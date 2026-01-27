.global TSRTAdvsimdVectorSignedOperation

.text
.p2align 4

TSRTAdvsimdVectorSignedOperation:

TSRTAdvsimdVectorSignedOperation_TestBegin:
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
    MOVZ  X2, #0x9670, LSL #0
    MOVK  X2, #0x9ffa, LSL #16
    MOVK  X2, #0x9a77, LSL #32
    MOVK  X2, #0xc5c0, LSL #48
    MOVZ  X3, #0x5e57, LSL #0
    MOVK  X3, #0x9f78, LSL #16
    MOVK  X3, #0x9a75, LSL #32
    MOVK  X3, #0xf154, LSL #48
    MOVZ  X4, #0xbd87, LSL #0
    MOVK  X4, #0x4ec2, LSL #16
    MOVK  X4, #0xc0be, LSL #32
    MOVK  X4, #0xb996, LSL #48
    MOVZ  X5, #0xc4f0, LSL #0
    MOVK  X5, #0x992e, LSL #16
    MOVK  X5, #0xc0b5, LSL #32
    MOVK  X5, #0x698b, LSL #48
    MOVZ  X6, #0xcb2b, LSL #0
    MOVK  X6, #0x9f8a, LSL #16
    MOVK  X6, #0x70b9, LSL #32
    MOVK  X6, #0xe449, LSL #48
    MOVZ  X7, #0x989d, LSL #0
    MOVK  X7, #0xee8d, LSL #16
    MOVK  X7, #0xe382, LSL #32
    MOVK  X7, #0x8535, LSL #48
    MOVZ  X8, #0xb5d9, LSL #0
    MOVK  X8, #0xf985, LSL #16
    MOVK  X8, #0xcea2, LSL #32
    MOVK  X8, #0x66b4, LSL #48
    MOVZ  X9, #0xbfe4, LSL #0
    MOVK  X9, #0x1644, LSL #16
    MOVK  X9, #0xdffb, LSL #32
    MOVK  X9, #0x835, LSL #48
    MOVZ  X10, #0xf81, LSL #0
    MOVK  X10, #0xa21a, LSL #16
    MOVK  X10, #0xa314, LSL #32
    MOVK  X10, #0xcd75, LSL #48
    MOVZ  X16, #0x8ed4, LSL #0
    MOVK  X16, #0xcf5b, LSL #16
    MOVK  X16, #0xcf86, LSL #32
    MOVK  X16, #0xcc0c, LSL #48
    MOVZ  X17, #0x5007, LSL #0
    MOVK  X17, #0xe49a, LSL #16
    MOVK  X17, #0xc65c, LSL #32
    MOVK  X17, #0x5940, LSL #48
    MOVZ  X18, #0xe91a, LSL #0
    MOVK  X18, #0xf854, LSL #16
    MOVK  X18, #0xbf0c, LSL #32
    MOVK  X18, #0x3225, LSL #48
    MOVZ  X19, #0xd6c5, LSL #0
    MOVK  X19, #0x3e68, LSL #16
    MOVK  X19, #0x3a15, LSL #32
    MOVK  X19, #0x870e, LSL #48
    MOVZ  X20, #0xcdc7, LSL #0
    MOVK  X20, #0x2f32, LSL #16
    MOVK  X20, #0xabb0, LSL #32
    MOVK  X20, #0xd375, LSL #48
    MOVZ  X21, #0x2c64, LSL #0
    MOVK  X21, #0x33f0, LSL #16
    MOVK  X21, #0x41f3, LSL #32
    MOVK  X21, #0xc502, LSL #48
    MOVZ  X22, #0xe4b9, LSL #0
    MOVK  X22, #0xc82f, LSL #16
    MOVK  X22, #0xa63f, LSL #32
    MOVK  X22, #0x8576, LSL #48
    MOVZ  X23, #0xe9f1, LSL #0
    MOVK  X23, #0x9736, LSL #16
    MOVK  X23, #0x60ae, LSL #32
    MOVK  X23, #0x6811, LSL #48
    MOVZ  X24, #0x1eae, LSL #0
    MOVK  X24, #0xd1b4, LSL #16
    MOVK  X24, #0x5992, LSL #32
    MOVK  X24, #0xa8b, LSL #48
    MOVZ  X25, #0xb873, LSL #0
    MOVK  X25, #0x5238, LSL #16
    MOVK  X25, #0x9df1, LSL #32
    MOVK  X25, #0x48b5, LSL #48
    MOVZ  X26, #0x3d22, LSL #0
    MOVK  X26, #0x1e54, LSL #16
    MOVK  X26, #0x6bf6, LSL #32
    MOVK  X26, #0x6932, LSL #48
    MOVZ  X27, #0xe566, LSL #0
    MOVK  X27, #0x8bca, LSL #16
    MOVK  X27, #0x99e6, LSL #32
    MOVK  X27, #0x2176, LSL #48
    MOVZ  X28, #0xbd75, LSL #0
    MOVK  X28, #0x19d6, LSL #16
    MOVK  X28, #0xe3d4, LSL #32
    MOVK  X28, #0x386a, LSL #48
    MOVZ  X29, #0xe7ae, LSL #0
    MOVK  X29, #0x1ff5, LSL #16
    MOVK  X29, #0x4c8b, LSL #32
    MOVK  X29, #0x96f0, LSL #48
    MOVZ  X17, #0xa5f, LSL #0
    MOVK  X17, #0xa9, LSL #16
    MOVK  X17, #0x8118, LSL #32
    MOVK  X17, #0x388b, LSL #48
    MSR  FPCR, X17
    MRS  X23, FPCR
    MOVZ  X26, #0x60ff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    AND  X23, X23, X26
    MOVZ  X26, #0x0, LSL #0
    ORR  X23, X23, X26
    MSR  FPCR, X23
    ISB  SY
    MOVZ  X17, #0x5653, LSL #0
    MOVK  X17, #0xa1b9, LSL #16
    MOVK  X17, #0x5c24, LSL #32
    MOVK  X17, #0x6b08, LSL #48
    MSR  FPSR, X17
    MRS  X24, FPSR
    MOVZ  X26, #0xff60, LSL #0
    MOVK  X26, #0x7ff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    AND  X24, X24, X26
    MOVZ  X26, #0x0, LSL #0
    ORR  X24, X24, X26
    MSR  FPSR, X24
    ISB  SY
    ADDS  W23, W23, #0xc6c
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x1f76, LSL #0
    MOVK  X2, #0x808a, LSL #16
    MOVK  X2, #0xc4f3, LSL #32
    MOVK  X2, #0x5ce, LSL #48
    MOVZ  X3, #0x341c, LSL #0
    MOVK  X3, #0x4a07, LSL #16
    MOVK  X3, #0xcd8a, LSL #32
    MOVK  X3, #0xa95e, LSL #48
    MOVZ  X4, #0x3ca9, LSL #0
    MOVK  X4, #0x51a9, LSL #16
    MOVK  X4, #0x5b99, LSL #32
    MOVK  X4, #0x66ec, LSL #48
    MOVZ  X5, #0x718d, LSL #0
    MOVK  X5, #0x2d44, LSL #16
    MOVK  X5, #0xbad7, LSL #32
    MOVK  X5, #0xd2dd, LSL #48
    MOVZ  X6, #0xeae1, LSL #0
    MOVK  X6, #0x3906, LSL #16
    MOVK  X6, #0xfb15, LSL #32
    MOVK  X6, #0x2bc0, LSL #48
    MOVZ  X7, #0x4ff6, LSL #0
    MOVK  X7, #0xac68, LSL #16
    MOVK  X7, #0xc4, LSL #32
    MOVK  X7, #0xf329, LSL #48
    MOVZ  X8, #0x946b, LSL #0
    MOVK  X8, #0x37cb, LSL #16
    MOVK  X8, #0x2d0e, LSL #32
    MOVK  X8, #0xcc37, LSL #48
    MOVZ  X9, #0x2c88, LSL #0
    MOVK  X9, #0xe466, LSL #16
    MOVK  X9, #0x9f7f, LSL #32
    MOVK  X9, #0x610e, LSL #48
    MOVZ  X10, #0x7c52, LSL #0
    MOVK  X10, #0xf13d, LSL #16
    MOVK  X10, #0xc6d7, LSL #32
    MOVK  X10, #0xbe1, LSL #48
    MOVZ  X16, #0xa1d, LSL #0
    MOVK  X16, #0x62fb, LSL #16
    MOVK  X16, #0x71f9, LSL #32
    MOVK  X16, #0x6264, LSL #48
    MOVZ  X17, #0x25dd, LSL #0
    MOVK  X17, #0xc507, LSL #16
    MOVK  X17, #0x92c6, LSL #32
    MOVK  X17, #0x8213, LSL #48
    MOVZ  X18, #0x7518, LSL #0
    MOVK  X18, #0x7831, LSL #16
    MOVK  X18, #0x143f, LSL #32
    MOVK  X18, #0x7e4e, LSL #48
    MOVZ  X19, #0xf087, LSL #0
    MOVK  X19, #0x42b4, LSL #16
    MOVK  X19, #0xb04, LSL #32
    MOVK  X19, #0x55c2, LSL #48
    MOVZ  X20, #0x58fa, LSL #0
    MOVK  X20, #0xeec6, LSL #16
    MOVK  X20, #0xdaec, LSL #32
    MOVK  X20, #0xf378, LSL #48
    MOVZ  X21, #0x2843, LSL #0
    MOVK  X21, #0xd580, LSL #16
    MOVK  X21, #0xcef0, LSL #32
    MOVK  X21, #0xe573, LSL #48
    MOVZ  X22, #0xace1, LSL #0
    MOVK  X22, #0x59d4, LSL #16
    MOVK  X22, #0xf0b3, LSL #32
    MOVK  X22, #0x70e6, LSL #48
    MOVZ  X23, #0x6430, LSL #0
    MOVK  X23, #0x75f8, LSL #16
    MOVK  X23, #0xa4d6, LSL #32
    MOVK  X23, #0x2dc3, LSL #48
    MOVZ  X24, #0x9fa7, LSL #0
    MOVK  X24, #0xcd4b, LSL #16
    MOVK  X24, #0x8bb0, LSL #32
    MOVK  X24, #0x1d98, LSL #48
    MOVZ  X25, #0xc360, LSL #0
    MOVK  X25, #0x5e6f, LSL #16
    MOVK  X25, #0xdbfd, LSL #32
    MOVK  X25, #0xe483, LSL #48
    MOVZ  X26, #0xadc1, LSL #0
    MOVK  X26, #0x15ad, LSL #16
    MOVK  X26, #0xa32e, LSL #32
    MOVK  X26, #0xcbcb, LSL #48
    MOVZ  X27, #0xd7c9, LSL #0
    MOVK  X27, #0x7b5c, LSL #16
    MOVK  X27, #0x143c, LSL #32
    MOVK  X27, #0x1f50, LSL #48
    MOVZ  X28, #0xd27f, LSL #0
    MOVK  X28, #0x24d2, LSL #16
    MOVK  X28, #0x4438, LSL #32
    MOVK  X28, #0xc18f, LSL #48
    MOVZ  X29, #0xc420, LSL #0
    MOVK  X29, #0xa30d, LSL #16
    MOVK  X29, #0xd582, LSL #32
    MOVK  X29, #0x6357, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X18
    FMOV  V1.D[1], X25
    FMOV  D2, X16
    FMOV  V2.D[1], X8
    FMOV  D3, X24
    FMOV  V3.D[1], X29
    FMOV  D4, X8
    FMOV  V4.D[1], X28
    FMOV  D5, X10
    FMOV  V5.D[1], X7
    FMOV  D6, X2
    FMOV  V6.D[1], X18
    FMOV  D7, X4
    FMOV  V7.D[1], X25
    FMOV  D8, X26
    FMOV  V8.D[1], X28
    FMOV  D9, X26
    FMOV  V9.D[1], X3
    FMOV  D10, X3
    FMOV  V10.D[1], X29
    FMOV  D11, X10
    FMOV  V11.D[1], X5
    FMOV  D12, X5
    FMOV  V12.D[1], X28
    FMOV  D13, X7
    FMOV  V13.D[1], X18
    FMOV  D14, X8
    FMOV  V14.D[1], X23
    FMOV  D15, X26
    FMOV  V15.D[1], X7
    FMOV  D16, X17
    FMOV  V16.D[1], X25
    FMOV  D17, X5
    FMOV  V17.D[1], X5
    FMOV  D18, X26
    FMOV  V18.D[1], X23
    FMOV  D19, X2
    FMOV  V19.D[1], X17
    FMOV  D20, X26
    FMOV  V20.D[1], X20
    FMOV  D21, X3
    FMOV  V21.D[1], X7
    FMOV  D22, X5
    FMOV  V22.D[1], X16
    FMOV  D23, X21
    FMOV  V23.D[1], X22
    FMOV  D24, X20
    FMOV  V24.D[1], X24
    FMOV  D25, X29
    FMOV  V25.D[1], X17
    FMOV  D26, X8
    FMOV  V26.D[1], X7
    FMOV  D27, X27
    FMOV  V27.D[1], X4
    FMOV  D28, X23
    FMOV  V28.D[1], X4
    FMOV  D29, X8
    FMOV  V29.D[1], X17
    FMOV  D30, X16
    FMOV  V30.D[1], X22
    FMOV  D31, X10
    FMOV  V31.D[1], X22
    SABA  V21.2S, V0.2S, V27.2S
    SABA  V19.2S, V4.2S, V31.2S
    SABA  V29.16B, V8.16B, V11.16B
    SABA  V16.4H, V28.4H, V28.4H
    SABA  V10.4S, V24.4S, V16.4S
    SABA  V13.4S, V25.4S, V29.4S
    SABA  V7.4S, V1.4S, V10.4S
    SABA  V27.8H, V7.8H, V10.8H
    SABA  V15.4H, V2.4H, V2.4H
    SABA  V20.8H, V28.8H, V15.8H
    SABAL  V1.4S, V23.4H, V13.4H
    SABAL  V11.2D, V27.2S, V30.2S
    SABAL  V31.4S, V3.4H, V19.4H
    SABAL  V4.8H, V20.8B, V21.8B
    SABAL  V19.8H, V1.8B, V11.8B
    SABAL  V23.8H, V26.8B, V4.8B
    SABAL  V2.4S, V17.4H, V23.4H
    SABAL  V17.2D, V16.2S, V19.2S
    SABAL  V16.2D, V2.2S, V8.2S
    SABAL  V7.2D, V31.2S, V17.2S
    SABAL2  V24.8H, V3.16B, V8.16B
    SABAL2  V2.2D, V26.4S, V30.4S
    SABAL2  V1.4S, V26.8H, V1.8H
    SABAL2  V8.2D, V14.4S, V0.4S
    SABAL2  V19.8H, V29.16B, V28.16B
    SABAL2  V0.8H, V14.16B, V25.16B
    SABAL2  V23.2D, V10.4S, V3.4S
    SABAL2  V10.4S, V23.8H, V25.8H
    SABAL2  V31.4S, V7.8H, V26.8H
    SABAL2  V16.2D, V25.4S, V13.4S
    SABD  V3.16B, V19.16B, V31.16B
    SABD  V7.8B, V1.8B, V20.8B
    SABD  V26.8H, V10.8H, V30.8H
    SABD  V5.2S, V25.2S, V15.2S
    SABD  V28.2S, V5.2S, V2.2S
    SABD  V18.8H, V12.8H, V19.8H
    SABD  V19.16B, V0.16B, V18.16B
    SABD  V20.4H, V3.4H, V20.4H
    SABD  V2.4H, V28.4H, V19.4H
    SABD  V27.4H, V13.4H, V20.4H
    SABDL  V11.4S, V20.4H, V16.4H
    SABDL  V23.8H, V26.8B, V19.8B
    SABDL  V30.4S, V28.4H, V11.4H
    SABDL  V14.8H, V23.8B, V30.8B
    SABDL  V15.2D, V18.2S, V9.2S
    SABDL  V28.2D, V0.2S, V14.2S
    SABDL  V13.2D, V11.2S, V11.2S
    SABDL  V17.2D, V8.2S, V27.2S
    SABDL  V27.2D, V24.2S, V24.2S
    SABDL  V10.2D, V24.2S, V27.2S
    SABDL2  V0.2D, V28.4S, V16.4S
    SABDL2  V19.2D, V10.4S, V2.4S
    SABDL2  V20.2D, V26.4S, V13.4S
    SABDL2  V15.2D, V17.4S, V24.4S
    SABDL2  V17.8H, V28.16B, V7.16B
    SABDL2  V1.4S, V13.8H, V20.8H
    SABDL2  V27.2D, V19.4S, V3.4S
    SABDL2  V7.4S, V1.8H, V27.8H
    SABDL2  V8.2D, V17.4S, V14.4S
    SABDL2  V17.2D, V8.4S, V7.4S
    SADALP  V14.4H, V17.8B
    SADALP  V19.2S, V15.4H
    SADALP  V13.2D, V30.4S
    SADALP  V5.2D, V1.4S
    SADALP  V26.2S, V0.4H
    SADALP  V29.1D, V5.2S
    SADALP  V17.1D, V27.2S
    SADALP  V30.4S, V17.8H
    SADALP  V17.4H, V22.8B
    SADALP  V20.8H, V17.16B
    SADDL  V5.4S, V29.4H, V26.4H
    SADDL  V15.8H, V26.8B, V3.8B
    SADDL  V24.8H, V13.8B, V1.8B
    SADDL  V0.8H, V14.8B, V12.8B
    SADDL  V12.4S, V20.4H, V30.4H
    SADDL  V27.2D, V0.2S, V3.2S
    SADDL  V2.8H, V12.8B, V27.8B
    SADDL  V19.8H, V22.8B, V4.8B
    SADDL  V7.8H, V2.8B, V9.8B
    SADDL  V13.2D, V31.2S, V19.2S
    SADDL2  V29.4S, V5.8H, V0.8H
    SADDL2  V31.4S, V18.8H, V13.8H
    SADDL2  V4.8H, V1.16B, V7.16B
    SADDL2  V27.8H, V31.16B, V29.16B
    SADDL2  V19.2D, V4.4S, V19.4S
    SADDL2  V21.8H, V19.16B, V24.16B
    SADDL2  V5.2D, V26.4S, V21.4S
    SADDL2  V0.2D, V27.4S, V15.4S
    SADDL2  V3.2D, V15.4S, V19.4S
    SADDL2  V23.8H, V2.16B, V5.16B
    SADDLP  V26.8H, V24.16B
    SADDLP  V20.8H, V25.16B
    SADDLP  V12.4S, V0.8H
    SADDLP  V19.2S, V28.4H
    SADDLP  V18.4S, V31.8H
    SADDLP  V24.4H, V22.8B
    SADDLP  V28.2D, V12.4S
    SADDLP  V31.2D, V13.4S
    SADDLP  V29.8H, V28.16B
    SADDLP  V5.1D, V23.2S
    SADDLV  H4, V26.16B
    SADDLV  H26, V12.8B
    SADDLV  H0, V31.16B
    SADDLV  H28, V29.8B
    SADDLV  H4, V14.8B
    SADDLV  H22, V5.16B
    SADDLV  H25, V26.8B
    SADDLV  H27, V0.8B
    SADDLV  H14, V31.8B
    SADDLV  H13, V27.16B
    SADDLV  S31, V25.8H
    SADDLV  S29, V24.8H
    SADDLV  S23, V3.4H
    SADDLV  S29, V22.8H
    SADDLV  S24, V6.4H
    SADDLV  S6, V4.4H
    SADDLV  S0, V29.8H
    SADDLV  S25, V14.8H
    SADDLV  S4, V22.4H
    SADDLV  S22, V20.4H
    SADDLV  D28, V4.4S
    SADDLV  D27, V22.4S
    SADDLV  D12, V7.4S
    SADDLV  D7, V12.4S
    SADDLV  D4, V7.4S
    SADDLV  D3, V25.4S
    SADDLV  D20, V24.4S
    SADDLV  D2, V10.4S
    SADDLV  D10, V20.4S
    SADDLV  D12, V6.4S
    SADDW  V25.4S, V23.4S, V12.4H
    SADDW  V29.4S, V25.4S, V2.4H
    SADDW  V23.8H, V0.8H, V10.8B
    SADDW  V0.4S, V27.4S, V28.4H
    SADDW  V24.4S, V23.4S, V28.4H
    SADDW  V15.8H, V30.8H, V4.8B
    SADDW  V13.4S, V3.4S, V31.4H
    SADDW  V25.4S, V0.4S, V25.4H
    SADDW  V12.4S, V25.4S, V24.4H
    SADDW  V25.4S, V0.4S, V29.4H
    SADDW2  V24.4S, V13.4S, V12.8H
    SADDW2  V13.8H, V15.8H, V24.16B
    SADDW2  V10.2D, V29.2D, V22.4S
    SADDW2  V6.4S, V22.4S, V3.8H
    SADDW2  V27.8H, V5.8H, V20.16B
    SADDW2  V30.2D, V21.2D, V25.4S
    SADDW2  V5.8H, V27.8H, V27.16B
    SADDW2  V0.4S, V28.4S, V8.8H
    SADDW2  V12.2D, V20.2D, V5.4S
    SADDW2  V4.2D, V7.2D, V19.4S
    SHADD  V1.4S, V1.4S, V14.4S
    SHADD  V28.2S, V27.2S, V9.2S
    SHADD  V20.16B, V0.16B, V9.16B
    SHADD  V8.4H, V10.4H, V28.4H
    SHADD  V25.8H, V4.8H, V9.8H
    SHADD  V3.4H, V8.4H, V25.4H
    SHADD  V27.4H, V20.4H, V8.4H
    SHADD  V28.4S, V3.4S, V30.4S
    SHADD  V29.4H, V1.4H, V4.4H
    SHADD  V25.8H, V6.8H, V20.8H
    SHSUB  V30.16B, V10.16B, V29.16B
    SHSUB  V3.2S, V12.2S, V13.2S
    SHSUB  V5.16B, V14.16B, V3.16B
    SHSUB  V10.8B, V5.8B, V28.8B
    SHSUB  V2.8H, V10.8H, V25.8H
    SHSUB  V25.2S, V2.2S, V27.2S
    SHSUB  V0.2S, V29.2S, V22.2S
    SHSUB  V20.2S, V12.2S, V27.2S
    SHSUB  V10.2S, V26.2S, V9.2S
    SHSUB  V2.4S, V22.4S, V28.4S
    SMLAL V21.2D, V24.2S, V24.S[0x2]
    SMLAL V21.2D, V27.2S, V22.S[0x0]
    SMLAL V9.2D, V31.2S, V19.S[0x3]
    SMLAL V27.2D, V13.2S, V5.S[0x1]
    SMLAL V1.2D, V10.2S, V30.S[0x2]
    SMLAL V8.2D, V0.2S, V0.S[0x0]
    SMLAL V28.2D, V19.2S, V16.S[0x1]
    SMLAL V13.2D, V2.2S, V1.S[0x2]
    SMLAL V22.2D, V27.2S, V25.S[0x0]
    SMLAL V7.2D, V8.2S, V3.S[0x2]
    SMLAL V24.4S, V9.4H, V11.H[0x7]
    SMLAL V6.4S, V26.4H, V7.H[0x0]
    SMLAL V14.4S, V20.4H, V11.H[0x5]
    SMLAL V14.4S, V12.4H, V6.H[0x1]
    SMLAL V30.4S, V21.4H, V14.H[0x5]
    SMLAL V31.4S, V13.4H, V13.H[0x3]
    SMLAL V29.4S, V20.4H, V14.H[0x3]
    SMLAL V8.4S, V30.4H, V14.H[0x5]
    SMLAL V19.4S, V22.4H, V9.H[0x6]
    SMLAL V12.4S, V29.4H, V8.H[0x4]
    SMLAL  V6.2D, V24.2S, V27.2S
    SMLAL  V3.2D, V19.2S, V28.2S
    SMLAL  V25.8H, V6.8B, V6.8B
    SMLAL  V24.8H, V12.8B, V25.8B
    SMLAL  V15.4S, V30.4H, V11.4H
    SMLAL  V6.8H, V24.8B, V17.8B
    SMLAL  V12.4S, V25.4H, V15.4H
    SMLAL  V0.4S, V31.4H, V31.4H
    SMLAL  V24.2D, V3.2S, V11.2S
    SMLAL  V20.8H, V12.8B, V6.8B
    SMLAL2 V21.2D, V24.4S, V20.S[0x2]
    SMLAL2 V10.2D, V9.4S, V23.S[0x0]
    SMLAL2 V23.2D, V23.4S, V31.S[0x3]
    SMLAL2 V22.2D, V25.4S, V6.S[0x3]
    SMLAL2 V29.2D, V21.4S, V25.S[0x1]
    SMLAL2 V29.2D, V8.4S, V19.S[0x1]
    SMLAL2 V30.2D, V7.4S, V21.S[0x1]
    SMLAL2 V14.2D, V17.4S, V2.S[0x1]
    SMLAL2 V19.2D, V28.4S, V11.S[0x2]
    SMLAL2 V28.2D, V9.4S, V28.S[0x1]
    SMLAL2 V27.4S, V29.8H, V14.H[0x1]
    SMLAL2 V5.4S, V0.8H, V0.H[0x7]
    SMLAL2 V9.4S, V13.8H, V14.H[0x1]
    SMLAL2 V25.4S, V10.8H, V14.H[0x4]
    SMLAL2 V18.4S, V9.8H, V11.H[0x7]
    SMLAL2 V7.4S, V30.8H, V5.H[0x1]
    SMLAL2 V2.4S, V19.8H, V12.H[0x5]
    SMLAL2 V10.4S, V22.8H, V4.H[0x5]
    SMLAL2 V5.4S, V2.8H, V7.H[0x1]
    SMLAL2 V29.4S, V25.8H, V10.H[0x1]
    SMLAL2  V14.2D, V23.4S, V5.4S
    SMLAL2  V4.8H, V25.16B, V27.16B
    SMLAL2  V28.4S, V17.8H, V14.8H
    SMLAL2  V8.4S, V6.8H, V4.8H
    SMLAL2  V2.8H, V8.16B, V4.16B
    SMLAL2  V5.2D, V29.4S, V18.4S
    SMLAL2  V10.2D, V2.4S, V2.4S
    SMLAL2  V19.2D, V5.4S, V17.4S
    SMLAL2  V25.4S, V28.8H, V19.8H
    SMLAL2  V29.2D, V2.4S, V13.4S
    SMLSL V28.2D, V11.2S, V22.S[0x2]
    SMLSL V6.2D, V25.2S, V16.S[0x0]
    SMLSL V0.2D, V30.2S, V20.S[0x1]
    SMLSL V8.2D, V1.2S, V18.S[0x3]
    SMLSL V4.2D, V0.2S, V29.S[0x2]
    SMLSL V12.2D, V1.2S, V19.S[0x0]
    SMLSL V9.2D, V20.2S, V22.S[0x3]
    SMLSL V13.2D, V9.2S, V3.S[0x2]
    SMLSL V18.2D, V19.2S, V27.S[0x3]
    SMLSL V6.2D, V3.2S, V8.S[0x1]
    SMLSL V25.4S, V24.4H, V3.H[0x7]
    SMLSL V22.4S, V16.4H, V3.H[0x5]
    SMLSL V24.4S, V6.4H, V0.H[0x5]
    SMLSL V10.4S, V28.4H, V12.H[0x0]
    SMLSL V8.4S, V13.4H, V0.H[0x4]
    SMLSL V19.4S, V20.4H, V13.H[0x1]
    SMLSL V2.4S, V25.4H, V1.H[0x0]
    SMLSL V11.4S, V22.4H, V4.H[0x1]
    SMLSL V8.4S, V19.4H, V2.H[0x6]
    SMLSL V19.4S, V14.4H, V2.H[0x0]
    SMLSL  V4.4S, V27.4H, V24.4H
    SMLSL  V29.2D, V19.2S, V21.2S
    SMLSL  V28.4S, V10.4H, V11.4H
    SMLSL  V11.8H, V29.8B, V8.8B
    SMLSL  V10.4S, V28.4H, V23.4H
    SMLSL  V13.4S, V11.4H, V18.4H
    SMLSL  V12.8H, V10.8B, V4.8B
    SMLSL  V27.4S, V23.4H, V30.4H
    SMLSL  V2.2D, V16.2S, V25.2S
    SMLSL  V0.2D, V26.2S, V18.2S
    SMLSL2 V9.2D, V6.4S, V18.S[0x0]
    SMLSL2 V28.2D, V20.4S, V0.S[0x1]
    SMLSL2 V8.2D, V21.4S, V28.S[0x1]
    SMLSL2 V3.2D, V31.4S, V17.S[0x1]
    SMLSL2 V27.2D, V12.4S, V9.S[0x2]
    SMLSL2 V24.2D, V27.4S, V24.S[0x1]
    SMLSL2 V21.2D, V24.4S, V2.S[0x2]
    SMLSL2 V11.2D, V5.4S, V23.S[0x0]
    SMLSL2 V22.2D, V16.4S, V2.S[0x0]
    SMLSL2 V4.2D, V27.4S, V10.S[0x2]
    SMLSL2 V20.4S, V10.8H, V10.H[0x4]
    SMLSL2 V28.4S, V5.8H, V11.H[0x1]
    SMLSL2 V27.4S, V11.8H, V6.H[0x4]
    SMLSL2 V6.4S, V27.8H, V8.H[0x6]
    SMLSL2 V24.4S, V8.8H, V3.H[0x0]
    SMLSL2 V23.4S, V3.8H, V13.H[0x0]
    SMLSL2 V11.4S, V4.8H, V6.H[0x6]
    SMLSL2 V13.4S, V28.8H, V2.H[0x2]
    SMLSL2 V27.4S, V17.8H, V13.H[0x5]
    SMLSL2 V5.4S, V31.8H, V1.H[0x7]
    SMLSL2  V1.8H, V24.16B, V5.16B
    SMLSL2  V25.8H, V22.16B, V27.16B
    SMLSL2  V9.4S, V12.8H, V20.8H
    SMLSL2  V22.2D, V25.4S, V9.4S
    SMLSL2  V16.8H, V22.16B, V27.16B
    SMLSL2  V12.4S, V29.8H, V1.8H
    SMLSL2  V22.4S, V11.8H, V12.8H
    SMLSL2  V10.4S, V21.8H, V22.8H
    SMLSL2  V7.2D, V16.4S, V16.4S
    SMLSL2  V20.2D, V5.4S, V6.4S
    SMOV W4, V23.B[0x5]
    SMOV W6, V20.B[0x4]
    SMOV W16, V7.B[0x0]
    SMOV W22, V29.B[0x3]
    SMOV W16, V9.B[0x0]
    SMOV W2, V31.B[0xf]
    SMOV W2, V27.B[0x2]
    SMOV W17, V2.B[0xc]
    SMOV W7, V11.B[0x5]
    SMOV W16, V20.B[0x6]
    MOVZ  X25, #0xff9d, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X9, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x341c, LSL #0
    MOVK  X25, #0x4a07, LSL #16
    MOVK  X25, #0xcd8a, LSL #32
    MOVK  X25, #0xa95e, LSL #48
    SUB  X9, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x5b, LSL #0
    SUB  X9, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x718d, LSL #0
    MOVK  X25, #0x2d44, LSL #16
    MOVK  X25, #0xbad7, LSL #32
    MOVK  X25, #0xd2dd, LSL #48
    SUB  X9, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x59, LSL #0
    SUB  X9, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xffd7, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X9, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x946b, LSL #0
    MOVK  X25, #0x37cb, LSL #16
    MOVK  X25, #0x2d0e, LSL #32
    MOVK  X25, #0xcc37, LSL #48
    SUB  X9, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x7c52, LSL #0
    MOVK  X25, #0xf13d, LSL #16
    MOVK  X25, #0xc6d7, LSL #32
    MOVK  X25, #0xbe1, LSL #48
    SUB  X9, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xffc9, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X9, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x68, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x7518, LSL #0
    MOVK  X25, #0x7831, LSL #16
    MOVK  X25, #0x143f, LSL #32
    MOVK  X25, #0x7e4e, LSL #48
    SUB  X9, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xf087, LSL #0
    MOVK  X25, #0x42b4, LSL #16
    MOVK  X25, #0xb04, LSL #32
    MOVK  X25, #0x55c2, LSL #48
    SUB  X9, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x58fa, LSL #0
    MOVK  X25, #0xeec6, LSL #16
    MOVK  X25, #0xdaec, LSL #32
    MOVK  X25, #0xf378, LSL #48
    SUB  X9, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x2843, LSL #0
    MOVK  X25, #0xd580, LSL #16
    MOVK  X25, #0xcef0, LSL #32
    MOVK  X25, #0xe573, LSL #48
    SUB  X9, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xff92, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X9, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x6430, LSL #0
    MOVK  X25, #0x75f8, LSL #16
    MOVK  X25, #0xa4d6, LSL #32
    MOVK  X25, #0x2dc3, LSL #48
    SUB  X9, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x9fa7, LSL #0
    MOVK  X25, #0xcd4b, LSL #16
    MOVK  X25, #0x8bb0, LSL #32
    MOVK  X25, #0x1d98, LSL #48
    SUB  X9, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xd7c9, LSL #0
    MOVK  X25, #0x7b5c, LSL #16
    MOVK  X25, #0x143c, LSL #32
    MOVK  X25, #0x1f50, LSL #48
    SUB  X9, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xd27f, LSL #0
    MOVK  X25, #0x24d2, LSL #16
    MOVK  X25, #0x4438, LSL #32
    MOVK  X25, #0xc18f, LSL #48
    SUB  X9, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xc420, LSL #0
    MOVK  X25, #0xa30d, LSL #16
    MOVK  X25, #0xd582, LSL #32
    MOVK  X25, #0x6357, LSL #48
    SUB  X9, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X25, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X9, #0x7426, LSL #0
    MOVK  X9, #0xa00b, LSL #16
    MOVK  X9, #0xff64, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D0
    MOVZ  X9, #0xb05b, LSL #0
    MOVK  X9, #0x716a, LSL #16
    MOVK  X9, #0xe794, LSL #32
    MOVK  X9, #0xfffc, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X9, #0xd8f4, LSL #0
    MOVK  X9, #0xff4c, LSL #16
    MOVK  X9, #0xff87, LSL #32
    MOVK  X9, #0xfffd, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D1
    MOVZ  X9, #0x3fab, LSL #0
    MOVK  X9, #0x1cc0, LSL #16
    MOVK  X9, #0xf835, LSL #32
    MOVK  X9, #0xffa4, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X9, #0xc07e, LSL #0
    MOVK  X9, #0xce52, LSL #16
    MOVK  X9, #0xd068, LSL #32
    MOVK  X9, #0x7f3, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D2
    MOVZ  X9, #0xd5e4, LSL #0
    MOVK  X9, #0x6b9d, LSL #16
    MOVK  X9, #0x37cd, LSL #32
    MOVK  X9, #0xe25d, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X9, #0x1168, LSL #0
    MOVK  X9, #0x3d7f, LSL #16
    MOVK  X9, #0xf545, LSL #32
    MOVK  X9, #0xffe8, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D3
    MOVZ  X9, #0xd7d3, LSL #0
    MOVK  X9, #0xfe40, LSL #16
    MOVK  X9, #0xde37, LSL #32
    MOVK  X9, #0x669, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X9, #0xefec, LSL #0
    MOVK  X9, #0xff81, LSL #16
    MOVK  X9, #0xe89b, LSL #32
    MOVK  X9, #0x102, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D4
    MOVZ  X9, #0x6d7f, LSL #0
    MOVK  X9, #0xabf6, LSL #16
    MOVK  X9, #0xbee4, LSL #32
    MOVK  X9, #0x1866, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X9, #0xa498, LSL #0
    MOVK  X9, #0xffd2, LSL #16
    MOVK  X9, #0xfe62, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D5
    MOVZ  X9, #0xf3a5, LSL #0
    MOVK  X9, #0x41fd, LSL #16
    MOVK  X9, #0x4526, LSL #32
    MOVK  X9, #0xfff9, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X9, #0x867b, LSL #0
    MOVK  X9, #0x50dc, LSL #16
    MOVK  X9, #0x3d, LSL #32
    MOVK  X9, #0xf7e3, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D6
    MOVZ  X9, #0x93ea, LSL #0
    MOVK  X9, #0x342c, LSL #16
    MOVK  X9, #0xb744, LSL #32
    MOVK  X9, #0xfb6d, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X9, #0xdc00, LSL #0
    MOVK  X9, #0xfea6, LSL #16
    MOVK  X9, #0xfc41, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D7
    MOVZ  X9, #0xd7d5, LSL #0
    MOVK  X9, #0xb7c2, LSL #16
    MOVK  X9, #0x91fa, LSL #32
    MOVK  X9, #0xdddd, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X9, #0x49ee, LSL #0
    MOVK  X9, #0xaadb, LSL #16
    MOVK  X9, #0x74d5, LSL #32
    MOVK  X9, #0x95d, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D8
    MOVZ  X9, #0xbf84, LSL #0
    MOVK  X9, #0x9893, LSL #16
    MOVK  X9, #0x2e1f, LSL #32
    MOVK  X9, #0x11e2, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X9, #0x1686, LSL #0
    MOVK  X9, #0x9c2d, LSL #16
    MOVK  X9, #0x782, LSL #32
    MOVK  X9, #0xa9e0, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D9
    MOVZ  X9, #0xdba6, LSL #0
    MOVK  X9, #0x85aa, LSL #16
    MOVK  X9, #0x118, LSL #32
    MOVK  X9, #0xc1ab, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X9, #0xf33, LSL #0
    MOVK  X9, #0x8842, LSL #16
    MOVK  X9, #0x9856, LSL #32
    MOVK  X9, #0xfc76, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D10
    MOVZ  X9, #0xd4aa, LSL #0
    MOVK  X9, #0x26ac, LSL #16
    MOVK  X9, #0x3150, LSL #32
    MOVK  X9, #0xfcc6, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X9, #0x5601, LSL #0
    MOVK  X9, #0x811f, LSL #16
    MOVK  X9, #0x4ca0, LSL #32
    MOVK  X9, #0xfd0b, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D11
    MOVZ  X9, #0xde47, LSL #0
    MOVK  X9, #0xec19, LSL #16
    MOVK  X9, #0xd729, LSL #32
    MOVK  X9, #0xf236, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X9, #0x9d01, LSL #0
    MOVK  X9, #0xbcdf, LSL #16
    MOVK  X9, #0x2a06, LSL #32
    MOVK  X9, #0xffc4, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D12
    MOVZ  X9, #0x2b18, LSL #0
    MOVK  X9, #0xd4b3, LSL #16
    MOVK  X9, #0xe8fb, LSL #32
    MOVK  X9, #0x4dd, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X9, #0xf5ed, LSL #0
    MOVK  X9, #0x39da, LSL #16
    MOVK  X9, #0xcd39, LSL #32
    MOVK  X9, #0xb8d, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D13
    MOVZ  X9, #0x90fa, LSL #0
    MOVK  X9, #0xf78b, LSL #16
    MOVK  X9, #0xbf5e, LSL #32
    MOVK  X9, #0xf05c, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X9, #0x19f, LSL #0
    MOVK  X9, #0x1, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D14
    MOVZ  X9, #0x5e9a, LSL #0
    MOVK  X9, #0xe2, LSL #16
    MOVK  X9, #0x2, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X9, #0x2c2d, LSL #0
    MOVK  X9, #0x7c, LSL #16
    MOVK  X9, #0x3527, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D15
    MOVZ  X9, #0x2599, LSL #0
    MOVK  X9, #0x117f, LSL #16
    MOVK  X9, #0x6269, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X9, #0x3afc, LSL #0
    MOVK  X9, #0xa285, LSL #16
    MOVK  X9, #0xf3a0, LSL #32
    MOVK  X9, #0x1e, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D16
    MOVZ  X9, #0xb838, LSL #0
    MOVK  X9, #0x4aa4, LSL #16
    MOVK  X9, #0x926f, LSL #32
    MOVK  X9, #0x85f5, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D17
    MOVZ  X9, #0x2c66, LSL #0
    MOVK  X9, #0x59fe, LSL #16
    MOVK  X9, #0xff91, LSL #32
    MOVK  X9, #0xffaf, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X9, #0xd66c, LSL #0
    MOVK  X9, #0x25a, LSL #16
    MOVK  X9, #0x3fb7, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D18
    MOVZ  X9, #0x8308, LSL #0
    MOVK  X9, #0x101a, LSL #16
    MOVK  X9, #0x30b6, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X9, #0xa194, LSL #0
    MOVK  X9, #0xe9c3, LSL #16
    MOVK  X9, #0x8846, LSL #32
    MOVK  X9, #0x3c8, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D19
    MOVZ  X9, #0x84f8, LSL #0
    MOVK  X9, #0x38ff, LSL #16
    MOVK  X9, #0xd26e, LSL #32
    MOVK  X9, #0xf769, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X9, #0xcb98, LSL #0
    MOVK  X9, #0xcd35, LSL #16
    MOVK  X9, #0x4326, LSL #32
    MOVK  X9, #0xff7a, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D20
    MOVZ  X9, #0xbd6d, LSL #0
    MOVK  X9, #0xb49d, LSL #16
    MOVK  X9, #0xd959, LSL #32
    MOVK  X9, #0xf7c9, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X9, #0x4927, LSL #0
    MOVK  X9, #0x1f07, LSL #16
    MOVK  X9, #0x4bac, LSL #32
    MOVK  X9, #0xff3c, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D21
    MOVZ  X9, #0x6e5f, LSL #0
    MOVK  X9, #0x5ed2, LSL #16
    MOVK  X9, #0xaab3, LSL #32
    MOVK  X9, #0xeab7, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X9, #0x8bdc, LSL #0
    MOVK  X9, #0x3b40, LSL #16
    MOVK  X9, #0xe85b, LSL #32
    MOVK  X9, #0x1e1f, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D22
    MOVZ  X9, #0x4db0, LSL #0
    MOVK  X9, #0xeae1, LSL #16
    MOVK  X9, #0x9632, LSL #32
    MOVK  X9, #0xf125, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X9, #0xae00, LSL #0
    MOVK  X9, #0x54a, LSL #16
    MOVK  X9, #0xd5e7, LSL #32
    MOVK  X9, #0xb, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D23
    MOVZ  X9, #0x86db, LSL #0
    MOVK  X9, #0xf7d4, LSL #16
    MOVK  X9, #0x5bbe, LSL #32
    MOVK  X9, #0xe1ac, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X9, #0x5027, LSL #0
    MOVK  X9, #0xa4a8, LSL #16
    MOVK  X9, #0xa666, LSL #32
    MOVK  X9, #0xfd87, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D24
    MOVZ  X9, #0x7b8a, LSL #0
    MOVK  X9, #0x3327, LSL #16
    MOVK  X9, #0x404b, LSL #32
    MOVK  X9, #0xfffb, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X9, #0x8713, LSL #0
    MOVK  X9, #0xff3e, LSL #16
    MOVK  X9, #0xaa83, LSL #32
    MOVK  X9, #0x1e, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D25
    MOVZ  X9, #0xbacf, LSL #0
    MOVK  X9, #0x433a, LSL #16
    MOVK  X9, #0x8a49, LSL #32
    MOVK  X9, #0x1803, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D26
    MOVZ  X9, #0xe, LSL #0
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X9, #0xe5a3, LSL #0
    MOVK  X9, #0xf2fe, LSL #16
    MOVK  X9, #0xfc2b, LSL #32
    MOVK  X9, #0xff63, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D27
    MOVZ  X9, #0x454d, LSL #0
    MOVK  X9, #0xc99d, LSL #16
    MOVK  X9, #0xb9b0, LSL #32
    MOVK  X9, #0xbe76, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X9, #0xa359, LSL #0
    MOVK  X9, #0xe5f2, LSL #16
    MOVK  X9, #0x7e7a, LSL #32
    MOVK  X9, #0x341, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D28
    MOVZ  X9, #0x78f4, LSL #0
    MOVK  X9, #0x8c08, LSL #16
    MOVK  X9, #0xa768, LSL #32
    MOVK  X9, #0xf36a, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X9, #0xaf64, LSL #0
    MOVK  X9, #0x44e8, LSL #16
    MOVK  X9, #0xdb, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D29
    MOVZ  X9, #0x7ec0, LSL #0
    MOVK  X9, #0x921a, LSL #16
    MOVK  X9, #0xa0d6, LSL #32
    MOVK  X9, #0xee6c, LSL #48
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D30
    MOVZ  X9, #0xdae8, LSL #0
    MOVK  X9, #0x33, LSL #16
    MOVK  X9, #0xc17, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X9, #0x3b30, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x4, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D31
    MOVZ  X9, #0x8eb0, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x2, LSL #32
    SUB  X26, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x8721, LSL #0
    MOVK  X2, #0x819d, LSL #16
    MOVK  X2, #0x662b, LSL #32
    MOVK  X2, #0x64cc, LSL #48
    MOVZ  X3, #0x99c7, LSL #0
    MOVK  X3, #0xb4f3, LSL #16
    MOVK  X3, #0x8d89, LSL #32
    MOVK  X3, #0x9970, LSL #48
    MOVZ  X4, #0x9009, LSL #0
    MOVK  X4, #0xdee, LSL #16
    MOVK  X4, #0xd85e, LSL #32
    MOVK  X4, #0x232, LSL #48
    MOVZ  X5, #0xcf71, LSL #0
    MOVK  X5, #0xf47e, LSL #16
    MOVK  X5, #0xd5ce, LSL #32
    MOVK  X5, #0x2051, LSL #48
    MOVZ  X6, #0x1dbc, LSL #0
    MOVK  X6, #0xde1, LSL #16
    MOVK  X6, #0x9559, LSL #32
    MOVK  X6, #0x33ce, LSL #48
    MOVZ  X7, #0x9f1, LSL #0
    MOVK  X7, #0xf67e, LSL #16
    MOVK  X7, #0xdd73, LSL #32
    MOVK  X7, #0x5b04, LSL #48
    MOVZ  X8, #0x1538, LSL #0
    MOVK  X8, #0x4340, LSL #16
    MOVK  X8, #0xd6d2, LSL #32
    MOVK  X8, #0xffb4, LSL #48
    MOVZ  X9, #0x6b33, LSL #0
    MOVK  X9, #0xce38, LSL #16
    MOVK  X9, #0x9d2e, LSL #32
    MOVK  X9, #0xf954, LSL #48
    MOVZ  X10, #0x5bd1, LSL #0
    MOVK  X10, #0x215c, LSL #16
    MOVK  X10, #0x679e, LSL #32
    MOVK  X10, #0xe5f5, LSL #48
    MOVZ  X16, #0xde29, LSL #0
    MOVK  X16, #0xd5b9, LSL #16
    MOVK  X16, #0xbdd3, LSL #32
    MOVK  X16, #0xaa42, LSL #48
    MOVZ  X17, #0xa8f1, LSL #0
    MOVK  X17, #0xf402, LSL #16
    MOVK  X17, #0xe448, LSL #32
    MOVK  X17, #0xf375, LSL #48
    MOVZ  X18, #0xeda5, LSL #0
    MOVK  X18, #0xdecf, LSL #16
    MOVK  X18, #0x4264, LSL #32
    MOVK  X18, #0xafd9, LSL #48
    MOVZ  X19, #0x98c0, LSL #0
    MOVK  X19, #0xbbb4, LSL #16
    MOVK  X19, #0x3bf0, LSL #32
    MOVK  X19, #0x2fe8, LSL #48
    MOVZ  X20, #0xcf08, LSL #0
    MOVK  X20, #0x3291, LSL #16
    MOVK  X20, #0xad1, LSL #32
    MOVK  X20, #0x6472, LSL #48
    MOVZ  X21, #0x3e01, LSL #0
    MOVK  X21, #0x477a, LSL #16
    MOVK  X21, #0xcd7f, LSL #32
    MOVK  X21, #0xcf3c, LSL #48
    MOVZ  X22, #0x5b4c, LSL #0
    MOVK  X22, #0x43fd, LSL #16
    MOVK  X22, #0xd07f, LSL #32
    MOVK  X22, #0xd333, LSL #48
    MOVZ  X23, #0x7959, LSL #0
    MOVK  X23, #0x6f60, LSL #16
    MOVK  X23, #0x2eed, LSL #32
    MOVK  X23, #0x5b6c, LSL #48
    MOVZ  X24, #0xb332, LSL #0
    MOVK  X24, #0x3e45, LSL #16
    MOVK  X24, #0xa06b, LSL #32
    MOVK  X24, #0x5591, LSL #48
    MOVZ  X25, #0x9113, LSL #0
    MOVK  X25, #0x397, LSL #16
    MOVK  X25, #0xcb0c, LSL #32
    MOVK  X25, #0x3d22, LSL #48
    MOVZ  X26, #0x59d3, LSL #0
    MOVK  X26, #0x9cf8, LSL #16
    MOVK  X26, #0x71d4, LSL #32
    MOVK  X26, #0x321d, LSL #48
    MOVZ  X27, #0x840a, LSL #0
    MOVK  X27, #0x9186, LSL #16
    MOVK  X27, #0xfe8e, LSL #32
    MOVK  X27, #0x3759, LSL #48
    MOVZ  X28, #0x8cee, LSL #0
    MOVK  X28, #0x855d, LSL #16
    MOVK  X28, #0x90ba, LSL #32
    MOVK  X28, #0xc320, LSL #48
    MOVZ  X29, #0xd8e4, LSL #0
    MOVK  X29, #0xb70f, LSL #16
    MOVK  X29, #0xc9b6, LSL #32
    MOVK  X29, #0xd193, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X21
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X6
    FMOV  V2.D[1], X22
    FMOV  D3, X9
    FMOV  V3.D[1], X27
    FMOV  D4, X9
    FMOV  V4.D[1], X20
    FMOV  D5, X28
    FMOV  V5.D[1], X3
    FMOV  D6, X25
    FMOV  V6.D[1], X6
    FMOV  D7, X16
    FMOV  V7.D[1], X20
    FMOV  D8, X18
    FMOV  V8.D[1], X18
    FMOV  D9, X3
    FMOV  V9.D[1], X20
    FMOV  D10, X7
    FMOV  V10.D[1], X5
    FMOV  D11, X24
    FMOV  V11.D[1], X19
    FMOV  D12, X3
    FMOV  V12.D[1], X10
    FMOV  D13, X16
    FMOV  V13.D[1], X28
    FMOV  D14, X18
    FMOV  V14.D[1], X7
    FMOV  D15, X28
    FMOV  V15.D[1], X16
    FMOV  D16, X28
    FMOV  V16.D[1], X28
    FMOV  D17, X23
    FMOV  V17.D[1], X3
    FMOV  D18, X17
    FMOV  V18.D[1], X7
    FMOV  D19, X25
    FMOV  V19.D[1], X9
    FMOV  D20, X10
    FMOV  V20.D[1], X26
    FMOV  D21, X7
    FMOV  V21.D[1], X7
    FMOV  D22, X19
    FMOV  V22.D[1], X23
    FMOV  D23, X7
    FMOV  V23.D[1], X9
    FMOV  D24, X17
    FMOV  V24.D[1], X5
    FMOV  D25, X4
    FMOV  V25.D[1], X25
    FMOV  D26, X26
    FMOV  V26.D[1], X27
    FMOV  D27, X19
    FMOV  V27.D[1], X7
    FMOV  D28, X19
    FMOV  V28.D[1], X25
    FMOV  D29, X9
    FMOV  V29.D[1], X26
    FMOV  D30, X20
    FMOV  V30.D[1], X20
    FMOV  D31, X19
    FMOV  V31.D[1], X10
    SMOV W26, V25.H[0x7]
    SMOV W23, V21.H[0x2]
    SMOV W10, V27.H[0x7]
    SMOV W5, V29.H[0x3]
    SMOV W27, V30.H[0x2]
    SMOV W2, V26.H[0x1]
    SMOV W4, V31.H[0x4]
    SMOV W17, V28.H[0x1]
    SMOV W7, V28.H[0x7]
    SMOV W20, V11.H[0x5]
    SMOV  X29, V17.B[0x1]
    SMOV  X19, V20.B[0x9]
    SMOV  X7, V27.B[0xe]
    SMOV  X18, V23.B[0x0]
    SMOV  X24, V5.B[0x8]
    SMOV  X20, V9.B[0x8]
    SMOV  X23, V24.B[0xb]
    SMOV  X3, V27.B[0x3]
    SMOV  X29, V14.B[0x5]
    SMOV  X17, V25.B[0xb]
    SMOV  X28, V26.H[0x3]
    SMOV  X24, V16.H[0x0]
    SMOV  X6, V6.H[0x3]
    SMOV  X29, V22.H[0x6]
    SMOV  X10, V31.H[0x7]
    SMOV  X29, V6.H[0x1]
    SMOV  X8, V31.H[0x5]
    SMOV  X28, V3.H[0x5]
    SMOV  X6, V11.H[0x3]
    SMOV  X10, V1.H[0x3]
    SMOV  X17, V2.S[0x3]
    SMOV  X19, V27.S[0x1]
    SMOV  X7, V7.S[0x3]
    SMOV  X20, V9.S[0x3]
    SMOV  X24, V15.S[0x1]
    SMOV  X4, V28.S[0x3]
    SMOV  X10, V6.S[0x0]
    SMOV  X6, V2.S[0x0]
    SMOV  X24, V22.S[0x2]
    SMOV  X3, V25.S[0x0]
    SMULL V26.2D, V23.2S, V8.S[0x2]
    SMULL V25.2D, V2.2S, V0.S[0x2]
    SMULL V9.2D, V28.2S, V5.S[0x1]
    SMULL V24.2D, V11.2S, V17.S[0x2]
    SMULL V23.2D, V0.2S, V2.S[0x0]
    SMULL V22.2D, V16.2S, V25.S[0x0]
    SMULL V8.2D, V9.2S, V2.S[0x1]
    SMULL V1.2D, V27.2S, V30.S[0x0]
    SMULL V16.2D, V13.2S, V29.S[0x1]
    SMULL V30.2D, V23.2S, V4.S[0x0]
    SMULL V24.4S, V22.4H, V10.H[0x7]
    SMULL V28.4S, V6.4H, V0.H[0x6]
    SMULL V15.4S, V24.4H, V7.H[0x7]
    SMULL V26.4S, V13.4H, V8.H[0x3]
    SMULL V0.4S, V22.4H, V4.H[0x6]
    SMULL V31.4S, V25.4H, V10.H[0x5]
    SMULL V17.4S, V15.4H, V3.H[0x1]
    SMULL V25.4S, V12.4H, V6.H[0x7]
    SMULL V23.4S, V5.4H, V1.H[0x5]
    SMULL V18.4S, V0.4H, V7.H[0x7]
    SMULL  V24.2D, V25.2S, V25.2S
    SMULL  V13.2D, V2.2S, V2.2S
    SMULL  V4.8H, V16.8B, V28.8B
    SMULL  V29.8H, V18.8B, V29.8B
    SMULL  V28.4S, V8.4H, V4.4H
    SMULL  V6.8H, V27.8B, V1.8B
    SMULL  V9.2D, V29.2S, V28.2S
    SMULL  V15.2D, V6.2S, V23.2S
    SMULL  V13.8H, V15.8B, V26.8B
    SMULL  V26.8H, V30.8B, V26.8B
    SMULL2 V7.2D, V24.4S, V24.S[0x2]
    SMULL2 V25.2D, V21.4S, V3.S[0x2]
    SMULL2 V4.2D, V23.4S, V12.S[0x0]
    SMULL2 V11.2D, V26.4S, V5.S[0x2]
    SMULL2 V18.2D, V31.4S, V13.S[0x2]
    SMULL2 V15.2D, V28.4S, V25.S[0x0]
    SMULL2 V2.2D, V7.4S, V15.S[0x3]
    SMULL2 V0.2D, V15.4S, V2.S[0x3]
    SMULL2 V22.2D, V0.4S, V4.S[0x0]
    SMULL2 V4.2D, V18.4S, V9.S[0x2]
    SMULL2 V26.4S, V25.8H, V14.H[0x4]
    SMULL2 V8.4S, V4.8H, V11.H[0x5]
    SMULL2 V0.4S, V26.8H, V8.H[0x2]
    SMULL2 V29.4S, V22.8H, V3.H[0x3]
    SMULL2 V4.4S, V19.8H, V2.H[0x7]
    SMULL2 V9.4S, V29.8H, V4.H[0x3]
    SMULL2 V25.4S, V3.8H, V3.H[0x4]
    SMULL2 V27.4S, V9.8H, V7.H[0x0]
    SMULL2 V0.4S, V25.8H, V6.H[0x1]
    SMULL2 V21.4S, V15.8H, V0.H[0x7]
    SMULL2  V3.2D, V8.4S, V7.4S
    SMULL2  V6.2D, V7.4S, V22.4S
    SMULL2  V26.4S, V21.8H, V29.8H
    SMULL2  V9.2D, V15.4S, V31.4S
    SMULL2  V24.4S, V18.8H, V22.8H
    SMULL2  V25.2D, V12.4S, V23.4S
    SMULL2  V3.8H, V21.16B, V28.16B
    SMULL2  V18.2D, V10.4S, V20.4S
    SMULL2  V8.2D, V16.4S, V15.4S
    SMULL2  V4.8H, V15.16B, V25.16B
    SQABS  V0.4S, V3.4S
    SQABS  V15.4H, V18.4H
    SQABS  V16.16B, V15.16B
    SQABS  V2.8H, V24.8H
    SQABS  V31.8H, V0.8H
    SQABS  V23.2S, V9.2S
    SQABS  V9.4H, V26.4H
    SQABS  V12.2S, V16.2S
    SQABS  V29.8B, V16.8B
    SQABS  V15.8H, V4.8H
    SQADD  V16.2D, V30.2D, V19.2D
    SQADD  V16.8H, V16.8H, V8.8H
    SQADD  V8.4S, V31.4S, V19.4S
    SQADD  V4.8H, V19.8H, V23.8H
    SQADD  V19.8H, V26.8H, V29.8H
    SQADD  V24.8H, V12.8H, V4.8H
    SQADD  V18.4S, V9.4S, V15.4S
    SQADD  V25.8H, V18.8H, V19.8H
    SQADD  V9.2S, V16.2S, V10.2S
    SQADD  V12.8H, V8.8H, V9.8H
    SQDMLAL S7, H30, V2.H[0x4]
    SQDMLAL S2, H12, V12.H[0x6]
    SQDMLAL S16, H3, V2.H[0x0]
    SQDMLAL S19, H1, V7.H[0x0]
    SQDMLAL S22, H24, V15.H[0x5]
    SQDMLAL S8, H19, V0.H[0x6]
    SQDMLAL S20, H8, V8.H[0x7]
    SQDMLAL S8, H25, V8.H[0x1]
    SQDMLAL S2, H20, V8.H[0x3]
    SQDMLAL S31, H14, V0.H[0x7]
    SQDMLAL D25, S16, V16.S[0x1]
    SQDMLAL D0, S31, V25.S[0x3]
    SQDMLAL D23, S13, V6.S[0x1]
    SQDMLAL D4, S19, V25.S[0x2]
    SQDMLAL D16, S0, V2.S[0x2]
    SQDMLAL D30, S22, V28.S[0x3]
    SQDMLAL D25, S8, V30.S[0x3]
    SQDMLAL D20, S23, V4.S[0x0]
    SQDMLAL D19, S16, V16.S[0x3]
    SQDMLAL D7, S20, V20.S[0x2]
    SQDMLAL V28.2D, V7.2S, V26.S[0x1]
    SQDMLAL V14.2D, V19.2S, V28.S[0x2]
    SQDMLAL V16.2D, V3.2S, V13.S[0x2]
    SQDMLAL V23.2D, V5.2S, V9.S[0x0]
    SQDMLAL V13.2D, V31.2S, V29.S[0x3]
    SQDMLAL V6.2D, V3.2S, V8.S[0x1]
    SQDMLAL V11.2D, V17.2S, V29.S[0x1]
    SQDMLAL V20.2D, V27.2S, V4.S[0x2]
    SQDMLAL V9.2D, V22.2S, V17.S[0x0]
    SQDMLAL V17.2D, V6.2S, V8.S[0x2]
    SQDMLAL V6.4S, V23.4H, V7.H[0x0]
    SQDMLAL V27.4S, V6.4H, V14.H[0x2]
    SQDMLAL V14.4S, V30.4H, V9.H[0x4]
    SQDMLAL V1.4S, V11.4H, V13.H[0x5]
    SQDMLAL V9.4S, V2.4H, V14.H[0x3]
    SQDMLAL V29.4S, V1.4H, V9.H[0x6]
    SQDMLAL V0.4S, V29.4H, V14.H[0x5]
    SQDMLAL V23.4S, V27.4H, V0.H[0x6]
    SQDMLAL V28.4S, V17.4H, V14.H[0x7]
    SQDMLAL V27.4S, V29.4H, V6.H[0x1]
    SQDMLAL  V30.4S, V20.4H, V28.4H
    SQDMLAL  V5.2D, V23.2S, V15.2S
    SQDMLAL  V11.4S, V16.4H, V2.4H
    SQDMLAL  V26.4S, V27.4H, V20.4H
    SQDMLAL  V22.4S, V9.4H, V30.4H
    SQDMLAL  V20.2D, V30.2S, V5.2S
    SQDMLAL  V29.2D, V13.2S, V22.2S
    SQDMLAL  V27.2D, V16.2S, V18.2S
    SQDMLAL  V28.2D, V26.2S, V26.2S
    SQDMLAL  V15.2D, V28.2S, V24.2S
    SQDMLAL2 V9.2D, V4.4S, V11.S[0x3]
    SQDMLAL2 V1.2D, V27.4S, V9.S[0x1]
    SQDMLAL2 V25.2D, V20.4S, V20.S[0x1]
    SQDMLAL2 V5.2D, V24.4S, V25.S[0x1]
    SQDMLAL2 V20.2D, V15.4S, V15.S[0x0]
    SQDMLAL2 V15.2D, V19.4S, V1.S[0x3]
    SQDMLAL2 V21.2D, V9.4S, V20.S[0x3]
    SQDMLAL2 V11.2D, V29.4S, V12.S[0x0]
    SQDMLAL2 V24.2D, V0.4S, V15.S[0x1]
    SQDMLAL2 V19.2D, V5.4S, V23.S[0x0]
    SQDMLAL2 V7.4S, V27.8H, V1.H[0x0]
    SQDMLAL2 V20.4S, V11.8H, V13.H[0x4]
    SQDMLAL2 V1.4S, V24.8H, V8.H[0x6]
    SQDMLAL2 V31.4S, V21.8H, V7.H[0x1]
    SQDMLAL2 V5.4S, V31.8H, V5.H[0x4]
    SQDMLAL2 V22.4S, V6.8H, V1.H[0x2]
    SQDMLAL2 V28.4S, V1.8H, V4.H[0x3]
    SQDMLAL2 V24.4S, V22.8H, V5.H[0x2]
    SQDMLAL2 V6.4S, V8.8H, V14.H[0x2]
    SQDMLAL2 V4.4S, V20.8H, V2.H[0x4]
    SQDMLAL2  V7.2D, V24.4S, V6.4S
    SQDMLAL2  V27.4S, V28.8H, V24.8H
    SQDMLAL2  V12.4S, V27.8H, V19.8H
    SQDMLAL2  V5.4S, V4.8H, V23.8H
    SQDMLAL2  V21.4S, V21.8H, V26.8H
    SQDMLAL2  V8.2D, V7.4S, V12.4S
    SQDMLAL2  V2.2D, V15.4S, V5.4S
    SQDMLAL2  V0.4S, V20.8H, V2.8H
    SQDMLAL2  V19.4S, V0.8H, V20.8H
    SQDMLAL2  V11.4S, V8.8H, V12.8H
    SQDMLSL S25, H8, V9.H[0x7]
    SQDMLSL S3, H11, V11.H[0x5]
    SQDMLSL S0, H2, V15.H[0x1]
    SQDMLSL S26, H26, V8.H[0x6]
    SQDMLSL S27, H0, V5.H[0x6]
    SQDMLSL S22, H19, V9.H[0x6]
    SQDMLSL S28, H0, V3.H[0x5]
    SQDMLSL S20, H24, V3.H[0x5]
    SQDMLSL S17, H23, V8.H[0x4]
    SQDMLSL S12, H29, V0.H[0x2]
    SQDMLSL D4, S21, V20.S[0x1]
    SQDMLSL D29, S4, V22.S[0x1]
    SQDMLSL D4, S12, V27.S[0x1]
    SQDMLSL D11, S29, V26.S[0x1]
    SQDMLSL D3, S31, V17.S[0x0]
    SQDMLSL D29, S10, V3.S[0x2]
    SQDMLSL D12, S23, V8.S[0x3]
    SQDMLSL D22, S29, V25.S[0x0]
    SQDMLSL D26, S12, V11.S[0x2]
    SQDMLSL D27, S28, V0.S[0x2]
    SQDMLSL V10.2D, V20.2S, V4.S[0x3]
    SQDMLSL V18.2D, V26.2S, V10.S[0x2]
    SQDMLSL V29.2D, V8.2S, V18.S[0x1]
    SQDMLSL V25.2D, V11.2S, V2.S[0x0]
    SQDMLSL V24.2D, V25.2S, V3.S[0x3]
    SQDMLSL V21.2D, V29.2S, V22.S[0x1]
    SQDMLSL V25.2D, V20.2S, V23.S[0x0]
    SQDMLSL V20.2D, V27.2S, V18.S[0x0]
    SQDMLSL V27.2D, V5.2S, V25.S[0x0]
    SQDMLSL V23.2D, V21.2S, V8.S[0x2]
    SQDMLSL V26.4S, V24.4H, V0.H[0x6]
    SQDMLSL V4.4S, V23.4H, V8.H[0x4]
    SQDMLSL V24.4S, V20.4H, V11.H[0x0]
    SQDMLSL V23.4S, V22.4H, V4.H[0x1]
    SQDMLSL V26.4S, V21.4H, V11.H[0x0]
    SQDMLSL V31.4S, V26.4H, V8.H[0x4]
    SQDMLSL V1.4S, V27.4H, V7.H[0x7]
    SQDMLSL V4.4S, V24.4H, V11.H[0x2]
    SQDMLSL V3.4S, V16.4H, V1.H[0x4]
    SQDMLSL V26.4S, V3.4H, V14.H[0x7]
    SQDMLSL  V10.4S, V26.4H, V31.4H
    SQDMLSL  V27.2D, V4.2S, V10.2S
    SQDMLSL  V14.2D, V19.2S, V6.2S
    SQDMLSL  V28.4S, V20.4H, V22.4H
    SQDMLSL  V23.4S, V23.4H, V11.4H
    SQDMLSL  V20.4S, V17.4H, V9.4H
    SQDMLSL  V26.4S, V17.4H, V12.4H
    SQDMLSL  V22.4S, V17.4H, V27.4H
    SQDMLSL  V16.4S, V2.4H, V5.4H
    SQDMLSL  V31.2D, V14.2S, V1.2S
    SQDMLSL2 V12.2D, V27.4S, V27.S[0x0]
    SQDMLSL2 V5.2D, V1.4S, V1.S[0x2]
    SQDMLSL2 V8.2D, V28.4S, V0.S[0x1]
    SQDMLSL2 V27.2D, V19.4S, V13.S[0x3]
    SQDMLSL2 V6.2D, V5.4S, V8.S[0x0]
    SQDMLSL2 V4.2D, V27.4S, V20.S[0x1]
    SQDMLSL2 V25.2D, V20.4S, V16.S[0x2]
    SQDMLSL2 V1.2D, V25.4S, V17.S[0x3]
    SQDMLSL2 V19.2D, V18.4S, V16.S[0x1]
    SQDMLSL2 V28.2D, V1.4S, V30.S[0x1]
    SQDMLSL2 V21.4S, V23.8H, V9.H[0x5]
    SQDMLSL2 V14.4S, V4.8H, V9.H[0x7]
    SQDMLSL2 V2.4S, V5.8H, V0.H[0x2]
    SQDMLSL2 V18.4S, V12.8H, V2.H[0x4]
    SQDMLSL2 V27.4S, V31.8H, V6.H[0x0]
    SQDMLSL2 V4.4S, V19.8H, V10.H[0x4]
    SQDMLSL2 V3.4S, V4.8H, V4.H[0x2]
    SQDMLSL2 V9.4S, V21.8H, V3.H[0x3]
    SQDMLSL2 V17.4S, V23.8H, V14.H[0x7]
    SQDMLSL2 V11.4S, V4.8H, V9.H[0x3]
    SQDMLSL2  V7.2D, V11.4S, V29.4S
    SQDMLSL2  V5.4S, V18.8H, V28.8H
    SQDMLSL2  V19.4S, V19.8H, V17.8H
    SQDMLSL2  V6.2D, V19.4S, V20.4S
    SQDMLSL2  V17.2D, V7.4S, V6.4S
    SQDMLSL2  V9.4S, V25.8H, V25.8H
    SQDMLSL2  V19.2D, V19.4S, V5.4S
    SQDMLSL2  V30.2D, V17.4S, V27.4S
    SQDMLSL2  V0.4S, V21.8H, V19.8H
    SQDMLSL2  V11.2D, V3.4S, V28.4S
    SQDMULH H14, H11, V1.H[0x7]
    SQDMULH H18, H9, V9.H[0x1]
    SQDMULH H7, H0, V8.H[0x2]
    SQDMULH H9, H14, V14.H[0x3]
    SQDMULH H27, H1, V10.H[0x0]
    SQDMULH H28, H18, V9.H[0x7]
    SQDMULH H27, H7, V7.H[0x0]
    SQDMULH H10, H28, V8.H[0x3]
    SQDMULH H9, H27, V10.H[0x3]
    SQDMULH H14, H27, V5.H[0x2]
    SQDMULH S17, S9, V9.S[0x2]
    SQDMULH S3, S9, V1.S[0x0]
    SQDMULH S7, S26, V27.S[0x3]
    SQDMULH S18, S13, V23.S[0x2]
    SQDMULH S17, S18, V13.S[0x2]
    SQDMULH S21, S25, V12.S[0x3]
    SQDMULH S6, S29, V20.S[0x1]
    SQDMULH S9, S10, V5.S[0x2]
    SQDMULH S18, S9, V30.S[0x3]
    SQDMULH S12, S6, V11.S[0x0]
    MOVZ  X25, #0x9cf8, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X16, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x9009, LSL #0
    MOVK  X25, #0xdee, LSL #16
    SUB  X16, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xcb0c, LSL #0
    MOVK  X25, #0x3d22, LSL #16
    SUB  X16, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xf954, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X16, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x1dbc, LSL #0
    MOVK  X25, #0xde1, LSL #16
    SUB  X16, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xad1, LSL #0
    MOVK  X25, #0x6472, LSL #16
    SUB  X16, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x215c, LSL #0
    SUB  X16, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x9113, LSL #0
    MOVK  X25, #0x397, LSL #16
    SUB  X16, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xd07f, LSL #0
    MOVK  X25, #0xd333, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xfff1, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x3bf0, LSL #0
    MOVK  X25, #0x2fe8, LSL #16
    SUB  X16, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xad1, LSL #0
    MOVK  X25, #0x6472, LSL #16
    SUB  X16, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x3e01, LSL #0
    MOVK  X25, #0x477a, LSL #16
    MOVK  X25, #0xcd7f, LSL #32
    MOVK  X25, #0xcf3c, LSL #48
    SUB  X16, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x5b4c, LSL #0
    MOVK  X25, #0x43fd, LSL #16
    MOVK  X25, #0xd07f, LSL #32
    MOVK  X25, #0xd333, LSL #48
    SUB  X16, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xfff4, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x7959, LSL #0
    MOVK  X25, #0x6f60, LSL #16
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x3d22, LSL #0
    SUB  X16, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xad1, LSL #0
    SUB  X16, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x9186, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x397, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X25, FPSR
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X16, #0x6324, LSL #0
    MOVK  X16, #0x2bd1, LSL #16
    MOVK  X16, #0x2210, LSL #32
    MOVK  X16, #0x12d, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D0
    MOVZ  X16, #0x3ad2, LSL #0
    MOVK  X16, #0x95a8, LSL #16
    MOVK  X16, #0xaffa, LSL #32
    MOVK  X16, #0x1126, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X16, #0x436, LSL #0
    MOVK  X16, #0x5492, LSL #16
    MOVK  X16, #0x4cd4, LSL #32
    MOVK  X16, #0x1282, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D1
    MOVZ  X16, #0xcfe0, LSL #0
    MOVK  X16, #0x241d, LSL #16
    MOVK  X16, #0x56f8, LSL #32
    MOVK  X16, #0x13f7, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X16, #0x6c2c, LSL #0
    MOVK  X16, #0xdb71, LSL #16
    MOVK  X16, #0x7398, LSL #32
    MOVK  X16, #0x483, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D2
    MOVZ  X16, #0xc944, LSL #0
    MOVK  X16, #0x783, LSL #16
    MOVK  X16, #0x38da, LSL #32
    MOVK  X16, #0xe487, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X16, #0x64f8, LSL #0
    MOVK  X16, #0x193f, LSL #16
    MOVK  X16, #0x7aa4, LSL #32
    MOVK  X16, #0x9ed9, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D4
    MOVZ  X16, #0x8ad6, LSL #0
    MOVK  X16, #0x5574, LSL #16
    MOVK  X16, #0xfba1, LSL #32
    MOVK  X16, #0x2632, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X16, #0x2c53, LSL #0
    MOVK  X16, #0x41e1, LSL #16
    MOVK  X16, #0x90f4, LSL #32
    MOVK  X16, #0x9231, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D5
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0xc43d, LSL #32
    MOVK  X16, #0x88bd, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D6
    MOVZ  X16, #0x544f, LSL #0
    MOVK  X16, #0xba6, LSL #16
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X16, #0x547c, LSL #0
    MOVK  X16, #0x942e, LSL #16
    MOVK  X16, #0x76a1, LSL #32
    MOVK  X16, #0xffaf, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D8
    MOVZ  X16, #0x8235, LSL #0
    MOVK  X16, #0xa6a2, LSL #16
    MOVK  X16, #0xdd52, LSL #32
    MOVK  X16, #0x2584, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X16, #0x1d1c, LSL #0
    MOVK  X16, #0x71e6, LSL #16
    MOVK  X16, #0x735f, LSL #32
    MOVK  X16, #0x2e57, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D11
    MOVZ  X16, #0x9800, LSL #0
    MOVK  X16, #0x99d, LSL #16
    MOVK  X16, #0xe438, LSL #32
    MOVK  X16, #0xcc59, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D12
    MOVZ  X16, #0x9c6, LSL #0
    MOVK  X16, #0xe0, LSL #16
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X16, #0xf0e2, LSL #0
    MOVK  X16, #0x374, LSL #16
    MOVK  X16, #0xa4f, LSL #32
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D13
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xffdf, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D14
    MOVZ  X16, #0xff12, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X16, #0x622e, LSL #0
    MOVK  X16, #0x59d9, LSL #16
    MOVK  X16, #0xd887, LSL #32
    MOVK  X16, #0xfa1f, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D15
    MOVZ  X16, #0x8100, LSL #0
    MOVK  X16, #0xe73c, LSL #16
    MOVK  X16, #0xe422, LSL #32
    MOVK  X16, #0x1583, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X16, #0x1028, LSL #0
    MOVK  X16, #0xcbe7, LSL #16
    MOVK  X16, #0x9be2, LSL #32
    MOVK  X16, #0xf22d, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D16
    MOVZ  X16, #0x8b53, LSL #0
    MOVK  X16, #0x2500, LSL #16
    MOVK  X16, #0xd57e, LSL #32
    MOVK  X16, #0x1cc, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X16, #0xd330, LSL #0
    MOVK  X16, #0xd73b, LSL #16
    MOVK  X16, #0x6f03, LSL #32
    MOVK  X16, #0xcf55, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D19
    MOVZ  X16, #0xebc8, LSL #0
    MOVK  X16, #0x93ad, LSL #16
    MOVK  X16, #0x3b4f, LSL #32
    MOVK  X16, #0xc913, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D20
    MOVZ  X16, #0x58a1, LSL #0
    MOVK  X16, #0xd6ac, LSL #16
    MOVK  X16, #0x4aa2, LSL #32
    MOVK  X16, #0xf452, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D21
    MOVZ  X16, #0x148c, LSL #0
    MOVK  X16, #0xe72, LSL #16
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D22
    MOVZ  X16, #0x318a, LSL #0
    MOVK  X16, #0xd3d8, LSL #16
    MOVK  X16, #0x60e2, LSL #32
    MOVK  X16, #0x805d, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X16, #0xb5ae, LSL #0
    MOVK  X16, #0x7166, LSL #16
    MOVK  X16, #0x7010, LSL #32
    MOVK  X16, #0xda54, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D23
    MOVZ  X16, #0x34f8, LSL #0
    MOVK  X16, #0xa92a, LSL #16
    MOVK  X16, #0x95c1, LSL #32
    MOVK  X16, #0xefb7, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X16, #0x3ce7, LSL #0
    MOVK  X16, #0x2ec2, LSL #16
    MOVK  X16, #0x7f34, LSL #32
    MOVK  X16, #0xf3a2, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D24
    MOVZ  X16, #0xb3b7, LSL #0
    MOVK  X16, #0x37e2, LSL #16
    MOVK  X16, #0xdcb9, LSL #32
    MOVK  X16, #0x4dd2, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X16, #0xf428, LSL #0
    MOVK  X16, #0xe685, LSL #16
    MOVK  X16, #0xff9e, LSL #32
    MOVK  X16, #0x252, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D25
    MOVZ  X16, #0xce8b, LSL #0
    MOVK  X16, #0xd596, LSL #16
    MOVK  X16, #0x4b83, LSL #32
    MOVK  X16, #0x27d7, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X16, #0x9aa0, LSL #0
    MOVK  X16, #0xb920, LSL #16
    MOVK  X16, #0x6d68, LSL #32
    MOVK  X16, #0xfe86, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D26
    MOVZ  X16, #0xc38, LSL #0
    MOVK  X16, #0xdf6e, LSL #16
    MOVK  X16, #0x1db6, LSL #32
    MOVK  X16, #0x2b1c, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D27
    MOVZ  X16, #0x1fc, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X16, #0xf4a4, LSL #0
    MOVK  X16, #0x40d7, LSL #16
    MOVK  X16, #0x7946, LSL #32
    MOVK  X16, #0x38, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D29
    MOVZ  X16, #0xe08d, LSL #0
    MOVK  X16, #0x8050, LSL #16
    MOVK  X16, #0xc9f2, LSL #32
    MOVK  X16, #0x3ec, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X16, #0x4ac, LSL #0
    MOVK  X16, #0xe818, LSL #16
    MOVK  X16, #0x157, LSL #32
    MOVK  X16, #0xa54, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D30
    MOVZ  X16, #0xce0c, LSL #0
    MOVK  X16, #0x8a36, LSL #16
    MOVK  X16, #0x3477, LSL #32
    MOVK  X16, #0xca1a, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X16, #0x884c, LSL #0
    MOVK  X16, #0x1f83, LSL #16
    MOVK  X16, #0xc0c0, LSL #32
    MOVK  X16, #0x61f, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X25, D31
    MOVZ  X16, #0xf064, LSL #0
    MOVK  X16, #0x3c9a, LSL #16
    MOVK  X16, #0x3de6, LSL #32
    MOVK  X16, #0x16bc, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x3f21, LSL #0
    MOVK  X2, #0x5a11, LSL #16
    MOVK  X2, #0x53aa, LSL #32
    MOVK  X2, #0x21a4, LSL #48
    MOVZ  X3, #0xa951, LSL #0
    MOVK  X3, #0x4cd4, LSL #16
    MOVK  X3, #0xf81, LSL #32
    MOVK  X3, #0x5a06, LSL #48
    MOVZ  X4, #0x3a71, LSL #0
    MOVK  X4, #0x8612, LSL #16
    MOVK  X4, #0x6e49, LSL #32
    MOVK  X4, #0x362f, LSL #48
    MOVZ  X5, #0xf38e, LSL #0
    MOVK  X5, #0xe6eb, LSL #16
    MOVK  X5, #0x77b9, LSL #32
    MOVK  X5, #0xc77c, LSL #48
    MOVZ  X6, #0x7d8d, LSL #0
    MOVK  X6, #0xd65b, LSL #16
    MOVK  X6, #0x85be, LSL #32
    MOVK  X6, #0x4e8a, LSL #48
    MOVZ  X7, #0x88ff, LSL #0
    MOVK  X7, #0xf1bc, LSL #16
    MOVK  X7, #0x6948, LSL #32
    MOVK  X7, #0x3710, LSL #48
    MOVZ  X8, #0xe891, LSL #0
    MOVK  X8, #0x128c, LSL #16
    MOVK  X8, #0x1d81, LSL #32
    MOVK  X8, #0xc958, LSL #48
    MOVZ  X9, #0x5c1, LSL #0
    MOVK  X9, #0x363d, LSL #16
    MOVK  X9, #0xa900, LSL #32
    MOVK  X9, #0xa773, LSL #48
    MOVZ  X10, #0x5591, LSL #0
    MOVK  X10, #0xee0e, LSL #16
    MOVK  X10, #0xcbc1, LSL #32
    MOVK  X10, #0xa8f3, LSL #48
    MOVZ  X16, #0xa877, LSL #0
    MOVK  X16, #0x5e22, LSL #16
    MOVK  X16, #0x23f2, LSL #32
    MOVK  X16, #0x3617, LSL #48
    MOVZ  X17, #0xd697, LSL #0
    MOVK  X17, #0x8247, LSL #16
    MOVK  X17, #0xb86d, LSL #32
    MOVK  X17, #0xd497, LSL #48
    MOVZ  X18, #0xa3dc, LSL #0
    MOVK  X18, #0x84a3, LSL #16
    MOVK  X18, #0xf425, LSL #32
    MOVK  X18, #0x883d, LSL #48
    MOVZ  X19, #0x9d9, LSL #0
    MOVK  X19, #0xb26f, LSL #16
    MOVK  X19, #0x3fde, LSL #32
    MOVK  X19, #0x2656, LSL #48
    MOVZ  X20, #0x4bd4, LSL #0
    MOVK  X20, #0x594f, LSL #16
    MOVK  X20, #0x6891, LSL #32
    MOVK  X20, #0x1551, LSL #48
    MOVZ  X21, #0x36e2, LSL #0
    MOVK  X21, #0xcf15, LSL #16
    MOVK  X21, #0x7a4d, LSL #32
    MOVK  X21, #0xbc9d, LSL #48
    MOVZ  X22, #0xbae8, LSL #0
    MOVK  X22, #0x389a, LSL #16
    MOVK  X22, #0x2575, LSL #32
    MOVK  X22, #0x3af1, LSL #48
    MOVZ  X23, #0x8e21, LSL #0
    MOVK  X23, #0x9b46, LSL #16
    MOVK  X23, #0x989b, LSL #32
    MOVK  X23, #0xeb57, LSL #48
    MOVZ  X24, #0xcbc0, LSL #0
    MOVK  X24, #0x40c1, LSL #16
    MOVK  X24, #0xe2e2, LSL #32
    MOVK  X24, #0xd88, LSL #48
    MOVZ  X25, #0xe472, LSL #0
    MOVK  X25, #0x6976, LSL #16
    MOVK  X25, #0x7644, LSL #32
    MOVK  X25, #0xc30d, LSL #48
    MOVZ  X26, #0xd01f, LSL #0
    MOVK  X26, #0xb4ab, LSL #16
    MOVK  X26, #0xafee, LSL #32
    MOVK  X26, #0xe391, LSL #48
    MOVZ  X27, #0xff29, LSL #0
    MOVK  X27, #0xb987, LSL #16
    MOVK  X27, #0x7012, LSL #32
    MOVK  X27, #0x6621, LSL #48
    MOVZ  X28, #0xb989, LSL #0
    MOVK  X28, #0xf9f5, LSL #16
    MOVK  X28, #0x34d3, LSL #32
    MOVK  X28, #0x71ed, LSL #48
    MOVZ  X29, #0x8b50, LSL #0
    MOVK  X29, #0x68c7, LSL #16
    MOVK  X29, #0xab91, LSL #32
    MOVK  X29, #0x36b7, LSL #48
    FMOV  D0, X3
    FMOV  V0.D[1], X22
    FMOV  D1, X26
    FMOV  V1.D[1], X6
    FMOV  D2, X9
    FMOV  V2.D[1], X10
    FMOV  D3, X25
    FMOV  V3.D[1], X29
    FMOV  D4, X27
    FMOV  V4.D[1], X16
    FMOV  D5, X28
    FMOV  V5.D[1], X10
    FMOV  D6, X16
    FMOV  V6.D[1], X18
    FMOV  D7, X5
    FMOV  V7.D[1], X2
    FMOV  D8, X3
    FMOV  V8.D[1], X7
    FMOV  D9, X5
    FMOV  V9.D[1], X19
    FMOV  D10, X10
    FMOV  V10.D[1], X6
    FMOV  D11, X20
    FMOV  V11.D[1], X9
    FMOV  D12, X7
    FMOV  V12.D[1], X23
    FMOV  D13, X10
    FMOV  V13.D[1], X9
    FMOV  D14, X7
    FMOV  V14.D[1], X7
    FMOV  D15, X19
    FMOV  V15.D[1], X9
    FMOV  D16, X23
    FMOV  V16.D[1], X26
    FMOV  D17, X26
    FMOV  V17.D[1], X9
    FMOV  D18, X5
    FMOV  V18.D[1], X3
    FMOV  D19, X17
    FMOV  V19.D[1], X9
    FMOV  D20, X6
    FMOV  V20.D[1], X28
    FMOV  D21, X28
    FMOV  V21.D[1], X4
    FMOV  D22, X10
    FMOV  V22.D[1], X2
    FMOV  D23, X26
    FMOV  V23.D[1], X22
    FMOV  D24, X5
    FMOV  V24.D[1], X28
    FMOV  D25, X8
    FMOV  V25.D[1], X10
    FMOV  D26, X3
    FMOV  V26.D[1], X3
    FMOV  D27, X27
    FMOV  V27.D[1], X27
    FMOV  D28, X20
    FMOV  V28.D[1], X27
    FMOV  D29, X9
    FMOV  V29.D[1], X26
    FMOV  D30, X10
    FMOV  V30.D[1], X2
    FMOV  D31, X8
    FMOV  V31.D[1], X3
    SQDMULH  V30.8H, V15.8H, V2.H[0x0]
    SQDMULH  V13.8H, V29.8H, V0.H[0x4]
    SQDMULH  V4.8H, V23.8H, V11.H[0x3]
    SQDMULH  V1.8H, V30.8H, V0.H[0x3]
    SQDMULH  V12.4H, V25.4H, V9.H[0x5]
    SQDMULH  V30.4H, V5.4H, V12.H[0x5]
    SQDMULH  V26.8H, V23.8H, V2.H[0x7]
    SQDMULH  V7.8H, V27.8H, V13.H[0x0]
    SQDMULH  V17.8H, V21.8H, V13.H[0x3]
    SQDMULH  V28.4H, V15.4H, V1.H[0x7]
    SQDMULH  V29.4S, V22.4S, V30.S[0x1]
    SQDMULH  V2.4S, V7.4S, V26.S[0x1]
    SQDMULH  V7.2S, V29.2S, V29.S[0x3]
    SQDMULH  V9.4S, V28.4S, V8.S[0x0]
    SQDMULH  V22.4S, V7.4S, V17.S[0x0]
    SQDMULH  V29.4S, V22.4S, V9.S[0x1]
    SQDMULH  V11.2S, V14.2S, V2.S[0x0]
    SQDMULH  V5.4S, V4.4S, V14.S[0x0]
    SQDMULH  V21.4S, V5.4S, V29.S[0x3]
    SQDMULH  V23.2S, V31.2S, V11.S[0x0]
    SQDMULH  V30.2S, V13.2S, V1.2S
    SQDMULH  V11.2S, V2.2S, V9.2S
    SQDMULH  V2.2S, V12.2S, V22.2S
    SQDMULH  V13.4H, V16.4H, V20.4H
    SQDMULH  V4.8H, V20.8H, V15.8H
    SQDMULH  V0.2S, V16.2S, V28.2S
    SQDMULH  V29.4S, V17.4S, V29.4S
    SQDMULH  V22.4H, V30.4H, V20.4H
    SQDMULH  V15.4S, V0.4S, V31.4S
    SQDMULH  V7.4S, V12.4S, V13.4S
    SQDMULL S0, H2, V11.H[0x3]
    SQDMULL S20, H21, V7.H[0x3]
    SQDMULL S5, H4, V0.H[0x7]
    SQDMULL S21, H7, V15.H[0x4]
    SQDMULL S7, H7, V5.H[0x3]
    SQDMULL S17, H23, V12.H[0x5]
    SQDMULL S12, H7, V7.H[0x1]
    SQDMULL S4, H24, V12.H[0x1]
    SQDMULL S10, H29, V4.H[0x5]
    SQDMULL S9, H21, V10.H[0x1]
    SQDMULL D16, S27, V6.S[0x1]
    SQDMULL D7, S20, V10.S[0x2]
    SQDMULL D30, S17, V9.S[0x2]
    SQDMULL D11, S7, V26.S[0x3]
    SQDMULL D9, S22, V11.S[0x1]
    SQDMULL D17, S16, V20.S[0x1]
    SQDMULL D20, S30, V0.S[0x3]
    SQDMULL D22, S25, V20.S[0x2]
    SQDMULL D13, S19, V12.S[0x1]
    SQDMULL D23, S24, V9.S[0x0]
    SQDMULL V11.2D, V17.2S, V22.S[0x1]
    SQDMULL V2.2D, V11.2S, V18.S[0x0]
    SQDMULL V5.2D, V29.2S, V23.S[0x2]
    SQDMULL V16.2D, V13.2S, V13.S[0x3]
    SQDMULL V12.2D, V16.2S, V5.S[0x2]
    SQDMULL V24.2D, V12.2S, V0.S[0x3]
    SQDMULL V30.2D, V8.2S, V8.S[0x2]
    SQDMULL V8.2D, V23.2S, V12.S[0x0]
    SQDMULL V13.2D, V26.2S, V4.S[0x2]
    SQDMULL V19.2D, V7.2S, V18.S[0x3]
    SQDMULL V0.4S, V17.4H, V7.H[0x0]
    SQDMULL V11.4S, V30.4H, V0.H[0x5]
    SQDMULL V5.4S, V26.4H, V11.H[0x5]
    SQDMULL V20.4S, V21.4H, V1.H[0x0]
    SQDMULL V18.4S, V27.4H, V6.H[0x2]
    SQDMULL V1.4S, V0.4H, V0.H[0x2]
    SQDMULL V4.4S, V20.4H, V0.H[0x6]
    SQDMULL V23.4S, V18.4H, V8.H[0x7]
    SQDMULL V12.4S, V13.4H, V4.H[0x0]
    SQDMULL V21.4S, V12.4H, V5.H[0x4]
    SQDMULL  V5.4S, V24.4H, V1.4H
    SQDMULL  V8.2D, V17.2S, V0.2S
    SQDMULL  V25.2D, V2.2S, V21.2S
    SQDMULL  V4.4S, V23.4H, V25.4H
    SQDMULL  V24.4S, V8.4H, V5.4H
    SQDMULL  V12.4S, V29.4H, V20.4H
    SQDMULL  V22.2D, V24.2S, V12.2S
    SQDMULL  V17.4S, V1.4H, V20.4H
    SQDMULL  V13.4S, V7.4H, V20.4H
    SQDMULL  V16.2D, V17.2S, V30.2S
    SQDMULL2 V11.2D, V22.4S, V22.S[0x2]
    SQDMULL2 V30.2D, V13.4S, V3.S[0x3]
    SQDMULL2 V25.2D, V11.4S, V16.S[0x2]
    SQDMULL2 V20.2D, V6.4S, V30.S[0x3]
    SQDMULL2 V5.2D, V19.4S, V4.S[0x0]
    SQDMULL2 V27.2D, V25.4S, V27.S[0x0]
    SQDMULL2 V1.2D, V2.4S, V27.S[0x3]
    SQDMULL2 V7.2D, V12.4S, V14.S[0x1]
    SQDMULL2 V13.2D, V26.4S, V16.S[0x1]
    SQDMULL2 V24.2D, V5.4S, V5.S[0x1]
    SQDMULL2 V23.4S, V24.8H, V7.H[0x3]
    SQDMULL2 V3.4S, V13.8H, V0.H[0x4]
    SQDMULL2 V4.4S, V28.8H, V3.H[0x0]
    SQDMULL2 V30.4S, V23.8H, V7.H[0x3]
    SQDMULL2 V28.4S, V20.8H, V12.H[0x0]
    SQDMULL2 V20.4S, V4.8H, V11.H[0x0]
    SQDMULL2 V16.4S, V30.8H, V1.H[0x0]
    SQDMULL2 V25.4S, V27.8H, V11.H[0x6]
    SQDMULL2 V29.4S, V23.8H, V14.H[0x0]
    SQDMULL2 V12.4S, V8.8H, V4.H[0x7]
    SQDMULL2  V27.4S, V16.8H, V14.8H
    SQDMULL2  V6.4S, V11.8H, V28.8H
    SQDMULL2  V11.2D, V25.4S, V6.4S
    SQDMULL2  V19.2D, V29.4S, V2.4S
    SQDMULL2  V26.4S, V14.8H, V17.8H
    SQDMULL2  V7.4S, V20.8H, V22.8H
    SQDMULL2  V23.4S, V7.8H, V16.8H
    SQDMULL2  V25.4S, V27.8H, V12.8H
    SQDMULL2  V17.2D, V14.4S, V19.4S
    SQDMULL2  V18.2D, V26.4S, V13.4S
    SQNEG  V26.2S, V31.2S
    SQNEG  V31.4H, V11.4H
    SQNEG  V5.8B, V17.8B
    SQNEG  V11.2S, V3.2S
    SQNEG  V17.8H, V7.8H
    SQNEG  V0.8B, V19.8B
    SQNEG  V4.16B, V23.16B
    SQNEG  V8.16B, V25.16B
    SQNEG  V27.8B, V8.8B
    SQNEG  V22.16B, V21.16B
    SQRDMULH H13, H17, V11.H[0x5]
    SQRDMULH H28, H27, V4.H[0x2]
    SQRDMULH H12, H13, V0.H[0x3]
    SQRDMULH H30, H12, V6.H[0x6]
    SQRDMULH H31, H22, V3.H[0x6]
    SQRDMULH H25, H30, V4.H[0x7]
    SQRDMULH H16, H5, V5.H[0x4]
    SQRDMULH H20, H26, V13.H[0x4]
    SQRDMULH H0, H16, V9.H[0x0]
    SQRDMULH H26, H31, V7.H[0x7]
    SQRDMULH S27, S20, V27.S[0x0]
    SQRDMULH S6, S30, V4.S[0x3]
    SQRDMULH S19, S6, V6.S[0x0]
    SQRDMULH S4, S13, V0.S[0x2]
    SQRDMULH S0, S18, V27.S[0x2]
    SQRDMULH S23, S26, V25.S[0x1]
    SQRDMULH S20, S8, V4.S[0x1]
    SQRDMULH S30, S13, V28.S[0x2]
    SQRDMULH S14, S23, V31.S[0x3]
    SQRDMULH S2, S14, V30.S[0x1]
    SQRDMULH  V14.4H, V2.4H, V12.H[0x2]
    SQRDMULH  V4.4H, V20.4H, V0.H[0x7]
    SQRDMULH  V9.8H, V19.8H, V3.H[0x5]
    SQRDMULH  V7.4H, V4.4H, V14.H[0x2]
    SQRDMULH  V8.8H, V0.8H, V7.H[0x5]
    SQRDMULH  V4.4H, V11.4H, V6.H[0x5]
    SQRDMULH  V16.4H, V9.4H, V14.H[0x4]
    SQRDMULH  V7.8H, V24.8H, V6.H[0x3]
    SQRDMULH  V9.4H, V13.4H, V1.H[0x5]
    SQRDMULH  V28.8H, V5.8H, V7.H[0x4]
    SQRDMULH  V0.2S, V17.2S, V21.S[0x1]
    SQRDMULH  V30.2S, V21.2S, V21.S[0x0]
    SQRDMULH  V27.4S, V3.4S, V16.S[0x1]
    SQRDMULH  V7.4S, V7.4S, V27.S[0x3]
    SQRDMULH  V12.2S, V3.2S, V10.S[0x2]
    SQRDMULH  V12.2S, V1.2S, V25.S[0x0]
    SQRDMULH  V14.2S, V0.2S, V28.S[0x1]
    SQRDMULH  V11.2S, V12.2S, V5.S[0x1]
    SQRDMULH  V1.2S, V7.2S, V11.S[0x0]
    SQRDMULH  V24.2S, V14.2S, V13.S[0x1]
    SQRDMULH  V20.4S, V17.4S, V25.4S
    SQRDMULH  V25.2S, V29.2S, V20.2S
    SQRDMULH  V17.4S, V4.4S, V10.4S
    SQRDMULH  V13.2S, V4.2S, V25.2S
    SQRDMULH  V29.4S, V17.4S, V17.4S
    SQRDMULH  V11.4H, V30.4H, V30.4H
    SQRDMULH  V27.2S, V16.2S, V29.2S
    SQRDMULH  V2.4H, V9.4H, V8.4H
    SQRDMULH  V21.4S, V2.4S, V23.4S
    SQRDMULH  V20.8H, V13.8H, V1.8H
    SQRSHL  V21.4S, V10.4S, V21.4S
    SQRSHL  V30.16B, V5.16B, V20.16B
    SQRSHL  V6.8B, V27.8B, V20.8B
    SQRSHL  V9.4S, V21.4S, V25.4S
    SQRSHL  V2.8B, V17.8B, V6.8B
    SQRSHL  V10.4S, V24.4S, V24.4S
    SQRSHL  V27.16B, V11.16B, V13.16B
    SQRSHL  V23.4S, V2.4S, V10.4S
    SQRSHL  V14.2D, V9.2D, V2.2D
    SQRSHL  V8.8H, V22.8H, V14.8H
    SQRSHRN V3.8B, V22.8H, #2
    SQRSHRN V6.8B, V27.8H, #3
    SQRSHRN V28.8B, V6.8H, #1
    SQRSHRN V27.8B, V2.8H, #6
    SQRSHRN V12.8B, V28.8H, #7
    SQRSHRN V21.8B, V30.8H, #1
    SQRSHRN V19.8B, V12.8H, #3
    SQRSHRN V15.8B, V31.8H, #3
    SQRSHRN V22.8B, V14.8H, #7
    SQRSHRN V1.8B, V19.8H, #2
    SQRSHRN V31.4H, V22.4S, #4
    SQRSHRN V25.4H, V3.4S, #16
    SQRSHRN V12.4H, V8.4S, #6
    SQRSHRN V13.4H, V25.4S, #11
    SQRSHRN V30.4H, V31.4S, #13
    SQRSHRN V22.4H, V24.4S, #4
    SQRSHRN V16.4H, V15.4S, #11
    SQRSHRN V20.4H, V16.4S, #15
    SQRSHRN V19.4H, V24.4S, #4
    SQRSHRN V15.4H, V13.4S, #10
    SQRSHRN V24.2S, V1.2D, #23
    SQRSHRN V9.2S, V15.2D, #15
    SQRSHRN V16.2S, V9.2D, #10
    SQRSHRN V2.2S, V22.2D, #6
    SQRSHRN V9.2S, V12.2D, #30
    SQRSHRN V10.2S, V2.2D, #16
    SQRSHRN V22.2S, V16.2D, #17
    SQRSHRN V11.2S, V30.2D, #9
    SQRSHRN V13.2S, V11.2D, #2
    SQRSHRN V25.2S, V20.2D, #32
    SQRSHRN2 V15.16B, V10.8H, #3
    SQRSHRN2 V10.16B, V19.8H, #8
    SQRSHRN2 V31.16B, V25.8H, #8
    SQRSHRN2 V2.16B, V10.8H, #7
    SQRSHRN2 V31.16B, V22.8H, #7
    SQRSHRN2 V30.16B, V13.8H, #8
    SQRSHRN2 V13.16B, V17.8H, #2
    SQRSHRN2 V16.16B, V15.8H, #6
    SQRSHRN2 V15.16B, V2.8H, #8
    SQRSHRN2 V5.16B, V9.8H, #7
    SQRSHRN2 V9.8H, V16.4S, #7
    SQRSHRN2 V10.8H, V31.4S, #9
    SQRSHRN2 V9.8H, V29.4S, #5
    SQRSHRN2 V9.8H, V5.4S, #1
    SQRSHRN2 V5.8H, V13.4S, #8
    SQRSHRN2 V12.8H, V10.4S, #1
    SQRSHRN2 V19.8H, V9.4S, #16
    SQRSHRN2 V9.8H, V24.4S, #16
    SQRSHRN2 V10.8H, V9.4S, #16
    SQRSHRN2 V13.8H, V2.4S, #9
    SQRSHRN2 V9.4S, V21.2D, #9
    SQRSHRN2 V22.4S, V9.2D, #26
    SQRSHRN2 V17.4S, V19.2D, #19
    SQRSHRN2 V16.4S, V22.2D, #26
    SQRSHRN2 V2.4S, V5.2D, #21
    SQRSHRN2 V9.4S, V13.2D, #21
    SQRSHRN2 V29.4S, V2.2D, #13
    SQRSHRN2 V21.4S, V10.2D, #22
    SQRSHRN2 V13.4S, V9.2D, #26
    SQRSHRN2 V22.4S, V11.2D, #5
    SQRSHRUN V24.8B, V16.8H, #2
    SQRSHRUN V25.8B, V5.8H, #3
    SQRSHRUN V13.8B, V21.8H, #1
    SQRSHRUN V18.8B, V25.8H, #5
    SQRSHRUN V11.8B, V13.8H, #6
    SQRSHRUN V21.8B, V24.8H, #4
    SQRSHRUN V31.8B, V22.8H, #7
    SQRSHRUN V5.8B, V13.8H, #8
    SQRSHRUN V2.8B, V29.8H, #8
    SQRSHRUN V22.8B, V28.8H, #4
    SQRSHRUN V25.4H, V31.4S, #13
    SQRSHRUN V12.4H, V21.4S, #4
    SQRSHRUN V8.4H, V18.4S, #16
    SQRSHRUN V2.4H, V7.4S, #1
    SQRSHRUN V10.4H, V3.4S, #5
    SQRSHRUN V28.4H, V4.4S, #3
    SQRSHRUN V24.4H, V25.4S, #10
    SQRSHRUN V13.4H, V12.4S, #15
    SQRSHRUN V18.4H, V24.4S, #7
    SQRSHRUN V7.4H, V24.4S, #15
    SQRSHRUN V29.2S, V10.2D, #19
    SQRSHRUN V2.2S, V8.2D, #29
    SQRSHRUN V12.2S, V4.2D, #17
    SQRSHRUN V16.2S, V31.2D, #26
    SQRSHRUN V10.2S, V31.2D, #32
    SQRSHRUN V27.2S, V31.2D, #5
    SQRSHRUN V24.2S, V17.2D, #29
    SQRSHRUN V14.2S, V28.2D, #25
    SQRSHRUN V4.2S, V10.2D, #18
    SQRSHRUN V25.2S, V17.2D, #20
    SQRSHRUN2 V31.16B, V12.8H, #6
    SQRSHRUN2 V21.16B, V29.8H, #1
    SQRSHRUN2 V18.16B, V14.8H, #5
    SQRSHRUN2 V14.16B, V16.8H, #8
    SQRSHRUN2 V10.16B, V22.8H, #8
    SQRSHRUN2 V12.16B, V30.8H, #8
    SQRSHRUN2 V17.16B, V23.8H, #4
    SQRSHRUN2 V23.16B, V31.8H, #7
    SQRSHRUN2 V22.16B, V17.8H, #7
    SQRSHRUN2 V8.16B, V28.8H, #5
    SQRSHRUN2 V28.8H, V24.4S, #2
    SQRSHRUN2 V30.8H, V28.4S, #11
    SQRSHRUN2 V28.8H, V7.4S, #7
    SQRSHRUN2 V7.8H, V8.4S, #2
    SQRSHRUN2 V17.8H, V25.4S, #10
    SQRSHRUN2 V6.8H, V28.4S, #9
    SQRSHRUN2 V25.8H, V28.4S, #14
    SQRSHRUN2 V31.8H, V10.4S, #11
    SQRSHRUN2 V24.8H, V17.4S, #4
    SQRSHRUN2 V3.8H, V25.4S, #5
    SQRSHRUN2 V17.4S, V6.2D, #19
    SQRSHRUN2 V25.4S, V12.2D, #18
    SQRSHRUN2 V8.4S, V31.2D, #22
    SQRSHRUN2 V31.4S, V24.2D, #16
    SQRSHRUN2 V12.4S, V3.2D, #3
    SQRSHRUN2 V9.4S, V17.2D, #1
    SQRSHRUN2 V22.4S, V7.2D, #14
    SQRSHRUN2 V24.4S, V22.2D, #5
    SQRSHRUN2 V28.4S, V4.2D, #25
    SQRSHRUN2 V6.4S, V30.2D, #4
    MOVZ  X9, #0x3f21, LSL #0
    MOVK  X9, #0x5a11, LSL #16
    MOVK  X9, #0x53aa, LSL #32
    MOVK  X9, #0x21a4, LSL #48
    SUB  X27, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xa951, LSL #0
    MOVK  X9, #0x4cd4, LSL #16
    MOVK  X9, #0xf81, LSL #32
    MOVK  X9, #0x5a06, LSL #48
    SUB  X27, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x3a71, LSL #0
    MOVK  X9, #0x8612, LSL #16
    MOVK  X9, #0x6e49, LSL #32
    MOVK  X9, #0x362f, LSL #48
    SUB  X27, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xf38e, LSL #0
    MOVK  X9, #0xe6eb, LSL #16
    MOVK  X9, #0x77b9, LSL #32
    MOVK  X9, #0xc77c, LSL #48
    SUB  X27, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x7d8d, LSL #0
    MOVK  X9, #0xd65b, LSL #16
    MOVK  X9, #0x85be, LSL #32
    MOVK  X9, #0x4e8a, LSL #48
    SUB  X27, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x88ff, LSL #0
    MOVK  X9, #0xf1bc, LSL #16
    MOVK  X9, #0x6948, LSL #32
    MOVK  X9, #0x3710, LSL #48
    SUB  X27, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xe891, LSL #0
    MOVK  X9, #0x128c, LSL #16
    MOVK  X9, #0x1d81, LSL #32
    MOVK  X9, #0xc958, LSL #48
    SUB  X27, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x5591, LSL #0
    MOVK  X9, #0xee0e, LSL #16
    MOVK  X9, #0xcbc1, LSL #32
    MOVK  X9, #0xa8f3, LSL #48
    SUB  X27, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xa877, LSL #0
    MOVK  X9, #0x5e22, LSL #16
    MOVK  X9, #0x23f2, LSL #32
    MOVK  X9, #0x3617, LSL #48
    SUB  X27, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xd697, LSL #0
    MOVK  X9, #0x8247, LSL #16
    MOVK  X9, #0xb86d, LSL #32
    MOVK  X9, #0xd497, LSL #48
    SUB  X27, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xa3dc, LSL #0
    MOVK  X9, #0x84a3, LSL #16
    MOVK  X9, #0xf425, LSL #32
    MOVK  X9, #0x883d, LSL #48
    SUB  X27, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x9d9, LSL #0
    MOVK  X9, #0xb26f, LSL #16
    MOVK  X9, #0x3fde, LSL #32
    MOVK  X9, #0x2656, LSL #48
    SUB  X27, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x4bd4, LSL #0
    MOVK  X9, #0x594f, LSL #16
    MOVK  X9, #0x6891, LSL #32
    MOVK  X9, #0x1551, LSL #48
    SUB  X27, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x36e2, LSL #0
    MOVK  X9, #0xcf15, LSL #16
    MOVK  X9, #0x7a4d, LSL #32
    MOVK  X9, #0xbc9d, LSL #48
    SUB  X27, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xbae8, LSL #0
    MOVK  X9, #0x389a, LSL #16
    MOVK  X9, #0x2575, LSL #32
    MOVK  X9, #0x3af1, LSL #48
    SUB  X27, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x8e21, LSL #0
    MOVK  X9, #0x9b46, LSL #16
    MOVK  X9, #0x989b, LSL #32
    MOVK  X9, #0xeb57, LSL #48
    SUB  X27, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xcbc0, LSL #0
    MOVK  X9, #0x40c1, LSL #16
    MOVK  X9, #0xe2e2, LSL #32
    MOVK  X9, #0xd88, LSL #48
    SUB  X27, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xe472, LSL #0
    MOVK  X9, #0x6976, LSL #16
    MOVK  X9, #0x7644, LSL #32
    MOVK  X9, #0xc30d, LSL #48
    SUB  X27, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0xb989, LSL #0
    MOVK  X9, #0xf9f5, LSL #16
    MOVK  X9, #0x34d3, LSL #32
    MOVK  X9, #0x71ed, LSL #48
    SUB  X27, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X9, #0x8b50, LSL #0
    MOVK  X9, #0x68c7, LSL #16
    MOVK  X9, #0xab91, LSL #32
    MOVK  X9, #0x36b7, LSL #48
    SUB  X27, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X9, FPSR
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x800, LSL #16
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D0
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D1
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D27
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D30
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X9, D31
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x908, LSL #0
    MOVK  X2, #0xcee5, LSL #16
    MOVK  X2, #0x3232, LSL #32
    MOVK  X2, #0xd4cb, LSL #48
    MOVZ  X3, #0xa3a6, LSL #0
    MOVK  X3, #0x53de, LSL #16
    MOVK  X3, #0x8908, LSL #32
    MOVK  X3, #0x1d2b, LSL #48
    MOVZ  X4, #0xf92c, LSL #0
    MOVK  X4, #0x1f2f, LSL #16
    MOVK  X4, #0xf7d7, LSL #32
    MOVK  X4, #0xb3c0, LSL #48
    MOVZ  X5, #0x415e, LSL #0
    MOVK  X5, #0x5117, LSL #16
    MOVK  X5, #0xf544, LSL #32
    MOVK  X5, #0x38d3, LSL #48
    MOVZ  X6, #0x1fac, LSL #0
    MOVK  X6, #0x5cdb, LSL #16
    MOVK  X6, #0x34fb, LSL #32
    MOVK  X6, #0xf329, LSL #48
    MOVZ  X7, #0xc15f, LSL #0
    MOVK  X7, #0x44, LSL #16
    MOVK  X7, #0x64fe, LSL #32
    MOVK  X7, #0xdfa6, LSL #48
    MOVZ  X8, #0xaa22, LSL #0
    MOVK  X8, #0xdaf1, LSL #16
    MOVK  X8, #0x5256, LSL #32
    MOVK  X8, #0x516, LSL #48
    MOVZ  X9, #0xa230, LSL #0
    MOVK  X9, #0xb1ef, LSL #16
    MOVK  X9, #0xbb19, LSL #32
    MOVK  X9, #0xe2f8, LSL #48
    MOVZ  X10, #0xf517, LSL #0
    MOVK  X10, #0x138f, LSL #16
    MOVK  X10, #0x4e40, LSL #32
    MOVK  X10, #0x4c1, LSL #48
    MOVZ  X16, #0x4197, LSL #0
    MOVK  X16, #0x1fa7, LSL #16
    MOVK  X16, #0x7ae1, LSL #32
    MOVK  X16, #0xc8c, LSL #48
    MOVZ  X17, #0x652a, LSL #0
    MOVK  X17, #0x5768, LSL #16
    MOVK  X17, #0x528a, LSL #32
    MOVK  X17, #0x1d8, LSL #48
    MOVZ  X18, #0x60c2, LSL #0
    MOVK  X18, #0x4aad, LSL #16
    MOVK  X18, #0x969f, LSL #32
    MOVK  X18, #0xca8e, LSL #48
    MOVZ  X19, #0xb7cb, LSL #0
    MOVK  X19, #0xe929, LSL #16
    MOVK  X19, #0xda51, LSL #32
    MOVK  X19, #0x4bb1, LSL #48
    MOVZ  X20, #0xa4b7, LSL #0
    MOVK  X20, #0x4a93, LSL #16
    MOVK  X20, #0xc260, LSL #32
    MOVK  X20, #0xd60a, LSL #48
    MOVZ  X21, #0x292f, LSL #0
    MOVK  X21, #0x97a3, LSL #16
    MOVK  X21, #0x2516, LSL #32
    MOVK  X21, #0xee3a, LSL #48
    MOVZ  X22, #0x23f, LSL #0
    MOVK  X22, #0x347d, LSL #16
    MOVK  X22, #0x97ae, LSL #32
    MOVK  X22, #0x6f1, LSL #48
    MOVZ  X23, #0x7e6f, LSL #0
    MOVK  X23, #0x4d95, LSL #16
    MOVK  X23, #0x40e0, LSL #32
    MOVK  X23, #0xf5b0, LSL #48
    MOVZ  X24, #0xe78b, LSL #0
    MOVK  X24, #0x19f3, LSL #16
    MOVK  X24, #0x1fd3, LSL #32
    MOVK  X24, #0xc7e3, LSL #48
    MOVZ  X25, #0x73e7, LSL #0
    MOVK  X25, #0xca35, LSL #16
    MOVK  X25, #0xf56, LSL #32
    MOVK  X25, #0xad10, LSL #48
    MOVZ  X26, #0xfa57, LSL #0
    MOVK  X26, #0x326b, LSL #16
    MOVK  X26, #0x2ccc, LSL #32
    MOVK  X26, #0x819f, LSL #48
    MOVZ  X27, #0x8caa, LSL #0
    MOVK  X27, #0x3ac2, LSL #16
    MOVK  X27, #0xec36, LSL #32
    MOVK  X27, #0x12c0, LSL #48
    MOVZ  X28, #0x510e, LSL #0
    MOVK  X28, #0xd48, LSL #16
    MOVK  X28, #0xb5c3, LSL #32
    MOVK  X28, #0xd4dd, LSL #48
    MOVZ  X29, #0xde1b, LSL #0
    MOVK  X29, #0x178f, LSL #16
    MOVK  X29, #0xf607, LSL #32
    MOVK  X29, #0x4064, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X18
    FMOV  V2.D[1], X28
    FMOV  D3, X4
    FMOV  V3.D[1], X4
    FMOV  D4, X6
    FMOV  V4.D[1], X25
    FMOV  D5, X27
    FMOV  V5.D[1], X18
    FMOV  D6, X5
    FMOV  V6.D[1], X25
    FMOV  D7, X17
    FMOV  V7.D[1], X8
    FMOV  D8, X21
    FMOV  V8.D[1], X4
    FMOV  D9, X19
    FMOV  V9.D[1], X3
    FMOV  D10, X23
    FMOV  V10.D[1], X6
    FMOV  D11, X29
    FMOV  V11.D[1], X4
    FMOV  D12, X6
    FMOV  V12.D[1], X9
    FMOV  D13, X24
    FMOV  V13.D[1], X28
    FMOV  D14, X17
    FMOV  V14.D[1], X23
    FMOV  D15, X4
    FMOV  V15.D[1], X3
    FMOV  D16, X17
    FMOV  V16.D[1], X19
    FMOV  D17, X8
    FMOV  V17.D[1], X27
    FMOV  D18, X2
    FMOV  V18.D[1], X9
    FMOV  D19, X9
    FMOV  V19.D[1], X16
    FMOV  D20, X22
    FMOV  V20.D[1], X24
    FMOV  D21, X2
    FMOV  V21.D[1], X4
    FMOV  D22, X5
    FMOV  V22.D[1], X16
    FMOV  D23, X28
    FMOV  V23.D[1], X17
    FMOV  D24, X26
    FMOV  V24.D[1], X29
    FMOV  D25, X23
    FMOV  V25.D[1], X16
    FMOV  D26, X23
    FMOV  V26.D[1], X25
    FMOV  D27, X28
    FMOV  V27.D[1], X8
    FMOV  D28, X29
    FMOV  V28.D[1], X22
    FMOV  D29, X22
    FMOV  V29.D[1], X8
    FMOV  D30, X20
    FMOV  V30.D[1], X7
    FMOV  D31, X16
    FMOV  V31.D[1], X29
    SQSHL  V23.16B, V17.16B, #0x1
    SQSHL  V9.16B, V24.16B, #0x7
    SQSHL  V18.16B, V31.16B, #0x6
    SQSHL  V2.8B, V9.8B, #0x2
    SQSHL  V14.16B, V18.16B, #0x3
    SQSHL  V6.16B, V27.16B, #0x6
    SQSHL  V21.16B, V2.16B, #0x1
    SQSHL  V6.8B, V12.8B, #0x3
    SQSHL  V19.16B, V29.16B, #0x7
    SQSHL  V8.16B, V29.16B, #0x3
    SQSHL V1.2D, V6.2D, #0x18
    SQSHL V8.2D, V19.2D, #0x2f
    SQSHL V11.2D, V28.2D, #0x1f
    SQSHL V25.2D, V30.2D, #0x31
    SQSHL V29.2D, V12.2D, #0x11
    SQSHL V15.2D, V14.2D, #0x9
    SQSHL V10.2D, V25.2D, #0x30
    SQSHL V16.2D, V1.2D, #0x28
    SQSHL V9.2D, V8.2D, #0x20
    SQSHL V1.2D, V29.2D, #0x9
    SQSHL  V27.4H, V19.4H, #0x8
    SQSHL  V29.4H, V5.4H, #0xf
    SQSHL  V6.4H, V21.4H, #0x5
    SQSHL  V5.4H, V28.4H, #0xe
    SQSHL  V24.4H, V27.4H, #0x3
    SQSHL  V19.8H, V9.8H, #0x2
    SQSHL  V13.8H, V6.8H, #0xa
    SQSHL  V30.8H, V16.8H, #0xe
    SQSHL  V8.4H, V30.4H, #0xe
    SQSHL  V9.8H, V24.8H, #0x1
    SQSHL  V6.4S, V28.4S, #0x10
    SQSHL  V25.2S, V18.2S, #0x3
    SQSHL  V12.4S, V8.4S, #0x13
    SQSHL  V14.4S, V5.4S, #0x12
    SQSHL  V7.2S, V9.2S, #0x3
    SQSHL  V30.2S, V26.2S, #0xe
    SQSHL  V9.2S, V19.2S, #0x15
    SQSHL  V26.4S, V25.4S, #0x13
    SQSHL  V8.4S, V9.4S, #0xc
    SQSHL  V25.4S, V26.4S, #0x0
    SQSHL  V10.16B, V7.16B, V25.16B
    SQSHL  V28.2D, V29.2D, V29.2D
    SQSHL  V26.16B, V28.16B, V13.16B
    SQSHL  V15.8B, V30.8B, V8.8B
    SQSHL  V27.8H, V10.8H, V1.8H
    SQSHL  V24.2D, V12.2D, V15.2D
    SQSHL  V31.8H, V6.8H, V15.8H
    SQSHL  V29.8B, V31.8B, V14.8B
    SQSHL  V23.4H, V29.4H, V24.4H
    SQSHL  V18.8B, V23.8B, V7.8B
    SQSHLU  V19.8B, V15.8B, #0x5
    SQSHLU  V16.16B, V22.16B, #0x5
    SQSHLU  V1.16B, V18.16B, #0x7
    SQSHLU  V13.16B, V27.16B, #0x0
    SQSHLU  V10.16B, V13.16B, #0x5
    SQSHLU  V27.16B, V10.16B, #0x1
    SQSHLU  V8.8B, V27.8B, #0x1
    SQSHLU  V14.16B, V7.16B, #0x0
    SQSHLU  V24.16B, V26.16B, #0x3
    SQSHLU  V23.16B, V15.16B, #0x2
    SQSHLU V15.2D, V7.2D, #0x25
    SQSHLU V28.2D, V16.2D, #0x20
    SQSHLU V7.2D, V0.2D, #0x9
    SQSHLU V13.2D, V20.2D, #0x24
    SQSHLU V22.2D, V28.2D, #0xf
    SQSHLU V6.2D, V24.2D, #0x1c
    SQSHLU V10.2D, V1.2D, #0x26
    SQSHLU V26.2D, V14.2D, #0x30
    SQSHLU V1.2D, V8.2D, #0x1a
    SQSHLU V20.2D, V1.2D, #0x1d
    SQSHLU  V27.8H, V22.8H, #0x4
    SQSHLU  V16.8H, V26.8H, #0x9
    SQSHLU  V18.4H, V7.4H, #0xd
    SQSHLU  V28.4H, V16.4H, #0xd
    SQSHLU  V8.8H, V28.8H, #0x2
    SQSHLU  V1.4H, V6.4H, #0x2
    SQSHLU  V16.4H, V23.4H, #0x7
    SQSHLU  V7.4H, V16.4H, #0x6
    SQSHLU  V23.4H, V7.4H, #0x9
    SQSHLU  V24.8H, V18.8H, #0xb
    SQSHLU  V18.2S, V15.2S, #0x12
    SQSHLU  V15.4S, V18.4S, #0x17
    SQSHLU  V18.4S, V10.4S, #0x13
    SQSHLU  V12.2S, V15.2S, #0x19
    SQSHLU  V14.2S, V6.2S, #0xf
    SQSHLU  V7.4S, V23.4S, #0x18
    SQSHLU  V1.4S, V13.4S, #0x1
    SQSHLU  V1.2S, V24.2S, #0x4
    SQSHLU  V28.2S, V3.2S, #0x7
    SQSHLU  V22.2S, V28.2S, #0x13
    SQSHRN V16.8B, V7.8H, #3
    SQSHRN V7.8B, V19.8H, #2
    SQSHRN V6.8B, V20.8H, #4
    SQSHRN V23.8B, V6.8H, #1
    SQSHRN V13.8B, V23.8H, #7
    SQSHRN V3.8B, V18.8H, #8
    SQSHRN V18.8B, V1.8H, #7
    SQSHRN V30.8B, V22.8H, #2
    SQSHRN V23.8B, V1.8H, #5
    SQSHRN V24.8B, V27.8H, #2
    SQSHRN V22.4H, V23.4S, #10
    SQSHRN V26.4H, V24.4S, #11
    SQSHRN V10.4H, V18.4S, #5
    SQSHRN V6.4H, V14.4S, #2
    SQSHRN V13.4H, V26.4S, #8
    SQSHRN V18.4H, V13.4S, #2
    SQSHRN V14.4H, V10.4S, #3
    SQSHRN V12.4H, V30.4S, #5
    SQSHRN V1.4H, V18.4S, #1
    SQSHRN V24.4H, V29.4S, #3
    SQSHRN V18.2S, V3.2D, #28
    SQSHRN V13.2S, V18.2D, #21
    SQSHRN V15.2S, V14.2D, #8
    SQSHRN V29.2S, V10.2D, #21
    SQSHRN V4.2S, V6.2D, #19
    SQSHRN V23.2S, V29.2D, #17
    SQSHRN V14.2S, V15.2D, #8
    SQSHRN V15.2S, V23.2D, #8
    SQSHRN V19.2S, V23.2D, #25
    SQSHRN V26.2S, V14.2D, #2
    SQSHRN2 V2.16B, V19.8H, #7
    SQSHRN2 V13.16B, V23.8H, #7
    SQSHRN2 V23.16B, V1.8H, #1
    SQSHRN2 V30.16B, V24.8H, #7
    SQSHRN2 V3.16B, V8.8H, #4
    SQSHRN2 V13.16B, V3.8H, #8
    SQSHRN2 V4.16B, V2.8H, #8
    SQSHRN2 V8.16B, V12.8H, #8
    SQSHRN2 V14.16B, V15.8H, #7
    SQSHRN2 V29.16B, V14.8H, #1
    SQSHRN2 V19.8H, V29.4S, #6
    SQSHRN2 V10.8H, V28.4S, #2
    SQSHRN2 V22.8H, V15.4S, #10
    SQSHRN2 V12.8H, V22.4S, #15
    SQSHRN2 V18.8H, V26.4S, #3
    SQSHRN2 V26.8H, V13.4S, #4
    SQSHRN2 V13.8H, V9.4S, #1
    SQSHRN2 V13.8H, V18.4S, #1
    SQSHRN2 V29.8H, V13.4S, #5
    SQSHRN2 V22.8H, V3.4S, #13
    SQSHRN2 V24.4S, V8.2D, #3
    SQSHRN2 V14.4S, V12.2D, #16
    SQSHRN2 V9.4S, V4.2D, #29
    SQSHRN2 V13.4S, V16.2D, #9
    SQSHRN2 V19.4S, V26.2D, #20
    SQSHRN2 V3.4S, V9.2D, #19
    SQSHRN2 V1.4S, V5.2D, #6
    SQSHRN2 V8.4S, V23.2D, #23
    SQSHRN2 V26.4S, V1.2D, #23
    SQSHRN2 V4.4S, V26.2D, #11
    SQSHRUN V23.8B, V12.8H, #1
    SQSHRUN V5.8B, V23.8H, #4
    SQSHRUN V16.8B, V1.8H, #8
    SQSHRUN V23.8B, V3.8H, #3
    SQSHRUN V15.8B, V8.8H, #2
    SQSHRUN V8.8B, V9.8H, #4
    SQSHRUN V1.8B, V15.8H, #7
    SQSHRUN V9.8B, V23.8H, #7
    SQSHRUN V15.8B, V13.8H, #7
    SQSHRUN V23.8B, V24.8H, #5
    SQSHRUN V24.4H, V0.4S, #15
    SQSHRUN V15.4H, V1.4S, #2
    SQSHRUN V19.4H, V23.4S, #11
    SQSHRUN V12.4H, V15.4S, #10
    SQSHRUN V13.4H, V16.4S, #15
    SQSHRUN V3.4H, V9.4S, #11
    SQSHRUN V23.4H, V3.4S, #4
    SQSHRUN V26.4H, V19.4S, #3
    SQSHRUN V2.4H, V4.4S, #15
    SQSHRUN V3.4H, V12.4S, #6
    SQSHRUN V16.2S, V29.2D, #15
    SQSHRUN V9.2S, V16.2D, #29
    SQSHRUN V22.2S, V23.2D, #9
    SQSHRUN V23.2S, V13.2D, #12
    SQSHRUN V15.2S, V23.2D, #18
    SQSHRUN V30.2S, V22.2D, #21
    SQSHRUN V10.2S, V24.2D, #8
    SQSHRUN V13.2S, V9.2D, #6
    SQSHRUN V22.2S, V13.2D, #7
    SQSHRUN V29.2S, V15.2D, #21
    SQSHRUN2 V7.16B, V2.8H, #8
    SQSHRUN2 V0.16B, V8.8H, #6
    SQSHRUN2 V15.16B, V12.8H, #7
    SQSHRUN2 V24.16B, V26.8H, #5
    SQSHRUN2 V12.16B, V15.8H, #5
    SQSHRUN2 V1.16B, V8.8H, #5
    SQSHRUN2 V16.16B, V0.8H, #3
    SQSHRUN2 V19.16B, V7.8H, #7
    SQSHRUN2 V8.16B, V11.8H, #7
    SQSHRUN2 V9.16B, V8.8H, #5
    SQSHRUN2 V15.8H, V3.4S, #3
    SQSHRUN2 V26.8H, V14.4S, #3
    SQSHRUN2 V14.8H, V9.4S, #6
    SQSHRUN2 V24.8H, V14.4S, #15
    SQSHRUN2 V27.8H, V21.4S, #7
    SQSHRUN2 V27.8H, V30.4S, #15
    SQSHRUN2 V0.8H, V18.4S, #3
    SQSHRUN2 V4.8H, V15.4S, #1
    SQSHRUN2 V15.8H, V27.4S, #15
    SQSHRUN2 V21.8H, V19.4S, #12
    SQSHRUN2 V9.4S, V21.2D, #17
    SQSHRUN2 V21.4S, V1.2D, #10
    SQSHRUN2 V27.4S, V31.2D, #17
    SQSHRUN2 V8.4S, V15.2D, #24
    SQSHRUN2 V18.4S, V9.2D, #30
    SQSHRUN2 V1.4S, V26.2D, #20
    SQSHRUN2 V30.4S, V4.2D, #22
    SQSHRUN2 V12.4S, V1.2D, #13
    SQSHRUN2 V4.4S, V22.2D, #15
    SQSHRUN2 V7.4S, V30.2D, #24
    SQSUB  V26.2S, V12.2S, V27.2S
    SQSUB  V16.2D, V8.2D, V19.2D
    SQSUB  V1.4S, V21.4S, V18.4S
    SQSUB  V3.16B, V0.16B, V9.16B
    SQSUB  V17.8B, V21.8B, V7.8B
    SQSUB  V19.2D, V30.2D, V26.2D
    SQSUB  V3.8H, V3.8H, V1.8H
    SQSUB  V26.4H, V24.4H, V17.4H
    SQSUB  V14.4H, V3.4H, V17.4H
    SQSUB  V8.4H, V16.4H, V4.4H
    SQXTN  V12.2S, V3.2D
    SQXTN  V0.2S, V19.2D
    SQXTN  V1.4H, V12.4S
    SQXTN  V24.8B, V2.8H
    SQXTN  V22.4H, V24.4S
    SQXTN  V16.4H, V1.4S
    SQXTN  V17.4H, V16.4S
    SQXTN  V18.4H, V18.4S
    SQXTN  V2.8B, V0.8H
    SQXTN  V1.2S, V0.2D
    SQXTN2  V15.4S, V4.2D
    SQXTN2  V3.4S, V17.2D
    SQXTN2  V12.8H, V8.4S
    SQXTN2  V9.16B, V1.8H
    SQXTN2  V16.4S, V30.2D
    SQXTN2  V19.16B, V15.8H
    SQXTN2  V17.16B, V2.8H
    SQXTN2  V7.4S, V24.2D
    SQXTN2  V30.16B, V17.8H
    SQXTN2  V1.4S, V22.2D
    SQXTUN  V23.2S, V2.2D
    SQXTUN  V8.8B, V1.8H
    SQXTUN  V21.2S, V30.2D
    SQXTUN  V15.8B, V9.8H
    SQXTUN  V25.2S, V26.2D
    SQXTUN  V0.4H, V16.4S
    SQXTUN  V1.4H, V15.4S
    SQXTUN  V31.4H, V28.4S
    SQXTUN  V15.2S, V0.2D
    SQXTUN  V28.2S, V23.2D
    SQXTUN2  V28.8H, V12.4S
    SQXTUN2  V0.8H, V27.4S
    SQXTUN2  V24.4S, V28.2D
    SQXTUN2  V27.8H, V19.4S
    SQXTUN2  V4.4S, V1.2D
    SQXTUN2  V7.4S, V24.2D
    SQXTUN2  V12.4S, V15.2D
    SQXTUN2  V2.16B, V27.8H
    SQXTUN2  V30.16B, V4.8H
    SQXTUN2  V4.16B, V25.8H
    SRHADD  V17.16B, V31.16B, V30.16B
    SRHADD  V19.8B, V2.8B, V12.8B
    SRHADD  V14.16B, V25.16B, V26.16B
    SRHADD  V30.4S, V9.4S, V5.4S
    SRHADD  V2.4S, V8.4S, V4.4S
    SRHADD  V24.2S, V26.2S, V7.2S
    SRHADD  V12.16B, V20.16B, V17.16B
    SRHADD  V7.4S, V12.4S, V0.4S
    SRHADD  V20.8H, V22.8H, V19.8H
    SRHADD  V9.8H, V7.8H, V20.8H
    SRSHL  V12.2S, V19.2S, V24.2S
    SRSHL  V26.2D, V2.2D, V14.2D
    SRSHL  V22.16B, V12.16B, V9.16B
    SRSHL  V12.2S, V30.2S, V11.2S
    SRSHL  V14.16B, V12.16B, V22.16B
    SRSHL  V15.2S, V6.2S, V19.2S
    SRSHL  V17.16B, V2.16B, V30.16B
    SRSHL  V5.4H, V31.4H, V28.4H
    SRSHL  V4.4H, V2.4H, V11.4H
    SRSHL  V0.8H, V3.8H, V1.8H
    SRSHR  V1.16B, V14.16B, #4
    SRSHR  V27.16B, V27.16B, #4
    SRSHR  V3.16B, V28.16B, #8
    SRSHR  V6.8B, V0.8B, #6
    SRSHR  V2.16B, V20.16B, #4
    SRSHR  V7.16B, V4.16B, #1
    SRSHR  V12.16B, V2.16B, #3
    SRSHR  V23.8B, V15.8B, #1
    SRSHR  V11.8B, V11.8B, #2
    SRSHR  V24.8B, V23.8B, #4
    SRSHR V0.2D, V6.2D, #24
    SRSHR V2.2D, V26.2D, #43
    SRSHR V31.2D, V27.2D, #50
    SRSHR V4.2D, V7.2D, #40
    SRSHR V30.2D, V11.2D, #29
    SRSHR V26.2D, V0.2D, #58
    SRSHR V19.2D, V12.2D, #42
    SRSHR V11.2D, V26.2D, #9
    SRSHR V26.2D, V2.2D, #2
    SRSHR V21.2D, V1.2D, #62
    MOVZ  X29, #0x908, LSL #0
    MOVK  X29, #0xcee5, LSL #16
    MOVK  X29, #0x3232, LSL #32
    MOVK  X29, #0xd4cb, LSL #48
    SUB  X28, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xa3a6, LSL #0
    MOVK  X29, #0x53de, LSL #16
    MOVK  X29, #0x8908, LSL #32
    MOVK  X29, #0x1d2b, LSL #48
    SUB  X28, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xf92c, LSL #0
    MOVK  X29, #0x1f2f, LSL #16
    MOVK  X29, #0xf7d7, LSL #32
    MOVK  X29, #0xb3c0, LSL #48
    SUB  X28, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x415e, LSL #0
    MOVK  X29, #0x5117, LSL #16
    MOVK  X29, #0xf544, LSL #32
    MOVK  X29, #0x38d3, LSL #48
    SUB  X28, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xc15f, LSL #0
    MOVK  X29, #0x44, LSL #16
    MOVK  X29, #0x64fe, LSL #32
    MOVK  X29, #0xdfa6, LSL #48
    SUB  X28, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xaa22, LSL #0
    MOVK  X29, #0xdaf1, LSL #16
    MOVK  X29, #0x5256, LSL #32
    MOVK  X29, #0x516, LSL #48
    SUB  X28, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xa230, LSL #0
    MOVK  X29, #0xb1ef, LSL #16
    MOVK  X29, #0xbb19, LSL #32
    MOVK  X29, #0xe2f8, LSL #48
    SUB  X28, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xf517, LSL #0
    MOVK  X29, #0x138f, LSL #16
    MOVK  X29, #0x4e40, LSL #32
    MOVK  X29, #0x4c1, LSL #48
    SUB  X28, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x4197, LSL #0
    MOVK  X29, #0x1fa7, LSL #16
    MOVK  X29, #0x7ae1, LSL #32
    MOVK  X29, #0xc8c, LSL #48
    SUB  X28, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x652a, LSL #0
    MOVK  X29, #0x5768, LSL #16
    MOVK  X29, #0x528a, LSL #32
    MOVK  X29, #0x1d8, LSL #48
    SUB  X28, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x60c2, LSL #0
    MOVK  X29, #0x4aad, LSL #16
    MOVK  X29, #0x969f, LSL #32
    MOVK  X29, #0xca8e, LSL #48
    SUB  X28, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xb7cb, LSL #0
    MOVK  X29, #0xe929, LSL #16
    MOVK  X29, #0xda51, LSL #32
    MOVK  X29, #0x4bb1, LSL #48
    SUB  X28, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xa4b7, LSL #0
    MOVK  X29, #0x4a93, LSL #16
    MOVK  X29, #0xc260, LSL #32
    MOVK  X29, #0xd60a, LSL #48
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x292f, LSL #0
    MOVK  X29, #0x97a3, LSL #16
    MOVK  X29, #0x2516, LSL #32
    MOVK  X29, #0xee3a, LSL #48
    SUB  X28, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x23f, LSL #0
    MOVK  X29, #0x347d, LSL #16
    MOVK  X29, #0x97ae, LSL #32
    MOVK  X29, #0x6f1, LSL #48
    SUB  X28, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7e6f, LSL #0
    MOVK  X29, #0x4d95, LSL #16
    MOVK  X29, #0x40e0, LSL #32
    MOVK  X29, #0xf5b0, LSL #48
    SUB  X28, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xe78b, LSL #0
    MOVK  X29, #0x19f3, LSL #16
    MOVK  X29, #0x1fd3, LSL #32
    MOVK  X29, #0xc7e3, LSL #48
    SUB  X28, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x73e7, LSL #0
    MOVK  X29, #0xca35, LSL #16
    MOVK  X29, #0xf56, LSL #32
    MOVK  X29, #0xad10, LSL #48
    SUB  X28, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xfa57, LSL #0
    MOVK  X29, #0x326b, LSL #16
    MOVK  X29, #0x2ccc, LSL #32
    MOVK  X29, #0x819f, LSL #48
    SUB  X28, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x8caa, LSL #0
    MOVK  X29, #0x3ac2, LSL #16
    MOVK  X29, #0xec36, LSL #32
    MOVK  X29, #0x12c0, LSL #48
    SUB  X28, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X29, FPSR
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x800, LSL #16
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D0
    MOVZ  X28, #0xfffe, LSL #0
    MOVK  X28, #0x1ff, LSL #16
    MOVK  X28, #0x1, LSL #32
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D1
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D6
    MOVZ  X28, #0x200, LSL #0
    MOVK  X28, #0xfe00, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x101, LSL #48
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D7
    MOVZ  X28, #0x400, LSL #0
    MOVK  X28, #0x20, LSL #32
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D8
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xff, LSL #32
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D9
    MOVZ  X28, #0x4000, LSL #0
    MOVK  X28, #0x1000, LSL #16
    MOVK  X28, #0x1000, LSL #48
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D12
    MOVZ  X28, #0x100, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D15
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D16
    MOVZ  X28, #0x7fff, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D17
    MOVZ  X28, #0x1000, LSL #0
    MOVK  X28, #0x80, LSL #32
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D20
    MOVZ  X28, #0x4000, LSL #0
    MOVK  X28, #0x2000, LSL #16
    MOVK  X28, #0x2000, LSL #48
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D25
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8, LSL #48
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0x8000, LSL #32
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D28
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D30
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x1, LSL #32
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X28, #0x2, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D31
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x6165, LSL #0
    MOVK  X2, #0x599e, LSL #16
    MOVK  X2, #0xea73, LSL #32
    MOVK  X2, #0xde7e, LSL #48
    MOVZ  X3, #0x771f, LSL #0
    MOVK  X3, #0x28e1, LSL #16
    MOVK  X3, #0x6912, LSL #32
    MOVK  X3, #0x535f, LSL #48
    MOVZ  X4, #0x3e6, LSL #0
    MOVK  X4, #0x8e0b, LSL #16
    MOVK  X4, #0xde81, LSL #32
    MOVK  X4, #0x1f43, LSL #48
    MOVZ  X5, #0x8cd5, LSL #0
    MOVK  X5, #0x9932, LSL #16
    MOVK  X5, #0xaa53, LSL #32
    MOVK  X5, #0xab26, LSL #48
    MOVZ  X6, #0xfa21, LSL #0
    MOVK  X6, #0xce9, LSL #16
    MOVK  X6, #0x5d55, LSL #32
    MOVK  X6, #0x4245, LSL #48
    MOVZ  X7, #0x5d2c, LSL #0
    MOVK  X7, #0x733, LSL #16
    MOVK  X7, #0xa700, LSL #32
    MOVK  X7, #0x6d9a, LSL #48
    MOVZ  X8, #0xdb23, LSL #0
    MOVK  X8, #0xb1d0, LSL #16
    MOVK  X8, #0xf320, LSL #32
    MOVK  X8, #0xae0f, LSL #48
    MOVZ  X9, #0xd95d, LSL #0
    MOVK  X9, #0x6514, LSL #16
    MOVK  X9, #0xe91, LSL #32
    MOVK  X9, #0x7a2a, LSL #48
    MOVZ  X10, #0x5f21, LSL #0
    MOVK  X10, #0xbf19, LSL #16
    MOVK  X10, #0x6ed7, LSL #32
    MOVK  X10, #0x12b8, LSL #48
    MOVZ  X16, #0xb746, LSL #0
    MOVK  X16, #0x129, LSL #16
    MOVK  X16, #0x7504, LSL #32
    MOVK  X16, #0x3ca2, LSL #48
    MOVZ  X17, #0xd1be, LSL #0
    MOVK  X17, #0xd142, LSL #16
    MOVK  X17, #0x6bbb, LSL #32
    MOVK  X17, #0xa439, LSL #48
    MOVZ  X18, #0x3175, LSL #0
    MOVK  X18, #0x45f7, LSL #16
    MOVK  X18, #0x32e3, LSL #32
    MOVK  X18, #0xdde4, LSL #48
    MOVZ  X19, #0xd650, LSL #0
    MOVK  X19, #0xeb08, LSL #16
    MOVK  X19, #0x65a5, LSL #32
    MOVK  X19, #0x5c72, LSL #48
    MOVZ  X20, #0x51ab, LSL #0
    MOVK  X20, #0x6b81, LSL #16
    MOVK  X20, #0x1bcb, LSL #32
    MOVK  X20, #0x8769, LSL #48
    MOVZ  X21, #0xd0c9, LSL #0
    MOVK  X21, #0x156c, LSL #16
    MOVK  X21, #0xa80d, LSL #32
    MOVK  X21, #0xe8e5, LSL #48
    MOVZ  X22, #0x67e9, LSL #0
    MOVK  X22, #0x2ed8, LSL #16
    MOVK  X22, #0x81ee, LSL #32
    MOVK  X22, #0x8d9a, LSL #48
    MOVZ  X23, #0xb49d, LSL #0
    MOVK  X23, #0x1222, LSL #16
    MOVK  X23, #0x8eb8, LSL #32
    MOVK  X23, #0x7c2e, LSL #48
    MOVZ  X24, #0x7788, LSL #0
    MOVK  X24, #0x8598, LSL #16
    MOVK  X24, #0xe063, LSL #32
    MOVK  X24, #0xd72b, LSL #48
    MOVZ  X25, #0xb500, LSL #0
    MOVK  X25, #0x3c0, LSL #16
    MOVK  X25, #0x671, LSL #32
    MOVK  X25, #0x76a1, LSL #48
    MOVZ  X26, #0x7cd7, LSL #0
    MOVK  X26, #0x3d1f, LSL #16
    MOVK  X26, #0x39d3, LSL #32
    MOVK  X26, #0x1ee1, LSL #48
    MOVZ  X27, #0xfff7, LSL #0
    MOVK  X27, #0xe152, LSL #16
    MOVK  X27, #0xb106, LSL #32
    MOVK  X27, #0x63ce, LSL #48
    MOVZ  X28, #0x8d9e, LSL #0
    MOVK  X28, #0x40f2, LSL #16
    MOVK  X28, #0x10af, LSL #32
    MOVK  X28, #0xb242, LSL #48
    MOVZ  X29, #0xe2ea, LSL #0
    MOVK  X29, #0x2503, LSL #16
    MOVK  X29, #0x3b59, LSL #32
    MOVK  X29, #0x88fc, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X7
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X28
    FMOV  V3.D[1], X9
    FMOV  D4, X29
    FMOV  V4.D[1], X3
    FMOV  D5, X28
    FMOV  V5.D[1], X25
    FMOV  D6, X4
    FMOV  V6.D[1], X23
    FMOV  D7, X19
    FMOV  V7.D[1], X6
    FMOV  D8, X10
    FMOV  V8.D[1], X27
    FMOV  D9, X9
    FMOV  V9.D[1], X26
    FMOV  D10, X6
    FMOV  V10.D[1], X17
    FMOV  D11, X8
    FMOV  V11.D[1], X2
    FMOV  D12, X28
    FMOV  V12.D[1], X28
    FMOV  D13, X24
    FMOV  V13.D[1], X22
    FMOV  D14, X24
    FMOV  V14.D[1], X22
    FMOV  D15, X29
    FMOV  V15.D[1], X17
    FMOV  D16, X20
    FMOV  V16.D[1], X23
    FMOV  D17, X22
    FMOV  V17.D[1], X6
    FMOV  D18, X28
    FMOV  V18.D[1], X18
    FMOV  D19, X5
    FMOV  V19.D[1], X5
    FMOV  D20, X8
    FMOV  V20.D[1], X16
    FMOV  D21, X6
    FMOV  V21.D[1], X19
    FMOV  D22, X25
    FMOV  V22.D[1], X8
    FMOV  D23, X4
    FMOV  V23.D[1], X23
    FMOV  D24, X7
    FMOV  V24.D[1], X5
    FMOV  D25, X24
    FMOV  V25.D[1], X28
    FMOV  D26, X9
    FMOV  V26.D[1], X27
    FMOV  D27, X3
    FMOV  V27.D[1], X18
    FMOV  D28, X22
    FMOV  V28.D[1], X29
    FMOV  D29, X10
    FMOV  V29.D[1], X23
    FMOV  D30, X2
    FMOV  V30.D[1], X21
    FMOV  D31, X6
    FMOV  V31.D[1], X9
    SRSHR  V17.8H, V28.8H, #6
    SRSHR  V4.8H, V20.8H, #13
    SRSHR  V15.4H, V26.4H, #3
    SRSHR  V22.4H, V29.4H, #2
    SRSHR  V27.4H, V24.4H, #14
    SRSHR  V7.4H, V15.4H, #7
    SRSHR  V20.4H, V7.4H, #16
    SRSHR  V22.8H, V22.8H, #9
    SRSHR  V19.4H, V4.4H, #13
    SRSHR  V5.4H, V21.4H, #16
    SRSHR  V20.2S, V27.2S, #16
    SRSHR  V11.4S, V30.4S, #4
    SRSHR  V31.4S, V22.4S, #13
    SRSHR  V0.2S, V20.2S, #3
    SRSHR  V25.4S, V5.4S, #28
    SRSHR  V2.4S, V31.4S, #14
    SRSHR  V7.2S, V22.2S, #31
    SRSHR  V7.2S, V19.2S, #3
    SRSHR  V27.2S, V3.2S, #12
    SRSHR  V16.4S, V26.4S, #14
    SRSRA  V29.8B, V25.8B, #4
    SRSRA  V10.8B, V2.8B, #1
    SRSRA  V24.16B, V11.16B, #6
    SRSRA  V3.8B, V24.8B, #3
    SRSRA  V4.16B, V3.16B, #2
    SRSRA  V5.16B, V27.16B, #4
    SRSRA  V2.16B, V26.16B, #5
    SRSRA  V11.8B, V4.8B, #1
    SRSRA  V21.16B, V29.16B, #5
    SRSRA  V29.8B, V16.8B, #7
    SRSRA V24.2D, V29.2D, #46
    SRSRA V4.2D, V21.2D, #24
    SRSRA V27.2D, V12.2D, #35
    SRSRA V19.2D, V25.2D, #41
    SRSRA V11.2D, V27.2D, #56
    SRSRA V3.2D, V24.2D, #40
    SRSRA V13.2D, V0.2D, #11
    SRSRA V29.2D, V28.2D, #34
    SRSRA V28.2D, V19.2D, #58
    SRSRA V12.2D, V10.2D, #15
    SRSRA  V24.4H, V5.4H, #11
    SRSRA  V22.4H, V29.4H, #15
    SRSRA  V31.8H, V4.8H, #10
    SRSRA  V20.4H, V7.4H, #12
    SRSRA  V19.4H, V24.4H, #1
    SRSRA  V28.8H, V19.8H, #16
    SRSRA  V5.8H, V12.8H, #7
    SRSRA  V19.4H, V11.4H, #11
    SRSRA  V25.4H, V28.4H, #16
    SRSRA  V9.4H, V9.4H, #9
    SRSRA  V12.2S, V5.2S, #13
    SRSRA  V5.2S, V25.2S, #29
    SRSRA  V7.2S, V22.2S, #6
    SRSRA  V4.2S, V9.2S, #21
    SRSRA  V10.2S, V5.2S, #17
    SRSRA  V11.4S, V19.4S, #9
    SRSRA  V25.4S, V12.4S, #13
    SRSRA  V9.4S, V25.4S, #15
    SRSRA  V27.4S, V9.4S, #15
    SRSRA  V29.2S, V29.2S, #5
    SSHL  V9.4S, V11.4S, V25.4S
    SSHL  V11.4S, V10.4S, V10.4S
    SSHL  V10.4S, V10.4S, V20.4S
    SSHL  V25.8H, V10.8H, V4.8H
    SSHL  V27.16B, V23.16B, V29.16B
    SSHL  V22.8B, V15.8B, V25.8B
    SSHL  V10.2D, V9.2D, V27.2D
    SSHL  V19.16B, V11.16B, V22.16B
    SSHL  V24.8B, V15.8B, V10.8B
    SSHL  V27.2D, V23.2D, V24.2D
    SSHLL V22.2D, V31.2S, #0x5
    SSHLL V11.2D, V18.2S, #0x1
    SSHLL V25.2D, V3.2S, #0x1e
    SSHLL V10.2D, V22.2S, #0x1b
    SSHLL V6.2D, V20.2S, #0x1c
    SSHLL V15.2D, V25.2S, #0x18
    SSHLL V20.2D, V15.2S, #0x14
    SSHLL V18.2D, V15.2S, #0x1b
    SSHLL V24.2D, V11.2S, #0x8
    SSHLL V11.2D, V20.2S, #0x13
    SSHLL V23.8H, V11.8B, #0x4
    SSHLL V29.8H, V27.8B, #0x5
    SSHLL V20.8H, V10.8B, #0x1
    SSHLL V15.8H, V11.8B, #0x4
    SSHLL V3.8H, V23.8B, #0x6
    SSHLL V10.8H, V19.8B, #0x2
    SSHLL V11.8H, V6.8B, #0x5
    SSHLL V6.8H, V4.8B, #0x1
    SSHLL V23.8H, V18.8B, #0x7
    SSHLL V18.8H, V8.8B, #0x3
    SSHLL V25.4S, V20.4H, #0x5
    SSHLL V8.4S, V13.4H, #0x8
    SSHLL V13.4S, V6.4H, #0x3
    SSHLL V4.4S, V29.4H, #0xd
    SSHLL V29.4S, V13.4H, #0xe
    SSHLL V8.4S, V25.4H, #0xc
    SSHLL V27.4S, V11.4H, #0xd
    SSHLL V11.4S, V18.4H, #0x6
    SSHLL V20.4S, V30.4H, #0x4
    SSHLL V18.4S, V4.4H, #0x1
    SSHLL2 V0.2D, V8.4S, #0x10
    SSHLL2 V19.2D, V3.4S, #0x4
    SSHLL2 V3.2D, V29.4S, #0x17
    SSHLL2 V25.2D, V4.4S, #0x3
    SSHLL2 V4.2D, V22.4S, #0x1a
    SSHLL2 V0.2D, V20.4S, #0x8
    SSHLL2 V15.2D, V7.4S, #0x16
    SSHLL2 V13.2D, V30.4S, #0xc
    SSHLL2 V7.2D, V23.4S, #0x5
    SSHLL2 V8.2D, V16.4S, #0x7
    SSHLL2 V6.8H, V8.16B, #0x1
    SSHLL2 V17.8H, V25.16B, #0x2
    SSHLL2 V23.8H, V7.16B, #0x1
    SSHLL2 V7.8H, V23.16B, #0x1
    SSHLL2 V25.8H, V17.16B, #0x3
    SSHLL2 V0.8H, V14.16B, #0x1
    SSHLL2 V11.8H, V4.16B, #0x7
    SSHLL2 V27.8H, V25.16B, #0x7
    SSHLL2 V20.8H, V5.16B, #0x1
    SSHLL2 V23.8H, V28.16B, #0x2
    SSHLL2 V5.4S, V3.8H, #0xa
    SSHLL2 V17.4S, V15.8H, #0x3
    SSHLL2 V12.4S, V19.8H, #0x6
    SSHLL2 V3.4S, V7.8H, #0x3
    SSHLL2 V7.4S, V0.8H, #0x7
    SSHLL2 V0.4S, V11.8H, #0x3
    SSHLL2 V8.4S, V13.8H, #0x1
    SSHLL2 V6.4S, V7.8H, #0xb
    SSHLL2 V11.4S, V0.8H, #0x2
    SSHLL2 V27.4S, V8.8H, #0x9
    SSHR  V4.16B, V17.16B, #6
    SSHR  V15.16B, V4.16B, #4
    SSHR  V8.8B, V5.8B, #1
    SSHR  V5.16B, V8.16B, #6
    SSHR  V16.8B, V15.8B, #4
    SSHR  V30.8B, V23.8B, #5
    SSHR  V7.8B, V20.8B, #3
    SSHR  V20.8B, V17.8B, #1
    SSHR  V0.8B, V2.8B, #5
    SSHR  V19.16B, V7.16B, #5
    SSHR V4.2D, V31.2D, #52
    SSHR V8.2D, V6.2D, #42
    SSHR V14.2D, V16.2D, #2
    SSHR V23.2D, V14.2D, #63
    SSHR V17.2D, V31.2D, #11
    SSHR V6.2D, V11.2D, #23
    SSHR V15.2D, V21.2D, #40
    SSHR V16.2D, V8.2D, #59
    SSHR V14.2D, V17.2D, #46
    SSHR V11.2D, V12.2D, #7
    SSHR  V21.8H, V23.8H, #10
    SSHR  V31.8H, V19.8H, #7
    SSHR  V23.8H, V24.8H, #1
    SSHR  V24.4H, V21.4H, #4
    SSHR  V7.8H, V20.8H, #5
    SSHR  V13.8H, V14.8H, #6
    SSHR  V8.4H, V24.4H, #9
    SSHR  V19.4H, V8.4H, #16
    SSHR  V2.4H, V16.4H, #3
    SSHR  V8.4H, V23.4H, #7
    SSHR  V16.4S, V4.4S, #10
    SSHR  V24.4S, V19.4S, #3
    SSHR  V28.2S, V18.2S, #11
    SSHR  V7.2S, V8.2S, #29
    SSHR  V14.4S, V13.4S, #12
    SSHR  V8.4S, V2.4S, #6
    SSHR  V8.2S, V6.2S, #21
    SSHR  V1.2S, V27.2S, #30
    SSHR  V6.4S, V28.4S, #1
    SSHR  V13.2S, V15.2S, #27
    SSRA  V4.16B, V31.16B, #2
    SSRA  V28.16B, V4.16B, #8
    SSRA  V18.8B, V13.8B, #1
    SSRA  V12.8B, V6.8B, #6
    SSRA  V20.16B, V30.16B, #4
    SSRA  V21.16B, V20.16B, #1
    SSRA  V4.8B, V28.8B, #6
    SSRA  V6.8B, V0.8B, #1
    SSRA  V15.8B, V24.8B, #6
    SSRA  V22.8B, V7.8B, #1
    SSRA V27.2D, V21.2D, #32
    SSRA V18.2D, V16.2D, #19
    SSRA V28.2D, V12.2D, #50
    SSRA V31.2D, V31.2D, #51
    SSRA V21.2D, V1.2D, #45
    SSRA V13.2D, V3.2D, #6
    SSRA V0.2D, V29.2D, #59
    SSRA V15.2D, V13.2D, #36
    SSRA V13.2D, V28.2D, #9
    SSRA V16.2D, V6.2D, #63
    SSRA  V3.4H, V0.4H, #1
    SSRA  V25.8H, V18.8H, #4
    SSRA  V6.4H, V22.4H, #2
    SSRA  V16.4H, V31.4H, #5
    SSRA  V1.4H, V16.4H, #11
    SSRA  V4.4H, V27.4H, #10
    SSRA  V26.8H, V15.8H, #15
    SSRA  V18.8H, V5.8H, #4
    SSRA  V16.4H, V12.4H, #14
    SSRA  V0.8H, V1.8H, #10
    SSRA  V27.2S, V27.2S, #32
    SSRA  V7.2S, V25.2S, #29
    SSRA  V20.4S, V13.4S, #15
    SSRA  V22.4S, V20.4S, #10
    SSRA  V20.4S, V10.4S, #25
    SSRA  V10.2S, V12.2S, #32
    SSRA  V6.2S, V15.2S, #24
    SSRA  V13.4S, V3.4S, #27
    SSRA  V0.2S, V0.2S, #21
    SSRA  V5.4S, V13.4S, #3
    SSUBL  V25.4S, V20.4H, V6.4H
    SSUBL  V3.4S, V26.4H, V16.4H
    SSUBL  V12.2D, V27.2S, V17.2S
    SSUBL  V17.8H, V25.8B, V25.8B
    SSUBL  V25.8H, V17.8B, V0.8B
    SSUBL  V21.4S, V3.4H, V18.4H
    SSUBL  V14.4S, V21.4H, V21.4H
    SSUBL  V25.8H, V3.8B, V10.8B
    SSUBL  V18.2D, V7.2S, V5.2S
    SSUBL  V29.8H, V15.8B, V30.8B
    SSUBL2  V5.2D, V18.4S, V12.4S
    SSUBL2  V12.4S, V14.8H, V25.8H
    SSUBL2  V8.4S, V12.8H, V9.8H
    SSUBL2  V3.2D, V4.4S, V28.4S
    SSUBL2  V14.4S, V18.8H, V1.8H
    SSUBL2  V7.2D, V3.4S, V1.4S
    SSUBL2  V16.8H, V4.16B, V22.16B
    SSUBL2  V28.4S, V7.8H, V16.8H
    SSUBL2  V6.8H, V13.16B, V29.16B
    SSUBL2  V26.8H, V14.16B, V23.16B
    SSUBW  V22.2D, V5.2D, V18.2S
    SSUBW  V21.8H, V8.8H, V12.8B
    SSUBW  V3.8H, V28.8H, V31.8B
    SSUBW  V28.4S, V13.4S, V0.4H
    SSUBW  V20.4S, V6.4S, V21.4H
    SSUBW  V7.8H, V26.8H, V3.8B
    SSUBW  V28.8H, V5.8H, V7.8B
    SSUBW  V11.4S, V22.4S, V22.4H
    SSUBW  V22.2D, V11.2D, V11.2S
    SSUBW  V17.8H, V22.8H, V28.8B
    SSUBW2  V16.8H, V4.8H, V11.16B
    SSUBW2  V0.2D, V17.2D, V30.4S
    SSUBW2  V24.2D, V27.2D, V30.4S
    SSUBW2  V14.4S, V13.4S, V10.8H
    SSUBW2  V11.4S, V30.4S, V29.8H
    SSUBW2  V19.8H, V19.8H, V12.16B
    SSUBW2  V4.4S, V10.4S, V12.8H
    SSUBW2  V19.4S, V8.4S, V12.8H
    SSUBW2  V13.2D, V14.2D, V0.4S
    SSUBW2  V12.8H, V20.8H, V20.16B
    SUQADD  V21.2S, V11.2S
    SUQADD  V8.2S, V4.2S
    SUQADD  V31.2D, V8.2D
    SUQADD  V26.4S, V4.4S
    SUQADD  V12.16B, V13.16B
    SUQADD  V13.8B, V16.8B
    SUQADD  V8.16B, V12.16B
    SUQADD  V20.8H, V13.8H
    SUQADD  V22.8H, V19.8H
    SUQADD  V27.16B, V1.16B
    SXTL V0.2D, V18.2S
    SXTL V29.2D, V28.2S
    SXTL V19.2D, V29.2S
    SXTL V25.2D, V2.2S
    SXTL V2.2D, V26.2S
    SXTL V26.2D, V20.2S
    SXTL V12.2D, V21.2S
    SXTL V20.2D, V2.2S
    SXTL V8.2D, V22.2S
    SXTL V13.2D, V3.2S
    SXTL V1.8H, V31.8B
    SXTL V26.8H, V26.8B
    SXTL V2.8H, V0.8B
    SXTL V4.8H, V28.8B
    SXTL V0.8H, V1.8B
    SXTL V21.8H, V4.8B
    SXTL V31.8H, V13.8B
    SXTL V16.8H, V21.8B
    SXTL V29.8H, V25.8B
    SXTL V28.8H, V14.8B
    SXTL V3.4S, V27.4H
    SXTL V1.4S, V31.4H
    SXTL V13.4S, V20.4H
    SXTL V20.4S, V9.4H
    SXTL V9.4S, V16.4H
    SXTL V21.4S, V0.4H
    SXTL V31.4S, V26.4H
    SXTL V19.4S, V28.4H
    SXTL V28.4S, V31.4H
    SXTL V31.4S, V9.4H
    SXTL2 V18.2D, V25.4S
    SXTL2 V0.2D, V20.4S
    SXTL2 V26.2D, V0.4S
    SXTL2 V4.2D, V18.4S
    SXTL2 V16.2D, V13.4S
    SXTL2 V27.2D, V4.4S
    SXTL2 V4.2D, V26.4S
    SXTL2 V22.2D, V29.4S
    SXTL2 V11.2D, V8.4S
    SXTL2 V20.2D, V19.4S
    MOVZ  X26, #0x6165, LSL #0
    MOVK  X26, #0x599e, LSL #16
    MOVK  X26, #0xea73, LSL #32
    MOVK  X26, #0xde7e, LSL #48
    SUB  X5, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x771f, LSL #0
    MOVK  X26, #0x28e1, LSL #16
    MOVK  X26, #0x6912, LSL #32
    MOVK  X26, #0x535f, LSL #48
    SUB  X5, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x3e6, LSL #0
    MOVK  X26, #0x8e0b, LSL #16
    MOVK  X26, #0xde81, LSL #32
    MOVK  X26, #0x1f43, LSL #48
    SUB  X5, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xfa21, LSL #0
    MOVK  X26, #0xce9, LSL #16
    MOVK  X26, #0x5d55, LSL #32
    MOVK  X26, #0x4245, LSL #48
    SUB  X5, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5d2c, LSL #0
    MOVK  X26, #0x733, LSL #16
    MOVK  X26, #0xa700, LSL #32
    MOVK  X26, #0x6d9a, LSL #48
    SUB  X5, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xdb23, LSL #0
    MOVK  X26, #0xb1d0, LSL #16
    MOVK  X26, #0xf320, LSL #32
    MOVK  X26, #0xae0f, LSL #48
    SUB  X5, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xd95d, LSL #0
    MOVK  X26, #0x6514, LSL #16
    MOVK  X26, #0xe91, LSL #32
    MOVK  X26, #0x7a2a, LSL #48
    SUB  X5, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5f21, LSL #0
    MOVK  X26, #0xbf19, LSL #16
    MOVK  X26, #0x6ed7, LSL #32
    MOVK  X26, #0x12b8, LSL #48
    SUB  X5, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xb746, LSL #0
    MOVK  X26, #0x129, LSL #16
    MOVK  X26, #0x7504, LSL #32
    MOVK  X26, #0x3ca2, LSL #48
    SUB  X5, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x3175, LSL #0
    MOVK  X26, #0x45f7, LSL #16
    MOVK  X26, #0x32e3, LSL #32
    MOVK  X26, #0xdde4, LSL #48
    SUB  X5, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xd650, LSL #0
    MOVK  X26, #0xeb08, LSL #16
    MOVK  X26, #0x65a5, LSL #32
    MOVK  X26, #0x5c72, LSL #48
    SUB  X5, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x51ab, LSL #0
    MOVK  X26, #0x6b81, LSL #16
    MOVK  X26, #0x1bcb, LSL #32
    MOVK  X26, #0x8769, LSL #48
    SUB  X5, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xd0c9, LSL #0
    MOVK  X26, #0x156c, LSL #16
    MOVK  X26, #0xa80d, LSL #32
    MOVK  X26, #0xe8e5, LSL #48
    SUB  X5, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x67e9, LSL #0
    MOVK  X26, #0x2ed8, LSL #16
    MOVK  X26, #0x81ee, LSL #32
    MOVK  X26, #0x8d9a, LSL #48
    SUB  X5, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xb49d, LSL #0
    MOVK  X26, #0x1222, LSL #16
    MOVK  X26, #0x8eb8, LSL #32
    MOVK  X26, #0x7c2e, LSL #48
    SUB  X5, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x7788, LSL #0
    MOVK  X26, #0x8598, LSL #16
    MOVK  X26, #0xe063, LSL #32
    MOVK  X26, #0xd72b, LSL #48
    SUB  X5, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xb500, LSL #0
    MOVK  X26, #0x3c0, LSL #16
    MOVK  X26, #0x671, LSL #32
    MOVK  X26, #0x76a1, LSL #48
    SUB  X5, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xfff7, LSL #0
    MOVK  X26, #0xe152, LSL #16
    MOVK  X26, #0xb106, LSL #32
    MOVK  X26, #0x63ce, LSL #48
    SUB  X5, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x8d9e, LSL #0
    MOVK  X26, #0x40f2, LSL #16
    MOVK  X26, #0x10af, LSL #32
    MOVK  X26, #0xb242, LSL #48
    SUB  X5, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xe2ea, LSL #0
    MOVK  X26, #0x2503, LSL #16
    MOVK  X26, #0x3b59, LSL #32
    MOVK  X26, #0x88fc, LSL #48
    SUB  X5, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x800, LSL #16
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X5, #0xc0e0, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D0
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D1
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D2
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X5, #0x7f7f, LSL #0
    MOVK  X5, #0x7f7f, LSL #32
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D3
    MOVZ  X5, #0x7f7f, LSL #0
    MOVK  X5, #0x7f7f, LSL #32
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D4
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D5
    MOVZ  X5, #0x17f, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X5, #0xfffc, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D7
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D9
    MOVZ  X5, #0xff80, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X5, #0x1, LSL #0
    MOVK  X5, #0xfd, LSL #16
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D12
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D13
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D14
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D15
    MOVZ  X5, #0x4360, LSL #0
    MOVK  X5, #0x43, LSL #16
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D16
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xffff, LSL #32
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D17
    MOVZ  X5, #0x80, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D18
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D19
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D20
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D22
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D23
    MOVZ  X5, #0x1e00, LSL #0
    MOVK  X5, #0xf28d, LSL #16
    MOVK  X5, #0xffc0, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D24
    MOVZ  X5, #0x3800, LSL #0
    MOVK  X5, #0xf9, LSL #16
    MOVK  X5, #0xfe00, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D25
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D26
    MOVZ  X5, #0xc0e0, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D27
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X5, #0x7e, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D28
    MOVZ  X5, #0xfff5, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D29
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D30
    MOVZ  X5, #0xfffd, LSL #0
    MOVK  X5, #0xfffc, LSL #16
    MOVK  X5, #0xfc, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D31
    MOVZ  X5, #0xff80, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xb96c, LSL #0
    MOVK  X2, #0x58c1, LSL #16
    MOVK  X2, #0xac4f, LSL #32
    MOVK  X2, #0xb501, LSL #48
    MOVZ  X3, #0x7667, LSL #0
    MOVK  X3, #0xa88f, LSL #16
    MOVK  X3, #0x3489, LSL #32
    MOVK  X3, #0x4f3f, LSL #48
    MOVZ  X4, #0xa02f, LSL #0
    MOVK  X4, #0xd44e, LSL #16
    MOVK  X4, #0xe0fc, LSL #32
    MOVK  X4, #0x6742, LSL #48
    MOVZ  X5, #0xdcb7, LSL #0
    MOVK  X5, #0xd897, LSL #16
    MOVK  X5, #0x8d00, LSL #32
    MOVK  X5, #0xace9, LSL #48
    MOVZ  X6, #0x908f, LSL #0
    MOVK  X6, #0xb461, LSL #16
    MOVK  X6, #0x995c, LSL #32
    MOVK  X6, #0x81c7, LSL #48
    MOVZ  X7, #0x1b24, LSL #0
    MOVK  X7, #0xbf03, LSL #16
    MOVK  X7, #0x2eb4, LSL #32
    MOVK  X7, #0x6e9c, LSL #48
    MOVZ  X8, #0x234a, LSL #0
    MOVK  X8, #0xdcab, LSL #16
    MOVK  X8, #0x942b, LSL #32
    MOVK  X8, #0xe967, LSL #48
    MOVZ  X9, #0x3b55, LSL #0
    MOVK  X9, #0x4cdf, LSL #16
    MOVK  X9, #0x464, LSL #32
    MOVK  X9, #0x3a64, LSL #48
    MOVZ  X10, #0xd79, LSL #0
    MOVK  X10, #0x62e3, LSL #16
    MOVK  X10, #0x4f10, LSL #32
    MOVK  X10, #0x5fa9, LSL #48
    MOVZ  X16, #0x8460, LSL #0
    MOVK  X16, #0xa9a, LSL #16
    MOVK  X16, #0xef0b, LSL #32
    MOVK  X16, #0x8fb0, LSL #48
    MOVZ  X17, #0x59b, LSL #0
    MOVK  X17, #0x313e, LSL #16
    MOVK  X17, #0xd473, LSL #32
    MOVK  X17, #0x73cd, LSL #48
    MOVZ  X18, #0xa8b4, LSL #0
    MOVK  X18, #0x817a, LSL #16
    MOVK  X18, #0xef15, LSL #32
    MOVK  X18, #0xab04, LSL #48
    MOVZ  X19, #0x721e, LSL #0
    MOVK  X19, #0xa0a3, LSL #16
    MOVK  X19, #0x1471, LSL #32
    MOVK  X19, #0x97cf, LSL #48
    MOVZ  X20, #0x860, LSL #0
    MOVK  X20, #0x8704, LSL #16
    MOVK  X20, #0x1fa9, LSL #32
    MOVK  X20, #0x19a7, LSL #48
    MOVZ  X21, #0xa243, LSL #0
    MOVK  X21, #0xbe8d, LSL #16
    MOVK  X21, #0xbce1, LSL #32
    MOVK  X21, #0xbee5, LSL #48
    MOVZ  X22, #0x8009, LSL #0
    MOVK  X22, #0x8069, LSL #16
    MOVK  X22, #0x1be8, LSL #32
    MOVK  X22, #0x71f9, LSL #48
    MOVZ  X23, #0x5984, LSL #0
    MOVK  X23, #0xa4a7, LSL #16
    MOVK  X23, #0x8423, LSL #32
    MOVK  X23, #0x3660, LSL #48
    MOVZ  X24, #0x2529, LSL #0
    MOVK  X24, #0x96be, LSL #16
    MOVK  X24, #0x360, LSL #32
    MOVK  X24, #0x5b36, LSL #48
    MOVZ  X25, #0xd165, LSL #0
    MOVK  X25, #0x3a38, LSL #16
    MOVK  X25, #0xe189, LSL #32
    MOVK  X25, #0x2a84, LSL #48
    MOVZ  X26, #0xc229, LSL #0
    MOVK  X26, #0x72f, LSL #16
    MOVK  X26, #0xeda2, LSL #32
    MOVK  X26, #0xc8c3, LSL #48
    MOVZ  X27, #0x8533, LSL #0
    MOVK  X27, #0xb89d, LSL #16
    MOVK  X27, #0xce86, LSL #32
    MOVK  X27, #0x9679, LSL #48
    MOVZ  X28, #0x5746, LSL #0
    MOVK  X28, #0xa514, LSL #16
    MOVK  X28, #0x628a, LSL #32
    MOVK  X28, #0xc64, LSL #48
    MOVZ  X29, #0x8344, LSL #0
    MOVK  X29, #0xfc68, LSL #16
    MOVK  X29, #0x49ff, LSL #32
    MOVK  X29, #0x2852, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X23
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X24
    FMOV  D4, X5
    FMOV  V4.D[1], X2
    FMOV  D5, X3
    FMOV  V5.D[1], X16
    FMOV  D6, X20
    FMOV  V6.D[1], X18
    FMOV  D7, X17
    FMOV  V7.D[1], X28
    FMOV  D8, X20
    FMOV  V8.D[1], X19
    FMOV  D9, X16
    FMOV  V9.D[1], X23
    FMOV  D10, X21
    FMOV  V10.D[1], X10
    FMOV  D11, X22
    FMOV  V11.D[1], X7
    FMOV  D12, X23
    FMOV  V12.D[1], X16
    FMOV  D13, X3
    FMOV  V13.D[1], X6
    FMOV  D14, X6
    FMOV  V14.D[1], X20
    FMOV  D15, X8
    FMOV  V15.D[1], X3
    FMOV  D16, X10
    FMOV  V16.D[1], X10
    FMOV  D17, X3
    FMOV  V17.D[1], X5
    FMOV  D18, X5
    FMOV  V18.D[1], X10
    FMOV  D19, X23
    FMOV  V19.D[1], X6
    FMOV  D20, X29
    FMOV  V20.D[1], X17
    FMOV  D21, X18
    FMOV  V21.D[1], X29
    FMOV  D22, X2
    FMOV  V22.D[1], X3
    FMOV  D23, X9
    FMOV  V23.D[1], X19
    FMOV  D24, X7
    FMOV  V24.D[1], X19
    FMOV  D25, X23
    FMOV  V25.D[1], X8
    FMOV  D26, X4
    FMOV  V26.D[1], X4
    FMOV  D27, X8
    FMOV  V27.D[1], X9
    FMOV  D28, X9
    FMOV  V28.D[1], X21
    FMOV  D29, X17
    FMOV  V29.D[1], X17
    FMOV  D30, X3
    FMOV  V30.D[1], X22
    FMOV  D31, X8
    FMOV  V31.D[1], X26
    SXTL2 V23.8H, V27.16B
    SXTL2 V25.8H, V25.16B
    SXTL2 V28.8H, V26.16B
    SXTL2 V10.8H, V25.16B
    SXTL2 V5.8H, V3.16B
    SXTL2 V5.8H, V29.16B
    SXTL2 V14.8H, V23.16B
    SXTL2 V29.8H, V10.16B
    SXTL2 V16.8H, V24.16B
    SXTL2 V29.8H, V29.16B
    SXTL2 V2.4S, V30.8H
    SXTL2 V15.4S, V6.8H
    SXTL2 V29.4S, V31.8H
    SXTL2 V19.4S, V30.8H
    SXTL2 V27.4S, V19.8H
    SXTL2 V6.4S, V14.8H
    SXTL2 V10.4S, V10.8H
    SXTL2 V25.4S, V5.8H
    SXTL2 V14.4S, V31.8H
    SXTL2 V3.4S, V2.8H
    MOVZ  X6, #0x7667, LSL #0
    MOVK  X6, #0xa88f, LSL #16
    MOVK  X6, #0x3489, LSL #32
    MOVK  X6, #0x4f3f, LSL #48
    SUB  X19, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0xa02f, LSL #0
    MOVK  X6, #0xd44e, LSL #16
    MOVK  X6, #0xe0fc, LSL #32
    MOVK  X6, #0x6742, LSL #48
    SUB  X19, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0xdcb7, LSL #0
    MOVK  X6, #0xd897, LSL #16
    MOVK  X6, #0x8d00, LSL #32
    MOVK  X6, #0xace9, LSL #48
    SUB  X19, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x1b24, LSL #0
    MOVK  X6, #0xbf03, LSL #16
    MOVK  X6, #0x2eb4, LSL #32
    MOVK  X6, #0x6e9c, LSL #48
    SUB  X19, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x234a, LSL #0
    MOVK  X6, #0xdcab, LSL #16
    MOVK  X6, #0x942b, LSL #32
    MOVK  X6, #0xe967, LSL #48
    SUB  X19, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x3b55, LSL #0
    MOVK  X6, #0x4cdf, LSL #16
    MOVK  X6, #0x464, LSL #32
    MOVK  X6, #0x3a64, LSL #48
    SUB  X19, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0xd79, LSL #0
    MOVK  X6, #0x62e3, LSL #16
    MOVK  X6, #0x4f10, LSL #32
    MOVK  X6, #0x5fa9, LSL #48
    SUB  X19, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x8460, LSL #0
    MOVK  X6, #0xa9a, LSL #16
    MOVK  X6, #0xef0b, LSL #32
    MOVK  X6, #0x8fb0, LSL #48
    SUB  X19, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x59b, LSL #0
    MOVK  X6, #0x313e, LSL #16
    MOVK  X6, #0xd473, LSL #32
    MOVK  X6, #0x73cd, LSL #48
    SUB  X19, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0xa8b4, LSL #0
    MOVK  X6, #0x817a, LSL #16
    MOVK  X6, #0xef15, LSL #32
    MOVK  X6, #0xab04, LSL #48
    SUB  X19, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x860, LSL #0
    MOVK  X6, #0x8704, LSL #16
    MOVK  X6, #0x1fa9, LSL #32
    MOVK  X6, #0x19a7, LSL #48
    SUB  X19, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0xa243, LSL #0
    MOVK  X6, #0xbe8d, LSL #16
    MOVK  X6, #0xbce1, LSL #32
    MOVK  X6, #0xbee5, LSL #48
    SUB  X19, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x8009, LSL #0
    MOVK  X6, #0x8069, LSL #16
    MOVK  X6, #0x1be8, LSL #32
    MOVK  X6, #0x71f9, LSL #48
    SUB  X19, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x5984, LSL #0
    MOVK  X6, #0xa4a7, LSL #16
    MOVK  X6, #0x8423, LSL #32
    MOVK  X6, #0x3660, LSL #48
    SUB  X19, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x2529, LSL #0
    MOVK  X6, #0x96be, LSL #16
    MOVK  X6, #0x360, LSL #32
    MOVK  X6, #0x5b36, LSL #48
    SUB  X19, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0xd165, LSL #0
    MOVK  X6, #0x3a38, LSL #16
    MOVK  X6, #0xe189, LSL #32
    MOVK  X6, #0x2a84, LSL #48
    SUB  X19, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0xc229, LSL #0
    MOVK  X6, #0x72f, LSL #16
    MOVK  X6, #0xeda2, LSL #32
    MOVK  X6, #0xc8c3, LSL #48
    SUB  X19, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x8533, LSL #0
    MOVK  X6, #0xb89d, LSL #16
    MOVK  X6, #0xce86, LSL #32
    MOVK  X6, #0x9679, LSL #48
    SUB  X19, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x5746, LSL #0
    MOVK  X6, #0xa514, LSL #16
    MOVK  X6, #0x628a, LSL #32
    MOVK  X6, #0xc64, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X6, #0x8344, LSL #0
    MOVK  X6, #0xfc68, LSL #16
    MOVK  X6, #0x49ff, LSL #32
    MOVK  X6, #0x2852, LSL #48
    SUB  X19, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X6, FPSR
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x800, LSL #16
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X19, #0x5984, LSL #0
    MOVK  X19, #0xa4a7, LSL #16
    MOVK  X19, #0x8423, LSL #32
    MOVK  X19, #0x3660, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D0
    MOVZ  X19, #0x8009, LSL #0
    MOVK  X19, #0x8069, LSL #16
    MOVK  X19, #0x1be8, LSL #32
    MOVK  X19, #0x71f9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X19, #0x5746, LSL #0
    MOVK  X19, #0xa514, LSL #16
    MOVK  X19, #0x628a, LSL #32
    MOVK  X19, #0xc64, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D1
    MOVZ  X19, #0x8009, LSL #0
    MOVK  X19, #0x8069, LSL #16
    MOVK  X19, #0x1be8, LSL #32
    MOVK  X19, #0x71f9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X19, #0x1be8, LSL #0
    MOVK  X19, #0x71f9, LSL #32
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D2
    MOVZ  X19, #0x8009, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x8069, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X19, #0x71f9, LSL #0
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D3
    MOVZ  X19, #0x1be8, LSL #0
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X19, #0xb96c, LSL #0
    MOVK  X19, #0x58c1, LSL #16
    MOVK  X19, #0xac4f, LSL #32
    MOVK  X19, #0xb501, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D4
    MOVZ  X19, #0xdcb7, LSL #0
    MOVK  X19, #0xd897, LSL #16
    MOVK  X19, #0x8d00, LSL #32
    MOVK  X19, #0xace9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X19, #0x73, LSL #0
    MOVK  X19, #0xffd4, LSL #16
    MOVK  X19, #0xffcd, LSL #32
    MOVK  X19, #0x73, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D5
    MOVZ  X19, #0xff9b, LSL #0
    MOVK  X19, #0x5, LSL #16
    MOVK  X19, #0x3e, LSL #32
    MOVK  X19, #0x31, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X19, #0x3a, LSL #0
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D6
    MOVZ  X19, #0x64, LSL #0
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X19, #0x5746, LSL #0
    MOVK  X19, #0xa514, LSL #16
    MOVK  X19, #0x628a, LSL #32
    MOVK  X19, #0xc64, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D7
    MOVZ  X19, #0x59b, LSL #0
    MOVK  X19, #0x313e, LSL #16
    MOVK  X19, #0xd473, LSL #32
    MOVK  X19, #0x73cd, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X19, #0x721e, LSL #0
    MOVK  X19, #0xa0a3, LSL #16
    MOVK  X19, #0x1471, LSL #32
    MOVK  X19, #0x97cf, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D8
    MOVZ  X19, #0x860, LSL #0
    MOVK  X19, #0x8704, LSL #16
    MOVK  X19, #0x1fa9, LSL #32
    MOVK  X19, #0x19a7, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X19, #0x5984, LSL #0
    MOVK  X19, #0xa4a7, LSL #16
    MOVK  X19, #0x8423, LSL #32
    MOVK  X19, #0x3660, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D9
    MOVZ  X19, #0x8460, LSL #0
    MOVK  X19, #0xa9a, LSL #16
    MOVK  X19, #0xef0b, LSL #32
    MOVK  X19, #0x8fb0, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X19, #0xffe9, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D10
    MOVZ  X19, #0x67, LSL #0
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X19, #0x1b24, LSL #0
    MOVK  X19, #0xbf03, LSL #16
    MOVK  X19, #0x2eb4, LSL #32
    MOVK  X19, #0x6e9c, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D11
    MOVZ  X19, #0x8009, LSL #0
    MOVK  X19, #0x8069, LSL #16
    MOVK  X19, #0x1be8, LSL #32
    MOVK  X19, #0x71f9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X19, #0x8460, LSL #0
    MOVK  X19, #0xa9a, LSL #16
    MOVK  X19, #0xef0b, LSL #32
    MOVK  X19, #0x8fb0, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D12
    MOVZ  X19, #0x5984, LSL #0
    MOVK  X19, #0xa4a7, LSL #16
    MOVK  X19, #0x8423, LSL #32
    MOVK  X19, #0x3660, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X19, #0x908f, LSL #0
    MOVK  X19, #0xb461, LSL #16
    MOVK  X19, #0x995c, LSL #32
    MOVK  X19, #0x81c7, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D13
    MOVZ  X19, #0x7667, LSL #0
    MOVK  X19, #0xa88f, LSL #16
    MOVK  X19, #0x3489, LSL #32
    MOVK  X19, #0x4f3f, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X19, #0xeda2, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xc8c3, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D14
    MOVZ  X19, #0xc229, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x72f, LSL #32
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X19, #0xef15, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xab04, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D15
    MOVZ  X19, #0xa8b4, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x817a, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X19, #0x71, LSL #0
    MOVK  X19, #0x14, LSL #16
    MOVK  X19, #0xffcf, LSL #32
    MOVK  X19, #0xff97, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D16
    MOVZ  X19, #0x1e, LSL #0
    MOVK  X19, #0x72, LSL #16
    MOVK  X19, #0xffa3, LSL #32
    MOVK  X19, #0xffa0, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X19, #0xdcb7, LSL #0
    MOVK  X19, #0xd897, LSL #16
    MOVK  X19, #0x8d00, LSL #32
    MOVK  X19, #0xace9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D17
    MOVZ  X19, #0x7667, LSL #0
    MOVK  X19, #0xa88f, LSL #16
    MOVK  X19, #0x3489, LSL #32
    MOVK  X19, #0x4f3f, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X19, #0xd79, LSL #0
    MOVK  X19, #0x62e3, LSL #16
    MOVK  X19, #0x4f10, LSL #32
    MOVK  X19, #0x5fa9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D18
    MOVZ  X19, #0xdcb7, LSL #0
    MOVK  X19, #0xd897, LSL #16
    MOVK  X19, #0x8d00, LSL #32
    MOVK  X19, #0xace9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X19, #0x1be8, LSL #0
    MOVK  X19, #0x71f9, LSL #32
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D19
    MOVZ  X19, #0x8009, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x8069, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X19, #0x59b, LSL #0
    MOVK  X19, #0x313e, LSL #16
    MOVK  X19, #0xd473, LSL #32
    MOVK  X19, #0x73cd, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D20
    MOVZ  X19, #0x8344, LSL #0
    MOVK  X19, #0xfc68, LSL #16
    MOVK  X19, #0x49ff, LSL #32
    MOVK  X19, #0x2852, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X19, #0x8344, LSL #0
    MOVK  X19, #0xfc68, LSL #16
    MOVK  X19, #0x49ff, LSL #32
    MOVK  X19, #0x2852, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D21
    MOVZ  X19, #0xa8b4, LSL #0
    MOVK  X19, #0x817a, LSL #16
    MOVK  X19, #0xef15, LSL #32
    MOVK  X19, #0xab04, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X19, #0x7667, LSL #0
    MOVK  X19, #0xa88f, LSL #16
    MOVK  X19, #0x3489, LSL #32
    MOVK  X19, #0x4f3f, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D22
    MOVZ  X19, #0xb96c, LSL #0
    MOVK  X19, #0x58c1, LSL #16
    MOVK  X19, #0xac4f, LSL #32
    MOVK  X19, #0xb501, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X19, #0x64, LSL #0
    MOVK  X19, #0x4, LSL #16
    MOVK  X19, #0x64, LSL #32
    MOVK  X19, #0x3a, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D23
    MOVZ  X19, #0x55, LSL #0
    MOVK  X19, #0x3b, LSL #16
    MOVK  X19, #0xffdf, LSL #32
    MOVK  X19, #0x4c, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X19, #0x721e, LSL #0
    MOVK  X19, #0xa0a3, LSL #16
    MOVK  X19, #0x1471, LSL #32
    MOVK  X19, #0x97cf, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D24
    MOVZ  X19, #0x1b24, LSL #0
    MOVK  X19, #0xbf03, LSL #16
    MOVK  X19, #0x2eb4, LSL #32
    MOVK  X19, #0x6e9c, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X19, #0xffcd, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x73, LSL #32
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D25
    MOVZ  X19, #0x73, LSL #0
    MOVK  X19, #0xffd4, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X19, #0xa02f, LSL #0
    MOVK  X19, #0xd44e, LSL #16
    MOVK  X19, #0xe0fc, LSL #32
    MOVK  X19, #0x6742, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D26
    MOVZ  X19, #0xa02f, LSL #0
    MOVK  X19, #0xd44e, LSL #16
    MOVK  X19, #0xe0fc, LSL #32
    MOVK  X19, #0x6742, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X19, #0x71f9, LSL #0
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D27
    MOVZ  X19, #0x1be8, LSL #0
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X19, #0xfffc, LSL #0
    MOVK  X19, #0xffe0, LSL #16
    MOVK  X19, #0x42, LSL #32
    MOVK  X19, #0x67, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D28
    MOVZ  X19, #0x2f, LSL #0
    MOVK  X19, #0xffa0, LSL #16
    MOVK  X19, #0x4e, LSL #32
    MOVK  X19, #0xffd4, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X19, #0xeda2, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xc8c3, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D29
    MOVZ  X19, #0xc229, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x72f, LSL #32
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X19, #0x8009, LSL #0
    MOVK  X19, #0x8069, LSL #16
    MOVK  X19, #0x1be8, LSL #32
    MOVK  X19, #0x71f9, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D30
    MOVZ  X19, #0x7667, LSL #0
    MOVK  X19, #0xa88f, LSL #16
    MOVK  X19, #0x3489, LSL #32
    MOVK  X19, #0x4f3f, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X19, #0xc229, LSL #0
    MOVK  X19, #0x72f, LSL #16
    MOVK  X19, #0xeda2, LSL #32
    MOVK  X19, #0xc8c3, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X6, D31
    MOVZ  X19, #0x234a, LSL #0
    MOVK  X19, #0xdcab, LSL #16
    MOVK  X19, #0x942b, LSL #32
    MOVK  X19, #0xe967, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x8644, LSL #0
    MOVK  X2, #0x33ae, LSL #16
    MOVK  X2, #0x32ec, LSL #32
    MOVK  X2, #0xab2e, LSL #48
    MOVZ  X3, #0x5d39, LSL #0
    MOVK  X3, #0x78d7, LSL #16
    MOVK  X3, #0xc81d, LSL #32
    MOVK  X3, #0x9de2, LSL #48
    MOVZ  X4, #0xad45, LSL #0
    MOVK  X4, #0x3df4, LSL #16
    MOVK  X4, #0x75f5, LSL #32
    MOVK  X4, #0x2571, LSL #48
    MOVZ  X5, #0x49e6, LSL #0
    MOVK  X5, #0xe4b9, LSL #16
    MOVK  X5, #0x3d3f, LSL #32
    MOVK  X5, #0x80b2, LSL #48
    MOVZ  X6, #0xd0f9, LSL #0
    MOVK  X6, #0xb090, LSL #16
    MOVK  X6, #0x9f0e, LSL #32
    MOVK  X6, #0xc2c, LSL #48
    MOVZ  X7, #0x16cf, LSL #0
    MOVK  X7, #0xceee, LSL #16
    MOVK  X7, #0x62cb, LSL #32
    MOVK  X7, #0x7946, LSL #48
    MOVZ  X8, #0x8567, LSL #0
    MOVK  X8, #0xa95a, LSL #16
    MOVK  X8, #0x9d50, LSL #32
    MOVK  X8, #0x2900, LSL #48
    MOVZ  X9, #0x1ce2, LSL #0
    MOVK  X9, #0x7663, LSL #16
    MOVK  X9, #0x2ebd, LSL #32
    MOVK  X9, #0xe3cc, LSL #48
    MOVZ  X10, #0x94cd, LSL #0
    MOVK  X10, #0x1b7, LSL #16
    MOVK  X10, #0xc7c1, LSL #32
    MOVK  X10, #0xb9a2, LSL #48
    MOVZ  X16, #0x5607, LSL #0
    MOVK  X16, #0x9cee, LSL #16
    MOVK  X16, #0xd7a1, LSL #32
    MOVK  X16, #0xd3ab, LSL #48
    MOVZ  X17, #0x56e8, LSL #0
    MOVK  X17, #0x63e2, LSL #16
    MOVK  X17, #0x626c, LSL #32
    MOVK  X17, #0x5bd8, LSL #48
    MOVZ  X18, #0x28dd, LSL #0
    MOVK  X18, #0xe7d4, LSL #16
    MOVK  X18, #0xb23, LSL #32
    MOVK  X18, #0xd0cc, LSL #48
    MOVZ  X19, #0xa1f1, LSL #0
    MOVK  X19, #0xd8e8, LSL #16
    MOVK  X19, #0x7cea, LSL #32
    MOVK  X19, #0x3b8b, LSL #48
    MOVZ  X20, #0x8f98, LSL #0
    MOVK  X20, #0x8582, LSL #16
    MOVK  X20, #0x587f, LSL #32
    MOVK  X20, #0x521d, LSL #48
    MOVZ  X21, #0xbead, LSL #0
    MOVK  X21, #0x3f8a, LSL #16
    MOVK  X21, #0x318c, LSL #32
    MOVK  X21, #0x515e, LSL #48
    MOVZ  X22, #0xb1d5, LSL #0
    MOVK  X22, #0x8e33, LSL #16
    MOVK  X22, #0x8499, LSL #32
    MOVK  X22, #0x70b, LSL #48
    MOVZ  X23, #0x965c, LSL #0
    MOVK  X23, #0x409c, LSL #16
    MOVK  X23, #0x85d8, LSL #32
    MOVK  X23, #0x3ce6, LSL #48
    MOVZ  X24, #0x103e, LSL #0
    MOVK  X24, #0xdff5, LSL #16
    MOVK  X24, #0x6c, LSL #32
    MOVK  X24, #0xd4a, LSL #48
    MOVZ  X25, #0x93af, LSL #0
    MOVK  X25, #0x3885, LSL #16
    MOVK  X25, #0x6e6f, LSL #32
    MOVK  X25, #0xee55, LSL #48
    MOVZ  X26, #0xd890, LSL #0
    MOVK  X26, #0xac78, LSL #16
    MOVK  X26, #0xf2f1, LSL #32
    MOVK  X26, #0xfc5, LSL #48
    MOVZ  X27, #0xb190, LSL #0
    MOVK  X27, #0xefa3, LSL #16
    MOVK  X27, #0x3990, LSL #32
    MOVK  X27, #0xa972, LSL #48
    MOVZ  X28, #0xc69b, LSL #0
    MOVK  X28, #0x52f5, LSL #16
    MOVK  X28, #0xad5b, LSL #32
    MOVK  X28, #0xa14c, LSL #48
    MOVZ  X29, #0x13ca, LSL #0
    MOVK  X29, #0xf45b, LSL #16
    MOVK  X29, #0x2b27, LSL #32
    MOVK  X29, #0xd7a8, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X2
    FMOV  V2.D[1], X27
    FMOV  D3, X26
    FMOV  V3.D[1], X23
    FMOV  D4, X16
    FMOV  V4.D[1], X16
    FMOV  D5, X20
    FMOV  V5.D[1], X20
    FMOV  D6, X7
    FMOV  V6.D[1], X4
    FMOV  D7, X3
    FMOV  V7.D[1], X21
    FMOV  D8, X27
    FMOV  V8.D[1], X3
    FMOV  D9, X4
    FMOV  V9.D[1], X17
    FMOV  D10, X17
    FMOV  V10.D[1], X18
    FMOV  D11, X3
    FMOV  V11.D[1], X19
    FMOV  D12, X6
    FMOV  V12.D[1], X26
    FMOV  D13, X27
    FMOV  V13.D[1], X20
    FMOV  D14, X19
    FMOV  V14.D[1], X8
    FMOV  D15, X3
    FMOV  V15.D[1], X8
    FMOV  D16, X3
    FMOV  V16.D[1], X21
    FMOV  D17, X16
    FMOV  V17.D[1], X3
    FMOV  D18, X7
    FMOV  V18.D[1], X19
    FMOV  D19, X29
    FMOV  V19.D[1], X27
    FMOV  D20, X23
    FMOV  V20.D[1], X8
    FMOV  D21, X29
    FMOV  V21.D[1], X27
    FMOV  D22, X4
    FMOV  V22.D[1], X21
    FMOV  D23, X22
    FMOV  V23.D[1], X25
    FMOV  D24, X29
    FMOV  V24.D[1], X29
    FMOV  D25, X25
    FMOV  V25.D[1], X29
    FMOV  D26, X3
    FMOV  V26.D[1], X24
    FMOV  D27, X4
    FMOV  V27.D[1], X23
    FMOV  D28, X24
    FMOV  V28.D[1], X9
    FMOV  D29, X20
    FMOV  V29.D[1], X3
    FMOV  D30, X27
    FMOV  V30.D[1], X6
    FMOV  D31, X6
    FMOV  V31.D[1], X9
    MOVZ  X16, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_0:
    SQRSHL  V26.2D, V25.2D, V27.2D
    SADDW  V29.8H, V29.8H, V23.8B
    SSRA  V20.2S, V31.2S, #11
    SSHLL2 V8.4S, V29.8H, #0xf
    SQXTN  V30.4H, V24.4S
    SQDMLSL S18, H20, V10.H[0x4]
    SRSRA V17.2D, V30.2D, #1
    SSHLL2 V25.8H, V26.16B, #0x7
    SMULL V25.2D, V19.2S, V27.S[0x0]
    SADDW2  V18.4S, V8.4S, V28.8H
    SQDMULH  V9.4S, V18.4S, V30.S[0x3]
    SQDMLAL2  V20.4S, V25.8H, V9.8H
    SQSHL V31.2D, V20.2D, #0x3f
    SQSHRN V12.8B, V17.8H, #4
    SMLAL V26.4S, V13.4H, V14.H[0x4]
    SQSHRUN V28.4H, V9.4S, #4
    SQABS  V28.2S, V11.2S
    SQSHL  V23.2D, V5.2D, V23.2D
    SQDMLSL V29.4S, V18.4H, V0.H[0x4]
    SRSRA  V20.4H, V29.4H, #11
    SQNEG  V11.8H, V31.8H
    SQRSHRN V23.2S, V12.2D, #6
    SQDMLAL D13, S29, V24.S[0x2]
    SQSHRUN V26.2S, V19.2D, #16
    SQDMLSL2 V10.2D, V20.4S, V0.S[0x0]
    SQRSHRN V14.4H, V22.4S, #11
    SMULL2  V25.2D, V5.4S, V0.4S
    SSHLL V0.4S, V21.4H, #0x9
    SRSRA  V28.4H, V25.4H, #6
    SQNEG  V25.2D, V16.2D
    SMLSL  V18.8H, V0.8B, V28.8B
    SQRSHRUN2 V16.4S, V10.2D, #26
    SMOV W10, V13.H[0x6]
    SQSHLU  V5.16B, V18.16B, #0x5
    SRSRA  V30.4S, V23.4S, #19
    SADDW  V27.2D, V30.2D, V25.2S
    SQSHRUN2 V25.4S, V1.2D, #1
    SMLAL V12.2D, V5.2S, V25.S[0x2]
    SQSHRN2 V24.8H, V26.4S, #1
    SMLSL2  V20.2D, V27.4S, V8.4S
    SSUBL2  V17.4S, V12.8H, V24.8H
    SQSHLU  V1.4S, V20.4S, #0x3
    SQDMULL  V21.4S, V16.4H, V14.4H
    SXTL2 V31.2D, V8.4S
    SQRDMULH  V16.4H, V31.4H, V6.4H
    SMULL2  V5.2D, V21.4S, V21.4S
    SQDMULL V8.2D, V5.2S, V5.S[0x0]
    SADDLV  D24, V16.4S
    SMOV W8, V8.H[0x7]
    SQSHL  V8.4H, V1.4H, #0xa
    SQXTN  V12.2S, V27.2D
    SQXTN2  V30.4S, V17.2D
    SABAL  V14.8H, V12.8B, V13.8B
    SRSRA  V31.2S, V30.2S, #12
    SQDMULL2 V13.2D, V24.4S, V23.S[0x3]
    SQDMLSL2  V6.2D, V13.4S, V18.4S
    SQDMULL D27, S14, V14.S[0x1]
    SADDL2  V30.2D, V8.4S, V5.4S
    SSRA  V17.4S, V6.4S, #7
    SQRSHRUN2 V23.8H, V17.4S, #3
    SSUBW2  V12.4S, V30.4S, V31.8H
    SHADD  V23.4H, V14.4H, V29.4H
    SSHLL V13.8H, V12.8B, #0x4
    SQSHL V31.2D, V23.2D, #0x32
    SQRDMULH H29, H25, V13.H[0x4]
    SRSRA  V1.8B, V28.8B, #3
    SQRDMULH  V18.4S, V22.4S, V27.4S
    SQSHLU  V27.8B, V31.8B, #0x6
    SRSHR  V17.8B, V25.8B, #1
    SQRDMULH  V14.4H, V18.4H, V5.H[0x1]
    SQRSHRN V25.8B, V18.8H, #5
    SADDL  V13.8H, V20.8B, V24.8B
    SADDLV  H22, V18.16B
    SMULL V31.4S, V13.4H, V6.H[0x1]
    SMOV W25, V30.B[0x9]
    SQDMLAL2 V13.2D, V27.4S, V29.S[0x1]
    SQRDMULH  V8.8H, V31.8H, V14.H[0x6]
    SRSRA  V23.8B, V25.8B, #1
    SMOV  X27, V16.S[0x3]
    SQDMLSL2 V25.4S, V31.8H, V5.H[0x1]
    SSHLL2 V25.4S, V2.8H, #0xf
    SMLSL2  V5.2D, V29.4S, V17.4S
    SQDMULL D6, S23, V8.S[0x3]
    SABDL  V12.2D, V6.2S, V1.2S
    SMLSL2 V20.4S, V25.8H, V13.H[0x3]
    SQSHRUN V14.2S, V12.2D, #5
    SMLSL2 V18.2D, V21.4S, V21.S[0x1]
    SADDW2  V21.8H, V7.8H, V5.16B
    SMOV W25, V21.H[0x0]
    SMLAL V7.4S, V7.4H, V14.H[0x1]
    SQSHRUN2 V27.8H, V22.4S, #13
    SABAL2  V2.8H, V20.16B, V4.16B
    SRSHR V12.2D, V7.2D, #7
    SQDMLSL2  V16.4S, V13.8H, V27.8H
    SQXTN  V14.2S, V29.2D
    SQRSHRUN V2.8B, V18.8H, #2
    SQXTUN2  V22.16B, V16.8H
    SQRSHRUN V7.4H, V2.4S, #14
    SADDW2  V8.8H, V19.8H, V7.16B
    SQSHLU V4.2D, V14.2D, #0xa
    SQSHRUN V18.8B, V4.8H, #6
    SQADD  V31.8B, V8.8B, V8.8B
    SQDMULH  V18.4H, V1.4H, V12.H[0x0]
    SMOV  X24, V24.S[0x0]
    SQXTN2  V21.8H, V22.4S
    SQXTUN  V24.4H, V1.4S
    SABD  V22.2S, V28.2S, V18.2S
    SQXTN2  V29.4S, V2.2D
    SMLSL2 V12.2D, V21.4S, V22.S[0x1]
    SQRSHRUN V14.4H, V29.4S, #12
    SMOV  X4, V1.H[0x7]
    SQSHL  V15.8B, V14.8B, #0x0
    SMULL  V29.8H, V2.8B, V12.8B
    SSUBL2  V4.8H, V15.16B, V15.16B
    SMOV  X9, V24.S[0x2]
    SSHLL2 V15.8H, V4.16B, #0x3
    SMLSL V18.2D, V31.2S, V6.S[0x2]
    SQDMULL2  V22.4S, V28.8H, V10.8H
    SMLSL2  V10.8H, V23.16B, V15.16B
    SQDMULL D1, S18, V22.S[0x2]
    SQDMLAL S22, H10, V10.H[0x3]
    SUQADD  V18.16B, V1.16B
    SQSHLU  V4.8H, V18.8H, #0x3
    SQXTN  V1.8B, V14.8H
    SABDL  V8.8H, V4.8B, V9.8B
    SHSUB  V0.4S, V6.4S, V22.4S
    SSHLL V26.4S, V0.4H, #0xd
    SQRSHL  V18.4H, V9.4H, V29.4H
    SMLSL2 V6.2D, V2.4S, V26.S[0x3]
    SMLSL V23.2D, V1.2S, V6.S[0x1]
    SQNEG  V9.8H, V12.8H
    SADDLV  H14, V23.16B
    SSRA  V26.2S, V8.2S, #19
    SSRA V29.2D, V9.2D, #23
    SQRSHRUN2 V10.4S, V18.2D, #11
    SRHADD  V3.2S, V23.2S, V13.2S
    SQXTUN2  V22.4S, V29.2D
    SQRDMULH S18, S23, V27.S[0x1]
    SQSHRUN2 V29.16B, V9.8H, #6
    SMLSL V9.2D, V9.2S, V3.S[0x3]
    SQNEG  V25.16B, V14.16B
    SQDMLSL2  V4.4S, V10.8H, V28.8H
    SQDMLSL V8.4S, V18.4H, V9.H[0x7]
    SQDMLAL S3, H22, V8.H[0x0]
    SQDMLSL2  V30.4S, V26.8H, V23.8H
    SQDMLSL S12, H3, V0.H[0x6]
    SQXTN2  V28.4S, V30.2D
    SADDLV  H30, V12.8B
    SQSHRN2 V23.4S, V25.2D, #8
    SMOV  X18, V4.B[0xa]
    SQRDMULH H26, H30, V1.H[0x6]
    SABDL  V10.2D, V28.2S, V26.2S
    SMULL V6.4S, V29.4H, V10.H[0x5]
    SMLAL2 V8.2D, V21.4S, V11.S[0x3]
    SABA  V11.2S, V0.2S, V3.2S
    SMLAL V27.2D, V29.2S, V23.S[0x2]
    SMLSL V4.4S, V1.4H, V9.H[0x7]
    SSUBW2  V26.2D, V0.2D, V7.4S
    SMLSL  V9.8H, V25.8B, V22.8B
    SQRDMULH  V23.2S, V11.2S, V3.S[0x1]
    SXTL2 V6.8H, V13.16B
    SSHLL2 V18.4S, V12.8H, #0xd
    SQSHLU  V29.4H, V22.4H, #0xf
    SSRA  V3.8H, V8.8H, #15
    SQRSHL  V10.4H, V6.4H, V23.4H
    SQDMULL V8.2D, V27.2S, V4.S[0x0]
    SQDMULL2  V17.4S, V26.8H, V18.8H
    SQDMLAL V18.2D, V17.2S, V17.S[0x1]
    SADDL2  V22.4S, V18.8H, V8.8H
    SQDMLAL V1.2D, V31.2S, V19.S[0x0]
    SMLSL V11.2D, V10.2S, V16.S[0x2]
    SSRA  V23.16B, V1.16B, #4
    SQADD  V4.16B, V22.16B, V9.16B
    SABDL  V18.4S, V11.4H, V23.4H
    SSHLL2 V9.8H, V19.16B, #0x5
    SMOV W24, V26.H[0x1]
    SMOV  X25, V9.S[0x2]
    SSRA  V22.16B, V29.16B, #7
    SQDMULH H23, H18, V0.H[0x1]
    SADDLV  H27, V22.8B
    SQDMULH  V1.8H, V8.8H, V3.H[0x1]
    SQSHL V8.2D, V1.2D, #0x35
    SQSHRUN2 V11.16B, V2.8H, #5
    SSUBW  V9.4S, V7.4S, V8.4H
    SSUBL2  V0.4S, V4.8H, V30.8H
    SMLAL2 V18.2D, V0.4S, V11.S[0x3]
    SABD  V17.4S, V18.4S, V25.4S
    SQRSHRN2 V13.4S, V17.2D, #11
    SQDMULL V0.4S, V9.4H, V15.H[0x6]
    SQSHLU  V10.4S, V13.4S, #0x1f
    SQDMLSL S18, H0, V5.H[0x2]
    SQSHRN2 V4.16B, V23.8H, #4
    SQDMLSL D23, S16, V18.S[0x1]
    SABAL2  V26.2D, V27.4S, V4.4S
    SQRDMULH  V30.8H, V10.8H, V23.8H
    SQADD  V1.16B, V22.16B, V28.16B
    SRSRA  V13.4H, V29.4H, #14
    SQDMULH H27, H19, V12.H[0x3]
    SSUBL2  V8.4S, V17.8H, V14.8H
    SMLAL2  V15.2D, V13.4S, V18.4S
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_0
    MOVZ  X26, #0x8644, LSL #0
    MOVK  X26, #0x33ae, LSL #16
    MOVK  X26, #0x32ec, LSL #32
    MOVK  X26, #0xab2e, LSL #48
    SUB  X23, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5d39, LSL #0
    MOVK  X26, #0x78d7, LSL #16
    MOVK  X26, #0xc81d, LSL #32
    MOVK  X26, #0x9de2, LSL #48
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x49e6, LSL #0
    MOVK  X26, #0xe4b9, LSL #16
    MOVK  X26, #0x3d3f, LSL #32
    MOVK  X26, #0x80b2, LSL #48
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xd0f9, LSL #0
    MOVK  X26, #0xb090, LSL #16
    MOVK  X26, #0x9f0e, LSL #32
    MOVK  X26, #0xc2c, LSL #48
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x16cf, LSL #0
    MOVK  X26, #0xceee, LSL #16
    MOVK  X26, #0x62cb, LSL #32
    MOVK  X26, #0x7946, LSL #48
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x56e8, LSL #0
    MOVK  X26, #0x63e2, LSL #16
    MOVK  X26, #0x626c, LSL #32
    MOVK  X26, #0x5bd8, LSL #48
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xa1f1, LSL #0
    MOVK  X26, #0xd8e8, LSL #16
    MOVK  X26, #0x7cea, LSL #32
    MOVK  X26, #0x3b8b, LSL #48
    SUB  X23, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x8f98, LSL #0
    MOVK  X26, #0x8582, LSL #16
    MOVK  X26, #0x587f, LSL #32
    MOVK  X26, #0x521d, LSL #48
    SUB  X23, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xbead, LSL #0
    MOVK  X26, #0x3f8a, LSL #16
    MOVK  X26, #0x318c, LSL #32
    MOVK  X26, #0x515e, LSL #48
    SUB  X23, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xb1d5, LSL #0
    MOVK  X26, #0x8e33, LSL #16
    MOVK  X26, #0x8499, LSL #32
    MOVK  X26, #0x70b, LSL #48
    SUB  X23, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xf200, LSL #0
    MOVK  X26, #0x720, LSL #16
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x13ca, LSL #0
    MOVK  X26, #0xf45b, LSL #16
    MOVK  X26, #0x2b27, LSL #32
    MOVK  X26, #0xd7a8, LSL #48
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x800, LSL #16
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D0
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D1
    MOVZ  X23, #0xffdc, LSL #0
    MOVK  X23, #0x18, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7ffe, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D3
    MOVZ  X23, #0x8054, LSL #0
    MOVK  X23, #0x1f, LSL #16
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X23, #0x59, LSL #0
    MOVK  X23, #0x47, LSL #32
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D6
    MOVZ  X23, #0xff83, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0x3b, LSL #32
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X23, #0x8001, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D8
    MOVZ  X23, #0x501, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D9
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D10
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D11
    MOVZ  X23, #0x8055, LSL #0
    MOVK  X23, #0x20, LSL #16
    MOVK  X23, #0x1, LSL #32
    MOVK  X23, #0x8001, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D13
    MOVZ  X23, #0x6b, LSL #0
    MOVK  X23, #0x37, LSL #16
    MOVK  X23, #0xffc4, LSL #32
    MOVK  X23, #0xff9a, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D14
    MOVZ  X23, #0x57, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X23, #0x501, LSL #0
    MOVK  X23, #0x8001, LSL #32
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D17
    MOVZ  X23, #0x7cfb, LSL #0
    MOVK  X23, #0x5d9, LSL #32
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D18
    MOVZ  X23, #0x7da4, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X23, #0xb190, LSL #0
    MOVK  X23, #0xefa3, LSL #16
    MOVK  X23, #0x3990, LSL #32
    MOVK  X23, #0xa972, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D19
    MOVZ  X23, #0x13ca, LSL #0
    MOVK  X23, #0xf45b, LSL #16
    MOVK  X23, #0x2b27, LSL #32
    MOVK  X23, #0xd7a8, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D20
    MOVZ  X23, #0x376b, LSL #0
    MOVK  X23, #0x9ac4, LSL #16
    MOVK  X23, #0x3b83, LSL #32
    MOVK  X23, #0x4759, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D23
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D24
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D25
    MOVZ  X23, #0xa9, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D28
    MOVZ  X23, #0xffdc, LSL #0
    MOVK  X23, #0x18, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7ffe, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D30
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D31
    MOVZ  X23, #0x2694, LSL #0
    MOVK  X23, #0xe87f, LSL #16
    MOVK  X23, #0x564e, LSL #32
    MOVK  X23, #0xae80, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X5
    FMOV  V0.D[1], X3
    FMOV  D1, X29
    FMOV  V1.D[1], X24
    FMOV  D2, X22
    FMOV  V2.D[1], X26
    FMOV  D3, X18
    FMOV  V3.D[1], X25
    FMOV  D4, X27
    FMOV  V4.D[1], X28
    FMOV  D5, X21
    FMOV  V5.D[1], X23
    FMOV  D6, X20
    FMOV  V6.D[1], X18
    FMOV  D7, X10
    FMOV  V7.D[1], X3
    FMOV  D8, X7
    FMOV  V8.D[1], X19
    FMOV  D9, X18
    FMOV  V9.D[1], X5
    FMOV  D10, X27
    FMOV  V10.D[1], X20
    FMOV  D11, X27
    FMOV  V11.D[1], X26
    FMOV  D12, X7
    FMOV  V12.D[1], X26
    FMOV  D13, X8
    FMOV  V13.D[1], X4
    FMOV  D14, X24
    FMOV  V14.D[1], X9
    FMOV  D15, X18
    FMOV  V15.D[1], X10
    FMOV  D16, X18
    FMOV  V16.D[1], X28
    FMOV  D17, X10
    FMOV  V17.D[1], X6
    FMOV  D18, X5
    FMOV  V18.D[1], X8
    FMOV  D19, X19
    FMOV  V19.D[1], X9
    FMOV  D20, X4
    FMOV  V20.D[1], X25
    FMOV  D21, X24
    FMOV  V21.D[1], X16
    FMOV  D22, X7
    FMOV  V22.D[1], X4
    FMOV  D23, X17
    FMOV  V23.D[1], X21
    FMOV  D24, X20
    FMOV  V24.D[1], X17
    FMOV  D25, X8
    FMOV  V25.D[1], X7
    FMOV  D26, X27
    FMOV  V26.D[1], X25
    FMOV  D27, X10
    FMOV  V27.D[1], X28
    FMOV  D28, X9
    FMOV  V28.D[1], X4
    FMOV  D29, X26
    FMOV  V29.D[1], X10
    FMOV  D30, X26
    FMOV  V30.D[1], X20
    FMOV  D31, X26
    FMOV  V31.D[1], X19
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_1:
    SMLSL2 V9.2D, V2.4S, V31.S[0x1]
    SQRSHRUN V7.8B, V27.8H, #1
    SQDMLAL D16, S7, V19.S[0x1]
    SSUBW2  V5.4S, V24.4S, V23.8H
    SABDL2  V2.8H, V30.16B, V9.16B
    SMLSL V12.2D, V5.2S, V6.S[0x2]
    SRSHR V24.2D, V17.2D, #5
    SQDMLAL  V19.2D, V21.2S, V12.2S
    SQXTUN2  V21.4S, V31.2D
    SXTL V6.4S, V8.4H
    SQRDMULH  V25.2S, V2.2S, V8.S[0x3]
    SMOV W28, V0.B[0x9]
    SQDMULH  V3.4S, V16.4S, V19.4S
    SRSHR V16.2D, V8.2D, #31
    SMULL2 V0.4S, V6.8H, V3.H[0x2]
    SQRDMULH H9, H10, V14.H[0x5]
    SSUBL  V5.8H, V31.8B, V24.8B
    SXTL V10.2D, V16.2S
    SQRSHRN V7.8B, V25.8H, #3
    SSHLL2 V30.4S, V9.8H, #0x3
    SSHLL V16.8H, V13.8B, #0x3
    SQDMLAL D3, S30, V10.S[0x1]
    SQSHRN V17.8B, V3.8H, #3
    SQRSHRN2 V25.4S, V19.2D, #16
    SMULL V13.2D, V7.2S, V25.S[0x1]
    SXTL2 V13.8H, V22.16B
    SXTL V14.4S, V16.4H
    SQDMULL2 V2.4S, V14.8H, V11.H[0x6]
    SADDLV  S6, V21.4H
    SXTL V10.4S, V8.4H
    SSHR  V27.16B, V10.16B, #3
    SQSHLU V8.2D, V14.2D, #0x39
    SQSHRN2 V19.8H, V28.4S, #14
    SMLAL V31.4S, V6.4H, V5.H[0x0]
    SSRA  V19.4H, V17.4H, #15
    SQDMULL2  V10.2D, V2.4S, V27.4S
    SMULL  V23.8H, V31.8B, V19.8B
    SQDMULH H6, H10, V8.H[0x2]
    SSUBW  V7.8H, V12.8H, V0.8B
    SHADD  V30.8H, V23.8H, V21.8H
    SQSHRN2 V11.4S, V5.2D, #24
    SQRSHRUN V25.4H, V11.4S, #9
    SADDLV  H8, V17.16B
    SQRSHRN2 V27.8H, V30.4S, #9
    SQRSHRN V10.4H, V19.4S, #5
    SMLSL2  V5.8H, V10.16B, V10.16B
    SQSHRN V31.2S, V5.2D, #8
    SMLAL  V20.4S, V30.4H, V1.4H
    SSRA  V11.8B, V13.8B, #8
    SXTL V12.2D, V22.2S
    SQDMULL S17, H7, V0.H[0x4]
    SRSHR  V7.16B, V25.16B, #7
    SADDLV  S6, V12.8H
    SQRSHRUN2 V18.16B, V6.8H, #3
    SADDW  V2.4S, V20.4S, V11.4H
    SQRSHRUN2 V28.4S, V17.2D, #32
    SMOV  X16, V27.S[0x0]
    SSHR  V14.4H, V8.4H, #9
    SSHLL2 V12.2D, V18.4S, #0x19
    SSHLL V8.2D, V14.2S, #0x1d
    SQRSHRUN2 V18.8H, V30.4S, #5
    SQSHLU  V20.2S, V5.2S, #0x10
    SQSHLU  V19.2S, V25.2S, #0x1d
    SQDMULL S11, H0, V7.H[0x5]
    SQRSHRN V23.2S, V8.2D, #15
    SQSHL  V0.4S, V22.4S, #0x0
    SSHLL2 V1.4S, V11.8H, #0x7
    SQRSHRN V30.4H, V0.4S, #11
    SSHR  V28.4S, V30.4S, #31
    SQDMLAL  V5.4S, V20.4H, V31.4H
    SQSHRN2 V0.4S, V0.2D, #21
    SQSHRN V20.2S, V28.2D, #10
    SQADD  V25.4H, V20.4H, V22.4H
    SSUBL2  V5.4S, V1.8H, V18.8H
    SQDMULL  V20.2D, V19.2S, V25.2S
    SABDL  V17.4S, V20.4H, V10.4H
    SSHLL2 V7.4S, V9.8H, #0x1
    SSRA  V9.8B, V25.8B, #6
    SSHLL2 V8.2D, V0.4S, #0x9
    SRHADD  V31.8B, V9.8B, V2.8B
    SMLSL2 V27.4S, V11.8H, V9.H[0x2]
    SMULL V30.2D, V21.2S, V12.S[0x1]
    SRSHR  V22.8B, V5.8B, #8
    SQDMLAL2 V9.2D, V17.4S, V21.S[0x0]
    SSHR  V10.8B, V27.8B, #5
    SQDMULL  V14.4S, V22.4H, V31.4H
    SADDLP  V31.1D, V11.2S
    SQDMLAL S1, H15, V14.H[0x2]
    SSRA  V30.16B, V23.16B, #7
    SMLAL V5.2D, V21.2S, V30.S[0x3]
    SMLSL  V20.4S, V13.4H, V9.4H
    SQDMULH  V15.2S, V20.2S, V7.S[0x1]
    SQDMLAL V19.2D, V31.2S, V5.S[0x0]
    SRSRA  V11.4H, V6.4H, #10
    SRSRA  V18.4H, V17.4H, #7
    SQSHRN2 V12.4S, V15.2D, #17
    SXTL2 V22.8H, V31.16B
    SQDMULL2  V17.2D, V12.4S, V6.4S
    SQDMULH S2, S22, V19.S[0x3]
    SMLSL2 V14.2D, V31.4S, V11.S[0x2]
    SMULL V19.4S, V17.4H, V10.H[0x7]
    SQRSHRUN2 V20.8H, V8.4S, #3
    SABAL2  V27.4S, V2.8H, V19.8H
    SQXTUN  V21.4H, V27.4S
    SMLAL2 V3.2D, V10.4S, V30.S[0x2]
    SQRSHRUN2 V15.8H, V5.4S, #3
    SMULL2  V19.2D, V1.4S, V18.4S
    SMOV  X17, V21.H[0x1]
    SADDW2  V2.8H, V15.8H, V14.16B
    SSHR  V27.2S, V8.2S, #14
    SMLAL  V18.4S, V19.4H, V27.4H
    SRSHL  V21.8H, V20.8H, V20.8H
    SMOV W20, V2.H[0x5]
    SQDMULL D28, S3, V3.S[0x3]
    SQADD  V6.4H, V29.4H, V28.4H
    SQDMLSL2 V7.4S, V21.8H, V0.H[0x6]
    SHSUB  V0.8B, V6.8B, V7.8B
    SQDMULH  V9.4H, V13.4H, V5.H[0x7]
    SQDMULL2  V12.4S, V15.8H, V28.8H
    SQRSHRUN V6.2S, V6.2D, #19
    SABDL2  V30.8H, V12.16B, V10.16B
    SQDMLSL2 V14.2D, V23.4S, V15.S[0x3]
    SXTL2 V19.2D, V10.4S
    SMLAL V29.2D, V30.2S, V6.S[0x0]
    SSHLL2 V8.4S, V18.8H, #0x5
    SSHLL2 V17.8H, V21.16B, #0x4
    SQDMULL2 V28.2D, V24.4S, V24.S[0x3]
    SMOV  X22, V14.H[0x4]
    SQXTN  V7.4H, V25.4S
    SABDL  V13.4S, V12.4H, V0.4H
    SQDMLSL2 V12.4S, V9.8H, V9.H[0x3]
    SSRA  V18.4H, V17.4H, #4
    SQADD  V0.8H, V7.8H, V13.8H
    SSHR  V30.8H, V10.8H, #10
    SXTL V14.4S, V22.4H
    SSHL  V6.8B, V18.8B, V5.8B
    SQDMULL  V18.2D, V18.2S, V22.2S
    SMLAL V14.4S, V0.4H, V6.H[0x3]
    SQDMLAL D25, S4, V31.S[0x1]
    SMLSL V9.4S, V2.4H, V6.H[0x7]
    SADDW2  V0.2D, V29.2D, V12.4S
    SQSHLU  V10.16B, V28.16B, #0x6
    SQSHRUN2 V7.4S, V25.2D, #22
    SQDMLSL  V0.4S, V14.4H, V22.4H
    SQSHRN2 V17.16B, V2.8H, #8
    SQRSHRUN2 V6.4S, V26.2D, #31
    SQABS  V31.8B, V30.8B
    SABAL  V22.8H, V31.8B, V0.8B
    SRSHR  V0.8B, V7.8B, #6
    SQRSHRN V14.4H, V6.4S, #16
    SQRSHRN2 V21.8H, V2.4S, #5
    SQRSHL  V14.4S, V21.4S, V20.4S
    SSRA  V20.2S, V0.2S, #22
    SQDMULH H29, H14, V9.H[0x4]
    SQSHRN2 V31.16B, V18.8H, #4
    SMOV  X22, V2.H[0x4]
    SSHLL V25.4S, V22.4H, #0xe
    SQADD  V30.8B, V14.8B, V20.8B
    SSHLL V3.2D, V25.2S, #0x8
    SQRSHRUN2 V28.8H, V10.4S, #13
    SMULL V2.2D, V28.2S, V31.S[0x0]
    SQRSHRN V28.2S, V3.2D, #6
    SSRA  V0.8B, V2.8B, #1
    SADALP  V21.1D, V28.2S
    SQDMLAL V6.2D, V29.2S, V24.S[0x2]
    SQRSHRUN2 V14.8H, V22.4S, #2
    SMLAL2 V29.2D, V0.4S, V0.S[0x1]
    SABA  V25.2S, V21.2S, V2.2S
    SQDMLSL2 V24.2D, V14.4S, V14.S[0x1]
    SUQADD  V31.4S, V24.4S
    SRSRA  V14.4H, V29.4H, #11
    SMLAL V8.4S, V23.4H, V2.H[0x5]
    SQSHRN V20.8B, V17.8H, #4
    SQSHRN V4.2S, V8.2D, #30
    SQDMULL V22.2D, V6.2S, V20.S[0x2]
    SABAL2  V10.4S, V11.8H, V22.8H
    SABA  V0.8B, V31.8B, V30.8B
    SQRSHRUN2 V21.16B, V25.8H, #1
    SQSHL  V7.16B, V30.16B, V8.16B
    SQRSHRUN2 V25.8H, V21.4S, #2
    SXTL2 V16.4S, V0.8H
    SSHR  V30.8H, V16.8H, #16
    SQSHRUN V17.8B, V24.8H, #5
    SQSHRUN V0.8B, V7.8H, #1
    SQRSHRUN2 V27.16B, V17.8H, #8
    SQDMULH  V22.2S, V25.2S, V14.S[0x2]
    SMLAL  V20.2D, V26.2S, V10.2S
    SQSHLU  V7.16B, V1.16B, #0x5
    SABAL  V24.2D, V22.2S, V22.2S
    SQDMULL V15.4S, V6.4H, V3.H[0x0]
    SQDMULH  V1.2S, V27.2S, V0.S[0x0]
    SUQADD  V29.2D, V5.2D
    SMOV W8, V13.B[0x7]
    SMOV  X29, V15.B[0x6]
    SQSHLU  V0.8H, V31.8H, #0xf
    SQRSHRN2 V26.8H, V19.4S, #15
    SQDMLAL2  V7.4S, V18.8H, V30.8H
    SABDL2  V21.4S, V14.8H, V16.8H
    SMOV W7, V7.B[0x0]
    SSRA  V5.4S, V5.4S, #24
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_1
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X2, FPSR
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x800, LSL #16
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    FMOV  D0, X2
    FMOV  V0.D[1], X10
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X17
    FMOV  V2.D[1], X28
    FMOV  D3, X24
    FMOV  V3.D[1], X20
    FMOV  D4, X26
    FMOV  V4.D[1], X16
    FMOV  D5, X20
    FMOV  V5.D[1], X17
    FMOV  D6, X20
    FMOV  V6.D[1], X2
    FMOV  D7, X25
    FMOV  V7.D[1], X5
    FMOV  D8, X16
    FMOV  V8.D[1], X7
    FMOV  D9, X5
    FMOV  V9.D[1], X5
    FMOV  D10, X28
    FMOV  V10.D[1], X21
    FMOV  D11, X4
    FMOV  V11.D[1], X6
    FMOV  D12, X28
    FMOV  V12.D[1], X28
    FMOV  D13, X29
    FMOV  V13.D[1], X19
    FMOV  D14, X20
    FMOV  V14.D[1], X5
    FMOV  D15, X20
    FMOV  V15.D[1], X19
    FMOV  D16, X3
    FMOV  V16.D[1], X10
    FMOV  D17, X28
    FMOV  V17.D[1], X28
    FMOV  D18, X19
    FMOV  V18.D[1], X17
    FMOV  D19, X6
    FMOV  V19.D[1], X6
    FMOV  D20, X6
    FMOV  V20.D[1], X24
    FMOV  D21, X3
    FMOV  V21.D[1], X3
    FMOV  D22, X10
    FMOV  V22.D[1], X7
    FMOV  D23, X19
    FMOV  V23.D[1], X4
    FMOV  D24, X21
    FMOV  V24.D[1], X4
    FMOV  D25, X9
    FMOV  V25.D[1], X9
    FMOV  D26, X3
    FMOV  V26.D[1], X19
    FMOV  D27, X20
    FMOV  V27.D[1], X3
    FMOV  D28, X27
    FMOV  V28.D[1], X17
    FMOV  D29, X19
    FMOV  V29.D[1], X7
    FMOV  D30, X22
    FMOV  V30.D[1], X6
    FMOV  D31, X6
    FMOV  V31.D[1], X10
    MOVZ  X18, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_2:
    SQSHRUN2 V26.8H, V31.4S, #6
    SQSHLU  V6.16B, V25.16B, #0x5
    SADDW2  V7.2D, V7.2D, V4.4S
    SQRSHRUN V1.2S, V30.2D, #24
    SQSHL  V0.4S, V2.4S, V19.4S
    SRSHR  V30.8H, V27.8H, #3
    SMOV  X2, V29.B[0xb]
    SADDW  V15.8H, V6.8H, V9.8B
    SHSUB  V23.16B, V23.16B, V21.16B
    SQSHLU  V4.4H, V23.4H, #0x6
    SQXTUN2  V23.8H, V25.4S
    SMULL2  V12.4S, V7.8H, V4.8H
    SQXTN2  V0.4S, V28.2D
    SMLSL2  V21.2D, V12.4S, V30.4S
    SQDMULH  V14.4S, V1.4S, V9.4S
    SSUBL  V2.8H, V1.8B, V1.8B
    SRSHR  V7.8H, V5.8H, #11
    SMULL V22.2D, V15.2S, V14.S[0x2]
    SQRSHRN V31.8B, V21.8H, #8
    SQSHL  V29.4H, V22.4H, #0x4
    SQDMLSL V14.2D, V30.2S, V15.S[0x2]
    SMLSL2  V21.2D, V7.4S, V22.4S
    SQRSHRN2 V3.8H, V29.4S, #6
    SQXTUN  V9.4H, V0.4S
    SQRDMULH  V5.4S, V12.4S, V14.S[0x3]
    SQDMLSL D22, S23, V2.S[0x0]
    SQSHRN V4.8B, V9.8H, #1
    SQXTN2  V29.16B, V31.8H
    SQSHRN2 V2.16B, V10.8H, #5
    SMLAL  V5.8H, V26.8B, V2.8B
    SMLSL V14.2D, V6.2S, V29.S[0x3]
    SQDMLSL V6.4S, V22.4H, V5.H[0x5]
    SUQADD  V5.4S, V21.4S
    SQRDMULH S22, S3, V6.S[0x2]
    SRSRA  V7.8H, V20.8H, #11
    SMLSL2 V10.2D, V5.4S, V1.S[0x2]
    SABA  V2.4H, V16.4H, V22.4H
    SABD  V27.2S, V10.2S, V2.2S
    SQDMLAL D5, S18, V13.S[0x2]
    SSRA  V9.4S, V28.4S, #6
    SQSHL  V25.8H, V4.8H, #0x5
    SQDMULH  V26.4S, V15.4S, V7.4S
    SQDMULH S3, S25, V27.S[0x2]
    SMOV  X20, V7.B[0x2]
    SADDL  V4.2D, V2.2S, V13.2S
    SQDMLSL D21, S4, V7.S[0x1]
    SSHL  V29.2S, V5.2S, V0.2S
    SADDLP  V23.8H, V26.16B
    SSRA V18.2D, V21.2D, #22
    SQDMULL  V5.4S, V29.4H, V3.4H
    SQRDMULH H6, H14, V14.H[0x2]
    SQADD  V9.4S, V9.4S, V5.4S
    SQDMLAL V0.4S, V17.4H, V1.H[0x1]
    SQDMULL2  V5.4S, V23.8H, V25.8H
    SQSHRN V12.4H, V30.4S, #10
    SQXTN2  V16.16B, V5.8H
    SSRA  V21.8H, V12.8H, #11
    SRSRA V17.2D, V6.2D, #33
    SHSUB  V18.8B, V18.8B, V23.8B
    SSHL  V20.4S, V24.4S, V18.4S
    SQDMLAL V27.2D, V9.2S, V0.S[0x1]
    SQSHRN V6.4H, V26.4S, #14
    SQXTN2  V25.8H, V16.4S
    SQRSHRN2 V4.8H, V4.4S, #12
    SQRDMULH  V14.4H, V25.4H, V6.H[0x4]
    SQRSHRN V31.4H, V21.4S, #11
    SQSHRUN V29.4H, V12.4S, #1
    SQDMULH H19, H29, V5.H[0x1]
    SADDLV  H3, V31.8B
    SMOV  X25, V4.H[0x2]
    SQDMULL D18, S14, V4.S[0x3]
    SMLSL2  V5.8H, V17.16B, V20.16B
    SQDMULH  V22.4S, V5.4S, V11.S[0x3]
    SXTL V7.2D, V17.2S
    SQRDMULH  V25.4S, V18.4S, V0.S[0x3]
    SXTL2 V6.4S, V7.8H
    SQRSHRUN V4.2S, V28.2D, #26
    SQSHRUN2 V0.4S, V9.2D, #25
    SQRDMULH S28, S4, V25.S[0x2]
    SMULL V17.2D, V27.2S, V27.S[0x0]
    SABDL2  V9.8H, V0.16B, V30.16B
    SQSHLU  V31.16B, V9.16B, #0x7
    SQSHRN2 V12.4S, V9.2D, #23
    SQRSHRN V23.2S, V31.2D, #21
    SQDMLSL2  V10.2D, V22.4S, V22.4S
    SRSHR  V24.4H, V3.4H, #2
    SQDMULL D13, S6, V10.S[0x3]
    SQSHRN V5.4H, V26.4S, #13
    SADDL2  V18.8H, V12.16B, V17.16B
    SSHLL V22.4S, V9.4H, #0x2
    SQDMLAL  V6.4S, V25.4H, V6.4H
    SQDMLAL2 V4.4S, V1.8H, V5.H[0x4]
    SSUBL  V9.8H, V4.8B, V18.8B
    SRSHR  V25.8B, V28.8B, #2
    SRSHR  V14.8B, V6.8B, #1
    SQRSHRUN2 V31.8H, V23.4S, #2
    SRSHL  V19.4H, V9.4H, V24.4H
    SQDMLSL2 V10.2D, V14.4S, V22.S[0x2]
    SADDLV  D26, V13.4S
    SMULL  V3.4S, V31.4H, V10.4H
    SQDMULL  V20.2D, V3.2S, V26.2S
    SQDMULL V13.2D, V14.2S, V28.S[0x2]
    SQSHRUN V3.4H, V25.4S, #2
    SQRSHRUN V31.4H, V3.4S, #11
    SSHLL V3.2D, V19.2S, #0x19
    SMULL  V16.4S, V20.4H, V13.4H
    SXTL2 V23.8H, V16.16B
    SMULL V5.2D, V28.2S, V3.S[0x1]
    SMOV  X7, V23.S[0x2]
    SQDMLSL2 V26.2D, V31.4S, V5.S[0x1]
    SQDMLAL  V18.4S, V12.4H, V25.4H
    SQSHRN V1.4H, V28.4S, #4
    SADDW2  V10.4S, V17.4S, V23.8H
    SSHLL V8.2D, V3.2S, #0x4
    SSHLL V22.2D, V17.2S, #0x9
    SMLAL  V5.4S, V15.4H, V17.4H
    SQDMLAL V2.2D, V6.2S, V31.S[0x0]
    SSHL  V23.4H, V1.4H, V18.4H
    SSRA  V27.4H, V8.4H, #12
    SQRSHRN2 V16.16B, V21.8H, #6
    SSHLL V20.8H, V3.8B, #0x1
    SABAL2  V12.2D, V27.4S, V27.4S
    SQDMULH  V27.4S, V5.4S, V5.S[0x3]
    SQDMLAL D3, S2, V27.S[0x1]
    SABDL  V19.2D, V3.2S, V12.2S
    SRHADD  V8.8B, V22.8B, V20.8B
    SSUBL  V11.4S, V4.4H, V26.4H
    SQDMULL V31.2D, V5.2S, V0.S[0x1]
    SQRDMULH  V2.4H, V11.4H, V2.H[0x1]
    SQXTUN2  V28.4S, V19.2D
    SQSHRN2 V5.4S, V25.2D, #31
    SRSHR V21.2D, V8.2D, #52
    SADDLV  D0, V10.4S
    SQDMULH  V11.4H, V21.4H, V5.H[0x6]
    SRSHL  V4.8H, V6.8H, V11.8H
    SSHR  V5.4H, V14.4H, #4
    SMLAL2 V3.4S, V5.8H, V4.H[0x4]
    SQSHRUN V20.8B, V3.8H, #4
    SADDW2  V0.4S, V31.4S, V20.8H
    SSUBL  V4.2D, V20.2S, V2.2S
    SQSHLU  V4.8B, V28.8B, #0x1
    SSHLL2 V28.8H, V23.16B, #0x5
    SQSHLU  V23.8H, V2.8H, #0x0
    SSRA  V27.4H, V28.4H, #4
    SQDMULL D22, S4, V23.S[0x2]
    SQDMLSL  V10.2D, V22.2S, V9.2S
    SMOV W2, V24.H[0x0]
    SQDMULL S25, H10, V10.H[0x3]
    SQDMULL V0.4S, V0.4H, V11.H[0x7]
    SQSHRUN V23.2S, V16.2D, #25
    SQDMULH  V6.4S, V0.4S, V10.4S
    SABAL2  V20.2D, V6.4S, V27.4S
    SMLSL2  V24.2D, V20.4S, V29.4S
    SQSHRN2 V2.4S, V9.2D, #13
    SABAL2  V10.2D, V23.4S, V26.4S
    SSHLL V14.8H, V10.8B, #0x7
    SQDMLSL  V9.4S, V29.4H, V14.4H
    SXTL V8.4S, V24.4H
    SQRSHRN V11.8B, V8.8H, #1
    SQSHLU  V20.4S, V25.4S, #0x13
    SMLSL  V14.8H, V9.8B, V20.8B
    SQABS  V5.16B, V11.16B
    SQDMLSL2 V16.2D, V14.4S, V5.S[0x1]
    SSHLL V6.4S, V25.4H, #0x1
    SSHR  V11.8B, V27.8B, #2
    SQRSHRUN V25.8B, V2.8H, #8
    SQRSHRN V29.4H, V11.4S, #8
    SQDMLSL2  V9.4S, V17.8H, V28.8H
    SADALP  V30.4H, V28.8B
    SQRDMULH  V28.8H, V1.8H, V14.H[0x4]
    SQSHRUN V5.8B, V12.8H, #1
    SRSHR  V20.4S, V13.4S, #30
    SQSHRN V24.8B, V25.8H, #6
    SRSHR  V16.4S, V22.4S, #12
    SMOV W7, V5.H[0x6]
    SQSHRN2 V5.16B, V20.8H, #6
    SMULL V27.2D, V18.2S, V30.S[0x2]
    SSUBW2  V23.4S, V24.4S, V29.8H
    SQXTN  V8.4H, V6.4S
    SRSHR  V18.8B, V15.8B, #8
    SQDMLAL2 V12.4S, V27.8H, V5.H[0x5]
    SQRSHRUN V11.2S, V18.2D, #4
    SRSRA V30.2D, V9.2D, #11
    SSHR  V9.2S, V7.2S, #27
    SRSHR  V17.8H, V30.8H, #1
    SMOV  X7, V9.B[0x4]
    SQRDMULH S15, S16, V28.S[0x0]
    SXTL2 V20.2D, V15.4S
    SRSHR  V24.4H, V8.4H, #8
    SQRSHRN V13.2S, V11.2D, #17
    SQSHLU V8.2D, V17.2D, #0xd
    SRSHR  V6.8H, V1.8H, #11
    SMLAL2 V11.2D, V13.4S, V13.S[0x2]
    SQSHRN2 V29.16B, V31.8H, #5
    SQSHRN2 V7.8H, V27.4S, #6
    SQDMLSL S20, H23, V15.H[0x6]
    SQDMLAL  V5.2D, V11.2S, V12.2S
    SQRSHRN2 V18.8H, V29.4S, #16
    SHADD  V9.2S, V18.2S, V24.2S
    SQSHRN2 V23.16B, V26.8H, #7
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_2
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X23, FPSR
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x800, LSL #16
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D30
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X21
    FMOV  D2, X21
    FMOV  V2.D[1], X28
    FMOV  D3, X25
    FMOV  V3.D[1], X9
    FMOV  D4, X7
    FMOV  V4.D[1], X23
    FMOV  D5, X29
    FMOV  V5.D[1], X4
    FMOV  D6, X17
    FMOV  V6.D[1], X16
    FMOV  D7, X22
    FMOV  V7.D[1], X7
    FMOV  D8, X23
    FMOV  V8.D[1], X3
    FMOV  D9, X19
    FMOV  V9.D[1], X24
    FMOV  D10, X19
    FMOV  V10.D[1], X2
    FMOV  D11, X3
    FMOV  V11.D[1], X10
    FMOV  D12, X28
    FMOV  V12.D[1], X26
    FMOV  D13, X27
    FMOV  V13.D[1], X25
    FMOV  D14, X19
    FMOV  V14.D[1], X23
    FMOV  D15, X16
    FMOV  V15.D[1], X26
    FMOV  D16, X6
    FMOV  V16.D[1], X16
    FMOV  D17, X22
    FMOV  V17.D[1], X29
    FMOV  D18, X16
    FMOV  V18.D[1], X5
    FMOV  D19, X17
    FMOV  V19.D[1], X28
    FMOV  D20, X26
    FMOV  V20.D[1], X21
    FMOV  D21, X25
    FMOV  V21.D[1], X22
    FMOV  D22, X19
    FMOV  V22.D[1], X4
    FMOV  D23, X20
    FMOV  V23.D[1], X8
    FMOV  D24, X3
    FMOV  V24.D[1], X22
    FMOV  D25, X25
    FMOV  V25.D[1], X18
    FMOV  D26, X16
    FMOV  V26.D[1], X24
    FMOV  D27, X4
    FMOV  V27.D[1], X17
    FMOV  D28, X23
    FMOV  V28.D[1], X24
    FMOV  D29, X5
    FMOV  V29.D[1], X27
    FMOV  D30, X8
    FMOV  V30.D[1], X2
    FMOV  D31, X24
    FMOV  V31.D[1], X4
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_3:
    SMLAL V4.4S, V30.4H, V9.H[0x0]
    SQRSHRUN V7.4H, V26.4S, #6
    SRSHR  V15.4H, V24.4H, #15
    SMULL  V27.8H, V4.8B, V31.8B
    SQRSHRN2 V31.4S, V27.2D, #12
    SRSHL  V7.16B, V29.16B, V28.16B
    SQSHLU  V24.2S, V22.2S, #0x6
    SSHR V16.2D, V15.2D, #60
    SQRDMULH S24, S25, V24.S[0x0]
    SQDMULL V0.4S, V31.4H, V7.H[0x2]
    SQRSHRUN V12.8B, V24.8H, #4
    SMLAL2 V10.2D, V16.4S, V0.S[0x2]
    SMULL V27.2D, V17.2S, V4.S[0x2]
    SQSHL  V25.4H, V27.4H, V11.4H
    SHSUB  V15.4H, V12.4H, V24.4H
    SXTL V0.2D, V25.2S
    SMULL2 V15.4S, V15.8H, V11.H[0x2]
    SMOV  X8, V6.H[0x2]
    SQRSHRUN2 V13.4S, V0.2D, #12
    SQDMULL D12, S15, V21.S[0x3]
    SQDMLAL2  V26.2D, V16.4S, V10.4S
    SSHR  V11.16B, V26.16B, #1
    SMOV  X9, V6.S[0x0]
    SABAL2  V11.4S, V13.8H, V12.8H
    SQSHLU  V28.8H, V22.8H, #0xf
    SADDL2  V26.2D, V31.4S, V7.4S
    SQRSHRUN V7.2S, V13.2D, #18
    SRSHL  V27.4S, V25.4S, V2.4S
    SABDL2  V17.8H, V25.16B, V10.16B
    SMULL2 V16.4S, V0.8H, V11.H[0x1]
    SQSHRN V10.2S, V25.2D, #20
    SQRSHRN V1.4H, V1.4S, #5
    SQDMLAL V21.2D, V5.2S, V12.S[0x3]
    SQSHL  V22.2S, V21.2S, #0xb
    SQDMLSL2 V6.2D, V7.4S, V11.S[0x0]
    SRSHR  V2.8B, V22.8B, #8
    SQDMULH S20, S28, V1.S[0x1]
    SRSRA  V4.16B, V27.16B, #8
    SQSHLU  V21.8B, V20.8B, #0x3
    SMLSL2  V27.2D, V4.4S, V17.4S
    SSHR  V22.8H, V30.8H, #5
    SQRSHRN V13.8B, V5.8H, #6
    SQDMLSL2 V20.4S, V26.8H, V9.H[0x6]
    SRSHR  V7.16B, V16.16B, #8
    SMLSL V11.2D, V18.2S, V11.S[0x0]
    SMOV W20, V11.B[0x0]
    SQABS  V9.8H, V23.8H
    SMULL V30.4S, V22.4H, V6.H[0x3]
    SADDLV  S2, V27.4H
    SQRSHL  V25.8B, V7.8B, V9.8B
    SABAL2  V6.4S, V21.8H, V28.8H
    SQDMULL2 V26.4S, V13.8H, V13.H[0x4]
    SADDW2  V17.4S, V6.4S, V11.8H
    SSHR  V11.4H, V31.4H, #2
    SQDMULH S21, S11, V26.S[0x2]
    SMOV W10, V20.H[0x6]
    SQRSHRN V27.4H, V2.4S, #15
    SADDLP  V12.2D, V17.4S
    SQDMLAL D7, S25, V21.S[0x1]
    SQRSHRN2 V22.16B, V12.8H, #7
    SRSRA  V5.4S, V7.4S, #7
    SQXTUN  V13.2S, V22.2D
    SQRDMULH H26, H26, V5.H[0x7]
    SQRDMULH  V11.8H, V8.8H, V8.H[0x5]
    SQRDMULH  V25.8H, V17.8H, V26.8H
    SMLAL2  V8.8H, V30.16B, V16.16B
    SADDL2  V1.8H, V0.16B, V11.16B
    SMLAL V26.2D, V13.2S, V8.S[0x3]
    SSRA  V21.8B, V10.8B, #7
    SQDMULL2 V9.4S, V9.8H, V2.H[0x5]
    SSRA  V10.2S, V31.2S, #28
    SADDLV  D13, V1.4S
    SSUBW  V20.4S, V13.4S, V21.4H
    SSHLL2 V0.2D, V23.4S, #0xe
    SSUBW2  V11.8H, V9.8H, V9.16B
    SQDMLSL2 V13.4S, V16.8H, V11.H[0x3]
    SMLSL V23.2D, V26.2S, V27.S[0x0]
    SMOV  X29, V25.B[0x6]
    SQRSHRN V17.8B, V20.8H, #1
    SRSRA  V11.8H, V10.8H, #11
    SMULL2 V12.4S, V13.8H, V13.H[0x7]
    SXTL V8.2D, V11.2S
    SQDMLAL S14, H8, V4.H[0x6]
    SQSHLU  V26.2S, V10.2S, #0xd
    SQDMULL2 V8.4S, V14.8H, V10.H[0x6]
    SQRDMULH  V27.4S, V17.4S, V8.4S
    SQDMLAL2  V14.2D, V24.4S, V27.4S
    SQDMLAL2  V27.4S, V26.8H, V29.8H
    SADDLP  V24.2S, V12.4H
    SQSHLU  V17.8B, V26.8B, #0x0
    SSRA  V25.16B, V27.16B, #5
    SQRSHRUN2 V16.16B, V25.8H, #1
    SQSHRUN V31.4H, V0.4S, #15
    SMLAL2 V20.4S, V16.8H, V6.H[0x4]
    SQSHRUN2 V1.4S, V23.2D, #7
    SABAL2  V30.8H, V20.16B, V29.16B
    SABAL  V24.2D, V30.2S, V28.2S
    SMLAL V23.2D, V17.2S, V24.S[0x3]
    SQRDMULH S17, S23, V14.S[0x1]
    SQRSHRN2 V2.16B, V1.8H, #5
    SRHADD  V13.8H, V17.8H, V31.8H
    SRSHL  V1.2D, V25.2D, V6.2D
    SQRDMULH  V26.2S, V7.2S, V16.S[0x0]
    SRHADD  V12.8B, V21.8B, V31.8B
    SQDMULL V9.4S, V26.4H, V9.H[0x5]
    SMLAL2 V11.2D, V30.4S, V26.S[0x1]
    SQSHRN2 V0.4S, V8.2D, #2
    SSHLL2 V23.2D, V26.4S, #0x8
    SQRSHRUN2 V4.8H, V18.4S, #8
    SQRSHRN V31.2S, V4.2D, #10
    SRSRA V28.2D, V6.2D, #31
    SQDMULL2  V18.2D, V11.4S, V13.4S
    SSHR  V14.8H, V1.8H, #5
    SSRA  V4.4H, V14.4H, #12
    SQRDMULH  V30.8H, V4.8H, V17.8H
    SMLAL2 V0.4S, V0.8H, V2.H[0x5]
    SQDMULH  V16.8H, V0.8H, V0.H[0x1]
    SADDW  V7.8H, V4.8H, V21.8B
    SQDMULL2 V21.4S, V18.8H, V7.H[0x0]
    SQDMULL2 V2.4S, V31.8H, V10.H[0x7]
    SQDMULL2 V31.4S, V12.8H, V3.H[0x4]
    SQDMLAL2 V19.2D, V23.4S, V28.S[0x1]
    SMLAL2 V14.2D, V21.4S, V19.S[0x0]
    SQDMLSL2 V12.2D, V30.4S, V19.S[0x3]
    SRSHR V3.2D, V16.2D, #60
    SQRSHRUN V26.4H, V2.4S, #11
    SQSHL  V23.8B, V12.8B, #0x2
    SQSHRUN V22.2S, V14.2D, #26
    SMULL2 V30.4S, V25.8H, V3.H[0x6]
    SABAL2  V8.8H, V10.16B, V26.16B
    SQDMULL V14.4S, V7.4H, V8.H[0x2]
    SQABS  V8.4H, V13.4H
    SMLAL V8.2D, V14.2S, V23.S[0x3]
    SMLSL2  V18.2D, V30.4S, V22.4S
    SQRDMULH S0, S10, V31.S[0x1]
    SABDL2  V22.4S, V18.8H, V0.8H
    SRSHR  V23.4H, V29.4H, #13
    SRHADD  V1.4S, V19.4S, V8.4S
    SRSRA  V30.2S, V1.2S, #20
    SXTL2 V7.4S, V11.8H
    SXTL2 V18.2D, V30.4S
    SXTL V12.4S, V12.4H
    SRSRA V1.2D, V12.2D, #23
    SQSHLU  V14.2S, V22.2S, #0xa
    SQSHRUN2 V25.16B, V23.8H, #3
    SUQADD  V25.2S, V15.2S
    SUQADD  V26.4H, V14.4H
    SQRDMULH  V10.4H, V18.4H, V7.H[0x0]
    SQRDMULH H19, H15, V1.H[0x4]
    SQADD  V12.4H, V10.4H, V19.4H
    SQSHRUN2 V23.4S, V18.2D, #23
    SQDMLSL D18, S12, V30.S[0x1]
    SQRSHRUN2 V30.4S, V26.2D, #19
    SQSHRN2 V12.8H, V24.4S, #10
    SQDMULL2  V8.2D, V25.4S, V28.4S
    SQSHRUN V14.8B, V30.8H, #3
    SSHR  V22.16B, V18.16B, #4
    SABDL2  V11.4S, V23.8H, V12.8H
    SQDMLSL2  V24.2D, V11.4S, V11.4S
    SSHR  V10.4H, V24.4H, #7
    SQXTUN2  V7.16B, V8.8H
    SADALP  V0.2D, V5.4S
    SQRSHRN2 V25.4S, V2.2D, #9
    SSHLL V5.2D, V22.2S, #0x17
    SSHLL V11.8H, V5.8B, #0x4
    SQRSHRN V5.4H, V0.4S, #6
    SQDMULH  V1.2S, V7.2S, V7.S[0x3]
    SQDMLSL  V15.2D, V5.2S, V1.2S
    SADDLV  S1, V10.8H
    SQSHLU  V0.16B, V22.16B, #0x3
    SSHLL V8.4S, V0.4H, #0x1
    SADDLP  V10.4H, V1.8B
    SQSUB  V28.8H, V15.8H, V4.8H
    SABDL  V24.2D, V19.2S, V6.2S
    SHSUB  V26.8H, V8.8H, V18.8H
    SQSHL  V5.4S, V27.4S, #0xa
    SQDMLSL D17, S28, V11.S[0x1]
    SQRSHRUN V24.2S, V24.2D, #17
    SQDMLAL S28, H17, V10.H[0x5]
    SQDMLSL V2.4S, V14.4H, V12.H[0x1]
    SQXTN2  V0.8H, V26.4S
    SSHLL V1.8H, V25.8B, #0x1
    SSHLL2 V12.8H, V24.16B, #0x5
    SQDMLSL V28.4S, V1.4H, V5.H[0x4]
    SSRA  V22.8H, V28.8H, #15
    SSHR  V28.16B, V20.16B, #1
    SMOV  X25, V28.S[0x2]
    SQSHRUN V10.4H, V26.4S, #5
    SRHADD  V14.8B, V10.8B, V27.8B
    SMLAL  V26.2D, V22.2S, V14.2S
    SQDMULH H15, H0, V2.H[0x6]
    SQRSHRUN2 V18.4S, V26.2D, #16
    SADDL  V1.8H, V18.8B, V22.8B
    SMULL2 V8.4S, V0.8H, V1.H[0x6]
    SQDMLSL2 V29.4S, V8.8H, V12.H[0x7]
    SXTL V4.2D, V13.2S
    SSHL  V18.2S, V13.2S, V9.2S
    SHSUB  V14.8B, V23.8B, V0.8B
    SMLSL2 V28.2D, V27.4S, V3.S[0x1]
    SQSHRUN2 V8.16B, V25.8H, #6
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_3
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5b, LSL #0
    SUB  X16, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5b, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X16, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X16, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X7, FPSR
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D0
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X16, #0x5a5b, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5b, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D6
    MOVZ  X16, #0x5a5b, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5b, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D14
    MOVZ  X16, #0x1, LSL #0
    MOVK  X16, #0x1, LSL #16
    MOVK  X16, #0x1, LSL #32
    MOVK  X16, #0x1, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D16
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D23
    MOVZ  X16, #0x3, LSL #0
    MOVK  X16, #0x3, LSL #16
    MOVK  X16, #0x3, LSL #32
    MOVK  X16, #0x3, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D24
    MOVZ  X16, #0x2d2d, LSL #0
    MOVK  X16, #0x2d2d, LSL #32
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D29
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D30
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X7, D31
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  D1, X4
    FMOV  V1.D[1], X22
    FMOV  D2, X16
    FMOV  V2.D[1], X27
    FMOV  D3, X29
    FMOV  V3.D[1], X2
    FMOV  D4, X16
    FMOV  V4.D[1], X16
    FMOV  D5, X6
    FMOV  V5.D[1], X4
    FMOV  D6, X10
    FMOV  V6.D[1], X26
    FMOV  D7, X19
    FMOV  V7.D[1], X27
    FMOV  D8, X23
    FMOV  V8.D[1], X5
    FMOV  D9, X19
    FMOV  V9.D[1], X26
    FMOV  D10, X2
    FMOV  V10.D[1], X25
    FMOV  D11, X22
    FMOV  V11.D[1], X8
    FMOV  D12, X29
    FMOV  V12.D[1], X20
    FMOV  D13, X27
    FMOV  V13.D[1], X19
    FMOV  D14, X26
    FMOV  V14.D[1], X24
    FMOV  D15, X27
    FMOV  V15.D[1], X17
    FMOV  D16, X10
    FMOV  V16.D[1], X23
    FMOV  D17, X22
    FMOV  V17.D[1], X25
    FMOV  D18, X3
    FMOV  V18.D[1], X18
    FMOV  D19, X27
    FMOV  V19.D[1], X27
    FMOV  D20, X3
    FMOV  V20.D[1], X23
    FMOV  D21, X20
    FMOV  V21.D[1], X16
    FMOV  D22, X29
    FMOV  V22.D[1], X2
    FMOV  D23, X18
    FMOV  V23.D[1], X28
    FMOV  D24, X16
    FMOV  V24.D[1], X9
    FMOV  D25, X27
    FMOV  V25.D[1], X10
    FMOV  D26, X27
    FMOV  V26.D[1], X3
    FMOV  D27, X17
    FMOV  V27.D[1], X18
    FMOV  D28, X19
    FMOV  V28.D[1], X2
    FMOV  D29, X17
    FMOV  V29.D[1], X20
    FMOV  D30, X23
    FMOV  V30.D[1], X16
    FMOV  D31, X9
    FMOV  V31.D[1], X29
    MOVZ  X7, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_4:
    SSHLL2 V4.2D, V26.4S, #0x10
    SSHR V25.2D, V28.2D, #59
    SQDMULL2  V3.2D, V24.4S, V24.4S
    SSHLL V9.8H, V3.8B, #0x1
    SQDMULL V11.2D, V13.2S, V30.S[0x3]
    SABAL  V28.2D, V27.2S, V25.2S
    SADDW2  V22.2D, V28.2D, V29.4S
    SSHR V29.2D, V4.2D, #29
    SQDMLSL V26.4S, V17.4H, V3.H[0x2]
    SQSHL  V29.4S, V26.4S, #0x9
    SMLAL V26.2D, V31.2S, V30.S[0x3]
    SQRDMULH H2, H14, V8.H[0x4]
    SQSHRUN2 V29.16B, V29.8H, #5
    SSUBL  V10.4S, V25.4H, V22.4H
    SMLAL V24.4S, V11.4H, V13.H[0x3]
    SQDMLSL2 V22.4S, V26.8H, V2.H[0x2]
    SSHLL V30.2D, V22.2S, #0x1
    SQSHL V28.2D, V30.2D, #0x27
    SMLAL V5.4S, V28.4H, V10.H[0x3]
    SSHLL2 V31.2D, V29.4S, #0x11
    SQXTN2  V3.16B, V5.8H
    SQSHRN2 V11.8H, V28.4S, #4
    SSHR  V25.8H, V15.8H, #10
    SHSUB  V2.4S, V24.4S, V9.4S
    SQXTUN2  V13.4S, V18.2D
    SQDMLSL V22.2D, V25.2S, V13.S[0x2]
    SMLSL2 V15.4S, V24.8H, V2.H[0x6]
    SMOV W4, V3.B[0x2]
    SQDMLSL2 V25.2D, V31.4S, V15.S[0x0]
    SXTL2 V2.4S, V25.8H
    SXTL2 V14.8H, V11.16B
    SMLAL2  V15.8H, V14.16B, V2.16B
    SQSHLU  V13.4H, V25.4H, #0xd
    SQSHRUN2 V14.4S, V16.2D, #1
    SMULL  V11.2D, V10.2S, V13.2S
    SQSHRN V29.8B, V14.8H, #5
    SSHR  V3.8B, V30.8B, #2
    SSHR  V2.2S, V16.2S, #24
    SSHR V31.2D, V0.2D, #30
    SQSHRN2 V11.4S, V30.2D, #24
    SQDMLSL V22.4S, V19.4H, V9.H[0x3]
    SQSHL  V24.4S, V21.4S, #0xb
    SMLSL2 V0.4S, V28.8H, V9.H[0x5]
    SMULL2 V21.2D, V3.4S, V12.S[0x2]
    SMOV  X17, V0.B[0x5]
    SRSHR  V28.4S, V13.4S, #1
    SQDMLAL  V16.4S, V29.4H, V29.4H
    SADDLV  D19, V31.4S
    SQSHLU V9.2D, V21.2D, #0x2f
    SXTL V29.8H, V11.8B
    SSHLL2 V3.8H, V29.16B, #0x3
    SSHLL2 V12.8H, V3.16B, #0x5
    SQSHL V13.2D, V30.2D, #0x14
    SQRSHRUN V25.2S, V28.2D, #17
    SQDMLAL2  V14.2D, V24.4S, V9.4S
    SQDMLSL D25, S30, V18.S[0x0]
    SQRSHRN2 V21.8H, V19.4S, #2
    SQRSHRUN2 V17.4S, V14.2D, #2
    SQSHRN V30.4H, V25.4S, #8
    SMLSL2 V14.2D, V15.4S, V21.S[0x0]
    SSUBW2  V9.2D, V12.2D, V13.4S
    SQDMULL  V13.2D, V14.2S, V7.2S
    SQRSHRUN2 V3.16B, V16.8H, #4
    SQSHRUN V25.8B, V21.8H, #2
    SQSHRUN V12.8B, V31.8H, #1
    SABAL2  V31.2D, V13.4S, V21.4S
    SQDMULL V0.4S, V1.4H, V0.H[0x4]
    SQDMLAL2 V7.4S, V12.8H, V12.H[0x2]
    SQSHL V1.2D, V25.2D, #0x37
    SQSHRUN V16.2S, V3.2D, #31
    SQSHRUN V28.2S, V9.2D, #12
    SMLAL2 V25.2D, V0.4S, V19.S[0x3]
    SMLAL V12.2D, V25.2S, V30.S[0x0]
    SXTL2 V16.2D, V31.4S
    SRSHR V13.2D, V12.2D, #60
    SQDMULL2 V5.4S, V21.8H, V6.H[0x5]
    SQDMLSL2  V19.2D, V7.4S, V2.4S
    SUQADD  V30.2S, V28.2S
    SMULL2  V31.4S, V1.8H, V13.8H
    SQSHRUN2 V23.8H, V16.4S, #16
    SQDMLAL S0, H1, V5.H[0x2]
    SQRSHRN V18.2S, V30.2D, #27
    SQSHRUN2 V9.8H, V19.4S, #13
    SQSHRUN V30.2S, V23.2D, #5
    SABDL2  V28.2D, V0.4S, V0.4S
    SMLAL2 V5.4S, V28.8H, V9.H[0x1]
    SMULL2 V28.2D, V25.4S, V31.S[0x3]
    SQRSHRUN V18.8B, V28.8H, #7
    SQSHRUN2 V9.8H, V18.4S, #14
    SRSRA  V6.8B, V22.8B, #8
    SABDL  V19.2D, V30.2S, V5.2S
    SMULL2 V12.4S, V19.8H, V9.H[0x5]
    SQDMULH  V24.8H, V16.8H, V19.8H
    SQDMLSL S28, H9, V8.H[0x7]
    SQDMLSL V8.4S, V6.4H, V8.H[0x4]
    SMLAL  V9.2D, V29.2S, V2.2S
    SSHLL V13.8H, V25.8B, #0x3
    SMLAL V18.2D, V23.2S, V19.S[0x1]
    SQDMLAL2  V16.2D, V6.4S, V27.4S
    SHADD  V2.2S, V15.2S, V5.2S
    SSHLL V25.4S, V24.4H, #0x2
    SSHR  V23.8B, V24.8B, #1
    SQDMLSL D22, S18, V23.S[0x0]
    SMLAL  V18.8H, V1.8B, V13.8B
    SQDMULL S1, H19, V2.H[0x2]
    SQDMLSL D29, S25, V12.S[0x3]
    SQDMULL  V25.4S, V18.4H, V31.4H
    SQSHL  V23.4S, V22.4S, V8.4S
    SQXTN2  V27.16B, V18.8H
    SRSRA  V0.8H, V1.8H, #3
    SMLSL2 V6.2D, V0.4S, V16.S[0x1]
    SQDMULH  V1.2S, V7.2S, V24.S[0x2]
    SSHLL V28.2D, V14.2S, #0x5
    SQSHL  V14.4H, V9.4H, #0x0
    SQDMLAL V31.2D, V25.2S, V28.S[0x3]
    SSHR  V30.16B, V2.16B, #1
    SSHLL2 V13.8H, V6.16B, #0x4
    SQSHRUN2 V20.8H, V23.4S, #9
    SQXTUN2  V19.8H, V31.4S
    SQRSHRUN V12.4H, V10.4S, #1
    SQSHRN V1.8B, V21.8H, #3
    SQRSHRN V31.8B, V14.8H, #6
    SMULL2 V10.4S, V30.8H, V9.H[0x5]
    SQSHRUN V28.2S, V31.2D, #17
    SADALP  V7.2D, V28.4S
    SQRDMULH  V0.8H, V1.8H, V13.H[0x3]
    SMLSL2 V1.4S, V27.8H, V0.H[0x0]
    SMLAL2 V24.4S, V7.8H, V1.H[0x5]
    SABDL  V2.4S, V12.4H, V19.4H
    SQSHRN2 V8.4S, V13.2D, #2
    SMOV  X16, V20.B[0x7]
    SADDLP  V16.4H, V29.8B
    SRSHL  V14.8B, V16.8B, V10.8B
    SABDL2  V9.8H, V8.16B, V18.16B
    SQDMULL2 V29.4S, V9.8H, V2.H[0x7]
    SQRSHRN2 V7.16B, V29.8H, #2
    SQDMULL V6.4S, V14.4H, V7.H[0x3]
    SMOV  X19, V0.B[0x0]
    SQDMULH  V28.4S, V5.4S, V31.S[0x3]
    SABDL2  V9.2D, V24.4S, V7.4S
    SQSHRUN V2.4H, V25.4S, #5
    SSHR  V0.2S, V7.2S, #12
    SADDL  V8.8H, V26.8B, V1.8B
    SSRA  V20.4H, V11.4H, #8
    SQSHRUN2 V27.8H, V27.4S, #11
    SQDMLAL  V11.4S, V31.4H, V26.4H
    SQDMULH S7, S6, V9.S[0x0]
    SSUBL  V5.4S, V24.4H, V28.4H
    SQXTN  V12.8B, V24.8H
    SADDLV  S17, V11.4H
    SRSRA  V23.16B, V13.16B, #4
    SSHLL V11.8H, V20.8B, #0x1
    SRSRA  V16.8H, V0.8H, #3
    SQSHRN2 V13.16B, V5.8H, #7
    SMLSL2 V3.4S, V9.8H, V7.H[0x7]
    SQDMLSL S20, H28, V12.H[0x4]
    SABAL2  V18.8H, V3.16B, V1.16B
    SRSHL  V28.16B, V23.16B, V27.16B
    SQDMULH S12, S28, V2.S[0x1]
    SQRSHRUN V1.8B, V17.8H, #8
    SQSHL V6.2D, V16.2D, #0x35
    SQDMULH H17, H8, V9.H[0x5]
    SMLSL2 V3.2D, V3.4S, V20.S[0x3]
    SQRDMULH  V12.4H, V18.4H, V13.H[0x6]
    SABA  V5.8B, V1.8B, V13.8B
    SABAL2  V9.8H, V12.16B, V17.16B
    SQRSHRN2 V20.8H, V5.4S, #2
    SSUBL2  V28.2D, V24.4S, V11.4S
    SADDLV  H13, V10.16B
    SQDMLSL2 V16.2D, V24.4S, V3.S[0x1]
    SSUBW2  V2.8H, V20.8H, V28.16B
    SRHADD  V8.2S, V2.2S, V7.2S
    SXTL V20.8H, V7.8B
    SADDLV  D12, V11.4S
    SQDMULL  V3.2D, V20.2S, V21.2S
    SMLAL V7.4S, V8.4H, V1.H[0x0]
    SSRA  V23.4S, V31.4S, #5
    SSHLL V5.8H, V23.8B, #0x7
    SQDMLAL2 V24.2D, V13.4S, V13.S[0x1]
    SXTL2 V8.2D, V6.4S
    SQRDMULH S0, S12, V17.S[0x2]
    SQDMULL2  V0.2D, V9.4S, V7.4S
    SQSHRUN V1.4H, V3.4S, #2
    SQSHL  V31.16B, V16.16B, V16.16B
    SMLAL  V3.2D, V21.2S, V8.2S
    SQDMLAL V20.4S, V16.4H, V5.H[0x4]
    SQDMLSL  V5.2D, V14.2S, V3.2S
    SQRSHRN V12.2S, V24.2D, #22
    SQDMLSL2  V11.4S, V20.8H, V12.8H
    SRSHL  V28.8B, V30.8B, V1.8B
    SQRSHRUN V6.4H, V0.4S, #11
    SQDMULL D24, S28, V29.S[0x2]
    SQRDMULH H0, H9, V15.H[0x7]
    SQRSHL  V20.2D, V0.2D, V17.2D
    SQRSHRN V14.2S, V31.2D, #9
    SSHR V15.2D, V22.2D, #18
    SQRSHRUN V0.8B, V24.8H, #3
    SXTL V21.8H, V5.8B
    SSUBW  V9.8H, V6.8H, V0.8B
    SMOV  X5, V14.B[0x6]
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_4
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X8, FPSR
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x800, LSL #16
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D0
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D1
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D2
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0xffc4, LSL #16
    MOVK  X21, #0xffff, LSL #32
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x85eb, LSL #16
    MOVK  X21, #0xfd30, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D4
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xfad8, LSL #16
    MOVK  X21, #0x812c, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D5
    MOVZ  X21, #0xc380, LSL #0
    MOVK  X21, #0x1f80, LSL #16
    MOVK  X21, #0x1d00, LSL #32
    MOVK  X21, #0x2d00, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D6
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D7
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D9
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0xfffe, LSL #16
    MOVK  X21, #0xfffe, LSL #32
    MOVK  X21, #0xfffe, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D11
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff88, LSL #32
    MOVK  X21, #0xfffe, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D12
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D13
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D14
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D15
    MOVZ  X21, #0x168c, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D16
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x50, LSL #32
    MOVK  X21, #0xffc3, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D19
    MOVZ  X21, #0x71fc, LSL #0
    MOVK  X21, #0x2d2, LSL #16
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x1d, LSL #16
    MOVK  X21, #0x2d, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D21
    MOVZ  X21, #0xff80, LSL #0
    MOVK  X21, #0xffc3, LSL #16
    MOVK  X21, #0xff80, LSL #32
    MOVK  X21, #0x1f, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D22
    MOVZ  X21, #0x5f80, LSL #0
    MOVK  X21, #0x5a32, LSL #16
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D23
    MOVZ  X21, #0x3f87, LSL #0
    MOVK  X21, #0x5a3a, LSL #16
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D24
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D25
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X21, #0xfad8, LSL #0
    MOVK  X21, #0x812c, LSL #16
    MOVK  X21, #0x85eb, LSL #32
    MOVK  X21, #0xfd30, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D26
    MOVZ  X21, #0xfad8, LSL #0
    MOVK  X21, #0x812c, LSL #16
    MOVK  X21, #0x85eb, LSL #32
    MOVK  X21, #0xfd30, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D27
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D28
    MOVZ  X21, #0x524, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D30
    MOVZ  X21, #0x524, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X8, D31
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7f, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X26, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x7a2c, LSL #0
    MOVK  X2, #0xe95a, LSL #16
    MOVK  X2, #0xada9, LSL #32
    MOVK  X2, #0x23f1, LSL #48
    MOVZ  X3, #0x71c4, LSL #0
    MOVK  X3, #0x7f9, LSL #16
    MOVK  X3, #0x4871, LSL #32
    MOVK  X3, #0x4305, LSL #48
    MOVZ  X4, #0x5d39, LSL #0
    MOVK  X4, #0xa1cc, LSL #16
    MOVK  X4, #0x64aa, LSL #32
    MOVK  X4, #0xd962, LSL #48
    MOVZ  X5, #0xd6f9, LSL #0
    MOVK  X5, #0x3e75, LSL #16
    MOVK  X5, #0xc9de, LSL #32
    MOVK  X5, #0x7de7, LSL #48
    MOVZ  X6, #0xb6ff, LSL #0
    MOVK  X6, #0x705b, LSL #16
    MOVK  X6, #0xade2, LSL #32
    MOVK  X6, #0x53ad, LSL #48
    MOVZ  X7, #0x5abd, LSL #0
    MOVK  X7, #0xdda1, LSL #16
    MOVK  X7, #0xe2b9, LSL #32
    MOVK  X7, #0x6417, LSL #48
    MOVZ  X8, #0xcfbb, LSL #0
    MOVK  X8, #0xf9b3, LSL #16
    MOVK  X8, #0xcb7a, LSL #32
    MOVK  X8, #0x5ffb, LSL #48
    MOVZ  X9, #0x2d0b, LSL #0
    MOVK  X9, #0x2a70, LSL #16
    MOVK  X9, #0x10f1, LSL #32
    MOVK  X9, #0xb088, LSL #48
    MOVZ  X10, #0xca93, LSL #0
    MOVK  X10, #0xbae6, LSL #16
    MOVK  X10, #0x5af8, LSL #32
    MOVK  X10, #0x7f30, LSL #48
    MOVZ  X16, #0x2dc3, LSL #0
    MOVK  X16, #0x4a48, LSL #16
    MOVK  X16, #0x62a0, LSL #32
    MOVK  X16, #0x2c7, LSL #48
    MOVZ  X17, #0x90d1, LSL #0
    MOVK  X17, #0xd591, LSL #16
    MOVK  X17, #0xbfd5, LSL #32
    MOVK  X17, #0x5aee, LSL #48
    MOVZ  X18, #0xd7de, LSL #0
    MOVK  X18, #0x83a5, LSL #16
    MOVK  X18, #0xcba8, LSL #32
    MOVK  X18, #0x7547, LSL #48
    MOVZ  X19, #0x30e3, LSL #0
    MOVK  X19, #0xbb8e, LSL #16
    MOVK  X19, #0x45ac, LSL #32
    MOVK  X19, #0x4ccb, LSL #48
    MOVZ  X20, #0xdef, LSL #0
    MOVK  X20, #0x2894, LSL #16
    MOVK  X20, #0x8c58, LSL #32
    MOVK  X20, #0xe8c5, LSL #48
    MOVZ  X21, #0xf87b, LSL #0
    MOVK  X21, #0x3d0, LSL #16
    MOVK  X21, #0x62fe, LSL #32
    MOVK  X21, #0x58fb, LSL #48
    MOVZ  X22, #0x9ffa, LSL #0
    MOVK  X22, #0x8c1d, LSL #16
    MOVK  X22, #0x3556, LSL #32
    MOVK  X22, #0x1794, LSL #48
    MOVZ  X23, #0x946b, LSL #0
    MOVK  X23, #0xb153, LSL #16
    MOVK  X23, #0x16bf, LSL #32
    MOVK  X23, #0xa54f, LSL #48
    MOVZ  X24, #0x126c, LSL #0
    MOVK  X24, #0x32f3, LSL #16
    MOVK  X24, #0xe426, LSL #32
    MOVK  X24, #0xc24f, LSL #48
    MOVZ  X25, #0x900, LSL #0
    MOVK  X25, #0xff7c, LSL #16
    MOVK  X25, #0xa93f, LSL #32
    MOVK  X25, #0x4c71, LSL #48
    MOVZ  X26, #0xc210, LSL #0
    MOVK  X26, #0x2b07, LSL #16
    MOVK  X26, #0xfa42, LSL #32
    MOVK  X26, #0x230d, LSL #48
    MOVZ  X27, #0xd75a, LSL #0
    MOVK  X27, #0x2f34, LSL #16
    MOVK  X27, #0x31cd, LSL #32
    MOVK  X27, #0x96a0, LSL #48
    MOVZ  X28, #0x25f8, LSL #0
    MOVK  X28, #0xec42, LSL #16
    MOVK  X28, #0x5b3f, LSL #32
    MOVK  X28, #0x1017, LSL #48
    MOVZ  X29, #0x116, LSL #0
    MOVK  X29, #0x2b35, LSL #16
    MOVK  X29, #0x57, LSL #32
    MOVK  X29, #0xc89f, LSL #48
    FMOV  D0, X7
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X3
    FMOV  D2, X9
    FMOV  V2.D[1], X23
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X28
    FMOV  V4.D[1], X21
    FMOV  D5, X17
    FMOV  V5.D[1], X26
    FMOV  D6, X18
    FMOV  V6.D[1], X21
    FMOV  D7, X2
    FMOV  V7.D[1], X7
    FMOV  D8, X9
    FMOV  V8.D[1], X20
    FMOV  D9, X6
    FMOV  V9.D[1], X16
    FMOV  D10, X9
    FMOV  V10.D[1], X3
    FMOV  D11, X7
    FMOV  V11.D[1], X27
    FMOV  D12, X22
    FMOV  V12.D[1], X4
    FMOV  D13, X18
    FMOV  V13.D[1], X3
    FMOV  D14, X26
    FMOV  V14.D[1], X20
    FMOV  D15, X4
    FMOV  V15.D[1], X20
    FMOV  D16, X20
    FMOV  V16.D[1], X23
    FMOV  D17, X4
    FMOV  V17.D[1], X4
    FMOV  D18, X21
    FMOV  V18.D[1], X23
    FMOV  D19, X27
    FMOV  V19.D[1], X26
    FMOV  D20, X17
    FMOV  V20.D[1], X26
    FMOV  D21, X22
    FMOV  V21.D[1], X24
    FMOV  D22, X18
    FMOV  V22.D[1], X19
    FMOV  D23, X4
    FMOV  V23.D[1], X3
    FMOV  D24, X20
    FMOV  V24.D[1], X3
    FMOV  D25, X9
    FMOV  V25.D[1], X28
    FMOV  D26, X19
    FMOV  V26.D[1], X3
    FMOV  D27, X7
    FMOV  V27.D[1], X23
    FMOV  D28, X10
    FMOV  V28.D[1], X4
    FMOV  D29, X2
    FMOV  V29.D[1], X21
    FMOV  D30, X29
    FMOV  V30.D[1], X17
    FMOV  D31, X17
    FMOV  V31.D[1], X27
    MOVZ  X16, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_5:
    SQSHRUN V5.8B, V0.8H, #2
    SRSHR  V6.8B, V5.8B, #8
    SQSHL  V26.2S, V31.2S, #0x15
    SQDMLSL S27, H6, V10.H[0x4]
    SQSHRUN V29.4H, V30.4S, #9
    SABDL  V31.8H, V27.8B, V23.8B
    SQSHRN V12.8B, V28.8H, #1
    SQSHLU V26.2D, V26.2D, #0x25
    SMOV  X4, V10.B[0xc]
    SQRSHL  V5.8H, V26.8H, V26.8H
    SSUBW  V22.4S, V12.4S, V22.4H
    SRSRA  V4.8H, V22.8H, #8
    SQRDMULH  V26.8H, V5.8H, V4.H[0x7]
    SQABS  V26.16B, V28.16B
    SMLAL2 V6.2D, V21.4S, V16.S[0x1]
    SQDMULH  V12.8H, V6.8H, V1.H[0x7]
    SQDMLSL V23.2D, V12.2S, V26.S[0x1]
    SQDMULL V30.4S, V22.4H, V10.H[0x7]
    SRSHL  V22.16B, V6.16B, V29.16B
    SMLSL2 V22.4S, V7.8H, V3.H[0x2]
    SUQADD  V27.4S, V31.4S
    SQRDMULH  V0.4H, V22.4H, V12.H[0x6]
    SRHADD  V7.2S, V0.2S, V0.2S
    SRSHR  V27.4S, V7.4S, #21
    SQDMLSL2 V23.2D, V15.4S, V9.S[0x0]
    SADDL  V7.2D, V30.2S, V10.2S
    SQSHRN2 V4.8H, V27.4S, #1
    SQXTN2  V28.16B, V23.8H
    SADDW  V11.4S, V18.4S, V31.4H
    SSHLL2 V12.2D, V4.4S, #0x1a
    SXTL V27.4S, V11.4H
    SABDL2  V22.4S, V3.8H, V12.8H
    SRSRA V11.2D, V27.2D, #24
    SSHR  V15.16B, V28.16B, #5
    SXTL V23.2D, V11.2S
    SQSHRN V4.2S, V22.2D, #1
    SQDMULL D27, S3, V9.S[0x2]
    SQDMULL2 V10.2D, V23.4S, V4.S[0x3]
    SQDMLSL S0, H14, V15.H[0x2]
    SMLSL V4.4S, V7.4H, V10.H[0x0]
    SSHL  V13.8B, V5.8B, V19.8B
    SABD  V9.8H, V26.8H, V0.8H
    SQRSHL  V5.4H, V27.4H, V27.4H
    SABAL2  V23.8H, V5.16B, V11.16B
    SRSHR  V3.8H, V30.8H, #1
    SMULL V7.2D, V23.2S, V20.S[0x0]
    SQSHL  V23.16B, V9.16B, V9.16B
    SQDMLAL2 V14.2D, V25.4S, V3.S[0x0]
    SQRSHRUN V25.4H, V4.4S, #15
    SXTL2 V11.8H, V8.16B
    SHADD  V28.4H, V21.4H, V13.4H
    SQSHRN V19.8B, V25.8H, #3
    SQRSHRUN V9.8B, V28.8H, #2
    SQDMULL2  V0.4S, V11.8H, V13.8H
    SADDW  V27.8H, V2.8H, V7.8B
    SQSHRN V18.4H, V9.4S, #5
    SQRSHRUN2 V5.16B, V16.8H, #3
    SMLAL2  V26.8H, V31.16B, V14.16B
    SQSHRUN2 V10.4S, V0.2D, #25
    SRSHL  V20.4H, V4.4H, V30.4H
    SSUBW2  V30.2D, V10.2D, V30.4S
    SRSHL  V3.4H, V19.4H, V20.4H
    SXTL V3.2D, V27.2S
    SQSHRUN V31.4H, V7.4S, #6
    SQSHRN2 V14.16B, V24.8H, #2
    SQABS  V0.8B, V14.8B
    SMLAL2 V19.2D, V30.4S, V31.S[0x3]
    SMOV W5, V18.B[0x4]
    SSHLL2 V13.4S, V8.8H, #0x3
    SMULL2 V21.4S, V0.8H, V0.H[0x3]
    SQXTUN  V10.8B, V19.8H
    SRSHR  V14.4H, V13.4H, #9
    SMOV  X7, V26.B[0x3]
    SMOV  X7, V3.H[0x7]
    SMOV  X18, V10.H[0x6]
    SSHR  V26.4S, V5.4S, #8
    SXTL V0.4S, V14.4H
    SQDMLAL  V18.4S, V16.4H, V21.4H
    SRSHR V19.2D, V26.2D, #33
    SSHLL V8.8H, V0.8B, #0x3
    SUQADD  V19.16B, V2.16B
    SADDW2  V10.8H, V19.8H, V18.16B
    SQSHRN V20.8B, V25.8H, #1
    SADDW  V16.2D, V22.2D, V9.2S
    SQSHRUN V5.2S, V11.2D, #9
    SQSHRN V22.8B, V18.8H, #2
    SSHLL V0.2D, V3.2S, #0x5
    SQSHLU  V14.4H, V6.4H, #0xb
    SQSHRN V6.8B, V8.8H, #3
    SRSHR  V2.8H, V0.8H, #7
    SQDMULL V13.2D, V16.2S, V7.S[0x2]
    SRSRA V27.2D, V21.2D, #55
    SQADD  V8.16B, V9.16B, V27.16B
    SQSHRN V25.8B, V20.8H, #6
    SMLAL2  V0.4S, V8.8H, V2.8H
    SRSHR  V31.2S, V22.2S, #17
    SQRSHRN2 V13.8H, V11.4S, #13
    SADDW  V26.8H, V13.8H, V6.8B
    SQDMLAL2  V0.2D, V10.4S, V14.4S
    SQSHRN V21.2S, V25.2D, #13
    SQDMLAL D3, S0, V5.S[0x0]
    SQSHL  V25.16B, V26.16B, #0x5
    SQSHRN V5.8B, V3.8H, #1
    SXTL V8.8H, V16.8B
    SADDLP  V0.1D, V25.2S
    SQDMLSL  V7.4S, V30.4H, V31.4H
    SMLSL2 V19.2D, V8.4S, V21.S[0x3]
    SQRDMULH S20, S19, V7.S[0x0]
    SQDMULL  V26.2D, V3.2S, V5.2S
    SQDMULL V13.4S, V26.4H, V0.H[0x3]
    SQDMULL2  V30.4S, V23.8H, V30.8H
    SMULL2  V16.2D, V17.4S, V5.4S
    SQRSHRUN2 V31.16B, V23.8H, #5
    SMULL2 V19.2D, V28.4S, V17.S[0x2]
    SMLAL V2.4S, V22.4H, V9.H[0x5]
    SABAL  V25.4S, V28.4H, V27.4H
    SQXTN2  V4.8H, V30.4S
    SXTL2 V23.4S, V14.8H
    SSUBL  V10.2D, V9.2S, V19.2S
    SQDMULL2  V31.4S, V13.8H, V4.8H
    SQDMLSL  V7.2D, V10.2S, V20.2S
    SSUBL  V22.4S, V25.4H, V2.4H
    SQRSHRUN V30.8B, V16.8H, #2
    SQRSHRN2 V25.8H, V22.4S, #16
    SQSHRN V2.8B, V25.8H, #3
    SQSHL  V22.8H, V2.8H, #0xd
    SQSHL  V8.16B, V19.16B, #0x1
    SQDMLSL2  V2.4S, V31.8H, V23.8H
    SMULL V25.4S, V23.4H, V2.H[0x4]
    SQRSHRN2 V9.8H, V3.4S, #5
    SSHLL V13.8H, V11.8B, #0x6
    SMULL  V28.2D, V30.2S, V8.2S
    SQDMLSL2 V16.4S, V25.8H, V13.H[0x5]
    SRSRA V23.2D, V22.2D, #7
    SQRDMULH  V20.4H, V16.4H, V28.4H
    SXTL V12.4S, V12.4H
    SSRA V25.2D, V23.2D, #59
    SQSHL  V30.4S, V20.4S, V1.4S
    SSHLL2 V31.8H, V20.16B, #0x5
    SQRSHL  V1.8H, V31.8H, V3.8H
    SQSHRUN2 V4.8H, V12.4S, #9
    SMOV W10, V2.B[0xf]
    SQSHLU  V19.2S, V4.2S, #0x14
    SMULL2 V14.4S, V1.8H, V9.H[0x7]
    SQXTUN  V8.4H, V12.4S
    SQDMULL D20, S14, V19.S[0x2]
    SSHLL V19.8H, V31.8B, #0x3
    SQDMULL  V2.4S, V7.4H, V25.4H
    SQDMLSL2 V12.4S, V26.8H, V2.H[0x1]
    SQDMLSL V13.2D, V8.2S, V26.S[0x2]
    SQSHLU V7.2D, V13.2D, #0x27
    SQDMLAL  V21.4S, V21.4H, V16.4H
    SQDMLSL V23.4S, V19.4H, V2.H[0x4]
    SQABS  V7.4H, V20.4H
    SMOV W20, V17.H[0x5]
    SQDMULL  V6.2D, V21.2S, V11.2S
    SQDMLAL D21, S12, V23.S[0x3]
    SQDMULH  V25.4S, V2.4S, V30.4S
    SQSHRN V12.8B, V3.8H, #3
    SSHLL V12.8H, V27.8B, #0x6
    SSRA  V24.4H, V21.4H, #12
    SQRSHRN2 V19.8H, V15.4S, #12
    SSUBW2  V20.8H, V25.8H, V14.16B
    SQDMULL2 V15.4S, V6.8H, V9.H[0x3]
    SADALP  V10.4S, V12.8H
    SQDMULL  V17.2D, V15.2S, V10.2S
    SQDMULH S26, S3, V7.S[0x2]
    SQRSHRN V30.2S, V4.2D, #17
    SQSHLU  V12.8H, V15.8H, #0xd
    SRSRA  V10.2S, V19.2S, #1
    SQDMLSL D27, S19, V6.S[0x1]
    SSUBW  V7.8H, V20.8H, V20.8B
    SQRSHRN2 V4.16B, V28.8H, #7
    SQDMLSL2 V11.4S, V27.8H, V3.H[0x5]
    SMLAL V19.2D, V26.2S, V30.S[0x0]
    SHADD  V14.8H, V7.8H, V24.8H
    SMLAL  V9.2D, V4.2S, V18.2S
    SMLSL V8.2D, V5.2S, V14.S[0x2]
    SSHR  V3.8H, V8.8H, #4
    SRSRA V21.2D, V20.2D, #30
    SQSHRN V25.8B, V14.8H, #4
    SSHLL V22.8H, V12.8B, #0x2
    SSHR V8.2D, V5.2D, #15
    SQDMULL  V23.4S, V17.4H, V21.4H
    SSHL  V24.2S, V21.2S, V22.2S
    SMLSL2  V21.2D, V2.4S, V20.4S
    SSUBL  V22.4S, V12.4H, V11.4H
    SQDMLSL V26.4S, V10.4H, V9.H[0x3]
    SQRSHL  V30.4H, V25.4H, V24.4H
    SQRSHRUN2 V6.16B, V22.8H, #3
    SQSHRN2 V2.4S, V6.2D, #13
    SMLAL2 V30.2D, V30.4S, V18.S[0x1]
    SSRA  V11.4H, V21.4H, #3
    SQRSHRN V2.8B, V7.8H, #2
    SQSHRN V25.4H, V12.4S, #2
    SQDMULH S22, S8, V30.S[0x3]
    SQDMULL V28.4S, V19.4H, V2.H[0x0]
    SUQADD  V24.16B, V10.16B
    SXTL2 V12.2D, V26.4S
    SQDMULH  V14.8H, V25.8H, V3.H[0x0]
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_5
    MOVZ  X24, #0x7a2c, LSL #0
    MOVK  X24, #0xe95a, LSL #16
    MOVK  X24, #0xada9, LSL #32
    MOVK  X24, #0x23f1, LSL #48
    SUB  X29, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x71c4, LSL #0
    MOVK  X24, #0x7f9, LSL #16
    MOVK  X24, #0x4871, LSL #32
    MOVK  X24, #0x4305, LSL #48
    SUB  X29, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0xb6ff, LSL #0
    MOVK  X24, #0x705b, LSL #16
    MOVK  X24, #0xade2, LSL #32
    MOVK  X24, #0x53ad, LSL #48
    SUB  X29, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0xcfbb, LSL #0
    MOVK  X24, #0xf9b3, LSL #16
    MOVK  X24, #0xcb7a, LSL #32
    MOVK  X24, #0x5ffb, LSL #48
    SUB  X29, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x2d0b, LSL #0
    MOVK  X24, #0x2a70, LSL #16
    MOVK  X24, #0x10f1, LSL #32
    MOVK  X24, #0xb088, LSL #48
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x90d1, LSL #0
    MOVK  X24, #0xd591, LSL #16
    MOVK  X24, #0xbfd5, LSL #32
    MOVK  X24, #0x5aee, LSL #48
    SUB  X29, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x30e3, LSL #0
    MOVK  X24, #0xbb8e, LSL #16
    MOVK  X24, #0x45ac, LSL #32
    MOVK  X24, #0x4ccb, LSL #48
    SUB  X29, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0xf87b, LSL #0
    MOVK  X24, #0x3d0, LSL #16
    MOVK  X24, #0x62fe, LSL #32
    MOVK  X24, #0x58fb, LSL #48
    SUB  X29, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x946b, LSL #0
    MOVK  X24, #0xb153, LSL #16
    MOVK  X24, #0x16bf, LSL #32
    MOVK  X24, #0xa54f, LSL #48
    SUB  X29, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x900, LSL #0
    MOVK  X24, #0xff7c, LSL #16
    MOVK  X24, #0xa93f, LSL #32
    MOVK  X24, #0x4c71, LSL #48
    SUB  X29, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0xc210, LSL #0
    MOVK  X24, #0x2b07, LSL #16
    MOVK  X24, #0xfa42, LSL #32
    MOVK  X24, #0x230d, LSL #48
    SUB  X29, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0xd75a, LSL #0
    MOVK  X24, #0x2f34, LSL #16
    MOVK  X24, #0x31cd, LSL #32
    MOVK  X24, #0x96a0, LSL #48
    SUB  X29, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X24, #0x25f8, LSL #0
    MOVK  X24, #0xec42, LSL #16
    MOVK  X24, #0x5b3f, LSL #32
    MOVK  X24, #0x1017, LSL #48
    SUB  X29, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X24, FPSR
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x800, LSL #16
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D1
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D29
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D30
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X24, D31
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X18
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X19
    FMOV  D2, X24
    FMOV  V2.D[1], X20
    FMOV  D3, X16
    FMOV  V3.D[1], X17
    FMOV  D4, X21
    FMOV  V4.D[1], X22
    FMOV  D5, X25
    FMOV  V5.D[1], X23
    FMOV  D6, X29
    FMOV  V6.D[1], X4
    FMOV  D7, X27
    FMOV  V7.D[1], X17
    FMOV  D8, X5
    FMOV  V8.D[1], X27
    FMOV  D9, X28
    FMOV  V9.D[1], X23
    FMOV  D10, X29
    FMOV  V10.D[1], X17
    FMOV  D11, X26
    FMOV  V11.D[1], X26
    FMOV  D12, X7
    FMOV  V12.D[1], X10
    FMOV  D13, X25
    FMOV  V13.D[1], X25
    FMOV  D14, X20
    FMOV  V14.D[1], X18
    FMOV  D15, X23
    FMOV  V15.D[1], X26
    FMOV  D16, X16
    FMOV  V16.D[1], X7
    FMOV  D17, X26
    FMOV  V17.D[1], X16
    FMOV  D18, X26
    FMOV  V18.D[1], X8
    FMOV  D19, X26
    FMOV  V19.D[1], X24
    FMOV  D20, X16
    FMOV  V20.D[1], X23
    FMOV  D21, X6
    FMOV  V21.D[1], X28
    FMOV  D22, X28
    FMOV  V22.D[1], X3
    FMOV  D23, X18
    FMOV  V23.D[1], X4
    FMOV  D24, X18
    FMOV  V24.D[1], X5
    FMOV  D25, X9
    FMOV  V25.D[1], X17
    FMOV  D26, X8
    FMOV  V26.D[1], X17
    FMOV  D27, X23
    FMOV  V27.D[1], X9
    FMOV  D28, X2
    FMOV  V28.D[1], X23
    FMOV  D29, X24
    FMOV  V29.D[1], X3
    FMOV  D30, X16
    FMOV  V30.D[1], X2
    FMOV  D31, X3
    FMOV  V31.D[1], X21
    MOVZ  X10, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_6:
    SMOV  X8, V21.H[0x0]
    SXTL V4.2D, V30.2S
    SSHR  V14.8H, V25.8H, #12
    SQRSHRN2 V17.4S, V14.2D, #19
    SQSHL  V13.2D, V26.2D, V23.2D
    SSUBL  V0.8H, V10.8B, V27.8B
    SQXTUN  V8.8B, V28.8H
    SQSHLU  V12.8B, V21.8B, #0x3
    SSUBL2  V13.8H, V13.16B, V0.16B
    SQRSHL  V6.2D, V13.2D, V27.2D
    SMLSL2 V13.2D, V0.4S, V12.S[0x1]
    SQSUB  V30.4H, V17.4H, V17.4H
    SQSHRN V6.2S, V27.2D, #17
    SQDMULL V4.2D, V27.2S, V4.S[0x1]
    SMLSL2 V2.2D, V14.4S, V14.S[0x1]
    SSHLL V11.4S, V7.4H, #0x6
    SSHR V30.2D, V31.2D, #62
    SQRDMULH S30, S29, V13.S[0x0]
    SQDMULH  V31.8H, V3.8H, V4.H[0x1]
    SQDMULL  V26.2D, V6.2S, V11.2S
    SADDL2  V17.4S, V25.8H, V6.8H
    SQSHRUN V12.8B, V17.8H, #3
    SQSHL V29.2D, V30.2D, #0x2e
    SMOV W3, V29.H[0x7]
    SMOV  X19, V15.B[0xc]
    SMLSL2 V30.2D, V0.4S, V3.S[0x0]
    SQDMULL S29, H0, V11.H[0x4]
    SQDMLSL2  V10.4S, V1.8H, V26.8H
    SMLSL2 V13.4S, V29.8H, V12.H[0x6]
    SQRDMULH S1, S27, V15.S[0x0]
    SMLAL V21.4S, V31.4H, V10.H[0x0]
    SQDMULL D14, S13, V25.S[0x3]
    SQRSHRUN V6.2S, V31.2D, #31
    SXTL2 V23.2D, V21.4S
    SQRSHRUN2 V26.8H, V2.4S, #3
    SMLAL V31.4S, V23.4H, V1.H[0x1]
    SQRDMULH  V23.4H, V31.4H, V14.H[0x4]
    SADDLV  D2, V26.4S
    SRSRA  V29.4S, V22.4S, #12
    SMOV  X3, V6.S[0x2]
    SQSHRUN2 V31.4S, V30.2D, #4
    SQSHL V12.2D, V0.2D, #0x7
    SQDMLAL2 V19.4S, V23.8H, V2.H[0x3]
    SSHL  V0.4S, V12.4S, V16.4S
    SQSHL  V14.8B, V3.8B, #0x5
    SQRSHRN V6.8B, V14.8H, #1
    SQSHL  V15.2S, V6.2S, #0x15
    SADDL  V3.2D, V31.2S, V31.2S
    SSHLL V1.8H, V5.8B, #0x2
    SQDMLSL V22.2D, V3.2S, V29.S[0x2]
    SQDMLAL  V6.4S, V22.4H, V15.4H
    SADALP  V13.2S, V1.4H
    SQXTN  V15.2S, V6.2D
    SRSHR V27.2D, V1.2D, #41
    SQNEG  V16.4S, V13.4S
    SQSHL  V13.4H, V12.4H, #0x0
    SXTL2 V5.8H, V24.16B
    SQRSHRN2 V14.8H, V27.4S, #5
    SHADD  V3.4S, V19.4S, V0.4S
    SADDW  V19.4S, V16.4S, V0.4H
    SABA  V23.2S, V13.2S, V19.2S
    SQSHLU V12.2D, V0.2D, #0x3f
    SQDMULL V24.2D, V10.2S, V24.S[0x0]
    SQSHLU  V22.8B, V15.8B, #0x4
    SADALP  V16.2D, V14.4S
    SQDMLAL2  V25.4S, V18.8H, V4.8H
    SHSUB  V13.4S, V3.4S, V5.4S
    SABD  V27.16B, V24.16B, V27.16B
    SMLAL2 V18.2D, V28.4S, V21.S[0x3]
    SSHR  V6.4H, V22.4H, #10
    SHADD  V4.2S, V6.2S, V27.2S
    SSHR V21.2D, V21.2D, #34
    SQRSHRN V0.8B, V16.8H, #8
    SXTL V22.2D, V0.2S
    SMLSL  V16.2D, V4.2S, V23.2S
    SRSHR  V4.4H, V25.4H, #15
    SQDMLAL S28, H0, V0.H[0x6]
    SSHR V25.2D, V28.2D, #15
    SADDW  V12.2D, V4.2D, V21.2S
    SQRSHRN V15.2S, V18.2D, #17
    SQDMLSL D1, S25, V13.S[0x2]
    SMOV  X2, V16.B[0x6]
    SQXTUN  V3.8B, V1.8H
    SSRA  V5.8B, V21.8B, #3
    SQDMLSL2 V28.4S, V22.8H, V13.H[0x0]
    SMULL  V13.8H, V15.8B, V12.8B
    SQSHLU  V15.4S, V16.4S, #0x8
    SQDMULL V0.2D, V24.2S, V5.S[0x0]
    SABAL  V10.4S, V16.4H, V16.4H
    SQDMLAL2 V26.4S, V0.8H, V15.H[0x0]
    SSHR V23.2D, V25.2D, #20
    SQRSHRN2 V6.8H, V13.4S, #8
    SQDMULL2 V18.4S, V3.8H, V10.H[0x4]
    SMLSL2 V7.4S, V21.8H, V6.H[0x5]
    SADDLV  S19, V18.8H
    SQSHRN2 V16.8H, V23.4S, #15
    SSUBW  V27.4S, V26.4S, V3.4H
    SQSHRN2 V28.16B, V19.8H, #1
    SABDL2  V15.4S, V16.8H, V1.8H
    SQRDMULH  V26.2S, V15.2S, V15.S[0x0]
    SMLSL V22.2D, V12.2S, V5.S[0x3]
    SMULL2 V3.4S, V28.8H, V7.H[0x2]
    SQDMULH  V18.8H, V26.8H, V13.H[0x6]
    SMOV  X6, V17.S[0x2]
    SQDMULH S2, S8, V22.S[0x0]
    SQDMULL V26.4S, V3.4H, V3.H[0x0]
    SRSRA  V8.8H, V8.8H, #9
    SQNEG  V15.16B, V29.16B
    SMLSL  V13.2D, V8.2S, V17.2S
    SQSHRN2 V25.4S, V26.2D, #11
    SQDMLAL2 V10.2D, V27.4S, V15.S[0x0]
    SABA  V24.16B, V18.16B, V10.16B
    SQDMLSL V1.2D, V11.2S, V25.S[0x1]
    SQSHLU V6.2D, V1.2D, #0x18
    SMLAL2  V23.2D, V24.4S, V24.4S
    SSHR  V21.4S, V2.4S, #17
    SRSHR  V22.4S, V13.4S, #30
    SRSRA  V13.4H, V21.4H, #1
    SSHLL V26.8H, V23.8B, #0x6
    SRSRA  V23.8H, V23.8H, #11
    SSUBL2  V3.8H, V25.16B, V30.16B
    SHSUB  V28.16B, V6.16B, V7.16B
    SMLSL2 V29.4S, V23.8H, V3.H[0x7]
    SMULL2 V10.4S, V6.8H, V0.H[0x6]
    SRSHR  V0.8H, V28.8H, #9
    SABAL2  V8.8H, V0.16B, V17.16B
    SQDMLSL S21, H8, V8.H[0x2]
    SQDMLAL D5, S29, V2.S[0x0]
    SABAL  V18.8H, V10.8B, V26.8B
    SQRSHRN V8.2S, V29.2D, #7
    SQDMLAL2  V6.2D, V22.4S, V28.4S
    SADDW2  V19.2D, V9.2D, V2.4S
    SMULL2 V7.2D, V18.4S, V24.S[0x1]
    SMLAL V26.2D, V19.2S, V25.S[0x3]
    SQDMULL V23.4S, V7.4H, V2.H[0x2]
    SHADD  V2.4H, V5.4H, V21.4H
    SQDMLSL2 V5.2D, V12.4S, V13.S[0x0]
    SQRDMULH  V10.2S, V0.2S, V13.2S
    SMOV  X21, V23.H[0x3]
    SHSUB  V9.16B, V15.16B, V6.16B
    SQSHRN2 V6.4S, V25.2D, #9
    SQDMLSL2 V19.4S, V0.8H, V6.H[0x3]
    SSRA  V30.8B, V8.8B, #4
    SQDMLSL V8.4S, V19.4H, V12.H[0x6]
    SRSHL  V28.2S, V4.2S, V9.2S
    SADDLV  H0, V21.8B
    SQXTUN2  V12.8H, V10.4S
    SADDL2  V10.4S, V12.8H, V27.8H
    SHADD  V12.8B, V30.8B, V26.8B
    SQABS  V28.4S, V2.4S
    SQRDMULH  V18.4S, V8.4S, V7.S[0x2]
    SQDMULL S7, H21, V1.H[0x6]
    SQXTUN2  V21.8H, V0.4S
    SQDMLSL S30, H2, V14.H[0x6]
    SQSHRN2 V9.16B, V30.8H, #3
    SQRSHRUN2 V23.8H, V7.4S, #13
    SQRSHRUN V12.4H, V18.4S, #4
    SQDMLAL S7, H7, V10.H[0x4]
    SQDMULL2 V10.2D, V20.4S, V23.S[0x0]
    SQDMLSL V30.2D, V12.2S, V12.S[0x2]
    SQRSHRUN V1.4H, V9.4S, #5
    SQDMLAL  V23.4S, V27.4H, V30.4H
    SMLAL  V21.4S, V21.4H, V10.4H
    SMLAL2 V15.4S, V7.8H, V1.H[0x5]
    SRSRA V30.2D, V21.2D, #58
    SMLAL2 V26.2D, V28.4S, V15.S[0x0]
    SSHLL2 V8.4S, V21.8H, #0x4
    SMULL2 V21.4S, V31.8H, V1.H[0x6]
    SQRSHRUN2 V14.16B, V8.8H, #2
    SABDL2  V1.4S, V5.8H, V31.8H
    SQXTN  V7.2S, V12.2D
    SADDL2  V20.2D, V0.4S, V26.4S
    SQRSHRN2 V31.16B, V30.8H, #1
    SQRDMULH  V0.2S, V31.2S, V1.S[0x1]
    SADDL2  V15.4S, V4.8H, V8.8H
    SRHADD  V10.16B, V15.16B, V23.16B
    SMULL2 V9.4S, V14.8H, V10.H[0x3]
    SRSRA V26.2D, V20.2D, #17
    SQDMLSL2 V2.2D, V21.4S, V9.S[0x3]
    SQRSHRUN V12.4H, V26.4S, #3
    SQDMLSL V4.2D, V23.2S, V12.S[0x3]
    SMULL V5.4S, V13.4H, V10.H[0x6]
    SQSHLU  V14.16B, V4.16B, #0x3
    SABDL2  V4.8H, V7.16B, V7.16B
    SQDMULL2  V30.2D, V27.4S, V22.4S
    SQDMULL V14.4S, V30.4H, V2.H[0x5]
    SQDMULL2 V10.2D, V31.4S, V4.S[0x1]
    SABDL  V7.4S, V16.4H, V28.4H
    SQDMLSL D8, S14, V13.S[0x0]
    SQDMLSL  V20.4S, V5.4H, V27.4H
    SSHLL V5.4S, V8.4H, #0x6
    SQDMULL2 V12.4S, V9.8H, V11.H[0x3]
    SSHL  V27.4H, V10.4H, V23.4H
    SQXTUN2  V9.8H, V24.4S
    SSRA  V12.4H, V0.4H, #12
    SQDMULH  V8.8H, V7.8H, V12.H[0x3]
    SQSHRN2 V13.4S, V5.2D, #11
    SQDMULL2  V2.2D, V27.4S, V8.4S
    SQRDMULH H23, H20, V13.H[0x4]
    SADDW  V31.4S, V9.4S, V2.4H
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_6
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X20, FPSR
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x800, LSL #16
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D0
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D1
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D27
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D30
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X20, D31
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    FMOV  D0, X29
    FMOV  V0.D[1], X10
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X23
    FMOV  D3, X27
    FMOV  V3.D[1], X7
    FMOV  D4, X10
    FMOV  V4.D[1], X21
    FMOV  D5, X5
    FMOV  V5.D[1], X8
    FMOV  D6, X10
    FMOV  V6.D[1], X22
    FMOV  D7, X28
    FMOV  V7.D[1], X21
    FMOV  D8, X10
    FMOV  V8.D[1], X9
    FMOV  D9, X27
    FMOV  V9.D[1], X25
    FMOV  D10, X20
    FMOV  V10.D[1], X29
    FMOV  D11, X26
    FMOV  V11.D[1], X27
    FMOV  D12, X5
    FMOV  V12.D[1], X16
    FMOV  D13, X21
    FMOV  V13.D[1], X27
    FMOV  D14, X5
    FMOV  V14.D[1], X27
    FMOV  D15, X23
    FMOV  V15.D[1], X8
    FMOV  D16, X2
    FMOV  V16.D[1], X6
    FMOV  D17, X28
    FMOV  V17.D[1], X16
    FMOV  D18, X6
    FMOV  V18.D[1], X26
    FMOV  D19, X28
    FMOV  V19.D[1], X18
    FMOV  D20, X2
    FMOV  V20.D[1], X19
    FMOV  D21, X10
    FMOV  V21.D[1], X6
    FMOV  D22, X4
    FMOV  V22.D[1], X27
    FMOV  D23, X24
    FMOV  V23.D[1], X27
    FMOV  D24, X18
    FMOV  V24.D[1], X20
    FMOV  D25, X8
    FMOV  V25.D[1], X28
    FMOV  D26, X20
    FMOV  V26.D[1], X23
    FMOV  D27, X18
    FMOV  V27.D[1], X20
    FMOV  D28, X9
    FMOV  V28.D[1], X17
    FMOV  D29, X26
    FMOV  V29.D[1], X18
    FMOV  D30, X10
    FMOV  V30.D[1], X5
    FMOV  D31, X16
    FMOV  V31.D[1], X20
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_7:
    SABA  V13.8B, V28.8B, V26.8B
    SQRSHRN2 V9.16B, V23.8H, #2
    SMULL  V25.2D, V25.2S, V19.2S
    SQDMLAL2 V12.4S, V29.8H, V15.H[0x6]
    SRSRA V28.2D, V20.2D, #38
    SADDL2  V1.8H, V16.16B, V12.16B
    SQRDMULH  V0.8H, V10.8H, V1.8H
    SQRSHRN V3.8B, V28.8H, #1
    SQDMULL2 V13.2D, V21.4S, V25.S[0x2]
    SQSHLU  V0.8H, V12.8H, #0xe
    SMLSL2 V14.4S, V13.8H, V3.H[0x6]
    SQDMLAL2  V23.2D, V20.4S, V22.4S
    SMLAL V22.4S, V23.4H, V0.H[0x6]
    SRSRA  V26.8H, V22.8H, #5
    SQSHRUN2 V0.16B, V14.8H, #1
    SADDLP  V14.1D, V20.2S
    SXTL2 V15.4S, V27.8H
    SQDMLSL S21, H25, V5.H[0x5]
    SRSHR  V10.8B, V30.8B, #6
    SSRA V1.2D, V8.2D, #39
    SQDMULL  V24.2D, V15.2S, V1.2S
    SXTL2 V25.2D, V9.4S
    SQNEG  V3.4S, V0.4S
    SQDMLAL D13, S24, V21.S[0x1]
    SMLAL2 V27.2D, V25.4S, V30.S[0x3]
    SSHR  V24.4H, V13.4H, #5
    SQSHRN V15.8B, V27.8H, #8
    SQRSHRN V19.8B, V3.8H, #2
    SABD  V8.4S, V20.4S, V14.4S
    SADDW2  V16.8H, V8.8H, V15.16B
    SSHL  V22.4S, V19.4S, V22.4S
    SQSHRN2 V9.16B, V12.8H, #6
    SADDL2  V14.2D, V20.4S, V22.4S
    SXTL2 V13.8H, V14.16B
    SQDMULH H2, H9, V9.H[0x4]
    SXTL V10.4S, V2.4H
    SQDMULL2  V8.2D, V30.4S, V24.4S
    SQDMULL2  V19.2D, V0.4S, V16.4S
    SSRA  V24.16B, V19.16B, #6
    SSHLL2 V11.8H, V24.16B, #0x5
    SQDMLAL2 V24.2D, V11.4S, V14.S[0x0]
    SQDMLSL D3, S9, V20.S[0x1]
    SSHLL2 V9.8H, V13.16B, #0x2
    SQDMLAL V21.4S, V8.4H, V8.H[0x7]
    SMOV W22, V10.B[0x2]
    SSHR  V16.4S, V21.4S, #17
    SSUBL  V13.8H, V19.8B, V12.8B
    SQDMLAL V5.4S, V3.4H, V2.H[0x2]
    SQSHL V4.2D, V13.2D, #0x5
    SQRSHRUN2 V25.4S, V9.2D, #16
    SQDMLSL2 V2.2D, V4.4S, V1.S[0x1]
    SQRDMULH H30, H10, V5.H[0x3]
    SMLAL2  V1.8H, V5.16B, V24.16B
    SQDMULH S0, S1, V29.S[0x1]
    SXTL2 V6.8H, V16.16B
    SMLAL V19.2D, V17.2S, V27.S[0x2]
    SQRSHRN V3.4H, V6.4S, #5
    SMULL V22.2D, V30.2S, V25.S[0x0]
    SSUBL2  V21.2D, V22.4S, V19.4S
    SMLAL2 V27.4S, V21.8H, V0.H[0x0]
    SADDW  V30.2D, V12.2D, V27.2S
    SQRSHL  V24.2S, V30.2S, V2.2S
    SQDMLAL2 V29.4S, V12.8H, V7.H[0x7]
    SMOV  X24, V9.S[0x0]
    SSHLL V4.4S, V2.4H, #0x1
    SRSRA  V6.16B, V22.16B, #4
    SMLAL V0.4S, V30.4H, V6.H[0x3]
    SRSHR V24.2D, V2.2D, #3
    SMLAL2 V9.2D, V29.4S, V9.S[0x2]
    SQSHL  V10.8H, V17.8H, #0xf
    SMOV W4, V26.H[0x2]
    SSHR  V7.16B, V12.16B, #5
    SSUBW2  V13.8H, V15.8H, V30.16B
    SSUBL  V15.2D, V29.2S, V11.2S
    SQRDMULH S16, S1, V13.S[0x3]
    SMLAL V2.4S, V7.4H, V7.H[0x5]
    SQDMLSL2 V19.4S, V16.8H, V0.H[0x1]
    SABAL  V5.4S, V8.4H, V10.4H
    SSHLL2 V16.2D, V5.4S, #0xc
    SQDMULL V27.2D, V9.2S, V17.S[0x3]
    SQSHRUN2 V13.16B, V27.8H, #5
    SQDMLSL D30, S4, V27.S[0x2]
    SSHLL2 V12.4S, V19.8H, #0x1
    SQDMLSL2 V22.2D, V12.4S, V16.S[0x2]
    SSUBW  V1.2D, V24.2D, V15.2S
    SMLAL2 V10.4S, V1.8H, V1.H[0x3]
    SQRSHRN2 V24.4S, V2.2D, #31
    SQDMLSL D15, S24, V22.S[0x2]
    SQSHRN V0.8B, V22.8H, #5
    SQNEG  V7.8B, V26.8B
    SMULL2  V18.2D, V0.4S, V7.4S
    SRHADD  V5.4H, V28.4H, V18.4H
    SMLSL  V18.2D, V12.2S, V15.2S
    SQDMULH  V12.2S, V5.2S, V30.S[0x0]
    SSRA  V24.8B, V30.8B, #6
    SQSHLU V2.2D, V21.2D, #0x19
    SQDMLAL2 V22.4S, V9.8H, V13.H[0x7]
    SQADD  V11.8B, V14.8B, V4.8B
    SQDMLAL2 V30.2D, V10.4S, V23.S[0x2]
    SQXTN  V8.8B, V7.8H
    SABD  V8.8B, V11.8B, V30.8B
    SMULL V5.4S, V8.4H, V0.H[0x5]
    SQDMULH S31, S7, V5.S[0x1]
    SRSRA  V16.8H, V18.8H, #2
    SQDMULH  V11.2S, V16.2S, V2.S[0x3]
    SQDMLSL2 V23.4S, V22.8H, V11.H[0x1]
    SQSHRN V14.2S, V17.2D, #10
    SMLAL2 V8.4S, V19.8H, V12.H[0x0]
    SQSHLU V8.2D, V24.2D, #0x3d
    SQDMLAL V28.4S, V14.4H, V14.H[0x3]
    SQRSHRUN2 V2.16B, V3.8H, #3
    SSRA V14.2D, V20.2D, #34
    SMOV  X28, V31.H[0x6]
    SMULL V3.2D, V13.2S, V8.S[0x3]
    SQXTUN  V18.4H, V23.4S
    SQDMLAL2  V4.2D, V16.4S, V28.4S
    SABAL2  V15.2D, V2.4S, V3.4S
    SHADD  V2.4H, V14.4H, V8.4H
    SQDMULL V5.4S, V1.4H, V4.H[0x7]
    SQDMULH H12, H15, V2.H[0x4]
    SQDMLSL  V17.2D, V22.2S, V27.2S
    SQSHRUN V9.4H, V23.4S, #2
    SMLAL2 V10.4S, V1.8H, V1.H[0x5]
    SQRSHRN V1.2S, V18.2D, #24
    SHSUB  V4.2S, V1.2S, V10.2S
    SQSHRUN2 V12.8H, V4.4S, #8
    SMOV  X16, V12.S[0x0]
    SQSHRUN2 V31.4S, V0.2D, #17
    SRSRA  V4.4H, V16.4H, #10
    SRSHR V22.2D, V5.2D, #28
    SADDLV  H18, V4.16B
    SMLAL V0.2D, V26.2S, V31.S[0x0]
    SSUBL  V26.8H, V9.8B, V22.8B
    SRSHR  V28.4H, V26.4H, #2
    SADDLV  S31, V20.8H
    SQSHRN V27.2S, V28.2D, #7
    SQDMULL2  V20.4S, V25.8H, V27.8H
    SQSHLU  V14.2S, V0.2S, #0x8
    SQRDMULH  V25.4H, V31.4H, V14.H[0x0]
    SQDMULH  V28.4S, V4.4S, V17.S[0x0]
    SQSHRUN2 V18.4S, V18.2D, #16
    SMLSL2  V9.2D, V18.4S, V23.4S
    SMULL  V14.2D, V28.2S, V25.2S
    SQSHRUN V26.2S, V14.2D, #19
    SQSHRN V23.2S, V26.2D, #3
    SSHR  V14.8B, V23.8B, #4
    SQSHRN V26.4H, V20.4S, #5
    SSHR  V28.8B, V9.8B, #2
    SMLAL2 V20.2D, V26.4S, V4.S[0x2]
    SQSHRUN2 V30.4S, V14.2D, #2
    SQDMULH  V23.8H, V30.8H, V11.H[0x0]
    SMLSL V30.4S, V3.4H, V8.H[0x4]
    SQRDMULH  V4.4S, V23.4S, V11.4S
    SADALP  V31.8H, V28.16B
    SQDMULL  V9.4S, V14.4H, V13.4H
    SHADD  V13.2S, V4.2S, V23.2S
    SSHR  V8.2S, V20.2S, #16
    SQSHLU  V5.8B, V10.8B, #0x4
    SMLAL V3.2D, V5.2S, V9.S[0x0]
    SQDMULL D17, S14, V20.S[0x0]
    SSHR  V18.2S, V21.2S, #9
    SMULL2 V26.4S, V13.8H, V13.H[0x3]
    SQRDMULH  V28.2S, V8.2S, V30.S[0x1]
    SQDMLAL2 V5.2D, V3.4S, V31.S[0x1]
    SADDLV  S21, V17.8H
    SQSHL  V17.4S, V8.4S, V26.4S
    SSUBW  V20.2D, V28.2D, V28.2S
    SSHLL2 V23.4S, V12.8H, #0x6
    SSHR V9.2D, V19.2D, #17
    SQDMLSL V25.4S, V20.4H, V1.H[0x0]
    SMOV  X6, V12.S[0x0]
    SSRA  V1.2S, V21.2S, #11
    SQSUB  V12.8B, V5.8B, V5.8B
    SQDMULH H31, H18, V1.H[0x0]
    SHADD  V26.16B, V27.16B, V28.16B
    SMOV  X4, V26.H[0x3]
    SQSHLU  V27.16B, V12.16B, #0x2
    SQRSHRUN2 V19.16B, V25.8H, #6
    SRSRA V14.2D, V11.2D, #58
    SQDMLAL V15.4S, V10.4H, V13.H[0x7]
    SQSHLU  V8.2S, V27.2S, #0x1f
    SSHR  V12.16B, V30.16B, #3
    SRSHR V21.2D, V26.2D, #34
    SQRSHL  V13.2S, V21.2S, V25.2S
    SRSHL  V1.2S, V23.2S, V13.2S
    SQSHRN2 V3.16B, V9.8H, #1
    SQDMLAL S22, H20, V1.H[0x4]
    SQXTUN2  V5.4S, V15.2D
    SMLSL2 V18.4S, V12.8H, V0.H[0x1]
    SQRSHRUN V9.4H, V14.4S, #12
    SQSHRN2 V20.4S, V24.2D, #3
    SQRSHRUN V22.8B, V9.8H, #6
    SADDL  V26.2D, V22.2S, V22.2S
    SRSHR  V31.4H, V2.4H, #12
    SSHLL V1.4S, V17.4H, #0x1
    SQNEG  V10.4S, V31.4S
    SQADD  V24.8H, V20.8H, V8.8H
    SSHR  V27.2S, V5.2S, #32
    SQXTN  V5.4H, V1.4S
    SRSHR  V27.2S, V19.2S, #9
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_7
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X21, FPSR
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x800, LSL #16
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D15
    MOVZ  X9, #0xfffd, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X9, #0xfffd, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D29
    MOVZ  X9, #0xfffd, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X21, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X23
    FMOV  D2, X29
    FMOV  V2.D[1], X4
    FMOV  D3, X16
    FMOV  V3.D[1], X16
    FMOV  D4, X9
    FMOV  V4.D[1], X28
    FMOV  D5, X6
    FMOV  V5.D[1], X24
    FMOV  D6, X10
    FMOV  V6.D[1], X22
    FMOV  D7, X10
    FMOV  V7.D[1], X21
    FMOV  D8, X6
    FMOV  V8.D[1], X7
    FMOV  D9, X3
    FMOV  V9.D[1], X20
    FMOV  D10, X16
    FMOV  V10.D[1], X5
    FMOV  D11, X20
    FMOV  V11.D[1], X23
    FMOV  D12, X23
    FMOV  V12.D[1], X17
    FMOV  D13, X10
    FMOV  V13.D[1], X6
    FMOV  D14, X6
    FMOV  V14.D[1], X4
    FMOV  D15, X28
    FMOV  V15.D[1], X2
    FMOV  D16, X20
    FMOV  V16.D[1], X4
    FMOV  D17, X2
    FMOV  V17.D[1], X4
    FMOV  D18, X27
    FMOV  V18.D[1], X8
    FMOV  D19, X29
    FMOV  V19.D[1], X26
    FMOV  D20, X3
    FMOV  V20.D[1], X3
    FMOV  D21, X27
    FMOV  V21.D[1], X10
    FMOV  D22, X23
    FMOV  V22.D[1], X16
    FMOV  D23, X22
    FMOV  V23.D[1], X8
    FMOV  D24, X26
    FMOV  V24.D[1], X29
    FMOV  D25, X23
    FMOV  V25.D[1], X17
    FMOV  D26, X7
    FMOV  V26.D[1], X19
    FMOV  D27, X6
    FMOV  V27.D[1], X27
    FMOV  D28, X28
    FMOV  V28.D[1], X20
    FMOV  D29, X21
    FMOV  V29.D[1], X26
    FMOV  D30, X19
    FMOV  V30.D[1], X7
    FMOV  D31, X9
    FMOV  V31.D[1], X3
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_8:
    SQSHRUN V25.2S, V27.2D, #20
    SQDMULH S23, S24, V25.S[0x0]
    SMLSL2 V23.4S, V30.8H, V6.H[0x5]
    SQSHRN V26.8B, V7.8H, #7
    SQABS  V8.2D, V28.2D
    SSHR  V12.4S, V25.4S, #10
    SMLAL2  V9.8H, V29.16B, V16.16B
    SSHLL V24.4S, V0.4H, #0x6
    SMLAL V23.2D, V26.2S, V8.S[0x3]
    SSHLL V29.8H, V5.8B, #0x1
    SMOV  X7, V24.B[0x7]
    SQXTN2  V2.16B, V31.8H
    SXTL V13.2D, V23.2S
    SQRSHRN V0.8B, V12.8H, #3
    SABDL  V17.8H, V9.8B, V9.8B
    SMULL2 V10.2D, V29.4S, V20.S[0x2]
    SQRSHRN2 V4.8H, V17.4S, #5
    SSHLL V9.4S, V24.4H, #0x9
    SABA  V28.4H, V29.4H, V10.4H
    SXTL2 V26.8H, V7.16B
    SMLSL V24.4S, V13.4H, V4.H[0x2]
    SQDMLAL V22.2D, V27.2S, V28.S[0x1]
    SADDW2  V5.8H, V2.8H, V16.16B
    SSHLL V16.2D, V5.2S, #0x16
    SSHLL2 V4.2D, V13.4S, #0x7
    SADDLV  D27, V27.4S
    SSHLL2 V13.2D, V22.4S, #0x16
    SHADD  V23.4H, V13.4H, V13.4H
    SQRSHRN V25.8B, V9.8H, #5
    SRSHL  V16.4H, V16.4H, V0.4H
    SQXTUN2  V29.8H, V27.4S
    SABAL  V0.8H, V29.8B, V29.8B
    SQDMULH  V20.8H, V16.8H, V4.H[0x0]
    SQDMULH  V5.2S, V24.2S, V23.S[0x2]
    SMLAL V3.4S, V5.4H, V0.H[0x3]
    SQXTUN  V5.8B, V3.8H
    SQDMULH H8, H6, V5.H[0x1]
    SADALP  V3.8H, V14.16B
    SXTL V22.2D, V25.2S
    SRSHL  V25.16B, V29.16B, V20.16B
    SQSHLU  V7.8B, V3.8B, #0x2
    SQDMULH  V4.4S, V7.4S, V7.4S
    SQSHRN V20.8B, V29.8H, #5
    SQRSHRN V0.4H, V22.4S, #8
    SQRSHRN V9.2S, V28.2D, #10
    SRSHR  V28.8B, V3.8B, #7
    SADALP  V29.8H, V8.16B
    SSHLL V2.8H, V29.8B, #0x7
    SMULL V27.4S, V9.4H, V9.H[0x6]
    SMOV  X9, V5.S[0x2]
    SADDW  V8.2D, V0.2D, V0.2S
    SMLSL2 V9.4S, V4.8H, V2.H[0x6]
    SQSHL  V2.8B, V25.8B, #0x2
    SQXTN2  V7.16B, V27.8H
    SXTL V12.8H, V2.8B
    SQDMLAL S29, H20, V15.H[0x7]
    SQDMLSL S26, H30, V7.H[0x1]
    SSHL  V15.8B, V27.8B, V22.8B
    SADDW2  V7.8H, V12.8H, V28.16B
    SSHR  V3.8H, V15.8H, #4
    SQSHLU  V20.8H, V9.8H, #0xb
    SMLSL2 V30.2D, V9.4S, V26.S[0x2]
    SQSHRUN2 V25.16B, V3.8H, #1
    SQDMLSL2  V5.2D, V2.4S, V29.4S
    SQDMULL D22, S20, V31.S[0x0]
    SABDL2  V4.2D, V2.4S, V19.4S
    SQNEG  V2.2D, V4.2D
    SMLSL V9.4S, V25.4H, V7.H[0x0]
    SSHR  V26.8B, V5.8B, #8
    SMULL  V12.8H, V26.8B, V22.8B
    SQSHRN V31.4H, V9.4S, #10
    SQDMLSL V29.2D, V22.2S, V12.S[0x0]
    SQDMULL2  V29.4S, V3.8H, V30.8H
    SSUBW2  V7.4S, V2.4S, V20.8H
    SQXTN  V0.4H, V29.4S
    SMULL2  V5.8H, V7.16B, V0.16B
    SQSHRUN V20.4H, V27.4S, #14
    SMULL  V27.2D, V20.2S, V5.2S
    SMOV  X25, V20.B[0xa]
    SQDMLSL V2.2D, V17.2S, V24.S[0x3]
    SADDL2  V5.8H, V5.16B, V20.16B
    SADDLV  S8, V27.8H
    SABD  V15.8H, V23.8H, V5.8H
    SABAL  V29.4S, V3.4H, V2.4H
    SMLSL2 V27.4S, V29.8H, V15.H[0x5]
    SQDMULL2  V26.4S, V8.8H, V23.8H
    SQDMLAL  V7.2D, V31.2S, V7.2S
    SQRSHRUN2 V5.16B, V7.8H, #4
    SABAL  V3.4S, V27.4H, V8.4H
    SQRDMULH  V9.4H, V26.4H, V14.4H
    SQRSHRN V24.2S, V5.2D, #2
    SMLAL2 V8.4S, V3.8H, V0.H[0x4]
    SQDMLSL2 V26.4S, V8.8H, V8.H[0x4]
    SADDL2  V2.8H, V26.16B, V29.16B
    SQRSHRN2 V23.4S, V1.2D, #4
    SMULL2 V4.4S, V9.8H, V8.H[0x2]
    SRSHR  V20.8H, V24.8H, #13
    SSHLL V3.4S, V9.4H, #0x4
    SQDMLAL  V9.4S, V10.4H, V22.4H
    SQRSHRN V17.2S, V7.2D, #13
    SRSRA V29.2D, V17.2D, #50
    SMLSL V28.2D, V29.2S, V29.S[0x1]
    SSHR  V17.4H, V8.4H, #14
    SMLAL  V11.4S, V17.4H, V23.4H
    SQSUB  V27.16B, V3.16B, V4.16B
    SMULL2  V14.8H, V27.16B, V11.16B
    SQDMLAL D27, S20, V9.S[0x0]
    SMULL V3.2D, V10.2S, V26.S[0x3]
    SQDMLSL D26, S14, V27.S[0x2]
    SSRA  V29.4S, V6.4S, #13
    SABDL2  V27.4S, V1.8H, V26.8H
    SXTL V23.8H, V3.8B
    SQSHRN2 V15.16B, V9.8H, #4
    SQDMLSL2 V2.2D, V29.4S, V23.S[0x1]
    SADDL  V10.4S, V10.4H, V15.4H
    SSUBL  V26.8H, V2.8B, V0.8B
    SSHL  V7.2S, V6.2S, V29.2S
    SRSHR  V23.8B, V27.8B, #5
    SADALP  V11.4H, V26.8B
    SXTL2 V22.2D, V0.4S
    SQRDMULH  V26.4S, V23.4S, V27.S[0x2]
    SQSHRN V0.2S, V14.2D, #18
    SRSHR  V3.8H, V0.8H, #13
    SQRDMULH  V16.2S, V3.2S, V11.S[0x0]
    SQDMLAL2  V11.2D, V26.4S, V10.4S
    SSHLL2 V0.2D, V11.4S, #0x6
    SQXTN2  V1.8H, V22.4S
    SSUBW  V14.4S, V18.4S, V7.4H
    SQDMLSL2 V15.2D, V12.4S, V0.S[0x1]
    SQSHRN V3.8B, V28.8H, #3
    SQRSHRN V29.2S, V7.2D, #14
    SQSHRN2 V2.8H, V26.4S, #10
    SXTL V26.8H, V16.8B
    SQSHRN V10.2S, V1.2D, #13
    SHSUB  V4.4S, V15.4S, V3.4S
    SQSHL  V3.2S, V14.2S, #0x4
    SSHLL2 V15.2D, V29.4S, #0x14
    SQRDMULH  V23.4S, V14.4S, V10.4S
    SQSHLU V29.2D, V15.2D, #0x1d
    SQRSHRUN V0.4H, V2.4S, #15
    SABAL2  V28.4S, V28.8H, V1.8H
    SQSHLU  V22.4H, V16.4H, #0x0
    SQDMLAL  V18.2D, V28.2S, V4.2S
    SADDL  V2.4S, V22.4H, V18.4H
    SQDMLSL V14.2D, V28.2S, V0.S[0x1]
    SADDL  V11.2D, V26.2S, V20.2S
    SMLAL V4.4S, V23.4H, V13.H[0x7]
    SMULL  V19.4S, V4.4H, V19.4H
    SQRSHRUN2 V18.16B, V28.8H, #1
    SQDMULH S20, S31, V29.S[0x2]
    SQSHRN2 V0.8H, V3.4S, #15
    SQDMLAL S3, H12, V0.H[0x6]
    SQXTUN  V23.4H, V3.4S
    SQRSHRN V29.4H, V27.4S, #12
    SSRA V10.2D, V20.2D, #26
    SQDMLSL2  V7.2D, V9.4S, V29.4S
    SQSHRN V9.4H, V18.4S, #1
    SRSRA  V4.8H, V19.8H, #4
    SQXTUN  V13.8B, V11.8H
    SQRSHRN2 V31.8H, V10.4S, #13
    SSHLL V0.4S, V16.4H, #0x4
    SMULL V18.2D, V14.2S, V6.S[0x0]
    SSHLL2 V29.4S, V26.8H, #0xb
    SMULL V11.4S, V7.4H, V7.H[0x6]
    SRSRA  V31.16B, V23.16B, #5
    SADDLP  V12.4H, V24.8B
    SQDMULL  V10.4S, V18.4H, V18.4H
    SSUBW2  V26.2D, V2.2D, V3.4S
    SQDMLSL2  V12.4S, V4.8H, V26.8H
    SRSHR V28.2D, V11.2D, #12
    SMOV W2, V23.B[0xc]
    SRHADD  V31.8B, V9.8B, V13.8B
    SQRDMULH  V30.4S, V1.4S, V29.S[0x3]
    SMULL2  V16.2D, V30.4S, V10.4S
    SQSHL  V14.2S, V4.2S, #0x3
    SRSRA  V6.2S, V0.2S, #19
    SQSHL  V3.2S, V18.2S, #0x11
    SMLAL2  V26.4S, V19.8H, V28.8H
    SQRSHRN2 V10.4S, V16.2D, #8
    SHSUB  V10.8B, V9.8B, V31.8B
    SQSHLU  V19.4H, V14.4H, #0x9
    SXTL V0.8H, V24.8B
    SRSHR V18.2D, V18.2D, #30
    SADALP  V27.2D, V6.4S
    SQDMLSL2  V24.2D, V18.4S, V10.4S
    SQDMULL V29.2D, V24.2S, V24.S[0x3]
    SMOV W18, V5.H[0x2]
    SSRA  V6.16B, V7.16B, #4
    SQSHRN V28.2S, V26.2D, #15
    SMLSL2  V31.4S, V3.8H, V0.8H
    SMOV  X6, V29.B[0x0]
    SQDMULH  V13.2S, V25.2S, V28.S[0x2]
    SMLSL V30.2D, V22.2S, V17.S[0x1]
    SMOV W4, V31.B[0x4]
    SQRSHRN V1.8B, V27.8H, #5
    SMLSL V28.2D, V30.2S, V11.S[0x0]
    SQDMULH S25, S28, V19.S[0x3]
    SSHR  V30.8H, V6.8H, #12
    SQDMLSL V14.4S, V13.4H, V1.H[0x4]
    SHSUB  V3.16B, V8.16B, V4.16B
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_8
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x20, LSL #0
    SUB  X26, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X26, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X29, FPSR
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x800, LSL #16
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D0
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D1
    MOVZ  X26, #0x8080, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D2
    MOVZ  X26, #0xb7c6, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0x8daa, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D3
    MOVZ  X26, #0x8, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D4
    MOVZ  X26, #0xfff0, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D9
    MOVZ  X26, #0x8000, LSL #0
    MOVK  X26, #0x40, LSL #32
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D10
    MOVZ  X26, #0xe000, LSL #0
    MOVK  X26, #0x10, LSL #32
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D14
    MOVZ  X26, #0xff80, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D18
    MOVZ  X26, #0xd618, LSL #0
    MOVK  X26, #0x5e96, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D26
    MOVZ  X26, #0xb7c6, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0x8daa, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D27
    MOVZ  X26, #0xb4b4, LSL #0
    MOVK  X26, #0xb4b4, LSL #16
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D28
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #16
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D30
    MOVZ  X26, #0x5, LSL #0
    MOVK  X26, #0x5, LSL #16
    MOVK  X26, #0x5, LSL #32
    MOVK  X26, #0x5, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X29, D31
    MOVZ  X26, #0xc000, LSL #0
    MOVK  X26, #0x20, LSL #32
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X2
    FMOV  V2.D[1], X27
    FMOV  D3, X4
    FMOV  V3.D[1], X25
    FMOV  D4, X22
    FMOV  V4.D[1], X26
    FMOV  D5, X21
    FMOV  V5.D[1], X25
    FMOV  D6, X24
    FMOV  V6.D[1], X6
    FMOV  D7, X25
    FMOV  V7.D[1], X27
    FMOV  D8, X7
    FMOV  V8.D[1], X17
    FMOV  D9, X7
    FMOV  V9.D[1], X28
    FMOV  D10, X6
    FMOV  V10.D[1], X8
    FMOV  D11, X19
    FMOV  V11.D[1], X18
    FMOV  D12, X28
    FMOV  V12.D[1], X27
    FMOV  D13, X17
    FMOV  V13.D[1], X22
    FMOV  D14, X3
    FMOV  V14.D[1], X8
    FMOV  D15, X10
    FMOV  V15.D[1], X29
    FMOV  D16, X9
    FMOV  V16.D[1], X23
    FMOV  D17, X9
    FMOV  V17.D[1], X18
    FMOV  D18, X22
    FMOV  V18.D[1], X16
    FMOV  D19, X3
    FMOV  V19.D[1], X24
    FMOV  D20, X26
    FMOV  V20.D[1], X3
    FMOV  D21, X21
    FMOV  V21.D[1], X5
    FMOV  D22, X29
    FMOV  V22.D[1], X10
    FMOV  D23, X25
    FMOV  V23.D[1], X29
    FMOV  D24, X26
    FMOV  V24.D[1], X19
    FMOV  D25, X25
    FMOV  V25.D[1], X27
    FMOV  D26, X6
    FMOV  V26.D[1], X21
    FMOV  D27, X5
    FMOV  V27.D[1], X23
    FMOV  D28, X16
    FMOV  V28.D[1], X10
    FMOV  D29, X19
    FMOV  V29.D[1], X16
    FMOV  D30, X20
    FMOV  V30.D[1], X17
    FMOV  D31, X20
    FMOV  V31.D[1], X20
    MOVZ  X3, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_9:
    SQRDMULH  V17.4H, V24.4H, V22.4H
    SQRDMULH H24, H18, V15.H[0x5]
    SXTL2 V30.4S, V25.8H
    SMLAL V0.2D, V25.2S, V17.S[0x2]
    SQDMLSL V21.4S, V30.4H, V0.H[0x2]
    SADDL  V20.8H, V28.8B, V29.8B
    SRSHR  V12.4S, V20.4S, #27
    SQDMLSL2  V22.2D, V21.4S, V26.4S
    SXTL2 V5.4S, V23.8H
    SMLSL2 V20.2D, V22.4S, V5.S[0x2]
    SSHLL2 V31.8H, V18.16B, #0x3
    SADDLV  D25, V8.4S
    SHSUB  V10.4H, V20.4H, V25.4H
    SMOV W23, V10.H[0x4]
    SMULL  V28.4S, V12.4H, V12.4H
    SQSHRUN2 V29.4S, V28.2D, #2
    SQRSHRUN V18.2S, V29.2D, #8
    SQDMULL2 V0.4S, V24.8H, V13.H[0x7]
    SQSHRUN2 V20.8H, V31.4S, #4
    SXTL2 V10.4S, V18.8H
    SSUBL2  V17.8H, V0.16B, V20.16B
    SQSHRN V28.8B, V3.8H, #8
    SSRA V12.2D, V10.2D, #6
    SQDMULH H3, H9, V6.H[0x4]
    SQDMULL2  V10.4S, V19.8H, V12.8H
    SMOV W24, V28.B[0x1]
    SQADD  V6.8H, V3.8H, V17.8H
    SQDMULH  V26.4H, V28.4H, V14.H[0x6]
    SQADD  V24.4S, V6.4S, V20.4S
    SQRDMULH  V30.2S, V9.2S, V6.S[0x3]
    SSHLL2 V17.2D, V8.4S, #0xc
    SQXTUN2  V8.8H, V4.4S
    SQRSHRUN V18.8B, V14.8H, #2
    SSHR  V13.8B, V18.8B, #4
    SQDMLSL V3.4S, V21.4H, V11.H[0x5]
    SSRA  V29.4S, V27.4S, #4
    SRSHR  V7.16B, V30.16B, #6
    SQDMLAL D8, S29, V18.S[0x2]
    SADDLV  H0, V28.8B
    SQSHLU  V12.8B, V13.8B, #0x0
    SMLAL V14.4S, V3.4H, V7.H[0x7]
    SQRDMULH  V4.2S, V1.2S, V31.S[0x0]
    SQDMULL2 V7.4S, V0.8H, V10.H[0x7]
    SRSHR V30.2D, V7.2D, #32
    SRSHR  V13.4S, V8.4S, #22
    SQRSHRUN2 V21.16B, V12.8H, #4
    SQRSHRN V31.8B, V21.8H, #7
    SQSHRUN V11.8B, V30.8H, #4
    SQSHRN2 V1.16B, V4.8H, #6
    SMLSL2 V4.4S, V25.8H, V0.H[0x1]
    SQDMLAL  V18.2D, V14.2S, V4.2S
    SQDMULH  V19.4H, V1.4H, V4.H[0x4]
    SQDMLSL V28.4S, V10.4H, V11.H[0x7]
    SMULL  V12.4S, V19.4H, V15.4H
    SQDMULL2  V4.2D, V14.4S, V24.4S
    SSRA  V7.16B, V13.16B, #1
    SQRDMULH  V14.2S, V31.2S, V26.S[0x0]
    SQRSHRN2 V6.4S, V17.2D, #17
    SQSHRN2 V9.8H, V14.4S, #2
    SQDMULL  V24.4S, V6.4H, V12.4H
    SQDMULH S29, S7, V18.S[0x3]
    SQSHRUN V1.2S, V28.2D, #20
    SHSUB  V22.4S, V26.4S, V24.4S
    SRSHR  V14.8H, V1.8H, #9
    SQDMLSL V6.4S, V21.4H, V15.H[0x7]
    SMLSL2  V25.4S, V6.8H, V23.8H
    SMOV  X16, V17.S[0x0]
    SQDMULL2  V2.2D, V4.4S, V14.4S
    SSUBW2  V13.8H, V2.8H, V9.16B
    SRSRA  V16.4S, V22.4S, #32
    SMOV W10, V25.H[0x4]
    SADDW2  V2.8H, V29.8H, V16.16B
    SQNEG  V18.4S, V5.4S
    SSUBL2  V16.2D, V24.4S, V31.4S
    SQADD  V16.2D, V17.2D, V28.2D
    SXTL2 V22.4S, V13.8H
    SMULL  V16.2D, V22.2S, V24.2S
    SQSHRUN V9.4H, V25.4S, #8
    SMLSL2  V17.2D, V7.4S, V2.4S
    SSRA  V10.8B, V14.8B, #5
    SSHL  V14.8B, V9.8B, V26.8B
    SQDMULH  V26.8H, V8.8H, V8.8H
    SMULL  V19.4S, V27.4H, V17.4H
    SMLAL V29.2D, V25.2S, V6.S[0x0]
    SSRA  V15.4S, V20.4S, #17
    SQDMLAL D17, S16, V30.S[0x2]
    SQDMULL2 V2.4S, V29.8H, V14.H[0x1]
    SQXTUN2  V24.4S, V10.2D
    SQRSHRN2 V31.16B, V2.8H, #7
    SMULL2 V1.2D, V7.4S, V17.S[0x2]
    SQSHLU V4.2D, V31.2D, #0x1b
    SQDMLAL D22, S10, V14.S[0x1]
    SQRSHRN V13.2S, V22.2D, #4
    SQSHL  V24.4S, V25.4S, #0x12
    SABAL  V5.4S, V1.4H, V26.4H
    SQDMULH  V22.2S, V18.2S, V19.S[0x2]
    SQDMLAL2 V14.2D, V4.4S, V15.S[0x2]
    SMLSL2  V18.8H, V22.16B, V22.16B
    SQSHRUN2 V30.8H, V30.4S, #1
    SADDLV  D22, V14.4S
    SQRDMULH  V20.4H, V18.4H, V6.H[0x2]
    SQRDMULH S1, S5, V2.S[0x1]
    SSHLL V16.4S, V22.4H, #0xf
    SMULL V20.2D, V24.2S, V9.S[0x2]
    SQDMULL2 V17.2D, V13.4S, V13.S[0x1]
    SADDLV  D7, V17.4S
    SRSRA  V19.8H, V30.8H, #5
    SMULL  V2.8H, V27.8B, V1.8B
    SQRSHRUN V22.4H, V8.4S, #7
    SQSHRUN V19.8B, V27.8H, #1
    SMLAL V5.2D, V8.2S, V7.S[0x0]
    SRSHR  V25.8H, V17.8H, #7
    SSRA V15.2D, V25.2D, #6
    SADDW  V9.2D, V9.2D, V12.2S
    SQDMLAL S12, H5, V15.H[0x1]
    SMLSL2 V6.4S, V19.8H, V13.H[0x0]
    SMULL2 V8.2D, V22.4S, V6.S[0x0]
    SQSHRN2 V24.8H, V8.4S, #3
    SQXTN2  V8.8H, V12.4S
    SQSHL V25.2D, V9.2D, #0x9
    SRSRA  V27.4H, V9.4H, #16
    SADDLV  D6, V4.4S
    SQNEG  V10.8H, V16.8H
    SXTL2 V20.4S, V8.8H
    SRSHR  V8.4S, V6.4S, #3
    SADDLV  S17, V8.8H
    SQRDMULH  V16.2S, V10.2S, V17.2S
    SQRSHL  V26.16B, V27.16B, V20.16B
    SXTL V19.2D, V21.2S
    SRSRA  V17.2S, V1.2S, #14
    SSRA  V22.4H, V30.4H, #7
    SMULL2  V13.4S, V25.8H, V22.8H
    SSUBL2  V31.4S, V17.8H, V13.8H
    SQSHLU  V13.8B, V26.8B, #0x7
    SRSHL  V10.4S, V13.4S, V31.4S
    SQSHLU  V15.8B, V10.8B, #0x1
    SXTL2 V7.8H, V15.16B
    SMOV W5, V19.H[0x1]
    SQDMULL  V5.4S, V15.4H, V7.4H
    SXTL V15.2D, V20.2S
    SSHLL2 V21.8H, V15.16B, #0x4
    SMOV  X24, V16.S[0x1]
    SQRSHRN V16.2S, V5.2D, #17
    SMLAL  V26.8H, V4.8B, V16.8B
    SMOV  X26, V9.B[0xe]
    SQADD  V22.4H, V21.4H, V21.4H
    SQDMULH  V31.2S, V18.2S, V27.S[0x2]
    SMLSL V7.2D, V22.2S, V24.S[0x1]
    SQDMULL S18, H26, V7.H[0x2]
    SMLAL2 V16.4S, V25.8H, V3.H[0x5]
    SSHR  V20.2S, V6.2S, #1
    SMULL V15.4S, V23.4H, V10.H[0x7]
    SMOV W16, V2.B[0x3]
    SQSHRUN V5.2S, V0.2D, #25
    SQSHRN V25.2S, V10.2D, #15
    SMLAL  V27.8H, V24.8B, V12.8B
    SRSHL  V0.4H, V6.4H, V26.4H
    SADDW  V10.2D, V15.2D, V23.2S
    SSHLL V23.8H, V5.8B, #0x5
    SQSHRN2 V31.16B, V10.8H, #7
    SQRDMULH  V24.8H, V10.8H, V0.H[0x3]
    SSUBW  V21.2D, V25.2D, V13.2S
    SQSHL  V25.8B, V23.8B, #0x1
    SADDLV  D0, V27.4S
    SQRSHRUN2 V7.8H, V7.4S, #13
    SQSHLU  V12.16B, V20.16B, #0x2
    SMLAL2 V9.4S, V18.8H, V12.H[0x4]
    SSHLL2 V15.8H, V4.16B, #0x6
    SQDMLSL V18.2D, V27.2S, V19.S[0x0]
    SSHR V26.2D, V21.2D, #39
    SMLSL V22.2D, V31.2S, V26.S[0x1]
    SQRSHRN2 V27.8H, V28.4S, #10
    SADDLP  V7.2D, V9.4S
    SQDMULH  V20.4H, V24.4H, V7.H[0x4]
    SRSHR  V0.4S, V20.4S, #4
    SRSRA  V9.16B, V25.16B, #2
    SQSHRUN V7.8B, V5.8H, #3
    SQDMULH  V24.8H, V7.8H, V0.8H
    SQRSHRUN2 V30.16B, V18.8H, #8
    SQDMLAL V1.2D, V16.2S, V16.S[0x1]
    SQSHLU  V7.2S, V29.2S, #0x1a
    SQRSHRUN V26.2S, V30.2D, #30
    SRHADD  V18.4H, V0.4H, V27.4H
    SQSHRUN2 V21.8H, V2.4S, #10
    SQDMULL  V16.2D, V21.2S, V24.2S
    SRSHR  V25.4S, V16.4S, #4
    SQRDMULH  V6.2S, V26.2S, V1.S[0x0]
    SRSHR  V4.16B, V11.16B, #8
    SQSHRN V29.4H, V18.4S, #13
    SQSHLU  V31.16B, V29.16B, #0x7
    SMULL V29.4S, V2.4H, V0.H[0x4]
    SSHLL2 V27.2D, V22.4S, #0x3
    SQSHLU  V6.4S, V7.4S, #0x19
    SMLAL  V12.2D, V29.2S, V31.2S
    SSHLL2 V19.8H, V27.16B, #0x3
    SRSRA  V31.4H, V9.4H, #1
    SQSHL  V29.8H, V1.8H, #0x1
    SSHR  V7.4S, V11.4S, #28
    SQDMLSL S2, H12, V6.H[0x5]
    SADDLP  V1.2D, V29.4S
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_9
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X2, FPSR
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x800, LSL #16
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x290f, LSL #0
    MOVK  X2, #0xf7ff, LSL #16
    MOVK  X2, #0xb49d, LSL #32
    MOVK  X2, #0x7e3e, LSL #48
    MOVZ  X3, #0xd14c, LSL #0
    MOVK  X3, #0xfc26, LSL #16
    MOVK  X3, #0xf62e, LSL #32
    MOVK  X3, #0x44f9, LSL #48
    MOVZ  X4, #0xd22c, LSL #0
    MOVK  X4, #0xfc61, LSL #16
    MOVK  X4, #0xee62, LSL #32
    MOVK  X4, #0xb526, LSL #48
    MOVZ  X5, #0x6d97, LSL #0
    MOVK  X5, #0xcb37, LSL #16
    MOVK  X5, #0xd19b, LSL #32
    MOVK  X5, #0x37bc, LSL #48
    MOVZ  X6, #0xc898, LSL #0
    MOVK  X6, #0x7c2c, LSL #16
    MOVK  X6, #0x7ebf, LSL #32
    MOVK  X6, #0x2368, LSL #48
    MOVZ  X7, #0x735c, LSL #0
    MOVK  X7, #0xd43d, LSL #16
    MOVK  X7, #0x58a4, LSL #32
    MOVK  X7, #0xddd9, LSL #48
    MOVZ  X8, #0xb00f, LSL #0
    MOVK  X8, #0xb7ad, LSL #16
    MOVK  X8, #0x636b, LSL #32
    MOVK  X8, #0xb87c, LSL #48
    MOVZ  X9, #0x6e39, LSL #0
    MOVK  X9, #0x2741, LSL #16
    MOVK  X9, #0xf7e9, LSL #32
    MOVK  X9, #0xf758, LSL #48
    MOVZ  X10, #0x75a3, LSL #0
    MOVK  X10, #0x87e9, LSL #16
    MOVK  X10, #0x4585, LSL #32
    MOVK  X10, #0xee1b, LSL #48
    MOVZ  X16, #0xa51d, LSL #0
    MOVK  X16, #0xfed5, LSL #16
    MOVK  X16, #0x1616, LSL #32
    MOVK  X16, #0xe935, LSL #48
    MOVZ  X17, #0xf41b, LSL #0
    MOVK  X17, #0xa57a, LSL #16
    MOVK  X17, #0x8fb5, LSL #32
    MOVK  X17, #0x4964, LSL #48
    MOVZ  X18, #0x9a79, LSL #0
    MOVK  X18, #0xc939, LSL #16
    MOVK  X18, #0xca72, LSL #32
    MOVK  X18, #0x6a5f, LSL #48
    MOVZ  X19, #0x9a9b, LSL #0
    MOVK  X19, #0xbc35, LSL #16
    MOVK  X19, #0xb6f7, LSL #32
    MOVK  X19, #0x5444, LSL #48
    MOVZ  X20, #0xef98, LSL #0
    MOVK  X20, #0x9e0d, LSL #16
    MOVK  X20, #0xc20a, LSL #32
    MOVK  X20, #0x657f, LSL #48
    MOVZ  X21, #0xf27e, LSL #0
    MOVK  X21, #0xb3df, LSL #16
    MOVK  X21, #0x6679, LSL #32
    MOVK  X21, #0xc3a1, LSL #48
    MOVZ  X22, #0xa08a, LSL #0
    MOVK  X22, #0x9d55, LSL #16
    MOVK  X22, #0xd46d, LSL #32
    MOVK  X22, #0x151b, LSL #48
    MOVZ  X23, #0xbb3a, LSL #0
    MOVK  X23, #0xcfab, LSL #16
    MOVK  X23, #0xbae3, LSL #32
    MOVK  X23, #0x16d8, LSL #48
    MOVZ  X24, #0x6ef0, LSL #0
    MOVK  X24, #0xfa83, LSL #16
    MOVK  X24, #0x2cd9, LSL #32
    MOVK  X24, #0x90b2, LSL #48
    MOVZ  X25, #0xa10d, LSL #0
    MOVK  X25, #0x94df, LSL #16
    MOVK  X25, #0x4b2e, LSL #32
    MOVK  X25, #0x667b, LSL #48
    MOVZ  X26, #0xd3e, LSL #0
    MOVK  X26, #0x2ac9, LSL #16
    MOVK  X26, #0x1bb, LSL #32
    MOVK  X26, #0x945a, LSL #48
    MOVZ  X27, #0xea13, LSL #0
    MOVK  X27, #0x9b30, LSL #16
    MOVK  X27, #0x5845, LSL #32
    MOVK  X27, #0xf1c7, LSL #48
    MOVZ  X28, #0x6363, LSL #0
    MOVK  X28, #0xc810, LSL #16
    MOVK  X28, #0xa76c, LSL #32
    MOVK  X28, #0xa2a8, LSL #48
    MOVZ  X29, #0xc645, LSL #0
    MOVK  X29, #0x1840, LSL #16
    MOVK  X29, #0x8530, LSL #32
    MOVK  X29, #0xdd25, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X16
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X8
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X9
    FMOV  V4.D[1], X18
    FMOV  D5, X8
    FMOV  V5.D[1], X25
    FMOV  D6, X23
    FMOV  V6.D[1], X17
    FMOV  D7, X6
    FMOV  V7.D[1], X6
    FMOV  D8, X24
    FMOV  V8.D[1], X24
    FMOV  D9, X19
    FMOV  V9.D[1], X17
    FMOV  D10, X3
    FMOV  V10.D[1], X26
    FMOV  D11, X24
    FMOV  V11.D[1], X25
    FMOV  D12, X26
    FMOV  V12.D[1], X7
    FMOV  D13, X8
    FMOV  V13.D[1], X27
    FMOV  D14, X19
    FMOV  V14.D[1], X19
    FMOV  D15, X20
    FMOV  V15.D[1], X5
    FMOV  D16, X7
    FMOV  V16.D[1], X27
    FMOV  D17, X19
    FMOV  V17.D[1], X16
    FMOV  D18, X19
    FMOV  V18.D[1], X23
    FMOV  D19, X24
    FMOV  V19.D[1], X10
    FMOV  D20, X26
    FMOV  V20.D[1], X17
    FMOV  D21, X27
    FMOV  V21.D[1], X5
    FMOV  D22, X10
    FMOV  V22.D[1], X5
    FMOV  D23, X9
    FMOV  V23.D[1], X17
    FMOV  D24, X6
    FMOV  V24.D[1], X5
    FMOV  D25, X6
    FMOV  V25.D[1], X8
    FMOV  D26, X7
    FMOV  V26.D[1], X8
    FMOV  D27, X2
    FMOV  V27.D[1], X7
    FMOV  D28, X7
    FMOV  V28.D[1], X9
    FMOV  D29, X8
    FMOV  V29.D[1], X8
    FMOV  D30, X10
    FMOV  V30.D[1], X29
    FMOV  D31, X7
    FMOV  V31.D[1], X17
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_10:
    SABA  V29.4H, V25.4H, V31.4H
    SABDL  V14.8H, V23.8B, V26.8B
    SQDMULL V20.2D, V27.2S, V25.S[0x2]
    SABD  V7.2S, V26.2S, V29.2S
    SQSHL  V21.4H, V24.4H, V12.4H
    SQDMULL  V2.2D, V21.2S, V21.2S
    SQRDMULH  V27.2S, V16.2S, V2.S[0x3]
    SQSHLU  V22.4H, V22.4H, #0xb
    SSHR  V22.8H, V30.8H, #5
    SADDW  V10.8H, V14.8H, V22.8B
    SMOV  X3, V15.H[0x7]
    SSHLL2 V7.4S, V17.8H, #0xb
    SQSHRN2 V21.4S, V10.2D, #15
    SQXTN  V21.8B, V16.8H
    SABAL  V26.8H, V20.8B, V2.8B
    SMULL2 V25.4S, V21.8H, V13.H[0x2]
    SQRDMULH H17, H27, V7.H[0x7]
    SQSHRUN V27.2S, V17.2D, #15
    SRSRA  V30.2S, V10.2S, #12
    SQDMLAL V31.4S, V27.4H, V4.H[0x3]
    SMLAL2 V10.2D, V0.4S, V14.S[0x3]
    SQXTUN2  V8.4S, V31.2D
    SQDMLAL  V0.4S, V25.4H, V25.4H
    SQRSHRUN2 V31.4S, V30.2D, #13
    SXTL2 V7.8H, V26.16B
    SQDMLSL2 V25.2D, V8.4S, V0.S[0x0]
    SQRSHL  V17.4H, V1.4H, V25.4H
    SXTL V23.8H, V23.8B
    SQABS  V13.2D, V15.2D
    SSHR  V26.2S, V17.2S, #3
    SABA  V15.8B, V21.8B, V13.8B
    SQDMLAL V30.2D, V15.2S, V15.S[0x3]
    SQDMLAL V0.2D, V26.2S, V23.S[0x2]
    SQDMLAL2 V0.4S, V30.8H, V7.H[0x2]
    SQSHLU  V20.8B, V0.8B, #0x3
    SABA  V15.16B, V20.16B, V20.16B
    SQADD  V8.2D, V31.2D, V28.2D
    SQRDMULH H25, H20, V10.H[0x5]
    SABDL  V1.8H, V15.8B, V4.8B
    SQDMLAL  V21.2D, V1.2S, V1.2S
    SSHR V26.2D, V14.2D, #36
    SSUBW  V10.4S, V19.4S, V25.4H
    SRSHR  V25.2S, V26.2S, #13
    SHSUB  V7.8H, V10.8H, V25.8H
    SQXTN  V0.4H, V8.4S
    SQRSHRUN2 V31.4S, V7.2D, #25
    SMLAL2  V17.2D, V4.4S, V31.4S
    SQNEG  V13.16B, V20.16B
    SMULL  V29.8H, V26.8B, V17.8B
    SHADD  V25.16B, V18.16B, V19.16B
    SSHLL2 V18.4S, V14.8H, #0x1
    SQDMULL2 V28.2D, V0.4S, V13.S[0x1]
    SQDMLAL2 V10.4S, V27.8H, V7.H[0x1]
    SMULL V14.4S, V10.4H, V6.H[0x1]
    SQDMLSL V14.2D, V28.2S, V29.S[0x2]
    SSHLL2 V19.2D, V29.4S, #0x3
    SQRDMULH  V11.8H, V21.8H, V15.8H
    SABAL  V1.8H, V25.8B, V19.8B
    SQSHLU  V7.4H, V1.4H, #0xe
    SRSHR  V28.8B, V22.8B, #4
    SQSHRUN V2.2S, V12.2D, #15
    SMLSL2 V12.4S, V30.8H, V14.H[0x6]
    SQDMLSL2 V30.2D, V15.4S, V18.S[0x2]
    SQSHRN2 V0.8H, V2.4S, #6
    SRSRA  V30.4H, V19.4H, #12
    SQDMLAL V15.4S, V7.4H, V2.H[0x3]
    SMLAL2  V19.4S, V13.8H, V12.8H
    SQSHRUN V18.2S, V19.2D, #3
    SRSHR V29.2D, V28.2D, #45
    SRSHL  V12.8B, V15.8B, V11.8B
    SADDL2  V6.2D, V11.4S, V18.4S
    SMLSL V15.4S, V0.4H, V0.H[0x2]
    SQRSHRUN V1.2S, V25.2D, #5
    SQSHRUN V19.8B, V3.8H, #6
    SQSHRN2 V28.8H, V6.4S, #7
    SQSHRUN2 V19.4S, V19.2D, #24
    SQDMLSL2  V7.2D, V30.4S, V30.4S
    SQRDMULH  V0.4H, V1.4H, V19.4H
    SQDMLSL  V1.4S, V28.4H, V12.4H
    SUQADD  V25.4H, V0.4H
    SQDMULL D27, S27, V15.S[0x0]
    SABDL2  V7.4S, V1.8H, V1.8H
    SMOV  X29, V1.S[0x1]
    SQDMLSL D3, S27, V25.S[0x3]
    SADDL  V0.8H, V29.8B, V13.8B
    SQXTUN  V1.2S, V12.2D
    SQSHRN V25.2S, V7.2D, #19
    SMOV W17, V3.B[0x1]
    SRSHR  V28.8H, V14.8H, #3
    SQXTUN  V7.2S, V0.2D
    SMLSL  V8.8H, V7.8B, V1.8B
    SXTL V6.8H, V28.8B
    SSUBL2  V1.4S, V30.8H, V24.8H
    SSUBW  V8.2D, V6.2D, V18.2S
    SSRA  V13.8B, V2.8B, #6
    SQDMULL  V3.4S, V29.4H, V5.4H
    SXTL2 V7.8H, V1.16B
    SQRDMULH  V27.2S, V25.2S, V13.S[0x1]
    SQRSHRUN V1.4H, V8.4S, #9
    SRSHR V13.2D, V27.2D, #56
    SQDMLAL2  V15.4S, V3.8H, V1.8H
    SRSRA V1.2D, V7.2D, #14
    SQSHL  V5.4H, V15.4H, #0xe
    SQXTN2  V15.16B, V27.8H
    SSHR  V6.2S, V6.2S, #7
    SQSHLU  V2.16B, V21.16B, #0x5
    SQDMLAL2 V8.2D, V13.4S, V15.S[0x1]
    SQDMULH H0, H11, V2.H[0x1]
    SRHADD  V21.8H, V4.8H, V6.8H
    SMLAL2 V11.2D, V28.4S, V8.S[0x3]
    SSRA  V17.8B, V5.8B, #5
    SQSHL  V4.8B, V0.8B, #0x2
    SMULL2 V2.4S, V29.8H, V11.H[0x3]
    SQDMLSL2 V27.4S, V17.8H, V2.H[0x4]
    SQDMULL S11, H4, V10.H[0x7]
    SADDLV  D13, V31.4S
    SQDMULH  V17.2S, V11.2S, V21.S[0x0]
    SQSHRN V28.4H, V17.4S, #10
    SQSHRUN2 V0.4S, V28.2D, #9
    SSHR V15.2D, V0.2D, #10
    SQDMULL2 V18.4S, V2.8H, V1.H[0x7]
    SQRDMULH H31, H9, V12.H[0x4]
    SSRA  V9.2S, V15.2S, #2
    SQSHLU  V21.4H, V9.4H, #0x0
    SXTL V2.8H, V3.8B
    SRSHR  V8.16B, V31.16B, #2
    SQSHL  V1.2D, V13.2D, V2.2D
    SRSRA  V6.4S, V21.4S, #6
    SRSRA  V0.8B, V6.8B, #4
    SQSHRUN2 V21.8H, V0.4S, #15
    SMULL  V11.2D, V26.2S, V30.2S
    SQSHRUN V2.8B, V7.8H, #2
    SQDMLAL S9, H11, V8.H[0x6]
    SQDMLSL V4.4S, V1.4H, V12.H[0x1]
    SSHR  V13.4S, V2.4S, #7
    SMOV  X19, V9.S[0x1]
    SMLSL V15.2D, V18.2S, V24.S[0x3]
    SSHR V17.2D, V15.2D, #54
    SQRSHRN V26.4H, V13.4S, #7
    SQDMULH  V21.4S, V1.4S, V11.S[0x3]
    SQDMULH  V7.8H, V17.8H, V4.H[0x0]
    SXTL2 V11.2D, V3.4S
    SQRSHRUN2 V13.8H, V7.4S, #10
    SQSHRUN2 V4.4S, V26.2D, #28
    SSHR  V6.2S, V16.2S, #12
    SQSHL  V26.8B, V23.8B, V21.8B
    SQDMULL S18, H13, V6.H[0x0]
    SSRA V7.2D, V18.2D, #30
    SQDMLAL2 V12.2D, V27.4S, V26.S[0x1]
    SQSHLU V15.2D, V4.2D, #0x1c
    SMLAL2  V17.4S, V0.8H, V15.8H
    SRSRA  V30.2S, V7.2S, #29
    SMOV  X8, V6.H[0x0]
    SSHLL V23.2D, V16.2S, #0xb
    SQDMLSL2 V15.4S, V30.8H, V11.H[0x5]
    SQDMULH  V16.4S, V23.4S, V4.4S
    SMULL2 V30.2D, V10.4S, V15.S[0x0]
    SXTL V21.8H, V17.8B
    SXTL V14.8H, V16.8B
    SQRSHRN2 V27.4S, V21.2D, #16
    SQDMULL V6.4S, V30.4H, V14.H[0x0]
    SQSHRUN V0.4H, V27.4S, #8
    SQDMLSL2  V13.2D, V0.4S, V12.4S
    SSUBL  V21.8H, V1.8B, V7.8B
    SSHLL V15.4S, V18.4H, #0x3
    SSHLL2 V11.8H, V7.16B, #0x4
    SQRSHRN V12.4H, V14.4S, #8
    SQRSHRUN V3.4H, V18.4S, #16
    SADALP  V30.1D, V25.2S
    SQRSHRN2 V10.4S, V2.2D, #12
    SQRDMULH  V2.4H, V15.4H, V12.H[0x2]
    SRSHL  V3.8H, V10.8H, V3.8H
    SADDW2  V16.2D, V6.2D, V4.4S
    SQDMULH  V7.8H, V31.8H, V8.H[0x4]
    SMLSL V9.2D, V30.2S, V7.S[0x0]
    SQRDMULH  V18.8H, V11.8H, V31.8H
    SMULL2 V25.2D, V15.4S, V3.S[0x3]
    SQSHRUN V1.4H, V25.4S, #11
    SSUBL2  V7.8H, V18.16B, V27.16B
    SQDMLAL V7.4S, V21.4H, V2.H[0x6]
    SQRSHRN2 V10.8H, V4.4S, #13
    SQRSHRN2 V25.16B, V22.8H, #6
    SXTL2 V30.2D, V25.4S
    SQSHRN V24.4H, V18.4S, #13
    SQRSHRUN2 V18.4S, V1.2D, #11
    SRSRA  V3.4S, V30.4S, #18
    SQRSHRN V21.2S, V12.2D, #28
    SRSHR V28.2D, V16.2D, #23
    SQABS  V4.2D, V18.2D
    SQABS  V18.4H, V28.4H
    SQXTN2  V8.16B, V7.8H
    SQSHRUN V15.8B, V18.8H, #2
    SQRDMULH  V18.4S, V13.4S, V31.S[0x2]
    SMLAL  V19.8H, V18.8B, V9.8B
    SQRSHRUN V13.8B, V24.8H, #3
    SQDMULL  V11.4S, V13.4H, V15.4H
    SQDMULH H13, H8, V5.H[0x0]
    SQDMULH S25, S3, V13.S[0x2]
    SMOV  X2, V25.B[0xb]
    SMLAL  V12.4S, V10.4H, V11.4H
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_10
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x6d97, LSL #0
    MOVK  X26, #0xcb37, LSL #16
    MOVK  X26, #0xd19b, LSL #32
    MOVK  X26, #0x37bc, LSL #48
    SUB  X28, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xc898, LSL #0
    MOVK  X26, #0x7c2c, LSL #16
    MOVK  X26, #0x7ebf, LSL #32
    MOVK  X26, #0x2368, LSL #48
    SUB  X28, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x735c, LSL #0
    MOVK  X26, #0xd43d, LSL #16
    MOVK  X26, #0x58a4, LSL #32
    MOVK  X26, #0xddd9, LSL #48
    SUB  X28, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x6e39, LSL #0
    MOVK  X26, #0x2741, LSL #16
    MOVK  X26, #0xf7e9, LSL #32
    MOVK  X26, #0xf758, LSL #48
    SUB  X28, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x75a3, LSL #0
    MOVK  X26, #0x87e9, LSL #16
    MOVK  X26, #0x4585, LSL #32
    MOVK  X26, #0xee1b, LSL #48
    SUB  X28, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xa51d, LSL #0
    MOVK  X26, #0xfed5, LSL #16
    MOVK  X26, #0x1616, LSL #32
    MOVK  X26, #0xe935, LSL #48
    SUB  X28, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x9a79, LSL #0
    MOVK  X26, #0xc939, LSL #16
    MOVK  X26, #0xca72, LSL #32
    MOVK  X26, #0x6a5f, LSL #48
    SUB  X28, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xef98, LSL #0
    MOVK  X26, #0x9e0d, LSL #16
    MOVK  X26, #0xc20a, LSL #32
    MOVK  X26, #0x657f, LSL #48
    SUB  X28, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xf27e, LSL #0
    MOVK  X26, #0xb3df, LSL #16
    MOVK  X26, #0x6679, LSL #32
    MOVK  X26, #0xc3a1, LSL #48
    SUB  X28, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xa08a, LSL #0
    MOVK  X26, #0x9d55, LSL #16
    MOVK  X26, #0xd46d, LSL #32
    MOVK  X26, #0x151b, LSL #48
    SUB  X28, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xbb3a, LSL #0
    MOVK  X26, #0xcfab, LSL #16
    MOVK  X26, #0xbae3, LSL #32
    MOVK  X26, #0x16d8, LSL #48
    SUB  X28, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xa10d, LSL #0
    MOVK  X26, #0x94df, LSL #16
    MOVK  X26, #0x4b2e, LSL #32
    MOVK  X26, #0x667b, LSL #48
    SUB  X28, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0xea13, LSL #0
    MOVK  X26, #0x9b30, LSL #16
    MOVK  X26, #0x5845, LSL #32
    MOVK  X26, #0xf1c7, LSL #48
    SUB  X28, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x800, LSL #16
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D0
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D1
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D9
    MOVZ  X28, #0x9a9b, LSL #0
    MOVK  X28, #0xbc35, LSL #16
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D28
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D30
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D31
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
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
    FMOV  D0, X25
    FMOV  V0.D[1], X3
    FMOV  D1, X24
    FMOV  V1.D[1], X21
    FMOV  D2, X17
    FMOV  V2.D[1], X7
    FMOV  D3, X18
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X19
    FMOV  D5, X23
    FMOV  V5.D[1], X4
    FMOV  D6, X8
    FMOV  V6.D[1], X24
    FMOV  D7, X26
    FMOV  V7.D[1], X28
    FMOV  D8, X4
    FMOV  V8.D[1], X21
    FMOV  D9, X3
    FMOV  V9.D[1], X6
    FMOV  D10, X3
    FMOV  V10.D[1], X21
    FMOV  D11, X22
    FMOV  V11.D[1], X19
    FMOV  D12, X6
    FMOV  V12.D[1], X2
    FMOV  D13, X10
    FMOV  V13.D[1], X25
    FMOV  D14, X22
    FMOV  V14.D[1], X3
    FMOV  D15, X26
    FMOV  V15.D[1], X16
    FMOV  D16, X25
    FMOV  V16.D[1], X20
    FMOV  D17, X9
    FMOV  V17.D[1], X6
    FMOV  D18, X26
    FMOV  V18.D[1], X7
    FMOV  D19, X2
    FMOV  V19.D[1], X7
    FMOV  D20, X29
    FMOV  V20.D[1], X5
    FMOV  D21, X7
    FMOV  V21.D[1], X10
    FMOV  D22, X3
    FMOV  V22.D[1], X18
    FMOV  D23, X17
    FMOV  V23.D[1], X7
    FMOV  D24, X20
    FMOV  V24.D[1], X26
    FMOV  D25, X6
    FMOV  V25.D[1], X28
    FMOV  D26, X23
    FMOV  V26.D[1], X19
    FMOV  D27, X5
    FMOV  V27.D[1], X3
    FMOV  D28, X8
    FMOV  V28.D[1], X16
    FMOV  D29, X19
    FMOV  V29.D[1], X24
    FMOV  D30, X4
    FMOV  V30.D[1], X18
    FMOV  D31, X28
    FMOV  V31.D[1], X16
    MOVZ  X20, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_11:
    SXTL2 V11.8H, V27.16B
    SRSRA  V8.4H, V23.4H, #7
    SRSRA  V2.16B, V26.16B, #3
    SQDMLSL2 V1.4S, V31.8H, V8.H[0x6]
    SQDMLAL2 V18.4S, V24.8H, V5.H[0x3]
    SQSHLU  V17.8H, V11.8H, #0x5
    SQDMULL S2, H2, V2.H[0x4]
    SQSHLU  V27.4S, V2.4S, #0x18
    SQSHL V11.2D, V30.2D, #0x25
    SMLAL2 V28.2D, V28.4S, V17.S[0x1]
    SQSHRN2 V9.8H, V28.4S, #9
    SMULL2 V2.2D, V9.4S, V24.S[0x2]
    SMLAL V17.4S, V21.4H, V2.H[0x0]
    SQRDMULH  V10.2S, V17.2S, V27.S[0x0]
    SQDMLSL V0.4S, V11.4H, V1.H[0x1]
    SQRSHRUN V30.4H, V12.4S, #10
    SXTL2 V5.8H, V0.16B
    SQSHRN2 V31.8H, V18.4S, #12
    SMOV W22, V2.B[0x5]
    SRHADD  V11.8H, V31.8H, V5.8H
    SXTL2 V23.4S, V11.8H
    SMOV  X19, V23.B[0xa]
    SRSHR  V31.4H, V0.4H, #16
    SADDLP  V12.4S, V29.8H
    SSRA  V2.16B, V17.16B, #6
    SSHLL2 V28.2D, V12.4S, #0x1d
    SADDL  V12.4S, V10.4H, V25.4H
    SQRSHRN2 V1.8H, V8.4S, #2
    SSUBL  V26.8H, V1.8B, V2.8B
    SMLAL V2.2D, V30.2S, V9.S[0x2]
    SMLSL2  V0.2D, V14.4S, V26.4S
    SMLSL  V29.8H, V28.8B, V17.8B
    SSRA  V10.16B, V31.16B, #6
    SSHLL V5.8H, V12.8B, #0x5
    SSRA  V9.4S, V5.4S, #2
    SSUBW2  V10.4S, V29.4S, V29.8H
    SQSHRN V17.2S, V7.2D, #3
    SQRSHRUN V31.2S, V2.2D, #23
    SQDMULL S29, H10, V12.H[0x6]
    SQADD  V25.2S, V29.2S, V31.2S
    SQSHRN2 V29.16B, V31.8H, #4
    SSRA V7.2D, V25.2D, #14
    SSRA  V8.8H, V29.8H, #1
    SQRDMULH S11, S3, V8.S[0x2]
    SQDMULL2  V25.4S, V9.8H, V17.8H
    SHSUB  V9.4H, V25.4H, V15.4H
    SADDW2  V10.8H, V7.8H, V0.16B
    SXTL2 V2.4S, V11.8H
    SQSHRN V23.4H, V2.4S, #9
    SMLSL2 V3.4S, V10.8H, V10.H[0x2]
    SQSUB  V8.4S, V23.4S, V28.4S
    SMLSL2 V0.2D, V8.4S, V15.S[0x1]
    SQDMLSL D25, S20, V9.S[0x2]
    SMLAL V28.2D, V28.2S, V0.S[0x1]
    SQSHRUN V12.8B, V28.8H, #6
    SQSHRUN V10.8B, V3.8H, #2
    SABAL  V23.2D, V10.2S, V3.2S
    SQDMLAL2 V28.4S, V23.8H, V12.H[0x3]
    SQRSHRN V17.8B, V24.8H, #7
    SMLSL2 V8.2D, V6.4S, V28.S[0x1]
    SRSHR V6.2D, V20.2D, #21
    SXTL V18.4S, V26.4H
    SSHLL V3.2D, V21.2S, #0xf
    SQDMLAL V21.2D, V6.2S, V4.S[0x3]
    SADDW2  V26.4S, V7.4S, V8.8H
    SQSHL V10.2D, V19.2D, #0x10
    SQDMULL  V6.2D, V15.2S, V16.2S
    SABAL2  V0.4S, V24.8H, V0.8H
    SRSHL  V28.2S, V31.2S, V25.2S
    SQRSHL  V31.16B, V0.16B, V6.16B
    SQDMULH S16, S11, V18.S[0x0]
    SQSHLU  V6.8H, V21.8H, #0x8
    SMLSL V15.2D, V31.2S, V16.S[0x1]
    SMLSL2  V21.4S, V31.8H, V10.8H
    SMLAL2 V8.2D, V28.4S, V13.S[0x1]
    SRSHR  V6.16B, V14.16B, #6
    SMLSL V28.2D, V6.2S, V3.S[0x2]
    SQDMLSL D18, S9, V18.S[0x1]
    SSHLL V11.4S, V7.4H, #0xc
    SQDMLSL V3.4S, V28.4H, V12.H[0x0]
    SMULL2 V6.4S, V20.8H, V14.H[0x7]
    SSHR  V20.16B, V6.16B, #4
    SQDMULH  V21.4H, V21.4H, V11.H[0x1]
    SSRA  V7.4H, V9.4H, #7
    SXTL V13.8H, V20.8B
    SMULL2 V11.2D, V13.4S, V7.S[0x3]
    SQSHRN2 V25.8H, V0.4S, #4
    SMLSL V27.2D, V21.2S, V18.S[0x0]
    SQDMULH  V16.8H, V20.8H, V15.8H
    SMLAL V14.4S, V16.4H, V8.H[0x0]
    SMLAL2 V31.4S, V14.8H, V0.H[0x4]
    SQRDMULH S15, S11, V5.S[0x1]
    SXTL2 V11.4S, V3.8H
    SMLSL V11.4S, V24.4H, V15.H[0x4]
    SXTL2 V8.4S, V31.8H
    SQDMLSL S9, H13, V0.H[0x3]
    SQDMULL S15, H25, V5.H[0x4]
    SSUBW  V28.2D, V30.2D, V11.2S
    SSHLL2 V30.2D, V27.4S, #0x6
    SADDL  V3.2D, V9.2S, V19.2S
    SMLSL2 V6.4S, V15.8H, V4.H[0x6]
    SMLSL2 V31.2D, V30.4S, V19.S[0x0]
    SMLAL V19.2D, V8.2S, V6.S[0x2]
    SQRSHRN2 V15.8H, V31.4S, #1
    SMULL  V21.2D, V20.2S, V10.2S
    SSHLL V10.4S, V21.4H, #0x1
    SQSHL  V16.16B, V3.16B, #0x2
    SMLSL2 V9.4S, V19.8H, V10.H[0x3]
    SQXTUN2  V8.16B, V9.8H
    SMLSL2 V0.2D, V26.4S, V8.S[0x3]
    SSHLL V19.4S, V28.4H, #0x1
    SXTL V25.4S, V19.4H
    SQSHRN V13.4H, V11.4S, #8
    SQDMULL2  V10.4S, V30.8H, V15.8H
    SQXTUN  V28.4H, V25.4S
    SQSHRUN V3.8B, V28.8H, #3
    SQRDMULH  V5.4H, V4.4H, V0.H[0x0]
    SABA  V15.8B, V7.8B, V19.8B
    SMLAL  V28.8H, V3.8B, V10.8B
    SQSHRUN V28.8B, V28.8H, #5
    SQRDMULH  V30.8H, V5.8H, V28.8H
    SMOV  X26, V1.H[0x5]
    SXTL2 V28.2D, V15.4S
    SQDMULL2 V27.4S, V30.8H, V11.H[0x1]
    SADDW2  V15.2D, V2.2D, V4.4S
    SSUBL  V17.4S, V11.4H, V16.4H
    SQRSHRN2 V10.4S, V27.2D, #3
    SQDMLSL S2, H10, V10.H[0x1]
    SQRDMULH S19, S9, V28.S[0x3]
    SQSHL  V26.4S, V10.4S, #0x6
    SQSHL  V0.8B, V26.8B, #0x6
    SADDW  V25.8H, V5.8H, V19.8B
    SRSHR V10.2D, V29.2D, #58
    SQDMLAL S5, H28, V15.H[0x2]
    SQSHRUN2 V9.8H, V21.4S, #7
    SQDMLSL2 V3.4S, V0.8H, V15.H[0x0]
    SRSHR  V26.4H, V2.4H, #2
    SMLSL2  V8.4S, V3.8H, V4.8H
    SQDMLAL  V0.4S, V24.4H, V5.4H
    SSHR  V24.4S, V24.4S, #8
    SABD  V7.2S, V9.2S, V25.2S
    SSRA  V21.8B, V2.8B, #4
    SMLAL  V17.4S, V17.4H, V26.4H
    SQSHRUN V9.4H, V10.4S, #4
    SQRSHRN V15.2S, V9.2D, #16
    SMLAL V11.4S, V21.4H, V8.H[0x4]
    SMLAL2  V2.2D, V24.4S, V24.4S
    SMLAL2  V4.4S, V1.8H, V25.8H
    SQSHL  V11.4S, V4.4S, #0x10
    SRSHR V9.2D, V15.2D, #21
    SSHLL V19.8H, V0.8B, #0x6
    SADDW2  V0.4S, V20.4S, V19.8H
    SQDMLAL2 V17.4S, V27.8H, V14.H[0x5]
    SSHR  V3.4S, V21.4S, #23
    SSUBW2  V1.4S, V0.4S, V0.8H
    SQDMLAL2  V15.4S, V2.8H, V18.8H
    SQRSHRUN2 V25.8H, V1.4S, #16
    SQDMLAL2 V8.2D, V25.4S, V11.S[0x3]
    SQDMLSL2 V26.2D, V9.4S, V7.S[0x0]
    SQSHRN2 V2.16B, V17.8H, #7
    SQRSHRUN2 V29.16B, V8.8H, #2
    SQXTUN  V0.8B, V29.8H
    SMLSL  V1.2D, V26.2S, V26.2S
    SQSUB  V11.4S, V30.4S, V15.4S
    SQXTUN2  V9.4S, V21.2D
    SQDMLSL S4, H9, V6.H[0x3]
    SADDW  V26.8H, V1.8H, V2.8B
    SQDMLAL  V24.4S, V0.4H, V11.4H
    SQDMLSL V8.2D, V28.2S, V4.S[0x2]
    SQDMULL  V30.4S, V8.4H, V24.4H
    SQDMLAL  V14.2D, V29.2S, V3.2S
    SQSHLU  V0.8H, V30.8H, #0xb
    SQSHL  V27.16B, V0.16B, #0x7
    SQDMULL2 V26.2D, V26.4S, V14.S[0x0]
    SQDMULH  V9.2S, V17.2S, V24.S[0x0]
    SQDMULL  V30.2D, V8.2S, V20.2S
    SMLAL V3.4S, V31.4H, V7.H[0x5]
    SQDMULL S17, H20, V6.H[0x1]
    SQRDMULH  V29.8H, V17.8H, V11.H[0x0]
    SQDMLAL V23.4S, V0.4H, V6.H[0x5]
    SSRA  V8.16B, V28.16B, #2
    SADDL2  V21.8H, V17.16B, V2.16B
    SQRSHRN2 V13.16B, V11.8H, #3
    SQSHLU  V20.16B, V26.16B, #0x4
    SMULL2  V1.8H, V29.16B, V13.16B
    SQDMLSL  V7.4S, V8.4H, V8.4H
    SABA  V4.4H, V20.4H, V23.4H
    SSHL  V11.4H, V1.4H, V30.4H
    SXTL V17.4S, V4.4H
    SMLAL V15.4S, V27.4H, V7.H[0x5]
    SQDMLAL S13, H9, V9.H[0x4]
    SXTL2 V14.4S, V28.8H
    SQDMLSL  V29.4S, V13.4H, V17.4H
    SQRSHRN V9.8B, V11.8H, #7
    SQSHL V28.2D, V31.2D, #0xc
    SQXTN  V18.8B, V23.8H
    SRSHR  V7.4H, V28.4H, #13
    SQRSHRN V13.2S, V7.2D, #1
    SQRSHRUN2 V0.8H, V2.4S, #13
    SADDW2  V20.8H, V13.8H, V9.16B
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_11
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X5, FPSR
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X5, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
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
    FMOV  D0, X7
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X10
    FMOV  D3, X28
    FMOV  V3.D[1], X18
    FMOV  D4, X2
    FMOV  V4.D[1], X9
    FMOV  D5, X17
    FMOV  V5.D[1], X20
    FMOV  D6, X2
    FMOV  V6.D[1], X10
    FMOV  D7, X16
    FMOV  V7.D[1], X23
    FMOV  D8, X10
    FMOV  V8.D[1], X21
    FMOV  D9, X8
    FMOV  V9.D[1], X21
    FMOV  D10, X16
    FMOV  V10.D[1], X22
    FMOV  D11, X21
    FMOV  V11.D[1], X6
    FMOV  D12, X29
    FMOV  V12.D[1], X21
    FMOV  D13, X20
    FMOV  V13.D[1], X25
    FMOV  D14, X23
    FMOV  V14.D[1], X7
    FMOV  D15, X20
    FMOV  V15.D[1], X5
    FMOV  D16, X22
    FMOV  V16.D[1], X24
    FMOV  D17, X29
    FMOV  V17.D[1], X29
    FMOV  D18, X25
    FMOV  V18.D[1], X27
    FMOV  D19, X27
    FMOV  V19.D[1], X26
    FMOV  D20, X27
    FMOV  V20.D[1], X19
    FMOV  D21, X22
    FMOV  V21.D[1], X21
    FMOV  D22, X16
    FMOV  V22.D[1], X7
    FMOV  D23, X6
    FMOV  V23.D[1], X28
    FMOV  D24, X10
    FMOV  V24.D[1], X9
    FMOV  D25, X7
    FMOV  V25.D[1], X8
    FMOV  D26, X8
    FMOV  V26.D[1], X5
    FMOV  D27, X23
    FMOV  V27.D[1], X18
    FMOV  D28, X5
    FMOV  V28.D[1], X19
    FMOV  D29, X17
    FMOV  V29.D[1], X28
    FMOV  D30, X24
    FMOV  V30.D[1], X23
    FMOV  D31, X10
    FMOV  V31.D[1], X6
    MOVZ  X5, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_12:
    SQDMLAL S19, H18, V6.H[0x6]
    SSUBL  V4.8H, V21.8B, V20.8B
    SHADD  V3.16B, V31.16B, V28.16B
    SQRSHRN V6.2S, V18.2D, #29
    SQSHRN V16.4H, V3.4S, #4
    SRSRA V2.2D, V30.2D, #38
    SMLAL2  V14.4S, V26.8H, V2.8H
    SQRDMULH  V30.8H, V19.8H, V19.8H
    SQDMULL  V21.4S, V30.4H, V27.4H
    SMLSL2  V25.8H, V4.16B, V14.16B
    SQRDMULH S1, S9, V27.S[0x1]
    SQADD  V17.8B, V21.8B, V25.8B
    SQSUB  V3.8B, V29.8B, V8.8B
    SMLSL2 V28.4S, V4.8H, V6.H[0x1]
    SQSHRUN V14.2S, V28.2D, #19
    SQDMULL V4.2D, V8.2S, V3.S[0x1]
    SADDLV  D18, V4.4S
    SQRSHRUN2 V25.8H, V21.4S, #15
    SQXTN2  V21.8H, V10.4S
    SQRSHRUN V6.4H, V11.4S, #14
    SQDMULL  V25.2D, V25.2S, V14.2S
    SQDMULL V28.2D, V11.2S, V1.S[0x0]
    SQDMLSL  V19.4S, V6.4H, V25.4H
    SQXTN  V16.4H, V16.4S
    SQDMLAL2 V29.2D, V10.4S, V18.S[0x1]
    SQSHRN2 V4.8H, V19.4S, #5
    SQABS  V19.2S, V2.2S
    SADALP  V26.8H, V28.16B
    SQRDMULH  V10.2S, V22.2S, V19.S[0x2]
    SQRDMULH  V14.8H, V21.8H, V10.8H
    SQDMLSL V6.4S, V17.4H, V4.H[0x7]
    SQDMULL2 V21.2D, V14.4S, V6.S[0x3]
    SQDMLSL D19, S3, V29.S[0x2]
    SQDMULL V8.4S, V21.4H, V8.H[0x0]
    SRSHL  V28.4H, V16.4H, V22.4H
    SHADD  V18.2S, V21.2S, V28.2S
    SQSHRN2 V29.16B, V1.8H, #1
    SRSRA  V14.8H, V8.8H, #1
    SMLSL  V16.2D, V6.2S, V18.2S
    SMULL2 V22.4S, V29.8H, V14.H[0x5]
    SQRSHRN V0.8B, V16.8H, #3
    SSHLL2 V6.8H, V19.16B, #0x2
    SQRSHRN V19.8B, V0.8H, #8
    SQSHRN2 V20.8H, V6.4S, #5
    SSRA V18.2D, V22.2D, #63
    SQRSHRUN V8.2S, V18.2D, #22
    SQRSHRUN2 V28.4S, V8.2D, #31
    SQDMULH H6, H28, V9.H[0x3]
    SQABS  V29.2S, V13.2S
    SADDLV  D30, V26.4S
    SSRA  V3.4H, V4.4H, #12
    SRSHR V26.2D, V20.2D, #12
    SQSHRN V14.4H, V19.4S, #7
    SQSHRUN2 V21.4S, V3.2D, #9
    SQRDMULH  V3.2S, V22.2S, V14.S[0x3]
    SMLSL  V18.4S, V13.4H, V30.4H
    SQDMLAL S16, H30, V13.H[0x0]
    SRSHR  V9.4H, V16.4H, #12
    SABA  V20.16B, V26.16B, V6.16B
    SQRSHRUN2 V26.4S, V6.2D, #7
    SQSHRUN V0.4H, V8.4S, #7
    SQDMULH S1, S24, V21.S[0x1]
    SQSHL  V4.2S, V18.2S, V1.2S
    SADDL  V21.4S, V21.4H, V9.4H
    SQRDMULH  V30.4S, V28.4S, V21.4S
    SQSHRN2 V16.8H, V27.4S, #3
    SMOV  X4, V26.B[0xb]
    SSUBL2  V21.2D, V29.4S, V6.4S
    SQSHRN V9.2S, V30.2D, #10
    SUQADD  V24.4H, V25.4H
    SQSHRUN V26.2S, V26.2D, #3
    SSUBL  V27.8H, V20.8B, V0.8B
    SQDMLAL D0, S4, V24.S[0x1]
    SSRA  V3.8H, V21.8H, #2
    SSHLL V25.2D, V29.2S, #0x9
    SQDMULL V27.2D, V9.2S, V16.S[0x0]
    SABA  V13.4H, V25.4H, V6.4H
    SRSHR V21.2D, V26.2D, #25
    SABD  V18.4S, V21.4S, V21.4S
    SMLSL2  V29.8H, V27.16B, V21.16B
    SMLAL V7.2D, V7.2S, V2.S[0x3]
    SQDMULH  V20.4S, V7.4S, V3.S[0x1]
    SSHR  V28.4S, V6.4S, #23
    SQRDMULH  V16.8H, V8.8H, V24.8H
    SQSHRUN2 V7.8H, V25.4S, #3
    SQRSHRUN V31.8B, V20.8H, #7
    SQDMLAL2 V5.2D, V29.4S, V23.S[0x3]
    SQDMLSL2 V1.4S, V31.8H, V13.H[0x5]
    SQXTUN2  V29.8H, V22.4S
    SXTL2 V3.8H, V1.16B
    SADDW  V20.8H, V16.8H, V28.8B
    SRSHR  V6.4H, V29.4H, #15
    SMULL2  V10.8H, V0.16B, V8.16B
    SQSHL V30.2D, V1.2D, #0x2f
    SMLAL V29.4S, V31.4H, V4.H[0x5]
    SQRDMULH  V28.4S, V20.4S, V12.S[0x0]
    SMLSL V9.2D, V18.2S, V30.S[0x1]
    SMLAL2 V23.4S, V5.8H, V3.H[0x1]
    SQRSHRUN2 V16.8H, V0.4S, #12
    SSHLL V16.2D, V23.2S, #0x9
    SADDL2  V21.8H, V28.16B, V16.16B
    SMLAL V19.2D, V29.2S, V29.S[0x3]
    SQSHRN2 V12.16B, V9.8H, #2
    SRSRA  V23.4H, V12.4H, #6
    SQDMULL D28, S6, V9.S[0x3]
    SSHLL2 V31.8H, V23.16B, #0x6
    SQRSHRN V24.4H, V31.4S, #4
    SMULL2 V13.4S, V7.8H, V10.H[0x3]
    SSHLL V4.8H, V13.8B, #0x1
    SQDMULH H25, H4, V8.H[0x6]
    SMULL2 V20.2D, V22.4S, V16.S[0x1]
    SQSHLU V4.2D, V6.2D, #0x2a
    SQRSHRN2 V6.4S, V4.2D, #8
    SADDLV  S22, V11.8H
    SQDMULH  V16.2S, V18.2S, V6.S[0x3]
    SQSHRN2 V0.4S, V24.2D, #24
    SABDL2  V8.4S, V3.8H, V9.8H
    SMOV  X22, V22.H[0x6]
    SQSHL  V3.8H, V20.8H, #0x2
    SQDMULL2  V22.2D, V0.4S, V25.4S
    SQRDMULH  V5.4S, V21.4S, V22.S[0x1]
    SRSRA  V5.4H, V19.4H, #12
    SXTL V31.2D, V9.2S
    SRSHL  V30.4S, V28.4S, V19.4S
    SQSHL  V25.16B, V31.16B, #0x7
    SQRDMULH  V13.2S, V3.2S, V3.S[0x2]
    SABDL2  V0.4S, V17.8H, V25.8H
    SQRDMULH  V31.4S, V26.4S, V30.4S
    SADDL2  V3.4S, V16.8H, V5.8H
    SQDMULL2  V25.2D, V3.4S, V22.4S
    SMLSL  V23.2D, V30.2S, V8.2S
    SQSHLU  V4.8H, V0.8H, #0xc
    SRSRA  V21.8B, V23.8B, #3
    SQRSHRUN2 V30.4S, V13.2D, #13
    SMOV  X28, V18.H[0x6]
    SSHR  V23.4S, V30.4S, #10
    SSRA V5.2D, V21.2D, #42
    SQSHRUN V19.4H, V26.4S, #16
    SQRSHRN2 V15.4S, V23.2D, #31
    SQRSHRUN2 V28.8H, V4.4S, #3
    SQDMULH  V31.4S, V4.4S, V31.S[0x0]
    SSHLL2 V23.8H, V31.16B, #0x5
    SMLSL V4.2D, V15.2S, V19.S[0x3]
    SQRDMULH  V0.8H, V16.8H, V13.H[0x4]
    SMULL2 V21.2D, V28.4S, V0.S[0x2]
    SQDMULH H28, H5, V10.H[0x4]
    SQSHL V0.2D, V25.2D, #0x2
    SQRSHRUN V26.4H, V5.4S, #11
    SQSHRUN V31.4H, V4.4S, #16
    SSHR V10.2D, V31.2D, #43
    SABD  V13.16B, V13.16B, V29.16B
    SSHLL V6.8H, V19.8B, #0x6
    SQSHLU  V25.2S, V2.2S, #0x14
    SQDMULL S19, H17, V11.H[0x6]
    SQDMULH S31, S8, V25.S[0x0]
    SQSHL  V17.8H, V26.8H, #0xb
    SQRDMULH H27, H31, V0.H[0x0]
    SQADD  V31.2D, V15.2D, V9.2D
    SQNEG  V8.8B, V11.8B
    SABDL  V29.2D, V11.2S, V23.2S
    SXTL V5.4S, V6.4H
    SQDMULL D2, S19, V6.S[0x3]
    SSHLL V18.2D, V17.2S, #0x10
    SQDMLAL  V11.2D, V31.2S, V27.2S
    SSHLL2 V27.8H, V8.16B, #0x2
    SRSHR  V23.16B, V28.16B, #5
    SMLAL2 V0.4S, V21.8H, V10.H[0x4]
    SADDLV  D28, V20.4S
    SSHLL V6.2D, V27.2S, #0x16
    SMULL2 V31.4S, V6.8H, V6.H[0x6]
    SQRSHRUN V26.8B, V23.8H, #5
    SQSHRUN V17.2S, V18.2D, #31
    SMULL  V2.4S, V27.4H, V17.4H
    SSHLL2 V20.4S, V2.8H, #0xc
    SMLSL2 V26.2D, V28.4S, V5.S[0x3]
    SQADD  V9.2S, V22.2S, V26.2S
    SMULL2 V5.2D, V12.4S, V20.S[0x2]
    SQRDMULH  V21.8H, V31.8H, V5.8H
    SQSHL  V25.4S, V11.4S, V21.4S
    SMULL V8.2D, V24.2S, V25.S[0x0]
    SXTL V15.4S, V18.4H
    SQDMLSL2  V23.2D, V11.4S, V16.4S
    SQDMULH  V17.4S, V9.4S, V23.S[0x2]
    SQDMLAL V31.2D, V6.2S, V23.S[0x1]
    SMLSL  V28.8H, V29.8B, V14.8B
    SRHADD  V6.4H, V8.4H, V12.4H
    SABA  V2.4H, V6.4H, V6.4H
    SQSHL  V9.2S, V31.2S, V0.2S
    SQABS  V30.8B, V2.8B
    SXTL2 V16.8H, V15.16B
    SADDW2  V3.4S, V21.4S, V9.8H
    SQRSHRN V0.4H, V3.4S, #6
    SMLSL2 V23.4S, V16.8H, V0.H[0x0]
    SQSHLU  V5.16B, V28.16B, #0x4
    SQDMULH  V5.2S, V23.2S, V15.2S
    SQSHL  V0.16B, V5.16B, #0x4
    SSRA  V24.2S, V18.2S, #25
    SMULL V14.4S, V14.4H, V0.H[0x3]
    SQNEG  V15.16B, V16.16B
    SQDMULL2  V0.2D, V13.4S, V11.4S
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_12
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X23, FPSR
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X2, #0x40, LSL #0
    MOVK  X2, #0x40, LSL #32
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D11
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D12
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D13
    MOVZ  X2, #0x1, LSL #0
    MOVK  X2, #0x1, LSL #32
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D19
    MOVZ  X2, #0x2, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D25
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X2, #0x1, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D29
    MOVZ  X2, #0x1, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X23, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  D1, X21
    FMOV  V1.D[1], X8
    FMOV  D2, X4
    FMOV  V2.D[1], X27
    FMOV  D3, X5
    FMOV  V3.D[1], X26
    FMOV  D4, X23
    FMOV  V4.D[1], X10
    FMOV  D5, X3
    FMOV  V5.D[1], X28
    FMOV  D6, X20
    FMOV  V6.D[1], X28
    FMOV  D7, X10
    FMOV  V7.D[1], X22
    FMOV  D8, X19
    FMOV  V8.D[1], X5
    FMOV  D9, X10
    FMOV  V9.D[1], X16
    FMOV  D10, X3
    FMOV  V10.D[1], X28
    FMOV  D11, X5
    FMOV  V11.D[1], X9
    FMOV  D12, X9
    FMOV  V12.D[1], X4
    FMOV  D13, X6
    FMOV  V13.D[1], X10
    FMOV  D14, X22
    FMOV  V14.D[1], X21
    FMOV  D15, X20
    FMOV  V15.D[1], X10
    FMOV  D16, X7
    FMOV  V16.D[1], X19
    FMOV  D17, X8
    FMOV  V17.D[1], X18
    FMOV  D18, X9
    FMOV  V18.D[1], X19
    FMOV  D19, X17
    FMOV  V19.D[1], X4
    FMOV  D20, X26
    FMOV  V20.D[1], X29
    FMOV  D21, X23
    FMOV  V21.D[1], X18
    FMOV  D22, X8
    FMOV  V22.D[1], X4
    FMOV  D23, X6
    FMOV  V23.D[1], X29
    FMOV  D24, X9
    FMOV  V24.D[1], X4
    FMOV  D25, X8
    FMOV  V25.D[1], X3
    FMOV  D26, X27
    FMOV  V26.D[1], X6
    FMOV  D27, X20
    FMOV  V27.D[1], X22
    FMOV  D28, X25
    FMOV  V28.D[1], X20
    FMOV  D29, X23
    FMOV  V29.D[1], X22
    FMOV  D30, X5
    FMOV  V30.D[1], X8
    FMOV  D31, X26
    FMOV  V31.D[1], X29
    MOVZ  X27, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_13:
    SADDLP  V6.2D, V26.4S
    SQDMLSL V16.4S, V27.4H, V6.H[0x3]
    SQDMLAL  V22.4S, V16.4H, V30.4H
    SMULL V22.4S, V19.4H, V11.H[0x2]
    SRSHR  V12.16B, V31.16B, #2
    SSHR  V13.16B, V29.16B, #4
    SRSHR  V27.4S, V22.4S, #4
    SMULL V29.4S, V29.4H, V12.H[0x1]
    SMLSL  V11.8H, V29.8B, V27.8B
    SQDMULL2 V4.2D, V11.4S, V28.S[0x1]
    SQSHRUN V26.2S, V9.2D, #25
    SQDMLSL D8, S26, V4.S[0x1]
    SQXTUN  V26.8B, V8.8H
    SADALP  V17.1D, V13.2S
    SQRSHRUN V29.2S, V26.2D, #1
    SADDLV  D9, V29.4S
    SQDMULH  V26.2S, V9.2S, V17.2S
    SABDL  V27.4S, V9.4H, V14.4H
    SQDMLAL  V23.4S, V6.4H, V24.4H
    SQRSHRUN V28.8B, V9.8H, #8
    SQDMULL2  V8.4S, V8.8H, V31.8H
    SQDMULL V11.2D, V27.2S, V18.S[0x2]
    SQSHRN2 V18.4S, V24.2D, #24
    SADDL2  V5.2D, V20.4S, V27.4S
    SQDMLSL2  V29.4S, V21.8H, V15.8H
    SABAL2  V31.2D, V10.4S, V25.4S
    SMLSL V13.4S, V23.4H, V8.H[0x6]
    SQDMULH  V14.4S, V31.4S, V15.S[0x2]
    SRHADD  V23.8B, V25.8B, V13.8B
    SABAL  V21.8H, V26.8B, V31.8B
    SSHLL2 V9.2D, V18.4S, #0xf
    SQDMULH H27, H31, V5.H[0x1]
    SQSHRUN V18.4H, V21.4S, #1
    SSUBL2  V25.2D, V14.4S, V29.4S
    SQSHL V29.2D, V6.2D, #0x1b
    SMOV  X18, V22.S[0x3]
    SQSHLU V12.2D, V28.2D, #0x39
    SQXTN2  V5.8H, V25.4S
    SMLAL V31.4S, V19.4H, V1.H[0x5]
    SQSUB  V6.8H, V17.8H, V18.8H
    SADDL2  V8.4S, V16.8H, V17.8H
    SQDMLSL2 V16.4S, V23.8H, V11.H[0x7]
    SQSHLU  V10.4S, V5.4S, #0x3
    SSHR  V22.2S, V12.2S, #15
    SSHR  V20.8B, V16.8B, #6
    SRSHL  V13.8H, V27.8H, V31.8H
    SQSHRN V16.4H, V14.4S, #6
    SMLSL V14.4S, V10.4H, V6.H[0x1]
    SXTL2 V23.4S, V16.8H
    SQDMULL2  V16.2D, V9.4S, V9.4S
    SQDMLAL2  V11.2D, V16.4S, V29.4S
    SQDMLAL S24, H23, V15.H[0x5]
    SSUBL2  V20.8H, V14.16B, V14.16B
    SMLSL2  V29.4S, V11.8H, V5.8H
    SSRA  V17.2S, V7.2S, #19
    SSUBL2  V11.4S, V29.8H, V13.8H
    SQDMLAL2 V16.2D, V3.4S, V20.S[0x1]
    SMLSL V25.4S, V6.4H, V11.H[0x6]
    SABA  V9.8B, V21.8B, V23.8B
    SMOV  X7, V22.H[0x4]
    SQRSHRN V22.8B, V15.8H, #5
    SMULL2  V10.8H, V24.16B, V25.16B
    SXTL2 V7.4S, V10.8H
    SADDW2  V24.2D, V31.2D, V5.4S
    SSRA  V19.4S, V8.4S, #19
    SADDLV  S18, V9.8H
    SRSHR  V29.8H, V16.8H, #15
    SQRSHRUN2 V31.4S, V22.2D, #32
    SMULL2 V11.4S, V8.8H, V7.H[0x3]
    SRSHL  V13.4H, V23.4H, V11.4H
    SQNEG  V21.8B, V7.8B
    SSRA V11.2D, V23.2D, #22
    SUQADD  V27.2S, V15.2S
    SMLAL2  V14.4S, V24.8H, V9.8H
    SQRDMULH S20, S31, V9.S[0x2]
    SABD  V31.16B, V27.16B, V18.16B
    SQDMLAL D8, S2, V31.S[0x3]
    SQSHRUN V9.4H, V13.4S, #9
    SQDMULL S2, H20, V13.H[0x0]
    SQADD  V16.8H, V21.8H, V18.8H
    SQRSHRN V24.8B, V5.8H, #6
    SABDL  V7.4S, V24.4H, V19.4H
    SQDMULL V18.2D, V3.2S, V0.S[0x2]
    SQRSHRUN2 V23.8H, V4.4S, #3
    SMLAL2 V21.4S, V16.8H, V9.H[0x6]
    SMLAL V20.2D, V14.2S, V7.S[0x1]
    SSHL  V31.8B, V1.8B, V22.8B
    SQRDMULH  V18.8H, V20.8H, V11.H[0x4]
    SABDL2  V13.4S, V29.8H, V13.8H
    SMLAL2  V18.8H, V2.16B, V29.16B
    SMLAL2 V2.4S, V13.8H, V4.H[0x4]
    SQRSHRUN2 V3.16B, V2.8H, #5
    SQSHRUN2 V21.4S, V18.2D, #20
    SRSRA  V4.16B, V1.16B, #5
    SQDMLAL  V7.4S, V8.4H, V3.4H
    SQDMULL D29, S16, V31.S[0x3]
    SQSHLU  V14.4S, V1.4S, #0x5
    SSHLL2 V27.4S, V21.8H, #0xb
    SSRA  V9.2S, V8.2S, #6
    SADDLP  V2.8H, V27.16B
    SQDMULL V3.4S, V14.4H, V5.H[0x2]
    SQDMULL V31.4S, V29.4H, V7.H[0x7]
    SQDMLAL D16, S24, V23.S[0x3]
    SQXTUN  V14.8B, V16.8H
    SMULL2 V29.4S, V4.8H, V2.H[0x2]
    SADDL  V27.4S, V7.4H, V29.4H
    SQSHLU V22.2D, V14.2D, #0x20
    SQSHRUN V5.8B, V3.8H, #1
    SRSHR  V8.4H, V9.4H, #1
    SADDW2  V1.8H, V26.8H, V27.16B
    SRSHR  V3.2S, V8.2S, #10
    SMLAL  V19.8H, V18.8B, V3.8B
    SQDMULH H24, H10, V1.H[0x6]
    SSUBL2  V10.8H, V12.16B, V19.16B
    SQSHL  V1.16B, V24.16B, #0x6
    SQDMLSL V29.4S, V14.4H, V0.H[0x5]
    SQRSHRUN2 V9.8H, V25.4S, #12
    SQSHRUN2 V23.4S, V1.2D, #15
    SQABS  V14.8H, V5.8H
    SSUBL2  V1.4S, V22.8H, V15.8H
    SMULL2 V16.2D, V1.4S, V7.S[0x0]
    SRSRA  V7.4H, V7.4H, #1
    SSRA  V0.8H, V29.8H, #3
    SQDMLAL2 V25.4S, V23.8H, V12.H[0x6]
    SMLAL V26.2D, V16.2S, V3.S[0x2]
    SQSHL  V24.4S, V19.4S, #0x17
    SQSHL  V3.8H, V23.8H, #0xf
    SQDMLAL2  V30.4S, V0.8H, V22.8H
    SQSHLU  V27.4S, V6.4S, #0x1f
    SQSHLU V0.2D, V22.2D, #0x2
    SQSHLU  V6.8H, V27.8H, #0x8
    SRSHL  V27.16B, V27.16B, V26.16B
    SQSHRN V4.4H, V3.4S, #10
    SSRA  V26.8H, V30.8H, #12
    SQSHLU  V16.4H, V25.4H, #0x3
    SSUBW2  V8.2D, V24.2D, V9.4S
    SQRSHL  V1.4H, V29.4H, V27.4H
    SQSHLU  V30.8H, V31.8H, #0xe
    SMLAL2 V25.2D, V14.4S, V4.S[0x1]
    SSUBL  V23.2D, V10.2S, V2.2S
    SQRSHRUN2 V19.8H, V26.4S, #2
    SRHADD  V31.2S, V19.2S, V6.2S
    SQRSHRUN V22.4H, V1.4S, #1
    SQNEG  V19.8H, V30.8H
    SQRDMULH  V14.2S, V15.2S, V12.S[0x1]
    SSHR  V4.8H, V7.8H, #9
    SSUBW  V12.8H, V19.8H, V25.8B
    SQADD  V15.4H, V4.4H, V1.4H
    SQDMULL V25.2D, V15.2S, V9.S[0x3]
    SADDLV  H10, V5.8B
    SQRSHRN V27.8B, V23.8H, #2
    SMLAL2 V3.4S, V5.8H, V0.H[0x4]
    SADDW  V0.4S, V10.4S, V14.4H
    SQDMLAL2  V14.2D, V25.4S, V16.4S
    SQDMULL  V10.2D, V26.2S, V31.2S
    SRSHR  V25.8B, V3.8B, #3
    SQDMLSL V24.2D, V8.2S, V16.S[0x3]
    SMLAL V22.4S, V14.4H, V13.H[0x3]
    SQSHRUN V6.4H, V12.4S, #14
    SQRDMULH  V1.2S, V25.2S, V14.S[0x1]
    SSHR  V4.16B, V10.16B, #5
    SQSHRUN V15.4H, V10.4S, #12
    SADDLV  H26, V27.16B
    SMOV W2, V25.B[0x6]
    SMOV W9, V4.B[0x3]
    SQDMLAL2  V19.4S, V26.8H, V1.8H
    SQSHL  V9.8H, V5.8H, #0x8
    SQDMLAL  V31.2D, V22.2S, V6.2S
    SSRA  V13.4H, V9.4H, #3
    SMULL V27.2D, V0.2S, V0.S[0x1]
    SQSHRUN V0.2S, V27.2D, #27
    SMOV  X28, V15.H[0x5]
    SSHLL V4.2D, V0.2S, #0x7
    SQADD  V15.8H, V12.8H, V7.8H
    SQSHLU  V15.16B, V5.16B, #0x4
    SQDMULL V7.4S, V31.4H, V4.H[0x5]
    SSHR  V12.16B, V19.16B, #4
    SQSHL  V1.4H, V19.4H, V18.4H
    SQRDMULH  V31.4S, V30.4S, V13.4S
    SQNEG  V12.4S, V1.4S
    SMLAL2 V28.2D, V15.4S, V31.S[0x3]
    SXTL2 V3.4S, V4.8H
    SMLAL2  V9.2D, V18.4S, V24.4S
    SRSRA V18.2D, V7.2D, #13
    SADDL2  V26.4S, V25.8H, V0.8H
    SRSRA V27.2D, V24.2D, #28
    SQRSHRUN2 V4.8H, V9.4S, #16
    SSRA  V5.4H, V0.4H, #12
    SXTL V30.8H, V18.8B
    SQXTUN  V16.8B, V30.8H
    SQSHRUN2 V25.16B, V22.8H, #5
    SQDMLAL S18, H12, V12.H[0x0]
    SQRDMULH  V1.2S, V13.2S, V18.S[0x1]
    SQSHRN V31.4H, V16.4S, #4
    SQDMULL2  V12.2D, V28.4S, V23.4S
    SQSHL  V8.4H, V9.4H, #0x0
    SQSHLU V0.2D, V12.2D, #0x3b
    SQSHRUN V22.2S, V1.2D, #20
    SQRSHRN V19.2S, V3.2D, #22
    SMOV W28, V5.B[0xf]
    SUBS  X27, X27, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_13
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X19, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x800, LSL #16
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D0
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D1
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D4
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D5
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D9
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D12
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D17
    MOVZ  X19, #0x6baa, LSL #0
    MOVK  X19, #0x6465, LSL #16
    MOVK  X19, #0x65a5, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D19
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D21
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D30
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X26, D31
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  V0.D[1], X8
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X18
    FMOV  V2.D[1], X24
    FMOV  D3, X29
    FMOV  V3.D[1], X27
    FMOV  D4, X10
    FMOV  V4.D[1], X26
    FMOV  D5, X3
    FMOV  V5.D[1], X9
    FMOV  D6, X10
    FMOV  V6.D[1], X25
    FMOV  D7, X29
    FMOV  V7.D[1], X29
    FMOV  D8, X6
    FMOV  V8.D[1], X6
    FMOV  D9, X17
    FMOV  V9.D[1], X17
    FMOV  D10, X22
    FMOV  V10.D[1], X24
    FMOV  D11, X10
    FMOV  V11.D[1], X24
    FMOV  D12, X7
    FMOV  V12.D[1], X21
    FMOV  D13, X7
    FMOV  V13.D[1], X3
    FMOV  D14, X2
    FMOV  V14.D[1], X19
    FMOV  D15, X21
    FMOV  V15.D[1], X21
    FMOV  D16, X26
    FMOV  V16.D[1], X16
    FMOV  D17, X24
    FMOV  V17.D[1], X9
    FMOV  D18, X10
    FMOV  V18.D[1], X21
    FMOV  D19, X27
    FMOV  V19.D[1], X9
    FMOV  D20, X23
    FMOV  V20.D[1], X7
    FMOV  D21, X29
    FMOV  V21.D[1], X7
    FMOV  D22, X2
    FMOV  V22.D[1], X16
    FMOV  D23, X8
    FMOV  V23.D[1], X28
    FMOV  D24, X19
    FMOV  V24.D[1], X25
    FMOV  D25, X23
    FMOV  V25.D[1], X16
    FMOV  D26, X28
    FMOV  V26.D[1], X23
    FMOV  D27, X29
    FMOV  V27.D[1], X23
    FMOV  D28, X7
    FMOV  V28.D[1], X26
    FMOV  D29, X2
    FMOV  V29.D[1], X9
    FMOV  D30, X19
    FMOV  V30.D[1], X18
    FMOV  D31, X17
    FMOV  V31.D[1], X29
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorSignedOperation_label_14:
    SQRSHRUN V25.2S, V28.2D, #9
    SQDMLAL2 V31.2D, V24.4S, V24.S[0x0]
    SMLAL2  V22.2D, V31.4S, V9.4S
    SQDMLSL2 V9.4S, V29.8H, V14.H[0x0]
    SQSHRN2 V25.16B, V25.8H, #2
    SQNEG  V2.16B, V26.16B
    SQSHLU  V24.16B, V25.16B, #0x2
    SQRSHRN2 V22.16B, V30.8H, #8
    SQSHRUN V3.8B, V6.8H, #5
    SQRSHRN2 V31.4S, V2.2D, #3
    SQDMLSL D23, S27, V27.S[0x0]
    SQSHRN2 V10.16B, V24.8H, #3
    SQDMLAL V30.4S, V3.4H, V8.H[0x6]
    SQDMLSL V9.2D, V30.2S, V31.S[0x1]
    SQDMLAL V4.4S, V10.4H, V10.H[0x5]
    SSHR  V29.2S, V8.2S, #24
    SQDMULH  V24.4H, V24.4H, V10.H[0x7]
    SSHLL2 V14.4S, V29.8H, #0x3
    SQDMLAL V31.4S, V17.4H, V9.H[0x2]
    SQDMULL2  V14.4S, V17.8H, V14.8H
    SQRSHRUN2 V25.8H, V24.4S, #8
    SXTL2 V30.8H, V4.16B
    SABAL2  V26.4S, V3.8H, V6.8H
    SQSHL V27.2D, V31.2D, #0x19
    SQDMULL  V10.4S, V14.4H, V11.4H
    SRSHR  V31.2S, V25.2S, #26
    SQRSHRN V22.8B, V30.8H, #6
    SQRDMULH  V6.4H, V31.4H, V1.H[0x0]
    SQXTN2  V17.4S, V27.2D
    SQSHRN V24.8B, V23.8H, #8
    SQSHL V11.2D, V22.2D, #0x6
    SRHADD  V16.2S, V17.2S, V17.2S
    SQRDMULH S10, S2, V11.S[0x1]
    SMULL2  V23.4S, V16.8H, V6.8H
    SQRDMULH  V29.8H, V10.8H, V9.H[0x6]
    SQSHRN2 V11.8H, V24.4S, #3
    SQDMULL D1, S12, V23.S[0x2]
    SXTL V22.8H, V11.8B
    SADDL2  V8.4S, V14.8H, V26.8H
    SSHL  V14.4S, V1.4S, V26.4S
    SQSHRN V10.8B, V22.8H, #3
    SABA  V30.16B, V0.16B, V8.16B
    SQRSHRUN V25.2S, V24.2D, #1
    SQSHLU  V8.8H, V1.8H, #0xc
    SQSHRN V12.4H, V29.4S, #16
    SQDMULL S2, H12, V12.H[0x3]
    SQXTUN  V22.4H, V10.4S
    SRSRA V16.2D, V8.2D, #54
    SMULL V26.4S, V18.4H, V14.H[0x1]
    SQSHRN V14.8B, V2.8H, #1
    SRHADD  V10.4H, V28.4H, V7.4H
    SQRSHRN2 V18.16B, V25.8H, #7
    SQSHL  V0.4H, V26.4H, #0x2
    SRSHR V31.2D, V16.2D, #53
    SQDMULH  V7.4H, V31.4H, V12.H[0x6]
    SXTL2 V1.8H, V22.16B
    SMLSL2  V25.2D, V14.4S, V16.4S
    SQRDMULH  V1.8H, V18.8H, V8.H[0x7]
    SQDMLSL2  V18.2D, V3.4S, V25.4S
    SMOV  X7, V19.B[0x9]
    SQDMULL  V14.4S, V10.4H, V30.4H
    SXTL2 V30.8H, V1.16B
    SMULL2 V16.2D, V15.4S, V24.S[0x1]
    SQSHL  V8.16B, V19.16B, #0x4
    SMOV  X21, V16.H[0x5]
    SMLAL2  V22.4S, V8.8H, V26.8H
    SSUBW  V17.8H, V0.8H, V7.8B
    SMLAL2 V26.4S, V30.8H, V5.H[0x2]
    SQNEG  V8.8H, V23.8H
    SQSUB  V1.4H, V8.4H, V5.4H
    SQXTN  V25.2S, V18.2D
    SQDMULL D8, S17, V1.S[0x0]
    SSUBW  V18.4S, V25.4S, V26.4H
    SQRDMULH H23, H22, V8.H[0x2]
    SQSHL V7.2D, V18.2D, #0x3c
    SQRSHRUN V1.2S, V7.2D, #11
    SRSHL  V25.2D, V3.2D, V1.2D
    SSRA  V7.2S, V23.2S, #7
    SQDMULL V10.2D, V30.2S, V14.S[0x1]
    SQDMULH S30, S10, V24.S[0x1]
    SMLSL2  V0.2D, V13.4S, V7.4S
    SSRA  V24.16B, V18.16B, #6
    SQDMULH  V14.8H, V24.8H, V1.H[0x1]
    SMOV  X27, V5.B[0x9]
    SQRSHRN2 V10.8H, V0.4S, #7
    SRSRA V16.2D, V19.2D, #7
    SABDL2  V1.2D, V14.4S, V10.4S
    SQSHRN V8.2S, V1.2D, #11
    SRSHR V26.2D, V25.2D, #24
    SQDMULL V2.2D, V30.2S, V16.S[0x3]
    SQDMLAL2 V7.2D, V19.4S, V8.S[0x0]
    SRSHR  V3.2S, V2.2S, #19
    SSUBL  V23.2D, V7.2S, V26.2S
    SADDLP  V14.2D, V2.4S
    SQDMLSL  V24.4S, V19.4H, V7.4H
    SQDMLSL2  V1.2D, V30.4S, V1.4S
    SMLSL2 V25.4S, V29.8H, V3.H[0x4]
    SMLSL  V29.2D, V13.2S, V2.2S
    SMLAL V8.2D, V1.2S, V12.S[0x0]
    SQNEG  V21.16B, V2.16B
    SQRSHRUN2 V10.4S, V9.2D, #8
    SMOV  X21, V17.B[0x1]
    SADDL  V2.4S, V31.4H, V12.4H
    SHSUB  V2.8B, V18.8B, V14.8B
    SQSHRN V17.2S, V23.2D, #27
    SRSHR  V16.2S, V24.2S, #25
    SQABS  V14.8H, V16.8H
    SSHLL2 V27.2D, V10.4S, #0xb
    SRSRA  V3.4S, V14.4S, #31
    SQRSHRN2 V9.16B, V25.8H, #7
    SSHLL V23.8H, V2.8B, #0x7
    SQDMLAL V26.4S, V8.4H, V3.H[0x1]
    SQSUB  V13.16B, V29.16B, V17.16B
    SSHLL V1.4S, V26.4H, #0x5
    SABDL  V18.8H, V21.8B, V21.8B
    SQDMLSL2 V16.4S, V27.8H, V8.H[0x5]
    SQDMLAL2  V17.4S, V19.8H, V23.8H
    SQDMULL S3, H9, V13.H[0x2]
    SQXTN  V25.8B, V30.8H
    SSHLL2 V7.2D, V3.4S, #0x13
    SQRDMULH  V12.2S, V25.2S, V8.2S
    SSUBL  V13.4S, V18.4H, V17.4H
    SQDMULH S17, S19, V12.S[0x2]
    SQDMULL S24, H17, V7.H[0x6]
    SQXTUN  V12.8B, V26.8H
    SQRDMULH  V10.4H, V1.4H, V12.H[0x4]
    SSHLL V27.8H, V24.8B, #0x5
    SSUBW  V9.8H, V10.8H, V16.8B
    SMLAL V29.4S, V13.4H, V13.H[0x2]
    SRSHR V13.2D, V18.2D, #55
    SRSHR V7.2D, V14.2D, #39
    SQRSHL  V18.2D, V6.2D, V28.2D
    SRSHR V23.2D, V16.2D, #9
    SQABS  V10.2S, V13.2S
    SQADD  V26.4H, V23.4H, V28.4H
    SQRSHRUN2 V6.16B, V26.8H, #2
    SQRSHRN V19.2S, V17.2D, #9
    SSHLL2 V23.2D, V27.4S, #0x17
    SQDMULL S17, H24, V9.H[0x2]
    SQSHLU  V16.16B, V17.16B, #0x3
    SRSRA V8.2D, V25.2D, #57
    SQSHL V24.2D, V12.2D, #0x26
    SQDMULL2 V2.4S, V8.8H, V8.H[0x2]
    SSHL  V28.16B, V5.16B, V16.16B
    SSHR  V27.16B, V29.16B, #2
    SMLAL V16.2D, V18.2S, V1.S[0x1]
    SMLAL2  V29.8H, V16.16B, V16.16B
    SADDL2  V18.2D, V23.4S, V10.4S
    SQRSHRN2 V13.8H, V7.4S, #7
    SQRSHRN V8.4H, V19.4S, #12
    SMOV  X16, V2.H[0x1]
    SQXTUN  V1.4H, V29.4S
    SHSUB  V12.8B, V6.8B, V27.8B
    SSHLL V16.4S, V1.4H, #0x1
    SMOV  X27, V30.S[0x1]
    SSHLL2 V1.8H, V25.16B, #0x5
    SABDL2  V25.4S, V16.8H, V13.8H
    SQDMLSL2 V23.4S, V25.8H, V0.H[0x7]
    SQDMLAL V16.2D, V6.2S, V8.S[0x3]
    SQXTUN2  V10.4S, V12.2D
    SRSHR  V3.16B, V16.16B, #2
    SQSHRUN2 V2.16B, V10.8H, #3
    SMLAL V29.4S, V5.4H, V13.H[0x3]
    SSHLL2 V25.4S, V21.8H, #0x7
    SQSHLU  V12.16B, V28.16B, #0x0
    SQSHL V28.2D, V18.2D, #0x38
    SQDMLAL2 V18.2D, V1.4S, V23.S[0x1]
    SQSHRN2 V21.8H, V3.4S, #15
    SABD  V8.8B, V1.8B, V22.8B
    SADDLP  V3.4H, V8.8B
    SQSHL  V30.2S, V22.2S, #0xf
    SQDMULL V8.4S, V18.4H, V5.H[0x4]
    SSRA V13.2D, V10.2D, #46
    SQDMULH H23, H21, V7.H[0x3]
    SQRSHRUN2 V18.8H, V30.4S, #11
    SSRA  V17.4H, V11.4H, #14
    SQDMLSL S0, H18, V2.H[0x6]
    SMLAL2 V17.4S, V17.8H, V13.H[0x5]
    SQSHL  V5.8B, V2.8B, V29.8B
    SQDMLSL V13.4S, V25.4H, V12.H[0x4]
    SQDMLSL D12, S17, V28.S[0x3]
    SQRSHRUN2 V25.16B, V28.8H, #4
    SQSHL  V16.4H, V25.4H, #0x2
    SQDMULL S29, H5, V0.H[0x4]
    SMLAL2 V28.4S, V10.8H, V11.H[0x5]
    SQRSHRUN2 V25.4S, V13.2D, #32
    SQXTUN2  V7.4S, V8.2D
    SQDMLAL S6, H7, V12.H[0x4]
    SQDMLAL S11, H3, V6.H[0x0]
    SMOV  X18, V2.H[0x1]
    SQSHRN V8.8B, V23.8H, #1
    SMOV W23, V8.B[0x4]
    SQABS  V7.2D, V1.2D
    SQDMULL2 V22.2D, V29.4S, V16.S[0x3]
    SQDMLSL2 V6.4S, V25.8H, V7.H[0x7]
    SQRSHRUN2 V25.4S, V11.2D, #21
    SQDMLAL  V8.2D, V9.2S, V28.2S
    SRSRA V13.2D, V6.2D, #42
    SRSHL  V10.2D, V25.2D, V8.2D
    SQSHL  V8.4H, V14.4H, V26.4H
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_14
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X8, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSignedOperation_TestFail
    MRS  X2, FPSR
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x800, LSL #16
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D4
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X8, #0x800, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D11
    MOVZ  X8, #0xffc0, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D15
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D17
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D20
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X8, #0x800, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    FMOV  X2, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail

TSRTAdvsimdVectorSignedOperation_TestEnd:
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
TSRTAdvsimdVectorSignedOperation_TestFail:
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
