.global TSRTAdvsimdVectorMaxMin

.text
.p2align 4

TSRTAdvsimdVectorMaxMin:

TSRTAdvsimdVectorMaxMin_TestBegin:
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
    MOVZ  X2, #0xd357, LSL #0
    MOVK  X2, #0x4c8, LSL #16
    MOVK  X2, #0x4757, LSL #32
    MOVK  X2, #0x6992, LSL #48
    MOVZ  X3, #0x936d, LSL #0
    MOVK  X3, #0x611c, LSL #16
    MOVK  X3, #0xc796, LSL #32
    MOVK  X3, #0xadd2, LSL #48
    MOVZ  X4, #0xed08, LSL #0
    MOVK  X4, #0x94a, LSL #16
    MOVK  X4, #0xc6f4, LSL #32
    MOVK  X4, #0x5c06, LSL #48
    MOVZ  X5, #0x4a87, LSL #0
    MOVK  X5, #0xc538, LSL #16
    MOVK  X5, #0xe81e, LSL #32
    MOVK  X5, #0xa53b, LSL #48
    MOVZ  X6, #0x35de, LSL #0
    MOVK  X6, #0x9aee, LSL #16
    MOVK  X6, #0xb5bb, LSL #32
    MOVK  X6, #0x9c2e, LSL #48
    MOVZ  X7, #0xedc7, LSL #0
    MOVK  X7, #0xddad, LSL #16
    MOVK  X7, #0xf14b, LSL #32
    MOVK  X7, #0xf782, LSL #48
    MOVZ  X8, #0xc18d, LSL #0
    MOVK  X8, #0xd4e6, LSL #16
    MOVK  X8, #0x841c, LSL #32
    MOVK  X8, #0x1af1, LSL #48
    MOVZ  X9, #0xa5fc, LSL #0
    MOVK  X9, #0x26e6, LSL #16
    MOVK  X9, #0x5cf2, LSL #32
    MOVK  X9, #0x1d43, LSL #48
    MOVZ  X10, #0x75ad, LSL #0
    MOVK  X10, #0xa85, LSL #16
    MOVK  X10, #0x3567, LSL #32
    MOVK  X10, #0x3acf, LSL #48
    MOVZ  X11, #0x4a68, LSL #0
    MOVK  X11, #0x9081, LSL #16
    MOVK  X11, #0x1791, LSL #32
    MOVK  X11, #0x554d, LSL #48
    MOVZ  X12, #0x74ef, LSL #0
    MOVK  X12, #0x74d5, LSL #16
    MOVK  X12, #0x563b, LSL #32
    MOVK  X12, #0xd5fa, LSL #48
    MOVZ  X13, #0x76d1, LSL #0
    MOVK  X13, #0xa9b7, LSL #16
    MOVK  X13, #0x25e5, LSL #32
    MOVK  X13, #0x89d9, LSL #48
    MOVZ  X14, #0x7761, LSL #0
    MOVK  X14, #0x772f, LSL #16
    MOVK  X14, #0xb1a0, LSL #32
    MOVK  X14, #0x7775, LSL #48
    MOVZ  X15, #0x5193, LSL #0
    MOVK  X15, #0xbda3, LSL #16
    MOVK  X15, #0x544b, LSL #32
    MOVK  X15, #0xa39e, LSL #48
    MOVZ  X16, #0xc725, LSL #0
    MOVK  X16, #0xddba, LSL #16
    MOVK  X16, #0xcc2e, LSL #32
    MOVK  X16, #0xe37, LSL #48
    MOVZ  X17, #0x788b, LSL #0
    MOVK  X17, #0x2087, LSL #16
    MOVK  X17, #0x71f2, LSL #32
    MOVK  X17, #0x7322, LSL #48
    MOVZ  X18, #0x94b0, LSL #0
    MOVK  X18, #0xc617, LSL #16
    MOVK  X18, #0x761b, LSL #32
    MOVK  X18, #0x558b, LSL #48
    MOVZ  X19, #0xb2c6, LSL #0
    MOVK  X19, #0x79bd, LSL #16
    MOVK  X19, #0x3d88, LSL #32
    MOVK  X19, #0x70ad, LSL #48
    MOVZ  X20, #0x2ac9, LSL #0
    MOVK  X20, #0x91f3, LSL #16
    MOVK  X20, #0x74f7, LSL #32
    MOVK  X20, #0xc0f, LSL #48
    MOVZ  X21, #0xc0dc, LSL #0
    MOVK  X21, #0x847, LSL #16
    MOVK  X21, #0x3c2, LSL #32
    MOVK  X21, #0x7785, LSL #48
    MOVZ  X22, #0xff58, LSL #0
    MOVK  X22, #0x38ed, LSL #16
    MOVK  X22, #0xfbbd, LSL #32
    MOVK  X22, #0x5796, LSL #48
    MOVZ  X23, #0xa628, LSL #0
    MOVK  X23, #0x2160, LSL #16
    MOVK  X23, #0xdd74, LSL #32
    MOVK  X23, #0x561e, LSL #48
    MOVZ  X29, #0x3127, LSL #0
    MOVK  X29, #0x9aff, LSL #16
    MOVK  X29, #0x4084, LSL #32
    MOVK  X29, #0x80d9, LSL #48
    MOVZ  X5, #0x298c, LSL #0
    MOVK  X5, #0x6364, LSL #16
    MOVK  X5, #0xb66f, LSL #32
    MOVK  X5, #0xf687, LSL #48
    MSR  FPCR, X5
    MRS  X9, FPCR
    MOVZ  X8, #0x60ff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    AND  X9, X9, X8
    MOVZ  X8, #0x0, LSL #0
    ORR  X9, X9, X8
    MSR  FPCR, X9
    ISB  SY
    MOVZ  X5, #0x7651, LSL #0
    MOVK  X5, #0x870f, LSL #16
    MOVK  X5, #0xaf73, LSL #32
    MOVK  X5, #0xc393, LSL #48
    MSR  FPSR, X5
    MRS  X5, FPSR
    MOVZ  X20, #0xff60, LSL #0
    MOVK  X20, #0x7ff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    AND  X5, X5, X20
    MOVZ  X20, #0x0, LSL #0
    ORR  X5, X5, X20
    MSR  FPSR, X5
    ISB  SY
    SUBS  X15, X9, #0x6e8
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x815f, LSL #0
    MOVK  X2, #0x5eef, LSL #16
    MOVK  X2, #0xe5f1, LSL #32
    MOVK  X2, #0xcf7b, LSL #48
    MOVZ  X3, #0x3852, LSL #0
    MOVK  X3, #0x77f5, LSL #16
    MOVK  X3, #0xdf64, LSL #32
    MOVK  X3, #0xf7d7, LSL #48
    MOVZ  X4, #0x557b, LSL #0
    MOVK  X4, #0xf058, LSL #16
    MOVK  X4, #0x32e, LSL #32
    MOVK  X4, #0xefb8, LSL #48
    MOVZ  X5, #0xd321, LSL #0
    MOVK  X5, #0xd362, LSL #16
    MOVK  X5, #0x1a55, LSL #32
    MOVK  X5, #0x9684, LSL #48
    MOVZ  X6, #0x1974, LSL #0
    MOVK  X6, #0x1896, LSL #16
    MOVK  X6, #0x647a, LSL #32
    MOVK  X6, #0x4124, LSL #48
    MOVZ  X7, #0x3703, LSL #0
    MOVK  X7, #0x7edc, LSL #16
    MOVK  X7, #0xb9a8, LSL #32
    MOVK  X7, #0x37e, LSL #48
    MOVZ  X8, #0x2e2a, LSL #0
    MOVK  X8, #0xf28f, LSL #16
    MOVK  X8, #0xf869, LSL #32
    MOVK  X8, #0x7a86, LSL #48
    MOVZ  X9, #0xca44, LSL #0
    MOVK  X9, #0xeafc, LSL #16
    MOVK  X9, #0x89e6, LSL #32
    MOVK  X9, #0xd5bf, LSL #48
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x2f7, LSL #16
    MOVK  X10, #0x927b, LSL #32
    MOVK  X10, #0xbbbb, LSL #48
    MOVZ  X11, #0x9487, LSL #0
    MOVK  X11, #0x6ea3, LSL #16
    MOVK  X11, #0x3670, LSL #32
    MOVK  X11, #0xd9bf, LSL #48
    MOVZ  X12, #0x61a2, LSL #0
    MOVK  X12, #0xcd99, LSL #16
    MOVK  X12, #0x32c, LSL #32
    MOVK  X12, #0xf342, LSL #48
    MOVZ  X13, #0x5b3d, LSL #0
    MOVK  X13, #0xfc32, LSL #16
    MOVK  X13, #0x30c3, LSL #32
    MOVK  X13, #0x494a, LSL #48
    MOVZ  X14, #0x56eb, LSL #0
    MOVK  X14, #0x6fc6, LSL #16
    MOVK  X14, #0xee5c, LSL #32
    MOVK  X14, #0x9c15, LSL #48
    MOVZ  X15, #0xbaf8, LSL #0
    MOVK  X15, #0x6cbf, LSL #16
    MOVK  X15, #0xf3e7, LSL #32
    MOVK  X15, #0x73ee, LSL #48
    MOVZ  X16, #0xda08, LSL #0
    MOVK  X16, #0xcd51, LSL #16
    MOVK  X16, #0xe136, LSL #32
    MOVK  X16, #0xa7ae, LSL #48
    MOVZ  X17, #0xdd39, LSL #0
    MOVK  X17, #0x5f90, LSL #16
    MOVK  X17, #0xa511, LSL #32
    MOVK  X17, #0x5cff, LSL #48
    MOVZ  X18, #0x8b6d, LSL #0
    MOVK  X18, #0xf221, LSL #16
    MOVK  X18, #0xb997, LSL #32
    MOVK  X18, #0x9a74, LSL #48
    MOVZ  X19, #0xbe3a, LSL #0
    MOVK  X19, #0xc182, LSL #16
    MOVK  X19, #0x722c, LSL #32
    MOVK  X19, #0xaaea, LSL #48
    MOVZ  X20, #0x6cde, LSL #0
    MOVK  X20, #0x6ff5, LSL #16
    MOVK  X20, #0x35ae, LSL #32
    MOVK  X20, #0x8897, LSL #48
    MOVZ  X21, #0xc13f, LSL #0
    MOVK  X21, #0xef92, LSL #16
    MOVK  X21, #0xfa3c, LSL #32
    MOVK  X21, #0x5607, LSL #48
    MOVZ  X22, #0xa010, LSL #0
    MOVK  X22, #0x3524, LSL #16
    MOVK  X22, #0x50dd, LSL #32
    MOVK  X22, #0x3609, LSL #48
    MOVZ  X23, #0xf1e5, LSL #0
    MOVK  X23, #0x46cf, LSL #16
    MOVK  X23, #0xcd97, LSL #32
    MOVK  X23, #0x9e2e, LSL #48
    MOVZ  X29, #0x409b, LSL #0
    MOVK  X29, #0xac6f, LSL #16
    MOVK  X29, #0x60fd, LSL #32
    MOVK  X29, #0x3f8c, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X20
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X21
    FMOV  V2.D[1], X5
    FMOV  D3, X10
    FMOV  V3.D[1], X12
    FMOV  D4, X10
    FMOV  V4.D[1], X11
    FMOV  D5, X2
    FMOV  V5.D[1], X20
    FMOV  D6, X23
    FMOV  V6.D[1], X18
    FMOV  D7, X2
    FMOV  V7.D[1], X14
    FMOV  D8, X19
    FMOV  V8.D[1], X29
    FMOV  D9, X7
    FMOV  V9.D[1], X3
    FMOV  D10, X20
    FMOV  V10.D[1], X2
    FMOV  D11, X21
    FMOV  V11.D[1], X19
    FMOV  D12, X16
    FMOV  V12.D[1], X8
    FMOV  D13, X18
    FMOV  V13.D[1], X17
    FMOV  D14, X3
    FMOV  V14.D[1], X20
    FMOV  D15, X22
    FMOV  V15.D[1], X11
    FMOV  D16, X8
    FMOV  V16.D[1], X7
    FMOV  D17, X3
    FMOV  V17.D[1], X9
    FMOV  D18, X20
    FMOV  V18.D[1], X8
    FMOV  D19, X16
    FMOV  V19.D[1], X18
    FMOV  D20, X5
    FMOV  V20.D[1], X14
    FMOV  D21, X13
    FMOV  V21.D[1], X15
    FMOV  D22, X8
    FMOV  V22.D[1], X29
    FMOV  D23, X2
    FMOV  V23.D[1], X13
    FMOV  D24, X22
    FMOV  V24.D[1], X12
    FMOV  D25, X11
    FMOV  V25.D[1], X15
    FMOV  D26, X18
    FMOV  V26.D[1], X14
    FMOV  D27, X4
    FMOV  V27.D[1], X13
    FMOV  D28, X22
    FMOV  V28.D[1], X5
    FMOV  D29, X12
    FMOV  V29.D[1], X9
    FMOV  D30, X16
    FMOV  V30.D[1], X4
    FMOV  D31, X5
    FMOV  V31.D[1], X2
    FMAX  V27.2D, V26.2D, V24.2D
    FMAX  V23.2D, V6.2D, V23.2D
    FMAX  V26.2D, V20.2D, V4.2D
    FMAX  V2.2D, V20.2D, V28.2D
    FMAX  V4.2S, V2.2S, V13.2S
    FMAX  V9.2S, V4.2S, V29.2S
    FMAX  V17.2S, V25.2S, V0.2S
    FMAX  V31.2D, V20.2D, V23.2D
    FMAX  V17.2S, V11.2S, V31.2S
    FMAX  V18.4S, V17.4S, V26.4S
    FMAXNM  V23.2D, V9.2D, V8.2D
    FMAXNM  V25.4S, V23.4S, V30.4S
    FMAXNM  V20.2S, V12.2S, V9.2S
    FMAXNM  V28.2S, V27.2S, V21.2S
    FMAXNM  V27.2S, V25.2S, V12.2S
    FMAXNM  V9.2D, V20.2D, V28.2D
    FMAXNM  V22.2S, V18.2S, V12.2S
    FMAXNM  V28.2D, V2.2D, V0.2D
    FMAXNM  V31.2D, V27.2D, V27.2D
    FMAXNM  V11.2D, V9.2D, V31.2D
    FMAXNMP D6, V15.2D
    FMAXNMP D20, V7.2D
    FMAXNMP D8, V28.2D
    FMAXNMP D20, V11.2D
    FMAXNMP D23, V20.2D
    FMAXNMP D26, V15.2D
    FMAXNMP D0, V23.2D
    FMAXNMP D20, V22.2D
    FMAXNMP D27, V2.2D
    FMAXNMP D15, V20.2D
    FMAXNMP S11, V16.2S
    FMAXNMP S28, V26.2S
    FMAXNMP S23, V19.2S
    FMAXNMP S25, V5.2S
    FMAXNMP S27, V27.2S
    FMAXNMP S30, V25.2S
    FMAXNMP S5, V13.2S
    FMAXNMP S11, V27.2S
    FMAXNMP S7, V23.2S
    FMAXNMP S2, V11.2S
    FMAXNMP  V13.2D, V17.2D, V28.2D
    FMAXNMP  V19.2D, V3.2D, V7.2D
    FMAXNMP  V3.4S, V23.4S, V15.4S
    FMAXNMP  V26.2D, V22.2D, V19.2D
    FMAXNMP  V17.2S, V2.2S, V5.2S
    FMAXNMP  V15.2D, V30.2D, V26.2D
    FMAXNMP  V22.2D, V19.2D, V20.2D
    FMAXNMP  V2.2D, V13.2D, V17.2D
    FMAXNMP  V5.2D, V7.2D, V8.2D
    FMAXNMP  V27.2S, V29.2S, V2.2S
    FMAXNMV  S10, V3.4S
    FMAXNMV  S16, V21.4S
    FMAXNMV  S30, V10.4S
    FMAXNMV  S23, V30.4S
    FMAXNMV  S3, V5.4S
    FMAXNMV  S25, V3.4S
    FMAXNMV  S30, V25.4S
    FMAXNMV  S5, V22.4S
    FMAXNMV  S28, V23.4S
    FMAXNMV  S17, V16.4S
    FMAXP D25, V10.2D
    FMAXP D13, V17.2D
    FMAXP D23, V15.2D
    FMAXP D8, V14.2D
    FMAXP D15, V27.2D
    FMAXP D21, V22.2D
    FMAXP D10, V13.2D
    FMAXP D25, V15.2D
    FMAXP D13, V8.2D
    FMAXP D11, V24.2D
    FMAXP S30, V10.2S
    FMAXP S14, V5.2S
    FMAXP S22, V23.2S
    FMAXP S16, V4.2S
    FMAXP S25, V14.2S
    FMAXP S8, V24.2S
    FMAXP S14, V31.2S
    FMAXP S5, V25.2S
    FMAXP S2, V8.2S
    FMAXP S25, V5.2S
    FMAXP  V8.2S, V30.2S, V31.2S
    FMAXP  V24.2D, V28.2D, V11.2D
    FMAXP  V23.2D, V14.2D, V8.2D
    FMAXP  V13.2D, V25.2D, V2.2D
    FMAXP  V10.2S, V16.2S, V22.2S
    FMAXP  V11.2S, V30.2S, V3.2S
    FMAXP  V22.4S, V13.4S, V8.4S
    FMAXP  V31.2S, V21.2S, V23.2S
    FMAXP  V4.4S, V24.4S, V3.4S
    FMAXP  V2.4S, V31.4S, V11.4S
    FMAXV  S14, V4.4S
    FMAXV  S4, V2.4S
    FMAXV  S10, V22.4S
    FMAXV  S30, V10.4S
    FMAXV  S24, V14.4S
    FMAXV  S15, V4.4S
    FMAXV  S14, V10.4S
    FMAXV  S22, V12.4S
    FMAXV  S28, V28.4S
    FMAXV  S16, V24.4S
    FMIN  V8.2S, V14.2S, V28.2S
    FMIN  V6.2S, V8.2S, V16.2S
    FMIN  V4.2S, V30.2S, V30.2S
    FMIN  V8.4S, V31.4S, V22.4S
    FMIN  V2.2S, V21.2S, V28.2S
    FMIN  V3.4S, V4.4S, V4.4S
    FMIN  V22.2S, V8.2S, V24.2S
    FMIN  V13.2S, V2.2S, V22.2S
    FMIN  V25.2S, V12.2S, V13.2S
    FMIN  V22.2S, V15.2S, V23.2S
    FMINNM  V2.2D, V15.2D, V27.2D
    FMINNM  V29.2D, V22.2D, V3.2D
    FMINNM  V18.4S, V6.4S, V9.4S
    FMINNM  V23.4S, V15.4S, V29.4S
    FMINNM  V27.2S, V26.2S, V25.2S
    FMINNM  V29.4S, V23.4S, V8.4S
    FMINNM  V16.4S, V26.4S, V15.4S
    FMINNM  V27.2S, V28.2S, V10.2S
    FMINNM  V8.2D, V29.2D, V27.2D
    FMINNM  V23.4S, V8.4S, V23.4S
    FMINNMP D8, V2.2D
    FMINNMP D25, V18.2D
    FMINNMP D0, V23.2D
    FMINNMP D10, V8.2D
    FMINNMP D4, V16.2D
    FMINNMP D6, V21.2D
    FMINNMP D8, V10.2D
    FMINNMP D9, V6.2D
    FMINNMP D14, V24.2D
    FMINNMP D15, V8.2D
    FMINNMP S8, V10.2S
    FMINNMP S24, V5.2S
    FMINNMP S12, V0.2S
    FMINNMP S18, V17.2S
    FMINNMP S17, V24.2S
    FMINNMP S26, V24.2S
    FMINNMP S24, V10.2S
    FMINNMP S23, V5.2S
    FMINNMP S23, V9.2S
    FMINNMP S0, V10.2S
    FMINNMP  V5.2S, V15.2S, V25.2S
    FMINNMP  V30.2D, V26.2D, V0.2D
    FMINNMP  V6.2D, V18.2D, V30.2D
    FMINNMP  V16.4S, V6.4S, V6.4S
    FMINNMP  V6.4S, V12.4S, V17.4S
    FMINNMP  V5.2D, V6.2D, V23.2D
    FMINNMP  V10.4S, V14.4S, V25.4S
    FMINNMP  V26.2S, V20.2S, V5.2S
    FMINNMP  V9.2D, V24.2D, V22.2D
    FMINNMP  V23.4S, V9.4S, V16.4S
    FMINNMV  S14, V26.4S
    FMINNMV  S26, V17.4S
    FMINNMV  S15, V23.4S
    FMINNMV  S9, V10.4S
    FMINNMV  S10, V15.4S
    FMINNMV  S12, V12.4S
    FMINNMV  S25, V3.4S
    FMINNMV  S3, V25.4S
    FMINNMV  S15, V12.4S
    FMINNMV  S17, V0.4S
    FMINP D24, V19.2D
    FMINP D12, V3.2D
    FMINP D25, V17.2D
    FMINP D8, V24.2D
    FMINP D23, V26.2D
    FMINP D6, V23.2D
    FMINP D23, V12.2D
    FMINP D16, V14.2D
    FMINP D24, V6.2D
    FMINP D18, V25.2D
    FMINP S25, V23.2S
    FMINP S9, V9.2S
    FMINP S14, V7.2S
    FMINP S23, V18.2S
    FMINP S0, V23.2S
    FMINP S12, V24.2S
    FMINP S26, V14.2S
    FMINP S24, V10.2S
    FMINP S10, V15.2S
    FMINP S19, V19.2S
    FMINP  V23.2S, V27.2S, V16.2S
    FMINP  V20.2S, V3.2S, V10.2S
    FMINP  V6.2D, V12.2D, V24.2D
    FMINP  V3.2S, V26.2S, V6.2S
    FMINP  V17.2S, V5.2S, V25.2S
    FMINP  V5.2S, V3.2S, V19.2S
    FMINP  V25.2S, V7.2S, V0.2S
    FMINP  V14.2S, V31.2S, V15.2S
    FMINP  V18.2D, V23.2D, V8.2D
    FMINP  V26.4S, V7.4S, V9.4S
    FMINV  S6, V7.4S
    FMINV  S15, V17.4S
    FMINV  S0, V6.4S
    FMINV  S10, V26.4S
    FMINV  S24, V5.4S
    FMINV  S17, V1.4S
    FMINV  S9, V5.4S
    FMINV  S26, V15.4S
    FMINV  S6, V20.4S
    FMINV  S12, V27.4S
    FMAX  V20.4H, V24.4H, V2.4H
    FMAX  V27.4H, V14.4H, V10.4H
    FMAX  V23.4H, V25.4H, V17.4H
    FMAX  V19.4H, V16.4H, V20.4H
    FMAX  V5.4H, V26.4H, V0.4H
    FMAX  V1.8H, V9.8H, V19.8H
    FMAX  V10.8H, V27.8H, V6.8H
    FMAX  V7.4H, V28.4H, V5.4H
    FMAX  V20.8H, V10.8H, V1.8H
    FMAX  V14.8H, V7.8H, V28.8H
    FMAXNM  V19.4H, V22.4H, V23.4H
    FMAXNM  V25.4H, V19.4H, V19.4H
    FMAXNM  V6.4H, V14.4H, V12.4H
    FMAXNM  V17.8H, V20.8H, V30.8H
    FMAXNM  V7.4H, V6.4H, V5.4H
    FMAXNM  V0.8H, V17.8H, V14.8H
    FMAXNM  V24.4H, V25.4H, V1.4H
    FMAXNM  V28.8H, V7.8H, V7.8H
    FMAXNM  V2.8H, V0.8H, V28.8H
    FMAXNM  V27.8H, V6.8H, V20.8H
    FMAXNMP H25, V19.2H
    FMAXNMP H26, V22.2H
    FMAXNMP H23, V24.2H
    FMAXNMP H15, V2.2H
    FMAXNMP H22, V28.2H
    FMAXNMP H25, V16.2H
    FMAXNMP H3, V25.2H
    FMAXNMP H12, V23.2H
    FMAXNMP H5, V3.2H
    FMAXNMP H30, V8.2H
    FMAXNMP  V24.8H, V12.8H, V3.8H
    FMAXNMP  V14.8H, V13.8H, V15.8H
    FMAXNMP  V17.4H, V2.4H, V26.4H
    FMAXNMP  V23.8H, V17.8H, V10.8H
    FMAXNMP  V3.4H, V16.4H, V30.4H
    FMAXNMP  V6.4H, V25.4H, V24.4H
    FMAXNMP  V8.4H, V4.4H, V3.4H
    FMAXNMP  V3.4H, V14.4H, V24.4H
    FMAXNMP  V17.4H, V6.4H, V5.4H
    FMAXNMP  V24.4H, V3.4H, V17.4H
    FMAXNMV  H10, V22.4H
    FMAXNMV  H25, V24.4H
    FMAXNMV  H0, V7.4H
    FMAXNMV  H19, V24.4H
    FMAXNMV  H4, V0.8H
    FMAXNMV  H3, V10.8H
    FMAXNMV  H22, V23.8H
    FMAXNMV  H10, V16.4H
    FMAXNMV  H14, V30.8H
    FMAXNMV  H16, V4.4H
    FMAXP H26, V22.2H
    FMAXP H22, V25.2H
    FMAXP H25, V22.2H
    FMAXP H17, V12.2H
    FMAXP H0, V16.2H
    FMAXP H23, V23.2H
    FMAXP H7, V17.2H
    FMAXP H24, V23.2H
    FMAXP H17, V25.2H
    FMAXP H22, V24.2H
    FMAXP  V30.4H, V26.4H, V17.4H
    FMAXP  V25.4H, V3.4H, V22.4H
    FMAXP  V26.8H, V14.8H, V22.8H
    FMAXP  V17.8H, V0.8H, V30.8H
    FMAXP  V0.4H, V26.4H, V18.4H
    FMAXP  V29.8H, V17.8H, V8.8H
    FMAXP  V23.4H, V5.4H, V19.4H
    FMAXP  V12.8H, V23.8H, V26.8H
    FMAXP  V4.8H, V2.8H, V0.8H
    FMAXP  V30.4H, V25.4H, V10.4H
    FMAXV  H23, V20.8H
    FMAXV  H3, V29.4H
    FMAXV  H19, V12.4H
    FMAXV  H24, V7.4H
    FMAXV  H14, V3.4H
    FMAXV  H20, V24.8H
    FMAXV  H7, V16.4H
    FMAXV  H5, V18.4H
    FMAXV  H26, V24.4H
    FMAXV  H22, V20.8H
    FMIN  V29.8H, V26.8H, V5.8H
    FMIN  V20.4H, V4.4H, V29.4H
    FMIN  V17.4H, V30.4H, V23.4H
    FMIN  V18.8H, V20.8H, V20.8H
    FMIN  V12.4H, V18.4H, V14.4H
    FMIN  V16.8H, V12.8H, V4.8H
    FMIN  V20.8H, V19.8H, V27.8H
    FMIN  V14.4H, V7.4H, V16.4H
    FMIN  V15.8H, V14.8H, V20.8H
    FMIN  V3.8H, V27.8H, V12.8H
    FMINNM  V18.8H, V22.8H, V12.8H
    FMINNM  V12.4H, V22.4H, V13.4H
    FMINNM  V0.8H, V4.8H, V19.8H
    FMINNM  V29.8H, V18.8H, V2.8H
    FMINNM  V4.4H, V12.4H, V0.4H
    FMINNM  V31.8H, V15.8H, V16.8H
    FMINNM  V16.4H, V31.4H, V3.4H
    FMINNM  V14.4H, V17.4H, V29.4H
    FMINNM  V31.8H, V16.8H, V28.8H
    FMINNM  V17.4H, V31.4H, V4.4H
    MOVZ  X8, #0x815f, LSL #0
    MOVK  X8, #0x5eef, LSL #16
    MOVK  X8, #0xe5f1, LSL #32
    MOVK  X8, #0xcf7b, LSL #48
    SUB  X7, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x3852, LSL #0
    MOVK  X8, #0x77f5, LSL #16
    MOVK  X8, #0xdf64, LSL #32
    MOVK  X8, #0xf7d7, LSL #48
    SUB  X7, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x557b, LSL #0
    MOVK  X8, #0xf058, LSL #16
    MOVK  X8, #0x32e, LSL #32
    MOVK  X8, #0xefb8, LSL #48
    SUB  X7, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xd321, LSL #0
    MOVK  X8, #0xd362, LSL #16
    MOVK  X8, #0x1a55, LSL #32
    MOVK  X8, #0x9684, LSL #48
    SUB  X7, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x1974, LSL #0
    MOVK  X8, #0x1896, LSL #16
    MOVK  X8, #0x647a, LSL #32
    MOVK  X8, #0x4124, LSL #48
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xca44, LSL #0
    MOVK  X8, #0xeafc, LSL #16
    MOVK  X8, #0x89e6, LSL #32
    MOVK  X8, #0xd5bf, LSL #48
    SUB  X7, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x7e00, LSL #0
    MOVK  X8, #0x2f7, LSL #16
    MOVK  X8, #0x927b, LSL #32
    MOVK  X8, #0xbbbb, LSL #48
    SUB  X7, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x9487, LSL #0
    MOVK  X8, #0x6ea3, LSL #16
    MOVK  X8, #0x3670, LSL #32
    MOVK  X8, #0xd9bf, LSL #48
    SUB  X7, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x61a2, LSL #0
    MOVK  X8, #0xcd99, LSL #16
    MOVK  X8, #0x32c, LSL #32
    MOVK  X8, #0xf342, LSL #48
    SUB  X7, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x5b3d, LSL #0
    MOVK  X8, #0xfc32, LSL #16
    MOVK  X8, #0x30c3, LSL #32
    MOVK  X8, #0x494a, LSL #48
    SUB  X7, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x56eb, LSL #0
    MOVK  X8, #0x6fc6, LSL #16
    MOVK  X8, #0xee5c, LSL #32
    MOVK  X8, #0x9c15, LSL #48
    SUB  X7, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xbaf8, LSL #0
    MOVK  X8, #0x6cbf, LSL #16
    MOVK  X8, #0xf3e7, LSL #32
    MOVK  X8, #0x73ee, LSL #48
    SUB  X7, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xda08, LSL #0
    MOVK  X8, #0xcd51, LSL #16
    MOVK  X8, #0xe136, LSL #32
    MOVK  X8, #0xa7ae, LSL #48
    SUB  X7, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xdd39, LSL #0
    MOVK  X8, #0x5f90, LSL #16
    MOVK  X8, #0xa511, LSL #32
    MOVK  X8, #0x5cff, LSL #48
    SUB  X7, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x8b6d, LSL #0
    MOVK  X8, #0xf221, LSL #16
    MOVK  X8, #0xb997, LSL #32
    MOVK  X8, #0x9a74, LSL #48
    SUB  X7, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xbe3a, LSL #0
    MOVK  X8, #0xc182, LSL #16
    MOVK  X8, #0x722c, LSL #32
    MOVK  X8, #0xaaea, LSL #48
    SUB  X7, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x6cde, LSL #0
    MOVK  X8, #0x6ff5, LSL #16
    MOVK  X8, #0x35ae, LSL #32
    MOVK  X8, #0x8897, LSL #48
    SUB  X7, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xc13f, LSL #0
    MOVK  X8, #0xef92, LSL #16
    MOVK  X8, #0xfa3c, LSL #32
    MOVK  X8, #0x5607, LSL #48
    SUB  X7, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xa010, LSL #0
    MOVK  X8, #0x3524, LSL #16
    MOVK  X8, #0x50dd, LSL #32
    MOVK  X8, #0x3609, LSL #48
    SUB  X7, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0xf1e5, LSL #0
    MOVK  X8, #0x46cf, LSL #16
    MOVK  X8, #0xcd97, LSL #32
    MOVK  X8, #0x9e2e, LSL #48
    SUB  X7, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X8, FPSR
    MOVZ  X7, #0x80, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D0
    MOVZ  X7, #0x409b, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D2
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5607, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D4
    MOVZ  X7, #0xda08, LSL #0
    MOVK  X7, #0xcd51, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D6
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x409b, LSL #32
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D7
    MOVZ  X7, #0x5607, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D8
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x2f7, LSL #48
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D9
    MOVZ  X7, #0x927b, LSL #0
    MOVK  X7, #0xbbbb, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D11
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x50dd, LSL #32
    MOVK  X7, #0x3609, LSL #48
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D12
    MOVZ  X7, #0xda08, LSL #0
    MOVK  X7, #0xcd51, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D13
    MOVZ  X7, #0xda08, LSL #0
    MOVK  X7, #0xcd51, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D17
    MOVZ  X7, #0xda08, LSL #0
    MOVK  X7, #0xcd51, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D19
    MOVZ  X7, #0x409b, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D21
    MOVZ  X7, #0xda08, LSL #0
    MOVK  X7, #0xcd51, LSL #16
    MOVK  X7, #0xfa3c, LSL #32
    MOVK  X7, #0x5607, LSL #48
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D22
    MOVZ  X7, #0x409b, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D24
    MOVZ  X7, #0x409b, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D25
    MOVZ  X7, #0x5607, LSL #0
    MOVK  X7, #0x5607, LSL #32
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D26
    MOVZ  X7, #0x409b, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D27
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5607, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D28
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5607, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D30
    MOVZ  X7, #0x5607, LSL #0
    MOVK  X7, #0x5607, LSL #16
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5610, LSL #0
    MOVK  X2, #0x9fd7, LSL #16
    MOVK  X2, #0x1143, LSL #32
    MOVK  X2, #0x22c5, LSL #48
    MOVZ  X3, #0x6488, LSL #0
    MOVK  X3, #0x16d0, LSL #16
    MOVK  X3, #0xbe38, LSL #32
    MOVK  X3, #0x861, LSL #48
    MOVZ  X4, #0x936f, LSL #0
    MOVK  X4, #0x318e, LSL #16
    MOVK  X4, #0x34a0, LSL #32
    MOVK  X4, #0xb4c1, LSL #48
    MOVZ  X5, #0x41c0, LSL #0
    MOVK  X5, #0x35ae, LSL #16
    MOVK  X5, #0xc44e, LSL #32
    MOVK  X5, #0xa710, LSL #48
    MOVZ  X6, #0xbdd6, LSL #0
    MOVK  X6, #0x8c03, LSL #16
    MOVK  X6, #0x11e5, LSL #32
    MOVK  X6, #0x659d, LSL #48
    MOVZ  X7, #0x15e6, LSL #0
    MOVK  X7, #0xa78c, LSL #16
    MOVK  X7, #0x5d58, LSL #32
    MOVK  X7, #0xd52a, LSL #48
    MOVZ  X8, #0x3560, LSL #0
    MOVK  X8, #0xc0ff, LSL #16
    MOVK  X8, #0x2a81, LSL #32
    MOVK  X8, #0xc8e, LSL #48
    MOVZ  X9, #0x8c09, LSL #0
    MOVK  X9, #0x600f, LSL #16
    MOVK  X9, #0xe66f, LSL #32
    MOVK  X9, #0x8746, LSL #48
    MOVZ  X10, #0xc85d, LSL #0
    MOVK  X10, #0x673, LSL #16
    MOVK  X10, #0xad3a, LSL #32
    MOVK  X10, #0x7613, LSL #48
    MOVZ  X11, #0x6772, LSL #0
    MOVK  X11, #0x5fea, LSL #16
    MOVK  X11, #0xf960, LSL #32
    MOVK  X11, #0x6d1d, LSL #48
    MOVZ  X12, #0xfe59, LSL #0
    MOVK  X12, #0x8286, LSL #16
    MOVK  X12, #0x8a8, LSL #32
    MOVK  X12, #0x93b8, LSL #48
    MOVZ  X13, #0x6513, LSL #0
    MOVK  X13, #0x6490, LSL #16
    MOVK  X13, #0x75cd, LSL #32
    MOVK  X13, #0x221, LSL #48
    MOVZ  X14, #0x78d7, LSL #0
    MOVK  X14, #0x240b, LSL #16
    MOVK  X14, #0xc944, LSL #32
    MOVK  X14, #0xd7fa, LSL #48
    MOVZ  X15, #0xe2d8, LSL #0
    MOVK  X15, #0x89c, LSL #16
    MOVK  X15, #0x6b9e, LSL #32
    MOVK  X15, #0x6d4f, LSL #48
    MOVZ  X16, #0xcffa, LSL #0
    MOVK  X16, #0x63ec, LSL #16
    MOVK  X16, #0x8747, LSL #32
    MOVK  X16, #0x190a, LSL #48
    MOVZ  X17, #0xa0ed, LSL #0
    MOVK  X17, #0x64fe, LSL #16
    MOVK  X17, #0xca45, LSL #32
    MOVK  X17, #0x7f1a, LSL #48
    MOVZ  X18, #0xe836, LSL #0
    MOVK  X18, #0x5d41, LSL #16
    MOVK  X18, #0xe98c, LSL #32
    MOVK  X18, #0x5f9c, LSL #48
    MOVZ  X19, #0x3fe7, LSL #0
    MOVK  X19, #0xe1ea, LSL #16
    MOVK  X19, #0x9086, LSL #32
    MOVK  X19, #0x669d, LSL #48
    MOVZ  X20, #0xa00a, LSL #0
    MOVK  X20, #0x6d3e, LSL #16
    MOVK  X20, #0xd23b, LSL #32
    MOVK  X20, #0xa82e, LSL #48
    MOVZ  X21, #0x451e, LSL #0
    MOVK  X21, #0xa573, LSL #16
    MOVK  X21, #0x9d8f, LSL #32
    MOVK  X21, #0xf938, LSL #48
    MOVZ  X22, #0x3646, LSL #0
    MOVK  X22, #0x4625, LSL #16
    MOVK  X22, #0x22ee, LSL #32
    MOVK  X22, #0xafb3, LSL #48
    MOVZ  X23, #0x969e, LSL #0
    MOVK  X23, #0xd6fa, LSL #16
    MOVK  X23, #0x134f, LSL #32
    MOVK  X23, #0x9480, LSL #48
    MOVZ  X29, #0x3cef, LSL #0
    MOVK  X29, #0xe5aa, LSL #16
    MOVK  X29, #0x7aa8, LSL #32
    MOVK  X29, #0xdc7b, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X5
    FMOV  D1, X19
    FMOV  V1.D[1], X20
    FMOV  D2, X29
    FMOV  V2.D[1], X6
    FMOV  D3, X19
    FMOV  V3.D[1], X23
    FMOV  D4, X3
    FMOV  V4.D[1], X10
    FMOV  D5, X21
    FMOV  V5.D[1], X7
    FMOV  D6, X8
    FMOV  V6.D[1], X21
    FMOV  D7, X13
    FMOV  V7.D[1], X17
    FMOV  D8, X13
    FMOV  V8.D[1], X7
    FMOV  D9, X22
    FMOV  V9.D[1], X12
    FMOV  D10, X20
    FMOV  V10.D[1], X19
    FMOV  D11, X10
    FMOV  V11.D[1], X19
    FMOV  D12, X10
    FMOV  V12.D[1], X9
    FMOV  D13, X21
    FMOV  V13.D[1], X20
    FMOV  D14, X11
    FMOV  V14.D[1], X17
    FMOV  D15, X6
    FMOV  V15.D[1], X29
    FMOV  D16, X18
    FMOV  V16.D[1], X15
    FMOV  D17, X23
    FMOV  V17.D[1], X15
    FMOV  D18, X15
    FMOV  V18.D[1], X20
    FMOV  D19, X22
    FMOV  V19.D[1], X2
    FMOV  D20, X4
    FMOV  V20.D[1], X15
    FMOV  D21, X14
    FMOV  V21.D[1], X14
    FMOV  D22, X10
    FMOV  V22.D[1], X4
    FMOV  D23, X22
    FMOV  V23.D[1], X12
    FMOV  D24, X2
    FMOV  V24.D[1], X4
    FMOV  D25, X9
    FMOV  V25.D[1], X9
    FMOV  D26, X15
    FMOV  V26.D[1], X3
    FMOV  D27, X5
    FMOV  V27.D[1], X8
    FMOV  D28, X6
    FMOV  V28.D[1], X4
    FMOV  D29, X15
    FMOV  V29.D[1], X4
    FMOV  D30, X23
    FMOV  V30.D[1], X17
    FMOV  D31, X7
    FMOV  V31.D[1], X11
    FMINNMP H15, V12.2H
    FMINNMP H15, V18.2H
    FMINNMP H28, V27.2H
    FMINNMP H22, V24.2H
    FMINNMP H22, V11.2H
    FMINNMP H25, V10.2H
    FMINNMP H14, V31.2H
    FMINNMP H30, V15.2H
    FMINNMP H16, V28.2H
    FMINNMP H20, V29.2H
    FMINNMP  V24.4H, V30.4H, V22.4H
    FMINNMP  V10.8H, V24.8H, V16.8H
    FMINNMP  V11.8H, V26.8H, V23.8H
    FMINNMP  V1.8H, V28.8H, V9.8H
    FMINNMP  V31.4H, V14.4H, V6.4H
    FMINNMP  V16.8H, V10.8H, V10.8H
    FMINNMP  V24.8H, V25.8H, V11.8H
    FMINNMP  V26.8H, V23.8H, V31.8H
    FMINNMP  V10.8H, V24.8H, V0.8H
    FMINNMP  V29.4H, V11.4H, V16.4H
    FMINNMV  H27, V20.4H
    FMINNMV  H0, V27.8H
    FMINNMV  H28, V21.8H
    FMINNMV  H18, V18.4H
    FMINNMV  H25, V1.4H
    FMINNMV  H0, V31.4H
    FMINNMV  H9, V25.8H
    FMINNMV  H15, V18.8H
    FMINNMV  H21, V26.4H
    FMINNMV  H27, V29.4H
    FMINP H8, V21.2H
    FMINP H14, V15.2H
    FMINP H6, V8.2H
    FMINP H15, V16.2H
    FMINP H11, V27.2H
    FMINP H20, V5.2H
    FMINP H30, V10.2H
    FMINP H11, V28.2H
    FMINP H2, V16.2H
    FMINP H8, V0.2H
    FMINP  V24.8H, V20.8H, V8.8H
    FMINP  V26.4H, V2.4H, V9.4H
    FMINP  V20.4H, V30.4H, V15.4H
    FMINP  V21.8H, V26.8H, V14.8H
    FMINP  V4.4H, V11.4H, V11.4H
    FMINP  V29.8H, V7.8H, V4.8H
    FMINP  V14.4H, V2.4H, V17.4H
    FMINP  V4.8H, V29.8H, V21.8H
    FMINP  V10.8H, V27.8H, V28.8H
    FMINP  V26.8H, V10.8H, V10.8H
    FMINV  H30, V20.4H
    FMINV  H17, V12.8H
    FMINV  H21, V27.8H
    FMINV  H9, V10.8H
    FMINV  H8, V30.8H
    FMINV  H29, V8.4H
    FMINV  H28, V3.8H
    FMINV  H27, V29.4H
    FMINV  H3, V30.4H
    FMINV  H7, V17.4H
    SMAX  V16.2S, V24.2S, V24.2S
    SMAX  V17.4S, V16.4S, V14.4S
    SMAX  V20.8B, V4.8B, V21.8B
    SMAX  V5.8B, V3.8B, V27.8B
    SMAX  V3.4H, V1.4H, V5.4H
    SMAX  V20.4H, V30.4H, V10.4H
    SMAX  V12.8B, V3.8B, V9.8B
    SMAX  V11.4H, V12.4H, V31.4H
    SMAX  V5.2S, V26.2S, V21.2S
    SMAX  V30.16B, V17.16B, V11.16B
    SMAXP  V8.2S, V28.2S, V13.2S
    SMAXP  V31.2S, V5.2S, V20.2S
    SMAXP  V14.2S, V31.2S, V19.2S
    SMAXP  V19.4S, V7.4S, V16.4S
    SMAXP  V25.2S, V18.2S, V8.2S
    SMAXP  V26.4H, V19.4H, V12.4H
    SMAXP  V21.8B, V26.8B, V18.8B
    SMAXP  V12.8H, V12.8H, V21.8H
    SMAXP  V28.4H, V25.4H, V25.4H
    SMAXP  V24.16B, V15.16B, V14.16B
    SMAXV  B13, V12.16B
    SMAXV  B25, V4.16B
    SMAXV  B17, V31.8B
    SMAXV  B4, V25.16B
    SMAXV  B25, V4.8B
    SMAXV  B8, V25.8B
    SMAXV  B26, V16.8B
    SMAXV  B4, V24.8B
    SMAXV  B16, V8.8B
    SMAXV  B3, V2.16B
    SMAXV  H5, V4.4H
    SMAXV  H4, V26.8H
    SMAXV  H9, V13.8H
    SMAXV  H30, V30.8H
    SMAXV  H31, V16.4H
    SMAXV  H25, V12.8H
    SMAXV  H26, V5.8H
    SMAXV  H24, V21.4H
    SMAXV  H0, V9.8H
    SMAXV  H11, V26.4H
    SMAXV  S23, V5.4S
    SMAXV  S25, V4.4S
    SMAXV  S2, V6.4S
    SMAXV  S8, V11.4S
    SMAXV  S9, V3.4S
    SMAXV  S30, V9.4S
    SMAXV  S13, V30.4S
    SMAXV  S16, V0.4S
    SMAXV  S9, V23.4S
    SMAXV  S4, V29.4S
    SMIN  V14.4S, V31.4S, V31.4S
    SMIN  V21.2S, V4.2S, V11.2S
    SMIN  V26.8H, V5.8H, V14.8H
    SMIN  V4.2S, V1.2S, V24.2S
    SMIN  V31.4S, V1.4S, V13.4S
    SMIN  V14.8B, V9.8B, V27.8B
    SMIN  V5.2S, V2.2S, V6.2S
    SMIN  V1.8H, V25.8H, V11.8H
    SMIN  V12.8H, V21.8H, V22.8H
    SMIN  V11.8B, V26.8B, V1.8B
    SMINP  V6.8H, V16.8H, V12.8H
    SMINP  V2.2S, V17.2S, V10.2S
    SMINP  V30.2S, V2.2S, V11.2S
    SMINP  V14.8H, V4.8H, V30.8H
    SMINP  V17.4H, V20.4H, V6.4H
    SMINP  V2.2S, V2.2S, V18.2S
    SMINP  V6.4S, V1.4S, V31.4S
    SMINP  V29.2S, V2.2S, V13.2S
    SMINP  V18.8H, V6.8H, V14.8H
    SMINP  V25.4S, V29.4S, V27.4S
    SMINV  B28, V7.16B
    SMINV  B8, V13.8B
    SMINV  B1, V5.16B
    SMINV  B13, V18.16B
    SMINV  B14, V28.8B
    SMINV  B21, V9.8B
    SMINV  B11, V13.8B
    SMINV  B26, V17.8B
    SMINV  B12, V14.16B
    SMINV  B30, V28.8B
    SMINV  H2, V20.4H
    SMINV  H18, V1.4H
    SMINV  H29, V11.8H
    SMINV  H31, V29.8H
    SMINV  H0, V18.4H
    SMINV  H18, V31.8H
    SMINV  H11, V26.4H
    SMINV  H27, V23.4H
    SMINV  H9, V21.4H
    SMINV  H5, V0.4H
    SMINV  S29, V30.4S
    SMINV  S21, V9.4S
    SMINV  S23, V29.4S
    SMINV  S9, V23.4S
    SMINV  S18, V2.4S
    SMINV  S9, V9.4S
    SMINV  S30, V15.4S
    SMINV  S28, V11.4S
    SMINV  S25, V9.4S
    SMINV  S29, V28.4S
    UMAX  V31.8B, V18.8B, V27.8B
    UMAX  V23.4S, V5.4S, V23.4S
    UMAX  V1.4H, V9.4H, V31.4H
    UMAX  V14.8B, V24.8B, V30.8B
    UMAX  V0.4S, V1.4S, V14.4S
    UMAX  V5.2S, V1.2S, V0.2S
    UMAX  V5.16B, V10.16B, V23.16B
    UMAX  V13.2S, V3.2S, V29.2S
    UMAX  V24.8B, V1.8B, V5.8B
    UMAX  V9.16B, V25.16B, V21.16B
    UMAXP  V2.16B, V9.16B, V25.16B
    UMAXP  V26.8H, V2.8H, V13.8H
    UMAXP  V4.2S, V21.2S, V1.2S
    UMAXP  V13.4H, V5.4H, V2.4H
    UMAXP  V23.8B, V28.8B, V10.8B
    UMAXP  V10.8B, V20.8B, V15.8B
    UMAXP  V2.16B, V26.16B, V11.16B
    UMAXP  V14.16B, V13.16B, V22.16B
    UMAXP  V15.2S, V15.2S, V2.2S
    UMAXP  V2.4H, V27.4H, V23.4H
    UMAXV  B5, V12.16B
    UMAXV  B31, V18.16B
    UMAXV  B11, V5.8B
    UMAXV  B0, V15.8B
    UMAXV  B12, V18.16B
    UMAXV  B21, V12.16B
    UMAXV  B1, V11.8B
    UMAXV  B22, V24.8B
    UMAXV  B13, V20.8B
    UMAXV  B28, V2.16B
    UMAXV  H7, V31.8H
    UMAXV  H15, V28.8H
    UMAXV  H27, V22.4H
    UMAXV  H3, V21.4H
    UMAXV  H26, V13.4H
    UMAXV  H24, V3.8H
    UMAXV  H31, V10.4H
    UMAXV  H18, V2.4H
    UMAXV  H28, V31.4H
    UMAXV  H13, V21.8H
    UMAXV  S12, V24.4S
    UMAXV  S12, V7.4S
    UMAXV  S23, V13.4S
    UMAXV  S3, V28.4S
    UMAXV  S5, V23.4S
    UMAXV  S14, V15.4S
    UMAXV  S9, V12.4S
    UMAXV  S23, V5.4S
    UMAXV  S5, V14.4S
    UMAXV  S14, V27.4S
    UMIN  V28.16B, V5.16B, V18.16B
    UMIN  V12.4H, V0.4H, V20.4H
    UMIN  V2.8B, V21.8B, V9.8B
    UMIN  V7.2S, V25.2S, V3.2S
    UMIN  V27.16B, V14.16B, V2.16B
    UMIN  V18.2S, V12.2S, V4.2S
    UMIN  V12.16B, V20.16B, V23.16B
    UMIN  V14.16B, V27.16B, V7.16B
    UMIN  V9.8H, V18.8H, V14.8H
    UMIN  V23.4H, V12.4H, V9.4H
    UMINP  V0.4S, V23.4S, V28.4S
    UMINP  V13.8H, V19.8H, V29.8H
    UMINP  V22.16B, V13.16B, V22.16B
    UMINP  V20.16B, V11.16B, V0.16B
    UMINP  V23.16B, V26.16B, V8.16B
    UMINP  V28.16B, V5.16B, V12.16B
    UMINP  V29.2S, V4.2S, V8.2S
    UMINP  V0.16B, V29.16B, V13.16B
    UMINP  V17.8B, V2.8B, V0.8B
    UMINP  V2.8B, V31.8B, V28.8B
    UMINV  B12, V28.16B
    UMINV  B29, V30.8B
    UMINV  B2, V22.8B
    UMINV  B27, V25.16B
    UMINV  B31, V18.8B
    UMINV  B18, V25.16B
    UMINV  B0, V29.8B
    UMINV  B25, V0.8B
    UMINV  B29, V31.8B
    UMINV  B28, V27.16B
    UMINV  H8, V17.8H
    UMINV  H22, V23.4H
    UMINV  H26, V20.4H
    UMINV  H5, V29.4H
    UMINV  H29, V3.8H
    UMINV  H21, V29.4H
    UMINV  H31, V22.4H
    UMINV  H29, V29.4H
    UMINV  H22, V12.8H
    UMINV  H18, V9.8H
    UMINV  S16, V5.4S
    UMINV  S11, V28.4S
    UMINV  S20, V26.4S
    UMINV  S23, V31.4S
    UMINV  S5, V18.4S
    UMINV  S28, V20.4S
    UMINV  S12, V16.4S
    UMINV  S16, V28.4S
    UMINV  S3, V13.4S
    UMINV  S13, V16.4S
    MOVZ  X11, #0x6488, LSL #0
    MOVK  X11, #0x16d0, LSL #16
    MOVK  X11, #0xbe38, LSL #32
    MOVK  X11, #0x861, LSL #48
    SUB  X2, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x936f, LSL #0
    MOVK  X11, #0x318e, LSL #16
    MOVK  X11, #0x34a0, LSL #32
    MOVK  X11, #0xb4c1, LSL #48
    SUB  X2, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xbdd6, LSL #0
    MOVK  X11, #0x8c03, LSL #16
    MOVK  X11, #0x11e5, LSL #32
    MOVK  X11, #0x659d, LSL #48
    SUB  X2, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x15e6, LSL #0
    MOVK  X11, #0xa78c, LSL #16
    MOVK  X11, #0x5d58, LSL #32
    MOVK  X11, #0xd52a, LSL #48
    SUB  X2, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x3560, LSL #0
    MOVK  X11, #0xc0ff, LSL #16
    MOVK  X11, #0x2a81, LSL #32
    MOVK  X11, #0xc8e, LSL #48
    SUB  X2, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x8c09, LSL #0
    MOVK  X11, #0x600f, LSL #16
    MOVK  X11, #0xe66f, LSL #32
    MOVK  X11, #0x8746, LSL #48
    SUB  X2, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xc85d, LSL #0
    MOVK  X11, #0x673, LSL #16
    MOVK  X11, #0xad3a, LSL #32
    MOVK  X11, #0x7613, LSL #48
    SUB  X2, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xfe59, LSL #0
    MOVK  X11, #0x8286, LSL #16
    MOVK  X11, #0x8a8, LSL #32
    MOVK  X11, #0x93b8, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x6513, LSL #0
    MOVK  X11, #0x6490, LSL #16
    MOVK  X11, #0x75cd, LSL #32
    MOVK  X11, #0x221, LSL #48
    SUB  X2, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x78d7, LSL #0
    MOVK  X11, #0x240b, LSL #16
    MOVK  X11, #0xc944, LSL #32
    MOVK  X11, #0xd7fa, LSL #48
    SUB  X2, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xe2d8, LSL #0
    MOVK  X11, #0x89c, LSL #16
    MOVK  X11, #0x6b9e, LSL #32
    MOVK  X11, #0x6d4f, LSL #48
    SUB  X2, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xcffa, LSL #0
    MOVK  X11, #0x63ec, LSL #16
    MOVK  X11, #0x8747, LSL #32
    MOVK  X11, #0x190a, LSL #48
    SUB  X2, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xa0ed, LSL #0
    MOVK  X11, #0x64fe, LSL #16
    MOVK  X11, #0xca45, LSL #32
    MOVK  X11, #0x7f1a, LSL #48
    SUB  X2, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xe836, LSL #0
    MOVK  X11, #0x5d41, LSL #16
    MOVK  X11, #0xe98c, LSL #32
    MOVK  X11, #0x5f9c, LSL #48
    SUB  X2, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x3fe7, LSL #0
    MOVK  X11, #0xe1ea, LSL #16
    MOVK  X11, #0x9086, LSL #32
    MOVK  X11, #0x669d, LSL #48
    SUB  X2, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0xa00a, LSL #0
    MOVK  X11, #0x6d3e, LSL #16
    MOVK  X11, #0xd23b, LSL #32
    MOVK  X11, #0xa82e, LSL #48
    SUB  X2, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x451e, LSL #0
    MOVK  X11, #0xa573, LSL #16
    MOVK  X11, #0x9d8f, LSL #32
    MOVK  X11, #0xf938, LSL #48
    SUB  X2, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x3646, LSL #0
    MOVK  X11, #0x4625, LSL #16
    MOVK  X11, #0x22ee, LSL #32
    MOVK  X11, #0xafb3, LSL #48
    SUB  X2, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x969e, LSL #0
    MOVK  X11, #0xd6fa, LSL #16
    MOVK  X11, #0x134f, LSL #32
    MOVK  X11, #0x9480, LSL #48
    SUB  X2, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X11, #0x3cef, LSL #0
    MOVK  X11, #0xe5aa, LSL #16
    MOVK  X11, #0x7aa8, LSL #32
    MOVK  X11, #0xdc7b, LSL #48
    SUB  X2, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X11, FPSR
    MOVZ  X2, #0x80, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D1
    MOVZ  X2, #0xe6, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8286, LSL #32
    MOVK  X2, #0x93b8, LSL #48
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D10
    MOVZ  X2, #0xe2, LSL #0
    MOVK  X2, #0xe2, LSL #32
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D15
    MOVZ  X2, #0xe2, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X2, #0xa573, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D19
    MOVZ  X2, #0xe66f, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X11, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xdad8, LSL #0
    MOVK  X2, #0xeeeb, LSL #16
    MOVK  X2, #0x93f6, LSL #32
    MOVK  X2, #0x7fad, LSL #48
    MOVZ  X3, #0x57d9, LSL #0
    MOVK  X3, #0x3418, LSL #16
    MOVK  X3, #0x5020, LSL #32
    MOVK  X3, #0x6c07, LSL #48
    MOVZ  X4, #0x469a, LSL #0
    MOVK  X4, #0x8b2, LSL #16
    MOVK  X4, #0x9740, LSL #32
    MOVK  X4, #0x1ee7, LSL #48
    MOVZ  X5, #0x213e, LSL #0
    MOVK  X5, #0x7675, LSL #16
    MOVK  X5, #0x76f9, LSL #32
    MOVK  X5, #0x6fd1, LSL #48
    MOVZ  X6, #0x9315, LSL #0
    MOVK  X6, #0x454, LSL #16
    MOVK  X6, #0x9767, LSL #32
    MOVK  X6, #0xe0b7, LSL #48
    MOVZ  X7, #0x6964, LSL #0
    MOVK  X7, #0xc44f, LSL #16
    MOVK  X7, #0xa0be, LSL #32
    MOVK  X7, #0x7866, LSL #48
    MOVZ  X8, #0xcea2, LSL #0
    MOVK  X8, #0x825d, LSL #16
    MOVK  X8, #0x602e, LSL #32
    MOVK  X8, #0xb755, LSL #48
    MOVZ  X9, #0xed6f, LSL #0
    MOVK  X9, #0x8479, LSL #16
    MOVK  X9, #0x4416, LSL #32
    MOVK  X9, #0xe022, LSL #48
    MOVZ  X10, #0xc018, LSL #0
    MOVK  X10, #0x5d0f, LSL #16
    MOVK  X10, #0x137f, LSL #32
    MOVK  X10, #0x8b67, LSL #48
    MOVZ  X11, #0x272a, LSL #0
    MOVK  X11, #0x7b86, LSL #16
    MOVK  X11, #0x13b5, LSL #32
    MOVK  X11, #0x1ba0, LSL #48
    MOVZ  X12, #0x720e, LSL #0
    MOVK  X12, #0xc173, LSL #16
    MOVK  X12, #0xc12f, LSL #32
    MOVK  X12, #0xb5e0, LSL #48
    MOVZ  X13, #0x6b88, LSL #0
    MOVK  X13, #0x7f42, LSL #16
    MOVK  X13, #0x87d9, LSL #32
    MOVK  X13, #0x8404, LSL #48
    MOVZ  X14, #0xd454, LSL #0
    MOVK  X14, #0x2ad2, LSL #16
    MOVK  X14, #0xd26c, LSL #32
    MOVK  X14, #0x7169, LSL #48
    MOVZ  X15, #0x156e, LSL #0
    MOVK  X15, #0x1adf, LSL #16
    MOVK  X15, #0x90a2, LSL #32
    MOVK  X15, #0xab93, LSL #48
    MOVZ  X16, #0x8399, LSL #0
    MOVK  X16, #0x4111, LSL #16
    MOVK  X16, #0xbc83, LSL #32
    MOVK  X16, #0x8e34, LSL #48
    MOVZ  X17, #0xc0d3, LSL #0
    MOVK  X17, #0x31eb, LSL #16
    MOVK  X17, #0x69eb, LSL #32
    MOVK  X17, #0x5438, LSL #48
    MOVZ  X18, #0x2e2, LSL #0
    MOVK  X18, #0x5f0e, LSL #16
    MOVK  X18, #0x337e, LSL #32
    MOVK  X18, #0x9e88, LSL #48
    MOVZ  X19, #0x5491, LSL #0
    MOVK  X19, #0x5d7f, LSL #16
    MOVK  X19, #0x1679, LSL #32
    MOVK  X19, #0x73ec, LSL #48
    MOVZ  X20, #0xe1c0, LSL #0
    MOVK  X20, #0x1245, LSL #16
    MOVK  X20, #0xf6d5, LSL #32
    MOVK  X20, #0xf777, LSL #48
    MOVZ  X21, #0x35, LSL #0
    MOVK  X21, #0x62f1, LSL #16
    MOVK  X21, #0x7126, LSL #32
    MOVK  X21, #0x45e5, LSL #48
    MOVZ  X22, #0x5e20, LSL #0
    MOVK  X22, #0xd1ef, LSL #16
    MOVK  X22, #0xe3d7, LSL #32
    MOVK  X22, #0x2586, LSL #48
    MOVZ  X23, #0x693a, LSL #0
    MOVK  X23, #0x5e43, LSL #16
    MOVK  X23, #0x2d4f, LSL #32
    MOVK  X23, #0xd050, LSL #48
    MOVZ  X29, #0xcb25, LSL #0
    MOVK  X29, #0xf89c, LSL #16
    MOVK  X29, #0x56de, LSL #32
    MOVK  X29, #0xfc5c, LSL #48
    FMOV  D0, X6
    FMOV  V0.D[1], X29
    FMOV  D1, X20
    FMOV  V1.D[1], X14
    FMOV  D2, X21
    FMOV  V2.D[1], X19
    FMOV  D3, X22
    FMOV  V3.D[1], X23
    FMOV  D4, X5
    FMOV  V4.D[1], X29
    FMOV  D5, X2
    FMOV  V5.D[1], X22
    FMOV  D6, X14
    FMOV  V6.D[1], X8
    FMOV  D7, X10
    FMOV  V7.D[1], X17
    FMOV  D8, X6
    FMOV  V8.D[1], X8
    FMOV  D9, X9
    FMOV  V9.D[1], X23
    FMOV  D10, X12
    FMOV  V10.D[1], X23
    FMOV  D11, X17
    FMOV  V11.D[1], X10
    FMOV  D12, X9
    FMOV  V12.D[1], X2
    FMOV  D13, X6
    FMOV  V13.D[1], X6
    FMOV  D14, X7
    FMOV  V14.D[1], X4
    FMOV  D15, X14
    FMOV  V15.D[1], X16
    FMOV  D16, X21
    FMOV  V16.D[1], X15
    FMOV  D17, X8
    FMOV  V17.D[1], X20
    FMOV  D18, X16
    FMOV  V18.D[1], X21
    FMOV  D19, X9
    FMOV  V19.D[1], X14
    FMOV  D20, X11
    FMOV  V20.D[1], X7
    FMOV  D21, X9
    FMOV  V21.D[1], X11
    FMOV  D22, X9
    FMOV  V22.D[1], X22
    FMOV  D23, X8
    FMOV  V23.D[1], X19
    FMOV  D24, X9
    FMOV  V24.D[1], X19
    FMOV  D25, X14
    FMOV  V25.D[1], X5
    FMOV  D26, X29
    FMOV  V26.D[1], X7
    FMOV  D27, X13
    FMOV  V27.D[1], X6
    FMOV  D28, X22
    FMOV  V28.D[1], X6
    FMOV  D29, X13
    FMOV  V29.D[1], X23
    FMOV  D30, X7
    FMOV  V30.D[1], X14
    FMOV  D31, X6
    FMOV  V31.D[1], X2
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_0:
    FMAXP S27, V25.2S
    FMAXNMP S0, V23.2S
    FMAXV  H30, V30.8H
    SMINV  B1, V19.8B
    FMINP D3, V31.2D
    FMAXNM  V23.4S, V21.4S, V27.4S
    FMAXV  H12, V16.8H
    UMINV  H11, V0.4H
    UMAXP  V29.4H, V3.4H, V29.4H
    FMAXNMV  H26, V24.8H
    FMAX  V5.4H, V22.4H, V1.4H
    SMINV  H5, V5.4H
    SMAXP  V21.16B, V26.16B, V30.16B
    SMAXV  B11, V4.16B
    FMINNMV  S14, V28.4S
    SMINV  S9, V13.4S
    SMINV  H19, V17.4H
    UMAXV  S22, V19.4S
    FMAXV  S0, V21.4S
    SMAXV  H26, V9.8H
    FMAXP  V17.4H, V14.4H, V22.4H
    UMAXP  V3.2S, V12.2S, V12.2S
    UMAXV  S4, V29.4S
    UMINV  H14, V3.8H
    SMIN  V27.4H, V0.4H, V17.4H
    FMAXV  S12, V5.4S
    UMAXP  V28.2S, V14.2S, V12.2S
    SMAX  V29.2S, V4.2S, V26.2S
    FMINNMV  H24, V29.4H
    FMINP H3, V24.2H
    FMAXNMV  S22, V13.4S
    SMINV  S12, V14.4S
    FMINP D9, V12.2D
    FMAXP D19, V9.2D
    FMINNMP D1, V3.2D
    FMAXP  V26.2D, V28.2D, V29.2D
    FMAXP S28, V26.2S
    FMINP S10, V0.2S
    SMIN  V24.4S, V22.4S, V25.4S
    FMAXP D14, V27.2D
    FMINNM  V25.8H, V10.8H, V19.8H
    UMINP  V19.8H, V28.8H, V24.8H
    FMAXV  S29, V1.4S
    UMAXV  H3, V14.4H
    UMAXV  S21, V3.4S
    UMIN  V13.16B, V2.16B, V19.16B
    UMAXV  B0, V8.8B
    FMINP H22, V0.2H
    FMINNM  V28.4H, V22.4H, V26.4H
    FMAXP  V5.4H, V25.4H, V21.4H
    FMAXP D15, V25.2D
    SMAXV  S26, V27.4S
    FMAXNM  V22.4S, V5.4S, V14.4S
    FMAXNMP S21, V23.2S
    FMAXP  V13.2D, V18.2D, V28.2D
    FMIN  V3.4H, V18.4H, V26.4H
    FMINNMP S27, V8.2S
    SMINV  H4, V13.8H
    UMINV  S5, V26.4S
    SMINV  B13, V5.8B
    FMINNM  V19.4H, V13.4H, V13.4H
    FMINNM  V2.2D, V21.2D, V21.2D
    FMINP H8, V8.2H
    FMIN  V5.2S, V28.2S, V10.2S
    FMINNMV  S13, V27.4S
    FMINV  S21, V29.4S
    FMAXNM  V26.4H, V20.4H, V3.4H
    FMINP S18, V4.2S
    FMINP S23, V9.2S
    FMAXNMP S3, V13.2S
    FMINNMV  S3, V5.4S
    UMAXP  V27.2S, V30.2S, V9.2S
    SMIN  V25.16B, V3.16B, V3.16B
    UMINV  H13, V0.4H
    FMINNMV  S9, V19.4S
    UMAXP  V19.4H, V22.4H, V2.4H
    UMAXP  V14.4S, V23.4S, V19.4S
    SMINV  B22, V21.8B
    FMINNMP D31, V14.2D
    FMAXNMP  V3.4S, V13.4S, V8.4S
    SMINV  H0, V9.8H
    FMINNM  V23.4S, V18.4S, V18.4S
    FMINNMP  V5.4S, V27.4S, V3.4S
    FMINNMP  V21.8H, V20.8H, V28.8H
    FMAXP  V20.2D, V5.2D, V0.2D
    FMINNM  V3.4H, V25.4H, V23.4H
    FMAXNM  V5.4H, V22.4H, V20.4H
    FMAXNMP S27, V5.2S
    FMINV  S30, V28.4S
    SMINP  V11.8B, V31.8B, V23.8B
    SMINP  V5.2S, V21.2S, V1.2S
    UMAXP  V4.2S, V27.2S, V3.2S
    UMAXV  B9, V23.8B
    FMINP H31, V9.2H
    FMIN  V8.4H, V14.4H, V30.4H
    UMAXP  V0.2S, V5.2S, V0.2S
    UMAXV  H14, V6.4H
    SMAX  V23.4H, V11.4H, V31.4H
    SMAXV  B18, V16.8B
    FMINNMV  S16, V18.4S
    UMAXV  S5, V15.4S
    FMINP H2, V19.2H
    FMAXP  V3.8H, V5.8H, V5.8H
    SMAXV  H27, V3.8H
    FMIN  V6.2S, V17.2S, V16.2S
    UMINP  V16.8H, V23.8H, V18.8H
    SMAXP  V20.8H, V2.8H, V4.8H
    SMAXV  S15, V0.4S
    FMINP S31, V15.2S
    FMINP H25, V21.2H
    SMAX  V7.4H, V8.4H, V20.4H
    FMINP D5, V18.2D
    FMAXNMP D0, V5.2D
    UMIN  V8.8B, V12.8B, V16.8B
    FMAXV  H25, V7.4H
    SMAXV  H2, V18.8H
    UMAXV  H7, V2.4H
    FMINP D20, V8.2D
    FMINNMP S23, V20.2S
    FMINP  V31.4S, V14.4S, V0.4S
    FMINNM  V3.4S, V17.4S, V20.4S
    SMAXV  B19, V5.16B
    FMAXP S8, V7.2S
    FMAXV  H5, V25.8H
    SMAXV  S30, V27.4S
    SMAXV  S16, V0.4S
    FMAXP S17, V0.2S
    FMAXNMP S7, V8.2S
    FMINNMV  H4, V13.8H
    FMINV  H20, V4.8H
    FMAX  V14.4H, V11.4H, V19.4H
    FMINP  V2.8H, V12.8H, V14.8H
    FMAX  V14.2S, V31.2S, V26.2S
    FMIN  V30.8H, V2.8H, V2.8H
    FMAXP D0, V12.2D
    FMAXNMV  S27, V3.4S
    FMAXNMV  S12, V27.4S
    FMINNM  V27.4H, V17.4H, V12.4H
    FMINP D26, V5.2D
    UMIN  V13.4S, V22.4S, V14.4S
    SMINV  S4, V27.4S
    UMAXV  H25, V24.4H
    FMAXP D8, V4.2D
    UMINV  B13, V23.8B
    FMINP D31, V19.2D
    FMAXNM  V18.8H, V8.8H, V13.8H
    FMINP  V4.4H, V26.4H, V30.4H
    FMIN  V12.8H, V16.8H, V20.8H
    FMINNM  V17.8H, V31.8H, V13.8H
    UMINV  H26, V25.8H
    FMAX  V23.2S, V26.2S, V6.2S
    FMINNMP H3, V23.2H
    FMINV  S30, V18.4S
    FMAXNM  V8.4H, V31.4H, V30.4H
    FMAXNMP H27, V3.2H
    FMAXP H23, V16.2H
    FMAXP S16, V17.2S
    FMINP S19, V16.2S
    SMAXV  H16, V27.8H
    FMAXNMP  V10.4H, V16.4H, V12.4H
    SMAX  V6.8B, V0.8B, V26.8B
    SMIN  V18.16B, V19.16B, V19.16B
    FMINNMP  V17.4S, V4.4S, V1.4S
    FMAXNMP  V5.2S, V23.2S, V6.2S
    SMAXV  S7, V9.4S
    SMIN  V29.4S, V28.4S, V7.4S
    FMIN  V24.8H, V5.8H, V29.8H
    SMINP  V29.4S, V15.4S, V17.4S
    UMIN  V0.8H, V8.8H, V29.8H
    UMAXV  S5, V10.4S
    FMAX  V6.8H, V10.8H, V18.8H
    FMAXP  V9.2D, V1.2D, V5.2D
    SMAXP  V19.2S, V8.2S, V7.2S
    FMAXNMP  V18.4S, V24.4S, V24.4S
    FMAXP  V27.2D, V18.2D, V6.2D
    FMINNMP S4, V0.2S
    SMAXV  H12, V9.8H
    FMINNM  V16.8H, V4.8H, V27.8H
    FMAXNMP S10, V22.2S
    FMIN  V29.8H, V26.8H, V16.8H
    UMAXP  V18.4H, V0.4H, V12.4H
    FMINNMP D14, V19.2D
    SMIN  V5.2S, V31.2S, V14.2S
    FMAXNMP  V17.8H, V5.8H, V18.8H
    FMAXNMV  S15, V7.4S
    SMINV  S30, V15.4S
    FMAXP  V18.4S, V10.4S, V30.4S
    UMINV  S14, V17.4S
    FMINNMP S6, V18.2S
    FMAXNMP H18, V1.2H
    SMAXP  V28.4S, V29.4S, V29.4S
    UMIN  V5.4S, V18.4S, V14.4S
    FMINV  H8, V6.4H
    FMAXV  H30, V2.8H
    FMAXP  V16.8H, V3.8H, V20.8H
    FMINNM  V2.2D, V16.2D, V5.2D
    FMINNM  V16.4H, V24.4H, V28.4H
    FMINP S5, V12.2S
    FMINNM  V7.4S, V2.4S, V30.4S
    UMAXV  B12, V5.16B
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_0
    MOVZ  X12, #0xdad8, LSL #0
    MOVK  X12, #0xeeeb, LSL #16
    MOVK  X12, #0x93f6, LSL #32
    MOVK  X12, #0x7fad, LSL #48
    SUB  X20, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x57d9, LSL #0
    MOVK  X12, #0x3418, LSL #16
    MOVK  X12, #0x5020, LSL #32
    MOVK  X12, #0x6c07, LSL #48
    SUB  X20, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x469a, LSL #0
    MOVK  X12, #0x8b2, LSL #16
    MOVK  X12, #0x9740, LSL #32
    MOVK  X12, #0x1ee7, LSL #48
    SUB  X20, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x213e, LSL #0
    MOVK  X12, #0x7675, LSL #16
    MOVK  X12, #0x76f9, LSL #32
    MOVK  X12, #0x6fd1, LSL #48
    SUB  X20, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x9315, LSL #0
    MOVK  X12, #0x454, LSL #16
    MOVK  X12, #0x9767, LSL #32
    MOVK  X12, #0xe0b7, LSL #48
    SUB  X20, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x6964, LSL #0
    MOVK  X12, #0xc44f, LSL #16
    MOVK  X12, #0xa0be, LSL #32
    MOVK  X12, #0x7866, LSL #48
    SUB  X20, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xed6f, LSL #0
    MOVK  X12, #0x8479, LSL #16
    MOVK  X12, #0x4416, LSL #32
    MOVK  X12, #0xe022, LSL #48
    SUB  X20, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xc018, LSL #0
    MOVK  X12, #0x5d0f, LSL #16
    MOVK  X12, #0x137f, LSL #32
    MOVK  X12, #0x8b67, LSL #48
    SUB  X20, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x272a, LSL #0
    MOVK  X12, #0x7b86, LSL #16
    MOVK  X12, #0x13b5, LSL #32
    MOVK  X12, #0x1ba0, LSL #48
    SUB  X20, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x6b88, LSL #0
    MOVK  X12, #0x7f42, LSL #16
    MOVK  X12, #0x87d9, LSL #32
    MOVK  X12, #0x8404, LSL #48
    SUB  X20, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xd454, LSL #0
    MOVK  X12, #0x2ad2, LSL #16
    MOVK  X12, #0xd26c, LSL #32
    MOVK  X12, #0x7169, LSL #48
    SUB  X20, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x156e, LSL #0
    MOVK  X12, #0x1adf, LSL #16
    MOVK  X12, #0x90a2, LSL #32
    MOVK  X12, #0xab93, LSL #48
    SUB  X20, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x8399, LSL #0
    MOVK  X12, #0x4111, LSL #16
    MOVK  X12, #0xbc83, LSL #32
    MOVK  X12, #0x8e34, LSL #48
    SUB  X20, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xc0d3, LSL #0
    MOVK  X12, #0x31eb, LSL #16
    MOVK  X12, #0x69eb, LSL #32
    MOVK  X12, #0x5438, LSL #48
    SUB  X20, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x2e2, LSL #0
    MOVK  X12, #0x5f0e, LSL #16
    MOVK  X12, #0x337e, LSL #32
    MOVK  X12, #0x9e88, LSL #48
    SUB  X20, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x5491, LSL #0
    MOVK  X12, #0x5d7f, LSL #16
    MOVK  X12, #0x1679, LSL #32
    MOVK  X12, #0x73ec, LSL #48
    SUB  X20, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x35, LSL #0
    MOVK  X12, #0x62f1, LSL #16
    MOVK  X12, #0x7126, LSL #32
    MOVK  X12, #0x45e5, LSL #48
    SUB  X20, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x5e20, LSL #0
    MOVK  X12, #0xd1ef, LSL #16
    MOVK  X12, #0xe3d7, LSL #32
    MOVK  X12, #0x2586, LSL #48
    SUB  X20, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x693a, LSL #0
    MOVK  X12, #0x5e43, LSL #16
    MOVK  X12, #0x2d4f, LSL #32
    MOVK  X12, #0xd050, LSL #48
    SUB  X20, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X12, FPSR
    MOVZ  X20, #0x80, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D0
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D1
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D5
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D9
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D11
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D17
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D20
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D28
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D30
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D31
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X22
    FMOV  V0.D[1], X11
    FMOV  D1, X7
    FMOV  V1.D[1], X14
    FMOV  D2, X12
    FMOV  V2.D[1], X23
    FMOV  D3, X18
    FMOV  V3.D[1], X17
    FMOV  D4, X23
    FMOV  V4.D[1], X11
    FMOV  D5, X22
    FMOV  V5.D[1], X20
    FMOV  D6, X21
    FMOV  V6.D[1], X19
    FMOV  D7, X29
    FMOV  V7.D[1], X2
    FMOV  D8, X29
    FMOV  V8.D[1], X4
    FMOV  D9, X8
    FMOV  V9.D[1], X8
    FMOV  D10, X16
    FMOV  V10.D[1], X22
    FMOV  D11, X23
    FMOV  V11.D[1], X18
    FMOV  D12, X3
    FMOV  V12.D[1], X20
    FMOV  D13, X16
    FMOV  V13.D[1], X18
    FMOV  D14, X10
    FMOV  V14.D[1], X5
    FMOV  D15, X17
    FMOV  V15.D[1], X8
    FMOV  D16, X16
    FMOV  V16.D[1], X29
    FMOV  D17, X29
    FMOV  V17.D[1], X19
    FMOV  D18, X14
    FMOV  V18.D[1], X18
    FMOV  D19, X8
    FMOV  V19.D[1], X21
    FMOV  D20, X6
    FMOV  V20.D[1], X14
    FMOV  D21, X21
    FMOV  V21.D[1], X9
    FMOV  D22, X22
    FMOV  V22.D[1], X14
    FMOV  D23, X11
    FMOV  V23.D[1], X2
    FMOV  D24, X9
    FMOV  V24.D[1], X4
    FMOV  D25, X4
    FMOV  V25.D[1], X21
    FMOV  D26, X22
    FMOV  V26.D[1], X5
    FMOV  D27, X16
    FMOV  V27.D[1], X7
    FMOV  D28, X16
    FMOV  V28.D[1], X17
    FMOV  D29, X21
    FMOV  V29.D[1], X17
    FMOV  D30, X6
    FMOV  V30.D[1], X10
    FMOV  D31, X10
    FMOV  V31.D[1], X22
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_1:
    UMAX  V26.8H, V21.8H, V25.8H
    UMINV  H2, V22.4H
    FMAXNM  V11.8H, V6.8H, V27.8H
    FMAXP H7, V29.2H
    UMINV  B3, V30.8B
    FMAXNMP  V21.8H, V11.8H, V31.8H
    UMAXV  H9, V2.8H
    SMINV  H2, V16.4H
    FMAXNMP D22, V5.2D
    FMAXP H9, V5.2H
    FMIN  V18.4S, V28.4S, V22.4S
    FMAXV  H9, V21.8H
    UMAXV  B9, V9.8B
    FMINNMP H19, V8.2H
    FMAXNM  V13.8H, V7.8H, V8.8H
    UMAXV  B26, V25.16B
    FMINP  V29.4H, V5.4H, V28.4H
    FMAXNMP S4, V2.2S
    FMINP D24, V13.2D
    FMINP H6, V19.2H
    FMAXNM  V16.2D, V6.2D, V16.2D
    UMIN  V3.16B, V21.16B, V4.16B
    FMINNMP D8, V31.2D
    UMAXV  B31, V16.16B
    UMAX  V13.16B, V27.16B, V9.16B
    SMIN  V28.2S, V8.2S, V29.2S
    UMINV  B21, V29.16B
    FMINV  S5, V31.4S
    FMAXNMP  V28.2D, V28.2D, V28.2D
    FMAX  V8.8H, V5.8H, V3.8H
    FMAXNMP S7, V26.2S
    FMAXNM  V29.4S, V21.4S, V28.4S
    UMAX  V21.8B, V24.8B, V13.8B
    FMINP  V16.8H, V18.8H, V29.8H
    SMAXV  B11, V17.16B
    FMAXNM  V2.8H, V7.8H, V21.8H
    FMAXP S22, V22.2S
    FMAXV  H14, V22.4H
    UMINV  H7, V11.8H
    SMINV  B25, V6.16B
    FMINV  H6, V2.4H
    UMINV  B19, V17.8B
    FMAXV  S31, V14.4S
    FMINNM  V27.4S, V5.4S, V7.4S
    SMAXV  H11, V19.4H
    FMAXNMP  V13.2S, V28.2S, V7.2S
    UMAXP  V4.8B, V11.8B, V25.8B
    FMAXP D21, V17.2D
    FMAXP  V28.2D, V27.2D, V13.2D
    FMINP D26, V4.2D
    UMINV  S2, V21.4S
    FMINV  S25, V22.4S
    FMINP S21, V16.2S
    FMAX  V4.2S, V25.2S, V24.2S
    FMINP D24, V4.2D
    SMAXV  H11, V31.8H
    UMIN  V7.16B, V3.16B, V21.16B
    SMAXV  B19, V8.8B
    FMINNMP D28, V7.2D
    UMINP  V31.4H, V10.4H, V6.4H
    FMAXP S3, V19.2S
    FMAXP S5, V17.2S
    FMINP  V14.2S, V25.2S, V31.2S
    SMINP  V7.8H, V2.8H, V26.8H
    FMINNMP S2, V28.2S
    UMAXV  B19, V5.16B
    FMAXV  S14, V12.4S
    UMAXV  H15, V28.4H
    FMAXNMV  S25, V11.4S
    UMAXP  V25.8H, V19.8H, V27.8H
    UMAX  V13.16B, V14.16B, V14.16B
    FMAXNMP  V8.2D, V27.2D, V24.2D
    FMIN  V27.8H, V3.8H, V26.8H
    SMINV  H31, V25.8H
    SMAXV  S4, V8.4S
    UMIN  V10.2S, V12.2S, V31.2S
    FMINNMV  H14, V1.8H
    FMINV  S12, V4.4S
    FMAX  V21.4H, V14.4H, V27.4H
    FMINP  V27.2D, V7.2D, V10.2D
    FMINP  V5.8H, V5.8H, V27.8H
    FMINP S11, V21.2S
    FMAXP  V17.4H, V5.4H, V15.4H
    SMAXV  B15, V17.8B
    FMAXNMP  V2.4H, V16.4H, V13.4H
    FMAXP  V6.8H, V27.8H, V11.8H
    FMINP S24, V16.2S
    SMAXP  V17.4S, V15.4S, V3.4S
    SMAXP  V13.8H, V6.8H, V2.8H
    SMINV  S5, V17.4S
    FMAXP H2, V0.2H
    UMINV  B6, V2.16B
    SMAXV  H21, V3.8H
    UMIN  V14.4S, V11.4S, V21.4S
    FMINNMP  V24.8H, V13.8H, V10.8H
    FMINNMV  H16, V24.8H
    FMAXNMP  V17.4H, V8.4H, V6.4H
    UMIN  V15.8H, V25.8H, V14.8H
    FMAXP H1, V5.2H
    FMINP H24, V10.2H
    FMINNM  V14.4H, V16.4H, V15.4H
    FMIN  V0.2D, V11.2D, V24.2D
    SMAX  V5.16B, V17.16B, V12.16B
    FMAXP  V7.2D, V13.2D, V0.2D
    FMAXNMV  H27, V7.4H
    SMINV  B13, V27.8B
    SMAX  V6.4S, V13.4S, V30.4S
    FMINNMV  S25, V5.4S
    UMAXV  S1, V20.4S
    FMIN  V24.2D, V25.2D, V24.2D
    UMINP  V13.4S, V1.4S, V6.4S
    SMINV  H15, V13.8H
    FMAXNM  V3.2S, V15.2S, V15.2S
    SMINV  B16, V14.16B
    SMAXV  B15, V16.8B
    FMINP H27, V3.2H
    UMINV  H3, V11.4H
    FMINP S12, V28.2S
    UMAXV  B20, V18.8B
    FMINNMP  V13.8H, V20.8H, V24.8H
    SMIN  V6.16B, V27.16B, V10.16B
    FMINP D1, V27.2D
    FMINNM  V16.2D, V6.2D, V15.2D
    UMINP  V0.2S, V4.2S, V12.2S
    FMAXP H25, V13.2H
    FMAXP S18, V9.2S
    FMINP  V15.8H, V18.8H, V1.8H
    SMINV  S5, V3.4S
    SMINV  B11, V25.8B
    SMIN  V12.4S, V15.4S, V5.4S
    SMINV  B18, V16.8B
    FMINP H28, V12.2H
    FMAXP D8, V11.2D
    SMINV  B4, V18.8B
    FMINNMP H5, V28.2H
    UMIN  V16.4H, V30.4H, V31.4H
    UMINV  H3, V8.4H
    SMINP  V9.8H, V29.8H, V18.8H
    FMINNMP  V26.2S, V30.2S, V0.2S
    FMAXV  H8, V20.8H
    UMINV  B30, V26.8B
    FMAXNMP S12, V23.2S
    FMAX  V23.4H, V3.4H, V31.4H
    FMAXNMP S25, V11.2S
    FMIN  V18.8H, V5.8H, V16.8H
    FMINNMV  H26, V25.4H
    SMINV  H29, V23.8H
    UMINV  S0, V18.4S
    FMINP  V11.4S, V16.4S, V8.4S
    SMIN  V27.16B, V1.16B, V10.16B
    UMAX  V13.4H, V9.4H, V29.4H
    FMAXP H28, V5.2H
    FMINNM  V20.4S, V9.4S, V11.4S
    FMINNMP  V13.2S, V13.2S, V27.2S
    FMAXNMP S11, V0.2S
    FMINNMP S1, V30.2S
    SMAXP  V18.8H, V28.8H, V1.8H
    FMAXP S27, V20.2S
    UMAXV  S25, V27.4S
    FMAXV  H1, V13.8H
    FMAXNM  V30.8H, V17.8H, V25.8H
    FMAXP D13, V4.2D
    FMAXNMP S1, V18.2S
    FMIN  V20.4H, V13.4H, V30.4H
    FMINV  H0, V26.8H
    FMAXP  V18.4S, V11.4S, V0.4S
    SMIN  V31.16B, V14.16B, V20.16B
    FMINNMP D16, V10.2D
    FMINNMV  H10, V4.4H
    SMAXP  V27.4S, V16.4S, V12.4S
    FMINV  S26, V1.4S
    FMINNMP  V11.2S, V31.2S, V13.2S
    FMAXV  S14, V15.4S
    FMIN  V1.4H, V18.4H, V19.4H
    FMAXP  V13.4H, V25.4H, V28.4H
    FMAXV  H18, V14.8H
    SMINV  S3, V26.4S
    FMINNMP  V19.4S, V19.4S, V1.4S
    UMINV  S30, V27.4S
    FMAXNMP  V5.2D, V13.2D, V30.2D
    SMINV  S7, V2.4S
    FMAXNMP  V2.8H, V5.8H, V22.8H
    UMINP  V5.4S, V19.4S, V1.4S
    SMAXP  V16.16B, V3.16B, V11.16B
    FMINV  H17, V5.8H
    FMINNMV  H0, V7.4H
    FMIN  V11.8H, V10.8H, V12.8H
    FMAXP  V30.2D, V16.2D, V11.2D
    FMAXNMV  H25, V21.4H
    SMAXV  S22, V30.4S
    FMIN  V10.4H, V0.4H, V29.4H
    FMINP S1, V8.2S
    FMAX  V16.4H, V2.4H, V4.4H
    UMAXV  S5, V16.4S
    FMAXNMP S11, V22.2S
    FMAXNMV  S22, V25.4S
    FMINP S14, V1.2S
    FMINNMV  H0, V21.8H
    UMINV  B2, V22.16B
    FMINNM  V22.8H, V10.8H, V3.8H
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_1
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X8, FPSR
    MOVZ  X10, #0x80, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X8, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X29
    FMOV  V0.D[1], X6
    FMOV  D1, X20
    FMOV  V1.D[1], X15
    FMOV  D2, X20
    FMOV  V2.D[1], X22
    FMOV  D3, X2
    FMOV  V3.D[1], X23
    FMOV  D4, X4
    FMOV  V4.D[1], X6
    FMOV  D5, X29
    FMOV  V5.D[1], X21
    FMOV  D6, X15
    FMOV  V6.D[1], X29
    FMOV  D7, X14
    FMOV  V7.D[1], X22
    FMOV  D8, X19
    FMOV  V8.D[1], X8
    FMOV  D9, X13
    FMOV  V9.D[1], X5
    FMOV  D10, X14
    FMOV  V10.D[1], X8
    FMOV  D11, X15
    FMOV  V11.D[1], X4
    FMOV  D12, X19
    FMOV  V12.D[1], X13
    FMOV  D13, X15
    FMOV  V13.D[1], X23
    FMOV  D14, X5
    FMOV  V14.D[1], X23
    FMOV  D15, X16
    FMOV  V15.D[1], X12
    FMOV  D16, X14
    FMOV  V16.D[1], X29
    FMOV  D17, X15
    FMOV  V17.D[1], X9
    FMOV  D18, X10
    FMOV  V18.D[1], X29
    FMOV  D19, X18
    FMOV  V19.D[1], X10
    FMOV  D20, X4
    FMOV  V20.D[1], X19
    FMOV  D21, X3
    FMOV  V21.D[1], X13
    FMOV  D22, X11
    FMOV  V22.D[1], X29
    FMOV  D23, X23
    FMOV  V23.D[1], X4
    FMOV  D24, X16
    FMOV  V24.D[1], X4
    FMOV  D25, X12
    FMOV  V25.D[1], X29
    FMOV  D26, X13
    FMOV  V26.D[1], X2
    FMOV  D27, X23
    FMOV  V27.D[1], X13
    FMOV  D28, X15
    FMOV  V28.D[1], X15
    FMOV  D29, X14
    FMOV  V29.D[1], X20
    FMOV  D30, X13
    FMOV  V30.D[1], X22
    FMOV  D31, X4
    FMOV  V31.D[1], X6
    MOVZ  X12, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_2:
    FMAXNM  V13.8H, V26.8H, V30.8H
    UMAX  V25.8H, V6.8H, V4.8H
    FMAXNMP  V19.8H, V25.8H, V27.8H
    FMINNMP  V17.4H, V28.4H, V24.4H
    FMAXP  V18.2D, V31.2D, V13.2D
    SMAXV  B22, V0.8B
    SMAX  V6.8H, V20.8H, V15.8H
    FMAXNM  V26.4H, V3.4H, V29.4H
    FMAX  V19.2S, V26.2S, V18.2S
    FMAX  V31.4H, V22.4H, V26.4H
    UMINV  B10, V6.16B
    FMINNM  V25.8H, V21.8H, V23.8H
    FMAXP S0, V31.2S
    FMINNMV  H18, V25.8H
    UMAXP  V17.4S, V15.4S, V1.4S
    FMAXNMV  S9, V18.4S
    FMINV  S7, V15.4S
    UMINV  S21, V12.4S
    FMAX  V23.2D, V18.2D, V21.2D
    UMAXV  S28, V0.4S
    FMINP H6, V4.2H
    FMINNMP  V22.2D, V7.2D, V19.2D
    FMINNMP D20, V19.2D
    FMINV  S13, V10.4S
    UMAXV  B9, V12.8B
    FMAXP S15, V20.2S
    UMINV  B12, V6.16B
    FMAX  V19.8H, V28.8H, V11.8H
    FMINNMP  V3.8H, V23.8H, V12.8H
    FMAXNMP S20, V24.2S
    FMINP  V10.4S, V16.4S, V20.4S
    FMINNMP  V6.2D, V17.2D, V17.2D
    FMINP  V17.4H, V22.4H, V9.4H
    UMINP  V12.4H, V10.4H, V15.4H
    SMAX  V21.2S, V15.2S, V4.2S
    FMAXP  V23.2D, V21.2D, V13.2D
    FMAXNMP S16, V17.2S
    FMAXNMP D10, V27.2D
    FMIN  V17.4H, V6.4H, V23.4H
    FMINNM  V20.4S, V26.4S, V3.4S
    FMAXP  V9.2S, V14.2S, V12.2S
    FMAXP H21, V0.2H
    FMAXNMV  S13, V1.4S
    UMAXV  H14, V3.8H
    FMINP  V26.4S, V13.4S, V16.4S
    FMINNMP H1, V10.2H
    FMINNMP  V15.8H, V30.8H, V17.8H
    FMINNMV  S0, V21.4S
    FMAX  V4.4H, V1.4H, V1.4H
    SMINV  H3, V15.4H
    FMAXP D23, V5.2D
    SMAXV  B24, V19.16B
    FMINNMP  V30.4S, V22.4S, V24.4S
    SMAXV  B16, V3.16B
    FMAXP S10, V21.2S
    FMINP S13, V0.2S
    FMAXV  S6, V10.4S
    FMINNMP H1, V26.2H
    FMAXNM  V3.8H, V7.8H, V25.8H
    FMINNMP  V12.4S, V13.4S, V9.4S
    FMAXNM  V19.4S, V30.4S, V14.4S
    FMINNM  V9.2S, V20.2S, V4.2S
    FMINP D5, V12.2D
    FMIN  V22.8H, V5.8H, V16.8H
    UMAXV  B20, V19.8B
    UMINV  S7, V31.4S
    FMIN  V19.2S, V7.2S, V20.2S
    FMAXP  V31.4H, V1.4H, V6.4H
    FMIN  V24.8H, V23.8H, V19.8H
    UMIN  V26.8H, V7.8H, V22.8H
    FMINP  V12.8H, V17.8H, V6.8H
    SMINV  B13, V10.8B
    FMAXP  V15.8H, V3.8H, V9.8H
    FMINNMP  V23.8H, V13.8H, V26.8H
    FMINNMP  V22.2D, V31.2D, V15.2D
    FMAXV  S7, V12.4S
    SMAXV  S31, V22.4S
    FMINP  V30.4S, V31.4S, V31.4S
    UMIN  V26.4S, V10.4S, V29.4S
    FMAX  V15.4H, V13.4H, V31.4H
    FMAXNMP D29, V17.2D
    SMAXV  H25, V30.4H
    FMINNMP S9, V1.2S
    FMINP D10, V1.2D
    FMAXP S14, V23.2S
    UMIN  V19.4S, V10.4S, V29.4S
    UMAXP  V29.8H, V14.8H, V9.8H
    FMINNMP  V6.2S, V24.2S, V29.2S
    UMAXV  S12, V6.4S
    FMINNMP D31, V19.2D
    FMAXNMP  V24.8H, V15.8H, V0.8H
    FMAXNMP S3, V12.2S
    SMAXV  B17, V31.16B
    UMIN  V13.16B, V3.16B, V25.16B
    UMAXV  B0, V5.8B
    UMINV  H15, V11.4H
    SMINV  H25, V0.8H
    UMAXV  S5, V21.4S
    FMINV  H14, V24.4H
    UMINV  B19, V22.16B
    FMINP D29, V13.2D
    UMINV  H13, V6.8H
    SMAX  V31.16B, V29.16B, V16.16B
    FMINNMV  H11, V17.4H
    FMAXP  V12.8H, V29.8H, V7.8H
    FMAXNM  V16.2S, V5.2S, V24.2S
    SMAXP  V26.8H, V23.8H, V11.8H
    FMINP  V11.4H, V12.4H, V31.4H
    SMIN  V23.4H, V25.4H, V28.4H
    FMINP D22, V1.2D
    UMAXP  V28.8B, V15.8B, V11.8B
    FMAXP D29, V3.2D
    FMINNMP D15, V16.2D
    FMAXNMV  H14, V28.8H
    FMINV  S28, V28.4S
    FMIN  V31.4S, V8.4S, V29.4S
    SMINV  H8, V22.8H
    FMINNMP  V6.4S, V13.4S, V15.4S
    FMINNM  V16.4H, V19.4H, V7.4H
    FMIN  V27.4H, V19.4H, V18.4H
    SMAX  V24.4H, V6.4H, V28.4H
    FMINV  S21, V23.4S
    UMINV  S0, V16.4S
    FMINP S11, V14.2S
    SMINP  V22.4S, V26.4S, V21.4S
    FMAXNM  V4.4S, V31.4S, V0.4S
    FMINV  S21, V4.4S
    FMINNMP H25, V18.2H
    UMAXP  V13.8H, V31.8H, V27.8H
    UMINV  H15, V6.8H
    FMAXNMP  V28.2D, V7.2D, V22.2D
    FMINP  V17.4H, V1.4H, V15.4H
    SMAXV  S4, V25.4S
    FMAXP  V23.4S, V16.4S, V8.4S
    FMAXP D4, V13.2D
    FMAXV  S27, V0.4S
    FMAXNM  V19.8H, V13.8H, V11.8H
    FMAX  V15.2D, V19.2D, V24.2D
    FMAXNMV  S26, V17.4S
    FMIN  V13.2D, V6.2D, V27.2D
    FMAXNMP S11, V21.2S
    FMINP D21, V13.2D
    FMAXV  S1, V26.4S
    FMINNMV  S13, V15.4S
    FMAXP D19, V13.2D
    FMIN  V24.8H, V16.8H, V4.8H
    FMAXNMP  V7.2D, V12.2D, V23.2D
    UMAXV  S23, V11.4S
    FMINNMV  S15, V29.4S
    FMINNMP  V9.2D, V1.2D, V28.2D
    FMINNMV  H12, V24.8H
    FMINP H27, V12.2H
    SMINV  B0, V23.16B
    FMAXNMP S11, V13.2S
    SMAXP  V13.8B, V21.8B, V9.8B
    UMINV  H28, V20.8H
    UMAXP  V17.8H, V0.8H, V25.8H
    FMINNM  V24.4H, V9.4H, V17.4H
    UMAXV  B21, V2.16B
    FMAXP  V2.8H, V7.8H, V27.8H
    UMAX  V7.8H, V19.8H, V11.8H
    FMIN  V11.8H, V2.8H, V24.8H
    SMINV  S25, V16.4S
    SMIN  V29.4S, V25.4S, V26.4S
    FMAXV  H0, V28.4H
    SMINV  S20, V29.4S
    FMINP H26, V15.2H
    FMAXNMP  V14.8H, V11.8H, V20.8H
    FMAXNMV  S18, V14.4S
    FMAXP  V17.4H, V7.4H, V26.4H
    SMAXV  B7, V13.16B
    FMINP  V20.4H, V7.4H, V17.4H
    FMAXNMP  V23.4S, V9.4S, V0.4S
    FMINP H24, V29.2H
    SMAXV  H28, V18.8H
    FMINNM  V27.4H, V8.4H, V2.4H
    FMINV  H0, V27.8H
    SMINV  H18, V21.8H
    SMINV  S17, V18.4S
    FMINP  V12.8H, V20.8H, V0.8H
    FMAXP H29, V12.2H
    FMAXP  V7.8H, V25.8H, V4.8H
    FMAX  V4.8H, V2.8H, V3.8H
    UMAXV  H3, V24.4H
    SMINV  S11, V4.4S
    FMAX  V24.2D, V3.2D, V3.2D
    FMAXNMV  H13, V17.8H
    FMAXNMP D30, V11.2D
    FMINV  S17, V30.4S
    FMAXNMP H26, V18.2H
    FMINP  V27.4S, V23.4S, V11.4S
    FMAX  V9.4H, V24.4H, V7.4H
    FMINNM  V7.4H, V23.4H, V13.4H
    FMAXP S12, V24.2S
    FMAXP H30, V10.2H
    UMINV  S10, V16.4S
    UMAX  V20.4H, V30.4H, V9.4H
    FMAXNMP  V3.2D, V17.2D, V20.2D
    FMINP  V8.4S, V14.4S, V4.4S
    SMAXV  H30, V9.8H
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_2
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X16, FPSR
    MOVZ  X13, #0x80, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X2
    FMOV  V0.D[1], X15
    FMOV  D1, X20
    FMOV  V1.D[1], X29
    FMOV  D2, X22
    FMOV  V2.D[1], X21
    FMOV  D3, X23
    FMOV  V3.D[1], X13
    FMOV  D4, X23
    FMOV  V4.D[1], X29
    FMOV  D5, X9
    FMOV  V5.D[1], X13
    FMOV  D6, X9
    FMOV  V6.D[1], X29
    FMOV  D7, X20
    FMOV  V7.D[1], X6
    FMOV  D8, X20
    FMOV  V8.D[1], X6
    FMOV  D9, X5
    FMOV  V9.D[1], X18
    FMOV  D10, X18
    FMOV  V10.D[1], X21
    FMOV  D11, X20
    FMOV  V11.D[1], X18
    FMOV  D12, X20
    FMOV  V12.D[1], X15
    FMOV  D13, X2
    FMOV  V13.D[1], X10
    FMOV  D14, X9
    FMOV  V14.D[1], X14
    FMOV  D15, X8
    FMOV  V15.D[1], X11
    FMOV  D16, X10
    FMOV  V16.D[1], X19
    FMOV  D17, X6
    FMOV  V17.D[1], X17
    FMOV  D18, X11
    FMOV  V18.D[1], X10
    FMOV  D19, X9
    FMOV  V19.D[1], X8
    FMOV  D20, X23
    FMOV  V20.D[1], X19
    FMOV  D21, X29
    FMOV  V21.D[1], X14
    FMOV  D22, X22
    FMOV  V22.D[1], X23
    FMOV  D23, X2
    FMOV  V23.D[1], X9
    FMOV  D24, X19
    FMOV  V24.D[1], X19
    FMOV  D25, X6
    FMOV  V25.D[1], X4
    FMOV  D26, X14
    FMOV  V26.D[1], X13
    FMOV  D27, X11
    FMOV  V27.D[1], X9
    FMOV  D28, X9
    FMOV  V28.D[1], X18
    FMOV  D29, X22
    FMOV  V29.D[1], X6
    FMOV  D30, X3
    FMOV  V30.D[1], X7
    FMOV  D31, X16
    FMOV  V31.D[1], X9
    MOVZ  X22, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_3:
    FMINNM  V12.4H, V21.4H, V27.4H
    UMINV  B20, V31.8B
    FMIN  V2.2D, V26.2D, V30.2D
    FMIN  V26.8H, V20.8H, V12.8H
    FMAXNMP  V3.8H, V29.8H, V1.8H
    FMINNMP D21, V27.2D
    FMINP H4, V12.2H
    SMINV  B12, V4.16B
    FMAXV  H0, V12.8H
    FMINNMP  V23.4S, V0.4S, V0.4S
    UMIN  V6.8H, V9.8H, V23.8H
    FMINP H18, V24.2H
    FMINNMP H8, V5.2H
    UMAXV  S28, V22.4S
    UMAXV  B0, V18.8B
    FMAXV  S23, V0.4S
    SMINV  S29, V28.4S
    SMAXV  B22, V14.16B
    FMINNMP D0, V22.2D
    FMINV  H22, V23.8H
    FMINNM  V28.2S, V29.2S, V29.2S
    FMAX  V20.8H, V3.8H, V26.8H
    FMINP D12, V31.2D
    UMINV  S17, V8.4S
    FMINNMP H14, V17.2H
    FMINP  V5.4H, V21.4H, V20.4H
    FMAX  V26.8H, V0.8H, V12.8H
    SMAXV  S2, V24.4S
    FMINNMP  V26.2S, V5.2S, V13.2S
    FMAX  V18.8H, V12.8H, V28.8H
    FMAXNM  V1.8H, V22.8H, V26.8H
    FMINP  V5.2S, V2.2S, V14.2S
    FMAXNMV  H2, V1.8H
    FMAXNMV  H28, V22.8H
    FMAXP H12, V5.2H
    FMINP H3, V28.2H
    FMAXP D22, V18.2D
    SMAX  V17.2S, V22.2S, V3.2S
    FMAXP H5, V15.2H
    FMINNMP  V31.8H, V12.8H, V30.8H
    FMAXV  H28, V17.4H
    FMAXNMV  H3, V19.4H
    SMAXV  H30, V3.8H
    FMINP D1, V28.2D
    SMINP  V20.8B, V1.8B, V31.8B
    FMINNMP H21, V2.2H
    UMINV  S13, V12.4S
    FMINNMP S15, V3.2S
    FMAX  V18.2D, V9.2D, V20.2D
    FMAXNMP  V19.8H, V5.8H, V1.8H
    FMIN  V17.4H, V13.4H, V11.4H
    FMAXNMP S20, V30.2S
    FMINNMP H30, V13.2H
    FMAXNMP S13, V19.2S
    FMINP S16, V22.2S
    FMINP D3, V15.2D
    UMAX  V25.8B, V23.8B, V20.8B
    FMAXNMV  H26, V3.8H
    FMAXNM  V5.2D, V25.2D, V21.2D
    FMAXNM  V31.4H, V26.4H, V5.4H
    FMINNM  V26.2S, V13.2S, V13.2S
    FMINP  V22.2S, V24.2S, V30.2S
    FMAXNMP D11, V16.2D
    FMAXP  V20.2S, V11.2S, V26.2S
    SMAX  V2.4S, V17.4S, V22.4S
    FMINNMV  H23, V27.8H
    FMAXNMP S10, V18.2S
    FMINNMP H21, V10.2H
    SMIN  V9.2S, V31.2S, V29.2S
    FMAXV  H1, V30.8H
    SMAXV  S18, V22.4S
    SMAXV  B17, V21.16B
    SMINV  B30, V18.16B
    UMAX  V16.8B, V23.8B, V17.8B
    FMAXNMP D22, V27.2D
    FMINNMV  S17, V16.4S
    FMINNMP  V16.2D, V9.2D, V28.2D
    SMAX  V21.4S, V27.4S, V9.4S
    SMINV  H18, V2.4H
    FMAXV  H26, V16.4H
    FMINNMP D13, V18.2D
    FMINP  V31.4H, V23.4H, V30.4H
    FMAXNMP H24, V17.2H
    SMINV  B0, V1.8B
    FMINNM  V3.8H, V0.8H, V5.8H
    FMINNMP D17, V22.2D
    UMAX  V18.4S, V13.4S, V6.4S
    SMIN  V9.8B, V18.8B, V21.8B
    UMAXV  B22, V9.8B
    FMAX  V2.4S, V20.4S, V31.4S
    FMAXP  V23.2D, V24.2D, V22.2D
    FMINNMV  S26, V17.4S
    FMAXNM  V5.2S, V23.2S, V9.2S
    SMAX  V13.8H, V23.8H, V5.8H
    FMINP S6, V3.2S
    FMINV  H28, V6.4H
    SMINV  S24, V13.4S
    FMINNMP  V3.2S, V23.2S, V19.2S
    FMINP D16, V24.2D
    SMAXV  H1, V24.8H
    FMIN  V25.8H, V17.8H, V16.8H
    SMIN  V4.4H, V2.4H, V3.4H
    FMINNMP S20, V4.2S
    UMIN  V19.8B, V1.8B, V10.8B
    FMAXNM  V2.4H, V29.4H, V19.4H
    FMAXNMP  V13.4H, V28.4H, V28.4H
    UMAXV  S22, V20.4S
    FMAXNMP S10, V17.2S
    SMAXP  V3.16B, V25.16B, V6.16B
    FMAXP S20, V2.2S
    UMINV  S9, V10.4S
    SMAXV  S19, V13.4S
    FMAX  V23.4S, V20.4S, V12.4S
    FMINNMP  V13.2D, V26.2D, V7.2D
    FMINNMP  V8.4S, V13.4S, V9.4S
    UMIN  V9.8H, V12.8H, V22.8H
    FMAX  V4.4H, V19.4H, V21.4H
    FMAX  V29.8H, V6.8H, V3.8H
    FMAXNMV  S17, V29.4S
    SMIN  V24.4S, V9.4S, V0.4S
    FMINNMP  V11.8H, V12.8H, V4.8H
    FMAXP H7, V8.2H
    FMAXP H12, V5.2H
    FMINNMV  S9, V23.4S
    FMAXNMP D20, V22.2D
    FMINNM  V26.8H, V28.8H, V11.8H
    UMINV  S19, V25.4S
    FMINP S11, V21.2S
    FMAXNMP  V4.8H, V9.8H, V11.8H
    FMAXNMV  H21, V28.8H
    FMINP  V18.2S, V2.2S, V15.2S
    UMAXV  B8, V31.8B
    UMAXV  S6, V31.4S
    FMINNMV  S11, V26.4S
    FMAXV  S15, V4.4S
    FMAX  V4.8H, V15.8H, V18.8H
    FMAXP H9, V17.2H
    UMAXV  B28, V21.8B
    FMINNM  V23.2D, V27.2D, V6.2D
    SMAXP  V18.8B, V9.8B, V7.8B
    SMAXP  V27.4H, V15.4H, V6.4H
    FMINNMP  V6.4S, V21.4S, V11.4S
    FMAXNMV  S7, V6.4S
    UMINV  B21, V13.8B
    FMAXNMP  V17.4S, V20.4S, V4.4S
    FMINNMP H25, V11.2H
    FMAXNMP S29, V23.2S
    FMAXV  H14, V18.8H
    FMINP S18, V25.2S
    FMAXP D15, V21.2D
    FMINNMP S23, V17.2S
    UMINV  S20, V6.4S
    FMINNMP D6, V7.2D
    FMINNM  V5.2S, V27.2S, V20.2S
    FMINNMP H17, V6.2H
    FMINNMV  S27, V25.4S
    SMIN  V6.4H, V14.4H, V29.4H
    FMAXNMP H9, V8.2H
    FMINNMP H11, V4.2H
    SMAX  V31.8B, V9.8B, V28.8B
    FMINNMP  V10.4S, V11.4S, V6.4S
    FMINNM  V9.8H, V27.8H, V18.8H
    FMAXNM  V18.4H, V16.4H, V17.4H
    FMINP  V20.2S, V18.2S, V6.2S
    FMAXP  V4.4S, V12.4S, V27.4S
    FMINNMP  V29.4S, V20.4S, V11.4S
    FMAXP S11, V31.2S
    UMAXV  H27, V11.4H
    FMAXNM  V17.8H, V4.8H, V9.8H
    FMINNM  V9.2S, V10.2S, V26.2S
    FMINNM  V10.2S, V23.2S, V9.2S
    FMINV  S1, V17.4S
    FMINNMP D11, V29.2D
    UMINV  S8, V5.4S
    FMAXNM  V29.4H, V13.4H, V10.4H
    SMINV  S20, V29.4S
    FMINV  S17, V1.4S
    FMAXP D6, V17.2D
    FMAXNM  V17.2D, V0.2D, V27.2D
    FMAXV  S9, V8.4S
    SMAX  V28.4S, V15.4S, V21.4S
    FMINNMP D29, V24.2D
    FMAXP D0, V2.2D
    FMINNMP  V26.8H, V17.8H, V11.8H
    FMAXNMP H27, V0.2H
    SMAXP  V12.4S, V29.4S, V29.4S
    FMAXP S14, V27.2S
    FMINP  V27.8H, V28.8H, V12.8H
    FMINV  S16, V14.4S
    FMINP H24, V9.2H
    FMINNM  V27.2S, V26.2S, V2.2S
    FMAXNMP  V12.4H, V17.4H, V11.4H
    FMAXV  H23, V15.8H
    FMIN  V26.8H, V27.8H, V6.8H
    FMINP  V2.8H, V10.8H, V15.8H
    FMAXV  H6, V26.4H
    FMINNMP H21, V24.2H
    FMAXNMP H29, V16.2H
    FMAXNMV  H11, V12.4H
    FMAXP D12, V6.2D
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_3
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X2, FPSR
    MOVZ  X23, #0x80, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D0
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D1
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D9
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D11
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D20
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D23
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D28
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D30
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D31
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X15
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X9
    FMOV  D2, X23
    FMOV  V2.D[1], X21
    FMOV  D3, X21
    FMOV  V3.D[1], X13
    FMOV  D4, X16
    FMOV  V4.D[1], X13
    FMOV  D5, X29
    FMOV  V5.D[1], X23
    FMOV  D6, X20
    FMOV  V6.D[1], X10
    FMOV  D7, X22
    FMOV  V7.D[1], X4
    FMOV  D8, X19
    FMOV  V8.D[1], X16
    FMOV  D9, X3
    FMOV  V9.D[1], X29
    FMOV  D10, X20
    FMOV  V10.D[1], X13
    FMOV  D11, X29
    FMOV  V11.D[1], X9
    FMOV  D12, X18
    FMOV  V12.D[1], X14
    FMOV  D13, X15
    FMOV  V13.D[1], X23
    FMOV  D14, X15
    FMOV  V14.D[1], X6
    FMOV  D15, X9
    FMOV  V15.D[1], X2
    FMOV  D16, X21
    FMOV  V16.D[1], X29
    FMOV  D17, X7
    FMOV  V17.D[1], X11
    FMOV  D18, X2
    FMOV  V18.D[1], X8
    FMOV  D19, X23
    FMOV  V19.D[1], X12
    FMOV  D20, X14
    FMOV  V20.D[1], X17
    FMOV  D21, X6
    FMOV  V21.D[1], X10
    FMOV  D22, X2
    FMOV  V22.D[1], X19
    FMOV  D23, X10
    FMOV  V23.D[1], X18
    FMOV  D24, X29
    FMOV  V24.D[1], X18
    FMOV  D25, X11
    FMOV  V25.D[1], X18
    FMOV  D26, X7
    FMOV  V26.D[1], X4
    FMOV  D27, X4
    FMOV  V27.D[1], X17
    FMOV  D28, X14
    FMOV  V28.D[1], X12
    FMOV  D29, X23
    FMOV  V29.D[1], X3
    FMOV  D30, X7
    FMOV  V30.D[1], X7
    FMOV  D31, X17
    FMOV  V31.D[1], X4
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_4:
    SMAXV  B8, V24.16B
    UMAXV  S18, V22.4S
    UMAXV  S0, V31.4S
    SMAXV  S16, V13.4S
    SMINV  S20, V20.4S
    FMAXP D11, V16.2D
    FMINNM  V8.4H, V18.4H, V25.4H
    FMINNM  V16.2S, V26.2S, V21.2S
    FMAXNMP S29, V29.2S
    FMINV  S23, V29.4S
    SMINV  H30, V13.8H
    FMINNMV  H4, V8.8H
    FMINP H16, V15.2H
    FMIN  V0.8H, V20.8H, V19.8H
    FMAXV  H16, V23.8H
    SMAX  V8.8B, V0.8B, V11.8B
    FMAXNMV  H0, V10.4H
    FMINNMV  S2, V0.4S
    FMAXNM  V31.4S, V16.4S, V16.4S
    SMAXV  S26, V30.4S
    SMINV  B11, V31.16B
    FMAXNM  V14.2S, V2.2S, V26.2S
    FMINNMP S23, V11.2S
    SMAXV  B22, V16.8B
    FMAXNMP H26, V18.2H
    FMINV  H18, V21.8H
    FMAXNMV  S11, V18.4S
    FMINP  V15.4H, V8.4H, V22.4H
    UMAXV  H9, V22.8H
    FMAXNM  V25.2D, V11.2D, V4.2D
    FMAXP  V27.2S, V29.2S, V6.2S
    FMAXP  V0.8H, V16.8H, V1.8H
    FMAXNMP  V6.2D, V9.2D, V26.2D
    FMAXNM  V29.8H, V22.8H, V14.8H
    FMINNMP D16, V28.2D
    SMAX  V18.4H, V15.4H, V15.4H
    FMAXNMP H11, V23.2H
    FMINP D21, V28.2D
    SMINV  S22, V26.4S
    SMINP  V13.8H, V29.8H, V17.8H
    FMAXNM  V17.2D, V13.2D, V18.2D
    FMAXP D26, V22.2D
    UMAXV  S1, V28.4S
    FMINNMP H29, V17.2H
    SMINV  S31, V29.4S
    FMINV  S6, V25.4S
    UMAXP  V23.8H, V26.8H, V11.8H
    SMIN  V8.8H, V23.8H, V21.8H
    FMAXNMV  H14, V27.8H
    FMINNMP S13, V25.2S
    FMAXP  V22.4H, V5.4H, V1.4H
    SMINV  S12, V23.4S
    SMAXV  H9, V12.8H
    SMAXV  S5, V0.4S
    FMAXP S23, V31.2S
    SMIN  V1.4H, V2.4H, V22.4H
    FMAXNMV  H31, V26.8H
    FMINNMP  V4.8H, V8.8H, V6.8H
    FMIN  V25.4H, V4.4H, V4.4H
    FMINNMV  S4, V26.4S
    FMAX  V6.8H, V5.8H, V14.8H
    SMIN  V14.8B, V25.8B, V9.8B
    FMINNMP H8, V14.2H
    SMINV  H16, V14.8H
    FMINNM  V21.4H, V0.4H, V30.4H
    FMINP  V30.2D, V19.2D, V8.2D
    UMAXV  B12, V24.16B
    SMAXV  B10, V9.16B
    FMINV  S19, V22.4S
    FMINNM  V22.4H, V16.4H, V4.4H
    FMAX  V25.4H, V20.4H, V19.4H
    UMINV  S14, V6.4S
    FMINNMP  V5.4H, V13.4H, V14.4H
    FMINNM  V20.2S, V31.2S, V10.2S
    FMINNMP D16, V7.2D
    FMINNM  V8.4H, V30.4H, V12.4H
    SMIN  V13.8H, V8.8H, V16.8H
    FMAXNMP  V22.8H, V25.8H, V25.8H
    FMINNMP H24, V16.2H
    FMAXNMP  V9.4H, V21.4H, V25.4H
    FMAXP  V30.4H, V22.4H, V9.4H
    UMAX  V21.4H, V6.4H, V13.4H
    SMINV  H25, V20.8H
    SMINV  S28, V5.4S
    SMAXP  V4.4S, V21.4S, V29.4S
    FMAXNMV  S19, V4.4S
    SMAXV  B21, V30.8B
    FMINNMP D29, V22.2D
    FMINV  S7, V25.4S
    FMAXP S22, V25.2S
    SMAXV  S8, V21.4S
    FMAXP D21, V12.2D
    FMINP S14, V29.2S
    FMINP D29, V22.2D
    SMINV  B6, V20.16B
    SMAXP  V5.8B, V14.8B, V24.8B
    FMAXNMV  S8, V8.4S
    UMAXV  S30, V21.4S
    SMINV  B14, V7.8B
    FMINNMP D24, V30.2D
    FMINNMV  S9, V24.4S
    FMAXNMV  H13, V28.4H
    FMAXNMP H25, V7.2H
    FMIN  V23.8H, V17.8H, V9.8H
    UMAXV  B7, V23.16B
    UMAX  V15.16B, V29.16B, V5.16B
    FMAX  V6.8H, V8.8H, V20.8H
    FMINP S9, V3.2S
    FMINNM  V8.4S, V15.4S, V6.4S
    FMINNMP H28, V13.2H
    SMINV  S12, V25.4S
    SMAXV  H13, V1.8H
    UMAX  V29.4H, V7.4H, V30.4H
    FMINNMP  V3.2D, V31.2D, V9.2D
    SMINV  S21, V17.4S
    FMINP  V24.4H, V21.4H, V5.4H
    SMINP  V5.2S, V8.2S, V6.2S
    SMINV  S22, V12.4S
    UMAXV  B8, V27.16B
    FMINNM  V9.4S, V3.4S, V29.4S
    FMINP H8, V21.2H
    FMAXNM  V23.2D, V24.2D, V26.2D
    FMINNMP  V24.2S, V9.2S, V0.2S
    UMAX  V21.4H, V14.4H, V28.4H
    FMINP  V25.4H, V24.4H, V22.4H
    UMINV  S12, V7.4S
    FMINNM  V7.8H, V24.8H, V21.8H
    SMAXP  V31.4H, V5.4H, V13.4H
    FMAXNMV  H17, V24.8H
    SMINV  S27, V7.4S
    FMAXP D6, V8.2D
    FMINNMV  S3, V12.4S
    FMAXP S2, V31.2S
    FMAXP H12, V27.2H
    UMINP  V7.8H, V6.8H, V17.8H
    UMINP  V8.4S, V1.4S, V12.4S
    FMIN  V26.8H, V25.8H, V8.8H
    FMINNMP S28, V16.2S
    UMINV  H24, V23.8H
    SMINV  B6, V28.8B
    UMAXP  V25.4S, V12.4S, V6.4S
    FMINNMP S12, V8.2S
    UMAXV  B15, V0.16B
    SMAX  V0.2S, V27.2S, V17.2S
    FMAXP D28, V15.2D
    FMINNMP H5, V26.2H
    SMIN  V16.16B, V21.16B, V5.16B
    FMINNMP  V13.2S, V28.2S, V3.2S
    FMINP  V8.4H, V12.4H, V24.4H
    FMAXNM  V24.4H, V13.4H, V27.4H
    FMINNM  V5.2D, V8.2D, V13.2D
    FMAXP S17, V5.2S
    FMINP D5, V30.2D
    FMINV  H21, V4.4H
    UMINV  B30, V3.8B
    SMINV  H13, V25.4H
    FMIN  V3.8H, V21.8H, V17.8H
    FMAXV  S1, V5.4S
    FMINNM  V27.8H, V0.8H, V28.8H
    UMINV  B15, V0.8B
    UMIN  V16.16B, V2.16B, V16.16B
    SMAXV  B0, V15.16B
    FMAXV  H28, V3.4H
    FMINP D19, V11.2D
    UMINP  V5.8H, V3.8H, V24.8H
    FMINNM  V11.2D, V19.2D, V30.2D
    FMAXNM  V24.4H, V2.4H, V13.4H
    UMINV  B19, V20.16B
    FMAXP D3, V11.2D
    UMINP  V15.16B, V25.16B, V22.16B
    FMINNMV  S17, V0.4S
    SMAXV  H26, V3.4H
    FMINV  H30, V27.4H
    FMAXNMP H15, V24.2H
    FMINP D12, V17.2D
    FMINP  V16.4H, V23.4H, V1.4H
    UMINP  V20.8H, V5.8H, V5.8H
    UMIN  V21.4H, V22.4H, V0.4H
    UMAXP  V3.8B, V22.8B, V30.8B
    UMAXV  H25, V21.4H
    FMAXNMP  V27.2S, V16.2S, V13.2S
    UMAXP  V29.2S, V8.2S, V19.2S
    FMAXP D16, V3.2D
    FMAXP D5, V20.2D
    FMAXNMP S23, V25.2S
    FMAXNMP  V0.2S, V15.2S, V16.2S
    FMAXV  S21, V5.4S
    FMAXV  H2, V1.8H
    FMAXNMV  S15, V12.4S
    FMINNMV  S5, V27.4S
    FMINNM  V24.8H, V28.8H, V2.8H
    FMAXV  S19, V24.4S
    FMAXNMV  S8, V5.4S
    UMIN  V1.4H, V21.4H, V6.4H
    FMINP D27, V29.2D
    UMAXV  H16, V15.4H
    FMINP S10, V8.2S
    SMAX  V23.8H, V26.8H, V21.8H
    FMAX  V29.2S, V23.2S, V16.2S
    FMAXNMP S13, V27.2S
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_4
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X7, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X5, FPSR
    MOVZ  X7, #0x80, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X5, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xab54, LSL #0
    MOVK  X2, #0x3afe, LSL #16
    MOVK  X2, #0x5086, LSL #32
    MOVK  X2, #0x2fc6, LSL #48
    MOVZ  X3, #0x3c64, LSL #0
    MOVK  X3, #0xaea, LSL #16
    MOVK  X3, #0x750f, LSL #32
    MOVK  X3, #0xd41f, LSL #48
    MOVZ  X4, #0xb70b, LSL #0
    MOVK  X4, #0x4a0a, LSL #16
    MOVK  X4, #0xf970, LSL #32
    MOVK  X4, #0xa583, LSL #48
    MOVZ  X5, #0xb325, LSL #0
    MOVK  X5, #0xc814, LSL #16
    MOVK  X5, #0xab23, LSL #32
    MOVK  X5, #0xfc62, LSL #48
    MOVZ  X6, #0x783d, LSL #0
    MOVK  X6, #0x7450, LSL #16
    MOVK  X6, #0xc4a0, LSL #32
    MOVK  X6, #0x5a0b, LSL #48
    MOVZ  X7, #0xe3b7, LSL #0
    MOVK  X7, #0x155d, LSL #16
    MOVK  X7, #0xfa4e, LSL #32
    MOVK  X7, #0x2eb4, LSL #48
    MOVZ  X8, #0xf249, LSL #0
    MOVK  X8, #0x1132, LSL #16
    MOVK  X8, #0x5ea6, LSL #32
    MOVK  X8, #0x691a, LSL #48
    MOVZ  X9, #0x264d, LSL #0
    MOVK  X9, #0x640e, LSL #16
    MOVK  X9, #0x9d9, LSL #32
    MOVK  X9, #0x78f0, LSL #48
    MOVZ  X10, #0x5, LSL #0
    MOVK  X10, #0xe24e, LSL #16
    MOVK  X10, #0xc2e7, LSL #32
    MOVK  X10, #0xa923, LSL #48
    MOVZ  X11, #0x3922, LSL #0
    MOVK  X11, #0xc050, LSL #16
    MOVK  X11, #0x35c3, LSL #32
    MOVK  X11, #0x3aee, LSL #48
    MOVZ  X12, #0x901, LSL #0
    MOVK  X12, #0x1df5, LSL #16
    MOVK  X12, #0x280c, LSL #32
    MOVK  X12, #0x5c81, LSL #48
    MOVZ  X13, #0x7dd0, LSL #0
    MOVK  X13, #0xa9b1, LSL #16
    MOVK  X13, #0x406e, LSL #32
    MOVK  X13, #0xe1f1, LSL #48
    MOVZ  X14, #0x4511, LSL #0
    MOVK  X14, #0xeb43, LSL #16
    MOVK  X14, #0xbdf3, LSL #32
    MOVK  X14, #0x5ee5, LSL #48
    MOVZ  X15, #0x8631, LSL #0
    MOVK  X15, #0x2d6e, LSL #16
    MOVK  X15, #0x4003, LSL #32
    MOVK  X15, #0x27ee, LSL #48
    MOVZ  X16, #0x68a8, LSL #0
    MOVK  X16, #0xdea4, LSL #16
    MOVK  X16, #0xcc2a, LSL #32
    MOVK  X16, #0x5643, LSL #48
    MOVZ  X17, #0xe62f, LSL #0
    MOVK  X17, #0x8dde, LSL #16
    MOVK  X17, #0x7855, LSL #32
    MOVK  X17, #0x9f2c, LSL #48
    MOVZ  X18, #0x496b, LSL #0
    MOVK  X18, #0xc106, LSL #16
    MOVK  X18, #0x86ba, LSL #32
    MOVK  X18, #0x6e91, LSL #48
    MOVZ  X19, #0x5c7e, LSL #0
    MOVK  X19, #0xf3f0, LSL #16
    MOVK  X19, #0x6b0b, LSL #32
    MOVK  X19, #0xbe6, LSL #48
    MOVZ  X20, #0x7d0, LSL #0
    MOVK  X20, #0xd044, LSL #16
    MOVK  X20, #0xeb17, LSL #32
    MOVK  X20, #0x99d8, LSL #48
    MOVZ  X21, #0xbe85, LSL #0
    MOVK  X21, #0x7c36, LSL #16
    MOVK  X21, #0x2f27, LSL #32
    MOVK  X21, #0xc0bd, LSL #48
    MOVZ  X22, #0x9560, LSL #0
    MOVK  X22, #0x56a7, LSL #16
    MOVK  X22, #0xd415, LSL #32
    MOVK  X22, #0x1b82, LSL #48
    MOVZ  X23, #0x1353, LSL #0
    MOVK  X23, #0x3fce, LSL #16
    MOVK  X23, #0xf64b, LSL #32
    MOVK  X23, #0x4ab9, LSL #48
    MOVZ  X29, #0x279e, LSL #0
    MOVK  X29, #0xc662, LSL #16
    MOVK  X29, #0xf93, LSL #32
    MOVK  X29, #0xb78c, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X9
    FMOV  V1.D[1], X8
    FMOV  D2, X22
    FMOV  V2.D[1], X21
    FMOV  D3, X16
    FMOV  V3.D[1], X20
    FMOV  D4, X3
    FMOV  V4.D[1], X15
    FMOV  D5, X16
    FMOV  V5.D[1], X15
    FMOV  D6, X3
    FMOV  V6.D[1], X29
    FMOV  D7, X4
    FMOV  V7.D[1], X17
    FMOV  D8, X12
    FMOV  V8.D[1], X17
    FMOV  D9, X20
    FMOV  V9.D[1], X21
    FMOV  D10, X17
    FMOV  V10.D[1], X20
    FMOV  D11, X5
    FMOV  V11.D[1], X10
    FMOV  D12, X6
    FMOV  V12.D[1], X7
    FMOV  D13, X9
    FMOV  V13.D[1], X17
    FMOV  D14, X14
    FMOV  V14.D[1], X19
    FMOV  D15, X6
    FMOV  V15.D[1], X10
    FMOV  D16, X11
    FMOV  V16.D[1], X22
    FMOV  D17, X2
    FMOV  V17.D[1], X10
    FMOV  D18, X17
    FMOV  V18.D[1], X5
    FMOV  D19, X3
    FMOV  V19.D[1], X5
    FMOV  D20, X8
    FMOV  V20.D[1], X16
    FMOV  D21, X14
    FMOV  V21.D[1], X23
    FMOV  D22, X2
    FMOV  V22.D[1], X16
    FMOV  D23, X18
    FMOV  V23.D[1], X6
    FMOV  D24, X5
    FMOV  V24.D[1], X3
    FMOV  D25, X20
    FMOV  V25.D[1], X19
    FMOV  D26, X3
    FMOV  V26.D[1], X8
    FMOV  D27, X21
    FMOV  V27.D[1], X21
    FMOV  D28, X22
    FMOV  V28.D[1], X9
    FMOV  D29, X17
    FMOV  V29.D[1], X12
    FMOV  D30, X22
    FMOV  V30.D[1], X6
    FMOV  D31, X23
    FMOV  V31.D[1], X13
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_5:
    UMIN  V24.2S, V8.2S, V25.2S
    FMAXP H29, V24.2H
    FMINNMV  H17, V22.8H
    FMAXNMV  S13, V23.4S
    UMINV  S5, V27.4S
    SMAXV  B16, V26.16B
    FMINP H13, V22.2H
    UMAXP  V13.4H, V27.4H, V31.4H
    FMAXP  V29.4S, V29.4S, V25.4S
    FMINP H14, V29.2H
    SMAXV  H4, V5.4H
    SMINV  S7, V14.4S
    FMINNMP H18, V1.2H
    FMINNM  V27.4H, V13.4H, V27.4H
    SMINV  H28, V7.8H
    FMAXNMP S1, V18.2S
    FMAXNMP  V10.2S, V4.2S, V4.2S
    UMAX  V16.4S, V30.4S, V1.4S
    FMINP H25, V27.2H
    FMINP D23, V28.2D
    FMINV  S7, V25.4S
    UMINV  S30, V17.4S
    FMINNMP  V18.8H, V10.8H, V18.8H
    FMINNMV  H25, V25.4H
    UMINV  S14, V20.4S
    FMAXNM  V28.2S, V9.2S, V16.2S
    FMAXNMP  V20.2D, V30.2D, V14.2D
    UMAXP  V31.16B, V5.16B, V28.16B
    SMINV  B1, V18.8B
    FMAXNMP  V28.8H, V18.8H, V31.8H
    SMAXP  V14.4S, V25.4S, V28.4S
    UMAXV  B16, V16.8B
    FMAXNMV  S29, V20.4S
    SMAXV  S30, V4.4S
    FMAXNMP H4, V17.2H
    SMINP  V17.8H, V30.8H, V4.8H
    FMAXNMP  V30.4H, V3.4H, V6.4H
    SMAX  V4.4H, V6.4H, V7.4H
    SMAXV  S20, V24.4S
    FMAXNMP D8, V10.2D
    FMINNMP S13, V8.2S
    SMINV  S8, V4.4S
    FMINNMP  V18.8H, V23.8H, V8.8H
    FMINNMV  H9, V25.8H
    FMAXNMP H28, V29.2H
    FMAXNM  V22.4H, V14.4H, V16.4H
    SMIN  V10.8H, V18.8H, V25.8H
    FMAXNMP  V31.2S, V10.2S, V1.2S
    SMAXP  V3.4S, V28.4S, V31.4S
    FMINV  S16, V15.4S
    FMINP  V28.4S, V30.4S, V30.4S
    SMINV  S8, V16.4S
    SMIN  V18.4S, V22.4S, V23.4S
    FMAXNM  V10.4H, V9.4H, V1.4H
    FMAXNM  V15.4S, V10.4S, V13.4S
    FMINP H13, V3.2H
    FMINV  H25, V8.8H
    SMINV  H6, V20.4H
    FMAX  V29.2D, V6.2D, V18.2D
    UMINV  B4, V27.8B
    FMINNMP D3, V13.2D
    UMAXP  V13.8B, V4.8B, V29.8B
    UMAX  V22.2S, V24.2S, V26.2S
    FMINNMP S8, V10.2S
    SMIN  V18.8H, V17.8H, V22.8H
    UMINV  B24, V25.8B
    FMINNMP D3, V21.2D
    FMAXNMP D29, V18.2D
    FMINNMP  V10.4H, V24.4H, V16.4H
    FMAXNMP S0, V10.2S
    SMAXV  H8, V13.8H
    FMINNMV  H10, V26.8H
    FMAXNMV  S25, V8.4S
    SMINV  B22, V3.16B
    FMINV  S13, V26.4S
    SMAXV  S5, V29.4S
    FMAXNMP  V18.8H, V10.8H, V15.8H
    UMAXV  S17, V5.4S
    SMAXP  V3.8B, V25.8B, V25.8B
    FMINP S22, V0.2S
    FMAXV  H9, V22.8H
    FMAXNMV  S18, V2.4S
    FMAXNMP  V23.4H, V18.4H, V13.4H
    SMAXV  B26, V23.16B
    FMINP H23, V21.2H
    UMAXV  S22, V23.4S
    FMINP D15, V17.2D
    FMAXNMP S21, V9.2S
    FMINNMP S27, V5.2S
    FMAXP  V0.4S, V27.4S, V13.4S
    UMAXV  H18, V19.8H
    SMINV  H19, V2.8H
    FMAXNMV  S21, V18.4S
    FMAXNMP S16, V0.2S
    FMINNMV  S5, V24.4S
    SMINV  H13, V7.4H
    FMAXP H10, V26.2H
    FMINP  V27.4S, V21.4S, V3.4S
    FMINNMP  V25.4H, V22.4H, V3.4H
    FMINNMP D14, V3.2D
    FMAXP  V7.8H, V2.8H, V0.8H
    FMAXNM  V3.8H, V19.8H, V7.8H
    FMAXP S29, V1.2S
    SMAXV  H1, V25.4H
    FMAXNMP H6, V16.2H
    FMINP  V7.2S, V16.2S, V6.2S
    SMINV  H2, V1.8H
    FMAX  V0.8H, V14.8H, V15.8H
    UMINV  B15, V2.8B
    SMINV  S24, V13.4S
    FMAXV  S3, V7.4S
    UMAXV  H18, V15.4H
    FMINV  S19, V24.4S
    FMINP  V24.4S, V0.4S, V15.4S
    SMAX  V1.8B, V5.8B, V5.8B
    FMAX  V2.8H, V16.8H, V16.8H
    FMINNMP S13, V21.2S
    FMAXV  S16, V3.4S
    FMINNMP S22, V1.2S
    FMAXNM  V23.4S, V27.4S, V22.4S
    SMAXP  V11.4S, V10.4S, V16.4S
    FMINNMP  V3.2S, V19.2S, V29.2S
    FMAXNMV  H15, V2.8H
    UMINP  V19.16B, V13.16B, V23.16B
    FMIN  V1.4H, V29.4H, V15.4H
    FMAXP H6, V11.2H
    FMINNMP  V15.8H, V24.8H, V6.8H
    FMINNMV  H11, V19.4H
    FMAXP  V0.2D, V18.2D, V11.2D
    SMINV  S14, V27.4S
    UMAX  V7.8H, V11.8H, V25.8H
    FMAXNMP H2, V1.2H
    FMAXNMV  H30, V15.4H
    FMAXP D19, V7.2D
    FMINNMP D4, V30.2D
    UMINV  H18, V19.8H
    FMAXNMP H25, V14.2H
    SMAXP  V30.2S, V0.2S, V22.2S
    FMAXNM  V1.2D, V4.2D, V4.2D
    FMAXNMP  V29.8H, V11.8H, V22.8H
    FMAXNMP H24, V3.2H
    FMINNMP D0, V18.2D
    UMAXV  B5, V2.16B
    FMINNMP H23, V5.2H
    FMAXV  S15, V0.4S
    UMINP  V7.8B, V24.8B, V30.8B
    FMINNMV  H2, V23.4H
    FMAXP H5, V2.2H
    FMINNMP  V6.2D, V1.2D, V28.2D
    SMAXV  B0, V5.8B
    FMINP S4, V7.2S
    SMINV  H18, V15.4H
    FMINNMV  S2, V0.4S
    FMAXV  H1, V6.4H
    FMINP  V2.8H, V2.8H, V11.8H
    FMAXNMV  H23, V25.4H
    FMINP S28, V1.2S
    FMAXNM  V5.2S, V28.2S, V18.2S
    FMINNMP S22, V23.2S
    FMAXNMP D19, V5.2D
    SMAXV  H23, V4.8H
    FMINP  V30.4S, V23.4S, V2.4S
    SMIN  V10.16B, V22.16B, V29.16B
    SMAXV  S3, V16.4S
    FMINV  S22, V19.4S
    SMINV  H4, V11.4H
    FMAXP S5, V29.2S
    FMAXP  V1.2D, V21.2D, V3.2D
    FMINP  V2.2D, V30.2D, V4.2D
    FMINNMP  V16.2S, V2.2S, V22.2S
    FMINNMP H25, V10.2H
    FMINNMP H15, V1.2H
    SMINP  V15.16B, V29.16B, V24.16B
    FMINP D24, V16.2D
    FMAXNM  V4.4S, V1.4S, V28.4S
    UMIN  V30.8B, V24.8B, V25.8B
    FMAXNMV  S21, V15.4S
    FMIN  V29.8H, V5.8H, V21.8H
    FMAXNMP  V15.2S, V3.2S, V30.2S
    UMAXV  H11, V4.8H
    SMINV  H5, V29.8H
    FMAXP D3, V5.2D
    FMINNMP H24, V10.2H
    FMINNM  V10.4H, V15.4H, V14.4H
    UMAXP  V15.16B, V24.16B, V11.16B
    UMINV  H22, V3.8H
    FMINV  H18, V28.8H
    UMAXV  H16, V15.4H
    FMAXV  H15, V22.4H
    SMAXV  S25, V10.4S
    FMINNMP S14, V25.2S
    FMAXV  H3, V14.4H
    FMAXV  H29, V20.8H
    SMIN  V18.4S, V30.4S, V3.4S
    FMAXV  H18, V27.4H
    UMAXP  V31.8H, V16.8H, V16.8H
    FMAXP  V11.8H, V11.8H, V2.8H
    SMAXV  H16, V1.4H
    FMINP  V28.8H, V31.8H, V12.8H
    UMAXV  H12, V2.8H
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_5
    MOVZ  X29, #0xab54, LSL #0
    MOVK  X29, #0x3afe, LSL #16
    MOVK  X29, #0x5086, LSL #32
    MOVK  X29, #0x2fc6, LSL #48
    SUB  X20, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x3c64, LSL #0
    MOVK  X29, #0xaea, LSL #16
    MOVK  X29, #0x750f, LSL #32
    MOVK  X29, #0xd41f, LSL #48
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xb70b, LSL #0
    MOVK  X29, #0x4a0a, LSL #16
    MOVK  X29, #0xf970, LSL #32
    MOVK  X29, #0xa583, LSL #48
    SUB  X20, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xb325, LSL #0
    MOVK  X29, #0xc814, LSL #16
    MOVK  X29, #0xab23, LSL #32
    MOVK  X29, #0xfc62, LSL #48
    SUB  X20, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x783d, LSL #0
    MOVK  X29, #0x7450, LSL #16
    MOVK  X29, #0xc4a0, LSL #32
    MOVK  X29, #0x5a0b, LSL #48
    SUB  X20, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xe3b7, LSL #0
    MOVK  X29, #0x155d, LSL #16
    MOVK  X29, #0xfa4e, LSL #32
    MOVK  X29, #0x2eb4, LSL #48
    SUB  X20, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xf249, LSL #0
    MOVK  X29, #0x1132, LSL #16
    MOVK  X29, #0x5ea6, LSL #32
    MOVK  X29, #0x691a, LSL #48
    SUB  X20, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x264d, LSL #0
    MOVK  X29, #0x640e, LSL #16
    MOVK  X29, #0x9d9, LSL #32
    MOVK  X29, #0x78f0, LSL #48
    SUB  X20, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x5, LSL #0
    MOVK  X29, #0xe24e, LSL #16
    MOVK  X29, #0xc2e7, LSL #32
    MOVK  X29, #0xa923, LSL #48
    SUB  X20, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x3922, LSL #0
    MOVK  X29, #0xc050, LSL #16
    MOVK  X29, #0x35c3, LSL #32
    MOVK  X29, #0x3aee, LSL #48
    SUB  X20, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x7dd0, LSL #0
    MOVK  X29, #0xa9b1, LSL #16
    MOVK  X29, #0x406e, LSL #32
    MOVK  X29, #0xe1f1, LSL #48
    SUB  X20, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x4511, LSL #0
    MOVK  X29, #0xeb43, LSL #16
    MOVK  X29, #0xbdf3, LSL #32
    MOVK  X29, #0x5ee5, LSL #48
    SUB  X20, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x8631, LSL #0
    MOVK  X29, #0x2d6e, LSL #16
    MOVK  X29, #0x4003, LSL #32
    MOVK  X29, #0x27ee, LSL #48
    SUB  X20, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x68a8, LSL #0
    MOVK  X29, #0xdea4, LSL #16
    MOVK  X29, #0xcc2a, LSL #32
    MOVK  X29, #0x5643, LSL #48
    SUB  X20, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x496b, LSL #0
    MOVK  X29, #0xc106, LSL #16
    MOVK  X29, #0x86ba, LSL #32
    MOVK  X29, #0x6e91, LSL #48
    SUB  X20, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x5c7e, LSL #0
    MOVK  X29, #0xf3f0, LSL #16
    MOVK  X29, #0x6b0b, LSL #32
    MOVK  X29, #0xbe6, LSL #48
    SUB  X20, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0xbe85, LSL #0
    MOVK  X29, #0x7c36, LSL #16
    MOVK  X29, #0x2f27, LSL #32
    MOVK  X29, #0xc0bd, LSL #48
    SUB  X20, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x9560, LSL #0
    MOVK  X29, #0x56a7, LSL #16
    MOVK  X29, #0xd415, LSL #32
    MOVK  X29, #0x1b82, LSL #48
    SUB  X20, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X29, #0x1353, LSL #0
    MOVK  X29, #0x3fce, LSL #16
    MOVK  X29, #0xf64b, LSL #32
    MOVK  X29, #0x4ab9, LSL #48
    SUB  X20, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X29, FPSR
    MOVZ  X20, #0x81, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D0
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D1
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D5
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D9
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D11
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D17
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D20
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D28
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D30
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X29, D31
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X13
    FMOV  D1, X18
    FMOV  V1.D[1], X17
    FMOV  D2, X15
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X12
    FMOV  D4, X4
    FMOV  V4.D[1], X22
    FMOV  D5, X23
    FMOV  V5.D[1], X8
    FMOV  D6, X14
    FMOV  V6.D[1], X9
    FMOV  D7, X18
    FMOV  V7.D[1], X3
    FMOV  D8, X21
    FMOV  V8.D[1], X2
    FMOV  D9, X19
    FMOV  V9.D[1], X3
    FMOV  D10, X2
    FMOV  V10.D[1], X12
    FMOV  D11, X12
    FMOV  V11.D[1], X20
    FMOV  D12, X22
    FMOV  V12.D[1], X18
    FMOV  D13, X9
    FMOV  V13.D[1], X10
    FMOV  D14, X9
    FMOV  V14.D[1], X17
    FMOV  D15, X13
    FMOV  V15.D[1], X21
    FMOV  D16, X5
    FMOV  V16.D[1], X15
    FMOV  D17, X11
    FMOV  V17.D[1], X14
    FMOV  D18, X2
    FMOV  V18.D[1], X22
    FMOV  D19, X3
    FMOV  V19.D[1], X9
    FMOV  D20, X23
    FMOV  V20.D[1], X23
    FMOV  D21, X16
    FMOV  V21.D[1], X5
    FMOV  D22, X18
    FMOV  V22.D[1], X9
    FMOV  D23, X3
    FMOV  V23.D[1], X21
    FMOV  D24, X13
    FMOV  V24.D[1], X5
    FMOV  D25, X15
    FMOV  V25.D[1], X7
    FMOV  D26, X12
    FMOV  V26.D[1], X21
    FMOV  D27, X12
    FMOV  V27.D[1], X29
    FMOV  D28, X20
    FMOV  V28.D[1], X20
    FMOV  D29, X21
    FMOV  V29.D[1], X10
    FMOV  D30, X4
    FMOV  V30.D[1], X13
    FMOV  D31, X8
    FMOV  V31.D[1], X22
    MOVZ  X4, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_6:
    FMINP S2, V25.2S
    FMAXNMV  S15, V29.4S
    FMINP  V9.2S, V15.2S, V27.2S
    FMINP D22, V24.2D
    FMINP S13, V8.2S
    FMINP D10, V31.2D
    FMINNMP  V8.4S, V22.4S, V28.4S
    SMIN  V18.16B, V8.16B, V13.16B
    UMAX  V11.4S, V20.4S, V9.4S
    FMINNMV  S30, V18.4S
    FMAXP  V15.4H, V13.4H, V30.4H
    FMAXNMP  V29.2S, V11.2S, V11.2S
    FMINP H18, V18.2H
    FMAXNMV  H9, V10.8H
    FMAXNM  V20.2D, V18.2D, V15.2D
    UMAXV  S11, V20.4S
    UMINP  V31.16B, V26.16B, V24.16B
    UMAXV  S22, V31.4S
    FMAX  V24.4H, V9.4H, V29.4H
    SMINP  V31.16B, V12.16B, V22.16B
    SMAX  V25.16B, V2.16B, V20.16B
    FMAX  V26.8H, V31.8H, V8.8H
    UMAXV  H12, V24.4H
    FMAXNMP S30, V8.2S
    FMAXNMP H27, V29.2H
    FMINNMV  H24, V12.4H
    SMAXP  V31.16B, V30.16B, V12.16B
    FMINNMV  S12, V11.4S
    SMAXV  H11, V12.8H
    SMINV  S18, V12.4S
    FMINNMP  V26.4H, V11.4H, V1.4H
    FMINP  V10.8H, V23.8H, V26.8H
    FMAXNMV  H2, V28.8H
    SMINV  B26, V10.16B
    FMAXP  V11.8H, V18.8H, V31.8H
    FMINNMP H22, V25.2H
    FMAXP S20, V24.2S
    SMINV  S8, V1.4S
    FMAXP D12, V22.2D
    SMINP  V25.4H, V5.4H, V8.4H
    UMINV  S16, V15.4S
    FMAXNMP S1, V26.2S
    FMINNMP  V29.2S, V22.2S, V12.2S
    FMINP  V15.4H, V27.4H, V27.4H
    FMAXNMP S23, V25.2S
    FMAXNMP  V24.4H, V2.4H, V15.4H
    SMINV  S31, V24.4S
    FMAXV  H2, V23.4H
    FMINNM  V25.8H, V20.8H, V25.8H
    FMAXNMP D23, V4.2D
    UMAXV  B10, V31.16B
    SMIN  V18.8B, V1.8B, V23.8B
    FMINP  V20.2S, V29.2S, V11.2S
    UMINV  B12, V25.8B
    SMINV  B27, V2.8B
    FMAXNMP D12, V20.2D
    FMINNMV  S11, V10.4S
    FMINNMP  V10.4S, V25.4S, V16.4S
    UMAXP  V8.2S, V13.2S, V5.2S
    FMAXP  V31.4H, V11.4H, V8.4H
    SMAXP  V2.8H, V19.8H, V13.8H
    FMAXP S29, V27.2S
    FMINP S4, V17.2S
    SMAX  V22.4S, V7.4S, V10.4S
    FMAXNMP H16, V22.2H
    FMINNM  V22.2D, V18.2D, V6.2D
    FMINNMV  S8, V22.4S
    FMAX  V10.2D, V8.2D, V26.2D
    SMAXV  H5, V2.8H
    FMAXP  V25.4S, V10.4S, V29.4S
    SMINV  B7, V12.16B
    FMINNMP  V13.2S, V9.2S, V4.2S
    FMAX  V22.4H, V16.4H, V16.4H
    UMINV  B16, V5.8B
    FMINP  V19.2D, V31.2D, V30.2D
    FMAXNMP S0, V4.2S
    SMAXP  V2.4H, V25.4H, V0.4H
    UMINP  V11.8H, V2.8H, V14.8H
    FMINP  V25.4S, V7.4S, V13.4S
    FMAXNMP D30, V12.2D
    SMIN  V6.2S, V30.2S, V15.2S
    FMAXP  V13.2S, V3.2S, V1.2S
    FMAXP D7, V6.2D
    SMAXP  V18.4S, V13.4S, V26.4S
    SMAXV  B31, V1.8B
    FMINNMP D14, V25.2D
    SMAXV  B30, V31.16B
    FMAXV  H3, V4.4H
    FMAXNMV  S10, V14.4S
    FMINNMP D25, V0.2D
    FMAXNM  V2.4H, V11.4H, V16.4H
    SMAXV  B2, V22.16B
    SMAXV  S14, V7.4S
    FMINP D5, V10.2D
    SMINV  B31, V30.8B
    SMINV  H12, V25.8H
    UMINV  S4, V14.4S
    FMINNM  V13.2S, V25.2S, V5.2S
    FMINNMP  V11.4H, V18.4H, V3.4H
    FMAXNMP S14, V29.2S
    FMINNMV  S1, V18.4S
    SMIN  V10.8B, V29.8B, V28.8B
    FMINNMV  S16, V23.4S
    SMINV  B30, V10.8B
    UMINV  H0, V12.4H
    SMAXV  S6, V12.4S
    FMINP S11, V16.2S
    UMINV  H28, V13.4H
    FMAXNM  V7.8H, V30.8H, V27.8H
    FMINP  V15.8H, V22.8H, V0.8H
    FMINNMP S4, V1.2S
    FMINNMV  S26, V11.4S
    FMINNMV  S13, V26.4S
    UMAXV  H0, V15.4H
    SMINV  H10, V28.8H
    FMINP  V26.4S, V23.4S, V14.4S
    FMAXP H29, V30.2H
    FMAXNM  V30.4S, V31.4S, V4.4S
    UMAXV  S5, V10.4S
    SMINV  B17, V7.8B
    SMINP  V28.8B, V13.8B, V19.8B
    FMAXV  S19, V0.4S
    UMINV  B12, V5.16B
    FMINNMP  V1.8H, V20.8H, V26.8H
    SMINV  S4, V12.4S
    FMINP S7, V4.2S
    SMINV  H10, V23.8H
    UMAXV  S0, V10.4S
    FMAXV  H26, V29.4H
    FMINP S9, V10.2S
    FMINP S14, V29.2S
    FMAXNM  V5.4S, V7.4S, V7.4S
    FMAXP  V10.4H, V1.4H, V8.4H
    FMINP H31, V14.2H
    FMINNMV  H13, V9.4H
    SMINP  V9.8H, V0.8H, V13.8H
    FMINNM  V27.4H, V13.4H, V10.4H
    FMIN  V12.8H, V11.8H, V30.8H
    UMINV  S8, V22.4S
    UMINV  H10, V17.4H
    FMAXNMV  S30, V10.4S
    UMIN  V9.8H, V12.8H, V28.8H
    UMINV  B14, V19.16B
    FMINP H10, V9.2H
    FMINP D23, V8.2D
    FMINNMP H4, V25.2H
    FMINP  V28.4H, V22.4H, V19.4H
    UMAXV  H19, V30.4H
    UMINV  S19, V10.4S
    UMAXV  S11, V14.4S
    UMAXP  V17.8H, V31.8H, V26.8H
    SMINV  B14, V11.8B
    UMAX  V30.4H, V18.4H, V13.4H
    SMINV  S31, V28.4S
    SMINV  H28, V7.4H
    FMAXP  V1.8H, V28.8H, V23.8H
    FMINNMP  V12.2D, V4.2D, V30.2D
    FMAXNM  V24.8H, V31.8H, V31.8H
    FMAXP H25, V5.2H
    UMAX  V5.4H, V19.4H, V19.4H
    FMAXNMV  S4, V17.4S
    UMAX  V17.8B, V4.8B, V0.8B
    FMINNMP D10, V5.2D
    FMAXNMP  V13.2S, V25.2S, V13.2S
    FMAXV  H19, V13.4H
    FMAXP  V11.8H, V19.8H, V1.8H
    SMIN  V5.4H, V17.4H, V27.4H
    SMINV  H31, V21.4H
    FMINV  S26, V20.4S
    UMAXV  S7, V5.4S
    FMAXV  H4, V11.8H
    FMAXNMP H1, V12.2H
    UMAXV  S28, V6.4S
    FMINP S11, V28.2S
    UMAXP  V5.4S, V1.4S, V20.4S
    FMINV  H6, V5.8H
    UMAX  V19.4S, V31.4S, V24.4S
    FMINNMV  S25, V30.4S
    FMINP S18, V28.2S
    UMAX  V28.8B, V4.8B, V14.8B
    FMAXP  V20.4S, V28.4S, V19.4S
    FMINP  V19.2S, V22.2S, V25.2S
    UMAXP  V21.4S, V17.4S, V19.4S
    FMINNMP S27, V22.2S
    FMINP S20, V11.2S
    FMAXNMP  V4.2S, V0.2S, V21.2S
    UMAXP  V28.4S, V26.4S, V20.4S
    FMINNMP  V3.2D, V28.2D, V28.2D
    UMAXV  B19, V4.8B
    FMAXP H22, V27.2H
    FMINP H17, V0.2H
    FMAXNMV  H13, V3.8H
    FMIN  V26.4H, V7.4H, V19.4H
    FMAXP H3, V12.2H
    FMINP  V19.4H, V26.4H, V13.4H
    UMIN  V4.2S, V10.2S, V15.2S
    FMAXNM  V14.2S, V19.2S, V3.2S
    UMAXV  H25, V18.4H
    UMAXV  B13, V31.8B
    FMINP  V1.4S, V22.4S, V14.4S
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_6
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X21, FPSR
    MOVZ  X5, #0x81, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D0
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D1
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D5
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D9
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D29
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D30
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X21, D31
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X19
    FMOV  V1.D[1], X14
    FMOV  D2, X22
    FMOV  V2.D[1], X21
    FMOV  D3, X20
    FMOV  V3.D[1], X8
    FMOV  D4, X17
    FMOV  V4.D[1], X18
    FMOV  D5, X4
    FMOV  V5.D[1], X20
    FMOV  D6, X21
    FMOV  V6.D[1], X20
    FMOV  D7, X22
    FMOV  V7.D[1], X20
    FMOV  D8, X5
    FMOV  V8.D[1], X19
    FMOV  D9, X10
    FMOV  V9.D[1], X13
    FMOV  D10, X8
    FMOV  V10.D[1], X14
    FMOV  D11, X8
    FMOV  V11.D[1], X23
    FMOV  D12, X12
    FMOV  V12.D[1], X10
    FMOV  D13, X17
    FMOV  V13.D[1], X6
    FMOV  D14, X23
    FMOV  V14.D[1], X20
    FMOV  D15, X15
    FMOV  V15.D[1], X11
    FMOV  D16, X20
    FMOV  V16.D[1], X21
    FMOV  D17, X21
    FMOV  V17.D[1], X10
    FMOV  D18, X15
    FMOV  V18.D[1], X16
    FMOV  D19, X5
    FMOV  V19.D[1], X20
    FMOV  D20, X5
    FMOV  V20.D[1], X20
    FMOV  D21, X10
    FMOV  V21.D[1], X7
    FMOV  D22, X5
    FMOV  V22.D[1], X16
    FMOV  D23, X8
    FMOV  V23.D[1], X5
    FMOV  D24, X10
    FMOV  V24.D[1], X4
    FMOV  D25, X14
    FMOV  V25.D[1], X21
    FMOV  D26, X16
    FMOV  V26.D[1], X5
    FMOV  D27, X7
    FMOV  V27.D[1], X13
    FMOV  D28, X21
    FMOV  V28.D[1], X5
    FMOV  D29, X2
    FMOV  V29.D[1], X18
    FMOV  D30, X5
    FMOV  V30.D[1], X3
    FMOV  D31, X17
    FMOV  V31.D[1], X8
    MOVZ  X16, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_7:
    FMAXP  V8.4S, V29.4S, V24.4S
    FMIN  V26.4H, V26.4H, V25.4H
    SMINV  B4, V5.16B
    FMINNM  V5.4H, V27.4H, V27.4H
    FMAX  V7.8H, V10.8H, V30.8H
    UMINP  V13.16B, V7.16B, V5.16B
    FMAXNMV  H2, V26.8H
    UMINV  S7, V31.4S
    UMINP  V17.4H, V21.4H, V4.4H
    UMINP  V27.8H, V8.8H, V13.8H
    FMINNMP H7, V22.2H
    FMIN  V20.4H, V0.4H, V23.4H
    SMIN  V4.8B, V22.8B, V13.8B
    FMINNMP D30, V28.2D
    SMINV  H31, V17.8H
    SMAX  V24.4H, V7.4H, V29.4H
    UMINV  B13, V24.16B
    SMINV  B21, V2.16B
    FMAXP  V26.8H, V21.8H, V2.8H
    SMAXV  S28, V27.4S
    FMINNMP D31, V26.2D
    SMINV  B5, V23.8B
    SMAX  V23.8H, V30.8H, V19.8H
    FMINNMP  V12.2D, V28.2D, V26.2D
    FMINV  S30, V12.4S
    FMINP H24, V5.2H
    UMAXV  H5, V26.4H
    UMAXV  S19, V4.4S
    FMAXNMV  S8, V5.4S
    FMAXP D21, V30.2D
    SMIN  V12.8H, V31.8H, V20.8H
    FMAXNM  V17.8H, V29.8H, V8.8H
    FMINV  S28, V21.4S
    FMAXNMP D9, V23.2D
    UMINV  H27, V9.8H
    FMINNMP  V9.8H, V12.8H, V8.8H
    FMINP H29, V27.2H
    FMIN  V10.4S, V5.4S, V9.4S
    UMIN  V8.8H, V17.8H, V6.8H
    FMINP H12, V29.2H
    FMINNMP  V27.2S, V12.2S, V5.2S
    FMINNMP  V23.8H, V10.8H, V13.8H
    FMAXV  S4, V27.4S
    FMAXNM  V27.4H, V1.4H, V21.4H
    UMAXV  B16, V24.8B
    FMINNMV  S29, V16.4S
    FMAXNM  V21.4S, V28.4S, V27.4S
    UMINP  V5.16B, V19.16B, V23.16B
    FMAXP S24, V20.2S
    FMAXNMV  H9, V24.4H
    FMAXNMP  V23.4H, V24.4H, V5.4H
    FMINP  V20.4H, V10.4H, V21.4H
    FMAXNMP  V10.4H, V29.4H, V4.4H
    FMAXNMP  V24.4H, V8.4H, V8.4H
    FMIN  V5.4S, V20.4S, V20.4S
    FMAXNMV  H15, V1.8H
    UMAXV  B29, V5.8B
    FMINNMP  V20.4H, V24.4H, V29.4H
    SMAX  V31.8B, V20.8B, V5.8B
    SMINV  B8, V10.8B
    SMAXV  H21, V23.8H
    FMINP D6, V17.2D
    FMAX  V12.4H, V22.4H, V8.4H
    FMINNM  V4.2D, V21.2D, V24.2D
    FMAX  V3.2S, V31.2S, V12.2S
    SMINV  H31, V9.4H
    SMAXP  V19.4H, V3.4H, V29.4H
    SMINP  V9.2S, V19.2S, V31.2S
    SMIN  V29.4H, V12.4H, V6.4H
    FMINP H18, V20.2H
    FMAXV  H22, V18.4H
    FMAXNMP H20, V28.2H
    FMINNMP  V23.4S, V17.4S, V22.4S
    FMINNMV  H19, V29.8H
    SMAXV  S8, V20.4S
    FMINNM  V20.2D, V9.2D, V15.2D
    SMINV  H25, V23.4H
    FMAXP S25, V24.2S
    SMAXV  H2, V3.4H
    SMINV  S3, V20.4S
    FMIN  V28.8H, V4.8H, V19.8H
    SMAX  V21.16B, V8.16B, V28.16B
    FMINNMP S28, V21.2S
    FMINP  V12.8H, V2.8H, V25.8H
    FMAXNM  V19.2D, V12.2D, V3.2D
    FMAXV  S12, V11.4S
    FMAXNMV  H1, V15.4H
    FMINP D15, V27.2D
    FMAXNM  V31.4S, V23.4S, V7.4S
    FMINV  S6, V14.4S
    SMAXP  V29.2S, V1.2S, V14.2S
    FMAX  V8.2D, V26.2D, V28.2D
    SMINP  V24.4H, V7.4H, V15.4H
    FMAXNMV  H21, V10.4H
    FMINNM  V11.4H, V27.4H, V24.4H
    FMAXP H20, V7.2H
    FMINP D6, V12.2D
    FMAXP S9, V15.2S
    FMINNMV  H17, V19.4H
    SMINP  V19.4S, V21.4S, V8.4S
    FMAXP S7, V3.2S
    UMAXV  H26, V6.8H
    UMAXV  B12, V29.16B
    FMINNMP  V3.4S, V0.4S, V12.4S
    FMAXNM  V14.8H, V3.8H, V20.8H
    FMAXNMV  S6, V19.4S
    FMAX  V3.2S, V27.2S, V14.2S
    FMINNMP  V20.8H, V26.8H, V17.8H
    FMAXV  H8, V9.4H
    UMAXV  H17, V3.8H
    FMAXP S0, V10.2S
    FMINP H19, V21.2H
    FMINP  V15.2S, V15.2S, V8.2S
    UMIN  V23.4S, V7.4S, V0.4S
    FMINNM  V26.2S, V29.2S, V10.2S
    UMAXV  B26, V25.16B
    FMAXNMP S12, V12.2S
    FMAXP  V7.8H, V17.8H, V10.8H
    FMINNMP  V27.4H, V15.4H, V12.4H
    UMINV  S14, V2.4S
    UMAX  V9.2S, V6.2S, V26.2S
    FMAXP  V2.2S, V14.2S, V9.2S
    FMINNMP D29, V27.2D
    FMAXNM  V17.2S, V20.2S, V11.2S
    UMAX  V29.16B, V6.16B, V17.16B
    FMAX  V11.4H, V16.4H, V7.4H
    SMAXV  H12, V23.8H
    FMAXNM  V8.2S, V22.2S, V24.2S
    SMAXV  B26, V19.16B
    FMAX  V20.2S, V12.2S, V29.2S
    FMINNMV  S3, V26.4S
    FMIN  V21.4S, V8.4S, V17.4S
    FMINV  H18, V25.4H
    FMAXP  V17.8H, V28.8H, V25.8H
    FMINP  V24.4H, V3.4H, V11.4H
    FMINNM  V0.8H, V20.8H, V18.8H
    FMINNMP  V27.8H, V23.8H, V2.8H
    FMAXNM  V20.8H, V23.8H, V24.8H
    SMAX  V18.4H, V8.4H, V20.4H
    FMIN  V20.8H, V0.8H, V17.8H
    FMAXNM  V19.8H, V21.8H, V27.8H
    UMINV  S10, V20.4S
    FMAXV  H0, V10.4H
    FMINNMP D12, V19.2D
    FMAXV  H22, V14.4H
    FMAXNMV  S31, V2.4S
    FMINNMP H6, V18.2H
    FMINNM  V24.4S, V26.4S, V22.4S
    FMINNMV  S23, V21.4S
    FMINP H18, V27.2H
    FMINNMP  V29.8H, V24.8H, V27.8H
    FMAX  V28.4S, V29.4S, V31.4S
    UMINV  B26, V31.8B
    FMINNMP D10, V28.2D
    SMINV  B2, V18.16B
    SMAXV  S29, V26.4S
    FMINNMV  H25, V12.4H
    FMINNMV  H21, V29.4H
    UMAXV  H19, V21.8H
    UMAXP  V28.8H, V13.8H, V23.8H
    UMAX  V13.4H, V0.4H, V6.4H
    FMAXP D22, V2.2D
    UMAXV  S15, V4.4S
    UMAX  V26.4S, V15.4S, V19.4S
    FMAXNMP  V6.4H, V22.4H, V19.4H
    FMINP  V12.2S, V28.2S, V6.2S
    SMAXV  B14, V10.16B
    FMAXNMP H23, V12.2H
    FMINP  V4.4H, V31.4H, V25.4H
    FMAXNMP S29, V14.2S
    FMAXNM  V21.2S, V29.2S, V29.2S
    FMINV  S11, V13.4S
    FMINNM  V13.4S, V9.4S, V21.4S
    FMINV  S15, V23.4S
    FMINP D9, V14.2D
    UMINV  H27, V9.8H
    FMAX  V21.4H, V14.4H, V8.4H
    FMAXV  H9, V26.8H
    FMINNM  V0.8H, V15.8H, V11.8H
    FMAXNMP D28, V0.2D
    FMINV  S11, V28.4S
    FMINV  H25, V21.4H
    FMINNMV  H14, V13.8H
    FMINP  V31.4S, V25.4S, V22.4S
    FMAXNMP H28, V22.2H
    FMAXV  H13, V14.4H
    UMAXV  H25, V27.4H
    SMINV  H15, V9.8H
    FMINP D9, V15.2D
    FMINNMP H23, V14.2H
    FMIN  V0.8H, V13.8H, V23.8H
    FMINP H20, V9.2H
    SMINV  B6, V7.8B
    FMAXV  S9, V6.4S
    FMAXV  S27, V25.4S
    UMAXV  S15, V19.4S
    SMINV  H19, V30.8H
    UMAXV  H22, V15.8H
    FMINP  V21.2S, V31.2S, V27.2S
    FMAX  V29.8H, V23.8H, V23.8H
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_7
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X2, FPSR
    MOVZ  X10, #0x81, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X2, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  V0.D[1], X21
    FMOV  D1, X20
    FMOV  V1.D[1], X23
    FMOV  D2, X22
    FMOV  V2.D[1], X19
    FMOV  D3, X19
    FMOV  V3.D[1], X3
    FMOV  D4, X12
    FMOV  V4.D[1], X17
    FMOV  D5, X4
    FMOV  V5.D[1], X22
    FMOV  D6, X18
    FMOV  V6.D[1], X15
    FMOV  D7, X5
    FMOV  V7.D[1], X18
    FMOV  D8, X12
    FMOV  V8.D[1], X17
    FMOV  D9, X8
    FMOV  V9.D[1], X6
    FMOV  D10, X2
    FMOV  V10.D[1], X8
    FMOV  D11, X7
    FMOV  V11.D[1], X5
    FMOV  D12, X12
    FMOV  V12.D[1], X10
    FMOV  D13, X23
    FMOV  V13.D[1], X19
    FMOV  D14, X7
    FMOV  V14.D[1], X13
    FMOV  D15, X6
    FMOV  V15.D[1], X11
    FMOV  D16, X16
    FMOV  V16.D[1], X9
    FMOV  D17, X14
    FMOV  V17.D[1], X10
    FMOV  D18, X16
    FMOV  V18.D[1], X6
    FMOV  D19, X12
    FMOV  V19.D[1], X29
    FMOV  D20, X2
    FMOV  V20.D[1], X22
    FMOV  D21, X13
    FMOV  V21.D[1], X4
    FMOV  D22, X19
    FMOV  V22.D[1], X17
    FMOV  D23, X19
    FMOV  V23.D[1], X12
    FMOV  D24, X13
    FMOV  V24.D[1], X15
    FMOV  D25, X18
    FMOV  V25.D[1], X10
    FMOV  D26, X22
    FMOV  V26.D[1], X29
    FMOV  D27, X4
    FMOV  V27.D[1], X9
    FMOV  D28, X12
    FMOV  V28.D[1], X22
    FMOV  D29, X13
    FMOV  V29.D[1], X16
    FMOV  D30, X3
    FMOV  V30.D[1], X23
    FMOV  D31, X7
    FMOV  V31.D[1], X19
    MOVZ  X19, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_8:
    FMINNMP  V10.4H, V30.4H, V27.4H
    FMAXP  V26.8H, V25.8H, V23.8H
    FMAXNMP  V14.2D, V28.2D, V24.2D
    FMINNMP H14, V14.2H
    UMAXV  S24, V5.4S
    FMINV  S24, V26.4S
    FMINNM  V5.2D, V31.2D, V0.2D
    FMAXNMV  H26, V24.8H
    FMAXP D24, V29.2D
    SMIN  V16.2S, V14.2S, V11.2S
    UMAXV  S20, V22.4S
    SMINV  H5, V20.8H
    FMAXNMP H9, V5.2H
    FMAXNMP S30, V30.2S
    SMINV  B25, V24.8B
    FMINNMP  V23.4H, V16.4H, V4.4H
    FMAXP  V15.4H, V7.4H, V25.4H
    FMAXP  V29.2D, V23.2D, V2.2D
    FMINNMP D8, V10.2D
    UMAXP  V26.2S, V29.2S, V8.2S
    UMAXV  H11, V30.4H
    FMAXP S24, V28.2S
    FMINNMV  H10, V11.4H
    FMINNM  V23.8H, V17.8H, V1.8H
    FMINV  H28, V22.8H
    SMINV  S8, V24.4S
    UMAXV  H22, V12.8H
    FMINP  V24.2S, V22.2S, V23.2S
    FMINP D20, V26.2D
    FMAXP  V4.8H, V12.8H, V24.8H
    FMAX  V17.8H, V28.8H, V18.8H
    UMAXV  S28, V7.4S
    FMAXNMP S23, V4.2S
    FMINNMP S4, V20.2S
    UMINV  S11, V8.4S
    UMAXP  V25.2S, V24.2S, V23.2S
    FMAXNM  V12.2D, V9.2D, V25.2D
    FMINNMV  S9, V17.4S
    FMAXP D17, V12.2D
    FMINP D18, V17.2D
    UMAXP  V12.8H, V19.8H, V28.8H
    FMAXNMP S26, V27.2S
    UMIN  V23.16B, V12.16B, V11.16B
    FMAX  V27.2D, V18.2D, V6.2D
    FMINNM  V19.2D, V4.2D, V13.2D
    UMINP  V11.8H, V13.8H, V19.8H
    SMINV  B22, V13.8B
    FMAXP  V18.4H, V9.4H, V23.4H
    UMAXP  V12.4S, V22.4S, V15.4S
    FMINNMP  V23.2S, V30.2S, V5.2S
    FMAX  V19.4S, V18.4S, V13.4S
    UMAX  V5.4S, V27.4S, V19.4S
    FMINNMP S15, V15.2S
    FMAXNM  V18.2D, V15.2D, V9.2D
    FMINP H24, V5.2H
    FMINNM  V20.8H, V12.8H, V11.8H
    FMINV  H28, V15.8H
    SMAXP  V7.8B, V20.8B, V17.8B
    FMINNMV  H20, V24.4H
    FMINNMV  H15, V16.8H
    FMAXV  H13, V29.4H
    FMINP  V17.4H, V26.4H, V26.4H
    UMIN  V29.4H, V15.4H, V14.4H
    FMINNMV  S22, V13.4S
    FMINP H8, V7.2H
    FMAXNM  V30.2S, V3.2S, V28.2S
    UMINP  V12.2S, V8.2S, V26.2S
    FMAXNMP  V16.4H, V22.4H, V23.4H
    UMAXV  B4, V2.16B
    FMIN  V28.4H, V4.4H, V30.4H
    FMINNMP S4, V12.2S
    UMINV  S11, V15.4S
    UMAX  V26.2S, V11.2S, V26.2S
    FMINP  V30.4H, V26.4H, V26.4H
    FMAXP D11, V30.2D
    FMAXNMV  S13, V29.4S
    SMINV  S7, V13.4S
    FMAXNMV  S22, V21.4S
    UMIN  V29.4S, V17.4S, V22.4S
    FMINNMV  S2, V4.4S
    FMAXNMP  V12.2S, V22.2S, V20.2S
    UMAXV  S15, V24.4S
    SMAXV  S21, V12.4S
    UMINV  S22, V11.4S
    UMINV  B3, V25.8B
    SMAXV  B17, V27.8B
    SMAXV  H31, V7.4H
    FMAXNM  V23.8H, V17.8H, V28.8H
    FMAXNMP D3, V3.2D
    FMINNM  V25.4S, V10.4S, V21.4S
    UMIN  V4.8B, V23.8B, V2.8B
    FMAXP S23, V16.2S
    UMAXV  H24, V25.8H
    FMINP D27, V4.2D
    UMINV  H11, V18.4H
    FMAXNMP S2, V24.2S
    SMIN  V7.16B, V31.16B, V23.16B
    UMAXV  H4, V11.4H
    FMAXP D23, V3.2D
    SMAXV  B28, V7.16B
    UMAXV  H11, V5.4H
    FMAXP S10, V4.2S
    FMINP S16, V26.2S
    FMAXNMP  V26.4H, V22.4H, V26.4H
    SMINV  H27, V23.4H
    FMINV  S4, V20.4S
    FMINP D23, V2.2D
    FMINP H18, V27.2H
    FMAXNM  V3.2D, V23.2D, V28.2D
    FMAXP D28, V4.2D
    FMAX  V23.2S, V28.2S, V16.2S
    SMINV  B25, V15.8B
    FMINP S4, V10.2S
    FMINNMP  V28.2D, V18.2D, V11.2D
    SMAX  V2.8H, V25.8H, V25.8H
    FMINNMV  S31, V13.4S
    FMINNM  V13.2D, V3.2D, V28.2D
    FMINV  H7, V15.8H
    FMAXNMP H25, V31.2H
    UMAXV  H28, V2.8H
    FMAXNMV  H22, V4.4H
    SMINP  V10.8H, V22.8H, V23.8H
    FMINNMP  V16.2S, V10.2S, V13.2S
    FMAXNMP  V21.4S, V28.4S, V26.4S
    UMAXV  H3, V21.8H
    FMAXNMP H6, V26.2H
    FMINNM  V4.2S, V3.2S, V16.2S
    FMAXNM  V30.8H, V16.8H, V4.8H
    FMINNMP S10, V17.2S
    FMAXNMP D8, V1.2D
    FMAXP H26, V19.2H
    FMINNMV  H31, V28.8H
    UMAXV  S26, V27.4S
    UMAXV  S22, V15.4S
    SMAXP  V18.8H, V29.8H, V19.8H
    FMAX  V29.4H, V20.4H, V31.4H
    FMAXP  V15.8H, V7.8H, V11.8H
    FMAXNMP  V11.4H, V10.4H, V8.4H
    FMINP  V2.8H, V25.8H, V12.8H
    FMINNM  V20.4S, V25.4S, V22.4S
    SMINP  V12.16B, V6.16B, V26.16B
    SMINV  H7, V6.4H
    FMAXP D23, V30.2D
    UMAXP  V31.8B, V20.8B, V8.8B
    FMAXP H27, V12.2H
    SMINV  B12, V2.8B
    UMAXV  H10, V18.8H
    FMAXNMV  H20, V11.8H
    FMAXNMP  V8.2S, V20.2S, V7.2S
    UMINV  B25, V23.8B
    FMAXNMP S28, V10.2S
    FMINNM  V30.4H, V25.4H, V31.4H
    FMINNMP  V6.8H, V30.8H, V26.8H
    UMAXP  V19.4S, V22.4S, V15.4S
    FMINV  H18, V27.8H
    FMAXV  S10, V12.4S
    FMINP  V25.4H, V28.4H, V28.4H
    SMAXV  S2, V25.4S
    FMAXV  H28, V19.4H
    FMAXP H27, V10.2H
    FMAXV  S17, V8.4S
    FMAXV  S8, V2.4S
    SMIN  V22.4H, V29.4H, V17.4H
    FMINV  S25, V29.4S
    FMAXP  V20.8H, V11.8H, V8.8H
    FMINNMP  V2.4H, V17.4H, V11.4H
    FMAXP  V7.2D, V1.2D, V3.2D
    SMAXV  B19, V25.16B
    FMAXP  V31.8H, V31.8H, V18.8H
    FMINP S17, V7.2S
    FMAXV  S12, V11.4S
    FMIN  V3.2S, V2.2S, V2.2S
    UMAXV  H7, V3.8H
    FMINV  H25, V15.8H
    SMAXV  H29, V25.4H
    UMAXP  V5.4S, V22.4S, V27.4S
    UMIN  V10.4H, V20.4H, V23.4H
    FMINNMP S0, V28.2S
    FMINP H26, V12.2H
    FMAXNMP D23, V26.2D
    FMAXP D20, V17.2D
    UMAXV  H18, V10.4H
    FMAXNMV  H15, V5.4H
    FMAXV  H2, V7.8H
    FMINNMP  V27.4S, V24.4S, V31.4S
    FMINNMP S26, V15.2S
    UMAXV  B7, V26.16B
    FMINP S26, V23.2S
    FMINP H3, V2.2H
    FMAXNM  V1.8H, V3.8H, V5.8H
    FMAXV  S26, V0.4S
    FMAX  V3.4H, V18.4H, V27.4H
    FMAXV  H9, V20.8H
    SMAX  V11.16B, V7.16B, V26.16B
    FMAXP H7, V18.2H
    SMINP  V17.16B, V0.16B, V3.16B
    UMIN  V27.4S, V17.4S, V11.4S
    SMAXV  H5, V7.8H
    FMAXNMV  S26, V1.4S
    FMINNMP S28, V17.2S
    SUBS  X19, X19, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_8
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X7, FPSR
    MOVZ  X8, #0x81, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X7, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X3
    FMOV  V0.D[1], X29
    FMOV  D1, X12
    FMOV  V1.D[1], X20
    FMOV  D2, X23
    FMOV  V2.D[1], X22
    FMOV  D3, X12
    FMOV  V3.D[1], X19
    FMOV  D4, X3
    FMOV  V4.D[1], X7
    FMOV  D5, X20
    FMOV  V5.D[1], X14
    FMOV  D6, X17
    FMOV  V6.D[1], X11
    FMOV  D7, X4
    FMOV  V7.D[1], X11
    FMOV  D8, X12
    FMOV  V8.D[1], X17
    FMOV  D9, X3
    FMOV  V9.D[1], X3
    FMOV  D10, X23
    FMOV  V10.D[1], X2
    FMOV  D11, X10
    FMOV  V11.D[1], X3
    FMOV  D12, X2
    FMOV  V12.D[1], X10
    FMOV  D13, X15
    FMOV  V13.D[1], X12
    FMOV  D14, X5
    FMOV  V14.D[1], X29
    FMOV  D15, X5
    FMOV  V15.D[1], X12
    FMOV  D16, X9
    FMOV  V16.D[1], X13
    FMOV  D17, X23
    FMOV  V17.D[1], X10
    FMOV  D18, X17
    FMOV  V18.D[1], X17
    FMOV  D19, X11
    FMOV  V19.D[1], X8
    FMOV  D20, X21
    FMOV  V20.D[1], X13
    FMOV  D21, X16
    FMOV  V21.D[1], X9
    FMOV  D22, X11
    FMOV  V22.D[1], X15
    FMOV  D23, X9
    FMOV  V23.D[1], X15
    FMOV  D24, X15
    FMOV  V24.D[1], X16
    FMOV  D25, X4
    FMOV  V25.D[1], X9
    FMOV  D26, X16
    FMOV  V26.D[1], X29
    FMOV  D27, X11
    FMOV  V27.D[1], X4
    FMOV  D28, X18
    FMOV  V28.D[1], X16
    FMOV  D29, X23
    FMOV  V29.D[1], X21
    FMOV  D30, X5
    FMOV  V30.D[1], X7
    FMOV  D31, X19
    FMOV  V31.D[1], X19
    MOVZ  X7, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_9:
    FMINNMV  H14, V20.8H
    SMAXP  V20.2S, V27.2S, V18.2S
    FMAXP  V12.8H, V26.8H, V23.8H
    SMAXV  H14, V29.8H
    SMIN  V0.4S, V25.4S, V24.4S
    FMINNM  V17.2S, V28.2S, V14.2S
    FMIN  V24.2D, V17.2D, V22.2D
    UMAXV  S27, V12.4S
    UMAXV  S4, V24.4S
    FMAXNMV  H10, V27.8H
    FMAXNMP D19, V0.2D
    SMAX  V19.8B, V30.8B, V19.8B
    FMAXNMP  V25.4H, V20.4H, V31.4H
    FMIN  V30.2S, V5.2S, V19.2S
    UMAXV  B26, V2.8B
    FMAXNMP  V18.4H, V24.4H, V17.4H
    FMAXP S31, V18.2S
    FMAXNMV  H23, V4.8H
    FMAXV  S22, V26.4S
    UMINV  H2, V22.8H
    UMAXP  V29.8H, V25.8H, V10.8H
    FMINV  S4, V29.4S
    UMAXV  S22, V31.4S
    UMINP  V20.2S, V22.2S, V18.2S
    FMAXNMV  S24, V2.4S
    SMAXV  B26, V30.16B
    FMINP  V19.8H, V27.8H, V4.8H
    SMIN  V2.8H, V26.8H, V26.8H
    UMINV  B28, V16.8B
    FMAXV  H29, V11.8H
    FMINNM  V30.4H, V19.4H, V29.4H
    FMAXNMP H24, V20.2H
    SMAXP  V20.8H, V24.8H, V15.8H
    UMINP  V22.8B, V13.8B, V28.8B
    SMIN  V11.16B, V30.16B, V19.16B
    SMAXV  B29, V13.16B
    UMINV  B27, V23.8B
    UMINV  S10, V20.4S
    UMINP  V26.8B, V2.8B, V30.8B
    FMAXNMP H4, V17.2H
    FMAXNMP S24, V22.2S
    FMAXP H23, V10.2H
    FMAXNMP  V13.8H, V26.8H, V6.8H
    FMAXP  V28.4S, V19.4S, V23.4S
    FMINNMP D26, V28.2D
    FMAXP S6, V13.2S
    UMIN  V29.2S, V6.2S, V26.2S
    FMINP S13, V27.2S
    FMAXNMV  S20, V0.4S
    FMINNMP  V18.2S, V18.2S, V13.2S
    FMINNMP H0, V18.2H
    SMAXV  S3, V25.4S
    SMIN  V30.8H, V27.8H, V11.8H
    FMINP D1, V4.2D
    UMAXV  B27, V16.8B
    SMINV  B23, V27.8B
    FMINNMP  V18.2S, V20.2S, V21.2S
    FMINNMV  H11, V23.4H
    FMAXP  V6.8H, V24.8H, V3.8H
    FMINP D27, V18.2D
    FMAX  V3.8H, V1.8H, V29.8H
    FMINNMP H26, V30.2H
    FMAXV  H28, V3.8H
    FMINV  H29, V28.8H
    FMINV  S16, V27.4S
    FMAXNMP  V23.2S, V1.2S, V29.2S
    FMAXP H27, V16.2H
    SMIN  V22.16B, V27.16B, V6.16B
    FMINNMV  S24, V0.4S
    FMAXNM  V4.4S, V14.4S, V11.4S
    FMAXNMP  V10.2D, V6.2D, V19.2D
    SMIN  V5.8H, V9.8H, V17.8H
    UMAX  V18.4H, V5.4H, V10.4H
    FMAXV  H27, V24.4H
    FMINP S29, V4.2S
    FMINNMP  V14.4S, V26.4S, V29.4S
    FMAXNM  V1.4H, V12.4H, V25.4H
    FMAXP S26, V1.2S
    FMAXP  V11.2S, V26.2S, V27.2S
    FMINNM  V1.2S, V14.2S, V19.2S
    UMIN  V10.4S, V23.4S, V21.4S
    FMAXNMP S23, V30.2S
    FMINNMP H20, V1.2H
    UMAXP  V24.8H, V22.8H, V11.8H
    FMINNMV  S14, V23.4S
    UMAXP  V12.4H, V17.4H, V18.4H
    FMINP  V20.8H, V10.8H, V10.8H
    FMAXNMP D25, V13.2D
    FMINNMV  H10, V29.4H
    FMINNM  V13.2D, V23.2D, V25.2D
    FMAXNMV  H0, V5.4H
    FMINP S23, V11.2S
    FMINNMV  S25, V10.4S
    SMINV  H5, V20.4H
    FMIN  V1.4H, V14.4H, V0.4H
    FMINV  S10, V1.4S
    FMAXNMP S17, V13.2S
    FMAXNM  V23.8H, V25.8H, V13.8H
    SMAXV  H1, V12.8H
    FMIN  V25.8H, V23.8H, V17.8H
    UMIN  V11.2S, V13.2S, V25.2S
    SMIN  V12.8B, V11.8B, V17.8B
    FMINNM  V20.4H, V7.4H, V12.4H
    SMINV  H8, V1.4H
    FMINNMP  V18.8H, V20.8H, V8.8H
    FMINP  V20.8H, V23.8H, V10.8H
    UMAXV  H23, V19.8H
    UMAX  V11.4S, V5.4S, V19.4S
    FMAXP H14, V18.2H
    FMAXP D13, V18.2D
    UMINV  S17, V25.4S
    FMAXNMP  V5.8H, V13.8H, V11.8H
    FMIN  V17.8H, V25.8H, V23.8H
    FMIN  V13.2D, V31.2D, V20.2D
    FMINP H25, V11.2H
    SMINV  B7, V14.8B
    FMINP  V26.2S, V17.2S, V13.2S
    FMAXNMV  H25, V23.8H
    UMAX  V10.8H, V5.8H, V5.8H
    SMINP  V31.2S, V24.2S, V1.2S
    FMIN  V13.8H, V27.8H, V26.8H
    FMAXV  S27, V25.4S
    UMIN  V5.2S, V31.2S, V31.2S
    UMAXP  V24.16B, V11.16B, V7.16B
    SMINV  H18, V16.8H
    UMINV  S19, V13.4S
    SMAX  V25.16B, V24.16B, V27.16B
    FMAXV  S25, V25.4S
    FMAXNM  V1.8H, V25.8H, V25.8H
    UMAXV  B24, V17.8B
    FMAXNMP D31, V1.2D
    FMAXV  H9, V3.4H
    SMINV  S17, V18.4S
    FMAXV  S16, V24.4S
    UMAXV  H3, V29.8H
    FMINNMV  H25, V9.4H
    FMINP D18, V19.2D
    SMAXP  V19.8B, V1.8B, V17.8B
    UMAX  V29.2S, V3.2S, V8.2S
    FMAXNM  V17.2S, V31.2S, V18.2S
    UMAXV  H13, V17.4H
    FMINV  H26, V10.4H
    FMAX  V18.8H, V19.8H, V19.8H
    UMINV  S20, V29.4S
    FMAXP S27, V18.2S
    FMAXP D17, V20.2D
    FMAXNMP  V9.4H, V25.4H, V22.4H
    SMINV  B10, V16.8B
    SMINV  B29, V17.16B
    FMINNMP H18, V13.2H
    SMAXV  H8, V5.8H
    FMAXV  S25, V27.4S
    SMINV  B27, V18.16B
    FMINNM  V26.8H, V21.8H, V26.8H
    FMAXNMP H1, V27.2H
    UMAX  V7.4H, V8.4H, V23.4H
    FMAXNMP  V21.2S, V26.2S, V7.2S
    SMINV  B17, V28.8B
    FMINNMP S18, V1.2S
    FMINNMP S23, V15.2S
    FMAXNMP D27, V25.2D
    UMIN  V16.4S, V21.4S, V18.4S
    FMINP S18, V27.2S
    FMAXNMP  V1.4S, V16.4S, V18.4S
    FMINP H5, V26.2H
    FMAX  V13.4H, V8.4H, V31.4H
    UMINV  S15, V9.4S
    UMINP  V27.2S, V25.2S, V13.2S
    FMAX  V18.2D, V17.2D, V29.2D
    FMAXNMP D28, V0.2D
    FMINNMP D29, V27.2D
    SMAXP  V26.8B, V18.8B, V1.8B
    UMAXV  B7, V6.16B
    FMAXV  H13, V15.4H
    SMAXV  H17, V13.4H
    FMINNMV  S31, V1.4S
    UMINV  S9, V23.4S
    UMINV  B30, V5.16B
    SMINP  V20.16B, V31.16B, V7.16B
    UMAXV  B7, V20.16B
    FMAX  V1.4H, V5.4H, V17.4H
    UMAX  V21.16B, V26.16B, V30.16B
    FMAXNM  V17.2D, V10.2D, V7.2D
    FMAX  V27.4S, V26.4S, V15.4S
    FMINNMP  V26.2D, V14.2D, V1.2D
    SMINV  H8, V15.4H
    FMINP  V0.2D, V24.2D, V27.2D
    FMINNMP  V27.4H, V27.4H, V22.4H
    FMINNMP  V18.8H, V8.8H, V21.8H
    FMAXNMP  V16.8H, V18.8H, V9.8H
    FMINV  S6, V10.4S
    FMINNMV  S31, V16.4S
    FMAXNMV  S21, V6.4S
    FMINP D21, V26.2D
    FMAXP D5, V8.2D
    FMAXNMP D25, V4.2D
    FMINP H1, V1.2H
    UMAXV  H17, V9.4H
    FMAXNM  V7.2S, V15.2S, V31.2S
    UMINV  S18, V1.4S
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_9
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X8, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X23, FPSR
    MOVZ  X8, #0x81, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X2, #0x8c19, LSL #0
    MOVK  X2, #0x9ab3, LSL #16
    MOVK  X2, #0x9906, LSL #32
    MOVK  X2, #0xdbaf, LSL #48
    MOVZ  X3, #0xc4c0, LSL #0
    MOVK  X3, #0x96d, LSL #16
    MOVK  X3, #0x2df0, LSL #32
    MOVK  X3, #0xf0e9, LSL #48
    MOVZ  X4, #0xe5a2, LSL #0
    MOVK  X4, #0x90ca, LSL #16
    MOVK  X4, #0xa16a, LSL #32
    MOVK  X4, #0x4716, LSL #48
    MOVZ  X5, #0x3038, LSL #0
    MOVK  X5, #0x24e5, LSL #16
    MOVK  X5, #0x92a9, LSL #32
    MOVK  X5, #0x9558, LSL #48
    MOVZ  X6, #0xd880, LSL #0
    MOVK  X6, #0x447, LSL #16
    MOVK  X6, #0xe04b, LSL #32
    MOVK  X6, #0xf4b8, LSL #48
    MOVZ  X7, #0x39f5, LSL #0
    MOVK  X7, #0xd1f, LSL #16
    MOVK  X7, #0x9ca2, LSL #32
    MOVK  X7, #0x56b8, LSL #48
    MOVZ  X8, #0x83ab, LSL #0
    MOVK  X8, #0xd883, LSL #16
    MOVK  X8, #0x349c, LSL #32
    MOVK  X8, #0xa862, LSL #48
    MOVZ  X9, #0x3df1, LSL #0
    MOVK  X9, #0xf16e, LSL #16
    MOVK  X9, #0x5594, LSL #32
    MOVK  X9, #0x6bd9, LSL #48
    MOVZ  X10, #0xdbb, LSL #0
    MOVK  X10, #0x20f7, LSL #16
    MOVK  X10, #0x38eb, LSL #32
    MOVK  X10, #0x125e, LSL #48
    MOVZ  X11, #0xf8dc, LSL #0
    MOVK  X11, #0xd1c4, LSL #16
    MOVK  X11, #0x17cb, LSL #32
    MOVK  X11, #0x1132, LSL #48
    MOVZ  X12, #0xf5ac, LSL #0
    MOVK  X12, #0xc076, LSL #16
    MOVK  X12, #0x7ed7, LSL #32
    MOVK  X12, #0x920e, LSL #48
    MOVZ  X13, #0xc2e0, LSL #0
    MOVK  X13, #0x7def, LSL #16
    MOVK  X13, #0xfcd2, LSL #32
    MOVK  X13, #0x88a4, LSL #48
    MOVZ  X14, #0xa33b, LSL #0
    MOVK  X14, #0x9378, LSL #16
    MOVK  X14, #0xa23, LSL #32
    MOVK  X14, #0xea62, LSL #48
    MOVZ  X15, #0xfa90, LSL #0
    MOVK  X15, #0xe9eb, LSL #16
    MOVK  X15, #0x5b46, LSL #32
    MOVK  X15, #0xe485, LSL #48
    MOVZ  X16, #0xa889, LSL #0
    MOVK  X16, #0xe96, LSL #16
    MOVK  X16, #0x6582, LSL #32
    MOVK  X16, #0x854a, LSL #48
    MOVZ  X17, #0x6558, LSL #0
    MOVK  X17, #0x9f41, LSL #16
    MOVK  X17, #0xb3f3, LSL #32
    MOVK  X17, #0xf125, LSL #48
    MOVZ  X18, #0x18bc, LSL #0
    MOVK  X18, #0x5d2b, LSL #16
    MOVK  X18, #0x2fc4, LSL #32
    MOVK  X18, #0x7480, LSL #48
    MOVZ  X19, #0x8964, LSL #0
    MOVK  X19, #0x9928, LSL #16
    MOVK  X19, #0xa1ea, LSL #32
    MOVK  X19, #0xdda4, LSL #48
    MOVZ  X20, #0x1b52, LSL #0
    MOVK  X20, #0x2e92, LSL #16
    MOVK  X20, #0xbe38, LSL #32
    MOVK  X20, #0x25cc, LSL #48
    MOVZ  X21, #0x3340, LSL #0
    MOVK  X21, #0xde58, LSL #16
    MOVK  X21, #0x116a, LSL #32
    MOVK  X21, #0xc34d, LSL #48
    MOVZ  X22, #0x9788, LSL #0
    MOVK  X22, #0x4cb2, LSL #16
    MOVK  X22, #0x4b5b, LSL #32
    MOVK  X22, #0xe204, LSL #48
    MOVZ  X23, #0xb450, LSL #0
    MOVK  X23, #0xf870, LSL #16
    MOVK  X23, #0xfe5, LSL #32
    MOVK  X23, #0xd5db, LSL #48
    MOVZ  X29, #0x232c, LSL #0
    MOVK  X29, #0x9764, LSL #16
    MOVK  X29, #0x6f51, LSL #32
    MOVK  X29, #0x2734, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X22
    FMOV  D1, X19
    FMOV  V1.D[1], X20
    FMOV  D2, X21
    FMOV  V2.D[1], X9
    FMOV  D3, X23
    FMOV  V3.D[1], X13
    FMOV  D4, X3
    FMOV  V4.D[1], X22
    FMOV  D5, X29
    FMOV  V5.D[1], X20
    FMOV  D6, X6
    FMOV  V6.D[1], X2
    FMOV  D7, X19
    FMOV  V7.D[1], X13
    FMOV  D8, X13
    FMOV  V8.D[1], X13
    FMOV  D9, X12
    FMOV  V9.D[1], X5
    FMOV  D10, X22
    FMOV  V10.D[1], X18
    FMOV  D11, X7
    FMOV  V11.D[1], X10
    FMOV  D12, X5
    FMOV  V12.D[1], X15
    FMOV  D13, X16
    FMOV  V13.D[1], X19
    FMOV  D14, X8
    FMOV  V14.D[1], X7
    FMOV  D15, X12
    FMOV  V15.D[1], X16
    FMOV  D16, X21
    FMOV  V16.D[1], X7
    FMOV  D17, X23
    FMOV  V17.D[1], X4
    FMOV  D18, X2
    FMOV  V18.D[1], X14
    FMOV  D19, X13
    FMOV  V19.D[1], X6
    FMOV  D20, X15
    FMOV  V20.D[1], X3
    FMOV  D21, X8
    FMOV  V21.D[1], X19
    FMOV  D22, X5
    FMOV  V22.D[1], X8
    FMOV  D23, X15
    FMOV  V23.D[1], X16
    FMOV  D24, X14
    FMOV  V24.D[1], X17
    FMOV  D25, X23
    FMOV  V25.D[1], X8
    FMOV  D26, X17
    FMOV  V26.D[1], X3
    FMOV  D27, X4
    FMOV  V27.D[1], X7
    FMOV  D28, X5
    FMOV  V28.D[1], X9
    FMOV  D29, X18
    FMOV  V29.D[1], X13
    FMOV  D30, X19
    FMOV  V30.D[1], X10
    FMOV  D31, X22
    FMOV  V31.D[1], X3
    MOVZ  X5, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_10:
    FMAXV  H25, V30.4H
    UMAXP  V27.2S, V31.2S, V22.2S
    FMINNMP H2, V26.2H
    UMINV  B12, V29.16B
    FMINNMP S27, V27.2S
    FMAXNMV  S5, V7.4S
    FMINNMP  V9.4H, V18.4H, V21.4H
    FMAXNMP D4, V5.2D
    FMAXV  H29, V25.4H
    FMINNMP D11, V2.2D
    FMAXNMP  V9.4S, V7.4S, V27.4S
    FMINNMP S19, V4.2S
    FMAXP D6, V28.2D
    UMINV  H5, V15.8H
    SMINV  H1, V6.4H
    UMAXV  H2, V28.8H
    FMAXV  H6, V1.8H
    FMAXNMV  S6, V9.4S
    UMAXP  V29.16B, V19.16B, V16.16B
    UMAXV  S12, V14.4S
    SMAXP  V9.4S, V21.4S, V6.4S
    FMAXNMV  H22, V12.4H
    UMINV  B25, V10.8B
    FMAXNMP  V4.4H, V18.4H, V11.4H
    UMINV  S14, V5.4S
    FMINNMP H2, V9.2H
    FMAXV  H21, V22.4H
    FMAXV  S19, V23.4S
    FMAXP H23, V14.2H
    UMINP  V31.2S, V25.2S, V23.2S
    UMINP  V27.8B, V29.8B, V14.8B
    UMAXV  S15, V8.4S
    UMAXP  V24.2S, V2.2S, V2.2S
    FMAXP D1, V31.2D
    FMAXNMP H16, V31.2H
    FMINP D25, V15.2D
    SMINV  S10, V5.4S
    FMINNMP S23, V30.2S
    FMAXNMP  V6.2S, V16.2S, V19.2S
    UMINV  B14, V6.16B
    SMINP  V14.2S, V25.2S, V24.2S
    SMAXV  B25, V21.8B
    FMINNMP  V22.4H, V27.4H, V14.4H
    UMIN  V21.4S, V4.4S, V28.4S
    SMINV  H27, V18.8H
    FMINNMV  H18, V26.8H
    SMAXP  V29.8H, V22.8H, V21.8H
    FMAXNMP D20, V27.2D
    SMAXV  H8, V19.4H
    SMAXV  H31, V20.4H
    FMINNM  V15.4S, V31.4S, V16.4S
    FMAXNM  V11.2S, V15.2S, V8.2S
    FMINP S19, V23.2S
    UMAXP  V26.8H, V10.8H, V18.8H
    UMINV  B16, V1.8B
    UMAXV  S5, V14.4S
    FMINV  S30, V10.4S
    FMAXNM  V27.8H, V11.8H, V29.8H
    FMINNMP S24, V27.2S
    FMINNMP  V25.4H, V9.4H, V16.4H
    FMAXNMV  S23, V2.4S
    FMINNMP S16, V30.2S
    UMAX  V31.4H, V15.4H, V25.4H
    FMAXP  V10.4S, V1.4S, V24.4S
    FMINNM  V30.2D, V16.2D, V5.2D
    FMINP S8, V26.2S
    UMIN  V11.8H, V8.8H, V10.8H
    FMINP  V22.8H, V26.8H, V14.8H
    SMAXV  S9, V23.4S
    SMAXP  V2.8H, V30.8H, V30.8H
    FMINP  V16.2D, V14.2D, V31.2D
    FMINNMP  V8.2S, V2.2S, V29.2S
    UMINV  B26, V3.16B
    FMAXNMP S17, V26.2S
    FMINP D23, V7.2D
    FMINNMP D20, V16.2D
    FMINNMP H31, V20.2H
    FMINP S14, V23.2S
    FMAXV  S2, V5.4S
    FMINNMP  V21.4H, V17.4H, V22.4H
    SMAXV  S18, V21.4S
    UMINP  V29.4H, V9.4H, V8.4H
    FMINNMP D24, V19.2D
    FMINNM  V20.4S, V29.4S, V29.4S
    FMAXV  H17, V16.8H
    FMAXP D5, V2.2D
    UMINV  B7, V28.16B
    FMAXNMP  V13.4S, V14.4S, V24.4S
    FMINP S19, V20.2S
    FMAXNMP  V9.2S, V3.2S, V11.2S
    FMINP H16, V19.2H
    FMAXP H20, V21.2H
    FMINV  S15, V16.4S
    FMINV  H16, V18.8H
    UMAXV  B26, V15.8B
    FMINP  V31.4H, V13.4H, V28.4H
    UMINV  S21, V7.4S
    SMAXV  H24, V2.8H
    FMIN  V19.4H, V26.4H, V20.4H
    FMINP  V28.8H, V2.8H, V27.8H
    FMAXP H29, V24.2H
    SMAXV  B24, V9.8B
    UMIN  V8.16B, V26.16B, V31.16B
    FMINNMP  V26.8H, V24.8H, V29.8H
    SMINV  B9, V16.8B
    FMINNMP  V14.4H, V21.4H, V9.4H
    FMAXNMP  V31.2S, V6.2S, V26.2S
    FMAXNMP  V13.4H, V31.4H, V8.4H
    FMINP  V2.4H, V7.4H, V13.4H
    FMINP S21, V14.2S
    UMAXV  H14, V19.8H
    FMAXNMP S14, V5.2S
    FMINP  V18.2S, V26.2S, V9.2S
    FMIN  V27.2D, V21.2D, V16.2D
    SMINV  H30, V28.8H
    UMINP  V28.2S, V14.2S, V14.2S
    SMAXP  V6.8B, V18.8B, V28.8B
    FMAXV  S19, V18.4S
    FMAXNMV  S18, V27.4S
    FMINV  S12, V19.4S
    FMAXV  S14, V6.4S
    FMAXP S11, V9.2S
    UMINV  S31, V26.4S
    FMAXP D9, V21.2D
    FMIN  V28.4H, V18.4H, V31.4H
    FMAX  V31.2D, V25.2D, V30.2D
    FMAXNM  V8.4H, V11.4H, V12.4H
    UMIN  V25.4H, V14.4H, V8.4H
    FMAXP H12, V10.2H
    FMINP  V11.2S, V31.2S, V12.2S
    UMAXV  B30, V2.8B
    UMIN  V16.4S, V16.4S, V24.4S
    FMINP S24, V11.2S
    FMAXV  H17, V9.4H
    UMAXV  S31, V13.4S
    UMAXV  S8, V31.4S
    FMINNM  V11.2S, V24.2S, V24.2S
    SMIN  V6.16B, V8.16B, V8.16B
    SMINV  B9, V17.8B
    FMAXNMP  V12.8H, V30.8H, V6.8H
    FMAXNMP  V6.4S, V16.4S, V16.4S
    SMAXV  H8, V8.4H
    UMAXV  S28, V16.4S
    FMINNM  V16.2D, V11.2D, V12.2D
    UMAX  V14.8B, V6.8B, V28.8B
    UMINV  S31, V13.4S
    UMINV  S21, V25.4S
    FMAXP  V6.2S, V14.2S, V21.2S
    SMAXP  V10.16B, V9.16B, V16.16B
    SMAXV  B1, V1.16B
    UMAXV  B2, V10.16B
    FMINNM  V14.2D, V6.2D, V31.2D
    UMINV  B28, V14.16B
    FMAXNMP S9, V1.2S
    FMINNMP  V12.8H, V28.8H, V8.8H
    UMINV  B17, V12.16B
    FMIN  V10.4H, V22.4H, V17.4H
    SMINV  S28, V10.4S
    FMINNMP D24, V2.2D
    FMINP H13, V24.2H
    FMAXNMP  V1.8H, V28.8H, V9.8H
    FMAXNMP  V24.8H, V23.8H, V9.8H
    FMINNMP S31, V6.2S
    UMINV  S12, V6.4S
    SMAXV  S2, V12.4S
    FMAXV  H14, V4.8H
    SMAXP  V24.8H, V12.8H, V19.8H
    FMINP  V16.4H, V24.4H, V11.4H
    SMINP  V28.8B, V0.8B, V4.8B
    SMINV  B24, V12.8B
    SMINV  B12, V20.16B
    FMINNM  V23.8H, V1.8H, V12.8H
    FMAXP H12, V14.2H
    FMINNMP S17, V31.2S
    SMAXP  V22.8H, V2.8H, V28.8H
    FMAX  V2.2D, V22.2D, V12.2D
    FMINV  H10, V17.4H
    UMINV  S0, V24.4S
    SMAXV  H11, V10.4H
    SMINP  V23.4H, V2.4H, V12.4H
    FMINNMP  V30.8H, V16.8H, V29.8H
    SMAXV  S2, V22.4S
    FMIN  V4.8H, V23.8H, V30.8H
    FMINNMV  S31, V4.4S
    UMINV  B24, V1.16B
    FMAXNMP  V10.4S, V16.4S, V2.4S
    FMAXV  S14, V12.4S
    FMINNMV  H30, V10.8H
    UMAXV  S31, V30.4S
    SMAX  V4.16B, V24.16B, V2.16B
    FMAXNMP H29, V14.2H
    FMINV  S21, V4.4S
    UMAX  V23.8H, V5.8H, V19.8H
    FMAXP H28, V21.2H
    UMAXV  H20, V25.8H
    SMAXP  V16.2S, V0.2S, V31.2S
    FMAXP  V4.4H, V0.4H, V29.4H
    FMINP  V14.4H, V14.4H, V16.4H
    UMAXV  S25, V15.4S
    FMAXNMV  H5, V20.4H
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_10
    MOVZ  X16, #0x8c19, LSL #0
    MOVK  X16, #0x9ab3, LSL #16
    MOVK  X16, #0x9906, LSL #32
    MOVK  X16, #0xdbaf, LSL #48
    SUB  X18, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xc4c0, LSL #0
    MOVK  X16, #0x96d, LSL #16
    MOVK  X16, #0x2df0, LSL #32
    MOVK  X16, #0xf0e9, LSL #48
    SUB  X18, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xe5a2, LSL #0
    MOVK  X16, #0x90ca, LSL #16
    MOVK  X16, #0xa16a, LSL #32
    MOVK  X16, #0x4716, LSL #48
    SUB  X18, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xd880, LSL #0
    MOVK  X16, #0x447, LSL #16
    MOVK  X16, #0xe04b, LSL #32
    MOVK  X16, #0xf4b8, LSL #48
    SUB  X18, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x39f5, LSL #0
    MOVK  X16, #0xd1f, LSL #16
    MOVK  X16, #0x9ca2, LSL #32
    MOVK  X16, #0x56b8, LSL #48
    SUB  X18, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x83ab, LSL #0
    MOVK  X16, #0xd883, LSL #16
    MOVK  X16, #0x349c, LSL #32
    MOVK  X16, #0xa862, LSL #48
    SUB  X18, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x3df1, LSL #0
    MOVK  X16, #0xf16e, LSL #16
    MOVK  X16, #0x5594, LSL #32
    MOVK  X16, #0x6bd9, LSL #48
    SUB  X18, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xdbb, LSL #0
    MOVK  X16, #0x20f7, LSL #16
    MOVK  X16, #0x38eb, LSL #32
    MOVK  X16, #0x125e, LSL #48
    SUB  X18, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xf8dc, LSL #0
    MOVK  X16, #0xd1c4, LSL #16
    MOVK  X16, #0x17cb, LSL #32
    MOVK  X16, #0x1132, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xf5ac, LSL #0
    MOVK  X16, #0xc076, LSL #16
    MOVK  X16, #0x7ed7, LSL #32
    MOVK  X16, #0x920e, LSL #48
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xc2e0, LSL #0
    MOVK  X16, #0x7def, LSL #16
    MOVK  X16, #0xfcd2, LSL #32
    MOVK  X16, #0x88a4, LSL #48
    SUB  X18, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xa33b, LSL #0
    MOVK  X16, #0x9378, LSL #16
    MOVK  X16, #0xa23, LSL #32
    MOVK  X16, #0xea62, LSL #48
    SUB  X18, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xfa90, LSL #0
    MOVK  X16, #0xe9eb, LSL #16
    MOVK  X16, #0x5b46, LSL #32
    MOVK  X16, #0xe485, LSL #48
    SUB  X18, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x6558, LSL #0
    MOVK  X16, #0x9f41, LSL #16
    MOVK  X16, #0xb3f3, LSL #32
    MOVK  X16, #0xf125, LSL #48
    SUB  X18, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x8964, LSL #0
    MOVK  X16, #0x9928, LSL #16
    MOVK  X16, #0xa1ea, LSL #32
    MOVK  X16, #0xdda4, LSL #48
    SUB  X18, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x1b52, LSL #0
    MOVK  X16, #0x2e92, LSL #16
    MOVK  X16, #0xbe38, LSL #32
    MOVK  X16, #0x25cc, LSL #48
    SUB  X18, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x9788, LSL #0
    MOVK  X16, #0x4cb2, LSL #16
    MOVK  X16, #0x4b5b, LSL #32
    MOVK  X16, #0xe204, LSL #48
    SUB  X18, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0xb450, LSL #0
    MOVK  X16, #0xf870, LSL #16
    MOVK  X16, #0xfe5, LSL #32
    MOVK  X16, #0xd5db, LSL #48
    SUB  X18, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X16, #0x232c, LSL #0
    MOVK  X16, #0x9764, LSL #16
    MOVK  X16, #0x6f51, LSL #32
    MOVK  X16, #0x2734, LSL #48
    SUB  X18, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X16, FPSR
    MOVZ  X18, #0x81, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D0
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D1
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X18, #0xc2e0, LSL #0
    MOVK  X18, #0x7def, LSL #16
    MOVK  X18, #0xfcd2, LSL #32
    MOVK  X18, #0x88a4, LSL #48
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D3
    MOVZ  X18, #0xb450, LSL #0
    MOVK  X18, #0xf870, LSL #16
    MOVK  X18, #0xfe5, LSL #32
    MOVK  X18, #0xd5db, LSL #48
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D5
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D18
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D30
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X16, D31
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  D0, X2
    FMOV  V0.D[1], X4
    FMOV  D1, X7
    FMOV  V1.D[1], X29
    FMOV  D2, X15
    FMOV  V2.D[1], X9
    FMOV  D3, X22
    FMOV  V3.D[1], X21
    FMOV  D4, X14
    FMOV  V4.D[1], X20
    FMOV  D5, X23
    FMOV  V5.D[1], X2
    FMOV  D6, X17
    FMOV  V6.D[1], X13
    FMOV  D7, X19
    FMOV  V7.D[1], X17
    FMOV  D8, X13
    FMOV  V8.D[1], X3
    FMOV  D9, X21
    FMOV  V9.D[1], X19
    FMOV  D10, X22
    FMOV  V10.D[1], X6
    FMOV  D11, X10
    FMOV  V11.D[1], X10
    FMOV  D12, X2
    FMOV  V12.D[1], X29
    FMOV  D13, X3
    FMOV  V13.D[1], X2
    FMOV  D14, X2
    FMOV  V14.D[1], X2
    FMOV  D15, X13
    FMOV  V15.D[1], X16
    FMOV  D16, X19
    FMOV  V16.D[1], X22
    FMOV  D17, X29
    FMOV  V17.D[1], X12
    FMOV  D18, X29
    FMOV  V18.D[1], X18
    FMOV  D19, X16
    FMOV  V19.D[1], X4
    FMOV  D20, X23
    FMOV  V20.D[1], X15
    FMOV  D21, X20
    FMOV  V21.D[1], X3
    FMOV  D22, X16
    FMOV  V22.D[1], X2
    FMOV  D23, X3
    FMOV  V23.D[1], X12
    FMOV  D24, X23
    FMOV  V24.D[1], X17
    FMOV  D25, X22
    FMOV  V25.D[1], X21
    FMOV  D26, X13
    FMOV  V26.D[1], X6
    FMOV  D27, X21
    FMOV  V27.D[1], X23
    FMOV  D28, X12
    FMOV  V28.D[1], X5
    FMOV  D29, X10
    FMOV  V29.D[1], X4
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X16
    FMOV  V31.D[1], X23
    MOVZ  X8, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_11:
    FMINP D8, V3.2D
    FMINP S25, V27.2S
    FMINP  V6.2D, V24.2D, V23.2D
    FMAXP  V2.4S, V26.4S, V3.4S
    FMINP  V18.2S, V6.2S, V10.2S
    FMINNMP H15, V31.2H
    SMAXV  S21, V15.4S
    FMAXNMP D0, V2.2D
    SMAXV  B25, V31.16B
    FMINNMP D6, V25.2D
    FMINNMP D18, V29.2D
    FMINP S14, V18.2S
    FMAX  V24.8H, V27.8H, V0.8H
    FMINNM  V1.4S, V3.4S, V8.4S
    FMINNMP D25, V28.2D
    FMINNMP D27, V6.2D
    FMIN  V15.4S, V9.4S, V24.4S
    FMAXNMP  V2.2S, V1.2S, V1.2S
    UMINP  V26.16B, V25.16B, V27.16B
    UMINV  B1, V15.8B
    FMINNMV  H3, V26.8H
    UMINV  B24, V1.16B
    FMINP  V10.2D, V7.2D, V30.2D
    UMINP  V23.4S, V22.4S, V1.4S
    FMAXNMP S18, V23.2S
    FMINP H8, V0.2H
    UMIN  V30.8B, V21.8B, V22.8B
    FMINNMP H16, V2.2H
    FMINP S26, V19.2S
    FMINNMP D19, V3.2D
    FMAXNMP  V2.8H, V10.8H, V5.8H
    FMAXNMP  V6.4S, V24.4S, V2.4S
    FMAXNMP H28, V16.2H
    FMINP D15, V18.2D
    FMAX  V24.2D, V15.2D, V6.2D
    UMINV  H1, V30.4H
    FMAXNM  V27.2S, V1.2S, V24.2S
    FMAXP S7, V28.2S
    FMAXNMP  V21.4H, V19.4H, V7.4H
    FMINNMP S6, V8.2S
    FMAXP  V8.4H, V21.4H, V14.4H
    FMINP H11, V6.2H
    FMINNMV  H10, V31.4H
    FMAXP  V15.2S, V8.2S, V6.2S
    UMAXV  S30, V21.4S
    FMAXP H19, V3.2H
    FMINP  V18.4H, V30.4H, V20.4H
    FMAXP  V16.4S, V28.4S, V10.4S
    FMINP  V5.8H, V26.8H, V18.8H
    FMAX  V14.2S, V0.2S, V27.2S
    FMINNM  V30.8H, V25.8H, V9.8H
    FMINP H1, V18.2H
    FMIN  V8.2D, V10.2D, V6.2D
    FMINP S21, V16.2S
    SMAXV  B21, V13.8B
    FMINNMP H26, V21.2H
    FMAXNMV  S29, V14.4S
    UMINV  S25, V14.4S
    FMAXNMV  S14, V5.4S
    SMIN  V6.8H, V29.8H, V1.8H
    FMINP H27, V30.2H
    FMINNMV  S10, V15.4S
    SMIN  V3.8B, V6.8B, V14.8B
    UMINV  B15, V25.16B
    FMAXNM  V30.2D, V3.2D, V27.2D
    FMINP H14, V22.2H
    FMAXNMV  S27, V30.4S
    UMAXP  V30.16B, V26.16B, V10.16B
    SMINV  B3, V19.16B
    FMINP H30, V15.2H
    UMAX  V25.4S, V27.4S, V16.4S
    FMAXP  V18.4S, V14.4S, V0.4S
    SMAXV  H29, V23.8H
    UMINV  B5, V26.8B
    UMINP  V16.4H, V3.4H, V18.4H
    UMINV  B3, V25.8B
    FMINNMV  H23, V30.4H
    UMIN  V14.4H, V5.4H, V16.4H
    SMAX  V2.8B, V3.8B, V28.8B
    FMAXNM  V30.4S, V0.4S, V23.4S
    FMAX  V25.4H, V14.4H, V12.4H
    UMINV  H15, V30.4H
    UMAXP  V5.2S, V29.2S, V27.2S
    SMINP  V29.8H, V25.8H, V9.8H
    SMINP  V27.4S, V1.4S, V24.4S
    FMAX  V0.2S, V29.2S, V15.2S
    UMIN  V25.8B, V27.8B, V0.8B
    FMIN  V27.8H, V25.8H, V2.8H
    FMAXNM  V28.2S, V3.2S, V9.2S
    FMINNM  V30.8H, V6.8H, V16.8H
    FMINV  H30, V1.8H
    FMINNM  V8.8H, V28.8H, V28.8H
    SMAXV  H29, V26.8H
    UMAXV  H26, V24.8H
    FMINP  V0.8H, V28.8H, V25.8H
    SMINV  B0, V5.16B
    FMINNM  V12.4H, V27.4H, V2.4H
    FMINNM  V25.4H, V22.4H, V3.4H
    UMINV  B6, V6.16B
    UMAXV  H27, V19.4H
    FMAXNMV  S14, V0.4S
    UMAXV  S16, V8.4S
    FMINNMP H29, V25.2H
    SMAXV  H1, V1.4H
    FMINNMP H2, V10.2H
    SMINV  S9, V16.4S
    FMAXV  H13, V6.4H
    UMAXV  H7, V2.8H
    SMAXP  V12.4S, V26.4S, V1.4S
    FMINNMV  S16, V13.4S
    UMAXV  S25, V27.4S
    SMAXV  B0, V29.8B
    SMINV  H19, V16.8H
    FMAX  V10.8H, V12.8H, V5.8H
    UMINP  V27.8H, V25.8H, V16.8H
    FMAXNMP  V1.4S, V0.4S, V3.4S
    FMAXV  H26, V23.8H
    FMAX  V2.8H, V26.8H, V10.8H
    FMAXNMP S6, V7.2S
    FMAXNM  V24.2S, V6.2S, V30.2S
    FMAXNMV  H26, V14.8H
    SMINV  B26, V9.8B
    UMAXV  H9, V1.4H
    FMINNM  V0.8H, V27.8H, V29.8H
    FMINNMP D8, V24.2D
    FMINNMP S7, V23.2S
    FMAXNMV  H3, V9.8H
    FMINNMP S13, V3.2S
    UMIN  V24.4S, V8.4S, V7.4S
    FMAXP  V24.8H, V0.8H, V2.8H
    FMINP S14, V19.2S
    FMIN  V18.4H, V0.4H, V14.4H
    UMIN  V27.2S, V24.2S, V24.2S
    FMINP S29, V18.2S
    FMINV  H14, V26.8H
    FMAXP  V0.2D, V27.2D, V23.2D
    FMINNMV  H26, V5.8H
    UMINV  S5, V14.4S
    SMIN  V18.2S, V26.2S, V0.2S
    SMAXP  V24.4S, V29.4S, V18.4S
    FMINP H27, V24.2H
    FMINV  S8, V0.4S
    UMIN  V24.4S, V8.4S, V24.4S
    FMAXNMP D10, V13.2D
    FMAXNMP D9, V20.2D
    FMINP D3, V10.2D
    UMAXP  V7.4H, V9.4H, V24.4H
    FMINNMP  V6.2S, V11.2S, V3.2S
    FMAXNM  V0.2D, V11.2D, V31.2D
    UMAXV  B27, V27.16B
    FMAXNMP H3, V8.2H
    FMAXP  V11.4H, V27.4H, V0.4H
    FMINP D13, V3.2D
    FMINP  V14.2S, V1.2S, V6.2S
    FMINNM  V29.8H, V7.8H, V7.8H
    SMINV  B31, V24.16B
    FMIN  V7.4S, V3.4S, V5.4S
    FMINP H1, V7.2H
    SMAXV  S12, V14.4S
    FMAXNMP H3, V29.2H
    SMAXP  V0.2S, V31.2S, V11.2S
    UMINV  S7, V13.4S
    UMINP  V11.4S, V1.4S, V1.4S
    FMAXNMV  S23, V11.4S
    UMINV  H1, V7.8H
    FMINV  S5, V0.4S
    FMINNMP H29, V21.2H
    SMINP  V31.2S, V27.2S, V5.2S
    FMAXNMV  S20, V31.4S
    FMAXP  V10.2D, V17.2D, V20.2D
    FMAXNMP S14, V12.2S
    UMAXP  V28.4H, V12.4H, V10.4H
    UMINV  S7, V29.4S
    FMAX  V16.4S, V7.4S, V4.4S
    UMAXP  V12.16B, V14.16B, V1.16B
    FMINV  H5, V30.4H
    FMINNM  V10.4S, V20.4S, V4.4S
    FMIN  V27.2D, V23.2D, V14.2D
    UMAXV  H4, V1.8H
    UMINV  H11, V5.8H
    FMAX  V8.4S, V6.4S, V10.4S
    FMINP S6, V10.2S
    UMAXP  V31.8H, V27.8H, V24.8H
    FMAXNMV  H29, V31.4H
    FMAXP H21, V9.2H
    FMAXNMP  V10.4S, V14.4S, V4.4S
    FMINNM  V13.8H, V23.8H, V4.8H
    FMINNM  V24.2S, V6.2S, V29.2S
    FMIN  V11.4S, V13.4S, V24.4S
    FMINP S23, V8.2S
    FMINNMP  V7.4H, V3.4H, V10.4H
    FMAXNMP  V6.4H, V21.4H, V21.4H
    UMINV  B20, V11.16B
    SMAXV  S31, V6.4S
    FMIN  V4.4H, V12.4H, V7.4H
    FMINP S3, V7.2S
    SMIN  V30.2S, V20.2S, V4.2S
    FMINNM  V10.8H, V25.8H, V27.8H
    SMINP  V6.8H, V10.8H, V4.8H
    FMINP D25, V3.2D
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_11
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X23, FPSR
    MOVZ  X20, #0x81, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D0
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D1
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D5
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D9
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D11
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D17
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D20
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D28
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D30
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X23, D31
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  V0.D[1], X23
    FMOV  D1, X22
    FMOV  V1.D[1], X29
    FMOV  D2, X18
    FMOV  V2.D[1], X13
    FMOV  D3, X21
    FMOV  V3.D[1], X8
    FMOV  D4, X21
    FMOV  V4.D[1], X5
    FMOV  D5, X11
    FMOV  V5.D[1], X13
    FMOV  D6, X13
    FMOV  V6.D[1], X18
    FMOV  D7, X6
    FMOV  V7.D[1], X4
    FMOV  D8, X4
    FMOV  V8.D[1], X14
    FMOV  D9, X4
    FMOV  V9.D[1], X10
    FMOV  D10, X12
    FMOV  V10.D[1], X29
    FMOV  D11, X21
    FMOV  V11.D[1], X22
    FMOV  D12, X16
    FMOV  V12.D[1], X5
    FMOV  D13, X8
    FMOV  V13.D[1], X13
    FMOV  D14, X23
    FMOV  V14.D[1], X10
    FMOV  D15, X10
    FMOV  V15.D[1], X21
    FMOV  D16, X22
    FMOV  V16.D[1], X15
    FMOV  D17, X11
    FMOV  V17.D[1], X15
    FMOV  D18, X4
    FMOV  V18.D[1], X20
    FMOV  D19, X2
    FMOV  V19.D[1], X8
    FMOV  D20, X14
    FMOV  V20.D[1], X17
    FMOV  D21, X3
    FMOV  V21.D[1], X21
    FMOV  D22, X21
    FMOV  V22.D[1], X17
    FMOV  D23, X19
    FMOV  V23.D[1], X23
    FMOV  D24, X13
    FMOV  V24.D[1], X14
    FMOV  D25, X2
    FMOV  V25.D[1], X15
    FMOV  D26, X15
    FMOV  V26.D[1], X7
    FMOV  D27, X20
    FMOV  V27.D[1], X29
    FMOV  D28, X19
    FMOV  V28.D[1], X23
    FMOV  D29, X7
    FMOV  V29.D[1], X16
    FMOV  D30, X16
    FMOV  V30.D[1], X3
    FMOV  D31, X23
    FMOV  V31.D[1], X16
    MOVZ  X12, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_12:
    FMAX  V26.2S, V28.2S, V27.2S
    SMINV  B20, V30.8B
    FMAXV  S31, V18.4S
    FMAXP H10, V26.2H
    SMINV  H13, V31.8H
    FMAXNMP D24, V10.2D
    FMINV  H7, V20.8H
    UMINP  V21.16B, V7.16B, V29.16B
    UMAXV  B28, V21.16B
    FMAXP D12, V11.2D
    FMAX  V5.4H, V28.4H, V13.4H
    FMAXP  V19.8H, V2.8H, V12.8H
    FMINNMP S7, V11.2S
    SMINV  B29, V19.16B
    FMINP  V2.4H, V22.4H, V7.4H
    FMAX  V30.2D, V29.2D, V11.2D
    FMAXNMP  V22.2S, V30.2S, V25.2S
    FMAXP  V31.4H, V22.4H, V2.4H
    FMAXNMP  V30.4H, V24.4H, V31.4H
    FMINNMV  S28, V30.4S
    FMINP D29, V5.2D
    FMINNMP D27, V18.2D
    FMINP H2, V5.2H
    SMINV  B23, V12.8B
    UMINV  B22, V28.16B
    UMAXV  S12, V12.4S
    FMINNM  V5.8H, V2.8H, V15.8H
    SMAXV  B18, V10.16B
    FMAXNMP  V2.4S, V12.4S, V10.4S
    FMINNMP H7, V17.2H
    FMAXNM  V17.4S, V6.4S, V7.4S
    FMAXV  H30, V11.8H
    FMINV  S19, V5.4S
    UMAX  V28.8B, V22.8B, V22.8B
    FMAXNMP H11, V18.2H
    FMINNMP D31, V2.2D
    FMIN  V12.4S, V23.4S, V17.4S
    UMINV  B22, V12.16B
    FMAXP D23, V31.2D
    SMAXP  V7.4H, V15.4H, V27.4H
    FMAXP S15, V22.2S
    UMIN  V24.8H, V7.8H, V7.8H
    FMINP D12, V24.2D
    FMINNM  V17.2D, V15.2D, V15.2D
    FMINP  V31.4S, V4.4S, V19.4S
    FMAXNMP S6, V21.2S
    SMIN  V27.4S, V12.4S, V12.4S
    UMAXV  S10, V28.4S
    SMAXP  V12.4H, V31.4H, V31.4H
    SMAXP  V3.4H, V27.4H, V27.4H
    FMINNMP S28, V23.2S
    UMINV  H24, V26.4H
    FMINNMV  H22, V24.4H
    SMAXV  S15, V10.4S
    UMAXV  S24, V25.4S
    FMAXP  V4.8H, V24.8H, V6.8H
    FMIN  V21.8H, V3.8H, V3.8H
    UMINV  H5, V17.4H
    FMAXP D10, V12.2D
    FMAXP  V12.4H, V19.4H, V21.4H
    UMAXV  H18, V28.8H
    SMINP  V2.4H, V30.4H, V30.4H
    FMINNMP  V24.2S, V24.2S, V1.2S
    FMINNMP  V25.4H, V4.4H, V5.4H
    FMINP D30, V10.2D
    FMAXP S6, V25.2S
    UMAXV  B5, V18.16B
    FMAXNMV  S1, V15.4S
    FMINNM  V7.8H, V1.8H, V1.8H
    UMINV  B1, V5.8B
    SMINV  B19, V6.8B
    FMINV  S30, V1.4S
    FMINV  H17, V7.4H
    SMAXV  H6, V2.8H
    FMINNMV  H4, V19.4H
    FMINP S12, V17.2S
    FMINNMP D28, V30.2D
    UMINV  B19, V17.16B
    SMINP  V7.2S, V6.2S, V4.2S
    FMINNMP S19, V22.2S
    FMINP  V2.2D, V24.2D, V21.2D
    FMINNMV  H18, V4.8H
    UMAX  V2.8H, V7.8H, V2.8H
    FMAX  V1.4H, V18.4H, V2.4H
    SMAXV  B7, V1.8B
    FMINV  H25, V27.8H
    FMINNMP H27, V25.2H
    SMINV  S1, V28.4S
    FMAXNM  V5.4H, V7.4H, V7.4H
    FMINP S13, V3.2S
    UMAXV  S7, V19.4S
    UMINV  S18, V13.4S
    UMAX  V12.2S, V5.2S, V1.2S
    FMINV  S25, V8.4S
    FMINP  V4.4H, V12.4H, V27.4H
    FMAXV  H2, V25.8H
    UMAXP  V8.2S, V25.2S, V10.2S
    FMINNMP H28, V8.2H
    FMAXNMP  V17.4H, V18.4H, V4.4H
    FMIN  V6.8H, V2.8H, V14.8H
    FMINP H25, V8.2H
    UMAXP  V15.8B, V1.8B, V8.8B
    FMINV  S8, V25.4S
    FMINV  S30, V6.4S
    UMAXV  H12, V7.4H
    FMAX  V2.4H, V12.4H, V24.4H
    SMINV  S22, V15.4S
    SMAXV  B1, V13.16B
    SMAXV  S24, V1.4S
    FMIN  V25.4H, V24.4H, V4.4H
    SMAXP  V15.4H, V30.4H, V22.4H
    SMAXV  S5, V25.4S
    FMINNMP  V30.8H, V11.8H, V13.8H
    FMAXNMP H21, V30.2H
    FMAXNMV  S4, V28.4S
    UMAXV  B28, V6.8B
    FMINNM  V21.4H, V4.4H, V15.4H
    FMAXP  V6.2S, V28.2S, V17.2S
    FMINP H19, V2.2H
    FMAXNMP S2, V31.2S
    FMAXNMP S23, V8.2S
    SMINV  S30, V19.4S
    FMINP S25, V2.2S
    FMAXNMP D17, V6.2D
    FMINP D10, V19.2D
    FMAX  V31.8H, V23.8H, V31.8H
    FMAXNM  V4.2S, V2.2S, V25.2S
    FMAXNMV  S1, V5.4S
    FMINP  V28.2S, V4.2S, V15.2S
    SMAXV  B23, V0.16B
    UMINV  S5, V22.4S
    FMINV  S4, V31.4S
    SMAXV  S13, V2.4S
    FMAXNMV  S6, V27.4S
    UMAXV  S24, V10.4S
    FMAXV  S10, V13.4S
    UMAXV  H11, V22.4H
    UMAX  V15.8H, V24.8H, V23.8H
    SMINV  B22, V4.16B
    FMINNMV  H19, V5.8H
    FMAXNMP  V0.4H, V28.4H, V15.4H
    FMINP S2, V17.2S
    FMAXP D28, V10.2D
    SMINV  B17, V19.8B
    FMINNM  V5.2D, V11.2D, V0.2D
    FMINP H24, V5.2H
    FMAXP S10, V18.2S
    UMAX  V15.8B, V17.8B, V2.8B
    FMINNM  V4.4S, V29.4S, V1.4S
    FMINV  H19, V10.4H
    FMINP S9, V28.2S
    FMINV  S5, V18.4S
    FMINP  V18.8H, V15.8H, V9.8H
    FMINP S25, V17.2S
    SMAXV  B21, V23.16B
    UMINV  S10, V25.4S
    FMAXNMV  H28, V21.4H
    FMINP  V27.4H, V15.4H, V5.4H
    FMAXNMP H9, V24.2H
    FMAXP S13, V28.2S
    FMAXNMP  V31.4S, V4.4S, V10.4S
    FMAXNMP H29, V19.2H
    FMINP S28, V27.2S
    SMAXV  S23, V28.4S
    FMAXV  H17, V23.8H
    FMINNMV  S5, V17.4S
    UMINP  V2.8B, V13.8B, V5.8B
    UMINP  V5.4H, V9.4H, V11.4H
    FMINV  S1, V25.4S
    FMAXP H25, V2.2H
    FMAX  V28.4H, V18.4H, V0.4H
    UMAX  V27.16B, V1.16B, V28.16B
    FMAXNMP S17, V6.2S
    FMIN  V26.4S, V5.4S, V24.4S
    FMAXNMP S30, V17.2S
    FMAXV  H1, V27.8H
    SMINV  H5, V0.8H
    FMAXNMP S21, V18.2S
    FMAXNM  V30.4S, V27.4S, V26.4S
    UMINP  V24.8B, V14.8B, V30.8B
    FMAXNMP S30, V1.2S
    FMINV  S2, V5.4S
    UMAXV  B0, V25.8B
    FMINNMP D25, V2.2D
    FMAXP  V11.2D, V0.2D, V30.2D
    SMAXP  V26.2S, V21.2S, V24.2S
    FMAXP D29, V11.2D
    FMAXP  V18.4S, V25.4S, V29.4S
    FMINNMP  V1.4H, V5.4H, V18.4H
    FMINNM  V5.2D, V5.2D, V1.2D
    FMINP D28, V26.2D
    UMINP  V27.16B, V28.16B, V25.16B
    SMINP  V1.4S, V27.4S, V5.4S
    FMAXNMV  S7, V17.4S
    FMAXNMP H15, V16.2H
    FMINP  V28.4H, V11.4H, V23.4H
    FMINNMP S25, V14.2S
    UMAXP  V18.4S, V18.4S, V12.4S
    UMINV  B29, V6.8B
    FMAXNM  V21.4H, V4.4H, V16.4H
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_12
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X17, FPSR
    MOVZ  X6, #0x81, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D1
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D14
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D15
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D16
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D24
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D25
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7fc0, LSL #16
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X17, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  V0.D[1], X22
    FMOV  D1, X21
    FMOV  V1.D[1], X17
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X6
    FMOV  V3.D[1], X22
    FMOV  D4, X13
    FMOV  V4.D[1], X15
    FMOV  D5, X12
    FMOV  V5.D[1], X3
    FMOV  D6, X29
    FMOV  V6.D[1], X7
    FMOV  D7, X23
    FMOV  V7.D[1], X20
    FMOV  D8, X2
    FMOV  V8.D[1], X12
    FMOV  D9, X19
    FMOV  V9.D[1], X10
    FMOV  D10, X17
    FMOV  V10.D[1], X9
    FMOV  D11, X21
    FMOV  V11.D[1], X13
    FMOV  D12, X10
    FMOV  V12.D[1], X8
    FMOV  D13, X20
    FMOV  V13.D[1], X10
    FMOV  D14, X23
    FMOV  V14.D[1], X29
    FMOV  D15, X10
    FMOV  V15.D[1], X18
    FMOV  D16, X18
    FMOV  V16.D[1], X17
    FMOV  D17, X20
    FMOV  V17.D[1], X16
    FMOV  D18, X6
    FMOV  V18.D[1], X10
    FMOV  D19, X11
    FMOV  V19.D[1], X3
    FMOV  D20, X13
    FMOV  V20.D[1], X16
    FMOV  D21, X9
    FMOV  V21.D[1], X8
    FMOV  D22, X7
    FMOV  V22.D[1], X5
    FMOV  D23, X6
    FMOV  V23.D[1], X14
    FMOV  D24, X11
    FMOV  V24.D[1], X9
    FMOV  D25, X12
    FMOV  V25.D[1], X12
    FMOV  D26, X3
    FMOV  V26.D[1], X12
    FMOV  D27, X5
    FMOV  V27.D[1], X19
    FMOV  D28, X29
    FMOV  V28.D[1], X12
    FMOV  D29, X14
    FMOV  V29.D[1], X21
    FMOV  D30, X6
    FMOV  V30.D[1], X15
    FMOV  D31, X2
    FMOV  V31.D[1], X29
    MOVZ  X8, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_13:
    UMAXP  V30.4S, V6.4S, V27.4S
    FMAXV  S23, V31.4S
    SMAX  V8.16B, V23.16B, V23.16B
    FMAXP  V10.4S, V18.4S, V28.4S
    FMINV  S0, V29.4S
    FMAXP H3, V25.2H
    SMINV  S17, V0.4S
    FMINNMV  H10, V2.4H
    FMAXV  S15, V5.4S
    SMAX  V27.8B, V26.8B, V24.8B
    FMAXNM  V22.2S, V30.2S, V17.2S
    FMAXNMP  V20.4S, V15.4S, V5.4S
    SMAXP  V18.8B, V20.8B, V22.8B
    FMINNM  V30.2S, V8.2S, V3.2S
    FMAX  V25.4S, V18.4S, V9.4S
    FMINNM  V31.2D, V30.2D, V30.2D
    FMAXP H2, V10.2H
    FMAXNMP  V26.4S, V26.4S, V25.4S
    SMAXV  H0, V31.4H
    UMAXV  S29, V27.4S
    FMAXV  H20, V26.8H
    FMINNM  V20.4H, V20.4H, V15.4H
    SMIN  V19.8H, V24.8H, V24.8H
    FMAXP H27, V29.2H
    FMINV  H5, V19.4H
    FMINNMP S28, V2.2S
    FMINNMP  V6.2D, V0.2D, V16.2D
    FMAXV  S8, V24.4S
    SMIN  V23.2S, V20.2S, V3.2S
    FMAXNMP H15, V23.2H
    FMIN  V0.2S, V28.2S, V25.2S
    UMINV  B23, V6.8B
    FMAXP D6, V0.2D
    FMAXV  H3, V6.8H
    FMINP H19, V5.2H
    FMAXP  V26.4S, V19.4S, V3.4S
    UMAXP  V2.4S, V23.4S, V15.4S
    SMINP  V17.4H, V27.4H, V27.4H
    UMINP  V27.8H, V8.8H, V2.8H
    FMAXNMP H19, V17.2H
    FMINV  H20, V15.4H
    FMAX  V16.2D, V30.2D, V14.2D
    SMAXP  V2.16B, V20.16B, V16.16B
    FMAXV  S25, V26.4S
    UMAXV  B23, V25.8B
    FMIN  V14.8H, V27.8H, V24.8H
    FMINNMV  H15, V2.8H
    FMAXP  V31.4S, V19.4S, V23.4S
    FMINNMP  V25.2S, V1.2S, V25.2S
    UMINV  H3, V0.4H
    FMAXV  H2, V31.4H
    SMINP  V23.8H, V15.8H, V14.8H
    FMINP H31, V0.2H
    UMAXP  V2.8B, V2.8B, V21.8B
    UMINV  H29, V3.8H
    FMAXP S14, V17.2S
    SMAXV  H31, V23.8H
    UMINV  H26, V29.4H
    FMINP H5, V21.2H
    FMAXNMP  V27.4H, V17.4H, V25.4H
    SMIN  V3.8H, V5.8H, V3.8H
    FMINP D29, V27.2D
    FMAXNM  V20.4S, V31.4S, V3.4S
    FMAXV  H25, V20.4H
    FMAXNM  V23.4H, V2.4H, V2.4H
    FMINNM  V15.8H, V27.8H, V25.8H
    SMAXP  V20.8H, V29.8H, V15.8H
    UMIN  V25.4S, V5.4S, V0.4S
    UMAX  V30.2S, V18.2S, V23.2S
    SMAXV  S23, V12.4S
    SMAXV  S5, V26.4S
    FMINNM  V25.4H, V27.4H, V20.4H
    FMINP D21, V20.2D
    FMAXNMP H15, V5.2H
    FMAXNM  V5.2S, V18.2S, V3.2S
    UMIN  V31.4H, V17.4H, V14.4H
    FMINP  V27.4S, V13.4S, V23.4S
    FMINP S0, V31.2S
    FMAXP  V5.4H, V8.4H, V28.4H
    FMAXNMP D26, V4.2D
    FMAXNMP  V24.8H, V15.8H, V13.8H
    SMINP  V18.2S, V25.2S, V15.2S
    UMINV  S23, V27.4S
    FMAXP  V20.2D, V5.2D, V5.2D
    FMAXNM  V28.4H, V18.4H, V11.4H
    FMAXP H18, V26.2H
    UMINV  S26, V22.4S
    FMAXP  V8.4S, V18.4S, V24.4S
    SMINV  H18, V30.4H
    FMINNMP  V24.2S, V21.2S, V16.2S
    FMAXP  V25.2S, V26.2S, V8.2S
    FMAXNMV  H22, V18.4H
    FMINNMP S16, V23.2S
    FMINP S3, V16.2S
    FMINNMP S30, V22.2S
    FMAXV  S27, V20.4S
    UMINP  V26.16B, V10.16B, V5.16B
    FMINNMP S13, V26.2S
    UMAXP  V26.4H, V24.4H, V20.4H
    UMAXV  H20, V3.4H
    FMAXNMP S21, V26.2S
    FMAXNMP D3, V13.2D
    SMAXP  V24.8H, V26.8H, V18.8H
    FMINNM  V16.8H, V8.8H, V5.8H
    FMINP S11, V2.2S
    FMAXP D10, V28.2D
    FMAXNM  V9.8H, V3.8H, V30.8H
    FMINNM  V10.2D, V24.2D, V11.2D
    UMINP  V3.4H, V16.4H, V25.4H
    FMINV  H22, V10.8H
    FMAX  V2.2S, V21.2S, V3.2S
    SMINP  V21.4H, V22.4H, V9.4H
    SMAXV  S10, V2.4S
    SMINV  S8, V21.4S
    UMINV  H11, V10.8H
    SMINP  V10.4S, V20.4S, V1.4S
    SMAXV  B30, V21.8B
    FMAXNMP D24, V26.2D
    UMAXV  H13, V8.8H
    UMINV  B2, V13.8B
    SMAXV  S18, V1.4S
    UMAXV  H5, V2.8H
    FMINP  V22.8H, V5.8H, V24.8H
    FMAXV  H17, V11.8H
    FMINP H10, V28.2H
    SMAXV  S9, V10.4S
    UMINV  B8, V11.16B
    FMINNM  V11.4H, V18.4H, V17.4H
    SMAXV  B20, V22.8B
    UMINV  H2, V8.8H
    FMAXP  V19.4S, V11.4S, V20.4S
    SMINV  B5, V5.16B
    FMINNM  V24.4H, V19.4H, V19.4H
    SMAXV  S16, V2.4S
    FMAXNM  V17.8H, V13.8H, V28.8H
    FMAX  V3.4H, V30.4H, V2.4H
    UMAXV  H21, V8.4H
    FMIN  V18.8H, V20.8H, V3.8H
    FMINNMP  V8.4H, V24.4H, V9.4H
    FMAXV  S19, V13.4S
    SMAXV  B26, V21.16B
    UMAX  V9.8B, V19.8B, V18.8B
    SMINV  B2, V25.8B
    FMINNMV  S11, V2.4S
    FMIN  V13.8H, V10.8H, V13.8H
    SMAX  V1.4S, V11.4S, V17.4S
    FMAXNMV  H25, V8.8H
    FMAXNMV  H30, V10.4H
    FMAX  V17.4H, V16.4H, V13.4H
    UMIN  V2.4S, V22.4S, V25.4S
    SMAXV  H10, V1.4H
    FMINV  S18, V17.4S
    SMINV  B28, V2.16B
    UMAX  V11.2S, V5.2S, V26.2S
    FMAXNMP H1, V10.2H
    FMINNM  V11.4S, V29.4S, V23.4S
    UMINV  S16, V9.4S
    FMAXP D10, V8.2D
    FMAXNM  V13.8H, V11.8H, V18.8H
    FMINNMP  V26.4S, V18.4S, V1.4S
    SMAX  V20.8B, V26.8B, V22.8B
    SMINV  B5, V28.16B
    FMINNM  V25.2D, V2.2D, V29.2D
    SMAXV  S9, V11.4S
    SMINV  B23, V9.16B
    UMAXV  H19, V20.4H
    FMAXP S26, V15.2S
    FMAXP S20, V25.2S
    FMAXV  S15, V26.4S
    SMIN  V17.16B, V13.16B, V19.16B
    UMAXV  H1, V17.4H
    FMAXP S13, V10.2S
    SMIN  V29.4H, V16.4H, V15.4H
    FMAXP  V2.2S, V1.2S, V30.2S
    FMINNMP H8, V20.2H
    FMAXP  V9.2S, V8.2S, V2.2S
    FMINNMP D8, V23.2D
    FMAXNMP  V17.8H, V14.8H, V24.8H
    FMAXP D28, V29.2D
    UMINV  B14, V24.16B
    FMAXNMP S10, V27.2S
    FMINNMP  V19.4H, V8.4H, V22.4H
    UMIN  V22.2S, V17.2S, V17.2S
    FMAXNMP  V29.2S, V28.2S, V28.2S
    UMIN  V27.8B, V19.8B, V10.8B
    FMINP S5, V0.2S
    FMINV  S23, V9.4S
    FMAXNM  V1.4S, V27.4S, V14.4S
    FMINNM  V0.4S, V5.4S, V1.4S
    FMAXNMP D27, V13.2D
    UMAXV  H15, V22.8H
    FMINNM  V20.4S, V23.4S, V29.4S
    FMAXP  V24.8H, V27.8H, V15.8H
    SMAXP  V28.8H, V30.8H, V9.8H
    FMINNMP  V30.4H, V6.4H, V20.4H
    FMAXNMV  H9, V30.4H
    FMAXNMP  V21.2S, V28.2S, V24.2S
    FMAXNMP  V4.2D, V20.2D, V21.2D
    FMAX  V28.8H, V4.8H, V4.8H
    FMINV  H19, V28.8H
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_13
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X10, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X22, FPSR
    MOVZ  X10, #0x81, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X22, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorMaxMin_TestFail
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
    FMOV  V0.D[1], X13
    FMOV  D1, X16
    FMOV  V1.D[1], X15
    FMOV  D2, X21
    FMOV  V2.D[1], X22
    FMOV  D3, X2
    FMOV  V3.D[1], X18
    FMOV  D4, X7
    FMOV  V4.D[1], X12
    FMOV  D5, X17
    FMOV  V5.D[1], X21
    FMOV  D6, X18
    FMOV  V6.D[1], X29
    FMOV  D7, X5
    FMOV  V7.D[1], X4
    FMOV  D8, X8
    FMOV  V8.D[1], X16
    FMOV  D9, X13
    FMOV  V9.D[1], X10
    FMOV  D10, X19
    FMOV  V10.D[1], X18
    FMOV  D11, X7
    FMOV  V11.D[1], X9
    FMOV  D12, X29
    FMOV  V12.D[1], X5
    FMOV  D13, X7
    FMOV  V13.D[1], X2
    FMOV  D14, X14
    FMOV  V14.D[1], X3
    FMOV  D15, X15
    FMOV  V15.D[1], X2
    FMOV  D16, X12
    FMOV  V16.D[1], X13
    FMOV  D17, X11
    FMOV  V17.D[1], X3
    FMOV  D18, X29
    FMOV  V18.D[1], X10
    FMOV  D19, X13
    FMOV  V19.D[1], X3
    FMOV  D20, X3
    FMOV  V20.D[1], X16
    FMOV  D21, X29
    FMOV  V21.D[1], X13
    FMOV  D22, X19
    FMOV  V22.D[1], X11
    FMOV  D23, X2
    FMOV  V23.D[1], X2
    FMOV  D24, X14
    FMOV  V24.D[1], X4
    FMOV  D25, X2
    FMOV  V25.D[1], X29
    FMOV  D26, X16
    FMOV  V26.D[1], X16
    FMOV  D27, X3
    FMOV  V27.D[1], X15
    FMOV  D28, X17
    FMOV  V28.D[1], X10
    FMOV  D29, X20
    FMOV  V29.D[1], X8
    FMOV  D30, X4
    FMOV  V30.D[1], X16
    FMOV  D31, X14
    FMOV  V31.D[1], X20
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorMaxMin_label_14:
    FMINP D21, V29.2D
    FMINNMP  V0.8H, V26.8H, V21.8H
    UMAXV  H3, V25.4H
    FMAXNM  V26.2S, V3.2S, V3.2S
    FMINNMP S29, V0.2S
    FMAXP D4, V28.2D
    FMINP S3, V23.2S
    UMINV  B2, V20.16B
    SMINV  H9, V3.8H
    FMAXV  H19, V2.8H
    FMIN  V25.4H, V30.4H, V11.4H
    FMAXNMP H12, V19.2H
    FMINP D21, V26.2D
    SMAXP  V5.4S, V27.4S, V0.4S
    FMINNMP S22, V29.2S
    FMAXNMV  S15, V5.4S
    SMINV  S27, V3.4S
    FMIN  V18.2D, V25.2D, V13.2D
    SMAX  V27.8H, V15.8H, V9.8H
    SMINP  V2.16B, V18.16B, V27.16B
    FMINP H3, V21.2H
    FMINNMP  V25.2S, V21.2S, V3.2S
    FMINNM  V26.4S, V12.4S, V12.4S
    FMAXNMP H21, V26.2H
    SMAXV  S30, V21.4S
    UMINV  H15, V22.4H
    UMAX  V19.2S, V16.2S, V30.2S
    FMINNMP  V30.8H, V10.8H, V2.8H
    FMAX  V22.2S, V7.2S, V19.2S
    FMAXNMP  V0.4H, V22.4H, V2.4H
    SMAXP  V26.4H, V20.4H, V9.4H
    FMINNMP  V18.4H, V3.4H, V26.4H
    FMINNMP D12, V25.2D
    FMAXNMP H20, V30.2H
    SMAXV  H3, V18.8H
    FMAXV  H7, V4.8H
    UMAXV  B9, V2.16B
    UMAX  V22.8B, V16.8B, V10.8B
    FMAXP  V10.8H, V20.8H, V25.8H
    FMAXP D19, V13.2D
    UMINV  S18, V12.4S
    FMINNMP D21, V9.2D
    SMINV  B9, V0.8B
    FMIN  V19.8H, V22.8H, V20.8H
    FMAXP D30, V21.2D
    FMINNMP  V17.2D, V7.2D, V7.2D
    FMAXP  V13.4S, V9.4S, V7.4S
    FMINNMP H22, V23.2H
    FMINV  H20, V3.4H
    FMINNMP  V25.4S, V18.4S, V18.4S
    UMIN  V18.8B, V30.8B, V22.8B
    SMAX  V2.8B, V19.8B, V31.8B
    UMINV  H23, V15.8H
    SMAXP  V26.8H, V23.8H, V13.8H
    FMAXP  V7.2S, V10.2S, V20.2S
    FMAXNMP S12, V12.2S
    UMAXV  B4, V26.16B
    FMINP  V10.8H, V17.8H, V12.8H
    FMAXNM  V22.2D, V20.2D, V10.2D
    FMAXNMP  V17.4S, V2.4S, V7.4S
    FMAXNMP D15, V4.2D
    FMINP S23, V10.2S
    FMAXV  S4, V2.4S
    FMAXNMP D13, V4.2D
    FMAXNMP D21, V18.2D
    FMINNMP  V2.8H, V17.8H, V26.8H
    FMINNMP H19, V2.2H
    UMAXP  V7.2S, V21.2S, V25.2S
    SMAX  V30.4S, V30.4S, V13.4S
    UMINV  H2, V19.4H
    UMAXP  V1.4H, V27.4H, V28.4H
    SMINP  V13.2S, V15.2S, V22.2S
    FMAXNM  V18.4S, V29.4S, V2.4S
    FMINNM  V31.2S, V25.2S, V14.2S
    FMAXNM  V10.8H, V1.8H, V30.8H
    FMAXNMP  V8.4S, V20.4S, V1.4S
    FMAXNMP D17, V18.2D
    FMINNMP  V2.4H, V23.4H, V13.4H
    FMINV  S4, V8.4S
    FMAXP S22, V0.2S
    FMAXNMP D12, V2.2D
    UMAXP  V26.2S, V22.2S, V10.2S
    SMAX  V21.2S, V13.2S, V7.2S
    SMAX  V25.16B, V12.16B, V30.16B
    FMINP S28, V19.2S
    FMAXNMP  V4.4H, V31.4H, V7.4H
    FMINNMP S16, V6.2S
    UMAX  V19.4S, V25.4S, V17.4S
    UMAXV  H27, V0.8H
    SMINP  V25.8H, V4.8H, V16.8H
    SMINV  S11, V25.4S
    FMINNMP D0, V12.2D
    FMAXP D6, V1.2D
    FMINP  V12.4H, V6.4H, V9.4H
    FMAXP  V6.8H, V28.8H, V26.8H
    FMINNM  V31.4S, V31.4S, V11.4S
    FMAXNM  V26.2S, V24.2S, V28.2S
    FMAXNM  V7.4H, V5.4H, V21.4H
    FMINNMP  V16.4H, V2.4H, V19.4H
    UMINV  H5, V1.8H
    FMINP S9, V29.2S
    FMAXNMV  S19, V21.4S
    FMAXP S24, V27.2S
    SMIN  V26.2S, V6.2S, V31.2S
    UMAXV  B28, V9.16B
    FMINP H17, V16.2H
    FMAXNMV  S16, V19.4S
    FMINV  S9, V20.4S
    SMAXV  H27, V16.4H
    UMINV  S16, V5.4S
    SMIN  V5.4H, V28.4H, V2.4H
    UMAXP  V1.4S, V21.4S, V25.4S
    UMAX  V2.16B, V11.16B, V24.16B
    UMINV  S20, V5.4S
    FMAXNMP H21, V2.2H
    UMINV  S9, V0.4S
    SMIN  V0.16B, V3.16B, V3.16B
    FMAXNMP S4, V12.2S
    UMIN  V24.4S, V26.4S, V16.4S
    FMINNMP  V25.4H, V24.4H, V28.4H
    FMINNM  V14.4S, V23.4S, V17.4S
    UMAXV  H11, V23.8H
    FMIN  V9.2D, V25.2D, V12.2D
    UMAXV  B0, V20.16B
    FMAXNMP  V17.2S, V27.2S, V1.2S
    SMAX  V31.8H, V10.8H, V11.8H
    FMAXNMP D20, V19.2D
    FMINNMV  S25, V4.4S
    FMINP  V28.4S, V25.4S, V9.4S
    FMINV  H4, V22.4H
    FMAXNMP  V26.2S, V12.2S, V21.2S
    FMINNMP S20, V30.2S
    UMINV  S7, V20.4S
    FMAXNMP H1, V6.2H
    SMINV  H23, V17.8H
    UMAXP  V21.4S, V14.4S, V4.4S
    FMINP S15, V23.2S
    FMAXV  S13, V15.4S
    FMINP  V17.4H, V14.4H, V27.4H
    UMINP  V9.8B, V26.8B, V28.8B
    UMIN  V10.4S, V13.4S, V23.4S
    FMAXNM  V14.8H, V17.8H, V21.8H
    FMINNMP S15, V0.2S
    FMINNMP  V27.8H, V15.8H, V31.8H
    FMAXNM  V21.8H, V27.8H, V10.8H
    FMIN  V26.4S, V19.4S, V18.4S
    SMAXV  B11, V26.16B
    FMAXNMV  H16, V7.8H
    FMAXP  V9.8H, V5.8H, V29.8H
    FMINNM  V5.2S, V14.2S, V15.2S
    FMIN  V31.8H, V15.8H, V0.8H
    FMINP S7, V8.2S
    FMAXNMV  H17, V15.8H
    FMINNMP  V4.4H, V11.4H, V11.4H
    FMAXNM  V29.8H, V31.8H, V7.8H
    SMIN  V27.8B, V30.8B, V27.8B
    FMINP D11, V29.2D
    UMINV  B7, V11.8B
    SMAXV  B15, V4.8B
    FMINP H5, V18.2H
    FMAXV  S19, V7.4S
    UMINP  V18.4H, V4.4H, V15.4H
    SMINP  V10.8H, V17.8H, V18.8H
    UMAXV  S18, V5.4S
    FMAXP  V4.4H, V18.4H, V4.4H
    UMINP  V14.8B, V19.8B, V27.8B
    SMINV  H16, V16.4H
    FMAXP  V18.4H, V16.4H, V7.4H
    UMAXV  S5, V14.4S
    UMINV  B16, V15.16B
    FMINNMV  H31, V8.4H
    FMAXNMP S21, V31.2S
    FMINP S15, V5.2S
    FMAXV  H24, V29.8H
    FMINNMP  V1.4S, V4.4S, V5.4S
    FMIN  V4.4H, V18.4H, V10.4H
    FMAXNMV  H3, V1.8H
    FMAXP  V18.2S, V29.2S, V15.2S
    FMAXNMP S1, V5.2S
    FMAX  V29.4H, V18.4H, V3.4H
    SMINP  V19.2S, V21.2S, V1.2S
    FMINV  H3, V16.4H
    FMAXV  S24, V29.4S
    FMAXNMP H18, V15.2H
    FMINNMP  V27.4H, V19.4H, V2.4H
    FMAXNM  V13.2S, V19.2S, V24.2S
    FMAXNM  V10.4S, V18.4S, V8.4S
    SMAXP  V5.8B, V24.8B, V10.8B
    UMAX  V17.8B, V0.8B, V4.8B
    SMINV  B16, V5.16B
    UMAX  V14.8B, V16.8B, V27.8B
    FMINNMP D31, V3.2D
    FMAXNMP S0, V26.2S
    FMINNM  V3.2D, V17.2D, V3.2D
    FMAXP S16, V13.2S
    FMAXNMP S17, V6.2S
    UMAXV  H5, V1.8H
    FMAXP D12, V0.2D
    FMINNMP  V23.4H, V22.4H, V28.4H
    SMAXP  V26.4S, V31.4S, V14.4S
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorMaxMin_label_14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X18, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorMaxMin_TestFail
    MRS  X12, FPSR
    MOVZ  X18, #0x81, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D0
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D1
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D5
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D18
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D30
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail
    FMOV  X12, D31
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorMaxMin_TestFail

TSRTAdvsimdVectorMaxMin_TestEnd:
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
TSRTAdvsimdVectorMaxMin_TestFail:
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
