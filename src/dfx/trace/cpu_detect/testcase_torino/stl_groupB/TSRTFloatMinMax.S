.global TSRTFloatMinMax

.text
.p2align 4

TSRTFloatMinMax:

TSRTFloatMinMax_TestBegin:
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
    MOVZ  X2, #0x4130, LSL #0
    MOVK  X2, #0x8356, LSL #16
    MOVK  X2, #0x4953, LSL #32
    MOVK  X2, #0xd9ee, LSL #48
    MOVZ  X3, #0x917d, LSL #0
    MOVK  X3, #0xfb30, LSL #16
    MOVK  X3, #0x32e, LSL #32
    MOVK  X3, #0x91ae, LSL #48
    MOVZ  X4, #0x5f0a, LSL #0
    MOVK  X4, #0xf0ac, LSL #16
    MOVK  X4, #0x6d15, LSL #32
    MOVK  X4, #0x8067, LSL #48
    MOVZ  X5, #0xe7a2, LSL #0
    MOVK  X5, #0x3d52, LSL #16
    MOVK  X5, #0xa444, LSL #32
    MOVK  X5, #0x27d9, LSL #48
    MOVZ  X6, #0x16b9, LSL #0
    MOVK  X6, #0x4269, LSL #16
    MOVK  X6, #0xd5fb, LSL #32
    MOVK  X6, #0x8266, LSL #48
    MOVZ  X7, #0x5267, LSL #0
    MOVK  X7, #0x833, LSL #16
    MOVK  X7, #0xc202, LSL #32
    MOVK  X7, #0xf1, LSL #48
    MOVZ  X8, #0x9390, LSL #0
    MOVK  X8, #0xda11, LSL #16
    MOVK  X8, #0x302f, LSL #32
    MOVK  X8, #0x1b25, LSL #48
    MOVZ  X9, #0x7c02, LSL #0
    MOVK  X9, #0x1286, LSL #16
    MOVK  X9, #0x6b4, LSL #32
    MOVK  X9, #0xf015, LSL #48
    MOVZ  X10, #0x2620, LSL #0
    MOVK  X10, #0x7d8f, LSL #16
    MOVK  X10, #0x6269, LSL #32
    MOVK  X10, #0x697d, LSL #48
    MOVZ  X11, #0x30a4, LSL #0
    MOVK  X11, #0x9b95, LSL #16
    MOVK  X11, #0xb68f, LSL #32
    MOVK  X11, #0xebd7, LSL #48
    MOVZ  X12, #0x38f, LSL #0
    MOVK  X12, #0x4ae, LSL #16
    MOVK  X12, #0xcb2a, LSL #32
    MOVK  X12, #0xd092, LSL #48
    MOVZ  X13, #0xabfc, LSL #0
    MOVK  X13, #0x50c3, LSL #16
    MOVK  X13, #0xe0e3, LSL #32
    MOVK  X13, #0x4aca, LSL #48
    MOVZ  X14, #0x817f, LSL #0
    MOVK  X14, #0x50c1, LSL #16
    MOVK  X14, #0x6e92, LSL #32
    MOVK  X14, #0xa1d7, LSL #48
    MOVZ  X15, #0xfdc2, LSL #0
    MOVK  X15, #0xfe63, LSL #16
    MOVK  X15, #0xf0f7, LSL #32
    MOVK  X15, #0x54fc, LSL #48
    MOVZ  X16, #0xb1e1, LSL #0
    MOVK  X16, #0x5159, LSL #16
    MOVK  X16, #0x8b29, LSL #32
    MOVK  X16, #0x800b, LSL #48
    MOVZ  X17, #0x6916, LSL #0
    MOVK  X17, #0xfb15, LSL #16
    MOVK  X17, #0x1f6c, LSL #32
    MOVK  X17, #0x9e4c, LSL #48
    MOVZ  X18, #0x80b3, LSL #0
    MOVK  X18, #0x889c, LSL #16
    MOVK  X18, #0x3cd0, LSL #32
    MOVK  X18, #0xfc96, LSL #48
    MOVZ  X19, #0xeb4d, LSL #0
    MOVK  X19, #0x5f6c, LSL #16
    MOVK  X19, #0xee39, LSL #32
    MOVK  X19, #0x7a96, LSL #48
    MOVZ  X20, #0xa12, LSL #0
    MOVK  X20, #0x1fb4, LSL #16
    MOVK  X20, #0x2775, LSL #32
    MOVK  X20, #0x9ce8, LSL #48
    MOVZ  X21, #0x6f1d, LSL #0
    MOVK  X21, #0xe554, LSL #16
    MOVK  X21, #0x954a, LSL #32
    MOVK  X21, #0xd650, LSL #48
    MOVZ  X22, #0x395b, LSL #0
    MOVK  X22, #0xb7b8, LSL #16
    MOVK  X22, #0xe7ae, LSL #32
    MOVK  X22, #0x6dcf, LSL #48
    MOVZ  X23, #0xc0ac, LSL #0
    MOVK  X23, #0x4468, LSL #16
    MOVK  X23, #0x4587, LSL #32
    MOVK  X23, #0x74b, LSL #48
    MOVZ  X29, #0x63e0, LSL #0
    MOVK  X29, #0xccd0, LSL #16
    MOVK  X29, #0xd8fc, LSL #32
    MOVK  X29, #0xe9d0, LSL #48
    MOVZ  X16, #0xa77f, LSL #0
    MOVK  X16, #0x9155, LSL #16
    MOVK  X16, #0x2275, LSL #32
    MOVK  X16, #0x60e6, LSL #48
    MSR  FPCR, X16
    MRS  X13, FPCR
    MOVZ  X29, #0x60ff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    AND  X13, X13, X29
    MOVZ  X29, #0x0, LSL #0
    ORR  X13, X13, X29
    MSR  FPCR, X13
    ISB  SY
    MOVZ  X16, #0x3bef, LSL #0
    MOVK  X16, #0x51f3, LSL #16
    MOVK  X16, #0x90cb, LSL #32
    MOVK  X16, #0x384d, LSL #48
    MSR  FPSR, X16
    MRS  X4, FPSR
    MOVZ  X2, #0xff60, LSL #0
    MOVK  X2, #0x7ff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X4, X4, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X4, X4, X2
    MSR  FPSR, X4
    ISB  SY
    ANDS  X17, X21, X15, LSR #28
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x1ed0, LSL #0
    MOVK  X2, #0x2416, LSL #16
    MOVK  X2, #0xca8a, LSL #32
    MOVK  X2, #0x4ce1, LSL #48
    MOVZ  X3, #0xd69e, LSL #0
    MOVK  X3, #0x4370, LSL #16
    MOVK  X3, #0xa3ea, LSL #32
    MOVK  X3, #0x3211, LSL #48
    MOVZ  X4, #0xd25d, LSL #0
    MOVK  X4, #0xf93d, LSL #16
    MOVK  X4, #0xd0c9, LSL #32
    MOVK  X4, #0x5fe6, LSL #48
    MOVZ  X5, #0xcced, LSL #0
    MOVK  X5, #0xa81f, LSL #16
    MOVK  X5, #0xf6d9, LSL #32
    MOVK  X5, #0xd6bf, LSL #48
    MOVZ  X6, #0xaba0, LSL #0
    MOVK  X6, #0xf4f0, LSL #16
    MOVK  X6, #0xf6f7, LSL #32
    MOVK  X6, #0xd57c, LSL #48
    MOVZ  X7, #0x8d9b, LSL #0
    MOVK  X7, #0x401c, LSL #16
    MOVK  X7, #0x4d54, LSL #32
    MOVK  X7, #0x3ed2, LSL #48
    MOVZ  X8, #0x5f96, LSL #0
    MOVK  X8, #0xc07e, LSL #16
    MOVK  X8, #0xe637, LSL #32
    MOVK  X8, #0xf3f1, LSL #48
    MOVZ  X9, #0x3ef7, LSL #0
    MOVK  X9, #0x2b50, LSL #16
    MOVK  X9, #0x9add, LSL #32
    MOVK  X9, #0xf77d, LSL #48
    MOVZ  X10, #0x8f15, LSL #0
    MOVK  X10, #0xf874, LSL #16
    MOVK  X10, #0xcb17, LSL #32
    MOVK  X10, #0x4509, LSL #48
    MOVZ  X11, #0x8250, LSL #0
    MOVK  X11, #0x9779, LSL #16
    MOVK  X11, #0x1837, LSL #32
    MOVK  X11, #0xb28d, LSL #48
    MOVZ  X12, #0xbaf4, LSL #0
    MOVK  X12, #0x8c, LSL #16
    MOVK  X12, #0xfd5b, LSL #32
    MOVK  X12, #0xd1b4, LSL #48
    MOVZ  X13, #0x8c9b, LSL #0
    MOVK  X13, #0x2aed, LSL #16
    MOVK  X13, #0x80b1, LSL #32
    MOVK  X13, #0xa538, LSL #48
    MOVZ  X14, #0x501d, LSL #0
    MOVK  X14, #0xbbed, LSL #16
    MOVK  X14, #0xd9bd, LSL #32
    MOVK  X14, #0x30b4, LSL #48
    MOVZ  X15, #0xd511, LSL #0
    MOVK  X15, #0xaa95, LSL #16
    MOVK  X15, #0x5c85, LSL #32
    MOVK  X15, #0x55d, LSL #48
    MOVZ  X16, #0x3d15, LSL #0
    MOVK  X16, #0x4fc8, LSL #16
    MOVK  X16, #0x5756, LSL #32
    MOVK  X16, #0x9a45, LSL #48
    MOVZ  X17, #0x5e4f, LSL #0
    MOVK  X17, #0xc759, LSL #16
    MOVK  X17, #0x4e52, LSL #32
    MOVK  X17, #0x660d, LSL #48
    MOVZ  X18, #0x8f12, LSL #0
    MOVK  X18, #0x8b6b, LSL #16
    MOVK  X18, #0x5f7d, LSL #32
    MOVK  X18, #0xd1ec, LSL #48
    MOVZ  X19, #0xa7a7, LSL #0
    MOVK  X19, #0x10cb, LSL #16
    MOVK  X19, #0x566e, LSL #32
    MOVK  X19, #0x67c9, LSL #48
    MOVZ  X20, #0xe93, LSL #0
    MOVK  X20, #0x189c, LSL #16
    MOVK  X20, #0xe208, LSL #32
    MOVK  X20, #0x609c, LSL #48
    MOVZ  X21, #0x8bb3, LSL #0
    MOVK  X21, #0x50ba, LSL #16
    MOVK  X21, #0x3030, LSL #32
    MOVK  X21, #0x6a94, LSL #48
    MOVZ  X22, #0x1e25, LSL #0
    MOVK  X22, #0xa900, LSL #16
    MOVK  X22, #0xe1e7, LSL #32
    MOVK  X22, #0xd0ec, LSL #48
    MOVZ  X23, #0x2568, LSL #0
    MOVK  X23, #0xd7f5, LSL #16
    MOVK  X23, #0x5bf3, LSL #32
    MOVK  X23, #0xbadd, LSL #48
    MOVZ  X29, #0xf38e, LSL #0
    MOVK  X29, #0x74c7, LSL #16
    MOVK  X29, #0x8213, LSL #32
    MOVK  X29, #0xe7aa, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X21
    FMOV  D1, X8
    FMOV  V1.D[1], X10
    FMOV  D2, X18
    FMOV  V2.D[1], X23
    FMOV  D3, X4
    FMOV  V3.D[1], X29
    FMOV  D4, X14
    FMOV  V4.D[1], X5
    FMOV  D5, X5
    FMOV  V5.D[1], X20
    FMOV  D6, X29
    FMOV  V6.D[1], X9
    FMOV  D7, X12
    FMOV  V7.D[1], X13
    FMOV  D8, X7
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X12
    FMOV  D10, X3
    FMOV  V10.D[1], X13
    FMOV  D11, X7
    FMOV  V11.D[1], X9
    FMOV  D12, X12
    FMOV  V12.D[1], X2
    FMOV  D13, X17
    FMOV  V13.D[1], X10
    FMOV  D14, X18
    FMOV  V14.D[1], X11
    FMOV  D15, X11
    FMOV  V15.D[1], X22
    FMOV  D16, X12
    FMOV  V16.D[1], X23
    FMOV  D17, X18
    FMOV  V17.D[1], X21
    FMOV  D18, X9
    FMOV  V18.D[1], X2
    FMOV  D19, X2
    FMOV  V19.D[1], X21
    FMOV  D20, X18
    FMOV  V20.D[1], X7
    FMOV  D21, X20
    FMOV  V21.D[1], X4
    FMOV  D22, X12
    FMOV  V22.D[1], X15
    FMOV  D23, X14
    FMOV  V23.D[1], X15
    FMOV  D24, X7
    FMOV  V24.D[1], X15
    FMOV  D25, X8
    FMOV  V25.D[1], X5
    FMOV  D26, X4
    FMOV  V26.D[1], X6
    FMOV  D27, X29
    FMOV  V27.D[1], X5
    FMOV  D28, X3
    FMOV  V28.D[1], X11
    FMOV  D29, X17
    FMOV  V29.D[1], X6
    FMOV  D30, X9
    FMOV  V30.D[1], X22
    FMOV  D31, X2
    FMOV  V31.D[1], X18
    FMAX  D24, D27, D31
    FMAX  D23, D24, D18
    FMAX  D25, D14, D18
    FMAX  D6, D26, D19
    FMAX  D29, D30, D6
    FMAX  D9, D24, D15
    FMAX  D17, D25, D12
    FMAX  D13, D1, D11
    FMAX  D20, D22, D23
    FMAX  D5, D28, D28
    FMAX  S14, S9, S29
    FMAX  S27, S17, S20
    FMAX  S31, S14, S27
    FMAX  S3, S31, S5
    FMAX  S6, S0, S1
    FMAX  S30, S5, S26
    FMAX  S9, S7, S26
    FMAX  S12, S11, S19
    FMAX  S1, S31, S28
    FMAX  S26, S18, S10
    FMAXNM  D29, D29, D18
    FMAXNM  D31, D6, D12
    FMAXNM  D0, D13, D13
    FMAXNM  D8, D1, D31
    FMAXNM  D12, D29, D3
    FMAXNM  D3, D30, D14
    FMAXNM  D0, D26, D8
    FMAXNM  D27, D2, D20
    FMAXNM  D2, D19, D19
    FMAXNM  D28, D15, D8
    FMAXNM  S8, S11, S24
    FMAXNM  S14, S8, S0
    FMAXNM  S14, S27, S7
    FMAXNM  S20, S9, S12
    FMAXNM  S26, S28, S20
    FMAXNM  S1, S29, S30
    FMAXNM  S11, S23, S13
    FMAXNM  S28, S10, S26
    FMAXNM  S15, S2, S3
    FMAXNM  S22, S0, S25
    FMIN  D31, D14, D30
    FMIN  D24, D14, D28
    FMIN  D10, D22, D0
    FMIN  D20, D10, D1
    FMIN  D3, D16, D15
    FMIN  D25, D3, D20
    FMIN  D18, D25, D17
    FMIN  D6, D31, D24
    FMIN  D29, D30, D11
    FMIN  D10, D18, D21
    FMIN  S9, S29, S10
    FMIN  S1, S10, S14
    FMIN  S5, S16, S20
    FMIN  S2, S24, S7
    FMIN  S29, S2, S10
    FMIN  S23, S8, S27
    FMIN  S25, S20, S18
    FMIN  S28, S5, S19
    FMIN  S30, S25, S8
    FMIN  S21, S14, S24
    FMINNM  D14, D12, D24
    FMINNM  D24, D20, D14
    FMINNM  D11, D4, D21
    FMINNM  D5, D28, D30
    FMINNM  D25, D6, D29
    FMINNM  D15, D25, D9
    FMINNM  D10, D25, D24
    FMINNM  D26, D10, D5
    FMINNM  D25, D11, D11
    FMINNM  D12, D2, D17
    FMINNM  S9, S19, S13
    FMINNM  S27, S21, S9
    FMINNM  S18, S10, S23
    FMINNM  S13, S18, S27
    FMINNM  S17, S23, S13
    FMINNM  S19, S28, S26
    FMINNM  S26, S17, S1
    FMINNM  S25, S15, S12
    FMINNM  S4, S26, S19
    FMINNM  S24, S21, S11
    FMAX  H7, H24, H8
    FMAX  H18, H12, H26
    FMAX  H2, H27, H25
    FMAX  H1, H9, H26
    FMAX  H8, H9, H6
    FMAX  H5, H20, H1
    FMAX  H27, H16, H20
    FMAX  H26, H18, H17
    FMAX  H1, H16, H22
    FMAX  H19, H6, H22
    FMAXNM  H30, H26, H4
    FMAXNM  H0, H5, H3
    FMAXNM  H2, H14, H7
    FMAXNM  H20, H27, H29
    FMAXNM  H11, H21, H1
    FMAXNM  H21, H19, H2
    FMAXNM  H7, H6, H20
    FMAXNM  H19, H7, H18
    FMAXNM  H18, H23, H11
    FMAXNM  H4, H8, H19
    FMIN  H29, H29, H24
    FMIN  H8, H21, H21
    FMIN  H27, H18, H18
    FMIN  H14, H28, H0
    FMIN  H3, H8, H27
    FMIN  H17, H3, H30
    FMIN  H21, H2, H17
    FMIN  H22, H29, H4
    FMIN  H30, H21, H14
    FMIN  H29, H2, H4
    FMINNM  H6, H31, H29
    FMINNM  H29, H17, H9
    FMINNM  H12, H18, H23
    FMINNM  H9, H26, H30
    FMINNM  H20, H27, H8
    FMINNM  H3, H15, H30
    FMINNM  H31, H1, H24
    FMINNM  H30, H25, H16
    FMINNM  H8, H29, H12
    FMINNM  H27, H4, H8
    MOVZ  X3, #0x1ed0, LSL #0
    MOVK  X3, #0x2416, LSL #16
    MOVK  X3, #0xca8a, LSL #32
    MOVK  X3, #0x4ce1, LSL #48
    SUB  X7, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xd25d, LSL #0
    MOVK  X3, #0xf93d, LSL #16
    MOVK  X3, #0xd0c9, LSL #32
    MOVK  X3, #0x5fe6, LSL #48
    SUB  X7, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xcced, LSL #0
    MOVK  X3, #0xa81f, LSL #16
    MOVK  X3, #0xf6d9, LSL #32
    MOVK  X3, #0xd6bf, LSL #48
    SUB  X7, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xaba0, LSL #0
    MOVK  X3, #0xf4f0, LSL #16
    MOVK  X3, #0xf6f7, LSL #32
    MOVK  X3, #0xd57c, LSL #48
    SUB  X7, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x5f96, LSL #0
    MOVK  X3, #0xc07e, LSL #16
    MOVK  X3, #0xe637, LSL #32
    MOVK  X3, #0xf3f1, LSL #48
    SUB  X7, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x3ef7, LSL #0
    MOVK  X3, #0x2b50, LSL #16
    MOVK  X3, #0x9add, LSL #32
    MOVK  X3, #0xf77d, LSL #48
    SUB  X7, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x8f15, LSL #0
    MOVK  X3, #0xf874, LSL #16
    MOVK  X3, #0xcb17, LSL #32
    MOVK  X3, #0x4509, LSL #48
    SUB  X7, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x8250, LSL #0
    MOVK  X3, #0x9779, LSL #16
    MOVK  X3, #0x1837, LSL #32
    MOVK  X3, #0xb28d, LSL #48
    SUB  X7, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xbaf4, LSL #0
    MOVK  X3, #0x8c, LSL #16
    MOVK  X3, #0xfd5b, LSL #32
    MOVK  X3, #0xd1b4, LSL #48
    SUB  X7, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x8c9b, LSL #0
    MOVK  X3, #0x2aed, LSL #16
    MOVK  X3, #0x80b1, LSL #32
    MOVK  X3, #0xa538, LSL #48
    SUB  X7, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x501d, LSL #0
    MOVK  X3, #0xbbed, LSL #16
    MOVK  X3, #0xd9bd, LSL #32
    MOVK  X3, #0x30b4, LSL #48
    SUB  X7, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xd511, LSL #0
    MOVK  X3, #0xaa95, LSL #16
    MOVK  X3, #0x5c85, LSL #32
    MOVK  X3, #0x55d, LSL #48
    SUB  X7, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x3d15, LSL #0
    MOVK  X3, #0x4fc8, LSL #16
    MOVK  X3, #0x5756, LSL #32
    MOVK  X3, #0x9a45, LSL #48
    SUB  X7, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x5e4f, LSL #0
    MOVK  X3, #0xc759, LSL #16
    MOVK  X3, #0x4e52, LSL #32
    MOVK  X3, #0x660d, LSL #48
    SUB  X7, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x8f12, LSL #0
    MOVK  X3, #0x8b6b, LSL #16
    MOVK  X3, #0x5f7d, LSL #32
    MOVK  X3, #0xd1ec, LSL #48
    SUB  X7, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xa7a7, LSL #0
    MOVK  X3, #0x10cb, LSL #16
    MOVK  X3, #0x566e, LSL #32
    MOVK  X3, #0x67c9, LSL #48
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xe93, LSL #0
    MOVK  X3, #0x189c, LSL #16
    MOVK  X3, #0xe208, LSL #32
    MOVK  X3, #0x609c, LSL #48
    SUB  X7, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x8bb3, LSL #0
    MOVK  X3, #0x50ba, LSL #16
    MOVK  X3, #0x3030, LSL #32
    MOVK  X3, #0x6a94, LSL #48
    SUB  X7, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x1e25, LSL #0
    MOVK  X3, #0xa900, LSL #16
    MOVK  X3, #0xe1e7, LSL #32
    MOVK  X3, #0xd0ec, LSL #48
    SUB  X7, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xf38e, LSL #0
    MOVK  X3, #0x74c7, LSL #16
    MOVK  X3, #0x8213, LSL #32
    MOVK  X3, #0xe7aa, LSL #48
    SUB  X7, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MRS  X3, FPSR
    MOVZ  X7, #0x80, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D0
    MOVZ  X7, #0x1ed0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D4
    MOVZ  X7, #0x1ed0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D5
    MOVZ  X7, #0x1ed0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D12
    MOVZ  X7, #0x1ed0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X7, #0x2568, LSL #0
    MOVK  X7, #0xd7f5, LSL #16
    MOVK  X7, #0x5bf3, LSL #32
    MOVK  X7, #0xbadd, LSL #48
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D16
    MOVZ  X7, #0xbaf4, LSL #0
    MOVK  X7, #0x8c, LSL #16
    MOVK  X7, #0xfd5b, LSL #32
    MOVK  X7, #0xd1b4, LSL #48
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D18
    MOVZ  X7, #0x1ed0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D23
    MOVZ  X7, #0x1ed0, LSL #0
    MOVK  X7, #0x2416, LSL #16
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D30
    MOVZ  X7, #0xbaf4, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X3, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X2, #0x9d23, LSL #0
    MOVK  X2, #0xb409, LSL #16
    MOVK  X2, #0x8fcb, LSL #32
    MOVK  X2, #0xc25b, LSL #48
    MOVZ  X3, #0x115, LSL #0
    MOVK  X3, #0xc57d, LSL #16
    MOVK  X3, #0x219b, LSL #32
    MOVK  X3, #0x645c, LSL #48
    MOVZ  X4, #0xb662, LSL #0
    MOVK  X4, #0xe74f, LSL #16
    MOVK  X4, #0x7bd1, LSL #32
    MOVK  X4, #0x9216, LSL #48
    MOVZ  X5, #0x8102, LSL #0
    MOVK  X5, #0x7317, LSL #16
    MOVK  X5, #0x60a1, LSL #32
    MOVK  X5, #0xb558, LSL #48
    MOVZ  X6, #0x48d2, LSL #0
    MOVK  X6, #0x2efe, LSL #16
    MOVK  X6, #0x2c8c, LSL #32
    MOVK  X6, #0x490b, LSL #48
    MOVZ  X7, #0xa5e8, LSL #0
    MOVK  X7, #0x11a3, LSL #16
    MOVK  X7, #0xad84, LSL #32
    MOVK  X7, #0x3062, LSL #48
    MOVZ  X8, #0xbb34, LSL #0
    MOVK  X8, #0xfeb4, LSL #16
    MOVK  X8, #0x13d5, LSL #32
    MOVK  X8, #0x45ae, LSL #48
    MOVZ  X9, #0x93d4, LSL #0
    MOVK  X9, #0x2682, LSL #16
    MOVK  X9, #0x9fab, LSL #32
    MOVK  X9, #0x46b3, LSL #48
    MOVZ  X10, #0x8913, LSL #0
    MOVK  X10, #0x8f72, LSL #16
    MOVK  X10, #0x9b2b, LSL #32
    MOVK  X10, #0xcc88, LSL #48
    MOVZ  X11, #0x97c6, LSL #0
    MOVK  X11, #0x9d93, LSL #16
    MOVK  X11, #0x1be6, LSL #32
    MOVK  X11, #0x81e6, LSL #48
    MOVZ  X12, #0x83a6, LSL #0
    MOVK  X12, #0xd1b9, LSL #16
    MOVK  X12, #0x9dc, LSL #32
    MOVK  X12, #0x416e, LSL #48
    MOVZ  X13, #0x90e4, LSL #0
    MOVK  X13, #0xc56e, LSL #16
    MOVK  X13, #0xfdbb, LSL #32
    MOVK  X13, #0x50ea, LSL #48
    MOVZ  X14, #0x63d5, LSL #0
    MOVK  X14, #0x2c59, LSL #16
    MOVK  X14, #0x7817, LSL #32
    MOVK  X14, #0x3555, LSL #48
    MOVZ  X15, #0x2222, LSL #0
    MOVK  X15, #0x6b37, LSL #16
    MOVK  X15, #0xa8a, LSL #32
    MOVK  X15, #0x4d3b, LSL #48
    MOVZ  X16, #0x567d, LSL #0
    MOVK  X16, #0xe37b, LSL #16
    MOVK  X16, #0xba3f, LSL #32
    MOVK  X16, #0xcf62, LSL #48
    MOVZ  X17, #0x9d57, LSL #0
    MOVK  X17, #0x2844, LSL #16
    MOVK  X17, #0x729c, LSL #32
    MOVK  X17, #0x3ba1, LSL #48
    MOVZ  X18, #0x312, LSL #0
    MOVK  X18, #0xcb0e, LSL #16
    MOVK  X18, #0x4821, LSL #32
    MOVK  X18, #0x3325, LSL #48
    MOVZ  X19, #0x3a80, LSL #0
    MOVK  X19, #0x5d3a, LSL #16
    MOVK  X19, #0x9ad4, LSL #32
    MOVK  X19, #0x988c, LSL #48
    MOVZ  X20, #0x4b64, LSL #0
    MOVK  X20, #0xe223, LSL #16
    MOVK  X20, #0x4da3, LSL #32
    MOVK  X20, #0x9644, LSL #48
    MOVZ  X21, #0xf58, LSL #0
    MOVK  X21, #0x6729, LSL #16
    MOVK  X21, #0x1cb8, LSL #32
    MOVK  X21, #0xca31, LSL #48
    MOVZ  X22, #0xc491, LSL #0
    MOVK  X22, #0xe384, LSL #16
    MOVK  X22, #0x851a, LSL #32
    MOVK  X22, #0xdd4c, LSL #48
    MOVZ  X23, #0x6fdd, LSL #0
    MOVK  X23, #0x2b7e, LSL #16
    MOVK  X23, #0xc745, LSL #32
    MOVK  X23, #0x126d, LSL #48
    MOVZ  X29, #0x373b, LSL #0
    MOVK  X29, #0x16ff, LSL #16
    MOVK  X29, #0x243b, LSL #32
    MOVK  X29, #0x3fe, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X29
    FMOV  D1, X21
    FMOV  V1.D[1], X4
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X16
    FMOV  V3.D[1], X21
    FMOV  D4, X19
    FMOV  V4.D[1], X21
    FMOV  D5, X8
    FMOV  V5.D[1], X6
    FMOV  D6, X10
    FMOV  V6.D[1], X16
    FMOV  D7, X21
    FMOV  V7.D[1], X7
    FMOV  D8, X6
    FMOV  V8.D[1], X14
    FMOV  D9, X22
    FMOV  V9.D[1], X20
    FMOV  D10, X29
    FMOV  V10.D[1], X23
    FMOV  D11, X29
    FMOV  V11.D[1], X22
    FMOV  D12, X14
    FMOV  V12.D[1], X5
    FMOV  D13, X22
    FMOV  V13.D[1], X8
    FMOV  D14, X20
    FMOV  V14.D[1], X21
    FMOV  D15, X11
    FMOV  V15.D[1], X20
    FMOV  D16, X14
    FMOV  V16.D[1], X12
    FMOV  D17, X7
    FMOV  V17.D[1], X8
    FMOV  D18, X22
    FMOV  V18.D[1], X29
    FMOV  D19, X5
    FMOV  V19.D[1], X6
    FMOV  D20, X6
    FMOV  V20.D[1], X8
    FMOV  D21, X10
    FMOV  V21.D[1], X10
    FMOV  D22, X6
    FMOV  V22.D[1], X23
    FMOV  D23, X4
    FMOV  V23.D[1], X15
    FMOV  D24, X13
    FMOV  V24.D[1], X8
    FMOV  D25, X8
    FMOV  V25.D[1], X17
    FMOV  D26, X13
    FMOV  V26.D[1], X19
    FMOV  D27, X17
    FMOV  V27.D[1], X3
    FMOV  D28, X22
    FMOV  V28.D[1], X10
    FMOV  D29, X8
    FMOV  V29.D[1], X18
    FMOV  D30, X22
    FMOV  V30.D[1], X8
    FMOV  D31, X8
    FMOV  V31.D[1], X11
    MOVZ  X15, #0xa, LSL #0
