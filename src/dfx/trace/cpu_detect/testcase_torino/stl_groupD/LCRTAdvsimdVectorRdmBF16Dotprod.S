.global LCRTAdvsimdVectorRdmBF16Dotprod

.text
.p2align 4

LCRTAdvsimdVectorRdmBF16Dotprod:

LCRTAdvsimdVectorRdmBF16Dotprod_TestBegin:
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
    MOVZ  X2, #0x38ae, LSL #0
    MOVK  X2, #0x7010, LSL #16
    MOVK  X2, #0x72d7, LSL #32
    MOVK  X2, #0xd95b, LSL #48
    MOVZ  X3, #0x81b4, LSL #0
    MOVK  X3, #0x5354, LSL #16
    MOVK  X3, #0x83c9, LSL #32
    MOVK  X3, #0x1058, LSL #48
    MOVZ  X4, #0xfef6, LSL #0
    MOVK  X4, #0xccd0, LSL #16
    MOVK  X4, #0x1807, LSL #32
    MOVK  X4, #0x7cca, LSL #48
    MOVZ  X5, #0xdf05, LSL #0
    MOVK  X5, #0x63f9, LSL #16
    MOVK  X5, #0xe79, LSL #32
    MOVK  X5, #0x431e, LSL #48
    MOVZ  X6, #0xab21, LSL #0
    MOVK  X6, #0x103b, LSL #16
    MOVK  X6, #0x3467, LSL #32
    MOVK  X6, #0xd2d9, LSL #48
    MOVZ  X7, #0x81d, LSL #0
    MOVK  X7, #0xdcfc, LSL #16
    MOVK  X7, #0x810a, LSL #32
    MOVK  X7, #0xc00a, LSL #48
    MOVZ  X8, #0xc21a, LSL #0
    MOVK  X8, #0x1179, LSL #16
    MOVK  X8, #0x48d0, LSL #32
    MOVK  X8, #0xbe7f, LSL #48
    MOVZ  X10, #0xc1ea, LSL #0
    MOVK  X10, #0xe764, LSL #16
    MOVK  X10, #0xdaea, LSL #32
    MOVK  X10, #0xc246, LSL #48
    MOVZ  X12, #0xbda1, LSL #0
    MOVK  X12, #0xc47, LSL #16
    MOVK  X12, #0xf403, LSL #32
    MOVK  X12, #0xaf0c, LSL #48
    MOVZ  X16, #0x5735, LSL #0
    MOVK  X16, #0x6aeb, LSL #16
    MOVK  X16, #0x9992, LSL #32
    MOVK  X16, #0x243c, LSL #48
    MOVZ  X17, #0xd33e, LSL #0
    MOVK  X17, #0xd2b1, LSL #16
    MOVK  X17, #0x39ae, LSL #32
    MOVK  X17, #0x817, LSL #48
    MOVZ  X18, #0x194e, LSL #0
    MOVK  X18, #0x96df, LSL #16
    MOVK  X18, #0x44ce, LSL #32
    MOVK  X18, #0xccdf, LSL #48
    MOVZ  X19, #0xcd18, LSL #0
    MOVK  X19, #0xdecc, LSL #16
    MOVK  X19, #0xdb14, LSL #32
    MOVK  X19, #0xe906, LSL #48
    MOVZ  X20, #0xbf47, LSL #0
    MOVK  X20, #0xffa1, LSL #16
    MOVK  X20, #0xa820, LSL #32
    MOVK  X20, #0xd752, LSL #48
    MOVZ  X21, #0xd87a, LSL #0
    MOVK  X21, #0xbdc9, LSL #16
    MOVK  X21, #0x30e1, LSL #32
    MOVK  X21, #0x943f, LSL #48
    MOVZ  X22, #0xfc07, LSL #0
    MOVK  X22, #0xdc3c, LSL #16
    MOVK  X22, #0x56f3, LSL #32
    MOVK  X22, #0x4224, LSL #48
    MOVZ  X23, #0xc2e1, LSL #0
    MOVK  X23, #0x4015, LSL #16
    MOVK  X23, #0x382f, LSL #32
    MOVK  X23, #0x6676, LSL #48
    MOVZ  X24, #0x6715, LSL #0
    MOVK  X24, #0x8c43, LSL #16
    MOVK  X24, #0x9bd6, LSL #32
    MOVK  X24, #0xf175, LSL #48
    MOVZ  X25, #0xe31, LSL #0
    MOVK  X25, #0xd458, LSL #16
    MOVK  X25, #0x3ea1, LSL #32
    MOVK  X25, #0xe63a, LSL #48
    MOVZ  X26, #0xe1a, LSL #0
    MOVK  X26, #0xc16b, LSL #16
    MOVK  X26, #0xdf12, LSL #32
    MOVK  X26, #0xf47, LSL #48
    MOVZ  X27, #0x417d, LSL #0
    MOVK  X27, #0x9f82, LSL #16
    MOVK  X27, #0xcda1, LSL #32
    MOVK  X27, #0xc73d, LSL #48
    MOVZ  X28, #0xe8ba, LSL #0
    MOVK  X28, #0x6d8f, LSL #16
    MOVK  X28, #0x46ea, LSL #32
    MOVK  X28, #0x6783, LSL #48
    MOVZ  X29, #0xf65f, LSL #0
    MOVK  X29, #0x1342, LSL #16
    MOVK  X29, #0xc229, LSL #32
    MOVK  X29, #0x37, LSL #48
    MOVZ  X20, #0xfa06, LSL #0
    MOVK  X20, #0x597e, LSL #16
    MOVK  X20, #0xca77, LSL #32
    MOVK  X20, #0x5d33, LSL #48
    MSR  FPCR, X20
    MRS  X10, FPCR
    MOVZ  X2, #0x60ff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X10, X10, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X10, X10, X2
    MSR  FPCR, X10
    ISB  SY
    MOVZ  X20, #0x9ce1, LSL #0
    MOVK  X20, #0xb102, LSL #16
    MOVK  X20, #0x2a88, LSL #32
    MOVK  X20, #0x7a2b, LSL #48
    MSR  FPSR, X20
    MRS  X21, FPSR
    MOVZ  X22, #0xff60, LSL #0
    MOVK  X22, #0x7ff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    AND  X21, X21, X22
    MOVZ  X22, #0x0, LSL #0
    ORR  X21, X21, X22
    MSR  FPSR, X21
    ISB  SY
    ADDS  W29, W4, #0x2ba, LSL #12
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xfe41, LSL #0
    MOVK  X2, #0xe9b7, LSL #16
    MOVK  X2, #0x33a5, LSL #32
    MOVK  X2, #0xe159, LSL #48
    MOVZ  X3, #0x464b, LSL #0
    MOVK  X3, #0x49b7, LSL #16
    MOVK  X3, #0x8584, LSL #32
    MOVK  X3, #0xbaf1, LSL #48
    MOVZ  X4, #0xa3ca, LSL #0
    MOVK  X4, #0x43e7, LSL #16
    MOVK  X4, #0x4b92, LSL #32
    MOVK  X4, #0x5ddd, LSL #48
    MOVZ  X5, #0xd45b, LSL #0
    MOVK  X5, #0xccad, LSL #16
    MOVK  X5, #0xefab, LSL #32
    MOVK  X5, #0x1dd9, LSL #48
    MOVZ  X6, #0xb84, LSL #0
    MOVK  X6, #0xa288, LSL #16
    MOVK  X6, #0xfb54, LSL #32
    MOVK  X6, #0x738e, LSL #48
    MOVZ  X7, #0xbaf8, LSL #0
    MOVK  X7, #0x785a, LSL #16
    MOVK  X7, #0xab88, LSL #32
    MOVK  X7, #0xec36, LSL #48
    MOVZ  X8, #0xdaeb, LSL #0
    MOVK  X8, #0x3161, LSL #16
    MOVK  X8, #0x3d3f, LSL #32
    MOVK  X8, #0x940e, LSL #48
    MOVZ  X10, #0x2996, LSL #0
    MOVK  X10, #0x8ccc, LSL #16
    MOVK  X10, #0x94db, LSL #32
    MOVK  X10, #0x717c, LSL #48
    MOVZ  X12, #0x3c29, LSL #0
    MOVK  X12, #0x2ab0, LSL #16
    MOVK  X12, #0x69b1, LSL #32
    MOVK  X12, #0x28d, LSL #48
    MOVZ  X16, #0x80df, LSL #0
    MOVK  X16, #0xa2b, LSL #16
    MOVK  X16, #0xe2fd, LSL #32
    MOVK  X16, #0x1cc9, LSL #48
    MOVZ  X17, #0x5b10, LSL #0
    MOVK  X17, #0x2269, LSL #16
    MOVK  X17, #0xfdc9, LSL #32
    MOVK  X17, #0xd29d, LSL #48
    MOVZ  X18, #0x1175, LSL #0
    MOVK  X18, #0x4d83, LSL #16
    MOVK  X18, #0x2723, LSL #32
    MOVK  X18, #0x2597, LSL #48
    MOVZ  X19, #0xf3ca, LSL #0
    MOVK  X19, #0x1cc9, LSL #16
    MOVK  X19, #0x94ad, LSL #32
    MOVK  X19, #0x5b9, LSL #48
    MOVZ  X20, #0xf48b, LSL #0
    MOVK  X20, #0x70fc, LSL #16
    MOVK  X20, #0x71fb, LSL #32
    MOVK  X20, #0xdaf6, LSL #48
    MOVZ  X21, #0xb3fb, LSL #0
    MOVK  X21, #0x1282, LSL #16
    MOVK  X21, #0x9317, LSL #32
    MOVK  X21, #0x8287, LSL #48
    MOVZ  X22, #0xea73, LSL #0
    MOVK  X22, #0xdae7, LSL #16
    MOVK  X22, #0xa752, LSL #32
    MOVK  X22, #0x45f6, LSL #48
    MOVZ  X23, #0x3374, LSL #0
    MOVK  X23, #0x9350, LSL #16
    MOVK  X23, #0x60d, LSL #32
    MOVK  X23, #0x56d3, LSL #48
    MOVZ  X24, #0xa8a4, LSL #0
    MOVK  X24, #0x8618, LSL #16
    MOVK  X24, #0x81e4, LSL #32
    MOVK  X24, #0x7299, LSL #48
    MOVZ  X25, #0x24d3, LSL #0
    MOVK  X25, #0x51c7, LSL #16
    MOVK  X25, #0xf985, LSL #32
    MOVK  X25, #0xe93c, LSL #48
    MOVZ  X26, #0x38ef, LSL #0
    MOVK  X26, #0x1a56, LSL #16
    MOVK  X26, #0xec4a, LSL #32
    MOVK  X26, #0x88ca, LSL #48
    MOVZ  X27, #0xded7, LSL #0
    MOVK  X27, #0xe6be, LSL #16
    MOVK  X27, #0xd853, LSL #32
    MOVK  X27, #0x162, LSL #48
    MOVZ  X28, #0x447d, LSL #0
    MOVK  X28, #0xbe67, LSL #16
    MOVK  X28, #0xcbde, LSL #32
    MOVK  X28, #0x3f25, LSL #48
    MOVZ  X29, #0x447d, LSL #0
    MOVK  X29, #0x4eee, LSL #16
    MOVK  X29, #0xb22a, LSL #32
    MOVK  X29, #0x400e, LSL #48
    FMOV  D0, X19
    FMOV  V0.D[1], X27
    FMOV  D1, X3
    FMOV  V1.D[1], X28
    FMOV  D2, X3
    FMOV  V2.D[1], X18
    FMOV  D3, X6
    FMOV  V3.D[1], X29
    FMOV  D4, X27
    FMOV  V4.D[1], X28
    FMOV  D5, X26
    FMOV  V5.D[1], X5
    FMOV  D6, X19
    FMOV  V6.D[1], X8
    FMOV  D7, X29
    FMOV  V7.D[1], X7
    FMOV  D8, X12
    FMOV  V8.D[1], X23
    FMOV  D9, X4
    FMOV  V9.D[1], X5
    FMOV  D10, X8
    FMOV  V10.D[1], X26
    FMOV  D11, X26
    FMOV  V11.D[1], X24
    FMOV  D12, X18
    FMOV  V12.D[1], X25
    FMOV  D13, X26
    FMOV  V13.D[1], X29
    FMOV  D14, X7
    FMOV  V14.D[1], X17
    FMOV  D15, X29
    FMOV  V15.D[1], X6
    FMOV  D16, X22
    FMOV  V16.D[1], X17
    FMOV  D17, X22
    FMOV  V17.D[1], X2
    FMOV  D18, X12
    FMOV  V18.D[1], X16
    FMOV  D19, X17
    FMOV  V19.D[1], X20
    FMOV  D20, X20
    FMOV  V20.D[1], X23
    FMOV  D21, X6
    FMOV  V21.D[1], X24
    FMOV  D22, X16
    FMOV  V22.D[1], X7
    FMOV  D23, X17
    FMOV  V23.D[1], X5
    FMOV  D24, X8
    FMOV  V24.D[1], X4
    FMOV  D25, X28
    FMOV  V25.D[1], X24
    FMOV  D26, X3
    FMOV  V26.D[1], X17
    FMOV  D27, X3
    FMOV  V27.D[1], X5
    FMOV  D28, X6
    FMOV  V28.D[1], X16
    FMOV  D29, X16
    FMOV  V29.D[1], X29
    FMOV  D30, X24
    FMOV  V30.D[1], X22
    FMOV  D31, X5
    FMOV  V31.D[1], X28
    SQRDMLAH V19.8H, V24.8H, V4.H[0x1]
    SQRDMLAH V3.8H, V1.8H, V1.H[0x4]
    SQRDMLAH V28.8H, V17.8H, V10.H[0x6]
    SQRDMLAH V27.8H, V19.8H, V7.H[0x0]
    SQRDMLAH V6.8H, V31.8H, V3.H[0x6]
    SQRDMLAH V13.8H, V11.8H, V9.H[0x0]
    SQRDMLAH V22.4H, V25.4H, V11.H[0x3]
    SQRDMLAH V9.8H, V29.8H, V6.H[0x7]
    SQRDMLAH V1.8H, V28.8H, V9.H[0x3]
    SQRDMLAH V25.8H, V22.8H, V13.H[0x2]
    SQRDMLAH V24.4S, V26.4S, V10.S[0x1]
    SQRDMLAH V11.2S, V28.2S, V30.S[0x2]
    SQRDMLAH V1.2S, V24.2S, V12.S[0x0]
    SQRDMLAH V17.2S, V11.2S, V16.S[0x1]
    SQRDMLAH V11.2S, V30.2S, V17.S[0x2]
    SQRDMLAH V12.4S, V18.4S, V27.S[0x1]
    SQRDMLAH V16.4S, V1.4S, V23.S[0x0]
    SQRDMLAH V3.2S, V12.2S, V25.S[0x3]
    SQRDMLAH V26.2S, V11.2S, V16.S[0x2]
    SQRDMLAH V3.2S, V15.2S, V21.S[0x2]
    SQRDMLAH V6.4S, V17.4S, V20.4S
    SQRDMLAH V28.2S, V19.2S, V0.2S
    SQRDMLAH V9.4H, V18.4H, V11.4H
    SQRDMLAH V18.2S, V23.2S, V2.2S
    SQRDMLAH V23.4H, V6.4H, V16.4H
    SQRDMLAH V17.8H, V4.8H, V0.8H
    SQRDMLAH V25.2S, V9.2S, V4.2S
    SQRDMLAH V7.4S, V23.4S, V30.4S
    SQRDMLAH V10.4S, V4.4S, V9.4S
    SQRDMLAH V27.2S, V1.2S, V13.2S
    SQRDMLSH V1.8H, V17.8H, V15.H[0x2]
    SQRDMLSH V13.4H, V28.4H, V1.H[0x4]
    SQRDMLSH V22.4H, V27.4H, V9.H[0x5]
    SQRDMLSH V19.4H, V14.4H, V14.H[0x5]
    SQRDMLSH V9.8H, V18.8H, V9.H[0x7]
    SQRDMLSH V2.4H, V10.4H, V6.H[0x2]
    SQRDMLSH V20.4H, V26.4H, V3.H[0x7]
    SQRDMLSH V23.4H, V2.4H, V13.H[0x4]
    SQRDMLSH V10.8H, V7.8H, V9.H[0x6]
    SQRDMLSH V26.4H, V4.4H, V10.H[0x5]
    SQRDMLSH V6.4S, V20.4S, V9.S[0x3]
    SQRDMLSH V15.2S, V25.2S, V19.S[0x3]
    SQRDMLSH V0.2S, V6.2S, V22.S[0x2]
    SQRDMLSH V27.2S, V0.2S, V26.S[0x0]
    SQRDMLSH V3.2S, V2.2S, V14.S[0x0]
    SQRDMLSH V6.4S, V12.4S, V15.S[0x3]
    SQRDMLSH V12.4S, V23.4S, V5.S[0x3]
    SQRDMLSH V10.2S, V29.2S, V15.S[0x3]
    SQRDMLSH V0.4S, V6.4S, V27.S[0x1]
    SQRDMLSH V2.2S, V14.2S, V2.S[0x2]
    SQRDMLSH V11.4S, V10.4S, V12.4S
    SQRDMLSH V13.4H, V26.4H, V11.4H
    SQRDMLSH V1.4S, V13.4S, V0.4S
    SQRDMLSH V6.2S, V2.2S, V20.2S
    SQRDMLSH V23.2S, V6.2S, V6.2S
    SQRDMLSH V26.2S, V1.2S, V4.2S
    SQRDMLSH V18.4S, V7.4S, V24.4S
    SQRDMLSH V11.2S, V23.2S, V26.2S
    SQRDMLSH V27.4S, V18.4S, V18.4S
    SQRDMLSH V5.4H, V11.4H, V3.4H
    BFMMLA V17.4S, V15.8H, V9.8H
    BFMMLA V6.4S, V30.8H, V3.8H
    BFMMLA V2.4S, V20.8H, V25.8H
    BFMMLA V11.4S, V7.8H, V1.8H
    BFMMLA V7.4S, V20.8H, V21.8H
    BFMMLA V25.4S, V29.8H, V18.8H
    BFMMLA V13.4S, V13.8H, V14.8H
    BFMMLA V4.4S, V13.8H, V25.8H
    BFMMLA V30.4S, V27.8H, V27.8H
    BFMMLA V0.4S, V4.8H, V5.8H
    BFCVTN V26.4H, V8.4S
    BFCVTN V10.4H, V0.4S
    BFCVTN V21.4H, V10.4S
    BFCVTN V13.4H, V21.4S
    BFCVTN V9.4H, V6.4S
    BFCVTN V1.4H, V17.4S
    BFCVTN V10.4H, V9.4S
    BFCVTN V24.4H, V6.4S
    BFCVTN V21.4H, V25.4S
    BFCVTN V17.4H, V2.4S
    BFCVTN2 V0.8H, V24.4S
    BFCVTN2 V2.8H, V27.4S
    BFCVTN2 V5.8H, V19.4S
    BFCVTN2 V8.8H, V26.4S
    BFCVTN2 V23.8H, V7.4S
    BFCVTN2 V26.8H, V11.4S
    BFCVTN2 V7.8H, V26.4S
    BFCVTN2 V30.8H, V4.4S
    BFCVTN2 V11.8H, V10.4S
    BFCVTN2 V25.8H, V20.4S
    BFDOT V3.4S, V0.8H, V6.2H[0x1]
    BFDOT V10.4S, V15.8H, V29.2H[0x3]
    BFDOT V16.4S, V5.8H, V18.2H[0x3]
    BFDOT V24.4S, V10.8H, V21.2H[0x2]
    BFDOT V5.4S, V3.8H, V2.2H[0x0]
    BFDOT V10.4S, V13.8H, V16.2H[0x0]
    BFDOT V4.4S, V24.8H, V24.2H[0x0]
    BFDOT V9.4S, V10.8H, V2.2H[0x3]
    BFDOT V15.4S, V9.8H, V7.2H[0x2]
    BFDOT V24.4S, V8.8H, V6.2H[0x0]
    BFDOT V27.4S, V1.8H, V23.8H
    BFDOT V13.4S, V27.8H, V18.8H
    BFDOT V26.4S, V24.8H, V23.8H
    BFDOT V0.4S, V4.8H, V15.8H
    BFDOT V8.4S, V27.8H, V30.8H
    BFDOT V31.4S, V8.8H, V11.8H
    BFDOT V11.4S, V13.8H, V0.8H
    BFDOT V20.4S, V11.8H, V24.8H
    BFDOT V15.4S, V9.8H, V5.8H
    BFDOT V22.4S, V20.8H, V0.8H
    BFDOT V13.2S, V31.4H, V26.2H[0x0]
    BFDOT V7.2S, V27.4H, V2.2H[0x1]
    BFDOT V0.2S, V12.4H, V7.2H[0x1]
    BFDOT V8.2S, V13.4H, V25.2H[0x2]
    BFDOT V29.2S, V22.4H, V15.2H[0x2]
    BFDOT V31.2S, V0.4H, V6.2H[0x0]
    BFDOT V16.2S, V9.4H, V27.2H[0x0]
    BFDOT V5.2S, V16.4H, V16.2H[0x3]
    BFDOT V0.2S, V31.4H, V31.2H[0x0]
    BFDOT V31.2S, V29.4H, V5.2H[0x3]
    BFDOT V23.2S, V10.4H, V30.4H
    BFDOT V1.2S, V8.4H, V8.4H
    BFDOT V8.2S, V31.4H, V1.4H
    BFDOT V4.2S, V8.4H, V0.4H
    BFDOT V30.2S, V24.4H, V4.4H
    BFDOT V4.2S, V29.4H, V13.4H
    BFDOT V9.2S, V19.4H, V21.4H
    BFDOT V0.2S, V15.4H, V25.4H
    BFDOT V13.2S, V13.4H, V21.4H
    BFDOT V29.2S, V19.4H, V15.4H
    BFMLALB V12.4S, V7.8H, V7.H[0x4]
    BFMLALB V21.4S, V10.8H, V2.H[0x5]
    BFMLALB V5.4S, V29.8H, V0.H[0x2]
    BFMLALB V22.4S, V4.8H, V12.H[0x0]
    BFMLALB V11.4S, V22.8H, V15.H[0x4]
    BFMLALB V12.4S, V9.8H, V11.H[0x7]
    BFMLALB V29.4S, V30.8H, V15.H[0x3]
    BFMLALB V25.4S, V12.8H, V10.H[0x0]
    BFMLALB V7.4S, V28.8H, V13.H[0x4]
    BFMLALB V9.4S, V5.8H, V5.H[0x6]
    BFMLALB V8.4S, V21.8H, V29.8H
    BFMLALB V15.4S, V25.8H, V9.8H
    BFMLALB V11.4S, V7.8H, V3.8H
    BFMLALB V22.4S, V8.8H, V2.8H
    BFMLALB V0.4S, V25.8H, V13.8H
    BFMLALB V12.4S, V22.8H, V11.8H
    BFMLALB V21.4S, V16.8H, V12.8H
    BFMLALB V4.4S, V0.8H, V21.8H
    BFMLALB V8.4S, V8.8H, V15.8H
    BFMLALB V19.4S, V4.8H, V19.8H
    BFMLALT V25.4S, V23.8H, V8.H[0x6]
    BFMLALT V15.4S, V10.8H, V7.H[0x2]
    BFMLALT V30.4S, V10.8H, V6.H[0x5]
    BFMLALT V0.4S, V27.8H, V14.H[0x3]
    BFMLALT V21.4S, V13.8H, V1.H[0x0]
    BFMLALT V14.4S, V3.8H, V15.H[0x6]
    BFMLALT V16.4S, V21.8H, V7.H[0x2]
    BFMLALT V11.4S, V29.8H, V9.H[0x0]
    BFMLALT V5.4S, V15.8H, V8.H[0x6]
    BFMLALT V3.4S, V0.8H, V10.H[0x1]
    BFMLALT V7.4S, V15.8H, V23.8H
    BFMLALT V22.4S, V4.8H, V14.8H
    BFMLALT V6.4S, V3.8H, V3.8H
    BFMLALT V21.4S, V7.8H, V19.8H
    BFMLALT V9.4S, V5.8H, V18.8H
    BFMLALT V1.4S, V21.8H, V6.8H
    BFMLALT V15.4S, V25.8H, V9.8H
    BFMLALT V13.4S, V1.8H, V24.8H
    BFMLALT V16.4S, V11.8H, V12.8H
    BFMLALT V18.4S, V16.8H, V13.8H
    SDOT V23.4S, V30.16B, V0.4B[0x1]
    SDOT V31.4S, V2.16B, V22.4B[0x3]
    SDOT V8.4S, V4.16B, V30.4B[0x1]
    SDOT V25.4S, V8.16B, V31.4B[0x3]
    SDOT V8.4S, V23.16B, V25.4B[0x1]
    SDOT V13.4S, V10.16B, V8.4B[0x1]
    SDOT V21.4S, V15.16B, V18.4B[0x1]
    SDOT V3.4S, V31.16B, V30.4B[0x1]
    SDOT V22.4S, V8.16B, V23.4B[0x3]
    SDOT V29.4S, V7.16B, V9.4B[0x0]
    SDOT V18.4S, V18.16B, V12.16B
    SDOT V27.4S, V11.16B, V15.16B
    SDOT V8.4S, V11.16B, V18.16B
    SDOT V14.4S, V11.16B, V14.16B
    SDOT V19.4S, V0.16B, V10.16B
    SDOT V29.4S, V7.16B, V19.16B
    SDOT V11.4S, V6.16B, V21.16B
    SDOT V11.4S, V14.16B, V13.16B
    SDOT V14.4S, V18.16B, V29.16B
    SDOT V13.4S, V24.16B, V22.16B
    SDOT V18.2S, V3.8B, V14.4B[0x2]
    SDOT V10.2S, V8.8B, V8.4B[0x1]
    SDOT V12.2S, V4.8B, V13.4B[0x3]
    SDOT V28.2S, V1.8B, V27.4B[0x1]
    SDOT V21.2S, V12.8B, V18.4B[0x1]
    SDOT V23.2S, V22.8B, V16.4B[0x2]
    SDOT V3.2S, V15.8B, V17.4B[0x3]
    SDOT V17.2S, V3.8B, V10.4B[0x1]
    SDOT V1.2S, V28.8B, V11.4B[0x0]
    SDOT V3.2S, V1.8B, V16.4B[0x0]
    SDOT V30.2S, V25.8B, V23.8B
    SDOT V22.2S, V9.8B, V10.8B
    SDOT V16.2S, V5.8B, V17.8B
    SDOT V1.2S, V8.8B, V2.8B
    SDOT V20.2S, V30.8B, V1.8B
    SDOT V15.2S, V21.8B, V16.8B
    SDOT V1.2S, V11.8B, V3.8B
    SDOT V13.2S, V18.8B, V1.8B
    SDOT V5.2S, V22.8B, V22.8B
    SDOT V17.2S, V2.8B, V20.8B
    UDOT V14.4S, V15.16B, V20.4B[0x2]
    UDOT V8.4S, V5.16B, V5.4B[0x0]
    UDOT V19.4S, V11.16B, V17.4B[0x0]
    UDOT V28.4S, V17.16B, V8.4B[0x1]
    UDOT V5.4S, V19.16B, V28.4B[0x1]
    UDOT V22.4S, V5.16B, V23.4B[0x3]
    UDOT V28.4S, V4.16B, V14.4B[0x1]
    UDOT V17.4S, V13.16B, V25.4B[0x2]
    UDOT V1.4S, V18.16B, V22.4B[0x2]
    UDOT V8.4S, V28.16B, V28.4B[0x1]
    UDOT V3.4S, V1.16B, V12.16B
    UDOT V15.4S, V3.16B, V17.16B
    UDOT V5.4S, V25.16B, V16.16B
    UDOT V23.4S, V14.16B, V20.16B
    UDOT V4.4S, V1.16B, V29.16B
    UDOT V13.4S, V6.16B, V16.16B
    UDOT V14.4S, V4.16B, V4.16B
    UDOT V30.4S, V0.16B, V16.16B
    UDOT V22.4S, V29.16B, V3.16B
    UDOT V10.4S, V14.16B, V8.16B
    UDOT V8.2S, V30.8B, V24.4B[0x3]
    UDOT V19.2S, V4.8B, V21.4B[0x1]
    UDOT V21.2S, V7.8B, V26.4B[0x2]
    UDOT V14.2S, V21.8B, V13.4B[0x3]
    UDOT V25.2S, V14.8B, V23.4B[0x2]
    UDOT V29.2S, V19.8B, V8.4B[0x2]
    UDOT V8.2S, V5.8B, V29.4B[0x2]
    UDOT V3.2S, V21.8B, V12.4B[0x3]
    UDOT V6.2S, V3.8B, V28.4B[0x3]
    UDOT V4.2S, V10.8B, V22.4B[0x2]
    UDOT V30.2S, V3.8B, V27.8B
    UDOT V26.2S, V8.8B, V31.8B
    UDOT V18.2S, V25.8B, V25.8B
    UDOT V8.2S, V21.8B, V26.8B
    UDOT V19.2S, V15.8B, V30.8B
    UDOT V30.2S, V29.8B, V8.8B
    UDOT V21.2S, V23.8B, V4.8B
    UDOT V16.2S, V21.8B, V1.8B
    UDOT V31.2S, V18.8B, V18.8B
    UDOT V17.2S, V15.8B, V28.8B
    MOVZ  X29, #0xfe41, LSL #0
    MOVK  X29, #0xe9b7, LSL #16
    MOVK  X29, #0x33a5, LSL #32
    MOVK  X29, #0xe159, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x464b, LSL #0
    MOVK  X29, #0x49b7, LSL #16
    MOVK  X29, #0x8584, LSL #32
    MOVK  X29, #0xbaf1, LSL #48
    SUB  X4, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xd45b, LSL #0
    MOVK  X29, #0xccad, LSL #16
    MOVK  X29, #0xefab, LSL #32
    MOVK  X29, #0x1dd9, LSL #48
    SUB  X4, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xb84, LSL #0
    MOVK  X29, #0xa288, LSL #16
    MOVK  X29, #0xfb54, LSL #32
    MOVK  X29, #0x738e, LSL #48
    SUB  X4, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xdaeb, LSL #0
    MOVK  X29, #0x3161, LSL #16
    MOVK  X29, #0x3d3f, LSL #32
    MOVK  X29, #0x940e, LSL #48
    SUB  X4, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x2996, LSL #0
    MOVK  X29, #0x8ccc, LSL #16
    MOVK  X29, #0x94db, LSL #32
    MOVK  X29, #0x717c, LSL #48
    SUB  X4, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x3c29, LSL #0
    MOVK  X29, #0x2ab0, LSL #16
    MOVK  X29, #0x69b1, LSL #32
    MOVK  X29, #0x28d, LSL #48
    SUB  X4, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x80df, LSL #0
    MOVK  X29, #0xa2b, LSL #16
    MOVK  X29, #0xe2fd, LSL #32
    MOVK  X29, #0x1cc9, LSL #48
    SUB  X4, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x5b10, LSL #0
    MOVK  X29, #0x2269, LSL #16
    MOVK  X29, #0xfdc9, LSL #32
    MOVK  X29, #0xd29d, LSL #48
    SUB  X4, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x1175, LSL #0
    MOVK  X29, #0x4d83, LSL #16
    MOVK  X29, #0x2723, LSL #32
    MOVK  X29, #0x2597, LSL #48
    SUB  X4, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xf3ca, LSL #0
    MOVK  X29, #0x1cc9, LSL #16
    MOVK  X29, #0x94ad, LSL #32
    MOVK  X29, #0x5b9, LSL #48
    SUB  X4, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xf48b, LSL #0
    MOVK  X29, #0x70fc, LSL #16
    MOVK  X29, #0x71fb, LSL #32
    MOVK  X29, #0xdaf6, LSL #48
    SUB  X4, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xb3fb, LSL #0
    MOVK  X29, #0x1282, LSL #16
    MOVK  X29, #0x9317, LSL #32
    MOVK  X29, #0x8287, LSL #48
    SUB  X4, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xea73, LSL #0
    MOVK  X29, #0xdae7, LSL #16
    MOVK  X29, #0xa752, LSL #32
    MOVK  X29, #0x45f6, LSL #48
    SUB  X4, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x3374, LSL #0
    MOVK  X29, #0x9350, LSL #16
    MOVK  X29, #0x60d, LSL #32
    MOVK  X29, #0x56d3, LSL #48
    SUB  X4, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xa8a4, LSL #0
    MOVK  X29, #0x8618, LSL #16
    MOVK  X29, #0x81e4, LSL #32
    MOVK  X29, #0x7299, LSL #48
    SUB  X4, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x24d3, LSL #0
    MOVK  X29, #0x51c7, LSL #16
    MOVK  X29, #0xf985, LSL #32
    MOVK  X29, #0xe93c, LSL #48
    SUB  X4, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x38ef, LSL #0
    MOVK  X29, #0x1a56, LSL #16
    MOVK  X29, #0xec4a, LSL #32
    MOVK  X29, #0x88ca, LSL #48
    SUB  X4, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xded7, LSL #0
    MOVK  X29, #0xe6be, LSL #16
    MOVK  X29, #0xd853, LSL #32
    MOVK  X29, #0x162, LSL #48
    SUB  X4, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x447d, LSL #0
    MOVK  X29, #0xbe67, LSL #16
    MOVK  X29, #0xcbde, LSL #32
    MOVK  X29, #0x3f25, LSL #48
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X29, FPSR
    MOVZ  X4, #0x95, LSL #0
    MOVK  X4, #0x800, LSL #16
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7f80, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D0
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D1
    MOVZ  X4, #0x48bd, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0xbd16, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X4, #0x1e82, LSL #0
    MOVK  X4, #0xad41, LSL #16
    MOVK  X4, #0xf58e, LSL #32
    MOVK  X4, #0xfcf0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D2
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xff80, LSL #16
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D3
    MOVZ  X4, #0x8438, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0xa76c, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D4
    MOVZ  X4, #0xe51e, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x397, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X4, #0x29d9, LSL #0
    MOVK  X4, #0x32f2, LSL #32
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D5
    MOVZ  X4, #0xa3fd, LSL #0
    MOVK  X4, #0x7fc2, LSL #16
    MOVK  X4, #0x97d8, LSL #32
    MOVK  X4, #0x7fc2, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D6
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D7
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D8
    MOVZ  X4, #0xa042, LSL #0
    MOVK  X4, #0x7fc5, LSL #16
    MOVK  X4, #0x4b21, LSL #32
    MOVK  X4, #0x7fc5, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D9
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X4, #0x4331, LSL #0
    MOVK  X4, #0x2ff0, LSL #32
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D10
    MOVZ  X4, #0x6bf7, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0x2311, LSL #32
    MOVK  X4, #0x409f, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X4, #0x459f, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x50ef, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D11
    MOVZ  X4, #0xb664, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x9fa1, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D12
    MOVZ  X4, #0x4f01, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x4f01, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D13
    MOVZ  X4, #0xd7a7, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0x60e4, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D14
    MOVZ  X4, #0x4e62, LSL #0
    MOVK  X4, #0x7fc2, LSL #16
    MOVK  X4, #0xd7dc, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D15
    MOVZ  X4, #0xe303, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x46d, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D16
    MOVZ  X4, #0xc8ea, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0x5421, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D17
    MOVZ  X4, #0x2769, LSL #0
    MOVK  X4, #0x4, LSL #16
    MOVK  X4, #0x8ede, LSL #32
    MOVK  X4, #0x3, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D18
    MOVZ  X4, #0x654c, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0x654c, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D19
    MOVZ  X4, #0xf13a, LSL #0
    MOVK  X4, #0xf853, LSL #16
    MOVK  X4, #0xe620, LSL #32
    MOVK  X4, #0xed3e, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D20
    MOVZ  X4, #0x5883, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x69c4, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D21
    MOVZ  X4, #0xf1f5, LSL #0
    MOVK  X4, #0x7fc2, LSL #16
    MOVK  X4, #0x96f3, LSL #32
    MOVK  X4, #0x7fc2, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D22
    MOVZ  X4, #0x1e2d, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0x8c01, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D23
    MOVZ  X4, #0xab77, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0xe561, LSL #32
    MOVK  X4, #0xff81, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D24
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D25
    MOVZ  X4, #0xa2, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0xa2, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D26
    MOVZ  X4, #0xf41f, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0xd201, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X4, #0x4f01, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x4d42, LSL #32
    MOVK  X4, #0xfcf1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D27
    MOVZ  X4, #0xcd00, LSL #0
    MOVK  X4, #0xbdfc, LSL #16
    MOVK  X4, #0x9c42, LSL #32
    MOVK  X4, #0xad3b, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D28
    MOVZ  X4, #0x62da, LSL #0
    MOVK  X4, #0xadcb, LSL #16
    MOVK  X4, #0x19d8, LSL #32
    MOVK  X4, #0x67b5, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D29
    MOVZ  X4, #0x3709, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x3694, LSL #32
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D30
    MOVZ  X4, #0x81ec, LSL #0
    MOVK  X4, #0x7fc3, LSL #16
    MOVK  X4, #0xe757, LSL #32
    MOVK  X4, #0x7fc2, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D31
    MOVZ  X4, #0x2e6c, LSL #0
    MOVK  X4, #0x7fc1, LSL #16
    MOVK  X4, #0xeeb, LSL #32
    MOVK  X4, #0x7fc1, LSL #48
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X2, #0x5e7e, LSL #0
    MOVK  X2, #0x9bb1, LSL #16
    MOVK  X2, #0x22c8, LSL #32
    MOVK  X2, #0x403a, LSL #48
    MOVZ  X3, #0x6964, LSL #0
    MOVK  X3, #0xd199, LSL #16
    MOVK  X3, #0xa528, LSL #32
    MOVK  X3, #0x7d42, LSL #48
    MOVZ  X4, #0xa647, LSL #0
    MOVK  X4, #0xa5fa, LSL #16
    MOVK  X4, #0x74b6, LSL #32
    MOVK  X4, #0x571, LSL #48
    MOVZ  X5, #0xf5b6, LSL #0
    MOVK  X5, #0xddb9, LSL #16
    MOVK  X5, #0x86be, LSL #32
    MOVK  X5, #0x4e12, LSL #48
    MOVZ  X6, #0x2b52, LSL #0
    MOVK  X6, #0xa602, LSL #16
    MOVK  X6, #0x8e31, LSL #32
    MOVK  X6, #0xa045, LSL #48
    MOVZ  X7, #0x4b57, LSL #0
    MOVK  X7, #0xee20, LSL #16
    MOVK  X7, #0x56a5, LSL #32
    MOVK  X7, #0x6520, LSL #48
    MOVZ  X8, #0x64a9, LSL #0
    MOVK  X8, #0xb29e, LSL #16
    MOVK  X8, #0x8f91, LSL #32
    MOVK  X8, #0xdbda, LSL #48
    MOVZ  X10, #0xd098, LSL #0
    MOVK  X10, #0x9aa1, LSL #16
    MOVK  X10, #0xb798, LSL #32
    MOVK  X10, #0x6808, LSL #48
    MOVZ  X12, #0x6fec, LSL #0
    MOVK  X12, #0x41c, LSL #16
    MOVK  X12, #0x92d, LSL #32
    MOVK  X12, #0xc82c, LSL #48
    MOVZ  X16, #0xb76c, LSL #0
    MOVK  X16, #0xe03b, LSL #16
    MOVK  X16, #0xde9e, LSL #32
    MOVK  X16, #0x1907, LSL #48
    MOVZ  X17, #0x50e3, LSL #0
    MOVK  X17, #0x71f9, LSL #16
    MOVK  X17, #0x2b22, LSL #32
    MOVK  X17, #0x3f3a, LSL #48
    MOVZ  X18, #0x9538, LSL #0
    MOVK  X18, #0x69f6, LSL #16
    MOVK  X18, #0x49d3, LSL #32
    MOVK  X18, #0x3553, LSL #48
    MOVZ  X19, #0xd7b1, LSL #0
    MOVK  X19, #0x90b7, LSL #16
    MOVK  X19, #0xc388, LSL #32
    MOVK  X19, #0xdb5e, LSL #48
    MOVZ  X20, #0xf59b, LSL #0
    MOVK  X20, #0xd3b7, LSL #16
    MOVK  X20, #0xdc0, LSL #32
    MOVK  X20, #0x6bfd, LSL #48
    MOVZ  X21, #0xfc01, LSL #0
    MOVK  X21, #0xd578, LSL #16
    MOVK  X21, #0xfe7c, LSL #32
    MOVK  X21, #0x3d11, LSL #48
    MOVZ  X22, #0x6b30, LSL #0
    MOVK  X22, #0x339d, LSL #16
    MOVK  X22, #0x73cf, LSL #32
    MOVK  X22, #0xf8e, LSL #48
    MOVZ  X23, #0x5351, LSL #0
    MOVK  X23, #0x3138, LSL #16
    MOVK  X23, #0xb2d1, LSL #32
    MOVK  X23, #0xa149, LSL #48
    MOVZ  X24, #0x3622, LSL #0
    MOVK  X24, #0xec5b, LSL #16
    MOVK  X24, #0x961c, LSL #32
    MOVK  X24, #0xd6b4, LSL #48
    MOVZ  X25, #0xe006, LSL #0
    MOVK  X25, #0x61c, LSL #16
    MOVK  X25, #0xd2f1, LSL #32
    MOVK  X25, #0x1657, LSL #48
    MOVZ  X26, #0x7a5, LSL #0
    MOVK  X26, #0xeab0, LSL #16
    MOVK  X26, #0x2dd2, LSL #32
    MOVK  X26, #0x7bef, LSL #48
    MOVZ  X27, #0x40cf, LSL #0
    MOVK  X27, #0x773a, LSL #16
    MOVK  X27, #0xfee8, LSL #32
    MOVK  X27, #0x61c5, LSL #48
    MOVZ  X28, #0xf6, LSL #0
    MOVK  X28, #0xb61, LSL #16
    MOVK  X28, #0xf38b, LSL #32
    MOVK  X28, #0x5bfb, LSL #48
    MOVZ  X29, #0x8e67, LSL #0
    MOVK  X29, #0x99a6, LSL #16
    MOVK  X29, #0xf844, LSL #32
    MOVK  X29, #0xf2c4, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X21
    FMOV  D2, X6
    FMOV  V2.D[1], X29
    FMOV  D3, X10
    FMOV  V3.D[1], X4
    FMOV  D4, X28
    FMOV  V4.D[1], X3
    FMOV  D5, X18
    FMOV  V5.D[1], X7
    FMOV  D6, X3
    FMOV  V6.D[1], X19
    FMOV  D7, X17
    FMOV  V7.D[1], X4
    FMOV  D8, X20
    FMOV  V8.D[1], X24
    FMOV  D9, X25
    FMOV  V9.D[1], X28
    FMOV  D10, X24
    FMOV  V10.D[1], X3
    FMOV  D11, X23
    FMOV  V11.D[1], X20
    FMOV  D12, X16
    FMOV  V12.D[1], X27
    FMOV  D13, X29
    FMOV  V13.D[1], X3
    FMOV  D14, X6
    FMOV  V14.D[1], X18
    FMOV  D15, X19
    FMOV  V15.D[1], X18
    FMOV  D16, X29
    FMOV  V16.D[1], X2
    FMOV  D17, X21
    FMOV  V17.D[1], X7
    FMOV  D18, X17
    FMOV  V18.D[1], X29
    FMOV  D19, X4
    FMOV  V19.D[1], X6
    FMOV  D20, X27
    FMOV  V20.D[1], X10
    FMOV  D21, X17
    FMOV  V21.D[1], X16
    FMOV  D22, X10
    FMOV  V22.D[1], X29
    FMOV  D23, X18
    FMOV  V23.D[1], X29
    FMOV  D24, X4
    FMOV  V24.D[1], X3
    FMOV  D25, X28
    FMOV  V25.D[1], X22
    FMOV  D26, X5
    FMOV  V26.D[1], X20
    FMOV  D27, X18
    FMOV  V27.D[1], X7
    FMOV  D28, X26
    FMOV  V28.D[1], X24
    FMOV  D29, X24
    FMOV  V29.D[1], X26
    FMOV  D30, X17
    FMOV  V30.D[1], X16
    FMOV  D31, X25
    FMOV  V31.D[1], X16
    MOVZ  X17, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_0:
    SDOT V2.4S, V29.16B, V22.4B[0x0]
    SQRDMLAH V10.8H, V26.8H, V28.8H
    BFCVTN V1.4H, V21.4S
    SQRDMLSH V17.4S, V27.4S, V2.S[0x3]
    SDOT V12.2S, V25.8B, V20.8B
    SQRDMLSH V13.4H, V10.4H, V17.4H
    UDOT V5.2S, V1.8B, V30.8B
    UDOT V23.4S, V31.16B, V31.4B[0x2]
    SDOT V22.2S, V6.8B, V5.4B[0x2]
    SQRDMLSH V2.2S, V23.2S, V0.S[0x1]
    SDOT V31.4S, V27.16B, V22.4B[0x1]
    BFMLALB V9.4S, V2.8H, V8.H[0x1]
    BFMLALT V8.4S, V17.8H, V5.H[0x6]
    SQRDMLSH V27.8H, V15.8H, V12.H[0x4]
    UDOT V21.4S, V31.16B, V23.16B
    BFMLALB V10.4S, V21.8H, V7.8H
    SQRDMLAH V15.2S, V13.2S, V8.S[0x2]
    SDOT V12.2S, V14.8B, V15.8B
    BFCVTN V5.4H, V13.4S
    SDOT V22.4S, V12.16B, V27.4B[0x1]
    UDOT V11.4S, V9.16B, V4.4B[0x1]
    SQRDMLAH V0.8H, V10.8H, V11.H[0x3]
    BFMLALT V6.4S, V22.8H, V0.H[0x7]
    SQRDMLAH V23.2S, V27.2S, V18.2S
    SDOT V17.2S, V5.8B, V18.4B[0x1]
    UDOT V7.4S, V15.16B, V0.4B[0x0]
    UDOT V9.2S, V13.8B, V13.8B
    BFMLALT V4.4S, V25.8H, V4.H[0x4]
    SQRDMLSH V27.2S, V15.2S, V19.S[0x2]
    SQRDMLAH V28.4H, V3.4H, V3.H[0x1]
    SDOT V1.2S, V2.8B, V23.8B
    BFMLALT V2.4S, V14.8H, V13.H[0x3]
    UDOT V5.4S, V23.16B, V3.4B[0x1]
    BFDOT V14.2S, V18.4H, V31.4H
    SQRDMLAH V23.4H, V5.4H, V15.H[0x6]
    BFDOT V9.2S, V15.4H, V3.4H
    BFMLALB V13.4S, V29.8H, V9.H[0x7]
    SDOT V7.2S, V1.8B, V4.4B[0x2]
    BFMLALT V23.4S, V28.8H, V2.8H
    UDOT V8.4S, V23.16B, V7.4B[0x3]
    SQRDMLSH V10.4H, V6.4H, V6.H[0x0]
    BFMLALT V23.4S, V8.8H, V8.8H
    SQRDMLSH V9.4S, V10.4S, V23.S[0x0]
    SQRDMLSH V8.8H, V17.8H, V24.8H
    SQRDMLSH V24.4H, V8.4H, V1.4H
    UDOT V25.2S, V24.8B, V14.4B[0x1]
    BFDOT V24.4S, V2.8H, V21.2H[0x2]
    SQRDMLAH V14.8H, V29.8H, V13.H[0x2]
    BFDOT V28.4S, V14.8H, V24.2H[0x0]
    UDOT V6.2S, V25.8B, V27.4B[0x2]
    UDOT V11.2S, V9.8B, V6.4B[0x3]
    BFDOT V12.2S, V12.4H, V24.4H
    BFMLALB V29.4S, V10.8H, V11.8H
    SQRDMLSH V24.2S, V9.2S, V10.S[0x1]
    BFMMLA V28.4S, V14.8H, V8.8H
    SDOT V7.2S, V14.8B, V28.8B
    SQRDMLSH V4.2S, V20.2S, V20.2S
    SQRDMLSH V9.4H, V19.4H, V15.H[0x5]
    BFDOT V20.2S, V28.4H, V14.4H
    BFDOT V8.4S, V21.8H, V13.8H
    SDOT V1.4S, V25.16B, V6.4B[0x0]
    SQRDMLSH V10.2S, V29.2S, V1.S[0x3]
    SDOT V2.2S, V21.8B, V16.8B
    SQRDMLAH V23.2S, V11.2S, V7.S[0x3]
    SQRDMLSH V19.4H, V23.4H, V12.H[0x0]
    BFCVTN2 V15.8H, V19.4S
    SQRDMLSH V3.8H, V20.8H, V0.H[0x0]
    UDOT V6.2S, V4.8B, V19.8B
    UDOT V27.2S, V9.8B, V6.4B[0x3]
    BFDOT V0.4S, V15.8H, V27.8H
    BFDOT V25.2S, V5.4H, V3.4H
    SQRDMLAH V18.8H, V0.8H, V2.H[0x3]
    SQRDMLSH V2.4S, V10.4S, V25.S[0x0]
    SDOT V25.2S, V17.8B, V24.4B[0x3]
    SQRDMLAH V26.8H, V21.8H, V2.H[0x6]
    SDOT V27.4S, V26.16B, V26.16B
    BFCVTN V29.4H, V18.4S
    BFMLALT V17.4S, V16.8H, V24.8H
    UDOT V4.2S, V29.8B, V25.4B[0x3]
    UDOT V9.4S, V14.16B, V4.16B
    SQRDMLAH V19.4S, V27.4S, V9.S[0x3]
    SQRDMLAH V16.8H, V19.8H, V13.H[0x7]
    SDOT V19.2S, V16.8B, V27.4B[0x2]
    UDOT V13.2S, V17.8B, V17.4B[0x1]
    BFMMLA V7.4S, V19.8H, V19.8H
    SQRDMLSH V19.8H, V13.8H, V0.H[0x4]
    SDOT V4.4S, V29.16B, V19.16B
    BFMLALB V29.4S, V1.8H, V15.H[0x6]
    BFMLALT V27.4S, V7.8H, V15.H[0x7]
    UDOT V19.4S, V27.16B, V8.16B
    UDOT V0.4S, V18.16B, V19.4B[0x1]
    UDOT V12.2S, V19.8B, V29.8B
    UDOT V14.4S, V4.16B, V2.16B
    UDOT V27.4S, V24.16B, V18.16B
    BFMLALT V21.4S, V25.8H, V0.8H
    SDOT V25.4S, V29.16B, V14.4B[0x1]
    BFCVTN2 V2.8H, V11.4S
    SDOT V17.4S, V0.16B, V2.16B
    BFDOT V1.2S, V17.4H, V28.2H[0x1]
    BFDOT V29.2S, V16.4H, V6.4H
    SQRDMLSH V10.4S, V25.4S, V10.S[0x3]
    BFDOT V15.4S, V21.8H, V21.2H[0x3]
    SDOT V24.2S, V29.8B, V10.8B
    SQRDMLSH V18.8H, V1.8H, V27.8H
    BFDOT V18.2S, V12.4H, V27.4H
    BFCVTN V12.4H, V24.4S
    SQRDMLSH V6.4S, V2.4S, V18.S[0x0]
    SQRDMLSH V19.4S, V13.4S, V25.S[0x0]
    BFDOT V11.2S, V12.4H, V14.4H
    BFDOT V10.2S, V15.4H, V17.4H
    SQRDMLSH V7.4H, V11.4H, V5.H[0x0]
    SQRDMLSH V29.2S, V19.2S, V8.2S
    SDOT V19.4S, V29.16B, V12.16B
    BFMLALT V27.4S, V19.8H, V19.8H
    BFMMLA V17.4S, V27.8H, V10.8H
    UDOT V18.4S, V17.16B, V6.4B[0x2]
    SDOT V0.4S, V1.16B, V10.16B
    BFDOT V11.2S, V11.4H, V5.2H[0x2]
    SDOT V13.2S, V26.8B, V30.4B[0x3]
    SDOT V21.4S, V2.16B, V1.16B
    SQRDMLAH V29.2S, V12.2S, V10.S[0x0]
    SQRDMLAH V16.4H, V30.4H, V8.H[0x1]
    BFDOT V8.2S, V4.4H, V11.2H[0x0]
    SDOT V17.2S, V26.8B, V31.8B
    UDOT V26.4S, V8.16B, V18.4B[0x3]
    UDOT V29.2S, V3.8B, V17.4B[0x0]
    UDOT V4.4S, V0.16B, V7.4B[0x3]
    UDOT V15.2S, V21.8B, V16.8B
    SQRDMLSH V11.8H, V26.8H, V4.H[0x5]
    BFDOT V30.4S, V27.8H, V30.2H[0x1]
    UDOT V8.2S, V5.8B, V27.4B[0x3]
    SQRDMLAH V11.8H, V8.8H, V8.H[0x1]
    SQRDMLAH V17.2S, V15.2S, V9.2S
    SQRDMLAH V16.8H, V29.8H, V12.H[0x2]
    SQRDMLAH V7.8H, V11.8H, V13.8H
    BFCVTN V2.4H, V12.4S
    BFMLALT V18.4S, V25.8H, V2.8H
    UDOT V30.2S, V10.8B, V7.4B[0x0]
    UDOT V26.2S, V12.8B, V23.4B[0x0]
    BFDOT V19.2S, V16.4H, V30.4H
    SQRDMLAH V21.2S, V19.2S, V19.2S
    SQRDMLAH V15.2S, V26.2S, V27.S[0x2]
    SDOT V7.2S, V6.8B, V17.8B
    BFMLALT V5.4S, V18.8H, V13.H[0x1]
    BFMLALB V29.4S, V5.8H, V15.H[0x5]
    SQRDMLSH V12.2S, V30.2S, V7.S[0x2]
    BFDOT V23.4S, V12.8H, V6.8H
    SDOT V9.4S, V24.16B, V21.4B[0x3]
    SDOT V5.4S, V23.16B, V19.4B[0x0]
    UDOT V25.2S, V5.8B, V18.8B
    SQRDMLSH V12.2S, V25.2S, V9.S[0x1]
    BFDOT V2.4S, V18.8H, V25.2H[0x3]
    UDOT V7.4S, V14.16B, V30.4B[0x1]
    SDOT V19.2S, V6.8B, V1.8B
    BFMMLA V6.4S, V21.8H, V0.8H
    BFDOT V23.2S, V1.4H, V28.4H
    SQRDMLSH V20.4H, V0.4H, V13.H[0x5]
    BFMLALB V9.4S, V4.8H, V6.H[0x5]
    UDOT V25.4S, V25.16B, V14.16B
    BFMMLA V6.4S, V29.8H, V2.8H
    UDOT V14.4S, V9.16B, V25.16B
    SQRDMLSH V11.2S, V15.2S, V4.2S
    SDOT V4.2S, V11.8B, V11.4B[0x3]
    BFDOT V29.4S, V20.8H, V20.8H
    UDOT V11.4S, V29.16B, V22.4B[0x1]
    BFMMLA V1.4S, V28.8H, V20.8H
    UDOT V30.2S, V10.8B, V14.4B[0x3]
    UDOT V21.4S, V1.16B, V11.4B[0x0]
    SQRDMLSH V11.8H, V4.8H, V7.H[0x1]
    SDOT V2.4S, V11.16B, V30.4B[0x1]
    SDOT V10.2S, V19.8B, V2.4B[0x1]
    BFCVTN V24.4H, V21.4S
    BFMLALT V29.4S, V2.8H, V10.8H
    BFMLALB V8.4S, V23.8H, V6.8H
    BFCVTN V4.4H, V0.4S
    BFMLALT V22.4S, V15.8H, V28.8H
    SDOT V28.4S, V29.16B, V13.4B[0x0]
    SDOT V18.4S, V22.16B, V4.16B
    SQRDMLSH V14.8H, V8.8H, V8.H[0x3]
    BFDOT V5.4S, V9.8H, V11.2H[0x1]
    BFMMLA V20.4S, V11.8H, V5.8H
    UDOT V28.4S, V28.16B, V17.16B
    BFMMLA V8.4S, V20.8H, V3.8H
    UDOT V19.4S, V14.16B, V18.4B[0x1]
    UDOT V30.2S, V4.8B, V8.8B
    BFDOT V30.4S, V30.8H, V24.8H
    BFMLALB V0.4S, V19.8H, V8.H[0x5]
    SDOT V29.4S, V28.16B, V13.4B[0x3]
    UDOT V15.2S, V2.8B, V12.4B[0x1]
    SDOT V4.2S, V29.8B, V0.4B[0x1]
    SQRDMLAH V21.4S, V15.4S, V17.4S
    BFMLALT V1.4S, V30.8H, V12.H[0x3]
    SDOT V11.4S, V6.16B, V4.16B
    BFDOT V2.2S, V19.4H, V3.2H[0x0]
    SQRDMLSH V24.2S, V9.2S, V3.S[0x3]
    SQRDMLAH V14.4H, V1.4H, V1.H[0x2]
    BFCVTN V15.4H, V17.4S
    SQRDMLSH V19.4H, V14.4H, V21.4H
    BFDOT V18.2S, V20.4H, V15.4H
    SQRDMLAH V22.8H, V19.8H, V4.H[0x2]
    SUBS  X17, X17, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_0
    MOVZ  X3, #0x5e7e, LSL #0
    MOVK  X3, #0x9bb1, LSL #16
    MOVK  X3, #0x22c8, LSL #32
    MOVK  X3, #0x403a, LSL #48
    SUB  X18, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa647, LSL #0
    MOVK  X3, #0xa5fa, LSL #16
    MOVK  X3, #0x74b6, LSL #32
    MOVK  X3, #0x571, LSL #48
    SUB  X18, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xf5b6, LSL #0
    MOVK  X3, #0xddb9, LSL #16
    MOVK  X3, #0x86be, LSL #32
    MOVK  X3, #0x4e12, LSL #48
    SUB  X18, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x2b52, LSL #0
    MOVK  X3, #0xa602, LSL #16
    MOVK  X3, #0x8e31, LSL #32
    MOVK  X3, #0xa045, LSL #48
    SUB  X18, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x4b57, LSL #0
    MOVK  X3, #0xee20, LSL #16
    MOVK  X3, #0x56a5, LSL #32
    MOVK  X3, #0x6520, LSL #48
    SUB  X18, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x64a9, LSL #0
    MOVK  X3, #0xb29e, LSL #16
    MOVK  X3, #0x8f91, LSL #32
    MOVK  X3, #0xdbda, LSL #48
    SUB  X18, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xd098, LSL #0
    MOVK  X3, #0x9aa1, LSL #16
    MOVK  X3, #0xb798, LSL #32
    MOVK  X3, #0x6808, LSL #48
    SUB  X18, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x6fec, LSL #0
    MOVK  X3, #0x41c, LSL #16
    MOVK  X3, #0x92d, LSL #32
    MOVK  X3, #0xc82c, LSL #48
    SUB  X18, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xb76c, LSL #0
    MOVK  X3, #0xe03b, LSL #16
    MOVK  X3, #0xde9e, LSL #32
    MOVK  X3, #0x1907, LSL #48
    SUB  X18, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xd7b1, LSL #0
    MOVK  X3, #0x90b7, LSL #16
    MOVK  X3, #0xc388, LSL #32
    MOVK  X3, #0xdb5e, LSL #48
    SUB  X18, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xf59b, LSL #0
    MOVK  X3, #0xd3b7, LSL #16
    MOVK  X3, #0xdc0, LSL #32
    MOVK  X3, #0x6bfd, LSL #48
    SUB  X18, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xfc01, LSL #0
    MOVK  X3, #0xd578, LSL #16
    MOVK  X3, #0xfe7c, LSL #32
    MOVK  X3, #0x3d11, LSL #48
    SUB  X18, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x6b30, LSL #0
    MOVK  X3, #0x339d, LSL #16
    MOVK  X3, #0x73cf, LSL #32
    MOVK  X3, #0xf8e, LSL #48
    SUB  X18, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x5351, LSL #0
    MOVK  X3, #0x3138, LSL #16
    MOVK  X3, #0xb2d1, LSL #32
    MOVK  X3, #0xa149, LSL #48
    SUB  X18, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x3622, LSL #0
    MOVK  X3, #0xec5b, LSL #16
    MOVK  X3, #0x961c, LSL #32
    MOVK  X3, #0xd6b4, LSL #48
    SUB  X18, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xe006, LSL #0
    MOVK  X3, #0x61c, LSL #16
    MOVK  X3, #0xd2f1, LSL #32
    MOVK  X3, #0x1657, LSL #48
    SUB  X18, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x7a5, LSL #0
    MOVK  X3, #0xeab0, LSL #16
    MOVK  X3, #0x2dd2, LSL #32
    MOVK  X3, #0x7bef, LSL #48
    SUB  X18, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x40cf, LSL #0
    MOVK  X3, #0x773a, LSL #16
    MOVK  X3, #0xfee8, LSL #32
    MOVK  X3, #0x61c5, LSL #48
    SUB  X18, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x8e67, LSL #0
    MOVK  X3, #0x99a6, LSL #16
    MOVK  X3, #0xf844, LSL #32
    MOVK  X3, #0xf2c4, LSL #48
    SUB  X18, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X3, FPSR
    MOVZ  X18, #0x95, LSL #0
    MOVK  X18, #0x800, LSL #16
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X18, #0xbe40, LSL #0
    MOVK  X18, #0x7fc1, LSL #16
    MOVK  X18, #0xbe40, LSL #32
    MOVK  X18, #0x7fc1, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D0
    MOVZ  X18, #0x5d81, LSL #0
    MOVK  X18, #0x7fc1, LSL #16
    MOVK  X18, #0x5d81, LSL #32
    MOVK  X18, #0x7fc1, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D1
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D2
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X18, #0xa647, LSL #0
    MOVK  X18, #0xa5fa, LSL #16
    MOVK  X18, #0x74b6, LSL #32
    MOVK  X18, #0x571, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D3
    MOVZ  X18, #0xe0b0, LSL #0
    MOVK  X18, #0x7fff, LSL #16
    MOVK  X18, #0xb798, LSL #32
    MOVK  X18, #0x7fff, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D4
    MOVZ  X18, #0xce82, LSL #0
    MOVK  X18, #0x7fc1, LSL #16
    MOVK  X18, #0xce82, LSL #32
    MOVK  X18, #0x7fc1, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D5
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D6
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D7
    MOVZ  X18, #0x5d2e, LSL #0
    MOVK  X18, #0x7514, LSL #16
    MOVK  X18, #0x692d, LSL #32
    MOVK  X18, #0x7514, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D8
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D9
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0xe323, LSL #32
    MOVK  X18, #0xffc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D10
    MOVZ  X18, #0x4bae, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x4bae, LSL #32
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D11
    MOVZ  X18, #0x4f53, LSL #0
    MOVK  X18, #0x7f95, LSL #16
    MOVK  X18, #0xcec0, LSL #32
    MOVK  X18, #0x7f84, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D12
    MOVZ  X18, #0x5b7d, LSL #0
    MOVK  X18, #0x3f, LSL #16
    MOVK  X18, #0xfdeb, LSL #32
    MOVK  X18, #0x3e, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D13
    MOVZ  X18, #0x9cab, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0x57e5, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D14
    MOVZ  X18, #0x6204, LSL #0
    MOVK  X18, #0x41, LSL #16
    MOVK  X18, #0x5d44, LSL #32
    MOVK  X18, #0x42, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D15
    MOVZ  X18, #0x7fff, LSL #0
    MOVK  X18, #0x7fc1, LSL #16
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D16
    MOVZ  X18, #0x8000, LSL #0
    MOVK  X18, #0x7fff, LSL #16
    MOVK  X18, #0x53d1, LSL #32
    MOVK  X18, #0x7fff, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D17
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x7fff, LSL #16
    MOVK  X18, #0x269d, LSL #32
    MOVK  X18, #0x7f81, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D18
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D19
    MOVZ  X18, #0x6ef, LSL #0
    MOVK  X18, #0x7fd1, LSL #16
    MOVK  X18, #0xe24f, LSL #32
    MOVK  X18, #0x7fff, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D20
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X18, #0xdb01, LSL #0
    MOVK  X18, #0xdb01, LSL #32
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D21
    MOVZ  X18, #0x80cd, LSL #0
    MOVK  X18, #0xdd9a, LSL #16
    MOVK  X18, #0x8000, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D22
    MOVZ  X18, #0xfd52, LSL #0
    MOVK  X18, #0x4e54, LSL #16
    MOVK  X18, #0x2a4f, LSL #32
    MOVK  X18, #0x4e81, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D23
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D24
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #16
    MOVK  X18, #0xaf12, LSL #32
    MOVK  X18, #0x2, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D25
    MOVZ  X18, #0x4bf7, LSL #0
    MOVK  X18, #0x7fc2, LSL #16
    MOVK  X18, #0x6f0b, LSL #32
    MOVK  X18, #0x7fc2, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D26
    MOVZ  X18, #0x3364, LSL #0
    MOVK  X18, #0xddc6, LSL #16
    MOVK  X18, #0x86be, LSL #32
    MOVK  X18, #0x4e12, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D27
    MOVZ  X18, #0x9148, LSL #0
    MOVK  X18, #0x7fc9, LSL #16
    MOVK  X18, #0xffc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D28
    MOVZ  X18, #0xba43, LSL #0
    MOVK  X18, #0x7fc2, LSL #16
    MOVK  X18, #0x3a9a, LSL #32
    MOVK  X18, #0x7fc1, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D29
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D30
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X18, #0x48fb, LSL #0
    MOVK  X18, #0xe03d, LSL #16
    MOVK  X18, #0x1518, LSL #32
    MOVK  X18, #0x1908, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D31
    MOVZ  X18, #0x7cfa, LSL #0
    MOVK  X18, #0x61f, LSL #16
    MOVK  X18, #0xfea7, LSL #32
    MOVK  X18, #0x1657, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
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
    FMOV  D0, X8
    FMOV  V0.D[1], X12
    FMOV  D1, X10
    FMOV  V1.D[1], X18
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X29
    FMOV  V4.D[1], X24
    FMOV  D5, X5
    FMOV  V5.D[1], X26
    FMOV  D6, X27
    FMOV  V6.D[1], X24
    FMOV  D7, X7
    FMOV  V7.D[1], X28
    FMOV  D8, X4
    FMOV  V8.D[1], X16
    FMOV  D9, X4
    FMOV  V9.D[1], X5
    FMOV  D10, X29
    FMOV  V10.D[1], X2
    FMOV  D11, X5
    FMOV  V11.D[1], X7
    FMOV  D12, X24
    FMOV  V12.D[1], X21
    FMOV  D13, X28
    FMOV  V13.D[1], X12
    FMOV  D14, X3
    FMOV  V14.D[1], X4
    FMOV  D15, X21
    FMOV  V15.D[1], X8
    FMOV  D16, X4
    FMOV  V16.D[1], X7
    FMOV  D17, X20
    FMOV  V17.D[1], X21
    FMOV  D18, X6
    FMOV  V18.D[1], X20
    FMOV  D19, X20
    FMOV  V19.D[1], X16
    FMOV  D20, X28
    FMOV  V20.D[1], X4
    FMOV  D21, X4
    FMOV  V21.D[1], X4
    FMOV  D22, X29
    FMOV  V22.D[1], X8
    FMOV  D23, X16
    FMOV  V23.D[1], X20
    FMOV  D24, X3
    FMOV  V24.D[1], X21
    FMOV  D25, X18
    FMOV  V25.D[1], X10
    FMOV  D26, X8
    FMOV  V26.D[1], X7
    FMOV  D27, X5
    FMOV  V27.D[1], X8
    FMOV  D28, X5
    FMOV  V28.D[1], X12
    FMOV  D29, X2
    FMOV  V29.D[1], X4
    FMOV  D30, X6
    FMOV  V30.D[1], X8
    FMOV  D31, X28
    FMOV  V31.D[1], X10
    MOVZ  X26, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_1:
    BFMLALT V29.4S, V22.8H, V7.H[0x3]
    SQRDMLAH V5.2S, V10.2S, V2.2S
    SDOT V6.4S, V23.16B, V26.4B[0x1]
    BFMLALT V5.4S, V28.8H, V13.8H
    SDOT V19.2S, V30.8B, V29.8B
    SQRDMLSH V6.2S, V25.2S, V19.2S
    UDOT V9.2S, V6.8B, V6.8B
    SQRDMLAH V30.4H, V5.4H, V11.H[0x7]
    BFMLALB V13.4S, V2.8H, V0.H[0x2]
    SQRDMLAH V11.8H, V29.8H, V15.H[0x7]
    UDOT V16.2S, V13.8B, V11.8B
    UDOT V8.4S, V31.16B, V9.4B[0x3]
    UDOT V19.4S, V26.16B, V16.16B
    SQRDMLSH V26.4H, V28.4H, V8.H[0x1]
    SQRDMLAH V0.4S, V30.4S, V26.S[0x0]
    SDOT V28.2S, V11.8B, V30.4B[0x0]
    SQRDMLAH V30.8H, V14.8H, V4.8H
    SQRDMLSH V22.2S, V27.2S, V6.S[0x0]
    SQRDMLAH V7.4S, V19.4S, V0.S[0x3]
    BFDOT V1.4S, V16.8H, V7.2H[0x1]
    SQRDMLAH V25.4H, V5.4H, V1.H[0x7]
    BFMLALT V15.4S, V24.8H, V7.8H
    SQRDMLAH V0.4H, V4.4H, V15.4H
    UDOT V8.4S, V30.16B, V31.16B
    BFDOT V24.2S, V28.4H, V25.4H
    BFDOT V9.4S, V8.8H, V24.8H
    SQRDMLAH V19.8H, V0.8H, V9.8H
    UDOT V30.2S, V9.8B, V28.4B[0x1]
    SQRDMLAH V31.4S, V16.4S, V8.S[0x2]
    BFCVTN V7.4H, V4.4S
    SQRDMLAH V3.8H, V18.8H, V6.8H
    SDOT V4.2S, V6.8B, V26.8B
    BFDOT V29.4S, V11.8H, V29.8H
    SDOT V15.2S, V27.8B, V18.4B[0x0]
    SDOT V18.2S, V30.8B, V7.8B
    SQRDMLSH V8.4H, V15.4H, V18.4H
    SQRDMLAH V9.4S, V29.4S, V22.S[0x3]
    SQRDMLSH V1.4S, V31.4S, V3.S[0x0]
    UDOT V15.4S, V16.16B, V26.4B[0x0]
    BFMLALB V1.4S, V15.8H, V14.8H
    SQRDMLSH V2.4S, V4.4S, V4.S[0x1]
    SQRDMLSH V30.4S, V7.4S, V5.4S
    SQRDMLAH V7.2S, V19.2S, V2.S[0x0]
    SDOT V2.2S, V7.8B, V30.4B[0x1]
    SDOT V18.2S, V1.8B, V8.8B
    SDOT V4.4S, V2.16B, V25.4B[0x0]
    BFDOT V5.4S, V19.8H, V18.2H[0x3]
    BFCVTN V1.4H, V5.4S
    UDOT V18.4S, V1.16B, V27.16B
    SQRDMLAH V12.8H, V4.8H, V9.H[0x6]
    UDOT V6.2S, V15.8B, V18.8B
    SQRDMLSH V11.2S, V19.2S, V8.S[0x3]
    SQRDMLAH V3.4H, V30.4H, V5.H[0x2]
    BFDOT V29.4S, V5.8H, V11.2H[0x0]
    BFDOT V2.2S, V26.4H, V23.2H[0x1]
    SQRDMLSH V19.2S, V16.2S, V14.S[0x0]
    BFCVTN V15.4H, V31.4S
    BFCVTN V5.4H, V16.4S
    SQRDMLAH V26.8H, V14.8H, V7.H[0x4]
    SDOT V5.4S, V29.16B, V3.16B
    BFMMLA V29.4S, V6.8H, V16.8H
    SDOT V23.2S, V0.8B, V14.8B
    SQRDMLAH V8.2S, V5.2S, V23.2S
    BFMLALB V1.4S, V31.8H, V11.8H
    SQRDMLAH V31.4S, V1.4S, V19.4S
    SQRDMLAH V7.4H, V8.4H, V15.H[0x3]
    SQRDMLAH V11.4H, V21.4H, V7.H[0x6]
    UDOT V2.2S, V26.8B, V11.4B[0x2]
    SDOT V25.2S, V12.8B, V12.8B
    SQRDMLSH V30.2S, V2.2S, V2.S[0x3]
    BFDOT V24.4S, V25.8H, V14.2H[0x2]
    BFMLALB V15.4S, V16.8H, V24.8H
    BFDOT V24.2S, V15.4H, V30.4H
    BFMLALT V7.4S, V24.8H, V31.8H
    SQRDMLSH V25.8H, V16.8H, V13.H[0x0]
    BFDOT V31.2S, V1.4H, V26.2H[0x0]
    UDOT V16.4S, V10.16B, V17.16B
    SQRDMLSH V14.2S, V12.2S, V29.S[0x3]
    BFDOT V17.2S, V18.4H, V23.2H[0x0]
    BFMLALB V3.4S, V20.8H, V14.8H
    BFCVTN V20.4H, V14.4S
    BFMMLA V8.4S, V28.8H, V19.8H
    SDOT V5.2S, V1.8B, V8.4B[0x0]
    SQRDMLSH V8.4S, V6.4S, V13.S[0x1]
    BFCVTN V2.4H, V8.4S
    SQRDMLSH V23.2S, V2.2S, V16.S[0x2]
    SDOT V18.2S, V15.8B, V25.8B
    BFMLALT V28.4S, V20.8H, V5.H[0x2]
    SQRDMLAH V0.2S, V31.2S, V5.S[0x2]
    UDOT V25.4S, V3.16B, V23.4B[0x0]
    UDOT V2.2S, V0.8B, V25.8B
    BFMLALT V16.4S, V28.8H, V7.H[0x2]
    BFCVTN2 V6.8H, V17.4S
    BFDOT V21.4S, V3.8H, V19.2H[0x1]
    SDOT V8.4S, V14.16B, V18.4B[0x2]
    BFMLALT V14.4S, V26.8H, V8.H[0x6]
    SDOT V0.2S, V14.8B, V16.4B[0x1]
    SDOT V11.2S, V6.8B, V6.4B[0x1]
    UDOT V18.4S, V21.16B, V13.16B
    UDOT V6.2S, V8.8B, V20.4B[0x1]
    UDOT V21.2S, V5.8B, V6.4B[0x0]
    SQRDMLSH V3.4H, V11.4H, V11.H[0x6]
    SQRDMLSH V19.4H, V0.4H, V3.4H
    UDOT V5.2S, V21.8B, V19.8B
    SQRDMLAH V8.4H, V2.4H, V2.H[0x7]
    UDOT V11.2S, V8.8B, V5.8B
    SQRDMLAH V23.4H, V0.4H, V5.H[0x6]
    SQRDMLSH V14.8H, V15.8H, V21.8H
    UDOT V2.4S, V8.16B, V3.16B
    SDOT V18.4S, V28.16B, V12.16B
    BFMLALT V15.4S, V19.8H, V0.8H
    SQRDMLAH V3.8H, V6.8H, V7.H[0x1]
    SDOT V15.2S, V11.8B, V11.4B[0x1]
    SDOT V5.4S, V19.16B, V28.4B[0x3]
    BFMLALB V28.4S, V17.8H, V15.H[0x0]
    SDOT V9.4S, V16.16B, V17.4B[0x1]
    BFMLALB V21.4S, V27.8H, V9.H[0x6]
    UDOT V27.2S, V11.8B, V15.4B[0x1]
    BFCVTN V3.4H, V27.4S
    SQRDMLSH V20.4H, V11.4H, V1.4H
    SDOT V4.2S, V18.8B, V20.4B[0x2]
    BFCVTN2 V11.8H, V20.4S
    BFMLALB V13.4S, V23.8H, V21.8H
    SQRDMLAH V8.4H, V2.4H, V13.H[0x3]
    SDOT V19.4S, V14.16B, V28.16B
    SDOT V17.2S, V31.8B, V19.8B
    SQRDMLAH V12.8H, V3.8H, V3.H[0x6]
    SDOT V27.2S, V4.8B, V27.4B[0x1]
    BFMLALT V14.4S, V7.8H, V15.8H
    BFMLALB V0.4S, V12.8H, V5.8H
    BFMLALB V16.4S, V8.8H, V1.H[0x7]
    BFCVTN2 V29.8H, V14.4S
    SQRDMLAH V25.8H, V31.8H, V0.H[0x7]
    SQRDMLSH V9.2S, V28.2S, V17.2S
    SQRDMLAH V20.4H, V11.4H, V8.H[0x5]
    BFMLALT V15.4S, V2.8H, V29.8H
    BFDOT V13.4S, V9.8H, V23.2H[0x0]
    UDOT V0.2S, V27.8B, V31.4B[0x0]
    SDOT V21.4S, V30.16B, V16.4B[0x1]
    SQRDMLSH V27.4S, V13.4S, V11.4S
    BFDOT V31.4S, V15.8H, V14.8H
    SQRDMLSH V14.4S, V31.4S, V20.S[0x3]
    SQRDMLAH V0.4H, V25.4H, V12.H[0x7]
    SDOT V31.2S, V0.8B, V27.8B
    BFDOT V20.4S, V21.8H, V6.8H
    BFDOT V2.2S, V14.4H, V14.2H[0x2]
    UDOT V9.2S, V31.8B, V31.8B
    BFMLALT V30.4S, V9.8H, V9.8H
    SQRDMLSH V23.8H, V20.8H, V14.H[0x6]
    SDOT V4.4S, V30.16B, V23.4B[0x3]
    UDOT V5.4S, V11.16B, V7.4B[0x1]
    UDOT V3.2S, V23.8B, V24.4B[0x1]
    BFMLALT V9.4S, V0.8H, V5.H[0x0]
    BFMMLA V30.4S, V22.8H, V26.8H
    UDOT V16.2S, V10.8B, V25.8B
    SQRDMLSH V20.4H, V6.4H, V13.H[0x2]
    UDOT V25.4S, V17.16B, V4.4B[0x3]
    SQRDMLSH V27.8H, V21.8H, V6.H[0x5]
    SQRDMLAH V12.4S, V22.4S, V24.4S
    BFCVTN V23.4H, V0.4S
    SQRDMLAH V17.4S, V30.4S, V20.4S
    BFDOT V24.4S, V28.8H, V9.2H[0x1]
    SQRDMLSH V13.4S, V27.4S, V16.4S
    UDOT V7.4S, V23.16B, V3.4B[0x2]
    BFDOT V31.2S, V14.4H, V2.4H
    BFDOT V21.2S, V23.4H, V19.2H[0x1]
    SDOT V2.2S, V23.8B, V13.8B
    SQRDMLSH V15.2S, V21.2S, V17.S[0x1]
    SQRDMLSH V5.8H, V31.8H, V25.8H
    BFDOT V10.4S, V5.8H, V24.2H[0x2]
    BFDOT V15.2S, V20.4H, V12.4H
    SQRDMLAH V17.8H, V7.8H, V15.8H
    SDOT V22.4S, V10.16B, V10.16B
    SQRDMLAH V25.4S, V2.4S, V17.S[0x2]
    SQRDMLSH V23.8H, V13.8H, V5.H[0x3]
    UDOT V23.4S, V2.16B, V14.16B
    BFDOT V2.4S, V5.8H, V10.2H[0x1]
    SDOT V13.4S, V4.16B, V29.16B
    BFMLALB V28.4S, V12.8H, V12.8H
    BFMLALT V14.4S, V2.8H, V8.H[0x0]
    BFMLALT V5.4S, V29.8H, V0.8H
    BFMLALT V2.4S, V19.8H, V4.8H
    UDOT V17.2S, V1.8B, V6.4B[0x3]
    SQRDMLAH V6.8H, V17.8H, V22.8H
    BFMMLA V12.4S, V5.8H, V1.8H
    SQRDMLAH V9.4S, V25.4S, V6.4S
    SQRDMLSH V21.4H, V25.4H, V13.H[0x5]
    UDOT V16.4S, V23.16B, V2.4B[0x0]
    SQRDMLSH V6.4H, V16.4H, V9.4H
    SQRDMLAH V15.8H, V28.8H, V14.H[0x3]
    SQRDMLAH V2.4S, V15.4S, V19.S[0x2]
    BFCVTN2 V16.8H, V25.4S
    BFMMLA V13.4S, V27.8H, V14.8H
    BFMMLA V25.4S, V7.8H, V21.8H
    BFMLALT V27.4S, V1.8H, V19.8H
    SQRDMLSH V26.2S, V13.2S, V0.2S
    SQRDMLSH V0.2S, V6.2S, V6.S[0x1]
    BFDOT V4.2S, V16.4H, V25.2H[0x3]
    UDOT V23.4S, V16.16B, V15.16B
    SDOT V25.2S, V0.8B, V29.8B
    SUBS  X26, X26, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_1
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X29, FPSR
    MOVZ  X24, #0x95, LSL #0
    MOVK  X24, #0x800, LSL #16
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X7
    FMOV  V1.D[1], X6
    FMOV  D2, X22
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X2
    FMOV  D4, X29
    FMOV  V4.D[1], X3
    FMOV  D5, X23
    FMOV  V5.D[1], X24
    FMOV  D6, X17
    FMOV  V6.D[1], X8
    FMOV  D7, X18
    FMOV  V7.D[1], X10
    FMOV  D8, X22
    FMOV  V8.D[1], X27
    FMOV  D9, X8
    FMOV  V9.D[1], X20
    FMOV  D10, X18
    FMOV  V10.D[1], X10
    FMOV  D11, X22
    FMOV  V11.D[1], X27
    FMOV  D12, X22
    FMOV  V12.D[1], X17
    FMOV  D13, X18
    FMOV  V13.D[1], X19
    FMOV  D14, X23
    FMOV  V14.D[1], X25
    FMOV  D15, X3
    FMOV  V15.D[1], X3
    FMOV  D16, X21
    FMOV  V16.D[1], X17
    FMOV  D17, X6
    FMOV  V17.D[1], X6
    FMOV  D18, X23
    FMOV  V18.D[1], X27
    FMOV  D19, X23
    FMOV  V19.D[1], X20
    FMOV  D20, X17
    FMOV  V20.D[1], X19
    FMOV  D21, X19
    FMOV  V21.D[1], X7
    FMOV  D22, X20
    FMOV  V22.D[1], X23
    FMOV  D23, X19
    FMOV  V23.D[1], X25
    FMOV  D24, X23
    FMOV  V24.D[1], X12
    FMOV  D25, X25
    FMOV  V25.D[1], X26
    FMOV  D26, X17
    FMOV  V26.D[1], X19
    FMOV  D27, X22
    FMOV  V27.D[1], X17
    FMOV  D28, X4
    FMOV  V28.D[1], X16
    FMOV  D29, X21
    FMOV  V29.D[1], X17
    FMOV  D30, X21
    FMOV  V30.D[1], X27
    FMOV  D31, X17
    FMOV  V31.D[1], X24
    MOVZ  X5, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_2:
    SQRDMLSH V21.4S, V30.4S, V27.4S
    BFDOT V18.2S, V7.4H, V28.2H[0x1]
    UDOT V21.4S, V4.16B, V30.4B[0x3]
    BFDOT V9.2S, V26.4H, V29.2H[0x0]
    SQRDMLSH V17.8H, V9.8H, V3.H[0x2]
    BFMLALT V15.4S, V21.8H, V1.8H
    BFDOT V16.4S, V31.8H, V18.2H[0x2]
    SDOT V29.4S, V17.16B, V16.4B[0x1]
    SQRDMLAH V9.4S, V31.4S, V29.4S
    SQRDMLAH V11.4H, V26.4H, V15.H[0x5]
    BFDOT V18.2S, V11.4H, V7.2H[0x2]
    SQRDMLSH V6.4H, V18.4H, V18.4H
    SDOT V15.2S, V6.8B, V30.4B[0x2]
    SQRDMLAH V26.4S, V25.4S, V28.S[0x0]
    SQRDMLSH V15.4H, V26.4H, V15.H[0x4]
    SDOT V20.2S, V19.8B, V25.4B[0x1]
    SDOT V29.4S, V20.16B, V15.4B[0x1]
    SQRDMLSH V28.4S, V6.4S, V19.S[0x1]
    SDOT V11.4S, V9.16B, V31.4B[0x0]
    SQRDMLAH V3.2S, V19.2S, V12.2S
    SQRDMLAH V8.4H, V31.4H, V7.H[0x0]
    BFCVTN2 V16.8H, V25.4S
    UDOT V31.4S, V26.16B, V30.4B[0x0]
    SDOT V1.2S, V3.8B, V6.8B
    SDOT V6.4S, V10.16B, V23.16B
    SDOT V25.4S, V26.16B, V14.16B
    BFDOT V19.2S, V16.4H, V25.2H[0x3]
    BFMLALT V9.4S, V31.8H, V6.H[0x5]
    SDOT V3.2S, V8.8B, V29.8B
    SQRDMLAH V17.4H, V16.4H, V11.4H
    UDOT V8.2S, V6.8B, V28.8B
    SDOT V29.2S, V21.8B, V17.4B[0x1]
    SDOT V25.2S, V21.8B, V29.8B
    SDOT V31.4S, V20.16B, V28.16B
    UDOT V21.4S, V21.16B, V5.16B
    SDOT V7.2S, V26.8B, V11.4B[0x2]
    SQRDMLAH V31.4H, V27.4H, V1.H[0x2]
    SQRDMLAH V29.4S, V31.4S, V18.S[0x3]
    UDOT V16.4S, V25.16B, V25.4B[0x0]
    SQRDMLAH V14.2S, V29.2S, V19.2S
    BFMMLA V24.4S, V14.8H, V3.8H
    SQRDMLAH V6.8H, V24.8H, V8.H[0x5]
    BFDOT V16.4S, V7.8H, V29.2H[0x1]
    UDOT V15.2S, V2.8B, V9.8B
    SDOT V19.4S, V15.16B, V21.4B[0x1]
    SQRDMLSH V20.8H, V19.8H, V12.H[0x4]
    BFDOT V26.4S, V6.8H, V6.8H
    SDOT V11.2S, V20.8B, V26.4B[0x3]
    SQRDMLAH V15.4H, V0.4H, V7.4H
    SQRDMLSH V2.8H, V15.8H, V14.H[0x3]
    UDOT V31.4S, V1.16B, V2.4B[0x2]
    BFDOT V21.4S, V23.8H, V26.8H
    BFMLALB V23.4S, V29.8H, V17.8H
    BFDOT V27.4S, V12.8H, V12.8H
    SQRDMLAH V26.4H, V9.4H, V10.H[0x0]
    SQRDMLSH V25.2S, V25.2S, V7.2S
    BFCVTN2 V1.8H, V8.4S
    BFMLALB V20.4S, V1.8H, V25.8H
    UDOT V24.4S, V10.16B, V26.16B
    BFCVTN2 V9.8H, V1.4S
    SQRDMLSH V17.8H, V22.8H, V7.8H
    SQRDMLAH V6.4H, V21.4H, V7.4H
    SQRDMLAH V19.4H, V6.4H, V21.4H
    SDOT V17.2S, V31.8B, V19.8B
    UDOT V1.2S, V20.8B, V17.8B
    SDOT V29.2S, V10.8B, V1.4B[0x1]
    BFDOT V7.4S, V23.8H, V23.2H[0x2]
    SQRDMLAH V10.4H, V21.4H, V13.H[0x4]
    BFDOT V0.2S, V28.4H, V10.4H
    SQRDMLSH V6.2S, V27.2S, V7.S[0x1]
    BFDOT V20.2S, V15.4H, V23.2H[0x0]
    BFCVTN2 V25.8H, V26.4S
    SDOT V7.2S, V0.8B, V13.4B[0x3]
    BFMLALB V29.4S, V6.8H, V1.H[0x2]
    SQRDMLSH V1.4S, V20.4S, V18.4S
    BFMLALB V6.4S, V17.8H, V11.H[0x1]
    SQRDMLAH V26.2S, V7.2S, V0.S[0x1]
    SQRDMLAH V31.2S, V24.2S, V9.S[0x0]
    SDOT V13.4S, V29.16B, V31.4B[0x0]
    BFMLALT V22.4S, V6.8H, V13.H[0x2]
    UDOT V9.4S, V25.16B, V26.4B[0x1]
    SQRDMLSH V18.8H, V9.8H, V8.H[0x5]
    SQRDMLAH V20.4H, V28.4H, V7.H[0x7]
    BFDOT V23.4S, V20.8H, V20.8H
    BFDOT V22.4S, V18.8H, V22.2H[0x1]
    UDOT V28.2S, V3.8B, V14.4B[0x3]
    UDOT V31.4S, V27.16B, V15.4B[0x3]
    BFDOT V27.2S, V28.4H, V1.2H[0x3]
    UDOT V3.2S, V31.8B, V27.8B
    BFDOT V31.2S, V16.4H, V17.2H[0x0]
    BFMLALB V25.4S, V3.8H, V3.H[0x0]
    BFDOT V18.4S, V22.8H, V23.2H[0x3]
    BFDOT V16.4S, V12.8H, V25.2H[0x3]
    SQRDMLSH V12.4S, V16.4S, V31.4S
    BFCVTN V22.4H, V17.4S
    BFMLALB V6.4S, V8.8H, V13.8H
    SQRDMLAH V30.4S, V26.4S, V0.4S
    SDOT V23.4S, V28.16B, V6.16B
    BFMLALT V16.4S, V19.8H, V0.8H
    BFCVTN V31.4H, V11.4S
    SQRDMLAH V24.2S, V26.2S, V12.S[0x1]
    BFMLALB V0.4S, V30.8H, V1.8H
    BFMLALB V15.4S, V1.8H, V2.H[0x3]
    SQRDMLAH V11.4S, V13.4S, V17.S[0x3]
    SQRDMLSH V8.2S, V22.2S, V2.2S
    SDOT V13.4S, V31.16B, V30.4B[0x3]
    BFMLALB V17.4S, V23.8H, V0.H[0x0]
    SQRDMLAH V0.4H, V9.4H, V22.4H
    BFDOT V3.4S, V16.8H, V13.8H
    BFDOT V14.2S, V15.4H, V8.2H[0x3]
    SQRDMLSH V30.2S, V17.2S, V3.S[0x2]
    UDOT V13.4S, V10.16B, V20.4B[0x3]
    SQRDMLAH V1.4H, V30.4H, V15.H[0x5]
    SDOT V3.2S, V15.8B, V11.4B[0x0]
    SDOT V30.2S, V13.8B, V0.4B[0x1]
    SQRDMLSH V27.4H, V24.4H, V14.H[0x1]
    SDOT V23.4S, V3.16B, V20.4B[0x0]
    BFMLALB V6.4S, V12.8H, V18.8H
    SQRDMLSH V9.4S, V30.4S, V6.S[0x2]
    SQRDMLSH V26.4S, V23.4S, V27.4S
    BFMLALB V29.4S, V26.8H, V7.H[0x1]
    SDOT V24.4S, V15.16B, V9.4B[0x3]
    BFMLALT V27.4S, V1.8H, V6.H[0x6]
    UDOT V3.2S, V29.8B, V26.8B
    UDOT V14.4S, V3.16B, V27.4B[0x0]
    BFCVTN2 V31.8H, V23.4S
    SQRDMLSH V6.4H, V22.4H, V8.H[0x4]
    UDOT V16.2S, V1.8B, V28.4B[0x3]
    SQRDMLSH V13.2S, V13.2S, V11.S[0x1]
    BFMMLA V1.4S, V21.8H, V9.8H
    SQRDMLSH V16.2S, V18.2S, V3.S[0x1]
    SQRDMLSH V0.4H, V19.4H, V4.H[0x2]
    UDOT V25.4S, V15.16B, V30.16B
    BFDOT V23.2S, V27.4H, V16.4H
    BFDOT V26.2S, V6.4H, V0.2H[0x1]
    BFCVTN2 V16.8H, V13.4S
    BFCVTN V11.4H, V23.4S
    SDOT V18.4S, V11.16B, V14.16B
    UDOT V3.4S, V26.16B, V3.16B
    UDOT V6.2S, V20.8B, V18.4B[0x0]
    BFDOT V4.4S, V6.8H, V6.8H
    BFMLALT V11.4S, V15.8H, V2.H[0x7]
    SDOT V26.4S, V27.16B, V31.4B[0x2]
    SQRDMLAH V30.4S, V11.4S, V4.S[0x0]
    BFMLALT V9.4S, V30.8H, V1.H[0x1]
    UDOT V1.4S, V25.16B, V9.16B
    BFCVTN2 V15.8H, V3.4S
    SDOT V22.4S, V16.16B, V18.16B
    UDOT V28.4S, V1.16B, V22.4B[0x2]
    BFCVTN V29.4H, V15.4S
    UDOT V13.4S, V29.16B, V24.4B[0x3]
    BFDOT V15.4S, V26.8H, V4.2H[0x2]
    SQRDMLSH V20.4H, V10.4H, V12.H[0x7]
    SQRDMLAH V16.2S, V15.2S, V28.S[0x3]
    BFDOT V6.2S, V20.4H, V21.4H
    BFMLALT V3.4S, V6.8H, V27.8H
    BFMLALT V14.4S, V16.8H, V7.8H
    SDOT V2.2S, V3.8B, V31.4B[0x1]
    BFCVTN2 V18.8H, V30.4S
    SQRDMLSH V10.4S, V2.4S, V16.S[0x1]
    BFCVTN2 V16.8H, V4.4S
    SDOT V26.4S, V10.16B, V18.4B[0x0]
    SQRDMLAH V15.4S, V8.4S, V13.4S
    SDOT V18.2S, V16.8B, V22.8B
    BFMLALB V16.4S, V3.8H, V15.H[0x1]
    SQRDMLSH V22.4S, V0.4S, V16.4S
    SQRDMLAH V30.2S, V14.2S, V14.2S
    BFDOT V21.2S, V30.4H, V26.4H
    SDOT V7.2S, V9.8B, V14.4B[0x2]
    UDOT V2.4S, V21.16B, V19.16B
    SDOT V30.2S, V12.8B, V22.4B[0x0]
    SQRDMLAH V28.2S, V7.2S, V5.S[0x1]
    SQRDMLAH V15.4H, V30.4H, V13.H[0x3]
    BFMMLA V5.4S, V2.8H, V2.8H
    BFDOT V7.2S, V18.4H, V28.2H[0x1]
    BFMLALB V19.4S, V17.8H, V6.H[0x0]
    BFDOT V22.4S, V23.8H, V15.2H[0x3]
    BFDOT V30.4S, V19.8H, V19.2H[0x0]
    SQRDMLSH V18.4H, V21.4H, V5.4H
    UDOT V28.4S, V12.16B, V0.4B[0x0]
    SQRDMLAH V21.2S, V30.2S, V25.S[0x1]
    SQRDMLSH V4.4S, V21.4S, V28.S[0x3]
    BFMLALT V8.4S, V12.8H, V18.8H
    SDOT V8.2S, V0.8B, V4.8B
    UDOT V23.4S, V8.16B, V3.16B
    SQRDMLSH V5.4S, V7.4S, V23.4S
    BFDOT V14.4S, V13.8H, V28.8H
    SDOT V2.2S, V2.8B, V29.4B[0x3]
    SDOT V28.4S, V25.16B, V26.16B
    BFDOT V4.2S, V21.4H, V31.4H
    SDOT V29.2S, V15.8B, V15.4B[0x3]
    SQRDMLAH V9.2S, V30.2S, V31.S[0x0]
    SQRDMLSH V30.8H, V10.8H, V2.H[0x3]
    BFMLALB V19.4S, V23.8H, V22.8H
    SDOT V24.2S, V27.8B, V29.8B
    BFDOT V12.4S, V15.8H, V11.8H
    SQRDMLSH V7.4S, V24.4S, V28.S[0x1]
    BFMLALT V29.4S, V6.8H, V12.8H
    SQRDMLSH V0.4H, V19.4H, V4.H[0x6]
    SQRDMLAH V11.4H, V7.4H, V16.4H
    SUBS  X5, X5, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_2
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X25, FPSR
    MOVZ  X7, #0x95, LSL #0
    MOVK  X7, #0x800, LSL #16
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D0
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7959, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X7, #0x6240, LSL #0
    MOVK  X7, #0x1, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D1
    MOVZ  X7, #0x1fe, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x285d, LSL #32
    MOVK  X7, #0x7fc1, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D2
    MOVZ  X7, #0x814d, LSL #0
    MOVK  X7, #0x8001, LSL #16
    MOVK  X7, #0x4e41, LSL #32
    MOVK  X7, #0x1, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D3
    MOVZ  X7, #0x27eb, LSL #0
    MOVK  X7, #0x7fc2, LSL #16
    MOVK  X7, #0x1815, LSL #32
    MOVK  X7, #0x7fc2, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D4
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D5
    MOVZ  X7, #0x3723, LSL #0
    MOVK  X7, #0x3f, LSL #16
    MOVK  X7, #0xd38a, LSL #32
    MOVK  X7, #0x807e, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D6
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D7
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x11e8, LSL #32
    MOVK  X7, #0xffc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D8
    MOVZ  X7, #0x256d, LSL #0
    MOVK  X7, #0x8000, LSL #16
    MOVK  X7, #0x4f41, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D9
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D10
    MOVZ  X7, #0xf5c9, LSL #0
    MOVK  X7, #0x26f, LSL #16
    MOVK  X7, #0x7a13, LSL #32
    MOVK  X7, #0x1f2, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D11
    MOVZ  X7, #0x7fc0, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0xffc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D12
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D14
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D15
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X7, #0x7fc0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D16
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D17
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xe728, LSL #32
    MOVK  X7, #0x666, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D18
    MOVZ  X7, #0x64b5, LSL #0
    MOVK  X7, #0x40, LSL #16
    MOVK  X7, #0xf883, LSL #32
    MOVK  X7, #0x7fbf, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D19
    MOVZ  X7, #0x6154, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0xe6bd, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D20
    MOVZ  X7, #0xa235, LSL #0
    MOVK  X7, #0x7dcf, LSL #16
    MOVK  X7, #0x85ac, LSL #32
    MOVK  X7, #0x7dcf, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D21
    MOVZ  X7, #0xc25f, LSL #0
    MOVK  X7, #0x63c3, LSL #16
    MOVK  X7, #0xc25f, LSL #32
    MOVK  X7, #0x63c3, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D22
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D23
    MOVZ  X7, #0xa932, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0xcfc, LSL #32
    MOVK  X7, #0x7fc1, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D24
    MOVZ  X7, #0x2dae, LSL #0
    MOVK  X7, #0x8000, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D25
    MOVZ  X7, #0x8c3e, LSL #0
    MOVK  X7, #0x2, LSL #16
    MOVK  X7, #0xbd3e, LSL #32
    MOVK  X7, #0xe3f5, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D26
    MOVZ  X7, #0xe1a2, LSL #0
    MOVK  X7, #0x7fbf, LSL #16
    MOVK  X7, #0x29b8, LSL #32
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X7, #0x7ec7, LSL #0
    MOVK  X7, #0x7ec7, LSL #32
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D28
    MOVZ  X7, #0xcad, LSL #0
    MOVK  X7, #0x8000, LSL #16
    MOVK  X7, #0xee19, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D29
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D30
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fc0, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X7, #0x7fc0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X25, D31
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X16
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X18
    FMOV  V2.D[1], X26
    FMOV  D3, X29
    FMOV  V3.D[1], X20
    FMOV  D4, X29
    FMOV  V4.D[1], X8
    FMOV  D5, X16
    FMOV  V5.D[1], X28
    FMOV  D6, X23
    FMOV  V6.D[1], X25
    FMOV  D7, X2
    FMOV  V7.D[1], X22
    FMOV  D8, X16
    FMOV  V8.D[1], X20
    FMOV  D9, X25
    FMOV  V9.D[1], X24
    FMOV  D10, X28
    FMOV  V10.D[1], X19
    FMOV  D11, X26
    FMOV  V11.D[1], X8
    FMOV  D12, X22
    FMOV  V12.D[1], X19
    FMOV  D13, X19
    FMOV  V13.D[1], X4
    FMOV  D14, X17
    FMOV  V14.D[1], X10
    FMOV  D15, X8
    FMOV  V15.D[1], X22
    FMOV  D16, X21
    FMOV  V16.D[1], X18
    FMOV  D17, X21
    FMOV  V17.D[1], X19
    FMOV  D18, X24
    FMOV  V18.D[1], X29
    FMOV  D19, X20
    FMOV  V19.D[1], X12
    FMOV  D20, X21
    FMOV  V20.D[1], X28
    FMOV  D21, X21
    FMOV  V21.D[1], X12
    FMOV  D22, X18
    FMOV  V22.D[1], X6
    FMOV  D23, X8
    FMOV  V23.D[1], X21
    FMOV  D24, X21
    FMOV  V24.D[1], X4
    FMOV  D25, X21
    FMOV  V25.D[1], X24
    FMOV  D26, X5
    FMOV  V26.D[1], X17
    FMOV  D27, X27
    FMOV  V27.D[1], X28
    FMOV  D28, X2
    FMOV  V28.D[1], X18
    FMOV  D29, X20
    FMOV  V29.D[1], X24
    FMOV  D30, X19
    FMOV  V30.D[1], X2
    FMOV  D31, X12
    FMOV  V31.D[1], X8
    MOVZ  X7, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_3:
    BFMLALT V21.4S, V5.8H, V12.H[0x5]
    UDOT V1.2S, V24.8B, V24.8B
    BFDOT V12.2S, V26.4H, V26.2H[0x3]
    UDOT V31.4S, V1.16B, V28.16B
    BFDOT V5.2S, V25.4H, V12.2H[0x1]
    SQRDMLSH V21.8H, V0.8H, V7.H[0x4]
    UDOT V25.2S, V18.8B, V31.8B
    UDOT V5.4S, V5.16B, V21.16B
    BFMLALT V2.4S, V1.8H, V26.8H
    SQRDMLSH V8.2S, V5.2S, V2.S[0x3]
    UDOT V14.4S, V14.16B, V4.16B
    SQRDMLSH V6.4S, V19.4S, V16.S[0x0]
    SDOT V5.2S, V8.8B, V14.8B
    BFMLALB V31.4S, V7.8H, V5.8H
    SDOT V18.4S, V31.16B, V19.4B[0x2]
    SQRDMLAH V5.2S, V6.2S, V25.2S
    BFDOT V21.4S, V5.8H, V18.8H
    BFDOT V26.2S, V21.4H, V1.2H[0x3]
    SQRDMLSH V4.4H, V22.4H, V5.H[0x3]
    SQRDMLAH V22.4S, V4.4S, V4.4S
    SQRDMLSH V24.8H, V22.8H, V22.8H
    BFMLALT V25.4S, V24.8H, V7.H[0x3]
    BFMLALB V2.4S, V9.8H, V26.8H
    BFCVTN2 V0.8H, V25.4S
    BFDOT V18.2S, V0.4H, V0.2H[0x3]
    SDOT V4.4S, V18.16B, V10.16B
    BFCVTN V26.4H, V2.4S
    UDOT V14.4S, V31.16B, V4.4B[0x3]
    SDOT V22.2S, V7.8B, V5.8B
    BFMLALT V28.4S, V26.8H, V14.8H
    SQRDMLSH V4.4H, V9.4H, V6.H[0x6]
    SQRDMLSH V8.8H, V0.8H, V9.H[0x5]
    BFDOT V25.2S, V6.4H, V15.4H
    SQRDMLSH V7.2S, V9.2S, V14.S[0x0]
    SQRDMLAH V26.4S, V16.4S, V2.S[0x3]
    BFCVTN2 V11.8H, V2.4S
    SQRDMLSH V24.4H, V30.4H, V14.H[0x6]
    SQRDMLSH V0.8H, V16.8H, V6.H[0x3]
    UDOT V9.2S, V4.8B, V1.8B
    BFDOT V6.4S, V28.8H, V2.2H[0x2]
    UDOT V5.2S, V0.8B, V25.8B
    SQRDMLSH V0.2S, V5.2S, V7.2S
    BFMLALB V16.4S, V9.8H, V9.H[0x4]
    BFMLALT V9.4S, V11.8H, V4.8H
    BFMLALB V4.4S, V16.8H, V13.H[0x7]
    UDOT V19.2S, V17.8B, V26.8B
    UDOT V14.2S, V9.8B, V4.8B
    BFMLALT V31.4S, V24.8H, V8.H[0x6]
    UDOT V8.2S, V14.8B, V13.8B
    SDOT V9.2S, V31.8B, V22.4B[0x0]
    UDOT V30.4S, V13.16B, V6.16B
    BFDOT V14.4S, V8.8H, V22.2H[0x2]
    SDOT V11.4S, V14.16B, V29.4B[0x3]
    SDOT V25.2S, V19.8B, V9.8B
    SQRDMLSH V16.4S, V21.4S, V0.S[0x3]
    BFMLALB V18.4S, V25.8H, V1.H[0x5]
    SDOT V5.2S, V11.8B, V30.8B
    BFDOT V6.4S, V10.8H, V5.2H[0x1]
    SQRDMLSH V8.4S, V6.4S, V4.S[0x3]
    SQRDMLSH V31.8H, V16.8H, V7.H[0x1]
    SQRDMLSH V13.8H, V8.8H, V18.8H
    SQRDMLAH V30.8H, V1.8H, V7.H[0x5]
    SQRDMLAH V8.4S, V25.4S, V27.4S
    BFMLALB V29.4S, V11.8H, V28.8H
    BFDOT V16.2S, V4.4H, V3.2H[0x1]
    BFDOT V4.4S, V8.8H, V15.2H[0x3]
    SDOT V4.4S, V15.16B, V25.16B
    SDOT V25.2S, V10.8B, V2.8B
    BFMLALB V9.4S, V25.8H, V28.8H
    UDOT V22.4S, V3.16B, V30.16B
    SDOT V26.4S, V26.16B, V5.4B[0x3]
    BFMMLA V2.4S, V25.8H, V18.8H
    BFCVTN2 V18.8H, V13.4S
    BFCVTN2 V30.8H, V26.4S
    BFDOT V28.2S, V9.4H, V19.2H[0x2]
    SDOT V8.4S, V16.16B, V16.16B
    BFMLALB V13.4S, V22.8H, V2.8H
    SQRDMLAH V3.2S, V18.2S, V8.S[0x1]
    SDOT V21.4S, V29.16B, V30.16B
    SDOT V4.2S, V4.8B, V3.4B[0x1]
    BFMMLA V29.4S, V13.8H, V28.8H
    SQRDMLSH V14.4H, V21.4H, V14.H[0x5]
    BFMMLA V13.4S, V20.8H, V4.8H
    UDOT V10.2S, V13.8B, V14.8B
    BFMLALB V2.4S, V29.8H, V3.8H
    SQRDMLSH V3.8H, V2.8H, V13.H[0x3]
    BFMLALT V26.4S, V3.8H, V12.8H
    SDOT V2.2S, V10.8B, V26.8B
    SQRDMLSH V8.4S, V24.4S, V17.S[0x3]
    SDOT V22.4S, V10.16B, V25.4B[0x3]
    SQRDMLAH V18.8H, V7.8H, V10.8H
    BFMLALT V9.4S, V5.8H, V27.8H
    UDOT V28.2S, V21.8B, V0.8B
    BFDOT V27.2S, V20.4H, V14.2H[0x2]
    UDOT V20.2S, V3.8B, V30.8B
    SQRDMLSH V21.2S, V14.2S, V3.S[0x2]
    SQRDMLSH V3.4S, V2.4S, V10.S[0x1]
    BFCVTN2 V10.8H, V20.4S
    BFMLALT V0.4S, V27.8H, V15.H[0x1]
    SQRDMLSH V4.4H, V9.4H, V14.H[0x0]
    UDOT V14.4S, V8.16B, V12.16B
    BFMLALB V2.4S, V4.8H, V5.8H
    SDOT V29.4S, V3.16B, V2.16B
    SQRDMLAH V15.4S, V25.4S, V10.S[0x1]
    SQRDMLAH V7.4H, V2.4H, V3.H[0x3]
    BFDOT V13.2S, V21.4H, V21.4H
    UDOT V20.4S, V18.16B, V7.4B[0x0]
    SDOT V2.4S, V26.16B, V14.4B[0x3]
    UDOT V9.4S, V13.16B, V15.16B
    SQRDMLAH V11.4S, V15.4S, V0.4S
    BFCVTN2 V12.8H, V1.4S
    UDOT V27.4S, V29.16B, V29.16B
    BFCVTN2 V8.8H, V12.4S
    SQRDMLSH V15.4H, V9.4H, V12.H[0x1]
    BFDOT V9.4S, V1.8H, V15.8H
    SQRDMLAH V7.8H, V20.8H, V2.H[0x5]
    SQRDMLAH V24.4S, V10.4S, V27.S[0x2]
    SDOT V17.2S, V9.8B, V12.4B[0x1]
    BFMMLA V18.4S, V21.8H, V3.8H
    BFDOT V5.4S, V27.8H, V12.8H
    BFDOT V20.4S, V28.8H, V9.8H
    SQRDMLAH V28.4H, V17.4H, V11.H[0x7]
    BFDOT V26.4S, V29.8H, V28.8H
    UDOT V9.2S, V5.8B, V8.8B
    BFMMLA V21.4S, V0.8H, V22.8H
    SQRDMLSH V4.2S, V20.2S, V19.S[0x2]
    UDOT V3.2S, V18.8B, V9.4B[0x3]
    SQRDMLAH V17.4H, V2.4H, V4.H[0x2]
    BFDOT V5.4S, V21.8H, V18.2H[0x1]
    SQRDMLSH V11.4S, V26.4S, V7.4S
    SQRDMLSH V20.8H, V3.8H, V5.H[0x2]
    BFMLALT V10.4S, V11.8H, V1.H[0x7]
    BFMLALB V27.4S, V29.8H, V0.H[0x0]
    UDOT V7.4S, V3.16B, V10.4B[0x2]
    SDOT V0.2S, V27.8B, V6.4B[0x3]
    UDOT V4.2S, V20.8B, V20.4B[0x1]
    SQRDMLSH V19.8H, V13.8H, V10.8H
    SQRDMLAH V9.4H, V19.4H, V17.4H
    SDOT V12.4S, V0.16B, V9.4B[0x0]
    UDOT V20.2S, V25.8B, V7.4B[0x3]
    BFDOT V8.2S, V12.4H, V21.2H[0x3]
    BFCVTN V21.4H, V20.4S
    SQRDMLAH V7.2S, V8.2S, V8.2S
    SQRDMLAH V11.8H, V24.8H, V12.8H
    SQRDMLSH V13.2S, V11.2S, V8.2S
    BFMMLA V29.4S, V4.8H, V13.8H
    SQRDMLAH V10.2S, V23.2S, V7.2S
    SQRDMLSH V17.4S, V30.4S, V21.S[0x3]
    UDOT V27.2S, V29.8B, V13.8B
    UDOT V12.2S, V27.8B, V17.4B[0x1]
    SQRDMLSH V2.4S, V21.4S, V1.4S
    BFMLALT V26.4S, V18.8H, V1.H[0x7]
    SDOT V18.4S, V8.16B, V15.4B[0x3]
    SQRDMLSH V9.4H, V8.4H, V7.4H
    SQRDMLSH V20.4H, V15.4H, V4.H[0x2]
    BFMLALT V12.4S, V2.8H, V8.H[0x7]
    BFDOT V1.2S, V19.4H, V17.4H
    SQRDMLAH V15.4S, V30.4S, V22.S[0x0]
    BFDOT V13.4S, V28.8H, V6.2H[0x3]
    BFDOT V24.4S, V1.8H, V1.2H[0x0]
    BFDOT V1.2S, V18.4H, V9.2H[0x2]
    SDOT V0.4S, V24.16B, V6.16B
    SDOT V30.4S, V26.16B, V1.16B
    BFCVTN V6.4H, V21.4S
    BFMMLA V27.4S, V24.8H, V0.8H
    SQRDMLAH V2.4S, V30.4S, V27.S[0x1]
    BFMLALT V9.4S, V27.8H, V12.8H
    SDOT V25.2S, V20.8B, V4.8B
    SDOT V29.2S, V6.8B, V28.8B
    BFMLALB V0.4S, V25.8H, V29.8H
    BFDOT V11.2S, V0.4H, V10.4H
    SQRDMLSH V28.4S, V24.4S, V15.4S
    SDOT V22.4S, V20.16B, V31.4B[0x2]
    SQRDMLAH V4.4H, V11.4H, V0.H[0x1]
    BFCVTN2 V19.8H, V2.4S
    BFMLALT V21.4S, V0.8H, V13.H[0x0]
    BFDOT V25.4S, V10.8H, V28.2H[0x0]
    SDOT V6.2S, V4.8B, V4.4B[0x1]
    SQRDMLSH V4.2S, V19.2S, V25.2S
    UDOT V28.2S, V4.8B, V9.4B[0x2]
    SQRDMLAH V25.8H, V21.8H, V3.8H
    SDOT V9.4S, V24.16B, V23.4B[0x1]
    BFCVTN2 V23.8H, V28.4S
    SQRDMLSH V10.2S, V25.2S, V22.S[0x3]
    BFDOT V28.2S, V9.4H, V10.4H
    UDOT V29.2S, V9.8B, V6.8B
    UDOT V24.2S, V12.8B, V20.4B[0x2]
    SDOT V13.4S, V23.16B, V28.16B
    SDOT V11.4S, V13.16B, V16.16B
    SQRDMLAH V15.4H, V1.4H, V7.H[0x6]
    BFMMLA V3.4S, V11.8H, V24.8H
    BFMLALB V9.4S, V15.8H, V18.8H
    SQRDMLAH V0.8H, V14.8H, V15.H[0x7]
    UDOT V9.4S, V7.16B, V16.16B
    SQRDMLSH V15.2S, V9.2S, V29.2S
    BFDOT V6.4S, V21.8H, V21.2H[0x2]
    SQRDMLSH V28.4S, V20.4S, V0.S[0x0]
    SDOT V21.4S, V6.16B, V15.4B[0x2]
    BFMLALT V18.4S, V21.8H, V24.8H
    SQRDMLAH V15.2S, V29.2S, V28.S[0x2]
    SUBS  X7, X7, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_3
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X17, FPSR
    MOVZ  X22, #0x95, LSL #0
    MOVK  X22, #0x800, LSL #16
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D0
    MOVZ  X22, #0x9dc2, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x9e02, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D1
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X22, #0x803f, LSL #0
    MOVK  X22, #0x7fbf, LSL #16
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D2
    MOVZ  X22, #0x3042, LSL #0
    MOVK  X22, #0x5ab6, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x7fff, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D3
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D4
    MOVZ  X22, #0xff01, LSL #0
    MOVK  X22, #0xffbd, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x7fff, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D5
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D6
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D7
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x7fff, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D8
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X22, #0x1626, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x1626, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D9
    MOVZ  X22, #0x395f, LSL #0
    MOVK  X22, #0xffc4, LSL #16
    MOVK  X22, #0x23e, LSL #32
    MOVK  X22, #0xffc5, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D10
    MOVZ  X22, #0x5a59, LSL #0
    MOVK  X22, #0xda5a, LSL #16
    MOVK  X22, #0x5a59, LSL #32
    MOVK  X22, #0xda5a, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D11
    MOVZ  X22, #0x4f01, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x4f01, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D12
    MOVZ  X22, #0xa0ee, LSL #0
    MOVK  X22, #0x7fc1, LSL #16
    MOVK  X22, #0xb3f3, LSL #32
    MOVK  X22, #0x7fc1, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D13
    MOVZ  X22, #0x1626, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x1626, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D14
    MOVZ  X22, #0xbf7c, LSL #0
    MOVK  X22, #0x5a7e, LSL #16
    MOVK  X22, #0x67e3, LSL #32
    MOVK  X22, #0x5a7d, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D15
    MOVZ  X22, #0x7ee9, LSL #0
    MOVK  X22, #0xd40b, LSL #16
    MOVK  X22, #0x2220, LSL #32
    MOVK  X22, #0xd40a, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D16
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D17
    MOVZ  X22, #0xa54c, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0x5202, LSL #32
    MOVK  X22, #0x7fff, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D18
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X22, #0x5ab7, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0x7fff, LSL #32
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D19
    MOVZ  X22, #0x9c8f, LSL #0
    MOVK  X22, #0xffc2, LSL #16
    MOVK  X22, #0x17f0, LSL #32
    MOVK  X22, #0xffc2, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D20
    MOVZ  X22, #0xfcdc, LSL #0
    MOVK  X22, #0x5df8, LSL #16
    MOVK  X22, #0x1934, LSL #32
    MOVK  X22, #0x5df8, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D21
    MOVZ  X22, #0x7fc0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X22, #0x3f80, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D22
    MOVZ  X22, #0xeb87, LSL #0
    MOVK  X22, #0x76ac, LSL #16
    MOVK  X22, #0xd4a4, LSL #32
    MOVK  X22, #0x76ae, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D23
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D24
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D25
    MOVZ  X22, #0xb20a, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0x7fff, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D26
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D27
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D28
    MOVZ  X22, #0x8bd1, LSL #0
    MOVK  X22, #0x21f5, LSL #16
    MOVK  X22, #0x6f08, LSL #32
    MOVK  X22, #0x21f6, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D29
    MOVZ  X22, #0x2319, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0xc49b, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X22, #0x7fff, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D30
    MOVZ  X22, #0x1053, LSL #0
    MOVK  X22, #0x5a65, LSL #16
    MOVK  X22, #0x1053, LSL #32
    MOVK  X22, #0x5a65, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X22, #0x4799, LSL #0
    MOVK  X22, #0x4799, LSL #16
    MOVK  X22, #0x4799, LSL #32
    MOVK  X22, #0x4799, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D31
    MOVZ  X22, #0x5a51, LSL #0
    MOVK  X22, #0xe91c, LSL #16
    MOVK  X22, #0xe000, LSL #32
    MOVK  X22, #0xad5, LSL #48
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X4
    FMOV  V3.D[1], X6
    FMOV  D4, X4
    FMOV  V4.D[1], X24
    FMOV  D5, X21
    FMOV  V5.D[1], X27
    FMOV  D6, X6
    FMOV  V6.D[1], X4
    FMOV  D7, X7
    FMOV  V7.D[1], X21
    FMOV  D8, X20
    FMOV  V8.D[1], X16
    FMOV  D9, X28
    FMOV  V9.D[1], X20
    FMOV  D10, X23
    FMOV  V10.D[1], X8
    FMOV  D11, X25
    FMOV  V11.D[1], X29
    FMOV  D12, X17
    FMOV  V12.D[1], X29
    FMOV  D13, X4
    FMOV  V13.D[1], X4
    FMOV  D14, X4
    FMOV  V14.D[1], X19
    FMOV  D15, X25
    FMOV  V15.D[1], X5
    FMOV  D16, X29
    FMOV  V16.D[1], X26
    FMOV  D17, X19
    FMOV  V17.D[1], X5
    FMOV  D18, X19
    FMOV  V18.D[1], X6
    FMOV  D19, X19
    FMOV  V19.D[1], X20
    FMOV  D20, X23
    FMOV  V20.D[1], X16
    FMOV  D21, X22
    FMOV  V21.D[1], X10
    FMOV  D22, X6
    FMOV  V22.D[1], X20
    FMOV  D23, X18
    FMOV  V23.D[1], X17
    FMOV  D24, X25
    FMOV  V24.D[1], X12
    FMOV  D25, X10
    FMOV  V25.D[1], X16
    FMOV  D26, X12
    FMOV  V26.D[1], X27
    FMOV  D27, X23
    FMOV  V27.D[1], X21
    FMOV  D28, X29
    FMOV  V28.D[1], X10
    FMOV  D29, X26
    FMOV  V29.D[1], X24
    FMOV  D30, X22
    FMOV  V30.D[1], X4
    FMOV  D31, X22
    FMOV  V31.D[1], X2
    MOVZ  X10, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_4:
    SQRDMLAH V12.2S, V28.2S, V23.S[0x2]
    SQRDMLSH V19.4H, V12.4H, V27.4H
    BFDOT V20.4S, V23.8H, V3.8H
    SDOT V30.2S, V30.8B, V30.4B[0x1]
    SDOT V6.2S, V26.8B, V29.8B
    SQRDMLSH V17.2S, V8.2S, V27.2S
    BFMLALT V29.4S, V25.8H, V6.H[0x4]
    BFMMLA V30.4S, V20.8H, V30.8H
    SQRDMLAH V15.8H, V31.8H, V30.8H
    UDOT V26.2S, V19.8B, V17.8B
    BFMMLA V10.4S, V31.8H, V2.8H
    SQRDMLAH V23.4H, V26.4H, V29.4H
    SDOT V12.2S, V10.8B, V23.4B[0x3]
    BFCVTN V17.4H, V15.4S
    BFDOT V28.4S, V10.8H, V12.2H[0x1]
    BFCVTN2 V29.8H, V28.4S
    SQRDMLAH V26.4S, V28.4S, V29.S[0x0]
    SQRDMLSH V3.4H, V17.4H, V14.H[0x2]
    BFCVTN V10.4H, V25.4S
    SQRDMLAH V30.4H, V23.4H, V18.4H
    BFMLALB V20.4S, V10.8H, V12.8H
    SDOT V11.4S, V9.16B, V9.4B[0x0]
    BFMLALT V27.4S, V18.8H, V3.8H
    UDOT V25.4S, V9.16B, V1.16B
    SDOT V15.4S, V28.16B, V21.16B
    BFDOT V6.4S, V9.8H, V22.2H[0x3]
    SQRDMLSH V21.4S, V14.4S, V9.S[0x0]
    BFDOT V5.4S, V27.8H, V30.2H[0x3]
    UDOT V28.4S, V5.16B, V10.4B[0x0]
    BFMLALB V19.4S, V11.8H, V15.H[0x0]
    SQRDMLSH V2.2S, V20.2S, V9.2S
    SQRDMLSH V14.8H, V15.8H, V2.H[0x5]
    BFMLALT V12.4S, V29.8H, V14.H[0x5]
    SDOT V10.2S, V19.8B, V10.8B
    SDOT V1.2S, V6.8B, V21.4B[0x2]
    BFDOT V22.2S, V26.4H, V12.4H
    BFDOT V23.4S, V11.8H, V2.8H
    SQRDMLSH V15.4H, V1.4H, V1.H[0x0]
    BFDOT V29.2S, V25.4H, V10.2H[0x2]
    BFMLALT V9.4S, V23.8H, V15.H[0x2]
    SQRDMLSH V23.2S, V16.2S, V16.S[0x0]
    SQRDMLSH V19.2S, V22.2S, V29.2S
    SDOT V27.4S, V10.16B, V23.16B
    BFCVTN2 V17.8H, V30.4S
    BFMLALB V15.4S, V28.8H, V2.8H
    BFDOT V2.2S, V17.4H, V8.4H
    SQRDMLAH V25.4S, V9.4S, V15.4S
    BFCVTN2 V29.8H, V25.4S
    UDOT V10.4S, V5.16B, V29.16B
    SQRDMLAH V28.4S, V5.4S, V23.4S
    SDOT V17.4S, V2.16B, V2.16B
    UDOT V26.4S, V10.16B, V5.4B[0x0]
    SQRDMLSH V3.2S, V28.2S, V28.S[0x2]
    SQRDMLSH V15.8H, V27.8H, V15.8H
    UDOT V29.2S, V26.8B, V5.4B[0x0]
    SDOT V12.4S, V19.16B, V3.16B
    SQRDMLSH V3.4S, V29.4S, V29.S[0x3]
    SQRDMLSH V29.8H, V17.8H, V17.8H
    SDOT V9.4S, V15.16B, V24.16B
    UDOT V16.2S, V3.8B, V12.4B[0x2]
    BFDOT V2.2S, V11.4H, V29.4H
    SDOT V8.2S, V10.8B, V2.4B[0x2]
    UDOT V21.2S, V24.8B, V16.8B
    SDOT V16.2S, V9.8B, V16.4B[0x0]
    SDOT V12.2S, V8.8B, V21.4B[0x0]
    UDOT V5.2S, V16.8B, V2.8B
    UDOT V8.4S, V15.16B, V28.16B
    SQRDMLAH V7.4S, V10.4S, V28.4S
    SDOT V26.4S, V6.16B, V7.16B
    SDOT V17.4S, V4.16B, V9.16B
    SQRDMLSH V4.4H, V0.4H, V7.H[0x6]
    UDOT V16.4S, V22.16B, V2.4B[0x0]
    BFCVTN V23.4H, V0.4S
    BFDOT V16.4S, V0.8H, V3.2H[0x3]
    BFCVTN2 V6.8H, V16.4S
    SQRDMLAH V21.4S, V10.4S, V23.S[0x1]
    SQRDMLSH V9.4H, V16.4H, V10.H[0x1]
    BFDOT V28.4S, V9.8H, V6.2H[0x0]
    SQRDMLSH V0.2S, V21.2S, V5.2S
    BFDOT V10.4S, V4.8H, V17.8H
    SQRDMLAH V25.2S, V0.2S, V0.S[0x0]
    BFMMLA V2.4S, V14.8H, V14.8H
    BFMLALT V19.4S, V28.8H, V2.H[0x0]
    UDOT V30.4S, V18.16B, V13.4B[0x3]
    BFDOT V22.4S, V19.8H, V30.8H
    SQRDMLSH V13.4H, V10.4H, V13.H[0x6]
    SQRDMLAH V25.4H, V25.4H, V8.H[0x3]
    SDOT V6.2S, V13.8B, V12.4B[0x0]
    SQRDMLAH V16.4S, V6.4S, V27.4S
    BFMLALB V23.4S, V25.8H, V26.8H
    BFCVTN2 V7.8H, V26.4S
    SQRDMLSH V21.8H, V7.8H, V10.H[0x2]
    BFMMLA V0.4S, V18.8H, V5.8H
    SQRDMLSH V2.2S, V21.2S, V15.S[0x2]
    BFDOT V13.4S, V16.8H, V25.2H[0x3]
    BFMLALB V27.4S, V0.8H, V0.H[0x2]
    SDOT V25.4S, V29.16B, V27.16B
    SDOT V19.4S, V13.16B, V2.16B
    BFMLALB V14.4S, V25.8H, V22.8H
    UDOT V15.4S, V11.16B, V23.16B
    BFDOT V19.2S, V19.4H, V3.2H[0x2]
    BFMLALB V25.4S, V0.8H, V15.8H
    SQRDMLSH V26.2S, V21.2S, V25.S[0x2]
    BFDOT V13.2S, V9.4H, V26.4H
    BFDOT V0.4S, V13.8H, V6.8H
    BFMLALT V12.4S, V14.8H, V0.H[0x4]
    SQRDMLSH V26.2S, V12.2S, V7.S[0x0]
    BFDOT V12.2S, V23.4H, V1.2H[0x0]
    UDOT V14.2S, V2.8B, V29.8B
    BFDOT V0.2S, V27.4H, V28.2H[0x1]
    BFMLALB V2.4S, V15.8H, V4.H[0x6]
    UDOT V22.4S, V9.16B, V4.16B
    SQRDMLSH V3.8H, V19.8H, V8.8H
    SQRDMLAH V30.2S, V27.2S, V3.S[0x2]
    BFMLALB V11.4S, V25.8H, V5.H[0x5]
    SDOT V29.2S, V19.8B, V29.8B
    SDOT V21.4S, V17.16B, V10.4B[0x1]
    SQRDMLSH V9.2S, V11.2S, V3.S[0x3]
    SQRDMLSH V15.8H, V15.8H, V2.H[0x2]
    BFCVTN V11.4H, V9.4S
    SQRDMLAH V3.4S, V5.4S, V22.S[0x0]
    SQRDMLSH V13.2S, V20.2S, V30.S[0x0]
    SQRDMLAH V2.2S, V13.2S, V12.2S
    SDOT V7.4S, V29.16B, V15.4B[0x0]
    SDOT V29.4S, V26.16B, V27.16B
    BFMLALB V12.4S, V21.8H, V12.H[0x6]
    SQRDMLSH V25.4H, V0.4H, V13.H[0x7]
    SQRDMLSH V22.2S, V3.2S, V2.S[0x2]
    BFMLALT V6.4S, V22.8H, V22.8H
    UDOT V3.4S, V16.16B, V11.16B
    SDOT V20.4S, V28.16B, V6.16B
    UDOT V30.4S, V15.16B, V12.4B[0x3]
    BFMLALT V12.4S, V15.8H, V20.8H
    SDOT V13.2S, V3.8B, V19.4B[0x1]
    SQRDMLAH V21.4H, V29.4H, V6.H[0x3]
    SQRDMLAH V27.4S, V12.4S, V9.S[0x2]
    BFMMLA V0.4S, V9.8H, V25.8H
    UDOT V19.2S, V27.8B, V0.8B
    SQRDMLAH V22.4S, V19.4S, V26.S[0x3]
    SQRDMLSH V9.4H, V13.4H, V4.4H
    UDOT V2.2S, V30.8B, V0.8B
    SQRDMLSH V28.4H, V9.4H, V9.H[0x5]
    BFDOT V13.2S, V12.4H, V28.4H
    BFMMLA V20.4S, V13.8H, V29.8H
    BFMLALB V28.4S, V2.8H, V2.H[0x1]
    UDOT V26.2S, V2.8B, V28.8B
    UDOT V15.2S, V24.8B, V14.8B
    BFMLALT V8.4S, V20.8H, V26.8H
    BFMMLA V19.4S, V22.8H, V9.8H
    SQRDMLSH V26.8H, V15.8H, V15.8H
    BFCVTN V30.4H, V8.4S
    BFMMLA V20.4S, V25.8H, V24.8H
    SQRDMLSH V22.2S, V15.2S, V20.2S
    BFDOT V20.2S, V1.4H, V3.4H
    BFMLALT V11.4S, V18.8H, V22.8H
    BFMLALT V27.4S, V19.8H, V11.H[0x7]
    SQRDMLAH V16.4H, V26.4H, V1.H[0x3]
    SDOT V15.2S, V30.8B, V29.8B
    BFMLALT V26.4S, V27.8H, V27.8H
    SDOT V13.4S, V20.16B, V20.16B
    BFMMLA V13.4S, V16.8H, V21.8H
    BFDOT V20.4S, V13.8H, V16.8H
    SQRDMLAH V9.4S, V29.4S, V15.4S
    UDOT V16.4S, V22.16B, V7.4B[0x1]
    SQRDMLAH V9.4S, V16.4S, V24.S[0x2]
    SQRDMLSH V2.2S, V27.2S, V26.S[0x0]
    SQRDMLAH V24.8H, V2.8H, V13.H[0x4]
    SDOT V16.4S, V24.16B, V24.16B
    BFDOT V3.2S, V8.4H, V9.2H[0x3]
    SDOT V24.2S, V16.8B, V31.4B[0x3]
    SQRDMLSH V21.4H, V0.4H, V3.H[0x0]
    SQRDMLAH V30.2S, V15.2S, V20.S[0x1]
    SDOT V3.4S, V24.16B, V30.16B
    BFMLALB V30.4S, V16.8H, V5.H[0x1]
    SQRDMLAH V22.8H, V12.8H, V8.H[0x6]
    UDOT V29.4S, V14.16B, V17.4B[0x2]
    SDOT V15.4S, V26.16B, V14.16B
    SQRDMLAH V28.2S, V10.2S, V19.2S
    SQRDMLSH V7.8H, V15.8H, V21.8H
    BFDOT V26.2S, V25.4H, V13.4H
    BFDOT V5.4S, V8.8H, V6.2H[0x1]
    SDOT V12.2S, V10.8B, V31.4B[0x0]
    SQRDMLSH V2.4H, V21.4H, V10.H[0x4]
    SQRDMLAH V11.4S, V31.4S, V29.S[0x1]
    UDOT V17.2S, V28.8B, V19.4B[0x0]
    BFMLALT V23.4S, V7.8H, V5.8H
    BFMLALT V24.4S, V17.8H, V26.8H
    UDOT V25.4S, V25.16B, V0.16B
    BFDOT V26.2S, V26.4H, V24.2H[0x2]
    SQRDMLAH V14.8H, V14.8H, V3.H[0x3]
    BFDOT V0.2S, V0.4H, V26.4H
    SQRDMLSH V16.4S, V12.4S, V22.4S
    SQRDMLSH V5.8H, V16.8H, V15.H[0x6]
    SQRDMLSH V15.4S, V16.4S, V23.S[0x0]
    SQRDMLAH V13.4H, V2.4H, V5.H[0x7]
    SDOT V4.2S, V30.8B, V0.8B
    SDOT V17.4S, V11.16B, V1.4B[0x2]
    UDOT V21.2S, V7.8B, V3.8B
    SQRDMLAH V16.2S, V13.2S, V13.S[0x1]
    SQRDMLAH V13.4S, V25.4S, V14.4S
    SUBS  X10, X10, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_4
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X16, FPSR
    MOVZ  X23, #0x9d, LSL #0
    MOVK  X23, #0x800, LSL #16
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D0
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D1
    MOVZ  X23, #0xd325, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xd325, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D2
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0x8000, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D3
    MOVZ  X23, #0x5727, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x5f21, LSL #32
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D4
    MOVZ  X23, #0x195e, LSL #0
    MOVK  X23, #0x8000, LSL #16
    MOVK  X23, #0xe088, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D5
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D6
    MOVZ  X23, #0xd0fb, LSL #0
    MOVK  X23, #0x7fff, LSL #16
    MOVK  X23, #0xfae5, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X23, #0x66d6, LSL #0
    MOVK  X23, #0x66d5, LSL #16
    MOVK  X23, #0xe714, LSL #32
    MOVK  X23, #0xe714, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D7
    MOVZ  X23, #0xf7c, LSL #0
    MOVK  X23, #0x5f31, LSL #16
    MOVK  X23, #0x223c, LSL #32
    MOVK  X23, #0xffaf, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D8
    MOVZ  X23, #0xf9f, LSL #0
    MOVK  X23, #0x7fcb, LSL #16
    MOVK  X23, #0x9b13, LSL #32
    MOVK  X23, #0x7fcc, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D9
    MOVZ  X23, #0x6b83, LSL #0
    MOVK  X23, #0x22dc, LSL #16
    MOVK  X23, #0x7121, LSL #32
    MOVK  X23, #0x239d, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D10
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X23, #0xafa1, LSL #0
    MOVK  X23, #0x59b0, LSL #16
    MOVK  X23, #0xafa1, LSL #32
    MOVK  X23, #0x59b0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D11
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x7fff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D12
    MOVZ  X23, #0xe99b, LSL #0
    MOVK  X23, #0x7fbf, LSL #16
    MOVK  X23, #0xe99b, LSL #32
    MOVK  X23, #0x7fbf, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D13
    MOVZ  X23, #0x7bc0, LSL #0
    MOVK  X23, #0xffc2, LSL #16
    MOVK  X23, #0x1a79, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D14
    MOVZ  X23, #0x7fff, LSL #0
    MOVK  X23, #0xffba, LSL #16
    MOVK  X23, #0xe587, LSL #32
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D15
    MOVZ  X23, #0x7d37, LSL #0
    MOVK  X23, #0x4e4, LSL #16
    MOVK  X23, #0xa2fa, LSL #32
    MOVK  X23, #0x4e2, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D16
    MOVZ  X23, #0x28a9, LSL #0
    MOVK  X23, #0xfb1c, LSL #16
    MOVK  X23, #0x7f2, LSL #32
    MOVK  X23, #0xfb1f, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D17
    MOVZ  X23, #0x789a, LSL #0
    MOVK  X23, #0x2581, LSL #16
    MOVK  X23, #0x20b7, LSL #32
    MOVK  X23, #0xa5d4, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D18
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D19
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D20
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D21
    MOVZ  X23, #0x3aaa, LSL #0
    MOVK  X23, #0x905d, LSL #16
    MOVK  X23, #0x7387, LSL #32
    MOVK  X23, #0x8001, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D22
    MOVZ  X23, #0x88a, LSL #0
    MOVK  X23, #0x7fbe, LSL #16
    MOVK  X23, #0xeea3, LSL #32
    MOVK  X23, #0x7fbc, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D23
    MOVZ  X23, #0x7fc0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0xffef, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D24
    MOVZ  X23, #0x259e, LSL #0
    MOVK  X23, #0x7fc1, LSL #16
    MOVK  X23, #0xbdd2, LSL #32
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D25
    MOVZ  X23, #0xf657, LSL #0
    MOVK  X23, #0x714b, LSL #16
    MOVK  X23, #0x4301, LSL #32
    MOVK  X23, #0x8000, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D26
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D27
    MOVZ  X23, #0x7990, LSL #0
    MOVK  X23, #0x7fe3, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D28
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x7fff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D29
    MOVZ  X23, #0x77fa, LSL #0
    MOVK  X23, #0xdc0e, LSL #16
    MOVK  X23, #0x5c87, LSL #32
    MOVK  X23, #0x80f0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D30
    MOVZ  X23, #0x8db5, LSL #0
    MOVK  X23, #0x7fcf, LSL #16
    MOVK  X23, #0x943e, LSL #32
    MOVK  X23, #0x7fc4, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X16, D31
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X2, #0x7376, LSL #0
    MOVK  X2, #0x2ded, LSL #16
    MOVK  X2, #0xf19a, LSL #32
    MOVK  X2, #0x9230, LSL #48
    MOVZ  X3, #0x3acf, LSL #0
    MOVK  X3, #0x63, LSL #16
    MOVK  X3, #0x3dc3, LSL #32
    MOVK  X3, #0xb59f, LSL #48
    MOVZ  X4, #0xccd1, LSL #0
    MOVK  X4, #0xf2de, LSL #16
    MOVK  X4, #0xff51, LSL #32
    MOVK  X4, #0xc2c, LSL #48
    MOVZ  X5, #0xc55b, LSL #0
    MOVK  X5, #0xf6e6, LSL #16
    MOVK  X5, #0xf5ce, LSL #32
    MOVK  X5, #0x512d, LSL #48
    MOVZ  X6, #0x5327, LSL #0
    MOVK  X6, #0x3ebb, LSL #16
    MOVK  X6, #0x4fc0, LSL #32
    MOVK  X6, #0x36d1, LSL #48
    MOVZ  X7, #0xcae4, LSL #0
    MOVK  X7, #0xe098, LSL #16
    MOVK  X7, #0x328f, LSL #32
    MOVK  X7, #0xccb, LSL #48
    MOVZ  X8, #0x78f0, LSL #0
    MOVK  X8, #0xc3ab, LSL #16
    MOVK  X8, #0x27d1, LSL #32
    MOVK  X8, #0x50f0, LSL #48
    MOVZ  X10, #0x4dd0, LSL #0
    MOVK  X10, #0x47b, LSL #16
    MOVK  X10, #0x3fae, LSL #32
    MOVK  X10, #0x2eb7, LSL #48
    MOVZ  X12, #0x6249, LSL #0
    MOVK  X12, #0x544f, LSL #16
    MOVK  X12, #0xb3c, LSL #32
    MOVK  X12, #0x72e4, LSL #48
    MOVZ  X16, #0x723f, LSL #0
    MOVK  X16, #0xb9a, LSL #16
    MOVK  X16, #0xd37e, LSL #32
    MOVK  X16, #0xe1d7, LSL #48
    MOVZ  X17, #0xbdfe, LSL #0
    MOVK  X17, #0x6092, LSL #16
    MOVK  X17, #0x10e8, LSL #32
    MOVK  X17, #0xd7d7, LSL #48
    MOVZ  X18, #0xb6fb, LSL #0
    MOVK  X18, #0x34dc, LSL #16
    MOVK  X18, #0xa208, LSL #32
    MOVK  X18, #0x2803, LSL #48
    MOVZ  X19, #0xa3e8, LSL #0
    MOVK  X19, #0x1308, LSL #16
    MOVK  X19, #0xbf95, LSL #32
    MOVK  X19, #0x64d7, LSL #48
    MOVZ  X20, #0x33aa, LSL #0
    MOVK  X20, #0x9ff6, LSL #16
    MOVK  X20, #0x1345, LSL #32
    MOVK  X20, #0xfa16, LSL #48
    MOVZ  X21, #0xcc0b, LSL #0
    MOVK  X21, #0x123b, LSL #16
    MOVK  X21, #0x8114, LSL #32
    MOVK  X21, #0x4360, LSL #48
    MOVZ  X22, #0x338b, LSL #0
    MOVK  X22, #0x60bf, LSL #16
    MOVK  X22, #0xb002, LSL #32
    MOVK  X22, #0xfdb7, LSL #48
    MOVZ  X23, #0xcfe4, LSL #0
    MOVK  X23, #0x970, LSL #16
    MOVK  X23, #0xcfe1, LSL #32
    MOVK  X23, #0xebbe, LSL #48
    MOVZ  X24, #0xab33, LSL #0
    MOVK  X24, #0xa78, LSL #16
    MOVK  X24, #0x2b59, LSL #32
    MOVK  X24, #0x8e54, LSL #48
    MOVZ  X25, #0x8c4, LSL #0
    MOVK  X25, #0x4f4f, LSL #16
    MOVK  X25, #0x5997, LSL #32
    MOVK  X25, #0x5901, LSL #48
    MOVZ  X26, #0x78c9, LSL #0
    MOVK  X26, #0x307c, LSL #16
    MOVK  X26, #0x3ef1, LSL #32
    MOVK  X26, #0x1cb0, LSL #48
    MOVZ  X27, #0x6645, LSL #0
    MOVK  X27, #0xf34c, LSL #16
    MOVK  X27, #0xe674, LSL #32
    MOVK  X27, #0x3479, LSL #48
    MOVZ  X28, #0xd67, LSL #0
    MOVK  X28, #0xb51e, LSL #16
    MOVK  X28, #0xcb61, LSL #32
    MOVK  X28, #0xc5ff, LSL #48
    MOVZ  X29, #0xb03a, LSL #0
    MOVK  X29, #0x4b39, LSL #16
    MOVK  X29, #0xd21b, LSL #32
    MOVK  X29, #0x2e3e, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X2
    FMOV  V1.D[1], X27
    FMOV  D2, X2
    FMOV  V2.D[1], X28
    FMOV  D3, X28
    FMOV  V3.D[1], X19
    FMOV  D4, X7
    FMOV  V4.D[1], X10
    FMOV  D5, X5
    FMOV  V5.D[1], X10
    FMOV  D6, X5
    FMOV  V6.D[1], X29
    FMOV  D7, X8
    FMOV  V7.D[1], X22
    FMOV  D8, X10
    FMOV  V8.D[1], X28
    FMOV  D9, X8
    FMOV  V9.D[1], X10
    FMOV  D10, X28
    FMOV  V10.D[1], X17
    FMOV  D11, X21
    FMOV  V11.D[1], X8
    FMOV  D12, X23
    FMOV  V12.D[1], X28
    FMOV  D13, X20
    FMOV  V13.D[1], X25
    FMOV  D14, X22
    FMOV  V14.D[1], X20
    FMOV  D15, X4
    FMOV  V15.D[1], X16
    FMOV  D16, X7
    FMOV  V16.D[1], X4
    FMOV  D17, X23
    FMOV  V17.D[1], X8
    FMOV  D18, X29
    FMOV  V18.D[1], X22
    FMOV  D19, X2
    FMOV  V19.D[1], X7
    FMOV  D20, X7
    FMOV  V20.D[1], X18
    FMOV  D21, X19
    FMOV  V21.D[1], X8
    FMOV  D22, X3
    FMOV  V22.D[1], X29
    FMOV  D23, X29
    FMOV  V23.D[1], X8
    FMOV  D24, X27
    FMOV  V24.D[1], X3
    FMOV  D25, X8
    FMOV  V25.D[1], X6
    FMOV  D26, X3
    FMOV  V26.D[1], X6
    FMOV  D27, X2
    FMOV  V27.D[1], X25
    FMOV  D28, X6
    FMOV  V28.D[1], X27
    FMOV  D29, X2
    FMOV  V29.D[1], X16
    FMOV  D30, X20
    FMOV  V30.D[1], X3
    FMOV  D31, X10
    FMOV  V31.D[1], X8
    MOVZ  X22, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_5:
    BFMMLA V9.4S, V23.8H, V23.8H
    UDOT V20.4S, V25.16B, V27.16B
    BFDOT V24.2S, V21.4H, V30.4H
    SQRDMLAH V30.4H, V20.4H, V9.H[0x3]
    UDOT V17.2S, V31.8B, V31.4B[0x1]
    UDOT V13.4S, V26.16B, V3.16B
    UDOT V14.2S, V28.8B, V13.4B[0x3]
    UDOT V1.2S, V30.8B, V30.8B
    UDOT V29.4S, V17.16B, V28.4B[0x0]
    SQRDMLSH V11.8H, V29.8H, V14.H[0x2]
    SQRDMLAH V9.4H, V25.4H, V1.4H
    BFDOT V14.4S, V3.8H, V30.8H
    BFDOT V9.4S, V9.8H, V24.8H
    BFCVTN2 V28.8H, V11.4S
    BFMMLA V11.4S, V14.8H, V29.8H
    BFDOT V29.2S, V11.4H, V9.4H
    SQRDMLSH V23.2S, V0.2S, V2.S[0x2]
    BFCVTN2 V31.8H, V13.4S
    BFMLALT V21.4S, V3.8H, V13.8H
    UDOT V14.2S, V31.8B, V6.8B
    SQRDMLAH V17.2S, V30.2S, V17.S[0x0]
    SQRDMLAH V20.4H, V10.4H, V12.4H
    SQRDMLAH V24.4S, V18.4S, V24.4S
    SDOT V8.4S, V17.16B, V10.16B
    SQRDMLAH V18.4S, V27.4S, V29.S[0x3]
    SQRDMLAH V30.4S, V6.4S, V13.S[0x1]
    SQRDMLAH V26.4H, V21.4H, V18.4H
    SDOT V12.2S, V8.8B, V14.8B
    SDOT V17.2S, V28.8B, V0.8B
    SDOT V14.2S, V29.8B, V12.8B
    UDOT V2.4S, V21.16B, V27.4B[0x0]
    SQRDMLSH V6.8H, V17.8H, V11.8H
    UDOT V27.2S, V9.8B, V2.4B[0x0]
    SQRDMLAH V13.4H, V30.4H, V6.H[0x5]
    BFMLALT V8.4S, V17.8H, V12.8H
    BFMLALT V29.4S, V15.8H, V8.H[0x5]
    SDOT V12.2S, V11.8B, V20.4B[0x3]
    BFMLALB V9.4S, V12.8H, V24.8H
    BFCVTN V2.4H, V26.4S
    BFDOT V31.4S, V23.8H, V3.2H[0x2]
    SQRDMLSH V30.2S, V6.2S, V2.2S
    BFMLALT V17.4S, V13.8H, V14.8H
    BFMLALB V10.4S, V28.8H, V22.8H
    UDOT V23.2S, V9.8B, V31.8B
    SQRDMLAH V2.4H, V27.4H, V29.4H
    BFDOT V22.4S, V11.8H, V23.2H[0x2]
    BFDOT V26.2S, V17.4H, V2.4H
    SDOT V3.2S, V2.8B, V26.4B[0x3]
    SQRDMLAH V18.8H, V26.8H, V21.8H
    UDOT V26.4S, V3.16B, V10.4B[0x2]
    BFMLALB V1.4S, V26.8H, V16.8H
    SQRDMLAH V16.2S, V16.2S, V30.S[0x2]
    SQRDMLSH V0.4H, V1.4H, V31.4H
    BFMLALB V15.4S, V17.8H, V13.H[0x2]
    SDOT V30.2S, V15.8B, V28.8B
    SDOT V11.2S, V18.8B, V30.4B[0x0]
    SQRDMLSH V18.8H, V12.8H, V29.8H
    SQRDMLAH V15.4S, V16.4S, V22.4S
    BFDOT V17.4S, V24.8H, V15.8H
    SDOT V27.2S, V24.8B, V18.4B[0x3]
    SQRDMLAH V3.4H, V14.4H, V11.H[0x5]
    SQRDMLAH V4.4H, V3.4H, V3.H[0x0]
    BFMLALB V16.4S, V25.8H, V26.8H
    BFMMLA V14.4S, V16.8H, V12.8H
    UDOT V24.2S, V0.8B, V13.8B
    SQRDMLSH V16.2S, V27.2S, V27.S[0x1]
    SQRDMLAH V21.8H, V15.8H, V15.H[0x1]
    BFMLALT V22.4S, V16.8H, V29.8H
    SDOT V30.4S, V23.16B, V13.16B
    SQRDMLSH V23.2S, V9.2S, V21.2S
    SQRDMLSH V11.4H, V30.4H, V8.H[0x6]
    BFDOT V13.2S, V19.4H, V23.4H
    UDOT V26.2S, V4.8B, V23.8B
    BFDOT V0.2S, V14.4H, V24.2H[0x1]
    UDOT V12.4S, V30.16B, V13.4B[0x3]
    BFDOT V3.4S, V11.8H, V1.2H[0x2]
    UDOT V13.2S, V26.8B, V12.8B
    SQRDMLSH V2.8H, V19.8H, V0.H[0x0]
    SQRDMLAH V19.4H, V3.4H, V31.4H
    BFMLALT V0.4S, V22.8H, V2.8H
    SDOT V1.2S, V0.8B, V28.4B[0x3]
    BFCVTN V23.4H, V1.4S
    BFDOT V0.2S, V23.4H, V13.4H
    BFDOT V1.2S, V11.4H, V25.2H[0x3]
    SQRDMLSH V4.8H, V19.8H, V17.8H
    SQRDMLSH V18.4H, V4.4H, V3.H[0x5]
    SQRDMLAH V8.4H, V5.4H, V10.H[0x7]
    BFMLALT V29.4S, V22.8H, V4.H[0x6]
    SQRDMLAH V26.4H, V8.4H, V6.H[0x1]
    UDOT V5.4S, V26.16B, V26.16B
    SDOT V16.2S, V18.8B, V5.8B
    BFMLALB V17.4S, V29.8H, V1.H[0x7]
    SDOT V31.2S, V15.8B, V28.4B[0x1]
    SQRDMLAH V1.4H, V3.4H, V7.4H
    BFDOT V12.2S, V31.4H, V0.4H
    BFMLALB V8.4S, V1.8H, V18.8H
    UDOT V7.4S, V8.16B, V16.4B[0x1]
    SQRDMLAH V26.2S, V22.2S, V7.2S
    SQRDMLAH V30.4S, V26.4S, V2.S[0x0]
    SQRDMLSH V13.2S, V17.2S, V16.S[0x0]
    UDOT V8.4S, V13.16B, V13.4B[0x0]
    SQRDMLAH V5.4S, V13.4S, V4.S[0x3]
    UDOT V20.4S, V12.16B, V5.4B[0x1]
    SDOT V0.2S, V20.8B, V4.8B
    SQRDMLSH V16.4H, V8.4H, V7.H[0x6]
    SQRDMLAH V10.2S, V12.2S, V0.S[0x0]
    BFMLALT V4.4S, V16.8H, V10.H[0x1]
    UDOT V3.4S, V15.16B, V27.4B[0x0]
    UDOT V28.4S, V15.16B, V6.4B[0x2]
    SQRDMLAH V10.4H, V4.4H, V1.H[0x2]
    BFCVTN2 V6.8H, V1.4S
    UDOT V12.4S, V4.16B, V24.4B[0x1]
    UDOT V4.2S, V20.8B, V29.4B[0x3]
    BFMLALT V27.4S, V12.8H, V6.8H
    BFMLALB V18.4S, V26.8H, V23.8H
    SDOT V26.2S, V22.8B, V26.4B[0x1]
    SDOT V16.2S, V26.8B, V13.8B
    SDOT V8.4S, V26.16B, V27.16B
    UDOT V27.4S, V16.16B, V7.4B[0x0]
    SQRDMLSH V1.4H, V13.4H, V19.4H
    BFDOT V23.2S, V3.4H, V27.2H[0x2]
    UDOT V8.4S, V23.16B, V11.4B[0x2]
    BFDOT V20.4S, V28.8H, V8.2H[0x3]
    SDOT V2.2S, V20.8B, V30.4B[0x0]
    BFDOT V6.4S, V2.8H, V17.8H
    BFMLALB V28.4S, V18.8H, V10.8H
    UDOT V26.2S, V4.8B, V6.8B
    SQRDMLSH V10.4S, V26.4S, V1.4S
    SQRDMLAH V30.8H, V27.8H, V6.8H
    BFMLALB V11.4S, V18.8H, V13.H[0x6]
    UDOT V5.4S, V6.16B, V16.4B[0x1]
    SQRDMLSH V3.2S, V31.2S, V25.2S
    BFMLALT V0.4S, V4.8H, V9.H[0x5]
    BFMLALT V7.4S, V26.8H, V15.H[0x5]
    SDOT V27.2S, V31.8B, V23.4B[0x0]
    BFDOT V4.2S, V11.4H, V5.4H
    SQRDMLSH V8.8H, V27.8H, V10.8H
    SQRDMLAH V31.4S, V21.4S, V1.S[0x0]
    UDOT V17.4S, V7.16B, V20.16B
    SQRDMLSH V25.4S, V4.4S, V8.4S
    SDOT V31.2S, V25.8B, V21.4B[0x1]
    SQRDMLAH V19.8H, V28.8H, V3.H[0x4]
    BFDOT V28.4S, V18.8H, V18.8H
    BFMMLA V3.4S, V30.8H, V14.8H
    BFMLALB V9.4S, V24.8H, V3.8H
    BFDOT V13.4S, V17.8H, V11.2H[0x1]
    UDOT V7.2S, V13.8B, V19.8B
    SDOT V8.4S, V28.16B, V28.4B[0x0]
    BFDOT V3.4S, V7.8H, V1.8H
    SDOT V15.4S, V0.16B, V22.16B
    SQRDMLAH V16.2S, V7.2S, V13.S[0x3]
    UDOT V5.2S, V27.8B, V31.8B
    BFDOT V21.4S, V18.8H, V10.2H[0x3]
    BFDOT V7.2S, V16.4H, V3.4H
    SQRDMLAH V11.4S, V1.4S, V7.S[0x0]
    BFDOT V27.4S, V8.8H, V26.8H
    SQRDMLSH V19.8H, V13.8H, V15.H[0x0]
    BFMLALB V28.4S, V21.8H, V6.H[0x4]
    SQRDMLSH V23.2S, V28.2S, V27.S[0x3]
    SDOT V4.2S, V19.8B, V5.8B
    SQRDMLSH V27.4S, V12.4S, V17.S[0x1]
    SQRDMLAH V17.2S, V9.2S, V5.2S
    BFDOT V26.2S, V11.4H, V11.4H
    UDOT V3.2S, V4.8B, V17.8B
    SQRDMLAH V14.8H, V3.8H, V27.8H
    SQRDMLAH V16.4S, V14.4S, V26.S[0x1]
    BFMLALT V25.4S, V31.8H, V13.H[0x0]
    SDOT V25.2S, V0.8B, V10.4B[0x0]
    SQRDMLAH V15.2S, V26.2S, V23.S[0x0]
    UDOT V4.4S, V18.16B, V29.4B[0x1]
    UDOT V28.4S, V5.16B, V18.16B
    SDOT V12.2S, V11.8B, V15.4B[0x1]
    BFMLALB V9.4S, V8.8H, V21.8H
    SQRDMLSH V7.8H, V10.8H, V11.H[0x6]
    SDOT V29.4S, V22.16B, V17.16B
    SQRDMLSH V18.2S, V15.2S, V21.2S
    SDOT V1.4S, V12.16B, V16.16B
    UDOT V19.2S, V11.8B, V9.8B
    BFMLALB V6.4S, V4.8H, V25.8H
    BFCVTN2 V13.8H, V29.4S
    BFMMLA V29.4S, V21.8H, V1.8H
    UDOT V21.2S, V15.8B, V29.8B
    SQRDMLAH V11.2S, V12.2S, V21.S[0x3]
    BFDOT V18.4S, V7.8H, V19.2H[0x0]
    BFDOT V0.2S, V18.4H, V13.2H[0x1]
    SDOT V18.4S, V26.16B, V11.4B[0x1]
    SQRDMLAH V23.2S, V6.2S, V6.S[0x3]
    BFDOT V7.2S, V13.4H, V23.2H[0x3]
    SQRDMLSH V19.4S, V19.4S, V7.4S
    SQRDMLAH V17.4H, V19.4H, V0.H[0x6]
    BFMLALT V1.4S, V17.8H, V3.8H
    UDOT V21.2S, V1.8B, V14.8B
    SDOT V16.4S, V19.16B, V19.4B[0x2]
    BFCVTN2 V5.8H, V16.4S
    BFMLALT V22.4S, V5.8H, V5.H[0x2]
    SQRDMLSH V19.8H, V7.8H, V10.H[0x4]
    SQRDMLSH V31.2S, V22.2S, V18.S[0x2]
    SQRDMLSH V3.8H, V31.8H, V6.H[0x1]
    SQRDMLAH V9.4S, V28.4S, V19.4S
    UDOT V26.4S, V21.16B, V0.16B
    SUBS  X22, X22, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_5
    MOVZ  X17, #0x7376, LSL #0
    MOVK  X17, #0x2ded, LSL #16
    MOVK  X17, #0xf19a, LSL #32
    MOVK  X17, #0x9230, LSL #48
    SUB  X21, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x3acf, LSL #0
    MOVK  X17, #0x63, LSL #16
    MOVK  X17, #0x3dc3, LSL #32
    MOVK  X17, #0xb59f, LSL #48
    SUB  X21, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xc55b, LSL #0
    MOVK  X17, #0xf6e6, LSL #16
    MOVK  X17, #0xf5ce, LSL #32
    MOVK  X17, #0x512d, LSL #48
    SUB  X21, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x5327, LSL #0
    MOVK  X17, #0x3ebb, LSL #16
    MOVK  X17, #0x4fc0, LSL #32
    MOVK  X17, #0x36d1, LSL #48
    SUB  X21, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xcae4, LSL #0
    MOVK  X17, #0xe098, LSL #16
    MOVK  X17, #0x328f, LSL #32
    MOVK  X17, #0xccb, LSL #48
    SUB  X21, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x78f0, LSL #0
    MOVK  X17, #0xc3ab, LSL #16
    MOVK  X17, #0x27d1, LSL #32
    MOVK  X17, #0x50f0, LSL #48
    SUB  X21, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x4dd0, LSL #0
    MOVK  X17, #0x47b, LSL #16
    MOVK  X17, #0x3fae, LSL #32
    MOVK  X17, #0x2eb7, LSL #48
    SUB  X21, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x6249, LSL #0
    MOVK  X17, #0x544f, LSL #16
    MOVK  X17, #0xb3c, LSL #32
    MOVK  X17, #0x72e4, LSL #48
    SUB  X21, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x723f, LSL #0
    MOVK  X17, #0xb9a, LSL #16
    MOVK  X17, #0xd37e, LSL #32
    MOVK  X17, #0xe1d7, LSL #48
    SUB  X21, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xb6fb, LSL #0
    MOVK  X17, #0x34dc, LSL #16
    MOVK  X17, #0xa208, LSL #32
    MOVK  X17, #0x2803, LSL #48
    SUB  X21, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xa3e8, LSL #0
    MOVK  X17, #0x1308, LSL #16
    MOVK  X17, #0xbf95, LSL #32
    MOVK  X17, #0x64d7, LSL #48
    SUB  X21, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x33aa, LSL #0
    MOVK  X17, #0x9ff6, LSL #16
    MOVK  X17, #0x1345, LSL #32
    MOVK  X17, #0xfa16, LSL #48
    SUB  X21, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xcfe4, LSL #0
    MOVK  X17, #0x970, LSL #16
    MOVK  X17, #0xcfe1, LSL #32
    MOVK  X17, #0xebbe, LSL #48
    SUB  X21, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xab33, LSL #0
    MOVK  X17, #0xa78, LSL #16
    MOVK  X17, #0x2b59, LSL #32
    MOVK  X17, #0x8e54, LSL #48
    SUB  X21, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x8c4, LSL #0
    MOVK  X17, #0x4f4f, LSL #16
    MOVK  X17, #0x5997, LSL #32
    MOVK  X17, #0x5901, LSL #48
    SUB  X21, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x78c9, LSL #0
    MOVK  X17, #0x307c, LSL #16
    MOVK  X17, #0x3ef1, LSL #32
    MOVK  X17, #0x1cb0, LSL #48
    SUB  X21, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x6645, LSL #0
    MOVK  X17, #0xf34c, LSL #16
    MOVK  X17, #0xe674, LSL #32
    MOVK  X17, #0x3479, LSL #48
    SUB  X21, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xd67, LSL #0
    MOVK  X17, #0xb51e, LSL #16
    MOVK  X17, #0xcb61, LSL #32
    MOVK  X17, #0xc5ff, LSL #48
    SUB  X21, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0xb03a, LSL #0
    MOVK  X17, #0x4b39, LSL #16
    MOVK  X17, #0xd21b, LSL #32
    MOVK  X17, #0x2e3e, LSL #48
    SUB  X21, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X17, FPSR
    MOVZ  X21, #0x9d, LSL #0
    MOVK  X21, #0x800, LSL #16
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D0
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D1
    MOVZ  X21, #0x3ee9, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0x7fff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D2
    MOVZ  X21, #0xbf40, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0x3f41, LSL #32
    MOVK  X21, #0x3f, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D3
    MOVZ  X21, #0x53f2, LSL #0
    MOVK  X21, #0x2, LSL #16
    MOVK  X21, #0xae45, LSL #32
    MOVK  X21, #0x2, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D4
    MOVZ  X21, #0x7f59, LSL #0
    MOVK  X21, #0x7fc1, LSL #16
    MOVK  X21, #0x6830, LSL #32
    MOVK  X21, #0x7fc1, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X21, #0x7fff, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0x7fc0, LSL #32
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D5
    MOVZ  X21, #0x275b, LSL #0
    MOVK  X21, #0xf707, LSL #16
    MOVK  X21, #0x4a49, LSL #32
    MOVK  X21, #0x5155, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D6
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D7
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X21, #0x16e7, LSL #0
    MOVK  X21, #0xd767, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D8
    MOVZ  X21, #0x4884, LSL #0
    MOVK  X21, #0x3, LSL #16
    MOVK  X21, #0x4885, LSL #32
    MOVK  X21, #0x4, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D9
    MOVZ  X21, #0x942b, LSL #0
    MOVK  X21, #0x7f98, LSL #16
    MOVK  X21, #0x34b8, LSL #32
    MOVK  X21, #0x7fd8, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D10
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D11
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D12
    MOVZ  X21, #0x7edb, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7edb, LSL #32
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X21, #0x7fc0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #32
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D13
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D14
    MOVZ  X21, #0xda1e, LSL #0
    MOVK  X21, #0x7ffe, LSL #16
    MOVK  X21, #0x26a9, LSL #32
    MOVK  X21, #0x7ffe, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D15
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0xf670, LSL #32
    MOVK  X21, #0x7f3f, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X21, #0x2000, LSL #0
    MOVK  X21, #0x7f80, LSL #16
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D16
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D17
    MOVZ  X21, #0x72c8, LSL #0
    MOVK  X21, #0x76cc, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D18
    MOVZ  X21, #0x3f41, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x3f41, LSL #32
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D19
    MOVZ  X21, #0x80b9, LSL #0
    MOVK  X21, #0xffd8, LSL #16
    MOVK  X21, #0x40b9, LSL #32
    MOVK  X21, #0x18, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D20
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D21
    MOVZ  X21, #0x8a5e, LSL #0
    MOVK  X21, #0x7fc2, LSL #16
    MOVK  X21, #0xaa44, LSL #32
    MOVK  X21, #0x7fc1, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D22
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D23
    MOVZ  X21, #0xe000, LSL #0
    MOVK  X21, #0x3f, LSL #16
    MOVK  X21, #0xe000, LSL #32
    MOVK  X21, #0x3f, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D24
    MOVZ  X21, #0xfe40, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x3d01, LSL #32
    MOVK  X21, #0x8001, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D25
    MOVZ  X21, #0xa4e4, LSL #0
    MOVK  X21, #0x7ff6, LSL #16
    MOVK  X21, #0xf029, LSL #32
    MOVK  X21, #0xfff6, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D26
    MOVZ  X21, #0xd081, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0xcfc1, LSL #32
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X21, #0xbfa1, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xbfa1, LSL #32
    MOVK  X21, #0x7fbf, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D27
    MOVZ  X21, #0xd107, LSL #0
    MOVK  X21, #0x3e, LSL #16
    MOVK  X21, #0xd107, LSL #32
    MOVK  X21, #0x3e, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X21, #0x19d6, LSL #0
    MOVK  X21, #0x19d6, LSL #16
    MOVK  X21, #0x99d6, LSL #32
    MOVK  X21, #0x99d6, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D28
    MOVZ  X21, #0xfd02, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0xa55a, LSL #32
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D29
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fbf, LSL #16
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D30
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D31
    MOVZ  X21, #0x1354, LSL #0
    MOVK  X21, #0x7fff, LSL #16
    MOVK  X21, #0xe857, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
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
    FMOV  D0, X23
    FMOV  V0.D[1], X20
    FMOV  D1, X19
    FMOV  V1.D[1], X7
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X24
    FMOV  V3.D[1], X17
    FMOV  D4, X26
    FMOV  V4.D[1], X25
    FMOV  D5, X25
    FMOV  V5.D[1], X22
    FMOV  D6, X6
    FMOV  V6.D[1], X27
    FMOV  D7, X10
    FMOV  V7.D[1], X29
    FMOV  D8, X10
    FMOV  V8.D[1], X24
    FMOV  D9, X26
    FMOV  V9.D[1], X10
    FMOV  D10, X21
    FMOV  V10.D[1], X2
    FMOV  D11, X5
    FMOV  V11.D[1], X3
    FMOV  D12, X19
    FMOV  V12.D[1], X25
    FMOV  D13, X26
    FMOV  V13.D[1], X24
    FMOV  D14, X25
    FMOV  V14.D[1], X18
    FMOV  D15, X8
    FMOV  V15.D[1], X22
    FMOV  D16, X27
    FMOV  V16.D[1], X29
    FMOV  D17, X7
    FMOV  V17.D[1], X7
    FMOV  D18, X12
    FMOV  V18.D[1], X12
    FMOV  D19, X20
    FMOV  V19.D[1], X10
    FMOV  D20, X19
    FMOV  V20.D[1], X26
    FMOV  D21, X10
    FMOV  V21.D[1], X25
    FMOV  D22, X28
    FMOV  V22.D[1], X6
    FMOV  D23, X26
    FMOV  V23.D[1], X28
    FMOV  D24, X19
    FMOV  V24.D[1], X7
    FMOV  D25, X19
    FMOV  V25.D[1], X25
    FMOV  D26, X3
    FMOV  V26.D[1], X20
    FMOV  D27, X22
    FMOV  V27.D[1], X7
    FMOV  D28, X4
    FMOV  V28.D[1], X20
    FMOV  D29, X6
    FMOV  V29.D[1], X6
    FMOV  D30, X2
    FMOV  V30.D[1], X4
    FMOV  D31, X23
    FMOV  V31.D[1], X21
    MOVZ  X6, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_6:
    UDOT V22.4S, V29.16B, V22.4B[0x1]
    SQRDMLAH V11.8H, V23.8H, V4.H[0x3]
    BFMMLA V30.4S, V28.8H, V19.8H
    UDOT V4.2S, V31.8B, V22.8B
    SDOT V12.2S, V4.8B, V25.4B[0x0]
    BFDOT V8.4S, V29.8H, V30.8H
    SQRDMLSH V23.8H, V5.8H, V11.H[0x4]
    SDOT V13.4S, V27.16B, V8.16B
    UDOT V28.2S, V7.8B, V26.8B
    SQRDMLSH V23.4H, V12.4H, V0.H[0x7]
    UDOT V5.4S, V28.16B, V28.4B[0x0]
    BFMLALT V19.4S, V24.8H, V30.8H
    SDOT V21.4S, V15.16B, V5.4B[0x2]
    BFDOT V26.2S, V21.4H, V14.2H[0x1]
    UDOT V4.4S, V17.16B, V8.4B[0x1]
    BFMMLA V0.4S, V4.8H, V13.8H
    BFMMLA V21.4S, V19.8H, V19.8H
    BFMLALT V31.4S, V18.8H, V30.8H
    SDOT V8.2S, V0.8B, V31.4B[0x1]
    SQRDMLSH V26.2S, V22.2S, V16.S[0x2]
    SQRDMLAH V17.4S, V8.4S, V8.S[0x3]
    SDOT V22.2S, V22.8B, V23.4B[0x1]
    SQRDMLSH V23.4H, V9.4H, V9.H[0x1]
    SQRDMLSH V26.2S, V21.2S, V18.2S
    SQRDMLAH V28.2S, V26.2S, V17.2S
    SQRDMLSH V0.2S, V22.2S, V22.2S
    SQRDMLSH V19.4H, V14.4H, V8.H[0x1]
    SDOT V12.4S, V27.16B, V0.4B[0x2]
    SQRDMLAH V11.4H, V20.4H, V9.H[0x1]
    SQRDMLSH V26.8H, V19.8H, V11.H[0x5]
    SQRDMLAH V8.4S, V23.4S, V24.S[0x1]
    UDOT V31.4S, V12.16B, V14.4B[0x2]
    BFMLALB V11.4S, V5.8H, V1.H[0x0]
    SQRDMLAH V22.4H, V5.4H, V8.4H
    SDOT V12.2S, V28.8B, V28.4B[0x2]
    BFMLALT V8.4S, V11.8H, V3.8H
    SQRDMLAH V21.4S, V31.4S, V8.S[0x0]
    SDOT V28.2S, V10.8B, V18.4B[0x2]
    BFDOT V0.2S, V9.4H, V22.2H[0x3]
    BFMLALT V22.4S, V21.8H, V12.8H
    SDOT V13.2S, V28.8B, V14.8B
    SQRDMLSH V31.4S, V19.4S, V29.S[0x2]
    UDOT V5.4S, V26.16B, V13.16B
    UDOT V10.4S, V22.16B, V0.16B
    UDOT V30.2S, V27.8B, V4.4B[0x1]
    SQRDMLSH V18.2S, V31.2S, V10.S[0x0]
    SDOT V17.2S, V15.8B, V18.8B
    SQRDMLAH V27.2S, V17.2S, V5.S[0x1]
    SQRDMLAH V22.2S, V11.2S, V11.S[0x3]
    SDOT V9.4S, V6.16B, V4.4B[0x1]
    SQRDMLAH V29.4S, V31.4S, V3.S[0x0]
    UDOT V9.2S, V29.8B, V22.8B
    UDOT V10.2S, V14.8B, V24.8B
    UDOT V24.4S, V16.16B, V31.4B[0x0]
    SQRDMLAH V16.4S, V12.4S, V23.S[0x2]
    UDOT V21.2S, V13.8B, V29.8B
    SDOT V28.2S, V30.8B, V20.4B[0x2]
    BFMLALT V31.4S, V28.8H, V4.8H
    SQRDMLAH V17.2S, V20.2S, V29.2S
    BFDOT V29.2S, V14.4H, V29.2H[0x2]
    SQRDMLAH V23.8H, V9.8H, V17.8H
    BFMMLA V12.4S, V9.8H, V30.8H
    BFCVTN V30.4H, V27.4S
    UDOT V17.2S, V25.8B, V6.4B[0x3]
    BFMLALB V22.4S, V30.8H, V10.H[0x3]
    BFDOT V14.2S, V17.4H, V22.4H
    SDOT V3.4S, V31.16B, V21.16B
    SQRDMLSH V31.4H, V16.4H, V14.H[0x2]
    BFCVTN2 V4.8H, V12.4S
    SDOT V11.2S, V5.8B, V23.8B
    BFMMLA V22.4S, V24.8H, V14.8H
    SDOT V27.4S, V25.16B, V22.16B
    SQRDMLAH V5.8H, V31.8H, V1.8H
    UDOT V25.2S, V27.8B, V4.8B
    UDOT V16.4S, V11.16B, V1.16B
    BFDOT V21.2S, V3.4H, V3.4H
    SDOT V28.2S, V29.8B, V27.4B[0x2]
    BFMLALT V20.4S, V21.8H, V19.8H
    BFMLALB V21.4S, V31.8H, V5.H[0x0]
    SQRDMLSH V1.8H, V16.8H, V8.H[0x4]
    SQRDMLAH V22.4H, V28.4H, V4.4H
    UDOT V3.2S, V21.8B, V25.8B
    SQRDMLSH V14.8H, V1.8H, V9.H[0x5]
    BFMLALB V23.4S, V21.8H, V14.8H
    UDOT V28.2S, V3.8B, V28.4B[0x0]
    UDOT V18.4S, V7.16B, V20.4B[0x1]
    UDOT V4.2S, V3.8B, V28.4B[0x3]
    SDOT V31.4S, V18.16B, V18.16B
    BFDOT V6.2S, V24.4H, V25.2H[0x1]
    BFCVTN2 V25.8H, V23.4S
    BFMLALB V28.4S, V10.8H, V13.H[0x1]
    SQRDMLSH V23.2S, V31.2S, V19.S[0x1]
    UDOT V7.2S, V24.8B, V10.8B
    UDOT V9.2S, V13.8B, V21.8B
    UDOT V31.4S, V3.16B, V22.16B
    UDOT V19.2S, V10.8B, V7.4B[0x0]
    SQRDMLSH V10.4S, V9.4S, V19.4S
    UDOT V8.4S, V3.16B, V6.16B
    SQRDMLSH V2.4S, V27.4S, V10.4S
    BFDOT V3.4S, V1.8H, V23.8H
    SQRDMLSH V1.4H, V2.4H, V17.4H
    UDOT V9.2S, V3.8B, V15.4B[0x0]
    BFCVTN2 V13.8H, V19.4S
    BFMMLA V6.4S, V21.8H, V25.8H
    SDOT V19.4S, V23.16B, V30.4B[0x3]
    SQRDMLAH V22.4H, V19.4H, V1.4H
    UDOT V21.4S, V6.16B, V25.16B
    SQRDMLAH V10.2S, V9.2S, V28.2S
    SDOT V20.4S, V13.16B, V0.4B[0x0]
    SQRDMLAH V24.2S, V21.2S, V21.S[0x2]
    SDOT V14.2S, V31.8B, V31.4B[0x3]
    SQRDMLSH V0.8H, V24.8H, V10.H[0x1]
    BFDOT V10.2S, V2.4H, V11.4H
    SQRDMLSH V29.4S, V0.4S, V20.S[0x2]
    BFDOT V20.4S, V10.8H, V10.8H
    SQRDMLSH V18.2S, V23.2S, V8.S[0x1]
    SQRDMLSH V3.2S, V4.2S, V29.S[0x0]
    SDOT V7.2S, V20.8B, V22.8B
    SQRDMLSH V20.4H, V3.4H, V7.H[0x5]
    UDOT V17.2S, V4.8B, V20.8B
    SDOT V0.2S, V16.8B, V15.4B[0x1]
    BFCVTN2 V21.8H, V5.4S
    BFMMLA V30.4S, V21.8H, V21.8H
    SDOT V23.2S, V14.8B, V14.4B[0x1]
    BFCVTN2 V4.8H, V30.4S
    BFDOT V20.2S, V18.4H, V12.2H[0x1]
    UDOT V12.2S, V29.8B, V4.4B[0x2]
    UDOT V5.2S, V12.8B, V3.8B
    SQRDMLAH V2.4H, V20.4H, V0.H[0x7]
    BFDOT V17.2S, V17.4H, V28.2H[0x1]
    BFCVTN V31.4H, V2.4S
    SDOT V28.4S, V3.16B, V17.4B[0x2]
    SQRDMLAH V19.4H, V31.4H, V28.4H
    BFDOT V12.4S, V27.8H, V5.8H
    SQRDMLAH V28.4H, V7.4H, V12.H[0x4]
    SDOT V14.2S, V23.8B, V23.8B
    SQRDMLSH V13.2S, V28.2S, V17.2S
    SQRDMLSH V24.4S, V14.4S, V15.S[0x1]
    UDOT V29.4S, V19.16B, V19.4B[0x1]
    SQRDMLAH V0.4S, V24.4S, V13.S[0x1]
    BFMLALT V2.4S, V24.8H, V6.H[0x4]
    SQRDMLAH V13.8H, V14.8H, V8.H[0x5]
    BFDOT V19.4S, V2.8H, V22.2H[0x1]
    SQRDMLSH V14.8H, V12.8H, V1.H[0x2]
    BFMLALB V8.4S, V1.8H, V12.8H
    SDOT V24.4S, V24.16B, V19.4B[0x0]
    BFDOT V3.2S, V8.4H, V19.4H
    SQRDMLAH V22.2S, V24.2S, V28.S[0x2]
    SQRDMLSH V13.4H, V1.4H, V6.4H
    SDOT V2.2S, V6.8B, V21.4B[0x0]
    SQRDMLAH V31.8H, V1.8H, V24.8H
    SQRDMLAH V6.4H, V7.4H, V21.4H
    SQRDMLSH V8.4S, V13.4S, V14.S[0x3]
    BFMLALB V17.4S, V29.8H, V13.8H
    SQRDMLSH V10.4H, V7.4H, V6.H[0x2]
    SDOT V1.2S, V9.8B, V22.4B[0x2]
    UDOT V6.4S, V2.16B, V3.16B
    BFDOT V28.4S, V0.8H, V17.8H
    BFMMLA V13.4S, V28.8H, V1.8H
    SQRDMLSH V18.4S, V10.4S, V25.4S
    SQRDMLSH V2.4S, V6.4S, V8.S[0x0]
    SQRDMLAH V10.2S, V2.2S, V31.2S
    UDOT V21.2S, V10.8B, V23.4B[0x0]
    BFDOT V29.2S, V7.4H, V24.4H
    BFDOT V15.4S, V29.8H, V13.8H
    BFCVTN V19.4H, V31.4S
    SDOT V2.4S, V0.16B, V18.4B[0x2]
    SQRDMLAH V25.2S, V21.2S, V19.S[0x1]
    UDOT V10.2S, V15.8B, V12.8B
    SDOT V21.4S, V25.16B, V12.4B[0x0]
    SQRDMLSH V17.8H, V27.8H, V1.H[0x2]
    UDOT V6.2S, V29.8B, V17.8B
    UDOT V31.2S, V14.8B, V10.4B[0x3]
    BFDOT V10.4S, V2.8H, V6.2H[0x3]
    SQRDMLAH V0.4S, V31.4S, V31.S[0x1]
    BFCVTN V6.4H, V7.4S
    SDOT V17.4S, V14.16B, V10.4B[0x1]
    BFMLALB V10.4S, V0.8H, V0.8H
    SDOT V7.2S, V1.8B, V21.4B[0x1]
    SQRDMLAH V31.2S, V10.2S, V2.2S
    SQRDMLAH V2.8H, V6.8H, V11.H[0x5]
    BFDOT V0.4S, V17.8H, V17.8H
    BFDOT V27.2S, V0.4H, V28.4H
    BFCVTN2 V14.8H, V2.4S
    BFMMLA V23.4S, V14.8H, V27.8H
    BFDOT V27.4S, V28.8H, V5.8H
    SQRDMLAH V29.4S, V27.4S, V11.S[0x2]
    BFCVTN2 V10.8H, V11.4S
    BFMLALT V2.4S, V5.8H, V23.8H
    UDOT V28.4S, V12.16B, V29.16B
    UDOT V13.4S, V10.16B, V10.4B[0x0]
    SQRDMLAH V10.4S, V31.4S, V28.4S
    SQRDMLAH V11.2S, V18.2S, V13.S[0x1]
    SQRDMLSH V18.8H, V2.8H, V7.8H
    SQRDMLSH V21.4H, V30.4H, V7.H[0x6]
    UDOT V17.4S, V24.16B, V18.16B
    BFMLALT V24.4S, V21.8H, V27.8H
    SDOT V9.2S, V0.8B, V24.8B
    SDOT V1.2S, V17.8B, V24.8B
    SQRDMLAH V13.4H, V1.4H, V11.4H
    SUBS  X6, X6, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_6
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X17, FPSR
    MOVZ  X2, #0x9d, LSL #0
    MOVK  X2, #0x800, LSL #16
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X17, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X16
    FMOV  V1.D[1], X18
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X27
    FMOV  V4.D[1], X10
    FMOV  D5, X27
    FMOV  V5.D[1], X26
    FMOV  D6, X22
    FMOV  V6.D[1], X6
    FMOV  D7, X26
    FMOV  V7.D[1], X2
    FMOV  D8, X23
    FMOV  V8.D[1], X26
    FMOV  D9, X26
    FMOV  V9.D[1], X3
    FMOV  D10, X27
    FMOV  V10.D[1], X22
    FMOV  D11, X16
    FMOV  V11.D[1], X6
    FMOV  D12, X24
    FMOV  V12.D[1], X16
    FMOV  D13, X7
    FMOV  V13.D[1], X18
    FMOV  D14, X24
    FMOV  V14.D[1], X27
    FMOV  D15, X12
    FMOV  V15.D[1], X17
    FMOV  D16, X29
    FMOV  V16.D[1], X3
    FMOV  D17, X10
    FMOV  V17.D[1], X26
    FMOV  D18, X5
    FMOV  V18.D[1], X4
    FMOV  D19, X2
    FMOV  V19.D[1], X21
    FMOV  D20, X23
    FMOV  V20.D[1], X25
    FMOV  D21, X5
    FMOV  V21.D[1], X6
    FMOV  D22, X26
    FMOV  V22.D[1], X6
    FMOV  D23, X28
    FMOV  V23.D[1], X2
    FMOV  D24, X6
    FMOV  V24.D[1], X18
    FMOV  D25, X26
    FMOV  V25.D[1], X10
    FMOV  D26, X24
    FMOV  V26.D[1], X26
    FMOV  D27, X16
    FMOV  V27.D[1], X5
    FMOV  D28, X29
    FMOV  V28.D[1], X10
    FMOV  D29, X18
    FMOV  V29.D[1], X10
    FMOV  D30, X5
    FMOV  V30.D[1], X12
    FMOV  D31, X21
    FMOV  V31.D[1], X10
    MOVZ  X10, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_7:
    BFDOT V26.4S, V31.8H, V25.2H[0x0]
    SDOT V24.2S, V19.8B, V28.8B
    UDOT V30.4S, V17.16B, V29.16B
    SQRDMLSH V4.4H, V8.4H, V16.4H
    SQRDMLSH V22.2S, V24.2S, V27.S[0x2]
    UDOT V3.2S, V22.8B, V20.4B[0x1]
    SQRDMLSH V10.4H, V3.4H, V9.H[0x4]
    SDOT V24.2S, V11.8B, V30.4B[0x1]
    BFDOT V21.4S, V30.8H, V14.8H
    SDOT V20.4S, V21.16B, V31.16B
    SDOT V14.2S, V26.8B, V26.8B
    SDOT V18.2S, V4.8B, V4.4B[0x3]
    UDOT V25.4S, V18.16B, V18.4B[0x3]
    BFMLALB V22.4S, V10.8H, V14.8H
    BFCVTN2 V28.8H, V20.4S
    BFCVTN V17.4H, V30.4S
    SDOT V26.4S, V25.16B, V22.16B
    BFDOT V8.2S, V26.4H, V26.2H[0x1]
    SQRDMLAH V21.4S, V24.4S, V28.S[0x0]
    SDOT V29.2S, V21.8B, V2.4B[0x2]
    SQRDMLAH V21.2S, V8.2S, V17.S[0x3]
    SDOT V11.2S, V15.8B, V11.8B
    UDOT V7.2S, V27.8B, V7.4B[0x1]
    BFCVTN V15.4H, V1.4S
    SDOT V4.4S, V2.16B, V17.16B
    SDOT V8.4S, V4.16B, V21.4B[0x2]
    SQRDMLSH V27.4H, V2.4H, V0.4H
    SQRDMLSH V26.2S, V26.2S, V17.S[0x0]
    SQRDMLAH V14.2S, V23.2S, V2.S[0x1]
    BFMLALT V30.4S, V10.8H, V24.8H
    SQRDMLAH V23.4S, V17.4S, V15.S[0x3]
    SDOT V28.4S, V31.16B, V13.4B[0x2]
    SQRDMLAH V13.4H, V7.4H, V14.H[0x5]
    SQRDMLSH V16.4H, V11.4H, V19.4H
    BFDOT V25.4S, V8.8H, V16.8H
    BFMLALB V9.4S, V23.8H, V28.8H
    SDOT V8.4S, V11.16B, V30.4B[0x3]
    SDOT V23.2S, V29.8B, V19.4B[0x1]
    UDOT V29.4S, V5.16B, V25.4B[0x3]
    BFCVTN V2.4H, V29.4S
    BFMLALT V18.4S, V19.8H, V9.8H
    BFCVTN V25.4H, V6.4S
    SQRDMLAH V20.4S, V4.4S, V23.S[0x1]
    BFMLALB V10.4S, V1.8H, V13.8H
    SDOT V9.4S, V8.16B, V26.16B
    BFCVTN2 V19.8H, V20.4S
    SQRDMLAH V28.8H, V16.8H, V9.H[0x2]
    UDOT V17.2S, V28.8B, V2.8B
    UDOT V0.4S, V25.16B, V25.16B
    BFDOT V9.2S, V10.4H, V16.2H[0x3]
    SDOT V29.2S, V18.8B, V18.4B[0x3]
    SQRDMLAH V13.4S, V17.4S, V19.S[0x3]
    SDOT V27.4S, V13.16B, V14.16B
    SQRDMLAH V5.4S, V27.4S, V15.S[0x3]
    SQRDMLAH V26.4S, V9.4S, V29.S[0x0]
    SQRDMLSH V16.2S, V15.2S, V0.S[0x1]
    SQRDMLAH V2.4S, V24.4S, V4.S[0x1]
    UDOT V7.2S, V26.8B, V2.4B[0x1]
    BFMLALT V23.4S, V31.8H, V8.H[0x0]
    UDOT V17.2S, V5.8B, V23.8B
    BFDOT V29.2S, V7.4H, V20.2H[0x0]
    SQRDMLSH V18.2S, V8.2S, V16.S[0x3]
    UDOT V16.4S, V17.16B, V6.4B[0x0]
    SQRDMLAH V30.4H, V12.4H, V4.H[0x7]
    BFDOT V31.4S, V16.8H, V8.2H[0x0]
    BFDOT V17.4S, V11.8H, V2.2H[0x0]
    SDOT V13.2S, V21.8B, V21.4B[0x3]
    UDOT V19.2S, V28.8B, V13.4B[0x1]
    SQRDMLAH V20.4H, V29.4H, V17.4H
    SQRDMLAH V24.4H, V19.4H, V11.H[0x5]
    SDOT V16.2S, V14.8B, V26.8B
    BFMLALT V1.4S, V25.8H, V24.8H
    BFMLALB V26.4S, V30.8H, V7.H[0x7]
    SQRDMLSH V27.4S, V16.4S, V8.S[0x2]
    BFMLALB V14.4S, V23.8H, V10.H[0x6]
    SQRDMLSH V13.4H, V8.4H, V14.H[0x1]
    SQRDMLSH V19.4S, V13.4S, V27.S[0x3]
    BFDOT V28.2S, V19.4H, V19.2H[0x0]
    SQRDMLSH V8.4S, V5.4S, V28.S[0x0]
    SDOT V6.4S, V31.16B, V31.4B[0x1]
    SDOT V2.2S, V11.8B, V8.8B
    BFMLALT V16.4S, V6.8H, V8.8H
    BFMLALT V4.4S, V26.8H, V21.8H
    BFMMLA V6.4S, V20.8H, V1.8H
    BFCVTN V17.4H, V6.4S
    UDOT V29.2S, V17.8B, V27.8B
    SQRDMLSH V7.8H, V16.8H, V16.8H
    BFMMLA V25.4S, V2.8H, V18.8H
    BFMLALB V13.4S, V7.8H, V12.8H
    BFDOT V24.4S, V7.8H, V29.8H
    BFMLALB V1.4S, V13.8H, V24.8H
    SQRDMLSH V16.2S, V12.2S, V2.S[0x1]
    BFMLALB V19.4S, V16.8H, V3.8H
    SQRDMLAH V29.8H, V20.8H, V7.H[0x7]
    SQRDMLSH V26.2S, V29.2S, V1.S[0x0]
    SQRDMLAH V21.4S, V14.4S, V16.S[0x2]
    SQRDMLAH V31.8H, V4.8H, V4.H[0x5]
    BFDOT V20.4S, V26.8H, V0.2H[0x2]
    SQRDMLAH V31.2S, V21.2S, V1.S[0x3]
    BFCVTN2 V13.8H, V19.4S
    SQRDMLAH V24.4H, V31.4H, V10.H[0x0]
    UDOT V19.4S, V25.16B, V25.4B[0x1]
    SDOT V10.2S, V19.8B, V13.8B
    SQRDMLSH V27.4H, V24.4H, V7.H[0x4]
    SQRDMLSH V24.2S, V16.2S, V16.2S
    SQRDMLSH V25.8H, V25.8H, V10.H[0x5]
    UDOT V12.2S, V27.8B, V20.4B[0x3]
    SQRDMLAH V21.4H, V27.4H, V25.4H
    SQRDMLSH V13.4S, V0.4S, V12.S[0x3]
    SDOT V17.4S, V13.16B, V30.4B[0x2]
    UDOT V8.4S, V24.16B, V24.4B[0x1]
    BFMLALB V8.4S, V17.8H, V26.8H
    BFDOT V6.4S, V1.8H, V11.8H
    SQRDMLAH V17.4H, V13.4H, V14.H[0x2]
    SDOT V20.4S, V0.16B, V24.4B[0x2]
    BFDOT V11.2S, V10.4H, V12.2H[0x2]
    SQRDMLSH V12.4H, V7.4H, V13.4H
    BFDOT V10.2S, V31.4H, V7.2H[0x1]
    UDOT V14.2S, V20.8B, V26.4B[0x3]
    SDOT V12.4S, V3.16B, V12.4B[0x0]
    BFMLALB V30.4S, V6.8H, V22.8H
    BFCVTN2 V25.8H, V21.4S
    BFMLALB V0.4S, V24.8H, V30.8H
    BFDOT V21.4S, V3.8H, V10.8H
    SDOT V31.2S, V18.8B, V2.8B
    SQRDMLAH V13.4H, V25.4H, V14.H[0x6]
    BFDOT V10.4S, V12.8H, V12.8H
    BFMLALT V18.4S, V0.8H, V8.H[0x0]
    BFMLALT V16.4S, V4.8H, V10.H[0x0]
    UDOT V4.2S, V13.8B, V13.8B
    BFCVTN2 V1.8H, V11.4S
    SDOT V19.2S, V1.8B, V7.4B[0x0]
    BFMMLA V22.4S, V4.8H, V14.8H
    SQRDMLSH V3.2S, V19.2S, V19.S[0x3]
    SQRDMLAH V10.4H, V3.4H, V3.H[0x3]
    UDOT V24.2S, V23.8B, V21.4B[0x3]
    BFMLALT V26.4S, V18.8H, V16.8H
    SQRDMLAH V12.8H, V26.8H, V10.H[0x4]
    BFDOT V11.4S, V22.8H, V31.2H[0x1]
    SDOT V31.4S, V13.16B, V11.16B
    UDOT V13.2S, V12.8B, V24.8B
    UDOT V14.4S, V17.16B, V31.4B[0x0]
    UDOT V1.4S, V2.16B, V27.16B
    SQRDMLAH V17.8H, V26.8H, V13.H[0x5]
    UDOT V12.2S, V11.8B, V26.8B
    SDOT V3.2S, V19.8B, V30.4B[0x0]
    BFDOT V4.2S, V9.4H, V27.4H
    SQRDMLAH V6.2S, V14.2S, V14.S[0x1]
    BFDOT V31.2S, V26.4H, V4.2H[0x2]
    SDOT V10.2S, V19.8B, V9.4B[0x2]
    SQRDMLAH V14.8H, V6.8H, V13.H[0x4]
    BFCVTN2 V29.8H, V27.4S
    BFMLALB V27.4S, V9.8H, V12.H[0x3]
    SDOT V4.4S, V8.16B, V29.16B
    UDOT V23.4S, V0.16B, V11.16B
    UDOT V21.2S, V10.8B, V16.4B[0x1]
    BFMLALB V8.4S, V31.8H, V11.H[0x4]
    SDOT V6.2S, V3.8B, V21.4B[0x3]
    SQRDMLSH V10.4S, V27.4S, V27.S[0x3]
    SQRDMLAH V12.4S, V10.4S, V6.4S
    BFDOT V29.2S, V4.4H, V21.4H
    UDOT V27.2S, V10.8B, V1.4B[0x2]
    SDOT V9.2S, V1.8B, V17.8B
    SQRDMLSH V13.4H, V27.4H, V0.H[0x7]
    SQRDMLSH V10.8H, V23.8H, V2.H[0x5]
    BFDOT V1.4S, V25.8H, V18.2H[0x2]
    SQRDMLSH V22.4S, V12.4S, V29.S[0x1]
    SQRDMLAH V25.2S, V2.2S, V10.S[0x3]
    SQRDMLAH V12.4S, V9.4S, V11.S[0x0]
    SQRDMLSH V10.4H, V1.4H, V12.H[0x6]
    UDOT V18.4S, V6.16B, V8.16B
    BFMLALB V6.4S, V25.8H, V12.8H
    BFMLALB V16.4S, V10.8H, V23.8H
    BFDOT V8.4S, V6.8H, V14.2H[0x3]
    SQRDMLSH V6.8H, V8.8H, V12.H[0x5]
    SQRDMLAH V15.4H, V26.4H, V4.H[0x0]
    SQRDMLAH V25.4H, V18.4H, V15.H[0x4]
    BFMMLA V9.4S, V22.8H, V16.8H
    BFCVTN V29.4H, V19.4S
    SDOT V12.2S, V29.8B, V25.8B
    BFDOT V27.4S, V20.8H, V12.8H
    BFDOT V26.2S, V9.4H, V5.2H[0x1]
    UDOT V11.2S, V27.8B, V5.4B[0x3]
    BFMMLA V8.4S, V13.8H, V11.8H
    BFDOT V16.2S, V26.4H, V6.2H[0x2]
    UDOT V4.2S, V30.8B, V14.8B
    SDOT V19.2S, V27.8B, V27.4B[0x1]
    UDOT V6.2S, V24.8B, V12.4B[0x1]
    SDOT V31.2S, V31.8B, V26.4B[0x3]
    BFDOT V29.2S, V12.4H, V4.2H[0x1]
    SDOT V11.4S, V15.16B, V24.16B
    UDOT V25.2S, V0.8B, V20.8B
    SQRDMLSH V2.2S, V24.2S, V4.2S
    BFMLALT V15.4S, V11.8H, V0.H[0x0]
    BFDOT V13.4S, V31.8H, V19.2H[0x2]
    SQRDMLAH V0.4H, V8.4H, V4.4H
    BFCVTN2 V12.8H, V6.4S
    SDOT V9.4S, V29.16B, V10.4B[0x0]
    SQRDMLAH V1.4S, V25.4S, V9.4S
    UDOT V27.4S, V13.16B, V0.4B[0x0]
    SUBS  X10, X10, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_7
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X22, FPSR
    MOVZ  X20, #0x9d, LSL #0
    MOVK  X20, #0x800, LSL #16
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D0
    MOVZ  X20, #0x420f, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0x7fff, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D1
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0xfdc2, LSL #32
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D2
    MOVZ  X20, #0x6c37, LSL #0
    MOVK  X20, #0x8033, LSL #16
    MOVK  X20, #0xc84b, LSL #32
    MOVK  X20, #0xffc3, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D3
    MOVZ  X20, #0xc322, LSL #0
    MOVK  X20, #0x8, LSL #16
    MOVK  X20, #0x4302, LSL #32
    MOVK  X20, #0xb, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D4
    MOVZ  X20, #0x21c0, LSL #0
    MOVK  X20, #0x7fc2, LSL #16
    MOVK  X20, #0x8446, LSL #32
    MOVK  X20, #0x7fc1, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D5
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D6
    MOVZ  X20, #0x4b55, LSL #0
    MOVK  X20, #0x7fc1, LSL #16
    MOVK  X20, #0xa31a, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D7
    MOVZ  X20, #0x3054, LSL #0
    MOVK  X20, #0x8000, LSL #16
    MOVK  X20, #0x3508, LSL #32
    MOVK  X20, #0x8000, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D8
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D9
    MOVZ  X20, #0x4f01, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x4f01, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D10
    MOVZ  X20, #0xfff7, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D11
    MOVZ  X20, #0x5018, LSL #0
    MOVK  X20, #0x7fc1, LSL #16
    MOVK  X20, #0xfe28, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X20, #0x7fc1, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D12
    MOVZ  X20, #0x5871, LSL #0
    MOVK  X20, #0x7f02, LSL #16
    MOVK  X20, #0x8785, LSL #32
    MOVK  X20, #0x7f01, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D13
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D14
    MOVZ  X20, #0x18a3, LSL #0
    MOVK  X20, #0xffc8, LSL #16
    MOVK  X20, #0x121a, LSL #32
    MOVK  X20, #0xffc6, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D15
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc1, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D16
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D17
    MOVZ  X20, #0x7fc0, LSL #0
    MOVK  X20, #0x2a20, LSL #16
    MOVK  X20, #0x7fc0, LSL #32
    MOVK  X20, #0x2a20, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D18
    MOVZ  X20, #0x99e8, LSL #0
    MOVK  X20, #0x7fc9, LSL #16
    MOVK  X20, #0x5b11, LSL #32
    MOVK  X20, #0x7fc9, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D19
    MOVZ  X20, #0xcf87, LSL #0
    MOVK  X20, #0xffc7, LSL #16
    MOVK  X20, #0x4ac4, LSL #32
    MOVK  X20, #0x509f, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D20
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D21
    MOVZ  X20, #0x7fdf, LSL #0
    MOVK  X20, #0x7fc1, LSL #16
    MOVK  X20, #0xcfc1, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D22
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0x7fff, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D23
    MOVZ  X20, #0xf546, LSL #0
    MOVK  X20, #0x7fc4, LSL #16
    MOVK  X20, #0x7ae7, LSL #32
    MOVK  X20, #0x7fc8, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D24
    MOVZ  X20, #0xc98c, LSL #0
    MOVK  X20, #0xffcc, LSL #16
    MOVK  X20, #0xc93b, LSL #32
    MOVK  X20, #0x3c, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D25
    MOVZ  X20, #0x7381, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0xfe41, LSL #32
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D26
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D27
    MOVZ  X20, #0xfe41, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0xfe41, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D28
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D29
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D30
    MOVZ  X20, #0xcff4, LSL #0
    MOVK  X20, #0x7fc6, LSL #16
    MOVK  X20, #0xcff4, LSL #32
    MOVK  X20, #0x7fc6, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X22, D31
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X23
    FMOV  D3, X22
    FMOV  V3.D[1], X27
    FMOV  D4, X28
    FMOV  V4.D[1], X21
    FMOV  D5, X16
    FMOV  V5.D[1], X3
    FMOV  D6, X4
    FMOV  V6.D[1], X25
    FMOV  D7, X7
    FMOV  V7.D[1], X29
    FMOV  D8, X22
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X26
    FMOV  D10, X16
    FMOV  V10.D[1], X27
    FMOV  D11, X26
    FMOV  V11.D[1], X21
    FMOV  D12, X16
    FMOV  V12.D[1], X10
    FMOV  D13, X28
    FMOV  V13.D[1], X3
    FMOV  D14, X26
    FMOV  V14.D[1], X26
    FMOV  D15, X5
    FMOV  V15.D[1], X8
    FMOV  D16, X26
    FMOV  V16.D[1], X25
    FMOV  D17, X2
    FMOV  V17.D[1], X21
    FMOV  D18, X7
    FMOV  V18.D[1], X4
    FMOV  D19, X24
    FMOV  V19.D[1], X5
    FMOV  D20, X10
    FMOV  V20.D[1], X3
    FMOV  D21, X26
    FMOV  V21.D[1], X3
    FMOV  D22, X16
    FMOV  V22.D[1], X20
    FMOV  D23, X20
    FMOV  V23.D[1], X18
    FMOV  D24, X27
    FMOV  V24.D[1], X27
    FMOV  D25, X27
    FMOV  V25.D[1], X7
    FMOV  D26, X4
    FMOV  V26.D[1], X16
    FMOV  D27, X21
    FMOV  V27.D[1], X4
    FMOV  D28, X18
    FMOV  V28.D[1], X17
    FMOV  D29, X4
    FMOV  V29.D[1], X12
    FMOV  D30, X10
    FMOV  V30.D[1], X20
    FMOV  D31, X22
    FMOV  V31.D[1], X28
    MOVZ  X23, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_8:
    BFMLALT V3.4S, V23.8H, V30.8H
    UDOT V22.4S, V28.16B, V29.4B[0x1]
    BFMLALT V6.4S, V24.8H, V2.H[0x6]
    UDOT V2.4S, V6.16B, V31.16B
    BFMMLA V0.4S, V3.8H, V22.8H
    SQRDMLSH V29.2S, V0.2S, V22.S[0x0]
    SDOT V8.2S, V21.8B, V29.8B
    SQRDMLAH V6.4H, V2.4H, V2.4H
    SQRDMLAH V16.8H, V4.8H, V8.H[0x1]
    UDOT V0.2S, V27.8B, V7.8B
    SQRDMLSH V31.4H, V16.4H, V11.H[0x5]
    SDOT V6.4S, V0.16B, V6.16B
    SDOT V21.4S, V31.16B, V31.4B[0x2]
    SQRDMLAH V26.4H, V14.4H, V3.H[0x7]
    SQRDMLAH V0.4S, V6.4S, V14.S[0x2]
    SQRDMLAH V28.4S, V26.4S, V21.S[0x1]
    SDOT V26.4S, V28.16B, V25.16B
    SQRDMLSH V19.4H, V18.4H, V7.H[0x7]
    SQRDMLAH V30.4H, V10.4H, V10.H[0x5]
    SQRDMLAH V29.4H, V11.4H, V14.H[0x6]
    SQRDMLAH V27.2S, V5.2S, V23.S[0x3]
    UDOT V7.4S, V22.16B, V3.4B[0x1]
    SQRDMLAH V23.4S, V12.4S, V25.S[0x2]
    UDOT V24.2S, V13.8B, V1.8B
    UDOT V12.2S, V23.8B, V23.8B
    SQRDMLSH V28.2S, V24.2S, V24.2S
    UDOT V26.4S, V21.16B, V19.4B[0x1]
    SDOT V7.2S, V9.8B, V8.4B[0x2]
    SDOT V18.4S, V7.16B, V12.16B
    SQRDMLSH V1.4S, V28.4S, V22.4S
    SQRDMLSH V21.4H, V19.4H, V1.H[0x4]
    BFDOT V11.4S, V14.8H, V14.2H[0x3]
    SQRDMLSH V19.8H, V3.8H, V9.H[0x5]
    SQRDMLSH V25.2S, V26.2S, V25.S[0x2]
    SQRDMLAH V4.2S, V11.2S, V14.S[0x2]
    BFMLALT V28.4S, V17.8H, V4.H[0x4]
    SDOT V4.2S, V29.8B, V4.8B
    SDOT V1.2S, V25.8B, V21.4B[0x2]
    UDOT V11.4S, V18.16B, V13.16B
    SQRDMLSH V28.8H, V6.8H, V11.H[0x3]
    SDOT V17.2S, V1.8B, V30.4B[0x1]
    SDOT V9.4S, V28.16B, V2.4B[0x2]
    BFMLALT V23.4S, V19.8H, V12.H[0x1]
    UDOT V18.2S, V23.8B, V23.4B[0x3]
    BFDOT V13.2S, V1.4H, V17.2H[0x1]
    BFMLALT V30.4S, V9.8H, V18.8H
    SQRDMLSH V18.4H, V4.4H, V4.H[0x4]
    BFMLALT V2.4S, V29.8H, V15.H[0x0]
    BFDOT V6.2S, V7.4H, V22.2H[0x1]
    BFDOT V22.2S, V20.4H, V25.2H[0x3]
    SDOT V9.2S, V2.8B, V26.4B[0x2]
    SQRDMLAH V13.8H, V13.8H, V22.8H
    BFDOT V26.2S, V6.4H, V18.2H[0x1]
    BFCVTN2 V20.8H, V11.4S
    SDOT V19.2S, V11.8B, V26.8B
    UDOT V2.2S, V16.8B, V9.8B
    BFCVTN2 V22.8H, V25.4S
    UDOT V7.4S, V2.16B, V22.16B
    SQRDMLSH V2.4H, V19.4H, V30.4H
    SQRDMLSH V22.8H, V20.8H, V4.H[0x7]
    SQRDMLAH V8.4S, V13.4S, V2.4S
    BFMLALT V6.4S, V22.8H, V22.8H
    BFCVTN V16.4H, V19.4S
    SQRDMLAH V25.4H, V6.4H, V13.4H
    SQRDMLSH V11.8H, V21.8H, V8.H[0x5]
    UDOT V12.2S, V10.8B, V1.8B
    SQRDMLAH V29.4S, V7.4S, V25.4S
    BFCVTN2 V8.8H, V6.4S
    UDOT V2.2S, V16.8B, V8.4B[0x0]
    SQRDMLSH V4.2S, V9.2S, V27.S[0x2]
    UDOT V14.2S, V2.8B, V12.8B
    BFDOT V1.4S, V14.8H, V11.2H[0x1]
    SDOT V18.4S, V4.16B, V1.16B
    BFDOT V7.4S, V13.8H, V9.8H
    BFDOT V14.4S, V9.8H, V14.2H[0x1]
    BFMLALB V20.4S, V20.8H, V27.8H
    UDOT V3.4S, V0.16B, V22.16B
    SQRDMLAH V11.4S, V6.4S, V6.S[0x3]
    UDOT V0.4S, V19.16B, V21.4B[0x1]
    SQRDMLAH V25.8H, V26.8H, V28.8H
    BFMMLA V9.4S, V10.8H, V11.8H
    SDOT V4.4S, V19.16B, V25.4B[0x3]
    SQRDMLSH V30.4H, V18.4H, V18.4H
    BFMMLA V22.4S, V30.8H, V0.8H
    BFMLALB V10.4S, V3.8H, V9.H[0x3]
    SQRDMLSH V27.8H, V19.8H, V29.8H
    SDOT V19.4S, V24.16B, V18.16B
    SQRDMLSH V25.4S, V12.4S, V20.S[0x1]
    SQRDMLAH V21.2S, V14.2S, V25.S[0x2]
    SQRDMLSH V14.4H, V22.4H, V15.H[0x2]
    UDOT V27.4S, V25.16B, V20.4B[0x1]
    SQRDMLAH V1.4H, V23.4H, V4.4H
    SDOT V26.4S, V7.16B, V1.4B[0x1]
    SDOT V24.4S, V27.16B, V8.4B[0x0]
    BFMLALT V8.4S, V14.8H, V6.8H
    BFMLALT V0.4S, V21.8H, V10.H[0x4]
    SQRDMLSH V18.4H, V8.4H, V0.H[0x5]
    SQRDMLAH V30.4S, V26.4S, V28.4S
    SQRDMLAH V21.4H, V24.4H, V2.H[0x2]
    BFCVTN V31.4H, V9.4S
    UDOT V6.4S, V19.16B, V21.4B[0x3]
    SDOT V3.4S, V31.16B, V6.4B[0x0]
    SDOT V15.2S, V3.8B, V30.8B
    BFDOT V6.2S, V15.4H, V13.4H
    BFMLALB V11.4S, V5.8H, V4.8H
    UDOT V27.4S, V6.16B, V6.4B[0x0]
    SDOT V4.4S, V21.16B, V8.4B[0x1]
    SDOT V5.2S, V19.8B, V26.4B[0x3]
    SDOT V10.2S, V10.8B, V30.4B[0x3]
    SQRDMLSH V13.4S, V27.4S, V9.S[0x3]
    BFMLALT V28.4S, V6.8H, V14.H[0x1]
    SQRDMLAH V19.8H, V10.8H, V10.H[0x1]
    BFDOT V30.4S, V24.8H, V18.8H
    SQRDMLSH V2.8H, V25.8H, V9.H[0x2]
    BFMLALT V3.4S, V19.8H, V25.8H
    SDOT V19.4S, V22.16B, V27.4B[0x0]
    BFMLALT V27.4S, V30.8H, V11.H[0x2]
    UDOT V22.4S, V13.16B, V4.4B[0x1]
    BFMLALT V14.4S, V2.8H, V22.8H
    UDOT V30.4S, V5.16B, V28.4B[0x3]
    UDOT V21.4S, V17.16B, V7.4B[0x3]
    UDOT V1.2S, V17.8B, V25.4B[0x2]
    BFCVTN V7.4H, V1.4S
    BFDOT V5.4S, V3.8H, V10.8H
    SDOT V9.2S, V30.8B, V27.4B[0x3]
    SDOT V2.4S, V28.16B, V1.4B[0x3]
    UDOT V1.2S, V13.8B, V5.4B[0x2]
    UDOT V18.4S, V2.16B, V21.16B
    SQRDMLAH V25.2S, V7.2S, V7.S[0x1]
    BFMMLA V5.4S, V1.8H, V18.8H
    UDOT V26.2S, V5.8B, V18.4B[0x2]
    SQRDMLAH V22.4H, V14.4H, V14.H[0x0]
    BFDOT V17.4S, V22.8H, V26.2H[0x2]
    SQRDMLAH V10.4S, V6.4S, V7.S[0x2]
    SDOT V30.4S, V9.16B, V3.16B
    UDOT V4.4S, V19.16B, V10.4B[0x0]
    SQRDMLAH V21.4S, V25.4S, V4.4S
    SQRDMLAH V1.4S, V16.4S, V0.S[0x3]
    SQRDMLAH V9.4S, V21.4S, V1.S[0x0]
    UDOT V27.4S, V22.16B, V22.4B[0x0]
    SDOT V28.2S, V30.8B, V26.8B
    SDOT V7.4S, V0.16B, V17.16B
    UDOT V2.2S, V13.8B, V28.4B[0x2]
    SQRDMLAH V25.4H, V27.4H, V7.H[0x2]
    BFCVTN V0.4H, V12.4S
    BFDOT V22.2S, V1.4H, V25.4H
    BFMMLA V12.4S, V0.8H, V29.8H
    SDOT V1.2S, V22.8B, V12.4B[0x3]
    UDOT V0.2S, V9.8B, V16.8B
    SQRDMLAH V14.2S, V25.2S, V1.S[0x1]
    UDOT V1.2S, V0.8B, V20.8B
    SDOT V0.4S, V1.16B, V23.4B[0x1]
    SQRDMLSH V17.4S, V10.4S, V2.S[0x3]
    SQRDMLSH V23.8H, V14.8H, V17.8H
    UDOT V1.4S, V20.16B, V28.4B[0x1]
    SQRDMLAH V2.4S, V1.4S, V17.4S
    BFCVTN2 V7.8H, V14.4S
    BFDOT V27.2S, V13.4H, V27.4H
    UDOT V5.4S, V20.16B, V20.4B[0x1]
    BFDOT V19.2S, V6.4H, V24.2H[0x3]
    SQRDMLAH V16.4S, V17.4S, V24.4S
    BFMLALB V7.4S, V5.8H, V2.H[0x7]
    SQRDMLAH V10.4H, V17.4H, V11.H[0x3]
    BFDOT V12.4S, V13.8H, V11.2H[0x2]
    UDOT V2.4S, V20.16B, V31.16B
    SQRDMLSH V14.4S, V10.4S, V16.S[0x0]
    SQRDMLSH V27.4H, V14.4H, V9.H[0x6]
    BFDOT V11.4S, V19.8H, V12.8H
    SQRDMLSH V14.2S, V27.2S, V3.2S
    BFMLALT V6.4S, V2.8H, V2.H[0x6]
    UDOT V13.4S, V23.16B, V0.16B
    BFMLALT V29.4S, V11.8H, V13.H[0x7]
    BFMLALB V10.4S, V14.8H, V10.H[0x6]
    UDOT V13.4S, V25.16B, V24.16B
    SDOT V25.2S, V13.8B, V29.8B
    BFMLALB V13.4S, V10.8H, V25.8H
    BFCVTN2 V20.8H, V6.4S
    UDOT V16.4S, V13.16B, V20.16B
    UDOT V24.4S, V14.16B, V24.4B[0x1]
    BFMLALT V23.4S, V10.8H, V11.8H
    SQRDMLSH V1.8H, V5.8H, V28.8H
    SQRDMLAH V13.2S, V21.2S, V10.S[0x3]
    UDOT V29.4S, V23.16B, V9.4B[0x3]
    SDOT V6.4S, V12.16B, V1.16B
    BFCVTN2 V21.8H, V6.4S
    SQRDMLSH V4.4S, V6.4S, V0.S[0x3]
    UDOT V11.4S, V0.16B, V27.4B[0x0]
    SQRDMLSH V29.2S, V9.2S, V28.2S
    SDOT V0.2S, V29.8B, V0.8B
    BFMMLA V20.4S, V23.8H, V8.8H
    SQRDMLAH V31.4S, V13.4S, V16.S[0x2]
    SQRDMLSH V14.8H, V7.8H, V7.H[0x6]
    SDOT V13.2S, V12.8B, V21.4B[0x3]
    BFMLALB V23.4S, V30.8H, V4.8H
    BFDOT V29.4S, V31.8H, V20.8H
    BFDOT V31.2S, V30.4H, V14.2H[0x0]
    BFMLALB V30.4S, V24.8H, V5.H[0x5]
    BFMLALB V19.4S, V11.8H, V11.8H
    BFMLALB V11.4S, V31.8H, V15.8H
    SQRDMLAH V14.4H, V18.4H, V11.H[0x2]
    SUBS  X23, X23, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_8
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X4, FPSR
    MOVZ  X20, #0x9d, LSL #0
    MOVK  X20, #0x800, LSL #16
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D0
    MOVZ  X20, #0x964, LSL #0
    MOVK  X20, #0x7fc4, LSL #16
    MOVK  X20, #0xfad8, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X20, #0x6a60, LSL #0
    MOVK  X20, #0x1, LSL #16
    MOVK  X20, #0x6a60, LSL #32
    MOVK  X20, #0x1, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D1
    MOVZ  X20, #0xfd23, LSL #0
    MOVK  X20, #0x804c, LSL #16
    MOVK  X20, #0x5219, LSL #32
    MOVK  X20, #0x804d, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D2
    MOVZ  X20, #0xb4d7, LSL #0
    MOVK  X20, #0x804e, LSL #16
    MOVK  X20, #0x3f29, LSL #32
    MOVK  X20, #0x804e, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0x7fff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D3
    MOVZ  X20, #0x1412, LSL #0
    MOVK  X20, #0x7fca, LSL #16
    MOVK  X20, #0xe12, LSL #32
    MOVK  X20, #0x7fca, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D4
    MOVZ  X20, #0xb196, LSL #0
    MOVK  X20, #0x800b, LSL #16
    MOVK  X20, #0x83aa, LSL #32
    MOVK  X20, #0x800c, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X20, #0xcf01, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0xcf01, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D5
    MOVZ  X20, #0xcf01, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0xcf01, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X20, #0xffc0, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffc0, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D6
    MOVZ  X20, #0xad80, LSL #0
    MOVK  X20, #0x7fbf, LSL #16
    MOVK  X20, #0xad40, LSL #32
    MOVK  X20, #0x7fbf, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X20, #0x7fdf, LSL #0
    MOVK  X20, #0x7fdf, LSL #16
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D7
    MOVZ  X20, #0x4e8c, LSL #0
    MOVK  X20, #0xffcd, LSL #16
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X20, #0x7fc0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D8
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D9
    MOVZ  X20, #0x59fd, LSL #0
    MOVK  X20, #0x7f9a, LSL #16
    MOVK  X20, #0x58dc, LSL #32
    MOVK  X20, #0x7f9a, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D10
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0x7fff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D11
    MOVZ  X20, #0xd201, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x3dc1, LSL #32
    MOVK  X20, #0x7fc1, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D12
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D13
    MOVZ  X20, #0xffc1, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffc1, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D14
    MOVZ  X20, #0xbb1e, LSL #0
    MOVK  X20, #0xabb7, LSL #16
    MOVK  X20, #0xfea9, LSL #32
    MOVK  X20, #0xabb7, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D15
    MOVZ  X20, #0x81e5, LSL #0
    MOVK  X20, #0x5a5b, LSL #16
    MOVK  X20, #0x4352, LSL #32
    MOVK  X20, #0x5a5c, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D16
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0xfbe9, LSL #32
    MOVK  X20, #0x5a3d, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D17
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D18
    MOVZ  X20, #0xf169, LSL #0
    MOVK  X20, #0x5a6e, LSL #16
    MOVK  X20, #0x5619, LSL #32
    MOVK  X20, #0x5a6e, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D19
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D20
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X20, #0x7fff, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D21
    MOVZ  X20, #0xb699, LSL #0
    MOVK  X20, #0x5b49, LSL #16
    MOVK  X20, #0x7433, LSL #32
    MOVK  X20, #0x5b4c, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D22
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0x7fff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D23
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fff, LSL #16
    MOVK  X20, #0x7fff, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D24
    MOVZ  X20, #0x47af, LSL #0
    MOVK  X20, #0x5a69, LSL #16
    MOVK  X20, #0xa037, LSL #32
    MOVK  X20, #0x5a6b, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D25
    MOVZ  X20, #0x9a28, LSL #0
    MOVK  X20, #0x4f78, LSL #16
    MOVK  X20, #0x603f, LSL #32
    MOVK  X20, #0x4f58, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D26
    MOVZ  X20, #0xc81, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0xc81, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D27
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D28
    MOVZ  X20, #0x639b, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x618f, LSL #32
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D29
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D30
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X4, D31
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    MOVK  X20, #0x7fc0, LSL #48
    SUB  X22, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X2
    FMOV  V3.D[1], X21
    FMOV  D4, X23
    FMOV  V4.D[1], X16
    FMOV  D5, X24
    FMOV  V5.D[1], X8
    FMOV  D6, X6
    FMOV  V6.D[1], X4
    FMOV  D7, X22
    FMOV  V7.D[1], X8
    FMOV  D8, X4
    FMOV  V8.D[1], X8
    FMOV  D9, X2
    FMOV  V9.D[1], X29
    FMOV  D10, X6
    FMOV  V10.D[1], X7
    FMOV  D11, X18
    FMOV  V11.D[1], X2
    FMOV  D12, X23
    FMOV  V12.D[1], X17
    FMOV  D13, X7
    FMOV  V13.D[1], X21
    FMOV  D14, X19
    FMOV  V14.D[1], X2
    FMOV  D15, X17
    FMOV  V15.D[1], X19
    FMOV  D16, X16
    FMOV  V16.D[1], X12
    FMOV  D17, X22
    FMOV  V17.D[1], X23
    FMOV  D18, X5
    FMOV  V18.D[1], X20
    FMOV  D19, X5
    FMOV  V19.D[1], X26
    FMOV  D20, X3
    FMOV  V20.D[1], X4
    FMOV  D21, X10
    FMOV  V21.D[1], X2
    FMOV  D22, X22
    FMOV  V22.D[1], X16
    FMOV  D23, X23
    FMOV  V23.D[1], X16
    FMOV  D24, X21
    FMOV  V24.D[1], X18
    FMOV  D25, X19
    FMOV  V25.D[1], X26
    FMOV  D26, X8
    FMOV  V26.D[1], X8
    FMOV  D27, X26
    FMOV  V27.D[1], X21
    FMOV  D28, X10
    FMOV  V28.D[1], X29
    FMOV  D29, X23
    FMOV  V29.D[1], X4
    FMOV  D30, X20
    FMOV  V30.D[1], X18
    FMOV  D31, X5
    FMOV  V31.D[1], X16
    MOVZ  X24, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_9:
    BFDOT V23.2S, V2.4H, V13.4H
    SDOT V7.2S, V29.8B, V20.4B[0x1]
    UDOT V13.2S, V28.8B, V18.4B[0x2]
    BFMMLA V21.4S, V23.8H, V16.8H
    SQRDMLSH V23.2S, V13.2S, V30.S[0x2]
    SQRDMLSH V5.4H, V27.4H, V4.H[0x7]
    SDOT V8.4S, V14.16B, V10.4B[0x2]
    BFCVTN2 V19.8H, V7.4S
    SQRDMLSH V9.2S, V21.2S, V26.2S
    SDOT V25.2S, V31.8B, V4.8B
    SDOT V16.2S, V2.8B, V3.8B
    BFDOT V28.2S, V16.4H, V19.4H
    UDOT V28.4S, V8.16B, V29.4B[0x3]
    SQRDMLSH V30.2S, V31.2S, V22.S[0x2]
    BFCVTN2 V8.8H, V0.4S
    SQRDMLAH V18.2S, V16.2S, V8.2S
    BFDOT V23.2S, V28.4H, V30.4H
    BFDOT V30.4S, V12.8H, V23.2H[0x3]
    BFDOT V4.4S, V10.8H, V6.2H[0x0]
    BFDOT V23.2S, V9.4H, V6.4H
    SQRDMLAH V14.8H, V4.8H, V18.8H
    UDOT V16.2S, V27.8B, V14.4B[0x3]
    UDOT V26.2S, V16.8B, V29.8B
    BFDOT V8.2S, V30.4H, V25.2H[0x3]
    SDOT V4.4S, V26.16B, V22.4B[0x3]
    BFMLALT V16.4S, V30.8H, V5.H[0x0]
    BFMLALB V19.4S, V17.8H, V4.H[0x4]
    UDOT V26.2S, V8.8B, V23.4B[0x3]
    SDOT V9.4S, V26.16B, V16.4B[0x2]
    SQRDMLSH V25.8H, V7.8H, V26.8H
    BFDOT V23.2S, V31.4H, V11.4H
    BFCVTN2 V28.8H, V17.4S
    UDOT V18.2S, V23.8B, V15.8B
    SQRDMLSH V29.4H, V7.4H, V2.H[0x2]
    UDOT V22.2S, V16.8B, V12.4B[0x0]
    UDOT V6.2S, V31.8B, V30.4B[0x2]
    SQRDMLAH V26.4H, V31.4H, V9.4H
    UDOT V15.2S, V17.8B, V31.4B[0x1]
    SQRDMLAH V23.4H, V28.4H, V6.H[0x2]
    UDOT V12.2S, V29.8B, V14.8B
    SDOT V7.4S, V25.16B, V18.16B
    SQRDMLSH V4.2S, V22.2S, V23.2S
    UDOT V24.4S, V26.16B, V7.4B[0x1]
    UDOT V5.4S, V24.16B, V31.4B[0x3]
    SQRDMLSH V18.2S, V28.2S, V5.S[0x1]
    BFDOT V5.4S, V19.8H, V12.2H[0x1]
    BFMLALB V26.4S, V18.8H, V5.H[0x2]
    SQRDMLSH V21.4S, V26.4S, V15.S[0x2]
    BFMMLA V7.4S, V7.8H, V7.8H
    SQRDMLAH V31.2S, V17.2S, V18.S[0x0]
    BFCVTN V2.4H, V23.4S
    SDOT V24.4S, V21.16B, V30.16B
    UDOT V0.2S, V18.8B, V15.8B
    SQRDMLAH V19.4S, V4.4S, V28.S[0x2]
    UDOT V22.2S, V7.8B, V30.8B
    UDOT V16.4S, V30.16B, V13.4B[0x3]
    SQRDMLAH V8.2S, V17.2S, V2.S[0x3]
    SDOT V18.2S, V12.8B, V25.8B
    BFDOT V25.2S, V0.4H, V7.4H
    BFMLALB V14.4S, V19.8H, V11.H[0x3]
    BFDOT V17.2S, V5.4H, V25.2H[0x3]
    UDOT V2.2S, V12.8B, V4.8B
    BFDOT V11.2S, V16.4H, V14.4H
    SQRDMLSH V5.8H, V22.8H, V18.8H
    UDOT V3.2S, V11.8B, V2.8B
    BFMLALB V23.4S, V31.8H, V1.H[0x1]
    BFMLALB V18.4S, V31.8H, V8.H[0x6]
    BFMLALT V19.4S, V5.8H, V31.8H
    BFCVTN2 V30.8H, V24.4S
    BFMLALB V22.4S, V23.8H, V12.H[0x1]
    SDOT V8.2S, V17.8B, V3.4B[0x2]
    SQRDMLAH V0.8H, V7.8H, V8.8H
    UDOT V5.4S, V10.16B, V19.16B
    BFDOT V23.4S, V22.8H, V0.2H[0x2]
    BFMMLA V14.4S, V23.8H, V30.8H
    SQRDMLAH V13.4H, V18.4H, V2.H[0x0]
    BFMMLA V10.4S, V30.8H, V13.8H
    BFDOT V12.2S, V19.4H, V9.4H
    SQRDMLAH V28.4S, V5.4S, V12.S[0x3]
    UDOT V19.4S, V28.16B, V27.4B[0x1]
    SQRDMLAH V11.8H, V21.8H, V12.H[0x5]
    SDOT V24.4S, V22.16B, V19.4B[0x3]
    BFCVTN V9.4H, V10.4S
    BFMLALB V10.4S, V22.8H, V11.8H
    UDOT V25.2S, V24.8B, V10.4B[0x1]
    SQRDMLAH V25.4H, V14.4H, V0.H[0x6]
    BFMLALB V0.4S, V20.8H, V6.H[0x0]
    UDOT V24.4S, V25.16B, V4.4B[0x0]
    BFCVTN2 V10.8H, V6.4S
    SDOT V14.4S, V30.16B, V18.16B
    BFDOT V28.4S, V15.8H, V12.2H[0x2]
    SQRDMLAH V30.4H, V8.4H, V10.H[0x0]
    BFMLALB V3.4S, V12.8H, V8.8H
    BFCVTN V21.4H, V18.4S
    BFDOT V2.4S, V27.8H, V15.8H
    SDOT V5.2S, V28.8B, V24.4B[0x2]
    BFMLALB V18.4S, V30.8H, V30.8H
    UDOT V15.2S, V3.8B, V17.8B
    UDOT V11.4S, V14.16B, V2.4B[0x2]
    UDOT V17.2S, V3.8B, V18.4B[0x3]
    UDOT V19.2S, V0.8B, V1.4B[0x0]
    SDOT V30.4S, V6.16B, V23.16B
    SQRDMLSH V8.4S, V27.4S, V24.S[0x0]
    BFDOT V31.4S, V21.8H, V11.8H
    SDOT V2.4S, V17.16B, V19.4B[0x0]
    SDOT V10.2S, V0.8B, V26.4B[0x0]
    UDOT V27.2S, V3.8B, V30.8B
    SQRDMLAH V0.8H, V18.8H, V1.H[0x6]
    BFMLALB V18.4S, V10.8H, V5.H[0x4]
    UDOT V6.4S, V27.16B, V20.4B[0x1]
    BFDOT V26.2S, V0.4H, V6.4H
    BFDOT V12.4S, V26.8H, V31.2H[0x1]
    BFDOT V14.2S, V15.4H, V2.2H[0x0]
    SQRDMLSH V7.2S, V26.2S, V11.S[0x1]
    SDOT V25.2S, V14.8B, V17.4B[0x1]
    BFDOT V0.2S, V25.4H, V7.2H[0x0]
    BFMLALB V24.4S, V2.8H, V9.H[0x0]
    UDOT V21.2S, V8.8B, V0.4B[0x2]
    SQRDMLSH V15.8H, V12.8H, V12.H[0x0]
    BFMLALB V10.4S, V15.8H, V15.H[0x2]
    SQRDMLAH V27.4H, V28.4H, V10.H[0x3]
    BFCVTN2 V10.8H, V26.4S
    BFMLALB V0.4S, V21.8H, V10.H[0x3]
    SQRDMLSH V12.8H, V24.8H, V27.8H
    BFMLALB V18.4S, V12.8H, V5.8H
    BFDOT V13.2S, V17.4H, V4.4H
    BFMLALB V31.4S, V17.8H, V6.H[0x0]
    UDOT V26.2S, V27.8B, V4.8B
    SDOT V15.2S, V4.8B, V13.8B
    BFDOT V20.4S, V13.8H, V29.2H[0x3]
    UDOT V29.4S, V11.16B, V24.4B[0x1]
    SQRDMLSH V8.4H, V14.4H, V7.H[0x6]
    SQRDMLAH V25.2S, V25.2S, V21.S[0x1]
    UDOT V9.2S, V31.8B, V20.8B
    BFMMLA V24.4S, V9.8H, V26.8H
    BFDOT V28.4S, V19.8H, V26.8H
    BFMLALT V2.4S, V0.8H, V7.H[0x2]
    UDOT V31.4S, V29.16B, V2.4B[0x2]
    BFMLALT V6.4S, V24.8H, V8.H[0x7]
    SQRDMLSH V26.8H, V18.8H, V15.H[0x5]
    UDOT V26.4S, V6.16B, V25.16B
    BFCVTN V10.4H, V26.4S
    UDOT V9.4S, V28.16B, V28.4B[0x1]
    SQRDMLAH V13.2S, V31.2S, V10.S[0x1]
    SQRDMLSH V29.4S, V16.4S, V23.S[0x0]
    SQRDMLSH V21.2S, V18.2S, V12.S[0x3]
    BFDOT V11.4S, V8.8H, V19.8H
    UDOT V6.2S, V14.8B, V21.8B
    UDOT V6.2S, V8.8B, V23.4B[0x2]
    UDOT V8.2S, V11.8B, V2.8B
    BFDOT V19.2S, V28.4H, V23.4H
    SQRDMLAH V23.4S, V20.4S, V23.S[0x2]
    BFDOT V12.4S, V13.8H, V27.2H[0x1]
    SDOT V24.2S, V26.8B, V7.4B[0x3]
    BFCVTN V25.4H, V11.4S
    BFCVTN2 V20.8H, V25.4S
    SDOT V16.2S, V7.8B, V23.8B
    BFDOT V13.4S, V8.8H, V8.8H
    UDOT V8.2S, V20.8B, V5.8B
    UDOT V2.2S, V9.8B, V23.4B[0x3]
    BFCVTN2 V11.8H, V6.4S
    SQRDMLAH V7.2S, V4.2S, V12.S[0x1]
    SDOT V15.2S, V4.8B, V7.4B[0x2]
    UDOT V27.4S, V9.16B, V13.4B[0x0]
    SDOT V5.2S, V2.8B, V29.8B
    BFMLALB V7.4S, V24.8H, V10.H[0x4]
    BFDOT V13.2S, V11.4H, V6.2H[0x0]
    SQRDMLAH V24.2S, V8.2S, V2.S[0x0]
    BFMLALT V18.4S, V13.8H, V15.H[0x3]
    BFMLALT V28.4S, V7.8H, V16.8H
    UDOT V8.4S, V18.16B, V24.16B
    SDOT V7.4S, V5.16B, V22.16B
    SDOT V18.2S, V8.8B, V28.4B[0x2]
    SQRDMLAH V6.4S, V31.4S, V19.S[0x0]
    SQRDMLAH V4.8H, V1.8H, V7.H[0x6]
    SQRDMLAH V24.2S, V18.2S, V27.S[0x3]
    SDOT V11.4S, V6.16B, V28.4B[0x1]
    BFMLALT V19.4S, V11.8H, V4.8H
    UDOT V27.2S, V20.8B, V5.4B[0x2]
    BFMLALB V10.4S, V17.8H, V15.8H
    SQRDMLSH V18.2S, V9.2S, V28.2S
    UDOT V15.4S, V18.16B, V1.16B
    BFDOT V18.2S, V15.4H, V7.2H[0x2]
    SQRDMLSH V1.2S, V4.2S, V22.S[0x3]
    UDOT V16.4S, V22.16B, V7.4B[0x2]
    BFDOT V8.4S, V6.8H, V29.8H
    BFDOT V13.2S, V7.4H, V11.2H[0x2]
    SQRDMLAH V6.4H, V18.4H, V10.H[0x3]
    SQRDMLAH V15.4S, V13.4S, V18.4S
    SDOT V13.4S, V29.16B, V8.16B
    BFMLALB V7.4S, V3.8H, V13.H[0x5]
    BFMLALB V4.4S, V15.8H, V31.8H
    SQRDMLAH V10.2S, V4.2S, V24.S[0x2]
    BFMLALT V11.4S, V11.8H, V7.H[0x0]
    BFMLALB V20.4S, V10.8H, V1.H[0x7]
    BFMLALT V2.4S, V11.8H, V19.8H
    SQRDMLAH V5.4H, V2.4H, V17.4H
    SQRDMLAH V29.4H, V12.4H, V4.4H
    SQRDMLAH V1.8H, V16.8H, V5.H[0x0]
    SDOT V11.2S, V29.8B, V20.8B
    SUBS  X24, X24, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_9
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X25, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X3, FPSR
    MOVZ  X25, #0x9d, LSL #0
    MOVK  X25, #0x800, LSL #16
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D0
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D1
    MOVZ  X25, #0xd1, LSL #0
    MOVK  X25, #0xe936, LSL #16
    MOVK  X25, #0x1263, LSL #32
    MOVK  X25, #0xe935, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc1, LSL #16
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D2
    MOVZ  X25, #0x1e82, LSL #0
    MOVK  X25, #0x7fc1, LSL #16
    MOVK  X25, #0x4f81, LSL #32
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D3
    MOVZ  X25, #0x28d0, LSL #0
    MOVK  X25, #0x49b7, LSL #16
    MOVK  X25, #0x9ac0, LSL #32
    MOVK  X25, #0x49b0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D4
    MOVZ  X25, #0xe913, LSL #0
    MOVK  X25, #0xb12f, LSL #16
    MOVK  X25, #0xffff, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D5
    MOVZ  X25, #0x201b, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0x8983, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D6
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D7
    MOVZ  X25, #0x23ab, LSL #0
    MOVK  X25, #0x248e, LSL #16
    MOVK  X25, #0x4a2, LSL #32
    MOVK  X25, #0x46f, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D8
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X25, #0xcf01, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D9
    MOVZ  X25, #0x1dc2, LSL #0
    MOVK  X25, #0x7fc2, LSL #16
    MOVK  X25, #0x1dc2, LSL #32
    MOVK  X25, #0x2, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D10
    MOVZ  X25, #0x7fc1, LSL #0
    MOVK  X25, #0x7fc1, LSL #16
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D11
    MOVZ  X25, #0xffc1, LSL #0
    MOVK  X25, #0x7fbf, LSL #16
    MOVK  X25, #0xffc1, LSL #32
    MOVK  X25, #0x7fbf, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D12
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D13
    MOVZ  X25, #0xc080, LSL #0
    MOVK  X25, #0x7fbf, LSL #16
    MOVK  X25, #0xc080, LSL #32
    MOVK  X25, #0x7fbf, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D14
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D15
    MOVZ  X25, #0x2224, LSL #0
    MOVK  X25, #0x7f14, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D16
    MOVZ  X25, #0x8695, LSL #0
    MOVK  X25, #0x7fc1, LSL #16
    MOVK  X25, #0x7e86, LSL #32
    MOVK  X25, #0x7fc1, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D17
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D18
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc1, LSL #16
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D19
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D20
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D21
    MOVZ  X25, #0x1240, LSL #0
    MOVK  X25, #0x232b, LSL #32
    MOVK  X25, #0x3d, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D22
    MOVZ  X25, #0x12f1, LSL #0
    MOVK  X25, #0x7fca, LSL #16
    MOVK  X25, #0x9507, LSL #32
    MOVK  X25, #0x7fc9, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D23
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D24
    MOVZ  X25, #0xad1d, LSL #0
    MOVK  X25, #0xad1d, LSL #32
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D25
    MOVZ  X25, #0x7fc0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D26
    MOVZ  X25, #0xa4ef, LSL #0
    MOVK  X25, #0x7fc1, LSL #16
    MOVK  X25, #0xc98f, LSL #32
    MOVK  X25, #0x7fc1, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D27
    MOVZ  X25, #0xc986, LSL #0
    MOVK  X25, #0x8000, LSL #16
    MOVK  X25, #0xc959, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D28
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D29
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    MOVK  X25, #0x8000, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D30
    MOVZ  X25, #0xc080, LSL #0
    MOVK  X25, #0x7fbf, LSL #16
    MOVK  X25, #0xc080, LSL #32
    MOVK  X25, #0x7fbf, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X3, D31
    MOVZ  X25, #0xcef4, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0xae81, LSL #32
    MOVK  X25, #0x7fc0, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X2, #0xb16f, LSL #0
    MOVK  X2, #0x5b98, LSL #16
    MOVK  X2, #0xda28, LSL #32
    MOVK  X2, #0x7d5c, LSL #48
    MOVZ  X3, #0xf9d1, LSL #0
    MOVK  X3, #0x1d24, LSL #16
    MOVK  X3, #0xc1bb, LSL #32
    MOVK  X3, #0x3d6e, LSL #48
    MOVZ  X4, #0x77cc, LSL #0
    MOVK  X4, #0x15d4, LSL #16
    MOVK  X4, #0x92d2, LSL #32
    MOVK  X4, #0xd6c, LSL #48
    MOVZ  X5, #0x3316, LSL #0
    MOVK  X5, #0x5626, LSL #16
    MOVK  X5, #0x7aa2, LSL #32
    MOVK  X5, #0x6a18, LSL #48
    MOVZ  X6, #0x8000, LSL #0
    MOVK  X6, #0x5de6, LSL #16
    MOVK  X6, #0xe2a3, LSL #32
    MOVK  X6, #0xfc3c, LSL #48
    MOVZ  X7, #0xd381, LSL #0
    MOVK  X7, #0x9d69, LSL #16
    MOVK  X7, #0x2073, LSL #32
    MOVK  X7, #0x1984, LSL #48
    MOVZ  X8, #0xda79, LSL #0
    MOVK  X8, #0x6bf9, LSL #16
    MOVK  X8, #0x7fc0, LSL #32
    MOVK  X8, #0x2be9, LSL #48
    MOVZ  X10, #0x9744, LSL #0
    MOVK  X10, #0xffdc, LSL #16
    MOVK  X10, #0x36f2, LSL #32
    MOVK  X10, #0x7136, LSL #48
    MOVZ  X12, #0xdd57, LSL #0
    MOVK  X12, #0x7ea4, LSL #16
    MOVK  X12, #0xc919, LSL #32
    MOVK  X12, #0x963, LSL #48
    MOVZ  X16, #0x7b3f, LSL #0
    MOVK  X16, #0x89df, LSL #16
    MOVK  X16, #0x622f, LSL #32
    MOVK  X16, #0x2325, LSL #48
    MOVZ  X17, #0x16b7, LSL #0
    MOVK  X17, #0x16a3, LSL #16
    MOVK  X17, #0xf95c, LSL #32
    MOVK  X17, #0x5b88, LSL #48
    MOVZ  X18, #0xb592, LSL #0
    MOVK  X18, #0xc22a, LSL #16
    MOVK  X18, #0x8fc5, LSL #32
    MOVK  X18, #0xf340, LSL #48
    MOVZ  X19, #0x9055, LSL #0
    MOVK  X19, #0xbc7a, LSL #16
    MOVK  X19, #0xdbe, LSL #32
    MOVK  X19, #0xd2f2, LSL #48
    MOVZ  X20, #0x50d5, LSL #0
    MOVK  X20, #0x1d2c, LSL #16
    MOVK  X20, #0xf691, LSL #32
    MOVK  X20, #0xc766, LSL #48
    MOVZ  X21, #0x619a, LSL #0
    MOVK  X21, #0x2e04, LSL #16
    MOVK  X21, #0x1538, LSL #32
    MOVK  X21, #0x5452, LSL #48
    MOVZ  X22, #0xa64e, LSL #0
    MOVK  X22, #0x392b, LSL #16
    MOVK  X22, #0x6eff, LSL #32
    MOVK  X22, #0xd7a7, LSL #48
    MOVZ  X23, #0x341a, LSL #0
    MOVK  X23, #0x97eb, LSL #16
    MOVK  X23, #0x2faf, LSL #32
    MOVK  X23, #0x8a6c, LSL #48
    MOVZ  X24, #0xfc44, LSL #0
    MOVK  X24, #0x4b9c, LSL #16
    MOVK  X24, #0x6345, LSL #32
    MOVK  X24, #0xf5d9, LSL #48
    MOVZ  X25, #0x1db, LSL #0
    MOVK  X25, #0x905c, LSL #16
    MOVK  X25, #0xa8b1, LSL #32
    MOVK  X25, #0x6716, LSL #48
    MOVZ  X26, #0x2927, LSL #0
    MOVK  X26, #0xd6ac, LSL #16
    MOVK  X26, #0xa4ff, LSL #32
    MOVK  X26, #0xe262, LSL #48
    MOVZ  X27, #0xe4db, LSL #0
    MOVK  X27, #0x2a41, LSL #16
    MOVK  X27, #0xa014, LSL #32
    MOVK  X27, #0x47a2, LSL #48
    MOVZ  X28, #0x4de6, LSL #0
    MOVK  X28, #0xaf14, LSL #16
    MOVK  X28, #0x5ed9, LSL #32
    MOVK  X28, #0x63df, LSL #48
    MOVZ  X29, #0x8767, LSL #0
    MOVK  X29, #0x6b0f, LSL #16
    MOVK  X29, #0x8f03, LSL #32
    MOVK  X29, #0x4d90, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X17
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X22
    FMOV  V3.D[1], X6
    FMOV  D4, X21
    FMOV  V4.D[1], X16
    FMOV  D5, X20
    FMOV  V5.D[1], X20
    FMOV  D6, X24
    FMOV  V6.D[1], X17
    FMOV  D7, X12
    FMOV  V7.D[1], X8
    FMOV  D8, X25
    FMOV  V8.D[1], X5
    FMOV  D9, X18
    FMOV  V9.D[1], X28
    FMOV  D10, X7
    FMOV  V10.D[1], X19
    FMOV  D11, X18
    FMOV  V11.D[1], X12
    FMOV  D12, X3
    FMOV  V12.D[1], X26
    FMOV  D13, X29
    FMOV  V13.D[1], X25
    FMOV  D14, X7
    FMOV  V14.D[1], X27
    FMOV  D15, X8
    FMOV  V15.D[1], X2
    FMOV  D16, X6
    FMOV  V16.D[1], X8
    FMOV  D17, X6
    FMOV  V17.D[1], X22
    FMOV  D18, X23
    FMOV  V18.D[1], X10
    FMOV  D19, X27
    FMOV  V19.D[1], X22
    FMOV  D20, X6
    FMOV  V20.D[1], X27
    FMOV  D21, X8
    FMOV  V21.D[1], X2
    FMOV  D22, X24
    FMOV  V22.D[1], X12
    FMOV  D23, X5
    FMOV  V23.D[1], X18
    FMOV  D24, X8
    FMOV  V24.D[1], X2
    FMOV  D25, X5
    FMOV  V25.D[1], X19
    FMOV  D26, X8
    FMOV  V26.D[1], X8
    FMOV  D27, X2
    FMOV  V27.D[1], X29
    FMOV  D28, X27
    FMOV  V28.D[1], X6
    FMOV  D29, X6
    FMOV  V29.D[1], X8
    FMOV  D30, X8
    FMOV  V30.D[1], X7
    FMOV  D31, X23
    FMOV  V31.D[1], X6
    MOVZ  X27, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_10:
    SQRDMLSH V16.2S, V27.2S, V30.S[0x0]
    BFMLALT V25.4S, V24.8H, V26.8H
    SQRDMLSH V19.8H, V21.8H, V16.8H
    UDOT V27.2S, V15.8B, V13.8B
    SQRDMLAH V21.8H, V15.8H, V10.H[0x7]
    UDOT V10.2S, V28.8B, V28.8B
    UDOT V28.2S, V27.8B, V5.4B[0x0]
    UDOT V1.4S, V21.16B, V10.16B
    SQRDMLAH V1.8H, V29.8H, V1.H[0x2]
    SDOT V6.4S, V19.16B, V23.4B[0x0]
    UDOT V15.2S, V6.8B, V1.4B[0x1]
    SQRDMLSH V23.4S, V1.4S, V26.S[0x3]
    SDOT V28.2S, V29.8B, V15.4B[0x0]
    BFCVTN2 V1.8H, V24.4S
    SDOT V10.4S, V31.16B, V26.4B[0x3]
    SQRDMLSH V13.8H, V23.8H, V28.8H
    SQRDMLAH V16.2S, V29.2S, V1.S[0x0]
    SQRDMLAH V31.2S, V25.2S, V14.2S
    SQRDMLAH V27.4S, V13.4S, V28.4S
    BFCVTN V20.4H, V23.4S
    SDOT V5.2S, V10.8B, V16.8B
    BFDOT V16.2S, V5.4H, V7.2H[0x0]
    BFDOT V13.2S, V12.4H, V7.2H[0x1]
    SQRDMLAH V12.4S, V14.4S, V0.4S
    BFMLALT V10.4S, V16.8H, V13.H[0x2]
    BFDOT V23.4S, V31.8H, V28.8H
    BFDOT V14.4S, V24.8H, V18.2H[0x1]
    SQRDMLAH V26.4S, V27.4S, V30.S[0x3]
    SQRDMLSH V27.4S, V20.4S, V17.S[0x3]
    UDOT V17.2S, V23.8B, V14.8B
    SQRDMLAH V25.4S, V17.4S, V17.S[0x2]
    BFMLALT V20.4S, V27.8H, V2.8H
    BFDOT V7.4S, V20.8H, V24.8H
    SDOT V18.4S, V25.16B, V10.16B
    SQRDMLAH V13.4H, V1.4H, V7.H[0x2]
    SQRDMLAH V13.2S, V26.2S, V18.S[0x3]
    BFDOT V23.4S, V1.8H, V22.8H
    BFMMLA V18.4S, V2.8H, V10.8H
    BFDOT V5.4S, V12.8H, V5.2H[0x2]
    SQRDMLAH V30.4S, V1.4S, V19.S[0x0]
    UDOT V5.4S, V17.16B, V12.16B
    SQRDMLSH V27.4S, V4.4S, V28.4S
    SDOT V31.4S, V11.16B, V31.4B[0x1]
    UDOT V20.2S, V4.8B, V6.8B
    BFCVTN V12.4H, V26.4S
    SQRDMLAH V26.8H, V1.8H, V12.8H
    SQRDMLSH V28.4H, V13.4H, V13.4H
    BFDOT V7.4S, V23.8H, V4.8H
    SQRDMLAH V17.8H, V4.8H, V7.H[0x5]
    SQRDMLAH V4.8H, V10.8H, V30.8H
    SDOT V13.2S, V6.8B, V18.4B[0x0]
    UDOT V0.4S, V24.16B, V21.16B
    BFDOT V22.4S, V4.8H, V26.8H
    BFCVTN2 V2.8H, V0.4S
    SQRDMLAH V24.4S, V28.4S, V9.S[0x2]
    BFMMLA V1.4S, V5.8H, V27.8H
    BFCVTN V15.4H, V13.4S
    UDOT V12.4S, V20.16B, V2.4B[0x3]
    SQRDMLAH V27.4S, V31.4S, V1.4S
    BFMLALT V26.4S, V21.8H, V4.H[0x4]
    SQRDMLAH V7.4H, V26.4H, V15.H[0x2]
    SQRDMLSH V10.4H, V12.4H, V12.H[0x0]
    BFDOT V5.4S, V7.8H, V24.2H[0x1]
    SQRDMLSH V24.4S, V1.4S, V5.S[0x0]
    BFMLALT V9.4S, V24.8H, V11.8H
    SQRDMLSH V1.4S, V17.4S, V21.S[0x0]
    SQRDMLSH V11.8H, V10.8H, V27.8H
    SQRDMLSH V18.4H, V17.4H, V9.H[0x2]
    SQRDMLSH V0.4H, V18.4H, V1.4H
    BFMLALT V30.4S, V29.8H, V3.H[0x2]
    SQRDMLAH V31.4S, V0.4S, V16.S[0x0]
    BFMLALB V0.4S, V22.8H, V30.8H
    SDOT V2.2S, V24.8B, V11.8B
    SQRDMLSH V28.4H, V14.4H, V13.H[0x7]
    SDOT V30.2S, V31.8B, V26.4B[0x2]
    UDOT V18.4S, V20.16B, V7.4B[0x2]
    UDOT V26.2S, V18.8B, V14.8B
    BFDOT V10.2S, V27.4H, V8.4H
    BFDOT V4.4S, V2.8H, V0.8H
    BFMLALT V18.4S, V26.8H, V25.8H
    BFDOT V16.2S, V1.4H, V4.4H
    BFMLALB V13.4S, V16.8H, V30.8H
    BFMLALB V3.4S, V18.8H, V13.8H
    BFCVTN V22.4H, V16.4S
    SDOT V7.2S, V22.8B, V16.8B
    SQRDMLAH V22.4S, V7.4S, V7.S[0x0]
    UDOT V13.4S, V22.16B, V28.4B[0x3]
    BFDOT V12.2S, V11.4H, V3.4H
    SQRDMLSH V11.8H, V9.8H, V12.8H
    SDOT V24.4S, V7.16B, V31.16B
    SQRDMLSH V30.4S, V13.4S, V7.S[0x3]
    SQRDMLSH V14.4S, V11.4S, V30.4S
    BFMLALT V13.4S, V20.8H, V14.H[0x0]
    SDOT V7.4S, V24.16B, V13.4B[0x2]
    SQRDMLAH V1.4S, V27.4S, V15.4S
    SQRDMLSH V22.2S, V12.2S, V16.2S
    BFMLALB V13.4S, V24.8H, V1.H[0x2]
    SDOT V30.4S, V7.16B, V3.4B[0x1]
    SDOT V24.2S, V18.8B, V20.8B
    SQRDMLSH V14.2S, V18.2S, V30.2S
    SQRDMLAH V11.2S, V31.2S, V12.S[0x3]
    BFDOT V3.2S, V12.4H, V2.2H[0x0]
    SDOT V7.2S, V13.8B, V31.8B
    BFDOT V31.4S, V10.8H, V4.2H[0x1]
    SQRDMLAH V24.8H, V31.8H, V8.H[0x6]
    BFMLALB V31.4S, V26.8H, V23.8H
    SDOT V18.2S, V30.8B, V29.8B
    SQRDMLSH V8.2S, V11.2S, V18.S[0x3]
    BFDOT V16.4S, V4.8H, V18.8H
    BFDOT V19.2S, V15.4H, V6.2H[0x3]
    UDOT V9.2S, V19.8B, V16.4B[0x2]
    SQRDMLAH V15.4S, V21.4S, V14.S[0x2]
    SQRDMLAH V11.8H, V8.8H, V13.H[0x0]
    UDOT V19.4S, V25.16B, V24.4B[0x1]
    BFMLALT V16.4S, V12.8H, V3.H[0x1]
    SDOT V21.4S, V15.16B, V7.16B
    BFMLALT V23.4S, V29.8H, V21.8H
    SDOT V26.4S, V9.16B, V9.16B
    BFDOT V2.4S, V21.8H, V11.2H[0x2]
    SDOT V3.2S, V26.8B, V22.4B[0x3]
    SDOT V8.4S, V9.16B, V3.16B
    BFDOT V12.4S, V20.8H, V23.2H[0x0]
    BFDOT V6.4S, V1.8H, V20.2H[0x2]
    UDOT V11.2S, V16.8B, V8.8B
    SDOT V29.2S, V1.8B, V2.4B[0x0]
    SQRDMLAH V18.8H, V18.8H, V6.H[0x3]
    BFMMLA V2.4S, V19.8H, V22.8H
    SDOT V15.4S, V9.16B, V18.16B
    SQRDMLSH V4.4H, V26.4H, V8.4H
    SQRDMLAH V6.8H, V20.8H, V29.8H
    BFDOT V25.2S, V6.4H, V4.2H[0x1]
    SQRDMLAH V13.4S, V12.4S, V4.S[0x0]
    UDOT V22.2S, V11.8B, V28.4B[0x0]
    SQRDMLAH V17.8H, V2.8H, V13.H[0x4]
    SQRDMLSH V19.8H, V17.8H, V15.H[0x2]
    BFMLALT V8.4S, V10.8H, V22.8H
    BFDOT V14.2S, V5.4H, V8.2H[0x0]
    SQRDMLSH V18.4H, V24.4H, V10.H[0x0]
    SDOT V12.4S, V10.16B, V5.4B[0x0]
    BFDOT V30.2S, V25.4H, V9.4H
    SQRDMLSH V16.4H, V19.4H, V5.H[0x7]
    SDOT V5.2S, V30.8B, V19.4B[0x0]
    SQRDMLSH V19.4H, V2.4H, V21.4H
    SQRDMLSH V19.8H, V14.8H, V12.8H
    BFMMLA V4.4S, V5.8H, V5.8H
    BFCVTN V17.4H, V18.4S
    SQRDMLAH V29.8H, V16.8H, V14.H[0x5]
    SQRDMLAH V28.2S, V17.2S, V29.S[0x2]
    UDOT V10.4S, V28.16B, V28.4B[0x2]
    SQRDMLAH V18.4S, V26.4S, V20.4S
    SQRDMLSH V9.4H, V4.4H, V18.4H
    BFCVTN2 V22.8H, V30.4S
    SQRDMLSH V12.4H, V24.4H, V0.H[0x3]
    SQRDMLAH V20.2S, V31.2S, V22.2S
    BFCVTN V8.4H, V26.4S
    BFDOT V14.2S, V9.4H, V8.4H
    SQRDMLSH V31.4H, V10.4H, V5.H[0x1]
    SDOT V11.4S, V12.16B, V19.4B[0x2]
    BFCVTN2 V22.8H, V11.4S
    SQRDMLAH V13.4S, V22.4S, V22.4S
    SDOT V20.2S, V4.8B, V31.4B[0x0]
    BFCVTN V24.4H, V8.4S
    SDOT V29.4S, V3.16B, V14.4B[0x1]
    SQRDMLAH V8.4H, V13.4H, V9.H[0x1]
    UDOT V0.4S, V20.16B, V29.16B
    SQRDMLAH V11.4H, V1.4H, V27.4H
    BFDOT V27.2S, V13.4H, V8.2H[0x0]
    UDOT V20.4S, V3.16B, V13.4B[0x3]
    BFDOT V4.4S, V11.8H, V24.2H[0x1]
    SQRDMLSH V22.2S, V4.2S, V20.2S
    BFDOT V8.4S, V22.8H, V8.8H
    BFCVTN V26.4H, V19.4S
    SQRDMLSH V25.4H, V27.4H, V0.H[0x4]
    SDOT V19.4S, V8.16B, V20.4B[0x2]
    BFCVTN2 V29.8H, V25.4S
    BFCVTN2 V11.8H, V19.4S
    SQRDMLAH V17.4H, V11.4H, V19.4H
    SQRDMLSH V27.4H, V29.4H, V26.4H
    UDOT V5.4S, V29.16B, V26.16B
    SDOT V26.4S, V21.16B, V5.4B[0x2]
    SQRDMLSH V0.2S, V19.2S, V27.2S
    SQRDMLSH V14.8H, V19.8H, V14.H[0x0]
    SQRDMLAH V11.4S, V0.4S, V6.4S
    SDOT V25.4S, V16.16B, V31.4B[0x0]
    BFMLALB V16.4S, V7.8H, V9.8H
    UDOT V19.2S, V21.8B, V13.4B[0x3]
    SDOT V27.2S, V4.8B, V22.4B[0x1]
    SQRDMLAH V30.4H, V19.4H, V18.4H
    BFMLALT V25.4S, V24.8H, V11.H[0x1]
    SDOT V7.2S, V10.8B, V27.8B
    BFCVTN V31.4H, V10.4S
    SDOT V0.4S, V9.16B, V19.16B
    SQRDMLAH V10.2S, V25.2S, V16.S[0x2]
    SQRDMLSH V13.4H, V26.4H, V10.4H
    SQRDMLSH V21.4H, V30.4H, V13.H[0x3]
    BFDOT V16.4S, V7.8H, V6.2H[0x2]
    BFDOT V10.4S, V4.8H, V21.8H
    SDOT V27.2S, V0.8B, V20.4B[0x1]
    UDOT V8.4S, V14.16B, V21.4B[0x0]
    SQRDMLAH V13.4H, V15.4H, V5.H[0x1]
    SUBS  X27, X27, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_10
    MOVZ  X6, #0xb16f, LSL #0
    MOVK  X6, #0x5b98, LSL #16
    MOVK  X6, #0xda28, LSL #32
    MOVK  X6, #0x7d5c, LSL #48
    SUB  X5, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0xf9d1, LSL #0
    MOVK  X6, #0x1d24, LSL #16
    MOVK  X6, #0xc1bb, LSL #32
    MOVK  X6, #0x3d6e, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x77cc, LSL #0
    MOVK  X6, #0x15d4, LSL #16
    MOVK  X6, #0x92d2, LSL #32
    MOVK  X6, #0xd6c, LSL #48
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0xd381, LSL #0
    MOVK  X6, #0x9d69, LSL #16
    MOVK  X6, #0x2073, LSL #32
    MOVK  X6, #0x1984, LSL #48
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0xda79, LSL #0
    MOVK  X6, #0x6bf9, LSL #16
    MOVK  X6, #0x7fc0, LSL #32
    MOVK  X6, #0x2be9, LSL #48
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x9744, LSL #0
    MOVK  X6, #0xffdc, LSL #16
    MOVK  X6, #0x36f2, LSL #32
    MOVK  X6, #0x7136, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0xdd57, LSL #0
    MOVK  X6, #0x7ea4, LSL #16
    MOVK  X6, #0xc919, LSL #32
    MOVK  X6, #0x963, LSL #48
    SUB  X5, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x7b3f, LSL #0
    MOVK  X6, #0x89df, LSL #16
    MOVK  X6, #0x622f, LSL #32
    MOVK  X6, #0x2325, LSL #48
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x16b7, LSL #0
    MOVK  X6, #0x16a3, LSL #16
    MOVK  X6, #0xf95c, LSL #32
    MOVK  X6, #0x5b88, LSL #48
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0xb592, LSL #0
    MOVK  X6, #0xc22a, LSL #16
    MOVK  X6, #0x8fc5, LSL #32
    MOVK  X6, #0xf340, LSL #48
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x9055, LSL #0
    MOVK  X6, #0xbc7a, LSL #16
    MOVK  X6, #0xdbe, LSL #32
    MOVK  X6, #0xd2f2, LSL #48
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x50d5, LSL #0
    MOVK  X6, #0x1d2c, LSL #16
    MOVK  X6, #0xf691, LSL #32
    MOVK  X6, #0xc766, LSL #48
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x619a, LSL #0
    MOVK  X6, #0x2e04, LSL #16
    MOVK  X6, #0x1538, LSL #32
    MOVK  X6, #0x5452, LSL #48
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0xa64e, LSL #0
    MOVK  X6, #0x392b, LSL #16
    MOVK  X6, #0x6eff, LSL #32
    MOVK  X6, #0xd7a7, LSL #48
    SUB  X5, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x341a, LSL #0
    MOVK  X6, #0x97eb, LSL #16
    MOVK  X6, #0x2faf, LSL #32
    MOVK  X6, #0x8a6c, LSL #48
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0xfc44, LSL #0
    MOVK  X6, #0x4b9c, LSL #16
    MOVK  X6, #0x6345, LSL #32
    MOVK  X6, #0xf5d9, LSL #48
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x1db, LSL #0
    MOVK  X6, #0x905c, LSL #16
    MOVK  X6, #0xa8b1, LSL #32
    MOVK  X6, #0x6716, LSL #48
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x2927, LSL #0
    MOVK  X6, #0xd6ac, LSL #16
    MOVK  X6, #0xa4ff, LSL #32
    MOVK  X6, #0xe262, LSL #48
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X6, #0x4de6, LSL #0
    MOVK  X6, #0xaf14, LSL #16
    MOVK  X6, #0x5ed9, LSL #32
    MOVK  X6, #0x63df, LSL #48
    SUB  X5, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X6, FPSR
    MOVZ  X5, #0x9d, LSL #0
    MOVK  X5, #0x800, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D0
    MOVZ  X5, #0xd066, LSL #0
    MOVK  X5, #0x8002, LSL #16
    MOVK  X5, #0xde10, LSL #32
    MOVK  X5, #0x22ce, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D1
    MOVZ  X5, #0x6f88, LSL #0
    MOVK  X5, #0x7f02, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D2
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D3
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D4
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D5
    MOVZ  X5, #0xbc9d, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x4e09, LSL #32
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0xf434, LSL #32
    MOVK  X5, #0x5b88, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D6
    MOVZ  X5, #0xb259, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xd992, LSL #32
    MOVK  X5, #0x7fc2, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D7
    MOVZ  X5, #0x4f02, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x8eb3, LSL #32
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D8
    MOVZ  X5, #0x3f80, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x3f80, LSL #32
    MOVK  X5, #0x8000, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D9
    MOVZ  X5, #0x9e02, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x6000, LSL #32
    MOVK  X5, #0x8041, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D10
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xdd21, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D11
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0xdc94, LSL #32
    MOVK  X5, #0x22bc, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D12
    MOVZ  X5, #0x4f01, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x4f01, LSL #32
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D13
    MOVZ  X5, #0x215d, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x238d, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D14
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D15
    MOVZ  X5, #0x216f, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x23a0, LSL #32
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D16
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D17
    MOVZ  X5, #0x64a9, LSL #0
    MOVK  X5, #0x7f80, LSL #16
    MOVK  X5, #0x3c64, LSL #32
    MOVK  X5, #0x1, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D18
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x5eae, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D19
    MOVZ  X5, #0x7df9, LSL #0
    MOVK  X5, #0x80, LSL #16
    MOVK  X5, #0xfc73, LSL #32
    MOVK  X5, #0xdd21, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D20
    MOVZ  X5, #0x8e40, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x12c4, LSL #32
    MOVK  X5, #0xffc6, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D21
    MOVZ  X5, #0x59cf, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x41e7, LSL #32
    MOVK  X5, #0x8000, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D22
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x8521, LSL #32
    MOVK  X5, #0x3b, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0xe1fe, LSL #32
    MOVK  X5, #0xe536, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D23
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D25
    MOVZ  X5, #0xf000, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xf000, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D26
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xdd21, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D27
    MOVZ  X5, #0xd604, LSL #0
    MOVK  X5, #0x7ffe, LSL #16
    MOVK  X5, #0xf64e, LSL #32
    MOVK  X5, #0x7fbf, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D28
    MOVZ  X5, #0xff7e, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0xa405, LSL #32
    MOVK  X5, #0x8000, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X5, #0x7fc0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D29
    MOVZ  X5, #0x1f, LSL #0
    MOVK  X5, #0x5deb, LSL #16
    MOVK  X5, #0xb691, LSL #32
    MOVK  X5, #0xfc41, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D30
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xfd60, LSL #32
    MOVK  X5, #0x5ce1, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X6, D31
    MOVZ  X5, #0x7fc0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
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
    FMOV  D0, X7
    FMOV  V0.D[1], X8
    FMOV  D1, X25
    FMOV  V1.D[1], X12
    FMOV  D2, X20
    FMOV  V2.D[1], X22
    FMOV  D3, X23
    FMOV  V3.D[1], X24
    FMOV  D4, X10
    FMOV  V4.D[1], X29
    FMOV  D5, X28
    FMOV  V5.D[1], X12
    FMOV  D6, X26
    FMOV  V6.D[1], X23
    FMOV  D7, X17
    FMOV  V7.D[1], X27
    FMOV  D8, X8
    FMOV  V8.D[1], X21
    FMOV  D9, X21
    FMOV  V9.D[1], X17
    FMOV  D10, X4
    FMOV  V10.D[1], X2
    FMOV  D11, X5
    FMOV  V11.D[1], X12
    FMOV  D12, X24
    FMOV  V12.D[1], X21
    FMOV  D13, X4
    FMOV  V13.D[1], X24
    FMOV  D14, X22
    FMOV  V14.D[1], X18
    FMOV  D15, X8
    FMOV  V15.D[1], X19
    FMOV  D16, X12
    FMOV  V16.D[1], X16
    FMOV  D17, X6
    FMOV  V17.D[1], X22
    FMOV  D18, X23
    FMOV  V18.D[1], X21
    FMOV  D19, X26
    FMOV  V19.D[1], X16
    FMOV  D20, X19
    FMOV  V20.D[1], X21
    FMOV  D21, X7
    FMOV  V21.D[1], X22
    FMOV  D22, X25
    FMOV  V22.D[1], X27
    FMOV  D23, X5
    FMOV  V23.D[1], X19
    FMOV  D24, X26
    FMOV  V24.D[1], X12
    FMOV  D25, X7
    FMOV  V25.D[1], X17
    FMOV  D26, X22
    FMOV  V26.D[1], X17
    FMOV  D27, X22
    FMOV  V27.D[1], X6
    FMOV  D28, X28
    FMOV  V28.D[1], X3
    FMOV  D29, X20
    FMOV  V29.D[1], X16
    FMOV  D30, X3
    FMOV  V30.D[1], X2
    FMOV  D31, X12
    FMOV  V31.D[1], X20
    MOVZ  X27, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_11:
    UDOT V16.4S, V24.16B, V28.4B[0x2]
    SDOT V27.4S, V7.16B, V26.16B
    BFMLALB V3.4S, V9.8H, V12.H[0x3]
    BFDOT V14.2S, V20.4H, V3.4H
    UDOT V22.4S, V31.16B, V31.4B[0x0]
    SQRDMLSH V20.8H, V30.8H, V11.H[0x3]
    BFDOT V16.4S, V27.8H, V20.8H
    BFMLALT V18.4S, V14.8H, V14.H[0x0]
    BFMLALT V10.4S, V22.8H, V2.8H
    SQRDMLAH V7.4S, V22.4S, V16.4S
    BFMMLA V28.4S, V7.8H, V28.8H
    SQRDMLSH V12.8H, V29.8H, V23.8H
    UDOT V30.2S, V25.8B, V25.4B[0x0]
    BFDOT V25.4S, V0.8H, V10.2H[0x1]
    BFMLALT V23.4S, V28.8H, V8.H[0x3]
    UDOT V22.2S, V30.8B, V30.8B
    UDOT V10.4S, V30.16B, V25.16B
    SDOT V7.2S, V18.8B, V18.4B[0x1]
    SQRDMLAH V16.4H, V7.4H, V13.H[0x4]
    UDOT V31.2S, V22.8B, V5.8B
    SQRDMLAH V7.4S, V23.4S, V22.S[0x3]
    SDOT V20.4S, V28.16B, V12.4B[0x1]
    SQRDMLAH V25.8H, V10.8H, V8.H[0x3]
    SQRDMLAH V11.2S, V2.2S, V7.2S
    SQRDMLAH V26.4H, V20.4H, V11.H[0x7]
    SDOT V22.4S, V16.16B, V26.16B
    UDOT V2.2S, V31.8B, V22.8B
    BFDOT V5.4S, V19.8H, V12.8H
    SQRDMLAH V27.4H, V21.4H, V2.H[0x3]
    SQRDMLSH V19.8H, V0.8H, V11.8H
    SQRDMLSH V21.8H, V17.8H, V3.H[0x1]
    SDOT V26.2S, V25.8B, V23.8B
    BFMMLA V16.4S, V25.8H, V2.8H
    SQRDMLAH V7.4S, V28.4S, V17.4S
    UDOT V2.2S, V7.8B, V8.4B[0x0]
    SQRDMLSH V13.4H, V29.4H, V11.4H
    SQRDMLAH V11.4S, V18.4S, V1.S[0x2]
    BFDOT V19.2S, V19.4H, V19.4H
    BFCVTN2 V29.8H, V26.4S
    SQRDMLSH V28.4S, V16.4S, V12.S[0x3]
    SDOT V5.4S, V5.16B, V11.4B[0x3]
    BFCVTN V20.4H, V19.4S
    SQRDMLAH V1.4S, V13.4S, V26.4S
    SDOT V3.4S, V28.16B, V21.4B[0x0]
    SQRDMLAH V19.4S, V15.4S, V20.S[0x0]
    BFCVTN V15.4H, V29.4S
    BFCVTN2 V13.8H, V1.4S
    UDOT V18.2S, V13.8B, V3.4B[0x2]
    BFDOT V16.4S, V27.8H, V28.2H[0x0]
    SDOT V0.2S, V18.8B, V29.8B
    SDOT V13.4S, V16.16B, V21.16B
    UDOT V17.2S, V13.8B, V9.8B
    SDOT V7.4S, V8.16B, V19.16B
    SQRDMLAH V9.4S, V15.4S, V17.4S
    SQRDMLSH V2.2S, V5.2S, V9.S[0x2]
    BFDOT V4.4S, V2.8H, V2.2H[0x0]
    UDOT V17.2S, V15.8B, V22.8B
    UDOT V3.4S, V4.16B, V23.16B
    BFDOT V15.4S, V0.8H, V7.8H
    SQRDMLAH V27.2S, V15.2S, V1.2S
    UDOT V6.2S, V27.8B, V19.4B[0x2]
    SQRDMLSH V27.4H, V25.4H, V6.H[0x5]
    SDOT V20.2S, V27.8B, V11.8B
    BFDOT V26.4S, V3.8H, V3.8H
    BFMLALT V5.4S, V7.8H, V17.8H
    SQRDMLSH V18.8H, V13.8H, V5.H[0x1]
    UDOT V28.4S, V31.16B, V2.4B[0x2]
    UDOT V19.4S, V11.16B, V18.4B[0x1]
    UDOT V11.4S, V26.16B, V20.4B[0x2]
    BFMLALT V13.4S, V19.8H, V18.8H
    SQRDMLSH V9.8H, V28.8H, V11.H[0x2]
    BFMLALB V27.4S, V30.8H, V10.H[0x6]
    SDOT V4.2S, V5.8B, V6.4B[0x2]
    BFDOT V5.4S, V0.8H, V5.8H
    SDOT V15.4S, V23.16B, V5.16B
    SDOT V22.2S, V30.8B, V11.8B
    BFDOT V0.4S, V23.8H, V7.8H
    BFMLALT V25.4S, V16.8H, V13.8H
    SQRDMLSH V26.8H, V9.8H, V13.8H
    BFMLALB V3.4S, V7.8H, V30.8H
    UDOT V19.2S, V2.8B, V19.8B
    BFDOT V18.4S, V6.8H, V19.8H
    BFDOT V9.4S, V23.8H, V25.2H[0x1]
    UDOT V11.2S, V0.8B, V18.8B
    SDOT V28.2S, V3.8B, V15.4B[0x0]
    BFMLALB V2.4S, V28.8H, V3.8H
    UDOT V24.2S, V27.8B, V11.4B[0x1]
    SQRDMLAH V5.4H, V2.4H, V26.4H
    UDOT V1.4S, V5.16B, V4.4B[0x3]
    BFMLALT V17.4S, V11.8H, V9.H[0x5]
    SDOT V24.2S, V30.8B, V1.8B
    SQRDMLAH V6.4S, V17.4S, V24.S[0x2]
    SQRDMLAH V25.8H, V30.8H, V11.8H
    BFDOT V16.4S, V3.8H, V3.2H[0x2]
    BFCVTN V5.4H, V15.4S
    UDOT V19.2S, V11.8B, V10.8B
    BFMLALB V17.4S, V18.8H, V10.H[0x5]
    SQRDMLAH V8.4S, V14.4S, V4.4S
    SQRDMLSH V7.4H, V19.4H, V1.H[0x5]
    SDOT V9.4S, V24.16B, V3.4B[0x0]
    UDOT V19.4S, V31.16B, V30.16B
    SDOT V1.4S, V22.16B, V5.16B
    SDOT V23.4S, V7.16B, V17.4B[0x0]
    BFCVTN2 V3.8H, V23.4S
    SDOT V0.2S, V16.8B, V1.4B[0x3]
    BFMLALB V10.4S, V3.8H, V15.H[0x0]
    BFMLALT V15.4S, V19.8H, V9.8H
    BFMLALT V10.4S, V13.8H, V10.H[0x2]
    SDOT V5.4S, V6.16B, V12.16B
    BFDOT V17.4S, V10.8H, V8.2H[0x2]
    BFCVTN V16.4H, V21.4S
    BFDOT V22.4S, V15.8H, V5.8H
    BFMLALT V15.4S, V22.8H, V10.H[0x2]
    SDOT V21.2S, V8.8B, V8.4B[0x2]
    BFMLALB V19.4S, V16.8H, V25.8H
    BFDOT V18.4S, V14.8H, V26.8H
    SQRDMLAH V23.2S, V0.2S, V14.2S
    BFMMLA V12.4S, V17.8H, V8.8H
    BFCVTN V22.4H, V15.4S
    UDOT V7.2S, V21.8B, V26.4B[0x0]
    SQRDMLAH V9.8H, V12.8H, V12.8H
    SDOT V27.2S, V18.8B, V23.4B[0x0]
    BFCVTN V0.4H, V22.4S
    BFCVTN V15.4H, V19.4S
    BFDOT V10.2S, V10.4H, V0.4H
    UDOT V21.4S, V27.16B, V24.16B
    BFMLALB V5.4S, V15.8H, V4.H[0x4]
    BFDOT V23.2S, V10.4H, V11.4H
    BFDOT V24.4S, V21.8H, V23.2H[0x1]
    UDOT V8.2S, V24.8B, V16.4B[0x2]
    BFDOT V21.2S, V9.4H, V9.2H[0x3]
    UDOT V10.2S, V8.8B, V8.8B
    SDOT V27.2S, V20.8B, V23.8B
    SQRDMLAH V1.4H, V5.4H, V10.H[0x7]
    SQRDMLSH V8.2S, V7.2S, V20.2S
    SDOT V26.4S, V8.16B, V1.16B
    UDOT V17.4S, V13.16B, V12.4B[0x0]
    BFDOT V25.4S, V26.8H, V16.2H[0x3]
    SDOT V0.4S, V25.16B, V4.16B
    BFMMLA V7.4S, V27.8H, V27.8H
    SDOT V1.4S, V27.16B, V30.4B[0x3]
    UDOT V18.4S, V17.16B, V0.16B
    SQRDMLSH V15.2S, V18.2S, V28.S[0x0]
    BFMLALB V28.4S, V15.8H, V9.H[0x5]
    SQRDMLAH V18.4H, V16.4H, V4.H[0x1]
    SQRDMLAH V9.4S, V21.4S, V21.S[0x0]
    BFDOT V25.2S, V5.4H, V30.4H
    SDOT V26.2S, V7.8B, V9.8B
    SQRDMLAH V15.8H, V11.8H, V9.8H
    BFMLALT V28.4S, V18.8H, V6.H[0x4]
    BFMMLA V27.4S, V3.8H, V25.8H
    SDOT V8.4S, V25.16B, V8.4B[0x3]
    BFCVTN2 V5.8H, V27.4S
    UDOT V27.4S, V5.16B, V17.4B[0x1]
    BFMLALB V18.4S, V8.8H, V28.8H
    SQRDMLSH V4.4H, V29.4H, V3.H[0x6]
    BFCVTN2 V22.8H, V1.4S
    SQRDMLAH V25.4H, V27.4H, V11.H[0x1]
    BFCVTN2 V3.8H, V4.4S
    BFMLALT V16.4S, V25.8H, V5.H[0x2]
    BFMLALT V6.4S, V31.8H, V6.8H
    UDOT V0.4S, V17.16B, V20.4B[0x3]
    SQRDMLAH V20.4H, V16.4H, V0.H[0x5]
    SQRDMLSH V21.4H, V5.4H, V23.4H
    SQRDMLAH V15.2S, V26.2S, V3.2S
    BFMMLA V16.4S, V5.8H, V17.8H
    SQRDMLAH V9.4S, V22.4S, V6.4S
    BFDOT V0.4S, V15.8H, V2.8H
    SQRDMLAH V30.4H, V21.4H, V18.4H
    SQRDMLAH V24.4H, V9.4H, V0.H[0x0]
    SQRDMLSH V11.2S, V26.2S, V24.2S
    SDOT V26.4S, V17.16B, V30.4B[0x3]
    SDOT V1.4S, V26.16B, V2.4B[0x1]
    SQRDMLSH V29.2S, V0.2S, V8.S[0x1]
    SQRDMLSH V27.4S, V23.4S, V8.S[0x1]
    SQRDMLSH V17.2S, V27.2S, V16.2S
    SQRDMLSH V23.2S, V7.2S, V1.S[0x2]
    UDOT V5.4S, V20.16B, V12.16B
    UDOT V31.4S, V17.16B, V25.4B[0x0]
    SQRDMLSH V9.4S, V11.4S, V5.S[0x0]
    SQRDMLAH V7.2S, V29.2S, V20.2S
    BFDOT V5.4S, V31.8H, V23.2H[0x1]
    SDOT V1.4S, V17.16B, V5.16B
    BFMLALB V2.4S, V2.8H, V9.8H
    SDOT V30.4S, V2.16B, V17.16B
    SQRDMLAH V16.4S, V28.4S, V30.4S
    SQRDMLAH V25.8H, V12.8H, V7.8H
    SDOT V23.2S, V16.8B, V31.4B[0x2]
    SQRDMLAH V7.4H, V25.4H, V9.H[0x1]
    UDOT V11.4S, V1.16B, V23.4B[0x2]
    BFCVTN2 V5.8H, V25.4S
    SDOT V29.4S, V0.16B, V29.16B
    BFMLALT V24.4S, V15.8H, V12.8H
    BFDOT V15.2S, V24.4H, V20.2H[0x3]
    BFDOT V24.2S, V14.4H, V27.4H
    SDOT V14.2S, V20.8B, V20.8B
    BFMMLA V31.4S, V22.8H, V4.8H
    SDOT V2.4S, V4.16B, V23.4B[0x2]
    BFDOT V24.4S, V8.8H, V15.2H[0x2]
    SQRDMLAH V8.4H, V31.4H, V11.4H
    SUBS  X27, X27, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_11
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X26, FPSR
    MOVZ  X24, #0x9d, LSL #0
    MOVK  X24, #0x800, LSL #16
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X26, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
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
    FMOV  D0, X19
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X10
    FMOV  V4.D[1], X16
    FMOV  D5, X6
    FMOV  V5.D[1], X23
    FMOV  D6, X6
    FMOV  V6.D[1], X3
    FMOV  D7, X6
    FMOV  V7.D[1], X23
    FMOV  D8, X3
    FMOV  V8.D[1], X23
    FMOV  D9, X4
    FMOV  V9.D[1], X5
    FMOV  D10, X5
    FMOV  V10.D[1], X23
    FMOV  D11, X18
    FMOV  V11.D[1], X8
    FMOV  D12, X27
    FMOV  V12.D[1], X5
    FMOV  D13, X27
    FMOV  V13.D[1], X19
    FMOV  D14, X7
    FMOV  V14.D[1], X2
    FMOV  D15, X25
    FMOV  V15.D[1], X6
    FMOV  D16, X16
    FMOV  V16.D[1], X4
    FMOV  D17, X19
    FMOV  V17.D[1], X28
    FMOV  D18, X16
    FMOV  V18.D[1], X26
    FMOV  D19, X10
    FMOV  V19.D[1], X8
    FMOV  D20, X19
    FMOV  V20.D[1], X12
    FMOV  D21, X8
    FMOV  V21.D[1], X5
    FMOV  D22, X16
    FMOV  V22.D[1], X23
    FMOV  D23, X20
    FMOV  V23.D[1], X23
    FMOV  D24, X21
    FMOV  V24.D[1], X25
    FMOV  D25, X21
    FMOV  V25.D[1], X12
    FMOV  D26, X4
    FMOV  V26.D[1], X19
    FMOV  D27, X28
    FMOV  V27.D[1], X28
    FMOV  D28, X28
    FMOV  V28.D[1], X10
    FMOV  D29, X23
    FMOV  V29.D[1], X8
    FMOV  D30, X29
    FMOV  V30.D[1], X27
    FMOV  D31, X29
    FMOV  V31.D[1], X2
    MOVZ  X20, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_12:
    BFDOT V4.4S, V23.8H, V30.8H
    BFCVTN2 V27.8H, V22.4S
    BFMLALB V5.4S, V26.8H, V4.H[0x0]
    SQRDMLSH V22.8H, V3.8H, V0.H[0x6]
    BFCVTN2 V5.8H, V22.4S
    BFDOT V16.4S, V31.8H, V28.2H[0x0]
    SQRDMLAH V14.4H, V29.4H, V6.H[0x2]
    UDOT V7.2S, V24.8B, V14.4B[0x2]
    BFDOT V28.2S, V0.4H, V5.4H
    UDOT V13.4S, V6.16B, V15.4B[0x2]
    SQRDMLSH V15.8H, V16.8H, V7.H[0x6]
    UDOT V27.4S, V15.16B, V29.16B
    SQRDMLSH V7.2S, V12.2S, V13.2S
    BFMLALT V15.4S, V27.8H, V28.8H
    BFDOT V31.2S, V15.4H, V5.4H
    BFDOT V12.2S, V2.4H, V7.2H[0x2]
    SDOT V22.2S, V12.8B, V9.4B[0x0]
    UDOT V16.2S, V26.8B, V22.4B[0x0]
    SQRDMLAH V4.4S, V30.4S, V31.S[0x1]
    SQRDMLSH V12.4S, V28.4S, V11.S[0x0]
    SQRDMLAH V31.8H, V19.8H, V7.H[0x6]
    SQRDMLSH V26.2S, V9.2S, V7.2S
    SQRDMLAH V13.2S, V10.2S, V16.S[0x0]
    SQRDMLAH V30.2S, V20.2S, V31.S[0x1]
    SQRDMLAH V4.4S, V15.4S, V3.4S
    BFMLALB V11.4S, V30.8H, V24.8H
    BFMLALT V6.4S, V6.8H, V4.H[0x5]
    BFDOT V4.2S, V6.4H, V9.2H[0x3]
    UDOT V19.2S, V20.8B, V31.4B[0x3]
    UDOT V20.2S, V15.8B, V1.8B
    UDOT V30.4S, V29.16B, V29.4B[0x3]
    SQRDMLAH V7.2S, V21.2S, V12.S[0x3]
    BFMMLA V24.4S, V14.8H, V19.8H
    SQRDMLSH V6.8H, V3.8H, V9.H[0x4]
    BFMLALT V28.4S, V30.8H, V30.8H
    SQRDMLAH V15.4H, V7.4H, V11.H[0x4]
    SDOT V27.2S, V15.8B, V28.4B[0x1]
    SQRDMLSH V7.2S, V5.2S, V2.S[0x0]
    SDOT V7.4S, V7.16B, V1.4B[0x2]
    SDOT V5.2S, V4.8B, V26.4B[0x3]
    SDOT V3.4S, V27.16B, V5.4B[0x3]
    SQRDMLSH V19.8H, V28.8H, V6.H[0x0]
    SQRDMLAH V21.4S, V6.4S, V20.4S
    SQRDMLSH V6.8H, V24.8H, V3.H[0x6]
    SDOT V25.2S, V7.8B, V6.8B
    SDOT V10.2S, V21.8B, V12.4B[0x2]
    SQRDMLSH V30.8H, V25.8H, V10.H[0x4]
    SQRDMLSH V1.8H, V16.8H, V30.8H
    BFDOT V26.2S, V16.4H, V1.4H
    UDOT V22.2S, V26.8B, V20.4B[0x3]
    SQRDMLAH V20.4H, V17.4H, V1.H[0x1]
    BFDOT V17.2S, V22.4H, V23.4H
    UDOT V11.4S, V20.16B, V3.16B
    UDOT V28.4S, V11.16B, V11.16B
    BFMLALT V5.4S, V17.8H, V19.8H
    SQRDMLAH V14.8H, V5.8H, V13.H[0x6]
    UDOT V9.2S, V17.8B, V29.4B[0x0]
    BFMLALB V5.4S, V17.8H, V15.H[0x6]
    UDOT V1.2S, V16.8B, V5.8B
    SQRDMLSH V30.2S, V18.2S, V13.2S
    BFDOT V3.4S, V8.8H, V29.8H
    SDOT V17.4S, V31.16B, V21.4B[0x0]
    UDOT V10.2S, V18.8B, V15.4B[0x0]
    SQRDMLSH V24.4S, V10.4S, V23.4S
    UDOT V15.4S, V6.16B, V23.16B
    SQRDMLSH V29.8H, V1.8H, V3.H[0x1]
    SQRDMLAH V20.2S, V9.2S, V9.S[0x0]
    UDOT V11.4S, V20.16B, V13.4B[0x1]
    SQRDMLAH V5.4S, V31.4S, V30.S[0x1]
    SQRDMLSH V9.4S, V28.4S, V5.S[0x0]
    SDOT V28.4S, V24.16B, V17.4B[0x0]
    BFMLALT V6.4S, V15.8H, V8.H[0x3]
    SDOT V31.4S, V29.16B, V11.16B
    SDOT V3.2S, V5.8B, V11.8B
    SDOT V10.4S, V6.16B, V14.4B[0x0]
    UDOT V15.2S, V31.8B, V9.4B[0x1]
    SQRDMLAH V21.8H, V5.8H, V13.H[0x3]
    UDOT V13.2S, V15.8B, V30.8B
    UDOT V26.4S, V8.16B, V21.16B
    BFCVTN V9.4H, V5.4S
    SDOT V24.4S, V26.16B, V20.4B[0x0]
    SQRDMLAH V31.4S, V24.4S, V24.4S
    SQRDMLAH V15.2S, V5.2S, V26.S[0x3]
    BFMLALB V7.4S, V15.8H, V1.H[0x6]
    UDOT V1.4S, V9.16B, V2.4B[0x1]
    SQRDMLSH V14.8H, V28.8H, V4.H[0x3]
    SQRDMLSH V29.4H, V13.4H, V14.4H
    BFMLALB V11.4S, V31.8H, V1.8H
    BFMLALT V9.4S, V10.8H, V7.8H
    BFCVTN2 V5.8H, V29.4S
    SDOT V14.2S, V3.8B, V11.4B[0x0]
    UDOT V29.4S, V18.16B, V27.4B[0x0]
    SQRDMLSH V6.4H, V29.4H, V5.H[0x6]
    BFDOT V20.4S, V23.8H, V14.2H[0x3]
    BFMMLA V23.4S, V29.8H, V11.8H
    SQRDMLAH V11.8H, V24.8H, V6.H[0x7]
    UDOT V13.4S, V11.16B, V11.16B
    UDOT V11.4S, V1.16B, V9.4B[0x0]
    SDOT V2.4S, V30.16B, V11.4B[0x2]
    SDOT V8.2S, V23.8B, V13.8B
    SQRDMLAH V23.4H, V18.4H, V14.H[0x4]
    SDOT V3.4S, V23.16B, V2.16B
    BFDOT V14.4S, V12.8H, V4.8H
    SDOT V11.4S, V25.16B, V14.4B[0x0]
    UDOT V9.2S, V21.8B, V19.8B
    BFMMLA V1.4S, V9.8H, V21.8H
    BFDOT V4.4S, V5.8H, V16.8H
    BFMMLA V13.4S, V20.8H, V9.8H
    BFMLALT V22.4S, V16.8H, V16.8H
    SDOT V26.2S, V6.8B, V22.4B[0x0]
    SQRDMLSH V23.4S, V3.4S, V26.S[0x0]
    SQRDMLAH V26.4S, V1.4S, V23.S[0x3]
    UDOT V3.4S, V12.16B, V24.4B[0x3]
    SQRDMLAH V21.4S, V4.4S, V13.4S
    SQRDMLAH V23.4S, V7.4S, V29.4S
    UDOT V7.4S, V13.16B, V3.16B
    UDOT V19.4S, V9.16B, V11.4B[0x0]
    BFMLALT V20.4S, V8.8H, V9.H[0x1]
    BFDOT V5.2S, V20.4H, V23.4H
    SDOT V8.4S, V20.16B, V26.4B[0x2]
    SDOT V9.2S, V7.8B, V12.8B
    UDOT V11.4S, V11.16B, V21.4B[0x1]
    SQRDMLAH V30.2S, V26.2S, V5.2S
    UDOT V27.2S, V30.8B, V3.8B
    SDOT V16.2S, V8.8B, V19.8B
    SDOT V7.4S, V9.16B, V27.16B
    SQRDMLAH V20.8H, V15.8H, V11.H[0x6]
    UDOT V27.2S, V20.8B, V25.4B[0x2]
    BFDOT V3.4S, V7.8H, V0.2H[0x0]
    UDOT V4.2S, V10.8B, V3.8B
    BFMLALT V2.4S, V11.8H, V27.8H
    BFDOT V8.2S, V28.4H, V16.2H[0x1]
    UDOT V7.2S, V17.8B, V21.8B
    BFDOT V1.2S, V7.4H, V28.4H
    SQRDMLSH V17.8H, V29.8H, V2.8H
    SQRDMLAH V2.4S, V0.4S, V31.4S
    BFDOT V19.2S, V8.4H, V2.4H
    BFMLALB V12.4S, V4.8H, V17.8H
    SQRDMLAH V29.2S, V30.2S, V4.S[0x1]
    SQRDMLSH V17.4S, V12.4S, V29.4S
    BFCVTN2 V8.8H, V19.4S
    UDOT V16.2S, V18.8B, V7.4B[0x1]
    SQRDMLSH V0.4H, V11.4H, V4.H[0x5]
    BFDOT V27.2S, V1.4H, V8.4H
    BFDOT V31.2S, V0.4H, V16.4H
    SDOT V8.2S, V17.8B, V1.8B
    BFCVTN2 V15.8H, V22.4S
    SQRDMLSH V16.4S, V31.4S, V15.4S
    SDOT V22.2S, V8.8B, V8.8B
    SQRDMLAH V11.4H, V20.4H, V27.4H
    SQRDMLSH V2.4H, V24.4H, V11.H[0x1]
    BFDOT V21.2S, V2.4H, V22.4H
    SQRDMLSH V15.4H, V17.4H, V4.H[0x4]
    SDOT V31.4S, V21.16B, V11.4B[0x2]
    UDOT V19.2S, V2.8B, V11.4B[0x2]
    SQRDMLSH V0.4S, V15.4S, V29.S[0x0]
    BFDOT V11.4S, V10.8H, V22.8H
    UDOT V20.2S, V5.8B, V3.8B
    BFCVTN V28.4H, V0.4S
    BFDOT V22.2S, V14.4H, V28.2H[0x0]
    UDOT V29.4S, V3.16B, V18.16B
    UDOT V7.2S, V25.8B, V8.8B
    BFMLALT V15.4S, V29.8H, V23.8H
    SDOT V24.4S, V15.16B, V27.4B[0x2]
    UDOT V8.2S, V1.8B, V3.4B[0x0]
    UDOT V17.4S, V3.16B, V11.4B[0x0]
    UDOT V30.2S, V8.8B, V4.4B[0x1]
    SDOT V4.4S, V7.16B, V15.4B[0x3]
    UDOT V0.4S, V6.16B, V24.16B
    SQRDMLAH V28.2S, V19.2S, V16.S[0x0]
    UDOT V21.4S, V28.16B, V19.16B
    SQRDMLAH V5.2S, V22.2S, V31.S[0x0]
    UDOT V14.4S, V20.16B, V20.16B
    SQRDMLAH V28.4S, V14.4S, V30.4S
    SQRDMLAH V3.8H, V4.8H, V4.H[0x5]
    UDOT V4.4S, V21.16B, V13.4B[0x1]
    UDOT V20.2S, V28.8B, V23.4B[0x2]
    SQRDMLSH V6.4S, V11.4S, V30.S[0x1]
    SQRDMLSH V4.4S, V20.4S, V3.S[0x1]
    SQRDMLAH V30.2S, V6.2S, V5.S[0x1]
    UDOT V29.4S, V17.16B, V0.4B[0x1]
    BFDOT V21.4S, V13.8H, V3.2H[0x3]
    BFMLALT V5.4S, V11.8H, V4.H[0x5]
    BFMLALB V1.4S, V7.8H, V5.8H
    SQRDMLSH V24.2S, V29.2S, V21.S[0x2]
    SQRDMLAH V0.8H, V1.8H, V4.H[0x2]
    UDOT V4.2S, V30.8B, V0.8B
    BFDOT V29.2S, V12.4H, V2.2H[0x0]
    SDOT V6.2S, V9.8B, V15.8B
    SDOT V5.4S, V12.16B, V4.16B
    SQRDMLAH V13.4H, V5.4H, V3.H[0x2]
    UDOT V27.4S, V1.16B, V23.16B
    SQRDMLSH V1.4H, V7.4H, V3.4H
    SQRDMLSH V28.4H, V25.4H, V6.4H
    BFCVTN V11.4H, V25.4S
    BFCVTN2 V6.8H, V29.4S
    UDOT V9.4S, V14.16B, V27.4B[0x1]
    BFMLALB V25.4S, V29.8H, V11.H[0x7]
    SQRDMLAH V17.2S, V4.2S, V10.2S
    BFDOT V12.4S, V22.8H, V12.8H
    SUBS  X20, X20, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_12
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X2, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X29, FPSR
    MOVZ  X2, #0x9d, LSL #0
    MOVK  X2, #0x800, LSL #16
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D0
    MOVZ  X2, #0x4856, LSL #0
    MOVK  X2, #0x8000, LSL #16
    MOVK  X2, #0xcef3, LSL #32
    MOVK  X2, #0x8000, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D1
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fbd, LSL #16
    MOVK  X2, #0x7fff, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D2
    MOVZ  X2, #0xcaf8, LSL #0
    MOVK  X2, #0x8082, LSL #16
    MOVK  X2, #0x8b8e, LSL #32
    MOVK  X2, #0x8068, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D3
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D4
    MOVZ  X2, #0x674, LSL #0
    MOVK  X2, #0x40, LSL #16
    MOVK  X2, #0x2bd2, LSL #32
    MOVK  X2, #0x40, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D5
    MOVZ  X2, #0xc633, LSL #0
    MOVK  X2, #0x7fff, LSL #16
    MOVK  X2, #0x1691, LSL #32
    MOVK  X2, #0x8000, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X2, #0x7fc0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D6
    MOVZ  X2, #0xdea9, LSL #0
    MOVK  X2, #0x7fff, LSL #16
    MOVK  X2, #0xc900, LSL #32
    MOVK  X2, #0x7fff, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D7
    MOVZ  X2, #0x4dd7, LSL #0
    MOVK  X2, #0x3, LSL #16
    MOVK  X2, #0xfc26, LSL #32
    MOVK  X2, #0xff81, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D8
    MOVZ  X2, #0xe42, LSL #0
    MOVK  X2, #0x7fc1, LSL #16
    MOVK  X2, #0xe42, LSL #32
    MOVK  X2, #0x7fc1, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D9
    MOVZ  X2, #0xb6b9, LSL #0
    MOVK  X2, #0x8001, LSL #16
    MOVK  X2, #0x553e, LSL #32
    MOVK  X2, #0x2, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X2, #0x4a17, LSL #0
    MOVK  X2, #0x284d, LSL #32
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D10
    MOVZ  X2, #0x323c, LSL #0
    MOVK  X2, #0x18, LSL #16
    MOVK  X2, #0x7dbf, LSL #32
    MOVK  X2, #0x19, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D11
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D12
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D13
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D14
    MOVZ  X2, #0x7663, LSL #0
    MOVK  X2, #0x7fc1, LSL #16
    MOVK  X2, #0x7663, LSL #32
    MOVK  X2, #0x7fc1, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D15
    MOVZ  X2, #0x3733, LSL #0
    MOVK  X2, #0xfffb, LSL #16
    MOVK  X2, #0x81a4, LSL #32
    MOVK  X2, #0x7fca, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D16
    MOVZ  X2, #0xb749, LSL #0
    MOVK  X2, #0x7fc7, LSL #16
    MOVK  X2, #0xa54e, LSL #32
    MOVK  X2, #0x38, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D17
    MOVZ  X2, #0xdb1a, LSL #0
    MOVK  X2, #0x8000, LSL #16
    MOVK  X2, #0xdbc8, LSL #32
    MOVK  X2, #0x8000, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D18
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D19
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D20
    MOVZ  X2, #0xcf01, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0xcf01, LSL #32
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D21
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D22
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D23
    MOVZ  X2, #0x3077, LSL #0
    MOVK  X2, #0x3e, LSL #16
    MOVK  X2, #0x5b1, LSL #32
    MOVK  X2, #0x8082, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D24
    MOVZ  X2, #0x334f, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x5afe, LSL #32
    MOVK  X2, #0x7fd9, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D25
    MOVZ  X2, #0x8b6, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xe0f5, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D26
    MOVZ  X2, #0xd30, LSL #0
    MOVK  X2, #0x7fc2, LSL #16
    MOVK  X2, #0xfbe8, LSL #32
    MOVK  X2, #0x7fc2, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D27
    MOVZ  X2, #0x2e80, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0xa100, LSL #32
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D28
    MOVZ  X2, #0x245, LSL #0
    MOVK  X2, #0x8001, LSL #16
    MOVK  X2, #0x5171, LSL #32
    MOVK  X2, #0xffc8, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D29
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D30
    MOVZ  X2, #0x23a, LSL #0
    MOVK  X2, #0x1, LSL #16
    MOVK  X2, #0x23a, LSL #32
    MOVK  X2, #0x1, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X29, D31
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X3, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X22
    FMOV  D1, X6
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X25
    FMOV  D4, X23
    FMOV  V4.D[1], X25
    FMOV  D5, X24
    FMOV  V5.D[1], X16
    FMOV  D6, X25
    FMOV  V6.D[1], X17
    FMOV  D7, X27
    FMOV  V7.D[1], X6
    FMOV  D8, X20
    FMOV  V8.D[1], X29
    FMOV  D9, X8
    FMOV  V9.D[1], X2
    FMOV  D10, X20
    FMOV  V10.D[1], X25
    FMOV  D11, X2
    FMOV  V11.D[1], X23
    FMOV  D12, X22
    FMOV  V12.D[1], X25
    FMOV  D13, X23
    FMOV  V13.D[1], X6
    FMOV  D14, X24
    FMOV  V14.D[1], X16
    FMOV  D15, X26
    FMOV  V15.D[1], X16
    FMOV  D16, X17
    FMOV  V16.D[1], X27
    FMOV  D17, X17
    FMOV  V17.D[1], X20
    FMOV  D18, X16
    FMOV  V18.D[1], X10
    FMOV  D19, X7
    FMOV  V19.D[1], X8
    FMOV  D20, X3
    FMOV  V20.D[1], X20
    FMOV  D21, X10
    FMOV  V21.D[1], X16
    FMOV  D22, X12
    FMOV  V22.D[1], X3
    FMOV  D23, X7
    FMOV  V23.D[1], X10
    FMOV  D24, X19
    FMOV  V24.D[1], X8
    FMOV  D25, X27
    FMOV  V25.D[1], X29
    FMOV  D26, X27
    FMOV  V26.D[1], X22
    FMOV  D27, X28
    FMOV  V27.D[1], X18
    FMOV  D28, X27
    FMOV  V28.D[1], X7
    FMOV  D29, X10
    FMOV  V29.D[1], X20
    FMOV  D30, X24
    FMOV  V30.D[1], X20
    FMOV  D31, X2
    FMOV  V31.D[1], X27
    MOVZ  X26, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_13:
    BFDOT V30.2S, V10.4H, V23.4H
    SQRDMLSH V9.8H, V31.8H, V14.H[0x2]
    SQRDMLAH V25.2S, V10.2S, V29.S[0x1]
    BFMLALT V30.4S, V6.8H, V22.8H
    BFDOT V23.2S, V12.4H, V11.2H[0x0]
    BFMLALB V13.4S, V27.8H, V26.8H
    SDOT V29.4S, V19.16B, V13.16B
    BFDOT V21.4S, V19.8H, V8.8H
    SDOT V18.2S, V21.8B, V24.4B[0x3]
    SDOT V8.2S, V27.8B, V28.4B[0x2]
    SQRDMLAH V26.2S, V8.2S, V18.2S
    SDOT V10.2S, V9.8B, V26.4B[0x0]
    BFMLALB V12.4S, V2.8H, V30.8H
    UDOT V8.2S, V29.8B, V23.4B[0x2]
    BFCVTN V22.4H, V15.4S
    BFMLALB V28.4S, V27.8H, V24.8H
    BFMLALT V18.4S, V24.8H, V25.8H
    BFDOT V2.4S, V28.8H, V18.8H
    UDOT V27.2S, V14.8B, V8.4B[0x2]
    SQRDMLAH V30.2S, V12.2S, V23.S[0x2]
    SDOT V18.4S, V10.16B, V26.4B[0x0]
    SDOT V13.4S, V28.16B, V27.16B
    BFDOT V11.2S, V22.4H, V31.2H[0x1]
    SQRDMLAH V31.2S, V5.2S, V17.2S
    BFCVTN V21.4H, V18.4S
    SQRDMLSH V22.8H, V13.8H, V10.8H
    BFDOT V18.4S, V29.8H, V9.2H[0x3]
    BFDOT V8.4S, V21.8H, V2.2H[0x3]
    BFCVTN V20.4H, V31.4S
    UDOT V3.4S, V24.16B, V10.16B
    BFDOT V15.4S, V31.8H, V24.2H[0x1]
    BFMLALT V13.4S, V8.8H, V11.H[0x0]
    SDOT V3.4S, V13.16B, V27.16B
    BFCVTN V5.4H, V18.4S
    BFDOT V24.4S, V22.8H, V20.8H
    BFDOT V18.4S, V10.8H, V25.2H[0x2]
    SQRDMLAH V19.4H, V3.4H, V3.H[0x4]
    SQRDMLAH V10.4H, V23.4H, V9.4H
    BFMMLA V14.4S, V24.8H, V19.8H
    BFMLALB V19.4S, V10.8H, V10.H[0x4]
    SQRDMLAH V5.8H, V15.8H, V0.H[0x2]
    SDOT V23.2S, V5.8B, V18.4B[0x0]
    SQRDMLSH V12.4S, V20.4S, V19.S[0x2]
    UDOT V0.2S, V14.8B, V23.4B[0x1]
    BFMLALT V5.4S, V17.8H, V7.H[0x6]
    BFMLALB V23.4S, V0.8H, V5.H[0x7]
    SQRDMLAH V25.4H, V25.4H, V23.4H
    BFCVTN V7.4H, V4.4S
    SQRDMLSH V2.4H, V25.4H, V8.H[0x7]
    BFMLALB V7.4S, V12.8H, V12.8H
    BFDOT V0.2S, V2.4H, V2.2H[0x3]
    SQRDMLSH V20.4H, V0.4H, V23.4H
    BFMLALT V17.4S, V20.8H, V10.8H
    SQRDMLSH V9.8H, V27.8H, V7.H[0x7]
    SQRDMLSH V18.2S, V11.2S, V13.2S
    SQRDMLAH V14.4H, V26.4H, V7.H[0x1]
    SQRDMLSH V25.2S, V8.2S, V18.S[0x2]
    SQRDMLSH V13.2S, V30.2S, V15.S[0x0]
    SQRDMLSH V24.4S, V25.4S, V9.S[0x1]
    SQRDMLSH V10.4S, V21.4S, V16.4S
    BFMLALB V27.4S, V11.8H, V19.8H
    UDOT V26.2S, V29.8B, V1.4B[0x2]
    UDOT V11.2S, V16.8B, V18.8B
    BFDOT V3.2S, V30.4H, V22.4H
    UDOT V8.2S, V3.8B, V25.8B
    BFDOT V17.2S, V26.4H, V14.4H
    SQRDMLSH V5.2S, V8.2S, V24.S[0x2]
    SQRDMLSH V23.2S, V10.2S, V11.2S
    BFCVTN V30.4H, V17.4S
    UDOT V20.4S, V2.16B, V31.4B[0x2]
    SDOT V17.4S, V13.16B, V24.16B
    BFDOT V10.4S, V30.8H, V20.8H
    BFMLALB V12.4S, V27.8H, V10.H[0x3]
    SQRDMLAH V15.8H, V25.8H, V5.H[0x6]
    SQRDMLAH V2.4S, V15.4S, V12.4S
    UDOT V11.2S, V23.8B, V17.8B
    SDOT V5.2S, V15.8B, V31.4B[0x0]
    BFCVTN V13.4H, V11.4S
    BFCVTN2 V17.8H, V31.4S
    BFDOT V26.4S, V12.8H, V5.8H
    SQRDMLSH V23.4H, V6.4H, V5.4H
    SDOT V25.4S, V17.16B, V4.16B
    BFCVTN V18.4H, V2.4S
    SQRDMLSH V11.4H, V12.4H, V11.H[0x5]
    SQRDMLSH V5.8H, V2.8H, V26.8H
    SDOT V19.2S, V22.8B, V19.4B[0x1]
    SQRDMLAH V12.4H, V19.4H, V4.H[0x5]
    SDOT V19.4S, V14.16B, V11.4B[0x3]
    SQRDMLAH V23.4S, V20.4S, V4.S[0x0]
    SQRDMLAH V21.8H, V30.8H, V28.8H
    BFMLALT V30.4S, V0.8H, V1.H[0x2]
    SQRDMLAH V1.2S, V31.2S, V9.S[0x1]
    BFDOT V1.2S, V19.4H, V19.4H
    SDOT V15.2S, V25.8B, V26.8B
    SQRDMLAH V2.4S, V1.4S, V4.S[0x1]
    SQRDMLSH V20.8H, V21.8H, V7.H[0x2]
    SQRDMLSH V1.4S, V12.4S, V21.4S
    SQRDMLAH V8.4S, V20.4S, V15.4S
    SQRDMLAH V7.4S, V18.4S, V30.S[0x0]
    SDOT V28.2S, V2.8B, V23.8B
    BFMLALT V24.4S, V28.8H, V7.8H
    UDOT V17.4S, V24.16B, V22.16B
    SQRDMLAH V14.4H, V6.4H, V8.H[0x0]
    UDOT V2.4S, V17.16B, V5.4B[0x1]
    SQRDMLSH V6.4H, V8.4H, V8.4H
    SDOT V17.4S, V6.16B, V5.16B
    SQRDMLAH V8.4H, V1.4H, V2.H[0x1]
    SDOT V20.4S, V13.16B, V31.4B[0x0]
    SQRDMLAH V6.8H, V20.8H, V27.8H
    BFDOT V22.4S, V14.8H, V18.8H
    UDOT V28.2S, V22.8B, V29.8B
    BFCVTN V31.4H, V5.4S
    BFDOT V2.2S, V24.4H, V31.4H
    BFMLALT V29.4S, V28.8H, V28.8H
    BFDOT V12.2S, V6.4H, V2.4H
    SQRDMLSH V15.8H, V8.8H, V29.8H
    UDOT V30.4S, V15.16B, V31.4B[0x2]
    BFDOT V13.4S, V17.8H, V12.8H
    SQRDMLSH V18.4S, V9.4S, V18.S[0x1]
    BFCVTN2 V2.8H, V9.4S
    SDOT V7.2S, V19.8B, V27.4B[0x2]
    SDOT V22.4S, V0.16B, V0.4B[0x1]
    SQRDMLSH V5.8H, V8.8H, V15.H[0x0]
    SDOT V0.2S, V31.8B, V14.8B
    BFDOT V29.4S, V15.8H, V2.2H[0x3]
    UDOT V8.2S, V10.8B, V13.8B
    SQRDMLSH V22.2S, V13.2S, V22.S[0x0]
    BFCVTN2 V6.8H, V21.4S
    SQRDMLSH V19.8H, V6.8H, V29.8H
    SQRDMLSH V23.4S, V12.4S, V7.S[0x2]
    SQRDMLAH V10.8H, V0.8H, V8.H[0x6]
    SDOT V27.4S, V10.16B, V21.4B[0x1]
    BFDOT V8.4S, V31.8H, V4.8H
    SDOT V24.4S, V8.16B, V22.16B
    SQRDMLSH V1.4S, V4.4S, V19.S[0x1]
    BFDOT V4.4S, V15.8H, V23.8H
    SQRDMLAH V17.8H, V12.8H, V4.H[0x2]
    UDOT V0.4S, V24.16B, V18.16B
    SDOT V31.4S, V5.16B, V17.16B
    UDOT V2.2S, V27.8B, V22.4B[0x3]
    SDOT V21.4S, V30.16B, V0.16B
    BFMLALB V19.4S, V25.8H, V1.H[0x3]
    BFMMLA V5.4S, V11.8H, V19.8H
    BFMLALT V17.4S, V9.8H, V21.8H
    BFMLALB V29.4S, V15.8H, V2.8H
    SQRDMLSH V4.4S, V3.4S, V5.S[0x1]
    SQRDMLAH V6.4H, V17.4H, V11.H[0x7]
    UDOT V27.4S, V7.16B, V7.4B[0x0]
    SQRDMLAH V24.2S, V31.2S, V22.S[0x0]
    SDOT V25.4S, V4.16B, V25.4B[0x2]
    SDOT V5.4S, V24.16B, V30.4B[0x3]
    BFDOT V1.2S, V19.4H, V30.2H[0x3]
    SQRDMLAH V18.8H, V25.8H, V11.H[0x6]
    SDOT V3.2S, V18.8B, V1.8B
    BFDOT V15.2S, V25.4H, V29.4H
    UDOT V12.2S, V27.8B, V27.4B[0x2]
    UDOT V1.4S, V17.16B, V3.4B[0x2]
    BFDOT V8.2S, V24.4H, V28.4H
    SDOT V0.4S, V12.16B, V0.16B
    SQRDMLSH V25.4S, V29.4S, V21.S[0x3]
    SDOT V9.2S, V24.8B, V6.8B
    SQRDMLAH V19.2S, V25.2S, V24.S[0x3]
    SQRDMLAH V31.2S, V19.2S, V15.S[0x0]
    BFCVTN V11.4H, V4.4S
    UDOT V6.2S, V0.8B, V31.4B[0x2]
    SDOT V18.2S, V10.8B, V12.8B
    BFMLALB V24.4S, V6.8H, V15.H[0x3]
    SDOT V2.2S, V24.8B, V14.4B[0x0]
    BFDOT V27.4S, V18.8H, V31.2H[0x1]
    SQRDMLAH V22.8H, V8.8H, V0.H[0x4]
    SQRDMLSH V7.8H, V5.8H, V5.H[0x3]
    BFDOT V29.4S, V7.8H, V1.2H[0x3]
    SQRDMLAH V14.4H, V4.4H, V11.H[0x0]
    BFMLALB V3.4S, V9.8H, V14.H[0x0]
    UDOT V7.4S, V22.16B, V10.16B
    SQRDMLAH V8.8H, V2.8H, V2.H[0x1]
    SDOT V31.2S, V3.8B, V8.8B
    BFMLALT V11.4S, V4.8H, V5.H[0x7]
    BFMMLA V21.4S, V7.8H, V19.8H
    SDOT V22.4S, V20.16B, V12.16B
    BFDOT V19.4S, V31.8H, V22.2H[0x3]
    SQRDMLSH V0.4S, V2.4S, V11.S[0x1]
    UDOT V21.2S, V26.8B, V29.8B
    SQRDMLAH V15.4S, V21.4S, V8.S[0x3]
    SQRDMLAH V5.2S, V24.2S, V15.2S
    UDOT V21.4S, V16.16B, V19.4B[0x3]
    UDOT V26.2S, V0.8B, V19.8B
    SQRDMLSH V23.4S, V18.4S, V21.4S
    SQRDMLSH V14.4S, V19.4S, V5.4S
    SQRDMLAH V10.4H, V26.4H, V6.H[0x3]
    SDOT V20.4S, V23.16B, V4.4B[0x3]
    SQRDMLSH V5.8H, V10.8H, V10.H[0x0]
    UDOT V22.4S, V27.16B, V20.16B
    UDOT V16.2S, V22.8B, V30.8B
    UDOT V22.4S, V24.16B, V29.16B
    UDOT V27.2S, V4.8B, V16.8B
    BFMLALB V15.4S, V31.8H, V2.H[0x5]
    UDOT V26.2S, V14.8B, V25.8B
    SQRDMLSH V30.4H, V15.4H, V24.4H
    SQRDMLAH V9.4H, V4.4H, V5.H[0x7]
    SUBS  X26, X26, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_13
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X19, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X28, FPSR
    MOVZ  X19, #0x9d, LSL #0
    MOVK  X19, #0x800, LSL #16
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D0
    MOVZ  X19, #0x5ff0, LSL #0
    MOVK  X19, #0x42, LSL #16
    MOVK  X19, #0x1fa3, LSL #32
    MOVK  X19, #0x40, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D1
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D2
    MOVZ  X19, #0x1dd4, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0xf66, LSL #32
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D3
    MOVZ  X19, #0x3f41, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D4
    MOVZ  X19, #0xe000, LSL #0
    MOVK  X19, #0x3f, LSL #16
    MOVK  X19, #0xe000, LSL #32
    MOVK  X19, #0x3f, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D5
    MOVZ  X19, #0xecdb, LSL #0
    MOVK  X19, #0x7fff, LSL #16
    MOVK  X19, #0xf4fa, LSL #32
    MOVK  X19, #0x4e7f, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D6
    MOVZ  X19, #0x8000, LSL #0
    MOVK  X19, #0x8000, LSL #16
    MOVK  X19, #0xd1fa, LSL #32
    MOVK  X19, #0x8000, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8080, LSL #16
    MOVK  X19, #0x8080, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D7
    MOVZ  X19, #0x2f3f, LSL #0
    MOVK  X19, #0x40, LSL #16
    MOVK  X19, #0xf597, LSL #32
    MOVK  X19, #0xdadc, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D8
    MOVZ  X19, #0x1dc5, LSL #0
    MOVK  X19, #0x7fff, LSL #16
    MOVK  X19, #0xf5e, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D9
    MOVZ  X19, #0x7349, LSL #0
    MOVK  X19, #0xed64, LSL #16
    MOVK  X19, #0x2299, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D10
    MOVZ  X19, #0xce80, LSL #0
    MOVK  X19, #0xe380, LSL #32
    MOVK  X19, #0x8000, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D11
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D12
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D13
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D14
    MOVZ  X19, #0xbe51, LSL #0
    MOVK  X19, #0xb20b, LSL #16
    MOVK  X19, #0xb20c, LSL #32
    MOVK  X19, #0xb20b, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D15
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D16
    MOVZ  X19, #0x3c3d, LSL #0
    MOVK  X19, #0x5a62, LSL #16
    MOVK  X19, #0xc3db, LSL #32
    MOVK  X19, #0x5a5c, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X19, #0x7fff, LSL #0
    MOVK  X19, #0x7fff, LSL #16
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D17
    MOVZ  X19, #0x4dc5, LSL #0
    MOVK  X19, #0x7fc1, LSL #16
    MOVK  X19, #0xbb44, LSL #32
    MOVK  X19, #0x7fc1, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D18
    MOVZ  X19, #0xcf00, LSL #0
    MOVK  X19, #0x7fff, LSL #16
    MOVK  X19, #0xde9b, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D19
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D20
    MOVZ  X19, #0x7ea9, LSL #0
    MOVK  X19, #0xa687, LSL #16
    MOVK  X19, #0xa140, LSL #32
    MOVK  X19, #0x8000, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D21
    MOVZ  X19, #0xcf01, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0xcf01, LSL #32
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X19, #0x7026, LSL #0
    MOVK  X19, #0x7026, LSL #32
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D22
    MOVZ  X19, #0x879d, LSL #0
    MOVK  X19, #0x41, LSL #16
    MOVK  X19, #0xc471, LSL #32
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D23
    MOVZ  X19, #0xf21a, LSL #0
    MOVK  X19, #0x3e, LSL #16
    MOVK  X19, #0xe0d5, LSL #32
    MOVK  X19, #0x7fbf, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D24
    MOVZ  X19, #0x7874, LSL #0
    MOVK  X19, #0x7fff, LSL #16
    MOVK  X19, #0xffe2, LSL #32
    MOVK  X19, #0x7fff, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X19, #0x52f8, LSL #0
    MOVK  X19, #0xfa60, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D25
    MOVZ  X19, #0xc915, LSL #0
    MOVK  X19, #0x8000, LSL #16
    MOVK  X19, #0x526, LSL #32
    MOVK  X19, #0x8000, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D26
    MOVZ  X19, #0x2653, LSL #0
    MOVK  X19, #0x7fc1, LSL #16
    MOVK  X19, #0x8e42, LSL #32
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D27
    MOVZ  X19, #0x4c9e, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0xc144, LSL #32
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D28
    MOVZ  X19, #0x6260, LSL #0
    MOVK  X19, #0x7fc7, LSL #16
    MOVK  X19, #0x8b6e, LSL #32
    MOVK  X19, #0xfff1, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X19, #0x7788, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x7788, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D29
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D30
    MOVZ  X19, #0x7fc0, LSL #0
    MOVK  X19, #0x1, LSL #16
    MOVK  X19, #0x1, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X28, D31
    MOVZ  X19, #0xf0d6, LSL #0
    MOVK  X19, #0x7f, LSL #16
    MOVK  X19, #0x24e4, LSL #32
    MOVK  X19, #0x7fbf, LSL #48
    SUB  X3, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
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
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  D0, X3
    FMOV  V0.D[1], X25
    FMOV  D1, X21
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X4
    FMOV  D3, X26
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X20
    FMOV  D5, X28
    FMOV  V5.D[1], X12
    FMOV  D6, X7
    FMOV  V6.D[1], X4
    FMOV  D7, X26
    FMOV  V7.D[1], X3
    FMOV  D8, X4
    FMOV  V8.D[1], X4
    FMOV  D9, X25
    FMOV  V9.D[1], X29
    FMOV  D10, X8
    FMOV  V10.D[1], X24
    FMOV  D11, X16
    FMOV  V11.D[1], X10
    FMOV  D12, X12
    FMOV  V12.D[1], X27
    FMOV  D13, X12
    FMOV  V13.D[1], X16
    FMOV  D14, X4
    FMOV  V14.D[1], X5
    FMOV  D15, X6
    FMOV  V15.D[1], X23
    FMOV  D16, X21
    FMOV  V16.D[1], X27
    FMOV  D17, X6
    FMOV  V17.D[1], X12
    FMOV  D18, X18
    FMOV  V18.D[1], X4
    FMOV  D19, X29
    FMOV  V19.D[1], X21
    FMOV  D20, X26
    FMOV  V20.D[1], X10
    FMOV  D21, X6
    FMOV  V21.D[1], X10
    FMOV  D22, X16
    FMOV  V22.D[1], X5
    FMOV  D23, X25
    FMOV  V23.D[1], X29
    FMOV  D24, X28
    FMOV  V24.D[1], X28
    FMOV  D25, X18
    FMOV  V25.D[1], X29
    FMOV  D26, X5
    FMOV  V26.D[1], X18
    FMOV  D27, X29
    FMOV  V27.D[1], X5
    FMOV  D28, X5
    FMOV  V28.D[1], X18
    FMOV  D29, X3
    FMOV  V29.D[1], X27
    FMOV  D30, X16
    FMOV  V30.D[1], X10
    FMOV  D31, X2
    FMOV  V31.D[1], X27
    MOVZ  X17, #0xa, LSL #0
LCRTAdvsimdVectorRdmBF16Dotprod_label_14:
    SDOT V10.2S, V27.8B, V28.8B
    SDOT V28.4S, V26.16B, V25.16B
    UDOT V23.4S, V30.16B, V23.16B
    SQRDMLAH V12.8H, V28.8H, V24.8H
    SQRDMLAH V1.8H, V12.8H, V31.8H
    SQRDMLSH V12.4S, V23.4S, V22.S[0x2]
    SDOT V20.4S, V10.16B, V1.16B
    SDOT V25.2S, V20.8B, V12.4B[0x0]
    SQRDMLAH V6.8H, V21.8H, V11.H[0x3]
    UDOT V27.4S, V25.16B, V6.4B[0x0]
    BFDOT V16.2S, V19.4H, V28.4H
    BFMLALT V20.4S, V24.8H, V29.8H
    SQRDMLAH V30.4H, V18.4H, V30.4H
    SQRDMLAH V28.4H, V5.4H, V8.H[0x1]
    UDOT V26.4S, V2.16B, V7.4B[0x3]
    SDOT V7.4S, V31.16B, V31.16B
    SQRDMLAH V29.2S, V21.2S, V2.S[0x1]
    SDOT V31.2S, V4.8B, V3.8B
    UDOT V2.4S, V10.16B, V29.4B[0x2]
    SQRDMLAH V6.4H, V20.4H, V10.H[0x6]
    BFMLALB V24.4S, V26.8H, V6.H[0x2]
    SDOT V3.2S, V28.8B, V19.8B
    SDOT V4.2S, V3.8B, V31.8B
    SQRDMLAH V29.8H, V12.8H, V7.H[0x5]
    SDOT V20.2S, V24.8B, V30.8B
    SQRDMLAH V25.4S, V2.4S, V27.4S
    SDOT V31.2S, V13.8B, V25.8B
    SQRDMLSH V12.4H, V28.4H, V28.4H
    BFMLALT V21.4S, V4.8H, V4.H[0x1]
    BFMMLA V13.4S, V29.8H, V4.8H
    SQRDMLAH V25.4H, V13.4H, V22.4H
    BFDOT V19.4S, V13.8H, V12.2H[0x0]
    SQRDMLSH V26.4H, V31.4H, V4.H[0x6]
    UDOT V2.2S, V26.8B, V15.4B[0x2]
    UDOT V18.2S, V2.8B, V21.8B
    SQRDMLSH V13.8H, V25.8H, V1.H[0x6]
    BFMLALB V7.4S, V3.8H, V3.H[0x4]
    SQRDMLSH V6.8H, V30.8H, V20.8H
    SQRDMLSH V30.8H, V7.8H, V15.H[0x6]
    SDOT V28.2S, V22.8B, V6.8B
    BFMLALT V31.4S, V7.8H, V20.8H
    UDOT V20.2S, V28.8B, V27.8B
    SDOT V24.2S, V19.8B, V22.4B[0x1]
    SQRDMLSH V7.4S, V20.4S, V31.4S
    BFDOT V26.2S, V13.4H, V30.4H
    BFDOT V22.2S, V17.4H, V7.4H
    UDOT V13.4S, V22.16B, V1.4B[0x0]
    SQRDMLSH V3.4H, V19.4H, V2.H[0x0]
    UDOT V28.4S, V3.16B, V16.4B[0x2]
    UDOT V27.4S, V28.16B, V5.4B[0x1]
    SQRDMLAH V16.8H, V18.8H, V19.8H
    BFMLALB V30.4S, V24.8H, V13.H[0x7]
    BFDOT V18.4S, V16.8H, V30.8H
    SDOT V16.2S, V8.8B, V18.4B[0x3]
    BFDOT V13.4S, V17.8H, V27.2H[0x3]
    BFMLALT V24.4S, V13.8H, V18.8H
    BFCVTN2 V8.8H, V13.4S
    SDOT V17.4S, V8.16B, V16.4B[0x1]
    BFDOT V30.2S, V24.4H, V6.4H
    UDOT V4.2S, V17.8B, V17.8B
    UDOT V2.2S, V5.8B, V4.8B
    BFMLALT V17.4S, V2.8H, V15.H[0x2]
    SDOT V29.2S, V9.8B, V9.4B[0x0]
    UDOT V30.2S, V3.8B, V26.8B
    SDOT V8.4S, V29.16B, V29.4B[0x0]
    UDOT V20.2S, V24.8B, V11.4B[0x1]
    BFDOT V10.2S, V26.4H, V30.4H
    SQRDMLAH V24.4H, V20.4H, V10.H[0x5]
    BFDOT V28.2S, V5.4H, V17.4H
    SQRDMLSH V9.4S, V28.4S, V3.4S
    SDOT V30.4S, V18.16B, V24.4B[0x1]
    BFCVTN2 V27.8H, V30.4S
    BFMLALT V30.4S, V16.8H, V13.8H
    SDOT V26.4S, V27.16B, V30.4B[0x2]
    SDOT V18.4S, V18.16B, V6.4B[0x3]
    SDOT V24.2S, V28.8B, V8.4B[0x3]
    SQRDMLAH V29.2S, V15.2S, V29.2S
    SQRDMLAH V17.2S, V31.2S, V26.2S
    BFMMLA V30.4S, V11.8H, V24.8H
    SQRDMLSH V24.2S, V30.2S, V30.2S
    SDOT V27.4S, V18.16B, V18.4B[0x0]
    SDOT V30.2S, V29.8B, V0.4B[0x1]
    SDOT V21.4S, V24.16B, V24.4B[0x2]
    BFMLALT V24.4S, V3.8H, V17.8H
    SQRDMLSH V29.4H, V22.4H, V7.4H
    BFCVTN2 V31.8H, V21.4S
    SDOT V0.2S, V24.8B, V24.8B
    UDOT V20.4S, V0.16B, V28.4B[0x0]
    SQRDMLAH V6.4H, V29.4H, V9.H[0x0]
    BFMMLA V24.4S, V11.8H, V20.8H
    SQRDMLAH V8.8H, V30.8H, V14.H[0x0]
    SQRDMLAH V11.2S, V12.2S, V31.S[0x3]
    SDOT V31.2S, V27.8B, V24.4B[0x0]
    SDOT V22.4S, V3.16B, V16.4B[0x3]
    SQRDMLAH V6.8H, V31.8H, V1.8H
    SDOT V15.4S, V22.16B, V22.4B[0x0]
    SDOT V27.2S, V30.8B, V7.8B
    BFDOT V16.4S, V8.8H, V11.2H[0x0]
    SQRDMLAH V13.8H, V9.8H, V15.H[0x5]
    SQRDMLAH V24.8H, V23.8H, V15.H[0x0]
    BFMLALT V15.4S, V13.8H, V27.8H
    SQRDMLSH V13.2S, V6.2S, V13.2S
    SQRDMLSH V0.4S, V18.4S, V7.S[0x1]
    BFDOT V24.2S, V17.4H, V8.4H
    SQRDMLAH V29.4H, V24.4H, V15.4H
    SQRDMLAH V30.2S, V31.2S, V16.S[0x2]
    SQRDMLSH V31.8H, V2.8H, V1.H[0x1]
    BFCVTN V22.4H, V0.4S
    SDOT V6.4S, V29.16B, V31.4B[0x3]
    UDOT V23.2S, V14.8B, V6.8B
    BFCVTN2 V3.8H, V13.4S
    SDOT V6.4S, V23.16B, V23.16B
    SQRDMLAH V2.2S, V22.2S, V30.2S
    SQRDMLSH V31.4S, V13.4S, V4.4S
    UDOT V11.2S, V18.8B, V2.8B
    SDOT V16.4S, V22.16B, V6.4B[0x1]
    UDOT V1.4S, V11.16B, V9.16B
    SQRDMLSH V4.8H, V16.8H, V17.8H
    SQRDMLSH V24.8H, V3.8H, V3.H[0x5]
    BFMLALB V16.4S, V24.8H, V0.8H
    SQRDMLAH V3.4S, V28.4S, V16.S[0x0]
    BFDOT V0.2S, V27.4H, V1.2H[0x2]
    BFCVTN2 V5.8H, V4.4S
    SQRDMLSH V1.4H, V5.4H, V4.4H
    SDOT V25.4S, V3.16B, V15.16B
    BFDOT V4.4S, V5.8H, V1.2H[0x1]
    UDOT V7.4S, V31.16B, V4.16B
    UDOT V29.4S, V25.16B, V18.4B[0x0]
    SQRDMLAH V27.4S, V0.4S, V24.S[0x2]
    BFMLALT V14.4S, V27.8H, V21.8H
    SDOT V18.2S, V15.8B, V29.8B
    BFMMLA V25.4S, V16.8H, V18.8H
    BFMLALB V21.4S, V25.8H, V14.H[0x2]
    BFDOT V6.4S, V28.8H, V16.8H
    UDOT V17.4S, V19.16B, V28.16B
    SDOT V3.4S, V4.16B, V30.4B[0x0]
    UDOT V14.2S, V12.8B, V22.8B
    BFDOT V30.4S, V9.8H, V15.8H
    BFMLALB V0.4S, V13.8H, V19.8H
    BFMLALB V1.4S, V4.8H, V16.8H
    SQRDMLSH V29.4S, V30.4S, V3.4S
    BFCVTN V13.4H, V6.4S
    UDOT V24.4S, V21.16B, V9.4B[0x0]
    SQRDMLSH V22.4H, V1.4H, V31.4H
    SQRDMLAH V28.4S, V22.4S, V15.4S
    BFMLALT V7.4S, V0.8H, V0.8H
    SQRDMLAH V27.4S, V22.4S, V29.S[0x3]
    SDOT V0.2S, V4.8B, V13.4B[0x3]
    BFMLALB V4.4S, V24.8H, V28.8H
    SQRDMLAH V22.2S, V4.2S, V14.S[0x2]
    BFDOT V30.4S, V0.8H, V30.2H[0x1]
    BFCVTN V31.4H, V17.4S
    BFMLALT V17.4S, V31.8H, V25.8H
    UDOT V4.4S, V26.16B, V18.4B[0x1]
    BFMLALB V5.4S, V29.8H, V4.H[0x5]
    UDOT V28.4S, V7.16B, V30.16B
    BFMLALT V13.4S, V27.8H, V6.H[0x0]
    SQRDMLSH V26.2S, V19.2S, V28.2S
    UDOT V1.4S, V8.16B, V16.16B
    BFCVTN V7.4H, V22.4S
    UDOT V9.2S, V13.8B, V5.4B[0x0]
    SQRDMLAH V8.2S, V23.2S, V14.S[0x1]
    SQRDMLAH V14.2S, V26.2S, V1.2S
    BFCVTN2 V1.8H, V14.4S
    SDOT V22.2S, V17.8B, V9.8B
    SDOT V26.4S, V5.16B, V7.16B
    BFMLALB V28.4S, V22.8H, V2.H[0x1]
    UDOT V13.2S, V26.8B, V18.4B[0x3]
    UDOT V26.4S, V1.16B, V10.4B[0x0]
    SQRDMLSH V17.4H, V13.4H, V13.H[0x6]
    SQRDMLSH V23.4S, V26.4S, V15.S[0x2]
    BFMLALT V7.4S, V24.8H, V5.H[0x0]
    BFCVTN2 V13.8H, V23.4S
    SQRDMLSH V10.4S, V16.4S, V3.S[0x0]
    BFMMLA V22.4S, V16.8H, V28.8H
    UDOT V27.2S, V7.8B, V22.8B
    SQRDMLAH V15.4S, V8.4S, V27.4S
    SQRDMLAH V2.8H, V7.8H, V15.8H
    SQRDMLAH V14.8H, V10.8H, V8.H[0x1]
    BFDOT V6.4S, V13.8H, V20.2H[0x3]
    SQRDMLAH V3.4H, V6.4H, V2.4H
    BFDOT V27.2S, V14.4H, V30.2H[0x2]
    SQRDMLAH V20.4S, V21.4S, V29.S[0x3]
    BFDOT V13.2S, V3.4H, V23.4H
    SQRDMLAH V24.4H, V5.4H, V6.H[0x0]
    SQRDMLSH V29.8H, V20.8H, V24.8H
    SDOT V31.2S, V27.8B, V6.8B
    SQRDMLSH V16.4H, V10.4H, V10.H[0x6]
    UDOT V7.4S, V29.16B, V16.16B
    SDOT V26.4S, V4.16B, V17.16B
    UDOT V2.4S, V31.16B, V26.4B[0x1]
    SQRDMLAH V1.4H, V7.4H, V4.H[0x6]
    SQRDMLAH V22.4H, V13.4H, V15.H[0x1]
    BFMMLA V14.4S, V12.8H, V28.8H
    UDOT V20.4S, V1.16B, V22.16B
    SQRDMLAH V26.2S, V25.2S, V14.S[0x3]
    SQRDMLAH V25.8H, V26.8H, V20.8H
    BFDOT V30.4S, V21.8H, V31.8H
    SQRDMLAH V4.4H, V27.4H, V9.H[0x1]
    SQRDMLSH V16.4S, V1.4S, V6.S[0x0]
    SUBS  X17, X17, #0x1
    B.NE  LCRTAdvsimdVectorRdmBF16Dotprod_label_14
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X22, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    MRS  X21, FPSR
    MOVZ  X22, #0x9d, LSL #0
    MOVK  X22, #0x800, LSL #16
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D0
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D1
    MOVZ  X22, #0x156e, LSL #0
    MOVK  X22, #0x22f5, LSL #16
    MOVK  X22, #0x400, LSL #32
    MOVK  X22, #0x4fd6, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D2
    MOVZ  X22, #0x9786, LSL #0
    MOVK  X22, #0xd, LSL #16
    MOVK  X22, #0x8d37, LSL #32
    MOVK  X22, #0xffc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D3
    MOVZ  X22, #0x3f40, LSL #0
    MOVK  X22, #0x800d, LSL #16
    MOVK  X22, #0xd45, LSL #32
    MOVK  X22, #0x5e7a, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D4
    MOVZ  X22, #0xcf01, LSL #0
    MOVK  X22, #0xcf01, LSL #32
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X22, #0xaf42, LSL #0
    MOVK  X22, #0xaf81, LSL #16
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D5
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D6
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D7
    MOVZ  X22, #0x7fd7, LSL #0
    MOVK  X22, #0x7fc1, LSL #16
    MOVK  X22, #0x38df, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D8
    MOVZ  X22, #0x5579, LSL #0
    MOVK  X22, #0x8001, LSL #16
    MOVK  X22, #0xcbb4, LSL #32
    MOVK  X22, #0x40, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D9
    MOVZ  X22, #0xcf01, LSL #0
    MOVK  X22, #0x8000, LSL #16
    MOVK  X22, #0xfc22, LSL #32
    MOVK  X22, #0xa0b7, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X22, #0xc0e0, LSL #0
    MOVK  X22, #0x7fbf, LSL #16
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D10
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x7fff, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D11
    MOVZ  X22, #0xc532, LSL #0
    MOVK  X22, #0xd492, LSL #16
    MOVK  X22, #0x596b, LSL #32
    MOVK  X22, #0x6f03, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D12
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0xad3e, LSL #16
    MOVK  X22, #0xb99d, LSL #32
    MOVK  X22, #0xffbf, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D13
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D14
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D15
    MOVZ  X22, #0x4737, LSL #0
    MOVK  X22, #0x803e, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x7fff, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D16
    MOVZ  X22, #0xd418, LSL #0
    MOVK  X22, #0x5cdc, LSL #16
    MOVK  X22, #0xe702, LSL #32
    MOVK  X22, #0x3011, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D17
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc1, LSL #16
    MOVK  X22, #0xaf01, LSL #32
    MOVK  X22, #0x7fc1, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D18
    MOVZ  X22, #0x2d96, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x5e03, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D19
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D20
    MOVZ  X22, #0xec10, LSL #0
    MOVK  X22, #0x7fec, LSL #16
    MOVK  X22, #0x2e1d, LSL #32
    MOVK  X22, #0xffc3, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D21
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7f80, LSL #16
    MOVK  X22, #0xfffc, LSL #32
    MOVK  X22, #0xff7f, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D22
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x3e, LSL #16
    MOVK  X22, #0x3e, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X22, #0x1c1, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D23
    MOVZ  X22, #0xa93, LSL #0
    MOVK  X22, #0xffc0, LSL #16
    MOVK  X22, #0x2213, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D24
    MOVZ  X22, #0x3f80, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7f80, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D25
    MOVZ  X22, #0xf68e, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0x1933, LSL #32
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D26
    MOVZ  X22, #0x3ca1, LSL #0
    MOVK  X22, #0x7fc1, LSL #16
    MOVK  X22, #0x45f3, LSL #32
    MOVK  X22, #0xff81, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D27
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fcf, LSL #16
    MOVK  X22, #0x7fcf, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D28
    MOVZ  X22, #0xff22, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    MOVK  X22, #0x7fcf, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X22, #0x2045, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D29
    MOVZ  X22, #0x7fff, LSL #0
    MOVK  X22, #0x8015, LSL #16
    MOVK  X22, #0x2174, LSL #32
    MOVK  X22, #0x2136, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D30
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    MOVK  X22, #0x7fc0, LSL #48
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail
    FMOV  X21, D31
    MOVZ  X22, #0xcf01, LSL #0
    MOVK  X22, #0x7fc1, LSL #16
    MOVK  X22, #0x4f01, LSL #32
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTAdvsimdVectorRdmBF16Dotprod_TestFail

LCRTAdvsimdVectorRdmBF16Dotprod_TestEnd:
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
LCRTAdvsimdVectorRdmBF16Dotprod_TestFail:
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
