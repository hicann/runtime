.global LCRTAdvsimdVectorFhmI8mm

.text
.p2align 4

LCRTAdvsimdVectorFhmI8mm:

LCRTAdvsimdVectorFhmI8mm_TestBegin:
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
    MOVZ  X2, #0xe838, LSL #0
    MOVK  X2, #0xb643, LSL #16
    MOVK  X2, #0x9c88, LSL #32
    MOVK  X2, #0xf0b1, LSL #48
    MOVZ  X3, #0x63ac, LSL #0
    MOVK  X3, #0x7753, LSL #16
    MOVK  X3, #0x3b58, LSL #32
    MOVK  X3, #0xfe54, LSL #48
    MOVZ  X6, #0x2796, LSL #0
    MOVK  X6, #0x429, LSL #16
    MOVK  X6, #0xd686, LSL #32
    MOVK  X6, #0x219a, LSL #48
    MOVZ  X8, #0xfe78, LSL #0
    MOVK  X8, #0x7d6b, LSL #16
    MOVK  X8, #0xb704, LSL #32
    MOVK  X8, #0x6c8e, LSL #48
    MOVZ  X9, #0xd8fa, LSL #0
    MOVK  X9, #0xe04f, LSL #16
    MOVK  X9, #0xa74b, LSL #32
    MOVK  X9, #0x1a08, LSL #48
    MOVZ  X10, #0x984, LSL #0
    MOVK  X10, #0x3b51, LSL #16
    MOVK  X10, #0x9755, LSL #32
    MOVK  X10, #0xcd75, LSL #48
    MOVZ  X11, #0xc97d, LSL #0
    MOVK  X11, #0x8071, LSL #16
    MOVK  X11, #0xa9e2, LSL #32
    MOVK  X11, #0x28da, LSL #48
    MOVZ  X12, #0x50de, LSL #0
    MOVK  X12, #0x1198, LSL #16
    MOVK  X12, #0x98d1, LSL #32
    MOVK  X12, #0x185, LSL #48
    MOVZ  X13, #0x4fe9, LSL #0
    MOVK  X13, #0xb3fc, LSL #16
    MOVK  X13, #0xa011, LSL #32
    MOVK  X13, #0x9888, LSL #48
    MOVZ  X14, #0x9842, LSL #0
    MOVK  X14, #0x356e, LSL #16
    MOVK  X14, #0xe975, LSL #32
    MOVK  X14, #0xd1e1, LSL #48
    MOVZ  X15, #0xf6da, LSL #0
    MOVK  X15, #0x4cc4, LSL #16
    MOVK  X15, #0x2c39, LSL #32
    MOVK  X15, #0xc63f, LSL #48
    MOVZ  X16, #0x44e, LSL #0
    MOVK  X16, #0x5296, LSL #16
    MOVK  X16, #0xd6bb, LSL #32
    MOVK  X16, #0xbc4e, LSL #48
    MOVZ  X17, #0xb921, LSL #0
    MOVK  X17, #0x3028, LSL #16
    MOVK  X17, #0xb4ea, LSL #32
    MOVK  X17, #0xba6d, LSL #48
    MOVZ  X18, #0x9d71, LSL #0
    MOVK  X18, #0x1f87, LSL #16
    MOVK  X18, #0x82ec, LSL #32
    MOVK  X18, #0x722c, LSL #48
    MOVZ  X19, #0x8f60, LSL #0
    MOVK  X19, #0x265c, LSL #16
    MOVK  X19, #0x4a04, LSL #32
    MOVK  X19, #0x2ebc, LSL #48
    MOVZ  X20, #0xb2f8, LSL #0
    MOVK  X20, #0x6a5a, LSL #16
    MOVK  X20, #0x8253, LSL #32
    MOVK  X20, #0x5a71, LSL #48
    MOVZ  X21, #0x2952, LSL #0
    MOVK  X21, #0xa098, LSL #16
    MOVK  X21, #0xe3c7, LSL #32
    MOVK  X21, #0xb1f0, LSL #48
    MOVZ  X22, #0xb62b, LSL #0
    MOVK  X22, #0xd130, LSL #16
    MOVK  X22, #0x37d5, LSL #32
    MOVK  X22, #0x50bc, LSL #48
    MOVZ  X23, #0xc35e, LSL #0
    MOVK  X23, #0xff87, LSL #16
    MOVK  X23, #0xfbcd, LSL #32
    MOVK  X23, #0x87e1, LSL #48
    MOVZ  X24, #0xb392, LSL #0
    MOVK  X24, #0xeb50, LSL #16
    MOVK  X24, #0x27ae, LSL #32
    MOVK  X24, #0x2abc, LSL #48
    MOVZ  X25, #0x7ac1, LSL #0
    MOVK  X25, #0xb0f2, LSL #16
    MOVK  X25, #0x439c, LSL #32
    MOVK  X25, #0x89bf, LSL #48
    MOVZ  X26, #0xa40d, LSL #0
    MOVK  X26, #0x1a92, LSL #16
    MOVK  X26, #0x3397, LSL #32
    MOVK  X26, #0xa75e, LSL #48
    MOVZ  X27, #0x5bb6, LSL #0
    MOVK  X27, #0xe3a9, LSL #16
    MOVK  X27, #0x1e84, LSL #32
    MOVK  X27, #0x87b3, LSL #48
    MOVZ  X28, #0x87f6, LSL #0
    MOVK  X28, #0x5b5d, LSL #16
    MOVK  X28, #0xa953, LSL #32
    MOVK  X28, #0x5d0b, LSL #48
    MOVZ  X29, #0xc8e6, LSL #0
    MOVK  X29, #0xde9b, LSL #16
    MOVK  X29, #0x6e4f, LSL #32
    MOVK  X29, #0x9f61, LSL #48
    MOVZ  X29, #0xe165, LSL #0
    MOVK  X29, #0xbd2f, LSL #16
    MOVK  X29, #0xa6db, LSL #32
    MOVK  X29, #0x1baa, LSL #48
    MSR  FPCR, X29
    MRS  X23, FPCR
    MOVZ  X16, #0x60ff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    AND  X23, X23, X16
    MOVZ  X16, #0x0, LSL #0
    ORR  X23, X23, X16
    MSR  FPCR, X23
    ISB  SY
    MOVZ  X29, #0x8215, LSL #0
    MOVK  X29, #0x4401, LSL #16
    MOVK  X29, #0xfb1d, LSL #32
    MOVK  X29, #0xaac8, LSL #48
    MSR  FPSR, X29
    MRS  X19, FPSR
    MOVZ  X26, #0xff60, LSL #0
    MOVK  X26, #0x7ff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    AND  X19, X19, X26
    MOVZ  X26, #0x0, LSL #0
    ORR  X19, X19, X26
    MSR  FPSR, X19
    ISB  SY
    ANDS  X23, X6, #0x7e0000007e0
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xc2af, LSL #0
    MOVK  X2, #0xdfc5, LSL #16
    MOVK  X2, #0x24a0, LSL #32
    MOVK  X2, #0x8b09, LSL #48
    MOVZ  X3, #0x5d0c, LSL #0
    MOVK  X3, #0x4595, LSL #16
    MOVK  X3, #0xdf2a, LSL #32
    MOVK  X3, #0xfccf, LSL #48
    MOVZ  X6, #0x887c, LSL #0
    MOVK  X6, #0x9b20, LSL #16
    MOVK  X6, #0x6f23, LSL #32
    MOVK  X6, #0xf978, LSL #48
    MOVZ  X8, #0x7dc0, LSL #0
    MOVK  X8, #0x9dfb, LSL #16
    MOVK  X8, #0x6118, LSL #32
    MOVK  X8, #0x7147, LSL #48
    MOVZ  X9, #0x13c9, LSL #0
    MOVK  X9, #0xbd70, LSL #16
    MOVK  X9, #0x2c77, LSL #32
    MOVK  X9, #0x5a30, LSL #48
    MOVZ  X10, #0x2025, LSL #0
    MOVK  X10, #0x901a, LSL #16
    MOVK  X10, #0x4f92, LSL #32
    MOVK  X10, #0xa8b7, LSL #48
    MOVZ  X11, #0xa7ef, LSL #0
    MOVK  X11, #0xab79, LSL #16
    MOVK  X11, #0x6665, LSL #32
    MOVK  X11, #0x96a5, LSL #48
    MOVZ  X12, #0xaaac, LSL #0
    MOVK  X12, #0xea5, LSL #16
    MOVK  X12, #0xad62, LSL #32
    MOVK  X12, #0x7676, LSL #48
    MOVZ  X13, #0x6b2c, LSL #0
    MOVK  X13, #0x9a5a, LSL #16
    MOVK  X13, #0xed81, LSL #32
    MOVK  X13, #0x760e, LSL #48
    MOVZ  X14, #0x8191, LSL #0
    MOVK  X14, #0xde53, LSL #16
    MOVK  X14, #0x3a3d, LSL #32
    MOVK  X14, #0x3dcb, LSL #48
    MOVZ  X15, #0x130f, LSL #0
    MOVK  X15, #0x48d7, LSL #16
    MOVK  X15, #0xb07f, LSL #32
    MOVK  X15, #0x391c, LSL #48
    MOVZ  X16, #0x6299, LSL #0
    MOVK  X16, #0xe01f, LSL #16
    MOVK  X16, #0x7ab5, LSL #32
    MOVK  X16, #0xd0b8, LSL #48
    MOVZ  X17, #0x8c81, LSL #0
    MOVK  X17, #0x54a, LSL #16
    MOVK  X17, #0xf801, LSL #32
    MOVK  X17, #0xcb68, LSL #48
    MOVZ  X18, #0xda9c, LSL #0
    MOVK  X18, #0x42fa, LSL #16
    MOVK  X18, #0x7653, LSL #32
    MOVK  X18, #0x5337, LSL #48
    MOVZ  X19, #0xe76e, LSL #0
    MOVK  X19, #0xe30a, LSL #16
    MOVK  X19, #0xc7a0, LSL #32
    MOVK  X19, #0x8887, LSL #48
    MOVZ  X20, #0x2f08, LSL #0
    MOVK  X20, #0xcb81, LSL #16
    MOVK  X20, #0x8cb, LSL #32
    MOVK  X20, #0xd961, LSL #48
    MOVZ  X21, #0xe834, LSL #0
    MOVK  X21, #0x1a5a, LSL #16
    MOVK  X21, #0x4589, LSL #32
    MOVK  X21, #0x7d57, LSL #48
    MOVZ  X22, #0x52a7, LSL #0
    MOVK  X22, #0xff59, LSL #16
    MOVK  X22, #0x1d69, LSL #32
    MOVK  X22, #0xeb43, LSL #48
    MOVZ  X23, #0x3659, LSL #0
    MOVK  X23, #0x166, LSL #16
    MOVK  X23, #0x27e2, LSL #32
    MOVK  X23, #0xf05f, LSL #48
    MOVZ  X24, #0xc5c9, LSL #0
    MOVK  X24, #0xc1ee, LSL #16
    MOVK  X24, #0xcfa2, LSL #32
    MOVK  X24, #0xcb76, LSL #48
    MOVZ  X25, #0xb4fe, LSL #0
    MOVK  X25, #0x2372, LSL #16
    MOVK  X25, #0x544d, LSL #32
    MOVK  X25, #0xa2e1, LSL #48
    MOVZ  X26, #0x4209, LSL #0
    MOVK  X26, #0xf720, LSL #16
    MOVK  X26, #0x1521, LSL #32
    MOVK  X26, #0xc063, LSL #48
    MOVZ  X27, #0x1e2b, LSL #0
    MOVK  X27, #0xf093, LSL #16
    MOVK  X27, #0xd3b6, LSL #32
    MOVK  X27, #0x41d0, LSL #48
    MOVZ  X28, #0x7cde, LSL #0
    MOVK  X28, #0xd7e9, LSL #16
    MOVK  X28, #0xfd52, LSL #32
    MOVK  X28, #0x21b8, LSL #48
    MOVZ  X29, #0x2d86, LSL #0
    MOVK  X29, #0x719a, LSL #16
    MOVK  X29, #0x6c32, LSL #32
    MOVK  X29, #0x8374, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X21
    FMOV  D3, X19
    FMOV  V3.D[1], X28
    FMOV  D4, X18
    FMOV  V4.D[1], X29
    FMOV  D5, X6
    FMOV  V5.D[1], X15
    FMOV  D6, X23
    FMOV  V6.D[1], X18
    FMOV  D7, X15
    FMOV  V7.D[1], X2
    FMOV  D8, X10
    FMOV  V8.D[1], X27
    FMOV  D9, X28
    FMOV  V9.D[1], X17
    FMOV  D10, X19
    FMOV  V10.D[1], X18
    FMOV  D11, X14
    FMOV  V11.D[1], X29
    FMOV  D12, X14
    FMOV  V12.D[1], X27
    FMOV  D13, X22
    FMOV  V13.D[1], X25
    FMOV  D14, X20
    FMOV  V14.D[1], X12
    FMOV  D15, X10
    FMOV  V15.D[1], X12
    FMOV  D16, X13
    FMOV  V16.D[1], X26
    FMOV  D17, X18
    FMOV  V17.D[1], X18
    FMOV  D18, X29
    FMOV  V18.D[1], X8
    FMOV  D19, X25
    FMOV  V19.D[1], X21
    FMOV  D20, X8
    FMOV  V20.D[1], X14
    FMOV  D21, X21
    FMOV  V21.D[1], X9
    FMOV  D22, X20
    FMOV  V22.D[1], X20
    FMOV  D23, X27
    FMOV  V23.D[1], X23
    FMOV  D24, X25
    FMOV  V24.D[1], X16
    FMOV  D25, X19
    FMOV  V25.D[1], X25
    FMOV  D26, X25
    FMOV  V26.D[1], X19
    FMOV  D27, X14
    FMOV  V27.D[1], X25
    FMOV  D28, X16
    FMOV  V28.D[1], X15
    FMOV  D29, X21
    FMOV  V29.D[1], X15
    FMOV  D30, X14
    FMOV  V30.D[1], X11
    FMOV  D31, X16
    FMOV  V31.D[1], X24
    FMLAL V18.4S, V24.4H, V10.H[0x6]
    FMLAL V24.4S, V24.4H, V6.H[0x1]
    FMLAL V22.4S, V20.4H, V7.H[0x0]
    FMLAL V2.4S, V30.4H, V5.H[0x7]
    FMLAL V6.4S, V25.4H, V4.H[0x7]
    FMLAL V26.4S, V28.4H, V6.H[0x7]
    FMLAL V11.4S, V22.4H, V11.H[0x0]
    FMLAL V12.4S, V29.4H, V14.H[0x1]
    FMLAL V19.4S, V2.4H, V4.H[0x1]
    FMLAL V4.4S, V26.4H, V14.H[0x3]
    FMLAL V13.4S, V31.4H, V23.4H
    FMLAL V29.4S, V2.4H, V27.4H
    FMLAL V6.4S, V12.4H, V4.4H
    FMLAL V12.4S, V13.4H, V19.4H
    FMLAL V26.4S, V6.4H, V29.4H
    FMLAL V5.4S, V18.4H, V8.4H
    FMLAL V2.4S, V18.4H, V31.4H
    FMLAL V23.4S, V2.4H, V9.4H
    FMLAL V31.4S, V20.4H, V5.4H
    FMLAL V14.4S, V10.4H, V31.4H
    FMLAL V30.2S, V19.2H, V11.H[0x6]
    FMLAL V6.2S, V20.2H, V12.H[0x6]
    FMLAL V12.2S, V26.2H, V15.H[0x3]
    FMLAL V29.2S, V22.2H, V12.H[0x2]
    FMLAL V26.2S, V30.2H, V14.H[0x1]
    FMLAL V2.2S, V21.2H, V13.H[0x7]
    FMLAL V22.2S, V6.2H, V6.H[0x5]
    FMLAL V20.2S, V20.2H, V14.H[0x6]
    FMLAL V12.2S, V26.2H, V3.H[0x6]
    FMLAL V15.2S, V20.2H, V4.H[0x5]
    FMLAL V6.2S, V22.2H, V2.2H
    FMLAL V8.2S, V6.2H, V8.2H
    FMLAL V18.2S, V14.2H, V29.2H
    FMLAL V10.2S, V18.2H, V12.2H
    FMLAL V4.2S, V23.2H, V23.2H
    FMLAL V9.2S, V4.2H, V8.2H
    FMLAL V26.2S, V13.2H, V10.2H
    FMLAL V19.2S, V26.2H, V15.2H
    FMLAL V31.2S, V14.2H, V12.2H
    FMLAL V6.2S, V30.2H, V1.2H
    FMLAL2 V8.4S, V15.4H, V4.H[0x7]
    FMLAL2 V1.4S, V9.4H, V14.H[0x6]
    FMLAL2 V3.4S, V27.4H, V1.H[0x5]
    FMLAL2 V25.4S, V27.4H, V8.H[0x6]
    FMLAL2 V22.4S, V2.4H, V9.H[0x4]
    FMLAL2 V26.4S, V12.4H, V5.H[0x2]
    FMLAL2 V1.4S, V8.4H, V2.H[0x3]
    FMLAL2 V21.4S, V18.4H, V1.H[0x3]
    FMLAL2 V23.4S, V14.4H, V9.H[0x1]
    FMLAL2 V29.4S, V31.4H, V1.H[0x5]
    FMLAL2 V22.4S, V28.4H, V23.4H
    FMLAL2 V28.4S, V6.4H, V3.4H
    FMLAL2 V2.4S, V21.4H, V25.4H
    FMLAL2 V31.4S, V2.4H, V17.4H
    FMLAL2 V3.4S, V26.4H, V26.4H
    FMLAL2 V27.4S, V8.4H, V0.4H
    FMLAL2 V26.4S, V19.4H, V19.4H
    FMLAL2 V8.4S, V12.4H, V21.4H
    FMLAL2 V6.4S, V2.4H, V26.4H
    FMLAL2 V17.4S, V8.4H, V8.4H
    FMLAL2 V1.2S, V17.2H, V11.H[0x3]
    FMLAL2 V9.2S, V3.2H, V6.H[0x6]
    FMLAL2 V0.2S, V27.2H, V5.H[0x2]
    FMLAL2 V0.2S, V31.2H, V1.H[0x3]
    FMLAL2 V26.2S, V3.2H, V14.H[0x4]
    FMLAL2 V25.2S, V26.2H, V6.H[0x0]
    FMLAL2 V23.2S, V20.2H, V12.H[0x1]
    FMLAL2 V19.2S, V0.2H, V4.H[0x0]
    FMLAL2 V21.2S, V11.2H, V5.H[0x1]
    FMLAL2 V23.2S, V19.2H, V13.H[0x1]
    FMLAL2 V17.2S, V25.2H, V25.2H
    FMLAL2 V8.2S, V9.2H, V29.2H
    FMLAL2 V18.2S, V17.2H, V1.2H
    FMLAL2 V29.2S, V5.2H, V1.2H
    FMLAL2 V27.2S, V18.2H, V8.2H
    FMLAL2 V19.2S, V23.2H, V22.2H
    FMLAL2 V14.2S, V27.2H, V29.2H
    FMLAL2 V11.2S, V14.2H, V25.2H
    FMLAL2 V1.2S, V11.2H, V25.2H
    FMLAL2 V26.2S, V28.2H, V21.2H
    FMLSL V17.4S, V27.4H, V9.H[0x6]
    FMLSL V27.4S, V26.4H, V3.H[0x7]
    FMLSL V2.4S, V13.4H, V5.H[0x5]
    FMLSL V4.4S, V2.4H, V2.H[0x4]
    FMLSL V2.4S, V9.4H, V9.H[0x1]
    FMLSL V13.4S, V17.4H, V1.H[0x2]
    FMLSL V3.4S, V4.4H, V2.H[0x3]
    FMLSL V17.4S, V19.4H, V13.H[0x1]
    FMLSL V18.4S, V14.4H, V10.H[0x5]
    FMLSL V2.4S, V18.4H, V15.H[0x3]
    FMLSL V18.4S, V3.4H, V17.4H
    FMLSL V19.4S, V30.4H, V16.4H
    FMLSL V5.4S, V19.4H, V27.4H
    FMLSL V16.4S, V2.4H, V22.4H
    FMLSL V22.4S, V18.4H, V7.4H
    FMLSL V21.4S, V0.4H, V31.4H
    FMLSL V14.4S, V3.4H, V5.4H
    FMLSL V3.4S, V21.4H, V14.4H
    FMLSL V27.4S, V3.4H, V22.4H
    FMLSL V21.4S, V5.4H, V25.4H
    FMLSL V9.2S, V15.2H, V6.H[0x6]
    FMLSL V4.2S, V5.2H, V2.H[0x3]
    FMLSL V30.2S, V8.2H, V5.H[0x5]
    FMLSL V1.2S, V22.2H, V9.H[0x3]
    FMLSL V2.2S, V15.2H, V7.H[0x1]
    FMLSL V19.2S, V7.2H, V6.H[0x5]
    FMLSL V6.2S, V27.2H, V10.H[0x6]
    FMLSL V18.2S, V19.2H, V8.H[0x7]
    FMLSL V8.2S, V26.2H, V1.H[0x6]
    FMLSL V19.2S, V24.2H, V1.H[0x0]
    FMLSL V1.2S, V18.2H, V30.2H
    FMLSL V18.2S, V4.2H, V8.2H
    FMLSL V5.2S, V25.2H, V16.2H
    FMLSL V10.2S, V21.2H, V2.2H
    FMLSL V2.2S, V5.2H, V10.2H
    FMLSL V7.2S, V19.2H, V2.2H
    FMLSL V17.2S, V7.2H, V24.2H
    FMLSL V27.2S, V18.2H, V22.2H
    FMLSL V2.2S, V17.2H, V27.2H
    FMLSL V0.2S, V21.2H, V12.2H
    FMLSL2 V23.4S, V6.4H, V2.H[0x7]
    FMLSL2 V16.4S, V1.4H, V0.H[0x4]
    FMLSL2 V18.4S, V24.4H, V6.H[0x2]
    FMLSL2 V7.4S, V26.4H, V3.H[0x7]
    FMLSL2 V15.4S, V3.4H, V12.H[0x6]
    FMLSL2 V28.4S, V7.4H, V5.H[0x3]
    FMLSL2 V1.4S, V23.4H, V3.H[0x2]
    FMLSL2 V27.4S, V12.4H, V10.H[0x1]
    FMLSL2 V26.4S, V10.4H, V14.H[0x3]
    FMLSL2 V9.4S, V25.4H, V0.H[0x1]
    FMLSL2 V25.4S, V27.4H, V30.4H
    FMLSL2 V4.4S, V6.4H, V12.4H
    FMLSL2 V2.4S, V27.4H, V9.4H
    FMLSL2 V14.4S, V18.4H, V26.4H
    FMLSL2 V18.4S, V16.4H, V24.4H
    FMLSL2 V0.4S, V18.4H, V23.4H
    FMLSL2 V23.4S, V15.4H, V20.4H
    FMLSL2 V24.4S, V14.4H, V28.4H
    FMLSL2 V7.4S, V6.4H, V12.4H
    FMLSL2 V20.4S, V12.4H, V31.4H
    FMLSL2 V15.2S, V24.2H, V0.H[0x2]
    FMLSL2 V31.2S, V7.2H, V1.H[0x0]
    FMLSL2 V7.2S, V31.2H, V15.H[0x4]
    FMLSL2 V24.2S, V7.2H, V7.H[0x0]
    FMLSL2 V5.2S, V23.2H, V3.H[0x7]
    FMLSL2 V12.2S, V29.2H, V5.H[0x0]
    FMLSL2 V26.2S, V7.2H, V12.H[0x2]
    FMLSL2 V5.2S, V4.2H, V1.H[0x0]
    FMLSL2 V21.2S, V24.2H, V3.H[0x4]
    FMLSL2 V23.2S, V21.2H, V6.H[0x7]
    FMLSL2 V29.2S, V20.2H, V20.2H
    FMLSL2 V3.2S, V5.2H, V23.2H
    FMLSL2 V1.2S, V1.2H, V30.2H
    FMLSL2 V28.2S, V25.2H, V3.2H
    FMLSL2 V20.2S, V29.2H, V29.2H
    FMLSL2 V24.2S, V28.2H, V28.2H
    FMLSL2 V21.2S, V25.2H, V20.2H
    FMLSL2 V20.2S, V4.2H, V21.2H
    FMLSL2 V9.2S, V31.2H, V5.2H
    FMLSL2 V3.2S, V20.2H, V5.2H
    SMMLA V4.4S, V24.16B, V9.16B
    SMMLA V18.4S, V1.16B, V26.16B
    SMMLA V9.4S, V18.16B, V10.16B
    SMMLA V7.4S, V0.16B, V21.16B
    SMMLA V25.4S, V19.16B, V21.16B
    SMMLA V20.4S, V22.16B, V4.16B
    SMMLA V1.4S, V29.16B, V3.16B
    SMMLA V29.4S, V9.16B, V1.16B
    SMMLA V5.4S, V20.16B, V20.16B
    SMMLA V9.4S, V29.16B, V7.16B
    SUDOT V10.4S, V11.16B, V25.4B[0x1]
    SUDOT V24.4S, V10.16B, V4.4B[0x0]
    SUDOT V6.4S, V9.16B, V23.4B[0x3]
    SUDOT V18.4S, V6.16B, V24.4B[0x2]
    SUDOT V22.4S, V23.16B, V17.4B[0x2]
    SUDOT V7.4S, V17.16B, V19.4B[0x1]
    SUDOT V0.4S, V30.16B, V12.4B[0x2]
    SUDOT V1.4S, V29.16B, V29.4B[0x2]
    SUDOT V25.4S, V20.16B, V16.4B[0x3]
    SUDOT V24.4S, V8.16B, V6.4B[0x2]
    SUDOT V11.2S, V5.8B, V10.4B[0x2]
    SUDOT V29.2S, V12.8B, V24.4B[0x1]
    SUDOT V4.2S, V20.8B, V2.4B[0x1]
    SUDOT V16.2S, V13.8B, V0.4B[0x3]
    SUDOT V24.2S, V7.8B, V7.4B[0x1]
    SUDOT V31.2S, V16.8B, V18.4B[0x3]
    SUDOT V9.2S, V11.8B, V24.4B[0x1]
    SUDOT V16.2S, V1.8B, V10.4B[0x2]
    SUDOT V18.2S, V22.8B, V31.4B[0x2]
    SUDOT V0.2S, V9.8B, V30.4B[0x0]
    UMMLA V24.4S, V22.16B, V25.16B
    UMMLA V26.4S, V13.16B, V7.16B
    UMMLA V31.4S, V4.16B, V26.16B
    UMMLA V19.4S, V6.16B, V31.16B
    UMMLA V9.4S, V24.16B, V16.16B
    UMMLA V1.4S, V2.16B, V19.16B
    UMMLA V16.4S, V17.16B, V1.16B
    UMMLA V24.4S, V0.16B, V4.16B
    UMMLA V23.4S, V15.16B, V24.16B
    UMMLA V17.4S, V16.16B, V18.16B
    USDOT V1.4S, V9.16B, V9.16B
    USDOT V10.4S, V1.16B, V4.16B
    USDOT V8.4S, V23.16B, V23.16B
    USDOT V12.4S, V21.16B, V17.16B
    USDOT V15.4S, V15.16B, V29.16B
    USDOT V25.4S, V6.16B, V4.16B
    USDOT V23.4S, V15.16B, V12.16B
    USDOT V13.4S, V22.16B, V25.16B
    USDOT V21.4S, V5.16B, V8.16B
    USDOT V29.4S, V8.16B, V23.16B
    USDOT V26.2S, V18.8B, V29.8B
    USDOT V31.2S, V25.8B, V26.8B
    USDOT V21.2S, V31.8B, V21.8B
    USDOT V29.2S, V15.8B, V2.8B
    USDOT V6.2S, V22.8B, V31.8B
    USDOT V5.2S, V10.8B, V29.8B
    USDOT V29.2S, V31.8B, V5.8B
    USDOT V26.2S, V9.8B, V21.8B
    USDOT V9.2S, V22.8B, V4.8B
    USDOT V21.2S, V9.8B, V13.8B
    USDOT V9.4S, V7.16B, V29.4B[0x0]
    USDOT V13.4S, V21.16B, V26.4B[0x3]
    USDOT V4.4S, V22.16B, V11.4B[0x0]
    USDOT V14.4S, V29.16B, V6.4B[0x2]
    USDOT V15.4S, V9.16B, V13.4B[0x1]
    USDOT V10.4S, V8.16B, V15.4B[0x0]
    USDOT V5.4S, V17.16B, V10.4B[0x1]
    USDOT V22.4S, V5.16B, V15.4B[0x0]
    USDOT V11.4S, V22.16B, V22.4B[0x1]
    USDOT V5.4S, V31.16B, V21.4B[0x0]
    USDOT V12.2S, V22.8B, V13.4B[0x0]
    USDOT V17.2S, V31.8B, V4.4B[0x1]
    USDOT V0.2S, V5.8B, V7.4B[0x0]
    USDOT V7.2S, V23.8B, V12.4B[0x2]
    USDOT V22.2S, V14.8B, V0.4B[0x2]
    USDOT V31.2S, V27.8B, V17.4B[0x2]
    USDOT V5.2S, V11.8B, V11.4B[0x3]
    USDOT V0.2S, V5.8B, V15.4B[0x3]
    USDOT V15.2S, V28.8B, V8.4B[0x0]
    USDOT V22.2S, V0.8B, V14.4B[0x1]
    USMMLA V17.4S, V31.16B, V0.16B
    USMMLA V21.4S, V4.16B, V22.16B
    USMMLA V12.4S, V17.16B, V17.16B
    USMMLA V15.4S, V27.16B, V0.16B
    USMMLA V8.4S, V20.16B, V12.16B
    USMMLA V20.4S, V7.16B, V23.16B
    USMMLA V4.4S, V20.16B, V24.16B
    USMMLA V11.4S, V21.16B, V0.16B
    USMMLA V5.4S, V8.16B, V19.16B
    USMMLA V1.4S, V15.16B, V15.16B
    MOVZ  X11, #0xc2af, LSL #0
    MOVK  X11, #0xdfc5, LSL #16
    MOVK  X11, #0x24a0, LSL #32
    MOVK  X11, #0x8b09, LSL #48
    SUB  X19, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x5d0c, LSL #0
    MOVK  X11, #0x4595, LSL #16
    MOVK  X11, #0xdf2a, LSL #32
    MOVK  X11, #0xfccf, LSL #48
    SUB  X19, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x887c, LSL #0
    MOVK  X11, #0x9b20, LSL #16
    MOVK  X11, #0x6f23, LSL #32
    MOVK  X11, #0xf978, LSL #48
    SUB  X19, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x7dc0, LSL #0
    MOVK  X11, #0x9dfb, LSL #16
    MOVK  X11, #0x6118, LSL #32
    MOVK  X11, #0x7147, LSL #48
    SUB  X19, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x13c9, LSL #0
    MOVK  X11, #0xbd70, LSL #16
    MOVK  X11, #0x2c77, LSL #32
    MOVK  X11, #0x5a30, LSL #48
    SUB  X19, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x2025, LSL #0
    MOVK  X11, #0x901a, LSL #16
    MOVK  X11, #0x4f92, LSL #32
    MOVK  X11, #0xa8b7, LSL #48
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xaaac, LSL #0
    MOVK  X11, #0xea5, LSL #16
    MOVK  X11, #0xad62, LSL #32
    MOVK  X11, #0x7676, LSL #48
    SUB  X19, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x6b2c, LSL #0
    MOVK  X11, #0x9a5a, LSL #16
    MOVK  X11, #0xed81, LSL #32
    MOVK  X11, #0x760e, LSL #48
    SUB  X19, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x8191, LSL #0
    MOVK  X11, #0xde53, LSL #16
    MOVK  X11, #0x3a3d, LSL #32
    MOVK  X11, #0x3dcb, LSL #48
    SUB  X19, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x130f, LSL #0
    MOVK  X11, #0x48d7, LSL #16
    MOVK  X11, #0xb07f, LSL #32
    MOVK  X11, #0x391c, LSL #48
    SUB  X19, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x8c81, LSL #0
    MOVK  X11, #0x54a, LSL #16
    MOVK  X11, #0xf801, LSL #32
    MOVK  X11, #0xcb68, LSL #48
    SUB  X19, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xda9c, LSL #0
    MOVK  X11, #0x42fa, LSL #16
    MOVK  X11, #0x7653, LSL #32
    MOVK  X11, #0x5337, LSL #48
    SUB  X19, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x2f08, LSL #0
    MOVK  X11, #0xcb81, LSL #16
    MOVK  X11, #0x8cb, LSL #32
    MOVK  X11, #0xd961, LSL #48
    SUB  X19, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xe834, LSL #0
    MOVK  X11, #0x1a5a, LSL #16
    MOVK  X11, #0x4589, LSL #32
    MOVK  X11, #0x7d57, LSL #48
    SUB  X19, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x52a7, LSL #0
    MOVK  X11, #0xff59, LSL #16
    MOVK  X11, #0x1d69, LSL #32
    MOVK  X11, #0xeb43, LSL #48
    SUB  X19, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x3659, LSL #0
    MOVK  X11, #0x166, LSL #16
    MOVK  X11, #0x27e2, LSL #32
    MOVK  X11, #0xf05f, LSL #48
    SUB  X19, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xc5c9, LSL #0
    MOVK  X11, #0xc1ee, LSL #16
    MOVK  X11, #0xcfa2, LSL #32
    MOVK  X11, #0xcb76, LSL #48
    SUB  X19, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xb4fe, LSL #0
    MOVK  X11, #0x2372, LSL #16
    MOVK  X11, #0x544d, LSL #32
    MOVK  X11, #0xa2e1, LSL #48
    SUB  X19, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x4209, LSL #0
    MOVK  X11, #0xf720, LSL #16
    MOVK  X11, #0x1521, LSL #32
    MOVK  X11, #0xc063, LSL #48
    SUB  X19, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x1e2b, LSL #0
    MOVK  X11, #0xf093, LSL #16
    MOVK  X11, #0xd3b6, LSL #32
    MOVK  X11, #0x41d0, LSL #48
    SUB  X19, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x7cde, LSL #0
    MOVK  X11, #0xd7e9, LSL #16
    MOVK  X11, #0xfd52, LSL #32
    MOVK  X11, #0x21b8, LSL #48
    SUB  X19, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x2d86, LSL #0
    MOVK  X11, #0x719a, LSL #16
    MOVK  X11, #0x6c32, LSL #32
    MOVK  X11, #0x8374, LSL #48
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X11, FPSR
    MOVZ  X19, #0x11, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D0
    MOVZ  X19, #0xbce0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    MOVK  X19, #0x7c00, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X19, #0x1ff6, LSL #0
    MOVK  X19, #0x2, LSL #16
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D1
    MOVZ  X19, #0x97a9, LSL #0
    MOVK  X19, #0x8002, LSL #16
    MOVK  X19, #0x47f3, LSL #32
    MOVK  X19, #0x8000, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D2
    MOVZ  X19, #0xc000, LSL #0
    MOVK  X19, #0xffdb, LSL #16
    MOVK  X19, #0x2000, LSL #32
    MOVK  X19, #0x7feb, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D3
    MOVZ  X19, #0x6000, LSL #0
    MOVK  X19, #0x7ffd, LSL #16
    MOVK  X19, #0x6000, LSL #32
    MOVK  X19, #0x7ffd, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X19, #0xab57, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x1d4c, LSL #32
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D4
    MOVZ  X19, #0x9001, LSL #0
    MOVK  X19, #0x7ffe, LSL #16
    MOVK  X19, #0xf0, LSL #32
    MOVK  X19, #0x7ffc, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X19, #0x527d, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D5
    MOVZ  X19, #0xab59, LSL #0
    MOVK  X19, #0x6df7, LSL #32
    MOVK  X19, #0x8000, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D6
    MOVZ  X19, #0x3931, LSL #0
    MOVK  X19, #0x7ff8, LSL #16
    MOVK  X19, #0xfd83, LSL #32
    MOVK  X19, #0x7ffe, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D7
    MOVZ  X19, #0xe09, LSL #0
    MOVK  X19, #0xa02, LSL #32
    MOVK  X19, #0xfffb, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X19, #0xe006, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D8
    MOVZ  X19, #0x763e, LSL #0
    MOVK  X19, #0x901a, LSL #16
    MOVK  X19, #0xe00b, LSL #32
    MOVK  X19, #0x7ffe, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X19, #0x3736, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D9
    MOVZ  X19, #0x2d3b, LSL #0
    MOVK  X19, #0x8002, LSL #16
    MOVK  X19, #0x8790, LSL #32
    MOVK  X19, #0x8000, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D10
    MOVZ  X19, #0xd4d4, LSL #0
    MOVK  X19, #0xe30a, LSL #16
    MOVK  X19, #0x7b2b, LSL #32
    MOVK  X19, #0xfffd, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X19, #0xb549, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xdcc3, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D11
    MOVZ  X19, #0x7139, LSL #0
    MOVK  X19, #0xde53, LSL #16
    MOVK  X19, #0xdca, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D12
    MOVZ  X19, #0x60ba, LSL #0
    MOVK  X19, #0xffea, LSL #16
    MOVK  X19, #0x69e1, LSL #32
    MOVK  X19, #0xffea, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X19, #0xebd6, LSL #0
    MOVK  X19, #0xca4e, LSL #16
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D13
    MOVZ  X19, #0x4eec, LSL #0
    MOVK  X19, #0xff59, LSL #16
    MOVK  X19, #0x19ed, LSL #32
    MOVK  X19, #0xeb43, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X19, #0x6000, LSL #0
    MOVK  X19, #0xca64, LSL #16
    MOVK  X19, #0xa000, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D14
    MOVZ  X19, #0x2f0b, LSL #0
    MOVK  X19, #0xcb81, LSL #16
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D15
    MOVZ  X19, #0xa77f, LSL #0
    MOVK  X19, #0x9019, LSL #16
    MOVK  X19, #0x3457, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D16
    MOVZ  X19, #0x5e2a, LSL #0
    MOVK  X19, #0x9a5c, LSL #16
    MOVK  X19, #0xc45d, LSL #32
    MOVK  X19, #0x7ffb, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D17
    MOVZ  X19, #0xfa1a, LSL #0
    MOVK  X19, #0xffed, LSL #16
    MOVK  X19, #0x2ab1, LSL #32
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D18
    MOVZ  X19, #0x6c1e, LSL #0
    MOVK  X19, #0x719a, LSL #16
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D19
    MOVZ  X19, #0x665e, LSL #0
    MOVK  X19, #0x42b5, LSL #16
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X19, #0x138f, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D20
    MOVZ  X19, #0x8374, LSL #0
    MOVK  X19, #0x7ff8, LSL #16
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X19, #0xe9c3, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D21
    MOVZ  X19, #0xdccf, LSL #0
    MOVK  X19, #0x41ce, LSL #16
    MOVK  X19, #0x86b3, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D22
    MOVZ  X19, #0xe33b, LSL #0
    MOVK  X19, #0x7ff7, LSL #16
    MOVK  X19, #0xfc1, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D23
    MOVZ  X19, #0x642f, LSL #0
    MOVK  X19, #0x7fdd, LSL #16
    MOVK  X19, #0x3bec, LSL #32
    MOVK  X19, #0xfffd, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X19, #0x397e, LSL #0
    MOVK  X19, #0x3, LSL #16
    MOVK  X19, #0xd0e, LSL #32
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D24
    MOVZ  X19, #0xad42, LSL #0
    MOVK  X19, #0x40fa, LSL #16
    MOVK  X19, #0xc5a6, LSL #32
    MOVK  X19, #0x7ffe, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X19, #0x720, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D25
    MOVZ  X19, #0xe400, LSL #0
    MOVK  X19, #0xe30b, LSL #16
    MOVK  X19, #0x8c0a, LSL #32
    MOVK  X19, #0xfffd, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D26
    MOVZ  X19, #0x9b10, LSL #0
    MOVK  X19, #0x8001, LSL #16
    MOVK  X19, #0x730b, LSL #32
    MOVK  X19, #0xffec, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D27
    MOVZ  X19, #0x8191, LSL #0
    MOVK  X19, #0xde53, LSL #16
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D28
    MOVZ  X19, #0xc000, LSL #0
    MOVK  X19, #0x7fdb, LSL #16
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D29
    MOVZ  X19, #0xf46d, LSL #0
    MOVK  X19, #0xca7e, LSL #16
    MOVK  X19, #0xea90, LSL #32
    MOVK  X19, #0x7ffe, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D30
    MOVZ  X19, #0x8191, LSL #0
    MOVK  X19, #0xde53, LSL #16
    MOVK  X19, #0x9174, LSL #32
    MOVK  X19, #0x45dd, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D31
    MOVZ  X19, #0x54c8, LSL #0
    MOVK  X19, #0x7ffa, LSL #16
    MOVK  X19, #0x2f5a, LSL #32
    MOVK  X19, #0xfffe, LSL #48
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0x2034, LSL #0
    MOVK  X2, #0xed74, LSL #16
    MOVK  X2, #0xba5f, LSL #32
    MOVK  X2, #0x7d8e, LSL #48
    MOVZ  X3, #0x7037, LSL #0
    MOVK  X3, #0xb6f, LSL #16
    MOVK  X3, #0xdf10, LSL #32
    MOVK  X3, #0x5492, LSL #48
    MOVZ  X6, #0x905e, LSL #0
    MOVK  X6, #0x957e, LSL #16
    MOVK  X6, #0x3165, LSL #32
    MOVK  X6, #0x44bf, LSL #48
    MOVZ  X8, #0xde26, LSL #0
    MOVK  X8, #0xef04, LSL #16
    MOVK  X8, #0xbb8e, LSL #32
    MOVK  X8, #0xc88a, LSL #48
    MOVZ  X9, #0xbb1, LSL #0
    MOVK  X9, #0x7764, LSL #16
    MOVK  X9, #0xa8a5, LSL #32
    MOVK  X9, #0xed33, LSL #48
    MOVZ  X10, #0xe2d5, LSL #0
    MOVK  X10, #0x476d, LSL #16
    MOVK  X10, #0x2769, LSL #32
    MOVK  X10, #0xf56e, LSL #48
    MOVZ  X11, #0xe243, LSL #0
    MOVK  X11, #0x36bc, LSL #16
    MOVK  X11, #0xd188, LSL #32
    MOVK  X11, #0x262c, LSL #48
    MOVZ  X12, #0x3b98, LSL #0
    MOVK  X12, #0xc643, LSL #16
    MOVK  X12, #0x9e2f, LSL #32
    MOVK  X12, #0x1199, LSL #48
    MOVZ  X13, #0x6cdb, LSL #0
    MOVK  X13, #0x811c, LSL #16
    MOVK  X13, #0x24ba, LSL #32
    MOVK  X13, #0x55c2, LSL #48
    MOVZ  X14, #0xb902, LSL #0
    MOVK  X14, #0xad49, LSL #16
    MOVK  X14, #0x571e, LSL #32
    MOVK  X14, #0xa86a, LSL #48
    MOVZ  X15, #0x6b83, LSL #0
    MOVK  X15, #0xfe1b, LSL #16
    MOVK  X15, #0xea9a, LSL #32
    MOVK  X15, #0xb4aa, LSL #48
    MOVZ  X16, #0xb4e4, LSL #0
    MOVK  X16, #0x3d88, LSL #16
    MOVK  X16, #0xf1d3, LSL #32
    MOVK  X16, #0x3dc7, LSL #48
    MOVZ  X17, #0x467c, LSL #0
    MOVK  X17, #0x8867, LSL #16
    MOVK  X17, #0xb10f, LSL #32
    MOVK  X17, #0xade5, LSL #48
    MOVZ  X18, #0xbbf2, LSL #0
    MOVK  X18, #0x24e7, LSL #16
    MOVK  X18, #0x73ce, LSL #32
    MOVK  X18, #0xb2f7, LSL #48
    MOVZ  X19, #0x6e55, LSL #0
    MOVK  X19, #0x63eb, LSL #16
    MOVK  X19, #0xdb61, LSL #32
    MOVK  X19, #0x151f, LSL #48
    MOVZ  X20, #0xeaa3, LSL #0
    MOVK  X20, #0x8294, LSL #16
    MOVK  X20, #0xdd25, LSL #32
    MOVK  X20, #0xa56, LSL #48
    MOVZ  X21, #0x23d1, LSL #0
    MOVK  X21, #0x14d8, LSL #16
    MOVK  X21, #0x82f7, LSL #32
    MOVK  X21, #0xaa0, LSL #48
    MOVZ  X22, #0xa503, LSL #0
    MOVK  X22, #0x26e0, LSL #16
    MOVK  X22, #0xc7a9, LSL #32
    MOVK  X22, #0xe04e, LSL #48
    MOVZ  X23, #0xabcb, LSL #0
    MOVK  X23, #0xf442, LSL #16
    MOVK  X23, #0xda28, LSL #32
    MOVK  X23, #0x20c4, LSL #48
    MOVZ  X24, #0xd614, LSL #0
    MOVK  X24, #0x247, LSL #16
    MOVK  X24, #0x76d8, LSL #32
    MOVK  X24, #0xd427, LSL #48
    MOVZ  X25, #0x7a32, LSL #0
    MOVK  X25, #0xa30a, LSL #16
    MOVK  X25, #0x7c64, LSL #32
    MOVK  X25, #0x8e43, LSL #48
    MOVZ  X26, #0x8797, LSL #0
    MOVK  X26, #0x80cd, LSL #16
    MOVK  X26, #0xc14c, LSL #32
    MOVK  X26, #0xb948, LSL #48
    MOVZ  X27, #0x37c, LSL #0
    MOVK  X27, #0x46b3, LSL #16
    MOVK  X27, #0x9633, LSL #32
    MOVK  X27, #0xe9de, LSL #48
    MOVZ  X28, #0x3235, LSL #0
    MOVK  X28, #0xde7e, LSL #16
    MOVK  X28, #0x81e7, LSL #32
    MOVK  X28, #0x4a5c, LSL #48
    MOVZ  X29, #0xdadd, LSL #0
    MOVK  X29, #0xa139, LSL #16
    MOVK  X29, #0x63f6, LSL #32
    MOVK  X29, #0x6a4b, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X10
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X9
    FMOV  V3.D[1], X10
    FMOV  D4, X22
    FMOV  V4.D[1], X15
    FMOV  D5, X29
    FMOV  V5.D[1], X27
    FMOV  D6, X11
    FMOV  V6.D[1], X13
    FMOV  D7, X26
    FMOV  V7.D[1], X11
    FMOV  D8, X28
    FMOV  V8.D[1], X18
    FMOV  D9, X15
    FMOV  V9.D[1], X13
    FMOV  D10, X10
    FMOV  V10.D[1], X2
    FMOV  D11, X23
    FMOV  V11.D[1], X28
    FMOV  D12, X29
    FMOV  V12.D[1], X22
    FMOV  D13, X21
    FMOV  V13.D[1], X15
    FMOV  D14, X26
    FMOV  V14.D[1], X27
    FMOV  D15, X12
    FMOV  V15.D[1], X2
    FMOV  D16, X23
    FMOV  V16.D[1], X28
    FMOV  D17, X21
    FMOV  V17.D[1], X15
    FMOV  D18, X6
    FMOV  V18.D[1], X23
    FMOV  D19, X3
    FMOV  V19.D[1], X6
    FMOV  D20, X16
    FMOV  V20.D[1], X23
    FMOV  D21, X3
    FMOV  V21.D[1], X22
    FMOV  D22, X12
    FMOV  V22.D[1], X24
    FMOV  D23, X6
    FMOV  V23.D[1], X3
    FMOV  D24, X23
    FMOV  V24.D[1], X29
    FMOV  D25, X22
    FMOV  V25.D[1], X9
    FMOV  D26, X19
    FMOV  V26.D[1], X27
    FMOV  D27, X24
    FMOV  V27.D[1], X29
    FMOV  D28, X8
    FMOV  V28.D[1], X3
    FMOV  D29, X25
    FMOV  V29.D[1], X10
    FMOV  D30, X12
    FMOV  V30.D[1], X23
    FMOV  D31, X29
    FMOV  V31.D[1], X14
    MOVZ  X21, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_0:
    USDOT V19.4S, V26.16B, V19.16B
    UMMLA V15.4S, V27.16B, V19.16B
    USDOT V22.2S, V15.8B, V23.8B
    SUDOT V30.2S, V28.8B, V19.4B[0x3]
    USDOT V14.4S, V25.16B, V25.16B
    USDOT V14.2S, V14.8B, V30.4B[0x2]
    USDOT V21.2S, V31.8B, V31.8B
    FMLAL V30.2S, V15.2H, V14.H[0x3]
    USDOT V27.2S, V21.8B, V19.4B[0x1]
    FMLSL V4.4S, V12.4H, V22.4H
    FMLSL V14.2S, V27.2H, V7.H[0x6]
    UMMLA V1.4S, V29.16B, V24.16B
    SMMLA V10.4S, V14.16B, V4.16B
    USMMLA V26.4S, V14.16B, V5.16B
    FMLSL2 V19.2S, V23.2H, V11.H[0x6]
    FMLSL V16.4S, V2.4H, V28.4H
    FMLAL V25.4S, V19.4H, V10.H[0x1]
    FMLSL2 V31.4S, V30.4H, V21.4H
    SUDOT V6.4S, V31.16B, V26.4B[0x0]
    SUDOT V22.4S, V18.16B, V11.4B[0x2]
    USDOT V30.2S, V25.8B, V16.4B[0x1]
    FMLSL V5.4S, V27.4H, V1.H[0x4]
    FMLAL2 V10.4S, V2.4H, V30.4H
    FMLSL2 V4.2S, V6.2H, V10.2H
    FMLAL V29.4S, V28.4H, V31.4H
    FMLSL V16.4S, V5.4H, V5.4H
    FMLSL2 V2.4S, V16.4H, V24.4H
    SUDOT V27.2S, V2.8B, V4.4B[0x1]
    USDOT V15.4S, V22.16B, V29.4B[0x2]
    FMLAL2 V7.2S, V21.2H, V3.H[0x6]
    SUDOT V21.4S, V12.16B, V6.4B[0x0]
    SUDOT V24.2S, V16.8B, V21.4B[0x2]
    SUDOT V21.2S, V6.8B, V20.4B[0x3]
    USMMLA V23.4S, V14.16B, V8.16B
    FMLAL V10.4S, V10.4H, V7.H[0x2]
    USDOT V24.4S, V26.16B, V12.16B
    FMLAL V26.2S, V9.2H, V8.2H
    FMLAL2 V8.2S, V5.2H, V9.2H
    FMLAL V2.4S, V4.4H, V15.4H
    FMLSL V31.2S, V12.2H, V1.2H
    SUDOT V28.2S, V31.8B, V2.4B[0x0]
    USDOT V29.2S, V23.8B, V24.4B[0x0]
    FMLAL2 V1.2S, V26.2H, V26.2H
    SUDOT V26.2S, V1.8B, V1.4B[0x3]
    FMLAL2 V14.2S, V25.2H, V27.2H
    SUDOT V27.4S, V8.16B, V8.4B[0x2]
    USDOT V9.4S, V28.16B, V3.4B[0x0]
    SUDOT V7.2S, V6.8B, V13.4B[0x1]
    SUDOT V12.2S, V15.8B, V10.4B[0x0]
    FMLSL2 V2.2S, V14.2H, V2.H[0x7]
    USDOT V16.2S, V1.8B, V1.8B
    USDOT V5.4S, V27.16B, V27.16B
    USDOT V20.2S, V2.8B, V29.8B
    FMLSL V23.4S, V12.4H, V16.4H
    USDOT V28.4S, V20.16B, V26.4B[0x1]
    USMMLA V6.4S, V28.16B, V23.16B
    FMLSL V29.2S, V5.2H, V7.2H
    FMLSL V13.2S, V27.2H, V11.H[0x0]
    FMLSL V25.4S, V6.4H, V11.H[0x7]
    FMLAL2 V6.2S, V21.2H, V13.H[0x0]
    FMLSL2 V21.4S, V29.4H, V10.4H
    FMLAL V29.2S, V6.2H, V6.H[0x3]
    FMLAL V2.4S, V25.4H, V9.H[0x4]
    SUDOT V10.2S, V1.8B, V2.4B[0x2]
    FMLAL2 V6.2S, V21.2H, V21.2H
    FMLAL V26.2S, V10.2H, V10.H[0x5]
    FMLAL V10.4S, V28.4H, V6.4H
    FMLSL2 V6.4S, V10.4H, V10.H[0x0]
    FMLSL2 V5.2S, V26.2H, V6.H[0x7]
    UMMLA V11.4S, V27.16B, V10.16B
    SMMLA V26.4S, V19.16B, V15.16B
    FMLSL V23.2S, V31.2H, V5.H[0x5]
    SUDOT V15.2S, V28.8B, V25.4B[0x3]
    USMMLA V19.4S, V26.16B, V18.16B
    FMLAL2 V8.4S, V5.4H, V3.4H
    FMLAL2 V28.4S, V20.4H, V2.H[0x2]
    FMLSL V25.2S, V5.2H, V18.2H
    FMLAL V1.4S, V9.4H, V3.H[0x5]
    SUDOT V9.4S, V22.16B, V24.4B[0x0]
    FMLSL2 V22.2S, V9.2H, V10.H[0x4]
    FMLAL2 V21.2S, V23.2H, V28.2H
    FMLAL2 V5.2S, V22.2H, V15.H[0x5]
    FMLAL V6.2S, V7.2H, V11.H[0x7]
    FMLSL V28.2S, V1.2H, V13.H[0x3]
    FMLAL V24.4S, V19.4H, V25.4H
    USDOT V20.4S, V6.16B, V27.16B
    USMMLA V1.4S, V21.16B, V28.16B
    SUDOT V15.4S, V3.16B, V5.4B[0x0]
    SUDOT V23.2S, V2.8B, V11.4B[0x2]
    SUDOT V13.4S, V24.16B, V13.4B[0x0]
    USMMLA V27.4S, V1.16B, V15.16B
    USDOT V9.4S, V23.16B, V13.4B[0x2]
    FMLSL V29.4S, V8.4H, V9.4H
    FMLSL V1.2S, V21.2H, V12.H[0x5]
    USMMLA V10.4S, V1.16B, V1.16B
    FMLSL2 V8.4S, V29.4H, V6.4H
    USDOT V31.2S, V20.8B, V20.4B[0x0]
    FMLSL2 V28.2S, V27.2H, V10.H[0x6]
    FMLAL V1.4S, V28.4H, V9.H[0x6]
    UMMLA V2.4S, V31.16B, V23.16B
    FMLSL V25.2S, V0.2H, V2.2H
    SMMLA V11.4S, V25.16B, V8.16B
    FMLAL2 V27.4S, V5.4H, V18.4H
    UMMLA V28.4S, V31.16B, V22.16B
    USDOT V13.4S, V19.16B, V16.4B[0x2]
    FMLAL2 V23.4S, V30.4H, V9.4H
    UMMLA V5.4S, V25.16B, V6.16B
    USDOT V9.4S, V2.16B, V9.4B[0x0]
    FMLSL2 V7.4S, V24.4H, V14.H[0x3]
    FMLAL V24.4S, V28.4H, V13.H[0x7]
    FMLSL V3.4S, V5.4H, V23.4H
    FMLSL V31.2S, V24.2H, V9.H[0x4]
    FMLAL V0.2S, V1.2H, V3.H[0x5]
    SUDOT V3.4S, V7.16B, V7.4B[0x2]
    FMLAL2 V0.4S, V22.4H, V11.H[0x1]
    FMLAL V16.4S, V29.4H, V0.H[0x7]
    FMLSL2 V1.2S, V3.2H, V17.2H
    FMLAL V25.4S, V16.4H, V1.H[0x3]
    FMLAL2 V30.4S, V27.4H, V15.H[0x5]
    FMLAL2 V9.4S, V31.4H, V30.4H
    SMMLA V6.4S, V26.16B, V20.16B
    FMLSL V5.2S, V14.2H, V7.2H
    USDOT V3.4S, V18.16B, V25.4B[0x3]
    USDOT V31.2S, V20.8B, V16.8B
    SUDOT V1.2S, V6.8B, V14.4B[0x2]
    USDOT V30.2S, V15.8B, V12.4B[0x2]
    USDOT V18.4S, V0.16B, V16.4B[0x3]
    USDOT V23.4S, V28.16B, V30.4B[0x3]
    FMLAL V19.4S, V4.4H, V9.H[0x7]
    USDOT V12.4S, V2.16B, V3.16B
    FMLSL V17.2S, V31.2H, V4.H[0x3]
    USDOT V14.2S, V11.8B, V14.8B
    FMLAL V25.2S, V19.2H, V16.2H
    FMLAL2 V7.4S, V28.4H, V1.H[0x2]
    USDOT V15.4S, V4.16B, V7.16B
    FMLAL V7.4S, V5.4H, V11.H[0x2]
    SMMLA V13.4S, V23.16B, V31.16B
    FMLSL2 V2.2S, V18.2H, V1.H[0x6]
    FMLSL V19.2S, V0.2H, V4.H[0x0]
    FMLAL V6.4S, V14.4H, V15.4H
    USDOT V23.2S, V13.8B, V19.8B
    FMLAL2 V0.2S, V16.2H, V28.2H
    FMLSL V28.2S, V12.2H, V23.2H
    FMLAL V26.2S, V8.2H, V7.2H
    USDOT V13.4S, V20.16B, V28.4B[0x3]
    FMLSL V31.2S, V21.2H, V10.2H
    USDOT V23.4S, V17.16B, V26.4B[0x3]
    FMLAL V3.2S, V16.2H, V13.H[0x1]
    FMLAL V16.4S, V2.4H, V2.H[0x3]
    SUDOT V14.2S, V22.8B, V0.4B[0x0]
    FMLAL2 V20.4S, V25.4H, V6.4H
    USDOT V26.4S, V5.16B, V23.4B[0x2]
    FMLSL2 V17.4S, V20.4H, V14.H[0x4]
    FMLAL2 V0.4S, V3.4H, V19.4H
    FMLSL2 V13.2S, V27.2H, V26.2H
    SMMLA V9.4S, V7.16B, V31.16B
    UMMLA V11.4S, V31.16B, V16.16B
    SMMLA V28.4S, V0.16B, V27.16B
    FMLSL2 V7.2S, V11.2H, V5.2H
    FMLAL V17.4S, V28.4H, V7.4H
    UMMLA V28.4S, V15.16B, V17.16B
    UMMLA V4.4S, V13.16B, V28.16B
    FMLAL2 V20.2S, V11.2H, V8.H[0x4]
    USDOT V23.2S, V4.8B, V23.4B[0x3]
    USDOT V4.2S, V8.8B, V17.8B
    USDOT V31.4S, V4.16B, V11.4B[0x0]
    SUDOT V5.2S, V19.8B, V6.4B[0x0]
    USDOT V4.2S, V11.8B, V23.4B[0x3]
    SUDOT V14.2S, V25.8B, V14.4B[0x0]
    FMLSL V2.2S, V17.2H, V11.2H
    FMLAL V7.2S, V23.2H, V0.H[0x3]
    FMLAL2 V15.4S, V13.4H, V11.4H
    SMMLA V28.4S, V29.16B, V9.16B
    USDOT V27.2S, V20.8B, V3.8B
    USDOT V9.4S, V14.16B, V4.4B[0x1]
    UMMLA V0.4S, V22.16B, V17.16B
    FMLSL2 V29.2S, V31.2H, V7.H[0x4]
    SUDOT V14.2S, V17.8B, V23.4B[0x2]
    FMLSL V4.4S, V0.4H, V27.4H
    FMLSL2 V6.4S, V25.4H, V9.4H
    USDOT V14.4S, V29.16B, V7.16B
    USDOT V17.4S, V20.16B, V7.16B
    FMLAL V27.2S, V5.2H, V2.H[0x5]
    USDOT V31.2S, V11.8B, V4.8B
    FMLAL V19.4S, V4.4H, V15.H[0x5]
    FMLSL2 V0.2S, V6.2H, V13.H[0x7]
    USDOT V4.2S, V28.8B, V27.4B[0x2]
    FMLAL V11.4S, V17.4H, V31.4H
    FMLAL V2.4S, V14.4H, V5.H[0x2]
    SUDOT V24.4S, V19.16B, V19.4B[0x2]
    FMLAL2 V5.4S, V4.4H, V10.4H
    USDOT V3.4S, V0.16B, V5.4B[0x2]
    SUDOT V15.2S, V28.8B, V3.4B[0x3]
    FMLAL2 V31.2S, V2.2H, V2.2H
    FMLSL V3.2S, V11.2H, V11.H[0x7]
    USDOT V25.2S, V28.8B, V31.4B[0x0]
    FMLAL2 V23.2S, V14.2H, V15.H[0x7]
    FMLSL V27.2S, V3.2H, V4.H[0x1]
    FMLAL2 V29.4S, V24.4H, V27.4H
    SUDOT V28.4S, V25.16B, V29.4B[0x2]
    SUBS  X21, X21, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_0
    MOVZ  X28, #0x2034, LSL #0
    MOVK  X28, #0xed74, LSL #16
    MOVK  X28, #0xba5f, LSL #32
    MOVK  X28, #0x7d8e, LSL #48
    SUB  X9, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x7037, LSL #0
    MOVK  X28, #0xb6f, LSL #16
    MOVK  X28, #0xdf10, LSL #32
    MOVK  X28, #0x5492, LSL #48
    SUB  X9, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x905e, LSL #0
    MOVK  X28, #0x957e, LSL #16
    MOVK  X28, #0x3165, LSL #32
    MOVK  X28, #0x44bf, LSL #48
    SUB  X9, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xde26, LSL #0
    MOVK  X28, #0xef04, LSL #16
    MOVK  X28, #0xbb8e, LSL #32
    MOVK  X28, #0xc88a, LSL #48
    SUB  X9, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xe2d5, LSL #0
    MOVK  X28, #0x476d, LSL #16
    MOVK  X28, #0x2769, LSL #32
    MOVK  X28, #0xf56e, LSL #48
    SUB  X9, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xe243, LSL #0
    MOVK  X28, #0x36bc, LSL #16
    MOVK  X28, #0xd188, LSL #32
    MOVK  X28, #0x262c, LSL #48
    SUB  X9, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x3b98, LSL #0
    MOVK  X28, #0xc643, LSL #16
    MOVK  X28, #0x9e2f, LSL #32
    MOVK  X28, #0x1199, LSL #48
    SUB  X9, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x6cdb, LSL #0
    MOVK  X28, #0x811c, LSL #16
    MOVK  X28, #0x24ba, LSL #32
    MOVK  X28, #0x55c2, LSL #48
    SUB  X9, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xb902, LSL #0
    MOVK  X28, #0xad49, LSL #16
    MOVK  X28, #0x571e, LSL #32
    MOVK  X28, #0xa86a, LSL #48
    SUB  X9, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x6b83, LSL #0
    MOVK  X28, #0xfe1b, LSL #16
    MOVK  X28, #0xea9a, LSL #32
    MOVK  X28, #0xb4aa, LSL #48
    SUB  X9, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xb4e4, LSL #0
    MOVK  X28, #0x3d88, LSL #16
    MOVK  X28, #0xf1d3, LSL #32
    MOVK  X28, #0x3dc7, LSL #48
    SUB  X9, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x467c, LSL #0
    MOVK  X28, #0x8867, LSL #16
    MOVK  X28, #0xb10f, LSL #32
    MOVK  X28, #0xade5, LSL #48
    SUB  X9, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xbbf2, LSL #0
    MOVK  X28, #0x24e7, LSL #16
    MOVK  X28, #0x73ce, LSL #32
    MOVK  X28, #0xb2f7, LSL #48
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x6e55, LSL #0
    MOVK  X28, #0x63eb, LSL #16
    MOVK  X28, #0xdb61, LSL #32
    MOVK  X28, #0x151f, LSL #48
    SUB  X9, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xeaa3, LSL #0
    MOVK  X28, #0x8294, LSL #16
    MOVK  X28, #0xdd25, LSL #32
    MOVK  X28, #0xa56, LSL #48
    SUB  X9, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xa503, LSL #0
    MOVK  X28, #0x26e0, LSL #16
    MOVK  X28, #0xc7a9, LSL #32
    MOVK  X28, #0xe04e, LSL #48
    SUB  X9, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xabcb, LSL #0
    MOVK  X28, #0xf442, LSL #16
    MOVK  X28, #0xda28, LSL #32
    MOVK  X28, #0x20c4, LSL #48
    SUB  X9, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xd614, LSL #0
    MOVK  X28, #0x247, LSL #16
    MOVK  X28, #0x76d8, LSL #32
    MOVK  X28, #0xd427, LSL #48
    SUB  X9, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x8797, LSL #0
    MOVK  X28, #0x80cd, LSL #16
    MOVK  X28, #0xc14c, LSL #32
    MOVK  X28, #0xb948, LSL #48
    SUB  X9, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0x37c, LSL #0
    MOVK  X28, #0x46b3, LSL #16
    MOVK  X28, #0x9633, LSL #32
    MOVK  X28, #0xe9de, LSL #48
    SUB  X9, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X28, #0xdadd, LSL #0
    MOVK  X28, #0xa139, LSL #16
    MOVK  X28, #0x63f6, LSL #32
    MOVK  X28, #0x6a4b, LSL #48
    SUB  X9, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X28, FPSR
    MOVZ  X9, #0x91, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D0
    MOVZ  X9, #0xb879, LSL #0
    MOVK  X9, #0x7ff6, LSL #16
    MOVK  X9, #0x6000, LSL #32
    MOVK  X9, #0x7ffe, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D1
    MOVZ  X9, #0x2000, LSL #0
    MOVK  X9, #0x7fcd, LSL #16
    MOVK  X9, #0x8000, LSL #32
    MOVK  X9, #0xfff8, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X9, #0x6290, LSL #0
    MOVK  X9, #0x3da9, LSL #16
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D2
    MOVZ  X9, #0xa300, LSL #0
    MOVK  X9, #0x40d2, LSL #16
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D3
    MOVZ  X9, #0xe000, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xc000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D4
    MOVZ  X9, #0xadb5, LSL #0
    MOVK  X9, #0x7fd9, LSL #16
    MOVK  X9, #0xa36, LSL #32
    MOVK  X9, #0xfffd, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D5
    MOVZ  X9, #0x30f4, LSL #0
    MOVK  X9, #0xffcd, LSL #16
    MOVK  X9, #0x1b1d, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X9, #0x6920, LSL #0
    MOVK  X9, #0xc4d6, LSL #16
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D6
    MOVZ  X9, #0xa092, LSL #0
    MOVK  X9, #0xffd0, LSL #16
    MOVK  X9, #0x6982, LSL #32
    MOVK  X9, #0xfff3, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D7
    MOVZ  X9, #0xbf4f, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x1121, LSL #32
    MOVK  X9, #0x7ffe, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D8
    MOVZ  X9, #0x3235, LSL #0
    MOVK  X9, #0xde7e, LSL #16
    MOVK  X9, #0x7fff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X9, #0xde45, LSL #0
    MOVK  X9, #0x811b, LSL #16
    MOVK  X9, #0xee64, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D9
    MOVZ  X9, #0x4bbd, LSL #0
    MOVK  X9, #0xfe1e, LSL #16
    MOVK  X9, #0xd914, LSL #32
    MOVK  X9, #0xfffc, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X9, #0x7240, LSL #0
    MOVK  X9, #0x4236, LSL #16
    MOVK  X9, #0x6000, LSL #32
    MOVK  X9, #0xfffe, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D10
    MOVZ  X9, #0x242f, LSL #0
    MOVK  X9, #0xcb20, LSL #16
    MOVK  X9, #0xb5a2, LSL #32
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X9, #0x2000, LSL #0
    MOVK  X9, #0x7fcd, LSL #16
    MOVK  X9, #0x4000, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D11
    MOVZ  X9, #0xf400, LSL #0
    MOVK  X9, #0x4166, LSL #16
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X9, #0x1caa, LSL #0
    MOVK  X9, #0x8400, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D12
    MOVZ  X9, #0xa1dd, LSL #0
    MOVK  X9, #0xa13a, LSL #16
    MOVK  X9, #0x2f0a, LSL #32
    MOVK  X9, #0x6a4a, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D13
    MOVZ  X9, #0x71, LSL #0
    MOVK  X9, #0x4a50, LSL #16
    MOVK  X9, #0x66bc, LSL #32
    MOVK  X9, #0xfff7, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D14
    MOVZ  X9, #0xeae0, LSL #0
    MOVK  X9, #0xffef, LSL #16
    MOVK  X9, #0x4df4, LSL #32
    MOVK  X9, #0x1, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D15
    MOVZ  X9, #0xcd22, LSL #0
    MOVK  X9, #0xc66b, LSL #16
    MOVK  X9, #0xa000, LSL #32
    MOVK  X9, #0x7ff9, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X9, #0xe000, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x6000, LSL #32
    MOVK  X9, #0xfff8, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D16
    MOVZ  X9, #0x698, LSL #0
    MOVK  X9, #0xfffe, LSL #16
    MOVK  X9, #0x5253, LSL #32
    MOVK  X9, #0x7ffa, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X9, #0xc000, LSL #0
    MOVK  X9, #0xfffc, LSL #16
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D17
    MOVZ  X9, #0x10e0, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xaadc, LSL #32
    MOVK  X9, #0x7ffb, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X9, #0xaed4, LSL #0
    MOVK  X9, #0xf442, LSL #16
    MOVK  X9, #0xdd31, LSL #32
    MOVK  X9, #0x20c4, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D18
    MOVZ  X9, #0xa0c9, LSL #0
    MOVK  X9, #0x957f, LSL #16
    MOVK  X9, #0x3e3d, LSL #32
    MOVK  X9, #0x44c0, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D19
    MOVZ  X9, #0xe000, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x8a49, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D20
    MOVZ  X9, #0x23c7, LSL #0
    MOVK  X9, #0x3d89, LSL #16
    MOVK  X9, #0x6456, LSL #32
    MOVK  X9, #0x3dc5, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D21
    MOVZ  X9, #0x7d22, LSL #0
    MOVK  X9, #0x7fec, LSL #16
    MOVK  X9, #0x9c3e, LSL #32
    MOVK  X9, #0xfffe, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D22
    MOVZ  X9, #0xa94b, LSL #0
    MOVK  X9, #0xc7be, LSL #16
    MOVK  X9, #0x2229, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D23
    MOVZ  X9, #0xd732, LSL #0
    MOVK  X9, #0x7ff7, LSL #16
    MOVK  X9, #0xa869, LSL #32
    MOVK  X9, #0x7ffc, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X9, #0xe000, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D24
    MOVZ  X9, #0xe000, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xda9a, LSL #32
    MOVK  X9, #0xfffc, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D25
    MOVZ  X9, #0x155f, LSL #0
    MOVK  X9, #0xffdf, LSL #16
    MOVK  X9, #0x57e9, LSL #32
    MOVK  X9, #0x7ffc, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D26
    MOVZ  X9, #0xd619, LSL #0
    MOVK  X9, #0x63ee, LSL #16
    MOVK  X9, #0x19f1, LSL #32
    MOVK  X9, #0xffc4, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D27
    MOVZ  X9, #0x3b44, LSL #0
    MOVK  X9, #0x7ffb, LSL #16
    MOVK  X9, #0xb69f, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X9, #0xa85, LSL #0
    MOVK  X9, #0x242, LSL #32
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D28
    MOVZ  X9, #0x886d, LSL #0
    MOVK  X9, #0x7ff8, LSL #16
    MOVK  X9, #0x7172, LSL #32
    MOVK  X9, #0x1, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D29
    MOVZ  X9, #0xc8d4, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xcd0d, LSL #32
    MOVK  X9, #0xffc3, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D30
    MOVZ  X9, #0x8889, LSL #0
    MOVK  X9, #0xc4ef, LSL #16
    MOVK  X9, #0xe000, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X28, D31
    MOVZ  X9, #0x75ec, LSL #0
    MOVK  X9, #0xffe4, LSL #16
    MOVK  X9, #0xa737, LSL #32
    MOVK  X9, #0xfffd, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X16
    FMOV  V0.D[1], X19
    FMOV  D1, X15
    FMOV  V1.D[1], X19
    FMOV  D2, X28
    FMOV  V2.D[1], X20
    FMOV  D3, X24
    FMOV  V3.D[1], X25
    FMOV  D4, X29
    FMOV  V4.D[1], X22
    FMOV  D5, X26
    FMOV  V5.D[1], X21
    FMOV  D6, X25
    FMOV  V6.D[1], X27
    FMOV  D7, X18
    FMOV  V7.D[1], X28
    FMOV  D8, X24
    FMOV  V8.D[1], X23
    FMOV  D9, X16
    FMOV  V9.D[1], X23
    FMOV  D10, X28
    FMOV  V10.D[1], X20
    FMOV  D11, X22
    FMOV  V11.D[1], X13
    FMOV  D12, X23
    FMOV  V12.D[1], X24
    FMOV  D13, X23
    FMOV  V13.D[1], X13
    FMOV  D14, X22
    FMOV  V14.D[1], X2
    FMOV  D15, X10
    FMOV  V15.D[1], X22
    FMOV  D16, X29
    FMOV  V16.D[1], X17
    FMOV  D17, X11
    FMOV  V17.D[1], X22
    FMOV  D18, X16
    FMOV  V18.D[1], X23
    FMOV  D19, X26
    FMOV  V19.D[1], X27
    FMOV  D20, X26
    FMOV  V20.D[1], X6
    FMOV  D21, X6
    FMOV  V21.D[1], X17
    FMOV  D22, X3
    FMOV  V22.D[1], X20
    FMOV  D23, X25
    FMOV  V23.D[1], X15
    FMOV  D24, X9
    FMOV  V24.D[1], X14
    FMOV  D25, X3
    FMOV  V25.D[1], X6
    FMOV  D26, X20
    FMOV  V26.D[1], X19
    FMOV  D27, X11
    FMOV  V27.D[1], X12
    FMOV  D28, X11
    FMOV  V28.D[1], X12
    FMOV  D29, X26
    FMOV  V29.D[1], X26
    FMOV  D30, X26
    FMOV  V30.D[1], X20
    FMOV  D31, X10
    FMOV  V31.D[1], X25
    MOVZ  X27, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_1:
    USMMLA V25.4S, V26.16B, V28.16B
    FMLSL2 V0.2S, V30.2H, V2.H[0x5]
    FMLSL V5.2S, V18.2H, V15.H[0x3]
    USDOT V19.2S, V5.8B, V20.8B
    FMLAL V25.4S, V27.4H, V31.4H
    FMLSL V15.2S, V25.2H, V29.2H
    FMLSL2 V10.2S, V14.2H, V19.2H
    FMLAL V30.4S, V25.4H, V0.4H
    FMLSL V29.2S, V16.2H, V13.2H
    FMLSL2 V5.4S, V10.4H, V29.4H
    SUDOT V25.2S, V15.8B, V5.4B[0x2]
    UMMLA V10.4S, V30.16B, V24.16B
    FMLAL2 V15.4S, V23.4H, V10.4H
    SMMLA V30.4S, V26.16B, V30.16B
    SMMLA V26.4S, V27.16B, V10.16B
    FMLAL2 V28.4S, V25.4H, V27.4H
    FMLSL V24.2S, V6.2H, V29.2H
    UMMLA V27.4S, V7.16B, V28.16B
    USDOT V0.4S, V23.16B, V26.4B[0x1]
    USDOT V5.2S, V20.8B, V6.4B[0x0]
    SMMLA V14.4S, V0.16B, V20.16B
    USDOT V20.2S, V8.8B, V5.8B
    FMLSL2 V29.2S, V19.2H, V7.2H
    FMLSL V19.4S, V4.4H, V16.4H
    SUDOT V28.2S, V24.8B, V13.4B[0x1]
    FMLSL2 V10.4S, V26.4H, V31.4H
    SUDOT V8.2S, V27.8B, V24.4B[0x3]
    USMMLA V25.4S, V9.16B, V14.16B
    FMLAL V27.4S, V19.4H, V0.4H
    USDOT V1.2S, V14.8B, V0.4B[0x3]
    SUDOT V0.2S, V20.8B, V25.4B[0x2]
    FMLSL2 V19.4S, V27.4H, V27.4H
    FMLSL2 V5.4S, V29.4H, V1.H[0x0]
    FMLSL V31.2S, V8.2H, V10.H[0x7]
    SUDOT V25.2S, V28.8B, V0.4B[0x1]
    SMMLA V3.4S, V1.16B, V25.16B
    FMLSL2 V7.4S, V28.4H, V15.4H
    SUDOT V14.4S, V13.16B, V3.4B[0x0]
    USDOT V24.4S, V13.16B, V11.16B
    UMMLA V3.4S, V31.16B, V7.16B
    USDOT V31.2S, V3.8B, V5.4B[0x0]
    FMLSL V23.4S, V24.4H, V8.H[0x2]
    USDOT V7.2S, V14.8B, V1.4B[0x1]
    FMLAL V14.2S, V7.2H, V7.H[0x0]
    USDOT V10.2S, V0.8B, V23.4B[0x2]
    SUDOT V0.4S, V31.16B, V18.4B[0x3]
    FMLSL V9.4S, V14.4H, V10.H[0x7]
    UMMLA V25.4S, V31.16B, V27.16B
    FMLAL V8.4S, V11.4H, V0.H[0x4]
    FMLSL V14.2S, V8.2H, V9.H[0x7]
    FMLSL V19.4S, V10.4H, V23.4H
    FMLSL V20.4S, V8.4H, V12.H[0x4]
    FMLSL V24.4S, V25.4H, V1.4H
    FMLSL V29.4S, V7.4H, V6.4H
    FMLAL2 V10.2S, V20.2H, V1.2H
    FMLAL V10.2S, V29.2H, V19.2H
    FMLSL2 V25.4S, V3.4H, V10.H[0x7]
    USDOT V8.2S, V1.8B, V27.4B[0x2]
    USDOT V1.4S, V14.16B, V30.16B
    UMMLA V22.4S, V1.16B, V11.16B
    USDOT V9.2S, V15.8B, V12.4B[0x1]
    FMLSL V12.4S, V15.4H, V25.4H
    FMLSL2 V28.4S, V29.4H, V8.H[0x1]
    SUDOT V26.4S, V22.16B, V9.4B[0x3]
    FMLSL V0.4S, V26.4H, V10.4H
    FMLAL2 V14.4S, V0.4H, V6.H[0x7]
    USDOT V19.4S, V14.16B, V24.16B
    USMMLA V8.4S, V19.16B, V5.16B
    USDOT V19.4S, V8.16B, V8.4B[0x3]
    UMMLA V29.4S, V19.16B, V30.16B
    USDOT V22.4S, V29.16B, V29.16B
    USDOT V0.2S, V12.8B, V28.4B[0x0]
    USDOT V20.4S, V15.16B, V9.4B[0x2]
    FMLSL V30.4S, V3.4H, V22.4H
    FMLAL2 V9.2S, V2.2H, V8.H[0x4]
    SMMLA V26.4S, V13.16B, V6.16B
    USDOT V29.2S, V12.8B, V30.8B
    UMMLA V2.4S, V11.16B, V14.16B
    FMLSL V5.2S, V24.2H, V15.2H
    SMMLA V1.4S, V7.16B, V11.16B
    FMLSL2 V25.2S, V25.2H, V3.H[0x5]
    SMMLA V27.4S, V18.16B, V0.16B
    SUDOT V8.2S, V20.8B, V26.4B[0x2]
    FMLAL V13.2S, V5.2H, V9.2H
    SUDOT V15.4S, V11.16B, V30.4B[0x2]
    FMLSL2 V28.2S, V25.2H, V15.2H
    USDOT V7.4S, V13.16B, V28.4B[0x2]
    SMMLA V22.4S, V25.16B, V29.16B
    FMLSL V16.4S, V7.4H, V1.H[0x1]
    FMLSL2 V5.4S, V16.4H, V6.H[0x7]
    FMLSL2 V31.4S, V16.4H, V5.H[0x7]
    FMLSL2 V24.4S, V8.4H, V22.4H
    FMLAL V10.4S, V24.4H, V31.4H
    FMLSL2 V3.2S, V27.2H, V2.H[0x5]
    USDOT V5.2S, V25.8B, V29.4B[0x3]
    FMLAL2 V7.4S, V23.4H, V0.4H
    FMLAL2 V31.4S, V4.4H, V7.H[0x2]
    USDOT V4.2S, V9.8B, V12.4B[0x0]
    FMLSL2 V8.2S, V8.2H, V7.2H
    FMLAL2 V25.2S, V6.2H, V12.H[0x2]
    FMLSL V14.2S, V10.2H, V10.H[0x1]
    FMLSL2 V30.4S, V16.4H, V7.H[0x4]
    UMMLA V23.4S, V30.16B, V23.16B
    FMLAL V5.4S, V2.4H, V9.H[0x6]
    FMLAL V11.4S, V5.4H, V0.4H
    USMMLA V16.4S, V11.16B, V24.16B
    USDOT V22.4S, V9.16B, V14.4B[0x3]
    FMLAL V14.4S, V12.4H, V22.4H
    FMLSL V9.4S, V22.4H, V10.H[0x3]
    FMLSL2 V12.2S, V22.2H, V14.H[0x1]
    UMMLA V30.4S, V25.16B, V4.16B
    SMMLA V24.4S, V14.16B, V23.16B
    FMLSL2 V19.2S, V0.2H, V3.2H
    FMLAL2 V0.2S, V24.2H, V24.2H
    USDOT V10.2S, V12.8B, V0.8B
    FMLAL2 V4.2S, V23.2H, V15.2H
    FMLAL V15.2S, V31.2H, V8.H[0x3]
    FMLAL2 V22.2S, V10.2H, V0.H[0x0]
    SMMLA V0.4S, V4.16B, V12.16B
    SUDOT V14.2S, V9.8B, V14.4B[0x3]
    FMLSL2 V29.4S, V22.4H, V13.4H
    UMMLA V28.4S, V27.16B, V16.16B
    SMMLA V10.4S, V14.16B, V0.16B
    FMLSL2 V2.2S, V15.2H, V28.2H
    USMMLA V7.4S, V3.16B, V10.16B
    FMLAL2 V25.2S, V2.2H, V5.H[0x2]
    FMLAL V5.2S, V27.2H, V23.2H
    USDOT V0.4S, V7.16B, V25.4B[0x3]
    FMLAL2 V24.4S, V5.4H, V5.H[0x1]
    USDOT V7.4S, V30.16B, V24.4B[0x1]
    FMLSL V16.2S, V7.2H, V7.H[0x5]
    UMMLA V28.4S, V19.16B, V31.16B
    FMLSL V27.4S, V21.4H, V0.H[0x2]
    USDOT V19.4S, V27.16B, V28.4B[0x3]
    USMMLA V8.4S, V16.16B, V1.16B
    USMMLA V5.4S, V8.16B, V19.16B
    FMLAL V19.2S, V14.2H, V7.2H
    SMMLA V10.4S, V29.16B, V5.16B
    USDOT V15.4S, V12.16B, V15.4B[0x2]
    USDOT V3.2S, V9.8B, V11.4B[0x1]
    USDOT V11.4S, V8.16B, V7.4B[0x0]
    FMLAL2 V7.2S, V3.2H, V27.2H
    UMMLA V8.4S, V4.16B, V2.16B
    FMLSL V12.2S, V20.2H, V11.H[0x6]
    USDOT V20.2S, V18.8B, V6.8B
    USMMLA V22.4S, V17.16B, V30.16B
    USDOT V11.4S, V29.16B, V27.4B[0x3]
    FMLAL V16.2S, V11.2H, V22.2H
    SUDOT V12.4S, V8.16B, V10.4B[0x1]
    USDOT V30.2S, V7.8B, V20.8B
    FMLSL2 V3.4S, V10.4H, V30.4H
    FMLAL2 V4.2S, V15.2H, V12.2H
    FMLAL V8.4S, V3.4H, V4.4H
    FMLSL2 V18.4S, V29.4H, V8.H[0x0]
    FMLAL2 V2.2S, V16.2H, V11.H[0x0]
    FMLSL V31.4S, V2.4H, V1.H[0x7]
    SMMLA V4.4S, V31.16B, V31.16B
    SUDOT V29.4S, V4.16B, V17.4B[0x0]
    UMMLA V29.4S, V23.16B, V18.16B
    USDOT V8.2S, V4.8B, V3.4B[0x2]
    SUDOT V6.4S, V3.16B, V20.4B[0x1]
    FMLSL V20.2S, V26.2H, V19.2H
    USDOT V30.4S, V11.16B, V2.4B[0x3]
    FMLSL2 V22.4S, V24.4H, V4.H[0x7]
    FMLSL2 V18.4S, V27.4H, V0.4H
    USMMLA V11.4S, V5.16B, V10.16B
    UMMLA V16.4S, V2.16B, V16.16B
    FMLAL V19.4S, V17.4H, V24.4H
    USDOT V3.2S, V18.8B, V22.4B[0x0]
    FMLAL V26.4S, V28.4H, V8.H[0x4]
    SUDOT V25.4S, V29.16B, V20.4B[0x0]
    FMLAL2 V15.4S, V19.4H, V15.H[0x7]
    FMLAL2 V10.2S, V16.2H, V4.H[0x4]
    UMMLA V6.4S, V10.16B, V26.16B
    FMLSL2 V10.2S, V3.2H, V7.2H
    FMLSL V26.2S, V6.2H, V11.H[0x4]
    FMLAL V12.2S, V25.2H, V30.2H
    SUDOT V5.4S, V10.16B, V19.4B[0x1]
    FMLAL2 V11.2S, V12.2H, V13.2H
    FMLSL2 V1.4S, V3.4H, V11.H[0x4]
    SUDOT V13.2S, V28.8B, V4.4B[0x3]
    FMLAL2 V16.2S, V1.2H, V14.H[0x3]
    FMLAL2 V8.2S, V26.2H, V15.2H
    USMMLA V24.4S, V25.16B, V5.16B
    USMMLA V18.4S, V13.16B, V11.16B
    FMLAL V20.2S, V16.2H, V16.2H
    USDOT V19.2S, V4.8B, V1.4B[0x0]
    FMLAL2 V16.2S, V6.2H, V19.2H
    FMLAL2 V29.4S, V18.4H, V20.4H
    FMLAL2 V5.4S, V8.4H, V11.H[0x0]
    FMLSL V5.2S, V29.2H, V2.H[0x6]
    UMMLA V3.4S, V24.16B, V24.16B
    FMLAL V15.4S, V5.4H, V19.4H
    UMMLA V14.4S, V1.16B, V15.16B
    FMLSL2 V18.2S, V27.2H, V13.2H
    USDOT V24.2S, V3.8B, V3.4B[0x1]
    FMLSL V4.2S, V14.2H, V14.H[0x5]
    USDOT V29.2S, V9.8B, V16.8B
    FMLAL2 V9.2S, V4.2H, V29.2H
    FMLSL2 V29.4S, V18.4H, V9.H[0x4]
    SUBS  X27, X27, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_1
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X16, FPSR
    MOVZ  X2, #0x91, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X10
    FMOV  V1.D[1], X21
    FMOV  D2, X15
    FMOV  V2.D[1], X14
    FMOV  D3, X9
    FMOV  V3.D[1], X25
    FMOV  D4, X19
    FMOV  V4.D[1], X27
    FMOV  D5, X24
    FMOV  V5.D[1], X11
    FMOV  D6, X25
    FMOV  V6.D[1], X2
    FMOV  D7, X20
    FMOV  V7.D[1], X17
    FMOV  D8, X22
    FMOV  V8.D[1], X17
    FMOV  D9, X16
    FMOV  V9.D[1], X28
    FMOV  D10, X3
    FMOV  V10.D[1], X8
    FMOV  D11, X11
    FMOV  V11.D[1], X28
    FMOV  D12, X16
    FMOV  V12.D[1], X14
    FMOV  D13, X18
    FMOV  V13.D[1], X2
    FMOV  D14, X8
    FMOV  V14.D[1], X20
    FMOV  D15, X25
    FMOV  V15.D[1], X20
    FMOV  D16, X29
    FMOV  V16.D[1], X10
    FMOV  D17, X10
    FMOV  V17.D[1], X3
    FMOV  D18, X2
    FMOV  V18.D[1], X29
    FMOV  D19, X15
    FMOV  V19.D[1], X6
    FMOV  D20, X19
    FMOV  V20.D[1], X15
    FMOV  D21, X12
    FMOV  V21.D[1], X26
    FMOV  D22, X27
    FMOV  V22.D[1], X13
    FMOV  D23, X9
    FMOV  V23.D[1], X29
    FMOV  D24, X21
    FMOV  V24.D[1], X26
    FMOV  D25, X16
    FMOV  V25.D[1], X25
    FMOV  D26, X15
    FMOV  V26.D[1], X17
    FMOV  D27, X10
    FMOV  V27.D[1], X10
    FMOV  D28, X8
    FMOV  V28.D[1], X10
    FMOV  D29, X9
    FMOV  V29.D[1], X21
    FMOV  D30, X10
    FMOV  V30.D[1], X17
    FMOV  D31, X11
    FMOV  V31.D[1], X14
    MOVZ  X17, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_2:
    USDOT V2.4S, V28.16B, V27.4B[0x3]
    USDOT V1.4S, V4.16B, V24.16B
    FMLAL V26.4S, V29.4H, V4.H[0x1]
    UMMLA V21.4S, V1.16B, V1.16B
    FMLSL2 V17.2S, V31.2H, V29.2H
    USDOT V30.2S, V2.8B, V21.4B[0x3]
    SUDOT V0.4S, V4.16B, V26.4B[0x1]
    FMLAL V2.2S, V31.2H, V3.H[0x5]
    FMLAL V1.2S, V29.2H, V0.H[0x0]
    UMMLA V14.4S, V1.16B, V9.16B
    USDOT V28.4S, V11.16B, V2.16B
    UMMLA V21.4S, V21.16B, V17.16B
    FMLSL2 V13.2S, V11.2H, V14.H[0x0]
    SUDOT V14.2S, V21.8B, V9.4B[0x0]
    SUDOT V7.4S, V16.16B, V14.4B[0x3]
    SMMLA V5.4S, V7.16B, V20.16B
    USDOT V24.4S, V27.16B, V9.16B
    USMMLA V24.4S, V9.16B, V5.16B
    FMLAL2 V1.4S, V20.4H, V13.H[0x0]
    FMLSL2 V0.2S, V11.2H, V12.H[0x5]
    USDOT V24.4S, V24.16B, V24.4B[0x1]
    UMMLA V4.4S, V28.16B, V24.16B
    FMLAL2 V13.2S, V11.2H, V2.H[0x6]
    FMLAL V3.4S, V31.4H, V13.H[0x7]
    SMMLA V5.4S, V1.16B, V4.16B
    FMLAL V5.4S, V0.4H, V30.4H
    USDOT V1.4S, V5.16B, V16.4B[0x2]
    FMLSL2 V4.2S, V4.2H, V30.2H
    USDOT V5.4S, V16.16B, V16.16B
    UMMLA V0.4S, V26.16B, V8.16B
    USDOT V24.2S, V5.8B, V14.8B
    FMLAL V31.2S, V31.2H, V1.2H
    UMMLA V16.4S, V30.16B, V30.16B
    USDOT V9.2S, V31.8B, V8.4B[0x0]
    FMLAL2 V5.2S, V2.2H, V0.H[0x7]
    FMLSL2 V29.2S, V16.2H, V9.2H
    FMLAL V14.2S, V30.2H, V0.H[0x3]
    FMLSL2 V28.4S, V27.4H, V15.4H
    FMLAL2 V7.4S, V26.4H, V6.H[0x1]
    USDOT V1.4S, V27.16B, V23.16B
    USDOT V6.2S, V20.8B, V28.8B
    SMMLA V0.4S, V1.16B, V10.16B
    SMMLA V11.4S, V9.16B, V29.16B
    UMMLA V21.4S, V3.16B, V5.16B
    FMLSL V16.2S, V6.2H, V11.H[0x0]
    USDOT V31.2S, V23.8B, V24.8B
    FMLAL V26.2S, V7.2H, V14.2H
    UMMLA V29.4S, V16.16B, V1.16B
    FMLSL V6.4S, V21.4H, V0.4H
    FMLAL2 V12.4S, V16.4H, V6.H[0x7]
    USDOT V21.2S, V26.8B, V31.8B
    USDOT V14.2S, V29.8B, V29.8B
    USDOT V15.2S, V21.8B, V14.4B[0x2]
    FMLAL2 V10.2S, V15.2H, V15.H[0x5]
    FMLAL V8.2S, V10.2H, V12.H[0x2]
    USDOT V1.4S, V5.16B, V14.4B[0x0]
    SMMLA V28.4S, V7.16B, V27.16B
    SUDOT V6.4S, V24.16B, V13.4B[0x3]
    FMLSL V23.4S, V0.4H, V16.4H
    FMLAL V5.2S, V7.2H, V6.2H
    FMLSL2 V15.4S, V15.4H, V19.4H
    SUDOT V24.2S, V13.8B, V12.4B[0x2]
    UMMLA V11.4S, V28.16B, V10.16B
    SUDOT V19.4S, V22.16B, V5.4B[0x0]
    USDOT V21.4S, V28.16B, V4.16B
    FMLAL2 V29.4S, V15.4H, V20.4H
    FMLAL V26.2S, V31.2H, V28.2H
    FMLAL2 V18.2S, V29.2H, V19.2H
    USDOT V4.4S, V18.16B, V11.16B
    FMLAL2 V3.2S, V24.2H, V21.2H
    USDOT V5.2S, V8.8B, V23.4B[0x1]
    FMLSL V31.2S, V26.2H, V27.2H
    USDOT V18.4S, V31.16B, V5.4B[0x1]
    FMLAL2 V18.4S, V3.4H, V12.H[0x2]
    FMLAL2 V7.4S, V4.4H, V4.H[0x2]
    UMMLA V28.4S, V22.16B, V4.16B
    SUDOT V29.4S, V28.16B, V2.4B[0x0]
    USDOT V23.4S, V18.16B, V1.4B[0x0]
    FMLAL V24.4S, V25.4H, V14.4H
    FMLAL2 V15.2S, V25.2H, V7.H[0x5]
    FMLAL V2.2S, V15.2H, V24.2H
    FMLAL2 V5.2S, V29.2H, V2.2H
    FMLAL2 V13.4S, V31.4H, V16.4H
    SUDOT V8.4S, V30.16B, V7.4B[0x0]
    USDOT V19.2S, V31.8B, V26.8B
    FMLSL V28.2S, V30.2H, V6.H[0x6]
    USDOT V10.2S, V25.8B, V4.8B
    USDOT V14.2S, V29.8B, V12.4B[0x1]
    FMLSL2 V26.4S, V11.4H, V5.H[0x3]
    FMLSL2 V15.2S, V17.2H, V12.H[0x2]
    FMLAL2 V27.2S, V10.2H, V15.H[0x0]
    FMLAL V10.2S, V23.2H, V14.2H
    FMLAL2 V25.4S, V27.4H, V26.4H
    SUDOT V26.4S, V28.16B, V12.4B[0x2]
    FMLSL2 V6.2S, V27.2H, V0.H[0x4]
    SUDOT V15.2S, V26.8B, V7.4B[0x0]
    USDOT V17.4S, V24.16B, V13.16B
    SUDOT V7.2S, V25.8B, V17.4B[0x2]
    SUDOT V17.2S, V12.8B, V8.4B[0x3]
    USDOT V5.4S, V15.16B, V7.4B[0x3]
    FMLSL2 V17.2S, V6.2H, V10.2H
    UMMLA V26.4S, V5.16B, V17.16B
    USMMLA V2.4S, V28.16B, V2.16B
    FMLAL V14.4S, V1.4H, V8.4H
    FMLAL V27.2S, V23.2H, V10.2H
    SMMLA V28.4S, V21.16B, V29.16B
    FMLSL V4.4S, V1.4H, V31.4H
    UMMLA V6.4S, V18.16B, V14.16B
    FMLAL V11.4S, V12.4H, V27.4H
    FMLAL V14.2S, V19.2H, V6.H[0x2]
    FMLSL V24.4S, V0.4H, V3.H[0x2]
    SUDOT V17.4S, V27.16B, V14.4B[0x2]
    FMLSL2 V5.4S, V31.4H, V4.H[0x3]
    FMLSL V29.2S, V31.2H, V10.2H
    USDOT V29.2S, V24.8B, V18.4B[0x2]
    FMLSL V19.2S, V6.2H, V25.2H
    USDOT V13.2S, V9.8B, V8.8B
    SUDOT V24.2S, V11.8B, V28.4B[0x0]
    FMLAL2 V12.4S, V17.4H, V24.4H
    UMMLA V20.4S, V13.16B, V13.16B
    SUDOT V13.4S, V5.16B, V12.4B[0x0]
    UMMLA V23.4S, V25.16B, V13.16B
    FMLAL V3.2S, V19.2H, V9.H[0x4]
    FMLSL2 V0.4S, V23.4H, V3.H[0x0]
    FMLAL2 V9.2S, V5.2H, V0.H[0x3]
    FMLAL2 V7.2S, V16.2H, V29.2H
    FMLSL V18.4S, V9.4H, V1.H[0x2]
    USDOT V6.4S, V18.16B, V11.4B[0x3]
    USDOT V4.4S, V20.16B, V20.4B[0x1]
    FMLAL2 V23.2S, V7.2H, V8.H[0x2]
    SMMLA V21.4S, V28.16B, V23.16B
    FMLAL2 V25.2S, V6.2H, V4.H[0x1]
    UMMLA V12.4S, V25.16B, V22.16B
    USDOT V10.2S, V26.8B, V21.8B
    USMMLA V21.4S, V1.16B, V23.16B
    USDOT V23.2S, V10.8B, V24.8B
    SMMLA V25.4S, V12.16B, V12.16B
    USDOT V9.4S, V18.16B, V21.16B
    FMLSL2 V10.4S, V14.4H, V9.4H
    USDOT V19.2S, V10.8B, V16.4B[0x2]
    SUDOT V20.2S, V11.8B, V0.4B[0x1]
    FMLSL V31.2S, V24.2H, V25.2H
    SMMLA V9.4S, V20.16B, V17.16B
    FMLSL2 V14.4S, V29.4H, V9.4H
    SUDOT V10.2S, V23.8B, V23.4B[0x0]
    FMLAL V5.2S, V14.2H, V29.2H
    FMLSL2 V23.4S, V5.4H, V5.4H
    USDOT V7.4S, V10.16B, V31.4B[0x1]
    USDOT V13.2S, V19.8B, V7.4B[0x0]
    USDOT V29.4S, V9.16B, V9.4B[0x3]
    UMMLA V1.4S, V7.16B, V30.16B
    FMLAL2 V9.2S, V19.2H, V23.2H
    SUDOT V21.2S, V22.8B, V29.4B[0x0]
    FMLSL2 V19.2S, V0.2H, V25.2H
    FMLSL V24.2S, V31.2H, V7.H[0x7]
    FMLSL2 V29.4S, V2.4H, V11.H[0x0]
    FMLAL V25.2S, V23.2H, V4.2H
    FMLSL V13.4S, V30.4H, V6.4H
    FMLSL2 V20.4S, V16.4H, V0.H[0x1]
    FMLSL2 V20.4S, V11.4H, V7.4H
    FMLAL V13.4S, V1.4H, V21.4H
    USDOT V30.2S, V25.8B, V20.8B
    USDOT V12.4S, V30.16B, V19.16B
    FMLSL2 V10.4S, V29.4H, V29.4H
    FMLAL2 V17.4S, V4.4H, V3.H[0x4]
    FMLAL2 V18.2S, V12.2H, V3.H[0x7]
    FMLSL2 V6.2S, V13.2H, V1.2H
    SMMLA V13.4S, V17.16B, V0.16B
    SUDOT V20.4S, V25.16B, V16.4B[0x2]
    FMLAL2 V14.4S, V10.4H, V6.H[0x6]
    FMLSL2 V0.4S, V20.4H, V9.H[0x3]
    SUDOT V17.4S, V25.16B, V5.4B[0x1]
    FMLAL2 V31.2S, V11.2H, V14.H[0x2]
    USMMLA V12.4S, V24.16B, V18.16B
    FMLSL2 V19.2S, V31.2H, V12.2H
    UMMLA V9.4S, V0.16B, V16.16B
    SUDOT V22.2S, V15.8B, V0.4B[0x3]
    FMLAL2 V7.2S, V23.2H, V19.2H
    FMLSL V1.2S, V17.2H, V9.2H
    USDOT V13.2S, V1.8B, V7.8B
    USDOT V4.2S, V26.8B, V18.8B
    SMMLA V7.4S, V10.16B, V22.16B
    FMLAL2 V29.2S, V27.2H, V27.2H
    USDOT V23.2S, V25.8B, V10.8B
    USDOT V6.2S, V2.8B, V15.4B[0x3]
    FMLAL2 V2.2S, V14.2H, V28.2H
    SUDOT V1.2S, V15.8B, V16.4B[0x3]
    USDOT V25.4S, V23.16B, V4.16B
    UMMLA V27.4S, V9.16B, V27.16B
    FMLAL V23.4S, V29.4H, V11.4H
    SUDOT V20.2S, V21.8B, V13.4B[0x2]
    FMLSL V29.2S, V1.2H, V12.2H
    USDOT V12.4S, V6.16B, V26.16B
    USDOT V11.4S, V11.16B, V4.16B
    SUDOT V4.4S, V2.16B, V2.4B[0x0]
    FMLSL V21.2S, V11.2H, V12.H[0x2]
    FMLSL2 V1.4S, V23.4H, V14.H[0x4]
    FMLAL V23.2S, V25.2H, V15.2H
    SUDOT V9.4S, V7.16B, V12.4B[0x1]
    USDOT V5.2S, V27.8B, V1.4B[0x0]
    SUBS  X17, X17, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_2
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X16, FPSR
    MOVZ  X25, #0x91, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X25, #0xe000, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xe000, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D0
    MOVZ  X25, #0xe000, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xe000, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xe000, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D1
    MOVZ  X25, #0x71dc, LSL #0
    MOVK  X25, #0xffea, LSL #16
    MOVK  X25, #0x2323, LSL #32
    MOVK  X25, #0xffe6, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D2
    MOVZ  X25, #0x4d7e, LSL #0
    MOVK  X25, #0x7fd0, LSL #16
    MOVK  X25, #0xfc03, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D3
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D4
    MOVZ  X25, #0xa60b, LSL #0
    MOVK  X25, #0xcdbf, LSL #16
    MOVK  X25, #0xc61b, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D5
    MOVZ  X25, #0x63d8, LSL #0
    MOVK  X25, #0xffc0, LSL #16
    MOVK  X25, #0x3401, LSL #32
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D6
    MOVZ  X25, #0x9802, LSL #0
    MOVK  X25, #0xffec, LSL #16
    MOVK  X25, #0xa000, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D7
    MOVZ  X25, #0xc888, LSL #0
    MOVK  X25, #0xffcd, LSL #16
    MOVK  X25, #0xe863, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D8
    MOVZ  X25, #0x3c75, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0x3db1, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X25, #0x1a7a, LSL #0
    MOVK  X25, #0x5, LSL #16
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D9
    MOVZ  X25, #0x8861, LSL #0
    MOVK  X25, #0xfff5, LSL #16
    MOVK  X25, #0xc92e, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D10
    MOVZ  X25, #0x23cd, LSL #0
    MOVK  X25, #0xfffe, LSL #16
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X25, #0xe000, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D11
    MOVZ  X25, #0xec7c, LSL #0
    MOVK  X25, #0x4b15, LSL #16
    MOVK  X25, #0x2ba2, LSL #32
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D12
    MOVZ  X25, #0x3a50, LSL #0
    MOVK  X25, #0x2, LSL #16
    MOVK  X25, #0x407a, LSL #32
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D13
    MOVZ  X25, #0x7fb8, LSL #0
    MOVK  X25, #0x7ffd, LSL #16
    MOVK  X25, #0xa0b1, LSL #32
    MOVK  X25, #0xfffd, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D14
    MOVZ  X25, #0xcd53, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0x75d5, LSL #32
    MOVK  X25, #0xfffb, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D15
    MOVZ  X25, #0x7eb6, LSL #0
    MOVK  X25, #0x7fc6, LSL #16
    MOVK  X25, #0xbc5, LSL #32
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D16
    MOVZ  X25, #0x66f3, LSL #0
    MOVK  X25, #0xffe9, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D17
    MOVZ  X25, #0xa242, LSL #0
    MOVK  X25, #0x7fc4, LSL #16
    MOVK  X25, #0xc662, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D18
    MOVZ  X25, #0x6f35, LSL #0
    MOVK  X25, #0x7fda, LSL #16
    MOVK  X25, #0xb6e5, LSL #32
    MOVK  X25, #0x7ff9, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D19
    MOVZ  X25, #0xaa9c, LSL #0
    MOVK  X25, #0xffc2, LSL #16
    MOVK  X25, #0x398c, LSL #32
    MOVK  X25, #0x7ffd, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D20
    MOVZ  X25, #0xe000, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0x3e0c, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D21
    MOVZ  X25, #0x48a0, LSL #0
    MOVK  X25, #0x4e1c, LSL #16
    MOVK  X25, #0x16f0, LSL #32
    MOVK  X25, #0x48e2, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D22
    MOVZ  X25, #0xbdc5, LSL #0
    MOVK  X25, #0xbaf, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D23
    MOVZ  X25, #0x8000, LSL #0
    MOVK  X25, #0x7fc2, LSL #16
    MOVK  X25, #0xd6fb, LSL #32
    MOVK  X25, #0x7ffd, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D24
    MOVZ  X25, #0x6123, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0x3c8d, LSL #32
    MOVK  X25, #0xfffc, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D25
    MOVZ  X25, #0x7c14, LSL #0
    MOVK  X25, #0xfff6, LSL #16
    MOVK  X25, #0x123a, LSL #32
    MOVK  X25, #0x8000, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X25, #0xe000, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0xe000, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D26
    MOVZ  X25, #0x5b62, LSL #0
    MOVK  X25, #0x4, LSL #16
    MOVK  X25, #0x9dc2, LSL #32
    MOVK  X25, #0x7ffc, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X25, #0x63ec, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D27
    MOVZ  X25, #0x4524, LSL #0
    MOVK  X25, #0x7ff5, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D28
    MOVZ  X25, #0x35b1, LSL #0
    MOVK  X25, #0xc6e5, LSL #16
    MOVK  X25, #0xe128, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D29
    MOVZ  X25, #0x57b2, LSL #0
    MOVK  X25, #0x7ff0, LSL #16
    MOVK  X25, #0xb1cf, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D30
    MOVZ  X25, #0x7d30, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xd9a0, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X16, D31
    MOVZ  X25, #0xcd2a, LSL #0
    MOVK  X25, #0x7fcf, LSL #16
    MOVK  X25, #0x1f25, LSL #32
    MOVK  X25, #0x7fd0, LSL #48
    SUB  X28, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X9
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X6
    FMOV  V2.D[1], X26
    FMOV  D3, X24
    FMOV  V3.D[1], X3
    FMOV  D4, X21
    FMOV  V4.D[1], X6
    FMOV  D5, X25
    FMOV  V5.D[1], X28
    FMOV  D6, X23
    FMOV  V6.D[1], X3
    FMOV  D7, X10
    FMOV  V7.D[1], X17
    FMOV  D8, X6
    FMOV  V8.D[1], X25
    FMOV  D9, X17
    FMOV  V9.D[1], X16
    FMOV  D10, X26
    FMOV  V10.D[1], X11
    FMOV  D11, X16
    FMOV  V11.D[1], X9
    FMOV  D12, X21
    FMOV  V12.D[1], X17
    FMOV  D13, X23
    FMOV  V13.D[1], X17
    FMOV  D14, X12
    FMOV  V14.D[1], X2
    FMOV  D15, X23
    FMOV  V15.D[1], X14
    FMOV  D16, X14
    FMOV  V16.D[1], X6
    FMOV  D17, X13
    FMOV  V17.D[1], X15
    FMOV  D18, X10
    FMOV  V18.D[1], X29
    FMOV  D19, X11
    FMOV  V19.D[1], X10
    FMOV  D20, X29
    FMOV  V20.D[1], X10
    FMOV  D21, X23
    FMOV  V21.D[1], X18
    FMOV  D22, X26
    FMOV  V22.D[1], X12
    FMOV  D23, X21
    FMOV  V23.D[1], X11
    FMOV  D24, X15
    FMOV  V24.D[1], X17
    FMOV  D25, X2
    FMOV  V25.D[1], X17
    FMOV  D26, X28
    FMOV  V26.D[1], X14
    FMOV  D27, X21
    FMOV  V27.D[1], X10
    FMOV  D28, X24
    FMOV  V28.D[1], X23
    FMOV  D29, X8
    FMOV  V29.D[1], X10
    FMOV  D30, X17
    FMOV  V30.D[1], X8
    FMOV  D31, X23
    FMOV  V31.D[1], X9
    MOVZ  X12, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_3:
    SUDOT V5.4S, V21.16B, V30.4B[0x3]
    SUDOT V6.4S, V23.16B, V24.4B[0x0]
    FMLAL V23.4S, V5.4H, V7.H[0x5]
    FMLSL2 V1.2S, V31.2H, V6.2H
    SUDOT V27.2S, V26.8B, V26.4B[0x0]
    USDOT V12.4S, V1.16B, V27.16B
    USDOT V7.4S, V12.16B, V29.4B[0x3]
    FMLAL2 V17.4S, V7.4H, V7.H[0x7]
    FMLSL2 V26.4S, V17.4H, V6.H[0x0]
    FMLAL2 V18.4S, V13.4H, V18.4H
    FMLAL V24.4S, V18.4H, V28.4H
    FMLAL2 V1.2S, V24.2H, V12.H[0x2]
    FMLSL V28.2S, V13.2H, V6.2H
    FMLAL2 V18.4S, V2.4H, V4.H[0x5]
    UMMLA V17.4S, V21.16B, V1.16B
    USMMLA V5.4S, V30.16B, V28.16B
    FMLSL V27.4S, V17.4H, V5.H[0x6]
    FMLSL2 V18.2S, V10.2H, V5.H[0x4]
    USDOT V29.4S, V23.16B, V12.4B[0x0]
    SMMLA V6.4S, V26.16B, V27.16B
    FMLSL V2.4S, V29.4H, V7.H[0x0]
    USDOT V12.4S, V2.16B, V18.16B
    SUDOT V5.4S, V27.16B, V14.4B[0x3]
    SMMLA V10.4S, V26.16B, V7.16B
    FMLSL V7.4S, V0.4H, V20.4H
    USDOT V4.4S, V3.16B, V17.16B
    FMLAL2 V3.4S, V17.4H, V25.4H
    UMMLA V31.4S, V2.16B, V24.16B
    FMLSL2 V14.2S, V8.2H, V14.H[0x3]
    SMMLA V0.4S, V7.16B, V2.16B
    SUDOT V27.2S, V6.8B, V0.4B[0x0]
    SUDOT V28.4S, V12.16B, V31.4B[0x0]
    FMLAL V17.4S, V25.4H, V14.H[0x7]
    SUDOT V14.4S, V17.16B, V3.4B[0x2]
    FMLAL V23.4S, V14.4H, V14.H[0x4]
    FMLAL V8.4S, V17.4H, V9.4H
    FMLSL V20.2S, V10.2H, V10.H[0x2]
    FMLSL V25.2S, V28.2H, V1.2H
    UMMLA V26.4S, V14.16B, V2.16B
    SUDOT V30.2S, V23.8B, V25.4B[0x0]
    FMLAL2 V6.4S, V20.4H, V0.4H
    FMLSL2 V14.2S, V27.2H, V11.H[0x7]
    FMLAL2 V29.4S, V8.4H, V10.H[0x6]
    USDOT V29.2S, V2.8B, V6.8B
    FMLAL V11.2S, V29.2H, V22.2H
    USDOT V9.2S, V13.8B, V26.8B
    USDOT V1.4S, V19.16B, V1.16B
    FMLSL V25.2S, V6.2H, V9.H[0x3]
    FMLAL V2.4S, V5.4H, V14.4H
    FMLAL2 V24.2S, V30.2H, V30.2H
    FMLAL V18.2S, V24.2H, V11.2H
    FMLSL V12.4S, V25.4H, V25.4H
    USDOT V6.2S, V21.8B, V12.8B
    FMLAL V9.2S, V6.2H, V1.2H
    USDOT V30.4S, V18.16B, V26.4B[0x1]
    FMLAL2 V31.2S, V3.2H, V9.2H
    FMLSL2 V8.2S, V2.2H, V2.H[0x4]
    FMLAL2 V11.4S, V31.4H, V1.H[0x2]
    USDOT V24.4S, V11.16B, V12.4B[0x2]
    USDOT V22.4S, V24.16B, V30.4B[0x2]
    USDOT V6.2S, V13.8B, V21.4B[0x1]
    FMLAL2 V5.4S, V29.4H, V26.4H
    FMLSL V30.2S, V3.2H, V15.2H
    UMMLA V9.4S, V28.16B, V10.16B
    FMLAL2 V16.4S, V18.4H, V2.4H
    USDOT V1.2S, V8.8B, V10.8B
    USDOT V24.2S, V9.8B, V10.8B
    FMLSL2 V24.4S, V30.4H, V7.H[0x5]
    SMMLA V4.4S, V12.16B, V3.16B
    FMLSL2 V31.4S, V5.4H, V3.4H
    SUDOT V5.2S, V18.8B, V19.4B[0x1]
    UMMLA V29.4S, V27.16B, V28.16B
    SUDOT V28.2S, V16.8B, V22.4B[0x0]
    UMMLA V11.4S, V22.16B, V28.16B
    FMLSL V28.4S, V4.4H, V1.H[0x6]
    UMMLA V19.4S, V25.16B, V23.16B
    FMLSL2 V10.2S, V16.2H, V5.H[0x4]
    USDOT V14.2S, V6.8B, V6.4B[0x0]
    FMLSL V9.2S, V31.2H, V31.2H
    FMLSL V4.4S, V24.4H, V4.H[0x4]
    SUDOT V12.4S, V1.16B, V19.4B[0x1]
    SUDOT V24.2S, V10.8B, V28.4B[0x3]
    FMLSL V19.4S, V4.4H, V10.4H
    FMLAL V31.2S, V24.2H, V6.H[0x1]
    USMMLA V8.4S, V6.16B, V29.16B
    UMMLA V21.4S, V2.16B, V19.16B
    FMLSL V4.2S, V14.2H, V3.H[0x6]
    FMLSL V19.4S, V5.4H, V3.4H
    USDOT V18.2S, V31.8B, V21.4B[0x1]
    FMLSL V6.4S, V25.4H, V1.H[0x2]
    FMLSL2 V28.4S, V30.4H, V25.4H
    FMLAL2 V23.4S, V3.4H, V8.4H
    FMLSL2 V27.4S, V19.4H, V9.4H
    UMMLA V16.4S, V24.16B, V12.16B
    FMLSL2 V21.4S, V3.4H, V11.H[0x0]
    USMMLA V25.4S, V14.16B, V30.16B
    SUDOT V27.2S, V27.8B, V27.4B[0x0]
    FMLSL V12.4S, V25.4H, V26.4H
    USDOT V25.4S, V6.16B, V22.16B
    FMLAL V26.2S, V25.2H, V12.H[0x0]
    FMLSL V6.2S, V27.2H, V5.H[0x7]
    USDOT V29.4S, V18.16B, V30.16B
    UMMLA V14.4S, V26.16B, V18.16B
    USMMLA V24.4S, V3.16B, V16.16B
    SUDOT V28.2S, V3.8B, V29.4B[0x3]
    FMLAL2 V2.2S, V23.2H, V6.2H
    FMLSL2 V23.2S, V14.2H, V4.H[0x1]
    FMLSL V11.4S, V28.4H, V5.H[0x7]
    USDOT V4.4S, V19.16B, V14.16B
    FMLSL V14.2S, V2.2H, V11.H[0x6]
    FMLSL2 V31.2S, V22.2H, V2.H[0x1]
    SUDOT V28.2S, V31.8B, V29.4B[0x0]
    FMLSL2 V22.2S, V12.2H, V14.H[0x0]
    FMLSL V2.2S, V4.2H, V4.H[0x3]
    SUDOT V5.4S, V28.16B, V28.4B[0x3]
    FMLAL2 V6.2S, V2.2H, V2.H[0x1]
    UMMLA V14.4S, V21.16B, V5.16B
    FMLSL2 V16.4S, V22.4H, V10.H[0x4]
    FMLSL V4.4S, V20.4H, V5.H[0x7]
    FMLSL2 V21.2S, V12.2H, V14.2H
    SMMLA V30.4S, V23.16B, V23.16B
    FMLAL V22.2S, V10.2H, V9.H[0x4]
    USDOT V11.2S, V22.8B, V6.4B[0x2]
    SUDOT V28.4S, V30.16B, V21.4B[0x2]
    SMMLA V6.4S, V4.16B, V29.16B
    USDOT V3.2S, V19.8B, V19.8B
    USDOT V2.2S, V5.8B, V26.4B[0x2]
    FMLSL2 V20.4S, V31.4H, V12.H[0x4]
    FMLAL V12.4S, V11.4H, V6.H[0x3]
    SUDOT V18.4S, V3.16B, V12.4B[0x3]
    SUDOT V18.2S, V16.8B, V16.4B[0x1]
    USDOT V22.4S, V20.16B, V10.16B
    FMLSL2 V4.4S, V2.4H, V2.H[0x1]
    FMLAL V2.4S, V22.4H, V1.H[0x0]
    USDOT V12.2S, V18.8B, V2.4B[0x2]
    USDOT V9.2S, V5.8B, V4.8B
    SUDOT V22.2S, V2.8B, V12.4B[0x0]
    UMMLA V23.4S, V26.16B, V22.16B
    USDOT V10.2S, V17.8B, V16.4B[0x0]
    FMLSL V31.2S, V3.2H, V9.H[0x3]
    USDOT V22.4S, V14.16B, V31.4B[0x1]
    FMLSL V12.2S, V28.2H, V18.2H
    FMLSL2 V11.4S, V23.4H, V8.H[0x7]
    UMMLA V17.4S, V12.16B, V9.16B
    USDOT V20.4S, V29.16B, V17.4B[0x3]
    USDOT V29.4S, V10.16B, V22.4B[0x3]
    USDOT V3.2S, V20.8B, V29.4B[0x0]
    FMLAL V18.2S, V31.2H, V14.H[0x5]
    FMLSL2 V13.2S, V12.2H, V19.2H
    FMLAL V5.4S, V6.4H, V14.H[0x6]
    USDOT V11.2S, V25.8B, V6.8B
    FMLSL V7.2S, V15.2H, V1.H[0x4]
    USMMLA V2.4S, V8.16B, V16.16B
    SUDOT V26.2S, V29.8B, V14.4B[0x3]
    UMMLA V4.4S, V31.16B, V2.16B
    SUDOT V7.4S, V5.16B, V20.4B[0x0]
    SUDOT V14.4S, V0.16B, V1.4B[0x3]
    FMLAL V8.4S, V5.4H, V1.H[0x2]
    FMLSL2 V20.4S, V18.4H, V7.4H
    USDOT V9.2S, V20.8B, V11.8B
    FMLAL2 V10.4S, V24.4H, V9.H[0x2]
    USDOT V23.2S, V10.8B, V4.4B[0x2]
    SUDOT V19.4S, V8.16B, V13.4B[0x1]
    SMMLA V2.4S, V26.16B, V14.16B
    FMLAL2 V4.2S, V23.2H, V3.H[0x0]
    FMLSL V8.2S, V19.2H, V30.2H
    USDOT V15.4S, V4.16B, V2.4B[0x2]
    FMLSL2 V14.2S, V5.2H, V16.2H
    USDOT V3.4S, V4.16B, V22.16B
    SUDOT V7.2S, V13.8B, V13.4B[0x3]
    SMMLA V6.4S, V9.16B, V10.16B
    USDOT V1.2S, V1.8B, V12.8B
    SMMLA V19.4S, V12.16B, V27.16B
    FMLAL2 V9.2S, V21.2H, V27.2H
    SUDOT V30.2S, V3.8B, V8.4B[0x0]
    USMMLA V24.4S, V9.16B, V28.16B
    FMLSL V27.4S, V19.4H, V30.4H
    USMMLA V11.4S, V1.16B, V15.16B
    FMLAL V10.4S, V6.4H, V11.H[0x7]
    UMMLA V19.4S, V14.16B, V25.16B
    SUDOT V14.4S, V10.16B, V6.4B[0x1]
    FMLAL V16.4S, V24.4H, V5.4H
    FMLAL V26.4S, V27.4H, V19.4H
    FMLSL V23.2S, V18.2H, V10.H[0x4]
    SMMLA V8.4S, V26.16B, V22.16B
    FMLSL V11.4S, V4.4H, V18.4H
    SUDOT V21.4S, V14.16B, V23.4B[0x3]
    USDOT V31.4S, V1.16B, V3.4B[0x2]
    USDOT V15.2S, V11.8B, V8.8B
    USDOT V4.2S, V16.8B, V21.4B[0x3]
    UMMLA V10.4S, V13.16B, V31.16B
    SUDOT V19.4S, V10.16B, V10.4B[0x2]
    FMLSL2 V18.4S, V18.4H, V27.4H
    FMLAL V25.2S, V7.2H, V7.H[0x4]
    SMMLA V24.4S, V19.16B, V15.16B
    USMMLA V16.4S, V18.16B, V25.16B
    FMLAL V14.2S, V0.2H, V4.H[0x2]
    FMLAL2 V11.2S, V24.2H, V20.2H
    FMLAL2 V3.2S, V16.2H, V19.2H
    FMLSL V5.2S, V24.2H, V14.2H
    SUBS  X12, X12, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_3
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X26, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X14, FPSR
    MOVZ  X26, #0x91, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X26, #0x6de0, LSL #0
    MOVK  X26, #0x5a59, LSL #16
    MOVK  X26, #0xc61, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D0
    MOVZ  X26, #0x8a22, LSL #0
    MOVK  X26, #0x5a5d, LSL #16
    MOVK  X26, #0x487a, LSL #32
    MOVK  X26, #0x5a5c, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D1
    MOVZ  X26, #0x4a72, LSL #0
    MOVK  X26, #0x4a8a, LSL #16
    MOVK  X26, #0x8756, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X26, #0x5b58, LSL #0
    MOVK  X26, #0x4530, LSL #16
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D2
    MOVZ  X26, #0x4af9, LSL #0
    MOVK  X26, #0xfff3, LSL #16
    MOVK  X26, #0x7a1a, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D3
    MOVZ  X26, #0x5971, LSL #0
    MOVK  X26, #0x5a5d, LSL #16
    MOVK  X26, #0xd59e, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D4
    MOVZ  X26, #0xaa33, LSL #0
    MOVK  X26, #0xffce, LSL #16
    MOVK  X26, #0x3974, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D5
    MOVZ  X26, #0xd317, LSL #0
    MOVK  X26, #0xcb53, LSL #16
    MOVK  X26, #0xc000, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D6
    MOVZ  X26, #0x5a1f, LSL #0
    MOVK  X26, #0xfffe, LSL #16
    MOVK  X26, #0x4e55, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D7
    MOVZ  X26, #0xfd79, LSL #0
    MOVK  X26, #0x7fca, LSL #16
    MOVK  X26, #0x6f1, LSL #32
    MOVK  X26, #0x7ffb, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X26, #0x3e62, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D8
    MOVZ  X26, #0x30ac, LSL #0
    MOVK  X26, #0x7fc9, LSL #16
    MOVK  X26, #0x7c53, LSL #32
    MOVK  X26, #0x7ff8, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D9
    MOVZ  X26, #0x19ea, LSL #0
    MOVK  X26, #0x7fe3, LSL #16
    MOVK  X26, #0x1f87, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X26, #0xf238, LSL #0
    MOVK  X26, #0xc0c3, LSL #16
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D10
    MOVZ  X26, #0xceef, LSL #0
    MOVK  X26, #0x5a7a, LSL #16
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D11
    MOVZ  X26, #0x99a6, LSL #0
    MOVK  X26, #0x7fd1, LSL #16
    MOVK  X26, #0x3fa5, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D12
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x7fed, LSL #16
    MOVK  X26, #0xdf9a, LSL #32
    MOVK  X26, #0xfffd, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D14
    MOVZ  X26, #0xe339, LSL #0
    MOVK  X26, #0xffe6, LSL #16
    MOVK  X26, #0x8aa, LSL #32
    MOVK  X26, #0x7ffe, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D15
    MOVZ  X26, #0xe6b6, LSL #0
    MOVK  X26, #0x5a5d, LSL #16
    MOVK  X26, #0xf98, LSL #32
    MOVK  X26, #0x5a5f, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X26, #0x2744, LSL #0
    MOVK  X26, #0xffdc, LSL #16
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D16
    MOVZ  X26, #0x6bec, LSL #0
    MOVK  X26, #0x7fdf, LSL #16
    MOVK  X26, #0x8000, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X26, #0x577a, LSL #0
    MOVK  X26, #0x5a5b, LSL #16
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D17
    MOVZ  X26, #0xfa5d, LSL #0
    MOVK  X26, #0x5a9a, LSL #16
    MOVK  X26, #0x6000, LSL #32
    MOVK  X26, #0x7ffb, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D18
    MOVZ  X26, #0x30ec, LSL #0
    MOVK  X26, #0x7fc0, LSL #16
    MOVK  X26, #0xe2e4, LSL #32
    MOVK  X26, #0xfffb, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X26, #0xb9b2, LSL #0
    MOVK  X26, #0x5a5b, LSL #16
    MOVK  X26, #0x64be, LSL #32
    MOVK  X26, #0xfffe, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D19
    MOVZ  X26, #0x6bd8, LSL #0
    MOVK  X26, #0xe394, LSL #32
    MOVK  X26, #0xc561, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D20
    MOVZ  X26, #0x8f42, LSL #0
    MOVK  X26, #0x7fe4, LSL #16
    MOVK  X26, #0x4327, LSL #32
    MOVK  X26, #0x4a4f, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D21
    MOVZ  X26, #0xb842, LSL #0
    MOVK  X26, #0xfff3, LSL #16
    MOVK  X26, #0x8000, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X26, #0xeb40, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D22
    MOVZ  X26, #0xc63, LSL #0
    MOVK  X26, #0xffe9, LSL #16
    MOVK  X26, #0xfb1e, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D23
    MOVZ  X26, #0xaca9, LSL #0
    MOVK  X26, #0x7fed, LSL #16
    MOVK  X26, #0x1365, LSL #32
    MOVK  X26, #0xfff9, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X26, #0xe827, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xe282, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D24
    MOVZ  X26, #0xf355, LSL #0
    MOVK  X26, #0x8000, LSL #16
    MOVK  X26, #0x96dc, LSL #32
    MOVK  X26, #0x7ff7, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D25
    MOVZ  X26, #0x2000, LSL #0
    MOVK  X26, #0xffef, LSL #16
    MOVK  X26, #0xd581, LSL #32
    MOVK  X26, #0xfffe, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x2000, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D26
    MOVZ  X26, #0xc000, LSL #0
    MOVK  X26, #0xffcc, LSL #16
    MOVK  X26, #0x1f3, LSL #32
    MOVK  X26, #0x7ffe, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X26, #0x1e4, LSL #0
    MOVK  X26, #0x428d, LSL #16
    MOVK  X26, #0xb60c, LSL #32
    MOVK  X26, #0x4488, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D27
    MOVZ  X26, #0x9627, LSL #0
    MOVK  X26, #0x5a5c, LSL #16
    MOVK  X26, #0x337e, LSL #32
    MOVK  X26, #0x7ff9, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D28
    MOVZ  X26, #0xfd68, LSL #0
    MOVK  X26, #0x5a5c, LSL #16
    MOVK  X26, #0x12eb, LSL #32
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D29
    MOVZ  X26, #0xcabb, LSL #0
    MOVK  X26, #0x5a7b, LSL #16
    MOVK  X26, #0x6458, LSL #32
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D30
    MOVZ  X26, #0x8bb3, LSL #0
    MOVK  X26, #0x5a67, LSL #16
    MOVK  X26, #0x20eb, LSL #32
    MOVK  X26, #0x5a5d, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X14, D31
    MOVZ  X26, #0x6dbd, LSL #0
    MOVK  X26, #0x7ff8, LSL #16
    MOVK  X26, #0xe000, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X20
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X24
    FMOV  D4, X10
    FMOV  V4.D[1], X23
    FMOV  D5, X23
    FMOV  V5.D[1], X11
    FMOV  D6, X20
    FMOV  V6.D[1], X26
    FMOV  D7, X21
    FMOV  V7.D[1], X16
    FMOV  D8, X6
    FMOV  V8.D[1], X6
    FMOV  D9, X13
    FMOV  V9.D[1], X23
    FMOV  D10, X12
    FMOV  V10.D[1], X22
    FMOV  D11, X14
    FMOV  V11.D[1], X21
    FMOV  D12, X3
    FMOV  V12.D[1], X27
    FMOV  D13, X10
    FMOV  V13.D[1], X14
    FMOV  D14, X16
    FMOV  V14.D[1], X19
    FMOV  D15, X12
    FMOV  V15.D[1], X21
    FMOV  D16, X22
    FMOV  V16.D[1], X20
    FMOV  D17, X20
    FMOV  V17.D[1], X3
    FMOV  D18, X29
    FMOV  V18.D[1], X22
    FMOV  D19, X17
    FMOV  V19.D[1], X10
    FMOV  D20, X13
    FMOV  V20.D[1], X8
    FMOV  D21, X26
    FMOV  V21.D[1], X10
    FMOV  D22, X27
    FMOV  V22.D[1], X11
    FMOV  D23, X28
    FMOV  V23.D[1], X17
    FMOV  D24, X26
    FMOV  V24.D[1], X10
    FMOV  D25, X21
    FMOV  V25.D[1], X24
    FMOV  D26, X27
    FMOV  V26.D[1], X24
    FMOV  D27, X24
    FMOV  V27.D[1], X27
    FMOV  D28, X29
    FMOV  V28.D[1], X6
    FMOV  D29, X15
    FMOV  V29.D[1], X16
    FMOV  D30, X28
    FMOV  V30.D[1], X26
    FMOV  D31, X22
    FMOV  V31.D[1], X12
    MOVZ  X27, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_4:
    SMMLA V12.4S, V15.16B, V4.16B
    FMLAL V20.2S, V12.2H, V23.2H
    USDOT V24.4S, V31.16B, V26.4B[0x0]
    SUDOT V2.4S, V28.16B, V29.4B[0x0]
    FMLAL V24.2S, V18.2H, V12.2H
    UMMLA V5.4S, V16.16B, V6.16B
    SUDOT V2.4S, V16.16B, V30.4B[0x1]
    SMMLA V10.4S, V27.16B, V21.16B
    SMMLA V18.4S, V0.16B, V10.16B
    FMLSL2 V27.4S, V31.4H, V5.H[0x3]
    FMLSL V10.4S, V20.4H, V2.H[0x7]
    UMMLA V0.4S, V10.16B, V27.16B
    FMLAL V6.2S, V30.2H, V0.H[0x7]
    FMLAL V21.2S, V24.2H, V15.H[0x5]
    USDOT V12.4S, V21.16B, V3.4B[0x1]
    FMLAL2 V28.4S, V25.4H, V6.4H
    USDOT V9.4S, V28.16B, V12.16B
    SUDOT V31.2S, V9.8B, V24.4B[0x3]
    USDOT V7.4S, V7.16B, V7.16B
    FMLSL2 V19.2S, V5.2H, V10.2H
    FMLAL2 V24.2S, V13.2H, V2.2H
    FMLSL V29.4S, V23.4H, V11.H[0x3]
    USDOT V14.2S, V11.8B, V21.8B
    FMLAL2 V26.2S, V21.2H, V12.H[0x4]
    FMLAL V28.2S, V5.2H, V3.H[0x3]
    FMLSL V11.4S, V23.4H, V14.H[0x1]
    USDOT V4.4S, V11.16B, V18.16B
    UMMLA V20.4S, V28.16B, V24.16B
    UMMLA V9.4S, V26.16B, V20.16B
    UMMLA V27.4S, V7.16B, V12.16B
    FMLAL V26.4S, V31.4H, V12.H[0x4]
    FMLSL V16.4S, V19.4H, V25.4H
    SUDOT V19.2S, V22.8B, V28.4B[0x3]
    FMLSL2 V25.4S, V13.4H, V7.H[0x6]
    SUDOT V3.2S, V4.8B, V29.4B[0x0]
    USDOT V29.2S, V31.8B, V8.8B
    FMLAL2 V6.2S, V14.2H, V12.H[0x7]
    FMLAL2 V18.2S, V3.2H, V2.H[0x5]
    USDOT V21.2S, V24.8B, V23.4B[0x3]
    USDOT V14.4S, V27.16B, V19.4B[0x2]
    SUDOT V20.2S, V21.8B, V25.4B[0x1]
    USDOT V27.2S, V14.8B, V26.4B[0x0]
    SUDOT V15.4S, V11.16B, V27.4B[0x1]
    FMLAL V13.4S, V9.4H, V30.4H
    FMLAL2 V28.4S, V29.4H, V13.H[0x2]
    FMLAL V4.2S, V28.2H, V15.H[0x1]
    FMLAL2 V2.4S, V8.4H, V13.H[0x2]
    FMLAL2 V10.2S, V20.2H, V0.H[0x3]
    FMLSL2 V16.4S, V2.4H, V2.4H
    FMLSL2 V29.2S, V13.2H, V10.H[0x0]
    USDOT V5.2S, V25.8B, V29.4B[0x1]
    USDOT V12.4S, V5.16B, V18.4B[0x3]
    SMMLA V4.4S, V12.16B, V6.16B
    SUDOT V3.4S, V26.16B, V10.4B[0x0]
    FMLSL V8.2S, V20.2H, V2.2H
    USDOT V12.4S, V11.16B, V6.16B
    SMMLA V19.4S, V26.16B, V3.16B
    FMLSL2 V3.2S, V0.2H, V7.H[0x6]
    FMLSL2 V31.2S, V3.2H, V22.2H
    SUDOT V15.4S, V6.16B, V3.4B[0x3]
    FMLSL2 V27.4S, V15.4H, V3.H[0x2]
    UMMLA V25.4S, V22.16B, V9.16B
    FMLSL V26.4S, V0.4H, V12.4H
    USDOT V27.2S, V24.8B, V5.8B
    USDOT V13.4S, V1.16B, V2.16B
    USDOT V3.4S, V8.16B, V8.4B[0x2]
    FMLSL2 V6.2S, V3.2H, V11.H[0x4]
    USDOT V20.2S, V10.8B, V26.4B[0x2]
    FMLSL V18.2S, V6.2H, V4.H[0x1]
    USDOT V11.2S, V13.8B, V15.8B
    FMLSL2 V20.2S, V25.2H, V11.H[0x1]
    FMLAL2 V7.2S, V21.2H, V31.2H
    FMLAL V8.4S, V5.4H, V7.H[0x4]
    USDOT V5.4S, V27.16B, V19.16B
    FMLSL2 V24.4S, V11.4H, V5.H[0x6]
    FMLSL2 V25.2S, V6.2H, V8.H[0x0]
    USDOT V12.2S, V20.8B, V13.4B[0x0]
    FMLAL V7.4S, V17.4H, V18.4H
    FMLSL2 V30.4S, V25.4H, V9.H[0x6]
    FMLAL2 V3.2S, V12.2H, V6.2H
    FMLAL2 V23.2S, V24.2H, V14.H[0x4]
    FMLAL V10.2S, V3.2H, V1.H[0x1]
    UMMLA V31.4S, V10.16B, V14.16B
    USMMLA V25.4S, V7.16B, V30.16B
    FMLAL V26.4S, V25.4H, V23.4H
    UMMLA V30.4S, V20.16B, V30.16B
    FMLAL V14.2S, V4.2H, V24.2H
    FMLSL2 V5.2S, V24.2H, V10.H[0x7]
    FMLAL2 V2.4S, V4.4H, V26.4H
    FMLSL2 V6.4S, V7.4H, V3.H[0x4]
    SMMLA V13.4S, V9.16B, V10.16B
    FMLSL2 V25.2S, V5.2H, V24.2H
    USDOT V11.4S, V17.16B, V19.16B
    FMLAL V19.4S, V21.4H, V15.H[0x4]
    USDOT V10.2S, V19.8B, V31.8B
    FMLSL2 V18.4S, V10.4H, V10.H[0x4]
    FMLSL V24.4S, V11.4H, V29.4H
    USMMLA V23.4S, V13.16B, V14.16B
    SUDOT V12.4S, V30.16B, V13.4B[0x3]
    FMLSL V4.2S, V24.2H, V12.H[0x1]
    FMLSL2 V13.2S, V19.2H, V2.H[0x6]
    SUDOT V15.4S, V10.16B, V27.4B[0x0]
    FMLSL V29.4S, V9.4H, V13.4H
    FMLAL2 V21.2S, V23.2H, V23.2H
    SUDOT V31.4S, V4.16B, V26.4B[0x0]
    FMLAL V24.2S, V18.2H, V4.H[0x5]
    FMLSL2 V27.2S, V19.2H, V14.H[0x4]
    FMLSL V13.2S, V21.2H, V6.H[0x3]
    FMLAL V5.4S, V4.4H, V13.H[0x6]
    UMMLA V13.4S, V30.16B, V3.16B
    FMLAL V4.4S, V27.4H, V29.4H
    FMLSL V18.2S, V3.2H, V23.2H
    FMLSL V29.4S, V18.4H, V5.H[0x2]
    FMLSL2 V2.4S, V15.4H, V4.H[0x4]
    USDOT V23.2S, V13.8B, V24.4B[0x2]
    USMMLA V27.4S, V28.16B, V23.16B
    USDOT V30.4S, V3.16B, V10.4B[0x2]
    FMLAL2 V24.4S, V31.4H, V25.4H
    USDOT V9.2S, V29.8B, V13.8B
    FMLSL2 V14.2S, V2.2H, V5.H[0x4]
    FMLAL V4.2S, V24.2H, V5.H[0x3]
    UMMLA V13.4S, V7.16B, V8.16B
    SMMLA V18.4S, V13.16B, V27.16B
    FMLSL2 V15.4S, V4.4H, V5.H[0x5]
    FMLSL2 V13.2S, V18.2H, V15.2H
    SUDOT V3.4S, V30.16B, V0.4B[0x2]
    USDOT V19.2S, V8.8B, V9.8B
    FMLAL2 V31.2S, V13.2H, V14.2H
    FMLAL2 V14.2S, V19.2H, V19.2H
    UMMLA V12.4S, V31.16B, V31.16B
    SUDOT V15.4S, V3.16B, V12.4B[0x1]
    FMLAL V2.4S, V27.4H, V24.4H
    USDOT V0.4S, V22.16B, V4.4B[0x3]
    USDOT V23.4S, V25.16B, V5.16B
    FMLAL V24.4S, V2.4H, V8.H[0x5]
    USDOT V13.4S, V10.16B, V18.4B[0x2]
    USDOT V30.4S, V13.16B, V26.16B
    SUDOT V9.4S, V2.16B, V16.4B[0x3]
    FMLAL V16.4S, V8.4H, V3.4H
    UMMLA V26.4S, V21.16B, V30.16B
    FMLSL V13.4S, V16.4H, V9.4H
    USMMLA V21.4S, V17.16B, V31.16B
    SUDOT V22.4S, V24.16B, V3.4B[0x1]
    FMLSL2 V12.2S, V11.2H, V2.2H
    FMLAL2 V3.4S, V0.4H, V23.4H
    USDOT V2.4S, V7.16B, V12.16B
    FMLAL V16.4S, V13.4H, V7.H[0x1]
    UMMLA V27.4S, V29.16B, V22.16B
    FMLSL V23.2S, V14.2H, V14.H[0x4]
    SUDOT V19.4S, V21.16B, V15.4B[0x1]
    USMMLA V12.4S, V23.16B, V3.16B
    FMLAL V21.2S, V2.2H, V2.H[0x0]
    USDOT V31.4S, V12.16B, V8.16B
    FMLAL V13.2S, V16.2H, V4.2H
    FMLAL2 V30.4S, V6.4H, V13.H[0x1]
    USDOT V22.4S, V26.16B, V27.16B
    FMLSL V6.4S, V8.4H, V31.4H
    USDOT V23.4S, V29.16B, V20.4B[0x3]
    SMMLA V20.4S, V22.16B, V5.16B
    FMLSL V3.2S, V23.2H, V6.H[0x4]
    USMMLA V13.4S, V21.16B, V19.16B
    UMMLA V7.4S, V4.16B, V8.16B
    FMLSL V14.4S, V12.4H, V20.4H
    SUDOT V11.4S, V7.16B, V19.4B[0x2]
    SUDOT V21.2S, V13.8B, V30.4B[0x2]
    FMLAL V12.4S, V6.4H, V21.4H
    USDOT V29.2S, V3.8B, V15.4B[0x1]
    FMLSL V6.4S, V28.4H, V11.H[0x4]
    USMMLA V23.4S, V14.16B, V12.16B
    USDOT V12.2S, V22.8B, V11.8B
    USDOT V5.4S, V12.16B, V23.16B
    FMLAL V26.2S, V6.2H, V29.2H
    SMMLA V20.4S, V20.16B, V28.16B
    USDOT V4.2S, V6.8B, V0.8B
    USDOT V22.2S, V1.8B, V0.4B[0x1]
    USDOT V30.2S, V20.8B, V2.4B[0x2]
    FMLAL2 V27.2S, V8.2H, V5.H[0x1]
    FMLSL V23.4S, V6.4H, V3.H[0x6]
    USMMLA V14.4S, V6.16B, V17.16B
    USDOT V15.4S, V3.16B, V14.4B[0x3]
    FMLAL2 V17.2S, V27.2H, V12.H[0x5]
    FMLSL V15.2S, V0.2H, V8.2H
    USDOT V0.2S, V20.8B, V9.4B[0x0]
    USDOT V11.2S, V17.8B, V27.8B
    USDOT V29.4S, V3.16B, V10.16B
    USDOT V5.2S, V23.8B, V9.8B
    USMMLA V2.4S, V5.16B, V26.16B
    USDOT V7.2S, V24.8B, V2.4B[0x0]
    FMLAL2 V9.4S, V15.4H, V4.H[0x6]
    FMLSL2 V27.4S, V9.4H, V7.H[0x1]
    USDOT V5.4S, V15.16B, V29.16B
    FMLSL V6.2S, V24.2H, V13.H[0x5]
    SUDOT V8.4S, V30.16B, V0.4B[0x1]
    UMMLA V4.4S, V22.16B, V24.16B
    USDOT V29.4S, V5.16B, V11.16B
    FMLSL V11.2S, V27.2H, V27.2H
    USDOT V5.2S, V13.8B, V29.4B[0x2]
    USDOT V22.4S, V10.16B, V5.16B
    FMLSL V23.2S, V11.2H, V6.H[0x7]
    FMLSL2 V12.2S, V4.2H, V8.H[0x4]
    SUBS  X27, X27, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_4
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X29, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X15, FPSR
    MOVZ  X29, #0x91, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D0
    MOVZ  X29, #0xe17a, LSL #0
    MOVK  X29, #0xa5c4, LSL #16
    MOVK  X29, #0xc3df, LSL #32
    MOVK  X29, #0xa5bf, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X29, #0xbf8a, LSL #0
    MOVK  X29, #0xfffd, LSL #16
    MOVK  X29, #0x7473, LSL #32
    MOVK  X29, #0x7ffe, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D2
    MOVZ  X29, #0x4dec, LSL #0
    MOVK  X29, #0xfff3, LSL #16
    MOVK  X29, #0x5547, LSL #32
    MOVK  X29, #0x7ff9, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D3
    MOVZ  X29, #0x6800, LSL #0
    MOVK  X29, #0xffe6, LSL #16
    MOVK  X29, #0xad57, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D4
    MOVZ  X29, #0x87b4, LSL #0
    MOVK  X29, #0xaa91, LSL #32
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D5
    MOVZ  X29, #0x3ddf, LSL #0
    MOVK  X29, #0xa5bd, LSL #16
    MOVK  X29, #0x12a3, LSL #32
    MOVK  X29, #0xfff8, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D6
    MOVZ  X29, #0xe000, LSL #0
    MOVK  X29, #0x7fd1, LSL #16
    MOVK  X29, #0xa000, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D7
    MOVZ  X29, #0x76a9, LSL #0
    MOVK  X29, #0x4b9b, LSL #16
    MOVK  X29, #0x70fd, LSL #32
    MOVK  X29, #0x8001, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D8
    MOVZ  X29, #0xa4fd, LSL #0
    MOVK  X29, #0x7fd9, LSL #16
    MOVK  X29, #0xba4, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X29, #0xd364, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D9
    MOVZ  X29, #0xb78b, LSL #0
    MOVK  X29, #0xa5b8, LSL #16
    MOVK  X29, #0xe7a2, LSL #32
    MOVK  X29, #0xa5ac, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D10
    MOVZ  X29, #0x7483, LSL #0
    MOVK  X29, #0xffe9, LSL #16
    MOVK  X29, #0x4f48, LSL #32
    MOVK  X29, #0x8000, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D11
    MOVZ  X29, #0xa828, LSL #0
    MOVK  X29, #0xfff7, LSL #16
    MOVK  X29, #0xf672, LSL #32
    MOVK  X29, #0xfffd, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D12
    MOVZ  X29, #0x3c6b, LSL #0
    MOVK  X29, #0x4b89, LSL #16
    MOVK  X29, #0xbddd, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D13
    MOVZ  X29, #0x15c7, LSL #0
    MOVK  X29, #0xffea, LSL #16
    MOVK  X29, #0xb4ac, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X29, #0x63a3, LSL #0
    MOVK  X29, #0xb940, LSL #16
    MOVK  X29, #0xe000, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D14
    MOVZ  X29, #0x87c5, LSL #0
    MOVK  X29, #0xffe2, LSL #16
    MOVK  X29, #0x701e, LSL #32
    MOVK  X29, #0x7ffe, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D15
    MOVZ  X29, #0x722c, LSL #0
    MOVK  X29, #0xc988, LSL #16
    MOVK  X29, #0x70a4, LSL #32
    MOVK  X29, #0x7ffa, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X29, #0x6000, LSL #0
    MOVK  X29, #0x7ff6, LSL #16
    MOVK  X29, #0xa000, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D16
    MOVZ  X29, #0x2000, LSL #0
    MOVK  X29, #0xfffe, LSL #16
    MOVK  X29, #0xa000, LSL #32
    MOVK  X29, #0x7ffa, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D17
    MOVZ  X29, #0xe000, LSL #0
    MOVK  X29, #0xfffd, LSL #16
    MOVK  X29, #0xe000, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X29, #0xd498, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D18
    MOVZ  X29, #0x737f, LSL #0
    MOVK  X29, #0xfffd, LSL #16
    MOVK  X29, #0xc000, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D19
    MOVZ  X29, #0x3a5, LSL #0
    MOVK  X29, #0x4ce8, LSL #16
    MOVK  X29, #0x6c0b, LSL #32
    MOVK  X29, #0x7ffc, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X29, #0xfc98, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xf9a0, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D20
    MOVZ  X29, #0x4c60, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0x8601, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D21
    MOVZ  X29, #0xa15f, LSL #0
    MOVK  X29, #0x7ff7, LSL #16
    MOVK  X29, #0xbdcf, LSL #32
    MOVK  X29, #0x7ffb, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D22
    MOVZ  X29, #0x9c2e, LSL #0
    MOVK  X29, #0xa5a2, LSL #16
    MOVK  X29, #0x19f1, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D23
    MOVZ  X29, #0x9bde, LSL #0
    MOVK  X29, #0xffd6, LSL #16
    MOVK  X29, #0x5f83, LSL #32
    MOVK  X29, #0xfffa, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x2000, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D24
    MOVZ  X29, #0x262, LSL #0
    MOVK  X29, #0x7fd4, LSL #16
    MOVK  X29, #0xa0b0, LSL #32
    MOVK  X29, #0x7ffe, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D25
    MOVZ  X29, #0x435c, LSL #0
    MOVK  X29, #0xc89b, LSL #16
    MOVK  X29, #0xe000, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D26
    MOVZ  X29, #0x4d9e, LSL #0
    MOVK  X29, #0x4bc6, LSL #16
    MOVK  X29, #0x2000, LSL #32
    MOVK  X29, #0x7ffe, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D27
    MOVZ  X29, #0xb9dd, LSL #0
    MOVK  X29, #0x445f, LSL #16
    MOVK  X29, #0xa827, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D28
    MOVZ  X29, #0xc000, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xc000, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D29
    MOVZ  X29, #0xe176, LSL #0
    MOVK  X29, #0xffcd, LSL #16
    MOVK  X29, #0xaf0b, LSL #32
    MOVK  X29, #0xffc9, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D30
    MOVZ  X29, #0x9259, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0x2f48, LSL #32
    MOVK  X29, #0x7ffc, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D31
    MOVZ  X29, #0xf2cc, LSL #0
    MOVK  X29, #0xfffd, LSL #16
    MOVK  X29, #0x21ff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X19, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xbe9a, LSL #0
    MOVK  X2, #0xbddf, LSL #16
    MOVK  X2, #0xcfcd, LSL #32
    MOVK  X2, #0x71e0, LSL #48
    MOVZ  X3, #0x9aa3, LSL #0
    MOVK  X3, #0x85a2, LSL #16
    MOVK  X3, #0xae41, LSL #32
    MOVK  X3, #0x45aa, LSL #48
    MOVZ  X6, #0xb517, LSL #0
    MOVK  X6, #0x5f6f, LSL #16
    MOVK  X6, #0x4614, LSL #32
    MOVK  X6, #0x741d, LSL #48
    MOVZ  X8, #0x1897, LSL #0
    MOVK  X8, #0x39cb, LSL #16
    MOVK  X8, #0x8629, LSL #32
    MOVK  X8, #0x4e4c, LSL #48
    MOVZ  X9, #0xfb4d, LSL #0
    MOVK  X9, #0x1521, LSL #16
    MOVK  X9, #0xf7db, LSL #32
    MOVK  X9, #0x9112, LSL #48
    MOVZ  X10, #0x1889, LSL #0
    MOVK  X10, #0x8cbb, LSL #16
    MOVK  X10, #0x388, LSL #32
    MOVK  X10, #0xac45, LSL #48
    MOVZ  X11, #0x283c, LSL #0
    MOVK  X11, #0x6108, LSL #16
    MOVK  X11, #0xc756, LSL #32
    MOVK  X11, #0xdb87, LSL #48
    MOVZ  X12, #0xc526, LSL #0
    MOVK  X12, #0x40e9, LSL #16
    MOVK  X12, #0xe281, LSL #32
    MOVK  X12, #0x37cd, LSL #48
    MOVZ  X13, #0x7096, LSL #0
    MOVK  X13, #0xad5c, LSL #16
    MOVK  X13, #0x2608, LSL #32
    MOVK  X13, #0x67b5, LSL #48
    MOVZ  X14, #0x8e0d, LSL #0
    MOVK  X14, #0x1b06, LSL #16
    MOVK  X14, #0xb411, LSL #32
    MOVK  X14, #0xad0b, LSL #48
    MOVZ  X15, #0xe92f, LSL #0
    MOVK  X15, #0xc80e, LSL #16
    MOVK  X15, #0xa0da, LSL #32
    MOVK  X15, #0x5f88, LSL #48
    MOVZ  X16, #0x8236, LSL #0
    MOVK  X16, #0xa018, LSL #16
    MOVK  X16, #0x7575, LSL #32
    MOVK  X16, #0xee10, LSL #48
    MOVZ  X17, #0x4324, LSL #0
    MOVK  X17, #0x7dbb, LSL #16
    MOVK  X17, #0xca52, LSL #32
    MOVK  X17, #0x2944, LSL #48
    MOVZ  X18, #0x76a8, LSL #0
    MOVK  X18, #0xde42, LSL #16
    MOVK  X18, #0xf160, LSL #32
    MOVK  X18, #0x3a1a, LSL #48
    MOVZ  X19, #0xf702, LSL #0
    MOVK  X19, #0x2c68, LSL #16
    MOVK  X19, #0x2567, LSL #32
    MOVK  X19, #0x20ac, LSL #48
    MOVZ  X20, #0xb77a, LSL #0
    MOVK  X20, #0x9c1e, LSL #16
    MOVK  X20, #0x105e, LSL #32
    MOVK  X20, #0xa6fe, LSL #48
    MOVZ  X21, #0x9aaf, LSL #0
    MOVK  X21, #0x51f5, LSL #16
    MOVK  X21, #0xf276, LSL #32
    MOVK  X21, #0xcb67, LSL #48
    MOVZ  X22, #0xf62, LSL #0
    MOVK  X22, #0xb539, LSL #16
    MOVK  X22, #0xd623, LSL #32
    MOVK  X22, #0xbebf, LSL #48
    MOVZ  X23, #0x72a9, LSL #0
    MOVK  X23, #0x6830, LSL #16
    MOVK  X23, #0x6407, LSL #32
    MOVK  X23, #0xd84, LSL #48
    MOVZ  X24, #0x744e, LSL #0
    MOVK  X24, #0x7d73, LSL #16
    MOVK  X24, #0xef3a, LSL #32
    MOVK  X24, #0xebbf, LSL #48
    MOVZ  X25, #0xe781, LSL #0
    MOVK  X25, #0xcc8d, LSL #16
    MOVK  X25, #0xc256, LSL #32
    MOVK  X25, #0xa4b2, LSL #48
    MOVZ  X26, #0x62a, LSL #0
    MOVK  X26, #0x959e, LSL #16
    MOVK  X26, #0xf92f, LSL #32
    MOVK  X26, #0x44c9, LSL #48
    MOVZ  X27, #0x57a3, LSL #0
    MOVK  X27, #0xe767, LSL #16
    MOVK  X27, #0xcfb8, LSL #32
    MOVK  X27, #0x83f8, LSL #48
    MOVZ  X28, #0x5e3, LSL #0
    MOVK  X28, #0xcadb, LSL #16
    MOVK  X28, #0x72, LSL #32
    MOVK  X28, #0x4403, LSL #48
    MOVZ  X29, #0x802c, LSL #0
    MOVK  X29, #0xa94e, LSL #16
    MOVK  X29, #0x99, LSL #32
    MOVK  X29, #0xbc83, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X11
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X28
    FMOV  V3.D[1], X21
    FMOV  D4, X29
    FMOV  V4.D[1], X21
    FMOV  D5, X14
    FMOV  V5.D[1], X15
    FMOV  D6, X17
    FMOV  V6.D[1], X28
    FMOV  D7, X28
    FMOV  V7.D[1], X16
    FMOV  D8, X17
    FMOV  V8.D[1], X23
    FMOV  D9, X27
    FMOV  V9.D[1], X8
    FMOV  D10, X12
    FMOV  V10.D[1], X23
    FMOV  D11, X6
    FMOV  V11.D[1], X26
    FMOV  D12, X12
    FMOV  V12.D[1], X21
    FMOV  D13, X8
    FMOV  V13.D[1], X29
    FMOV  D14, X26
    FMOV  V14.D[1], X27
    FMOV  D15, X10
    FMOV  V15.D[1], X25
    FMOV  D16, X29
    FMOV  V16.D[1], X21
    FMOV  D17, X17
    FMOV  V17.D[1], X18
    FMOV  D18, X10
    FMOV  V18.D[1], X18
    FMOV  D19, X9
    FMOV  V19.D[1], X25
    FMOV  D20, X19
    FMOV  V20.D[1], X23
    FMOV  D21, X2
    FMOV  V21.D[1], X3
    FMOV  D22, X3
    FMOV  V22.D[1], X17
    FMOV  D23, X6
    FMOV  V23.D[1], X3
    FMOV  D24, X6
    FMOV  V24.D[1], X12
    FMOV  D25, X19
    FMOV  V25.D[1], X22
    FMOV  D26, X2
    FMOV  V26.D[1], X11
    FMOV  D27, X24
    FMOV  V27.D[1], X25
    FMOV  D28, X14
    FMOV  V28.D[1], X19
    FMOV  D29, X28
    FMOV  V29.D[1], X15
    FMOV  D30, X18
    FMOV  V30.D[1], X3
    FMOV  D31, X28
    FMOV  V31.D[1], X15
    MOVZ  X13, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_5:
    FMLAL2 V17.4S, V27.4H, V1.H[0x6]
    FMLAL2 V10.4S, V29.4H, V29.4H
    USDOT V28.4S, V24.16B, V28.4B[0x0]
    FMLAL2 V20.2S, V17.2H, V9.2H
    USDOT V15.4S, V1.16B, V28.16B
    FMLSL V31.2S, V10.2H, V9.H[0x5]
    USMMLA V4.4S, V31.16B, V29.16B
    SUDOT V18.4S, V4.16B, V15.4B[0x2]
    USMMLA V28.4S, V25.16B, V28.16B
    FMLSL2 V9.2S, V12.2H, V0.H[0x5]
    UMMLA V26.4S, V18.16B, V23.16B
    FMLSL2 V17.4S, V3.4H, V9.4H
    FMLAL2 V22.4S, V26.4H, V8.H[0x7]
    USDOT V18.4S, V18.16B, V22.4B[0x0]
    UMMLA V0.4S, V10.16B, V3.16B
    FMLSL2 V25.2S, V20.2H, V9.H[0x7]
    USDOT V8.4S, V27.16B, V17.4B[0x2]
    FMLAL V29.4S, V8.4H, V30.4H
    FMLAL V23.4S, V0.4H, V0.4H
    USDOT V31.4S, V23.16B, V25.16B
    FMLAL2 V2.4S, V18.4H, V15.H[0x5]
    SUDOT V11.4S, V29.16B, V29.4B[0x0]
    FMLAL V1.2S, V13.2H, V6.H[0x2]
    UMMLA V8.4S, V28.16B, V28.16B
    FMLAL2 V30.4S, V7.4H, V8.H[0x5]
    FMLAL V12.2S, V1.2H, V23.2H
    USDOT V25.4S, V2.16B, V30.16B
    SUDOT V31.2S, V20.8B, V23.4B[0x0]
    FMLAL V1.2S, V20.2H, V9.H[0x6]
    FMLSL V22.2S, V12.2H, V4.H[0x2]
    FMLSL V20.4S, V31.4H, V1.H[0x4]
    SUDOT V10.2S, V23.8B, V11.4B[0x3]
    FMLSL V4.4S, V22.4H, V25.4H
    FMLAL V1.4S, V24.4H, V10.4H
    SMMLA V21.4S, V2.16B, V1.16B
    FMLAL2 V26.4S, V9.4H, V7.4H
    SMMLA V31.4S, V20.16B, V12.16B
    SMMLA V9.4S, V7.16B, V17.16B
    FMLAL2 V10.4S, V31.4H, V14.H[0x2]
    USDOT V20.2S, V26.8B, V9.4B[0x0]
    FMLAL2 V25.2S, V20.2H, V9.H[0x0]
    USDOT V29.2S, V25.8B, V4.8B
    USMMLA V12.4S, V17.16B, V21.16B
    USDOT V23.2S, V12.8B, V2.8B
    USMMLA V11.4S, V29.16B, V23.16B
    USDOT V1.2S, V11.8B, V27.4B[0x1]
    SUDOT V12.2S, V9.8B, V5.4B[0x0]
    USDOT V26.4S, V28.16B, V26.4B[0x0]
    USDOT V9.4S, V3.16B, V12.16B
    FMLSL V12.2S, V13.2H, V28.2H
    USDOT V28.2S, V2.8B, V24.4B[0x1]
    FMLSL V19.4S, V5.4H, V17.4H
    FMLAL V30.2S, V3.2H, V3.2H
    FMLSL2 V23.4S, V30.4H, V3.H[0x4]
    USDOT V3.2S, V25.8B, V18.8B
    FMLAL2 V29.2S, V12.2H, V10.H[0x2]
    FMLSL2 V27.4S, V3.4H, V28.4H
    SUDOT V15.4S, V26.16B, V28.4B[0x3]
    SUDOT V15.2S, V23.8B, V26.4B[0x2]
    SUDOT V10.2S, V1.8B, V1.4B[0x1]
    USMMLA V11.4S, V19.16B, V2.16B
    FMLAL V12.2S, V27.2H, V13.H[0x0]
    FMLSL2 V28.2S, V16.2H, V5.H[0x5]
    SUDOT V19.4S, V12.16B, V29.4B[0x1]
    SUDOT V25.4S, V24.16B, V15.4B[0x3]
    FMLSL V25.2S, V19.2H, V25.2H
    FMLSL V1.2S, V7.2H, V10.H[0x3]
    FMLSL V23.4S, V25.4H, V9.4H
    SUDOT V29.4S, V23.16B, V11.4B[0x1]
    USDOT V13.4S, V29.16B, V29.16B
    USDOT V20.2S, V7.8B, V25.4B[0x0]
    FMLAL2 V3.2S, V20.2H, V1.2H
    FMLAL V25.4S, V4.4H, V13.H[0x6]
    FMLAL V19.4S, V0.4H, V15.H[0x3]
    SUDOT V5.4S, V23.16B, V1.4B[0x3]
    SMMLA V20.4S, V28.16B, V21.16B
    FMLSL2 V2.4S, V5.4H, V5.H[0x7]
    USMMLA V24.4S, V10.16B, V3.16B
    SUDOT V29.2S, V2.8B, V20.4B[0x0]
    USDOT V0.2S, V24.8B, V22.8B
    SUDOT V13.2S, V29.8B, V8.4B[0x3]
    USDOT V26.2S, V0.8B, V13.8B
    FMLSL2 V13.4S, V19.4H, V25.4H
    FMLSL V5.4S, V20.4H, V31.4H
    USMMLA V2.4S, V9.16B, V26.16B
    SUDOT V0.4S, V13.16B, V3.4B[0x0]
    USDOT V24.2S, V28.8B, V21.4B[0x3]
    SUDOT V27.4S, V30.16B, V30.4B[0x2]
    USMMLA V7.4S, V7.16B, V4.16B
    FMLSL V19.2S, V6.2H, V3.H[0x6]
    SMMLA V20.4S, V30.16B, V7.16B
    USDOT V28.2S, V16.8B, V7.8B
    FMLAL V15.2S, V17.2H, V23.2H
    SUDOT V1.4S, V15.16B, V24.4B[0x2]
    FMLAL V28.2S, V13.2H, V0.H[0x1]
    FMLAL V31.2S, V27.2H, V26.2H
    USDOT V24.2S, V2.8B, V8.4B[0x0]
    FMLSL2 V30.4S, V20.4H, V29.4H
    FMLAL V4.2S, V24.2H, V19.2H
    FMLSL V25.4S, V1.4H, V16.4H
    FMLSL V19.4S, V5.4H, V8.H[0x4]
    SUDOT V8.4S, V25.16B, V30.4B[0x2]
    FMLAL V21.2S, V15.2H, V10.2H
    FMLAL V30.2S, V28.2H, V8.H[0x3]
    FMLSL V11.4S, V21.4H, V12.4H
    USDOT V1.4S, V11.16B, V11.16B
    FMLAL V26.4S, V18.4H, V31.4H
    FMLAL2 V10.2S, V26.2H, V1.H[0x2]
    FMLSL2 V31.2S, V10.2H, V10.2H
    USDOT V2.4S, V9.16B, V16.4B[0x0]
    FMLAL2 V13.2S, V27.2H, V10.H[0x1]
    USDOT V24.4S, V19.16B, V13.16B
    FMLAL V15.2S, V30.2H, V14.H[0x6]
    UMMLA V0.4S, V2.16B, V1.16B
    FMLAL V20.4S, V8.4H, V30.4H
    SUDOT V21.4S, V27.16B, V31.4B[0x3]
    USDOT V3.4S, V0.16B, V15.16B
    FMLSL V18.4S, V20.4H, V4.H[0x1]
    FMLSL2 V15.2S, V5.2H, V3.2H
    USDOT V25.4S, V15.16B, V24.16B
    FMLSL V15.2S, V21.2H, V21.2H
    SMMLA V0.4S, V17.16B, V15.16B
    FMLSL V29.4S, V11.4H, V18.4H
    SUDOT V1.2S, V3.8B, V16.4B[0x0]
    FMLSL2 V16.2S, V29.2H, V0.H[0x2]
    FMLSL2 V3.4S, V16.4H, V1.H[0x3]
    UMMLA V9.4S, V9.16B, V31.16B
    UMMLA V6.4S, V29.16B, V18.16B
    FMLAL2 V18.4S, V13.4H, V14.H[0x1]
    USDOT V11.2S, V4.8B, V26.8B
    FMLAL V17.2S, V21.2H, V5.H[0x6]
    SUDOT V27.4S, V18.16B, V8.4B[0x2]
    UMMLA V1.4S, V30.16B, V24.16B
    FMLAL2 V12.4S, V24.4H, V10.H[0x1]
    FMLSL2 V5.4S, V6.4H, V3.4H
    USDOT V15.2S, V17.8B, V19.4B[0x0]
    FMLSL V16.2S, V9.2H, V5.H[0x5]
    USMMLA V31.4S, V20.16B, V7.16B
    FMLAL2 V10.2S, V9.2H, V12.H[0x0]
    USDOT V19.4S, V25.16B, V10.4B[0x0]
    USDOT V21.4S, V31.16B, V4.16B
    USMMLA V14.4S, V1.16B, V19.16B
    SMMLA V30.4S, V15.16B, V30.16B
    USDOT V1.2S, V5.8B, V11.8B
    USDOT V18.2S, V1.8B, V14.4B[0x2]
    FMLSL2 V31.2S, V12.2H, V12.H[0x0]
    FMLSL2 V15.2S, V31.2H, V7.H[0x4]
    FMLAL2 V9.4S, V3.4H, V1.H[0x0]
    FMLAL V13.2S, V9.2H, V18.2H
    FMLSL2 V29.2S, V11.2H, V23.2H
    SUDOT V5.2S, V16.8B, V13.4B[0x2]
    FMLSL V4.4S, V15.4H, V14.H[0x2]
    FMLAL V26.4S, V30.4H, V3.H[0x4]
    FMLSL2 V9.2S, V5.2H, V5.H[0x2]
    FMLSL V19.2S, V27.2H, V26.2H
    FMLAL V6.2S, V29.2H, V9.2H
    FMLAL V1.4S, V25.4H, V4.H[0x5]
    UMMLA V1.4S, V6.16B, V21.16B
    SMMLA V27.4S, V23.16B, V19.16B
    FMLSL2 V28.4S, V14.4H, V7.H[0x2]
    UMMLA V3.4S, V20.16B, V11.16B
    UMMLA V19.4S, V1.16B, V6.16B
    USDOT V23.4S, V20.16B, V16.4B[0x2]
    FMLAL2 V14.4S, V13.4H, V6.H[0x2]
    FMLSL2 V10.4S, V16.4H, V5.H[0x6]
    FMLSL V13.2S, V16.2H, V15.H[0x6]
    FMLSL2 V16.4S, V20.4H, V19.4H
    USDOT V29.2S, V26.8B, V4.4B[0x1]
    USDOT V9.4S, V29.16B, V2.16B
    USDOT V25.4S, V13.16B, V16.4B[0x3]
    SUDOT V2.2S, V27.8B, V27.4B[0x1]
    SUDOT V6.2S, V14.8B, V25.4B[0x1]
    FMLAL V7.4S, V1.4H, V2.H[0x0]
    USMMLA V15.4S, V23.16B, V24.16B
    FMLAL2 V23.4S, V9.4H, V1.H[0x6]
    FMLAL2 V21.4S, V6.4H, V11.H[0x2]
    FMLSL2 V4.4S, V7.4H, V9.4H
    FMLSL V1.2S, V21.2H, V4.H[0x6]
    USDOT V31.4S, V30.16B, V1.4B[0x1]
    FMLSL V7.2S, V22.2H, V3.H[0x2]
    FMLAL V5.4S, V15.4H, V7.4H
    FMLAL V19.4S, V26.4H, V23.4H
    USDOT V6.2S, V28.8B, V13.4B[0x0]
    USDOT V18.2S, V8.8B, V19.8B
    SUDOT V15.2S, V31.8B, V31.4B[0x1]
    USDOT V27.2S, V6.8B, V24.4B[0x0]
    USDOT V20.4S, V15.16B, V15.4B[0x0]
    USDOT V24.4S, V20.16B, V20.16B
    FMLSL2 V21.4S, V24.4H, V5.H[0x7]
    FMLAL V20.4S, V10.4H, V18.4H
    USDOT V5.2S, V12.8B, V27.4B[0x3]
    FMLSL2 V26.4S, V21.4H, V21.4H
    FMLAL V19.4S, V26.4H, V17.4H
    SUDOT V22.4S, V20.16B, V31.4B[0x0]
    FMLSL2 V24.4S, V27.4H, V22.4H
    FMLSL2 V27.2S, V19.2H, V2.2H
    FMLAL V19.2S, V5.2H, V24.2H
    FMLAL V1.2S, V16.2H, V28.2H
    FMLAL V24.2S, V21.2H, V19.2H
    SUDOT V6.4S, V22.16B, V27.4B[0x1]
    SUBS  X13, X13, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_5
    MOVZ  X15, #0x9aa3, LSL #0
    MOVK  X15, #0x85a2, LSL #16
    MOVK  X15, #0xae41, LSL #32
    MOVK  X15, #0x45aa, LSL #48
    SUB  X24, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xb517, LSL #0
    MOVK  X15, #0x5f6f, LSL #16
    MOVK  X15, #0x4614, LSL #32
    MOVK  X15, #0x741d, LSL #48
    SUB  X24, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x1897, LSL #0
    MOVK  X15, #0x39cb, LSL #16
    MOVK  X15, #0x8629, LSL #32
    MOVK  X15, #0x4e4c, LSL #48
    SUB  X24, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xfb4d, LSL #0
    MOVK  X15, #0x1521, LSL #16
    MOVK  X15, #0xf7db, LSL #32
    MOVK  X15, #0x9112, LSL #48
    SUB  X24, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x1889, LSL #0
    MOVK  X15, #0x8cbb, LSL #16
    MOVK  X15, #0x388, LSL #32
    MOVK  X15, #0xac45, LSL #48
    SUB  X24, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x283c, LSL #0
    MOVK  X15, #0x6108, LSL #16
    MOVK  X15, #0xc756, LSL #32
    MOVK  X15, #0xdb87, LSL #48
    SUB  X24, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xc526, LSL #0
    MOVK  X15, #0x40e9, LSL #16
    MOVK  X15, #0xe281, LSL #32
    MOVK  X15, #0x37cd, LSL #48
    SUB  X24, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x8e0d, LSL #0
    MOVK  X15, #0x1b06, LSL #16
    MOVK  X15, #0xb411, LSL #32
    MOVK  X15, #0xad0b, LSL #48
    SUB  X24, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x8236, LSL #0
    MOVK  X15, #0xa018, LSL #16
    MOVK  X15, #0x7575, LSL #32
    MOVK  X15, #0xee10, LSL #48
    SUB  X24, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x4324, LSL #0
    MOVK  X15, #0x7dbb, LSL #16
    MOVK  X15, #0xca52, LSL #32
    MOVK  X15, #0x2944, LSL #48
    SUB  X24, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x76a8, LSL #0
    MOVK  X15, #0xde42, LSL #16
    MOVK  X15, #0xf160, LSL #32
    MOVK  X15, #0x3a1a, LSL #48
    SUB  X24, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xf702, LSL #0
    MOVK  X15, #0x2c68, LSL #16
    MOVK  X15, #0x2567, LSL #32
    MOVK  X15, #0x20ac, LSL #48
    SUB  X24, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xb77a, LSL #0
    MOVK  X15, #0x9c1e, LSL #16
    MOVK  X15, #0x105e, LSL #32
    MOVK  X15, #0xa6fe, LSL #48
    SUB  X24, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x9aaf, LSL #0
    MOVK  X15, #0x51f5, LSL #16
    MOVK  X15, #0xf276, LSL #32
    MOVK  X15, #0xcb67, LSL #48
    SUB  X24, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xf62, LSL #0
    MOVK  X15, #0xb539, LSL #16
    MOVK  X15, #0xd623, LSL #32
    MOVK  X15, #0xbebf, LSL #48
    SUB  X24, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x72a9, LSL #0
    MOVK  X15, #0x6830, LSL #16
    MOVK  X15, #0x6407, LSL #32
    MOVK  X15, #0xd84, LSL #48
    SUB  X24, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0xe781, LSL #0
    MOVK  X15, #0xcc8d, LSL #16
    MOVK  X15, #0xc256, LSL #32
    MOVK  X15, #0xa4b2, LSL #48
    SUB  X24, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x62a, LSL #0
    MOVK  X15, #0x959e, LSL #16
    MOVK  X15, #0xf92f, LSL #32
    MOVK  X15, #0x44c9, LSL #48
    SUB  X24, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x57a3, LSL #0
    MOVK  X15, #0xe767, LSL #16
    MOVK  X15, #0xcfb8, LSL #32
    MOVK  X15, #0x83f8, LSL #48
    SUB  X24, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x5e3, LSL #0
    MOVK  X15, #0xcadb, LSL #16
    MOVK  X15, #0x72, LSL #32
    MOVK  X15, #0x4403, LSL #48
    SUB  X24, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X15, #0x802c, LSL #0
    MOVK  X15, #0xa94e, LSL #16
    MOVK  X15, #0x99, LSL #32
    MOVK  X15, #0xbc83, LSL #48
    SUB  X24, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X15, FPSR
    MOVZ  X24, #0x91, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X24, #0xd7e2, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xe62d, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D0
    MOVZ  X24, #0x29cf, LSL #0
    MOVK  X24, #0xc83a, LSL #16
    MOVK  X24, #0x7638, LSL #32
    MOVK  X24, #0x5fb4, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D1
    MOVZ  X24, #0x9f90, LSL #0
    MOVK  X24, #0xca11, LSL #16
    MOVK  X24, #0xd37b, LSL #32
    MOVK  X24, #0xfffc, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D2
    MOVZ  X24, #0xe7bf, LSL #0
    MOVK  X24, #0xe770, LSL #16
    MOVK  X24, #0x60eb, LSL #32
    MOVK  X24, #0x462d, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X24, #0x8f36, LSL #0
    MOVK  X24, #0x8000, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D3
    MOVZ  X24, #0x3230, LSL #0
    MOVK  X24, #0x2, LSL #16
    MOVK  X24, #0xa508, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X24, #0xe8c8, LSL #0
    MOVK  X24, #0x3743, LSL #16
    MOVK  X24, #0xe000, LSL #32
    MOVK  X24, #0xfffe, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D4
    MOVZ  X24, #0xab4f, LSL #0
    MOVK  X24, #0x7ffd, LSL #16
    MOVK  X24, #0xe000, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D5
    MOVZ  X24, #0x4000, LSL #0
    MOVK  X24, #0x7fe4, LSL #16
    MOVK  X24, #0xe000, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X24, #0x2484, LSL #0
    MOVK  X24, #0xea9b, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D6
    MOVZ  X24, #0x3511, LSL #0
    MOVK  X24, #0x40bc, LSL #16
    MOVK  X24, #0xa3fb, LSL #32
    MOVK  X24, #0x7ffd, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D7
    MOVZ  X24, #0xed18, LSL #0
    MOVK  X24, #0x7ffd, LSL #16
    MOVK  X24, #0xd838, LSL #32
    MOVK  X24, #0xffe5, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X24, #0x5f8f, LSL #0
    MOVK  X24, #0x6842, LSL #16
    MOVK  X24, #0xf56, LSL #32
    MOVK  X24, #0xd9f, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D8
    MOVZ  X24, #0x59e6, LSL #0
    MOVK  X24, #0x7dd6, LSL #16
    MOVK  X24, #0xdc16, LSL #32
    MOVK  X24, #0x2956, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D9
    MOVZ  X24, #0x9e73, LSL #0
    MOVK  X24, #0xc902, LSL #16
    MOVK  X24, #0x39e5, LSL #32
    MOVK  X24, #0xfffe, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D10
    MOVZ  X24, #0x71d9, LSL #0
    MOVK  X24, #0xcdae, LSL #16
    MOVK  X24, #0xbaeb, LSL #32
    MOVK  X24, #0xfffe, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D11
    MOVZ  X24, #0x3194, LSL #0
    MOVK  X24, #0x5f7a, LSL #16
    MOVK  X24, #0x64e4, LSL #32
    MOVK  X24, #0xfffd, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D12
    MOVZ  X24, #0x2306, LSL #0
    MOVK  X24, #0x4b03, LSL #16
    MOVK  X24, #0xaad9, LSL #32
    MOVK  X24, #0x7ff0, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D13
    MOVZ  X24, #0xfbd3, LSL #0
    MOVK  X24, #0xc7e0, LSL #16
    MOVK  X24, #0xc26c, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X24, #0xa000, LSL #0
    MOVK  X24, #0x7fd9, LSL #16
    MOVK  X24, #0xa000, LSL #32
    MOVK  X24, #0x7fd9, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D14
    MOVZ  X24, #0xeb0b, LSL #0
    MOVK  X24, #0x7fda, LSL #16
    MOVK  X24, #0x18df, LSL #32
    MOVK  X24, #0x7fdb, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D15
    MOVZ  X24, #0xbbcb, LSL #0
    MOVK  X24, #0xffe9, LSL #16
    MOVK  X24, #0x77a6, LSL #32
    MOVK  X24, #0x7ff7, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D16
    MOVZ  X24, #0x2000, LSL #0
    MOVK  X24, #0x7fd4, LSL #16
    MOVK  X24, #0x2000, LSL #32
    MOVK  X24, #0x7fd4, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D17
    MOVZ  X24, #0x4324, LSL #0
    MOVK  X24, #0x7dbb, LSL #16
    MOVK  X24, #0x7ffd, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D18
    MOVZ  X24, #0xc58f, LSL #0
    MOVK  X24, #0x7ffe, LSL #16
    MOVK  X24, #0x2932, LSL #32
    MOVK  X24, #0xfffd, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D19
    MOVZ  X24, #0x7161, LSL #0
    MOVK  X24, #0xbf81, LSL #16
    MOVK  X24, #0x6000, LSL #32
    MOVK  X24, #0x7ff7, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X24, #0xe7ec, LSL #0
    MOVK  X24, #0x4627, LSL #16
    MOVK  X24, #0xc000, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D20
    MOVZ  X24, #0xfa18, LSL #0
    MOVK  X24, #0x7fdf, LSL #16
    MOVK  X24, #0x66df, LSL #32
    MOVK  X24, #0x7ffa, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X24, #0xc000, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0xc000, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D21
    MOVZ  X24, #0xec8d, LSL #0
    MOVK  X24, #0x7fe9, LSL #16
    MOVK  X24, #0x71cb, LSL #32
    MOVK  X24, #0x7ffd, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X24, #0x5802, LSL #0
    MOVK  X24, #0xdcea, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D22
    MOVZ  X24, #0x4254, LSL #0
    MOVK  X24, #0x4ab3, LSL #16
    MOVK  X24, #0xf1e9, LSL #32
    MOVK  X24, #0xfffb, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X24, #0x2010, LSL #0
    MOVK  X24, #0xc404, LSL #16
    MOVK  X24, #0xfffc, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D23
    MOVZ  X24, #0x98b, LSL #0
    MOVK  X24, #0xfffc, LSL #16
    MOVK  X24, #0xa494, LSL #32
    MOVK  X24, #0xfffd, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D24
    MOVZ  X24, #0xade0, LSL #0
    MOVK  X24, #0xffeb, LSL #16
    MOVK  X24, #0x2000, LSL #32
    MOVK  X24, #0x7ffd, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X24, #0x8000, LSL #0
    MOVK  X24, #0x4bb8, LSL #16
    MOVK  X24, #0xe000, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D25
    MOVZ  X24, #0x53a1, LSL #0
    MOVK  X24, #0x7fd4, LSL #16
    MOVK  X24, #0x7163, LSL #32
    MOVK  X24, #0x7fe0, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X24, #0x7b53, LSL #0
    MOVK  X24, #0xc082, LSL #16
    MOVK  X24, #0xa000, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D26
    MOVZ  X24, #0xb36b, LSL #0
    MOVK  X24, #0x7ff3, LSL #16
    MOVK  X24, #0xc000, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D27
    MOVZ  X24, #0x6999, LSL #0
    MOVK  X24, #0x7fde, LSL #16
    MOVK  X24, #0x6936, LSL #32
    MOVK  X24, #0xfffe, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xbf87, LSL #16
    MOVK  X24, #0x2000, LSL #32
    MOVK  X24, #0xfffb, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D28
    MOVZ  X24, #0x18c4, LSL #0
    MOVK  X24, #0xca4c, LSL #16
    MOVK  X24, #0x183e, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D29
    MOVZ  X24, #0xce17, LSL #0
    MOVK  X24, #0x7fef, LSL #16
    MOVK  X24, #0x64b9, LSL #32
    MOVK  X24, #0x7ffa, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D30
    MOVZ  X24, #0xfa41, LSL #0
    MOVK  X24, #0xffd0, LSL #16
    MOVK  X24, #0xd123, LSL #32
    MOVK  X24, #0x4409, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X15, D31
    MOVZ  X24, #0x8513, LSL #0
    MOVK  X24, #0xffd7, LSL #16
    MOVK  X24, #0xc9c6, LSL #32
    MOVK  X24, #0x7ff3, LSL #48
    SUB  X2, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X24
    FMOV  V0.D[1], X12
    FMOV  D1, X17
    FMOV  V1.D[1], X27
    FMOV  D2, X23
    FMOV  V2.D[1], X16
    FMOV  D3, X19
    FMOV  V3.D[1], X28
    FMOV  D4, X11
    FMOV  V4.D[1], X26
    FMOV  D5, X29
    FMOV  V5.D[1], X22
    FMOV  D6, X20
    FMOV  V6.D[1], X18
    FMOV  D7, X25
    FMOV  V7.D[1], X20
    FMOV  D8, X25
    FMOV  V8.D[1], X17
    FMOV  D9, X10
    FMOV  V9.D[1], X26
    FMOV  D10, X21
    FMOV  V10.D[1], X26
    FMOV  D11, X17
    FMOV  V11.D[1], X21
    FMOV  D12, X24
    FMOV  V12.D[1], X3
    FMOV  D13, X11
    FMOV  V13.D[1], X3
    FMOV  D14, X29
    FMOV  V14.D[1], X11
    FMOV  D15, X13
    FMOV  V15.D[1], X19
    FMOV  D16, X28
    FMOV  V16.D[1], X10
    FMOV  D17, X26
    FMOV  V17.D[1], X13
    FMOV  D18, X8
    FMOV  V18.D[1], X25
    FMOV  D19, X2
    FMOV  V19.D[1], X8
    FMOV  D20, X15
    FMOV  V20.D[1], X9
    FMOV  D21, X6
    FMOV  V21.D[1], X11
    FMOV  D22, X18
    FMOV  V22.D[1], X22
    FMOV  D23, X22
    FMOV  V23.D[1], X2
    FMOV  D24, X15
    FMOV  V24.D[1], X26
    FMOV  D25, X22
    FMOV  V25.D[1], X20
    FMOV  D26, X12
    FMOV  V26.D[1], X10
    FMOV  D27, X25
    FMOV  V27.D[1], X26
    FMOV  D28, X23
    FMOV  V28.D[1], X15
    FMOV  D29, X20
    FMOV  V29.D[1], X22
    FMOV  D30, X15
    FMOV  V30.D[1], X14
    FMOV  D31, X16
    FMOV  V31.D[1], X19
    MOVZ  X20, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_6:
    USDOT V4.4S, V26.16B, V25.16B
    SUDOT V25.4S, V23.16B, V23.4B[0x0]
    USMMLA V3.4S, V1.16B, V16.16B
    FMLAL2 V21.2S, V27.2H, V22.2H
    SMMLA V30.4S, V13.16B, V14.16B
    USDOT V23.4S, V29.16B, V24.16B
    USDOT V19.2S, V11.8B, V20.8B
    FMLSL2 V4.2S, V31.2H, V3.H[0x0]
    FMLAL V4.4S, V21.4H, V14.H[0x4]
    UMMLA V20.4S, V19.16B, V30.16B
    FMLAL V19.4S, V20.4H, V3.H[0x3]
    FMLAL V18.4S, V28.4H, V16.4H
    USDOT V9.4S, V23.16B, V19.4B[0x3]
    USMMLA V30.4S, V18.16B, V9.16B
    USMMLA V24.4S, V30.16B, V30.16B
    FMLSL2 V26.2S, V4.2H, V16.2H
    UMMLA V29.4S, V14.16B, V30.16B
    FMLAL2 V18.2S, V7.2H, V29.2H
    SUDOT V0.4S, V21.16B, V26.4B[0x1]
    USDOT V3.4S, V7.16B, V0.4B[0x3]
    SMMLA V31.4S, V25.16B, V18.16B
    FMLAL2 V28.4S, V11.4H, V3.H[0x7]
    USDOT V27.4S, V29.16B, V31.16B
    USMMLA V28.4S, V17.16B, V28.16B
    USDOT V1.4S, V27.16B, V27.16B
    UMMLA V18.4S, V27.16B, V1.16B
    FMLAL2 V19.2S, V19.2H, V18.2H
    FMLAL2 V18.2S, V28.2H, V19.2H
    FMLSL V14.2S, V8.2H, V21.2H
    FMLAL2 V3.2S, V7.2H, V19.2H
    SUDOT V13.4S, V16.16B, V11.4B[0x2]
    USDOT V1.2S, V16.8B, V30.8B
    FMLSL V31.4S, V29.4H, V9.H[0x7]
    FMLAL V27.2S, V18.2H, V12.H[0x7]
    FMLAL2 V19.4S, V8.4H, V6.H[0x4]
    SMMLA V23.4S, V13.16B, V11.16B
    USDOT V17.4S, V24.16B, V14.4B[0x2]
    UMMLA V9.4S, V12.16B, V24.16B
    SUDOT V2.2S, V2.8B, V1.4B[0x0]
    USMMLA V18.4S, V7.16B, V12.16B
    USDOT V6.2S, V3.8B, V18.4B[0x2]
    FMLSL V18.2S, V7.2H, V2.H[0x3]
    USDOT V2.2S, V14.8B, V23.4B[0x0]
    FMLAL V24.2S, V27.2H, V3.H[0x6]
    FMLSL V1.2S, V25.2H, V2.2H
    FMLSL2 V7.2S, V26.2H, V3.2H
    UMMLA V16.4S, V18.16B, V24.16B
    FMLAL2 V18.4S, V31.4H, V11.H[0x4]
    SMMLA V3.4S, V9.16B, V5.16B
    SUDOT V11.2S, V17.8B, V18.4B[0x0]
    UMMLA V29.4S, V11.16B, V19.16B
    USDOT V30.2S, V16.8B, V16.8B
    FMLAL V13.4S, V9.4H, V24.4H
    FMLAL2 V22.2S, V1.2H, V7.2H
    USDOT V2.4S, V3.16B, V6.4B[0x1]
    USMMLA V19.4S, V13.16B, V13.16B
    FMLAL V4.2S, V29.2H, V17.2H
    USDOT V27.4S, V22.16B, V12.16B
    FMLSL2 V18.2S, V19.2H, V19.2H
    FMLSL2 V11.4S, V30.4H, V30.4H
    SUDOT V13.4S, V11.16B, V8.4B[0x3]
    FMLSL2 V15.4S, V20.4H, V13.H[0x2]
    USMMLA V4.4S, V2.16B, V27.16B
    USDOT V25.4S, V15.16B, V17.4B[0x1]
    FMLAL2 V12.4S, V25.4H, V4.4H
    FMLSL V27.4S, V12.4H, V5.H[0x0]
    FMLAL V8.2S, V26.2H, V4.H[0x0]
    SUDOT V26.2S, V8.8B, V23.4B[0x3]
    SUDOT V31.2S, V11.8B, V26.4B[0x3]
    FMLAL2 V5.2S, V5.2H, V13.H[0x2]
    FMLSL2 V20.2S, V1.2H, V7.H[0x5]
    USDOT V4.4S, V28.16B, V24.16B
    USDOT V0.2S, V24.8B, V21.8B
    FMLAL V26.2S, V2.2H, V11.2H
    SUDOT V17.4S, V6.16B, V5.4B[0x1]
    FMLSL V3.2S, V10.2H, V3.H[0x0]
    USDOT V25.2S, V18.8B, V26.4B[0x2]
    FMLAL V4.2S, V18.2H, V24.2H
    FMLAL2 V7.4S, V31.4H, V4.4H
    FMLAL2 V6.4S, V10.4H, V22.4H
    USDOT V15.4S, V31.16B, V7.16B
    FMLSL2 V2.2S, V15.2H, V25.2H
    FMLAL2 V8.4S, V6.4H, V2.H[0x4]
    USDOT V13.2S, V17.8B, V27.4B[0x2]
    SUDOT V17.4S, V1.16B, V23.4B[0x3]
    UMMLA V21.4S, V17.16B, V23.16B
    FMLSL2 V17.4S, V17.4H, V8.4H
    USDOT V2.4S, V13.16B, V3.4B[0x2]
    FMLSL2 V30.4S, V12.4H, V0.H[0x2]
    USMMLA V5.4S, V20.16B, V30.16B
    FMLAL V1.4S, V21.4H, V5.H[0x3]
    USMMLA V27.4S, V17.16B, V1.16B
    USMMLA V31.4S, V14.16B, V1.16B
    FMLSL V1.4S, V7.4H, V13.H[0x5]
    SUDOT V6.2S, V20.8B, V28.4B[0x1]
    FMLSL2 V9.4S, V14.4H, V6.H[0x5]
    FMLAL2 V26.2S, V8.2H, V3.2H
    FMLSL V0.4S, V0.4H, V5.H[0x6]
    USDOT V21.2S, V1.8B, V31.4B[0x3]
    FMLSL2 V12.4S, V9.4H, V3.4H
    USMMLA V15.4S, V1.16B, V31.16B
    FMLSL V8.4S, V0.4H, V5.H[0x0]
    USDOT V3.2S, V27.8B, V2.8B
    USDOT V17.2S, V30.8B, V8.4B[0x2]
    USDOT V22.4S, V8.16B, V4.16B
    USMMLA V30.4S, V8.16B, V13.16B
    FMLAL2 V12.2S, V27.2H, V9.H[0x0]
    FMLAL V8.4S, V12.4H, V30.4H
    FMLSL V2.2S, V7.2H, V11.H[0x3]
    FMLAL2 V6.2S, V1.2H, V18.2H
    USDOT V28.2S, V2.8B, V22.8B
    USDOT V20.4S, V16.16B, V28.4B[0x2]
    FMLAL2 V22.2S, V3.2H, V8.2H
    FMLAL V5.4S, V6.4H, V15.H[0x6]
    FMLSL2 V22.2S, V14.2H, V26.2H
    UMMLA V7.4S, V5.16B, V17.16B
    FMLAL2 V17.4S, V11.4H, V21.4H
    FMLSL2 V12.4S, V31.4H, V12.H[0x5]
    FMLAL V21.2S, V22.2H, V12.2H
    SUDOT V4.2S, V21.8B, V20.4B[0x1]
    USMMLA V27.4S, V4.16B, V7.16B
    FMLAL V28.2S, V23.2H, V7.2H
    USDOT V16.4S, V11.16B, V27.16B
    FMLSL V27.2S, V10.2H, V2.H[0x7]
    UMMLA V20.4S, V11.16B, V0.16B
    USDOT V12.2S, V26.8B, V15.8B
    FMLAL2 V8.2S, V27.2H, V8.2H
    FMLSL2 V11.4S, V21.4H, V3.H[0x7]
    FMLAL2 V6.2S, V11.2H, V10.2H
    USDOT V13.2S, V28.8B, V4.8B
    SUDOT V15.4S, V16.16B, V20.4B[0x0]
    FMLSL2 V5.4S, V20.4H, V21.4H
    FMLSL V28.4S, V30.4H, V14.4H
    SUDOT V4.2S, V5.8B, V29.4B[0x2]
    USMMLA V27.4S, V11.16B, V9.16B
    USDOT V20.4S, V13.16B, V12.4B[0x2]
    FMLAL2 V10.2S, V27.2H, V7.H[0x0]
    SMMLA V9.4S, V28.16B, V4.16B
    FMLAL V21.4S, V13.4H, V15.H[0x4]
    USMMLA V22.4S, V8.16B, V10.16B
    UMMLA V3.4S, V21.16B, V6.16B
    USMMLA V12.4S, V9.16B, V22.16B
    SUDOT V6.2S, V20.8B, V8.4B[0x3]
    FMLSL V13.2S, V17.2H, V12.H[0x5]
    USDOT V19.4S, V3.16B, V6.4B[0x1]
    USDOT V30.2S, V12.8B, V26.8B
    FMLSL2 V18.2S, V31.2H, V9.H[0x1]
    FMLAL V31.2S, V2.2H, V29.2H
    FMLAL V2.2S, V16.2H, V17.2H
    FMLAL2 V20.4S, V5.4H, V15.H[0x0]
    USDOT V21.4S, V11.16B, V2.16B
    USDOT V4.4S, V30.16B, V29.4B[0x0]
    UMMLA V28.4S, V1.16B, V7.16B
    FMLAL2 V0.4S, V14.4H, V0.4H
    FMLAL2 V27.4S, V20.4H, V0.H[0x4]
    FMLSL V16.4S, V28.4H, V9.H[0x3]
    FMLAL2 V3.4S, V15.4H, V12.H[0x2]
    FMLSL V10.4S, V13.4H, V16.4H
    FMLAL2 V26.2S, V31.2H, V4.2H
    FMLSL V5.2S, V18.2H, V13.2H
    USDOT V12.4S, V30.16B, V2.16B
    UMMLA V0.4S, V27.16B, V26.16B
    FMLSL2 V22.4S, V31.4H, V25.4H
    USMMLA V29.4S, V21.16B, V12.16B
    FMLAL V4.4S, V29.4H, V29.4H
    USDOT V28.4S, V10.16B, V14.4B[0x0]
    SMMLA V9.4S, V28.16B, V3.16B
    UMMLA V2.4S, V5.16B, V5.16B
    FMLAL V5.2S, V20.2H, V0.2H
    USDOT V14.4S, V2.16B, V4.16B
    FMLAL2 V7.2S, V19.2H, V22.2H
    FMLAL2 V31.4S, V9.4H, V9.H[0x2]
    FMLAL V12.2S, V11.2H, V7.H[0x6]
    FMLAL V4.4S, V16.4H, V24.4H
    SUDOT V24.2S, V12.8B, V19.4B[0x0]
    USDOT V25.4S, V14.16B, V4.16B
    USDOT V30.4S, V15.16B, V5.16B
    FMLSL2 V28.4S, V26.4H, V4.H[0x6]
    FMLAL2 V9.4S, V11.4H, V13.H[0x5]
    USDOT V14.4S, V24.16B, V28.16B
    FMLSL V21.4S, V0.4H, V4.4H
    FMLSL V5.2S, V31.2H, V21.2H
    FMLAL V26.2S, V9.2H, V14.H[0x2]
    USDOT V15.4S, V5.16B, V4.16B
    SMMLA V27.4S, V25.16B, V30.16B
    FMLAL2 V21.2S, V26.2H, V27.2H
    FMLSL V26.2S, V28.2H, V9.2H
    FMLSL V28.4S, V25.4H, V2.H[0x3]
    USDOT V27.2S, V25.8B, V3.4B[0x3]
    SMMLA V11.4S, V30.16B, V26.16B
    UMMLA V7.4S, V8.16B, V24.16B
    USDOT V19.2S, V28.8B, V8.4B[0x2]
    USDOT V8.4S, V7.16B, V17.16B
    UMMLA V12.4S, V24.16B, V22.16B
    FMLSL2 V22.2S, V18.2H, V6.H[0x1]
    FMLSL2 V17.4S, V29.4H, V20.4H
    FMLSL V0.4S, V27.4H, V8.H[0x7]
    USDOT V31.2S, V21.8B, V12.8B
    FMLAL V18.4S, V0.4H, V15.H[0x4]
    SMMLA V2.4S, V31.16B, V10.16B
    SUBS  X20, X20, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_6
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X19, FPSR
    MOVZ  X8, #0x91, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X19, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X22
    FMOV  V2.D[1], X28
    FMOV  D3, X8
    FMOV  V3.D[1], X22
    FMOV  D4, X27
    FMOV  V4.D[1], X25
    FMOV  D5, X10
    FMOV  V5.D[1], X20
    FMOV  D6, X28
    FMOV  V6.D[1], X22
    FMOV  D7, X14
    FMOV  V7.D[1], X24
    FMOV  D8, X6
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X8
    FMOV  D10, X20
    FMOV  V10.D[1], X12
    FMOV  D11, X19
    FMOV  V11.D[1], X18
    FMOV  D12, X2
    FMOV  V12.D[1], X23
    FMOV  D13, X25
    FMOV  V13.D[1], X29
    FMOV  D14, X24
    FMOV  V14.D[1], X23
    FMOV  D15, X11
    FMOV  V15.D[1], X16
    FMOV  D16, X16
    FMOV  V16.D[1], X20
    FMOV  D17, X27
    FMOV  V17.D[1], X17
    FMOV  D18, X25
    FMOV  V18.D[1], X15
    FMOV  D19, X18
    FMOV  V19.D[1], X10
    FMOV  D20, X26
    FMOV  V20.D[1], X24
    FMOV  D21, X14
    FMOV  V21.D[1], X28
    FMOV  D22, X6
    FMOV  V22.D[1], X11
    FMOV  D23, X26
    FMOV  V23.D[1], X16
    FMOV  D24, X12
    FMOV  V24.D[1], X10
    FMOV  D25, X25
    FMOV  V25.D[1], X25
    FMOV  D26, X6
    FMOV  V26.D[1], X6
    FMOV  D27, X20
    FMOV  V27.D[1], X24
    FMOV  D28, X29
    FMOV  V28.D[1], X10
    FMOV  D29, X27
    FMOV  V29.D[1], X16
    FMOV  D30, X17
    FMOV  V30.D[1], X20
    FMOV  D31, X8
    FMOV  V31.D[1], X6
    MOVZ  X9, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_7:
    FMLSL2 V15.2S, V28.2H, V8.H[0x0]
    UMMLA V15.4S, V27.16B, V23.16B
    FMLAL2 V28.4S, V20.4H, V29.4H
    FMLSL2 V2.4S, V30.4H, V15.H[0x1]
    FMLAL V11.4S, V28.4H, V1.H[0x2]
    SUDOT V27.2S, V26.8B, V26.4B[0x0]
    FMLSL V22.4S, V16.4H, V31.4H
    UMMLA V23.4S, V2.16B, V2.16B
    FMLAL2 V1.4S, V14.4H, V11.H[0x7]
    FMLAL V9.4S, V23.4H, V27.4H
    FMLSL2 V19.4S, V23.4H, V15.4H
    SUDOT V25.2S, V24.8B, V1.4B[0x3]
    USDOT V23.4S, V19.16B, V8.16B
    SMMLA V31.4S, V17.16B, V0.16B
    FMLSL V16.4S, V31.4H, V9.H[0x4]
    FMLAL V26.2S, V10.2H, V25.2H
    SUDOT V15.2S, V31.8B, V28.4B[0x1]
    FMLSL2 V17.2S, V8.2H, V15.2H
    FMLAL V8.4S, V8.4H, V0.H[0x7]
    FMLAL V15.2S, V8.2H, V23.2H
    USMMLA V10.4S, V26.16B, V26.16B
    USDOT V24.2S, V17.8B, V15.8B
    FMLSL V27.2S, V18.2H, V1.H[0x5]
    USDOT V23.4S, V16.16B, V16.4B[0x2]
    FMLSL2 V14.4S, V27.4H, V23.4H
    FMLAL V28.2S, V22.2H, V14.2H
    FMLSL V19.2S, V28.2H, V24.2H
    FMLAL2 V18.4S, V24.4H, V13.H[0x7]
    FMLAL2 V1.4S, V25.4H, V18.4H
    USMMLA V16.4S, V26.16B, V9.16B
    FMLSL V31.2S, V10.2H, V15.H[0x5]
    FMLSL V20.2S, V8.2H, V15.2H
    USDOT V29.4S, V2.16B, V10.16B
    FMLAL2 V22.2S, V26.2H, V28.2H
    FMLAL2 V6.4S, V2.4H, V29.4H
    FMLAL2 V27.2S, V18.2H, V6.2H
    FMLAL V14.4S, V11.4H, V7.4H
    USMMLA V6.4S, V4.16B, V1.16B
    USDOT V23.4S, V9.16B, V6.16B
    FMLAL V18.2S, V12.2H, V11.2H
    FMLSL V24.2S, V18.2H, V14.H[0x2]
    SUDOT V28.2S, V27.8B, V24.4B[0x3]
    SUDOT V6.4S, V23.16B, V20.4B[0x2]
    USDOT V4.2S, V12.8B, V14.8B
    FMLAL2 V2.4S, V18.4H, V4.H[0x1]
    FMLAL V11.2S, V16.2H, V7.H[0x4]
    SMMLA V0.4S, V28.16B, V2.16B
    UMMLA V13.4S, V19.16B, V11.16B
    FMLAL2 V27.4S, V28.4H, V13.H[0x1]
    FMLAL V29.4S, V23.4H, V19.4H
    UMMLA V18.4S, V22.16B, V22.16B
    FMLSL2 V2.4S, V31.4H, V27.4H
    FMLSL V26.2S, V30.2H, V2.H[0x1]
    UMMLA V4.4S, V6.16B, V6.16B
    FMLAL V31.4S, V29.4H, V4.H[0x2]
    FMLAL2 V24.2S, V26.2H, V4.H[0x6]
    USDOT V16.4S, V0.16B, V24.16B
    SUDOT V1.4S, V5.16B, V7.4B[0x3]
    FMLAL V30.4S, V1.4H, V16.4H
    FMLAL2 V1.4S, V30.4H, V13.H[0x4]
    FMLAL V23.2S, V1.2H, V4.H[0x0]
    FMLSL2 V29.4S, V18.4H, V18.4H
    FMLAL2 V24.2S, V30.2H, V29.2H
    FMLAL V29.2S, V24.2H, V24.2H
    USDOT V28.2S, V7.8B, V23.4B[0x2]
    FMLAL V1.4S, V29.4H, V28.4H
    USMMLA V28.4S, V3.16B, V8.16B
    UMMLA V27.4S, V10.16B, V16.16B
    SUDOT V26.2S, V21.8B, V24.4B[0x2]
    FMLSL2 V8.4S, V28.4H, V23.4H
    FMLAL2 V15.4S, V22.4H, V12.H[0x0]
    FMLSL V12.2S, V14.2H, V19.2H
    FMLAL V11.2S, V30.2H, V18.2H
    FMLSL2 V18.2S, V6.2H, V5.H[0x6]
    FMLSL2 V30.4S, V11.4H, V7.4H
    SMMLA V19.4S, V3.16B, V26.16B
    USDOT V5.4S, V8.16B, V27.4B[0x0]
    USMMLA V10.4S, V12.16B, V30.16B
    FMLAL2 V16.2S, V10.2H, V15.H[0x0]
    USDOT V29.4S, V5.16B, V5.16B
    FMLSL V5.2S, V18.2H, V7.H[0x0]
    SUDOT V31.4S, V1.16B, V16.4B[0x3]
    USDOT V22.2S, V29.8B, V19.4B[0x2]
    FMLAL V15.2S, V31.2H, V4.H[0x3]
    FMLAL V8.4S, V22.4H, V14.H[0x2]
    SUDOT V16.2S, V29.8B, V30.4B[0x0]
    SUDOT V12.2S, V8.8B, V18.4B[0x1]
    FMLSL V31.2S, V12.2H, V5.2H
    FMLSL2 V23.4S, V31.4H, V30.4H
    FMLAL2 V0.2S, V15.2H, V8.H[0x3]
    SMMLA V15.4S, V16.16B, V16.16B
    USDOT V1.2S, V23.8B, V0.8B
    USDOT V22.4S, V13.16B, V3.16B
    FMLAL2 V4.2S, V19.2H, V18.2H
    UMMLA V11.4S, V2.16B, V6.16B
    FMLAL2 V30.4S, V2.4H, V27.4H
    FMLAL2 V16.4S, V21.4H, V3.H[0x0]
    FMLAL V3.2S, V18.2H, V24.2H
    SUDOT V13.2S, V30.8B, V0.4B[0x3]
    USDOT V22.4S, V25.16B, V30.16B
    UMMLA V14.4S, V1.16B, V7.16B
    USDOT V19.2S, V18.8B, V13.4B[0x1]
    USDOT V12.4S, V10.16B, V7.16B
    USDOT V31.2S, V3.8B, V15.8B
    FMLSL2 V30.2S, V4.2H, V4.H[0x2]
    FMLAL2 V10.4S, V12.4H, V10.H[0x1]
    FMLSL2 V16.2S, V14.2H, V24.2H
    SUDOT V24.4S, V30.16B, V29.4B[0x3]
    USDOT V0.2S, V10.8B, V2.4B[0x3]
    FMLSL2 V15.2S, V22.2H, V18.2H
    FMLSL V27.4S, V19.4H, V0.4H
    FMLAL2 V4.2S, V31.2H, V5.2H
    FMLSL2 V30.2S, V27.2H, V7.H[0x2]
    FMLAL V1.2S, V15.2H, V11.H[0x0]
    FMLSL2 V31.4S, V1.4H, V4.4H
    FMLSL2 V5.4S, V19.4H, V16.4H
    FMLSL2 V1.4S, V2.4H, V5.H[0x3]
    USDOT V13.2S, V31.8B, V13.8B
    FMLSL V11.2S, V24.2H, V1.H[0x6]
    USDOT V4.2S, V6.8B, V18.4B[0x0]
    FMLAL V1.2S, V11.2H, V4.2H
    FMLSL V2.2S, V19.2H, V10.H[0x5]
    FMLAL V25.4S, V4.4H, V2.H[0x3]
    FMLSL V3.2S, V1.2H, V13.H[0x4]
    USDOT V3.2S, V22.8B, V8.8B
    FMLSL V12.2S, V9.2H, V3.H[0x0]
    FMLAL V10.2S, V26.2H, V12.2H
    USDOT V0.4S, V5.16B, V13.4B[0x1]
    FMLSL2 V19.2S, V0.2H, V10.H[0x1]
    SUDOT V11.2S, V1.8B, V30.4B[0x1]
    SMMLA V31.4S, V26.16B, V11.16B
    USMMLA V2.4S, V25.16B, V12.16B
    FMLSL2 V16.4S, V19.4H, V13.4H
    FMLAL V19.2S, V2.2H, V12.2H
    FMLSL2 V15.2S, V16.2H, V4.H[0x0]
    SUDOT V14.4S, V15.16B, V16.4B[0x0]
    FMLAL2 V26.2S, V22.2H, V14.2H
    USMMLA V27.4S, V19.16B, V16.16B
    SMMLA V30.4S, V27.16B, V27.16B
    FMLAL2 V1.4S, V8.4H, V15.H[0x7]
    USDOT V7.2S, V30.8B, V30.8B
    USDOT V1.2S, V31.8B, V31.8B
    FMLAL2 V11.4S, V1.4H, V7.4H
    SMMLA V0.4S, V15.16B, V28.16B
    UMMLA V28.4S, V28.16B, V3.16B
    FMLSL2 V3.2S, V15.2H, V14.2H
    FMLSL V29.2S, V31.2H, V12.2H
    FMLAL2 V24.2S, V26.2H, V12.H[0x2]
    USMMLA V10.4S, V6.16B, V6.16B
    UMMLA V16.4S, V19.16B, V27.16B
    USMMLA V30.4S, V5.16B, V27.16B
    USDOT V31.4S, V23.16B, V16.4B[0x3]
    USDOT V4.4S, V28.16B, V0.16B
    FMLSL2 V8.4S, V8.4H, V10.H[0x2]
    FMLSL2 V22.4S, V11.4H, V24.4H
    UMMLA V23.4S, V4.16B, V4.16B
    FMLAL V2.2S, V31.2H, V3.H[0x0]
    FMLSL2 V16.4S, V22.4H, V29.4H
    USDOT V7.4S, V2.16B, V21.16B
    FMLAL2 V22.4S, V30.4H, V8.H[0x4]
    FMLSL V13.2S, V23.2H, V7.H[0x2]
    FMLAL V10.2S, V4.2H, V16.2H
    FMLAL2 V0.4S, V27.4H, V0.4H
    FMLSL V5.4S, V22.4H, V0.H[0x1]
    UMMLA V27.4S, V12.16B, V5.16B
    FMLSL V22.2S, V28.2H, V0.H[0x7]
    UMMLA V29.4S, V10.16B, V8.16B
    USDOT V12.2S, V29.8B, V13.4B[0x3]
    FMLAL2 V13.2S, V9.2H, V27.2H
    USDOT V5.4S, V3.16B, V13.16B
    FMLAL V2.4S, V5.4H, V0.H[0x4]
    USDOT V7.2S, V3.8B, V13.8B
    USDOT V13.4S, V2.16B, V9.4B[0x0]
    USDOT V21.2S, V0.8B, V22.4B[0x2]
    FMLAL2 V31.2S, V1.2H, V13.2H
    SUDOT V16.2S, V23.8B, V7.4B[0x0]
    FMLAL2 V6.4S, V14.4H, V5.H[0x2]
    FMLSL2 V1.2S, V27.2H, V12.H[0x2]
    FMLSL V7.2S, V16.2H, V12.H[0x4]
    SUDOT V22.4S, V30.16B, V21.4B[0x3]
    USDOT V1.4S, V7.16B, V12.16B
    UMMLA V20.4S, V20.16B, V6.16B
    FMLSL2 V7.4S, V1.4H, V5.H[0x6]
    FMLSL2 V30.4S, V21.4H, V10.H[0x7]
    SUDOT V3.4S, V4.16B, V20.4B[0x0]
    FMLAL V28.4S, V22.4H, V6.H[0x3]
    SUDOT V14.2S, V13.8B, V7.4B[0x3]
    FMLSL2 V21.2S, V31.2H, V14.H[0x7]
    USDOT V14.2S, V9.8B, V7.4B[0x1]
    FMLAL V22.2S, V29.2H, V3.2H
    USDOT V9.4S, V30.16B, V22.16B
    SUDOT V16.4S, V3.16B, V14.4B[0x2]
    FMLSL2 V20.4S, V21.4H, V9.H[0x2]
    UMMLA V8.4S, V20.16B, V16.16B
    FMLSL V12.2S, V6.2H, V29.2H
    FMLSL2 V27.4S, V8.4H, V26.4H
    SMMLA V21.4S, V18.16B, V12.16B
    FMLAL V13.4S, V21.4H, V15.H[0x4]
    FMLSL2 V29.2S, V13.2H, V25.2H
    FMLAL2 V30.2S, V5.2H, V6.2H
    SUBS  X9, X9, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_7
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X20, FPSR
    MOVZ  X16, #0x91, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D0
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D1
    MOVZ  X16, #0xb101, LSL #0
    MOVK  X16, #0x7fc3, LSL #16
    MOVK  X16, #0x54c0, LSL #32
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X16, #0x4000, LSL #0
    MOVK  X16, #0xffe2, LSL #16
    MOVK  X16, #0xe000, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D2
    MOVZ  X16, #0x6541, LSL #0
    MOVK  X16, #0x7fe3, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D3
    MOVZ  X16, #0xa28, LSL #0
    MOVK  X16, #0x7fcc, LSL #16
    MOVK  X16, #0xef96, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D4
    MOVZ  X16, #0xb254, LSL #0
    MOVK  X16, #0xffde, LSL #16
    MOVK  X16, #0x652e, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xc000, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D5
    MOVZ  X16, #0x97df, LSL #0
    MOVK  X16, #0xfffe, LSL #16
    MOVK  X16, #0xfd12, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X16, #0x4000, LSL #0
    MOVK  X16, #0xffe2, LSL #16
    MOVK  X16, #0x4000, LSL #32
    MOVK  X16, #0xffe2, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D6
    MOVZ  X16, #0x4000, LSL #0
    MOVK  X16, #0xffe2, LSL #16
    MOVK  X16, #0x4000, LSL #32
    MOVK  X16, #0xffe2, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D7
    MOVZ  X16, #0x4000, LSL #0
    MOVK  X16, #0x7fe3, LSL #16
    MOVK  X16, #0x1115, LSL #32
    MOVK  X16, #0xfffc, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X16, #0xe000, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D8
    MOVZ  X16, #0x39bf, LSL #0
    MOVK  X16, #0x1, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xffe9, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D9
    MOVZ  X16, #0x1278, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x3ffd, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D10
    MOVZ  X16, #0x6db3, LSL #0
    MOVK  X16, #0xfff9, LSL #16
    MOVK  X16, #0xc799, LSL #32
    MOVK  X16, #0xfffe, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D11
    MOVZ  X16, #0x4907, LSL #0
    MOVK  X16, #0x4bed, LSL #16
    MOVK  X16, #0xaf6c, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D12
    MOVZ  X16, #0xba, LSL #0
    MOVK  X16, #0xffe1, LSL #16
    MOVK  X16, #0x54dc, LSL #32
    MOVK  X16, #0x7ff7, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X16, #0xe000, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xe000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D13
    MOVZ  X16, #0xce6f, LSL #0
    MOVK  X16, #0xffe3, LSL #16
    MOVK  X16, #0x2bdd, LSL #32
    MOVK  X16, #0x7ffd, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D14
    MOVZ  X16, #0x43bd, LSL #0
    MOVK  X16, #0x48b9, LSL #16
    MOVK  X16, #0xd3bb, LSL #32
    MOVK  X16, #0xfffe, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D15
    MOVZ  X16, #0xeec8, LSL #0
    MOVK  X16, #0x7fe7, LSL #16
    MOVK  X16, #0xe000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D16
    MOVZ  X16, #0xfd1a, LSL #0
    MOVK  X16, #0x7fde, LSL #16
    MOVK  X16, #0xd18a, LSL #32
    MOVK  X16, #0x8000, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D17
    MOVZ  X16, #0xe000, LSL #0
    MOVK  X16, #0xffd9, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D18
    MOVZ  X16, #0xa000, LSL #0
    MOVK  X16, #0xc2f4, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D19
    MOVZ  X16, #0xb583, LSL #0
    MOVK  X16, #0xfff9, LSL #16
    MOVK  X16, #0x55b, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D20
    MOVZ  X16, #0x8117, LSL #0
    MOVK  X16, #0x4886, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D21
    MOVZ  X16, #0xe8da, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D22
    MOVZ  X16, #0x8d3f, LSL #0
    MOVK  X16, #0xfffc, LSL #16
    MOVK  X16, #0xebe3, LSL #32
    MOVK  X16, #0xfffe, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xe000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D23
    MOVZ  X16, #0x2cf4, LSL #0
    MOVK  X16, #0xbe24, LSL #16
    MOVK  X16, #0x1b44, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D24
    MOVZ  X16, #0x7a75, LSL #0
    MOVK  X16, #0xfffe, LSL #16
    MOVK  X16, #0xf56e, LSL #32
    MOVK  X16, #0x7ffe, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X16, #0xe000, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xe000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D25
    MOVZ  X16, #0x8714, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xb8ee, LSL #32
    MOVK  X16, #0xfffb, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D26
    MOVZ  X16, #0xa000, LSL #0
    MOVK  X16, #0x7fcc, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0xfffc, LSL #16
    MOVK  X16, #0x8000, LSL #32
    MOVK  X16, #0xfffc, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D27
    MOVZ  X16, #0xec32, LSL #0
    MOVK  X16, #0x3f9e, LSL #16
    MOVK  X16, #0xe000, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X16, #0x4000, LSL #0
    MOVK  X16, #0xfffc, LSL #16
    MOVK  X16, #0xc000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D28
    MOVZ  X16, #0x4000, LSL #0
    MOVK  X16, #0xfffc, LSL #16
    MOVK  X16, #0x4dc4, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D29
    MOVZ  X16, #0xbb96, LSL #0
    MOVK  X16, #0x7fdc, LSL #16
    MOVK  X16, #0xa000, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D30
    MOVZ  X16, #0x4000, LSL #0
    MOVK  X16, #0xffe2, LSL #16
    MOVK  X16, #0x216c, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X20, D31
    MOVZ  X16, #0x48f4, LSL #0
    MOVK  X16, #0xffe2, LSL #16
    MOVK  X16, #0x1e0e, LSL #32
    MOVK  X16, #0xffe2, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X26
    FMOV  D1, X16
    FMOV  V1.D[1], X16
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X28
    FMOV  V3.D[1], X22
    FMOV  D4, X8
    FMOV  V4.D[1], X18
    FMOV  D5, X6
    FMOV  V5.D[1], X23
    FMOV  D6, X2
    FMOV  V6.D[1], X18
    FMOV  D7, X18
    FMOV  V7.D[1], X8
    FMOV  D8, X13
    FMOV  V8.D[1], X12
    FMOV  D9, X28
    FMOV  V9.D[1], X17
    FMOV  D10, X3
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X17
    FMOV  D12, X26
    FMOV  V12.D[1], X17
    FMOV  D13, X2
    FMOV  V13.D[1], X22
    FMOV  D14, X23
    FMOV  V14.D[1], X16
    FMOV  D15, X24
    FMOV  V15.D[1], X12
    FMOV  D16, X25
    FMOV  V16.D[1], X10
    FMOV  D17, X2
    FMOV  V17.D[1], X13
    FMOV  D18, X20
    FMOV  V18.D[1], X3
    FMOV  D19, X24
    FMOV  V19.D[1], X23
    FMOV  D20, X22
    FMOV  V20.D[1], X3
    FMOV  D21, X11
    FMOV  V21.D[1], X25
    FMOV  D22, X13
    FMOV  V22.D[1], X17
    FMOV  D23, X27
    FMOV  V23.D[1], X17
    FMOV  D24, X28
    FMOV  V24.D[1], X10
    FMOV  D25, X20
    FMOV  V25.D[1], X8
    FMOV  D26, X11
    FMOV  V26.D[1], X20
    FMOV  D27, X14
    FMOV  V27.D[1], X25
    FMOV  D28, X23
    FMOV  V28.D[1], X19
    FMOV  D29, X6
    FMOV  V29.D[1], X12
    FMOV  D30, X8
    FMOV  V30.D[1], X18
    FMOV  D31, X21
    FMOV  V31.D[1], X23
    MOVZ  X19, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_8:
    USMMLA V19.4S, V22.16B, V30.16B
    FMLSL2 V29.2S, V28.2H, V27.2H
    USDOT V10.2S, V31.8B, V25.8B
    FMLSL V30.4S, V3.4H, V13.H[0x7]
    FMLSL2 V6.4S, V24.4H, V7.H[0x0]
    FMLSL V22.4S, V3.4H, V29.4H
    FMLAL2 V15.4S, V10.4H, V7.H[0x7]
    FMLAL V19.4S, V2.4H, V10.H[0x7]
    UMMLA V8.4S, V6.16B, V6.16B
    SUDOT V27.2S, V8.8B, V8.4B[0x3]
    SMMLA V18.4S, V15.16B, V19.16B
    FMLSL2 V10.4S, V18.4H, V7.4H
    USDOT V24.4S, V30.16B, V30.16B
    FMLSL V8.4S, V7.4H, V26.4H
    FMLSL2 V28.2S, V27.2H, V22.2H
    FMLSL V3.4S, V28.4H, V10.H[0x3]
    FMLAL V28.2S, V24.2H, V13.H[0x1]
    FMLSL2 V21.2S, V3.2H, V8.2H
    FMLAL2 V23.2S, V14.2H, V0.H[0x6]
    FMLSL V24.4S, V2.4H, V21.4H
    FMLAL V26.4S, V17.4H, V8.H[0x0]
    USDOT V16.2S, V14.8B, V17.8B
    SUDOT V30.2S, V0.8B, V10.4B[0x1]
    USDOT V6.4S, V12.16B, V13.16B
    FMLSL V13.4S, V27.4H, V0.H[0x0]
    FMLSL2 V10.2S, V6.2H, V4.2H
    USDOT V27.4S, V7.16B, V3.4B[0x0]
    FMLAL V14.2S, V14.2H, V6.2H
    UMMLA V7.4S, V27.16B, V1.16B
    SMMLA V12.4S, V28.16B, V26.16B
    UMMLA V26.4S, V14.16B, V12.16B
    FMLAL V28.4S, V16.4H, V6.H[0x7]
    SMMLA V6.4S, V29.16B, V25.16B
    FMLAL V8.4S, V30.4H, V24.4H
    USDOT V17.4S, V23.16B, V6.4B[0x0]
    FMLSL2 V0.4S, V18.4H, V3.H[0x2]
    FMLSL2 V19.4S, V10.4H, V0.H[0x4]
    FMLAL2 V4.2S, V26.2H, V10.H[0x2]
    USDOT V3.2S, V13.8B, V19.4B[0x3]
    FMLSL V19.4S, V8.4H, V8.H[0x2]
    FMLSL2 V29.4S, V19.4H, V6.H[0x7]
    FMLSL V30.4S, V31.4H, V7.4H
    SUDOT V1.2S, V3.8B, V4.4B[0x2]
    FMLAL V21.4S, V1.4H, V29.4H
    SUDOT V25.4S, V10.16B, V28.4B[0x3]
    FMLSL2 V26.2S, V24.2H, V30.2H
    USDOT V27.4S, V1.16B, V26.4B[0x3]
    USDOT V4.4S, V30.16B, V21.4B[0x2]
    FMLAL2 V16.2S, V7.2H, V4.H[0x2]
    USDOT V18.2S, V11.8B, V16.8B
    FMLSL V7.2S, V18.2H, V25.2H
    USMMLA V10.4S, V18.16B, V17.16B
    FMLSL2 V29.2S, V3.2H, V7.H[0x2]
    USDOT V0.4S, V10.16B, V19.4B[0x1]
    USDOT V24.4S, V27.16B, V15.16B
    USMMLA V3.4S, V24.16B, V29.16B
    USDOT V18.2S, V19.8B, V0.8B
    FMLAL2 V11.4S, V27.4H, V1.H[0x6]
    FMLAL2 V30.4S, V31.4H, V3.4H
    FMLSL2 V29.2S, V6.2H, V3.2H
    FMLSL V10.2S, V29.2H, V30.2H
    USMMLA V29.4S, V21.16B, V1.16B
    USMMLA V6.4S, V16.16B, V23.16B
    FMLAL2 V8.2S, V14.2H, V12.H[0x6]
    FMLSL V4.4S, V11.4H, V7.H[0x7]
    FMLAL V31.2S, V20.2H, V11.2H
    SMMLA V26.4S, V18.16B, V1.16B
    FMLSL V18.4S, V13.4H, V23.4H
    FMLAL2 V30.2S, V18.2H, V9.H[0x4]
    USMMLA V22.4S, V5.16B, V0.16B
    FMLSL2 V26.4S, V29.4H, V12.4H
    UMMLA V1.4S, V22.16B, V30.16B
    SUDOT V0.4S, V20.16B, V10.4B[0x3]
    FMLAL2 V5.4S, V17.4H, V12.H[0x5]
    USDOT V22.4S, V5.16B, V6.4B[0x0]
    UMMLA V24.4S, V30.16B, V0.16B
    FMLAL2 V11.2S, V11.2H, V8.H[0x1]
    FMLSL2 V8.4S, V22.4H, V5.4H
    FMLSL2 V6.4S, V13.4H, V8.H[0x6]
    FMLAL V5.4S, V1.4H, V14.4H
    FMLSL2 V10.2S, V6.2H, V4.H[0x0]
    FMLSL2 V18.2S, V5.2H, V10.H[0x6]
    FMLSL2 V1.4S, V24.4H, V18.4H
    USDOT V7.4S, V7.16B, V6.4B[0x1]
    USDOT V20.2S, V31.8B, V26.8B
    SUDOT V30.2S, V2.8B, V20.4B[0x1]
    USMMLA V31.4S, V1.16B, V30.16B
    FMLAL V4.2S, V7.2H, V16.2H
    FMLAL V2.4S, V31.4H, V7.H[0x0]
    FMLSL V16.4S, V0.4H, V14.H[0x0]
    FMLAL V22.4S, V21.4H, V16.4H
    FMLSL V17.2S, V4.2H, V14.H[0x5]
    FMLSL2 V18.2S, V17.2H, V2.H[0x6]
    USMMLA V17.4S, V4.16B, V6.16B
    SUDOT V26.4S, V17.16B, V11.4B[0x0]
    FMLAL V13.4S, V26.4H, V22.4H
    FMLAL2 V23.2S, V18.2H, V1.H[0x4]
    USDOT V6.2S, V18.8B, V11.8B
    FMLAL2 V30.4S, V12.4H, V30.4H
    FMLAL V7.2S, V27.2H, V2.H[0x1]
    UMMLA V31.4S, V14.16B, V20.16B
    FMLAL V20.2S, V15.2H, V0.H[0x0]
    USDOT V25.4S, V23.16B, V7.16B
    FMLAL2 V15.2S, V18.2H, V11.H[0x7]
    FMLAL V21.4S, V19.4H, V25.4H
    USDOT V0.4S, V31.16B, V9.4B[0x1]
    FMLAL V7.2S, V12.2H, V10.2H
    USDOT V8.4S, V10.16B, V8.4B[0x1]
    FMLAL2 V12.2S, V8.2H, V15.H[0x5]
    FMLSL V19.2S, V12.2H, V7.H[0x0]
    USDOT V16.2S, V13.8B, V13.4B[0x1]
    USDOT V13.4S, V16.16B, V17.16B
    SUDOT V23.4S, V24.16B, V19.4B[0x0]
    FMLSL2 V9.2S, V20.2H, V4.H[0x2]
    FMLAL2 V20.2S, V21.2H, V0.2H
    FMLSL2 V23.2S, V24.2H, V30.2H
    UMMLA V7.4S, V20.16B, V23.16B
    SMMLA V15.4S, V26.16B, V7.16B
    FMLSL V29.2S, V4.2H, V1.2H
    FMLAL V2.4S, V15.4H, V4.4H
    UMMLA V4.4S, V12.16B, V9.16B
    FMLSL2 V11.2S, V8.2H, V9.H[0x2]
    UMMLA V9.4S, V21.16B, V2.16B
    FMLAL V1.4S, V22.4H, V16.4H
    SUDOT V19.2S, V29.8B, V9.4B[0x3]
    FMLSL V22.4S, V4.4H, V4.H[0x0]
    SMMLA V8.4S, V19.16B, V30.16B
    USDOT V24.4S, V22.16B, V9.16B
    USDOT V4.2S, V27.8B, V13.4B[0x1]
    USDOT V6.4S, V8.16B, V18.4B[0x0]
    USDOT V15.2S, V1.8B, V28.4B[0x2]
    FMLAL V22.2S, V6.2H, V24.2H
    USDOT V0.4S, V22.16B, V8.4B[0x3]
    UMMLA V29.4S, V29.16B, V0.16B
    FMLAL2 V16.4S, V29.4H, V29.4H
    FMLAL V27.4S, V23.4H, V5.H[0x6]
    USDOT V23.2S, V27.8B, V15.8B
    USDOT V28.2S, V16.8B, V9.8B
    FMLSL V30.2S, V18.2H, V20.2H
    FMLAL2 V29.4S, V11.4H, V11.4H
    FMLSL V8.4S, V30.4H, V4.H[0x0]
    UMMLA V13.4S, V23.16B, V30.16B
    FMLSL V20.4S, V13.4H, V13.4H
    SUDOT V0.2S, V29.8B, V8.4B[0x1]
    FMLSL2 V21.2S, V17.2H, V28.2H
    FMLAL V15.4S, V4.4H, V21.4H
    FMLAL V9.2S, V0.2H, V17.2H
    FMLSL V29.4S, V27.4H, V15.H[0x5]
    SUDOT V22.2S, V20.8B, V16.4B[0x1]
    SUDOT V16.2S, V26.8B, V9.4B[0x3]
    UMMLA V18.4S, V8.16B, V16.16B
    USMMLA V17.4S, V26.16B, V18.16B
    FMLSL V11.4S, V22.4H, V20.4H
    FMLAL2 V1.2S, V29.2H, V20.2H
    FMLAL2 V23.4S, V21.4H, V0.4H
    SMMLA V4.4S, V14.16B, V25.16B
    SUDOT V25.4S, V28.16B, V23.4B[0x2]
    USDOT V27.4S, V29.16B, V28.16B
    SMMLA V4.4S, V1.16B, V17.16B
    FMLSL V22.4S, V27.4H, V4.4H
    FMLAL2 V17.2S, V25.2H, V15.H[0x1]
    FMLSL V20.4S, V31.4H, V16.4H
    UMMLA V18.4S, V13.16B, V24.16B
    FMLSL V5.4S, V11.4H, V14.H[0x4]
    FMLSL V15.2S, V0.2H, V2.2H
    USDOT V13.2S, V6.8B, V17.4B[0x1]
    SUDOT V9.4S, V0.16B, V21.4B[0x2]
    USDOT V1.4S, V20.16B, V1.16B
    USDOT V17.4S, V22.16B, V22.16B
    USDOT V20.4S, V18.16B, V5.4B[0x1]
    FMLSL V30.4S, V31.4H, V26.4H
    FMLAL2 V0.4S, V15.4H, V26.4H
    FMLSL V22.2S, V17.2H, V3.H[0x3]
    USMMLA V31.4S, V9.16B, V25.16B
    SUDOT V16.4S, V23.16B, V0.4B[0x1]
    FMLSL V17.4S, V31.4H, V19.4H
    FMLAL V9.2S, V13.2H, V8.H[0x6]
    USMMLA V14.4S, V16.16B, V11.16B
    USDOT V24.2S, V22.8B, V23.8B
    FMLSL2 V2.2S, V8.2H, V10.H[0x0]
    USDOT V5.2S, V14.8B, V1.4B[0x2]
    SUDOT V27.4S, V17.16B, V17.4B[0x0]
    USDOT V8.2S, V2.8B, V10.4B[0x3]
    FMLAL V15.2S, V24.2H, V12.H[0x2]
    FMLSL2 V0.4S, V20.4H, V8.4H
    UMMLA V3.4S, V27.16B, V15.16B
    FMLAL2 V20.2S, V5.2H, V9.H[0x5]
    SMMLA V28.4S, V18.16B, V3.16B
    UMMLA V10.4S, V9.16B, V10.16B
    USMMLA V4.4S, V27.16B, V6.16B
    FMLAL2 V2.4S, V16.4H, V31.4H
    FMLSL2 V17.2S, V25.2H, V28.2H
    FMLSL V27.2S, V17.2H, V9.H[0x4]
    USDOT V14.4S, V0.16B, V3.4B[0x3]
    USMMLA V28.4S, V27.16B, V4.16B
    FMLSL V18.4S, V10.4H, V2.H[0x5]
    SMMLA V10.4S, V20.16B, V20.16B
    FMLAL2 V23.4S, V5.4H, V10.H[0x3]
    FMLAL V0.2S, V14.2H, V6.2H
    UMMLA V3.4S, V0.16B, V18.16B
    SUBS  X19, X19, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_8
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X23, FPSR
    MOVZ  X13, #0x91, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D0
    MOVZ  X13, #0x2d12, LSL #0
    MOVK  X13, #0x7fca, LSL #16
    MOVK  X13, #0x7dc8, LSL #32
    MOVK  X13, #0xfffa, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D1
    MOVZ  X13, #0x1291, LSL #0
    MOVK  X13, #0x7fd3, LSL #16
    MOVK  X13, #0x893b, LSL #32
    MOVK  X13, #0xfffd, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D2
    MOVZ  X13, #0x6000, LSL #0
    MOVK  X13, #0xffe7, LSL #16
    MOVK  X13, #0x6000, LSL #32
    MOVK  X13, #0xffe7, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X13, #0x9cd9, LSL #0
    MOVK  X13, #0x3, LSL #16
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D3
    MOVZ  X13, #0x385f, LSL #0
    MOVK  X13, #0x8005, LSL #16
    MOVK  X13, #0x2bc8, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X13, #0xa1dd, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xec38, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D4
    MOVZ  X13, #0x739f, LSL #0
    MOVK  X13, #0xfff8, LSL #16
    MOVK  X13, #0x3d6d, LSL #32
    MOVK  X13, #0xfffa, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D5
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x4000, LSL #32
    MOVK  X13, #0xfffa, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xfdc1, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D6
    MOVZ  X13, #0xf146, LSL #0
    MOVK  X13, #0xffcd, LSL #16
    MOVK  X13, #0x88ad, LSL #32
    MOVK  X13, #0xffcc, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D7
    MOVZ  X13, #0xfdae, LSL #0
    MOVK  X13, #0xffd2, LSL #16
    MOVK  X13, #0xd648, LSL #32
    MOVK  X13, #0xfff8, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D8
    MOVZ  X13, #0xf28a, LSL #0
    MOVK  X13, #0xfff3, LSL #16
    MOVK  X13, #0x6d5e, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D9
    MOVZ  X13, #0xca19, LSL #0
    MOVK  X13, #0x5a76, LSL #16
    MOVK  X13, #0x4000, LSL #32
    MOVK  X13, #0x7ff9, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D10
    MOVZ  X13, #0x920, LSL #0
    MOVK  X13, #0xfff4, LSL #16
    MOVK  X13, #0xedf8, LSL #32
    MOVK  X13, #0x7ffc, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X13, #0x3958, LSL #0
    MOVK  X13, #0xc487, LSL #16
    MOVK  X13, #0xe000, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D11
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fed, LSL #16
    MOVK  X13, #0x7ff9, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D12
    MOVZ  X13, #0xe239, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x57d2, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D13
    MOVZ  X13, #0xb310, LSL #0
    MOVK  X13, #0x5a80, LSL #16
    MOVK  X13, #0x60eb, LSL #32
    MOVK  X13, #0xfffd, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D14
    MOVZ  X13, #0xed15, LSL #0
    MOVK  X13, #0x7fcf, LSL #16
    MOVK  X13, #0x90a4, LSL #32
    MOVK  X13, #0xfffc, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D15
    MOVZ  X13, #0x9668, LSL #0
    MOVK  X13, #0xffd1, LSL #16
    MOVK  X13, #0xc37c, LSL #32
    MOVK  X13, #0xfff9, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D16
    MOVZ  X13, #0x6178, LSL #0
    MOVK  X13, #0x5a5d, LSL #16
    MOVK  X13, #0x4e5a, LSL #32
    MOVK  X13, #0xfffc, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D17
    MOVZ  X13, #0xf0c, LSL #0
    MOVK  X13, #0xfff8, LSL #16
    MOVK  X13, #0x867, LSL #32
    MOVK  X13, #0xfff6, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D18
    MOVZ  X13, #0x484a, LSL #0
    MOVK  X13, #0x44a0, LSL #16
    MOVK  X13, #0x6000, LSL #32
    MOVK  X13, #0x7ffe, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D19
    MOVZ  X13, #0x83ef, LSL #0
    MOVK  X13, #0xffe7, LSL #16
    MOVK  X13, #0x32c2, LSL #32
    MOVK  X13, #0xffe7, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D20
    MOVZ  X13, #0xc89f, LSL #0
    MOVK  X13, #0x7fca, LSL #16
    MOVK  X13, #0x481b, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D21
    MOVZ  X13, #0xe000, LSL #0
    MOVK  X13, #0xffd0, LSL #16
    MOVK  X13, #0x4000, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D22
    MOVZ  X13, #0xada0, LSL #0
    MOVK  X13, #0xfff1, LSL #16
    MOVK  X13, #0x60ba, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X13, #0x8000, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x8000, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D23
    MOVZ  X13, #0x4704, LSL #0
    MOVK  X13, #0xffd3, LSL #16
    MOVK  X13, #0xf316, LSL #32
    MOVK  X13, #0xfffd, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D24
    MOVZ  X13, #0xa83f, LSL #0
    MOVK  X13, #0x5a82, LSL #16
    MOVK  X13, #0x5043, LSL #32
    MOVK  X13, #0x8001, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D25
    MOVZ  X13, #0xbc5d, LSL #0
    MOVK  X13, #0x5a5d, LSL #16
    MOVK  X13, #0xce36, LSL #32
    MOVK  X13, #0x5a5d, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D26
    MOVZ  X13, #0x4f1c, LSL #0
    MOVK  X13, #0x5a77, LSL #16
    MOVK  X13, #0x8069, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D27
    MOVZ  X13, #0x7d57, LSL #0
    MOVK  X13, #0x5a5d, LSL #16
    MOVK  X13, #0xb69, LSL #32
    MOVK  X13, #0xfffe, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X13, #0x3155, LSL #0
    MOVK  X13, #0x209e, LSL #32
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D28
    MOVZ  X13, #0x498f, LSL #0
    MOVK  X13, #0x7fd8, LSL #16
    MOVK  X13, #0xad21, LSL #32
    MOVK  X13, #0xfffd, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X13, #0x18d0, LSL #0
    MOVK  X13, #0xbb77, LSL #16
    MOVK  X13, #0xc000, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D29
    MOVZ  X13, #0xf95c, LSL #0
    MOVK  X13, #0x7fe7, LSL #16
    MOVK  X13, #0x8808, LSL #32
    MOVK  X13, #0xc396, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xc000, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D30
    MOVZ  X13, #0xce42, LSL #0
    MOVK  X13, #0xffef, LSL #16
    MOVK  X13, #0xeefe, LSL #32
    MOVK  X13, #0x7ffe, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X13, #0x7383, LSL #0
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X23, D31
    MOVZ  X13, #0x46fe, LSL #0
    MOVK  X13, #0x5a85, LSL #16
    MOVK  X13, #0x19f6, LSL #32
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X10
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X16
    FMOV  D3, X24
    FMOV  V3.D[1], X2
    FMOV  D4, X11
    FMOV  V4.D[1], X22
    FMOV  D5, X9
    FMOV  V5.D[1], X12
    FMOV  D6, X28
    FMOV  V6.D[1], X10
    FMOV  D7, X22
    FMOV  V7.D[1], X19
    FMOV  D8, X11
    FMOV  V8.D[1], X9
    FMOV  D9, X17
    FMOV  V9.D[1], X21
    FMOV  D10, X11
    FMOV  V10.D[1], X14
    FMOV  D11, X25
    FMOV  V11.D[1], X15
    FMOV  D12, X6
    FMOV  V12.D[1], X13
    FMOV  D13, X12
    FMOV  V13.D[1], X13
    FMOV  D14, X2
    FMOV  V14.D[1], X14
    FMOV  D15, X9
    FMOV  V15.D[1], X12
    FMOV  D16, X17
    FMOV  V16.D[1], X3
    FMOV  D17, X2
    FMOV  V17.D[1], X28
    FMOV  D18, X29
    FMOV  V18.D[1], X17
    FMOV  D19, X18
    FMOV  V19.D[1], X15
    FMOV  D20, X24
    FMOV  V20.D[1], X18
    FMOV  D21, X23
    FMOV  V21.D[1], X23
    FMOV  D22, X3
    FMOV  V22.D[1], X28
    FMOV  D23, X20
    FMOV  V23.D[1], X26
    FMOV  D24, X21
    FMOV  V24.D[1], X23
    FMOV  D25, X17
    FMOV  V25.D[1], X10
    FMOV  D26, X14
    FMOV  V26.D[1], X24
    FMOV  D27, X26
    FMOV  V27.D[1], X28
    FMOV  D28, X20
    FMOV  V28.D[1], X18
    FMOV  D29, X16
    FMOV  V29.D[1], X10
    FMOV  D30, X8
    FMOV  V30.D[1], X23
    FMOV  D31, X19
    FMOV  V31.D[1], X11
    MOVZ  X12, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_9:
    USDOT V3.4S, V19.16B, V16.4B[0x1]
    USDOT V11.4S, V25.16B, V25.4B[0x1]
    SUDOT V17.2S, V11.8B, V28.4B[0x3]
    FMLAL2 V14.2S, V21.2H, V24.2H
    SMMLA V22.4S, V26.16B, V3.16B
    USDOT V24.2S, V27.8B, V27.8B
    FMLAL2 V19.4S, V30.4H, V14.H[0x1]
    FMLAL2 V12.2S, V23.2H, V22.2H
    FMLAL2 V4.2S, V13.2H, V12.H[0x6]
    SUDOT V3.2S, V10.8B, V3.4B[0x2]
    FMLAL V22.4S, V24.4H, V5.4H
    FMLSL2 V5.4S, V3.4H, V8.H[0x1]
    FMLSL2 V26.2S, V26.2H, V5.H[0x0]
    USDOT V11.4S, V4.16B, V4.4B[0x2]
    SUDOT V12.2S, V22.8B, V17.4B[0x3]
    FMLAL2 V24.4S, V26.4H, V12.H[0x6]
    FMLAL2 V14.2S, V11.2H, V11.H[0x3]
    FMLSL2 V22.4S, V31.4H, V14.4H
    USDOT V23.2S, V22.8B, V19.4B[0x1]
    FMLSL2 V16.4S, V12.4H, V23.4H
    SMMLA V13.4S, V26.16B, V16.16B
    FMLSL V16.4S, V1.4H, V13.H[0x1]
    FMLAL V25.2S, V19.2H, V6.H[0x1]
    FMLSL V19.2S, V16.2H, V12.2H
    USDOT V7.4S, V24.16B, V23.16B
    FMLAL2 V12.2S, V25.2H, V19.2H
    FMLSL2 V14.2S, V12.2H, V7.2H
    FMLAL2 V26.2S, V17.2H, V10.2H
    FMLAL2 V7.4S, V0.4H, V12.H[0x1]
    USDOT V6.4S, V27.16B, V8.4B[0x0]
    FMLSL2 V16.4S, V18.4H, V9.H[0x3]
    FMLAL2 V1.4S, V15.4H, V9.4H
    FMLAL2 V24.4S, V17.4H, V10.H[0x2]
    FMLSL2 V9.2S, V22.2H, V18.2H
    FMLSL V3.4S, V4.4H, V11.4H
    USDOT V25.4S, V6.16B, V24.16B
    UMMLA V21.4S, V9.16B, V26.16B
    UMMLA V30.4S, V16.16B, V25.16B
    SUDOT V12.2S, V1.8B, V14.4B[0x1]
    FMLSL V18.2S, V30.2H, V12.2H
    USDOT V11.2S, V18.8B, V18.4B[0x3]
    USMMLA V24.4S, V11.16B, V11.16B
    SMMLA V4.4S, V5.16B, V15.16B
    FMLSL2 V15.4S, V18.4H, V3.H[0x4]
    USDOT V22.2S, V24.8B, V15.4B[0x0]
    FMLAL2 V7.2S, V7.2H, V21.2H
    FMLSL2 V24.2S, V0.2H, V22.2H
    FMLAL V8.2S, V20.2H, V7.H[0x3]
    FMLSL V21.2S, V6.2H, V8.H[0x1]
    USDOT V30.2S, V14.8B, V31.8B
    FMLAL2 V31.2S, V24.2H, V4.H[0x1]
    UMMLA V17.4S, V27.16B, V23.16B
    SMMLA V23.4S, V27.16B, V21.16B
    FMLAL V7.2S, V23.2H, V3.H[0x4]
    USDOT V26.4S, V26.16B, V30.4B[0x2]
    FMLAL V18.2S, V17.2H, V15.H[0x5]
    USDOT V11.2S, V30.8B, V17.4B[0x3]
    FMLAL2 V12.2S, V13.2H, V20.2H
    USDOT V1.2S, V21.8B, V31.4B[0x3]
    FMLSL V15.4S, V26.4H, V1.4H
    USDOT V13.2S, V11.8B, V18.8B
    SUDOT V21.4S, V12.16B, V15.4B[0x2]
    USMMLA V27.4S, V5.16B, V15.16B
    USDOT V31.2S, V30.8B, V13.8B
    FMLSL V1.4S, V27.4H, V21.4H
    FMLSL V4.4S, V19.4H, V1.H[0x0]
    USDOT V1.4S, V1.16B, V31.16B
    FMLSL2 V14.2S, V10.2H, V7.2H
    FMLSL2 V26.4S, V4.4H, V31.4H
    FMLAL V11.2S, V31.2H, V1.H[0x3]
    FMLSL V30.4S, V4.4H, V4.4H
    FMLSL V12.2S, V30.2H, V7.2H
    USDOT V23.2S, V26.8B, V14.4B[0x2]
    FMLAL V7.4S, V16.4H, V12.H[0x0]
    USMMLA V24.4S, V17.16B, V7.16B
    SMMLA V14.4S, V11.16B, V0.16B
    FMLSL2 V21.4S, V24.4H, V14.H[0x3]
    FMLSL2 V20.2S, V15.2H, V11.H[0x1]
    FMLSL2 V4.4S, V12.4H, V13.H[0x3]
    SUDOT V7.2S, V8.8B, V1.4B[0x3]
    FMLSL2 V24.4S, V0.4H, V26.4H
    USMMLA V15.4S, V13.16B, V19.16B
    SUDOT V7.2S, V18.8B, V15.4B[0x0]
    FMLAL V27.2S, V19.2H, V2.H[0x7]
    FMLAL2 V3.2S, V27.2H, V24.2H
    FMLAL2 V16.4S, V5.4H, V11.H[0x3]
    FMLAL2 V1.4S, V29.4H, V12.H[0x4]
    FMLAL2 V30.2S, V4.2H, V17.2H
    FMLSL2 V25.4S, V21.4H, V24.4H
    SMMLA V2.4S, V24.16B, V13.16B
    USMMLA V30.4S, V2.16B, V31.16B
    USDOT V12.4S, V15.16B, V9.4B[0x1]
    FMLSL V27.2S, V3.2H, V23.2H
    USMMLA V2.4S, V25.16B, V20.16B
    FMLAL2 V21.4S, V2.4H, V2.4H
    FMLAL2 V14.2S, V12.2H, V7.H[0x7]
    USDOT V15.4S, V30.16B, V31.16B
    FMLAL2 V7.2S, V2.2H, V27.2H
    USDOT V2.4S, V10.16B, V14.16B
    FMLAL2 V10.4S, V21.4H, V1.H[0x1]
    SUDOT V8.4S, V4.16B, V8.4B[0x2]
    USDOT V17.2S, V8.8B, V16.4B[0x3]
    FMLSL2 V14.2S, V17.2H, V31.2H
    USDOT V17.2S, V9.8B, V2.4B[0x1]
    FMLSL2 V23.4S, V1.4H, V7.H[0x6]
    UMMLA V8.4S, V14.16B, V17.16B
    UMMLA V16.4S, V23.16B, V23.16B
    FMLAL2 V18.2S, V15.2H, V10.H[0x4]
    SMMLA V27.4S, V18.16B, V16.16B
    UMMLA V9.4S, V26.16B, V17.16B
    FMLSL2 V17.4S, V17.4H, V15.H[0x7]
    FMLSL V18.4S, V20.4H, V2.4H
    SMMLA V7.4S, V31.16B, V17.16B
    USDOT V14.2S, V29.8B, V10.4B[0x2]
    FMLAL V1.2S, V18.2H, V23.2H
    FMLAL2 V16.4S, V15.4H, V9.H[0x2]
    SUDOT V24.2S, V18.8B, V29.4B[0x3]
    USMMLA V23.4S, V28.16B, V25.16B
    USDOT V17.4S, V2.16B, V11.4B[0x3]
    FMLAL V13.4S, V27.4H, V1.4H
    USDOT V3.4S, V2.16B, V3.16B
    SMMLA V31.4S, V16.16B, V23.16B
    SUDOT V12.4S, V5.16B, V7.4B[0x0]
    FMLSL V4.4S, V13.4H, V8.4H
    SUDOT V16.2S, V24.8B, V12.4B[0x1]
    UMMLA V26.4S, V14.16B, V3.16B
    UMMLA V17.4S, V31.16B, V31.16B
    USDOT V9.4S, V26.16B, V14.16B
    SMMLA V23.4S, V9.16B, V17.16B
    SUDOT V22.4S, V14.16B, V4.4B[0x1]
    FMLAL2 V18.4S, V22.4H, V16.4H
    FMLSL2 V31.2S, V16.2H, V22.2H
    USDOT V22.4S, V13.16B, V27.16B
    SMMLA V2.4S, V9.16B, V16.16B
    USDOT V24.2S, V27.8B, V0.4B[0x3]
    SMMLA V29.4S, V31.16B, V17.16B
    SUDOT V16.2S, V25.8B, V17.4B[0x1]
    FMLAL V31.4S, V27.4H, V2.4H
    FMLAL V13.4S, V21.4H, V6.H[0x5]
    USDOT V7.4S, V11.16B, V6.4B[0x3]
    USMMLA V27.4S, V23.16B, V22.16B
    FMLSL V8.2S, V24.2H, V1.H[0x1]
    USDOT V31.4S, V13.16B, V31.4B[0x0]
    FMLSL2 V28.2S, V8.2H, V27.2H
    SUDOT V21.2S, V29.8B, V16.4B[0x2]
    UMMLA V15.4S, V22.16B, V18.16B
    FMLAL2 V16.4S, V29.4H, V15.H[0x1]
    FMLSL V12.4S, V20.4H, V11.H[0x5]
    SUDOT V22.4S, V28.16B, V16.4B[0x3]
    USDOT V0.4S, V12.16B, V7.4B[0x0]
    FMLSL2 V29.4S, V22.4H, V22.4H
    SUDOT V8.2S, V31.8B, V21.4B[0x0]
    USMMLA V26.4S, V8.16B, V29.16B
    USDOT V6.2S, V31.8B, V11.4B[0x1]
    USDOT V31.2S, V14.8B, V17.8B
    FMLAL V14.4S, V26.4H, V18.4H
    USDOT V7.2S, V20.8B, V6.8B
    USDOT V13.2S, V28.8B, V21.4B[0x2]
    FMLAL V18.4S, V14.4H, V19.4H
    FMLSL V10.2S, V4.2H, V4.H[0x2]
    FMLSL2 V23.2S, V10.2H, V2.2H
    FMLAL2 V14.2S, V16.2H, V7.H[0x6]
    UMMLA V19.4S, V5.16B, V0.16B
    USDOT V20.2S, V14.8B, V25.8B
    USDOT V17.4S, V30.16B, V8.16B
    UMMLA V7.4S, V1.16B, V22.16B
    USDOT V2.2S, V20.8B, V0.4B[0x1]
    FMLAL V11.4S, V22.4H, V6.H[0x5]
    FMLAL2 V21.2S, V13.2H, V2.H[0x4]
    FMLSL V0.4S, V11.4H, V7.H[0x4]
    FMLSL2 V26.2S, V19.2H, V0.H[0x5]
    SMMLA V12.4S, V18.16B, V14.16B
    UMMLA V29.4S, V25.16B, V26.16B
    UMMLA V19.4S, V23.16B, V1.16B
    USDOT V13.2S, V13.8B, V12.8B
    UMMLA V23.4S, V17.16B, V21.16B
    FMLSL2 V4.2S, V23.2H, V29.2H
    FMLSL V25.4S, V23.4H, V5.4H
    SMMLA V17.4S, V25.16B, V25.16B
    FMLAL V28.2S, V19.2H, V19.2H
    FMLAL V1.2S, V5.2H, V13.H[0x3]
    FMLAL V25.2S, V1.2H, V20.2H
    FMLSL2 V14.2S, V17.2H, V21.2H
    FMLAL2 V7.4S, V4.4H, V7.H[0x5]
    FMLSL V12.2S, V9.2H, V10.2H
    FMLAL V19.2S, V12.2H, V12.2H
    FMLAL V11.4S, V15.4H, V19.4H
    FMLAL V26.2S, V11.2H, V0.H[0x0]
    FMLSL V5.4S, V25.4H, V23.4H
    FMLSL V14.4S, V26.4H, V7.4H
    FMLAL V21.2S, V5.2H, V10.2H
    SUDOT V11.2S, V8.8B, V12.4B[0x1]
    USDOT V15.4S, V18.16B, V21.4B[0x0]
    FMLSL2 V1.4S, V29.4H, V14.4H
    FMLSL2 V21.4S, V1.4H, V1.4H
    FMLSL V4.2S, V11.2H, V8.2H
    FMLSL V0.2S, V4.2H, V24.2H
    USMMLA V5.4S, V31.16B, V28.16B
    SUDOT V17.2S, V13.8B, V21.4B[0x1]
    USMMLA V20.4S, V1.16B, V0.16B
    SUBS  X12, X12, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X17, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X11, FPSR
    MOVZ  X17, #0x91, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D0
    MOVZ  X17, #0x699d, LSL #0
    MOVK  X17, #0x7fd3, LSL #16
    MOVK  X17, #0xc000, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X17, #0xa000, LSL #0
    MOVK  X17, #0xb934, LSL #16
    MOVK  X17, #0x2000, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D1
    MOVZ  X17, #0x6000, LSL #0
    MOVK  X17, #0x7fd2, LSL #16
    MOVK  X17, #0x34e8, LSL #32
    MOVK  X17, #0xfffd, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D2
    MOVZ  X17, #0x4d65, LSL #0
    MOVK  X17, #0xa5a8, LSL #16
    MOVK  X17, #0x430b, LSL #32
    MOVK  X17, #0xa5a6, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D3
    MOVZ  X17, #0xafe2, LSL #0
    MOVK  X17, #0x7fd2, LSL #16
    MOVK  X17, #0xa4f1, LSL #32
    MOVK  X17, #0xfffe, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D4
    MOVZ  X17, #0xc635, LSL #0
    MOVK  X17, #0xffc4, LSL #16
    MOVK  X17, #0x5bea, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffd8, LSL #16
    MOVK  X17, #0xe000, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D5
    MOVZ  X17, #0xbfaf, LSL #0
    MOVK  X17, #0x7fc3, LSL #16
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D6
    MOVZ  X17, #0xaa03, LSL #0
    MOVK  X17, #0xa5a3, LSL #16
    MOVK  X17, #0x9bcf, LSL #32
    MOVK  X17, #0xa5a3, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D7
    MOVZ  X17, #0x6bab, LSL #0
    MOVK  X17, #0x7fd4, LSL #16
    MOVK  X17, #0x8440, LSL #32
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D8
    MOVZ  X17, #0x49dc, LSL #0
    MOVK  X17, #0x7ffb, LSL #16
    MOVK  X17, #0x647b, LSL #32
    MOVK  X17, #0x7ffb, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X17, #0xb63e, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D9
    MOVZ  X17, #0x6a9e, LSL #0
    MOVK  X17, #0x4294, LSL #16
    MOVK  X17, #0xc455, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D10
    MOVZ  X17, #0x2000, LSL #0
    MOVK  X17, #0x7fd2, LSL #16
    MOVK  X17, #0xe000, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D11
    MOVZ  X17, #0xd330, LSL #0
    MOVK  X17, #0xfffe, LSL #16
    MOVK  X17, #0x77ee, LSL #32
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D12
    MOVZ  X17, #0xc5ff, LSL #0
    MOVK  X17, #0xffd8, LSL #16
    MOVK  X17, #0xf3fb, LSL #32
    MOVK  X17, #0x7ffe, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D13
    MOVZ  X17, #0x57ac, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x63a2, LSL #32
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X17, #0x9400, LSL #0
    MOVK  X17, #0x390d, LSL #16
    MOVK  X17, #0xa000, LSL #32
    MOVK  X17, #0xfff9, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D14
    MOVZ  X17, #0x49f3, LSL #0
    MOVK  X17, #0xffed, LSL #16
    MOVK  X17, #0x8fc6, LSL #32
    MOVK  X17, #0x7ff9, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X17, #0x4164, LSL #0
    MOVK  X17, #0x7fdb, LSL #16
    MOVK  X17, #0x31a2, LSL #32
    MOVK  X17, #0xfffa, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D15
    MOVZ  X17, #0x5e4c, LSL #0
    MOVK  X17, #0x475b, LSL #16
    MOVK  X17, #0x5a97, LSL #32
    MOVK  X17, #0x2, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X17, #0xfc08, LSL #0
    MOVK  X17, #0xbe25, LSL #16
    MOVK  X17, #0xfc08, LSL #32
    MOVK  X17, #0xbe25, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D16
    MOVZ  X17, #0x5364, LSL #0
    MOVK  X17, #0x7fcf, LSL #16
    MOVK  X17, #0xe792, LSL #32
    MOVK  X17, #0x7ffa, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D17
    MOVZ  X17, #0x1523, LSL #0
    MOVK  X17, #0x3, LSL #16
    MOVK  X17, #0xa371, LSL #32
    MOVK  X17, #0x3, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X17, #0xd973, LSL #0
    MOVK  X17, #0x3d16, LSL #16
    MOVK  X17, #0xe000, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D18
    MOVZ  X17, #0xe000, LSL #0
    MOVK  X17, #0xffd9, LSL #16
    MOVK  X17, #0xa000, LSL #32
    MOVK  X17, #0x7ffb, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D19
    MOVZ  X17, #0xd004, LSL #0
    MOVK  X17, #0x420f, LSL #16
    MOVK  X17, #0x7fe2, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X17, #0x9c5, LSL #0
    MOVK  X17, #0x1, LSL #16
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D20
    MOVZ  X17, #0x5876, LSL #0
    MOVK  X17, #0x7fda, LSL #16
    MOVK  X17, #0x20b6, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xb880, LSL #16
    MOVK  X17, #0xe000, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D21
    MOVZ  X17, #0x3b5d, LSL #0
    MOVK  X17, #0x7fff, LSL #16
    MOVK  X17, #0xb0de, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D22
    MOVZ  X17, #0xb28e, LSL #0
    MOVK  X17, #0xc54d, LSL #16
    MOVK  X17, #0xb654, LSL #32
    MOVK  X17, #0x7ff9, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X17, #0x20a0, LSL #0
    MOVK  X17, #0x1, LSL #16
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D23
    MOVZ  X17, #0x5007, LSL #0
    MOVK  X17, #0xfffd, LSL #16
    MOVK  X17, #0x2dd0, LSL #32
    MOVK  X17, #0xfffe, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D24
    MOVZ  X17, #0x1e7c, LSL #0
    MOVK  X17, #0xc8dd, LSL #16
    MOVK  X17, #0xc0f5, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D25
    MOVZ  X17, #0xaedf, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xca36, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D26
    MOVZ  X17, #0x6255, LSL #0
    MOVK  X17, #0x7fce, LSL #16
    MOVK  X17, #0x402a, LSL #32
    MOVK  X17, #0x7fcd, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X17, #0xf3f0, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D27
    MOVZ  X17, #0xa3f8, LSL #0
    MOVK  X17, #0x7fd2, LSL #16
    MOVK  X17, #0x7cba, LSL #32
    MOVK  X17, #0x7ffd, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D28
    MOVZ  X17, #0x4000, LSL #0
    MOVK  X17, #0x7fd7, LSL #16
    MOVK  X17, #0xe000, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X17, #0x8bb9, LSL #0
    MOVK  X17, #0xa5be, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D29
    MOVZ  X17, #0x5624, LSL #0
    MOVK  X17, #0xa5c6, LSL #16
    MOVK  X17, #0xfaeb, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X17, #0x2c24, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D30
    MOVZ  X17, #0x5733, LSL #0
    MOVK  X17, #0x7fdd, LSL #16
    MOVK  X17, #0xc135, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X11, D31
    MOVZ  X17, #0xaaf7, LSL #0
    MOVK  X17, #0xfff5, LSL #16
    MOVK  X17, #0x984f, LSL #32
    MOVK  X17, #0xfffe, LSL #48
    SUB  X16, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xb9a3, LSL #0
    MOVK  X2, #0x6540, LSL #16
    MOVK  X2, #0x951, LSL #32
    MOVK  X2, #0xd5fd, LSL #48
    MOVZ  X3, #0xf65e, LSL #0
    MOVK  X3, #0x7131, LSL #16
    MOVK  X3, #0x7b3, LSL #32
    MOVK  X3, #0x85c5, LSL #48
    MOVZ  X6, #0x5324, LSL #0
    MOVK  X6, #0xa553, LSL #16
    MOVK  X6, #0x154b, LSL #32
    MOVK  X6, #0x65cc, LSL #48
    MOVZ  X8, #0xd91e, LSL #0
    MOVK  X8, #0x56a2, LSL #16
    MOVK  X8, #0x105d, LSL #32
    MOVK  X8, #0x2fc0, LSL #48
    MOVZ  X9, #0x3f9d, LSL #0
    MOVK  X9, #0xf307, LSL #16
    MOVK  X9, #0x9186, LSL #32
    MOVK  X9, #0x2480, LSL #48
    MOVZ  X10, #0xc633, LSL #0
    MOVK  X10, #0x42d2, LSL #16
    MOVK  X10, #0xa410, LSL #32
    MOVK  X10, #0xf589, LSL #48
    MOVZ  X11, #0x9333, LSL #0
    MOVK  X11, #0x18df, LSL #16
    MOVK  X11, #0x50, LSL #32
    MOVK  X11, #0xfd46, LSL #48
    MOVZ  X12, #0xc566, LSL #0
    MOVK  X12, #0x6d1e, LSL #16
    MOVK  X12, #0x740c, LSL #32
    MOVK  X12, #0xe58e, LSL #48
    MOVZ  X13, #0x328d, LSL #0
    MOVK  X13, #0x6b5a, LSL #16
    MOVK  X13, #0xcc03, LSL #32
    MOVK  X13, #0xa7c, LSL #48
    MOVZ  X14, #0xa311, LSL #0
    MOVK  X14, #0xea56, LSL #16
    MOVK  X14, #0x3893, LSL #32
    MOVK  X14, #0x1966, LSL #48
    MOVZ  X15, #0xd61d, LSL #0
    MOVK  X15, #0xed1e, LSL #16
    MOVK  X15, #0x66b, LSL #32
    MOVK  X15, #0xa637, LSL #48
    MOVZ  X16, #0x4add, LSL #0
    MOVK  X16, #0x4dcf, LSL #16
    MOVK  X16, #0x7984, LSL #32
    MOVK  X16, #0xe0f, LSL #48
    MOVZ  X17, #0x1efd, LSL #0
    MOVK  X17, #0x4a1f, LSL #16
    MOVK  X17, #0xb7ae, LSL #32
    MOVK  X17, #0x2943, LSL #48
    MOVZ  X18, #0xf823, LSL #0
    MOVK  X18, #0xa2c8, LSL #16
    MOVK  X18, #0x6747, LSL #32
    MOVK  X18, #0xf, LSL #48
    MOVZ  X19, #0xc291, LSL #0
    MOVK  X19, #0x94a6, LSL #16
    MOVK  X19, #0xcd3f, LSL #32
    MOVK  X19, #0x3226, LSL #48
    MOVZ  X20, #0x66d2, LSL #0
    MOVK  X20, #0xf17e, LSL #16
    MOVK  X20, #0x8e30, LSL #32
    MOVK  X20, #0x7cd, LSL #48
    MOVZ  X21, #0x1990, LSL #0
    MOVK  X21, #0x6d7f, LSL #16
    MOVK  X21, #0x960b, LSL #32
    MOVK  X21, #0xe03c, LSL #48
    MOVZ  X22, #0xdd72, LSL #0
    MOVK  X22, #0x7ab0, LSL #16
    MOVK  X22, #0xf2bb, LSL #32
    MOVK  X22, #0x768d, LSL #48
    MOVZ  X23, #0x10e6, LSL #0
    MOVK  X23, #0x2a21, LSL #16
    MOVK  X23, #0x92fd, LSL #32
    MOVK  X23, #0xc6d5, LSL #48
    MOVZ  X24, #0x9b5d, LSL #0
    MOVK  X24, #0xed99, LSL #16
    MOVK  X24, #0x27d5, LSL #32
    MOVK  X24, #0xfc9a, LSL #48
    MOVZ  X25, #0x2b15, LSL #0
    MOVK  X25, #0x91f5, LSL #16
    MOVK  X25, #0x880c, LSL #32
    MOVK  X25, #0xd11f, LSL #48
    MOVZ  X26, #0x3dcb, LSL #0
    MOVK  X26, #0x2859, LSL #16
    MOVK  X26, #0xfb7a, LSL #32
    MOVK  X26, #0x1e5c, LSL #48
    MOVZ  X27, #0xe665, LSL #0
    MOVK  X27, #0x752b, LSL #16
    MOVK  X27, #0x99f1, LSL #32
    MOVK  X27, #0xc7ad, LSL #48
    MOVZ  X28, #0x6b0, LSL #0
    MOVK  X28, #0xa59f, LSL #16
    MOVK  X28, #0x1f82, LSL #32
    MOVK  X28, #0x4c9e, LSL #48
    MOVZ  X29, #0x9b6a, LSL #0
    MOVK  X29, #0x5b53, LSL #16
    MOVK  X29, #0x7443, LSL #32
    MOVK  X29, #0xe384, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X6
    FMOV  D3, X2
    FMOV  V3.D[1], X26
    FMOV  D4, X14
    FMOV  V4.D[1], X19
    FMOV  D5, X24
    FMOV  V5.D[1], X29
    FMOV  D6, X29
    FMOV  V6.D[1], X22
    FMOV  D7, X19
    FMOV  V7.D[1], X16
    FMOV  D8, X9
    FMOV  V8.D[1], X6
    FMOV  D9, X13
    FMOV  V9.D[1], X23
    FMOV  D10, X6
    FMOV  V10.D[1], X22
    FMOV  D11, X27
    FMOV  V11.D[1], X2
    FMOV  D12, X22
    FMOV  V12.D[1], X14
    FMOV  D13, X2
    FMOV  V13.D[1], X2
    FMOV  D14, X29
    FMOV  V14.D[1], X20
    FMOV  D15, X6
    FMOV  V15.D[1], X2
    FMOV  D16, X6
    FMOV  V16.D[1], X20
    FMOV  D17, X15
    FMOV  V17.D[1], X20
    FMOV  D18, X26
    FMOV  V18.D[1], X13
    FMOV  D19, X24
    FMOV  V19.D[1], X9
    FMOV  D20, X13
    FMOV  V20.D[1], X8
    FMOV  D21, X6
    FMOV  V21.D[1], X26
    FMOV  D22, X9
    FMOV  V22.D[1], X18
    FMOV  D23, X11
    FMOV  V23.D[1], X19
    FMOV  D24, X14
    FMOV  V24.D[1], X13
    FMOV  D25, X13
    FMOV  V25.D[1], X19
    FMOV  D26, X24
    FMOV  V26.D[1], X24
    FMOV  D27, X12
    FMOV  V27.D[1], X28
    FMOV  D28, X13
    FMOV  V28.D[1], X11
    FMOV  D29, X20
    FMOV  V29.D[1], X2
    FMOV  D30, X8
    FMOV  V30.D[1], X19
    FMOV  D31, X15
    FMOV  V31.D[1], X22
    MOVZ  X15, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_10:
    USDOT V28.2S, V25.8B, V23.4B[0x1]
    FMLSL2 V30.4S, V5.4H, V31.4H
    FMLSL V5.4S, V28.4H, V15.H[0x7]
    FMLAL V15.4S, V26.4H, V5.H[0x0]
    USDOT V5.4S, V15.16B, V15.4B[0x3]
    FMLAL V23.2S, V5.2H, V5.2H
    FMLAL2 V20.4S, V7.4H, V29.4H
    FMLSL2 V15.2S, V27.2H, V1.H[0x5]
    FMLSL2 V25.4S, V15.4H, V15.H[0x5]
    FMLAL2 V8.4S, V30.4H, V0.H[0x4]
    USDOT V23.4S, V25.16B, V25.4B[0x2]
    USDOT V17.4S, V23.16B, V8.16B
    USDOT V25.4S, V20.16B, V17.16B
    FMLAL2 V19.4S, V22.4H, V6.H[0x1]
    FMLAL2 V0.2S, V4.2H, V11.H[0x1]
    USDOT V5.4S, V13.16B, V23.4B[0x2]
    SMMLA V21.4S, V15.16B, V27.16B
    FMLAL2 V30.2S, V25.2H, V26.2H
    USDOT V30.4S, V24.16B, V1.16B
    FMLAL V31.4S, V16.4H, V12.H[0x1]
    FMLAL V20.2S, V26.2H, V16.2H
    FMLSL2 V8.4S, V2.4H, V19.4H
    SUDOT V17.4S, V23.16B, V8.4B[0x1]
    SUDOT V11.4S, V22.16B, V23.4B[0x2]
    SMMLA V13.4S, V0.16B, V2.16B
    USDOT V25.4S, V5.16B, V21.4B[0x1]
    USDOT V8.4S, V5.16B, V8.4B[0x3]
    USDOT V15.4S, V29.16B, V16.4B[0x3]
    FMLSL V2.2S, V30.2H, V8.H[0x0]
    FMLSL V19.4S, V17.4H, V6.H[0x3]
    USMMLA V0.4S, V25.16B, V2.16B
    USMMLA V17.4S, V0.16B, V19.16B
    SUDOT V4.4S, V16.16B, V15.4B[0x3]
    USDOT V7.2S, V31.8B, V15.4B[0x2]
    USDOT V2.4S, V15.16B, V13.4B[0x0]
    FMLSL2 V30.2S, V17.2H, V11.H[0x1]
    FMLSL V29.2S, V21.2H, V30.2H
    USDOT V26.2S, V29.8B, V29.4B[0x1]
    FMLSL2 V15.2S, V2.2H, V18.2H
    USMMLA V12.4S, V7.16B, V2.16B
    USMMLA V30.4S, V4.16B, V12.16B
    FMLAL V7.2S, V15.2H, V2.H[0x6]
    USDOT V25.2S, V15.8B, V30.4B[0x0]
    USDOT V8.2S, V26.8B, V10.4B[0x3]
    USDOT V10.2S, V22.8B, V7.8B
    USDOT V22.2S, V8.8B, V14.4B[0x3]
    FMLAL2 V22.2S, V10.2H, V10.H[0x1]
    FMLSL2 V30.4S, V25.4H, V28.4H
    SMMLA V7.4S, V2.16B, V6.16B
    USDOT V11.2S, V22.8B, V13.8B
    FMLAL2 V2.2S, V3.2H, V7.2H
    USMMLA V4.4S, V6.16B, V2.16B
    FMLSL V21.4S, V24.4H, V11.H[0x3]
    FMLAL V12.2S, V18.2H, V10.2H
    USDOT V26.2S, V7.8B, V30.4B[0x1]
    USDOT V31.4S, V26.16B, V12.4B[0x2]
    FMLAL2 V24.2S, V18.2H, V29.2H
    UMMLA V2.4S, V30.16B, V23.16B
    FMLAL V3.2S, V2.2H, V4.H[0x0]
    SUDOT V22.4S, V24.16B, V23.4B[0x2]
    FMLAL V13.4S, V31.4H, V12.4H
    FMLAL2 V15.2S, V7.2H, V13.H[0x7]
    SUDOT V2.4S, V27.16B, V22.4B[0x0]
    SUDOT V30.2S, V15.8B, V15.4B[0x1]
    FMLSL V22.4S, V21.4H, V8.4H
    USDOT V8.4S, V15.16B, V22.4B[0x1]
    USDOT V26.4S, V30.16B, V2.4B[0x2]
    FMLAL2 V29.4S, V3.4H, V27.4H
    USMMLA V2.4S, V26.16B, V26.16B
    FMLSL V22.2S, V29.2H, V8.2H
    SUDOT V30.2S, V14.8B, V15.4B[0x2]
    FMLSL2 V26.4S, V8.4H, V8.H[0x0]
    FMLAL2 V20.2S, V10.2H, V28.2H
    USDOT V24.4S, V11.16B, V11.4B[0x2]
    FMLAL V7.4S, V22.4H, V15.H[0x0]
    SUDOT V31.2S, V23.8B, V1.4B[0x3]
    USDOT V12.2S, V16.8B, V8.4B[0x1]
    SMMLA V27.4S, V11.16B, V13.16B
    UMMLA V14.4S, V26.16B, V10.16B
    USDOT V3.2S, V30.8B, V14.8B
    FMLAL V31.4S, V0.4H, V2.H[0x6]
    SUDOT V28.4S, V27.16B, V24.4B[0x1]
    USDOT V18.4S, V31.16B, V3.4B[0x2]
    FMLAL V29.4S, V7.4H, V7.4H
    FMLSL V14.2S, V10.2H, V12.H[0x1]
    FMLAL2 V27.2S, V6.2H, V10.H[0x6]
    FMLSL V3.4S, V20.4H, V10.H[0x5]
    FMLAL2 V6.4S, V28.4H, V17.4H
    USDOT V26.2S, V3.8B, V14.8B
    FMLSL V13.2S, V18.2H, V0.H[0x7]
    FMLAL2 V18.2S, V6.2H, V6.2H
    FMLAL2 V31.4S, V18.4H, V4.H[0x4]
    FMLAL V21.2S, V14.2H, V8.H[0x5]
    FMLAL V20.2S, V29.2H, V13.H[0x3]
    FMLAL2 V8.4S, V10.4H, V4.4H
    SUDOT V14.4S, V9.16B, V7.4B[0x2]
    FMLSL V1.4S, V14.4H, V14.H[0x1]
    FMLAL V30.4S, V20.4H, V21.4H
    SMMLA V28.4S, V26.16B, V8.16B
    UMMLA V31.4S, V1.16B, V1.16B
    USMMLA V4.4S, V29.16B, V28.16B
    UMMLA V3.4S, V27.16B, V27.16B
    SMMLA V17.4S, V16.16B, V31.16B
    FMLSL V15.2S, V17.2H, V9.H[0x1]
    FMLSL V17.4S, V30.4H, V4.4H
    FMLSL V2.2S, V17.2H, V28.2H
    USDOT V11.2S, V15.8B, V25.4B[0x3]
    USDOT V20.2S, V3.8B, V11.8B
    FMLAL V27.4S, V27.4H, V0.4H
    FMLSL V7.4S, V1.4H, V10.H[0x4]
    FMLSL2 V9.2S, V15.2H, V12.2H
    FMLSL V16.2S, V19.2H, V10.2H
    FMLAL2 V0.2S, V3.2H, V7.H[0x1]
    FMLSL V8.4S, V23.4H, V7.H[0x4]
    FMLSL V26.2S, V10.2H, V3.H[0x7]
    FMLAL V28.4S, V7.4H, V9.4H
    FMLSL V11.4S, V17.4H, V14.H[0x4]
    FMLSL2 V2.2S, V5.2H, V5.H[0x2]
    USDOT V31.2S, V2.8B, V16.8B
    FMLAL V3.2S, V8.2H, V8.2H
    USMMLA V16.4S, V27.16B, V5.16B
    FMLAL2 V2.2S, V9.2H, V1.2H
    USDOT V15.2S, V28.8B, V11.4B[0x1]
    SUDOT V4.4S, V26.16B, V26.4B[0x0]
    USDOT V23.4S, V0.16B, V11.16B
    FMLSL V21.2S, V31.2H, V31.2H
    FMLAL V25.4S, V23.4H, V22.4H
    USDOT V12.2S, V25.8B, V19.4B[0x1]
    USDOT V3.2S, V6.8B, V25.4B[0x2]
    FMLSL V28.2S, V28.2H, V2.2H
    USDOT V7.2S, V20.8B, V4.8B
    FMLSL V11.2S, V7.2H, V3.2H
    FMLAL2 V7.4S, V15.4H, V7.H[0x2]
    USDOT V24.4S, V21.16B, V28.4B[0x3]
    FMLSL2 V10.2S, V9.2H, V19.2H
    USMMLA V0.4S, V12.16B, V1.16B
    USMMLA V31.4S, V10.16B, V7.16B
    FMLAL V12.2S, V7.2H, V5.2H
    SUDOT V5.4S, V11.16B, V31.4B[0x1]
    FMLAL2 V11.4S, V24.4H, V0.4H
    FMLAL2 V0.2S, V12.2H, V12.2H
    FMLSL2 V0.4S, V24.4H, V7.4H
    FMLAL V26.4S, V0.4H, V4.H[0x6]
    FMLSL V31.2S, V5.2H, V0.2H
    SUDOT V6.4S, V31.16B, V31.4B[0x3]
    FMLSL2 V23.2S, V16.2H, V26.2H
    FMLAL2 V2.4S, V11.4H, V6.4H
    FMLAL V20.2S, V7.2H, V2.H[0x1]
    FMLAL V8.2S, V9.2H, V11.2H
    SUDOT V6.2S, V13.8B, V4.4B[0x3]
    USDOT V12.2S, V29.8B, V17.4B[0x1]
    FMLSL V26.4S, V12.4H, V1.H[0x6]
    FMLSL2 V16.4S, V7.4H, V25.4H
    FMLSL V4.4S, V31.4H, V16.4H
    USDOT V16.2S, V16.8B, V19.4B[0x0]
    FMLAL V12.4S, V25.4H, V26.4H
    FMLSL V7.4S, V15.4H, V11.4H
    FMLSL2 V24.2S, V5.2H, V0.H[0x6]
    FMLAL V5.2S, V28.2H, V24.2H
    FMLSL2 V11.4S, V11.4H, V20.4H
    USDOT V1.4S, V7.16B, V8.4B[0x2]
    SUDOT V7.2S, V11.8B, V28.4B[0x0]
    SUDOT V10.2S, V12.8B, V16.4B[0x3]
    USMMLA V15.4S, V31.16B, V23.16B
    SUDOT V17.4S, V6.16B, V19.4B[0x1]
    SMMLA V8.4S, V4.16B, V7.16B
    USDOT V20.2S, V5.8B, V17.8B
    FMLSL V23.2S, V6.2H, V1.H[0x6]
    USDOT V28.4S, V15.16B, V4.16B
    USDOT V13.2S, V5.8B, V5.4B[0x2]
    USDOT V29.4S, V13.16B, V13.16B
    FMLSL2 V0.2S, V29.2H, V8.2H
    FMLAL V25.2S, V6.2H, V21.2H
    USDOT V4.2S, V12.8B, V23.4B[0x1]
    FMLAL2 V1.2S, V28.2H, V10.2H
    UMMLA V21.4S, V20.16B, V1.16B
    FMLAL V2.4S, V25.4H, V4.H[0x0]
    FMLSL2 V19.2S, V0.2H, V29.2H
    SUDOT V7.2S, V25.8B, V11.4B[0x3]
    USDOT V17.2S, V7.8B, V21.8B
    FMLSL V24.4S, V19.4H, V2.4H
    FMLAL V6.4S, V27.4H, V8.H[0x1]
    USDOT V26.2S, V17.8B, V17.8B
    USDOT V27.2S, V2.8B, V11.4B[0x1]
    FMLSL2 V11.2S, V22.2H, V27.2H
    USDOT V7.2S, V22.8B, V22.4B[0x2]
    UMMLA V19.4S, V0.16B, V8.16B
    FMLSL2 V8.2S, V19.2H, V30.2H
    UMMLA V25.4S, V7.16B, V4.16B
    SUDOT V0.4S, V29.16B, V11.4B[0x0]
    UMMLA V18.4S, V15.16B, V4.16B
    FMLAL2 V21.2S, V8.2H, V2.2H
    UMMLA V31.4S, V18.16B, V30.16B
    FMLSL V23.2S, V21.2H, V0.H[0x5]
    UMMLA V15.4S, V24.16B, V7.16B
    SUDOT V4.4S, V11.16B, V5.4B[0x3]
    FMLAL V26.2S, V6.2H, V10.H[0x3]
    SMMLA V6.4S, V26.16B, V31.16B
    FMLSL V7.4S, V16.4H, V4.4H
    USMMLA V19.4S, V4.16B, V23.16B
    SUBS  X15, X15, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_10
    MOVZ  X26, #0xb9a3, LSL #0
    MOVK  X26, #0x6540, LSL #16
    MOVK  X26, #0x951, LSL #32
    MOVK  X26, #0xd5fd, LSL #48
    SUB  X21, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xf65e, LSL #0
    MOVK  X26, #0x7131, LSL #16
    MOVK  X26, #0x7b3, LSL #32
    MOVK  X26, #0x85c5, LSL #48
    SUB  X21, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x5324, LSL #0
    MOVK  X26, #0xa553, LSL #16
    MOVK  X26, #0x154b, LSL #32
    MOVK  X26, #0x65cc, LSL #48
    SUB  X21, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xd91e, LSL #0
    MOVK  X26, #0x56a2, LSL #16
    MOVK  X26, #0x105d, LSL #32
    MOVK  X26, #0x2fc0, LSL #48
    SUB  X21, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x3f9d, LSL #0
    MOVK  X26, #0xf307, LSL #16
    MOVK  X26, #0x9186, LSL #32
    MOVK  X26, #0x2480, LSL #48
    SUB  X21, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xc633, LSL #0
    MOVK  X26, #0x42d2, LSL #16
    MOVK  X26, #0xa410, LSL #32
    MOVK  X26, #0xf589, LSL #48
    SUB  X21, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x9333, LSL #0
    MOVK  X26, #0x18df, LSL #16
    MOVK  X26, #0x50, LSL #32
    MOVK  X26, #0xfd46, LSL #48
    SUB  X21, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x328d, LSL #0
    MOVK  X26, #0x6b5a, LSL #16
    MOVK  X26, #0xcc03, LSL #32
    MOVK  X26, #0xa7c, LSL #48
    SUB  X21, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xa311, LSL #0
    MOVK  X26, #0xea56, LSL #16
    MOVK  X26, #0x3893, LSL #32
    MOVK  X26, #0x1966, LSL #48
    SUB  X21, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x4add, LSL #0
    MOVK  X26, #0x4dcf, LSL #16
    MOVK  X26, #0x7984, LSL #32
    MOVK  X26, #0xe0f, LSL #48
    SUB  X21, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x1efd, LSL #0
    MOVK  X26, #0x4a1f, LSL #16
    MOVK  X26, #0xb7ae, LSL #32
    MOVK  X26, #0x2943, LSL #48
    SUB  X21, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xf823, LSL #0
    MOVK  X26, #0xa2c8, LSL #16
    MOVK  X26, #0x6747, LSL #32
    MOVK  X26, #0xf, LSL #48
    SUB  X21, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xc291, LSL #0
    MOVK  X26, #0x94a6, LSL #16
    MOVK  X26, #0xcd3f, LSL #32
    MOVK  X26, #0x3226, LSL #48
    SUB  X21, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x66d2, LSL #0
    MOVK  X26, #0xf17e, LSL #16
    MOVK  X26, #0x8e30, LSL #32
    MOVK  X26, #0x7cd, LSL #48
    SUB  X21, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xdd72, LSL #0
    MOVK  X26, #0x7ab0, LSL #16
    MOVK  X26, #0xf2bb, LSL #32
    MOVK  X26, #0x768d, LSL #48
    SUB  X21, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x10e6, LSL #0
    MOVK  X26, #0x2a21, LSL #16
    MOVK  X26, #0x92fd, LSL #32
    MOVK  X26, #0xc6d5, LSL #48
    SUB  X21, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x9b5d, LSL #0
    MOVK  X26, #0xed99, LSL #16
    MOVK  X26, #0x27d5, LSL #32
    MOVK  X26, #0xfc9a, LSL #48
    SUB  X21, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x2b15, LSL #0
    MOVK  X26, #0x91f5, LSL #16
    MOVK  X26, #0x880c, LSL #32
    MOVK  X26, #0xd11f, LSL #48
    SUB  X21, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0xe665, LSL #0
    MOVK  X26, #0x752b, LSL #16
    MOVK  X26, #0x99f1, LSL #32
    MOVK  X26, #0xc7ad, LSL #48
    SUB  X21, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x6b0, LSL #0
    MOVK  X26, #0xa59f, LSL #16
    MOVK  X26, #0x1f82, LSL #32
    MOVK  X26, #0x4c9e, LSL #48
    SUB  X21, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X26, #0x9b6a, LSL #0
    MOVK  X26, #0x5b53, LSL #16
    MOVK  X26, #0x7443, LSL #32
    MOVK  X26, #0xe384, LSL #48
    SUB  X21, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X26, FPSR
    MOVZ  X21, #0x91, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X21, #0x4901, LSL #0
    MOVK  X21, #0xba05, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D0
    MOVZ  X21, #0xbfe2, LSL #0
    MOVK  X21, #0xffe3, LSL #16
    MOVK  X21, #0x4d61, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D1
    MOVZ  X21, #0x9b6a, LSL #0
    MOVK  X21, #0x5b53, LSL #16
    MOVK  X21, #0x6000, LSL #32
    MOVK  X21, #0xfffa, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X21, #0xc338, LSL #0
    MOVK  X21, #0xcd00, LSL #16
    MOVK  X21, #0xe000, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D2
    MOVZ  X21, #0x2d89, LSL #0
    MOVK  X21, #0x7fd6, LSL #16
    MOVK  X21, #0x24e9, LSL #32
    MOVK  X21, #0x7fd7, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D3
    MOVZ  X21, #0x16c4, LSL #0
    MOVK  X21, #0xc72b, LSL #16
    MOVK  X21, #0x100e, LSL #32
    MOVK  X21, #0xfffa, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D4
    MOVZ  X21, #0x6db7, LSL #0
    MOVK  X21, #0xea5f, LSL #16
    MOVK  X21, #0x7de4, LSL #32
    MOVK  X21, #0xfffc, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D5
    MOVZ  X21, #0x9933, LSL #0
    MOVK  X21, #0x7fdd, LSL #16
    MOVK  X21, #0x6724, LSL #32
    MOVK  X21, #0xfffd, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X21, #0xa000, LSL #0
    MOVK  X21, #0xfffd, LSL #16
    MOVK  X21, #0xe000, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D6
    MOVZ  X21, #0xf6b3, LSL #0
    MOVK  X21, #0xfffc, LSL #16
    MOVK  X21, #0xd2da, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X21, #0x8000, LSL #0
    MOVK  X21, #0x7ffc, LSL #16
    MOVK  X21, #0xe000, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D7
    MOVZ  X21, #0x6c2d, LSL #0
    MOVK  X21, #0x7ff8, LSL #16
    MOVK  X21, #0x28c8, LSL #32
    MOVK  X21, #0xfffd, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D8
    MOVZ  X21, #0xa9b3, LSL #0
    MOVK  X21, #0xffed, LSL #16
    MOVK  X21, #0xd9e, LSL #32
    MOVK  X21, #0xfffe, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D9
    MOVZ  X21, #0xc000, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0xe000, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D10
    MOVZ  X21, #0xeda1, LSL #0
    MOVK  X21, #0xc882, LSL #16
    MOVK  X21, #0x7521, LSL #32
    MOVK  X21, #0xffd4, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D11
    MOVZ  X21, #0xb7d7, LSL #0
    MOVK  X21, #0x7fdc, LSL #16
    MOVK  X21, #0x19b2, LSL #32
    MOVK  X21, #0x7ffd, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X21, #0xe578, LSL #0
    MOVK  X21, #0xc028, LSL #16
    MOVK  X21, #0x6000, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D12
    MOVZ  X21, #0x55cc, LSL #0
    MOVK  X21, #0x7ab2, LSL #16
    MOVK  X21, #0x131b, LSL #32
    MOVK  X21, #0xfffc, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D13
    MOVZ  X21, #0x402c, LSL #0
    MOVK  X21, #0x6542, LSL #16
    MOVK  X21, #0xaa56, LSL #32
    MOVK  X21, #0xd5fc, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D14
    MOVZ  X21, #0x55a0, LSL #0
    MOVK  X21, #0x5b7e, LSL #16
    MOVK  X21, #0x8afb, LSL #32
    MOVK  X21, #0xe386, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X21, #0xfe59, LSL #0
    MOVK  X21, #0x1, LSL #16
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D15
    MOVZ  X21, #0x5c5d, LSL #0
    MOVK  X21, #0xffe6, LSL #16
    MOVK  X21, #0x4aa5, LSL #32
    MOVK  X21, #0x7ffb, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D16
    MOVZ  X21, #0x965a, LSL #0
    MOVK  X21, #0xffe6, LSL #16
    MOVK  X21, #0x4297, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D17
    MOVZ  X21, #0x8265, LSL #0
    MOVK  X21, #0xed1c, LSL #16
    MOVK  X21, #0xd9d6, LSL #32
    MOVK  X21, #0xfff6, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D18
    MOVZ  X21, #0x7efb, LSL #0
    MOVK  X21, #0x48a7, LSL #16
    MOVK  X21, #0xe000, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D19
    MOVZ  X21, #0x799, LSL #0
    MOVK  X21, #0x7ff7, LSL #16
    MOVK  X21, #0xe6a7, LSL #32
    MOVK  X21, #0x1, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D20
    MOVZ  X21, #0xcd78, LSL #0
    MOVK  X21, #0x7ffb, LSL #16
    MOVK  X21, #0xd4fb, LSL #32
    MOVK  X21, #0x7ffd, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D21
    MOVZ  X21, #0x2c7, LSL #0
    MOVK  X21, #0x7fdb, LSL #16
    MOVK  X21, #0x4000, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D22
    MOVZ  X21, #0x4000, LSL #0
    MOVK  X21, #0xfffc, LSL #16
    MOVK  X21, #0x6000, LSL #32
    MOVK  X21, #0xfffa, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D23
    MOVZ  X21, #0xd756, LSL #0
    MOVK  X21, #0xffda, LSL #16
    MOVK  X21, #0xa47, LSL #32
    MOVK  X21, #0xffd6, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X21, #0x43c4, LSL #0
    MOVK  X21, #0x3b05, LSL #16
    MOVK  X21, #0xe000, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D24
    MOVZ  X21, #0x2000, LSL #0
    MOVK  X21, #0x7fe2, LSL #16
    MOVK  X21, #0x6000, LSL #32
    MOVK  X21, #0x7fd3, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D25
    MOVZ  X21, #0x5f5e, LSL #0
    MOVK  X21, #0x7fe2, LSL #16
    MOVK  X21, #0xf5a2, LSL #32
    MOVK  X21, #0x7ffb, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D26
    MOVZ  X21, #0x7277, LSL #0
    MOVK  X21, #0x7fdb, LSL #16
    MOVK  X21, #0xb8b9, LSL #32
    MOVK  X21, #0xfffa, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D27
    MOVZ  X21, #0xf6b2, LSL #0
    MOVK  X21, #0x6d21, LSL #16
    MOVK  X21, #0xd902, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D28
    MOVZ  X21, #0x164c, LSL #0
    MOVK  X21, #0xffd1, LSL #16
    MOVK  X21, #0x8bae, LSL #32
    MOVK  X21, #0x7ffb, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X21, #0xa240, LSL #0
    MOVK  X21, #0x3546, LSL #16
    MOVK  X21, #0xa000, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D29
    MOVZ  X21, #0x7172, LSL #0
    MOVK  X21, #0xffe0, LSL #16
    MOVK  X21, #0x614, LSL #32
    MOVK  X21, #0x7ffb, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X21, #0xe000, LSL #0
    MOVK  X21, #0xbaea, LSL #16
    MOVK  X21, #0xa000, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D30
    MOVZ  X21, #0x35fc, LSL #0
    MOVK  X21, #0x7ff8, LSL #16
    MOVK  X21, #0xf5, LSL #32
    MOVK  X21, #0xffd5, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X26, D31
    MOVZ  X21, #0x6b6, LSL #0
    MOVK  X21, #0xed5e, LSL #16
    MOVK  X21, #0x16f5, LSL #32
    MOVK  X21, #0x1, LSL #48
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X22
    FMOV  D1, X24
    FMOV  V1.D[1], X9
    FMOV  D2, X28
    FMOV  V2.D[1], X6
    FMOV  D3, X23
    FMOV  V3.D[1], X17
    FMOV  D4, X19
    FMOV  V4.D[1], X26
    FMOV  D5, X20
    FMOV  V5.D[1], X6
    FMOV  D6, X29
    FMOV  V6.D[1], X12
    FMOV  D7, X22
    FMOV  V7.D[1], X27
    FMOV  D8, X25
    FMOV  V8.D[1], X17
    FMOV  D9, X13
    FMOV  V9.D[1], X20
    FMOV  D10, X13
    FMOV  V10.D[1], X13
    FMOV  D11, X28
    FMOV  V11.D[1], X18
    FMOV  D12, X3
    FMOV  V12.D[1], X17
    FMOV  D13, X21
    FMOV  V13.D[1], X12
    FMOV  D14, X21
    FMOV  V14.D[1], X12
    FMOV  D15, X3
    FMOV  V15.D[1], X15
    FMOV  D16, X6
    FMOV  V16.D[1], X20
    FMOV  D17, X10
    FMOV  V17.D[1], X19
    FMOV  D18, X20
    FMOV  V18.D[1], X2
    FMOV  D19, X6
    FMOV  V19.D[1], X23
    FMOV  D20, X12
    FMOV  V20.D[1], X18
    FMOV  D21, X13
    FMOV  V21.D[1], X15
    FMOV  D22, X9
    FMOV  V22.D[1], X6
    FMOV  D23, X26
    FMOV  V23.D[1], X20
    FMOV  D24, X24
    FMOV  V24.D[1], X22
    FMOV  D25, X24
    FMOV  V25.D[1], X21
    FMOV  D26, X8
    FMOV  V26.D[1], X9
    FMOV  D27, X24
    FMOV  V27.D[1], X15
    FMOV  D28, X28
    FMOV  V28.D[1], X25
    FMOV  D29, X8
    FMOV  V29.D[1], X18
    FMOV  D30, X15
    FMOV  V30.D[1], X13
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X22, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_11:
    USDOT V18.4S, V24.16B, V24.16B
    FMLSL2 V22.4S, V18.4H, V25.4H
    FMLAL2 V17.4S, V30.4H, V12.H[0x1]
    FMLSL2 V10.4S, V26.4H, V30.4H
    FMLAL V13.2S, V23.2H, V7.2H
    FMLSL V9.4S, V13.4H, V13.H[0x5]
    FMLSL V15.2S, V7.2H, V15.2H
    FMLSL2 V17.4S, V29.4H, V9.H[0x4]
    FMLSL2 V10.2S, V16.2H, V15.2H
    FMLAL V3.2S, V22.2H, V22.2H
    SUDOT V12.2S, V24.8B, V28.4B[0x1]
    SUDOT V4.4S, V28.16B, V11.4B[0x3]
    USMMLA V25.4S, V3.16B, V12.16B
    USDOT V11.4S, V10.16B, V25.16B
    USDOT V6.4S, V17.16B, V17.4B[0x0]
    FMLAL V12.4S, V6.4H, V15.H[0x4]
    FMLSL2 V26.4S, V23.4H, V11.4H
    USDOT V15.2S, V4.8B, V26.8B
    USDOT V25.4S, V15.16B, V11.16B
    UMMLA V4.4S, V25.16B, V10.16B
    USMMLA V28.4S, V4.16B, V27.16B
    USDOT V15.2S, V5.8B, V28.4B[0x1]
    USDOT V4.2S, V31.8B, V12.8B
    FMLSL2 V11.4S, V18.4H, V14.H[0x3]
    USMMLA V12.4S, V3.16B, V1.16B
    FMLSL V18.2S, V7.2H, V5.2H
    SUDOT V3.4S, V27.16B, V15.4B[0x1]
    FMLAL2 V26.4S, V29.4H, V8.H[0x0]
    FMLSL V23.4S, V12.4H, V1.4H
    FMLAL V25.2S, V12.2H, V15.H[0x1]
    FMLSL2 V27.4S, V25.4H, V12.4H
    FMLSL2 V1.4S, V9.4H, V9.H[0x6]
    SUDOT V31.2S, V8.8B, V21.4B[0x3]
    USDOT V17.2S, V31.8B, V27.4B[0x2]
    USMMLA V7.4S, V11.16B, V3.16B
    FMLAL2 V24.4S, V1.4H, V7.H[0x1]
    SUDOT V5.4S, V4.16B, V16.4B[0x0]
    FMLAL V21.4S, V1.4H, V12.H[0x2]
    UMMLA V16.4S, V22.16B, V20.16B
    USMMLA V26.4S, V24.16B, V0.16B
    FMLAL2 V10.2S, V21.2H, V4.2H
    USDOT V14.4S, V1.16B, V4.16B
    FMLAL V4.2S, V23.2H, V12.2H
    UMMLA V6.4S, V18.16B, V26.16B
    SMMLA V25.4S, V3.16B, V5.16B
    USDOT V9.4S, V16.16B, V14.16B
    FMLSL V29.4S, V4.4H, V4.4H
    USDOT V5.4S, V9.16B, V6.16B
    USDOT V26.2S, V25.8B, V17.8B
    SUDOT V3.4S, V29.16B, V3.4B[0x1]
    SMMLA V28.4S, V3.16B, V15.16B
    FMLAL V9.4S, V10.4H, V10.H[0x1]
    FMLSL2 V1.2S, V19.2H, V9.H[0x7]
    FMLAL V27.2S, V17.2H, V28.2H
    FMLSL2 V7.2S, V8.2H, V29.2H
    FMLAL2 V9.4S, V5.4H, V23.4H
    FMLSL V21.4S, V1.4H, V27.4H
    FMLSL2 V8.4S, V9.4H, V12.H[0x3]
    SUDOT V17.4S, V1.16B, V21.4B[0x2]
    SUDOT V9.2S, V8.8B, V16.4B[0x0]
    UMMLA V19.4S, V7.16B, V25.16B
    UMMLA V22.4S, V26.16B, V9.16B
    FMLSL2 V28.2S, V19.2H, V6.2H
    SUDOT V4.2S, V31.8B, V12.4B[0x1]
    USDOT V15.2S, V22.8B, V28.8B
    SMMLA V8.4S, V15.16B, V28.16B
    UMMLA V22.4S, V8.16B, V9.16B
    FMLSL2 V8.4S, V26.4H, V2.4H
    FMLAL2 V9.4S, V2.4H, V4.H[0x0]
    FMLAL2 V3.2S, V8.2H, V15.H[0x2]
    USMMLA V1.4S, V25.16B, V6.16B
    SMMLA V31.4S, V17.16B, V17.16B
    FMLAL2 V7.4S, V31.4H, V19.4H
    FMLSL2 V6.2S, V17.2H, V9.2H
    SUDOT V4.2S, V14.8B, V7.4B[0x0]
    FMLSL V28.2S, V4.2H, V9.H[0x4]
    FMLAL2 V15.2S, V6.2H, V28.2H
    USMMLA V9.4S, V11.16B, V1.16B
    FMLAL2 V28.4S, V9.4H, V14.H[0x6]
    FMLAL2 V4.4S, V22.4H, V4.H[0x1]
    SMMLA V12.4S, V4.16B, V3.16B
    FMLSL V3.4S, V28.4H, V15.4H
    FMLAL V31.2S, V23.2H, V5.2H
    FMLSL2 V22.4S, V29.4H, V9.H[0x2]
    FMLAL2 V9.4S, V1.4H, V9.H[0x5]
    FMLSL V14.2S, V29.2H, V21.2H
    FMLSL V6.4S, V0.4H, V13.4H
    SUDOT V15.2S, V31.8B, V5.4B[0x3]
    SUDOT V16.4S, V17.16B, V11.4B[0x1]
    SUDOT V20.4S, V26.16B, V21.4B[0x3]
    SUDOT V7.4S, V12.16B, V20.4B[0x3]
    FMLAL V22.2S, V31.2H, V8.H[0x6]
    USDOT V1.4S, V9.16B, V14.16B
    USDOT V26.4S, V6.16B, V6.4B[0x2]
    SUDOT V4.2S, V13.8B, V22.4B[0x0]
    FMLSL2 V0.4S, V12.4H, V9.4H
    USDOT V24.4S, V7.16B, V19.4B[0x3]
    FMLAL V5.4S, V0.4H, V10.H[0x3]
    FMLSL2 V14.2S, V24.2H, V1.H[0x3]
    USDOT V1.4S, V15.16B, V12.16B
    SMMLA V10.4S, V1.16B, V16.16B
    FMLAL V21.4S, V4.4H, V8.H[0x5]
    USDOT V9.4S, V3.16B, V5.16B
    USDOT V11.4S, V0.16B, V9.4B[0x2]
    FMLAL V17.4S, V11.4H, V11.H[0x5]
    FMLAL2 V29.4S, V21.4H, V11.H[0x0]
    SUDOT V20.4S, V17.16B, V0.4B[0x0]
    FMLAL2 V2.4S, V27.4H, V14.H[0x2]
    USDOT V22.2S, V6.8B, V25.8B
    SUDOT V19.4S, V20.16B, V20.4B[0x2]
    USDOT V19.2S, V22.8B, V19.4B[0x3]
    USDOT V9.2S, V10.8B, V26.8B
    USDOT V12.2S, V2.8B, V2.8B
    FMLAL2 V22.4S, V12.4H, V6.H[0x5]
    USMMLA V27.4S, V13.16B, V20.16B
    SUDOT V20.4S, V19.16B, V9.4B[0x3]
    USMMLA V6.4S, V7.16B, V12.16B
    FMLSL2 V11.4S, V29.4H, V22.4H
    FMLSL V7.4S, V6.4H, V4.4H
    FMLAL2 V17.4S, V9.4H, V20.4H
    FMLSL2 V19.4S, V7.4H, V29.4H
    FMLSL2 V25.2S, V11.2H, V9.H[0x3]
    FMLAL V29.4S, V10.4H, V1.H[0x5]
    FMLSL2 V2.4S, V17.4H, V12.H[0x7]
    FMLAL2 V14.4S, V9.4H, V2.H[0x5]
    FMLAL V22.2S, V5.2H, V14.2H
    FMLSL V14.2S, V27.2H, V14.2H
    FMLSL V13.4S, V25.4H, V19.4H
    USMMLA V1.4S, V14.16B, V13.16B
    FMLAL2 V14.2S, V12.2H, V2.H[0x1]
    FMLAL V10.2S, V22.2H, V24.2H
    USMMLA V19.4S, V8.16B, V17.16B
    USMMLA V1.4S, V18.16B, V16.16B
    USDOT V13.2S, V14.8B, V25.8B
    USDOT V16.4S, V10.16B, V19.16B
    USMMLA V21.4S, V16.16B, V16.16B
    FMLAL V27.4S, V23.4H, V21.4H
    FMLAL2 V20.4S, V13.4H, V1.H[0x1]
    SUDOT V20.4S, V27.16B, V1.4B[0x2]
    FMLAL V18.4S, V21.4H, V1.H[0x6]
    USDOT V23.2S, V1.8B, V12.4B[0x2]
    USDOT V17.4S, V13.16B, V24.4B[0x2]
    USDOT V9.4S, V28.16B, V1.4B[0x0]
    FMLAL V14.4S, V8.4H, V11.4H
    SUDOT V12.4S, V22.16B, V11.4B[0x3]
    FMLSL2 V6.2S, V4.2H, V10.2H
    USDOT V7.2S, V15.8B, V23.4B[0x1]
    FMLAL2 V8.2S, V20.2H, V2.H[0x3]
    SMMLA V19.4S, V12.16B, V25.16B
    FMLSL V21.4S, V21.4H, V7.H[0x6]
    FMLAL2 V24.2S, V6.2H, V29.2H
    FMLSL2 V15.4S, V16.4H, V19.4H
    FMLAL V28.2S, V8.2H, V14.H[0x1]
    USDOT V9.4S, V28.16B, V20.16B
    FMLAL2 V0.4S, V18.4H, V18.4H
    SUDOT V8.4S, V24.16B, V15.4B[0x0]
    USDOT V18.4S, V19.16B, V29.16B
    FMLAL2 V14.4S, V17.4H, V9.4H
    USDOT V2.4S, V8.16B, V0.16B
    FMLSL2 V28.2S, V17.2H, V2.H[0x7]
    FMLSL2 V13.4S, V14.4H, V11.4H
    FMLSL V11.2S, V18.2H, V13.H[0x1]
    FMLSL V10.4S, V27.4H, V11.H[0x1]
    SMMLA V1.4S, V28.16B, V10.16B
    SUDOT V28.2S, V1.8B, V13.4B[0x0]
    UMMLA V27.4S, V10.16B, V8.16B
    SUDOT V20.2S, V10.8B, V30.4B[0x2]
    USDOT V25.2S, V25.8B, V25.8B
    USDOT V29.4S, V14.16B, V25.16B
    FMLSL2 V8.4S, V2.4H, V12.H[0x0]
    FMLSL V1.2S, V24.2H, V25.2H
    FMLAL V9.2S, V29.2H, V10.H[0x3]
    SUDOT V25.4S, V17.16B, V19.4B[0x1]
    FMLAL V0.4S, V11.4H, V24.4H
    UMMLA V1.4S, V18.16B, V8.16B
    FMLAL2 V19.4S, V5.4H, V2.4H
    FMLSL V1.4S, V1.4H, V9.4H
    FMLAL2 V14.2S, V27.2H, V19.2H
    USDOT V27.4S, V28.16B, V28.4B[0x3]
    FMLAL V11.2S, V30.2H, V0.2H
    SUDOT V28.2S, V26.8B, V3.4B[0x0]
    USDOT V12.4S, V20.16B, V18.16B
    FMLAL V14.4S, V14.4H, V3.4H
    FMLSL V19.4S, V1.4H, V8.H[0x4]
    USMMLA V20.4S, V25.16B, V23.16B
    FMLSL V2.4S, V24.4H, V9.H[0x7]
    SMMLA V29.4S, V11.16B, V0.16B
    FMLSL2 V26.4S, V20.4H, V20.4H
    USMMLA V11.4S, V17.16B, V14.16B
    FMLAL2 V0.2S, V12.2H, V8.2H
    SMMLA V24.4S, V17.16B, V11.16B
    SMMLA V30.4S, V31.16B, V13.16B
    SUDOT V0.4S, V19.16B, V20.4B[0x2]
    FMLSL2 V20.2S, V28.2H, V0.H[0x3]
    USDOT V13.2S, V3.8B, V0.8B
    FMLSL V27.2S, V13.2H, V13.H[0x0]
    USDOT V19.2S, V29.8B, V24.8B
    SUDOT V1.2S, V25.8B, V27.4B[0x3]
    SUDOT V14.4S, V12.16B, V1.4B[0x3]
    FMLSL2 V28.2S, V26.2H, V20.2H
    SUBS  X22, X22, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_11
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X13, FPSR
    MOVZ  X29, #0x91, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D1
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D29
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D30
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D31
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X28
    FMOV  D3, X23
    FMOV  V3.D[1], X29
    FMOV  D4, X11
    FMOV  V4.D[1], X6
    FMOV  D5, X18
    FMOV  V5.D[1], X26
    FMOV  D6, X12
    FMOV  V6.D[1], X19
    FMOV  D7, X25
    FMOV  V7.D[1], X3
    FMOV  D8, X28
    FMOV  V8.D[1], X6
    FMOV  D9, X22
    FMOV  V9.D[1], X15
    FMOV  D10, X22
    FMOV  V10.D[1], X27
    FMOV  D11, X8
    FMOV  V11.D[1], X22
    FMOV  D12, X2
    FMOV  V12.D[1], X25
    FMOV  D13, X2
    FMOV  V13.D[1], X18
    FMOV  D14, X16
    FMOV  V14.D[1], X2
    FMOV  D15, X10
    FMOV  V15.D[1], X27
    FMOV  D16, X28
    FMOV  V16.D[1], X2
    FMOV  D17, X2
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X14
    FMOV  D19, X16
    FMOV  V19.D[1], X8
    FMOV  D20, X17
    FMOV  V20.D[1], X12
    FMOV  D21, X10
    FMOV  V21.D[1], X25
    FMOV  D22, X18
    FMOV  V22.D[1], X12
    FMOV  D23, X26
    FMOV  V23.D[1], X11
    FMOV  D24, X16
    FMOV  V24.D[1], X20
    FMOV  D25, X20
    FMOV  V25.D[1], X20
    FMOV  D26, X28
    FMOV  V26.D[1], X29
    FMOV  D27, X14
    FMOV  V27.D[1], X14
    FMOV  D28, X9
    FMOV  V28.D[1], X22
    FMOV  D29, X12
    FMOV  V29.D[1], X2
    FMOV  D30, X26
    FMOV  V30.D[1], X13
    FMOV  D31, X24
    FMOV  V31.D[1], X14
    MOVZ  X22, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_12:
    FMLAL V24.4S, V5.4H, V8.H[0x7]
    FMLSL V28.4S, V31.4H, V4.H[0x7]
    SUDOT V26.2S, V27.8B, V0.4B[0x2]
    FMLSL2 V24.2S, V28.2H, V12.H[0x5]
    FMLAL2 V12.4S, V30.4H, V1.H[0x0]
    FMLAL2 V3.4S, V12.4H, V12.H[0x5]
    USDOT V25.4S, V22.16B, V24.16B
    USDOT V24.4S, V31.16B, V3.4B[0x0]
    USDOT V9.2S, V29.8B, V7.4B[0x3]
    FMLSL V22.4S, V25.4H, V9.H[0x7]
    FMLSL2 V5.2S, V30.2H, V24.2H
    SUDOT V9.2S, V16.8B, V18.4B[0x2]
    USMMLA V8.4S, V5.16B, V26.16B
    FMLSL V13.2S, V18.2H, V28.2H
    FMLSL V16.4S, V24.4H, V9.4H
    FMLAL V30.2S, V16.2H, V13.H[0x6]
    FMLAL V29.4S, V27.4H, V7.4H
    USDOT V25.2S, V29.8B, V30.8B
    USDOT V26.4S, V25.16B, V22.4B[0x0]
    FMLSL V9.2S, V6.2H, V18.2H
    UMMLA V16.4S, V16.16B, V19.16B
    FMLSL2 V7.2S, V1.2H, V13.H[0x3]
    SMMLA V4.4S, V15.16B, V26.16B
    USMMLA V17.4S, V21.16B, V27.16B
    UMMLA V1.4S, V25.16B, V11.16B
    FMLAL V26.2S, V20.2H, V19.2H
    FMLAL2 V18.4S, V6.4H, V11.H[0x6]
    SMMLA V12.4S, V2.16B, V3.16B
    FMLSL2 V7.4S, V17.4H, V8.4H
    UMMLA V20.4S, V4.16B, V18.16B
    USDOT V30.2S, V9.8B, V27.4B[0x2]
    USDOT V24.2S, V20.8B, V20.4B[0x0]
    UMMLA V27.4S, V30.16B, V24.16B
    FMLSL V30.4S, V25.4H, V30.4H
    SUDOT V6.2S, V2.8B, V9.4B[0x0]
    FMLAL V8.2S, V5.2H, V26.2H
    FMLSL V19.2S, V1.2H, V1.H[0x2]
    FMLSL2 V9.4S, V25.4H, V0.4H
    FMLAL V7.4S, V7.4H, V16.4H
    USDOT V25.2S, V6.8B, V7.4B[0x3]
    FMLAL2 V28.4S, V25.4H, V9.4H
    USDOT V13.4S, V28.16B, V16.4B[0x0]
    FMLSL2 V15.2S, V24.2H, V15.H[0x5]
    SUDOT V26.4S, V12.16B, V9.4B[0x2]
    FMLAL V0.2S, V15.2H, V4.2H
    FMLAL V1.2S, V31.2H, V5.H[0x4]
    FMLAL2 V9.4S, V0.4H, V0.H[0x1]
    FMLSL2 V25.4S, V8.4H, V9.H[0x2]
    FMLAL2 V20.2S, V25.2H, V31.2H
    FMLSL V9.2S, V31.2H, V28.2H
    FMLAL2 V12.2S, V31.2H, V25.2H
    FMLSL V31.2S, V1.2H, V30.2H
    USDOT V24.4S, V19.16B, V9.16B
    FMLAL2 V19.4S, V26.4H, V12.H[0x2]
    USDOT V5.4S, V31.16B, V19.16B
    USDOT V19.4S, V20.16B, V24.4B[0x0]
    USDOT V31.4S, V13.16B, V17.4B[0x1]
    FMLAL2 V1.2S, V31.2H, V2.2H
    FMLAL2 V6.2S, V17.2H, V1.H[0x7]
    FMLAL2 V15.2S, V19.2H, V6.H[0x0]
    FMLSL V26.4S, V24.4H, V5.4H
    USDOT V7.2S, V7.8B, V21.4B[0x3]
    USDOT V30.2S, V23.8B, V7.4B[0x3]
    FMLAL2 V25.2S, V5.2H, V10.2H
    FMLAL2 V8.4S, V30.4H, V15.H[0x6]
    FMLSL2 V21.2S, V24.2H, V8.H[0x4]
    USDOT V2.2S, V15.8B, V23.4B[0x3]
    USDOT V17.4S, V26.16B, V2.4B[0x0]
    FMLSL2 V22.2S, V21.2H, V25.2H
    FMLSL V29.2S, V28.2H, V9.H[0x6]
    FMLAL2 V28.4S, V24.4H, V25.4H
    USDOT V8.4S, V0.16B, V10.4B[0x2]
    FMLAL V24.4S, V15.4H, V4.H[0x6]
    SMMLA V21.4S, V18.16B, V10.16B
    USMMLA V0.4S, V11.16B, V3.16B
    USMMLA V26.4S, V6.16B, V9.16B
    SMMLA V13.4S, V24.16B, V22.16B
    FMLAL2 V11.4S, V28.4H, V8.H[0x0]
    SUDOT V5.4S, V29.16B, V0.4B[0x0]
    FMLSL V27.2S, V13.2H, V8.H[0x4]
    UMMLA V25.4S, V27.16B, V23.16B
    FMLSL2 V18.2S, V17.2H, V26.2H
    FMLAL V4.4S, V11.4H, V5.H[0x1]
    UMMLA V1.4S, V14.16B, V12.16B
    USDOT V26.2S, V1.8B, V1.8B
    SUDOT V14.2S, V15.8B, V26.4B[0x1]
    USDOT V17.2S, V21.8B, V8.8B
    USMMLA V3.4S, V18.16B, V17.16B
    FMLSL V30.2S, V1.2H, V4.2H
    SMMLA V27.4S, V14.16B, V3.16B
    SUDOT V29.2S, V24.8B, V27.4B[0x3]
    FMLSL V17.2S, V4.2H, V6.H[0x6]
    FMLSL2 V0.2S, V30.2H, V8.H[0x7]
    USDOT V23.4S, V17.16B, V23.16B
    SMMLA V4.4S, V4.16B, V24.16B
    USDOT V2.4S, V4.16B, V23.4B[0x0]
    FMLSL V22.2S, V2.2H, V2.2H
    FMLSL2 V8.4S, V29.4H, V22.4H
    FMLAL V23.4S, V3.4H, V26.4H
    USDOT V29.4S, V25.16B, V0.4B[0x1]
    FMLAL V7.4S, V29.4H, V26.4H
    USDOT V28.4S, V7.16B, V25.4B[0x1]
    USDOT V3.2S, V28.8B, V8.8B
    USMMLA V0.4S, V20.16B, V11.16B
    FMLSL V15.2S, V17.2H, V9.2H
    FMLSL2 V1.4S, V3.4H, V10.H[0x3]
    SMMLA V29.4S, V26.16B, V17.16B
    USDOT V4.2S, V15.8B, V7.8B
    FMLAL2 V22.2S, V7.2H, V6.H[0x4]
    SMMLA V8.4S, V16.16B, V13.16B
    USDOT V7.2S, V7.8B, V12.8B
    USDOT V15.2S, V2.8B, V12.4B[0x1]
    SMMLA V12.4S, V27.16B, V4.16B
    SUDOT V7.4S, V22.16B, V22.4B[0x0]
    SUDOT V9.4S, V24.16B, V0.4B[0x1]
    SUDOT V0.2S, V28.8B, V15.4B[0x2]
    USMMLA V22.4S, V23.16B, V18.16B
    FMLAL2 V24.2S, V29.2H, V12.H[0x5]
    FMLSL2 V29.4S, V24.4H, V24.4H
    SMMLA V10.4S, V9.16B, V0.16B
    SUDOT V13.4S, V7.16B, V10.4B[0x3]
    FMLAL2 V15.4S, V13.4H, V13.4H
    FMLAL2 V12.4S, V24.4H, V1.H[0x2]
    FMLSL2 V2.4S, V29.4H, V28.4H
    UMMLA V29.4S, V8.16B, V2.16B
    FMLAL2 V13.2S, V29.2H, V12.2H
    FMLAL2 V29.4S, V13.4H, V21.4H
    USDOT V11.4S, V22.16B, V31.16B
    FMLAL2 V12.2S, V17.2H, V15.2H
    USDOT V17.2S, V11.8B, V6.4B[0x1]
    USMMLA V0.4S, V12.16B, V22.16B
    FMLAL V8.4S, V29.4H, V23.4H
    FMLSL V28.4S, V8.4H, V0.H[0x1]
    FMLSL2 V31.2S, V13.2H, V3.2H
    FMLSL2 V2.2S, V16.2H, V13.2H
    FMLSL2 V6.2S, V23.2H, V21.2H
    FMLAL2 V19.2S, V14.2H, V2.H[0x3]
    FMLSL V12.4S, V14.4H, V12.H[0x3]
    USMMLA V3.4S, V27.16B, V22.16B
    USDOT V29.2S, V14.8B, V12.8B
    USDOT V21.2S, V4.8B, V12.4B[0x2]
    FMLAL2 V15.2S, V15.2H, V26.2H
    USDOT V27.4S, V6.16B, V31.16B
    FMLAL2 V23.2S, V29.2H, V19.2H
    SMMLA V19.4S, V28.16B, V23.16B
    FMLAL V8.2S, V27.2H, V3.2H
    FMLAL V23.2S, V12.2H, V19.2H
    FMLAL V26.2S, V22.2H, V23.2H
    UMMLA V31.4S, V11.16B, V8.16B
    USDOT V24.2S, V0.8B, V7.8B
    USMMLA V7.4S, V18.16B, V21.16B
    FMLAL2 V1.4S, V15.4H, V27.4H
    FMLSL V28.4S, V7.4H, V7.H[0x2]
    FMLSL V6.2S, V1.2H, V11.H[0x5]
    FMLSL2 V19.2S, V17.2H, V10.H[0x3]
    SMMLA V3.4S, V19.16B, V28.16B
    USDOT V27.4S, V3.16B, V28.4B[0x3]
    FMLSL2 V28.2S, V21.2H, V27.2H
    SUDOT V29.4S, V31.16B, V25.4B[0x3]
    SUDOT V3.2S, V31.8B, V26.4B[0x2]
    FMLSL2 V8.4S, V28.4H, V7.4H
    SUDOT V21.4S, V29.16B, V8.4B[0x1]
    UMMLA V1.4S, V6.16B, V11.16B
    FMLSL V10.4S, V24.4H, V1.H[0x6]
    SMMLA V11.4S, V11.16B, V14.16B
    USDOT V6.2S, V9.8B, V12.4B[0x1]
    SUDOT V12.4S, V10.16B, V7.4B[0x2]
    USDOT V4.4S, V11.16B, V21.4B[0x2]
    FMLAL2 V26.4S, V12.4H, V14.H[0x3]
    FMLAL V24.2S, V29.2H, V3.2H
    SMMLA V1.4S, V24.16B, V4.16B
    USMMLA V17.4S, V26.16B, V26.16B
    FMLAL V28.4S, V17.4H, V14.H[0x1]
    SMMLA V31.4S, V28.16B, V6.16B
    FMLAL2 V26.4S, V6.4H, V3.H[0x5]
    FMLAL2 V12.2S, V0.2H, V15.H[0x6]
    FMLAL V10.4S, V9.4H, V6.H[0x4]
    SUDOT V3.4S, V18.16B, V1.4B[0x2]
    UMMLA V13.4S, V7.16B, V14.16B
    FMLAL V15.2S, V9.2H, V14.2H
    FMLAL V4.4S, V15.4H, V27.4H
    USDOT V9.4S, V5.16B, V6.4B[0x1]
    UMMLA V18.4S, V6.16B, V21.16B
    FMLAL V15.2S, V10.2H, V10.H[0x3]
    FMLSL V25.4S, V13.4H, V26.4H
    USDOT V21.4S, V31.16B, V25.4B[0x1]
    USDOT V14.4S, V28.16B, V15.4B[0x0]
    USDOT V12.2S, V21.8B, V30.4B[0x1]
    FMLAL2 V15.4S, V6.4H, V12.H[0x4]
    FMLAL2 V10.2S, V9.2H, V12.2H
    FMLSL V11.4S, V15.4H, V4.H[0x4]
    USDOT V7.4S, V1.16B, V30.16B
    FMLSL2 V0.4S, V29.4H, V2.H[0x7]
    FMLSL2 V9.2S, V10.2H, V7.2H
    FMLAL V17.2S, V18.2H, V11.2H
    SMMLA V1.4S, V14.16B, V14.16B
    FMLAL2 V2.4S, V3.4H, V3.4H
    FMLAL V13.2S, V0.2H, V0.2H
    USDOT V29.2S, V17.8B, V1.4B[0x3]
    USDOT V0.2S, V23.8B, V2.8B
    SUBS  X22, X22, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_12
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X21, FPSR
    MOVZ  X23, #0x91, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D0
    MOVZ  X23, #0xa7e6, LSL #0
    MOVK  X23, #0x7fe0, LSL #16
    MOVK  X23, #0x4e1a, LSL #32
    MOVK  X23, #0xfffd, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X23, #0x92, LSL #0
    MOVK  X23, #0x1afc, LSL #32
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D1
    MOVZ  X23, #0x86ff, LSL #0
    MOVK  X23, #0x4, LSL #16
    MOVK  X23, #0x513, LSL #32
    MOVK  X23, #0x5, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D2
    MOVZ  X23, #0x22aa, LSL #0
    MOVK  X23, #0xfffd, LSL #16
    MOVK  X23, #0xaea5, LSL #32
    MOVK  X23, #0x7ffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D3
    MOVZ  X23, #0xd650, LSL #0
    MOVK  X23, #0xfffc, LSL #16
    MOVK  X23, #0x77be, LSL #32
    MOVK  X23, #0xfffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X23, #0xc1ac, LSL #0
    MOVK  X23, #0xc891, LSL #16
    MOVK  X23, #0xc000, LSL #32
    MOVK  X23, #0xfffb, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D4
    MOVZ  X23, #0x6cb0, LSL #0
    MOVK  X23, #0x7ffd, LSL #16
    MOVK  X23, #0xe5ee, LSL #32
    MOVK  X23, #0xfffb, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D5
    MOVZ  X23, #0xf5fa, LSL #0
    MOVK  X23, #0x7fdf, LSL #16
    MOVK  X23, #0xe63f, LSL #32
    MOVK  X23, #0xfffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D6
    MOVZ  X23, #0x4ba9, LSL #0
    MOVK  X23, #0x7fd0, LSL #16
    MOVK  X23, #0xcbd3, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D7
    MOVZ  X23, #0x1e94, LSL #0
    MOVK  X23, #0xfffd, LSL #16
    MOVK  X23, #0xe3e, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D8
    MOVZ  X23, #0x3f, LSL #0
    MOVK  X23, #0xffc6, LSL #16
    MOVK  X23, #0x5da8, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D9
    MOVZ  X23, #0x123e, LSL #0
    MOVK  X23, #0xffe0, LSL #16
    MOVK  X23, #0x9fb, LSL #32
    MOVK  X23, #0xfffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D10
    MOVZ  X23, #0xfa50, LSL #0
    MOVK  X23, #0x4ba4, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X23, #0xaafc, LSL #0
    MOVK  X23, #0xc8b5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D11
    MOVZ  X23, #0x6ffd, LSL #0
    MOVK  X23, #0xfffe, LSL #16
    MOVK  X23, #0x1689, LSL #32
    MOVK  X23, #0xfff9, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D12
    MOVZ  X23, #0xa09b, LSL #0
    MOVK  X23, #0xffd5, LSL #16
    MOVK  X23, #0xce12, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D13
    MOVZ  X23, #0x9450, LSL #0
    MOVK  X23, #0x4b66, LSL #16
    MOVK  X23, #0x8c55, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X23, #0x1612, LSL #0
    MOVK  X23, #0x2472, LSL #32
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D14
    MOVZ  X23, #0x2b7a, LSL #0
    MOVK  X23, #0xfffd, LSL #16
    MOVK  X23, #0xf232, LSL #32
    MOVK  X23, #0xfffd, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D15
    MOVZ  X23, #0x73c8, LSL #0
    MOVK  X23, #0xffcf, LSL #16
    MOVK  X23, #0xc751, LSL #32
    MOVK  X23, #0xffde, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X23, #0xcd95, LSL #0
    MOVK  X23, #0x7fea, LSL #16
    MOVK  X23, #0xe000, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D16
    MOVZ  X23, #0xcd95, LSL #0
    MOVK  X23, #0x7fea, LSL #16
    MOVK  X23, #0xe000, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D17
    MOVZ  X23, #0xdab8, LSL #0
    MOVK  X23, #0xfff9, LSL #16
    MOVK  X23, #0x8b0c, LSL #32
    MOVK  X23, #0xfffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D18
    MOVZ  X23, #0x6069, LSL #0
    MOVK  X23, #0x4, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D19
    MOVZ  X23, #0x5e5f, LSL #0
    MOVK  X23, #0xffdf, LSL #16
    MOVK  X23, #0xd37f, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D20
    MOVZ  X23, #0xd79f, LSL #0
    MOVK  X23, #0xffde, LSL #16
    MOVK  X23, #0xe000, LSL #32
    MOVK  X23, #0xfffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X23, #0xdcbe, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D21
    MOVZ  X23, #0xea8f, LSL #0
    MOVK  X23, #0xfffc, LSL #16
    MOVK  X23, #0x923d, LSL #32
    MOVK  X23, #0x7ffd, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X23, #0xfd42, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D22
    MOVZ  X23, #0x5867, LSL #0
    MOVK  X23, #0xffd5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D23
    MOVZ  X23, #0x3d9b, LSL #0
    MOVK  X23, #0xffec, LSL #16
    MOVK  X23, #0x724b, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D24
    MOVZ  X23, #0xa612, LSL #0
    MOVK  X23, #0x7fd1, LSL #16
    MOVK  X23, #0xff02, LSL #32
    MOVK  X23, #0xfffd, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xe000, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D25
    MOVZ  X23, #0x53c7, LSL #0
    MOVK  X23, #0xffda, LSL #16
    MOVK  X23, #0x991a, LSL #32
    MOVK  X23, #0xfff7, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X23, #0xa000, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xe000, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D26
    MOVZ  X23, #0x9554, LSL #0
    MOVK  X23, #0xffc3, LSL #16
    MOVK  X23, #0x16a, LSL #32
    MOVK  X23, #0xfffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D27
    MOVZ  X23, #0x49ce, LSL #0
    MOVK  X23, #0x78fb, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X23, #0xa000, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xc000, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D28
    MOVZ  X23, #0x8319, LSL #0
    MOVK  X23, #0x7fcd, LSL #16
    MOVK  X23, #0x6d3f, LSL #32
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D29
    MOVZ  X23, #0xc93d, LSL #0
    MOVK  X23, #0xffd9, LSL #16
    MOVK  X23, #0xa796, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D30
    MOVZ  X23, #0x4000, LSL #0
    MOVK  X23, #0xffe0, LSL #16
    MOVK  X23, #0xfd02, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X23, #0x6e5a, LSL #0
    MOVK  X23, #0x4, LSL #16
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X21, D31
    MOVZ  X23, #0x85ac, LSL #0
    MOVK  X23, #0xc6a3, LSL #32
    MOVK  X23, #0x7ffe, LSL #48
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X2
    FMOV  D1, X23
    FMOV  V1.D[1], X29
    FMOV  D2, X21
    FMOV  V2.D[1], X26
    FMOV  D3, X22
    FMOV  V3.D[1], X28
    FMOV  D4, X3
    FMOV  V4.D[1], X2
    FMOV  D5, X18
    FMOV  V5.D[1], X18
    FMOV  D6, X19
    FMOV  V6.D[1], X22
    FMOV  D7, X18
    FMOV  V7.D[1], X2
    FMOV  D8, X21
    FMOV  V8.D[1], X22
    FMOV  D9, X6
    FMOV  V9.D[1], X18
    FMOV  D10, X12
    FMOV  V10.D[1], X16
    FMOV  D11, X24
    FMOV  V11.D[1], X13
    FMOV  D12, X21
    FMOV  V12.D[1], X24
    FMOV  D13, X20
    FMOV  V13.D[1], X8
    FMOV  D14, X14
    FMOV  V14.D[1], X14
    FMOV  D15, X8
    FMOV  V15.D[1], X18
    FMOV  D16, X25
    FMOV  V16.D[1], X20
    FMOV  D17, X14
    FMOV  V17.D[1], X25
    FMOV  D18, X18
    FMOV  V18.D[1], X12
    FMOV  D19, X24
    FMOV  V19.D[1], X17
    FMOV  D20, X20
    FMOV  V20.D[1], X25
    FMOV  D21, X26
    FMOV  V21.D[1], X10
    FMOV  D22, X21
    FMOV  V22.D[1], X22
    FMOV  D23, X17
    FMOV  V23.D[1], X26
    FMOV  D24, X17
    FMOV  V24.D[1], X11
    FMOV  D25, X6
    FMOV  V25.D[1], X29
    FMOV  D26, X9
    FMOV  V26.D[1], X16
    FMOV  D27, X29
    FMOV  V27.D[1], X26
    FMOV  D28, X15
    FMOV  V28.D[1], X15
    FMOV  D29, X13
    FMOV  V29.D[1], X21
    FMOV  D30, X25
    FMOV  V30.D[1], X26
    FMOV  D31, X16
    FMOV  V31.D[1], X11
    MOVZ  X6, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_13:
    FMLAL V29.2S, V30.2H, V27.2H
    SUDOT V30.2S, V8.8B, V29.4B[0x1]
    FMLAL2 V28.2S, V25.2H, V28.2H
    USDOT V23.4S, V28.16B, V7.4B[0x0]
    UMMLA V23.4S, V27.16B, V23.16B
    FMLSL V2.4S, V23.4H, V7.H[0x3]
    FMLAL2 V31.4S, V21.4H, V2.H[0x0]
    SUDOT V30.4S, V26.16B, V31.4B[0x1]
    USMMLA V28.4S, V31.16B, V30.16B
    USDOT V3.4S, V28.16B, V6.16B
    SUDOT V6.2S, V28.8B, V3.4B[0x1]
    USDOT V31.2S, V21.8B, V6.8B
    USDOT V8.4S, V31.16B, V25.16B
    FMLAL2 V7.2S, V4.2H, V3.H[0x4]
    USDOT V3.4S, V24.16B, V17.16B
    USDOT V29.2S, V8.8B, V2.4B[0x1]
    USDOT V11.4S, V12.16B, V25.4B[0x2]
    FMLAL2 V6.2S, V2.2H, V5.H[0x2]
    SMMLA V10.4S, V6.16B, V27.16B
    USDOT V16.2S, V4.8B, V12.4B[0x1]
    USDOT V4.2S, V11.8B, V17.4B[0x2]
    FMLSL V17.2S, V1.2H, V18.2H
    USDOT V25.2S, V0.8B, V29.4B[0x3]
    FMLAL2 V24.2S, V24.2H, V25.2H
    SUDOT V12.2S, V23.8B, V13.4B[0x3]
    FMLAL2 V2.4S, V31.4H, V15.4H
    FMLAL V28.2S, V4.2H, V10.H[0x1]
    USDOT V18.4S, V15.16B, V4.16B
    FMLSL V28.4S, V12.4H, V2.4H
    USDOT V10.2S, V28.8B, V3.4B[0x3]
    FMLAL V26.2S, V29.2H, V7.H[0x7]
    FMLSL2 V26.4S, V16.4H, V31.4H
    USMMLA V26.4S, V24.16B, V18.16B
    FMLSL2 V24.4S, V18.4H, V10.H[0x4]
    FMLAL V0.2S, V24.2H, V1.H[0x7]
    FMLSL V29.4S, V26.4H, V17.4H
    FMLSL V25.2S, V16.2H, V6.H[0x1]
    FMLSL V12.2S, V9.2H, V12.H[0x6]
    USDOT V31.4S, V2.16B, V11.16B
    SMMLA V7.4S, V6.16B, V0.16B
    USDOT V0.4S, V13.16B, V16.16B
    FMLAL2 V9.4S, V31.4H, V15.4H
    SMMLA V6.4S, V29.16B, V16.16B
    FMLSL2 V5.2S, V5.2H, V13.2H
    USDOT V29.4S, V20.16B, V22.4B[0x3]
    USMMLA V6.4S, V27.16B, V23.16B
    FMLSL V3.4S, V7.4H, V21.4H
    FMLAL V26.4S, V17.4H, V26.4H
    FMLAL2 V16.2S, V0.2H, V12.H[0x2]
    FMLAL2 V31.4S, V3.4H, V25.4H
    FMLSL V16.2S, V7.2H, V11.2H
    FMLSL V17.2S, V1.2H, V1.2H
    UMMLA V2.4S, V26.16B, V4.16B
    SMMLA V10.4S, V17.16B, V5.16B
    USDOT V25.4S, V28.16B, V16.16B
    FMLAL V24.2S, V29.2H, V9.2H
    FMLAL V24.4S, V10.4H, V1.H[0x1]
    FMLAL V22.4S, V31.4H, V27.4H
    SUDOT V29.4S, V30.16B, V6.4B[0x0]
    FMLSL2 V6.2S, V25.2H, V3.H[0x7]
    FMLAL V10.2S, V12.2H, V31.2H
    USDOT V31.2S, V10.8B, V10.8B
    SMMLA V2.4S, V7.16B, V28.16B
    USDOT V15.2S, V22.8B, V27.8B
    USDOT V22.4S, V6.16B, V4.4B[0x1]
    FMLSL V20.2S, V31.2H, V10.2H
    USMMLA V31.4S, V2.16B, V29.16B
    FMLAL2 V5.2S, V9.2H, V22.2H
    FMLAL V22.4S, V20.4H, V5.H[0x4]
    UMMLA V6.4S, V15.16B, V15.16B
    FMLAL V12.2S, V1.2H, V6.H[0x4]
    FMLAL2 V27.2S, V22.2H, V0.H[0x4]
    FMLSL V28.2S, V12.2H, V27.2H
    FMLAL V16.4S, V2.4H, V13.H[0x6]
    SMMLA V22.4S, V12.16B, V16.16B
    FMLSL V6.4S, V24.4H, V22.4H
    UMMLA V4.4S, V24.16B, V20.16B
    UMMLA V12.4S, V31.16B, V6.16B
    USDOT V11.4S, V28.16B, V28.4B[0x2]
    FMLSL2 V3.4S, V21.4H, V24.4H
    FMLAL2 V16.4S, V4.4H, V3.H[0x1]
    FMLSL V0.4S, V30.4H, V5.H[0x2]
    FMLAL V27.4S, V16.4H, V11.4H
    USDOT V29.2S, V12.8B, V27.8B
    FMLAL2 V2.2S, V12.2H, V0.H[0x4]
    USDOT V30.2S, V10.8B, V14.8B
    SUDOT V24.2S, V24.8B, V31.4B[0x1]
    FMLAL V27.4S, V31.4H, V4.H[0x6]
    FMLSL2 V13.4S, V11.4H, V0.H[0x5]
    USMMLA V28.4S, V25.16B, V7.16B
    USDOT V1.4S, V15.16B, V30.16B
    USDOT V2.2S, V25.8B, V16.4B[0x2]
    FMLAL V12.2S, V1.2H, V13.H[0x1]
    FMLSL2 V2.4S, V11.4H, V10.4H
    USDOT V14.4S, V30.16B, V26.16B
    SMMLA V30.4S, V2.16B, V14.16B
    USDOT V3.2S, V4.8B, V3.4B[0x2]
    USDOT V5.4S, V1.16B, V30.16B
    USDOT V15.4S, V5.16B, V2.16B
    USDOT V13.4S, V6.16B, V23.4B[0x0]
    USMMLA V26.4S, V19.16B, V17.16B
    USDOT V28.2S, V12.8B, V12.4B[0x0]
    USMMLA V1.4S, V12.16B, V15.16B
    USDOT V11.2S, V26.8B, V29.4B[0x0]
    USDOT V7.4S, V11.16B, V11.16B
    FMLSL V22.2S, V9.2H, V13.H[0x4]
    FMLAL2 V31.2S, V24.2H, V11.H[0x1]
    USMMLA V10.4S, V22.16B, V9.16B
    USDOT V9.4S, V1.16B, V10.16B
    FMLAL V5.4S, V9.4H, V6.H[0x5]
    FMLAL V15.4S, V31.4H, V5.4H
    USDOT V12.4S, V28.16B, V28.16B
    FMLAL2 V7.2S, V12.2H, V3.2H
    USDOT V14.2S, V7.8B, V15.8B
    USDOT V13.2S, V27.8B, V23.4B[0x0]
    SUDOT V17.4S, V15.16B, V26.4B[0x2]
    USDOT V16.4S, V2.16B, V12.16B
    FMLAL2 V10.4S, V25.4H, V29.4H
    FMLSL V25.4S, V19.4H, V3.H[0x3]
    FMLAL2 V11.2S, V20.2H, V4.H[0x6]
    FMLSL V31.2S, V17.2H, V5.H[0x1]
    FMLAL V30.4S, V31.4H, V0.H[0x2]
    FMLSL2 V24.2S, V10.2H, V27.2H
    USDOT V29.2S, V6.8B, V11.8B
    SUDOT V31.4S, V7.16B, V29.4B[0x0]
    FMLSL V3.4S, V27.4H, V15.H[0x2]
    SMMLA V17.4S, V18.16B, V15.16B
    USDOT V11.2S, V14.8B, V27.8B
    FMLAL2 V29.2S, V11.2H, V13.H[0x7]
    FMLSL2 V28.2S, V24.2H, V1.H[0x1]
    FMLAL2 V20.2S, V20.2H, V17.2H
    FMLSL2 V13.2S, V23.2H, V8.H[0x0]
    FMLAL V8.2S, V16.2H, V31.2H
    USMMLA V10.4S, V28.16B, V25.16B
    FMLSL2 V2.4S, V8.4H, V10.H[0x1]
    SUDOT V5.2S, V2.8B, V29.4B[0x3]
    USDOT V17.2S, V13.8B, V13.8B
    USDOT V30.2S, V20.8B, V5.4B[0x3]
    FMLSL2 V25.4S, V17.4H, V8.H[0x7]
    FMLSL2 V24.2S, V3.2H, V29.2H
    FMLSL V28.2S, V24.2H, V24.2H
    FMLSL V12.4S, V26.4H, V9.4H
    FMLAL2 V23.4S, V28.4H, V28.4H
    SUDOT V15.4S, V10.16B, V23.4B[0x0]
    USDOT V28.4S, V2.16B, V15.16B
    FMLAL V5.2S, V3.2H, V25.2H
    FMLSL V31.4S, V31.4H, V28.4H
    FMLSL2 V15.4S, V31.4H, V11.H[0x1]
    SMMLA V11.4S, V15.16B, V29.16B
    FMLAL2 V29.2S, V12.2H, V21.2H
    UMMLA V29.4S, V25.16B, V30.16B
    FMLSL V31.4S, V5.4H, V5.H[0x5]
    FMLSL V4.2S, V10.2H, V8.H[0x2]
    FMLSL V23.2S, V31.2H, V11.H[0x4]
    USDOT V20.4S, V31.16B, V23.16B
    FMLAL V21.4S, V1.4H, V21.4H
    USMMLA V25.4S, V5.16B, V21.16B
    FMLSL2 V30.2S, V11.2H, V9.H[0x4]
    USDOT V1.4S, V3.16B, V25.4B[0x0]
    USMMLA V12.4S, V30.16B, V5.16B
    SUDOT V15.2S, V1.8B, V12.4B[0x0]
    FMLAL2 V0.2S, V15.2H, V14.2H
    FMLAL V12.4S, V4.4H, V7.H[0x4]
    SMMLA V5.4S, V24.16B, V11.16B
    FMLSL V26.2S, V16.2H, V5.H[0x4]
    FMLSL V17.2S, V12.2H, V12.2H
    UMMLA V21.4S, V26.16B, V26.16B
    FMLSL2 V1.4S, V17.4H, V0.4H
    SMMLA V30.4S, V21.16B, V16.16B
    FMLAL2 V5.2S, V0.2H, V1.H[0x2]
    UMMLA V23.4S, V30.16B, V20.16B
    SMMLA V25.4S, V23.16B, V23.16B
    FMLSL2 V15.2S, V20.2H, V5.2H
    FMLAL2 V16.2S, V25.2H, V8.H[0x0]
    USDOT V7.4S, V16.16B, V5.4B[0x2]
    FMLSL V3.4S, V29.4H, V15.4H
    USDOT V14.4S, V20.16B, V25.4B[0x2]
    USDOT V23.4S, V19.16B, V20.4B[0x0]
    SUDOT V21.4S, V15.16B, V17.4B[0x0]
    FMLAL2 V12.2S, V25.2H, V12.2H
    FMLAL V27.4S, V29.4H, V30.4H
    FMLSL2 V11.4S, V24.4H, V4.H[0x5]
    FMLAL V17.2S, V4.2H, V26.2H
    USDOT V29.4S, V3.16B, V12.16B
    USDOT V8.2S, V14.8B, V21.4B[0x0]
    USMMLA V30.4S, V7.16B, V11.16B
    UMMLA V26.4S, V25.16B, V17.16B
    FMLAL2 V9.2S, V23.2H, V8.H[0x0]
    USDOT V3.2S, V27.8B, V10.4B[0x0]
    FMLAL2 V24.4S, V26.4H, V9.H[0x7]
    FMLAL V10.2S, V3.2H, V3.H[0x7]
    SUDOT V9.4S, V24.16B, V17.4B[0x0]
    FMLAL V11.4S, V1.4H, V9.H[0x1]
    USMMLA V7.4S, V10.16B, V4.16B
    FMLAL V24.2S, V29.2H, V7.H[0x1]
    USDOT V21.4S, V30.16B, V30.4B[0x3]
    FMLAL2 V15.4S, V11.4H, V24.4H
    UMMLA V25.4S, V1.16B, V16.16B
    SMMLA V9.4S, V18.16B, V27.16B
    SUDOT V20.4S, V17.16B, V11.4B[0x2]
    SUBS  X6, X6, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_13
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X13, FPSR
    MOVZ  X8, #0x91, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D0
    MOVZ  X8, #0xf7f5, LSL #0
    MOVK  X8, #0x7fc0, LSL #16
    MOVK  X8, #0x4d50, LSL #32
    MOVK  X8, #0xfffb, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X8, #0xb55a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x78d, LSL #32
    MOVK  X8, #0x5a5c, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D1
    MOVZ  X8, #0xd2ae, LSL #0
    MOVK  X8, #0x5a63, LSL #16
    MOVK  X8, #0xe614, LSL #32
    MOVK  X8, #0x5a59, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0xfff8, LSL #16
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D2
    MOVZ  X8, #0x6d13, LSL #0
    MOVK  X8, #0xfffa, LSL #16
    MOVK  X8, #0xfad1, LSL #32
    MOVK  X8, #0x7ffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D3
    MOVZ  X8, #0xcd08, LSL #0
    MOVK  X8, #0x7fe2, LSL #16
    MOVK  X8, #0xc514, LSL #32
    MOVK  X8, #0xfffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D4
    MOVZ  X8, #0xe185, LSL #0
    MOVK  X8, #0xffea, LSL #16
    MOVK  X8, #0xc000, LSL #32
    MOVK  X8, #0xfffa, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D5
    MOVZ  X8, #0x7125, LSL #0
    MOVK  X8, #0xfffd, LSL #16
    MOVK  X8, #0xcdaa, LSL #32
    MOVK  X8, #0xfffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X8, #0xe980, LSL #0
    MOVK  X8, #0xbf9d, LSL #16
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D6
    MOVZ  X8, #0x68ff, LSL #0
    MOVK  X8, #0x7fd9, LSL #16
    MOVK  X8, #0xdfec, LSL #32
    MOVK  X8, #0x7ffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D7
    MOVZ  X8, #0xcee7, LSL #0
    MOVK  X8, #0x5a5d, LSL #16
    MOVK  X8, #0x9189, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D8
    MOVZ  X8, #0xdb24, LSL #0
    MOVK  X8, #0x7fe8, LSL #16
    MOVK  X8, #0xc3c5, LSL #32
    MOVK  X8, #0x7ffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X8, #0x729c, LSL #0
    MOVK  X8, #0xd1f2, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D9
    MOVZ  X8, #0xf87e, LSL #0
    MOVK  X8, #0xffe5, LSL #16
    MOVK  X8, #0x8800, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D10
    MOVZ  X8, #0x99b8, LSL #0
    MOVK  X8, #0xffc4, LSL #16
    MOVK  X8, #0xfa07, LSL #32
    MOVK  X8, #0x7ffd, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X8, #0xa000, LSL #0
    MOVK  X8, #0xfffc, LSL #16
    MOVK  X8, #0xa000, LSL #32
    MOVK  X8, #0xfffc, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D11
    MOVZ  X8, #0xd8b9, LSL #0
    MOVK  X8, #0x7fdd, LSL #16
    MOVK  X8, #0xc6ce, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D12
    MOVZ  X8, #0x432d, LSL #0
    MOVK  X8, #0xffef, LSL #16
    MOVK  X8, #0xca82, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D13
    MOVZ  X8, #0x79cf, LSL #0
    MOVK  X8, #0xfffb, LSL #16
    MOVK  X8, #0xa289, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D14
    MOVZ  X8, #0x8082, LSL #0
    MOVK  X8, #0x5a5c, LSL #16
    MOVK  X8, #0xeaa8, LSL #32
    MOVK  X8, #0x5a5d, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D15
    MOVZ  X8, #0x6000, LSL #0
    MOVK  X8, #0xfff0, LSL #16
    MOVK  X8, #0x53b8, LSL #32
    MOVK  X8, #0x7ffd, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D16
    MOVZ  X8, #0xbd90, LSL #0
    MOVK  X8, #0x4988, LSL #16
    MOVK  X8, #0xcae, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D17
    MOVZ  X8, #0xe000, LSL #0
    MOVK  X8, #0x7fee, LSL #16
    MOVK  X8, #0xe786, LSL #32
    MOVK  X8, #0xfffc, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D18
    MOVZ  X8, #0xbae4, LSL #0
    MOVK  X8, #0x5a5b, LSL #16
    MOVK  X8, #0xbb28, LSL #32
    MOVK  X8, #0x5a5c, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D19
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D20
    MOVZ  X8, #0xef74, LSL #0
    MOVK  X8, #0x7fdd, LSL #16
    MOVK  X8, #0x68f4, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X8, #0x5fd9, LSL #0
    MOVK  X8, #0x7fd6, LSL #16
    MOVK  X8, #0xae7e, LSL #32
    MOVK  X8, #0x5a59, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D21
    MOVZ  X8, #0x459d, LSL #0
    MOVK  X8, #0xce4d, LSL #16
    MOVK  X8, #0x93d4, LSL #32
    MOVK  X8, #0x5a5c, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D22
    MOVZ  X8, #0x2f1b, LSL #0
    MOVK  X8, #0x7ff4, LSL #16
    MOVK  X8, #0xef48, LSL #32
    MOVK  X8, #0x7ffb, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X8, #0xcad1, LSL #0
    MOVK  X8, #0xdd32, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D23
    MOVZ  X8, #0xb630, LSL #0
    MOVK  X8, #0x5a88, LSL #16
    MOVK  X8, #0xdd32, LSL #32
    MOVK  X8, #0x7ffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D24
    MOVZ  X8, #0x1cd0, LSL #0
    MOVK  X8, #0xffd3, LSL #16
    MOVK  X8, #0x9570, LSL #32
    MOVK  X8, #0xfffc, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X8, #0xfae9, LSL #0
    MOVK  X8, #0x1, LSL #16
    MOVK  X8, #0x62a, LSL #32
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D25
    MOVZ  X8, #0x238a, LSL #0
    MOVK  X8, #0x3, LSL #16
    MOVK  X8, #0x6a71, LSL #32
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X8, #0x4d99, LSL #0
    MOVK  X8, #0x2, LSL #16
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D26
    MOVZ  X8, #0x2491, LSL #0
    MOVK  X8, #0x369a, LSL #16
    MOVK  X8, #0xab20, LSL #32
    MOVK  X8, #0x7ffa, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X8, #0xbdc8, LSL #0
    MOVK  X8, #0xc357, LSL #16
    MOVK  X8, #0xe000, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D27
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0xe000, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xee82, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D28
    MOVZ  X8, #0xe3e7, LSL #0
    MOVK  X8, #0x7fc7, LSL #16
    MOVK  X8, #0x8a70, LSL #32
    MOVK  X8, #0x7ffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X8, #0x8180, LSL #0
    MOVK  X8, #0x4, LSL #16
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D29
    MOVZ  X8, #0x7002, LSL #0
    MOVK  X8, #0x7feb, LSL #16
    MOVK  X8, #0x5544, LSL #32
    MOVK  X8, #0xfffa, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X8, #0x1fd6, LSL #0
    MOVK  X8, #0x4c4d, LSL #32
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D30
    MOVZ  X8, #0xa6b, LSL #0
    MOVK  X8, #0xffe3, LSL #16
    MOVK  X8, #0x288a, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X8, #0x3600, LSL #0
    MOVK  X8, #0xb9f2, LSL #16
    MOVK  X8, #0xc000, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X13, D31
    MOVZ  X8, #0x74f1, LSL #0
    MOVK  X8, #0xfff8, LSL #16
    MOVK  X8, #0xc0b4, LSL #32
    MOVK  X8, #0xfffe, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
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
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X10
    FMOV  D3, X9
    FMOV  V3.D[1], X22
    FMOV  D4, X18
    FMOV  V4.D[1], X24
    FMOV  D5, X24
    FMOV  V5.D[1], X19
    FMOV  D6, X23
    FMOV  V6.D[1], X16
    FMOV  D7, X19
    FMOV  V7.D[1], X11
    FMOV  D8, X24
    FMOV  V8.D[1], X6
    FMOV  D9, X11
    FMOV  V9.D[1], X11
    FMOV  D10, X10
    FMOV  V10.D[1], X26
    FMOV  D11, X27
    FMOV  V11.D[1], X6
    FMOV  D12, X3
    FMOV  V12.D[1], X18
    FMOV  D13, X19
    FMOV  V13.D[1], X29
    FMOV  D14, X19
    FMOV  V14.D[1], X28
    FMOV  D15, X9
    FMOV  V15.D[1], X16
    FMOV  D16, X25
    FMOV  V16.D[1], X16
    FMOV  D17, X16
    FMOV  V17.D[1], X11
    FMOV  D18, X2
    FMOV  V18.D[1], X15
    FMOV  D19, X21
    FMOV  V19.D[1], X26
    FMOV  D20, X3
    FMOV  V20.D[1], X28
    FMOV  D21, X17
    FMOV  V21.D[1], X26
    FMOV  D22, X26
    FMOV  V22.D[1], X25
    FMOV  D23, X17
    FMOV  V23.D[1], X17
    FMOV  D24, X10
    FMOV  V24.D[1], X9
    FMOV  D25, X20
    FMOV  V25.D[1], X20
    FMOV  D26, X14
    FMOV  V26.D[1], X2
    FMOV  D27, X29
    FMOV  V27.D[1], X12
    FMOV  D28, X25
    FMOV  V28.D[1], X29
    FMOV  D29, X12
    FMOV  V29.D[1], X18
    FMOV  D30, X10
    FMOV  V30.D[1], X21
    FMOV  D31, X19
    FMOV  V31.D[1], X19
    MOVZ  X24, #0xa, LSL #0
LCRTAdvsimdVectorFhmI8mm_label_14:
    FMLSL2 V2.4S, V30.4H, V8.H[0x1]
    USDOT V22.2S, V25.8B, V24.8B
    FMLAL V16.2S, V31.2H, V27.2H
    FMLSL2 V8.2S, V27.2H, V1.H[0x1]
    SUDOT V31.2S, V0.8B, V8.4B[0x0]
    SMMLA V29.4S, V28.16B, V21.16B
    SMMLA V2.4S, V22.16B, V22.16B
    UMMLA V29.4S, V1.16B, V8.16B
    SUDOT V4.2S, V29.8B, V29.4B[0x2]
    SMMLA V27.4S, V4.16B, V31.16B
    FMLAL2 V3.4S, V2.4H, V1.H[0x4]
    USDOT V7.4S, V16.16B, V23.4B[0x3]
    FMLSL2 V29.2S, V7.2H, V7.2H
    FMLAL2 V31.4S, V27.4H, V5.H[0x0]
    SMMLA V16.4S, V31.16B, V30.16B
    FMLAL V31.4S, V0.4H, V15.H[0x1]
    FMLAL V26.2S, V21.2H, V3.2H
    USMMLA V25.4S, V16.16B, V16.16B
    USDOT V7.4S, V26.16B, V25.16B
    USMMLA V24.4S, V31.16B, V29.16B
    FMLAL V25.2S, V21.2H, V28.2H
    USDOT V15.2S, V21.8B, V1.8B
    FMLSL2 V28.2S, V28.2H, V5.H[0x2]
    FMLAL V31.4S, V2.4H, V9.H[0x7]
    USDOT V28.2S, V27.8B, V7.8B
    FMLSL2 V21.4S, V7.4H, V12.H[0x7]
    SUDOT V27.4S, V22.16B, V16.4B[0x3]
    FMLSL2 V29.2S, V31.2H, V26.2H
    FMLSL2 V11.2S, V5.2H, V2.H[0x3]
    FMLAL2 V25.4S, V7.4H, V8.H[0x0]
    USMMLA V26.4S, V4.16B, V6.16B
    FMLSL2 V23.4S, V27.4H, V11.H[0x2]
    FMLSL2 V12.2S, V0.2H, V15.H[0x4]
    FMLSL V31.2S, V25.2H, V1.H[0x6]
    SUDOT V7.2S, V24.8B, V21.4B[0x3]
    USDOT V19.2S, V28.8B, V12.8B
    FMLAL2 V1.2S, V15.2H, V7.2H
    FMLSL V3.2S, V31.2H, V31.2H
    SUDOT V27.2S, V1.8B, V23.4B[0x3]
    FMLAL V31.4S, V27.4H, V3.H[0x1]
    FMLAL2 V22.4S, V28.4H, V7.H[0x7]
    USDOT V30.2S, V19.8B, V20.4B[0x3]
    FMLAL2 V23.2S, V31.2H, V15.2H
    UMMLA V9.4S, V12.16B, V23.16B
    USMMLA V3.4S, V30.16B, V26.16B
    FMLSL V1.4S, V26.4H, V1.4H
    FMLAL V25.2S, V12.2H, V14.H[0x4]
    UMMLA V15.4S, V1.16B, V27.16B
    FMLSL V7.4S, V29.4H, V4.H[0x0]
    UMMLA V30.4S, V11.16B, V22.16B
    USDOT V31.4S, V9.16B, V30.16B
    USMMLA V1.4S, V14.16B, V9.16B
    USDOT V27.2S, V5.8B, V7.8B
    USDOT V23.2S, V25.8B, V15.4B[0x0]
    FMLSL V16.2S, V27.2H, V1.2H
    SMMLA V20.4S, V23.16B, V31.16B
    USDOT V6.2S, V20.8B, V9.4B[0x3]
    FMLAL2 V30.2S, V24.2H, V3.H[0x2]
    FMLAL V25.2S, V24.2H, V8.H[0x4]
    USDOT V6.4S, V16.16B, V2.16B
    USMMLA V8.4S, V6.16B, V25.16B
    SUDOT V23.4S, V15.16B, V29.4B[0x3]
    FMLSL V7.2S, V12.2H, V9.2H
    FMLSL V28.2S, V24.2H, V12.H[0x3]
    USMMLA V20.4S, V29.16B, V11.16B
    SUDOT V27.2S, V20.8B, V5.4B[0x2]
    USDOT V16.2S, V29.8B, V0.8B
    FMLSL2 V4.4S, V2.4H, V29.4H
    USDOT V15.4S, V28.16B, V14.16B
    FMLAL V0.4S, V14.4H, V12.H[0x4]
    FMLSL V28.2S, V27.2H, V30.2H
    USDOT V2.2S, V14.8B, V11.8B
    USDOT V27.2S, V18.8B, V8.8B
    USDOT V7.4S, V23.16B, V23.4B[0x2]
    SMMLA V20.4S, V27.16B, V15.16B
    SUDOT V5.4S, V31.16B, V2.4B[0x2]
    USMMLA V6.4S, V5.16B, V20.16B
    FMLAL2 V4.2S, V7.2H, V6.H[0x6]
    USDOT V23.4S, V7.16B, V4.4B[0x2]
    USDOT V8.2S, V27.8B, V0.8B
    SUDOT V11.2S, V0.8B, V25.4B[0x0]
    FMLAL V7.4S, V3.4H, V8.4H
    USDOT V24.4S, V11.16B, V30.4B[0x2]
    USMMLA V0.4S, V24.16B, V23.16B
    FMLSL V23.4S, V31.4H, V7.H[0x0]
    FMLSL V9.2S, V1.2H, V14.2H
    FMLSL V25.2S, V29.2H, V6.H[0x1]
    FMLAL V15.4S, V5.4H, V28.4H
    SMMLA V12.4S, V9.16B, V25.16B
    SUDOT V27.2S, V15.8B, V12.4B[0x0]
    FMLAL V15.4S, V0.4H, V1.H[0x6]
    USMMLA V8.4S, V23.16B, V8.16B
    USDOT V24.2S, V27.8B, V27.4B[0x1]
    UMMLA V14.4S, V11.16B, V6.16B
    USDOT V25.2S, V16.8B, V14.8B
    FMLSL V20.4S, V24.4H, V3.4H
    FMLSL2 V4.2S, V20.2H, V14.2H
    UMMLA V29.4S, V4.16B, V16.16B
    FMLAL2 V22.2S, V15.2H, V17.2H
    FMLAL2 V9.2S, V8.2H, V11.2H
    FMLSL V24.4S, V22.4H, V4.4H
    SMMLA V27.4S, V13.16B, V24.16B
    USMMLA V15.4S, V19.16B, V25.16B
    FMLAL2 V12.2S, V9.2H, V9.H[0x2]
    SUDOT V28.4S, V29.16B, V12.4B[0x0]
    SMMLA V29.4S, V27.16B, V3.16B
    USDOT V4.2S, V8.8B, V15.4B[0x0]
    SUDOT V5.4S, V29.16B, V4.4B[0x2]
    FMLSL V12.4S, V14.4H, V0.H[0x7]
    FMLSL2 V24.2S, V10.2H, V14.H[0x6]
    FMLAL2 V11.2S, V19.2H, V2.H[0x4]
    FMLAL2 V7.2S, V24.2H, V1.H[0x5]
    USDOT V17.2S, V3.8B, V20.8B
    FMLAL V13.4S, V5.4H, V31.4H
    FMLAL V23.2S, V24.2H, V15.H[0x4]
    USDOT V14.2S, V16.8B, V16.8B
    SUDOT V10.2S, V4.8B, V9.4B[0x0]
    SUDOT V5.2S, V23.8B, V14.4B[0x2]
    USDOT V14.2S, V2.8B, V6.8B
    USDOT V0.2S, V11.8B, V8.4B[0x1]
    FMLAL V29.2S, V24.2H, V7.H[0x7]
    FMLSL2 V6.4S, V0.4H, V13.4H
    FMLAL V16.2S, V12.2H, V6.H[0x1]
    SMMLA V31.4S, V28.16B, V23.16B
    FMLSL V0.4S, V29.4H, V16.4H
    USDOT V31.2S, V10.8B, V17.4B[0x3]
    FMLAL V7.2S, V5.2H, V5.H[0x3]
    FMLAL2 V29.4S, V31.4H, V14.H[0x6]
    FMLSL2 V8.2S, V26.2H, V0.H[0x1]
    USDOT V1.4S, V28.16B, V23.16B
    SMMLA V19.4S, V2.16B, V29.16B
    USDOT V12.4S, V19.16B, V19.16B
    FMLAL2 V17.4S, V8.4H, V15.4H
    FMLAL V29.4S, V17.4H, V12.H[0x2]
    SUDOT V0.2S, V7.8B, V29.4B[0x1]
    USDOT V29.4S, V4.16B, V18.16B
    FMLAL2 V15.4S, V1.4H, V13.H[0x1]
    FMLSL2 V13.2S, V10.2H, V7.2H
    FMLAL2 V25.2S, V6.2H, V1.H[0x7]
    SUDOT V18.4S, V22.16B, V30.4B[0x2]
    FMLAL2 V14.2S, V19.2H, V27.2H
    FMLAL2 V23.4S, V1.4H, V10.4H
    SMMLA V11.4S, V31.16B, V24.16B
    FMLSL2 V9.2S, V25.2H, V25.2H
    FMLSL2 V26.2S, V23.2H, V8.2H
    FMLAL V12.2S, V30.2H, V9.2H
    FMLSL V25.4S, V12.4H, V11.H[0x4]
    SUDOT V11.4S, V18.16B, V13.4B[0x1]
    FMLAL2 V7.4S, V25.4H, V29.4H
    FMLSL2 V7.4S, V15.4H, V14.4H
    FMLAL V21.2S, V18.2H, V11.H[0x4]
    UMMLA V8.4S, V6.16B, V7.16B
    FMLSL V22.4S, V8.4H, V0.H[0x4]
    FMLSL V1.2S, V30.2H, V21.2H
    FMLSL V27.4S, V11.4H, V1.4H
    SMMLA V29.4S, V27.16B, V18.16B
    SMMLA V31.4S, V28.16B, V0.16B
    SMMLA V23.4S, V21.16B, V22.16B
    USMMLA V10.4S, V29.16B, V3.16B
    SMMLA V4.4S, V26.16B, V31.16B
    SUDOT V8.2S, V4.8B, V10.4B[0x3]
    USDOT V22.2S, V25.8B, V24.4B[0x1]
    USDOT V9.4S, V3.16B, V6.16B
    FMLSL V15.4S, V4.4H, V8.4H
    USDOT V18.2S, V7.8B, V14.4B[0x1]
    UMMLA V10.4S, V24.16B, V28.16B
    USDOT V13.2S, V14.8B, V11.8B
    FMLSL2 V8.2S, V13.2H, V4.H[0x4]
    FMLAL2 V14.2S, V17.2H, V3.H[0x4]
    USDOT V7.4S, V5.16B, V4.4B[0x0]
    FMLAL2 V27.4S, V15.4H, V15.H[0x6]
    USMMLA V12.4S, V22.16B, V23.16B
    USDOT V0.4S, V27.16B, V10.16B
    USDOT V11.4S, V7.16B, V14.4B[0x0]
    USDOT V21.4S, V9.16B, V18.16B
    FMLSL V15.4S, V21.4H, V0.H[0x7]
    FMLSL2 V6.4S, V1.4H, V12.4H
    USDOT V0.4S, V6.16B, V30.16B
    USMMLA V24.4S, V0.16B, V11.16B
    UMMLA V10.4S, V22.16B, V24.16B
    USDOT V17.2S, V10.8B, V19.8B
    FMLAL2 V28.4S, V8.4H, V8.4H
    FMLAL2 V30.2S, V3.2H, V15.H[0x5]
    SMMLA V6.4S, V17.16B, V30.16B
    USDOT V0.4S, V25.16B, V23.16B
    UMMLA V26.4S, V13.16B, V11.16B
    FMLAL2 V19.4S, V18.4H, V0.4H
    FMLSL2 V18.4S, V29.4H, V14.H[0x4]
    SUDOT V19.4S, V20.16B, V19.4B[0x0]
    FMLAL2 V8.4S, V13.4H, V30.4H
    SUDOT V15.4S, V3.16B, V18.4B[0x2]
    USDOT V27.2S, V4.8B, V24.8B
    UMMLA V0.4S, V9.16B, V2.16B
    FMLAL V29.2S, V12.2H, V15.H[0x1]
    FMLAL V14.2S, V19.2H, V9.2H
    USDOT V5.2S, V13.8B, V15.8B
    FMLSL2 V30.2S, V27.2H, V7.H[0x2]
    UMMLA V4.4S, V8.16B, V28.16B
    UMMLA V17.4S, V15.16B, V6.16B
    FMLSL2 V7.2S, V3.2H, V27.2H
    SUBS  X24, X24, #0x1
    B.NE  LCRTAdvsimdVectorFhmI8mm_label_14
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFhmI8mm_TestFail
    MRS  X3, FPSR
    MOVZ  X15, #0x91, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xfe03, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D0
    MOVZ  X15, #0xe259, LSL #0
    MOVK  X15, #0x4ac6, LSL #16
    MOVK  X15, #0xbdf9, LSL #32
    MOVK  X15, #0x7ffd, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D1
    MOVZ  X15, #0xeaa9, LSL #0
    MOVK  X15, #0x7fc9, LSL #16
    MOVK  X15, #0x85e, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D2
    MOVZ  X15, #0xbcc5, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0xb232, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D3
    MOVZ  X15, #0x13be, LSL #0
    MOVK  X15, #0x7fca, LSL #16
    MOVK  X15, #0x2000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D4
    MOVZ  X15, #0x43a6, LSL #0
    MOVK  X15, #0x8002, LSL #16
    MOVK  X15, #0x92cc, LSL #32
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D5
    MOVZ  X15, #0xf742, LSL #0
    MOVK  X15, #0xa5a6, LSL #16
    MOVK  X15, #0x643f, LSL #32
    MOVK  X15, #0xa5a7, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xe000, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D6
    MOVZ  X15, #0xe2e4, LSL #0
    MOVK  X15, #0xa5a2, LSL #16
    MOVK  X15, #0x4a3c, LSL #32
    MOVK  X15, #0xa5a4, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D7
    MOVZ  X15, #0x7d09, LSL #0
    MOVK  X15, #0x7fe0, LSL #16
    MOVK  X15, #0xe6e9, LSL #32
    MOVK  X15, #0x7ffd, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D8
    MOVZ  X15, #0xfc2e, LSL #0
    MOVK  X15, #0x7ffb, LSL #16
    MOVK  X15, #0xc000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D9
    MOVZ  X15, #0x2d83, LSL #0
    MOVK  X15, #0xffc5, LSL #16
    MOVK  X15, #0xb17a, LSL #32
    MOVK  X15, #0x7ff9, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X15, #0x19b3, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D10
    MOVZ  X15, #0x58e6, LSL #0
    MOVK  X15, #0xa5d3, LSL #16
    MOVK  X15, #0x7d54, LSL #32
    MOVK  X15, #0xa5b6, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xcafb, LSL #32
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D11
    MOVZ  X15, #0x1758, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0xb50d, LSL #32
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D12
    MOVZ  X15, #0xe666, LSL #0
    MOVK  X15, #0x7fdf, LSL #16
    MOVK  X15, #0xb8e6, LSL #32
    MOVK  X15, #0x7ff0, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D13
    MOVZ  X15, #0xa031, LSL #0
    MOVK  X15, #0xffea, LSL #16
    MOVK  X15, #0x9c2c, LSL #32
    MOVK  X15, #0x7ffe, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D14
    MOVZ  X15, #0xa47, LSL #0
    MOVK  X15, #0x4c79, LSL #16
    MOVK  X15, #0x2008, LSL #32
    MOVK  X15, #0x7ffc, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xe000, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D15
    MOVZ  X15, #0xc000, LSL #0
    MOVK  X15, #0xffc5, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D16
    MOVZ  X15, #0x5d5f, LSL #0
    MOVK  X15, #0x7fca, LSL #16
    MOVK  X15, #0x72b1, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X15, #0x9a30, LSL #0
    MOVK  X15, #0x2, LSL #16
    MOVK  X15, #0x102, LSL #32
    MOVK  X15, #0x2, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D17
    MOVZ  X15, #0x864a, LSL #0
    MOVK  X15, #0x2, LSL #16
    MOVK  X15, #0xd8cc, LSL #32
    MOVK  X15, #0xa5b6, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D18
    MOVZ  X15, #0xb74c, LSL #0
    MOVK  X15, #0xa5a8, LSL #16
    MOVK  X15, #0xefc8, LSL #32
    MOVK  X15, #0x7ffc, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X15, #0xbd59, LSL #0
    MOVK  X15, #0xffc0, LSL #16
    MOVK  X15, #0xc1ce, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D19
    MOVZ  X15, #0x7325, LSL #0
    MOVK  X15, #0xfff4, LSL #16
    MOVK  X15, #0x14f4, LSL #32
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X15, #0x411e, LSL #0
    MOVK  X15, #0xc94a, LSL #16
    MOVK  X15, #0xe000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D20
    MOVZ  X15, #0x57c8, LSL #0
    MOVK  X15, #0x4923, LSL #16
    MOVK  X15, #0xe2b5, LSL #32
    MOVK  X15, #0x7ff9, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D21
    MOVZ  X15, #0xf619, LSL #0
    MOVK  X15, #0x3ae5, LSL #16
    MOVK  X15, #0x475d, LSL #32
    MOVK  X15, #0x3ae7, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D22
    MOVZ  X15, #0x1635, LSL #0
    MOVK  X15, #0x7fc6, LSL #16
    MOVK  X15, #0x6828, LSL #32
    MOVK  X15, #0x8000, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xe000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D23
    MOVZ  X15, #0xa4b5, LSL #0
    MOVK  X15, #0x7fce, LSL #16
    MOVK  X15, #0xc000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D24
    MOVZ  X15, #0x4aa1, LSL #0
    MOVK  X15, #0x4b1e, LSL #16
    MOVK  X15, #0xdae8, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xfffe, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D25
    MOVZ  X15, #0x58f2, LSL #0
    MOVK  X15, #0xffe2, LSL #16
    MOVK  X15, #0xe000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D26
    MOVZ  X15, #0xe4f3, LSL #0
    MOVK  X15, #0xffc4, LSL #16
    MOVK  X15, #0x4e22, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D27
    MOVZ  X15, #0x2252, LSL #0
    MOVK  X15, #0x7fe5, LSL #16
    MOVK  X15, #0xb734, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D28
    MOVZ  X15, #0x421a, LSL #0
    MOVK  X15, #0x7ffc, LSL #16
    MOVK  X15, #0x447, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D29
    MOVZ  X15, #0x8113, LSL #0
    MOVK  X15, #0xfff0, LSL #16
    MOVK  X15, #0x83e8, LSL #32
    MOVK  X15, #0xffde, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D30
    MOVZ  X15, #0xe000, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xaecd, LSL #32
    MOVK  X15, #0x7ffb, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail
    FMOV  X3, D31
    MOVZ  X15, #0xa027, LSL #0
    MOVK  X15, #0x7ffe, LSL #16
    MOVK  X15, #0x8d09, LSL #32
    MOVK  X15, #0x7ffe, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFhmI8mm_TestFail

LCRTAdvsimdVectorFhmI8mm_TestEnd:
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
LCRTAdvsimdVectorFhmI8mm_TestFail:
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