TSRTFloatMinMax_label_0:
    FMINNM  D22, D31, D22
    FMIN  H26, H26, H30
    FMIN  S28, S26, S25
    FMAX  S5, S22, S28
    FMAXNM  D31, D9, D15
    FMAXNM  S7, S21, S7
    FMINNM  S28, S26, S29
    FMAXNM  D10, D31, D27
    FMINNM  D2, D25, D17
    FMIN  D23, D7, D10
    FMAXNM  H31, H5, H28
    FMIN  D30, D31, D14
    FMIN  D25, D23, D14
    FMAX  H9, H24, H24
    FMAX  D26, D9, D30
    FMINNM  H9, H26, H2
    FMAX  S10, S23, S20
    FMINNM  S15, S24, S16
    FMIN  S29, S24, S0
    FMINNM  D23, D11, D20
    FMAX  D27, D4, D25
    FMINNM  S21, S31, S21
    FMAXNM  D31, D7, D21
    FMAX  S28, S31, S8
    FMAX  H24, H21, H19
    FMAXNM  H20, H24, H31
    FMINNM  H0, H28, H30
    FMAXNM  S31, S4, S28
    FMAX  D10, D23, D0
    FMINNM  H23, H10, H20
    FMAX  S21, S29, S27
    FMINNM  S16, S21, S21
    FMAXNM  H14, H15, H0
    FMIN  H30, H23, H28
    FMAXNM  H8, H17, H9
    FMIN  S24, S8, S30
    FMAX  D28, D29, D16
    FMIN  S21, S24, S31
    FMINNM  S20, S28, S21
    FMINNM  H17, H21, H3
    FMAXNM  H23, H4, H24
    FMAX  H16, H7, H8
    FMAX  D8, D4, D31
    FMAX  S26, S9, S17
    FMAXNM  D31, D4, D7
    FMAX  D9, D29, D7
    FMINNM  H15, H15, H28
    FMIN  S12, S16, S16
    FMIN  S10, S23, S9
    FMIN  S7, S11, S14
    FMAXNM  S20, S10, S0
    FMAXNM  S17, S12, S12
    FMAXNM  H5, H17, H26
    FMAX  D29, D19, D21
    FMAX  S16, S31, S5
    FMIN  S10, S31, S29
    FMAX  D28, D20, D21
    FMIN  H28, H10, H15
    FMINNM  H23, H1, H13
    FMAXNM  S31, S6, S7
    FMINNM  H20, H28, H22
    FMINNM  H19, H16, H30
    FMIN  D7, D31, D23
    FMAXNM  H11, H18, H12
    FMINNM  D26, D11, D7
    FMAX  H9, H8, H19
    FMAXNM  D22, D26, D26
    FMAXNM  S21, S27, S20
    FMAX  S11, S9, S16
    FMIN  S7, S19, S16
    FMINNM  S13, S11, S22
    FMIN  D28, D26, D21
    FMAX  S24, S18, S22
    FMAXNM  S9, S9, S13
    FMIN  D22, D28, D28
    FMINNM  D23, D24, D8
    FMINNM  H1, H18, H7
    FMAXNM  S30, S9, S0
    FMIN  S24, S15, S23
    FMIN  S16, S30, S1
    FMAXNM  H19, H28, H24
    FMAXNM  D1, D22, D22
    FMIN  D26, D21, D25
    FMAX  H11, H1, H16
    FMAXNM  S13, S26, S19
    FMAXNM  D1, D18, D28
    FMAX  H19, H16, H10
    FMIN  S15, S7, S0
    FMAXNM  D23, D7, D24
    FMINNM  S18, S13, S24
    FMINNM  S25, S15, S1
    FMIN  S10, S16, S8
    FMAX  D12, D7, D16
    FMAX  H15, H0, H3
    FMAXNM  D9, D24, D5
    FMIN  H7, H10, H10
    FMAXNM  S3, S18, S12
    FMAXNM  S16, S15, S25
    FMAX  H26, H6, H7
    FMINNM  D4, D19, D16
    FMIN  H13, H3, H26
    FMIN  D19, D11, D11
    FMIN  H24, H23, H10
    FMINNM  H10, H31, H19
    FMIN  H5, H4, H10
    FMINNM  H0, H16, H9
    FMAX  S21, S5, S2
    FMAXNM  D7, D18, D16
    FMINNM  S11, S24, S13
    FMIN  D10, D11, D20
    FMIN  D15, D6, D10
    FMIN  H25, H21, H21
    FMAX  H1, H7, H7
    FMAX  S9, S25, S21
    FMINNM  D20, D0, D0
    FMIN  D25, D5, D1
    FMINNM  S10, S18, S10
    FMAX  D5, D20, D3
    FMINNM  H7, H15, H15
    FMAXNM  H22, H18, H9
    FMIN  S8, S14, S22
    FMINNM  D0, D2, D24
    FMAXNM  H24, H8, H7
    FMIN  S8, S20, S1
    FMAX  H29, H25, H24
    FMIN  S20, S10, S10
    FMAX  D24, D14, D20
    FMAXNM  S25, S0, S8
    FMINNM  H3, H25, H5
    FMAXNM  H26, H29, H29
    FMIN  S25, S20, S24
    FMAX  D21, D9, D26
    FMIN  D2, D20, D25
    FMAXNM  S9, S29, S2
    FMINNM  D15, D14, D21
    FMAXNM  D22, D15, D26
    FMIN  S25, S30, S9
    FMAXNM  H18, H5, H3
    FMAX  D24, D0, D22
    FMAXNM  D2, D24, D18
    FMIN  D18, D14, D1
    FMAX  H24, H30, H7
    FMIN  D7, D30, D28
    FMIN  H25, H13, H22
    FMIN  S30, S18, S27
    FMINNM  H23, H10, H26
    FMAX  S25, S13, S26
    FMAX  D20, D16, D20
    FMINNM  D3, D1, D17
    FMAX  H0, H0, H7
    FMIN  S27, S6, S6
    FMINNM  D8, D20, D3
    FMAXNM  H26, H4, H0
    FMIN  D21, D26, D23
    FMAXNM  S25, S2, S13
    FMIN  H22, H22, H24
    FMIN  D18, D30, D8
    FMINNM  S8, S25, S27
    FMINNM  H11, H10, H28
    FMIN  H30, H18, H11
    FMINNM  H14, H2, H30
    FMINNM  H7, H22, H26
    FMIN  D24, D29, D8
    FMAX  H2, H7, H26
    FMIN  D29, D26, D1
    FMAXNM  H3, H24, H14
    FMINNM  D28, D8, D27
    FMINNM  S1, S2, S29
    FMINNM  H21, H1, H3
    FMAX  S22, S21, S21
    FMIN  H20, H31, H20
    FMAXNM  S2, S20, S31
    FMIN  S25, S23, S2
    FMINNM  H21, H13, H4
    FMIN  H24, H23, H4
    FMAXNM  H10, H14, H28
    FMINNM  S9, S30, S11
    FMIN  H4, H3, H28
    FMAX  S20, S5, S29
    FMAXNM  D0, D12, D29
    FMAX  D28, D6, D10
    FMINNM  D27, D21, D20
    FMINNM  D5, D23, D4
    FMAX  H2, H27, H27
    FMAX  H4, H28, H5
    FMINNM  S10, S9, S12
    FMAXNM  D3, D24, D10
    FMIN  S14, S2, S4
    FMAX  D12, D10, D0
    FMAX  S27, S27, S9
    FMIN  S29, S25, S27
    FMIN  S13, S18, S14
    FMAX  D6, D29, D29
    FMIN  S18, S3, S22
    FMIN  H28, H18, H24
    FMINNM  S6, S13, S28
    FMINNM  H14, H25, H12
    FMAX  H10, H23, H17
    FMINNM  D30, D6, D17
    FMIN  H23, H24, H14
    SUBS  X15, X15, #0x1
    B.NE  TSRTFloatMinMax_label_0
    MOVZ  X29, #0x9d23, LSL #0
    MOVK  X29, #0xb409, LSL #16
    MOVK  X29, #0x8fcb, LSL #32
    MOVK  X29, #0xc25b, LSL #48
    SUB  X9, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x115, LSL #0
    MOVK  X29, #0xc57d, LSL #16
    MOVK  X29, #0x219b, LSL #32
    MOVK  X29, #0x645c, LSL #48
    SUB  X9, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xb662, LSL #0
    MOVK  X29, #0xe74f, LSL #16
    MOVK  X29, #0x7bd1, LSL #32
    MOVK  X29, #0x9216, LSL #48
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x8102, LSL #0
    MOVK  X29, #0x7317, LSL #16
    MOVK  X29, #0x60a1, LSL #32
    MOVK  X29, #0xb558, LSL #48
    SUB  X9, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x48d2, LSL #0
    MOVK  X29, #0x2efe, LSL #16
    MOVK  X29, #0x2c8c, LSL #32
    MOVK  X29, #0x490b, LSL #48
    SUB  X9, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xa5e8, LSL #0
    MOVK  X29, #0x11a3, LSL #16
    MOVK  X29, #0xad84, LSL #32
    MOVK  X29, #0x3062, LSL #48
    SUB  X9, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xbb34, LSL #0
    MOVK  X29, #0xfeb4, LSL #16
    MOVK  X29, #0x13d5, LSL #32
    MOVK  X29, #0x45ae, LSL #48
    SUB  X9, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x8913, LSL #0
    MOVK  X29, #0x8f72, LSL #16
    MOVK  X29, #0x9b2b, LSL #32
    MOVK  X29, #0xcc88, LSL #48
    SUB  X9, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x83a6, LSL #0
    MOVK  X29, #0xd1b9, LSL #16
    MOVK  X29, #0x9dc, LSL #32
    MOVK  X29, #0x416e, LSL #48
    SUB  X9, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x90e4, LSL #0
    MOVK  X29, #0xc56e, LSL #16
    MOVK  X29, #0xfdbb, LSL #32
    MOVK  X29, #0x50ea, LSL #48
    SUB  X9, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x63d5, LSL #0
    MOVK  X29, #0x2c59, LSL #16
    MOVK  X29, #0x7817, LSL #32
    MOVK  X29, #0x3555, LSL #48
    SUB  X9, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x567d, LSL #0
    MOVK  X29, #0xe37b, LSL #16
    MOVK  X29, #0xba3f, LSL #32
    MOVK  X29, #0xcf62, LSL #48
    SUB  X9, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x9d57, LSL #0
    MOVK  X29, #0x2844, LSL #16
    MOVK  X29, #0x729c, LSL #32
    MOVK  X29, #0x3ba1, LSL #48
    SUB  X9, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x312, LSL #0
    MOVK  X29, #0xcb0e, LSL #16
    MOVK  X29, #0x4821, LSL #32
    MOVK  X29, #0x3325, LSL #48
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x3a80, LSL #0
    MOVK  X29, #0x5d3a, LSL #16
    MOVK  X29, #0x9ad4, LSL #32
    MOVK  X29, #0x988c, LSL #48
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x4b64, LSL #0
    MOVK  X29, #0xe223, LSL #16
    MOVK  X29, #0x4da3, LSL #32
    MOVK  X29, #0x9644, LSL #48
    SUB  X9, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xf58, LSL #0
    MOVK  X29, #0x6729, LSL #16
    MOVK  X29, #0x1cb8, LSL #32
    MOVK  X29, #0xca31, LSL #48
    SUB  X9, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xc491, LSL #0
    MOVK  X29, #0xe384, LSL #16
    MOVK  X29, #0x851a, LSL #32
    MOVK  X29, #0xdd4c, LSL #48
    SUB  X9, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x6fdd, LSL #0
    MOVK  X29, #0x2b7e, LSL #16
    MOVK  X29, #0xc745, LSL #32
    MOVK  X29, #0x126d, LSL #48
    SUB  X9, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MRS  X29, FPSR
    MOVZ  X9, #0x80, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
    FMOV  X29, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMinMax_TestFail
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
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X19
    FMOV  V0.D[1], X13
    FMOV  D1, X7
    FMOV  V1.D[1], X21
    FMOV  D2, X11
    FMOV  V2.D[1], X16
    FMOV  D3, X12
    FMOV  V3.D[1], X23
    FMOV  D4, X6
    FMOV  V4.D[1], X3
    FMOV  D5, X29
    FMOV  V5.D[1], X18
    FMOV  D6, X20
    FMOV  V6.D[1], X22
    FMOV  D7, X29
    FMOV  V7.D[1], X14
    FMOV  D8, X12
    FMOV  V8.D[1], X7
    FMOV  D9, X20
    FMOV  V9.D[1], X10
    FMOV  D10, X16
    FMOV  V10.D[1], X16
    FMOV  D11, X14
    FMOV  V11.D[1], X13
    FMOV  D12, X4
    FMOV  V12.D[1], X11
    FMOV  D13, X23
    FMOV  V13.D[1], X10
    FMOV  D14, X20
    FMOV  V14.D[1], X29
    FMOV  D15, X20
    FMOV  V15.D[1], X7
    FMOV  D16, X7
    FMOV  V16.D[1], X13
    FMOV  D17, X29
    FMOV  V17.D[1], X18
    FMOV  D18, X11
    FMOV  V18.D[1], X11
    FMOV  D19, X15
    FMOV  V19.D[1], X16
    FMOV  D20, X4
    FMOV  V20.D[1], X19
    FMOV  D21, X13
    FMOV  V21.D[1], X20
    FMOV  D22, X5
    FMOV  V22.D[1], X5
    FMOV  D23, X14
    FMOV  V23.D[1], X9
    FMOV  D24, X17
    FMOV  V24.D[1], X5
    FMOV  D25, X23
    FMOV  V25.D[1], X21
    FMOV  D26, X15
    FMOV  V26.D[1], X29
    FMOV  D27, X4
    FMOV  V27.D[1], X8
    FMOV  D28, X16
    FMOV  V28.D[1], X18
    FMOV  D29, X6
    FMOV  V29.D[1], X23
    FMOV  D30, X5
    FMOV  V30.D[1], X17
    FMOV  D31, X13
    FMOV  V31.D[1], X18
    MOVZ  X3, #0xa, LSL #0
TSRTFloatMinMax_label_1:
    FMAXNM  H25, H24, H16
    FMAX  D23, D25, D29
    FMAXNM  H22, H28, H26
    FMAXNM  H28, H30, H31
    FMINNM  H2, H10, H28
    FMAX  D12, D2, D5
    FMAXNM  S1, S20, S2
    FMAXNM  H16, H27, H1
    FMIN  D14, D24, D10
    FMAXNM  S3, S12, S23
    FMINNM  D28, D16, D20
    FMIN  H27, H28, H3
    FMAXNM  H26, H14, H22
    FMIN  H29, H22, H12
    FMIN  D3, D25, D20
    FMAX  S11, S30, S11
    FMINNM  D27, D8, D14
    FMIN  H12, H21, H23
    FMINNM  S19, S21, S22
    FMIN  D2, D9, D25
    FMINNM  H10, H26, H5
    FMIN  H9, H30, H20
    FMINNM  S25, S27, S12
    FMINNM  S26, S11, S3
    FMINNM  S8, S1, S2
    FMAXNM  S24, S26, S12
    FMINNM  H2, H4, H19
    FMAX  H21, H24, H23
    FMIN  D22, D10, D21
    FMAX  D2, D29, D29
    FMINNM  D31, D9, D2
    FMIN  S1, S8, S25
    FMAXNM  D27, D1, D11
    FMIN  H19, H22, H25
    FMAX  H23, H27, H14
    FMIN  D29, D31, D19
    FMAXNM  H2, H5, H5
    FMINNM  S31, S0, S25
    FMAX  D1, D12, D20
    FMAX  D19, D17, D10
    FMINNM  H0, H12, H5
    FMIN  S9, S10, S26
    FMINNM  D30, D2, D7
    FMAX  S24, S9, S11
    FMAX  H3, H4, H8
    FMAXNM  H17, H1, H22
    FMINNM  D5, D19, D23
    FMAXNM  H25, H0, H29
    FMAX  S29, S30, S25
    FMAX  D12, D3, D12
    FMINNM  S5, S17, S12
    FMIN  H25, H7, H21
    FMINNM  D14, D31, D24
    FMAX  S21, S29, S25
    FMAXNM  S26, S21, S13
    FMAXNM  H23, H22, H27
    FMIN  S0, S5, S5
    FMINNM  S12, S8, S30
    FMAXNM  S11, S12, S4
    FMAX  H22, H14, H23
    FMINNM  H7, H6, H25
    FMAXNM  S10, S14, S26
    FMINNM  H2, H0, H22
    FMAX  D20, D2, D10
    FMAXNM  S5, S10, S9
    FMIN  H12, H20, H16
    FMIN  H5, H1, H5
    FMAXNM  S17, S5, S7
    FMINNM  S21, S11, S18
    FMAX  H18, H4, H25
    FMIN  S18, S22, S21
    FMIN  S7, S27, S18
    FMAXNM  S26, S22, S7
    FMAXNM  H3, H12, H17
    FMAXNM  D19, D1, D9
    FMAXNM  H6, H22, H26
    FMAX  H7, H22, H5
    FMINNM  S11, S6, S8
    FMINNM  H14, H2, H3
    FMAX  D26, D28, D6
    FMAXNM  H10, H20, H6
    FMINNM  D0, D5, D31
    FMINNM  S25, S16, S27
    FMIN  S4, S25, S6
    FMAXNM  H20, H12, H24
    FMIN  S28, S26, S0
    FMINNM  D3, D11, D11
    FMIN  D11, D20, D4
    FMIN  H23, H27, H28
    FMAX  S9, S18, S24
    FMINNM  S8, S11, S3
    FMIN  H27, H7, H7
    FMIN  D24, D10, D23
    FMAX  S7, S27, S9
    FMIN  H25, H25, H19
    FMAXNM  H21, H25, H13
    FMIN  S8, S30, S18
    FMAXNM  D1, D30, D8
    FMAXNM  H3, H21, H7
    FMAXNM  S6, S24, S24
    FMAX  D16, D13, D2
    FMIN  D7, D6, D28
    FMIN  D15, D1, D1
    FMIN  D30, D15, D21
    FMAX  S23, S30, S7
    FMIN  D0, D23, D14
    FMAXNM  D6, D16, D20
    FMAXNM  D8, D6, D30
    FMIN  H9, H0, H0
    FMAXNM  H23, H8, H13
    FMIN  H25, H23, H23
    FMAX  S21, S25, S3
    FMAXNM  H3, H29, H21
    FMIN  H2, H12, H7
    FMAXNM  H3, H10, H21
    FMAXNM  S8, S24, S0
    FMAXNM  D30, D3, D20
    FMINNM  S27, S29, S22
    FMINNM  S14, S30, S21
    FMIN  D6, D31, D19
    FMINNM  H28, H18, H2
    FMIN  H13, H25, H7
    FMIN  S30, S12, S28
    FMIN  H30, H2, H2
    FMAXNM  D2, D6, D25
    FMIN  D8, D6, D28
    FMINNM  S2, S7, S9
    FMAX  S20, S20, S26
    FMIN  H28, H4, H18
    FMAXNM  D15, D24, D12
    FMAX  S19, S8, S3
    FMINNM  S25, S23, S6
    FMIN  D16, D2, D2
    FMIN  S12, S26, S28
    FMAXNM  S8, S12, S20
    FMAXNM  H10, H27, H27
    FMIN  D12, D8, D13
    FMIN  S26, S15, S18
    FMIN  H13, H16, H9
    FMINNM  D31, D14, D10
    FMINNM  H21, H13, H12
    FMINNM  H6, H5, H25
    FMAXNM  H3, H20, H30
    FMIN  S12, S6, S9
    FMAX  D7, D14, D26
    FMINNM  H29, H12, H26
    FMAX  S1, S21, S29
    FMAXNM  H26, H31, H3
    FMAXNM  S2, S1, S19
    FMAX  D28, D7, D13
    FMINNM  H30, H26, H16
    FMAX  H14, H28, H28
    FMAXNM  S3, S14, S14
    FMAX  S20, S0, S30
    FMINNM  S21, S2, S28
    FMINNM  S23, S1, S21
    FMAXNM  S29, S24, S23
    FMINNM  H6, H20, H29
    FMAX  S20, S29, S31
    FMINNM  S12, S22, S7
    FMINNM  H19, H23, H14
    FMAX  S28, S7, S12
    FMINNM  S11, S6, S30
    FMAX  H23, H15, H2
    FMIN  S2, S29, S11
    FMIN  S31, S11, S1
    FMIN  D29, D20, D31
    FMIN  D20, D24, D14
    FMAX  H22, H19, H4
    FMAXNM  D6, D30, D15
    FMINNM  D12, D7, D12
    FMAXNM  D0, D29, D28
    FMAX  H13, H20, H2
    FMAXNM  S31, S27, S24
    FMIN  D7, D31, D4
    FMAXNM  D28, D22, D7
    FMIN  S4, S8, S6
    FMIN  H8, H13, H13
    FMAXNM  S1, S3, S28
    FMIN  H24, H14, H7
    FMIN  S3, S4, S18
    FMAXNM  D29, D12, D3
    FMAX  S15, S18, S8
    FMIN  S21, S24, S24
    FMAXNM  D6, D15, D21
    FMAX  H30, H0, H10
    FMAX  D18, D9, D1
    FMAXNM  S9, S30, S30
    FMAXNM  S4, S17, S18
    FMAX  S3, S9, S28
    FMAX  S19, S20, S14
    FMAX  S21, S23, S30
    FMIN  H7, H19, H4
    FMAXNM  H14, H21, H6
    FMINNM  D21, D4, D3
    FMAXNM  H22, H25, H28
    FMAX  S31, S29, S14
    FMINNM  D25, D19, D22
    FMAXNM  D1, D0, D11
    FMAX  D6, D21, D29
    SUBS  X3, X3, #0x1
    B.NE  TSRTFloatMinMax_label_1
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MRS  X19, FPSR
    MOVZ  X7, #0x80, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    FMOV  X19, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X20
    FMOV  D1, X22
    FMOV  V1.D[1], X22
    FMOV  D2, X13
    FMOV  V2.D[1], X14
    FMOV  D3, X12
    FMOV  V3.D[1], X2
    FMOV  D4, X29
    FMOV  V4.D[1], X7
    FMOV  D5, X18
    FMOV  V5.D[1], X23
    FMOV  D6, X23
    FMOV  V6.D[1], X20
    FMOV  D7, X9
    FMOV  V7.D[1], X12
    FMOV  D8, X23
    FMOV  V8.D[1], X7
    FMOV  D9, X12
    FMOV  V9.D[1], X6
    FMOV  D10, X10
    FMOV  V10.D[1], X13
    FMOV  D11, X12
    FMOV  V11.D[1], X4
    FMOV  D12, X23
    FMOV  V12.D[1], X5
    FMOV  D13, X7
    FMOV  V13.D[1], X23
    FMOV  D14, X12
    FMOV  V14.D[1], X4
    FMOV  D15, X14
    FMOV  V15.D[1], X21
    FMOV  D16, X19
    FMOV  V16.D[1], X8
    FMOV  D17, X12
    FMOV  V17.D[1], X23
    FMOV  D18, X11
    FMOV  V18.D[1], X3
    FMOV  D19, X9
    FMOV  V19.D[1], X22
    FMOV  D20, X21
    FMOV  V20.D[1], X4
    FMOV  D21, X5
    FMOV  V21.D[1], X23
    FMOV  D22, X21
    FMOV  V22.D[1], X20
    FMOV  D23, X19
    FMOV  V23.D[1], X7
    FMOV  D24, X2
    FMOV  V24.D[1], X3
    FMOV  D25, X14
    FMOV  V25.D[1], X2
    FMOV  D26, X16
    FMOV  V26.D[1], X10
    FMOV  D27, X7
    FMOV  V27.D[1], X23
    FMOV  D28, X15
    FMOV  V28.D[1], X9
    FMOV  D29, X22
    FMOV  V29.D[1], X18
    FMOV  D30, X20
    FMOV  V30.D[1], X8
    FMOV  D31, X10
    FMOV  V31.D[1], X6
    MOVZ  X17, #0xa, LSL #0
