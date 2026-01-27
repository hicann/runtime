.global TSRTFloatFloatPointRoundToInteger

.text
.p2align 4

TSRTFloatFloatPointRoundToInteger:

TSRTFloatFloatPointRoundToInteger_TestBegin:
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
    MOVZ  X2, #0x866f, LSL #0
    MOVK  X2, #0x411f, LSL #16
    MOVK  X2, #0x844, LSL #32
    MOVK  X2, #0x9a24, LSL #48
    MOVZ  X3, #0x1a7c, LSL #0
    MOVK  X3, #0xf128, LSL #16
    MOVK  X3, #0x66c6, LSL #32
    MOVK  X3, #0xdd49, LSL #48
    MOVZ  X4, #0x3ff3, LSL #0
    MOVK  X4, #0x8e, LSL #16
    MOVK  X4, #0xe1a7, LSL #32
    MOVK  X4, #0xbdd9, LSL #48
    MOVZ  X5, #0xec87, LSL #0
    MOVK  X5, #0x7186, LSL #16
    MOVK  X5, #0x5880, LSL #32
    MOVK  X5, #0xf74c, LSL #48
    MOVZ  X6, #0x89be, LSL #0
    MOVK  X6, #0xc1b9, LSL #16
    MOVK  X6, #0x573, LSL #32
    MOVK  X6, #0x6f81, LSL #48
    MOVZ  X7, #0x1a66, LSL #0
    MOVK  X7, #0x81a6, LSL #16
    MOVK  X7, #0x7cca, LSL #32
    MOVK  X7, #0x650d, LSL #48
    MOVZ  X8, #0x591, LSL #0
    MOVK  X8, #0xfbfc, LSL #16
    MOVK  X8, #0xa73e, LSL #32
    MOVK  X8, #0x120b, LSL #48
    MOVZ  X11, #0xe215, LSL #0
    MOVK  X11, #0xdb73, LSL #16
    MOVK  X11, #0xec2c, LSL #32
    MOVK  X11, #0x70d4, LSL #48
    MOVZ  X14, #0xe858, LSL #0
    MOVK  X14, #0x2c72, LSL #16
    MOVK  X14, #0x5d8f, LSL #32
    MOVK  X14, #0x4ee4, LSL #48
    MOVZ  X16, #0x731, LSL #0
    MOVK  X16, #0x7c9, LSL #16
    MOVK  X16, #0xc5f, LSL #32
    MOVK  X16, #0x3a88, LSL #48
    MOVZ  X17, #0xa413, LSL #0
    MOVK  X17, #0x2002, LSL #16
    MOVK  X17, #0x8cc4, LSL #32
    MOVK  X17, #0xf43, LSL #48
    MOVZ  X18, #0x3c1c, LSL #0
    MOVK  X18, #0xeac6, LSL #16
    MOVK  X18, #0x9c58, LSL #32
    MOVK  X18, #0x8c1, LSL #48
    MOVZ  X19, #0x85d1, LSL #0
    MOVK  X19, #0xf8da, LSL #16
    MOVK  X19, #0x56ee, LSL #32
    MOVK  X19, #0x6d17, LSL #48
    MOVZ  X20, #0xea73, LSL #0
    MOVK  X20, #0x7720, LSL #16
    MOVK  X20, #0xf20a, LSL #32
    MOVK  X20, #0x5c46, LSL #48
    MOVZ  X21, #0x4792, LSL #0
    MOVK  X21, #0x222e, LSL #16
    MOVK  X21, #0x251d, LSL #32
    MOVK  X21, #0xb646, LSL #48
    MOVZ  X22, #0x6da, LSL #0
    MOVK  X22, #0xf20b, LSL #16
    MOVK  X22, #0xa0f4, LSL #32
    MOVK  X22, #0x7705, LSL #48
    MOVZ  X23, #0x8fc, LSL #0
    MOVK  X23, #0xb6a3, LSL #16
    MOVK  X23, #0xb554, LSL #32
    MOVK  X23, #0x6739, LSL #48
    MOVZ  X24, #0x40c, LSL #0
    MOVK  X24, #0x2eb6, LSL #16
    MOVK  X24, #0x4d92, LSL #32
    MOVK  X24, #0xbaa6, LSL #48
    MOVZ  X25, #0x58b1, LSL #0
    MOVK  X25, #0x737d, LSL #16
    MOVK  X25, #0x9f28, LSL #32
    MOVK  X25, #0x30ee, LSL #48
    MOVZ  X26, #0x3451, LSL #0
    MOVK  X26, #0x4047, LSL #16
    MOVK  X26, #0x456f, LSL #32
    MOVK  X26, #0x6457, LSL #48
    MOVZ  X27, #0x26ca, LSL #0
    MOVK  X27, #0x325a, LSL #16
    MOVK  X27, #0xad15, LSL #32
    MOVK  X27, #0xade9, LSL #48
    MOVZ  X28, #0x5a2f, LSL #0
    MOVK  X28, #0x72bf, LSL #16
    MOVK  X28, #0x1afd, LSL #32
    MOVK  X28, #0x4a9d, LSL #48
    MOVZ  X29, #0x216d, LSL #0
    MOVK  X29, #0xe672, LSL #16
    MOVK  X29, #0x2ebb, LSL #32
    MOVK  X29, #0xfa3f, LSL #48
    MOVZ  X14, #0xef05, LSL #0
    MOVK  X14, #0xdd1b, LSL #16
    MOVK  X14, #0x1e40, LSL #32
    MOVK  X14, #0x5cee, LSL #48
    MSR  FPCR, X14
    MRS  X18, FPCR
    MOVZ  X6, #0x60ff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    AND  X18, X18, X6
    MOVZ  X6, #0x0, LSL #0
    ORR  X18, X18, X6
    MSR  FPCR, X18
    ISB  SY
    MOVZ  X14, #0x4de4, LSL #0
    MOVK  X14, #0x5820, LSL #16
    MOVK  X14, #0x13c2, LSL #32
    MOVK  X14, #0x1d72, LSL #48
    MSR  FPSR, X14
    MRS  X6, FPSR
    MOVZ  X5, #0xff60, LSL #0
    MOVK  X5, #0x7ff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    AND  X6, X6, X5
    MOVZ  X5, #0x0, LSL #0
    ORR  X6, X6, X5
    MSR  FPSR, X6
    ISB  SY
    ANDS  W26, W3, W28, LSR #24
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x8da2, LSL #0
    MOVK  X2, #0x804a, LSL #16
    MOVK  X2, #0x2ea0, LSL #32
    MOVK  X2, #0x3e5e, LSL #48
    MOVZ  X3, #0x50c2, LSL #0
    MOVK  X3, #0x8c1a, LSL #16
    MOVK  X3, #0xff8d, LSL #32
    MOVK  X3, #0x7285, LSL #48
    MOVZ  X4, #0xae8d, LSL #0
    MOVK  X4, #0xb08e, LSL #16
    MOVK  X4, #0xf2dc, LSL #32
    MOVK  X4, #0xeeac, LSL #48
    MOVZ  X5, #0xb111, LSL #0
    MOVK  X5, #0x2754, LSL #16
    MOVK  X5, #0xc35d, LSL #32
    MOVK  X5, #0x7912, LSL #48
    MOVZ  X6, #0x719f, LSL #0
    MOVK  X6, #0x27c2, LSL #16
    MOVK  X6, #0x8bd7, LSL #32
    MOVK  X6, #0x54e9, LSL #48
    MOVZ  X7, #0xd5ea, LSL #0
    MOVK  X7, #0x112d, LSL #16
    MOVK  X7, #0x85c3, LSL #32
    MOVK  X7, #0x9539, LSL #48
    MOVZ  X8, #0x7c04, LSL #0
    MOVK  X8, #0x25e1, LSL #16
    MOVK  X8, #0x9e8e, LSL #32
    MOVK  X8, #0xa26e, LSL #48
    MOVZ  X11, #0x30d5, LSL #0
    MOVK  X11, #0xb57e, LSL #16
    MOVK  X11, #0x8091, LSL #32
    MOVK  X11, #0xa27e, LSL #48
    MOVZ  X14, #0x3fdc, LSL #0
    MOVK  X14, #0x952c, LSL #16
    MOVK  X14, #0x2372, LSL #32
    MOVK  X14, #0xabb5, LSL #48
    MOVZ  X16, #0x4a75, LSL #0
    MOVK  X16, #0x2f2f, LSL #16
    MOVK  X16, #0x2795, LSL #32
    MOVK  X16, #0x5c75, LSL #48
    MOVZ  X17, #0x98b2, LSL #0
    MOVK  X17, #0x4e9c, LSL #16
    MOVK  X17, #0x4d11, LSL #32
    MOVK  X17, #0x5b73, LSL #48
    MOVZ  X18, #0x538e, LSL #0
    MOVK  X18, #0x8fa4, LSL #16
    MOVK  X18, #0x683, LSL #32
    MOVK  X18, #0xc747, LSL #48
    MOVZ  X19, #0xe996, LSL #0
    MOVK  X19, #0x794d, LSL #16
    MOVK  X19, #0xb54a, LSL #32
    MOVK  X19, #0x9cba, LSL #48
    MOVZ  X20, #0x18dd, LSL #0
    MOVK  X20, #0x219b, LSL #16
    MOVK  X20, #0x1cb, LSL #32
    MOVK  X20, #0xd68d, LSL #48
    MOVZ  X21, #0x9606, LSL #0
    MOVK  X21, #0x1d03, LSL #16
    MOVK  X21, #0x573a, LSL #32
    MOVK  X21, #0x2c27, LSL #48
    MOVZ  X22, #0xba3f, LSL #0
    MOVK  X22, #0x24fe, LSL #16
    MOVK  X22, #0x1353, LSL #32
    MOVK  X22, #0x82ed, LSL #48
    MOVZ  X23, #0xbcfc, LSL #0
    MOVK  X23, #0xfedc, LSL #16
    MOVK  X23, #0x9398, LSL #32
    MOVK  X23, #0xd88, LSL #48
    MOVZ  X24, #0x50a9, LSL #0
    MOVK  X24, #0xa564, LSL #16
    MOVK  X24, #0x21f5, LSL #32
    MOVK  X24, #0xca5a, LSL #48
    MOVZ  X25, #0x6846, LSL #0
    MOVK  X25, #0xb2d3, LSL #16
    MOVK  X25, #0xe684, LSL #32
    MOVK  X25, #0x7f51, LSL #48
    MOVZ  X26, #0x1de8, LSL #0
    MOVK  X26, #0xb53d, LSL #16
    MOVK  X26, #0x301e, LSL #32
    MOVK  X26, #0x55bb, LSL #48
    MOVZ  X27, #0xd680, LSL #0
    MOVK  X27, #0xd57d, LSL #16
    MOVK  X27, #0x3643, LSL #32
    MOVK  X27, #0x9160, LSL #48
    MOVZ  X28, #0xce01, LSL #0
    MOVK  X28, #0x2781, LSL #16
    MOVK  X28, #0x1a46, LSL #32
    MOVK  X28, #0xcfe, LSL #48
    MOVZ  X29, #0xbab1, LSL #0
    MOVK  X29, #0x95c, LSL #16
    MOVK  X29, #0x8e63, LSL #32
    MOVK  X29, #0x8775, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X23
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X24
    FMOV  D3, X4
    FMOV  V3.D[1], X20
    FMOV  D4, X3
    FMOV  V4.D[1], X16
    FMOV  D5, X18
    FMOV  V5.D[1], X2
    FMOV  D6, X11
    FMOV  V6.D[1], X6
    FMOV  D7, X24
    FMOV  V7.D[1], X4
    FMOV  D8, X25
    FMOV  V8.D[1], X23
    FMOV  D9, X27
    FMOV  V9.D[1], X18
    FMOV  D10, X23
    FMOV  V10.D[1], X6
    FMOV  D11, X19
    FMOV  V11.D[1], X25
    FMOV  D12, X4
    FMOV  V12.D[1], X17
    FMOV  D13, X2
    FMOV  V13.D[1], X24
    FMOV  D14, X19
    FMOV  V14.D[1], X17
    FMOV  D15, X24
    FMOV  V15.D[1], X2
    FMOV  D16, X27
    FMOV  V16.D[1], X5
    FMOV  D17, X20
    FMOV  V17.D[1], X28
    FMOV  D18, X25
    FMOV  V18.D[1], X22
    FMOV  D19, X25
    FMOV  V19.D[1], X20
    FMOV  D20, X22
    FMOV  V20.D[1], X5
    FMOV  D21, X19
    FMOV  V21.D[1], X18
    FMOV  D22, X3
    FMOV  V22.D[1], X24
    FMOV  D23, X19
    FMOV  V23.D[1], X20
    FMOV  D24, X29
    FMOV  V24.D[1], X20
    FMOV  D25, X18
    FMOV  V25.D[1], X7
    FMOV  D26, X18
    FMOV  V26.D[1], X26
    FMOV  D27, X24
    FMOV  V27.D[1], X25
    FMOV  D28, X7
    FMOV  V28.D[1], X7
    FMOV  D29, X4
    FMOV  V29.D[1], X18
    FMOV  D30, X17
    FMOV  V30.D[1], X16
    FMOV  D31, X2
    FMOV  V31.D[1], X6
    FRINTA  D8, D26
    FRINTA  D6, D19
    FRINTA  D27, D24
    FRINTA  D6, D25
    FRINTA  D24, D18
    FRINTA  D28, D5
    FRINTA  D31, D20
    FRINTA  D10, D28
    FRINTA  D2, D30
    FRINTA  D31, D10
    FRINTA  S18, S24
    FRINTA  S24, S29
    FRINTA  S4, S17
    FRINTA  S21, S8
    FRINTA  S2, S21
    FRINTA  S31, S20
    FRINTA  S28, S4
    FRINTA  S23, S26
    FRINTA  S26, S28
    FRINTA  S20, S27
    FRINTI  D28, D20
    FRINTI  D22, D28
    FRINTI  D13, D24
    FRINTI  D5, D13
    FRINTI  D29, D22
    FRINTI  D10, D31
    FRINTI  D24, D14
    FRINTI  D16, D23
    FRINTI  D8, D24
    FRINTI  D13, D10
    FRINTI  S22, S5
    FRINTI  S27, S8
    FRINTI  S28, S12
    FRINTI  S4, S16
    FRINTI  S12, S3
    FRINTI  S23, S12
    FRINTI  S22, S22
    FRINTI  S5, S8
    FRINTI  S1, S13
    FRINTI  S10, S17
    FRINTM  D17, D22
    FRINTM  D16, D14
    FRINTM  D15, D5
    FRINTM  D28, D14
    FRINTM  D8, D23
    FRINTM  D9, D15
    FRINTM  D15, D31
    FRINTM  D23, D27
    FRINTM  D15, D17
    FRINTM  D25, D28
    FRINTM  S31, S16
    FRINTM  S24, S25
    FRINTM  S22, S8
    FRINTM  S17, S29
    FRINTM  S1, S24
    FRINTM  S12, S31
    FRINTM  S27, S15
    FRINTM  S9, S1
    FRINTM  S27, S17
    FRINTM  S11, S24
    FRINTN  D22, D9
    FRINTN  D3, D12
    FRINTN  D13, D11
    FRINTN  D31, D28
    FRINTN  D28, D31
    FRINTN  D25, D28
    FRINTN  D4, D15
    FRINTN  D28, D25
    FRINTN  D11, D13
    FRINTN  D17, D1
    FRINTN  S15, S29
    FRINTN  S28, S28
    FRINTN  S6, S17
    FRINTN  S25, S23
    FRINTN  S9, S11
    FRINTN  S24, S27
    FRINTN  S9, S6
    FRINTN  S6, S28
    FRINTN  S17, S1
    FRINTN  S31, S3
    FRINTP  D13, D13
    FRINTP  D12, D9
    FRINTP  D11, D18
    FRINTP  D29, D12
    FRINTP  D3, D11
    FRINTP  D27, D13
    FRINTP  D12, D21
    FRINTP  D21, D6
    FRINTP  D28, D4
    FRINTP  D11, D30
    FRINTP  S23, S25
    FRINTP  S2, S18
    FRINTP  S4, S2
    FRINTP  S5, S31
    FRINTP  S18, S27
    FRINTP  S1, S29
    FRINTP  S2, S3
    FRINTP  S29, S1
    FRINTP  S22, S13
    FRINTP  S16, S28
    FRINTX  D28, D4
    FRINTX  D27, D21
    FRINTX  D25, D27
    FRINTX  D1, D23
    FRINTX  D27, D5
    FRINTX  D9, D29
    FRINTX  D30, D4
    FRINTX  D15, D18
    FRINTX  D4, D1
    FRINTX  D23, D19
    FRINTX  S29, S4
    FRINTX  S18, S2
    FRINTX  S4, S4
    FRINTX  S3, S27
    FRINTX  S21, S18
    FRINTX  S2, S21
    FRINTX  S19, S25
    FRINTX  S18, S15
    FRINTX  S13, S2
    FRINTX  S25, S29
    FRINTZ  D5, D9
    FRINTZ  D9, D15
    FRINTZ  D29, D19
    FRINTZ  D21, D1
    FRINTZ  D20, D13
    FRINTZ  D5, D3
    FRINTZ  D19, D20
    FRINTZ  D15, D23
    FRINTZ  D10, D29
    FRINTZ  D24, D15
    FRINTZ  S31, S13
    FRINTZ  S23, S4
    FRINTZ  S3, S25
    FRINTZ  S12, S1
    FRINTZ  S19, S0
    FRINTZ  S7, S21
    FRINTZ  S2, S10
    FRINTZ  S21, S19
    FRINTZ  S10, S3
    FRINTZ  S20, S9
    FRINTA  H31, H20
    FRINTA  H5, H22
    FRINTA  H15, H25
    FRINTA  H0, H18
    FRINTA  H13, H21
    FRINTA  H3, H31
    FRINTA  H25, H2
    FRINTA  H18, H25
    FRINTA  H9, H15
    FRINTA  H19, H10
    FRINTI  H25, H5
    FRINTI  H15, H9
    FRINTI  H6, H9
    FRINTI  H0, H13
    FRINTI  H22, H31
    FRINTI  H5, H22
    FRINTI  H29, H20
    FRINTI  H25, H6
    FRINTI  H9, H0
    FRINTI  H20, H25
    FRINTM  H10, H20
    FRINTM  H1, H5
    FRINTM  H9, H18
    FRINTM  H18, H1
    FRINTM  H1, H29
    FRINTM  H6, H1
    FRINTM  H20, H15
    FRINTM  H2, H9
    FRINTM  H1, H17
    FRINTM  H22, H6
    FRINTN  H2, H1
    FRINTN  H1, H20
    FRINTN  H17, H1
    FRINTN  H25, H22
    FRINTN  H29, H28
    FRINTN  H15, H17
    FRINTN  H22, H15
    FRINTN  H31, H4
    FRINTN  H4, H22
    FRINTN  H6, H19
    FRINTP  H22, H4
    FRINTP  H5, H22
    FRINTP  H0, H25
    FRINTP  H1, H22
    FRINTP  H19, H6
    FRINTP  H31, H10
    FRINTP  H26, H1
    FRINTP  H5, H26
    FRINTP  H20, H10
    FRINTP  H30, H5
    FRINTX  H15, H18
    FRINTX  H22, H31
    FRINTX  H5, H22
    FRINTX  H1, H19
    FRINTX  H10, H1
    FRINTX  H22, H10
    FRINTX  H19, H30
    FRINTX  H4, H5
    FRINTX  H5, H4
    FRINTX  H4, H20
    FRINTZ  H21, H4
    FRINTZ  H18, H0
    FRINTZ  H6, H28
    FRINTZ  H10, H4
    FRINTZ  H12, H18
    FRINTZ  H1, H6
    FRINTZ  H4, H16
    FRINTZ  H16, H14
    FRINTZ  H20, H22
    FRINTZ  H0, H15
    MOVZ  X24, #0x8da2, LSL #0
    MOVK  X24, #0x804a, LSL #16
    MOVK  X24, #0x2ea0, LSL #32
    MOVK  X24, #0x3e5e, LSL #48
    SUB  X4, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x50c2, LSL #0
    MOVK  X24, #0x8c1a, LSL #16
    MOVK  X24, #0xff8d, LSL #32
    MOVK  X24, #0x7285, LSL #48
    SUB  X4, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xb111, LSL #0
    MOVK  X24, #0x2754, LSL #16
    MOVK  X24, #0xc35d, LSL #32
    MOVK  X24, #0x7912, LSL #48
    SUB  X4, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xd5ea, LSL #0
    MOVK  X24, #0x112d, LSL #16
    MOVK  X24, #0x85c3, LSL #32
    MOVK  X24, #0x9539, LSL #48
    SUB  X4, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x7c04, LSL #0
    MOVK  X24, #0x25e1, LSL #16
    MOVK  X24, #0x9e8e, LSL #32
    MOVK  X24, #0xa26e, LSL #48
    SUB  X4, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x30d5, LSL #0
    MOVK  X24, #0xb57e, LSL #16
    MOVK  X24, #0x8091, LSL #32
    MOVK  X24, #0xa27e, LSL #48
    SUB  X4, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x3fdc, LSL #0
    MOVK  X24, #0x952c, LSL #16
    MOVK  X24, #0x2372, LSL #32
    MOVK  X24, #0xabb5, LSL #48
    SUB  X4, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x4a75, LSL #0
    MOVK  X24, #0x2f2f, LSL #16
    MOVK  X24, #0x2795, LSL #32
    MOVK  X24, #0x5c75, LSL #48
    SUB  X4, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x98b2, LSL #0
    MOVK  X24, #0x4e9c, LSL #16
    MOVK  X24, #0x4d11, LSL #32
    MOVK  X24, #0x5b73, LSL #48
    SUB  X4, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x538e, LSL #0
    MOVK  X24, #0x8fa4, LSL #16
    MOVK  X24, #0x683, LSL #32
    MOVK  X24, #0xc747, LSL #48
    SUB  X4, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xe996, LSL #0
    MOVK  X24, #0x794d, LSL #16
    MOVK  X24, #0xb54a, LSL #32
    MOVK  X24, #0x9cba, LSL #48
    SUB  X4, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x18dd, LSL #0
    MOVK  X24, #0x219b, LSL #16
    MOVK  X24, #0x1cb, LSL #32
    MOVK  X24, #0xd68d, LSL #48
    SUB  X4, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x9606, LSL #0
    MOVK  X24, #0x1d03, LSL #16
    MOVK  X24, #0x573a, LSL #32
    MOVK  X24, #0x2c27, LSL #48
    SUB  X4, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xba3f, LSL #0
    MOVK  X24, #0x24fe, LSL #16
    MOVK  X24, #0x1353, LSL #32
    MOVK  X24, #0x82ed, LSL #48
    SUB  X4, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xbcfc, LSL #0
    MOVK  X24, #0xfedc, LSL #16
    MOVK  X24, #0x9398, LSL #32
    MOVK  X24, #0xd88, LSL #48
    SUB  X4, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x6846, LSL #0
    MOVK  X24, #0xb2d3, LSL #16
    MOVK  X24, #0xe684, LSL #32
    MOVK  X24, #0x7f51, LSL #48
    SUB  X4, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x1de8, LSL #0
    MOVK  X24, #0xb53d, LSL #16
    MOVK  X24, #0x301e, LSL #32
    MOVK  X24, #0x55bb, LSL #48
    SUB  X4, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xd680, LSL #0
    MOVK  X24, #0xd57d, LSL #16
    MOVK  X24, #0x3643, LSL #32
    MOVK  X24, #0x9160, LSL #48
    SUB  X4, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xce01, LSL #0
    MOVK  X24, #0x2781, LSL #16
    MOVK  X24, #0x1a46, LSL #32
    MOVK  X24, #0xcfe, LSL #48
    SUB  X4, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0xbab1, LSL #0
    MOVK  X24, #0x95c, LSL #16
    MOVK  X24, #0x8e63, LSL #32
    MOVK  X24, #0x8775, LSL #48
    SUB  X4, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X24, FPSR
    MOVZ  X4, #0x80, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D11
    MOVZ  X4, #0x98b2, LSL #0
    MOVK  X4, #0x4e9c, LSL #16
    MOVK  X4, #0x4d11, LSL #32
    MOVK  X4, #0x5b73, LSL #48
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X4, #0x98b2, LSL #0
    MOVK  X4, #0x4e9c, LSL #16
    MOVK  X4, #0x4d11, LSL #32
    MOVK  X4, #0x5b73, LSL #48
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D14
    MOVZ  X4, #0xe996, LSL #0
    MOVK  X4, #0x794d, LSL #16
    MOVK  X4, #0xb54a, LSL #32
    MOVK  X4, #0x9cba, LSL #48
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D16
    MOVZ  X4, #0xe996, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D24
    MOVZ  X4, #0x6846, LSL #0
    MOVK  X4, #0xb2d3, LSL #16
    MOVK  X4, #0xe684, LSL #32
    MOVK  X4, #0x7f51, LSL #48
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xeb1d, LSL #0
    MOVK  X2, #0xd410, LSL #16
    MOVK  X2, #0x574d, LSL #32
    MOVK  X2, #0x57c8, LSL #48
    MOVZ  X3, #0xe434, LSL #0
    MOVK  X3, #0xc03c, LSL #16
    MOVK  X3, #0x46f0, LSL #32
    MOVK  X3, #0x515, LSL #48
    MOVZ  X4, #0x5683, LSL #0
    MOVK  X4, #0x41f3, LSL #16
    MOVK  X4, #0x7c5c, LSL #32
    MOVK  X4, #0x6e1, LSL #48
    MOVZ  X5, #0xe6a8, LSL #0
    MOVK  X5, #0xb595, LSL #16
    MOVK  X5, #0x64aa, LSL #32
    MOVK  X5, #0x9567, LSL #48
    MOVZ  X6, #0xe3f5, LSL #0
    MOVK  X6, #0x6724, LSL #16
    MOVK  X6, #0x911f, LSL #32
    MOVK  X6, #0x2986, LSL #48
    MOVZ  X7, #0x154d, LSL #0
    MOVK  X7, #0xf933, LSL #16
    MOVK  X7, #0xfc8a, LSL #32
    MOVK  X7, #0x5a80, LSL #48
    MOVZ  X8, #0xab6c, LSL #0
    MOVK  X8, #0x27a, LSL #16
    MOVK  X8, #0x4419, LSL #32
    MOVK  X8, #0x130e, LSL #48
    MOVZ  X11, #0x1ed4, LSL #0
    MOVK  X11, #0xc2b, LSL #16
    MOVK  X11, #0x461, LSL #32
    MOVK  X11, #0xebad, LSL #48
    MOVZ  X14, #0xaa0f, LSL #0
    MOVK  X14, #0x7ed4, LSL #16
    MOVK  X14, #0x90d, LSL #32
    MOVK  X14, #0x6b32, LSL #48
    MOVZ  X16, #0xbf75, LSL #0
    MOVK  X16, #0xf308, LSL #16
    MOVK  X16, #0xd73e, LSL #32
    MOVK  X16, #0xf92a, LSL #48
    MOVZ  X17, #0xcdc2, LSL #0
    MOVK  X17, #0xc592, LSL #16
    MOVK  X17, #0x505f, LSL #32
    MOVK  X17, #0xc79, LSL #48
    MOVZ  X18, #0x2e37, LSL #0
    MOVK  X18, #0x8905, LSL #16
    MOVK  X18, #0x3bbe, LSL #32
    MOVK  X18, #0x6ada, LSL #48
    MOVZ  X19, #0x83ea, LSL #0
    MOVK  X19, #0xc8d, LSL #16
    MOVK  X19, #0x2343, LSL #32
    MOVK  X19, #0x2bf1, LSL #48
    MOVZ  X20, #0x538e, LSL #0
    MOVK  X20, #0xb60f, LSL #16
    MOVK  X20, #0x2977, LSL #32
    MOVK  X20, #0x646a, LSL #48
    MOVZ  X21, #0x4bb2, LSL #0
    MOVK  X21, #0x7b2d, LSL #16
    MOVK  X21, #0x9db5, LSL #32
    MOVK  X21, #0xbad7, LSL #48
    MOVZ  X22, #0x9733, LSL #0
    MOVK  X22, #0x2096, LSL #16
    MOVK  X22, #0x1c6f, LSL #32
    MOVK  X22, #0xec16, LSL #48
    MOVZ  X23, #0x9a31, LSL #0
    MOVK  X23, #0x5d63, LSL #16
    MOVK  X23, #0x6a5e, LSL #32
    MOVK  X23, #0xb491, LSL #48
    MOVZ  X24, #0xfcef, LSL #0
    MOVK  X24, #0x1831, LSL #16
    MOVK  X24, #0x8b0d, LSL #32
    MOVK  X24, #0x453a, LSL #48
    MOVZ  X25, #0x77b1, LSL #0
    MOVK  X25, #0xb3d6, LSL #16
    MOVK  X25, #0x29f4, LSL #32
    MOVK  X25, #0x4d17, LSL #48
    MOVZ  X26, #0x833b, LSL #0
    MOVK  X26, #0xfd11, LSL #16
    MOVK  X26, #0x41fe, LSL #32
    MOVK  X26, #0xe159, LSL #48
    MOVZ  X27, #0x74a, LSL #0
    MOVK  X27, #0x3949, LSL #16
    MOVK  X27, #0x5a5d, LSL #32
    MOVK  X27, #0x4731, LSL #48
    MOVZ  X28, #0x5514, LSL #0
    MOVK  X28, #0xc0e3, LSL #16
    MOVK  X28, #0x5a77, LSL #32
    MOVK  X28, #0x3b11, LSL #48
    MOVZ  X29, #0xc659, LSL #0
    MOVK  X29, #0xb002, LSL #16
    MOVK  X29, #0xc0d2, LSL #32
    MOVK  X29, #0xb5f9, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X22
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X25
    FMOV  V5.D[1], X2
    FMOV  D6, X14
    FMOV  V6.D[1], X29
    FMOV  D7, X21
    FMOV  V7.D[1], X23
    FMOV  D8, X18
    FMOV  V8.D[1], X27
    FMOV  D9, X28
    FMOV  V9.D[1], X3
    FMOV  D10, X6
    FMOV  V10.D[1], X27
    FMOV  D11, X14
    FMOV  V11.D[1], X22
    FMOV  D12, X2
    FMOV  V12.D[1], X26
    FMOV  D13, X20
    FMOV  V13.D[1], X19
    FMOV  D14, X21
    FMOV  V14.D[1], X28
    FMOV  D15, X17
    FMOV  V15.D[1], X3
    FMOV  D16, X28
    FMOV  V16.D[1], X7
    FMOV  D17, X28
    FMOV  V17.D[1], X5
    FMOV  D18, X28
    FMOV  V18.D[1], X28
    FMOV  D19, X23
    FMOV  V19.D[1], X16
    FMOV  D20, X28
    FMOV  V20.D[1], X19
    FMOV  D21, X8
    FMOV  V21.D[1], X16
    FMOV  D22, X20
    FMOV  V22.D[1], X11
    FMOV  D23, X20
    FMOV  V23.D[1], X20
    FMOV  D24, X20
    FMOV  V24.D[1], X23
    FMOV  D25, X28
    FMOV  V25.D[1], X4
    FMOV  D26, X26
    FMOV  V26.D[1], X16
    FMOV  D27, X17
    FMOV  V27.D[1], X22
    FMOV  D28, X14
    FMOV  V28.D[1], X2
    FMOV  D29, X6
    FMOV  V29.D[1], X27
    FMOV  D30, X14
    FMOV  V30.D[1], X16
    FMOV  D31, X29
    FMOV  V31.D[1], X6
    MOVZ  X20, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_0:
    FRINTM  H30, H19
    FRINTI  S3, S26
    FRINTM  D11, D30
    FRINTN  S18, S24
    FRINTI  S5, S31
    FRINTP  S16, S29
    FRINTA  S25, S28
    FRINTZ  D21, D27
    FRINTX  S12, S25
    FRINTI  H31, H14
    FRINTZ  D29, D23
    FRINTZ  D29, D21
    FRINTN  H11, H30
    FRINTM  H26, H18
    FRINTA  D0, D31
    FRINTA  H16, H3
    FRINTP  D11, D10
    FRINTM  D11, D16
    FRINTX  H23, H12
    FRINTZ  H4, H0
    FRINTA  D15, D29
    FRINTN  D14, D31
    FRINTX  S0, S2
    FRINTA  D3, D18
    FRINTP  S29, S11
    FRINTI  S30, S14
    FRINTP  D16, D26
    FRINTP  S21, S23
    FRINTM  S11, S1
    FRINTX  S28, S0
    FRINTX  S12, S4
    FRINTN  H1, H16
    FRINTX  H16, H15
    FRINTP  H23, H1
    FRINTZ  S24, S21
    FRINTN  S14, S23
    FRINTX  S15, S12
    FRINTA  H2, H3
    FRINTZ  D25, D30
    FRINTP  S3, S28
    FRINTP  D28, D17
    FRINTX  H28, H3
    FRINTZ  D7, D26
    FRINTX  D4, D2
    FRINTZ  S0, S25
    FRINTI  D25, D23
    FRINTX  H31, H14
    FRINTA  D2, D7
    FRINTA  D21, D26
    FRINTA  H12, H11
    FRINTN  D26, D15
    FRINTZ  D30, D0
    FRINTN  D17, D4
    FRINTX  S6, S14
    FRINTX  H4, H0
    FRINTZ  D15, D16
    FRINTI  D4, D24
    FRINTX  D23, D6
    FRINTN  S30, S12
    FRINTP  H19, H0
    FRINTM  S7, S17
    FRINTP  H11, H18
    FRINTM  D17, D7
    FRINTN  D24, D5
    FRINTX  H16, H24
    FRINTA  H27, H21
    FRINTP  D3, D16
    FRINTX  S7, S21
    FRINTI  H21, H7
    FRINTZ  S12, S21
    FRINTI  D6, D24
    FRINTI  H16, H31
    FRINTN  S17, S15
    FRINTZ  S9, S23
    FRINTX  S21, S2
    FRINTP  S24, S26
    FRINTX  D13, D30
    FRINTX  D2, D17
    FRINTN  D5, D11
    FRINTX  D11, D14
    FRINTP  S8, S19
    FRINTZ  D18, D24
    FRINTZ  D26, D11
    FRINTP  D11, D2
    FRINTZ  D7, D8
    FRINTI  H30, H18
    FRINTI  S11, S25
    FRINTM  D31, D26
    FRINTN  D24, D16
    FRINTP  S19, S5
    FRINTZ  H25, H19
    FRINTN  D16, D13
    FRINTA  S5, S7
    FRINTZ  S8, S0
    FRINTX  S0, S25
    FRINTX  D15, D5
    FRINTP  H26, H24
    FRINTZ  H13, H31
    FRINTA  S18, S3
    FRINTZ  H25, H26
    FRINTI  S19, S11
    FRINTA  D2, D4
    FRINTA  D22, D2
    FRINTM  D31, D22
    FRINTM  S24, S25
    FRINTA  D26, D13
    FRINTI  H5, H25
    FRINTP  S14, S12
    FRINTI  S11, S19
    FRINTI  H0, H24
    FRINTI  H4, H26
    FRINTA  D25, D19
    FRINTI  S12, S30
    FRINTP  D19, D25
    FRINTP  H30, H15
    FRINTN  D30, D5
    FRINTX  H5, H31
    FRINTN  S24, S16
    FRINTP  H25, H16
    FRINTM  D16, D30
    FRINTP  H28, H25
    FRINTZ  H1, H19
    FRINTX  S22, S1
    FRINTN  S19, S24
    FRINTA  H13, H28
    FRINTP  D30, D17
    FRINTA  D15, D31
    FRINTA  S3, S16
    FRINTX  S24, S28
    FRINTZ  D17, D0
    FRINTA  D28, D3
    FRINTZ  H0, H14
    FRINTM  S9, S28
    FRINTI  H14, H12
    FRINTA  S25, S9
    FRINTA  S16, S15
    FRINTA  H31, H4
    FRINTN  S29, S30
    FRINTA  H29, H29
    FRINTP  D12, D17
    FRINTP  H15, H13
    FRINTM  D20, D0
    FRINTN  S8, S5
    FRINTX  S17, S3
    FRINTZ  D6, D8
    FRINTM  S25, S15
    FRINTI  H4, H14
    FRINTX  D15, D24
    FRINTZ  D12, D12
    FRINTA  D17, D25
    FRINTI  H24, H29
    FRINTI  S28, S31
    FRINTA  H31, H28
    FRINTA  H5, H15
    FRINTI  S28, S2
    FRINTX  D8, D20
    FRINTM  H14, H17
    FRINTZ  D30, D16
    FRINTP  H15, H24
    FRINTM  D16, D5
    FRINTI  H5, H31
    FRINTM  S2, S10
    FRINTX  H20, H4
    FRINTA  S10, S6
    FRINTA  S23, S30
    FRINTP  H6, H28
    FRINTN  S25, S16
    FRINTX  D12, D10
    FRINTX  H24, H5
    FRINTM  H28, H15
    FRINTI  S0, S25
    FRINTX  D10, D20
    FRINTI  D7, D30
    FRINTI  S20, S7
    FRINTZ  D17, D6
    FRINTX  S15, S8
    FRINTA  S29, S24
    FRINTP  D5, D15
    FRINTZ  S7, S0
    FRINTA  D4, D10
    FRINTN  S7, S17
    FRINTZ  H7, H22
    FRINTA  S19, S4
    FRINTX  H24, H19
    FRINTX  S0, S20
    FRINTP  S29, S12
    FRINTX  H12, H31
    FRINTN  S22, S10
    FRINTZ  S20, S12
    FRINTX  D10, D2
    FRINTP  S28, S12
    FRINTX  S6, S7
    FRINTP  H30, H6
    FRINTI  H8, H30
    FRINTX  D2, D8
    FRINTN  D3, D10
    FRINTP  D9, D24
    FRINTI  S15, S5
    FRINTN  D27, D3
    FRINTI  D4, D10
    SUBS  X20, X20, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_0
    MOVZ  X6, #0xeb1d, LSL #0
    MOVK  X6, #0xd410, LSL #16
    MOVK  X6, #0x574d, LSL #32
    MOVK  X6, #0x57c8, LSL #48
    SUB  X7, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0xe434, LSL #0
    MOVK  X6, #0xc03c, LSL #16
    MOVK  X6, #0x46f0, LSL #32
    MOVK  X6, #0x515, LSL #48
    SUB  X7, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5683, LSL #0
    MOVK  X6, #0x41f3, LSL #16
    MOVK  X6, #0x7c5c, LSL #32
    MOVK  X6, #0x6e1, LSL #48
    SUB  X7, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0xe6a8, LSL #0
    MOVK  X6, #0xb595, LSL #16
    MOVK  X6, #0x64aa, LSL #32
    MOVK  X6, #0x9567, LSL #48
    SUB  X7, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x1ed4, LSL #0
    MOVK  X6, #0xc2b, LSL #16
    MOVK  X6, #0x461, LSL #32
    MOVK  X6, #0xebad, LSL #48
    SUB  X7, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0xaa0f, LSL #0
    MOVK  X6, #0x7ed4, LSL #16
    MOVK  X6, #0x90d, LSL #32
    MOVK  X6, #0x6b32, LSL #48
    SUB  X7, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0xbf75, LSL #0
    MOVK  X6, #0xf308, LSL #16
    MOVK  X6, #0xd73e, LSL #32
    MOVK  X6, #0xf92a, LSL #48
    SUB  X7, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0xcdc2, LSL #0
    MOVK  X6, #0xc592, LSL #16
    MOVK  X6, #0x505f, LSL #32
    MOVK  X6, #0xc79, LSL #48
    SUB  X7, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x2e37, LSL #0
    MOVK  X6, #0x8905, LSL #16
    MOVK  X6, #0x3bbe, LSL #32
    MOVK  X6, #0x6ada, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x83ea, LSL #0
    MOVK  X6, #0xc8d, LSL #16
    MOVK  X6, #0x2343, LSL #32
    MOVK  X6, #0x2bf1, LSL #48
    SUB  X7, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x4bb2, LSL #0
    MOVK  X6, #0x7b2d, LSL #16
    MOVK  X6, #0x9db5, LSL #32
    MOVK  X6, #0xbad7, LSL #48
    SUB  X7, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x9733, LSL #0
    MOVK  X6, #0x2096, LSL #16
    MOVK  X6, #0x1c6f, LSL #32
    MOVK  X6, #0xec16, LSL #48
    SUB  X7, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x9a31, LSL #0
    MOVK  X6, #0x5d63, LSL #16
    MOVK  X6, #0x6a5e, LSL #32
    MOVK  X6, #0xb491, LSL #48
    SUB  X7, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0xfcef, LSL #0
    MOVK  X6, #0x1831, LSL #16
    MOVK  X6, #0x8b0d, LSL #32
    MOVK  X6, #0x453a, LSL #48
    SUB  X7, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x77b1, LSL #0
    MOVK  X6, #0xb3d6, LSL #16
    MOVK  X6, #0x29f4, LSL #32
    MOVK  X6, #0x4d17, LSL #48
    SUB  X7, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x833b, LSL #0
    MOVK  X6, #0xfd11, LSL #16
    MOVK  X6, #0x41fe, LSL #32
    MOVK  X6, #0xe159, LSL #48
    SUB  X7, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x74a, LSL #0
    MOVK  X6, #0x3949, LSL #16
    MOVK  X6, #0x5a5d, LSL #32
    MOVK  X6, #0x4731, LSL #48
    SUB  X7, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5514, LSL #0
    MOVK  X6, #0xc0e3, LSL #16
    MOVK  X6, #0x5a77, LSL #32
    MOVK  X6, #0x3b11, LSL #48
    SUB  X7, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0xc659, LSL #0
    MOVK  X6, #0xb002, LSL #16
    MOVK  X6, #0xc0d2, LSL #32
    MOVK  X6, #0xb5f9, LSL #48
    SUB  X7, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X6, FPSR
    MOVZ  X7, #0x90, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
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
    FMOV  D0, X26
    FMOV  V0.D[1], X17
    FMOV  D1, X28
    FMOV  V1.D[1], X8
    FMOV  D2, X11
    FMOV  V2.D[1], X21
    FMOV  D3, X27
    FMOV  V3.D[1], X28
    FMOV  D4, X18
    FMOV  V4.D[1], X21
    FMOV  D5, X4
    FMOV  V5.D[1], X22
    FMOV  D6, X11
    FMOV  V6.D[1], X29
    FMOV  D7, X22
    FMOV  V7.D[1], X19
    FMOV  D8, X8
    FMOV  V8.D[1], X5
    FMOV  D9, X20
    FMOV  V9.D[1], X19
    FMOV  D10, X4
    FMOV  V10.D[1], X26
    FMOV  D11, X23
    FMOV  V11.D[1], X17
    FMOV  D12, X26
    FMOV  V12.D[1], X7
    FMOV  D13, X5
    FMOV  V13.D[1], X7
    FMOV  D14, X25
    FMOV  V14.D[1], X4
    FMOV  D15, X8
    FMOV  V15.D[1], X20
    FMOV  D16, X21
    FMOV  V16.D[1], X23
    FMOV  D17, X28
    FMOV  V17.D[1], X21
    FMOV  D18, X18
    FMOV  V18.D[1], X2
    FMOV  D19, X21
    FMOV  V19.D[1], X5
    FMOV  D20, X16
    FMOV  V20.D[1], X26
    FMOV  D21, X21
    FMOV  V21.D[1], X6
    FMOV  D22, X3
    FMOV  V22.D[1], X22
    FMOV  D23, X21
    FMOV  V23.D[1], X14
    FMOV  D24, X14
    FMOV  V24.D[1], X23
    FMOV  D25, X6
    FMOV  V25.D[1], X16
    FMOV  D26, X19
    FMOV  V26.D[1], X11
    FMOV  D27, X22
    FMOV  V27.D[1], X4
    FMOV  D28, X2
    FMOV  V28.D[1], X4
    FMOV  D29, X25
    FMOV  V29.D[1], X24
    FMOV  D30, X17
    FMOV  V30.D[1], X29
    FMOV  D31, X26
    FMOV  V31.D[1], X20
    MOVZ  X7, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_1:
    FRINTM  S11, S16
    FRINTN  S0, S22
    FRINTN  H10, H29
    FRINTX  S8, S17
    FRINTP  D12, D25
    FRINTN  H17, H31
    FRINTN  H12, H8
    FRINTM  D7, D27
    FRINTX  S8, S28
    FRINTX  S0, S24
    FRINTZ  H22, H17
    FRINTX  S17, S7
    FRINTA  D12, D10
    FRINTZ  S8, S5
    FRINTZ  S28, S17
    FRINTA  S14, S22
    FRINTM  S28, S12
    FRINTZ  H22, H8
    FRINTI  S11, S0
    FRINTN  H19, H28
    FRINTP  H14, H11
    FRINTA  D7, D14
    FRINTZ  H10, H22
    FRINTI  S25, S11
    FRINTM  H24, H25
    FRINTZ  D27, D19
    FRINTP  H5, H1
    FRINTI  H31, H18
    FRINTX  D1, D27
    FRINTP  H14, H24
    FRINTI  S24, S18
    FRINTA  D30, D24
    FRINTA  H29, H7
    FRINTZ  H23, H1
    FRINTP  H8, H30
    FRINTP  D25, D10
    FRINTZ  H1, H29
    FRINTA  D19, D5
    FRINTP  D11, D25
    FRINTM  D25, D1
    FRINTX  S5, S23
    FRINTP  H18, H19
    FRINTZ  H19, H14
    FRINTZ  S29, S3
    FRINTM  S24, S0
    FRINTZ  H30, H14
    FRINTA  H23, H8
    FRINTX  H14, H18
    FRINTZ  H12, H8
    FRINTZ  D8, D5
    FRINTZ  D0, D23
    FRINTN  D17, D15
    FRINTP  S7, S17
    FRINTA  D16, D0
    FRINTP  S23, S0
    FRINTN  H0, H11
    FRINTP  H5, H20
    FRINTA  D3, D29
    FRINTP  H20, H25
    FRINTI  S17, S14
    FRINTZ  D14, D24
    FRINTM  D25, D16
    FRINTA  D5, D17
    FRINTP  D24, D7
    FRINTX  S17, S14
    FRINTZ  D9, D3
    FRINTZ  S11, S21
    FRINTN  D21, D12
    FRINTM  S18, S9
    FRINTN  H27, H15
    FRINTP  D29, D1
    FRINTP  S28, S5
    FRINTA  D22, D25
    FRINTA  S25, S10
    FRINTA  H5, H28
    FRINTA  S28, S11
    FRINTM  H12, H21
    FRINTA  H21, H12
    FRINTZ  D12, D18
    FRINTN  D1, D17
    FRINTI  H14, H24
    FRINTP  D11, D18
    FRINTI  D19, D25
    FRINTZ  H25, H29
    FRINTM  D24, D21
    FRINTI  S3, S10
    FRINTA  D15, D25
    FRINTP  S10, S28
    FRINTZ  D17, D20
    FRINTP  H28, H14
    FRINTM  H29, H15
    FRINTM  H18, H28
    FRINTN  D17, D3
    FRINTA  H15, H10
    FRINTM  D10, D15
    FRINTM  D20, D10
    FRINTA  H2, H19
    FRINTZ  S21, S24
    FRINTP  H14, H0
    FRINTA  D3, D1
    FRINTX  H15, H17
    FRINTA  D17, D4
    FRINTX  S28, S5
    FRINTP  S0, S3
    FRINTN  H24, H28
    FRINTM  H19, H20
    FRINTA  D4, D12
    FRINTI  H30, H7
    FRINTI  D5, D4
    FRINTP  D4, D18
    FRINTN  H14, H0
    FRINTI  H28, H24
    FRINTA  S24, S27
    FRINTM  S5, S2
    FRINTM  H27, H19
    FRINTX  D3, D10
    FRINTN  H20, H7
    FRINTA  D0, D27
    FRINTM  H10, H5
    FRINTI  D18, D4
    FRINTP  D27, D0
    FRINTM  D19, D30
    FRINTP  S12, S27
    FRINTP  S4, S10
    FRINTP  S2, S24
    FRINTP  D25, D2
    FRINTA  H9, H4
    FRINTX  D26, D12
    FRINTN  H24, H14
    FRINTM  H4, H18
    FRINTA  D30, D3
    FRINTN  S5, S28
    FRINTN  H22, H6
    FRINTN  H31, H25
    FRINTM  D8, D25
    FRINTI  H2, H22
    FRINTZ  H12, H24
    FRINTZ  H7, H5
    FRINTN  S14, S10
    FRINTX  H28, H9
    FRINTX  S27, S7
    FRINTM  D5, D30
    FRINTA  H7, H16
    FRINTN  D18, D12
    FRINTI  H0, H8
    FRINTX  D12, D0
    FRINTP  H27, H14
    FRINTZ  S3, S6
    FRINTN  H6, H18
    FRINTX  D24, D4
    FRINTM  D4, D6
    FRINTX  S11, S3
    FRINTP  D25, D11
    FRINTI  H28, H28
    FRINTZ  D3, D8
    FRINTN  H8, H12
    FRINTI  D30, D0
    FRINTZ  S9, S25
    FRINTM  H5, H5
    FRINTP  S6, S24
    FRINTN  D8, D31
    FRINTN  H0, H27
    FRINTM  S31, S3
    FRINTN  D24, D20
    FRINTA  S2, S4
    FRINTP  D9, D28
    FRINTZ  S18, S10
    FRINTP  D20, D24
    FRINTZ  S23, S6
    FRINTI  D14, D20
    FRINTM  S3, S31
    FRINTN  S15, S0
    FRINTI  H11, H19
    FRINTP  H12, H8
    FRINTA  S6, S30
    FRINTZ  D28, D6
    FRINTX  S10, S23
    FRINTN  H6, H17
    FRINTZ  H0, H3
    FRINTM  S8, S9
    FRINTP  D30, D6
    FRINTX  D4, D10
    FRINTP  S23, S30
    FRINTN  D11, D12
    FRINTM  D20, D28
    FRINTM  S3, S24
    FRINTM  D28, D20
    FRINTN  H17, H20
    FRINTM  S19, S4
    FRINTZ  D12, D15
    FRINTX  S6, S12
    FRINTM  H6, H27
    FRINTM  S23, S15
    FRINTA  D15, D28
    FRINTN  H11, H19
    FRINTA  D12, D3
    FRINTA  D24, D17
    FRINTP  H17, H24
    FRINTP  H30, H18
    FRINTP  H9, H8
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_1
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X29, FPSR
    MOVZ  X16, #0x90, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D0
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D16
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D30
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X29, D31
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X6
    FMOV  V1.D[1], X25
    FMOV  D2, X8
    FMOV  V2.D[1], X14
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X11
    FMOV  V4.D[1], X22
    FMOV  D5, X20
    FMOV  V5.D[1], X29
    FMOV  D6, X21
    FMOV  V6.D[1], X24
    FMOV  D7, X24
    FMOV  V7.D[1], X22
    FMOV  D8, X19
    FMOV  V8.D[1], X21
    FMOV  D9, X4
    FMOV  V9.D[1], X5
    FMOV  D10, X23
    FMOV  V10.D[1], X6
    FMOV  D11, X8
    FMOV  V11.D[1], X20
    FMOV  D12, X19
    FMOV  V12.D[1], X18
    FMOV  D13, X29
    FMOV  V13.D[1], X2
    FMOV  D14, X11
    FMOV  V14.D[1], X16
    FMOV  D15, X14
    FMOV  V15.D[1], X23
    FMOV  D16, X2
    FMOV  V16.D[1], X25
    FMOV  D17, X17
    FMOV  V17.D[1], X26
    FMOV  D18, X20
    FMOV  V18.D[1], X5
    FMOV  D19, X20
    FMOV  V19.D[1], X27
    FMOV  D20, X4
    FMOV  V20.D[1], X24
    FMOV  D21, X23
    FMOV  V21.D[1], X7
    FMOV  D22, X2
    FMOV  V22.D[1], X28
    FMOV  D23, X17
    FMOV  V23.D[1], X25
    FMOV  D24, X24
    FMOV  V24.D[1], X8
    FMOV  D25, X4
    FMOV  V25.D[1], X22
    FMOV  D26, X23
    FMOV  V26.D[1], X17
    FMOV  D27, X5
    FMOV  V27.D[1], X25
    FMOV  D28, X20
    FMOV  V28.D[1], X11
    FMOV  D29, X4
    FMOV  V29.D[1], X21
    FMOV  D30, X8
    FMOV  V30.D[1], X8
    FMOV  D31, X7
    FMOV  V31.D[1], X11
    MOVZ  X7, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_2:
    FRINTP  S17, S2
    FRINTN  H10, H24
    FRINTN  H2, H30
    FRINTI  S5, S28
    FRINTA  H18, H29
    FRINTA  S1, S31
    FRINTN  S6, S5
    FRINTZ  D21, D27
    FRINTA  H14, H1
    FRINTZ  S21, S6
    FRINTA  H31, H14
    FRINTN  S19, S5
    FRINTI  H13, H25
    FRINTM  H10, H15
    FRINTP  S3, S31
    FRINTA  S3, S17
    FRINTA  H12, H18
    FRINTX  S18, S26
    FRINTP  H7, H13
    FRINTA  H25, H12
    FRINTN  S13, S25
    FRINTI  H15, H21
    FRINTX  S14, S15
    FRINTZ  D12, D3
    FRINTZ  D11, D2
    FRINTN  H31, H11
    FRINTZ  H9, H10
    FRINTI  S27, S7
    FRINTA  H30, H12
    FRINTM  S12, S13
    FRINTM  S2, S17
    FRINTP  S15, S19
    FRINTZ  D3, D27
    FRINTM  D11, D2
    FRINTA  D17, D30
    FRINTI  H26, H11
    FRINTZ  S15, S6
    FRINTZ  D19, D18
    FRINTI  H21, H26
    FRINTA  S6, S15
    FRINTP  H11, H17
    FRINTP  H6, H31
    FRINTN  S28, S6
    FRINTZ  H26, H9
    FRINTM  H9, H26
    FRINTM  S31, S9
    FRINTZ  H6, H31
    FRINTM  S13, S3
    FRINTM  S29, S21
    FRINTM  H30, H29
    FRINTA  S9, S15
    FRINTM  S3, S1
    FRINTM  S1, S14
    FRINTA  H15, H13
    FRINTN  S26, S19
    FRINTP  S18, S11
    FRINTP  D12, D3
    FRINTZ  S15, S23
    FRINTZ  S5, S28
    FRINTZ  D29, D1
    FRINTM  S3, S6
    FRINTN  S13, S30
    FRINTX  D6, D29
    FRINTA  H1, H3
    FRINTA  H0, H5
    FRINTX  S8, S6
    FRINTM  H6, H15
    FRINTX  S15, S8
    FRINTZ  H31, H22
    FRINTA  H20, H22
    FRINTI  D12, D1
    FRINTZ  H23, H20
    FRINTP  H3, H15
    FRINTM  D22, D9
    FRINTA  S28, S0
    FRINTZ  S20, S22
    FRINTZ  H30, H6
    FRINTN  H16, H20
    FRINTZ  D1, D13
    FRINTP  S13, S12
    FRINTM  H30, H27
    FRINTN  D0, D1
    FRINTM  D29, D0
    FRINTN  H15, H16
    FRINTM  D0, D3
    FRINTN  D16, D5
    FRINTI  S13, S13
    FRINTM  D3, D13
    FRINTA  S1, S31
    FRINTP  D31, D3
    FRINTI  H9, H16
    FRINTI  D5, D16
    FRINTN  D5, D29
    FRINTZ  D12, D31
    FRINTX  S19, S5
    FRINTN  S15, S15
    FRINTA  H5, H19
    FRINTA  S6, S15
    FRINTP  H15, H18
    FRINTX  D29, D12
    FRINTZ  H19, H29
    FRINTZ  D16, D0
    FRINTI  S8, S16
    FRINTX  D14, D19
    FRINTX  H0, H28
    FRINTA  H16, H6
    FRINTN  H31, H14
    FRINTP  D12, D6
    FRINTM  H20, H8
    FRINTZ  H28, H7
    FRINTZ  D4, D15
    FRINTP  H14, H4
    FRINTI  D8, D16
    FRINTP  D7, D31
    FRINTM  H19, H8
    FRINTI  H28, H5
    FRINTX  H4, H19
    FRINTN  D15, D20
    FRINTX  D3, D14
    FRINTI  D6, D11
    FRINTA  D8, D3
    FRINTN  H14, H15
    FRINTA  S28, S8
    FRINTZ  D19, D14
    FRINTA  S11, S28
    FRINTA  D28, D11
    FRINTI  S11, S7
    FRINTA  D26, D28
    FRINTA  D17, D12
    FRINTZ  D5, D0
    FRINTA  S31, S28
    FRINTA  H19, H4
    FRINTM  D25, D6
    FRINTA  S31, S17
    FRINTX  H21, H5
    FRINTA  S16, S31
    FRINTI  D5, D12
    FRINTP  S28, S15
    FRINTI  D31, D25
    FRINTZ  H20, H5
    FRINTZ  S16, S22
    FRINTA  D6, D16
    FRINTA  D7, D28
    FRINTZ  S8, S19
    FRINTP  H3, H22
    FRINTN  D14, D18
    FRINTI  H25, H0
    FRINTX  D0, D6
    FRINTZ  S9, S16
    FRINTI  S28, S14
    FRINTM  D18, D26
    FRINTM  S16, S18
    FRINTZ  D18, D7
    FRINTI  H5, H21
    FRINTM  S4, S11
    FRINTX  S6, S4
    FRINTN  S14, S2
    FRINTP  H20, H18
    FRINTX  D11, D20
    FRINTX  S26, S18
    FRINTI  S19, S0
    FRINTN  S4, S19
    FRINTN  S16, S31
    FRINTZ  H2, H4
    FRINTI  D15, D14
    FRINTI  S31, S26
    FRINTX  H27, H15
    FRINTI  H7, H27
    FRINTA  D14, D12
    FRINTX  H16, H0
    FRINTX  D15, D7
    FRINTA  H19, H29
    FRINTX  D21, D6
    FRINTN  H12, H9
    FRINTX  D27, D2
    FRINTN  D7, D9
    FRINTA  H6, H15
    FRINTZ  D14, D14
    FRINTI  D24, D19
    FRINTX  H0, H7
    FRINTM  D7, D14
    FRINTX  H9, H12
    FRINTI  S17, S24
    FRINTM  D5, D26
    FRINTI  H18, H7
    FRINTP  S7, S16
    FRINTA  H12, H18
    FRINTN  D24, D7
    FRINTX  H3, H11
    FRINTX  H18, H8
    FRINTA  H19, H27
    FRINTX  H2, H12
    FRINTI  D8, D6
    FRINTI  S6, S27
    FRINTN  S7, S6
    FRINTA  D14, D24
    FRINTZ  H24, H12
    FRINTN  D8, D19
    FRINTI  H27, H24
    FRINTA  H15, H5
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_2
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X27, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X23, FPSR
    MOVZ  X27, #0x90, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D0
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D1
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D27
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D30
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X23, D31
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X7
    FMOV  D2, X26
    FMOV  V2.D[1], X24
    FMOV  D3, X28
    FMOV  V3.D[1], X2
    FMOV  D4, X5
    FMOV  V4.D[1], X19
    FMOV  D5, X25
    FMOV  V5.D[1], X18
    FMOV  D6, X20
    FMOV  V6.D[1], X11
    FMOV  D7, X11
    FMOV  V7.D[1], X21
    FMOV  D8, X7
    FMOV  V8.D[1], X2
    FMOV  D9, X5
    FMOV  V9.D[1], X26
    FMOV  D10, X19
    FMOV  V10.D[1], X5
    FMOV  D11, X29
    FMOV  V11.D[1], X3
    FMOV  D12, X26
    FMOV  V12.D[1], X22
    FMOV  D13, X20
    FMOV  V13.D[1], X6
    FMOV  D14, X28
    FMOV  V14.D[1], X8
    FMOV  D15, X28
    FMOV  V15.D[1], X19
    FMOV  D16, X6
    FMOV  V16.D[1], X17
    FMOV  D17, X6
    FMOV  V17.D[1], X14
    FMOV  D18, X14
    FMOV  V18.D[1], X26
    FMOV  D19, X8
    FMOV  V19.D[1], X8
    FMOV  D20, X22
    FMOV  V20.D[1], X27
    FMOV  D21, X26
    FMOV  V21.D[1], X4
    FMOV  D22, X26
    FMOV  V22.D[1], X16
    FMOV  D23, X16
    FMOV  V23.D[1], X7
    FMOV  D24, X24
    FMOV  V24.D[1], X2
    FMOV  D25, X11
    FMOV  V25.D[1], X4
    FMOV  D26, X23
    FMOV  V26.D[1], X25
    FMOV  D27, X3
    FMOV  V27.D[1], X25
    FMOV  D28, X23
    FMOV  V28.D[1], X4
    FMOV  D29, X3
    FMOV  V29.D[1], X18
    FMOV  D30, X22
    FMOV  V30.D[1], X26
    FMOV  D31, X25
    FMOV  V31.D[1], X2
    MOVZ  X16, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_3:
    FRINTI  S14, S27
    FRINTI  S19, S29
    FRINTX  D15, D11
    FRINTN  H28, H25
    FRINTP  S22, S22
    FRINTZ  H31, H14
    FRINTX  H0, H23
    FRINTM  H13, H0
    FRINTN  D19, D7
    FRINTM  H28, H15
    FRINTM  D4, D13
    FRINTM  S5, S4
    FRINTM  H25, H24
    FRINTP  S4, S25
    FRINTA  S26, S26
    FRINTP  S28, S28
    FRINTA  S16, S4
    FRINTZ  D28, D18
    FRINTM  D31, D26
    FRINTM  H4, H18
    FRINTM  H22, H16
    FRINTX  H18, H31
    FRINTZ  S16, S28
    FRINTA  H5, H18
    FRINTP  D29, D19
    FRINTP  D24, D5
    FRINTZ  D19, D7
    FRINTZ  H28, H29
    FRINTP  D5, D7
    FRINTM  S25, S24
    FRINTZ  S31, S16
    FRINTP  D6, D31
    FRINTZ  H7, H19
    FRINTN  S18, S8
    FRINTZ  D29, D22
    FRINTZ  S23, S8
    FRINTN  H2, H23
    FRINTM  D8, D5
    FRINTN  D5, D28
    FRINTN  S24, S5
    FRINTA  H23, H2
    FRINTI  H22, H29
    FRINTM  D19, D25
    FRINTN  H28, H6
    FRINTX  S2, S28
    FRINTP  D5, D27
    FRINTN  S27, S29
    FRINTM  S29, S27
    FRINTA  S21, S8
    FRINTP  D26, D18
    FRINTI  H8, H21
    FRINTM  D28, D9
    FRINTA  S21, S12
    FRINTM  S27, S21
    FRINTN  D7, D5
    FRINTX  D31, D7
    FRINTA  D12, D8
    FRINTI  D2, D23
    FRINTA  D5, D19
    FRINTM  D19, D5
    FRINTA  H16, H7
    FRINTX  H5, H22
    FRINTI  H21, H20
    FRINTI  D10, D2
    FRINTX  S2, S27
    FRINTA  S9, S29
    FRINTP  H27, H28
    FRINTP  S15, S2
    FRINTX  H28, H27
    FRINTP  S23, S10
    FRINTX  H10, H5
    FRINTP  D20, D16
    FRINTM  H27, H26
    FRINTM  D5, D15
    FRINTA  H31, H20
    FRINTN  H18, H27
    FRINTP  S7, S31
    FRINTI  S26, S12
    FRINTX  S20, S7
    FRINTN  D15, D10
    FRINTN  D11, D5
    FRINTX  S7, S26
    FRINTZ  H13, H7
    FRINTZ  H31, H4
    FRINTZ  D30, D11
    FRINTI  H7, H15
    FRINTI  S31, S7
    FRINTI  D7, D23
    FRINTZ  D9, D21
    FRINTI  H12, H18
    FRINTA  H27, H20
    FRINTM  D20, D12
    FRINTP  D15, D31
    FRINTZ  S4, S20
    FRINTX  D26, D16
    FRINTI  D10, D28
    FRINTI  H18, H10
    FRINTA  H5, H26
    FRINTZ  D11, D19
    FRINTP  H19, H11
    FRINTZ  H16, H9
    FRINTX  S12, S5
    FRINTN  S10, S27
    FRINTA  H25, H10
    FRINTX  S5, S15
    FRINTX  D3, D18
    FRINTP  D9, D6
    FRINTA  H10, H1
    FRINTP  S15, S4
    FRINTA  H14, H28
    FRINTM  H6, H15
    FRINTI  D12, D12
    FRINTA  D23, D12
    FRINTX  H4, H10
    FRINTN  D3, D16
    FRINTA  S14, S23
    FRINTM  H10, H9
    FRINTM  H23, H10
    FRINTN  S10, S19
    FRINTM  D28, D6
    FRINTN  D16, D23
    FRINTZ  S1, S5
    FRINTP  H4, H15
    FRINTA  D27, D24
    FRINTM  S10, S1
    FRINTI  D12, D12
    FRINTA  S23, S3
    FRINTZ  H19, H29
    FRINTP  H3, H27
    FRINTI  H9, H23
    FRINTP  H27, H9
    FRINTM  S1, S16
    FRINTX  D16, D12
    FRINTX  D18, D1
    FRINTN  S23, S28
    FRINTN  D5, D23
    FRINTM  D29, D5
    FRINTX  S28, S10
    FRINTP  D22, D14
    FRINTX  S24, S3
    FRINTN  D4, D16
    FRINTZ  H9, H27
    FRINTN  H14, H4
    FRINTP  D23, D18
    FRINTM  S1, S19
    FRINTP  D31, D28
    FRINTX  D3, D29
    FRINTX  S12, S24
    FRINTN  D10, D31
    FRINTM  D19, D3
    FRINTM  H13, H12
    FRINTI  H27, H19
    FRINTI  H4, H1
    FRINTM  S14, S13
    FRINTA  D31, D10
    FRINTN  H1, H31
    FRINTA  S5, S14
    FRINTN  D24, D23
    FRINTI  H26, H15
    FRINTP  S15, S24
    FRINTP  D18, D26
    FRINTX  S24, S4
    FRINTM  D3, D3
    FRINTN  S12, S22
    FRINTA  H26, H13
    FRINTA  H1, H15
    FRINTN  H22, H3
    FRINTI  S28, S24
    FRINTN  H19, H18
    FRINTZ  S28, S4
    FRINTP  H27, H9
    FRINTZ  S24, S12
    FRINTM  H29, H19
    FRINTI  S15, S27
    FRINTI  D3, D5
    FRINTM  S5, S5
    FRINTP  H18, H2
    FRINTN  S18, S24
    FRINTM  H27, H1
    FRINTP  D9, D15
    FRINTA  S19, S3
    FRINTX  H13, H19
    FRINTA  H19, H30
    FRINTN  D2, D4
    FRINTN  D4, D28
    FRINTZ  H12, H18
    FRINTX  D1, D22
    FRINTM  H22, H29
    FRINTM  D24, D5
    FRINTM  D22, D16
    FRINTP  S28, S19
    FRINTN  S10, S14
    FRINTA  H30, H17
    FRINTZ  H14, H27
    FRINTX  S17, S24
    FRINTP  S4, S30
    FRINTN  H24, H28
    FRINTX  S16, S17
    FRINTZ  H17, H12
    FRINTN  D18, D22
    SUBS  X16, X16, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_3
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X22, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X20, FPSR
    MOVZ  X22, #0x90, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D1
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D22
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D30
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X20, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    FMOV  D1, X25
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X8
    FMOV  V3.D[1], X24
    FMOV  D4, X14
    FMOV  V4.D[1], X11
    FMOV  D5, X17
    FMOV  V5.D[1], X27
    FMOV  D6, X27
    FMOV  V6.D[1], X8
    FMOV  D7, X29
    FMOV  V7.D[1], X18
    FMOV  D8, X4
    FMOV  V8.D[1], X2
    FMOV  D9, X6
    FMOV  V9.D[1], X18
    FMOV  D10, X2
    FMOV  V10.D[1], X17
    FMOV  D11, X22
    FMOV  V11.D[1], X6
    FMOV  D12, X18
    FMOV  V12.D[1], X5
    FMOV  D13, X23
    FMOV  V13.D[1], X2
    FMOV  D14, X22
    FMOV  V14.D[1], X2
    FMOV  D15, X4
    FMOV  V15.D[1], X3
    FMOV  D16, X11
    FMOV  V16.D[1], X5
    FMOV  D17, X23
    FMOV  V17.D[1], X8
    FMOV  D18, X20
    FMOV  V18.D[1], X3
    FMOV  D19, X27
    FMOV  V19.D[1], X21
    FMOV  D20, X28
    FMOV  V20.D[1], X5
    FMOV  D21, X19
    FMOV  V21.D[1], X5
    FMOV  D22, X29
    FMOV  V22.D[1], X24
    FMOV  D23, X27
    FMOV  V23.D[1], X26
    FMOV  D24, X6
    FMOV  V24.D[1], X26
    FMOV  D25, X8
    FMOV  V25.D[1], X14
    FMOV  D26, X29
    FMOV  V26.D[1], X5
    FMOV  D27, X2
    FMOV  V27.D[1], X2
    FMOV  D28, X25
    FMOV  V28.D[1], X24
    FMOV  D29, X5
    FMOV  V29.D[1], X8
    FMOV  D30, X29
    FMOV  V30.D[1], X7
    FMOV  D31, X22
    FMOV  V31.D[1], X23
    MOVZ  X16, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_4:
    FRINTM  S17, S28
    FRINTN  H25, H27
    FRINTM  D13, D23
    FRINTX  D2, D25
    FRINTI  H5, H26
    FRINTN  S11, S2
    FRINTP  D28, D17
    FRINTA  H16, H29
    FRINTM  S30, S30
    FRINTM  S6, S1
    FRINTN  D17, D31
    FRINTA  D5, D24
    FRINTZ  H21, H4
    FRINTZ  D17, D19
    FRINTZ  H4, H17
    FRINTN  D11, D21
    FRINTP  D10, D10
    FRINTA  D10, D19
    FRINTN  D1, D1
    FRINTZ  S10, S10
    FRINTP  D13, D5
    FRINTX  H24, H6
    FRINTP  S16, S4
    FRINTM  S20, S13
    FRINTP  H26, H16
    FRINTN  D2, D1
    FRINTZ  H7, H30
    FRINTZ  S12, S26
    FRINTI  H19, H12
    FRINTP  H12, H1
    FRINTI  H21, H28
    FRINTN  S1, S18
    FRINTX  S16, S7
    FRINTN  D31, D16
    FRINTI  S6, S2
    FRINTN  S16, S19
    FRINTI  S13, S1
    FRINTX  D2, D11
    FRINTN  D18, D23
    FRINTM  H13, H21
    FRINTZ  S21, S2
    FRINTZ  S19, S1
    FRINTP  S14, S19
    FRINTZ  D13, D18
    FRINTZ  D11, D27
    FRINTN  S26, S27
    FRINTI  D7, D12
    FRINTM  D10, D24
    FRINTN  S24, S13
    FRINTN  S12, S7
    FRINTA  H15, H14
    FRINTX  H19, H10
    FRINTA  H1, H6
    FRINTM  H18, H4
    FRINTX  D23, D11
    FRINTZ  H6, H22
    FRINTZ  S13, S6
    FRINTN  S27, S29
    FRINTP  H6, H18
    FRINTA  D4, D1
    FRINTZ  D14, D21
    FRINTA  D11, D26
    FRINTI  S7, S12
    FRINTZ  D2, D27
    FRINTN  D27, D31
    FRINTM  D31, D17
    FRINTA  D10, D19
    FRINTZ  H26, H2
    FRINTX  D19, D24
    FRINTA  D21, D27
    FRINTX  H27, H8
    FRINTP  S29, S8
    FRINTN  H9, H7
    FRINTM  H12, H31
    FRINTX  H18, H10
    FRINTX  S17, S29
    FRINTN  H29, H21
    FRINTX  S10, S4
    FRINTA  H2, H10
    FRINTI  D4, D12
    FRINTA  S22, S27
    FRINTP  S21, S25
    FRINTA  D7, D22
    FRINTP  H1, H7
    FRINTZ  D6, D1
    FRINTP  S24, S26
    FRINTI  D7, D29
    FRINTM  H8, H9
    FRINTM  H26, H2
    FRINTI  H12, H24
    FRINTP  S23, S19
    FRINTA  H16, H9
    FRINTP  D24, D26
    FRINTX  S27, S21
    FRINTI  D22, D8
    FRINTX  S28, S4
    FRINTA  S29, S18
    FRINTA  D5, D29
    FRINTP  H25, H17
    FRINTZ  S12, S24
    FRINTI  S4, S22
    FRINTZ  H19, H7
    FRINTM  H2, H16
    FRINTA  D22, D19
    FRINTM  D16, D11
    FRINTN  S8, S11
    FRINTZ  D18, D4
    FRINTP  D24, D6
    FRINTP  D4, D7
    FRINTI  D28, D26
    FRINTP  H11, H5
    FRINTA  H21, H16
    FRINTP  S26, S25
    FRINTN  H25, H22
    FRINTM  D6, D19
    FRINTM  D5, D28
    FRINTP  S25, S12
    FRINTM  H28, H8
    FRINTP  H29, H28
    FRINTA  H28, H4
    FRINTA  S6, S28
    FRINTZ  S7, S1
    FRINTZ  S31, S2
    FRINTA  S12, S8
    FRINTM  S16, S29
    FRINTI  D29, D16
    FRINTA  H13, H6
    FRINTX  D16, D7
    FRINTI  H2, H12
    FRINTN  D14, D26
    FRINTA  S28, S13
    FRINTA  S22, S23
    FRINTZ  D23, D10
    FRINTX  H2, H16
    FRINTZ  S4, S11
    FRINTI  S26, S31
    FRINTA  H3, H21
    FRINTA  D4, D26
    FRINTA  H13, H4
    FRINTZ  H8, H12
    FRINTA  D11, D14
    FRINTI  H14, H8
    FRINTX  D10, D11
    FRINTI  S7, S22
    FRINTP  D8, D8
    FRINTZ  D12, D5
    FRINTZ  D7, D14
    FRINTZ  D16, D13
    FRINTA  H26, H13
    FRINTN  D25, D9
    FRINTA  S4, S16
    FRINTI  S31, S26
    FRINTP  D14, D26
    FRINTN  S13, S10
    FRINTI  S21, S25
    FRINTP  H3, H14
    FRINTN  H27, H10
    FRINTP  S10, S3
    FRINTN  D19, D10
    FRINTM  S3, S12
    FRINTP  S9, S19
    FRINTI  D22, D4
    FRINTX  H14, H13
    FRINTN  S19, S31
    FRINTA  D12, D8
    FRINTA  D4, D8
    FRINTA  H11, H14
    FRINTM  D25, D9
    FRINTA  D30, D25
    FRINTM  D17, D23
    FRINTN  D9, D12
    FRINTA  H19, H6
    FRINTI  D12, D4
    FRINTI  H8, H21
    FRINTP  S20, S22
    FRINTZ  H21, H30
    FRINTX  S23, S8
    FRINTN  S11, S3
    FRINTM  H25, H11
    FRINTZ  S14, S20
    FRINTX  S30, S21
    FRINTI  S13, S25
    FRINTZ  S21, S12
    FRINTA  D10, D23
    FRINTX  H22, H19
    FRINTM  S13, S17
    FRINTI  H23, H28
    FRINTZ  S17, S28
    FRINTM  D8, D13
    FRINTM  H13, H10
    FRINTN  S25, S16
    FRINTA  S19, S24
    FRINTM  D12, D13
    FRINTA  H7, H22
    FRINTZ  S28, S25
    FRINTP  H20, H23
    FRINTX  H6, H23
    FRINTA  D9, D9
    FRINTI  H4, H17
    FRINTI  S25, S28
    SUBS  X16, X16, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_4
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X7, FPSR
    MOVZ  X4, #0x90, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xff9c, LSL #0
    MOVK  X2, #0xa28e, LSL #16
    MOVK  X2, #0x5e65, LSL #32
    MOVK  X2, #0xd4b, LSL #48
    MOVZ  X3, #0x10a1, LSL #0
    MOVK  X3, #0xc514, LSL #16
    MOVK  X3, #0xdf07, LSL #32
    MOVK  X3, #0x96d6, LSL #48
    MOVZ  X4, #0x23df, LSL #0
    MOVK  X4, #0x561d, LSL #16
    MOVK  X4, #0x6137, LSL #32
    MOVK  X4, #0x613a, LSL #48
    MOVZ  X5, #0xdbf7, LSL #0
    MOVK  X5, #0xbff5, LSL #16
    MOVK  X5, #0x54eb, LSL #32
    MOVK  X5, #0x6ae4, LSL #48
    MOVZ  X6, #0x2750, LSL #0
    MOVK  X6, #0x487, LSL #16
    MOVK  X6, #0x837e, LSL #32
    MOVK  X6, #0x2b46, LSL #48
    MOVZ  X7, #0x63c5, LSL #0
    MOVK  X7, #0x94de, LSL #16
    MOVK  X7, #0x6bc2, LSL #32
    MOVK  X7, #0x2ae3, LSL #48
    MOVZ  X8, #0x700d, LSL #0
    MOVK  X8, #0x5234, LSL #16
    MOVK  X8, #0x24d4, LSL #32
    MOVK  X8, #0x2c71, LSL #48
    MOVZ  X11, #0x28fb, LSL #0
    MOVK  X11, #0xb394, LSL #16
    MOVK  X11, #0x8d4c, LSL #32
    MOVK  X11, #0xcae6, LSL #48
    MOVZ  X14, #0x3e3a, LSL #0
    MOVK  X14, #0xe301, LSL #16
    MOVK  X14, #0xc91a, LSL #32
    MOVK  X14, #0xc6f0, LSL #48
    MOVZ  X16, #0x1da6, LSL #0
    MOVK  X16, #0x3269, LSL #16
    MOVK  X16, #0xdd14, LSL #32
    MOVK  X16, #0xbb7f, LSL #48
    MOVZ  X17, #0x260b, LSL #0
    MOVK  X17, #0xd237, LSL #16
    MOVK  X17, #0x3146, LSL #32
    MOVK  X17, #0x52a5, LSL #48
    MOVZ  X18, #0xaca0, LSL #0
    MOVK  X18, #0xc259, LSL #16
    MOVK  X18, #0xb55a, LSL #32
    MOVK  X18, #0x2a36, LSL #48
    MOVZ  X19, #0x996d, LSL #0
    MOVK  X19, #0x90d2, LSL #16
    MOVK  X19, #0x9d9d, LSL #32
    MOVK  X19, #0xf249, LSL #48
    MOVZ  X20, #0x7853, LSL #0
    MOVK  X20, #0x6ad7, LSL #16
    MOVK  X20, #0xd738, LSL #32
    MOVK  X20, #0xdfba, LSL #48
    MOVZ  X21, #0xd7ba, LSL #0
    MOVK  X21, #0x9d43, LSL #16
    MOVK  X21, #0x405c, LSL #32
    MOVK  X21, #0x9974, LSL #48
    MOVZ  X22, #0x9e5d, LSL #0
    MOVK  X22, #0xafcc, LSL #16
    MOVK  X22, #0xb101, LSL #32
    MOVK  X22, #0xfe2b, LSL #48
    MOVZ  X23, #0xa167, LSL #0
    MOVK  X23, #0x6caf, LSL #16
    MOVK  X23, #0x9b93, LSL #32
    MOVK  X23, #0xc271, LSL #48
    MOVZ  X24, #0xd34d, LSL #0
    MOVK  X24, #0x59, LSL #16
    MOVK  X24, #0x713c, LSL #32
    MOVK  X24, #0xd415, LSL #48
    MOVZ  X25, #0x1007, LSL #0
    MOVK  X25, #0x41d0, LSL #16
    MOVK  X25, #0x2a0a, LSL #32
    MOVK  X25, #0x43c4, LSL #48
    MOVZ  X26, #0x8da5, LSL #0
    MOVK  X26, #0x1d63, LSL #16
    MOVK  X26, #0x61f8, LSL #32
    MOVK  X26, #0x9be9, LSL #48
    MOVZ  X27, #0x51ac, LSL #0
    MOVK  X27, #0xd513, LSL #16
    MOVK  X27, #0xff61, LSL #32
    MOVK  X27, #0x2cff, LSL #48
    MOVZ  X28, #0xeb42, LSL #0
    MOVK  X28, #0xeaf8, LSL #16
    MOVK  X28, #0x849, LSL #32
    MOVK  X28, #0x7a7d, LSL #48
    MOVZ  X29, #0x7b9a, LSL #0
    MOVK  X29, #0xa738, LSL #16
    MOVK  X29, #0x4c50, LSL #32
    MOVK  X29, #0x9813, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X21
    FMOV  D2, X18
    FMOV  V2.D[1], X28
    FMOV  D3, X28
    FMOV  V3.D[1], X7
    FMOV  D4, X29
    FMOV  V4.D[1], X8
    FMOV  D5, X18
    FMOV  V5.D[1], X29
    FMOV  D6, X5
    FMOV  V6.D[1], X21
    FMOV  D7, X26
    FMOV  V7.D[1], X2
    FMOV  D8, X8
    FMOV  V8.D[1], X21
    FMOV  D9, X7
    FMOV  V9.D[1], X14
    FMOV  D10, X7
    FMOV  V10.D[1], X27
    FMOV  D11, X17
    FMOV  V11.D[1], X11
    FMOV  D12, X16
    FMOV  V12.D[1], X8
    FMOV  D13, X16
    FMOV  V13.D[1], X2
    FMOV  D14, X20
    FMOV  V14.D[1], X5
    FMOV  D15, X24
    FMOV  V15.D[1], X6
    FMOV  D16, X27
    FMOV  V16.D[1], X24
    FMOV  D17, X4
    FMOV  V17.D[1], X7
    FMOV  D18, X21
    FMOV  V18.D[1], X21
    FMOV  D19, X3
    FMOV  V19.D[1], X14
    FMOV  D20, X17
    FMOV  V20.D[1], X21
    FMOV  D21, X26
    FMOV  V21.D[1], X2
    FMOV  D22, X22
    FMOV  V22.D[1], X22
    FMOV  D23, X23
    FMOV  V23.D[1], X7
    FMOV  D24, X27
    FMOV  V24.D[1], X20
    FMOV  D25, X24
    FMOV  V25.D[1], X16
    FMOV  D26, X29
    FMOV  V26.D[1], X17
    FMOV  D27, X22
    FMOV  V27.D[1], X16
    FMOV  D28, X5
    FMOV  V28.D[1], X23
    FMOV  D29, X4
    FMOV  V29.D[1], X26
    FMOV  D30, X29
    FMOV  V30.D[1], X28
    FMOV  D31, X11
    FMOV  V31.D[1], X18
    MOVZ  X29, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_5:
    FRINTN  S24, S31
    FRINTP  S28, S25
    FRINTZ  H25, H25
    FRINTA  S18, S20
    FRINTN  S5, S26
    FRINTZ  H10, H27
    FRINTZ  H11, H28
    FRINTA  H20, H21
    FRINTP  H27, H25
    FRINTZ  H9, H10
    FRINTI  D13, D24
    FRINTZ  H12, H27
    FRINTI  D18, D23
    FRINTX  D7, D30
    FRINTP  H1, H9
    FRINTM  D9, D31
    FRINTX  D4, D22
    FRINTZ  D13, D29
    FRINTX  H2, H6
    FRINTZ  H11, H1
    FRINTN  S24, S21
    FRINTA  S31, S5
    FRINTN  H22, H31
    FRINTN  D31, D26
    FRINTP  H20, H20
    FRINTI  D23, D12
    FRINTA  H29, H4
    FRINTI  D2, D13
    FRINTZ  S19, S8
    FRINTZ  D28, D20
    FRINTP  H0, H19
    FRINTZ  H13, H28
    FRINTN  D20, D22
    FRINTP  S6, S15
    FRINTI  S12, S13
    FRINTP  D4, D31
    FRINTI  D1, D12
    FRINTZ  H19, H7
    FRINTP  H7, H18
    FRINTA  D18, D0
    FRINTN  H12, H20
    FRINTM  S3, S9
    FRINTX  H26, H23
    FRINTP  H20, H29
    FRINTX  D22, D1
    FRINTA  D25, D22
    FRINTX  S23, S3
    FRINTM  D26, D26
    FRINTA  S7, S23
    FRINTI  D5, D19
    FRINTP  S0, S5
    FRINTM  D16, D23
    FRINTI  D22, D6
    FRINTZ  S28, S16
    FRINTA  H6, H18
    FRINTN  H16, H31
    FRINTM  H29, H6
    FRINTX  H6, H16
    FRINTP  D9, D26
    FRINTI  S14, S28
    FRINTN  H19, H4
    FRINTN  D31, D12
    FRINTZ  D4, D19
    FRINTI  S28, S22
    FRINTP  H8, H20
    FRINTP  H22, H20
    FRINTM  S20, S9
    FRINTN  D1, D0
    FRINTZ  S19, S1
    FRINTN  S13, S19
    FRINTI  S7, S13
    FRINTI  D18, D0
    FRINTA  D9, D7
    FRINTM  S2, S27
    FRINTX  H7, H25
    FRINTX  S27, S30
    FRINTP  D4, D31
    FRINTI  D12, D7
    FRINTA  H25, H4
    FRINTP  H31, H9
    FRINTM  D30, D18
    FRINTX  H7, H27
    FRINTI  S26, S7
    FRINTI  D7, D25
    FRINTM  D10, D8
    FRINTZ  S13, S20
    FRINTZ  D9, D2
    FRINTZ  H4, H26
    FRINTZ  S3, S9
    FRINTM  D19, D5
    FRINTM  H26, H12
    FRINTI  H8, H30
    FRINTA  D0, D31
    FRINTA  S1, S7
    FRINTA  H18, H1
    FRINTN  D3, D7
    FRINTN  D20, D29
    FRINTP  D7, D28
    FRINTA  H31, H7
    FRINTN  S9, S8
    FRINTN  D29, D19
    FRINTN  H0, H4
    FRINTX  H12, H13
    FRINTI  D5, D12
    FRINTX  S15, S6
    FRINTN  S1, S29
    FRINTP  S17, S30
    FRINTX  D6, D23
    FRINTI  S30, S31
    FRINTZ  S11, S3
    FRINTZ  S8, S18
    FRINTP  S12, S15
    FRINTZ  H4, H20
    FRINTZ  D31, D30
    FRINTN  H20, H8
    FRINTM  D8, D0
    FRINTP  H15, H9
    FRINTI  D18, D17
    FRINTZ  H30, H31
    FRINTP  D17, D20
    FRINTZ  S27, S15
    FRINTN  D7, D1
    FRINTZ  D13, D18
    FRINTI  S31, S27
    FRINTA  S18, S0
    FRINTN  D9, D17
    FRINTX  D2, D13
    FRINTP  H3, H12
    FRINTA  D0, D21
    FRINTA  D1, D21
    FRINTP  S15, S1
    FRINTM  D17, D6
    FRINTZ  H20, H11
    FRINTN  D1, D8
    FRINTZ  S27, S1
    FRINTM  D1, D2
    FRINTP  D12, D30
    FRINTI  D6, D3
    FRINTI  D15, D15
    FRINTI  H8, H18
    FRINTM  S0, S17
    FRINTX  S28, S8
    FRINTX  S31, S31
    FRINTZ  S17, S30
    FRINTA  S13, S16
    FRINTI  D16, D1
    FRINTI  H8, H6
    FRINTA  D11, D31
    FRINTN  D1, D3
    FRINTM  H1, H28
    FRINTZ  D6, D17
    FRINTI  S21, S0
    FRINTZ  S0, S8
    FRINTZ  S18, S0
    FRINTN  H31, H21
    FRINTN  S17, S1
    FRINTZ  H3, H11
    FRINTP  D1, D27
    FRINTZ  S8, S20
    FRINTI  H20, H8
    FRINTZ  S2, S13
    FRINTZ  H20, H2
    FRINTX  S13, S17
    FRINTP  D3, D27
    FRINTI  D8, D6
    FRINTM  D2, D18
    FRINTI  H17, H8
    FRINTP  D2, D23
    FRINTZ  D6, D31
    FRINTI  S30, S1
    FRINTX  D29, D20
    FRINTA  H21, H17
    FRINTN  S11, S3
    FRINTN  D1, D30
    FRINTP  S3, S29
    FRINTA  S20, S16
    FRINTX  S27, S22
    FRINTX  S31, S21
    FRINTZ  S29, S11
    FRINTM  D18, D2
    FRINTN  D2, D28
    FRINTX  S22, S29
    FRINTI  D8, D6
    FRINTM  D11, D3
    FRINTN  D22, D27
    FRINTP  S27, S2
    FRINTM  S16, S4
    FRINTN  S15, S3
    FRINTN  D17, D9
    FRINTZ  H9, H8
    FRINTN  S23, S1
    FRINTM  S30, S27
    FRINTA  H3, H30
    FRINTZ  H6, H26
    FRINTP  D26, D0
    FRINTI  S7, S18
    FRINTI  H28, H30
    FRINTZ  S20, S20
    FRINTA  D0, D20
    FRINTN  H3, H16
    SUBS  X29, X29, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_5
    MOVZ  X17, #0xff9c, LSL #0
    MOVK  X17, #0xa28e, LSL #16
    MOVK  X17, #0x5e65, LSL #32
    MOVK  X17, #0xd4b, LSL #48
    SUB  X14, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x10a1, LSL #0
    MOVK  X17, #0xc514, LSL #16
    MOVK  X17, #0xdf07, LSL #32
    MOVK  X17, #0x96d6, LSL #48
    SUB  X14, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x23df, LSL #0
    MOVK  X17, #0x561d, LSL #16
    MOVK  X17, #0x6137, LSL #32
    MOVK  X17, #0x613a, LSL #48
    SUB  X14, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x2750, LSL #0
    MOVK  X17, #0x487, LSL #16
    MOVK  X17, #0x837e, LSL #32
    MOVK  X17, #0x2b46, LSL #48
    SUB  X14, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x63c5, LSL #0
    MOVK  X17, #0x94de, LSL #16
    MOVK  X17, #0x6bc2, LSL #32
    MOVK  X17, #0x2ae3, LSL #48
    SUB  X14, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x700d, LSL #0
    MOVK  X17, #0x5234, LSL #16
    MOVK  X17, #0x24d4, LSL #32
    MOVK  X17, #0x2c71, LSL #48
    SUB  X14, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x28fb, LSL #0
    MOVK  X17, #0xb394, LSL #16
    MOVK  X17, #0x8d4c, LSL #32
    MOVK  X17, #0xcae6, LSL #48
    SUB  X14, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x1da6, LSL #0
    MOVK  X17, #0x3269, LSL #16
    MOVK  X17, #0xdd14, LSL #32
    MOVK  X17, #0xbb7f, LSL #48
    SUB  X14, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0xaca0, LSL #0
    MOVK  X17, #0xc259, LSL #16
    MOVK  X17, #0xb55a, LSL #32
    MOVK  X17, #0x2a36, LSL #48
    SUB  X14, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x996d, LSL #0
    MOVK  X17, #0x90d2, LSL #16
    MOVK  X17, #0x9d9d, LSL #32
    MOVK  X17, #0xf249, LSL #48
    SUB  X14, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x7853, LSL #0
    MOVK  X17, #0x6ad7, LSL #16
    MOVK  X17, #0xd738, LSL #32
    MOVK  X17, #0xdfba, LSL #48
    SUB  X14, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0xd7ba, LSL #0
    MOVK  X17, #0x9d43, LSL #16
    MOVK  X17, #0x405c, LSL #32
    MOVK  X17, #0x9974, LSL #48
    SUB  X14, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x9e5d, LSL #0
    MOVK  X17, #0xafcc, LSL #16
    MOVK  X17, #0xb101, LSL #32
    MOVK  X17, #0xfe2b, LSL #48
    SUB  X14, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0xa167, LSL #0
    MOVK  X17, #0x6caf, LSL #16
    MOVK  X17, #0x9b93, LSL #32
    MOVK  X17, #0xc271, LSL #48
    SUB  X14, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0xd34d, LSL #0
    MOVK  X17, #0x59, LSL #16
    MOVK  X17, #0x713c, LSL #32
    MOVK  X17, #0xd415, LSL #48
    SUB  X14, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x1007, LSL #0
    MOVK  X17, #0x41d0, LSL #16
    MOVK  X17, #0x2a0a, LSL #32
    MOVK  X17, #0x43c4, LSL #48
    SUB  X14, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x8da5, LSL #0
    MOVK  X17, #0x1d63, LSL #16
    MOVK  X17, #0x61f8, LSL #32
    MOVK  X17, #0x9be9, LSL #48
    SUB  X14, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x51ac, LSL #0
    MOVK  X17, #0xd513, LSL #16
    MOVK  X17, #0xff61, LSL #32
    MOVK  X17, #0x2cff, LSL #48
    SUB  X14, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0xeb42, LSL #0
    MOVK  X17, #0xeaf8, LSL #16
    MOVK  X17, #0x849, LSL #32
    MOVK  X17, #0x7a7d, LSL #48
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X17, FPSR
    MOVZ  X14, #0x90, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D0
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D1
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D14
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D29
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X17, D31
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
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
    FMOV  D0, X14
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X22
    FMOV  V2.D[1], X2
    FMOV  D3, X24
    FMOV  V3.D[1], X18
    FMOV  D4, X5
    FMOV  V4.D[1], X19
    FMOV  D5, X17
    FMOV  V5.D[1], X18
    FMOV  D6, X19
    FMOV  V6.D[1], X23
    FMOV  D7, X25
    FMOV  V7.D[1], X26
    FMOV  D8, X16
    FMOV  V8.D[1], X7
    FMOV  D9, X3
    FMOV  V9.D[1], X28
    FMOV  D10, X22
    FMOV  V10.D[1], X2
    FMOV  D11, X22
    FMOV  V11.D[1], X23
    FMOV  D12, X8
    FMOV  V12.D[1], X11
    FMOV  D13, X2
    FMOV  V13.D[1], X4
    FMOV  D14, X27
    FMOV  V14.D[1], X7
    FMOV  D15, X3
    FMOV  V15.D[1], X8
    FMOV  D16, X26
    FMOV  V16.D[1], X28
    FMOV  D17, X27
    FMOV  V17.D[1], X14
    FMOV  D18, X16
    FMOV  V18.D[1], X14
    FMOV  D19, X23
    FMOV  V19.D[1], X21
    FMOV  D20, X3
    FMOV  V20.D[1], X11
    FMOV  D21, X29
    FMOV  V21.D[1], X17
    FMOV  D22, X5
    FMOV  V22.D[1], X16
    FMOV  D23, X4
    FMOV  V23.D[1], X25
    FMOV  D24, X29
    FMOV  V24.D[1], X18
    FMOV  D25, X3
    FMOV  V25.D[1], X11
    FMOV  D26, X7
    FMOV  V26.D[1], X14
    FMOV  D27, X3
    FMOV  V27.D[1], X19
    FMOV  D28, X21
    FMOV  V28.D[1], X16
    FMOV  D29, X5
    FMOV  V29.D[1], X24
    FMOV  D30, X22
    FMOV  V30.D[1], X5
    FMOV  D31, X3
    FMOV  V31.D[1], X4
    MOVZ  X18, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_6:
    FRINTX  H2, H29
    FRINTI  S29, S0
    FRINTM  S20, S25
    FRINTP  S22, S29
    FRINTI  H28, H2
    FRINTX  H14, H21
    FRINTP  D28, D30
    FRINTP  S10, S27
    FRINTI  H1, H24
    FRINTM  H0, H10
    FRINTZ  H6, H22
    FRINTI  S20, S28
    FRINTX  H7, H2
    FRINTM  S3, S4
    FRINTZ  D26, D20
    FRINTZ  D18, D7
    FRINTZ  H3, H10
    FRINTZ  S25, S26
    FRINTM  H21, H14
    FRINTM  D26, D6
    FRINTN  D2, D1
    FRINTN  D28, D5
    FRINTN  S14, S0
    FRINTM  D4, D28
    FRINTA  D29, D21
    FRINTN  H10, H23
    FRINTA  H20, H16
    FRINTM  D27, D29
    FRINTM  D13, D15
    FRINTZ  S28, S18
    FRINTI  H15, H27
    FRINTZ  D29, D28
    FRINTA  S16, S25
    FRINTM  S30, S2
    FRINTA  D5, D10
    FRINTP  H27, H30
    FRINTI  S21, S26
    FRINTA  H26, H4
    FRINTN  D9, D27
    FRINTZ  H9, H13
    FRINTM  D25, D9
    FRINTZ  H18, H21
    FRINTX  D0, D21
    FRINTZ  D13, D15
    FRINTN  S28, S1
    FRINTX  S10, S14
    FRINTP  H6, H13
    FRINTP  S21, S31
    FRINTI  D31, D30
    FRINTN  H13, H5
    FRINTP  D4, D13
    FRINTA  S13, S6
    FRINTX  H21, H4
    FRINTZ  H6, H11
    FRINTI  S30, S13
    FRINTX  D13, D7
    FRINTM  S14, S30
    FRINTN  H27, H3
    FRINTA  D24, D28
    FRINTM  H1, H10
    FRINTZ  D30, D29
    FRINTA  H8, H18
    FRINTZ  D3, D25
    FRINTM  S11, S10
    FRINTZ  S1, S14
    FRINTX  S2, S6
    FRINTN  H9, H1
    FRINTP  H28, H1
    FRINTI  H5, H31
    FRINTM  D7, D23
    FRINTI  H18, H7
    FRINTX  D10, D18
    FRINTP  H29, H16
    FRINTN  S23, S27
    FRINTP  D26, D28
    FRINTN  S25, S24
    FRINTX  D23, D21
    FRINTA  S6, S2
    FRINTM  D4, D8
    FRINTZ  D24, D11
    FRINTN  S18, S4
    FRINTI  D27, D25
    FRINTN  D14, D30
    FRINTX  S28, S9
    FRINTN  H30, H18
    FRINTM  S9, S5
    FRINTX  S21, S14
    FRINTX  H25, H7
    FRINTN  S14, S21
    FRINTM  D18, D29
    FRINTI  S1, S26
    FRINTX  D26, D28
    FRINTA  S8, S18
    FRINTX  D2, D1
    FRINTP  H16, H9
    FRINTM  S6, S8
    FRINTP  D4, D8
    FRINTN  H1, H4
    FRINTP  D7, D16
    FRINTP  D28, D24
    FRINTM  S8, S4
    FRINTM  H0, H15
    FRINTA  H4, H2
    FRINTZ  D29, D1
    FRINTM  H1, H26
    FRINTA  S21, S14
    FRINTI  H16, H6
    FRINTP  S18, S8
    FRINTM  S15, S26
    FRINTX  D24, D7
    FRINTI  S2, S27
    FRINTZ  H5, H23
    FRINTA  D27, D4
    FRINTZ  D4, D1
    FRINTI  D1, D24
    FRINTA  H30, H7
    FRINTM  H23, H0
    FRINTI  D8, D16
    FRINTA  S0, S12
    FRINTZ  S7, S19
    FRINTX  D14, D28
    FRINTM  H15, H8
    FRINTI  D22, D4
    FRINTM  D28, D0
    FRINTA  H4, H14
    FRINTA  S0, S13
    FRINTM  S16, S4
    FRINTP  D2, D18
    FRINTP  D22, D28
    FRINTP  S8, S4
    FRINTZ  H28, H27
    FRINTX  S19, S30
    FRINTP  H28, H4
    FRINTP  D30, D5
    FRINTA  S28, S19
    FRINTI  H5, H22
    FRINTI  D24, D1
    FRINTP  H14, H19
    FRINTN  S18, S14
    FRINTZ  S19, S16
    FRINTI  S17, S19
    FRINTM  D22, D17
    FRINTZ  H1, H20
    FRINTX  H12, H18
    FRINTP  H4, H2
    FRINTA  S2, S9
    FRINTP  H19, H1
    FRINTM  H20, H24
    FRINTP  S1, S30
    FRINTI  D28, D14
    FRINTN  S9, S20
    FRINTX  H2, H28
    FRINTZ  S28, S2
    FRINTZ  H9, H19
    FRINTN  S17, S28
    FRINTZ  H28, H9
    FRINTA  S18, S27
    FRINTI  S16, S28
    FRINTA  H9, H18
    FRINTM  D9, D22
    FRINTA  D2, D10
    FRINTZ  H20, H10
    FRINTA  H16, H4
    FRINTM  D18, D5
    FRINTZ  D28, D15
    FRINTA  S19, S16
    FRINTX  D30, D20
    FRINTZ  S27, S2
    FRINTA  D14, D2
    FRINTM  H22, H14
    FRINTI  D12, D19
    FRINTN  D3, D9
    FRINTX  S19, S7
    FRINTM  D2, D17
    FRINTN  D17, D27
    FRINTP  D1, D19
    FRINTI  H15, H22
    FRINTA  D20, D27
    FRINTI  D19, D12
    FRINTN  H22, H30
    FRINTN  S22, S2
    FRINTI  H18, H20
    FRINTM  H30, H2
    FRINTN  D4, D25
    FRINTX  H5, H16
    FRINTZ  H9, H3
    FRINTA  D25, D5
    FRINTI  S27, S30
    FRINTZ  S5, S22
    FRINTN  H7, H15
    FRINTA  D2, D19
    FRINTX  H3, H17
    FRINTI  H14, H16
    FRINTM  D30, D25
    FRINTN  S22, S7
    FRINTX  S25, S14
    FRINTN  S12, S4
    FRINTN  S14, S14
    FRINTI  H15, H22
    FRINTA  D7, D4
    SUBS  X18, X18, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_6
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X11, FPSR
    MOVZ  X22, #0x90, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D1
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D22
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D30
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
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
    FMOV  D0, X18
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X18
    FMOV  D4, X3
    FMOV  V4.D[1], X27
    FMOV  D5, X2
    FMOV  V5.D[1], X14
    FMOV  D6, X20
    FMOV  V6.D[1], X26
    FMOV  D7, X26
    FMOV  V7.D[1], X3
    FMOV  D8, X18
    FMOV  V8.D[1], X23
    FMOV  D9, X22
    FMOV  V9.D[1], X4
    FMOV  D10, X8
    FMOV  V10.D[1], X21
    FMOV  D11, X6
    FMOV  V11.D[1], X4
    FMOV  D12, X19
    FMOV  V12.D[1], X24
    FMOV  D13, X19
    FMOV  V13.D[1], X22
    FMOV  D14, X23
    FMOV  V14.D[1], X11
    FMOV  D15, X11
    FMOV  V15.D[1], X5
    FMOV  D16, X27
    FMOV  V16.D[1], X19
    FMOV  D17, X4
    FMOV  V17.D[1], X2
    FMOV  D18, X24
    FMOV  V18.D[1], X16
    FMOV  D19, X5
    FMOV  V19.D[1], X21
    FMOV  D20, X22
    FMOV  V20.D[1], X2
    FMOV  D21, X11
    FMOV  V21.D[1], X6
    FMOV  D22, X26
    FMOV  V22.D[1], X26
    FMOV  D23, X7
    FMOV  V23.D[1], X21
    FMOV  D24, X25
    FMOV  V24.D[1], X23
    FMOV  D25, X20
    FMOV  V25.D[1], X14
    FMOV  D26, X28
    FMOV  V26.D[1], X11
    FMOV  D27, X28
    FMOV  V27.D[1], X24
    FMOV  D28, X24
    FMOV  V28.D[1], X21
    FMOV  D29, X24
    FMOV  V29.D[1], X14
    FMOV  D30, X11
    FMOV  V30.D[1], X24
    FMOV  D31, X24
    FMOV  V31.D[1], X6
    MOVZ  X21, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_7:
    FRINTM  H8, H22
    FRINTN  S18, S28
    FRINTN  D10, D31
    FRINTA  D26, D25
    FRINTA  S13, S21
    FRINTZ  H28, H24
    FRINTX  S10, S18
    FRINTI  D27, D13
    FRINTI  H17, H27
    FRINTZ  H19, H29
    FRINTP  H2, H17
    FRINTI  D10, D31
    FRINTX  H16, H3
    FRINTX  D16, D27
    FRINTM  H31, H28
    FRINTX  D23, D3
    FRINTP  D18, D23
    FRINTP  S16, S2
    FRINTZ  D8, D26
    FRINTZ  S23, S18
    FRINTP  D16, D8
    FRINTM  H8, H22
    FRINTZ  S3, S19
    FRINTM  S19, S30
    FRINTP  S28, S10
    FRINTX  S2, S8
    FRINTZ  H25, H31
    FRINTZ  H30, H19
    FRINTZ  D13, D25
    FRINTI  H25, H28
    FRINTI  S29, S21
    FRINTM  H0, H14
    FRINTP  D21, D23
    FRINTP  H27, H16
    FRINTZ  S24, S25
    FRINTM  D22, D11
    FRINTN  S14, S24
    FRINTM  S19, S30
    FRINTX  S25, S29
    FRINTP  D17, D22
    FRINTI  S18, S2
    FRINTP  D16, D12
    FRINTM  H12, H14
    FRINTI  H19, H19
    FRINTX  D22, D0
    FRINTI  D24, D13
    FRINTA  S0, S17
    FRINTX  H30, H0
    FRINTZ  H14, H25
    FRINTA  H13, H12
    FRINTI  D23, D31
    FRINTI  H31, H13
    FRINTZ  S2, S23
    FRINTI  S13, S16
    FRINTP  H12, H24
    FRINTZ  D12, D31
    FRINTP  H2, H10
    FRINTX  H9, H9
    FRINTA  S31, S14
    FRINTM  S16, S31
    FRINTM  H6, H22
    FRINTM  D0, D9
    FRINTP  D3, D16
    FRINTP  H14, H8
    FRINTZ  S8, S12
    FRINTM  S10, S22
    FRINTX  H9, H14
    FRINTP  D1, D13
    FRINTX  S24, S30
    FRINTZ  D25, D10
    FRINTX  S13, S0
    FRINTZ  H0, H13
    FRINTA  H31, H24
    FRINTZ  S16, S25
    FRINTZ  S12, S1
    FRINTI  D30, D23
    FRINTZ  S17, S16
    FRINTX  H24, H9
    FRINTX  H13, H3
    FRINTX  D30, D25
    FRINTZ  D15, D24
    FRINTP  D16, D8
    FRINTP  S7, S12
    FRINTN  H8, H3
    FRINTP  H9, H13
    FRINTM  S2, S8
    FRINTX  H1, H2
    FRINTP  D8, D17
    FRINTI  D12, D20
    FRINTX  H31, H9
    FRINTI  H3, H1
    FRINTN  S17, S16
    FRINTN  S20, S3
    FRINTP  H25, H19
    FRINTN  H3, H13
    FRINTP  H23, H12
    FRINTX  S12, S0
    FRINTZ  D28, D25
    FRINTM  S25, S12
    FRINTM  D12, D30
    FRINTX  D0, D19
    FRINTX  H1, H23
    FRINTX  H20, H8
    FRINTI  D30, D1
    FRINTN  S24, S28
    FRINTP  H16, H30
    FRINTN  D30, D0
    FRINTI  S13, S17
    FRINTM  S27, S0
    FRINTI  S29, S25
    FRINTA  D19, D20
    FRINTM  D25, D16
    FRINTM  D28, D25
    FRINTA  S10, S12
    FRINTI  S8, S3
    FRINTI  S20, S23
    FRINTZ  H14, H30
    FRINTN  S22, S0
    FRINTM  H1, H14
    FRINTP  S28, S12
    FRINTI  D10, D28
    FRINTP  H17, H27
    FRINTM  D25, D20
    FRINTP  D29, D1
    FRINTZ  H14, H17
    FRINTN  H1, H14
    FRINTZ  D16, D19
    FRINTI  D14, D10
    FRINTI  S30, S25
    FRINTP  S16, S22
    FRINTM  S27, S29
    FRINTM  S0, S30
    FRINTX  D5, D6
    FRINTI  S3, S13
    FRINTM  S12, S6
    FRINTN  D25, D21
    FRINTM  S23, S16
    FRINTI  S30, S12
    FRINTA  H10, H13
    FRINTZ  S6, S10
    FRINTP  H21, H14
    FRINTI  H12, H1
    FRINTN  D16, D12
    FRINTX  D14, D21
    FRINTM  S12, S8
    FRINTM  S10, S7
    FRINTP  S19, S10
    FRINTZ  D21, D14
    FRINTX  H8, H27
    FRINTM  D13, D17
    FRINTI  H2, H26
    FRINTZ  S14, S25
    FRINTZ  S26, S2
    FRINTZ  S7, S13
    FRINTN  D17, D8
    FRINTP  D27, D5
    FRINTX  D1, D0
    FRINTX  H25, H27
    FRINTZ  D10, D12
    FRINTI  D11, D27
    FRINTN  H0, H1
    FRINTN  S5, S3
    FRINTP  S8, S0
    FRINTA  H3, H11
    FRINTI  H13, H17
    FRINTX  H0, H3
    FRINTM  H11, H25
    FRINTM  H12, H26
    FRINTA  D21, D8
    FRINTN  S25, S19
    FRINTA  S11, S11
    FRINTP  H17, H12
    FRINTN  D19, D5
    FRINTZ  S14, S10
    FRINTI  D14, D21
    FRINTX  S26, S26
    FRINTM  H12, H13
    FRINTI  D13, D17
    FRINTI  D22, D19
    FRINTM  S27, S11
    FRINTA  D21, D15
    FRINTM  D11, D27
    FRINTN  S15, S7
    FRINTA  H7, H13
    FRINTM  S11, S14
    FRINTM  S17, S5
    FRINTZ  D10, D11
    FRINTA  D19, D26
    FRINTZ  H13, H7
    FRINTP  H5, H22
    FRINTM  D3, D10
    FRINTM  D27, D17
    FRINTN  S11, S12
    FRINTM  H7, H3
    FRINTN  S17, S19
    FRINTX  H26, H21
    FRINTM  H10, H15
    FRINTI  H12, H17
    FRINTP  H12, H13
    FRINTN  S22, S26
    SUBS  X21, X21, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_7
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X7, FPSR
    MOVZ  X3, #0x90, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D4
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D30
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X7, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X22
    FMOV  D1, X20
    FMOV  V1.D[1], X28
    FMOV  D2, X14
    FMOV  V2.D[1], X16
    FMOV  D3, X25
    FMOV  V3.D[1], X4
    FMOV  D4, X26
    FMOV  V4.D[1], X11
    FMOV  D5, X17
    FMOV  V5.D[1], X16
    FMOV  D6, X28
    FMOV  V6.D[1], X29
    FMOV  D7, X22
    FMOV  V7.D[1], X17
    FMOV  D8, X7
    FMOV  V8.D[1], X27
    FMOV  D9, X6
    FMOV  V9.D[1], X22
    FMOV  D10, X4
    FMOV  V10.D[1], X19
    FMOV  D11, X17
    FMOV  V11.D[1], X27
    FMOV  D12, X17
    FMOV  V12.D[1], X17
    FMOV  D13, X20
    FMOV  V13.D[1], X3
    FMOV  D14, X14
    FMOV  V14.D[1], X28
    FMOV  D15, X24
    FMOV  V15.D[1], X2
    FMOV  D16, X6
    FMOV  V16.D[1], X6
    FMOV  D17, X19
    FMOV  V17.D[1], X27
    FMOV  D18, X26
    FMOV  V18.D[1], X4
    FMOV  D19, X5
    FMOV  V19.D[1], X2
    FMOV  D20, X11
    FMOV  V20.D[1], X14
    FMOV  D21, X8
    FMOV  V21.D[1], X28
    FMOV  D22, X19
    FMOV  V22.D[1], X3
    FMOV  D23, X22
    FMOV  V23.D[1], X29
    FMOV  D24, X11
    FMOV  V24.D[1], X29
    FMOV  D25, X18
    FMOV  V25.D[1], X14
    FMOV  D26, X18
    FMOV  V26.D[1], X28
    FMOV  D27, X7
    FMOV  V27.D[1], X16
    FMOV  D28, X24
    FMOV  V28.D[1], X8
    FMOV  D29, X29
    FMOV  V29.D[1], X29
    FMOV  D30, X22
    FMOV  V30.D[1], X17
    FMOV  D31, X25
    FMOV  V31.D[1], X4
    MOVZ  X8, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_8:
    FRINTZ  H15, H12
    FRINTP  D2, D29
    FRINTN  D19, D26
    FRINTZ  H21, H15
    FRINTM  S10, S24
    FRINTN  H18, H29
    FRINTA  D1, D28
    FRINTI  S15, S21
    FRINTX  D6, D30
    FRINTI  D15, D16
    FRINTP  S3, S15
    FRINTI  D31, D18
    FRINTI  D28, D6
    FRINTI  D30, D28
    FRINTN  D4, D1
    FRINTP  H15, H3
    FRINTA  H24, H31
    FRINTN  D1, D15
    FRINTA  S24, S4
    FRINTX  S22, S27
    FRINTX  H4, H22
    FRINTP  D16, D4
    FRINTX  H27, H2
    FRINTN  S19, S30
    FRINTN  D18, D31
    FRINTA  H12, H18
    FRINTI  S3, S1
    FRINTX  S22, S24
    FRINTZ  S1, S12
    FRINTA  D31, D15
    FRINTM  S4, S19
    FRINTA  S26, S10
    FRINTM  H2, H1
    FRINTM  S24, S16
    FRINTN  S29, S25
    FRINTP  H10, H4
    FRINTN  D4, D31
    FRINTN  S15, S24
    FRINTX  H28, H4
    FRINTP  S22, S26
    FRINTA  S2, S22
    FRINTZ  D31, D3
    FRINTP  D3, D12
    FRINTA  D30, D31
    FRINTN  D17, D15
    FRINTP  H24, H31
    FRINTX  H11, H27
    FRINTX  H22, H29
    FRINTI  D29, D0
    FRINTX  S16, S10
    FRINTM  H26, H2
    FRINTM  H27, H7
    FRINTI  H1, H22
    FRINTM  D18, D26
    FRINTI  H19, H30
    FRINTX  D15, D19
    FRINTI  D15, D3
    FRINTI  D30, D28
    FRINTI  D0, D11
    FRINTI  S25, S24
    FRINTZ  S12, S16
    FRINTN  D22, D12
    FRINTX  D4, D2
    FRINTN  D11, D29
    FRINTN  H18, H15
    FRINTI  H10, H0
    FRINTI  D20, D4
    FRINTX  H6, H4
    FRINTN  D16, D17
    FRINTI  H24, H27
    FRINTI  H31, H19
    FRINTX  H15, H22
    FRINTZ  D22, D6
    FRINTI  H3, H15
    FRINTI  S17, S24
    FRINTP  S12, S18
    FRINTP  S6, S16
    FRINTX  D24, D12
    FRINTP  H26, H18
    FRINTI  H27, H13
    FRINTZ  D7, D31
    FRINTP  S10, S20
    FRINTI  D18, D19
    FRINTN  D19, D22
    FRINTA  S31, S24
    FRINTA  H4, H27
    FRINTZ  D27, D18
    FRINTI  H0, H0
    FRINTP  H12, H7
    FRINTA  D15, D10
    FRINTN  D13, D15
    FRINTN  S10, S26
    FRINTI  H20, H12
    FRINTA  H7, H20
    FRINTI  S26, S26
    FRINTX  D2, D19
    FRINTN  D20, D6
    FRINTZ  S15, S7
    FRINTM  H12, H28
    FRINTZ  S19, S4
    FRINTP  D3, D12
    FRINTM  D18, D19
    FRINTI  D23, D18
    FRINTI  D6, D2
    FRINTI  S19, S9
    FRINTA  S20, S10
    FRINTM  H12, H6
    FRINTA  S4, S8
    FRINTX  H18, H0
    FRINTM  D1, D15
    FRINTI  D17, D30
    FRINTM  H6, H13
    FRINTI  D8, D19
    FRINTZ  H9, H13
    FRINTM  S25, S18
    FRINTP  H30, H20
    FRINTP  H15, H1
    FRINTA  D18, D12
    FRINTM  H7, H25
    FRINTM  H6, H18
    FRINTM  D10, D29
    FRINTP  H28, H6
    FRINTM  D2, D15
    FRINTA  H0, H20
    FRINTM  S1, S7
    FRINTP  S19, S17
    FRINTN  D15, D23
    FRINTA  S12, S19
    FRINTP  D18, D19
    FRINTM  D19, D1
    FRINTN  D17, D3
    FRINTX  H21, H15
    FRINTX  S25, S0
    FRINTI  S6, S12
    FRINTP  D20, D17
    FRINTN  H7, H21
    FRINTZ  D20, D10
    FRINTA  H12, H30
    FRINTM  S17, S9
    FRINTZ  D13, D8
    FRINTZ  H8, H25
    FRINTX  S25, S8
    FRINTA  H29, H19
    FRINTN  D1, D22
    FRINTN  S3, S29
    FRINTA  S19, S7
    FRINTN  H10, H12
    FRINTN  D15, D18
    FRINTA  H7, H4
    FRINTN  D0, D7
    FRINTA  S4, S5
    FRINTA  H18, H13
    FRINTM  D7, D13
    FRINTN  D9, D18
    FRINTX  S12, S29
    FRINTX  S18, S17
    FRINTP  D31, D9
    FRINTI  D29, D15
    FRINTX  S21, S7
    FRINTN  H8, H4
    FRINTI  H9, H1
    FRINTI  H17, H31
    FRINTN  S12, S29
    FRINTN  D15, D12
    FRINTA  H1, H3
    FRINTP  H7, H21
    FRINTX  S21, S0
    FRINTA  D5, D8
    FRINTA  S3, S9
    FRINTZ  D13, D2
    FRINTN  H8, H5
    FRINTM  S22, S13
    FRINTX  S0, S22
    FRINTP  D28, D18
    FRINTP  S9, S15
    FRINTX  H2, H9
    FRINTA  S31, S0
    FRINTI  H18, H1
    FRINTN  D25, D21
    FRINTI  H21, H28
    FRINTI  D5, D7
    FRINTP  H15, H14
    FRINTM  D28, D15
    FRINTI  H1, H2
    FRINTZ  S6, S3
    FRINTA  H12, H12
    FRINTX  S26, S5
    FRINTM  S5, S6
    FRINTM  H14, H30
    FRINTZ  H7, H14
    FRINTM  S6, S5
    FRINTM  H20, H1
    FRINTA  H14, H26
    FRINTI  H0, H18
    FRINTZ  H16, H10
    FRINTM  S10, S28
    FRINTN  D31, D12
    FRINTA  S1, S3
    FRINTA  S2, S10
    FRINTI  S18, S2
    SUBS  X8, X8, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_8
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X4, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X21, FPSR
    MOVZ  X4, #0x90, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X21, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    FMOV  D1, X8
    FMOV  V1.D[1], X26
    FMOV  D2, X3
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X14
    FMOV  D4, X17
    FMOV  V4.D[1], X22
    FMOV  D5, X21
    FMOV  V5.D[1], X5
    FMOV  D6, X7
    FMOV  V6.D[1], X19
    FMOV  D7, X3
    FMOV  V7.D[1], X17
    FMOV  D8, X8
    FMOV  V8.D[1], X21
    FMOV  D9, X25
    FMOV  V9.D[1], X25
    FMOV  D10, X26
    FMOV  V10.D[1], X6
    FMOV  D11, X5
    FMOV  V11.D[1], X25
    FMOV  D12, X24
    FMOV  V12.D[1], X3
    FMOV  D13, X28
    FMOV  V13.D[1], X16
    FMOV  D14, X23
    FMOV  V14.D[1], X17
    FMOV  D15, X25
    FMOV  V15.D[1], X18
    FMOV  D16, X17
    FMOV  V16.D[1], X26
    FMOV  D17, X7
    FMOV  V17.D[1], X17
    FMOV  D18, X20
    FMOV  V18.D[1], X17
    FMOV  D19, X7
    FMOV  V19.D[1], X23
    FMOV  D20, X11
    FMOV  V20.D[1], X20
    FMOV  D21, X19
    FMOV  V21.D[1], X6
    FMOV  D22, X18
    FMOV  V22.D[1], X23
    FMOV  D23, X19
    FMOV  V23.D[1], X18
    FMOV  D24, X23
    FMOV  V24.D[1], X25
    FMOV  D25, X14
    FMOV  V25.D[1], X17
    FMOV  D26, X27
    FMOV  V26.D[1], X14
    FMOV  D27, X4
    FMOV  V27.D[1], X29
    FMOV  D28, X6
    FMOV  V28.D[1], X7
    FMOV  D29, X19
    FMOV  V29.D[1], X29
    FMOV  D30, X8
    FMOV  V30.D[1], X18
    FMOV  D31, X19
    FMOV  V31.D[1], X22
    MOVZ  X8, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_9:
    FRINTM  D4, D31
    FRINTA  D25, D29
    FRINTN  D14, D8
    FRINTZ  H11, H23
    FRINTM  H2, H4
    FRINTX  H27, H25
    FRINTZ  S8, S6
    FRINTM  H24, H28
    FRINTI  H23, H24
    FRINTA  S25, S22
    FRINTX  D12, D25
    FRINTA  H27, H30
    FRINTA  S15, S27
    FRINTZ  S16, S8
    FRINTP  D21, D23
    FRINTN  H30, H21
    FRINTN  S23, S30
    FRINTP  D19, D14
    FRINTP  S23, S13
    FRINTP  D16, D5
    FRINTM  H17, H11
    FRINTN  H23, H23
    FRINTN  S4, S2
    FRINTN  S27, S15
    FRINTI  S25, S4
    FRINTI  S14, S14
    FRINTZ  D22, D16
    FRINTP  S14, S27
    FRINTM  H16, H17
    FRINTA  D29, D25
    FRINTI  S5, S23
    FRINTZ  H23, H25
    FRINTX  D27, D23
    FRINTI  H25, H27
    FRINTX  H2, H25
    FRINTN  D21, D12
    FRINTZ  S8, S19
    FRINTI  D28, D29
    FRINTX  H13, H14
    FRINTI  H17, H28
    FRINTI  D12, D14
    FRINTI  H16, H21
    FRINTP  D21, D2
    FRINTI  D28, D29
    FRINTZ  D23, D16
    FRINTI  S11, S28
    FRINTZ  S14, S24
    FRINTI  D29, D22
    FRINTI  H27, H26
    FRINTX  H15, H17
    FRINTA  H12, H20
    FRINTI  S16, S13
    FRINTN  S13, S11
    FRINTN  S4, S29
    FRINTM  H26, H15
    FRINTI  D5, D23
    FRINTI  S23, S4
    FRINTN  S4, S5
    FRINTP  H0, H4
    FRINTI  S17, S16
    FRINTX  S21, S26
    FRINTN  D25, D17
    FRINTZ  D16, D8
    FRINTI  H9, H27
    FRINTM  S26, S15
    FRINTZ  H8, H28
    FRINTA  S28, S9
    FRINTZ  D23, D18
    FRINTI  S17, S14
    FRINTX  H27, H16
    FRINTI  H18, H22
    FRINTI  H2, H25
    FRINTZ  S29, S8
    FRINTM  D16, D28
    FRINTN  S18, S30
    FRINTN  D11, D27
    FRINTN  D25, D11
    FRINTM  S27, S12
    FRINTA  S12, S3
    FRINTN  D20, D26
    FRINTM  S8, S18
    FRINTN  S29, S27
    FRINTZ  H27, H12
    FRINTN  D26, D0
    FRINTX  H4, H26
    FRINTA  S5, S20
    FRINTN  S3, S4
    FRINTP  H8, H12
    FRINTP  S26, S5
    FRINTP  S0, S2
    FRINTA  D29, D25
    FRINTM  D6, D22
    FRINTA  H18, H10
    FRINTM  D21, D13
    FRINTA  H12, H21
    FRINTM  H21, H3
    FRINTN  D25, D17
    FRINTZ  S20, S1
    FRINTX  D5, D21
    FRINTN  H2, H25
    FRINTP  S22, S8
    FRINTA  S1, S29
    FRINTZ  D29, D6
    FRINTP  D17, D1
    FRINTA  D13, D5
    FRINTM  D21, D29
    FRINTI  S8, S12
    FRINTM  D15, D21
    FRINTP  H1, H13
    FRINTI  D13, D10
    FRINTI  H25, H17
    FRINTX  D29, D25
    FRINTX  S4, S7
    FRINTI  H27, H1
    FRINTI  H1, H29
    FRINTZ  S31, S4
    FRINTP  D7, D27
    FRINTM  S3, S31
    FRINTZ  H15, H18
    FRINTZ  S29, S3
    FRINTI  D4, D13
    FRINTP  S7, S13
    FRINTM  S19, S31
    FRINTN  D6, D8
    FRINTA  H14, H25
    FRINTI  D5, D19
    FRINTA  H25, H31
    FRINTM  D8, D14
    FRINTA  S31, S5
    FRINTM  S20, S29
    FRINTM  D18, D6
    FRINTM  S5, S15
    FRINTP  H6, H10
    FRINTI  S0, S1
    FRINTM  H18, H12
    FRINTI  S31, S11
    FRINTA  S13, S8
    FRINTX  S4, S20
    FRINTZ  S17, S0
    FRINTZ  S21, S6
    FRINTZ  D10, D31
    FRINTZ  S23, S27
    FRINTX  S0, S4
    FRINTP  D27, D6
    FRINTX  H2, H5
    FRINTM  H6, H23
    FRINTP  D17, D13
    FRINTX  D0, D12
    FRINTP  D29, D6
    FRINTZ  D20, D0
    FRINTP  H8, H20
    FRINTI  D21, D5
    FRINTP  S20, S0
    FRINTA  S23, S20
    FRINTA  S20, S10
    FRINTA  S1, S29
    FRINTP  S12, S8
    FRINTP  S10, S28
    FRINTP  S4, S21
    FRINTM  S15, S10
    FRINTA  H10, H20
    FRINTA  D6, D2
    FRINTN  S8, S17
    FRINTP  S6, S1
    FRINTN  D31, D23
    FRINTI  D5, D8
    FRINTN  S23, S27
    FRINTA  S7, S4
    FRINTP  H28, H23
    FRINTM  D13, D6
    FRINTN  H7, H5
    FRINTX  D26, D31
    FRINTN  D27, D6
    FRINTM  D4, D22
    FRINTM  S8, S25
    FRINTI  S2, S28
    FRINTX  D14, D10
    FRINTI  D9, D14
    FRINTN  D25, D13
    FRINTP  D31, D4
    FRINTI  D10, D7
    FRINTN  S13, S27
    FRINTM  D23, D31
    FRINTA  D4, D25
    FRINTI  H27, H19
    FRINTZ  D19, D21
    FRINTI  H22, H4
    FRINTP  D7, D8
    FRINTX  H5, H3
    FRINTI  H4, H13
    FRINTI  H14, H22
    FRINTZ  H22, H10
    FRINTM  H8, H7
    FRINTP  D28, D2
    FRINTM  S22, S18
    FRINTI  D11, D25
    FRINTP  S24, S11
    FRINTA  S7, S14
    FRINTX  H3, H19
    FRINTP  H22, H2
    SUBS  X8, X8, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_9
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X29, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X16, FPSR
    MOVZ  X29, #0x90, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D1
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D29
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D30
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X16, D31
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x211a, LSL #0
    MOVK  X2, #0x7f8b, LSL #16
    MOVK  X2, #0x7812, LSL #32
    MOVK  X2, #0xf33c, LSL #48
    MOVZ  X3, #0x6cf3, LSL #0
    MOVK  X3, #0x79b1, LSL #16
    MOVK  X3, #0x57b5, LSL #32
    MOVK  X3, #0xea42, LSL #48
    MOVZ  X4, #0xe682, LSL #0
    MOVK  X4, #0xa560, LSL #16
    MOVK  X4, #0x936b, LSL #32
    MOVK  X4, #0xf37, LSL #48
    MOVZ  X5, #0x4173, LSL #0
    MOVK  X5, #0xcbe4, LSL #16
    MOVK  X5, #0x402d, LSL #32
    MOVK  X5, #0x5e83, LSL #48
    MOVZ  X6, #0x5aee, LSL #0
    MOVK  X6, #0x5e3f, LSL #16
    MOVK  X6, #0x3700, LSL #32
    MOVK  X6, #0x2fb6, LSL #48
    MOVZ  X7, #0xa914, LSL #0
    MOVK  X7, #0xfb3, LSL #16
    MOVK  X7, #0x4136, LSL #32
    MOVK  X7, #0xad36, LSL #48
    MOVZ  X8, #0x5a33, LSL #0
    MOVK  X8, #0x5deb, LSL #16
    MOVK  X8, #0x5672, LSL #32
    MOVK  X8, #0x5f93, LSL #48
    MOVZ  X11, #0x4cba, LSL #0
    MOVK  X11, #0xfa5c, LSL #16
    MOVK  X11, #0xb472, LSL #32
    MOVK  X11, #0xfd30, LSL #48
    MOVZ  X14, #0xb731, LSL #0
    MOVK  X14, #0x95bb, LSL #16
    MOVK  X14, #0xe3c7, LSL #32
    MOVK  X14, #0x8f3a, LSL #48
    MOVZ  X16, #0x2d6c, LSL #0
    MOVK  X16, #0x146e, LSL #16
    MOVK  X16, #0xaa07, LSL #32
    MOVK  X16, #0xca83, LSL #48
    MOVZ  X17, #0x157c, LSL #0
    MOVK  X17, #0xf56b, LSL #16
    MOVK  X17, #0x3aa6, LSL #32
    MOVK  X17, #0xfb72, LSL #48
    MOVZ  X18, #0xa67f, LSL #0
    MOVK  X18, #0x2a99, LSL #16
    MOVK  X18, #0x4960, LSL #32
    MOVK  X18, #0xf20d, LSL #48
    MOVZ  X19, #0xd24c, LSL #0
    MOVK  X19, #0x423, LSL #16
    MOVK  X19, #0x7f02, LSL #32
    MOVK  X19, #0x2c1f, LSL #48
    MOVZ  X20, #0x6ee5, LSL #0
    MOVK  X20, #0x936a, LSL #16
    MOVK  X20, #0xbdf1, LSL #32
    MOVK  X20, #0x7ed6, LSL #48
    MOVZ  X21, #0xad25, LSL #0
    MOVK  X21, #0xce30, LSL #16
    MOVK  X21, #0x75a8, LSL #32
    MOVK  X21, #0xcbb3, LSL #48
    MOVZ  X22, #0x7d42, LSL #0
    MOVK  X22, #0x8f1a, LSL #16
    MOVK  X22, #0x15fa, LSL #32
    MOVK  X22, #0xf7f3, LSL #48
    MOVZ  X23, #0xe58a, LSL #0
    MOVK  X23, #0x4498, LSL #16
    MOVK  X23, #0xd51b, LSL #32
    MOVK  X23, #0xbea, LSL #48
    MOVZ  X24, #0xce75, LSL #0
    MOVK  X24, #0xd31f, LSL #16
    MOVK  X24, #0x6dd9, LSL #32
    MOVK  X24, #0xb470, LSL #48
    MOVZ  X25, #0x4ff3, LSL #0
    MOVK  X25, #0x5256, LSL #16
    MOVK  X25, #0xa8b2, LSL #32
    MOVK  X25, #0xe636, LSL #48
    MOVZ  X26, #0x6be1, LSL #0
    MOVK  X26, #0xd9c4, LSL #16
    MOVK  X26, #0x7bb5, LSL #32
    MOVK  X26, #0xa9d2, LSL #48
    MOVZ  X27, #0xf8e6, LSL #0
    MOVK  X27, #0xa80a, LSL #16
    MOVK  X27, #0x55fd, LSL #32
    MOVK  X27, #0xb268, LSL #48
    MOVZ  X28, #0x19ed, LSL #0
    MOVK  X28, #0x42f1, LSL #16
    MOVK  X28, #0xee7, LSL #32
    MOVK  X28, #0xec86, LSL #48
    MOVZ  X29, #0x5192, LSL #0
    MOVK  X29, #0x7747, LSL #16
    MOVK  X29, #0xcfa8, LSL #32
    MOVK  X29, #0x75a2, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X27
    FMOV  D3, X19
    FMOV  V3.D[1], X23
    FMOV  D4, X25
    FMOV  V4.D[1], X4
    FMOV  D5, X28
    FMOV  V5.D[1], X3
    FMOV  D6, X20
    FMOV  V6.D[1], X4
    FMOV  D7, X16
    FMOV  V7.D[1], X20
    FMOV  D8, X16
    FMOV  V8.D[1], X28
    FMOV  D9, X23
    FMOV  V9.D[1], X23
    FMOV  D10, X25
    FMOV  V10.D[1], X27
    FMOV  D11, X23
    FMOV  V11.D[1], X5
    FMOV  D12, X21
    FMOV  V12.D[1], X11
    FMOV  D13, X25
    FMOV  V13.D[1], X17
    FMOV  D14, X3
    FMOV  V14.D[1], X7
    FMOV  D15, X17
    FMOV  V15.D[1], X24
    FMOV  D16, X21
    FMOV  V16.D[1], X17
    FMOV  D17, X22
    FMOV  V17.D[1], X5
    FMOV  D18, X22
    FMOV  V18.D[1], X20
    FMOV  D19, X16
    FMOV  V19.D[1], X21
    FMOV  D20, X29
    FMOV  V20.D[1], X19
    FMOV  D21, X18
    FMOV  V21.D[1], X6
    FMOV  D22, X29
    FMOV  V22.D[1], X19
    FMOV  D23, X22
    FMOV  V23.D[1], X7
    FMOV  D24, X3
    FMOV  V24.D[1], X8
    FMOV  D25, X16
    FMOV  V25.D[1], X18
    FMOV  D26, X3
    FMOV  V26.D[1], X24
    FMOV  D27, X26
    FMOV  V27.D[1], X3
    FMOV  D28, X19
    FMOV  V28.D[1], X22
    FMOV  D29, X19
    FMOV  V29.D[1], X24
    FMOV  D30, X17
    FMOV  V30.D[1], X3
    FMOV  D31, X14
    FMOV  V31.D[1], X17
    MOVZ  X6, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_10:
    FRINTM  S6, S28
    FRINTZ  S6, S24
    FRINTN  D12, D27
    FRINTN  D21, D12
    FRINTN  S22, S6
    FRINTA  D6, D23
    FRINTZ  H16, H22
    FRINTM  H7, H17
    FRINTP  D10, D21
    FRINTN  S5, S6
    FRINTA  S0, S7
    FRINTX  D20, D5
    FRINTZ  H15, H5
    FRINTM  H31, H18
    FRINTX  D27, D10
    FRINTM  H7, H16
    FRINTX  D26, D26
    FRINTA  H24, H15
    FRINTI  D16, D24
    FRINTN  D22, D13
    FRINTM  S8, S30
    FRINTP  H26, H16
    FRINTX  S15, S0
    FRINTZ  S13, S7
    FRINTA  D16, D31
    FRINTI  D5, D13
    FRINTZ  H18, H8
    FRINTX  H0, H20
    FRINTP  D13, D10
    FRINTZ  S8, S16
    FRINTA  D30, D7
    FRINTN  H4, H0
    FRINTX  H16, H5
    FRINTN  H10, H3
    FRINTP  H7, H4
    FRINTP  D13, D27
    FRINTZ  H23, H18
    FRINTI  S0, S15
    FRINTM  S18, S5
    FRINTM  H24, H1
    FRINTI  D5, D26
    FRINTP  D3, D0
    FRINTM  S0, S18
    FRINTA  D4, D8
    FRINTZ  H31, H27
    FRINTX  D4, D23
    FRINTX  S5, S13
    FRINTA  S26, S17
    FRINTM  D20, D5
    FRINTM  S5, S26
    FRINTZ  D27, D11
    FRINTI  H18, H0
    FRINTA  S28, S11
    FRINTZ  S1, S30
    FRINTI  D11, D27
    FRINTZ  D26, D5
    FRINTX  H13, H11
    FRINTI  H17, H3
    FRINTN  D30, D17
    FRINTN  S21, S16
    FRINTX  H23, H13
    FRINTX  S3, S18
    FRINTZ  D6, D31
    FRINTM  D31, D21
    FRINTM  D11, D22
    FRINTX  H21, H22
    FRINTX  H0, H7
    FRINTA  H22, H24
    FRINTN  H8, H3
    FRINTI  H11, H31
    FRINTN  S17, S31
    FRINTP  D7, D21
    FRINTX  S16, S6
    FRINTM  S24, S23
    FRINTA  H21, H0
    FRINTP  S17, S4
    FRINTN  H3, H21
    FRINTM  S20, S23
    FRINTI  S21, S26
    FRINTM  D24, D17
    FRINTA  S14, S21
    FRINTA  H15, H1
    FRINTX  H23, H13
    FRINTP  D31, D7
    FRINTP  H26, H14
    FRINTI  H13, H16
    FRINTI  H21, H4
    FRINTX  S17, S24
    FRINTA  S0, S3
    FRINTP  H30, H23
    FRINTI  H6, H21
    FRINTA  S18, S31
    FRINTX  S14, S6
    FRINTX  H1, H17
    FRINTZ  D3, D14
    FRINTM  S17, S12
    FRINTZ  H21, H26
    FRINTM  H31, H18
    FRINTX  H26, H6
    FRINTX  H17, H0
    FRINTM  S22, S31
    FRINTI  S17, S15
    FRINTX  H23, H3
    FRINTX  H24, H23
    FRINTZ  S25, S30
    FRINTP  D26, D25
    FRINTX  S23, S1
    FRINTX  S15, S26
    FRINTM  D12, D15
    FRINTN  S15, S17
    FRINTX  D17, D22
    FRINTI  D1, D25
    FRINTN  S14, S2
    FRINTZ  D26, D13
    FRINTI  H13, H15
    FRINTM  H3, H13
    FRINTP  D2, D3
    FRINTA  H3, H26
    FRINTI  D25, D17
    FRINTN  H26, H6
    FRINTA  D18, D3
    FRINTP  D17, D21
    FRINTP  H17, H23
    FRINTN  D21, D14
    FRINTA  D14, D12
    FRINTX  D23, D2
    FRINTM  D27, D14
    FRINTA  D3, D17
    FRINTZ  H13, H26
    FRINTP  D14, D24
    FRINTX  H6, H23
    FRINTP  D21, D14
    FRINTX  D22, D13
    FRINTM  H24, H27
    FRINTI  H29, H6
    FRINTA  S12, S18
    FRINTZ  H14, H21
    FRINTM  S18, S24
    FRINTZ  H17, H7
    FRINTZ  D7, D3
    FRINTM  H26, H22
    FRINTA  H2, H29
    FRINTI  S27, S26
    FRINTX  D23, D21
    FRINTZ  D29, D17
    FRINTA  D3, D7
    FRINTZ  D17, D23
    FRINTP  S30, S17
    FRINTZ  H6, H12
    FRINTP  H15, H30
    FRINTN  H12, H29
    FRINTN  H25, H15
    FRINTA  D23, D6
    FRINTX  D22, D27
    FRINTA  S15, S25
    FRINTM  D29, D14
    FRINTA  D26, D2
    FRINTZ  S13, S23
    FRINTN  H30, H22
    FRINTA  S2, S13
    FRINTM  S14, S29
    FRINTZ  D5, D2
    FRINTA  S6, S13
    FRINTZ  D7, D6
    FRINTM  S13, S26
    FRINTM  S23, S7
    FRINTX  H22, H12
    FRINTZ  S17, S13
    FRINTX  H29, H20
    FRINTN  D26, D3
    FRINTZ  D3, D14
    FRINTX  D4, D15
    FRINTM  D20, D4
    FRINTA  D7, D10
    FRINTX  S29, S5
    FRINTX  S12, S20
    FRINTM  D25, D30
    FRINTM  S6, S29
    FRINTA  D20, D22
    FRINTA  H29, H7
    FRINTI  D15, D20
    FRINTN  H31, H12
    FRINTM  D10, D7
    FRINTA  S14, S29
    FRINTZ  S30, S7
    FRINTM  D2, D30
    FRINTA  S3, S31
    FRINTX  D25, D6
    FRINTZ  S13, S15
    FRINTN  S31, S3
    FRINTA  D7, D2
    FRINTI  S13, S31
    FRINTM  D20, D6
    FRINTI  S15, S31
    FRINTM  H31, H15
    FRINTZ  D3, D10
    FRINTM  S10, S25
    FRINTA  D29, D29
    FRINTX  H15, H20
    FRINTN  H26, H25
    SUBS  X6, X6, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_10
    MOVZ  X14, #0x211a, LSL #0
    MOVK  X14, #0x7f8b, LSL #16
    MOVK  X14, #0x7812, LSL #32
    MOVK  X14, #0xf33c, LSL #48
    SUB  X19, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x6cf3, LSL #0
    MOVK  X14, #0x79b1, LSL #16
    MOVK  X14, #0x57b5, LSL #32
    MOVK  X14, #0xea42, LSL #48
    SUB  X19, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x4173, LSL #0
    MOVK  X14, #0xcbe4, LSL #16
    MOVK  X14, #0x402d, LSL #32
    MOVK  X14, #0x5e83, LSL #48
    SUB  X19, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xa914, LSL #0
    MOVK  X14, #0xfb3, LSL #16
    MOVK  X14, #0x4136, LSL #32
    MOVK  X14, #0xad36, LSL #48
    SUB  X19, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x5a33, LSL #0
    MOVK  X14, #0x5deb, LSL #16
    MOVK  X14, #0x5672, LSL #32
    MOVK  X14, #0x5f93, LSL #48
    SUB  X19, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x4cba, LSL #0
    MOVK  X14, #0xfa5c, LSL #16
    MOVK  X14, #0xb472, LSL #32
    MOVK  X14, #0xfd30, LSL #48
    SUB  X19, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x2d6c, LSL #0
    MOVK  X14, #0x146e, LSL #16
    MOVK  X14, #0xaa07, LSL #32
    MOVK  X14, #0xca83, LSL #48
    SUB  X19, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x157c, LSL #0
    MOVK  X14, #0xf56b, LSL #16
    MOVK  X14, #0x3aa6, LSL #32
    MOVK  X14, #0xfb72, LSL #48
    SUB  X19, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xa67f, LSL #0
    MOVK  X14, #0x2a99, LSL #16
    MOVK  X14, #0x4960, LSL #32
    MOVK  X14, #0xf20d, LSL #48
    SUB  X19, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x6ee5, LSL #0
    MOVK  X14, #0x936a, LSL #16
    MOVK  X14, #0xbdf1, LSL #32
    MOVK  X14, #0x7ed6, LSL #48
    SUB  X19, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xad25, LSL #0
    MOVK  X14, #0xce30, LSL #16
    MOVK  X14, #0x75a8, LSL #32
    MOVK  X14, #0xcbb3, LSL #48
    SUB  X19, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x7d42, LSL #0
    MOVK  X14, #0x8f1a, LSL #16
    MOVK  X14, #0x15fa, LSL #32
    MOVK  X14, #0xf7f3, LSL #48
    SUB  X19, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xe58a, LSL #0
    MOVK  X14, #0x4498, LSL #16
    MOVK  X14, #0xd51b, LSL #32
    MOVK  X14, #0xbea, LSL #48
    SUB  X19, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xce75, LSL #0
    MOVK  X14, #0xd31f, LSL #16
    MOVK  X14, #0x6dd9, LSL #32
    MOVK  X14, #0xb470, LSL #48
    SUB  X19, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x4ff3, LSL #0
    MOVK  X14, #0x5256, LSL #16
    MOVK  X14, #0xa8b2, LSL #32
    MOVK  X14, #0xe636, LSL #48
    SUB  X19, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x6be1, LSL #0
    MOVK  X14, #0xd9c4, LSL #16
    MOVK  X14, #0x7bb5, LSL #32
    MOVK  X14, #0xa9d2, LSL #48
    SUB  X19, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xf8e6, LSL #0
    MOVK  X14, #0xa80a, LSL #16
    MOVK  X14, #0x55fd, LSL #32
    MOVK  X14, #0xb268, LSL #48
    SUB  X19, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x19ed, LSL #0
    MOVK  X14, #0x42f1, LSL #16
    MOVK  X14, #0xee7, LSL #32
    MOVK  X14, #0xec86, LSL #48
    SUB  X19, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x5192, LSL #0
    MOVK  X14, #0x7747, LSL #16
    MOVK  X14, #0xcfa8, LSL #32
    MOVK  X14, #0x75a2, LSL #48
    SUB  X19, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X14, FPSR
    MOVZ  X19, #0x91, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D0
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D1
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D4
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D5
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X19, #0xe58a, LSL #0
    MOVK  X19, #0x4498, LSL #16
    MOVK  X19, #0xd51b, LSL #32
    MOVK  X19, #0xbea, LSL #48
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D9
    MOVZ  X19, #0xe58a, LSL #0
    MOVK  X19, #0x4498, LSL #16
    MOVK  X19, #0xd51b, LSL #32
    MOVK  X19, #0xbea, LSL #48
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D12
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X19, #0xad25, LSL #0
    MOVK  X19, #0xce30, LSL #16
    MOVK  X19, #0x75a8, LSL #32
    MOVK  X19, #0xcbb3, LSL #48
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D19
    MOVZ  X19, #0x2d6c, LSL #0
    MOVK  X19, #0x146e, LSL #16
    MOVK  X19, #0xaa07, LSL #32
    MOVK  X19, #0xca83, LSL #48
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D21
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D30
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X14, D31
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
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
    FMOV  D0, X27
    FMOV  V0.D[1], X5
    FMOV  D1, X24
    FMOV  V1.D[1], X18
    FMOV  D2, X11
    FMOV  V2.D[1], X26
    FMOV  D3, X18
    FMOV  V3.D[1], X17
    FMOV  D4, X25
    FMOV  V4.D[1], X28
    FMOV  D5, X25
    FMOV  V5.D[1], X28
    FMOV  D6, X29
    FMOV  V6.D[1], X20
    FMOV  D7, X6
    FMOV  V7.D[1], X17
    FMOV  D8, X19
    FMOV  V8.D[1], X29
    FMOV  D9, X3
    FMOV  V9.D[1], X2
    FMOV  D10, X6
    FMOV  V10.D[1], X18
    FMOV  D11, X17
    FMOV  V11.D[1], X5
    FMOV  D12, X21
    FMOV  V12.D[1], X21
    FMOV  D13, X16
    FMOV  V13.D[1], X7
    FMOV  D14, X21
    FMOV  V14.D[1], X5
    FMOV  D15, X27
    FMOV  V15.D[1], X25
    FMOV  D16, X19
    FMOV  V16.D[1], X29
    FMOV  D17, X24
    FMOV  V17.D[1], X3
    FMOV  D18, X17
    FMOV  V18.D[1], X23
    FMOV  D19, X14
    FMOV  V19.D[1], X5
    FMOV  D20, X27
    FMOV  V20.D[1], X29
    FMOV  D21, X22
    FMOV  V21.D[1], X20
    FMOV  D22, X26
    FMOV  V22.D[1], X8
    FMOV  D23, X6
    FMOV  V23.D[1], X5
    FMOV  D24, X7
    FMOV  V24.D[1], X18
    FMOV  D25, X3
    FMOV  V25.D[1], X4
    FMOV  D26, X6
    FMOV  V26.D[1], X27
    FMOV  D27, X22
    FMOV  V27.D[1], X4
    FMOV  D28, X7
    FMOV  V28.D[1], X2
    FMOV  D29, X2
    FMOV  V29.D[1], X16
    FMOV  D30, X25
    FMOV  V30.D[1], X24
    FMOV  D31, X25
    FMOV  V31.D[1], X29
    MOVZ  X14, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_11:
    FRINTZ  D28, D26
    FRINTA  D25, D2
    FRINTZ  S16, S23
    FRINTN  D25, D31
    FRINTZ  S9, S22
    FRINTI  H0, H28
    FRINTM  D9, D20
    FRINTI  H17, H29
    FRINTZ  H11, H21
    FRINTN  S1, S17
    FRINTP  S8, S0
    FRINTX  D24, D8
    FRINTI  D21, D17
    FRINTN  S25, S24
    FRINTZ  D21, D21
    FRINTP  S13, S25
    FRINTN  S30, S30
    FRINTN  H20, H22
    FRINTP  H9, H16
    FRINTN  H13, H13
    FRINTA  S15, S1
    FRINTM  S1, S11
    FRINTX  H1, H30
    FRINTA  D30, D29
    FRINTX  S11, S10
    FRINTI  S2, S30
    FRINTZ  S17, S1
    FRINTZ  D9, D13
    FRINTX  H25, H3
    FRINTN  H22, H24
    FRINTZ  S10, S17
    FRINTP  H30, H21
    FRINTM  D0, D22
    FRINTN  D8, D9
    FRINTM  S21, S2
    FRINTA  S9, S10
    FRINTA  S13, S21
    FRINTM  D0, D30
    FRINTN  D10, D25
    FRINTM  D21, D2
    FRINTZ  H31, H8
    FRINTA  D7, D31
    FRINTM  S20, S7
    FRINTA  H28, H9
    FRINTA  H3, H10
    FRINTA  D16, D28
    FRINTN  D28, D16
    FRINTZ  S30, S17
    FRINTA  D13, D13
    FRINTZ  S1, S0
    FRINTX  H31, H25
    FRINTM  S10, S21
    FRINTP  H24, H10
    FRINTI  D21, D5
    FRINTZ  S25, S21
    FRINTX  H22, H31
    FRINTX  H21, H22
    FRINTX  H5, H28
    FRINTN  S13, S5
    FRINTI  S14, S1
    FRINTM  H16, H2
    FRINTZ  S22, S16
    FRINTX  S7, S16
    FRINTZ  S31, S20
    FRINTI  D28, D31
    FRINTM  D17, D24
    FRINTP  H0, H17
    FRINTI  H5, H28
    FRINTI  S20, S3
    FRINTN  H16, H26
    FRINTZ  S10, S14
    FRINTM  D6, D22
    FRINTP  S4, S16
    FRINTM  D24, D25
    FRINTM  S28, S6
    FRINTZ  H4, H31
    FRINTA  D22, D21
    FRINTP  S1, S13
    FRINTP  H23, H11
    FRINTZ  H31, H10
    FRINTZ  S14, S1
    FRINTZ  H16, H5
    FRINTM  S10, S20
    FRINTZ  S5, S10
    FRINTI  H6, H5
    FRINTX  S11, S4
    FRINTZ  S25, S22
    FRINTI  D9, D16
    FRINTX  D17, D19
    FRINTI  S2, S14
    FRINTI  S21, S25
    FRINTN  D5, D9
    FRINTM  S14, S29
    FRINTZ  H19, H5
    FRINTI  S5, S21
    FRINTM  S22, S11
    FRINTX  D25, D17
    FRINTM  D29, D5
    FRINTI  S14, S23
    FRINTM  H23, H19
    FRINTA  S5, S31
    FRINTP  D9, D14
    FRINTA  S31, S25
    FRINTA  D4, D23
    FRINTI  H23, H31
    FRINTP  S4, S9
    FRINTZ  S13, S2
    FRINTM  H2, H0
    FRINTA  S14, S13
    FRINTX  S0, S14
    FRINTZ  H13, H28
    FRINTP  H28, H0
    FRINTZ  H25, H12
    FRINTZ  H12, H4
    FRINTX  H7, H29
    FRINTI  D14, D13
    FRINTI  D13, D25
    FRINTP  D0, D28
    FRINTP  H18, H2
    FRINTP  H9, H23
    FRINTA  S4, S22
    FRINTM  D22, D8
    FRINTN  D1, D31
    FRINTX  D8, D7
    FRINTP  S23, S12
    FRINTX  H17, H13
    FRINTX  S13, S9
    FRINTX  D28, D8
    FRINTM  D12, D5
    FRINTM  D23, D29
    FRINTZ  H13, H4
    FRINTZ  S8, S6
    FRINTZ  D5, D12
    FRINTA  S12, S22
    FRINTN  S7, S17
    FRINTP  S9, S13
    FRINTN  S6, S7
    FRINTA  D13, D9
    FRINTZ  H2, H5
    FRINTA  D5, D28
    FRINTN  H29, H5
    FRINTA  S31, S18
    FRINTZ  D18, D12
    FRINTZ  H7, H8
    FRINTN  S17, S6
    FRINTA  S25, S23
    FRINTP  H27, H5
    FRINTN  D6, D13
    FRINTZ  S5, S31
    FRINTN  D29, D8
    FRINTN  D9, D29
    FRINTZ  H29, H18
    FRINTI  S25, S1
    FRINTP  H22, H9
    FRINTA  H4, H29
    FRINTZ  H15, H2
    FRINTZ  S17, S7
    FRINTA  S31, S25
    FRINTX  D23, D17
    FRINTA  S18, S4
    FRINTA  S4, S5
    FRINTM  S6, S6
    FRINTZ  S1, S27
    FRINTP  D7, D14
    FRINTN  D27, D3
    FRINTP  D25, D22
    FRINTM  S8, S6
    FRINTP  H9, H23
    FRINTA  H31, H12
    FRINTZ  D27, D27
    FRINTI  D5, D0
    FRINTN  H22, H1
    FRINTZ  D31, D15
    FRINTI  H0, H25
    FRINTM  D25, D24
    FRINTZ  H17, H8
    FRINTN  D17, D0
    FRINTI  S3, S27
    FRINTP  S23, S4
    FRINTI  H0, H23
    FRINTN  S8, S17
    FRINTX  D6, D0
    FRINTM  D4, D10
    FRINTN  H5, H25
    FRINTN  D25, D7
    FRINTZ  H27, H22
    FRINTN  S3, S25
    FRINTZ  D18, D5
    FRINTX  H0, H18
    FRINTZ  S10, S24
    FRINTN  H22, H4
    FRINTI  S15, S30
    FRINTX  D25, D28
    FRINTN  H15, H3
    FRINTM  D17, D0
    FRINTA  S5, S8
    FRINTN  S28, S5
    FRINTP  D23, D31
    FRINTZ  S2, S17
    FRINTX  H21, H18
    SUBS  X14, X14, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_11
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X24, FPSR
    MOVZ  X29, #0x91, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D1
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D29
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D30
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X24, D31
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X24
    FMOV  D3, X27
    FMOV  V3.D[1], X17
    FMOV  D4, X14
    FMOV  V4.D[1], X3
    FMOV  D5, X7
    FMOV  V5.D[1], X28
    FMOV  D6, X18
    FMOV  V6.D[1], X17
    FMOV  D7, X8
    FMOV  V7.D[1], X29
    FMOV  D8, X23
    FMOV  V8.D[1], X3
    FMOV  D9, X16
    FMOV  V9.D[1], X21
    FMOV  D10, X21
    FMOV  V10.D[1], X26
    FMOV  D11, X25
    FMOV  V11.D[1], X28
    FMOV  D12, X14
    FMOV  V12.D[1], X22
    FMOV  D13, X3
    FMOV  V13.D[1], X17
    FMOV  D14, X27
    FMOV  V14.D[1], X4
    FMOV  D15, X6
    FMOV  V15.D[1], X14
    FMOV  D16, X21
    FMOV  V16.D[1], X7
    FMOV  D17, X6
    FMOV  V17.D[1], X17
    FMOV  D18, X24
    FMOV  V18.D[1], X4
    FMOV  D19, X24
    FMOV  V19.D[1], X29
    FMOV  D20, X25
    FMOV  V20.D[1], X8
    FMOV  D21, X26
    FMOV  V21.D[1], X23
    FMOV  D22, X4
    FMOV  V22.D[1], X11
    FMOV  D23, X5
    FMOV  V23.D[1], X24
    FMOV  D24, X29
    FMOV  V24.D[1], X3
    FMOV  D25, X29
    FMOV  V25.D[1], X2
    FMOV  D26, X27
    FMOV  V26.D[1], X14
    FMOV  D27, X28
    FMOV  V27.D[1], X18
    FMOV  D28, X19
    FMOV  V28.D[1], X29
    FMOV  D29, X23
    FMOV  V29.D[1], X20
    FMOV  D30, X4
    FMOV  V30.D[1], X25
    FMOV  D31, X16
    FMOV  V31.D[1], X26
    MOVZ  X27, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_12:
    FRINTM  S31, S25
    FRINTM  H11, H30
    FRINTZ  D10, D20
    FRINTX  D3, D26
    FRINTZ  S7, S11
    FRINTP  S11, S20
    FRINTI  H25, H24
    FRINTX  H8, H23
    FRINTP  D29, D22
    FRINTX  H8, H11
    FRINTX  D20, D3
    FRINTI  H14, H14
    FRINTM  S8, S10
    FRINTI  D6, D31
    FRINTM  H21, H23
    FRINTA  D1, D27
    FRINTP  D9, D21
    FRINTN  H5, H25
    FRINTN  D5, D1
    FRINTX  H14, H28
    FRINTM  S18, S23
    FRINTA  H25, H2
    FRINTX  S22, S18
    FRINTZ  S12, S20
    FRINTI  S21, S8
    FRINTM  S22, S7
    FRINTM  D18, D29
    FRINTP  S1, S5
    FRINTZ  H11, H18
    FRINTI  H8, H9
    FRINTN  D18, D6
    FRINTP  S18, S22
    FRINTX  S3, S8
    FRINTP  D7, D25
    FRINTA  H6, H18
    FRINTN  S8, S12
    FRINTX  H25, H7
    FRINTA  H12, H10
    FRINTM  S20, S1
    FRINTA  D9, D3
    FRINTZ  H7, H12
    FRINTN  H3, H6
    FRINTX  S21, S16
    FRINTZ  S12, S24
    FRINTI  D18, D8
    FRINTN  H29, H18
    FRINTI  D1, D11
    FRINTZ  H19, H25
    FRINTM  D24, D19
    FRINTA  H10, H12
    FRINTN  S31, S1
    FRINTM  H11, H21
    FRINTP  D21, D9
    FRINTN  H18, H0
    FRINTZ  S18, S31
    FRINTX  S17, S7
    FRINTZ  H1, H29
    FRINTA  S21, S20
    FRINTX  H9, H17
    FRINTN  S0, S18
    FRINTX  S21, S29
    FRINTI  H18, H11
    FRINTN  D25, D18
    FRINTA  D31, D7
    FRINTP  S7, S24
    FRINTN  H29, H10
    FRINTN  D19, D4
    FRINTZ  D18, D13
    FRINTZ  S17, S25
    FRINTP  D8, D20
    FRINTP  H10, H21
    FRINTZ  S11, S24
    FRINTN  S24, S0
    FRINTA  D20, D1
    FRINTP  S0, S5
    FRINTM  S5, S11
    FRINTX  S11, S29
    FRINTN  S1, S10
    FRINTP  D27, D7
    FRINTA  D21, D9
    FRINTM  D5, D21
    FRINTN  S7, S27
    FRINTM  D25, D4
    FRINTN  H13, H24
    FRINTZ  D10, D19
    FRINTA  S31, S31
    FRINTP  D4, D5
    FRINTZ  S29, S5
    FRINTA  D9, D0
    FRINTZ  H22, H4
    FRINTZ  H0, H25
    FRINTN  D6, D22
    FRINTZ  D5, D19
    FRINTI  H24, H20
    FRINTX  H21, H0
    FRINTI  D27, D7
    FRINTN  D25, D5
    FRINTN  S23, S9
    FRINTN  D18, D29
    FRINTI  H29, H23
    FRINTX  S22, S10
    FRINTA  H10, H29
    FRINTZ  S2, S7
    FRINTM  H5, H21
    FRINTA  D18, D11
    FRINTX  D9, D20
    FRINTN  D22, D23
    FRINTN  D8, D28
    FRINTN  D20, D18
    FRINTZ  H3, H8
    FRINTA  S31, S2
    FRINTZ  S8, S31
    FRINTM  D31, D10
    FRINTI  D30, D8
    FRINTN  H4, H30
    FRINTM  D30, D20
    FRINTN  H11, H4
    FRINTX  S22, S30
    FRINTP  H21, H11
    FRINTZ  D9, D8
    FRINTZ  H27, H14
    FRINTP  D18, D22
    FRINTZ  H11, H18
    FRINTX  D7, D18
    FRINTM  D8, D27
    FRINTA  S23, S13
    FRINTM  D27, D25
    FRINTN  S2, S8
    FRINTX  S20, S23
    FRINTZ  D23, D13
    FRINTA  S29, S11
    FRINTI  H21, H7
    FRINTN  H7, H21
    FRINTA  H0, H29
    FRINTP  H12, H8
    FRINTA  H28, H7
    FRINTI  D25, D10
    FRINTP  S14, S0
    FRINTZ  H7, H29
    FRINTP  S10, S28
    FRINTX  D30, D25
    FRINTP  H18, H27
    FRINTI  D3, D12
    FRINTZ  D29, D23
    FRINTA  S27, S3
    FRINTP  H2, H18
    FRINTN  D12, D18
    FRINTA  H28, H22
    FRINTP  S22, S10
    FRINTA  D11, D27
    FRINTP  D13, D7
    FRINTM  H3, H13
    FRINTZ  H27, H14
    FRINTI  S23, S3
    FRINTP  D14, D15
    FRINTI  H10, H29
    FRINTA  H15, H20
    FRINTA  H0, H12
    FRINTN  H21, H29
    FRINTM  D20, D10
    FRINTI  D13, D22
    FRINTM  H22, H9
    FRINTX  H29, H23
    FRINTP  D9, D20
    FRINTI  D20, D11
    FRINTX  S25, S11
    FRINTM  D11, D20
    FRINTP  S7, S14
    FRINTX  S14, S25
    FRINTP  D23, D28
    FRINTM  D3, D15
    FRINTN  D2, D9
    FRINTN  H25, H27
    FRINTX  H12, H21
    FRINTA  D21, D14
    FRINTN  D13, D24
    FRINTZ  H12, H23
    FRINTZ  S21, S25
    FRINTI  D7, D8
    FRINTN  S14, S5
    FRINTP  H5, H3
    FRINTX  D3, D14
    FRINTA  D20, D8
    FRINTN  S24, S11
    FRINTP  S11, S2
    FRINTX  D18, D19
    FRINTZ  S2, S3
    FRINTM  D15, D24
    FRINTI  D24, D22
    FRINTA  H17, H13
    FRINTZ  H8, H11
    FRINTA  S27, S21
    FRINTI  S24, S8
    FRINTN  D22, D2
    FRINTP  H9, H17
    FRINTN  S14, S15
    FRINTM  D17, D24
    FRINTN  H24, H28
    FRINTX  D2, D20
    FRINTI  H3, H24
    SUBS  X27, X27, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_12
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X8, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X28, FPSR
    MOVZ  X8, #0x91, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D16
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D26
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X28, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
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
    FMOV  D0, X6
    FMOV  V0.D[1], X8
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X23
    FMOV  V2.D[1], X28
    FMOV  D3, X4
    FMOV  V3.D[1], X29
    FMOV  D4, X18
    FMOV  V4.D[1], X20
    FMOV  D5, X8
    FMOV  V5.D[1], X8
    FMOV  D6, X5
    FMOV  V6.D[1], X21
    FMOV  D7, X11
    FMOV  V7.D[1], X26
    FMOV  D8, X17
    FMOV  V8.D[1], X18
    FMOV  D9, X21
    FMOV  V9.D[1], X3
    FMOV  D10, X26
    FMOV  V10.D[1], X29
    FMOV  D11, X23
    FMOV  V11.D[1], X25
    FMOV  D12, X18
    FMOV  V12.D[1], X17
    FMOV  D13, X2
    FMOV  V13.D[1], X14
    FMOV  D14, X24
    FMOV  V14.D[1], X8
    FMOV  D15, X21
    FMOV  V15.D[1], X25
    FMOV  D16, X23
    FMOV  V16.D[1], X6
    FMOV  D17, X11
    FMOV  V17.D[1], X24
    FMOV  D18, X29
    FMOV  V18.D[1], X6
    FMOV  D19, X20
    FMOV  V19.D[1], X28
    FMOV  D20, X5
    FMOV  V20.D[1], X26
    FMOV  D21, X19
    FMOV  V21.D[1], X7
    FMOV  D22, X5
    FMOV  V22.D[1], X2
    FMOV  D23, X3
    FMOV  V23.D[1], X25
    FMOV  D24, X2
    FMOV  V24.D[1], X19
    FMOV  D25, X2
    FMOV  V25.D[1], X22
    FMOV  D26, X20
    FMOV  V26.D[1], X26
    FMOV  D27, X8
    FMOV  V27.D[1], X14
    FMOV  D28, X8
    FMOV  V28.D[1], X2
    FMOV  D29, X23
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X14
    FMOV  D31, X11
    FMOV  V31.D[1], X23
    MOVZ  X22, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_13:
    FRINTA  S14, S28
    FRINTP  H25, H25
    FRINTZ  S17, S30
    FRINTM  H26, H20
    FRINTI  D23, D31
    FRINTM  S24, S17
    FRINTZ  D6, D27
    FRINTA  H31, H23
    FRINTM  D9, D6
    FRINTN  D5, D22
    FRINTM  H24, H29
    FRINTA  S17, S14
    FRINTI  D18, D9
    FRINTZ  D23, D29
    FRINTP  D19, D25
    FRINTX  S12, S31
    FRINTA  H17, H12
    FRINTP  H13, H27
    FRINTI  D11, D5
    FRINTA  D4, D24
    FRINTM  S24, S5
    FRINTZ  H16, H4
    FRINTN  S3, S23
    FRINTI  S25, S11
    FRINTP  D4, D11
    FRINTN  H8, H25
    FRINTI  D28, D4
    FRINTM  H23, H28
    FRINTZ  H6, H23
    FRINTP  S12, S13
    FRINTX  D30, D19
    FRINTZ  D23, D12
    FRINTZ  H11, H26
    FRINTN  D3, D8
    FRINTP  H8, H23
    FRINTN  S19, S30
    FRINTZ  H27, H3
    FRINTX  D28, D14
    FRINTX  D4, D15
    FRINTM  H30, H27
    FRINTP  D13, D24
    FRINTP  S26, S19
    FRINTI  D12, D17
    FRINTA  S19, S30
    FRINTI  S27, S19
    FRINTP  H25, H11
    FRINTP  S3, S16
    FRINTA  D3, D12
    FRINTA  H17, H6
    FRINTA  H19, H28
    FRINTM  H5, H24
    FRINTN  D12, D26
    FRINTM  D15, D17
    FRINTA  S20, S25
    FRINTX  H11, H16
    FRINTN  S26, S13
    FRINTI  H13, H1
    FRINTA  H11, H14
    FRINTX  D24, D12
    FRINTA  D25, D5
    FRINTX  S14, S27
    FRINTX  S27, S20
    FRINTP  D20, D21
    FRINTA  S17, S26
    FRINTX  D1, D15
    FRINTM  H10, H3
    FRINTM  D26, D1
    FRINTZ  S30, S19
    FRINTX  D28, D27
    FRINTM  S2, S26
    FRINTX  D12, D30
    FRINTP  S26, S11
    FRINTP  H19, H2
    FRINTN  D5, D13
    FRINTX  H30, H19
    FRINTM  H11, H5
    FRINTX  D25, D28
    FRINTI  H6, H14
    FRINTA  D15, D0
    FRINTZ  D3, D30
    FRINTX  H14, H15
    FRINTA  H24, H24
    FRINTN  H5, H14
    FRINTZ  S26, S10
    FRINTZ  H19, H3
    FRINTZ  H26, H12
    FRINTI  H15, H25
    FRINTX  D30, D5
    FRINTM  S9, S11
    FRINTX  S11, S21
    FRINTI  H14, H5
    FRINTI  D21, D26
    FRINTN  H5, H24
    FRINTI  H0, H31
    FRINTA  H31, H19
    FRINTN  D28, D25
    FRINTM  H5, H21
    FRINTP  H21, H7
    FRINTP  S16, S15
    FRINTI  H29, H31
    FRINTN  D12, D6
    FRINTA  S15, S21
    FRINTX  S31, S14
    FRINTI  D16, D4
    FRINTN  D13, D31
    FRINTX  H7, H9
    FRINTI  D9, D15
    FRINTA  D6, D12
    FRINTA  H19, H16
    FRINTN  S25, S9
    FRINTN  S26, S25
    FRINTA  H16, H7
    FRINTN  S24, S3
    FRINTN  H24, H19
    FRINTI  S19, S24
    FRINTA  D25, D28
    FRINTX  S28, S9
    FRINTZ  D3, D16
    FRINTX  H12, H13
    FRINTI  S13, S26
    FRINTZ  S21, S13
    FRINTI  H3, H25
    FRINTM  H14, H19
    FRINTP  H15, H6
    FRINTI  S19, S28
    FRINTI  D6, D15
    FRINTA  D25, D14
    FRINTN  S13, S21
    FRINTX  H21, H30
    FRINTZ  H28, H11
    FRINTM  S2, S3
    FRINTI  S30, S13
    FRINTN  D16, D30
    FRINTM  H23, H0
    FRINTI  H15, H21
    FRINTM  H0, H20
    FRINTP  D3, D15
    FRINTP  D14, D12
    FRINTI  H11, H23
    FRINTM  S22, S9
    FRINTX  S13, S0
    FRINTX  H30, H25
    FRINTM  S12, S6
    FRINTN  D9, D2
    FRINTI  H12, H9
    FRINTN  H5, H27
    FRINTA  D15, D28
    FRINTM  D20, D30
    FRINTP  H27, H13
    FRINTM  S3, S16
    FRINTX  D25, D3
    FRINTZ  S31, S27
    FRINTZ  H30, H12
    FRINTN  D7, D25
    FRINTP  D16, D7
    FRINTI  H10, H16
    FRINTI  S23, S30
    FRINTI  D2, D10
    FRINTA  H30, H22
    FRINTN  S21, S23
    FRINTP  S3, S3
    FRINTP  S23, S14
    FRINTZ  H27, H25
    FRINTA  D12, D14
    FRINTM  D9, D20
    FRINTX  H22, H27
    FRINTA  S23, S22
    FRINTX  D27, D9
    FRINTI  H7, H23
    FRINTM  S10, S31
    FRINTP  D14, D30
    FRINTX  D10, D21
    FRINTZ  D25, D10
    FRINTZ  D20, D18
    FRINTX  H30, H7
    FRINTI  D23, D12
    FRINTZ  H31, H15
    FRINTA  S12, S20
    FRINTI  H9, H2
    FRINTM  D2, D31
    FRINTZ  D14, D27
    FRINTA  S20, S30
    FRINTA  S18, S25
    FRINTA  S12, S20
    FRINTM  S7, S14
    FRINTM  D4, D18
    FRINTZ  H18, H2
    FRINTM  D10, D1
    FRINTP  H30, H22
    FRINTM  H5, H3
    FRINTX  S15, S3
    FRINTA  H14, H4
    FRINTZ  D3, D23
    FRINTM  S23, S14
    FRINTX  D20, D5
    FRINTN  D2, D29
    FRINTA  H2, H7
    FRINTZ  S5, S23
    FRINTN  S22, S16
    FRINTX  S29, S12
    SUBS  X22, X22, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_13
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X17, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X6, FPSR
    MOVZ  X17, #0x91, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D0
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D1
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D2
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D3
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D4
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D7
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D10
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D11
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D13
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D17
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D21
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D28
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D30
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X6, D31
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
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
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    FMOV  V1.D[1], X17
    FMOV  D2, X16
    FMOV  V2.D[1], X24
    FMOV  D3, X28
    FMOV  V3.D[1], X18
    FMOV  D4, X4
    FMOV  V4.D[1], X18
    FMOV  D5, X21
    FMOV  V5.D[1], X18
    FMOV  D6, X6
    FMOV  V6.D[1], X3
    FMOV  D7, X24
    FMOV  V7.D[1], X23
    FMOV  D8, X24
    FMOV  V8.D[1], X26
    FMOV  D9, X5
    FMOV  V9.D[1], X11
    FMOV  D10, X7
    FMOV  V10.D[1], X23
    FMOV  D11, X24
    FMOV  V11.D[1], X3
    FMOV  D12, X24
    FMOV  V12.D[1], X8
    FMOV  D13, X3
    FMOV  V13.D[1], X16
    FMOV  D14, X5
    FMOV  V14.D[1], X23
    FMOV  D15, X2
    FMOV  V15.D[1], X22
    FMOV  D16, X11
    FMOV  V16.D[1], X14
    FMOV  D17, X14
    FMOV  V17.D[1], X25
    FMOV  D18, X5
    FMOV  V18.D[1], X11
    FMOV  D19, X21
    FMOV  V19.D[1], X22
    FMOV  D20, X27
    FMOV  V20.D[1], X25
    FMOV  D21, X8
    FMOV  V21.D[1], X14
    FMOV  D22, X5
    FMOV  V22.D[1], X22
    FMOV  D23, X19
    FMOV  V23.D[1], X4
    FMOV  D24, X27
    FMOV  V24.D[1], X18
    FMOV  D25, X20
    FMOV  V25.D[1], X25
    FMOV  D26, X2
    FMOV  V26.D[1], X25
    FMOV  D27, X3
    FMOV  V27.D[1], X11
    FMOV  D28, X26
    FMOV  V28.D[1], X23
    FMOV  D29, X21
    FMOV  V29.D[1], X17
    FMOV  D30, X4
    FMOV  V30.D[1], X7
    FMOV  D31, X22
    FMOV  V31.D[1], X23
    MOVZ  X21, #0xa, LSL #0
