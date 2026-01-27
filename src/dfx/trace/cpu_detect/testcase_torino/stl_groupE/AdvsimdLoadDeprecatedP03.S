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
    MOVZ  X2, #0x1e97, LSL #0
    MOVK  X2, #0x155f, LSL #16
    MOVK  X2, #0xdc62, LSL #32
    MOVK  X2, #0xe212, LSL #48
    MOVZ  X3, #0xab91, LSL #0
    MOVK  X3, #0x9438, LSL #16
    MOVK  X3, #0xcc50, LSL #32
    MOVK  X3, #0x4f39, LSL #48
    MOVZ  X4, #0x786f, LSL #0
    MOVK  X4, #0xe515, LSL #16
    MOVK  X4, #0x7f8f, LSL #32
    MOVK  X4, #0x93f2, LSL #48
    MOVZ  X5, #0x7439, LSL #0
    MOVK  X5, #0xa1cf, LSL #16
    MOVK  X5, #0x3584, LSL #32
    MOVK  X5, #0x5eb, LSL #48
    MOVZ  X6, #0x42e, LSL #0
    MOVK  X6, #0x700b, LSL #16
    MOVK  X6, #0x4cc2, LSL #32
    MOVK  X6, #0x59dc, LSL #48
    MOVZ  X7, #0xa937, LSL #0
    MOVK  X7, #0x2294, LSL #16
    MOVK  X7, #0x54b6, LSL #32
    MOVK  X7, #0xb62c, LSL #48
    MOVZ  X8, #0x3e5e, LSL #0
    MOVK  X8, #0x5640, LSL #16
    MOVK  X8, #0x1a2a, LSL #32
    MOVK  X8, #0x7338, LSL #48
    MOVZ  X9, #0xd9e3, LSL #0
    MOVK  X9, #0x663b, LSL #16
    MOVK  X9, #0xe0af, LSL #32
    MOVK  X9, #0x5347, LSL #48
    MOVZ  X10, #0x2477, LSL #0
    MOVK  X10, #0xa787, LSL #16
    MOVK  X10, #0x8090, LSL #32
    MOVK  X10, #0xfc2f, LSL #48
    MOVZ  X11, #0x2c37, LSL #0
    MOVK  X11, #0xdac0, LSL #16
    MOVK  X11, #0x7eea, LSL #32
    MOVK  X11, #0x8c93, LSL #48
    MOVZ  X12, #0x163f, LSL #0
    MOVK  X12, #0x8b0d, LSL #16
    MOVK  X12, #0x3a85, LSL #32
    MOVK  X12, #0xb628, LSL #48
    MOVZ  X13, #0xb24f, LSL #0
    MOVK  X13, #0xa77f, LSL #16
    MOVK  X13, #0xbe7f, LSL #32
    MOVK  X13, #0x1da6, LSL #48
    MOVZ  X14, #0x1a6a, LSL #0
    MOVK  X14, #0xf79d, LSL #16
    MOVK  X14, #0x54c1, LSL #32
    MOVK  X14, #0x4e0a, LSL #48
    MOVZ  X15, #0xeb68, LSL #0
    MOVK  X15, #0x905a, LSL #16
    MOVK  X15, #0xcd6d, LSL #32
    MOVK  X15, #0xfd7f, LSL #48
    MOVZ  X16, #0x74bb, LSL #0
    MOVK  X16, #0x54c, LSL #16
    MOVK  X16, #0xb07, LSL #32
    MOVK  X16, #0x1cb3, LSL #48
    MOVZ  X17, #0xf06e, LSL #0
    MOVK  X17, #0x6a42, LSL #16
    MOVK  X17, #0x6a6, LSL #32
    MOVK  X17, #0x1968, LSL #48
    MOVZ  X18, #0x6ef4, LSL #0
    MOVK  X18, #0x31c3, LSL #16
    MOVK  X18, #0xb096, LSL #32
    MOVK  X18, #0x4036, LSL #48
    MOVZ  X19, #0x996, LSL #0
    MOVK  X19, #0xfe5d, LSL #16
    MOVK  X19, #0x9641, LSL #32
    MOVK  X19, #0xc731, LSL #48
    MOVZ  X20, #0x4691, LSL #0
    MOVK  X20, #0x3fdf, LSL #16
    MOVK  X20, #0xf371, LSL #32
    MOVK  X20, #0x19d, LSL #48
    MOVZ  X21, #0x80df, LSL #0
    MOVK  X21, #0x4388, LSL #16
    MOVK  X21, #0x6e56, LSL #32
    MOVK  X21, #0x99c9, LSL #48
    MOVZ  X22, #0xcb18, LSL #0
    MOVK  X22, #0xec83, LSL #16
    MOVK  X22, #0xcf4f, LSL #32
    MOVK  X22, #0xe403, LSL #48
    MOVZ  X23, #0x9f4f, LSL #0
    MOVK  X23, #0x4b7a, LSL #16
    MOVK  X23, #0xba22, LSL #32
    MOVK  X23, #0x545c, LSL #48
    MOVZ  X26, #0xeaa7, LSL #0
    MOVK  X26, #0xa5f7, LSL #16
    MOVK  X26, #0xeb76, LSL #32
    MOVK  X26, #0xdbe5, LSL #48
    MOVZ  X6, #0xe2f3, LSL #0
    MOVK  X6, #0x1993, LSL #16
    MOVK  X6, #0xcb7a, LSL #32
    MOVK  X6, #0x864e, LSL #48
    MSR  FPCR, X6
    MRS  X4, FPCR
    MOVZ  X10, #0x60ff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    AND  X4, X4, X10
    MOVZ  X10, #0x0, LSL #0
    ORR  X4, X4, X10
    MSR  FPCR, X4
    ISB  SY
    MOVZ  X6, #0xc84a, LSL #0
    MOVK  X6, #0xdf97, LSL #16
    MOVK  X6, #0xebf6, LSL #32
    MOVK  X6, #0x4d7b, LSL #48
    MSR  FPSR, X6
    MRS  X14, FPSR
    MOVZ  X17, #0xff60, LSL #0
    MOVK  X17, #0x7ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X14, X14, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X14, X14, X17
    MSR  FPSR, X14
    ISB  SY
    SUBS  W26, W4, W4, UXTB #0
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X21
    FMOV  D1, X6
    FMOV  V1.D[1], X6
    FMOV  D2, X2
    FMOV  V2.D[1], X11
    FMOV  D3, X3
    FMOV  V3.D[1], X2
    FMOV  D4, X26
    FMOV  V4.D[1], X22
    FMOV  D5, X14
    FMOV  V5.D[1], X20
    FMOV  D6, X18
    FMOV  V6.D[1], X19
    FMOV  D7, X6
    FMOV  V7.D[1], X14
    FMOV  D8, X9
    FMOV  V8.D[1], X26
    FMOV  D9, X15
    FMOV  V9.D[1], X7
    FMOV  D10, X21
    FMOV  V10.D[1], X10
    FMOV  D11, X26
    FMOV  V11.D[1], X17
    FMOV  D12, X6
    FMOV  V12.D[1], X7
    FMOV  D13, X5
    FMOV  V13.D[1], X7
    FMOV  D14, X20
    FMOV  V14.D[1], X13
    FMOV  D15, X19
    FMOV  V15.D[1], X16
    FMOV  D16, X15
    FMOV  V16.D[1], X7
    FMOV  D17, X2
    FMOV  V17.D[1], X14
    FMOV  D18, X18
    FMOV  V18.D[1], X8
    FMOV  D19, X22
    FMOV  V19.D[1], X15
    FMOV  D20, X13
    FMOV  V20.D[1], X18
    FMOV  D21, X21
    FMOV  V21.D[1], X12
    FMOV  D22, X17
    FMOV  V22.D[1], X19
    FMOV  D23, X23
    FMOV  V23.D[1], X12
    FMOV  D24, X19
    FMOV  V24.D[1], X12
    FMOV  D25, X8
    FMOV  V25.D[1], X4
    FMOV  D26, X8
    FMOV  V26.D[1], X16
    FMOV  D27, X15
    FMOV  V27.D[1], X23
    FMOV  D28, X10
    FMOV  V28.D[1], X20
    FMOV  D29, X14
    FMOV  V29.D[1], X16
    FMOV  D30, X17
    FMOV  V30.D[1], X4
    FMOV  D31, X17
    FMOV  V31.D[1], X16
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X8, #0x0, LSL #0
    ADD  X4, X30, X8
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X4]
    LD3R { V15.16B, V16.16B, V17.16B }, [X4]
    ADD  X4, X4, X6, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X4]
    LD3R { V21.16B, V22.16B, V23.16B }, [X4]
    ADD  X4, X4, X6, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X4]
    LD3R { V19.2D, V20.2D, V21.2D }, [X4]
    ADD  X4, X4, X6, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X4]
    LD3R { V15.4S, V16.4S, V17.4S }, [X4]
    ADD  X4, X4, X6
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X4]
    LD3R { V19.8H, V20.8H, V21.8H }, [X4]
    ADD  X4, X4, X6
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X4]
    LD3R { V18.1D, V19.1D, V20.1D }, [X4]
    ADD  X4, X4, X6
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X4]
    LD3R { V1.1D, V2.1D, V3.1D }, [X4]
    ADD  X4, X4, X6
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X4]
    LD3R { V22.2S, V23.2S, V24.2S }, [X4]
    ADD  X4, X4, X6
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X4]
    LD3R { V18.4H, V19.4H, V20.4H }, [X4]
    ADD  X4, X4, X6
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X4]
    LD3R { V29.8B, V30.8B, V31.8B }, [X4]
    ADD  X4, X4, X6, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X4]
    MOV  X7, X4
    LD3R { V31.2S, V0.2S, V1.2S }, [X7], #12
    ADD  X4, X4, X6
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X4]
    MOV  X7, X4
    LD3R { V8.2S, V9.2S, V10.2S }, [X7], #12
    ADD  X4, X4, X6, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X4]
    MOV  X7, X4
    LD3R { V25.4S, V26.4S, V27.4S }, [X7], #12
    ADD  X4, X4, X6, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X4]
    MOV  X7, X4
    LD3R { V27.2D, V28.2D, V29.2D }, [X7], #24
    ADD  X4, X4, X6
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X4]
    MOV  X7, X4
    LD3R { V24.1D, V25.1D, V26.1D }, [X7], #24
    ADD  X4, X4, X6
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X4]
    MOV  X7, X4
    LD3R { V25.2D, V26.2D, V27.2D }, [X7], #24
    ADD  X4, X4, X6, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X4]
    MOV  X7, X4
    LD3R { V14.8B, V15.8B, V16.8B }, [X7], #3
    ADD  X4, X4, X6, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X4]
    MOV  X7, X4
    LD3R { V25.16B, V26.16B, V27.16B }, [X7], #3
    ADD  X4, X4, X6, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X4]
    MOV  X7, X4
    LD3R { V18.8B, V19.8B, V20.8B }, [X7], #3
    ADD  X4, X4, X6
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X4]
    MOV  X7, X4
    LD3R { V25.4H, V26.4H, V27.4H }, [X7], #6
    ADD  X4, X4, X6
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X4]
    MOV  X7, X4
    LD3R { V30.8H, V31.8H, V0.8H }, [X7], #6
    ADD  X4, X4, X6, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X4]
    MOV  X7, X4
    LD3R { V17.4H, V18.4H, V19.4H }, [X7], #6
    ADD  X4, X4, X6, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X4]
    LD3R { V11.4S, V12.4S, V13.4S }, [X4], X20
    ADD  X4, X4, X6, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X4]
    LD3R { V4.16B, V5.16B, V6.16B }, [X4], X20
    ADD  X4, X4, X6
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X4]
    LD3R { V28.2D, V29.2D, V30.2D }, [X4], X20
    ADD  X4, X4, X6, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X4]
    LD3R { V8.4S, V9.4S, V10.4S }, [X4], X20
    ADD  X4, X4, X6
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X4]
    LD3R { V24.8H, V25.8H, V26.8H }, [X4], X20
    ADD  X4, X4, X6, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X4]
    LD3R { V17.8B, V18.8B, V19.8B }, [X4], X20
    ADD  X4, X4, X6, ASR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X4]
    LD3R { V31.1D, V0.1D, V1.1D }, [X4], X20
    ADD  X4, X4, X6
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X4]
    LD3R { V10.2S, V11.2S, V12.2S }, [X4], X20
    ADD  X4, X4, X6
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X4]
    LD3R { V29.4H, V30.4H, V31.4H }, [X4], X20
    ADD  X4, X4, X6, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X4]
    LD3R { V7.8B, V8.8B, V9.8B }, [X4], X20
    ADD  X4, X4, X6, ASR #0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X2, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X5, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D1
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D2
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D3
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D4
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D5
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D6
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D7
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D8
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D9
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D10
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D11
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D12
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D13
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D14
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D15
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D16
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D17
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D18
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D19
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D20
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D21
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D22
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D23
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D24
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D25
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D26
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D27
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D28
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D29
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D30
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X5, D31
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X5
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X17
    FMOV  D1, X23
    FMOV  V1.D[1], X2
    FMOV  D2, X16
    FMOV  V2.D[1], X18
    FMOV  D3, X4
    FMOV  V3.D[1], X20
    FMOV  D4, X19
    FMOV  V4.D[1], X16
    FMOV  D5, X26
    FMOV  V5.D[1], X7
    FMOV  D6, X22
    FMOV  V6.D[1], X20
    FMOV  D7, X12
    FMOV  V7.D[1], X16
    FMOV  D8, X8
    FMOV  V8.D[1], X8
    FMOV  D9, X23
    FMOV  V9.D[1], X5
    FMOV  D10, X2
    FMOV  V10.D[1], X20
    FMOV  D11, X21
    FMOV  V11.D[1], X20
    FMOV  D12, X10
    FMOV  V12.D[1], X7
    FMOV  D13, X17
    FMOV  V13.D[1], X26
    FMOV  D14, X19
    FMOV  V14.D[1], X20
    FMOV  D15, X5
    FMOV  V15.D[1], X26
    FMOV  D16, X23
    FMOV  V16.D[1], X26
    FMOV  D17, X23
    FMOV  V17.D[1], X2
    FMOV  D18, X17
    FMOV  V18.D[1], X15
    FMOV  D19, X9
    FMOV  V19.D[1], X10
    FMOV  D20, X3
    FMOV  V20.D[1], X7
    FMOV  D21, X10
    FMOV  V21.D[1], X22
    FMOV  D22, X20
    FMOV  V22.D[1], X3
    FMOV  D23, X14
    FMOV  V23.D[1], X3
    FMOV  D24, X8
    FMOV  V24.D[1], X9
    FMOV  D25, X16
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X6
    FMOV  D27, X6
    FMOV  V27.D[1], X16
    FMOV  D28, X9
    FMOV  V28.D[1], X23
    FMOV  D29, X4
    FMOV  V29.D[1], X12
    FMOV  D30, X14
    FMOV  V30.D[1], X5
    FMOV  D31, X15
    FMOV  V31.D[1], X20
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X5, #0x500, LSL #0
    ADD  X12, X30, X5, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X12]
    LD3R { V26.8H, V27.8H, V28.8H }, [X12]
    ADD  X12, X12, X11, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X12]
    LD3R { V11.16B, V12.16B, V13.16B }, [X12]
    ADD  X12, X12, X11
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X12]
    LD3R { V22.2D, V23.2D, V24.2D }, [X12]
    ADD  X12, X12, X11, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X12]
    LD3R { V20.4S, V21.4S, V22.4S }, [X12]
    ADD  X12, X12, X11
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X12]
    LD3R { V23.8H, V24.8H, V25.8H }, [X12]
    ADD  X12, X12, X11
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X12]
    LD3R { V5.4H, V6.4H, V7.4H }, [X12]
    ADD  X12, X12, X11
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X12]
    LD3R { V5.1D, V6.1D, V7.1D }, [X12]
    ADD  X12, X12, X11, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X12]
    LD3R { V21.2S, V22.2S, V23.2S }, [X12]
    ADD  X12, X12, X11
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X12]
    LD3R { V15.4H, V16.4H, V17.4H }, [X12]
    ADD  X12, X12, X11, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X12]
    LD3R { V25.8B, V26.8B, V27.8B }, [X12]
    ADD  X12, X12, X11, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X12]
    MOV  X7, X12
    LD3R { V14.2S, V15.2S, V16.2S }, [X7], #12
    ADD  X12, X12, X11
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X12]
    MOV  X7, X12
    LD3R { V29.2S, V30.2S, V31.2S }, [X7], #12
    ADD  X12, X12, X11, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X12]
    MOV  X7, X12
    LD3R { V3.4S, V4.4S, V5.4S }, [X7], #12
    ADD  X12, X12, X11
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X12]
    MOV  X7, X12
    LD3R { V3.2D, V4.2D, V5.2D }, [X7], #24
    ADD  X12, X12, X11, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X12]
    MOV  X7, X12
    LD3R { V15.1D, V16.1D, V17.1D }, [X7], #24
    ADD  X12, X12, X11
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X12]
    MOV  X7, X12
    LD3R { V31.2D, V0.2D, V1.2D }, [X7], #24
    ADD  X12, X12, X11
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X12]
    MOV  X7, X12
    LD3R { V2.16B, V3.16B, V4.16B }, [X7], #3
    ADD  X12, X12, X11, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X12]
    MOV  X7, X12
    LD3R { V13.16B, V14.16B, V15.16B }, [X7], #3
    ADD  X12, X12, X11, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X12]
    MOV  X7, X12
    LD3R { V16.8B, V17.8B, V18.8B }, [X7], #3
    ADD  X12, X12, X11
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X12]
    MOV  X7, X12
    LD3R { V2.4H, V3.4H, V4.4H }, [X7], #6
    ADD  X12, X12, X11, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X12]
    MOV  X7, X12
    LD3R { V10.8H, V11.8H, V12.8H }, [X7], #6
    ADD  X12, X12, X11, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X12]
    MOV  X7, X12
    LD3R { V16.8H, V17.8H, V18.8H }, [X7], #6
    ADD  X12, X12, X11
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X12]
    LD3R { V9.8H, V10.8H, V11.8H }, [X12], X8
    ADD  X12, X12, X11, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X12]
    LD3R { V21.16B, V22.16B, V23.16B }, [X12], X8
    ADD  X12, X12, X11, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X12]
    LD3R { V6.2D, V7.2D, V8.2D }, [X12], X8
    ADD  X12, X12, X11, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X12]
    LD3R { V19.4S, V20.4S, V21.4S }, [X12], X8
    ADD  X12, X12, X11
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X12]
    LD3R { V16.8H, V17.8H, V18.8H }, [X12], X8
    ADD  X12, X12, X11, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X12]
    LD3R { V6.8B, V7.8B, V8.8B }, [X12], X8
    ADD  X12, X12, X11, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X12]
    LD3R { V21.1D, V22.1D, V23.1D }, [X12], X8
    ADD  X12, X12, X11
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X12]
    LD3R { V13.2S, V14.2S, V15.2S }, [X12], X8
    ADD  X12, X12, X11, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X12]
    LD3R { V14.4H, V15.4H, V16.4H }, [X12], X8
    ADD  X12, X12, X11, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X12]
    LD3R { V23.8B, V24.8B, V25.8B }, [X12], X8
    ADD  X12, X12, X11, LSR #0
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X26, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D1
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D2
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D3
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D4
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D5
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D6
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D7
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D8
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D9
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D10
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D11
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D12
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D13
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D14
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D15
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D16
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D17
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D18
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D19
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D20
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D21
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D22
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D23
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D24
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D25
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D26
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D27
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D28
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D29
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D30
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D31
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X23
    FMOV  D1, X14
    FMOV  V1.D[1], X26
    FMOV  D2, X21
    FMOV  V2.D[1], X5
    FMOV  D3, X17
    FMOV  V3.D[1], X6
    FMOV  D4, X15
    FMOV  V4.D[1], X6
    FMOV  D5, X20
    FMOV  V5.D[1], X7
    FMOV  D6, X5
    FMOV  V6.D[1], X16
    FMOV  D7, X3
    FMOV  V7.D[1], X26
    FMOV  D8, X14
    FMOV  V8.D[1], X7
    FMOV  D9, X12
    FMOV  V9.D[1], X10
    FMOV  D10, X21
    FMOV  V10.D[1], X15
    FMOV  D11, X11
    FMOV  V11.D[1], X4
    FMOV  D12, X17
    FMOV  V12.D[1], X17
    FMOV  D13, X10
    FMOV  V13.D[1], X16
    FMOV  D14, X11
    FMOV  V14.D[1], X17
    FMOV  D15, X12
    FMOV  V15.D[1], X22
    FMOV  D16, X12
    FMOV  V16.D[1], X17
    FMOV  D17, X22
    FMOV  V17.D[1], X3
    FMOV  D18, X16
    FMOV  V18.D[1], X6
    FMOV  D19, X22
    FMOV  V19.D[1], X3
    FMOV  D20, X20
    FMOV  V20.D[1], X15
    FMOV  D21, X23
    FMOV  V21.D[1], X4
    FMOV  D22, X7
    FMOV  V22.D[1], X12
    FMOV  D23, X18
    FMOV  V23.D[1], X26
    FMOV  D24, X26
    FMOV  V24.D[1], X10
    FMOV  D25, X15
    FMOV  V25.D[1], X9
    FMOV  D26, X20
    FMOV  V26.D[1], X9
    FMOV  D27, X20
    FMOV  V27.D[1], X2
    FMOV  D28, X22
    FMOV  V28.D[1], X7
    FMOV  D29, X8
    FMOV  V29.D[1], X20
    FMOV  D30, X19
    FMOV  V30.D[1], X21
    FMOV  D31, X26
    FMOV  V31.D[1], X15
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X6, #0xa00, LSL #0
    ADD  X22, X30, X6, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X22]
    LD3R { V15.4S, V16.4S, V17.4S }, [X22]
    ADD  X22, X22, X2, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X22]
    LD3R { V9.16B, V10.16B, V11.16B }, [X22]
    ADD  X22, X22, X2
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X22]
    LD3R { V21.2D, V22.2D, V23.2D }, [X22]
    ADD  X22, X22, X2
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X22]
    LD3R { V7.4S, V8.4S, V9.4S }, [X22]
    ADD  X22, X22, X2
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X22]
    LD3R { V18.8H, V19.8H, V20.8H }, [X22]
    ADD  X22, X22, X2, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X22]
    LD3R { V14.8B, V15.8B, V16.8B }, [X22]
    ADD  X22, X22, X2, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X22]
    LD3R { V12.1D, V13.1D, V14.1D }, [X22]
    ADD  X22, X22, X2, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X22]
    LD3R { V5.2S, V6.2S, V7.2S }, [X22]
    ADD  X22, X22, X2, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X22]
    LD3R { V9.4H, V10.4H, V11.4H }, [X22]
    ADD  X22, X22, X2, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22]
    LD3R { V6.8B, V7.8B, V8.8B }, [X22]
    ADD  X22, X22, X2, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X22]
    MOV  X9, X22
    LD3R { V27.4S, V28.4S, V29.4S }, [X9], #12
    ADD  X22, X22, X2
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X22]
    MOV  X9, X22
    LD3R { V15.2S, V16.2S, V17.2S }, [X9], #12
    ADD  X22, X22, X2, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X22]
    MOV  X9, X22
    LD3R { V3.4S, V4.4S, V5.4S }, [X9], #12
    ADD  X22, X22, X2
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X22]
    MOV  X9, X22
    LD3R { V31.1D, V0.1D, V1.1D }, [X9], #24
    ADD  X22, X22, X2, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X22]
    MOV  X9, X22
    LD3R { V30.1D, V31.1D, V0.1D }, [X9], #24
    ADD  X22, X22, X2
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X22]
    MOV  X9, X22
    LD3R { V13.2D, V14.2D, V15.2D }, [X9], #24
    ADD  X22, X22, X2, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X22]
    MOV  X9, X22
    LD3R { V28.8B, V29.8B, V30.8B }, [X9], #3
    ADD  X22, X22, X2
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X22]
    MOV  X9, X22
    LD3R { V28.16B, V29.16B, V30.16B }, [X9], #3
    ADD  X22, X22, X2, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X22]
    MOV  X9, X22
    LD3R { V14.8B, V15.8B, V16.8B }, [X9], #3
    ADD  X22, X22, X2, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X22]
    MOV  X9, X22
    LD3R { V0.4H, V1.4H, V2.4H }, [X9], #6
    ADD  X22, X22, X2
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22]
    MOV  X9, X22
    LD3R { V19.8H, V20.8H, V21.8H }, [X9], #6
    ADD  X22, X22, X2, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X22]
    MOV  X9, X22
    LD3R { V26.4H, V27.4H, V28.4H }, [X9], #6
    ADD  X22, X22, X2, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X22]
    LD3R { V12.2D, V13.2D, V14.2D }, [X22], X20
    ADD  X22, X22, X2
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X22]
    LD3R { V26.16B, V27.16B, V28.16B }, [X22], X20
    ADD  X22, X22, X2, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X22]
    LD3R { V18.2D, V19.2D, V20.2D }, [X22], X20
    ADD  X22, X22, X2
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X22]
    LD3R { V11.4S, V12.4S, V13.4S }, [X22], X20
    ADD  X22, X22, X2, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X22]
    LD3R { V30.8H, V31.8H, V0.8H }, [X22], X20
    ADD  X22, X22, X2, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X22]
    LD3R { V9.8B, V10.8B, V11.8B }, [X22], X20
    ADD  X22, X22, X2, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X22]
    LD3R { V21.1D, V22.1D, V23.1D }, [X22], X20
    ADD  X22, X22, X2
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X22]
    LD3R { V4.2S, V5.2S, V6.2S }, [X22], X20
    ADD  X22, X22, X2
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X22]
    LD3R { V25.4H, V26.4H, V27.4H }, [X22], X20
    ADD  X22, X22, X2, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X22]
    LD3R { V5.8B, V6.8B, V7.8B }, [X22], X20
    ADD  X22, X22, X2, LSR #0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X16, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D5
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D10
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D11
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D15
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D16
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D19
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D20
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D23
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D26
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D28
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D29
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X16, D31
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X18, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X9
    FMOV  D1, X18
    FMOV  V1.D[1], X22
    FMOV  D2, X26
    FMOV  V2.D[1], X9
    FMOV  D3, X23
    FMOV  V3.D[1], X7
    FMOV  D4, X10
    FMOV  V4.D[1], X3
    FMOV  D5, X23
    FMOV  V5.D[1], X16
    FMOV  D6, X23
    FMOV  V6.D[1], X3
    FMOV  D7, X19
    FMOV  V7.D[1], X12
    FMOV  D8, X2
    FMOV  V8.D[1], X19
    FMOV  D9, X15
    FMOV  V9.D[1], X11
    FMOV  D10, X17
    FMOV  V10.D[1], X15
    FMOV  D11, X21
    FMOV  V11.D[1], X14
    FMOV  D12, X14
    FMOV  V12.D[1], X23
    FMOV  D13, X22
    FMOV  V13.D[1], X18
    FMOV  D14, X8
    FMOV  V14.D[1], X19
    FMOV  D15, X3
    FMOV  V15.D[1], X26
    FMOV  D16, X7
    FMOV  V16.D[1], X21
    FMOV  D17, X21
    FMOV  V17.D[1], X6
    FMOV  D18, X17
    FMOV  V18.D[1], X26
    FMOV  D19, X12
    FMOV  V19.D[1], X10
    FMOV  D20, X19
    FMOV  V20.D[1], X8
    FMOV  D21, X19
    FMOV  V21.D[1], X17
    FMOV  D22, X9
    FMOV  V22.D[1], X2
    FMOV  D23, X10
    FMOV  V23.D[1], X22
    FMOV  D24, X7
    FMOV  V24.D[1], X4
    FMOV  D25, X23
    FMOV  V25.D[1], X4
    FMOV  D26, X11
    FMOV  V26.D[1], X5
    FMOV  D27, X2
    FMOV  V27.D[1], X16
    FMOV  D28, X19
    FMOV  V28.D[1], X4
    FMOV  D29, X17
    FMOV  V29.D[1], X6
    FMOV  D30, X26
    FMOV  V30.D[1], X21
    FMOV  D31, X18
    FMOV  V31.D[1], X23
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X18, #0xf00, LSL #0
    ADD  X5, X30, X18
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X5]
    LD3R { V21.4S, V22.4S, V23.4S }, [X5]
    ADD  X5, X5, X3, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X5]
    LD3R { V28.16B, V29.16B, V30.16B }, [X5]
    ADD  X5, X5, X3, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X5]
    LD3R { V7.2D, V8.2D, V9.2D }, [X5]
    ADD  X5, X5, X3, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X5]
    LD3R { V9.4S, V10.4S, V11.4S }, [X5]
    ADD  X5, X5, X3
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X5]
    LD3R { V22.8H, V23.8H, V24.8H }, [X5]
    ADD  X5, X5, X3
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X5]
    LD3R { V1.8B, V2.8B, V3.8B }, [X5]
    ADD  X5, X5, X3, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X5]
    LD3R { V4.1D, V5.1D, V6.1D }, [X5]
    ADD  X5, X5, X3, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X5]
    LD3R { V18.2S, V19.2S, V20.2S }, [X5]
    ADD  X5, X5, X3, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X5]
    LD3R { V28.4H, V29.4H, V30.4H }, [X5]
    ADD  X5, X5, X3
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X5]
    LD3R { V3.8B, V4.8B, V5.8B }, [X5]
    ADD  X5, X5, X3, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X5]
    MOV  X7, X5
    LD3R { V18.4S, V19.4S, V20.4S }, [X7], #12
    ADD  X5, X5, X3, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X5]
    MOV  X7, X5
    LD3R { V31.2S, V0.2S, V1.2S }, [X7], #12
    ADD  X5, X5, X3, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X5]
    MOV  X7, X5
    LD3R { V2.4S, V3.4S, V4.4S }, [X7], #12
    ADD  X5, X5, X3, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X5]
    MOV  X7, X5
    LD3R { V7.2D, V8.2D, V9.2D }, [X7], #24
    ADD  X5, X5, X3, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X5]
    MOV  X7, X5
    LD3R { V28.1D, V29.1D, V30.1D }, [X7], #24
    ADD  X5, X5, X3, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X5]
    MOV  X7, X5
    LD3R { V28.2D, V29.2D, V30.2D }, [X7], #24
    ADD  X5, X5, X3, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X5]
    MOV  X7, X5
    LD3R { V29.8B, V30.8B, V31.8B }, [X7], #3
    ADD  X5, X5, X3, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X5]
    MOV  X7, X5
    LD3R { V13.16B, V14.16B, V15.16B }, [X7], #3
    ADD  X5, X5, X3, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X5]
    MOV  X7, X5
    LD3R { V2.8B, V3.8B, V4.8B }, [X7], #3
    ADD  X5, X5, X3
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X5]
    MOV  X7, X5
    LD3R { V19.4H, V20.4H, V21.4H }, [X7], #6
    ADD  X5, X5, X3
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X5]
    MOV  X7, X5
    LD3R { V0.8H, V1.8H, V2.8H }, [X7], #6
    ADD  X5, X5, X3, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X5]
    MOV  X7, X5
    LD3R { V8.8H, V9.8H, V10.8H }, [X7], #6
    ADD  X5, X5, X3, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X5]
    LD3R { V9.2D, V10.2D, V11.2D }, [X5], X22
    ADD  X5, X5, X3
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X5]
    LD3R { V4.16B, V5.16B, V6.16B }, [X5], X22
    ADD  X5, X5, X3, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X5]
    LD3R { V5.2D, V6.2D, V7.2D }, [X5], X22
    ADD  X5, X5, X3, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X5]
    LD3R { V13.4S, V14.4S, V15.4S }, [X5], X22
    ADD  X5, X5, X3
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X5]
    LD3R { V11.8H, V12.8H, V13.8H }, [X5], X22
    ADD  X5, X5, X3, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X5]
    LD3R { V6.8B, V7.8B, V8.8B }, [X5], X22
    ADD  X5, X5, X3, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X5]
    LD3R { V9.1D, V10.1D, V11.1D }, [X5], X22
    ADD  X5, X5, X3, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X5]
    LD3R { V18.2S, V19.2S, V20.2S }, [X5], X22
    ADD  X5, X5, X3, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X5]
    LD3R { V3.4H, V4.4H, V5.4H }, [X5], X22
    ADD  X5, X5, X3, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X5]
    LD3R { V0.8B, V1.8B, V2.8B }, [X5], X22
    ADD  X5, X5, X3, ASR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X2, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X8, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D0
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D1
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D2
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D3
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D4
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D5
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D6
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D7
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D8
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D9
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D10
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D11
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D12
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D13
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D14
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D15
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D16
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D17
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D18
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D19
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D20
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D21
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D22
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D23
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D24
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D25
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D26
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D27
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D28
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D29
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D30
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D31
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X5
    FMOV  D1, X20
    FMOV  V1.D[1], X18
    FMOV  D2, X23
    FMOV  V2.D[1], X22
    FMOV  D3, X21
    FMOV  V3.D[1], X20
    FMOV  D4, X6
    FMOV  V4.D[1], X16
    FMOV  D5, X26
    FMOV  V5.D[1], X9
    FMOV  D6, X9
    FMOV  V6.D[1], X5
    FMOV  D7, X13
    FMOV  V7.D[1], X19
    FMOV  D8, X5
    FMOV  V8.D[1], X16
    FMOV  D9, X5
    FMOV  V9.D[1], X13
    FMOV  D10, X19
    FMOV  V10.D[1], X6
    FMOV  D11, X2
    FMOV  V11.D[1], X9
    FMOV  D12, X6
    FMOV  V12.D[1], X17
    FMOV  D13, X3
    FMOV  V13.D[1], X17
    FMOV  D14, X10
    FMOV  V14.D[1], X6
    FMOV  D15, X22
    FMOV  V15.D[1], X18
    FMOV  D16, X26
    FMOV  V16.D[1], X12
    FMOV  D17, X16
    FMOV  V17.D[1], X16
    FMOV  D18, X14
    FMOV  V18.D[1], X22
    FMOV  D19, X5
    FMOV  V19.D[1], X9
    FMOV  D20, X5
    FMOV  V20.D[1], X3
    FMOV  D21, X5
    FMOV  V21.D[1], X15
    FMOV  D22, X22
    FMOV  V22.D[1], X9
    FMOV  D23, X5
    FMOV  V23.D[1], X14
    FMOV  D24, X12
    FMOV  V24.D[1], X23
    FMOV  D25, X17
    FMOV  V25.D[1], X21
    FMOV  D26, X18
    FMOV  V26.D[1], X17
    FMOV  D27, X7
    FMOV  V27.D[1], X26
    FMOV  D28, X21
    FMOV  V28.D[1], X3
    FMOV  D29, X4
    FMOV  V29.D[1], X17
    FMOV  D30, X5
    FMOV  V30.D[1], X3
    FMOV  D31, X5
    FMOV  V31.D[1], X6
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X23, #0x1400, LSL #0
    ADD  X9, X30, X23, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X9]
    LD3R { V22.8H, V23.8H, V24.8H }, [X9]
    ADD  X9, X9, X14, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X9]
    LD3R { V19.16B, V20.16B, V21.16B }, [X9]
    ADD  X9, X9, X14, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X9]
    LD3R { V29.2D, V30.2D, V31.2D }, [X9]
    ADD  X9, X9, X14
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X9]
    LD3R { V4.4S, V5.4S, V6.4S }, [X9]
    ADD  X9, X9, X14
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X9]
    LD3R { V3.8H, V4.8H, V5.8H }, [X9]
    ADD  X9, X9, X14, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X9]
    LD3R { V25.1D, V26.1D, V27.1D }, [X9]
    ADD  X9, X9, X14
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X9]
    LD3R { V16.1D, V17.1D, V18.1D }, [X9]
    ADD  X9, X9, X14, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X9]
    LD3R { V26.2S, V27.2S, V28.2S }, [X9]
    ADD  X9, X9, X14, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X9]
    LD3R { V31.4H, V0.4H, V1.4H }, [X9]
    ADD  X9, X9, X14, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X9]
    LD3R { V20.8B, V21.8B, V22.8B }, [X9]
    ADD  X9, X9, X14, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X9]
    MOV  X17, X9
    LD3R { V20.2S, V21.2S, V22.2S }, [X17], #12
    ADD  X9, X9, X14, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X9]
    MOV  X17, X9
    LD3R { V31.2S, V0.2S, V1.2S }, [X17], #12
    ADD  X9, X9, X14
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X9]
    MOV  X17, X9
    LD3R { V4.4S, V5.4S, V6.4S }, [X17], #12
    ADD  X9, X9, X14, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X9]
    MOV  X17, X9
    LD3R { V20.1D, V21.1D, V22.1D }, [X17], #24
    ADD  X9, X9, X14, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X9]
    MOV  X17, X9
    LD3R { V8.1D, V9.1D, V10.1D }, [X17], #24
    ADD  X9, X9, X14, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X9]
    MOV  X17, X9
    LD3R { V29.2D, V30.2D, V31.2D }, [X17], #24
    ADD  X9, X9, X14, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X9]
    MOV  X17, X9
    LD3R { V31.16B, V0.16B, V1.16B }, [X17], #3
    ADD  X9, X9, X14
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X9]
    MOV  X17, X9
    LD3R { V11.16B, V12.16B, V13.16B }, [X17], #3
    ADD  X9, X9, X14
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X9]
    MOV  X17, X9
    LD3R { V26.8B, V27.8B, V28.8B }, [X17], #3
    ADD  X9, X9, X14, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X9]
    MOV  X17, X9
    LD3R { V10.4H, V11.4H, V12.4H }, [X17], #6
    ADD  X9, X9, X14, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X9]
    MOV  X17, X9
    LD3R { V27.8H, V28.8H, V29.8H }, [X17], #6
    ADD  X9, X9, X14, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X9]
    MOV  X17, X9
    LD3R { V1.8H, V2.8H, V3.8H }, [X17], #6
    ADD  X9, X9, X14
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X9]
    LD3R { V21.16B, V22.16B, V23.16B }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X9]
    LD3R { V0.16B, V1.16B, V2.16B }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X9]
    LD3R { V10.2D, V11.2D, V12.2D }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X9]
    LD3R { V15.4S, V16.4S, V17.4S }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X9]
    LD3R { V15.8H, V16.8H, V17.8H }, [X9], X3
    ADD  X9, X9, X14, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X9]
    LD3R { V27.1D, V28.1D, V29.1D }, [X9], X3
    ADD  X9, X9, X14
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X9]
    LD3R { V29.1D, V30.1D, V31.1D }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X9]
    LD3R { V14.2S, V15.2S, V16.2S }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X9]
    LD3R { V20.4H, V21.4H, V22.4H }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X9]
    LD3R { V28.8B, V29.8B, V30.8B }, [X9], X3
    ADD  X9, X9, X14, ASR #0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X26, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D1
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D2
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D5
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D6
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D7
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D8
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D9
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D10
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D11
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D12
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D14
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D15
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D16
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D17
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D18
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D19
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D20
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D22
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D23
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D24
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D25
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D26
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D27
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D29
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D30
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D31
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X19
    FMOV  D2, X9
    FMOV  V2.D[1], X21
    FMOV  D3, X20
    FMOV  V3.D[1], X11
    FMOV  D4, X21
    FMOV  V4.D[1], X9
    FMOV  D5, X14
    FMOV  V5.D[1], X18
    FMOV  D6, X20
    FMOV  V6.D[1], X4
    FMOV  D7, X20
    FMOV  V7.D[1], X11
    FMOV  D8, X9
    FMOV  V8.D[1], X9
    FMOV  D9, X23
    FMOV  V9.D[1], X10
    FMOV  D10, X5
    FMOV  V10.D[1], X22
    FMOV  D11, X19
    FMOV  V11.D[1], X22
    FMOV  D12, X16
    FMOV  V12.D[1], X23
    FMOV  D13, X10
    FMOV  V13.D[1], X15
    FMOV  D14, X16
    FMOV  V14.D[1], X12
    FMOV  D15, X7
    FMOV  V15.D[1], X23
    FMOV  D16, X2
    FMOV  V16.D[1], X19
    FMOV  D17, X11
    FMOV  V17.D[1], X9
    FMOV  D18, X5
    FMOV  V18.D[1], X13
    FMOV  D19, X22
    FMOV  V19.D[1], X22
    FMOV  D20, X5
    FMOV  V20.D[1], X14
    FMOV  D21, X9
    FMOV  V21.D[1], X10
    FMOV  D22, X12
    FMOV  V22.D[1], X13
    FMOV  D23, X5
    FMOV  V23.D[1], X15
    FMOV  D24, X7
    FMOV  V24.D[1], X23
    FMOV  D25, X10
    FMOV  V25.D[1], X10
    FMOV  D26, X16
    FMOV  V26.D[1], X17
    FMOV  D27, X16
    FMOV  V27.D[1], X19
    FMOV  D28, X13
    FMOV  V28.D[1], X18
    FMOV  D29, X8
    FMOV  V29.D[1], X8
    FMOV  D30, X22
    FMOV  V30.D[1], X20
    FMOV  D31, X9
    FMOV  V31.D[1], X10
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X22, #0x1900, LSL #0
    ADD  X2, X30, X22
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X2]
    LD3R { V27.4S, V28.4S, V29.4S }, [X2]
    ADD  X2, X2, X16
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X2]
    LD3R { V9.16B, V10.16B, V11.16B }, [X2]
    ADD  X2, X2, X16
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X2]
    LD3R { V30.2D, V31.2D, V0.2D }, [X2]
    ADD  X2, X2, X16, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X2]
    LD3R { V8.4S, V9.4S, V10.4S }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X2]
    LD3R { V17.8H, V18.8H, V19.8H }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X2]
    LD3R { V8.4H, V9.4H, V10.4H }, [X2]
    ADD  X2, X2, X16
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X2]
    LD3R { V29.1D, V30.1D, V31.1D }, [X2]
    ADD  X2, X2, X16
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X2]
    LD3R { V15.2S, V16.2S, V17.2S }, [X2]
    ADD  X2, X2, X16
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X2]
    LD3R { V21.4H, V22.4H, V23.4H }, [X2]
    ADD  X2, X2, X16, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X2]
    LD3R { V31.8B, V0.8B, V1.8B }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X2]
    MOV  X20, X2
    LD3R { V26.2S, V27.2S, V28.2S }, [X20], #12
    ADD  X2, X2, X16, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X2]
    MOV  X20, X2
    LD3R { V30.2S, V31.2S, V0.2S }, [X20], #12
    ADD  X2, X2, X16, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X2]
    MOV  X20, X2
    LD3R { V24.4S, V25.4S, V26.4S }, [X20], #12
    ADD  X2, X2, X16
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X2]
    MOV  X20, X2
    LD3R { V31.2D, V0.2D, V1.2D }, [X20], #24
    ADD  X2, X2, X16
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X2]
    MOV  X20, X2
    LD3R { V3.1D, V4.1D, V5.1D }, [X20], #24
    ADD  X2, X2, X16, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2]
    MOV  X20, X2
    LD3R { V5.2D, V6.2D, V7.2D }, [X20], #24
    ADD  X2, X2, X16, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X2]
    MOV  X20, X2
    LD3R { V7.16B, V8.16B, V9.16B }, [X20], #3
    ADD  X2, X2, X16, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X2]
    MOV  X20, X2
    LD3R { V4.16B, V5.16B, V6.16B }, [X20], #3
    ADD  X2, X2, X16
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X2]
    MOV  X20, X2
    LD3R { V23.8B, V24.8B, V25.8B }, [X20], #3
    ADD  X2, X2, X16, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X2]
    MOV  X20, X2
    LD3R { V31.4H, V0.4H, V1.4H }, [X20], #6
    ADD  X2, X2, X16, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X2]
    MOV  X20, X2
    LD3R { V6.8H, V7.8H, V8.8H }, [X20], #6
    ADD  X2, X2, X16, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X2]
    MOV  X20, X2
    LD3R { V8.8H, V9.8H, V10.8H }, [X20], #6
    ADD  X2, X2, X16, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X2]
    LD3R { V25.16B, V26.16B, V27.16B }, [X2], X5
    ADD  X2, X2, X16
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X2]
    LD3R { V9.16B, V10.16B, V11.16B }, [X2], X5
    ADD  X2, X2, X16, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X2]
    LD3R { V14.2D, V15.2D, V16.2D }, [X2], X5
    ADD  X2, X2, X16
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X2]
    LD3R { V0.4S, V1.4S, V2.4S }, [X2], X5
    ADD  X2, X2, X16, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X2]
    LD3R { V2.8H, V3.8H, V4.8H }, [X2], X5
    ADD  X2, X2, X16, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X2]
    LD3R { V27.2S, V28.2S, V29.2S }, [X2], X5
    ADD  X2, X2, X16, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X2]
    LD3R { V25.1D, V26.1D, V27.1D }, [X2], X5
    ADD  X2, X2, X16, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X2]
    LD3R { V25.2S, V26.2S, V27.2S }, [X2], X5
    ADD  X2, X2, X16, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X2]
    LD3R { V2.4H, V3.4H, V4.4H }, [X2], X5
    ADD  X2, X2, X16
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X2]
    LD3R { V1.8B, V2.8B, V3.8B }, [X2], X5
    ADD  X2, X2, X16, ASR #0
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X13, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X26, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D1
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D2
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D3
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D4
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D5
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D6
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D7
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D8
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D9
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D10
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D11
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D12
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D13
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D14
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D15
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D16
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D17
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D18
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D19
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D20
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D21
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D22
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D23
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D24
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D25
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D26
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D27
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D28
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D29
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D30
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X26, D31
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X7
    FMOV  D1, X4
    FMOV  V1.D[1], X22
    FMOV  D2, X23
    FMOV  V2.D[1], X19
    FMOV  D3, X14
    FMOV  V3.D[1], X20
    FMOV  D4, X18
    FMOV  V4.D[1], X14
    FMOV  D5, X21
    FMOV  V5.D[1], X4
    FMOV  D6, X20
    FMOV  V6.D[1], X6
    FMOV  D7, X8
    FMOV  V7.D[1], X16
    FMOV  D8, X16
    FMOV  V8.D[1], X22
    FMOV  D9, X21
    FMOV  V9.D[1], X10
    FMOV  D10, X3
    FMOV  V10.D[1], X26
    FMOV  D11, X5
    FMOV  V11.D[1], X14
    FMOV  D12, X6
    FMOV  V12.D[1], X5
    FMOV  D13, X10
    FMOV  V13.D[1], X23
    FMOV  D14, X21
    FMOV  V14.D[1], X12
    FMOV  D15, X20
    FMOV  V15.D[1], X4
    FMOV  D16, X8
    FMOV  V16.D[1], X19
    FMOV  D17, X23
    FMOV  V17.D[1], X10
    FMOV  D18, X4
    FMOV  V18.D[1], X21
    FMOV  D19, X4
    FMOV  V19.D[1], X5
    FMOV  D20, X22
    FMOV  V20.D[1], X3
    FMOV  D21, X17
    FMOV  V21.D[1], X17
    FMOV  D22, X14
    FMOV  V22.D[1], X13
    FMOV  D23, X16
    FMOV  V23.D[1], X13
    FMOV  D24, X9
    FMOV  V24.D[1], X9
    FMOV  D25, X8
    FMOV  V25.D[1], X11
    FMOV  D26, X14
    FMOV  V26.D[1], X16
    FMOV  D27, X11
    FMOV  V27.D[1], X2
    FMOV  D28, X11
    FMOV  V28.D[1], X22
    FMOV  D29, X19
    FMOV  V29.D[1], X26
    FMOV  D30, X23
    FMOV  V30.D[1], X21
    FMOV  D31, X17
    FMOV  V31.D[1], X23
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X15, #0x1e00, LSL #0
    ADD  X8, X30, X15
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X8]
    LD3R { V15.4S, V16.4S, V17.4S }, [X8]
    ADD  X8, X8, X12
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X8]
    LD3R { V27.16B, V28.16B, V29.16B }, [X8]
    ADD  X8, X8, X12, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X8]
    LD3R { V25.2D, V26.2D, V27.2D }, [X8]
    ADD  X8, X8, X12
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X8]
    LD3R { V14.4S, V15.4S, V16.4S }, [X8]
    ADD  X8, X8, X12, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X8]
    LD3R { V22.8H, V23.8H, V24.8H }, [X8]
    ADD  X8, X8, X12, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X8]
    LD3R { V6.2S, V7.2S, V8.2S }, [X8]
    ADD  X8, X8, X12, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X8]
    LD3R { V9.1D, V10.1D, V11.1D }, [X8]
    ADD  X8, X8, X12
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X8]
    LD3R { V8.2S, V9.2S, V10.2S }, [X8]
    ADD  X8, X8, X12, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X8]
    LD3R { V25.4H, V26.4H, V27.4H }, [X8]
    ADD  X8, X8, X12, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X8]
    LD3R { V29.8B, V30.8B, V31.8B }, [X8]
    ADD  X8, X8, X12, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X8]
    MOV  X13, X8
    LD3R { V0.2S, V1.2S, V2.2S }, [X13], #12
    ADD  X8, X8, X12, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X8]
    MOV  X13, X8
    LD3R { V15.2S, V16.2S, V17.2S }, [X13], #12
    ADD  X8, X8, X12, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X8]
    MOV  X13, X8
    LD3R { V14.4S, V15.4S, V16.4S }, [X13], #12
    ADD  X8, X8, X12, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X8]
    MOV  X13, X8
    LD3R { V7.2D, V8.2D, V9.2D }, [X13], #24
    ADD  X8, X8, X12, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X8]
    MOV  X13, X8
    LD3R { V10.1D, V11.1D, V12.1D }, [X13], #24
    ADD  X8, X8, X12, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X8]
    MOV  X13, X8
    LD3R { V19.2D, V20.2D, V21.2D }, [X13], #24
    ADD  X8, X8, X12, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X8]
    MOV  X13, X8
    LD3R { V1.16B, V2.16B, V3.16B }, [X13], #3
    ADD  X8, X8, X12
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X8]
    MOV  X13, X8
    LD3R { V0.16B, V1.16B, V2.16B }, [X13], #3
    ADD  X8, X8, X12
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X8]
    MOV  X13, X8
    LD3R { V23.8B, V24.8B, V25.8B }, [X13], #3
    ADD  X8, X8, X12, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X8]
    MOV  X13, X8
    LD3R { V20.4H, V21.4H, V22.4H }, [X13], #6
    ADD  X8, X8, X12, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X8]
    MOV  X13, X8
    LD3R { V27.8H, V28.8H, V29.8H }, [X13], #6
    ADD  X8, X8, X12, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X8]
    MOV  X13, X8
    LD3R { V8.8H, V9.8H, V10.8H }, [X13], #6
    ADD  X8, X8, X12, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X8]
    LD3R { V21.4S, V22.4S, V23.4S }, [X8], X4
    ADD  X8, X8, X12
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X8]
    LD3R { V19.16B, V20.16B, V21.16B }, [X8], X4
    ADD  X8, X8, X12, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X8]
    LD3R { V24.2D, V25.2D, V26.2D }, [X8], X4
    ADD  X8, X8, X12
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X8]
    LD3R { V19.4S, V20.4S, V21.4S }, [X8], X4
    ADD  X8, X8, X12, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X8]
    LD3R { V31.8H, V0.8H, V1.8H }, [X8], X4
    ADD  X8, X8, X12, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X8]
    LD3R { V11.4H, V12.4H, V13.4H }, [X8], X4
    ADD  X8, X8, X12, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X8]
    LD3R { V17.1D, V18.1D, V19.1D }, [X8], X4
    ADD  X8, X8, X12, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X8]
    LD3R { V21.2S, V22.2S, V23.2S }, [X8], X4
    ADD  X8, X8, X12, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X8]
    LD3R { V10.4H, V11.4H, V12.4H }, [X8], X4
    ADD  X8, X8, X12
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X8]
    LD3R { V16.8B, V17.8B, V18.8B }, [X8], X4
    ADD  X8, X8, X12
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X11, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X7, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D0
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D1
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D2
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D3
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D4
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D5
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D6
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D7
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D8
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D9
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D10
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D11
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D12
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D13
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D14
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D15
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D16
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D17
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D18
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D19
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D20
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D21
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D22
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D23
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D24
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D25
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D26
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D27
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D28
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D29
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D30
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D31
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X23, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X19
    FMOV  V0.D[1], X22
    FMOV  D1, X10
    FMOV  V1.D[1], X23
    FMOV  D2, X21
    FMOV  V2.D[1], X26
    FMOV  D3, X10
    FMOV  V3.D[1], X20
    FMOV  D4, X4
    FMOV  V4.D[1], X10
    FMOV  D5, X14
    FMOV  V5.D[1], X6
    FMOV  D6, X14
    FMOV  V6.D[1], X14
    FMOV  D7, X5
    FMOV  V7.D[1], X20
    FMOV  D8, X17
    FMOV  V8.D[1], X19
    FMOV  D9, X7
    FMOV  V9.D[1], X8
    FMOV  D10, X6
    FMOV  V10.D[1], X15
    FMOV  D11, X9
    FMOV  V11.D[1], X18
    FMOV  D12, X11
    FMOV  V12.D[1], X14
    FMOV  D13, X11
    FMOV  V13.D[1], X5
    FMOV  D14, X21
    FMOV  V14.D[1], X17
    FMOV  D15, X17
    FMOV  V15.D[1], X21
    FMOV  D16, X4
    FMOV  V16.D[1], X23
    FMOV  D17, X7
    FMOV  V17.D[1], X16
    FMOV  D18, X6
    FMOV  V18.D[1], X9
    FMOV  D19, X13
    FMOV  V19.D[1], X15
    FMOV  D20, X2
    FMOV  V20.D[1], X22
    FMOV  D21, X2
    FMOV  V21.D[1], X10
    FMOV  D22, X8
    FMOV  V22.D[1], X15
    FMOV  D23, X20
    FMOV  V23.D[1], X19
    FMOV  D24, X10
    FMOV  V24.D[1], X12
    FMOV  D25, X14
    FMOV  V25.D[1], X23
    FMOV  D26, X17
    FMOV  V26.D[1], X13
    FMOV  D27, X11
    FMOV  V27.D[1], X11
    FMOV  D28, X17
    FMOV  V28.D[1], X2
    FMOV  D29, X6
    FMOV  V29.D[1], X10
    FMOV  D30, X4
    FMOV  V30.D[1], X10
    FMOV  D31, X18
    FMOV  V31.D[1], X16
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X19, #0x2300, LSL #0
    ADD  X4, X30, X19, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X4]
    LD3R { V12.2D, V13.2D, V14.2D }, [X4]
    ADD  X4, X4, X7
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X4]
    LD3R { V10.16B, V11.16B, V12.16B }, [X4]
    ADD  X4, X4, X7, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X4]
    LD3R { V10.2D, V11.2D, V12.2D }, [X4]
    ADD  X4, X4, X7
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X4]
    LD3R { V0.4S, V1.4S, V2.4S }, [X4]
    ADD  X4, X4, X7
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X4]
    LD3R { V20.8H, V21.8H, V22.8H }, [X4]
    ADD  X4, X4, X7, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X4]
    LD3R { V5.4H, V6.4H, V7.4H }, [X4]
    ADD  X4, X4, X7, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X4]
    LD3R { V28.1D, V29.1D, V30.1D }, [X4]
    ADD  X4, X4, X7
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X4]
    LD3R { V31.2S, V0.2S, V1.2S }, [X4]
    ADD  X4, X4, X7, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X4]
    LD3R { V13.4H, V14.4H, V15.4H }, [X4]
    ADD  X4, X4, X7, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X4]
    LD3R { V7.8B, V8.8B, V9.8B }, [X4]
    ADD  X4, X4, X7
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X4]
    MOV  X2, X4
    LD3R { V18.2S, V19.2S, V20.2S }, [X2], #12
    ADD  X4, X4, X7
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X4]
    MOV  X2, X4
    LD3R { V15.2S, V16.2S, V17.2S }, [X2], #12
    ADD  X4, X4, X7
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X4]
    MOV  X2, X4
    LD3R { V15.4S, V16.4S, V17.4S }, [X2], #12
    ADD  X4, X4, X7
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X4]
    MOV  X2, X4
    LD3R { V3.2D, V4.2D, V5.2D }, [X2], #24
    ADD  X4, X4, X7, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X4]
    MOV  X2, X4
    LD3R { V18.1D, V19.1D, V20.1D }, [X2], #24
    ADD  X4, X4, X7, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X4]
    MOV  X2, X4
    LD3R { V17.2D, V18.2D, V19.2D }, [X2], #24
    ADD  X4, X4, X7, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X4]
    MOV  X2, X4
    LD3R { V4.16B, V5.16B, V6.16B }, [X2], #3
    ADD  X4, X4, X7, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X4]
    MOV  X2, X4
    LD3R { V6.16B, V7.16B, V8.16B }, [X2], #3
    ADD  X4, X4, X7
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X4]
    MOV  X2, X4
    LD3R { V30.8B, V31.8B, V0.8B }, [X2], #3
    ADD  X4, X4, X7, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X4]
    MOV  X2, X4
    LD3R { V23.4H, V24.4H, V25.4H }, [X2], #6
    ADD  X4, X4, X7, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X4]
    MOV  X2, X4
    LD3R { V24.8H, V25.8H, V26.8H }, [X2], #6
    ADD  X4, X4, X7, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X4]
    MOV  X2, X4
    LD3R { V12.4H, V13.4H, V14.4H }, [X2], #6
    ADD  X4, X4, X7, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X4]
    LD3R { V17.16B, V18.16B, V19.16B }, [X4], X10
    ADD  X4, X4, X7, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X4]
    LD3R { V21.16B, V22.16B, V23.16B }, [X4], X10
    ADD  X4, X4, X7, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X4]
    LD3R { V25.2D, V26.2D, V27.2D }, [X4], X10
    ADD  X4, X4, X7, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X4]
    LD3R { V14.4S, V15.4S, V16.4S }, [X4], X10
    ADD  X4, X4, X7
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X4]
    LD3R { V10.8H, V11.8H, V12.8H }, [X4], X10
    ADD  X4, X4, X7, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X4]
    LD3R { V6.1D, V7.1D, V8.1D }, [X4], X10
    ADD  X4, X4, X7
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X4]
    LD3R { V30.1D, V31.1D, V0.1D }, [X4], X10
    ADD  X4, X4, X7, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X4]
    LD3R { V30.2S, V31.2S, V0.2S }, [X4], X10
    ADD  X4, X4, X7, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X4]
    LD3R { V28.4H, V29.4H, V30.4H }, [X4], X10
    ADD  X4, X4, X7
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X4]
    LD3R { V7.8B, V8.8B, V9.8B }, [X4], X10
    ADD  X4, X4, X7, ASR #0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X16, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X11, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D1
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D2
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D3
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D4
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D5
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D6
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D7
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D8
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D9
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D10
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D11
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D12
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D13
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D14
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D15
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D16
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D17
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D18
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D19
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D20
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D21
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D22
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D23
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D24
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D25
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D26
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D27
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D28
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D29
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D30
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X11, D31
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X20
    FMOV  D1, X23
    FMOV  V1.D[1], X2
    FMOV  D2, X9
    FMOV  V2.D[1], X12
    FMOV  D3, X5
    FMOV  V3.D[1], X19
    FMOV  D4, X26
    FMOV  V4.D[1], X20
    FMOV  D5, X8
    FMOV  V5.D[1], X12
    FMOV  D6, X13
    FMOV  V6.D[1], X26
    FMOV  D7, X8
    FMOV  V7.D[1], X19
    FMOV  D8, X11
    FMOV  V8.D[1], X26
    FMOV  D9, X22
    FMOV  V9.D[1], X22
    FMOV  D10, X13
    FMOV  V10.D[1], X5
    FMOV  D11, X19
    FMOV  V11.D[1], X13
    FMOV  D12, X17
    FMOV  V12.D[1], X6
    FMOV  D13, X3
    FMOV  V13.D[1], X9
    FMOV  D14, X7
    FMOV  V14.D[1], X14
    FMOV  D15, X9
    FMOV  V15.D[1], X15
    FMOV  D16, X26
    FMOV  V16.D[1], X7
    FMOV  D17, X14
    FMOV  V17.D[1], X15
    FMOV  D18, X7
    FMOV  V18.D[1], X14
    FMOV  D19, X4
    FMOV  V19.D[1], X10
    FMOV  D20, X26
    FMOV  V20.D[1], X8
    FMOV  D21, X3
    FMOV  V21.D[1], X20
    FMOV  D22, X18
    FMOV  V22.D[1], X21
    FMOV  D23, X11
    FMOV  V23.D[1], X17
    FMOV  D24, X22
    FMOV  V24.D[1], X18
    FMOV  D25, X5
    FMOV  V25.D[1], X9
    FMOV  D26, X4
    FMOV  V26.D[1], X14
    FMOV  D27, X4
    FMOV  V27.D[1], X22
    FMOV  D28, X19
    FMOV  V28.D[1], X15
    FMOV  D29, X9
    FMOV  V29.D[1], X10
    FMOV  D30, X13
    FMOV  V30.D[1], X22
    FMOV  D31, X9
    FMOV  V31.D[1], X14
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X9, #0x2800, LSL #0
    ADD  X17, X30, X9
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X17]
    LD3R { V6.4S, V7.4S, V8.4S }, [X17]
    ADD  X17, X17, X12, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X17]
    LD3R { V16.16B, V17.16B, V18.16B }, [X17]
    ADD  X17, X17, X12, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X17]
    LD3R { V15.2D, V16.2D, V17.2D }, [X17]
    ADD  X17, X17, X12, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X17]
    LD3R { V5.4S, V6.4S, V7.4S }, [X17]
    ADD  X17, X17, X12
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X17]
    LD3R { V26.8H, V27.8H, V28.8H }, [X17]
    ADD  X17, X17, X12
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X17]
    LD3R { V29.8B, V30.8B, V31.8B }, [X17]
    ADD  X17, X17, X12
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X17]
    LD3R { V2.1D, V3.1D, V4.1D }, [X17]
    ADD  X17, X17, X12, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X17]
    LD3R { V24.2S, V25.2S, V26.2S }, [X17]
    ADD  X17, X17, X12
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X17]
    LD3R { V27.4H, V28.4H, V29.4H }, [X17]
    ADD  X17, X17, X12, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X17]
    LD3R { V25.8B, V26.8B, V27.8B }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X17]
    MOV  X22, X17
    LD3R { V6.2S, V7.2S, V8.2S }, [X22], #12
    ADD  X17, X17, X12, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X17]
    MOV  X22, X17
    LD3R { V27.2S, V28.2S, V29.2S }, [X22], #12
    ADD  X17, X17, X12, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X17]
    MOV  X22, X17
    LD3R { V6.4S, V7.4S, V8.4S }, [X22], #12
    ADD  X17, X17, X12, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X17]
    MOV  X22, X17
    LD3R { V26.2D, V27.2D, V28.2D }, [X22], #24
    ADD  X17, X17, X12
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X17]
    MOV  X22, X17
    LD3R { V10.1D, V11.1D, V12.1D }, [X22], #24
    ADD  X17, X17, X12
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X17]
    MOV  X22, X17
    LD3R { V26.2D, V27.2D, V28.2D }, [X22], #24
    ADD  X17, X17, X12, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X17]
    MOV  X22, X17
    LD3R { V27.8B, V28.8B, V29.8B }, [X22], #3
    ADD  X17, X17, X12, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X17]
    MOV  X22, X17
    LD3R { V27.16B, V28.16B, V29.16B }, [X22], #3
    ADD  X17, X17, X12, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X17]
    MOV  X22, X17
    LD3R { V25.8B, V26.8B, V27.8B }, [X22], #3
    ADD  X17, X17, X12, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X17]
    MOV  X22, X17
    LD3R { V13.4H, V14.4H, V15.4H }, [X22], #6
    ADD  X17, X17, X12
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X17]
    MOV  X22, X17
    LD3R { V22.8H, V23.8H, V24.8H }, [X22], #6
    ADD  X17, X17, X12
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X17]
    MOV  X22, X17
    LD3R { V30.4H, V31.4H, V0.4H }, [X22], #6
    ADD  X17, X17, X12, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X17]
    LD3R { V23.2D, V24.2D, V25.2D }, [X17], X26
    ADD  X17, X17, X12, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X17]
    LD3R { V17.16B, V18.16B, V19.16B }, [X17], X26
    ADD  X17, X17, X12, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X17]
    LD3R { V10.2D, V11.2D, V12.2D }, [X17], X26
    ADD  X17, X17, X12
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X17]
    LD3R { V23.4S, V24.4S, V25.4S }, [X17], X26
    ADD  X17, X17, X12
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X17]
    LD3R { V5.8H, V6.8H, V7.8H }, [X17], X26
    ADD  X17, X17, X12, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X17]
    LD3R { V20.8B, V21.8B, V22.8B }, [X17], X26
    ADD  X17, X17, X12, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X17]
    LD3R { V10.1D, V11.1D, V12.1D }, [X17], X26
    ADD  X17, X17, X12, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X17]
    LD3R { V26.2S, V27.2S, V28.2S }, [X17], X26
    ADD  X17, X17, X12, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X17]
    LD3R { V0.4H, V1.4H, V2.4H }, [X17], X26
    ADD  X17, X17, X12, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X17]
    LD3R { V22.8B, V23.8B, V24.8B }, [X17], X26
    ADD  X17, X17, X12, LSR #0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X15, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X18, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D1
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D2
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D3
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D4
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D5
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D6
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D7
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D8
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D9
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D10
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D11
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D12
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D13
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D14
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D15
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D16
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D17
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D18
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D19
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D20
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D21
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D22
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D23
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D24
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D25
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D26
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D27
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D28
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D29
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D30
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X18, D31
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X5
    FMOV  V0.D[1], X21
    FMOV  D1, X26
    FMOV  V1.D[1], X19
    FMOV  D2, X23
    FMOV  V2.D[1], X20
    FMOV  D3, X2
    FMOV  V3.D[1], X5
    FMOV  D4, X13
    FMOV  V4.D[1], X22
    FMOV  D5, X4
    FMOV  V5.D[1], X23
    FMOV  D6, X23
    FMOV  V6.D[1], X19
    FMOV  D7, X26
    FMOV  V7.D[1], X23
    FMOV  D8, X20
    FMOV  V8.D[1], X14
    FMOV  D9, X11
    FMOV  V9.D[1], X13
    FMOV  D10, X18
    FMOV  V10.D[1], X5
    FMOV  D11, X13
    FMOV  V11.D[1], X5
    FMOV  D12, X16
    FMOV  V12.D[1], X13
    FMOV  D13, X13
    FMOV  V13.D[1], X23
    FMOV  D14, X21
    FMOV  V14.D[1], X2
    FMOV  D15, X3
    FMOV  V15.D[1], X3
    FMOV  D16, X21
    FMOV  V16.D[1], X12
    FMOV  D17, X15
    FMOV  V17.D[1], X20
    FMOV  D18, X14
    FMOV  V18.D[1], X3
    FMOV  D19, X20
    FMOV  V19.D[1], X11
    FMOV  D20, X17
    FMOV  V20.D[1], X14
    FMOV  D21, X13
    FMOV  V21.D[1], X18
    FMOV  D22, X13
    FMOV  V22.D[1], X18
    FMOV  D23, X5
    FMOV  V23.D[1], X13
    FMOV  D24, X10
    FMOV  V24.D[1], X9
    FMOV  D25, X5
    FMOV  V25.D[1], X7
    FMOV  D26, X23
    FMOV  V26.D[1], X7
    FMOV  D27, X8
    FMOV  V27.D[1], X13
    FMOV  D28, X23
    FMOV  V28.D[1], X22
    FMOV  D29, X8
    FMOV  V29.D[1], X10
    FMOV  D30, X17
    FMOV  V30.D[1], X23
    FMOV  D31, X8
    FMOV  V31.D[1], X9
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X19, #0x2d00, LSL #0
    ADD  X2, X30, X19
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X2]
    LD3R { V12.4S, V13.4S, V14.4S }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X2]
    LD3R { V17.16B, V18.16B, V19.16B }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X2]
    LD3R { V29.2D, V30.2D, V31.2D }, [X2]
    ADD  X2, X2, X4
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X2]
    LD3R { V2.4S, V3.4S, V4.4S }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X2]
    LD3R { V7.8H, V8.8H, V9.8H }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2]
    LD3R { V17.2S, V18.2S, V19.2S }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X2]
    LD3R { V4.1D, V5.1D, V6.1D }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X2]
    LD3R { V10.2S, V11.2S, V12.2S }, [X2]
    ADD  X2, X2, X4
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X2]
    LD3R { V7.4H, V8.4H, V9.4H }, [X2]
    ADD  X2, X2, X4
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X2]
    LD3R { V1.8B, V2.8B, V3.8B }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X2]
    MOV  X3, X2
    LD3R { V20.2S, V21.2S, V22.2S }, [X3], #12
    ADD  X2, X2, X4, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X2]
    MOV  X3, X2
    LD3R { V13.2S, V14.2S, V15.2S }, [X3], #12
    ADD  X2, X2, X4, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X2]
    MOV  X3, X2
    LD3R { V12.4S, V13.4S, V14.4S }, [X3], #12
    ADD  X2, X2, X4, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X2]
    MOV  X3, X2
    LD3R { V8.1D, V9.1D, V10.1D }, [X3], #24
    ADD  X2, X2, X4, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X2]
    MOV  X3, X2
    LD3R { V27.1D, V28.1D, V29.1D }, [X3], #24
    ADD  X2, X2, X4
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2]
    MOV  X3, X2
    LD3R { V4.2D, V5.2D, V6.2D }, [X3], #24
    ADD  X2, X2, X4
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X2]
    MOV  X3, X2
    LD3R { V14.16B, V15.16B, V16.16B }, [X3], #3
    ADD  X2, X2, X4, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X2]
    MOV  X3, X2
    LD3R { V8.16B, V9.16B, V10.16B }, [X3], #3
    ADD  X2, X2, X4, ASR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X2]
    MOV  X3, X2
    LD3R { V5.8B, V6.8B, V7.8B }, [X3], #3
    ADD  X2, X2, X4, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X2]
    MOV  X3, X2
    LD3R { V12.4H, V13.4H, V14.4H }, [X3], #6
    ADD  X2, X2, X4, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X2]
    MOV  X3, X2
    LD3R { V16.8H, V17.8H, V18.8H }, [X3], #6
    ADD  X2, X2, X4, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X2]
    MOV  X3, X2
    LD3R { V27.8H, V28.8H, V29.8H }, [X3], #6
    ADD  X2, X2, X4, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X2]
    LD3R { V28.16B, V29.16B, V30.16B }, [X2], X14
    ADD  X2, X2, X4, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X2]
    LD3R { V5.16B, V6.16B, V7.16B }, [X2], X14
    ADD  X2, X2, X4, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X2]
    LD3R { V17.2D, V18.2D, V19.2D }, [X2], X14
    ADD  X2, X2, X4, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X2]
    LD3R { V18.4S, V19.4S, V20.4S }, [X2], X14
    ADD  X2, X2, X4, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X2]
    LD3R { V15.8H, V16.8H, V17.8H }, [X2], X14
    ADD  X2, X2, X4, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X2]
    LD3R { V10.8B, V11.8B, V12.8B }, [X2], X14
    ADD  X2, X2, X4, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X2]
    LD3R { V19.1D, V20.1D, V21.1D }, [X2], X14
    ADD  X2, X2, X4, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X2]
    LD3R { V15.2S, V16.2S, V17.2S }, [X2], X14
    ADD  X2, X2, X4, ASR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X2]
    LD3R { V27.4H, V28.4H, V29.4H }, [X2], X14
    ADD  X2, X2, X4, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X2]
    LD3R { V24.8B, V25.8B, V26.8B }, [X2], X14
    ADD  X2, X2, X4, LSR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X16, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X23, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D1
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D2
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D3
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D4
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D5
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D6
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D7
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D8
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D9
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D10
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D11
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D12
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D13
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D14
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D15
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D16
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D17
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D18
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D19
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D20
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D21
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D22
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D23
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D24
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D25
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D26
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D27
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D28
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D29
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D30
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D31
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X23
    FMOV  D1, X2
    FMOV  V1.D[1], X14
    FMOV  D2, X22
    FMOV  V2.D[1], X26
    FMOV  D3, X26
    FMOV  V3.D[1], X15
    FMOV  D4, X15
    FMOV  V4.D[1], X19
    FMOV  D5, X17
    FMOV  V5.D[1], X26
    FMOV  D6, X18
    FMOV  V6.D[1], X8
    FMOV  D7, X16
    FMOV  V7.D[1], X23
    FMOV  D8, X7
    FMOV  V8.D[1], X22
    FMOV  D9, X5
    FMOV  V9.D[1], X6
    FMOV  D10, X14
    FMOV  V10.D[1], X22
    FMOV  D11, X15
    FMOV  V11.D[1], X22
    FMOV  D12, X18
    FMOV  V12.D[1], X10
    FMOV  D13, X8
    FMOV  V13.D[1], X15
    FMOV  D14, X4
    FMOV  V14.D[1], X3
    FMOV  D15, X9
    FMOV  V15.D[1], X3
    FMOV  D16, X22
    FMOV  V16.D[1], X4
    FMOV  D17, X7
    FMOV  V17.D[1], X11
    FMOV  D18, X9
    FMOV  V18.D[1], X26
    FMOV  D19, X2
    FMOV  V19.D[1], X19
    FMOV  D20, X21
    FMOV  V20.D[1], X5
    FMOV  D21, X26
    FMOV  V21.D[1], X6
    FMOV  D22, X8
    FMOV  V22.D[1], X17
    FMOV  D23, X16
    FMOV  V23.D[1], X21
    FMOV  D24, X22
    FMOV  V24.D[1], X21
    FMOV  D25, X7
    FMOV  V25.D[1], X5
    FMOV  D26, X18
    FMOV  V26.D[1], X5
    FMOV  D27, X8
    FMOV  V27.D[1], X17
    FMOV  D28, X15
    FMOV  V28.D[1], X6
    FMOV  D29, X18
    FMOV  V29.D[1], X26
    FMOV  D30, X4
    FMOV  V30.D[1], X15
    FMOV  D31, X10
    FMOV  V31.D[1], X13
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X2, #0x0, LSL #0
    ADD  X14, X30, X2
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X14]
    LD3R { V29.4S, V30.4S, V31.4S }, [X14]
    ADD  X14, X14, X12, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X14]
    LD3R { V20.16B, V21.16B, V22.16B }, [X14]
    ADD  X14, X14, X12, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X14]
    LD3R { V4.2D, V5.2D, V6.2D }, [X14]
    ADD  X14, X14, X12, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X14]
    LD3R { V9.4S, V10.4S, V11.4S }, [X14]
    ADD  X14, X14, X12, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X14]
    LD3R { V2.8H, V3.8H, V4.8H }, [X14]
    ADD  X14, X14, X12
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X14]
    LD3R { V2.8B, V3.8B, V4.8B }, [X14]
    ADD  X14, X14, X12, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X14]
    LD3R { V1.1D, V2.1D, V3.1D }, [X14]
    ADD  X14, X14, X12, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X14]
    LD3R { V23.2S, V24.2S, V25.2S }, [X14]
    ADD  X14, X14, X12, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X14]
    LD3R { V10.4H, V11.4H, V12.4H }, [X14]
    ADD  X14, X14, X12, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X14]
    LD3R { V15.8B, V16.8B, V17.8B }, [X14]
    ADD  X14, X14, X12, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X14]
    MOV  X6, X14
    LD3R { V25.4S, V26.4S, V27.4S }, [X6], #12
    ADD  X14, X14, X12
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X14]
    MOV  X6, X14
    LD3R { V4.2S, V5.2S, V6.2S }, [X6], #12
    ADD  X14, X14, X12, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X14]
    MOV  X6, X14
    LD3R { V8.4S, V9.4S, V10.4S }, [X6], #12
    ADD  X14, X14, X12
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X14]
    MOV  X6, X14
    LD3R { V1.1D, V2.1D, V3.1D }, [X6], #24
    ADD  X14, X14, X12, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X14]
    MOV  X6, X14
    LD3R { V25.1D, V26.1D, V27.1D }, [X6], #24
    ADD  X14, X14, X12, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X14]
    MOV  X6, X14
    LD3R { V10.2D, V11.2D, V12.2D }, [X6], #24
    ADD  X14, X14, X12, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X14]
    MOV  X6, X14
    LD3R { V8.16B, V9.16B, V10.16B }, [X6], #3
    ADD  X14, X14, X12
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X14]
    MOV  X6, X14
    LD3R { V13.16B, V14.16B, V15.16B }, [X6], #3
    ADD  X14, X14, X12
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X14]
    MOV  X6, X14
    LD3R { V1.8B, V2.8B, V3.8B }, [X6], #3
    ADD  X14, X14, X12, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X14]
    MOV  X6, X14
    LD3R { V22.4H, V23.4H, V24.4H }, [X6], #6
    ADD  X14, X14, X12, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X14]
    MOV  X6, X14
    LD3R { V23.8H, V24.8H, V25.8H }, [X6], #6
    ADD  X14, X14, X12, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X14]
    MOV  X6, X14
    LD3R { V8.8H, V9.8H, V10.8H }, [X6], #6
    ADD  X14, X14, X12
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X14]
    LD3R { V16.8H, V17.8H, V18.8H }, [X14], X9
    ADD  X14, X14, X12, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X14]
    LD3R { V4.16B, V5.16B, V6.16B }, [X14], X9
    ADD  X14, X14, X12, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    LD3R { V24.2D, V25.2D, V26.2D }, [X14], X9
    ADD  X14, X14, X12
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X14]
    LD3R { V27.4S, V28.4S, V29.4S }, [X14], X9
    ADD  X14, X14, X12
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X14]
    LD3R { V20.8H, V21.8H, V22.8H }, [X14], X9
    ADD  X14, X14, X12
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X14]
    LD3R { V30.4H, V31.4H, V0.4H }, [X14], X9
    ADD  X14, X14, X12, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X14]
    LD3R { V22.1D, V23.1D, V24.1D }, [X14], X9
    ADD  X14, X14, X12, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X14]
    LD3R { V5.2S, V6.2S, V7.2S }, [X14], X9
    ADD  X14, X14, X12, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X14]
    LD3R { V5.4H, V6.4H, V7.4H }, [X14], X9
    ADD  X14, X14, X12, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X14]
    LD3R { V6.8B, V7.8B, V8.8B }, [X14], X9
    ADD  X14, X14, X12, LSR #0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X20, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D1
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D2
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D3
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D4
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D5
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D6
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D7
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D8
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D9
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D10
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D11
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D12
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D13
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D14
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D15
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D16
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D17
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D18
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D19
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D20
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D21
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D22
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D23
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D24
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D25
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D26
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D27
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D28
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D29
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D30
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X20, D31
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X19, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X22
    FMOV  D1, X11
    FMOV  V1.D[1], X20
    FMOV  D2, X4
    FMOV  V2.D[1], X20
    FMOV  D3, X5
    FMOV  V3.D[1], X23
    FMOV  D4, X26
    FMOV  V4.D[1], X3
    FMOV  D5, X7
    FMOV  V5.D[1], X3
    FMOV  D6, X18
    FMOV  V6.D[1], X23
    FMOV  D7, X17
    FMOV  V7.D[1], X4
    FMOV  D8, X16
    FMOV  V8.D[1], X11
    FMOV  D9, X20
    FMOV  V9.D[1], X22
    FMOV  D10, X10
    FMOV  V10.D[1], X3
    FMOV  D11, X18
    FMOV  V11.D[1], X26
    FMOV  D12, X8
    FMOV  V12.D[1], X4
    FMOV  D13, X23
    FMOV  V13.D[1], X8
    FMOV  D14, X2
    FMOV  V14.D[1], X11
    FMOV  D15, X13
    FMOV  V15.D[1], X12
    FMOV  D16, X3
    FMOV  V16.D[1], X11
    FMOV  D17, X3
    FMOV  V17.D[1], X4
    FMOV  D18, X12
    FMOV  V18.D[1], X7
    FMOV  D19, X20
    FMOV  V19.D[1], X11
    FMOV  D20, X5
    FMOV  V20.D[1], X9
    FMOV  D21, X12
    FMOV  V21.D[1], X20
    FMOV  D22, X26
    FMOV  V22.D[1], X8
    FMOV  D23, X15
    FMOV  V23.D[1], X9
    FMOV  D24, X3
    FMOV  V24.D[1], X9
    FMOV  D25, X8
    FMOV  V25.D[1], X16
    FMOV  D26, X7
    FMOV  V26.D[1], X13
    FMOV  D27, X15
    FMOV  V27.D[1], X4
    FMOV  D28, X3
    FMOV  V28.D[1], X23
    FMOV  D29, X6
    FMOV  V29.D[1], X2
    FMOV  D30, X5
    FMOV  V30.D[1], X7
    FMOV  D31, X7
    FMOV  V31.D[1], X13
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X8, #0x500, LSL #0
    ADD  X18, X30, X8, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X18]
    LD3R { V7.8H, V8.8H, V9.8H }, [X18]
    ADD  X18, X18, X22, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X18]
    LD3R { V7.16B, V8.16B, V9.16B }, [X18]
    ADD  X18, X18, X22, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X18]
    LD3R { V25.2D, V26.2D, V27.2D }, [X18]
    ADD  X18, X18, X22, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X18]
    LD3R { V7.4S, V8.4S, V9.4S }, [X18]
    ADD  X18, X18, X22, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X18]
    LD3R { V29.8H, V30.8H, V31.8H }, [X18]
    ADD  X18, X18, X22, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X18]
    LD3R { V25.2S, V26.2S, V27.2S }, [X18]
    ADD  X18, X18, X22, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X18]
    LD3R { V7.1D, V8.1D, V9.1D }, [X18]
    ADD  X18, X18, X22, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X18]
    LD3R { V14.2S, V15.2S, V16.2S }, [X18]
    ADD  X18, X18, X22
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X18]
    LD3R { V1.4H, V2.4H, V3.4H }, [X18]
    ADD  X18, X18, X22
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X18]
    LD3R { V12.8B, V13.8B, V14.8B }, [X18]
    ADD  X18, X18, X22, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X18]
    MOV  X5, X18
    LD3R { V7.2S, V8.2S, V9.2S }, [X5], #12
    ADD  X18, X18, X22, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X18]
    MOV  X5, X18
    LD3R { V14.2S, V15.2S, V16.2S }, [X5], #12
    ADD  X18, X18, X22
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X18]
    MOV  X5, X18
    LD3R { V19.4S, V20.4S, V21.4S }, [X5], #12
    ADD  X18, X18, X22, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X18]
    MOV  X5, X18
    LD3R { V2.1D, V3.1D, V4.1D }, [X5], #24
    ADD  X18, X18, X22, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X18]
    MOV  X5, X18
    LD3R { V30.1D, V31.1D, V0.1D }, [X5], #24
    ADD  X18, X18, X22
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X18]
    MOV  X5, X18
    LD3R { V14.2D, V15.2D, V16.2D }, [X5], #24
    ADD  X18, X18, X22, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X18]
    MOV  X5, X18
    LD3R { V21.16B, V22.16B, V23.16B }, [X5], #3
    ADD  X18, X18, X22
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X18]
    MOV  X5, X18
    LD3R { V16.16B, V17.16B, V18.16B }, [X5], #3
    ADD  X18, X18, X22, ASR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X18]
    MOV  X5, X18
    LD3R { V18.8B, V19.8B, V20.8B }, [X5], #3
    ADD  X18, X18, X22
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X18]
    MOV  X5, X18
    LD3R { V14.4H, V15.4H, V16.4H }, [X5], #6
    ADD  X18, X18, X22, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X18]
    MOV  X5, X18
    LD3R { V9.8H, V10.8H, V11.8H }, [X5], #6
    ADD  X18, X18, X22, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X18]
    MOV  X5, X18
    LD3R { V28.8H, V29.8H, V30.8H }, [X5], #6
    ADD  X18, X18, X22, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X18]
    LD3R { V1.2D, V2.2D, V3.2D }, [X18], X7
    ADD  X18, X18, X22
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X18]
    LD3R { V0.16B, V1.16B, V2.16B }, [X18], X7
    ADD  X18, X18, X22, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X18]
    LD3R { V2.2D, V3.2D, V4.2D }, [X18], X7
    ADD  X18, X18, X22, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X18]
    LD3R { V15.4S, V16.4S, V17.4S }, [X18], X7
    ADD  X18, X18, X22, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X18]
    LD3R { V10.8H, V11.8H, V12.8H }, [X18], X7
    ADD  X18, X18, X22, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X18]
    LD3R { V17.2S, V18.2S, V19.2S }, [X18], X7
    ADD  X18, X18, X22, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X18]
    LD3R { V27.1D, V28.1D, V29.1D }, [X18], X7
    ADD  X18, X18, X22, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X18]
    LD3R { V15.2S, V16.2S, V17.2S }, [X18], X7
    ADD  X18, X18, X22
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X18]
    LD3R { V4.4H, V5.4H, V6.4H }, [X18], X7
    ADD  X18, X18, X22, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X18]
    LD3R { V13.8B, V14.8B, V15.8B }, [X18], X7
    ADD  X18, X18, X22, ASR #0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X12, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D1
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D2
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D3
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D4
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D5
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D6
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D7
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D8
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D9
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D10
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D11
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D12
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D13
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D14
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D15
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D16
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D17
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D18
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D19
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D20
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D21
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D22
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D23
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D24
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D25
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D26
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D27
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D28
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D29
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D30
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X12, D31
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X11
    FMOV  D1, X22
    FMOV  V1.D[1], X23
    FMOV  D2, X19
    FMOV  V2.D[1], X4
    FMOV  D3, X21
    FMOV  V3.D[1], X13
    FMOV  D4, X26
    FMOV  V4.D[1], X2
    FMOV  D5, X13
    FMOV  V5.D[1], X7
    FMOV  D6, X8
    FMOV  V6.D[1], X21
    FMOV  D7, X20
    FMOV  V7.D[1], X20
    FMOV  D8, X23
    FMOV  V8.D[1], X16
    FMOV  D9, X7
    FMOV  V9.D[1], X11
    FMOV  D10, X2
    FMOV  V10.D[1], X26
    FMOV  D11, X9
    FMOV  V11.D[1], X8
    FMOV  D12, X23
    FMOV  V12.D[1], X23
    FMOV  D13, X21
    FMOV  V13.D[1], X23
    FMOV  D14, X23
    FMOV  V14.D[1], X21
    FMOV  D15, X18
    FMOV  V15.D[1], X22
    FMOV  D16, X3
    FMOV  V16.D[1], X26
    FMOV  D17, X13
    FMOV  V17.D[1], X23
    FMOV  D18, X4
    FMOV  V18.D[1], X11
    FMOV  D19, X16
    FMOV  V19.D[1], X13
    FMOV  D20, X20
    FMOV  V20.D[1], X10
    FMOV  D21, X5
    FMOV  V21.D[1], X16
    FMOV  D22, X17
    FMOV  V22.D[1], X14
    FMOV  D23, X14
    FMOV  V23.D[1], X13
    FMOV  D24, X12
    FMOV  V24.D[1], X9
    FMOV  D25, X11
    FMOV  V25.D[1], X12
    FMOV  D26, X2
    FMOV  V26.D[1], X2
    FMOV  D27, X2
    FMOV  V27.D[1], X23
    FMOV  D28, X6
    FMOV  V28.D[1], X6
    FMOV  D29, X26
    FMOV  V29.D[1], X9
    FMOV  D30, X11
    FMOV  V30.D[1], X6
    FMOV  D31, X4
    FMOV  V31.D[1], X11
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X14, #0xa00, LSL #0
    ADD  X17, X30, X14, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X17]
    LD3R { V0.16B, V1.16B, V2.16B }, [X17]
    ADD  X17, X17, X11, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X17]
    LD3R { V22.16B, V23.16B, V24.16B }, [X17]
    ADD  X17, X17, X11
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X17]
    LD3R { V0.2D, V1.2D, V2.2D }, [X17]
    ADD  X17, X17, X11
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X17]
    LD3R { V20.4S, V21.4S, V22.4S }, [X17]
    ADD  X17, X17, X11, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X17]
    LD3R { V20.8H, V21.8H, V22.8H }, [X17]
    ADD  X17, X17, X11, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X17]
    LD3R { V0.4H, V1.4H, V2.4H }, [X17]
    ADD  X17, X17, X11, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X17]
    LD3R { V23.1D, V24.1D, V25.1D }, [X17]
    ADD  X17, X17, X11, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X17]
    LD3R { V31.2S, V0.2S, V1.2S }, [X17]
    ADD  X17, X17, X11, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X17]
    LD3R { V5.4H, V6.4H, V7.4H }, [X17]
    ADD  X17, X17, X11, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X17]
    LD3R { V11.8B, V12.8B, V13.8B }, [X17]
    ADD  X17, X17, X11, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X17]
    MOV  X22, X17
    LD3R { V0.4S, V1.4S, V2.4S }, [X22], #12
    ADD  X17, X17, X11, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X17]
    MOV  X22, X17
    LD3R { V15.2S, V16.2S, V17.2S }, [X22], #12
    ADD  X17, X17, X11, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X17]
    MOV  X22, X17
    LD3R { V24.4S, V25.4S, V26.4S }, [X22], #12
    ADD  X17, X17, X11
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X17]
    MOV  X22, X17
    LD3R { V19.2D, V20.2D, V21.2D }, [X22], #24
    ADD  X17, X17, X11, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X17]
    MOV  X22, X17
    LD3R { V5.1D, V6.1D, V7.1D }, [X22], #24
    ADD  X17, X17, X11
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X17]
    MOV  X22, X17
    LD3R { V26.2D, V27.2D, V28.2D }, [X22], #24
    ADD  X17, X17, X11
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X17]
    MOV  X22, X17
    LD3R { V5.16B, V6.16B, V7.16B }, [X22], #3
    ADD  X17, X17, X11, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X17]
    MOV  X22, X17
    LD3R { V27.16B, V28.16B, V29.16B }, [X22], #3
    ADD  X17, X17, X11
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X17]
    MOV  X22, X17
    LD3R { V7.8B, V8.8B, V9.8B }, [X22], #3
    ADD  X17, X17, X11
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X17]
    MOV  X22, X17
    LD3R { V31.4H, V0.4H, V1.4H }, [X22], #6
    ADD  X17, X17, X11, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X17]
    MOV  X22, X17
    LD3R { V14.8H, V15.8H, V16.8H }, [X22], #6
    ADD  X17, X17, X11, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X17]
    MOV  X22, X17
    LD3R { V20.4H, V21.4H, V22.4H }, [X22], #6
    ADD  X17, X17, X11, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X17]
    LD3R { V17.4S, V18.4S, V19.4S }, [X17], X20
    ADD  X17, X17, X11, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X17]
    LD3R { V8.16B, V9.16B, V10.16B }, [X17], X20
    ADD  X17, X17, X11, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X17]
    LD3R { V27.2D, V28.2D, V29.2D }, [X17], X20
    ADD  X17, X17, X11, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X17]
    LD3R { V11.4S, V12.4S, V13.4S }, [X17], X20
    ADD  X17, X17, X11, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X17]
    LD3R { V17.8H, V18.8H, V19.8H }, [X17], X20
    ADD  X17, X17, X11, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X17]
    LD3R { V16.4H, V17.4H, V18.4H }, [X17], X20
    ADD  X17, X17, X11
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X17]
    LD3R { V31.1D, V0.1D, V1.1D }, [X17], X20
    ADD  X17, X17, X11, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X17]
    LD3R { V9.2S, V10.2S, V11.2S }, [X17], X20
    ADD  X17, X17, X11, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X17]
    LD3R { V6.4H, V7.4H, V8.4H }, [X17], X20
    ADD  X17, X17, X11, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X17]
    LD3R { V3.8B, V4.8B, V5.8B }, [X17], X20
    ADD  X17, X17, X11, ASR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X19, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D1
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D2
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D3
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D4
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D5
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D6
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D7
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D8
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D9
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D10
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D11
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D12
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D13
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D14
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D15
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D16
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D17
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D18
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D19
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D20
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D21
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D22
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D23
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D24
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D25
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D26
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D27
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D28
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D29
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D30
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X19, D31
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X19
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X21
    FMOV  D1, X22
    FMOV  V1.D[1], X12
    FMOV  D2, X12
    FMOV  V2.D[1], X23
    FMOV  D3, X4
    FMOV  V3.D[1], X21
    FMOV  D4, X19
    FMOV  V4.D[1], X10
    FMOV  D5, X15
    FMOV  V5.D[1], X3
    FMOV  D6, X10
    FMOV  V6.D[1], X11
    FMOV  D7, X16
    FMOV  V7.D[1], X4
    FMOV  D8, X8
    FMOV  V8.D[1], X14
    FMOV  D9, X12
    FMOV  V9.D[1], X15
    FMOV  D10, X18
    FMOV  V10.D[1], X23
    FMOV  D11, X12
    FMOV  V11.D[1], X11
    FMOV  D12, X10
    FMOV  V12.D[1], X4
    FMOV  D13, X4
    FMOV  V13.D[1], X16
    FMOV  D14, X15
    FMOV  V14.D[1], X2
    FMOV  D15, X21
    FMOV  V15.D[1], X5
    FMOV  D16, X4
    FMOV  V16.D[1], X2
    FMOV  D17, X2
    FMOV  V17.D[1], X9
    FMOV  D18, X8
    FMOV  V18.D[1], X2
    FMOV  D19, X23
    FMOV  V19.D[1], X10
    FMOV  D20, X13
    FMOV  V20.D[1], X26
    FMOV  D21, X22
    FMOV  V21.D[1], X9
    FMOV  D22, X10
    FMOV  V22.D[1], X2
    FMOV  D23, X17
    FMOV  V23.D[1], X2
    FMOV  D24, X21
    FMOV  V24.D[1], X26
    FMOV  D25, X16
    FMOV  V25.D[1], X12
    FMOV  D26, X21
    FMOV  V26.D[1], X18
    FMOV  D27, X5
    FMOV  V27.D[1], X22
    FMOV  D28, X9
    FMOV  V28.D[1], X23
    FMOV  D29, X26
    FMOV  V29.D[1], X10
    FMOV  D30, X20
    FMOV  V30.D[1], X5
    FMOV  D31, X17
    FMOV  V31.D[1], X26
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X3, #0xf00, LSL #0
    ADD  X4, X30, X3
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X4]
    LD3R { V10.16B, V11.16B, V12.16B }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X4]
    LD3R { V4.16B, V5.16B, V6.16B }, [X4]
    ADD  X4, X4, X16
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X4]
    LD3R { V24.2D, V25.2D, V26.2D }, [X4]
    ADD  X4, X4, X16
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X4]
    LD3R { V23.4S, V24.4S, V25.4S }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X4]
    LD3R { V11.8H, V12.8H, V13.8H }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X4]
    LD3R { V30.8B, V31.8B, V0.8B }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X4]
    LD3R { V17.1D, V18.1D, V19.1D }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X4]
    LD3R { V29.2S, V30.2S, V31.2S }, [X4]
    ADD  X4, X4, X16
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X4]
    LD3R { V29.4H, V30.4H, V31.4H }, [X4]
    ADD  X4, X4, X16
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X4]
    LD3R { V28.8B, V29.8B, V30.8B }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X4]
    MOV  X5, X4
    LD3R { V11.4S, V12.4S, V13.4S }, [X5], #12
    ADD  X4, X4, X16, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X4]
    MOV  X5, X4
    LD3R { V21.2S, V22.2S, V23.2S }, [X5], #12
    ADD  X4, X4, X16, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X4]
    MOV  X5, X4
    LD3R { V16.4S, V17.4S, V18.4S }, [X5], #12
    ADD  X4, X4, X16, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X4]
    MOV  X5, X4
    LD3R { V6.2D, V7.2D, V8.2D }, [X5], #24
    ADD  X4, X4, X16, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X4]
    MOV  X5, X4
    LD3R { V16.1D, V17.1D, V18.1D }, [X5], #24
    ADD  X4, X4, X16, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X4]
    MOV  X5, X4
    LD3R { V31.2D, V0.2D, V1.2D }, [X5], #24
    ADD  X4, X4, X16
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X4]
    MOV  X5, X4
    LD3R { V15.8B, V16.8B, V17.8B }, [X5], #3
    ADD  X4, X4, X16
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X4]
    MOV  X5, X4
    LD3R { V5.16B, V6.16B, V7.16B }, [X5], #3
    ADD  X4, X4, X16, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X4]
    MOV  X5, X4
    LD3R { V19.8B, V20.8B, V21.8B }, [X5], #3
    ADD  X4, X4, X16, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X4]
    MOV  X5, X4
    LD3R { V14.4H, V15.4H, V16.4H }, [X5], #6
    ADD  X4, X4, X16, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X4]
    MOV  X5, X4
    LD3R { V27.8H, V28.8H, V29.8H }, [X5], #6
    ADD  X4, X4, X16, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X4]
    MOV  X5, X4
    LD3R { V31.4H, V0.4H, V1.4H }, [X5], #6
    ADD  X4, X4, X16
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X4]
    LD3R { V20.8H, V21.8H, V22.8H }, [X4], X13
    ADD  X4, X4, X16, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X4]
    LD3R { V6.16B, V7.16B, V8.16B }, [X4], X13
    ADD  X4, X4, X16
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X4]
    LD3R { V28.2D, V29.2D, V30.2D }, [X4], X13
    ADD  X4, X4, X16, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X4]
    LD3R { V3.4S, V4.4S, V5.4S }, [X4], X13
    ADD  X4, X4, X16, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X4]
    LD3R { V31.8H, V0.8H, V1.8H }, [X4], X13
    ADD  X4, X4, X16
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X4]
    LD3R { V2.4H, V3.4H, V4.4H }, [X4], X13
    ADD  X4, X4, X16
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X4]
    LD3R { V30.1D, V31.1D, V0.1D }, [X4], X13
    ADD  X4, X4, X16
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X4]
    LD3R { V12.2S, V13.2S, V14.2S }, [X4], X13
    ADD  X4, X4, X16, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X4]
    LD3R { V1.4H, V2.4H, V3.4H }, [X4], X13
    ADD  X4, X4, X16
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X4]
    LD3R { V30.8B, V31.8B, V0.8B }, [X4], X13
    ADD  X4, X4, X16
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X12, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X7, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D6
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X7, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X22
    FMOV  D1, X3
    FMOV  V1.D[1], X21
    FMOV  D2, X26
    FMOV  V2.D[1], X26
    FMOV  D3, X20
    FMOV  V3.D[1], X8
    FMOV  D4, X7
    FMOV  V4.D[1], X10
    FMOV  D5, X5
    FMOV  V5.D[1], X26
    FMOV  D6, X14
    FMOV  V6.D[1], X4
    FMOV  D7, X12
    FMOV  V7.D[1], X3
    FMOV  D8, X6
    FMOV  V8.D[1], X26
    FMOV  D9, X14
    FMOV  V9.D[1], X14
    FMOV  D10, X16
    FMOV  V10.D[1], X18
    FMOV  D11, X8
    FMOV  V11.D[1], X6
    FMOV  D12, X17
    FMOV  V12.D[1], X11
    FMOV  D13, X19
    FMOV  V13.D[1], X18
    FMOV  D14, X17
    FMOV  V14.D[1], X26
    FMOV  D15, X8
    FMOV  V15.D[1], X7
    FMOV  D16, X13
    FMOV  V16.D[1], X10
    FMOV  D17, X14
    FMOV  V17.D[1], X14
    FMOV  D18, X14
    FMOV  V18.D[1], X8
    FMOV  D19, X3
    FMOV  V19.D[1], X7
    FMOV  D20, X4
    FMOV  V20.D[1], X11
    FMOV  D21, X23
    FMOV  V21.D[1], X26
    FMOV  D22, X18
    FMOV  V22.D[1], X22
    FMOV  D23, X9
    FMOV  V23.D[1], X26
    FMOV  D24, X5
    FMOV  V24.D[1], X4
    FMOV  D25, X7
    FMOV  V25.D[1], X21
    FMOV  D26, X6
    FMOV  V26.D[1], X11
    FMOV  D27, X8
    FMOV  V27.D[1], X4
    FMOV  D28, X16
    FMOV  V28.D[1], X18
    FMOV  D29, X11
    FMOV  V29.D[1], X5
    FMOV  D30, X2
    FMOV  V30.D[1], X9
    FMOV  D31, X5
    FMOV  V31.D[1], X18
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X21, #0x1400, LSL #0
    ADD  X19, X30, X21, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X19]
    LD3R { V1.4S, V2.4S, V3.4S }, [X19]
    ADD  X19, X19, X3, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X19]
    LD3R { V10.16B, V11.16B, V12.16B }, [X19]
    ADD  X19, X19, X3
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X19]
    LD3R { V3.2D, V4.2D, V5.2D }, [X19]
    ADD  X19, X19, X3, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X19]
    LD3R { V14.4S, V15.4S, V16.4S }, [X19]
    ADD  X19, X19, X3, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X19]
    LD3R { V9.8H, V10.8H, V11.8H }, [X19]
    ADD  X19, X19, X3, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X19]
    LD3R { V8.1D, V9.1D, V10.1D }, [X19]
    ADD  X19, X19, X3, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X19]
    LD3R { V22.1D, V23.1D, V24.1D }, [X19]
    ADD  X19, X19, X3
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X19]
    LD3R { V29.2S, V30.2S, V31.2S }, [X19]
    ADD  X19, X19, X3, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X19]
    LD3R { V8.4H, V9.4H, V10.4H }, [X19]
    ADD  X19, X19, X3
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X19]
    LD3R { V26.8B, V27.8B, V28.8B }, [X19]
    ADD  X19, X19, X3, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X19]
    MOV  X6, X19
    LD3R { V19.2S, V20.2S, V21.2S }, [X6], #12
    ADD  X19, X19, X3, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X19]
    MOV  X6, X19
    LD3R { V17.2S, V18.2S, V19.2S }, [X6], #12
    ADD  X19, X19, X3, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X19]
    MOV  X6, X19
    LD3R { V26.4S, V27.4S, V28.4S }, [X6], #12
    ADD  X19, X19, X3, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X19]
    MOV  X6, X19
    LD3R { V21.2D, V22.2D, V23.2D }, [X6], #24
    ADD  X19, X19, X3
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X19]
    MOV  X6, X19
    LD3R { V19.1D, V20.1D, V21.1D }, [X6], #24
    ADD  X19, X19, X3, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X19]
    MOV  X6, X19
    LD3R { V16.2D, V17.2D, V18.2D }, [X6], #24
    ADD  X19, X19, X3, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X19]
    MOV  X6, X19
    LD3R { V11.16B, V12.16B, V13.16B }, [X6], #3
    ADD  X19, X19, X3
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X19]
    MOV  X6, X19
    LD3R { V27.16B, V28.16B, V29.16B }, [X6], #3
    ADD  X19, X19, X3
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X19]
    MOV  X6, X19
    LD3R { V15.8B, V16.8B, V17.8B }, [X6], #3
    ADD  X19, X19, X3, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X19]
    MOV  X6, X19
    LD3R { V4.4H, V5.4H, V6.4H }, [X6], #6
    ADD  X19, X19, X3, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X19]
    MOV  X6, X19
    LD3R { V28.8H, V29.8H, V30.8H }, [X6], #6
    ADD  X19, X19, X3, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X19]
    MOV  X6, X19
    LD3R { V27.4H, V28.4H, V29.4H }, [X6], #6
    ADD  X19, X19, X3
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X19]
    LD3R { V20.8H, V21.8H, V22.8H }, [X19], X15
    ADD  X19, X19, X3, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X19]
    LD3R { V22.16B, V23.16B, V24.16B }, [X19], X15
    ADD  X19, X19, X3
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X19]
    LD3R { V18.2D, V19.2D, V20.2D }, [X19], X15
    ADD  X19, X19, X3, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X19]
    LD3R { V31.4S, V0.4S, V1.4S }, [X19], X15
    ADD  X19, X19, X3
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X19]
    LD3R { V22.8H, V23.8H, V24.8H }, [X19], X15
    ADD  X19, X19, X3, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X19]
    LD3R { V8.8B, V9.8B, V10.8B }, [X19], X15
    ADD  X19, X19, X3
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X19]
    LD3R { V11.1D, V12.1D, V13.1D }, [X19], X15
    ADD  X19, X19, X3, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X19]
    LD3R { V26.2S, V27.2S, V28.2S }, [X19], X15
    ADD  X19, X19, X3, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X19]
    LD3R { V15.4H, V16.4H, V17.4H }, [X19], X15
    ADD  X19, X19, X3, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X19]
    LD3R { V18.8B, V19.8B, V20.8B }, [X19], X15
    ADD  X19, X19, X3, LSR #0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X8, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D1
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D2
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D5
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D6
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D7
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D8
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D9
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D10
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D11
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D12
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D14
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D15
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D16
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D17
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D18
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D19
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D20
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D22
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D23
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D24
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D25
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D26
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D27
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D29
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D30
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X8, D31
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X11, X5, X8
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X21
    FMOV  D1, X23
    FMOV  V1.D[1], X20
    FMOV  D2, X26
    FMOV  V2.D[1], X5
    FMOV  D3, X10
    FMOV  V3.D[1], X14
    FMOV  D4, X21
    FMOV  V4.D[1], X19
    FMOV  D5, X14
    FMOV  V5.D[1], X6
    FMOV  D6, X21
    FMOV  V6.D[1], X22
    FMOV  D7, X5
    FMOV  V7.D[1], X3
    FMOV  D8, X15
    FMOV  V8.D[1], X4
    FMOV  D9, X19
    FMOV  V9.D[1], X15
    FMOV  D10, X22
    FMOV  V10.D[1], X7
    FMOV  D11, X2
    FMOV  V11.D[1], X16
    FMOV  D12, X14
    FMOV  V12.D[1], X14
    FMOV  D13, X15
    FMOV  V13.D[1], X11
    FMOV  D14, X7
    FMOV  V14.D[1], X17
    FMOV  D15, X6
    FMOV  V15.D[1], X3
    FMOV  D16, X16
    FMOV  V16.D[1], X12
    FMOV  D17, X23
    FMOV  V17.D[1], X18
    FMOV  D18, X20
    FMOV  V18.D[1], X18
    FMOV  D19, X18
    FMOV  V19.D[1], X10
    FMOV  D20, X5
    FMOV  V20.D[1], X16
    FMOV  D21, X7
    FMOV  V21.D[1], X17
    FMOV  D22, X22
    FMOV  V22.D[1], X10
    FMOV  D23, X10
    FMOV  V23.D[1], X19
    FMOV  D24, X26
    FMOV  V24.D[1], X17
    FMOV  D25, X10
    FMOV  V25.D[1], X26
    FMOV  D26, X11
    FMOV  V26.D[1], X15
    FMOV  D27, X12
    FMOV  V27.D[1], X13
    FMOV  D28, X3
    FMOV  V28.D[1], X7
    FMOV  D29, X14
    FMOV  V29.D[1], X2
    FMOV  D30, X26
    FMOV  V30.D[1], X6
    FMOV  D31, X4
    FMOV  V31.D[1], X9
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X9, #0x1900, LSL #0
    ADD  X2, X30, X9
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X2]
    LD3R { V16.2D, V17.2D, V18.2D }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X2]
    LD3R { V8.16B, V9.16B, V10.16B }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X2]
    LD3R { V20.2D, V21.2D, V22.2D }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X2]
    LD3R { V31.4S, V0.4S, V1.4S }, [X2]
    ADD  X2, X2, X17
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X2]
    LD3R { V30.8H, V31.8H, V0.8H }, [X2]
    ADD  X2, X2, X17
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X2]
    LD3R { V16.2S, V17.2S, V18.2S }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X2]
    LD3R { V26.1D, V27.1D, V28.1D }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X2]
    LD3R { V9.2S, V10.2S, V11.2S }, [X2]
    ADD  X2, X2, X17
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X2]
    LD3R { V8.4H, V9.4H, V10.4H }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X2]
    LD3R { V12.8B, V13.8B, V14.8B }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X2]
    MOV  X12, X2
    LD3R { V23.2S, V24.2S, V25.2S }, [X12], #12
    ADD  X2, X2, X17, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X2]
    MOV  X12, X2
    LD3R { V16.2S, V17.2S, V18.2S }, [X12], #12
    ADD  X2, X2, X17, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X2]
    MOV  X12, X2
    LD3R { V28.4S, V29.4S, V30.4S }, [X12], #12
    ADD  X2, X2, X17, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X2]
    MOV  X12, X2
    LD3R { V20.2D, V21.2D, V22.2D }, [X12], #24
    ADD  X2, X2, X17, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X2]
    MOV  X12, X2
    LD3R { V27.1D, V28.1D, V29.1D }, [X12], #24
    ADD  X2, X2, X17, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X2]
    MOV  X12, X2
    LD3R { V3.2D, V4.2D, V5.2D }, [X12], #24
    ADD  X2, X2, X17
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2]
    MOV  X12, X2
    LD3R { V9.16B, V10.16B, V11.16B }, [X12], #3
    ADD  X2, X2, X17
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X2]
    MOV  X12, X2
    LD3R { V13.16B, V14.16B, V15.16B }, [X12], #3
    ADD  X2, X2, X17, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X2]
    MOV  X12, X2
    LD3R { V28.8B, V29.8B, V30.8B }, [X12], #3
    ADD  X2, X2, X17, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X2]
    MOV  X12, X2
    LD3R { V12.4H, V13.4H, V14.4H }, [X12], #6
    ADD  X2, X2, X17, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X2]
    MOV  X12, X2
    LD3R { V4.8H, V5.8H, V6.8H }, [X12], #6
    ADD  X2, X2, X17
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X2]
    MOV  X12, X2
    LD3R { V9.4H, V10.4H, V11.4H }, [X12], #6
    ADD  X2, X2, X17
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X2]
    LD3R { V27.4S, V28.4S, V29.4S }, [X2], X16
    ADD  X2, X2, X17
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X2]
    LD3R { V3.16B, V4.16B, V5.16B }, [X2], X16
    ADD  X2, X2, X17
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X2]
    LD3R { V28.2D, V29.2D, V30.2D }, [X2], X16
    ADD  X2, X2, X17, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X2]
    LD3R { V1.4S, V2.4S, V3.4S }, [X2], X16
    ADD  X2, X2, X17, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X2]
    LD3R { V21.8H, V22.8H, V23.8H }, [X2], X16
    ADD  X2, X2, X17, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X2]
    LD3R { V7.8B, V8.8B, V9.8B }, [X2], X16
    ADD  X2, X2, X17
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X2]
    LD3R { V27.1D, V28.1D, V29.1D }, [X2], X16
    ADD  X2, X2, X17, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X2]
    LD3R { V2.2S, V3.2S, V4.2S }, [X2], X16
    ADD  X2, X2, X17, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X2]
    LD3R { V15.4H, V16.4H, V17.4H }, [X2], X16
    ADD  X2, X2, X17, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X2]
    LD3R { V1.8B, V2.8B, V3.8B }, [X2], X16
    ADD  X2, X2, X17, LSR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X23, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D1
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D2
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D3
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D4
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D5
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D6
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D7
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D8
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D9
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D10
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D11
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D12
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D13
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D14
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D15
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D16
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D17
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D18
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D19
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D20
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D21
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D22
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D23
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D24
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D25
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D26
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D27
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D28
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D29
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D30
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X23, D31
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X23
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X26
    FMOV  D1, X19
    FMOV  V1.D[1], X20
    FMOV  D2, X13
    FMOV  V2.D[1], X11
    FMOV  D3, X22
    FMOV  V3.D[1], X23
    FMOV  D4, X14
    FMOV  V4.D[1], X7
    FMOV  D5, X22
    FMOV  V5.D[1], X26
    FMOV  D6, X12
    FMOV  V6.D[1], X13
    FMOV  D7, X20
    FMOV  V7.D[1], X12
    FMOV  D8, X7
    FMOV  V8.D[1], X16
    FMOV  D9, X22
    FMOV  V9.D[1], X2
    FMOV  D10, X21
    FMOV  V10.D[1], X13
    FMOV  D11, X17
    FMOV  V11.D[1], X20
    FMOV  D12, X12
    FMOV  V12.D[1], X17
    FMOV  D13, X3
    FMOV  V13.D[1], X20
    FMOV  D14, X6
    FMOV  V14.D[1], X15
    FMOV  D15, X18
    FMOV  V15.D[1], X19
    FMOV  D16, X7
    FMOV  V16.D[1], X3
    FMOV  D17, X17
    FMOV  V17.D[1], X26
    FMOV  D18, X17
    FMOV  V18.D[1], X23
    FMOV  D19, X8
    FMOV  V19.D[1], X22
    FMOV  D20, X4
    FMOV  V20.D[1], X20
    FMOV  D21, X12
    FMOV  V21.D[1], X7
    FMOV  D22, X5
    FMOV  V22.D[1], X5
    FMOV  D23, X21
    FMOV  V23.D[1], X12
    FMOV  D24, X12
    FMOV  V24.D[1], X2
    FMOV  D25, X8
    FMOV  V25.D[1], X18
    FMOV  D26, X10
    FMOV  V26.D[1], X11
    FMOV  D27, X2
    FMOV  V27.D[1], X8
    FMOV  D28, X13
    FMOV  V28.D[1], X13
    FMOV  D29, X20
    FMOV  V29.D[1], X8
    FMOV  D30, X26
    FMOV  V30.D[1], X2
    FMOV  D31, X15
    FMOV  V31.D[1], X9
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X6, #0x1e00, LSL #0
    ADD  X4, X30, X6, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X4]
    LD3R { V29.8H, V30.8H, V31.8H }, [X4]
    ADD  X4, X4, X14
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X4]
    LD3R { V26.16B, V27.16B, V28.16B }, [X4]
    ADD  X4, X4, X14, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X4]
    LD3R { V27.2D, V28.2D, V29.2D }, [X4]
    ADD  X4, X4, X14, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X4]
    LD3R { V13.4S, V14.4S, V15.4S }, [X4]
    ADD  X4, X4, X14, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X4]
    LD3R { V5.8H, V6.8H, V7.8H }, [X4]
    ADD  X4, X4, X14
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X4]
    LD3R { V1.2S, V2.2S, V3.2S }, [X4]
    ADD  X4, X4, X14, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X4]
    LD3R { V4.1D, V5.1D, V6.1D }, [X4]
    ADD  X4, X4, X14
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X4]
    LD3R { V17.2S, V18.2S, V19.2S }, [X4]
    ADD  X4, X4, X14, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X4]
    LD3R { V20.4H, V21.4H, V22.4H }, [X4]
    ADD  X4, X4, X14
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X4]
    LD3R { V28.8B, V29.8B, V30.8B }, [X4]
    ADD  X4, X4, X14, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X4]
    MOV  X20, X4
    LD3R { V3.4S, V4.4S, V5.4S }, [X20], #12
    ADD  X4, X4, X14
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X4]
    MOV  X20, X4
    LD3R { V9.2S, V10.2S, V11.2S }, [X20], #12
    ADD  X4, X4, X14, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X4]
    MOV  X20, X4
    LD3R { V12.4S, V13.4S, V14.4S }, [X20], #12
    ADD  X4, X4, X14, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X4]
    MOV  X20, X4
    LD3R { V17.2D, V18.2D, V19.2D }, [X20], #24
    ADD  X4, X4, X14, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X4]
    MOV  X20, X4
    LD3R { V22.1D, V23.1D, V24.1D }, [X20], #24
    ADD  X4, X4, X14, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X4]
    MOV  X20, X4
    LD3R { V23.2D, V24.2D, V25.2D }, [X20], #24
    ADD  X4, X4, X14, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X4]
    MOV  X20, X4
    LD3R { V0.16B, V1.16B, V2.16B }, [X20], #3
    ADD  X4, X4, X14, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X4]
    MOV  X20, X4
    LD3R { V12.16B, V13.16B, V14.16B }, [X20], #3
    ADD  X4, X4, X14
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X4]
    MOV  X20, X4
    LD3R { V18.8B, V19.8B, V20.8B }, [X20], #3
    ADD  X4, X4, X14
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X4]
    MOV  X20, X4
    LD3R { V9.4H, V10.4H, V11.4H }, [X20], #6
    ADD  X4, X4, X14, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X4]
    MOV  X20, X4
    LD3R { V20.8H, V21.8H, V22.8H }, [X20], #6
    ADD  X4, X4, X14
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X4]
    MOV  X20, X4
    LD3R { V15.8H, V16.8H, V17.8H }, [X20], #6
    ADD  X4, X4, X14, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X4]
    LD3R { V5.4S, V6.4S, V7.4S }, [X4], X26
    ADD  X4, X4, X14, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X4]
    LD3R { V24.16B, V25.16B, V26.16B }, [X4], X26
    ADD  X4, X4, X14
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X4]
    LD3R { V27.2D, V28.2D, V29.2D }, [X4], X26
    ADD  X4, X4, X14, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X4]
    LD3R { V13.4S, V14.4S, V15.4S }, [X4], X26
    ADD  X4, X4, X14
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X4]
    LD3R { V9.8H, V10.8H, V11.8H }, [X4], X26
    ADD  X4, X4, X14, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X4]
    LD3R { V30.8B, V31.8B, V0.8B }, [X4], X26
    ADD  X4, X4, X14, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X4]
    LD3R { V5.1D, V6.1D, V7.1D }, [X4], X26
    ADD  X4, X4, X14, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X4]
    LD3R { V13.2S, V14.2S, V15.2S }, [X4], X26
    ADD  X4, X4, X14, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X4]
    LD3R { V29.4H, V30.4H, V31.4H }, [X4], X26
    ADD  X4, X4, X14
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X4]
    LD3R { V23.8B, V24.8B, V25.8B }, [X4], X26
    ADD  X4, X4, X14, ASR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X13, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D1
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D2
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D3
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D4
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D5
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D6
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D7
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D8
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D9
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D10
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D11
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D12
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D13
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D14
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D15
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D16
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D17
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D18
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D19
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D20
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D21
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D22
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D23
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D24
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D25
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D26
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D27
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D28
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D29
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D30
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X13, D31
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X3, X9, X13
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X6
    FMOV  V0.D[1], X23
    FMOV  D1, X20
    FMOV  V1.D[1], X22
    FMOV  D2, X15
    FMOV  V2.D[1], X26
    FMOV  D3, X21
    FMOV  V3.D[1], X4
    FMOV  D4, X9
    FMOV  V4.D[1], X10
    FMOV  D5, X14
    FMOV  V5.D[1], X7
    FMOV  D6, X8
    FMOV  V6.D[1], X15
    FMOV  D7, X3
    FMOV  V7.D[1], X26
    FMOV  D8, X7
    FMOV  V8.D[1], X15
    FMOV  D9, X23
    FMOV  V9.D[1], X6
    FMOV  D10, X21
    FMOV  V10.D[1], X15
    FMOV  D11, X26
    FMOV  V11.D[1], X2
    FMOV  D12, X16
    FMOV  V12.D[1], X20
    FMOV  D13, X3
    FMOV  V13.D[1], X11
    FMOV  D14, X6
    FMOV  V14.D[1], X15
    FMOV  D15, X19
    FMOV  V15.D[1], X18
    FMOV  D16, X16
    FMOV  V16.D[1], X9
    FMOV  D17, X20
    FMOV  V17.D[1], X22
    FMOV  D18, X8
    FMOV  V18.D[1], X12
    FMOV  D19, X12
    FMOV  V19.D[1], X14
    FMOV  D20, X9
    FMOV  V20.D[1], X8
    FMOV  D21, X8
    FMOV  V21.D[1], X6
    FMOV  D22, X18
    FMOV  V22.D[1], X22
    FMOV  D23, X8
    FMOV  V23.D[1], X16
    FMOV  D24, X5
    FMOV  V24.D[1], X2
    FMOV  D25, X8
    FMOV  V25.D[1], X23
    FMOV  D26, X10
    FMOV  V26.D[1], X19
    FMOV  D27, X4
    FMOV  V27.D[1], X18
    FMOV  D28, X12
    FMOV  V28.D[1], X5
    FMOV  D29, X3
    FMOV  V29.D[1], X4
    FMOV  D30, X17
    FMOV  V30.D[1], X20
    FMOV  D31, X11
    FMOV  V31.D[1], X13
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X7, #0x2300, LSL #0
    ADD  X18, X30, X7, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X18]
    LD3R { V15.16B, V16.16B, V17.16B }, [X18]
    ADD  X18, X18, X19, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X18]
    LD3R { V27.16B, V28.16B, V29.16B }, [X18]
    ADD  X18, X18, X19, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X18]
    LD3R { V12.2D, V13.2D, V14.2D }, [X18]
    ADD  X18, X18, X19, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X18]
    LD3R { V15.4S, V16.4S, V17.4S }, [X18]
    ADD  X18, X18, X19
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X18]
    LD3R { V7.8H, V8.8H, V9.8H }, [X18]
    ADD  X18, X18, X19
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X18]
    LD3R { V28.4H, V29.4H, V30.4H }, [X18]
    ADD  X18, X18, X19
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X18]
    LD3R { V29.1D, V30.1D, V31.1D }, [X18]
    ADD  X18, X18, X19, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X18]
    LD3R { V13.2S, V14.2S, V15.2S }, [X18]
    ADD  X18, X18, X19, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X18]
    LD3R { V23.4H, V24.4H, V25.4H }, [X18]
    ADD  X18, X18, X19, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X18]
    LD3R { V19.8B, V20.8B, V21.8B }, [X18]
    ADD  X18, X18, X19, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X18]
    MOV  X26, X18
    LD3R { V10.2S, V11.2S, V12.2S }, [X26], #12
    ADD  X18, X18, X19, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X18]
    MOV  X26, X18
    LD3R { V4.2S, V5.2S, V6.2S }, [X26], #12
    ADD  X18, X18, X19, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X18]
    MOV  X26, X18
    LD3R { V31.4S, V0.4S, V1.4S }, [X26], #12
    ADD  X18, X18, X19, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X18]
    MOV  X26, X18
    LD3R { V28.1D, V29.1D, V30.1D }, [X26], #24
    ADD  X18, X18, X19, ASR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X18]
    MOV  X26, X18
    LD3R { V19.1D, V20.1D, V21.1D }, [X26], #24
    ADD  X18, X18, X19
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X18]
    MOV  X26, X18
    LD3R { V26.2D, V27.2D, V28.2D }, [X26], #24
    ADD  X18, X18, X19, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X18]
    MOV  X26, X18
    LD3R { V11.16B, V12.16B, V13.16B }, [X26], #3
    ADD  X18, X18, X19, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X18]
    MOV  X26, X18
    LD3R { V31.16B, V0.16B, V1.16B }, [X26], #3
    ADD  X18, X18, X19, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X18]
    MOV  X26, X18
    LD3R { V18.8B, V19.8B, V20.8B }, [X26], #3
    ADD  X18, X18, X19, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X18]
    MOV  X26, X18
    LD3R { V29.4H, V30.4H, V31.4H }, [X26], #6
    ADD  X18, X18, X19
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X18]
    MOV  X26, X18
    LD3R { V28.8H, V29.8H, V30.8H }, [X26], #6
    ADD  X18, X18, X19, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X18]
    MOV  X26, X18
    LD3R { V18.4H, V19.4H, V20.4H }, [X26], #6
    ADD  X18, X18, X19, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X18]
    LD3R { V30.16B, V31.16B, V0.16B }, [X18], X13
    ADD  X18, X18, X19
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X18]
    LD3R { V17.16B, V18.16B, V19.16B }, [X18], X13
    ADD  X18, X18, X19, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X18]
    LD3R { V28.2D, V29.2D, V30.2D }, [X18], X13
    ADD  X18, X18, X19, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X18]
    LD3R { V18.4S, V19.4S, V20.4S }, [X18], X13
    ADD  X18, X18, X19, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X18]
    LD3R { V26.8H, V27.8H, V28.8H }, [X18], X13
    ADD  X18, X18, X19
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X18]
    LD3R { V0.4H, V1.4H, V2.4H }, [X18], X13
    ADD  X18, X18, X19, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X18]
    LD3R { V2.1D, V3.1D, V4.1D }, [X18], X13
    ADD  X18, X18, X19, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X18]
    LD3R { V1.2S, V2.2S, V3.2S }, [X18], X13
    ADD  X18, X18, X19
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X18]
    LD3R { V15.4H, V16.4H, V17.4H }, [X18], X13
    ADD  X18, X18, X19
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X18]
    LD3R { V1.8B, V2.8B, V3.8B }, [X18], X13
    ADD  X18, X18, X19, LSR #0
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X5, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X2, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D1
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D2
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D3
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D4
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D5
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D6
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D7
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D8
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D9
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D10
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D11
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D12
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D13
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D14
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D15
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D16
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D17
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D18
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D19
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D20
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D21
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D22
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D23
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D24
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D25
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D26
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D27
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D28
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D29
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D30
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X2, D31
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X21, X5, X2
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
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X21
    FMOV  D1, X22
    FMOV  V1.D[1], X18
    FMOV  D2, X8
    FMOV  V2.D[1], X19
    FMOV  D3, X2
    FMOV  V3.D[1], X23
    FMOV  D4, X16
    FMOV  V4.D[1], X22
    FMOV  D5, X3
    FMOV  V5.D[1], X20
    FMOV  D6, X14
    FMOV  V6.D[1], X18
    FMOV  D7, X8
    FMOV  V7.D[1], X22
    FMOV  D8, X2
    FMOV  V8.D[1], X5
    FMOV  D9, X14
    FMOV  V9.D[1], X2
    FMOV  D10, X6
    FMOV  V10.D[1], X18
    FMOV  D11, X5
    FMOV  V11.D[1], X22
    FMOV  D12, X9
    FMOV  V12.D[1], X17
    FMOV  D13, X9
    FMOV  V13.D[1], X8
    FMOV  D14, X13
    FMOV  V14.D[1], X7
    FMOV  D15, X7
    FMOV  V15.D[1], X22
    FMOV  D16, X16
    FMOV  V16.D[1], X7
    FMOV  D17, X15
    FMOV  V17.D[1], X12
    FMOV  D18, X9
    FMOV  V18.D[1], X15
    FMOV  D19, X5
    FMOV  V19.D[1], X6
    FMOV  D20, X2
    FMOV  V20.D[1], X23
    FMOV  D21, X26
    FMOV  V21.D[1], X14
    FMOV  D22, X4
    FMOV  V22.D[1], X13
    FMOV  D23, X20
    FMOV  V23.D[1], X13
    FMOV  D24, X22
    FMOV  V24.D[1], X13
    FMOV  D25, X13
    FMOV  V25.D[1], X14
    FMOV  D26, X15
    FMOV  V26.D[1], X15
    FMOV  D27, X6
    FMOV  V27.D[1], X3
    FMOV  D28, X8
    FMOV  V28.D[1], X7
    FMOV  D29, X22
    FMOV  V29.D[1], X12
    FMOV  D30, X26
    FMOV  V30.D[1], X19
    FMOV  D31, X17
    FMOV  V31.D[1], X11
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X21, #0x2800, LSL #0
    ADD  X14, X30, X21, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X14]
    LD3R { V5.8H, V6.8H, V7.8H }, [X14]
    ADD  X14, X14, X20
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    LD3R { V2.16B, V3.16B, V4.16B }, [X14]
    ADD  X14, X14, X20
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X14]
    LD3R { V4.2D, V5.2D, V6.2D }, [X14]
    ADD  X14, X14, X20
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    LD3R { V25.4S, V26.4S, V27.4S }, [X14]
    ADD  X14, X14, X20
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X14]
    LD3R { V13.8H, V14.8H, V15.8H }, [X14]
    ADD  X14, X14, X20, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X14]
    LD3R { V11.1D, V12.1D, V13.1D }, [X14]
    ADD  X14, X14, X20, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X14]
    LD3R { V30.1D, V31.1D, V0.1D }, [X14]
    ADD  X14, X14, X20, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X14]
    LD3R { V12.2S, V13.2S, V14.2S }, [X14]
    ADD  X14, X14, X20
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X14]
    LD3R { V11.4H, V12.4H, V13.4H }, [X14]
    ADD  X14, X14, X20, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X14]
    LD3R { V22.8B, V23.8B, V24.8B }, [X14]
    ADD  X14, X14, X20, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X14]
    MOV  X7, X14
    LD3R { V30.2S, V31.2S, V0.2S }, [X7], #12
    ADD  X14, X14, X20, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X14]
    MOV  X7, X14
    LD3R { V0.2S, V1.2S, V2.2S }, [X7], #12
    ADD  X14, X14, X20
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X14]
    MOV  X7, X14
    LD3R { V30.4S, V31.4S, V0.4S }, [X7], #12
    ADD  X14, X14, X20, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X14]
    MOV  X7, X14
    LD3R { V25.2D, V26.2D, V27.2D }, [X7], #24
    ADD  X14, X14, X20, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X14]
    MOV  X7, X14
    LD3R { V12.1D, V13.1D, V14.1D }, [X7], #24
    ADD  X14, X14, X20, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    MOV  X7, X14
    LD3R { V21.2D, V22.2D, V23.2D }, [X7], #24
    ADD  X14, X14, X20
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X14]
    MOV  X7, X14
    LD3R { V20.8B, V21.8B, V22.8B }, [X7], #3
    ADD  X14, X14, X20, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X14]
    MOV  X7, X14
    LD3R { V12.16B, V13.16B, V14.16B }, [X7], #3
    ADD  X14, X14, X20, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X14]
    MOV  X7, X14
    LD3R { V8.8B, V9.8B, V10.8B }, [X7], #3
    ADD  X14, X14, X20, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X14]
    MOV  X7, X14
    LD3R { V25.4H, V26.4H, V27.4H }, [X7], #6
    ADD  X14, X14, X20, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X14]
    MOV  X7, X14
    LD3R { V5.8H, V6.8H, V7.8H }, [X7], #6
    ADD  X14, X14, X20, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X14]
    MOV  X7, X14
    LD3R { V6.4H, V7.4H, V8.4H }, [X7], #6
    ADD  X14, X14, X20, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X14]
    LD3R { V10.8H, V11.8H, V12.8H }, [X14], X10
    ADD  X14, X14, X20, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X14]
    LD3R { V21.16B, V22.16B, V23.16B }, [X14], X10
    ADD  X14, X14, X20, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X14]
    LD3R { V0.2D, V1.2D, V2.2D }, [X14], X10
    ADD  X14, X14, X20
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X14]
    LD3R { V15.4S, V16.4S, V17.4S }, [X14], X10
    ADD  X14, X14, X20
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X14]
    LD3R { V6.8H, V7.8H, V8.8H }, [X14], X10
    ADD  X14, X14, X20, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X14]
    LD3R { V27.8B, V28.8B, V29.8B }, [X14], X10
    ADD  X14, X14, X20
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X14]
    LD3R { V25.1D, V26.1D, V27.1D }, [X14], X10
    ADD  X14, X14, X20
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X14]
    LD3R { V20.2S, V21.2S, V22.2S }, [X14], X10
    ADD  X14, X14, X20
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X14]
    LD3R { V21.4H, V22.4H, V23.4H }, [X14], X10
    ADD  X14, X14, X20, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X14]
    LD3R { V29.8B, V30.8B, V31.8B }, [X14], X10
    ADD  X14, X14, X20, LSR #0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X22, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D1
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D2
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D3
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D4
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D5
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D6
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D7
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D8
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D9
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D10
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D11
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D12
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D13
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D14
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D15
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D16
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D17
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D18
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D19
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D20
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D21
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D22
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D23
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D24
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D25
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D26
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D27
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D28
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D29
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D30
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D31
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X19, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X21
    FMOV  D1, X22
    FMOV  V1.D[1], X2
    FMOV  D2, X23
    FMOV  V2.D[1], X19
    FMOV  D3, X26
    FMOV  V3.D[1], X6
    FMOV  D4, X19
    FMOV  V4.D[1], X10
    FMOV  D5, X12
    FMOV  V5.D[1], X14
    FMOV  D6, X15
    FMOV  V6.D[1], X10
    FMOV  D7, X4
    FMOV  V7.D[1], X7
    FMOV  D8, X6
    FMOV  V8.D[1], X26
    FMOV  D9, X21
    FMOV  V9.D[1], X19
    FMOV  D10, X10
    FMOV  V10.D[1], X23
    FMOV  D11, X3
    FMOV  V11.D[1], X5
    FMOV  D12, X5
    FMOV  V12.D[1], X15
    FMOV  D13, X20
    FMOV  V13.D[1], X17
    FMOV  D14, X13
    FMOV  V14.D[1], X19
    FMOV  D15, X19
    FMOV  V15.D[1], X12
    FMOV  D16, X22
    FMOV  V16.D[1], X17
    FMOV  D17, X13
    FMOV  V17.D[1], X20
    FMOV  D18, X3
    FMOV  V18.D[1], X14
    FMOV  D19, X20
    FMOV  V19.D[1], X19
    FMOV  D20, X2
    FMOV  V20.D[1], X5
    FMOV  D21, X8
    FMOV  V21.D[1], X13
    FMOV  D22, X2
    FMOV  V22.D[1], X18
    FMOV  D23, X12
    FMOV  V23.D[1], X21
    FMOV  D24, X18
    FMOV  V24.D[1], X23
    FMOV  D25, X13
    FMOV  V25.D[1], X3
    FMOV  D26, X16
    FMOV  V26.D[1], X23
    FMOV  D27, X11
    FMOV  V27.D[1], X3
    FMOV  D28, X22
    FMOV  V28.D[1], X5
    FMOV  D29, X6
    FMOV  V29.D[1], X5
    FMOV  D30, X20
    FMOV  V30.D[1], X14
    FMOV  D31, X15
    FMOV  V31.D[1], X19
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X6, #0x2d00, LSL #0
    ADD  X11, X30, X6, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X11]
    LD3R { V0.4S, V1.4S, V2.4S }, [X11]
    ADD  X11, X11, X14
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X11]
    LD3R { V20.16B, V21.16B, V22.16B }, [X11]
    ADD  X11, X11, X14
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X11]
    LD3R { V3.2D, V4.2D, V5.2D }, [X11]
    ADD  X11, X11, X14
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X11]
    LD3R { V13.4S, V14.4S, V15.4S }, [X11]
    ADD  X11, X11, X14, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X11]
    LD3R { V6.8H, V7.8H, V8.8H }, [X11]
    ADD  X11, X11, X14, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X11]
    LD3R { V29.1D, V30.1D, V31.1D }, [X11]
    ADD  X11, X11, X14, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X11]
    LD3R { V3.1D, V4.1D, V5.1D }, [X11]
    ADD  X11, X11, X14
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X11]
    LD3R { V21.2S, V22.2S, V23.2S }, [X11]
    ADD  X11, X11, X14, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X11]
    LD3R { V0.4H, V1.4H, V2.4H }, [X11]
    ADD  X11, X11, X14, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X11]
    LD3R { V22.8B, V23.8B, V24.8B }, [X11]
    ADD  X11, X11, X14
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X11]
    MOV  X12, X11
    LD3R { V8.2S, V9.2S, V10.2S }, [X12], #12
    ADD  X11, X11, X14, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X11]
    MOV  X12, X11
    LD3R { V1.2S, V2.2S, V3.2S }, [X12], #12
    ADD  X11, X11, X14, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X11]
    MOV  X12, X11
    LD3R { V24.4S, V25.4S, V26.4S }, [X12], #12
    ADD  X11, X11, X14, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X11]
    MOV  X12, X11
    LD3R { V15.2D, V16.2D, V17.2D }, [X12], #24
    ADD  X11, X11, X14, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X11]
    MOV  X12, X11
    LD3R { V30.1D, V31.1D, V0.1D }, [X12], #24
    ADD  X11, X11, X14
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X11]
    MOV  X12, X11
    LD3R { V31.2D, V0.2D, V1.2D }, [X12], #24
    ADD  X11, X11, X14
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X11]
    MOV  X12, X11
    LD3R { V14.8B, V15.8B, V16.8B }, [X12], #3
    ADD  X11, X11, X14, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X11]
    MOV  X12, X11
    LD3R { V20.16B, V21.16B, V22.16B }, [X12], #3
    ADD  X11, X11, X14
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X11]
    MOV  X12, X11
    LD3R { V25.8B, V26.8B, V27.8B }, [X12], #3
    ADD  X11, X11, X14, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X11]
    MOV  X12, X11
    LD3R { V7.4H, V8.4H, V9.4H }, [X12], #6
    ADD  X11, X11, X14, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X11]
    MOV  X12, X11
    LD3R { V1.8H, V2.8H, V3.8H }, [X12], #6
    ADD  X11, X11, X14
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X11]
    MOV  X12, X11
    LD3R { V24.8H, V25.8H, V26.8H }, [X12], #6
    ADD  X11, X11, X14, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X11]
    LD3R { V14.8H, V15.8H, V16.8H }, [X11], X9
    ADD  X11, X11, X14, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X11]
    LD3R { V12.16B, V13.16B, V14.16B }, [X11], X9
    ADD  X11, X11, X14, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X11]
    LD3R { V1.2D, V2.2D, V3.2D }, [X11], X9
    ADD  X11, X11, X14, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X11]
    LD3R { V26.4S, V27.4S, V28.4S }, [X11], X9
    ADD  X11, X11, X14, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X11]
    LD3R { V16.8H, V17.8H, V18.8H }, [X11], X9
    ADD  X11, X11, X14, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X11]
    LD3R { V9.2S, V10.2S, V11.2S }, [X11], X9
    ADD  X11, X11, X14, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X11]
    LD3R { V9.1D, V10.1D, V11.1D }, [X11], X9
    ADD  X11, X11, X14, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X11]
    LD3R { V28.2S, V29.2S, V30.2S }, [X11], X9
    ADD  X11, X11, X14
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X11]
    LD3R { V17.4H, V18.4H, V19.4H }, [X11], X9
    ADD  X11, X11, X14, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X11]
    LD3R { V12.8B, V13.8B, V14.8B }, [X11], X9
    ADD  X11, X11, X14, LSR #0
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X10, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MRS  X22, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D1
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D2
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D3
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D4
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D5
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D6
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D7
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D8
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D9
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D10
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D11
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D12
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D13
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D14
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D15
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D16
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D17
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D18
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D19
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D20
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D21
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D22
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D23
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D24
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D25
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D26
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D27
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D28
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D29
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D30
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    FMOV  X22, D31
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X18, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail

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