TSRTFloatMinMax_label_2:
    FMINNM  H20, H22, H29
    FMIN  D9, D28, D23
    FMIN  D13, D31, D31
    FMAXNM  D14, D9, D26
    FMIN  S3, S10, S13
    FMINNM  S29, S5, S3
    FMIN  H10, H24, H24
    FMAXNM  D18, D19, D5
    FMIN  S1, S14, S10
    FMINNM  H3, H29, H31
    FMAXNM  S12, S1, S25
    FMIN  D9, D17, D18
    FMAXNM  D7, D30, D9
    FMINNM  D23, D27, D3
    FMINNM  S30, S23, S24
    FMINNM  D22, D6, D7
    FMINNM  S5, S12, S30
    FMIN  S14, S22, S22
    FMIN  H16, H14, H5
    FMAX  S27, S25, S9
    FMINNM  S6, S14, S21
    FMAX  S25, S30, S29
    FMAXNM  D29, D7, D22
    FMAXNM  H26, H12, H21
    FMIN  D9, D14, D28
    FMINNM  H10, H13, H29
    FMIN  D28, D7, D19
    FMINNM  D14, D26, D6
    FMAX  H6, H15, H15
    FMINNM  S16, S14, S9
    FMAXNM  H21, H19, H16
    FMAX  S13, S31, S13
    FMIN  D5, D25, D10
    FMIN  H19, H19, H5
    FMAX  S22, S6, S9
    FMAX  D7, D12, D13
    FMIN  D23, D28, D21
    FMAXNM  H14, H19, H6
    FMAXNM  D7, D27, D23
    FMINNM  D31, D22, D22
    FMAX  D13, D7, D14
    FMINNM  H23, H18, H23
    FMAX  D5, D13, D11
    FMIN  H28, H0, H21
    FMIN  D0, D7, D20
    FMAXNM  H13, H3, H31
    FMIN  D10, D7, D13
    FMAX  H22, H8, H31
    FMAX  H21, H4, H5
    FMIN  S29, S24, S11
    FMINNM  S9, S9, S16
    FMIN  S7, S15, S7
    FMAXNM  S18, S23, S28
    FMAXNM  S14, S29, S8
    FMIN  D5, D21, D1
    FMIN  D19, D0, D25
    FMAXNM  H15, H22, H10
    FMIN  S7, S12, S14
    FMIN  H20, H15, H19
    FMINNM  D11, D18, D20
    FMIN  S26, S1, S7
    FMAX  S8, S11, S12
    FMIN  S16, S11, S5
    FMAX  H19, H24, H16
    FMAXNM  D25, D8, D8
    FMAXNM  H18, H9, H5
    FMAX  S27, S7, S18
    FMIN  H31, H31, H15
    FMINNM  S8, S3, S28
    FMAX  H12, H7, H31
    FMAX  D2, D8, D8
    FMAXNM  H29, H25, H19
    FMAX  H23, H27, H26
    FMINNM  S7, S2, S29
    FMINNM  S0, S10, S20
    FMAX  D14, D12, D20
    FMAXNM  D4, D14, D4
    FMINNM  D18, D23, D0
    FMIN  D3, D18, D18
    FMAXNM  H10, H18, H1
    FMINNM  H9, H21, H3
    FMIN  D8, D13, D11
    FMINNM  D23, D19, D9
    FMIN  H0, H4, H21
    FMIN  S1, S31, S5
    FMIN  S11, S0, S2
    FMAX  S25, S19, S1
    FMIN  D9, D23, D22
    FMAXNM  S28, S25, S7
    FMINNM  D29, D19, D8
    FMIN  D5, D11, D9
    FMINNM  S27, S10, S29
    FMINNM  D1, D8, D5
    FMIN  S25, S1, S9
    FMAX  H21, H17, H8
    FMAXNM  S4, S12, S21
    FMAXNM  S13, S4, S4
    FMAX  S18, S8, S17
    FMIN  S1, S25, S27
    FMAXNM  H31, H1, H13
    FMAX  H26, H31, H31
    FMAX  D11, D16, D26
    FMAX  H25, H3, H11
    FMINNM  H1, H23, H18
    FMINNM  S18, S23, S3
    FMIN  S5, S4, S25
    FMAX  H19, H28, H28
    FMAXNM  H16, H18, H18
    FMAXNM  H7, H5, H25
    FMINNM  S10, S7, S1
    FMIN  H28, H10, H16
    FMAX  H18, H8, H21
    FMIN  H5, H4, H6
    FMIN  D30, D19, D20
    FMIN  D10, D17, D28
    FMAXNM  D16, D31, D22
    FMINNM  H25, H20, H6
    FMINNM  S12, S6, S25
    FMINNM  S21, S5, S4
    FMIN  H29, H26, H2
    FMINNM  H20, H26, H26
    FMIN  S26, S7, S15
    FMIN  H25, H16, H18
    FMIN  H19, H29, H14
    FMAX  H13, H20, H19
    FMIN  D28, D13, D26
    FMAXNM  H18, H25, H14
    FMIN  H1, H28, H9
    FMAXNM  H31, H16, H30
    FMIN  H29, H21, H21
    FMAXNM  H7, H29, H15
    FMAXNM  D19, D28, D7
    FMINNM  S26, S7, S10
    FMAXNM  H17, H1, H19
    FMAXNM  D20, D14, D28
    FMIN  S16, S3, S20
    FMINNM  S25, S17, S16
    FMAXNM  D5, D12, D18
    FMAXNM  D13, D5, D26
    FMAXNM  S29, S25, S31
    FMINNM  D27, D1, D12
    FMAXNM  S19, S18, S4
    FMIN  D21, D21, D3
    FMIN  H17, H18, H9
    FMIN  S1, S18, S9
    FMAX  H12, H15, H30
    FMINNM  D10, D17, D5
    FMIN  D7, D14, D19
    FMAX  D28, D8, D15
    FMINNM  S3, S28, S4
    FMAX  H16, H12, H21
    FMAX  S5, S10, S29
    FMAX  D19, D27, D24
    FMINNM  H9, H26, H13
    FMIN  S30, S5, S5
    FMINNM  H28, H16, H30
    FMAX  H8, H31, H5
    FMIN  D4, D24, D19
    FMAXNM  H29, H0, H28
    FMAX  D12, D5, D1
    FMIN  D22, D12, D7
    FMAX  S3, S12, S9
    FMAXNM  S31, S22, S23
    FMINNM  H14, H10, H2
    FMINNM  D17, D29, D8
    FMAXNM  S24, S5, S21
    FMAX  H9, H6, H14
    FMINNM  S7, S29, S3
    FMAX  S27, S15, S9
    FMAXNM  D6, D7, D4
    FMIN  D1, D6, D31
    FMAXNM  D14, D27, D19
    FMAXNM  D22, D1, D15
    FMINNM  S15, S17, S14
    FMINNM  S18, S1, S15
    FMAX  H12, H24, H18
    FMIN  D19, D0, D3
    FMIN  S6, S29, S7
    FMAXNM  D16, D14, D28
    FMAXNM  S21, S21, S6
    FMAX  D18, D0, D14
    FMINNM  D2, D18, D13
    FMAXNM  D14, D25, D3
    FMAXNM  S27, S20, S10
    FMAX  S28, S29, S16
    FMIN  H6, H9, H14
    FMINNM  S3, S26, S2
    FMINNM  S17, S29, S13
    FMAXNM  D17, D29, D3
    FMAXNM  S3, S28, S4
    FMAXNM  S0, S0, S12
    FMIN  S29, S3, S22
    FMAX  S2, S21, S13
    FMAX  H12, H6, H0
    FMAXNM  H16, H5, H12
    FMAX  H15, H17, H27
    FMIN  D9, D2, D30
    FMAXNM  S20, S22, S29
    FMINNM  D13, D15, D16
    FMAXNM  D24, D20, D20
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatMinMax_label_2
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MRS  X20, FPSR
    MOVZ  X2, #0x80, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    FMOV  X20, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
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
    FMOV  V0.D[1], X22
    FMOV  D1, X21
    FMOV  V1.D[1], X15
    FMOV  D2, X2
    FMOV  V2.D[1], X22
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X6
    FMOV  V4.D[1], X10
    FMOV  D5, X4
    FMOV  V5.D[1], X7
    FMOV  D6, X7
    FMOV  V6.D[1], X21
    FMOV  D7, X12
    FMOV  V7.D[1], X4
    FMOV  D8, X21
    FMOV  V8.D[1], X13
    FMOV  D9, X14
    FMOV  V9.D[1], X29
    FMOV  D10, X21
    FMOV  V10.D[1], X6
    FMOV  D11, X10
    FMOV  V11.D[1], X10
    FMOV  D12, X12
    FMOV  V12.D[1], X5
    FMOV  D13, X5
    FMOV  V13.D[1], X29
    FMOV  D14, X23
    FMOV  V14.D[1], X11
    FMOV  D15, X20
    FMOV  V15.D[1], X12
    FMOV  D16, X21
    FMOV  V16.D[1], X3
    FMOV  D17, X29
    FMOV  V17.D[1], X9
    FMOV  D18, X7
    FMOV  V18.D[1], X16
    FMOV  D19, X11
    FMOV  V19.D[1], X12
    FMOV  D20, X11
    FMOV  V20.D[1], X9
    FMOV  D21, X3
    FMOV  V21.D[1], X17
    FMOV  D22, X11
    FMOV  V22.D[1], X2
    FMOV  D23, X11
    FMOV  V23.D[1], X15
    FMOV  D24, X11
    FMOV  V24.D[1], X15
    FMOV  D25, X3
    FMOV  V25.D[1], X21
    FMOV  D26, X21
    FMOV  V26.D[1], X4
    FMOV  D27, X20
    FMOV  V27.D[1], X2
    FMOV  D28, X20
    FMOV  V28.D[1], X5
    FMOV  D29, X14
    FMOV  V29.D[1], X20
    FMOV  D30, X5
    FMOV  V30.D[1], X9
    FMOV  D31, X22
    FMOV  V31.D[1], X4
    MOVZ  X18, #0xa, LSL #0
TSRTFloatMinMax_label_3:
    FMAXNM  D4, D29, D28
    FMINNM  S23, S20, S30
    FMIN  S9, S16, S14
    FMAXNM  H0, H9, H26
    FMAX  H14, H0, H6
    FMIN  H29, H23, H4
    FMINNM  D3, D14, D31
    FMAXNM  H30, H27, H3
    FMAXNM  D4, D13, D6
    FMIN  H2, H29, H30
    FMAXNM  D3, D17, D11
    FMAX  H20, H7, H17
    FMAXNM  S0, S17, S20
    FMAX  S10, S7, S20
    FMINNM  H13, H0, H3
    FMAX  S26, S10, S25
    FMIN  D7, D7, D2
    FMIN  D17, D12, D13
    FMINNM  S13, S12, S28
    FMAX  S9, S31, S7
    FMAXNM  H23, H17, H4
    FMINNM  H20, H31, H23
    FMIN  H11, H27, H21
    FMAXNM  H28, H11, H11
    FMINNM  H15, H20, H22
    FMINNM  H14, H25, H13
    FMAXNM  S2, S17, S13
    FMAX  D30, D14, D9
    FMINNM  H20, H28, H2
    FMAXNM  H28, H9, H6
    FMIN  S11, S15, S28
    FMIN  S6, S20, S11
    FMAXNM  H7, H27, H21
    FMAX  D5, D3, D6
    FMIN  S11, S30, S30
    FMAX  S10, S12, S5
    FMINNM  D21, D29, D29
    FMINNM  D15, D23, D7
    FMAXNM  H31, H21, H26
    FMAX  D20, D4, D11
    FMINNM  D11, D16, D15
    FMAXNM  S2, S27, S31
    FMAX  H0, H10, H1
    FMAXNM  H17, H5, H20
    FMIN  H5, H17, H2
    FMAXNM  S20, S5, S10
    FMIN  S19, S16, S20
    FMINNM  D14, D19, D0
    FMINNM  S16, S4, S0
    FMAX  D19, D30, D18
    FMAX  D9, D2, D2
    FMAXNM  D22, D19, D2
    FMAXNM  H27, H21, H27
    FMAX  D2, D15, D3
    FMINNM  H0, H11, H31
    FMAX  D19, D18, D7
    FMAX  D29, D26, D6
    FMINNM  H5, H27, H27
    FMIN  D1, D22, D22
    FMAXNM  H7, H15, H1
    FMINNM  S10, S19, S29
    FMINNM  S6, S5, S7
    FMIN  D27, D6, D6
    FMAX  D0, D16, D14
    FMAXNM  D30, D27, D27
    FMAX  S29, S17, S30
    FMAX  H26, H9, H19
    FMINNM  S15, S10, S0
    FMAX  D7, D15, D15
    FMAXNM  D18, D7, D29
    FMINNM  D17, D18, D26
    FMAX  D21, D12, D7
    FMINNM  D27, D18, D23
    FMINNM  D23, D1, D5
    FMAX  S16, S30, S16
    FMAX  H18, H1, H6
    FMAX  H19, H0, H23
    FMIN  S1, S4, S20
    FMAXNM  S7, S2, S18
    FMIN  S21, S30, S24
    FMAX  D22, D12, D31
    FMINNM  H4, H16, H13
    FMINNM  D13, D24, D3
    FMIN  D30, D0, D17
    FMINNM  S16, S13, S4
    FMIN  D15, D9, D22
    FMIN  S23, S21, S12
    FMAX  S14, S30, S1
    FMAX  S21, S16, S13
    FMAX  S7, S19, S15
    FMIN  S29, S7, S11
    FMAX  S20, S26, S29
    FMINNM  S31, S27, S27
    FMINNM  D3, D21, D14
    FMAXNM  H4, H3, H23
    FMINNM  H6, H10, H20
    FMIN  S22, S4, S15
    FMAXNM  H1, H22, H22
    FMAX  H17, H19, H1
    FMAX  H7, H6, H17
    FMIN  D16, D22, D16
    FMAX  D13, D11, D30
    FMIN  S22, S13, S5
    FMIN  S8, S0, S12
    FMINNM  S20, S4, S19
    FMAXNM  D13, D2, D8
    FMINNM  H10, H24, H23
    FMAXNM  H17, H19, H15
    FMAXNM  D5, D29, D11
    FMAXNM  S11, S17, S20
    FMAXNM  S15, S22, S5
    FMAX  H22, H16, H10
    FMAX  D17, D12, D9
    FMINNM  S26, S7, S11
    FMAXNM  S1, S26, S15
    FMAX  D7, D17, D22
    FMINNM  D6, D17, D29
    FMAX  S12, S13, S4
    FMIN  H5, H12, H31
    FMAX  D13, D7, D7
    FMIN  H30, H31, H6
    FMINNM  H31, H5, H1
    FMAX  S2, S22, S28
    FMIN  D11, D29, D29
    FMINNM  S23, S11, S30
    FMAX  H16, H0, H23
    FMIN  H4, H12, H31
    FMAXNM  H0, H2, H4
    FMINNM  S7, S13, S13
    FMAX  S29, S28, S7
    FMAXNM  H2, H0, H16
    FMINNM  H5, H29, H9
    FMAX  H24, H13, H1
    FMINNM  S15, S23, S21
    FMAX  H1, H8, H24
    FMAXNM  S6, S24, S21
    FMINNM  H7, H30, H15
    FMINNM  S17, S8, S1
    FMAXNM  S13, S20, S21
    FMAXNM  H22, H18, H14
    FMINNM  H21, H29, H2
    FMIN  H2, H26, H0
    FMIN  S26, S29, S14
    FMIN  S4, S1, S17
    FMINNM  H31, H26, H22
    FMAXNM  D15, D2, D31
    FMINNM  H30, H7, H13
    FMAX  D8, D29, D9
    FMIN  S12, S5, S30
    FMIN  S29, S4, S15
    FMIN  S13, S18, S21
    FMINNM  D5, D29, D13
    FMAXNM  S28, S5, S31
    FMAXNM  D14, D30, D3
    FMINNM  S23, S6, S6
    FMAXNM  H24, H14, H28
    FMIN  S18, S6, S12
    FMIN  S18, S8, S24
    FMINNM  S2, S0, S10
    FMIN  H22, H18, H18
    FMAXNM  D15, D23, D23
    FMAX  H7, H7, H21
    FMAX  S10, S7, S7
    FMIN  H30, H2, H2
    FMAX  S19, S17, S30
    FMINNM  S30, S21, S12
    FMINNM  S12, S10, S30
    FMAXNM  H8, H18, H22
    FMIN  H26, H19, H6
    FMINNM  S21, S23, S12
    FMINNM  H19, H24, H26
    FMAX  D1, D19, D8
    FMINNM  S14, S15, S9
    FMAX  D17, D0, D21
    FMINNM  H13, H17, H14
    FMIN  H2, H22, H24
    FMAXNM  S10, S25, S4
    FMAXNM  D7, D23, D20
    FMINNM  S17, S20, S18
    FMAXNM  H19, H7, H27
    FMAXNM  H3, H0, H19
    FMAXNM  S27, S12, S26
    FMINNM  D27, D10, D16
    FMAXNM  D7, D22, D15
    FMAX  S12, S13, S13
    FMIN  S31, S0, S10
    FMAX  H7, H21, H14
    FMAX  H15, H10, H24
    FMIN  H14, H10, H16
    FMAX  H24, H15, H11
    FMINNM  H22, H27, H14
    FMINNM  H27, H22, H7
    FMIN  S23, S17, S17
    FMIN  S26, S27, S19
    FMAXNM  D8, D10, D31
    FMAXNM  H7, H18, H3
    FMINNM  S13, S8, S24
    FMINNM  D24, D15, D26
    FMAX  H17, H7, H13
    FMINNM  S1, S30, S12
    SUBS  X18, X18, #0x1
    B.NE  TSRTFloatMinMax_label_3
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X6, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MRS  X20, FPSR
    MOVZ  X6, #0x80, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D1
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D10
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D15
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D25
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X20, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
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
    FMOV  V0.D[1], X23
    FMOV  D1, X16
    FMOV  V1.D[1], X9
    FMOV  D2, X21
    FMOV  V2.D[1], X21
    FMOV  D3, X22
    FMOV  V3.D[1], X11
    FMOV  D4, X12
    FMOV  V4.D[1], X13
    FMOV  D5, X11
    FMOV  V5.D[1], X11
    FMOV  D6, X4
    FMOV  V6.D[1], X23
    FMOV  D7, X29
    FMOV  V7.D[1], X11
    FMOV  D8, X2
    FMOV  V8.D[1], X14
    FMOV  D9, X10
    FMOV  V9.D[1], X10
    FMOV  D10, X20
    FMOV  V10.D[1], X29
    FMOV  D11, X22
    FMOV  V11.D[1], X20
    FMOV  D12, X13
    FMOV  V12.D[1], X29
    FMOV  D13, X15
    FMOV  V13.D[1], X14
    FMOV  D14, X20
    FMOV  V14.D[1], X2
    FMOV  D15, X6
    FMOV  V15.D[1], X19
    FMOV  D16, X11
    FMOV  V16.D[1], X11
    FMOV  D17, X21
    FMOV  V17.D[1], X8
    FMOV  D18, X18
    FMOV  V18.D[1], X2
    FMOV  D19, X2
    FMOV  V19.D[1], X5
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X10
    FMOV  V21.D[1], X17
    FMOV  D22, X11
    FMOV  V22.D[1], X23
    FMOV  D23, X19
    FMOV  V23.D[1], X18
    FMOV  D24, X16
    FMOV  V24.D[1], X9
    FMOV  D25, X7
    FMOV  V25.D[1], X20
    FMOV  D26, X11
    FMOV  V26.D[1], X12
    FMOV  D27, X10
    FMOV  V27.D[1], X21
    FMOV  D28, X14
    FMOV  V28.D[1], X5
    FMOV  D29, X18
    FMOV  V29.D[1], X10
    FMOV  D30, X9
    FMOV  V30.D[1], X21
    FMOV  D31, X3
    FMOV  V31.D[1], X8
    MOVZ  X21, #0xa, LSL #0