TSRTFloatFloatPointRoundToInteger_label_14:
    FRINTI  S22, S23
    FRINTZ  D29, D29
    FRINTX  H30, H30
    FRINTA  D13, D27
    FRINTZ  S15, S15
    FRINTA  S4, S13
    FRINTM  S20, S22
    FRINTZ  H5, H8
    FRINTZ  D3, D20
    FRINTM  H1, H30
    FRINTZ  H12, H29
    FRINTN  D8, D3
    FRINTA  D0, D15
    FRINTI  D29, D1
    FRINTM  D25, D8
    FRINTZ  D16, D4
    FRINTN  D7, D14
    FRINTM  H1, H25
    FRINTP  S16, S0
    FRINTP  D3, D16
    FRINTN  S9, S7
    FRINTN  H24, H5
    FRINTA  S15, S9
    FRINTN  S25, S15
    FRINTX  S16, S18
    FRINTN  H20, H21
    FRINTX  D30, D20
    FRINTZ  S29, S22
    FRINTN  H23, H12
    FRINTA  D22, D3
    FRINTX  D18, D22
    FRINTA  D0, D25
    FRINTI  H28, H29
    FRINTM  S22, S18
    FRINTN  S15, S20
    FRINTX  H14, H29
    FRINTI  S7, S9
    FRINTI  H20, H16
    FRINTI  D3, D22
    FRINTP  H5, H23
    FRINTP  S21, S1
    FRINTP  D8, D15
    FRINTP  S14, S5
    FRINTP  S3, S7
    FRINTM  H4, H8
    FRINTA  D1, D18
    FRINTA  D22, D4
    FRINTN  D18, D22
    FRINTP  D4, D14
    FRINTX  H23, H27
    FRINTX  D27, D1
    FRINTA  H14, H23
    FRINTX  D7, D3
    FRINTN  D17, D15
    FRINTP  H1, H31
    FRINTA  D3, D23
    FRINTZ  H0, H3
    FRINTZ  D3, D20
    FRINTX  H29, H0
    FRINTX  D26, D18
    FRINTN  H18, H17
    FRINTM  H23, H29
    FRINTM  D8, D27
    FRINTA  S0, S26
    FRINTM  D15, D23
    FRINTP  H20, H7
    FRINTA  D16, D18
    FRINTP  H23, H22
    FRINTI  H26, H16
    FRINTN  S7, S20
    FRINTP  H27, H26
    FRINTP  S20, S27
    FRINTI  D29, D3
    FRINTI  D13, D7
    FRINTM  D17, D23
    FRINTP  H1, H14
    FRINTI  H15, H4
    FRINTM  D3, D29
    FRINTX  D20, D17
    FRINTP  S22, S15
    FRINTI  S28, S27
    FRINTM  D29, D22
    FRINTN  D8, D0
    FRINTP  D16, D20
    FRINTX  H16, H1
    FRINTX  H2, H29
    FRINTZ  H20, H8
    FRINTX  H23, H2
    FRINTI  H4, H23
    FRINTN  D18, D4
    FRINTM  S2, S28
    FRINTN  D23, D13
    FRINTX  S4, S18
    FRINTZ  S13, S23
    FRINTA  H16, H16
    FRINTZ  D20, D13
    FRINTI  S29, S16
    FRINTX  H23, H1
    FRINTI  H8, H23
    FRINTN  D22, D20
    FRINTP  H24, H3
    FRINTN  D16, D10
    FRINTI  H23, H4
    FRINTZ  D18, D29
    FRINTM  D31, D10
    FRINTA  D1, D22
    FRINTN  D22, D8
    FRINTM  D29, D31
    FRINTN  H27, H5
    FRINTM  D28, D18
    FRINTP  S5, S27
    FRINTP  S6, S7
    FRINTX  D27, D22
    FRINTA  S5, S26
    FRINTM  D7, D9
    FRINTZ  S4, S29
    FRINTZ  D5, D6
    FRINTA  D22, D28
    FRINTI  H28, H1
    FRINTZ  S9, S2
    FRINTA  S1, S7
    FRINTX  S31, S25
    FRINTP  D7, D10
    FRINTP  S29, S5
    FRINTZ  D5, D27
    FRINTZ  S6, S9
    FRINTI  H26, H1
    FRINTN  D10, D26
    FRINTX  D18, D10
    FRINTA  S10, S4
    FRINTX  D26, D31
    FRINTM  H2, H5
    FRINTX  S5, S22
    FRINTA  H29, H28
    FRINTA  H0, H7
    FRINTM  D9, D29
    FRINTP  S10, S9
    FRINTA  D16, D26
    FRINTZ  H23, H6
    FRINTZ  D28, D23
    FRINTX  D9, D2
    FRINTP  S23, S16
    FRINTN  H31, H30
    FRINTA  H27, H0
    FRINTM  H1, H30
    FRINTI  D17, D28
    FRINTZ  D25, D17
    FRINTA  S17, S10
    FRINTM  H16, H11
    FRINTM  H28, H15
    FRINTZ  D7, D1
    FRINTI  D25, D28
    FRINTX  D29, D18
    FRINTX  S18, S16
    FRINTX  S16, S9
    FRINTA  H14, H7
    FRINTX  D10, D25
    FRINTA  D7, D30
    FRINTA  S22, S26
    FRINTN  S11, S10
    FRINTM  S1, S14
    FRINTI  S25, S16
    FRINTP  S14, S29
    FRINTZ  S9, S11
    FRINTP  H28, H1
    FRINTI  D23, D22
    FRINTZ  S9, S17
    FRINTM  D22, D18
    FRINTN  H0, H9
    FRINTZ  D29, D25
    FRINTP  D30, D17
    FRINTM  H10, H28
    FRINTI  S16, S31
    FRINTP  D31, D22
    FRINTN  S29, S29
    FRINTP  S1, S30
    FRINTA  S18, S21
    FRINTI  D17, D16
    FRINTM  S25, S29
    FRINTM  D18, D18
    FRINTM  H22, H14
    FRINTA  D11, D23
    FRINTN  H9, H22
    FRINTZ  D16, D9
    FRINTN  H29, H1
    FRINTI  D28, D25
    FRINTI  S30, S12
    FRINTZ  S14, S18
    FRINTZ  S18, S16
    FRINTN  D9, D10
    FRINTP  S1, S18
    FRINTA  D23, D5
    FRINTA  S5, S9
    FRINTX  H31, H29
    FRINTM  H21, H23
    FRINTA  D10, D30
    FRINTZ  H4, H14
    FRINTA  S14, S10
    FRINTZ  S28, S31
    FRINTM  S29, S1
    SUBS  X21, X21, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_14
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X8, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatFloatPointRoundToInteger_TestFail
    MRS  X11, FPSR
    MOVZ  X8, #0x91, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D19
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    FMOV  X11, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail

TSRTFloatFloatPointRoundToInteger_TestEnd:
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
TSRTFloatFloatPointRoundToInteger_TestFail:
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
