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
    MOVZ  X2, #0x60f0, LSL #0
    MOVK  X2, #0xb5bb, LSL #16
    MOVK  X2, #0x4fd2, LSL #32
    MOVK  X2, #0x6957, LSL #48
    MOVZ  X3, #0xd6bf, LSL #0
    MOVK  X3, #0x1ae8, LSL #16
    MOVK  X3, #0x16b4, LSL #32
    MOVK  X3, #0x254d, LSL #48
    MOVZ  X4, #0xa9fe, LSL #0
    MOVK  X4, #0xe386, LSL #16
    MOVK  X4, #0x5f4, LSL #32
    MOVK  X4, #0xe836, LSL #48
    MOVZ  X5, #0x7398, LSL #0
    MOVK  X5, #0xdc05, LSL #16
    MOVK  X5, #0x8698, LSL #32
    MOVK  X5, #0x86b, LSL #48
    MOVZ  X6, #0x624f, LSL #0
    MOVK  X6, #0xa6e4, LSL #16
    MOVK  X6, #0x81bb, LSL #32
    MOVK  X6, #0xd29b, LSL #48
    MOVZ  X7, #0xd13d, LSL #0
    MOVK  X7, #0xcb27, LSL #16
    MOVK  X7, #0xcd00, LSL #32
    MOVK  X7, #0x9abc, LSL #48
    MOVZ  X8, #0xdb96, LSL #0
    MOVK  X8, #0xfe55, LSL #16
    MOVK  X8, #0xf291, LSL #32
    MOVK  X8, #0xf18f, LSL #48
    MOVZ  X9, #0x5144, LSL #0
    MOVK  X9, #0xbaef, LSL #16
    MOVK  X9, #0xb3f0, LSL #32
    MOVK  X9, #0x2619, LSL #48
    MOVZ  X10, #0xda5e, LSL #0
    MOVK  X10, #0xd8ef, LSL #16
    MOVK  X10, #0x3e81, LSL #32
    MOVK  X10, #0x799b, LSL #48
    MOVZ  X11, #0x887c, LSL #0
    MOVK  X11, #0xf890, LSL #16
    MOVK  X11, #0xc120, LSL #32
    MOVK  X11, #0x3b7, LSL #48
    MOVZ  X12, #0xe2b4, LSL #0
    MOVK  X12, #0xdafc, LSL #16
    MOVK  X12, #0xbb7, LSL #32
    MOVK  X12, #0x3209, LSL #48
    MOVZ  X13, #0x1e60, LSL #0
    MOVK  X13, #0xab99, LSL #16
    MOVK  X13, #0xfb96, LSL #32
    MOVK  X13, #0xa64b, LSL #48
    MOVZ  X14, #0xd7af, LSL #0
    MOVK  X14, #0x5d7c, LSL #16
    MOVK  X14, #0x7852, LSL #32
    MOVK  X14, #0x8e18, LSL #48
    MOVZ  X15, #0xfab5, LSL #0
    MOVK  X15, #0xd288, LSL #16
    MOVK  X15, #0x795b, LSL #32
    MOVK  X15, #0x3ee5, LSL #48
    MOVZ  X16, #0xe3b4, LSL #0
    MOVK  X16, #0x7316, LSL #16
    MOVK  X16, #0xefff, LSL #32
    MOVK  X16, #0xf2b5, LSL #48
    MOVZ  X17, #0x3dcf, LSL #0
    MOVK  X17, #0xebdd, LSL #16
    MOVK  X17, #0x5f3c, LSL #32
    MOVK  X17, #0x18a9, LSL #48
    MOVZ  X23, #0xb6ad, LSL #0
    MOVK  X23, #0x74a7, LSL #16
    MOVK  X23, #0x1d16, LSL #32
    MOVK  X23, #0x4c5e, LSL #48
    MOVZ  X24, #0xd33a, LSL #0
    MOVK  X24, #0x3bf4, LSL #16
    MOVK  X24, #0x76bf, LSL #32
    MOVK  X24, #0x1c94, LSL #48
    MOVZ  X25, #0xed11, LSL #0
    MOVK  X25, #0x88c, LSL #16
    MOVK  X25, #0x3759, LSL #32
    MOVK  X25, #0xe610, LSL #48
    MOVZ  X26, #0x2b, LSL #0
    MOVK  X26, #0x3ad6, LSL #16
    MOVK  X26, #0xc34d, LSL #32
    MOVK  X26, #0xd36b, LSL #48
    MOVZ  X27, #0x34a6, LSL #0
    MOVK  X27, #0xadc5, LSL #16
    MOVK  X27, #0x9c5, LSL #32
    MOVK  X27, #0x2208, LSL #48
    MOVZ  X28, #0x880e, LSL #0
    MOVK  X28, #0xf53e, LSL #16
    MOVK  X28, #0x5272, LSL #32
    MOVK  X28, #0xc329, LSL #48
    MOVZ  X29, #0xfafb, LSL #0
    MOVK  X29, #0xdafe, LSL #16
    MOVK  X29, #0xd72e, LSL #32
    MOVK  X29, #0x7992, LSL #48
    MOVZ  X2, #0x94ae, LSL #0
    MOVK  X2, #0xafd6, LSL #16
    MOVK  X2, #0xf326, LSL #32
    MOVK  X2, #0xf0cf, LSL #48
    MSR  FPCR, X2
    MRS  X2, FPCR
    MOVZ  X3, #0x60ff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X2, X2, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X2, X2, X3
    MSR  FPCR, X2
    ISB  SY
    MOVZ  X2, #0xf499, LSL #0
    MOVK  X2, #0xf730, LSL #16
    MOVK  X2, #0x1f85, LSL #32
    MOVK  X2, #0x3ed4, LSL #48
    MSR  FPSR, X2
    MRS  X10, FPSR
    MOVZ  X17, #0xff60, LSL #0
    MOVK  X17, #0x7ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X10, X10, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X10, X10, X17
    MSR  FPSR, X10
    ISB  SY
    SUBS  X14, X24, W10, UXTW #2
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
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X10
    FMOV  D3, X4
    FMOV  V3.D[1], X4
    FMOV  D4, X16
    FMOV  V4.D[1], X9
    FMOV  D5, X29
    FMOV  V5.D[1], X28
    FMOV  D6, X28
    FMOV  V6.D[1], X12
    FMOV  D7, X3
    FMOV  V7.D[1], X15
    FMOV  D8, X28
    FMOV  V8.D[1], X25
    FMOV  D9, X23
    FMOV  V9.D[1], X14
    FMOV  D10, X15
    FMOV  V10.D[1], X14
    FMOV  D11, X7
    FMOV  V11.D[1], X7
    FMOV  D12, X17
    FMOV  V12.D[1], X4
    FMOV  D13, X28
    FMOV  V13.D[1], X12
    FMOV  D14, X3
    FMOV  V14.D[1], X15
    FMOV  D15, X3
    FMOV  V15.D[1], X13
    FMOV  D16, X13
    FMOV  V16.D[1], X3
    FMOV  D17, X16
    FMOV  V17.D[1], X5
    FMOV  D18, X11
    FMOV  V18.D[1], X10
    FMOV  D19, X4
    FMOV  V19.D[1], X23
    FMOV  D20, X14
    FMOV  V20.D[1], X11
    FMOV  D21, X7
    FMOV  V21.D[1], X16
    FMOV  D22, X26
    FMOV  V22.D[1], X26
    FMOV  D23, X5
    FMOV  V23.D[1], X3
    FMOV  D24, X15
    FMOV  V24.D[1], X24
    FMOV  D25, X2
    FMOV  V25.D[1], X5
    FMOV  D26, X4
    FMOV  V26.D[1], X7
    FMOV  D27, X4
    FMOV  V27.D[1], X12
    FMOV  D28, X17
    FMOV  V28.D[1], X15
    FMOV  D29, X9
    FMOV  V29.D[1], X25
    FMOV  D30, X26
    FMOV  V30.D[1], X16
    FMOV  D31, X23
    FMOV  V31.D[1], X10
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X5, #0x0, LSL #0
    ADD  X3, X30, X5, LSR #0
    ST3 { V23.16B, V24.16B, V25.16B }, [X3]
    LD3 { V3.16B, V4.16B, V5.16B }, [X3]
    ADD  X3, X3, X4, LSR #0
    ST3 { V24.16B, V25.16B, V26.16B }, [X3]
    LD3 { V20.16B, V21.16B, V22.16B }, [X3]
    ADD  X3, X3, X4, ASR #0
    ST3 { V28.2D, V29.2D, V30.2D }, [X3]
    LD3 { V13.2D, V14.2D, V15.2D }, [X3]
    ADD  X3, X3, X4
    ST3 { V11.4S, V12.4S, V13.4S }, [X3]
    LD3 { V23.4S, V24.4S, V25.4S }, [X3]
    ADD  X3, X3, X4
    ST3 { V23.8H, V24.8H, V25.8H }, [X3]
    LD3 { V12.8H, V13.8H, V14.8H }, [X3]
    ADD  X3, X3, X4, LSR #0
    ST3 { V31.4H, V0.4H, V1.4H }, [X3]
    LD3 { V15.4H, V16.4H, V17.4H }, [X3]
    ADD  X3, X3, X4, LSR #0
    ST3 { V13.2S, V14.2S, V15.2S }, [X3]
    LD3 { V8.2S, V9.2S, V10.2S }, [X3]
    ADD  X3, X3, X4
    ST3 { V10.4H, V11.4H, V12.4H }, [X3]
    LD3 { V28.4H, V29.4H, V30.4H }, [X3]
    ADD  X3, X3, X4
    ST3 { V28.8B, V29.8B, V30.8B }, [X3]
    LD3 { V10.8B, V11.8B, V12.8B }, [X3]
    ADD  X3, X3, X4
    MOV  X12, X3
    ST3 { V10.16B, V11.16B, V12.16B }, [X12], #48
    MOV  X12, X3
    LD3 { V10.4S, V11.4S, V12.4S }, [X12], #48
    ADD  X3, X3, X4
    MOV  X12, X3
    ST3 { V3.16B, V4.16B, V5.16B }, [X12], #48
    MOV  X12, X3
    LD3 { V9.16B, V10.16B, V11.16B }, [X12], #48
    ADD  X3, X3, X4
    MOV  X12, X3
    ST3 { V8.2D, V9.2D, V10.2D }, [X12], #48
    MOV  X12, X3
    LD3 { V6.2D, V7.2D, V8.2D }, [X12], #48
    ADD  X3, X3, X4, LSR #0
    MOV  X12, X3
    ST3 { V22.4S, V23.4S, V24.4S }, [X12], #48
    MOV  X12, X3
    LD3 { V22.4S, V23.4S, V24.4S }, [X12], #48
    ADD  X3, X3, X4, ASR #0
    MOV  X12, X3
    ST3 { V10.8H, V11.8H, V12.8H }, [X12], #48
    MOV  X12, X3
    LD3 { V28.8H, V29.8H, V30.8H }, [X12], #48
    ADD  X3, X3, X4, ASR #0
    MOV  X12, X3
    ST3 { V22.8B, V23.8B, V24.8B }, [X12], #24
    MOV  X12, X3
    LD3 { V4.4H, V5.4H, V6.4H }, [X12], #24
    ADD  X3, X3, X4
    MOV  X12, X3
    ST3 { V4.2S, V5.2S, V6.2S }, [X12], #24
    MOV  X12, X3
    LD3 { V10.2S, V11.2S, V12.2S }, [X12], #24
    ADD  X3, X3, X4, LSR #0
    MOV  X12, X3
    ST3 { V22.4H, V23.4H, V24.4H }, [X12], #24
    MOV  X12, X3
    LD3 { V22.4H, V23.4H, V24.4H }, [X12], #24
    ADD  X3, X3, X4, ASR #0
    MOV  X12, X3
    ST3 { V28.8B, V29.8B, V30.8B }, [X12], #24
    MOV  X12, X3
    LD3 { V21.8B, V22.8B, V23.8B }, [X12], #24
    ADD  X3, X3, X4, ASR #0
    ST3 { V8.8H, V9.8H, V10.8H }, [X3], X23
    LD3 { V29.2D, V30.2D, V31.2D }, [X3], X23
    ADD  X3, X3, X4, ASR #0
    ST3 { V21.16B, V22.16B, V23.16B }, [X3], X23
    LD3 { V9.16B, V10.16B, V11.16B }, [X3], X23
    ADD  X3, X3, X4, ASR #0
    ST3 { V9.2D, V10.2D, V11.2D }, [X3], X23
    LD3 { V8.2D, V9.2D, V10.2D }, [X3], X23
    ADD  X3, X3, X4, ASR #0
    ST3 { V25.4S, V26.4S, V27.4S }, [X3], X23
    LD3 { V25.4S, V26.4S, V27.4S }, [X3], X23
    ADD  X3, X3, X4, LSR #0
    ST3 { V24.8H, V25.8H, V26.8H }, [X3], X23
    LD3 { V24.8H, V25.8H, V26.8H }, [X3], X23
    ADD  X3, X3, X4, ASR #0
    ST3 { V24.8B, V25.8B, V26.8B }, [X3], X23
    LD3 { V22.4H, V23.4H, V24.4H }, [X3], X23
    ADD  X3, X3, X4, LSR #0
    ST3 { V25.2S, V26.2S, V27.2S }, [X3], X23
    LD3 { V26.2S, V27.2S, V28.2S }, [X3], X23
    ADD  X3, X3, X4
    ST3 { V28.4H, V29.4H, V30.4H }, [X3], X23
    LD3 { V28.4H, V29.4H, V30.4H }, [X3], X23
    ADD  X3, X3, X4, ASR #0
    ST3 { V27.8B, V28.8B, V29.8B }, [X3], X23
    LD3 { V17.8B, V18.8B, V19.8B }, [X3], X23
    ADD  X3, X3, X4, ASR #0
    ST3 { V19.H, V20.H, V21.H }[0x0], [X3]
    LD3 { V19.H, V20.H, V21.H }[0x4], [X3]
    ADD  X3, X3, X4, ASR #0
    ST3 { V8.S, V9.S, V10.S }[0x1], [X3]
    LD3 { V0.S, V1.S, V2.S }[0x1], [X3]
    ADD  X3, X3, X4, LSR #0
    ST3 { V28.D, V29.D, V30.D }[0x1], [X3]
    LD3 { V27.D, V28.D, V29.D }[0x1], [X3]
    ADD  X3, X3, X4
    ST3 { V27.B, V28.B, V29.B }[0x4], [X3]
    LD3 { V0.B, V1.B, V2.B }[0x9], [X3]
    ADD  X3, X3, X4
    MOV  X12, X3
    ST3 { V0.H, V1.H, V2.H }[0x1], [X12], #6
    MOV  X12, X3
    LD3 { V27.H, V28.H, V29.H }[0x6], [X12], #6
    ADD  X3, X3, X4, ASR #0
    ST3 { V6.H, V7.H, V8.H }[0x4], [X3], X23
    LD3 { V7.H, V8.H, V9.H }[0x3], [X3], X23
    ADD  X3, X3, X4
    MOV  X12, X3
    ST3 { V21.S, V22.S, V23.S }[0x1], [X12], #12
    MOV  X12, X3
    LD3 { V0.S, V1.S, V2.S }[0x0], [X12], #12
    ADD  X3, X3, X4, LSR #0
    ST3 { V18.S, V19.S, V20.S }[0x0], [X3], X23
    LD3 { V5.S, V6.S, V7.S }[0x2], [X3], X23
    ADD  X3, X3, X4, LSR #0
    MOV  X12, X3
    ST3 { V5.D, V6.D, V7.D }[0x1], [X12], #24
    MOV  X12, X3
    LD3 { V30.D, V31.D, V0.D }[0x0], [X12], #24
    ADD  X3, X3, X4, LSR #0
    ST3 { V4.D, V5.D, V6.D }[0x0], [X3], X23
    LD3 { V21.D, V22.D, V23.D }[0x0], [X3], X23
    ADD  X3, X3, X4, LSR #0
    MOV  X12, X3
    ST3 { V4.B, V5.B, V6.B }[0x7], [X12], #3
    MOV  X12, X3
    LD3 { V5.B, V6.B, V7.B }[0x6], [X12], #3
    ADD  X3, X3, X4, ASR #0
    ST3 { V15.B, V16.B, V17.B }[0x1], [X3], X23
    LD3 { V15.B, V16.B, V17.B }[0xc], [X3], X23
    ADD  X3, X3, X4, ASR #0
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
    SUB  X13, X9, X6
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
    SUB  X13, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X16
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
    SUB  X13, X9, X24
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
    SUB  X13, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MRS  X9, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D1
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D2
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D3
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D4
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D5
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D6
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D7
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D8
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D9
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D10
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D11
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D12
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D13
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D14
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D15
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D16
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D17
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D18
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D19
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D20
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D21
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D22
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D23
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D24
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D25
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D26
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x5a5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D27
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x5a5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D28
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x5a5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D29
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D30
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    FMOV  X9, D31
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X27, X13, X9
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
    FMOV  D0, X15
    FMOV  V0.D[1], X27
    FMOV  D1, X8
    FMOV  V1.D[1], X16
    FMOV  D2, X11
    FMOV  V2.D[1], X11
    FMOV  D3, X28
    FMOV  V3.D[1], X3
    FMOV  D4, X29
    FMOV  V4.D[1], X17
    FMOV  D5, X28
    FMOV  V5.D[1], X14
    FMOV  D6, X11
    FMOV  V6.D[1], X28
    FMOV  D7, X3
    FMOV  V7.D[1], X4
    FMOV  D8, X10
    FMOV  V8.D[1], X15
    FMOV  D9, X29
    FMOV  V9.D[1], X29
    FMOV  D10, X5
    FMOV  V10.D[1], X27
    FMOV  D11, X28
    FMOV  V11.D[1], X9
    FMOV  D12, X3
    FMOV  V12.D[1], X15
    FMOV  D13, X16
    FMOV  V13.D[1], X15
    FMOV  D14, X25
    FMOV  V14.D[1], X11
    FMOV  D15, X17
    FMOV  V15.D[1], X12
    FMOV  D16, X2
    FMOV  V16.D[1], X5
    FMOV  D17, X3
    FMOV  V17.D[1], X14
    FMOV  D18, X25
    FMOV  V18.D[1], X23
    FMOV  D19, X13
    FMOV  V19.D[1], X12
    FMOV  D20, X4
    FMOV  V20.D[1], X25
    FMOV  D21, X10
    FMOV  V21.D[1], X28
    FMOV  D22, X8
    FMOV  V22.D[1], X4
    FMOV  D23, X2
    FMOV  V23.D[1], X23
    FMOV  D24, X17
    FMOV  V24.D[1], X15
    FMOV  D25, X27
    FMOV  V25.D[1], X3
    FMOV  D26, X17
    FMOV  V26.D[1], X26
    FMOV  D27, X6
    FMOV  V27.D[1], X13
    FMOV  D28, X11
    FMOV  V28.D[1], X3
    FMOV  D29, X27
    FMOV  V29.D[1], X28
    FMOV  D30, X15
    FMOV  V30.D[1], X16
    FMOV  D31, X27
    FMOV  V31.D[1], X4
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X7, #0x500, LSL #0
    ADD  X27, X30, X7, LSR #0
    ST3 { V17.2D, V18.2D, V19.2D }, [X27]
    LD3 { V29.8H, V30.8H, V31.8H }, [X27]
    ADD  X27, X27, X29
    ST3 { V9.16B, V10.16B, V11.16B }, [X27]
    LD3 { V5.16B, V6.16B, V7.16B }, [X27]
    ADD  X27, X27, X29
    ST3 { V14.2D, V15.2D, V16.2D }, [X27]
    LD3 { V13.2D, V14.2D, V15.2D }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST3 { V31.4S, V0.4S, V1.4S }, [X27]
    LD3 { V4.4S, V5.4S, V6.4S }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST3 { V5.8H, V6.8H, V7.8H }, [X27]
    LD3 { V5.8H, V6.8H, V7.8H }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST3 { V13.2S, V14.2S, V15.2S }, [X27]
    LD3 { V7.8B, V8.8B, V9.8B }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST3 { V6.2S, V7.2S, V8.2S }, [X27]
    LD3 { V17.2S, V18.2S, V19.2S }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST3 { V17.4H, V18.4H, V19.4H }, [X27]
    LD3 { V25.4H, V26.4H, V27.4H }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST3 { V25.8B, V26.8B, V27.8B }, [X27]
    LD3 { V6.8B, V7.8B, V8.8B }, [X27]
    ADD  X27, X27, X29, ASR #0
    MOV  X12, X27
    ST3 { V4.4S, V5.4S, V6.4S }, [X12], #48
    MOV  X12, X27
    LD3 { V25.2D, V26.2D, V27.2D }, [X12], #48
    ADD  X27, X27, X29, ASR #0
    MOV  X12, X27
    ST3 { V12.16B, V13.16B, V14.16B }, [X12], #48
    MOV  X12, X27
    LD3 { V17.16B, V18.16B, V19.16B }, [X12], #48
    ADD  X27, X27, X29, ASR #0
    MOV  X12, X27
    ST3 { V17.2D, V18.2D, V19.2D }, [X12], #48
    MOV  X12, X27
    LD3 { V4.2D, V5.2D, V6.2D }, [X12], #48
    ADD  X27, X27, X29, LSR #0
    MOV  X12, X27
    ST3 { V4.4S, V5.4S, V6.4S }, [X12], #48
    MOV  X12, X27
    LD3 { V4.4S, V5.4S, V6.4S }, [X12], #48
    ADD  X27, X27, X29
    MOV  X12, X27
    ST3 { V4.8H, V5.8H, V6.8H }, [X12], #48
    MOV  X12, X27
    LD3 { V12.8H, V13.8H, V14.8H }, [X12], #48
    ADD  X27, X27, X29
    MOV  X12, X27
    ST3 { V12.8B, V13.8B, V14.8B }, [X12], #24
    MOV  X12, X27
    LD3 { V25.4H, V26.4H, V27.4H }, [X12], #24
    ADD  X27, X27, X29, ASR #0
    MOV  X12, X27
    ST3 { V7.2S, V8.2S, V9.2S }, [X12], #24
    MOV  X12, X27
    LD3 { V8.2S, V9.2S, V10.2S }, [X12], #24
    ADD  X27, X27, X29, LSR #0
    MOV  X12, X27
    ST3 { V8.4H, V9.4H, V10.4H }, [X12], #24
    MOV  X12, X27
    LD3 { V23.4H, V24.4H, V25.4H }, [X12], #24
    ADD  X27, X27, X29, LSR #0
    MOV  X12, X27
    ST3 { V13.8B, V14.8B, V15.8B }, [X12], #24
    MOV  X12, X27
    LD3 { V7.8B, V8.8B, V9.8B }, [X12], #24
    ADD  X27, X27, X29, ASR #0
    ST3 { V25.2D, V26.2D, V27.2D }, [X27], X14
    LD3 { V12.4S, V13.4S, V14.4S }, [X27], X14
    ADD  X27, X27, X29, LSR #0
    ST3 { V7.16B, V8.16B, V9.16B }, [X27], X14
    LD3 { V8.16B, V9.16B, V10.16B }, [X27], X14
    ADD  X27, X27, X29
    ST3 { V6.2D, V7.2D, V8.2D }, [X27], X14
    LD3 { V27.2D, V28.2D, V29.2D }, [X27], X14
    ADD  X27, X27, X29, ASR #0
    ST3 { V27.4S, V28.4S, V29.4S }, [X27], X14
    LD3 { V6.4S, V7.4S, V8.4S }, [X27], X14
    ADD  X27, X27, X29
    ST3 { V30.8H, V31.8H, V0.8H }, [X27], X14
    LD3 { V6.8H, V7.8H, V8.8H }, [X27], X14
    ADD  X27, X27, X29, LSR #0
    ST3 { V12.8B, V13.8B, V14.8B }, [X27], X14
    LD3 { V25.8B, V26.8B, V27.8B }, [X27], X14
    ADD  X27, X27, X29
    ST3 { V6.2S, V7.2S, V8.2S }, [X27], X14
    LD3 { V6.2S, V7.2S, V8.2S }, [X27], X14
    ADD  X27, X27, X29, LSR #0
    ST3 { V8.4H, V9.4H, V10.4H }, [X27], X14
    LD3 { V30.4H, V31.4H, V0.4H }, [X27], X14
    ADD  X27, X27, X29, ASR #0
    ST3 { V25.8B, V26.8B, V27.8B }, [X27], X14
    LD3 { V9.8B, V10.8B, V11.8B }, [X27], X14
    ADD  X27, X27, X29
    ST3 { V15.H, V16.H, V17.H }[0x7], [X27]
    LD3 { V12.H, V13.H, V14.H }[0x5], [X27]
    ADD  X27, X27, X29, ASR #0
    ST3 { V12.S, V13.S, V14.S }[0x3], [X27]
    LD3 { V31.S, V0.S, V1.S }[0x1], [X27]
    ADD  X27, X27, X29, LSR #0
    ST3 { V31.D, V0.D, V1.D }[0x0], [X27]
    LD3 { V27.D, V28.D, V29.D }[0x1], [X27]
    ADD  X27, X27, X29, LSR #0
    ST3 { V12.B, V13.B, V14.B }[0x6], [X27]
    LD3 { V8.B, V9.B, V10.B }[0xd], [X27]
    ADD  X27, X27, X29
    MOV  X12, X27
    ST3 { V6.H, V7.H, V8.H }[0x7], [X12], #6
    MOV  X12, X27
    LD3 { V31.H, V0.H, V1.H }[0x0], [X12], #6
    ADD  X27, X27, X29, LSR #0
    ST3 { V13.H, V14.H, V15.H }[0x5], [X27], X14
    LD3 { V9.H, V10.H, V11.H }[0x5], [X27], X14
    ADD  X27, X27, X29
    MOV  X12, X27
    ST3 { V31.S, V0.S, V1.S }[0x3], [X12], #12
    MOV  X12, X27
    LD3 { V20.S, V21.S, V22.S }[0x1], [X12], #12
    ADD  X27, X27, X29
    ST3 { V27.S, V28.S, V29.S }[0x2], [X27], X14
    LD3 { V24.S, V25.S, V26.S }[0x1], [X27], X14
    ADD  X27, X27, X29, ASR #0
    MOV  X12, X27
    ST3 { V20.D, V21.D, V22.D }[0x0], [X12], #24
    MOV  X12, X27
    LD3 { V21.D, V22.D, V23.D }[0x0], [X12], #24
    ADD  X27, X27, X29
    ST3 { V24.D, V25.D, V26.D }[0x0], [X27], X14
    LD3 { V25.D, V26.D, V27.D }[0x1], [X27], X14
    ADD  X27, X27, X29
    MOV  X12, X27
    ST3 { V21.B, V22.B, V23.B }[0x9], [X12], #3
    MOV  X12, X27
    LD3 { V3.B, V4.B, V5.B }[0x9], [X12], #3
    ADD  X27, X27, X29, ASR #0
    ST3 { V25.B, V26.B, V27.B }[0x3], [X27], X14
    LD3 { V27.B, V28.B, V29.B }[0x3], [X27], X14
    ADD  X27, X27, X29, ASR #0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MRS  X15, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D0
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D1
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D2
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D3
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D4
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X17, #0xa5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D5
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D6
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D7
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa500, LSL #32
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D8
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa500, LSL #32
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D9
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa500, LSL #32
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D10
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D11
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D12
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D13
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D14
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D15
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D16
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D17
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D18
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D19
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D20
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D21
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D22
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D23
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D24
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D25
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D26
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D27
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D28
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D29
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D30
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D31
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X16, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
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
    FMOV  D0, X3
    FMOV  V0.D[1], X8
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X29
    FMOV  V3.D[1], X9
    FMOV  D4, X9
    FMOV  V4.D[1], X17
    FMOV  D5, X15
    FMOV  V5.D[1], X5
    FMOV  D6, X2
    FMOV  V6.D[1], X23
    FMOV  D7, X27
    FMOV  V7.D[1], X5
    FMOV  D8, X23
    FMOV  V8.D[1], X14
    FMOV  D9, X29
    FMOV  V9.D[1], X28
    FMOV  D10, X5
    FMOV  V10.D[1], X7
    FMOV  D11, X26
    FMOV  V11.D[1], X6
    FMOV  D12, X27
    FMOV  V12.D[1], X29
    FMOV  D13, X8
    FMOV  V13.D[1], X24
    FMOV  D14, X7
    FMOV  V14.D[1], X25
    FMOV  D15, X16
    FMOV  V15.D[1], X23
    FMOV  D16, X8
    FMOV  V16.D[1], X12
    FMOV  D17, X13
    FMOV  V17.D[1], X15
    FMOV  D18, X23
    FMOV  V18.D[1], X29
    FMOV  D19, X23
    FMOV  V19.D[1], X8
    FMOV  D20, X27
    FMOV  V20.D[1], X15
    FMOV  D21, X26
    FMOV  V21.D[1], X23
    FMOV  D22, X11
    FMOV  V22.D[1], X12
    FMOV  D23, X2
    FMOV  V23.D[1], X23
    FMOV  D24, X8
    FMOV  V24.D[1], X10
    FMOV  D25, X16
    FMOV  V25.D[1], X5
    FMOV  D26, X28
    FMOV  V26.D[1], X16
    FMOV  D27, X11
    FMOV  V27.D[1], X17
    FMOV  D28, X5
    FMOV  V28.D[1], X29
    FMOV  D29, X26
    FMOV  V29.D[1], X17
    FMOV  D30, X28
    FMOV  V30.D[1], X23
    FMOV  D31, X2
    FMOV  V31.D[1], X3
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X23, #0xa00, LSL #0
    ADD  X2, X30, X23, LSR #0
    ST3 { V24.8H, V25.8H, V26.8H }, [X2]
    LD3 { V21.4S, V22.4S, V23.4S }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST3 { V24.16B, V25.16B, V26.16B }, [X2]
    LD3 { V18.16B, V19.16B, V20.16B }, [X2]
    ADD  X2, X2, X4
    ST3 { V21.2D, V22.2D, V23.2D }, [X2]
    LD3 { V2.2D, V3.2D, V4.2D }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V31.4S, V0.4S, V1.4S }, [X2]
    LD3 { V19.4S, V20.4S, V21.4S }, [X2]
    ADD  X2, X2, X4
    ST3 { V18.8H, V19.8H, V20.8H }, [X2]
    LD3 { V26.8H, V27.8H, V28.8H }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V20.8B, V21.8B, V22.8B }, [X2]
    LD3 { V28.4H, V29.4H, V30.4H }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V2.2S, V3.2S, V4.2S }, [X2]
    LD3 { V16.2S, V17.2S, V18.2S }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V16.4H, V17.4H, V18.4H }, [X2]
    LD3 { V23.4H, V24.4H, V25.4H }, [X2]
    ADD  X2, X2, X4
    ST3 { V13.8B, V14.8B, V15.8B }, [X2]
    LD3 { V20.8B, V21.8B, V22.8B }, [X2]
    ADD  X2, X2, X4, ASR #0
    MOV  X7, X2
    ST3 { V3.4S, V4.4S, V5.4S }, [X7], #48
    MOV  X7, X2
    LD3 { V14.16B, V15.16B, V16.16B }, [X7], #48
    ADD  X2, X2, X4
    MOV  X7, X2
    ST3 { V24.16B, V25.16B, V26.16B }, [X7], #48
    MOV  X7, X2
    LD3 { V0.16B, V1.16B, V2.16B }, [X7], #48
    ADD  X2, X2, X4, ASR #0
    MOV  X7, X2
    ST3 { V28.2D, V29.2D, V30.2D }, [X7], #48
    MOV  X7, X2
    LD3 { V28.2D, V29.2D, V30.2D }, [X7], #48
    ADD  X2, X2, X4
    MOV  X7, X2
    ST3 { V0.4S, V1.4S, V2.4S }, [X7], #48
    MOV  X7, X2
    LD3 { V26.4S, V27.4S, V28.4S }, [X7], #48
    ADD  X2, X2, X4
    MOV  X7, X2
    ST3 { V30.8H, V31.8H, V0.8H }, [X7], #48
    MOV  X7, X2
    LD3 { V3.8H, V4.8H, V5.8H }, [X7], #48
    ADD  X2, X2, X4, ASR #0
    MOV  X7, X2
    ST3 { V3.8B, V4.8B, V5.8B }, [X7], #24
    MOV  X7, X2
    LD3 { V3.8B, V4.8B, V5.8B }, [X7], #24
    ADD  X2, X2, X4, LSR #0
    MOV  X7, X2
    ST3 { V7.2S, V8.2S, V9.2S }, [X7], #24
    MOV  X7, X2
    LD3 { V31.2S, V0.2S, V1.2S }, [X7], #24
    ADD  X2, X2, X4, ASR #0
    MOV  X7, X2
    ST3 { V3.4H, V4.4H, V5.4H }, [X7], #24
    MOV  X7, X2
    LD3 { V3.4H, V4.4H, V5.4H }, [X7], #24
    ADD  X2, X2, X4, ASR #0
    MOV  X7, X2
    ST3 { V3.8B, V4.8B, V5.8B }, [X7], #24
    MOV  X7, X2
    LD3 { V7.8B, V8.8B, V9.8B }, [X7], #24
    ADD  X2, X2, X4, LSR #0
    ST3 { V31.8H, V0.8H, V1.8H }, [X2], X3
    LD3 { V31.8H, V0.8H, V1.8H }, [X2], X3
    ADD  X2, X2, X4
    ST3 { V21.16B, V22.16B, V23.16B }, [X2], X3
    LD3 { V4.16B, V5.16B, V6.16B }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V31.2D, V0.2D, V1.2D }, [X2], X3
    LD3 { V2.2D, V3.2D, V4.2D }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V28.4S, V29.4S, V30.4S }, [X2], X3
    LD3 { V27.4S, V28.4S, V29.4S }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V4.8H, V5.8H, V6.8H }, [X2], X3
    LD3 { V30.8H, V31.8H, V0.8H }, [X2], X3
    ADD  X2, X2, X4
    ST3 { V30.2S, V31.2S, V0.2S }, [X2], X3
    LD3 { V17.2S, V18.2S, V19.2S }, [X2], X3
    ADD  X2, X2, X4
    ST3 { V27.2S, V28.2S, V29.2S }, [X2], X3
    LD3 { V21.2S, V22.2S, V23.2S }, [X2], X3
    ADD  X2, X2, X4
    ST3 { V17.4H, V18.4H, V19.4H }, [X2], X3
    LD3 { V17.4H, V18.4H, V19.4H }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V6.8B, V7.8B, V8.8B }, [X2], X3
    LD3 { V4.8B, V5.8B, V6.8B }, [X2], X3
    ADD  X2, X2, X4, ASR #0
    ST3 { V7.H, V8.H, V9.H }[0x2], [X2]
    LD3 { V13.H, V14.H, V15.H }[0x4], [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V13.S, V14.S, V15.S }[0x3], [X2]
    LD3 { V27.S, V28.S, V29.S }[0x0], [X2]
    ADD  X2, X2, X4
    ST3 { V16.D, V17.D, V18.D }[0x1], [X2]
    LD3 { V15.D, V16.D, V17.D }[0x1], [X2]
    ADD  X2, X2, X4, LSR #0
    ST3 { V24.B, V25.B, V26.B }[0xf], [X2]
    LD3 { V30.B, V31.B, V0.B }[0xb], [X2]
    ADD  X2, X2, X4, LSR #0
    MOV  X7, X2
    ST3 { V30.H, V31.H, V0.H }[0x4], [X7], #6
    MOV  X7, X2
    LD3 { V19.H, V20.H, V21.H }[0x0], [X7], #6
    ADD  X2, X2, X4, LSR #0
    ST3 { V23.H, V24.H, V25.H }[0x5], [X2], X3
    LD3 { V24.H, V25.H, V26.H }[0x2], [X2], X3
    ADD  X2, X2, X4
    MOV  X7, X2
    ST3 { V15.S, V16.S, V17.S }[0x1], [X7], #12
    MOV  X7, X2
    LD3 { V31.S, V0.S, V1.S }[0x2], [X7], #12
    ADD  X2, X2, X4, ASR #0
    ST3 { V31.S, V0.S, V1.S }[0x1], [X2], X3
    LD3 { V31.S, V0.S, V1.S }[0x1], [X2], X3
    ADD  X2, X2, X4, ASR #0
    MOV  X7, X2
    ST3 { V7.D, V8.D, V9.D }[0x0], [X7], #24
    MOV  X7, X2
    LD3 { V15.D, V16.D, V17.D }[0x0], [X7], #24
    ADD  X2, X2, X4
    ST3 { V19.D, V20.D, V21.D }[0x1], [X2], X3
    LD3 { V15.D, V16.D, V17.D }[0x0], [X2], X3
    ADD  X2, X2, X4, ASR #0
    MOV  X7, X2
    ST3 { V31.B, V0.B, V1.B }[0xa], [X7], #3
    MOV  X7, X2
    LD3 { V23.B, V24.B, V25.B }[0x7], [X7], #3
    ADD  X2, X2, X4
    ST3 { V23.B, V24.B, V25.B }[0x0], [X2], X3
    LD3 { V19.B, V20.B, V21.B }[0xc], [X2], X3
    ADD  X2, X2, X4
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MRS  X6, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D5
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D10
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D11
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a, LSL #32
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D19
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a, LSL #32
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D20
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a, LSL #32
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D21
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D23
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D26
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D28
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D29
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X14, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D31
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X6
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
    FMOV  V0.D[1], X12
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X13
    FMOV  V2.D[1], X5
    FMOV  D3, X29
    FMOV  V3.D[1], X28
    FMOV  D4, X17
    FMOV  V4.D[1], X12
    FMOV  D5, X25
    FMOV  V5.D[1], X17
    FMOV  D6, X25
    FMOV  V6.D[1], X27
    FMOV  D7, X2
    FMOV  V7.D[1], X2
    FMOV  D8, X4
    FMOV  V8.D[1], X17
    FMOV  D9, X24
    FMOV  V9.D[1], X11
    FMOV  D10, X27
    FMOV  V10.D[1], X5
    FMOV  D11, X14
    FMOV  V11.D[1], X24
    FMOV  D12, X25
    FMOV  V12.D[1], X23
    FMOV  D13, X9
    FMOV  V13.D[1], X16
    FMOV  D14, X17
    FMOV  V14.D[1], X7
    FMOV  D15, X16
    FMOV  V15.D[1], X3
    FMOV  D16, X16
    FMOV  V16.D[1], X17
    FMOV  D17, X3
    FMOV  V17.D[1], X16
    FMOV  D18, X9
    FMOV  V18.D[1], X12
    FMOV  D19, X10
    FMOV  V19.D[1], X23
    FMOV  D20, X14
    FMOV  V20.D[1], X29
    FMOV  D21, X24
    FMOV  V21.D[1], X4
    FMOV  D22, X16
    FMOV  V22.D[1], X17
    FMOV  D23, X24
    FMOV  V23.D[1], X2
    FMOV  D24, X9
    FMOV  V24.D[1], X15
    FMOV  D25, X7
    FMOV  V25.D[1], X15
    FMOV  D26, X4
    FMOV  V26.D[1], X25
    FMOV  D27, X9
    FMOV  V27.D[1], X7
    FMOV  D28, X14
    FMOV  V28.D[1], X16
    FMOV  D29, X10
    FMOV  V29.D[1], X3
    FMOV  D30, X28
    FMOV  V30.D[1], X5
    FMOV  D31, X9
    FMOV  V31.D[1], X4
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X5, #0xf00, LSL #0
    ADD  X16, X30, X5, ASR #0
    ST3 { V13.16B, V14.16B, V15.16B }, [X16]
    LD3 { V20.2D, V21.2D, V22.2D }, [X16]
    ADD  X16, X16, X29, ASR #0
    ST3 { V26.16B, V27.16B, V28.16B }, [X16]
    LD3 { V10.16B, V11.16B, V12.16B }, [X16]
    ADD  X16, X16, X29, ASR #0
    ST3 { V23.2D, V24.2D, V25.2D }, [X16]
    LD3 { V30.2D, V31.2D, V0.2D }, [X16]
    ADD  X16, X16, X29, LSR #0
    ST3 { V10.4S, V11.4S, V12.4S }, [X16]
    LD3 { V30.4S, V31.4S, V0.4S }, [X16]
    ADD  X16, X16, X29, ASR #0
    ST3 { V20.8H, V21.8H, V22.8H }, [X16]
    LD3 { V22.8H, V23.8H, V24.8H }, [X16]
    ADD  X16, X16, X29
    ST3 { V9.4H, V10.4H, V11.4H }, [X16]
    LD3 { V6.2S, V7.2S, V8.2S }, [X16]
    ADD  X16, X16, X29
    ST3 { V31.2S, V0.2S, V1.2S }, [X16]
    LD3 { V25.2S, V26.2S, V27.2S }, [X16]
    ADD  X16, X16, X29
    ST3 { V23.4H, V24.4H, V25.4H }, [X16]
    LD3 { V13.4H, V14.4H, V15.4H }, [X16]
    ADD  X16, X16, X29
    ST3 { V6.8B, V7.8B, V8.8B }, [X16]
    LD3 { V18.8B, V19.8B, V20.8B }, [X16]
    ADD  X16, X16, X29, LSR #0
    MOV  X3, X16
    ST3 { V13.2D, V14.2D, V15.2D }, [X3], #48
    MOV  X3, X16
    LD3 { V21.8H, V22.8H, V23.8H }, [X3], #48
    ADD  X16, X16, X29, ASR #0
    MOV  X3, X16
    ST3 { V20.16B, V21.16B, V22.16B }, [X3], #48
    MOV  X3, X16
    LD3 { V3.16B, V4.16B, V5.16B }, [X3], #48
    ADD  X16, X16, X29, ASR #0
    MOV  X3, X16
    ST3 { V8.2D, V9.2D, V10.2D }, [X3], #48
    MOV  X3, X16
    LD3 { V6.2D, V7.2D, V8.2D }, [X3], #48
    ADD  X16, X16, X29, ASR #0
    MOV  X3, X16
    ST3 { V10.4S, V11.4S, V12.4S }, [X3], #48
    MOV  X3, X16
    LD3 { V10.4S, V11.4S, V12.4S }, [X3], #48
    ADD  X16, X16, X29, LSR #0
    MOV  X3, X16
    ST3 { V3.8H, V4.8H, V5.8H }, [X3], #48
    MOV  X3, X16
    LD3 { V31.8H, V0.8H, V1.8H }, [X3], #48
    ADD  X16, X16, X29
    MOV  X3, X16
    ST3 { V6.8B, V7.8B, V8.8B }, [X3], #24
    MOV  X3, X16
    LD3 { V20.8B, V21.8B, V22.8B }, [X3], #24
    ADD  X16, X16, X29
    MOV  X3, X16
    ST3 { V31.2S, V0.2S, V1.2S }, [X3], #24
    MOV  X3, X16
    LD3 { V24.2S, V25.2S, V26.2S }, [X3], #24
    ADD  X16, X16, X29
    MOV  X3, X16
    ST3 { V20.4H, V21.4H, V22.4H }, [X3], #24
    MOV  X3, X16
    LD3 { V31.4H, V0.4H, V1.4H }, [X3], #24
    ADD  X16, X16, X29, LSR #0
    MOV  X3, X16
    ST3 { V1.8B, V2.8B, V3.8B }, [X3], #24
    MOV  X3, X16
    LD3 { V26.8B, V27.8B, V28.8B }, [X3], #24
    ADD  X16, X16, X29, ASR #0
    ST3 { V10.4S, V11.4S, V12.4S }, [X16], X15
    LD3 { V3.4S, V4.4S, V5.4S }, [X16], X15
    ADD  X16, X16, X29, LSR #0
    ST3 { V24.16B, V25.16B, V26.16B }, [X16], X15
    LD3 { V10.16B, V11.16B, V12.16B }, [X16], X15
    ADD  X16, X16, X29, ASR #0
    ST3 { V1.2D, V2.2D, V3.2D }, [X16], X15
    LD3 { V14.2D, V15.2D, V16.2D }, [X16], X15
    ADD  X16, X16, X29, LSR #0
    ST3 { V16.4S, V17.4S, V18.4S }, [X16], X15
    LD3 { V8.4S, V9.4S, V10.4S }, [X16], X15
    ADD  X16, X16, X29
    ST3 { V19.8H, V20.8H, V21.8H }, [X16], X15
    LD3 { V16.8H, V17.8H, V18.8H }, [X16], X15
    ADD  X16, X16, X29, ASR #0
    ST3 { V15.8B, V16.8B, V17.8B }, [X16], X15
    LD3 { V1.8B, V2.8B, V3.8B }, [X16], X15
    ADD  X16, X16, X29, LSR #0
    ST3 { V1.2S, V2.2S, V3.2S }, [X16], X15
    LD3 { V1.2S, V2.2S, V3.2S }, [X16], X15
    ADD  X16, X16, X29, LSR #0
    ST3 { V2.4H, V3.4H, V4.4H }, [X16], X15
    LD3 { V20.4H, V21.4H, V22.4H }, [X16], X15
    ADD  X16, X16, X29, LSR #0
    ST3 { V18.8B, V19.8B, V20.8B }, [X16], X15
    LD3 { V18.8B, V19.8B, V20.8B }, [X16], X15
    ADD  X16, X16, X29, LSR #0
    ST3 { V23.H, V24.H, V25.H }[0x5], [X16]
    LD3 { V15.H, V16.H, V17.H }[0x3], [X16]
    ADD  X16, X16, X29, ASR #0
    ST3 { V8.S, V9.S, V10.S }[0x2], [X16]
    LD3 { V2.S, V3.S, V4.S }[0x1], [X16]
    ADD  X16, X16, X29
    ST3 { V18.D, V19.D, V20.D }[0x1], [X16]
    LD3 { V8.D, V9.D, V10.D }[0x0], [X16]
    ADD  X16, X16, X29
    ST3 { V15.B, V16.B, V17.B }[0x8], [X16]
    LD3 { V8.B, V9.B, V10.B }[0xa], [X16]
    ADD  X16, X16, X29
    MOV  X3, X16
    ST3 { V12.H, V13.H, V14.H }[0x2], [X3], #6
    MOV  X3, X16
    LD3 { V5.H, V6.H, V7.H }[0x4], [X3], #6
    ADD  X16, X16, X29, ASR #0
    ST3 { V8.H, V9.H, V10.H }[0x2], [X16], X15
    LD3 { V23.H, V24.H, V25.H }[0x5], [X16], X15
    ADD  X16, X16, X29, LSR #0
    MOV  X3, X16
    ST3 { V3.S, V4.S, V5.S }[0x1], [X3], #12
    MOV  X3, X16
    LD3 { V3.S, V4.S, V5.S }[0x2], [X3], #12
    ADD  X16, X16, X29, ASR #0
    ST3 { V5.S, V6.S, V7.S }[0x3], [X16], X15
    LD3 { V8.S, V9.S, V10.S }[0x2], [X16], X15
    ADD  X16, X16, X29, ASR #0
    MOV  X3, X16
    ST3 { V22.D, V23.D, V24.D }[0x0], [X3], #24
    MOV  X3, X16
    LD3 { V10.D, V11.D, V12.D }[0x0], [X3], #24
    ADD  X16, X16, X29, LSR #0
    ST3 { V10.D, V11.D, V12.D }[0x0], [X16], X15
    LD3 { V22.D, V23.D, V24.D }[0x0], [X16], X15
    ADD  X16, X16, X29
    MOV  X3, X16
    ST3 { V4.B, V5.B, V6.B }[0x9], [X3], #3
    MOV  X3, X16
    LD3 { V25.B, V26.B, V27.B }[0xb], [X3], #3
    ADD  X16, X16, X29, LSR #0
    ST3 { V25.B, V26.B, V27.B }[0x0], [X16], X15
    LD3 { V10.B, V11.B, V12.B }[0xb], [X16], X15
    ADD  X16, X16, X29
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MRS  X6, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D6
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa500, LSL #16
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa500, LSL #16
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa500, LSL #16
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa500, LSL #16
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X6, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
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
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X6
    FMOV  D3, X4
    FMOV  V3.D[1], X11
    FMOV  D4, X26
    FMOV  V4.D[1], X27
    FMOV  D5, X17
    FMOV  V5.D[1], X25
    FMOV  D6, X26
    FMOV  V6.D[1], X17
    FMOV  D7, X8
    FMOV  V7.D[1], X3
    FMOV  D8, X23
    FMOV  V8.D[1], X11
    FMOV  D9, X3
    FMOV  V9.D[1], X5
    FMOV  D10, X10
    FMOV  V10.D[1], X17
    FMOV  D11, X2
    FMOV  V11.D[1], X16
    FMOV  D12, X17
    FMOV  V12.D[1], X10
    FMOV  D13, X24
    FMOV  V13.D[1], X23
    FMOV  D14, X15
    FMOV  V14.D[1], X2
    FMOV  D15, X11
    FMOV  V15.D[1], X6
    FMOV  D16, X24
    FMOV  V16.D[1], X9
    FMOV  D17, X26
    FMOV  V17.D[1], X2
    FMOV  D18, X28
    FMOV  V18.D[1], X13
    FMOV  D19, X12
    FMOV  V19.D[1], X16
    FMOV  D20, X15
    FMOV  V20.D[1], X15
    FMOV  D21, X11
    FMOV  V21.D[1], X10
    FMOV  D22, X6
    FMOV  V22.D[1], X15
    FMOV  D23, X13
    FMOV  V23.D[1], X5
    FMOV  D24, X9
    FMOV  V24.D[1], X13
    FMOV  D25, X24
    FMOV  V25.D[1], X16
    FMOV  D26, X26
    FMOV  V26.D[1], X2
    FMOV  D27, X4
    FMOV  V27.D[1], X28
    FMOV  D28, X28
    FMOV  V28.D[1], X16
    FMOV  D29, X16
    FMOV  V29.D[1], X13
    FMOV  D30, X24
    FMOV  V30.D[1], X13
    FMOV  D31, X10
    FMOV  V31.D[1], X24
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X7, #0x1400, LSL #0
    ADD  X14, X30, X7
    ST3 { V24.4S, V25.4S, V26.4S }, [X14]
    LD3 { V22.2D, V23.2D, V24.2D }, [X14]
    ADD  X14, X14, X15, ASR #0
    ST3 { V28.16B, V29.16B, V30.16B }, [X14]
    LD3 { V0.16B, V1.16B, V2.16B }, [X14]
    ADD  X14, X14, X15, LSR #0
    ST3 { V22.2D, V23.2D, V24.2D }, [X14]
    LD3 { V2.2D, V3.2D, V4.2D }, [X14]
    ADD  X14, X14, X15, LSR #0
    ST3 { V31.4S, V0.4S, V1.4S }, [X14]
    LD3 { V5.4S, V6.4S, V7.4S }, [X14]
    ADD  X14, X14, X15, ASR #0
    ST3 { V2.8H, V3.8H, V4.8H }, [X14]
    LD3 { V13.8H, V14.8H, V15.8H }, [X14]
    ADD  X14, X14, X15, ASR #0
    ST3 { V5.8B, V6.8B, V7.8B }, [X14]
    LD3 { V5.8B, V6.8B, V7.8B }, [X14]
    ADD  X14, X14, X15
    ST3 { V13.2S, V14.2S, V15.2S }, [X14]
    LD3 { V8.2S, V9.2S, V10.2S }, [X14]
    ADD  X14, X14, X15, ASR #0
    ST3 { V11.4H, V12.4H, V13.4H }, [X14]
    LD3 { V30.4H, V31.4H, V0.4H }, [X14]
    ADD  X14, X14, X15
    ST3 { V8.8B, V9.8B, V10.8B }, [X14]
    LD3 { V8.8B, V9.8B, V10.8B }, [X14]
    ADD  X14, X14, X15
    MOV  X6, X14
    ST3 { V7.4S, V8.4S, V9.4S }, [X6], #48
    MOV  X6, X14
    LD3 { V13.4S, V14.4S, V15.4S }, [X6], #48
    ADD  X14, X14, X15
    MOV  X6, X14
    ST3 { V30.16B, V31.16B, V0.16B }, [X6], #48
    MOV  X6, X14
    LD3 { V7.16B, V8.16B, V9.16B }, [X6], #48
    ADD  X14, X14, X15, ASR #0
    MOV  X6, X14
    ST3 { V8.2D, V9.2D, V10.2D }, [X6], #48
    MOV  X6, X14
    LD3 { V27.2D, V28.2D, V29.2D }, [X6], #48
    ADD  X14, X14, X15
    MOV  X6, X14
    ST3 { V7.4S, V8.4S, V9.4S }, [X6], #48
    MOV  X6, X14
    LD3 { V30.4S, V31.4S, V0.4S }, [X6], #48
    ADD  X14, X14, X15
    MOV  X6, X14
    ST3 { V6.8H, V7.8H, V8.8H }, [X6], #48
    MOV  X6, X14
    LD3 { V7.8H, V8.8H, V9.8H }, [X6], #48
    ADD  X14, X14, X15, ASR #0
    MOV  X6, X14
    ST3 { V27.8B, V28.8B, V29.8B }, [X6], #24
    MOV  X6, X14
    LD3 { V5.8B, V6.8B, V7.8B }, [X6], #24
    ADD  X14, X14, X15, ASR #0
    MOV  X6, X14
    ST3 { V30.2S, V31.2S, V0.2S }, [X6], #24
    MOV  X6, X14
    LD3 { V16.2S, V17.2S, V18.2S }, [X6], #24
    ADD  X14, X14, X15, LSR #0
    MOV  X6, X14
    ST3 { V5.4H, V6.4H, V7.4H }, [X6], #24
    MOV  X6, X14
    LD3 { V14.4H, V15.4H, V16.4H }, [X6], #24
    ADD  X14, X14, X15, LSR #0
    MOV  X6, X14
    ST3 { V16.8B, V17.8B, V18.8B }, [X6], #24
    MOV  X6, X14
    LD3 { V28.8B, V29.8B, V30.8B }, [X6], #24
    ADD  X14, X14, X15, ASR #0
    ST3 { V28.8H, V29.8H, V30.8H }, [X14], X9
    LD3 { V18.2D, V19.2D, V20.2D }, [X14], X9
    ADD  X14, X14, X15, ASR #0
    ST3 { V18.16B, V19.16B, V20.16B }, [X14], X9
    LD3 { V12.16B, V13.16B, V14.16B }, [X14], X9
    ADD  X14, X14, X15, LSR #0
    ST3 { V13.2D, V14.2D, V15.2D }, [X14], X9
    LD3 { V17.2D, V18.2D, V19.2D }, [X14], X9
    ADD  X14, X14, X15
    ST3 { V17.4S, V18.4S, V19.4S }, [X14], X9
    LD3 { V18.4S, V19.4S, V20.4S }, [X14], X9
    ADD  X14, X14, X15, ASR #0
    ST3 { V1.8H, V2.8H, V3.8H }, [X14], X9
    LD3 { V1.8H, V2.8H, V3.8H }, [X14], X9
    ADD  X14, X14, X15, LSR #0
    ST3 { V30.4H, V31.4H, V0.4H }, [X14], X9
    LD3 { V17.2S, V18.2S, V19.2S }, [X14], X9
    ADD  X14, X14, X15, ASR #0
    ST3 { V19.2S, V20.2S, V21.2S }, [X14], X9
    LD3 { V29.2S, V30.2S, V31.2S }, [X14], X9
    ADD  X14, X14, X15, LSR #0
    ST3 { V30.4H, V31.4H, V0.4H }, [X14], X9
    LD3 { V23.4H, V24.4H, V25.4H }, [X14], X9
    ADD  X14, X14, X15
    ST3 { V27.8B, V28.8B, V29.8B }, [X14], X9
    LD3 { V30.8B, V31.8B, V0.8B }, [X14], X9
    ADD  X14, X14, X15, LSR #0
    ST3 { V23.H, V24.H, V25.H }[0x5], [X14]
    LD3 { V12.H, V13.H, V14.H }[0x0], [X14]
    ADD  X14, X14, X15
    ST3 { V30.S, V31.S, V0.S }[0x3], [X14]
    LD3 { V27.S, V28.S, V29.S }[0x3], [X14]
    ADD  X14, X14, X15
    ST3 { V27.D, V28.D, V29.D }[0x1], [X14]
    LD3 { V19.D, V20.D, V21.D }[0x1], [X14]
    ADD  X14, X14, X15
    ST3 { V19.B, V20.B, V21.B }[0xf], [X14]
    LD3 { V13.B, V14.B, V15.B }[0x5], [X14]
    ADD  X14, X14, X15
    MOV  X6, X14
    ST3 { V11.H, V12.H, V13.H }[0x0], [X6], #6
    MOV  X6, X14
    LD3 { V11.H, V12.H, V13.H }[0x7], [X6], #6
    ADD  X14, X14, X15, LSR #0
    ST3 { V12.H, V13.H, V14.H }[0x5], [X14], X9
    LD3 { V28.H, V29.H, V30.H }[0x0], [X14], X9
    ADD  X14, X14, X15, ASR #0
    MOV  X6, X14
    ST3 { V8.S, V9.S, V10.S }[0x1], [X6], #12
    MOV  X6, X14
    LD3 { V19.S, V20.S, V21.S }[0x3], [X6], #12
    ADD  X14, X14, X15
    ST3 { V19.S, V20.S, V21.S }[0x2], [X14], X9
    LD3 { V8.S, V9.S, V10.S }[0x0], [X14], X9
    ADD  X14, X14, X15, LSR #0
    MOV  X6, X14
    ST3 { V16.D, V17.D, V18.D }[0x0], [X6], #24
    MOV  X6, X14
    LD3 { V13.D, V14.D, V15.D }[0x1], [X6], #24
    ADD  X14, X14, X15, ASR #0
    ST3 { V0.D, V1.D, V2.D }[0x0], [X14], X9
    LD3 { V0.D, V1.D, V2.D }[0x0], [X14], X9
    ADD  X14, X14, X15, ASR #0
    MOV  X6, X14
    ST3 { V13.B, V14.B, V15.B }[0xf], [X6], #3
    MOV  X6, X14
    LD3 { V1.B, V2.B, V3.B }[0x0], [X6], #3
    ADD  X14, X14, X15, LSR #0
    ST3 { V0.B, V1.B, V2.B }[0xa], [X14], X9
    LD3 { V24.B, V25.B, V26.B }[0xb], [X14], X9
    ADD  X14, X14, X15
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X28, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MRS  X11, FPSR
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D1
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D2
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D3
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D4
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D5
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D6
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D7
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D8
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D9
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D10
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D11
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D12
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D13
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D14
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D15
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D16
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D17
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D18
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D19
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D20
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D21
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D22
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D23
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D24
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a00, LSL #16
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D25
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D26
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D27
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D28
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D29
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D30
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X11, D31
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X23, X28, X11
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
    FMOV  D0, X17
    FMOV  V0.D[1], X29
    FMOV  D1, X12
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X13
    FMOV  D4, X23
    FMOV  V4.D[1], X14
    FMOV  D5, X10
    FMOV  V5.D[1], X23
    FMOV  D6, X6
    FMOV  V6.D[1], X17
    FMOV  D7, X13
    FMOV  V7.D[1], X14
    FMOV  D8, X14
    FMOV  V8.D[1], X5
    FMOV  D9, X16
    FMOV  V9.D[1], X29
    FMOV  D10, X12
    FMOV  V10.D[1], X23
    FMOV  D11, X15
    FMOV  V11.D[1], X6
    FMOV  D12, X15
    FMOV  V12.D[1], X26
    FMOV  D13, X11
    FMOV  V13.D[1], X15
    FMOV  D14, X9
    FMOV  V14.D[1], X12
    FMOV  D15, X26
    FMOV  V15.D[1], X11
    FMOV  D16, X26
    FMOV  V16.D[1], X17
    FMOV  D17, X10
    FMOV  V17.D[1], X26
    FMOV  D18, X16
    FMOV  V18.D[1], X28
    FMOV  D19, X26
    FMOV  V19.D[1], X29
    FMOV  D20, X13
    FMOV  V20.D[1], X3
    FMOV  D21, X6
    FMOV  V21.D[1], X23
    FMOV  D22, X14
    FMOV  V22.D[1], X6
    FMOV  D23, X10
    FMOV  V23.D[1], X12
    FMOV  D24, X11
    FMOV  V24.D[1], X4
    FMOV  D25, X6
    FMOV  V25.D[1], X2
    FMOV  D26, X3
    FMOV  V26.D[1], X8
    FMOV  D27, X4
    FMOV  V27.D[1], X14
    FMOV  D28, X23
    FMOV  V28.D[1], X11
    FMOV  D29, X10
    FMOV  V29.D[1], X26
    FMOV  D30, X14
    FMOV  V30.D[1], X11
    FMOV  D31, X5
    FMOV  V31.D[1], X28
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X2, #0x1900, LSL #0
    ADD  X11, X30, X2, ASR #0
    ST3 { V29.16B, V30.16B, V31.16B }, [X11]
    LD3 { V3.16B, V4.16B, V5.16B }, [X11]
    ADD  X11, X11, X14
    ST3 { V25.16B, V26.16B, V27.16B }, [X11]
    LD3 { V13.16B, V14.16B, V15.16B }, [X11]
    ADD  X11, X11, X14, LSR #0
    ST3 { V4.2D, V5.2D, V6.2D }, [X11]
    LD3 { V14.2D, V15.2D, V16.2D }, [X11]
    ADD  X11, X11, X14
    ST3 { V7.4S, V8.4S, V9.4S }, [X11]
    LD3 { V20.4S, V21.4S, V22.4S }, [X11]
    ADD  X11, X11, X14, LSR #0
    ST3 { V16.8H, V17.8H, V18.8H }, [X11]
    LD3 { V4.8H, V5.8H, V6.8H }, [X11]
    ADD  X11, X11, X14, ASR #0
    ST3 { V20.2S, V21.2S, V22.2S }, [X11]
    LD3 { V28.8B, V29.8B, V30.8B }, [X11]
    ADD  X11, X11, X14, ASR #0
    ST3 { V1.2S, V2.2S, V3.2S }, [X11]
    LD3 { V25.2S, V26.2S, V27.2S }, [X11]
    ADD  X11, X11, X14, LSR #0
    ST3 { V28.4H, V29.4H, V30.4H }, [X11]
    LD3 { V20.4H, V21.4H, V22.4H }, [X11]
    ADD  X11, X11, X14, ASR #0
    ST3 { V22.8B, V23.8B, V24.8B }, [X11]
    LD3 { V30.8B, V31.8B, V0.8B }, [X11]
    ADD  X11, X11, X14, ASR #0
    MOV  X29, X11
    ST3 { V7.2D, V8.2D, V9.2D }, [X29], #48
    MOV  X29, X11
    LD3 { V1.8H, V2.8H, V3.8H }, [X29], #48
    ADD  X11, X11, X14, LSR #0
    MOV  X29, X11
    ST3 { V1.16B, V2.16B, V3.16B }, [X29], #48
    MOV  X29, X11
    LD3 { V1.16B, V2.16B, V3.16B }, [X29], #48
    ADD  X11, X11, X14
    MOV  X29, X11
    ST3 { V25.2D, V26.2D, V27.2D }, [X29], #48
    MOV  X29, X11
    LD3 { V27.2D, V28.2D, V29.2D }, [X29], #48
    ADD  X11, X11, X14
    MOV  X29, X11
    ST3 { V27.4S, V28.4S, V29.4S }, [X29], #48
    MOV  X29, X11
    LD3 { V7.4S, V8.4S, V9.4S }, [X29], #48
    ADD  X11, X11, X14, ASR #0
    MOV  X29, X11
    ST3 { V7.8H, V8.8H, V9.8H }, [X29], #48
    MOV  X29, X11
    LD3 { V27.8H, V28.8H, V29.8H }, [X29], #48
    ADD  X11, X11, X14, LSR #0
    MOV  X29, X11
    ST3 { V2.8B, V3.8B, V4.8B }, [X29], #24
    MOV  X29, X11
    LD3 { V2.4H, V3.4H, V4.4H }, [X29], #24
    ADD  X11, X11, X14
    MOV  X29, X11
    ST3 { V2.2S, V3.2S, V4.2S }, [X29], #24
    MOV  X29, X11
    LD3 { V2.2S, V3.2S, V4.2S }, [X29], #24
    ADD  X11, X11, X14, ASR #0
    MOV  X29, X11
    ST3 { V27.4H, V28.4H, V29.4H }, [X29], #24
    MOV  X29, X11
    LD3 { V16.4H, V17.4H, V18.4H }, [X29], #24
    ADD  X11, X11, X14, LSR #0
    MOV  X29, X11
    ST3 { V2.8B, V3.8B, V4.8B }, [X29], #24
    MOV  X29, X11
    LD3 { V2.8B, V3.8B, V4.8B }, [X29], #24
    ADD  X11, X11, X14
    ST3 { V2.4S, V3.4S, V4.4S }, [X11], X5
    LD3 { V19.4S, V20.4S, V21.4S }, [X11], X5
    ADD  X11, X11, X14
    ST3 { V3.16B, V4.16B, V5.16B }, [X11], X5
    LD3 { V12.16B, V13.16B, V14.16B }, [X11], X5
    ADD  X11, X11, X14
    ST3 { V12.2D, V13.2D, V14.2D }, [X11], X5
    LD3 { V13.2D, V14.2D, V15.2D }, [X11], X5
    ADD  X11, X11, X14, ASR #0
    ST3 { V13.4S, V14.4S, V15.4S }, [X11], X5
    LD3 { V3.4S, V4.4S, V5.4S }, [X11], X5
    ADD  X11, X11, X14, LSR #0
    ST3 { V22.8H, V23.8H, V24.8H }, [X11], X5
    LD3 { V20.8H, V21.8H, V22.8H }, [X11], X5
    ADD  X11, X11, X14, ASR #0
    ST3 { V11.4H, V12.4H, V13.4H }, [X11], X5
    LD3 { V6.2S, V7.2S, V8.2S }, [X11], X5
    ADD  X11, X11, X14, ASR #0
    ST3 { V20.2S, V21.2S, V22.2S }, [X11], X5
    LD3 { V11.2S, V12.2S, V13.2S }, [X11], X5
    ADD  X11, X11, X14, LSR #0
    ST3 { V11.4H, V12.4H, V13.4H }, [X11], X5
    LD3 { V22.4H, V23.4H, V24.4H }, [X11], X5
    ADD  X11, X11, X14, ASR #0
    ST3 { V25.8B, V26.8B, V27.8B }, [X11], X5
    LD3 { V12.8B, V13.8B, V14.8B }, [X11], X5
    ADD  X11, X11, X14
    ST3 { V22.H, V23.H, V24.H }[0x5], [X11]
    LD3 { V11.H, V12.H, V13.H }[0x5], [X11]
    ADD  X11, X11, X14, LSR #0
    ST3 { V5.S, V6.S, V7.S }[0x2], [X11]
    LD3 { V29.S, V30.S, V31.S }[0x2], [X11]
    ADD  X11, X11, X14
    ST3 { V28.D, V29.D, V30.D }[0x0], [X11]
    LD3 { V22.D, V23.D, V24.D }[0x1], [X11]
    ADD  X11, X11, X14, LSR #0
    ST3 { V12.B, V13.B, V14.B }[0xf], [X11]
    LD3 { V5.B, V6.B, V7.B }[0xa], [X11]
    ADD  X11, X11, X14, ASR #0
    MOV  X29, X11
    ST3 { V22.H, V23.H, V24.H }[0x0], [X29], #6
    MOV  X29, X11
    LD3 { V6.H, V7.H, V8.H }[0x7], [X29], #6
    ADD  X11, X11, X14
    ST3 { V5.H, V6.H, V7.H }[0x3], [X11], X5
    LD3 { V3.H, V4.H, V5.H }[0x1], [X11], X5
    ADD  X11, X11, X14
    MOV  X29, X11
    ST3 { V17.S, V18.S, V19.S }[0x2], [X29], #12
    MOV  X29, X11
    LD3 { V27.S, V28.S, V29.S }[0x1], [X29], #12
    ADD  X11, X11, X14, LSR #0
    ST3 { V21.S, V22.S, V23.S }[0x1], [X11], X5
    LD3 { V21.S, V22.S, V23.S }[0x3], [X11], X5
    ADD  X11, X11, X14, LSR #0
    MOV  X29, X11
    ST3 { V2.D, V3.D, V4.D }[0x0], [X29], #24
    MOV  X29, X11
    LD3 { V17.D, V18.D, V19.D }[0x0], [X29], #24
    ADD  X11, X11, X14, ASR #0
    ST3 { V17.D, V18.D, V19.D }[0x1], [X11], X5
    LD3 { V19.D, V20.D, V21.D }[0x1], [X11], X5
    ADD  X11, X11, X14, ASR #0
    MOV  X29, X11
    ST3 { V3.B, V4.B, V5.B }[0x3], [X29], #3
    MOV  X29, X11
    LD3 { V12.B, V13.B, V14.B }[0xc], [X29], #3
    ADD  X11, X11, X14, LSR #0
    ST3 { V20.B, V21.B, V22.B }[0x3], [X11], X5
    LD3 { V22.B, V23.B, V24.B }[0xf], [X11], X5
    ADD  X11, X11, X14
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MRS  X26, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa500, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5, LSL #32
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D12
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5, LSL #32
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5, LSL #32
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D18
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D24
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D28
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X7
    FMOV  D3, X23
    FMOV  V3.D[1], X25
    FMOV  D4, X26
    FMOV  V4.D[1], X8
    FMOV  D5, X26
    FMOV  V5.D[1], X4
    FMOV  D6, X25
    FMOV  V6.D[1], X2
    FMOV  D7, X27
    FMOV  V7.D[1], X16
    FMOV  D8, X12
    FMOV  V8.D[1], X10
    FMOV  D9, X5
    FMOV  V9.D[1], X2
    FMOV  D10, X15
    FMOV  V10.D[1], X23
    FMOV  D11, X16
    FMOV  V11.D[1], X12
    FMOV  D12, X28
    FMOV  V12.D[1], X16
    FMOV  D13, X17
    FMOV  V13.D[1], X8
    FMOV  D14, X14
    FMOV  V14.D[1], X17
    FMOV  D15, X24
    FMOV  V15.D[1], X15
    FMOV  D16, X6
    FMOV  V16.D[1], X28
    FMOV  D17, X3
    FMOV  V17.D[1], X12
    FMOV  D18, X16
    FMOV  V18.D[1], X23
    FMOV  D19, X28
    FMOV  V19.D[1], X7
    FMOV  D20, X10
    FMOV  V20.D[1], X13
    FMOV  D21, X11
    FMOV  V21.D[1], X28
    FMOV  D22, X14
    FMOV  V22.D[1], X23
    FMOV  D23, X16
    FMOV  V23.D[1], X13
    FMOV  D24, X14
    FMOV  V24.D[1], X2
    FMOV  D25, X17
    FMOV  V25.D[1], X14
    FMOV  D26, X25
    FMOV  V26.D[1], X27
    FMOV  D27, X23
    FMOV  V27.D[1], X5
    FMOV  D28, X14
    FMOV  V28.D[1], X3
    FMOV  D29, X4
    FMOV  V29.D[1], X6
    FMOV  D30, X11
    FMOV  V30.D[1], X14
    FMOV  D31, X16
    FMOV  V31.D[1], X4
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X7, #0x1e00, LSL #0
    ADD  X2, X30, X7
    ST3 { V20.8H, V21.8H, V22.8H }, [X2]
    LD3 { V8.16B, V9.16B, V10.16B }, [X2]
    ADD  X2, X2, X5, LSR #0
    ST3 { V31.16B, V0.16B, V1.16B }, [X2]
    LD3 { V18.16B, V19.16B, V20.16B }, [X2]
    ADD  X2, X2, X5, LSR #0
    ST3 { V17.2D, V18.2D, V19.2D }, [X2]
    LD3 { V27.2D, V28.2D, V29.2D }, [X2]
    ADD  X2, X2, X5, ASR #0
    ST3 { V28.4S, V29.4S, V30.4S }, [X2]
    LD3 { V0.4S, V1.4S, V2.4S }, [X2]
    ADD  X2, X2, X5
    ST3 { V8.8H, V9.8H, V10.8H }, [X2]
    LD3 { V5.8H, V6.8H, V7.8H }, [X2]
    ADD  X2, X2, X5, ASR #0
    ST3 { V27.8B, V28.8B, V29.8B }, [X2]
    LD3 { V12.2S, V13.2S, V14.2S }, [X2]
    ADD  X2, X2, X5
    ST3 { V0.2S, V1.2S, V2.2S }, [X2]
    LD3 { V0.2S, V1.2S, V2.2S }, [X2]
    ADD  X2, X2, X5, ASR #0
    ST3 { V12.4H, V13.4H, V14.4H }, [X2]
    LD3 { V21.4H, V22.4H, V23.4H }, [X2]
    ADD  X2, X2, X5
    ST3 { V5.8B, V6.8B, V7.8B }, [X2]
    LD3 { V17.8B, V18.8B, V19.8B }, [X2]
    ADD  X2, X2, X5
    MOV  X12, X2
    ST3 { V21.8H, V22.8H, V23.8H }, [X12], #48
    MOV  X12, X2
    LD3 { V12.4S, V13.4S, V14.4S }, [X12], #48
    ADD  X2, X2, X5, ASR #0
    MOV  X12, X2
    ST3 { V17.16B, V18.16B, V19.16B }, [X12], #48
    MOV  X12, X2
    LD3 { V27.16B, V28.16B, V29.16B }, [X12], #48
    ADD  X2, X2, X5
    MOV  X12, X2
    ST3 { V27.2D, V28.2D, V29.2D }, [X12], #48
    MOV  X12, X2
    LD3 { V21.2D, V22.2D, V23.2D }, [X12], #48
    ADD  X2, X2, X5, LSR #0
    MOV  X12, X2
    ST3 { V11.4S, V12.4S, V13.4S }, [X12], #48
    MOV  X12, X2
    LD3 { V31.4S, V0.4S, V1.4S }, [X12], #48
    ADD  X2, X2, X5, ASR #0
    MOV  X12, X2
    ST3 { V15.8H, V16.8H, V17.8H }, [X12], #48
    MOV  X12, X2
    LD3 { V12.8H, V13.8H, V14.8H }, [X12], #48
    ADD  X2, X2, X5, LSR #0
    MOV  X12, X2
    ST3 { V30.4H, V31.4H, V0.4H }, [X12], #24
    MOV  X12, X2
    LD3 { V26.4H, V27.4H, V28.4H }, [X12], #24
    ADD  X2, X2, X5
    MOV  X12, X2
    ST3 { V21.2S, V22.2S, V23.2S }, [X12], #24
    MOV  X12, X2
    LD3 { V15.2S, V16.2S, V17.2S }, [X12], #24
    ADD  X2, X2, X5
    MOV  X12, X2
    ST3 { V12.4H, V13.4H, V14.4H }, [X12], #24
    MOV  X12, X2
    LD3 { V6.4H, V7.4H, V8.4H }, [X12], #24
    ADD  X2, X2, X5, LSR #0
    MOV  X12, X2
    ST3 { V16.8B, V17.8B, V18.8B }, [X12], #24
    MOV  X12, X2
    LD3 { V12.8B, V13.8B, V14.8B }, [X12], #24
    ADD  X2, X2, X5
    ST3 { V6.16B, V7.16B, V8.16B }, [X2], X6
    LD3 { V27.4S, V28.4S, V29.4S }, [X2], X6
    ADD  X2, X2, X5
    ST3 { V13.16B, V14.16B, V15.16B }, [X2], X6
    LD3 { V6.16B, V7.16B, V8.16B }, [X2], X6
    ADD  X2, X2, X5, ASR #0
    ST3 { V6.2D, V7.2D, V8.2D }, [X2], X6
    LD3 { V21.2D, V22.2D, V23.2D }, [X2], X6
    ADD  X2, X2, X5
    ST3 { V25.4S, V26.4S, V27.4S }, [X2], X6
    LD3 { V14.4S, V15.4S, V16.4S }, [X2], X6
    ADD  X2, X2, X5, ASR #0
    ST3 { V10.8H, V11.8H, V12.8H }, [X2], X6
    LD3 { V30.8H, V31.8H, V0.8H }, [X2], X6
    ADD  X2, X2, X5, LSR #0
    ST3 { V31.8B, V0.8B, V1.8B }, [X2], X6
    LD3 { V15.2S, V16.2S, V17.2S }, [X2], X6
    ADD  X2, X2, X5, LSR #0
    ST3 { V26.2S, V27.2S, V28.2S }, [X2], X6
    LD3 { V10.2S, V11.2S, V12.2S }, [X2], X6
    ADD  X2, X2, X5
    ST3 { V28.4H, V29.4H, V30.4H }, [X2], X6
    LD3 { V14.4H, V15.4H, V16.4H }, [X2], X6
    ADD  X2, X2, X5, ASR #0
    ST3 { V10.8B, V11.8B, V12.8B }, [X2], X6
    LD3 { V1.8B, V2.8B, V3.8B }, [X2], X6
    ADD  X2, X2, X5, LSR #0
    ST3 { V28.H, V29.H, V30.H }[0x3], [X2]
    LD3 { V30.H, V31.H, V0.H }[0x7], [X2]
    ADD  X2, X2, X5, LSR #0
    ST3 { V19.S, V20.S, V21.S }[0x1], [X2]
    LD3 { V26.S, V27.S, V28.S }[0x1], [X2]
    ADD  X2, X2, X5
    ST3 { V5.D, V6.D, V7.D }[0x0], [X2]
    LD3 { V10.D, V11.D, V12.D }[0x0], [X2]
    ADD  X2, X2, X5, LSR #0
    ST3 { V15.B, V16.B, V17.B }[0xa], [X2]
    LD3 { V3.B, V4.B, V5.B }[0x3], [X2]
    ADD  X2, X2, X5
    MOV  X12, X2
    ST3 { V30.H, V31.H, V0.H }[0x0], [X12], #6
    MOV  X12, X2
    LD3 { V15.H, V16.H, V17.H }[0x6], [X12], #6
    ADD  X2, X2, X5, LSR #0
    ST3 { V0.H, V1.H, V2.H }[0x0], [X2], X6
    LD3 { V17.H, V18.H, V19.H }[0x0], [X2], X6
    ADD  X2, X2, X5
    MOV  X12, X2
    ST3 { V0.S, V1.S, V2.S }[0x0], [X12], #12
    MOV  X12, X2
    LD3 { V30.S, V31.S, V0.S }[0x3], [X12], #12
    ADD  X2, X2, X5, ASR #0
    ST3 { V10.S, V11.S, V12.S }[0x1], [X2], X6
    LD3 { V18.S, V19.S, V20.S }[0x0], [X2], X6
    ADD  X2, X2, X5, LSR #0
    MOV  X12, X2
    ST3 { V3.D, V4.D, V5.D }[0x0], [X12], #24
    MOV  X12, X2
    LD3 { V2.D, V3.D, V4.D }[0x0], [X12], #24
    ADD  X2, X2, X5, ASR #0
    ST3 { V23.D, V24.D, V25.D }[0x0], [X2], X6
    LD3 { V6.D, V7.D, V8.D }[0x1], [X2], X6
    ADD  X2, X2, X5
    MOV  X12, X2
    ST3 { V17.B, V18.B, V19.B }[0x3], [X12], #3
    MOV  X12, X2
    LD3 { V5.B, V6.B, V7.B }[0x3], [X12], #3
    ADD  X2, X2, X5
    ST3 { V22.B, V23.B, V24.B }[0x8], [X2], X6
    LD3 { V23.B, V24.B, V25.B }[0x1], [X2], X6
    ADD  X2, X2, X5
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X16, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP06_TestFail
    MRS  X8, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D1
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D2
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D3
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D4
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D5
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D6
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D7
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D8
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D9
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D10
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D11
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D12
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D13
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D14
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a5a, LSL #32
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D15
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a5a, LSL #32
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D16
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a5a, LSL #32
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D17
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D18
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D19
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D20
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D21
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D22
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D23
    MOVZ  X16, #0x5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D24
    MOVZ  X16, #0x5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D25
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D26
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D27
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D28
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D29
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D30
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D31
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
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
    FMOV  D0, X11
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X7
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X10
    FMOV  D4, X11
    FMOV  V4.D[1], X4
    FMOV  D5, X26
    FMOV  V5.D[1], X10
    FMOV  D6, X3
    FMOV  V6.D[1], X26
    FMOV  D7, X15
    FMOV  V7.D[1], X27
    FMOV  D8, X6
    FMOV  V8.D[1], X5
    FMOV  D9, X9
    FMOV  V9.D[1], X24
    FMOV  D10, X4
    FMOV  V10.D[1], X3
    FMOV  D11, X10
    FMOV  V11.D[1], X9
    FMOV  D12, X15
    FMOV  V12.D[1], X26
    FMOV  D13, X11
    FMOV  V13.D[1], X25
    FMOV  D14, X14
    FMOV  V14.D[1], X14
    FMOV  D15, X15
    FMOV  V15.D[1], X17
    FMOV  D16, X8
    FMOV  V16.D[1], X25
    FMOV  D17, X2
    FMOV  V17.D[1], X25
    FMOV  D18, X5
    FMOV  V18.D[1], X17
    FMOV  D19, X26
    FMOV  V19.D[1], X24
    FMOV  D20, X7
    FMOV  V20.D[1], X2
    FMOV  D21, X9
    FMOV  V21.D[1], X11
    FMOV  D22, X2
    FMOV  V22.D[1], X24
    FMOV  D23, X17
    FMOV  V23.D[1], X25
    FMOV  D24, X4
    FMOV  V24.D[1], X10
    FMOV  D25, X24
    FMOV  V25.D[1], X3
    FMOV  D26, X26
    FMOV  V26.D[1], X24
    FMOV  D27, X15
    FMOV  V27.D[1], X5
    FMOV  D28, X23
    FMOV  V28.D[1], X15
    FMOV  D29, X11
    FMOV  V29.D[1], X29
    FMOV  D30, X27
    FMOV  V30.D[1], X11
    FMOV  D31, X17
    FMOV  V31.D[1], X23
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X26, #0x2300, LSL #0
    ADD  X2, X30, X26, LSR #0
    ST3 { V25.4S, V26.4S, V27.4S }, [X2]
    LD3 { V16.2D, V17.2D, V18.2D }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V2.16B, V3.16B, V4.16B }, [X2]
    LD3 { V29.16B, V30.16B, V31.16B }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST3 { V28.2D, V29.2D, V30.2D }, [X2]
    LD3 { V30.2D, V31.2D, V0.2D }, [X2]
    ADD  X2, X2, X4
    ST3 { V30.4S, V31.4S, V0.4S }, [X2]
    LD3 { V14.4S, V15.4S, V16.4S }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST3 { V0.8H, V1.8H, V2.8H }, [X2]
    LD3 { V9.8H, V10.8H, V11.8H }, [X2]
    ADD  X2, X2, X4
    ST3 { V15.8B, V16.8B, V17.8B }, [X2]
    LD3 { V15.8B, V16.8B, V17.8B }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V27.2S, V28.2S, V29.2S }, [X2]
    LD3 { V30.2S, V31.2S, V0.2S }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V12.4H, V13.4H, V14.4H }, [X2]
    LD3 { V12.4H, V13.4H, V14.4H }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST3 { V18.8B, V19.8B, V20.8B }, [X2]
    LD3 { V18.8B, V19.8B, V20.8B }, [X2]
    ADD  X2, X2, X4, ASR #0
    MOV  X5, X2
    ST3 { V9.2D, V10.2D, V11.2D }, [X5], #48
    MOV  X5, X2
    LD3 { V9.16B, V10.16B, V11.16B }, [X5], #48
    ADD  X2, X2, X4
    MOV  X5, X2
    ST3 { V13.16B, V14.16B, V15.16B }, [X5], #48
    MOV  X5, X2
    LD3 { V2.16B, V3.16B, V4.16B }, [X5], #48
    ADD  X2, X2, X4, ASR #0
    MOV  X5, X2
    ST3 { V30.2D, V31.2D, V0.2D }, [X5], #48
    MOV  X5, X2
    LD3 { V13.2D, V14.2D, V15.2D }, [X5], #48
    ADD  X2, X2, X4, LSR #0
    MOV  X5, X2
    ST3 { V30.4S, V31.4S, V0.4S }, [X5], #48
    MOV  X5, X2
    LD3 { V18.4S, V19.4S, V20.4S }, [X5], #48
    ADD  X2, X2, X4, LSR #0
    MOV  X5, X2
    ST3 { V16.8H, V17.8H, V18.8H }, [X5], #48
    MOV  X5, X2
    LD3 { V16.8H, V17.8H, V18.8H }, [X5], #48
    ADD  X2, X2, X4, LSR #0
    MOV  X5, X2
    ST3 { V13.4H, V14.4H, V15.4H }, [X5], #24
    MOV  X5, X2
    LD3 { V19.2S, V20.2S, V21.2S }, [X5], #24
    ADD  X2, X2, X4, ASR #0
    MOV  X5, X2
    ST3 { V17.2S, V18.2S, V19.2S }, [X5], #24
    MOV  X5, X2
    LD3 { V20.2S, V21.2S, V22.2S }, [X5], #24
    ADD  X2, X2, X4
    MOV  X5, X2
    ST3 { V1.4H, V2.4H, V3.4H }, [X5], #24
    MOV  X5, X2
    LD3 { V1.4H, V2.4H, V3.4H }, [X5], #24
    ADD  X2, X2, X4, ASR #0
    MOV  X5, X2
    ST3 { V1.8B, V2.8B, V3.8B }, [X5], #24
    MOV  X5, X2
    LD3 { V22.8B, V23.8B, V24.8B }, [X5], #24
    ADD  X2, X2, X4, ASR #0
    ST3 { V21.4S, V22.4S, V23.4S }, [X2], X3
    LD3 { V14.4S, V15.4S, V16.4S }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V17.16B, V18.16B, V19.16B }, [X2], X3
    LD3 { V7.16B, V8.16B, V9.16B }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V7.2D, V8.2D, V9.2D }, [X2], X3
    LD3 { V21.2D, V22.2D, V23.2D }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V22.4S, V23.4S, V24.4S }, [X2], X3
    LD3 { V22.4S, V23.4S, V24.4S }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V21.8H, V22.8H, V23.8H }, [X2], X3
    LD3 { V23.8H, V24.8H, V25.8H }, [X2], X3
    ADD  X2, X2, X4
    ST3 { V23.2S, V24.2S, V25.2S }, [X2], X3
    LD3 { V17.8B, V18.8B, V19.8B }, [X2], X3
    ADD  X2, X2, X4, LSR #0
    ST3 { V17.2S, V18.2S, V19.2S }, [X2], X3
    LD3 { V23.2S, V24.2S, V25.2S }, [X2], X3
    ADD  X2, X2, X4, ASR #0
    ST3 { V14.4H, V15.4H, V16.4H }, [X2], X3
    LD3 { V14.4H, V15.4H, V16.4H }, [X2], X3
    ADD  X2, X2, X4
    ST3 { V17.8B, V18.8B, V19.8B }, [X2], X3
    LD3 { V4.8B, V5.8B, V6.8B }, [X2], X3
    ADD  X2, X2, X4, ASR #0
    ST3 { V4.H, V5.H, V6.H }[0x0], [X2]
    LD3 { V7.H, V8.H, V9.H }[0x5], [X2]
    ADD  X2, X2, X4, LSR #0
    ST3 { V5.S, V6.S, V7.S }[0x2], [X2]
    LD3 { V6.S, V7.S, V8.S }[0x2], [X2]
    ADD  X2, X2, X4
    ST3 { V7.D, V8.D, V9.D }[0x1], [X2]
    LD3 { V7.D, V8.D, V9.D }[0x1], [X2]
    ADD  X2, X2, X4, LSR #0
    ST3 { V23.B, V24.B, V25.B }[0x3], [X2]
    LD3 { V17.B, V18.B, V19.B }[0x9], [X2]
    ADD  X2, X2, X4
    MOV  X5, X2
    ST3 { V16.H, V17.H, V18.H }[0x0], [X5], #6
    MOV  X5, X2
    LD3 { V16.H, V17.H, V18.H }[0x6], [X5], #6
    ADD  X2, X2, X4, LSR #0
    ST3 { V17.H, V18.H, V19.H }[0x2], [X2], X3
    LD3 { V21.H, V22.H, V23.H }[0x4], [X2], X3
    ADD  X2, X2, X4, LSR #0
    MOV  X5, X2
    ST3 { V25.S, V26.S, V27.S }[0x1], [X5], #12
    MOV  X5, X2
    LD3 { V15.S, V16.S, V17.S }[0x0], [X5], #12
    ADD  X2, X2, X4, ASR #0
    ST3 { V7.S, V8.S, V9.S }[0x1], [X2], X3
    LD3 { V24.S, V25.S, V26.S }[0x1], [X2], X3
    ADD  X2, X2, X4
    MOV  X5, X2
    ST3 { V13.D, V14.D, V15.D }[0x0], [X5], #24
    MOV  X5, X2
    LD3 { V13.D, V14.D, V15.D }[0x0], [X5], #24
    ADD  X2, X2, X4, ASR #0
    ST3 { V31.D, V0.D, V1.D }[0x0], [X2], X3
    LD3 { V7.D, V8.D, V9.D }[0x1], [X2], X3
    ADD  X2, X2, X4, LSR #0
    MOV  X5, X2
    ST3 { V21.B, V22.B, V23.B }[0xe], [X5], #3
    MOV  X5, X2
    LD3 { V1.B, V2.B, V3.B }[0x7], [X5], #3
    ADD  X2, X2, X4
    ST3 { V15.B, V16.B, V17.B }[0xf], [X2], X3
    LD3 { V15.B, V16.B, V17.B }[0x0], [X2], X3
    ADD  X2, X2, X4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X6, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP06_TestFail
    MRS  X29, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D1
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D2
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D3
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D4
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D5
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D6
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D7
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D8
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D9
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D10
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D11
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D12
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D13
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D14
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D15
    MOVZ  X6, #0xa500, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xa5a5, LSL #32
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D16
    MOVZ  X6, #0xa500, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X6, #0xa500, LSL #0
    MOVK  X6, #0xa5a5, LSL #32
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D17
    MOVZ  X6, #0xa500, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X6, #0xa500, LSL #0
    MOVK  X6, #0xa5a5, LSL #32
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D18
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X6, #0xa500, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D19
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D20
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D21
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D22
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D23
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D24
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D25
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D26
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D27
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D28
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D29
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D30
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    FMOV  X29, D31
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X29
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
    FMOV  D0, X2
    FMOV  V0.D[1], X14
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X9
    FMOV  V2.D[1], X28
    FMOV  D3, X11
    FMOV  V3.D[1], X24
    FMOV  D4, X27
    FMOV  V4.D[1], X11
    FMOV  D5, X3
    FMOV  V5.D[1], X29
    FMOV  D6, X6
    FMOV  V6.D[1], X28
    FMOV  D7, X16
    FMOV  V7.D[1], X27
    FMOV  D8, X15
    FMOV  V8.D[1], X17
    FMOV  D9, X9
    FMOV  V9.D[1], X14
    FMOV  D10, X5
    FMOV  V10.D[1], X27
    FMOV  D11, X17
    FMOV  V11.D[1], X29
    FMOV  D12, X7
    FMOV  V12.D[1], X28
    FMOV  D13, X25
    FMOV  V13.D[1], X25
    FMOV  D14, X3
    FMOV  V14.D[1], X11
    FMOV  D15, X27
    FMOV  V15.D[1], X24
    FMOV  D16, X12
    FMOV  V16.D[1], X8
    FMOV  D17, X12
    FMOV  V17.D[1], X3
    FMOV  D18, X13
    FMOV  V18.D[1], X2
    FMOV  D19, X3
    FMOV  V19.D[1], X24
    FMOV  D20, X16
    FMOV  V20.D[1], X17
    FMOV  D21, X6
    FMOV  V21.D[1], X4
    FMOV  D22, X10
    FMOV  V22.D[1], X17
    FMOV  D23, X9
    FMOV  V23.D[1], X25
    FMOV  D24, X28
    FMOV  V24.D[1], X13
    FMOV  D25, X3
    FMOV  V25.D[1], X13
    FMOV  D26, X6
    FMOV  V26.D[1], X24
    FMOV  D27, X14
    FMOV  V27.D[1], X15
    FMOV  D28, X9
    FMOV  V28.D[1], X8
    FMOV  D29, X11
    FMOV  V29.D[1], X17
    FMOV  D30, X26
    FMOV  V30.D[1], X17
    FMOV  D31, X17
    FMOV  V31.D[1], X17
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X5, #0x2800, LSL #0
    ADD  X25, X30, X5, ASR #0
    ST3 { V19.16B, V20.16B, V21.16B }, [X25]
    LD3 { V15.8H, V16.8H, V17.8H }, [X25]
    ADD  X25, X25, X11, LSR #0
    ST3 { V30.16B, V31.16B, V0.16B }, [X25]
    LD3 { V8.16B, V9.16B, V10.16B }, [X25]
    ADD  X25, X25, X11, ASR #0
    ST3 { V8.2D, V9.2D, V10.2D }, [X25]
    LD3 { V0.2D, V1.2D, V2.2D }, [X25]
    ADD  X25, X25, X11, LSR #0
    ST3 { V29.4S, V30.4S, V31.4S }, [X25]
    LD3 { V31.4S, V0.4S, V1.4S }, [X25]
    ADD  X25, X25, X11, LSR #0
    ST3 { V15.8H, V16.8H, V17.8H }, [X25]
    LD3 { V9.8H, V10.8H, V11.8H }, [X25]
    ADD  X25, X25, X11
    ST3 { V9.2S, V10.2S, V11.2S }, [X25]
    LD3 { V3.4H, V4.4H, V5.4H }, [X25]
    ADD  X25, X25, X11, LSR #0
    ST3 { V10.2S, V11.2S, V12.2S }, [X25]
    LD3 { V14.2S, V15.2S, V16.2S }, [X25]
    ADD  X25, X25, X11
    ST3 { V30.4H, V31.4H, V0.4H }, [X25]
    LD3 { V26.4H, V27.4H, V28.4H }, [X25]
    ADD  X25, X25, X11, ASR #0
    ST3 { V14.8B, V15.8B, V16.8B }, [X25]
    LD3 { V10.8B, V11.8B, V12.8B }, [X25]
    ADD  X25, X25, X11, ASR #0
    MOV  X16, X25
    ST3 { V3.4S, V4.4S, V5.4S }, [X16], #48
    MOV  X16, X25
    LD3 { V3.8H, V4.8H, V5.8H }, [X16], #48
    ADD  X25, X25, X11
    MOV  X16, X25
    ST3 { V5.16B, V6.16B, V7.16B }, [X16], #48
    MOV  X16, X25
    LD3 { V1.16B, V2.16B, V3.16B }, [X16], #48
    ADD  X25, X25, X11, LSR #0
    MOV  X16, X25
    ST3 { V0.2D, V1.2D, V2.2D }, [X16], #48
    MOV  X16, X25
    LD3 { V0.2D, V1.2D, V2.2D }, [X16], #48
    ADD  X25, X25, X11
    MOV  X16, X25
    ST3 { V10.4S, V11.4S, V12.4S }, [X16], #48
    MOV  X16, X25
    LD3 { V5.4S, V6.4S, V7.4S }, [X16], #48
    ADD  X25, X25, X11, LSR #0
    MOV  X16, X25
    ST3 { V13.8H, V14.8H, V15.8H }, [X16], #48
    MOV  X16, X25
    LD3 { V4.8H, V5.8H, V6.8H }, [X16], #48
    ADD  X25, X25, X11, LSR #0
    MOV  X16, X25
    ST3 { V11.8B, V12.8B, V13.8B }, [X16], #24
    MOV  X16, X25
    LD3 { V11.2S, V12.2S, V13.2S }, [X16], #24
    ADD  X25, X25, X11, ASR #0
    MOV  X16, X25
    ST3 { V0.2S, V1.2S, V2.2S }, [X16], #24
    MOV  X16, X25
    LD3 { V16.2S, V17.2S, V18.2S }, [X16], #24
    ADD  X25, X25, X11, LSR #0
    MOV  X16, X25
    ST3 { V30.4H, V31.4H, V0.4H }, [X16], #24
    MOV  X16, X25
    LD3 { V31.4H, V0.4H, V1.4H }, [X16], #24
    ADD  X25, X25, X11, LSR #0
    MOV  X16, X25
    ST3 { V7.8B, V8.8B, V9.8B }, [X16], #24
    MOV  X16, X25
    LD3 { V7.8B, V8.8B, V9.8B }, [X16], #24
    ADD  X25, X25, X11, LSR #0
    ST3 { V29.2D, V30.2D, V31.2D }, [X25], X15
    LD3 { V11.16B, V12.16B, V13.16B }, [X25], X15
    ADD  X25, X25, X11, LSR #0
    ST3 { V9.16B, V10.16B, V11.16B }, [X25], X15
    LD3 { V9.16B, V10.16B, V11.16B }, [X25], X15
    ADD  X25, X25, X11
    ST3 { V11.2D, V12.2D, V13.2D }, [X25], X15
    LD3 { V3.2D, V4.2D, V5.2D }, [X25], X15
    ADD  X25, X25, X11, LSR #0
    ST3 { V7.4S, V8.4S, V9.4S }, [X25], X15
    LD3 { V24.4S, V25.4S, V26.4S }, [X25], X15
    ADD  X25, X25, X11, LSR #0
    ST3 { V3.8H, V4.8H, V5.8H }, [X25], X15
    LD3 { V3.8H, V4.8H, V5.8H }, [X25], X15
    ADD  X25, X25, X11
    ST3 { V25.2S, V26.2S, V27.2S }, [X25], X15
    LD3 { V7.8B, V8.8B, V9.8B }, [X25], X15
    ADD  X25, X25, X11, LSR #0
    ST3 { V31.2S, V0.2S, V1.2S }, [X25], X15
    LD3 { V16.2S, V17.2S, V18.2S }, [X25], X15
    ADD  X25, X25, X11, LSR #0
    ST3 { V3.4H, V4.4H, V5.4H }, [X25], X15
    LD3 { V16.4H, V17.4H, V18.4H }, [X25], X15
    ADD  X25, X25, X11, ASR #0
    ST3 { V19.8B, V20.8B, V21.8B }, [X25], X15
    LD3 { V11.8B, V12.8B, V13.8B }, [X25], X15
    ADD  X25, X25, X11, LSR #0
    ST3 { V2.H, V3.H, V4.H }[0x6], [X25]
    LD3 { V1.H, V2.H, V3.H }[0x5], [X25]
    ADD  X25, X25, X11
    ST3 { V13.S, V14.S, V15.S }[0x2], [X25]
    LD3 { V26.S, V27.S, V28.S }[0x0], [X25]
    ADD  X25, X25, X11, LSR #0
    ST3 { V1.D, V2.D, V3.D }[0x0], [X25]
    LD3 { V0.D, V1.D, V2.D }[0x1], [X25]
    ADD  X25, X25, X11, LSR #0
    ST3 { V7.B, V8.B, V9.B }[0xa], [X25]
    LD3 { V19.B, V20.B, V21.B }[0xb], [X25]
    ADD  X25, X25, X11, ASR #0
    MOV  X16, X25
    ST3 { V26.H, V27.H, V28.H }[0x7], [X16], #6
    MOV  X16, X25
    LD3 { V13.H, V14.H, V15.H }[0x4], [X16], #6
    ADD  X25, X25, X11, LSR #0
    ST3 { V21.H, V22.H, V23.H }[0x3], [X25], X15
    LD3 { V7.H, V8.H, V9.H }[0x2], [X25], X15
    ADD  X25, X25, X11, ASR #0
    MOV  X16, X25
    ST3 { V3.S, V4.S, V5.S }[0x2], [X16], #12
    MOV  X16, X25
    LD3 { V30.S, V31.S, V0.S }[0x3], [X16], #12
    ADD  X25, X25, X11
    ST3 { V14.S, V15.S, V16.S }[0x0], [X25], X15
    LD3 { V21.S, V22.S, V23.S }[0x1], [X25], X15
    ADD  X25, X25, X11, ASR #0
    MOV  X16, X25
    ST3 { V26.D, V27.D, V28.D }[0x1], [X16], #24
    MOV  X16, X25
    LD3 { V3.D, V4.D, V5.D }[0x1], [X16], #24
    ADD  X25, X25, X11
    ST3 { V11.D, V12.D, V13.D }[0x1], [X25], X15
    LD3 { V13.D, V14.D, V15.D }[0x1], [X25], X15
    ADD  X25, X25, X11, ASR #0
    MOV  X16, X25
    ST3 { V17.B, V18.B, V19.B }[0x8], [X16], #3
    MOV  X16, X25
    LD3 { V16.B, V17.B, V18.B }[0xa], [X16], #3
    ADD  X25, X25, X11, ASR #0
    ST3 { V21.B, V22.B, V23.B }[0x1], [X25], X15
    LD3 { V26.B, V27.B, V28.B }[0x2], [X25], X15
    ADD  X25, X25, X11, ASR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MRS  X28, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a, LSL #16
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D26
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D27
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D28
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X28, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X23, X29, X28
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
    FMOV  V0.D[1], X7
    FMOV  D1, X10
    FMOV  V1.D[1], X4
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X29
    FMOV  V4.D[1], X14
    FMOV  D5, X9
    FMOV  V5.D[1], X8
    FMOV  D6, X17
    FMOV  V6.D[1], X13
    FMOV  D7, X13
    FMOV  V7.D[1], X16
    FMOV  D8, X17
    FMOV  V8.D[1], X5
    FMOV  D9, X28
    FMOV  V9.D[1], X11
    FMOV  D10, X9
    FMOV  V10.D[1], X3
    FMOV  D11, X15
    FMOV  V11.D[1], X17
    FMOV  D12, X9
    FMOV  V12.D[1], X17
    FMOV  D13, X9
    FMOV  V13.D[1], X14
    FMOV  D14, X15
    FMOV  V14.D[1], X6
    FMOV  D15, X14
    FMOV  V15.D[1], X3
    FMOV  D16, X25
    FMOV  V16.D[1], X9
    FMOV  D17, X27
    FMOV  V17.D[1], X15
    FMOV  D18, X12
    FMOV  V18.D[1], X16
    FMOV  D19, X7
    FMOV  V19.D[1], X13
    FMOV  D20, X27
    FMOV  V20.D[1], X4
    FMOV  D21, X28
    FMOV  V21.D[1], X10
    FMOV  D22, X10
    FMOV  V22.D[1], X7
    FMOV  D23, X13
    FMOV  V23.D[1], X13
    FMOV  D24, X12
    FMOV  V24.D[1], X17
    FMOV  D25, X11
    FMOV  V25.D[1], X6
    FMOV  D26, X9
    FMOV  V26.D[1], X10
    FMOV  D27, X14
    FMOV  V27.D[1], X4
    FMOV  D28, X5
    FMOV  V28.D[1], X14
    FMOV  D29, X12
    FMOV  V29.D[1], X28
    FMOV  D30, X3
    FMOV  V30.D[1], X6
    FMOV  D31, X5
    FMOV  V31.D[1], X6
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X4, #0x2d00, LSL #0
    ADD  X28, X30, X4
    ST3 { V28.8H, V29.8H, V30.8H }, [X28]
    LD3 { V10.4S, V11.4S, V12.4S }, [X28]
    ADD  X28, X28, X5, ASR #0
    ST3 { V23.16B, V24.16B, V25.16B }, [X28]
    LD3 { V14.16B, V15.16B, V16.16B }, [X28]
    ADD  X28, X28, X5, ASR #0
    ST3 { V23.2D, V24.2D, V25.2D }, [X28]
    LD3 { V3.2D, V4.2D, V5.2D }, [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V26.4S, V27.4S, V28.4S }, [X28]
    LD3 { V30.4S, V31.4S, V0.4S }, [X28]
    ADD  X28, X28, X5, ASR #0
    ST3 { V21.8H, V22.8H, V23.8H }, [X28]
    LD3 { V22.8H, V23.8H, V24.8H }, [X28]
    ADD  X28, X28, X5
    ST3 { V30.4H, V31.4H, V0.4H }, [X28]
    LD3 { V21.2S, V22.2S, V23.2S }, [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V3.2S, V4.2S, V5.2S }, [X28]
    LD3 { V9.2S, V10.2S, V11.2S }, [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V13.4H, V14.4H, V15.4H }, [X28]
    LD3 { V0.4H, V1.4H, V2.4H }, [X28]
    ADD  X28, X28, X5
    ST3 { V12.8B, V13.8B, V14.8B }, [X28]
    LD3 { V17.8B, V18.8B, V19.8B }, [X28]
    ADD  X28, X28, X5, LSR #0
    MOV  X16, X28
    ST3 { V22.2D, V23.2D, V24.2D }, [X16], #48
    MOV  X16, X28
    LD3 { V3.16B, V4.16B, V5.16B }, [X16], #48
    ADD  X28, X28, X5
    MOV  X16, X28
    ST3 { V1.16B, V2.16B, V3.16B }, [X16], #48
    MOV  X16, X28
    LD3 { V12.16B, V13.16B, V14.16B }, [X16], #48
    ADD  X28, X28, X5
    MOV  X16, X28
    ST3 { V5.2D, V6.2D, V7.2D }, [X16], #48
    MOV  X16, X28
    LD3 { V22.2D, V23.2D, V24.2D }, [X16], #48
    ADD  X28, X28, X5, ASR #0
    MOV  X16, X28
    ST3 { V23.4S, V24.4S, V25.4S }, [X16], #48
    MOV  X16, X28
    LD3 { V5.4S, V6.4S, V7.4S }, [X16], #48
    ADD  X28, X28, X5
    MOV  X16, X28
    ST3 { V5.8H, V6.8H, V7.8H }, [X16], #48
    MOV  X16, X28
    LD3 { V17.8H, V18.8H, V19.8H }, [X16], #48
    ADD  X28, X28, X5, ASR #0
    MOV  X16, X28
    ST3 { V28.2S, V29.2S, V30.2S }, [X16], #24
    MOV  X16, X28
    LD3 { V28.4H, V29.4H, V30.4H }, [X16], #24
    ADD  X28, X28, X5
    MOV  X16, X28
    ST3 { V28.2S, V29.2S, V30.2S }, [X16], #24
    MOV  X16, X28
    LD3 { V23.2S, V24.2S, V25.2S }, [X16], #24
    ADD  X28, X28, X5, ASR #0
    MOV  X16, X28
    ST3 { V25.4H, V26.4H, V27.4H }, [X16], #24
    MOV  X16, X28
    LD3 { V19.4H, V20.4H, V21.4H }, [X16], #24
    ADD  X28, X28, X5, LSR #0
    MOV  X16, X28
    ST3 { V19.8B, V20.8B, V21.8B }, [X16], #24
    MOV  X16, X28
    LD3 { V11.8B, V12.8B, V13.8B }, [X16], #24
    ADD  X28, X28, X5
    ST3 { V6.2D, V7.2D, V8.2D }, [X28], X15
    LD3 { V13.4S, V14.4S, V15.4S }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V2.16B, V3.16B, V4.16B }, [X28], X15
    LD3 { V28.16B, V29.16B, V30.16B }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V13.2D, V14.2D, V15.2D }, [X28], X15
    LD3 { V30.2D, V31.2D, V0.2D }, [X28], X15
    ADD  X28, X28, X5, ASR #0
    ST3 { V30.4S, V31.4S, V0.4S }, [X28], X15
    LD3 { V13.4S, V14.4S, V15.4S }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V18.8H, V19.8H, V20.8H }, [X28], X15
    LD3 { V18.8H, V19.8H, V20.8H }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V18.4H, V19.4H, V20.4H }, [X28], X15
    LD3 { V6.8B, V7.8B, V8.8B }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V12.2S, V13.2S, V14.2S }, [X28], X15
    LD3 { V28.2S, V29.2S, V30.2S }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V6.4H, V7.4H, V8.4H }, [X28], X15
    LD3 { V18.4H, V19.4H, V20.4H }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V28.8B, V29.8B, V30.8B }, [X28], X15
    LD3 { V14.8B, V15.8B, V16.8B }, [X28], X15
    ADD  X28, X28, X5
    ST3 { V3.H, V4.H, V5.H }[0x4], [X28]
    LD3 { V27.H, V28.H, V29.H }[0x1], [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V27.S, V28.S, V29.S }[0x2], [X28]
    LD3 { V28.S, V29.S, V30.S }[0x0], [X28]
    ADD  X28, X28, X5, ASR #0
    ST3 { V18.D, V19.D, V20.D }[0x0], [X28]
    LD3 { V12.D, V13.D, V14.D }[0x1], [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V22.B, V23.B, V24.B }[0xd], [X28]
    LD3 { V4.B, V5.B, V6.B }[0x2], [X28]
    ADD  X28, X28, X5, ASR #0
    MOV  X16, X28
    ST3 { V13.H, V14.H, V15.H }[0x0], [X16], #6
    MOV  X16, X28
    LD3 { V18.H, V19.H, V20.H }[0x0], [X16], #6
    ADD  X28, X28, X5, ASR #0
    ST3 { V18.H, V19.H, V20.H }[0x3], [X28], X15
    LD3 { V29.H, V30.H, V31.H }[0x7], [X28], X15
    ADD  X28, X28, X5, LSR #0
    MOV  X16, X28
    ST3 { V1.S, V2.S, V3.S }[0x3], [X16], #12
    MOV  X16, X28
    LD3 { V1.S, V2.S, V3.S }[0x2], [X16], #12
    ADD  X28, X28, X5
    ST3 { V14.S, V15.S, V16.S }[0x3], [X28], X15
    LD3 { V22.S, V23.S, V24.S }[0x3], [X28], X15
    ADD  X28, X28, X5, ASR #0
    MOV  X16, X28
    ST3 { V22.D, V23.D, V24.D }[0x0], [X16], #24
    MOV  X16, X28
    LD3 { V26.D, V27.D, V28.D }[0x0], [X16], #24
    ADD  X28, X28, X5
    ST3 { V18.D, V19.D, V20.D }[0x0], [X28], X15
    LD3 { V14.D, V15.D, V16.D }[0x0], [X28], X15
    ADD  X28, X28, X5
    MOV  X16, X28
    ST3 { V24.B, V25.B, V26.B }[0x1], [X16], #3
    MOV  X16, X28
    LD3 { V22.B, V23.B, V24.B }[0xf], [X16], #3
    ADD  X28, X28, X5, LSR #0
    ST3 { V22.B, V23.B, V24.B }[0x5], [X28], X15
    LD3 { V18.B, V19.B, V20.B }[0xf], [X28], X15
    ADD  X28, X28, X5, ASR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MRS  X8, FPSR
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D1
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D2
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D3
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa500, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D4
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D5
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa500, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D6
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa500, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D7
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D8
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D9
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D10
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D11
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D12
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D13
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D14
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D15
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D16
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D17
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa500, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D18
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa500, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D19
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa500, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D20
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D21
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D22
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa500, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D23
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa500, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D24
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D25
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D26
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D27
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D28
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D29
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D30
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X8, D31
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X9
    FMOV  V1.D[1], X16
    FMOV  D2, X23
    FMOV  V2.D[1], X28
    FMOV  D3, X5
    FMOV  V3.D[1], X9
    FMOV  D4, X5
    FMOV  V4.D[1], X17
    FMOV  D5, X28
    FMOV  V5.D[1], X10
    FMOV  D6, X3
    FMOV  V6.D[1], X23
    FMOV  D7, X17
    FMOV  V7.D[1], X17
    FMOV  D8, X8
    FMOV  V8.D[1], X15
    FMOV  D9, X26
    FMOV  V9.D[1], X25
    FMOV  D10, X2
    FMOV  V10.D[1], X27
    FMOV  D11, X7
    FMOV  V11.D[1], X3
    FMOV  D12, X24
    FMOV  V12.D[1], X7
    FMOV  D13, X4
    FMOV  V13.D[1], X26
    FMOV  D14, X3
    FMOV  V14.D[1], X2
    FMOV  D15, X13
    FMOV  V15.D[1], X9
    FMOV  D16, X15
    FMOV  V16.D[1], X4
    FMOV  D17, X10
    FMOV  V17.D[1], X16
    FMOV  D18, X28
    FMOV  V18.D[1], X8
    FMOV  D19, X6
    FMOV  V19.D[1], X15
    FMOV  D20, X15
    FMOV  V20.D[1], X23
    FMOV  D21, X8
    FMOV  V21.D[1], X12
    FMOV  D22, X26
    FMOV  V22.D[1], X23
    FMOV  D23, X29
    FMOV  V23.D[1], X13
    FMOV  D24, X28
    FMOV  V24.D[1], X13
    FMOV  D25, X10
    FMOV  V25.D[1], X2
    FMOV  D26, X17
    FMOV  V26.D[1], X23
    FMOV  D27, X25
    FMOV  V27.D[1], X3
    FMOV  D28, X29
    FMOV  V28.D[1], X2
    FMOV  D29, X24
    FMOV  V29.D[1], X29
    FMOV  D30, X14
    FMOV  V30.D[1], X24
    FMOV  D31, X28
    FMOV  V31.D[1], X11
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X5, #0x0, LSL #0
    ADD  X9, X30, X5, LSR #0
    ST3 { V24.16B, V25.16B, V26.16B }, [X9]
    LD3 { V6.2D, V7.2D, V8.2D }, [X9]
    ADD  X9, X9, X12
    ST3 { V24.16B, V25.16B, V26.16B }, [X9]
    LD3 { V12.16B, V13.16B, V14.16B }, [X9]
    ADD  X9, X9, X12, LSR #0
    ST3 { V1.2D, V2.2D, V3.2D }, [X9]
    LD3 { V28.2D, V29.2D, V30.2D }, [X9]
    ADD  X9, X9, X12
    ST3 { V21.4S, V22.4S, V23.4S }, [X9]
    LD3 { V26.4S, V27.4S, V28.4S }, [X9]
    ADD  X9, X9, X12
    ST3 { V23.8H, V24.8H, V25.8H }, [X9]
    LD3 { V2.8H, V3.8H, V4.8H }, [X9]
    ADD  X9, X9, X12
    ST3 { V2.8B, V3.8B, V4.8B }, [X9]
    LD3 { V2.8B, V3.8B, V4.8B }, [X9]
    ADD  X9, X9, X12, ASR #0
    ST3 { V17.2S, V18.2S, V19.2S }, [X9]
    LD3 { V26.2S, V27.2S, V28.2S }, [X9]
    ADD  X9, X9, X12, ASR #0
    ST3 { V26.4H, V27.4H, V28.4H }, [X9]
    LD3 { V5.4H, V6.4H, V7.4H }, [X9]
    ADD  X9, X9, X12, ASR #0
    ST3 { V25.8B, V26.8B, V27.8B }, [X9]
    LD3 { V0.8B, V1.8B, V2.8B }, [X9]
    ADD  X9, X9, X12, ASR #0
    MOV  X25, X9
    ST3 { V4.4S, V5.4S, V6.4S }, [X25], #48
    MOV  X25, X9
    LD3 { V12.4S, V13.4S, V14.4S }, [X25], #48
    ADD  X9, X9, X12, ASR #0
    MOV  X25, X9
    ST3 { V0.16B, V1.16B, V2.16B }, [X25], #48
    MOV  X25, X9
    LD3 { V25.16B, V26.16B, V27.16B }, [X25], #48
    ADD  X9, X9, X12
    MOV  X25, X9
    ST3 { V4.2D, V5.2D, V6.2D }, [X25], #48
    MOV  X25, X9
    LD3 { V2.2D, V3.2D, V4.2D }, [X25], #48
    ADD  X9, X9, X12, ASR #0
    MOV  X25, X9
    ST3 { V15.4S, V16.4S, V17.4S }, [X25], #48
    MOV  X25, X9
    LD3 { V26.4S, V27.4S, V28.4S }, [X25], #48
    ADD  X9, X9, X12
    MOV  X25, X9
    ST3 { V25.8H, V26.8H, V27.8H }, [X25], #48
    MOV  X25, X9
    LD3 { V25.8H, V26.8H, V27.8H }, [X25], #48
    ADD  X9, X9, X12, ASR #0
    MOV  X25, X9
    ST3 { V26.8B, V27.8B, V28.8B }, [X25], #24
    MOV  X25, X9
    LD3 { V2.8B, V3.8B, V4.8B }, [X25], #24
    ADD  X9, X9, X12, LSR #0
    MOV  X25, X9
    ST3 { V2.2S, V3.2S, V4.2S }, [X25], #24
    MOV  X25, X9
    LD3 { V2.2S, V3.2S, V4.2S }, [X25], #24
    ADD  X9, X9, X12
    MOV  X25, X9
    ST3 { V26.4H, V27.4H, V28.4H }, [X25], #24
    MOV  X25, X9
    LD3 { V24.4H, V25.4H, V26.4H }, [X25], #24
    ADD  X9, X9, X12
    MOV  X25, X9
    ST3 { V26.8B, V27.8B, V28.8B }, [X25], #24
    MOV  X25, X9
    LD3 { V26.8B, V27.8B, V28.8B }, [X25], #24
    ADD  X9, X9, X12
    ST3 { V24.8H, V25.8H, V26.8H }, [X9], X28
    LD3 { V24.8H, V25.8H, V26.8H }, [X9], X28
    ADD  X9, X9, X12
    ST3 { V24.16B, V25.16B, V26.16B }, [X9], X28
    LD3 { V31.16B, V0.16B, V1.16B }, [X9], X28
    ADD  X9, X9, X12
    ST3 { V31.2D, V0.2D, V1.2D }, [X9], X28
    LD3 { V16.2D, V17.2D, V18.2D }, [X9], X28
    ADD  X9, X9, X12, LSR #0
    ST3 { V8.4S, V9.4S, V10.4S }, [X9], X28
    LD3 { V12.4S, V13.4S, V14.4S }, [X9], X28
    ADD  X9, X9, X12
    ST3 { V17.8H, V18.8H, V19.8H }, [X9], X28
    LD3 { V6.8H, V7.8H, V8.8H }, [X9], X28
    ADD  X9, X9, X12, LSR #0
    ST3 { V6.8B, V7.8B, V8.8B }, [X9], X28
    LD3 { V4.2S, V5.2S, V6.2S }, [X9], X28
    ADD  X9, X9, X12
    ST3 { V4.2S, V5.2S, V6.2S }, [X9], X28
    LD3 { V6.2S, V7.2S, V8.2S }, [X9], X28
    ADD  X9, X9, X12, ASR #0
    ST3 { V6.4H, V7.4H, V8.4H }, [X9], X28
    LD3 { V17.4H, V18.4H, V19.4H }, [X9], X28
    ADD  X9, X9, X12
    ST3 { V17.8B, V18.8B, V19.8B }, [X9], X28
    LD3 { V4.8B, V5.8B, V6.8B }, [X9], X28
    ADD  X9, X9, X12, ASR #0
    ST3 { V2.H, V3.H, V4.H }[0x2], [X9]
    LD3 { V7.H, V8.H, V9.H }[0x6], [X9]
    ADD  X9, X9, X12
    ST3 { V7.S, V8.S, V9.S }[0x3], [X9]
    LD3 { V17.S, V18.S, V19.S }[0x1], [X9]
    ADD  X9, X9, X12
    ST3 { V19.D, V20.D, V21.D }[0x0], [X9]
    LD3 { V19.D, V20.D, V21.D }[0x1], [X9]
    ADD  X9, X9, X12
    ST3 { V13.B, V14.B, V15.B }[0x6], [X9]
    LD3 { V7.B, V8.B, V9.B }[0xd], [X9]
    ADD  X9, X9, X12
    MOV  X25, X9
    ST3 { V3.H, V4.H, V5.H }[0x3], [X25], #6
    MOV  X25, X9
    LD3 { V12.H, V13.H, V14.H }[0x0], [X25], #6
    ADD  X9, X9, X12, ASR #0
    ST3 { V7.H, V8.H, V9.H }[0x6], [X9], X28
    LD3 { V16.H, V17.H, V18.H }[0x5], [X9], X28
    ADD  X9, X9, X12, LSR #0
    MOV  X25, X9
    ST3 { V12.S, V13.S, V14.S }[0x2], [X25], #12
    MOV  X25, X9
    LD3 { V5.S, V6.S, V7.S }[0x2], [X25], #12
    ADD  X9, X9, X12
    ST3 { V23.S, V24.S, V25.S }[0x0], [X9], X28
    LD3 { V12.S, V13.S, V14.S }[0x3], [X9], X28
    ADD  X9, X9, X12
    MOV  X25, X9
    ST3 { V12.D, V13.D, V14.D }[0x1], [X25], #24
    MOV  X25, X9
    LD3 { V29.D, V30.D, V31.D }[0x1], [X25], #24
    ADD  X9, X9, X12, LSR #0
    ST3 { V31.D, V0.D, V1.D }[0x1], [X9], X28
    LD3 { V23.D, V24.D, V25.D }[0x0], [X9], X28
    ADD  X9, X9, X12, ASR #0
    MOV  X25, X9
    ST3 { V23.B, V24.B, V25.B }[0x0], [X25], #3
    MOV  X25, X9
    LD3 { V12.B, V13.B, V14.B }[0xc], [X25], #3
    ADD  X9, X9, X12
    ST3 { V0.B, V1.B, V2.B }[0xb], [X9], X28
    LD3 { V23.B, V24.B, V25.B }[0xe], [X9], X28
    ADD  X9, X9, X12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X17, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MRS  X24, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D1
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D2
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D3
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D4
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D5
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D6
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D7
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D8
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D9
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D10
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D11
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D12
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a00, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D13
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a00, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D14
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D15
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D16
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D17
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D18
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D19
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D20
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D21
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D22
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a00, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D23
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D26
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D27
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D28
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D29
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D30
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D31
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
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
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X8
    FMOV  V2.D[1], X29
    FMOV  D3, X23
    FMOV  V3.D[1], X28
    FMOV  D4, X24
    FMOV  V4.D[1], X4
    FMOV  D5, X25
    FMOV  V5.D[1], X28
    FMOV  D6, X29
    FMOV  V6.D[1], X3
    FMOV  D7, X5
    FMOV  V7.D[1], X15
    FMOV  D8, X7
    FMOV  V8.D[1], X12
    FMOV  D9, X12
    FMOV  V9.D[1], X7
    FMOV  D10, X17
    FMOV  V10.D[1], X14
    FMOV  D11, X7
    FMOV  V11.D[1], X13
    FMOV  D12, X7
    FMOV  V12.D[1], X16
    FMOV  D13, X17
    FMOV  V13.D[1], X6
    FMOV  D14, X3
    FMOV  V14.D[1], X5
    FMOV  D15, X4
    FMOV  V15.D[1], X14
    FMOV  D16, X6
    FMOV  V16.D[1], X3
    FMOV  D17, X6
    FMOV  V17.D[1], X8
    FMOV  D18, X27
    FMOV  V18.D[1], X2
    FMOV  D19, X4
    FMOV  V19.D[1], X28
    FMOV  D20, X4
    FMOV  V20.D[1], X4
    FMOV  D21, X17
    FMOV  V21.D[1], X23
    FMOV  D22, X9
    FMOV  V22.D[1], X7
    FMOV  D23, X13
    FMOV  V23.D[1], X4
    FMOV  D24, X2
    FMOV  V24.D[1], X17
    FMOV  D25, X16
    FMOV  V25.D[1], X9
    FMOV  D26, X28
    FMOV  V26.D[1], X8
    FMOV  D27, X7
    FMOV  V27.D[1], X16
    FMOV  D28, X2
    FMOV  V28.D[1], X23
    FMOV  D29, X12
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X14
    FMOV  D31, X7
    FMOV  V31.D[1], X24
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X6, #0x500, LSL #0
    ADD  X28, X30, X6, LSR #0
    ST3 { V20.16B, V21.16B, V22.16B }, [X28]
    LD3 { V2.16B, V3.16B, V4.16B }, [X28]
    ADD  X28, X28, X3
    ST3 { V27.16B, V28.16B, V29.16B }, [X28]
    LD3 { V19.16B, V20.16B, V21.16B }, [X28]
    ADD  X28, X28, X3
    ST3 { V19.2D, V20.2D, V21.2D }, [X28]
    LD3 { V28.2D, V29.2D, V30.2D }, [X28]
    ADD  X28, X28, X3
    ST3 { V29.4S, V30.4S, V31.4S }, [X28]
    LD3 { V27.4S, V28.4S, V29.4S }, [X28]
    ADD  X28, X28, X3
    ST3 { V2.8H, V3.8H, V4.8H }, [X28]
    LD3 { V28.8H, V29.8H, V30.8H }, [X28]
    ADD  X28, X28, X3, LSR #0
    ST3 { V28.8B, V29.8B, V30.8B }, [X28]
    LD3 { V26.4H, V27.4H, V28.4H }, [X28]
    ADD  X28, X28, X3, LSR #0
    ST3 { V9.2S, V10.2S, V11.2S }, [X28]
    LD3 { V28.2S, V29.2S, V30.2S }, [X28]
    ADD  X28, X28, X3, ASR #0
    ST3 { V28.4H, V29.4H, V30.4H }, [X28]
    LD3 { V27.4H, V28.4H, V29.4H }, [X28]
    ADD  X28, X28, X3, ASR #0
    ST3 { V13.8B, V14.8B, V15.8B }, [X28]
    LD3 { V15.8B, V16.8B, V17.8B }, [X28]
    ADD  X28, X28, X3
    MOV  X29, X28
    ST3 { V26.8H, V27.8H, V28.8H }, [X29], #48
    MOV  X29, X28
    LD3 { V2.2D, V3.2D, V4.2D }, [X29], #48
    ADD  X28, X28, X3
    MOV  X29, X28
    ST3 { V2.16B, V3.16B, V4.16B }, [X29], #48
    MOV  X29, X28
    LD3 { V19.16B, V20.16B, V21.16B }, [X29], #48
    ADD  X28, X28, X3, ASR #0
    MOV  X29, X28
    ST3 { V21.2D, V22.2D, V23.2D }, [X29], #48
    MOV  X29, X28
    LD3 { V21.2D, V22.2D, V23.2D }, [X29], #48
    ADD  X28, X28, X3
    MOV  X29, X28
    ST3 { V21.4S, V22.4S, V23.4S }, [X29], #48
    MOV  X29, X28
    LD3 { V29.4S, V30.4S, V31.4S }, [X29], #48
    ADD  X28, X28, X3, LSR #0
    MOV  X29, X28
    ST3 { V29.8H, V30.8H, V31.8H }, [X29], #48
    MOV  X29, X28
    LD3 { V9.8H, V10.8H, V11.8H }, [X29], #48
    ADD  X28, X28, X3
    MOV  X29, X28
    ST3 { V9.8B, V10.8B, V11.8B }, [X29], #24
    MOV  X29, X28
    LD3 { V29.8B, V30.8B, V31.8B }, [X29], #24
    ADD  X28, X28, X3, ASR #0
    MOV  X29, X28
    ST3 { V14.2S, V15.2S, V16.2S }, [X29], #24
    MOV  X29, X28
    LD3 { V11.2S, V12.2S, V13.2S }, [X29], #24
    ADD  X28, X28, X3, LSR #0
    MOV  X29, X28
    ST3 { V11.4H, V12.4H, V13.4H }, [X29], #24
    MOV  X29, X28
    LD3 { V4.4H, V5.4H, V6.4H }, [X29], #24
    ADD  X28, X28, X3
    MOV  X29, X28
    ST3 { V4.8B, V5.8B, V6.8B }, [X29], #24
    MOV  X29, X28
    LD3 { V10.8B, V11.8B, V12.8B }, [X29], #24
    ADD  X28, X28, X3
    ST3 { V17.4S, V18.4S, V19.4S }, [X28], X8
    LD3 { V16.4S, V17.4S, V18.4S }, [X28], X8
    ADD  X28, X28, X3, ASR #0
    ST3 { V29.16B, V30.16B, V31.16B }, [X28], X8
    LD3 { V13.16B, V14.16B, V15.16B }, [X28], X8
    ADD  X28, X28, X3, LSR #0
    ST3 { V15.2D, V16.2D, V17.2D }, [X28], X8
    LD3 { V12.2D, V13.2D, V14.2D }, [X28], X8
    ADD  X28, X28, X3
    ST3 { V4.4S, V5.4S, V6.4S }, [X28], X8
    LD3 { V18.4S, V19.4S, V20.4S }, [X28], X8
    ADD  X28, X28, X3
    ST3 { V11.8H, V12.8H, V13.8H }, [X28], X8
    LD3 { V18.8H, V19.8H, V20.8H }, [X28], X8
    ADD  X28, X28, X3
    ST3 { V18.8B, V19.8B, V20.8B }, [X28], X8
    LD3 { V4.8B, V5.8B, V6.8B }, [X28], X8
    ADD  X28, X28, X3, LSR #0
    ST3 { V13.2S, V14.2S, V15.2S }, [X28], X8
    LD3 { V18.2S, V19.2S, V20.2S }, [X28], X8
    ADD  X28, X28, X3
    ST3 { V19.4H, V20.4H, V21.4H }, [X28], X8
    LD3 { V19.4H, V20.4H, V21.4H }, [X28], X8
    ADD  X28, X28, X3
    ST3 { V19.8B, V20.8B, V21.8B }, [X28], X8
    LD3 { V15.8B, V16.8B, V17.8B }, [X28], X8
    ADD  X28, X28, X3, ASR #0
    ST3 { V25.H, V26.H, V27.H }[0x1], [X28]
    LD3 { V18.H, V19.H, V20.H }[0x4], [X28]
    ADD  X28, X28, X3, ASR #0
    ST3 { V4.S, V5.S, V6.S }[0x1], [X28]
    LD3 { V12.S, V13.S, V14.S }[0x2], [X28]
    ADD  X28, X28, X3
    ST3 { V13.D, V14.D, V15.D }[0x1], [X28]
    LD3 { V30.D, V31.D, V0.D }[0x0], [X28]
    ADD  X28, X28, X3, LSR #0
    ST3 { V22.B, V23.B, V24.B }[0x0], [X28]
    LD3 { V24.B, V25.B, V26.B }[0xb], [X28]
    ADD  X28, X28, X3, ASR #0
    MOV  X29, X28
    ST3 { V23.H, V24.H, V25.H }[0x6], [X29], #6
    MOV  X29, X28
    LD3 { V4.H, V5.H, V6.H }[0x5], [X29], #6
    ADD  X28, X28, X3
    ST3 { V17.H, V18.H, V19.H }[0x1], [X28], X8
    LD3 { V13.H, V14.H, V15.H }[0x5], [X28], X8
    ADD  X28, X28, X3, LSR #0
    MOV  X29, X28
    ST3 { V9.S, V10.S, V11.S }[0x0], [X29], #12
    MOV  X29, X28
    LD3 { V24.S, V25.S, V26.S }[0x0], [X29], #12
    ADD  X28, X28, X3
    ST3 { V2.S, V3.S, V4.S }[0x3], [X28], X8
    LD3 { V22.S, V23.S, V24.S }[0x3], [X28], X8
    ADD  X28, X28, X3
    MOV  X29, X28
    ST3 { V28.D, V29.D, V30.D }[0x1], [X29], #24
    MOV  X29, X28
    LD3 { V28.D, V29.D, V30.D }[0x1], [X29], #24
    ADD  X28, X28, X3, ASR #0
    ST3 { V13.D, V14.D, V15.D }[0x0], [X28], X8
    LD3 { V21.D, V22.D, V23.D }[0x0], [X28], X8
    ADD  X28, X28, X3, LSR #0
    MOV  X29, X28
    ST3 { V29.B, V30.B, V31.B }[0x9], [X29], #3
    MOV  X29, X28
    LD3 { V13.B, V14.B, V15.B }[0xa], [X29], #3
    ADD  X28, X28, X3
    ST3 { V21.B, V22.B, V23.B }[0x1], [X28], X8
    LD3 { V25.B, V26.B, V27.B }[0x2], [X28], X8
    ADD  X28, X28, X3
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X11, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP06_TestFail
    MRS  X24, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D0
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D1
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D2
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D3
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D4
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D5
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D6
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D7
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D8
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D10
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D11
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D12
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa500, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D13
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa500, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D14
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xa500, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D15
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D16
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D17
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D18
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D19
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D20
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D21
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D22
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D23
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D24
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D25
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xa500, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D26
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D27
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D28
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D29
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D30
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X24, D31
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
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
    FMOV  V0.D[1], X2
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X23
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X10
    FMOV  D4, X17
    FMOV  V4.D[1], X29
    FMOV  D5, X28
    FMOV  V5.D[1], X10
    FMOV  D6, X10
    FMOV  V6.D[1], X8
    FMOV  D7, X8
    FMOV  V7.D[1], X10
    FMOV  D8, X14
    FMOV  V8.D[1], X17
    FMOV  D9, X15
    FMOV  V9.D[1], X5
    FMOV  D10, X6
    FMOV  V10.D[1], X3
    FMOV  D11, X9
    FMOV  V11.D[1], X17
    FMOV  D12, X12
    FMOV  V12.D[1], X27
    FMOV  D13, X3
    FMOV  V13.D[1], X15
    FMOV  D14, X26
    FMOV  V14.D[1], X7
    FMOV  D15, X24
    FMOV  V15.D[1], X11
    FMOV  D16, X5
    FMOV  V16.D[1], X29
    FMOV  D17, X27
    FMOV  V17.D[1], X3
    FMOV  D18, X23
    FMOV  V18.D[1], X15
    FMOV  D19, X10
    FMOV  V19.D[1], X14
    FMOV  D20, X23
    FMOV  V20.D[1], X4
    FMOV  D21, X29
    FMOV  V21.D[1], X2
    FMOV  D22, X29
    FMOV  V22.D[1], X12
    FMOV  D23, X26
    FMOV  V23.D[1], X9
    FMOV  D24, X14
    FMOV  V24.D[1], X11
    FMOV  D25, X27
    FMOV  V25.D[1], X27
    FMOV  D26, X13
    FMOV  V26.D[1], X12
    FMOV  D27, X25
    FMOV  V27.D[1], X7
    FMOV  D28, X4
    FMOV  V28.D[1], X23
    FMOV  D29, X28
    FMOV  V29.D[1], X8
    FMOV  D30, X12
    FMOV  V30.D[1], X5
    FMOV  D31, X7
    FMOV  V31.D[1], X27
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X4, #0xa00, LSL #0
    ADD  X13, X30, X4, LSR #0
    ST3 { V24.2D, V25.2D, V26.2D }, [X13]
    LD3 { V23.4S, V24.4S, V25.4S }, [X13]
    ADD  X13, X13, X17
    ST3 { V10.16B, V11.16B, V12.16B }, [X13]
    LD3 { V30.16B, V31.16B, V0.16B }, [X13]
    ADD  X13, X13, X17
    ST3 { V20.2D, V21.2D, V22.2D }, [X13]
    LD3 { V13.2D, V14.2D, V15.2D }, [X13]
    ADD  X13, X13, X17
    ST3 { V29.4S, V30.4S, V31.4S }, [X13]
    LD3 { V8.4S, V9.4S, V10.4S }, [X13]
    ADD  X13, X13, X17, LSR #0
    ST3 { V13.8H, V14.8H, V15.8H }, [X13]
    LD3 { V12.8H, V13.8H, V14.8H }, [X13]
    ADD  X13, X13, X17, LSR #0
    ST3 { V22.2S, V23.2S, V24.2S }, [X13]
    LD3 { V7.8B, V8.8B, V9.8B }, [X13]
    ADD  X13, X13, X17, LSR #0
    ST3 { V22.2S, V23.2S, V24.2S }, [X13]
    LD3 { V20.2S, V21.2S, V22.2S }, [X13]
    ADD  X13, X13, X17
    ST3 { V12.4H, V13.4H, V14.4H }, [X13]
    LD3 { V22.4H, V23.4H, V24.4H }, [X13]
    ADD  X13, X13, X17, ASR #0
    ST3 { V22.8B, V23.8B, V24.8B }, [X13]
    LD3 { V8.8B, V9.8B, V10.8B }, [X13]
    ADD  X13, X13, X17
    MOV  X28, X13
    ST3 { V14.8H, V15.8H, V16.8H }, [X28], #48
    MOV  X28, X13
    LD3 { V1.16B, V2.16B, V3.16B }, [X28], #48
    ADD  X13, X13, X17, LSR #0
    MOV  X28, X13
    ST3 { V13.16B, V14.16B, V15.16B }, [X28], #48
    MOV  X28, X13
    LD3 { V29.16B, V30.16B, V31.16B }, [X28], #48
    ADD  X13, X13, X17, ASR #0
    MOV  X28, X13
    ST3 { V21.2D, V22.2D, V23.2D }, [X28], #48
    MOV  X28, X13
    LD3 { V20.2D, V21.2D, V22.2D }, [X28], #48
    ADD  X13, X13, X17, ASR #0
    MOV  X28, X13
    ST3 { V21.4S, V22.4S, V23.4S }, [X28], #48
    MOV  X28, X13
    LD3 { V22.4S, V23.4S, V24.4S }, [X28], #48
    ADD  X13, X13, X17, ASR #0
    MOV  X28, X13
    ST3 { V22.8H, V23.8H, V24.8H }, [X28], #48
    MOV  X28, X13
    LD3 { V20.8H, V21.8H, V22.8H }, [X28], #48
    ADD  X13, X13, X17, LSR #0
    MOV  X28, X13
    ST3 { V6.4H, V7.4H, V8.4H }, [X28], #24
    MOV  X28, X13
    LD3 { V5.2S, V6.2S, V7.2S }, [X28], #24
    ADD  X13, X13, X17, LSR #0
    MOV  X28, X13
    ST3 { V20.2S, V21.2S, V22.2S }, [X28], #24
    MOV  X28, X13
    LD3 { V20.2S, V21.2S, V22.2S }, [X28], #24
    ADD  X13, X13, X17
    MOV  X28, X13
    ST3 { V20.4H, V21.4H, V22.4H }, [X28], #24
    MOV  X28, X13
    LD3 { V10.4H, V11.4H, V12.4H }, [X28], #24
    ADD  X13, X13, X17
    MOV  X28, X13
    ST3 { V24.8B, V25.8B, V26.8B }, [X28], #24
    MOV  X28, X13
    LD3 { V6.8B, V7.8B, V8.8B }, [X28], #24
    ADD  X13, X13, X17, LSR #0
    ST3 { V4.2D, V5.2D, V6.2D }, [X13], X5
    LD3 { V15.4S, V16.4S, V17.4S }, [X13], X5
    ADD  X13, X13, X17, LSR #0
    ST3 { V18.16B, V19.16B, V20.16B }, [X13], X5
    LD3 { V24.16B, V25.16B, V26.16B }, [X13], X5
    ADD  X13, X13, X17, LSR #0
    ST3 { V10.2D, V11.2D, V12.2D }, [X13], X5
    LD3 { V4.2D, V5.2D, V6.2D }, [X13], X5
    ADD  X13, X13, X17, ASR #0
    ST3 { V10.4S, V11.4S, V12.4S }, [X13], X5
    LD3 { V4.4S, V5.4S, V6.4S }, [X13], X5
    ADD  X13, X13, X17
    ST3 { V15.8H, V16.8H, V17.8H }, [X13], X5
    LD3 { V28.8H, V29.8H, V30.8H }, [X13], X5
    ADD  X13, X13, X17, ASR #0
    ST3 { V15.4H, V16.4H, V17.4H }, [X13], X5
    LD3 { V0.8B, V1.8B, V2.8B }, [X13], X5
    ADD  X13, X13, X17, LSR #0
    ST3 { V7.2S, V8.2S, V9.2S }, [X13], X5
    LD3 { V7.2S, V8.2S, V9.2S }, [X13], X5
    ADD  X13, X13, X17
    ST3 { V8.4H, V9.4H, V10.4H }, [X13], X5
    LD3 { V8.4H, V9.4H, V10.4H }, [X13], X5
    ADD  X13, X13, X17
    ST3 { V28.8B, V29.8B, V30.8B }, [X13], X5
    LD3 { V13.8B, V14.8B, V15.8B }, [X13], X5
    ADD  X13, X13, X17, ASR #0
    ST3 { V24.H, V25.H, V26.H }[0x4], [X13]
    LD3 { V17.H, V18.H, V19.H }[0x0], [X13]
    ADD  X13, X13, X17, LSR #0
    ST3 { V28.S, V29.S, V30.S }[0x1], [X13]
    LD3 { V18.S, V19.S, V20.S }[0x3], [X13]
    ADD  X13, X13, X17, LSR #0
    ST3 { V0.D, V1.D, V2.D }[0x1], [X13]
    LD3 { V11.D, V12.D, V13.D }[0x1], [X13]
    ADD  X13, X13, X17, LSR #0
    ST3 { V20.B, V21.B, V22.B }[0x4], [X13]
    LD3 { V17.B, V18.B, V19.B }[0x7], [X13]
    ADD  X13, X13, X17
    MOV  X28, X13
    ST3 { V9.H, V10.H, V11.H }[0x0], [X28], #6
    MOV  X28, X13
    LD3 { V20.H, V21.H, V22.H }[0x7], [X28], #6
    ADD  X13, X13, X17, ASR #0
    ST3 { V20.H, V21.H, V22.H }[0x6], [X13], X5
    LD3 { V9.H, V10.H, V11.H }[0x3], [X13], X5
    ADD  X13, X13, X17, ASR #0
    MOV  X28, X13
    ST3 { V20.S, V21.S, V22.S }[0x2], [X28], #12
    MOV  X28, X13
    LD3 { V11.S, V12.S, V13.S }[0x1], [X28], #12
    ADD  X13, X13, X17, ASR #0
    ST3 { V30.S, V31.S, V0.S }[0x1], [X13], X5
    LD3 { V0.S, V1.S, V2.S }[0x2], [X13], X5
    ADD  X13, X13, X17, LSR #0
    MOV  X28, X13
    ST3 { V8.D, V9.D, V10.D }[0x1], [X28], #24
    MOV  X28, X13
    LD3 { V21.D, V22.D, V23.D }[0x0], [X28], #24
    ADD  X13, X13, X17, ASR #0
    ST3 { V2.D, V3.D, V4.D }[0x0], [X13], X5
    LD3 { V2.D, V3.D, V4.D }[0x1], [X13], X5
    ADD  X13, X13, X17, LSR #0
    MOV  X28, X13
    ST3 { V8.B, V9.B, V10.B }[0x8], [X28], #3
    MOV  X28, X13
    LD3 { V29.B, V30.B, V31.B }[0x1], [X28], #3
    ADD  X13, X13, X17, ASR #0
    ST3 { V24.B, V25.B, V26.B }[0x2], [X13], X5
    LD3 { V12.B, V13.B, V14.B }[0x2], [X13], X5
    ADD  X13, X13, X17
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MRS  X12, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D1
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D3
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D6
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D7
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D9
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D11
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D16
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D17
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D18
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D19
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D20
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D26
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D28
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D29
    MOVZ  X24, #0x5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D30
    MOVZ  X24, #0x5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X12, D31
    MOVZ  X24, #0x5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X2
    FMOV  V2.D[1], X29
    FMOV  D3, X12
    FMOV  V3.D[1], X24
    FMOV  D4, X10
    FMOV  V4.D[1], X26
    FMOV  D5, X3
    FMOV  V5.D[1], X14
    FMOV  D6, X7
    FMOV  V6.D[1], X23
    FMOV  D7, X26
    FMOV  V7.D[1], X3
    FMOV  D8, X12
    FMOV  V8.D[1], X16
    FMOV  D9, X3
    FMOV  V9.D[1], X12
    FMOV  D10, X11
    FMOV  V10.D[1], X16
    FMOV  D11, X14
    FMOV  V11.D[1], X28
    FMOV  D12, X5
    FMOV  V12.D[1], X17
    FMOV  D13, X8
    FMOV  V13.D[1], X27
    FMOV  D14, X10
    FMOV  V14.D[1], X29
    FMOV  D15, X23
    FMOV  V15.D[1], X25
    FMOV  D16, X27
    FMOV  V16.D[1], X4
    FMOV  D17, X6
    FMOV  V17.D[1], X14
    FMOV  D18, X6
    FMOV  V18.D[1], X23
    FMOV  D19, X28
    FMOV  V19.D[1], X11
    FMOV  D20, X28
    FMOV  V20.D[1], X28
    FMOV  D21, X28
    FMOV  V21.D[1], X5
    FMOV  D22, X16
    FMOV  V22.D[1], X9
    FMOV  D23, X25
    FMOV  V23.D[1], X17
    FMOV  D24, X28
    FMOV  V24.D[1], X14
    FMOV  D25, X29
    FMOV  V25.D[1], X11
    FMOV  D26, X5
    FMOV  V26.D[1], X13
    FMOV  D27, X26
    FMOV  V27.D[1], X3
    FMOV  D28, X16
    FMOV  V28.D[1], X12
    FMOV  D29, X23
    FMOV  V29.D[1], X8
    FMOV  D30, X7
    FMOV  V30.D[1], X11
    FMOV  D31, X15
    FMOV  V31.D[1], X24
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X8, #0xf00, LSL #0
    ADD  X28, X30, X8, ASR #0
    ST3 { V2.8H, V3.8H, V4.8H }, [X28]
    LD3 { V29.8H, V30.8H, V31.8H }, [X28]
    ADD  X28, X28, X24
    ST3 { V29.16B, V30.16B, V31.16B }, [X28]
    LD3 { V5.16B, V6.16B, V7.16B }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST3 { V5.2D, V6.2D, V7.2D }, [X28]
    LD3 { V14.2D, V15.2D, V16.2D }, [X28]
    ADD  X28, X28, X24
    ST3 { V14.4S, V15.4S, V16.4S }, [X28]
    LD3 { V11.4S, V12.4S, V13.4S }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST3 { V24.8H, V25.8H, V26.8H }, [X28]
    LD3 { V21.8H, V22.8H, V23.8H }, [X28]
    ADD  X28, X28, X24
    ST3 { V21.4H, V22.4H, V23.4H }, [X28]
    LD3 { V12.8B, V13.8B, V14.8B }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST3 { V12.2S, V13.2S, V14.2S }, [X28]
    LD3 { V24.2S, V25.2S, V26.2S }, [X28]
    ADD  X28, X28, X24
    ST3 { V24.4H, V25.4H, V26.4H }, [X28]
    LD3 { V29.4H, V30.4H, V31.4H }, [X28]
    ADD  X28, X28, X24
    ST3 { V19.8B, V20.8B, V21.8B }, [X28]
    LD3 { V1.8B, V2.8B, V3.8B }, [X28]
    ADD  X28, X28, X24
    MOV  X2, X28
    ST3 { V18.16B, V19.16B, V20.16B }, [X2], #48
    MOV  X2, X28
    LD3 { V21.2D, V22.2D, V23.2D }, [X2], #48
    ADD  X28, X28, X24, ASR #0
    MOV  X2, X28
    ST3 { V21.16B, V22.16B, V23.16B }, [X2], #48
    MOV  X2, X28
    LD3 { V5.16B, V6.16B, V7.16B }, [X2], #48
    ADD  X28, X28, X24, LSR #0
    MOV  X2, X28
    ST3 { V21.2D, V22.2D, V23.2D }, [X2], #48
    MOV  X2, X28
    LD3 { V13.2D, V14.2D, V15.2D }, [X2], #48
    ADD  X28, X28, X24, LSR #0
    MOV  X2, X28
    ST3 { V2.4S, V3.4S, V4.4S }, [X2], #48
    MOV  X2, X28
    LD3 { V15.4S, V16.4S, V17.4S }, [X2], #48
    ADD  X28, X28, X24, ASR #0
    MOV  X2, X28
    ST3 { V22.8H, V23.8H, V24.8H }, [X2], #48
    MOV  X2, X28
    LD3 { V22.8H, V23.8H, V24.8H }, [X2], #48
    ADD  X28, X28, X24, ASR #0
    MOV  X2, X28
    ST3 { V7.2S, V8.2S, V9.2S }, [X2], #24
    MOV  X2, X28
    LD3 { V7.8B, V8.8B, V9.8B }, [X2], #24
    ADD  X28, X28, X24, LSR #0
    MOV  X2, X28
    ST3 { V13.2S, V14.2S, V15.2S }, [X2], #24
    MOV  X2, X28
    LD3 { V13.2S, V14.2S, V15.2S }, [X2], #24
    ADD  X28, X28, X24
    MOV  X2, X28
    ST3 { V22.4H, V23.4H, V24.4H }, [X2], #24
    MOV  X2, X28
    LD3 { V30.4H, V31.4H, V0.4H }, [X2], #24
    ADD  X28, X28, X24, LSR #0
    MOV  X2, X28
    ST3 { V8.8B, V9.8B, V10.8B }, [X2], #24
    MOV  X2, X28
    LD3 { V4.8B, V5.8B, V6.8B }, [X2], #24
    ADD  X28, X28, X24, LSR #0
    ST3 { V25.16B, V26.16B, V27.16B }, [X28], X6
    LD3 { V18.8H, V19.8H, V20.8H }, [X28], X6
    ADD  X28, X28, X24, LSR #0
    ST3 { V13.16B, V14.16B, V15.16B }, [X28], X6
    LD3 { V7.16B, V8.16B, V9.16B }, [X28], X6
    ADD  X28, X28, X24, LSR #0
    ST3 { V5.2D, V6.2D, V7.2D }, [X28], X6
    LD3 { V23.2D, V24.2D, V25.2D }, [X28], X6
    ADD  X28, X28, X24, ASR #0
    ST3 { V23.4S, V24.4S, V25.4S }, [X28], X6
    LD3 { V23.4S, V24.4S, V25.4S }, [X28], X6
    ADD  X28, X28, X24
    ST3 { V7.8H, V8.8H, V9.8H }, [X28], X6
    LD3 { V7.8H, V8.8H, V9.8H }, [X28], X6
    ADD  X28, X28, X24
    ST3 { V3.8B, V4.8B, V5.8B }, [X28], X6
    LD3 { V3.2S, V4.2S, V5.2S }, [X28], X6
    ADD  X28, X28, X24, ASR #0
    ST3 { V16.2S, V17.2S, V18.2S }, [X28], X6
    LD3 { V13.2S, V14.2S, V15.2S }, [X28], X6
    ADD  X28, X28, X24, LSR #0
    ST3 { V1.4H, V2.4H, V3.4H }, [X28], X6
    LD3 { V1.4H, V2.4H, V3.4H }, [X28], X6
    ADD  X28, X28, X24
    ST3 { V1.8B, V2.8B, V3.8B }, [X28], X6
    LD3 { V1.8B, V2.8B, V3.8B }, [X28], X6
    ADD  X28, X28, X24, ASR #0
    ST3 { V2.H, V3.H, V4.H }[0x5], [X28]
    LD3 { V16.H, V17.H, V18.H }[0x0], [X28]
    ADD  X28, X28, X24, ASR #0
    ST3 { V2.S, V3.S, V4.S }[0x2], [X28]
    LD3 { V2.S, V3.S, V4.S }[0x0], [X28]
    ADD  X28, X28, X24, LSR #0
    ST3 { V21.D, V22.D, V23.D }[0x1], [X28]
    LD3 { V15.D, V16.D, V17.D }[0x0], [X28]
    ADD  X28, X28, X24, ASR #0
    ST3 { V10.B, V11.B, V12.B }[0x7], [X28]
    LD3 { V27.B, V28.B, V29.B }[0x1], [X28]
    ADD  X28, X28, X24
    MOV  X2, X28
    ST3 { V25.H, V26.H, V27.H }[0x2], [X2], #6
    MOV  X2, X28
    LD3 { V15.H, V16.H, V17.H }[0x2], [X2], #6
    ADD  X28, X28, X24
    ST3 { V1.H, V2.H, V3.H }[0x6], [X28], X6
    LD3 { V7.H, V8.H, V9.H }[0x7], [X28], X6
    ADD  X28, X28, X24, LSR #0
    MOV  X2, X28
    ST3 { V2.S, V3.S, V4.S }[0x3], [X2], #12
    MOV  X2, X28
    LD3 { V11.S, V12.S, V13.S }[0x3], [X2], #12
    ADD  X28, X28, X24
    ST3 { V7.S, V8.S, V9.S }[0x3], [X28], X6
    LD3 { V12.S, V13.S, V14.S }[0x0], [X28], X6
    ADD  X28, X28, X24, ASR #0
    MOV  X2, X28
    ST3 { V9.D, V10.D, V11.D }[0x1], [X2], #24
    MOV  X2, X28
    LD3 { V2.D, V3.D, V4.D }[0x0], [X2], #24
    ADD  X28, X28, X24, ASR #0
    ST3 { V15.D, V16.D, V17.D }[0x0], [X28], X6
    LD3 { V11.D, V12.D, V13.D }[0x0], [X28], X6
    ADD  X28, X28, X24, ASR #0
    MOV  X2, X28
    ST3 { V7.B, V8.B, V9.B }[0x8], [X2], #3
    MOV  X2, X28
    LD3 { V16.B, V17.B, V18.B }[0x2], [X2], #3
    ADD  X28, X28, X24
    ST3 { V16.B, V17.B, V18.B }[0x6], [X28], X6
    LD3 { V7.B, V8.B, V9.B }[0xb], [X28], X6
    ADD  X28, X28, X24, LSR #0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X29, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MRS  X13, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D3
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D5
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D6
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #16
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D7
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D8
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #16
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D9
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D10
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D11
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D13
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D14
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa500, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D17
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D18
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X29, #0xa5, LSL #0
    MOVK  X29, #0xa5, LSL #16
    MOVK  X29, #0xa5, LSL #32
    MOVK  X29, #0xa5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X29, #0xa500, LSL #0
    MOVK  X29, #0xa500, LSL #16
    MOVK  X29, #0xa500, LSL #32
    MOVK  X29, #0xa500, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D21
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D22
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D23
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D26
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D27
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D28
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D29
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X2
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X4
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X27
    FMOV  V4.D[1], X7
    FMOV  D5, X24
    FMOV  V5.D[1], X29
    FMOV  D6, X28
    FMOV  V6.D[1], X16
    FMOV  D7, X29
    FMOV  V7.D[1], X10
    FMOV  D8, X11
    FMOV  V8.D[1], X17
    FMOV  D9, X12
    FMOV  V9.D[1], X7
    FMOV  D10, X14
    FMOV  V10.D[1], X2
    FMOV  D11, X15
    FMOV  V11.D[1], X6
    FMOV  D12, X28
    FMOV  V12.D[1], X12
    FMOV  D13, X26
    FMOV  V13.D[1], X13
    FMOV  D14, X11
    FMOV  V14.D[1], X13
    FMOV  D15, X23
    FMOV  V15.D[1], X11
    FMOV  D16, X24
    FMOV  V16.D[1], X26
    FMOV  D17, X28
    FMOV  V17.D[1], X16
    FMOV  D18, X26
    FMOV  V18.D[1], X12
    FMOV  D19, X8
    FMOV  V19.D[1], X27
    FMOV  D20, X13
    FMOV  V20.D[1], X15
    FMOV  D21, X17
    FMOV  V21.D[1], X14
    FMOV  D22, X5
    FMOV  V22.D[1], X24
    FMOV  D23, X12
    FMOV  V23.D[1], X2
    FMOV  D24, X23
    FMOV  V24.D[1], X24
    FMOV  D25, X7
    FMOV  V25.D[1], X29
    FMOV  D26, X17
    FMOV  V26.D[1], X17
    FMOV  D27, X2
    FMOV  V27.D[1], X17
    FMOV  D28, X24
    FMOV  V28.D[1], X7
    FMOV  D29, X3
    FMOV  V29.D[1], X7
    FMOV  D30, X12
    FMOV  V30.D[1], X3
    FMOV  D31, X16
    FMOV  V31.D[1], X11
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X26, #0x1400, LSL #0
    ADD  X28, X30, X26, LSR #0
    ST3 { V31.16B, V0.16B, V1.16B }, [X28]
    LD3 { V1.8H, V2.8H, V3.8H }, [X28]
    ADD  X28, X28, X5, ASR #0
    ST3 { V25.16B, V26.16B, V27.16B }, [X28]
    LD3 { V31.16B, V0.16B, V1.16B }, [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V18.2D, V19.2D, V20.2D }, [X28]
    LD3 { V4.2D, V5.2D, V6.2D }, [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V30.4S, V31.4S, V0.4S }, [X28]
    LD3 { V30.4S, V31.4S, V0.4S }, [X28]
    ADD  X28, X28, X5
    ST3 { V21.8H, V22.8H, V23.8H }, [X28]
    LD3 { V31.8H, V0.8H, V1.8H }, [X28]
    ADD  X28, X28, X5, ASR #0
    ST3 { V30.4H, V31.4H, V0.4H }, [X28]
    LD3 { V5.2S, V6.2S, V7.2S }, [X28]
    ADD  X28, X28, X5
    ST3 { V5.2S, V6.2S, V7.2S }, [X28]
    LD3 { V12.2S, V13.2S, V14.2S }, [X28]
    ADD  X28, X28, X5
    ST3 { V30.4H, V31.4H, V0.4H }, [X28]
    LD3 { V20.4H, V21.4H, V22.4H }, [X28]
    ADD  X28, X28, X5
    ST3 { V20.8B, V21.8B, V22.8B }, [X28]
    LD3 { V11.8B, V12.8B, V13.8B }, [X28]
    ADD  X28, X28, X5, ASR #0
    MOV  X9, X28
    ST3 { V12.4S, V13.4S, V14.4S }, [X9], #48
    MOV  X9, X28
    LD3 { V30.8H, V31.8H, V0.8H }, [X9], #48
    ADD  X28, X28, X5, LSR #0
    MOV  X9, X28
    ST3 { V30.16B, V31.16B, V0.16B }, [X9], #48
    MOV  X9, X28
    LD3 { V12.16B, V13.16B, V14.16B }, [X9], #48
    ADD  X28, X28, X5, ASR #0
    MOV  X9, X28
    ST3 { V1.2D, V2.2D, V3.2D }, [X9], #48
    MOV  X9, X28
    LD3 { V0.2D, V1.2D, V2.2D }, [X9], #48
    ADD  X28, X28, X5, LSR #0
    MOV  X9, X28
    ST3 { V12.4S, V13.4S, V14.4S }, [X9], #48
    MOV  X9, X28
    LD3 { V12.4S, V13.4S, V14.4S }, [X9], #48
    ADD  X28, X28, X5, LSR #0
    MOV  X9, X28
    ST3 { V0.8H, V1.8H, V2.8H }, [X9], #48
    MOV  X9, X28
    LD3 { V23.8H, V24.8H, V25.8H }, [X9], #48
    ADD  X28, X28, X5
    MOV  X9, X28
    ST3 { V12.8B, V13.8B, V14.8B }, [X9], #24
    MOV  X9, X28
    LD3 { V21.8B, V22.8B, V23.8B }, [X9], #24
    ADD  X28, X28, X5, ASR #0
    MOV  X9, X28
    ST3 { V29.2S, V30.2S, V31.2S }, [X9], #24
    MOV  X9, X28
    LD3 { V23.2S, V24.2S, V25.2S }, [X9], #24
    ADD  X28, X28, X5, LSR #0
    MOV  X9, X28
    ST3 { V23.4H, V24.4H, V25.4H }, [X9], #24
    MOV  X9, X28
    LD3 { V29.4H, V30.4H, V31.4H }, [X9], #24
    ADD  X28, X28, X5
    MOV  X9, X28
    ST3 { V29.8B, V30.8B, V31.8B }, [X9], #24
    MOV  X9, X28
    LD3 { V1.8B, V2.8B, V3.8B }, [X9], #24
    ADD  X28, X28, X5, LSR #0
    ST3 { V17.8H, V18.8H, V19.8H }, [X28], X27
    LD3 { V23.4S, V24.4S, V25.4S }, [X28], X27
    ADD  X28, X28, X5, LSR #0
    ST3 { V1.16B, V2.16B, V3.16B }, [X28], X27
    LD3 { V17.16B, V18.16B, V19.16B }, [X28], X27
    ADD  X28, X28, X5, ASR #0
    ST3 { V23.2D, V24.2D, V25.2D }, [X28], X27
    LD3 { V1.2D, V2.2D, V3.2D }, [X28], X27
    ADD  X28, X28, X5
    ST3 { V22.4S, V23.4S, V24.4S }, [X28], X27
    LD3 { V5.4S, V6.4S, V7.4S }, [X28], X27
    ADD  X28, X28, X5, LSR #0
    ST3 { V28.8H, V29.8H, V30.8H }, [X28], X27
    LD3 { V7.8H, V8.8H, V9.8H }, [X28], X27
    ADD  X28, X28, X5, ASR #0
    ST3 { V9.8B, V10.8B, V11.8B }, [X28], X27
    LD3 { V23.4H, V24.4H, V25.4H }, [X28], X27
    ADD  X28, X28, X5, ASR #0
    ST3 { V9.2S, V10.2S, V11.2S }, [X28], X27
    LD3 { V28.2S, V29.2S, V30.2S }, [X28], X27
    ADD  X28, X28, X5, LSR #0
    ST3 { V29.4H, V30.4H, V31.4H }, [X28], X27
    LD3 { V4.4H, V5.4H, V6.4H }, [X28], X27
    ADD  X28, X28, X5, ASR #0
    ST3 { V30.8B, V31.8B, V0.8B }, [X28], X27
    LD3 { V3.8B, V4.8B, V5.8B }, [X28], X27
    ADD  X28, X28, X5
    ST3 { V3.H, V4.H, V5.H }[0x4], [X28]
    LD3 { V9.H, V10.H, V11.H }[0x2], [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V28.S, V29.S, V30.S }[0x0], [X28]
    LD3 { V10.S, V11.S, V12.S }[0x3], [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V17.D, V18.D, V19.D }[0x1], [X28]
    LD3 { V17.D, V18.D, V19.D }[0x0], [X28]
    ADD  X28, X28, X5, LSR #0
    ST3 { V23.B, V24.B, V25.B }[0x2], [X28]
    LD3 { V23.B, V24.B, V25.B }[0x0], [X28]
    ADD  X28, X28, X5, ASR #0
    MOV  X9, X28
    ST3 { V10.H, V11.H, V12.H }[0x1], [X9], #6
    MOV  X9, X28
    LD3 { V21.H, V22.H, V23.H }[0x3], [X9], #6
    ADD  X28, X28, X5, ASR #0
    ST3 { V22.H, V23.H, V24.H }[0x3], [X28], X27
    LD3 { V13.H, V14.H, V15.H }[0x3], [X28], X27
    ADD  X28, X28, X5, LSR #0
    MOV  X9, X28
    ST3 { V13.S, V14.S, V15.S }[0x2], [X9], #12
    MOV  X9, X28
    LD3 { V26.S, V27.S, V28.S }[0x3], [X9], #12
    ADD  X28, X28, X5, ASR #0
    ST3 { V17.S, V18.S, V19.S }[0x1], [X28], X27
    LD3 { V30.S, V31.S, V0.S }[0x3], [X28], X27
    ADD  X28, X28, X5, ASR #0
    MOV  X9, X28
    ST3 { V18.D, V19.D, V20.D }[0x0], [X9], #24
    MOV  X9, X28
    LD3 { V16.D, V17.D, V18.D }[0x0], [X9], #24
    ADD  X28, X28, X5, ASR #0
    ST3 { V23.D, V24.D, V25.D }[0x0], [X28], X27
    LD3 { V7.D, V8.D, V9.D }[0x1], [X28], X27
    ADD  X28, X28, X5, LSR #0
    MOV  X9, X28
    ST3 { V15.B, V16.B, V17.B }[0xb], [X9], #3
    MOV  X9, X28
    LD3 { V30.B, V31.B, V0.B }[0x2], [X9], #3
    ADD  X28, X28, X5
    ST3 { V26.B, V27.B, V28.B }[0xd], [X28], X27
    LD3 { V9.B, V10.B, V11.B }[0xd], [X28], X27
    ADD  X28, X28, X5, ASR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP06_TestFail
    MRS  X13, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a00, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D1
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D3
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D6
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D7
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D9
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D11
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D18
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D20
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D21
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D22
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D23
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D26
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D28
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D29
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D30
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X13, D31
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
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
    FMOV  V0.D[1], X10
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X29
    FMOV  V3.D[1], X12
    FMOV  D4, X28
    FMOV  V4.D[1], X9
    FMOV  D5, X23
    FMOV  V5.D[1], X29
    FMOV  D6, X2
    FMOV  V6.D[1], X11
    FMOV  D7, X3
    FMOV  V7.D[1], X13
    FMOV  D8, X11
    FMOV  V8.D[1], X15
    FMOV  D9, X2
    FMOV  V9.D[1], X13
    FMOV  D10, X17
    FMOV  V10.D[1], X7
    FMOV  D11, X28
    FMOV  V11.D[1], X5
    FMOV  D12, X15
    FMOV  V12.D[1], X29
    FMOV  D13, X15
    FMOV  V13.D[1], X2
    FMOV  D14, X29
    FMOV  V14.D[1], X16
    FMOV  D15, X16
    FMOV  V15.D[1], X6
    FMOV  D16, X27
    FMOV  V16.D[1], X28
    FMOV  D17, X8
    FMOV  V17.D[1], X26
    FMOV  D18, X15
    FMOV  V18.D[1], X25
    FMOV  D19, X12
    FMOV  V19.D[1], X25
    FMOV  D20, X5
    FMOV  V20.D[1], X14
    FMOV  D21, X14
    FMOV  V21.D[1], X9
    FMOV  D22, X26
    FMOV  V22.D[1], X4
    FMOV  D23, X25
    FMOV  V23.D[1], X4
    FMOV  D24, X26
    FMOV  V24.D[1], X9
    FMOV  D25, X25
    FMOV  V25.D[1], X11
    FMOV  D26, X8
    FMOV  V26.D[1], X9
    FMOV  D27, X5
    FMOV  V27.D[1], X2
    FMOV  D28, X15
    FMOV  V28.D[1], X23
    FMOV  D29, X11
    FMOV  V29.D[1], X5
    FMOV  D30, X29
    FMOV  V30.D[1], X17
    FMOV  D31, X26
    FMOV  V31.D[1], X26
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X4, #0x1900, LSL #0
    ADD  X17, X30, X4, LSR #0
    ST3 { V1.16B, V2.16B, V3.16B }, [X17]
    LD3 { V24.16B, V25.16B, V26.16B }, [X17]
    ADD  X17, X17, X12, ASR #0
    ST3 { V29.16B, V30.16B, V31.16B }, [X17]
    LD3 { V5.16B, V6.16B, V7.16B }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST3 { V6.2D, V7.2D, V8.2D }, [X17]
    LD3 { V20.2D, V21.2D, V22.2D }, [X17]
    ADD  X17, X17, X12
    ST3 { V24.4S, V25.4S, V26.4S }, [X17]
    LD3 { V27.4S, V28.4S, V29.4S }, [X17]
    ADD  X17, X17, X12
    ST3 { V20.8H, V21.8H, V22.8H }, [X17]
    LD3 { V12.8H, V13.8H, V14.8H }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST3 { V29.4H, V30.4H, V31.4H }, [X17]
    LD3 { V1.8B, V2.8B, V3.8B }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST3 { V23.2S, V24.2S, V25.2S }, [X17]
    LD3 { V23.2S, V24.2S, V25.2S }, [X17]
    ADD  X17, X17, X12, ASR #0
    ST3 { V23.4H, V24.4H, V25.4H }, [X17]
    LD3 { V23.4H, V24.4H, V25.4H }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST3 { V12.8B, V13.8B, V14.8B }, [X17]
    LD3 { V20.8B, V21.8B, V22.8B }, [X17]
    ADD  X17, X17, X12, ASR #0
    MOV  X9, X17
    ST3 { V23.2D, V24.2D, V25.2D }, [X9], #48
    MOV  X9, X17
    LD3 { V17.2D, V18.2D, V19.2D }, [X9], #48
    ADD  X17, X17, X12, LSR #0
    MOV  X9, X17
    ST3 { V19.16B, V20.16B, V21.16B }, [X9], #48
    MOV  X9, X17
    LD3 { V19.16B, V20.16B, V21.16B }, [X9], #48
    ADD  X17, X17, X12, ASR #0
    MOV  X9, X17
    ST3 { V20.2D, V21.2D, V22.2D }, [X9], #48
    MOV  X9, X17
    LD3 { V5.2D, V6.2D, V7.2D }, [X9], #48
    ADD  X17, X17, X12, LSR #0
    MOV  X9, X17
    ST3 { V5.4S, V6.4S, V7.4S }, [X9], #48
    MOV  X9, X17
    LD3 { V5.4S, V6.4S, V7.4S }, [X9], #48
    ADD  X17, X17, X12, ASR #0
    MOV  X9, X17
    ST3 { V17.8H, V18.8H, V19.8H }, [X9], #48
    MOV  X9, X17
    LD3 { V22.8H, V23.8H, V24.8H }, [X9], #48
    ADD  X17, X17, X12, LSR #0
    MOV  X9, X17
    ST3 { V22.8B, V23.8B, V24.8B }, [X9], #24
    MOV  X9, X17
    LD3 { V17.4H, V18.4H, V19.4H }, [X9], #24
    ADD  X17, X17, X12, ASR #0
    MOV  X9, X17
    ST3 { V7.2S, V8.2S, V9.2S }, [X9], #24
    MOV  X9, X17
    LD3 { V22.2S, V23.2S, V24.2S }, [X9], #24
    ADD  X17, X17, X12, LSR #0
    MOV  X9, X17
    ST3 { V31.4H, V0.4H, V1.4H }, [X9], #24
    MOV  X9, X17
    LD3 { V14.4H, V15.4H, V16.4H }, [X9], #24
    ADD  X17, X17, X12
    MOV  X9, X17
    ST3 { V21.8B, V22.8B, V23.8B }, [X9], #24
    MOV  X9, X17
    LD3 { V27.8B, V28.8B, V29.8B }, [X9], #24
    ADD  X17, X17, X12, LSR #0
    ST3 { V13.16B, V14.16B, V15.16B }, [X17], X7
    LD3 { V4.4S, V5.4S, V6.4S }, [X17], X7
    ADD  X17, X17, X12, LSR #0
    ST3 { V27.16B, V28.16B, V29.16B }, [X17], X7
    LD3 { V31.16B, V0.16B, V1.16B }, [X17], X7
    ADD  X17, X17, X12
    ST3 { V31.2D, V0.2D, V1.2D }, [X17], X7
    LD3 { V8.2D, V9.2D, V10.2D }, [X17], X7
    ADD  X17, X17, X12, LSR #0
    ST3 { V5.4S, V6.4S, V7.4S }, [X17], X7
    LD3 { V19.4S, V20.4S, V21.4S }, [X17], X7
    ADD  X17, X17, X12
    ST3 { V19.8H, V20.8H, V21.8H }, [X17], X7
    LD3 { V5.8H, V6.8H, V7.8H }, [X17], X7
    ADD  X17, X17, X12
    ST3 { V4.8B, V5.8B, V6.8B }, [X17], X7
    LD3 { V14.8B, V15.8B, V16.8B }, [X17], X7
    ADD  X17, X17, X12, ASR #0
    ST3 { V7.2S, V8.2S, V9.2S }, [X17], X7
    LD3 { V27.2S, V28.2S, V29.2S }, [X17], X7
    ADD  X17, X17, X12, ASR #0
    ST3 { V5.4H, V6.4H, V7.4H }, [X17], X7
    LD3 { V9.4H, V10.4H, V11.4H }, [X17], X7
    ADD  X17, X17, X12, ASR #0
    ST3 { V30.8B, V31.8B, V0.8B }, [X17], X7
    LD3 { V5.8B, V6.8B, V7.8B }, [X17], X7
    ADD  X17, X17, X12
    ST3 { V9.H, V10.H, V11.H }[0x2], [X17]
    LD3 { V9.H, V10.H, V11.H }[0x6], [X17]
    ADD  X17, X17, X12, ASR #0
    ST3 { V20.S, V21.S, V22.S }[0x0], [X17]
    LD3 { V3.S, V4.S, V5.S }[0x0], [X17]
    ADD  X17, X17, X12, ASR #0
    ST3 { V4.D, V5.D, V6.D }[0x0], [X17]
    LD3 { V30.D, V31.D, V0.D }[0x0], [X17]
    ADD  X17, X17, X12, ASR #0
    ST3 { V28.B, V29.B, V30.B }[0xf], [X17]
    LD3 { V29.B, V30.B, V31.B }[0x8], [X17]
    ADD  X17, X17, X12
    MOV  X9, X17
    ST3 { V13.H, V14.H, V15.H }[0x5], [X9], #6
    MOV  X9, X17
    LD3 { V21.H, V22.H, V23.H }[0x4], [X9], #6
    ADD  X17, X17, X12
    ST3 { V23.H, V24.H, V25.H }[0x5], [X17], X7
    LD3 { V23.H, V24.H, V25.H }[0x7], [X17], X7
    ADD  X17, X17, X12, LSR #0
    MOV  X9, X17
    ST3 { V6.S, V7.S, V8.S }[0x1], [X9], #12
    MOV  X9, X17
    LD3 { V3.S, V4.S, V5.S }[0x2], [X9], #12
    ADD  X17, X17, X12
    ST3 { V5.S, V6.S, V7.S }[0x1], [X17], X7
    LD3 { V31.S, V0.S, V1.S }[0x1], [X17], X7
    ADD  X17, X17, X12, ASR #0
    MOV  X9, X17
    ST3 { V2.D, V3.D, V4.D }[0x1], [X9], #24
    MOV  X9, X17
    LD3 { V4.D, V5.D, V6.D }[0x1], [X9], #24
    ADD  X17, X17, X12, ASR #0
    ST3 { V4.D, V5.D, V6.D }[0x0], [X17], X7
    LD3 { V27.D, V28.D, V29.D }[0x0], [X17], X7
    ADD  X17, X17, X12, ASR #0
    MOV  X9, X17
    ST3 { V6.B, V7.B, V8.B }[0x3], [X9], #3
    MOV  X9, X17
    LD3 { V6.B, V7.B, V8.B }[0x1], [X9], #3
    ADD  X17, X17, X12, ASR #0
    ST3 { V5.B, V6.B, V7.B }[0xe], [X17], X7
    LD3 { V3.B, V4.B, V5.B }[0xa], [X17], X7
    ADD  X17, X17, X12
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X13, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MRS  X14, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D1
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D2
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa500, LSL #16
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D3
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D4
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa500, LSL #16
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D5
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5, LSL #32
    MOVK  X13, #0xa500, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D6
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D7
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D8
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D9
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D10
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D11
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D12
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D13
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D14
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D15
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D16
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D17
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D18
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5, LSL #16
    MOVK  X13, #0xa5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D19
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X13, #0xa500, LSL #0
    MOVK  X13, #0xa500, LSL #32
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D20
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D21
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D22
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D23
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D24
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D25
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D26
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D27
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D28
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D29
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X13, #0xa500, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D30
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X13, #0xa5, LSL #0
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X14, D31
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X10
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X17
    FMOV  D3, X3
    FMOV  V3.D[1], X6
    FMOV  D4, X3
    FMOV  V4.D[1], X8
    FMOV  D5, X9
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X13
    FMOV  D7, X13
    FMOV  V7.D[1], X29
    FMOV  D8, X10
    FMOV  V8.D[1], X15
    FMOV  D9, X7
    FMOV  V9.D[1], X26
    FMOV  D10, X11
    FMOV  V10.D[1], X4
    FMOV  D11, X9
    FMOV  V11.D[1], X24
    FMOV  D12, X9
    FMOV  V12.D[1], X3
    FMOV  D13, X12
    FMOV  V13.D[1], X10
    FMOV  D14, X5
    FMOV  V14.D[1], X23
    FMOV  D15, X29
    FMOV  V15.D[1], X25
    FMOV  D16, X25
    FMOV  V16.D[1], X15
    FMOV  D17, X24
    FMOV  V17.D[1], X6
    FMOV  D18, X23
    FMOV  V18.D[1], X8
    FMOV  D19, X4
    FMOV  V19.D[1], X27
    FMOV  D20, X9
    FMOV  V20.D[1], X13
    FMOV  D21, X6
    FMOV  V21.D[1], X15
    FMOV  D22, X5
    FMOV  V22.D[1], X8
    FMOV  D23, X6
    FMOV  V23.D[1], X8
    FMOV  D24, X17
    FMOV  V24.D[1], X11
    FMOV  D25, X16
    FMOV  V25.D[1], X15
    FMOV  D26, X26
    FMOV  V26.D[1], X27
    FMOV  D27, X16
    FMOV  V27.D[1], X28
    FMOV  D28, X29
    FMOV  V28.D[1], X9
    FMOV  D29, X13
    FMOV  V29.D[1], X6
    FMOV  D30, X26
    FMOV  V30.D[1], X8
    FMOV  D31, X12
    FMOV  V31.D[1], X23
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X29, #0x1e00, LSL #0
    ADD  X23, X30, X29, ASR #0
    ST3 { V20.8H, V21.8H, V22.8H }, [X23]
    LD3 { V11.4S, V12.4S, V13.4S }, [X23]
    ADD  X23, X23, X24, ASR #0
    ST3 { V17.16B, V18.16B, V19.16B }, [X23]
    LD3 { V17.16B, V18.16B, V19.16B }, [X23]
    ADD  X23, X23, X24, LSR #0
    ST3 { V3.2D, V4.2D, V5.2D }, [X23]
    LD3 { V24.2D, V25.2D, V26.2D }, [X23]
    ADD  X23, X23, X24, ASR #0
    ST3 { V11.4S, V12.4S, V13.4S }, [X23]
    LD3 { V2.4S, V3.4S, V4.4S }, [X23]
    ADD  X23, X23, X24
    ST3 { V11.8H, V12.8H, V13.8H }, [X23]
    LD3 { V31.8H, V0.8H, V1.8H }, [X23]
    ADD  X23, X23, X24
    ST3 { V1.4H, V2.4H, V3.4H }, [X23]
    LD3 { V8.8B, V9.8B, V10.8B }, [X23]
    ADD  X23, X23, X24
    ST3 { V24.2S, V25.2S, V26.2S }, [X23]
    LD3 { V31.2S, V0.2S, V1.2S }, [X23]
    ADD  X23, X23, X24, LSR #0
    ST3 { V17.4H, V18.4H, V19.4H }, [X23]
    LD3 { V7.4H, V8.4H, V9.4H }, [X23]
    ADD  X23, X23, X24, ASR #0
    ST3 { V11.8B, V12.8B, V13.8B }, [X23]
    LD3 { V24.8B, V25.8B, V26.8B }, [X23]
    ADD  X23, X23, X24
    MOV  X26, X23
    ST3 { V5.8H, V6.8H, V7.8H }, [X26], #48
    MOV  X26, X23
    LD3 { V5.2D, V6.2D, V7.2D }, [X26], #48
    ADD  X23, X23, X24, ASR #0
    MOV  X26, X23
    ST3 { V19.16B, V20.16B, V21.16B }, [X26], #48
    MOV  X26, X23
    LD3 { V5.16B, V6.16B, V7.16B }, [X26], #48
    ADD  X23, X23, X24
    MOV  X26, X23
    ST3 { V5.2D, V6.2D, V7.2D }, [X26], #48
    MOV  X26, X23
    LD3 { V10.2D, V11.2D, V12.2D }, [X26], #48
    ADD  X23, X23, X24
    MOV  X26, X23
    ST3 { V26.4S, V27.4S, V28.4S }, [X26], #48
    MOV  X26, X23
    LD3 { V14.4S, V15.4S, V16.4S }, [X26], #48
    ADD  X23, X23, X24, ASR #0
    MOV  X26, X23
    ST3 { V30.8H, V31.8H, V0.8H }, [X26], #48
    MOV  X26, X23
    LD3 { V10.8H, V11.8H, V12.8H }, [X26], #48
    ADD  X23, X23, X24, ASR #0
    MOV  X26, X23
    ST3 { V10.2S, V11.2S, V12.2S }, [X26], #24
    MOV  X26, X23
    LD3 { V10.4H, V11.4H, V12.4H }, [X26], #24
    ADD  X23, X23, X24, LSR #0
    MOV  X26, X23
    ST3 { V23.2S, V24.2S, V25.2S }, [X26], #24
    MOV  X26, X23
    LD3 { V29.2S, V30.2S, V31.2S }, [X26], #24
    ADD  X23, X23, X24, LSR #0
    MOV  X26, X23
    ST3 { V16.4H, V17.4H, V18.4H }, [X26], #24
    MOV  X26, X23
    LD3 { V16.4H, V17.4H, V18.4H }, [X26], #24
    ADD  X23, X23, X24, LSR #0
    MOV  X26, X23
    ST3 { V10.8B, V11.8B, V12.8B }, [X26], #24
    MOV  X26, X23
    LD3 { V13.8B, V14.8B, V15.8B }, [X26], #24
    ADD  X23, X23, X24, LSR #0
    ST3 { V29.16B, V30.16B, V31.16B }, [X23], X2
    LD3 { V10.2D, V11.2D, V12.2D }, [X23], X2
    ADD  X23, X23, X24
    ST3 { V14.16B, V15.16B, V16.16B }, [X23], X2
    LD3 { V15.16B, V16.16B, V17.16B }, [X23], X2
    ADD  X23, X23, X24
    ST3 { V28.2D, V29.2D, V30.2D }, [X23], X2
    LD3 { V29.2D, V30.2D, V31.2D }, [X23], X2
    ADD  X23, X23, X24, LSR #0
    ST3 { V23.4S, V24.4S, V25.4S }, [X23], X2
    LD3 { V31.4S, V0.4S, V1.4S }, [X23], X2
    ADD  X23, X23, X24, ASR #0
    ST3 { V28.8H, V29.8H, V30.8H }, [X23], X2
    LD3 { V28.8H, V29.8H, V30.8H }, [X23], X2
    ADD  X23, X23, X24, LSR #0
    ST3 { V29.4H, V30.4H, V31.4H }, [X23], X2
    LD3 { V29.4H, V30.4H, V31.4H }, [X23], X2
    ADD  X23, X23, X24, ASR #0
    ST3 { V9.2S, V10.2S, V11.2S }, [X23], X2
    LD3 { V9.2S, V10.2S, V11.2S }, [X23], X2
    ADD  X23, X23, X24, LSR #0
    ST3 { V28.4H, V29.4H, V30.4H }, [X23], X2
    LD3 { V28.4H, V29.4H, V30.4H }, [X23], X2
    ADD  X23, X23, X24
    ST3 { V14.8B, V15.8B, V16.8B }, [X23], X2
    LD3 { V14.8B, V15.8B, V16.8B }, [X23], X2
    ADD  X23, X23, X24, LSR #0
    ST3 { V18.H, V19.H, V20.H }[0x6], [X23]
    LD3 { V8.H, V9.H, V10.H }[0x7], [X23]
    ADD  X23, X23, X24, ASR #0
    ST3 { V11.S, V12.S, V13.S }[0x0], [X23]
    LD3 { V11.S, V12.S, V13.S }[0x2], [X23]
    ADD  X23, X23, X24, ASR #0
    ST3 { V10.D, V11.D, V12.D }[0x0], [X23]
    LD3 { V2.D, V3.D, V4.D }[0x0], [X23]
    ADD  X23, X23, X24, LSR #0
    ST3 { V29.B, V30.B, V31.B }[0xb], [X23]
    LD3 { V14.B, V15.B, V16.B }[0xd], [X23]
    ADD  X23, X23, X24, LSR #0
    MOV  X26, X23
    ST3 { V14.H, V15.H, V16.H }[0x7], [X26], #6
    MOV  X26, X23
    LD3 { V10.H, V11.H, V12.H }[0x5], [X26], #6
    ADD  X23, X23, X24, ASR #0
    ST3 { V8.H, V9.H, V10.H }[0x4], [X23], X2
    LD3 { V14.H, V15.H, V16.H }[0x0], [X23], X2
    ADD  X23, X23, X24, LSR #0
    MOV  X26, X23
    ST3 { V2.S, V3.S, V4.S }[0x2], [X26], #12
    MOV  X26, X23
    LD3 { V8.S, V9.S, V10.S }[0x2], [X26], #12
    ADD  X23, X23, X24, LSR #0
    ST3 { V14.S, V15.S, V16.S }[0x3], [X23], X2
    LD3 { V29.S, V30.S, V31.S }[0x1], [X23], X2
    ADD  X23, X23, X24
    MOV  X26, X23
    ST3 { V20.D, V21.D, V22.D }[0x1], [X26], #24
    MOV  X26, X23
    LD3 { V21.D, V22.D, V23.D }[0x0], [X26], #24
    ADD  X23, X23, X24, LSR #0
    ST3 { V21.D, V22.D, V23.D }[0x0], [X23], X2
    LD3 { V21.D, V22.D, V23.D }[0x1], [X23], X2
    ADD  X23, X23, X24
    MOV  X26, X23
    ST3 { V17.B, V18.B, V19.B }[0x9], [X26], #3
    MOV  X26, X23
    LD3 { V16.B, V17.B, V18.B }[0x6], [X26], #3
    ADD  X23, X23, X24, LSR #0
    ST3 { V16.B, V17.B, V18.B }[0x0], [X23], X2
    LD3 { V16.B, V17.B, V18.B }[0x6], [X23], X2
    ADD  X23, X23, X24, ASR #0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MRS  X10, FPSR
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D1
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D2
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D3
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D4
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D5
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D6
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D7
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D8
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D9
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D10
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D11
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D12
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D13
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D14
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D15
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D16
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a00, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D17
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D18
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D19
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D20
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D21
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D22
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D23
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D24
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D25
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D26
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D27
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D28
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D29
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D30
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
    FMOV  X10, D31
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP06_TestFail
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
    FMOV  V0.D[1], X2
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X9
    FMOV  V2.D[1], X17
    FMOV  D3, X27
    FMOV  V3.D[1], X23
    FMOV  D4, X28
    FMOV  V4.D[1], X24
    FMOV  D5, X23
    FMOV  V5.D[1], X27
    FMOV  D6, X2
    FMOV  V6.D[1], X29
    FMOV  D7, X28
    FMOV  V7.D[1], X4
    FMOV  D8, X26
    FMOV  V8.D[1], X9
    FMOV  D9, X12
    FMOV  V9.D[1], X13
    FMOV  D10, X7
    FMOV  V10.D[1], X3
    FMOV  D11, X24
    FMOV  V11.D[1], X12
    FMOV  D12, X17
    FMOV  V12.D[1], X25
    FMOV  D13, X16
    FMOV  V13.D[1], X5
    FMOV  D14, X3
    FMOV  V14.D[1], X28
    FMOV  D15, X14
    FMOV  V15.D[1], X11
    FMOV  D16, X5
    FMOV  V16.D[1], X17
    FMOV  D17, X8
    FMOV  V17.D[1], X11
    FMOV  D18, X4
    FMOV  V18.D[1], X26
    FMOV  D19, X3
    FMOV  V19.D[1], X10
    FMOV  D20, X26
    FMOV  V20.D[1], X6
    FMOV  D21, X4
    FMOV  V21.D[1], X13
    FMOV  D22, X13
    FMOV  V22.D[1], X8
    FMOV  D23, X24
    FMOV  V23.D[1], X9
    FMOV  D24, X6
    FMOV  V24.D[1], X5
    FMOV  D25, X13
    FMOV  V25.D[1], X24
    FMOV  D26, X28
    FMOV  V26.D[1], X29
    FMOV  D27, X28
    FMOV  V27.D[1], X4
    FMOV  D28, X9
    FMOV  V28.D[1], X13
    FMOV  D29, X29
    FMOV  V29.D[1], X26
    FMOV  D30, X17
    FMOV  V30.D[1], X12
    FMOV  D31, X23
    FMOV  V31.D[1], X15
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X14, #0x2300, LSL #0
    ADD  X10, X30, X14
    ST3 { V7.2D, V8.2D, V9.2D }, [X10]
    LD3 { V12.4S, V13.4S, V14.4S }, [X10]
    ADD  X10, X10, X24, LSR #0
    ST3 { V29.16B, V30.16B, V31.16B }, [X10]
    LD3 { V6.16B, V7.16B, V8.16B }, [X10]
    ADD  X10, X10, X24, ASR #0
    ST3 { V2.2D, V3.2D, V4.2D }, [X10]
    LD3 { V8.2D, V9.2D, V10.2D }, [X10]
    ADD  X10, X10, X24, LSR #0
    ST3 { V8.4S, V9.4S, V10.4S }, [X10]
    LD3 { V15.4S, V16.4S, V17.4S }, [X10]
    ADD  X10, X10, X24, ASR #0
    ST3 { V15.8H, V16.8H, V17.8H }, [X10]
    LD3 { V23.8H, V24.8H, V25.8H }, [X10]
    ADD  X10, X10, X24
    ST3 { V22.2S, V23.2S, V24.2S }, [X10]
    LD3 { V3.2S, V4.2S, V5.2S }, [X10]
    ADD  X10, X10, X24
    ST3 { V12.2S, V13.2S, V14.2S }, [X10]
    LD3 { V12.2S, V13.2S, V14.2S }, [X10]
    ADD  X10, X10, X24, LSR #0
    ST3 { V10.4H, V11.4H, V12.4H }, [X10]
    LD3 { V10.4H, V11.4H, V12.4H }, [X10]
    ADD  X10, X10, X24
    ST3 { V4.8B, V5.8B, V6.8B }, [X10]
    LD3 { V4.8B, V5.8B, V6.8B }, [X10]
    ADD  X10, X10, X24, ASR #0
    MOV  X3, X10
    ST3 { V20.16B, V21.16B, V22.16B }, [X3], #48
    MOV  X3, X10
    LD3 { V25.4S, V26.4S, V27.4S }, [X3], #48
    ADD  X10, X10, X24
    MOV  X3, X10
    ST3 { V3.16B, V4.16B, V5.16B }, [X3], #48
    MOV  X3, X10
    LD3 { V22.16B, V23.16B, V24.16B }, [X3], #48
    ADD  X10, X10, X24, ASR #0
    MOV  X3, X10
    ST3 { V24.2D, V25.2D, V26.2D }, [X3], #48
    MOV  X3, X10
    LD3 { V3.2D, V4.2D, V5.2D }, [X3], #48
    ADD  X10, X10, X24, LSR #0
    MOV  X3, X10
    ST3 { V19.4S, V20.4S, V21.4S }, [X3], #48
    MOV  X3, X10
    LD3 { V25.4S, V26.4S, V27.4S }, [X3], #48
    ADD  X10, X10, X24
    MOV  X3, X10
    ST3 { V25.8H, V26.8H, V27.8H }, [X3], #48
    MOV  X3, X10
    LD3 { V23.8H, V24.8H, V25.8H }, [X3], #48
    ADD  X10, X10, X24, LSR #0
    MOV  X3, X10
    ST3 { V3.8B, V4.8B, V5.8B }, [X3], #24
    MOV  X3, X10
    LD3 { V19.4H, V20.4H, V21.4H }, [X3], #24
    ADD  X10, X10, X24, ASR #0
    MOV  X3, X10
    ST3 { V4.2S, V5.2S, V6.2S }, [X3], #24
    MOV  X3, X10
    LD3 { V3.2S, V4.2S, V5.2S }, [X3], #24
    ADD  X10, X10, X24
    MOV  X3, X10
    ST3 { V27.4H, V28.4H, V29.4H }, [X3], #24
    MOV  X3, X10
    LD3 { V27.4H, V28.4H, V29.4H }, [X3], #24
    ADD  X10, X10, X24, LSR #0
    MOV  X3, X10
    ST3 { V26.8B, V27.8B, V28.8B }, [X3], #24
    MOV  X3, X10
    LD3 { V26.8B, V27.8B, V28.8B }, [X3], #24
    ADD  X10, X10, X24
    ST3 { V26.16B, V27.16B, V28.16B }, [X10], X23
    LD3 { V4.16B, V5.16B, V6.16B }, [X10], X23
    ADD  X10, X10, X24
    ST3 { V3.16B, V4.16B, V5.16B }, [X10], X23
    LD3 { V19.16B, V20.16B, V21.16B }, [X10], X23
    ADD  X10, X10, X24, ASR #0
    ST3 { V30.2D, V31.2D, V0.2D }, [X10], X23
    LD3 { V31.2D, V0.2D, V1.2D }, [X10], X23
    ADD  X10, X10, X24, LSR #0
    ST3 { V12.4S, V13.4S, V14.4S }, [X10], X23
    LD3 { V9.4S, V10.4S, V11.4S }, [X10], X23
    ADD  X10, X10, X24
    ST3 { V9.8H, V10.8H, V11.8H }, [X10], X23
    LD3 { V31.8H, V0.8H, V1.8H }, [X10], X23
    ADD  X10, X10, X24
    ST3 { V23.4H, V24.4H, V25.4H }, [X10], X23
    LD3 { V3.2S, V4.2S, V5.2S }, [X10], X23
    ADD  X10, X10, X24
    ST3 { V31.2S, V0.2S, V1.2S }, [X10], X23
    LD3 { V9.2S, V10.2S, V11.2S }, [X10], X23
    ADD  X10, X10, X24, ASR #0
    ST3 { V3.4H, V4.4H, V5.4H }, [X10], X23
    LD3 { V27.4H, V28.4H, V29.4H }, [X10], X23
    ADD  X10, X10, X24, LSR #0
    ST3 { V9.8B, V10.8B, V11.8B }, [X10], X23
    LD3 { V3.8B, V4.8B, V5.8B }, [X10], X23
    ADD  X10, X10, X24, LSR #0
    ST3 { V27.H, V28.H, V29.H }[0x2], [X10]
    LD3 { V31.H, V0.H, V1.H }[0x6], [X10]
    ADD  X10, X10, X24, ASR #0
    ST3 { V31.S, V0.S, V1.S }[0x1], [X10]
    LD3 { V17.S, V18.S, V19.S }[0x1], [X10]
    ADD  X10, X10, X24, LSR #0
    ST3 { V23.D, V24.D, V25.D }[0x1], [X10]
    LD3 { V31.D, V0.D, V1.D }[0x0], [X10]
    ADD  X10, X10, X24
    ST3 { V3.B, V4.B, V5.B }[0x2], [X10]
    LD3 { V2.B, V3.B, V4.B }[0x5], [X10]
    ADD  X10, X10, X24, ASR #0
    MOV  X3, X10
    ST3 { V1.H, V2.H, V3.H }[0x0], [X3], #6
    MOV  X3, X10
    LD3 { V1.H, V2.H, V3.H }[0x5], [X3], #6
    ADD  X10, X10, X24, LSR #0
    ST3 { V2.H, V3.H, V4.H }[0x6], [X10], X23
    LD3 { V27.H, V28.H, V29.H }[0x6], [X10], X23
    ADD  X10, X10, X24, LSR #0
    MOV  X3, X10
    ST3 { V9.S, V10.S, V11.S }[0x1], [X3], #12
    MOV  X3, X10
    LD3 { V23.S, V24.S, V25.S }[0x0], [X3], #12
    ADD  X10, X10, X24, ASR #0
    ST3 { V8.S, V9.S, V10.S }[0x2], [X10], X23
    LD3 { V9.S, V10.S, V11.S }[0x1], [X10], X23
    ADD  X10, X10, X24, ASR #0
    MOV  X3, X10
    ST3 { V2.D, V3.D, V4.D }[0x1], [X3], #24
    MOV  X3, X10
    LD3 { V12.D, V13.D, V14.D }[0x1], [X3], #24
    ADD  X10, X10, X24, LSR #0
    ST3 { V3.D, V4.D, V5.D }[0x0], [X10], X23
    LD3 { V6.D, V7.D, V8.D }[0x1], [X10], X23
    ADD  X10, X10, X24, LSR #0
    MOV  X3, X10
    ST3 { V11.B, V12.B, V13.B }[0x4], [X3], #3
    MOV  X3, X10
    LD3 { V2.B, V3.B, V4.B }[0x5], [X3], #3
    ADD  X10, X10, X24
    ST3 { V8.B, V9.B, V10.B }[0x7], [X10], X23
    LD3 { V13.B, V14.B, V15.B }[0x5], [X10], X23
    ADD  X10, X10, X24, LSR #0
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X25, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MRS  X26, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D12
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D18
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D24
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D28
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    FMOV  X26, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X8, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X23
    FMOV  D3, X13
    FMOV  V3.D[1], X16
    FMOV  D4, X10
    FMOV  V4.D[1], X17
    FMOV  D5, X2
    FMOV  V5.D[1], X8
    FMOV  D6, X28
    FMOV  V6.D[1], X23
    FMOV  D7, X11
    FMOV  V7.D[1], X29
    FMOV  D8, X17
    FMOV  V8.D[1], X6
    FMOV  D9, X3
    FMOV  V9.D[1], X13
    FMOV  D10, X15
    FMOV  V10.D[1], X2
    FMOV  D11, X23
    FMOV  V11.D[1], X27
    FMOV  D12, X7
    FMOV  V12.D[1], X13
    FMOV  D13, X3
    FMOV  V13.D[1], X23
    FMOV  D14, X12
    FMOV  V14.D[1], X11
    FMOV  D15, X7
    FMOV  V15.D[1], X4
    FMOV  D16, X2
    FMOV  V16.D[1], X17
    FMOV  D17, X8
    FMOV  V17.D[1], X3
    FMOV  D18, X12
    FMOV  V18.D[1], X7
    FMOV  D19, X6
    FMOV  V19.D[1], X29
    FMOV  D20, X23
    FMOV  V20.D[1], X5
    FMOV  D21, X9
    FMOV  V21.D[1], X9
    FMOV  D22, X6
    FMOV  V22.D[1], X13
    FMOV  D23, X26
    FMOV  V23.D[1], X16
    FMOV  D24, X13
    FMOV  V24.D[1], X28
    FMOV  D25, X3
    FMOV  V25.D[1], X25
    FMOV  D26, X14
    FMOV  V26.D[1], X11
    FMOV  D27, X7
    FMOV  V27.D[1], X29
    FMOV  D28, X25
    FMOV  V28.D[1], X23
    FMOV  D29, X26
    FMOV  V29.D[1], X12
    FMOV  D30, X16
    FMOV  V30.D[1], X26
    FMOV  D31, X14
    FMOV  V31.D[1], X2
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X23, #0x2800, LSL #0
    ADD  X11, X30, X23
    ST3 { V28.4S, V29.4S, V30.4S }, [X11]
    LD3 { V15.4S, V16.4S, V17.4S }, [X11]
    ADD  X11, X11, X26
    ST3 { V25.16B, V26.16B, V27.16B }, [X11]
    LD3 { V20.16B, V21.16B, V22.16B }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST3 { V20.2D, V21.2D, V22.2D }, [X11]
    LD3 { V24.2D, V25.2D, V26.2D }, [X11]
    ADD  X11, X11, X26
    ST3 { V3.4S, V4.4S, V5.4S }, [X11]
    LD3 { V12.4S, V13.4S, V14.4S }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST3 { V13.8H, V14.8H, V15.8H }, [X11]
    LD3 { V14.8H, V15.8H, V16.8H }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST3 { V31.2S, V0.2S, V1.2S }, [X11]
    LD3 { V2.4H, V3.4H, V4.4H }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST3 { V28.2S, V29.2S, V30.2S }, [X11]
    LD3 { V23.2S, V24.2S, V25.2S }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST3 { V3.4H, V4.4H, V5.4H }, [X11]
    LD3 { V19.4H, V20.4H, V21.4H }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST3 { V14.8B, V15.8B, V16.8B }, [X11]
    LD3 { V30.8B, V31.8B, V0.8B }, [X11]
    ADD  X11, X11, X26, LSR #0
    MOV  X2, X11
    ST3 { V23.2D, V24.2D, V25.2D }, [X2], #48
    MOV  X2, X11
    LD3 { V23.16B, V24.16B, V25.16B }, [X2], #48
    ADD  X11, X11, X26, LSR #0
    MOV  X2, X11
    ST3 { V23.16B, V24.16B, V25.16B }, [X2], #48
    MOV  X2, X11
    LD3 { V16.16B, V17.16B, V18.16B }, [X2], #48
    ADD  X11, X11, X26, LSR #0
    MOV  X2, X11
    ST3 { V30.2D, V31.2D, V0.2D }, [X2], #48
    MOV  X2, X11
    LD3 { V23.2D, V24.2D, V25.2D }, [X2], #48
    ADD  X11, X11, X26
    MOV  X2, X11
    ST3 { V20.4S, V21.4S, V22.4S }, [X2], #48
    MOV  X2, X11
    LD3 { V3.4S, V4.4S, V5.4S }, [X2], #48
    ADD  X11, X11, X26, ASR #0
    MOV  X2, X11
    ST3 { V16.8H, V17.8H, V18.8H }, [X2], #48
    MOV  X2, X11
    LD3 { V30.8H, V31.8H, V0.8H }, [X2], #48
    ADD  X11, X11, X26
    MOV  X2, X11
    ST3 { V23.8B, V24.8B, V25.8B }, [X2], #24
    MOV  X2, X11
    LD3 { V21.8B, V22.8B, V23.8B }, [X2], #24
    ADD  X11, X11, X26, ASR #0
    MOV  X2, X11
    ST3 { V21.2S, V22.2S, V23.2S }, [X2], #24
    MOV  X2, X11
    LD3 { V30.2S, V31.2S, V0.2S }, [X2], #24
    ADD  X11, X11, X26, LSR #0
    MOV  X2, X11
    ST3 { V30.4H, V31.4H, V0.4H }, [X2], #24
    MOV  X2, X11
    LD3 { V21.4H, V22.4H, V23.4H }, [X2], #24
    ADD  X11, X11, X26, ASR #0
    MOV  X2, X11
    ST3 { V1.8B, V2.8B, V3.8B }, [X2], #24
    MOV  X2, X11
    LD3 { V31.8B, V0.8B, V1.8B }, [X2], #24
    ADD  X11, X11, X26, LSR #0
    ST3 { V12.4S, V13.4S, V14.4S }, [X11], X7
    LD3 { V12.4S, V13.4S, V14.4S }, [X11], X7
    ADD  X11, X11, X26
    ST3 { V12.16B, V13.16B, V14.16B }, [X11], X7
    LD3 { V12.16B, V13.16B, V14.16B }, [X11], X7
    ADD  X11, X11, X26
    ST3 { V15.2D, V16.2D, V17.2D }, [X11], X7
    LD3 { V2.2D, V3.2D, V4.2D }, [X11], X7
    ADD  X11, X11, X26, ASR #0
    ST3 { V31.4S, V0.4S, V1.4S }, [X11], X7
    LD3 { V22.4S, V23.4S, V24.4S }, [X11], X7
    ADD  X11, X11, X26, LSR #0
    ST3 { V12.8H, V13.8H, V14.8H }, [X11], X7
    LD3 { V12.8H, V13.8H, V14.8H }, [X11], X7
    ADD  X11, X11, X26, LSR #0
    ST3 { V8.2S, V9.2S, V10.2S }, [X11], X7
    LD3 { V26.2S, V27.2S, V28.2S }, [X11], X7
    ADD  X11, X11, X26, LSR #0
    ST3 { V19.2S, V20.2S, V21.2S }, [X11], X7
    LD3 { V8.2S, V9.2S, V10.2S }, [X11], X7
    ADD  X11, X11, X26
    ST3 { V8.4H, V9.4H, V10.4H }, [X11], X7
    LD3 { V17.4H, V18.4H, V19.4H }, [X11], X7
    ADD  X11, X11, X26, LSR #0
    ST3 { V30.8B, V31.8B, V0.8B }, [X11], X7
    LD3 { V30.8B, V31.8B, V0.8B }, [X11], X7
    ADD  X11, X11, X26, LSR #0
    ST3 { V10.H, V11.H, V12.H }[0x1], [X11]
    LD3 { V15.H, V16.H, V17.H }[0x2], [X11]
    ADD  X11, X11, X26, ASR #0
    ST3 { V31.S, V0.S, V1.S }[0x3], [X11]
    LD3 { V16.S, V17.S, V18.S }[0x2], [X11]
    ADD  X11, X11, X26, ASR #0
    ST3 { V31.D, V0.D, V1.D }[0x1], [X11]
    LD3 { V3.D, V4.D, V5.D }[0x1], [X11]
    ADD  X11, X11, X26
    ST3 { V26.B, V27.B, V28.B }[0xd], [X11]
    LD3 { V31.B, V0.B, V1.B }[0xc], [X11]
    ADD  X11, X11, X26, ASR #0
    MOV  X2, X11
    ST3 { V31.H, V0.H, V1.H }[0x0], [X2], #6
    MOV  X2, X11
    LD3 { V18.H, V19.H, V20.H }[0x6], [X2], #6
    ADD  X11, X11, X26, LSR #0
    ST3 { V15.H, V16.H, V17.H }[0x5], [X11], X7
    LD3 { V4.H, V5.H, V6.H }[0x3], [X11], X7
    ADD  X11, X11, X26, ASR #0
    MOV  X2, X11
    ST3 { V17.S, V18.S, V19.S }[0x1], [X2], #12
    MOV  X2, X11
    LD3 { V7.S, V8.S, V9.S }[0x1], [X2], #12
    ADD  X11, X11, X26, ASR #0
    ST3 { V31.S, V0.S, V1.S }[0x2], [X11], X7
    LD3 { V15.S, V16.S, V17.S }[0x2], [X11], X7
    ADD  X11, X11, X26, ASR #0
    MOV  X2, X11
    ST3 { V1.D, V2.D, V3.D }[0x0], [X2], #24
    MOV  X2, X11
    LD3 { V12.D, V13.D, V14.D }[0x0], [X2], #24
    ADD  X11, X11, X26, LSR #0
    ST3 { V12.D, V13.D, V14.D }[0x0], [X11], X7
    LD3 { V31.D, V0.D, V1.D }[0x0], [X11], X7
    ADD  X11, X11, X26
    MOV  X2, X11
    ST3 { V5.B, V6.B, V7.B }[0x5], [X2], #3
    MOV  X2, X11
    LD3 { V25.B, V26.B, V27.B }[0xc], [X2], #3
    ADD  X11, X11, X26
    ST3 { V31.B, V0.B, V1.B }[0x0], [X11], X7
    LD3 { V31.B, V0.B, V1.B }[0xd], [X11], X7
    ADD  X11, X11, X26
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MRS  X15, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a00, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a00, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D1
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D2
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D5
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D6
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D7
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D8
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D9
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D10
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D11
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D12
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D14
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D15
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D16
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D17
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D18
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D19
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D20
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D22
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D23
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D24
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D25
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D26
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D27
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D29
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D30
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a00, LSL #32
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    FMOV  X15, D31
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X7
    FMOV  D2, X26
    FMOV  V2.D[1], X7
    FMOV  D3, X28
    FMOV  V3.D[1], X23
    FMOV  D4, X7
    FMOV  V4.D[1], X3
    FMOV  D5, X24
    FMOV  V5.D[1], X6
    FMOV  D6, X7
    FMOV  V6.D[1], X9
    FMOV  D7, X7
    FMOV  V7.D[1], X6
    FMOV  D8, X7
    FMOV  V8.D[1], X28
    FMOV  D9, X7
    FMOV  V9.D[1], X23
    FMOV  D10, X17
    FMOV  V10.D[1], X10
    FMOV  D11, X8
    FMOV  V11.D[1], X6
    FMOV  D12, X6
    FMOV  V12.D[1], X12
    FMOV  D13, X28
    FMOV  V13.D[1], X3
    FMOV  D14, X14
    FMOV  V14.D[1], X28
    FMOV  D15, X14
    FMOV  V15.D[1], X8
    FMOV  D16, X3
    FMOV  V16.D[1], X12
    FMOV  D17, X11
    FMOV  V17.D[1], X17
    FMOV  D18, X26
    FMOV  V18.D[1], X9
    FMOV  D19, X3
    FMOV  V19.D[1], X7
    FMOV  D20, X12
    FMOV  V20.D[1], X23
    FMOV  D21, X24
    FMOV  V21.D[1], X23
    FMOV  D22, X24
    FMOV  V22.D[1], X2
    FMOV  D23, X12
    FMOV  V23.D[1], X2
    FMOV  D24, X23
    FMOV  V24.D[1], X13
    FMOV  D25, X2
    FMOV  V25.D[1], X6
    FMOV  D26, X25
    FMOV  V26.D[1], X29
    FMOV  D27, X9
    FMOV  V27.D[1], X15
    FMOV  D28, X3
    FMOV  V28.D[1], X4
    FMOV  D29, X28
    FMOV  V29.D[1], X2
    FMOV  D30, X23
    FMOV  V30.D[1], X16
    FMOV  D31, X10
    FMOV  V31.D[1], X8
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X9, #0x2d00, LSL #0
    ADD  X11, X30, X9
    ST3 { V19.4S, V20.4S, V21.4S }, [X11]
    LD3 { V0.8H, V1.8H, V2.8H }, [X11]
    ADD  X11, X11, X6, ASR #0
    ST3 { V22.16B, V23.16B, V24.16B }, [X11]
    LD3 { V26.16B, V27.16B, V28.16B }, [X11]
    ADD  X11, X11, X6, ASR #0
    ST3 { V26.2D, V27.2D, V28.2D }, [X11]
    LD3 { V17.2D, V18.2D, V19.2D }, [X11]
    ADD  X11, X11, X6
    ST3 { V31.4S, V0.4S, V1.4S }, [X11]
    LD3 { V26.4S, V27.4S, V28.4S }, [X11]
    ADD  X11, X11, X6, LSR #0
    ST3 { V26.8H, V27.8H, V28.8H }, [X11]
    LD3 { V30.8H, V31.8H, V0.8H }, [X11]
    ADD  X11, X11, X6, ASR #0
    ST3 { V31.2S, V0.2S, V1.2S }, [X11]
    LD3 { V12.2S, V13.2S, V14.2S }, [X11]
    ADD  X11, X11, X6, LSR #0
    ST3 { V1.2S, V2.2S, V3.2S }, [X11]
    LD3 { V1.2S, V2.2S, V3.2S }, [X11]
    ADD  X11, X11, X6, LSR #0
    ST3 { V24.4H, V25.4H, V26.4H }, [X11]
    LD3 { V27.4H, V28.4H, V29.4H }, [X11]
    ADD  X11, X11, X6, ASR #0
    ST3 { V17.8B, V18.8B, V19.8B }, [X11]
    LD3 { V2.8B, V3.8B, V4.8B }, [X11]
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V28.16B, V29.16B, V30.16B }, [X15], #48
    MOV  X15, X11
    LD3 { V20.2D, V21.2D, V22.2D }, [X15], #48
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V12.16B, V13.16B, V14.16B }, [X15], #48
    MOV  X15, X11
    LD3 { V30.16B, V31.16B, V0.16B }, [X15], #48
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V30.2D, V31.2D, V0.2D }, [X15], #48
    MOV  X15, X11
    LD3 { V24.2D, V25.2D, V26.2D }, [X15], #48
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V17.4S, V18.4S, V19.4S }, [X15], #48
    MOV  X15, X11
    LD3 { V30.4S, V31.4S, V0.4S }, [X15], #48
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V28.8H, V29.8H, V30.8H }, [X15], #48
    MOV  X15, X11
    LD3 { V18.8H, V19.8H, V20.8H }, [X15], #48
    ADD  X11, X11, X6
    MOV  X15, X11
    ST3 { V2.4H, V3.4H, V4.4H }, [X15], #24
    MOV  X15, X11
    LD3 { V2.4H, V3.4H, V4.4H }, [X15], #24
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V18.2S, V19.2S, V20.2S }, [X15], #24
    MOV  X15, X11
    LD3 { V12.2S, V13.2S, V14.2S }, [X15], #24
    ADD  X11, X11, X6
    MOV  X15, X11
    ST3 { V18.4H, V19.4H, V20.4H }, [X15], #24
    MOV  X15, X11
    LD3 { V18.4H, V19.4H, V20.4H }, [X15], #24
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V30.8B, V31.8B, V0.8B }, [X15], #24
    MOV  X15, X11
    LD3 { V21.8B, V22.8B, V23.8B }, [X15], #24
    ADD  X11, X11, X6
    ST3 { V13.2D, V14.2D, V15.2D }, [X11], X23
    LD3 { V18.16B, V19.16B, V20.16B }, [X11], X23
    ADD  X11, X11, X6, ASR #0
    ST3 { V2.16B, V3.16B, V4.16B }, [X11], X23
    LD3 { V30.16B, V31.16B, V0.16B }, [X11], X23
    ADD  X11, X11, X6, ASR #0
    ST3 { V28.2D, V29.2D, V30.2D }, [X11], X23
    LD3 { V2.2D, V3.2D, V4.2D }, [X11], X23
    ADD  X11, X11, X6, LSR #0
    ST3 { V15.4S, V16.4S, V17.4S }, [X11], X23
    LD3 { V13.4S, V14.4S, V15.4S }, [X11], X23
    ADD  X11, X11, X6
    ST3 { V18.8H, V19.8H, V20.8H }, [X11], X23
    LD3 { V18.8H, V19.8H, V20.8H }, [X11], X23
    ADD  X11, X11, X6, ASR #0
    ST3 { V15.4H, V16.4H, V17.4H }, [X11], X23
    LD3 { V29.2S, V30.2S, V31.2S }, [X11], X23
    ADD  X11, X11, X6, LSR #0
    ST3 { V0.2S, V1.2S, V2.2S }, [X11], X23
    LD3 { V18.2S, V19.2S, V20.2S }, [X11], X23
    ADD  X11, X11, X6
    ST3 { V29.4H, V30.4H, V31.4H }, [X11], X23
    LD3 { V25.4H, V26.4H, V27.4H }, [X11], X23
    ADD  X11, X11, X6, LSR #0
    ST3 { V18.8B, V19.8B, V20.8B }, [X11], X23
    LD3 { V16.8B, V17.8B, V18.8B }, [X11], X23
    ADD  X11, X11, X6, ASR #0
    ST3 { V8.H, V9.H, V10.H }[0x0], [X11]
    LD3 { V30.H, V31.H, V0.H }[0x2], [X11]
    ADD  X11, X11, X6
    ST3 { V30.S, V31.S, V0.S }[0x0], [X11]
    LD3 { V8.S, V9.S, V10.S }[0x1], [X11]
    ADD  X11, X11, X6
    ST3 { V16.D, V17.D, V18.D }[0x1], [X11]
    LD3 { V0.D, V1.D, V2.D }[0x0], [X11]
    ADD  X11, X11, X6, ASR #0
    ST3 { V0.B, V1.B, V2.B }[0x7], [X11]
    LD3 { V18.B, V19.B, V20.B }[0x2], [X11]
    ADD  X11, X11, X6
    MOV  X15, X11
    ST3 { V27.H, V28.H, V29.H }[0x3], [X15], #6
    MOV  X15, X11
    LD3 { V11.H, V12.H, V13.H }[0x0], [X15], #6
    ADD  X11, X11, X6
    ST3 { V13.H, V14.H, V15.H }[0x0], [X11], X23
    LD3 { V28.H, V29.H, V30.H }[0x6], [X11], X23
    ADD  X11, X11, X6
    MOV  X15, X11
    ST3 { V18.S, V19.S, V20.S }[0x3], [X15], #12
    MOV  X15, X11
    LD3 { V26.S, V27.S, V28.S }[0x2], [X15], #12
    ADD  X11, X11, X6, LSR #0
    ST3 { V13.S, V14.S, V15.S }[0x1], [X11], X23
    LD3 { V10.S, V11.S, V12.S }[0x3], [X11], X23
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V27.D, V28.D, V29.D }[0x1], [X15], #24
    MOV  X15, X11
    LD3 { V18.D, V19.D, V20.D }[0x1], [X15], #24
    ADD  X11, X11, X6
    ST3 { V23.D, V24.D, V25.D }[0x0], [X11], X23
    LD3 { V23.D, V24.D, V25.D }[0x0], [X11], X23
    ADD  X11, X11, X6, ASR #0
    MOV  X15, X11
    ST3 { V16.B, V17.B, V18.B }[0x7], [X15], #3
    MOV  X15, X11
    LD3 { V23.B, V24.B, V25.B }[0xc], [X15], #3
    ADD  X11, X11, X6
    ST3 { V1.B, V2.B, V3.B }[0x1], [X11], X23
    LD3 { V13.B, V14.B, V15.B }[0x0], [X11], X23
    ADD  X11, X11, X6, LSR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MRS  X4, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D12
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D13
    MOVZ  X25, #0xa500, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D14
    MOVZ  X25, #0xa500, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D18
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa500, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa500, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa500, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D24
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D28
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xa5a5, LSL #32
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    FMOV  X4, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail

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