TSRTFloatMinMax_label_4:
    FMINNM  H4, H18, H7
    FMIN  S30, S24, S4
    FMIN  D4, D29, D10
    FMINNM  H6, H26, H4
    FMIN  D0, D31, D28
    FMAXNM  H6, H6, H0
    FMIN  H15, H26, H2
    FMAX  S16, S30, S15
    FMAX  S0, S20, S3
    FMINNM  H20, H0, H16
    FMINNM  D28, D6, D20
    FMIN  D2, D16, D28
    FMAX  S16, S21, S2
    FMAX  S31, S16, S16
    FMINNM  H23, H28, H31
    FMAXNM  D4, D17, D22
    FMAXNM  D24, D18, D4
    FMAXNM  D17, D23, D17
    FMAX  D10, D7, D31
    FMIN  D25, D24, D10
    FMAXNM  H10, H17, H11
    FMIN  S23, S30, S8
    FMAXNM  D15, D20, D10
    FMAXNM  S24, S20, S24
    FMIN  H16, H2, H25
    FMAX  H26, H29, H15
    FMAX  S8, S13, S23
    FMAX  H9, H8, H13
    FMAX  D11, D25, D9
    FMINNM  H30, H30, H11
    FMINNM  D16, D2, D1
    FMIN  D17, D17, D24
    FMAXNM  H21, H17, H30
    FMIN  S23, S22, S21
    FMIN  D13, D12, D4
    FMIN  H12, H10, H14
    FMINNM  D6, D16, D13
    FMINNM  S25, S6, S1
    FMAXNM  H11, H18, H25
    FMINNM  H2, H1, H1
    FMAXNM  S1, S11, S23
    FMAXNM  S6, S14, S26
    FMAX  H24, H12, H23
    FMINNM  S18, S6, S5
    FMAX  D23, D1, D20
    FMINNM  H8, H26, H24
    FMAXNM  D22, D0, D0
    FMAX  H7, H8, H8
    FMIN  H5, H22, H17
    FMAX  D11, D23, D5
    FMIN  H14, H2, H11
    FMAX  H2, H7, H0
    FMAX  H17, H2, H18
    FMIN  S21, S30, S25
    FMINNM  H0, H9, H11
    FMAX  D11, D16, D15
    FMAX  H10, H29, H21
    FMINNM  S13, S11, S4
    FMINNM  H21, H18, H12
    FMINNM  H22, H13, H28
    FMAXNM  S27, S17, S0
    FMAX  S4, S2, S17
    FMIN  H20, H28, H2
    FMAX  D8, D11, D31
    FMIN  S9, S12, S3
    FMAXNM  H12, H20, H3
    FMAXNM  H18, H21, H23
    FMAX  S11, S22, S14
    FMINNM  S1, S11, S9
    FMIN  S30, S9, S4
    FMIN  S17, S30, S12
    FMIN  S14, S7, S30
    FMAXNM  S22, S18, S27
    FMAX  H1, H22, H20
    FMIN  D0, D1, D18
    FMIN  H29, H14, H28
    FMIN  D13, D29, D7
    FMINNM  H7, H0, H0
    FMAX  D25, D13, D8
    FMAX  D21, D7, D17
    FMAX  D1, D30, D20
    FMIN  H16, H1, H21
    FMIN  S8, S8, S16
    FMIN  D17, D10, D12
    FMAX  H27, H29, H11
    FMINNM  H14, H27, H21
    FMAX  D28, D21, D17
    FMAX  H0, H28, H8
    FMAX  D13, D24, D0
    FMIN  D29, D14, D9
    FMIN  S16, S25, S25
    FMAXNM  D24, D13, D22
    FMAXNM  D13, D16, D16
    FMIN  S17, S13, S7
    FMIN  H11, H24, H3
    FMAX  H14, H29, H11
    FMIN  S10, S15, S22
    FMAXNM  D3, D25, D24
    FMAX  H28, H7, H11
    FMAXNM  D21, D19, D27
    FMIN  S1, S1, S8
    FMINNM  D13, D3, D21
    FMIN  S24, S7, S28
    FMAXNM  S19, S12, S11
    FMAXNM  S7, S0, S5
    FMAXNM  H29, H0, H11
    FMAX  H3, H19, H24
    FMIN  D6, D5, D29
    FMINNM  H14, H20, H3
    FMIN  S9, S10, S15
    FMINNM  S16, S1, S9
    FMAX  D27, D18, D17
    FMAX  H0, H27, H14
    FMIN  H10, H31, H8
    FMIN  S26, S16, S21
    FMAXNM  S15, S10, S24
    FMINNM  D28, D24, D5
    FMAXNM  S24, S15, S24
    FMINNM  S30, S24, S0
    FMIN  S18, S13, S10
    FMAX  S5, S6, S7
    FMAX  D14, D28, D26
    FMAXNM  H11, H5, H30
    FMAXNM  H24, H18, H24
    FMAXNM  H27, H23, H15
    FMAX  S13, S1, S4
    FMIN  H10, H11, H14
    FMAXNM  D17, D10, D10
    FMAXNM  S20, S13, S17
    FMAXNM  H16, H12, H2
    FMINNM  H0, H23, H20
    FMIN  S11, S3, S8
    FMAXNM  H2, H7, H16
    FMAXNM  H3, H27, H10
    FMAXNM  S13, S2, S4
    FMAX  D23, D24, D14
    FMAX  D17, D0, D11
    FMAXNM  S28, S23, S3
    FMAX  D27, D12, D13
    FMINNM  H25, H17, H28
    FMAXNM  H28, H10, H30
    FMAXNM  S8, S18, S21
    FMIN  S18, S5, S13
    FMIN  S6, S28, S22
    FMAXNM  S1, S19, S19
    FMINNM  S11, S27, S9
    FMINNM  D12, D10, D12
    FMIN  S17, S8, S14
    FMAX  S3, S18, S3
    FMINNM  D0, D6, D26
    FMAX  S30, S1, S30
    FMIN  H22, H3, H24
    FMAX  S7, S9, S17
    FMIN  H17, H24, H1
    FMAX  S3, S27, S2
    FMINNM  H16, H26, H8
    FMAX  S28, S6, S3
    FMAXNM  D6, D25, D28
    FMIN  H26, H28, H6
    FMAXNM  S1, S0, S7
    FMAX  H8, H22, H20
    FMIN  H28, H11, H12
    FMAX  S0, S1, S17
    FMINNM  H22, H28, H25
    FMIN  S14, S30, S26
    FMIN  S20, S27, S13
    FMINNM  S26, S1, S0
    FMINNM  D17, D29, D22
    FMAX  S3, S8, S20
    FMAX  H2, H24, H21
    FMAXNM  H25, H16, H30
    FMAXNM  D9, D3, D14
    FMAXNM  H30, H26, H23
    FMAX  D29, D30, D25
    FMIN  D23, D9, D2
    FMINNM  S28, S17, S3
    FMAXNM  H30, H23, H23
    FMAX  H22, H29, H9
    FMAXNM  H16, H15, H30
    FMAX  S25, S28, S3
    FMAX  H1, H25, H13
    FMAXNM  D28, D6, D16
    FMIN  S25, S2, S28
    FMAX  D3, D13, D1
    FMINNM  H12, H3, H25
    FMAX  H8, H2, H12
    FMAXNM  S23, S11, S20
    FMINNM  D4, D4, D5
    FMAXNM  H0, H18, H20
    FMINNM  S11, S28, S27
    FMINNM  D26, D19, D7
    FMIN  H14, H5, H16
    FMIN  D4, D20, D14
    FMAX  H15, H21, H2
    FMINNM  H1, H14, H1
    FMIN  S20, S0, S4
    FMIN  D18, D26, D28
    FMINNM  S6, S4, S20
    FMINNM  S16, S22, S6
    FMAX  S29, S1, S18
    SUBS  X21, X21, #0x1
    B.NE  TSRTFloatMinMax_label_4
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X22, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MRS  X7, FPSR
    MOVZ  X22, #0x80, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D1
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D22
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D30
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    FMOV  X7, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X2, #0x5a08, LSL #0
    MOVK  X2, #0xebef, LSL #16
    MOVK  X2, #0x2b2f, LSL #32
    MOVK  X2, #0x2af9, LSL #48
    MOVZ  X3, #0x5e66, LSL #0
    MOVK  X3, #0x4f41, LSL #16
    MOVK  X3, #0x3116, LSL #32
    MOVK  X3, #0xbcf7, LSL #48
    MOVZ  X4, #0x20ea, LSL #0
    MOVK  X4, #0x53d4, LSL #16
    MOVK  X4, #0x115, LSL #32
    MOVK  X4, #0xde71, LSL #48
    MOVZ  X5, #0x3208, LSL #0
    MOVK  X5, #0x2d6f, LSL #16
    MOVK  X5, #0x5f8, LSL #32
    MOVK  X5, #0x7b72, LSL #48
    MOVZ  X6, #0x6a24, LSL #0
    MOVK  X6, #0x10e3, LSL #16
    MOVK  X6, #0x63bb, LSL #32
    MOVK  X6, #0xa2dd, LSL #48
    MOVZ  X7, #0xd511, LSL #0
    MOVK  X7, #0x1b9e, LSL #16
    MOVK  X7, #0x3d09, LSL #32
    MOVK  X7, #0xdaf2, LSL #48
    MOVZ  X8, #0xd3b3, LSL #0
    MOVK  X8, #0x516f, LSL #16
    MOVK  X8, #0x5bc1, LSL #32
    MOVK  X8, #0x29f5, LSL #48
    MOVZ  X9, #0xbc6b, LSL #0
    MOVK  X9, #0xc294, LSL #16
    MOVK  X9, #0x62d2, LSL #32
    MOVK  X9, #0x5d35, LSL #48
    MOVZ  X10, #0x70a5, LSL #0
    MOVK  X10, #0x66af, LSL #16
    MOVK  X10, #0x3b61, LSL #32
    MOVK  X10, #0x7709, LSL #48
    MOVZ  X11, #0x7304, LSL #0
    MOVK  X11, #0x4725, LSL #16
    MOVK  X11, #0x28c7, LSL #32
    MOVK  X11, #0xb55c, LSL #48
    MOVZ  X12, #0x8549, LSL #0
    MOVK  X12, #0xe2ac, LSL #16
    MOVK  X12, #0xc472, LSL #32
    MOVK  X12, #0x53cc, LSL #48
    MOVZ  X13, #0xc81b, LSL #0
    MOVK  X13, #0xff3e, LSL #16
    MOVK  X13, #0x8d4c, LSL #32
    MOVK  X13, #0x8223, LSL #48
    MOVZ  X14, #0x9aa7, LSL #0
    MOVK  X14, #0x34ec, LSL #16
    MOVK  X14, #0x89ac, LSL #32
    MOVK  X14, #0x7703, LSL #48
    MOVZ  X15, #0x2c8b, LSL #0
    MOVK  X15, #0xddb, LSL #16
    MOVK  X15, #0x7f6b, LSL #32
    MOVK  X15, #0x6d, LSL #48
    MOVZ  X16, #0x3bb0, LSL #0
    MOVK  X16, #0x4565, LSL #16
    MOVK  X16, #0x38d8, LSL #32
    MOVK  X16, #0x848f, LSL #48
    MOVZ  X17, #0x436f, LSL #0
    MOVK  X17, #0xb8e2, LSL #16
    MOVK  X17, #0xa6cf, LSL #32
    MOVK  X17, #0x3b50, LSL #48
    MOVZ  X18, #0x73ed, LSL #0
    MOVK  X18, #0x4653, LSL #16
    MOVK  X18, #0x8b5d, LSL #32
    MOVK  X18, #0xc475, LSL #48
    MOVZ  X19, #0x4c7e, LSL #0
    MOVK  X19, #0x5902, LSL #16
    MOVK  X19, #0x20d2, LSL #32
    MOVK  X19, #0x78c2, LSL #48
    MOVZ  X20, #0xfb03, LSL #0
    MOVK  X20, #0xaf12, LSL #16
    MOVK  X20, #0x9755, LSL #32
    MOVK  X20, #0x930c, LSL #48
    MOVZ  X21, #0x6e97, LSL #0
    MOVK  X21, #0xe29d, LSL #16
    MOVK  X21, #0x4080, LSL #32
    MOVK  X21, #0x125f, LSL #48
    MOVZ  X22, #0x10f, LSL #0
    MOVK  X22, #0x38d1, LSL #16
    MOVK  X22, #0xbc8a, LSL #32
    MOVK  X22, #0xee0c, LSL #48
    MOVZ  X23, #0x6fa0, LSL #0
    MOVK  X23, #0x28bf, LSL #16
    MOVK  X23, #0xb2e4, LSL #32
    MOVK  X23, #0xe08c, LSL #48
    MOVZ  X29, #0xee24, LSL #0
    MOVK  X29, #0xe40b, LSL #16
    MOVK  X29, #0x9f34, LSL #32
    MOVK  X29, #0x283e, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X23
    FMOV  D1, X22
    FMOV  V1.D[1], X29
    FMOV  D2, X21
    FMOV  V2.D[1], X22
    FMOV  D3, X23
    FMOV  V3.D[1], X6
    FMOV  D4, X6
    FMOV  V4.D[1], X12
    FMOV  D5, X2
    FMOV  V5.D[1], X4
    FMOV  D6, X11
    FMOV  V6.D[1], X13
    FMOV  D7, X11
    FMOV  V7.D[1], X3
    FMOV  D8, X13
    FMOV  V8.D[1], X9
    FMOV  D9, X13
    FMOV  V9.D[1], X6
    FMOV  D10, X17
    FMOV  V10.D[1], X17
    FMOV  D11, X4
    FMOV  V11.D[1], X6
    FMOV  D12, X6
    FMOV  V12.D[1], X9
    FMOV  D13, X18
    FMOV  V13.D[1], X15
    FMOV  D14, X4
    FMOV  V14.D[1], X3
    FMOV  D15, X4
    FMOV  V15.D[1], X5
    FMOV  D16, X11
    FMOV  V16.D[1], X18
    FMOV  D17, X14
    FMOV  V17.D[1], X10
    FMOV  D18, X9
    FMOV  V18.D[1], X16
    FMOV  D19, X6
    FMOV  V19.D[1], X7
    FMOV  D20, X7
    FMOV  V20.D[1], X29
    FMOV  D21, X21
    FMOV  V21.D[1], X23
    FMOV  D22, X12
    FMOV  V22.D[1], X16
    FMOV  D23, X10
    FMOV  V23.D[1], X7
    FMOV  D24, X9
    FMOV  V24.D[1], X14
    FMOV  D25, X15
    FMOV  V25.D[1], X13
    FMOV  D26, X9
    FMOV  V26.D[1], X2
    FMOV  D27, X2
    FMOV  V27.D[1], X14
    FMOV  D28, X3
    FMOV  V28.D[1], X16
    FMOV  D29, X11
    FMOV  V29.D[1], X11
    FMOV  D30, X9
    FMOV  V30.D[1], X17
    FMOV  D31, X15
    FMOV  V31.D[1], X19
    MOVZ  X18, #0xa, LSL #0
TSRTFloatMinMax_label_5:
    FMIN  H6, H18, H11
    FMIN  S18, S26, S22
    FMIN  S11, S31, S24
    FMIN  D16, D27, D3
    FMAXNM  H8, H18, H30
    FMIN  S26, S16, S28
    FMAXNM  S19, S25, S29
    FMAXNM  S11, S26, S6
    FMIN  D22, D5, D2
    FMAXNM  S16, S23, S8
    FMAXNM  H6, H22, H3
    FMINNM  D3, D11, D16
    FMINNM  H24, H3, H8
    FMAX  H14, H25, H11
    FMINNM  D15, D6, D24
    FMIN  S16, S14, S15
    FMAX  D4, D26, D23
    FMINNM  D28, D1, D15
    FMAXNM  S29, S18, S29
    FMINNM  H11, H11, H12
    FMAX  D4, D22, D26
    FMINNM  S3, S10, S26
    FMAXNM  S15, S11, S16
    FMAXNM  S8, S4, S18
    FMAXNM  S16, S13, S12
    FMINNM  S9, S6, S7
    FMINNM  S30, S17, S6
    FMAXNM  S30, S31, S9
    FMINNM  S9, S30, S3
    FMAX  D13, D8, D8
    FMIN  D27, D25, D29
    FMAXNM  D11, D15, D27
    FMAX  D5, D13, D9
    FMIN  S23, S6, S11
    FMAXNM  S25, S23, S16
    FMIN  H29, H28, H19
    FMAX  S19, S29, S10
    FMIN  D7, D8, D23
    FMAXNM  H5, H20, H4
    FMIN  D27, D5, D5
    FMAX  S18, S7, S25
    FMAX  S6, S18, S27
    FMAXNM  H30, H20, H4
    FMIN  S20, S6, S3
    FMAXNM  S31, S3, S3
    FMAX  S15, S6, S0
    FMINNM  D17, D12, D3
    FMAX  H16, H18, H27
    FMAX  S29, S7, S19
    FMAXNM  S12, S0, S28
    FMIN  D31, D30, D27
    FMIN  D11, D21, D22
    FMAX  D6, D15, D21
    FMAXNM  S9, S26, S0
    FMIN  D4, D31, D16
    FMIN  S5, S6, S5
    FMAXNM  D15, D23, D21
    FMAX  D27, D20, D8
    FMAX  S28, S27, S5
    FMAX  S5, S5, S25
    FMINNM  D30, D25, D22
    FMAX  D26, D30, D9
    FMIN  S23, S16, S12
    FMINNM  D31, D17, D23
    FMIN  D23, D11, D11
    FMAX  S3, S3, S18
    FMAX  H9, H23, H3
    FMAXNM  S26, S5, S31
    FMIN  S18, S28, S4
    FMIN  D17, D15, D29
    FMIN  H11, H18, H17
    FMIN  S27, S12, S26
    FMAX  S16, S9, S27
    FMAXNM  D6, D28, D2
    FMINNM  D18, D20, D0
    FMINNM  S27, S31, S24
    FMINNM  D25, D4, D10
    FMAXNM  S3, S13, S12
    FMIN  H26, H13, H14
    FMINNM  S21, S12, S11
    FMAXNM  D14, D13, D8
    FMAXNM  H22, H3, H21
    FMINNM  H14, H22, H7
    FMIN  S0, S26, S14
    FMAXNM  S27, S28, S27
    FMIN  S30, S13, S18
    FMINNM  H14, H29, H17
    FMINNM  D18, D15, D25
    FMIN  D29, D30, D27
    FMAXNM  S31, S9, S0
    FMAXNM  S26, S16, S16
    FMAX  S0, S2, S26
    FMIN  H2, H19, H30
    FMIN  H24, H29, H18
    FMINNM  S10, S8, S0
    FMINNM  H26, H3, H25
    FMIN  S21, S24, S10
    FMAX  S7, S21, S21
    FMIN  D15, D4, D14
    FMIN  H10, H26, H31
    FMAX  D14, D11, D2
    FMAX  H9, H12, H12
    FMIN  D24, D19, D15
    FMAXNM  D18, D11, D6
    FMIN  S27, S10, S9
    FMIN  D16, D24, D7
    FMAXNM  D17, D14, D18
    FMIN  D16, D17, D27
    FMIN  H4, H17, H8
    FMIN  D2, D12, D10
    FMINNM  D15, D25, D4
    FMAXNM  D9, D26, D5
    FMINNM  H27, H6, H23
    FMINNM  H26, H6, H25
    FMAXNM  D13, D6, D2
    FMAXNM  S7, S14, S4
    FMIN  S4, S24, S14
    FMAXNM  S23, S2, S24
    FMAX  D29, D16, D27
    FMIN  H18, H15, H23
    FMAX  H17, H29, H13
    FMAXNM  D13, D9, D20
    FMINNM  D12, D13, D4
    FMIN  D2, D13, D12
    FMIN  S19, S28, S18
    FMIN  H6, H19, H2
    FMIN  S29, S17, S12
    FMINNM  D20, D26, D28
    FMAX  H26, H29, H6
    FMINNM  H5, H20, H0
    FMAXNM  D15, D31, D7
    FMIN  D23, D9, D0
    FMAXNM  S24, S23, S26
    FMINNM  D31, D5, D15
    FMINNM  H26, H31, H8
    FMIN  H23, H13, H30
    FMINNM  H14, H12, H6
    FMIN  S20, S21, S30
    FMINNM  D19, D21, D26
    FMINNM  S17, S26, S19
    FMAXNM  S29, S20, S15
    FMAX  H6, H15, H23
    FMIN  H12, H14, H17
    FMAX  D27, D25, D18
    FMAXNM  H13, H1, H7
    FMAXNM  H8, H5, H9
    FMINNM  H17, H26, H21
    FMINNM  S12, S5, S15
    FMAXNM  S30, S21, S1
    FMIN  H14, H19, H27
    FMIN  S7, S4, S29
    FMINNM  S16, S19, S14
    FMAX  S9, S6, S9
    FMINNM  H31, H30, H16
    FMAXNM  H26, H7, H8
    FMAXNM  D23, D17, D12
    FMAX  H28, H13, H11
    FMIN  H12, H24, H4
    FMAX  H27, H23, H31
    FMIN  H30, H25, H9
    FMAXNM  D14, D19, D27
    FMINNM  S3, S31, S18
    FMAXNM  S27, S30, S26
    FMAXNM  H1, H15, H14
    FMAX  D26, D23, D3
    FMAX  S15, S15, S26
    FMINNM  D5, D14, D15
    FMAX  S14, S27, S19
    FMAX  D11, D18, D1
    FMAX  D26, D5, D4
    FMIN  S6, S20, S12
    FMAX  S21, S6, S11
    FMIN  S11, S9, S18
    FMAXNM  D27, D13, D29
    FMAXNM  D17, D21, D0
    FMINNM  H29, H11, H11
    FMAX  D5, D27, D14
    FMINNM  S15, S17, S7
    FMIN  S5, S18, S26
    FMAXNM  H11, H14, H5
    FMAX  S6, S31, S25
    FMINNM  D19, D21, D11
    FMIN  S12, S19, S27
    FMAXNM  S30, S6, S21
    FMINNM  D24, D15, D28
    FMIN  S27, S24, S2
    FMIN  S11, S27, S9
    FMAXNM  H0, H29, H30
    FMAXNM  H5, H12, H10
    FMINNM  H29, H0, H11
    FMINNM  D21, D16, D15
    FMIN  H17, H10, H12
    FMINNM  D18, D12, D6
    FMAX  D26, D6, D22
    FMINNM  S25, S9, S18
    FMINNM  S19, S8, S2
    FMIN  S4, S6, S18
    FMIN  D10, D31, D18
    FMAX  S3, S5, S4
    FMAX  S24, S26, S25
    SUBS  X18, X18, #0x1
    B.NE  TSRTFloatMinMax_label_5
    MOVZ  X12, #0x5a08, LSL #0
    MOVK  X12, #0xebef, LSL #16
    MOVK  X12, #0x2b2f, LSL #32
    MOVK  X12, #0x2af9, LSL #48
    SUB  X4, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5e66, LSL #0
    MOVK  X12, #0x4f41, LSL #16
    MOVK  X12, #0x3116, LSL #32
    MOVK  X12, #0xbcf7, LSL #48
    SUB  X4, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x3208, LSL #0
    MOVK  X12, #0x2d6f, LSL #16
    MOVK  X12, #0x5f8, LSL #32
    MOVK  X12, #0x7b72, LSL #48
    SUB  X4, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x6a24, LSL #0
    MOVK  X12, #0x10e3, LSL #16
    MOVK  X12, #0x63bb, LSL #32
    MOVK  X12, #0xa2dd, LSL #48
    SUB  X4, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0xd511, LSL #0
    MOVK  X12, #0x1b9e, LSL #16
    MOVK  X12, #0x3d09, LSL #32
    MOVK  X12, #0xdaf2, LSL #48
    SUB  X4, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0xd3b3, LSL #0
    MOVK  X12, #0x516f, LSL #16
    MOVK  X12, #0x5bc1, LSL #32
    MOVK  X12, #0x29f5, LSL #48
    SUB  X4, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0xbc6b, LSL #0
    MOVK  X12, #0xc294, LSL #16
    MOVK  X12, #0x62d2, LSL #32
    MOVK  X12, #0x5d35, LSL #48
    SUB  X4, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x70a5, LSL #0
    MOVK  X12, #0x66af, LSL #16
    MOVK  X12, #0x3b61, LSL #32
    MOVK  X12, #0x7709, LSL #48
    SUB  X4, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x7304, LSL #0
    MOVK  X12, #0x4725, LSL #16
    MOVK  X12, #0x28c7, LSL #32
    MOVK  X12, #0xb55c, LSL #48
    SUB  X4, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0xc81b, LSL #0
    MOVK  X12, #0xff3e, LSL #16
    MOVK  X12, #0x8d4c, LSL #32
    MOVK  X12, #0x8223, LSL #48
    SUB  X4, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x9aa7, LSL #0
    MOVK  X12, #0x34ec, LSL #16
    MOVK  X12, #0x89ac, LSL #32
    MOVK  X12, #0x7703, LSL #48
    SUB  X4, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x2c8b, LSL #0
    MOVK  X12, #0xddb, LSL #16
    MOVK  X12, #0x7f6b, LSL #32
    MOVK  X12, #0x6d, LSL #48
    SUB  X4, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x3bb0, LSL #0
    MOVK  X12, #0x4565, LSL #16
    MOVK  X12, #0x38d8, LSL #32
    MOVK  X12, #0x848f, LSL #48
    SUB  X4, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x436f, LSL #0
    MOVK  X12, #0xb8e2, LSL #16
    MOVK  X12, #0xa6cf, LSL #32
    MOVK  X12, #0x3b50, LSL #48
    SUB  X4, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x4c7e, LSL #0
    MOVK  X12, #0x5902, LSL #16
    MOVK  X12, #0x20d2, LSL #32
    MOVK  X12, #0x78c2, LSL #48
    SUB  X4, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0xfb03, LSL #0
    MOVK  X12, #0xaf12, LSL #16
    MOVK  X12, #0x9755, LSL #32
    MOVK  X12, #0x930c, LSL #48
    SUB  X4, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x6e97, LSL #0
    MOVK  X12, #0xe29d, LSL #16
    MOVK  X12, #0x4080, LSL #32
    MOVK  X12, #0x125f, LSL #48
    SUB  X4, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x6fa0, LSL #0
    MOVK  X12, #0x28bf, LSL #16
    MOVK  X12, #0xb2e4, LSL #32
    MOVK  X12, #0xe08c, LSL #48
    SUB  X4, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0xee24, LSL #0
    MOVK  X12, #0xe40b, LSL #16
    MOVK  X12, #0x9f34, LSL #32
    MOVK  X12, #0x283e, LSL #48
    SUB  X4, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MRS  X12, FPSR
    MOVZ  X4, #0x80, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    FMOV  X12, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
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
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X23
    FMOV  V0.D[1], X14
    FMOV  D1, X10
    FMOV  V1.D[1], X7
    FMOV  D2, X6
    FMOV  V2.D[1], X17
    FMOV  D3, X12
    FMOV  V3.D[1], X21
    FMOV  D4, X20
    FMOV  V4.D[1], X15
    FMOV  D5, X13
    FMOV  V5.D[1], X22
    FMOV  D6, X4
    FMOV  V6.D[1], X29
    FMOV  D7, X29
    FMOV  V7.D[1], X29
    FMOV  D8, X11
    FMOV  V8.D[1], X10
    FMOV  D9, X16
    FMOV  V9.D[1], X13
    FMOV  D10, X9
    FMOV  V10.D[1], X23
    FMOV  D11, X20
    FMOV  V11.D[1], X21
    FMOV  D12, X3
    FMOV  V12.D[1], X15
    FMOV  D13, X17
    FMOV  V13.D[1], X11
    FMOV  D14, X10
    FMOV  V14.D[1], X29
    FMOV  D15, X10
    FMOV  V15.D[1], X23
    FMOV  D16, X3
    FMOV  V16.D[1], X7
    FMOV  D17, X29
    FMOV  V17.D[1], X6
    FMOV  D18, X2
    FMOV  V18.D[1], X19
    FMOV  D19, X23
    FMOV  V19.D[1], X8
    FMOV  D20, X13
    FMOV  V20.D[1], X4
    FMOV  D21, X22
    FMOV  V21.D[1], X16
    FMOV  D22, X23
    FMOV  V22.D[1], X14
    FMOV  D23, X13
    FMOV  V23.D[1], X10
    FMOV  D24, X18
    FMOV  V24.D[1], X17
    FMOV  D25, X9
    FMOV  V25.D[1], X9
    FMOV  D26, X23
    FMOV  V26.D[1], X18
    FMOV  D27, X10
    FMOV  V27.D[1], X16
    FMOV  D28, X5
    FMOV  V28.D[1], X13
    FMOV  D29, X17
    FMOV  V29.D[1], X9
    FMOV  D30, X7
    FMOV  V30.D[1], X3
    FMOV  D31, X11
    FMOV  V31.D[1], X20
    MOVZ  X19, #0xa, LSL #0
