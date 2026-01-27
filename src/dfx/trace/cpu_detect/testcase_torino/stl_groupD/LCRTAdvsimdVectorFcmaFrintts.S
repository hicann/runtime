.global LCRTAdvsimdVectorFcmaFrintts

.text
.p2align 4

LCRTAdvsimdVectorFcmaFrintts:

LCRTAdvsimdVectorFcmaFrintts_TestBegin:
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
    MOVZ  X2, #0x4133, LSL #0
    MOVK  X2, #0x7898, LSL #16
    MOVK  X2, #0x416b, LSL #32
    MOVK  X2, #0x10c6, LSL #48
    MOVZ  X3, #0xd926, LSL #0
    MOVK  X3, #0x1dda, LSL #16
    MOVK  X3, #0x8468, LSL #32
    MOVK  X3, #0x7b7b, LSL #48
    MOVZ  X4, #0x79e8, LSL #0
    MOVK  X4, #0x5f16, LSL #16
    MOVK  X4, #0x43b8, LSL #32
    MOVK  X4, #0x63d0, LSL #48
    MOVZ  X5, #0xbff2, LSL #0
    MOVK  X5, #0x6240, LSL #16
    MOVK  X5, #0xfc0a, LSL #32
    MOVK  X5, #0x90ed, LSL #48
    MOVZ  X6, #0x8362, LSL #0
    MOVK  X6, #0xff10, LSL #16
    MOVK  X6, #0x2885, LSL #32
    MOVK  X6, #0x3b79, LSL #48
    MOVZ  X7, #0x5b1c, LSL #0
    MOVK  X7, #0xc615, LSL #16
    MOVK  X7, #0x36d9, LSL #32
    MOVK  X7, #0x25f2, LSL #48
    MOVZ  X8, #0x4732, LSL #0
    MOVK  X8, #0xa1f2, LSL #16
    MOVK  X8, #0xbde5, LSL #32
    MOVK  X8, #0x783, LSL #48
    MOVZ  X9, #0x5d6, LSL #0
    MOVK  X9, #0x104b, LSL #16
    MOVK  X9, #0xced5, LSL #32
    MOVK  X9, #0x1004, LSL #48
    MOVZ  X10, #0x1d8a, LSL #0
    MOVK  X10, #0x57f2, LSL #16
    MOVK  X10, #0xa4fb, LSL #32
    MOVK  X10, #0x2ac0, LSL #48
    MOVZ  X11, #0xe4a7, LSL #0
    MOVK  X11, #0xe680, LSL #16
    MOVK  X11, #0xddfc, LSL #32
    MOVK  X11, #0x1865, LSL #48
    MOVZ  X12, #0xa966, LSL #0
    MOVK  X12, #0xd0bd, LSL #16
    MOVK  X12, #0x5297, LSL #32
    MOVK  X12, #0xc5eb, LSL #48
    MOVZ  X13, #0xe79d, LSL #0
    MOVK  X13, #0x80c5, LSL #16
    MOVK  X13, #0x55c3, LSL #32
    MOVK  X13, #0x8f29, LSL #48
    MOVZ  X14, #0x3806, LSL #0
    MOVK  X14, #0xadc3, LSL #16
    MOVK  X14, #0xf2aa, LSL #32
    MOVK  X14, #0x4bcd, LSL #48
    MOVZ  X15, #0x32eb, LSL #0
    MOVK  X15, #0x72f7, LSL #16
    MOVK  X15, #0x8d3, LSL #32
    MOVK  X15, #0x1297, LSL #48
    MOVZ  X16, #0xc9a8, LSL #0
    MOVK  X16, #0x9a7c, LSL #16
    MOVK  X16, #0x364c, LSL #32
    MOVK  X16, #0x1eaf, LSL #48
    MOVZ  X17, #0x1514, LSL #0
    MOVK  X17, #0xa66c, LSL #16
    MOVK  X17, #0xf3ce, LSL #32
    MOVK  X17, #0x5e10, LSL #48
    MOVZ  X23, #0x1e04, LSL #0
    MOVK  X23, #0x1f96, LSL #16
    MOVK  X23, #0x705a, LSL #32
    MOVK  X23, #0xeb1a, LSL #48
    MOVZ  X24, #0xb63b, LSL #0
    MOVK  X24, #0xd140, LSL #16
    MOVK  X24, #0xe5f2, LSL #32
    MOVK  X24, #0x8f4b, LSL #48
    MOVZ  X25, #0x1e01, LSL #0
    MOVK  X25, #0xf6cc, LSL #16
    MOVK  X25, #0xda56, LSL #32
    MOVK  X25, #0x91ec, LSL #48
    MOVZ  X26, #0x77c7, LSL #0
    MOVK  X26, #0xeb74, LSL #16
    MOVK  X26, #0x8aa9, LSL #32
    MOVK  X26, #0x3ffc, LSL #48
    MOVZ  X27, #0x7a77, LSL #0
    MOVK  X27, #0xc810, LSL #16
    MOVK  X27, #0x716f, LSL #32
    MOVK  X27, #0x515a, LSL #48
    MOVZ  X28, #0xeb5, LSL #0
    MOVK  X28, #0x1013, LSL #16
    MOVK  X28, #0xa38a, LSL #32
    MOVK  X28, #0x857c, LSL #48
    MOVZ  X29, #0x2ea8, LSL #0
    MOVK  X29, #0x6aa2, LSL #16
    MOVK  X29, #0xb925, LSL #32
    MOVK  X29, #0xb303, LSL #48
    MOVZ  X4, #0x7941, LSL #0
    MOVK  X4, #0x97f0, LSL #16
    MOVK  X4, #0x355c, LSL #32
    MOVK  X4, #0x7fa2, LSL #48
    MSR  FPCR, X4
    MRS  X29, FPCR
    MOVZ  X13, #0x60ff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    AND  X29, X29, X13
    MOVZ  X13, #0x0, LSL #0
    ORR  X29, X29, X13
    MSR  FPCR, X29
    ISB  SY
    MOVZ  X4, #0xfb88, LSL #0
    MOVK  X4, #0x2942, LSL #16
    MOVK  X4, #0x3621, LSL #32
    MOVK  X4, #0xedfb, LSL #48
    MSR  FPSR, X4
    MRS  X23, FPSR
    MOVZ  X8, #0xff60, LSL #0
    MOVK  X8, #0x7ff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    AND  X23, X23, X8
    MOVZ  X8, #0x0, LSL #0
    ORR  X23, X23, X8
    MSR  FPSR, X23
    ISB  SY
    SUBS  X5, X26, X10, LSR #30
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xe473, LSL #0
    MOVK  X2, #0x6d3f, LSL #16
    MOVK  X2, #0x2f9c, LSL #32
    MOVK  X2, #0x4521, LSL #48
    MOVZ  X3, #0x61ef, LSL #0
    MOVK  X3, #0x131b, LSL #16
    MOVK  X3, #0xf11e, LSL #32
    MOVK  X3, #0xeaa8, LSL #48
    MOVZ  X4, #0x61eb, LSL #0
    MOVK  X4, #0xd0e7, LSL #16
    MOVK  X4, #0x693e, LSL #32
    MOVK  X4, #0x9bec, LSL #48
    MOVZ  X5, #0x3a47, LSL #0
    MOVK  X5, #0x85, LSL #16
    MOVK  X5, #0xeba0, LSL #32
    MOVK  X5, #0x82ad, LSL #48
    MOVZ  X6, #0x583c, LSL #0
    MOVK  X6, #0x975, LSL #16
    MOVK  X6, #0x773f, LSL #32
    MOVK  X6, #0x7b1e, LSL #48
    MOVZ  X7, #0xe88, LSL #0
    MOVK  X7, #0x5ac9, LSL #16
    MOVK  X7, #0x6528, LSL #32
    MOVK  X7, #0xc105, LSL #48
    MOVZ  X8, #0xe4c7, LSL #0
    MOVK  X8, #0xd18c, LSL #16
    MOVK  X8, #0x236d, LSL #32
    MOVK  X8, #0x2d2a, LSL #48
    MOVZ  X9, #0x316b, LSL #0
    MOVK  X9, #0x3a69, LSL #16
    MOVK  X9, #0xaf6a, LSL #32
    MOVK  X9, #0x4e78, LSL #48
    MOVZ  X10, #0xb934, LSL #0
    MOVK  X10, #0x90ec, LSL #16
    MOVK  X10, #0x9c14, LSL #32
    MOVK  X10, #0x57f6, LSL #48
    MOVZ  X11, #0xdda4, LSL #0
    MOVK  X11, #0x96a6, LSL #16
    MOVK  X11, #0xcfe7, LSL #32
    MOVK  X11, #0xaa78, LSL #48
    MOVZ  X12, #0x2025, LSL #0
    MOVK  X12, #0xed7f, LSL #16
    MOVK  X12, #0x4b7b, LSL #32
    MOVK  X12, #0x930d, LSL #48
    MOVZ  X13, #0x8476, LSL #0
    MOVK  X13, #0xa19b, LSL #16
    MOVK  X13, #0xd9e1, LSL #32
    MOVK  X13, #0x1659, LSL #48
    MOVZ  X14, #0xd9ef, LSL #0
    MOVK  X14, #0xc007, LSL #16
    MOVK  X14, #0x12d5, LSL #32
    MOVK  X14, #0xa1e3, LSL #48
    MOVZ  X15, #0x5414, LSL #0
    MOVK  X15, #0xc7cf, LSL #16
    MOVK  X15, #0x1f34, LSL #32
    MOVK  X15, #0x515a, LSL #48
    MOVZ  X16, #0x168f, LSL #0
    MOVK  X16, #0x6427, LSL #16
    MOVK  X16, #0x7b8b, LSL #32
    MOVK  X16, #0x9315, LSL #48
    MOVZ  X17, #0x76e1, LSL #0
    MOVK  X17, #0x25ff, LSL #16
    MOVK  X17, #0x9e0e, LSL #32
    MOVK  X17, #0xb386, LSL #48
    MOVZ  X23, #0xac95, LSL #0
    MOVK  X23, #0x6db7, LSL #16
    MOVK  X23, #0xc72e, LSL #32
    MOVK  X23, #0xf852, LSL #48
    MOVZ  X24, #0xe0ab, LSL #0
    MOVK  X24, #0xde85, LSL #16
    MOVK  X24, #0x422a, LSL #32
    MOVK  X24, #0x952e, LSL #48
    MOVZ  X25, #0x7d57, LSL #0
    MOVK  X25, #0x9d1b, LSL #16
    MOVK  X25, #0x5121, LSL #32
    MOVK  X25, #0x1a43, LSL #48
    MOVZ  X26, #0x995a, LSL #0
    MOVK  X26, #0x6126, LSL #16
    MOVK  X26, #0x87b, LSL #32
    MOVK  X26, #0x6d1c, LSL #48
    MOVZ  X27, #0x8567, LSL #0
    MOVK  X27, #0x5155, LSL #16
    MOVK  X27, #0xc943, LSL #32
    MOVK  X27, #0xb56d, LSL #48
    MOVZ  X28, #0xbb61, LSL #0
    MOVK  X28, #0x1670, LSL #16
    MOVK  X28, #0xfc0b, LSL #32
    MOVK  X28, #0x3ae5, LSL #48
    MOVZ  X29, #0x9357, LSL #0
    MOVK  X29, #0xd3b6, LSL #16
    MOVK  X29, #0xfd6c, LSL #32
    MOVK  X29, #0x629a, LSL #48
    FMOV  D0, X6
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X12
    FMOV  D2, X25
    FMOV  V2.D[1], X29
    FMOV  D3, X16
    FMOV  V3.D[1], X13
    FMOV  D4, X28
    FMOV  V4.D[1], X24
    FMOV  D5, X16
    FMOV  V5.D[1], X7
    FMOV  D6, X6
    FMOV  V6.D[1], X14
    FMOV  D7, X9
    FMOV  V7.D[1], X3
    FMOV  D8, X3
    FMOV  V8.D[1], X23
    FMOV  D9, X5
    FMOV  V9.D[1], X26
    FMOV  D10, X17
    FMOV  V10.D[1], X9
    FMOV  D11, X10
    FMOV  V11.D[1], X5
    FMOV  D12, X24
    FMOV  V12.D[1], X14
    FMOV  D13, X10
    FMOV  V13.D[1], X15
    FMOV  D14, X13
    FMOV  V14.D[1], X29
    FMOV  D15, X25
    FMOV  V15.D[1], X26
    FMOV  D16, X27
    FMOV  V16.D[1], X10
    FMOV  D17, X12
    FMOV  V17.D[1], X7
    FMOV  D18, X15
    FMOV  V18.D[1], X10
    FMOV  D19, X8
    FMOV  V19.D[1], X9
    FMOV  D20, X8
    FMOV  V20.D[1], X5
    FMOV  D21, X10
    FMOV  V21.D[1], X15
    FMOV  D22, X29
    FMOV  V22.D[1], X14
    FMOV  D23, X28
    FMOV  V23.D[1], X23
    FMOV  D24, X24
    FMOV  V24.D[1], X11
    FMOV  D25, X8
    FMOV  V25.D[1], X8
    FMOV  D26, X9
    FMOV  V26.D[1], X27
    FMOV  D27, X10
    FMOV  V27.D[1], X14
    FMOV  D28, X29
    FMOV  V28.D[1], X28
    FMOV  D29, X15
    FMOV  V29.D[1], X6
    FMOV  D30, X9
    FMOV  V30.D[1], X15
    FMOV  D31, X27
    FMOV  V31.D[1], X7
    FCADD V1.2D, V30.2D, V18.2D, #270
    FCADD V26.2D, V23.2D, V23.2D, #270
    FCADD V24.2D, V14.2D, V18.2D, #270
    FCADD V28.2D, V28.2D, V29.2D, #270
    FCADD V24.4S, V31.4S, V20.4S, #90
    FCADD V24.2D, V16.2D, V28.2D, #270
    FCADD V26.4S, V2.4S, V12.4S, #90
    FCADD V22.4S, V21.4S, V27.4S, #270
    FCADD V10.4S, V24.4S, V17.4S, #90
    FCADD V6.4S, V26.4S, V17.4S, #90
    FCADD V25.2S, V25.2S, V1.2S, #270
    FCADD V24.2S, V19.2S, V22.2S, #270
    FCADD V28.2S, V6.2S, V25.2S, #90
    FCADD V24.4H, V23.4H, V28.4H, #270
    FCADD V10.2S, V24.2S, V11.2S, #270
    FCADD V14.4H, V5.4H, V13.4H, #270
    FCADD V28.2S, V8.2S, V4.2S, #90
    FCADD V8.4H, V23.4H, V28.4H, #270
    FCADD V12.2S, V23.2S, V5.2S, #90
    FCADD V1.2S, V12.2S, V16.2S, #270
    FCMLA V12.4H, V8.4H, V26.H[0x0], #180
    FCMLA V6.4H, V14.4H, V0.H[0x1], #90
    FCMLA V26.4H, V7.4H, V4.H[0x1], #0
    FCMLA V7.4H, V6.4H, V5.H[0x0], #90
    FCMLA V30.4H, V2.4H, V21.H[0x0], #90
    FCMLA V3.4H, V7.4H, V23.H[0x0], #0
    FCMLA V20.4H, V14.4H, V10.H[0x1], #180
    FCMLA V27.4H, V1.4H, V5.H[0x1], #90
    FCMLA V4.4H, V25.4H, V15.H[0x1], #0
    FCMLA V15.4H, V23.4H, V11.H[0x0], #0
    FCMLA V7.4S, V25.4S, V15.S[0x1], #0
    FCMLA V23.4S, V7.4S, V11.S[0x1], #90
    FCMLA V7.4S, V15.4S, V15.S[0x0], #270
    FCMLA V27.4S, V7.4S, V19.S[0x1], #180
    FCMLA V26.4S, V17.4S, V15.S[0x1], #0
    FCMLA V30.4S, V12.4S, V19.S[0x1], #90
    FCMLA V27.4S, V1.4S, V3.S[0x0], #90
    FCMLA V11.4S, V27.4S, V5.S[0x0], #270
    FCMLA V11.4S, V20.4S, V11.S[0x0], #180
    FCMLA V9.4S, V23.4S, V3.S[0x1], #90
    FCMLA V23.8H, V4.8H, V3.H[0x3], #0
    FCMLA V11.8H, V11.8H, V11.H[0x1], #0
    FCMLA V18.8H, V7.8H, V13.H[0x2], #90
    FCMLA V18.8H, V16.8H, V26.H[0x0], #180
    FCMLA V23.8H, V18.8H, V9.H[0x2], #180
    FCMLA V14.8H, V23.8H, V30.H[0x0], #270
    FCMLA V0.8H, V1.8H, V8.H[0x0], #0
    FCMLA V6.8H, V4.8H, V19.H[0x3], #90
    FCMLA V26.8H, V1.8H, V15.H[0x0], #0
    FCMLA V21.8H, V18.8H, V24.H[0x2], #0
    FCMLA V8.4S, V13.4S, V20.4S, #90
    FCMLA V22.2D, V28.2D, V8.2D, #90
    FCMLA V4.2D, V19.2D, V3.2D, #0
    FCMLA V25.8H, V4.8H, V20.8H, #0
    FCMLA V31.2D, V3.2D, V30.2D, #180
    FCMLA V9.2D, V31.2D, V21.2D, #90
    FCMLA V22.2D, V11.2D, V8.2D, #0
    FCMLA V30.8H, V14.8H, V6.8H, #0
    FCMLA V25.4S, V5.4S, V26.4S, #270
    FCMLA V2.4S, V25.4S, V25.4S, #0
    FCMLA V7.4H, V0.4H, V0.4H, #270
    FCMLA V18.2S, V28.2S, V22.2S, #180
    FCMLA V18.2S, V6.2S, V22.2S, #0
    FCMLA V18.4H, V19.4H, V2.4H, #90
    FCMLA V7.2S, V10.2S, V30.2S, #0
    FCMLA V9.4H, V10.4H, V13.4H, #90
    FCMLA V7.2S, V9.2S, V15.2S, #0
    FCMLA V23.4H, V27.4H, V31.4H, #180
    FCMLA V30.4H, V11.4H, V24.4H, #0
    FCMLA V5.2S, V4.2S, V11.2S, #270
    FRINT32X V2.4S, V24.4S
    FRINT32X V20.2S, V22.2S
    FRINT32X V4.2S, V3.2S
    FRINT32X V0.4S, V19.4S
    FRINT32X V9.2D, V4.2D
    FRINT32X V4.2S, V5.2S
    FRINT32X V31.4S, V7.4S
    FRINT32X V14.2S, V4.2S
    FRINT32X V1.4S, V31.4S
    FRINT32X V31.2D, V11.2D
    FRINT32Z V4.2D, V9.2D
    FRINT32Z V4.4S, V22.4S
    FRINT32Z V15.2S, V14.2S
    FRINT32Z V5.2D, V15.2D
    FRINT32Z V3.2S, V18.2S
    FRINT32Z V26.4S, V30.4S
    FRINT32Z V9.2S, V31.2S
    FRINT32Z V19.2S, V24.2S
    FRINT32Z V18.4S, V4.4S
    FRINT32Z V30.4S, V18.4S
    FRINT64X V11.4S, V9.4S
    FRINT64X V7.2D, V5.2D
    FRINT64X V31.4S, V19.4S
    FRINT64X V13.2D, V31.2D
    FRINT64X V10.2D, V7.2D
    FRINT64X V14.4S, V26.4S
    FRINT64X V5.2S, V10.2S
    FRINT64X V22.2S, V13.2S
    FRINT64X V24.2D, V11.2D
    FRINT64X V31.4S, V30.4S
    FRINT64Z V14.2S, V20.2S
    FRINT64Z V13.2S, V24.2S
    FRINT64Z V10.2D, V31.2D
    FRINT64Z V19.2S, V14.2S
    FRINT64Z V17.2D, V0.2D
    FRINT64Z V14.2S, V22.2S
    FRINT64Z V0.4S, V17.4S
    FRINT64Z V22.2S, V9.2S
    FRINT64Z V24.2D, V15.2D
    FRINT64Z V22.2S, V22.2S
    MOVZ  X6, #0xe473, LSL #0
    MOVK  X6, #0x6d3f, LSL #16
    MOVK  X6, #0x2f9c, LSL #32
    MOVK  X6, #0x4521, LSL #48
    SUB  X12, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x61ef, LSL #0
    MOVK  X6, #0x131b, LSL #16
    MOVK  X6, #0xf11e, LSL #32
    MOVK  X6, #0xeaa8, LSL #48
    SUB  X12, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x61eb, LSL #0
    MOVK  X6, #0xd0e7, LSL #16
    MOVK  X6, #0x693e, LSL #32
    MOVK  X6, #0x9bec, LSL #48
    SUB  X12, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x3a47, LSL #0
    MOVK  X6, #0x85, LSL #16
    MOVK  X6, #0xeba0, LSL #32
    MOVK  X6, #0x82ad, LSL #48
    SUB  X12, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xe88, LSL #0
    MOVK  X6, #0x5ac9, LSL #16
    MOVK  X6, #0x6528, LSL #32
    MOVK  X6, #0xc105, LSL #48
    SUB  X12, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xe4c7, LSL #0
    MOVK  X6, #0xd18c, LSL #16
    MOVK  X6, #0x236d, LSL #32
    MOVK  X6, #0x2d2a, LSL #48
    SUB  X12, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x316b, LSL #0
    MOVK  X6, #0x3a69, LSL #16
    MOVK  X6, #0xaf6a, LSL #32
    MOVK  X6, #0x4e78, LSL #48
    SUB  X12, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xb934, LSL #0
    MOVK  X6, #0x90ec, LSL #16
    MOVK  X6, #0x9c14, LSL #32
    MOVK  X6, #0x57f6, LSL #48
    SUB  X12, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xdda4, LSL #0
    MOVK  X6, #0x96a6, LSL #16
    MOVK  X6, #0xcfe7, LSL #32
    MOVK  X6, #0xaa78, LSL #48
    SUB  X12, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x8476, LSL #0
    MOVK  X6, #0xa19b, LSL #16
    MOVK  X6, #0xd9e1, LSL #32
    MOVK  X6, #0x1659, LSL #48
    SUB  X12, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xd9ef, LSL #0
    MOVK  X6, #0xc007, LSL #16
    MOVK  X6, #0x12d5, LSL #32
    MOVK  X6, #0xa1e3, LSL #48
    SUB  X12, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x5414, LSL #0
    MOVK  X6, #0xc7cf, LSL #16
    MOVK  X6, #0x1f34, LSL #32
    MOVK  X6, #0x515a, LSL #48
    SUB  X12, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x168f, LSL #0
    MOVK  X6, #0x6427, LSL #16
    MOVK  X6, #0x7b8b, LSL #32
    MOVK  X6, #0x9315, LSL #48
    SUB  X12, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xac95, LSL #0
    MOVK  X6, #0x6db7, LSL #16
    MOVK  X6, #0xc72e, LSL #32
    MOVK  X6, #0xf852, LSL #48
    SUB  X12, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xe0ab, LSL #0
    MOVK  X6, #0xde85, LSL #16
    MOVK  X6, #0x422a, LSL #32
    MOVK  X6, #0x952e, LSL #48
    SUB  X12, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x7d57, LSL #0
    MOVK  X6, #0x9d1b, LSL #16
    MOVK  X6, #0x5121, LSL #32
    MOVK  X6, #0x1a43, LSL #48
    SUB  X12, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x995a, LSL #0
    MOVK  X6, #0x6126, LSL #16
    MOVK  X6, #0x87b, LSL #32
    MOVK  X6, #0x6d1c, LSL #48
    SUB  X12, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x8567, LSL #0
    MOVK  X6, #0x5155, LSL #16
    MOVK  X6, #0xc943, LSL #32
    MOVK  X6, #0xb56d, LSL #48
    SUB  X12, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0xbb61, LSL #0
    MOVK  X6, #0x1670, LSL #16
    MOVK  X6, #0xfc0b, LSL #32
    MOVK  X6, #0x3ae5, LSL #48
    SUB  X12, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X6, #0x9357, LSL #0
    MOVK  X6, #0xd3b6, LSL #16
    MOVK  X6, #0xfd6c, LSL #32
    MOVK  X6, #0x629a, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X6, FPSR
    MOVZ  X12, #0x95, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc3e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D0
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D1
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D2
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D3
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X12, #0x5400, LSL #0
    MOVK  X12, #0xc7cf, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D4
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D5
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D6
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7bfe, LSL #16
    MOVK  X12, #0xda5f, LSL #32
    MOVK  X12, #0xed67, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D7
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D8
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0x7f7f, LSL #16
    MOVK  X12, #0x7be2, LSL #32
    MOVK  X12, #0x711d, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D9
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc3e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D10
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc3e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D11
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D12
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x9f7f, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D13
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D15
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X12, #0xb934, LSL #0
    MOVK  X12, #0x90ec, LSL #16
    MOVK  X12, #0x9c14, LSL #32
    MOVK  X12, #0x57f6, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D16
    MOVZ  X12, #0x8567, LSL #0
    MOVK  X12, #0x5155, LSL #16
    MOVK  X12, #0xc943, LSL #32
    MOVK  X12, #0xb56d, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc3e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X12, #0x5400, LSL #0
    MOVK  X12, #0xc7cf, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D18
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D19
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D20
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D21
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D22
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D23
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D24
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc3e0, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D25
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x57f7, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x641f, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D26
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D27
    MOVZ  X12, #0x966d, LSL #0
    MOVK  X12, #0xfb56, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0x7f7f, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D28
    MOVZ  X12, #0xfc0a, LSL #0
    MOVK  X12, #0xbae5, LSL #16
    MOVK  X12, #0xf11d, LSL #32
    MOVK  X12, #0xeaa8, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X12, #0x583c, LSL #0
    MOVK  X12, #0x975, LSL #16
    MOVK  X12, #0x773f, LSL #32
    MOVK  X12, #0x7b1e, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D29
    MOVZ  X12, #0x5414, LSL #0
    MOVK  X12, #0xc7cf, LSL #16
    MOVK  X12, #0x1f34, LSL #32
    MOVK  X12, #0x515a, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X12, #0x5400, LSL #0
    MOVK  X12, #0xc7cf, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D30
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X12, #0x5400, LSL #0
    MOVK  X12, #0xc7cf, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X6, D31
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X17, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0xf575, LSL #0
    MOVK  X2, #0x3ce2, LSL #16
    MOVK  X2, #0xcfac, LSL #32
    MOVK  X2, #0x5ab3, LSL #48
    MOVZ  X3, #0x261a, LSL #0
    MOVK  X3, #0xecc2, LSL #16
    MOVK  X3, #0x8440, LSL #32
    MOVK  X3, #0xc869, LSL #48
    MOVZ  X4, #0xd69c, LSL #0
    MOVK  X4, #0x7923, LSL #16
    MOVK  X4, #0x770c, LSL #32
    MOVK  X4, #0xb9a2, LSL #48
    MOVZ  X5, #0x573e, LSL #0
    MOVK  X5, #0xbfaf, LSL #16
    MOVK  X5, #0x8c33, LSL #32
    MOVK  X5, #0x9d48, LSL #48
    MOVZ  X6, #0xf34b, LSL #0
    MOVK  X6, #0xa57b, LSL #16
    MOVK  X6, #0xe667, LSL #32
    MOVK  X6, #0xd127, LSL #48
    MOVZ  X7, #0x70c9, LSL #0
    MOVK  X7, #0x6b8e, LSL #16
    MOVK  X7, #0x4922, LSL #32
    MOVK  X7, #0x8752, LSL #48
    MOVZ  X8, #0x7f5f, LSL #0
    MOVK  X8, #0xf373, LSL #16
    MOVK  X8, #0x7200, LSL #32
    MOVK  X8, #0xe884, LSL #48
    MOVZ  X9, #0xc702, LSL #0
    MOVK  X9, #0x32b3, LSL #16
    MOVK  X9, #0x2e3f, LSL #32
    MOVK  X9, #0xcfee, LSL #48
    MOVZ  X10, #0xd225, LSL #0
    MOVK  X10, #0x6686, LSL #16
    MOVK  X10, #0xeae3, LSL #32
    MOVK  X10, #0x22f, LSL #48
    MOVZ  X11, #0x47bc, LSL #0
    MOVK  X11, #0xd089, LSL #16
    MOVK  X11, #0x8bf7, LSL #32
    MOVK  X11, #0xbd0b, LSL #48
    MOVZ  X12, #0x339f, LSL #0
    MOVK  X12, #0x8e4f, LSL #16
    MOVK  X12, #0xaf26, LSL #32
    MOVK  X12, #0x95a1, LSL #48
    MOVZ  X13, #0xd6ea, LSL #0
    MOVK  X13, #0xf43c, LSL #16
    MOVK  X13, #0x3749, LSL #32
    MOVK  X13, #0xe2ee, LSL #48
    MOVZ  X14, #0x193a, LSL #0
    MOVK  X14, #0xe980, LSL #16
    MOVK  X14, #0xe19f, LSL #32
    MOVK  X14, #0x928e, LSL #48
    MOVZ  X15, #0x2358, LSL #0
    MOVK  X15, #0x39d7, LSL #16
    MOVK  X15, #0x7d2d, LSL #32
    MOVK  X15, #0xee29, LSL #48
    MOVZ  X16, #0x3dfa, LSL #0
    MOVK  X16, #0x95ce, LSL #16
    MOVK  X16, #0x72a9, LSL #32
    MOVK  X16, #0x9d9e, LSL #48
    MOVZ  X17, #0x5e7, LSL #0
    MOVK  X17, #0x293e, LSL #16
    MOVK  X17, #0x54a4, LSL #32
    MOVK  X17, #0x7fa1, LSL #48
    MOVZ  X23, #0x2eec, LSL #0
    MOVK  X23, #0xdafc, LSL #16
    MOVK  X23, #0xcd4, LSL #32
    MOVK  X23, #0xb3b8, LSL #48
    MOVZ  X24, #0x5440, LSL #0
    MOVK  X24, #0x5218, LSL #16
    MOVK  X24, #0xd00a, LSL #32
    MOVK  X24, #0x5fb7, LSL #48
    MOVZ  X25, #0x7c31, LSL #0
    MOVK  X25, #0x2633, LSL #16
    MOVK  X25, #0x1c6a, LSL #32
    MOVK  X25, #0x3a40, LSL #48
    MOVZ  X26, #0xc3af, LSL #0
    MOVK  X26, #0xd041, LSL #16
    MOVK  X26, #0x8afd, LSL #32
    MOVK  X26, #0x9c02, LSL #48
    MOVZ  X27, #0xadd4, LSL #0
    MOVK  X27, #0xcc34, LSL #16
    MOVK  X27, #0x5613, LSL #32
    MOVK  X27, #0x230d, LSL #48
    MOVZ  X28, #0x29fd, LSL #0
    MOVK  X28, #0xc79f, LSL #16
    MOVK  X28, #0xa94a, LSL #32
    MOVK  X28, #0x2e89, LSL #48
    MOVZ  X29, #0xec38, LSL #0
    MOVK  X29, #0xc41b, LSL #16
    MOVK  X29, #0xe306, LSL #32
    MOVK  X29, #0xdbcc, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X2
    FMOV  D3, X15
    FMOV  V3.D[1], X27
    FMOV  D4, X3
    FMOV  V4.D[1], X28
    FMOV  D5, X12
    FMOV  V5.D[1], X24
    FMOV  D6, X17
    FMOV  V6.D[1], X2
    FMOV  D7, X7
    FMOV  V7.D[1], X29
    FMOV  D8, X26
    FMOV  V8.D[1], X10
    FMOV  D9, X27
    FMOV  V9.D[1], X15
    FMOV  D10, X16
    FMOV  V10.D[1], X28
    FMOV  D11, X17
    FMOV  V11.D[1], X29
    FMOV  D12, X12
    FMOV  V12.D[1], X24
    FMOV  D13, X28
    FMOV  V13.D[1], X10
    FMOV  D14, X14
    FMOV  V14.D[1], X27
    FMOV  D15, X8
    FMOV  V15.D[1], X23
    FMOV  D16, X17
    FMOV  V16.D[1], X27
    FMOV  D17, X11
    FMOV  V17.D[1], X7
    FMOV  D18, X16
    FMOV  V18.D[1], X15
    FMOV  D19, X7
    FMOV  V19.D[1], X4
    FMOV  D20, X2
    FMOV  V20.D[1], X2
    FMOV  D21, X16
    FMOV  V21.D[1], X5
    FMOV  D22, X12
    FMOV  V22.D[1], X5
    FMOV  D23, X16
    FMOV  V23.D[1], X9
    FMOV  D24, X4
    FMOV  V24.D[1], X23
    FMOV  D25, X2
    FMOV  V25.D[1], X23
    FMOV  D26, X27
    FMOV  V26.D[1], X13
    FMOV  D27, X23
    FMOV  V27.D[1], X11
    FMOV  D28, X14
    FMOV  V28.D[1], X24
    FMOV  D29, X4
    FMOV  V29.D[1], X29
    FMOV  D30, X7
    FMOV  V30.D[1], X4
    FMOV  D31, X24
    FMOV  V31.D[1], X12
    MOVZ  X13, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_0:
    FCADD V22.4S, V16.4S, V24.4S, #90
    FRINT64Z V19.2D, V29.2D
    FRINT64Z V16.2S, V31.2S
    FCMLA V26.4H, V19.4H, V22.4H, #180
    FCMLA V20.4S, V30.4S, V13.S[0x0], #180
    FCMLA V25.2S, V16.2S, V20.2S, #270
    FCMLA V26.4S, V17.4S, V10.4S, #90
    FRINT64X V29.4S, V13.4S
    FRINT32X V31.2S, V26.2S
    FCMLA V23.8H, V25.8H, V25.H[0x3], #270
    FCMLA V26.4S, V29.4S, V28.4S, #90
    FCADD V2.4H, V10.4H, V23.4H, #270
    FCMLA V31.4H, V14.4H, V31.H[0x1], #270
    FCMLA V2.2D, V26.2D, V31.2D, #0
    FRINT64X V17.2D, V27.2D
    FCADD V28.2S, V19.2S, V20.2S, #270
    FCMLA V24.4H, V29.4H, V27.H[0x0], #180
    FRINT32X V13.2S, V29.2S
    FCADD V26.4S, V3.4S, V15.4S, #270
    FRINT32Z V22.2D, V11.2D
    FRINT64X V30.2S, V21.2S
    FRINT64X V10.2S, V28.2S
    FRINT32X V27.4S, V10.4S
    FRINT64X V31.4S, V11.4S
    FRINT64X V3.2S, V24.2S
    FRINT64Z V26.2D, V31.2D
    FRINT64X V24.2S, V26.2S
    FRINT32Z V20.2D, V27.2D
    FCMLA V30.4H, V27.4H, V22.H[0x1], #270
    FRINT64X V15.2D, V8.2D
    FRINT64X V19.2S, V3.2S
    FRINT32Z V11.2D, V17.2D
    FCADD V9.2S, V24.2S, V13.2S, #270
    FRINT64X V17.2S, V11.2S
    FCMLA V19.2D, V15.2D, V19.2D, #270
    FCADD V17.2S, V29.2S, V12.2S, #270
    FCMLA V9.8H, V23.8H, V30.H[0x1], #270
    FCADD V19.8H, V6.8H, V19.8H, #90
    FCMLA V19.2S, V20.2S, V9.2S, #0
    FRINT64Z V26.4S, V17.4S
    FCMLA V17.2S, V19.2S, V26.2S, #180
    FRINT64X V0.2S, V20.2S
    FCMLA V11.8H, V17.8H, V0.H[0x2], #270
    FRINT32Z V30.4S, V28.4S
    FRINT32Z V17.2D, V22.2D
    FRINT32X V15.4S, V14.4S
    FRINT64X V20.4S, V7.4S
    FRINT32Z V20.2S, V22.2S
    FCMLA V9.4S, V12.4S, V4.S[0x0], #180
    FRINT64X V6.4S, V26.4S
    FCMLA V17.8H, V18.8H, V15.H[0x3], #180
    FRINT32X V0.4S, V31.4S
    FRINT64X V19.2S, V1.2S
    FRINT32X V12.4S, V31.4S
    FCMLA V17.2S, V19.2S, V19.2S, #0
    FCMLA V19.4H, V11.4H, V17.H[0x1], #180
    FRINT64X V14.2D, V12.2D
    FCMLA V30.8H, V9.8H, V0.H[0x2], #270
    FRINT64X V17.4S, V23.4S
    FRINT32X V16.4S, V14.4S
    FRINT64X V31.4S, V6.4S
    FCMLA V10.2S, V19.2S, V1.2S, #180
    FRINT64Z V20.2S, V22.2S
    FCMLA V31.4H, V30.4H, V3.H[0x0], #90
    FCMLA V18.8H, V17.8H, V8.H[0x1], #270
    FRINT64X V3.2D, V18.2D
    FCMLA V20.4H, V31.4H, V21.H[0x1], #90
    FRINT32Z V30.4S, V11.4S
    FRINT32Z V15.2D, V16.2D
    FRINT64Z V22.2S, V30.2S
    FRINT32Z V16.4S, V11.4S
    FRINT64X V14.4S, V15.4S
    FRINT32X V21.2D, V7.2D
    FCADD V3.4H, V10.4H, V9.4H, #90
    FCMLA V21.8H, V22.8H, V12.H[0x0], #270
    FCMLA V21.8H, V20.8H, V13.H[0x1], #90
    FRINT32Z V1.4S, V26.4S
    FCADD V1.4H, V13.4H, V21.4H, #270
    FRINT32X V19.4S, V2.4S
    FCMLA V9.8H, V14.8H, V16.H[0x0], #270
    FRINT64Z V20.2D, V30.2D
    FCMLA V19.4H, V15.4H, V1.H[0x0], #90
    FRINT32X V11.2D, V3.2D
    FRINT32X V7.2S, V9.2S
    FCMLA V11.8H, V11.8H, V7.8H, #270
    FCMLA V19.4H, V12.4H, V19.H[0x1], #0
    FCMLA V23.4S, V30.4S, V3.S[0x0], #0
    FRINT64X V2.2D, V25.2D
    FCADD V23.2S, V29.2S, V4.2S, #270
    FRINT32X V7.2D, V2.2D
    FRINT32Z V1.4S, V17.4S
    FCADD V23.2D, V19.2D, V21.2D, #270
    FRINT64X V30.2D, V20.2D
    FRINT64Z V8.2S, V7.2S
    FCMLA V5.4H, V22.4H, V17.H[0x1], #90
    FRINT64Z V14.4S, V23.4S
    FRINT64Z V5.4S, V30.4S
    FRINT32Z V4.2S, V9.2S
    FCMLA V5.8H, V11.8H, V5.H[0x2], #0
    FRINT32X V7.4S, V8.4S
    FCADD V15.4S, V10.4S, V5.4S, #270
    FCMLA V12.8H, V14.8H, V26.H[0x3], #90
    FRINT32Z V25.2D, V4.2D
    FCADD V1.8H, V26.8H, V15.8H, #270
    FRINT64Z V13.4S, V1.4S
    FCMLA V13.4H, V25.4H, V12.4H, #180
    FCMLA V17.8H, V21.8H, V21.H[0x1], #90
    FRINT64Z V22.4S, V1.4S
    FCADD V30.2D, V8.2D, V15.2D, #270
    FCMLA V7.4H, V18.4H, V14.H[0x1], #0
    FRINT32X V29.2S, V27.2S
    FCMLA V0.4S, V5.4S, V4.4S, #90
    FCMLA V3.4H, V28.4H, V10.H[0x1], #270
    FCMLA V4.4H, V17.4H, V26.H[0x1], #270
    FCADD V11.2D, V25.2D, V27.2D, #270
    FRINT64Z V23.2S, V30.2S
    FCADD V31.4S, V22.4S, V17.4S, #270
    FRINT64Z V22.4S, V29.4S
    FCADD V19.2S, V11.2S, V31.2S, #90
    FRINT64X V14.4S, V13.4S
    FCMLA V15.2D, V19.2D, V14.2D, #180
    FRINT32X V17.2S, V22.2S
    FRINT32Z V8.4S, V10.4S
    FRINT64X V29.2S, V3.2S
    FRINT32Z V22.2S, V4.2S
    FRINT32Z V18.2D, V17.2D
    FRINT64Z V14.2S, V29.2S
    FRINT64X V25.2D, V29.2D
    FRINT32X V13.4S, V30.4S
    FRINT32Z V30.4S, V15.4S
    FCMLA V18.2S, V22.2S, V25.2S, #90
    FCMLA V9.4H, V8.4H, V7.H[0x0], #180
    FRINT64X V23.4S, V0.4S
    FCMLA V18.4S, V9.4S, V14.S[0x0], #0
    FRINT64X V31.2S, V30.2S
    FCMLA V18.8H, V18.8H, V31.H[0x2], #270
    FCMLA V2.4H, V15.4H, V23.H[0x0], #0
    FCMLA V14.8H, V13.8H, V2.8H, #270
    FCMLA V19.4S, V9.4S, V17.4S, #0
    FCMLA V17.8H, V20.8H, V12.H[0x0], #270
    FRINT64Z V23.2D, V21.2D
    FCMLA V7.8H, V7.8H, V31.H[0x2], #180
    FCMLA V7.4S, V26.4S, V1.S[0x0], #90
    FCADD V18.8H, V26.8H, V17.8H, #270
    FCMLA V12.4H, V21.4H, V10.H[0x1], #90
    FRINT32Z V30.2S, V4.2S
    FCMLA V31.2D, V0.2D, V10.2D, #270
    FCMLA V10.8H, V18.8H, V5.H[0x3], #270
    FRINT32X V3.2S, V15.2S
    FRINT32Z V20.2D, V25.2D
    FCMLA V19.4H, V23.4H, V7.H[0x0], #180
    FRINT64Z V26.2D, V20.2D
    FCMLA V10.4H, V10.4H, V12.H[0x1], #180
    FCMLA V14.8H, V5.8H, V3.H[0x1], #90
    FCMLA V31.2D, V30.2D, V19.2D, #180
    FCADD V14.4H, V26.4H, V26.4H, #90
    FRINT32Z V9.2S, V14.2S
    FCMLA V31.4S, V31.4S, V2.S[0x1], #0
    FCMLA V31.8H, V10.8H, V9.H[0x0], #0
    FCADD V29.2D, V17.2D, V0.2D, #270
    FRINT32Z V1.2D, V19.2D
    FCADD V25.2D, V21.2D, V21.2D, #270
    FCADD V16.4H, V8.4H, V21.4H, #90
    FCADD V3.2D, V11.2D, V5.2D, #90
    FCMLA V12.4H, V5.4H, V4.H[0x1], #180
    FRINT64Z V11.2S, V11.2S
    FCMLA V24.4S, V6.4S, V10.S[0x0], #180
    FRINT32X V5.2S, V16.2S
    FRINT32X V14.4S, V12.4S
    FRINT32X V30.2D, V9.2D
    FRINT64X V1.2S, V3.2S
    FCADD V15.2S, V2.2S, V26.2S, #270
    FCMLA V18.8H, V24.8H, V8.H[0x0], #180
    FRINT64X V24.4S, V9.4S
    FRINT64Z V29.2D, V1.2D
    FRINT32Z V19.4S, V25.4S
    FCMLA V24.4H, V11.4H, V5.H[0x1], #270
    FCADD V25.8H, V19.8H, V14.8H, #90
    FRINT64Z V8.4S, V30.4S
    FCMLA V25.8H, V22.8H, V8.H[0x1], #270
    FCMLA V18.4S, V18.4S, V24.S[0x0], #90
    FRINT32X V31.4S, V27.4S
    FCADD V29.4H, V25.4H, V29.4H, #90
    FRINT64X V9.4S, V26.4S
    FRINT64Z V1.4S, V29.4S
    FRINT64Z V11.2S, V15.2S
    FRINT64Z V25.2S, V30.2S
    FRINT64Z V2.2D, V9.2D
    FCMLA V10.8H, V0.8H, V2.H[0x2], #180
    FCMLA V1.4H, V22.4H, V18.H[0x1], #180
    FCMLA V1.4S, V31.4S, V10.S[0x0], #0
    FCADD V25.4S, V0.4S, V1.4S, #90
    FRINT32X V21.2D, V0.2D
    FCADD V21.2D, V25.2D, V21.2D, #270
    FRINT32Z V1.2S, V7.2S
    FRINT64X V14.4S, V12.4S
    FRINT64Z V5.4S, V1.4S
    FCMLA V15.4S, V12.4S, V18.S[0x1], #0
    FRINT32Z V8.2D, V21.2D
    FCMLA V3.4S, V7.4S, V25.4S, #270
    SUBS  X13, X13, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_0
    MOVZ  X26, #0xf575, LSL #0
    MOVK  X26, #0x3ce2, LSL #16
    MOVK  X26, #0xcfac, LSL #32
    MOVK  X26, #0x5ab3, LSL #48
    SUB  X23, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x261a, LSL #0
    MOVK  X26, #0xecc2, LSL #16
    MOVK  X26, #0x8440, LSL #32
    MOVK  X26, #0xc869, LSL #48
    SUB  X23, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0xd69c, LSL #0
    MOVK  X26, #0x7923, LSL #16
    MOVK  X26, #0x770c, LSL #32
    MOVK  X26, #0xb9a2, LSL #48
    SUB  X23, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x573e, LSL #0
    MOVK  X26, #0xbfaf, LSL #16
    MOVK  X26, #0x8c33, LSL #32
    MOVK  X26, #0x9d48, LSL #48
    SUB  X23, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0xf34b, LSL #0
    MOVK  X26, #0xa57b, LSL #16
    MOVK  X26, #0xe667, LSL #32
    MOVK  X26, #0xd127, LSL #48
    SUB  X23, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x70c9, LSL #0
    MOVK  X26, #0x6b8e, LSL #16
    MOVK  X26, #0x4922, LSL #32
    MOVK  X26, #0x8752, LSL #48
    SUB  X23, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x7f5f, LSL #0
    MOVK  X26, #0xf373, LSL #16
    MOVK  X26, #0x7200, LSL #32
    MOVK  X26, #0xe884, LSL #48
    SUB  X23, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0xc702, LSL #0
    MOVK  X26, #0x32b3, LSL #16
    MOVK  X26, #0x2e3f, LSL #32
    MOVK  X26, #0xcfee, LSL #48
    SUB  X23, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0xd225, LSL #0
    MOVK  X26, #0x6686, LSL #16
    MOVK  X26, #0xeae3, LSL #32
    MOVK  X26, #0x22f, LSL #48
    SUB  X23, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x47bc, LSL #0
    MOVK  X26, #0xd089, LSL #16
    MOVK  X26, #0x8bf7, LSL #32
    MOVK  X26, #0xbd0b, LSL #48
    SUB  X23, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x339f, LSL #0
    MOVK  X26, #0x8e4f, LSL #16
    MOVK  X26, #0xaf26, LSL #32
    MOVK  X26, #0x95a1, LSL #48
    SUB  X23, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x193a, LSL #0
    MOVK  X26, #0xe980, LSL #16
    MOVK  X26, #0xe19f, LSL #32
    MOVK  X26, #0x928e, LSL #48
    SUB  X23, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x3dfa, LSL #0
    MOVK  X26, #0x95ce, LSL #16
    MOVK  X26, #0x72a9, LSL #32
    MOVK  X26, #0x9d9e, LSL #48
    SUB  X23, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x5e7, LSL #0
    MOVK  X26, #0x293e, LSL #16
    MOVK  X26, #0x54a4, LSL #32
    MOVK  X26, #0x7fa1, LSL #48
    SUB  X23, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x5440, LSL #0
    MOVK  X26, #0x5218, LSL #16
    MOVK  X26, #0xd00a, LSL #32
    MOVK  X26, #0x5fb7, LSL #48
    SUB  X23, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x7c31, LSL #0
    MOVK  X26, #0x2633, LSL #16
    MOVK  X26, #0x1c6a, LSL #32
    MOVK  X26, #0x3a40, LSL #48
    SUB  X23, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0xadd4, LSL #0
    MOVK  X26, #0xcc34, LSL #16
    MOVK  X26, #0x5613, LSL #32
    MOVK  X26, #0x230d, LSL #48
    SUB  X23, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0x29fd, LSL #0
    MOVK  X26, #0xc79f, LSL #16
    MOVK  X26, #0xa94a, LSL #32
    MOVK  X26, #0x2e89, LSL #48
    SUB  X23, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X26, #0xec38, LSL #0
    MOVK  X26, #0xc41b, LSL #16
    MOVK  X26, #0xe306, LSL #32
    MOVK  X26, #0xdbcc, LSL #48
    SUB  X23, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X26, FPSR
    MOVZ  X23, #0x9d, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D0
    MOVZ  X23, #0x8000, LSL #0
    MOVK  X23, #0xd360, LSL #16
    MOVK  X23, #0x8000, LSL #32
    MOVK  X23, #0x535f, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D1
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xcf00, LSL #16
    MOVK  X23, #0xcf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D2
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3c00, LSL #32
    MOVK  X23, #0x4298, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D3
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x7f7f, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7f7f, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D4
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D5
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xcf00, LSL #16
    MOVK  X23, #0xcf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D6
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xdf00, LSL #16
    MOVK  X23, #0xdf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D7
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x7f7f, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xff7f, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D8
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D9
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D10
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D11
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xdf00, LSL #16
    MOVK  X23, #0xdf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D12
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xcf00, LSL #16
    MOVK  X23, #0xcf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D13
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D14
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xdf00, LSL #16
    MOVK  X23, #0xdf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D15
    MOVZ  X23, #0x7dff, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D16
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D17
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #16
    MOVK  X23, #0x56e4, LSL #32
    MOVK  X23, #0xc3e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D18
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x7f7f, LSL #16
    MOVK  X23, #0x7e00, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xcf00, LSL #16
    MOVK  X23, #0xcf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D19
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xcf00, LSL #16
    MOVK  X23, #0xcf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D20
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x41e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D21
    MOVZ  X23, #0xfffe, LSL #0
    MOVK  X23, #0x7f7f, LSL #16
    MOVK  X23, #0xfffe, LSL #32
    MOVK  X23, #0xff7f, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D22
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xcf00, LSL #16
    MOVK  X23, #0xcf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D23
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc3e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D24
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5524, LSL #32
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D25
    MOVZ  X23, #0xfffe, LSL #0
    MOVK  X23, #0x7f7f, LSL #16
    MOVK  X23, #0xfffe, LSL #32
    MOVK  X23, #0xff7f, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D26
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D27
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #16
    MOVK  X23, #0xc3e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D28
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #16
    MOVK  X23, #0xc3e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D29
    MOVZ  X23, #0x56e4, LSL #0
    MOVK  X23, #0xcf00, LSL #16
    MOVK  X23, #0x5713, LSL #32
    MOVK  X23, #0xcf00, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D30
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X26, D31
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc1e0, LSL #16
    MOVK  X23, #0xc3e0, LSL #48
    SUB  X15, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X13
    FMOV  V0.D[1], X28
    FMOV  D1, X14
    FMOV  V1.D[1], X15
    FMOV  D2, X12
    FMOV  V2.D[1], X3
    FMOV  D3, X13
    FMOV  V3.D[1], X25
    FMOV  D4, X12
    FMOV  V4.D[1], X23
    FMOV  D5, X27
    FMOV  V5.D[1], X24
    FMOV  D6, X17
    FMOV  V6.D[1], X26
    FMOV  D7, X29
    FMOV  V7.D[1], X3
    FMOV  D8, X25
    FMOV  V8.D[1], X28
    FMOV  D9, X28
    FMOV  V9.D[1], X3
    FMOV  D10, X29
    FMOV  V10.D[1], X5
    FMOV  D11, X24
    FMOV  V11.D[1], X5
    FMOV  D12, X24
    FMOV  V12.D[1], X2
    FMOV  D13, X28
    FMOV  V13.D[1], X14
    FMOV  D14, X13
    FMOV  V14.D[1], X9
    FMOV  D15, X6
    FMOV  V15.D[1], X23
    FMOV  D16, X5
    FMOV  V16.D[1], X23
    FMOV  D17, X25
    FMOV  V17.D[1], X13
    FMOV  D18, X13
    FMOV  V18.D[1], X13
    FMOV  D19, X6
    FMOV  V19.D[1], X4
    FMOV  D20, X17
    FMOV  V20.D[1], X12
    FMOV  D21, X7
    FMOV  V21.D[1], X27
    FMOV  D22, X17
    FMOV  V22.D[1], X8
    FMOV  D23, X8
    FMOV  V23.D[1], X3
    FMOV  D24, X12
    FMOV  V24.D[1], X23
    FMOV  D25, X6
    FMOV  V25.D[1], X25
    FMOV  D26, X28
    FMOV  V26.D[1], X9
    FMOV  D27, X14
    FMOV  V27.D[1], X17
    FMOV  D28, X16
    FMOV  V28.D[1], X29
    FMOV  D29, X10
    FMOV  V29.D[1], X26
    FMOV  D30, X25
    FMOV  V30.D[1], X13
    FMOV  D31, X29
    FMOV  V31.D[1], X26
    MOVZ  X5, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_1:
    FRINT32X V6.2S, V18.2S
    FCMLA V6.4S, V29.4S, V6.S[0x0], #0
    FRINT32X V24.2S, V31.2S
    FCMLA V30.8H, V6.8H, V6.H[0x1], #270
    FRINT64X V15.4S, V19.4S
    FRINT64X V27.2S, V30.2S
    FRINT64X V23.2D, V7.2D
    FCMLA V15.8H, V28.8H, V28.H[0x0], #0
    FRINT32X V2.2D, V15.2D
    FCADD V22.8H, V2.8H, V23.8H, #270
    FRINT64Z V0.4S, V24.4S
    FRINT64X V30.4S, V17.4S
    FRINT32X V30.2S, V30.2S
    FCMLA V15.4S, V20.4S, V22.S[0x0], #0
    FRINT64Z V3.4S, V0.4S
    FRINT64Z V16.4S, V27.4S
    FCMLA V25.4S, V26.4S, V21.S[0x0], #0
    FCMLA V25.4S, V3.4S, V30.S[0x1], #270
    FCMLA V25.2D, V10.2D, V25.2D, #180
    FCMLA V0.4H, V23.4H, V15.4H, #90
    FRINT32Z V4.2S, V19.2S
    FCADD V0.4H, V9.4H, V25.4H, #270
    FCMLA V0.2D, V23.2D, V7.2D, #90
    FCMLA V28.4S, V16.4S, V4.S[0x0], #270
    FRINT64Z V10.2D, V8.2D
    FCADD V6.2S, V9.2S, V15.2S, #270
    FCMLA V25.8H, V7.8H, V15.H[0x3], #90
    FRINT64X V26.2S, V7.2S
    FRINT32Z V3.2S, V9.2S
    FCMLA V7.2D, V15.2D, V18.2D, #270
    FRINT64X V15.2D, V1.2D
    FRINT32X V2.4S, V28.4S
    FCMLA V20.4S, V15.4S, V0.S[0x0], #0
    FCMLA V12.2S, V6.2S, V3.2S, #90
    FRINT32Z V16.4S, V12.4S
    FRINT32X V17.2S, V16.2S
    FCMLA V26.4H, V10.4H, V25.H[0x0], #90
    FCADD V21.2S, V7.2S, V7.2S, #270
    FRINT64Z V12.2D, V2.2D
    FCADD V21.2S, V25.2S, V26.2S, #270
    FCMLA V17.8H, V28.8H, V17.8H, #270
    FRINT32X V26.2S, V21.2S
    FRINT64Z V15.4S, V17.4S
    FCMLA V24.4H, V12.4H, V4.H[0x0], #90
    FRINT32Z V28.2S, V2.2S
    FRINT32Z V4.4S, V5.4S
    FRINT64Z V28.2S, V21.2S
    FCMLA V5.4S, V28.4S, V15.S[0x0], #90
    FCADD V1.4H, V5.4H, V7.4H, #270
    FRINT64Z V17.2D, V13.2D
    FCADD V7.8H, V20.8H, V17.8H, #90
    FCMLA V4.4H, V26.4H, V26.4H, #90
    FCMLA V23.4S, V17.4S, V9.S[0x1], #90
    FRINT32X V15.4S, V23.4S
    FCMLA V10.4H, V1.4H, V9.H[0x0], #0
    FCMLA V4.4S, V19.4S, V24.S[0x0], #180
    FRINT32Z V3.2S, V15.2S
    FCADD V4.4H, V10.4H, V7.4H, #270
    FCMLA V4.2D, V3.2D, V4.2D, #180
    FRINT32Z V19.2S, V15.2S
    FCADD V27.8H, V19.8H, V5.8H, #270
    FCADD V31.8H, V16.8H, V24.8H, #90
    FRINT64X V6.4S, V12.4S
    FRINT32Z V21.4S, V17.4S
    FRINT32X V26.2D, V17.2D
    FRINT64Z V4.2D, V2.2D
    FCMLA V13.2D, V6.2D, V11.2D, #90
    FCADD V11.2S, V23.2S, V26.2S, #90
    FCADD V28.2D, V11.2D, V26.2D, #90
    FCADD V11.4H, V0.4H, V21.4H, #90
    FRINT32X V20.4S, V11.4S
    FCADD V5.4S, V7.4S, V17.4S, #270
    FRINT64X V23.2S, V30.2S
    FRINT64Z V26.2S, V26.2S
    FRINT64X V18.2D, V26.2D
    FCMLA V13.4S, V28.4S, V13.4S, #90
    FRINT32X V30.2S, V23.2S
    FRINT32Z V10.4S, V30.4S
    FRINT64Z V12.2S, V5.2S
    FRINT64Z V30.4S, V12.4S
    FRINT64Z V0.4S, V28.4S
    FCMLA V4.8H, V11.8H, V16.8H, #0
    FCMLA V4.4S, V27.4S, V18.S[0x0], #180
    FRINT64Z V17.4S, V1.4S
    FCMLA V21.2D, V17.2D, V4.2D, #0
    FRINT64Z V11.2S, V16.2S
    FCMLA V0.4H, V10.4H, V11.H[0x1], #180
    FCADD V0.4S, V0.4S, V19.4S, #90
    FRINT64Z V7.2S, V13.2S
    FRINT64Z V25.2D, V0.2D
    FCMLA V8.4H, V25.4H, V30.H[0x0], #0
    FRINT32X V8.2S, V25.2S
    FCADD V8.2S, V8.2S, V14.2S, #90
    FRINT64Z V26.2D, V7.2D
    FRINT32X V31.2D, V19.2D
    FCADD V15.4H, V31.4H, V26.4H, #90
    FCMLA V21.4H, V15.4H, V21.4H, #0
    FRINT64X V16.4S, V8.4S
    FRINT64Z V13.2D, V20.2D
    FCMLA V13.4H, V21.4H, V23.H[0x1], #0
    FCMLA V28.4S, V31.4S, V6.S[0x1], #270
    FRINT32Z V11.2S, V5.2S
    FCADD V2.4H, V9.4H, V9.4H, #270
    FRINT32Z V23.2S, V27.2S
    FRINT32Z V5.2S, V6.2S
    FCADD V16.4S, V6.4S, V26.4S, #270
    FRINT64Z V20.2S, V23.2S
    FCMLA V31.8H, V15.8H, V30.8H, #0
    FCADD V27.4H, V2.4H, V9.4H, #90
    FCMLA V11.8H, V7.8H, V20.H[0x2], #180
    FCMLA V8.4H, V8.4H, V10.H[0x0], #270
    FCMLA V17.2S, V1.2S, V20.2S, #90
    FCADD V13.2D, V14.2D, V27.2D, #270
    FCMLA V30.8H, V10.8H, V28.H[0x2], #180
    FRINT64X V4.2S, V16.2S
    FCMLA V17.8H, V8.8H, V26.H[0x3], #0
    FRINT32Z V13.2S, V25.2S
    FCMLA V4.2S, V0.2S, V8.2S, #270
    FRINT64Z V27.2D, V15.2D
    FRINT64Z V7.2D, V30.2D
    FCMLA V27.4H, V11.4H, V5.H[0x1], #270
    FCADD V25.4H, V7.4H, V27.4H, #270
    FRINT32X V10.4S, V31.4S
    FRINT32X V31.4S, V25.4S
    FCMLA V4.2S, V10.2S, V13.2S, #0
    FRINT64X V8.2D, V29.2D
    FRINT32X V23.2D, V31.2D
    FCMLA V4.4S, V17.4S, V2.S[0x0], #90
    FCMLA V8.4S, V24.4S, V14.4S, #0
    FRINT32Z V20.4S, V8.4S
    FCMLA V17.2D, V23.2D, V0.2D, #90
    FCADD V15.2S, V3.2S, V17.2S, #90
    FRINT32X V24.4S, V20.4S
    FCADD V9.2S, V15.2S, V4.2S, #90
    FRINT32X V23.4S, V16.4S
    FCMLA V8.4H, V3.4H, V1.4H, #0
    FRINT32X V0.2S, V5.2S
    FRINT64Z V30.4S, V5.4S
    FRINT32Z V12.2D, V11.2D
    FCMLA V9.4H, V11.4H, V8.H[0x1], #180
    FRINT64X V25.4S, V28.4S
    FCMLA V5.8H, V26.8H, V25.8H, #180
    FCMLA V4.8H, V9.8H, V21.H[0x1], #270
    FRINT64X V28.2S, V14.2S
    FRINT32X V1.2D, V8.2D
    FCMLA V13.8H, V6.8H, V24.H[0x2], #180
    FCMLA V30.4H, V7.4H, V28.H[0x0], #180
    FRINT64Z V2.4S, V0.4S
    FRINT32Z V16.2S, V2.2S
    FCMLA V23.4S, V13.4S, V5.4S, #270
    FRINT32X V28.2D, V19.2D
    FCADD V17.2S, V4.2S, V21.2S, #270
    FCADD V10.4H, V12.4H, V1.4H, #270
    FCMLA V0.4H, V4.4H, V28.4H, #270
    FCMLA V23.2S, V21.2S, V16.2S, #0
    FRINT64X V7.2D, V30.2D
    FRINT64X V14.4S, V0.4S
    FCMLA V23.2D, V27.2D, V16.2D, #270
    FCMLA V23.4S, V7.4S, V8.S[0x1], #270
    FCMLA V11.4S, V15.4S, V10.S[0x1], #90
    FCMLA V18.8H, V21.8H, V26.8H, #0
    FCMLA V11.8H, V30.8H, V11.H[0x2], #270
    FRINT64X V7.2D, V17.2D
    FCMLA V18.4S, V14.4S, V23.S[0x1], #90
    FRINT64Z V15.2S, V18.2S
    FRINT64Z V21.4S, V15.4S
    FCMLA V21.4H, V21.4H, V12.4H, #90
    FCADD V11.4H, V21.4H, V22.4H, #90
    FCADD V11.2S, V0.2S, V11.2S, #90
    FRINT32X V21.4S, V20.4S
    FRINT32Z V22.4S, V18.4S
    FRINT64Z V17.2D, V12.2D
    FRINT64Z V9.2D, V11.2D
    FCADD V14.2D, V17.2D, V11.2D, #270
    FCADD V26.4H, V24.4H, V15.4H, #90
    FRINT64Z V8.2D, V14.2D
    FRINT64X V11.2D, V18.2D
    FCMLA V24.2S, V14.2S, V4.2S, #180
    FRINT32Z V14.4S, V24.4S
    FRINT32X V0.2S, V0.2S
    FRINT32Z V12.4S, V11.4S
    FCADD V26.2S, V19.2S, V7.2S, #90
    FCMLA V2.8H, V21.8H, V14.H[0x1], #180
    FCMLA V9.2D, V12.2D, V27.2D, #0
    FCMLA V7.4H, V2.4H, V9.4H, #0
    FCADD V3.4H, V7.4H, V10.4H, #270
    FCMLA V22.4S, V2.4S, V26.S[0x0], #180
    FCADD V28.8H, V25.8H, V0.8H, #90
    FRINT32Z V20.2S, V8.2S
    FCMLA V20.4S, V3.4S, V18.S[0x1], #180
    FRINT64Z V11.2D, V28.2D
    FRINT32Z V26.4S, V6.4S
    FCMLA V20.8H, V27.8H, V26.H[0x3], #0
    FRINT64X V18.2S, V3.2S
    FRINT64Z V10.2D, V11.2D
    FRINT32X V3.2D, V18.2D
    FRINT64X V27.2D, V17.2D
    FCMLA V4.4S, V7.4S, V22.S[0x1], #0
    FCMLA V20.2S, V31.2S, V9.2S, #180
    FCMLA V10.4H, V3.4H, V10.H[0x1], #0
    SUBS  X5, X5, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_1
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X4, FPSR
    MOVZ  X24, #0x9d, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X4, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  D0, X15
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X23
    FMOV  D3, X29
    FMOV  V3.D[1], X15
    FMOV  D4, X14
    FMOV  V4.D[1], X2
    FMOV  D5, X27
    FMOV  V5.D[1], X17
    FMOV  D6, X14
    FMOV  V6.D[1], X23
    FMOV  D7, X17
    FMOV  V7.D[1], X6
    FMOV  D8, X6
    FMOV  V8.D[1], X16
    FMOV  D9, X17
    FMOV  V9.D[1], X7
    FMOV  D10, X3
    FMOV  V10.D[1], X13
    FMOV  D11, X14
    FMOV  V11.D[1], X16
    FMOV  D12, X25
    FMOV  V12.D[1], X5
    FMOV  D13, X28
    FMOV  V13.D[1], X12
    FMOV  D14, X14
    FMOV  V14.D[1], X13
    FMOV  D15, X10
    FMOV  V15.D[1], X16
    FMOV  D16, X27
    FMOV  V16.D[1], X15
    FMOV  D17, X27
    FMOV  V17.D[1], X29
    FMOV  D18, X7
    FMOV  V18.D[1], X15
    FMOV  D19, X17
    FMOV  V19.D[1], X23
    FMOV  D20, X16
    FMOV  V20.D[1], X8
    FMOV  D21, X8
    FMOV  V21.D[1], X26
    FMOV  D22, X29
    FMOV  V22.D[1], X26
    FMOV  D23, X24
    FMOV  V23.D[1], X25
    FMOV  D24, X29
    FMOV  V24.D[1], X6
    FMOV  D25, X8
    FMOV  V25.D[1], X2
    FMOV  D26, X16
    FMOV  V26.D[1], X5
    FMOV  D27, X2
    FMOV  V27.D[1], X2
    FMOV  D28, X17
    FMOV  V28.D[1], X9
    FMOV  D29, X4
    FMOV  V29.D[1], X24
    FMOV  D30, X4
    FMOV  V30.D[1], X28
    FMOV  D31, X3
    FMOV  V31.D[1], X16
    MOVZ  X9, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_2:
    FCMLA V29.4S, V30.4S, V20.S[0x0], #0
    FCADD V31.4H, V26.4H, V21.4H, #270
    FRINT32Z V17.4S, V28.4S
    FCMLA V24.4H, V7.4H, V29.4H, #180
    FRINT32Z V22.2D, V17.2D
    FCADD V24.2S, V10.2S, V8.2S, #90
    FRINT64X V4.2D, V24.2D
    FCMLA V27.8H, V30.8H, V26.8H, #0
    FCMLA V28.8H, V4.8H, V15.8H, #270
    FRINT32Z V20.4S, V27.4S
    FRINT64X V28.4S, V28.4S
    FCMLA V30.8H, V8.8H, V6.H[0x0], #180
    FCMLA V10.4S, V30.4S, V25.S[0x0], #90
    FCMLA V10.2S, V31.2S, V24.2S, #180
    FCMLA V10.4S, V28.4S, V9.S[0x0], #90
    FCADD V31.8H, V3.8H, V4.8H, #270
    FRINT32Z V30.4S, V10.4S
    FCMLA V31.4S, V30.4S, V17.S[0x1], #180
    FCMLA V23.2D, V25.2D, V20.2D, #90
    FCMLA V6.4H, V17.4H, V22.4H, #90
    FCADD V9.8H, V31.8H, V31.8H, #90
    FRINT64Z V28.2S, V27.2S
    FRINT64Z V8.2S, V13.2S
    FCADD V17.2S, V15.2S, V8.2S, #270
    FCMLA V17.2D, V6.2D, V9.2D, #180
    FCMLA V1.8H, V23.8H, V28.H[0x3], #0
    FCMLA V6.4H, V21.4H, V11.H[0x0], #90
    FCMLA V25.2S, V14.2S, V13.2S, #90
    FRINT32Z V7.2D, V13.2D
    FRINT64Z V28.4S, V17.4S
    FCMLA V21.4S, V23.4S, V28.S[0x1], #90
    FCMLA V3.8H, V24.8H, V15.H[0x0], #0
    FRINT32Z V22.2S, V26.2S
    FRINT64Z V28.4S, V28.4S
    FRINT32X V24.4S, V30.4S
    FRINT64X V22.2S, V15.2S
    FRINT32X V15.4S, V23.4S
    FRINT32Z V9.2S, V6.2S
    FRINT64Z V8.2S, V28.2S
    FRINT32Z V30.4S, V22.4S
    FCADD V25.2D, V21.2D, V9.2D, #270
    FRINT32Z V28.2S, V1.2S
    FCADD V15.2D, V3.2D, V7.2D, #270
    FRINT32Z V6.2D, V28.2D
    FCMLA V15.4H, V25.4H, V19.H[0x0], #90
    FCMLA V24.2S, V15.2S, V24.2S, #180
    FRINT32X V21.4S, V30.4S
    FRINT32Z V13.2D, V6.2D
    FRINT32X V25.2S, V10.2S
    FRINT32Z V17.4S, V8.4S
    FCADD V25.4H, V7.4H, V25.4H, #90
    FRINT64X V26.2D, V17.2D
    FCMLA V24.4S, V24.4S, V6.4S, #0
    FCMLA V21.4S, V21.4S, V4.S[0x1], #270
    FCADD V5.2D, V30.2D, V13.2D, #90
    FCMLA V5.8H, V21.8H, V30.H[0x0], #270
    FRINT32X V22.4S, V5.4S
    FRINT32Z V4.2D, V25.2D
    FCMLA V26.4S, V26.4S, V24.S[0x1], #0
    FCADD V2.8H, V22.8H, V22.8H, #270
    FCMLA V12.4H, V26.4H, V11.H[0x0], #90
    FCMLA V16.4H, V12.4H, V4.4H, #270
    FRINT32X V17.2S, V5.2S
    FCMLA V9.8H, V14.8H, V26.H[0x2], #270
    FRINT32Z V11.2D, V19.2D
    FRINT32Z V22.2D, V11.2D
    FCMLA V21.4H, V9.4H, V20.4H, #0
    FCMLA V7.4H, V22.4H, V9.H[0x1], #90
    FCMLA V4.4H, V12.4H, V25.H[0x1], #270
    FRINT32Z V30.4S, V6.4S
    FCADD V0.2S, V7.2S, V25.2S, #270
    FCADD V10.4S, V8.4S, V14.4S, #270
    FRINT64X V25.4S, V30.4S
    FRINT32X V8.2D, V22.2D
    FRINT64X V9.2S, V0.2S
    FCMLA V0.4H, V10.4H, V15.H[0x0], #0
    FCMLA V21.4H, V16.4H, V8.H[0x1], #90
    FRINT32Z V19.2D, V21.2D
    FRINT64X V7.2S, V14.2S
    FCMLA V9.4H, V17.4H, V2.H[0x0], #180
    FCMLA V15.4S, V4.4S, V19.S[0x1], #180
    FRINT64Z V26.2D, V15.2D
    FRINT64X V21.2S, V26.2S
    FCMLA V7.8H, V23.8H, V0.H[0x2], #270
    FCMLA V7.2S, V9.2S, V7.2S, #270
    FCMLA V25.4H, V7.4H, V7.4H, #180
    FRINT64X V26.2S, V4.2S
    FCMLA V19.4S, V29.4S, V6.S[0x0], #0
    FCMLA V22.4S, V0.4S, V10.S[0x0], #90
    FCADD V24.2S, V23.2S, V25.2S, #90
    FRINT32Z V4.2D, V1.2D
    FRINT64Z V10.2S, V10.2S
    FCMLA V19.2S, V7.2S, V24.2S, #0
    FRINT32X V21.4S, V0.4S
    FCMLA V24.2S, V4.2S, V11.2S, #90
    FRINT32X V25.4S, V10.4S
    FRINT64X V10.4S, V24.4S
    FCMLA V0.4H, V3.4H, V23.H[0x1], #0
    FCADD V9.2S, V8.2S, V31.2S, #270
    FRINT64Z V2.2D, V17.2D
    FRINT32X V17.4S, V22.4S
    FCADD V25.4H, V10.4H, V2.4H, #270
    FCMLA V25.4H, V30.4H, V26.H[0x0], #90
    FRINT32Z V16.4S, V9.4S
    FRINT32Z V8.2D, V19.2D
    FRINT64Z V10.2D, V25.2D
    FRINT64X V15.2S, V19.2S
    FCMLA V21.8H, V0.8H, V16.H[0x1], #0
    FCADD V19.4S, V21.4S, V15.4S, #90
    FRINT32Z V12.4S, V5.4S
    FCMLA V12.4H, V16.4H, V12.H[0x1], #0
    FRINT64X V15.2D, V8.2D
    FCMLA V21.4H, V11.4H, V10.H[0x0], #0
    FCMLA V11.4S, V17.4S, V1.S[0x1], #270
    FRINT64X V25.4S, V31.4S
    FCMLA V11.4H, V15.4H, V15.4H, #90
    FRINT64X V31.4S, V18.4S
    FRINT64X V22.2D, V0.2D
    FRINT32X V0.4S, V19.4S
    FCMLA V21.8H, V18.8H, V15.H[0x3], #180
    FRINT32X V21.2D, V0.2D
    FRINT32X V10.4S, V11.4S
    FRINT32Z V30.2S, V21.2S
    FRINT32Z V26.2D, V25.2D
    FCMLA V2.4S, V31.4S, V22.S[0x0], #180
    FRINT32Z V1.4S, V12.4S
    FRINT32Z V19.4S, V26.4S
    FCMLA V30.4H, V2.4H, V30.4H, #0
    FRINT32X V21.4S, V30.4S
    FCMLA V27.4S, V26.4S, V11.S[0x1], #0
    FRINT32X V22.2S, V19.2S
    FCMLA V10.4S, V22.4S, V9.S[0x1], #180
    FRINT32Z V0.2D, V30.2D
    FCMLA V3.4H, V8.4H, V1.4H, #0
    FCADD V27.4S, V21.4S, V10.4S, #270
    FCADD V10.4H, V0.4H, V22.4H, #270
    FRINT32Z V30.4S, V30.4S
    FCADD V27.4H, V3.4H, V10.4H, #90
    FRINT32Z V2.2D, V21.2D
    FCADD V30.4H, V24.4H, V2.4H, #270
    FCADD V2.4H, V30.4H, V27.4H, #270
    FRINT32X V25.2D, V29.2D
    FRINT32Z V29.2D, V5.2D
    FCADD V13.4S, V29.4S, V24.4S, #270
    FRINT32Z V14.4S, V11.4S
    FRINT64X V26.4S, V28.4S
    FRINT32X V0.2D, V14.2D
    FCADD V29.2S, V29.2S, V8.2S, #270
    FCMLA V27.4H, V10.4H, V2.H[0x1], #90
    FCMLA V5.8H, V25.8H, V8.H[0x3], #180
    FCMLA V23.4H, V14.4H, V1.H[0x1], #0
    FCADD V28.8H, V1.8H, V18.8H, #270
    FRINT32X V22.4S, V19.4S
    FRINT64Z V24.2S, V23.2S
    FCADD V0.4H, V28.4H, V0.4H, #270
    FCMLA V8.2S, V10.2S, V29.2S, #0
    FCMLA V5.4S, V8.4S, V27.4S, #0
    FCMLA V24.8H, V26.8H, V9.8H, #270
    FRINT32Z V8.2S, V24.2S
    FCMLA V0.8H, V5.8H, V22.H[0x2], #90
    FCADD V13.2S, V29.2S, V0.2S, #90
    FCADD V13.4S, V22.4S, V26.4S, #90
    FCMLA V8.4S, V20.4S, V2.S[0x1], #270
    FRINT32X V18.2S, V26.2S
    FCADD V12.2S, V14.2S, V3.2S, #270
    FCMLA V30.4S, V15.4S, V11.S[0x1], #180
    FRINT64X V3.2D, V18.2D
    FRINT64Z V11.4S, V5.4S
    FRINT32X V26.4S, V16.4S
    FCMLA V30.4S, V7.4S, V25.S[0x1], #0
    FCMLA V13.4S, V25.4S, V10.S[0x1], #270
    FRINT32X V25.2D, V27.2D
    FCMLA V3.8H, V7.8H, V4.H[0x3], #90
    FCMLA V30.4H, V31.4H, V11.4H, #270
    FCMLA V31.8H, V30.8H, V10.H[0x2], #180
    FCADD V18.8H, V1.8H, V26.8H, #90
    FRINT64X V2.2S, V29.2S
    FRINT32X V27.4S, V17.4S
    FCMLA V3.4S, V30.4S, V31.S[0x1], #0
    FCADD V2.4H, V25.4H, V18.4H, #90
    FRINT64X V7.2D, V15.2D
    FCMLA V13.2D, V27.2D, V2.2D, #0
    FCMLA V4.4H, V7.4H, V31.4H, #180
    FCMLA V12.4S, V12.4S, V4.S[0x0], #270
    FCADD V13.2S, V19.2S, V12.2S, #90
    FCADD V13.2S, V13.2S, V26.2S, #90
    FRINT64X V18.2S, V30.2S
    FRINT32Z V19.2S, V2.2S
    FRINT64Z V24.2S, V30.2S
    FCADD V16.8H, V3.8H, V11.8H, #270
    FRINT64X V18.2D, V24.2D
    FCMLA V19.4H, V16.4H, V16.4H, #270
    FCMLA V8.2S, V18.2S, V18.2S, #270
    FCADD V7.2S, V13.2S, V6.2S, #270
    FCMLA V8.4S, V12.4S, V7.S[0x0], #0
    FRINT64Z V7.2D, V2.2D
    FRINT32X V16.4S, V25.4S
    FCADD V19.8H, V11.8H, V26.8H, #90
    FRINT32X V1.2D, V25.2D
    FRINT64X V3.2D, V19.2D
    SUBS  X9, X9, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_2
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X28, FPSR
    MOVZ  X12, #0x9d, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D0
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc6e0, LSL #32
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D1
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D2
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x41e0, LSL #16
    MOVK  X12, #0x41e0, LSL #32
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D3
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x41e0, LSL #32
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D4
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D5
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D6
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D8
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xff7f, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0x7f7f, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D9
    MOVZ  X12, #0xbc00, LSL #0
    MOVK  X12, #0xc1e0, LSL #16
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D10
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #32
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D11
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D12
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0x7f7f, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0x7f7f, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D13
    MOVZ  X12, #0xfffe, LSL #0
    MOVK  X12, #0xff7f, LSL #16
    MOVK  X12, #0xfffd, LSL #32
    MOVK  X12, #0x7f7f, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D14
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D15
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D16
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D17
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D18
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc3e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D19
    MOVZ  X12, #0x41e0, LSL #0
    MOVK  X12, #0x41e0, LSL #32
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D20
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D21
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D22
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D23
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7e00, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D24
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xdf00, LSL #16
    MOVK  X12, #0xdf00, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D25
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D26
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #16
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D27
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xcf00, LSL #16
    MOVK  X12, #0xcf00, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D28
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc3e0, LSL #32
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D29
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc1e0, LSL #16
    MOVK  X12, #0xc1e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D30
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x4930, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D31
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0xc3e0, LSL #48
    SUB  X7, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  V0.D[1], X3
    FMOV  D1, X26
    FMOV  V1.D[1], X13
    FMOV  D2, X23
    FMOV  V2.D[1], X24
    FMOV  D3, X11
    FMOV  V3.D[1], X28
    FMOV  D4, X7
    FMOV  V4.D[1], X27
    FMOV  D5, X2
    FMOV  V5.D[1], X25
    FMOV  D6, X26
    FMOV  V6.D[1], X8
    FMOV  D7, X11
    FMOV  V7.D[1], X3
    FMOV  D8, X12
    FMOV  V8.D[1], X28
    FMOV  D9, X25
    FMOV  V9.D[1], X26
    FMOV  D10, X12
    FMOV  V10.D[1], X27
    FMOV  D11, X29
    FMOV  V11.D[1], X12
    FMOV  D12, X29
    FMOV  V12.D[1], X24
    FMOV  D13, X14
    FMOV  V13.D[1], X25
    FMOV  D14, X3
    FMOV  V14.D[1], X24
    FMOV  D15, X4
    FMOV  V15.D[1], X13
    FMOV  D16, X26
    FMOV  V16.D[1], X29
    FMOV  D17, X5
    FMOV  V17.D[1], X29
    FMOV  D18, X9
    FMOV  V18.D[1], X3
    FMOV  D19, X4
    FMOV  V19.D[1], X11
    FMOV  D20, X24
    FMOV  V20.D[1], X5
    FMOV  D21, X25
    FMOV  V21.D[1], X7
    FMOV  D22, X24
    FMOV  V22.D[1], X16
    FMOV  D23, X25
    FMOV  V23.D[1], X26
    FMOV  D24, X12
    FMOV  V24.D[1], X17
    FMOV  D25, X26
    FMOV  V25.D[1], X16
    FMOV  D26, X27
    FMOV  V26.D[1], X8
    FMOV  D27, X25
    FMOV  V27.D[1], X3
    FMOV  D28, X3
    FMOV  V28.D[1], X26
    FMOV  D29, X24
    FMOV  V29.D[1], X13
    FMOV  D30, X11
    FMOV  V30.D[1], X16
    FMOV  D31, X16
    FMOV  V31.D[1], X26
    MOVZ  X10, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_3:
    FRINT32X V2.4S, V29.4S
    FCMLA V29.2D, V24.2D, V24.2D, #180
    FCMLA V2.4S, V22.4S, V27.S[0x0], #270
    FCADD V26.8H, V25.8H, V29.8H, #270
    FCMLA V13.2D, V26.2D, V26.2D, #0
    FCMLA V3.2D, V13.2D, V16.2D, #90
    FCMLA V21.4H, V3.4H, V28.4H, #90
    FCMLA V30.8H, V2.8H, V21.H[0x1], #0
    FRINT32Z V24.2D, V31.2D
    FRINT32Z V10.2D, V24.2D
    FCADD V23.4S, V24.4S, V23.4S, #90
    FRINT32Z V20.2D, V22.2D
    FCADD V17.8H, V28.8H, V3.8H, #90
    FCADD V25.2D, V10.2D, V23.2D, #90
    FRINT64Z V28.4S, V27.4S
    FCADD V3.4S, V20.4S, V20.4S, #270
    FRINT32Z V27.2S, V19.2S
    FCMLA V3.8H, V25.8H, V3.H[0x2], #90
    FRINT64Z V2.2S, V27.2S
    FCMLA V28.2S, V30.2S, V2.2S, #0
    FCMLA V28.8H, V3.8H, V31.8H, #0
    FCMLA V28.2D, V5.2D, V3.2D, #180
    FCMLA V15.4H, V16.4H, V9.H[0x1], #90
    FRINT32X V30.4S, V5.4S
    FCMLA V24.4H, V11.4H, V25.H[0x0], #0
    FCMLA V6.8H, V29.8H, V30.H[0x3], #270
    FRINT32Z V16.4S, V6.4S
    FCMLA V13.4H, V18.4H, V15.4H, #0
    FRINT32Z V31.2S, V20.2S
    FRINT32X V3.2S, V0.2S
    FCMLA V26.4H, V25.4H, V12.H[0x0], #180
    FRINT32Z V23.2S, V3.2S
    FRINT32X V15.2D, V29.2D
    FRINT64X V12.2D, V23.2D
    FRINT32X V9.4S, V24.4S
    FCMLA V28.8H, V23.8H, V29.H[0x1], #270
    FCMLA V1.8H, V9.8H, V13.H[0x0], #90
    FRINT64Z V25.2S, V6.2S
    FRINT32Z V27.4S, V11.4S
    FCMLA V18.2S, V28.2S, V14.2S, #270
    FRINT64X V23.4S, V21.4S
    FRINT64X V13.2S, V18.2S
    FRINT32X V9.2S, V12.2S
    FCADD V23.4H, V9.4H, V15.4H, #90
    FCADD V13.8H, V27.8H, V23.8H, #90
    FRINT32X V2.2D, V27.2D
    FRINT64Z V20.4S, V2.4S
    FRINT32X V18.2D, V25.2D
    FRINT64X V21.2D, V7.2D
    FRINT32Z V16.4S, V30.4S
    FRINT64X V9.2D, V20.2D
    FCMLA V25.4S, V2.4S, V9.4S, #180
    FRINT64Z V20.2D, V16.2D
    FRINT64X V6.4S, V0.4S
    FRINT64X V15.4S, V21.4S
    FRINT64Z V12.4S, V6.4S
    FRINT64Z V30.2S, V15.2S
    FRINT64Z V16.2S, V31.2S
    FCADD V20.8H, V27.8H, V25.8H, #270
    FCMLA V10.2D, V12.2D, V12.2D, #90
    FRINT32X V22.2S, V10.2S
    FRINT64Z V7.2D, V7.2D
    FRINT32X V28.4S, V5.4S
    FRINT32X V29.2S, V2.2S
    FCMLA V6.8H, V31.8H, V1.8H, #0
    FCADD V27.2S, V30.2S, V3.2S, #270
    FRINT32Z V30.2S, V21.2S
    FCADD V16.2S, V22.2S, V6.2S, #90
    FRINT64X V10.4S, V16.4S
    FRINT32Z V21.2D, V11.2D
    FCADD V25.2S, V27.2S, V29.2S, #270
    FRINT64Z V13.4S, V10.4S
    FCMLA V12.2S, V12.2S, V7.2S, #180
    FCMLA V12.4H, V25.4H, V18.H[0x0], #270
    FRINT32X V15.4S, V31.4S
    FRINT64Z V31.2S, V28.2S
    FCMLA V31.8H, V7.8H, V25.H[0x0], #90
    FRINT32Z V26.4S, V15.4S
    FCMLA V13.4H, V30.4H, V31.4H, #0
    FCMLA V28.4S, V26.4S, V26.4S, #270
    FCADD V9.4S, V27.4S, V28.4S, #270
    FCMLA V13.4H, V14.4H, V4.4H, #270
    FRINT64X V5.2S, V12.2S
    FCADD V9.4S, V25.4S, V5.4S, #270
    FCMLA V1.2S, V9.2S, V31.2S, #90
    FRINT32X V28.4S, V16.4S
    FCADD V28.4H, V28.4H, V1.4H, #90
    FCMLA V21.2S, V13.2S, V21.2S, #90
    FRINT32X V1.2D, V21.2D
    FRINT64X V15.2S, V28.2S
    FCMLA V10.4H, V14.4H, V26.H[0x1], #90
    FCMLA V1.8H, V21.8H, V12.H[0x1], #180
    FRINT64X V18.4S, V1.4S
    FRINT64Z V7.2D, V3.2D
    FCADD V7.2S, V7.2S, V30.2S, #90
    FRINT64X V31.2D, V23.2D
    FRINT64Z V26.2S, V15.2S
    FCMLA V31.4H, V18.4H, V31.4H, #270
    FRINT32X V27.2S, V7.2S
    FCMLA V31.8H, V31.8H, V10.H[0x2], #90
    FCMLA V14.2D, V7.2D, V9.2D, #0
    FCMLA V26.8H, V14.8H, V31.8H, #90
    FRINT32X V9.2S, V21.2S
    FRINT32Z V31.4S, V1.4S
    FCADD V9.4H, V11.4H, V31.4H, #270
    FCADD V21.4H, V13.4H, V30.4H, #90
    FRINT32X V11.4S, V26.4S
    FRINT64X V4.2D, V7.2D
    FRINT32X V31.2S, V13.2S
    FRINT32X V14.2D, V19.2D
    FCMLA V21.4S, V21.4S, V19.S[0x1], #0
    FCADD V29.4S, V28.4S, V13.4S, #270
    FRINT32X V15.4S, V12.4S
    FCADD V1.4H, V4.4H, V3.4H, #90
    FRINT64X V30.4S, V31.4S
    FRINT32X V26.4S, V15.4S
    FCMLA V9.8H, V14.8H, V21.H[0x2], #0
    FRINT32Z V10.4S, V27.4S
    FRINT32X V23.2D, V2.2D
    FCMLA V1.8H, V30.8H, V23.H[0x2], #90
    FRINT32X V2.4S, V26.4S
    FCADD V9.2S, V23.2S, V29.2S, #270
    FCADD V2.8H, V10.8H, V2.8H, #90
    FRINT32X V30.2D, V9.2D
    FRINT32Z V10.2S, V23.2S
    FCMLA V1.4H, V2.4H, V21.H[0x1], #270
    FCMLA V1.2S, V16.2S, V4.2S, #270
    FRINT32X V16.4S, V18.4S
    FRINT32X V23.2D, V24.2D
    FRINT32Z V21.2D, V1.2D
    FRINT32Z V29.4S, V23.4S
    FRINT64X V27.2S, V21.2S
    FCMLA V10.4S, V27.4S, V29.S[0x0], #0
    FRINT32X V9.2S, V30.2S
    FCADD V24.2S, V9.2S, V16.2S, #90
    FCMLA V5.8H, V10.8H, V14.H[0x0], #180
    FRINT64X V23.2S, V5.2S
    FRINT64Z V26.4S, V22.4S
    FCMLA V28.8H, V23.8H, V24.8H, #90
    FCADD V31.4H, V21.4H, V7.4H, #270
    FRINT32Z V22.2S, V5.2S
    FRINT32Z V5.4S, V25.4S
    FCADD V18.2D, V10.2D, V5.2D, #90
    FRINT32X V21.2D, V5.2D
    FRINT32Z V15.2S, V15.2S
    FCMLA V6.8H, V21.8H, V14.H[0x2], #270
    FRINT64X V9.2S, V0.2S
    FCADD V22.8H, V19.8H, V10.8H, #90
    FRINT64Z V16.2S, V31.2S
    FRINT64X V27.4S, V13.4S
    FRINT64X V24.2S, V18.2S
    FCMLA V12.8H, V16.8H, V26.H[0x3], #270
    FRINT64Z V19.2D, V1.2D
    FCMLA V2.8H, V27.8H, V24.H[0x0], #0
    FCMLA V29.8H, V28.8H, V15.H[0x3], #180
    FCMLA V19.4H, V2.4H, V22.4H, #0
    FCMLA V4.4H, V19.4H, V9.4H, #180
    FRINT32Z V24.2D, V30.2D
    FCMLA V12.4S, V7.4S, V19.S[0x0], #180
    FRINT64Z V0.2S, V11.2S
    FCMLA V18.8H, V12.8H, V0.H[0x3], #180
    FCADD V0.2S, V4.2S, V24.2S, #90
    FRINT32X V9.4S, V6.4S
    FRINT64X V14.2D, V19.2D
    FCADD V19.2S, V14.2S, V0.2S, #90
    FRINT64X V5.2S, V9.2S
    FRINT64X V2.2S, V5.2S
    FCMLA V29.2D, V26.2D, V29.2D, #270
    FRINT32X V28.2S, V18.2S
    FCADD V28.8H, V2.8H, V19.8H, #270
    FCMLA V29.4H, V3.4H, V25.H[0x1], #270
    FCMLA V0.4S, V9.4S, V5.S[0x1], #0
    FRINT32X V27.4S, V30.4S
    FRINT32X V14.2S, V20.2S
    FCADD V3.2S, V26.2S, V13.2S, #270
    FCMLA V9.4S, V30.4S, V4.S[0x0], #0
    FRINT64X V7.2D, V30.2D
    FCADD V6.4H, V2.4H, V13.4H, #270
    FRINT64X V26.2D, V6.2D
    FRINT32Z V6.4S, V27.4S
    FRINT64Z V2.2S, V0.2S
    FCMLA V14.4S, V30.4S, V29.S[0x0], #90
    FRINT64X V25.4S, V14.4S
    FRINT64Z V23.2D, V6.2D
    FRINT64Z V4.4S, V23.4S
    FRINT32Z V19.2S, V4.2S
    FRINT64Z V7.2D, V19.2D
    FCADD V28.4S, V7.4S, V9.4S, #90
    FRINT64Z V20.2D, V26.2D
    FRINT32X V26.2D, V2.2D
    FRINT32X V6.2D, V28.2D
    FCMLA V25.4S, V20.4S, V3.4S, #180
    FCMLA V31.8H, V26.8H, V26.H[0x3], #270
    FCMLA V25.4S, V14.4S, V6.S[0x0], #270
    FRINT64X V2.4S, V24.4S
    FCMLA V7.8H, V17.8H, V18.8H, #0
    FCMLA V7.4S, V19.4S, V17.S[0x1], #0
    FCMLA V6.4H, V3.4H, V1.4H, #270
    FCMLA V15.4S, V23.4S, V10.4S, #270
    FRINT64X V27.4S, V10.4S
    SUBS  X10, X10, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X27, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X12, FPSR
    MOVZ  X27, #0x9d, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D0
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x41e0, LSL #16
    MOVK  X27, #0x787f, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D1
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xff7f, LSL #16
    MOVK  X27, #0x7e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D2
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D3
    MOVZ  X27, #0x7e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x7e00, LSL #32
    MOVK  X27, #0xfe00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D4
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D5
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xcf00, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D6
    MOVZ  X27, #0x7e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x7e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D7
    MOVZ  X27, #0x7e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x7e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D8
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xcf00, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D9
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xcf00, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D10
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D11
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xcf00, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D12
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x41e0, LSL #16
    MOVK  X27, #0x4c45, LSL #32
    MOVK  X27, #0xdeff, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D13
    MOVZ  X27, #0x7e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x7e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D14
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7f7f, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xff7f, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D15
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x444b, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D16
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4f00, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D17
    MOVZ  X27, #0x7e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x7e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xcf00, LSL #16
    MOVK  X27, #0xc3ee, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D18
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D19
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D20
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc3e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D21
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D22
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x41e0, LSL #32
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D23
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D24
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D25
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7f7f, LSL #16
    MOVK  X27, #0xdf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D26
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D27
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4f00, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D28
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4f00, LSL #16
    MOVK  X27, #0xcf00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D29
    MOVZ  X27, #0x7e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x7e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D30
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D31
    MOVZ  X27, #0x43e0, LSL #0
    MOVK  X27, #0xc3e0, LSL #32
    MOVK  X27, #0xc1e0, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  D0, X2
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X17
    FMOV  D2, X28
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X27
    FMOV  V4.D[1], X29
    FMOV  D5, X2
    FMOV  V5.D[1], X7
    FMOV  D6, X4
    FMOV  V6.D[1], X29
    FMOV  D7, X24
    FMOV  V7.D[1], X25
    FMOV  D8, X29
    FMOV  V8.D[1], X7
    FMOV  D9, X17
    FMOV  V9.D[1], X28
    FMOV  D10, X11
    FMOV  V10.D[1], X13
    FMOV  D11, X13
    FMOV  V11.D[1], X29
    FMOV  D12, X28
    FMOV  V12.D[1], X15
    FMOV  D13, X23
    FMOV  V13.D[1], X7
    FMOV  D14, X13
    FMOV  V14.D[1], X10
    FMOV  D15, X9
    FMOV  V15.D[1], X9
    FMOV  D16, X6
    FMOV  V16.D[1], X25
    FMOV  D17, X11
    FMOV  V17.D[1], X24
    FMOV  D18, X11
    FMOV  V18.D[1], X6
    FMOV  D19, X8
    FMOV  V19.D[1], X11
    FMOV  D20, X26
    FMOV  V20.D[1], X2
    FMOV  D21, X17
    FMOV  V21.D[1], X6
    FMOV  D22, X25
    FMOV  V22.D[1], X7
    FMOV  D23, X15
    FMOV  V23.D[1], X9
    FMOV  D24, X23
    FMOV  V24.D[1], X16
    FMOV  D25, X3
    FMOV  V25.D[1], X7
    FMOV  D26, X7
    FMOV  V26.D[1], X14
    FMOV  D27, X11
    FMOV  V27.D[1], X13
    FMOV  D28, X2
    FMOV  V28.D[1], X10
    FMOV  D29, X4
    FMOV  V29.D[1], X16
    FMOV  D30, X15
    FMOV  V30.D[1], X28
    FMOV  D31, X29
    FMOV  V31.D[1], X15
    MOVZ  X9, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_4:
    FRINT32X V23.4S, V31.4S
    FCMLA V27.4S, V27.4S, V8.4S, #270
    FRINT64Z V17.2D, V30.2D
    FRINT64Z V11.4S, V25.4S
    FCMLA V13.4S, V17.4S, V14.S[0x0], #0
    FRINT64Z V2.4S, V11.4S
    FCADD V30.8H, V29.8H, V21.8H, #270
    FCADD V13.8H, V30.8H, V23.8H, #270
    FCMLA V6.4S, V2.4S, V27.S[0x1], #180
    FCMLA V28.2S, V1.2S, V3.2S, #90
    FRINT64X V29.2D, V6.2D
    FCMLA V13.8H, V21.8H, V28.H[0x3], #90
    FCMLA V29.4S, V13.4S, V23.S[0x0], #180
    FCMLA V29.2D, V31.2D, V10.2D, #270
    FCMLA V26.8H, V7.8H, V29.H[0x1], #180
    FCMLA V31.2D, V4.2D, V15.2D, #90
    FCADD V8.2D, V21.2D, V9.2D, #270
    FCMLA V7.4S, V18.4S, V0.S[0x1], #270
    FCMLA V13.8H, V6.8H, V17.H[0x2], #180
    FCMLA V30.2S, V20.2S, V25.2S, #270
    FRINT64Z V8.2S, V29.2S
    FRINT64Z V21.2D, V31.2D
    FRINT64Z V20.2D, V28.2D
    FRINT64X V27.2S, V15.2S
    FCMLA V26.8H, V12.8H, V10.8H, #0
    FRINT64Z V12.4S, V25.4S
    FCMLA V28.2S, V8.2S, V26.2S, #180
    FRINT64Z V11.4S, V27.4S
    FRINT32Z V15.2D, V6.2D
    FCADD V13.4H, V20.4H, V17.4H, #90
    FCADD V28.4H, V6.4H, V22.4H, #90
    FRINT64X V6.2D, V10.2D
    FCADD V8.2D, V12.2D, V28.2D, #90
    FRINT32Z V22.2D, V11.2D
    FRINT64Z V29.4S, V28.4S
    FCADD V8.4S, V7.4S, V29.4S, #90
    FCADD V21.4S, V6.4S, V9.4S, #90
    FCADD V15.4H, V24.4H, V13.4H, #270
    FCMLA V22.8H, V31.8H, V30.H[0x1], #180
    FCMLA V7.4H, V11.4H, V6.4H, #270
    FRINT64X V31.2S, V21.2S
    FRINT64X V21.2D, V31.2D
    FCMLA V21.4H, V8.4H, V15.H[0x1], #180
    FRINT32Z V26.4S, V20.4S
    FRINT64X V29.2S, V26.2S
    FRINT64Z V5.4S, V18.4S
    FCADD V7.2S, V21.2S, V5.2S, #270
    FRINT32X V8.4S, V22.4S
    FRINT32Z V28.2D, V8.2D
    FCADD V28.4H, V28.4H, V8.4H, #270
    FCMLA V28.8H, V29.8H, V31.8H, #180
    FCMLA V5.8H, V27.8H, V30.H[0x1], #270
    FCMLA V11.8H, V19.8H, V8.H[0x2], #180
    FCADD V5.4S, V24.4S, V21.4S, #90
    FRINT64X V20.2D, V29.2D
    FCADD V0.2S, V27.2S, V21.2S, #90
    FCMLA V23.2S, V16.2S, V20.2S, #270
    FRINT32X V16.2S, V16.2S
    FCMLA V18.4S, V22.4S, V7.4S, #180
    FCMLA V30.4H, V25.4H, V15.H[0x0], #0
    FCADD V13.4H, V25.4H, V21.4H, #90
    FRINT64Z V27.2S, V23.2S
    FCMLA V18.4S, V30.4S, V21.S[0x1], #0
    FRINT32Z V31.4S, V0.4S
    FCMLA V6.4H, V13.4H, V27.4H, #0
    FCMLA V6.2D, V28.2D, V6.2D, #180
    FCMLA V16.4H, V1.4H, V31.H[0x1], #90
    FCMLA V11.8H, V0.8H, V11.8H, #270
    FRINT64X V23.2S, V9.2S
    FCMLA V6.2D, V0.2D, V11.2D, #0
    FRINT32Z V27.2D, V30.2D
    FRINT64Z V21.2D, V6.2D
    FRINT64X V27.4S, V27.4S
    FRINT64Z V8.2D, V7.2D
    FRINT32X V1.2D, V4.2D
    FCMLA V0.8H, V23.8H, V26.8H, #270
    FRINT32Z V20.4S, V18.4S
    FRINT32X V1.2S, V6.2S
    FRINT64Z V11.2S, V21.2S
    FCMLA V4.4H, V1.4H, V6.H[0x1], #180
    FRINT64Z V15.4S, V4.4S
    FRINT64X V22.2S, V20.2S
    FRINT64X V21.4S, V15.4S
    FCMLA V8.4S, V8.4S, V7.S[0x1], #180
    FRINT32X V12.4S, V11.4S
    FRINT64X V13.2D, V27.2D
    FCMLA V0.8H, V16.8H, V16.H[0x1], #0
    FRINT64Z V11.2S, V8.2S
    FCMLA V1.4S, V31.4S, V12.S[0x1], #180
    FRINT64Z V24.2D, V13.2D
    FRINT32Z V31.2D, V21.2D
    FCADD V23.8H, V27.8H, V27.8H, #270
    FRINT64X V26.2D, V12.2D
    FCMLA V20.4H, V22.4H, V26.H[0x1], #180
    FCMLA V11.2D, V4.2D, V17.2D, #90
    FCMLA V20.4S, V1.4S, V27.S[0x0], #0
    FCADD V23.2S, V0.2S, V23.2S, #270
    FRINT64X V15.4S, V24.4S
    FRINT32Z V14.4S, V5.4S
    FRINT64Z V30.4S, V31.4S
    FRINT32Z V26.4S, V21.4S
    FRINT32X V5.2S, V26.2S
    FCADD V21.4S, V23.4S, V5.4S, #90
    FRINT32X V23.2S, V14.2S
    FRINT32Z V26.2S, V11.2S
    FRINT64X V12.2S, V8.2S
    FRINT64X V0.4S, V23.4S
    FRINT64Z V27.2D, V20.2D
    FCMLA V18.4S, V27.4S, V20.S[0x1], #270
    FRINT64Z V24.4S, V5.4S
    FRINT64Z V21.2S, V30.2S
    FRINT32X V16.2D, V12.2D
    FRINT64Z V4.2D, V1.2D
    FCMLA V18.8H, V21.8H, V16.H[0x1], #90
    FRINT32X V22.2S, V26.2S
    FRINT64X V27.2D, V18.2D
    FRINT32X V14.2D, V30.2D
    FCMLA V3.4H, V22.4H, V15.4H, #90
    FCADD V30.8H, V6.8H, V27.8H, #270
    FCMLA V25.4S, V30.4S, V0.S[0x1], #90
    FRINT32Z V16.2D, V3.2D
    FRINT32X V3.2S, V5.2S
    FRINT32Z V11.4S, V24.4S
    FRINT64Z V22.2S, V11.2S
    FRINT64Z V24.4S, V22.4S
    FCMLA V5.2D, V3.2D, V24.2D, #0
    FRINT64X V21.2D, V29.2D
    FCMLA V16.4S, V9.4S, V5.4S, #180
    FRINT64X V5.4S, V22.4S
    FRINT64Z V26.2D, V6.2D
    FCMLA V19.4S, V25.4S, V5.S[0x1], #90
    FRINT32Z V6.4S, V19.4S
    FCMLA V26.8H, V28.8H, V21.H[0x2], #270
    FCMLA V16.4H, V16.4H, V17.4H, #90
    FRINT64X V8.4S, V6.4S
    FCMLA V14.8H, V2.8H, V0.8H, #180
    FCMLA V13.4H, V26.4H, V26.4H, #0
    FCADD V13.4S, V13.4S, V13.4S, #90
    FCMLA V3.2D, V16.2D, V7.2D, #90
    FRINT32X V19.2S, V8.2S
    FRINT32X V8.4S, V15.4S
    FCMLA V13.8H, V4.8H, V13.H[0x0], #90
    FRINT32Z V6.4S, V13.4S
    FCADD V14.2S, V19.2S, V8.2S, #90
    FCADD V14.8H, V2.8H, V5.8H, #270
    FRINT32Z V2.4S, V26.4S
    FCMLA V15.8H, V14.8H, V20.H[0x1], #0
    FRINT64X V11.4S, V15.4S
    FCMLA V2.4H, V11.4H, V20.4H, #0
    FRINT64Z V15.4S, V3.4S
    FCMLA V6.8H, V25.8H, V2.H[0x3], #180
    FCADD V27.2D, V28.2D, V27.2D, #270
    FCMLA V21.8H, V7.8H, V2.H[0x0], #90
    FRINT32Z V20.2S, V31.2S
    FCMLA V16.8H, V22.8H, V13.H[0x2], #180
    FCADD V23.4S, V1.4S, V9.4S, #90
    FRINT32Z V11.2D, V4.2D
    FCADD V26.4H, V22.4H, V20.4H, #90
    FRINT64X V1.4S, V26.4S
    FCADD V7.2D, V0.2D, V16.2D, #90
    FRINT32X V0.2S, V25.2S
    FRINT64X V31.4S, V18.4S
    FCMLA V6.4H, V7.4H, V21.H[0x1], #0
    FRINT64Z V16.4S, V16.4S
    FRINT32Z V3.4S, V27.4S
    FRINT32Z V9.4S, V6.4S
    FRINT32Z V7.4S, V26.4S
    FCADD V9.4H, V2.4H, V18.4H, #90
    FRINT32X V13.4S, V23.4S
    FRINT32Z V26.2D, V9.2D
    FCADD V7.2D, V0.2D, V11.2D, #90
    FCMLA V16.8H, V26.8H, V7.8H, #180
    FCMLA V1.4S, V13.4S, V16.4S, #0
    FRINT32Z V18.2S, V31.2S
    FRINT32Z V5.2D, V18.2D
    FRINT64Z V6.2D, V1.2D
    FRINT64Z V2.2D, V3.2D
    FRINT64X V1.4S, V2.4S
    FRINT64X V27.4S, V1.4S
    FCADD V27.4H, V4.4H, V5.4H, #90
    FRINT32X V13.2D, V8.2D
    FRINT32Z V24.2D, V4.2D
    FRINT32Z V18.2S, V14.2S
    FCADD V14.2S, V18.2S, V26.2S, #270
    FRINT32X V15.2S, V29.2S
    FRINT32X V31.4S, V14.4S
    FRINT64X V17.2S, V26.2S
    FCMLA V2.8H, V25.8H, V31.H[0x0], #90
    FRINT64Z V2.2S, V15.2S
    FRINT32X V13.2S, V27.2S
    FRINT64X V4.2D, V26.2D
    FCADD V13.2D, V17.2D, V6.2D, #90
    FCADD V24.4S, V11.4S, V4.4S, #270
    FCMLA V22.8H, V5.8H, V13.H[0x2], #0
    FRINT32Z V11.2S, V23.2S
    FCMLA V9.4S, V13.4S, V6.S[0x0], #270
    FRINT64Z V18.2S, V20.2S
    FCMLA V2.8H, V2.8H, V18.H[0x3], #180
    FCADD V11.2S, V19.2S, V9.2S, #270
    FCMLA V2.4H, V22.4H, V5.H[0x0], #270
    SUBS  X9, X9, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_4
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X14, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X27, FPSR
    MOVZ  X14, #0x9d, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D0
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D1
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D7
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D10
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D11
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D14
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D19
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D25
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D29
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D31
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x3ba4, LSL #0
    MOVK  X2, #0x50cb, LSL #16
    MOVK  X2, #0x6d94, LSL #32
    MOVK  X2, #0x85b3, LSL #48
    MOVZ  X3, #0xeaf3, LSL #0
    MOVK  X3, #0x940d, LSL #16
    MOVK  X3, #0xbfec, LSL #32
    MOVK  X3, #0x4172, LSL #48
    MOVZ  X4, #0x20d1, LSL #0
    MOVK  X4, #0x9ab7, LSL #16
    MOVK  X4, #0x31c7, LSL #32
    MOVK  X4, #0xfede, LSL #48
    MOVZ  X5, #0x4725, LSL #0
    MOVK  X5, #0x8dc1, LSL #16
    MOVK  X5, #0x8601, LSL #32
    MOVK  X5, #0xddc3, LSL #48
    MOVZ  X6, #0xd8d4, LSL #0
    MOVK  X6, #0xdfad, LSL #16
    MOVK  X6, #0xafaf, LSL #32
    MOVK  X6, #0x765d, LSL #48
    MOVZ  X7, #0x499f, LSL #0
    MOVK  X7, #0xadf2, LSL #16
    MOVK  X7, #0x337f, LSL #32
    MOVK  X7, #0x2424, LSL #48
    MOVZ  X8, #0x333e, LSL #0
    MOVK  X8, #0x8dc0, LSL #16
    MOVK  X8, #0x51d2, LSL #32
    MOVK  X8, #0x3a81, LSL #48
    MOVZ  X9, #0xbc69, LSL #0
    MOVK  X9, #0xb021, LSL #16
    MOVK  X9, #0x65c5, LSL #32
    MOVK  X9, #0x654f, LSL #48
    MOVZ  X10, #0x2236, LSL #0
    MOVK  X10, #0x71b8, LSL #16
    MOVK  X10, #0x4d4c, LSL #32
    MOVK  X10, #0xbe9f, LSL #48
    MOVZ  X11, #0x895a, LSL #0
    MOVK  X11, #0x9eec, LSL #16
    MOVK  X11, #0x4ed8, LSL #32
    MOVK  X11, #0x15a9, LSL #48
    MOVZ  X12, #0xde11, LSL #0
    MOVK  X12, #0x72e6, LSL #16
    MOVK  X12, #0x918f, LSL #32
    MOVK  X12, #0xd5c9, LSL #48
    MOVZ  X13, #0xe25a, LSL #0
    MOVK  X13, #0x3825, LSL #16
    MOVK  X13, #0x1fbc, LSL #32
    MOVK  X13, #0xa8ab, LSL #48
    MOVZ  X14, #0x77d8, LSL #0
    MOVK  X14, #0x22a6, LSL #16
    MOVK  X14, #0xc592, LSL #32
    MOVK  X14, #0xfef1, LSL #48
    MOVZ  X15, #0x367, LSL #0
    MOVK  X15, #0x3a3, LSL #16
    MOVK  X15, #0xfcfa, LSL #32
    MOVK  X15, #0xc48e, LSL #48
    MOVZ  X16, #0x6e1b, LSL #0
    MOVK  X16, #0x2672, LSL #16
    MOVK  X16, #0xf36f, LSL #32
    MOVK  X16, #0x3d8, LSL #48
    MOVZ  X17, #0x66c6, LSL #0
    MOVK  X17, #0xf462, LSL #16
    MOVK  X17, #0x548b, LSL #32
    MOVK  X17, #0x54ef, LSL #48
    MOVZ  X23, #0x3b7a, LSL #0
    MOVK  X23, #0x2f04, LSL #16
    MOVK  X23, #0x7d87, LSL #32
    MOVK  X23, #0x6a34, LSL #48
    MOVZ  X24, #0xa21f, LSL #0
    MOVK  X24, #0x9d55, LSL #16
    MOVK  X24, #0xbac, LSL #32
    MOVK  X24, #0x1, LSL #48
    MOVZ  X25, #0x4582, LSL #0
    MOVK  X25, #0xbbb6, LSL #16
    MOVK  X25, #0x9c56, LSL #32
    MOVK  X25, #0x827, LSL #48
    MOVZ  X26, #0x6868, LSL #0
    MOVK  X26, #0x268f, LSL #16
    MOVK  X26, #0x9a90, LSL #32
    MOVK  X26, #0x6927, LSL #48
    MOVZ  X27, #0xd164, LSL #0
    MOVK  X27, #0x812a, LSL #16
    MOVK  X27, #0x2a1a, LSL #32
    MOVK  X27, #0xba64, LSL #48
    MOVZ  X28, #0x9eff, LSL #0
    MOVK  X28, #0x3910, LSL #16
    MOVK  X28, #0xa8ba, LSL #32
    MOVK  X28, #0xe93a, LSL #48
    MOVZ  X29, #0x11a6, LSL #0
    MOVK  X29, #0xc96f, LSL #16
    MOVK  X29, #0x41bf, LSL #32
    MOVK  X29, #0xee5c, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X9
    FMOV  D1, X28
    FMOV  V1.D[1], X6
    FMOV  D2, X8
    FMOV  V2.D[1], X23
    FMOV  D3, X10
    FMOV  V3.D[1], X11
    FMOV  D4, X24
    FMOV  V4.D[1], X29
    FMOV  D5, X24
    FMOV  V5.D[1], X15
    FMOV  D6, X6
    FMOV  V6.D[1], X29
    FMOV  D7, X4
    FMOV  V7.D[1], X13
    FMOV  D8, X25
    FMOV  V8.D[1], X8
    FMOV  D9, X2
    FMOV  V9.D[1], X8
    FMOV  D10, X2
    FMOV  V10.D[1], X4
    FMOV  D11, X16
    FMOV  V11.D[1], X9
    FMOV  D12, X4
    FMOV  V12.D[1], X15
    FMOV  D13, X8
    FMOV  V13.D[1], X14
    FMOV  D14, X29
    FMOV  V14.D[1], X28
    FMOV  D15, X29
    FMOV  V15.D[1], X3
    FMOV  D16, X27
    FMOV  V16.D[1], X2
    FMOV  D17, X5
    FMOV  V17.D[1], X10
    FMOV  D18, X16
    FMOV  V18.D[1], X11
    FMOV  D19, X8
    FMOV  V19.D[1], X4
    FMOV  D20, X17
    FMOV  V20.D[1], X7
    FMOV  D21, X23
    FMOV  V21.D[1], X13
    FMOV  D22, X13
    FMOV  V22.D[1], X2
    FMOV  D23, X12
    FMOV  V23.D[1], X16
    FMOV  D24, X26
    FMOV  V24.D[1], X15
    FMOV  D25, X10
    FMOV  V25.D[1], X13
    FMOV  D26, X2
    FMOV  V26.D[1], X3
    FMOV  D27, X29
    FMOV  V27.D[1], X13
    FMOV  D28, X7
    FMOV  V28.D[1], X24
    FMOV  D29, X8
    FMOV  V29.D[1], X5
    FMOV  D30, X23
    FMOV  V30.D[1], X5
    FMOV  D31, X28
    FMOV  V31.D[1], X23
    MOVZ  X15, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_5:
    FCADD V30.4S, V31.4S, V6.4S, #90
    FRINT32Z V22.2D, V23.2D
    FRINT32Z V24.4S, V7.4S
    FRINT32X V31.2S, V3.2S
    FRINT64Z V26.2S, V24.2S
    FRINT32X V24.4S, V31.4S
    FCMLA V25.2S, V24.2S, V24.2S, #270
    FRINT32X V3.2D, V29.2D
    FRINT32Z V8.2D, V27.2D
    FCMLA V7.4H, V3.4H, V1.H[0x0], #180
    FCMLA V1.4S, V30.4S, V23.4S, #90
    FCMLA V22.8H, V21.8H, V22.H[0x3], #0
    FRINT64Z V22.4S, V29.4S
    FCMLA V8.8H, V26.8H, V26.8H, #180
    FRINT64Z V25.2S, V28.2S
    FRINT32X V4.2D, V8.2D
    FCMLA V26.4S, V22.4S, V22.4S, #0
    FRINT64X V1.4S, V1.4S
    FRINT64Z V24.2S, V17.2S
    FCMLA V1.4S, V26.4S, V25.4S, #90
    FRINT64Z V29.2D, V8.2D
    FCADD V17.4S, V1.4S, V20.4S, #90
    FRINT32X V20.4S, V1.4S
    FCMLA V10.8H, V7.8H, V29.H[0x2], #180
    FCMLA V25.4H, V4.4H, V16.H[0x1], #90
    FCMLA V24.2S, V17.2S, V10.2S, #0
    FRINT64X V26.2S, V20.2S
    FCMLA V18.4S, V25.4S, V12.4S, #180
    FCADD V14.8H, V24.8H, V18.8H, #90
    FCMLA V30.4H, V9.4H, V13.H[0x1], #180
    FRINT32Z V21.2S, V13.2S
    FCMLA V9.8H, V20.8H, V18.H[0x0], #90
    FRINT64X V16.2D, V15.2D
    FRINT32X V28.2S, V7.2S
    FCMLA V0.4S, V15.4S, V15.4S, #270
    FCMLA V6.4H, V17.4H, V16.4H, #90
    FCADD V5.2S, V12.2S, V11.2S, #90
    FRINT32Z V24.2S, V30.2S
    FCMLA V9.2S, V7.2S, V26.2S, #270
    FCADD V21.4S, V9.4S, V24.4S, #270
    FCMLA V16.4S, V21.4S, V6.S[0x0], #0
    FCMLA V31.4H, V16.4H, V16.H[0x1], #270
    FCMLA V16.4S, V6.4S, V5.S[0x1], #180
    FCMLA V28.8H, V14.8H, V15.H[0x2], #180
    FRINT32Z V13.2D, V31.2D
    FCADD V29.4H, V7.4H, V16.4H, #270
    FCMLA V27.4H, V26.4H, V31.H[0x0], #0
    FRINT32X V5.2S, V28.2S
    FCMLA V0.4H, V27.4H, V29.H[0x1], #180
    FRINT64X V6.4S, V5.4S
    FCMLA V13.4H, V29.4H, V12.H[0x1], #90
    FRINT64Z V23.2S, V14.2S
    FRINT32X V17.4S, V6.4S
    FCADD V22.4H, V23.4H, V23.4H, #90
    FCMLA V17.4H, V22.4H, V0.4H, #0
    FRINT64Z V26.2D, V1.2D
    FRINT64X V16.2D, V22.2D
    FRINT32X V31.4S, V7.4S
    FCADD V13.2S, V4.2S, V4.2S, #270
    FRINT32X V27.4S, V22.4S
    FCMLA V20.2S, V16.2S, V16.2S, #90
    FRINT64Z V6.4S, V7.4S
    FRINT32Z V16.2D, V17.2D
    FCMLA V29.8H, V15.8H, V21.H[0x2], #0
    FCADD V20.2D, V20.2D, V23.2D, #270
    FRINT32Z V0.4S, V12.4S
    FCMLA V12.4S, V0.4S, V29.4S, #180
    FRINT64X V19.4S, V6.4S
    FRINT32Z V1.2D, V26.2D
    FRINT32X V6.4S, V0.4S
    FRINT64X V4.2S, V13.2S
    FCADD V31.4S, V19.4S, V19.4S, #270
    FRINT32X V16.2S, V16.2S
    FCMLA V1.4S, V20.4S, V22.S[0x0], #90
    FRINT32X V1.2D, V16.2D
    FCMLA V10.4S, V6.4S, V1.S[0x1], #180
    FRINT32X V23.2D, V10.2D
    FRINT64Z V1.4S, V17.4S
    FRINT64Z V7.4S, V1.4S
    FCMLA V23.4H, V12.4H, V31.4H, #0
    FCMLA V23.8H, V23.8H, V31.H[0x1], #270
    FRINT64X V10.2D, V3.2D
    FRINT64Z V1.4S, V4.4S
    FRINT64Z V0.2S, V27.2S
    FCADD V22.4H, V0.4H, V22.4H, #270
    FCMLA V20.4S, V6.4S, V14.4S, #0
    FCADD V10.2S, V10.2S, V6.2S, #90
    FCMLA V15.8H, V23.8H, V18.H[0x2], #90
    FRINT32Z V19.2D, V22.2D
    FCMLA V20.8H, V25.8H, V7.H[0x0], #270
    FCMLA V20.2S, V10.2S, V15.2S, #180
    FRINT64X V12.4S, V1.4S
    FRINT32X V25.2S, V12.2S
    FRINT64X V22.2D, V25.2D
    FCMLA V23.8H, V20.8H, V19.H[0x3], #90
    FRINT64Z V3.2D, V16.2D
    FCMLA V23.4H, V3.4H, V26.H[0x0], #0
    FCMLA V1.8H, V31.8H, V5.H[0x3], #270
    FRINT32Z V16.2S, V18.2S
    FCMLA V26.4H, V12.4H, V25.H[0x0], #270
    FCMLA V1.4S, V9.4S, V28.S[0x0], #0
    FCMLA V15.4H, V29.4H, V24.4H, #180
    FCMLA V14.4S, V3.4S, V30.4S, #0
    FCMLA V14.4S, V23.4S, V29.S[0x1], #0
    FCMLA V21.8H, V0.8H, V15.8H, #90
    FCMLA V13.4H, V0.4H, V26.4H, #180
    FRINT64Z V18.2D, V20.2D
    FRINT64X V12.2S, V13.2S
    FRINT32X V25.2S, V21.2S
    FCMLA V19.4H, V24.4H, V5.4H, #180
    FRINT64Z V7.2S, V19.2S
    FRINT32Z V19.2D, V23.2D
    FCMLA V8.4S, V7.4S, V12.S[0x0], #0
    FRINT32X V23.2D, V1.2D
    FRINT32X V15.4S, V16.4S
    FCMLA V28.4H, V19.4H, V23.H[0x0], #270
    FRINT32X V10.2D, V0.2D
    FCMLA V10.8H, V25.8H, V28.8H, #270
    FRINT64X V19.4S, V14.4S
    FRINT32X V12.2D, V11.2D
    FCMLA V18.4H, V24.4H, V2.4H, #270
    FCMLA V12.8H, V22.8H, V22.H[0x0], #270
    FRINT32X V0.2D, V8.2D
    FRINT32X V20.2D, V19.2D
    FCADD V28.8H, V12.8H, V15.8H, #90
    FRINT32Z V19.4S, V18.4S
    FCMLA V6.4H, V19.4H, V0.H[0x1], #180
    FCMLA V13.4S, V6.4S, V24.S[0x1], #90
    FRINT64X V8.2S, V13.2S
    FCMLA V20.4H, V10.4H, V8.H[0x1], #0
    FCMLA V25.4S, V7.4S, V6.4S, #90
    FCMLA V5.4H, V2.4H, V8.4H, #180
    FCMLA V24.4S, V0.4S, V26.S[0x1], #180
    FCADD V29.2S, V22.2S, V13.2S, #90
    FCMLA V26.8H, V13.8H, V31.8H, #270
    FRINT64X V31.2S, V19.2S
    FRINT32X V7.2S, V10.2S
    FCMLA V31.4S, V7.4S, V26.4S, #270
    FCMLA V25.4H, V29.4H, V10.H[0x0], #180
    FRINT64Z V29.2D, V16.2D
    FRINT64X V0.4S, V29.4S
    FCMLA V24.8H, V16.8H, V24.H[0x0], #0
    FRINT32X V18.2S, V24.2S
    FCMLA V8.4H, V5.4H, V18.H[0x0], #0
    FCMLA V28.4H, V28.4H, V2.H[0x1], #270
    FCMLA V5.4H, V31.4H, V22.H[0x0], #0
    FRINT32X V24.4S, V8.4S
    FRINT64Z V19.2S, V5.2S
    FCMLA V1.8H, V24.8H, V25.8H, #180
    FCADD V14.4H, V9.4H, V0.4H, #270
    FRINT64Z V7.4S, V1.4S
    FRINT64Z V1.4S, V2.4S
    FRINT64X V23.4S, V20.4S
    FRINT32Z V13.2S, V7.2S
    FRINT64X V22.2D, V24.2D
    FCMLA V19.4S, V1.4S, V13.S[0x0], #270
    FCMLA V19.4S, V19.4S, V28.S[0x1], #180
    FCMLA V23.4H, V22.4H, V22.H[0x1], #0
    FCMLA V13.4S, V19.4S, V14.S[0x0], #0
    FCADD V28.4H, V11.4H, V14.4H, #90
    FCMLA V26.8H, V25.8H, V17.H[0x0], #180
    FCMLA V1.4S, V8.4S, V25.S[0x0], #90
    FRINT32Z V20.2S, V9.2S
    FRINT64X V22.2S, V10.2S
    FCADD V30.2D, V14.2D, V19.2D, #270
    FCADD V6.2S, V6.2S, V27.2S, #90
    FCMLA V30.8H, V20.8H, V25.H[0x2], #270
    FCMLA V1.4S, V23.4S, V23.S[0x1], #0
    FCMLA V1.2S, V9.2S, V30.2S, #180
    FCADD V13.4S, V13.4S, V22.4S, #90
    FRINT32X V5.2D, V1.2D
    FCADD V4.2S, V13.2S, V6.2S, #90
    FCMLA V3.4H, V24.4H, V26.4H, #270
    FCADD V4.4S, V2.4S, V15.4S, #270
    FRINT32X V10.2D, V28.2D
    FCADD V3.8H, V17.8H, V15.8H, #270
    FRINT32Z V20.4S, V21.4S
    FRINT64X V6.4S, V3.4S
    FCADD V20.4S, V3.4S, V15.4S, #90
    FRINT64Z V3.2D, V14.2D
    FCMLA V10.4H, V6.4H, V6.H[0x1], #0
    FRINT64Z V26.2S, V18.2S
    FCMLA V5.8H, V27.8H, V3.H[0x2], #0
    FRINT32X V2.4S, V26.4S
    FRINT64X V22.2D, V21.2D
    FRINT32X V15.2S, V27.2S
    FCMLA V20.4S, V22.4S, V10.4S, #180
    FCMLA V5.2D, V20.2D, V8.2D, #180
    FRINT64X V14.4S, V3.4S
    FCMLA V15.4H, V2.4H, V2.H[0x1], #270
    FRINT64X V17.2S, V4.2S
    FRINT32X V6.4S, V14.4S
    FRINT32X V1.4S, V30.4S
    FRINT32X V18.4S, V19.4S
    FCMLA V5.4S, V17.4S, V5.S[0x0], #270
    FRINT32X V8.4S, V27.4S
    FCMLA V11.4H, V23.4H, V31.4H, #90
    FRINT64Z V21.2D, V16.2D
    FCADD V18.4H, V16.4H, V6.4H, #90
    FCMLA V22.8H, V30.8H, V1.8H, #90
    SUBS  X15, X15, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_5
    MOVZ  X12, #0x3ba4, LSL #0
    MOVK  X12, #0x50cb, LSL #16
    MOVK  X12, #0x6d94, LSL #32
    MOVK  X12, #0x85b3, LSL #48
    SUB  X24, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0xeaf3, LSL #0
    MOVK  X12, #0x940d, LSL #16
    MOVK  X12, #0xbfec, LSL #32
    MOVK  X12, #0x4172, LSL #48
    SUB  X24, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x20d1, LSL #0
    MOVK  X12, #0x9ab7, LSL #16
    MOVK  X12, #0x31c7, LSL #32
    MOVK  X12, #0xfede, LSL #48
    SUB  X24, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x4725, LSL #0
    MOVK  X12, #0x8dc1, LSL #16
    MOVK  X12, #0x8601, LSL #32
    MOVK  X12, #0xddc3, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0xd8d4, LSL #0
    MOVK  X12, #0xdfad, LSL #16
    MOVK  X12, #0xafaf, LSL #32
    MOVK  X12, #0x765d, LSL #48
    SUB  X24, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x499f, LSL #0
    MOVK  X12, #0xadf2, LSL #16
    MOVK  X12, #0x337f, LSL #32
    MOVK  X12, #0x2424, LSL #48
    SUB  X24, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x333e, LSL #0
    MOVK  X12, #0x8dc0, LSL #16
    MOVK  X12, #0x51d2, LSL #32
    MOVK  X12, #0x3a81, LSL #48
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0xbc69, LSL #0
    MOVK  X12, #0xb021, LSL #16
    MOVK  X12, #0x65c5, LSL #32
    MOVK  X12, #0x654f, LSL #48
    SUB  X24, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x2236, LSL #0
    MOVK  X12, #0x71b8, LSL #16
    MOVK  X12, #0x4d4c, LSL #32
    MOVK  X12, #0xbe9f, LSL #48
    SUB  X24, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x895a, LSL #0
    MOVK  X12, #0x9eec, LSL #16
    MOVK  X12, #0x4ed8, LSL #32
    MOVK  X12, #0x15a9, LSL #48
    SUB  X24, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0xe25a, LSL #0
    MOVK  X12, #0x3825, LSL #16
    MOVK  X12, #0x1fbc, LSL #32
    MOVK  X12, #0xa8ab, LSL #48
    SUB  X24, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x77d8, LSL #0
    MOVK  X12, #0x22a6, LSL #16
    MOVK  X12, #0xc592, LSL #32
    MOVK  X12, #0xfef1, LSL #48
    SUB  X24, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x66c6, LSL #0
    MOVK  X12, #0xf462, LSL #16
    MOVK  X12, #0x548b, LSL #32
    MOVK  X12, #0x54ef, LSL #48
    SUB  X24, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x3b7a, LSL #0
    MOVK  X12, #0x2f04, LSL #16
    MOVK  X12, #0x7d87, LSL #32
    MOVK  X12, #0x6a34, LSL #48
    SUB  X24, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x4582, LSL #0
    MOVK  X12, #0xbbb6, LSL #16
    MOVK  X12, #0x9c56, LSL #32
    MOVK  X12, #0x827, LSL #48
    SUB  X24, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x6868, LSL #0
    MOVK  X12, #0x268f, LSL #16
    MOVK  X12, #0x9a90, LSL #32
    MOVK  X12, #0x6927, LSL #48
    SUB  X24, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0xd164, LSL #0
    MOVK  X12, #0x812a, LSL #16
    MOVK  X12, #0x2a1a, LSL #32
    MOVK  X12, #0xba64, LSL #48
    SUB  X24, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x9eff, LSL #0
    MOVK  X12, #0x3910, LSL #16
    MOVK  X12, #0xa8ba, LSL #32
    MOVK  X12, #0xe93a, LSL #48
    SUB  X24, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X12, #0x11a6, LSL #0
    MOVK  X12, #0xc96f, LSL #16
    MOVK  X12, #0x41bf, LSL #32
    MOVK  X12, #0xee5c, LSL #48
    SUB  X24, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X12, FPSR
    MOVZ  X24, #0x9d, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D1
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D2
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D3
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc3e0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D4
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7fc0, LSL #16
    MOVK  X24, #0x7fc0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D5
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7fc0, LSL #16
    MOVK  X24, #0x7fc0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D6
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc3e0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D7
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xdf00, LSL #16
    MOVK  X24, #0xdf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D8
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D9
    MOVZ  X24, #0x7e00, LSL #0
    MOVK  X24, #0x7e00, LSL #16
    MOVK  X24, #0x7dff, LSL #32
    MOVK  X24, #0x7e00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D10
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc1e0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D11
    MOVZ  X24, #0x7e00, LSL #0
    MOVK  X24, #0x7e00, LSL #16
    MOVK  X24, #0xf952, LSL #32
    MOVK  X24, #0x3d8, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D12
    MOVZ  X24, #0x4850, LSL #0
    MOVK  X24, #0x4850, LSL #32
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D13
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x7f7f, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x7f7f, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D14
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc3e0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D15
    MOVZ  X24, #0x6220, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0x6220, LSL #32
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D17
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D18
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x43e0, LSL #32
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D19
    MOVZ  X24, #0xfffe, LSL #0
    MOVK  X24, #0x5e7f, LSL #16
    MOVK  X24, #0xde80, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D20
    MOVZ  X24, #0x7e00, LSL #0
    MOVK  X24, #0x7e00, LSL #16
    MOVK  X24, #0x7e00, LSL #32
    MOVK  X24, #0x7e00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X24, #0x71af, LSL #0
    MOVK  X24, #0x71b0, LSL #32
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D22
    MOVZ  X24, #0x7e00, LSL #0
    MOVK  X24, #0x7e00, LSL #16
    MOVK  X24, #0x7e00, LSL #32
    MOVK  X24, #0x7e00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D23
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xdf00, LSL #16
    MOVK  X24, #0xdf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D24
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc1e0, LSL #16
    MOVK  X24, #0xc1e0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D25
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D26
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D27
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xcf00, LSL #16
    MOVK  X24, #0xcf00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D28
    MOVZ  X24, #0x7e00, LSL #0
    MOVK  X24, #0x7e00, LSL #16
    MOVK  X24, #0x7e00, LSL #32
    MOVK  X24, #0x7e00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X24, #0x7e00, LSL #0
    MOVK  X24, #0x5e7f, LSL #16
    MOVK  X24, #0x5e80, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D30
    MOVZ  X24, #0x7e00, LSL #0
    MOVK  X24, #0x7e00, LSL #16
    MOVK  X24, #0x7e00, LSL #32
    MOVK  X24, #0x7e00, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X12, D31
    MOVZ  X24, #0x4850, LSL #0
    MOVK  X24, #0x5360, LSL #16
    MOVK  X24, #0xc3e0, LSL #48
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X5
    FMOV  V0.D[1], X24
    FMOV  D1, X11
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X3
    FMOV  D3, X6
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X15
    FMOV  D5, X23
    FMOV  V5.D[1], X3
    FMOV  D6, X17
    FMOV  V6.D[1], X28
    FMOV  D7, X16
    FMOV  V7.D[1], X12
    FMOV  D8, X27
    FMOV  V8.D[1], X25
    FMOV  D9, X24
    FMOV  V9.D[1], X11
    FMOV  D10, X5
    FMOV  V10.D[1], X3
    FMOV  D11, X3
    FMOV  V11.D[1], X24
    FMOV  D12, X2
    FMOV  V12.D[1], X26
    FMOV  D13, X13
    FMOV  V13.D[1], X14
    FMOV  D14, X23
    FMOV  V14.D[1], X23
    FMOV  D15, X10
    FMOV  V15.D[1], X17
    FMOV  D16, X17
    FMOV  V16.D[1], X24
    FMOV  D17, X24
    FMOV  V17.D[1], X12
    FMOV  D18, X4
    FMOV  V18.D[1], X25
    FMOV  D19, X6
    FMOV  V19.D[1], X25
    FMOV  D20, X8
    FMOV  V20.D[1], X13
    FMOV  D21, X27
    FMOV  V21.D[1], X23
    FMOV  D22, X12
    FMOV  V22.D[1], X25
    FMOV  D23, X15
    FMOV  V23.D[1], X5
    FMOV  D24, X7
    FMOV  V24.D[1], X10
    FMOV  D25, X7
    FMOV  V25.D[1], X11
    FMOV  D26, X7
    FMOV  V26.D[1], X7
    FMOV  D27, X28
    FMOV  V27.D[1], X23
    FMOV  D28, X14
    FMOV  V28.D[1], X10
    FMOV  D29, X7
    FMOV  V29.D[1], X26
    FMOV  D30, X2
    FMOV  V30.D[1], X4
    FMOV  D31, X28
    FMOV  V31.D[1], X6
    MOVZ  X8, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_6:
    FRINT32Z V2.4S, V30.4S
    FRINT32X V6.2D, V27.2D
    FCMLA V31.8H, V24.8H, V29.H[0x2], #270
    FRINT64Z V2.4S, V26.4S
    FRINT32X V16.2S, V15.2S
    FRINT32X V19.2S, V20.2S
    FCMLA V6.4H, V6.4H, V19.H[0x0], #270
    FCMLA V29.8H, V10.8H, V20.8H, #270
    FRINT64Z V10.4S, V28.4S
    FRINT64X V4.2S, V3.2S
    FCADD V4.8H, V2.8H, V23.8H, #90
    FRINT32Z V21.2S, V4.2S
    FRINT32X V6.2D, V31.2D
    FRINT32Z V22.4S, V6.4S
    FCMLA V26.4S, V6.4S, V6.S[0x0], #0
    FRINT32X V28.2D, V21.2D
    FRINT32Z V29.2D, V28.2D
    FRINT64Z V3.4S, V29.4S
    FRINT32X V27.2D, V2.2D
    FCMLA V27.4H, V26.4H, V22.H[0x0], #180
    FCADD V28.2D, V3.2D, V10.2D, #270
    FCADD V25.2D, V3.2D, V16.2D, #90
    FRINT32Z V23.2D, V27.2D
    FRINT64Z V4.2D, V16.2D
    FCMLA V2.8H, V25.8H, V26.8H, #270
    FRINT32X V20.2S, V2.2S
    FRINT64Z V31.2S, V20.2S
    FCMLA V23.4H, V26.4H, V9.4H, #270
    FCMLA V16.8H, V23.8H, V4.H[0x0], #270
    FCMLA V31.2S, V27.2S, V13.2S, #180
    FCMLA V4.4H, V29.4H, V27.H[0x0], #0
    FRINT64Z V29.2D, V28.2D
    FRINT32Z V22.2D, V29.2D
    FCADD V4.4S, V28.4S, V5.4S, #90
    FCMLA V4.4H, V12.4H, V4.4H, #180
    FCMLA V4.4S, V16.4S, V31.S[0x1], #270
    FCMLA V20.8H, V0.8H, V26.H[0x0], #90
    FRINT32X V2.2D, V16.2D
    FCMLA V7.8H, V18.8H, V11.8H, #180
    FRINT64Z V18.2S, V11.2S
    FRINT32X V9.4S, V10.4S
    FCADD V21.2S, V21.2S, V28.2S, #90
    FCADD V22.4H, V5.4H, V16.4H, #270
    FRINT32X V26.2D, V18.2D
    FRINT32X V27.4S, V20.4S
    FRINT64X V5.2D, V4.2D
    FRINT32X V10.2D, V5.2D
    FRINT64X V16.4S, V21.4S
    FRINT64X V12.4S, V10.4S
    FRINT32X V4.2S, V2.2S
    FRINT32X V5.2S, V9.2S
    FCMLA V17.4H, V12.4H, V22.4H, #0
    FRINT32Z V9.2D, V5.2D
    FCMLA V7.2D, V27.2D, V4.2D, #90
    FRINT32Z V6.2D, V26.2D
    FRINT64X V5.2D, V28.2D
    FRINT64X V28.2S, V9.2S
    FCMLA V16.4S, V15.4S, V5.4S, #90
    FCMLA V22.8H, V6.8H, V14.H[0x2], #90
    FCMLA V28.4S, V22.4S, V22.S[0x0], #180
    FRINT32X V0.4S, V7.4S
    FRINT64Z V7.4S, V31.4S
    FCMLA V16.4H, V19.4H, V4.H[0x0], #0
    FRINT32Z V10.2D, V1.2D
    FRINT64X V1.2S, V7.2S
    FRINT32Z V22.4S, V1.4S
    FCMLA V17.4H, V17.4H, V4.H[0x0], #180
    FRINT64Z V7.2S, V26.2S
    FRINT32X V2.2S, V0.2S
    FRINT32X V31.2S, V23.2S
    FCMLA V17.4H, V12.4H, V28.4H, #180
    FCMLA V16.4H, V7.4H, V22.H[0x0], #0
    FRINT32Z V27.2D, V14.2D
    FCMLA V8.4H, V27.4H, V31.H[0x1], #180
    FCADD V17.2S, V2.2S, V2.2S, #270
    FRINT64Z V1.2D, V10.2D
    FRINT64X V14.2D, V1.2D
    FRINT32X V22.4S, V16.4S
    FRINT64Z V19.2D, V16.2D
    FRINT64X V26.2D, V14.2D
    FRINT64X V8.4S, V17.4S
    FCMLA V8.2D, V9.2D, V2.2D, #270
    FCMLA V30.8H, V22.8H, V8.H[0x0], #180
    FCMLA V9.8H, V19.8H, V31.H[0x3], #90
    FCMLA V22.4H, V9.4H, V27.H[0x0], #0
    FRINT64Z V2.2D, V22.2D
    FRINT64Z V1.2S, V2.2S
    FRINT64Z V23.4S, V15.4S
    FRINT64X V0.2D, V30.2D
    FRINT64X V17.2S, V1.2S
    FCADD V0.2S, V24.2S, V23.2S, #270
    FCADD V6.4H, V22.4H, V26.4H, #90
    FCMLA V0.8H, V6.8H, V0.H[0x0], #180
    FRINT64Z V6.2S, V0.2S
    FRINT32Z V1.4S, V4.4S
    FCMLA V28.8H, V27.8H, V20.H[0x3], #90
    FRINT32X V22.4S, V21.4S
    FRINT64Z V27.4S, V2.4S
    FRINT64X V9.4S, V31.4S
    FCMLA V23.8H, V20.8H, V5.H[0x1], #270
    FRINT64Z V15.2S, V30.2S
    FRINT32Z V0.2S, V6.2S
    FRINT64X V11.2S, V5.2S
    FCMLA V27.8H, V20.8H, V10.H[0x3], #180
    FRINT64X V11.2D, V22.2D
    FCMLA V2.2D, V13.2D, V23.2D, #90
    FRINT64X V22.2S, V13.2S
    FRINT32X V16.4S, V24.4S
    FCMLA V16.4H, V11.4H, V16.4H, #0
    FCADD V28.4H, V15.4H, V0.4H, #270
    FCADD V9.2S, V2.2S, V17.2S, #90
    FCMLA V28.4S, V18.4S, V28.S[0x1], #0
    FRINT64X V30.4S, V26.4S
    FCMLA V1.2D, V27.2D, V27.2D, #90
    FRINT32X V28.2S, V3.2S
    FCMLA V23.4S, V22.4S, V30.S[0x1], #0
    FCMLA V5.4H, V3.4H, V9.H[0x1], #0
    FCMLA V16.8H, V22.8H, V23.8H, #270
    FRINT64Z V27.4S, V24.4S
    FCMLA V3.4S, V12.4S, V16.S[0x1], #90
    FRINT64Z V30.2S, V31.2S
    FRINT32X V10.2D, V28.2D
    FCMLA V3.2D, V30.2D, V10.2D, #180
    FRINT64Z V24.4S, V3.4S
    FRINT32Z V15.4S, V1.4S
    FRINT32Z V2.4S, V28.4S
    FCMLA V24.8H, V15.8H, V17.H[0x0], #0
    FRINT64X V22.4S, V31.4S
    FRINT64X V11.2S, V27.2S
    FCMLA V22.4H, V20.4H, V24.H[0x0], #0
    FCMLA V15.4H, V11.4H, V5.H[0x0], #270
    FCADD V30.2S, V22.2S, V4.2S, #270
    FRINT32X V28.4S, V14.4S
    FCMLA V28.4S, V2.4S, V8.4S, #90
    FCMLA V13.8H, V28.8H, V30.H[0x0], #270
    FRINT32X V0.2D, V28.2D
    FCMLA V10.8H, V8.8H, V8.H[0x1], #90
    FRINT64X V3.2S, V21.2S
    FRINT64Z V31.2S, V25.2S
    FCMLA V3.4S, V24.4S, V10.S[0x1], #270
    FRINT64Z V28.2S, V31.2S
    FCADD V25.2S, V0.2S, V0.2S, #90
    FCADD V13.4S, V21.4S, V29.4S, #270
    FCADD V15.4S, V30.4S, V13.4S, #90
    FRINT64Z V4.4S, V23.4S
    FRINT32X V25.2S, V1.2S
    FRINT32Z V31.4S, V9.4S
    FCMLA V20.2S, V3.2S, V19.2S, #90
    FRINT64Z V10.2D, V13.2D
    FRINT64X V24.2S, V30.2S
    FCMLA V17.4H, V1.4H, V6.H[0x0], #270
    FRINT32X V2.2S, V25.2S
    FCMLA V13.4H, V10.4H, V29.4H, #180
    FRINT64Z V8.4S, V4.4S
    FCADD V17.8H, V18.8H, V8.8H, #90
    FCADD V2.8H, V2.8H, V31.8H, #270
    FCADD V17.4H, V13.4H, V15.4H, #270
    FRINT32Z V18.2S, V20.2S
    FCMLA V2.2S, V17.2S, V2.2S, #0
    FCADD V2.2D, V1.2D, V24.2D, #90
    FCMLA V28.4S, V30.4S, V2.S[0x1], #270
    FCMLA V9.8H, V17.8H, V13.8H, #0
    FCMLA V29.4S, V15.4S, V1.S[0x1], #180
    FCMLA V3.4H, V11.4H, V11.H[0x1], #270
    FCMLA V24.8H, V18.8H, V18.H[0x2], #270
    FCADD V19.2S, V29.2S, V1.2S, #90
    FCMLA V13.8H, V28.8H, V12.H[0x3], #270
    FCMLA V21.2S, V9.2S, V7.2S, #0
    FRINT64X V0.2S, V27.2S
    FRINT32Z V25.4S, V23.4S
    FCADD V30.2D, V27.2D, V7.2D, #90
    FRINT64Z V25.2S, V25.2S
    FRINT64X V29.2S, V6.2S
    FCMLA V0.2D, V13.2D, V15.2D, #180
    FCMLA V0.4H, V30.4H, V25.4H, #0
    FRINT64X V11.2S, V12.2S
    FRINT32Z V29.2D, V24.2D
    FCMLA V21.2S, V3.2S, V19.2S, #270
    FRINT32X V23.2D, V11.2D
    FCADD V19.8H, V21.8H, V23.8H, #270
    FCADD V0.8H, V22.8H, V11.8H, #270
    FCMLA V24.2S, V2.2S, V0.2S, #270
    FCMLA V28.4H, V28.4H, V11.4H, #270
    FRINT64Z V12.2S, V15.2S
    FRINT64Z V6.2S, V24.2S
    FCMLA V12.4S, V29.4S, V28.S[0x1], #0
    FCMLA V19.2D, V20.2D, V22.2D, #180
    FRINT64X V15.2S, V4.2S
    FCMLA V0.8H, V26.8H, V19.H[0x3], #0
    FRINT64Z V30.2D, V6.2D
    FCADD V12.2S, V0.2S, V12.2S, #90
    FCMLA V29.4S, V15.4S, V19.S[0x1], #0
    FCMLA V7.2D, V12.2D, V30.2D, #180
    FRINT64X V3.2D, V7.2D
    FCMLA V28.2S, V18.2S, V17.2S, #0
    FCMLA V7.4H, V26.4H, V3.H[0x0], #90
    FRINT32X V25.2S, V20.2S
    FRINT32X V4.2D, V14.2D
    FRINT64X V3.4S, V14.4S
    FRINT32Z V14.2D, V20.2D
    SUBS  X8, X8, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_6
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X9, FPSR
    MOVZ  X28, #0x9d, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D0
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D1
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D28
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D30
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X9, D31
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X11
    FMOV  D2, X7
    FMOV  V2.D[1], X27
    FMOV  D3, X28
    FMOV  V3.D[1], X11
    FMOV  D4, X24
    FMOV  V4.D[1], X28
    FMOV  D5, X29
    FMOV  V5.D[1], X23
    FMOV  D6, X25
    FMOV  V6.D[1], X8
    FMOV  D7, X12
    FMOV  V7.D[1], X4
    FMOV  D8, X7
    FMOV  V8.D[1], X26
    FMOV  D9, X6
    FMOV  V9.D[1], X11
    FMOV  D10, X29
    FMOV  V10.D[1], X14
    FMOV  D11, X27
    FMOV  V11.D[1], X6
    FMOV  D12, X11
    FMOV  V12.D[1], X24
    FMOV  D13, X2
    FMOV  V13.D[1], X8
    FMOV  D14, X16
    FMOV  V14.D[1], X10
    FMOV  D15, X6
    FMOV  V15.D[1], X17
    FMOV  D16, X2
    FMOV  V16.D[1], X26
    FMOV  D17, X29
    FMOV  V17.D[1], X7
    FMOV  D18, X3
    FMOV  V18.D[1], X6
    FMOV  D19, X26
    FMOV  V19.D[1], X16
    FMOV  D20, X5
    FMOV  V20.D[1], X9
    FMOV  D21, X29
    FMOV  V21.D[1], X15
    FMOV  D22, X6
    FMOV  V22.D[1], X2
    FMOV  D23, X29
    FMOV  V23.D[1], X27
    FMOV  D24, X17
    FMOV  V24.D[1], X4
    FMOV  D25, X28
    FMOV  V25.D[1], X13
    FMOV  D26, X10
    FMOV  V26.D[1], X5
    FMOV  D27, X3
    FMOV  V27.D[1], X4
    FMOV  D28, X3
    FMOV  V28.D[1], X2
    FMOV  D29, X15
    FMOV  V29.D[1], X5
    FMOV  D30, X3
    FMOV  V30.D[1], X17
    FMOV  D31, X2
    FMOV  V31.D[1], X5
    MOVZ  X9, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_7:
    FRINT64Z V6.4S, V27.4S
    FRINT32Z V23.2S, V26.2S
    FCADD V23.2S, V29.2S, V17.2S, #90
    FCMLA V11.4H, V25.4H, V6.4H, #0
    FRINT64Z V25.4S, V11.4S
    FCMLA V15.8H, V1.8H, V10.H[0x2], #180
    FCMLA V25.8H, V15.8H, V20.H[0x3], #90
    FRINT64X V7.2S, V19.2S
    FCMLA V24.4S, V23.4S, V7.S[0x1], #0
    FCADD V28.2D, V25.2D, V30.2D, #90
    FCADD V28.2S, V28.2S, V31.2S, #270
    FCMLA V21.4H, V15.4H, V27.H[0x1], #270
    FCADD V21.8H, V26.8H, V24.8H, #90
    FRINT32X V11.4S, V28.4S
    FRINT64X V27.2S, V4.2S
    FCMLA V19.4H, V27.4H, V19.4H, #90
    FCMLA V27.8H, V29.8H, V9.8H, #270
    FCMLA V25.4H, V25.4H, V4.4H, #90
    FCMLA V1.2D, V27.2D, V16.2D, #90
    FCADD V2.2S, V14.2S, V1.2S, #90
    FCMLA V15.4S, V15.4S, V11.S[0x0], #180
    FRINT64X V28.2D, V12.2D
    FRINT64X V20.4S, V8.4S
    FRINT64X V8.2S, V23.2S
    FRINT32X V9.2S, V15.2S
    FRINT32Z V16.4S, V29.4S
    FCMLA V8.4S, V19.4S, V25.S[0x1], #270
    FCMLA V21.8H, V9.8H, V9.8H, #90
    FRINT32Z V25.2D, V28.2D
    FRINT64Z V9.2S, V21.2S
    FRINT32X V28.2D, V26.2D
    FCMLA V20.4S, V14.4S, V5.S[0x0], #270
    FRINT32X V29.4S, V9.4S
    FRINT64Z V11.4S, V26.4S
    FCMLA V16.8H, V11.8H, V16.8H, #90
    FCADD V23.2D, V28.2D, V22.2D, #90
    FRINT64X V7.2D, V31.2D
    FRINT32Z V5.2S, V7.2S
    FCADD V20.2S, V19.2S, V2.2S, #270
    FCADD V28.4H, V29.4H, V8.4H, #270
    FRINT64X V27.2S, V7.2S
    FRINT32X V9.2S, V16.2S
    FCADD V3.8H, V25.8H, V29.8H, #90
    FCMLA V27.4H, V17.4H, V13.H[0x1], #270
    FRINT64X V31.2D, V20.2D
    FRINT64Z V19.4S, V5.4S
    FCADD V27.2D, V23.2D, V27.2D, #90
    FCMLA V21.8H, V8.8H, V28.H[0x0], #270
    FCADD V7.4H, V27.4H, V23.4H, #90
    FCADD V9.8H, V9.8H, V12.8H, #90
    FCMLA V3.8H, V17.8H, V19.H[0x3], #270
    FRINT64X V18.2D, V7.2D
    FCADD V3.4S, V31.4S, V1.4S, #90
    FRINT64Z V22.2S, V3.2S
    FRINT32X V30.2S, V9.2S
    FCMLA V22.2S, V1.2S, V8.2S, #270
    FRINT32X V8.2D, V20.2D
    FCMLA V18.4H, V8.4H, V21.H[0x1], #0
    FRINT64Z V17.2D, V30.2D
    FCMLA V18.4S, V17.4S, V17.S[0x1], #90
    FRINT64X V29.2D, V10.2D
    FCADD V29.4S, V25.4S, V19.4S, #270
    FCADD V16.4S, V17.4S, V2.4S, #90
    FRINT32Z V29.2D, V30.2D
    FCMLA V7.4H, V21.4H, V27.H[0x0], #0
    FCMLA V26.4S, V1.4S, V18.S[0x1], #90
    FRINT64X V21.2D, V25.2D
    FCMLA V8.4H, V6.4H, V15.H[0x0], #90
    FCMLA V31.4H, V7.4H, V27.H[0x0], #0
    FRINT32Z V20.2D, V24.2D
    FRINT32Z V25.2S, V23.2S
    FRINT64Z V6.2D, V22.2D
    FRINT64Z V19.2S, V8.2S
    FCMLA V6.2S, V0.2S, V20.2S, #180
    FCMLA V28.4H, V16.4H, V13.H[0x0], #180
    FRINT32X V18.4S, V29.4S
    FCMLA V19.4S, V18.4S, V25.4S, #0
    FRINT32Z V22.4S, V28.4S
    FCMLA V2.4H, V1.4H, V6.4H, #0
    FRINT64X V16.4S, V26.4S
    FRINT32Z V8.2D, V17.2D
    FCMLA V19.4S, V16.4S, V21.S[0x0], #270
    FCADD V0.8H, V9.8H, V22.8H, #90
    FCMLA V5.8H, V4.8H, V1.H[0x0], #180
    FCMLA V14.4H, V0.4H, V2.H[0x1], #270
    FRINT64X V29.4S, V15.4S
    FCADD V8.4H, V14.4H, V29.4H, #270
    FRINT32Z V26.4S, V2.4S
    FCMLA V8.4H, V19.4H, V19.4H, #90
    FCADD V31.8H, V21.8H, V28.8H, #270
    FCADD V8.2D, V21.2D, V13.2D, #90
    FRINT32Z V1.4S, V31.4S
    FRINT32X V2.2D, V11.2D
    FRINT32X V29.2S, V5.2S
    FRINT32Z V7.4S, V9.4S
    FRINT64X V17.2S, V0.2S
    FCADD V17.2S, V7.2S, V2.2S, #90
    FCMLA V8.4H, V1.4H, V26.H[0x0], #270
    FCMLA V17.8H, V17.8H, V17.H[0x2], #90
    FRINT32Z V1.2S, V29.2S
    FRINT32Z V21.2D, V8.2D
    FRINT64Z V0.2S, V17.2S
    FCMLA V1.4H, V1.4H, V1.H[0x1], #90
    FRINT32X V10.2S, V1.2S
    FCMLA V8.4H, V22.4H, V0.H[0x1], #270
    FRINT32X V28.4S, V10.4S
    FRINT64Z V31.2D, V28.2D
    FRINT64Z V17.4S, V8.4S
    FCADD V17.4H, V24.4H, V21.4H, #90
    FCMLA V16.4H, V17.4H, V17.4H, #270
    FCMLA V10.4S, V3.4S, V31.S[0x0], #90
    FRINT64Z V9.2S, V18.2S
    FRINT32X V17.2S, V6.2S
    FRINT32Z V8.2S, V9.2S
    FCMLA V8.8H, V28.8H, V2.8H, #270
    FCMLA V22.4H, V13.4H, V31.H[0x1], #0
    FCMLA V25.4S, V0.4S, V7.4S, #90
    FRINT32X V5.2S, V15.2S
    FCMLA V6.2S, V30.2S, V0.2S, #180
    FCADD V14.2S, V30.2S, V18.2S, #90
    FRINT32X V15.4S, V14.4S
    FRINT32Z V18.2D, V5.2D
    FCADD V15.4S, V10.4S, V6.4S, #90
    FCMLA V15.4H, V2.4H, V29.H[0x1], #90
    FCMLA V17.4H, V8.4H, V22.4H, #90
    FCADD V20.4S, V12.4S, V29.4S, #90
    FRINT32X V14.2S, V12.2S
    FRINT32Z V6.2D, V9.2D
    FCADD V14.8H, V20.8H, V20.8H, #90
    FRINT64Z V3.2D, V16.2D
    FCMLA V18.4H, V18.4H, V25.H[0x1], #270
    FCMLA V17.4H, V14.4H, V14.4H, #0
    FCMLA V6.4S, V29.4S, V19.S[0x1], #270
    FCADD V27.8H, V3.8H, V18.8H, #90
    FCMLA V11.4H, V15.4H, V16.H[0x0], #180
    FRINT32Z V10.2S, V17.2S
    FCADD V4.8H, V10.8H, V11.8H, #90
    FRINT32X V25.2S, V6.2S
    FCMLA V25.4H, V25.4H, V3.4H, #270
    FCMLA V14.4H, V12.4H, V20.H[0x0], #270
    FCMLA V27.2S, V25.2S, V25.2S, #0
    FCADD V14.4H, V1.4H, V27.4H, #90
    FCMLA V14.4H, V4.4H, V27.H[0x1], #270
    FCMLA V10.8H, V18.8H, V9.H[0x3], #270
    FRINT64Z V6.4S, V1.4S
    FRINT64X V4.2S, V14.2S
    FCMLA V2.4H, V31.4H, V8.H[0x0], #180
    FRINT32Z V31.2S, V10.2S
    FCMLA V20.4S, V13.4S, V5.4S, #270
    FRINT64Z V30.4S, V31.4S
    FCMLA V12.4S, V7.4S, V30.4S, #180
    FCADD V20.8H, V22.8H, V1.8H, #90
    FCMLA V22.8H, V24.8H, V25.H[0x0], #90
    FRINT64Z V28.2S, V2.2S
    FCMLA V22.4S, V3.4S, V5.S[0x0], #0
    FRINT64X V14.4S, V26.4S
    FRINT64Z V3.4S, V21.4S
    FRINT32X V21.2S, V4.2S
    FRINT32X V25.2D, V16.2D
    FCMLA V12.4H, V12.4H, V22.H[0x1], #270
    FCMLA V8.4H, V0.4H, V6.4H, #90
    FRINT64Z V24.4S, V12.4S
    FCADD V14.2S, V21.2S, V14.2S, #270
    FRINT32X V13.2D, V29.2D
    FRINT32Z V7.4S, V10.4S
    FRINT32X V26.2D, V11.2D
    FCMLA V1.4H, V25.4H, V13.H[0x0], #0
    FRINT32X V4.2S, V21.2S
    FRINT32Z V11.4S, V25.4S
    FRINT32X V0.2S, V26.2S
    FCMLA V7.8H, V11.8H, V11.H[0x2], #270
    FCMLA V20.4H, V7.4H, V16.4H, #0
    FRINT64Z V7.2D, V28.2D
    FCMLA V0.4H, V7.4H, V8.H[0x1], #90
    FRINT32Z V26.2S, V3.2S
    FCMLA V30.4S, V28.4S, V11.S[0x0], #180
    FCMLA V0.2S, V12.2S, V19.2S, #90
    FCMLA V30.4S, V19.4S, V1.S[0x1], #0
    FCMLA V13.4H, V10.4H, V0.H[0x1], #180
    FCMLA V5.2S, V1.2S, V4.2S, #0
    FCADD V24.4H, V14.4H, V26.4H, #90
    FCMLA V13.4S, V20.4S, V25.S[0x1], #90
    FRINT32Z V20.2S, V13.2S
    FRINT32X V1.4S, V30.4S
    FCADD V5.2D, V8.2D, V5.2D, #90
    FCMLA V7.4S, V5.4S, V20.S[0x1], #180
    FCMLA V1.8H, V1.8H, V4.H[0x1], #270
    FRINT32X V12.4S, V31.4S
    FRINT64X V3.2S, V28.2S
    FCMLA V5.2S, V1.2S, V1.2S, #270
    FRINT64Z V11.2D, V7.2D
    FCMLA V8.4S, V14.4S, V30.4S, #0
    FRINT64X V20.2S, V4.2S
    FCMLA V14.8H, V1.8H, V21.H[0x1], #0
    FCMLA V12.2D, V9.2D, V20.2D, #180
    FCMLA V5.4S, V12.4S, V0.S[0x0], #270
    FRINT64Z V30.2S, V5.2S
    FCMLA V17.4S, V8.4S, V0.4S, #90
    FCMLA V3.2D, V14.2D, V30.2D, #270
    FCMLA V17.8H, V11.8H, V29.H[0x2], #90
    SUBS  X9, X9, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_7
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X28, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X23, FPSR
    MOVZ  X28, #0x9d, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D0
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0x7f7f, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x7f7f, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D1
    MOVZ  X28, #0x6220, LSL #0
    MOVK  X28, #0xcf00, LSL #16
    MOVK  X28, #0x6220, LSL #32
    MOVK  X28, #0xcf00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D2
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D3
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D4
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xcf00, LSL #16
    MOVK  X28, #0xcf00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D5
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xff7f, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x7f7f, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D6
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #32
    MOVK  X28, #0xc3e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D7
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D8
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5f00, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x5eff, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D9
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D10
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xcf00, LSL #16
    MOVK  X28, #0xcf00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D11
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D12
    MOVZ  X28, #0x1, LSL #0
    MOVK  X28, #0xcf20, LSL #16
    MOVK  X28, #0xd0f0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D13
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D14
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xf55d, LSL #16
    MOVK  X28, #0xf55c, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D15
    MOVZ  X28, #0xabb8, LSL #0
    MOVK  X28, #0xd360, LSL #16
    MOVK  X28, #0xc9c8, LSL #32
    MOVK  X28, #0xc3e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D16
    MOVZ  X28, #0x6308, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D17
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D18
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x4850, LSL #32
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D19
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x4444, LSL #16
    MOVK  X28, #0xc28e, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D20
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xcf00, LSL #16
    MOVK  X28, #0xcf00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D21
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xcf00, LSL #16
    MOVK  X28, #0xcf00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D22
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D23
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D24
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xcf80, LSL #16
    MOVK  X28, #0x41e0, LSL #32
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D25
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D26
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D27
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x41e0, LSL #32
    MOVK  X28, #0x45b0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D28
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc1e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D29
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xc3e0, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D30
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xdf00, LSL #16
    MOVK  X28, #0xdf00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X23, D31
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xcf00, LSL #16
    MOVK  X28, #0xcf00, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  D1, X25
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X28
    FMOV  V3.D[1], X7
    FMOV  D4, X25
    FMOV  V4.D[1], X12
    FMOV  D5, X23
    FMOV  V5.D[1], X12
    FMOV  D6, X10
    FMOV  V6.D[1], X23
    FMOV  D7, X16
    FMOV  V7.D[1], X15
    FMOV  D8, X16
    FMOV  V8.D[1], X16
    FMOV  D9, X25
    FMOV  V9.D[1], X14
    FMOV  D10, X24
    FMOV  V10.D[1], X15
    FMOV  D11, X4
    FMOV  V11.D[1], X4
    FMOV  D12, X14
    FMOV  V12.D[1], X10
    FMOV  D13, X23
    FMOV  V13.D[1], X15
    FMOV  D14, X14
    FMOV  V14.D[1], X25
    FMOV  D15, X7
    FMOV  V15.D[1], X12
    FMOV  D16, X11
    FMOV  V16.D[1], X17
    FMOV  D17, X12
    FMOV  V17.D[1], X27
    FMOV  D18, X26
    FMOV  V18.D[1], X9
    FMOV  D19, X6
    FMOV  V19.D[1], X9
    FMOV  D20, X15
    FMOV  V20.D[1], X25
    FMOV  D21, X28
    FMOV  V21.D[1], X13
    FMOV  D22, X4
    FMOV  V22.D[1], X9
    FMOV  D23, X25
    FMOV  V23.D[1], X15
    FMOV  D24, X12
    FMOV  V24.D[1], X14
    FMOV  D25, X11
    FMOV  V25.D[1], X24
    FMOV  D26, X15
    FMOV  V26.D[1], X26
    FMOV  D27, X7
    FMOV  V27.D[1], X11
    FMOV  D28, X13
    FMOV  V28.D[1], X13
    FMOV  D29, X13
    FMOV  V29.D[1], X3
    FMOV  D30, X24
    FMOV  V30.D[1], X5
    FMOV  D31, X23
    FMOV  V31.D[1], X25
    MOVZ  X27, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_8:
    FCADD V13.2S, V31.2S, V30.2S, #270
    FCMLA V29.8H, V27.8H, V29.H[0x1], #270
    FCMLA V13.4H, V9.4H, V25.H[0x0], #90
    FRINT32Z V10.4S, V26.4S
    FCMLA V13.4S, V10.4S, V29.4S, #270
    FRINT32Z V12.2D, V13.2D
    FCADD V18.2D, V12.2D, V5.2D, #90
    FRINT32Z V11.4S, V24.4S
    FRINT32Z V23.4S, V11.4S
    FRINT64Z V12.4S, V23.4S
    FRINT64Z V14.4S, V1.4S
    FRINT64Z V8.2D, V3.2D
    FCMLA V18.8H, V18.8H, V12.8H, #90
    FCADD V23.4H, V26.4H, V14.4H, #90
    FCMLA V31.4H, V8.4H, V8.H[0x1], #0
    FCMLA V31.4S, V18.4S, V31.4S, #90
    FCMLA V11.4S, V13.4S, V23.S[0x1], #0
    FCMLA V11.8H, V28.8H, V27.8H, #180
    FRINT32Z V5.4S, V1.4S
    FRINT32X V1.2S, V12.2S
    FRINT32Z V1.2D, V1.2D
    FRINT64X V27.4S, V28.4S
    FCMLA V25.8H, V5.8H, V2.H[0x3], #180
    FCADD V30.4H, V25.4H, V22.4H, #90
    FCMLA V2.2D, V29.2D, V28.2D, #270
    FRINT32Z V29.2D, V8.2D
    FRINT64Z V25.2S, V14.2S
    FRINT32Z V22.2D, V0.2D
    FRINT64Z V21.2S, V2.2S
    FRINT64Z V14.2D, V25.2D
    FRINT64Z V26.4S, V22.4S
    FCADD V27.2D, V3.2D, V30.2D, #270
    FCMLA V21.4H, V21.4H, V11.H[0x0], #90
    FRINT32X V29.2S, V3.2S
    FCADD V14.2S, V29.2S, V26.2S, #90
    FCMLA V9.8H, V1.8H, V9.8H, #0
    FCMLA V29.4S, V22.4S, V14.S[0x0], #90
    FCMLA V19.4H, V21.4H, V27.H[0x1], #90
    FRINT32Z V26.2S, V9.2S
    FCMLA V19.4H, V15.4H, V26.H[0x1], #180
    FCADD V1.2D, V3.2D, V21.2D, #90
    FCMLA V29.8H, V31.8H, V12.H[0x1], #90
    FCADD V1.4S, V12.4S, V19.4S, #270
    FCMLA V31.8H, V29.8H, V4.H[0x3], #0
    FCADD V12.4H, V30.4H, V7.4H, #270
    FRINT64Z V0.4S, V4.4S
    FCADD V26.2S, V18.2S, V17.2S, #90
    FRINT64Z V19.4S, V21.4S
    FRINT32Z V5.2S, V4.2S
    FCMLA V26.4H, V31.4H, V6.H[0x1], #270
    FRINT64X V9.2D, V24.2D
    FCMLA V1.4S, V16.4S, V11.4S, #90
    FRINT32X V22.4S, V22.4S
    FCMLA V13.4H, V7.4H, V25.H[0x0], #90
    FRINT64Z V18.4S, V22.4S
    FRINT64Z V25.2S, V0.2S
    FCMLA V16.4H, V19.4H, V14.4H, #270
    FCADD V9.2D, V17.2D, V11.2D, #90
    FRINT32Z V14.4S, V18.4S
    FCMLA V12.8H, V1.8H, V12.H[0x3], #180
    FRINT64X V21.2D, V5.2D
    FCADD V13.2D, V26.2D, V25.2D, #270
    FRINT64X V26.4S, V8.4S
    FCMLA V9.4S, V11.4S, V28.S[0x1], #180
    FRINT64X V7.2D, V9.2D
    FCMLA V16.4S, V1.4S, V13.S[0x1], #90
    FCMLA V1.8H, V16.8H, V23.H[0x2], #90
    FCMLA V12.2D, V26.2D, V21.2D, #180
    FCMLA V15.8H, V9.8H, V7.H[0x1], #0
    FRINT64Z V29.2D, V15.2D
    FCMLA V12.4H, V1.4H, V4.H[0x0], #270
    FCMLA V23.2S, V12.2S, V29.2S, #90
    FCMLA V21.4H, V2.4H, V5.H[0x0], #0
    FRINT32Z V17.2S, V26.2S
    FCMLA V22.2D, V30.2D, V12.2D, #270
    FRINT64Z V0.4S, V26.4S
    FCADD V18.8H, V17.8H, V3.8H, #90
    FRINT32Z V13.4S, V17.4S
    FRINT32X V6.2S, V14.2S
    FCMLA V15.4S, V2.4S, V27.4S, #180
    FCMLA V27.4H, V3.4H, V4.H[0x1], #270
    FCMLA V6.4H, V27.4H, V0.H[0x1], #0
    FRINT32Z V0.2D, V18.2D
    FRINT32Z V27.2D, V20.2D
    FCMLA V21.4S, V22.4S, V25.S[0x0], #0
    FRINT32Z V14.4S, V16.4S
    FRINT64Z V24.4S, V27.4S
    FRINT32X V16.2S, V24.2S
    FCMLA V27.8H, V23.8H, V13.H[0x2], #90
    FRINT32X V5.4S, V5.4S
    FCMLA V0.4H, V5.4H, V26.H[0x1], #180
    FRINT64Z V12.4S, V28.4S
    FCMLA V5.4H, V14.4H, V15.4H, #270
    FRINT64Z V2.2S, V4.2S
    FCMLA V5.4S, V11.4S, V21.S[0x0], #270
    FCMLA V9.4S, V27.4S, V12.4S, #270
    FCMLA V15.4H, V18.4H, V6.H[0x1], #180
    FCMLA V15.4S, V0.4S, V0.4S, #90
    FCMLA V0.4S, V15.4S, V10.S[0x0], #90
    FRINT32X V18.4S, V30.4S
    FRINT64Z V15.2D, V6.2D
    FRINT32X V6.4S, V27.4S
    FCMLA V18.4S, V2.4S, V21.S[0x1], #90
    FRINT32Z V30.2S, V2.2S
    FCMLA V9.2S, V0.2S, V15.2S, #90
    FRINT32X V21.2S, V30.2S
    FCADD V6.8H, V16.8H, V6.8H, #270
    FCMLA V5.8H, V2.8H, V21.H[0x1], #180
    FRINT32Z V24.2S, V5.2S
    FCMLA V26.4H, V24.4H, V18.4H, #180
    FCADD V2.2D, V0.2D, V26.2D, #270
    FRINT32X V14.4S, V20.4S
    FCMLA V6.4H, V2.4H, V2.H[0x1], #180
    FRINT32X V12.4S, V14.4S
    FCMLA V22.4S, V27.4S, V18.4S, #270
    FRINT64X V2.2S, V6.2S
    FCMLA V12.8H, V2.8H, V30.8H, #180
    FCADD V12.4S, V12.4S, V12.4S, #90
    FCMLA V12.8H, V22.8H, V23.H[0x1], #90
    FCMLA V15.2S, V17.2S, V24.2S, #0
    FRINT64X V23.2S, V31.2S
    FRINT64Z V18.2D, V27.2D
    FRINT32Z V27.2D, V4.2D
    FCMLA V24.8H, V14.8H, V2.H[0x2], #180
    FRINT64Z V26.2D, V29.2D
    FCMLA V1.8H, V17.8H, V12.H[0x2], #0
    FCMLA V13.8H, V21.8H, V4.8H, #180
    FCMLA V18.4H, V31.4H, V26.H[0x0], #270
    FRINT32Z V31.2S, V15.2S
    FCMLA V9.2D, V25.2D, V24.2D, #0
    FRINT64X V22.2D, V31.2D
    FRINT64X V12.2D, V29.2D
    FRINT64X V14.4S, V17.4S
    FCMLA V15.4H, V1.4H, V13.H[0x1], #180
    FRINT32X V1.2D, V22.2D
    FCMLA V23.4H, V1.4H, V15.H[0x0], #0
    FRINT32Z V25.2D, V12.2D
    FCMLA V25.4H, V18.4H, V4.H[0x0], #270
    FRINT32Z V29.4S, V23.4S
    FRINT64X V26.2D, V9.2D
    FRINT64X V12.4S, V26.4S
    FCMLA V27.8H, V19.8H, V10.8H, #270
    FCMLA V28.4S, V25.4S, V29.4S, #180
    FCMLA V31.8H, V17.8H, V25.H[0x2], #90
    FCADD V16.2D, V12.2D, V27.2D, #90
    FCMLA V14.4S, V31.4S, V28.S[0x0], #90
    FCMLA V22.8H, V18.8H, V20.8H, #180
    FRINT32Z V12.4S, V23.4S
    FCADD V11.4S, V5.4S, V30.4S, #90
    FRINT64X V30.4S, V0.4S
    FRINT64Z V26.4S, V20.4S
    FCMLA V0.4H, V12.4H, V5.H[0x0], #270
    FRINT32X V25.4S, V7.4S
    FRINT64Z V2.2D, V6.2D
    FCMLA V30.8H, V26.8H, V29.H[0x2], #180
    FCMLA V30.4H, V0.4H, V11.H[0x0], #90
    FRINT64X V16.2D, V2.2D
    FRINT64X V31.2D, V2.2D
    FRINT64Z V10.2D, V29.2D
    FRINT64X V6.2D, V10.2D
    FCMLA V27.2D, V6.2D, V14.2D, #90
    FRINT32X V27.2D, V31.2D
    FCMLA V1.4S, V16.4S, V23.S[0x0], #90
    FCMLA V28.2S, V22.2S, V6.2S, #0
    FCMLA V7.2S, V30.2S, V6.2S, #270
    FCMLA V7.4H, V25.4H, V20.H[0x1], #0
    FCMLA V27.4S, V7.4S, V14.4S, #180
    FCMLA V13.4H, V18.4H, V16.H[0x0], #270
    FCMLA V27.4S, V28.4S, V13.S[0x1], #90
    FCMLA V22.2D, V16.2D, V16.2D, #180
    FCMLA V6.8H, V29.8H, V7.8H, #0
    FCADD V12.4H, V3.4H, V7.4H, #90
    FRINT32Z V14.2D, V28.2D
    FRINT64X V23.2S, V30.2S
    FRINT32X V26.2S, V12.2S
    FCMLA V5.8H, V8.8H, V0.H[0x1], #90
    FCMLA V27.4S, V23.4S, V22.S[0x0], #180
    FRINT32X V2.2D, V18.2D
    FCMLA V15.8H, V15.8H, V1.8H, #90
    FRINT64X V7.2S, V17.2S
    FCMLA V2.4H, V28.4H, V23.H[0x1], #270
    FCMLA V15.4H, V19.4H, V27.H[0x0], #180
    FCMLA V9.4H, V23.4H, V24.4H, #0
    FCMLA V26.4H, V20.4H, V10.4H, #0
    FCMLA V25.4S, V28.4S, V13.S[0x1], #270
    FCMLA V2.2D, V9.2D, V14.2D, #180
    FRINT64X V22.4S, V6.4S
    FCADD V7.2S, V22.2S, V25.2S, #90
    FCADD V1.2D, V5.2D, V2.2D, #90
    FCMLA V1.4S, V15.4S, V7.S[0x0], #180
    FRINT32Z V27.2S, V6.2S
    FCMLA V24.2S, V4.2S, V16.2S, #180
    FRINT64Z V20.4S, V27.4S
    FCMLA V30.4H, V14.4H, V13.4H, #90
    FRINT32Z V2.4S, V3.4S
    FRINT32X V7.2S, V3.2S
    FRINT64Z V15.2S, V8.2S
    FRINT32X V0.2S, V24.2S
    FCMLA V12.4H, V7.4H, V0.H[0x1], #270
    FCMLA V23.2D, V5.2D, V26.2D, #270
    SUBS  X27, X27, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_8
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X2, FPSR
    MOVZ  X5, #0x9d, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D0
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xcf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X5, #0x7dff, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x7e10, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D1
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7f7f, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7f7f, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xcf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D2
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xcf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D5
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D6
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D7
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xcf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D8
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D9
    MOVZ  X5, #0x4b4a, LSL #0
    MOVK  X5, #0xaf4b, LSL #16
    MOVK  X5, #0x5a5b, LSL #32
    MOVK  X5, #0xe96a, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D10
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D11
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0xfbfe, LSL #32
    MOVK  X5, #0x718a, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D12
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x63be, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D13
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D14
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc1e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D15
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D16
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D17
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D18
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D19
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xdf00, LSL #16
    MOVK  X5, #0xdf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D20
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D21
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xcf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D22
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xdf00, LSL #16
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fef, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D23
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xdf00, LSL #16
    MOVK  X5, #0xdf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D24
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xf0e, LSL #32
    MOVK  X5, #0x5ebf, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D25
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D26
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xcf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D27
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D28
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7f7f, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xff7f, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D29
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xcf00, LSL #16
    MOVK  X5, #0xcf00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D30
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X2, D31
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc3e0, LSL #48
    SUB  X13, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  V0.D[1], X8
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X12
    FMOV  D3, X17
    FMOV  V3.D[1], X29
    FMOV  D4, X12
    FMOV  V4.D[1], X6
    FMOV  D5, X5
    FMOV  V5.D[1], X3
    FMOV  D6, X26
    FMOV  V6.D[1], X28
    FMOV  D7, X27
    FMOV  V7.D[1], X15
    FMOV  D8, X8
    FMOV  V8.D[1], X8
    FMOV  D9, X25
    FMOV  V9.D[1], X17
    FMOV  D10, X29
    FMOV  V10.D[1], X3
    FMOV  D11, X13
    FMOV  V11.D[1], X15
    FMOV  D12, X11
    FMOV  V12.D[1], X26
    FMOV  D13, X26
    FMOV  V13.D[1], X24
    FMOV  D14, X29
    FMOV  V14.D[1], X28
    FMOV  D15, X9
    FMOV  V15.D[1], X26
    FMOV  D16, X5
    FMOV  V16.D[1], X2
    FMOV  D17, X15
    FMOV  V17.D[1], X15
    FMOV  D18, X25
    FMOV  V18.D[1], X15
    FMOV  D19, X9
    FMOV  V19.D[1], X13
    FMOV  D20, X10
    FMOV  V20.D[1], X4
    FMOV  D21, X13
    FMOV  V21.D[1], X6
    FMOV  D22, X5
    FMOV  V22.D[1], X26
    FMOV  D23, X8
    FMOV  V23.D[1], X25
    FMOV  D24, X12
    FMOV  V24.D[1], X6
    FMOV  D25, X24
    FMOV  V25.D[1], X26
    FMOV  D26, X16
    FMOV  V26.D[1], X9
    FMOV  D27, X29
    FMOV  V27.D[1], X8
    FMOV  D28, X11
    FMOV  V28.D[1], X16
    FMOV  D29, X14
    FMOV  V29.D[1], X23
    FMOV  D30, X24
    FMOV  V30.D[1], X28
    FMOV  D31, X16
    FMOV  V31.D[1], X29
    MOVZ  X13, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_9:
    FRINT64Z V13.4S, V7.4S
    FRINT64X V26.4S, V9.4S
    FRINT32Z V22.2D, V27.2D
    FCMLA V28.4H, V22.4H, V24.H[0x0], #270
    FCMLA V10.2S, V13.2S, V13.2S, #0
    FRINT64Z V29.4S, V23.4S
    FRINT64X V15.2S, V13.2S
    FCADD V29.4S, V29.4S, V29.4S, #270
    FRINT32Z V2.4S, V0.4S
    FCADD V1.4H, V10.4H, V0.4H, #270
    FCMLA V1.8H, V7.8H, V21.H[0x0], #90
    FCMLA V25.4S, V10.4S, V15.S[0x0], #180
    FCMLA V21.4H, V25.4H, V0.4H, #90
    FCADD V1.4S, V2.4S, V28.4S, #90
    FCMLA V29.4H, V19.4H, V26.H[0x1], #270
    FRINT32X V27.2D, V20.2D
    FCADD V21.2S, V1.2S, V29.2S, #270
    FCMLA V31.4H, V27.4H, V31.H[0x1], #0
    FCADD V3.4H, V19.4H, V17.4H, #270
    FCMLA V3.4S, V30.4S, V3.S[0x1], #180
    FCADD V15.4S, V26.4S, V6.4S, #90
    FRINT32Z V27.2D, V15.2D
    FRINT64Z V30.4S, V27.4S
    FCMLA V13.4S, V29.4S, V31.S[0x1], #180
    FCMLA V13.2S, V21.2S, V3.2S, #90
    FRINT32X V31.2S, V29.2S
    FRINT32X V6.4S, V13.4S
    FCMLA V13.4H, V19.4H, V17.4H, #180
    FRINT32Z V29.2D, V12.2D
    FCADD V30.8H, V10.8H, V7.8H, #90
    FCMLA V1.4H, V8.4H, V25.H[0x1], #90
    FRINT32X V2.2S, V10.2S
    FCADD V24.4S, V2.4S, V24.4S, #270
    FCMLA V25.4S, V9.4S, V15.4S, #270
    FCADD V22.4H, V15.4H, V2.4H, #90
    FRINT64X V2.2S, V31.2S
    FCMLA V24.4H, V22.4H, V2.H[0x1], #270
    FRINT64X V26.2D, V30.2D
    FRINT32X V17.4S, V17.4S
    FRINT64X V12.4S, V31.4S
    FRINT64X V22.2S, V17.2S
    FRINT32X V3.2D, V6.2D
    FRINT64Z V19.2S, V26.2S
    FRINT64Z V7.4S, V12.4S
    FCMLA V24.4H, V19.4H, V7.4H, #90
    FRINT32Z V7.2D, V13.2D
    FRINT32Z V19.2S, V1.2S
    FRINT32X V27.2D, V29.2D
    FRINT64X V21.2D, V27.2D
    FRINT32Z V30.2S, V25.2S
    FCMLA V7.4S, V22.4S, V29.S[0x0], #0
    FRINT32Z V17.4S, V30.4S
    FCMLA V26.4S, V30.4S, V24.4S, #90
    FCMLA V3.8H, V26.8H, V9.H[0x3], #90
    FCMLA V21.4S, V27.4S, V19.S[0x0], #270
    FRINT32Z V25.2D, V24.2D
    FCMLA V11.8H, V17.8H, V7.H[0x2], #180
    FRINT32Z V3.4S, V16.4S
    FCMLA V15.8H, V3.8H, V4.8H, #90
    FCMLA V15.4H, V24.4H, V11.H[0x0], #180
    FCMLA V25.8H, V18.8H, V25.H[0x2], #270
    FCADD V7.4S, V25.4S, V25.4S, #270
    FCADD V7.2S, V27.2S, V15.2S, #90
    FCMLA V4.2S, V7.2S, V7.2S, #270
    FRINT64Z V3.4S, V12.4S
    FCMLA V25.8H, V17.8H, V8.H[0x0], #180
    FRINT32Z V27.2D, V2.2D
    FRINT64Z V15.2D, V10.2D
    FRINT64X V17.2D, V28.2D
    FCMLA V12.4H, V14.4H, V3.H[0x0], #180
    FRINT64Z V28.4S, V20.4S
    FRINT64X V1.2D, V11.2D
    FCMLA V1.4H, V1.4H, V5.H[0x1], #90
    FRINT32X V14.2D, V15.2D
    FRINT32Z V3.4S, V23.4S
    FRINT32Z V30.2D, V3.2D
    FRINT32X V8.2D, V21.2D
    FCMLA V4.2S, V27.2S, V8.2S, #90
    FCADD V28.2D, V28.2D, V0.2D, #90
    FCMLA V25.2S, V12.2S, V4.2S, #180
    FCMLA V17.8H, V12.8H, V25.H[0x2], #0
    FCMLA V16.4H, V0.4H, V1.H[0x1], #0
    FRINT32Z V25.2D, V17.2D
    FRINT64X V7.2S, V28.2S
    FRINT32Z V28.2D, V21.2D
    FCMLA V25.2S, V7.2S, V28.2S, #90
    FCADD V25.2S, V25.2S, V25.2S, #90
    FRINT32Z V0.2D, V30.2D
    FRINT32X V23.4S, V16.4S
    FRINT32Z V8.2S, V23.2S
    FCMLA V0.4S, V28.4S, V25.4S, #90
    FCADD V0.2S, V12.2S, V0.2S, #270
    FCMLA V0.4H, V0.4H, V14.H[0x1], #270
    FRINT64X V14.2D, V16.2D
    FRINT32Z V25.2D, V31.2D
    FRINT32X V17.2S, V4.2S
    FCMLA V22.8H, V9.8H, V3.H[0x2], #270
    FRINT32Z V9.2D, V19.2D
    FCMLA V21.2S, V23.2S, V3.2S, #0
    FCMLA V28.4S, V3.4S, V3.S[0x0], #270
    FRINT32Z V27.2S, V25.2S
    FRINT32X V3.4S, V22.4S
    FCADD V14.4H, V0.4H, V18.4H, #90
    FCADD V17.4S, V25.4S, V17.4S, #90
    FCMLA V19.2S, V17.2S, V0.2S, #270
    FCADD V31.2D, V28.2D, V14.2D, #90
    FCADD V19.2D, V2.2D, V19.2D, #270
    FRINT32X V17.2S, V22.2S
    FCMLA V21.4S, V27.4S, V3.4S, #90
    FCMLA V31.4H, V4.4H, V31.4H, #270
    FCMLA V19.8H, V20.8H, V8.8H, #90
    FCMLA V21.8H, V17.8H, V19.H[0x2], #270
    FCMLA V14.4S, V31.4S, V21.4S, #90
    FCADD V17.4H, V25.4H, V13.4H, #270
    FCADD V20.4S, V0.4S, V13.4S, #270
    FRINT64Z V25.2S, V14.2S
    FCMLA V13.8H, V22.8H, V31.H[0x1], #180
    FCADD V11.2D, V19.2D, V9.2D, #270
    FCMLA V11.8H, V4.8H, V8.H[0x2], #180
    FRINT64Z V22.4S, V12.4S
    FCADD V20.8H, V11.8H, V1.8H, #270
    FRINT32Z V3.2S, V2.2S
    FCMLA V19.4H, V25.4H, V28.H[0x1], #270
    FRINT64Z V31.2S, V12.2S
    FCMLA V9.4H, V12.4H, V12.H[0x1], #90
    FCMLA V24.4S, V8.4S, V10.S[0x1], #90
    FCMLA V19.8H, V31.8H, V13.H[0x2], #0
    FCMLA V22.4S, V22.4S, V26.S[0x1], #0
    FRINT32X V1.2D, V2.2D
    FCMLA V12.4H, V22.4H, V3.H[0x0], #270
    FCMLA V20.4S, V17.4S, V29.S[0x1], #180
    FCADD V20.4H, V8.4H, V6.4H, #90
    FRINT64Z V22.4S, V11.4S
    FRINT64Z V31.2D, V24.2D
    FCADD V31.2S, V19.2S, V22.2S, #270
    FRINT64Z V28.4S, V21.4S
    FCMLA V12.2S, V9.2S, V4.2S, #90
    FCMLA V31.4H, V20.4H, V23.H[0x0], #180
    FRINT32Z V11.2S, V14.2S
    FRINT32Z V17.4S, V1.4S
    FRINT64X V3.4S, V12.4S
    FRINT64Z V25.2D, V17.2D
    FCMLA V25.4H, V28.4H, V14.4H, #270
    FRINT64X V20.2S, V2.2S
    FRINT64Z V18.2S, V31.2S
    FRINT32X V26.2S, V20.2S
    FCADD V26.4S, V26.4S, V18.4S, #270
    FCADD V20.4H, V18.4H, V20.4H, #90
    FCMLA V30.8H, V3.8H, V14.8H, #0
    FCMLA V5.4S, V11.4S, V11.S[0x0], #270
    FCMLA V26.4H, V5.4H, V30.H[0x1], #0
    FRINT64X V28.2S, V26.2S
    FRINT32X V11.2D, V25.2D
    FCMLA V3.4S, V10.4S, V8.S[0x1], #180
    FRINT32Z V10.2S, V15.2S
    FCMLA V1.4S, V28.4S, V18.S[0x1], #180
    FCMLA V18.8H, V3.8H, V1.H[0x1], #270
    FCADD V11.4S, V11.4S, V18.4S, #90
    FRINT64Z V25.2S, V15.2S
    FRINT64X V22.4S, V20.4S
    FCADD V10.8H, V17.8H, V22.8H, #270
    FCADD V29.8H, V23.8H, V25.8H, #270
    FRINT64X V20.2S, V11.2S
    FCADD V22.4H, V23.4H, V18.4H, #90
    FCADD V20.4S, V13.4S, V1.4S, #90
    FCADD V10.4H, V22.4H, V10.4H, #90
    FCMLA V7.2D, V29.2D, V20.2D, #90
    FRINT64X V25.4S, V16.4S
    FCMLA V4.8H, V0.8H, V15.H[0x1], #180
    FCMLA V13.8H, V0.8H, V17.H[0x3], #270
    FCMLA V27.4S, V3.4S, V30.S[0x1], #180
    FCMLA V1.4H, V14.4H, V22.4H, #180
    FRINT64X V17.2S, V22.2S
    FCMLA V25.4H, V9.4H, V9.H[0x1], #0
    FRINT32X V15.2D, V24.2D
    FCMLA V15.4S, V13.4S, V10.4S, #270
    FRINT64Z V22.2S, V4.2S
    FRINT64Z V0.4S, V7.4S
    FCMLA V19.4H, V28.4H, V1.H[0x0], #180
    FRINT64Z V16.2S, V19.2S
    FRINT32X V29.4S, V28.4S
    FCMLA V6.4S, V3.4S, V17.S[0x1], #90
    FCMLA V15.4H, V0.4H, V16.4H, #0
    FRINT32Z V11.2S, V29.2S
    FCADD V11.4H, V6.4H, V27.4H, #270
    FRINT32X V30.2S, V23.2S
    FCMLA V7.4H, V22.4H, V25.4H, #90
    FRINT32X V24.2D, V1.2D
    FCMLA V7.2D, V30.2D, V11.2D, #180
    FRINT32Z V0.4S, V15.4S
    FCMLA V18.4S, V27.4S, V7.S[0x0], #270
    FRINT64Z V19.4S, V24.4S
    FRINT64X V29.2D, V19.2D
    FRINT32X V6.2D, V23.2D
    FCMLA V18.8H, V27.8H, V29.H[0x0], #180
    FCMLA V18.4H, V18.4H, V11.4H, #180
    FCADD V7.4H, V6.4H, V27.4H, #270
    FRINT64X V30.2D, V0.2D
    FCMLA V5.4S, V18.4S, V17.S[0x1], #0
    FRINT64X V18.2S, V26.2S
    SUBS  X13, X13, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X26, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X25, FPSR
    MOVZ  X26, #0x9d, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D0
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D1
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D4
    MOVZ  X26, #0xa5a4, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D5
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D14
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D22
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #16
    MOVK  X26, #0x8000, LSL #48
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D26
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D30
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X25, D31
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0xeb7, LSL #0
    MOVK  X2, #0x7123, LSL #16
    MOVK  X2, #0xb3d, LSL #32
    MOVK  X2, #0x96b6, LSL #48
    MOVZ  X3, #0x5d1, LSL #0
    MOVK  X3, #0x8d3a, LSL #16
    MOVK  X3, #0xc4ae, LSL #32
    MOVK  X3, #0x23c1, LSL #48
    MOVZ  X4, #0x4147, LSL #0
    MOVK  X4, #0x56ce, LSL #16
    MOVK  X4, #0xa29b, LSL #32
    MOVK  X4, #0x61eb, LSL #48
    MOVZ  X5, #0xd2fb, LSL #0
    MOVK  X5, #0xca50, LSL #16
    MOVK  X5, #0xbb5e, LSL #32
    MOVK  X5, #0xd0ad, LSL #48
    MOVZ  X6, #0x5d28, LSL #0
    MOVK  X6, #0x3b99, LSL #16
    MOVK  X6, #0xa01c, LSL #32
    MOVK  X6, #0x3dc3, LSL #48
    MOVZ  X7, #0x2fa1, LSL #0
    MOVK  X7, #0xeeac, LSL #16
    MOVK  X7, #0xd86c, LSL #32
    MOVK  X7, #0x403a, LSL #48
    MOVZ  X8, #0x54d8, LSL #0
    MOVK  X8, #0xb595, LSL #16
    MOVK  X8, #0x61a8, LSL #32
    MOVK  X8, #0xd712, LSL #48
    MOVZ  X9, #0x399f, LSL #0
    MOVK  X9, #0x2dc5, LSL #16
    MOVK  X9, #0xd126, LSL #32
    MOVK  X9, #0x8ee4, LSL #48
    MOVZ  X10, #0x600d, LSL #0
    MOVK  X10, #0xe4f, LSL #16
    MOVK  X10, #0x62d8, LSL #32
    MOVK  X10, #0xd8d6, LSL #48
    MOVZ  X11, #0xa8ed, LSL #0
    MOVK  X11, #0xd040, LSL #16
    MOVK  X11, #0xf66b, LSL #32
    MOVK  X11, #0xdf79, LSL #48
    MOVZ  X12, #0xcf29, LSL #0
    MOVK  X12, #0x4f22, LSL #16
    MOVK  X12, #0x9949, LSL #32
    MOVK  X12, #0x8245, LSL #48
    MOVZ  X13, #0x9eb9, LSL #0
    MOVK  X13, #0xbfe, LSL #16
    MOVK  X13, #0x74f5, LSL #32
    MOVK  X13, #0x8e2b, LSL #48
    MOVZ  X14, #0x1d6c, LSL #0
    MOVK  X14, #0xc2af, LSL #16
    MOVK  X14, #0xbd27, LSL #32
    MOVK  X14, #0x2400, LSL #48
    MOVZ  X15, #0x12e, LSL #0
    MOVK  X15, #0x17db, LSL #16
    MOVK  X15, #0xa3b, LSL #32
    MOVK  X15, #0x367d, LSL #48
    MOVZ  X16, #0x6afd, LSL #0
    MOVK  X16, #0xdb5c, LSL #16
    MOVK  X16, #0x3a61, LSL #32
    MOVK  X16, #0x3d40, LSL #48
    MOVZ  X17, #0x868c, LSL #0
    MOVK  X17, #0xd255, LSL #16
    MOVK  X17, #0x5061, LSL #32
    MOVK  X17, #0x37eb, LSL #48
    MOVZ  X23, #0x7b5e, LSL #0
    MOVK  X23, #0xead7, LSL #16
    MOVK  X23, #0xce0c, LSL #32
    MOVK  X23, #0x4f6c, LSL #48
    MOVZ  X24, #0xb335, LSL #0
    MOVK  X24, #0x2e19, LSL #16
    MOVK  X24, #0x9d14, LSL #32
    MOVK  X24, #0x42a1, LSL #48
    MOVZ  X25, #0x223, LSL #0
    MOVK  X25, #0x66fd, LSL #16
    MOVK  X25, #0xc8e, LSL #32
    MOVK  X25, #0xf2cb, LSL #48
    MOVZ  X26, #0x493c, LSL #0
    MOVK  X26, #0x9567, LSL #16
    MOVK  X26, #0xa1ce, LSL #32
    MOVK  X26, #0xd54d, LSL #48
    MOVZ  X27, #0x859a, LSL #0
    MOVK  X27, #0xdcc3, LSL #16
    MOVK  X27, #0x49e, LSL #32
    MOVK  X27, #0x4ed8, LSL #48
    MOVZ  X28, #0x130c, LSL #0
    MOVK  X28, #0x91d0, LSL #16
    MOVK  X28, #0x718f, LSL #32
    MOVK  X28, #0xb93d, LSL #48
    MOVZ  X29, #0x53a0, LSL #0
    MOVK  X29, #0x1bf8, LSL #16
    MOVK  X29, #0xfd80, LSL #32
    MOVK  X29, #0xadb4, LSL #48
    FMOV  D0, X5
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X26
    FMOV  D4, X6
    FMOV  V4.D[1], X11
    FMOV  D5, X14
    FMOV  V5.D[1], X16
    FMOV  D6, X7
    FMOV  V6.D[1], X28
    FMOV  D7, X23
    FMOV  V7.D[1], X5
    FMOV  D8, X14
    FMOV  V8.D[1], X27
    FMOV  D9, X13
    FMOV  V9.D[1], X11
    FMOV  D10, X8
    FMOV  V10.D[1], X2
    FMOV  D11, X29
    FMOV  V11.D[1], X13
    FMOV  D12, X6
    FMOV  V12.D[1], X23
    FMOV  D13, X5
    FMOV  V13.D[1], X6
    FMOV  D14, X7
    FMOV  V14.D[1], X12
    FMOV  D15, X3
    FMOV  V15.D[1], X11
    FMOV  D16, X7
    FMOV  V16.D[1], X13
    FMOV  D17, X25
    FMOV  V17.D[1], X5
    FMOV  D18, X3
    FMOV  V18.D[1], X7
    FMOV  D19, X6
    FMOV  V19.D[1], X4
    FMOV  D20, X7
    FMOV  V20.D[1], X10
    FMOV  D21, X2
    FMOV  V21.D[1], X7
    FMOV  D22, X29
    FMOV  V22.D[1], X6
    FMOV  D23, X24
    FMOV  V23.D[1], X6
    FMOV  D24, X16
    FMOV  V24.D[1], X24
    FMOV  D25, X28
    FMOV  V25.D[1], X11
    FMOV  D26, X15
    FMOV  V26.D[1], X2
    FMOV  D27, X14
    FMOV  V27.D[1], X13
    FMOV  D28, X5
    FMOV  V28.D[1], X13
    FMOV  D29, X13
    FMOV  V29.D[1], X14
    FMOV  D30, X2
    FMOV  V30.D[1], X25
    FMOV  D31, X29
    FMOV  V31.D[1], X3
    MOVZ  X28, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_10:
    FRINT32Z V30.4S, V3.4S
    FRINT32Z V13.2D, V22.2D
    FCMLA V14.4H, V27.4H, V24.4H, #180
    FRINT32X V28.4S, V31.4S
    FRINT32Z V4.2S, V28.2S
    FCMLA V21.8H, V2.8H, V18.8H, #90
    FRINT64Z V5.2S, V20.2S
    FCMLA V23.4H, V21.4H, V5.4H, #180
    FRINT64X V7.4S, V13.4S
    FRINT32X V12.4S, V30.4S
    FCADD V4.4H, V14.4H, V29.4H, #270
    FRINT32X V31.2D, V10.2D
    FCMLA V7.2D, V5.2D, V23.2D, #270
    FCMLA V7.4H, V12.4H, V25.H[0x1], #180
    FCMLA V4.8H, V20.8H, V7.H[0x2], #90
    FRINT32X V22.2D, V21.2D
    FRINT64X V7.4S, V17.4S
    FCMLA V31.8H, V31.8H, V26.H[0x1], #0
    FCADD V22.2S, V4.2S, V22.2S, #270
    FCMLA V7.4S, V20.4S, V7.4S, #180
    FCMLA V7.4S, V0.4S, V7.S[0x1], #0
    FRINT32Z V12.2D, V11.2D
    FRINT64Z V20.4S, V12.4S
    FRINT32X V25.2S, V22.2S
    FCADD V20.2D, V20.2D, V8.2D, #270
    FRINT32Z V14.2D, V31.2D
    FRINT64Z V13.2S, V28.2S
    FCMLA V14.4S, V14.4S, V0.S[0x0], #180
    FCADD V13.2S, V25.2S, V10.2S, #90
    FRINT32Z V11.2D, V20.2D
    FRINT32Z V21.4S, V29.4S
    FRINT64Z V24.2D, V11.2D
    FRINT64Z V31.4S, V11.4S
    FCMLA V3.2S, V7.2S, V21.2S, #180
    FRINT32X V23.2S, V14.2S
    FCMLA V31.4S, V23.4S, V31.S[0x1], #180
    FCMLA V24.4H, V13.4H, V13.4H, #180
    FRINT64X V28.2D, V31.2D
    FRINT64Z V13.2D, V4.2D
    FRINT32Z V20.2S, V3.2S
    FCMLA V20.4H, V28.4H, V24.4H, #0
    FCADD V15.2D, V17.2D, V19.2D, #270
    FRINT32Z V23.4S, V18.4S
    FRINT64X V11.2D, V5.2D
    FCMLA V2.8H, V20.8H, V25.8H, #0
    FRINT64Z V3.4S, V0.4S
    FCADD V10.2D, V13.2D, V19.2D, #270
    FRINT32X V29.2S, V4.2S
    FCMLA V28.4H, V16.4H, V0.4H, #270
    FRINT32X V0.2D, V18.2D
    FCMLA V0.2S, V24.2S, V23.2S, #180
    FRINT64Z V24.2D, V3.2D
    FRINT32X V7.2D, V25.2D
    FRINT64Z V16.2S, V28.2S
    FRINT64X V12.4S, V7.4S
    FCMLA V0.4H, V0.4H, V29.H[0x1], #90
    FRINT64Z V20.4S, V2.4S
    FRINT32X V31.2D, V22.2D
    FRINT64Z V28.2S, V31.2S
    FCADD V28.4S, V18.4S, V22.4S, #90
    FRINT32X V7.2S, V15.2S
    FCMLA V12.4H, V11.4H, V24.H[0x1], #90
    FCMLA V12.8H, V10.8H, V10.H[0x1], #180
    FRINT64X V5.2D, V28.2D
    FCMLA V7.8H, V3.8H, V20.8H, #90
    FCADD V23.2D, V10.2D, V12.2D, #90
    FCADD V16.4H, V2.4H, V16.4H, #270
    FCADD V21.4S, V8.4S, V0.4S, #90
    FCMLA V15.4S, V19.4S, V21.4S, #0
    FCMLA V5.8H, V15.8H, V23.H[0x3], #90
    FRINT64X V28.4S, V19.4S
    FRINT32X V24.2D, V16.2D
    FRINT64X V15.2D, V15.2D
    FRINT64X V30.2S, V8.2S
    FRINT64X V10.2S, V15.2S
    FRINT32Z V19.2D, V30.2D
    FRINT64X V15.2S, V14.2S
    FRINT32Z V11.4S, V2.4S
    FRINT32Z V6.2S, V31.2S
    FCMLA V7.8H, V19.8H, V7.H[0x2], #270
    FCMLA V24.4S, V5.4S, V28.4S, #0
    FCADD V10.2D, V7.2D, V20.2D, #270
    FCMLA V6.4H, V23.4H, V18.H[0x0], #0
    FCMLA V14.4H, V18.4H, V15.H[0x0], #180
    FCMLA V13.8H, V10.8H, V14.H[0x0], #90
    FRINT64X V21.2D, V11.2D
    FCMLA V29.8H, V24.8H, V19.8H, #180
    FCMLA V20.4S, V15.4S, V13.S[0x1], #180
    FCMLA V29.2S, V20.2S, V21.2S, #270
    FRINT64Z V11.2D, V14.2D
    FRINT64X V31.2S, V6.2S
    FRINT32Z V20.2S, V16.2S
    FCMLA V23.4S, V17.4S, V21.S[0x1], #90
    FRINT64Z V19.4S, V28.4S
    FCMLA V10.8H, V23.8H, V7.8H, #180
    FRINT64X V15.2S, V4.2S
    FCMLA V27.8H, V30.8H, V8.H[0x3], #0
    FCMLA V29.2D, V10.2D, V9.2D, #180
    FRINT32X V18.2S, V25.2S
    FRINT32X V5.4S, V21.4S
    FCMLA V11.4S, V26.4S, V27.4S, #270
    FCMLA V19.8H, V19.8H, V15.H[0x1], #270
    FCADD V18.4H, V14.4H, V24.4H, #90
    FRINT32Z V4.4S, V19.4S
    FRINT32Z V23.2D, V20.2D
    FCMLA V20.4H, V4.4H, V10.H[0x0], #180
    FCMLA V25.4S, V29.4S, V21.4S, #0
    FCMLA V31.8H, V30.8H, V20.H[0x2], #90
    FCMLA V21.4H, V25.4H, V18.4H, #180
    FCMLA V23.8H, V4.8H, V21.8H, #90
    FCMLA V21.4H, V19.4H, V27.H[0x0], #0
    FRINT32X V18.2D, V21.2D
    FCMLA V23.4S, V23.4S, V5.4S, #180
    FCMLA V23.4H, V31.4H, V11.4H, #0
    FRINT32X V11.2D, V15.2D
    FRINT32Z V29.2S, V11.2S
    FRINT32X V26.2S, V14.2S
    FCADD V6.2S, V13.2S, V9.2S, #270
    FRINT32X V11.2D, V21.2D
    FRINT64Z V21.4S, V19.4S
    FCADD V20.2S, V12.2S, V15.2S, #270
    FRINT64X V4.2D, V1.2D
    FRINT32Z V10.2S, V26.2S
    FCMLA V21.4H, V18.4H, V28.H[0x1], #180
    FCMLA V14.4H, V25.4H, V11.H[0x1], #0
    FRINT64X V25.2S, V6.2S
    FCMLA V23.4S, V28.4S, V14.S[0x1], #0
    FCADD V15.4H, V3.4H, V4.4H, #270
    FRINT32X V18.2S, V10.2S
    FCMLA V18.4H, V27.4H, V9.H[0x0], #0
    FCMLA V20.4H, V15.4H, V20.H[0x1], #0
    FRINT64Z V5.2D, V20.2D
    FCMLA V9.8H, V22.8H, V5.H[0x3], #0
    FRINT64Z V6.2S, V19.2S
    FCMLA V25.4H, V8.4H, V18.4H, #270
    FRINT64Z V4.4S, V6.4S
    FRINT64X V6.2D, V18.2D
    FCMLA V9.2S, V4.2S, V2.2S, #270
    FRINT32Z V26.2S, V21.2S
    FRINT64X V21.4S, V9.4S
    FCMLA V26.4S, V4.4S, V21.S[0x1], #180
    FCMLA V28.8H, V23.8H, V25.8H, #180
    FRINT64X V18.2S, V29.2S
    FCMLA V28.2S, V7.2S, V6.2S, #180
    FRINT64X V25.2S, V21.2S
    FCMLA V25.8H, V28.8H, V28.8H, #90
    FCMLA V26.4H, V25.4H, V26.4H, #0
    FRINT32X V19.2D, V13.2D
    FCMLA V5.4H, V22.4H, V15.H[0x1], #270
    FCMLA V7.8H, V25.8H, V7.H[0x0], #90
    FCADD V4.2S, V1.2S, V8.2S, #270
    FRINT32X V3.2D, V7.2D
    FCADD V27.4H, V10.4H, V15.4H, #90
    FCMLA V25.8H, V21.8H, V3.8H, #0
    FCMLA V24.4H, V25.4H, V11.H[0x1], #270
    FCMLA V1.8H, V15.8H, V25.8H, #270
    FCADD V4.2S, V0.2S, V4.2S, #90
    FCMLA V6.4H, V17.4H, V12.4H, #270
    FRINT64Z V28.2S, V27.2S
    FCMLA V19.4S, V14.4S, V13.S[0x1], #180
    FRINT32X V29.2D, V28.2D
    FRINT32Z V15.2S, V26.2S
    FRINT32X V6.2S, V14.2S
    FCMLA V19.8H, V29.8H, V27.H[0x0], #270
    FRINT32Z V21.2S, V6.2S
    FCMLA V15.2S, V12.2S, V2.2S, #90
    FCMLA V4.4S, V24.4S, V3.S[0x1], #270
    FRINT32X V9.2D, V11.2D
    FRINT32X V17.2D, V9.2D
    FRINT64Z V23.2D, V15.2D
    FRINT64X V8.4S, V17.4S
    FCADD V1.2S, V14.2S, V23.2S, #90
    FRINT64X V24.2D, V7.2D
    FCADD V0.2S, V24.2S, V30.2S, #90
    FRINT32X V14.4S, V21.4S
    FCADD V8.2S, V9.2S, V1.2S, #90
    FRINT64Z V1.2D, V19.2D
    FCMLA V5.4H, V0.4H, V4.H[0x0], #180
    FRINT64Z V7.4S, V8.4S
    FCMLA V0.4H, V5.4H, V5.H[0x1], #0
    FRINT32Z V4.2D, V0.2D
    FRINT64X V30.2S, V6.2S
    FRINT64X V21.4S, V1.4S
    FCMLA V25.8H, V14.8H, V21.H[0x1], #180
    FCADD V16.2S, V4.2S, V25.2S, #90
    FRINT64Z V25.4S, V0.4S
    FRINT32Z V0.4S, V17.4S
    FRINT64Z V21.2S, V30.2S
    FCMLA V8.4H, V21.4H, V25.H[0x1], #180
    FCADD V16.2S, V16.2S, V8.2S, #270
    FRINT64Z V23.2S, V7.2S
    FCMLA V0.4S, V0.4S, V5.S[0x0], #180
    FCADD V0.2S, V23.2S, V0.2S, #90
    FRINT32X V7.2D, V16.2D
    FRINT32Z V31.2D, V28.2D
    FRINT32Z V17.4S, V10.4S
    FRINT32Z V5.4S, V19.4S
    FRINT32Z V10.4S, V11.4S
    FCADD V10.2D, V13.2D, V25.2D, #270
    FRINT32X V24.2S, V4.2S
    SUBS  X28, X28, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_10
    MOVZ  X15, #0xeb7, LSL #0
    MOVK  X15, #0x7123, LSL #16
    MOVK  X15, #0xb3d, LSL #32
    MOVK  X15, #0x96b6, LSL #48
    SUB  X9, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x4147, LSL #0
    MOVK  X15, #0x56ce, LSL #16
    MOVK  X15, #0xa29b, LSL #32
    MOVK  X15, #0x61eb, LSL #48
    SUB  X9, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0xd2fb, LSL #0
    MOVK  X15, #0xca50, LSL #16
    MOVK  X15, #0xbb5e, LSL #32
    MOVK  X15, #0xd0ad, LSL #48
    SUB  X9, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x5d28, LSL #0
    MOVK  X15, #0x3b99, LSL #16
    MOVK  X15, #0xa01c, LSL #32
    MOVK  X15, #0x3dc3, LSL #48
    SUB  X9, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x2fa1, LSL #0
    MOVK  X15, #0xeeac, LSL #16
    MOVK  X15, #0xd86c, LSL #32
    MOVK  X15, #0x403a, LSL #48
    SUB  X9, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x54d8, LSL #0
    MOVK  X15, #0xb595, LSL #16
    MOVK  X15, #0x61a8, LSL #32
    MOVK  X15, #0xd712, LSL #48
    SUB  X9, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x600d, LSL #0
    MOVK  X15, #0xe4f, LSL #16
    MOVK  X15, #0x62d8, LSL #32
    MOVK  X15, #0xd8d6, LSL #48
    SUB  X9, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0xa8ed, LSL #0
    MOVK  X15, #0xd040, LSL #16
    MOVK  X15, #0xf66b, LSL #32
    MOVK  X15, #0xdf79, LSL #48
    SUB  X9, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0xcf29, LSL #0
    MOVK  X15, #0x4f22, LSL #16
    MOVK  X15, #0x9949, LSL #32
    MOVK  X15, #0x8245, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x9eb9, LSL #0
    MOVK  X15, #0xbfe, LSL #16
    MOVK  X15, #0x74f5, LSL #32
    MOVK  X15, #0x8e2b, LSL #48
    SUB  X9, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x1d6c, LSL #0
    MOVK  X15, #0xc2af, LSL #16
    MOVK  X15, #0xbd27, LSL #32
    MOVK  X15, #0x2400, LSL #48
    SUB  X9, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x6afd, LSL #0
    MOVK  X15, #0xdb5c, LSL #16
    MOVK  X15, #0x3a61, LSL #32
    MOVK  X15, #0x3d40, LSL #48
    SUB  X9, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x868c, LSL #0
    MOVK  X15, #0xd255, LSL #16
    MOVK  X15, #0x5061, LSL #32
    MOVK  X15, #0x37eb, LSL #48
    SUB  X9, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x7b5e, LSL #0
    MOVK  X15, #0xead7, LSL #16
    MOVK  X15, #0xce0c, LSL #32
    MOVK  X15, #0x4f6c, LSL #48
    SUB  X9, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0xb335, LSL #0
    MOVK  X15, #0x2e19, LSL #16
    MOVK  X15, #0x9d14, LSL #32
    MOVK  X15, #0x42a1, LSL #48
    SUB  X9, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x223, LSL #0
    MOVK  X15, #0x66fd, LSL #16
    MOVK  X15, #0xc8e, LSL #32
    MOVK  X15, #0xf2cb, LSL #48
    SUB  X9, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x493c, LSL #0
    MOVK  X15, #0x9567, LSL #16
    MOVK  X15, #0xa1ce, LSL #32
    MOVK  X15, #0xd54d, LSL #48
    SUB  X9, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x859a, LSL #0
    MOVK  X15, #0xdcc3, LSL #16
    MOVK  X15, #0x49e, LSL #32
    MOVK  X15, #0x4ed8, LSL #48
    SUB  X9, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X15, #0x53a0, LSL #0
    MOVK  X15, #0x1bf8, LSL #16
    MOVK  X15, #0xfd80, LSL #32
    MOVK  X15, #0xadb4, LSL #48
    SUB  X9, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X15, FPSR
    MOVZ  X9, #0x9d, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D0
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xdeff, LSL #16
    MOVK  X9, #0x43d2, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D1
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc3e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X9, #0x130c, LSL #0
    MOVK  X9, #0x91d0, LSL #16
    MOVK  X9, #0x718f, LSL #32
    MOVK  X9, #0xb93d, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D2
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7e00, LSL #16
    MOVK  X9, #0xa1ce, LSL #32
    MOVK  X9, #0xd54d, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D3
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D4
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D5
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xcf00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D6
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xcf00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D7
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D8
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x75c8, LSL #16
    MOVK  X9, #0x43d2, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D9
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xdf00, LSL #16
    MOVK  X9, #0x5f00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D10
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc3e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D11
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D12
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x4bb2, LSL #32
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D13
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc3e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D14
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xcf00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D15
    MOVZ  X9, #0x2aa1, LSL #0
    MOVK  X9, #0xd7b4, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xff7f, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D16
    MOVZ  X9, #0x7dff, LSL #0
    MOVK  X9, #0xfe00, LSL #16
    MOVK  X9, #0x7d9b, LSL #32
    MOVK  X9, #0x7e00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D17
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D18
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7e00, LSL #32
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D19
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x6520, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D20
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7e00, LSL #16
    MOVK  X9, #0xd1a6, LSL #32
    MOVK  X9, #0x4850, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D21
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xcf00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D22
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #16
    MOVK  X9, #0xc1e0, LSL #32
    MOVK  X9, #0xd0ef, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D23
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xdf00, LSL #16
    MOVK  X9, #0x43d2, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D24
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D25
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xdf00, LSL #16
    MOVK  X9, #0xdf00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D26
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7e00, LSL #16
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x7e00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D27
    MOVZ  X9, #0x5eff, LSL #0
    MOVK  X9, #0x7e00, LSL #16
    MOVK  X9, #0xc3d2, LSL #32
    MOVK  X9, #0xc6e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D28
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xdf00, LSL #16
    MOVK  X9, #0xc200, LSL #32
    MOVK  X9, #0xc6e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D29
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D30
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xcf00, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X15, D31
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc1e0, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X27
    FMOV  V0.D[1], X13
    FMOV  D1, X17
    FMOV  V1.D[1], X12
    FMOV  D2, X23
    FMOV  V2.D[1], X24
    FMOV  D3, X29
    FMOV  V3.D[1], X14
    FMOV  D4, X15
    FMOV  V4.D[1], X25
    FMOV  D5, X16
    FMOV  V5.D[1], X25
    FMOV  D6, X26
    FMOV  V6.D[1], X28
    FMOV  D7, X16
    FMOV  V7.D[1], X26
    FMOV  D8, X16
    FMOV  V8.D[1], X13
    FMOV  D9, X13
    FMOV  V9.D[1], X24
    FMOV  D10, X14
    FMOV  V10.D[1], X6
    FMOV  D11, X12
    FMOV  V11.D[1], X29
    FMOV  D12, X3
    FMOV  V12.D[1], X25
    FMOV  D13, X16
    FMOV  V13.D[1], X15
    FMOV  D14, X15
    FMOV  V14.D[1], X28
    FMOV  D15, X26
    FMOV  V15.D[1], X4
    FMOV  D16, X28
    FMOV  V16.D[1], X23
    FMOV  D17, X10
    FMOV  V17.D[1], X23
    FMOV  D18, X4
    FMOV  V18.D[1], X8
    FMOV  D19, X11
    FMOV  V19.D[1], X26
    FMOV  D20, X6
    FMOV  V20.D[1], X5
    FMOV  D21, X25
    FMOV  V21.D[1], X28
    FMOV  D22, X9
    FMOV  V22.D[1], X15
    FMOV  D23, X7
    FMOV  V23.D[1], X5
    FMOV  D24, X13
    FMOV  V24.D[1], X16
    FMOV  D25, X9
    FMOV  V25.D[1], X28
    FMOV  D26, X17
    FMOV  V26.D[1], X3
    FMOV  D27, X27
    FMOV  V27.D[1], X3
    FMOV  D28, X26
    FMOV  V28.D[1], X9
    FMOV  D29, X6
    FMOV  V29.D[1], X16
    FMOV  D30, X12
    FMOV  V30.D[1], X15
    FMOV  D31, X17
    FMOV  V31.D[1], X16
    MOVZ  X2, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_11:
    FCMLA V2.8H, V24.8H, V13.H[0x1], #0
    FRINT32X V12.2D, V26.2D
    FCMLA V30.4H, V23.4H, V2.4H, #180
    FCMLA V6.2S, V4.2S, V25.2S, #270
    FRINT32X V21.4S, V29.4S
    FRINT32X V31.4S, V30.4S
    FRINT64Z V16.2D, V6.2D
    FRINT64Z V7.4S, V16.4S
    FRINT64X V30.2D, V12.2D
    FCADD V9.2S, V22.2S, V7.2S, #90
    FRINT64X V25.2S, V28.2S
    FRINT32X V0.2D, V9.2D
    FCMLA V30.8H, V27.8H, V31.H[0x0], #180
    FCMLA V25.4H, V30.4H, V27.H[0x1], #270
    FRINT32X V30.2S, V14.2S
    FCADD V21.8H, V6.8H, V21.8H, #90
    FCMLA V27.2S, V28.2S, V25.2S, #270
    FCMLA V21.8H, V10.8H, V30.8H, #180
    FCMLA V0.8H, V0.8H, V27.H[0x2], #180
    FRINT32Z V23.2D, V20.2D
    FCMLA V14.4H, V27.4H, V11.4H, #0
    FCMLA V31.4H, V24.4H, V13.4H, #270
    FRINT64X V25.2S, V14.2S
    FCMLA V3.4S, V8.4S, V9.S[0x1], #180
    FRINT64X V24.2S, V14.2S
    FCADD V3.4H, V20.4H, V29.4H, #270
    FCMLA V26.2S, V31.2S, V7.2S, #90
    FRINT32Z V30.2D, V12.2D
    FRINT64Z V22.4S, V19.4S
    FCMLA V0.2S, V30.2S, V21.2S, #0
    FRINT64X V4.2S, V0.2S
    FRINT32Z V0.2D, V11.2D
    FCMLA V25.8H, V26.8H, V0.8H, #90
    FCADD V30.2S, V24.2S, V25.2S, #90
    FRINT32Z V6.2S, V23.2S
    FCMLA V8.4H, V30.4H, V6.H[0x0], #180
    FCMLA V3.4S, V8.4S, V4.4S, #90
    FCMLA V13.4H, V12.4H, V28.4H, #270
    FCADD V26.4S, V2.4S, V1.4S, #90
    FCMLA V13.2S, V18.2S, V1.2S, #270
    FRINT64X V27.4S, V4.4S
    FRINT64Z V7.4S, V1.4S
    FCADD V18.2S, V22.2S, V17.2S, #90
    FRINT64X V23.2D, V1.2D
    FCMLA V25.2S, V21.2S, V24.2S, #270
    FRINT64X V28.4S, V30.4S
    FCMLA V29.2D, V23.2D, V26.2D, #270
    FRINT32X V23.2D, V7.2D
    FCADD V18.2D, V28.2D, V28.2D, #90
    FCADD V3.8H, V23.8H, V23.8H, #90
    FCMLA V22.4S, V4.4S, V18.S[0x1], #90
    FRINT32X V23.2S, V4.2S
    FRINT64X V30.4S, V13.4S
    FRINT64Z V21.4S, V30.4S
    FCADD V22.2D, V16.2D, V25.2D, #90
    FRINT32X V13.2D, V11.2D
    FCMLA V3.4H, V27.4H, V31.4H, #0
    FCMLA V30.8H, V23.8H, V3.H[0x3], #270
    FCADD V13.4S, V31.4S, V11.4S, #90
    FCMLA V21.2D, V13.2D, V21.2D, #180
    FRINT32X V25.4S, V5.4S
    FCMLA V6.8H, V25.8H, V29.H[0x3], #90
    FCMLA V21.4S, V22.4S, V27.4S, #180
    FCADD V27.2S, V26.2S, V6.2S, #270
    FCMLA V28.8H, V21.8H, V1.H[0x3], #90
    FCADD V22.4H, V13.4H, V23.4H, #270
    FCMLA V28.4H, V26.4H, V21.4H, #90
    FRINT64X V31.2S, V27.2S
    FCMLA V8.8H, V31.8H, V30.H[0x3], #270
    FCMLA V22.4S, V3.4S, V6.S[0x1], #180
    FRINT64Z V13.2D, V22.2D
    FRINT64Z V23.2S, V21.2S
    FCMLA V13.8H, V22.8H, V13.H[0x2], #90
    FCADD V6.4H, V9.4H, V23.4H, #90
    FCMLA V6.8H, V8.8H, V6.8H, #0
    FCADD V13.8H, V28.8H, V5.8H, #270
    FCADD V6.2D, V13.2D, V13.2D, #270
    FCMLA V16.4S, V28.4S, V13.S[0x0], #0
    FRINT64X V22.2S, V4.2S
    FCMLA V25.4S, V18.4S, V9.S[0x0], #180
    FCMLA V9.2S, V23.2S, V31.2S, #180
    FRINT64Z V23.2S, V23.2S
    FCMLA V20.4H, V11.4H, V23.4H, #180
    FCADD V27.2D, V21.2D, V29.2D, #90
    FCMLA V18.4S, V1.4S, V12.S[0x1], #90
    FCMLA V20.2D, V6.2D, V30.2D, #270
    FRINT32Z V31.2S, V27.2S
    FCMLA V17.4H, V6.4H, V14.H[0x0], #180
    FCADD V26.2D, V1.2D, V0.2D, #90
    FCMLA V18.4S, V18.4S, V25.S[0x1], #270
    FRINT32Z V21.4S, V9.4S
    FRINT64X V23.2S, V21.2S
    FCADD V31.4H, V18.4H, V31.4H, #90
    FRINT64Z V20.4S, V22.4S
    FCADD V20.2S, V20.2S, V20.2S, #90
    FCADD V16.4S, V31.4S, V26.4S, #270
    FRINT32X V31.4S, V16.4S
    FRINT64X V28.2D, V18.2D
    FCMLA V1.4S, V31.4S, V8.S[0x0], #270
    FCMLA V17.8H, V17.8H, V1.H[0x2], #0
    FCMLA V20.8H, V16.8H, V23.H[0x0], #0
    FRINT64Z V0.2D, V20.2D
    FRINT64X V23.2D, V0.2D
    FRINT64X V9.2S, V8.2S
    FRINT32Z V1.2S, V14.2S
    FCMLA V7.4H, V1.4H, V28.H[0x1], #180
    FCMLA V12.4S, V5.4S, V23.4S, #90
    FRINT64X V23.4S, V9.4S
    FRINT32X V0.2D, V0.2D
    FCADD V27.2D, V30.2D, V1.2D, #270
    FCMLA V18.4H, V28.4H, V12.H[0x0], #90
    FRINT64X V26.4S, V26.4S
    FRINT32Z V9.2S, V18.2S
    FCADD V17.2D, V17.2D, V9.2D, #90
    FRINT64X V6.2D, V13.2D
    FRINT64Z V9.4S, V23.4S
    FRINT32Z V14.2S, V9.2S
    FRINT32Z V20.2D, V7.2D
    FRINT32Z V12.2S, V11.2S
    FCADD V0.2S, V14.2S, V17.2S, #90
    FRINT32Z V20.2D, V11.2D
    FRINT32Z V13.2D, V18.2D
    FRINT64X V1.4S, V0.4S
    FCMLA V1.4H, V29.4H, V23.H[0x0], #0
    FRINT64Z V5.2S, V13.2S
    FRINT32X V31.2S, V20.2S
    FCMLA V14.8H, V31.8H, V1.H[0x1], #180
    FCADD V27.2D, V24.2D, V27.2D, #90
    FCMLA V9.4S, V27.4S, V26.S[0x0], #180
    FCMLA V12.8H, V4.8H, V1.H[0x0], #90
    FCMLA V4.4S, V12.4S, V6.S[0x1], #90
    FRINT32X V25.4S, V9.4S
    FCADD V4.4S, V14.4S, V5.4S, #270
    FRINT64X V9.4S, V25.4S
    FRINT32X V11.2S, V14.2S
    FCMLA V27.2S, V28.2S, V28.2S, #90
    FCADD V6.4S, V15.4S, V0.4S, #90
    FRINT64X V13.2S, V25.2S
    FCMLA V4.8H, V25.8H, V8.H[0x0], #180
    FCADD V4.2D, V22.2D, V4.2D, #90
    FCMLA V6.4H, V13.4H, V12.H[0x1], #270
    FRINT64Z V26.2D, V18.2D
    FCMLA V30.8H, V8.8H, V13.H[0x0], #0
    FRINT32X V20.4S, V0.4S
    FRINT32Z V14.2D, V16.2D
    FCADD V14.2S, V26.2S, V20.2S, #270
    FRINT32Z V20.4S, V24.4S
    FCMLA V20.2S, V14.2S, V9.2S, #180
    FCADD V27.4S, V4.4S, V30.4S, #90
    FRINT32Z V12.4S, V20.4S
    FCMLA V19.8H, V27.8H, V0.8H, #180
    FRINT64X V22.4S, V19.4S
    FRINT32Z V18.2D, V22.2D
    FRINT64Z V20.2S, V11.2S
    FRINT64Z V30.2S, V12.2S
    FCADD V6.4H, V30.4H, V18.4H, #270
    FRINT32Z V12.2D, V6.2D
    FRINT32X V6.4S, V21.4S
    FCADD V10.4S, V27.4S, V11.4S, #270
    FRINT64Z V11.2D, V4.2D
    FCMLA V21.4H, V21.4H, V19.4H, #180
    FCMLA V10.8H, V7.8H, V21.H[0x2], #180
    FRINT32X V27.2S, V30.2S
    FCMLA V9.2D, V9.2D, V26.2D, #270
    FCMLA V26.4S, V17.4S, V17.4S, #180
    FRINT32Z V11.4S, V20.4S
    FCMLA V5.8H, V16.8H, V29.H[0x1], #180
    FCMLA V29.4H, V7.4H, V6.4H, #90
    FRINT32Z V22.4S, V17.4S
    FCADD V10.8H, V26.8H, V29.8H, #270
    FCADD V12.4H, V12.4H, V11.4H, #270
    FRINT32X V7.2D, V5.2D
    FCADD V10.4H, V25.4H, V9.4H, #90
    FCMLA V1.8H, V10.8H, V16.H[0x2], #0
    FCADD V27.4S, V7.4S, V1.4S, #270
    FCMLA V27.8H, V0.8H, V21.H[0x2], #90
    FCADD V17.8H, V12.8H, V30.8H, #90
    FRINT64X V26.2S, V5.2S
    FCMLA V27.4H, V17.4H, V31.H[0x1], #270
    FCMLA V26.4H, V1.4H, V26.H[0x1], #0
    FCADD V22.4S, V27.4S, V26.4S, #90
    FRINT64Z V8.2S, V23.2S
    FCMLA V30.8H, V26.8H, V29.H[0x0], #180
    FCADD V25.4H, V19.4H, V19.4H, #90
    FCMLA V5.8H, V15.8H, V5.8H, #0
    FCMLA V7.8H, V24.8H, V28.H[0x2], #90
    FCMLA V9.4S, V16.4S, V12.4S, #270
    FRINT64X V26.2S, V12.2S
    FRINT64Z V17.2S, V30.2S
    FRINT64Z V6.2D, V13.2D
    FRINT64Z V28.2D, V7.2D
    FRINT32X V3.4S, V28.4S
    FCMLA V13.4S, V25.4S, V4.S[0x0], #90
    FCMLA V16.2S, V3.2S, V8.2S, #90
    FRINT32Z V22.4S, V13.4S
    FRINT32X V1.4S, V16.4S
    FRINT64X V8.2S, V9.2S
    FCMLA V22.8H, V24.8H, V30.H[0x3], #270
    FCADD V12.2D, V6.2D, V1.2D, #270
    FCMLA V12.4S, V26.4S, V17.S[0x0], #180
    SUBS  X2, X2, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_11
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X3, FPSR
    MOVZ  X25, #0x9d, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D25
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D30
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X3, D31
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X12
    FMOV  D2, X27
    FMOV  V2.D[1], X27
    FMOV  D3, X17
    FMOV  V3.D[1], X29
    FMOV  D4, X27
    FMOV  V4.D[1], X4
    FMOV  D5, X25
    FMOV  V5.D[1], X10
    FMOV  D6, X7
    FMOV  V6.D[1], X4
    FMOV  D7, X6
    FMOV  V7.D[1], X14
    FMOV  D8, X11
    FMOV  V8.D[1], X14
    FMOV  D9, X3
    FMOV  V9.D[1], X23
    FMOV  D10, X5
    FMOV  V10.D[1], X29
    FMOV  D11, X29
    FMOV  V11.D[1], X17
    FMOV  D12, X11
    FMOV  V12.D[1], X27
    FMOV  D13, X16
    FMOV  V13.D[1], X4
    FMOV  D14, X9
    FMOV  V14.D[1], X5
    FMOV  D15, X28
    FMOV  V15.D[1], X5
    FMOV  D16, X5
    FMOV  V16.D[1], X4
    FMOV  D17, X29
    FMOV  V17.D[1], X2
    FMOV  D18, X23
    FMOV  V18.D[1], X12
    FMOV  D19, X29
    FMOV  V19.D[1], X12
    FMOV  D20, X17
    FMOV  V20.D[1], X27
    FMOV  D21, X15
    FMOV  V21.D[1], X8
    FMOV  D22, X9
    FMOV  V22.D[1], X5
    FMOV  D23, X6
    FMOV  V23.D[1], X16
    FMOV  D24, X24
    FMOV  V24.D[1], X16
    FMOV  D25, X13
    FMOV  V25.D[1], X8
    FMOV  D26, X8
    FMOV  V26.D[1], X29
    FMOV  D27, X16
    FMOV  V27.D[1], X12
    FMOV  D28, X23
    FMOV  V28.D[1], X13
    FMOV  D29, X29
    FMOV  V29.D[1], X11
    FMOV  D30, X12
    FMOV  V30.D[1], X15
    FMOV  D31, X26
    FMOV  V31.D[1], X26
    MOVZ  X24, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_12:
    FCADD V29.4H, V27.4H, V22.4H, #270
    FCMLA V0.8H, V23.8H, V31.8H, #270
    FRINT64Z V17.2S, V19.2S
    FCADD V4.8H, V6.8H, V17.8H, #270
    FRINT32Z V2.2D, V4.2D
    FCMLA V20.4H, V26.4H, V28.4H, #270
    FCADD V29.4H, V20.4H, V29.4H, #90
    FRINT32Z V16.4S, V2.4S
    FRINT64Z V24.4S, V31.4S
    FRINT32Z V16.2S, V8.2S
    FRINT64Z V3.2S, V0.2S
    FCMLA V16.4S, V20.4S, V25.S[0x1], #0
    FRINT32Z V29.4S, V30.4S
    FRINT32Z V26.2S, V12.2S
    FRINT32X V28.2S, V3.2S
    FRINT32X V12.4S, V28.4S
    FRINT64Z V17.4S, V29.4S
    FCADD V26.4H, V2.4H, V25.4H, #270
    FCMLA V26.8H, V12.8H, V26.H[0x0], #0
    FCMLA V0.4H, V24.4H, V21.H[0x0], #270
    FRINT64X V2.2S, V26.2S
    FCADD V0.4S, V16.4S, V12.4S, #90
    FCMLA V7.4S, V17.4S, V4.S[0x1], #180
    FRINT64X V4.2S, V7.2S
    FCMLA V0.2D, V2.2D, V0.2D, #0
    FRINT64X V24.4S, V6.4S
    FCMLA V19.4S, V24.4S, V4.S[0x1], #270
    FRINT64X V8.4S, V14.4S
    FCMLA V6.4S, V0.4S, V15.4S, #0
    FRINT32X V16.2D, V21.2D
    FRINT64X V25.2D, V24.2D
    FRINT64Z V25.2D, V13.2D
    FRINT64X V2.2D, V0.2D
    FRINT64X V29.2D, V8.2D
    FCADD V19.4S, V29.4S, V9.4S, #90
    FRINT32Z V17.4S, V1.4S
    FRINT64Z V12.2D, V4.2D
    FCADD V8.8H, V25.8H, V3.8H, #270
    FRINT64Z V0.2D, V29.2D
    FRINT32X V15.2D, V8.2D
    FCMLA V29.4H, V4.4H, V8.H[0x0], #270
    FCMLA V17.4S, V2.4S, V29.S[0x0], #270
    FCMLA V19.2S, V15.2S, V19.2S, #90
    FCMLA V6.4H, V6.4H, V22.4H, #180
    FRINT32X V28.2S, V12.2S
    FRINT32X V17.2D, V5.2D
    FCMLA V24.4H, V0.4H, V19.H[0x0], #180
    FCMLA V10.4H, V24.4H, V6.H[0x1], #0
    FRINT64X V2.4S, V16.4S
    FCMLA V18.8H, V14.8H, V17.8H, #270
    FRINT64Z V3.4S, V2.4S
    FRINT64Z V4.2S, V2.2S
    FRINT64Z V24.4S, V9.4S
    FRINT64Z V15.2D, V24.2D
    FCMLA V7.2S, V10.2S, V4.2S, #0
    FCMLA V7.4S, V15.4S, V18.S[0x0], #270
    FRINT32X V22.4S, V18.4S
    FCADD V22.2D, V22.2D, V7.2D, #270
    FRINT32X V19.4S, V22.4S
    FRINT32Z V24.2S, V3.2S
    FRINT64Z V25.2S, V24.2S
    FRINT32X V14.4S, V18.4S
    FRINT32X V16.2S, V31.2S
    FRINT64X V4.4S, V25.4S
    FCADD V4.8H, V24.8H, V14.8H, #90
    FCMLA V27.4S, V4.4S, V19.S[0x1], #90
    FCMLA V16.4S, V27.4S, V16.S[0x1], #0
    FCADD V30.8H, V0.8H, V5.8H, #90
    FRINT64X V17.2S, V9.2S
    FCMLA V24.4H, V1.4H, V7.H[0x1], #270
    FCMLA V30.8H, V21.8H, V10.H[0x1], #270
    FCMLA V14.4S, V22.4S, V0.S[0x0], #270
    FRINT64X V5.2D, V0.2D
    FRINT64X V2.2S, V12.2S
    FRINT32Z V21.2S, V21.2S
    FCMLA V13.2D, V21.2D, V19.2D, #90
    FCADD V30.8H, V2.8H, V14.8H, #270
    FCMLA V6.4H, V5.4H, V19.H[0x1], #0
    FCMLA V16.4H, V30.4H, V15.4H, #270
    FCMLA V1.8H, V11.8H, V13.H[0x1], #0
    FRINT64X V23.2D, V24.2D
    FCMLA V1.4H, V23.4H, V17.H[0x0], #90
    FRINT64Z V15.2D, V6.2D
    FCMLA V9.8H, V27.8H, V15.8H, #0
    FCMLA V9.4S, V9.4S, V1.S[0x1], #270
    FRINT32X V1.4S, V27.4S
    FRINT32Z V30.2D, V8.2D
    FCMLA V2.2D, V11.2D, V13.2D, #90
    FRINT32Z V23.4S, V29.4S
    FCADD V16.2S, V2.2S, V27.2S, #270
    FRINT32X V5.4S, V2.4S
    FRINT64X V6.2D, V12.2D
    FCADD V31.4H, V7.4H, V8.4H, #270
    FCMLA V22.4S, V2.4S, V19.S[0x1], #270
    FCMLA V31.8H, V25.8H, V31.H[0x0], #90
    FRINT32Z V13.2D, V20.2D
    FRINT32Z V24.2D, V16.2D
    FCMLA V23.4H, V31.4H, V6.4H, #180
    FCMLA V25.8H, V24.8H, V1.H[0x2], #270
    FRINT64X V21.4S, V23.4S
    FRINT64X V6.2S, V21.2S
    FCMLA V22.2S, V6.2S, V22.2S, #270
    FCMLA V14.8H, V1.8H, V30.H[0x2], #180
    FRINT32X V27.2D, V14.2D
    FCMLA V25.4S, V31.4S, V5.S[0x1], #0
    FRINT64Z V31.2D, V27.2D
    FCMLA V31.8H, V22.8H, V25.H[0x0], #270
    FCADD V5.2D, V31.2D, V10.2D, #270
    FCADD V9.8H, V5.8H, V5.8H, #270
    FCMLA V9.8H, V5.8H, V22.H[0x1], #0
    FCMLA V7.4H, V14.4H, V30.4H, #270
    FRINT64Z V25.4S, V26.4S
    FCMLA V20.4S, V6.4S, V31.S[0x1], #180
    FRINT64Z V4.2D, V4.2D
    FRINT32X V23.4S, V2.4S
    FCADD V3.4H, V8.4H, V11.4H, #270
    FRINT32X V1.2S, V29.2S
    FCMLA V13.4H, V0.4H, V11.H[0x0], #180
    FCADD V3.4H, V3.4H, V7.4H, #90
    FCADD V9.4H, V4.4H, V3.4H, #90
    FRINT64X V6.2S, V9.2S
    FRINT32Z V19.2S, V22.2S
    FRINT64Z V29.2D, V25.2D
    FRINT64X V2.4S, V20.4S
    FCMLA V2.4S, V0.4S, V4.S[0x1], #90
    FCMLA V12.4S, V1.4S, V19.S[0x1], #90
    FCMLA V17.8H, V29.8H, V12.H[0x3], #0
    FCMLA V6.4H, V8.4H, V2.H[0x1], #0
    FRINT64Z V3.2D, V30.2D
    FRINT32Z V4.2S, V23.2S
    FRINT32X V31.4S, V6.4S
    FCMLA V3.4H, V3.4H, V17.4H, #0
    FRINT64X V25.2S, V29.2S
    FRINT32X V8.2S, V31.2S
    FRINT32Z V11.2D, V8.2D
    FRINT32Z V2.2D, V3.2D
    FRINT64Z V17.4S, V4.4S
    FCMLA V2.2S, V9.2S, V17.2S, #90
    FCMLA V2.8H, V27.8H, V13.8H, #0
    FRINT32Z V27.4S, V30.4S
    FRINT64X V1.2S, V27.2S
    FCMLA V25.2S, V20.2S, V11.2S, #270
    FRINT32X V27.4S, V1.4S
    FRINT64X V1.2S, V25.2S
    FCMLA V3.4H, V27.4H, V1.4H, #0
    FRINT32Z V31.2D, V18.2D
    FCMLA V22.4H, V17.4H, V7.4H, #90
    FCMLA V7.8H, V25.8H, V3.H[0x0], #180
    FRINT32Z V11.2D, V19.2D
    FRINT32Z V4.4S, V12.4S
    FCMLA V19.4H, V7.4H, V12.H[0x1], #180
    FRINT32X V7.2S, V9.2S
    FRINT64Z V30.2D, V1.2D
    FRINT32X V25.2D, V17.2D
    FRINT64Z V1.2S, V31.2S
    FCMLA V7.4S, V25.4S, V25.4S, #180
    FCMLA V13.2D, V8.2D, V11.2D, #180
    FCADD V22.2S, V30.2S, V17.2S, #270
    FCMLA V21.4H, V22.4H, V15.H[0x1], #270
    FCADD V0.4S, V21.4S, V7.4S, #270
    FRINT64Z V22.2D, V24.2D
    FCMLA V2.4H, V21.4H, V0.H[0x1], #270
    FRINT32Z V21.4S, V4.4S
    FCMLA V11.2D, V21.2D, V24.2D, #90
    FCMLA V11.2S, V17.2S, V30.2S, #180
    FCADD V28.4H, V13.4H, V21.4H, #270
    FRINT64X V25.4S, V22.4S
    FCADD V28.2S, V2.2S, V29.2S, #270
    FCMLA V25.2D, V25.2D, V5.2D, #270
    FRINT32X V12.4S, V28.4S
    FRINT32Z V7.2S, V1.2S
    FRINT64X V0.4S, V21.4S
    FCMLA V28.4H, V17.4H, V11.4H, #270
    FCMLA V28.2D, V26.2D, V25.2D, #180
    FCMLA V9.2D, V28.2D, V4.2D, #0
    FRINT32X V25.2D, V9.2D
    FCMLA V25.4H, V7.4H, V19.H[0x1], #180
    FCMLA V25.8H, V0.8H, V22.H[0x2], #180
    FCADD V0.2S, V5.2S, V15.2S, #270
    FRINT64Z V13.4S, V29.4S
    FCMLA V20.4H, V29.4H, V14.4H, #90
    FRINT32X V19.4S, V28.4S
    FRINT64Z V18.2S, V8.2S
    FRINT64X V24.2S, V27.2S
    FCMLA V2.2S, V5.2S, V17.2S, #180
    FRINT64X V11.2D, V2.2D
    FCADD V0.2S, V12.2S, V18.2S, #90
    FCADD V25.4S, V19.4S, V29.4S, #270
    FCADD V0.2D, V1.2D, V0.2D, #270
    FCMLA V20.4S, V9.4S, V16.S[0x1], #270
    FRINT32X V2.2S, V11.2S
    FCMLA V0.4H, V3.4H, V13.H[0x1], #180
    FCMLA V22.8H, V16.8H, V25.H[0x2], #0
    FRINT64Z V12.2D, V15.2D
    FCMLA V0.2S, V11.2S, V21.2S, #0
    FCADD V5.8H, V0.8H, V12.8H, #270
    FCADD V6.8H, V24.8H, V12.8H, #90
    FRINT64Z V9.2D, V1.2D
    FRINT32X V7.2D, V9.2D
    FCMLA V6.4H, V2.4H, V7.H[0x1], #90
    SUBS  X24, X24, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_12
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X28, FPSR
    MOVZ  X15, #0x9d, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D0
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D1
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D2
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc3e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D3
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D4
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D5
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc3e0, LSL #32
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D6
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc7a1, LSL #32
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D7
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D8
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xcf00, LSL #16
    MOVK  X15, #0xcf00, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D9
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D10
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D11
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc3e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D12
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc3e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D13
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D14
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x535f, LSL #16
    MOVK  X15, #0xcf00, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D15
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc3e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D16
    MOVZ  X15, #0x4eff, LSL #0
    MOVK  X15, #0x5160, LSL #16
    MOVK  X15, #0x4eff, LSL #32
    MOVK  X15, #0x5160, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D17
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D18
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xcf00, LSL #16
    MOVK  X15, #0xcf00, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D19
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xcf00, LSL #16
    MOVK  X15, #0xcf00, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D20
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D21
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D22
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D23
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D24
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D25
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xcf00, LSL #16
    MOVK  X15, #0xcf00, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D26
    MOVZ  X15, #0xcf00, LSL #0
    MOVK  X15, #0xcf00, LSL #32
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D27
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D28
    MOVZ  X15, #0x7dff, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7bff, LSL #32
    MOVK  X15, #0x6d0d, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D29
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D30
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xdf00, LSL #16
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X28, D31
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc1e0, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  D0, X10
    FMOV  V0.D[1], X27
    FMOV  D1, X14
    FMOV  V1.D[1], X25
    FMOV  D2, X15
    FMOV  V2.D[1], X28
    FMOV  D3, X15
    FMOV  V3.D[1], X26
    FMOV  D4, X29
    FMOV  V4.D[1], X3
    FMOV  D5, X29
    FMOV  V5.D[1], X11
    FMOV  D6, X11
    FMOV  V6.D[1], X12
    FMOV  D7, X12
    FMOV  V7.D[1], X26
    FMOV  D8, X27
    FMOV  V8.D[1], X24
    FMOV  D9, X28
    FMOV  V9.D[1], X25
    FMOV  D10, X13
    FMOV  V10.D[1], X9
    FMOV  D11, X24
    FMOV  V11.D[1], X5
    FMOV  D12, X2
    FMOV  V12.D[1], X16
    FMOV  D13, X10
    FMOV  V13.D[1], X14
    FMOV  D14, X10
    FMOV  V14.D[1], X17
    FMOV  D15, X17
    FMOV  V15.D[1], X24
    FMOV  D16, X14
    FMOV  V16.D[1], X10
    FMOV  D17, X14
    FMOV  V17.D[1], X9
    FMOV  D18, X5
    FMOV  V18.D[1], X10
    FMOV  D19, X29
    FMOV  V19.D[1], X14
    FMOV  D20, X23
    FMOV  V20.D[1], X27
    FMOV  D21, X4
    FMOV  V21.D[1], X4
    FMOV  D22, X5
    FMOV  V22.D[1], X10
    FMOV  D23, X27
    FMOV  V23.D[1], X8
    FMOV  D24, X23
    FMOV  V24.D[1], X17
    FMOV  D25, X27
    FMOV  V25.D[1], X11
    FMOV  D26, X27
    FMOV  V26.D[1], X9
    FMOV  D27, X4
    FMOV  V27.D[1], X4
    FMOV  D28, X27
    FMOV  V28.D[1], X7
    FMOV  D29, X2
    FMOV  V29.D[1], X6
    FMOV  D30, X2
    FMOV  V30.D[1], X10
    FMOV  D31, X4
    FMOV  V31.D[1], X5
    MOVZ  X3, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_13:
    FRINT64Z V11.2S, V21.2S
    FRINT32X V25.2D, V18.2D
    FCADD V23.4S, V28.4S, V26.4S, #270
    FRINT64Z V16.2D, V25.2D
    FRINT32X V2.4S, V9.4S
    FRINT64X V2.4S, V27.4S
    FCMLA V11.4H, V2.4H, V31.H[0x1], #270
    FCMLA V17.2S, V29.2S, V29.2S, #270
    FRINT32Z V21.2S, V17.2S
    FRINT64Z V9.4S, V17.4S
    FCMLA V22.4S, V21.4S, V9.S[0x0], #90
    FCMLA V30.2S, V5.2S, V30.2S, #270
    FCMLA V30.4S, V12.4S, V11.4S, #180
    FCADD V15.4S, V24.4S, V31.4S, #270
    FCMLA V15.8H, V16.8H, V30.H[0x2], #90
    FRINT64Z V11.4S, V11.4S
    FRINT64X V5.2D, V19.2D
    FCADD V12.8H, V11.8H, V23.8H, #270
    FRINT32Z V5.2S, V12.2S
    FRINT64Z V26.4S, V28.4S
    FRINT64Z V9.2S, V10.2S
    FCMLA V26.8H, V3.8H, V0.H[0x1], #180
    FCMLA V22.8H, V26.8H, V29.8H, #90
    FRINT64Z V2.2S, V15.2S
    FRINT32Z V29.4S, V19.4S
    FRINT64X V13.4S, V10.4S
    FRINT64Z V15.4S, V10.4S
    FCMLA V29.4S, V27.4S, V20.S[0x1], #0
    FCMLA V2.4S, V13.4S, V2.4S, #90
    FCADD V29.4H, V15.4H, V22.4H, #270
    FCMLA V29.4H, V29.4H, V2.4H, #270
    FRINT64Z V12.2D, V29.2D
    FCMLA V20.4S, V0.4S, V16.4S, #0
    FCMLA V12.4S, V7.4S, V0.S[0x1], #180
    FCMLA V20.4H, V20.4H, V27.H[0x1], #180
    FCMLA V9.2S, V20.2S, V5.2S, #180
    FCADD V8.2S, V1.2S, V13.2S, #270
    FRINT32Z V22.2D, V28.2D
    FCMLA V9.4H, V7.4H, V6.H[0x0], #270
    FRINT32X V2.4S, V13.4S
    FRINT32Z V15.2D, V6.2D
    FRINT32Z V30.4S, V17.4S
    FRINT64Z V8.2D, V16.2D
    FRINT32X V20.2D, V2.2D
    FRINT64X V17.4S, V30.4S
    FCMLA V12.4S, V4.4S, V11.S[0x0], #0
    FRINT32X V29.2D, V9.2D
    FCMLA V28.4S, V8.4S, V14.4S, #0
    FRINT32Z V5.4S, V1.4S
    FRINT64Z V1.2S, V19.2S
    FCADD V30.2S, V5.2S, V1.2S, #270
    FCADD V15.4H, V27.4H, V8.4H, #270
    FRINT64Z V6.4S, V12.4S
    FCADD V6.2D, V6.2D, V14.2D, #90
    FRINT32X V7.2S, V15.2S
    FCMLA V22.4H, V24.4H, V20.H[0x1], #270
    FCMLA V0.4H, V28.4H, V8.H[0x1], #270
    FCADD V9.2D, V17.2D, V29.2D, #90
    FCMLA V30.4S, V12.4S, V6.S[0x0], #180
    FRINT32X V17.2S, V9.2S
    FCMLA V30.4S, V5.4S, V0.S[0x1], #180
    FCMLA V0.4H, V7.4H, V7.H[0x1], #90
    FRINT32X V3.4S, V22.4S
    FRINT32X V2.4S, V0.4S
    FCMLA V21.4H, V2.4H, V11.4H, #90
    FRINT64Z V4.2D, V7.2D
    FCADD V5.2S, V30.2S, V3.2S, #270
    FCMLA V4.8H, V22.8H, V11.H[0x3], #0
    FRINT32Z V2.2D, V21.2D
    FRINT64Z V30.2S, V26.2S
    FCADD V30.4S, V4.4S, V8.4S, #270
    FCADD V5.2S, V17.2S, V30.2S, #90
    FRINT32X V28.4S, V7.4S
    FCMLA V2.8H, V5.8H, V28.H[0x1], #90
    FCMLA V2.4S, V16.4S, V25.S[0x1], #90
    FCADD V16.2D, V31.2D, V15.2D, #90
    FCADD V20.4H, V14.4H, V25.4H, #270
    FRINT64X V3.2S, V15.2S
    FRINT64Z V30.2D, V0.2D
    FCADD V17.4S, V23.4S, V23.4S, #270
    FCMLA V29.8H, V18.8H, V12.8H, #90
    FRINT64X V9.2S, V22.2S
    FCADD V11.4S, V23.4S, V14.4S, #270
    FRINT64X V4.2S, V30.2S
    FCMLA V9.2D, V3.2D, V16.2D, #270
    FRINT32X V24.4S, V17.4S
    FCADD V19.2D, V29.2D, V2.2D, #270
    FCMLA V4.4H, V24.4H, V24.H[0x0], #90
    FCADD V4.4H, V20.4H, V19.4H, #270
    FRINT32X V16.2S, V24.2S
    FRINT32X V20.2D, V13.2D
    FCMLA V9.2D, V4.2D, V4.2D, #90
    FRINT64X V25.4S, V30.4S
    FCADD V9.2S, V31.2S, V16.2S, #270
    FRINT64X V30.2D, V26.2D
    FRINT64X V24.4S, V9.4S
    FCMLA V30.2S, V24.2S, V24.2S, #90
    FCMLA V11.4H, V24.4H, V25.H[0x0], #180
    FRINT32Z V19.4S, V30.4S
    FCMLA V11.8H, V19.8H, V24.8H, #90
    FCMLA V20.4S, V13.4S, V8.S[0x1], #180
    FRINT32X V21.2S, V1.2S
    FCMLA V4.4H, V28.4H, V22.H[0x1], #0
    FCMLA V17.4H, V6.4H, V21.H[0x0], #270
    FCMLA V10.4S, V1.4S, V4.S[0x1], #0
    FCMLA V23.4S, V30.4S, V11.S[0x0], #270
    FRINT64X V1.2D, V22.2D
    FCADD V5.2D, V30.2D, V12.2D, #90
    FRINT64X V28.2S, V15.2S
    FRINT64X V4.2S, V11.2S
    FCADD V6.4H, V26.4H, V30.4H, #270
    FCADD V28.8H, V4.8H, V7.8H, #270
    FRINT64X V23.2D, V10.2D
    FCMLA V25.2S, V16.2S, V6.2S, #270
    FCMLA V17.8H, V22.8H, V25.8H, #270
    FRINT32X V6.2S, V20.2S
    FCADD V23.2D, V6.2D, V17.2D, #90
    FCMLA V5.4H, V19.4H, V31.4H, #180
    FRINT32Z V13.2S, V5.2S
    FRINT32X V20.2S, V23.2S
    FRINT64Z V14.2D, V1.2D
    FCMLA V28.4H, V13.4H, V18.H[0x1], #270
    FRINT32X V12.4S, V22.4S
    FRINT32Z V4.2S, V22.2S
    FCADD V4.8H, V14.8H, V4.8H, #270
    FRINT64X V25.2S, V28.2S
    FRINT64X V30.2D, V17.2D
    FRINT32Z V22.2D, V12.2D
    FCMLA V31.4H, V4.4H, V25.H[0x0], #90
    FCADD V8.8H, V20.8H, V30.8H, #90
    FCMLA V25.4S, V22.4S, V26.4S, #270
    FCMLA V8.4S, V25.4S, V31.S[0x1], #90
    FCMLA V22.4H, V24.4H, V28.H[0x1], #0
    FCMLA V16.2S, V18.2S, V6.2S, #0
    FCMLA V25.8H, V6.8H, V17.H[0x3], #270
    FRINT64Z V1.2S, V5.2S
    FRINT32Z V19.2D, V2.2D
    FRINT64X V12.2S, V20.2S
    FRINT64X V17.4S, V9.4S
    FRINT32X V2.4S, V26.4S
    FCMLA V31.8H, V19.8H, V8.8H, #90
    FCADD V16.4H, V25.4H, V22.4H, #90
    FRINT32Z V13.2D, V2.2D
    FRINT64X V2.2D, V22.2D
    FCADD V27.4H, V3.4H, V31.4H, #90
    FCMLA V13.8H, V1.8H, V31.H[0x3], #270
    FRINT64Z V3.2S, V13.2S
    FCMLA V17.8H, V12.8H, V26.H[0x2], #180
    FCMLA V16.4H, V3.4H, V26.4H, #180
    FRINT32Z V22.2D, V31.2D
    FCADD V17.4H, V17.4H, V27.4H, #270
    FRINT64Z V27.4S, V14.4S
    FCMLA V13.4H, V27.4H, V22.4H, #0
    FCMLA V4.4S, V0.4S, V16.4S, #0
    FCMLA V6.4H, V4.4H, V13.H[0x1], #180
    FRINT64Z V13.2S, V17.2S
    FCMLA V23.8H, V13.8H, V6.H[0x1], #0
    FCMLA V25.4S, V4.4S, V7.S[0x0], #90
    FRINT32Z V31.2D, V30.2D
    FCADD V25.4H, V21.4H, V19.4H, #90
    FCADD V22.2S, V4.2S, V9.2S, #90
    FRINT64Z V30.4S, V10.4S
    FCADD V22.2S, V2.2S, V7.2S, #270
    FRINT64Z V0.2D, V12.2D
    FRINT32X V27.2D, V15.2D
    FRINT64X V4.4S, V10.4S
    FRINT32X V12.2D, V9.2D
    FCADD V23.4H, V24.4H, V2.4H, #90
    FRINT64Z V16.4S, V30.4S
    FRINT32X V21.4S, V4.4S
    FRINT64X V10.4S, V17.4S
    FRINT32Z V24.2S, V22.2S
    FRINT64Z V6.2S, V12.2S
    FRINT32Z V25.2D, V0.2D
    FRINT32X V30.2D, V21.2D
    FCMLA V24.4S, V11.4S, V14.S[0x0], #180
    FRINT64X V21.4S, V23.4S
    FRINT32Z V3.4S, V16.4S
    FCMLA V27.8H, V25.8H, V15.H[0x2], #270
    FRINT32X V2.4S, V21.4S
    FRINT64Z V28.2S, V2.2S
    FRINT64X V7.2D, V6.2D
    FRINT32Z V19.2D, V29.2D
    FRINT64X V15.2D, V24.2D
    FRINT32X V2.4S, V7.4S
    FCMLA V30.2S, V2.2S, V19.2S, #270
    FRINT64Z V25.2S, V10.2S
    FRINT32X V24.2S, V30.2S
    FRINT32Z V19.2D, V22.2D
    FCADD V16.4H, V11.4H, V11.4H, #90
    FCMLA V28.2S, V16.2S, V4.2S, #0
    FCADD V24.8H, V6.8H, V15.8H, #270
    FCMLA V17.4H, V3.4H, V20.H[0x1], #90
    FCADD V29.4H, V24.4H, V27.4H, #270
    FCMLA V21.2S, V0.2S, V13.2S, #270
    FCADD V25.4H, V5.4H, V25.4H, #270
    FCMLA V31.4S, V28.4S, V29.S[0x0], #270
    FRINT64X V5.2S, V19.2S
    FRINT32X V11.2S, V31.2S
    FCADD V26.2D, V21.2D, V21.2D, #270
    SUBS  X3, X3, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_13
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X17, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X7, FPSR
    MOVZ  X17, #0x9d, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D0
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc3e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D1
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0xdf00, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D2
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D3
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xcf00, LSL #16
    MOVK  X17, #0xe578, LSL #32
    MOVK  X17, #0xcc5c, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D4
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0xe578, LSL #32
    MOVK  X17, #0xcc5c, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D5
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D6
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D7
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D8
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x43e0, LSL #32
    MOVK  X17, #0xcf00, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D9
    MOVZ  X17, #0xfffe, LSL #0
    MOVK  X17, #0x7f7f, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0x4eff, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D10
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x4abe, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D11
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xcf00, LSL #16
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D12
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D13
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x4abe, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D14
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4850, LSL #32
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D15
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc3e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D16
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D17
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x4abe, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D18
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D19
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D20
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xcf00, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D21
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xe35f, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D22
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #16
    MOVK  X17, #0xc3e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D23
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x4eff, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D24
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc3e0, LSL #32
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D25
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0x635f, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D26
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xdf00, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xe35f, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D27
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D28
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xff7f, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xff7f, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D29
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc6e0, LSL #32
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D30
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4444, LSL #16
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X7, D31
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x7f7f, LSL #16
    MOVK  X17, #0xc1e0, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorFcmaFrintts_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X23
    FMOV  D2, X17
    FMOV  V2.D[1], X3
    FMOV  D3, X23
    FMOV  V3.D[1], X9
    FMOV  D4, X10
    FMOV  V4.D[1], X28
    FMOV  D5, X12
    FMOV  V5.D[1], X28
    FMOV  D6, X14
    FMOV  V6.D[1], X8
    FMOV  D7, X5
    FMOV  V7.D[1], X6
    FMOV  D8, X4
    FMOV  V8.D[1], X7
    FMOV  D9, X2
    FMOV  V9.D[1], X29
    FMOV  D10, X3
    FMOV  V10.D[1], X3
    FMOV  D11, X4
    FMOV  V11.D[1], X29
    FMOV  D12, X6
    FMOV  V12.D[1], X11
    FMOV  D13, X25
    FMOV  V13.D[1], X7
    FMOV  D14, X13
    FMOV  V14.D[1], X14
    FMOV  D15, X4
    FMOV  V15.D[1], X9
    FMOV  D16, X10
    FMOV  V16.D[1], X26
    FMOV  D17, X11
    FMOV  V17.D[1], X7
    FMOV  D18, X13
    FMOV  V18.D[1], X11
    FMOV  D19, X17
    FMOV  V19.D[1], X3
    FMOV  D20, X23
    FMOV  V20.D[1], X2
    FMOV  D21, X7
    FMOV  V21.D[1], X2
    FMOV  D22, X13
    FMOV  V22.D[1], X6
    FMOV  D23, X28
    FMOV  V23.D[1], X27
    FMOV  D24, X3
    FMOV  V24.D[1], X2
    FMOV  D25, X10
    FMOV  V25.D[1], X16
    FMOV  D26, X17
    FMOV  V26.D[1], X28
    FMOV  D27, X4
    FMOV  V27.D[1], X5
    FMOV  D28, X26
    FMOV  V28.D[1], X29
    FMOV  D29, X27
    FMOV  V29.D[1], X6
    FMOV  D30, X26
    FMOV  V30.D[1], X17
    FMOV  D31, X6
    FMOV  V31.D[1], X11
    MOVZ  X11, #0xa, LSL #0
