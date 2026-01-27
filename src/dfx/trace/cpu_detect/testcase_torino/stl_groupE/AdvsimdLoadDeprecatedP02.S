.global AdvsimdLoadDeprecatedP02

.text
.p2align 4

AdvsimdLoadDeprecatedP02:

AdvsimdLoadDeprecatedP02_TestBegin:
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
    MOVZ  X2, #0x9908, LSL #0
    MOVK  X2, #0x51e7, LSL #16
    MOVK  X2, #0xedac, LSL #32
    MOVK  X2, #0x6a51, LSL #48
    MOVZ  X3, #0xb51d, LSL #0
    MOVK  X3, #0xa15a, LSL #16
    MOVK  X3, #0xaeeb, LSL #32
    MOVK  X3, #0x9ca1, LSL #48
    MOVZ  X4, #0x1a2e, LSL #0
    MOVK  X4, #0xa4d3, LSL #16
    MOVK  X4, #0x2273, LSL #32
    MOVK  X4, #0x2e8f, LSL #48
    MOVZ  X5, #0x44e0, LSL #0
    MOVK  X5, #0xb674, LSL #16
    MOVK  X5, #0xf066, LSL #32
    MOVK  X5, #0xb60e, LSL #48
    MOVZ  X6, #0x3250, LSL #0
    MOVK  X6, #0xaaa1, LSL #16
    MOVK  X6, #0x6175, LSL #32
    MOVK  X6, #0xbe3c, LSL #48
    MOVZ  X7, #0x25e6, LSL #0
    MOVK  X7, #0x51c8, LSL #16
    MOVK  X7, #0x32b5, LSL #32
    MOVK  X7, #0x9997, LSL #48
    MOVZ  X8, #0x839b, LSL #0
    MOVK  X8, #0x1d07, LSL #16
    MOVK  X8, #0xc991, LSL #32
    MOVK  X8, #0x5d5c, LSL #48
    MOVZ  X9, #0xc27, LSL #0
    MOVK  X9, #0x684b, LSL #16
    MOVK  X9, #0xc0da, LSL #32
    MOVK  X9, #0xb8d5, LSL #48
    MOVZ  X10, #0xfd31, LSL #0
    MOVK  X10, #0xc5fe, LSL #16
    MOVK  X10, #0x85fb, LSL #32
    MOVK  X10, #0x3428, LSL #48
    MOVZ  X11, #0x36cb, LSL #0
    MOVK  X11, #0x9162, LSL #16
    MOVK  X11, #0xa2d5, LSL #32
    MOVK  X11, #0x177a, LSL #48
    MOVZ  X12, #0xef6, LSL #0
    MOVK  X12, #0xcc9b, LSL #16
    MOVK  X12, #0x2631, LSL #32
    MOVK  X12, #0xc712, LSL #48
    MOVZ  X13, #0x46e9, LSL #0
    MOVK  X13, #0xf532, LSL #16
    MOVK  X13, #0x6a4a, LSL #32
    MOVK  X13, #0xbdc6, LSL #48
    MOVZ  X14, #0x36d0, LSL #0
    MOVK  X14, #0xe1b, LSL #16
    MOVK  X14, #0x9645, LSL #32
    MOVK  X14, #0x34e2, LSL #48
    MOVZ  X15, #0x4c0f, LSL #0
    MOVK  X15, #0x9fa, LSL #16
    MOVK  X15, #0x114d, LSL #32
    MOVK  X15, #0x2c60, LSL #48
    MOVZ  X16, #0x830f, LSL #0
    MOVK  X16, #0x9a1, LSL #16
    MOVK  X16, #0x3785, LSL #32
    MOVK  X16, #0x8c09, LSL #48
    MOVZ  X17, #0xbf63, LSL #0
    MOVK  X17, #0x3db, LSL #16
    MOVK  X17, #0xd0a2, LSL #32
    MOVK  X17, #0x77fd, LSL #48
    MOVZ  X18, #0x1682, LSL #0
    MOVK  X18, #0x5b23, LSL #16
    MOVK  X18, #0x90eb, LSL #32
    MOVK  X18, #0x722f, LSL #48
    MOVZ  X19, #0x28bb, LSL #0
    MOVK  X19, #0xb928, LSL #16
    MOVK  X19, #0x1ca2, LSL #32
    MOVK  X19, #0xe058, LSL #48
    MOVZ  X20, #0x3b68, LSL #0
    MOVK  X20, #0x9dfe, LSL #16
    MOVK  X20, #0x1d, LSL #32
    MOVK  X20, #0x5271, LSL #48
    MOVZ  X21, #0xc6c5, LSL #0
    MOVK  X21, #0x5d70, LSL #16
    MOVK  X21, #0x93f4, LSL #32
    MOVK  X21, #0x1d8e, LSL #48
    MOVZ  X22, #0xaae7, LSL #0
    MOVK  X22, #0xad61, LSL #16
    MOVK  X22, #0x70ba, LSL #32
    MOVK  X22, #0x63e6, LSL #48
    MOVZ  X23, #0x5d01, LSL #0
    MOVK  X23, #0xd87b, LSL #16
    MOVK  X23, #0x4f64, LSL #32
    MOVK  X23, #0xe54c, LSL #48
    MOVZ  X29, #0x595b, LSL #0
    MOVK  X29, #0x4ba2, LSL #16
    MOVK  X29, #0xd3f7, LSL #32
    MOVK  X29, #0x517c, LSL #48
    MOVZ  X18, #0x30e2, LSL #0
    MOVK  X18, #0xf0b5, LSL #16
    MOVK  X18, #0xe205, LSL #32
    MOVK  X18, #0x3bf1, LSL #48
    MSR  FPCR, X18
    MRS  X21, FPCR
    MOVZ  X19, #0x60ff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    AND  X21, X21, X19
    MOVZ  X19, #0x0, LSL #0
    ORR  X21, X21, X19
    MSR  FPCR, X21
    ISB  SY
    MOVZ  X18, #0x8615, LSL #0
    MOVK  X18, #0x96f8, LSL #16
    MOVK  X18, #0x1f43, LSL #32
    MOVK  X18, #0x5da4, LSL #48
    MSR  FPSR, X18
    MRS  X7, FPSR
    MOVZ  X12, #0xff60, LSL #0
    MOVK  X12, #0x7ff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    AND  X7, X7, X12
    MOVZ  X12, #0x0, LSL #0
    ORR  X7, X7, X12
    MSR  FPSR, X7
    ISB  SY
    ANDS  X8, X10, #0xe001ffffe001ffff
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X23
    FMOV  D1, X21
    FMOV  V1.D[1], X20
    FMOV  D2, X22
    FMOV  V2.D[1], X7
    FMOV  D3, X29
    FMOV  V3.D[1], X2
    FMOV  D4, X4
    FMOV  V4.D[1], X13
    FMOV  D5, X3
    FMOV  V5.D[1], X10
    FMOV  D6, X6
    FMOV  V6.D[1], X18
    FMOV  D7, X23
    FMOV  V7.D[1], X18
    FMOV  D8, X29
    FMOV  V8.D[1], X18
    FMOV  D9, X16
    FMOV  V9.D[1], X4
    FMOV  D10, X17
    FMOV  V10.D[1], X12
    FMOV  D11, X7
    FMOV  V11.D[1], X9
    FMOV  D12, X2
    FMOV  V12.D[1], X29
    FMOV  D13, X8
    FMOV  V13.D[1], X15
    FMOV  D14, X16
    FMOV  V14.D[1], X6
    FMOV  D15, X12
    FMOV  V15.D[1], X17
    FMOV  D16, X15
    FMOV  V16.D[1], X8
    FMOV  D17, X17
    FMOV  V17.D[1], X21
    FMOV  D18, X2
    FMOV  V18.D[1], X29
    FMOV  D19, X16
    FMOV  V19.D[1], X21
    FMOV  D20, X23
    FMOV  V20.D[1], X18
    FMOV  D21, X13
    FMOV  V21.D[1], X29
    FMOV  D22, X8
    FMOV  V22.D[1], X17
    FMOV  D23, X17
    FMOV  V23.D[1], X22
    FMOV  D24, X13
    FMOV  V24.D[1], X22
    FMOV  D25, X23
    FMOV  V25.D[1], X4
    FMOV  D26, X12
    FMOV  V26.D[1], X16
    FMOV  D27, X17
    FMOV  V27.D[1], X15
    FMOV  D28, X12
    FMOV  V28.D[1], X7
    FMOV  D29, X16
    FMOV  V29.D[1], X15
    FMOV  D30, X12
    FMOV  V30.D[1], X7
    FMOV  D31, X21
    FMOV  V31.D[1], X4
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X19, #0x0, LSL #0
    ADD  X13, X30, X19, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13]
    LD2R { V20.4S, V21.4S }, [X13]
    ADD  X13, X13, X11
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X13]
    LD2R { V31.16B, V0.16B }, [X13]
    ADD  X13, X13, X11, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X13]
    LD2R { V6.2D, V7.2D }, [X13]
    ADD  X13, X13, X11
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X13]
    LD2R { V27.4S, V28.4S }, [X13]
    ADD  X13, X13, X11
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X13]
    LD2R { V25.8H, V26.8H }, [X13]
    ADD  X13, X13, X11, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X13]
    LD2R { V29.8B, V30.8B }, [X13]
    ADD  X13, X13, X11, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X13]
    LD2R { V26.1D, V27.1D }, [X13]
    ADD  X13, X13, X11, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X13]
    LD2R { V17.2S, V18.2S }, [X13]
    ADD  X13, X13, X11, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X13]
    LD2R { V21.4H, V22.4H }, [X13]
    ADD  X13, X13, X11, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X13]
    LD2R { V11.8B, V12.8B }, [X13]
    ADD  X13, X13, X11, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X13]
    MOV  X21, X13
    LD2R { V29.2D, V30.2D }, [X21], #16
    ADD  X13, X13, X11, ASR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X13]
    MOV  X21, X13
    LD2R { V25.1D, V26.1D }, [X21], #16
    ADD  X13, X13, X11, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X13]
    MOV  X21, X13
    LD2R { V26.2D, V27.2D }, [X21], #16
    ADD  X13, X13, X11
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X13]
    MOV  X21, X13
    LD2R { V18.16B, V19.16B }, [X21], #2
    ADD  X13, X13, X11
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X13]
    MOV  X21, X13
    LD2R { V17.16B, V18.16B }, [X21], #2
    ADD  X13, X13, X11
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X13]
    MOV  X21, X13
    LD2R { V22.8B, V23.8B }, [X21], #2
    ADD  X13, X13, X11
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X13]
    MOV  X21, X13
    LD2R { V12.4H, V13.4H }, [X21], #4
    ADD  X13, X13, X11
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X13]
    MOV  X21, X13
    LD2R { V28.8H, V29.8H }, [X21], #4
    ADD  X13, X13, X11, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X13]
    MOV  X21, X13
    LD2R { V2.4S, V3.4S }, [X21], #8
    ADD  X13, X13, X11
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X13]
    MOV  X21, X13
    LD2R { V18.2S, V19.2S }, [X21], #8
    ADD  X13, X13, X11, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X13]
    MOV  X21, X13
    LD2R { V28.4S, V29.4S }, [X21], #8
    ADD  X13, X13, X11
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X13]
    MOV  X21, X13
    LD2R { V22.4H, V23.4H }, [X21], #4
    ADD  X13, X13, X11, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X13]
    LD2R { V12.8H, V13.8H }, [X13], X10
    ADD  X13, X13, X11
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X13]
    LD2R { V18.16B, V19.16B }, [X13], X10
    ADD  X13, X13, X11, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X13]
    LD2R { V27.2D, V28.2D }, [X13], X10
    ADD  X13, X13, X11, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X13]
    LD2R { V30.4S, V31.4S }, [X13], X10
    ADD  X13, X13, X11, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X13]
    LD2R { V30.8H, V31.8H }, [X13], X10
    ADD  X13, X13, X11, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X13]
    LD2R { V12.2S, V13.2S }, [X13], X10
    ADD  X13, X13, X11, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X13]
    LD2R { V10.1D, V11.1D }, [X13], X10
    ADD  X13, X13, X11, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X13]
    LD2R { V12.2S, V13.2S }, [X13], X10
    ADD  X13, X13, X11
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13]
    LD2R { V5.4H, V6.4H }, [X13], X10
    ADD  X13, X13, X11, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X13]
    LD2R { V20.8B, V21.8B }, [X13], X10
    ADD  X13, X13, X11, LSR #0
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X5, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X12, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D1
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D2
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D5
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D6
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D7
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D8
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D9
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D10
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D11
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D12
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D14
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D15
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D16
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D17
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D18
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D19
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D20
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D22
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D23
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D24
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D25
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D26
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D27
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D29
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D30
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X12, D31
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X21
    FMOV  D1, X19
    FMOV  V1.D[1], X20
    FMOV  D2, X22
    FMOV  V2.D[1], X10
    FMOV  D3, X13
    FMOV  V3.D[1], X23
    FMOV  D4, X17
    FMOV  V4.D[1], X21
    FMOV  D5, X4
    FMOV  V5.D[1], X23
    FMOV  D6, X6
    FMOV  V6.D[1], X3
    FMOV  D7, X18
    FMOV  V7.D[1], X22
    FMOV  D8, X21
    FMOV  V8.D[1], X4
    FMOV  D9, X14
    FMOV  V9.D[1], X3
    FMOV  D10, X29
    FMOV  V10.D[1], X12
    FMOV  D11, X19
    FMOV  V11.D[1], X2
    FMOV  D12, X16
    FMOV  V12.D[1], X6
    FMOV  D13, X19
    FMOV  V13.D[1], X2
    FMOV  D14, X20
    FMOV  V14.D[1], X11
    FMOV  D15, X6
    FMOV  V15.D[1], X7
    FMOV  D16, X2
    FMOV  V16.D[1], X29
    FMOV  D17, X17
    FMOV  V17.D[1], X15
    FMOV  D18, X17
    FMOV  V18.D[1], X8
    FMOV  D19, X6
    FMOV  V19.D[1], X23
    FMOV  D20, X9
    FMOV  V20.D[1], X16
    FMOV  D21, X22
    FMOV  V21.D[1], X6
    FMOV  D22, X5
    FMOV  V22.D[1], X5
    FMOV  D23, X13
    FMOV  V23.D[1], X2
    FMOV  D24, X17
    FMOV  V24.D[1], X6
    FMOV  D25, X20
    FMOV  V25.D[1], X11
    FMOV  D26, X15
    FMOV  V26.D[1], X9
    FMOV  D27, X22
    FMOV  V27.D[1], X15
    FMOV  D28, X13
    FMOV  V28.D[1], X11
    FMOV  D29, X7
    FMOV  V29.D[1], X18
    FMOV  D30, X20
    FMOV  V30.D[1], X4
    FMOV  D31, X29
    FMOV  V31.D[1], X16
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X22, #0x500, LSL #0
    ADD  X10, X30, X22, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X10]
    LD2R { V9.2D, V10.2D }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X10]
    LD2R { V2.16B, V3.16B }, [X10]
    ADD  X10, X10, X13, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X10]
    LD2R { V1.2D, V2.2D }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X10]
    LD2R { V10.4S, V11.4S }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X10]
    LD2R { V10.8H, V11.8H }, [X10]
    ADD  X10, X10, X13
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X10]
    LD2R { V29.8B, V30.8B }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X10]
    LD2R { V18.1D, V19.1D }, [X10]
    ADD  X10, X10, X13
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X10]
    LD2R { V30.2S, V31.2S }, [X10]
    ADD  X10, X10, X13, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X10]
    LD2R { V0.4H, V1.4H }, [X10]
    ADD  X10, X10, X13, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X10]
    LD2R { V19.8B, V20.8B }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X10]
    MOV  X17, X10
    LD2R { V6.2D, V7.2D }, [X17], #16
    ADD  X10, X10, X13, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X10]
    MOV  X17, X10
    LD2R { V13.1D, V14.1D }, [X17], #16
    ADD  X10, X10, X13
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X10]
    MOV  X17, X10
    LD2R { V21.2D, V22.2D }, [X17], #16
    ADD  X10, X10, X13, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X10]
    MOV  X17, X10
    LD2R { V30.8B, V31.8B }, [X17], #2
    ADD  X10, X10, X13, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X10]
    MOV  X17, X10
    LD2R { V19.16B, V20.16B }, [X17], #2
    ADD  X10, X10, X13, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X10]
    MOV  X17, X10
    LD2R { V6.8B, V7.8B }, [X17], #2
    ADD  X10, X10, X13, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X10]
    MOV  X17, X10
    LD2R { V13.4H, V14.4H }, [X17], #4
    ADD  X10, X10, X13
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X10]
    MOV  X17, X10
    LD2R { V25.8H, V26.8H }, [X17], #4
    ADD  X10, X10, X13, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X10]
    MOV  X17, X10
    LD2R { V4.4S, V5.4S }, [X17], #8
    ADD  X10, X10, X13, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X10]
    MOV  X17, X10
    LD2R { V21.2S, V22.2S }, [X17], #8
    ADD  X10, X10, X13
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X10]
    MOV  X17, X10
    LD2R { V5.4S, V6.4S }, [X17], #8
    ADD  X10, X10, X13
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X10]
    MOV  X17, X10
    LD2R { V27.4H, V28.4H }, [X17], #4
    ADD  X10, X10, X13, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X10]
    LD2R { V20.2D, V21.2D }, [X10], X14
    ADD  X10, X10, X13, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X10]
    LD2R { V1.16B, V2.16B }, [X10], X14
    ADD  X10, X10, X13, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X10]
    LD2R { V0.2D, V1.2D }, [X10], X14
    ADD  X10, X10, X13, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X10]
    LD2R { V22.4S, V23.4S }, [X10], X14
    ADD  X10, X10, X13
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X10]
    LD2R { V14.8H, V15.8H }, [X10], X14
    ADD  X10, X10, X13, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X10]
    LD2R { V19.2S, V20.2S }, [X10], X14
    ADD  X10, X10, X13
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X10]
    LD2R { V6.1D, V7.1D }, [X10], X14
    ADD  X10, X10, X13
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X10]
    LD2R { V30.2S, V31.2S }, [X10], X14
    ADD  X10, X10, X13
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X10]
    LD2R { V20.4H, V21.4H }, [X10], X14
    ADD  X10, X10, X13
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X10]
    LD2R { V24.8B, V25.8B }, [X10], X14
    ADD  X10, X10, X13, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X16, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D6
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X10
    FMOV  V1.D[1], X22
    FMOV  D2, X21
    FMOV  V2.D[1], X2
    FMOV  D3, X29
    FMOV  V3.D[1], X22
    FMOV  D4, X29
    FMOV  V4.D[1], X20
    FMOV  D5, X6
    FMOV  V5.D[1], X20
    FMOV  D6, X19
    FMOV  V6.D[1], X4
    FMOV  D7, X15
    FMOV  V7.D[1], X13
    FMOV  D8, X5
    FMOV  V8.D[1], X11
    FMOV  D9, X9
    FMOV  V9.D[1], X9
    FMOV  D10, X15
    FMOV  V10.D[1], X22
    FMOV  D11, X20
    FMOV  V11.D[1], X9
    FMOV  D12, X20
    FMOV  V12.D[1], X9
    FMOV  D13, X5
    FMOV  V13.D[1], X15
    FMOV  D14, X2
    FMOV  V14.D[1], X16
    FMOV  D15, X6
    FMOV  V15.D[1], X12
    FMOV  D16, X29
    FMOV  V16.D[1], X5
    FMOV  D17, X7
    FMOV  V17.D[1], X6
    FMOV  D18, X6
    FMOV  V18.D[1], X19
    FMOV  D19, X11
    FMOV  V19.D[1], X7
    FMOV  D20, X10
    FMOV  V20.D[1], X3
    FMOV  D21, X3
    FMOV  V21.D[1], X23
    FMOV  D22, X9
    FMOV  V22.D[1], X2
    FMOV  D23, X13
    FMOV  V23.D[1], X19
    FMOV  D24, X23
    FMOV  V24.D[1], X12
    FMOV  D25, X11
    FMOV  V25.D[1], X22
    FMOV  D26, X9
    FMOV  V26.D[1], X19
    FMOV  D27, X22
    FMOV  V27.D[1], X18
    FMOV  D28, X16
    FMOV  V28.D[1], X21
    FMOV  D29, X19
    FMOV  V29.D[1], X13
    FMOV  D30, X3
    FMOV  V30.D[1], X4
    FMOV  D31, X12
    FMOV  V31.D[1], X17
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X3, #0xa00, LSL #0
    ADD  X12, X30, X3, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X12]
    LD2R { V24.16B, V25.16B }, [X12]
    ADD  X12, X12, X18, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X12]
    LD2R { V29.16B, V30.16B }, [X12]
    ADD  X12, X12, X18, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X12]
    LD2R { V15.2D, V16.2D }, [X12]
    ADD  X12, X12, X18
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X12]
    LD2R { V19.4S, V20.4S }, [X12]
    ADD  X12, X12, X18, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X12]
    LD2R { V16.8H, V17.8H }, [X12]
    ADD  X12, X12, X18, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X12]
    LD2R { V24.8B, V25.8B }, [X12]
    ADD  X12, X12, X18, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X12]
    LD2R { V9.1D, V10.1D }, [X12]
    ADD  X12, X12, X18, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X12]
    LD2R { V16.2S, V17.2S }, [X12]
    ADD  X12, X12, X18
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X12]
    LD2R { V23.4H, V24.4H }, [X12]
    ADD  X12, X12, X18, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X12]
    LD2R { V27.8B, V28.8B }, [X12]
    ADD  X12, X12, X18, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X12]
    MOV  X6, X12
    LD2R { V18.2D, V19.2D }, [X6], #16
    ADD  X12, X12, X18
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X12]
    MOV  X6, X12
    LD2R { V21.1D, V22.1D }, [X6], #16
    ADD  X12, X12, X18, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X12]
    MOV  X6, X12
    LD2R { V10.2D, V11.2D }, [X6], #16
    ADD  X12, X12, X18
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X12]
    MOV  X6, X12
    LD2R { V13.8B, V14.8B }, [X6], #2
    ADD  X12, X12, X18
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X12]
    MOV  X6, X12
    LD2R { V23.16B, V24.16B }, [X6], #2
    ADD  X12, X12, X18, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X12]
    MOV  X6, X12
    LD2R { V22.8B, V23.8B }, [X6], #2
    ADD  X12, X12, X18, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X12]
    MOV  X6, X12
    LD2R { V25.4H, V26.4H }, [X6], #4
    ADD  X12, X12, X18, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X12]
    MOV  X6, X12
    LD2R { V30.8H, V31.8H }, [X6], #4
    ADD  X12, X12, X18, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X12]
    MOV  X6, X12
    LD2R { V16.4S, V17.4S }, [X6], #8
    ADD  X12, X12, X18, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X12]
    MOV  X6, X12
    LD2R { V11.2S, V12.2S }, [X6], #8
    ADD  X12, X12, X18
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X12]
    MOV  X6, X12
    LD2R { V3.4S, V4.4S }, [X6], #8
    ADD  X12, X12, X18, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X12]
    MOV  X6, X12
    LD2R { V14.4H, V15.4H }, [X6], #4
    ADD  X12, X12, X18
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X12]
    LD2R { V27.4S, V28.4S }, [X12], X8
    ADD  X12, X12, X18, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X12]
    LD2R { V20.16B, V21.16B }, [X12], X8
    ADD  X12, X12, X18
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X12]
    LD2R { V19.2D, V20.2D }, [X12], X8
    ADD  X12, X12, X18, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X12]
    LD2R { V15.4S, V16.4S }, [X12], X8
    ADD  X12, X12, X18
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X12]
    LD2R { V2.8H, V3.8H }, [X12], X8
    ADD  X12, X12, X18, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X12]
    LD2R { V27.8B, V28.8B }, [X12], X8
    ADD  X12, X12, X18, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X12]
    LD2R { V2.1D, V3.1D }, [X12], X8
    ADD  X12, X12, X18, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X12]
    LD2R { V31.2S, V0.2S }, [X12], X8
    ADD  X12, X12, X18, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X12]
    LD2R { V15.4H, V16.4H }, [X12], X8
    ADD  X12, X12, X18, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X12]
    LD2R { V29.8B, V30.8B }, [X12], X8
    ADD  X12, X12, X18, ASR #0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X20, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X21, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D1
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D2
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D3
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D4
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D5
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D6
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D7
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D8
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D9
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D10
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D11
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D12
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D13
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D14
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D15
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D16
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D17
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D18
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D19
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D20
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D21
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D22
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D23
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D24
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D25
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D26
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D27
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D28
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D29
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D30
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D31
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X20
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X8
    FMOV  V2.D[1], X23
    FMOV  D3, X11
    FMOV  V3.D[1], X21
    FMOV  D4, X5
    FMOV  V4.D[1], X14
    FMOV  D5, X17
    FMOV  V5.D[1], X8
    FMOV  D6, X11
    FMOV  V6.D[1], X9
    FMOV  D7, X16
    FMOV  V7.D[1], X4
    FMOV  D8, X2
    FMOV  V8.D[1], X3
    FMOV  D9, X7
    FMOV  V9.D[1], X13
    FMOV  D10, X13
    FMOV  V10.D[1], X8
    FMOV  D11, X19
    FMOV  V11.D[1], X29
    FMOV  D12, X8
    FMOV  V12.D[1], X19
    FMOV  D13, X11
    FMOV  V13.D[1], X19
    FMOV  D14, X16
    FMOV  V14.D[1], X20
    FMOV  D15, X17
    FMOV  V15.D[1], X16
    FMOV  D16, X3
    FMOV  V16.D[1], X22
    FMOV  D17, X9
    FMOV  V17.D[1], X15
    FMOV  D18, X13
    FMOV  V18.D[1], X16
    FMOV  D19, X17
    FMOV  V19.D[1], X22
    FMOV  D20, X12
    FMOV  V20.D[1], X17
    FMOV  D21, X16
    FMOV  V21.D[1], X9
    FMOV  D22, X3
    FMOV  V22.D[1], X12
    FMOV  D23, X17
    FMOV  V23.D[1], X5
    FMOV  D24, X7
    FMOV  V24.D[1], X9
    FMOV  D25, X13
    FMOV  V25.D[1], X11
    FMOV  D26, X17
    FMOV  V26.D[1], X3
    FMOV  D27, X8
    FMOV  V27.D[1], X19
    FMOV  D28, X8
    FMOV  V28.D[1], X9
    FMOV  D29, X22
    FMOV  V29.D[1], X3
    FMOV  D30, X18
    FMOV  V30.D[1], X19
    FMOV  D31, X6
    FMOV  V31.D[1], X21
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X9, #0xf00, LSL #0
    ADD  X2, X30, X9, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X2]
    LD2R { V5.4S, V6.4S }, [X2]
    ADD  X2, X2, X29, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X2]
    LD2R { V5.16B, V6.16B }, [X2]
    ADD  X2, X2, X29, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X2]
    LD2R { V23.2D, V24.2D }, [X2]
    ADD  X2, X2, X29, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X2]
    LD2R { V31.4S, V0.4S }, [X2]
    ADD  X2, X2, X29
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X2]
    LD2R { V4.8H, V5.8H }, [X2]
    ADD  X2, X2, X29
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X2]
    LD2R { V19.1D, V20.1D }, [X2]
    ADD  X2, X2, X29, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2]
    LD2R { V26.1D, V27.1D }, [X2]
    ADD  X2, X2, X29
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X2]
    LD2R { V11.2S, V12.2S }, [X2]
    ADD  X2, X2, X29, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X2]
    LD2R { V29.4H, V30.4H }, [X2]
    ADD  X2, X2, X29, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X2]
    LD2R { V21.8B, V22.8B }, [X2]
    ADD  X2, X2, X29, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X2]
    MOV  X4, X2
    LD2R { V29.2D, V30.2D }, [X4], #16
    ADD  X2, X2, X29, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X2]
    MOV  X4, X2
    LD2R { V27.1D, V28.1D }, [X4], #16
    ADD  X2, X2, X29, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X2]
    MOV  X4, X2
    LD2R { V9.2D, V10.2D }, [X4], #16
    ADD  X2, X2, X29, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X2]
    MOV  X4, X2
    LD2R { V11.8B, V12.8B }, [X4], #2
    ADD  X2, X2, X29
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X2]
    MOV  X4, X2
    LD2R { V20.16B, V21.16B }, [X4], #2
    ADD  X2, X2, X29, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X2]
    MOV  X4, X2
    LD2R { V23.8B, V24.8B }, [X4], #2
    ADD  X2, X2, X29
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X2]
    MOV  X4, X2
    LD2R { V17.4H, V18.4H }, [X4], #4
    ADD  X2, X2, X29, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X2]
    MOV  X4, X2
    LD2R { V13.8H, V14.8H }, [X4], #4
    ADD  X2, X2, X29, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X2]
    MOV  X4, X2
    LD2R { V10.4S, V11.4S }, [X4], #8
    ADD  X2, X2, X29, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X2]
    MOV  X4, X2
    LD2R { V12.2S, V13.2S }, [X4], #8
    ADD  X2, X2, X29, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X2]
    MOV  X4, X2
    LD2R { V1.4S, V2.4S }, [X4], #8
    ADD  X2, X2, X29
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X2]
    MOV  X4, X2
    LD2R { V25.8H, V26.8H }, [X4], #4
    ADD  X2, X2, X29, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X2]
    LD2R { V4.16B, V5.16B }, [X2], X13
    ADD  X2, X2, X29
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X2]
    LD2R { V5.16B, V6.16B }, [X2], X13
    ADD  X2, X2, X29, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X2]
    LD2R { V31.2D, V0.2D }, [X2], X13
    ADD  X2, X2, X29, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X2]
    LD2R { V29.4S, V30.4S }, [X2], X13
    ADD  X2, X2, X29, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X2]
    LD2R { V4.8H, V5.8H }, [X2], X13
    ADD  X2, X2, X29, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X2]
    LD2R { V29.2S, V30.2S }, [X2], X13
    ADD  X2, X2, X29, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X2]
    LD2R { V31.1D, V0.1D }, [X2], X13
    ADD  X2, X2, X29, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X2]
    LD2R { V25.2S, V26.2S }, [X2], X13
    ADD  X2, X2, X29
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X2]
    LD2R { V7.4H, V8.4H }, [X2], X13
    ADD  X2, X2, X29, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X2]
    LD2R { V17.8B, V18.8B }, [X2], X13
    ADD  X2, X2, X29, ASR #0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X10, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X15, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D1
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D2
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D3
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D4
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D5
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D6
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D7
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D8
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D9
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D10
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D11
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D12
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D13
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D14
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D15
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D16
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D17
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D18
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D19
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D20
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D21
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D22
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D23
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D24
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D25
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D26
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D27
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D28
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D29
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D30
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X15, D31
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X20
    FMOV  D1, X22
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X19
    FMOV  D3, X18
    FMOV  V3.D[1], X2
    FMOV  D4, X13
    FMOV  V4.D[1], X17
    FMOV  D5, X22
    FMOV  V5.D[1], X6
    FMOV  D6, X23
    FMOV  V6.D[1], X29
    FMOV  D7, X6
    FMOV  V7.D[1], X10
    FMOV  D8, X14
    FMOV  V8.D[1], X10
    FMOV  D9, X8
    FMOV  V9.D[1], X7
    FMOV  D10, X4
    FMOV  V10.D[1], X3
    FMOV  D11, X8
    FMOV  V11.D[1], X21
    FMOV  D12, X3
    FMOV  V12.D[1], X19
    FMOV  D13, X16
    FMOV  V13.D[1], X19
    FMOV  D14, X4
    FMOV  V14.D[1], X3
    FMOV  D15, X3
    FMOV  V15.D[1], X8
    FMOV  D16, X6
    FMOV  V16.D[1], X29
    FMOV  D17, X23
    FMOV  V17.D[1], X23
    FMOV  D18, X16
    FMOV  V18.D[1], X5
    FMOV  D19, X16
    FMOV  V19.D[1], X20
    FMOV  D20, X17
    FMOV  V20.D[1], X8
    FMOV  D21, X16
    FMOV  V21.D[1], X18
    FMOV  D22, X14
    FMOV  V22.D[1], X6
    FMOV  D23, X9
    FMOV  V23.D[1], X19
    FMOV  D24, X11
    FMOV  V24.D[1], X23
    FMOV  D25, X4
    FMOV  V25.D[1], X22
    FMOV  D26, X14
    FMOV  V26.D[1], X5
    FMOV  D27, X11
    FMOV  V27.D[1], X20
    FMOV  D28, X18
    FMOV  V28.D[1], X15
    FMOV  D29, X3
    FMOV  V29.D[1], X19
    FMOV  D30, X7
    FMOV  V30.D[1], X20
    FMOV  D31, X19
    FMOV  V31.D[1], X8
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X3, #0x1400, LSL #0
    ADD  X15, X30, X3, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X15]
    LD2R { V11.8H, V12.8H }, [X15]
    ADD  X15, X15, X21, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X15]
    LD2R { V10.16B, V11.16B }, [X15]
    ADD  X15, X15, X21
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X15]
    LD2R { V3.2D, V4.2D }, [X15]
    ADD  X15, X15, X21, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X15]
    LD2R { V26.4S, V27.4S }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X15]
    LD2R { V8.8H, V9.8H }, [X15]
    ADD  X15, X15, X21, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X15]
    LD2R { V29.8B, V30.8B }, [X15]
    ADD  X15, X15, X21, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X15]
    LD2R { V17.1D, V18.1D }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X15]
    LD2R { V25.2S, V26.2S }, [X15]
    ADD  X15, X15, X21, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X15]
    LD2R { V11.4H, V12.4H }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X15]
    LD2R { V17.8B, V18.8B }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X15]
    MOV  X23, X15
    LD2R { V22.1D, V23.1D }, [X23], #16
    ADD  X15, X15, X21
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X15]
    MOV  X23, X15
    LD2R { V24.1D, V25.1D }, [X23], #16
    ADD  X15, X15, X21, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X15]
    MOV  X23, X15
    LD2R { V21.2D, V22.2D }, [X23], #16
    ADD  X15, X15, X21
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X15]
    MOV  X23, X15
    LD2R { V29.16B, V30.16B }, [X23], #2
    ADD  X15, X15, X21
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X15]
    MOV  X23, X15
    LD2R { V16.16B, V17.16B }, [X23], #2
    ADD  X15, X15, X21, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X15]
    MOV  X23, X15
    LD2R { V25.8B, V26.8B }, [X23], #2
    ADD  X15, X15, X21, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X15]
    MOV  X23, X15
    LD2R { V13.4H, V14.4H }, [X23], #4
    ADD  X15, X15, X21, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X15]
    MOV  X23, X15
    LD2R { V6.8H, V7.8H }, [X23], #4
    ADD  X15, X15, X21, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X15]
    MOV  X23, X15
    LD2R { V1.2S, V2.2S }, [X23], #8
    ADD  X15, X15, X21
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X15]
    MOV  X23, X15
    LD2R { V30.2S, V31.2S }, [X23], #8
    ADD  X15, X15, X21, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X15]
    MOV  X23, X15
    LD2R { V27.4S, V28.4S }, [X23], #8
    ADD  X15, X15, X21
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X15]
    MOV  X23, X15
    LD2R { V10.8H, V11.8H }, [X23], #4
    ADD  X15, X15, X21
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X15]
    LD2R { V30.8H, V31.8H }, [X15], X18
    ADD  X15, X15, X21
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X15]
    LD2R { V14.16B, V15.16B }, [X15], X18
    ADD  X15, X15, X21, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X15]
    LD2R { V23.2D, V24.2D }, [X15], X18
    ADD  X15, X15, X21, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X15]
    LD2R { V7.4S, V8.4S }, [X15], X18
    ADD  X15, X15, X21, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X15]
    LD2R { V22.8H, V23.8H }, [X15], X18
    ADD  X15, X15, X21, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X15]
    LD2R { V17.8B, V18.8B }, [X15], X18
    ADD  X15, X15, X21
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X15]
    LD2R { V19.1D, V20.1D }, [X15], X18
    ADD  X15, X15, X21, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X15]
    LD2R { V0.2S, V1.2S }, [X15], X18
    ADD  X15, X15, X21, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X15]
    LD2R { V24.4H, V25.4H }, [X15], X18
    ADD  X15, X15, X21
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X15]
    LD2R { V31.8B, V0.8B }, [X15], X18
    ADD  X15, X15, X21
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X16, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D1
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D2
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D5
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D6
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D7
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D8
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D9
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D10
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D11
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D12
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D14
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D15
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D16
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D17
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D18
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D19
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D20
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D22
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D23
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D24
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D25
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D26
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D27
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D29
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D30
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X16, D31
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X17
    FMOV  D2, X21
    FMOV  V2.D[1], X17
    FMOV  D3, X21
    FMOV  V3.D[1], X16
    FMOV  D4, X9
    FMOV  V4.D[1], X29
    FMOV  D5, X21
    FMOV  V5.D[1], X9
    FMOV  D6, X17
    FMOV  V6.D[1], X17
    FMOV  D7, X23
    FMOV  V7.D[1], X13
    FMOV  D8, X9
    FMOV  V8.D[1], X23
    FMOV  D9, X29
    FMOV  V9.D[1], X20
    FMOV  D10, X3
    FMOV  V10.D[1], X2
    FMOV  D11, X9
    FMOV  V11.D[1], X21
    FMOV  D12, X11
    FMOV  V12.D[1], X21
    FMOV  D13, X19
    FMOV  V13.D[1], X2
    FMOV  D14, X4
    FMOV  V14.D[1], X15
    FMOV  D15, X3
    FMOV  V15.D[1], X8
    FMOV  D16, X11
    FMOV  V16.D[1], X23
    FMOV  D17, X17
    FMOV  V17.D[1], X5
    FMOV  D18, X10
    FMOV  V18.D[1], X21
    FMOV  D19, X21
    FMOV  V19.D[1], X18
    FMOV  D20, X2
    FMOV  V20.D[1], X16
    FMOV  D21, X6
    FMOV  V21.D[1], X3
    FMOV  D22, X22
    FMOV  V22.D[1], X22
    FMOV  D23, X15
    FMOV  V23.D[1], X9
    FMOV  D24, X8
    FMOV  V24.D[1], X16
    FMOV  D25, X5
    FMOV  V25.D[1], X3
    FMOV  D26, X14
    FMOV  V26.D[1], X10
    FMOV  D27, X19
    FMOV  V27.D[1], X2
    FMOV  D28, X9
    FMOV  V28.D[1], X8
    FMOV  D29, X2
    FMOV  V29.D[1], X14
    FMOV  D30, X16
    FMOV  V30.D[1], X8
    FMOV  D31, X23
    FMOV  V31.D[1], X13
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X18, #0x1900, LSL #0
    ADD  X12, X30, X18, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X12]
    LD2R { V17.4S, V18.4S }, [X12]
    ADD  X12, X12, X7, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X12]
    LD2R { V4.16B, V5.16B }, [X12]
    ADD  X12, X12, X7, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X12]
    LD2R { V22.2D, V23.2D }, [X12]
    ADD  X12, X12, X7, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X12]
    LD2R { V21.4S, V22.4S }, [X12]
    ADD  X12, X12, X7, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X12]
    LD2R { V29.8H, V30.8H }, [X12]
    ADD  X12, X12, X7, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X12]
    LD2R { V22.2S, V23.2S }, [X12]
    ADD  X12, X12, X7, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X12]
    LD2R { V27.1D, V28.1D }, [X12]
    ADD  X12, X12, X7
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X12]
    LD2R { V17.2S, V18.2S }, [X12]
    ADD  X12, X12, X7, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X12]
    LD2R { V9.4H, V10.4H }, [X12]
    ADD  X12, X12, X7, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X12]
    LD2R { V29.8B, V30.8B }, [X12]
    ADD  X12, X12, X7
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X12]
    MOV  X21, X12
    LD2R { V11.2D, V12.2D }, [X21], #16
    ADD  X12, X12, X7, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X12]
    MOV  X21, X12
    LD2R { V22.1D, V23.1D }, [X21], #16
    ADD  X12, X12, X7
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X12]
    MOV  X21, X12
    LD2R { V2.2D, V3.2D }, [X21], #16
    ADD  X12, X12, X7
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X12]
    MOV  X21, X12
    LD2R { V14.16B, V15.16B }, [X21], #2
    ADD  X12, X12, X7, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X12]
    MOV  X21, X12
    LD2R { V16.16B, V17.16B }, [X21], #2
    ADD  X12, X12, X7, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X12]
    MOV  X21, X12
    LD2R { V17.8B, V18.8B }, [X21], #2
    ADD  X12, X12, X7, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X12]
    MOV  X21, X12
    LD2R { V0.4H, V1.4H }, [X21], #4
    ADD  X12, X12, X7
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X12]
    MOV  X21, X12
    LD2R { V23.8H, V24.8H }, [X21], #4
    ADD  X12, X12, X7
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X12]
    MOV  X21, X12
    LD2R { V6.2S, V7.2S }, [X21], #8
    ADD  X12, X12, X7, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X12]
    MOV  X21, X12
    LD2R { V28.2S, V29.2S }, [X21], #8
    ADD  X12, X12, X7, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X12]
    MOV  X21, X12
    LD2R { V4.4S, V5.4S }, [X21], #8
    ADD  X12, X12, X7, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X12]
    MOV  X21, X12
    LD2R { V31.8H, V0.8H }, [X21], #4
    ADD  X12, X12, X7, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X12]
    LD2R { V20.16B, V21.16B }, [X12], X19
    ADD  X12, X12, X7, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X12]
    LD2R { V15.16B, V16.16B }, [X12], X19
    ADD  X12, X12, X7
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X12]
    LD2R { V24.2D, V25.2D }, [X12], X19
    ADD  X12, X12, X7
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X12]
    LD2R { V12.4S, V13.4S }, [X12], X19
    ADD  X12, X12, X7, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X12]
    LD2R { V17.8H, V18.8H }, [X12], X19
    ADD  X12, X12, X7
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X12]
    LD2R { V1.1D, V2.1D }, [X12], X19
    ADD  X12, X12, X7, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X12]
    LD2R { V0.1D, V1.1D }, [X12], X19
    ADD  X12, X12, X7
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X12]
    LD2R { V20.2S, V21.2S }, [X12], X19
    ADD  X12, X12, X7, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X12]
    LD2R { V2.4H, V3.4H }, [X12], X19
    ADD  X12, X12, X7, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X12]
    LD2R { V15.8B, V16.8B }, [X12], X19
    ADD  X12, X12, X7, ASR #0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X29, FPSR
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D1
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D2
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D3
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D4
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D5
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D6
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D7
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D8
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D9
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D10
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D11
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D12
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D13
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D14
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D15
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D16
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D17
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D18
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D19
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D20
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D21
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D22
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D23
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D24
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D25
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D26
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D27
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D28
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D29
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D30
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X29, D31
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X23, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X3
    FMOV  D1, X17
    FMOV  V1.D[1], X22
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X20
    FMOV  V3.D[1], X17
    FMOV  D4, X19
    FMOV  V4.D[1], X12
    FMOV  D5, X20
    FMOV  V5.D[1], X9
    FMOV  D6, X2
    FMOV  V6.D[1], X18
    FMOV  D7, X14
    FMOV  V7.D[1], X15
    FMOV  D8, X14
    FMOV  V8.D[1], X16
    FMOV  D9, X2
    FMOV  V9.D[1], X29
    FMOV  D10, X2
    FMOV  V10.D[1], X17
    FMOV  D11, X7
    FMOV  V11.D[1], X15
    FMOV  D12, X12
    FMOV  V12.D[1], X10
    FMOV  D13, X18
    FMOV  V13.D[1], X3
    FMOV  D14, X7
    FMOV  V14.D[1], X17
    FMOV  D15, X10
    FMOV  V15.D[1], X12
    FMOV  D16, X17
    FMOV  V16.D[1], X29
    FMOV  D17, X16
    FMOV  V17.D[1], X22
    FMOV  D18, X9
    FMOV  V18.D[1], X3
    FMOV  D19, X7
    FMOV  V19.D[1], X13
    FMOV  D20, X19
    FMOV  V20.D[1], X5
    FMOV  D21, X20
    FMOV  V21.D[1], X15
    FMOV  D22, X5
    FMOV  V22.D[1], X23
    FMOV  D23, X17
    FMOV  V23.D[1], X21
    FMOV  D24, X13
    FMOV  V24.D[1], X17
    FMOV  D25, X17
    FMOV  V25.D[1], X14
    FMOV  D26, X8
    FMOV  V26.D[1], X9
    FMOV  D27, X4
    FMOV  V27.D[1], X6
    FMOV  D28, X8
    FMOV  V28.D[1], X23
    FMOV  D29, X16
    FMOV  V29.D[1], X20
    FMOV  D30, X23
    FMOV  V30.D[1], X10
    FMOV  D31, X11
    FMOV  V31.D[1], X10
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X3, #0x1e00, LSL #0
    ADD  X13, X30, X3, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X13]
    LD2R { V14.16B, V15.16B }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X13]
    LD2R { V2.16B, V3.16B }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X13]
    LD2R { V17.2D, V18.2D }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X13]
    LD2R { V12.4S, V13.4S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X13]
    LD2R { V20.8H, V21.8H }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X13]
    LD2R { V5.8B, V6.8B }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X13]
    LD2R { V9.1D, V10.1D }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X13]
    LD2R { V3.2S, V4.2S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X13]
    LD2R { V27.4H, V28.4H }, [X13]
    ADD  X13, X13, X7
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X13]
    LD2R { V25.8B, V26.8B }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X13]
    MOV  X23, X13
    LD2R { V5.2D, V6.2D }, [X23], #16
    ADD  X13, X13, X7, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X13]
    MOV  X23, X13
    LD2R { V31.1D, V0.1D }, [X23], #16
    ADD  X13, X13, X7
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X13]
    MOV  X23, X13
    LD2R { V30.2D, V31.2D }, [X23], #16
    ADD  X13, X13, X7
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X13]
    MOV  X23, X13
    LD2R { V19.16B, V20.16B }, [X23], #2
    ADD  X13, X13, X7, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X13]
    MOV  X23, X13
    LD2R { V15.16B, V16.16B }, [X23], #2
    ADD  X13, X13, X7, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X13]
    MOV  X23, X13
    LD2R { V22.8B, V23.8B }, [X23], #2
    ADD  X13, X13, X7, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X13]
    MOV  X23, X13
    LD2R { V22.4H, V23.4H }, [X23], #4
    ADD  X13, X13, X7, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X13]
    MOV  X23, X13
    LD2R { V10.8H, V11.8H }, [X23], #4
    ADD  X13, X13, X7, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X13]
    MOV  X23, X13
    LD2R { V12.4S, V13.4S }, [X23], #8
    ADD  X13, X13, X7
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X13]
    MOV  X23, X13
    LD2R { V1.2S, V2.2S }, [X23], #8
    ADD  X13, X13, X7, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X13]
    MOV  X23, X13
    LD2R { V15.4S, V16.4S }, [X23], #8
    ADD  X13, X13, X7, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X13]
    MOV  X23, X13
    LD2R { V27.4H, V28.4H }, [X23], #4
    ADD  X13, X13, X7, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X13]
    LD2R { V2.16B, V3.16B }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X13]
    LD2R { V31.16B, V0.16B }, [X13], X11
    ADD  X13, X13, X7, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X13]
    LD2R { V26.2D, V27.2D }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X13]
    LD2R { V24.4S, V25.4S }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X13]
    LD2R { V11.8H, V12.8H }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X13]
    LD2R { V12.1D, V13.1D }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X13]
    LD2R { V15.1D, V16.1D }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X13]
    LD2R { V10.2S, V11.2S }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X13]
    LD2R { V14.4H, V15.4H }, [X13], X11
    ADD  X13, X13, X7
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X13]
    LD2R { V4.8B, V5.8B }, [X13], X11
    ADD  X13, X13, X7, ASR #0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X21, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D1
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D2
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D3
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D4
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D5
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D6
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D7
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D8
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D9
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D10
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D11
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D12
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D13
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D14
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D15
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D16
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D17
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D18
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D19
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D20
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D21
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D22
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D23
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D24
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D25
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D26
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D27
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D28
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D29
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D30
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X21, D31
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X20
    FMOV  D1, X6
    FMOV  V1.D[1], X29
    FMOV  D2, X15
    FMOV  V2.D[1], X22
    FMOV  D3, X29
    FMOV  V3.D[1], X16
    FMOV  D4, X14
    FMOV  V4.D[1], X23
    FMOV  D5, X29
    FMOV  V5.D[1], X21
    FMOV  D6, X12
    FMOV  V6.D[1], X19
    FMOV  D7, X9
    FMOV  V7.D[1], X15
    FMOV  D8, X2
    FMOV  V8.D[1], X15
    FMOV  D9, X14
    FMOV  V9.D[1], X8
    FMOV  D10, X14
    FMOV  V10.D[1], X20
    FMOV  D11, X29
    FMOV  V11.D[1], X18
    FMOV  D12, X4
    FMOV  V12.D[1], X8
    FMOV  D13, X18
    FMOV  V13.D[1], X2
    FMOV  D14, X21
    FMOV  V14.D[1], X10
    FMOV  D15, X21
    FMOV  V15.D[1], X16
    FMOV  D16, X17
    FMOV  V16.D[1], X7
    FMOV  D17, X8
    FMOV  V17.D[1], X4
    FMOV  D18, X16
    FMOV  V18.D[1], X17
    FMOV  D19, X6
    FMOV  V19.D[1], X15
    FMOV  D20, X6
    FMOV  V20.D[1], X12
    FMOV  D21, X22
    FMOV  V21.D[1], X10
    FMOV  D22, X15
    FMOV  V22.D[1], X13
    FMOV  D23, X3
    FMOV  V23.D[1], X9
    FMOV  D24, X10
    FMOV  V24.D[1], X8
    FMOV  D25, X23
    FMOV  V25.D[1], X15
    FMOV  D26, X23
    FMOV  V26.D[1], X5
    FMOV  D27, X8
    FMOV  V27.D[1], X21
    FMOV  D28, X8
    FMOV  V28.D[1], X10
    FMOV  D29, X16
    FMOV  V29.D[1], X9
    FMOV  D30, X3
    FMOV  V30.D[1], X13
    FMOV  D31, X23
    FMOV  V31.D[1], X11
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X21, #0x2300, LSL #0
    ADD  X18, X30, X21, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X18]
    LD2R { V21.16B, V22.16B }, [X18]
    ADD  X18, X18, X7
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X18]
    LD2R { V20.16B, V21.16B }, [X18]
    ADD  X18, X18, X7
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X18]
    LD2R { V0.2D, V1.2D }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X18]
    LD2R { V0.4S, V1.4S }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X18]
    LD2R { V14.8H, V15.8H }, [X18]
    ADD  X18, X18, X7
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X18]
    LD2R { V12.1D, V13.1D }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X18]
    LD2R { V19.1D, V20.1D }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X18]
    LD2R { V8.2S, V9.2S }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X18]
    LD2R { V31.4H, V0.4H }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X18]
    LD2R { V27.8B, V28.8B }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X18]
    MOV  X3, X18
    LD2R { V21.2D, V22.2D }, [X3], #16
    ADD  X18, X18, X7
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X18]
    MOV  X3, X18
    LD2R { V15.1D, V16.1D }, [X3], #16
    ADD  X18, X18, X7, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X18]
    MOV  X3, X18
    LD2R { V18.2D, V19.2D }, [X3], #16
    ADD  X18, X18, X7, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X18]
    MOV  X3, X18
    LD2R { V3.16B, V4.16B }, [X3], #2
    ADD  X18, X18, X7
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X18]
    MOV  X3, X18
    LD2R { V6.16B, V7.16B }, [X3], #2
    ADD  X18, X18, X7, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X18]
    MOV  X3, X18
    LD2R { V19.8B, V20.8B }, [X3], #2
    ADD  X18, X18, X7, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X18]
    MOV  X3, X18
    LD2R { V11.4H, V12.4H }, [X3], #4
    ADD  X18, X18, X7, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X18]
    MOV  X3, X18
    LD2R { V19.8H, V20.8H }, [X3], #4
    ADD  X18, X18, X7, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X18]
    MOV  X3, X18
    LD2R { V9.2S, V10.2S }, [X3], #8
    ADD  X18, X18, X7, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X18]
    MOV  X3, X18
    LD2R { V9.2S, V10.2S }, [X3], #8
    ADD  X18, X18, X7, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X18]
    MOV  X3, X18
    LD2R { V3.4S, V4.4S }, [X3], #8
    ADD  X18, X18, X7
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X18]
    MOV  X3, X18
    LD2R { V29.8H, V30.8H }, [X3], #4
    ADD  X18, X18, X7, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X18]
    LD2R { V6.8H, V7.8H }, [X18], X17
    ADD  X18, X18, X7, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X18]
    LD2R { V30.16B, V31.16B }, [X18], X17
    ADD  X18, X18, X7, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X18]
    LD2R { V15.2D, V16.2D }, [X18], X17
    ADD  X18, X18, X7, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X18]
    LD2R { V18.4S, V19.4S }, [X18], X17
    ADD  X18, X18, X7, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X18]
    LD2R { V12.8H, V13.8H }, [X18], X17
    ADD  X18, X18, X7, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X18]
    LD2R { V16.2S, V17.2S }, [X18], X17
    ADD  X18, X18, X7, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X18]
    LD2R { V29.1D, V30.1D }, [X18], X17
    ADD  X18, X18, X7
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X18]
    LD2R { V13.2S, V14.2S }, [X18], X17
    ADD  X18, X18, X7
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X18]
    LD2R { V14.4H, V15.4H }, [X18], X17
    ADD  X18, X18, X7, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X18]
    LD2R { V15.8B, V16.8B }, [X18], X17
    ADD  X18, X18, X7, LSR #0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X22, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X11, FPSR
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D0
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D1
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D2
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D3
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D4
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D5
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D6
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D7
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D8
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D9
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D10
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D11
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D12
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D13
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D14
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D15
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D16
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D17
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D18
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D19
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D20
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D21
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D22
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D23
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D24
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D25
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D26
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D27
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D28
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D29
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D30
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X11, D31
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X7
    FMOV  V0.D[1], X6
    FMOV  D1, X2
    FMOV  V1.D[1], X20
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X21
    FMOV  V3.D[1], X5
    FMOV  D4, X23
    FMOV  V4.D[1], X7
    FMOV  D5, X14
    FMOV  V5.D[1], X11
    FMOV  D6, X19
    FMOV  V6.D[1], X3
    FMOV  D7, X13
    FMOV  V7.D[1], X9
    FMOV  D8, X8
    FMOV  V8.D[1], X8
    FMOV  D9, X14
    FMOV  V9.D[1], X2
    FMOV  D10, X6
    FMOV  V10.D[1], X5
    FMOV  D11, X6
    FMOV  V11.D[1], X7
    FMOV  D12, X20
    FMOV  V12.D[1], X13
    FMOV  D13, X16
    FMOV  V13.D[1], X14
    FMOV  D14, X7
    FMOV  V14.D[1], X13
    FMOV  D15, X12
    FMOV  V15.D[1], X8
    FMOV  D16, X21
    FMOV  V16.D[1], X22
    FMOV  D17, X20
    FMOV  V17.D[1], X17
    FMOV  D18, X7
    FMOV  V18.D[1], X13
    FMOV  D19, X11
    FMOV  V19.D[1], X3
    FMOV  D20, X12
    FMOV  V20.D[1], X20
    FMOV  D21, X10
    FMOV  V21.D[1], X5
    FMOV  D22, X19
    FMOV  V22.D[1], X13
    FMOV  D23, X16
    FMOV  V23.D[1], X4
    FMOV  D24, X11
    FMOV  V24.D[1], X20
    FMOV  D25, X13
    FMOV  V25.D[1], X16
    FMOV  D26, X23
    FMOV  V26.D[1], X2
    FMOV  D27, X17
    FMOV  V27.D[1], X22
    FMOV  D28, X13
    FMOV  V28.D[1], X10
    FMOV  D29, X19
    FMOV  V29.D[1], X7
    FMOV  D30, X12
    FMOV  V30.D[1], X18
    FMOV  D31, X16
    FMOV  V31.D[1], X4
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X7, #0x2800, LSL #0
    ADD  X14, X30, X7, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X14]
    LD2R { V26.8H, V27.8H }, [X14]
    ADD  X14, X14, X3, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X14]
    LD2R { V28.16B, V29.16B }, [X14]
    ADD  X14, X14, X3, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X14]
    LD2R { V10.2D, V11.2D }, [X14]
    ADD  X14, X14, X3, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X14]
    LD2R { V9.4S, V10.4S }, [X14]
    ADD  X14, X14, X3, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X14]
    LD2R { V17.8H, V18.8H }, [X14]
    ADD  X14, X14, X3, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X14]
    LD2R { V0.8B, V1.8B }, [X14]
    ADD  X14, X14, X3
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X14]
    LD2R { V24.1D, V25.1D }, [X14]
    ADD  X14, X14, X3
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X14]
    LD2R { V28.2S, V29.2S }, [X14]
    ADD  X14, X14, X3, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X14]
    LD2R { V13.4H, V14.4H }, [X14]
    ADD  X14, X14, X3, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X14]
    LD2R { V15.8B, V16.8B }, [X14]
    ADD  X14, X14, X3, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X14]
    MOV  X11, X14
    LD2R { V7.2D, V8.2D }, [X11], #16
    ADD  X14, X14, X3, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X14]
    MOV  X11, X14
    LD2R { V11.1D, V12.1D }, [X11], #16
    ADD  X14, X14, X3, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X14]
    MOV  X11, X14
    LD2R { V28.2D, V29.2D }, [X11], #16
    ADD  X14, X14, X3
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X14]
    MOV  X11, X14
    LD2R { V16.16B, V17.16B }, [X11], #2
    ADD  X14, X14, X3, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X14]
    MOV  X11, X14
    LD2R { V25.16B, V26.16B }, [X11], #2
    ADD  X14, X14, X3, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X14]
    MOV  X11, X14
    LD2R { V3.8B, V4.8B }, [X11], #2
    ADD  X14, X14, X3, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X14]
    MOV  X11, X14
    LD2R { V0.4H, V1.4H }, [X11], #4
    ADD  X14, X14, X3, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X14]
    MOV  X11, X14
    LD2R { V29.8H, V30.8H }, [X11], #4
    ADD  X14, X14, X3, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X14]
    MOV  X11, X14
    LD2R { V27.2S, V28.2S }, [X11], #8
    ADD  X14, X14, X3
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X14]
    MOV  X11, X14
    LD2R { V28.2S, V29.2S }, [X11], #8
    ADD  X14, X14, X3, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X14]
    MOV  X11, X14
    LD2R { V13.4S, V14.4S }, [X11], #8
    ADD  X14, X14, X3, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X14]
    MOV  X11, X14
    LD2R { V24.8H, V25.8H }, [X11], #4
    ADD  X14, X14, X3, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X14]
    LD2R { V6.2D, V7.2D }, [X14], X4
    ADD  X14, X14, X3, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X14]
    LD2R { V25.16B, V26.16B }, [X14], X4
    ADD  X14, X14, X3
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X14]
    LD2R { V27.2D, V28.2D }, [X14], X4
    ADD  X14, X14, X3, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X14]
    LD2R { V2.4S, V3.4S }, [X14], X4
    ADD  X14, X14, X3
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X14]
    LD2R { V30.8H, V31.8H }, [X14], X4
    ADD  X14, X14, X3
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X14]
    LD2R { V14.2S, V15.2S }, [X14], X4
    ADD  X14, X14, X3, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X14]
    LD2R { V18.1D, V19.1D }, [X14], X4
    ADD  X14, X14, X3, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X14]
    LD2R { V6.2S, V7.2S }, [X14], X4
    ADD  X14, X14, X3, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X14]
    LD2R { V31.4H, V0.4H }, [X14], X4
    ADD  X14, X14, X3, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X14]
    LD2R { V18.8B, V19.8B }, [X14], X4
    ADD  X14, X14, X3, LSR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X19, FPSR
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D1
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D2
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D3
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D4
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D5
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D6
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D7
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D8
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D9
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D10
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D11
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D12
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D13
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D14
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D15
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D16
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D17
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D18
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D19
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D20
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D21
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D22
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D23
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D24
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D25
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D26
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D27
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D28
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D29
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D30
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X19, D31
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X20
    FMOV  D1, X23
    FMOV  V1.D[1], X29
    FMOV  D2, X22
    FMOV  V2.D[1], X13
    FMOV  D3, X12
    FMOV  V3.D[1], X6
    FMOV  D4, X12
    FMOV  V4.D[1], X11
    FMOV  D5, X16
    FMOV  V5.D[1], X29
    FMOV  D6, X12
    FMOV  V6.D[1], X22
    FMOV  D7, X15
    FMOV  V7.D[1], X2
    FMOV  D8, X10
    FMOV  V8.D[1], X16
    FMOV  D9, X4
    FMOV  V9.D[1], X20
    FMOV  D10, X11
    FMOV  V10.D[1], X11
    FMOV  D11, X5
    FMOV  V11.D[1], X15
    FMOV  D12, X16
    FMOV  V12.D[1], X4
    FMOV  D13, X13
    FMOV  V13.D[1], X23
    FMOV  D14, X8
    FMOV  V14.D[1], X16
    FMOV  D15, X8
    FMOV  V15.D[1], X23
    FMOV  D16, X9
    FMOV  V16.D[1], X29
    FMOV  D17, X16
    FMOV  V17.D[1], X13
    FMOV  D18, X13
    FMOV  V18.D[1], X16
    FMOV  D19, X2
    FMOV  V19.D[1], X21
    FMOV  D20, X7
    FMOV  V20.D[1], X4
    FMOV  D21, X29
    FMOV  V21.D[1], X8
    FMOV  D22, X16
    FMOV  V22.D[1], X2
    FMOV  D23, X10
    FMOV  V23.D[1], X4
    FMOV  D24, X5
    FMOV  V24.D[1], X17
    FMOV  D25, X12
    FMOV  V25.D[1], X14
    FMOV  D26, X8
    FMOV  V26.D[1], X5
    FMOV  D27, X23
    FMOV  V27.D[1], X7
    FMOV  D28, X23
    FMOV  V28.D[1], X3
    FMOV  D29, X23
    FMOV  V29.D[1], X29
    FMOV  D30, X5
    FMOV  V30.D[1], X10
    FMOV  D31, X23
    FMOV  V31.D[1], X13
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X14, #0x2d00, LSL #0
    ADD  X11, X30, X14, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X11]
    LD2R { V12.8H, V13.8H }, [X11]
    ADD  X11, X11, X7, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X11]
    LD2R { V17.16B, V18.16B }, [X11]
    ADD  X11, X11, X7
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X11]
    LD2R { V7.2D, V8.2D }, [X11]
    ADD  X11, X11, X7, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X11]
    LD2R { V21.4S, V22.4S }, [X11]
    ADD  X11, X11, X7, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X11]
    LD2R { V27.8H, V28.8H }, [X11]
    ADD  X11, X11, X7, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X11]
    LD2R { V10.4H, V11.4H }, [X11]
    ADD  X11, X11, X7, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X11]
    LD2R { V17.1D, V18.1D }, [X11]
    ADD  X11, X11, X7
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X11]
    LD2R { V26.2S, V27.2S }, [X11]
    ADD  X11, X11, X7, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X11]
    LD2R { V12.4H, V13.4H }, [X11]
    ADD  X11, X11, X7, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X11]
    LD2R { V31.8B, V0.8B }, [X11]
    ADD  X11, X11, X7, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X11]
    MOV  X12, X11
    LD2R { V28.2D, V29.2D }, [X12], #16
    ADD  X11, X11, X7, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X11]
    MOV  X12, X11
    LD2R { V0.1D, V1.1D }, [X12], #16
    ADD  X11, X11, X7
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X11]
    MOV  X12, X11
    LD2R { V17.2D, V18.2D }, [X12], #16
    ADD  X11, X11, X7, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X11]
    MOV  X12, X11
    LD2R { V27.16B, V28.16B }, [X12], #2
    ADD  X11, X11, X7
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X11]
    MOV  X12, X11
    LD2R { V29.16B, V30.16B }, [X12], #2
    ADD  X11, X11, X7
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X11]
    MOV  X12, X11
    LD2R { V8.8B, V9.8B }, [X12], #2
    ADD  X11, X11, X7
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X11]
    MOV  X12, X11
    LD2R { V14.4H, V15.4H }, [X12], #4
    ADD  X11, X11, X7, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X11]
    MOV  X12, X11
    LD2R { V18.8H, V19.8H }, [X12], #4
    ADD  X11, X11, X7
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X11]
    MOV  X12, X11
    LD2R { V21.4S, V22.4S }, [X12], #8
    ADD  X11, X11, X7, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X11]
    MOV  X12, X11
    LD2R { V23.2S, V24.2S }, [X12], #8
    ADD  X11, X11, X7, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X11]
    MOV  X12, X11
    LD2R { V31.4S, V0.4S }, [X12], #8
    ADD  X11, X11, X7, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X11]
    MOV  X12, X11
    LD2R { V1.4H, V2.4H }, [X12], #4
    ADD  X11, X11, X7, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X11]
    LD2R { V2.4S, V3.4S }, [X11], X13
    ADD  X11, X11, X7
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X11]
    LD2R { V18.16B, V19.16B }, [X11], X13
    ADD  X11, X11, X7
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X11]
    LD2R { V25.2D, V26.2D }, [X11], X13
    ADD  X11, X11, X7, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X11]
    LD2R { V27.4S, V28.4S }, [X11], X13
    ADD  X11, X11, X7, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X11]
    LD2R { V21.8H, V22.8H }, [X11], X13
    ADD  X11, X11, X7, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X11]
    LD2R { V2.8B, V3.8B }, [X11], X13
    ADD  X11, X11, X7, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X11]
    LD2R { V26.1D, V27.1D }, [X11], X13
    ADD  X11, X11, X7, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X11]
    LD2R { V6.2S, V7.2S }, [X11], X13
    ADD  X11, X11, X7
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X11]
    LD2R { V18.4H, V19.4H }, [X11], X13
    ADD  X11, X11, X7, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X11]
    LD2R { V4.8B, V5.8B }, [X11], X13
    ADD  X11, X11, X7, LSR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X23, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D1
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D2
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D3
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D4
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D5
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D6
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D7
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D8
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D9
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D10
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D11
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D12
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D13
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D14
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D15
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D16
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D17
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D18
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D19
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D20
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D21
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D22
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D23
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D24
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D25
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D26
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D27
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D28
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D29
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D30
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D31
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X22, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X20
    FMOV  D1, X7
    FMOV  V1.D[1], X4
    FMOV  D2, X4
    FMOV  V2.D[1], X15
    FMOV  D3, X23
    FMOV  V3.D[1], X22
    FMOV  D4, X11
    FMOV  V4.D[1], X29
    FMOV  D5, X23
    FMOV  V5.D[1], X21
    FMOV  D6, X29
    FMOV  V6.D[1], X29
    FMOV  D7, X23
    FMOV  V7.D[1], X16
    FMOV  D8, X3
    FMOV  V8.D[1], X23
    FMOV  D9, X16
    FMOV  V9.D[1], X10
    FMOV  D10, X5
    FMOV  V10.D[1], X14
    FMOV  D11, X20
    FMOV  V11.D[1], X15
    FMOV  D12, X20
    FMOV  V12.D[1], X5
    FMOV  D13, X2
    FMOV  V13.D[1], X11
    FMOV  D14, X5
    FMOV  V14.D[1], X19
    FMOV  D15, X9
    FMOV  V15.D[1], X6
    FMOV  D16, X23
    FMOV  V16.D[1], X22
    FMOV  D17, X14
    FMOV  V17.D[1], X13
    FMOV  D18, X29
    FMOV  V18.D[1], X6
    FMOV  D19, X12
    FMOV  V19.D[1], X6
    FMOV  D20, X11
    FMOV  V20.D[1], X12
    FMOV  D21, X5
    FMOV  V21.D[1], X4
    FMOV  D22, X29
    FMOV  V22.D[1], X16
    FMOV  D23, X19
    FMOV  V23.D[1], X9
    FMOV  D24, X7
    FMOV  V24.D[1], X8
    FMOV  D25, X23
    FMOV  V25.D[1], X22
    FMOV  D26, X17
    FMOV  V26.D[1], X29
    FMOV  D27, X11
    FMOV  V27.D[1], X11
    FMOV  D28, X8
    FMOV  V28.D[1], X6
    FMOV  D29, X5
    FMOV  V29.D[1], X23
    FMOV  D30, X14
    FMOV  V30.D[1], X20
    FMOV  D31, X7
    FMOV  V31.D[1], X9
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X21, #0x0, LSL #0
    ADD  X12, X30, X21, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X12]
    LD2R { V17.8H, V18.8H }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X12]
    LD2R { V28.16B, V29.16B }, [X12]
    ADD  X12, X12, X4, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X12]
    LD2R { V17.2D, V18.2D }, [X12]
    ADD  X12, X12, X4
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X12]
    LD2R { V19.4S, V20.4S }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X12]
    LD2R { V25.8H, V26.8H }, [X12]
    ADD  X12, X12, X4, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X12]
    LD2R { V24.8B, V25.8B }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X12]
    LD2R { V9.1D, V10.1D }, [X12]
    ADD  X12, X12, X4
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X12]
    LD2R { V27.2S, V28.2S }, [X12]
    ADD  X12, X12, X4
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X12]
    LD2R { V19.4H, V20.4H }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X12]
    LD2R { V26.8B, V27.8B }, [X12]
    ADD  X12, X12, X4, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X12]
    MOV  X2, X12
    LD2R { V24.2D, V25.2D }, [X2], #16
    ADD  X12, X12, X4
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X12]
    MOV  X2, X12
    LD2R { V29.1D, V30.1D }, [X2], #16
    ADD  X12, X12, X4
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X12]
    MOV  X2, X12
    LD2R { V27.2D, V28.2D }, [X2], #16
    ADD  X12, X12, X4, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X12]
    MOV  X2, X12
    LD2R { V31.16B, V0.16B }, [X2], #2
    ADD  X12, X12, X4
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X12]
    MOV  X2, X12
    LD2R { V27.16B, V28.16B }, [X2], #2
    ADD  X12, X12, X4, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X12]
    MOV  X2, X12
    LD2R { V20.8B, V21.8B }, [X2], #2
    ADD  X12, X12, X4, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X12]
    MOV  X2, X12
    LD2R { V17.4H, V18.4H }, [X2], #4
    ADD  X12, X12, X4, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X12]
    MOV  X2, X12
    LD2R { V29.8H, V30.8H }, [X2], #4
    ADD  X12, X12, X4, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X12]
    MOV  X2, X12
    LD2R { V5.4S, V6.4S }, [X2], #8
    ADD  X12, X12, X4
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X12]
    MOV  X2, X12
    LD2R { V17.2S, V18.2S }, [X2], #8
    ADD  X12, X12, X4, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X12]
    MOV  X2, X12
    LD2R { V26.4S, V27.4S }, [X2], #8
    ADD  X12, X12, X4, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X12]
    MOV  X2, X12
    LD2R { V26.4H, V27.4H }, [X2], #4
    ADD  X12, X12, X4
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X12]
    LD2R { V25.8H, V26.8H }, [X12], X6
    ADD  X12, X12, X4, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X12]
    LD2R { V21.16B, V22.16B }, [X12], X6
    ADD  X12, X12, X4, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X12]
    LD2R { V1.2D, V2.2D }, [X12], X6
    ADD  X12, X12, X4
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X12]
    LD2R { V14.4S, V15.4S }, [X12], X6
    ADD  X12, X12, X4
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X12]
    LD2R { V30.8H, V31.8H }, [X12], X6
    ADD  X12, X12, X4, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X12]
    LD2R { V13.4H, V14.4H }, [X12], X6
    ADD  X12, X12, X4, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X12]
    LD2R { V5.1D, V6.1D }, [X12], X6
    ADD  X12, X12, X4
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X12]
    LD2R { V19.2S, V20.2S }, [X12], X6
    ADD  X12, X12, X4
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X12]
    LD2R { V12.4H, V13.4H }, [X12], X6
    ADD  X12, X12, X4, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X12]
    LD2R { V28.8B, V29.8B }, [X12], X6
    ADD  X12, X12, X4
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X10, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D1
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D2
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D5
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D6
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D7
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D8
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D9
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D10
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D11
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D12
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D14
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D15
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D16
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D17
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D18
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D19
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D20
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D22
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D23
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D24
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D25
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D26
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D27
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D29
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D30
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X10, D31
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X8, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X21
    FMOV  V1.D[1], X22
    FMOV  D2, X8
    FMOV  V2.D[1], X7
    FMOV  D3, X23
    FMOV  V3.D[1], X21
    FMOV  D4, X15
    FMOV  V4.D[1], X19
    FMOV  D5, X14
    FMOV  V5.D[1], X15
    FMOV  D6, X6
    FMOV  V6.D[1], X3
    FMOV  D7, X23
    FMOV  V7.D[1], X11
    FMOV  D8, X14
    FMOV  V8.D[1], X3
    FMOV  D9, X19
    FMOV  V9.D[1], X13
    FMOV  D10, X16
    FMOV  V10.D[1], X11
    FMOV  D11, X4
    FMOV  V11.D[1], X16
    FMOV  D12, X4
    FMOV  V12.D[1], X20
    FMOV  D13, X17
    FMOV  V13.D[1], X16
    FMOV  D14, X18
    FMOV  V14.D[1], X15
    FMOV  D15, X14
    FMOV  V15.D[1], X12
    FMOV  D16, X21
    FMOV  V16.D[1], X14
    FMOV  D17, X19
    FMOV  V17.D[1], X16
    FMOV  D18, X19
    FMOV  V18.D[1], X11
    FMOV  D19, X7
    FMOV  V19.D[1], X15
    FMOV  D20, X19
    FMOV  V20.D[1], X4
    FMOV  D21, X14
    FMOV  V21.D[1], X15
    FMOV  D22, X8
    FMOV  V22.D[1], X29
    FMOV  D23, X5
    FMOV  V23.D[1], X13
    FMOV  D24, X14
    FMOV  V24.D[1], X17
    FMOV  D25, X23
    FMOV  V25.D[1], X4
    FMOV  D26, X14
    FMOV  V26.D[1], X20
    FMOV  D27, X14
    FMOV  V27.D[1], X11
    FMOV  D28, X4
    FMOV  V28.D[1], X9
    FMOV  D29, X29
    FMOV  V29.D[1], X8
    FMOV  D30, X2
    FMOV  V30.D[1], X29
    FMOV  D31, X13
    FMOV  V31.D[1], X23
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X14, #0x500, LSL #0
    ADD  X18, X30, X14, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X18]
    LD2R { V21.16B, V22.16B }, [X18]
    ADD  X18, X18, X4, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X18]
    LD2R { V22.16B, V23.16B }, [X18]
    ADD  X18, X18, X4, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X18]
    LD2R { V20.2D, V21.2D }, [X18]
    ADD  X18, X18, X4, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X18]
    LD2R { V17.4S, V18.4S }, [X18]
    ADD  X18, X18, X4, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X18]
    LD2R { V21.8H, V22.8H }, [X18]
    ADD  X18, X18, X4
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X18]
    LD2R { V29.8B, V30.8B }, [X18]
    ADD  X18, X18, X4
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X18]
    LD2R { V6.1D, V7.1D }, [X18]
    ADD  X18, X18, X4
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X18]
    LD2R { V18.2S, V19.2S }, [X18]
    ADD  X18, X18, X4, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X18]
    LD2R { V30.4H, V31.4H }, [X18]
    ADD  X18, X18, X4, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X18]
    LD2R { V30.8B, V31.8B }, [X18]
    ADD  X18, X18, X4, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X18]
    MOV  X8, X18
    LD2R { V8.1D, V9.1D }, [X8], #16
    ADD  X18, X18, X4
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X18]
    MOV  X8, X18
    LD2R { V6.1D, V7.1D }, [X8], #16
    ADD  X18, X18, X4, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X18]
    MOV  X8, X18
    LD2R { V17.2D, V18.2D }, [X8], #16
    ADD  X18, X18, X4
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X18]
    MOV  X8, X18
    LD2R { V8.16B, V9.16B }, [X8], #2
    ADD  X18, X18, X4, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X18]
    MOV  X8, X18
    LD2R { V22.16B, V23.16B }, [X8], #2
    ADD  X18, X18, X4, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X18]
    MOV  X8, X18
    LD2R { V8.8B, V9.8B }, [X8], #2
    ADD  X18, X18, X4
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X18]
    MOV  X8, X18
    LD2R { V5.4H, V6.4H }, [X8], #4
    ADD  X18, X18, X4, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X18]
    MOV  X8, X18
    LD2R { V27.8H, V28.8H }, [X8], #4
    ADD  X18, X18, X4, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X18]
    MOV  X8, X18
    LD2R { V10.2S, V11.2S }, [X8], #8
    ADD  X18, X18, X4, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X18]
    MOV  X8, X18
    LD2R { V24.2S, V25.2S }, [X8], #8
    ADD  X18, X18, X4
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X18]
    MOV  X8, X18
    LD2R { V4.4S, V5.4S }, [X8], #8
    ADD  X18, X18, X4, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X18]
    MOV  X8, X18
    LD2R { V16.8H, V17.8H }, [X8], #4
    ADD  X18, X18, X4, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X18]
    LD2R { V22.16B, V23.16B }, [X18], X5
    ADD  X18, X18, X4, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X18]
    LD2R { V13.16B, V14.16B }, [X18], X5
    ADD  X18, X18, X4, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X18]
    LD2R { V0.2D, V1.2D }, [X18], X5
    ADD  X18, X18, X4
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X18]
    LD2R { V16.4S, V17.4S }, [X18], X5
    ADD  X18, X18, X4, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X18]
    LD2R { V10.8H, V11.8H }, [X18], X5
    ADD  X18, X18, X4, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X18]
    LD2R { V24.2S, V25.2S }, [X18], X5
    ADD  X18, X18, X4, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X18]
    LD2R { V22.1D, V23.1D }, [X18], X5
    ADD  X18, X18, X4
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X18]
    LD2R { V3.2S, V4.2S }, [X18], X5
    ADD  X18, X18, X4, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X18]
    LD2R { V5.4H, V6.4H }, [X18], X5
    ADD  X18, X18, X4, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X18]
    LD2R { V26.8B, V27.8B }, [X18], X5
    ADD  X18, X18, X4, LSR #0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X11, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X13, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D1
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D2
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D3
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D4
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D5
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D6
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D7
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D8
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D10
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D11
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D12
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D13
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D14
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D15
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D16
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D17
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D18
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D19
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D20
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D21
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D22
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D23
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D24
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D25
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D26
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D27
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D28
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D29
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D30
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X13, D31
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X4
    FMOV  V0.D[1], X22
    FMOV  D1, X22
    FMOV  V1.D[1], X29
    FMOV  D2, X10
    FMOV  V2.D[1], X21
    FMOV  D3, X23
    FMOV  V3.D[1], X29
    FMOV  D4, X16
    FMOV  V4.D[1], X7
    FMOV  D5, X22
    FMOV  V5.D[1], X20
    FMOV  D6, X20
    FMOV  V6.D[1], X11
    FMOV  D7, X7
    FMOV  V7.D[1], X29
    FMOV  D8, X10
    FMOV  V8.D[1], X2
    FMOV  D9, X6
    FMOV  V9.D[1], X3
    FMOV  D10, X16
    FMOV  V10.D[1], X20
    FMOV  D11, X21
    FMOV  V11.D[1], X29
    FMOV  D12, X20
    FMOV  V12.D[1], X18
    FMOV  D13, X9
    FMOV  V13.D[1], X13
    FMOV  D14, X14
    FMOV  V14.D[1], X21
    FMOV  D15, X20
    FMOV  V15.D[1], X11
    FMOV  D16, X3
    FMOV  V16.D[1], X2
    FMOV  D17, X8
    FMOV  V17.D[1], X13
    FMOV  D18, X10
    FMOV  V18.D[1], X29
    FMOV  D19, X22
    FMOV  V19.D[1], X2
    FMOV  D20, X16
    FMOV  V20.D[1], X15
    FMOV  D21, X3
    FMOV  V21.D[1], X7
    FMOV  D22, X21
    FMOV  V22.D[1], X18
    FMOV  D23, X3
    FMOV  V23.D[1], X23
    FMOV  D24, X21
    FMOV  V24.D[1], X16
    FMOV  D25, X9
    FMOV  V25.D[1], X4
    FMOV  D26, X29
    FMOV  V26.D[1], X11
    FMOV  D27, X2
    FMOV  V27.D[1], X20
    FMOV  D28, X6
    FMOV  V28.D[1], X18
    FMOV  D29, X12
    FMOV  V29.D[1], X15
    FMOV  D30, X13
    FMOV  V30.D[1], X6
    FMOV  D31, X21
    FMOV  V31.D[1], X20
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X8, #0xa00, LSL #0
    ADD  X10, X30, X8, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X10]
    LD2R { V28.2D, V29.2D }, [X10]
    ADD  X10, X10, X15, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X10]
    LD2R { V10.16B, V11.16B }, [X10]
    ADD  X10, X10, X15
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X10]
    LD2R { V29.2D, V30.2D }, [X10]
    ADD  X10, X10, X15, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X10]
    LD2R { V25.4S, V26.4S }, [X10]
    ADD  X10, X10, X15
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X10]
    LD2R { V5.8H, V6.8H }, [X10]
    ADD  X10, X10, X15, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X10]
    LD2R { V29.1D, V30.1D }, [X10]
    ADD  X10, X10, X15, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X10]
    LD2R { V13.1D, V14.1D }, [X10]
    ADD  X10, X10, X15, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X10]
    LD2R { V10.2S, V11.2S }, [X10]
    ADD  X10, X10, X15, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X10]
    LD2R { V10.4H, V11.4H }, [X10]
    ADD  X10, X10, X15, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X10]
    LD2R { V20.8B, V21.8B }, [X10]
    ADD  X10, X10, X15, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X10]
    MOV  X5, X10
    LD2R { V4.2D, V5.2D }, [X5], #16
    ADD  X10, X10, X15, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X10]
    MOV  X5, X10
    LD2R { V23.1D, V24.1D }, [X5], #16
    ADD  X10, X10, X15, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X10]
    MOV  X5, X10
    LD2R { V10.2D, V11.2D }, [X5], #16
    ADD  X10, X10, X15
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X10]
    MOV  X5, X10
    LD2R { V22.8B, V23.8B }, [X5], #2
    ADD  X10, X10, X15, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X10]
    MOV  X5, X10
    LD2R { V3.16B, V4.16B }, [X5], #2
    ADD  X10, X10, X15, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X10]
    MOV  X5, X10
    LD2R { V15.8B, V16.8B }, [X5], #2
    ADD  X10, X10, X15, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X10]
    MOV  X5, X10
    LD2R { V25.4H, V26.4H }, [X5], #4
    ADD  X10, X10, X15
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X10]
    MOV  X5, X10
    LD2R { V9.8H, V10.8H }, [X5], #4
    ADD  X10, X10, X15, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X10]
    MOV  X5, X10
    LD2R { V2.2S, V3.2S }, [X5], #8
    ADD  X10, X10, X15
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X10]
    MOV  X5, X10
    LD2R { V14.2S, V15.2S }, [X5], #8
    ADD  X10, X10, X15, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X10]
    MOV  X5, X10
    LD2R { V0.4S, V1.4S }, [X5], #8
    ADD  X10, X10, X15
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X10]
    MOV  X5, X10
    LD2R { V10.4H, V11.4H }, [X5], #4
    ADD  X10, X10, X15, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X10]
    LD2R { V19.8H, V20.8H }, [X10], X11
    ADD  X10, X10, X15, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X10]
    LD2R { V27.16B, V28.16B }, [X10], X11
    ADD  X10, X10, X15, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X10]
    LD2R { V2.2D, V3.2D }, [X10], X11
    ADD  X10, X10, X15
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X10]
    LD2R { V19.4S, V20.4S }, [X10], X11
    ADD  X10, X10, X15, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X10]
    LD2R { V21.8H, V22.8H }, [X10], X11
    ADD  X10, X10, X15, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X10]
    LD2R { V26.2S, V27.2S }, [X10], X11
    ADD  X10, X10, X15, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X10]
    LD2R { V21.1D, V22.1D }, [X10], X11
    ADD  X10, X10, X15
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X10]
    LD2R { V2.2S, V3.2S }, [X10], X11
    ADD  X10, X10, X15, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X10]
    LD2R { V0.4H, V1.4H }, [X10], X11
    ADD  X10, X10, X15, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X10]
    LD2R { V22.8B, V23.8B }, [X10], X11
    ADD  X10, X10, X15
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X18, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X19
    FMOV  D1, X11
    FMOV  V1.D[1], X21
    FMOV  D2, X16
    FMOV  V2.D[1], X14
    FMOV  D3, X16
    FMOV  V3.D[1], X22
    FMOV  D4, X20
    FMOV  V4.D[1], X4
    FMOV  D5, X15
    FMOV  V5.D[1], X11
    FMOV  D6, X6
    FMOV  V6.D[1], X9
    FMOV  D7, X29
    FMOV  V7.D[1], X8
    FMOV  D8, X11
    FMOV  V8.D[1], X4
    FMOV  D9, X20
    FMOV  V9.D[1], X12
    FMOV  D10, X29
    FMOV  V10.D[1], X29
    FMOV  D11, X17
    FMOV  V11.D[1], X6
    FMOV  D12, X5
    FMOV  V12.D[1], X16
    FMOV  D13, X9
    FMOV  V13.D[1], X13
    FMOV  D14, X20
    FMOV  V14.D[1], X23
    FMOV  D15, X12
    FMOV  V15.D[1], X10
    FMOV  D16, X11
    FMOV  V16.D[1], X20
    FMOV  D17, X13
    FMOV  V17.D[1], X9
    FMOV  D18, X10
    FMOV  V18.D[1], X17
    FMOV  D19, X10
    FMOV  V19.D[1], X19
    FMOV  D20, X11
    FMOV  V20.D[1], X14
    FMOV  D21, X2
    FMOV  V21.D[1], X6
    FMOV  D22, X8
    FMOV  V22.D[1], X14
    FMOV  D23, X15
    FMOV  V23.D[1], X12
    FMOV  D24, X29
    FMOV  V24.D[1], X5
    FMOV  D25, X20
    FMOV  V25.D[1], X18
    FMOV  D26, X3
    FMOV  V26.D[1], X21
    FMOV  D27, X15
    FMOV  V27.D[1], X7
    FMOV  D28, X3
    FMOV  V28.D[1], X8
    FMOV  D29, X5
    FMOV  V29.D[1], X12
    FMOV  D30, X9
    FMOV  V30.D[1], X6
    FMOV  D31, X20
    FMOV  V31.D[1], X5
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X14, #0xf00, LSL #0
    ADD  X7, X30, X14, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X7]
    LD2R { V8.8H, V9.8H }, [X7]
    ADD  X7, X7, X20
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X7]
    LD2R { V20.16B, V21.16B }, [X7]
    ADD  X7, X7, X20, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X7]
    LD2R { V18.2D, V19.2D }, [X7]
    ADD  X7, X7, X20, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X7]
    LD2R { V4.4S, V5.4S }, [X7]
    ADD  X7, X7, X20, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X7]
    LD2R { V3.8H, V4.8H }, [X7]
    ADD  X7, X7, X20, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X7]
    LD2R { V24.8B, V25.8B }, [X7]
    ADD  X7, X7, X20, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X7]
    LD2R { V26.1D, V27.1D }, [X7]
    ADD  X7, X7, X20
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X7]
    LD2R { V1.2S, V2.2S }, [X7]
    ADD  X7, X7, X20, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X7]
    LD2R { V28.4H, V29.4H }, [X7]
    ADD  X7, X7, X20, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X7]
    LD2R { V2.8B, V3.8B }, [X7]
    ADD  X7, X7, X20, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X7]
    MOV  X10, X7
    LD2R { V26.2D, V27.2D }, [X10], #16
    ADD  X7, X7, X20, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X7]
    MOV  X10, X7
    LD2R { V5.1D, V6.1D }, [X10], #16
    ADD  X7, X7, X20, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X7]
    MOV  X10, X7
    LD2R { V3.2D, V4.2D }, [X10], #16
    ADD  X7, X7, X20
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X7]
    MOV  X10, X7
    LD2R { V28.8B, V29.8B }, [X10], #2
    ADD  X7, X7, X20, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X7]
    MOV  X10, X7
    LD2R { V24.16B, V25.16B }, [X10], #2
    ADD  X7, X7, X20, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X7]
    MOV  X10, X7
    LD2R { V30.8B, V31.8B }, [X10], #2
    ADD  X7, X7, X20
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X7]
    MOV  X10, X7
    LD2R { V6.4H, V7.4H }, [X10], #4
    ADD  X7, X7, X20, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X7]
    MOV  X10, X7
    LD2R { V30.8H, V31.8H }, [X10], #4
    ADD  X7, X7, X20, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X7]
    MOV  X10, X7
    LD2R { V24.4S, V25.4S }, [X10], #8
    ADD  X7, X7, X20, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X7]
    MOV  X10, X7
    LD2R { V27.2S, V28.2S }, [X10], #8
    ADD  X7, X7, X20
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X7]
    MOV  X10, X7
    LD2R { V20.4S, V21.4S }, [X10], #8
    ADD  X7, X7, X20
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X7]
    MOV  X10, X7
    LD2R { V22.4H, V23.4H }, [X10], #4
    ADD  X7, X7, X20, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X7]
    LD2R { V10.8H, V11.8H }, [X7], X12
    ADD  X7, X7, X20
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X7]
    LD2R { V20.16B, V21.16B }, [X7], X12
    ADD  X7, X7, X20
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X7]
    LD2R { V5.2D, V6.2D }, [X7], X12
    ADD  X7, X7, X20
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X7]
    LD2R { V22.4S, V23.4S }, [X7], X12
    ADD  X7, X7, X20
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X7]
    LD2R { V14.8H, V15.8H }, [X7], X12
    ADD  X7, X7, X20, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X7]
    LD2R { V8.8B, V9.8B }, [X7], X12
    ADD  X7, X7, X20, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X7]
    LD2R { V19.1D, V20.1D }, [X7], X12
    ADD  X7, X7, X20, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X7]
    LD2R { V17.2S, V18.2S }, [X7], X12
    ADD  X7, X7, X20, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X7]
    LD2R { V7.4H, V8.4H }, [X7], X12
    ADD  X7, X7, X20
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X7]
    LD2R { V4.8B, V5.8B }, [X7], X12
    ADD  X7, X7, X20
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X8, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D1
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D2
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D3
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D4
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D5
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D6
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D7
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D8
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D9
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D10
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D11
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D12
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D13
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D14
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D15
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D16
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D17
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D18
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D19
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D20
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D21
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D22
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D23
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D24
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D25
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D26
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D27
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D28
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D29
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D30
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D31
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X22
    FMOV  D2, X23
    FMOV  V2.D[1], X6
    FMOV  D3, X5
    FMOV  V3.D[1], X12
    FMOV  D4, X9
    FMOV  V4.D[1], X4
    FMOV  D5, X19
    FMOV  V5.D[1], X14
    FMOV  D6, X12
    FMOV  V6.D[1], X20
    FMOV  D7, X23
    FMOV  V7.D[1], X6
    FMOV  D8, X20
    FMOV  V8.D[1], X10
    FMOV  D9, X15
    FMOV  V9.D[1], X7
    FMOV  D10, X16
    FMOV  V10.D[1], X20
    FMOV  D11, X14
    FMOV  V11.D[1], X5
    FMOV  D12, X17
    FMOV  V12.D[1], X2
    FMOV  D13, X14
    FMOV  V13.D[1], X20
    FMOV  D14, X2
    FMOV  V14.D[1], X21
    FMOV  D15, X22
    FMOV  V15.D[1], X16
    FMOV  D16, X20
    FMOV  V16.D[1], X29
    FMOV  D17, X14
    FMOV  V17.D[1], X14
    FMOV  D18, X3
    FMOV  V18.D[1], X13
    FMOV  D19, X2
    FMOV  V19.D[1], X14
    FMOV  D20, X5
    FMOV  V20.D[1], X15
    FMOV  D21, X15
    FMOV  V21.D[1], X17
    FMOV  D22, X9
    FMOV  V22.D[1], X14
    FMOV  D23, X3
    FMOV  V23.D[1], X6
    FMOV  D24, X18
    FMOV  V24.D[1], X20
    FMOV  D25, X18
    FMOV  V25.D[1], X21
    FMOV  D26, X15
    FMOV  V26.D[1], X20
    FMOV  D27, X2
    FMOV  V27.D[1], X17
    FMOV  D28, X12
    FMOV  V28.D[1], X2
    FMOV  D29, X4
    FMOV  V29.D[1], X8
    FMOV  D30, X15
    FMOV  V30.D[1], X6
    FMOV  D31, X23
    FMOV  V31.D[1], X4
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X3, #0x1400, LSL #0
    ADD  X23, X30, X3
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X23]
    LD2R { V9.4S, V10.4S }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X23]
    LD2R { V5.16B, V6.16B }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X23]
    LD2R { V25.2D, V26.2D }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X23]
    LD2R { V5.4S, V6.4S }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X23]
    LD2R { V9.8H, V10.8H }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X23]
    LD2R { V31.1D, V0.1D }, [X23]
    ADD  X23, X23, X11
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X23]
    LD2R { V23.1D, V24.1D }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X23]
    LD2R { V4.2S, V5.2S }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    LD2R { V16.4H, V17.4H }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X23]
    LD2R { V13.8B, V14.8B }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X23]
    MOV  X7, X23
    LD2R { V24.2D, V25.2D }, [X7], #16
    ADD  X23, X23, X11, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    MOV  X7, X23
    LD2R { V22.1D, V23.1D }, [X7], #16
    ADD  X23, X23, X11
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X23]
    MOV  X7, X23
    LD2R { V10.2D, V11.2D }, [X7], #16
    ADD  X23, X23, X11
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X23]
    MOV  X7, X23
    LD2R { V14.16B, V15.16B }, [X7], #2
    ADD  X23, X23, X11, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X23]
    MOV  X7, X23
    LD2R { V28.16B, V29.16B }, [X7], #2
    ADD  X23, X23, X11
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X23]
    MOV  X7, X23
    LD2R { V22.8B, V23.8B }, [X7], #2
    ADD  X23, X23, X11
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X23]
    MOV  X7, X23
    LD2R { V28.4H, V29.4H }, [X7], #4
    ADD  X23, X23, X11, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X23]
    MOV  X7, X23
    LD2R { V17.8H, V18.8H }, [X7], #4
    ADD  X23, X23, X11, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X23]
    MOV  X7, X23
    LD2R { V3.2S, V4.2S }, [X7], #8
    ADD  X23, X23, X11, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X23]
    MOV  X7, X23
    LD2R { V5.2S, V6.2S }, [X7], #8
    ADD  X23, X23, X11, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X23]
    MOV  X7, X23
    LD2R { V3.4S, V4.4S }, [X7], #8
    ADD  X23, X23, X11, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X23]
    MOV  X7, X23
    LD2R { V11.4H, V12.4H }, [X7], #4
    ADD  X23, X23, X11
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X23]
    LD2R { V24.16B, V25.16B }, [X23], X13
    ADD  X23, X23, X11, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    LD2R { V23.16B, V24.16B }, [X23], X13
    ADD  X23, X23, X11, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X23]
    LD2R { V26.2D, V27.2D }, [X23], X13
    ADD  X23, X23, X11, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X23]
    LD2R { V7.4S, V8.4S }, [X23], X13
    ADD  X23, X23, X11
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X23]
    LD2R { V26.8H, V27.8H }, [X23], X13
    ADD  X23, X23, X11
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X23]
    LD2R { V12.1D, V13.1D }, [X23], X13
    ADD  X23, X23, X11, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X23]
    LD2R { V4.1D, V5.1D }, [X23], X13
    ADD  X23, X23, X11, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X23]
    LD2R { V28.2S, V29.2S }, [X23], X13
    ADD  X23, X23, X11, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X23]
    LD2R { V0.4H, V1.4H }, [X23], X13
    ADD  X23, X23, X11, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X23]
    LD2R { V22.8B, V23.8B }, [X23], X13
    ADD  X23, X23, X11, ASR #0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X18, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D1
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D2
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D3
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D4
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D5
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D6
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D9
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D10
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D11
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D14
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D15
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D17
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D18
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D19
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D20
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D21
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D22
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D23
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D24
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D26
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D27
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D28
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D29
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D30
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X18, D31
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X9
    FMOV  V0.D[1], X29
    FMOV  D1, X22
    FMOV  V1.D[1], X16
    FMOV  D2, X19
    FMOV  V2.D[1], X21
    FMOV  D3, X23
    FMOV  V3.D[1], X20
    FMOV  D4, X7
    FMOV  V4.D[1], X13
    FMOV  D5, X11
    FMOV  V5.D[1], X23
    FMOV  D6, X23
    FMOV  V6.D[1], X20
    FMOV  D7, X20
    FMOV  V7.D[1], X15
    FMOV  D8, X13
    FMOV  V8.D[1], X15
    FMOV  D9, X22
    FMOV  V9.D[1], X15
    FMOV  D10, X2
    FMOV  V10.D[1], X16
    FMOV  D11, X9
    FMOV  V11.D[1], X23
    FMOV  D12, X8
    FMOV  V12.D[1], X3
    FMOV  D13, X20
    FMOV  V13.D[1], X20
    FMOV  D14, X7
    FMOV  V14.D[1], X5
    FMOV  D15, X13
    FMOV  V15.D[1], X17
    FMOV  D16, X10
    FMOV  V16.D[1], X17
    FMOV  D17, X20
    FMOV  V17.D[1], X15
    FMOV  D18, X4
    FMOV  V18.D[1], X13
    FMOV  D19, X9
    FMOV  V19.D[1], X12
    FMOV  D20, X16
    FMOV  V20.D[1], X13
    FMOV  D21, X12
    FMOV  V21.D[1], X10
    FMOV  D22, X5
    FMOV  V22.D[1], X5
    FMOV  D23, X8
    FMOV  V23.D[1], X29
    FMOV  D24, X4
    FMOV  V24.D[1], X20
    FMOV  D25, X3
    FMOV  V25.D[1], X9
    FMOV  D26, X3
    FMOV  V26.D[1], X21
    FMOV  D27, X5
    FMOV  V27.D[1], X16
    FMOV  D28, X10
    FMOV  V28.D[1], X12
    FMOV  D29, X4
    FMOV  V29.D[1], X14
    FMOV  D30, X11
    FMOV  V30.D[1], X21
    FMOV  D31, X4
    FMOV  V31.D[1], X9
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X8, #0x1900, LSL #0
    ADD  X16, X30, X8, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X16]
    LD2R { V9.8H, V10.8H }, [X16]
    ADD  X16, X16, X17, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X16]
    LD2R { V4.16B, V5.16B }, [X16]
    ADD  X16, X16, X17, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X16]
    LD2R { V17.2D, V18.2D }, [X16]
    ADD  X16, X16, X17, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X16]
    LD2R { V6.4S, V7.4S }, [X16]
    ADD  X16, X16, X17
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X16]
    LD2R { V25.8H, V26.8H }, [X16]
    ADD  X16, X16, X17, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X16]
    LD2R { V28.4H, V29.4H }, [X16]
    ADD  X16, X16, X17, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X16]
    LD2R { V3.1D, V4.1D }, [X16]
    ADD  X16, X16, X17, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X16]
    LD2R { V28.2S, V29.2S }, [X16]
    ADD  X16, X16, X17
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X16]
    LD2R { V22.4H, V23.4H }, [X16]
    ADD  X16, X16, X17, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X16]
    LD2R { V20.8B, V21.8B }, [X16]
    ADD  X16, X16, X17, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X16]
    MOV  X19, X16
    LD2R { V14.2D, V15.2D }, [X19], #16
    ADD  X16, X16, X17, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X16]
    MOV  X19, X16
    LD2R { V12.1D, V13.1D }, [X19], #16
    ADD  X16, X16, X17
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X16]
    MOV  X19, X16
    LD2R { V12.2D, V13.2D }, [X19], #16
    ADD  X16, X16, X17, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X16]
    MOV  X19, X16
    LD2R { V10.16B, V11.16B }, [X19], #2
    ADD  X16, X16, X17
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X16]
    MOV  X19, X16
    LD2R { V5.16B, V6.16B }, [X19], #2
    ADD  X16, X16, X17, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X16]
    MOV  X19, X16
    LD2R { V15.8B, V16.8B }, [X19], #2
    ADD  X16, X16, X17
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X16]
    MOV  X19, X16
    LD2R { V12.4H, V13.4H }, [X19], #4
    ADD  X16, X16, X17
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X16]
    MOV  X19, X16
    LD2R { V4.8H, V5.8H }, [X19], #4
    ADD  X16, X16, X17, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X16]
    MOV  X19, X16
    LD2R { V26.4S, V27.4S }, [X19], #8
    ADD  X16, X16, X17, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X16]
    MOV  X19, X16
    LD2R { V24.2S, V25.2S }, [X19], #8
    ADD  X16, X16, X17, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X16]
    MOV  X19, X16
    LD2R { V7.4S, V8.4S }, [X19], #8
    ADD  X16, X16, X17
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X16]
    MOV  X19, X16
    LD2R { V3.8H, V4.8H }, [X19], #4
    ADD  X16, X16, X17
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X16]
    LD2R { V29.2D, V30.2D }, [X16], X14
    ADD  X16, X16, X17, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X16]
    LD2R { V14.16B, V15.16B }, [X16], X14
    ADD  X16, X16, X17, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X16]
    LD2R { V9.2D, V10.2D }, [X16], X14
    ADD  X16, X16, X17
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X16]
    LD2R { V12.4S, V13.4S }, [X16], X14
    ADD  X16, X16, X17
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X16]
    LD2R { V13.8H, V14.8H }, [X16], X14
    ADD  X16, X16, X17
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X16]
    LD2R { V13.1D, V14.1D }, [X16], X14
    ADD  X16, X16, X17, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X16]
    LD2R { V16.1D, V17.1D }, [X16], X14
    ADD  X16, X16, X17, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X16]
    LD2R { V24.2S, V25.2S }, [X16], X14
    ADD  X16, X16, X17, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X16]
    LD2R { V6.4H, V7.4H }, [X16], X14
    ADD  X16, X16, X17
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X16]
    LD2R { V12.8B, V13.8B }, [X16], X14
    ADD  X16, X16, X17, ASR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X4, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D1
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D2
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D3
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D4
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D5
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D6
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D7
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D8
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D9
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D10
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D11
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D12
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D13
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D14
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D15
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D16
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D17
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D18
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D19
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D20
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D21
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D22
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D23
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D24
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D25
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D26
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D27
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D28
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D29
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D30
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X4, D31
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X16
    FMOV  D1, X20
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X3
    FMOV  D3, X4
    FMOV  V3.D[1], X5
    FMOV  D4, X22
    FMOV  V4.D[1], X7
    FMOV  D5, X9
    FMOV  V5.D[1], X12
    FMOV  D6, X4
    FMOV  V6.D[1], X18
    FMOV  D7, X17
    FMOV  V7.D[1], X5
    FMOV  D8, X21
    FMOV  V8.D[1], X29
    FMOV  D9, X19
    FMOV  V9.D[1], X21
    FMOV  D10, X4
    FMOV  V10.D[1], X6
    FMOV  D11, X20
    FMOV  V11.D[1], X13
    FMOV  D12, X7
    FMOV  V12.D[1], X15
    FMOV  D13, X23
    FMOV  V13.D[1], X23
    FMOV  D14, X15
    FMOV  V14.D[1], X11
    FMOV  D15, X14
    FMOV  V15.D[1], X14
    FMOV  D16, X10
    FMOV  V16.D[1], X17
    FMOV  D17, X23
    FMOV  V17.D[1], X7
    FMOV  D18, X8
    FMOV  V18.D[1], X10
    FMOV  D19, X2
    FMOV  V19.D[1], X22
    FMOV  D20, X13
    FMOV  V20.D[1], X4
    FMOV  D21, X18
    FMOV  V21.D[1], X22
    FMOV  D22, X8
    FMOV  V22.D[1], X23
    FMOV  D23, X8
    FMOV  V23.D[1], X29
    FMOV  D24, X19
    FMOV  V24.D[1], X29
    FMOV  D25, X12
    FMOV  V25.D[1], X8
    FMOV  D26, X23
    FMOV  V26.D[1], X2
    FMOV  D27, X15
    FMOV  V27.D[1], X6
    FMOV  D28, X10
    FMOV  V28.D[1], X19
    FMOV  D29, X7
    FMOV  V29.D[1], X23
    FMOV  D30, X20
    FMOV  V30.D[1], X2
    FMOV  D31, X8
    FMOV  V31.D[1], X2
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X6, #0x1e00, LSL #0
    ADD  X2, X30, X6
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X2]
    LD2R { V4.8H, V5.8H }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X2]
    LD2R { V29.16B, V30.16B }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X2]
    LD2R { V22.2D, V23.2D }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X2]
    LD2R { V13.4S, V14.4S }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X2]
    LD2R { V23.8H, V24.8H }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X2]
    LD2R { V22.2S, V23.2S }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X2]
    LD2R { V17.1D, V18.1D }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X2]
    LD2R { V11.2S, V12.2S }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X2]
    LD2R { V17.4H, V18.4H }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X2]
    LD2R { V14.8B, V15.8B }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X2]
    MOV  X4, X2
    LD2R { V30.1D, V31.1D }, [X4], #16
    ADD  X2, X2, X13, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X2]
    MOV  X4, X2
    LD2R { V26.1D, V27.1D }, [X4], #16
    ADD  X2, X2, X13, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X2]
    MOV  X4, X2
    LD2R { V2.2D, V3.2D }, [X4], #16
    ADD  X2, X2, X13, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X2]
    MOV  X4, X2
    LD2R { V14.16B, V15.16B }, [X4], #2
    ADD  X2, X2, X13, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X2]
    MOV  X4, X2
    LD2R { V24.16B, V25.16B }, [X4], #2
    ADD  X2, X2, X13, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X2]
    MOV  X4, X2
    LD2R { V20.8B, V21.8B }, [X4], #2
    ADD  X2, X2, X13
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X2]
    MOV  X4, X2
    LD2R { V16.4H, V17.4H }, [X4], #4
    ADD  X2, X2, X13, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X2]
    MOV  X4, X2
    LD2R { V29.8H, V30.8H }, [X4], #4
    ADD  X2, X2, X13, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X2]
    MOV  X4, X2
    LD2R { V8.2S, V9.2S }, [X4], #8
    ADD  X2, X2, X13
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X2]
    MOV  X4, X2
    LD2R { V16.2S, V17.2S }, [X4], #8
    ADD  X2, X2, X13
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X2]
    MOV  X4, X2
    LD2R { V27.4S, V28.4S }, [X4], #8
    ADD  X2, X2, X13
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X2]
    MOV  X4, X2
    LD2R { V22.8H, V23.8H }, [X4], #4
    ADD  X2, X2, X13, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X2]
    LD2R { V12.4S, V13.4S }, [X2], X17
    ADD  X2, X2, X13, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X2]
    LD2R { V26.16B, V27.16B }, [X2], X17
    ADD  X2, X2, X13
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X2]
    LD2R { V14.2D, V15.2D }, [X2], X17
    ADD  X2, X2, X13, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X2]
    LD2R { V28.4S, V29.4S }, [X2], X17
    ADD  X2, X2, X13
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X2]
    LD2R { V4.8H, V5.8H }, [X2], X17
    ADD  X2, X2, X13, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X2]
    LD2R { V13.8B, V14.8B }, [X2], X17
    ADD  X2, X2, X13, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X2]
    LD2R { V26.1D, V27.1D }, [X2], X17
    ADD  X2, X2, X13, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X2]
    LD2R { V8.2S, V9.2S }, [X2], X17
    ADD  X2, X2, X13, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X2]
    LD2R { V13.4H, V14.4H }, [X2], X17
    ADD  X2, X2, X13, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X2]
    LD2R { V24.8B, V25.8B }, [X2], X17
    ADD  X2, X2, X13
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X22, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X9, FPSR
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D1
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D2
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D3
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D4
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D5
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D6
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D7
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D8
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D9
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D10
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D11
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D12
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D13
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D14
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D15
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D16
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D17
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D18
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D19
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D20
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D21
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D22
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D23
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D24
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D25
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D26
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D27
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D28
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D29
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D30
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X9, D31
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X15, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X18
    FMOV  D1, X22
    FMOV  V1.D[1], X6
    FMOV  D2, X19
    FMOV  V2.D[1], X23
    FMOV  D3, X8
    FMOV  V3.D[1], X20
    FMOV  D4, X20
    FMOV  V4.D[1], X14
    FMOV  D5, X4
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X18
    FMOV  D7, X12
    FMOV  V7.D[1], X7
    FMOV  D8, X16
    FMOV  V8.D[1], X13
    FMOV  D9, X9
    FMOV  V9.D[1], X5
    FMOV  D10, X11
    FMOV  V10.D[1], X18
    FMOV  D11, X21
    FMOV  V11.D[1], X23
    FMOV  D12, X10
    FMOV  V12.D[1], X7
    FMOV  D13, X23
    FMOV  V13.D[1], X19
    FMOV  D14, X16
    FMOV  V14.D[1], X21
    FMOV  D15, X22
    FMOV  V15.D[1], X6
    FMOV  D16, X19
    FMOV  V16.D[1], X6
    FMOV  D17, X29
    FMOV  V17.D[1], X8
    FMOV  D18, X4
    FMOV  V18.D[1], X2
    FMOV  D19, X29
    FMOV  V19.D[1], X17
    FMOV  D20, X10
    FMOV  V20.D[1], X14
    FMOV  D21, X9
    FMOV  V21.D[1], X10
    FMOV  D22, X18
    FMOV  V22.D[1], X11
    FMOV  D23, X5
    FMOV  V23.D[1], X6
    FMOV  D24, X15
    FMOV  V24.D[1], X11
    FMOV  D25, X10
    FMOV  V25.D[1], X6
    FMOV  D26, X3
    FMOV  V26.D[1], X13
    FMOV  D27, X21
    FMOV  V27.D[1], X23
    FMOV  D28, X18
    FMOV  V28.D[1], X4
    FMOV  D29, X4
    FMOV  V29.D[1], X19
    FMOV  D30, X7
    FMOV  V30.D[1], X2
    FMOV  D31, X8
    FMOV  V31.D[1], X6
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X11, #0x2300, LSL #0
    ADD  X23, X30, X11, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X23]
    LD2R { V5.2D, V6.2D }, [X23]
    ADD  X23, X23, X19
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X23]
    LD2R { V22.16B, V23.16B }, [X23]
    ADD  X23, X23, X19
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    LD2R { V0.2D, V1.2D }, [X23]
    ADD  X23, X23, X19
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X23]
    LD2R { V22.4S, V23.4S }, [X23]
    ADD  X23, X23, X19, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X23]
    LD2R { V1.8H, V2.8H }, [X23]
    ADD  X23, X23, X19, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X23]
    LD2R { V1.1D, V2.1D }, [X23]
    ADD  X23, X23, X19, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X23]
    LD2R { V27.1D, V28.1D }, [X23]
    ADD  X23, X23, X19, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X23]
    LD2R { V25.2S, V26.2S }, [X23]
    ADD  X23, X23, X19, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X23]
    LD2R { V17.4H, V18.4H }, [X23]
    ADD  X23, X23, X19
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23]
    LD2R { V30.8B, V31.8B }, [X23]
    ADD  X23, X23, X19, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X23]
    MOV  X18, X23
    LD2R { V10.1D, V11.1D }, [X18], #16
    ADD  X23, X23, X19
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X23]
    MOV  X18, X23
    LD2R { V24.1D, V25.1D }, [X18], #16
    ADD  X23, X23, X19, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X23]
    MOV  X18, X23
    LD2R { V4.2D, V5.2D }, [X18], #16
    ADD  X23, X23, X19, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X23]
    MOV  X18, X23
    LD2R { V29.8B, V30.8B }, [X18], #2
    ADD  X23, X23, X19, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X23]
    MOV  X18, X23
    LD2R { V25.16B, V26.16B }, [X18], #2
    ADD  X23, X23, X19, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X23]
    MOV  X18, X23
    LD2R { V0.8B, V1.8B }, [X18], #2
    ADD  X23, X23, X19, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X23]
    MOV  X18, X23
    LD2R { V3.4H, V4.4H }, [X18], #4
    ADD  X23, X23, X19
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X23]
    MOV  X18, X23
    LD2R { V28.8H, V29.8H }, [X18], #4
    ADD  X23, X23, X19, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X23]
    MOV  X18, X23
    LD2R { V19.4S, V20.4S }, [X18], #8
    ADD  X23, X23, X19, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X23]
    MOV  X18, X23
    LD2R { V0.2S, V1.2S }, [X18], #8
    ADD  X23, X23, X19, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X23]
    MOV  X18, X23
    LD2R { V17.4S, V18.4S }, [X18], #8
    ADD  X23, X23, X19
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X23]
    MOV  X18, X23
    LD2R { V19.4H, V20.4H }, [X18], #4
    ADD  X23, X23, X19, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X23]
    LD2R { V27.4S, V28.4S }, [X23], X10
    ADD  X23, X23, X19
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X23]
    LD2R { V25.16B, V26.16B }, [X23], X10
    ADD  X23, X23, X19, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X23]
    LD2R { V30.2D, V31.2D }, [X23], X10
    ADD  X23, X23, X19, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X23]
    LD2R { V17.4S, V18.4S }, [X23], X10
    ADD  X23, X23, X19, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X23]
    LD2R { V26.8H, V27.8H }, [X23], X10
    ADD  X23, X23, X19, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X23]
    LD2R { V31.1D, V0.1D }, [X23], X10
    ADD  X23, X23, X19
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X23]
    LD2R { V28.1D, V29.1D }, [X23], X10
    ADD  X23, X23, X19, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X23]
    LD2R { V23.2S, V24.2S }, [X23], X10
    ADD  X23, X23, X19, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X23]
    LD2R { V6.4H, V7.4H }, [X23], X10
    ADD  X23, X23, X19, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X23]
    LD2R { V30.8B, V31.8B }, [X23], X10
    ADD  X23, X23, X19, LSR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X8, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D6
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X8, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X8
    FMOV  D1, X21
    FMOV  V1.D[1], X7
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X5
    FMOV  V3.D[1], X19
    FMOV  D4, X10
    FMOV  V4.D[1], X3
    FMOV  D5, X22
    FMOV  V5.D[1], X4
    FMOV  D6, X10
    FMOV  V6.D[1], X8
    FMOV  D7, X14
    FMOV  V7.D[1], X8
    FMOV  D8, X6
    FMOV  V8.D[1], X4
    FMOV  D9, X5
    FMOV  V9.D[1], X6
    FMOV  D10, X29
    FMOV  V10.D[1], X10
    FMOV  D11, X10
    FMOV  V11.D[1], X3
    FMOV  D12, X5
    FMOV  V12.D[1], X12
    FMOV  D13, X10
    FMOV  V13.D[1], X16
    FMOV  D14, X20
    FMOV  V14.D[1], X4
    FMOV  D15, X9
    FMOV  V15.D[1], X6
    FMOV  D16, X20
    FMOV  V16.D[1], X13
    FMOV  D17, X9
    FMOV  V17.D[1], X23
    FMOV  D18, X23
    FMOV  V18.D[1], X8
    FMOV  D19, X3
    FMOV  V19.D[1], X10
    FMOV  D20, X10
    FMOV  V20.D[1], X3
    FMOV  D21, X18
    FMOV  V21.D[1], X15
    FMOV  D22, X23
    FMOV  V22.D[1], X19
    FMOV  D23, X4
    FMOV  V23.D[1], X9
    FMOV  D24, X6
    FMOV  V24.D[1], X12
    FMOV  D25, X17
    FMOV  V25.D[1], X19
    FMOV  D26, X18
    FMOV  V26.D[1], X10
    FMOV  D27, X19
    FMOV  V27.D[1], X2
    FMOV  D28, X5
    FMOV  V28.D[1], X9
    FMOV  D29, X10
    FMOV  V29.D[1], X22
    FMOV  D30, X22
    FMOV  V30.D[1], X4
    FMOV  D31, X12
    FMOV  V31.D[1], X20
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X19, #0x2800, LSL #0
    ADD  X22, X30, X19, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X22]
    LD2R { V13.2D, V14.2D }, [X22]
    ADD  X22, X22, X6, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X22]
    LD2R { V0.16B, V1.16B }, [X22]
    ADD  X22, X22, X6, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X22]
    LD2R { V5.2D, V6.2D }, [X22]
    ADD  X22, X22, X6
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X22]
    LD2R { V4.4S, V5.4S }, [X22]
    ADD  X22, X22, X6
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X22]
    LD2R { V28.8H, V29.8H }, [X22]
    ADD  X22, X22, X6
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X22]
    LD2R { V24.2S, V25.2S }, [X22]
    ADD  X22, X22, X6
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X22]
    LD2R { V12.1D, V13.1D }, [X22]
    ADD  X22, X22, X6
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X22]
    LD2R { V18.2S, V19.2S }, [X22]
    ADD  X22, X22, X6, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X22]
    LD2R { V10.4H, V11.4H }, [X22]
    ADD  X22, X22, X6, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X22]
    LD2R { V4.8B, V5.8B }, [X22]
    ADD  X22, X22, X6, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X22]
    MOV  X13, X22
    LD2R { V22.1D, V23.1D }, [X13], #16
    ADD  X22, X22, X6, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X22]
    MOV  X13, X22
    LD2R { V7.1D, V8.1D }, [X13], #16
    ADD  X22, X22, X6
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X22]
    MOV  X13, X22
    LD2R { V29.2D, V30.2D }, [X13], #16
    ADD  X22, X22, X6
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X22]
    MOV  X13, X22
    LD2R { V31.8B, V0.8B }, [X13], #2
    ADD  X22, X22, X6, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X22]
    MOV  X13, X22
    LD2R { V23.16B, V24.16B }, [X13], #2
    ADD  X22, X22, X6, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X22]
    MOV  X13, X22
    LD2R { V9.8B, V10.8B }, [X13], #2
    ADD  X22, X22, X6
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X22]
    MOV  X13, X22
    LD2R { V0.4H, V1.4H }, [X13], #4
    ADD  X22, X22, X6, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X22]
    MOV  X13, X22
    LD2R { V21.8H, V22.8H }, [X13], #4
    ADD  X22, X22, X6, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22]
    MOV  X13, X22
    LD2R { V30.4S, V31.4S }, [X13], #8
    ADD  X22, X22, X6, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X22]
    MOV  X13, X22
    LD2R { V11.2S, V12.2S }, [X13], #8
    ADD  X22, X22, X6, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X22]
    MOV  X13, X22
    LD2R { V31.4S, V0.4S }, [X13], #8
    ADD  X22, X22, X6, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X22]
    MOV  X13, X22
    LD2R { V12.4H, V13.4H }, [X13], #4
    ADD  X22, X22, X6, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X22]
    LD2R { V11.4S, V12.4S }, [X22], X7
    ADD  X22, X22, X6, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22]
    LD2R { V9.16B, V10.16B }, [X22], X7
    ADD  X22, X22, X6
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X22]
    LD2R { V26.2D, V27.2D }, [X22], X7
    ADD  X22, X22, X6, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X22]
    LD2R { V19.4S, V20.4S }, [X22], X7
    ADD  X22, X22, X6
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X22]
    LD2R { V13.8H, V14.8H }, [X22], X7
    ADD  X22, X22, X6, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X22]
    LD2R { V29.2S, V30.2S }, [X22], X7
    ADD  X22, X22, X6, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22]
    LD2R { V24.1D, V25.1D }, [X22], X7
    ADD  X22, X22, X6
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22]
    LD2R { V1.2S, V2.2S }, [X22], X7
    ADD  X22, X22, X6
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X22]
    LD2R { V8.4H, V9.4H }, [X22], X7
    ADD  X22, X22, X6
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X22]
    LD2R { V26.8B, V27.8B }, [X22], X7
    ADD  X22, X22, X6, ASR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X23, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D1
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D2
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D3
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D4
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D5
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D6
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D7
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D8
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D9
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D10
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D11
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D12
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D13
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D14
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D15
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D16
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D17
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D18
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D19
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D20
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D21
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D22
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D23
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D24
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D25
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D26
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D27
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D28
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D29
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D30
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X23, D31
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X20
    FMOV  V1.D[1], X21
    FMOV  D2, X22
    FMOV  V2.D[1], X6
    FMOV  D3, X14
    FMOV  V3.D[1], X16
    FMOV  D4, X17
    FMOV  V4.D[1], X19
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X10
    FMOV  V6.D[1], X7
    FMOV  D7, X5
    FMOV  V7.D[1], X3
    FMOV  D8, X10
    FMOV  V8.D[1], X12
    FMOV  D9, X6
    FMOV  V9.D[1], X10
    FMOV  D10, X5
    FMOV  V10.D[1], X2
    FMOV  D11, X13
    FMOV  V11.D[1], X12
    FMOV  D12, X7
    FMOV  V12.D[1], X23
    FMOV  D13, X7
    FMOV  V13.D[1], X29
    FMOV  D14, X2
    FMOV  V14.D[1], X13
    FMOV  D15, X19
    FMOV  V15.D[1], X9
    FMOV  D16, X14
    FMOV  V16.D[1], X23
    FMOV  D17, X23
    FMOV  V17.D[1], X9
    FMOV  D18, X20
    FMOV  V18.D[1], X14
    FMOV  D19, X23
    FMOV  V19.D[1], X8
    FMOV  D20, X4
    FMOV  V20.D[1], X4
    FMOV  D21, X10
    FMOV  V21.D[1], X11
    FMOV  D22, X12
    FMOV  V22.D[1], X9
    FMOV  D23, X10
    FMOV  V23.D[1], X13
    FMOV  D24, X17
    FMOV  V24.D[1], X2
    FMOV  D25, X5
    FMOV  V25.D[1], X6
    FMOV  D26, X9
    FMOV  V26.D[1], X3
    FMOV  D27, X7
    FMOV  V27.D[1], X22
    FMOV  D28, X7
    FMOV  V28.D[1], X6
    FMOV  D29, X9
    FMOV  V29.D[1], X23
    FMOV  D30, X6
    FMOV  V30.D[1], X12
    FMOV  D31, X9
    FMOV  V31.D[1], X5
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X14, #0x2d00, LSL #0
    ADD  X9, X30, X14
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X9]
    LD2R { V30.16B, V31.16B }, [X9]
    ADD  X9, X9, X23, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X9]
    LD2R { V6.16B, V7.16B }, [X9]
    ADD  X9, X9, X23, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X9]
    LD2R { V23.2D, V24.2D }, [X9]
    ADD  X9, X9, X23, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X9]
    LD2R { V8.4S, V9.4S }, [X9]
    ADD  X9, X9, X23, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X9]
    LD2R { V21.8H, V22.8H }, [X9]
    ADD  X9, X9, X23
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X9]
    LD2R { V15.4H, V16.4H }, [X9]
    ADD  X9, X9, X23, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X9]
    LD2R { V6.1D, V7.1D }, [X9]
    ADD  X9, X9, X23, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X9]
    LD2R { V13.2S, V14.2S }, [X9]
    ADD  X9, X9, X23, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X9]
    LD2R { V11.4H, V12.4H }, [X9]
    ADD  X9, X9, X23
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X9]
    LD2R { V15.8B, V16.8B }, [X9]
    ADD  X9, X9, X23, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X9]
    MOV  X18, X9
    LD2R { V13.2D, V14.2D }, [X18], #16
    ADD  X9, X9, X23, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X9]
    MOV  X18, X9
    LD2R { V6.1D, V7.1D }, [X18], #16
    ADD  X9, X9, X23
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X9]
    MOV  X18, X9
    LD2R { V29.2D, V30.2D }, [X18], #16
    ADD  X9, X9, X23, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X9]
    MOV  X18, X9
    LD2R { V21.16B, V22.16B }, [X18], #2
    ADD  X9, X9, X23, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X9]
    MOV  X18, X9
    LD2R { V23.16B, V24.16B }, [X18], #2
    ADD  X9, X9, X23, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X9]
    MOV  X18, X9
    LD2R { V17.8B, V18.8B }, [X18], #2
    ADD  X9, X9, X23, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X9]
    MOV  X18, X9
    LD2R { V15.4H, V16.4H }, [X18], #4
    ADD  X9, X9, X23, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X9]
    MOV  X18, X9
    LD2R { V15.8H, V16.8H }, [X18], #4
    ADD  X9, X9, X23, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9]
    MOV  X18, X9
    LD2R { V19.2S, V20.2S }, [X18], #8
    ADD  X9, X9, X23
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X9]
    MOV  X18, X9
    LD2R { V25.2S, V26.2S }, [X18], #8
    ADD  X9, X9, X23
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X9]
    MOV  X18, X9
    LD2R { V1.4S, V2.4S }, [X18], #8
    ADD  X9, X9, X23, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X9]
    MOV  X18, X9
    LD2R { V8.8H, V9.8H }, [X18], #4
    ADD  X9, X9, X23, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X9]
    LD2R { V25.8H, V26.8H }, [X9], X7
    ADD  X9, X9, X23
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X9]
    LD2R { V17.16B, V18.16B }, [X9], X7
    ADD  X9, X9, X23, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9]
    LD2R { V1.2D, V2.2D }, [X9], X7
    ADD  X9, X9, X23
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X9]
    LD2R { V3.4S, V4.4S }, [X9], X7
    ADD  X9, X9, X23
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X9]
    LD2R { V3.8H, V4.8H }, [X9], X7
    ADD  X9, X9, X23
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X9]
    LD2R { V14.2S, V15.2S }, [X9], X7
    ADD  X9, X9, X23, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X9]
    LD2R { V27.1D, V28.1D }, [X9], X7
    ADD  X9, X9, X23, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X9]
    LD2R { V23.2S, V24.2S }, [X9], X7
    ADD  X9, X9, X23, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X9]
    LD2R { V3.4H, V4.4H }, [X9], X7
    ADD  X9, X9, X23
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X9]
    LD2R { V27.8B, V28.8B }, [X9], X7
    ADD  X9, X9, X23, ASR #0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MRS  X3, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D6
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail
    FMOV  X3, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP02_TestFail

AdvsimdLoadDeprecatedP02_TestEnd:
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
AdvsimdLoadDeprecatedP02_TestFail:
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