TSRTFloatMinMax_label_6:
    FMAXNM  S4, S28, S18
    FMIN  H18, H4, H4
    FMINNM  D9, D27, D9
    FMAXNM  D24, D25, D21
    FMAXNM  H24, H29, H22
    FMAXNM  D20, D30, D26
    FMAX  D20, D23, D18
    FMIN  D2, D7, D24
    FMAX  S10, S8, S5
    FMAX  S27, S27, S19
    FMAXNM  D30, D27, D14
    FMIN  H18, H30, H20
    FMINNM  S15, S9, S2
    FMAX  S3, S3, S23
    FMIN  D25, D3, D14
    FMINNM  D5, D11, D10
    FMAX  H19, H6, H0
    FMAX  D4, D15, D23
    FMIN  S27, S29, S19
    FMIN  S23, S27, S6
    FMIN  H27, H7, H5
    FMINNM  H10, H4, H27
    FMAX  S5, S22, S18
    FMAX  D18, D23, D2
    FMAXNM  S14, S18, S5
    FMINNM  S18, S14, S9
    FMINNM  S28, S25, S10
    FMAX  H4, H28, H4
    FMAX  S27, S18, S4
    FMIN  D30, D2, D23
    FMAXNM  S25, S24, S22
    FMIN  H24, H0, H30
    FMIN  D22, D30, D9
    FMAX  H12, H17, H7
    FMIN  H0, H3, H17
    FMAXNM  S7, S13, S2
    FMAX  S1, S24, S25
    FMINNM  H18, H12, H27
    FMIN  D5, D17, D10
    FMAX  S6, S28, S17
    FMINNM  S19, S25, S6
    FMIN  S13, S26, S5
    FMAXNM  S23, S2, S21
    FMAXNM  D25, D21, D27
    FMAXNM  H10, H2, H13
    FMIN  D21, D25, D19
    FMAXNM  S3, S23, S11
    FMIN  S22, S18, S1
    FMAXNM  H2, H21, H10
    FMAX  H26, H0, H23
    FMIN  H8, H26, H22
    FMAXNM  H19, H22, H6
    FMAX  D23, D8, D25
    FMAXNM  H6, H7, H22
    FMIN  S0, S3, S23
    FMIN  H23, H6, H6
    FMINNM  H14, H2, H19
    FMAX  S30, S14, S14
    FMINNM  S21, S21, S30
    FMAXNM  S3, S23, S14
    FMAXNM  H17, H0, H3
    FMAXNM  H28, H0, H24
    FMAX  H9, H30, H5
    FMINNM  H3, H0, H3
    FMINNM  D11, D19, D5
    FMAXNM  H26, H16, H5
    FMAX  H1, H23, H10
    FMINNM  D16, D5, D28
    FMIN  D10, D14, D24
    FMIN  S23, S30, S16
    FMIN  D31, D1, D16
    FMINNM  H1, H3, H6
    FMAXNM  D5, D18, D9
    FMAXNM  H9, H21, H1
    FMINNM  H0, H17, H14
    FMAX  H24, H10, H31
    FMIN  D25, D11, D0
    FMAXNM  S1, S24, S15
    FMAX  S11, S30, S9
    FMIN  S5, S1, S15
    FMAXNM  D18, D23, D26
    FMAXNM  S9, S3, S5
    FMINNM  H0, H9, H11
    FMIN  S5, S0, S31
    FMINNM  S18, S5, S12
    FMAX  D23, D18, D18
    FMAXNM  H26, H28, H22
    FMAXNM  S22, S3, S24
    FMINNM  H28, H7, H1
    FMAXNM  D0, D29, D3
    FMAXNM  D31, D6, D22
    FMAX  H19, H20, H9
    FMAXNM  S30, S13, S0
    FMINNM  D21, D1, D3
    FMAXNM  D5, D9, D14
    FMIN  H3, H26, H28
    FMAX  D26, D30, D30
    FMAX  D18, D25, D15
    FMINNM  S9, S26, S13
    FMIN  H11, H3, H6
    FMAXNM  S30, S5, S6
    FMAXNM  H22, H15, H15
    FMAX  D12, D9, D0
    FMINNM  S6, S6, S12
    FMIN  S25, S22, S23
    FMIN  S23, S21, S30
    FMIN  D7, D18, D19
    FMINNM  H19, H23, H7
    FMIN  S21, S11, S19
    FMIN  H18, H31, H29
    FMAX  H29, H18, H13
    FMAX  H30, H16, H25
    FMAX  H0, H29, H3
    FMAX  H18, H12, H20
    FMIN  S29, S18, S30
    FMAXNM  S16, S9, S21
    FMIN  S30, S16, S29
    FMAXNM  S20, S22, S0
    FMAX  S12, S20, S6
    FMAXNM  H3, H27, H1
    FMAX  H13, H5, H1
    FMAX  H22, H12, H29
    FMINNM  D5, D26, D14
    FMAX  S16, S17, S3
    FMIN  D17, D15, D21
    FMAXNM  S27, S11, S3
    FMAXNM  H25, H20, H8
    FMIN  H3, H15, H10
    FMIN  H13, H3, H5
    FMIN  H26, H17, H25
    FMIN  D3, D14, D30
    FMAXNM  H23, H13, H3
    FMAX  H11, H29, H16
    FMINNM  D9, D11, D11
    FMINNM  D1, D22, D4
    FMAX  S21, S21, S0
    FMIN  S20, S26, S23
    FMINNM  D14, D13, D26
    FMINNM  S22, S14, S4
    FMIN  S26, S25, S1
    FMAX  H25, H20, H26
    FMAXNM  S10, S2, S21
    FMIN  H1, H9, H31
    FMAXNM  S11, S25, S27
    FMAXNM  D16, D1, D10
    FMAXNM  D30, D6, D11
    FMINNM  D24, D16, D25
    FMINNM  S4, S9, S30
    FMINNM  D10, D24, D24
    FMAX  S0, S22, S1
    FMINNM  S17, S1, S0
    FMIN  H18, H17, H4
    FMINNM  S17, S4, S24
    FMINNM  H21, H5, H15
    FMAXNM  D5, D20, D26
    FMAX  S23, S16, S12
    FMIN  D31, D4, D5
    FMIN  S5, S29, S8
    FMIN  H20, H8, H11
    FMIN  D24, D16, D22
    FMAX  H4, H20, H31
    FMAX  H22, H10, H12
    FMIN  S4, S0, S14
    FMAXNM  H1, H18, H17
    FMAXNM  D25, D24, D4
    FMIN  H3, H1, H4
    FMAX  S18, S5, S22
    FMAXNM  H30, H21, H18
    FMINNM  H31, H0, H23
    FMINNM  S5, S3, S19
    FMAXNM  D22, D10, D25
    FMINNM  D10, D31, D30
    FMINNM  D1, D10, D5
    FMINNM  H20, H29, H16
    FMINNM  S19, S13, S23
    FMAX  D25, D31, D26
    FMIN  D13, D5, D1
    FMINNM  S30, S5, S29
    FMINNM  S1, S27, S2
    FMINNM  S12, S14, S21
    FMINNM  S21, S30, S28
    FMIN  D2, D10, D4
    FMINNM  D10, D29, D22
    FMIN  H22, H25, H18
    FMINNM  S18, S2, S1
    FMINNM  D25, D26, D22
    FMINNM  S16, S20, S12
    FMAXNM  H27, H18, H10
    FMAXNM  S11, S27, S25
    FMIN  D29, D19, D12
    FMIN  H20, H29, H13
    FMINNM  S2, S20, S8
    FMINNM  H24, H16, H2
    FMAX  H12, H21, H21
    FMINNM  S27, S12, S9
    FMIN  D20, D7, D27
    FMINNM  S16, S24, S24
    FMAXNM  S8, S17, S16
    FMAX  S28, S11, S9
    FMAX  H2, H8, H28
    SUBS  X19, X19, #0x1
    B.NE  TSRTFloatMinMax_label_6
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MRS  X22, FPSR
    MOVZ  X7, #0x80, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    FMOV  X22, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X18
    FMOV  D1, X20
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X22
    FMOV  D3, X22
    FMOV  V3.D[1], X8
    FMOV  D4, X17
    FMOV  V4.D[1], X17
    FMOV  D5, X9
    FMOV  V5.D[1], X15
    FMOV  D6, X4
    FMOV  V6.D[1], X6
    FMOV  D7, X9
    FMOV  V7.D[1], X23
    FMOV  D8, X7
    FMOV  V8.D[1], X12
    FMOV  D9, X11
    FMOV  V9.D[1], X17
    FMOV  D10, X22
    FMOV  V10.D[1], X19
    FMOV  D11, X6
    FMOV  V11.D[1], X7
    FMOV  D12, X8
    FMOV  V12.D[1], X29
    FMOV  D13, X13
    FMOV  V13.D[1], X29
    FMOV  D14, X22
    FMOV  V14.D[1], X15
    FMOV  D15, X12
    FMOV  V15.D[1], X10
    FMOV  D16, X13
    FMOV  V16.D[1], X7
    FMOV  D17, X11
    FMOV  V17.D[1], X18
    FMOV  D18, X5
    FMOV  V18.D[1], X22
    FMOV  D19, X18
    FMOV  V19.D[1], X21
    FMOV  D20, X4
    FMOV  V20.D[1], X23
    FMOV  D21, X22
    FMOV  V21.D[1], X21
    FMOV  D22, X17
    FMOV  V22.D[1], X2
    FMOV  D23, X8
    FMOV  V23.D[1], X20
    FMOV  D24, X8
    FMOV  V24.D[1], X19
    FMOV  D25, X15
    FMOV  V25.D[1], X17
    FMOV  D26, X21
    FMOV  V26.D[1], X29
    FMOV  D27, X17
    FMOV  V27.D[1], X4
    FMOV  D28, X12
    FMOV  V28.D[1], X23
    FMOV  D29, X12
    FMOV  V29.D[1], X13
    FMOV  D30, X18
    FMOV  V30.D[1], X23
    FMOV  D31, X4
    FMOV  V31.D[1], X21
    MOVZ  X17, #0xa, LSL #0
TSRTFloatMinMax_label_7:
    FMAXNM  H7, H31, H28
    FMIN  D8, D20, D26
    FMAX  D30, D27, D23
    FMINNM  S23, S20, S2
    FMAXNM  S18, S7, S7
    FMIN  D29, D7, D3
    FMINNM  S10, S18, S18
    FMIN  D5, D29, D26
    FMAXNM  H27, H23, H23
    FMIN  H24, H2, H5
    FMINNM  S28, S21, S5
    FMINNM  H25, H11, H28
    FMIN  D20, D30, D24
    FMIN  S2, S27, S8
    FMAX  H3, H20, H10
    FMAXNM  S5, S31, S2
    FMAXNM  H2, H3, H25
    FMIN  S6, S27, S25
    FMAX  H31, H4, H21
    FMAX  S23, S8, S1
    FMIN  S4, S7, S0
    FMAX  D18, D17, D1
    FMIN  H28, H23, H1
    FMAX  S26, S23, S17
    FMAX  H20, H8, H12
    FMINNM  H24, H2, H3
    FMINNM  S23, S20, S31
    FMAXNM  H21, H17, H5
    FMAX  H29, H23, H27
    FMINNM  H25, H10, H17
    FMIN  S0, S24, S18
    FMAXNM  H7, H25, H26
    FMIN  H26, H30, H6
    FMINNM  S6, S29, S7
    FMIN  S10, S0, S28
    FMIN  H12, H26, H6
    FMIN  H6, H23, H21
    FMINNM  H25, H6, H12
    FMAX  S28, S0, S10
    FMINNM  D21, D25, D30
    FMIN  S20, S1, S31
    FMINNM  D11, D21, D5
    FMIN  S31, S8, S20
    FMINNM  D29, D28, D3
    FMINNM  S20, S29, S4
    FMAXNM  D25, D20, D31
    FMINNM  D4, D18, D20
    FMAXNM  D10, D29, D1
    FMINNM  D7, D3, D1
    FMAXNM  D20, D23, D14
    FMIN  D8, D17, D20
    FMAX  H30, H20, H12
    FMINNM  D21, D29, D24
    FMIN  D17, D18, D30
    FMIN  D12, D25, D16
    FMAXNM  S5, S28, S13
    FMAXNM  S18, S30, S12
    FMINNM  D9, D0, D8
    FMIN  H0, H5, H17
    FMINNM  H26, H7, H9
    FMAX  S27, S18, S31
    FMIN  D8, D11, D26
    FMINNM  H29, H8, H8
    FMAX  H17, H0, H6
    FMAX  H5, H17, H23
    FMIN  H19, H31, H26
    FMAXNM  H23, H29, H21
    FMIN  S30, S23, S10
    FMINNM  S12, S4, S5
    FMIN  D4, D5, D17
    FMAXNM  S25, S27, S13
    FMINNM  S5, S30, S12
    FMAXNM  D11, D25, D25
    FMAXNM  S15, S1, S19
    FMAXNM  D13, D5, D7
    FMAX  H7, H11, H4
    FMAXNM  H26, H7, H13
    FMAXNM  D28, D2, D31
    FMAXNM  S10, S23, S21
    FMINNM  D18, D16, D22
    FMINNM  H27, H11, H26
    FMINNM  S22, S15, S26
    FMAXNM  D22, D21, D17
    FMIN  S20, S4, S9
    FMINNM  H31, H22, H9
    FMIN  S13, S18, S24
    FMIN  S19, S23, S10
    FMINNM  H5, H24, H4
    FMAXNM  S10, S6, S12
    FMIN  D25, D17, D2
    FMAXNM  H17, H31, H28
    FMINNM  S6, S16, S8
    FMINNM  D1, D6, D10
    FMINNM  S6, S28, S19
    FMINNM  S21, S1, S17
    FMIN  S12, S0, S2
    FMINNM  H11, H25, H29
    FMIN  H1, H21, H6
    FMAX  D29, D5, D5
    FMIN  S26, S13, S19
    FMIN  S17, S20, S29
    FMINNM  S13, S26, S12
    FMAXNM  S26, S1, S13
    FMINNM  D10, D26, D11
    FMINNM  D18, D30, D8
    FMAXNM  S24, S14, S17
    FMAX  H25, H15, H10
    FMAX  H15, H18, H12
    FMIN  D18, D24, D27
    FMAXNM  H1, H15, H25
    FMAX  H26, H5, H24
    FMINNM  S10, S21, S19
    FMIN  H24, H18, H11
    FMAXNM  D2, D17, D16
    FMINNM  H20, H15, H18
    FMAX  H25, H31, H0
    FMINNM  D17, D10, D14
    FMAX  D21, D13, D30
    FMAXNM  D27, D16, D4
    FMIN  S19, S5, S24
    FMINNM  D4, D21, D29
    FMINNM  H16, H19, H11
    FMAXNM  S14, S2, S2
    FMINNM  D31, D25, D17
    FMINNM  S13, S26, S27
    FMAXNM  S15, S16, S10
    FMAX  H15, H4, H15
    FMAX  S20, S3, S31
    FMINNM  H24, H13, H20
    FMINNM  S22, S15, S1
    FMAX  H15, H22, H14
    FMAX  H0, H10, H18
    FMAX  D21, D12, D12
    FMINNM  S18, S3, S6
    FMIN  S22, S2, S18
    FMIN  H4, H20, H14
    FMAX  S25, S7, S25
    FMINNM  D5, D8, D8
    FMAXNM  H26, H4, H29
    FMIN  S31, S16, S31
    FMIN  S12, S27, S29
    FMINNM  S25, S26, S9
    FMAX  D29, D0, D25
    FMIN  H3, H21, H24
    FMAXNM  D27, D3, D3
    FMAX  H26, H15, H24
    FMINNM  H30, H22, H26
    FMIN  H30, H30, H12
    FMAX  S19, S7, S27
    FMIN  D8, D30, D16
    FMIN  D13, D3, D31
    FMAXNM  H26, H8, H5
    FMIN  H9, H11, H13
    FMAX  H10, H29, H17
    FMINNM  H4, H31, H10
    FMAX  S11, S26, S21
    FMINNM  H1, H9, H9
    FMAX  D6, D1, D4
    FMAXNM  H8, H27, H11
    FMINNM  D27, D6, D6
    FMIN  D30, D2, D27
    FMINNM  S0, S8, S18
    FMAX  S15, S10, S0
    FMAXNM  D6, D15, D19
    FMAXNM  S16, S11, S12
    FMINNM  H8, H27, H18
    FMINNM  D29, D30, D8
    FMINNM  H5, H13, H18
    FMINNM  D10, D3, D12
    FMINNM  S19, S8, S20
    FMINNM  D1, D27, D29
    FMAX  H4, H4, H6
    FMAX  H2, H23, H5
    FMAX  D31, D9, D10
    FMIN  D15, D4, D21
    FMAX  D4, D27, D10
    FMAX  S23, S13, S13
    FMAX  S27, S14, S18
    FMAX  H0, H31, H27
    FMAX  S7, S1, S15
    FMAX  S11, S7, S3
    FMINNM  H11, H19, H2
    FMAX  H26, H23, H28
    FMINNM  S3, S23, S8
    FMINNM  H29, H19, H6
    FMAX  H28, H16, H31
    FMIN  H5, H26, H30
    FMAX  H26, H5, H4
    FMINNM  S12, S10, S7
    FMINNM  H23, H29, H29
    FMAXNM  D27, D15, D16
    FMAX  S9, S26, S26
    FMAXNM  D21, D12, D9
    FMIN  D6, D27, D7
    FMIN  D13, D0, D21
    FMIN  D12, D11, D7
    FMAX  D4, D8, D23
    FMIN  D31, D28, D23
    FMINNM  S30, S6, S4
    FMAXNM  D9, D8, D30
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatMinMax_label_7
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MRS  X4, FPSR
    MOVZ  X6, #0x80, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D1
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D25
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    FMOV  X4, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
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
    FMOV  V0.D[1], X23
    FMOV  D1, X9
    FMOV  V1.D[1], X22
    FMOV  D2, X22
    FMOV  V2.D[1], X3
    FMOV  D3, X9
    FMOV  V3.D[1], X21
    FMOV  D4, X29
    FMOV  V4.D[1], X7
    FMOV  D5, X2
    FMOV  V5.D[1], X2
    FMOV  D6, X8
    FMOV  V6.D[1], X23
    FMOV  D7, X19
    FMOV  V7.D[1], X12
    FMOV  D8, X16
    FMOV  V8.D[1], X12
    FMOV  D9, X6
    FMOV  V9.D[1], X14
    FMOV  D10, X21
    FMOV  V10.D[1], X5
    FMOV  D11, X10
    FMOV  V11.D[1], X23
    FMOV  D12, X4
    FMOV  V12.D[1], X14
    FMOV  D13, X8
    FMOV  V13.D[1], X18
    FMOV  D14, X3
    FMOV  V14.D[1], X6
    FMOV  D15, X11
    FMOV  V15.D[1], X23
    FMOV  D16, X29
    FMOV  V16.D[1], X22
    FMOV  D17, X11
    FMOV  V17.D[1], X15
    FMOV  D18, X12
    FMOV  V18.D[1], X7
    FMOV  D19, X18
    FMOV  V19.D[1], X20
    FMOV  D20, X22
    FMOV  V20.D[1], X9
    FMOV  D21, X9
    FMOV  V21.D[1], X20
    FMOV  D22, X6
    FMOV  V22.D[1], X10
    FMOV  D23, X18
    FMOV  V23.D[1], X20
    FMOV  D24, X2
    FMOV  V24.D[1], X10
    FMOV  D25, X8
    FMOV  V25.D[1], X9
    FMOV  D26, X4
    FMOV  V26.D[1], X4
    FMOV  D27, X13
    FMOV  V27.D[1], X16
    FMOV  D28, X19
    FMOV  V28.D[1], X2
    FMOV  D29, X13
    FMOV  V29.D[1], X3
    FMOV  D30, X18
    FMOV  V30.D[1], X9
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X29, #0xa, LSL #0
TSRTFloatMinMax_label_8:
    FMINNM  D18, D26, D0
    FMINNM  D6, D29, D29
    FMINNM  D7, D24, D28
    FMAX  S26, S7, S17
    FMAX  S21, S22, S31
    FMINNM  D3, D29, D19
    FMIN  S14, S21, S3
    FMAXNM  H18, H25, H6
    FMINNM  S8, S27, S20
    FMAXNM  H25, H30, H21
    FMAXNM  H29, H0, H14
    FMIN  H1, H26, H29
    FMIN  D24, D31, D18
    FMINNM  S12, S24, S8
    FMIN  H17, H1, H1
    FMAX  S23, S17, S27
    FMAXNM  S21, S10, S12
    FMAXNM  S24, S25, S5
    FMIN  S14, S21, S21
    FMIN  H20, H14, H23
    FMAX  H3, H17, H14
    FMIN  H0, H27, H3
    FMAXNM  S12, S26, S10
    FMAXNM  H14, H18, H11
    FMAXNM  D18, D9, D23
    FMAXNM  D5, D27, D12
    FMINNM  S8, S20, S0
    FMIN  S9, S5, S28
    FMAXNM  H25, H26, H8
    FMINNM  D23, D27, D25
    FMIN  S3, S15, S23
    FMAX  S24, S10, S24
    FMINNM  H25, H0, H8
    FMINNM  D1, D27, D27
    FMINNM  H17, H8, H26
    FMAXNM  H31, H13, H4
    FMAXNM  H29, H14, H28
    FMINNM  S21, S30, S1
    FMIN  S11, S23, S23
    FMAXNM  D14, D9, D9
    FMAXNM  D8, D21, D11
    FMAXNM  H26, H8, H15
    FMAX  S27, S21, S28
    FMIN  H20, H14, H17
    FMINNM  D8, D29, D18
    FMIN  H9, H24, H25
    FMIN  H11, H26, H9
    FMAX  D17, D10, D6
    FMAX  D30, D5, D17
    FMIN  D28, D20, D11
    FMAXNM  D12, D12, D26
    FMINNM  H10, H27, H23
    FMAX  D15, D26, D28
    FMAX  D9, D31, D27
    FMAX  D27, D9, D9
    FMAX  H17, H3, H15
    FMIN  H1, H17, H16
    FMAX  S28, S0, S10
    FMAXNM  H4, H28, H19
    FMAXNM  S1, S1, S8
    FMINNM  D8, D9, D1
    FMAX  S0, S8, S8
    FMAXNM  D15, D3, D12
    FMIN  S21, S4, S30
    FMAX  S11, S20, S27
    FMAXNM  D26, D21, D15
    FMAX  D3, D20, D13
    FMIN  H8, H28, H26
    FMIN  D27, D9, D11
    FMIN  S21, S31, S3
    FMAXNM  S19, S8, S3
    FMAX  H26, H19, H27
    FMAX  S19, S19, S25
    FMAX  D10, D25, D27
    FMAXNM  D3, D21, D10
    FMAX  D25, D13, D19
    FMINNM  D21, D25, D3
    FMAXNM  D17, D8, D26
    FMAX  D10, D21, D0
    FMAXNM  D12, D30, D2
    FMAXNM  H4, H31, H26
    FMINNM  S19, S14, S15
    FMAXNM  D31, D22, D11
    FMINNM  S26, S10, S26
    FMINNM  D28, D9, D17
    FMIN  H21, H19, H15
    FMIN  H0, H5, H15
    FMINNM  D26, D31, D3
    FMAX  S13, S0, S21
    FMIN  H30, H2, H0
    FMINNM  S21, S5, S16
    FMAX  D19, D27, D18
    FMIN  S20, S23, S23
    FMAXNM  S8, S13, S31
    FMAXNM  S23, S8, S19
    FMAX  H16, H12, H26
    FMAX  D10, D16, D19
    FMINNM  H12, H26, H3
    FMINNM  D18, D28, D12
    FMAXNM  S26, S4, S29
    FMAXNM  D13, D6, D30
    FMIN  D9, D18, D26
    FMIN  S15, S13, S20
    FMAX  H13, H13, H23
    FMIN  H16, H9, H15
    FMIN  H19, H16, H16
    FMAXNM  D28, D10, D3
    FMIN  H20, H15, H13
    FMIN  H31, H19, H7
    FMIN  D30, D31, D21
    FMAXNM  S23, S30, S30
    FMAX  D11, D13, D23
    FMIN  D10, D14, D11
    FMINNM  D3, D28, D28
    FMIN  H23, H20, H10
    FMAX  H31, H26, H18
    FMINNM  S11, S2, S16
    FMIN  S28, S11, S30
    FMINNM  S12, S24, S27
    FMAX  H9, H5, H13
    FMIN  S18, S21, S23
    FMIN  H11, H8, H8
    FMIN  S27, S28, S10
    FMAXNM  H28, H17, H12
    FMAXNM  S20, S7, S10
    FMAXNM  H23, H15, H25
    FMIN  D14, D28, D3
    FMINNM  D3, D15, D6
    FMIN  H21, H19, H12
    FMAXNM  H8, H14, H23
    FMAXNM  S24, S7, S7
    FMAX  H16, H20, H27
    FMINNM  H20, H19, H24
    FMIN  D3, D18, D5
    FMAX  H14, H23, H6
    FMAX  D2, D8, D11
    FMIN  D15, D26, D25
    FMIN  S25, S14, S20
    FMINNM  S0, S25, S2
    FMIN  D7, D5, D3
    FMAX  H8, H15, H7
    FMAX  D13, D0, D9
    FMINNM  S3, S22, S21
    FMIN  D17, D4, D3
    FMAXNM  S3, S31, S31
    FMINNM  H27, H3, H10
    FMAX  H18, H13, H8
    FMIN  H0, H27, H18
    FMIN  D15, D16, D19
    FMAXNM  S12, S0, S17
    FMINNM  S10, S24, S24
    FMAX  H26, H7, H9
    FMINNM  H28, H8, H11
    FMIN  S7, S22, S2
    FMIN  H8, H7, H9
    FMIN  D10, D7, D7
    FMINNM  D13, D0, D12
    FMAX  S2, S18, S3
    FMAX  H16, H15, H31
    FMAX  D9, D18, D3
    FMINNM  D15, D4, D31
    FMAX  H7, H8, H26
    FMIN  S19, S10, S16
    FMIN  H12, H9, H22
    FMIN  D24, D15, D20
    FMIN  H9, H2, H0
    FMINNM  D17, D19, D17
    FMINNM  D20, D26, D4
    FMAXNM  H21, H24, H1
    FMIN  D11, D29, D6
    FMIN  S22, S21, S20
    FMAX  H29, H12, H7
    FMINNM  H24, H28, H28
    FMAX  S4, S19, S11
    FMINNM  S12, S4, S13
    FMINNM  D26, D11, D31
    FMAXNM  S4, S9, S17
    FMAXNM  D7, D4, D29
    FMIN  H23, H24, H12
    FMIN  D1, D9, D26
    FMAX  H19, H22, H31
    FMIN  S26, S23, S7
    FMAX  S24, S2, S13
    FMAX  H28, H16, H19
    FMIN  D28, D1, D13
    FMINNM  D22, D26, D5
    FMIN  S4, S25, S1
    FMINNM  S11, S24, S4
    FMAX  S2, S28, S28
    FMAXNM  S7, S26, S22
    FMAX  D23, D7, D7
    FMINNM  H19, H11, H11
    FMAX  D4, D8, D2
    FMAX  S29, S19, S19
    FMAX  D4, D29, D26
    FMINNM  D29, D4, D25
    FMIN  D13, D17, D17
    FMIN  S19, S23, S0
    FMINNM  S31, S4, S21
    FMIN  D23, D9, D23
    SUBS  X29, X29, #0x1
    B.NE  TSRTFloatMinMax_label_8
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X14, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MRS  X12, FPSR
    MOVZ  X14, #0x80, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D0
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D1
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D14
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D29
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    FMOV  X12, D31
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X18
    FMOV  D1, X21
    FMOV  V1.D[1], X20
    FMOV  D2, X19
    FMOV  V2.D[1], X3
    FMOV  D3, X29
    FMOV  V3.D[1], X23
    FMOV  D4, X6
    FMOV  V4.D[1], X4
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X8
    FMOV  V6.D[1], X8
    FMOV  D7, X10
    FMOV  V7.D[1], X17
    FMOV  D8, X10
    FMOV  V8.D[1], X18
    FMOV  D9, X18
    FMOV  V9.D[1], X21
    FMOV  D10, X5
    FMOV  V10.D[1], X18
    FMOV  D11, X21
    FMOV  V11.D[1], X4
    FMOV  D12, X9
    FMOV  V12.D[1], X13
    FMOV  D13, X29
    FMOV  V13.D[1], X12
    FMOV  D14, X21
    FMOV  V14.D[1], X11
    FMOV  D15, X29
    FMOV  V15.D[1], X12
    FMOV  D16, X11
    FMOV  V16.D[1], X20
    FMOV  D17, X29
    FMOV  V17.D[1], X11
    FMOV  D18, X13
    FMOV  V18.D[1], X11
    FMOV  D19, X22
    FMOV  V19.D[1], X6
    FMOV  D20, X18
    FMOV  V20.D[1], X14
    FMOV  D21, X3
    FMOV  V21.D[1], X3
    FMOV  D22, X17
    FMOV  V22.D[1], X10
    FMOV  D23, X13
    FMOV  V23.D[1], X22
    FMOV  D24, X2
    FMOV  V24.D[1], X11
    FMOV  D25, X8
    FMOV  V25.D[1], X15
    FMOV  D26, X8
    FMOV  V26.D[1], X23
    FMOV  D27, X29
    FMOV  V27.D[1], X8
    FMOV  D28, X10
    FMOV  V28.D[1], X9
    FMOV  D29, X14
    FMOV  V29.D[1], X16
    FMOV  D30, X16
    FMOV  V30.D[1], X7
    FMOV  D31, X22
    FMOV  V31.D[1], X4
    MOVZ  X11, #0xa, LSL #0