LCRTAdvsimdVectorFcmaFrintts_label_14:
    FRINT64X V5.2S, V14.2S
    FRINT32Z V28.2D, V26.2D
    FCADD V23.2D, V5.2D, V28.2D, #90
    FCMLA V26.8H, V26.8H, V23.8H, #180
    FCMLA V27.4H, V29.4H, V29.H[0x1], #90
    FCMLA V28.2S, V25.2S, V26.2S, #270
    FCADD V30.2S, V28.2S, V30.2S, #270
    FRINT32X V10.4S, V1.4S
    FCMLA V6.4H, V21.4H, V10.H[0x0], #180
    FCMLA V17.8H, V30.8H, V31.H[0x3], #90
    FCADD V19.2D, V15.2D, V7.2D, #90
    FCMLA V13.2S, V3.2S, V19.2S, #270
    FCMLA V28.4S, V12.4S, V27.S[0x1], #180
    FCMLA V24.2S, V5.2S, V21.2S, #0
    FCADD V28.4H, V28.4H, V24.4H, #90
    FCMLA V20.4H, V21.4H, V17.4H, #90
    FCMLA V28.8H, V20.8H, V31.H[0x0], #270
    FCADD V16.2S, V13.2S, V29.2S, #270
    FRINT64X V24.4S, V19.4S
    FCADD V15.2S, V0.2S, V13.2S, #270
    FRINT32X V23.2D, V6.2D
    FRINT32X V30.4S, V23.4S
    FRINT32Z V23.4S, V28.4S
    FRINT64Z V26.2D, V15.2D
    FRINT64Z V20.2S, V16.2S
    FCMLA V30.2D, V14.2D, V23.2D, #180
    FCADD V26.2D, V26.2D, V26.2D, #270
    FCMLA V1.2S, V14.2S, V19.2S, #270
    FCMLA V0.4H, V27.4H, V24.H[0x1], #180
    FRINT32Z V4.4S, V28.4S
    FRINT64X V7.2S, V0.2S
    FCMLA V31.2S, V1.2S, V11.2S, #0
    FRINT64X V15.4S, V31.4S
    FCMLA V20.2D, V6.2D, V26.2D, #270
    FCADD V8.4H, V11.4H, V4.4H, #270
    FRINT32X V4.4S, V8.4S
    FCMLA V15.4H, V4.4H, V18.H[0x1], #180
    FRINT32Z V24.2S, V30.2S
    FCMLA V19.4H, V24.4H, V20.H[0x1], #90
    FCMLA V15.2D, V15.2D, V7.2D, #180
    FRINT32X V23.2S, V22.2S
    FRINT64Z V7.2D, V25.2D
    FCADD V13.2S, V30.2S, V7.2S, #90
    FRINT64X V28.4S, V13.4S
    FRINT32X V23.2D, V25.2D
    FRINT32X V31.2S, V12.2S
    FCMLA V19.4S, V4.4S, V19.4S, #270
    FCADD V4.2S, V2.2S, V31.2S, #270
    FCMLA V29.4S, V29.4S, V11.S[0x1], #90
    FCMLA V28.4S, V12.4S, V19.S[0x1], #270
    FCMLA V16.8H, V24.8H, V11.8H, #90
    FCMLA V30.4S, V8.4S, V24.S[0x1], #0
    FRINT64Z V6.4S, V15.4S
    FRINT64X V24.4S, V8.4S
    FRINT64Z V20.2D, V12.2D
    FCMLA V6.4H, V16.4H, V28.H[0x0], #90
    FCMLA V29.4S, V14.4S, V28.4S, #180
    FRINT64X V19.4S, V10.4S
    FRINT32X V22.2D, V4.2D
    FCMLA V30.2D, V24.2D, V5.2D, #90
    FCMLA V23.2D, V31.2D, V23.2D, #180
    FCMLA V19.8H, V22.8H, V9.H[0x0], #90
    FCADD V23.2D, V6.2D, V23.2D, #90
    FRINT32Z V14.2D, V8.2D
    FCADD V5.2S, V26.2S, V1.2S, #90
    FCMLA V25.2D, V29.2D, V29.2D, #180
    FRINT32X V27.2D, V20.2D
    FRINT32X V16.2D, V5.2D
    FCMLA V23.4H, V25.4H, V30.H[0x0], #180
    FCADD V11.2D, V28.2D, V19.2D, #270
    FCMLA V14.4S, V23.4S, V31.S[0x0], #270
    FCMLA V4.8H, V28.8H, V11.H[0x0], #90
    FCADD V27.4S, V27.4S, V28.4S, #90
    FRINT32Z V29.2D, V5.2D
    FRINT32Z V11.2S, V5.2S
    FRINT64Z V11.2D, V14.2D
    FCMLA V4.4S, V3.4S, V11.4S, #270
    FRINT64Z V22.2S, V16.2S
    FRINT64X V26.2S, V17.2S
    FCMLA V4.4H, V5.4H, V24.H[0x0], #180
    FCMLA V9.2S, V28.2S, V27.2S, #0
    FRINT32Z V17.4S, V2.4S
    FRINT32Z V2.2S, V8.2S
    FRINT32Z V25.4S, V22.4S
    FRINT32Z V5.2D, V23.2D
    FCADD V26.4H, V2.4H, V25.4H, #270
    FRINT32X V9.2D, V6.2D
    FCMLA V5.8H, V21.8H, V29.8H, #180
    FRINT64Z V20.4S, V9.4S
    FRINT32Z V3.2D, V4.2D
    FRINT64Z V22.2D, V0.2D
    FRINT64Z V4.2D, V19.2D
    FRINT64Z V31.2D, V5.2D
    FRINT32X V5.2S, V12.2S
    FCMLA V23.2S, V10.2S, V18.2S, #180
    FRINT64X V27.4S, V5.4S
    FCMLA V3.2S, V23.2S, V31.2S, #270
    FRINT64X V14.2S, V21.2S
    FRINT64X V0.2D, V12.2D
    FCMLA V20.4H, V22.4H, V26.H[0x0], #0
    FCADD V12.4H, V27.4H, V17.4H, #90
    FRINT32X V29.2D, V3.2D
    FCMLA V15.8H, V4.8H, V12.8H, #90
    FCADD V14.4H, V22.4H, V15.4H, #270
    FCMLA V14.8H, V20.8H, V27.H[0x0], #270
    FRINT64X V25.2S, V0.2S
    FRINT32Z V3.2D, V17.2D
    FRINT32X V28.2S, V1.2S
    FRINT32Z V21.4S, V10.4S
    FRINT64Z V0.2S, V28.2S
    FCMLA V2.4S, V14.4S, V0.S[0x1], #270
    FRINT64X V10.2D, V19.2D
    FRINT64X V5.2S, V24.2S
    FCMLA V29.4S, V29.4S, V21.4S, #270
    FRINT64X V0.4S, V3.4S
    FCMLA V0.4H, V29.4H, V20.4H, #180
    FRINT64X V1.2S, V10.2S
    FCMLA V15.8H, V22.8H, V7.H[0x0], #180
    FRINT32Z V28.2S, V2.2S
    FCMLA V13.4S, V1.4S, V0.S[0x0], #180
    FCMLA V9.2D, V25.2D, V12.2D, #90
    FCADD V28.8H, V4.8H, V13.8H, #270
    FRINT32Z V29.4S, V14.4S
    FCMLA V9.2D, V13.2D, V9.2D, #270
    FCADD V5.4H, V5.4H, V29.4H, #270
    FRINT64X V2.4S, V5.4S
    FRINT64X V17.2D, V15.2D
    FRINT32X V11.4S, V26.4S
    FRINT64Z V27.2D, V17.2D
    FCADD V0.2S, V22.2S, V27.2S, #90
    FCMLA V9.2S, V12.2S, V11.2S, #180
    FCMLA V7.4H, V21.4H, V9.4H, #0
    FCMLA V28.4S, V0.4S, V1.4S, #0
    FCMLA V24.8H, V7.8H, V15.8H, #180
    FRINT32Z V22.4S, V28.4S
    FRINT64X V15.4S, V14.4S
    FCMLA V22.8H, V20.8H, V22.H[0x3], #180
    FCMLA V10.4H, V15.4H, V12.4H, #180
    FRINT64X V7.2D, V10.2D
    FRINT32Z V1.2S, V22.2S
    FCADD V2.8H, V12.8H, V7.8H, #90
    FRINT64Z V15.2S, V2.2S
    FRINT64Z V13.4S, V24.4S
    FRINT32X V3.2D, V13.2D
    FCADD V3.2D, V15.2D, V14.2D, #90
    FCADD V16.4S, V18.4S, V1.4S, #270
    FRINT32X V13.2D, V10.2D
    FRINT32Z V1.4S, V4.4S
    FRINT32Z V28.4S, V28.4S
    FCMLA V25.2S, V17.2S, V20.2S, #0
    FCMLA V12.4S, V15.4S, V20.S[0x0], #90
    FCADD V22.4S, V9.4S, V22.4S, #90
    FCMLA V12.8H, V4.8H, V5.H[0x1], #180
    FCADD V29.8H, V9.8H, V28.8H, #270
    FCMLA V2.4H, V22.4H, V23.4H, #90
    FCMLA V12.4S, V4.4S, V27.S[0x0], #90
    FRINT64Z V10.2D, V16.2D
    FCMLA V16.8H, V3.8H, V21.8H, #270
    FCADD V14.8H, V18.8H, V11.8H, #90
    FRINT32Z V5.2D, V13.2D
    FCMLA V12.4S, V10.4S, V3.S[0x0], #90
    FRINT32X V20.4S, V2.4S
    FRINT64Z V27.2S, V16.2S
    FRINT64X V13.2D, V3.2D
    FRINT64Z V4.2S, V20.2S
    FCMLA V14.4H, V16.4H, V27.H[0x1], #180
    FCADD V1.4S, V4.4S, V1.4S, #90
    FCMLA V12.8H, V13.8H, V29.H[0x0], #0
    FCMLA V14.4S, V12.4S, V11.S[0x1], #90
    FRINT64X V17.4S, V23.4S
    FCMLA V11.4S, V1.4S, V0.4S, #0
    FRINT64Z V24.2D, V5.2D
    FCADD V14.4H, V20.4H, V17.4H, #90
    FCMLA V10.2D, V14.2D, V11.2D, #0
    FRINT32X V29.2S, V12.2S
    FCMLA V31.8H, V0.8H, V24.8H, #270
    FCMLA V31.8H, V25.8H, V4.H[0x1], #90
    FCADD V5.2S, V31.2S, V29.2S, #270
    FCMLA V12.4H, V18.4H, V16.H[0x1], #270
    FCMLA V27.8H, V26.8H, V18.H[0x2], #270
    FRINT32Z V17.2D, V11.2D
    FRINT64Z V1.2S, V16.2S
    FRINT64X V26.2D, V16.2D
    FCADD V3.8H, V14.8H, V13.8H, #90
    FCMLA V21.4H, V17.4H, V19.H[0x0], #270
    FCADD V15.2S, V23.2S, V15.2S, #90
    FCMLA V12.2D, V15.2D, V10.2D, #180
    FCMLA V1.2S, V1.2S, V23.2S, #180
    FRINT64X V11.2D, V1.2D
    FCMLA V31.4H, V27.4H, V3.H[0x0], #0
    FCMLA V5.4H, V21.4H, V5.H[0x0], #90
    FCMLA V14.4H, V11.4H, V7.4H, #180
    FCMLA V22.4S, V8.4S, V14.S[0x1], #90
    FRINT64Z V18.4S, V26.4S
    FRINT32X V26.2D, V16.2D
    FCADD V17.4H, V3.4H, V12.4H, #270
    FCMLA V6.8H, V31.8H, V22.H[0x3], #180
    FRINT64X V30.4S, V9.4S
    FCMLA V17.8H, V18.8H, V17.H[0x0], #90
    FCMLA V6.8H, V6.8H, V26.8H, #90
    SUBS  X11, X11, #0x1
    B.NE  LCRTAdvsimdVectorFcmaFrintts_label_14
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X4, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorFcmaFrintts_TestFail
    MRS  X27, FPSR
    MOVZ  X4, #0x9d, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D1
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D8
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D11
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D16
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D18
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D21
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D26
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail
    FMOV  X27, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorFcmaFrintts_TestFail

LCRTAdvsimdVectorFcmaFrintts_TestEnd:
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
LCRTAdvsimdVectorFcmaFrintts_TestFail:
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
