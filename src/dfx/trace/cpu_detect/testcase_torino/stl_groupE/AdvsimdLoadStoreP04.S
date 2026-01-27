.global AdvsimdLoadStoreP04

.text
.p2align 4

AdvsimdLoadStoreP04:

AdvsimdLoadStoreP04_TestBegin:
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
    MOVZ  X5, #0x96c5, LSL #0
    MOVK  X5, #0xa6, LSL #16
    MOVK  X5, #0xdb66, LSL #32
    MOVK  X5, #0x679, LSL #48
    MOVZ  X6, #0xe899, LSL #0
    MOVK  X6, #0xf6d0, LSL #16
    MOVK  X6, #0x7f8c, LSL #32
    MOVK  X6, #0x51a2, LSL #48
    MOVZ  X7, #0x8bf0, LSL #0
    MOVK  X7, #0x6a0d, LSL #16
    MOVK  X7, #0xe3c6, LSL #32
    MOVK  X7, #0x1a0e, LSL #48
    MOVZ  X8, #0xc4a8, LSL #0
    MOVK  X8, #0x383a, LSL #16
    MOVK  X8, #0xd26a, LSL #32
    MOVK  X8, #0x6993, LSL #48
    MOVZ  X9, #0x6eb9, LSL #0
    MOVK  X9, #0xada7, LSL #16
    MOVK  X9, #0x2e85, LSL #32
    MOVK  X9, #0x97d7, LSL #48
    MOVZ  X10, #0x777a, LSL #0
    MOVK  X10, #0x1dd4, LSL #16
    MOVK  X10, #0x616d, LSL #32
    MOVK  X10, #0x9acd, LSL #48
    MOVZ  X11, #0xe47e, LSL #0
    MOVK  X11, #0x61ae, LSL #16
    MOVK  X11, #0x5aa2, LSL #32
    MOVK  X11, #0xbd63, LSL #48
    MOVZ  X12, #0x7c62, LSL #0
    MOVK  X12, #0xd18b, LSL #16
    MOVK  X12, #0xba06, LSL #32
    MOVK  X12, #0x29bf, LSL #48
    MOVZ  X13, #0x1e12, LSL #0
    MOVK  X13, #0x616b, LSL #16
    MOVK  X13, #0xb467, LSL #32
    MOVK  X13, #0xdbdc, LSL #48
    MOVZ  X14, #0x8b6e, LSL #0
    MOVK  X14, #0x366b, LSL #16
    MOVK  X14, #0xd3bd, LSL #32
    MOVK  X14, #0x973b, LSL #48
    MOVZ  X15, #0x654b, LSL #0
    MOVK  X15, #0xe294, LSL #16
    MOVK  X15, #0x42f4, LSL #32
    MOVK  X15, #0x9940, LSL #48
    MOVZ  X16, #0x623d, LSL #0
    MOVK  X16, #0xb1e6, LSL #16
    MOVK  X16, #0x166d, LSL #32
    MOVK  X16, #0x1426, LSL #48
    MOVZ  X17, #0xc89e, LSL #0
    MOVK  X17, #0x50a7, LSL #16
    MOVK  X17, #0x5e9f, LSL #32
    MOVK  X17, #0xca89, LSL #48
    MOVZ  X18, #0x8c1b, LSL #0
    MOVK  X18, #0x551, LSL #16
    MOVK  X18, #0xa5c8, LSL #32
    MOVK  X18, #0x2f46, LSL #48
    MOVZ  X19, #0x8034, LSL #0
    MOVK  X19, #0x95b1, LSL #16
    MOVK  X19, #0x2141, LSL #32
    MOVK  X19, #0xbcb1, LSL #48
    MOVZ  X20, #0xfcf4, LSL #0
    MOVK  X20, #0x2429, LSL #16
    MOVK  X20, #0x3906, LSL #32
    MOVK  X20, #0xc191, LSL #48
    MOVZ  X21, #0xd5a4, LSL #0
    MOVK  X21, #0xeffe, LSL #16
    MOVK  X21, #0x76e0, LSL #32
    MOVK  X21, #0x8010, LSL #48
    MOVZ  X22, #0x41b4, LSL #0
    MOVK  X22, #0x90ff, LSL #16
    MOVK  X22, #0x6b26, LSL #32
    MOVK  X22, #0xad75, LSL #48
    MOVZ  X23, #0xa5ed, LSL #0
    MOVK  X23, #0xd8bc, LSL #16
    MOVK  X23, #0x9247, LSL #32
    MOVK  X23, #0x16ca, LSL #48
    MOVZ  X24, #0x116a, LSL #0
    MOVK  X24, #0x2c1, LSL #16
    MOVK  X24, #0xf39e, LSL #32
    MOVK  X24, #0x25c8, LSL #48
    MOVZ  X25, #0xbe5b, LSL #0
    MOVK  X25, #0x2264, LSL #16
    MOVK  X25, #0x68d, LSL #32
    MOVK  X25, #0x78a6, LSL #48
    MOVZ  X26, #0x6248, LSL #0
    MOVK  X26, #0xae86, LSL #16
    MOVK  X26, #0x2c9b, LSL #32
    MOVK  X26, #0xd2e, LSL #48
    MOVZ  X27, #0xd0e, LSL #0
    MOVK  X27, #0xd7b5, LSL #16
    MOVK  X27, #0xe269, LSL #32
    MOVK  X27, #0x9738, LSL #48
    MOVZ  X28, #0xf1b1, LSL #0
    MOVK  X28, #0x261a, LSL #16
    MOVK  X28, #0xfe0d, LSL #32
    MOVK  X28, #0xfec5, LSL #48
    MOVZ  X29, #0x38ae, LSL #0
    MOVK  X29, #0xff66, LSL #16
    MOVK  X29, #0xf0ea, LSL #32
    MOVK  X29, #0x27b3, LSL #48
    MOVZ  X18, #0xf37c, LSL #0
    MOVK  X18, #0x65bd, LSL #16
    MOVK  X18, #0x162c, LSL #32
    MOVK  X18, #0x2bc5, LSL #48
    MSR  FPCR, X18
    MRS  X6, FPCR
    MOVZ  X25, #0x60ff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    AND  X6, X6, X25
    MOVZ  X25, #0x0, LSL #0
    ORR  X6, X6, X25
    MSR  FPCR, X6
    ISB  SY
    MOVZ  X18, #0x4b60, LSL #0
    MOVK  X18, #0x46f0, LSL #16
    MOVK  X18, #0xf590, LSL #32
    MOVK  X18, #0x8266, LSL #48
    MSR  FPSR, X18
    MRS  X14, FPSR
    MOVZ  X24, #0xff60, LSL #0
    MOVK  X24, #0x7ff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    AND  X14, X14, X24
    MOVZ  X24, #0x0, LSL #0
    ORR  X14, X14, X24
    MSR  FPSR, X14
    ISB  SY
    ADDS  W10, W6, W22, LSL #20
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
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
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X18
    FMOV  D3, X27
    FMOV  V3.D[1], X21
    FMOV  D4, X10
    FMOV  V4.D[1], X22
    FMOV  D5, X14
    FMOV  V5.D[1], X23
    FMOV  D6, X9
    FMOV  V6.D[1], X18
    FMOV  D7, X20
    FMOV  V7.D[1], X14
    FMOV  D8, X25
    FMOV  V8.D[1], X13
    FMOV  D9, X23
    FMOV  V9.D[1], X9
    FMOV  D10, X26
    FMOV  V10.D[1], X27
    FMOV  D11, X7
    FMOV  V11.D[1], X10
    FMOV  D12, X14
    FMOV  V12.D[1], X17
    FMOV  D13, X28
    FMOV  V13.D[1], X6
    FMOV  D14, X27
    FMOV  V14.D[1], X25
    FMOV  D15, X26
    FMOV  V15.D[1], X15
    FMOV  D16, X20
    FMOV  V16.D[1], X19
    FMOV  D17, X29
    FMOV  V17.D[1], X17
    FMOV  D18, X11
    FMOV  V18.D[1], X21
    FMOV  D19, X27
    FMOV  V19.D[1], X23
    FMOV  D20, X21
    FMOV  V20.D[1], X12
    FMOV  D21, X24
    FMOV  V21.D[1], X20
    FMOV  D22, X23
    FMOV  V22.D[1], X26
    FMOV  D23, X22
    FMOV  V23.D[1], X15
    FMOV  D24, X19
    FMOV  V24.D[1], X28
    FMOV  D25, X26
    FMOV  V25.D[1], X22
    FMOV  D26, X26
    FMOV  V26.D[1], X18
    FMOV  D27, X5
    FMOV  V27.D[1], X18
    FMOV  D28, X23
    FMOV  V28.D[1], X10
    FMOV  D29, X21
    FMOV  V29.D[1], X29
    FMOV  D30, X27
    FMOV  V30.D[1], X22
    FMOV  D31, X12
    FMOV  V31.D[1], X25
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X26, #0x0, LSL #0
    ADD  X11, X30, X26
    MOV  X21, X11
    ST1 { V24.16B, V25.16B }, [X21], #32
    MOV  X21, X11
    LD1 { V28.16B, V29.16B }, [X21], #32
    ADD  X11, X11, X29, LSR #0
    MOV  X21, X11
    ST1 { V1.2D, V2.2D }, [X21], #32
    MOV  X21, X11
    LD1 { V31.2D, V0.2D }, [X21], #32
    ADD  X11, X11, X29
    MOV  X21, X11
    ST1 { V27.4S, V28.4S }, [X21], #32
    MOV  X21, X11
    LD1 { V24.4S, V25.4S }, [X21], #32
    ADD  X11, X11, X29
    MOV  X21, X11
    ST1 { V31.8H, V0.8H }, [X21], #32
    MOV  X21, X11
    LD1 { V1.8H, V2.8H }, [X21], #32
    ADD  X11, X11, X29
    MOV  X21, X11
    ST1 { V17.4H, V18.4H }, [X21], #16
    MOV  X21, X11
    LD1 { V16.1D, V17.1D }, [X21], #16
    ADD  X11, X11, X29, ASR #0
    MOV  X21, X11
    ST1 { V7.1D, V8.1D }, [X21], #16
    MOV  X21, X11
    LD1 { V11.1D, V12.1D }, [X21], #16
    ADD  X11, X11, X29
    MOV  X21, X11
    ST1 { V1.2S, V2.2S }, [X21], #16
    MOV  X21, X11
    LD1 { V30.2S, V31.2S }, [X21], #16
    ADD  X11, X11, X29, LSR #0
    MOV  X21, X11
    ST1 { V11.4H, V12.4H }, [X21], #16
    MOV  X21, X11
    LD1 { V16.4H, V17.4H }, [X21], #16
    ADD  X11, X11, X29, ASR #0
    MOV  X21, X11
    ST1 { V16.8B, V17.8B }, [X21], #16
    MOV  X21, X11
    LD1 { V11.8B, V12.8B }, [X21], #16
    ADD  X11, X11, X29, LSR #0
    ST1 { V9.4S, V10.4S }, [X11], X6
    LD1 { V23.4S, V24.4S }, [X11], X6
    ADD  X11, X11, X29, ASR #0
    ST1 { V11.16B, V12.16B }, [X11], X6
    LD1 { V21.16B, V22.16B }, [X11], X6
    ADD  X11, X11, X29, LSR #0
    ST1 { V30.2D, V31.2D }, [X11], X6
    LD1 { V5.2D, V6.2D }, [X11], X6
    ADD  X11, X11, X29, ASR #0
    ST1 { V17.4S, V18.4S }, [X11], X6
    LD1 { V11.4S, V12.4S }, [X11], X6
    ADD  X11, X11, X29, LSR #0
    ST1 { V21.8H, V22.8H }, [X11], X6
    LD1 { V29.8H, V30.8H }, [X11], X6
    ADD  X11, X11, X29, LSR #0
    ST1 { V22.4H, V23.4H }, [X11], X6
    LD1 { V13.4H, V14.4H }, [X11], X6
    ADD  X11, X11, X29, LSR #0
    ST1 { V0.1D, V1.1D }, [X11], X6
    LD1 { V23.1D, V24.1D }, [X11], X6
    ADD  X11, X11, X29, ASR #0
    ST1 { V11.2S, V12.2S }, [X11], X6
    LD1 { V30.2S, V31.2S }, [X11], X6
    ADD  X11, X11, X29, LSR #0
    ST1 { V23.4H, V24.4H }, [X11], X6
    LD1 { V6.4H, V7.4H }, [X11], X6
    ADD  X11, X11, X29, ASR #0
    ST1 { V6.8B, V7.8B }, [X11], X6
    LD1 { V23.8B, V24.8B }, [X11], X6
    ADD  X11, X11, X29, LSR #0
    ST1 { V5.H }[0x7], [X11]
    LD1 { V11.H }[0x4], [X11]
    ADD  X11, X11, X29
    ST1 { V12.S }[0x2], [X11]
    LD1 { V7.S }[0x0], [X11]
    ADD  X11, X11, X29, LSR #0
    ST1 { V7.D }[0x0], [X11]
    LD1 { V12.D }[0x1], [X11]
    ADD  X11, X11, X29
    ST1 { V23.B }[0x2], [X11]
    LD1 { V14.B }[0x8], [X11]
    ADD  X11, X11, X29, ASR #0
    MOV  X21, X11
    ST1 { V14.H }[0x6], [X21], #2
    MOV  X21, X11
    LD1 { V14.H }[0x0], [X21], #2
    ADD  X11, X11, X29
    ST1 { V24.H }[0x6], [X11], X6
    LD1 { V5.H }[0x7], [X11], X6
    ADD  X11, X11, X29, LSR #0
    MOV  X21, X11
    ST1 { V11.S }[0x3], [X21], #4
    MOV  X21, X11
    LD1 { V23.S }[0x2], [X21], #4
    ADD  X11, X11, X29
    ST1 { V5.S }[0x3], [X11], X6
    LD1 { V26.S }[0x2], [X11], X6
    ADD  X11, X11, X29, ASR #0
    MOV  X21, X11
    ST1 { V24.D }[0x0], [X21], #8
    MOV  X21, X11
    LD1 { V11.D }[0x1], [X21], #8
    ADD  X11, X11, X29, ASR #0
    ST1 { V11.D }[0x1], [X11], X6
    LD1 { V5.D }[0x1], [X11], X6
    ADD  X11, X11, X29
    MOV  X21, X11
    ST1 { V23.B }[0x3], [X21], #1
    MOV  X21, X11
    LD1 { V7.B }[0x0], [X21], #1
    ADD  X11, X11, X29
    ST1 { V3.B }[0xb], [X11], X6
    LD1 { V24.B }[0x8], [X11], X6
    ADD  X11, X11, X29, LSR #0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X18, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MRS  X5, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D1
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D2
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D3
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D4
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D5
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D6
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D7
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D8
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D9
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D10
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D11
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D12
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D13
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X18, #0x5a, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D14
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D15
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D16
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D17
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D18
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D19
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D20
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D21
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D22
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D23
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X18, #0x5a, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D24
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D25
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D26
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D27
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D28
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D29
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D30
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D31
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X22, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X28
    FMOV  V3.D[1], X23
    FMOV  D4, X28
    FMOV  V4.D[1], X28
    FMOV  D5, X15
    FMOV  V5.D[1], X21
    FMOV  D6, X6
    FMOV  V6.D[1], X5
    FMOV  D7, X26
    FMOV  V7.D[1], X16
    FMOV  D8, X27
    FMOV  V8.D[1], X28
    FMOV  D9, X5
    FMOV  V9.D[1], X9
    FMOV  D10, X14
    FMOV  V10.D[1], X19
    FMOV  D11, X9
    FMOV  V11.D[1], X6
    FMOV  D12, X8
    FMOV  V12.D[1], X20
    FMOV  D13, X26
    FMOV  V13.D[1], X20
    FMOV  D14, X7
    FMOV  V14.D[1], X18
    FMOV  D15, X19
    FMOV  V15.D[1], X5
    FMOV  D16, X28
    FMOV  V16.D[1], X22
    FMOV  D17, X24
    FMOV  V17.D[1], X5
    FMOV  D18, X18
    FMOV  V18.D[1], X9
    FMOV  D19, X6
    FMOV  V19.D[1], X7
    FMOV  D20, X8
    FMOV  V20.D[1], X19
    FMOV  D21, X22
    FMOV  V21.D[1], X7
    FMOV  D22, X15
    FMOV  V22.D[1], X26
    FMOV  D23, X23
    FMOV  V23.D[1], X20
    FMOV  D24, X5
    FMOV  V24.D[1], X10
    FMOV  D25, X6
    FMOV  V25.D[1], X7
    FMOV  D26, X6
    FMOV  V26.D[1], X26
    FMOV  D27, X23
    FMOV  V27.D[1], X8
    FMOV  D28, X23
    FMOV  V28.D[1], X20
    FMOV  D29, X15
    FMOV  V29.D[1], X18
    FMOV  D30, X15
    FMOV  V30.D[1], X23
    FMOV  D31, X17
    FMOV  V31.D[1], X8
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X26, #0x500, LSL #0
    ADD  X20, X30, X26, LSR #0
    MOV  X7, X20
    ST1 { V13.16B, V14.16B }, [X7], #32
    MOV  X7, X20
    LD1 { V5.16B, V6.16B }, [X7], #32
    ADD  X20, X20, X29
    MOV  X7, X20
    ST1 { V28.2D, V29.2D }, [X7], #32
    MOV  X7, X20
    LD1 { V8.2D, V9.2D }, [X7], #32
    ADD  X20, X20, X29
    MOV  X7, X20
    ST1 { V30.4S, V31.4S }, [X7], #32
    MOV  X7, X20
    LD1 { V16.4S, V17.4S }, [X7], #32
    ADD  X20, X20, X29, ASR #0
    MOV  X7, X20
    ST1 { V20.8H, V21.8H }, [X7], #32
    MOV  X7, X20
    LD1 { V28.8H, V29.8H }, [X7], #32
    ADD  X20, X20, X29
    MOV  X7, X20
    ST1 { V21.8B, V22.8B }, [X7], #16
    MOV  X7, X20
    LD1 { V19.4H, V20.4H }, [X7], #16
    ADD  X20, X20, X29
    MOV  X7, X20
    ST1 { V19.1D, V20.1D }, [X7], #16
    MOV  X7, X20
    LD1 { V13.1D, V14.1D }, [X7], #16
    ADD  X20, X20, X29, LSR #0
    MOV  X7, X20
    ST1 { V25.2S, V26.2S }, [X7], #16
    MOV  X7, X20
    LD1 { V9.2S, V10.2S }, [X7], #16
    ADD  X20, X20, X29, LSR #0
    MOV  X7, X20
    ST1 { V21.4H, V22.4H }, [X7], #16
    MOV  X7, X20
    LD1 { V13.4H, V14.4H }, [X7], #16
    ADD  X20, X20, X29, ASR #0
    MOV  X7, X20
    ST1 { V6.8B, V7.8B }, [X7], #16
    MOV  X7, X20
    LD1 { V23.8B, V24.8B }, [X7], #16
    ADD  X20, X20, X29, LSR #0
    ST1 { V23.16B, V24.16B }, [X20], X11
    LD1 { V24.2D, V25.2D }, [X20], X11
    ADD  X20, X20, X29, LSR #0
    ST1 { V9.16B, V10.16B }, [X20], X11
    LD1 { V28.16B, V29.16B }, [X20], X11
    ADD  X20, X20, X29
    ST1 { V13.2D, V14.2D }, [X20], X11
    LD1 { V28.2D, V29.2D }, [X20], X11
    ADD  X20, X20, X29
    ST1 { V3.4S, V4.4S }, [X20], X11
    LD1 { V25.4S, V26.4S }, [X20], X11
    ADD  X20, X20, X29, ASR #0
    ST1 { V25.8H, V26.8H }, [X20], X11
    LD1 { V6.8H, V7.8H }, [X20], X11
    ADD  X20, X20, X29, ASR #0
    ST1 { V6.4H, V7.4H }, [X20], X11
    LD1 { V13.1D, V14.1D }, [X20], X11
    ADD  X20, X20, X29, ASR #0
    ST1 { V22.1D, V23.1D }, [X20], X11
    LD1 { V15.1D, V16.1D }, [X20], X11
    ADD  X20, X20, X29, ASR #0
    ST1 { V19.2S, V20.2S }, [X20], X11
    LD1 { V3.2S, V4.2S }, [X20], X11
    ADD  X20, X20, X29
    ST1 { V13.4H, V14.4H }, [X20], X11
    LD1 { V13.4H, V14.4H }, [X20], X11
    ADD  X20, X20, X29, ASR #0
    ST1 { V3.8B, V4.8B }, [X20], X11
    LD1 { V6.8B, V7.8B }, [X20], X11
    ADD  X20, X20, X29, ASR #0
    ST1 { V28.H }[0x1], [X20]
    LD1 { V17.H }[0x0], [X20]
    ADD  X20, X20, X29, ASR #0
    ST1 { V28.S }[0x2], [X20]
    LD1 { V20.S }[0x1], [X20]
    ADD  X20, X20, X29
    ST1 { V15.D }[0x1], [X20]
    LD1 { V1.D }[0x1], [X20]
    ADD  X20, X20, X29
    ST1 { V1.B }[0xe], [X20]
    LD1 { V19.B }[0x4], [X20]
    ADD  X20, X20, X29
    MOV  X7, X20
    ST1 { V17.H }[0x3], [X7], #2
    MOV  X7, X20
    LD1 { V17.H }[0x3], [X7], #2
    ADD  X20, X20, X29
    ST1 { V20.H }[0x7], [X20], X11
    LD1 { V28.H }[0x7], [X20], X11
    ADD  X20, X20, X29
    MOV  X7, X20
    ST1 { V17.S }[0x1], [X7], #4
    MOV  X7, X20
    LD1 { V20.S }[0x3], [X7], #4
    ADD  X20, X20, X29, ASR #0
    ST1 { V28.S }[0x1], [X20], X11
    LD1 { V1.S }[0x3], [X20], X11
    ADD  X20, X20, X29, LSR #0
    MOV  X7, X20
    ST1 { V19.D }[0x1], [X7], #8
    MOV  X7, X20
    LD1 { V20.D }[0x1], [X7], #8
    ADD  X20, X20, X29
    ST1 { V23.D }[0x1], [X20], X11
    LD1 { V19.D }[0x0], [X20], X11
    ADD  X20, X20, X29, ASR #0
    MOV  X7, X20
    ST1 { V29.B }[0x5], [X7], #1
    MOV  X7, X20
    LD1 { V15.B }[0xa], [X7], #1
    ADD  X20, X20, X29, ASR #0
    ST1 { V31.B }[0xd], [X20], X11
    LD1 { V28.B }[0xa], [X20], X11
    ADD  X20, X20, X29, ASR #0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MRS  X27, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D0
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D1
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D2
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D3
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D4
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D5
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D6
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D7
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D8
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D9
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D10
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D11
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D12
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D13
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D14
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa5, LSL #16
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D15
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D16
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D17
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D18
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D19
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D20
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D21
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D22
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D23
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D24
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D25
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D26
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D27
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa5, LSL #16
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D28
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D29
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D30
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X27, D31
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X6, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X18
    FMOV  D1, X14
    FMOV  V1.D[1], X27
    FMOV  D2, X6
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X5
    FMOV  D4, X29
    FMOV  V4.D[1], X27
    FMOV  D5, X25
    FMOV  V5.D[1], X5
    FMOV  D6, X26
    FMOV  V6.D[1], X27
    FMOV  D7, X14
    FMOV  V7.D[1], X10
    FMOV  D8, X27
    FMOV  V8.D[1], X24
    FMOV  D9, X5
    FMOV  V9.D[1], X15
    FMOV  D10, X9
    FMOV  V10.D[1], X9
    FMOV  D11, X24
    FMOV  V11.D[1], X12
    FMOV  D12, X8
    FMOV  V12.D[1], X11
    FMOV  D13, X28
    FMOV  V13.D[1], X27
    FMOV  D14, X21
    FMOV  V14.D[1], X7
    FMOV  D15, X5
    FMOV  V15.D[1], X21
    FMOV  D16, X24
    FMOV  V16.D[1], X16
    FMOV  D17, X18
    FMOV  V17.D[1], X21
    FMOV  D18, X26
    FMOV  V18.D[1], X12
    FMOV  D19, X5
    FMOV  V19.D[1], X14
    FMOV  D20, X23
    FMOV  V20.D[1], X17
    FMOV  D21, X26
    FMOV  V21.D[1], X27
    FMOV  D22, X15
    FMOV  V22.D[1], X27
    FMOV  D23, X13
    FMOV  V23.D[1], X9
    FMOV  D24, X7
    FMOV  V24.D[1], X14
    FMOV  D25, X10
    FMOV  V25.D[1], X27
    FMOV  D26, X14
    FMOV  V26.D[1], X25
    FMOV  D27, X14
    FMOV  V27.D[1], X6
    FMOV  D28, X20
    FMOV  V28.D[1], X13
    FMOV  D29, X26
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X29
    FMOV  D31, X16
    FMOV  V31.D[1], X14
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X24, #0xa00, LSL #0
    ADD  X6, X30, X24, LSR #0
    MOV  X26, X6
    ST1 { V27.16B, V28.16B }, [X26], #32
    MOV  X26, X6
    LD1 { V12.16B, V13.16B }, [X26], #32
    ADD  X6, X6, X10
    MOV  X26, X6
    ST1 { V0.2D, V1.2D }, [X26], #32
    MOV  X26, X6
    LD1 { V5.2D, V6.2D }, [X26], #32
    ADD  X6, X6, X10
    MOV  X26, X6
    ST1 { V12.4S, V13.4S }, [X26], #32
    MOV  X26, X6
    LD1 { V6.4S, V7.4S }, [X26], #32
    ADD  X6, X6, X10, ASR #0
    MOV  X26, X6
    ST1 { V17.8H, V18.8H }, [X26], #32
    MOV  X26, X6
    LD1 { V8.8H, V9.8H }, [X26], #32
    ADD  X6, X6, X10, ASR #0
    MOV  X26, X6
    ST1 { V8.4H, V9.4H }, [X26], #16
    MOV  X26, X6
    LD1 { V5.2S, V6.2S }, [X26], #16
    ADD  X6, X6, X10
    MOV  X26, X6
    ST1 { V5.1D, V6.1D }, [X26], #16
    MOV  X26, X6
    LD1 { V12.1D, V13.1D }, [X26], #16
    ADD  X6, X6, X10, LSR #0
    MOV  X26, X6
    ST1 { V1.2S, V2.2S }, [X26], #16
    MOV  X26, X6
    LD1 { V27.2S, V28.2S }, [X26], #16
    ADD  X6, X6, X10, LSR #0
    MOV  X26, X6
    ST1 { V8.4H, V9.4H }, [X26], #16
    MOV  X26, X6
    LD1 { V21.4H, V22.4H }, [X26], #16
    ADD  X6, X6, X10, LSR #0
    MOV  X26, X6
    ST1 { V6.8B, V7.8B }, [X26], #16
    MOV  X26, X6
    LD1 { V3.8B, V4.8B }, [X26], #16
    ADD  X6, X6, X10, ASR #0
    ST1 { V21.8H, V22.8H }, [X6], X14
    LD1 { V4.16B, V5.16B }, [X6], X14
    ADD  X6, X6, X10, ASR #0
    ST1 { V31.16B, V0.16B }, [X6], X14
    LD1 { V25.16B, V26.16B }, [X6], X14
    ADD  X6, X6, X10, ASR #0
    ST1 { V31.2D, V0.2D }, [X6], X14
    LD1 { V27.2D, V28.2D }, [X6], X14
    ADD  X6, X6, X10, ASR #0
    ST1 { V12.4S, V13.4S }, [X6], X14
    LD1 { V5.4S, V6.4S }, [X6], X14
    ADD  X6, X6, X10
    ST1 { V13.8H, V14.8H }, [X6], X14
    LD1 { V22.8H, V23.8H }, [X6], X14
    ADD  X6, X6, X10
    ST1 { V5.4H, V6.4H }, [X6], X14
    LD1 { V22.4H, V23.4H }, [X6], X14
    ADD  X6, X6, X10, LSR #0
    ST1 { V3.1D, V4.1D }, [X6], X14
    LD1 { V18.1D, V19.1D }, [X6], X14
    ADD  X6, X6, X10, ASR #0
    ST1 { V18.2S, V19.2S }, [X6], X14
    LD1 { V12.2S, V13.2S }, [X6], X14
    ADD  X6, X6, X10, LSR #0
    ST1 { V12.4H, V13.4H }, [X6], X14
    LD1 { V18.4H, V19.4H }, [X6], X14
    ADD  X6, X6, X10
    ST1 { V10.8B, V11.8B }, [X6], X14
    LD1 { V29.8B, V30.8B }, [X6], X14
    ADD  X6, X6, X10, ASR #0
    ST1 { V14.H }[0x2], [X6]
    LD1 { V7.H }[0x3], [X6]
    ADD  X6, X6, X10
    ST1 { V26.S }[0x2], [X6]
    LD1 { V14.S }[0x2], [X6]
    ADD  X6, X6, X10, LSR #0
    ST1 { V26.D }[0x1], [X6]
    LD1 { V5.D }[0x1], [X6]
    ADD  X6, X6, X10, LSR #0
    ST1 { V7.B }[0xf], [X6]
    LD1 { V25.B }[0xa], [X6]
    ADD  X6, X6, X10, LSR #0
    MOV  X26, X6
    ST1 { V25.H }[0x7], [X26], #2
    MOV  X26, X6
    LD1 { V13.H }[0x6], [X26], #2
    ADD  X6, X6, X10
    ST1 { V29.H }[0x7], [X6], X14
    LD1 { V22.H }[0x0], [X6], X14
    ADD  X6, X6, X10, LSR #0
    MOV  X26, X6
    ST1 { V13.S }[0x0], [X26], #4
    MOV  X26, X6
    LD1 { V26.S }[0x0], [X26], #4
    ADD  X6, X6, X10, LSR #0
    ST1 { V27.S }[0x3], [X6], X14
    LD1 { V7.S }[0x2], [X6], X14
    ADD  X6, X6, X10, ASR #0
    MOV  X26, X6
    ST1 { V0.D }[0x1], [X26], #8
    MOV  X26, X6
    LD1 { V25.D }[0x0], [X26], #8
    ADD  X6, X6, X10
    ST1 { V13.D }[0x0], [X6], X14
    LD1 { V29.D }[0x0], [X6], X14
    ADD  X6, X6, X10, ASR #0
    MOV  X26, X6
    ST1 { V22.B }[0x7], [X26], #1
    MOV  X26, X6
    LD1 { V0.B }[0x6], [X26], #1
    ADD  X6, X6, X10, ASR #0
    ST1 { V11.B }[0x6], [X6], X14
    LD1 { V2.B }[0x0], [X6], X14
    ADD  X6, X6, X10, ASR #0
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X9, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MRS  X11, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D1
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D2
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D3
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D4
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D5
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D6
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D7
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D8
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D9
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D10
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D11
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D12
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D13
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D14
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D15
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D16
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D17
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D18
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D19
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D20
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D21
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D22
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D23
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D24
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D25
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D26
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D27
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D28
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D29
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D30
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    FMOV  X11, D31
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D0, X9
    FMOV  V0.D[1], X25
    FMOV  D1, X7
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X17
    FMOV  D3, X28
    FMOV  V3.D[1], X27
    FMOV  D4, X17
    FMOV  V4.D[1], X28
    FMOV  D5, X22
    FMOV  V5.D[1], X15
    FMOV  D6, X14
    FMOV  V6.D[1], X10
    FMOV  D7, X27
    FMOV  V7.D[1], X26
    FMOV  D8, X19
    FMOV  V8.D[1], X28
    FMOV  D9, X22
    FMOV  V9.D[1], X7
    FMOV  D10, X13
    FMOV  V10.D[1], X20
    FMOV  D11, X10
    FMOV  V11.D[1], X19
    FMOV  D12, X12
    FMOV  V12.D[1], X22
    FMOV  D13, X15
    FMOV  V13.D[1], X15
    FMOV  D14, X10
    FMOV  V14.D[1], X10
    FMOV  D15, X23
    FMOV  V15.D[1], X6
    FMOV  D16, X17
    FMOV  V16.D[1], X10
    FMOV  D17, X9
    FMOV  V17.D[1], X14
    FMOV  D18, X17
    FMOV  V18.D[1], X29
    FMOV  D19, X20
    FMOV  V19.D[1], X29
    FMOV  D20, X28
    FMOV  V20.D[1], X27
    FMOV  D21, X25
    FMOV  V21.D[1], X27
    FMOV  D22, X11
    FMOV  V22.D[1], X7
    FMOV  D23, X20
    FMOV  V23.D[1], X28
    FMOV  D24, X16
    FMOV  V24.D[1], X15
    FMOV  D25, X26
    FMOV  V25.D[1], X29
    FMOV  D26, X14
    FMOV  V26.D[1], X7
    FMOV  D27, X13
    FMOV  V27.D[1], X7
    FMOV  D28, X10
    FMOV  V28.D[1], X25
    FMOV  D29, X6
    FMOV  V29.D[1], X7
    FMOV  D30, X18
    FMOV  V30.D[1], X7
    FMOV  D31, X26
    FMOV  V31.D[1], X14
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X18, #0xf00, LSL #0
    ADD  X24, X30, X18, ASR #0
    MOV  X29, X24
    ST1 { V18.16B, V19.16B }, [X29], #32
    MOV  X29, X24
    LD1 { V3.16B, V4.16B }, [X29], #32
    ADD  X24, X24, X12, LSR #0
    MOV  X29, X24
    ST1 { V30.2D, V31.2D }, [X29], #32
    MOV  X29, X24
    LD1 { V15.2D, V16.2D }, [X29], #32
    ADD  X24, X24, X12, LSR #0
    MOV  X29, X24
    ST1 { V5.4S, V6.4S }, [X29], #32
    MOV  X29, X24
    LD1 { V10.4S, V11.4S }, [X29], #32
    ADD  X24, X24, X12, LSR #0
    MOV  X29, X24
    ST1 { V2.8H, V3.8H }, [X29], #32
    MOV  X29, X24
    LD1 { V24.8H, V25.8H }, [X29], #32
    ADD  X24, X24, X12, LSR #0
    MOV  X29, X24
    ST1 { V2.8B, V3.8B }, [X29], #16
    MOV  X29, X24
    LD1 { V12.2S, V13.2S }, [X29], #16
    ADD  X24, X24, X12, LSR #0
    MOV  X29, X24
    ST1 { V28.1D, V29.1D }, [X29], #16
    MOV  X29, X24
    LD1 { V17.1D, V18.1D }, [X29], #16
    ADD  X24, X24, X12
    MOV  X29, X24
    ST1 { V24.2S, V25.2S }, [X29], #16
    MOV  X29, X24
    LD1 { V26.2S, V27.2S }, [X29], #16
    ADD  X24, X24, X12, ASR #0
    MOV  X29, X24
    ST1 { V7.4H, V8.4H }, [X29], #16
    MOV  X29, X24
    LD1 { V13.4H, V14.4H }, [X29], #16
    ADD  X24, X24, X12, LSR #0
    MOV  X29, X24
    ST1 { V26.8B, V27.8B }, [X29], #16
    MOV  X29, X24
    LD1 { V21.8B, V22.8B }, [X29], #16
    ADD  X24, X24, X12
    ST1 { V17.2D, V18.2D }, [X24], X10
    LD1 { V29.2D, V30.2D }, [X24], X10
    ADD  X24, X24, X12, ASR #0
    ST1 { V29.16B, V30.16B }, [X24], X10
    LD1 { V27.16B, V28.16B }, [X24], X10
    ADD  X24, X24, X12
    ST1 { V21.2D, V22.2D }, [X24], X10
    LD1 { V17.2D, V18.2D }, [X24], X10
    ADD  X24, X24, X12
    ST1 { V16.4S, V17.4S }, [X24], X10
    LD1 { V17.4S, V18.4S }, [X24], X10
    ADD  X24, X24, X12, ASR #0
    ST1 { V13.8H, V14.8H }, [X24], X10
    LD1 { V30.8H, V31.8H }, [X24], X10
    ADD  X24, X24, X12
    ST1 { V22.2S, V23.2S }, [X24], X10
    LD1 { V4.2S, V5.2S }, [X24], X10
    ADD  X24, X24, X12
    ST1 { V23.1D, V24.1D }, [X24], X10
    LD1 { V11.1D, V12.1D }, [X24], X10
    ADD  X24, X24, X12, ASR #0
    ST1 { V11.2S, V12.2S }, [X24], X10
    LD1 { V8.2S, V9.2S }, [X24], X10
    ADD  X24, X24, X12, ASR #0
    ST1 { V17.4H, V18.4H }, [X24], X10
    LD1 { V1.4H, V2.4H }, [X24], X10
    ADD  X24, X24, X12, ASR #0
    ST1 { V14.8B, V15.8B }, [X24], X10
    LD1 { V11.8B, V12.8B }, [X24], X10
    ADD  X24, X24, X12
    ST1 { V27.H }[0x3], [X24]
    LD1 { V23.H }[0x1], [X24]
    ADD  X24, X24, X12, ASR #0
    ST1 { V9.S }[0x3], [X24]
    LD1 { V18.S }[0x2], [X24]
    ADD  X24, X24, X12, LSR #0
    ST1 { V12.D }[0x0], [X24]
    LD1 { V26.D }[0x0], [X24]
    ADD  X24, X24, X12, LSR #0
    ST1 { V2.B }[0x9], [X24]
    LD1 { V31.B }[0x9], [X24]
    ADD  X24, X24, X12
    MOV  X29, X24
    ST1 { V1.H }[0x7], [X29], #2
    MOV  X29, X24
    LD1 { V12.H }[0x0], [X29], #2
    ADD  X24, X24, X12, ASR #0
    ST1 { V5.H }[0x1], [X24], X10
    LD1 { V27.H }[0x0], [X24], X10
    ADD  X24, X24, X12, ASR #0
    MOV  X29, X24
    ST1 { V23.S }[0x3], [X29], #4
    MOV  X29, X24
    LD1 { V29.S }[0x3], [X29], #4
    ADD  X24, X24, X12, ASR #0
    ST1 { V29.S }[0x2], [X24], X10
    LD1 { V2.S }[0x2], [X24], X10
    ADD  X24, X24, X12, ASR #0
    MOV  X29, X24
    ST1 { V2.D }[0x0], [X29], #8
    MOV  X29, X24
    LD1 { V1.D }[0x1], [X29], #8
    ADD  X24, X24, X12
    ST1 { V9.D }[0x1], [X24], X10
    LD1 { V1.D }[0x0], [X24], X10
    ADD  X24, X24, X12
    MOV  X29, X24
    ST1 { V3.B }[0xc], [X29], #1
    MOV  X29, X24
    LD1 { V3.B }[0x7], [X29], #1
    ADD  X24, X24, X12
    ST1 { V1.B }[0x3], [X24], X10
    LD1 { V29.B }[0x8], [X24], X10
    ADD  X24, X24, X12, ASR #0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X13, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MRS  X9, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D2
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D3
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D4
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D5
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D6
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D7
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D8
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D9
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D10
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D11
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D12
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D13
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D14
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D15
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D16
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D17
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D18
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D19
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D20
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D21
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D22
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D23
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D24
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D25
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D26
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D27
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D28
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D29
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D30
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X9, D31
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X25
    FMOV  D4, X17
    FMOV  V4.D[1], X19
    FMOV  D5, X12
    FMOV  V5.D[1], X29
    FMOV  D6, X20
    FMOV  V6.D[1], X5
    FMOV  D7, X15
    FMOV  V7.D[1], X16
    FMOV  D8, X18
    FMOV  V8.D[1], X12
    FMOV  D9, X12
    FMOV  V9.D[1], X26
    FMOV  D10, X8
    FMOV  V10.D[1], X20
    FMOV  D11, X18
    FMOV  V11.D[1], X9
    FMOV  D12, X20
    FMOV  V12.D[1], X28
    FMOV  D13, X22
    FMOV  V13.D[1], X27
    FMOV  D14, X11
    FMOV  V14.D[1], X5
    FMOV  D15, X17
    FMOV  V15.D[1], X9
    FMOV  D16, X27
    FMOV  V16.D[1], X23
    FMOV  D17, X19
    FMOV  V17.D[1], X17
    FMOV  D18, X16
    FMOV  V18.D[1], X24
    FMOV  D19, X8
    FMOV  V19.D[1], X16
    FMOV  D20, X27
    FMOV  V20.D[1], X25
    FMOV  D21, X24
    FMOV  V21.D[1], X25
    FMOV  D22, X6
    FMOV  V22.D[1], X9
    FMOV  D23, X14
    FMOV  V23.D[1], X13
    FMOV  D24, X15
    FMOV  V24.D[1], X9
    FMOV  D25, X16
    FMOV  V25.D[1], X25
    FMOV  D26, X16
    FMOV  V26.D[1], X19
    FMOV  D27, X26
    FMOV  V27.D[1], X5
    FMOV  D28, X13
    FMOV  V28.D[1], X16
    FMOV  D29, X7
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X25
    FMOV  D31, X13
    FMOV  V31.D[1], X26
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X9, #0x1400, LSL #0
    ADD  X25, X30, X9, ASR #0
    MOV  X15, X25
    ST1 { V1.16B, V2.16B }, [X15], #32
    MOV  X15, X25
    LD1 { V22.16B, V23.16B }, [X15], #32
    ADD  X25, X25, X8, ASR #0
    MOV  X15, X25
    ST1 { V27.2D, V28.2D }, [X15], #32
    MOV  X15, X25
    LD1 { V25.2D, V26.2D }, [X15], #32
    ADD  X25, X25, X8, LSR #0
    MOV  X15, X25
    ST1 { V29.4S, V30.4S }, [X15], #32
    MOV  X15, X25
    LD1 { V3.4S, V4.4S }, [X15], #32
    ADD  X25, X25, X8
    MOV  X15, X25
    ST1 { V21.8H, V22.8H }, [X15], #32
    MOV  X15, X25
    LD1 { V21.8H, V22.8H }, [X15], #32
    ADD  X25, X25, X8
    MOV  X15, X25
    ST1 { V28.1D, V29.1D }, [X15], #16
    MOV  X15, X25
    LD1 { V31.8B, V0.8B }, [X15], #16
    ADD  X25, X25, X8, ASR #0
    MOV  X15, X25
    ST1 { V29.1D, V30.1D }, [X15], #16
    MOV  X15, X25
    LD1 { V0.1D, V1.1D }, [X15], #16
    ADD  X25, X25, X8
    MOV  X15, X25
    ST1 { V0.2S, V1.2S }, [X15], #16
    MOV  X15, X25
    LD1 { V6.2S, V7.2S }, [X15], #16
    ADD  X25, X25, X8, ASR #0
    MOV  X15, X25
    ST1 { V21.4H, V22.4H }, [X15], #16
    MOV  X15, X25
    LD1 { V3.4H, V4.4H }, [X15], #16
    ADD  X25, X25, X8
    MOV  X15, X25
    ST1 { V2.8B, V3.8B }, [X15], #16
    MOV  X15, X25
    LD1 { V19.8B, V20.8B }, [X15], #16
    ADD  X25, X25, X8, ASR #0
    ST1 { V6.4S, V7.4S }, [X25], X14
    LD1 { V13.2D, V14.2D }, [X25], X14
    ADD  X25, X25, X8, ASR #0
    ST1 { V19.16B, V20.16B }, [X25], X14
    LD1 { V10.16B, V11.16B }, [X25], X14
    ADD  X25, X25, X8, LSR #0
    ST1 { V5.2D, V6.2D }, [X25], X14
    LD1 { V21.2D, V22.2D }, [X25], X14
    ADD  X25, X25, X8
    ST1 { V21.4S, V22.4S }, [X25], X14
    LD1 { V12.4S, V13.4S }, [X25], X14
    ADD  X25, X25, X8, ASR #0
    ST1 { V10.8H, V11.8H }, [X25], X14
    LD1 { V6.8H, V7.8H }, [X25], X14
    ADD  X25, X25, X8
    ST1 { V12.1D, V13.1D }, [X25], X14
    LD1 { V21.2S, V22.2S }, [X25], X14
    ADD  X25, X25, X8
    ST1 { V6.1D, V7.1D }, [X25], X14
    LD1 { V5.1D, V6.1D }, [X25], X14
    ADD  X25, X25, X8, LSR #0
    ST1 { V4.2S, V5.2S }, [X25], X14
    LD1 { V2.2S, V3.2S }, [X25], X14
    ADD  X25, X25, X8, LSR #0
    ST1 { V20.4H, V21.4H }, [X25], X14
    LD1 { V30.4H, V31.4H }, [X25], X14
    ADD  X25, X25, X8, LSR #0
    ST1 { V30.8B, V31.8B }, [X25], X14
    LD1 { V10.8B, V11.8B }, [X25], X14
    ADD  X25, X25, X8, ASR #0
    ST1 { V23.H }[0x6], [X25]
    LD1 { V31.H }[0x0], [X25]
    ADD  X25, X25, X8, ASR #0
    ST1 { V11.S }[0x1], [X25]
    LD1 { V23.S }[0x0], [X25]
    ADD  X25, X25, X8, ASR #0
    ST1 { V22.D }[0x0], [X25]
    LD1 { V21.D }[0x0], [X25]
    ADD  X25, X25, X8
    ST1 { V21.B }[0x4], [X25]
    LD1 { V7.B }[0xa], [X25]
    ADD  X25, X25, X8, ASR #0
    MOV  X15, X25
    ST1 { V31.H }[0x6], [X15], #2
    MOV  X15, X25
    LD1 { V30.H }[0x4], [X15], #2
    ADD  X25, X25, X8
    ST1 { V6.H }[0x2], [X25], X14
    LD1 { V20.H }[0x2], [X25], X14
    ADD  X25, X25, X8
    MOV  X15, X25
    ST1 { V7.S }[0x3], [X15], #4
    MOV  X15, X25
    LD1 { V6.S }[0x1], [X15], #4
    ADD  X25, X25, X8
    ST1 { V20.S }[0x2], [X25], X14
    LD1 { V30.S }[0x3], [X25], X14
    ADD  X25, X25, X8, LSR #0
    MOV  X15, X25
    ST1 { V17.D }[0x0], [X15], #8
    MOV  X15, X25
    LD1 { V31.D }[0x0], [X15], #8
    ADD  X25, X25, X8, ASR #0
    ST1 { V31.D }[0x1], [X25], X14
    LD1 { V29.D }[0x0], [X25], X14
    ADD  X25, X25, X8, LSR #0
    MOV  X15, X25
    ST1 { V6.B }[0x3], [X15], #1
    MOV  X15, X25
    LD1 { V7.B }[0x3], [X15], #1
    ADD  X25, X25, X8, LSR #0
    ST1 { V7.B }[0xa], [X25], X14
    LD1 { V31.B }[0x7], [X25], X14
    ADD  X25, X25, X8, LSR #0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    MRS  X22, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D0
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D1
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D2
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D3
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D4
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D5
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D6
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x5a, LSL #16
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D7
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D8
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D9
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D10
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D11
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D12
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D13
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D14
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D15
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D16
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D17
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D18
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D19
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D20
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D21
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D22
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D23
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D24
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D25
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D26
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D27
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D28
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D30
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    FMOV  X22, D31
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D0, X13
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X20
    FMOV  V2.D[1], X28
    FMOV  D3, X22
    FMOV  V3.D[1], X8
    FMOV  D4, X6
    FMOV  V4.D[1], X10
    FMOV  D5, X9
    FMOV  V5.D[1], X28
    FMOV  D6, X5
    FMOV  V6.D[1], X28
    FMOV  D7, X8
    FMOV  V7.D[1], X11
    FMOV  D8, X18
    FMOV  V8.D[1], X9
    FMOV  D9, X16
    FMOV  V9.D[1], X15
    FMOV  D10, X11
    FMOV  V10.D[1], X21
    FMOV  D11, X7
    FMOV  V11.D[1], X27
    FMOV  D12, X11
    FMOV  V12.D[1], X19
    FMOV  D13, X13
    FMOV  V13.D[1], X18
    FMOV  D14, X23
    FMOV  V14.D[1], X10
    FMOV  D15, X14
    FMOV  V15.D[1], X21
    FMOV  D16, X19
    FMOV  V16.D[1], X17
    FMOV  D17, X8
    FMOV  V17.D[1], X8
    FMOV  D18, X19
    FMOV  V18.D[1], X16
    FMOV  D19, X7
    FMOV  V19.D[1], X15
    FMOV  D20, X25
    FMOV  V20.D[1], X10
    FMOV  D21, X5
    FMOV  V21.D[1], X22
    FMOV  D22, X25
    FMOV  V22.D[1], X24
    FMOV  D23, X16
    FMOV  V23.D[1], X27
    FMOV  D24, X27
    FMOV  V24.D[1], X24
    FMOV  D25, X25
    FMOV  V25.D[1], X13
    FMOV  D26, X18
    FMOV  V26.D[1], X7
    FMOV  D27, X18
    FMOV  V27.D[1], X7
    FMOV  D28, X13
    FMOV  V28.D[1], X25
    FMOV  D29, X26
    FMOV  V29.D[1], X16
    FMOV  D30, X7
    FMOV  V30.D[1], X21
    FMOV  D31, X8
    FMOV  V31.D[1], X14
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X18, #0x1900, LSL #0
    ADD  X5, X30, X18, ASR #0
    MOV  X17, X5
    ST1 { V5.16B, V6.16B }, [X17], #32
    MOV  X17, X5
    LD1 { V0.16B, V1.16B }, [X17], #32
    ADD  X5, X5, X16, LSR #0
    MOV  X17, X5
    ST1 { V27.2D, V28.2D }, [X17], #32
    MOV  X17, X5
    LD1 { V16.2D, V17.2D }, [X17], #32
    ADD  X5, X5, X16
    MOV  X17, X5
    ST1 { V16.4S, V17.4S }, [X17], #32
    MOV  X17, X5
    LD1 { V20.4S, V21.4S }, [X17], #32
    ADD  X5, X5, X16
    MOV  X17, X5
    ST1 { V0.8H, V1.8H }, [X17], #32
    MOV  X17, X5
    LD1 { V1.8H, V2.8H }, [X17], #32
    ADD  X5, X5, X16
    MOV  X17, X5
    ST1 { V20.1D, V21.1D }, [X17], #16
    MOV  X17, X5
    LD1 { V2.4H, V3.4H }, [X17], #16
    ADD  X5, X5, X16, LSR #0
    MOV  X17, X5
    ST1 { V19.1D, V20.1D }, [X17], #16
    MOV  X17, X5
    LD1 { V16.1D, V17.1D }, [X17], #16
    ADD  X5, X5, X16
    MOV  X17, X5
    ST1 { V2.2S, V3.2S }, [X17], #16
    MOV  X17, X5
    LD1 { V28.2S, V29.2S }, [X17], #16
    ADD  X5, X5, X16, ASR #0
    MOV  X17, X5
    ST1 { V29.4H, V30.4H }, [X17], #16
    MOV  X17, X5
    LD1 { V21.4H, V22.4H }, [X17], #16
    ADD  X5, X5, X16
    MOV  X17, X5
    ST1 { V21.8B, V22.8B }, [X17], #16
    MOV  X17, X5
    LD1 { V8.8B, V9.8B }, [X17], #16
    ADD  X5, X5, X16, ASR #0
    ST1 { V8.8H, V9.8H }, [X5], X10
    LD1 { V16.2D, V17.2D }, [X5], X10
    ADD  X5, X5, X16
    ST1 { V16.16B, V17.16B }, [X5], X10
    LD1 { V22.16B, V23.16B }, [X5], X10
    ADD  X5, X5, X16, ASR #0
    ST1 { V22.2D, V23.2D }, [X5], X10
    LD1 { V31.2D, V0.2D }, [X5], X10
    ADD  X5, X5, X16, LSR #0
    ST1 { V3.4S, V4.4S }, [X5], X10
    LD1 { V13.4S, V14.4S }, [X5], X10
    ADD  X5, X5, X16, LSR #0
    ST1 { V7.8H, V8.8H }, [X5], X10
    LD1 { V15.8H, V16.8H }, [X5], X10
    ADD  X5, X5, X16, ASR #0
    ST1 { V22.4H, V23.4H }, [X5], X10
    LD1 { V15.2S, V16.2S }, [X5], X10
    ADD  X5, X5, X16, LSR #0
    ST1 { V31.1D, V0.1D }, [X5], X10
    LD1 { V7.1D, V8.1D }, [X5], X10
    ADD  X5, X5, X16, LSR #0
    ST1 { V1.2S, V2.2S }, [X5], X10
    LD1 { V2.2S, V3.2S }, [X5], X10
    ADD  X5, X5, X16
    ST1 { V2.4H, V3.4H }, [X5], X10
    LD1 { V24.4H, V25.4H }, [X5], X10
    ADD  X5, X5, X16, ASR #0
    ST1 { V3.8B, V4.8B }, [X5], X10
    LD1 { V2.8B, V3.8B }, [X5], X10
    ADD  X5, X5, X16, ASR #0
    ST1 { V12.H }[0x5], [X5]
    LD1 { V4.H }[0x4], [X5]
    ADD  X5, X5, X16, LSR #0
    ST1 { V25.S }[0x1], [X5]
    LD1 { V27.S }[0x0], [X5]
    ADD  X5, X5, X16, ASR #0
    ST1 { V4.D }[0x1], [X5]
    LD1 { V20.D }[0x0], [X5]
    ADD  X5, X5, X16, ASR #0
    ST1 { V14.B }[0xc], [X5]
    LD1 { V4.B }[0x9], [X5]
    ADD  X5, X5, X16, ASR #0
    MOV  X17, X5
    ST1 { V17.H }[0x4], [X17], #2
    MOV  X17, X5
    LD1 { V17.H }[0x5], [X17], #2
    ADD  X5, X5, X16, LSR #0
    ST1 { V17.H }[0x2], [X5], X10
    LD1 { V21.H }[0x2], [X5], X10
    ADD  X5, X5, X16
    MOV  X17, X5
    ST1 { V27.S }[0x0], [X17], #4
    MOV  X17, X5
    LD1 { V14.S }[0x0], [X17], #4
    ADD  X5, X5, X16, LSR #0
    ST1 { V6.S }[0x0], [X5], X10
    LD1 { V17.S }[0x2], [X5], X10
    ADD  X5, X5, X16, LSR #0
    MOV  X17, X5
    ST1 { V11.D }[0x1], [X17], #8
    MOV  X17, X5
    LD1 { V27.D }[0x0], [X17], #8
    ADD  X5, X5, X16, LSR #0
    ST1 { V5.D }[0x1], [X5], X10
    LD1 { V0.D }[0x1], [X5], X10
    ADD  X5, X5, X16, ASR #0
    MOV  X17, X5
    ST1 { V9.B }[0x2], [X17], #1
    MOV  X17, X5
    LD1 { V21.B }[0x1], [X17], #1
    ADD  X5, X5, X16
    ST1 { V2.B }[0x7], [X5], X10
    LD1 { V5.B }[0xb], [X5], X10
    ADD  X5, X5, X16, ASR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MRS  X14, FPSR
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D0
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D1
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D2
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D3
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D4
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D5
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D6
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D7
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D8
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D9
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D10
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D11
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D12
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D13
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D14
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D15
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D16
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D17
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D18
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D19
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D20
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D21
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D22
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D23
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D24
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D25
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D26
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D27
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D28
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D29
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D30
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    FMOV  X14, D31
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D1, X10
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X11
    FMOV  V3.D[1], X27
    FMOV  D4, X22
    FMOV  V4.D[1], X14
    FMOV  D5, X23
    FMOV  V5.D[1], X22
    FMOV  D6, X21
    FMOV  V6.D[1], X22
    FMOV  D7, X17
    FMOV  V7.D[1], X5
    FMOV  D8, X16
    FMOV  V8.D[1], X27
    FMOV  D9, X11
    FMOV  V9.D[1], X21
    FMOV  D10, X13
    FMOV  V10.D[1], X20
    FMOV  D11, X18
    FMOV  V11.D[1], X14
    FMOV  D12, X17
    FMOV  V12.D[1], X15
    FMOV  D13, X17
    FMOV  V13.D[1], X9
    FMOV  D14, X21
    FMOV  V14.D[1], X27
    FMOV  D15, X21
    FMOV  V15.D[1], X23
    FMOV  D16, X29
    FMOV  V16.D[1], X18
    FMOV  D17, X8
    FMOV  V17.D[1], X27
    FMOV  D18, X9
    FMOV  V18.D[1], X7
    FMOV  D19, X22
    FMOV  V19.D[1], X17
    FMOV  D20, X10
    FMOV  V20.D[1], X18
    FMOV  D21, X24
    FMOV  V21.D[1], X28
    FMOV  D22, X25
    FMOV  V22.D[1], X22
    FMOV  D23, X7
    FMOV  V23.D[1], X14
    FMOV  D24, X11
    FMOV  V24.D[1], X15
    FMOV  D25, X5
    FMOV  V25.D[1], X11
    FMOV  D26, X8
    FMOV  V26.D[1], X26
    FMOV  D27, X12
    FMOV  V27.D[1], X11
    FMOV  D28, X13
    FMOV  V28.D[1], X29
    FMOV  D29, X14
    FMOV  V29.D[1], X18
    FMOV  D30, X7
    FMOV  V30.D[1], X14
    FMOV  D31, X26
    FMOV  V31.D[1], X7
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X9, #0x1e00, LSL #0
    ADD  X26, X30, X9, ASR #0
    MOV  X20, X26
    ST1 { V24.16B, V25.16B }, [X20], #32
    MOV  X20, X26
    LD1 { V29.16B, V30.16B }, [X20], #32
    ADD  X26, X26, X8, LSR #0
    MOV  X20, X26
    ST1 { V28.2D, V29.2D }, [X20], #32
    MOV  X20, X26
    LD1 { V18.2D, V19.2D }, [X20], #32
    ADD  X26, X26, X8, ASR #0
    MOV  X20, X26
    ST1 { V11.4S, V12.4S }, [X20], #32
    MOV  X20, X26
    LD1 { V22.4S, V23.4S }, [X20], #32
    ADD  X26, X26, X8
    MOV  X20, X26
    ST1 { V18.8H, V19.8H }, [X20], #32
    MOV  X20, X26
    LD1 { V30.8H, V31.8H }, [X20], #32
    ADD  X26, X26, X8
    MOV  X20, X26
    ST1 { V15.8B, V16.8B }, [X20], #16
    MOV  X20, X26
    LD1 { V23.2S, V24.2S }, [X20], #16
    ADD  X26, X26, X8, ASR #0
    MOV  X20, X26
    ST1 { V18.1D, V19.1D }, [X20], #16
    MOV  X20, X26
    LD1 { V7.1D, V8.1D }, [X20], #16
    ADD  X26, X26, X8, ASR #0
    MOV  X20, X26
    ST1 { V22.2S, V23.2S }, [X20], #16
    MOV  X20, X26
    LD1 { V17.2S, V18.2S }, [X20], #16
    ADD  X26, X26, X8
    MOV  X20, X26
    ST1 { V7.4H, V8.4H }, [X20], #16
    MOV  X20, X26
    LD1 { V1.4H, V2.4H }, [X20], #16
    ADD  X26, X26, X8, LSR #0
    MOV  X20, X26
    ST1 { V1.8B, V2.8B }, [X20], #16
    MOV  X20, X26
    LD1 { V6.8B, V7.8B }, [X20], #16
    ADD  X26, X26, X8
    ST1 { V17.16B, V18.16B }, [X26], X7
    LD1 { V12.16B, V13.16B }, [X26], X7
    ADD  X26, X26, X8, LSR #0
    ST1 { V21.16B, V22.16B }, [X26], X7
    LD1 { V24.16B, V25.16B }, [X26], X7
    ADD  X26, X26, X8, LSR #0
    ST1 { V12.2D, V13.2D }, [X26], X7
    LD1 { V4.2D, V5.2D }, [X26], X7
    ADD  X26, X26, X8, LSR #0
    ST1 { V17.4S, V18.4S }, [X26], X7
    LD1 { V29.4S, V30.4S }, [X26], X7
    ADD  X26, X26, X8, ASR #0
    ST1 { V12.8H, V13.8H }, [X26], X7
    LD1 { V26.8H, V27.8H }, [X26], X7
    ADD  X26, X26, X8, LSR #0
    ST1 { V18.2S, V19.2S }, [X26], X7
    LD1 { V8.1D, V9.1D }, [X26], X7
    ADD  X26, X26, X8
    ST1 { V5.1D, V6.1D }, [X26], X7
    LD1 { V6.1D, V7.1D }, [X26], X7
    ADD  X26, X26, X8, ASR #0
    ST1 { V24.2S, V25.2S }, [X26], X7
    LD1 { V13.2S, V14.2S }, [X26], X7
    ADD  X26, X26, X8
    ST1 { V27.4H, V28.4H }, [X26], X7
    LD1 { V14.4H, V15.4H }, [X26], X7
    ADD  X26, X26, X8, ASR #0
    ST1 { V14.8B, V15.8B }, [X26], X7
    LD1 { V21.8B, V22.8B }, [X26], X7
    ADD  X26, X26, X8, ASR #0
    ST1 { V22.H }[0x3], [X26]
    LD1 { V5.H }[0x6], [X26]
    ADD  X26, X26, X8, ASR #0
    ST1 { V21.S }[0x3], [X26]
    LD1 { V11.S }[0x3], [X26]
    ADD  X26, X26, X8, ASR #0
    ST1 { V7.D }[0x0], [X26]
    LD1 { V17.D }[0x0], [X26]
    ADD  X26, X26, X8, ASR #0
    ST1 { V6.B }[0x3], [X26]
    LD1 { V13.B }[0x8], [X26]
    ADD  X26, X26, X8, ASR #0
    MOV  X20, X26
    ST1 { V4.H }[0x7], [X20], #2
    MOV  X20, X26
    LD1 { V21.H }[0x3], [X20], #2
    ADD  X26, X26, X8
    ST1 { V0.H }[0x0], [X26], X7
    LD1 { V0.H }[0x0], [X26], X7
    ADD  X26, X26, X8, LSR #0
    MOV  X20, X26
    ST1 { V13.S }[0x0], [X20], #4
    MOV  X20, X26
    LD1 { V16.S }[0x1], [X20], #4
    ADD  X26, X26, X8
    ST1 { V0.S }[0x3], [X26], X7
    LD1 { V6.S }[0x2], [X26], X7
    ADD  X26, X26, X8, LSR #0
    MOV  X20, X26
    ST1 { V6.D }[0x1], [X20], #8
    MOV  X20, X26
    LD1 { V13.D }[0x1], [X20], #8
    ADD  X26, X26, X8
    ST1 { V13.D }[0x0], [X26], X7
    LD1 { V6.D }[0x0], [X26], X7
    ADD  X26, X26, X8
    MOV  X20, X26
    ST1 { V17.B }[0x2], [X20], #1
    MOV  X20, X26
    LD1 { V0.B }[0x5], [X20], #1
    ADD  X26, X26, X8
    ST1 { V19.B }[0xa], [X26], X7
    LD1 { V17.B }[0xe], [X26], X7
    ADD  X26, X26, X8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X25, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MRS  X10, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D0
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D1
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D2
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D3
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D4
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a5a, LSL #32
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D5
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D6
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D7
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D8
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D9
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D10
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D11
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D12
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D13
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D14
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D15
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D16
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D17
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D18
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D19
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D20
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D21
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D22
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D23
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D24
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D25
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D26
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D27
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D28
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D29
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D30
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D31
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X14, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X11
    FMOV  V2.D[1], X16
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X7
    FMOV  V4.D[1], X15
    FMOV  D5, X18
    FMOV  V5.D[1], X21
    FMOV  D6, X20
    FMOV  V6.D[1], X5
    FMOV  D7, X7
    FMOV  V7.D[1], X28
    FMOV  D8, X21
    FMOV  V8.D[1], X23
    FMOV  D9, X23
    FMOV  V9.D[1], X14
    FMOV  D10, X14
    FMOV  V10.D[1], X21
    FMOV  D11, X16
    FMOV  V11.D[1], X6
    FMOV  D12, X18
    FMOV  V12.D[1], X25
    FMOV  D13, X21
    FMOV  V13.D[1], X27
    FMOV  D14, X28
    FMOV  V14.D[1], X19
    FMOV  D15, X23
    FMOV  V15.D[1], X7
    FMOV  D16, X7
    FMOV  V16.D[1], X16
    FMOV  D17, X25
    FMOV  V17.D[1], X6
    FMOV  D18, X7
    FMOV  V18.D[1], X6
    FMOV  D19, X22
    FMOV  V19.D[1], X29
    FMOV  D20, X19
    FMOV  V20.D[1], X5
    FMOV  D21, X19
    FMOV  V21.D[1], X23
    FMOV  D22, X14
    FMOV  V22.D[1], X12
    FMOV  D23, X20
    FMOV  V23.D[1], X27
    FMOV  D24, X13
    FMOV  V24.D[1], X24
    FMOV  D25, X17
    FMOV  V25.D[1], X25
    FMOV  D26, X15
    FMOV  V26.D[1], X22
    FMOV  D27, X12
    FMOV  V27.D[1], X18
    FMOV  D28, X21
    FMOV  V28.D[1], X16
    FMOV  D29, X26
    FMOV  V29.D[1], X15
    FMOV  D30, X25
    FMOV  V30.D[1], X17
    FMOV  D31, X21
    FMOV  V31.D[1], X23
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X27, #0x2300, LSL #0
    ADD  X10, X30, X27, ASR #0
    MOV  X21, X10
    ST1 { V21.16B, V22.16B }, [X21], #32
    MOV  X21, X10
    LD1 { V21.16B, V22.16B }, [X21], #32
    ADD  X10, X10, X16, LSR #0
    MOV  X21, X10
    ST1 { V13.2D, V14.2D }, [X21], #32
    MOV  X21, X10
    LD1 { V15.2D, V16.2D }, [X21], #32
    ADD  X10, X10, X16
    MOV  X21, X10
    ST1 { V15.4S, V16.4S }, [X21], #32
    MOV  X21, X10
    LD1 { V12.4S, V13.4S }, [X21], #32
    ADD  X10, X10, X16
    MOV  X21, X10
    ST1 { V21.8H, V22.8H }, [X21], #32
    MOV  X21, X10
    LD1 { V1.8H, V2.8H }, [X21], #32
    ADD  X10, X10, X16
    MOV  X21, X10
    ST1 { V1.8B, V2.8B }, [X21], #16
    MOV  X21, X10
    LD1 { V3.4H, V4.4H }, [X21], #16
    ADD  X10, X10, X16
    MOV  X21, X10
    ST1 { V12.1D, V13.1D }, [X21], #16
    MOV  X21, X10
    LD1 { V30.1D, V31.1D }, [X21], #16
    ADD  X10, X10, X16, LSR #0
    MOV  X21, X10
    ST1 { V30.2S, V31.2S }, [X21], #16
    MOV  X21, X10
    LD1 { V13.2S, V14.2S }, [X21], #16
    ADD  X10, X10, X16
    MOV  X21, X10
    ST1 { V13.4H, V14.4H }, [X21], #16
    MOV  X21, X10
    LD1 { V27.4H, V28.4H }, [X21], #16
    ADD  X10, X10, X16, LSR #0
    MOV  X21, X10
    ST1 { V25.8B, V26.8B }, [X21], #16
    MOV  X21, X10
    LD1 { V10.8B, V11.8B }, [X21], #16
    ADD  X10, X10, X16, LSR #0
    ST1 { V28.2D, V29.2D }, [X10], X26
    LD1 { V14.16B, V15.16B }, [X10], X26
    ADD  X10, X10, X16
    ST1 { V14.16B, V15.16B }, [X10], X26
    LD1 { V12.16B, V13.16B }, [X10], X26
    ADD  X10, X10, X16, LSR #0
    ST1 { V3.2D, V4.2D }, [X10], X26
    LD1 { V2.2D, V3.2D }, [X10], X26
    ADD  X10, X10, X16
    ST1 { V10.4S, V11.4S }, [X10], X26
    LD1 { V9.4S, V10.4S }, [X10], X26
    ADD  X10, X10, X16, ASR #0
    ST1 { V2.8H, V3.8H }, [X10], X26
    LD1 { V23.8H, V24.8H }, [X10], X26
    ADD  X10, X10, X16, LSR #0
    ST1 { V29.4H, V30.4H }, [X10], X26
    LD1 { V29.4H, V30.4H }, [X10], X26
    ADD  X10, X10, X16, LSR #0
    ST1 { V2.1D, V3.1D }, [X10], X26
    LD1 { V8.1D, V9.1D }, [X10], X26
    ADD  X10, X10, X16, ASR #0
    ST1 { V12.2S, V13.2S }, [X10], X26
    LD1 { V24.2S, V25.2S }, [X10], X26
    ADD  X10, X10, X16, LSR #0
    ST1 { V29.4H, V30.4H }, [X10], X26
    LD1 { V20.4H, V21.4H }, [X10], X26
    ADD  X10, X10, X16, ASR #0
    ST1 { V20.8B, V21.8B }, [X10], X26
    LD1 { V1.8B, V2.8B }, [X10], X26
    ADD  X10, X10, X16, ASR #0
    ST1 { V14.H }[0x0], [X10]
    LD1 { V27.H }[0x1], [X10]
    ADD  X10, X10, X16
    ST1 { V23.S }[0x3], [X10]
    LD1 { V28.S }[0x1], [X10]
    ADD  X10, X10, X16, LSR #0
    ST1 { V27.D }[0x1], [X10]
    LD1 { V19.D }[0x0], [X10]
    ADD  X10, X10, X16, LSR #0
    ST1 { V8.B }[0xe], [X10]
    LD1 { V27.B }[0x2], [X10]
    ADD  X10, X10, X16, ASR #0
    MOV  X21, X10
    ST1 { V27.H }[0x7], [X21], #2
    MOV  X21, X10
    LD1 { V30.H }[0x2], [X21], #2
    ADD  X10, X10, X16, ASR #0
    ST1 { V30.H }[0x2], [X10], X26
    LD1 { V19.H }[0x0], [X10], X26
    ADD  X10, X10, X16, ASR #0
    MOV  X21, X10
    ST1 { V15.S }[0x1], [X21], #4
    MOV  X21, X10
    LD1 { V16.S }[0x3], [X21], #4
    ADD  X10, X10, X16
    ST1 { V23.S }[0x0], [X10], X26
    LD1 { V2.S }[0x0], [X10], X26
    ADD  X10, X10, X16
    MOV  X21, X10
    ST1 { V19.D }[0x0], [X21], #8
    MOV  X21, X10
    LD1 { V4.D }[0x0], [X21], #8
    ADD  X10, X10, X16, ASR #0
    ST1 { V16.D }[0x0], [X10], X26
    LD1 { V16.D }[0x1], [X10], X26
    ADD  X10, X10, X16
    MOV  X21, X10
    ST1 { V15.B }[0xa], [X21], #1
    MOV  X21, X10
    LD1 { V8.B }[0x7], [X21], #1
    ADD  X10, X10, X16, LSR #0
    ST1 { V1.B }[0x0], [X10], X26
    LD1 { V7.B }[0x4], [X10], X26
    ADD  X10, X10, X16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MRS  X25, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D1
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D2
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D3
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D5
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D6
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D7
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D8
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D9
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D10
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D11
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D12
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D13
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D14
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D15
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D16
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D17
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D18
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D20
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D21
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D22
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D23
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D24
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D25
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D26
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D27
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa500, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D28
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D29
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D30
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    FMOV  X25, D31
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X17, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X20
    FMOV  D1, X28
    FMOV  V1.D[1], X28
    FMOV  D2, X16
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X24
    FMOV  D4, X27
    FMOV  V4.D[1], X14
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X27
    FMOV  V6.D[1], X8
    FMOV  D7, X10
    FMOV  V7.D[1], X21
    FMOV  D8, X18
    FMOV  V8.D[1], X7
    FMOV  D9, X25
    FMOV  V9.D[1], X11
    FMOV  D10, X22
    FMOV  V10.D[1], X16
    FMOV  D11, X15
    FMOV  V11.D[1], X23
    FMOV  D12, X23
    FMOV  V12.D[1], X18
    FMOV  D13, X8
    FMOV  V13.D[1], X26
    FMOV  D14, X18
    FMOV  V14.D[1], X6
    FMOV  D15, X18
    FMOV  V15.D[1], X17
    FMOV  D16, X5
    FMOV  V16.D[1], X12
    FMOV  D17, X10
    FMOV  V17.D[1], X24
    FMOV  D18, X8
    FMOV  V18.D[1], X11
    FMOV  D19, X15
    FMOV  V19.D[1], X16
    FMOV  D20, X8
    FMOV  V20.D[1], X26
    FMOV  D21, X24
    FMOV  V21.D[1], X16
    FMOV  D22, X11
    FMOV  V22.D[1], X25
    FMOV  D23, X8
    FMOV  V23.D[1], X8
    FMOV  D24, X29
    FMOV  V24.D[1], X7
    FMOV  D25, X5
    FMOV  V25.D[1], X5
    FMOV  D26, X18
    FMOV  V26.D[1], X25
    FMOV  D27, X20
    FMOV  V27.D[1], X16
    FMOV  D28, X9
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X16
    FMOV  D30, X11
    FMOV  V30.D[1], X18
    FMOV  D31, X7
    FMOV  V31.D[1], X28
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X7, #0x2800, LSL #0
    ADD  X6, X30, X7, LSR #0
    MOV  X19, X6
    ST1 { V29.16B, V30.16B }, [X19], #32
    MOV  X19, X6
    LD1 { V22.16B, V23.16B }, [X19], #32
    ADD  X6, X6, X27, ASR #0
    MOV  X19, X6
    ST1 { V27.2D, V28.2D }, [X19], #32
    MOV  X19, X6
    LD1 { V26.2D, V27.2D }, [X19], #32
    ADD  X6, X6, X27, LSR #0
    MOV  X19, X6
    ST1 { V26.4S, V27.4S }, [X19], #32
    MOV  X19, X6
    LD1 { V15.4S, V16.4S }, [X19], #32
    ADD  X6, X6, X27, ASR #0
    MOV  X19, X6
    ST1 { V15.8H, V16.8H }, [X19], #32
    MOV  X19, X6
    LD1 { V2.8H, V3.8H }, [X19], #32
    ADD  X6, X6, X27, ASR #0
    MOV  X19, X6
    ST1 { V22.2S, V23.2S }, [X19], #16
    MOV  X19, X6
    LD1 { V12.8B, V13.8B }, [X19], #16
    ADD  X6, X6, X27, ASR #0
    MOV  X19, X6
    ST1 { V3.1D, V4.1D }, [X19], #16
    MOV  X19, X6
    LD1 { V21.1D, V22.1D }, [X19], #16
    ADD  X6, X6, X27, ASR #0
    MOV  X19, X6
    ST1 { V26.2S, V27.2S }, [X19], #16
    MOV  X19, X6
    LD1 { V1.2S, V2.2S }, [X19], #16
    ADD  X6, X6, X27, LSR #0
    MOV  X19, X6
    ST1 { V16.4H, V17.4H }, [X19], #16
    MOV  X19, X6
    LD1 { V20.4H, V21.4H }, [X19], #16
    ADD  X6, X6, X27
    MOV  X19, X6
    ST1 { V19.8B, V20.8B }, [X19], #16
    MOV  X19, X6
    LD1 { V21.8B, V22.8B }, [X19], #16
    ADD  X6, X6, X27
    ST1 { V8.8H, V9.8H }, [X6], X12
    LD1 { V22.8H, V23.8H }, [X6], X12
    ADD  X6, X6, X27, LSR #0
    ST1 { V10.16B, V11.16B }, [X6], X12
    LD1 { V11.16B, V12.16B }, [X6], X12
    ADD  X6, X6, X27
    ST1 { V21.2D, V22.2D }, [X6], X12
    LD1 { V18.2D, V19.2D }, [X6], X12
    ADD  X6, X6, X27, LSR #0
    ST1 { V16.4S, V17.4S }, [X6], X12
    LD1 { V25.4S, V26.4S }, [X6], X12
    ADD  X6, X6, X27
    ST1 { V25.8H, V26.8H }, [X6], X12
    LD1 { V12.8H, V13.8H }, [X6], X12
    ADD  X6, X6, X27, LSR #0
    ST1 { V30.1D, V31.1D }, [X6], X12
    LD1 { V8.8B, V9.8B }, [X6], X12
    ADD  X6, X6, X27, LSR #0
    ST1 { V12.1D, V13.1D }, [X6], X12
    LD1 { V13.1D, V14.1D }, [X6], X12
    ADD  X6, X6, X27
    ST1 { V1.2S, V2.2S }, [X6], X12
    LD1 { V13.2S, V14.2S }, [X6], X12
    ADD  X6, X6, X27
    ST1 { V29.4H, V30.4H }, [X6], X12
    LD1 { V26.4H, V27.4H }, [X6], X12
    ADD  X6, X6, X27, ASR #0
    ST1 { V6.8B, V7.8B }, [X6], X12
    LD1 { V1.8B, V2.8B }, [X6], X12
    ADD  X6, X6, X27, ASR #0
    ST1 { V13.H }[0x7], [X6]
    LD1 { V29.H }[0x2], [X6]
    ADD  X6, X6, X27
    ST1 { V16.S }[0x0], [X6]
    LD1 { V30.S }[0x1], [X6]
    ADD  X6, X6, X27
    ST1 { V26.D }[0x1], [X6]
    LD1 { V12.D }[0x0], [X6]
    ADD  X6, X6, X27, ASR #0
    ST1 { V12.B }[0x0], [X6]
    LD1 { V13.B }[0x1], [X6]
    ADD  X6, X6, X27
    MOV  X19, X6
    ST1 { V13.H }[0x4], [X19], #2
    MOV  X19, X6
    LD1 { V12.H }[0x2], [X19], #2
    ADD  X6, X6, X27, LSR #0
    ST1 { V29.H }[0x4], [X6], X12
    LD1 { V20.H }[0x7], [X6], X12
    ADD  X6, X6, X27
    MOV  X19, X6
    ST1 { V12.S }[0x3], [X19], #4
    MOV  X19, X6
    LD1 { V3.S }[0x1], [X19], #4
    ADD  X6, X6, X27, LSR #0
    ST1 { V7.S }[0x3], [X6], X12
    LD1 { V12.S }[0x3], [X6], X12
    ADD  X6, X6, X27
    MOV  X19, X6
    ST1 { V10.D }[0x1], [X19], #8
    MOV  X19, X6
    LD1 { V13.D }[0x1], [X19], #8
    ADD  X6, X6, X27, LSR #0
    ST1 { V12.D }[0x0], [X6], X12
    LD1 { V10.D }[0x0], [X6], X12
    ADD  X6, X6, X27, ASR #0
    MOV  X19, X6
    ST1 { V20.B }[0x1], [X19], #1
    MOV  X19, X6
    LD1 { V20.B }[0x2], [X19], #1
    ADD  X6, X6, X27, ASR #0
    ST1 { V10.B }[0xd], [X6], X12
    LD1 { V10.B }[0x4], [X6], X12
    ADD  X6, X6, X27, ASR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MRS  X13, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D1
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D2
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D3
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D4
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D5
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D6
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D7
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D8
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D9
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D10
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a, LSL #32
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D11
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D13
    MOVZ  X9, #0x5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D14
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D15
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D16
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D17
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D18
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D19
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D20
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D21
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D22
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D23
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D24
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D25
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D26
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D27
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D28
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D29
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D30
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
    FMOV  X13, D31
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X20
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X11
    FMOV  D4, X18
    FMOV  V4.D[1], X15
    FMOV  D5, X8
    FMOV  V5.D[1], X14
    FMOV  D6, X10
    FMOV  V6.D[1], X16
    FMOV  D7, X15
    FMOV  V7.D[1], X24
    FMOV  D8, X27
    FMOV  V8.D[1], X9
    FMOV  D9, X15
    FMOV  V9.D[1], X22
    FMOV  D10, X9
    FMOV  V10.D[1], X17
    FMOV  D11, X21
    FMOV  V11.D[1], X13
    FMOV  D12, X10
    FMOV  V12.D[1], X27
    FMOV  D13, X15
    FMOV  V13.D[1], X12
    FMOV  D14, X24
    FMOV  V14.D[1], X28
    FMOV  D15, X12
    FMOV  V15.D[1], X19
    FMOV  D16, X20
    FMOV  V16.D[1], X24
    FMOV  D17, X29
    FMOV  V17.D[1], X16
    FMOV  D18, X15
    FMOV  V18.D[1], X11
    FMOV  D19, X27
    FMOV  V19.D[1], X14
    FMOV  D20, X14
    FMOV  V20.D[1], X23
    FMOV  D21, X26
    FMOV  V21.D[1], X17
    FMOV  D22, X21
    FMOV  V22.D[1], X11
    FMOV  D23, X27
    FMOV  V23.D[1], X23
    FMOV  D24, X13
    FMOV  V24.D[1], X5
    FMOV  D25, X8
    FMOV  V25.D[1], X14
    FMOV  D26, X7
    FMOV  V26.D[1], X13
    FMOV  D27, X10
    FMOV  V27.D[1], X8
    FMOV  D28, X8
    FMOV  V28.D[1], X27
    FMOV  D29, X28
    FMOV  V29.D[1], X13
    FMOV  D30, X17
    FMOV  V30.D[1], X28
    FMOV  D31, X16
    FMOV  V31.D[1], X24
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X29, #0x2d00, LSL #0
    ADD  X14, X30, X29
    MOV  X10, X14
    ST1 { V25.16B, V26.16B }, [X10], #32
    MOV  X10, X14
    LD1 { V30.16B, V31.16B }, [X10], #32
    ADD  X14, X14, X25
    MOV  X10, X14
    ST1 { V29.2D, V30.2D }, [X10], #32
    MOV  X10, X14
    LD1 { V19.2D, V20.2D }, [X10], #32
    ADD  X14, X14, X25, ASR #0
    MOV  X10, X14
    ST1 { V19.4S, V20.4S }, [X10], #32
    MOV  X10, X14
    LD1 { V19.4S, V20.4S }, [X10], #32
    ADD  X14, X14, X25, LSR #0
    MOV  X10, X14
    ST1 { V9.8H, V10.8H }, [X10], #32
    MOV  X10, X14
    LD1 { V24.8H, V25.8H }, [X10], #32
    ADD  X14, X14, X25, ASR #0
    MOV  X10, X14
    ST1 { V23.2S, V24.2S }, [X10], #16
    MOV  X10, X14
    LD1 { V12.8B, V13.8B }, [X10], #16
    ADD  X14, X14, X25
    MOV  X10, X14
    ST1 { V31.1D, V0.1D }, [X10], #16
    MOV  X10, X14
    LD1 { V16.1D, V17.1D }, [X10], #16
    ADD  X14, X14, X25
    MOV  X10, X14
    ST1 { V16.2S, V17.2S }, [X10], #16
    MOV  X10, X14
    LD1 { V7.2S, V8.2S }, [X10], #16
    ADD  X14, X14, X25, LSR #0
    MOV  X10, X14
    ST1 { V7.4H, V8.4H }, [X10], #16
    MOV  X10, X14
    LD1 { V25.4H, V26.4H }, [X10], #16
    ADD  X14, X14, X25, ASR #0
    MOV  X10, X14
    ST1 { V25.8B, V26.8B }, [X10], #16
    MOV  X10, X14
    LD1 { V4.8B, V5.8B }, [X10], #16
    ADD  X14, X14, X25
    ST1 { V4.8H, V5.8H }, [X14], X27
    LD1 { V18.8H, V19.8H }, [X14], X27
    ADD  X14, X14, X25, ASR #0
    ST1 { V13.16B, V14.16B }, [X14], X27
    LD1 { V5.16B, V6.16B }, [X14], X27
    ADD  X14, X14, X25, ASR #0
    ST1 { V18.2D, V19.2D }, [X14], X27
    LD1 { V18.2D, V19.2D }, [X14], X27
    ADD  X14, X14, X25
    ST1 { V10.4S, V11.4S }, [X14], X27
    LD1 { V25.4S, V26.4S }, [X14], X27
    ADD  X14, X14, X25, LSR #0
    ST1 { V25.8H, V26.8H }, [X14], X27
    LD1 { V25.8H, V26.8H }, [X14], X27
    ADD  X14, X14, X25, LSR #0
    ST1 { V12.4H, V13.4H }, [X14], X27
    LD1 { V11.2S, V12.2S }, [X14], X27
    ADD  X14, X14, X25, LSR #0
    ST1 { V27.1D, V28.1D }, [X14], X27
    LD1 { V13.1D, V14.1D }, [X14], X27
    ADD  X14, X14, X25, ASR #0
    ST1 { V14.2S, V15.2S }, [X14], X27
    LD1 { V0.2S, V1.2S }, [X14], X27
    ADD  X14, X14, X25, ASR #0
    ST1 { V19.4H, V20.4H }, [X14], X27
    LD1 { V19.4H, V20.4H }, [X14], X27
    ADD  X14, X14, X25, LSR #0
    ST1 { V31.8B, V0.8B }, [X14], X27
    LD1 { V30.8B, V31.8B }, [X14], X27
    ADD  X14, X14, X25
    ST1 { V20.H }[0x0], [X14]
    LD1 { V0.H }[0x2], [X14]
    ADD  X14, X14, X25, ASR #0
    ST1 { V16.S }[0x0], [X14]
    LD1 { V16.S }[0x3], [X14]
    ADD  X14, X14, X25
    ST1 { V1.D }[0x0], [X14]
    LD1 { V27.D }[0x0], [X14]
    ADD  X14, X14, X25, ASR #0
    ST1 { V6.B }[0x0], [X14]
    LD1 { V14.B }[0xf], [X14]
    ADD  X14, X14, X25, LSR #0
    MOV  X10, X14
    ST1 { V28.H }[0x7], [X10], #2
    MOV  X10, X14
    LD1 { V28.H }[0x7], [X10], #2
    ADD  X14, X14, X25
    ST1 { V13.H }[0x0], [X14], X27
    LD1 { V20.H }[0x0], [X14], X27
    ADD  X14, X14, X25, LSR #0
    MOV  X10, X14
    ST1 { V5.S }[0x0], [X10], #4
    MOV  X10, X14
    LD1 { V5.S }[0x1], [X10], #4
    ADD  X14, X14, X25, ASR #0
    ST1 { V14.S }[0x3], [X14], X27
    LD1 { V11.S }[0x1], [X14], X27
    ADD  X14, X14, X25, LSR #0
    MOV  X10, X14
    ST1 { V16.D }[0x0], [X10], #8
    MOV  X10, X14
    LD1 { V9.D }[0x0], [X10], #8
    ADD  X14, X14, X25
    ST1 { V20.D }[0x0], [X14], X27
    LD1 { V23.D }[0x1], [X14], X27
    ADD  X14, X14, X25
    MOV  X10, X14
    ST1 { V5.B }[0xa], [X10], #1
    MOV  X10, X14
    LD1 { V14.B }[0x3], [X10], #1
    ADD  X14, X14, X25
    ST1 { V14.B }[0x9], [X14], X27
    LD1 { V13.B }[0xb], [X14], X27
    ADD  X14, X14, X25
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP04_TestFail
    MRS  X8, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D6
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa500, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa500, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    FMOV  X8, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X21
    FMOV  D1, X25
    FMOV  V1.D[1], X11
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X22
    FMOV  V4.D[1], X5
    FMOV  D5, X23
    FMOV  V5.D[1], X27
    FMOV  D6, X21
    FMOV  V6.D[1], X6
    FMOV  D7, X16
    FMOV  V7.D[1], X6
    FMOV  D8, X16
    FMOV  V8.D[1], X28
    FMOV  D9, X18
    FMOV  V9.D[1], X15
    FMOV  D10, X24
    FMOV  V10.D[1], X15
    FMOV  D11, X28
    FMOV  V11.D[1], X13
    FMOV  D12, X18
    FMOV  V12.D[1], X16
    FMOV  D13, X25
    FMOV  V13.D[1], X9
    FMOV  D14, X15
    FMOV  V14.D[1], X12
    FMOV  D15, X5
    FMOV  V15.D[1], X25
    FMOV  D16, X13
    FMOV  V16.D[1], X20
    FMOV  D17, X5
    FMOV  V17.D[1], X13
    FMOV  D18, X22
    FMOV  V18.D[1], X15
    FMOV  D19, X12
    FMOV  V19.D[1], X24
    FMOV  D20, X25
    FMOV  V20.D[1], X21
    FMOV  D21, X10
    FMOV  V21.D[1], X18
    FMOV  D22, X25
    FMOV  V22.D[1], X19
    FMOV  D23, X28
    FMOV  V23.D[1], X16
    FMOV  D24, X11
    FMOV  V24.D[1], X21
    FMOV  D25, X7
    FMOV  V25.D[1], X25
    FMOV  D26, X24
    FMOV  V26.D[1], X13
    FMOV  D27, X26
    FMOV  V27.D[1], X12
    FMOV  D28, X7
    FMOV  V28.D[1], X26
    FMOV  D29, X13
    FMOV  V29.D[1], X28
    FMOV  D30, X20
    FMOV  V30.D[1], X5
    FMOV  D31, X6
    FMOV  V31.D[1], X26
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X13, #0x0, LSL #0
    ADD  X18, X30, X13, ASR #0
    MOV  X21, X18
    ST1 { V28.16B, V29.16B }, [X21], #32
    MOV  X21, X18
    LD1 { V1.16B, V2.16B }, [X21], #32
    ADD  X18, X18, X16, LSR #0
    MOV  X21, X18
    ST1 { V19.2D, V20.2D }, [X21], #32
    MOV  X21, X18
    LD1 { V25.2D, V26.2D }, [X21], #32
    ADD  X18, X18, X16, LSR #0
    MOV  X21, X18
    ST1 { V1.4S, V2.4S }, [X21], #32
    MOV  X21, X18
    LD1 { V17.4S, V18.4S }, [X21], #32
    ADD  X18, X18, X16, ASR #0
    MOV  X21, X18
    ST1 { V18.8H, V19.8H }, [X21], #32
    MOV  X21, X18
    LD1 { V0.8H, V1.8H }, [X21], #32
    ADD  X18, X18, X16
    MOV  X21, X18
    ST1 { V12.8B, V13.8B }, [X21], #16
    MOV  X21, X18
    LD1 { V9.2S, V10.2S }, [X21], #16
    ADD  X18, X18, X16, ASR #0
    MOV  X21, X18
    ST1 { V25.1D, V26.1D }, [X21], #16
    MOV  X21, X18
    LD1 { V31.1D, V0.1D }, [X21], #16
    ADD  X18, X18, X16, LSR #0
    MOV  X21, X18
    ST1 { V24.2S, V25.2S }, [X21], #16
    MOV  X21, X18
    LD1 { V30.2S, V31.2S }, [X21], #16
    ADD  X18, X18, X16, ASR #0
    MOV  X21, X18
    ST1 { V9.4H, V10.4H }, [X21], #16
    MOV  X21, X18
    LD1 { V30.4H, V31.4H }, [X21], #16
    ADD  X18, X18, X16, ASR #0
    MOV  X21, X18
    ST1 { V30.8B, V31.8B }, [X21], #16
    MOV  X21, X18
    LD1 { V21.8B, V22.8B }, [X21], #16
    ADD  X18, X18, X16, ASR #0
    ST1 { V21.4S, V22.4S }, [X18], X14
    LD1 { V18.4S, V19.4S }, [X18], X14
    ADD  X18, X18, X16, ASR #0
    ST1 { V18.16B, V19.16B }, [X18], X14
    LD1 { V18.16B, V19.16B }, [X18], X14
    ADD  X18, X18, X16
    ST1 { V18.2D, V19.2D }, [X18], X14
    LD1 { V25.2D, V26.2D }, [X18], X14
    ADD  X18, X18, X16, LSR #0
    ST1 { V21.4S, V22.4S }, [X18], X14
    LD1 { V1.4S, V2.4S }, [X18], X14
    ADD  X18, X18, X16, LSR #0
    ST1 { V14.8H, V15.8H }, [X18], X14
    LD1 { V4.8H, V5.8H }, [X18], X14
    ADD  X18, X18, X16, LSR #0
    ST1 { V9.2S, V10.2S }, [X18], X14
    LD1 { V29.8B, V30.8B }, [X18], X14
    ADD  X18, X18, X16, LSR #0
    ST1 { V13.1D, V14.1D }, [X18], X14
    LD1 { V28.1D, V29.1D }, [X18], X14
    ADD  X18, X18, X16, LSR #0
    ST1 { V1.2S, V2.2S }, [X18], X14
    LD1 { V12.2S, V13.2S }, [X18], X14
    ADD  X18, X18, X16, LSR #0
    ST1 { V25.4H, V26.4H }, [X18], X14
    LD1 { V17.4H, V18.4H }, [X18], X14
    ADD  X18, X18, X16, ASR #0
    ST1 { V28.8B, V29.8B }, [X18], X14
    LD1 { V10.8B, V11.8B }, [X18], X14
    ADD  X18, X18, X16, ASR #0
    ST1 { V11.H }[0x7], [X18]
    LD1 { V16.H }[0x5], [X18]
    ADD  X18, X18, X16, LSR #0
    ST1 { V10.S }[0x0], [X18]
    LD1 { V31.S }[0x3], [X18]
    ADD  X18, X18, X16, LSR #0
    ST1 { V6.D }[0x0], [X18]
    LD1 { V28.D }[0x0], [X18]
    ADD  X18, X18, X16
    ST1 { V16.B }[0xc], [X18]
    LD1 { V15.B }[0xe], [X18]
    ADD  X18, X18, X16
    MOV  X21, X18
    ST1 { V31.H }[0x7], [X21], #2
    MOV  X21, X18
    LD1 { V14.H }[0x3], [X21], #2
    ADD  X18, X18, X16
    ST1 { V10.H }[0x2], [X18], X14
    LD1 { V11.H }[0x4], [X18], X14
    ADD  X18, X18, X16
    MOV  X21, X18
    ST1 { V29.S }[0x2], [X21], #4
    MOV  X21, X18
    LD1 { V29.S }[0x0], [X21], #4
    ADD  X18, X18, X16, ASR #0
    ST1 { V28.S }[0x0], [X18], X14
    LD1 { V31.S }[0x0], [X18], X14
    ADD  X18, X18, X16, ASR #0
    MOV  X21, X18
    ST1 { V14.D }[0x0], [X21], #8
    MOV  X21, X18
    LD1 { V16.D }[0x1], [X21], #8
    ADD  X18, X18, X16, ASR #0
    ST1 { V11.D }[0x1], [X18], X14
    LD1 { V28.D }[0x0], [X18], X14
    ADD  X18, X18, X16, LSR #0
    MOV  X21, X18
    ST1 { V15.B }[0xb], [X21], #1
    MOV  X21, X18
    LD1 { V15.B }[0x4], [X21], #1
    ADD  X18, X18, X16
    ST1 { V31.B }[0xf], [X18], X14
    LD1 { V31.B }[0xb], [X18], X14
    ADD  X18, X18, X16
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X26, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MRS  X20, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D5
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D10
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D11
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D15
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D16
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D19
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D20
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D23
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D26
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D28
    MOVZ  X26, #0x5a5a, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D29
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a00, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D31
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X10, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X7
    FMOV  D1, X28
    FMOV  V1.D[1], X19
    FMOV  D2, X29
    FMOV  V2.D[1], X20
    FMOV  D3, X7
    FMOV  V3.D[1], X27
    FMOV  D4, X20
    FMOV  V4.D[1], X26
    FMOV  D5, X20
    FMOV  V5.D[1], X6
    FMOV  D6, X20
    FMOV  V6.D[1], X28
    FMOV  D7, X18
    FMOV  V7.D[1], X16
    FMOV  D8, X14
    FMOV  V8.D[1], X6
    FMOV  D9, X15
    FMOV  V9.D[1], X29
    FMOV  D10, X19
    FMOV  V10.D[1], X28
    FMOV  D11, X16
    FMOV  V11.D[1], X23
    FMOV  D12, X23
    FMOV  V12.D[1], X19
    FMOV  D13, X28
    FMOV  V13.D[1], X29
    FMOV  D14, X23
    FMOV  V14.D[1], X20
    FMOV  D15, X29
    FMOV  V15.D[1], X17
    FMOV  D16, X29
    FMOV  V16.D[1], X27
    FMOV  D17, X25
    FMOV  V17.D[1], X5
    FMOV  D18, X20
    FMOV  V18.D[1], X16
    FMOV  D19, X15
    FMOV  V19.D[1], X20
    FMOV  D20, X19
    FMOV  V20.D[1], X29
    FMOV  D21, X8
    FMOV  V21.D[1], X24
    FMOV  D22, X22
    FMOV  V22.D[1], X19
    FMOV  D23, X24
    FMOV  V23.D[1], X24
    FMOV  D24, X11
    FMOV  V24.D[1], X22
    FMOV  D25, X11
    FMOV  V25.D[1], X10
    FMOV  D26, X26
    FMOV  V26.D[1], X13
    FMOV  D27, X8
    FMOV  V27.D[1], X19
    FMOV  D28, X12
    FMOV  V28.D[1], X8
    FMOV  D29, X19
    FMOV  V29.D[1], X19
    FMOV  D30, X12
    FMOV  V30.D[1], X27
    FMOV  D31, X8
    FMOV  V31.D[1], X22
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X8, #0x500, LSL #0
    ADD  X22, X30, X8, ASR #0
    MOV  X18, X22
    ST1 { V27.16B, V28.16B }, [X18], #32
    MOV  X18, X22
    LD1 { V17.16B, V18.16B }, [X18], #32
    ADD  X22, X22, X13, ASR #0
    MOV  X18, X22
    ST1 { V17.2D, V18.2D }, [X18], #32
    MOV  X18, X22
    LD1 { V17.2D, V18.2D }, [X18], #32
    ADD  X22, X22, X13
    MOV  X18, X22
    ST1 { V30.4S, V31.4S }, [X18], #32
    MOV  X18, X22
    LD1 { V16.4S, V17.4S }, [X18], #32
    ADD  X22, X22, X13, ASR #0
    MOV  X18, X22
    ST1 { V16.8H, V17.8H }, [X18], #32
    MOV  X18, X22
    LD1 { V6.8H, V7.8H }, [X18], #32
    ADD  X22, X22, X13, ASR #0
    MOV  X18, X22
    ST1 { V1.4H, V2.4H }, [X18], #16
    MOV  X18, X22
    LD1 { V11.1D, V12.1D }, [X18], #16
    ADD  X22, X22, X13, LSR #0
    MOV  X18, X22
    ST1 { V6.1D, V7.1D }, [X18], #16
    MOV  X18, X22
    LD1 { V24.1D, V25.1D }, [X18], #16
    ADD  X22, X22, X13, LSR #0
    MOV  X18, X22
    ST1 { V11.2S, V12.2S }, [X18], #16
    MOV  X18, X22
    LD1 { V0.2S, V1.2S }, [X18], #16
    ADD  X22, X22, X13, ASR #0
    MOV  X18, X22
    ST1 { V12.4H, V13.4H }, [X18], #16
    MOV  X18, X22
    LD1 { V18.4H, V19.4H }, [X18], #16
    ADD  X22, X22, X13, LSR #0
    MOV  X18, X22
    ST1 { V16.8B, V17.8B }, [X18], #16
    MOV  X18, X22
    LD1 { V15.8B, V16.8B }, [X18], #16
    ADD  X22, X22, X13, LSR #0
    ST1 { V28.4S, V29.4S }, [X22], X29
    LD1 { V11.4S, V12.4S }, [X22], X29
    ADD  X22, X22, X13, LSR #0
    ST1 { V11.16B, V12.16B }, [X22], X29
    LD1 { V3.16B, V4.16B }, [X22], X29
    ADD  X22, X22, X13, LSR #0
    ST1 { V18.2D, V19.2D }, [X22], X29
    LD1 { V20.2D, V21.2D }, [X22], X29
    ADD  X22, X22, X13, ASR #0
    ST1 { V14.4S, V15.4S }, [X22], X29
    LD1 { V6.4S, V7.4S }, [X22], X29
    ADD  X22, X22, X13, ASR #0
    ST1 { V6.8H, V7.8H }, [X22], X29
    LD1 { V2.8H, V3.8H }, [X22], X29
    ADD  X22, X22, X13
    ST1 { V24.4H, V25.4H }, [X22], X29
    LD1 { V4.1D, V5.1D }, [X22], X29
    ADD  X22, X22, X13, ASR #0
    ST1 { V2.1D, V3.1D }, [X22], X29
    LD1 { V6.1D, V7.1D }, [X22], X29
    ADD  X22, X22, X13, LSR #0
    ST1 { V2.2S, V3.2S }, [X22], X29
    LD1 { V2.2S, V3.2S }, [X22], X29
    ADD  X22, X22, X13
    ST1 { V0.4H, V1.4H }, [X22], X29
    LD1 { V12.4H, V13.4H }, [X22], X29
    ADD  X22, X22, X13
    ST1 { V12.8B, V13.8B }, [X22], X29
    LD1 { V2.8B, V3.8B }, [X22], X29
    ADD  X22, X22, X13
    ST1 { V20.H }[0x2], [X22]
    LD1 { V1.H }[0x0], [X22]
    ADD  X22, X22, X13, ASR #0
    ST1 { V4.S }[0x0], [X22]
    LD1 { V0.S }[0x1], [X22]
    ADD  X22, X22, X13
    ST1 { V2.D }[0x1], [X22]
    LD1 { V29.D }[0x1], [X22]
    ADD  X22, X22, X13, LSR #0
    ST1 { V22.B }[0xc], [X22]
    LD1 { V5.B }[0x9], [X22]
    ADD  X22, X22, X13
    MOV  X18, X22
    ST1 { V20.H }[0x6], [X18], #2
    MOV  X18, X22
    LD1 { V22.H }[0x6], [X18], #2
    ADD  X22, X22, X13, LSR #0
    ST1 { V28.H }[0x7], [X22], X29
    LD1 { V2.H }[0x4], [X22], X29
    ADD  X22, X22, X13, ASR #0
    MOV  X18, X22
    ST1 { V2.S }[0x3], [X18], #4
    MOV  X18, X22
    LD1 { V28.S }[0x0], [X18], #4
    ADD  X22, X22, X13, ASR #0
    ST1 { V28.S }[0x2], [X22], X29
    LD1 { V20.S }[0x0], [X22], X29
    ADD  X22, X22, X13, LSR #0
    MOV  X18, X22
    ST1 { V20.D }[0x1], [X18], #8
    MOV  X18, X22
    LD1 { V20.D }[0x1], [X18], #8
    ADD  X22, X22, X13
    ST1 { V22.D }[0x0], [X22], X29
    LD1 { V17.D }[0x0], [X22], X29
    ADD  X22, X22, X13
    MOV  X18, X22
    ST1 { V18.B }[0xb], [X18], #1
    MOV  X18, X22
    LD1 { V19.B }[0x3], [X18], #1
    ADD  X22, X22, X13, LSR #0
    ST1 { V20.B }[0x2], [X22], X29
    LD1 { V3.B }[0x8], [X22], X29
    ADD  X22, X22, X13
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X16, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MRS  X10, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D1
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D2
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X16, #0xa5, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D3
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D4
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X16, #0xa500, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D5
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D6
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D7
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D8
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D9
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D10
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D11
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D12
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D13
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D14
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D15
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D16
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D17
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D18
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D19
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D20
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D21
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D22
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D23
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D24
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D25
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D26
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D27
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D28
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D29
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D30
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D31
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D2, X15
    FMOV  V2.D[1], X24
    FMOV  D3, X24
    FMOV  V3.D[1], X23
    FMOV  D4, X18
    FMOV  V4.D[1], X22
    FMOV  D5, X27
    FMOV  V5.D[1], X12
    FMOV  D6, X6
    FMOV  V6.D[1], X11
    FMOV  D7, X21
    FMOV  V7.D[1], X14
    FMOV  D8, X21
    FMOV  V8.D[1], X8
    FMOV  D9, X23
    FMOV  V9.D[1], X29
    FMOV  D10, X15
    FMOV  V10.D[1], X13
    FMOV  D11, X16
    FMOV  V11.D[1], X24
    FMOV  D12, X25
    FMOV  V12.D[1], X25
    FMOV  D13, X8
    FMOV  V13.D[1], X26
    FMOV  D14, X12
    FMOV  V14.D[1], X13
    FMOV  D15, X12
    FMOV  V15.D[1], X13
    FMOV  D16, X22
    FMOV  V16.D[1], X21
    FMOV  D17, X27
    FMOV  V17.D[1], X6
    FMOV  D18, X22
    FMOV  V18.D[1], X13
    FMOV  D19, X20
    FMOV  V19.D[1], X7
    FMOV  D20, X7
    FMOV  V20.D[1], X15
    FMOV  D21, X20
    FMOV  V21.D[1], X23
    FMOV  D22, X26
    FMOV  V22.D[1], X16
    FMOV  D23, X25
    FMOV  V23.D[1], X9
    FMOV  D24, X24
    FMOV  V24.D[1], X10
    FMOV  D25, X26
    FMOV  V25.D[1], X17
    FMOV  D26, X20
    FMOV  V26.D[1], X27
    FMOV  D27, X20
    FMOV  V27.D[1], X20
    FMOV  D28, X11
    FMOV  V28.D[1], X20
    FMOV  D29, X16
    FMOV  V29.D[1], X26
    FMOV  D30, X11
    FMOV  V30.D[1], X5
    FMOV  D31, X20
    FMOV  V31.D[1], X28
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X23, #0xa00, LSL #0
    ADD  X15, X30, X23
    MOV  X9, X15
    ST1 { V24.16B, V25.16B }, [X9], #32
    MOV  X9, X15
    LD1 { V22.16B, V23.16B }, [X9], #32
    ADD  X15, X15, X8
    MOV  X9, X15
    ST1 { V22.2D, V23.2D }, [X9], #32
    MOV  X9, X15
    LD1 { V19.2D, V20.2D }, [X9], #32
    ADD  X15, X15, X8
    MOV  X9, X15
    ST1 { V30.4S, V31.4S }, [X9], #32
    MOV  X9, X15
    LD1 { V19.4S, V20.4S }, [X9], #32
    ADD  X15, X15, X8, ASR #0
    MOV  X9, X15
    ST1 { V22.8H, V23.8H }, [X9], #32
    MOV  X9, X15
    LD1 { V18.8H, V19.8H }, [X9], #32
    ADD  X15, X15, X8, ASR #0
    MOV  X9, X15
    ST1 { V19.4H, V20.4H }, [X9], #16
    MOV  X9, X15
    LD1 { V18.4H, V19.4H }, [X9], #16
    ADD  X15, X15, X8, ASR #0
    MOV  X9, X15
    ST1 { V1.1D, V2.1D }, [X9], #16
    MOV  X9, X15
    LD1 { V13.1D, V14.1D }, [X9], #16
    ADD  X15, X15, X8, LSR #0
    MOV  X9, X15
    ST1 { V9.2S, V10.2S }, [X9], #16
    MOV  X9, X15
    LD1 { V28.2S, V29.2S }, [X9], #16
    ADD  X15, X15, X8
    MOV  X9, X15
    ST1 { V4.4H, V5.4H }, [X9], #16
    MOV  X9, X15
    LD1 { V9.4H, V10.4H }, [X9], #16
    ADD  X15, X15, X8, LSR #0
    MOV  X9, X15
    ST1 { V18.8B, V19.8B }, [X9], #16
    MOV  X9, X15
    LD1 { V13.8B, V14.8B }, [X9], #16
    ADD  X15, X15, X8, LSR #0
    ST1 { V29.16B, V30.16B }, [X15], X28
    LD1 { V10.8H, V11.8H }, [X15], X28
    ADD  X15, X15, X8, LSR #0
    ST1 { V26.16B, V27.16B }, [X15], X28
    LD1 { V27.16B, V28.16B }, [X15], X28
    ADD  X15, X15, X8
    ST1 { V1.2D, V2.2D }, [X15], X28
    LD1 { V29.2D, V30.2D }, [X15], X28
    ADD  X15, X15, X8, LSR #0
    ST1 { V13.4S, V14.4S }, [X15], X28
    LD1 { V2.4S, V3.4S }, [X15], X28
    ADD  X15, X15, X8
    ST1 { V21.8H, V22.8H }, [X15], X28
    LD1 { V4.8H, V5.8H }, [X15], X28
    ADD  X15, X15, X8
    ST1 { V30.8B, V31.8B }, [X15], X28
    LD1 { V25.8B, V26.8B }, [X15], X28
    ADD  X15, X15, X8
    ST1 { V21.1D, V22.1D }, [X15], X28
    LD1 { V20.1D, V21.1D }, [X15], X28
    ADD  X15, X15, X8, LSR #0
    ST1 { V10.2S, V11.2S }, [X15], X28
    LD1 { V10.2S, V11.2S }, [X15], X28
    ADD  X15, X15, X8, LSR #0
    ST1 { V26.4H, V27.4H }, [X15], X28
    LD1 { V6.4H, V7.4H }, [X15], X28
    ADD  X15, X15, X8
    ST1 { V18.8B, V19.8B }, [X15], X28
    LD1 { V29.8B, V30.8B }, [X15], X28
    ADD  X15, X15, X8
    ST1 { V10.H }[0x7], [X15]
    LD1 { V8.H }[0x3], [X15]
    ADD  X15, X15, X8, LSR #0
    ST1 { V27.S }[0x3], [X15]
    LD1 { V25.S }[0x1], [X15]
    ADD  X15, X15, X8
    ST1 { V7.D }[0x0], [X15]
    LD1 { V11.D }[0x0], [X15]
    ADD  X15, X15, X8
    ST1 { V30.B }[0x9], [X15]
    LD1 { V5.B }[0x0], [X15]
    ADD  X15, X15, X8, LSR #0
    MOV  X9, X15
    ST1 { V20.H }[0x4], [X9], #2
    MOV  X9, X15
    LD1 { V28.H }[0x2], [X9], #2
    ADD  X15, X15, X8, ASR #0
    ST1 { V6.H }[0x7], [X15], X28
    LD1 { V7.H }[0x4], [X15], X28
    ADD  X15, X15, X8, ASR #0
    MOV  X9, X15
    ST1 { V9.S }[0x3], [X9], #4
    MOV  X9, X15
    LD1 { V15.S }[0x3], [X9], #4
    ADD  X15, X15, X8, LSR #0
    ST1 { V28.S }[0x3], [X15], X28
    LD1 { V17.S }[0x1], [X15], X28
    ADD  X15, X15, X8
    MOV  X9, X15
    ST1 { V15.D }[0x1], [X9], #8
    MOV  X9, X15
    LD1 { V22.D }[0x1], [X9], #8
    ADD  X15, X15, X8, ASR #0
    ST1 { V26.D }[0x0], [X15], X28
    LD1 { V12.D }[0x0], [X15], X28
    ADD  X15, X15, X8, LSR #0
    MOV  X9, X15
    ST1 { V17.B }[0xc], [X9], #1
    MOV  X9, X15
    LD1 { V11.B }[0x6], [X9], #1
    ADD  X15, X15, X8, LSR #0
    ST1 { V22.B }[0x9], [X15], X28
    LD1 { V5.B }[0xf], [X15], X28
    ADD  X15, X15, X8, LSR #0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MRS  X20, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D1
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D2
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D3
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D4
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D5
    MOVZ  X13, #0x5a00, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D6
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D7
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D8
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D9
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D10
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D11
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D12
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D13
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D14
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D15
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D16
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D17
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D18
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D19
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D20
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D21
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D22
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D23
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D24
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D25
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D26
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D27
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D28
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D29
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D30
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    FMOV  X20, D31
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X7, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X19
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X15
    FMOV  V2.D[1], X20
    FMOV  D3, X29
    FMOV  V3.D[1], X18
    FMOV  D4, X22
    FMOV  V4.D[1], X29
    FMOV  D5, X27
    FMOV  V5.D[1], X7
    FMOV  D6, X27
    FMOV  V6.D[1], X9
    FMOV  D7, X11
    FMOV  V7.D[1], X29
    FMOV  D8, X16
    FMOV  V8.D[1], X11
    FMOV  D9, X29
    FMOV  V9.D[1], X6
    FMOV  D10, X7
    FMOV  V10.D[1], X12
    FMOV  D11, X16
    FMOV  V11.D[1], X15
    FMOV  D12, X16
    FMOV  V12.D[1], X9
    FMOV  D13, X25
    FMOV  V13.D[1], X10
    FMOV  D14, X16
    FMOV  V14.D[1], X7
    FMOV  D15, X6
    FMOV  V15.D[1], X23
    FMOV  D16, X17
    FMOV  V16.D[1], X26
    FMOV  D17, X22
    FMOV  V17.D[1], X21
    FMOV  D18, X29
    FMOV  V18.D[1], X26
    FMOV  D19, X25
    FMOV  V19.D[1], X16
    FMOV  D20, X16
    FMOV  V20.D[1], X29
    FMOV  D21, X23
    FMOV  V21.D[1], X19
    FMOV  D22, X14
    FMOV  V22.D[1], X14
    FMOV  D23, X16
    FMOV  V23.D[1], X14
    FMOV  D24, X11
    FMOV  V24.D[1], X11
    FMOV  D25, X8
    FMOV  V25.D[1], X7
    FMOV  D26, X7
    FMOV  V26.D[1], X17
    FMOV  D27, X5
    FMOV  V27.D[1], X28
    FMOV  D28, X16
    FMOV  V28.D[1], X8
    FMOV  D29, X9
    FMOV  V29.D[1], X28
    FMOV  D30, X6
    FMOV  V30.D[1], X18
    FMOV  D31, X21
    FMOV  V31.D[1], X28
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X26, #0xf00, LSL #0
    ADD  X21, X30, X26, ASR #0
    MOV  X14, X21
    ST1 { V28.16B, V29.16B }, [X14], #32
    MOV  X14, X21
    LD1 { V13.16B, V14.16B }, [X14], #32
    ADD  X21, X21, X22
    MOV  X14, X21
    ST1 { V7.2D, V8.2D }, [X14], #32
    MOV  X14, X21
    LD1 { V8.2D, V9.2D }, [X14], #32
    ADD  X21, X21, X22, LSR #0
    MOV  X14, X21
    ST1 { V25.4S, V26.4S }, [X14], #32
    MOV  X14, X21
    LD1 { V0.4S, V1.4S }, [X14], #32
    ADD  X21, X21, X22
    MOV  X14, X21
    ST1 { V13.8H, V14.8H }, [X14], #32
    MOV  X14, X21
    LD1 { V10.8H, V11.8H }, [X14], #32
    ADD  X21, X21, X22, LSR #0
    MOV  X14, X21
    ST1 { V4.8B, V5.8B }, [X14], #16
    MOV  X14, X21
    LD1 { V0.8B, V1.8B }, [X14], #16
    ADD  X21, X21, X22
    MOV  X14, X21
    ST1 { V21.1D, V22.1D }, [X14], #16
    MOV  X14, X21
    LD1 { V24.1D, V25.1D }, [X14], #16
    ADD  X21, X21, X22, ASR #0
    MOV  X14, X21
    ST1 { V21.2S, V22.2S }, [X14], #16
    MOV  X14, X21
    LD1 { V18.2S, V19.2S }, [X14], #16
    ADD  X21, X21, X22, LSR #0
    MOV  X14, X21
    ST1 { V22.4H, V23.4H }, [X14], #16
    MOV  X14, X21
    LD1 { V9.4H, V10.4H }, [X14], #16
    ADD  X21, X21, X22
    MOV  X14, X21
    ST1 { V16.8B, V17.8B }, [X14], #16
    MOV  X14, X21
    LD1 { V14.8B, V15.8B }, [X14], #16
    ADD  X21, X21, X22, LSR #0
    ST1 { V18.2D, V19.2D }, [X21], X11
    LD1 { V25.4S, V26.4S }, [X21], X11
    ADD  X21, X21, X22
    ST1 { V24.16B, V25.16B }, [X21], X11
    LD1 { V15.16B, V16.16B }, [X21], X11
    ADD  X21, X21, X22, LSR #0
    ST1 { V9.2D, V10.2D }, [X21], X11
    LD1 { V1.2D, V2.2D }, [X21], X11
    ADD  X21, X21, X22
    ST1 { V14.4S, V15.4S }, [X21], X11
    LD1 { V8.4S, V9.4S }, [X21], X11
    ADD  X21, X21, X22, LSR #0
    ST1 { V19.8H, V20.8H }, [X21], X11
    LD1 { V10.8H, V11.8H }, [X21], X11
    ADD  X21, X21, X22, ASR #0
    ST1 { V8.2S, V9.2S }, [X21], X11
    LD1 { V28.1D, V29.1D }, [X21], X11
    ADD  X21, X21, X22, LSR #0
    ST1 { V28.1D, V29.1D }, [X21], X11
    LD1 { V10.1D, V11.1D }, [X21], X11
    ADD  X21, X21, X22
    ST1 { V4.2S, V5.2S }, [X21], X11
    LD1 { V8.2S, V9.2S }, [X21], X11
    ADD  X21, X21, X22, ASR #0
    ST1 { V1.4H, V2.4H }, [X21], X11
    LD1 { V4.4H, V5.4H }, [X21], X11
    ADD  X21, X21, X22
    ST1 { V23.8B, V24.8B }, [X21], X11
    LD1 { V28.8B, V29.8B }, [X21], X11
    ADD  X21, X21, X22, LSR #0
    ST1 { V29.H }[0x6], [X21]
    LD1 { V2.H }[0x2], [X21]
    ADD  X21, X21, X22, LSR #0
    ST1 { V5.S }[0x0], [X21]
    LD1 { V5.S }[0x2], [X21]
    ADD  X21, X21, X22, LSR #0
    ST1 { V10.D }[0x0], [X21]
    LD1 { V4.D }[0x0], [X21]
    ADD  X21, X21, X22
    ST1 { V4.B }[0x9], [X21]
    LD1 { V29.B }[0x0], [X21]
    ADD  X21, X21, X22
    MOV  X14, X21
    ST1 { V2.H }[0x1], [X14], #2
    MOV  X14, X21
    LD1 { V2.H }[0x3], [X14], #2
    ADD  X21, X21, X22
    ST1 { V31.H }[0x4], [X21], X11
    LD1 { V31.H }[0x6], [X21], X11
    ADD  X21, X21, X22, ASR #0
    MOV  X14, X21
    ST1 { V29.S }[0x3], [X14], #4
    MOV  X14, X21
    LD1 { V13.S }[0x3], [X14], #4
    ADD  X21, X21, X22
    ST1 { V31.S }[0x2], [X21], X11
    LD1 { V11.S }[0x2], [X21], X11
    ADD  X21, X21, X22
    MOV  X14, X21
    ST1 { V2.D }[0x1], [X14], #8
    MOV  X14, X21
    LD1 { V31.D }[0x1], [X14], #8
    ADD  X21, X21, X22
    ST1 { V5.D }[0x0], [X21], X11
    LD1 { V29.D }[0x1], [X21], X11
    ADD  X21, X21, X22, LSR #0
    MOV  X14, X21
    ST1 { V13.B }[0x7], [X14], #1
    MOV  X14, X21
    LD1 { V2.B }[0x7], [X14], #1
    ADD  X21, X21, X22, ASR #0
    ST1 { V13.B }[0xf], [X21], X11
    LD1 { V3.B }[0x8], [X21], X11
    ADD  X21, X21, X22, ASR #0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MRS  X6, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D1
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D2
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X10, #0xa500, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D3
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D4
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D5
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D6
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D7
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D8
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D9
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D10
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D11
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D12
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D13
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D14
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D15
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D16
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D17
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D18
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D19
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D20
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D21
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D22
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D23
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D24
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D25
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D26
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D27
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D28
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D29
    MOVZ  X10, #0xa500, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D30
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D31
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X8, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X6
    FMOV  D1, X27
    FMOV  V1.D[1], X23
    FMOV  D2, X26
    FMOV  V2.D[1], X6
    FMOV  D3, X8
    FMOV  V3.D[1], X29
    FMOV  D4, X22
    FMOV  V4.D[1], X10
    FMOV  D5, X19
    FMOV  V5.D[1], X8
    FMOV  D6, X22
    FMOV  V6.D[1], X8
    FMOV  D7, X29
    FMOV  V7.D[1], X21
    FMOV  D8, X10
    FMOV  V8.D[1], X6
    FMOV  D9, X18
    FMOV  V9.D[1], X25
    FMOV  D10, X17
    FMOV  V10.D[1], X7
    FMOV  D11, X24
    FMOV  V11.D[1], X17
    FMOV  D12, X19
    FMOV  V12.D[1], X27
    FMOV  D13, X6
    FMOV  V13.D[1], X17
    FMOV  D14, X23
    FMOV  V14.D[1], X5
    FMOV  D15, X8
    FMOV  V15.D[1], X21
    FMOV  D16, X6
    FMOV  V16.D[1], X9
    FMOV  D17, X22
    FMOV  V17.D[1], X5
    FMOV  D18, X17
    FMOV  V18.D[1], X10
    FMOV  D19, X26
    FMOV  V19.D[1], X20
    FMOV  D20, X18
    FMOV  V20.D[1], X21
    FMOV  D21, X22
    FMOV  V21.D[1], X6
    FMOV  D22, X10
    FMOV  V22.D[1], X16
    FMOV  D23, X20
    FMOV  V23.D[1], X20
    FMOV  D24, X22
    FMOV  V24.D[1], X18
    FMOV  D25, X19
    FMOV  V25.D[1], X24
    FMOV  D26, X17
    FMOV  V26.D[1], X11
    FMOV  D27, X22
    FMOV  V27.D[1], X7
    FMOV  D28, X29
    FMOV  V28.D[1], X5
    FMOV  D29, X10
    FMOV  V29.D[1], X25
    FMOV  D30, X27
    FMOV  V30.D[1], X26
    FMOV  D31, X16
    FMOV  V31.D[1], X16
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X17, #0x1400, LSL #0
    ADD  X20, X30, X17
    MOV  X26, X20
    ST1 { V30.16B, V31.16B }, [X26], #32
    MOV  X26, X20
    LD1 { V27.16B, V28.16B }, [X26], #32
    ADD  X20, X20, X12, ASR #0
    MOV  X26, X20
    ST1 { V20.2D, V21.2D }, [X26], #32
    MOV  X26, X20
    LD1 { V6.2D, V7.2D }, [X26], #32
    ADD  X20, X20, X12, LSR #0
    MOV  X26, X20
    ST1 { V14.4S, V15.4S }, [X26], #32
    MOV  X26, X20
    LD1 { V29.4S, V30.4S }, [X26], #32
    ADD  X20, X20, X12, ASR #0
    MOV  X26, X20
    ST1 { V6.8H, V7.8H }, [X26], #32
    MOV  X26, X20
    LD1 { V9.8H, V10.8H }, [X26], #32
    ADD  X20, X20, X12, LSR #0
    MOV  X26, X20
    ST1 { V4.4H, V5.4H }, [X26], #16
    MOV  X26, X20
    LD1 { V5.1D, V6.1D }, [X26], #16
    ADD  X20, X20, X12, ASR #0
    MOV  X26, X20
    ST1 { V9.1D, V10.1D }, [X26], #16
    MOV  X26, X20
    LD1 { V26.1D, V27.1D }, [X26], #16
    ADD  X20, X20, X12, ASR #0
    MOV  X26, X20
    ST1 { V29.2S, V30.2S }, [X26], #16
    MOV  X26, X20
    LD1 { V28.2S, V29.2S }, [X26], #16
    ADD  X20, X20, X12
    MOV  X26, X20
    ST1 { V10.4H, V11.4H }, [X26], #16
    MOV  X26, X20
    LD1 { V22.4H, V23.4H }, [X26], #16
    ADD  X20, X20, X12
    MOV  X26, X20
    ST1 { V9.8B, V10.8B }, [X26], #16
    MOV  X26, X20
    LD1 { V24.8B, V25.8B }, [X26], #16
    ADD  X20, X20, X12, LSR #0
    ST1 { V24.2D, V25.2D }, [X20], X23
    LD1 { V11.4S, V12.4S }, [X20], X23
    ADD  X20, X20, X12, ASR #0
    ST1 { V27.16B, V28.16B }, [X20], X23
    LD1 { V31.16B, V0.16B }, [X20], X23
    ADD  X20, X20, X12
    ST1 { V5.2D, V6.2D }, [X20], X23
    LD1 { V27.2D, V28.2D }, [X20], X23
    ADD  X20, X20, X12, ASR #0
    ST1 { V3.4S, V4.4S }, [X20], X23
    LD1 { V19.4S, V20.4S }, [X20], X23
    ADD  X20, X20, X12
    ST1 { V19.8H, V20.8H }, [X20], X23
    LD1 { V29.8H, V30.8H }, [X20], X23
    ADD  X20, X20, X12
    ST1 { V29.4H, V30.4H }, [X20], X23
    LD1 { V8.2S, V9.2S }, [X20], X23
    ADD  X20, X20, X12, LSR #0
    ST1 { V27.1D, V28.1D }, [X20], X23
    LD1 { V14.1D, V15.1D }, [X20], X23
    ADD  X20, X20, X12, ASR #0
    ST1 { V16.2S, V17.2S }, [X20], X23
    LD1 { V7.2S, V8.2S }, [X20], X23
    ADD  X20, X20, X12, ASR #0
    ST1 { V31.4H, V0.4H }, [X20], X23
    LD1 { V7.4H, V8.4H }, [X20], X23
    ADD  X20, X20, X12, ASR #0
    ST1 { V11.8B, V12.8B }, [X20], X23
    LD1 { V23.8B, V24.8B }, [X20], X23
    ADD  X20, X20, X12, ASR #0
    ST1 { V30.H }[0x6], [X20]
    LD1 { V14.H }[0x5], [X20]
    ADD  X20, X20, X12, LSR #0
    ST1 { V9.S }[0x1], [X20]
    LD1 { V27.S }[0x0], [X20]
    ADD  X20, X20, X12
    ST1 { V10.D }[0x1], [X20]
    LD1 { V31.D }[0x0], [X20]
    ADD  X20, X20, X12, LSR #0
    ST1 { V23.B }[0x0], [X20]
    LD1 { V19.B }[0xd], [X20]
    ADD  X20, X20, X12
    MOV  X26, X20
    ST1 { V27.H }[0x2], [X26], #2
    MOV  X26, X20
    LD1 { V20.H }[0x6], [X26], #2
    ADD  X20, X20, X12
    ST1 { V19.H }[0x0], [X20], X23
    LD1 { V23.H }[0x7], [X20], X23
    ADD  X20, X20, X12, LSR #0
    MOV  X26, X20
    ST1 { V20.S }[0x2], [X26], #4
    MOV  X26, X20
    LD1 { V27.S }[0x3], [X26], #4
    ADD  X20, X20, X12, LSR #0
    ST1 { V31.S }[0x2], [X20], X23
    LD1 { V31.S }[0x3], [X20], X23
    ADD  X20, X20, X12
    MOV  X26, X20
    ST1 { V31.D }[0x0], [X26], #8
    MOV  X26, X20
    LD1 { V31.D }[0x0], [X26], #8
    ADD  X20, X20, X12, LSR #0
    ST1 { V23.D }[0x1], [X20], X23
    LD1 { V23.D }[0x0], [X20], X23
    ADD  X20, X20, X12, ASR #0
    MOV  X26, X20
    ST1 { V31.B }[0xc], [X26], #1
    MOV  X26, X20
    LD1 { V31.B }[0x6], [X26], #1
    ADD  X20, X20, X12, LSR #0
    ST1 { V18.B }[0x7], [X20], X23
    LD1 { V9.B }[0x2], [X20], X23
    ADD  X20, X20, X12
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X14, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MRS  X6, FPSR
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D1
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D2
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D3
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D4
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D5
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D6
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D7
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D8
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D9
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D10
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D11
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D12
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D13
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D14
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D15
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D16
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D17
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D18
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D19
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D20
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D21
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D22
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D23
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D24
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D25
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D26
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D27
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D28
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D29
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D30
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    FMOV  X6, D31
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a00, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D1, X16
    FMOV  V1.D[1], X9
    FMOV  D2, X22
    FMOV  V2.D[1], X6
    FMOV  D3, X7
    FMOV  V3.D[1], X25
    FMOV  D4, X11
    FMOV  V4.D[1], X24
    FMOV  D5, X16
    FMOV  V5.D[1], X27
    FMOV  D6, X25
    FMOV  V6.D[1], X29
    FMOV  D7, X23
    FMOV  V7.D[1], X6
    FMOV  D8, X6
    FMOV  V8.D[1], X14
    FMOV  D9, X20
    FMOV  V9.D[1], X15
    FMOV  D10, X13
    FMOV  V10.D[1], X21
    FMOV  D11, X21
    FMOV  V11.D[1], X29
    FMOV  D12, X20
    FMOV  V12.D[1], X22
    FMOV  D13, X12
    FMOV  V13.D[1], X29
    FMOV  D14, X10
    FMOV  V14.D[1], X24
    FMOV  D15, X28
    FMOV  V15.D[1], X13
    FMOV  D16, X9
    FMOV  V16.D[1], X21
    FMOV  D17, X27
    FMOV  V17.D[1], X20
    FMOV  D18, X20
    FMOV  V18.D[1], X15
    FMOV  D19, X6
    FMOV  V19.D[1], X7
    FMOV  D20, X13
    FMOV  V20.D[1], X14
    FMOV  D21, X29
    FMOV  V21.D[1], X8
    FMOV  D22, X5
    FMOV  V22.D[1], X7
    FMOV  D23, X17
    FMOV  V23.D[1], X21
    FMOV  D24, X13
    FMOV  V24.D[1], X26
    FMOV  D25, X14
    FMOV  V25.D[1], X8
    FMOV  D26, X28
    FMOV  V26.D[1], X24
    FMOV  D27, X27
    FMOV  V27.D[1], X13
    FMOV  D28, X26
    FMOV  V28.D[1], X5
    FMOV  D29, X20
    FMOV  V29.D[1], X16
    FMOV  D30, X14
    FMOV  V30.D[1], X8
    FMOV  D31, X29
    FMOV  V31.D[1], X12
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X6, #0x1900, LSL #0
    ADD  X7, X30, X6, LSR #0
    MOV  X5, X7
    ST1 { V30.16B, V31.16B }, [X5], #32
    MOV  X5, X7
    LD1 { V30.16B, V31.16B }, [X5], #32
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V28.2D, V29.2D }, [X5], #32
    MOV  X5, X7
    LD1 { V6.2D, V7.2D }, [X5], #32
    ADD  X7, X7, X22, ASR #0
    MOV  X5, X7
    ST1 { V0.4S, V1.4S }, [X5], #32
    MOV  X5, X7
    LD1 { V22.4S, V23.4S }, [X5], #32
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V19.8H, V20.8H }, [X5], #32
    MOV  X5, X7
    LD1 { V10.8H, V11.8H }, [X5], #32
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V1.2S, V2.2S }, [X5], #16
    MOV  X5, X7
    LD1 { V22.4H, V23.4H }, [X5], #16
    ADD  X7, X7, X22
    MOV  X5, X7
    ST1 { V6.1D, V7.1D }, [X5], #16
    MOV  X5, X7
    LD1 { V27.1D, V28.1D }, [X5], #16
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V10.2S, V11.2S }, [X5], #16
    MOV  X5, X7
    LD1 { V2.2S, V3.2S }, [X5], #16
    ADD  X7, X7, X22, ASR #0
    MOV  X5, X7
    ST1 { V27.4H, V28.4H }, [X5], #16
    MOV  X5, X7
    LD1 { V10.4H, V11.4H }, [X5], #16
    ADD  X7, X7, X22, ASR #0
    MOV  X5, X7
    ST1 { V10.8B, V11.8B }, [X5], #16
    MOV  X5, X7
    LD1 { V23.8B, V24.8B }, [X5], #16
    ADD  X7, X7, X22, ASR #0
    ST1 { V2.2D, V3.2D }, [X7], X19
    LD1 { V20.8H, V21.8H }, [X7], X19
    ADD  X7, X7, X22, LSR #0
    ST1 { V23.16B, V24.16B }, [X7], X19
    LD1 { V26.16B, V27.16B }, [X7], X19
    ADD  X7, X7, X22, ASR #0
    ST1 { V15.2D, V16.2D }, [X7], X19
    LD1 { V0.2D, V1.2D }, [X7], X19
    ADD  X7, X7, X22, LSR #0
    ST1 { V17.4S, V18.4S }, [X7], X19
    LD1 { V16.4S, V17.4S }, [X7], X19
    ADD  X7, X7, X22, ASR #0
    ST1 { V26.8H, V27.8H }, [X7], X19
    LD1 { V4.8H, V5.8H }, [X7], X19
    ADD  X7, X7, X22
    ST1 { V16.8B, V17.8B }, [X7], X19
    LD1 { V29.4H, V30.4H }, [X7], X19
    ADD  X7, X7, X22, ASR #0
    ST1 { V25.1D, V26.1D }, [X7], X19
    LD1 { V12.1D, V13.1D }, [X7], X19
    ADD  X7, X7, X22, LSR #0
    ST1 { V28.2S, V29.2S }, [X7], X19
    LD1 { V15.2S, V16.2S }, [X7], X19
    ADD  X7, X7, X22, ASR #0
    ST1 { V4.4H, V5.4H }, [X7], X19
    LD1 { V13.4H, V14.4H }, [X7], X19
    ADD  X7, X7, X22, LSR #0
    ST1 { V0.8B, V1.8B }, [X7], X19
    LD1 { V20.8B, V21.8B }, [X7], X19
    ADD  X7, X7, X22, ASR #0
    ST1 { V30.H }[0x0], [X7]
    LD1 { V0.H }[0x5], [X7]
    ADD  X7, X7, X22, LSR #0
    ST1 { V11.S }[0x1], [X7]
    LD1 { V26.S }[0x0], [X7]
    ADD  X7, X7, X22, LSR #0
    ST1 { V14.D }[0x1], [X7]
    LD1 { V4.D }[0x1], [X7]
    ADD  X7, X7, X22
    ST1 { V13.B }[0x3], [X7]
    LD1 { V13.B }[0xa], [X7]
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V21.H }[0x6], [X5], #2
    MOV  X5, X7
    LD1 { V12.H }[0x0], [X5], #2
    ADD  X7, X7, X22
    ST1 { V12.H }[0x3], [X7], X19
    LD1 { V21.H }[0x3], [X7], X19
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V26.S }[0x3], [X5], #4
    MOV  X5, X7
    LD1 { V14.S }[0x2], [X5], #4
    ADD  X7, X7, X22
    ST1 { V14.S }[0x0], [X7], X19
    LD1 { V27.S }[0x2], [X7], X19
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V13.D }[0x1], [X5], #8
    MOV  X5, X7
    LD1 { V14.D }[0x0], [X5], #8
    ADD  X7, X7, X22, LSR #0
    ST1 { V19.D }[0x1], [X7], X19
    LD1 { V12.D }[0x1], [X7], X19
    ADD  X7, X7, X22, LSR #0
    MOV  X5, X7
    ST1 { V12.B }[0x1], [X5], #1
    MOV  X5, X7
    LD1 { V16.B }[0xb], [X5], #1
    ADD  X7, X7, X22, ASR #0
    ST1 { V27.B }[0x4], [X7], X19
    LD1 { V26.B }[0x0], [X7], X19
    ADD  X7, X7, X22, ASR #0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X10, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP04_TestFail
    MRS  X18, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D1
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D2
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D3
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D4
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D5
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D6
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D7
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D8
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D9
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D10
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D11
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D12
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5, LSL #16
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D13
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D14
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5, LSL #16
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D15
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D16
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D17
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D18
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D19
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D20
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D21
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D22
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D23
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D24
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D25
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D26
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D27
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D28
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D29
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D30
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X18, D31
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X15, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X25
    FMOV  D1, X22
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X25
    FMOV  V4.D[1], X6
    FMOV  D5, X8
    FMOV  V5.D[1], X12
    FMOV  D6, X7
    FMOV  V6.D[1], X13
    FMOV  D7, X17
    FMOV  V7.D[1], X9
    FMOV  D8, X6
    FMOV  V8.D[1], X25
    FMOV  D9, X6
    FMOV  V9.D[1], X17
    FMOV  D10, X21
    FMOV  V10.D[1], X10
    FMOV  D11, X25
    FMOV  V11.D[1], X7
    FMOV  D12, X29
    FMOV  V12.D[1], X11
    FMOV  D13, X20
    FMOV  V13.D[1], X23
    FMOV  D14, X5
    FMOV  V14.D[1], X7
    FMOV  D15, X18
    FMOV  V15.D[1], X27
    FMOV  D16, X25
    FMOV  V16.D[1], X21
    FMOV  D17, X9
    FMOV  V17.D[1], X28
    FMOV  D18, X10
    FMOV  V18.D[1], X21
    FMOV  D19, X9
    FMOV  V19.D[1], X21
    FMOV  D20, X8
    FMOV  V20.D[1], X28
    FMOV  D21, X14
    FMOV  V21.D[1], X15
    FMOV  D22, X15
    FMOV  V22.D[1], X7
    FMOV  D23, X29
    FMOV  V23.D[1], X23
    FMOV  D24, X12
    FMOV  V24.D[1], X8
    FMOV  D25, X21
    FMOV  V25.D[1], X17
    FMOV  D26, X12
    FMOV  V26.D[1], X20
    FMOV  D27, X7
    FMOV  V27.D[1], X9
    FMOV  D28, X19
    FMOV  V28.D[1], X22
    FMOV  D29, X23
    FMOV  V29.D[1], X8
    FMOV  D30, X22
    FMOV  V30.D[1], X16
    FMOV  D31, X22
    FMOV  V31.D[1], X15
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X6, #0x1e00, LSL #0
    ADD  X26, X30, X6, LSR #0
    MOV  X19, X26
    ST1 { V6.16B, V7.16B }, [X19], #32
    MOV  X19, X26
    LD1 { V26.16B, V27.16B }, [X19], #32
    ADD  X26, X26, X14, ASR #0
    MOV  X19, X26
    ST1 { V5.2D, V6.2D }, [X19], #32
    MOV  X19, X26
    LD1 { V26.2D, V27.2D }, [X19], #32
    ADD  X26, X26, X14, LSR #0
    MOV  X19, X26
    ST1 { V30.4S, V31.4S }, [X19], #32
    MOV  X19, X26
    LD1 { V28.4S, V29.4S }, [X19], #32
    ADD  X26, X26, X14, ASR #0
    MOV  X19, X26
    ST1 { V24.8H, V25.8H }, [X19], #32
    MOV  X19, X26
    LD1 { V24.8H, V25.8H }, [X19], #32
    ADD  X26, X26, X14
    MOV  X19, X26
    ST1 { V20.8B, V21.8B }, [X19], #16
    MOV  X19, X26
    LD1 { V8.1D, V9.1D }, [X19], #16
    ADD  X26, X26, X14, ASR #0
    MOV  X19, X26
    ST1 { V25.1D, V26.1D }, [X19], #16
    MOV  X19, X26
    LD1 { V6.1D, V7.1D }, [X19], #16
    ADD  X26, X26, X14, ASR #0
    MOV  X19, X26
    ST1 { V0.2S, V1.2S }, [X19], #16
    MOV  X19, X26
    LD1 { V21.2S, V22.2S }, [X19], #16
    ADD  X26, X26, X14
    MOV  X19, X26
    ST1 { V6.4H, V7.4H }, [X19], #16
    MOV  X19, X26
    LD1 { V16.4H, V17.4H }, [X19], #16
    ADD  X26, X26, X14
    MOV  X19, X26
    ST1 { V17.8B, V18.8B }, [X19], #16
    MOV  X19, X26
    LD1 { V16.8B, V17.8B }, [X19], #16
    ADD  X26, X26, X14
    ST1 { V16.4S, V17.4S }, [X26], X25
    LD1 { V2.8H, V3.8H }, [X26], X25
    ADD  X26, X26, X14, LSR #0
    ST1 { V2.16B, V3.16B }, [X26], X25
    LD1 { V19.16B, V20.16B }, [X26], X25
    ADD  X26, X26, X14
    ST1 { V28.2D, V29.2D }, [X26], X25
    LD1 { V11.2D, V12.2D }, [X26], X25
    ADD  X26, X26, X14, LSR #0
    ST1 { V19.4S, V20.4S }, [X26], X25
    LD1 { V6.4S, V7.4S }, [X26], X25
    ADD  X26, X26, X14, ASR #0
    ST1 { V6.8H, V7.8H }, [X26], X25
    LD1 { V19.8H, V20.8H }, [X26], X25
    ADD  X26, X26, X14, LSR #0
    ST1 { V19.2S, V20.2S }, [X26], X25
    LD1 { V17.4H, V18.4H }, [X26], X25
    ADD  X26, X26, X14, LSR #0
    ST1 { V17.1D, V18.1D }, [X26], X25
    LD1 { V19.1D, V20.1D }, [X26], X25
    ADD  X26, X26, X14, LSR #0
    ST1 { V11.2S, V12.2S }, [X26], X25
    LD1 { V14.2S, V15.2S }, [X26], X25
    ADD  X26, X26, X14
    ST1 { V20.4H, V21.4H }, [X26], X25
    LD1 { V28.4H, V29.4H }, [X26], X25
    ADD  X26, X26, X14
    ST1 { V28.8B, V29.8B }, [X26], X25
    LD1 { V20.8B, V21.8B }, [X26], X25
    ADD  X26, X26, X14, LSR #0
    ST1 { V14.H }[0x4], [X26]
    LD1 { V1.H }[0x4], [X26]
    ADD  X26, X26, X14, ASR #0
    ST1 { V15.S }[0x3], [X26]
    LD1 { V28.S }[0x0], [X26]
    ADD  X26, X26, X14
    ST1 { V26.D }[0x1], [X26]
    LD1 { V26.D }[0x0], [X26]
    ADD  X26, X26, X14, ASR #0
    ST1 { V10.B }[0x3], [X26]
    LD1 { V14.B }[0xb], [X26]
    ADD  X26, X26, X14
    MOV  X19, X26
    ST1 { V18.H }[0x0], [X19], #2
    MOV  X19, X26
    LD1 { V7.H }[0x1], [X19], #2
    ADD  X26, X26, X14, LSR #0
    ST1 { V7.H }[0x4], [X26], X25
    LD1 { V16.H }[0x5], [X26], X25
    ADD  X26, X26, X14
    MOV  X19, X26
    ST1 { V3.S }[0x2], [X19], #4
    MOV  X19, X26
    LD1 { V27.S }[0x2], [X19], #4
    ADD  X26, X26, X14, LSR #0
    ST1 { V28.S }[0x1], [X26], X25
    LD1 { V10.S }[0x1], [X26], X25
    ADD  X26, X26, X14, ASR #0
    MOV  X19, X26
    ST1 { V14.D }[0x0], [X19], #8
    MOV  X19, X26
    LD1 { V7.D }[0x0], [X19], #8
    ADD  X26, X26, X14
    ST1 { V27.D }[0x1], [X26], X25
    LD1 { V14.D }[0x1], [X26], X25
    ADD  X26, X26, X14, LSR #0
    MOV  X19, X26
    ST1 { V10.B }[0xa], [X19], #1
    MOV  X19, X26
    LD1 { V28.B }[0x5], [X19], #1
    ADD  X26, X26, X14, ASR #0
    ST1 { V31.B }[0x1], [X26], X25
    LD1 { V31.B }[0x1], [X26], X25
    ADD  X26, X26, X14, ASR #0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X24, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP04_TestFail
    MRS  X10, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D1
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D3
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D6
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D7
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D9
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D11
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D16
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D17
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D18
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D19
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D20
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D21
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D22
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D23
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D26
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D28
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D29
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D30
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D31
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X18, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
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
    FMOV  V0.D[1], X9
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X28
    FMOV  D3, X10
    FMOV  V3.D[1], X26
    FMOV  D4, X27
    FMOV  V4.D[1], X22
    FMOV  D5, X10
    FMOV  V5.D[1], X17
    FMOV  D6, X27
    FMOV  V6.D[1], X19
    FMOV  D7, X6
    FMOV  V7.D[1], X16
    FMOV  D8, X6
    FMOV  V8.D[1], X9
    FMOV  D9, X8
    FMOV  V9.D[1], X23
    FMOV  D10, X24
    FMOV  V10.D[1], X20
    FMOV  D11, X28
    FMOV  V11.D[1], X28
    FMOV  D12, X24
    FMOV  V12.D[1], X22
    FMOV  D13, X23
    FMOV  V13.D[1], X5
    FMOV  D14, X12
    FMOV  V14.D[1], X19
    FMOV  D15, X22
    FMOV  V15.D[1], X27
    FMOV  D16, X13
    FMOV  V16.D[1], X8
    FMOV  D17, X22
    FMOV  V17.D[1], X19
    FMOV  D18, X16
    FMOV  V18.D[1], X23
    FMOV  D19, X29
    FMOV  V19.D[1], X24
    FMOV  D20, X24
    FMOV  V20.D[1], X24
    FMOV  D21, X7
    FMOV  V21.D[1], X16
    FMOV  D22, X7
    FMOV  V22.D[1], X13
    FMOV  D23, X24
    FMOV  V23.D[1], X11
    FMOV  D24, X13
    FMOV  V24.D[1], X11
    FMOV  D25, X22
    FMOV  V25.D[1], X22
    FMOV  D26, X27
    FMOV  V26.D[1], X13
    FMOV  D27, X16
    FMOV  V27.D[1], X10
    FMOV  D28, X12
    FMOV  V28.D[1], X26
    FMOV  D29, X15
    FMOV  V29.D[1], X10
    FMOV  D30, X13
    FMOV  V30.D[1], X10
    FMOV  D31, X20
    FMOV  V31.D[1], X28
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X14, #0x2300, LSL #0
    ADD  X6, X30, X14
    MOV  X17, X6
    ST1 { V14.16B, V15.16B }, [X17], #32
    MOV  X17, X6
    LD1 { V13.16B, V14.16B }, [X17], #32
    ADD  X6, X6, X24, ASR #0
    MOV  X17, X6
    ST1 { V21.2D, V22.2D }, [X17], #32
    MOV  X17, X6
    LD1 { V4.2D, V5.2D }, [X17], #32
    ADD  X6, X6, X24, ASR #0
    MOV  X17, X6
    ST1 { V21.4S, V22.4S }, [X17], #32
    MOV  X17, X6
    LD1 { V23.4S, V24.4S }, [X17], #32
    ADD  X6, X6, X24
    MOV  X17, X6
    ST1 { V31.8H, V0.8H }, [X17], #32
    MOV  X17, X6
    LD1 { V5.8H, V6.8H }, [X17], #32
    ADD  X6, X6, X24, ASR #0
    MOV  X17, X6
    ST1 { V5.4H, V6.4H }, [X17], #16
    MOV  X17, X6
    LD1 { V28.8B, V29.8B }, [X17], #16
    ADD  X6, X6, X24, LSR #0
    MOV  X17, X6
    ST1 { V28.1D, V29.1D }, [X17], #16
    MOV  X17, X6
    LD1 { V6.1D, V7.1D }, [X17], #16
    ADD  X6, X6, X24, ASR #0
    MOV  X17, X6
    ST1 { V6.2S, V7.2S }, [X17], #16
    MOV  X17, X6
    LD1 { V24.2S, V25.2S }, [X17], #16
    ADD  X6, X6, X24
    MOV  X17, X6
    ST1 { V24.4H, V25.4H }, [X17], #16
    MOV  X17, X6
    LD1 { V20.4H, V21.4H }, [X17], #16
    ADD  X6, X6, X24
    MOV  X17, X6
    ST1 { V20.8B, V21.8B }, [X17], #16
    MOV  X17, X6
    LD1 { V7.8B, V8.8B }, [X17], #16
    ADD  X6, X6, X24
    ST1 { V22.2D, V23.2D }, [X6], X7
    LD1 { V7.16B, V8.16B }, [X6], X7
    ADD  X6, X6, X24, ASR #0
    ST1 { V4.16B, V5.16B }, [X6], X7
    LD1 { V18.16B, V19.16B }, [X6], X7
    ADD  X6, X6, X24, ASR #0
    ST1 { V13.2D, V14.2D }, [X6], X7
    LD1 { V8.2D, V9.2D }, [X6], X7
    ADD  X6, X6, X24, LSR #0
    ST1 { V12.4S, V13.4S }, [X6], X7
    LD1 { V13.4S, V14.4S }, [X6], X7
    ADD  X6, X6, X24, ASR #0
    ST1 { V18.8H, V19.8H }, [X6], X7
    LD1 { V8.8H, V9.8H }, [X6], X7
    ADD  X6, X6, X24, ASR #0
    ST1 { V6.8B, V7.8B }, [X6], X7
    LD1 { V27.1D, V28.1D }, [X6], X7
    ADD  X6, X6, X24
    ST1 { V0.1D, V1.1D }, [X6], X7
    LD1 { V10.1D, V11.1D }, [X6], X7
    ADD  X6, X6, X24
    ST1 { V16.2S, V17.2S }, [X6], X7
    LD1 { V4.2S, V5.2S }, [X6], X7
    ADD  X6, X6, X24
    ST1 { V10.4H, V11.4H }, [X6], X7
    LD1 { V10.4H, V11.4H }, [X6], X7
    ADD  X6, X6, X24
    ST1 { V18.8B, V19.8B }, [X6], X7
    LD1 { V12.8B, V13.8B }, [X6], X7
    ADD  X6, X6, X24
    ST1 { V16.H }[0x4], [X6]
    LD1 { V10.H }[0x6], [X6]
    ADD  X6, X6, X24, ASR #0
    ST1 { V5.S }[0x1], [X6]
    LD1 { V15.S }[0x1], [X6]
    ADD  X6, X6, X24, LSR #0
    ST1 { V10.D }[0x0], [X6]
    LD1 { V18.D }[0x0], [X6]
    ADD  X6, X6, X24, LSR #0
    ST1 { V15.B }[0xd], [X6]
    LD1 { V16.B }[0x4], [X6]
    ADD  X6, X6, X24, ASR #0
    MOV  X17, X6
    ST1 { V4.H }[0x1], [X17], #2
    MOV  X17, X6
    LD1 { V4.H }[0x3], [X17], #2
    ADD  X6, X6, X24
    ST1 { V4.H }[0x5], [X6], X7
    LD1 { V26.H }[0x6], [X6], X7
    ADD  X6, X6, X24, ASR #0
    MOV  X17, X6
    ST1 { V24.S }[0x2], [X17], #4
    MOV  X17, X6
    LD1 { V24.S }[0x3], [X17], #4
    ADD  X6, X6, X24, LSR #0
    ST1 { V1.S }[0x2], [X6], X7
    LD1 { V4.S }[0x2], [X6], X7
    ADD  X6, X6, X24, LSR #0
    MOV  X17, X6
    ST1 { V8.D }[0x0], [X17], #8
    MOV  X17, X6
    LD1 { V1.D }[0x1], [X17], #8
    ADD  X6, X6, X24
    ST1 { V24.D }[0x0], [X6], X7
    LD1 { V7.D }[0x0], [X6], X7
    ADD  X6, X6, X24, ASR #0
    MOV  X17, X6
    ST1 { V16.B }[0x0], [X17], #1
    MOV  X17, X6
    LD1 { V20.B }[0xe], [X17], #1
    ADD  X6, X6, X24, LSR #0
    ST1 { V20.B }[0x9], [X6], X7
    LD1 { V16.B }[0xc], [X6], X7
    ADD  X6, X6, X24, ASR #0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X25, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MRS  X5, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D12
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa500, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D18
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D24
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D28
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
    FMOV  X5, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X11, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D0, X19
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X13
    FMOV  D5, X16
    FMOV  V5.D[1], X18
    FMOV  D6, X29
    FMOV  V6.D[1], X5
    FMOV  D7, X6
    FMOV  V7.D[1], X24
    FMOV  D8, X10
    FMOV  V8.D[1], X17
    FMOV  D9, X22
    FMOV  V9.D[1], X7
    FMOV  D10, X5
    FMOV  V10.D[1], X14
    FMOV  D11, X22
    FMOV  V11.D[1], X28
    FMOV  D12, X14
    FMOV  V12.D[1], X26
    FMOV  D13, X14
    FMOV  V13.D[1], X19
    FMOV  D14, X12
    FMOV  V14.D[1], X22
    FMOV  D15, X7
    FMOV  V15.D[1], X8
    FMOV  D16, X29
    FMOV  V16.D[1], X9
    FMOV  D17, X28
    FMOV  V17.D[1], X27
    FMOV  D18, X24
    FMOV  V18.D[1], X22
    FMOV  D19, X6
    FMOV  V19.D[1], X28
    FMOV  D20, X9
    FMOV  V20.D[1], X8
    FMOV  D21, X10
    FMOV  V21.D[1], X14
    FMOV  D22, X13
    FMOV  V22.D[1], X18
    FMOV  D23, X8
    FMOV  V23.D[1], X21
    FMOV  D24, X28
    FMOV  V24.D[1], X7
    FMOV  D25, X25
    FMOV  V25.D[1], X18
    FMOV  D26, X5
    FMOV  V26.D[1], X8
    FMOV  D27, X5
    FMOV  V27.D[1], X22
    FMOV  D28, X5
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X13
    FMOV  D30, X13
    FMOV  V30.D[1], X16
    FMOV  D31, X7
    FMOV  V31.D[1], X29
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X25, #0x2800, LSL #0
    ADD  X9, X30, X25
    MOV  X7, X9
    ST1 { V0.16B, V1.16B }, [X7], #32
    MOV  X7, X9
    LD1 { V13.16B, V14.16B }, [X7], #32
    ADD  X9, X9, X19
    MOV  X7, X9
    ST1 { V13.2D, V14.2D }, [X7], #32
    MOV  X7, X9
    LD1 { V25.2D, V26.2D }, [X7], #32
    ADD  X9, X9, X19, ASR #0
    MOV  X7, X9
    ST1 { V25.4S, V26.4S }, [X7], #32
    MOV  X7, X9
    LD1 { V4.4S, V5.4S }, [X7], #32
    ADD  X9, X9, X19
    MOV  X7, X9
    ST1 { V4.8H, V5.8H }, [X7], #32
    MOV  X7, X9
    LD1 { V30.8H, V31.8H }, [X7], #32
    ADD  X9, X9, X19, ASR #0
    MOV  X7, X9
    ST1 { V1.4H, V2.4H }, [X7], #16
    MOV  X7, X9
    LD1 { V11.8B, V12.8B }, [X7], #16
    ADD  X9, X9, X19, LSR #0
    MOV  X7, X9
    ST1 { V11.1D, V12.1D }, [X7], #16
    MOV  X7, X9
    LD1 { V2.1D, V3.1D }, [X7], #16
    ADD  X9, X9, X19
    MOV  X7, X9
    ST1 { V2.2S, V3.2S }, [X7], #16
    MOV  X7, X9
    LD1 { V6.2S, V7.2S }, [X7], #16
    ADD  X9, X9, X19, LSR #0
    MOV  X7, X9
    ST1 { V11.4H, V12.4H }, [X7], #16
    MOV  X7, X9
    LD1 { V24.4H, V25.4H }, [X7], #16
    ADD  X9, X9, X19, ASR #0
    MOV  X7, X9
    ST1 { V30.8B, V31.8B }, [X7], #16
    MOV  X7, X9
    LD1 { V29.8B, V30.8B }, [X7], #16
    ADD  X9, X9, X19
    ST1 { V17.8H, V18.8H }, [X9], X20
    LD1 { V15.8H, V16.8H }, [X9], X20
    ADD  X9, X9, X19, LSR #0
    ST1 { V6.16B, V7.16B }, [X9], X20
    LD1 { V11.16B, V12.16B }, [X9], X20
    ADD  X9, X9, X19, ASR #0
    ST1 { V15.2D, V16.2D }, [X9], X20
    LD1 { V14.2D, V15.2D }, [X9], X20
    ADD  X9, X9, X19, LSR #0
    ST1 { V14.4S, V15.4S }, [X9], X20
    LD1 { V26.4S, V27.4S }, [X9], X20
    ADD  X9, X9, X19
    ST1 { V29.8H, V30.8H }, [X9], X20
    LD1 { V19.8H, V20.8H }, [X9], X20
    ADD  X9, X9, X19, ASR #0
    ST1 { V24.1D, V25.1D }, [X9], X20
    LD1 { V7.2S, V8.2S }, [X9], X20
    ADD  X9, X9, X19, LSR #0
    ST1 { V26.1D, V27.1D }, [X9], X20
    LD1 { V4.1D, V5.1D }, [X9], X20
    ADD  X9, X9, X19, LSR #0
    ST1 { V7.2S, V8.2S }, [X9], X20
    LD1 { V5.2S, V6.2S }, [X9], X20
    ADD  X9, X9, X19, ASR #0
    ST1 { V19.4H, V20.4H }, [X9], X20
    LD1 { V24.4H, V25.4H }, [X9], X20
    ADD  X9, X9, X19, LSR #0
    ST1 { V21.8B, V22.8B }, [X9], X20
    LD1 { V8.8B, V9.8B }, [X9], X20
    ADD  X9, X9, X19, LSR #0
    ST1 { V24.H }[0x1], [X9]
    LD1 { V24.H }[0x2], [X9]
    ADD  X9, X9, X19, ASR #0
    ST1 { V25.S }[0x3], [X9]
    LD1 { V21.S }[0x2], [X9]
    ADD  X9, X9, X19, ASR #0
    ST1 { V8.D }[0x0], [X9]
    LD1 { V14.D }[0x0], [X9]
    ADD  X9, X9, X19, LSR #0
    ST1 { V6.B }[0x4], [X9]
    LD1 { V12.B }[0xf], [X9]
    ADD  X9, X9, X19, ASR #0
    MOV  X7, X9
    ST1 { V9.H }[0x2], [X7], #2
    MOV  X7, X9
    LD1 { V9.H }[0x6], [X7], #2
    ADD  X9, X9, X19, ASR #0
    ST1 { V21.H }[0x4], [X9], X20
    LD1 { V6.H }[0x5], [X9], X20
    ADD  X9, X9, X19, LSR #0
    MOV  X7, X9
    ST1 { V9.S }[0x1], [X7], #4
    MOV  X7, X9
    LD1 { V8.S }[0x0], [X7], #4
    ADD  X9, X9, X19
    ST1 { V12.S }[0x1], [X9], X20
    LD1 { V21.S }[0x3], [X9], X20
    ADD  X9, X9, X19
    MOV  X7, X9
    ST1 { V8.D }[0x1], [X7], #8
    MOV  X7, X9
    LD1 { V8.D }[0x0], [X7], #8
    ADD  X9, X9, X19, ASR #0
    ST1 { V18.D }[0x1], [X9], X20
    LD1 { V12.D }[0x1], [X9], X20
    ADD  X9, X9, X19
    MOV  X7, X9
    ST1 { V8.B }[0x0], [X7], #1
    MOV  X7, X9
    LD1 { V23.B }[0x4], [X7], #1
    ADD  X9, X9, X19
    ST1 { V29.B }[0xc], [X9], X20
    LD1 { V14.B }[0xb], [X9], X20
    ADD  X9, X9, X19
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MRS  X17, FPSR
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D1
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D2
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D3
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D4
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D5
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D6
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D7
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #32
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D9
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D10
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D11
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D12
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D13
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D14
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D15
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D16
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D17
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D18
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D19
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D20
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D21
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D22
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D23
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a00, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D24
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D25
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D26
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D27
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D28
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D29
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D30
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    FMOV  X17, D31
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X11
    FMOV  D2, X26
    FMOV  V2.D[1], X20
    FMOV  D3, X29
    FMOV  V3.D[1], X29
    FMOV  D4, X26
    FMOV  V4.D[1], X27
    FMOV  D5, X19
    FMOV  V5.D[1], X29
    FMOV  D6, X14
    FMOV  V6.D[1], X16
    FMOV  D7, X13
    FMOV  V7.D[1], X17
    FMOV  D8, X6
    FMOV  V8.D[1], X16
    FMOV  D9, X12
    FMOV  V9.D[1], X28
    FMOV  D10, X13
    FMOV  V10.D[1], X23
    FMOV  D11, X15
    FMOV  V11.D[1], X10
    FMOV  D12, X16
    FMOV  V12.D[1], X9
    FMOV  D13, X8
    FMOV  V13.D[1], X26
    FMOV  D14, X7
    FMOV  V14.D[1], X10
    FMOV  D15, X6
    FMOV  V15.D[1], X26
    FMOV  D16, X26
    FMOV  V16.D[1], X10
    FMOV  D17, X18
    FMOV  V17.D[1], X13
    FMOV  D18, X28
    FMOV  V18.D[1], X22
    FMOV  D19, X28
    FMOV  V19.D[1], X20
    FMOV  D20, X10
    FMOV  V20.D[1], X28
    FMOV  D21, X21
    FMOV  V21.D[1], X13
    FMOV  D22, X24
    FMOV  V22.D[1], X26
    FMOV  D23, X28
    FMOV  V23.D[1], X22
    FMOV  D24, X23
    FMOV  V24.D[1], X11
    FMOV  D25, X5
    FMOV  V25.D[1], X6
    FMOV  D26, X11
    FMOV  V26.D[1], X20
    FMOV  D27, X24
    FMOV  V27.D[1], X17
    FMOV  D28, X7
    FMOV  V28.D[1], X13
    FMOV  D29, X8
    FMOV  V29.D[1], X5
    FMOV  D30, X12
    FMOV  V30.D[1], X7
    FMOV  D31, X28
    FMOV  V31.D[1], X14
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X14, #0x2d00, LSL #0
    ADD  X26, X30, X14
    MOV  X18, X26
    ST1 { V22.16B, V23.16B }, [X18], #32
    MOV  X18, X26
    LD1 { V26.16B, V27.16B }, [X18], #32
    ADD  X26, X26, X29, LSR #0
    MOV  X18, X26
    ST1 { V29.2D, V30.2D }, [X18], #32
    MOV  X18, X26
    LD1 { V17.2D, V18.2D }, [X18], #32
    ADD  X26, X26, X29, ASR #0
    MOV  X18, X26
    ST1 { V1.4S, V2.4S }, [X18], #32
    MOV  X18, X26
    LD1 { V20.4S, V21.4S }, [X18], #32
    ADD  X26, X26, X29, ASR #0
    MOV  X18, X26
    ST1 { V7.8H, V8.8H }, [X18], #32
    MOV  X18, X26
    LD1 { V26.8H, V27.8H }, [X18], #32
    ADD  X26, X26, X29
    MOV  X18, X26
    ST1 { V11.4H, V12.4H }, [X18], #16
    MOV  X18, X26
    LD1 { V17.8B, V18.8B }, [X18], #16
    ADD  X26, X26, X29, LSR #0
    MOV  X18, X26
    ST1 { V18.1D, V19.1D }, [X18], #16
    MOV  X18, X26
    LD1 { V26.1D, V27.1D }, [X18], #16
    ADD  X26, X26, X29, LSR #0
    MOV  X18, X26
    ST1 { V17.2S, V18.2S }, [X18], #16
    MOV  X18, X26
    LD1 { V4.2S, V5.2S }, [X18], #16
    ADD  X26, X26, X29
    MOV  X18, X26
    ST1 { V9.4H, V10.4H }, [X18], #16
    MOV  X18, X26
    LD1 { V17.4H, V18.4H }, [X18], #16
    ADD  X26, X26, X29, ASR #0
    MOV  X18, X26
    ST1 { V11.8B, V12.8B }, [X18], #16
    MOV  X18, X26
    LD1 { V2.8B, V3.8B }, [X18], #16
    ADD  X26, X26, X29, LSR #0
    ST1 { V2.16B, V3.16B }, [X26], X20
    LD1 { V26.4S, V27.4S }, [X26], X20
    ADD  X26, X26, X29
    ST1 { V23.16B, V24.16B }, [X26], X20
    LD1 { V25.16B, V26.16B }, [X26], X20
    ADD  X26, X26, X29
    ST1 { V13.2D, V14.2D }, [X26], X20
    LD1 { V23.2D, V24.2D }, [X26], X20
    ADD  X26, X26, X29
    ST1 { V26.4S, V27.4S }, [X26], X20
    LD1 { V24.4S, V25.4S }, [X26], X20
    ADD  X26, X26, X29
    ST1 { V24.8H, V25.8H }, [X26], X20
    LD1 { V26.8H, V27.8H }, [X26], X20
    ADD  X26, X26, X29
    ST1 { V16.2S, V17.2S }, [X26], X20
    LD1 { V26.2S, V27.2S }, [X26], X20
    ADD  X26, X26, X29
    ST1 { V26.1D, V27.1D }, [X26], X20
    LD1 { V9.1D, V10.1D }, [X26], X20
    ADD  X26, X26, X29
    ST1 { V29.2S, V30.2S }, [X26], X20
    LD1 { V18.2S, V19.2S }, [X26], X20
    ADD  X26, X26, X29, LSR #0
    ST1 { V18.4H, V19.4H }, [X26], X20
    LD1 { V22.4H, V23.4H }, [X26], X20
    ADD  X26, X26, X29, ASR #0
    ST1 { V22.8B, V23.8B }, [X26], X20
    LD1 { V26.8B, V27.8B }, [X26], X20
    ADD  X26, X26, X29, LSR #0
    ST1 { V26.H }[0x7], [X26]
    LD1 { V0.H }[0x1], [X26]
    ADD  X26, X26, X29, LSR #0
    ST1 { V22.S }[0x0], [X26]
    LD1 { V17.S }[0x1], [X26]
    ADD  X26, X26, X29, ASR #0
    ST1 { V17.D }[0x1], [X26]
    LD1 { V26.D }[0x0], [X26]
    ADD  X26, X26, X29, ASR #0
    ST1 { V25.B }[0xb], [X26]
    LD1 { V19.B }[0x5], [X26]
    ADD  X26, X26, X29, LSR #0
    MOV  X18, X26
    ST1 { V26.H }[0x1], [X18], #2
    MOV  X18, X26
    LD1 { V1.H }[0x5], [X18], #2
    ADD  X26, X26, X29, ASR #0
    ST1 { V1.H }[0x1], [X26], X20
    LD1 { V13.H }[0x2], [X26], X20
    ADD  X26, X26, X29, LSR #0
    MOV  X18, X26
    ST1 { V27.S }[0x3], [X18], #4
    MOV  X18, X26
    LD1 { V23.S }[0x1], [X18], #4
    ADD  X26, X26, X29, LSR #0
    ST1 { V14.S }[0x3], [X26], X20
    LD1 { V27.S }[0x2], [X26], X20
    ADD  X26, X26, X29
    MOV  X18, X26
    ST1 { V23.D }[0x0], [X18], #8
    MOV  X18, X26
    LD1 { V20.D }[0x0], [X18], #8
    ADD  X26, X26, X29
    ST1 { V20.D }[0x0], [X26], X20
    LD1 { V14.D }[0x1], [X26], X20
    ADD  X26, X26, X29, LSR #0
    MOV  X18, X26
    ST1 { V14.B }[0xd], [X18], #1
    MOV  X18, X26
    LD1 { V19.B }[0xb], [X18], #1
    ADD  X26, X26, X29, ASR #0
    ST1 { V27.B }[0xf], [X26], X20
    LD1 { V23.B }[0x9], [X26], X20
    ADD  X26, X26, X29, ASR #0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X27, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP04_TestFail
    MRS  X10, FPSR
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D1
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D2
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D3
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D4
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D5
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D6
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D7
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D8
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D9
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D10
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D11
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D12
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D13
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D14
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D15
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D16
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D17
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D18
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D19
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D20
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D21
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D22
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D23
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D24
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D25
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D27
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D28
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D29
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D30
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    FMOV  X10, D31
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail

AdvsimdLoadStoreP04_TestEnd:
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
AdvsimdLoadStoreP04_TestFail:
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