TSRTFloatMinMax_label_9:
    FMAXNM  S16, S23, S21
    FMAXNM  D18, D8, D31
    FMAX  S6, S20, S28
    FMAX  D16, D26, D16
    FMAX  D7, D27, D18
    FMAXNM  D8, D18, D25
    FMAXNM  S11, S8, S7
    FMAXNM  H18, H30, H22
    FMAX  D9, D24, D16
    FMAX  S21, S9, S6
    FMAX  S27, S30, S7
    FMAX  H7, H2, H19
    FMIN  S19, S11, S9
    FMAX  H2, H18, H29
    FMINNM  S12, S16, S27
    FMINNM  S31, S9, S29
    FMINNM  S28, S2, S19
    FMINNM  S27, S7, S31
    FMAXNM  D20, D21, D28
    FMAX  S19, S27, S30
    FMAXNM  D12, D20, D27
    FMAXNM  H6, H19, H11
    FMIN  D26, D22, D6
    FMINNM  H2, H2, H23
    FMAXNM  S19, S22, S3
    FMAX  H9, H18, H25
    FMAX  H11, H4, H11
    FMIN  S8, S22, S29
    FMAX  S4, S22, S6
    FMINNM  H22, H11, H19
    FMAX  H31, H17, H13
    FMAXNM  H24, H5, H15
    FMINNM  D5, D9, D9
    FMAX  S7, S8, S5
    FMAXNM  H19, H26, H4
    FMAX  S6, S19, S26
    FMIN  D5, D31, D22
    FMIN  S25, S5, S26
    FMAX  S11, S24, S19
    FMAX  D22, D6, D22
    FMAX  H19, H2, H2
    FMAX  H5, H11, H27
    FMAXNM  H11, H18, H19
    FMIN  D26, D1, D7
    FMAXNM  D6, D12, D16
    FMINNM  D18, D11, D2
    FMINNM  S4, S22, S23
    FMINNM  S31, S26, S22
    FMINNM  D16, D18, D4
    FMINNM  S4, S31, S6
    FMAX  D7, D4, D22
    FMINNM  H23, H16, H16
    FMIN  H19, H6, H23
    FMIN  H8, H5, H19
    FMIN  H28, H25, H2
    FMINNM  S16, S23, S30
    FMAX  D5, D16, D16
    FMAXNM  H13, H5, H5
    FMAXNM  H1, H16, H7
    FMAXNM  D18, D21, D13
    FMAXNM  H25, H18, H2
    FMAXNM  D26, D1, D27
    FMIN  D19, D26, D24
    FMAXNM  S20, S11, S28
    FMAX  H1, H17, H19
    FMAXNM  S27, S4, S31
    FMINNM  H17, H24, H2
    FMAX  D26, D27, D10
    FMINNM  D18, D8, D25
    FMIN  S27, S19, S29
    FMIN  H2, H16, H18
    FMAXNM  S9, S26, S27
    FMINNM  S28, S2, S14
    FMAXNM  S22, S20, S0
    FMINNM  D2, D1, D9
    FMAX  H1, H18, H17
    FMAX  D9, D22, D25
    FMAXNM  D25, D9, D21
    FMIN  H0, H22, H25
    FMINNM  H9, H22, H2
    FMIN  D29, D9, D22
    FMIN  D10, D28, D28
    FMAX  S21, S29, S10
    FMINNM  D23, D21, D30
    FMAX  S24, S23, S1
    FMAX  D8, D10, D13
    FMINNM  H23, H29, H31
    FMAXNM  D21, D11, D23
    FMAX  H0, H9, H30
    FMAX  S11, S1, S25
    FMIN  D9, D28, D25
    FMIN  S30, S30, S2
    FMAX  S25, S1, S21
    FMINNM  H28, H20, H27
    FMAX  S27, S25, S22
    FMIN  S31, S17, S17
    FMINNM  S2, S1, S18
    FMAX  D21, D11, D27
    FMINNM  S22, S5, S30
    FMIN  S18, S9, S31
    FMINNM  D13, D28, D2
    FMINNM  H24, H0, H18
    FMAXNM  H11, H21, H21
    FMAX  S28, S19, S13
    FMAXNM  H2, H28, H22
    FMAX  S1, S24, S8
    FMINNM  S31, S2, S11
    FMINNM  D17, D12, D29
    FMAX  S25, S26, S7
    FMIN  D18, D30, D17
    FMIN  H9, H18, H18
    FMAXNM  S8, S21, S13
    FMIN  S26, S8, S11
    FMINNM  S12, S16, S4
    FMAXNM  H27, H0, H24
    FMAXNM  H10, H29, H20
    FMAXNM  D16, D27, D28
    FMAX  D3, D28, D13
    FMAXNM  H27, H1, H10
    FMAXNM  H4, H16, H27
    FMINNM  D21, D12, D25
    FMIN  D5, D26, D3
    FMIN  H4, H9, H11
    FMAX  S25, S18, S21
    FMAXNM  D28, D23, D22
    FMAXNM  D30, D26, D31
    FMINNM  S12, S28, S26
    FMINNM  H18, H1, H0
    FMIN  S17, S6, S18
    FMAX  D24, D17, D0
    FMAXNM  H26, H4, H4
    FMAXNM  D18, D12, D27
    FMAXNM  S1, S4, S29
    FMIN  H6, H1, H5
    FMAX  H4, H18, H18
    FMAXNM  H0, H10, H4
    FMINNM  D16, D26, D26
    FMIN  H11, H24, H19
    FMAXNM  H18, H25, H30
    FMAX  D21, D6, D0
    FMIN  H16, H10, H11
    FMAXNM  H28, H11, H6
    FMAXNM  S14, S11, S21
    FMAX  S0, S16, S16
    FMAX  H6, H1, H11
    FMAX  S16, S28, S14
    FMAX  H10, H21, H2
    FMAX  S17, S23, S16
    FMAXNM  D19, D18, D10
    FMINNM  S27, S17, S0
    FMAXNM  D4, D27, D6
    FMIN  S6, S24, S31
    FMINNM  D21, D6, D20
    FMINNM  H31, H15, H2
    FMAXNM  D6, D29, D26
    FMIN  S20, S28, S11
    FMINNM  S2, S4, S14
    FMAX  D11, D8, D17
    FMAX  D29, D14, D4
    FMAXNM  H24, H21, H7
    FMAX  S5, S10, S15
    FMINNM  H27, H2, H20
    FMAX  D26, D11, D11
    FMAX  S0, S6, S6
    FMAX  D1, D19, D0
    FMIN  S30, S27, S18
    FMIN  S7, S1, S31
    FMINNM  D15, D1, D19
    FMIN  S6, S7, S5
    FMIN  D18, D30, D14
    FMIN  D24, D26, D29
    FMAXNM  H21, H15, H18
    FMIN  H8, H6, H24
    FMINNM  S25, S11, S4
    FMINNM  S29, S14, S8
    FMINNM  H19, H26, H1
    FMIN  D30, D14, D2
    FMIN  S17, S29, S14
    FMAX  S5, S20, S9
    FMINNM  H7, H30, H23
    FMAXNM  D21, D11, D1
    FMAXNM  S20, S12, S0
    FMINNM  S11, S6, S2
    FMIN  H10, H5, H31
    FMIN  S28, S30, S30
    FMAXNM  D19, D25, D10
    FMAX  S1, S2, S20
    FMAX  D27, D2, D4
    FMAXNM  H18, H3, H11
    FMAX  H20, H28, H1
    FMAX  D29, D22, D20
    FMAX  H19, H3, H27
    FMAXNM  S0, S17, S21
    FMINNM  H6, H7, H19
    FMINNM  D12, D8, D21
    FMINNM  S17, S24, S6
    FMAX  S7, S17, S29
    FMIN  H2, H29, H7
    FMINNM  D15, D0, D12
    FMAX  S21, S2, S15
    SUBS  X11, X11, #0x1
    B.NE  TSRTFloatMinMax_label_9
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X4, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMinMax_TestFail
    MRS  X18, FPSR
    MOVZ  X4, #0x80, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    FMOV  X18, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X2, #0x679a, LSL #0
    MOVK  X2, #0x6400, LSL #16
    MOVK  X2, #0xc6d, LSL #32
    MOVK  X2, #0xad24, LSL #48
    MOVZ  X3, #0x8035, LSL #0
    MOVK  X3, #0x81d5, LSL #16
    MOVK  X3, #0x454d, LSL #32
    MOVK  X3, #0xa013, LSL #48
    MOVZ  X4, #0x25a2, LSL #0
    MOVK  X4, #0x16af, LSL #16
    MOVK  X4, #0x6d2b, LSL #32
    MOVK  X4, #0x4bb2, LSL #48
    MOVZ  X5, #0x7aa9, LSL #0
    MOVK  X5, #0xef35, LSL #16
    MOVK  X5, #0x79e5, LSL #32
    MOVK  X5, #0x1d8e, LSL #48
    MOVZ  X6, #0x395d, LSL #0
    MOVK  X6, #0xc288, LSL #16
    MOVK  X6, #0xa336, LSL #32
    MOVK  X6, #0x1c5, LSL #48
    MOVZ  X7, #0xafdb, LSL #0
    MOVK  X7, #0x6835, LSL #16
    MOVK  X7, #0xf4e0, LSL #32
    MOVK  X7, #0x2e99, LSL #48
    MOVZ  X8, #0x80f1, LSL #0
    MOVK  X8, #0xb36e, LSL #16
    MOVK  X8, #0x618f, LSL #32
    MOVK  X8, #0xa95b, LSL #48
    MOVZ  X9, #0xb1a5, LSL #0
    MOVK  X9, #0xe648, LSL #16
    MOVK  X9, #0x29a6, LSL #32
    MOVK  X9, #0x9654, LSL #48
    MOVZ  X10, #0xef9d, LSL #0
    MOVK  X10, #0x6041, LSL #16
    MOVK  X10, #0xa5e2, LSL #32
    MOVK  X10, #0x9d33, LSL #48
    MOVZ  X11, #0x12ba, LSL #0
    MOVK  X11, #0xf422, LSL #16
    MOVK  X11, #0x9996, LSL #32
    MOVK  X11, #0xd2c2, LSL #48
    MOVZ  X12, #0x3129, LSL #0
    MOVK  X12, #0x2c7c, LSL #16
    MOVK  X12, #0x8418, LSL #32
    MOVK  X12, #0xf5eb, LSL #48
    MOVZ  X13, #0x809, LSL #0
    MOVK  X13, #0x828f, LSL #16
    MOVK  X13, #0x285a, LSL #32
    MOVK  X13, #0xd407, LSL #48
    MOVZ  X14, #0x7fd, LSL #0
    MOVK  X14, #0xe3a1, LSL #16
    MOVK  X14, #0xbfb9, LSL #32
    MOVK  X14, #0xe161, LSL #48
    MOVZ  X15, #0x6c2b, LSL #0
    MOVK  X15, #0x4d53, LSL #16
    MOVK  X15, #0xb0d2, LSL #32
    MOVK  X15, #0x3e27, LSL #48
    MOVZ  X16, #0x9d76, LSL #0
    MOVK  X16, #0x8f95, LSL #16
    MOVK  X16, #0x8f5e, LSL #32
    MOVK  X16, #0x3b9f, LSL #48
    MOVZ  X17, #0x9774, LSL #0
    MOVK  X17, #0xe00c, LSL #16
    MOVK  X17, #0x8c10, LSL #32
    MOVK  X17, #0x909c, LSL #48
    MOVZ  X18, #0x9e82, LSL #0
    MOVK  X18, #0xb184, LSL #16
    MOVK  X18, #0x92a9, LSL #32
    MOVK  X18, #0x55f2, LSL #48
    MOVZ  X19, #0x1ae1, LSL #0
    MOVK  X19, #0x60cb, LSL #16
    MOVK  X19, #0x590f, LSL #32
    MOVK  X19, #0x826f, LSL #48
    MOVZ  X20, #0xb5dc, LSL #0
    MOVK  X20, #0x4ef1, LSL #16
    MOVK  X20, #0x2963, LSL #32
    MOVK  X20, #0x8f2d, LSL #48
    MOVZ  X21, #0x3a18, LSL #0
    MOVK  X21, #0x6bb4, LSL #16
    MOVK  X21, #0x9105, LSL #32
    MOVK  X21, #0xd0ca, LSL #48
    MOVZ  X22, #0x3e, LSL #0
    MOVK  X22, #0x3f97, LSL #16
    MOVK  X22, #0x33f2, LSL #32
    MOVK  X22, #0xe0c0, LSL #48
    MOVZ  X23, #0xde27, LSL #0
    MOVK  X23, #0xe00f, LSL #16
    MOVK  X23, #0x8a3f, LSL #32
    MOVK  X23, #0x6a6b, LSL #48
    MOVZ  X29, #0xc1df, LSL #0
    MOVK  X29, #0x8444, LSL #16
    MOVK  X29, #0x79de, LSL #32
    MOVK  X29, #0x5987, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X4
    FMOV  D1, X17
    FMOV  V1.D[1], X22
    FMOV  D2, X21
    FMOV  V2.D[1], X19
    FMOV  D3, X23
    FMOV  V3.D[1], X2
    FMOV  D4, X29
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X14
    FMOV  D6, X22
    FMOV  V6.D[1], X10
    FMOV  D7, X2
    FMOV  V7.D[1], X4
    FMOV  D8, X8
    FMOV  V8.D[1], X10
    FMOV  D9, X29
    FMOV  V9.D[1], X15
    FMOV  D10, X17
    FMOV  V10.D[1], X21
    FMOV  D11, X10
    FMOV  V11.D[1], X5
    FMOV  D12, X6
    FMOV  V12.D[1], X16
    FMOV  D13, X12
    FMOV  V13.D[1], X13
    FMOV  D14, X3
    FMOV  V14.D[1], X21
    FMOV  D15, X29
    FMOV  V15.D[1], X12
    FMOV  D16, X6
    FMOV  V16.D[1], X9
    FMOV  D17, X23
    FMOV  V17.D[1], X29
    FMOV  D18, X15
    FMOV  V18.D[1], X16
    FMOV  D19, X22
    FMOV  V19.D[1], X18
    FMOV  D20, X23
    FMOV  V20.D[1], X21
    FMOV  D21, X5
    FMOV  V21.D[1], X14
    FMOV  D22, X12
    FMOV  V22.D[1], X13
    FMOV  D23, X20
    FMOV  V23.D[1], X8
    FMOV  D24, X11
    FMOV  V24.D[1], X13
    FMOV  D25, X9
    FMOV  V25.D[1], X7
    FMOV  D26, X5
    FMOV  V26.D[1], X23
    FMOV  D27, X17
    FMOV  V27.D[1], X16
    FMOV  D28, X3
    FMOV  V28.D[1], X14
    FMOV  D29, X8
    FMOV  V29.D[1], X4
    FMOV  D30, X5
    FMOV  V30.D[1], X3
    FMOV  D31, X17
    FMOV  V31.D[1], X20
    MOVZ  X13, #0xa, LSL #0
