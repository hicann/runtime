.global TSRTAdvsimdScalarFloatPointConvertToInteger

.text
.p2align 4

TSRTAdvsimdScalarFloatPointConvertToInteger:

TSRTAdvsimdScalarFloatPointConvertToInteger_TestBegin:
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
    MOVZ  X2, #0x4a93, LSL #0
    MOVK  X2, #0x40e5, LSL #16
    MOVK  X2, #0x6f32, LSL #32
    MOVK  X2, #0x6059, LSL #48
    MOVZ  X3, #0x2074, LSL #0
    MOVK  X3, #0xedd4, LSL #16
    MOVK  X3, #0x48ec, LSL #32
    MOVK  X3, #0x42c1, LSL #48
    MOVZ  X4, #0x61d6, LSL #0
    MOVK  X4, #0x14ca, LSL #16
    MOVK  X4, #0x378c, LSL #32
    MOVK  X4, #0xd142, LSL #48
    MOVZ  X5, #0xb5, LSL #0
    MOVK  X5, #0xffcc, LSL #16
    MOVK  X5, #0x72dd, LSL #32
    MOVK  X5, #0x2a01, LSL #48
    MOVZ  X6, #0xc7ad, LSL #0
    MOVK  X6, #0xff8d, LSL #16
    MOVK  X6, #0x100d, LSL #32
    MOVK  X6, #0x3631, LSL #48
    MOVZ  X7, #0x1c73, LSL #0
    MOVK  X7, #0x8018, LSL #16
    MOVK  X7, #0x3da1, LSL #32
    MOVK  X7, #0x97cc, LSL #48
    MOVZ  X8, #0xaba9, LSL #0
    MOVK  X8, #0xf172, LSL #16
    MOVK  X8, #0x46f8, LSL #32
    MOVK  X8, #0x98e2, LSL #48
    MOVZ  X9, #0x6d1b, LSL #0
    MOVK  X9, #0x4e3c, LSL #16
    MOVK  X9, #0xceb7, LSL #32
    MOVK  X9, #0x5cf1, LSL #48
    MOVZ  X10, #0xde2a, LSL #0
    MOVK  X10, #0xa716, LSL #16
    MOVK  X10, #0x4035, LSL #32
    MOVK  X10, #0x2262, LSL #48
    MOVZ  X11, #0xcb09, LSL #0
    MOVK  X11, #0xa122, LSL #16
    MOVK  X11, #0xf015, LSL #32
    MOVK  X11, #0x10a1, LSL #48
    MOVZ  X12, #0x7b97, LSL #0
    MOVK  X12, #0xebf0, LSL #16
    MOVK  X12, #0x6d74, LSL #32
    MOVK  X12, #0x157e, LSL #48
    MOVZ  X13, #0x5414, LSL #0
    MOVK  X13, #0xf45e, LSL #16
    MOVK  X13, #0xfd2, LSL #32
    MOVK  X13, #0x7a24, LSL #48
    MOVZ  X14, #0xc172, LSL #0
    MOVK  X14, #0xc4ed, LSL #16
    MOVK  X14, #0xb009, LSL #32
    MOVK  X14, #0x9d57, LSL #48
    MOVZ  X15, #0x5cbc, LSL #0
    MOVK  X15, #0x550c, LSL #16
    MOVK  X15, #0x4c61, LSL #32
    MOVK  X15, #0x66c, LSL #48
    MOVZ  X16, #0xaddf, LSL #0
    MOVK  X16, #0x261d, LSL #16
    MOVK  X16, #0x4460, LSL #32
    MOVK  X16, #0x5de1, LSL #48
    MOVZ  X17, #0xab7b, LSL #0
    MOVK  X17, #0x9862, LSL #16
    MOVK  X17, #0x166d, LSL #32
    MOVK  X17, #0x5507, LSL #48
    MOVZ  X18, #0x2620, LSL #0
    MOVK  X18, #0x6e2b, LSL #16
    MOVK  X18, #0xa418, LSL #32
    MOVK  X18, #0xc86, LSL #48
    MOVZ  X19, #0x9991, LSL #0
    MOVK  X19, #0xb72d, LSL #16
    MOVK  X19, #0x3793, LSL #32
    MOVK  X19, #0x1b1c, LSL #48
    MOVZ  X20, #0xa275, LSL #0
    MOVK  X20, #0xfff4, LSL #16
    MOVK  X20, #0x1a25, LSL #32
    MOVK  X20, #0xf5da, LSL #48
    MOVZ  X21, #0x31cc, LSL #0
    MOVK  X21, #0x3df, LSL #16
    MOVK  X21, #0xaa9d, LSL #32
    MOVK  X21, #0x1905, LSL #48
    MOVZ  X22, #0xa9d6, LSL #0
    MOVK  X22, #0xc879, LSL #16
    MOVK  X22, #0x4c0a, LSL #32
    MOVK  X22, #0x5b1c, LSL #48
    MOVZ  X23, #0xdb32, LSL #0
    MOVK  X23, #0xaac9, LSL #16
    MOVK  X23, #0x7fe0, LSL #32
    MOVK  X23, #0xaf7c, LSL #48
    MOVZ  X29, #0x5dbf, LSL #0
    MOVK  X29, #0xc458, LSL #16
    MOVK  X29, #0xe157, LSL #32
    MOVK  X29, #0xa972, LSL #48
    MOVZ  X11, #0xb7e8, LSL #0
    MOVK  X11, #0x9cad, LSL #16
    MOVK  X11, #0x9a7c, LSL #32
    MOVK  X11, #0xd0db, LSL #48
    MSR  FPCR, X11
    MRS  X22, FPCR
    MOVZ  X15, #0x60ff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    AND  X22, X22, X15
    MOVZ  X15, #0x0, LSL #0
    ORR  X22, X22, X15
    MSR  FPCR, X22
    ISB  SY
    MOVZ  X11, #0x518e, LSL #0
    MOVK  X11, #0x549, LSL #16
    MOVK  X11, #0x6f58, LSL #32
    MOVK  X11, #0x4a75, LSL #48
    MSR  FPSR, X11
    MRS  X10, FPSR
    MOVZ  X2, #0xff60, LSL #0
    MOVK  X2, #0x7ff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X10, X10, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X10, X10, X2
    MSR  FPSR, X10
    ISB  SY
    SUBS  W11, W7, W22, LSR #25
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x94ab, LSL #0
    MOVK  X2, #0x8bed, LSL #16
    MOVK  X2, #0x806e, LSL #32
    MOVK  X2, #0x6a71, LSL #48
    MOVZ  X3, #0x44ea, LSL #0
    MOVK  X3, #0x45a0, LSL #16
    MOVK  X3, #0xe08a, LSL #32
    MOVK  X3, #0xcfd9, LSL #48
    MOVZ  X4, #0xdd01, LSL #0
    MOVK  X4, #0x3cde, LSL #16
    MOVK  X4, #0x6a5e, LSL #32
    MOVK  X4, #0x3611, LSL #48
    MOVZ  X5, #0x9459, LSL #0
    MOVK  X5, #0x4be8, LSL #16
    MOVK  X5, #0x8807, LSL #32
    MOVK  X5, #0x11ba, LSL #48
    MOVZ  X6, #0x8048, LSL #0
    MOVK  X6, #0x5486, LSL #16
    MOVK  X6, #0x62, LSL #32
    MOVK  X6, #0x507b, LSL #48
    MOVZ  X7, #0x5f15, LSL #0
    MOVK  X7, #0xad69, LSL #16
    MOVK  X7, #0x4abd, LSL #32
    MOVK  X7, #0x6520, LSL #48
    MOVZ  X8, #0xec88, LSL #0
    MOVK  X8, #0xfbc, LSL #16
    MOVK  X8, #0x5805, LSL #32
    MOVK  X8, #0xd781, LSL #48
    MOVZ  X9, #0xd6cb, LSL #0
    MOVK  X9, #0x2b2e, LSL #16
    MOVK  X9, #0xcc25, LSL #32
    MOVK  X9, #0xf304, LSL #48
    MOVZ  X10, #0x5096, LSL #0
    MOVK  X10, #0x12d7, LSL #16
    MOVK  X10, #0xce6b, LSL #32
    MOVK  X10, #0xf935, LSL #48
    MOVZ  X11, #0x2340, LSL #0
    MOVK  X11, #0x79e6, LSL #16
    MOVK  X11, #0xb9f3, LSL #32
    MOVK  X11, #0x9f72, LSL #48
    MOVZ  X12, #0xe57e, LSL #0
    MOVK  X12, #0xb52c, LSL #16
    MOVK  X12, #0x2117, LSL #32
    MOVK  X12, #0xb6e3, LSL #48
    MOVZ  X13, #0x84c0, LSL #0
    MOVK  X13, #0xbfa8, LSL #16
    MOVK  X13, #0xde34, LSL #32
    MOVK  X13, #0x307f, LSL #48
    MOVZ  X14, #0xa94, LSL #0
    MOVK  X14, #0x66e4, LSL #16
    MOVK  X14, #0x6aab, LSL #32
    MOVK  X14, #0x671e, LSL #48
    MOVZ  X15, #0xcccd, LSL #0
    MOVK  X15, #0x4d8, LSL #16
    MOVK  X15, #0xf1aa, LSL #32
    MOVK  X15, #0xda72, LSL #48
    MOVZ  X16, #0x9865, LSL #0
    MOVK  X16, #0x41db, LSL #16
    MOVK  X16, #0xba36, LSL #32
    MOVK  X16, #0xedc2, LSL #48
    MOVZ  X17, #0xf6f1, LSL #0
    MOVK  X17, #0xbdde, LSL #16
    MOVK  X17, #0x2cab, LSL #32
    MOVK  X17, #0x8c87, LSL #48
    MOVZ  X18, #0x172d, LSL #0
    MOVK  X18, #0xf5b5, LSL #16
    MOVK  X18, #0x1dc3, LSL #32
    MOVK  X18, #0x319d, LSL #48
    MOVZ  X19, #0xb7a4, LSL #0
    MOVK  X19, #0x62fd, LSL #16
    MOVK  X19, #0xfe63, LSL #32
    MOVK  X19, #0x442f, LSL #48
    MOVZ  X20, #0xaa8d, LSL #0
    MOVK  X20, #0x2bf7, LSL #16
    MOVK  X20, #0x30c5, LSL #32
    MOVK  X20, #0x7f7b, LSL #48
    MOVZ  X21, #0x2f1f, LSL #0
    MOVK  X21, #0xf52a, LSL #16
    MOVK  X21, #0x896e, LSL #32
    MOVK  X21, #0xf3af, LSL #48
    MOVZ  X22, #0x7bd2, LSL #0
    MOVK  X22, #0x73b0, LSL #16
    MOVK  X22, #0x3515, LSL #32
    MOVK  X22, #0x42c2, LSL #48
    MOVZ  X23, #0x61e3, LSL #0
    MOVK  X23, #0xf252, LSL #16
    MOVK  X23, #0xf1, LSL #32
    MOVK  X23, #0x7e0f, LSL #48
    MOVZ  X29, #0x6c2d, LSL #0
    MOVK  X29, #0xf2a3, LSL #16
    MOVK  X29, #0x88e5, LSL #32
    MOVK  X29, #0x9ff, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X20
    FMOV  D1, X29
    FMOV  V1.D[1], X3
    FMOV  D2, X23
    FMOV  V2.D[1], X21
    FMOV  D3, X6
    FMOV  V3.D[1], X7
    FMOV  D4, X18
    FMOV  V4.D[1], X2
    FMOV  D5, X10
    FMOV  V5.D[1], X3
    FMOV  D6, X19
    FMOV  V6.D[1], X6
    FMOV  D7, X23
    FMOV  V7.D[1], X4
    FMOV  D8, X2
    FMOV  V8.D[1], X18
    FMOV  D9, X16
    FMOV  V9.D[1], X14
    FMOV  D10, X15
    FMOV  V10.D[1], X18
    FMOV  D11, X29
    FMOV  V11.D[1], X7
    FMOV  D12, X11
    FMOV  V12.D[1], X18
    FMOV  D13, X10
    FMOV  V13.D[1], X6
    FMOV  D14, X16
    FMOV  V14.D[1], X23
    FMOV  D15, X17
    FMOV  V15.D[1], X6
    FMOV  D16, X2
    FMOV  V16.D[1], X21
    FMOV  D17, X11
    FMOV  V17.D[1], X23
    FMOV  D18, X8
    FMOV  V18.D[1], X4
    FMOV  D19, X13
    FMOV  V19.D[1], X19
    FMOV  D20, X22
    FMOV  V20.D[1], X10
    FMOV  D21, X22
    FMOV  V21.D[1], X6
    FMOV  D22, X13
    FMOV  V22.D[1], X4
    FMOV  D23, X4
    FMOV  V23.D[1], X12
    FMOV  D24, X20
    FMOV  V24.D[1], X7
    FMOV  D25, X21
    FMOV  V25.D[1], X7
    FMOV  D26, X17
    FMOV  V26.D[1], X22
    FMOV  D27, X10
    FMOV  V27.D[1], X11
    FMOV  D28, X15
    FMOV  V28.D[1], X9
    FMOV  D29, X9
    FMOV  V29.D[1], X4
    FMOV  D30, X17
    FMOV  V30.D[1], X23
    FMOV  D31, X10
    FMOV  V31.D[1], X3
    FCVTAS  D9, D2
    FCVTAS  D17, D28
    FCVTAS  D31, D24
    FCVTAS  D23, D12
    FCVTAS  D4, D17
    FCVTAS  D1, D29
    FCVTAS  D16, D13
    FCVTAS  D13, D1
    FCVTAS  D23, D13
    FCVTAS  D22, D22
    FCVTAS  S26, S27
    FCVTAS  S26, S15
    FCVTAS  S8, S23
    FCVTAS  S7, S5
    FCVTAS  S31, S31
    FCVTAS  S4, S7
    FCVTAS  S17, S22
    FCVTAS  S26, S26
    FCVTAS  S7, S4
    FCVTAS  S20, S31
    FCVTAU  D2, D16
    FCVTAU  D4, D8
    FCVTAU  D5, D2
    FCVTAU  D15, D17
    FCVTAU  D24, D30
    FCVTAU  D23, D9
    FCVTAU  D16, D26
    FCVTAU  D30, D16
    FCVTAU  D27, D22
    FCVTAU  D13, D22
    FCVTAU  S15, S5
    FCVTAU  S2, S15
    FCVTAU  S8, S24
    FCVTAU  S19, S8
    FCVTAU  S24, S7
    FCVTAU  S9, S23
    FCVTAU  S7, S18
    FCVTAU  S22, S30
    FCVTAU  S16, S4
    FCVTAU  S15, S16
    FCVTMS  D4, D20
    FCVTMS  D14, D15
    FCVTMS  D18, D14
    FCVTMS  D24, D13
    FCVTMS  D1, D27
    FCVTMS  D14, D24
    FCVTMS  D23, D14
    FCVTMS  D15, D4
    FCVTMS  D16, D30
    FCVTMS  D13, D21
    FCVTMS  S30, S15
    FCVTMS  S4, S16
    FCVTMS  S24, S9
    FCVTMS  S5, S4
    FCVTMS  S14, S2
    FCVTMS  S30, S5
    FCVTMS  S10, S24
    FCVTMS  S29, S13
    FCVTMS  S4, S17
    FCVTMS  S20, S21
    FCVTMU  D15, D4
    FCVTMU  D13, D10
    FCVTMU  D27, D15
    FCVTMU  D7, D8
    FCVTMU  D24, D8
    FCVTMU  D4, D7
    FCVTMU  D16, D29
    FCVTMU  D10, D14
    FCVTMU  D29, D1
    FCVTMU  D6, D10
    FCVTMU  S8, S13
    FCVTMU  S5, S4
    FCVTMU  S4, S5
    FCVTMU  S10, S6
    FCVTMU  S17, S4
    FCVTMU  S19, S23
    FCVTMU  S13, S27
    FCVTMU  S27, S25
    FCVTMU  S14, S27
    FCVTMU  S27, S28
    FCVTNS  D25, D25
    FCVTNS  D6, D25
    FCVTNS  D12, D17
    FCVTNS  D23, D6
    FCVTNS  D6, D14
    FCVTNS  D25, D23
    FCVTNS  D14, D19
    FCVTNS  D28, D19
    FCVTNS  D25, D10
    FCVTNS  D27, D25
    FCVTNS  S25, S28
    FCVTNS  S4, S12
    FCVTNS  S19, S13
    FCVTNS  S11, S6
    FCVTNS  S7, S26
    FCVTNS  S28, S14
    FCVTNS  S12, S11
    FCVTNS  S16, S24
    FCVTNS  S14, S25
    FCVTNS  S25, S19
    FCVTNU  D24, D25
    FCVTNU  D9, D14
    FCVTNU  D23, D22
    FCVTNU  D18, D17
    FCVTNU  D7, D27
    FCVTNU  D25, D7
    FCVTNU  D22, D28
    FCVTNU  D6, D11
    FCVTNU  D12, D4
    FCVTNU  D17, D12
    FCVTNU  S14, S13
    FCVTNU  S12, S12
    FCVTNU  S9, S24
    FCVTNU  S26, S6
    FCVTNU  S27, S26
    FCVTNU  S11, S16
    FCVTNU  S19, S18
    FCVTNU  S8, S17
    FCVTNU  S18, S21
    FCVTNU  S13, S19
    FCVTPS  D28, D12
    FCVTPS  D12, D22
    FCVTPS  D24, D14
    FCVTPS  D14, D20
    FCVTPS  D16, D25
    FCVTPS  D26, D18
    FCVTPS  D4, D14
    FCVTPS  D7, D24
    FCVTPS  D17, D12
    FCVTPS  D24, D17
    FCVTPS  S21, S1
    FCVTPS  S22, S16
    FCVTPS  S25, S15
    FCVTPS  S14, S26
    FCVTPS  S18, S14
    FCVTPS  S15, S28
    FCVTPS  S26, S6
    FCVTPS  S17, S2
    FCVTPS  S12, S25
    FCVTPS  S31, S26
    FCVTPU  D22, D28
    FCVTPU  D28, D24
    FCVTPU  D1, D22
    FCVTPU  D26, D17
    FCVTPU  D24, D1
    FCVTPU  D14, D5
    FCVTPU  D6, D18
    FCVTPU  D20, D28
    FCVTPU  D12, D7
    FCVTPU  D17, D20
    FCVTPU  S5, S15
    FCVTPU  S1, S31
    FCVTPU  S22, S17
    FCVTPU  S25, S10
    FCVTPU  S2, S13
    FCVTPU  S11, S12
    FCVTPU  S28, S14
    FCVTPU  S20, S22
    FCVTPU  S22, S28
    FCVTPU  S17, S11
    FCVTXN  S12, D8
    FCVTXN  S31, D6
    FCVTXN  S3, D30
    FCVTXN  S30, D2
    FCVTXN  S11, D5
    FCVTXN  S14, D30
    FCVTXN  S28, D14
    FCVTXN  S6, D25
    FCVTXN  S12, D28
    FCVTXN  S8, D11
    FCVTZS D2, D3, #45
    FCVTZS D28, D12, #37
    FCVTZS D27, D28, #31
    FCVTZS D14, D24, #45
    FCVTZS D7, D17, #29
    FCVTZS D24, D24, #35
    FCVTZS D24, D21, #58
    FCVTZS D21, D27, #60
    FCVTZS D13, D6, #20
    FCVTZS D27, D13, #55
    FCVTZS S12, S7, #12
    FCVTZS S25, S31, #10
    FCVTZS S7, S24, #5
    FCVTZS S24, S14, #31
    FCVTZS S30, S21, #32
    FCVTZS S13, S30, #6
    FCVTZS S28, S14, #23
    FCVTZS S5, S27, #24
    FCVTZS S17, S5, #32
    FCVTZS S21, S13, #2
    FCVTZS  D1, D21
    FCVTZS  D6, D17
    FCVTZS  D14, D7
    FCVTZS  D22, D1
    FCVTZS  D19, D25
    FCVTZS  D31, D22
    FCVTZS  D27, D30
    FCVTZS  D25, D19
    FCVTZS  D22, D12
    FCVTZS  D30, D31
    FCVTZS  S10, S6
    FCVTZS  S7, S27
    FCVTZS  S11, S14
    FCVTZS  S3, S1
    FCVTZS  S27, S28
    FCVTZS  S17, S21
    FCVTZS  S2, S24
    FCVTZS  S14, S3
    FCVTZS  S31, S5
    FCVTZS  S28, S2
    FCVTZU D6, D31, #41
    FCVTZU D2, D22, #1
    FCVTZU D26, D20, #15
    FCVTZU D24, D11, #50
    FCVTZU D15, D21, #51
    FCVTZU D5, D26, #40
    FCVTZU D11, D11, #12
    FCVTZU D0, D6, #36
    FCVTZU D22, D1, #43
    FCVTZU D31, D6, #54
    FCVTZU S0, S4, #1
    FCVTZU S7, S2, #22
    FCVTZU S21, S0, #2
    FCVTZU S6, S24, #5
    FCVTZU S3, S22, #22
    FCVTZU S24, S27, #11
    FCVTZU S27, S28, #26
    FCVTZU S22, S0, #1
    FCVTZU S30, S22, #18
    FCVTZU S2, S2, #8
    FCVTZU  D18, D10
    FCVTZU  D24, D30
    FCVTZU  D9, D11
    FCVTZU  D28, D18
    FCVTZU  D30, D24
    FCVTZU  D18, D6
    FCVTZU  D11, D29
    FCVTZU  D22, D21
    FCVTZU  D6, D30
    FCVTZU  D26, D31
    FCVTZU  S30, S3
    FCVTZU  S14, S11
    FCVTZU  S29, S23
    FCVTZU  S0, S28
    FCVTZU  S20, S30
    FCVTZU  S23, S6
    FCVTZU  S24, S26
    FCVTZU  S3, S10
    FCVTZU  S17, S22
    FCVTZU  S6, S24
    FCVTAS  H11, H30
    FCVTAS  H28, H29
    FCVTAS  H22, H17
    FCVTAS  H9, H11
    FCVTAS  H17, H12
    FCVTAS  H13, H28
    FCVTAS  H21, H23
    FCVTAS  H10, H0
    FCVTAS  H28, H14
    FCVTAS  H24, H28
    FCVTAU  H20, H9
    FCVTAU  H30, H22
    FCVTAU  H9, H11
    FCVTAU  H26, H3
    FCVTAU  H15, H17
    FCVTAU  H22, H30
    FCVTAU  H30, H15
    FCVTAU  H31, H21
    FCVTAU  H17, H31
    FCVTAU  H12, H9
    FCVTMS  H15, H22
    FCVTMS  H22, H6
    FCVTMS  H16, H15
    FCVTMS  H23, H13
    FCVTMS  H31, H30
    FCVTMS  H3, H29
    FCVTMS  H3, H23
    FCVTMS  H11, H21
    FCVTMS  H14, H20
    FCVTMS  H29, H11
    FCVTMU  H21, H0
    FCVTMU  H30, H29
    FCVTMU  H28, H17
    FCVTMU  H12, H16
    FCVTMU  H29, H5
    FCVTMU  H17, H2
    FCVTMU  H9, H29
    FCVTMU  H15, H21
    FCVTMU  H23, H31
    FCVTMU  H31, H17
    FCVTNS  H2, H3
    FCVTNS  H13, H30
    FCVTNS  H9, H15
    FCVTNS  H5, H22
    FCVTNS  H11, H23
    FCVTNS  H30, H12
    FCVTNS  H6, H9
    FCVTNS  H3, H28
    FCVTNS  H20, H3
    FCVTNS  H21, H9
    MOVZ  X20, #0x94ab, LSL #0
    MOVK  X20, #0x8bed, LSL #16
    MOVK  X20, #0x806e, LSL #32
    MOVK  X20, #0x6a71, LSL #48
    SUB  X9, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x44ea, LSL #0
    MOVK  X20, #0x45a0, LSL #16
    MOVK  X20, #0xe08a, LSL #32
    MOVK  X20, #0xcfd9, LSL #48
    SUB  X9, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x9459, LSL #0
    MOVK  X20, #0x4be8, LSL #16
    MOVK  X20, #0x8807, LSL #32
    MOVK  X20, #0x11ba, LSL #48
    SUB  X9, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x8048, LSL #0
    MOVK  X20, #0x5486, LSL #16
    MOVK  X20, #0x62, LSL #32
    MOVK  X20, #0x507b, LSL #48
    SUB  X9, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x5f15, LSL #0
    MOVK  X20, #0xad69, LSL #16
    MOVK  X20, #0x4abd, LSL #32
    MOVK  X20, #0x6520, LSL #48
    SUB  X9, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0xec88, LSL #0
    MOVK  X20, #0xfbc, LSL #16
    MOVK  X20, #0x5805, LSL #32
    MOVK  X20, #0xd781, LSL #48
    SUB  X9, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x5096, LSL #0
    MOVK  X20, #0x12d7, LSL #16
    MOVK  X20, #0xce6b, LSL #32
    MOVK  X20, #0xf935, LSL #48
    SUB  X9, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x2340, LSL #0
    MOVK  X20, #0x79e6, LSL #16
    MOVK  X20, #0xb9f3, LSL #32
    MOVK  X20, #0x9f72, LSL #48
    SUB  X9, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0xe57e, LSL #0
    MOVK  X20, #0xb52c, LSL #16
    MOVK  X20, #0x2117, LSL #32
    MOVK  X20, #0xb6e3, LSL #48
    SUB  X9, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x84c0, LSL #0
    MOVK  X20, #0xbfa8, LSL #16
    MOVK  X20, #0xde34, LSL #32
    MOVK  X20, #0x307f, LSL #48
    SUB  X9, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0xa94, LSL #0
    MOVK  X20, #0x66e4, LSL #16
    MOVK  X20, #0x6aab, LSL #32
    MOVK  X20, #0x671e, LSL #48
    SUB  X9, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0xcccd, LSL #0
    MOVK  X20, #0x4d8, LSL #16
    MOVK  X20, #0xf1aa, LSL #32
    MOVK  X20, #0xda72, LSL #48
    SUB  X9, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x9865, LSL #0
    MOVK  X20, #0x41db, LSL #16
    MOVK  X20, #0xba36, LSL #32
    MOVK  X20, #0xedc2, LSL #48
    SUB  X9, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0xf6f1, LSL #0
    MOVK  X20, #0xbdde, LSL #16
    MOVK  X20, #0x2cab, LSL #32
    MOVK  X20, #0x8c87, LSL #48
    SUB  X9, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x172d, LSL #0
    MOVK  X20, #0xf5b5, LSL #16
    MOVK  X20, #0x1dc3, LSL #32
    MOVK  X20, #0x319d, LSL #48
    SUB  X9, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0xb7a4, LSL #0
    MOVK  X20, #0x62fd, LSL #16
    MOVK  X20, #0xfe63, LSL #32
    MOVK  X20, #0x442f, LSL #48
    SUB  X9, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x2f1f, LSL #0
    MOVK  X20, #0xf52a, LSL #16
    MOVK  X20, #0x896e, LSL #32
    MOVK  X20, #0xf3af, LSL #48
    SUB  X9, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x7bd2, LSL #0
    MOVK  X20, #0x73b0, LSL #16
    MOVK  X20, #0x3515, LSL #32
    MOVK  X20, #0x42c2, LSL #48
    SUB  X9, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x61e3, LSL #0
    MOVK  X20, #0xf252, LSL #16
    MOVK  X20, #0xf1, LSL #32
    MOVK  X20, #0x7e0f, LSL #48
    SUB  X9, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X20, #0x6c2d, LSL #0
    MOVK  X20, #0xf2a3, LSL #16
    MOVK  X20, #0x88e5, LSL #32
    MOVK  X20, #0x9ff, LSL #48
    SUB  X9, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X20, FPSR
    MOVZ  X9, #0x19, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D4
    MOVZ  X9, #0x1, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X20, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x1b80, LSL #0
    MOVK  X2, #0x672c, LSL #16
    MOVK  X2, #0x2682, LSL #32
    MOVK  X2, #0xc9c5, LSL #48
    MOVZ  X3, #0x7ad3, LSL #0
    MOVK  X3, #0xe742, LSL #16
    MOVK  X3, #0x8d5c, LSL #32
    MOVK  X3, #0xa3cd, LSL #48
    MOVZ  X4, #0xac29, LSL #0
    MOVK  X4, #0xc200, LSL #16
    MOVK  X4, #0xea5b, LSL #32
    MOVK  X4, #0x446c, LSL #48
    MOVZ  X5, #0xf2f3, LSL #0
    MOVK  X5, #0x666e, LSL #16
    MOVK  X5, #0x1ac0, LSL #32
    MOVK  X5, #0x5756, LSL #48
    MOVZ  X6, #0xcd45, LSL #0
    MOVK  X6, #0xc6ff, LSL #16
    MOVK  X6, #0x2739, LSL #32
    MOVK  X6, #0x9524, LSL #48
    MOVZ  X7, #0x735c, LSL #0
    MOVK  X7, #0x34c6, LSL #16
    MOVK  X7, #0xecbc, LSL #32
    MOVK  X7, #0xfe95, LSL #48
    MOVZ  X8, #0x78a, LSL #0
    MOVK  X8, #0xa3a, LSL #16
    MOVK  X8, #0xbce6, LSL #32
    MOVK  X8, #0x5dca, LSL #48
    MOVZ  X9, #0x7862, LSL #0
    MOVK  X9, #0x8edb, LSL #16
    MOVK  X9, #0x6a9d, LSL #32
    MOVK  X9, #0x1e1a, LSL #48
    MOVZ  X10, #0x388b, LSL #0
    MOVK  X10, #0x590e, LSL #16
    MOVK  X10, #0x4822, LSL #32
    MOVK  X10, #0x7d81, LSL #48
    MOVZ  X11, #0xd6aa, LSL #0
    MOVK  X11, #0x6cf1, LSL #16
    MOVK  X11, #0x82d8, LSL #32
    MOVK  X11, #0xc55d, LSL #48
    MOVZ  X12, #0x1b09, LSL #0
    MOVK  X12, #0xf797, LSL #16
    MOVK  X12, #0x2d60, LSL #32
    MOVK  X12, #0xdc79, LSL #48
    MOVZ  X13, #0x2d66, LSL #0
    MOVK  X13, #0x483d, LSL #16
    MOVK  X13, #0x64d8, LSL #32
    MOVK  X13, #0xf240, LSL #48
    MOVZ  X14, #0x11ef, LSL #0
    MOVK  X14, #0xb5d, LSL #16
    MOVK  X14, #0x67f0, LSL #32
    MOVK  X14, #0xb213, LSL #48
    MOVZ  X15, #0xd6c9, LSL #0
    MOVK  X15, #0x4399, LSL #16
    MOVK  X15, #0x1d2b, LSL #32
    MOVK  X15, #0x6908, LSL #48
    MOVZ  X16, #0xae5a, LSL #0
    MOVK  X16, #0x481d, LSL #16
    MOVK  X16, #0x742d, LSL #32
    MOVK  X16, #0x667c, LSL #48
    MOVZ  X17, #0xf65, LSL #0
    MOVK  X17, #0x970f, LSL #16
    MOVK  X17, #0x6337, LSL #32
    MOVK  X17, #0x6de8, LSL #48
    MOVZ  X18, #0xc2e8, LSL #0
    MOVK  X18, #0x57ef, LSL #16
    MOVK  X18, #0x8c1c, LSL #32
    MOVK  X18, #0x3f95, LSL #48
    MOVZ  X19, #0x4dd8, LSL #0
    MOVK  X19, #0x6e2b, LSL #16
    MOVK  X19, #0x2615, LSL #32
    MOVK  X19, #0x7bff, LSL #48
    MOVZ  X20, #0xddd9, LSL #0
    MOVK  X20, #0xe950, LSL #16
    MOVK  X20, #0x6f73, LSL #32
    MOVK  X20, #0xa2, LSL #48
    MOVZ  X21, #0xe0b0, LSL #0
    MOVK  X21, #0xcfcd, LSL #16
    MOVK  X21, #0x9426, LSL #32
    MOVK  X21, #0x3c04, LSL #48
    MOVZ  X22, #0x80e9, LSL #0
    MOVK  X22, #0x2267, LSL #16
    MOVK  X22, #0xd2c0, LSL #32
    MOVK  X22, #0x5ba5, LSL #48
    MOVZ  X23, #0xe456, LSL #0
    MOVK  X23, #0x6cd7, LSL #16
    MOVK  X23, #0x359f, LSL #32
    MOVK  X23, #0x517d, LSL #48
    MOVZ  X29, #0x300a, LSL #0
    MOVK  X29, #0x2d27, LSL #16
    MOVK  X29, #0x5bbd, LSL #32
    MOVK  X29, #0xb28d, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X21
    FMOV  D1, X20
    FMOV  V1.D[1], X22
    FMOV  D2, X13
    FMOV  V2.D[1], X23
    FMOV  D3, X9
    FMOV  V3.D[1], X29
    FMOV  D4, X29
    FMOV  V4.D[1], X4
    FMOV  D5, X7
    FMOV  V5.D[1], X9
    FMOV  D6, X12
    FMOV  V6.D[1], X8
    FMOV  D7, X19
    FMOV  V7.D[1], X29
    FMOV  D8, X3
    FMOV  V8.D[1], X10
    FMOV  D9, X23
    FMOV  V9.D[1], X17
    FMOV  D10, X21
    FMOV  V10.D[1], X15
    FMOV  D11, X13
    FMOV  V11.D[1], X18
    FMOV  D12, X15
    FMOV  V12.D[1], X18
    FMOV  D13, X5
    FMOV  V13.D[1], X21
    FMOV  D14, X9
    FMOV  V14.D[1], X22
    FMOV  D15, X8
    FMOV  V15.D[1], X10
    FMOV  D16, X5
    FMOV  V16.D[1], X2
    FMOV  D17, X3
    FMOV  V17.D[1], X14
    FMOV  D18, X22
    FMOV  V18.D[1], X9
    FMOV  D19, X13
    FMOV  V19.D[1], X19
    FMOV  D20, X2
    FMOV  V20.D[1], X23
    FMOV  D21, X19
    FMOV  V21.D[1], X17
    FMOV  D22, X8
    FMOV  V22.D[1], X9
    FMOV  D23, X10
    FMOV  V23.D[1], X16
    FMOV  D24, X22
    FMOV  V24.D[1], X18
    FMOV  D25, X22
    FMOV  V25.D[1], X6
    FMOV  D26, X19
    FMOV  V26.D[1], X9
    FMOV  D27, X13
    FMOV  V27.D[1], X13
    FMOV  D28, X12
    FMOV  V28.D[1], X2
    FMOV  D29, X3
    FMOV  V29.D[1], X8
    FMOV  D30, X13
    FMOV  V30.D[1], X20
    FMOV  D31, X13
    FMOV  V31.D[1], X8
    FCVTNU  H29, H27
    FCVTNU  H11, H30
    FCVTNU  H31, H25
    FCVTNU  H24, H29
    FCVTNU  H19, H12
    FCVTNU  H6, H19
    FCVTNU  H1, H26
    FCVTNU  H16, H24
    FCVTNU  H22, H6
    FCVTNU  H19, H1
    FCVTPS  H19, H25
    FCVTPS  H5, H11
    FCVTPS  H7, H16
    FCVTPS  H16, H7
    FCVTPS  H0, H22
    FCVTPS  H21, H16
    FCVTPS  H2, H31
    FCVTPS  H7, H2
    FCVTPS  H27, H5
    FCVTPS  H26, H12
    FCVTPU  H28, H28
    FCVTPU  H16, H28
    FCVTPU  H22, H5
    FCVTPU  H10, H27
    FCVTPU  H9, H19
    FCVTPU  H24, H21
    FCVTPU  H21, H26
    FCVTPU  H28, H24
    FCVTPU  H31, H18
    FCVTPU  H29, H1
    FCVTZS H1, H9, #10
    FCVTZS H29, H21, #13
    FCVTZS H21, H28, #10
    FCVTZS H28, H27, #12
    FCVTZS H27, H11, #14
    FCVTZS H9, H22, #14
    FCVTZS H18, H7, #13
    FCVTZS H29, H27, #5
    FCVTZS H7, H29, #8
    FCVTZS H29, H5, #9
    FCVTZS  H22, H16
    FCVTZS  H1, H9
    FCVTZS  H24, H1
    FCVTZS  H16, H28
    FCVTZS  H1, H20
    FCVTZS  H27, H10
    FCVTZS  H24, H24
    FCVTZS  H5, H21
    FCVTZS  H20, H16
    FCVTZS  H28, H2
    FCVTZU H23, H29, #5
    FCVTZU H10, H20, #15
    FCVTZU H21, H31, #8
    FCVTZU H2, H21, #8
    FCVTZU H24, H28, #7
    FCVTZU H31, H2, #15
    FCVTZU H28, H20, #8
    FCVTZU H29, H22, #12
    FCVTZU H20, H31, #11
    FCVTZU H27, H24, #5
    FCVTZU  H23, H23
    FCVTZU  H2, H5
    FCVTZU  H16, H29
    FCVTZU  H22, H19
    FCVTZU  H11, H18
    FCVTZU  H3, H30
    FCVTZU  H5, H28
    FCVTZU  H24, H5
    FCVTZU  H18, H13
    FCVTZU  H25, H3
    MOVZ  X2, #0x7ad3, LSL #0
    MOVK  X2, #0xe742, LSL #16
    MOVK  X2, #0x8d5c, LSL #32
    MOVK  X2, #0xa3cd, LSL #48
    SUB  X9, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xac29, LSL #0
    MOVK  X2, #0xc200, LSL #16
    MOVK  X2, #0xea5b, LSL #32
    MOVK  X2, #0x446c, LSL #48
    SUB  X9, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xf2f3, LSL #0
    MOVK  X2, #0x666e, LSL #16
    MOVK  X2, #0x1ac0, LSL #32
    MOVK  X2, #0x5756, LSL #48
    SUB  X9, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xcd45, LSL #0
    MOVK  X2, #0xc6ff, LSL #16
    MOVK  X2, #0x2739, LSL #32
    MOVK  X2, #0x9524, LSL #48
    SUB  X9, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x735c, LSL #0
    MOVK  X2, #0x34c6, LSL #16
    MOVK  X2, #0xecbc, LSL #32
    MOVK  X2, #0xfe95, LSL #48
    SUB  X9, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x78a, LSL #0
    MOVK  X2, #0xa3a, LSL #16
    MOVK  X2, #0xbce6, LSL #32
    MOVK  X2, #0x5dca, LSL #48
    SUB  X9, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x388b, LSL #0
    MOVK  X2, #0x590e, LSL #16
    MOVK  X2, #0x4822, LSL #32
    MOVK  X2, #0x7d81, LSL #48
    SUB  X9, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xd6aa, LSL #0
    MOVK  X2, #0x6cf1, LSL #16
    MOVK  X2, #0x82d8, LSL #32
    MOVK  X2, #0xc55d, LSL #48
    SUB  X9, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x1b09, LSL #0
    MOVK  X2, #0xf797, LSL #16
    MOVK  X2, #0x2d60, LSL #32
    MOVK  X2, #0xdc79, LSL #48
    SUB  X9, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x11ef, LSL #0
    MOVK  X2, #0xb5d, LSL #16
    MOVK  X2, #0x67f0, LSL #32
    MOVK  X2, #0xb213, LSL #48
    SUB  X9, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xd6c9, LSL #0
    MOVK  X2, #0x4399, LSL #16
    MOVK  X2, #0x1d2b, LSL #32
    MOVK  X2, #0x6908, LSL #48
    SUB  X9, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xae5a, LSL #0
    MOVK  X2, #0x481d, LSL #16
    MOVK  X2, #0x742d, LSL #32
    MOVK  X2, #0x667c, LSL #48
    SUB  X9, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xf65, LSL #0
    MOVK  X2, #0x970f, LSL #16
    MOVK  X2, #0x6337, LSL #32
    MOVK  X2, #0x6de8, LSL #48
    SUB  X9, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xc2e8, LSL #0
    MOVK  X2, #0x57ef, LSL #16
    MOVK  X2, #0x8c1c, LSL #32
    MOVK  X2, #0x3f95, LSL #48
    SUB  X9, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x4dd8, LSL #0
    MOVK  X2, #0x6e2b, LSL #16
    MOVK  X2, #0x2615, LSL #32
    MOVK  X2, #0x7bff, LSL #48
    SUB  X9, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xddd9, LSL #0
    MOVK  X2, #0xe950, LSL #16
    MOVK  X2, #0x6f73, LSL #32
    MOVK  X2, #0xa2, LSL #48
    SUB  X9, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xe0b0, LSL #0
    MOVK  X2, #0xcfcd, LSL #16
    MOVK  X2, #0x9426, LSL #32
    MOVK  X2, #0x3c04, LSL #48
    SUB  X9, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x80e9, LSL #0
    MOVK  X2, #0x2267, LSL #16
    MOVK  X2, #0xd2c0, LSL #32
    MOVK  X2, #0x5ba5, LSL #48
    SUB  X9, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xe456, LSL #0
    MOVK  X2, #0x6cd7, LSL #16
    MOVK  X2, #0x359f, LSL #32
    MOVK  X2, #0x517d, LSL #48
    SUB  X9, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x300a, LSL #0
    MOVK  X2, #0x2d27, LSL #16
    MOVK  X2, #0x5bbd, LSL #32
    MOVK  X2, #0xb28d, LSL #48
    SUB  X9, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X2, FPSR
    MOVZ  X9, #0x19, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X9, #0xac29, LSL #0
    MOVK  X9, #0xc200, LSL #16
    MOVK  X9, #0xea5b, LSL #32
    MOVK  X9, #0x446c, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D4
    MOVZ  X9, #0x300a, LSL #0
    MOVK  X9, #0x2d27, LSL #16
    MOVK  X9, #0x5bbd, LSL #32
    MOVK  X9, #0xb28d, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X9, #0x388b, LSL #0
    MOVK  X9, #0x590e, LSL #16
    MOVK  X9, #0x4822, LSL #32
    MOVK  X9, #0x7d81, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D8
    MOVZ  X9, #0x7ad3, LSL #0
    MOVK  X9, #0xe742, LSL #16
    MOVK  X9, #0x8d5c, LSL #32
    MOVK  X9, #0xa3cd, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X9, #0xc2e8, LSL #0
    MOVK  X9, #0x57ef, LSL #16
    MOVK  X9, #0x8c1c, LSL #32
    MOVK  X9, #0x3f95, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D12
    MOVZ  X9, #0xd6c9, LSL #0
    MOVK  X9, #0x4399, LSL #16
    MOVK  X9, #0x1d2b, LSL #32
    MOVK  X9, #0x6908, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X9, #0xe0b0, LSL #0
    MOVK  X9, #0xcfcd, LSL #16
    MOVK  X9, #0x9426, LSL #32
    MOVK  X9, #0x3c04, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D13
    MOVZ  X9, #0xf2f3, LSL #0
    MOVK  X9, #0x666e, LSL #16
    MOVK  X9, #0x1ac0, LSL #32
    MOVK  X9, #0x5756, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X9, #0x80e9, LSL #0
    MOVK  X9, #0x2267, LSL #16
    MOVK  X9, #0xd2c0, LSL #32
    MOVK  X9, #0x5ba5, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D14
    MOVZ  X9, #0x7862, LSL #0
    MOVK  X9, #0x8edb, LSL #16
    MOVK  X9, #0x6a9d, LSL #32
    MOVK  X9, #0x1e1a, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X9, #0x388b, LSL #0
    MOVK  X9, #0x590e, LSL #16
    MOVK  X9, #0x4822, LSL #32
    MOVK  X9, #0x7d81, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D15
    MOVZ  X9, #0x78a, LSL #0
    MOVK  X9, #0xa3a, LSL #16
    MOVK  X9, #0xbce6, LSL #32
    MOVK  X9, #0x5dca, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X9, #0x11ef, LSL #0
    MOVK  X9, #0xb5d, LSL #16
    MOVK  X9, #0x67f0, LSL #32
    MOVK  X9, #0xb213, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D17
    MOVZ  X9, #0x7ad3, LSL #0
    MOVK  X9, #0xe742, LSL #16
    MOVK  X9, #0x8d5c, LSL #32
    MOVK  X9, #0xa3cd, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D26
    MOVZ  X9, #0xff94, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X9, #0xddd9, LSL #0
    MOVK  X9, #0xe950, LSL #16
    MOVK  X9, #0x6f73, LSL #32
    MOVK  X9, #0xa2, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D30
    MOVZ  X9, #0x2d66, LSL #0
    MOVK  X9, #0x483d, LSL #16
    MOVK  X9, #0x64d8, LSL #32
    MOVK  X9, #0xf240, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X2, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x973b, LSL #0
    MOVK  X2, #0x7843, LSL #16
    MOVK  X2, #0x4e4, LSL #32
    MOVK  X2, #0xc8b, LSL #48
    MOVZ  X3, #0x50e6, LSL #0
    MOVK  X3, #0x24dc, LSL #16
    MOVK  X3, #0xc019, LSL #32
    MOVK  X3, #0x6328, LSL #48
    MOVZ  X4, #0x9af2, LSL #0
    MOVK  X4, #0xd1a6, LSL #16
    MOVK  X4, #0x3b75, LSL #32
    MOVK  X4, #0x5a3e, LSL #48
    MOVZ  X5, #0x2aad, LSL #0
    MOVK  X5, #0x27cd, LSL #16
    MOVK  X5, #0xfaa8, LSL #32
    MOVK  X5, #0x7878, LSL #48
    MOVZ  X6, #0x844e, LSL #0
    MOVK  X6, #0x5190, LSL #16
    MOVK  X6, #0x9c06, LSL #32
    MOVK  X6, #0x3865, LSL #48
    MOVZ  X7, #0x7f07, LSL #0
    MOVK  X7, #0x99c5, LSL #16
    MOVK  X7, #0x5090, LSL #32
    MOVK  X7, #0xaf67, LSL #48
    MOVZ  X8, #0xfa4b, LSL #0
    MOVK  X8, #0x8ab6, LSL #16
    MOVK  X8, #0x2dd7, LSL #32
    MOVK  X8, #0x9c32, LSL #48
    MOVZ  X9, #0x8453, LSL #0
    MOVK  X9, #0xaab9, LSL #16
    MOVK  X9, #0x4599, LSL #32
    MOVK  X9, #0xb085, LSL #48
    MOVZ  X10, #0x1884, LSL #0
    MOVK  X10, #0x9090, LSL #16
    MOVK  X10, #0xed37, LSL #32
    MOVK  X10, #0x13b6, LSL #48
    MOVZ  X11, #0x741, LSL #0
    MOVK  X11, #0x8c52, LSL #16
    MOVK  X11, #0x283d, LSL #32
    MOVK  X11, #0xd6f, LSL #48
    MOVZ  X12, #0xc383, LSL #0
    MOVK  X12, #0x9aed, LSL #16
    MOVK  X12, #0x2cfe, LSL #32
    MOVK  X12, #0xf86b, LSL #48
    MOVZ  X13, #0x4b46, LSL #0
    MOVK  X13, #0xc15, LSL #16
    MOVK  X13, #0xa0b, LSL #32
    MOVK  X13, #0x1ae5, LSL #48
    MOVZ  X14, #0x20f3, LSL #0
    MOVK  X14, #0x2166, LSL #16
    MOVK  X14, #0xce8c, LSL #32
    MOVK  X14, #0x7188, LSL #48
    MOVZ  X15, #0x4456, LSL #0
    MOVK  X15, #0xe7b9, LSL #16
    MOVK  X15, #0xb1a7, LSL #32
    MOVK  X15, #0xe8f1, LSL #48
    MOVZ  X16, #0x1bb2, LSL #0
    MOVK  X16, #0x8903, LSL #16
    MOVK  X16, #0x82d4, LSL #32
    MOVK  X16, #0xfba1, LSL #48
    MOVZ  X17, #0x220b, LSL #0
    MOVK  X17, #0x77af, LSL #16
    MOVK  X17, #0xc81a, LSL #32
    MOVK  X17, #0x2ada, LSL #48
    MOVZ  X18, #0x7d73, LSL #0
    MOVK  X18, #0x4ac7, LSL #16
    MOVK  X18, #0x4730, LSL #32
    MOVK  X18, #0x40ec, LSL #48
    MOVZ  X19, #0x33c2, LSL #0
    MOVK  X19, #0xa169, LSL #16
    MOVK  X19, #0x5907, LSL #32
    MOVK  X19, #0xc846, LSL #48
    MOVZ  X20, #0x106, LSL #0
    MOVK  X20, #0xd7d, LSL #16
    MOVK  X20, #0xd9a9, LSL #32
    MOVK  X20, #0xc897, LSL #48
    MOVZ  X21, #0xa9af, LSL #0
    MOVK  X21, #0x72bb, LSL #16
    MOVK  X21, #0xf163, LSL #32
    MOVK  X21, #0x2d6c, LSL #48
    MOVZ  X22, #0x81cc, LSL #0
    MOVK  X22, #0xcce0, LSL #16
    MOVK  X22, #0x3b7, LSL #32
    MOVK  X22, #0xe763, LSL #48
    MOVZ  X23, #0x4433, LSL #0
    MOVK  X23, #0x70aa, LSL #16
    MOVK  X23, #0x9a97, LSL #32
    MOVK  X23, #0xf64f, LSL #48
    MOVZ  X29, #0xa1d6, LSL #0
    MOVK  X29, #0x69c8, LSL #16
    MOVK  X29, #0x969d, LSL #32
    MOVK  X29, #0xa69b, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X17
    FMOV  D1, X29
    FMOV  V1.D[1], X11
    FMOV  D2, X22
    FMOV  V2.D[1], X11
    FMOV  D3, X12
    FMOV  V3.D[1], X23
    FMOV  D4, X20
    FMOV  V4.D[1], X19
    FMOV  D5, X9
    FMOV  V5.D[1], X16
    FMOV  D6, X23
    FMOV  V6.D[1], X4
    FMOV  D7, X17
    FMOV  V7.D[1], X6
    FMOV  D8, X21
    FMOV  V8.D[1], X21
    FMOV  D9, X23
    FMOV  V9.D[1], X23
    FMOV  D10, X29
    FMOV  V10.D[1], X12
    FMOV  D11, X9
    FMOV  V11.D[1], X4
    FMOV  D12, X15
    FMOV  V12.D[1], X6
    FMOV  D13, X23
    FMOV  V13.D[1], X17
    FMOV  D14, X23
    FMOV  V14.D[1], X23
    FMOV  D15, X9
    FMOV  V15.D[1], X22
    FMOV  D16, X6
    FMOV  V16.D[1], X8
    FMOV  D17, X23
    FMOV  V17.D[1], X4
    FMOV  D18, X6
    FMOV  V18.D[1], X22
    FMOV  D19, X19
    FMOV  V19.D[1], X8
    FMOV  D20, X29
    FMOV  V20.D[1], X20
    FMOV  D21, X2
    FMOV  V21.D[1], X21
    FMOV  D22, X18
    FMOV  V22.D[1], X15
    FMOV  D23, X4
    FMOV  V23.D[1], X12
    FMOV  D24, X16
    FMOV  V24.D[1], X3
    FMOV  D25, X8
    FMOV  V25.D[1], X11
    FMOV  D26, X3
    FMOV  V26.D[1], X12
    FMOV  D27, X3
    FMOV  V27.D[1], X6
    FMOV  D28, X12
    FMOV  V28.D[1], X23
    FMOV  D29, X16
    FMOV  V29.D[1], X23
    FMOV  D30, X23
    FMOV  V30.D[1], X2
    FMOV  D31, X14
    FMOV  V31.D[1], X12
    MOVZ  X16, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_0:
    FCVTNU  H6, H16
    FCVTPU  H10, H30
    FCVTPU  S4, S24
    FCVTMU  S4, S21
    FCVTZS D1, D19, #7
    FCVTMU  D14, D16
    FCVTZU D20, D27, #31
    FCVTAS  D7, D28
    FCVTZS  S26, S14
    FCVTZU  H12, H23
    FCVTZS H24, H23, #16
    FCVTNS  D0, D14
    FCVTZU  H22, H25
    FCVTNU  D16, D10
    FCVTMU  D29, D10
    FCVTZU  S28, S20
    FCVTZS H14, H22, #3
    FCVTAU  D28, D1
    FCVTZS D24, D17, #44
    FCVTNS  D15, D6
    FCVTNS  D9, D29
    FCVTZS H18, H31, #12
    FCVTZS H30, H15, #9
    FCVTZS  H23, H26
    FCVTMU  D6, D27
    FCVTZU  H25, H24
    FCVTPS  D27, D25
    FCVTZU  D17, D16
    FCVTZU  S29, S30
    FCVTMU  H30, H23
    FCVTMU  D26, D23
    FCVTZU  S20, S9
    FCVTMU  S13, S12
    FCVTNS  H22, H15
    FCVTPU  H6, H28
    FCVTZS  H24, H27
    FCVTNU  S28, S29
    FCVTPS  D9, D26
    FCVTMS  H27, H9
    FCVTNS  S26, S27
    FCVTMS  S18, S30
    FCVTZS H15, H13, #6
    FCVTPU  D4, D6
    FCVTZS  D27, D9
    FCVTPS  H16, H7
    FCVTZS D25, D28, #45
    FCVTPU  H12, H18
    FCVTMS  D31, D5
    FCVTNS  S28, S31
    FCVTPU  H9, H28
    FCVTZU  H21, H20
    FCVTAU  D20, D4
    FCVTAU  D28, D16
    FCVTNU  H16, H27
    FCVTPS  H5, H16
    FCVTZS  D5, D17
    FCVTMU  H22, H26
    FCVTZU S4, S19, #26
    FCVTNS  H6, H28
    FCVTZS  D30, D22
    FCVTAU  S17, S20
    FCVTMU  H22, H12
    FCVTZU S15, S8, #12
    FCVTNU  H7, H6
    FCVTXN  S16, D11
    FCVTZS  D26, D24
    FCVTPS  D19, D5
    FCVTNU  S19, S22
    FCVTAU  H5, H8
    FCVTPS  H22, H15
    FCVTZU  H22, H30
    FCVTPS  H31, H16
    FCVTZU  H8, H29
    FCVTNS  D28, D19
    FCVTAU  D5, D4
    FCVTMS  S4, S8
    FCVTXN  S16, D22
    FCVTPU  H24, H26
    FCVTPS  S12, S4
    FCVTZU S20, S16, #22
    FCVTPS  H29, H23
    FCVTPU  S8, S12
    FCVTZS  D23, D12
    FCVTZS S15, S20, #27
    FCVTMS  D30, D31
    FCVTMS  D20, D29
    FCVTPU  S26, S0
    FCVTMS  D0, D0
    FCVTAS  S14, S17
    FCVTNU  S29, S15
    FCVTZU  D9, D5
    FCVTZU H15, H24, #4
    FCVTAU  D31, D7
    FCVTPS  D5, D0
    FCVTXN  S17, D8
    FCVTPS  H0, H17
    FCVTNU  S12, S5
    FCVTAU  D16, D23
    FCVTPS  H7, H31
    FCVTAU  S5, S29
    FCVTNU  S9, S16
    FCVTAS  H23, H0
    FCVTPS  D9, D20
    FCVTAU  H17, H28
    FCVTZS D28, D7, #29
    FCVTZU  S16, S4
    FCVTAU  S29, S7
    FCVTPS  D29, D29
    FCVTZU H20, H23, #3
    FCVTMS  D31, D24
    FCVTXN  S0, D29
    FCVTZS S4, S17, #28
    FCVTNU  S23, S23
    FCVTZS H31, H23, #9
    FCVTPS  D7, D9
    FCVTNS  H25, H10
    FCVTMU  D10, D4
    FCVTZU H4, H16, #13
    FCVTPS  S8, S19
    FCVTZU  D19, D8
    FCVTNU  S24, S24
    FCVTZU  H8, H4
    FCVTZS S8, S2, #7
    FCVTMU  H15, H31
    FCVTPU  H29, H12
    FCVTAS  D4, D19
    FCVTPU  D4, D28
    FCVTNS  D30, D15
    FCVTAU  S28, S7
    FCVTNU  H2, H5
    FCVTZS  D23, D8
    FCVTPU  S6, S10
    FCVTAU  H7, H4
    FCVTZS  H12, H27
    FCVTNU  D16, D9
    FCVTNS  S9, S27
    FCVTZS  H5, H16
    FCVTNU  S27, S11
    FCVTZU S8, S23, #24
    FCVTAU  D31, D9
    FCVTZU D22, D8, #23
    FCVTAU  H19, H7
    FCVTNU  H23, H11
    FCVTPS  S15, S27
    FCVTMU  H27, H31
    FCVTAS  H28, H22
    FCVTZU  H14, H30
    FCVTAU  S16, S28
    FCVTAU  D6, D12
    FCVTZS  H11, H27
    FCVTPU  S4, S17
    FCVTZU D5, D4, #31
    FCVTMU  S27, S16
    FCVTPU  D18, D6
    FCVTAU  S8, S13
    FCVTZS H4, H30, #12
    FCVTPU  H25, H11
    FCVTMS  D28, D14
    FCVTPS  S6, S18
    FCVTMU  S12, S15
    FCVTNS  H30, H24
    FCVTXN  S1, D23
    FCVTZU H15, H4, #15
    FCVTMS  S31, S30
    FCVTAS  H22, H31
    FCVTZS  D11, D28
    FCVTZS  D16, D5
    FCVTPU  D7, D6
    FCVTNU  H31, H16
    FCVTZS H28, H4, #7
    FCVTZU  H16, H10
    FCVTZS  D30, D12
    FCVTNU  D8, D11
    FCVTMS  H13, H7
    FCVTAU  D27, D15
    FCVTAU  H11, H23
    FCVTZU  D5, D10
    FCVTMU  S23, S8
    FCVTXN  S4, D11
    FCVTNU  D27, D30
    FCVTZU H13, H28, #5
    FCVTAS  S8, S31
    FCVTPU  S6, S13
    FCVTZS  H10, H23
    FCVTNS  D19, D27
    FCVTPU  D10, D8
    FCVTZS  H0, H16
    FCVTZU  D2, D0
    FCVTZS H13, H5, #1
    FCVTNU  H28, H19
    FCVTAU  S27, S6
    FCVTMS  H6, H28
    FCVTMU  H31, H6
    FCVTNS  D16, D13
    FCVTZU S15, S8, #10
    FCVTAS  H7, H4
    FCVTPU  H23, H14
    FCVTZU D12, D3, #42
    FCVTNU  H15, H10
    FCVTZU  D24, D23
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_0
    MOVZ  X9, #0x973b, LSL #0
    MOVK  X9, #0x7843, LSL #16
    MOVK  X9, #0x4e4, LSL #32
    MOVK  X9, #0xc8b, LSL #48
    SUB  X19, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x50e6, LSL #0
    MOVK  X9, #0x24dc, LSL #16
    MOVK  X9, #0xc019, LSL #32
    MOVK  X9, #0x6328, LSL #48
    SUB  X19, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x9af2, LSL #0
    MOVK  X9, #0xd1a6, LSL #16
    MOVK  X9, #0x3b75, LSL #32
    MOVK  X9, #0x5a3e, LSL #48
    SUB  X19, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x2aad, LSL #0
    MOVK  X9, #0x27cd, LSL #16
    MOVK  X9, #0xfaa8, LSL #32
    MOVK  X9, #0x7878, LSL #48
    SUB  X19, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x844e, LSL #0
    MOVK  X9, #0x5190, LSL #16
    MOVK  X9, #0x9c06, LSL #32
    MOVK  X9, #0x3865, LSL #48
    SUB  X19, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x7f07, LSL #0
    MOVK  X9, #0x99c5, LSL #16
    MOVK  X9, #0x5090, LSL #32
    MOVK  X9, #0xaf67, LSL #48
    SUB  X19, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0xfa4b, LSL #0
    MOVK  X9, #0x8ab6, LSL #16
    MOVK  X9, #0x2dd7, LSL #32
    MOVK  X9, #0x9c32, LSL #48
    SUB  X19, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x1884, LSL #0
    MOVK  X9, #0x9090, LSL #16
    MOVK  X9, #0xed37, LSL #32
    MOVK  X9, #0x13b6, LSL #48
    SUB  X19, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x741, LSL #0
    MOVK  X9, #0x8c52, LSL #16
    MOVK  X9, #0x283d, LSL #32
    MOVK  X9, #0xd6f, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0xc383, LSL #0
    MOVK  X9, #0x9aed, LSL #16
    MOVK  X9, #0x2cfe, LSL #32
    MOVK  X9, #0xf86b, LSL #48
    SUB  X19, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x4b46, LSL #0
    MOVK  X9, #0xc15, LSL #16
    MOVK  X9, #0xa0b, LSL #32
    MOVK  X9, #0x1ae5, LSL #48
    SUB  X19, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x20f3, LSL #0
    MOVK  X9, #0x2166, LSL #16
    MOVK  X9, #0xce8c, LSL #32
    MOVK  X9, #0x7188, LSL #48
    SUB  X19, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x4456, LSL #0
    MOVK  X9, #0xe7b9, LSL #16
    MOVK  X9, #0xb1a7, LSL #32
    MOVK  X9, #0xe8f1, LSL #48
    SUB  X19, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x7d73, LSL #0
    MOVK  X9, #0x4ac7, LSL #16
    MOVK  X9, #0x4730, LSL #32
    MOVK  X9, #0x40ec, LSL #48
    SUB  X19, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x106, LSL #0
    MOVK  X9, #0xd7d, LSL #16
    MOVK  X9, #0xd9a9, LSL #32
    MOVK  X9, #0xc897, LSL #48
    SUB  X19, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0xa9af, LSL #0
    MOVK  X9, #0x72bb, LSL #16
    MOVK  X9, #0xf163, LSL #32
    MOVK  X9, #0x2d6c, LSL #48
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x81cc, LSL #0
    MOVK  X9, #0xcce0, LSL #16
    MOVK  X9, #0x3b7, LSL #32
    MOVK  X9, #0xe763, LSL #48
    SUB  X19, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0x4433, LSL #0
    MOVK  X9, #0x70aa, LSL #16
    MOVK  X9, #0x9a97, LSL #32
    MOVK  X9, #0xf64f, LSL #48
    SUB  X19, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X9, #0xa1d6, LSL #0
    MOVK  X9, #0x69c8, LSL #16
    MOVK  X9, #0x969d, LSL #32
    MOVK  X9, #0xa69b, LSL #48
    SUB  X19, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X9, FPSR
    MOVZ  X19, #0x19, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D0
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D1
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X19, #0x4433, LSL #0
    MOVK  X19, #0x70aa, LSL #16
    MOVK  X19, #0x9a97, LSL #32
    MOVK  X19, #0xf64f, LSL #48
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D3
    MOVZ  X19, #0xc383, LSL #0
    MOVK  X19, #0x9aed, LSL #16
    MOVK  X19, #0x2cfe, LSL #32
    MOVK  X19, #0xf86b, LSL #48
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D4
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D5
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D9
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D12
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D19
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D21
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D30
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X9, D31
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  D0, X12
    FMOV  V0.D[1], X20
    FMOV  D1, X10
    FMOV  V1.D[1], X17
    FMOV  D2, X4
    FMOV  V2.D[1], X29
    FMOV  D3, X18
    FMOV  V3.D[1], X16
    FMOV  D4, X23
    FMOV  V4.D[1], X21
    FMOV  D5, X2
    FMOV  V5.D[1], X20
    FMOV  D6, X22
    FMOV  V6.D[1], X19
    FMOV  D7, X5
    FMOV  V7.D[1], X18
    FMOV  D8, X19
    FMOV  V8.D[1], X17
    FMOV  D9, X22
    FMOV  V9.D[1], X9
    FMOV  D10, X6
    FMOV  V10.D[1], X7
    FMOV  D11, X29
    FMOV  V11.D[1], X5
    FMOV  D12, X29
    FMOV  V12.D[1], X14
    FMOV  D13, X5
    FMOV  V13.D[1], X4
    FMOV  D14, X12
    FMOV  V14.D[1], X9
    FMOV  D15, X21
    FMOV  V15.D[1], X8
    FMOV  D16, X3
    FMOV  V16.D[1], X6
    FMOV  D17, X10
    FMOV  V17.D[1], X13
    FMOV  D18, X4
    FMOV  V18.D[1], X29
    FMOV  D19, X29
    FMOV  V19.D[1], X22
    FMOV  D20, X19
    FMOV  V20.D[1], X17
    FMOV  D21, X17
    FMOV  V21.D[1], X20
    FMOV  D22, X8
    FMOV  V22.D[1], X29
    FMOV  D23, X16
    FMOV  V23.D[1], X4
    FMOV  D24, X19
    FMOV  V24.D[1], X14
    FMOV  D25, X29
    FMOV  V25.D[1], X9
    FMOV  D26, X14
    FMOV  V26.D[1], X8
    FMOV  D27, X3
    FMOV  V27.D[1], X6
    FMOV  D28, X4
    FMOV  V28.D[1], X2
    FMOV  D29, X11
    FMOV  V29.D[1], X18
    FMOV  D30, X2
    FMOV  V30.D[1], X2
    FMOV  D31, X7
    FMOV  V31.D[1], X5
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_1:
    FCVTNS  D6, D7
    FCVTPS  S20, S1
    FCVTZU S15, S27, #4
    FCVTMS  D1, D12
    FCVTMS  D7, D25
    FCVTAU  H0, H26
    FCVTMU  H1, H29
    FCVTPS  D12, D13
    FCVTAU  H6, H21
    FCVTAS  S18, S5
    FCVTNS  D13, D7
    FCVTPU  D0, D31
    FCVTZS  H24, H28
    FCVTZS D24, D9, #9
    FCVTPS  S8, S20
    FCVTZS  S19, S15
    FCVTMS  D8, D13
    FCVTNS  S11, S13
    FCVTAS  D31, D15
    FCVTZS D3, D0, #19
    FCVTNU  S0, S12
    FCVTAU  S20, S3
    FCVTNS  H21, H31
    FCVTPU  S8, S0
    FCVTZU H3, H31, #11
    FCVTPS  S29, S19
    FCVTPU  D10, D30
    FCVTNS  S27, S12
    FCVTAU  D13, D27
    FCVTPS  S7, S24
    FCVTPU  H31, H7
    FCVTZS S26, S5, #25
    FCVTPS  S15, S11
    FCVTNU  S19, S26
    FCVTZU H24, H8, #6
    FCVTZS  H9, H28
    FCVTNU  D30, D10
    FCVTNU  H3, H13
    FCVTZU  S18, S27
    FCVTXN  S11, D30
    FCVTMU  S30, S29
    FCVTZU  D29, D4
    FCVTNS  D4, D3
    FCVTPU  H7, H28
    FCVTPS  D13, D21
    FCVTAS  H29, H18
    FCVTXN  S26, D24
    FCVTZU H8, H31, #3
    FCVTMU  H26, H11
    FCVTMU  S31, S23
    FCVTMS  D24, D30
    FCVTPU  D3, D24
    FCVTZS  D6, D7
    FCVTZS H10, H13, #6
    FCVTZU  D11, D29
    FCVTMU  H5, H19
    FCVTZU S18, S0, #24
    FCVTAU  S19, S6
    FCVTMS  H24, H18
    FCVTZS H30, H26, #5
    FCVTZS  H13, H20
    FCVTXN  S23, D11
    FCVTXN  S29, D19
    FCVTNS  H16, H24
    FCVTPU  H28, H5
    FCVTNS  H5, H29
    FCVTNS  S6, S16
    FCVTMS  D29, D14
    FCVTMS  D19, D17
    FCVTNU  S16, S28
    FCVTMS  H11, H16
    FCVTMS  S26, S30
    FCVTMS  H0, H6
    FCVTZS  H26, H2
    FCVTZS  H30, H12
    FCVTPS  H28, H12
    FCVTXN  S18, D8
    FCVTZS S12, S3, #29
    FCVTMS  D16, D19
    FCVTNU  D17, D30
    FCVTAU  D24, D26
    FCVTPU  D3, D5
    FCVTPS  S6, S10
    FCVTZS  H29, H6
    FCVTZU D6, D23, #30
    FCVTXN  S26, D28
    FCVTZU  H30, H29
    FCVTNU  D19, D2
    FCVTZU  S13, S3
    FCVTMS  H23, H17
    FCVTAS  S11, S4
    FCVTMS  H17, H13
    FCVTZU  H5, H18
    FCVTNS  H2, H26
    FCVTZS  D13, D1
    FCVTZS S14, S3, #15
    FCVTAU  H10, H24
    FCVTNS  H13, H26
    FCVTNU  D1, D10
    FCVTZU  S29, S19
    FCVTZS  S27, S1
    FCVTAS  D28, D17
    FCVTMS  D30, D27
    FCVTAU  H10, H22
    FCVTXN  S18, D5
    FCVTNU  S22, S28
    FCVTZS  D8, D30
    FCVTMU  S1, S2
    FCVTZS  S26, S22
    FCVTMU  H27, H6
    FCVTAS  D6, D7
    FCVTZS  S17, S29
    FCVTZU  D22, D8
    FCVTZU H2, H26, #14
    FCVTMS  D24, D13
    FCVTMU  H3, H11
    FCVTZU  S11, S27
    FCVTZU S27, S13, #5
    FCVTZU S26, S6, #16
    FCVTNS  S8, S0
    FCVTZS  D0, D1
    FCVTNU  D13, D18
    FCVTXN  S24, D10
    FCVTNU  H28, H12
    FCVTZU  S4, S3
    FCVTXN  S12, D27
    FCVTNU  S18, S24
    FCVTMU  S2, S2
    FCVTMU  H29, H2
    FCVTMS  H2, H13
    FCVTZU D19, D26, #13
    FCVTZU D26, D9, #15
    FCVTZU H3, H18, #3
    FCVTZU S8, S23, #9
    FCVTZS D10, D28, #55
    FCVTMU  H23, H26
    FCVTZS S13, S3, #28
    FCVTNU  D23, D0
    FCVTPU  S31, S23
    FCVTMS  H28, H13
    FCVTMS  S0, S19
    FCVTPS  S4, S13
    FCVTNU  D24, D28
    FCVTZU  H26, H11
    FCVTMS  D18, D6
    FCVTZS S28, S8, #11
    FCVTAU  D21, D4
    FCVTAU  H4, H24
    FCVTZU  S23, S2
    FCVTZU H24, H10, #5
    FCVTMS  D13, D12
    FCVTPS  S19, S21
    FCVTAS  D11, D23
    FCVTZU H6, H24, #2
    FCVTZS  D27, D28
    FCVTNS  H24, H13
    FCVTPS  S23, S18
    FCVTMU  H3, H6
    FCVTAS  S30, S31
    FCVTZS D8, D13, #34
    FCVTMU  D31, D19
    FCVTPU  D21, D17
    FCVTMS  S12, S9
    FCVTNS  D17, D18
    FCVTAS  D8, D12
    FCVTAU  S19, S30
    FCVTAS  D23, D27
    FCVTZS H28, H2, #1
    FCVTNS  D0, D10
    FCVTMU  D27, D26
    FCVTMU  H6, H16
    FCVTZU H10, H28, #2
    FCVTMU  D2, D4
    FCVTAU  H13, H19
    FCVTZU  S22, S21
    FCVTPS  S21, S28
    FCVTZS S12, S10, #20
    FCVTPS  S19, S3
    FCVTZS  H28, H31
    FCVTAS  D4, D23
    FCVTAU  H18, H17
    FCVTAS  D9, D2
    FCVTMU  D0, D20
    FCVTZU  H17, H19
    FCVTPU  S26, S0
    FCVTAS  S20, S9
    FCVTNS  H12, H21
    FCVTZU H16, H14, #2
    FCVTZU H31, H18, #11
    FCVTMU  D0, D25
    FCVTZU S3, S12, #17
    FCVTMS  S23, S3
    FCVTMU  S14, S20
    FCVTPS  H9, H11
    FCVTNU  D20, D28
    FCVTMU  D25, D14
    FCVTAS  S12, S26
    FCVTMU  H26, H20
    FCVTZU  H24, H9
    FCVTPS  H20, H31
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_1
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X11, FPSR
    MOVZ  X5, #0x19, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D0
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D1
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D5
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D9
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D29
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D30
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D31
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X12
    FMOV  V1.D[1], X11
    FMOV  D2, X22
    FMOV  V2.D[1], X19
    FMOV  D3, X21
    FMOV  V3.D[1], X15
    FMOV  D4, X29
    FMOV  V4.D[1], X18
    FMOV  D5, X12
    FMOV  V5.D[1], X10
    FMOV  D6, X12
    FMOV  V6.D[1], X22
    FMOV  D7, X21
    FMOV  V7.D[1], X29
    FMOV  D8, X22
    FMOV  V8.D[1], X16
    FMOV  D9, X14
    FMOV  V9.D[1], X21
    FMOV  D10, X29
    FMOV  V10.D[1], X29
    FMOV  D11, X19
    FMOV  V11.D[1], X6
    FMOV  D12, X15
    FMOV  V12.D[1], X4
    FMOV  D13, X29
    FMOV  V13.D[1], X12
    FMOV  D14, X13
    FMOV  V14.D[1], X3
    FMOV  D15, X4
    FMOV  V15.D[1], X21
    FMOV  D16, X7
    FMOV  V16.D[1], X4
    FMOV  D17, X8
    FMOV  V17.D[1], X5
    FMOV  D18, X13
    FMOV  V18.D[1], X20
    FMOV  D19, X11
    FMOV  V19.D[1], X22
    FMOV  D20, X12
    FMOV  V20.D[1], X16
    FMOV  D21, X18
    FMOV  V21.D[1], X21
    FMOV  D22, X12
    FMOV  V22.D[1], X19
    FMOV  D23, X7
    FMOV  V23.D[1], X12
    FMOV  D24, X4
    FMOV  V24.D[1], X13
    FMOV  D25, X13
    FMOV  V25.D[1], X21
    FMOV  D26, X18
    FMOV  V26.D[1], X6
    FMOV  D27, X18
    FMOV  V27.D[1], X8
    FMOV  D28, X13
    FMOV  V28.D[1], X4
    FMOV  D29, X2
    FMOV  V29.D[1], X4
    FMOV  D30, X22
    FMOV  V30.D[1], X22
    FMOV  D31, X29
    FMOV  V31.D[1], X10
    MOVZ  X19, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_2:
    FCVTZU S15, S27, #5
    FCVTMS  H30, H29
    FCVTNU  S29, S31
    FCVTZU H3, H18, #10
    FCVTZU S7, S15, #30
    FCVTZU  H6, H30
    FCVTAS  S16, S26
    FCVTZU  H13, H16
    FCVTMU  H3, H7
    FCVTAU  H27, H15
    FCVTZS H11, H9, #4
    FCVTPU  H26, H27
    FCVTPS  D29, D29
    FCVTMU  H9, H29
    FCVTZU D5, D27, #50
    FCVTZU D1, D25, #61
    FCVTAS  D6, D15
    FCVTPS  H17, H1
    FCVTAS  H21, H13
    FCVTZS  S15, S7
    FCVTZU  D31, D15
    FCVTMS  S16, S21
    FCVTAS  S29, S5
    FCVTZU  D3, D16
    FCVTZU  D23, D9
    FCVTMS  S13, S17
    FCVTNS  H13, H7
    FCVTZU  D12, D8
    FCVTZS  S7, S6
    FCVTNS  H9, H10
    FCVTNS  H29, H29
    FCVTZS  D29, D0
    FCVTMS  D6, D23
    FCVTZU  H5, H9
    FCVTAU  D17, D6
    FCVTAU  H0, H17
    FCVTMS  D23, D5
    FCVTZS  H28, H13
    FCVTZU  D10, D3
    FCVTNU  D13, D10
    FCVTZU H16, H28, #4
    FCVTZU  D15, D13
    FCVTPU  S6, S0
    FCVTMU  H8, H12
    FCVTMU  S10, S6
    FCVTZU  S16, S15
    FCVTAS  S20, S31
    FCVTNS  H3, H1
    FCVTXN  S28, D21
    FCVTPS  S2, S3
    FCVTZS  D13, D5
    FCVTAS  D26, D28
    FCVTAS  D17, D10
    FCVTMU  S9, S17
    FCVTPS  H28, H7
    FCVTZS H31, H30, #16
    FCVTZS D6, D26, #21
    FCVTZS  S4, S25
    FCVTZU  D17, D8
    FCVTZS S12, S16, #19
    FCVTAS  H29, H20
    FCVTZU  H26, H31
    FCVTZS S0, S9, #30
    FCVTAU  D16, D0
    FCVTPU  D10, D6
    FCVTAU  H15, H13
    FCVTMU  D21, D7
    FCVTAU  D25, D10
    FCVTZU  H13, H7
    FCVTNU  D30, D28
    FCVTPU  S7, S24
    FCVTZS  S6, S21
    FCVTZU  D0, D13
    FCVTZU S20, S2, #19
    FCVTZU H8, H29, #9
    FCVTZS D28, D30, #11
    FCVTAU  S26, S17
    FCVTPS  S21, S8
    FCVTAU  S31, S16
    FCVTPU  S3, S6
    FCVTXN  S8, D20
    FCVTNU  H24, H15
    FCVTNS  D28, D3
    FCVTZS  H3, H4
    FCVTXN  S17, D24
    FCVTZU S10, S25, #22
    FCVTMU  H2, H12
    FCVTNS  D13, D17
    FCVTZU  S16, S13
    FCVTAU  D17, D19
    FCVTMS  D6, D3
    FCVTZS D19, D8, #44
    FCVTMU  S30, S17
    FCVTNS  S2, S16
    FCVTNU  D23, D7
    FCVTPU  H24, H19
    FCVTAU  H7, H30
    FCVTZU H29, H0, #7
    FCVTMS  S15, S10
    FCVTPS  H4, H29
    FCVTZU D13, D6, #3
    FCVTPS  S0, S23
    FCVTAS  H30, H25
    FCVTAS  S20, S4
    FCVTZS H8, H30, #13
    FCVTZU H17, H15, #15
    FCVTZS  S12, S10
    FCVTNS  D17, D21
    FCVTZU D16, D27, #63
    FCVTPS  D25, D1
    FCVTZS  H21, H7
    FCVTAU  S1, S13
    FCVTPU  S3, S8
    FCVTMU  H30, H16
    FCVTZS H13, H12, #13
    FCVTMS  D10, D0
    FCVTPU  S4, S11
    FCVTPS  H29, H20
    FCVTMU  H16, H4
    FCVTMU  H6, H18
    FCVTAU  S15, S25
    FCVTZU  H23, H10
    FCVTAU  S10, S1
    FCVTZS S19, S29, #29
    FCVTPU  S4, S3
    FCVTZU  S0, S6
    FCVTZU H12, H19, #8
    FCVTAS  S27, S10
    FCVTMU  H8, H16
    FCVTZS  S29, S30
    FCVTAU  S1, S29
    FCVTPU  H30, H1
    FCVTZU  S16, S23
    FCVTAU  D1, D8
    FCVTNU  S3, S4
    FCVTZU D1, D27, #8
    FCVTMU  S25, S15
    FCVTPU  H20, H3
    FCVTAU  S23, S1
    FCVTZS H8, H16, #6
    FCVTMU  H1, H23
    FCVTPS  H15, H15
    FCVTMU  S6, S9
    FCVTZS D11, D6, #61
    FCVTAU  D15, D6
    FCVTZU  H15, H4
    FCVTZU H16, H11, #11
    FCVTMU  D4, D30
    FCVTMU  H6, H20
    FCVTMS  D27, D25
    FCVTZU H30, H13, #10
    FCVTXN  S25, D16
    FCVTNU  H10, H30
    FCVTNS  H23, H15
    FCVTNS  S9, S15
    FCVTPS  H15, H23
    FCVTZS  D20, D27
    FCVTNS  D23, D4
    FCVTMS  H30, H4
    FCVTMU  D13, D10
    FCVTZU  H10, H1
    FCVTNU  S11, S30
    FCVTPU  S1, S15
    FCVTPS  H24, H11
    FCVTZU H4, H1, #16
    FCVTXN  S20, D10
    FCVTZS  S11, S13
    FCVTAU  H15, H25
    FCVTMU  D7, D14
    FCVTZS  S13, S24
    FCVTNU  S27, S12
    FCVTAU  H30, H27
    FCVTNU  S24, S30
    FCVTMU  H30, H28
    FCVTZS  D1, D22
    FCVTNU  S28, S29
    FCVTMS  D12, D25
    FCVTPS  D29, D11
    FCVTAU  S21, S24
    FCVTMS  H17, H22
    FCVTAU  H11, H15
    FCVTZS S18, S1, #10
    FCVTZS D25, D9, #35
    FCVTPU  S11, S17
    FCVTNS  H20, H11
    FCVTAS  H1, H18
    FCVTZS  D31, D0
    FCVTMU  D27, D7
    FCVTZU  D10, D1
    FCVTZU  S24, S28
    FCVTZS  H7, H20
    FCVTZU D0, D31, #61
    FCVTNU  H0, H29
    FCVTAU  S22, S13
    FCVTMU  S31, S22
    FCVTZS S4, S27, #20
    FCVTMU  D27, D4
    FCVTAS  H11, H27
    FCVTZU H18, H10, #12
    FCVTAS  D1, D7
    SUBS  X19, X19, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_2
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X6, FPSR
    MOVZ  X3, #0x19, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D14
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D30
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X5
    FMOV  D1, X3
    FMOV  V1.D[1], X18
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X20
    FMOV  V3.D[1], X18
    FMOV  D4, X29
    FMOV  V4.D[1], X17
    FMOV  D5, X8
    FMOV  V5.D[1], X11
    FMOV  D6, X11
    FMOV  V6.D[1], X13
    FMOV  D7, X23
    FMOV  V7.D[1], X18
    FMOV  D8, X14
    FMOV  V8.D[1], X11
    FMOV  D9, X8
    FMOV  V9.D[1], X29
    FMOV  D10, X4
    FMOV  V10.D[1], X29
    FMOV  D11, X22
    FMOV  V11.D[1], X22
    FMOV  D12, X10
    FMOV  V12.D[1], X15
    FMOV  D13, X12
    FMOV  V13.D[1], X13
    FMOV  D14, X4
    FMOV  V14.D[1], X17
    FMOV  D15, X10
    FMOV  V15.D[1], X10
    FMOV  D16, X20
    FMOV  V16.D[1], X21
    FMOV  D17, X16
    FMOV  V17.D[1], X6
    FMOV  D18, X23
    FMOV  V18.D[1], X10
    FMOV  D19, X9
    FMOV  V19.D[1], X10
    FMOV  D20, X20
    FMOV  V20.D[1], X23
    FMOV  D21, X29
    FMOV  V21.D[1], X16
    FMOV  D22, X11
    FMOV  V22.D[1], X9
    FMOV  D23, X11
    FMOV  V23.D[1], X3
    FMOV  D24, X19
    FMOV  V24.D[1], X4
    FMOV  D25, X19
    FMOV  V25.D[1], X5
    FMOV  D26, X13
    FMOV  V26.D[1], X7
    FMOV  D27, X4
    FMOV  V27.D[1], X16
    FMOV  D28, X23
    FMOV  V28.D[1], X8
    FMOV  D29, X29
    FMOV  V29.D[1], X20
    FMOV  D30, X11
    FMOV  V30.D[1], X12
    FMOV  D31, X21
    FMOV  V31.D[1], X18
    MOVZ  X20, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_3:
    FCVTZS H22, H30, #12
    FCVTPS  S29, S22
    FCVTPS  S1, S23
    FCVTZS  S3, S1
    FCVTAU  S31, S19
    FCVTPS  D4, D31
    FCVTZS S27, S26, #10
    FCVTZS  H19, H28
    FCVTZU  D23, D27
    FCVTAS  H29, H3
    FCVTZS  H13, H23
    FCVTXN  S9, D4
    FCVTNU  S6, S29
    FCVTZS H11, H19, #16
    FCVTMS  H24, H22
    FCVTAU  D2, D19
    FCVTZS  H13, H6
    FCVTNS  D21, D25
    FCVTZU D29, D21, #10
    FCVTAU  D8, D9
    FCVTAS  S1, S20
    FCVTZU D29, D29, #28
    FCVTPS  H16, H1
    FCVTPU  H19, H16
    FCVTMU  H27, H24
    FCVTNU  H25, H29
    FCVTPS  S31, S19
    FCVTPS  D9, D25
    FCVTPU  S2, S10
    FCVTPU  D21, D27
    FCVTZS S25, S9, #14
    FCVTZU D11, D2, #10
    FCVTNS  H16, H22
    FCVTAS  S4, S3
    FCVTZU S19, S31, #27
    FCVTPS  H10, H0
    FCVTAS  H31, H21
    FCVTAS  S30, S4
    FCVTNS  S9, S3
    FCVTZU  H6, H25
    FCVTZU  S15, S30
    FCVTPU  S3, S15
    FCVTNS  S31, S10
    FCVTMU  D22, D13
    FCVTZS  D29, D22
    FCVTAU  S15, S9
    FCVTNU  S1, S20
    FCVTNU  D30, D15
    FCVTNS  H22, H12
    FCVTZU  H12, H16
    FCVTZU D24, D29, #52
    FCVTNU  S0, S1
    FCVTZU  H9, H3
    FCVTPU  S21, S22
    FCVTZS H15, H29, #10
    FCVTPS  H24, H5
    FCVTNS  H20, H21
    FCVTZU D12, D20, #10
    FCVTZS  H22, H31
    FCVTZU S5, S22, #13
    FCVTPU  H3, H22
    FCVTZS D20, D13, #47
    FCVTPS  D10, D29
    FCVTAU  H13, H30
    FCVTMU  S29, S13
    FCVTZU S4, S13, #26
    FCVTNS  H13, H10
    FCVTZS  H10, H26
    FCVTAU  D7, D3
    FCVTPS  S31, S3
    FCVTAU  D26, D4
    FCVTAU  S22, S0
    FCVTAS  H21, H12
    FCVTMU  H12, H22
    FCVTPS  H3, H20
    FCVTNS  H18, H24
    FCVTZU D2, D4, #35
    FCVTAS  S0, S26
    FCVTZU  D26, D2
    FCVTAU  D20, D7
    FCVTAS  S30, S20
    FCVTMS  S22, S18
    FCVTZS D8, D9, #12
    FCVTPU  D9, D0
    FCVTMU  D24, D21
    FCVTMU  H7, H8
    FCVTZU  D6, D15
    FCVTAU  H9, H10
    FCVTPS  H30, H6
    FCVTMS  D15, D0
    FCVTNS  S0, S23
    FCVTMU  D22, D1
    FCVTZS D4, D12, #56
    FCVTPS  H6, H22
    FCVTAS  H17, H5
    FCVTZS S18, S15, #14
    FCVTMS  S8, S12
    FCVTPS  D29, D18
    FCVTMS  H12, H6
    FCVTNS  H30, H17
    FCVTPS  H26, H8
    FCVTNS  H6, H0
    FCVTAS  D15, D18
    FCVTZS  H17, H12
    FCVTMS  H8, H9
    FCVTPU  S21, S15
    FCVTMU  H10, H26
    FCVTAU  H0, H24
    FCVTZS H25, H8, #3
    FCVTPS  D26, D29
    FCVTXN  S12, D25
    FCVTMS  S9, S10
    FCVTZS S5, S17, #14
    FCVTZS  S15, S0
    FCVTNU  S8, S6
    FCVTZU  D25, D26
    FCVTNU  D0, D5
    FCVTAS  H1, H1
    FCVTAU  S18, S30
    FCVTMS  D30, D1
    FCVTAU  H23, H4
    FCVTPU  D1, D9
    FCVTNS  S25, S15
    FCVTNU  D9, D8
    FCVTMS  D8, D6
    FCVTNS  D6, D7
    FCVTAS  D15, D23
    FCVTZU  S23, S30
    FCVTMS  H3, H23
    FCVTPS  D5, D8
    FCVTAU  D8, D25
    FCVTAU  H26, H27
    FCVTAU  H18, H21
    FCVTNU  H27, H12
    FCVTZS D10, D1, #35
    FCVTMU  S25, S0
    FCVTAS  S21, S27
    FCVTXN  S4, D21
    FCVTPU  H16, H13
    FCVTZS  D1, D27
    FCVTNS  H12, H25
    FCVTXN  S11, D3
    FCVTPU  H30, H9
    FCVTZU  S27, S4
    FCVTZU S25, S10, #23
    FCVTXN  S4, D15
    FCVTNU  H23, H1
    FCVTNS  H1, H4
    FCVTMS  S7, S18
    FCVTPS  H9, H5
    FCVTPS  S21, S13
    FCVTPU  D15, D26
    FCVTXN  S10, D25
    FCVTMS  H5, H6
    FCVTPS  H18, H5
    FCVTAU  H3, H18
    FCVTAS  D9, D8
    FCVTPS  S25, S21
    FCVTMU  D25, D30
    FCVTNU  D30, D12
    FCVTZU  H6, H28
    FCVTPU  D9, D25
    FCVTZU H13, H12, #2
    FCVTAS  S12, S25
    FCVTZU  H28, H30
    FCVTNU  H14, H7
    FCVTMS  H21, H10
    FCVTNU  S8, S12
    FCVTZU  S5, S16
    FCVTPS  D30, D14
    FCVTMU  D18, D15
    FCVTZU  S12, S12
    FCVTMU  H3, H6
    FCVTAU  D6, D4
    FCVTPS  D16, D4
    FCVTNS  D25, D9
    FCVTNU  D7, D25
    FCVTPS  H29, H6
    FCVTMS  D14, D28
    FCVTNU  H28, H5
    FCVTZU H6, H8, #6
    FCVTMU  D15, D6
    FCVTZU  H29, H16
    FCVTMU  D24, D14
    FCVTMU  H10, H21
    FCVTZU D5, D23, #51
    FCVTPU  H6, H20
    FCVTZU  H27, H5
    FCVTMS  S14, S7
    FCVTZU D19, D14, #49
    FCVTZS  D5, D11
    FCVTZS  D16, D30
    FCVTXN  S8, D24
    FCVTZU  S25, S3
    FCVTZS  D1, D16
    FCVTAS  D7, D12
    FCVTNU  S3, S18
    FCVTZS D18, D15, #48
    FCVTZS D23, D10, #27
    FCVTAS  H15, H23
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_3
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X3, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X10, FPSR
    MOVZ  X3, #0x19, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D30
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  V1.D[1], X21
    FMOV  D2, X29
    FMOV  V2.D[1], X2
    FMOV  D3, X2
    FMOV  V3.D[1], X7
    FMOV  D4, X15
    FMOV  V4.D[1], X22
    FMOV  D5, X12
    FMOV  V5.D[1], X9
    FMOV  D6, X8
    FMOV  V6.D[1], X12
    FMOV  D7, X29
    FMOV  V7.D[1], X2
    FMOV  D8, X4
    FMOV  V8.D[1], X14
    FMOV  D9, X17
    FMOV  V9.D[1], X7
    FMOV  D10, X22
    FMOV  V10.D[1], X20
    FMOV  D11, X14
    FMOV  V11.D[1], X23
    FMOV  D12, X19
    FMOV  V12.D[1], X4
    FMOV  D13, X9
    FMOV  V13.D[1], X19
    FMOV  D14, X13
    FMOV  V14.D[1], X6
    FMOV  D15, X19
    FMOV  V15.D[1], X18
    FMOV  D16, X17
    FMOV  V16.D[1], X21
    FMOV  D17, X18
    FMOV  V17.D[1], X2
    FMOV  D18, X14
    FMOV  V18.D[1], X7
    FMOV  D19, X7
    FMOV  V19.D[1], X4
    FMOV  D20, X11
    FMOV  V20.D[1], X12
    FMOV  D21, X8
    FMOV  V21.D[1], X8
    FMOV  D22, X22
    FMOV  V22.D[1], X18
    FMOV  D23, X11
    FMOV  V23.D[1], X14
    FMOV  D24, X15
    FMOV  V24.D[1], X5
    FMOV  D25, X21
    FMOV  V25.D[1], X8
    FMOV  D26, X11
    FMOV  V26.D[1], X11
    FMOV  D27, X3
    FMOV  V27.D[1], X11
    FMOV  D28, X29
    FMOV  V28.D[1], X18
    FMOV  D29, X12
    FMOV  V29.D[1], X11
    FMOV  D30, X11
    FMOV  V30.D[1], X6
    FMOV  D31, X9
    FMOV  V31.D[1], X22
    MOVZ  X16, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_4:
    FCVTMU  D0, D11
    FCVTZS  H4, H0
    FCVTAS  D24, D31
    FCVTMU  D25, D4
    FCVTZU  S28, S29
    FCVTPS  H26, H27
    FCVTPS  D19, D25
    FCVTAU  H21, H14
    FCVTMS  H23, H21
    FCVTMS  D6, D28
    FCVTNU  H11, H20
    FCVTMU  D4, D10
    FCVTPS  D25, D12
    FCVTNU  H26, H19
    FCVTZS  D14, D17
    FCVTNS  H16, H28
    FCVTAS  H11, H15
    FCVTMS  H14, H26
    FCVTNS  D4, D10
    FCVTZS H19, H24, #12
    FCVTZU  D15, D11
    FCVTZS D6, D16, #35
    FCVTXN  S26, D25
    FCVTNS  S0, S15
    FCVTZS  D21, D6
    FCVTZS H12, H2, #10
    FCVTZU  H2, H11
    FCVTZU  S16, S18
    FCVTPS  S24, S23
    FCVTZU S25, S29, #32
    FCVTZS  S29, S21
    FCVTNU  D18, D24
    FCVTNU  D11, D0
    FCVTZU S10, S29, #30
    FCVTZS S17, S18, #16
    FCVTAU  S23, S25
    FCVTNU  S10, S2
    FCVTNU  H26, H7
    FCVTAS  H20, H30
    FCVTZS D25, D26, #25
    FCVTXN  S7, D5
    FCVTZS S5, S18, #15
    FCVTMS  H26, H13
    FCVTZU  D15, D31
    FCVTPS  D14, D23
    FCVTAU  D18, D20
    FCVTPS  D24, D26
    FCVTNS  D26, D21
    FCVTMU  H31, H7
    FCVTPS  S2, S31
    FCVTZU  H20, H10
    FCVTAU  H13, H11
    FCVTZS  S31, S17
    FCVTAS  D24, D25
    FCVTZS D17, D2, #4
    FCVTZS  H23, H20
    FCVTMU  H11, H17
    FCVTMU  H20, H15
    FCVTZS D10, D5, #60
    FCVTZU S6, S17, #2
    FCVTZS S2, S13, #18
    FCVTNS  S0, S6
    FCVTZS D7, D23, #8
    FCVTAU  D31, D7
    FCVTMU  H7, H29
    FCVTMS  D15, D21
    FCVTNU  S4, S10
    FCVTNS  H9, H24
    FCVTPS  S13, S2
    FCVTMU  D25, D9
    FCVTAU  H6, H21
    FCVTPS  S24, S14
    FCVTAU  H23, H31
    FCVTPU  H10, H6
    FCVTPU  S5, S24
    FCVTAS  H17, H9
    FCVTAU  H2, H25
    FCVTPS  H14, H12
    FCVTZS S24, S23, #15
    FCVTZU  H31, H2
    FCVTNS  S25, S0
    FCVTPU  S29, S7
    FCVTZS D13, D4, #30
    FCVTPU  S0, S18
    FCVTZS  D4, D0
    FCVTZU  D7, D31
    FCVTMU  S23, S4
    FCVTMS  S2, S16
    FCVTNU  S0, S25
    FCVTNU  D31, D24
    FCVTPU  S31, S7
    FCVTNS  H16, H29
    FCVTPS  S29, S0
    FCVTPU  D7, D2
    FCVTAS  S4, S18
    FCVTNU  H24, H23
    FCVTNU  H25, H29
    FCVTMS  H21, H14
    FCVTMS  S12, S7
    FCVTPU  D0, D21
    FCVTAU  H7, H17
    FCVTPU  S17, S12
    FCVTZS  D29, D7
    FCVTZU  S12, S20
    FCVTMS  H20, H16
    FCVTZS S14, S20, #17
    FCVTAS  H2, H17
    FCVTAU  S20, S22
    FCVTNU  S18, S2
    FCVTNS  S9, S27
    FCVTXN  S7, D31
    FCVTAU  H31, H24
    FCVTPU  D21, D0
    FCVTPS  S21, S31
    FCVTAU  D17, D18
    FCVTPU  D31, D9
    FCVTPS  H16, H24
    FCVTZS H28, H25, #7
    FCVTMU  H23, H5
    FCVTMS  S18, S16
    FCVTZS H18, H7, #10
    FCVTMU  D7, D20
    FCVTMU  S0, S28
    FCVTPU  H5, H29
    FCVTZS H27, H5, #6
    FCVTNS  S22, S23
    FCVTMS  S16, S31
    FCVTZU S12, S22, #14
    FCVTPU  H31, H26
    FCVTAU  H1, H16
    FCVTAU  D16, D27
    FCVTNS  S26, S9
    FCVTNU  D22, D7
    FCVTAS  D14, D12
    FCVTMS  H23, H19
    FCVTNS  H19, H2
    FCVTMU  D20, D1
    FCVTPS  D14, D20
    FCVTZU  H7, H19
    FCVTAU  S12, S16
    FCVTZU  D29, D26
    FCVTZS S28, S22, #24
    FCVTAU  H1, H0
    FCVTPU  D19, D31
    FCVTZS D2, D23, #64
    FCVTPS  S24, S27
    FCVTAS  S31, S19
    FCVTZU D14, D14, #37
    FCVTZS  H23, H20
    FCVTAS  D19, D23
    FCVTZS  H10, H7
    FCVTMS  D25, D14
    FCVTZU  H15, H8
    FCVTNS  H22, H25
    FCVTZS  D0, D20
    FCVTNS  S14, S12
    FCVTNU  D25, D14
    FCVTNS  D20, D30
    FCVTZU  S27, S15
    FCVTZS  H12, H25
    FCVTPS  D25, D10
    FCVTZS H24, H24, #10
    FCVTPS  H16, H24
    FCVTZU S27, S5, #12
    FCVTZU  S30, S2
    FCVTAS  H15, H16
    FCVTZU H5, H29, #9
    FCVTNU  H8, H25
    FCVTNU  S7, S8
    FCVTMS  D29, D27
    FCVTNS  D14, D20
    FCVTAS  H2, H5
    FCVTZS  S8, S30
    FCVTAS  H26, H2
    FCVTNU  S16, S8
    FCVTAS  S16, S19
    FCVTZU  H30, H7
    FCVTZS  H7, H1
    FCVTAS  H6, H16
    FCVTNU  H15, H7
    FCVTZU S3, S31, #8
    FCVTZU H27, H30, #15
    FCVTZU D10, D29, #6
    FCVTZU S16, S3, #30
    FCVTNS  D27, D26
    FCVTZU  D19, D16
    FCVTAU  S31, S31
    FCVTAS  S24, S14
    FCVTZU D3, D31, #2
    FCVTPU  S30, S3
    FCVTMS  D3, D27
    FCVTAS  S30, S19
    FCVTAS  D0, D6
    FCVTZU  D1, D15
    FCVTZS  S23, S3
    FCVTAU  S22, S24
    FCVTAU  H6, H1
    FCVTZS  D3, D6
    FCVTZS  S16, S0
    FCVTZS H2, H23, #8
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_4
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X15, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X14, FPSR
    MOVZ  X15, #0x19, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X14, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x8f51, LSL #0
    MOVK  X2, #0xee84, LSL #16
    MOVK  X2, #0x6748, LSL #32
    MOVK  X2, #0x717e, LSL #48
    MOVZ  X3, #0xb2a6, LSL #0
    MOVK  X3, #0x4caf, LSL #16
    MOVK  X3, #0xda8, LSL #32
    MOVK  X3, #0xec1d, LSL #48
    MOVZ  X4, #0xe559, LSL #0
    MOVK  X4, #0x184e, LSL #16
    MOVK  X4, #0xaae7, LSL #32
    MOVK  X4, #0x8d03, LSL #48
    MOVZ  X5, #0x4bc1, LSL #0
    MOVK  X5, #0x20ff, LSL #16
    MOVK  X5, #0xefb, LSL #32
    MOVK  X5, #0xe7a6, LSL #48
    MOVZ  X6, #0x5c7a, LSL #0
    MOVK  X6, #0x47a1, LSL #16
    MOVK  X6, #0x841e, LSL #32
    MOVK  X6, #0xa898, LSL #48
    MOVZ  X7, #0x15d9, LSL #0
    MOVK  X7, #0x5aeb, LSL #16
    MOVK  X7, #0x8baa, LSL #32
    MOVK  X7, #0x1a50, LSL #48
    MOVZ  X8, #0x47d1, LSL #0
    MOVK  X8, #0x9a5, LSL #16
    MOVK  X8, #0xeb37, LSL #32
    MOVK  X8, #0x6806, LSL #48
    MOVZ  X9, #0xb125, LSL #0
    MOVK  X9, #0xbd03, LSL #16
    MOVK  X9, #0x1e03, LSL #32
    MOVK  X9, #0xda9d, LSL #48
    MOVZ  X10, #0xcc33, LSL #0
    MOVK  X10, #0x8123, LSL #16
    MOVK  X10, #0xe8b8, LSL #32
    MOVK  X10, #0x2e33, LSL #48
    MOVZ  X11, #0x1b03, LSL #0
    MOVK  X11, #0xc4a3, LSL #16
    MOVK  X11, #0x6ab9, LSL #32
    MOVK  X11, #0x4fef, LSL #48
    MOVZ  X12, #0xfaa5, LSL #0
    MOVK  X12, #0x8a9c, LSL #16
    MOVK  X12, #0xbca5, LSL #32
    MOVK  X12, #0xa287, LSL #48
    MOVZ  X13, #0x9ac6, LSL #0
    MOVK  X13, #0xf8b4, LSL #16
    MOVK  X13, #0xff2c, LSL #32
    MOVK  X13, #0xefc5, LSL #48
    MOVZ  X14, #0xd841, LSL #0
    MOVK  X14, #0x5a9a, LSL #16
    MOVK  X14, #0x364a, LSL #32
    MOVK  X14, #0x743d, LSL #48
    MOVZ  X15, #0x4440, LSL #0
    MOVK  X15, #0x1065, LSL #16
    MOVK  X15, #0x2a5d, LSL #32
    MOVK  X15, #0x43e2, LSL #48
    MOVZ  X16, #0x4793, LSL #0
    MOVK  X16, #0xd502, LSL #16
    MOVK  X16, #0xb074, LSL #32
    MOVK  X16, #0x3e00, LSL #48
    MOVZ  X17, #0x20b9, LSL #0
    MOVK  X17, #0x7981, LSL #16
    MOVK  X17, #0x5d55, LSL #32
    MOVK  X17, #0xad3d, LSL #48
    MOVZ  X18, #0x62a3, LSL #0
    MOVK  X18, #0x6909, LSL #16
    MOVK  X18, #0x30f7, LSL #32
    MOVK  X18, #0xa2b4, LSL #48
    MOVZ  X19, #0xea84, LSL #0
    MOVK  X19, #0x2853, LSL #16
    MOVK  X19, #0x4c57, LSL #32
    MOVK  X19, #0xe198, LSL #48
    MOVZ  X20, #0x154f, LSL #0
    MOVK  X20, #0x492, LSL #16
    MOVK  X20, #0x5dbe, LSL #32
    MOVK  X20, #0xae39, LSL #48
    MOVZ  X21, #0xb88a, LSL #0
    MOVK  X21, #0xd39a, LSL #16
    MOVK  X21, #0x74ea, LSL #32
    MOVK  X21, #0x7b7d, LSL #48
    MOVZ  X22, #0x3f0a, LSL #0
    MOVK  X22, #0xc68d, LSL #16
    MOVK  X22, #0xae70, LSL #32
    MOVK  X22, #0x80a, LSL #48
    MOVZ  X23, #0x8068, LSL #0
    MOVK  X23, #0xb64d, LSL #16
    MOVK  X23, #0xc308, LSL #32
    MOVK  X23, #0x6bf2, LSL #48
    MOVZ  X29, #0xfb9e, LSL #0
    MOVK  X29, #0x14b, LSL #16
    MOVK  X29, #0xd90c, LSL #32
    MOVK  X29, #0xe773, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X8
    FMOV  D1, X20
    FMOV  V1.D[1], X22
    FMOV  D2, X23
    FMOV  V2.D[1], X21
    FMOV  D3, X20
    FMOV  V3.D[1], X13
    FMOV  D4, X16
    FMOV  V4.D[1], X15
    FMOV  D5, X29
    FMOV  V5.D[1], X18
    FMOV  D6, X13
    FMOV  V6.D[1], X19
    FMOV  D7, X29
    FMOV  V7.D[1], X18
    FMOV  D8, X21
    FMOV  V8.D[1], X3
    FMOV  D9, X29
    FMOV  V9.D[1], X5
    FMOV  D10, X29
    FMOV  V10.D[1], X29
    FMOV  D11, X8
    FMOV  V11.D[1], X29
    FMOV  D12, X15
    FMOV  V12.D[1], X13
    FMOV  D13, X17
    FMOV  V13.D[1], X29
    FMOV  D14, X21
    FMOV  V14.D[1], X3
    FMOV  D15, X16
    FMOV  V15.D[1], X29
    FMOV  D16, X20
    FMOV  V16.D[1], X22
    FMOV  D17, X13
    FMOV  V17.D[1], X11
    FMOV  D18, X2
    FMOV  V18.D[1], X3
    FMOV  D19, X29
    FMOV  V19.D[1], X7
    FMOV  D20, X9
    FMOV  V20.D[1], X8
    FMOV  D21, X3
    FMOV  V21.D[1], X15
    FMOV  D22, X6
    FMOV  V22.D[1], X11
    FMOV  D23, X16
    FMOV  V23.D[1], X10
    FMOV  D24, X23
    FMOV  V24.D[1], X10
    FMOV  D25, X14
    FMOV  V25.D[1], X7
    FMOV  D26, X22
    FMOV  V26.D[1], X6
    FMOV  D27, X11
    FMOV  V27.D[1], X22
    FMOV  D28, X6
    FMOV  V28.D[1], X17
    FMOV  D29, X11
    FMOV  V29.D[1], X12
    FMOV  D30, X12
    FMOV  V30.D[1], X8
    FMOV  D31, X18
    FMOV  V31.D[1], X17
    MOVZ  X6, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_5:
    FCVTNU  S28, S29
    FCVTMS  D10, D23
    FCVTAU  H29, H31
    FCVTZU S31, S5, #17
    FCVTZS S2, S27, #17
    FCVTNU  H5, H4
    FCVTPS  H17, H11
    FCVTNU  H22, H5
    FCVTZS S0, S30, #18
    FCVTPU  H12, H22
    FCVTPU  D16, D10
    FCVTNU  S13, S2
    FCVTAS  H20, H29
    FCVTZU D9, D10, #6
    FCVTZS  S18, S31
    FCVTZU  S13, S18
    FCVTNU  S24, S28
    FCVTZU S16, S12, #2
    FCVTZS H11, H13, #2
    FCVTZS  H8, H13
    FCVTZS  H23, H17
    FCVTAU  S10, S12
    FCVTPS  D18, D24
    FCVTZU  S3, S10
    FCVTMS  H4, H14
    FCVTZS D11, D22, #56
    FCVTZS D22, D16, #60
    FCVTZU D17, D3, #60
    FCVTAS  D24, D0
    FCVTMS  H6, H11
    FCVTZU S8, S24, #10
    FCVTZS D13, D8, #9
    FCVTMS  H28, H20
    FCVTNS  S31, S7
    FCVTMS  H30, H21
    FCVTAS  H0, H2
    FCVTNS  S29, S9
    FCVTZU S21, S3, #16
    FCVTAS  D11, D22
    FCVTAU  H22, H18
    FCVTMS  S16, S6
    FCVTPU  H6, H18
    FCVTPS  S8, S23
    FCVTMS  S18, S31
    FCVTPU  H2, H22
    FCVTPS  S23, S13
    FCVTAU  S0, S2
    FCVTZS D3, D29, #54
    FCVTZU H13, H11, #5
    FCVTZS  D26, D0
    FCVTZS  S9, S17
    FCVTAS  D22, D8
    FCVTAS  S11, S28
    FCVTNU  D7, D21
    FCVTZS H17, H6, #14
    FCVTZU S0, S13, #10
    FCVTPU  D8, D17
    FCVTZU  H2, H9
    FCVTZS  S31, S5
    FCVTNU  S4, S16
    FCVTZU D16, D7, #54
    FCVTZU D20, D16, #18
    FCVTPU  D6, D6
    FCVTMU  D29, D22
    FCVTPS  H16, H2
    FCVTMS  D28, D20
    FCVTAS  S13, S27
    FCVTAS  H17, H29
    FCVTAU  D29, D17
    FCVTZU S5, S27, #32
    FCVTNS  S23, S4
    FCVTZU S27, S31, #19
    FCVTXN  S0, D16
    FCVTZS S11, S3, #25
    FCVTZU D17, D5, #39
    FCVTNS  D9, D8
    FCVTAS  S22, S27
    FCVTNS  D28, D22
    FCVTAU  D8, D22
    FCVTZS  H27, H13
    FCVTMU  H2, H0
    FCVTNU  S21, S28
    FCVTZS  D15, D28
    FCVTAU  H4, H11
    FCVTPU  H0, H8
    FCVTPS  H11, H15
    FCVTMU  D8, D23
    FCVTMS  D8, D21
    FCVTAS  S3, S23
    FCVTNS  S13, S3
    FCVTAS  S28, S27
    FCVTXN  S18, D13
    FCVTZU  S21, S8
    FCVTPS  H23, H2
    FCVTMS  H3, H28
    FCVTMS  S22, S11
    FCVTAU  S5, S3
    FCVTZU  D31, D14
    FCVTZU  S13, S23
    FCVTNS  D8, D13
    FCVTNU  D2, D9
    FCVTZS  H3, H8
    FCVTZU S28, S17, #6
    FCVTMU  D21, D2
    FCVTMS  H23, H22
    FCVTPU  D1, D21
    FCVTAS  S13, S23
    FCVTAS  D8, D3
    FCVTZS  H22, H31
    FCVTMU  S2, S18
    FCVTPU  D9, D28
    FCVTZS D11, D9, #54
    FCVTMS  S23, S15
    FCVTPS  H27, H1
    FCVTZS S15, S24, #16
    FCVTPU  S24, S20
    FCVTNS  D17, D23
    FCVTAU  S15, S27
    FCVTPS  H28, H15
    FCVTMU  H9, H24
    FCVTZS  D24, D22
    FCVTPU  S14, S9
    FCVTMS  D21, D28
    FCVTXN  S23, D3
    FCVTZU  H9, H5
    FCVTMS  D18, D11
    FCVTAS  D1, D9
    FCVTZU S3, S2, #18
    FCVTPU  S20, S18
    FCVTZS  D28, D14
    FCVTMU  D30, D21
    FCVTZS  H11, H17
    FCVTZS H9, H30, #15
    FCVTAU  D18, D11
    FCVTNU  S5, S23
    FCVTZS  H22, H9
    FCVTNU  H9, H13
    FCVTMU  D23, D18
    FCVTMU  H2, H9
    FCVTAU  D11, D1
    FCVTMU  D1, D28
    FCVTMS  D20, D2
    FCVTZU H18, H25, #11
    FCVTMU  D2, D9
    FCVTPU  S17, S5
    FCVTAU  S10, S11
    FCVTAS  H11, H18
    FCVTMS  D14, D1
    FCVTZS  D1, D12
    FCVTNU  H21, H1
    FCVTZS  D5, D12
    FCVTAS  S18, S22
    FCVTNS  S12, S9
    FCVTZS D11, D12, #8
    FCVTPU  H9, H2
    FCVTNU  H1, H9
    FCVTAU  H10, H17
    FCVTZS S4, S16, #2
    FCVTPU  D25, D10
    FCVTPU  S30, S23
    FCVTZS  D9, D1
    FCVTAS  S2, S21
    FCVTZU  H22, H14
    FCVTZS S28, S30, #15
    FCVTZS S13, S18, #3
    FCVTZU H18, H4, #4
    FCVTAS  S31, S2
    FCVTNS  D1, D8
    FCVTPS  D16, D13
    FCVTZU D5, D28, #27
    FCVTNU  D12, D20
    FCVTZU  D17, D18
    FCVTPU  D7, D11
    FCVTMU  D14, D12
    FCVTPU  D11, D8
    FCVTZU  S23, S17
    FCVTZS  D20, D8
    FCVTAS  H5, H14
    FCVTNS  S18, S5
    FCVTZU  H23, H31
    FCVTNU  H2, H7
    FCVTZU  H5, H2
    FCVTNS  D12, D25
    FCVTMS  S25, S18
    FCVTXN  S21, D22
    FCVTMS  S28, S3
    FCVTZU  H18, H25
    FCVTPU  S28, S18
    FCVTAU  H13, H23
    FCVTZS S17, S23, #4
    FCVTZU  S11, S17
    FCVTMS  D27, D31
    FCVTMS  D18, D16
    FCVTZS S9, S20, #24
    FCVTMS  H22, H28
    FCVTZU  S14, S24
    FCVTAU  H20, H18
    FCVTAS  H18, H27
    FCVTAS  H9, H13
    FCVTMS  S17, S30
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_5
    MOVZ  X10, #0x8f51, LSL #0
    MOVK  X10, #0xee84, LSL #16
    MOVK  X10, #0x6748, LSL #32
    MOVK  X10, #0x717e, LSL #48
    SUB  X23, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xb2a6, LSL #0
    MOVK  X10, #0x4caf, LSL #16
    MOVK  X10, #0xda8, LSL #32
    MOVK  X10, #0xec1d, LSL #48
    SUB  X23, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xe559, LSL #0
    MOVK  X10, #0x184e, LSL #16
    MOVK  X10, #0xaae7, LSL #32
    MOVK  X10, #0x8d03, LSL #48
    SUB  X23, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x4bc1, LSL #0
    MOVK  X10, #0x20ff, LSL #16
    MOVK  X10, #0xefb, LSL #32
    MOVK  X10, #0xe7a6, LSL #48
    SUB  X23, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x15d9, LSL #0
    MOVK  X10, #0x5aeb, LSL #16
    MOVK  X10, #0x8baa, LSL #32
    MOVK  X10, #0x1a50, LSL #48
    SUB  X23, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x47d1, LSL #0
    MOVK  X10, #0x9a5, LSL #16
    MOVK  X10, #0xeb37, LSL #32
    MOVK  X10, #0x6806, LSL #48
    SUB  X23, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xb125, LSL #0
    MOVK  X10, #0xbd03, LSL #16
    MOVK  X10, #0x1e03, LSL #32
    MOVK  X10, #0xda9d, LSL #48
    SUB  X23, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x1b03, LSL #0
    MOVK  X10, #0xc4a3, LSL #16
    MOVK  X10, #0x6ab9, LSL #32
    MOVK  X10, #0x4fef, LSL #48
    SUB  X23, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xfaa5, LSL #0
    MOVK  X10, #0x8a9c, LSL #16
    MOVK  X10, #0xbca5, LSL #32
    MOVK  X10, #0xa287, LSL #48
    SUB  X23, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x9ac6, LSL #0
    MOVK  X10, #0xf8b4, LSL #16
    MOVK  X10, #0xff2c, LSL #32
    MOVK  X10, #0xefc5, LSL #48
    SUB  X23, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x4440, LSL #0
    MOVK  X10, #0x1065, LSL #16
    MOVK  X10, #0x2a5d, LSL #32
    MOVK  X10, #0x43e2, LSL #48
    SUB  X23, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x4793, LSL #0
    MOVK  X10, #0xd502, LSL #16
    MOVK  X10, #0xb074, LSL #32
    MOVK  X10, #0x3e00, LSL #48
    SUB  X23, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x20b9, LSL #0
    MOVK  X10, #0x7981, LSL #16
    MOVK  X10, #0x5d55, LSL #32
    MOVK  X10, #0xad3d, LSL #48
    SUB  X23, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x62a3, LSL #0
    MOVK  X10, #0x6909, LSL #16
    MOVK  X10, #0x30f7, LSL #32
    MOVK  X10, #0xa2b4, LSL #48
    SUB  X23, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xea84, LSL #0
    MOVK  X10, #0x2853, LSL #16
    MOVK  X10, #0x4c57, LSL #32
    MOVK  X10, #0xe198, LSL #48
    SUB  X23, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x154f, LSL #0
    MOVK  X10, #0x492, LSL #16
    MOVK  X10, #0x5dbe, LSL #32
    MOVK  X10, #0xae39, LSL #48
    SUB  X23, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xb88a, LSL #0
    MOVK  X10, #0xd39a, LSL #16
    MOVK  X10, #0x74ea, LSL #32
    MOVK  X10, #0x7b7d, LSL #48
    SUB  X23, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x3f0a, LSL #0
    MOVK  X10, #0xc68d, LSL #16
    MOVK  X10, #0xae70, LSL #32
    MOVK  X10, #0x80a, LSL #48
    SUB  X23, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xfb9e, LSL #0
    MOVK  X10, #0x14b, LSL #16
    MOVK  X10, #0xd90c, LSL #32
    MOVK  X10, #0xe773, LSL #48
    SUB  X23, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X10, FPSR
    MOVZ  X23, #0x19, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D0
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D1
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D9
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D11
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X23, #0x15d9, LSL #0
    MOVK  X23, #0x5aeb, LSL #16
    MOVK  X23, #0x8baa, LSL #32
    MOVK  X23, #0x1a50, LSL #48
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D19
    MOVZ  X23, #0xfb9e, LSL #0
    MOVK  X23, #0x14b, LSL #16
    MOVK  X23, #0xd90c, LSL #32
    MOVK  X23, #0xe773, LSL #48
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D20
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D23
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D28
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D30
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X10, D31
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X13
    FMOV  D1, X17
    FMOV  V1.D[1], X4
    FMOV  D2, X19
    FMOV  V2.D[1], X21
    FMOV  D3, X23
    FMOV  V3.D[1], X7
    FMOV  D4, X15
    FMOV  V4.D[1], X15
    FMOV  D5, X22
    FMOV  V5.D[1], X18
    FMOV  D6, X29
    FMOV  V6.D[1], X20
    FMOV  D7, X15
    FMOV  V7.D[1], X15
    FMOV  D8, X16
    FMOV  V8.D[1], X12
    FMOV  D9, X14
    FMOV  V9.D[1], X9
    FMOV  D10, X19
    FMOV  V10.D[1], X3
    FMOV  D11, X22
    FMOV  V11.D[1], X23
    FMOV  D12, X3
    FMOV  V12.D[1], X9
    FMOV  D13, X21
    FMOV  V13.D[1], X10
    FMOV  D14, X22
    FMOV  V14.D[1], X22
    FMOV  D15, X5
    FMOV  V15.D[1], X8
    FMOV  D16, X18
    FMOV  V16.D[1], X6
    FMOV  D17, X9
    FMOV  V17.D[1], X11
    FMOV  D18, X20
    FMOV  V18.D[1], X29
    FMOV  D19, X9
    FMOV  V19.D[1], X29
    FMOV  D20, X16
    FMOV  V20.D[1], X20
    FMOV  D21, X17
    FMOV  V21.D[1], X8
    FMOV  D22, X11
    FMOV  V22.D[1], X11
    FMOV  D23, X9
    FMOV  V23.D[1], X22
    FMOV  D24, X4
    FMOV  V24.D[1], X15
    FMOV  D25, X10
    FMOV  V25.D[1], X29
    FMOV  D26, X18
    FMOV  V26.D[1], X13
    FMOV  D27, X8
    FMOV  V27.D[1], X14
    FMOV  D28, X9
    FMOV  V28.D[1], X15
    FMOV  D29, X15
    FMOV  V29.D[1], X18
    FMOV  D30, X15
    FMOV  V30.D[1], X4
    FMOV  D31, X23
    FMOV  V31.D[1], X14
    MOVZ  X8, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_6:
    FCVTPS  S16, S26
    FCVTAS  H11, H13
    FCVTAS  S5, S19
    FCVTNS  H14, H30
    FCVTZS S26, S22, #18
    FCVTXN  S24, D26
    FCVTNS  S18, S14
    FCVTZS  D31, D21
    FCVTAS  D16, D28
    FCVTZS  S5, S30
    FCVTAS  D4, D5
    FCVTNS  S11, S4
    FCVTPS  H23, H11
    FCVTZS S30, S5, #2
    FCVTZS  H4, H23
    FCVTMS  D16, D18
    FCVTPU  S31, S16
    FCVTAU  S17, S24
    FCVTNS  H8, H30
    FCVTPS  D24, D17
    FCVTPU  S1, S24
    FCVTZS  H5, H11
    FCVTZS  D22, D5
    FCVTZS S5, S7, #16
    FCVTMS  D24, D19
    FCVTZS S14, S31, #26
    FCVTZS  D30, D1
    FCVTPS  H31, H24
    FCVTZU  S24, S8
    FCVTPS  H1, H25
    FCVTZU  D11, D1
    FCVTMS  D16, D4
    FCVTMU  S19, S14
    FCVTPS  D31, D11
    FCVTAU  S1, S16
    FCVTZS  D6, D10
    FCVTAU  D7, D6
    FCVTMS  D10, D1
    FCVTAU  H11, H22
    FCVTAU  D9, D24
    FCVTPS  H1, H27
    FCVTZS  D27, D9
    FCVTPU  H18, H25
    FCVTPU  H22, H11
    FCVTPU  H16, H19
    FCVTPS  D14, D9
    FCVTXN  S1, D14
    FCVTZU D22, D15, #60
    FCVTZS  H15, H10
    FCVTNS  D11, D7
    FCVTPS  H4, H22
    FCVTZS  S15, S8
    FCVTZU  D6, D27
    FCVTPU  S27, S4
    FCVTNS  D26, D15
    FCVTPU  D24, D1
    FCVTNS  D14, D12
    FCVTAU  D25, D18
    FCVTMS  H4, H27
    FCVTMS  H18, H8
    FCVTAS  S7, S18
    FCVTMS  S10, S0
    FCVTXN  S1, D7
    FCVTNU  H21, H13
    FCVTAS  H15, H26
    FCVTZU S9, S14, #7
    FCVTAU  D7, D21
    FCVTPS  D21, D11
    FCVTNU  H11, H6
    FCVTPU  S6, S25
    FCVTZU H27, H1, #6
    FCVTZU H8, H4, #14
    FCVTPU  S13, S22
    FCVTPS  D6, D27
    FCVTZS S26, S6, #9
    FCVTAS  S4, S24
    FCVTAS  S0, S17
    FCVTPU  D20, D15
    FCVTPU  S1, S20
    FCVTMU  D15, D26
    FCVTZU D27, D21, #13
    FCVTMU  H20, H15
    FCVTZS H6, H4, #4
    FCVTZS H24, H23, #6
    FCVTMS  H10, H8
    FCVTPU  H14, H6
    FCVTMU  D21, D9
    FCVTAS  H23, H11
    FCVTZU S4, S17, #23
    FCVTPS  D11, D14
    FCVTZU S22, S13, #14
    FCVTZU D8, D6, #2
    FCVTAU  H26, H24
    FCVTAU  S15, S23
    FCVTZS  D17, D22
    FCVTPS  D26, D8
    FCVTPS  D9, D17
    FCVTZU S22, S4, #28
    FCVTNS  H31, H0
    FCVTAU  D7, D21
    FCVTNS  H8, H22
    FCVTMU  S0, S8
    FCVTMS  H30, H15
    FCVTZS D21, D31, #7
    FCVTMS  D16, D1
    FCVTMU  H22, H30
    FCVTMU  H31, H20
    FCVTAU  S13, S17
    FCVTNU  D7, D16
    FCVTMU  D16, D22
    FCVTZU  H0, H0
    FCVTMS  D30, D15
    FCVTZS D15, D7, #8
    FCVTMU  D25, D31
    FCVTPS  S2, S15
    FCVTNU  S15, S13
    FCVTAU  D22, D2
    FCVTPU  S13, S0
    FCVTZS  S22, S26
    FCVTXN  S0, D22
    FCVTAU  S2, S21
    FCVTMU  S21, S9
    FCVTNU  S1, S22
    FCVTPS  D7, D0
    FCVTMS  S16, S30
    FCVTPU  D31, D25
    FCVTNU  D4, D21
    FCVTAU  S0, S3
    FCVTPU  S30, S14
    FCVTMS  D30, D0
    FCVTNS  H20, H31
    FCVTAU  D8, D7
    FCVTPS  H31, H2
    FCVTZS H25, H15, #8
    FCVTZS  S15, S30
    FCVTAU  H3, H1
    FCVTMU  H0, H25
    FCVTZS  S18, S31
    FCVTZS  D26, D0
    FCVTXN  S2, D9
    FCVTAS  D31, D2
    FCVTNS  H30, H18
    FCVTNS  H22, H8
    FCVTZS  H31, H10
    FCVTAU  S0, S22
    FCVTMU  D14, D20
    FCVTZU  D10, D26
    FCVTZS D29, D30, #61
    FCVTZS H8, H15, #5
    FCVTZS S3, S14, #28
    FCVTZS  D18, D25
    FCVTZS D9, D10, #44
    FCVTMS  S21, S31
    FCVTXN  S2, D29
    FCVTZS D26, D8, #59
    FCVTZS H30, H2, #5
    FCVTAU  H15, H18
    FCVTZU  H1, H9
    FCVTNS  H18, H22
    FCVTAS  H22, H27
    FCVTZU  D31, D9
    FCVTMS  D8, D13
    FCVTZU H25, H26, #2
    FCVTZS S2, S8, #32
    FCVTNS  S29, S0
    FCVTNU  D10, D31
    FCVTAS  D0, D25
    FCVTAS  S9, S0
    FCVTNS  D14, D21
    FCVTZU  S21, S10
    FCVTAS  D25, D18
    FCVTZS  H18, H1
    FCVTAU  H0, H22
    FCVTAU  S20, S14
    FCVTMU  S13, S18
    FCVTZU  S22, S15
    FCVTMU  S20, S13
    FCVTXN  S18, D29
    FCVTNU  S1, S9
    FCVTAU  D29, D2
    FCVTNU  S14, S20
    FCVTZU S27, S12, #18
    FCVTZU S13, S14, #25
    FCVTNU  H12, H1
    FCVTMU  S26, S22
    FCVTZS  H31, H23
    FCVTZS  H22, H31
    FCVTMS  S14, S26
    FCVTZS  S15, S25
    FCVTNS  H10, H0
    FCVTMU  D25, D13
    FCVTNU  D9, D10
    FCVTZU D0, D14, #16
    FCVTPS  D25, D29
    FCVTMU  D20, D15
    FCVTAU  D15, D25
    FCVTPU  H29, H9
    FCVTNU  D23, D12
    FCVTZS S14, S20, #8
    FCVTMU  S31, S29
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_6
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X15, FPSR
    MOVZ  X9, #0x19, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X22
    FMOV  D1, X20
    FMOV  V1.D[1], X12
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X7
    FMOV  V3.D[1], X29
    FMOV  D4, X12
    FMOV  V4.D[1], X6
    FMOV  D5, X29
    FMOV  V5.D[1], X14
    FMOV  D6, X15
    FMOV  V6.D[1], X4
    FMOV  D7, X6
    FMOV  V7.D[1], X20
    FMOV  D8, X23
    FMOV  V8.D[1], X13
    FMOV  D9, X4
    FMOV  V9.D[1], X18
    FMOV  D10, X15
    FMOV  V10.D[1], X20
    FMOV  D11, X10
    FMOV  V11.D[1], X8
    FMOV  D12, X19
    FMOV  V12.D[1], X8
    FMOV  D13, X4
    FMOV  V13.D[1], X7
    FMOV  D14, X29
    FMOV  V14.D[1], X18
    FMOV  D15, X5
    FMOV  V15.D[1], X20
    FMOV  D16, X29
    FMOV  V16.D[1], X12
    FMOV  D17, X15
    FMOV  V17.D[1], X6
    FMOV  D18, X15
    FMOV  V18.D[1], X8
    FMOV  D19, X11
    FMOV  V19.D[1], X11
    FMOV  D20, X3
    FMOV  V20.D[1], X20
    FMOV  D21, X15
    FMOV  V21.D[1], X2
    FMOV  D22, X6
    FMOV  V22.D[1], X7
    FMOV  D23, X11
    FMOV  V23.D[1], X20
    FMOV  D24, X5
    FMOV  V24.D[1], X16
    FMOV  D25, X8
    FMOV  V25.D[1], X8
    FMOV  D26, X19
    FMOV  V26.D[1], X6
    FMOV  D27, X11
    FMOV  V27.D[1], X11
    FMOV  D28, X22
    FMOV  V28.D[1], X12
    FMOV  D29, X19
    FMOV  V29.D[1], X12
    FMOV  D30, X11
    FMOV  V30.D[1], X18
    FMOV  D31, X5
    FMOV  V31.D[1], X9
    MOVZ  X3, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_7:
    FCVTNU  S7, S0
    FCVTMU  S9, S23
    FCVTMU  H12, H25
    FCVTMS  S26, S24
    FCVTZS S10, S0, #2
    FCVTZS S29, S10, #14
    FCVTXN  S8, D25
    FCVTAS  H13, H9
    FCVTAU  S21, S30
    FCVTPU  H3, H21
    FCVTZU  D5, D31
    FCVTPU  D18, D27
    FCVTAU  D10, D13
    FCVTZS  D17, D17
    FCVTPS  S9, S3
    FCVTZS D31, D8, #33
    FCVTZS  D26, D13
    FCVTNS  D19, D5
    FCVTPU  H12, H12
    FCVTAS  D29, D14
    FCVTZU H21, H9, #12
    FCVTZU S8, S28, #9
    FCVTNS  S29, S11
    FCVTMU  H6, H29
    FCVTZU  H30, H17
    FCVTPS  S5, S19
    FCVTMU  H19, H10
    FCVTMS  H18, H29
    FCVTAU  D29, D6
    FCVTAS  S13, S31
    FCVTAU  S10, S26
    FCVTPS  S23, S8
    FCVTZU  D2, D5
    FCVTZS  H28, H12
    FCVTXN  S26, D19
    FCVTMU  D14, D20
    FCVTZS S19, S23, #7
    FCVTPU  H8, H2
    FCVTZS  S5, S19
    FCVTNS  H19, H14
    FCVTNU  D11, D5
    FCVTAS  H12, H26
    FCVTPS  S23, S28
    FCVTAS  D17, D19
    FCVTZS H31, H29, #15
    FCVTAS  D6, D30
    FCVTAS  H2, H12
    FCVTZU S12, S13, #32
    FCVTAU  H13, H21
    FCVTAS  D26, D17
    FCVTZS S20, S31, #3
    FCVTNS  H21, H8
    FCVTAU  H30, H13
    FCVTZU  S14, S6
    FCVTZU S28, S2, #19
    FCVTMS  D8, D28
    FCVTAU  D17, D30
    FCVTPU  S9, S11
    FCVTNU  D11, D31
    FCVTMU  S31, S8
    FCVTPS  S28, S21
    FCVTNS  S15, S28
    FCVTAS  H19, H20
    FCVTAU  S2, S23
    FCVTZU  D29, D17
    FCVTPS  H5, H20
    FCVTAU  H10, H14
    FCVTNU  D20, D11
    FCVTMS  D11, D5
    FCVTMU  S14, S10
    FCVTZS S8, S19, #10
    FCVTPS  D28, D23
    FCVTPS  S5, S14
    FCVTPU  S23, S25
    FCVTXN  S19, D2
    FCVTMU  S17, S28
    FCVTZS  D28, D20
    FCVTZU  D2, D25
    FCVTPU  S19, S11
    FCVTZU S13, S8, #5
    FCVTNU  D6, D9
    FCVTMU  H11, H31
    FCVTZS  H23, H2
    FCVTZU H21, H15, #7
    FCVTAS  H14, H21
    FCVTPU  S2, S28
    FCVTPS  S15, S2
    FCVTZS  D2, D11
    FCVTZS S28, S15, #10
    FCVTNS  H11, H14
    FCVTPU  H20, H5
    FCVTPU  D22, D19
    FCVTAS  D27, D29
    FCVTMS  H19, H17
    FCVTXN  S10, D2
    FCVTZS D23, D6, #7
    FCVTAS  H31, H27
    FCVTNU  S29, S20
    FCVTZS  S18, S1
    FCVTMS  D8, D19
    FCVTMU  D18, D18
    FCVTPS  D20, D11
    FCVTZS  D27, D1
    FCVTZU D31, D20, #40
    FCVTZU D20, D5, #20
    FCVTNU  H1, H27
    FCVTNS  S5, S29
    FCVTMS  S27, S20
    FCVTZU D11, D10, #51
    FCVTAU  H6, H4
    FCVTPS  S2, S8
    FCVTMS  S17, S28
    FCVTNU  D29, D1
    FCVTNU  H20, H31
    FCVTAU  S8, S23
    FCVTZS D10, D10, #64
    FCVTAS  S1, S31
    FCVTPU  S26, S22
    FCVTMU  H7, H11
    FCVTZU D28, D18, #53
    FCVTNU  S4, S10
    FCVTPS  S27, S17
    FCVTNS  D18, D7
    FCVTAS  S22, S17
    FCVTNU  H25, H22
    FCVTAU  S17, S28
    FCVTMU  S23, S26
    FCVTPU  H22, H23
    FCVTZS S10, S2, #10
    FCVTZU  D19, D1
    FCVTAU  D15, D27
    FCVTZS S26, S25, #17
    FCVTAU  S2, S4
    FCVTZS D23, D22, #33
    FCVTPU  S27, S5
    FCVTNU  D23, D29
    FCVTAS  D30, D5
    FCVTMS  D1, D18
    FCVTMS  S4, S17
    FCVTNS  S29, S2
    FCVTPU  H2, H10
    FCVTZU S15, S17, #14
    FCVTZS H25, H26, #8
    FCVTZU  H15, H30
    FCVTNU  D28, D2
    FCVTMU  H5, H29
    FCVTMS  H11, H28
    FCVTMU  H0, H19
    FCVTMU  S13, S9
    FCVTZU D15, D27, #4
    FCVTNS  H7, H4
    FCVTZS D23, D4, #25
    FCVTMS  S4, S0
    FCVTXN  S19, D19
    FCVTNU  S2, S15
    FCVTAU  S20, S18
    FCVTMU  D28, D20
    FCVTAU  H22, H28
    FCVTMU  D26, D14
    FCVTNS  H14, H25
    FCVTNS  H9, H11
    FCVTAU  S0, S2
    FCVTNU  S2, S4
    FCVTAS  H17, H23
    FCVTMS  H20, H5
    FCVTZS D27, D19, #59
    FCVTXN  S18, D2
    FCVTZU  D10, D20
    FCVTNU  D5, D29
    FCVTAS  D10, D21
    FCVTAS  S25, S9
    FCVTNU  D21, D0
    FCVTNS  H23, H22
    FCVTMS  H31, H10
    FCVTNS  D11, D23
    FCVTAS  S20, S26
    FCVTPS  H19, H25
    FCVTPU  S31, S18
    FCVTNS  H25, H17
    FCVTMU  D23, D14
    FCVTAU  D11, D5
    FCVTMU  D12, D20
    FCVTZU D17, D8, #35
    FCVTPS  H10, H11
    FCVTMU  H26, H21
    FCVTZS  H12, H17
    FCVTZS S29, S12, #2
    FCVTMU  S26, S25
    FCVTZU H17, H26, #6
    FCVTZS D5, D19, #5
    FCVTZU H9, H23, #13
    FCVTPS  S8, S1
    FCVTMU  D21, D8
    FCVTPS  H18, H31
    FCVTZS H26, H27, #10
    FCVTNU  S13, S10
    FCVTMU  S10, S21
    FCVTPU  S11, S29
    FCVTMU  H21, H0
    FCVTAS  S31, S18
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_7
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X16, FPSR
    MOVZ  X13, #0x19, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D16
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D24
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X16, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  D0, X17
    FMOV  V0.D[1], X29
    FMOV  D1, X8
    FMOV  V1.D[1], X21
    FMOV  D2, X16
    FMOV  V2.D[1], X23
    FMOV  D3, X16
    FMOV  V3.D[1], X23
    FMOV  D4, X3
    FMOV  V4.D[1], X5
    FMOV  D5, X22
    FMOV  V5.D[1], X13
    FMOV  D6, X19
    FMOV  V6.D[1], X16
    FMOV  D7, X4
    FMOV  V7.D[1], X8
    FMOV  D8, X21
    FMOV  V8.D[1], X8
    FMOV  D9, X8
    FMOV  V9.D[1], X10
    FMOV  D10, X2
    FMOV  V10.D[1], X15
    FMOV  D11, X12
    FMOV  V11.D[1], X22
    FMOV  D12, X29
    FMOV  V12.D[1], X6
    FMOV  D13, X22
    FMOV  V13.D[1], X20
    FMOV  D14, X21
    FMOV  V14.D[1], X5
    FMOV  D15, X17
    FMOV  V15.D[1], X16
    FMOV  D16, X22
    FMOV  V16.D[1], X22
    FMOV  D17, X5
    FMOV  V17.D[1], X8
    FMOV  D18, X6
    FMOV  V18.D[1], X18
    FMOV  D19, X10
    FMOV  V19.D[1], X16
    FMOV  D20, X14
    FMOV  V20.D[1], X20
    FMOV  D21, X23
    FMOV  V21.D[1], X20
    FMOV  D22, X29
    FMOV  V22.D[1], X21
    FMOV  D23, X23
    FMOV  V23.D[1], X2
    FMOV  D24, X6
    FMOV  V24.D[1], X11
    FMOV  D25, X3
    FMOV  V25.D[1], X8
    FMOV  D26, X15
    FMOV  V26.D[1], X14
    FMOV  D27, X14
    FMOV  V27.D[1], X13
    FMOV  D28, X13
    FMOV  V28.D[1], X7
    FMOV  D29, X8
    FMOV  V29.D[1], X14
    FMOV  D30, X22
    FMOV  V30.D[1], X12
    FMOV  D31, X8
    FMOV  V31.D[1], X21
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_8:
    FCVTMS  S24, S30
    FCVTMU  D17, D27
    FCVTPS  H12, H26
    FCVTZS D11, D24, #29
    FCVTZS S25, S12, #7
    FCVTZS  H30, H25
    FCVTZU H19, H17, #4
    FCVTXN  S24, D11
    FCVTPS  H19, H10
    FCVTZS  D18, D28
    FCVTMS  S15, S29
    FCVTMU  S6, S6
    FCVTAU  D28, D23
    FCVTAS  H17, H21
    FCVTNS  S12, S18
    FCVTPU  D26, D31
    FCVTAS  S25, S8
    FCVTAU  S21, S24
    FCVTZU D8, D24, #57
    FCVTPU  S24, S14
    FCVTPU  D0, D6
    FCVTZS D10, D15, #40
    FCVTZU S20, S24, #18
    FCVTZU D14, D30, #8
    FCVTAU  S5, S14
    FCVTMS  D12, D28
    FCVTMU  H20, H5
    FCVTZS  H23, H4
    FCVTNS  H12, H25
    FCVTZS  H25, H23
    FCVTZU S5, S30, #9
    FCVTZS S19, S20, #13
    FCVTNS  D28, D15
    FCVTZU S24, S0, #1
    FCVTZS S0, S19, #8
    FCVTPU  D15, D0
    FCVTMU  D11, D15
    FCVTMU  D20, D8
    FCVTNU  S4, S5
    FCVTAU  S19, S20
    FCVTPS  D8, D4
    FCVTZU  H20, H11
    FCVTZS  D7, D6
    FCVTPU  D23, D19
    FCVTZU H6, H12, #13
    FCVTZU S30, S25, #17
    FCVTPS  D0, D7
    FCVTPU  D5, D20
    FCVTNS  D11, D31
    FCVTAS  S12, S23
    FCVTAU  H15, H4
    FCVTAU  H2, H30
    FCVTZU  H23, H19
    FCVTAS  S30, S15
    FCVTMU  H4, H2
    FCVTAU  D1, D0
    FCVTAS  H31, H5
    FCVTZS H20, H11, #11
    FCVTPU  S7, S20
    FCVTAS  D20, D1
    FCVTAU  H2, H31
    FCVTZS  D1, D22
    FCVTPS  D0, D6
    FCVTAS  D11, D3
    FCVTMU  S22, S4
    FCVTPU  H9, H6
    FCVTMU  S4, S1
    FCVTZS D6, D12, #28
    FCVTZS  H29, H7
    FCVTZS S12, S8, #25
    FCVTMU  D19, D20
    FCVTAU  D4, D2
    FCVTPS  S3, S22
    FCVTNU  D7, D2
    FCVTPU  S2, S9
    FCVTMU  S1, S7
    FCVTMS  D2, D5
    FCVTPU  H9, H13
    FCVTNS  D13, D1
    FCVTNU  S31, S0
    FCVTZS  S8, S29
    FCVTAU  S29, S2
    FCVTNU  H7, H9
    FCVTZU H22, H19, #14
    FCVTAS  H26, H17
    FCVTZS D1, D4, #27
    FCVTMU  S5, S11
    FCVTZS  D13, D5
    FCVTNU  S17, S12
    FCVTPS  H3, H26
    FCVTZS D0, D13, #37
    FCVTZS  H11, H1
    FCVTMS  H21, H8
    FCVTZS D9, D27, #55
    FCVTZS  H4, H9
    FCVTZS  H5, H31
    FCVTZS H10, H11, #6
    FCVTMS  H28, H0
    FCVTPS  D2, D10
    FCVTMU  H31, H20
    FCVTZU  S19, S29
    FCVTXN  S20, D19
    FCVTZU  S27, S20
    FCVTMU  D20, D27
    FCVTXN  S23, D9
    FCVTZS H9, H3, #11
    FCVTNU  D27, D5
    FCVTPS  D19, D30
    FCVTAU  H11, H31
    FCVTAU  H5, H7
    FCVTMS  H17, H5
    FCVTZS  H3, H6
    FCVTNU  H10, H3
    FCVTZS H28, H23, #6
    FCVTAS  H7, H20
    FCVTMS  D0, D17
    FCVTZS  H11, H2
    FCVTPS  H6, H28
    FCVTAU  D13, D27
    FCVTNU  H5, H10
    FCVTNU  S9, S12
    FCVTZS H17, H22, #1
    FCVTZS  H1, H0
    FCVTZU  D31, D9
    FCVTAU  S30, S11
    FCVTAU  S28, S1
    FCVTNU  D3, D30
    FCVTMS  D29, D31
    FCVTNU  S21, S28
    FCVTAU  D22, D5
    FCVTNS  S23, S15
    FCVTMU  D28, D19
    FCVTAU  D5, D28
    FCVTMU  D0, D9
    FCVTPS  D15, D22
    FCVTPS  D10, D29
    FCVTZS H20, H21, #7
    FCVTMS  S28, S11
    FCVTPU  S29, S23
    FCVTMS  S12, S20
    FCVTAU  H23, H0
    FCVTAU  S11, S29
    FCVTZU  D0, D17
    FCVTPU  H22, H6
    FCVTZU  H31, H3
    FCVTZU D2, D4, #42
    FCVTPS  S29, S31
    FCVTZU  S4, S15
    FCVTPU  S30, S5
    FCVTAU  S26, S4
    FCVTPS  S9, S15
    FCVTMU  S16, S28
    FCVTXN  S5, D10
    FCVTAU  S5, S30
    FCVTNU  H6, H29
    FCVTNU  H31, H20
    FCVTNS  D30, D2
    FCVTXN  S10, D0
    FCVTZS D20, D31, #43
    FCVTAU  H17, H1
    FCVTNU  S3, S0
    FCVTZU D4, D11, #44
    FCVTZS  D2, D5
    FCVTPS  D31, D6
    FCVTPS  H1, H30
    FCVTMS  S0, S2
    FCVTZS  D15, D9
    FCVTZU S9, S27, #11
    FCVTAS  S10, S23
    FCVTMU  D12, D9
    FCVTNU  H9, H31
    FCVTPS  S4, S12
    FCVTNS  H6, H17
    FCVTAU  H19, H1
    FCVTXN  S2, D29
    FCVTPU  H27, H4
    FCVTPU  S23, S16
    FCVTPS  H16, H10
    FCVTMS  D4, D16
    FCVTAU  S5, S10
    FCVTAU  H17, H3
    FCVTZU H31, H1, #8
    FCVTZU H3, H19, #8
    FCVTMS  D29, D5
    FCVTNS  S22, S6
    FCVTZS  H6, H31
    FCVTPS  S10, S4
    FCVTZU  D12, D22
    FCVTZU  D5, D17
    FCVTZU  S1, S25
    FCVTMU  D19, D2
    FCVTNS  H17, H0
    FCVTZS  H6, H6
    FCVTZU S31, S3, #15
    FCVTAU  D14, D10
    FCVTMS  H28, H14
    FCVTZS D0, D30, #10
    FCVTZU H6, H19, #8
    FCVTAS  D16, D6
    FCVTXN  S25, D12
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_8
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X22, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X6, FPSR
    MOVZ  X22, #0x19, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D1
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D22
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D30
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X6, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X10
    FMOV  D1, X23
    FMOV  V1.D[1], X20
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X13
    FMOV  V3.D[1], X16
    FMOV  D4, X9
    FMOV  V4.D[1], X8
    FMOV  D5, X3
    FMOV  V5.D[1], X18
    FMOV  D6, X3
    FMOV  V6.D[1], X15
    FMOV  D7, X12
    FMOV  V7.D[1], X3
    FMOV  D8, X22
    FMOV  V8.D[1], X6
    FMOV  D9, X5
    FMOV  V9.D[1], X5
    FMOV  D10, X13
    FMOV  V10.D[1], X21
    FMOV  D11, X19
    FMOV  V11.D[1], X17
    FMOV  D12, X8
    FMOV  V12.D[1], X6
    FMOV  D13, X2
    FMOV  V13.D[1], X12
    FMOV  D14, X16
    FMOV  V14.D[1], X9
    FMOV  D15, X18
    FMOV  V15.D[1], X5
    FMOV  D16, X17
    FMOV  V16.D[1], X19
    FMOV  D17, X8
    FMOV  V17.D[1], X23
    FMOV  D18, X5
    FMOV  V18.D[1], X9
    FMOV  D19, X15
    FMOV  V19.D[1], X14
    FMOV  D20, X17
    FMOV  V20.D[1], X16
    FMOV  D21, X20
    FMOV  V21.D[1], X6
    FMOV  D22, X10
    FMOV  V22.D[1], X11
    FMOV  D23, X6
    FMOV  V23.D[1], X8
    FMOV  D24, X15
    FMOV  V24.D[1], X14
    FMOV  D25, X15
    FMOV  V25.D[1], X9
    FMOV  D26, X2
    FMOV  V26.D[1], X8
    FMOV  D27, X17
    FMOV  V27.D[1], X4
    FMOV  D28, X20
    FMOV  V28.D[1], X9
    FMOV  D29, X12
    FMOV  V29.D[1], X15
    FMOV  D30, X2
    FMOV  V30.D[1], X22
    FMOV  D31, X29
    FMOV  V31.D[1], X2
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_9:
    FCVTXN  S16, D24
    FCVTAU  S16, S26
    FCVTNU  S13, S27
    FCVTPU  H22, H13
    FCVTMU  H13, H25
    FCVTPU  S23, S22
    FCVTPU  S16, S29
    FCVTPS  S2, S28
    FCVTNU  H2, H31
    FCVTZU S25, S25, #32
    FCVTZU S27, S21, #19
    FCVTMS  D2, D25
    FCVTPS  D5, D27
    FCVTPS  S16, S20
    FCVTAU  H15, H13
    FCVTZU S18, S2, #6
    FCVTZS S8, S23, #19
    FCVTAU  S12, S16
    FCVTPS  D24, D12
    FCVTNU  D22, D5
    FCVTXN  S31, D8
    FCVTPS  D27, D24
    FCVTZS D13, D0, #17
    FCVTAU  H12, H31
    FCVTXN  S4, D21
    FCVTXN  S21, D12
    FCVTZU S25, S22, #23
    FCVTZS H22, H20, #15
    FCVTAU  H16, H30
    FCVTZU D30, D22, #7
    FCVTXN  S30, D7
    FCVTNU  H0, H13
    FCVTPS  H28, H18
    FCVTNU  S18, S6
    FCVTPU  D7, D2
    FCVTZS  D23, D25
    FCVTPU  H8, H15
    FCVTZU  S6, S4
    FCVTPU  S11, S21
    FCVTZS  H5, H4
    FCVTMU  S25, S12
    FCVTZS D5, D25, #16
    FCVTNS  D11, D6
    FCVTNU  H15, H0
    FCVTPU  S24, S23
    FCVTMU  D23, D7
    FCVTPS  D0, D8
    FCVTNU  D25, D31
    FCVTMS  S31, S11
    FCVTNU  H6, H5
    FCVTZS D5, D0, #25
    FCVTNU  S12, S31
    FCVTNU  S7, S24
    FCVTAU  S21, S18
    FCVTNS  S2, S23
    FCVTNU  D24, D15
    FCVTNS  D11, D21
    FCVTAS  H8, H30
    FCVTMU  H30, H24
    FCVTMS  S10, S8
    FCVTPS  S21, S10
    FCVTMU  S18, S14
    FCVTZU  H10, H15
    FCVTAU  D26, D25
    FCVTAU  S17, S7
    FCVTMU  H0, H25
    FCVTMU  H8, H6
    FCVTNU  H31, H17
    FCVTNU  H15, H12
    FCVTMU  S23, S18
    FCVTNS  D12, D11
    FCVTMS  D7, D21
    FCVTZS H2, H5, #10
    FCVTMU  H17, H30
    FCVTNU  S14, S26
    FCVTAS  D24, D2
    FCVTNU  D5, D23
    FCVTMU  H1, H17
    FCVTPS  H6, H1
    FCVTAU  H25, H15
    FCVTZU  H17, H8
    FCVTZS H2, H25, #7
    FCVTZU  S30, S6
    FCVTNU  H25, H0
    FCVTZU D11, D31, #16
    FCVTZU D18, D24, #9
    FCVTNU  D0, D27
    FCVTZS  D10, D3
    FCVTNS  S31, S1
    FCVTPU  D23, D2
    FCVTZU  H2, H18
    FCVTZU D6, D7, #49
    FCVTMS  H30, H15
    FCVTPU  D8, D12
    FCVTNU  D3, D31
    FCVTMU  D1, D3
    FCVTMU  S31, S5
    FCVTZU  S17, S5
    FCVTZU  H12, H0
    FCVTMS  S27, S14
    FCVTNS  D15, D27
    FCVTNU  H22, H21
    FCVTNU  S27, S17
    FCVTNS  H5, H12
    FCVTAU  S17, S23
    FCVTMS  D5, D12
    FCVTNS  S14, S8
    FCVTNU  D18, D30
    FCVTZS S24, S31, #4
    FCVTZS H31, H2, #15
    FCVTPS  H30, H12
    FCVTXN  S0, D27
    FCVTAU  D27, D17
    FCVTZU  D12, D6
    FCVTPU  H21, H25
    FCVTZS  H18, H1
    FCVTZS  D17, D27
    FCVTPU  H8, H10
    FCVTZU  S1, S5
    FCVTNS  S27, S25
    FCVTAU  D11, D31
    FCVTZS  S25, S0
    FCVTAU  D5, D15
    FCVTPU  S15, S14
    FCVTZS D11, D24, #54
    FCVTPS  S10, S11
    FCVTMU  H31, H9
    FCVTAU  D0, D5
    FCVTZU D13, D22, #56
    FCVTNU  S23, S17
    FCVTMU  S24, S15
    FCVTAS  S9, S12
    FCVTMU  D2, D21
    FCVTZU H11, H8, #7
    FCVTMU  D29, D16
    FCVTZU S15, S25, #31
    FCVTPU  S25, S15
    FCVTZS H15, H13, #8
    FCVTAU  H15, H29
    FCVTZU  S13, S30
    FCVTZU D8, D0, #6
    FCVTMU  S25, S2
    FCVTPU  D16, D15
    FCVTMS  S14, S9
    FCVTZS  D22, D24
    FCVTPU  D0, D11
    FCVTNU  S17, S0
    FCVTPS  S9, S16
    FCVTAU  D0, D7
    FCVTZU S16, S23, #5
    FCVTPS  D15, D25
    FCVTMS  H25, H8
    FCVTPU  H8, H13
    FCVTAU  S21, S9
    FCVTPS  D5, D31
    FCVTPU  S7, S22
    FCVTZS  H19, H25
    FCVTZU  S24, S8
    FCVTZS  D31, D30
    FCVTZS S11, S17, #19
    FCVTAU  D30, D24
    FCVTZS S23, S30, #7
    FCVTZS D9, D0, #20
    FCVTAS  D30, D23
    FCVTNS  S23, S14
    FCVTNS  H15, H9
    FCVTZS S17, S15, #1
    FCVTZS  H7, H19
    FCVTZU H13, H19, #7
    FCVTZU  S14, S11
    FCVTMS  S15, S14
    FCVTZS D8, D23, #63
    FCVTMU  S19, S7
    FCVTMU  D27, D5
    FCVTZS  D7, D27
    FCVTAU  H11, H17
    FCVTZU H5, H13, #8
    FCVTMU  S23, S8
    FCVTMS  D22, D16
    FCVTNS  H24, H30
    FCVTPU  D0, D11
    FCVTNU  S22, S22
    FCVTZU D13, D19, #2
    FCVTAS  D14, D13
    FCVTPU  S13, S5
    FCVTMS  H17, H0
    FCVTAU  H27, H15
    FCVTNS  D11, D2
    FCVTNS  D16, D2
    FCVTPS  D30, D16
    FCVTAU  H19, H31
    FCVTNU  S2, S10
    FCVTZS  H5, H2
    FCVTZU  S2, S21
    FCVTZU  D16, D2
    FCVTZS  S21, S5
    FCVTAU  H15, H7
    FCVTZU H0, H14, #16
    FCVTPS  S16, S24
    FCVTZS  H18, H17
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X11, FPSR
    MOVZ  X13, #0x19, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D20
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X11, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x9e65, LSL #0
    MOVK  X2, #0x438a, LSL #16
    MOVK  X2, #0xe88d, LSL #32
    MOVK  X2, #0x7318, LSL #48
    MOVZ  X3, #0xdfa2, LSL #0
    MOVK  X3, #0xf8c2, LSL #16
    MOVK  X3, #0xd72f, LSL #32
    MOVK  X3, #0xe94c, LSL #48
    MOVZ  X4, #0xed12, LSL #0
    MOVK  X4, #0x2ed1, LSL #16
    MOVK  X4, #0x6cf0, LSL #32
    MOVK  X4, #0x8da7, LSL #48
    MOVZ  X5, #0x90ba, LSL #0
    MOVK  X5, #0x1fbb, LSL #16
    MOVK  X5, #0x114d, LSL #32
    MOVK  X5, #0xac7a, LSL #48
    MOVZ  X6, #0xaae1, LSL #0
    MOVK  X6, #0xe298, LSL #16
    MOVK  X6, #0x7475, LSL #32
    MOVK  X6, #0xa5a6, LSL #48
    MOVZ  X7, #0x8987, LSL #0
    MOVK  X7, #0xc82b, LSL #16
    MOVK  X7, #0x9187, LSL #32
    MOVK  X7, #0xa768, LSL #48
    MOVZ  X8, #0x36f2, LSL #0
    MOVK  X8, #0xc2ce, LSL #16
    MOVK  X8, #0x4cf4, LSL #32
    MOVK  X8, #0xa7c4, LSL #48
    MOVZ  X9, #0xfa21, LSL #0
    MOVK  X9, #0xc175, LSL #16
    MOVK  X9, #0x4cdc, LSL #32
    MOVK  X9, #0x39c6, LSL #48
    MOVZ  X10, #0x7464, LSL #0
    MOVK  X10, #0x5f17, LSL #16
    MOVK  X10, #0xd5f0, LSL #32
    MOVK  X10, #0x7182, LSL #48
    MOVZ  X11, #0xf62d, LSL #0
    MOVK  X11, #0xfa40, LSL #16
    MOVK  X11, #0x36c8, LSL #32
    MOVK  X11, #0xaa3a, LSL #48
    MOVZ  X12, #0xe93a, LSL #0
    MOVK  X12, #0x190b, LSL #16
    MOVK  X12, #0x595f, LSL #32
    MOVK  X12, #0xd836, LSL #48
    MOVZ  X13, #0x3166, LSL #0
    MOVK  X13, #0xe7d9, LSL #16
    MOVK  X13, #0xdb40, LSL #32
    MOVK  X13, #0x58e2, LSL #48
    MOVZ  X14, #0x865e, LSL #0
    MOVK  X14, #0x8bc4, LSL #16
    MOVK  X14, #0x4842, LSL #32
    MOVK  X14, #0xf83d, LSL #48
    MOVZ  X15, #0x51cc, LSL #0
    MOVK  X15, #0x3af4, LSL #16
    MOVK  X15, #0xae6, LSL #32
    MOVK  X15, #0xece4, LSL #48
    MOVZ  X16, #0xfee9, LSL #0
    MOVK  X16, #0xe77d, LSL #16
    MOVK  X16, #0xa466, LSL #32
    MOVK  X16, #0x82ba, LSL #48
    MOVZ  X17, #0x2b9f, LSL #0
    MOVK  X17, #0x3dee, LSL #16
    MOVK  X17, #0x86c5, LSL #32
    MOVK  X17, #0x9f94, LSL #48
    MOVZ  X18, #0xbe0d, LSL #0
    MOVK  X18, #0x8817, LSL #16
    MOVK  X18, #0xde32, LSL #32
    MOVK  X18, #0x329a, LSL #48
    MOVZ  X19, #0x4558, LSL #0
    MOVK  X19, #0xeb77, LSL #16
    MOVK  X19, #0x6c62, LSL #32
    MOVK  X19, #0x2ec1, LSL #48
    MOVZ  X20, #0x64ca, LSL #0
    MOVK  X20, #0xea5, LSL #16
    MOVK  X20, #0xe246, LSL #32
    MOVK  X20, #0xa046, LSL #48
    MOVZ  X21, #0x195a, LSL #0
    MOVK  X21, #0xac89, LSL #16
    MOVK  X21, #0xd7af, LSL #32
    MOVK  X21, #0x528e, LSL #48
    MOVZ  X22, #0xc841, LSL #0
    MOVK  X22, #0x3962, LSL #16
    MOVK  X22, #0xb47, LSL #32
    MOVK  X22, #0x617, LSL #48
    MOVZ  X23, #0x8277, LSL #0
    MOVK  X23, #0xd5f8, LSL #16
    MOVK  X23, #0x20cc, LSL #32
    MOVK  X23, #0x95d3, LSL #48
    MOVZ  X29, #0x115d, LSL #0
    MOVK  X29, #0x50d2, LSL #16
    MOVK  X29, #0x4720, LSL #32
    MOVK  X29, #0x76c4, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X23
    FMOV  D1, X3
    FMOV  V1.D[1], X19
    FMOV  D2, X23
    FMOV  V2.D[1], X21
    FMOV  D3, X15
    FMOV  V3.D[1], X29
    FMOV  D4, X12
    FMOV  V4.D[1], X2
    FMOV  D5, X4
    FMOV  V5.D[1], X4
    FMOV  D6, X14
    FMOV  V6.D[1], X6
    FMOV  D7, X3
    FMOV  V7.D[1], X14
    FMOV  D8, X23
    FMOV  V8.D[1], X21
    FMOV  D9, X16
    FMOV  V9.D[1], X14
    FMOV  D10, X18
    FMOV  V10.D[1], X3
    FMOV  D11, X21
    FMOV  V11.D[1], X12
    FMOV  D12, X22
    FMOV  V12.D[1], X5
    FMOV  D13, X16
    FMOV  V13.D[1], X12
    FMOV  D14, X22
    FMOV  V14.D[1], X12
    FMOV  D15, X7
    FMOV  V15.D[1], X2
    FMOV  D16, X9
    FMOV  V16.D[1], X16
    FMOV  D17, X4
    FMOV  V17.D[1], X10
    FMOV  D18, X5
    FMOV  V18.D[1], X14
    FMOV  D19, X6
    FMOV  V19.D[1], X20
    FMOV  D20, X19
    FMOV  V20.D[1], X29
    FMOV  D21, X4
    FMOV  V21.D[1], X20
    FMOV  D22, X15
    FMOV  V22.D[1], X20
    FMOV  D23, X5
    FMOV  V23.D[1], X21
    FMOV  D24, X12
    FMOV  V24.D[1], X10
    FMOV  D25, X23
    FMOV  V25.D[1], X5
    FMOV  D26, X18
    FMOV  V26.D[1], X17
    FMOV  D27, X4
    FMOV  V27.D[1], X15
    FMOV  D28, X18
    FMOV  V28.D[1], X18
    FMOV  D29, X7
    FMOV  V29.D[1], X5
    FMOV  D30, X20
    FMOV  V30.D[1], X2
    FMOV  D31, X22
    FMOV  V31.D[1], X13
    MOVZ  X3, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_10:
    FCVTNS  D26, D25
    FCVTZU  D5, D27
    FCVTZS S6, S26, #8
    FCVTMS  H8, H29
    FCVTZU H27, H19, #15
    FCVTMS  S26, S7
    FCVTZS S19, S24, #18
    FCVTZS D18, D11, #26
    FCVTAU  H25, H8
    FCVTAU  S25, S28
    FCVTZS  S18, S19
    FCVTZU  D21, D5
    FCVTPS  H0, H31
    FCVTAS  S30, S18
    FCVTNU  H26, H22
    FCVTNS  D23, D26
    FCVTMS  H13, H21
    FCVTAS  D26, D30
    FCVTAS  S13, S14
    FCVTZU  H5, H4
    FCVTPU  S7, S23
    FCVTMS  H15, H26
    FCVTXN  S19, D25
    FCVTAS  S25, S13
    FCVTNU  H24, H5
    FCVTMU  S30, S16
    FCVTZS  S28, S28
    FCVTPS  S5, S7
    FCVTMS  D14, D24
    FCVTXN  S18, D28
    FCVTNU  S8, S25
    FCVTMU  S25, S8
    FCVTNU  S6, S3
    FCVTXN  S23, D20
    FCVTAU  S1, S23
    FCVTXN  S22, D15
    FCVTPS  H22, H1
    FCVTPU  H8, H22
    FCVTPS  D15, D5
    FCVTZS  D20, D11
    FCVTZU  D7, D25
    FCVTPU  S3, S7
    FCVTZS D16, D22, #34
    FCVTAU  S13, S15
    FCVTZU D5, D18, #29
    FCVTMU  S18, S16
    FCVTZU  D11, D18
    FCVTNU  D1, D8
    FCVTPU  D28, D14
    FCVTMU  D24, D11
    FCVTZS S16, S22, #13
    FCVTAS  D16, D3
    FCVTZS  H18, H24
    FCVTZU S8, S13, #3
    FCVTMS  D11, D8
    FCVTZU S7, S8, #17
    FCVTXN  S22, D19
    FCVTZS S3, S6, #13
    FCVTPU  H13, H18
    FCVTPU  H4, H1
    FCVTMU  S24, S22
    FCVTZS H18, H3, #9
    FCVTZS D8, D23, #22
    FCVTXN  S11, D31
    FCVTZS S16, S4, #29
    FCVTNS  D19, D24
    FCVTZS S25, S19, #9
    FCVTZS S19, S18, #5
    FCVTPS  D23, D28
    FCVTZS  D29, D22
    FCVTAS  S1, S16
    FCVTMS  S23, S20
    FCVTZS S6, S25, #13
    FCVTNS  S20, S19
    FCVTPS  H14, H29
    FCVTZS D19, D8, #35
    FCVTZS H9, H14, #8
    FCVTPU  S4, S30
    FCVTPU  H28, H20
    FCVTAU  H16, H9
    FCVTAS  H9, H4
    FCVTMU  H14, H11
    FCVTNS  H20, H23
    FCVTZU S4, S28, #2
    FCVTNS  H28, H20
    FCVTZS H23, H28, #2
    FCVTMU  D22, D14
    FCVTPS  S25, S16
    FCVTZS D29, D24, #45
    FCVTZU H27, H29, #15
    FCVTPU  D22, D6
    FCVTZU  D28, D5
    FCVTAU  H30, H9
    FCVTNS  H9, H28
    FCVTAU  H8, H25
    FCVTZS  D28, D22
    FCVTMU  D22, D30
    FCVTPU  S24, S27
    FCVTAU  H14, H29
    FCVTNU  H20, H19
    FCVTZS D29, D20, #16
    FCVTZS H20, H29, #12
    FCVTMS  D19, D4
    FCVTAS  S29, S6
    FCVTAU  H27, H29
    FCVTMS  H11, H5
    FCVTZS H16, H22, #9
    FCVTMS  D5, D16
    FCVTZU  D30, D14
    FCVTAU  H22, H23
    FCVTMU  D14, D31
    FCVTZU D14, D19, #2
    FCVTZU H22, H6, #2
    FCVTZS  D19, D24
    FCVTPU  D29, D28
    FCVTAS  H31, H8
    FCVTZS  S25, S13
    FCVTMS  D12, D30
    FCVTZU  H16, H9
    FCVTMS  S8, S22
    FCVTZS S22, S16, #9
    FCVTAS  D30, D27
    FCVTPS  S2, S5
    FCVTMU  D1, D19
    FCVTNS  D13, D2
    FCVTMS  H25, H11
    FCVTMS  D4, D8
    FCVTMU  H24, H1
    FCVTNU  H5, H30
    FCVTAS  H11, H21
    FCVTNS  S1, S11
    FCVTAS  S23, S4
    FCVTPU  D28, D13
    FCVTPS  D9, D22
    FCVTZU D30, D25, #41
    FCVTZU H18, H3, #8
    FCVTZS  D13, D16
    FCVTMS  H22, H9
    FCVTPU  H16, H24
    FCVTNU  D25, D28
    FCVTZU  S9, S30
    FCVTMS  D20, D13
    FCVTZS  D28, D5
    FCVTAS  S3, S2
    FCVTNU  D8, D28
    FCVTNS  H30, H20
    FCVTMS  H2, H22
    FCVTNU  H28, H18
    FCVTPU  S13, S23
    FCVTXN  S4, D14
    FCVTAS  D22, D28
    FCVTNU  D18, D8
    FCVTNS  D31, D5
    FCVTZS S5, S3, #15
    FCVTNU  S28, S23
    FCVTZS S16, S30, #24
    FCVTMS  S23, S22
    FCVTZS  S25, S23
    FCVTNS  H24, H31
    FCVTAS  S21, S2
    FCVTNS  H11, H5
    FCVTAS  D30, D19
    FCVTNU  S8, S6
    FCVTAS  H12, H9
    FCVTPU  S19, S13
    FCVTZU S2, S1, #12
    FCVTAU  S5, S2
    FCVTAS  H27, H5
    FCVTPU  S20, S12
    FCVTPS  H22, H8
    FCVTPU  D31, D4
    FCVTZS  S14, S22
    FCVTAU  H8, H25
    FCVTAU  D22, D11
    FCVTZS D25, D18, #25
    FCVTZU D18, D14, #53
    FCVTMS  S8, S20
    FCVTAS  D12, D22
    FCVTPU  S22, S27
    FCVTAU  H9, H31
    FCVTZU S5, S8, #3
    FCVTPS  H25, H19
    FCVTMS  H1, H22
    FCVTNS  H20, H25
    FCVTMU  H8, H8
    FCVTPU  S13, S5
    FCVTAU  D11, D8
    FCVTZU  H19, H1
    FCVTAU  H5, H12
    FCVTNS  H14, H9
    FCVTMU  H27, H5
    FCVTNS  D31, D30
    FCVTZU D5, D18, #21
    FCVTNS  S30, S11
    FCVTAS  H4, H25
    FCVTZU  D9, D19
    FCVTAS  D2, D31
    FCVTAS  S22, S22
    FCVTZU H5, H18, #13
    FCVTPS  D11, D2
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_10
    MOVZ  X18, #0x9e65, LSL #0
    MOVK  X18, #0x438a, LSL #16
    MOVK  X18, #0xe88d, LSL #32
    MOVK  X18, #0x7318, LSL #48
    SUB  X7, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xed12, LSL #0
    MOVK  X18, #0x2ed1, LSL #16
    MOVK  X18, #0x6cf0, LSL #32
    MOVK  X18, #0x8da7, LSL #48
    SUB  X7, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x90ba, LSL #0
    MOVK  X18, #0x1fbb, LSL #16
    MOVK  X18, #0x114d, LSL #32
    MOVK  X18, #0xac7a, LSL #48
    SUB  X7, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xaae1, LSL #0
    MOVK  X18, #0xe298, LSL #16
    MOVK  X18, #0x7475, LSL #32
    MOVK  X18, #0xa5a6, LSL #48
    SUB  X7, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x36f2, LSL #0
    MOVK  X18, #0xc2ce, LSL #16
    MOVK  X18, #0x4cf4, LSL #32
    MOVK  X18, #0xa7c4, LSL #48
    SUB  X7, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xfa21, LSL #0
    MOVK  X18, #0xc175, LSL #16
    MOVK  X18, #0x4cdc, LSL #32
    MOVK  X18, #0x39c6, LSL #48
    SUB  X7, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x7464, LSL #0
    MOVK  X18, #0x5f17, LSL #16
    MOVK  X18, #0xd5f0, LSL #32
    MOVK  X18, #0x7182, LSL #48
    SUB  X7, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xf62d, LSL #0
    MOVK  X18, #0xfa40, LSL #16
    MOVK  X18, #0x36c8, LSL #32
    MOVK  X18, #0xaa3a, LSL #48
    SUB  X7, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xe93a, LSL #0
    MOVK  X18, #0x190b, LSL #16
    MOVK  X18, #0x595f, LSL #32
    MOVK  X18, #0xd836, LSL #48
    SUB  X7, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x3166, LSL #0
    MOVK  X18, #0xe7d9, LSL #16
    MOVK  X18, #0xdb40, LSL #32
    MOVK  X18, #0x58e2, LSL #48
    SUB  X7, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x865e, LSL #0
    MOVK  X18, #0x8bc4, LSL #16
    MOVK  X18, #0x4842, LSL #32
    MOVK  X18, #0xf83d, LSL #48
    SUB  X7, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x51cc, LSL #0
    MOVK  X18, #0x3af4, LSL #16
    MOVK  X18, #0xae6, LSL #32
    MOVK  X18, #0xece4, LSL #48
    SUB  X7, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xfee9, LSL #0
    MOVK  X18, #0xe77d, LSL #16
    MOVK  X18, #0xa466, LSL #32
    MOVK  X18, #0x82ba, LSL #48
    SUB  X7, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x2b9f, LSL #0
    MOVK  X18, #0x3dee, LSL #16
    MOVK  X18, #0x86c5, LSL #32
    MOVK  X18, #0x9f94, LSL #48
    SUB  X7, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x4558, LSL #0
    MOVK  X18, #0xeb77, LSL #16
    MOVK  X18, #0x6c62, LSL #32
    MOVK  X18, #0x2ec1, LSL #48
    SUB  X7, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x64ca, LSL #0
    MOVK  X18, #0xea5, LSL #16
    MOVK  X18, #0xe246, LSL #32
    MOVK  X18, #0xa046, LSL #48
    SUB  X7, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xc841, LSL #0
    MOVK  X18, #0x3962, LSL #16
    MOVK  X18, #0xb47, LSL #32
    MOVK  X18, #0x617, LSL #48
    SUB  X7, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x8277, LSL #0
    MOVK  X18, #0xd5f8, LSL #16
    MOVK  X18, #0x20cc, LSL #32
    MOVK  X18, #0x95d3, LSL #48
    SUB  X7, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x115d, LSL #0
    MOVK  X18, #0x50d2, LSL #16
    MOVK  X18, #0x4720, LSL #32
    MOVK  X18, #0x76c4, LSL #48
    SUB  X7, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X18, FPSR
    MOVZ  X7, #0x19, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X7, #0xdfa2, LSL #0
    MOVK  X7, #0xf8c2, LSL #16
    MOVK  X7, #0xd72f, LSL #32
    MOVK  X7, #0xe94c, LSL #48
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D10
    MOVZ  X7, #0xbe0d, LSL #0
    MOVK  X7, #0x8817, LSL #16
    MOVK  X7, #0xde32, LSL #32
    MOVK  X7, #0x329a, LSL #48
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X7, #0x7464, LSL #0
    MOVK  X7, #0x5f17, LSL #16
    MOVK  X7, #0xd5f0, LSL #32
    MOVK  X7, #0x7182, LSL #48
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D17
    MOVZ  X7, #0xed12, LSL #0
    MOVK  X7, #0x2ed1, LSL #16
    MOVK  X7, #0x6cf0, LSL #32
    MOVK  X7, #0x8da7, LSL #48
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X18, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X6
    FMOV  D1, X8
    FMOV  V1.D[1], X13
    FMOV  D2, X19
    FMOV  V2.D[1], X22
    FMOV  D3, X16
    FMOV  V3.D[1], X13
    FMOV  D4, X29
    FMOV  V4.D[1], X15
    FMOV  D5, X11
    FMOV  V5.D[1], X17
    FMOV  D6, X19
    FMOV  V6.D[1], X23
    FMOV  D7, X20
    FMOV  V7.D[1], X12
    FMOV  D8, X10
    FMOV  V8.D[1], X17
    FMOV  D9, X6
    FMOV  V9.D[1], X18
    FMOV  D10, X11
    FMOV  V10.D[1], X9
    FMOV  D11, X11
    FMOV  V11.D[1], X14
    FMOV  D12, X18
    FMOV  V12.D[1], X7
    FMOV  D13, X5
    FMOV  V13.D[1], X9
    FMOV  D14, X16
    FMOV  V14.D[1], X23
    FMOV  D15, X5
    FMOV  V15.D[1], X13
    FMOV  D16, X15
    FMOV  V16.D[1], X20
    FMOV  D17, X19
    FMOV  V17.D[1], X3
    FMOV  D18, X2
    FMOV  V18.D[1], X20
    FMOV  D19, X7
    FMOV  V19.D[1], X15
    FMOV  D20, X22
    FMOV  V20.D[1], X19
    FMOV  D21, X5
    FMOV  V21.D[1], X3
    FMOV  D22, X17
    FMOV  V22.D[1], X6
    FMOV  D23, X22
    FMOV  V23.D[1], X2
    FMOV  D24, X11
    FMOV  V24.D[1], X8
    FMOV  D25, X14
    FMOV  V25.D[1], X13
    FMOV  D26, X11
    FMOV  V26.D[1], X8
    FMOV  D27, X20
    FMOV  V27.D[1], X13
    FMOV  D28, X19
    FMOV  V28.D[1], X29
    FMOV  D29, X3
    FMOV  V29.D[1], X2
    FMOV  D30, X4
    FMOV  V30.D[1], X29
    FMOV  D31, X4
    FMOV  V31.D[1], X22
    MOVZ  X7, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_11:
    FCVTAS  S21, S27
    FCVTMU  S26, S28
    FCVTZS D22, D19, #61
    FCVTNS  D17, D26
    FCVTNU  S23, S25
    FCVTPS  S9, S29
    FCVTZU  D22, D23
    FCVTZU D27, D12, #27
    FCVTAS  H1, H30
    FCVTMS  H25, H9
    FCVTNS  H2, H25
    FCVTAU  D1, D24
    FCVTZU  H16, H17
    FCVTZS  H12, H1
    FCVTNS  D4, D27
    FCVTPU  H23, H31
    FCVTNS  H19, H2
    FCVTAU  D23, D1
    FCVTZU H19, H28, #15
    FCVTAU  D13, D4
    FCVTZU D19, D27, #24
    FCVTZS  S30, S24
    FCVTZS  D29, D12
    FCVTNS  S27, S19
    FCVTZU  H26, H4
    FCVTZU D24, D26, #44
    FCVTZS D21, D29, #10
    FCVTZU  S1, S16
    FCVTAU  H16, H24
    FCVTPS  H12, H27
    FCVTZS S26, S30, #15
    FCVTZS  S29, S9
    FCVTPU  H0, H26
    FCVTNS  D9, D29
    FCVTMU  H30, H22
    FCVTZU S29, S13, #3
    FCVTZS D4, D29, #59
    FCVTZS S27, S21, #7
    FCVTPS  D28, D1
    FCVTNS  S13, S4
    FCVTPS  S22, S9
    FCVTZS S21, S30, #20
    FCVTPU  D7, D8
    FCVTAS  D27, D21
    FCVTZU D19, D27, #31
    FCVTMU  S7, S23
    FCVTMS  H27, H19
    FCVTMU  D9, D6
    FCVTZU D13, D9, #59
    FCVTZU  H8, H7
    FCVTXN  S30, D28
    FCVTNU  S17, S30
    FCVTPS  S19, S22
    FCVTMU  D23, D27
    FCVTZU D2, D1, #21
    FCVTZU D4, D23, #43
    FCVTPS  H28, H19
    FCVTAS  H6, H21
    FCVTZS  H9, H2
    FCVTZS D26, D4, #1
    FCVTPS  D22, D26
    FCVTMU  S30, S24
    FCVTMS  D29, D6
    FCVTMU  D4, D13
    FCVTNU  S27, S4
    FCVTMS  S21, S12
    FCVTNU  D1, D8
    FCVTZU  H2, H9
    FCVTNS  S4, S1
    FCVTMS  D13, D28
    FCVTMU  H1, H29
    FCVTNU  D2, D1
    FCVTAS  H8, H30
    FCVTPU  H28, H21
    FCVTZU  S23, S2
    FCVTAS  S25, S17
    FCVTAU  D9, D21
    FCVTMU  H12, H22
    FCVTZS  D29, D4
    FCVTNS  S1, S12
    FCVTMS  S21, S13
    FCVTAU  S13, S6
    FCVTZS  S30, S23
    FCVTZU  S12, S13
    FCVTAS  D17, D3
    FCVTMS  D3, D21
    FCVTZS D5, D12, #14
    FCVTMU  D13, D27
    FCVTPU  S21, S9
    FCVTMS  D26, D17
    FCVTZS  S22, S26
    FCVTNS  S27, S13
    FCVTNS  H5, H4
    FCVTPS  D12, D28
    FCVTPU  H2, H5
    FCVTAU  S6, S22
    FCVTMS  S12, S16
    FCVTNU  H16, H29
    FCVTPU  H22, H30
    FCVTZS  H27, H24
    FCVTXN  S24, D16
    FCVTNS  H4, H3
    FCVTZU  S30, S9
    FCVTZU  D9, D24
    FCVTZU D28, D2, #26
    FCVTZU  H3, H14
    FCVTPS  D11, D27
    FCVTZU  S27, S20
    FCVTZU  H17, H30
    FCVTNU  S26, S3
    FCVTPS  H7, H12
    FCVTAU  D23, D11
    FCVTAS  D12, D27
    FCVTZU  H28, H23
    FCVTMU  D11, D7
    FCVTZS D27, D22, #23
    FCVTZU  H2, H11
    FCVTXN  S14, D4
    FCVTZU D6, D3, #33
    FCVTZU  S24, S27
    FCVTPS  S29, S0
    FCVTNU  H10, H10
    FCVTPS  D5, D2
    FCVTZS  D16, D5
    FCVTZU D24, D9, #15
    FCVTZS H4, H24, #13
    FCVTMS  H29, H17
    FCVTPU  H11, H10
    FCVTZS S18, S16, #24
    FCVTPU  H3, H29
    FCVTMU  S26, S3
    FCVTXN  S7, D31
    FCVTZS D16, D14, #28
    FCVTZS H6, H12, #14
    FCVTZU H23, H11, #9
    FCVTNS  H29, H18
    FCVTNS  D9, D6
    FCVTPU  D20, D19
    FCVTAS  S31, S4
    FCVTAS  D19, D28
    FCVTNS  D7, D18
    FCVTZU H11, H4, #14
    FCVTPU  D26, D11
    FCVTMS  H28, H26
    FCVTNS  S28, S31
    FCVTZS D31, D29, #9
    FCVTZS D14, D20, #19
    FCVTZS  D2, D30
    FCVTNS  H20, H14
    FCVTMU  H8, H2
    FCVTZS  D24, D16
    FCVTAU  D16, D23
    FCVTNS  H18, H9
    FCVTPS  D31, D20
    FCVTZS  S14, S15
    FCVTAS  H11, H18
    FCVTMS  S7, S28
    FCVTNS  H20, H19
    FCVTZS S18, S18, #8
    FCVTMU  D3, D3
    FCVTNS  H2, H16
    FCVTZU  H4, H16
    FCVTZS  D22, D24
    FCVTZS D26, D7, #18
    FCVTPU  S9, S8
    FCVTMS  H30, H31
    FCVTZU S23, S20, #26
    FCVTZS H18, H23, #8
    FCVTNU  H15, H22
    FCVTMS  S28, S11
    FCVTZU  D11, D4
    FCVTMS  S29, S14
    FCVTNU  H1, H12
    FCVTMS  D11, D5
    FCVTZS D8, D18, #18
    FCVTNU  S12, S11
    FCVTZU D23, D8, #43
    FCVTZS S20, S1, #21
    FCVTAS  S17, S9
    FCVTAU  D7, D2
    FCVTNU  S24, S15
    FCVTAU  S16, S24
    FCVTPS  S9, S17
    FCVTZU  D4, D30
    FCVTMS  H1, H12
    FCVTZS H11, H29, #9
    FCVTZS H29, H16, #7
    FCVTNU  H20, H11
    FCVTPS  S22, S30
    FCVTMU  H17, H25
    FCVTZU H24, H22, #3
    FCVTZS  S2, S26
    FCVTZU  D21, D23
    FCVTZU  H18, H24
    FCVTZU S25, S13, #18
    FCVTZS  H13, H7
    FCVTPS  S8, S13
    FCVTNU  D15, D10
    FCVTAU  H18, H28
    FCVTAU  H23, H28
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_11
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X15, FPSR
    MOVZ  X4, #0x19, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X15, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X9
    FMOV  D1, X23
    FMOV  V1.D[1], X8
    FMOV  D2, X29
    FMOV  V2.D[1], X9
    FMOV  D3, X5
    FMOV  V3.D[1], X22
    FMOV  D4, X10
    FMOV  V4.D[1], X7
    FMOV  D5, X23
    FMOV  V5.D[1], X7
    FMOV  D6, X16
    FMOV  V6.D[1], X12
    FMOV  D7, X9
    FMOV  V7.D[1], X18
    FMOV  D8, X23
    FMOV  V8.D[1], X8
    FMOV  D9, X6
    FMOV  V9.D[1], X14
    FMOV  D10, X19
    FMOV  V10.D[1], X12
    FMOV  D11, X29
    FMOV  V11.D[1], X21
    FMOV  D12, X4
    FMOV  V12.D[1], X2
    FMOV  D13, X8
    FMOV  V13.D[1], X22
    FMOV  D14, X10
    FMOV  V14.D[1], X17
    FMOV  D15, X22
    FMOV  V15.D[1], X11
    FMOV  D16, X8
    FMOV  V16.D[1], X19
    FMOV  D17, X22
    FMOV  V17.D[1], X12
    FMOV  D18, X17
    FMOV  V18.D[1], X3
    FMOV  D19, X9
    FMOV  V19.D[1], X8
    FMOV  D20, X2
    FMOV  V20.D[1], X12
    FMOV  D21, X8
    FMOV  V21.D[1], X16
    FMOV  D22, X21
    FMOV  V22.D[1], X18
    FMOV  D23, X13
    FMOV  V23.D[1], X19
    FMOV  D24, X14
    FMOV  V24.D[1], X3
    FMOV  D25, X7
    FMOV  V25.D[1], X19
    FMOV  D26, X17
    FMOV  V26.D[1], X20
    FMOV  D27, X12
    FMOV  V27.D[1], X17
    FMOV  D28, X21
    FMOV  V28.D[1], X2
    FMOV  D29, X15
    FMOV  V29.D[1], X7
    FMOV  D30, X21
    FMOV  V30.D[1], X19
    FMOV  D31, X6
    FMOV  V31.D[1], X14
    MOVZ  X22, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_12:
    FCVTZS D8, D7, #7
    FCVTAS  S26, S25
    FCVTZS D11, D18, #10
    FCVTZS  S21, S11
    FCVTZS H21, H30, #7
    FCVTAU  S13, S18
    FCVTZU D9, D13, #21
    FCVTPS  S11, S8
    FCVTZS  S23, S28
    FCVTPS  D2, D27
    FCVTMU  S25, S2
    FCVTMS  D0, D25
    FCVTNU  H21, H10
    FCVTNS  D17, D5
    FCVTZU S31, S19, #11
    FCVTMS  D15, D22
    FCVTAS  S11, S11
    FCVTNU  H28, H11
    FCVTZU H23, H17, #3
    FCVTZU  S8, S23
    FCVTPS  H13, H9
    FCVTZU D2, D26, #7
    FCVTMU  D26, D2
    FCVTAS  S17, S31
    FCVTPS  D30, D13
    FCVTAU  D28, D0
    FCVTMU  S0, S15
    FCVTZU H11, H26, #11
    FCVTZS  H26, H30
    FCVTNU  H2, H21
    FCVTZS  S10, S2
    FCVTZU  H23, H11
    FCVTPU  H6, H4
    FCVTMS  D2, D28
    FCVTZU  D31, D10
    FCVTZS D13, D6, #23
    FCVTZS H22, H26, #2
    FCVTAS  S19, S23
    FCVTAS  D6, D17
    FCVTZS D23, D19, #29
    FCVTPU  S11, S27
    FCVTZS  H13, H31
    FCVTMS  H27, H28
    FCVTMS  S26, S10
    FCVTXN  S13, D23
    FCVTAS  D10, D26
    FCVTZS  S31, S6
    FCVTNU  S15, S27
    FCVTNU  D21, D5
    FCVTMS  S6, S24
    FCVTAS  H28, H2
    FCVTMS  D25, D13
    FCVTPU  D5, D15
    FCVTAS  S27, S0
    FCVTMU  D19, D2
    FCVTAU  D2, D31
    FCVTNU  H30, H14
    FCVTPU  S21, S25
    FCVTNU  H4, H10
    FCVTAS  H27, H27
    FCVTZU  S17, S28
    FCVTAU  S23, S5
    FCVTNU  D25, D27
    FCVTPS  S10, S25
    FCVTZU  H15, H17
    FCVTNU  S27, S15
    FCVTNU  H23, H6
    FCVTZU  H31, H30
    FCVTMU  S31, S27
    FCVTPU  S28, S10
    FCVTAS  S30, S11
    FCVTZS D6, D19, #33
    FCVTPU  S14, S23
    FCVTNU  H13, H21
    FCVTPS  H25, H2
    FCVTPU  D17, D14
    FCVTAS  D11, D25
    FCVTPS  D15, D11
    FCVTAU  D2, D31
    FCVTMS  S0, S24
    FCVTMS  S5, S28
    FCVTZU S23, S13, #14
    FCVTPS  H19, H17
    FCVTZS H4, H23, #1
    FCVTZU S28, S0, #10
    FCVTZS H11, H15, #4
    FCVTAS  H10, H2
    FCVTMS  D24, D5
    FCVTZU  H14, H4
    FCVTAU  H23, H3
    FCVTZS H2, H25, #5
    FCVTZS  D5, D29
    FCVTNS  D21, D11
    FCVTNS  D29, D19
    FCVTZU  D11, D12
    FCVTXN  S27, D5
    FCVTZS D15, D11, #20
    FCVTMS  H19, H23
    FCVTMU  D15, D24
    FCVTPU  H30, H19
    FCVTMS  S12, S22
    FCVTMS  H4, H29
    FCVTZS S5, S6, #8
    FCVTPU  D29, D27
    FCVTPU  H11, H15
    FCVTZU  H3, H11
    FCVTZS D18, D5, #36
    FCVTZS D13, D12, #20
    FCVTZU  H15, H10
    FCVTNS  D24, D30
    FCVTNS  D21, D21
    FCVTXN  S10, D3
    FCVTZU  D27, D20
    FCVTPU  H23, H30
    FCVTMU  D5, D13
    FCVTAS  H6, H10
    FCVTMS  S3, S27
    FCVTXN  S22, D18
    FCVTZS  D11, D2
    FCVTNU  S18, S11
    FCVTZS H13, H29, #1
    FCVTNS  D2, D15
    FCVTZU  H27, H5
    FCVTXN  S11, D4
    FCVTZS D30, D8, #59
    FCVTMU  H10, H22
    FCVTAU  D15, D27
    FCVTAU  H27, H3
    FCVTZU D7, D18, #36
    FCVTMS  H28, H2
    FCVTZS S3, S11, #10
    FCVTZS S9, S24, #30
    FCVTZS S12, S13, #14
    FCVTZU S22, S10, #14
    FCVTPU  S3, S30
    FCVTMS  D13, D22
    FCVTPS  D4, D3
    FCVTNU  H8, H7
    FCVTNU  H10, H3
    FCVTAU  D28, D4
    FCVTZU  D21, D12
    FCVTNU  D24, D28
    FCVTZS  D11, D29
    FCVTPU  H29, H10
    FCVTPU  D18, D6
    FCVTAS  S5, S2
    FCVTMU  D3, D3
    FCVTAS  S3, S13
    FCVTPS  S7, S23
    FCVTNU  H24, H7
    FCVTZS  S7, S27
    FCVTMS  D12, D29
    FCVTPS  H6, H5
    FCVTZU H2, H12, #4
    FCVTMS  S10, S1
    FCVTNU  S26, S8
    FCVTZU H30, H3, #1
    FCVTZS H23, H6, #15
    FCVTPS  H4, H17
    FCVTAU  S12, S10
    FCVTNU  S1, S28
    FCVTPS  S1, S12
    FCVTZU  H13, H18
    FCVTNU  S0, S13
    FCVTZS  D18, D0
    FCVTNU  D17, D25
    FCVTMS  D10, D24
    FCVTAS  H29, H26
    FCVTMS  S16, S8
    FCVTNU  H13, H16
    FCVTNU  H24, H29
    FCVTPS  D3, D24
    FCVTAU  H27, H7
    FCVTNS  H2, H17
    FCVTNS  H29, H16
    FCVTPU  D17, D23
    FCVTAU  D24, D10
    FCVTZS D16, D13, #40
    FCVTZU  S26, S16
    FCVTZS  D5, D3
    FCVTMS  D3, D30
    FCVTNU  D7, D4
    FCVTPS  S30, S17
    FCVTZU  D4, D15
    FCVTPU  S10, S7
    FCVTAS  S22, S30
    FCVTNU  S17, S2
    FCVTNS  D2, D6
    FCVTNU  D21, D2
    FCVTMS  H30, H24
    FCVTMU  D7, D3
    FCVTMS  H19, H5
    FCVTZU  D6, D27
    FCVTNU  H0, H29
    FCVTZU D5, D22, #14
    FCVTAU  D9, D5
    FCVTZU  H10, H6
    FCVTXN  S22, D17
    FCVTZS D17, D26, #9
    FCVTPS  S5, S10
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_12
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X13, FPSR
    MOVZ  X2, #0x19, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D20
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X13, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X21
    FMOV  D1, X23
    FMOV  V1.D[1], X22
    FMOV  D2, X6
    FMOV  V2.D[1], X17
    FMOV  D3, X29
    FMOV  V3.D[1], X22
    FMOV  D4, X21
    FMOV  V4.D[1], X20
    FMOV  D5, X11
    FMOV  V5.D[1], X21
    FMOV  D6, X20
    FMOV  V6.D[1], X23
    FMOV  D7, X6
    FMOV  V7.D[1], X23
    FMOV  D8, X9
    FMOV  V8.D[1], X8
    FMOV  D9, X9
    FMOV  V9.D[1], X20
    FMOV  D10, X9
    FMOV  V10.D[1], X20
    FMOV  D11, X7
    FMOV  V11.D[1], X8
    FMOV  D12, X3
    FMOV  V12.D[1], X4
    FMOV  D13, X14
    FMOV  V13.D[1], X6
    FMOV  D14, X11
    FMOV  V14.D[1], X12
    FMOV  D15, X10
    FMOV  V15.D[1], X7
    FMOV  D16, X7
    FMOV  V16.D[1], X14
    FMOV  D17, X2
    FMOV  V17.D[1], X14
    FMOV  D18, X13
    FMOV  V18.D[1], X10
    FMOV  D19, X3
    FMOV  V19.D[1], X22
    FMOV  D20, X10
    FMOV  V20.D[1], X14
    FMOV  D21, X16
    FMOV  V21.D[1], X8
    FMOV  D22, X19
    FMOV  V22.D[1], X3
    FMOV  D23, X12
    FMOV  V23.D[1], X5
    FMOV  D24, X9
    FMOV  V24.D[1], X17
    FMOV  D25, X15
    FMOV  V25.D[1], X21
    FMOV  D26, X6
    FMOV  V26.D[1], X23
    FMOV  D27, X16
    FMOV  V27.D[1], X10
    FMOV  D28, X6
    FMOV  V28.D[1], X2
    FMOV  D29, X4
    FMOV  V29.D[1], X16
    FMOV  D30, X13
    FMOV  V30.D[1], X3
    FMOV  D31, X15
    FMOV  V31.D[1], X17
    MOVZ  X7, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_13:
    FCVTNU  S8, S26
    FCVTNS  D8, D8
    FCVTMS  D16, D24
    FCVTAU  S25, S31
    FCVTZU H1, H28, #13
    FCVTMS  S4, S23
    FCVTZS S17, S4, #26
    FCVTAU  D22, D30
    FCVTZU H20, H29, #3
    FCVTNS  H15, H20
    FCVTPS  H15, H17
    FCVTZU  S5, S22
    FCVTZU  D10, D18
    FCVTPS  S29, S22
    FCVTZU S26, S16, #32
    FCVTPU  D24, D2
    FCVTZU D25, D24, #32
    FCVTNU  H9, H9
    FCVTZS S11, S31, #15
    FCVTNU  S9, S1
    FCVTAS  S26, S12
    FCVTZU  H21, H5
    FCVTZU  D5, D11
    FCVTZS  H11, H10
    FCVTAU  H21, H11
    FCVTZS H31, H15, #4
    FCVTMS  H7, H29
    FCVTZS  D22, D26
    FCVTZU  S2, S22
    FCVTPU  S18, S10
    FCVTPS  H1, H22
    FCVTZS D26, D28, #60
    FCVTMU  D17, D28
    FCVTZU S16, S17, #26
    FCVTMU  S11, S18
    FCVTAS  S4, S11
    FCVTZS H17, H5, #9
    FCVTMU  D5, D10
    FCVTNU  H11, H16
    FCVTAU  D12, D4
    FCVTMS  D10, D1
    FCVTNU  D1, D7
    FCVTXN  S28, D0
    FCVTAS  H7, H19
    FCVTZS D14, D25, #33
    FCVTMS  H16, H7
    FCVTZS  S24, S1
    FCVTAU  D25, D30
    FCVTAU  H20, H17
    FCVTZU  H4, H26
    FCVTZS  H30, H25
    FCVTAU  S0, S4
    FCVTZS  S8, S24
    FCVTZS D18, D20, #15
    FCVTZU  H4, H0
    FCVTNU  S25, S11
    FCVTAU  H14, H4
    FCVTNU  D19, D19
    FCVTAU  S24, S10
    FCVTNS  D17, D17
    FCVTZS  D20, D30
    FCVTNU  H26, H25
    FCVTAU  H0, H8
    FCVTNU  H8, H18
    FCVTZS H12, H30, #16
    FCVTZS H25, H15, #8
    FCVTZS  H4, H26
    FCVTNU  S26, S19
    FCVTAU  S10, S28
    FCVTZS H1, H14, #16
    FCVTMU  H18, H25
    FCVTMS  H0, H17
    FCVTAS  D19, D20
    FCVTAU  H20, H26
    FCVTPU  H26, H24
    FCVTNU  D28, D0
    FCVTZS S15, S31, #10
    FCVTPU  H25, H2
    FCVTZS  H15, H18
    FCVTPU  D0, D27
    FCVTZS  H14, H26
    FCVTNS  H17, H8
    FCVTXN  S11, D25
    FCVTPU  H17, H19
    FCVTPU  D31, D28
    FCVTZU H28, H1, #5
    FCVTAS  S8, S12
    FCVTPU  D18, D20
    FCVTAS  H30, H11
    FCVTAU  D24, D14
    FCVTAS  S19, S15
    FCVTPS  S26, S31
    FCVTXN  S15, D22
    FCVTMU  H27, H8
    FCVTZU S14, S27, #24
    FCVTNU  S12, S17
    FCVTPU  D22, D3
    FCVTMS  H29, H14
    FCVTZS  H31, H26
    FCVTPU  D17, D31
    FCVTZS S26, S18, #18
    FCVTPU  D31, D30
    FCVTAS  S2, S26
    FCVTPS  S1, S21
    FCVTMU  S18, S2
    FCVTMU  D27, D20
    FCVTXN  S30, D29
    FCVTZS S26, S30, #29
    FCVTAU  S6, S12
    FCVTPS  D2, D22
    FCVTPU  H21, H20
    FCVTMS  D12, D27
    FCVTZS  D25, D24
    FCVTXN  S3, D25
    FCVTMU  S12, S1
    FCVTAS  S25, S2
    FCVTPU  H6, H9
    FCVTMU  S9, S21
    FCVTNU  S2, S25
    FCVTZU S26, S18, #27
    FCVTZU  H21, H31
    FCVTZS D25, D21, #42
    FCVTPU  H15, H12
    FCVTNS  H27, H25
    FCVTAU  H15, H6
    FCVTZS  D24, D15
    FCVTAS  D30, D27
    FCVTZS D0, D17, #52
    FCVTZS H6, H30, #13
    FCVTZS  S1, S13
    FCVTZS S18, S9, #15
    FCVTAS  D17, D2
    FCVTAU  D13, D18
    FCVTAS  S6, S0
    FCVTZS  D12, D12
    FCVTPU  H30, H13
    FCVTZU D7, D2, #28
    FCVTNS  H20, H7
    FCVTZS  S7, S24
    FCVTMU  S22, S30
    FCVTAU  D30, D20
    FCVTZS S18, S12, #12
    FCVTPS  H15, H24
    FCVTZS H24, H7, #1
    FCVTNS  D13, D6
    FCVTPU  S6, S30
    FCVTMU  S2, S17
    FCVTNS  H30, H24
    FCVTZU  D20, D22
    FCVTZS D9, D8, #28
    FCVTAS  D20, D30
    FCVTMU  S12, S6
    FCVTPS  H20, H12
    FCVTMS  S29, S15
    FCVTNU  S4, S18
    FCVTPS  D4, D20
    FCVTMU  H14, H12
    FCVTMU  D6, D29
    FCVTNS  H12, H4
    FCVTPU  D7, D30
    FCVTZU  D25, D12
    FCVTPU  S24, S22
    FCVTPS  H30, H9
    FCVTZS H29, H30, #4
    FCVTAS  S30, S24
    FCVTPS  H3, H29
    FCVTZU  S15, S22
    FCVTMS  S4, S14
    FCVTNU  H24, H27
    FCVTNS  D14, D30
    FCVTZS  D20, D7
    FCVTZS  S29, S14
    FCVTNS  H7, H20
    FCVTZU H12, H24, #4
    FCVTNS  S9, S29
    FCVTAU  S29, S9
    FCVTNU  S27, S2
    FCVTMU  H30, H30
    FCVTNU  H14, H29
    FCVTZS  H10, H10
    FCVTZS  D9, D14
    FCVTAU  S14, S10
    FCVTNS  S22, S0
    FCVTAU  H12, H30
    FCVTAS  D15, D7
    FCVTNU  S29, S20
    FCVTZU D10, D26, #44
    FCVTMU  H26, H27
    FCVTNS  S7, S28
    FCVTZU H27, H8, #14
    FCVTXN  S7, D10
    FCVTZS  S0, S12
    FCVTNS  S24, S26
    FCVTMS  S10, S14
    FCVTNU  D2, D29
    FCVTZS  H8, H3
    FCVTZS H14, H31, #12
    FCVTAS  H31, H27
    FCVTMS  S30, S22
    FCVTNS  H22, H24
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_13
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X19, FPSR
    MOVZ  X15, #0x1d, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D23
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X19, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X18
    FMOV  D1, X19
    FMOV  V1.D[1], X14
    FMOV  D2, X21
    FMOV  V2.D[1], X18
    FMOV  D3, X4
    FMOV  V3.D[1], X18
    FMOV  D4, X29
    FMOV  V4.D[1], X2
    FMOV  D5, X21
    FMOV  V5.D[1], X4
    FMOV  D6, X12
    FMOV  V6.D[1], X23
    FMOV  D7, X16
    FMOV  V7.D[1], X19
    FMOV  D8, X11
    FMOV  V8.D[1], X20
    FMOV  D9, X6
    FMOV  V9.D[1], X8
    FMOV  D10, X2
    FMOV  V10.D[1], X16
    FMOV  D11, X21
    FMOV  V11.D[1], X19
    FMOV  D12, X7
    FMOV  V12.D[1], X5
    FMOV  D13, X3
    FMOV  V13.D[1], X7
    FMOV  D14, X12
    FMOV  V14.D[1], X3
    FMOV  D15, X17
    FMOV  V15.D[1], X11
    FMOV  D16, X11
    FMOV  V16.D[1], X16
    FMOV  D17, X11
    FMOV  V17.D[1], X16
    FMOV  D18, X9
    FMOV  V18.D[1], X8
    FMOV  D19, X3
    FMOV  V19.D[1], X19
    FMOV  D20, X21
    FMOV  V20.D[1], X21
    FMOV  D21, X9
    FMOV  V21.D[1], X9
    FMOV  D22, X19
    FMOV  V22.D[1], X2
    FMOV  D23, X8
    FMOV  V23.D[1], X5
    FMOV  D24, X22
    FMOV  V24.D[1], X22
    FMOV  D25, X11
    FMOV  V25.D[1], X2
    FMOV  D26, X16
    FMOV  V26.D[1], X20
    FMOV  D27, X9
    FMOV  V27.D[1], X2
    FMOV  D28, X6
    FMOV  V28.D[1], X2
    FMOV  D29, X7
    FMOV  V29.D[1], X18
    FMOV  D30, X8
    FMOV  V30.D[1], X13
    FMOV  D31, X23
    FMOV  V31.D[1], X21
    MOVZ  X13, #0xa, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_14:
    FCVTZS  D30, D31
    FCVTAU  S6, S29
    FCVTZU  H24, H26
    FCVTNU  S8, S21
    FCVTAU  H8, H27
    FCVTZU D29, D28, #23
    FCVTNU  H22, H9
    FCVTPU  H16, H29
    FCVTAU  D6, D22
    FCVTPU  D28, D30
    FCVTAS  S12, S28
    FCVTNS  H21, H15
    FCVTZU  S13, S8
    FCVTAU  S25, S17
    FCVTPU  H13, H13
    FCVTZS S8, S16, #28
    FCVTZS S24, S13, #18
    FCVTZS S12, S12, #17
    FCVTMS  S9, S25
    FCVTNS  S3, S7
    FCVTZS  D26, D21
    FCVTXN  S23, D25
    FCVTZS  S15, S8
    FCVTNU  H29, H23
    FCVTAU  D22, D26
    FCVTZU S16, S3, #8
    FCVTPS  D26, D9
    FCVTPS  H21, H12
    FCVTZS  S30, S26
    FCVTZU  S13, S22
    FCVTPS  H19, H13
    FCVTNU  D12, D29
    FCVTNU  H31, H16
    FCVTAU  D16, D12
    FCVTNU  H25, H1
    FCVTZU D3, D19, #60
    FCVTZS H1, H6, #3
    FCVTZS D26, D3, #12
    FCVTAU  H6, H30
    FCVTPU  D9, D16
    FCVTZU  H5, H22
    FCVTMU  S8, S21
    FCVTZS D26, D8, #14
    FCVTZS  S21, S6
    FCVTNS  H30, H27
    FCVTAS  H23, H21
    FCVTZU  S12, S30
    FCVTZS  S21, S26
    FCVTMS  H7, H31
    FCVTMS  D26, D23
    FCVTMS  S27, S21
    FCVTZS  S13, S18
    FCVTNS  D18, D15
    FCVTZS  D19, D1
    FCVTPS  D31, D23
    FCVTZU  H13, H7
    FCVTPU  D6, D12
    FCVTZS H23, H31, #1
    FCVTPU  H24, H17
    FCVTAS  S22, S25
    FCVTZS D17, D9, #63
    FCVTNU  H31, H23
    FCVTNU  S9, S17
    FCVTAS  H11, H9
    FCVTPU  H9, H25
    FCVTPS  S30, S12
    FCVTMS  S21, S9
    FCVTNS  D28, D31
    FCVTAU  D23, D17
    FCVTZS  S9, S11
    FCVTZS  H8, H30
    FCVTPS  S1, S22
    FCVTZS D9, D28, #28
    FCVTZS  S27, S28
    FCVTZS  H25, H1
    FCVTMS  H31, H0
    FCVTMS  H9, H19
    FCVTZU  H3, H23
    FCVTZS H28, H19, #5
    FCVTZS  D22, D26
    FCVTZS  D11, D31
    FCVTPU  D31, D11
    FCVTNS  H26, H13
    FCVTPS  H4, H11
    FCVTNU  H19, H25
    FCVTNS  S25, S6
    FCVTAU  S6, S12
    FCVTAU  S5, S3
    FCVTPU  D22, D30
    FCVTMU  H13, H6
    FCVTPS  S11, S4
    FCVTAU  H1, H8
    FCVTNU  S14, S26
    FCVTZS  H9, H13
    FCVTAS  S4, S29
    FCVTZS D26, D1, #22
    FCVTMU  S1, S26
    FCVTZS S12, S20, #6
    FCVTMS  D3, D28
    FCVTAU  S8, S0
    FCVTZU S26, S14, #4
    FCVTZU  S23, S25
    FCVTZS H14, H4, #15
    FCVTMU  D25, D8
    FCVTMS  D7, D1
    FCVTAS  D29, D24
    FCVTZS H13, H26, #13
    FCVTMU  H26, H23
    FCVTAU  S28, S13
    FCVTNS  D23, D16
    FCVTPU  S20, S22
    FCVTAU  S16, S3
    FCVTNU  D13, D10
    FCVTNS  D3, D13
    FCVTZU H10, H21, #1
    FCVTAU  H24, H9
    FCVTMS  D8, D10
    FCVTZS D21, D26, #21
    FCVTPU  H10, H27
    FCVTMU  H18, H22
    FCVTPS  S1, S24
    FCVTMS  S17, S1
    FCVTPU  H9, H21
    FCVTNS  H31, H7
    FCVTAS  D7, D28
    FCVTAS  H26, H17
    FCVTPS  H17, H16
    FCVTPU  S24, S14
    FCVTNU  D14, D23
    FCVTZU H21, H20, #4
    FCVTZS H19, H9, #2
    FCVTNS  S14, S31
    FCVTPU  D7, D13
    FCVTZS  S12, S17
    FCVTPU  D4, D12
    FCVTZS  S23, S8
    FCVTZS  D29, D15
    FCVTNU  S27, S14
    FCVTZS  D28, D29
    FCVTZU H9, H4, #5
    FCVTXN  S17, D7
    FCVTNU  S22, S24
    FCVTAS  S4, S28
    FCVTPU  S10, S15
    FCVTNS  D31, D19
    FCVTZU  D8, D22
    FCVTZS S15, S21, #29
    FCVTNS  S29, S15
    FCVTZU D4, D27, #43
    FCVTNU  H27, H25
    FCVTAS  S28, S9
    FCVTAU  S9, S27
    FCVTNS  S13, S21
    FCVTZU  D5, D4
    FCVTPS  S21, S10
    FCVTMU  S19, S5
    FCVTZU S2, S19, #12
    FCVTAS  S19, S17
    FCVTAS  D25, D13
    FCVTNS  D4, D18
    FCVTZS  S5, S15
    FCVTMU  H20, H5
    FCVTZS S9, S2, #20
    FCVTZS  H24, H23
    FCVTNS  H13, H13
    FCVTNS  D27, D25
    FCVTMU  D14, D19
    FCVTAS  H23, H10
    FCVTNU  H5, H20
    FCVTPU  S2, S28
    FCVTNU  D10, D13
    FCVTNS  S28, S5
    FCVTZU  H19, H8
    FCVTZU  S19, S8
    FCVTAU  D0, D28
    FCVTMU  H17, H29
    FCVTAU  H8, H4
    FCVTZU H15, H27, #14
    FCVTPU  D11, D30
    FCVTNS  H28, H2
    FCVTPS  H20, H4
    FCVTZU H18, H14, #13
    FCVTAU  H25, H0
    FCVTAS  D6, D28
    FCVTMS  D13, D20
    FCVTZS  H14, H18
    FCVTMU  H20, H13
    FCVTZU D5, D10, #9
    FCVTXN  S18, D25
    FCVTZU  S11, S5
    FCVTZS H29, H8, #9
    FCVTNS  H8, H9
    FCVTPS  D2, D17
    FCVTAU  D27, D6
    FCVTPS  H30, H2
    FCVTAU  H0, H14
    FCVTNU  H19, H27
    FCVTAS  S17, S4
    FCVTZU D29, D8, #30
    FCVTMS  H4, H29
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_14
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X9, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MRS  X17, FPSR
    MOVZ  X9, #0x1d, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    FMOV  X17, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail

TSRTAdvsimdScalarFloatPointConvertToInteger_TestEnd:
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
TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail:
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