TSRTFloatMinMax_label_10:
    FMINNM  H9, H28, H28
    FMAXNM  D30, D13, D5
    FMIN  D22, D31, D31
    FMAX  D29, D9, D30
    FMINNM  S2, S8, S30
    FMAXNM  S25, S25, S29
    FMIN  H15, H27, H15
    FMIN  S15, S24, S19
    FMIN  D9, D26, D2
    FMIN  H0, H15, H22
    FMINNM  D8, D25, D0
    FMAXNM  H30, H9, H8
    FMAXNM  D19, D9, D31
    FMIN  H31, H5, H8
    FMINNM  D8, D11, D31
    FMINNM  S2, S4, S0
    FMIN  D16, D23, D9
    FMAX  S11, S12, S24
    FMINNM  H11, H31, H12
    FMAX  D28, D5, D5
    FMAX  D25, D18, D26
    FMAX  H9, H9, H24
    FMIN  S29, S28, S19
    FMIN  D3, D21, D8
    FMIN  S23, S29, S16
    FMINNM  S28, S3, S23
    FMAXNM  H13, H30, H1
    FMIN  H4, H6, H26
    FMAX  D1, D20, D11
    FMIN  S24, S25, S2
    FMINNM  H30, H4, H28
    FMINNM  S31, S13, S17
    FMIN  S8, S1, S17
    FMINNM  S18, S13, S30
    FMIN  H3, H3, H24
    FMAX  S7, S18, S21
    FMAX  H19, H26, H8
    FMAXNM  S1, S9, S15
    FMIN  D25, D2, D22
    FMAXNM  D12, D25, D30
    FMAXNM  S4, S19, S3
    FMIN  S20, S11, S30
    FMIN  H29, H17, H7
    FMINNM  H21, H31, H24
    FMIN  H5, H29, H19
    FMIN  D30, D1, D20
    FMAX  H11, H30, H21
    FMAX  H6, H11, H4
    FMAXNM  H21, H8, H2
    FMAXNM  S25, S12, S5
    FMINNM  S2, S25, S25
    FMINNM  S16, S21, S21
    FMAXNM  S26, S2, S16
    FMINNM  H28, H13, H1
    FMAXNM  H11, H4, H27
    FMAX  D24, D25, D24
    FMAXNM  D19, D19, D17
    FMAX  H21, H3, H22
    FMAXNM  S1, S29, S28
    FMAXNM  D30, D16, D31
    FMINNM  D29, D20, D10
    FMAXNM  H5, H11, H29
    FMINNM  D11, D24, D19
    FMINNM  H29, H30, H6
    FMINNM  D28, D21, D23
    FMIN  S31, S1, S5
    FMAX  D22, D26, D21
    FMAX  H15, H28, H30
    FMIN  H20, H29, H15
    FMAX  S17, S18, S12
    FMAX  H18, H11, H11
    FMIN  H1, H2, H20
    FMAX  D26, D20, D10
    FMINNM  H23, H22, H26
    FMAX  S25, S23, S9
    FMAX  S20, S1, S5
    FMINNM  D23, D4, D25
    FMAXNM  H24, H15, H20
    FMAXNM  H16, H23, H15
    FMAXNM  S25, S13, S18
    FMAXNM  H20, H24, H24
    FMIN  H4, H12, H17
    FMAXNM  H5, H17, H23
    FMAX  D29, D25, D4
    FMINNM  S17, S20, S29
    FMAXNM  D28, D6, D17
    FMAX  D20, D25, D16
    FMIN  H16, H20, H26
    FMIN  D20, D14, D16
    FMIN  H18, H5, H4
    FMAXNM  D24, D20, D31
    FMIN  D22, D18, D25
    FMAX  S20, S24, S28
    FMAX  H18, H10, H15
    FMIN  D12, D31, D20
    FMAXNM  S23, S14, S7
    FMIN  S14, S31, S2
    FMAXNM  D24, D14, D11
    FMAXNM  S4, S13, S9
    FMIN  D13, D11, D20
    FMINNM  S26, S8, S5
    FMINNM  D17, D17, D21
    FMAX  D5, D18, D12
    FMAX  D29, D13, D8
    FMINNM  D11, D4, D5
    FMAX  S4, S29, S26
    FMAX  D16, D22, D22
    FMAX  H22, H12, H23
    FMAX  H12, H11, H24
    FMAX  S13, S21, S16
    FMAXNM  S28, S17, S22
    FMIN  H6, H5, H22
    FMIN  H16, H12, H17
    FMAX  D10, D15, D26
    FMAXNM  D8, D16, D4
    FMAX  D15, D28, D14
    FMAXNM  S5, S6, S5
    FMAXNM  D11, D8, D24
    FMAXNM  D23, D15, D5
    FMAXNM  H15, H23, H23
    FMIN  H22, H13, H13
    FMAXNM  H25, H25, H13
    FMAXNM  D25, D10, D12
    FMIN  D24, D11, D22
    FMAXNM  S14, S24, S0
    FMAX  H4, H15, H15
    FMAX  H6, H8, H2
    FMAX  D13, D4, D25
    FMINNM  H22, H5, H13
    FMAX  H13, H22, H22
    FMAX  D11, D24, D13
    FMINNM  S5, S13, S20
    FMIN  S2, S6, S12
    FMAX  S13, S30, S2
    FMAXNM  D0, D14, D11
    FMAX  S2, S5, S0
    FMAXNM  H4, H26, H5
    FMIN  H11, H20, H24
    FMAXNM  S10, S5, S20
    FMIN  H25, H0, H17
    FMAX  D13, D13, D1
    FMAXNM  S15, S29, S29
    FMINNM  H24, H21, H3
    FMIN  D14, D14, D3
    FMIN  D5, D24, D25
    FMAXNM  S17, S13, S2
    FMINNM  S12, S10, S10
    FMINNM  D3, D9, D12
    FMIN  D14, D4, D3
    FMAX  H29, H5, H14
    FMIN  S14, S11, S17
    FMINNM  D26, D29, D15
    FMINNM  H27, H23, H9
    FMINNM  D2, D13, D20
    FMINNM  H12, H12, H4
    FMAX  S11, S11, S8
    FMAXNM  D9, D31, D31
    FMAX  H25, H20, H23
    FMINNM  D10, D23, D0
    FMAXNM  D8, D2, D10
    FMINNM  D28, D23, D10
    FMINNM  S4, S4, S25
    FMIN  H0, H12, H27
    FMINNM  H25, H13, H26
    FMAXNM  H3, H9, H11
    FMIN  H21, H25, H8
    FMINNM  H25, H9, H0
    FMAX  D4, D25, D4
    FMAXNM  S10, S5, S28
    FMIN  D23, D10, D23
    FMIN  H2, H3, H24
    FMIN  S26, S30, S13
    FMAX  H28, H22, H26
    FMAX  H3, H17, H17
    FMAXNM  D21, D31, D2
    FMAXNM  S13, S3, S14
    FMIN  H10, H23, H13
    FMAX  S13, S21, S15
    FMINNM  H12, H4, H10
    FMAX  D3, D0, D28
    FMAXNM  H28, H14, H13
    FMAX  H14, H26, H3
    FMAXNM  H27, H19, H16
    FMAXNM  D31, D12, D31
    FMINNM  D13, D15, D27
    FMAXNM  H26, H13, H22
    FMIN  S19, S31, S0
    FMINNM  S24, S14, S15
    FMINNM  S14, S19, S10
    FMIN  H22, H10, H28
    FMAX  D4, D22, D18
    FMIN  S16, S24, S24
    FMAXNM  H20, H31, H26
    FMINNM  S28, S20, S3
    FMAXNM  S12, S28, S16
    FMINNM  S19, S15, S3
    FMAXNM  S2, S7, S4
    FMIN  D24, D19, D2
    FMAX  S31, S14, S24
    FMIN  D14, D16, D21
    SUBS  X13, X13, #0x1
    B.NE  TSRTFloatMinMax_label_10
    MOVZ  X4, #0x679a, LSL #0
    MOVK  X4, #0x6400, LSL #16
    MOVK  X4, #0xc6d, LSL #32
    MOVK  X4, #0xad24, LSL #48
    SUB  X5, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x8035, LSL #0
    MOVK  X4, #0x81d5, LSL #16
    MOVK  X4, #0x454d, LSL #32
    MOVK  X4, #0xa013, LSL #48
    SUB  X5, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x395d, LSL #0
    MOVK  X4, #0xc288, LSL #16
    MOVK  X4, #0xa336, LSL #32
    MOVK  X4, #0x1c5, LSL #48
    SUB  X5, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xafdb, LSL #0
    MOVK  X4, #0x6835, LSL #16
    MOVK  X4, #0xf4e0, LSL #32
    MOVK  X4, #0x2e99, LSL #48
    SUB  X5, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x80f1, LSL #0
    MOVK  X4, #0xb36e, LSL #16
    MOVK  X4, #0x618f, LSL #32
    MOVK  X4, #0xa95b, LSL #48
    SUB  X5, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xb1a5, LSL #0
    MOVK  X4, #0xe648, LSL #16
    MOVK  X4, #0x29a6, LSL #32
    MOVK  X4, #0x9654, LSL #48
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xef9d, LSL #0
    MOVK  X4, #0x6041, LSL #16
    MOVK  X4, #0xa5e2, LSL #32
    MOVK  X4, #0x9d33, LSL #48
    SUB  X5, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x12ba, LSL #0
    MOVK  X4, #0xf422, LSL #16
    MOVK  X4, #0x9996, LSL #32
    MOVK  X4, #0xd2c2, LSL #48
    SUB  X5, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x3129, LSL #0
    MOVK  X4, #0x2c7c, LSL #16
    MOVK  X4, #0x8418, LSL #32
    MOVK  X4, #0xf5eb, LSL #48
    SUB  X5, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x6c2b, LSL #0
    MOVK  X4, #0x4d53, LSL #16
    MOVK  X4, #0xb0d2, LSL #32
    MOVK  X4, #0x3e27, LSL #48
    SUB  X5, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x9d76, LSL #0
    MOVK  X4, #0x8f95, LSL #16
    MOVK  X4, #0x8f5e, LSL #32
    MOVK  X4, #0x3b9f, LSL #48
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x9774, LSL #0
    MOVK  X4, #0xe00c, LSL #16
    MOVK  X4, #0x8c10, LSL #32
    MOVK  X4, #0x909c, LSL #48
    SUB  X5, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x9e82, LSL #0
    MOVK  X4, #0xb184, LSL #16
    MOVK  X4, #0x92a9, LSL #32
    MOVK  X4, #0x55f2, LSL #48
    SUB  X5, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x1ae1, LSL #0
    MOVK  X4, #0x60cb, LSL #16
    MOVK  X4, #0x590f, LSL #32
    MOVK  X4, #0x826f, LSL #48
    SUB  X5, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xb5dc, LSL #0
    MOVK  X4, #0x4ef1, LSL #16
    MOVK  X4, #0x2963, LSL #32
    MOVK  X4, #0x8f2d, LSL #48
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x3a18, LSL #0
    MOVK  X4, #0x6bb4, LSL #16
    MOVK  X4, #0x9105, LSL #32
    MOVK  X4, #0xd0ca, LSL #48
    SUB  X5, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x3e, LSL #0
    MOVK  X4, #0x3f97, LSL #16
    MOVK  X4, #0x33f2, LSL #32
    MOVK  X4, #0xe0c0, LSL #48
    SUB  X5, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xde27, LSL #0
    MOVK  X4, #0xe00f, LSL #16
    MOVK  X4, #0x8a3f, LSL #32
    MOVK  X4, #0x6a6b, LSL #48
    SUB  X5, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0xc1df, LSL #0
    MOVK  X4, #0x8444, LSL #16
    MOVK  X4, #0x79de, LSL #32
    MOVK  X4, #0x5987, LSL #48
    SUB  X5, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MRS  X4, FPSR
    MOVZ  X5, #0x80, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D0
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D1
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D5
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D9
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D29
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D30
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    FMOV  X4, D31
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
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
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X6
    FMOV  V0.D[1], X16
    FMOV  D1, X18
    FMOV  V1.D[1], X14
    FMOV  D2, X21
    FMOV  V2.D[1], X19
    FMOV  D3, X15
    FMOV  V3.D[1], X9
    FMOV  D4, X12
    FMOV  V4.D[1], X23
    FMOV  D5, X20
    FMOV  V5.D[1], X22
    FMOV  D6, X29
    FMOV  V6.D[1], X12
    FMOV  D7, X17
    FMOV  V7.D[1], X11
    FMOV  D8, X6
    FMOV  V8.D[1], X19
    FMOV  D9, X13
    FMOV  V9.D[1], X10
    FMOV  D10, X2
    FMOV  V10.D[1], X8
    FMOV  D11, X8
    FMOV  V11.D[1], X7
    FMOV  D12, X23
    FMOV  V12.D[1], X21
    FMOV  D13, X6
    FMOV  V13.D[1], X15
    FMOV  D14, X18
    FMOV  V14.D[1], X20
    FMOV  D15, X20
    FMOV  V15.D[1], X4
    FMOV  D16, X10
    FMOV  V16.D[1], X2
    FMOV  D17, X13
    FMOV  V17.D[1], X16
    FMOV  D18, X16
    FMOV  V18.D[1], X22
    FMOV  D19, X2
    FMOV  V19.D[1], X11
    FMOV  D20, X2
    FMOV  V20.D[1], X8
    FMOV  D21, X15
    FMOV  V21.D[1], X17
    FMOV  D22, X9
    FMOV  V22.D[1], X10
    FMOV  D23, X23
    FMOV  V23.D[1], X22
    FMOV  D24, X12
    FMOV  V24.D[1], X3
    FMOV  D25, X20
    FMOV  V25.D[1], X17
    FMOV  D26, X5
    FMOV  V26.D[1], X2
    FMOV  D27, X6
    FMOV  V27.D[1], X8
    FMOV  D28, X15
    FMOV  V28.D[1], X8
    FMOV  D29, X3
    FMOV  V29.D[1], X14
    FMOV  D30, X22
    FMOV  V30.D[1], X3
    FMOV  D31, X4
    FMOV  V31.D[1], X12
    MOVZ  X5, #0xa, LSL #0
TSRTFloatMinMax_label_11:
    FMAX  H21, H24, H16
    FMAXNM  H24, H0, H4
    FMIN  S15, S30, S10
    FMINNM  D19, D15, D25
    FMAX  H15, H18, H16
    FMINNM  H24, H15, H28
    FMINNM  D11, D29, D26
    FMAX  D10, D3, D22
    FMAX  H24, H24, H24
    FMAX  S15, S21, S27
    FMINNM  H30, H31, H15
    FMAXNM  S27, S11, S19
    FMIN  H15, H19, H15
    FMIN  S7, S10, S24
    FMINNM  S4, S20, S30
    FMIN  H18, H23, H26
    FMAXNM  D3, D24, D4
    FMAX  D24, D8, D27
    FMAX  D20, D6, D21
    FMINNM  D6, D7, D27
    FMAXNM  H30, H3, H7
    FMAXNM  H11, H10, H6
    FMINNM  S10, S30, S25
    FMIN  D22, D12, D15
    FMIN  H28, H0, H20
    FMIN  D29, D22, D11
    FMIN  H8, H23, H24
    FMIN  H26, H7, H18
    FMAXNM  D19, D28, D29
    FMAXNM  S22, S29, S3
    FMIN  D6, D26, D10
    FMAX  H16, H3, H19
    FMINNM  S19, S6, S22
    FMAX  D31, D7, D28
    FMAXNM  S4, S31, S12
    FMAXNM  D29, D16, D29
    FMIN  H26, H29, H4
    FMAX  S22, S26, S23
    FMAX  S26, S19, S4
    FMAX  D18, D8, D9
    FMIN  H3, H26, H14
    FMINNM  D15, D3, D4
    FMINNM  S10, S18, S15
    FMINNM  S27, S6, S26
    FMIN  S15, S27, S3
    FMINNM  S14, S4, S6
    FMIN  D16, D0, D11
    FMINNM  S13, S28, S4
    FMAXNM  D19, D31, D5
    FMAX  H3, H20, H10
    FMAX  D26, D10, D28
    FMINNM  H20, H24, H30
    FMINNM  H10, H15, H8
    FMINNM  S30, S13, S4
    FMIN  S23, S30, S10
    FMIN  D13, D16, D12
    FMAXNM  H13, H6, H14
    FMIN  S31, S8, S8
    FMAXNM  S21, S12, S14
    FMIN  S8, S1, S2
    FMAX  D22, D23, D3
    FMAXNM  S3, S22, S4
    FMAXNM  H16, H13, H31
    FMAX  S23, S3, S21
    FMAX  D25, D19, D27
    FMAXNM  D0, D8, D8
    FMINNM  D26, D21, D2
    FMINNM  S8, S25, S26
    FMAXNM  H10, H0, H31
    FMAXNM  D3, D20, D28
    FMAX  H11, H17, H3
    FMAXNM  H27, H30, H8
    FMAX  D14, D29, D16
    FMINNM  S13, S14, S14
    FMIN  H5, H10, H8
    FMINNM  H19, H9, H27
    FMINNM  S9, S23, S1
    FMAX  H8, H11, H11
    FMIN  S11, S9, S13
    FMIN  D26, D19, D9
    FMINNM  H29, H30, H8
    FMINNM  S3, S5, S26
    FMIN  S1, S3, S29
    FMIN  H23, H3, H8
    FMAX  H27, H14, H21
    FMINNM  S31, S28, S7
    FMINNM  H2, H18, H0
    FMINNM  H19, H4, H28
    FMIN  S17, S24, S24
    FMAX  D20, D4, D31
    FMAXNM  S14, S4, S15
    FMIN  S26, S20, S19
    FMINNM  S15, S27, S23
    FMAXNM  D28, D14, D7
    FMAXNM  S21, S11, S28
    FMINNM  D28, D29, D22
    FMAXNM  H0, H28, H17
    FMAXNM  D22, D0, D0
    FMAX  H4, H2, H15
    FMINNM  S5, S17, S21
    FMAXNM  D21, D6, D5
    FMAXNM  S11, S21, S26
    FMAX  H18, H9, H0
    FMINNM  H6, H11, H18
    FMAX  S27, S22, S1
    FMINNM  D11, D28, D27
    FMAXNM  S18, S6, S5
    FMIN  S21, S11, S11
    FMIN  D2, D18, D4
    FMAXNM  D4, D27, D11
    FMIN  S23, S1, S0
    FMIN  D29, D28, D4
    FMAX  S6, S26, S20
    FMIN  D7, D7, D24
    FMINNM  D28, D9, D7
    FMIN  S4, S2, S18
    FMAX  S9, S10, S9
    FMAX  H23, H0, H5
    FMIN  S1, S11, S31
    FMIN  H22, H28, H12
    FMINNM  D10, D8, D8
    FMAXNM  H24, H9, H6
    FMINNM  S31, S1, S24
    FMAX  S24, S10, S21
    FMAXNM  H6, H24, H31
    FMIN  H2, H29, H29
    FMIN  D7, D6, D4
    FMAX  S6, S7, S11
    FMIN  S7, S11, S11
    FMAX  H21, H18, H2
    FMIN  H11, H4, H24
    FMINNM  S27, S11, S2
    FMAX  D28, D28, D6
    FMAXNM  S4, S14, S8
    FMAX  D18, D23, D28
    FMIN  S6, S21, S18
    FMIN  D12, D3, D6
    FMINNM  H11, H15, H7
    FMAXNM  H14, H12, H19
    FMINNM  H18, H27, H11
    FMIN  H29, H18, H22
    FMAX  D10, D16, D4
    FMINNM  H12, H29, H30
    FMAX  H19, H15, H0
    FMAXNM  H2, H12, H5
    FMAX  H6, H10, H20
    FMAX  D24, D30, D19
    FMAXNM  H12, H10, H24
    FMIN  D16, D14, D6
    FMINNM  H25, H12, H12
    FMAXNM  D5, D25, D2
    FMAX  H18, H2, H22
    FMIN  D28, D9, D27
    FMINNM  D10, D2, D24
    FMAX  H31, H25, H20
    FMAX  H23, H21, H18
    FMINNM  S29, S15, S11
    FMAX  H25, H22, H29
    FMINNM  D18, D3, D4
    FMAX  H21, H19, H17
    FMAX  S6, S31, S18
    FMINNM  H11, H28, H18
    FMAX  D24, D19, D16
    FMAX  D17, D11, D25
    FMAXNM  H9, H5, H17
    FMIN  S5, S6, S22
    FMAX  S9, S22, S14
    FMINNM  D19, D24, D11
    FMINNM  D24, D9, D21
    FMAX  D2, D31, D23
    FMIN  D3, D14, D19
    FMAX  D19, D10, D9
    FMAX  D15, D24, D2
    FMAXNM  D21, D18, D11
    FMAXNM  S0, S19, S13
    FMIN  S29, S5, S0
    FMINNM  H25, H21, H15
    FMAX  S13, S3, S2
    FMAXNM  D0, D5, D13
    FMAXNM  H3, H29, H0
    FMAX  S6, S0, S23
    FMINNM  D24, D23, D21
    FMAX  H24, H7, H14
    FMIN  D23, D1, D27
    FMAX  S19, S31, S12
    FMAX  S15, S18, S19
    FMAX  H29, H14, H8
    FMINNM  D14, D25, D11
    FMINNM  H18, H30, H6
    FMAX  H21, H28, H27
    FMIN  D27, D13, D24
    FMIN  S2, S31, S3
    FMAX  S0, S1, S12
    FMINNM  H25, H29, H18
    FMIN  S1, S8, S0
    FMIN  H24, H25, H25
    FMIN  S5, S10, S27
    FMAX  D30, D24, D14
    FMINNM  S3, S13, S1
    FMIN  D11, D5, D21
    SUBS  X5, X5, #0x1
    B.NE  TSRTFloatMinMax_label_11
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMinMax_TestFail
    MRS  X14, FPSR
    MOVZ  X2, #0x80, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    FMOV  X14, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X8
    FMOV  D2, X9
    FMOV  V2.D[1], X21
    FMOV  D3, X21
    FMOV  V3.D[1], X23
    FMOV  D4, X17
    FMOV  V4.D[1], X13
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X5
    FMOV  V6.D[1], X18
    FMOV  D7, X7
    FMOV  V7.D[1], X5
    FMOV  D8, X4
    FMOV  V8.D[1], X17
    FMOV  D9, X2
    FMOV  V9.D[1], X9
    FMOV  D10, X22
    FMOV  V10.D[1], X14
    FMOV  D11, X14
    FMOV  V11.D[1], X13
    FMOV  D12, X10
    FMOV  V12.D[1], X6
    FMOV  D13, X7
    FMOV  V13.D[1], X15
    FMOV  D14, X10
    FMOV  V14.D[1], X15
    FMOV  D15, X9
    FMOV  V15.D[1], X29
    FMOV  D16, X11
    FMOV  V16.D[1], X3
    FMOV  D17, X21
    FMOV  V17.D[1], X13
    FMOV  D18, X15
    FMOV  V18.D[1], X7
    FMOV  D19, X20
    FMOV  V19.D[1], X8
    FMOV  D20, X12
    FMOV  V20.D[1], X2
    FMOV  D21, X5
    FMOV  V21.D[1], X20
    FMOV  D22, X16
    FMOV  V22.D[1], X15
    FMOV  D23, X20
    FMOV  V23.D[1], X15
    FMOV  D24, X18
    FMOV  V24.D[1], X4
    FMOV  D25, X5
    FMOV  V25.D[1], X21
    FMOV  D26, X18
    FMOV  V26.D[1], X20
    FMOV  D27, X23
    FMOV  V27.D[1], X29
    FMOV  D28, X6
    FMOV  V28.D[1], X5
    FMOV  D29, X29
    FMOV  V29.D[1], X29
    FMOV  D30, X14
    FMOV  V30.D[1], X20
    FMOV  D31, X11
    FMOV  V31.D[1], X19
    MOVZ  X4, #0xa, LSL #0
TSRTFloatMinMax_label_12:
    FMAXNM  H18, H13, H23
    FMAXNM  S2, S27, S6
    FMIN  H23, H26, H21
    FMIN  S0, S25, S2
    FMINNM  S18, S0, S30
    FMINNM  S8, S31, S1
    FMIN  S28, S23, S18
    FMAX  S25, S3, S15
    FMIN  D6, D24, D29
    FMINNM  H13, H28, H25
    FMINNM  D28, D6, D8
    FMAXNM  D24, D18, D21
    FMINNM  S17, S16, S28
    FMAXNM  D26, D14, D24
    FMAX  S6, S17, S17
    FMAX  H1, H6, H23
    FMIN  H3, H12, H13
    FMAX  H18, H10, H26
    FMAXNM  D23, D10, D1
    FMAX  S30, S23, S3
    FMINNM  S25, S3, S21
    FMAX  S9, S4, S10
    FMIN  H31, H10, H3
    FMINNM  D27, D19, D11
    FMAX  D13, D10, D15
    FMAX  H0, H25, H29
    FMINNM  D23, D25, D9
    FMAX  H21, H26, H4
    FMAX  S3, S20, S29
    FMAX  H25, H0, H27
    FMIN  S3, S25, S13
    FMAX  S11, S21, S17
    FMIN  S1, S3, S30
    FMINNM  H9, H23, H15
    FMINNM  H8, H31, H11
    FMAXNM  H29, H21, H8
    FMIN  S26, S29, S15
    FMINNM  S25, S1, S13
    FMIN  H3, H26, H26
    FMIN  H23, H14, H3
    FMAXNM  S20, S7, S14
    FMIN  D8, D25, D23
    FMINNM  D6, D18, D9
    FMAX  H4, H20, H18
    FMAX  H27, H6, H6
    FMAXNM  D31, D27, D27
    FMIN  H14, H0, H4
    FMAXNM  S15, S3, S14
    FMAXNM  H26, H8, H2
    FMINNM  S17, S30, S26
    FMAXNM  S18, S17, S7
    FMAXNM  D30, D18, D15
    FMIN  S6, S6, S15
    FMINNM  S3, S18, S26
    FMIN  D18, D14, D12
    FMIN  H7, H22, H29
    FMAXNM  H25, H17, H20
    FMAX  H26, H24, H16
    FMAXNM  S20, S2, S2
    FMIN  S22, S6, S25
    FMIN  D6, D20, D22
    FMAX  S12, S3, S3
    FMAXNM  H8, H31, H26
    FMAX  S29, S7, S19
    FMINNM  H25, H6, H13
    FMINNM  H11, H29, H18
    FMAX  S14, S11, S25
    FMINNM  D15, D8, D18
    FMAX  H3, H12, H30
    FMIN  D18, D15, D13
    FMAX  D17, D3, D3
    FMINNM  S31, S18, S6
    FMAXNM  H24, H22, H14
    FMIN  H22, H24, H16
    FMAX  D20, D26, D21
    FMAXNM  H6, H22, H31
    FMIN  D19, D9, D17
    FMAX  D13, D20, D6
    FMAXNM  S8, S1, S23
    FMAXNM  D30, D3, D31
    FMINNM  S22, S25, S23
    FMAX  H5, H2, H17
    FMAXNM  S26, S26, S31
    FMAX  H20, H17, H29
    FMIN  H6, H16, H2
    FMIN  H1, H22, H8
    FMIN  D2, D13, D0
    FMINNM  H17, H16, H2
    FMAXNM  H18, H6, H17
    FMINNM  H2, H30, H1
    FMAXNM  D23, D2, D26
    FMAXNM  S8, S23, S29
    FMINNM  H22, H22, H10
    FMAX  H25, H8, H22
    FMINNM  D13, D19, D3
    FMINNM  D10, D18, D13
    FMAX  D17, D20, D31
    FMINNM  D2, D17, D14
    FMAX  H30, H11, H18
    FMINNM  S3, S7, S10
    FMAX  S8, S2, S3
    FMAX  H10, H8, H25
    FMAXNM  H29, H31, H10
    FMIN  H3, H7, H30
    FMAXNM  S18, S5, S29
    FMAX  D13, D30, D8
    FMAXNM  S25, S13, S20
    FMIN  D24, D7, D31
    FMAX  S29, S28, S9
    FMAX  D14, D27, D28
    FMAXNM  S22, S10, S15
    FMINNM  H9, H17, H4
    FMINNM  H4, H22, H11
    FMINNM  D10, D23, D8
    FMAXNM  D15, D10, D29
    FMAX  S6, S24, S8
    FMAXNM  S2, S3, S2
    FMINNM  H13, H18, H15
    FMIN  H17, H9, H22
    FMAXNM  D22, D19, D14
    FMIN  D20, D0, D9
    FMAXNM  H24, H20, H20
    FMIN  H15, H17, H27
    FMAXNM  H15, H14, H28
    FMAXNM  D19, D22, D19
    FMINNM  S28, S4, S25
    FMINNM  S1, S6, S2
    FMAX  H8, H13, H13
    FMAXNM  S18, S15, S10
    FMAXNM  H3, H13, H18
    FMINNM  D9, D29, D29
    FMINNM  S13, S1, S1
    FMINNM  H1, H9, H24
    FMAX  D27, D2, D13
    FMIN  S30, S27, S3
    FMINNM  H29, H24, H7
    FMAX  H18, H8, H28
    FMAX  D0, D3, D18
    FMAXNM  S23, S19, S29
    FMIN  S24, S23, S0
    FMAXNM  H7, H1, H10
    FMIN  D14, D7, D28
    FMAX  H6, H28, H18
    FMAXNM  S4, S1, S14
    FMAX  D22, D13, D24
    FMAXNM  S3, S4, S30
    FMINNM  H24, H6, H13
    FMAX  D0, D15, D3
    FMIN  H29, H24, H7
    FMAX  D23, D8, D29
    FMAX  H25, H0, H6
    FMAXNM  S5, S25, S9
    FMINNM  H0, H5, H18
    FMINNM  S19, S22, S14
    FMINNM  D14, D19, D0
    FMINNM  S13, S24, S17
    FMINNM  H7, H25, H6
    FMAXNM  H25, H0, H0
    FMINNM  S22, S3, S17
    FMIN  S25, S2, S13
    FMIN  H1, H16, H24
    FMINNM  H28, H28, H19
    FMINNM  D4, D13, D0
    FMAXNM  S22, S4, S28
    FMINNM  S15, S4, S3
    FMINNM  S9, S11, S2
    FMAX  D9, D25, D7
    FMAXNM  H16, H13, H24
    FMIN  H30, H28, H28
    FMIN  H6, H12, H3
    FMAXNM  H24, H23, H6
    FMAX  H18, H30, H15
    FMINNM  D1, D22, D16
    FMAX  H28, H1, H14
    FMINNM  S3, S18, S28
    FMINNM  D24, D3, D8
    FMAXNM  S12, S9, S24
    FMAXNM  H23, H25, H30
    FMAXNM  S30, S15, S5
    FMAX  D24, D30, D29
    FMINNM  S11, S5, S31
    FMAX  D18, D26, D18
    FMAXNM  H25, H23, H28
    FMIN  S3, S18, S12
    FMIN  D5, D26, D13
    FMINNM  D29, D9, D14
    FMIN  H7, H29, H20
    FMAX  S9, S11, S6
    FMAX  H22, H11, H15
    FMAX  S28, S13, S3
    FMAX  S1, S10, S19
    FMIN  S31, S14, S5
    FMAXNM  S1, S17, S18
    FMINNM  D29, D23, D1
    FMINNM  H10, H7, H9
    FMINNM  H2, H4, H8
    FMAXNM  S6, S24, S24
    FMAX  H25, H8, H2
    FMAXNM  H3, H31, H22
    FMINNM  H21, H22, H28
    SUBS  X4, X4, #0x1
    B.NE  TSRTFloatMinMax_label_12
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MRS  X17, FPSR
    MOVZ  X6, #0x80, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D1
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D25
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    FMOV  X17, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
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
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X29
    FMOV  D2, X21
    FMOV  V2.D[1], X19
    FMOV  D3, X3
    FMOV  V3.D[1], X7
    FMOV  D4, X4
    FMOV  V4.D[1], X29
    FMOV  D5, X6
    FMOV  V5.D[1], X13
    FMOV  D6, X2
    FMOV  V6.D[1], X8
    FMOV  D7, X23
    FMOV  V7.D[1], X23
    FMOV  D8, X16
    FMOV  V8.D[1], X11
    FMOV  D9, X19
    FMOV  V9.D[1], X29
    FMOV  D10, X11
    FMOV  V10.D[1], X12
    FMOV  D11, X13
    FMOV  V11.D[1], X7
    FMOV  D12, X4
    FMOV  V12.D[1], X15
    FMOV  D13, X17
    FMOV  V13.D[1], X20
    FMOV  D14, X8
    FMOV  V14.D[1], X15
    FMOV  D15, X11
    FMOV  V15.D[1], X7
    FMOV  D16, X11
    FMOV  V16.D[1], X20
    FMOV  D17, X14
    FMOV  V17.D[1], X15
    FMOV  D18, X7
    FMOV  V18.D[1], X12
    FMOV  D19, X18
    FMOV  V19.D[1], X10
    FMOV  D20, X5
    FMOV  V20.D[1], X17
    FMOV  D21, X6
    FMOV  V21.D[1], X11
    FMOV  D22, X23
    FMOV  V22.D[1], X9
    FMOV  D23, X2
    FMOV  V23.D[1], X6
    FMOV  D24, X3
    FMOV  V24.D[1], X17
    FMOV  D25, X15
    FMOV  V25.D[1], X18
    FMOV  D26, X11
    FMOV  V26.D[1], X7
    FMOV  D27, X2
    FMOV  V27.D[1], X22
    FMOV  D28, X29
    FMOV  V28.D[1], X18
    FMOV  D29, X7
    FMOV  V29.D[1], X14
    FMOV  D30, X13
    FMOV  V30.D[1], X11
    FMOV  D31, X16
    FMOV  V31.D[1], X4
    MOVZ  X23, #0xa, LSL #0
TSRTFloatMinMax_label_13:
    FMIN  H23, H25, H28
    FMIN  D19, D14, D27
    FMAX  S4, S30, S26
    FMIN  D18, D14, D20
    FMIN  H6, H18, H18
    FMINNM  H3, H6, H23
    FMIN  H19, H29, H19
    FMINNM  H8, H19, H3
    FMAX  D20, D30, D18
    FMAXNM  S13, S31, S4
    FMAXNM  S8, S29, S13
    FMAXNM  H29, H8, H11
    FMIN  S13, S20, S31
    FMAXNM  D6, D29, D29
    FMAX  S29, S14, S13
    FMIN  D18, D6, D28
    FMAX  H13, H12, H31
    FMIN  H20, H18, H28
    FMAX  S6, S29, S20
    FMAXNM  S28, S14, S3
    FMIN  H31, H6, H0
    FMAX  S27, S31, S31
    FMAXNM  S31, S4, S20
    FMAXNM  S14, S3, S6
    FMIN  S2, S2, S11
    FMINNM  D28, D0, D9
    FMAX  S12, S3, S24
    FMAXNM  D9, D3, D23
    FMAXNM  S4, S22, S8
    FMAXNM  S18, S12, S4
    FMAX  H26, H13, H2
    FMIN  H29, H28, H9
    FMAX  D8, D26, D25
    FMIN  S23, S29, S14
    FMINNM  H0, H31, H13
    FMAXNM  S29, S0, S27
    FMAXNM  H13, H12, H23
    FMAXNM  D22, D5, D17
    FMAXNM  D0, D29, D16
    FMAX  S12, S0, S0
    FMINNM  D2, D18, D14
    FMIN  D26, D2, D2
    FMIN  S9, S26, S26
    FMIN  S18, S16, S13
    FMAXNM  D17, D19, D22
    FMINNM  D5, D17, D12
    FMAX  H2, H2, H18
    FMAX  H31, H17, H25
    FMIN  H24, H31, H31
    FMAX  S20, S20, S29
    FMIN  S29, S20, S1
    FMIN  S26, S2, S8
    FMAXNM  S6, S29, S29
    FMAXNM  S19, S5, S24
    FMAXNM  S22, S19, S6
    FMINNM  D5, D22, D26
    FMINNM  D28, D12, D18
    FMAXNM  S16, S29, S27
    FMAX  S26, S4, S26
    FMAX  D0, D29, D4
    FMAXNM  H23, H21, H20
    FMAXNM  S20, S5, S21
    FMAXNM  S25, S8, S0
    FMAXNM  D9, D26, D16
    FMINNM  S3, S22, S30
    FMAXNM  H14, H31, H10
    FMINNM  H17, H17, H14
    FMAXNM  S30, S23, S21
    FMINNM  H12, H23, H15
    FMAXNM  S8, S29, S15
    FMIN  S23, S25, S30
    FMIN  D19, D26, D17
    FMAX  D0, D19, D12
    FMAX  H12, H8, H20
    FMINNM  D4, D23, D4
    FMAXNM  S17, S23, S20
    FMINNM  D16, D6, D0
    FMAX  D25, D4, D17
    FMINNM  D29, D16, D25
    FMIN  D22, D15, D12
    FMINNM  D14, D3, D29
    FMIN  D0, D28, D30
    FMAX  D28, D14, D4
    FMIN  S23, S25, S6
    FMAXNM  H17, H23, H0
    FMINNM  D25, D30, D17
    FMAX  D17, D25, D19
    FMAX  H16, H28, H22
    FMIN  S26, S16, S13
    FMAX  H22, H26, H17
    FMAXNM  S28, S16, S10
    FMIN  S8, S17, S5
    FMINNM  D20, D22, D8
    FMIN  D13, D28, D13
    FMINNM  H8, H12, H19
    FMAX  H30, H26, H11
    FMINNM  S6, S14, S16
    FMAXNM  H15, H14, H0
    FMINNM  S17, S11, S24
    FMINNM  D4, D28, D29
    FMAXNM  D11, D5, D2
    FMAXNM  D20, D13, D4
    FMINNM  D24, D17, D11
    FMAX  D16, D30, D5
    FMAXNM  D22, D9, D24
    FMIN  S3, S7, S22
    FMAX  D25, D15, D3
    FMINNM  H7, H25, H25
    FMIN  H31, H7, H17
    FMAX  D14, D6, D8
    FMINNM  D0, D14, D14
    FMAXNM  H26, H6, H26
    FMAX  H22, H31, H9
    FMAX  S2, S22, S22
    FMINNM  H25, H26, H5
    FMAXNM  S31, S2, S0
    FMAX  H30, H2, H26
    FMAX  H26, H16, H30
    FMAXNM  H24, H15, H12
    FMAXNM  D5, D26, D25
    FMAXNM  S15, S5, S3
    FMAXNM  H25, H7, H31
    FMINNM  H28, H24, H25
    FMIN  S21, S20, S28
    FMAX  S20, S7, S15
    FMINNM  H24, H0, H17
    FMAXNM  H22, H5, H7
    FMIN  H8, H3, H6
    FMIN  S9, S1, S24
    FMAXNM  H28, H5, H5
    FMAXNM  H24, H29, H20
    FMINNM  S12, S4, S12
    FMIN  H25, H29, H10
    FMAX  H4, H7, H23
    FMIN  D5, D6, D25
    FMAX  D2, D31, D5
    FMAXNM  D6, D24, D10
    FMAXNM  D3, D28, D16
    FMIN  S15, S22, S9
    FMAX  H1, H8, H2
    FMINNM  H28, H21, H22
    FMINNM  S9, S6, S15
    FMINNM  H17, H8, H8
    FMAXNM  D30, D11, D1
    FMIN  H10, H17, H13
    FMINNM  S27, S20, S10
    FMAXNM  S30, S30, S17
    FMAXNM  D8, D4, D4
    FMIN  D29, D23, D31
    FMIN  S26, S25, S9
    FMINNM  D8, D8, D16
    FMAX  D3, D12, D6
    FMAXNM  D25, D3, D3
    FMIN  S23, S26, S26
    FMINNM  D24, D27, D25
    FMIN  H22, H1, H30
    FMIN  H31, H23, H14
    FMIN  D25, D28, D24
    FMAX  H9, H31, H25
    FMAXNM  H31, H18, H28
    FMAXNM  S24, S9, S30
    FMAXNM  S18, S19, S24
    FMAXNM  D0, D18, D1
    FMINNM  D3, D25, D9
    FMAXNM  H29, H21, H17
    FMAX  H22, H16, H15
    FMINNM  S21, S8, S10
    FMINNM  D2, D0, D1
    FMINNM  H18, H12, H2
    FMIN  S12, S21, S31
    FMINNM  H13, H3, H29
    FMINNM  H26, H18, H18
    FMINNM  H27, H12, H12
    FMIN  D17, D22, D1
    FMIN  S2, S26, S25
    FMAX  H14, H4, H13
    FMIN  D1, D18, D2
    FMIN  D0, D19, D26
    FMAXNM  H2, H16, H11
    FMINNM  S8, S18, S2
    FMAXNM  S28, S8, S27
    FMINNM  D18, D17, D16
    FMINNM  H21, H2, H1
    FMIN  D22, D18, D14
    FMIN  S31, S2, S0
    FMAX  S13, S18, S28
    FMAX  D10, D3, D22
    FMINNM  D8, D22, D21
    FMINNM  S3, S13, S10
    FMIN  S11, S31, S31
    FMINNM  D28, D8, D3
    FMINNM  S31, S2, S18
    FMIN  D18, D26, D31
    FMAX  H1, H16, H11
    FMIN  D14, D18, D27
    FMIN  H15, H17, H26
    FMINNM  H14, H31, H27
    FMAXNM  H25, H9, H7
    FMAX  D7, D27, D4
    FMAXNM  D9, D24, D14
    SUBS  X23, X23, #0x1
    B.NE  TSRTFloatMinMax_label_13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MRS  X10, FPSR
    MOVZ  X9, #0x80, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    FMOV  X10, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
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
    FMOV  D1, X19
    FMOV  V1.D[1], X18
    FMOV  D2, X2
    FMOV  V2.D[1], X21
    FMOV  D3, X22
    FMOV  V3.D[1], X3
    FMOV  D4, X19
    FMOV  V4.D[1], X23
    FMOV  D5, X29
    FMOV  V5.D[1], X9
    FMOV  D6, X12
    FMOV  V6.D[1], X22
    FMOV  D7, X8
    FMOV  V7.D[1], X22
    FMOV  D8, X11
    FMOV  V8.D[1], X19
    FMOV  D9, X22
    FMOV  V9.D[1], X21
    FMOV  D10, X16
    FMOV  V10.D[1], X15
    FMOV  D11, X19
    FMOV  V11.D[1], X2
    FMOV  D12, X6
    FMOV  V12.D[1], X18
    FMOV  D13, X21
    FMOV  V13.D[1], X20
    FMOV  D14, X2
    FMOV  V14.D[1], X3
    FMOV  D15, X6
    FMOV  V15.D[1], X6
    FMOV  D16, X7
    FMOV  V16.D[1], X17
    FMOV  D17, X18
    FMOV  V17.D[1], X22
    FMOV  D18, X19
    FMOV  V18.D[1], X13
    FMOV  D19, X19
    FMOV  V19.D[1], X22
    FMOV  D20, X20
    FMOV  V20.D[1], X4
    FMOV  D21, X10
    FMOV  V21.D[1], X7
    FMOV  D22, X6
    FMOV  V22.D[1], X22
    FMOV  D23, X8
    FMOV  V23.D[1], X5
    FMOV  D24, X4
    FMOV  V24.D[1], X29
    FMOV  D25, X11
    FMOV  V25.D[1], X21
    FMOV  D26, X4
    FMOV  V26.D[1], X21
    FMOV  D27, X2
    FMOV  V27.D[1], X7
    FMOV  D28, X19
    FMOV  V28.D[1], X4
    FMOV  D29, X7
    FMOV  V29.D[1], X17
    FMOV  D30, X18
    FMOV  V30.D[1], X4
    FMOV  D31, X15
    FMOV  V31.D[1], X16
    MOVZ  X20, #0xa, LSL #0
TSRTFloatMinMax_label_14:
    FMINNM  S28, S21, S16
    FMINNM  H10, H29, H22
    FMIN  H13, H26, H23
    FMAX  S5, S11, S25
    FMINNM  S30, S5, S10
    FMIN  D16, D27, D20
    FMINNM  H18, H16, H16
    FMAXNM  S16, S30, S18
    FMINNM  D18, D13, D16
    FMINNM  H5, H18, H18
    FMAX  D27, D5, D28
    FMIN  H3, H24, H31
    FMINNM  S10, S18, S2
    FMINNM  D16, D30, D16
    FMINNM  S26, S28, S12
    FMAXNM  D22, D17, D5
    FMINNM  S28, S25, S30
    FMAXNM  S12, S0, S23
    FMINNM  H20, H31, H1
    FMAXNM  S2, S16, S20
    FMIN  H0, H22, H27
    FMAXNM  S29, S10, S12
    FMIN  H24, H0, H26
    FMAXNM  S11, S15, S19
    FMAXNM  S18, S2, S23
    FMAX  D12, D24, D11
    FMIN  S26, S28, S28
    FMINNM  D1, D22, D30
    FMINNM  H27, H26, H3
    FMINNM  S3, S1, S1
    FMAX  D25, D20, D3
    FMAX  D16, D18, D29
    FMIN  H23, H12, H15
    FMAXNM  S1, S8, S25
    FMAX  D18, D27, D1
    FMIN  H30, H15, H10
    FMIN  D27, D27, D23
    FMINNM  D11, D27, D23
    FMINNM  H19, H18, H30
    FMAX  H19, H8, H19
    FMAXNM  D5, D16, D11
    FMAX  S28, S22, S23
    FMAX  D8, D30, D0
    FMIN  H6, H6, H30
    FMAXNM  S16, S3, S1
    FMAX  D10, D14, D18
    FMAXNM  D6, D31, D25
    FMIN  S29, S4, S21
    FMINNM  D17, D0, D27
    FMAXNM  D12, D28, D16
    FMIN  S0, S25, S1
    FMINNM  D31, D19, D10
    FMINNM  S15, S17, S8
    FMINNM  H2, H12, H31
    FMIN  D4, D17, D10
    FMAX  S12, S2, S0
    FMINNM  S12, S5, S16
    FMAXNM  D14, D12, D12
    FMAXNM  H8, H4, H14
    FMAX  D20, D21, D15
    FMAX  S3, S8, S9
    FMIN  S1, S3, S29
    FMINNM  S20, S6, S27
    FMAX  D16, D27, D1
    FMAXNM  H10, H23, H5
    FMAX  D31, D4, D1
    FMIN  D8, D0, D0
    FMINNM  S8, S29, S28
    FMINNM  S27, S12, S9
    FMIN  S21, S19, S1
    FMAX  H3, H7, H30
    FMIN  S28, S22, S30
    FMINNM  D5, D21, D17
    FMAX  S25, S8, S31
    FMAXNM  H1, H28, H20
    FMAXNM  D31, D25, D27
    FMAX  S4, S5, S31
    FMAX  D0, D16, D22
    FMAXNM  H30, H3, H1
    FMAXNM  H11, H4, H4
    FMAX  S4, S30, S30
    FMIN  H29, H0, H11
    FMINNM  H12, H23, H7
    FMIN  S25, S8, S12
    FMAX  H9, H10, H29
    FMAX  D31, D9, D25
    FMAX  D27, D23, D7
    FMAX  D30, D27, D11
    FMIN  H25, H9, H19
    FMINNM  H27, H0, H8
    FMAXNM  S3, S0, S30
    FMIN  D19, D18, D5
    FMAXNM  S17, S29, S16
    FMIN  S1, S6, S14
    FMAXNM  D23, D2, D13
    FMINNM  H7, H3, H15
    FMINNM  D5, D19, D5
    FMAXNM  S18, S1, S25
    FMIN  S30, S27, S23
    FMINNM  D23, D1, D31
    FMAX  D10, D5, D18
    FMIN  H18, H30, H6
    FMAXNM  D6, D17, D23
    FMAX  D5, D18, D9
    FMAXNM  H20, H7, H6
    FMAXNM  D14, D11, D20
    FMIN  H27, H5, H10
    FMAX  D1, D14, D28
    FMIN  H31, H31, H2
    FMIN  H11, H4, H31
    FMAX  S18, S11, S11
    FMAXNM  D11, D9, D27
    FMINNM  H20, H23, H1
    FMAXNM  H2, H20, H22
    FMAX  H12, H11, H10
    FMAX  D17, D12, D12
    FMINNM  H12, H27, H18
    FMAXNM  H25, H28, H9
    FMAXNM  S31, S6, S20
    FMAXNM  H31, H31, H30
    FMIN  H23, H17, H27
    FMINNM  S22, S12, S25
    FMINNM  D27, D19, D22
    FMINNM  D4, D19, D10
    FMAX  D25, D23, D2
    FMINNM  D20, D12, D31
    FMAXNM  D12, D20, D20
    FMIN  D7, D27, D27
    FMAXNM  S17, S17, S2
    FMIN  S30, S12, S7
    FMAX  S9, S25, S4
    FMINNM  D19, D17, D30
    FMAX  D31, D24, D27
    FMINNM  D10, D19, D31
    FMAX  H23, H30, H28
    FMAX  H3, H10, H6
    FMAXNM  S24, S6, S2
    FMIN  S25, S30, S5
    FMINNM  D6, D9, D13
    FMAXNM  H21, H28, H20
    FMIN  H31, H13, H7
    FMIN  S2, S14, S22
    FMAXNM  H7, H14, H9
    FMINNM  H19, H15, H24
    FMIN  S15, S25, S26
    FMAX  D11, D7, D31
    FMAXNM  S22, S15, S2
    FMINNM  S13, S12, S11
    FMAX  D5, D21, D19
    FMINNM  S25, S13, S20
    FMIN  S21, S6, S22
    FMAXNM  D2, D3, D23
    FMINNM  D27, D1, D25
    FMAXNM  H19, H2, H27
    FMIN  H28, H22, H5
    FMIN  S31, S8, S28
    FMIN  H24, H6, H19
    FMAX  S18, S31, S31
    FMAX  H30, H24, H21
    FMINNM  D25, D2, D21
    FMAX  D7, D29, D1
    FMAX  S27, S29, S17
    FMAX  S29, S25, S19
    FMAXNM  S20, S7, S26
    FMAX  S9, S23, S15
    FMINNM  S26, S29, S5
    FMAXNM  D15, D15, D7
    FMAX  D13, D18, D3
    FMINNM  H2, H25, H1
    FMAX  H29, H31, H22
    FMIN  H25, H15, H4
    FMINNM  S15, S29, S27
    FMINNM  S19, S26, S2
    FMAXNM  D12, D25, D15
    FMINNM  H6, H19, H21
    FMIN  D3, D6, D9
    FMAXNM  D4, D12, D24
    FMAX  H1, H3, H20
    FMAXNM  D25, D1, D4
    FMAXNM  H15, H13, H13
    FMAXNM  S15, S25, S31
    FMIN  D24, D23, D30
    FMIN  D8, D15, D11
    FMIN  D24, D18, D14
    FMINNM  S11, S8, S24
    FMINNM  D5, D18, D24
    FMAX  H28, H19, H24
    FMIN  H20, H7, H31
    FMAXNM  S8, S22, S28
    FMAXNM  H28, H23, H19
    FMINNM  D23, D0, D8
    FMIN  D22, D25, D24
    FMIN  S24, S10, S22
    FMIN  D15, D7, D3
    FMAX  D21, D3, D16
    FMAX  S10, S26, S28
    FMAX  D18, D27, D15
    FMAX  D13, D16, D20
    FMAX  S22, S19, S28
    FMAXNM  H3, H22, H18
    SUBS  X20, X20, #0x1
    B.NE  TSRTFloatMinMax_label_14
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MRS  X7, FPSR
    MOVZ  X29, #0x80, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D1
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D29
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D30
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    FMOV  X7, D31
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail

TSRTFloatMinMax_TestEnd:
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
TSRTFloatMinMax_TestFail:
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
