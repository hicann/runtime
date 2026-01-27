.global TSRTAdvsimdVectorGeneralOperation

.text
.p2align 4

TSRTAdvsimdVectorGeneralOperation:

TSRTAdvsimdVectorGeneralOperation_TestBegin:
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
    MOVZ  X2, #0x17a1, LSL #0
    MOVK  X2, #0x3c6a, LSL #16
    MOVK  X2, #0xf303, LSL #32
    MOVK  X2, #0xbc67, LSL #48
    MOVZ  X3, #0xa287, LSL #0
    MOVK  X3, #0x1f08, LSL #16
    MOVK  X3, #0x319d, LSL #32
    MOVK  X3, #0xdaa0, LSL #48
    MOVZ  X4, #0x2d84, LSL #0
    MOVK  X4, #0xfe0b, LSL #16
    MOVK  X4, #0x160d, LSL #32
    MOVK  X4, #0x7158, LSL #48
    MOVZ  X5, #0xf9d3, LSL #0
    MOVK  X5, #0xa7e9, LSL #16
    MOVK  X5, #0x3da9, LSL #32
    MOVK  X5, #0x29a6, LSL #48
    MOVZ  X6, #0xa2d9, LSL #0
    MOVK  X6, #0x6c06, LSL #16
    MOVK  X6, #0x2857, LSL #32
    MOVK  X6, #0x707e, LSL #48
    MOVZ  X7, #0x6739, LSL #0
    MOVK  X7, #0x2613, LSL #16
    MOVK  X7, #0xfcb8, LSL #32
    MOVK  X7, #0xa418, LSL #48
    MOVZ  X8, #0xd1d3, LSL #0
    MOVK  X8, #0x2bdd, LSL #16
    MOVK  X8, #0xe922, LSL #32
    MOVK  X8, #0xa7ff, LSL #48
    MOVZ  X9, #0x6c15, LSL #0
    MOVK  X9, #0x58d3, LSL #16
    MOVK  X9, #0xd9d0, LSL #32
    MOVK  X9, #0xad4a, LSL #48
    MOVZ  X12, #0xe1c5, LSL #0
    MOVK  X12, #0xc01e, LSL #16
    MOVK  X12, #0x1ffc, LSL #32
    MOVK  X12, #0x1ffb, LSL #48
    MOVZ  X16, #0x7209, LSL #0
    MOVK  X16, #0xf1e9, LSL #16
    MOVK  X16, #0xd83d, LSL #32
    MOVK  X16, #0x2795, LSL #48
    MOVZ  X17, #0x3a11, LSL #0
    MOVK  X17, #0x6bfa, LSL #16
    MOVK  X17, #0xf477, LSL #32
    MOVK  X17, #0x2556, LSL #48
    MOVZ  X18, #0xfb3c, LSL #0
    MOVK  X18, #0xef13, LSL #16
    MOVK  X18, #0xd1a2, LSL #32
    MOVK  X18, #0x2e41, LSL #48
    MOVZ  X19, #0x4a0f, LSL #0
    MOVK  X19, #0xcf52, LSL #16
    MOVK  X19, #0xe3f7, LSL #32
    MOVK  X19, #0xbe92, LSL #48
    MOVZ  X20, #0x7368, LSL #0
    MOVK  X20, #0xdb4e, LSL #16
    MOVK  X20, #0x7d7, LSL #32
    MOVK  X20, #0xeec7, LSL #48
    MOVZ  X21, #0x7477, LSL #0
    MOVK  X21, #0xb00, LSL #16
    MOVK  X21, #0x4ff2, LSL #32
    MOVK  X21, #0x4055, LSL #48
    MOVZ  X22, #0x1a30, LSL #0
    MOVK  X22, #0x9c08, LSL #16
    MOVK  X22, #0x2391, LSL #32
    MOVK  X22, #0xf0f0, LSL #48
    MOVZ  X23, #0xb543, LSL #0
    MOVK  X23, #0x9f0, LSL #16
    MOVK  X23, #0x90c, LSL #32
    MOVK  X23, #0x3829, LSL #48
    MOVZ  X24, #0xbf4e, LSL #0
    MOVK  X24, #0x6688, LSL #16
    MOVK  X24, #0x9114, LSL #32
    MOVK  X24, #0xbc20, LSL #48
    MOVZ  X25, #0x4f62, LSL #0
    MOVK  X25, #0x31df, LSL #16
    MOVK  X25, #0x81d4, LSL #32
    MOVK  X25, #0xd99b, LSL #48
    MOVZ  X26, #0x2478, LSL #0
    MOVK  X26, #0xbda1, LSL #16
    MOVK  X26, #0x3fe9, LSL #32
    MOVK  X26, #0x2481, LSL #48
    MOVZ  X27, #0xba9a, LSL #0
    MOVK  X27, #0x1030, LSL #16
    MOVK  X27, #0x7580, LSL #32
    MOVK  X27, #0xd2ce, LSL #48
    MOVZ  X28, #0x706d, LSL #0
    MOVK  X28, #0x137e, LSL #16
    MOVK  X28, #0x8236, LSL #32
    MOVK  X28, #0x8436, LSL #48
    MOVZ  X29, #0xe30, LSL #0
    MOVK  X29, #0x7f, LSL #16
    MOVK  X29, #0x44ae, LSL #32
    MOVK  X29, #0x193a, LSL #48
    MOVZ  X7, #0x8661, LSL #0
    MOVK  X7, #0x565a, LSL #16
    MOVK  X7, #0xbe62, LSL #32
    MOVK  X7, #0xd98e, LSL #48
    MSR  FPCR, X7
    MRS  X20, FPCR
    MOVZ  X18, #0x60ff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    AND  X20, X20, X18
    MOVZ  X18, #0x0, LSL #0
    ORR  X20, X20, X18
    MSR  FPCR, X20
    ISB  SY
    MOVZ  X7, #0xe224, LSL #0
    MOVK  X7, #0x3b5f, LSL #16
    MOVK  X7, #0x8803, LSL #32
    MOVK  X7, #0x83c4, LSL #48
    MSR  FPSR, X7
    MRS  X24, FPSR
    MOVZ  X19, #0xff60, LSL #0
    MOVK  X19, #0x7ff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    AND  X24, X24, X19
    MOVZ  X19, #0x0, LSL #0
    ORR  X24, X24, X19
    MSR  FPSR, X24
    ISB  SY
    ADDS  X2, X20, X20, LSL #28
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x9ae3, LSL #0
    MOVK  X2, #0x3c33, LSL #16
    MOVK  X2, #0x4191, LSL #32
    MOVK  X2, #0x6c4b, LSL #48
    MOVZ  X3, #0x1bc5, LSL #0
    MOVK  X3, #0x39e7, LSL #16
    MOVK  X3, #0xeecc, LSL #32
    MOVK  X3, #0x798a, LSL #48
    MOVZ  X4, #0x352f, LSL #0
    MOVK  X4, #0xd9e6, LSL #16
    MOVK  X4, #0xaca2, LSL #32
    MOVK  X4, #0xc661, LSL #48
    MOVZ  X5, #0x54a9, LSL #0
    MOVK  X5, #0x839b, LSL #16
    MOVK  X5, #0xcc8a, LSL #32
    MOVK  X5, #0x5041, LSL #48
    MOVZ  X6, #0xfabd, LSL #0
    MOVK  X6, #0xadb, LSL #16
    MOVK  X6, #0x877e, LSL #32
    MOVK  X6, #0xf3d8, LSL #48
    MOVZ  X7, #0xa681, LSL #0
    MOVK  X7, #0x1aef, LSL #16
    MOVK  X7, #0x7134, LSL #32
    MOVK  X7, #0xa944, LSL #48
    MOVZ  X8, #0x50e3, LSL #0
    MOVK  X8, #0x1b99, LSL #16
    MOVK  X8, #0x38a9, LSL #32
    MOVK  X8, #0x9451, LSL #48
    MOVZ  X9, #0xb4d5, LSL #0
    MOVK  X9, #0xaa2b, LSL #16
    MOVK  X9, #0x24fe, LSL #32
    MOVK  X9, #0x56af, LSL #48
    MOVZ  X12, #0x525e, LSL #0
    MOVK  X12, #0x248e, LSL #16
    MOVK  X12, #0x7c0a, LSL #32
    MOVK  X12, #0x6681, LSL #48
    MOVZ  X16, #0x2f47, LSL #0
    MOVK  X16, #0x84e1, LSL #16
    MOVK  X16, #0xbbb5, LSL #32
    MOVK  X16, #0x7765, LSL #48
    MOVZ  X17, #0x507a, LSL #0
    MOVK  X17, #0xd450, LSL #16
    MOVK  X17, #0x859f, LSL #32
    MOVK  X17, #0x469b, LSL #48
    MOVZ  X18, #0x4cff, LSL #0
    MOVK  X18, #0x460e, LSL #16
    MOVK  X18, #0x9952, LSL #32
    MOVK  X18, #0x92cf, LSL #48
    MOVZ  X19, #0xa7fa, LSL #0
    MOVK  X19, #0x5355, LSL #16
    MOVK  X19, #0x18e2, LSL #32
    MOVK  X19, #0x5ba0, LSL #48
    MOVZ  X20, #0x5575, LSL #0
    MOVK  X20, #0x1f84, LSL #16
    MOVK  X20, #0x18e9, LSL #32
    MOVK  X20, #0xe4b4, LSL #48
    MOVZ  X21, #0xeb3e, LSL #0
    MOVK  X21, #0x1f48, LSL #16
    MOVK  X21, #0x5d7b, LSL #32
    MOVK  X21, #0xf0d9, LSL #48
    MOVZ  X22, #0xe949, LSL #0
    MOVK  X22, #0x1ef6, LSL #16
    MOVK  X22, #0x3b9c, LSL #32
    MOVK  X22, #0x1082, LSL #48
    MOVZ  X23, #0x54f8, LSL #0
    MOVK  X23, #0x7808, LSL #16
    MOVK  X23, #0x94f4, LSL #32
    MOVK  X23, #0xe35c, LSL #48
    MOVZ  X24, #0x6bfe, LSL #0
    MOVK  X24, #0xbf6c, LSL #16
    MOVK  X24, #0x231f, LSL #32
    MOVK  X24, #0x171a, LSL #48
    MOVZ  X25, #0x3001, LSL #0
    MOVK  X25, #0x2901, LSL #16
    MOVK  X25, #0xbb3f, LSL #32
    MOVK  X25, #0x779b, LSL #48
    MOVZ  X26, #0xc947, LSL #0
    MOVK  X26, #0xa9b3, LSL #16
    MOVK  X26, #0xd1ae, LSL #32
    MOVK  X26, #0xb224, LSL #48
    MOVZ  X27, #0xfba8, LSL #0
    MOVK  X27, #0xbfdc, LSL #16
    MOVK  X27, #0xd214, LSL #32
    MOVK  X27, #0x4e35, LSL #48
    MOVZ  X28, #0x594b, LSL #0
    MOVK  X28, #0x97c9, LSL #16
    MOVK  X28, #0x1bcc, LSL #32
    MOVK  X28, #0x7e75, LSL #48
    MOVZ  X29, #0xad3b, LSL #0
    MOVK  X29, #0xebba, LSL #16
    MOVK  X29, #0xdfd1, LSL #32
    MOVK  X29, #0xce07, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X9
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X4
    FMOV  V3.D[1], X16
    FMOV  D4, X4
    FMOV  V4.D[1], X4
    FMOV  D5, X12
    FMOV  V5.D[1], X19
    FMOV  D6, X5
    FMOV  V6.D[1], X9
    FMOV  D7, X16
    FMOV  V7.D[1], X28
    FMOV  D8, X21
    FMOV  V8.D[1], X25
    FMOV  D9, X21
    FMOV  V9.D[1], X12
    FMOV  D10, X8
    FMOV  V10.D[1], X28
    FMOV  D11, X29
    FMOV  V11.D[1], X28
    FMOV  D12, X20
    FMOV  V12.D[1], X12
    FMOV  D13, X24
    FMOV  V13.D[1], X5
    FMOV  D14, X29
    FMOV  V14.D[1], X29
    FMOV  D15, X12
    FMOV  V15.D[1], X12
    FMOV  D16, X29
    FMOV  V16.D[1], X5
    FMOV  D17, X27
    FMOV  V17.D[1], X6
    FMOV  D18, X19
    FMOV  V18.D[1], X6
    FMOV  D19, X8
    FMOV  V19.D[1], X4
    FMOV  D20, X20
    FMOV  V20.D[1], X19
    FMOV  D21, X17
    FMOV  V21.D[1], X2
    FMOV  D22, X24
    FMOV  V22.D[1], X22
    FMOV  D23, X9
    FMOV  V23.D[1], X8
    FMOV  D24, X4
    FMOV  V24.D[1], X4
    FMOV  D25, X4
    FMOV  V25.D[1], X7
    FMOV  D26, X23
    FMOV  V26.D[1], X24
    FMOV  D27, X23
    FMOV  V27.D[1], X28
    FMOV  D28, X23
    FMOV  V28.D[1], X28
    FMOV  D29, X7
    FMOV  V29.D[1], X6
    FMOV  D30, X3
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X27
    ABS  V22.4H, V30.4H
    ABS  V21.2D, V18.2D
    ABS  V30.8B, V29.8B
    ABS  V12.2S, V24.2S
    ABS  V19.2S, V22.2S
    ABS  V25.8B, V23.8B
    ABS  V30.2S, V18.2S
    ABS  V30.2D, V13.2D
    ABS  V1.4H, V3.4H
    ABS  V18.4H, V19.4H
    ADD  V20.4S, V18.4S, V31.4S
    ADD  V26.4H, V1.4H, V12.4H
    ADD  V14.8B, V26.8B, V16.8B
    ADD  V31.8B, V21.8B, V28.8B
    ADD  V21.2S, V30.2S, V14.2S
    ADD  V29.8H, V21.8H, V20.8H
    ADD  V24.4S, V29.4S, V13.4S
    ADD  V21.8B, V27.8B, V28.8B
    ADD  V26.8H, V24.8H, V31.8H
    ADD  V15.2S, V21.2S, V6.2S
    ADDHN  V18.4H, V28.4S, V25.4S
    ADDHN  V30.2S, V15.2D, V26.2D
    ADDHN  V15.2S, V11.2D, V27.2D
    ADDHN  V29.4H, V30.4S, V2.4S
    ADDHN  V19.8B, V5.8H, V20.8H
    ADDHN  V13.2S, V15.2D, V18.2D
    ADDHN  V6.2S, V26.2D, V15.2D
    ADDHN  V12.8B, V15.8H, V3.8H
    ADDHN  V20.8B, V1.8H, V11.8H
    ADDHN  V2.8B, V1.8H, V19.8H
    ADDHN2  V15.8H, V7.4S, V10.4S
    ADDHN2  V3.4S, V16.2D, V19.2D
    ADDHN2  V28.4S, V18.2D, V11.2D
    ADDHN2  V7.8H, V27.4S, V28.4S
    ADDHN2  V26.16B, V2.8H, V2.8H
    ADDHN2  V1.8H, V6.4S, V6.4S
    ADDHN2  V30.16B, V22.8H, V7.8H
    ADDHN2  V25.16B, V8.8H, V15.8H
    ADDHN2  V6.16B, V17.8H, V30.8H
    ADDHN2  V7.8H, V14.4S, V2.4S
    ADDP  D15, V10.2D
    ADDP  D19, V3.2D
    ADDP  D5, V1.2D
    ADDP  D22, V26.2D
    ADDP  D31, V5.2D
    ADDP  D30, V6.2D
    ADDP  D18, V25.2D
    ADDP  D3, V20.2D
    ADDP  D28, V8.2D
    ADDP  D25, V28.2D
    ADDP  V17.4H, V7.4H, V12.4H
    ADDP  V14.4H, V15.4H, V17.4H
    ADDP  V16.8B, V14.8B, V10.8B
    ADDP  V15.16B, V25.16B, V18.16B
    ADDP  V14.2D, V20.2D, V31.2D
    ADDP  V6.8H, V13.8H, V15.8H
    ADDP  V30.4H, V6.4H, V30.4H
    ADDP  V2.8H, V28.8H, V3.8H
    ADDP  V1.2D, V5.2D, V25.2D
    ADDP  V10.2D, V16.2D, V2.2D
    ADDV  B25, V22.8B
    ADDV  B27, V11.8B
    ADDV  B5, V1.16B
    ADDV  B18, V10.8B
    ADDV  B4, V18.8B
    ADDV  B17, V26.8B
    ADDV  B13, V5.8B
    ADDV  B2, V17.16B
    ADDV  B22, V23.16B
    ADDV  B18, V31.8B
    ADDV  H11, V25.4H
    ADDV  H5, V8.8H
    ADDV  H28, V5.4H
    ADDV  H17, V24.8H
    ADDV  H15, V30.8H
    ADDV  H23, V13.4H
    ADDV  H31, V22.4H
    ADDV  H24, V18.8H
    ADDV  H30, V1.4H
    ADDV  H22, V17.8H
    ADDV  S26, V4.4S
    ADDV  S18, V11.4S
    ADDV  S1, V2.4S
    ADDV  S8, V1.4S
    ADDV  S2, V15.4S
    ADDV  S10, V22.4S
    ADDV  S4, V30.4S
    ADDV  S22, V27.4S
    ADDV  S15, V18.4S
    ADDV  S30, V21.4S
    AESD  V18.16B, V2.16B
    AESD  V27.16B, V8.16B
    AESD  V25.16B, V12.16B
    AESD  V1.16B, V10.16B
    AESD  V11.16B, V23.16B
    AESD  V28.16B, V11.16B
    AESD  V17.16B, V4.16B
    AESD  V21.16B, V17.16B
    AESD  V21.16B, V24.16B
    AESD  V29.16B, V21.16B
    AESE  V17.16B, V22.16B
    AESE  V13.16B, V30.16B
    AESE  V23.16B, V24.16B
    AESE  V24.16B, V8.16B
    AESE  V0.16B, V15.16B
    AESE  V2.16B, V25.16B
    AESE  V27.16B, V17.16B
    AESE  V11.16B, V26.16B
    AESE  V14.16B, V27.16B
    AESE  V10.16B, V24.16B
    AESIMC  V15.16B, V29.16B
    AESIMC  V14.16B, V1.16B
    AESIMC  V4.16B, V7.16B
    AESIMC  V12.16B, V25.16B
    AESIMC  V25.16B, V11.16B
    AESIMC  V29.16B, V14.16B
    AESIMC  V5.16B, V23.16B
    AESIMC  V8.16B, V10.16B
    AESIMC  V0.16B, V2.16B
    AESIMC  V14.16B, V0.16B
    AESMC  V7.16B, V14.16B
    AESMC  V10.16B, V8.16B
    AESMC  V2.16B, V17.16B
    AESMC  V1.16B, V7.16B
    AESMC  V7.16B, V25.16B
    AESMC  V23.16B, V9.16B
    AESMC  V0.16B, V17.16B
    AESMC  V14.16B, V26.16B
    AESMC  V17.16B, V12.16B
    AESMC  V25.16B, V23.16B
    AND  V27.8B, V29.8B, V29.8B
    AND  V9.8B, V11.8B, V14.8B
    AND  V14.16B, V15.16B, V28.16B
    AND  V24.16B, V14.16B, V0.16B
    AND  V22.16B, V9.16B, V25.16B
    AND  V4.16B, V4.16B, V24.16B
    AND  V16.8B, V27.8B, V5.8B
    AND  V9.16B, V4.16B, V3.16B
    AND  V11.16B, V1.16B, V10.16B
    AND  V23.16B, V7.16B, V2.16B
    BIC  V12.4H, #0xc6
    BIC  V2.4H, #0x1e, LSL #8
    BIC  V27.8H, #0x6, LSL #8
    BIC  V0.4H, #0x81, LSL #8
    BIC  V25.4H, #0xf0, LSL #8
    BIC  V0.4H, #0x70, LSL #8
    BIC  V28.8H, #0xea
    BIC  V5.4H, #0x30
    BIC  V8.8H, #0x80
    BIC  V7.4H, #0xd3, LSL #8
    BIC  V1.4S, #0x4c
    BIC  V23.4S, #0xe0, LSL #24
    BIC  V4.2S, #0x5, LSL #16
    BIC  V13.4S, #0x55, LSL #16
    BIC  V24.4S, #0x1d, LSL #8
    BIC  V14.4S, #0x44, LSL #8
    BIC  V1.2S, #0xec, LSL #8
    BIC  V3.4S, #0x5f, LSL #8
    BIC  V10.4S, #0x1b, LSL #8
    BIC  V0.4S, #0x1b
    BIC  V24.8B, V25.8B, V10.8B
    BIC  V3.16B, V7.16B, V13.16B
    BIC  V8.8B, V24.8B, V22.8B
    BIC  V14.8B, V5.8B, V14.8B
    BIC  V21.8B, V15.8B, V8.8B
    BIC  V24.16B, V12.16B, V11.16B
    BIC  V30.8B, V21.8B, V14.8B
    BIC  V29.8B, V4.8B, V10.8B
    BIC  V25.8B, V1.8B, V20.8B
    BIC  V8.8B, V27.8B, V30.8B
    BIF  V11.16B, V7.16B, V28.16B
    BIF  V22.8B, V29.8B, V23.8B
    BIF  V23.8B, V25.8B, V3.8B
    BIF  V11.8B, V8.8B, V11.8B
    BIF  V3.8B, V24.8B, V24.8B
    BIF  V28.8B, V3.8B, V0.8B
    BIF  V20.8B, V23.8B, V0.8B
    BIF  V12.8B, V9.8B, V13.8B
    BIF  V27.16B, V20.16B, V12.16B
    BIF  V8.16B, V16.16B, V23.16B
    BIT  V15.16B, V2.16B, V11.16B
    BIT  V5.16B, V24.16B, V30.16B
    BIT  V28.16B, V6.16B, V15.16B
    BIT  V30.8B, V5.8B, V27.8B
    BIT  V25.8B, V28.8B, V8.8B
    BIT  V16.16B, V30.16B, V30.16B
    BIT  V4.16B, V16.16B, V8.16B
    BIT  V12.8B, V25.8B, V16.8B
    BIT  V0.8B, V0.8B, V22.8B
    BIT  V7.8B, V29.8B, V0.8B
    BSL  V21.8B, V4.8B, V6.8B
    BSL  V29.8B, V30.8B, V10.8B
    BSL  V16.8B, V12.8B, V12.8B
    BSL  V8.16B, V29.16B, V12.16B
    BSL  V1.16B, V3.16B, V7.16B
    BSL  V25.16B, V21.16B, V1.16B
    BSL  V13.8B, V25.8B, V25.8B
    BSL  V7.8B, V8.8B, V18.8B
    BSL  V6.16B, V16.16B, V13.16B
    BSL  V11.16B, V12.16B, V22.16B
    CLS  V24.16B, V0.16B
    CLS  V12.2S, V9.2S
    CLS  V20.8H, V31.8H
    CLS  V30.8B, V5.8B
    CLS  V31.4H, V9.4H
    CLS  V21.8B, V24.8B
    CLS  V8.8B, V25.8B
    CLS  V22.8B, V20.8B
    CLS  V0.4H, V28.4H
    CLS  V1.4H, V22.4H
    CLZ  V9.16B, V7.16B
    CLZ  V5.8B, V1.8B
    CLZ  V28.8B, V20.8B
    CLZ  V1.4S, V12.4S
    CLZ  V7.4S, V21.4S
    CLZ  V13.2S, V8.2S
    CLZ  V22.4S, V0.4S
    CLZ  V12.16B, V13.16B
    CLZ  V25.16B, V31.16B
    CLZ  V3.4H, V11.4H
    CNT  V23.16B, V1.16B
    CNT  V0.16B, V6.16B
    CNT  V1.8B, V28.8B
    CNT  V28.16B, V9.16B
    CNT  V20.8B, V17.8B
    CNT  V17.8B, V12.8B
    CNT  V23.8B, V0.8B
    CNT  V8.16B, V3.16B
    CNT  V9.16B, V7.16B
    CNT  V13.8B, V22.8B
    DUP B0, V23.B[0x0]
    DUP B11, V30.B[0x7]
    DUP B0, V13.B[0x2]
    DUP B3, V5.B[0x9]
    DUP B21, V17.B[0x4]
    DUP B17, V28.B[0xb]
    DUP B18, V11.B[0x6]
    DUP B13, V6.B[0x5]
    DUP B31, V8.B[0xc]
    DUP B4, V1.B[0xa]
    DUP D23, V3.D[0x0]
    DUP D30, V17.D[0x1]
    DUP D26, V20.D[0x1]
    DUP D7, V18.D[0x0]
    DUP D20, V27.D[0x0]
    DUP D1, V4.D[0x0]
    DUP D3, V13.D[0x0]
    DUP D22, V26.D[0x1]
    DUP D18, V20.D[0x0]
    DUP D27, V0.D[0x1]
    DUP H6, V19.H[0x7]
    DUP H13, V23.H[0x4]
    DUP H8, V7.H[0x5]
    DUP H20, V8.H[0x3]
    DUP H17, V9.H[0x5]
    DUP H26, V22.H[0x6]
    DUP H7, V18.H[0x4]
    DUP H21, V3.H[0x5]
    DUP H9, V26.H[0x7]
    DUP H8, V7.H[0x4]
    DUP S4, V1.S[0x3]
    DUP S3, V19.S[0x2]
    DUP S1, V4.S[0x1]
    DUP S23, V1.S[0x0]
    DUP S7, V25.S[0x3]
    DUP S1, V27.S[0x0]
    DUP S20, V13.S[0x3]
    DUP S18, V31.S[0x1]
    DUP S10, V15.S[0x3]
    DUP S31, V20.S[0x1]
    DUP  V13.16B, V8.B[0x8]
    DUP  V26.8B, V1.B[0x2]
    DUP  V20.8B, V18.B[0x2]
    DUP  V25.16B, V6.B[0x7]
    DUP  V0.8B, V31.B[0x4]
    DUP  V27.16B, V25.B[0xb]
    DUP  V19.16B, V27.B[0x0]
    DUP  V8.8B, V7.B[0x1]
    DUP  V15.8B, V9.B[0xa]
    DUP  V7.16B, V13.B[0x8]
    DUP V30.2D, V29.D[0x0]
    DUP V6.2D, V30.D[0x0]
    DUP V1.2D, V23.D[0x0]
    DUP V13.2D, V19.D[0x0]
    DUP V25.2D, V15.D[0x1]
    DUP V29.2D, V13.D[0x0]
    DUP V19.2D, V10.D[0x1]
    DUP V23.2D, V8.D[0x1]
    DUP V10.2D, V26.D[0x1]
    DUP V31.2D, V25.D[0x0]
    DUP  V26.4H, V7.H[0x3]
    DUP  V29.8H, V6.H[0x2]
    DUP  V4.4H, V5.H[0x4]
    DUP  V27.4H, V18.H[0x5]
    DUP  V5.4H, V6.H[0x0]
    DUP  V7.4H, V31.H[0x6]
    DUP  V13.8H, V27.H[0x6]
    DUP  V7.4H, V1.H[0x0]
    DUP  V8.4H, V19.H[0x6]
    DUP  V15.8H, V4.H[0x7]
    MOVZ  X16, #0x9ae3, LSL #0
    MOVK  X16, #0x3c33, LSL #16
    MOVK  X16, #0x4191, LSL #32
    MOVK  X16, #0x6c4b, LSL #48
    SUB  X19, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x1bc5, LSL #0
    MOVK  X16, #0x39e7, LSL #16
    MOVK  X16, #0xeecc, LSL #32
    MOVK  X16, #0x798a, LSL #48
    SUB  X19, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x352f, LSL #0
    MOVK  X16, #0xd9e6, LSL #16
    MOVK  X16, #0xaca2, LSL #32
    MOVK  X16, #0xc661, LSL #48
    SUB  X19, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x54a9, LSL #0
    MOVK  X16, #0x839b, LSL #16
    MOVK  X16, #0xcc8a, LSL #32
    MOVK  X16, #0x5041, LSL #48
    SUB  X19, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xfabd, LSL #0
    MOVK  X16, #0xadb, LSL #16
    MOVK  X16, #0x877e, LSL #32
    MOVK  X16, #0xf3d8, LSL #48
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xa681, LSL #0
    MOVK  X16, #0x1aef, LSL #16
    MOVK  X16, #0x7134, LSL #32
    MOVK  X16, #0xa944, LSL #48
    SUB  X19, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x50e3, LSL #0
    MOVK  X16, #0x1b99, LSL #16
    MOVK  X16, #0x38a9, LSL #32
    MOVK  X16, #0x9451, LSL #48
    SUB  X19, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xb4d5, LSL #0
    MOVK  X16, #0xaa2b, LSL #16
    MOVK  X16, #0x24fe, LSL #32
    MOVK  X16, #0x56af, LSL #48
    SUB  X19, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x525e, LSL #0
    MOVK  X16, #0x248e, LSL #16
    MOVK  X16, #0x7c0a, LSL #32
    MOVK  X16, #0x6681, LSL #48
    SUB  X19, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x507a, LSL #0
    MOVK  X16, #0xd450, LSL #16
    MOVK  X16, #0x859f, LSL #32
    MOVK  X16, #0x469b, LSL #48
    SUB  X19, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x4cff, LSL #0
    MOVK  X16, #0x460e, LSL #16
    MOVK  X16, #0x9952, LSL #32
    MOVK  X16, #0x92cf, LSL #48
    SUB  X19, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x5575, LSL #0
    MOVK  X16, #0x1f84, LSL #16
    MOVK  X16, #0x18e9, LSL #32
    MOVK  X16, #0xe4b4, LSL #48
    SUB  X19, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xeb3e, LSL #0
    MOVK  X16, #0x1f48, LSL #16
    MOVK  X16, #0x5d7b, LSL #32
    MOVK  X16, #0xf0d9, LSL #48
    SUB  X19, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xe949, LSL #0
    MOVK  X16, #0x1ef6, LSL #16
    MOVK  X16, #0x3b9c, LSL #32
    MOVK  X16, #0x1082, LSL #48
    SUB  X19, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x54f8, LSL #0
    MOVK  X16, #0x7808, LSL #16
    MOVK  X16, #0x94f4, LSL #32
    MOVK  X16, #0xe35c, LSL #48
    SUB  X19, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x6bfe, LSL #0
    MOVK  X16, #0xbf6c, LSL #16
    MOVK  X16, #0x231f, LSL #32
    MOVK  X16, #0x171a, LSL #48
    SUB  X19, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xc947, LSL #0
    MOVK  X16, #0xa9b3, LSL #16
    MOVK  X16, #0xd1ae, LSL #32
    MOVK  X16, #0xb224, LSL #48
    SUB  X19, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xfba8, LSL #0
    MOVK  X16, #0xbfdc, LSL #16
    MOVK  X16, #0xd214, LSL #32
    MOVK  X16, #0x4e35, LSL #48
    SUB  X19, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x594b, LSL #0
    MOVK  X16, #0x97c9, LSL #16
    MOVK  X16, #0x1bcc, LSL #32
    MOVK  X16, #0x7e75, LSL #48
    SUB  X19, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xad3b, LSL #0
    MOVK  X16, #0xebba, LSL #16
    MOVK  X16, #0xdfd1, LSL #32
    MOVK  X16, #0xce07, LSL #48
    SUB  X19, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X16, FPSR
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D0
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D1
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D2
    MOVZ  X19, #0x60c6, LSL #0
    MOVK  X19, #0xa0b0, LSL #16
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D4
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D5
    MOVZ  X19, #0xe0e7, LSL #0
    MOVK  X19, #0xe0e7, LSL #16
    MOVK  X19, #0xe0e7, LSL #32
    MOVK  X19, #0xe0e7, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X19, #0xe0e7, LSL #0
    MOVK  X19, #0xfbfb, LSL #16
    MOVK  X19, #0xe0fb, LSL #32
    MOVK  X19, #0xfbfb, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D6
    MOVZ  X19, #0xe0e7, LSL #0
    MOVK  X19, #0xfbfb, LSL #16
    MOVK  X19, #0xe0fb, LSL #32
    MOVK  X19, #0xfbfb, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D9
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X19, #0x808, LSL #0
    MOVK  X19, #0x808, LSL #16
    MOVK  X19, #0x808, LSL #32
    MOVK  X19, #0x808, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D12
    MOVZ  X19, #0x805, LSL #0
    MOVK  X19, #0x808, LSL #16
    MOVK  X19, #0x805, LSL #32
    MOVK  X19, #0x808, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D14
    MOVZ  X19, #0x6c09, LSL #0
    MOVK  X19, #0x78a, LSL #16
    MOVK  X19, #0x4303, LSL #32
    MOVK  X19, #0x2343, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D16
    MOVZ  X19, #0x6040, LSL #0
    MOVK  X19, #0x120, LSL #16
    MOVK  X19, #0x4301, LSL #32
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D19
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D21
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X19, #0x707, LSL #0
    MOVK  X19, #0x707, LSL #16
    MOVK  X19, #0x707, LSL #32
    MOVK  X19, #0x707, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D24
    MOVZ  X19, #0x301, LSL #0
    MOVK  X19, #0x300, LSL #16
    MOVK  X19, #0x707, LSL #32
    MOVK  X19, #0x707, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X19, #0x101, LSL #0
    MOVK  X19, #0x101, LSL #16
    MOVK  X19, #0x101, LSL #32
    MOVK  X19, #0x101, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D28
    MOVZ  X19, #0x100, LSL #0
    MOVK  X19, #0x101, LSL #16
    MOVK  X19, #0x101, LSL #32
    MOVK  X19, #0x101, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X19, #0xe0fb, LSL #0
    MOVK  X19, #0xe0fb, LSL #16
    MOVK  X19, #0xe0fb, LSL #32
    MOVK  X19, #0xe0fb, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D29
    MOVZ  X19, #0xe0fb, LSL #0
    MOVK  X19, #0xe0fb, LSL #16
    MOVK  X19, #0xe0fb, LSL #32
    MOVK  X19, #0xe0fb, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X19, #0xe0e7, LSL #0
    MOVK  X19, #0xfbfb, LSL #16
    MOVK  X19, #0xe0fb, LSL #32
    MOVK  X19, #0xfbfb, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D30
    MOVZ  X19, #0xe0e7, LSL #0
    MOVK  X19, #0xfbfb, LSL #16
    MOVK  X19, #0xe0fb, LSL #32
    MOVK  X19, #0xfbfb, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D31
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0xb720, LSL #0
    MOVK  X2, #0xe88a, LSL #16
    MOVK  X2, #0x49d8, LSL #32
    MOVK  X2, #0x9e79, LSL #48
    MOVZ  X3, #0x38ef, LSL #0
    MOVK  X3, #0xb05a, LSL #16
    MOVK  X3, #0x27bb, LSL #32
    MOVK  X3, #0xd198, LSL #48
    MOVZ  X4, #0x290b, LSL #0
    MOVK  X4, #0x2829, LSL #16
    MOVK  X4, #0x7a16, LSL #32
    MOVK  X4, #0x23d5, LSL #48
    MOVZ  X5, #0x3c65, LSL #0
    MOVK  X5, #0x231d, LSL #16
    MOVK  X5, #0x8a7a, LSL #32
    MOVK  X5, #0x1ad4, LSL #48
    MOVZ  X6, #0xd91a, LSL #0
    MOVK  X6, #0xa771, LSL #16
    MOVK  X6, #0x209a, LSL #32
    MOVK  X6, #0xde1f, LSL #48
    MOVZ  X7, #0x12de, LSL #0
    MOVK  X7, #0x281f, LSL #16
    MOVK  X7, #0x27e, LSL #32
    MOVK  X7, #0xda65, LSL #48
    MOVZ  X8, #0x90e3, LSL #0
    MOVK  X8, #0xa53a, LSL #16
    MOVK  X8, #0x6b2f, LSL #32
    MOVK  X8, #0xa1a2, LSL #48
    MOVZ  X9, #0x7e7b, LSL #0
    MOVK  X9, #0xa4f2, LSL #16
    MOVK  X9, #0x4e6, LSL #32
    MOVK  X9, #0x8c46, LSL #48
    MOVZ  X12, #0xb799, LSL #0
    MOVK  X12, #0x6bd0, LSL #16
    MOVK  X12, #0x7952, LSL #32
    MOVK  X12, #0xb1f5, LSL #48
    MOVZ  X16, #0x7418, LSL #0
    MOVK  X16, #0xbbb6, LSL #16
    MOVK  X16, #0x2e11, LSL #32
    MOVK  X16, #0xa6e4, LSL #48
    MOVZ  X17, #0x3388, LSL #0
    MOVK  X17, #0x67e6, LSL #16
    MOVK  X17, #0x81a2, LSL #32
    MOVK  X17, #0xc399, LSL #48
    MOVZ  X18, #0xa328, LSL #0
    MOVK  X18, #0x66b7, LSL #16
    MOVK  X18, #0xad70, LSL #32
    MOVK  X18, #0xcecb, LSL #48
    MOVZ  X19, #0xa31f, LSL #0
    MOVK  X19, #0xd056, LSL #16
    MOVK  X19, #0xea68, LSL #32
    MOVK  X19, #0xf2ea, LSL #48
    MOVZ  X20, #0x548b, LSL #0
    MOVK  X20, #0x33a7, LSL #16
    MOVK  X20, #0x561d, LSL #32
    MOVK  X20, #0xa3e9, LSL #48
    MOVZ  X21, #0xcfe5, LSL #0
    MOVK  X21, #0x8800, LSL #16
    MOVK  X21, #0x56fb, LSL #32
    MOVK  X21, #0x8015, LSL #48
    MOVZ  X22, #0xc7fc, LSL #0
    MOVK  X22, #0x5d32, LSL #16
    MOVK  X22, #0x2d2d, LSL #32
    MOVK  X22, #0x826, LSL #48
    MOVZ  X23, #0x5ec9, LSL #0
    MOVK  X23, #0x72c6, LSL #16
    MOVK  X23, #0x3798, LSL #32
    MOVK  X23, #0x49e7, LSL #48
    MOVZ  X24, #0x107f, LSL #0
    MOVK  X24, #0x233, LSL #16
    MOVK  X24, #0xdb16, LSL #32
    MOVK  X24, #0x5c13, LSL #48
    MOVZ  X25, #0xb783, LSL #0
    MOVK  X25, #0x298e, LSL #16
    MOVK  X25, #0x9629, LSL #32
    MOVK  X25, #0xa0ed, LSL #48
    MOVZ  X26, #0x5406, LSL #0
    MOVK  X26, #0xc936, LSL #16
    MOVK  X26, #0xbd15, LSL #32
    MOVK  X26, #0xc10a, LSL #48
    MOVZ  X27, #0x9f28, LSL #0
    MOVK  X27, #0x23c7, LSL #16
    MOVK  X27, #0x7945, LSL #32
    MOVK  X27, #0x93e2, LSL #48
    MOVZ  X28, #0x3641, LSL #0
    MOVK  X28, #0x668a, LSL #16
    MOVK  X28, #0xa05d, LSL #32
    MOVK  X28, #0x9655, LSL #48
    MOVZ  X29, #0x2ae6, LSL #0
    MOVK  X29, #0x335e, LSL #16
    MOVK  X29, #0xd56c, LSL #32
    MOVK  X29, #0x3007, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X7
    FMOV  D3, X20
    FMOV  V3.D[1], X19
    FMOV  D4, X8
    FMOV  V4.D[1], X9
    FMOV  D5, X24
    FMOV  V5.D[1], X22
    FMOV  D6, X28
    FMOV  V6.D[1], X23
    FMOV  D7, X29
    FMOV  V7.D[1], X4
    FMOV  D8, X7
    FMOV  V8.D[1], X5
    FMOV  D9, X2
    FMOV  V9.D[1], X18
    FMOV  D10, X5
    FMOV  V10.D[1], X27
    FMOV  D11, X12
    FMOV  V11.D[1], X4
    FMOV  D12, X6
    FMOV  V12.D[1], X19
    FMOV  D13, X6
    FMOV  V13.D[1], X25
    FMOV  D14, X25
    FMOV  V14.D[1], X7
    FMOV  D15, X9
    FMOV  V15.D[1], X5
    FMOV  D16, X17
    FMOV  V16.D[1], X5
    FMOV  D17, X23
    FMOV  V17.D[1], X25
    FMOV  D18, X28
    FMOV  V18.D[1], X3
    FMOV  D19, X27
    FMOV  V19.D[1], X25
    FMOV  D20, X27
    FMOV  V20.D[1], X18
    FMOV  D21, X24
    FMOV  V21.D[1], X17
    FMOV  D22, X16
    FMOV  V22.D[1], X4
    FMOV  D23, X22
    FMOV  V23.D[1], X8
    FMOV  D24, X25
    FMOV  V24.D[1], X3
    FMOV  D25, X3
    FMOV  V25.D[1], X28
    FMOV  D26, X24
    FMOV  V26.D[1], X25
    FMOV  D27, X19
    FMOV  V27.D[1], X24
    FMOV  D28, X19
    FMOV  V28.D[1], X18
    FMOV  D29, X23
    FMOV  V29.D[1], X20
    FMOV  D30, X17
    FMOV  V30.D[1], X23
    FMOV  D31, X22
    FMOV  V31.D[1], X29
    DUP  V6.4S, V28.S[0x1]
    DUP  V9.2S, V4.S[0x2]
    DUP  V4.2S, V24.S[0x3]
    DUP  V27.2S, V29.S[0x3]
    DUP  V19.4S, V27.S[0x2]
    DUP  V1.4S, V30.S[0x2]
    DUP  V10.2S, V7.S[0x2]
    DUP  V6.2S, V31.S[0x3]
    DUP  V30.4S, V21.S[0x3]
    DUP  V26.2S, V1.S[0x0]
    DUP V30.16B, W27
    DUP V3.16B, W29
    DUP V13.16B, W23
    DUP V27.16B, W9
    DUP V9.8B, W7
    DUP V11.8B, W4
    DUP V0.8B, W9
    DUP V7.8B, W22
    DUP V2.8B, W8
    DUP V25.16B, W5
    DUP V16.2D, X19
    DUP V5.2D, X2
    DUP V18.2D, X20
    DUP V9.2D, X17
    DUP V4.2D, X27
    DUP V1.2D, X29
    DUP V17.2D, X4
    DUP V0.2D, X12
    DUP V18.2D, X21
    DUP V31.2D, X26
    DUP V6.8H, W23
    DUP V24.8H, W3
    DUP V30.4H, W4
    DUP V1.8H, W20
    DUP V16.4H, W26
    DUP V30.8H, W9
    DUP V31.4H, W22
    DUP V2.8H, W23
    DUP V15.4H, W23
    DUP V8.8H, W8
    DUP V9.4S, W25
    DUP V6.4S, W29
    DUP V26.4S, W19
    DUP V17.2S, W23
    DUP V12.4S, W20
    DUP V11.4S, W29
    DUP V25.4S, W25
    DUP V18.2S, W19
    DUP V15.4S, W8
    DUP V26.4S, W3
    EOR  V10.16B, V31.16B, V10.16B
    EOR  V11.8B, V30.8B, V29.8B
    EOR  V26.16B, V17.16B, V8.16B
    EOR  V22.16B, V25.16B, V24.16B
    EOR  V1.8B, V16.8B, V16.8B
    EOR  V29.16B, V0.16B, V1.16B
    EOR  V28.8B, V29.8B, V29.8B
    EOR  V8.8B, V31.8B, V15.8B
    EOR  V21.8B, V26.8B, V18.8B
    EOR  V6.16B, V11.16B, V22.16B
    EXT  V21.16B, V26.16B, V31.16B, #0xd
    EXT  V30.16B, V6.16B, V25.16B, #0xc
    EXT  V4.16B, V6.16B, V30.16B, #0x5
    EXT  V15.16B, V12.16B, V12.16B, #0x8
    EXT  V22.16B, V10.16B, V8.16B, #0xb
    EXT  V0.16B, V3.16B, V15.16B, #0x0
    EXT  V31.16B, V4.16B, V9.16B, #0x0
    EXT  V16.16B, V22.16B, V31.16B, #0x2
    EXT  V4.16B, V3.16B, V20.16B, #0x2
    EXT  V31.16B, V14.16B, V31.16B, #0x7
    EXT  V3.8B, V19.8B, V31.8B, #0x0
    EXT  V17.8B, V21.8B, V4.8B, #0x6
    EXT  V16.8B, V3.8B, V9.8B, #0x3
    EXT  V3.8B, V16.8B, V21.8B, #0x4
    EXT  V26.8B, V17.8B, V7.8B, #0x2
    EXT  V7.8B, V26.8B, V28.8B, #0x1
    EXT  V29.8B, V24.8B, V7.8B, #0x0
    EXT  V6.8B, V3.8B, V22.8B, #0x7
    EXT  V30.8B, V6.8B, V6.8B, #0x0
    EXT  V16.8B, V29.8B, V29.8B, #0x7
    SUB  V6.2S, V12.2S, V16.2S
    SUB  V17.4H, V6.4H, V9.4H
    SUB  V11.8B, V0.8B, V4.8B
    SUB  V23.2S, V11.2S, V28.2S
    SUB  V20.16B, V8.16B, V23.16B
    SUB  V21.8B, V29.8B, V30.8B
    SUB  V8.16B, V17.16B, V20.16B
    SUB  V17.16B, V1.16B, V19.16B
    SUB  V0.4S, V18.4S, V1.4S
    SUB  V16.2D, V5.2D, V23.2D
    SUBHN  V9.8B, V26.8H, V5.8H
    SUBHN  V19.2S, V5.2D, V16.2D
    SUBHN  V31.4H, V5.4S, V7.4S
    SUBHN  V9.2S, V27.2D, V3.2D
    SUBHN  V24.4H, V9.4S, V29.4S
    SUBHN  V22.4H, V8.4S, V14.4S
    SUBHN  V3.4H, V18.4S, V0.4S
    SUBHN  V16.4H, V0.4S, V13.4S
    SUBHN  V19.2S, V28.2D, V7.2D
    SUBHN  V7.4H, V11.4S, V31.4S
    SUBHN2  V14.16B, V22.8H, V13.8H
    SUBHN2  V20.4S, V14.2D, V17.2D
    SUBHN2  V17.8H, V25.4S, V8.4S
    SUBHN2  V25.16B, V8.8H, V2.8H
    SUBHN2  V18.4S, V28.2D, V20.2D
    SUBHN2  V14.16B, V21.8H, V16.8H
    SUBHN2  V11.16B, V6.8H, V13.8H
    SUBHN2  V28.4S, V19.2D, V24.2D
    SUBHN2  V27.4S, V14.2D, V14.2D
    SUBHN2  V29.8H, V11.4S, V25.4S
    TRN1  V5.2S, V28.2S, V0.2S
    TRN1  V22.8B, V7.8B, V5.8B
    TRN1  V9.8H, V27.8H, V18.8H
    TRN1  V1.4H, V22.4H, V9.4H
    TRN1  V9.2D, V3.2D, V23.2D
    TRN1  V22.8H, V29.8H, V1.8H
    TRN1  V7.8H, V17.8H, V7.8H
    TRN1  V13.2D, V22.2D, V0.2D
    TRN1  V19.8H, V25.8H, V13.8H
    TRN1  V14.8B, V19.8B, V8.8B
    TRN2  V20.8H, V9.8H, V21.8H
    TRN2  V2.2D, V20.2D, V2.2D
    TRN2  V28.8H, V16.8H, V31.8H
    TRN2  V27.4S, V28.4S, V26.4S
    TRN2  V8.16B, V7.16B, V14.16B
    TRN2  V11.8H, V27.8H, V25.8H
    TRN2  V7.2D, V11.2D, V8.2D
    TRN2  V3.8H, V8.8H, V21.8H
    TRN2  V29.2D, V25.2D, V1.2D
    TRN2  V13.2S, V29.2S, V11.2S
    UZP1  V1.8H, V24.8H, V6.8H
    UZP1  V8.16B, V11.16B, V1.16B
    UZP1  V1.4S, V31.4S, V4.4S
    UZP1  V28.2D, V30.2D, V24.2D
    UZP1  V23.2S, V22.2S, V3.2S
    UZP1  V6.8H, V10.8H, V30.8H
    UZP1  V20.16B, V13.16B, V22.16B
    UZP1  V22.2S, V14.2S, V19.2S
    UZP1  V14.4S, V8.4S, V5.4S
    UZP1  V9.4H, V22.4H, V7.4H
    UZP2  V19.4H, V20.4H, V9.4H
    UZP2  V21.8H, V23.8H, V1.8H
    UZP2  V27.2S, V21.2S, V6.2S
    UZP2  V31.2D, V27.2D, V19.2D
    UZP2  V10.8H, V23.8H, V31.8H
    UZP2  V4.8H, V2.8H, V28.8H
    UZP2  V3.4S, V10.4S, V22.4S
    UZP2  V24.4S, V4.4S, V14.4S
    UZP2  V5.8H, V4.8H, V15.8H
    UZP2  V28.16B, V1.16B, V5.16B
    XTN  V23.4H, V19.4S
    XTN  V10.4H, V19.4S
    XTN  V1.2S, V6.2D
    XTN  V31.2S, V6.2D
    XTN  V7.4H, V10.4S
    XTN  V27.2S, V24.2D
    XTN  V10.4H, V26.4S
    XTN  V13.2S, V28.2D
    XTN  V5.2S, V1.2D
    XTN  V2.2S, V8.2D
    XTN2  V14.8H, V26.4S
    XTN2  V24.4S, V2.2D
    XTN2  V8.4S, V7.2D
    XTN2  V4.4S, V5.2D
    XTN2  V8.8H, V4.4S
    XTN2  V6.16B, V23.8H
    XTN2  V15.8H, V29.4S
    XTN2  V4.16B, V14.8H
    XTN2  V17.16B, V0.8H
    XTN2  V0.16B, V18.8H
    ZIP1  V29.4H, V31.4H, V0.4H
    ZIP1  V2.2S, V15.2S, V15.2S
    ZIP1  V31.2D, V21.2D, V31.2D
    ZIP1  V18.2D, V18.2D, V17.2D
    ZIP1  V19.16B, V2.16B, V23.16B
    ZIP1  V0.2S, V29.2S, V3.2S
    ZIP1  V5.8H, V6.8H, V13.8H
    ZIP1  V7.4H, V19.4H, V8.4H
    ZIP1  V28.4S, V27.4S, V19.4S
    ZIP1  V27.2S, V28.2S, V18.2S
    ZIP2  V17.4H, V10.4H, V0.4H
    ZIP2  V15.16B, V18.16B, V31.16B
    ZIP2  V28.8H, V30.8H, V5.8H
    ZIP2  V26.4S, V24.4S, V17.4S
    ZIP2  V21.8H, V21.8H, V7.8H
    ZIP2  V7.8H, V4.8H, V1.8H
    ZIP2  V18.2D, V20.2D, V3.2D
    ZIP2  V3.2S, V7.2S, V28.2S
    ZIP2  V24.4S, V21.4S, V21.4S
    ZIP2  V31.4S, V27.4S, V15.4S
    INS V1.B[0x8], V23.B[0x8]
    INS V19.B[0x6], V20.B[0x6]
    INS V21.B[0x5], V11.B[0xc]
    INS V15.B[0xe], V24.B[0xd]
    INS V2.B[0xd], V15.B[0x1]
    INS V23.B[0xd], V1.B[0x9]
    INS V13.B[0x7], V8.B[0xc]
    INS V11.B[0xb], V2.B[0xd]
    INS V17.B[0x4], V15.B[0x3]
    INS V15.B[0x6], V2.B[0x2]
    INS V8.D[0x0], V31.D[0x0]
    INS V1.D[0x1], V21.D[0x1]
    INS V10.D[0x0], V13.D[0x1]
    INS V30.D[0x0], V17.D[0x1]
    INS V20.D[0x0], V26.D[0x1]
    INS V28.D[0x0], V10.D[0x0]
    INS V22.D[0x0], V19.D[0x1]
    INS V19.D[0x0], V11.D[0x1]
    INS V27.D[0x1], V15.D[0x0]
    INS V15.D[0x1], V30.D[0x1]
    INS V31.H[0x0], V20.H[0x3]
    INS V17.H[0x7], V12.H[0x1]
    INS V11.H[0x3], V15.H[0x2]
    INS V24.H[0x3], V22.H[0x4]
    INS V7.H[0x0], V9.H[0x1]
    INS V21.H[0x0], V19.H[0x0]
    INS V26.H[0x5], V27.H[0x3]
    INS V30.H[0x3], V21.H[0x0]
    INS V15.H[0x0], V28.H[0x7]
    INS V5.H[0x4], V3.H[0x0]
    INS V12.S[0x3], V30.S[0x3]
    INS V2.S[0x2], V5.S[0x0]
    INS V27.S[0x1], V31.S[0x3]
    INS V3.S[0x0], V7.S[0x3]
    INS V10.S[0x3], V27.S[0x0]
    INS V25.S[0x3], V11.S[0x2]
    INS V4.S[0x1], V24.S[0x0]
    INS V24.S[0x3], V11.S[0x2]
    INS V2.S[0x2], V4.S[0x2]
    INS V21.S[0x3], V17.S[0x0]
    INS V7.B[0x2], W6
    INS V11.B[0x0], W17
    INS V17.B[0x5], W7
    INS V5.B[0xa], W26
    INS V19.B[0xd], W21
    INS V31.B[0x4], W7
    INS V9.B[0x4], W28
    INS V27.B[0xf], W17
    INS V28.B[0x3], W2
    INS V30.B[0x1], W3
    INS V4.D[0x0], X4
    INS V2.D[0x0], X3
    INS V7.D[0x0], X23
    INS V29.D[0x0], X20
    INS V0.D[0x1], X4
    INS V16.D[0x1], X27
    INS V19.D[0x1], X23
    INS V2.D[0x0], X12
    INS V8.D[0x1], X23
    INS V31.D[0x1], X27
    INS V9.H[0x2], W20
    INS V28.H[0x0], W5
    INS V16.H[0x5], W29
    INS V1.H[0x5], W29
    INS V15.H[0x6], W21
    INS V20.H[0x6], W17
    INS V3.H[0x2], W8
    INS V10.H[0x3], W20
    INS V11.H[0x5], W23
    INS V18.H[0x1], W28
    INS V26.S[0x0], W8
    INS V19.S[0x3], W12
    INS V23.S[0x0], W6
    INS V20.S[0x1], W21
    INS V28.S[0x2], W9
    INS V21.S[0x3], W22
    INS V23.S[0x1], W26
    INS V21.S[0x2], W17
    INS V14.S[0x1], W23
    INS V18.S[0x3], W9
    MLA  V29.8H, V10.8H, V15.H[0x0]
    MLA  V24.8H, V22.8H, V15.H[0x4]
    MLA  V23.4H, V23.4H, V15.H[0x1]
    MLA  V30.4H, V8.4H, V14.H[0x5]
    MLA  V7.8H, V20.8H, V2.H[0x1]
    MLA  V1.8H, V24.8H, V9.H[0x5]
    MLA  V10.4H, V18.4H, V7.H[0x0]
    MLA  V11.4H, V24.4H, V11.H[0x7]
    MLA  V4.8H, V11.8H, V15.H[0x5]
    MLA  V31.4H, V24.4H, V6.H[0x1]
    MLA  V14.4S, V1.4S, V30.S[0x2]
    MLA  V16.2S, V8.2S, V10.S[0x2]
    MLA  V9.2S, V28.2S, V16.S[0x0]
    MLA  V2.2S, V13.2S, V4.S[0x0]
    MLA  V31.4S, V21.4S, V8.S[0x1]
    MLA  V3.4S, V0.4S, V23.S[0x1]
    MLA  V4.4S, V23.4S, V31.S[0x0]
    MLA  V22.4S, V29.4S, V14.S[0x3]
    MLA  V0.2S, V19.2S, V8.S[0x0]
    MLA  V14.4S, V13.4S, V16.S[0x3]
    MLA  V3.8B, V9.8B, V14.8B
    MLA  V7.4S, V13.4S, V3.4S
    MLA  V18.2S, V4.2S, V22.2S
    MLA  V13.4H, V12.4H, V0.4H
    MLA  V3.8B, V12.8B, V19.8B
    MLA  V16.2S, V3.2S, V2.2S
    MLA  V10.16B, V21.16B, V17.16B
    MLA  V14.16B, V11.16B, V16.16B
    MLA  V21.4S, V4.4S, V7.4S
    MLA  V22.8B, V10.8B, V29.8B
    MOVZ  X16, #0xb720, LSL #0
    MOVK  X16, #0xe88a, LSL #16
    MOVK  X16, #0x49d8, LSL #32
    MOVK  X16, #0x9e79, LSL #48
    SUB  X18, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x38ef, LSL #0
    MOVK  X16, #0xb05a, LSL #16
    MOVK  X16, #0x27bb, LSL #32
    MOVK  X16, #0xd198, LSL #48
    SUB  X18, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x290b, LSL #0
    MOVK  X16, #0x2829, LSL #16
    MOVK  X16, #0x7a16, LSL #32
    MOVK  X16, #0x23d5, LSL #48
    SUB  X18, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x3c65, LSL #0
    MOVK  X16, #0x231d, LSL #16
    MOVK  X16, #0x8a7a, LSL #32
    MOVK  X16, #0x1ad4, LSL #48
    SUB  X18, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xd91a, LSL #0
    MOVK  X16, #0xa771, LSL #16
    MOVK  X16, #0x209a, LSL #32
    MOVK  X16, #0xde1f, LSL #48
    SUB  X18, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x12de, LSL #0
    MOVK  X16, #0x281f, LSL #16
    MOVK  X16, #0x27e, LSL #32
    MOVK  X16, #0xda65, LSL #48
    SUB  X18, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x90e3, LSL #0
    MOVK  X16, #0xa53a, LSL #16
    MOVK  X16, #0x6b2f, LSL #32
    MOVK  X16, #0xa1a2, LSL #48
    SUB  X18, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x7e7b, LSL #0
    MOVK  X16, #0xa4f2, LSL #16
    MOVK  X16, #0x4e6, LSL #32
    MOVK  X16, #0x8c46, LSL #48
    SUB  X18, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xb799, LSL #0
    MOVK  X16, #0x6bd0, LSL #16
    MOVK  X16, #0x7952, LSL #32
    MOVK  X16, #0xb1f5, LSL #48
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x3388, LSL #0
    MOVK  X16, #0x67e6, LSL #16
    MOVK  X16, #0x81a2, LSL #32
    MOVK  X16, #0xc399, LSL #48
    SUB  X18, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xa31f, LSL #0
    MOVK  X16, #0xd056, LSL #16
    MOVK  X16, #0xea68, LSL #32
    MOVK  X16, #0xf2ea, LSL #48
    SUB  X18, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x548b, LSL #0
    MOVK  X16, #0x33a7, LSL #16
    MOVK  X16, #0x561d, LSL #32
    MOVK  X16, #0xa3e9, LSL #48
    SUB  X18, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xcfe5, LSL #0
    MOVK  X16, #0x8800, LSL #16
    MOVK  X16, #0x56fb, LSL #32
    MOVK  X16, #0x8015, LSL #48
    SUB  X18, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xc7fc, LSL #0
    MOVK  X16, #0x5d32, LSL #16
    MOVK  X16, #0x2d2d, LSL #32
    MOVK  X16, #0x826, LSL #48
    SUB  X18, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x5ec9, LSL #0
    MOVK  X16, #0x72c6, LSL #16
    MOVK  X16, #0x3798, LSL #32
    MOVK  X16, #0x49e7, LSL #48
    SUB  X18, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xb783, LSL #0
    MOVK  X16, #0x298e, LSL #16
    MOVK  X16, #0x9629, LSL #32
    MOVK  X16, #0xa0ed, LSL #48
    SUB  X18, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x5406, LSL #0
    MOVK  X16, #0xc936, LSL #16
    MOVK  X16, #0xbd15, LSL #32
    MOVK  X16, #0xc10a, LSL #48
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x9f28, LSL #0
    MOVK  X16, #0x23c7, LSL #16
    MOVK  X16, #0x7945, LSL #32
    MOVK  X16, #0x93e2, LSL #48
    SUB  X18, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x3641, LSL #0
    MOVK  X16, #0x668a, LSL #16
    MOVK  X16, #0xa05d, LSL #32
    MOVK  X16, #0x9655, LSL #48
    SUB  X18, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x2ae6, LSL #0
    MOVK  X16, #0x335e, LSL #16
    MOVK  X16, #0xd56c, LSL #32
    MOVK  X16, #0x3007, LSL #48
    SUB  X18, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X16, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D0
    MOVZ  X18, #0xeef7, LSL #0
    MOVK  X18, #0xa31f, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X18, #0xe6e6, LSL #0
    MOVK  X18, #0x2ae6, LSL #16
    MOVK  X18, #0xe6e6, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D1
    MOVZ  X18, #0xeef7, LSL #0
    MOVK  X18, #0xeef7, LSL #16
    MOVK  X18, #0xfc, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D2
    MOVZ  X18, #0x9fa4, LSL #0
    MOVK  X18, #0xd225, LSL #16
    MOVK  X18, #0x8352, LSL #32
    MOVK  X18, #0x5ec4, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D3
    MOVZ  X18, #0xa511, LSL #0
    MOVK  X18, #0x1f5e, LSL #16
    MOVK  X18, #0x6806, LSL #32
    MOVK  X18, #0x7107, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X18, #0xfc79, LSL #0
    MOVK  X18, #0xfb, LSL #16
    MOVK  X18, #0xe6e6, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D4
    MOVZ  X18, #0x90cf, LSL #0
    MOVK  X18, #0x6f8e, LSL #16
    MOVK  X18, #0x3192, LSL #32
    MOVK  X18, #0xd681, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X18, #0xfb, LSL #0
    MOVK  X18, #0x5e06, LSL #16
    MOVK  X18, #0x57, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D5
    MOVZ  X18, #0xeef7, LSL #0
    MOVK  X18, #0x9d01, LSL #16
    MOVK  X18, #0xeef7, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X18, #0x83fc, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D6
    MOVZ  X18, #0xeef7, LSL #0
    MOVK  X18, #0xeef7, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X18, #0xfe16, LSL #0
    MOVK  X18, #0xa730, LSL #16
    MOVK  X18, #0xb680, LSL #32
    MOVK  X18, #0x1140, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D7
    MOVZ  X18, #0x70da, LSL #0
    MOVK  X18, #0x2b3f, LSL #16
    MOVK  X18, #0xca8, LSL #32
    MOVK  X18, #0x1424, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X18, #0x5ec9, LSL #0
    MOVK  X18, #0x72c6, LSL #16
    MOVK  X18, #0x3798, LSL #32
    MOVK  X18, #0x49e7, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D8
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xfc00, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D9
    MOVZ  X18, #0x16bf, LSL #0
    MOVK  X18, #0x9e4b, LSL #16
    MOVK  X18, #0x548b, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x879e, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D10
    MOVZ  X18, #0x58a7, LSL #0
    MOVK  X18, #0x7709, LSL #16
    MOVK  X18, #0xd6b9, LSL #32
    MOVK  X18, #0xd4f, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D11
    MOVZ  X18, #0x7b2e, LSL #0
    MOVK  X18, #0x298e, LSL #16
    MOVK  X18, #0xd9a2, LSL #32
    MOVK  X18, #0xf700, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X18, #0x548b, LSL #0
    MOVK  X18, #0x33a7, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D12
    MOVZ  X18, #0x548b, LSL #0
    MOVK  X18, #0x33a7, LSL #16
    MOVK  X18, #0x548b, LSL #32
    MOVK  X18, #0x33a7, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D13
    MOVZ  X18, #0x691e, LSL #0
    MOVK  X18, #0x9639, LSL #16
    MOVK  X18, #0x5e00, LSL #32
    MOVK  X18, #0xf757, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X18, #0xe6e6, LSL #0
    MOVK  X18, #0xe6e6, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D14
    MOVZ  X18, #0xea99, LSL #0
    MOVK  X18, #0x8b2c, LSL #16
    MOVK  X18, #0xe84d, LSL #32
    MOVK  X18, #0xfdc6, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xcfe5, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D15
    MOVZ  X18, #0x57, LSL #0
    MOVK  X18, #0xee00, LSL #16
    MOVK  X18, #0xf700, LSL #32
    MOVK  X18, #0xeea7, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D16
    MOVZ  X18, #0x5470, LSL #0
    MOVK  X18, #0xb528, LSL #16
    MOVK  X18, #0x9a22, LSL #32
    MOVK  X18, #0xd68, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x33a7, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D17
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xdeee, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D18
    MOVZ  X18, #0x2454, LSL #0
    MOVK  X18, #0x4c96, LSL #16
    MOVK  X18, #0x56af, LSL #32
    MOVK  X18, #0xcf01, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X18, #0x5ec9, LSL #0
    MOVK  X18, #0x72c6, LSL #16
    MOVK  X18, #0xb799, LSL #32
    MOVK  X18, #0x6bd0, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D19
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xf7f7, LSL #16
    MOVK  X18, #0xa1a1, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X18, #0x83ef, LSL #0
    MOVK  X18, #0xef, LSL #16
    MOVK  X18, #0x3388, LSL #32
    MOVK  X18, #0xa4, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D20
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xcfe5, LSL #32
    MOVK  X18, #0x8800, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X18, #0xf3ee, LSL #0
    MOVK  X18, #0xc7bd, LSL #16
    MOVK  X18, #0xbefc, LSL #32
    MOVK  X18, #0x14d, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D21
    MOVZ  X18, #0xe046, LSL #0
    MOVK  X18, #0xc6b2, LSL #16
    MOVK  X18, #0x5fd0, LSL #32
    MOVK  X18, #0x33a3, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D22
    MOVZ  X18, #0xe038, LSL #0
    MOVK  X18, #0xb533, LSL #16
    MOVK  X18, #0xe49c, LSL #32
    MOVK  X18, #0xd3ed, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D23
    MOVZ  X18, #0x51a, LSL #0
    MOVK  X18, #0xb571, LSL #16
    MOVK  X18, #0xe806, LSL #32
    MOVK  X18, #0xfd36, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X18, #0xe6e6, LSL #0
    MOVK  X18, #0xf7f7, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D24
    MOVZ  X18, #0xe6e6, LSL #0
    MOVK  X18, #0xe6e6, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X18, #0x59f7, LSL #0
    MOVK  X18, #0x59f7, LSL #16
    MOVK  X18, #0xf7f7, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D25
    MOVZ  X18, #0xb783, LSL #0
    MOVK  X18, #0x298e, LSL #16
    MOVK  X18, #0xb783, LSL #32
    MOVK  X18, #0x298e, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xd056, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D26
    MOVZ  X18, #0x90e3, LSL #0
    MOVK  X18, #0xa53a, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X18, #0xf700, LSL #0
    MOVK  X18, #0xee00, LSL #16
    MOVK  X18, #0xf700, LSL #32
    MOVK  X18, #0x88a7, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D27
    MOVZ  X18, #0x5ec9, LSL #0
    MOVK  X18, #0x5ec9, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X18, #0x7e7b, LSL #0
    MOVK  X18, #0xa4f2, LSL #16
    MOVK  X18, #0x57, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D28
    MOVZ  X18, #0x3c65, LSL #0
    MOVK  X18, #0x2000, LSL #16
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x364f, LSL #32
    MOVK  X18, #0x364f, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D29
    MOVZ  X18, #0x548b, LSL #0
    MOVK  X18, #0x33a7, LSL #16
    MOVK  X18, #0x561d, LSL #32
    MOVK  X18, #0x5f26, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D30
    MOVZ  X18, #0xef00, LSL #0
    MOVK  X18, #0x6800, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X18, #0xe000, LSL #0
    MOVK  X18, #0x9ab9, LSL #16
    MOVK  X18, #0x1000, LSL #32
    MOVK  X18, #0xfcdc, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D31
    MOVZ  X18, #0x9bea, LSL #0
    MOVK  X18, #0x98c8, LSL #32
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x29f4, LSL #0
    MOVK  X2, #0x18a2, LSL #16
    MOVK  X2, #0xaae6, LSL #32
    MOVK  X2, #0xb572, LSL #48
    MOVZ  X3, #0x861a, LSL #0
    MOVK  X3, #0x37ba, LSL #16
    MOVK  X3, #0x9882, LSL #32
    MOVK  X3, #0xa749, LSL #48
    MOVZ  X4, #0xafff, LSL #0
    MOVK  X4, #0xabe8, LSL #16
    MOVK  X4, #0x5b3a, LSL #32
    MOVK  X4, #0x3d91, LSL #48
    MOVZ  X5, #0xf44, LSL #0
    MOVK  X5, #0xb8b6, LSL #16
    MOVK  X5, #0xe619, LSL #32
    MOVK  X5, #0x42ec, LSL #48
    MOVZ  X6, #0x5572, LSL #0
    MOVK  X6, #0x2ea2, LSL #16
    MOVK  X6, #0x1148, LSL #32
    MOVK  X6, #0xab66, LSL #48
    MOVZ  X7, #0xc524, LSL #0
    MOVK  X7, #0x7a46, LSL #16
    MOVK  X7, #0x398d, LSL #32
    MOVK  X7, #0xa1b0, LSL #48
    MOVZ  X8, #0x6df8, LSL #0
    MOVK  X8, #0xedea, LSL #16
    MOVK  X8, #0x4c3a, LSL #32
    MOVK  X8, #0xf002, LSL #48
    MOVZ  X9, #0xcfd0, LSL #0
    MOVK  X9, #0xa51a, LSL #16
    MOVK  X9, #0xb1e6, LSL #32
    MOVK  X9, #0xf5e3, LSL #48
    MOVZ  X12, #0xfa9b, LSL #0
    MOVK  X12, #0xf36e, LSL #16
    MOVK  X12, #0x820a, LSL #32
    MOVK  X12, #0xb5fd, LSL #48
    MOVZ  X16, #0x10db, LSL #0
    MOVK  X16, #0xdc23, LSL #16
    MOVK  X16, #0xb38, LSL #32
    MOVK  X16, #0x89a1, LSL #48
    MOVZ  X17, #0xd610, LSL #0
    MOVK  X17, #0xce3e, LSL #16
    MOVK  X17, #0x80dc, LSL #32
    MOVK  X17, #0x4bb7, LSL #48
    MOVZ  X18, #0x4e43, LSL #0
    MOVK  X18, #0x2542, LSL #16
    MOVK  X18, #0xb4ec, LSL #32
    MOVK  X18, #0xeec8, LSL #48
    MOVZ  X19, #0x4731, LSL #0
    MOVK  X19, #0x4b7, LSL #16
    MOVK  X19, #0x9319, LSL #32
    MOVK  X19, #0xe75d, LSL #48
    MOVZ  X20, #0xc0be, LSL #0
    MOVK  X20, #0xb52a, LSL #16
    MOVK  X20, #0xdeac, LSL #32
    MOVK  X20, #0x4b7b, LSL #48
    MOVZ  X21, #0x40eb, LSL #0
    MOVK  X21, #0x12e5, LSL #16
    MOVK  X21, #0x8991, LSL #32
    MOVK  X21, #0xb252, LSL #48
    MOVZ  X22, #0x7cf5, LSL #0
    MOVK  X22, #0x9d3f, LSL #16
    MOVK  X22, #0xa05, LSL #32
    MOVK  X22, #0xff61, LSL #48
    MOVZ  X23, #0x55d3, LSL #0
    MOVK  X23, #0x8ac4, LSL #16
    MOVK  X23, #0x6ace, LSL #32
    MOVK  X23, #0x8d81, LSL #48
    MOVZ  X24, #0x1fc3, LSL #0
    MOVK  X24, #0xebbe, LSL #16
    MOVK  X24, #0xf7b4, LSL #32
    MOVK  X24, #0xf0f7, LSL #48
    MOVZ  X25, #0xd87d, LSL #0
    MOVK  X25, #0x6d8a, LSL #16
    MOVK  X25, #0x36cd, LSL #32
    MOVK  X25, #0xf03, LSL #48
    MOVZ  X26, #0x8985, LSL #0
    MOVK  X26, #0xbaee, LSL #16
    MOVK  X26, #0xd1b4, LSL #32
    MOVK  X26, #0xddc0, LSL #48
    MOVZ  X27, #0x501f, LSL #0
    MOVK  X27, #0x696d, LSL #16
    MOVK  X27, #0xe31, LSL #32
    MOVK  X27, #0xbfdd, LSL #48
    MOVZ  X28, #0xbdab, LSL #0
    MOVK  X28, #0xf6ff, LSL #16
    MOVK  X28, #0xac8c, LSL #32
    MOVK  X28, #0x70be, LSL #48
    MOVZ  X29, #0x9a29, LSL #0
    MOVK  X29, #0x7907, LSL #16
    MOVK  X29, #0x2c56, LSL #32
    MOVK  X29, #0xf5b3, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X12
    FMOV  D3, X7
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X8
    FMOV  D5, X27
    FMOV  V5.D[1], X4
    FMOV  D6, X19
    FMOV  V6.D[1], X18
    FMOV  D7, X9
    FMOV  V7.D[1], X3
    FMOV  D8, X25
    FMOV  V8.D[1], X20
    FMOV  D9, X6
    FMOV  V9.D[1], X26
    FMOV  D10, X7
    FMOV  V10.D[1], X26
    FMOV  D11, X5
    FMOV  V11.D[1], X12
    FMOV  D12, X21
    FMOV  V12.D[1], X8
    FMOV  D13, X5
    FMOV  V13.D[1], X4
    FMOV  D14, X20
    FMOV  V14.D[1], X7
    FMOV  D15, X17
    FMOV  V15.D[1], X27
    FMOV  D16, X23
    FMOV  V16.D[1], X19
    FMOV  D17, X5
    FMOV  V17.D[1], X20
    FMOV  D18, X5
    FMOV  V18.D[1], X12
    FMOV  D19, X16
    FMOV  V19.D[1], X17
    FMOV  D20, X17
    FMOV  V20.D[1], X19
    FMOV  D21, X18
    FMOV  V21.D[1], X18
    FMOV  D22, X28
    FMOV  V22.D[1], X25
    FMOV  D23, X29
    FMOV  V23.D[1], X23
    FMOV  D24, X3
    FMOV  V24.D[1], X21
    FMOV  D25, X23
    FMOV  V25.D[1], X24
    FMOV  D26, X5
    FMOV  V26.D[1], X29
    FMOV  D27, X18
    FMOV  V27.D[1], X23
    FMOV  D28, X22
    FMOV  V28.D[1], X27
    FMOV  D29, X3
    FMOV  V29.D[1], X24
    FMOV  D30, X22
    FMOV  V30.D[1], X26
    FMOV  D31, X16
    FMOV  V31.D[1], X17
    MLS  V2.8H, V31.8H, V12.H[0x6]
    MLS  V13.8H, V8.8H, V2.H[0x6]
    MLS  V23.4H, V27.4H, V0.H[0x5]
    MLS  V26.4H, V30.4H, V2.H[0x4]
    MLS  V0.4H, V13.4H, V14.H[0x7]
    MLS  V8.4H, V23.4H, V0.H[0x4]
    MLS  V10.4H, V29.4H, V13.H[0x6]
    MLS  V23.4H, V29.4H, V10.H[0x7]
    MLS  V18.8H, V19.8H, V8.H[0x6]
    MLS  V13.4H, V0.4H, V14.H[0x6]
    MLS  V19.4S, V29.4S, V18.S[0x2]
    MLS  V11.4S, V26.4S, V26.S[0x0]
    MLS  V25.4S, V25.4S, V10.S[0x1]
    MLS  V19.4S, V13.4S, V18.S[0x3]
    MLS  V6.4S, V11.4S, V19.S[0x0]
    MLS  V8.4S, V6.4S, V20.S[0x2]
    MLS  V0.4S, V23.4S, V25.S[0x2]
    MLS  V10.2S, V23.2S, V8.S[0x1]
    MLS  V18.2S, V28.2S, V0.S[0x2]
    MLS  V11.4S, V26.4S, V7.S[0x2]
    MLS  V7.4S, V28.4S, V22.4S
    MLS  V25.8H, V8.8H, V25.8H
    MLS  V12.4S, V19.4S, V8.4S
    MLS  V31.4H, V14.4H, V29.4H
    MLS  V28.4H, V8.4H, V19.4H
    MLS  V23.8B, V14.8B, V19.8B
    MLS  V13.8H, V25.8H, V7.8H
    MLS  V20.16B, V31.16B, V18.16B
    MLS  V17.4S, V8.4S, V10.4S
    MLS  V19.4H, V17.4H, V17.4H
    MOV V26.B[0xb], V23.B[0xc]
    MOV V0.B[0x4], V23.B[0xa]
    MOV V4.B[0x1], V0.B[0xe]
    MOV V24.B[0x0], V8.B[0x9]
    MOV V14.B[0x1], V12.B[0x0]
    MOV V17.B[0x8], V13.B[0x2]
    MOV V29.B[0x0], V24.B[0x1]
    MOV V25.B[0x4], V17.B[0x8]
    MOV V30.B[0x0], V19.B[0x4]
    MOV V31.B[0x9], V26.B[0x2]
    MOV V24.D[0x1], V11.D[0x1]
    MOV V31.D[0x1], V27.D[0x0]
    MOV V17.D[0x1], V2.D[0x0]
    MOV V26.D[0x0], V25.D[0x0]
    MOV V13.D[0x1], V26.D[0x0]
    MOV V18.D[0x1], V24.D[0x1]
    MOV V23.D[0x0], V29.D[0x0]
    MOV V27.D[0x0], V17.D[0x1]
    MOV V29.D[0x0], V4.D[0x0]
    MOV V10.D[0x1], V27.D[0x1]
    MOV V24.H[0x3], V30.H[0x3]
    MOV V11.H[0x5], V14.H[0x3]
    MOV V14.H[0x3], V31.H[0x4]
    MOV V26.H[0x4], V18.H[0x3]
    MOV V12.H[0x1], V19.H[0x3]
    MOV V25.H[0x4], V20.H[0x2]
    MOV V20.H[0x4], V13.H[0x3]
    MOV V17.H[0x0], V10.H[0x6]
    MOV V31.H[0x3], V24.H[0x0]
    MOV V24.H[0x1], V25.H[0x3]
    MOV V27.S[0x1], V25.S[0x1]
    MOV V24.S[0x0], V27.S[0x2]
    MOV V25.S[0x0], V23.S[0x0]
    MOV V19.S[0x2], V25.S[0x1]
    MOV V23.S[0x3], V16.S[0x2]
    MOV V10.S[0x1], V20.S[0x1]
    MOV V13.S[0x1], V12.S[0x2]
    MOV V30.S[0x3], V19.S[0x3]
    MOV V12.S[0x2], V26.S[0x2]
    MOV V20.S[0x3], V17.S[0x3]
    MOV V2.B[0xe], W9
    MOV V17.B[0xc], W4
    MOV V26.B[0xe], W21
    MOV V4.B[0xc], W8
    MOV V25.B[0x9], W22
    MOV V27.B[0xe], W29
    MOV V16.B[0x7], W19
    MOV V14.B[0x8], W25
    MOV V25.B[0xa], W4
    MOV V16.B[0xe], W4
    MOV V7.D[0x0], X16
    MOV V9.D[0x0], X16
    MOV V24.D[0x1], X9
    MOV V21.D[0x0], X19
    MOV V13.D[0x1], X22
    MOV V15.D[0x1], X12
    MOV V25.D[0x1], X18
    MOV V22.D[0x1], X23
    MOV V3.D[0x1], X12
    MOV V0.D[0x1], X9
    MOV V24.H[0x3], W19
    MOV V7.H[0x5], W27
    MOV V16.H[0x3], W19
    MOV V25.H[0x6], W27
    MOV V14.H[0x4], W27
    MOV V21.H[0x7], W24
    MOV V29.H[0x4], W18
    MOV V28.H[0x2], W3
    MOV V1.H[0x6], W3
    MOV V5.H[0x4], W25
    MOV V4.S[0x0], W4
    MOV V23.S[0x1], W20
    MOV V3.S[0x2], W19
    MOV V4.S[0x2], W29
    MOV V1.S[0x2], W29
    MOV V18.S[0x1], W4
    MOV V6.S[0x2], W3
    MOV V19.S[0x2], W9
    MOV V20.S[0x0], W8
    MOV V29.S[0x3], W6
    MOV B26, V7.B[0x7]
    MOV B9, V23.B[0xe]
    MOV B23, V9.B[0x6]
    MOV B24, V3.B[0xb]
    MOV B10, V23.B[0xa]
    MOV B1, V24.B[0x6]
    MOV B10, V10.B[0x4]
    MOV B29, V10.B[0x0]
    MOV B22, V12.B[0x6]
    MOV B28, V25.B[0xa]
    MOV D20, V18.D[0x1]
    MOV D9, V17.D[0x1]
    MOV D30, V1.D[0x1]
    MOV D29, V6.D[0x0]
    MOV D0, V29.D[0x0]
    MOV D23, V30.D[0x0]
    MOV D21, V3.D[0x1]
    MOV D11, V21.D[0x1]
    MOV D20, V28.D[0x1]
    MOV D2, V12.D[0x1]
    MOV H7, V27.H[0x2]
    MOV H10, V0.H[0x1]
    MOV H17, V10.H[0x0]
    MOV H30, V9.H[0x5]
    MOV H27, V23.H[0x6]
    MOV H3, V26.H[0x3]
    MOV H24, V7.H[0x0]
    MOV H29, V17.H[0x3]
    MOV H13, V22.H[0x4]
    MOV H18, V7.H[0x0]
    MOV S21, V30.S[0x0]
    MOV S26, V13.S[0x1]
    MOV S23, V25.S[0x2]
    MOV S15, V26.S[0x1]
    MOV S12, V29.S[0x2]
    MOV S17, V20.S[0x2]
    MOV S29, V26.S[0x1]
    MOV S30, V22.S[0x0]
    MOV S9, V11.S[0x0]
    MOV S13, V9.S[0x0]
    MOV  W22, V29.S[0x1]
    MOV  W7, V3.S[0x1]
    MOV  W3, V17.S[0x1]
    MOV  W25, V27.S[0x0]
    MOV  W29, V12.S[0x3]
    MOV  W9, V18.S[0x2]
    MOV  W18, V15.S[0x1]
    MOV  W7, V25.S[0x0]
    MOV  W6, V21.S[0x2]
    MOV  W4, V9.S[0x1]
    MOV  X24, V27.D[0x0]
    MOV  X19, V23.D[0x0]
    MOV  X21, V30.D[0x0]
    MOV  X24, V14.D[0x1]
    MOV  X7, V13.D[0x0]
    MOV  X25, V9.D[0x0]
    MOV  X23, V6.D[0x0]
    MOV  X6, V14.D[0x1]
    MOV  X21, V5.D[0x1]
    MOV  X16, V21.D[0x0]
    MOV  V23.8B, V7.8B
    MOV  V5.8B, V13.8B
    MOV  V20.8B, V14.8B
    MOV  V6.8B, V7.8B
    MOV  V18.8B, V21.8B
    MOV  V26.16B, V21.16B
    MOV  V9.8B, V7.8B
    MOV  V25.8B, V5.8B
    MOV  V7.8B, V22.8B
    MOV  V14.8B, V16.8B
    MOVI  V5.8H, #0xd7, LSL #8
    MOVI  V26.8H, #0xc6, LSL #8
    MOVI  V29.8H, #0x68
    MOVI  V13.4H, #0xf6
    MOVI  V16.4H, #0x87, LSL #8
    MOVI  V12.8H, #0x4b, LSL #8
    MOVI  V26.4H, #0x55, LSL #8
    MOVI  V15.8H, #0x3f
    MOVI  V21.8H, #0xc0, LSL #8
    MOVI  V23.8H, #0xc6
    MOVI  V22.4S, #0x69, LSL #8
    MOVI  V23.2S, #0xaa, LSL #8
    MOVI  V15.2S, #0xbe
    MOVI  V23.4S, #0xc7, LSL #24
    MOVI  V4.4S, #0x94
    MOVI  V14.2S, #0x60, LSL #24
    MOVI  V11.4S, #0xef
    MOVI  V25.4S, #0xd9, LSL #8
    MOVI  V6.2S, #0xa1, LSL #16
    MOVI  V29.2S, #0x13
    MOVI  V7.4S, #0xc9, MSL #16
    MOVI  V21.4S, #0xe0, MSL #8
    MOVI  V26.4S, #0x5e, MSL #16
    MOVI  V13.4S, #0x11, MSL #16
    MOVI  V17.2S, #0x97, MSL #16
    MOVI  V30.4S, #0x9b, MSL #16
    MOVI  V25.2S, #0xfd, MSL #16
    MOVI  V10.2S, #0xbd, MSL #16
    MOVI  V26.2S, #0x2c, MSL #16
    MOVI  V4.4S, #0xb0, MSL #16
    MOVI  V0.2D, #281470681743615
    MOVI  V4.2D, #18374967950370144255
    MOVI  V17.2D, #18446744073709486335
    MOVI  V27.2D, #18446744069414649855
    MOVI  V30.2D, #18446462603011031295
    MOVI  V21.2D, #18446462598732840960
    MOVI  V1.2D, #280375465148160
    MOVI  V17.2D, #280379759984895
    MOVI  V12.2D, #18374687574904996095
    MOVI  V19.2D, #18446463693966278400
    MOVI  V4.8B, #0xa8
    MOVI  V28.8B, #0x3c
    MOVI  V31.8B, #0xbd
    MOVI  V15.8B, #0x75
    MOVI  V14.8B, #0xa3
    MOVI  V24.16B, #0x7
    MOVI  V26.8B, #0xa7
    MOVI  V12.16B, #0x10
    MOVI  V30.8B, #0x5e
    MOVI  V18.8B, #0xde
    MUL  V26.4H, V30.4H, V1.H[0x6]
    MUL  V5.4H, V17.4H, V15.H[0x5]
    MUL  V14.4H, V27.4H, V12.H[0x2]
    MUL  V17.8H, V30.8H, V4.H[0x7]
    MUL  V29.8H, V17.8H, V5.H[0x2]
    MUL  V22.8H, V18.8H, V13.H[0x4]
    MUL  V23.8H, V22.8H, V11.H[0x2]
    MUL  V6.8H, V29.8H, V14.H[0x4]
    MUL  V19.8H, V23.8H, V6.H[0x7]
    MUL  V22.4H, V23.4H, V3.H[0x4]
    MUL  V17.2S, V0.2S, V30.S[0x0]
    MUL  V28.4S, V22.4S, V24.S[0x1]
    MUL  V11.2S, V4.2S, V17.S[0x3]
    MUL  V15.4S, V26.4S, V11.S[0x3]
    MUL  V19.2S, V19.2S, V20.S[0x3]
    MUL  V5.4S, V19.4S, V19.S[0x1]
    MUL  V23.2S, V31.2S, V27.S[0x3]
    MUL  V30.2S, V18.2S, V16.S[0x1]
    MUL  V20.4S, V2.4S, V30.S[0x3]
    MUL  V24.2S, V15.2S, V28.S[0x1]
    MUL  V17.4H, V6.4H, V0.4H
    MUL  V3.16B, V31.16B, V20.16B
    MUL  V1.8B, V15.8B, V17.8B
    MUL  V20.4S, V1.4S, V19.4S
    MUL  V19.16B, V26.16B, V20.16B
    MUL  V26.4S, V19.4S, V20.4S
    MUL  V19.4S, V5.4S, V23.4S
    MUL  V27.4H, V26.4H, V5.4H
    MUL  V26.4H, V24.4H, V19.4H
    MUL  V2.2S, V3.2S, V18.2S
    MVN  V29.16B, V22.16B
    MVN  V2.16B, V3.16B
    MVN  V3.8B, V29.8B
    MVN  V5.16B, V26.16B
    MVN  V18.16B, V0.16B
    MVN  V6.8B, V5.8B
    MVN  V30.8B, V24.8B
    MVN  V10.16B, V15.16B
    MVN  V19.16B, V9.16B
    MVN  V28.8B, V10.8B
    MVNI  V5.8H, #0x4f, LSL #8
    MVNI  V17.4H, #0xb4, LSL #8
    MVNI  V0.8H, #0x8d
    MVNI  V29.8H, #0xc1, LSL #8
    MVNI  V5.8H, #0x37, LSL #8
    MVNI  V23.8H, #0x8c
    MVNI  V10.8H, #0xe5
    MVNI  V26.8H, #0x8b
    MVNI  V11.4H, #0xa9, LSL #8
    MVNI  V15.4H, #0x21
    MVNI  V14.4S, #0x1b
    MVNI  V9.4S, #0xd1, LSL #8
    MVNI  V22.2S, #0x60, LSL #24
    MVNI  V1.2S, #0x1d, LSL #24
    MVNI  V11.2S, #0xca
    MVNI  V16.2S, #0x6a
    MVNI  V21.4S, #0x7
    MVNI  V12.4S, #0xd2, LSL #8
    MVNI  V13.2S, #0x4d, LSL #16
    MVNI  V23.4S, #0xf4
    MVNI  V2.4S, #0x41, MSL #8
    MVNI  V8.2S, #0xe8, MSL #8
    MVNI  V30.4S, #0x43, MSL #16
    MVNI  V12.2S, #0x84, MSL #16
    MVNI  V20.2S, #0x91, MSL #8
    MVNI  V31.2S, #0x40, MSL #16
    MVNI  V29.2S, #0x45, MSL #8
    MVNI  V26.2S, #0x9, MSL #8
    MVNI  V10.4S, #0x2e, MSL #16
    MVNI  V12.4S, #0x65, MSL #8
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x501f, LSL #0
    MOVK  X5, #0x7a46, LSL #16
    MOVK  X5, #0x398d, LSL #32
    MOVK  X5, #0xa1b0, LSL #48
    SUB  X17, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x6df8, LSL #0
    MOVK  X5, #0xedea, LSL #16
    MOVK  X5, #0x4c3a, LSL #32
    MOVK  X5, #0xf002, LSL #48
    SUB  X17, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0xfa9b, LSL #0
    MOVK  X5, #0xf36e, LSL #16
    MOVK  X5, #0x820a, LSL #32
    MOVK  X5, #0xb5fd, LSL #48
    SUB  X17, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x4e43, LSL #0
    MOVK  X5, #0x2542, LSL #16
    SUB  X17, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0xc0be, LSL #0
    MOVK  X5, #0xb52a, LSL #16
    MOVK  X5, #0xdeac, LSL #32
    MOVK  X5, #0x4b7b, LSL #48
    SUB  X17, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0xd87d, LSL #0
    MOVK  X5, #0xabe8, LSL #16
    MOVK  X5, #0x5b3a, LSL #32
    MOVK  X5, #0x3d91, LSL #48
    SUB  X17, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x5fa8, LSL #0
    MOVK  X5, #0x2ca1, LSL #16
    MOVK  X5, #0x4394, LSL #32
    MOVK  X5, #0x7277, LSL #48
    SUB  X17, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x501f, LSL #0
    MOVK  X5, #0x7a46, LSL #16
    MOVK  X5, #0x398d, LSL #32
    MOVK  X5, #0xa1b0, LSL #48
    SUB  X17, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x8985, LSL #0
    MOVK  X5, #0xbaee, LSL #16
    MOVK  X5, #0xd1b4, LSL #32
    MOVK  X5, #0xddc0, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x501f, LSL #0
    MOVK  X5, #0x696d, LSL #16
    MOVK  X5, #0xe31, LSL #32
    MOVK  X5, #0xbfdd, LSL #48
    SUB  X17, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0xbdab, LSL #0
    MOVK  X5, #0xf6ff, LSL #16
    MOVK  X5, #0xac8c, LSL #32
    MOVK  X5, #0x70be, LSL #48
    SUB  X17, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X5, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X17, #0xff72, LSL #0
    MOVK  X17, #0xff72, LSL #16
    MOVK  X17, #0xff72, LSL #32
    MOVK  X17, #0xff72, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D0
    MOVZ  X17, #0xff72, LSL #0
    MOVK  X17, #0xff72, LSL #16
    MOVK  X17, #0xff72, LSL #32
    MOVK  X17, #0xff72, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D1
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xe2ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xe2ff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X17, #0xbe00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xbe00, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D2
    MOVZ  X17, #0xbe00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xbe00, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D3
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D4
    MOVZ  X17, #0xa8a8, LSL #0
    MOVK  X17, #0xa8a8, LSL #16
    MOVK  X17, #0xa8a8, LSL #32
    MOVK  X17, #0xa8a8, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X17, #0xc8ff, LSL #0
    MOVK  X17, #0xc8ff, LSL #16
    MOVK  X17, #0xc8ff, LSL #32
    MOVK  X17, #0xc8ff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D5
    MOVZ  X17, #0xc8ff, LSL #0
    MOVK  X17, #0xc8ff, LSL #16
    MOVK  X17, #0xc8ff, LSL #32
    MOVK  X17, #0xc8ff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xc9, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xc9, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D7
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xc9, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xc9, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D8
    MOVZ  X17, #0x1700, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x1700, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X17, #0x2eff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x2eff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D9
    MOVZ  X17, #0x2eff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x2eff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffd1, LSL #16
    MOVK  X17, #0xffd1, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D10
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffd1, LSL #16
    MOVK  X17, #0xffd1, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D11
    MOVZ  X17, #0xff35, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xff35, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X17, #0x9a00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x9a00, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D12
    MOVZ  X17, #0x9a00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x9a00, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D13
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffb2, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffb2, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X17, #0xffe4, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffe4, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D14
    MOVZ  X17, #0xffe4, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffe4, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D15
    MOVZ  X17, #0xffde, LSL #0
    MOVK  X17, #0xffde, LSL #16
    MOVK  X17, #0xffde, LSL #32
    MOVK  X17, #0xffde, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D16
    MOVZ  X17, #0xff95, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xff95, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D17
    MOVZ  X17, #0x4bff, LSL #0
    MOVK  X17, #0x4bff, LSL #16
    MOVK  X17, #0x4bff, LSL #32
    MOVK  X17, #0x4bff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X17, #0xff00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D18
    MOVZ  X17, #0xff00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D19
    MOVZ  X17, #0xb744, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D20
    MOVZ  X17, #0x6e00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x6e00, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X17, #0xfff8, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xfff8, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D21
    MOVZ  X17, #0xfff8, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xfff8, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D22
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x9fff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0x9fff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X17, #0xff0b, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xff0b, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D23
    MOVZ  X17, #0xff0b, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xff0b, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D25
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xfd, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xfd, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D26
    MOVZ  X17, #0xf600, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xf600, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D28
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D29
    MOVZ  X17, #0xba00, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xba00, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffbc, LSL #16
    MOVK  X17, #0xffbc, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D30
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffbc, LSL #16
    MOVK  X17, #0xffbc, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X5, D31
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffbf, LSL #16
    MOVK  X17, #0xffbf, LSL #48
    SUB  X2, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x7b71, LSL #0
    MOVK  X2, #0xdd23, LSL #16
    MOVK  X2, #0x8e1c, LSL #32
    MOVK  X2, #0xe32e, LSL #48
    MOVZ  X3, #0x52b8, LSL #0
    MOVK  X3, #0xf9d9, LSL #16
    MOVK  X3, #0x6589, LSL #32
    MOVK  X3, #0x83d2, LSL #48
    MOVZ  X4, #0xca1f, LSL #0
    MOVK  X4, #0x56f1, LSL #16
    MOVK  X4, #0x93e1, LSL #32
    MOVK  X4, #0x4c2f, LSL #48
    MOVZ  X5, #0xe04e, LSL #0
    MOVK  X5, #0x41c1, LSL #16
    MOVK  X5, #0x3156, LSL #32
    MOVK  X5, #0x9f55, LSL #48
    MOVZ  X6, #0x8005, LSL #0
    MOVK  X6, #0xf426, LSL #16
    MOVK  X6, #0x802f, LSL #32
    MOVK  X6, #0xdba0, LSL #48
    MOVZ  X7, #0xea1, LSL #0
    MOVK  X7, #0x3825, LSL #16
    MOVK  X7, #0xca2f, LSL #32
    MOVK  X7, #0x7994, LSL #48
    MOVZ  X8, #0xb6d6, LSL #0
    MOVK  X8, #0xec5b, LSL #16
    MOVK  X8, #0xc273, LSL #32
    MOVK  X8, #0x6e72, LSL #48
    MOVZ  X9, #0x4fae, LSL #0
    MOVK  X9, #0x6e75, LSL #16
    MOVK  X9, #0x8631, LSL #32
    MOVK  X9, #0x8172, LSL #48
    MOVZ  X12, #0xb7ba, LSL #0
    MOVK  X12, #0x5c09, LSL #16
    MOVK  X12, #0x47f0, LSL #32
    MOVK  X12, #0xce61, LSL #48
    MOVZ  X16, #0xb4c6, LSL #0
    MOVK  X16, #0xa87d, LSL #16
    MOVK  X16, #0xe638, LSL #32
    MOVK  X16, #0xc1db, LSL #48
    MOVZ  X17, #0x8da7, LSL #0
    MOVK  X17, #0x4c5d, LSL #16
    MOVK  X17, #0xf4ea, LSL #32
    MOVK  X17, #0xdadb, LSL #48
    MOVZ  X18, #0xfcff, LSL #0
    MOVK  X18, #0x5840, LSL #16
    MOVK  X18, #0x757e, LSL #32
    MOVK  X18, #0x9e49, LSL #48
    MOVZ  X19, #0xdcba, LSL #0
    MOVK  X19, #0xbb40, LSL #16
    MOVK  X19, #0xbb25, LSL #32
    MOVK  X19, #0x2290, LSL #48
    MOVZ  X20, #0x91dd, LSL #0
    MOVK  X20, #0xf0ab, LSL #16
    MOVK  X20, #0x8084, LSL #32
    MOVK  X20, #0xc23e, LSL #48
    MOVZ  X21, #0x5812, LSL #0
    MOVK  X21, #0xb6dc, LSL #16
    MOVK  X21, #0xde83, LSL #32
    MOVK  X21, #0x8626, LSL #48
    MOVZ  X22, #0xfada, LSL #0
    MOVK  X22, #0xdcdd, LSL #16
    MOVK  X22, #0x4e21, LSL #32
    MOVK  X22, #0x607c, LSL #48
    MOVZ  X23, #0x46a2, LSL #0
    MOVK  X23, #0x7928, LSL #16
    MOVK  X23, #0x5961, LSL #32
    MOVK  X23, #0x6669, LSL #48
    MOVZ  X24, #0x34f9, LSL #0
    MOVK  X24, #0x24db, LSL #16
    MOVK  X24, #0x496e, LSL #32
    MOVK  X24, #0xddd4, LSL #48
    MOVZ  X25, #0x166c, LSL #0
    MOVK  X25, #0xef70, LSL #16
    MOVK  X25, #0xf4af, LSL #32
    MOVK  X25, #0xdf66, LSL #48
    MOVZ  X26, #0xd174, LSL #0
    MOVK  X26, #0xf520, LSL #16
    MOVK  X26, #0x8268, LSL #32
    MOVK  X26, #0xa231, LSL #48
    MOVZ  X27, #0x6bf5, LSL #0
    MOVK  X27, #0x9daf, LSL #16
    MOVK  X27, #0x2552, LSL #32
    MOVK  X27, #0x5483, LSL #48
    MOVZ  X28, #0x33f1, LSL #0
    MOVK  X28, #0xe2f7, LSL #16
    MOVK  X28, #0x31b6, LSL #32
    MOVK  X28, #0x4360, LSL #48
    MOVZ  X29, #0x441a, LSL #0
    MOVK  X29, #0x2bb4, LSL #16
    MOVK  X29, #0xeb07, LSL #32
    MOVK  X29, #0x684c, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X7
    FMOV  V3.D[1], X27
    FMOV  D4, X3
    FMOV  V4.D[1], X17
    FMOV  D5, X19
    FMOV  V5.D[1], X20
    FMOV  D6, X2
    FMOV  V6.D[1], X2
    FMOV  D7, X24
    FMOV  V7.D[1], X27
    FMOV  D8, X16
    FMOV  V8.D[1], X26
    FMOV  D9, X22
    FMOV  V9.D[1], X22
    FMOV  D10, X28
    FMOV  V10.D[1], X8
    FMOV  D11, X8
    FMOV  V11.D[1], X18
    FMOV  D12, X6
    FMOV  V12.D[1], X23
    FMOV  D13, X9
    FMOV  V13.D[1], X3
    FMOV  D14, X3
    FMOV  V14.D[1], X23
    FMOV  D15, X12
    FMOV  V15.D[1], X17
    FMOV  D16, X2
    FMOV  V16.D[1], X19
    FMOV  D17, X21
    FMOV  V17.D[1], X24
    FMOV  D18, X27
    FMOV  V18.D[1], X12
    FMOV  D19, X27
    FMOV  V19.D[1], X2
    FMOV  D20, X12
    FMOV  V20.D[1], X18
    FMOV  D21, X21
    FMOV  V21.D[1], X26
    FMOV  D22, X4
    FMOV  V22.D[1], X28
    FMOV  D23, X6
    FMOV  V23.D[1], X12
    FMOV  D24, X12
    FMOV  V24.D[1], X12
    FMOV  D25, X19
    FMOV  V25.D[1], X6
    FMOV  D26, X29
    FMOV  V26.D[1], X18
    FMOV  D27, X9
    FMOV  V27.D[1], X9
    FMOV  D28, X7
    FMOV  V28.D[1], X16
    FMOV  D29, X29
    FMOV  V29.D[1], X16
    FMOV  D30, X5
    FMOV  V30.D[1], X24
    FMOV  D31, X17
    FMOV  V31.D[1], X19
    NEG  V10.8B, V27.8B
    NEG  V18.16B, V0.16B
    NEG  V0.8B, V29.8B
    NEG  V19.2D, V30.2D
    NEG  V8.4S, V26.4S
    NEG  V13.8B, V28.8B
    NEG  V16.4H, V8.4H
    NEG  V24.4H, V31.4H
    NEG  V12.8H, V24.8H
    NEG  V20.4H, V26.4H
    NOT  V6.16B, V18.16B
    NOT  V23.16B, V12.16B
    NOT  V14.16B, V10.16B
    NOT  V26.8B, V23.8B
    NOT  V18.8B, V6.8B
    NOT  V28.8B, V16.8B
    NOT  V28.8B, V18.8B
    NOT  V19.16B, V31.16B
    NOT  V16.8B, V8.8B
    NOT  V9.8B, V20.8B
    ORN  V10.8B, V22.8B, V9.8B
    ORN  V30.8B, V9.8B, V10.8B
    ORN  V20.8B, V30.8B, V1.8B
    ORN  V23.16B, V0.16B, V26.16B
    ORN  V22.16B, V28.16B, V31.16B
    ORN  V10.8B, V22.8B, V19.8B
    ORN  V1.16B, V25.16B, V31.16B
    ORN  V6.16B, V1.16B, V6.16B
    ORN  V31.16B, V8.16B, V16.16B
    ORN  V24.16B, V23.16B, V0.16B
    ORR  V23.4H, #0xd0, LSL #8
    ORR  V18.8H, #0x72, LSL #8
    ORR  V14.4H, #0x4e, LSL #8
    ORR  V26.4H, #0x4b
    ORR  V1.4H, #0x8c, LSL #8
    ORR  V25.4H, #0x1, LSL #8
    ORR  V17.8H, #0x30, LSL #8
    ORR  V6.4H, #0x77
    ORR  V30.8H, #0xdb, LSL #8
    ORR  V16.4H, #0x6d, LSL #8
    ORR  V9.2S, #0xbc, LSL #24
    ORR  V15.2S, #0xd3, LSL #16
    ORR  V22.4S, #0x98
    ORR  V4.2S, #0xa2
    ORR  V9.4S, #0x65, LSL #24
    ORR  V6.4S, #0xfc, LSL #8
    ORR  V0.4S, #0x48
    ORR  V8.2S, #0x8c
    ORR  V22.4S, #0xa7, LSL #8
    ORR  V19.2S, #0x76, LSL #16
    ORR  V31.16B, V17.16B, V23.16B
    ORR  V0.8B, V30.8B, V4.8B
    ORR  V7.16B, V31.16B, V25.16B
    ORR  V21.16B, V6.16B, V26.16B
    ORR  V6.8B, V19.8B, V16.8B
    ORR  V31.8B, V2.8B, V8.8B
    ORR  V14.8B, V21.8B, V29.8B
    ORR  V24.8B, V7.8B, V22.8B
    ORR  V19.8B, V24.8B, V0.8B
    ORR  V18.8B, V31.8B, V20.8B
    PMUL  V26.16B, V1.16B, V19.16B
    PMUL  V1.8B, V2.8B, V15.8B
    PMUL  V23.8B, V14.8B, V6.8B
    PMUL  V0.8B, V18.8B, V18.8B
    PMUL  V20.16B, V29.16B, V9.16B
    PMUL  V18.16B, V20.16B, V1.16B
    PMUL  V6.16B, V17.16B, V0.16B
    PMUL  V25.8B, V6.8B, V30.8B
    PMUL  V29.16B, V18.16B, V27.16B
    PMUL  V18.16B, V26.16B, V13.16B
    PMULL  V21.8H, V25.8B, V31.8B
    PMULL  V1.8H, V23.8B, V21.8B
    PMULL  V21.8H, V29.8B, V1.8B
    PMULL  V17.8H, V14.8B, V20.8B
    PMULL  V6.8H, V13.8B, V22.8B
    PMULL  V20.8H, V0.8B, V21.8B
    PMULL  V14.8H, V24.8B, V21.8B
    PMULL  V29.1Q, V0.1D, V29.1D
    PMULL  V27.8H, V30.8B, V7.8B
    PMULL  V6.8H, V28.8B, V25.8B
    PMULL2  V9.8H, V18.16B, V22.16B
    PMULL2  V15.8H, V3.16B, V15.16B
    PMULL2  V3.8H, V19.16B, V3.16B
    PMULL2  V1.1Q, V6.2D, V19.2D
    PMULL2  V7.1Q, V3.2D, V27.2D
    PMULL2  V5.1Q, V29.2D, V1.2D
    PMULL2  V21.8H, V2.16B, V18.16B
    PMULL2  V23.8H, V5.16B, V27.16B
    PMULL2  V31.8H, V9.16B, V7.16B
    PMULL2  V28.1Q, V10.2D, V17.2D
    RADDHN  V27.4H, V28.4S, V14.4S
    RADDHN  V0.4H, V27.4S, V31.4S
    RADDHN  V22.4H, V19.4S, V24.4S
    RADDHN  V5.4H, V22.4S, V18.4S
    RADDHN  V17.8B, V15.8H, V21.8H
    RADDHN  V3.4H, V19.4S, V0.4S
    RADDHN  V13.2S, V19.2D, V5.2D
    RADDHN  V0.2S, V13.2D, V20.2D
    RADDHN  V2.2S, V15.2D, V16.2D
    RADDHN  V22.2S, V24.2D, V23.2D
    RADDHN2  V27.4S, V12.2D, V27.2D
    RADDHN2  V6.4S, V29.2D, V17.2D
    RADDHN2  V25.16B, V25.8H, V27.8H
    RADDHN2  V21.16B, V14.8H, V25.8H
    RADDHN2  V4.16B, V21.8H, V2.8H
    RADDHN2  V13.8H, V0.4S, V5.4S
    RADDHN2  V23.4S, V4.2D, V13.2D
    RADDHN2  V21.8H, V3.4S, V10.4S
    RADDHN2  V18.4S, V8.2D, V29.2D
    RADDHN2  V15.4S, V15.2D, V6.2D
    RBIT  V31.8B, V23.8B
    RBIT  V19.16B, V22.16B
    RBIT  V16.8B, V20.8B
    RBIT  V4.16B, V15.16B
    RBIT  V5.16B, V18.16B
    RBIT  V25.8B, V8.8B
    RBIT  V29.16B, V6.16B
    RBIT  V0.8B, V25.8B
    RBIT  V3.8B, V15.8B
    RBIT  V10.8B, V5.8B
    REV16  V15.16B, V0.16B
    REV16  V18.8B, V16.8B
    REV16  V5.16B, V4.16B
    REV16  V8.8B, V15.8B
    REV16  V13.16B, V29.16B
    REV16  V22.16B, V28.16B
    REV16  V15.8B, V18.8B
    REV16  V18.8B, V5.8B
    REV16  V6.16B, V1.16B
    REV16  V25.8B, V18.8B
    REV32  V0.8B, V3.8B
    REV32  V1.8H, V8.8H
    REV32  V5.8B, V20.8B
    REV32  V29.16B, V19.16B
    REV32  V4.4H, V25.4H
    REV32  V23.4H, V21.4H
    REV32  V6.16B, V31.16B
    REV32  V20.16B, V23.16B
    REV32  V9.16B, V23.16B
    REV32  V23.16B, V4.16B
    REV64  V12.4H, V0.4H
    REV64  V8.2S, V12.2S
    REV64  V12.2S, V30.2S
    REV64  V28.16B, V24.16B
    REV64  V31.8H, V23.8H
    REV64  V3.4S, V8.4S
    REV64  V31.8H, V11.8H
    REV64  V4.8H, V1.8H
    REV64  V16.16B, V7.16B
    REV64  V7.4S, V7.4S
    RSHRN V11.8B, V4.8H, #6
    RSHRN V0.8B, V11.8H, #6
    RSHRN V8.8B, V20.8H, #8
    RSHRN V1.8B, V16.8H, #8
    RSHRN V16.8B, V6.8H, #7
    RSHRN V6.8B, V3.8H, #8
    RSHRN V21.8B, V7.8H, #5
    RSHRN V30.8B, V16.8H, #6
    RSHRN V23.8B, V21.8H, #2
    RSHRN V18.8B, V29.8H, #5
    RSHRN V25.4H, V23.4S, #2
    RSHRN V13.4H, V31.4S, #7
    RSHRN V4.4H, V12.4S, #16
    RSHRN V16.4H, V6.4S, #5
    RSHRN V3.4H, V8.4S, #5
    RSHRN V21.4H, V22.4S, #16
    RSHRN V7.4H, V11.4S, #1
    RSHRN V8.4H, V11.4S, #5
    RSHRN V22.4H, V18.4S, #6
    RSHRN V6.4H, V30.4S, #11
    RSHRN V31.2S, V22.2D, #26
    RSHRN V17.2S, V13.2D, #6
    RSHRN V25.2S, V25.2D, #10
    RSHRN V29.2S, V0.2D, #21
    RSHRN V0.2S, V1.2D, #11
    RSHRN V0.2S, V28.2D, #18
    RSHRN V11.2S, V4.2D, #8
    RSHRN V11.2S, V3.2D, #12
    RSHRN V23.2S, V31.2D, #14
    RSHRN V1.2S, V10.2D, #24
    RSHRN2 V4.16B, V18.8H, #3
    RSHRN2 V28.16B, V11.8H, #4
    RSHRN2 V19.16B, V25.8H, #8
    RSHRN2 V7.16B, V21.8H, #2
    RSHRN2 V18.16B, V29.8H, #7
    RSHRN2 V29.16B, V25.8H, #5
    RSHRN2 V3.16B, V16.8H, #3
    RSHRN2 V25.16B, V8.8H, #6
    RSHRN2 V30.16B, V7.8H, #3
    RSHRN2 V29.16B, V19.8H, #4
    RSHRN2 V24.8H, V3.4S, #6
    RSHRN2 V13.8H, V0.4S, #14
    RSHRN2 V7.8H, V25.4S, #3
    RSHRN2 V31.8H, V24.4S, #6
    RSHRN2 V1.8H, V30.4S, #10
    RSHRN2 V8.8H, V4.4S, #1
    RSHRN2 V4.8H, V18.4S, #16
    RSHRN2 V20.8H, V8.4S, #6
    RSHRN2 V16.8H, V29.4S, #2
    RSHRN2 V18.8H, V16.4S, #8
    RSHRN2 V10.4S, V18.2D, #18
    RSHRN2 V3.4S, V10.2D, #31
    RSHRN2 V25.4S, V28.2D, #1
    RSHRN2 V28.4S, V17.2D, #23
    RSHRN2 V17.4S, V4.2D, #16
    RSHRN2 V24.4S, V5.2D, #8
    RSHRN2 V8.4S, V13.2D, #29
    RSHRN2 V29.4S, V3.2D, #11
    RSHRN2 V25.4S, V24.2D, #13
    RSHRN2 V13.4S, V28.2D, #8
    RSUBHN  V10.4H, V31.4S, V13.4S
    RSUBHN  V16.2S, V8.2D, V4.2D
    RSUBHN  V27.4H, V17.4S, V7.4S
    RSUBHN  V20.4H, V0.4S, V20.4S
    RSUBHN  V5.8B, V29.8H, V16.8H
    RSUBHN  V29.2S, V1.2D, V16.2D
    RSUBHN  V28.8B, V29.8H, V8.8H
    RSUBHN  V16.2S, V5.2D, V20.2D
    RSUBHN  V21.8B, V28.8H, V28.8H
    RSUBHN  V4.4H, V27.4S, V27.4S
    RSUBHN2  V18.8H, V30.4S, V10.4S
    RSUBHN2  V5.8H, V21.4S, V13.4S
    RSUBHN2  V17.16B, V25.8H, V25.8H
    RSUBHN2  V28.8H, V3.4S, V11.4S
    RSUBHN2  V27.16B, V25.8H, V16.8H
    RSUBHN2  V25.16B, V10.8H, V4.8H
    RSUBHN2  V0.16B, V29.8H, V28.8H
    RSUBHN2  V11.4S, V5.2D, V12.2D
    RSUBHN2  V8.8H, V27.4S, V17.4S
    RSUBHN2  V3.8H, V8.4S, V8.4S
    SHL  V17.16B, V27.16B, #0x1
    SHL  V8.8B, V19.8B, #0x5
    SHL  V7.16B, V19.16B, #0x2
    SHL  V4.16B, V18.16B, #0x0
    SHL  V10.16B, V8.16B, #0x1
    SHL  V19.8B, V8.8B, #0x2
    SHL  V8.8B, V20.8B, #0x2
    SHL  V4.16B, V3.16B, #0x3
    SHL  V18.16B, V25.16B, #0x3
    SHL  V20.8B, V2.8B, #0x2
    SHL V27.2D, V20.2D, #0x39
    SHL V25.2D, V27.2D, #0x11
    SHL V26.2D, V31.2D, #0x2c
    SHL V2.2D, V11.2D, #0x3e
    SHL V11.2D, V0.2D, #0x3f
    SHL V27.2D, V19.2D, #0x6
    SHL V5.2D, V25.2D, #0x15
    SHL V13.2D, V7.2D, #0x13
    SHL V9.2D, V2.2D, #0x2e
    SHL V5.2D, V24.2D, #0x9
    SHL  V19.8H, V19.8H, #0x5
    SHL  V20.8H, V27.8H, #0x9
    SHL  V24.4H, V26.4H, #0xf
    SHL  V25.4H, V10.4H, #0xa
    SHL  V26.4H, V8.4H, #0x3
    SHL  V31.4H, V4.4H, #0x6
    SHL  V8.4H, V31.4H, #0xf
    SHL  V27.4H, V10.4H, #0x4
    SHL  V29.8H, V9.8H, #0xe
    SHL  V2.8H, V19.8H, #0xc
    SHL  V0.2S, V18.2S, #0x6
    SHL  V31.2S, V28.2S, #0xb
    SHL  V19.2S, V5.2S, #0x1e
    SHL  V18.2S, V11.2S, #0x0
    SHL  V4.4S, V25.4S, #0x19
    SHL  V22.4S, V13.4S, #0x1e
    SHL  V11.4S, V29.4S, #0xa
    SHL  V14.4S, V19.4S, #0x1c
    SHL  V7.2S, V0.2S, #0xe
    SHL  V25.2S, V18.2S, #0x0
    SHLL  V0.8H, V24.8B, #8
    SHLL  V13.4S, V26.4H, #16
    SHLL  V29.4S, V2.4H, #16
    SHLL  V18.8H, V8.8B, #8
    SHLL  V12.8H, V11.8B, #8
    SHLL  V11.8H, V12.8B, #8
    SHLL  V22.8H, V1.8B, #8
    SHLL  V1.2D, V11.2S, #32
    SHLL  V19.8H, V24.8B, #8
    SHLL  V9.8H, V22.8B, #8
    SHLL2  V26.4S, V13.8H, #16
    SHLL2  V8.2D, V0.4S, #32
    SHLL2  V28.2D, V3.4S, #32
    SHLL2  V13.2D, V13.4S, #32
    SHLL2  V0.4S, V18.8H, #16
    SHLL2  V2.2D, V9.4S, #32
    SHLL2  V22.8H, V13.16B, #8
    SHLL2  V11.4S, V25.8H, #16
    SHLL2  V15.4S, V6.8H, #16
    SHLL2  V13.4S, V19.8H, #16
    SHRN V24.8B, V14.8H, #3
    SHRN V19.8B, V26.8H, #5
    SHRN V26.8B, V19.8H, #8
    SHRN V19.8B, V2.8H, #2
    SHRN V27.8B, V3.8H, #1
    SHRN V12.8B, V8.8H, #5
    SHRN V8.8B, V15.8H, #3
    SHRN V9.8B, V27.8H, #1
    SHRN V27.8B, V13.8H, #2
    SHRN V3.8B, V8.8H, #3
    MOVZ  X8, #0x7b71, LSL #0
    MOVK  X8, #0xdd23, LSL #16
    MOVK  X8, #0x8e1c, LSL #32
    MOVK  X8, #0xe32e, LSL #48
    SUB  X20, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x52b8, LSL #0
    MOVK  X8, #0xf9d9, LSL #16
    MOVK  X8, #0x6589, LSL #32
    MOVK  X8, #0x83d2, LSL #48
    SUB  X20, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xca1f, LSL #0
    MOVK  X8, #0x56f1, LSL #16
    MOVK  X8, #0x93e1, LSL #32
    MOVK  X8, #0x4c2f, LSL #48
    SUB  X20, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xe04e, LSL #0
    MOVK  X8, #0x41c1, LSL #16
    MOVK  X8, #0x3156, LSL #32
    MOVK  X8, #0x9f55, LSL #48
    SUB  X20, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x8005, LSL #0
    MOVK  X8, #0xf426, LSL #16
    MOVK  X8, #0x802f, LSL #32
    MOVK  X8, #0xdba0, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xea1, LSL #0
    MOVK  X8, #0x3825, LSL #16
    MOVK  X8, #0xca2f, LSL #32
    MOVK  X8, #0x7994, LSL #48
    SUB  X20, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x4fae, LSL #0
    MOVK  X8, #0x6e75, LSL #16
    MOVK  X8, #0x8631, LSL #32
    MOVK  X8, #0x8172, LSL #48
    SUB  X20, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xb7ba, LSL #0
    MOVK  X8, #0x5c09, LSL #16
    MOVK  X8, #0x47f0, LSL #32
    MOVK  X8, #0xce61, LSL #48
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xb4c6, LSL #0
    MOVK  X8, #0xa87d, LSL #16
    MOVK  X8, #0xe638, LSL #32
    MOVK  X8, #0xc1db, LSL #48
    SUB  X20, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x8da7, LSL #0
    MOVK  X8, #0x4c5d, LSL #16
    MOVK  X8, #0xf4ea, LSL #32
    MOVK  X8, #0xdadb, LSL #48
    SUB  X20, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xfcff, LSL #0
    MOVK  X8, #0x5840, LSL #16
    MOVK  X8, #0x757e, LSL #32
    MOVK  X8, #0x9e49, LSL #48
    SUB  X20, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xdcba, LSL #0
    MOVK  X8, #0xbb40, LSL #16
    MOVK  X8, #0xbb25, LSL #32
    MOVK  X8, #0x2290, LSL #48
    SUB  X20, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x5812, LSL #0
    MOVK  X8, #0xb6dc, LSL #16
    MOVK  X8, #0xde83, LSL #32
    MOVK  X8, #0x8626, LSL #48
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xfada, LSL #0
    MOVK  X8, #0xdcdd, LSL #16
    MOVK  X8, #0x4e21, LSL #32
    MOVK  X8, #0x607c, LSL #48
    SUB  X20, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x46a2, LSL #0
    MOVK  X8, #0x7928, LSL #16
    MOVK  X8, #0x5961, LSL #32
    MOVK  X8, #0x6669, LSL #48
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x34f9, LSL #0
    MOVK  X8, #0x24db, LSL #16
    MOVK  X8, #0x496e, LSL #32
    MOVK  X8, #0xddd4, LSL #48
    SUB  X20, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x166c, LSL #0
    MOVK  X8, #0xef70, LSL #16
    MOVK  X8, #0xf4af, LSL #32
    MOVK  X8, #0xdf66, LSL #48
    SUB  X20, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x6bf5, LSL #0
    MOVK  X8, #0x9daf, LSL #16
    MOVK  X8, #0x2552, LSL #32
    MOVK  X8, #0x5483, LSL #48
    SUB  X20, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x33f1, LSL #0
    MOVK  X8, #0xe2f7, LSL #16
    MOVK  X8, #0x31b6, LSL #32
    MOVK  X8, #0x4360, LSL #48
    SUB  X20, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x441a, LSL #0
    MOVK  X8, #0x2bb4, LSL #16
    MOVK  X8, #0xeb07, LSL #32
    MOVK  X8, #0x684c, LSL #48
    SUB  X20, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X8, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D0
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D1
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5000, LSL #48
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D2
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8e00, LSL #48
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X20, #0xa200, LSL #0
    MOVK  X20, #0x54, LSL #16
    MOVK  X20, #0x1, LSL #32
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D5
    MOVZ  X20, #0xfe00, LSL #0
    MOVK  X20, #0xfdff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D9
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D11
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D16
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xd4, LSL #16
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X20, #0xfe00, LSL #0
    MOVK  X20, #0x8, LSL #48
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D17
    MOVZ  X20, #0xec6e, LSL #0
    MOVK  X20, #0x2, LSL #32
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D19
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8000, LSL #16
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D20
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D28
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X20, #0xf5, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D30
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D31
    MOVZ  X20, #0xe800, LSL #0
    MOVK  X20, #0x3, LSL #16
    MOVK  X20, #0xb000, LSL #32
    MOVK  X20, #0x50, LSL #48
    SUB  X26, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x888e, LSL #0
    MOVK  X2, #0x8aba, LSL #16
    MOVK  X2, #0xd6d0, LSL #32
    MOVK  X2, #0xd4d2, LSL #48
    MOVZ  X3, #0xc243, LSL #0
    MOVK  X3, #0x77e0, LSL #16
    MOVK  X3, #0x68ab, LSL #32
    MOVK  X3, #0x4f20, LSL #48
    MOVZ  X4, #0xd203, LSL #0
    MOVK  X4, #0xd3fc, LSL #16
    MOVK  X4, #0xa05, LSL #32
    MOVK  X4, #0x4402, LSL #48
    MOVZ  X5, #0x95a7, LSL #0
    MOVK  X5, #0xa05d, LSL #16
    MOVK  X5, #0x8016, LSL #32
    MOVK  X5, #0x8b5f, LSL #48
    MOVZ  X6, #0xe860, LSL #0
    MOVK  X6, #0x1b31, LSL #16
    MOVK  X6, #0x2271, LSL #32
    MOVK  X6, #0x3f58, LSL #48
    MOVZ  X7, #0x9f5e, LSL #0
    MOVK  X7, #0x26d4, LSL #16
    MOVK  X7, #0x374e, LSL #32
    MOVK  X7, #0xb089, LSL #48
    MOVZ  X8, #0xf429, LSL #0
    MOVK  X8, #0x4bc6, LSL #16
    MOVK  X8, #0xc01c, LSL #32
    MOVK  X8, #0xa776, LSL #48
    MOVZ  X9, #0xe061, LSL #0
    MOVK  X9, #0xff36, LSL #16
    MOVK  X9, #0x93da, LSL #32
    MOVK  X9, #0x30fe, LSL #48
    MOVZ  X12, #0x4c9f, LSL #0
    MOVK  X12, #0xfdef, LSL #16
    MOVK  X12, #0x31e2, LSL #32
    MOVK  X12, #0xc0f2, LSL #48
    MOVZ  X16, #0x3718, LSL #0
    MOVK  X16, #0x758e, LSL #16
    MOVK  X16, #0xdcc8, LSL #32
    MOVK  X16, #0xf0a0, LSL #48
    MOVZ  X17, #0xa61a, LSL #0
    MOVK  X17, #0x956e, LSL #16
    MOVK  X17, #0x6f77, LSL #32
    MOVK  X17, #0x8c36, LSL #48
    MOVZ  X18, #0x87d1, LSL #0
    MOVK  X18, #0xaf9a, LSL #16
    MOVK  X18, #0xd75b, LSL #32
    MOVK  X18, #0x30a6, LSL #48
    MOVZ  X19, #0xe527, LSL #0
    MOVK  X19, #0xa7f6, LSL #16
    MOVK  X19, #0x7f24, LSL #32
    MOVK  X19, #0xd89a, LSL #48
    MOVZ  X20, #0xc00e, LSL #0
    MOVK  X20, #0xe2d7, LSL #16
    MOVK  X20, #0xb785, LSL #32
    MOVK  X20, #0xcc48, LSL #48
    MOVZ  X21, #0x58a6, LSL #0
    MOVK  X21, #0x5c47, LSL #16
    MOVK  X21, #0x6e12, LSL #32
    MOVK  X21, #0x63d3, LSL #48
    MOVZ  X22, #0x4d8c, LSL #0
    MOVK  X22, #0x49d9, LSL #16
    MOVK  X22, #0xdf4f, LSL #32
    MOVK  X22, #0xb7b1, LSL #48
    MOVZ  X23, #0x3730, LSL #0
    MOVK  X23, #0x7a4, LSL #16
    MOVK  X23, #0xba79, LSL #32
    MOVK  X23, #0x6d4e, LSL #48
    MOVZ  X24, #0xf331, LSL #0
    MOVK  X24, #0xf3cb, LSL #16
    MOVK  X24, #0x1442, LSL #32
    MOVK  X24, #0x15ab, LSL #48
    MOVZ  X25, #0xd7b6, LSL #0
    MOVK  X25, #0x94e1, LSL #16
    MOVK  X25, #0xc304, LSL #32
    MOVK  X25, #0x882e, LSL #48
    MOVZ  X26, #0x3d35, LSL #0
    MOVK  X26, #0xc085, LSL #16
    MOVK  X26, #0x365b, LSL #32
    MOVK  X26, #0x2a82, LSL #48
    MOVZ  X27, #0xf452, LSL #0
    MOVK  X27, #0x56bc, LSL #16
    MOVK  X27, #0xee88, LSL #32
    MOVK  X27, #0xafb5, LSL #48
    MOVZ  X28, #0x8bcb, LSL #0
    MOVK  X28, #0xfa27, LSL #16
    MOVK  X28, #0xe1f9, LSL #32
    MOVK  X28, #0x8c6f, LSL #48
    MOVZ  X29, #0x8d54, LSL #0
    MOVK  X29, #0xb498, LSL #16
    MOVK  X29, #0x7b15, LSL #32
    MOVK  X29, #0x7aab, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X9
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X18
    FMOV  D3, X22
    FMOV  V3.D[1], X17
    FMOV  D4, X23
    FMOV  V4.D[1], X25
    FMOV  D5, X5
    FMOV  V5.D[1], X9
    FMOV  D6, X2
    FMOV  V6.D[1], X29
    FMOV  D7, X7
    FMOV  V7.D[1], X27
    FMOV  D8, X5
    FMOV  V8.D[1], X20
    FMOV  D9, X18
    FMOV  V9.D[1], X22
    FMOV  D10, X23
    FMOV  V10.D[1], X7
    FMOV  D11, X5
    FMOV  V11.D[1], X18
    FMOV  D12, X18
    FMOV  V12.D[1], X3
    FMOV  D13, X16
    FMOV  V13.D[1], X17
    FMOV  D14, X27
    FMOV  V14.D[1], X25
    FMOV  D15, X4
    FMOV  V15.D[1], X8
    FMOV  D16, X2
    FMOV  V16.D[1], X6
    FMOV  D17, X16
    FMOV  V17.D[1], X7
    FMOV  D18, X6
    FMOV  V18.D[1], X18
    FMOV  D19, X9
    FMOV  V19.D[1], X24
    FMOV  D20, X18
    FMOV  V20.D[1], X12
    FMOV  D21, X12
    FMOV  V21.D[1], X8
    FMOV  D22, X19
    FMOV  V22.D[1], X2
    FMOV  D23, X9
    FMOV  V23.D[1], X20
    FMOV  D24, X23
    FMOV  V24.D[1], X5
    FMOV  D25, X26
    FMOV  V25.D[1], X25
    FMOV  D26, X3
    FMOV  V26.D[1], X27
    FMOV  D27, X5
    FMOV  V27.D[1], X29
    FMOV  D28, X3
    FMOV  V28.D[1], X27
    FMOV  D29, X9
    FMOV  V29.D[1], X22
    FMOV  D30, X19
    FMOV  V30.D[1], X22
    FMOV  D31, X22
    FMOV  V31.D[1], X19
    SHRN V19.4H, V24.4S, #14
    SHRN V26.4H, V19.4S, #12
    SHRN V3.4H, V31.4S, #1
    SHRN V16.4H, V26.4S, #14
    SHRN V5.4H, V27.4S, #15
    SHRN V26.4H, V3.4S, #10
    SHRN V10.4H, V25.4S, #12
    SHRN V27.4H, V10.4S, #1
    SHRN V2.4H, V27.4S, #15
    SHRN V20.4H, V10.4S, #3
    SHRN V23.2S, V12.2D, #30
    SHRN V24.2S, V27.2D, #10
    SHRN V16.2S, V30.2D, #13
    SHRN V23.2S, V7.2D, #7
    SHRN V31.2S, V24.2D, #24
    SHRN V1.2S, V2.2D, #18
    SHRN V18.2S, V5.2D, #13
    SHRN V29.2S, V28.2D, #17
    SHRN V2.2S, V31.2D, #27
    SHRN V1.2S, V1.2D, #9
    SHRN2 V1.16B, V20.8H, #8
    SHRN2 V7.16B, V7.8H, #4
    SHRN2 V6.16B, V26.8H, #5
    SHRN2 V9.16B, V1.8H, #2
    SHRN2 V23.16B, V2.8H, #1
    SHRN2 V28.16B, V7.8H, #6
    SHRN2 V3.16B, V28.8H, #3
    SHRN2 V12.16B, V9.8H, #2
    SHRN2 V0.16B, V28.8H, #4
    SHRN2 V31.16B, V23.8H, #5
    SHRN2 V1.8H, V0.4S, #4
    SHRN2 V18.8H, V3.4S, #1
    SHRN2 V30.8H, V3.4S, #13
    SHRN2 V10.8H, V23.4S, #5
    SHRN2 V15.8H, V17.4S, #4
    SHRN2 V26.8H, V22.4S, #8
    SHRN2 V0.8H, V21.4S, #11
    SHRN2 V6.8H, V0.4S, #2
    SHRN2 V25.8H, V15.4S, #10
    SHRN2 V0.8H, V12.4S, #8
    SHRN2 V28.4S, V1.2D, #21
    SHRN2 V17.4S, V30.2D, #32
    SHRN2 V12.4S, V0.2D, #31
    SHRN2 V7.4S, V17.2D, #25
    SHRN2 V0.4S, V12.2D, #6
    SHRN2 V30.4S, V2.2D, #12
    SHRN2 V27.4S, V0.2D, #2
    SHRN2 V15.4S, V18.2D, #1
    SHRN2 V2.4S, V30.2D, #4
    SHRN2 V26.4S, V7.2D, #21
    SLI  V22.8B, V31.8B, #0x4
    SLI  V31.8B, V10.8B, #0x5
    SLI  V3.8B, V31.8B, #0x0
    SLI  V31.16B, V25.16B, #0x6
    SLI  V25.8B, V3.8B, #0x5
    SLI  V17.8B, V2.8B, #0x7
    SLI  V12.16B, V17.16B, #0x5
    SLI  V20.8B, V25.8B, #0x2
    SLI  V30.16B, V26.16B, #0x6
    SLI  V2.16B, V22.16B, #0x4
    SLI V18.2D, V20.2D, #0x6
    SLI V22.2D, V26.2D, #0x2e
    SLI V15.2D, V26.2D, #0x2e
    SLI V26.2D, V2.2D, #0x10
    SLI V21.2D, V30.2D, #0x15
    SLI V3.2D, V27.2D, #0x12
    SLI V16.2D, V12.2D, #0x14
    SLI V25.2D, V6.2D, #0x34
    SLI V30.2D, V20.2D, #0x21
    SLI V6.2D, V30.2D, #0x1
    SLI  V24.4H, V16.4H, #0xa
    SLI  V7.4H, V31.4H, #0xc
    SLI  V15.8H, V25.8H, #0x5
    SLI  V21.8H, V26.8H, #0x7
    SLI  V12.8H, V22.8H, #0xf
    SLI  V2.4H, V12.4H, #0x5
    SLI  V17.4H, V13.4H, #0x3
    SLI  V30.4H, V17.4H, #0x5
    SLI  V9.8H, V26.8H, #0xd
    SLI  V26.8H, V6.8H, #0x7
    SLI  V10.2S, V13.2S, #0x15
    SLI  V22.4S, V10.4S, #0x6
    SLI  V31.2S, V3.2S, #0x6
    SLI  V10.4S, V31.4S, #0x14
    SLI  V17.2S, V21.2S, #0x7
    SLI  V21.4S, V28.4S, #0x1d
    SLI  V20.4S, V24.4S, #0xa
    SLI  V6.2S, V21.2S, #0xf
    SLI  V21.2S, V20.2S, #0x1a
    SLI  V19.4S, V14.4S, #0x12
    SRI  V16.8B, V19.8B, #1
    SRI  V19.8B, V30.8B, #5
    SRI  V7.8B, V30.8B, #5
    SRI  V20.16B, V16.16B, #8
    SRI  V19.8B, V19.8B, #2
    SRI  V12.16B, V6.16B, #2
    SRI  V14.16B, V21.16B, #1
    SRI  V29.8B, V12.8B, #3
    SRI  V12.8B, V29.8B, #1
    SRI  V15.16B, V2.16B, #5
    SRI V15.2D, V0.2D, #42
    SRI V6.2D, V14.2D, #21
    SRI V16.2D, V11.2D, #57
    SRI V3.2D, V22.2D, #37
    SRI V29.2D, V3.2D, #57
    SRI V21.2D, V6.2D, #54
    SRI V3.2D, V20.2D, #15
    SRI V6.2D, V17.2D, #62
    SRI V17.2D, V16.2D, #35
    SRI V11.2D, V19.2D, #11
    SRI  V6.4H, V28.4H, #4
    SRI  V16.8H, V15.8H, #6
    SRI  V9.4H, V3.4H, #12
    SRI  V3.4H, V16.4H, #11
    SRI  V14.8H, V8.8H, #7
    SRI  V18.4H, V6.4H, #8
    SRI  V22.8H, V14.8H, #8
    SRI  V24.8H, V12.8H, #7
    SRI  V6.8H, V11.8H, #2
    SRI  V12.4H, V17.4H, #9
    SRI  V17.2S, V22.2S, #9
    SRI  V0.2S, V23.2S, #31
    SRI  V14.2S, V9.2S, #19
    SRI  V9.2S, V0.2S, #4
    SRI  V8.4S, V30.4S, #4
    SRI  V3.2S, V17.2S, #31
    SRI  V23.4S, V2.4S, #9
    SRI  V26.2S, V8.2S, #13
    SRI  V5.2S, V6.2S, #3
    SRI  V16.2S, V1.2S, #19
    TBL  V25.16B, { V3.16B, V4.16B, V5.16B, V6.16B }, V14.16B
    TBL  V17.8B, { V23.16B, V24.16B, V25.16B, V26.16B }, V31.8B
    TBL  V3.16B, { V12.16B, V13.16B, V14.16B, V15.16B }, V9.16B
    TBL  V31.8B, { V6.16B, V7.16B, V8.16B, V9.16B }, V9.8B
    TBL  V13.8B, { V31.16B, V0.16B, V1.16B, V2.16B }, V29.8B
    TBL  V15.8B, { V2.16B, V3.16B, V4.16B, V5.16B }, V13.8B
    TBL  V7.8B, { V13.16B, V14.16B, V15.16B, V16.16B }, V22.8B
    TBL  V11.8B, { V25.16B, V26.16B, V27.16B, V28.16B }, V19.8B
    TBL  V2.8B, { V23.16B, V24.16B, V25.16B, V26.16B }, V11.8B
    TBL  V31.8B, { V24.16B, V25.16B, V26.16B, V27.16B }, V2.8B
    TBL  V16.8B, { V17.16B }, V7.8B
    TBL  V12.8B, { V31.16B }, V6.8B
    TBL  V31.8B, { V30.16B }, V16.8B
    TBL  V2.8B, { V22.16B }, V31.8B
    TBL  V24.8B, { V12.16B }, V2.8B
    TBL  V13.16B, { V6.16B }, V14.16B
    TBL  V23.16B, { V8.16B }, V30.16B
    TBL  V12.8B, { V13.16B }, V23.8B
    TBL  V22.8B, { V26.16B }, V5.8B
    TBL  V8.16B, { V19.16B }, V2.16B
    TBL  V31.16B, { V20.16B, V21.16B, V22.16B }, V14.16B
    TBL  V5.8B, { V14.16B, V15.16B, V16.16B }, V9.8B
    TBL  V21.8B, { V29.16B, V30.16B, V31.16B }, V9.8B
    TBL  V3.8B, { V28.16B, V29.16B, V30.16B }, V23.8B
    TBL  V29.8B, { V25.16B, V26.16B, V27.16B }, V8.8B
    TBL  V4.16B, { V15.16B, V16.16B, V17.16B }, V1.16B
    TBL  V26.16B, { V13.16B, V14.16B, V15.16B }, V26.16B
    TBL  V14.16B, { V28.16B, V29.16B, V30.16B }, V24.16B
    TBL  V31.16B, { V19.16B, V20.16B, V21.16B }, V0.16B
    TBL  V2.8B, { V16.16B, V17.16B, V18.16B }, V5.8B
    TBL  V29.16B, { V13.16B, V14.16B }, V15.16B
    TBL  V16.8B, { V21.16B, V22.16B }, V15.8B
    TBL  V22.8B, { V8.16B, V9.16B }, V5.8B
    TBL  V10.8B, { V3.16B, V4.16B }, V29.8B
    TBL  V27.16B, { V20.16B, V21.16B }, V26.16B
    TBL  V4.16B, { V24.16B, V25.16B }, V10.16B
    TBL  V23.8B, { V4.16B, V5.16B }, V31.8B
    TBL  V18.16B, { V24.16B, V25.16B }, V23.16B
    TBL  V17.8B, { V8.16B, V9.16B }, V22.8B
    TBL  V20.8B, { V18.16B, V19.16B }, V18.8B
    TBX  V13.16B, { V5.16B, V6.16B, V7.16B, V8.16B }, V2.16B
    TBX  V24.8B, { V12.16B, V13.16B, V14.16B, V15.16B }, V13.8B
    TBX  V30.8B, { V13.16B, V14.16B, V15.16B, V16.16B }, V27.8B
    TBX  V19.8B, { V22.16B, V23.16B, V24.16B, V25.16B }, V24.8B
    TBX  V29.8B, { V20.16B, V21.16B, V22.16B, V23.16B }, V2.8B
    TBX  V18.8B, { V25.16B, V26.16B, V27.16B, V28.16B }, V4.8B
    TBX  V27.16B, { V29.16B, V30.16B, V31.16B, V0.16B }, V29.16B
    TBX  V8.16B, { V2.16B, V3.16B, V4.16B, V5.16B }, V11.16B
    TBX  V1.8B, { V29.16B, V30.16B, V31.16B, V0.16B }, V8.8B
    TBX  V23.16B, { V15.16B, V16.16B, V17.16B, V18.16B }, V18.16B
    TBX  V13.8B, { V23.16B }, V1.8B
    TBX  V28.16B, { V12.16B }, V29.16B
    TBX  V18.16B, { V2.16B }, V25.16B
    TBX  V24.16B, { V2.16B }, V13.16B
    TBX  V3.16B, { V24.16B }, V27.16B
    TBX  V1.8B, { V18.16B }, V28.8B
    TBX  V16.8B, { V17.16B }, V19.8B
    TBX  V29.16B, { V13.16B }, V17.16B
    TBX  V28.8B, { V1.16B }, V3.8B
    TBX  V24.16B, { V17.16B }, V28.16B
    TBX  V19.8B, { V29.16B, V30.16B, V31.16B }, V24.8B
    TBX  V31.8B, { V16.16B, V17.16B, V18.16B }, V6.8B
    TBX  V2.16B, { V2.16B, V3.16B, V4.16B }, V1.16B
    TBX  V6.8B, { V2.16B, V3.16B, V4.16B }, V3.8B
    TBX  V0.8B, { V27.16B, V28.16B, V29.16B }, V29.8B
    TBX  V26.8B, { V2.16B, V3.16B, V4.16B }, V29.8B
    TBX  V27.16B, { V23.16B, V24.16B, V25.16B }, V19.16B
    TBX  V30.8B, { V12.16B, V13.16B, V14.16B }, V21.8B
    TBX  V30.8B, { V8.16B, V9.16B, V10.16B }, V29.8B
    TBX  V11.16B, { V14.16B, V15.16B, V16.16B }, V23.16B
    TBX  V17.8B, { V15.16B, V16.16B }, V27.8B
    TBX  V27.16B, { V20.16B, V21.16B }, V11.16B
    TBX  V1.8B, { V8.16B, V9.16B }, V13.8B
    TBX  V18.8B, { V30.16B, V31.16B }, V1.8B
    TBX  V21.16B, { V11.16B, V12.16B }, V28.16B
    TBX  V1.16B, { V14.16B, V15.16B }, V29.16B
    TBX  V29.8B, { V1.16B, V2.16B }, V24.8B
    TBX  V27.8B, { V30.16B, V31.16B }, V21.8B
    TBX  V1.8B, { V12.16B, V13.16B }, V25.8B
    TBX  V6.16B, { V15.16B, V16.16B }, V8.16B
    MOVZ  X20, #0x888e, LSL #0
    MOVK  X20, #0x8aba, LSL #16
    MOVK  X20, #0xd6d0, LSL #32
    MOVK  X20, #0xd4d2, LSL #48
    SUB  X7, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xc243, LSL #0
    MOVK  X20, #0x77e0, LSL #16
    MOVK  X20, #0x68ab, LSL #32
    MOVK  X20, #0x4f20, LSL #48
    SUB  X7, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xd203, LSL #0
    MOVK  X20, #0xd3fc, LSL #16
    MOVK  X20, #0xa05, LSL #32
    MOVK  X20, #0x4402, LSL #48
    SUB  X7, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x95a7, LSL #0
    MOVK  X20, #0xa05d, LSL #16
    MOVK  X20, #0x8016, LSL #32
    MOVK  X20, #0x8b5f, LSL #48
    SUB  X7, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xe860, LSL #0
    MOVK  X20, #0x1b31, LSL #16
    MOVK  X20, #0x2271, LSL #32
    MOVK  X20, #0x3f58, LSL #48
    SUB  X7, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xf429, LSL #0
    MOVK  X20, #0x4bc6, LSL #16
    MOVK  X20, #0xc01c, LSL #32
    MOVK  X20, #0xa776, LSL #48
    SUB  X7, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xe061, LSL #0
    MOVK  X20, #0xff36, LSL #16
    MOVK  X20, #0x93da, LSL #32
    MOVK  X20, #0x30fe, LSL #48
    SUB  X7, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x4c9f, LSL #0
    MOVK  X20, #0xfdef, LSL #16
    MOVK  X20, #0x31e2, LSL #32
    MOVK  X20, #0xc0f2, LSL #48
    SUB  X7, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x3718, LSL #0
    MOVK  X20, #0x758e, LSL #16
    MOVK  X20, #0xdcc8, LSL #32
    MOVK  X20, #0xf0a0, LSL #48
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x87d1, LSL #0
    MOVK  X20, #0xaf9a, LSL #16
    MOVK  X20, #0xd75b, LSL #32
    MOVK  X20, #0x30a6, LSL #48
    SUB  X7, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xe527, LSL #0
    MOVK  X20, #0xa7f6, LSL #16
    MOVK  X20, #0x7f24, LSL #32
    MOVK  X20, #0xd89a, LSL #48
    SUB  X7, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x58a6, LSL #0
    MOVK  X20, #0x5c47, LSL #16
    MOVK  X20, #0x6e12, LSL #32
    MOVK  X20, #0x63d3, LSL #48
    SUB  X7, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x4d8c, LSL #0
    MOVK  X20, #0x49d9, LSL #16
    MOVK  X20, #0xdf4f, LSL #32
    MOVK  X20, #0xb7b1, LSL #48
    SUB  X7, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x3730, LSL #0
    MOVK  X20, #0x7a4, LSL #16
    MOVK  X20, #0xba79, LSL #32
    MOVK  X20, #0x6d4e, LSL #48
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xf331, LSL #0
    MOVK  X20, #0xf3cb, LSL #16
    MOVK  X20, #0x1442, LSL #32
    MOVK  X20, #0x15ab, LSL #48
    SUB  X7, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xd7b6, LSL #0
    MOVK  X20, #0x94e1, LSL #16
    MOVK  X20, #0xc304, LSL #32
    MOVK  X20, #0x882e, LSL #48
    SUB  X7, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x3d35, LSL #0
    MOVK  X20, #0xc085, LSL #16
    MOVK  X20, #0x365b, LSL #32
    MOVK  X20, #0x2a82, LSL #48
    SUB  X7, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0xf452, LSL #0
    MOVK  X20, #0x56bc, LSL #16
    MOVK  X20, #0xee88, LSL #32
    MOVK  X20, #0xafb5, LSL #48
    SUB  X7, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x8bcb, LSL #0
    MOVK  X20, #0xfa27, LSL #16
    MOVK  X20, #0xe1f9, LSL #32
    MOVK  X20, #0x8c6f, LSL #48
    SUB  X7, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x8d54, LSL #0
    MOVK  X20, #0xb498, LSL #16
    MOVK  X20, #0x7b15, LSL #32
    MOVK  X20, #0x7aab, LSL #48
    SUB  X7, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X20, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D0
    MOVZ  X7, #0x8bcb, LSL #0
    MOVK  X7, #0xfa27, LSL #16
    MOVK  X7, #0xe1f8, LSL #32
    MOVK  X7, #0x8c6f, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D6
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D7
    MOVZ  X7, #0x1400, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D9
    MOVZ  X7, #0x78bc, LSL #0
    MOVK  X7, #0xfa2, LSL #16
    MOVK  X7, #0xfe1f, LSL #32
    MOVK  X7, #0x18c6, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D11
    MOVZ  X7, #0x4e00, LSL #0
    MOVK  X7, #0xe0, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D13
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X7, #0x4343, LSL #0
    MOVK  X7, #0x4343, LSL #16
    MOVK  X7, #0x4343, LSL #32
    MOVK  X7, #0x4343, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D14
    MOVZ  X7, #0x4343, LSL #0
    MOVK  X7, #0x4343, LSL #16
    MOVK  X7, #0x4343, LSL #32
    MOVK  X7, #0x4343, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D15
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D17
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D19
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D23
    MOVZ  X7, #0x3030, LSL #0
    MOVK  X7, #0x3030, LSL #16
    MOVK  X7, #0x3030, LSL #32
    MOVK  X7, #0x3030, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X7, #0xe0e0, LSL #0
    MOVK  X7, #0xe0e0, LSL #16
    MOVK  X7, #0xe0e0, LSL #32
    MOVK  X7, #0xe0e0, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D25
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x79, LSL #32
    MOVK  X7, #0x4e, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x4c04, LSL #0
    MOVK  X2, #0x3043, LSL #16
    MOVK  X2, #0xd559, LSL #32
    MOVK  X2, #0x4ee9, LSL #48
    MOVZ  X3, #0x2095, LSL #0
    MOVK  X3, #0x8b3a, LSL #16
    MOVK  X3, #0xa0e1, LSL #32
    MOVK  X3, #0xb156, LSL #48
    MOVZ  X4, #0xd63e, LSL #0
    MOVK  X4, #0x5369, LSL #16
    MOVK  X4, #0x4f60, LSL #32
    MOVK  X4, #0x8200, LSL #48
    MOVZ  X5, #0x5531, LSL #0
    MOVK  X5, #0xf972, LSL #16
    MOVK  X5, #0x993d, LSL #32
    MOVK  X5, #0xf247, LSL #48
    MOVZ  X6, #0xca1, LSL #0
    MOVK  X6, #0xc27e, LSL #16
    MOVK  X6, #0x92bc, LSL #32
    MOVK  X6, #0x69a8, LSL #48
    MOVZ  X7, #0xb57c, LSL #0
    MOVK  X7, #0x9f69, LSL #16
    MOVK  X7, #0xc208, LSL #32
    MOVK  X7, #0x2359, LSL #48
    MOVZ  X8, #0x356a, LSL #0
    MOVK  X8, #0xdba8, LSL #16
    MOVK  X8, #0xf20f, LSL #32
    MOVK  X8, #0xdde, LSL #48
    MOVZ  X9, #0x347e, LSL #0
    MOVK  X9, #0xa3e6, LSL #16
    MOVK  X9, #0x40ec, LSL #32
    MOVK  X9, #0x91f2, LSL #48
    MOVZ  X12, #0x411c, LSL #0
    MOVK  X12, #0x9e, LSL #16
    MOVK  X12, #0x4a10, LSL #32
    MOVK  X12, #0xab, LSL #48
    MOVZ  X16, #0x52d9, LSL #0
    MOVK  X16, #0xfbf8, LSL #16
    MOVK  X16, #0x29cf, LSL #32
    MOVK  X16, #0x8cb7, LSL #48
    MOVZ  X17, #0x6b46, LSL #0
    MOVK  X17, #0x2129, LSL #16
    MOVK  X17, #0x22a8, LSL #32
    MOVK  X17, #0xac7b, LSL #48
    MOVZ  X18, #0xbe56, LSL #0
    MOVK  X18, #0x11de, LSL #16
    MOVK  X18, #0x1625, LSL #32
    MOVK  X18, #0x1a48, LSL #48
    MOVZ  X19, #0xc476, LSL #0
    MOVK  X19, #0x5124, LSL #16
    MOVK  X19, #0x12cd, LSL #32
    MOVK  X19, #0x6ab6, LSL #48
    MOVZ  X20, #0x2196, LSL #0
    MOVK  X20, #0x5eaf, LSL #16
    MOVK  X20, #0xf720, LSL #32
    MOVK  X20, #0xb8a7, LSL #48
    MOVZ  X21, #0x12b, LSL #0
    MOVK  X21, #0xe426, LSL #16
    MOVK  X21, #0x1086, LSL #32
    MOVK  X21, #0xbac2, LSL #48
    MOVZ  X22, #0x63c3, LSL #0
    MOVK  X22, #0x35be, LSL #16
    MOVK  X22, #0x596d, LSL #32
    MOVK  X22, #0x46dd, LSL #48
    MOVZ  X23, #0xc6c9, LSL #0
    MOVK  X23, #0xc703, LSL #16
    MOVK  X23, #0x7a90, LSL #32
    MOVK  X23, #0x7e8e, LSL #48
    MOVZ  X24, #0x10bf, LSL #0
    MOVK  X24, #0x87f5, LSL #16
    MOVK  X24, #0x8553, LSL #32
    MOVK  X24, #0x5d2d, LSL #48
    MOVZ  X25, #0x80a6, LSL #0
    MOVK  X25, #0xfc88, LSL #16
    MOVK  X25, #0x9525, LSL #32
    MOVK  X25, #0x3fd5, LSL #48
    MOVZ  X26, #0xe829, LSL #0
    MOVK  X26, #0x1510, LSL #16
    MOVK  X26, #0x155f, LSL #32
    MOVK  X26, #0xe723, LSL #48
    MOVZ  X27, #0xb9e4, LSL #0
    MOVK  X27, #0x8244, LSL #16
    MOVK  X27, #0x5319, LSL #32
    MOVK  X27, #0x6568, LSL #48
    MOVZ  X28, #0xa02, LSL #0
    MOVK  X28, #0x6bb8, LSL #16
    MOVK  X28, #0x77f1, LSL #32
    MOVK  X28, #0x868f, LSL #48
    MOVZ  X29, #0x5738, LSL #0
    MOVK  X29, #0x1142, LSL #16
    MOVK  X29, #0xa90d, LSL #32
    MOVK  X29, #0x87b5, LSL #48
    FMOV  D0, X12
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X22
    FMOV  V3.D[1], X5
    FMOV  D4, X20
    FMOV  V4.D[1], X27
    FMOV  D5, X28
    FMOV  V5.D[1], X28
    FMOV  D6, X16
    FMOV  V6.D[1], X25
    FMOV  D7, X8
    FMOV  V7.D[1], X18
    FMOV  D8, X18
    FMOV  V8.D[1], X18
    FMOV  D9, X25
    FMOV  V9.D[1], X24
    FMOV  D10, X23
    FMOV  V10.D[1], X19
    FMOV  D11, X12
    FMOV  V11.D[1], X21
    FMOV  D12, X29
    FMOV  V12.D[1], X23
    FMOV  D13, X18
    FMOV  V13.D[1], X9
    FMOV  D14, X23
    FMOV  V14.D[1], X4
    FMOV  D15, X12
    FMOV  V15.D[1], X18
    FMOV  D16, X21
    FMOV  V16.D[1], X17
    FMOV  D17, X19
    FMOV  V17.D[1], X17
    FMOV  D18, X12
    FMOV  V18.D[1], X2
    FMOV  D19, X6
    FMOV  V19.D[1], X16
    FMOV  D20, X22
    FMOV  V20.D[1], X19
    FMOV  D21, X19
    FMOV  V21.D[1], X16
    FMOV  D22, X29
    FMOV  V22.D[1], X28
    FMOV  D23, X16
    FMOV  V23.D[1], X20
    FMOV  D24, X6
    FMOV  V24.D[1], X8
    FMOV  D25, X21
    FMOV  V25.D[1], X18
    FMOV  D26, X8
    FMOV  V26.D[1], X24
    FMOV  D27, X4
    FMOV  V27.D[1], X19
    FMOV  D28, X17
    FMOV  V28.D[1], X8
    FMOV  D29, X28
    FMOV  V29.D[1], X23
    FMOV  D30, X27
    FMOV  V30.D[1], X12
    FMOV  D31, X21
    FMOV  V31.D[1], X22
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_0:
    PMUL  V0.16B, V29.16B, V13.16B
    SRI  V31.4S, V25.4S, #12
    SHLL  V11.8H, V30.8B, #8
    ADDP  D6, V23.2D
    DUP  V26.8B, V26.B[0xe]
    ADDV  S19, V11.4S
    EXT  V0.8B, V27.8B, V26.8B, #0x3
    SRI V28.2D, V24.2D, #37
    SLI V7.2D, V31.2D, #0x2d
    REV64  V14.8B, V28.8B
    AESD  V16.16B, V6.16B
    REV16  V19.16B, V0.16B
    MLS  V31.8H, V21.8H, V10.H[0x0]
    SHRN V30.8B, V16.8H, #8
    BIT  V27.8B, V7.8B, V4.8B
    TBX  V21.8B, { V10.16B, V11.16B, V12.16B }, V14.8B
    MUL  V12.4S, V29.4S, V30.S[0x3]
    RADDHN2  V29.16B, V24.8H, V19.8H
    INS V26.H[0x4], V31.H[0x4]
    MOV V6.D[0x0], V21.D[0x1]
    DUP V13.4H, W9
    MOV  W21, V27.S[0x3]
    MOV B19, V29.B[0xc]
    MOVI  V24.2S, #0xf6
    UZP1  V28.16B, V29.16B, V0.16B
    TBX  V16.8B, { V4.16B, V5.16B, V6.16B, V7.16B }, V31.8B
    REV32  V31.8B, V23.8B
    DUP V7.8H, W2
    MOVI  V30.2S, #0x94, LSL #8
    MOV V25.S[0x3], W9
    TRN1  V22.4S, V13.4S, V19.4S
    EXT  V19.16B, V26.16B, V17.16B, #0x5
    BIC  V26.16B, V24.16B, V22.16B
    TRN2  V5.4H, V16.4H, V26.4H
    XTN2  V24.16B, V12.8H
    RSHRN V13.8B, V5.8H, #2
    MOV D5, V10.D[0x1]
    MVN  V21.16B, V7.16B
    EXT  V0.8B, V28.8B, V25.8B, #0x0
    RSUBHN2  V23.4S, V5.2D, V19.2D
    MOV S17, V21.S[0x2]
    REV16  V16.8B, V17.8B
    INS V22.S[0x0], W2
    RSUBHN2  V17.8H, V3.4S, V24.4S
    DUP V7.2D, V8.D[0x1]
    MVNI  V12.4H, #0xbe
    DUP B8, V16.B[0x3]
    MVNI  V24.8H, #0xad
    MUL  V5.2S, V8.2S, V30.S[0x3]
    REV16  V8.8B, V7.8B
    MOV V29.B[0x4], W21
    XTN  V10.8B, V20.8H
    MOVI  V17.4S, #0xd2, MSL #16
    EOR  V7.8B, V1.8B, V22.8B
    DUP V29.2S, W25
    INS V25.H[0x4], V17.H[0x3]
    SLI  V24.4S, V21.4S, #0x7
    RADDHN  V16.4H, V0.4S, V5.4S
    REV16  V23.16B, V8.16B
    MOVI  V22.2S, #0xf0, LSL #24
    MVNI  V21.2S, #0x9c, MSL #16
    MOV V20.B[0x8], V3.B[0xd]
    TBX  V6.8B, { V20.16B }, V24.8B
    AESIMC  V28.16B, V0.16B
    MOV V19.S[0x2], V16.S[0x2]
    ORN  V31.8B, V1.8B, V22.8B
    AESE  V8.16B, V12.16B
    MOVI  V22.8H, #0x87
    AESMC  V24.16B, V29.16B
    SUBHN2  V0.16B, V31.8H, V24.8H
    BIC  V2.4H, #0x89
    ADDHN  V28.2S, V0.2D, V8.2D
    MOV V8.D[0x1], V6.D[0x0]
    ORR  V30.16B, V7.16B, V3.16B
    SLI  V20.8B, V22.8B, #0x4
    ADD  V24.2D, V9.2D, V23.2D
    RSUBHN2  V22.8H, V19.4S, V22.4S
    TBL  V16.16B, { V26.16B, V27.16B, V28.16B, V29.16B }, V8.16B
    ABS  V8.4H, V25.4H
    TRN1  V7.2D, V24.2D, V16.2D
    MOV H19, V22.H[0x6]
    REV64  V17.8H, V30.8H
    ADDV  B9, V15.8B
    BIC  V31.8H, #0x40
    ORR  V17.2S, #0xa9, LSL #16
    DUP D15, V31.D[0x0]
    ORN  V12.16B, V24.16B, V15.16B
    ADDV  S25, V12.4S
    MVNI  V30.4H, #0xa7
    TBX  V15.8B, { V23.16B, V24.16B }, V19.8B
    XTN2  V5.8H, V15.4S
    ZIP1  V23.16B, V29.16B, V27.16B
    XTN2  V12.16B, V17.8H
    ORR  V16.8H, #0xb8
    ADD  V15.8B, V9.8B, V9.8B
    MLS  V29.8H, V7.8H, V3.H[0x4]
    MOV B4, V24.B[0x6]
    MLS  V22.2S, V8.2S, V15.S[0x1]
    DUP V9.2S, W20
    ADDP  V8.16B, V30.16B, V9.16B
    INS V7.S[0x3], V27.S[0x0]
    MOV H17, V22.H[0x5]
    NEG  V18.16B, V5.16B
    MOV V23.B[0xc], W2
    SHRN V27.8B, V29.8H, #2
    DUP V19.4H, W9
    MOV V22.B[0xa], W21
    BSL  V30.16B, V8.16B, V27.16B
    SLI  V5.4S, V23.4S, #0x16
    BIT  V23.8B, V4.8B, V18.8B
    SHL  V9.4H, V25.4H, #0xc
    SUBHN  V24.4H, V19.4S, V4.4S
    SHRN V4.8B, V9.8H, #1
    MVNI  V3.4H, #0xb4, LSL #8
    SHLL2  V9.2D, V4.4S, #32
    MVNI  V29.4S, #0x25, MSL #16
    MVN  V15.16B, V24.16B
    INS V18.H[0x0], W20
    MOVI  V24.4S, #0xaa, MSL #16
    PMULL  V19.8H, V29.8B, V15.8B
    DUP V8.16B, W21
    BIC  V25.8B, V3.8B, V16.8B
    ZIP2  V25.16B, V5.16B, V24.16B
    INS V15.D[0x1], V27.D[0x1]
    MOV  V19.16B, V18.16B
    DUP V27.2S, W12
    CLS  V24.8H, V25.8H
    EXT  V3.16B, V2.16B, V15.16B, #0x3
    RADDHN2  V10.4S, V19.2D, V27.2D
    MUL  V22.2S, V9.2S, V23.S[0x3]
    MUL  V21.2S, V8.2S, V11.S[0x2]
    DUP D16, V24.D[0x1]
    MLA  V11.8H, V21.8H, V3.H[0x6]
    SHRN2 V3.16B, V16.8H, #7
    AESMC  V16.16B, V22.16B
    RSUBHN  V4.8B, V12.8H, V3.8H
    MLS  V9.2S, V11.2S, V17.S[0x0]
    TRN2  V17.16B, V7.16B, V16.16B
    ZIP2  V27.8H, V11.8H, V3.8H
    REV16  V25.8B, V28.8B
    MOV V20.D[0x0], V1.D[0x1]
    INS V1.H[0x0], V17.H[0x3]
    MLS  V28.4S, V10.4S, V20.S[0x1]
    MOV H19, V0.H[0x5]
    SHRN V16.8B, V9.8H, #3
    SRI  V21.8H, V21.8H, #6
    SRI  V23.8H, V1.8H, #8
    TRN2  V26.2S, V6.2S, V28.2S
    SRI  V24.16B, V27.16B, #7
    DUP V6.8H, W27
    RSHRN2 V3.8H, V26.4S, #8
    RSUBHN  V4.4H, V3.4S, V3.4S
    RADDHN  V27.8B, V30.8H, V22.8H
    MOV S17, V6.S[0x1]
    DUP V11.2D, V17.D[0x0]
    ADDV  B10, V4.16B
    MLS  V1.4S, V11.4S, V19.S[0x1]
    DUP V20.2D, V14.D[0x0]
    MOV V22.B[0xf], W17
    DUP  V11.4S, V24.S[0x1]
    INS V25.D[0x0], X18
    MUL  V4.8H, V25.8H, V11.H[0x2]
    INS V14.H[0x3], W23
    SHL  V25.16B, V14.16B, #0x3
    SHL V30.2D, V27.2D, #0xd
    DUP V27.2D, V22.D[0x1]
    INS V9.B[0x3], W6
    EOR  V5.8B, V4.8B, V30.8B
    EXT  V6.8B, V27.8B, V9.8B, #0x6
    SHL  V4.2S, V0.2S, #0x1b
    EXT  V28.16B, V10.16B, V4.16B, #0x1
    BIC  V28.8B, V28.8B, V28.8B
    SRI V17.2D, V5.2D, #14
    NOT  V4.8B, V17.8B
    SLI V17.2D, V6.2D, #0x38
    SLI  V14.2S, V4.2S, #0x1a
    ADDP  D6, V17.2D
    MLS  V11.2S, V14.2S, V8.S[0x0]
    SHRN2 V0.4S, V6.2D, #9
    SHL  V6.8B, V14.8B, #0x1
    XTN2  V1.4S, V6.2D
    PMULL2  V7.8H, V0.16B, V11.16B
    RSHRN2 V24.16B, V20.8H, #1
    SLI  V20.8H, V28.8H, #0x7
    AESIMC  V2.16B, V24.16B
    REV16  V5.16B, V9.16B
    MUL  V18.2S, V5.2S, V2.S[0x3]
    DUP S10, V16.S[0x0]
    MVN  V6.8B, V18.8B
    MOV V17.D[0x0], V6.D[0x1]
    BIC  V1.8B, V10.8B, V26.8B
    PMULL  V4.1Q, V20.1D, V30.1D
    BIF  V9.16B, V9.16B, V31.16B
    SRI  V24.16B, V1.16B, #4
    SHL  V16.16B, V26.16B, #0x5
    RSHRN V11.8B, V24.8H, #8
    RSHRN2 V4.8H, V30.4S, #8
    MOV V14.H[0x2], V11.H[0x2]
    SHL  V18.16B, V14.16B, #0x6
    DUP D1, V18.D[0x1]
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_0
    MOVZ  X28, #0x4c04, LSL #0
    MOVK  X28, #0x3043, LSL #16
    MOVK  X28, #0xd559, LSL #32
    MOVK  X28, #0x4ee9, LSL #48
    SUB  X26, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x2095, LSL #0
    MOVK  X28, #0x8b3a, LSL #16
    MOVK  X28, #0xa0e1, LSL #32
    MOVK  X28, #0xb156, LSL #48
    SUB  X26, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xd63e, LSL #0
    MOVK  X28, #0x5369, LSL #16
    MOVK  X28, #0x4f60, LSL #32
    MOVK  X28, #0x8200, LSL #48
    SUB  X26, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x5531, LSL #0
    MOVK  X28, #0xf972, LSL #16
    MOVK  X28, #0x993d, LSL #32
    MOVK  X28, #0xf247, LSL #48
    SUB  X26, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xca1, LSL #0
    MOVK  X28, #0xc27e, LSL #16
    MOVK  X28, #0x92bc, LSL #32
    MOVK  X28, #0x69a8, LSL #48
    SUB  X26, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xb57c, LSL #0
    MOVK  X28, #0x9f69, LSL #16
    MOVK  X28, #0xc208, LSL #32
    MOVK  X28, #0x2359, LSL #48
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x347e, LSL #0
    MOVK  X28, #0xa3e6, LSL #16
    MOVK  X28, #0x40ec, LSL #32
    MOVK  X28, #0x91f2, LSL #48
    SUB  X26, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x411c, LSL #0
    MOVK  X28, #0x9e, LSL #16
    MOVK  X28, #0x4a10, LSL #32
    MOVK  X28, #0xab, LSL #48
    SUB  X26, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x52d9, LSL #0
    MOVK  X28, #0xfbf8, LSL #16
    MOVK  X28, #0x29cf, LSL #32
    MOVK  X28, #0x8cb7, LSL #48
    SUB  X26, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x6b46, LSL #0
    MOVK  X28, #0x2129, LSL #16
    MOVK  X28, #0x22a8, LSL #32
    MOVK  X28, #0xac7b, LSL #48
    SUB  X26, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xbe56, LSL #0
    MOVK  X28, #0x11de, LSL #16
    MOVK  X28, #0x1625, LSL #32
    MOVK  X28, #0x1a48, LSL #48
    SUB  X26, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xc476, LSL #0
    MOVK  X28, #0x5124, LSL #16
    MOVK  X28, #0x12cd, LSL #32
    MOVK  X28, #0x6ab6, LSL #48
    SUB  X26, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x2196, LSL #0
    MOVK  X28, #0x5eaf, LSL #16
    MOVK  X28, #0xf720, LSL #32
    MOVK  X28, #0xb8a7, LSL #48
    SUB  X26, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x63c3, LSL #0
    MOVK  X28, #0x35be, LSL #16
    MOVK  X28, #0x596d, LSL #32
    MOVK  X28, #0x46dd, LSL #48
    SUB  X26, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x10bf, LSL #0
    MOVK  X28, #0x87f5, LSL #16
    MOVK  X28, #0x8553, LSL #32
    MOVK  X28, #0x5d2d, LSL #48
    SUB  X26, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x80a6, LSL #0
    MOVK  X28, #0xfc88, LSL #16
    MOVK  X28, #0x9525, LSL #32
    MOVK  X28, #0x3fd5, LSL #48
    SUB  X26, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xb9e4, LSL #0
    MOVK  X28, #0x8244, LSL #16
    MOVK  X28, #0x5319, LSL #32
    MOVK  X28, #0x6568, LSL #48
    SUB  X26, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x5738, LSL #0
    MOVK  X28, #0x1142, LSL #16
    MOVK  X28, #0xa90d, LSL #32
    MOVK  X28, #0x87b5, LSL #48
    SUB  X26, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X28, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X26, #0x15, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D0
    MOVZ  X26, #0xda00, LSL #0
    MOVK  X26, #0xda00, LSL #16
    MOVK  X26, #0x4600, LSL #32
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D1
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D2
    MOVZ  X26, #0x2a36, LSL #0
    MOVK  X26, #0x263c, LSL #16
    MOVK  X26, #0x5868, LSL #32
    MOVK  X26, #0x4870, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8316, LSL #16
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D3
    MOVZ  X26, #0x6026, LSL #0
    MOVK  X26, #0x7058, LSL #16
    MOVK  X26, #0x48, LSL #32
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X26, #0xeae0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D4
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D5
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa1, LSL #16
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D6
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D9
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa100, LSL #16
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X26, #0xe900, LSL #0
    MOVK  X26, #0xaf5b, LSL #16
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D12
    MOVZ  X26, #0x40, LSL #0
    MOVK  X26, #0xf140, LSL #16
    MOVK  X26, #0x40, LSL #32
    MOVK  X26, #0xf040, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D13
    MOVZ  X26, #0x15, LSL #0
    MOVK  X26, #0x15, LSL #16
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D14
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5000, LSL #16
    MOVK  X26, #0xfc01, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D15
    MOVZ  X26, #0xcb81, LSL #0
    MOVK  X26, #0xcb81, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D16
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xc080, LSL #32
    MOVK  X26, #0x6060, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D18
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x40, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D19
    MOVZ  X26, #0xf53d, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x4600, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D25
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D26
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x1664, LSL #32
    MOVK  X26, #0x6383, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x4600, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D27
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x4600, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xffda, LSL #16
    MOVK  X26, #0xffda, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D29
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xffda, LSL #16
    MOVK  X26, #0xffda, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D30
    MOVZ  X26, #0xe000, LSL #0
    MOVK  X26, #0xaea, LSL #16
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D31
    MOVZ  X26, #0xffbf, LSL #0
    MOVK  X26, #0xfbf, LSL #16
    MOVK  X26, #0xffbf, LSL #32
    MOVK  X26, #0xfbf, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
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
    FMOV  D0, X29
    FMOV  V0.D[1], X18
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X7
    FMOV  V2.D[1], X12
    FMOV  D3, X24
    FMOV  V3.D[1], X22
    FMOV  D4, X27
    FMOV  V4.D[1], X22
    FMOV  D5, X21
    FMOV  V5.D[1], X4
    FMOV  D6, X9
    FMOV  V6.D[1], X25
    FMOV  D7, X28
    FMOV  V7.D[1], X22
    FMOV  D8, X21
    FMOV  V8.D[1], X3
    FMOV  D9, X19
    FMOV  V9.D[1], X12
    FMOV  D10, X18
    FMOV  V10.D[1], X29
    FMOV  D11, X2
    FMOV  V11.D[1], X23
    FMOV  D12, X27
    FMOV  V12.D[1], X5
    FMOV  D13, X18
    FMOV  V13.D[1], X5
    FMOV  D14, X22
    FMOV  V14.D[1], X22
    FMOV  D15, X28
    FMOV  V15.D[1], X19
    FMOV  D16, X3
    FMOV  V16.D[1], X22
    FMOV  D17, X29
    FMOV  V17.D[1], X24
    FMOV  D18, X21
    FMOV  V18.D[1], X4
    FMOV  D19, X21
    FMOV  V19.D[1], X25
    FMOV  D20, X29
    FMOV  V20.D[1], X29
    FMOV  D21, X27
    FMOV  V21.D[1], X2
    FMOV  D22, X20
    FMOV  V22.D[1], X2
    FMOV  D23, X3
    FMOV  V23.D[1], X19
    FMOV  D24, X19
    FMOV  V24.D[1], X20
    FMOV  D25, X12
    FMOV  V25.D[1], X2
    FMOV  D26, X4
    FMOV  V26.D[1], X9
    FMOV  D27, X9
    FMOV  V27.D[1], X6
    FMOV  D28, X21
    FMOV  V28.D[1], X26
    FMOV  D29, X4
    FMOV  V29.D[1], X21
    FMOV  D30, X4
    FMOV  V30.D[1], X27
    FMOV  D31, X21
    FMOV  V31.D[1], X27
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_1:
    SUB  V31.2S, V22.2S, V21.2S
    PMULL  V26.1Q, V27.1D, V27.1D
    BIC  V25.2S, #0xe2, LSL #24
    MVN  V0.16B, V14.16B
    MUL  V31.16B, V0.16B, V25.16B
    MOV  V8.8B, V28.8B
    MLS  V30.8H, V31.8H, V10.H[0x6]
    ORN  V14.16B, V11.16B, V30.16B
    SRI  V24.4S, V18.4S, #17
    ORR  V20.4S, #0x41, LSL #16
    ADDHN2  V7.4S, V12.2D, V0.2D
    AESIMC  V23.16B, V26.16B
    ADDV  S24, V16.4S
    MOV D1, V20.D[0x0]
    BIC  V0.16B, V7.16B, V25.16B
    RSHRN2 V30.8H, V23.4S, #1
    RADDHN2  V21.8H, V24.4S, V9.4S
    SUBHN  V10.8B, V29.8H, V21.8H
    MOV B10, V1.B[0x8]
    DUP  V18.4S, V10.S[0x1]
    MOVI  V27.16B, #0xc7
    INS V25.B[0x7], V21.B[0xd]
    ORN  V15.8B, V28.8B, V13.8B
    DUP S9, V30.S[0x3]
    MVNI  V30.8H, #0x51
    PMUL  V21.16B, V25.16B, V27.16B
    ADD  V7.8H, V8.8H, V26.8H
    CNT  V26.16B, V6.16B
    SRI  V22.2S, V7.2S, #18
    RSUBHN2  V27.4S, V9.2D, V26.2D
    RSHRN2 V25.8H, V24.4S, #6
    RADDHN2  V28.16B, V15.8H, V29.8H
    BIC  V8.16B, V22.16B, V30.16B
    ADDHN2  V15.16B, V8.8H, V16.8H
    CLZ  V24.8B, V27.8B
    AND  V23.8B, V8.8B, V15.8B
    INS V20.S[0x2], V29.S[0x2]
    TBL  V6.8B, { V24.16B, V25.16B }, V25.8B
    TBX  V15.16B, { V21.16B, V22.16B }, V0.16B
    TBL  V8.16B, { V8.16B, V9.16B, V10.16B }, V20.16B
    RSHRN V30.8B, V28.8H, #8
    DUP  V25.2S, V30.S[0x1]
    SHRN2 V16.8H, V23.4S, #16
    MOV  V24.8B, V8.8B
    SHL  V7.4S, V16.4S, #0x1c
    SHRN2 V0.16B, V24.8H, #3
    RSHRN V16.2S, V0.2D, #10
    UZP2  V28.16B, V25.16B, V7.16B
    NOT  V0.8B, V14.8B
    TBX  V29.8B, { V1.16B, V2.16B, V3.16B }, V16.8B
    REV32  V22.8H, V15.8H
    SRI V14.2D, V28.2D, #7
    MLA  V16.8H, V14.8H, V11.H[0x7]
    MOV D21, V6.D[0x1]
    ORR  V26.8H, #0x64
    MLS  V10.8H, V20.8H, V9.H[0x4]
    INS V25.S[0x0], W8
    BIC  V1.4H, #0xd4, LSL #8
    AESD  V15.16B, V25.16B
    INS V24.D[0x1], X29
    BIC  V23.4S, #0x7d
    INS V23.D[0x1], V15.D[0x1]
    MVNI  V30.8H, #0xdb, LSL #8
    NEG  V15.2S, V25.2S
    SHL  V28.8B, V22.8B, #0x2
    RADDHN2  V9.4S, V16.2D, V15.2D
    ZIP2  V14.2D, V28.2D, V3.2D
    MLA  V7.4S, V1.4S, V9.4S
    SUBHN2  V26.4S, V28.2D, V20.2D
    ADDP  V2.8B, V1.8B, V26.8B
    UZP2  V18.4H, V17.4H, V30.4H
    TBL  V19.16B, { V10.16B, V11.16B }, V0.16B
    DUP H25, V20.H[0x6]
    SRI  V15.4H, V14.4H, #1
    MLA  V28.8B, V23.8B, V19.8B
    MVNI  V18.4H, #0x3e
    TBX  V6.16B, { V25.16B }, V29.16B
    XTN2  V25.4S, V6.2D
    TBL  V10.8B, { V26.16B, V27.16B, V28.16B, V29.16B }, V25.8B
    MLS  V17.4H, V7.4H, V2.H[0x4]
    PMUL  V24.16B, V10.16B, V17.16B
    SRI V6.2D, V18.2D, #41
    MOV  W20, V24.S[0x0]
    MOVI  V22.2D, #281470681808640
    SHLL2  V23.2D, V19.4S, #32
    MOV B19, V6.B[0x0]
    SHRN V17.2S, V19.2D, #6
    AESD  V0.16B, V4.16B
    SHL  V12.2S, V15.2S, #0x1d
    SRI  V1.8B, V20.8B, #4
    TBL  V1.16B, { V0.16B }, V12.16B
    ADDHN  V25.2S, V1.2D, V1.2D
    SRI  V2.8B, V15.8B, #2
    MOV  W3, V22.S[0x3]
    TBL  V22.8B, { V0.16B, V1.16B, V2.16B }, V11.8B
    SUBHN  V14.4H, V23.4S, V14.4S
    TBL  V4.16B, { V25.16B, V26.16B }, V2.16B
    TBL  V19.16B, { V21.16B, V22.16B, V23.16B }, V5.16B
    ADDHN2  V15.8H, V17.4S, V7.4S
    RADDHN  V22.4H, V15.4S, V12.4S
    MOV  X20, V22.D[0x0]
    MOV B18, V14.B[0xa]
    SHRN2 V5.4S, V29.2D, #12
    AND  V28.16B, V1.16B, V25.16B
    ADD  V1.4H, V28.4H, V16.4H
    MOVI  V0.4S, #0xed
    SHLL  V16.2D, V4.2S, #32
    MOV S11, V1.S[0x3]
    BIF  V24.16B, V19.16B, V19.16B
    MLS  V7.4H, V21.4H, V0.H[0x7]
    AESE  V25.16B, V11.16B
    DUP  V29.4S, V24.S[0x0]
    ORR  V1.8H, #0xb3
    RBIT  V19.8B, V17.8B
    MLS  V14.4S, V1.4S, V16.S[0x3]
    MOV  W17, V26.S[0x3]
    AESE  V28.16B, V7.16B
    MOV  X5, V16.D[0x0]
    DUP  V12.8B, V18.B[0xc]
    DUP V20.2D, X24
    CLZ  V4.8B, V29.8B
    BIC  V11.8H, #0xcd, LSL #8
    RSHRN V1.4H, V28.4S, #6
    BIC  V28.4H, #0x1f, LSL #8
    TBL  V16.16B, { V19.16B, V20.16B, V21.16B }, V28.16B
    ORR  V16.4H, #0x59, LSL #8
    TBL  V18.16B, { V11.16B, V12.16B }, V1.16B
    DUP S8, V16.S[0x2]
    XTN  V4.2S, V8.2D
    MOV V12.D[0x0], V5.D[0x1]
    INS V26.B[0xb], W3
    ORR  V20.8B, V12.8B, V0.8B
    SHRN2 V17.8H, V26.4S, #6
    SHLL  V26.4S, V4.4H, #16
    SLI  V29.16B, V11.16B, #0x1
    MOV V24.D[0x1], V21.D[0x0]
    TBX  V7.8B, { V16.16B, V17.16B, V18.16B }, V17.8B
    SHRN2 V17.4S, V26.2D, #31
    DUP S21, V20.S[0x1]
    ZIP2  V12.4S, V10.4S, V25.4S
    EXT  V4.8B, V14.8B, V7.8B, #0x3
    SHRN V10.4H, V21.4S, #14
    SHRN V1.4H, V24.4S, #10
    DUP V20.2D, X21
    MOV V8.D[0x0], X28
    MOVI  V14.2D, #18374686483966525440
    MVN  V25.8B, V14.8B
    AESE  V7.16B, V28.16B
    INS V28.D[0x1], X9
    TBX  V14.8B, { V25.16B }, V8.8B
    DUP  V19.2S, V28.S[0x3]
    MOVI  V0.4S, #0x14, LSL #8
    MLA  V28.8H, V20.8H, V12.H[0x7]
    RSHRN V1.8B, V0.8H, #5
    MVNI  V0.4S, #0xaa
    ADDV  S14, V0.4S
    SLI  V26.2S, V17.2S, #0x1
    EXT  V25.16B, V16.16B, V26.16B, #0xe
    EXT  V29.8B, V15.8B, V25.8B, #0x3
    ADDP  D6, V6.2D
    SHRN V12.4H, V7.4S, #9
    SHL  V8.16B, V23.16B, #0x1
    PMUL  V24.8B, V12.8B, V4.8B
    AESE  V23.16B, V24.16B
    EOR  V16.8B, V6.8B, V14.8B
    MLA  V26.8H, V6.8H, V1.H[0x0]
    SRI  V3.8B, V19.8B, #1
    XTN2  V15.4S, V10.2D
    SLI  V20.8H, V16.8H, #0x9
    INS V7.D[0x0], V8.D[0x1]
    MOV V27.H[0x2], W8
    DUP H16, V15.H[0x3]
    MOV V24.H[0x6], V7.H[0x3]
    TBL  V15.16B, { V10.16B, V11.16B, V12.16B }, V6.16B
    RSHRN V26.8B, V1.8H, #5
    CNT  V4.8B, V18.8B
    SLI V0.2D, V26.2D, #0x0
    INS V6.B[0x9], V25.B[0xa]
    ORR  V17.4H, #0x36, LSL #8
    INS V19.H[0x6], V29.H[0x4]
    INS V12.H[0x3], W8
    BIC  V1.4S, #0x43, LSL #24
    DUP  V11.2S, V3.S[0x2]
    NEG  V11.4H, V19.4H
    DUP B26, V12.B[0x0]
    SHRN V13.4H, V11.4S, #4
    ORN  V7.16B, V5.16B, V24.16B
    MOV H8, V24.H[0x6]
    MOV S25, V7.S[0x0]
    MOV B7, V23.B[0x4]
    TBX  V28.16B, { V9.16B, V10.16B }, V1.16B
    AESE  V24.16B, V28.16B
    INS V19.B[0x6], W12
    SHLL2  V17.2D, V13.4S, #32
    AESE  V31.16B, V17.16B
    PMULL  V28.8H, V11.8B, V13.8B
    SUB  V9.4S, V26.4S, V31.4S
    RSHRN V5.2S, V28.2D, #18
    INS V11.H[0x3], V7.H[0x2]
    BIF  V29.8B, V11.8B, V9.8B
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_1
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0xffff, LSL #0
    SUB  X22, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xfa, LSL #32
    MOVK  X4, #0xfa, LSL #48
    SUB  X22, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xffbf, LSL #16
    SUB  X22, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8001, LSL #16
    MOVK  X4, #0x1, LSL #32
    SUB  X22, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X4, FPSR
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D0
    MOVZ  X22, #0x505, LSL #0
    MOVK  X22, #0x505, LSL #16
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D1
    MOVZ  X22, #0xa0, LSL #0
    MOVK  X22, #0xa0, LSL #16
    MOVK  X22, #0xa0, LSL #32
    MOVK  X22, #0xa0, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D2
    MOVZ  X22, #0x4000, LSL #0
    MOVK  X22, #0x4000, LSL #16
    MOVK  X22, #0x6040, LSL #32
    MOVK  X22, #0x6040, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D6
    MOVZ  X22, #0xe0ff, LSL #0
    MOVK  X22, #0x7f, LSL #16
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D7
    MOVZ  X22, #0x63, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X22, #0x9c9d, LSL #0
    MOVK  X22, #0x9c9c, LSL #16
    MOVK  X22, #0x449d, LSL #32
    MOVK  X22, #0x9c9c, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D9
    MOVZ  X22, #0x9cec, LSL #0
    MOVK  X22, #0x9c9c, LSL #16
    MOVK  X22, #0x9c9d, LSL #32
    MOVK  X22, #0x9c9c, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D12
    MOVZ  X22, #0xb1e8, LSL #0
    MOVK  X22, #0x31b1, LSL #16
    MOVK  X22, #0x7db1, LSL #32
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D14
    MOVZ  X22, #0xfd54, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D16
    MOVZ  X22, #0x8000, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D20
    MOVZ  X22, #0x5600, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D21
    MOVZ  X22, #0xed, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D22
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8001, LSL #16
    MOVK  X22, #0x1, LSL #32
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X22, #0x6363, LSL #0
    MOVK  X22, #0x6363, LSL #16
    MOVK  X22, #0x6363, LSL #32
    MOVK  X22, #0x6363, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D23
    MOVZ  X22, #0x6b63, LSL #0
    MOVK  X22, #0x6363, LSL #16
    MOVK  X22, #0x6363, LSL #32
    MOVK  X22, #0x6363, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X22, #0x6363, LSL #0
    MOVK  X22, #0x63fb, LSL #16
    MOVK  X22, #0x6363, LSL #32
    MOVK  X22, #0x63fb, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D24
    MOVZ  X22, #0x6b65, LSL #0
    MOVK  X22, #0x6363, LSL #16
    MOVK  X22, #0x6365, LSL #32
    MOVK  X22, #0x6363, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D25
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D26
    MOVZ  X22, #0xe8, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X22, #0x1, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D27
    MOVZ  X22, #0xc7c7, LSL #0
    MOVK  X22, #0xc7c7, LSL #16
    MOVK  X22, #0xc7c7, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D29
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x80, LSL #16
    MOVK  X22, #0x80, LSL #32
    MOVK  X22, #0x400, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X22, #0x24ff, LSL #0
    MOVK  X22, #0x24ff, LSL #16
    MOVK  X22, #0x24ff, LSL #32
    MOVK  X22, #0x24ff, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D30
    MOVZ  X22, #0x24ff, LSL #0
    MOVK  X22, #0x24ff, LSL #16
    MOVK  X22, #0x24ff, LSL #32
    MOVK  X22, #0x24ff, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X22, #0x6363, LSL #0
    MOVK  X22, #0x6363, LSL #16
    MOVK  X22, #0xbb63, LSL #32
    MOVK  X22, #0x6363, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X4, D31
    MOVZ  X22, #0x63fc, LSL #0
    MOVK  X22, #0x6363, LSL #16
    MOVK  X22, #0x6363, LSL #32
    MOVK  X22, #0x6363, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X9
    FMOV  V2.D[1], X29
    FMOV  D3, X20
    FMOV  V3.D[1], X23
    FMOV  D4, X24
    FMOV  V4.D[1], X24
    FMOV  D5, X16
    FMOV  V5.D[1], X28
    FMOV  D6, X17
    FMOV  V6.D[1], X8
    FMOV  D7, X22
    FMOV  V7.D[1], X5
    FMOV  D8, X23
    FMOV  V8.D[1], X19
    FMOV  D9, X12
    FMOV  V9.D[1], X5
    FMOV  D10, X12
    FMOV  V10.D[1], X6
    FMOV  D11, X27
    FMOV  V11.D[1], X9
    FMOV  D12, X23
    FMOV  V12.D[1], X7
    FMOV  D13, X7
    FMOV  V13.D[1], X29
    FMOV  D14, X17
    FMOV  V14.D[1], X27
    FMOV  D15, X5
    FMOV  V15.D[1], X8
    FMOV  D16, X17
    FMOV  V16.D[1], X16
    FMOV  D17, X7
    FMOV  V17.D[1], X24
    FMOV  D18, X20
    FMOV  V18.D[1], X8
    FMOV  D19, X26
    FMOV  V19.D[1], X4
    FMOV  D20, X23
    FMOV  V20.D[1], X12
    FMOV  D21, X5
    FMOV  V21.D[1], X6
    FMOV  D22, X4
    FMOV  V22.D[1], X22
    FMOV  D23, X17
    FMOV  V23.D[1], X19
    FMOV  D24, X18
    FMOV  V24.D[1], X20
    FMOV  D25, X4
    FMOV  V25.D[1], X9
    FMOV  D26, X12
    FMOV  V26.D[1], X12
    FMOV  D27, X20
    FMOV  V27.D[1], X29
    FMOV  D28, X6
    FMOV  V28.D[1], X12
    FMOV  D29, X25
    FMOV  V29.D[1], X21
    FMOV  D30, X16
    FMOV  V30.D[1], X18
    FMOV  D31, X20
    FMOV  V31.D[1], X21
    MOVZ  X28, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_2:
    TBL  V21.8B, { V12.16B, V13.16B, V14.16B }, V31.8B
    ORR  V19.2S, #0x65
    DUP D1, V28.D[0x1]
    MOVI  V21.8B, #0x25
    TBX  V14.16B, { V0.16B, V1.16B }, V27.16B
    BIC  V5.4H, #0xb2, LSL #8
    SHRN V12.8B, V9.8H, #8
    UZP1  V18.2S, V23.2S, V19.2S
    BIF  V11.16B, V15.16B, V5.16B
    UZP1  V14.4S, V14.4S, V18.4S
    CLZ  V27.4S, V2.4S
    BIC  V1.8H, #0x4
    SHRN2 V16.4S, V5.2D, #23
    ABS  V21.8H, V1.8H
    MLS  V11.4H, V30.4H, V14.H[0x7]
    MOV V2.S[0x2], V25.S[0x0]
    CLZ  V31.8B, V2.8B
    DUP  V11.16B, V11.B[0xa]
    EXT  V2.16B, V16.16B, V31.16B, #0xb
    SLI  V28.4H, V11.4H, #0x7
    CLS  V21.4S, V2.4S
    SHRN V25.8B, V12.8H, #1
    TBL  V23.16B, { V24.16B, V25.16B, V26.16B, V27.16B }, V7.16B
    NOT  V11.16B, V21.16B
    ORR  V15.2S, #0xcc, LSL #8
    TBL  V31.8B, { V19.16B }, V21.8B
    INS V7.S[0x3], V31.S[0x3]
    AESMC  V16.16B, V30.16B
    INS V19.H[0x4], V28.H[0x0]
    EXT  V5.16B, V15.16B, V16.16B, #0x1
    RSHRN2 V26.4S, V5.2D, #21
    RSHRN V12.4H, V11.4S, #15
    SUBHN2  V14.16B, V14.8H, V0.8H
    SHLL  V30.8H, V23.8B, #8
    BIC  V0.8B, V12.8B, V19.8B
    MOV S21, V9.S[0x2]
    DUP V2.4S, W5
    MOV S16, V2.S[0x2]
    RSUBHN2  V4.4S, V9.2D, V21.2D
    SRI V9.2D, V12.2D, #43
    REV32  V2.4H, V17.4H
    MOVI  V19.4S, #0xb7, MSL #16
    INS V15.B[0x5], W19
    XTN2  V31.8H, V26.4S
    MOVI  V3.4H, #0x32, LSL #8
    RSHRN2 V26.4S, V19.2D, #7
    SHRN2 V12.16B, V15.8H, #2
    DUP V5.2D, V30.D[0x0]
    CNT  V11.8B, V4.8B
    MLS  V11.4H, V5.4H, V11.H[0x4]
    ORN  V30.16B, V0.16B, V16.16B
    SUBHN2  V19.16B, V31.8H, V3.8H
    MVNI  V3.4H, #0xc8
    INS V30.H[0x6], V12.H[0x3]
    DUP  V0.8B, V15.B[0x7]
    RSUBHN  V31.4H, V1.4S, V17.4S
    TBX  V1.16B, { V31.16B, V0.16B }, V3.16B
    PMUL  V12.8B, V1.8B, V19.8B
    EXT  V1.16B, V14.16B, V12.16B, #0xa
    REV32  V14.8H, V11.8H
    SRI  V16.8H, V1.8H, #14
    DUP V31.4S, W17
    DUP  V20.4H, V16.H[0x5]
    RBIT  V15.8B, V20.8B
    MOVI  V5.16B, #0x81
    SHRN2 V3.4S, V31.2D, #13
    PMULL2  V31.1Q, V3.2D, V30.2D
    SHRN V16.4H, V1.4S, #4
    MOV H12, V16.H[0x1]
    MOV V1.B[0x2], V0.B[0xb]
    TRN2  V14.4H, V29.4H, V31.4H
    RSUBHN2  V30.16B, V15.8H, V15.8H
    ADD  V0.2D, V15.2D, V19.2D
    SHL V16.2D, V12.2D, #0x24
    MOVI  V29.8H, #0x38, LSL #8
    ZIP1  V24.2D, V24.2D, V29.2D
    ORR  V29.4S, #0x14, LSL #8
    ADDV  B20, V0.16B
    INS V14.H[0x6], W17
    MOV S31, V1.S[0x2]
    MOV V15.D[0x0], X18
    ORR  V19.8B, V5.8B, V20.8B
    SRI V1.2D, V15.2D, #58
    RADDHN  V15.2S, V8.2D, V29.2D
    RSHRN2 V20.16B, V10.8H, #1
    PMULL  V24.8H, V31.8B, V14.8B
    CLS  V3.8H, V20.8H
    INS V5.B[0xf], W2
    MOV B15, V26.B[0x0]
    MUL  V0.8B, V15.8B, V22.8B
    ADDV  H29, V6.4H
    CLS  V26.2S, V0.2S
    ORR  V21.4H, #0xa0
    MOVI  V6.2D, #18374686479688400895
    DUP D16, V21.D[0x1]
    MOVI  V3.2S, #0x78, MSL #8
    RSHRN2 V12.16B, V19.8H, #2
    SRI  V11.16B, V16.16B, #5
    RSUBHN  V14.2S, V30.2D, V19.2D
    MOV D21, V9.D[0x0]
    SHRN V22.8B, V21.8H, #8
    ABS  V10.2S, V24.2S
    DUP  V8.8B, V11.B[0x8]
    SHRN2 V24.8H, V22.4S, #16
    MUL  V0.16B, V6.16B, V10.16B
    AESIMC  V16.16B, V5.16B
    ADDV  S20, V25.4S
    TBL  V5.16B, { V4.16B, V5.16B, V6.16B }, V24.16B
    DUP  V10.4H, V12.H[0x3]
    INS V15.S[0x0], W27
    TBL  V22.8B, { V4.16B, V5.16B, V6.16B, V7.16B }, V5.8B
    ORR  V19.8H, #0xc5, LSL #8
    MOVI  V23.4H, #0x2e
    RADDHN2  V7.8H, V15.4S, V28.4S
    INS V30.B[0x6], W28
    ADDHN2  V13.4S, V0.2D, V16.2D
    DUP D11, V7.D[0x1]
    SHRN V16.2S, V14.2D, #5
    SUBHN2  V31.8H, V23.4S, V16.4S
    RSHRN2 V24.8H, V13.4S, #3
    MLA  V5.4H, V31.4H, V14.H[0x4]
    XTN2  V23.16B, V26.8H
    CNT  V15.16B, V22.16B
    INS V3.S[0x0], V24.S[0x3]
    SHL  V25.16B, V15.16B, #0x4
    MOV S31, V9.S[0x0]
    PMULL2  V13.8H, V30.16B, V11.16B
    MOV  W20, V31.S[0x3]
    PMULL  V28.1Q, V19.1D, V19.1D
    MOVI  V14.8H, #0xfb
    INS V26.B[0x7], V8.B[0x4]
    SLI V9.2D, V5.2D, #0x2d
    MOV V30.B[0x0], W5
    MOV  V8.8B, V23.8B
    DUP S0, V12.S[0x0]
    DUP V30.4S, W5
    CNT  V5.8B, V28.8B
    SRI  V16.4H, V7.4H, #7
    MLS  V26.4H, V16.4H, V6.H[0x3]
    RSHRN V12.8B, V14.8H, #5
    SRI V11.2D, V0.2D, #59
    INS V15.S[0x1], V11.S[0x1]
    NEG  V29.2S, V18.2S
    AND  V27.16B, V3.16B, V26.16B
    AND  V19.16B, V30.16B, V13.16B
    MOV H11, V14.H[0x0]
    MOV V24.S[0x0], V8.S[0x1]
    MLS  V22.2S, V28.2S, V12.S[0x2]
    CLZ  V18.4S, V25.4S
    SLI  V26.8B, V24.8B, #0x5
    NOT  V23.8B, V11.8B
    ADDHN2  V25.16B, V9.8H, V23.8H
    DUP B28, V5.B[0xd]
    MOV  W9, V24.S[0x2]
    REV64  V3.16B, V12.16B
    RADDHN2  V25.8H, V15.4S, V10.4S
    ORR  V6.8H, #0x20
    BIF  V8.8B, V16.8B, V1.8B
    RBIT  V29.16B, V22.16B
    SUBHN2  V22.8H, V25.4S, V3.4S
    SRI V23.2D, V5.2D, #63
    TBX  V11.8B, { V26.16B, V27.16B, V28.16B }, V18.8B
    RADDHN2  V26.4S, V19.2D, V6.2D
    ADDHN2  V5.4S, V0.2D, V14.2D
    SHRN V19.8B, V23.8H, #7
    AESD  V16.16B, V29.16B
    DUP V0.2D, X8
    SRI  V25.4H, V27.4H, #3
    MUL  V13.8H, V26.8H, V22.8H
    ADDP  D22, V5.2D
    SHRN2 V24.16B, V27.8H, #5
    DUP B14, V22.B[0x8]
    RSUBHN2  V1.8H, V14.4S, V16.4S
    ADDHN2  V28.16B, V11.8H, V11.8H
    SHRN2 V8.4S, V1.2D, #23
    RBIT  V29.16B, V19.16B
    ORN  V11.8B, V28.8B, V0.8B
    SHL  V6.16B, V10.16B, #0x7
    SHL  V18.4H, V8.4H, #0xf
    SLI  V27.16B, V18.16B, #0x6
    SHL  V14.2S, V3.2S, #0x12
    SRI  V26.4S, V27.4S, #29
    SHL  V16.8B, V25.8B, #0x0
    ORR  V28.16B, V29.16B, V15.16B
    RSHRN2 V20.8H, V28.4S, #3
    MLS  V22.4S, V13.4S, V23.S[0x1]
    ADDHN  V4.2S, V26.2D, V20.2D
    TBX  V5.8B, { V29.16B, V30.16B, V31.16B }, V9.8B
    AESD  V9.16B, V23.16B
    ZIP2  V27.16B, V2.16B, V2.16B
    RSHRN2 V24.8H, V5.4S, #6
    TBL  V2.8B, { V29.16B, V30.16B, V31.16B, V0.16B }, V16.8B
    TBL  V30.8B, { V19.16B, V20.16B, V21.16B, V22.16B }, V24.8B
    ADDP  D13, V4.2D
    PMULL  V0.8H, V14.8B, V23.8B
    DUP V29.16B, W24
    MOV S25, V26.S[0x1]
    MVNI  V15.4H, #0x7d
    SHRN V6.8B, V27.8H, #4
    SLI  V31.8B, V21.8B, #0x2
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_2
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0x3e3, LSL #0
    MOVK  X29, #0x4, LSL #16
    SUB  X25, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X25, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X29, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1fe0, LSL #32
    MOVK  X25, #0x1fe0, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D0
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1fe0, LSL #32
    MOVK  X25, #0x1fe0, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X25, #0xf6ae, LSL #0
    MOVK  X25, #0xadae, LSL #16
    MOVK  X25, #0xad83, LSL #32
    MOVK  X25, #0x2a83, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D1
    MOVZ  X25, #0xe0ff, LSL #0
    MOVK  X25, #0xff00, LSL #16
    MOVK  X25, #0xe0e0, LSL #32
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D2
    MOVZ  X25, #0xff, LSL #0
    MOVK  X25, #0xff7f, LSL #16
    MOVK  X25, #0xff, LSL #32
    MOVK  X25, #0x7f7f, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D3
    MOVZ  X25, #0x808, LSL #0
    MOVK  X25, #0x808, LSL #16
    MOVK  X25, #0x808, LSL #32
    MOVK  X25, #0x808, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D4
    MOVZ  X25, #0x1f18, LSL #0
    MOVK  X25, #0x1f00, LSL #16
    MOVK  X25, #0x20, LSL #32
    MOVK  X25, #0xff20, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D5
    MOVZ  X25, #0x7f7f, LSL #0
    MOVK  X25, #0x202, LSL #16
    MOVK  X25, #0xff01, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X25, #0x7f, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D7
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X25, #0xc1fe, LSL #0
    MOVK  X25, #0x1c1, LSL #16
    MOVK  X25, #0x75b, LSL #32
    MOVK  X25, #0x75b, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D8
    MOVZ  X25, #0x132e, LSL #0
    MOVK  X25, #0xff, LSL #16
    MOVK  X25, #0x13f, LSL #32
    MOVK  X25, #0x1ff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X25, #0x3b52, LSL #0
    MOVK  X25, #0x5284, LSL #16
    MOVK  X25, #0x52c1, LSL #32
    MOVK  X25, #0x6255, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D9
    MOVZ  X25, #0x3930, LSL #0
    MOVK  X25, #0x5590, LSL #16
    MOVK  X25, #0x7d5c, LSL #32
    MOVK  X25, #0x4852, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D12
    MOVZ  X25, #0x808, LSL #0
    MOVK  X25, #0x808, LSL #16
    MOVK  X25, #0x808, LSL #32
    MOVK  X25, #0x808, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D13
    MOVZ  X25, #0x1f18, LSL #0
    MOVK  X25, #0x1f00, LSL #16
    MOVK  X25, #0x20, LSL #32
    MOVK  X25, #0xff20, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D14
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x2020, LSL #16
    MOVK  X25, #0x2020, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D15
    MOVZ  X25, #0xff82, LSL #0
    MOVK  X25, #0xff82, LSL #16
    MOVK  X25, #0xff82, LSL #32
    MOVK  X25, #0xff82, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D16
    MOVZ  X25, #0x602, LSL #0
    MOVK  X25, #0x1b00, LSL #16
    MOVK  X25, #0xf03, LSL #32
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D17
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D18
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    MOVK  X25, #0x8000, LSL #32
    MOVK  X25, #0x8000, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D19
    MOVZ  X25, #0xfffe, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X25, #0xfff0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D20
    MOVZ  X25, #0x3e9c, LSL #0
    MOVK  X25, #0x291d, LSL #16
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D21
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x55a0, LSL #16
    MOVK  X25, #0x7db5, LSL #32
    MOVK  X25, #0x4852, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X25, #0xfee0, LSL #0
    MOVK  X25, #0x7e0, LSL #16
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D22
    MOVZ  X25, #0x3fd, LSL #0
    MOVK  X25, #0x2fd, LSL #16
    MOVK  X25, #0x1fc, LSL #32
    MOVK  X25, #0x2fd, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D23
    MOVZ  X25, #0xff04, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X25, #0x9fe, LSL #0
    MOVK  X25, #0xfffc, LSL #16
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D24
    MOVZ  X25, #0x2e, LSL #0
    MOVK  X25, #0x2e, LSL #16
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D25
    MOVZ  X25, #0x1f18, LSL #0
    MOVK  X25, #0x1f00, LSL #16
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X25, #0x20, LSL #0
    MOVK  X25, #0xff20, LSL #16
    MOVK  X25, #0x20, LSL #32
    MOVK  X25, #0xff20, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D26
    MOVZ  X25, #0x1fd8, LSL #0
    MOVK  X25, #0x1fc0, LSL #16
    MOVK  X25, #0x1f18, LSL #32
    MOVK  X25, #0x1f00, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D28
    MOVZ  X25, #0xff7f, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D29
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D30
    MOVZ  X25, #0xfe00, LSL #0
    MOVK  X25, #0xfe00, LSL #16
    MOVK  X25, #0xfefe, LSL #32
    MOVK  X25, #0xfefe, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X29, D31
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5580, LSL #16
    MOVK  X25, #0xf4d4, LSL #32
    MOVK  X25, #0x2048, LSL #48
    SUB  X16, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X19
    FMOV  V1.D[1], X12
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X7
    FMOV  V3.D[1], X8
    FMOV  D4, X25
    FMOV  V4.D[1], X27
    FMOV  D5, X29
    FMOV  V5.D[1], X19
    FMOV  D6, X3
    FMOV  V6.D[1], X25
    FMOV  D7, X5
    FMOV  V7.D[1], X9
    FMOV  D8, X24
    FMOV  V8.D[1], X18
    FMOV  D9, X23
    FMOV  V9.D[1], X22
    FMOV  D10, X20
    FMOV  V10.D[1], X2
    FMOV  D11, X17
    FMOV  V11.D[1], X2
    FMOV  D12, X2
    FMOV  V12.D[1], X5
    FMOV  D13, X25
    FMOV  V13.D[1], X8
    FMOV  D14, X18
    FMOV  V14.D[1], X3
    FMOV  D15, X26
    FMOV  V15.D[1], X18
    FMOV  D16, X5
    FMOV  V16.D[1], X4
    FMOV  D17, X22
    FMOV  V17.D[1], X5
    FMOV  D18, X24
    FMOV  V18.D[1], X9
    FMOV  D19, X6
    FMOV  V19.D[1], X26
    FMOV  D20, X2
    FMOV  V20.D[1], X18
    FMOV  D21, X12
    FMOV  V21.D[1], X22
    FMOV  D22, X24
    FMOV  V22.D[1], X19
    FMOV  D23, X12
    FMOV  V23.D[1], X6
    FMOV  D24, X2
    FMOV  V24.D[1], X19
    FMOV  D25, X7
    FMOV  V25.D[1], X25
    FMOV  D26, X8
    FMOV  V26.D[1], X25
    FMOV  D27, X2
    FMOV  V27.D[1], X26
    FMOV  D28, X21
    FMOV  V28.D[1], X28
    FMOV  D29, X28
    FMOV  V29.D[1], X28
    FMOV  D30, X6
    FMOV  V30.D[1], X26
    FMOV  D31, X21
    FMOV  V31.D[1], X24
    MOVZ  X16, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_3:
    SHRN V21.8B, V30.8H, #7
    BIF  V7.16B, V25.16B, V17.16B
    TBL  V24.8B, { V26.16B, V27.16B, V28.16B }, V20.8B
    RSHRN2 V15.8H, V11.4S, #1
    TBX  V13.8B, { V6.16B, V7.16B }, V29.8B
    MUL  V7.8H, V31.8H, V15.H[0x5]
    MUL  V15.4H, V24.4H, V11.4H
    MOV V8.D[0x1], V4.D[0x1]
    TBL  V31.16B, { V7.16B, V8.16B }, V14.16B
    XTN  V28.8B, V21.8H
    SUBHN  V30.2S, V15.2D, V28.2D
    PMUL  V19.16B, V31.16B, V13.16B
    SHRN V0.2S, V6.2D, #23
    MOV  X9, V30.D[0x1]
    EXT  V19.8B, V0.8B, V0.8B, #0x0
    SHRN2 V27.16B, V6.8H, #1
    INS V24.H[0x5], W19
    SRI  V6.4S, V29.4S, #29
    EXT  V15.8B, V5.8B, V17.8B, #0x0
    ORR  V13.4H, #0x3, LSL #8
    SLI V31.2D, V22.2D, #0x2e
    MOVI  V14.2S, #0xf2, MSL #8
    NEG  V19.2D, V4.2D
    SUBHN  V8.2S, V13.2D, V8.2D
    EXT  V0.16B, V14.16B, V27.16B, #0xb
    CNT  V21.8B, V8.8B
    DUP S24, V16.S[0x0]
    BIC  V17.4S, #0x25, LSL #24
    MOV V22.S[0x0], W12
    MOV  W4, V12.S[0x1]
    SLI V7.2D, V31.2D, #0xd
    MLS  V13.4S, V7.4S, V4.S[0x2]
    MOV V5.H[0x2], V24.H[0x6]
    REV16  V31.16B, V21.16B
    MOVI  V10.4H, #0x1f, LSL #8
    CLS  V24.8B, V31.8B
    DUP V11.8H, W20
    SUB  V4.4S, V27.4S, V13.4S
    BIC  V17.2S, #0x65, LSL #8
    DUP B16, V5.B[0x9]
    DUP V7.4S, W21
    BIC  V30.4H, #0x45, LSL #8
    MOVI  V27.2S, #0x68
    BSL  V5.8B, V7.8B, V30.8B
    MOV V29.S[0x3], V5.S[0x1]
    MVNI  V7.2S, #0x3a, MSL #8
    RSHRN V31.2S, V11.2D, #22
    BIT  V11.8B, V16.8B, V31.8B
    SRI V16.2D, V8.2D, #59
    ADDP  V30.16B, V16.16B, V19.16B
    REV16  V21.16B, V23.16B
    INS V29.D[0x1], V7.D[0x0]
    RSHRN2 V7.4S, V17.2D, #28
    EXT  V29.8B, V30.8B, V30.8B, #0x0
    TBX  V13.8B, { V5.16B }, V22.8B
    ZIP1  V26.4S, V11.4S, V2.4S
    TBL  V22.16B, { V7.16B, V8.16B, V9.16B }, V7.16B
    DUP D8, V26.D[0x1]
    ZIP2  V23.8B, V15.8B, V29.8B
    INS V31.S[0x2], W7
    XTN2  V9.8H, V21.4S
    MVNI  V10.4H, #0x89
    TRN2  V29.16B, V9.16B, V13.16B
    INS V5.H[0x4], W8
    ADDP  V21.2D, V18.2D, V5.2D
    CLZ  V9.8B, V26.8B
    CLS  V26.8H, V23.8H
    ADDHN2  V28.8H, V28.4S, V4.4S
    NEG  V28.2D, V26.2D
    SLI  V7.8H, V9.8H, #0x6
    DUP H23, V7.H[0x3]
    MOVI  V7.2S, #0xff, LSL #24
    EOR  V4.8B, V22.8B, V8.8B
    TRN1  V5.4H, V25.4H, V4.4H
    BIT  V13.8B, V23.8B, V24.8B
    MVNI  V3.2S, #0xf5, LSL #24
    MUL  V24.2S, V7.2S, V17.S[0x1]
    MOV V18.H[0x0], W9
    TBL  V0.8B, { V4.16B, V5.16B, V6.16B }, V3.8B
    RSHRN2 V5.4S, V15.2D, #29
    CLZ  V6.4S, V28.4S
    TBL  V15.8B, { V2.16B, V3.16B, V4.16B }, V31.8B
    RSHRN2 V23.4S, V18.2D, #19
    RSHRN2 V17.8H, V29.4S, #9
    MOV  X2, V21.D[0x0]
    MOVI  V27.2D, #18374687574904995840
    ADDV  H26, V15.8H
    SRI  V31.8B, V0.8B, #1
    MOV V24.H[0x4], W29
    MVNI  V15.4S, #0x28, LSL #8
    MOV V4.B[0x0], V13.B[0xf]
    ORR  V25.2S, #0x0, LSL #24
    MOV B18, V29.B[0xd]
    INS V21.H[0x3], V31.H[0x0]
    TRN1  V2.16B, V21.16B, V5.16B
    INS V0.D[0x1], X20
    SHL  V16.4S, V26.4S, #0xf
    INS V5.B[0x1], V22.B[0xb]
    BIF  V21.8B, V31.8B, V5.8B
    MOV V5.S[0x3], W9
    DUP S18, V25.S[0x1]
    MOVI  V19.2S, #0xfb, MSL #16
    TBL  V4.8B, { V16.16B, V17.16B, V18.16B }, V19.8B
    SRI  V29.4S, V0.4S, #11
    MVNI  V9.4S, #0x80, MSL #16
    TBL  V8.16B, { V12.16B, V13.16B, V14.16B, V15.16B }, V2.16B
    INS V12.B[0xe], V11.B[0x4]
    CLS  V31.8B, V0.8B
    SHL V16.2D, V5.2D, #0x2
    RADDHN2  V26.8H, V31.4S, V9.4S
    DUP  V18.16B, V7.B[0x3]
    MLA  V25.2S, V12.2S, V29.S[0x0]
    SHLL2  V29.4S, V16.8H, #16
    MOV V15.S[0x1], W18
    TBL  V13.8B, { V26.16B }, V17.8B
    MOV D11, V9.D[0x0]
    PMULL  V31.8H, V13.8B, V11.8B
    ORR  V22.4H, #0x2f, LSL #8
    MOV H5, V6.H[0x7]
    SLI V12.2D, V18.2D, #0x38
    ORR  V14.4S, #0x52
    DUP D16, V5.D[0x1]
    CLS  V13.4H, V14.4H
    SRI  V17.4S, V16.4S, #28
    ADD  V14.8H, V30.8H, V17.8H
    MUL  V16.8B, V6.8B, V21.8B
    BIC  V9.8B, V12.8B, V14.8B
    CLS  V17.4S, V25.4S
    MOV V7.D[0x1], X7
    ORR  V26.4H, #0x43, LSL #8
    SUB  V3.2D, V10.2D, V26.2D
    AESMC  V10.16B, V22.16B
    MOVI  V13.2S, #0xe6, MSL #16
    SLI  V6.4S, V9.4S, #0x17
    XTN2  V13.16B, V14.8H
    TBL  V25.8B, { V3.16B }, V6.8B
    MOV S26, V13.S[0x3]
    SRI V30.2D, V10.2D, #37
    REV64  V27.8H, V17.8H
    MOV  W27, V26.S[0x2]
    SUBHN2  V6.16B, V7.8H, V5.8H
    RSUBHN  V2.2S, V5.2D, V27.2D
    RSHRN V27.8B, V29.8H, #5
    RADDHN2  V13.16B, V2.8H, V16.8H
    SHRN V17.8B, V27.8H, #8
    TBL  V1.16B, { V6.16B, V7.16B }, V21.16B
    MOV V14.S[0x0], V30.S[0x3]
    MVNI  V6.2S, #0x76, LSL #16
    MUL  V21.4H, V13.4H, V6.H[0x5]
    MOV  X9, V14.D[0x0]
    MOV S0, V27.S[0x3]
    MOV B9, V16.B[0xe]
    MUL  V16.2S, V1.2S, V8.S[0x0]
    RSHRN V30.4H, V13.4S, #15
    MOV V14.D[0x0], X22
    MLA  V28.4H, V3.4H, V7.H[0x3]
    TBL  V10.8B, { V17.16B, V18.16B }, V9.8B
    ADDV  S29, V16.4S
    SRI  V27.4S, V0.4S, #3
    DUP H22, V14.H[0x2]
    SHRN V16.8B, V10.8H, #4
    EXT  V28.16B, V22.16B, V8.16B, #0x5
    MOVI  V0.16B, #0x14
    MOV  X22, V25.D[0x1]
    TBL  V12.16B, { V16.16B, V17.16B, V18.16B }, V0.16B
    MLS  V1.2S, V28.2S, V30.S[0x0]
    TBX  V15.8B, { V24.16B, V25.16B, V26.16B }, V25.8B
    TBX  V18.8B, { V3.16B, V4.16B, V5.16B, V6.16B }, V15.8B
    CLS  V26.4H, V8.4H
    TBL  V14.16B, { V18.16B, V19.16B, V20.16B, V21.16B }, V18.16B
    INS V18.B[0xb], W16
    TRN1  V24.4S, V13.4S, V14.4S
    TRN1  V19.2S, V13.2S, V9.2S
    ORN  V13.8B, V27.8B, V12.8B
    CNT  V15.8B, V27.8B
    TBL  V15.8B, { V15.16B }, V26.8B
    MOVI  V31.8B, #0x33
    RSHRN V10.2S, V16.2D, #13
    BIT  V24.8B, V13.8B, V7.8B
    MOVI  V0.4S, #0xbb, LSL #16
    MOV B6, V12.B[0x7]
    MVN  V21.8B, V29.8B
    MLA  V5.4H, V31.4H, V6.H[0x5]
    RSHRN2 V8.16B, V15.8H, #6
    MOV H7, V19.H[0x1]
    MOVI  V16.16B, #0x2f
    ADD  V26.16B, V10.16B, V24.16B
    DUP V24.2D, X9
    MUL  V20.8H, V26.8H, V8.8H
    RADDHN  V12.8B, V18.8H, V5.8H
    EOR  V31.16B, V31.16B, V12.16B
    ADDHN  V9.2S, V23.2D, V16.2D
    RSHRN V25.4H, V21.4S, #5
    INS V23.H[0x3], W28
    MUL  V27.2S, V7.2S, V24.S[0x2]
    MLS  V7.8H, V23.8H, V9.H[0x2]
    SHL V8.2D, V7.2D, #0xb
    MLA  V19.4S, V31.4S, V20.S[0x0]
    DUP H18, V25.H[0x1]
    ORR  V15.8H, #0x32
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_3
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x200, LSL #0
    SUB  X24, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X24, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X6, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xbb, LSL #16
    MOVK  X24, #0xbb, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D0
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xbb, LSL #16
    MOVK  X24, #0xbb, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D2
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xfffe, LSL #16
    MOVK  X24, #0xffe1, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D3
    MOVZ  X24, #0xbc76, LSL #0
    MOVK  X24, #0xbc76, LSL #16
    MOVK  X24, #0xbc76, LSL #32
    MOVK  X24, #0xbc76, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D7
    MOVZ  X24, #0x6455, LSL #0
    MOVK  X24, #0xe37a, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D8
    MOVZ  X24, #0xa800, LSL #0
    MOVK  X24, #0x322, LSL #16
    MOVK  X24, #0xd000, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D9
    MOVZ  X24, #0x2f2f, LSL #0
    MOVK  X24, #0x2f2f, LSL #16
    MOVK  X24, #0x2f2f, LSL #32
    MOVK  X24, #0x2f2f, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D11
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff7f, LSL #16
    MOVK  X24, #0xff7f, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D12
    MOVZ  X24, #0x7700, LSL #0
    MOVK  X24, #0x100, LSL #32
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D13
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X24, #0x32, LSL #0
    MOVK  X24, #0x32, LSL #16
    MOVK  X24, #0x32, LSL #32
    MOVK  X24, #0x32, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D15
    MOVZ  X24, #0x32, LSL #0
    MOVK  X24, #0x32, LSL #16
    MOVK  X24, #0x32, LSL #32
    MOVK  X24, #0x32, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X24, #0x2f2f, LSL #0
    MOVK  X24, #0x2f2f, LSL #16
    MOVK  X24, #0x2f2f, LSL #32
    MOVK  X24, #0x2f2f, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D16
    MOVZ  X24, #0x2f2f, LSL #0
    MOVK  X24, #0x2f2f, LSL #16
    MOVK  X24, #0x2f2f, LSL #32
    MOVK  X24, #0x2f2f, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D19
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xe6, LSL #16
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D21
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D23
    MOVZ  X24, #0x3f, LSL #0
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D26
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffe6, LSL #16
    MOVK  X24, #0xff00, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D30
    MOVZ  X24, #0x1ce, LSL #0
    MOVK  X24, #0x1ce, LSL #16
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X6, D31
    MOVZ  X24, #0x4433, LSL #0
    MOVK  X24, #0x3333, LSL #16
    MOVK  X24, #0x3233, LSL #32
    MOVK  X24, #0x3333, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X22
    FMOV  V0.D[1], X26
    FMOV  D1, X9
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X9
    FMOV  D3, X27
    FMOV  V3.D[1], X23
    FMOV  D4, X16
    FMOV  V4.D[1], X7
    FMOV  D5, X29
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X29
    FMOV  D7, X26
    FMOV  V7.D[1], X2
    FMOV  D8, X8
    FMOV  V8.D[1], X5
    FMOV  D9, X19
    FMOV  V9.D[1], X4
    FMOV  D10, X16
    FMOV  V10.D[1], X6
    FMOV  D11, X7
    FMOV  V11.D[1], X26
    FMOV  D12, X18
    FMOV  V12.D[1], X23
    FMOV  D13, X6
    FMOV  V13.D[1], X24
    FMOV  D14, X6
    FMOV  V14.D[1], X19
    FMOV  D15, X17
    FMOV  V15.D[1], X28
    FMOV  D16, X24
    FMOV  V16.D[1], X9
    FMOV  D17, X29
    FMOV  V17.D[1], X5
    FMOV  D18, X23
    FMOV  V18.D[1], X22
    FMOV  D19, X3
    FMOV  V19.D[1], X19
    FMOV  D20, X12
    FMOV  V20.D[1], X7
    FMOV  D21, X20
    FMOV  V21.D[1], X3
    FMOV  D22, X26
    FMOV  V22.D[1], X12
    FMOV  D23, X26
    FMOV  V23.D[1], X18
    FMOV  D24, X5
    FMOV  V24.D[1], X24
    FMOV  D25, X8
    FMOV  V25.D[1], X16
    FMOV  D26, X6
    FMOV  V26.D[1], X23
    FMOV  D27, X2
    FMOV  V27.D[1], X25
    FMOV  D28, X3
    FMOV  V28.D[1], X3
    FMOV  D29, X20
    FMOV  V29.D[1], X26
    FMOV  D30, X24
    FMOV  V30.D[1], X19
    FMOV  D31, X6
    FMOV  V31.D[1], X9
    MOVZ  X12, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_4:
    MLS  V21.4S, V5.4S, V21.S[0x0]
    EXT  V11.16B, V25.16B, V29.16B, #0x5
    MLS  V22.8H, V28.8H, V11.H[0x1]
    TBX  V26.16B, { V27.16B }, V13.16B
    TBL  V5.8B, { V27.16B }, V30.8B
    ADDV  B2, V22.8B
    TBL  V8.8B, { V16.16B, V17.16B, V18.16B, V19.16B }, V24.8B
    MOV  V24.8B, V23.8B
    RSHRN2 V4.4S, V21.2D, #18
    CLZ  V4.8B, V24.8B
    BIT  V27.8B, V27.8B, V8.8B
    TBL  V16.8B, { V2.16B }, V1.8B
    ZIP2  V22.8H, V27.8H, V3.8H
    MVN  V24.16B, V17.16B
    MOV H3, V24.H[0x3]
    DUP V8.4S, W5
    BIC  V29.2S, #0x44, LSL #16
    ADDV  S21, V24.4S
    XTN2  V19.4S, V22.2D
    MOV S22, V21.S[0x0]
    MOV V27.H[0x0], W19
    ORN  V28.8B, V5.8B, V9.8B
    ADDV  H9, V31.8H
    EXT  V30.8B, V29.8B, V8.8B, #0x4
    ORR  V8.4H, #0xf5
    UZP1  V5.8B, V27.8B, V9.8B
    CNT  V23.8B, V22.8B
    DUP D13, V28.D[0x0]
    SRI V24.2D, V8.2D, #62
    CLZ  V17.2S, V26.2S
    ZIP1  V25.8B, V13.8B, V4.8B
    MOV  X9, V4.D[0x1]
    INS V31.D[0x0], X8
    CNT  V8.16B, V5.16B
    EXT  V4.16B, V16.16B, V24.16B, #0xf
    SHRN2 V29.4S, V3.2D, #4
    DUP H13, V30.H[0x4]
    DUP  V1.16B, V4.B[0x0]
    SHRN V4.4H, V31.4S, #15
    MVNI  V27.4S, #0x18, MSL #16
    RSHRN V26.4H, V19.4S, #5
    BIC  V3.8H, #0x92, LSL #8
    TBL  V5.8B, { V25.16B, V26.16B, V27.16B }, V4.8B
    MOVI  V4.16B, #0x32
    RSUBHN2  V15.16B, V8.8H, V26.8H
    MOVI  V24.4S, #0x9
    SHRN V31.8B, V8.8H, #7
    SUB  V8.8H, V13.8H, V15.8H
    TBX  V26.8B, { V1.16B, V2.16B, V3.16B, V4.16B }, V17.8B
    MOV V27.B[0x4], W19
    SRI V22.2D, V27.2D, #34
    XTN2  V21.8H, V10.4S
    UZP2  V1.4S, V29.4S, V6.4S
    XTN2  V26.8H, V12.4S
    DUP  V22.4S, V1.S[0x2]
    INS V24.H[0x2], V31.H[0x5]
    MOV V11.B[0x0], W6
    MOV  W26, V1.S[0x0]
    BSL  V15.16B, V1.16B, V21.16B
    SHL V19.2D, V11.2D, #0x1c
    ADDP  D11, V11.2D
    ADDV  S6, V22.4S
    ORR  V8.2S, #0x2e, LSL #8
    ADDP  V27.2D, V26.2D, V26.2D
    MOV H1, V25.H[0x7]
    CNT  V30.8B, V7.8B
    INS V10.H[0x5], V8.H[0x1]
    CNT  V15.8B, V10.8B
    REV32  V10.8H, V8.8H
    SLI V31.2D, V15.2D, #0x35
    DUP  V26.8B, V31.B[0x3]
    DUP  V21.4S, V1.S[0x1]
    MVN  V22.8B, V26.8B
    BIC  V26.4S, #0xcc, LSL #24
    MOV V25.H[0x6], W8
    AND  V7.8B, V6.8B, V21.8B
    MOV  X19, V11.D[0x0]
    SHRN2 V15.8H, V19.4S, #4
    CNT  V17.16B, V15.16B
    RSUBHN  V22.4H, V14.4S, V7.4S
    MLS  V29.4S, V25.4S, V22.S[0x0]
    MOV V8.H[0x4], V24.H[0x0]
    SHRN V14.2S, V26.2D, #3
    INS V5.D[0x0], X29
    UZP2  V23.2D, V24.2D, V20.2D
    DUP V24.2D, V17.D[0x1]
    TBL  V1.8B, { V16.16B }, V5.8B
    XTN2  V11.16B, V13.8H
    ADDP  D25, V10.2D
    MOV  V13.16B, V10.16B
    MOVI  V9.16B, #0xc4
    ZIP1  V5.16B, V0.16B, V8.16B
    DUP V0.16B, W19
    RSHRN V7.2S, V29.2D, #24
    DUP H22, V11.H[0x1]
    UZP1  V29.2S, V14.2S, V1.2S
    RBIT  V8.8B, V22.8B
    INS V22.H[0x7], W19
    INS V17.H[0x3], V5.H[0x0]
    RSHRN V14.2S, V22.2D, #13
    TBX  V20.16B, { V13.16B }, V25.16B
    AESIMC  V11.16B, V29.16B
    MUL  V6.4H, V7.4H, V8.4H
    RBIT  V29.8B, V20.8B
    MOVI  V11.4S, #0xe0
    SHL  V13.4S, V14.4S, #0x11
    RSHRN V23.4H, V11.4S, #14
    ORR  V5.4H, #0x7c
    SHRN2 V29.8H, V17.4S, #1
    XTN2  V10.8H, V0.4S
    BIC  V11.2S, #0x0
    SLI  V2.2S, V6.2S, #0x0
    ORR  V10.16B, V13.16B, V13.16B
    REV32  V19.8H, V5.8H
    ADDV  B14, V23.16B
    UZP2  V22.8H, V11.8H, V19.8H
    MLS  V6.4H, V14.4H, V29.4H
    SUBHN  V30.2S, V22.2D, V15.2D
    INS V13.D[0x0], X23
    UZP1  V1.8H, V10.8H, V27.8H
    RSHRN2 V5.8H, V1.4S, #15
    AESE  V29.16B, V3.16B
    ADDV  S17, V0.4S
    MLS  V6.8H, V17.8H, V13.H[0x0]
    DUP  V11.8H, V2.H[0x2]
    ORN  V24.8B, V11.8B, V6.8B
    RBIT  V1.8B, V1.8B
    TBX  V25.16B, { V15.16B, V16.16B, V17.16B }, V27.16B
    MVNI  V23.4S, #0xd8, MSL #16
    INS V6.S[0x1], V16.S[0x2]
    MLS  V19.8H, V29.8H, V1.H[0x6]
    MLA  V2.4H, V18.4H, V15.H[0x3]
    SUBHN2  V0.16B, V10.8H, V23.8H
    CLS  V10.2S, V14.2S
    RSHRN V23.4H, V19.4S, #1
    SHL  V11.2S, V27.2S, #0xa
    SRI  V19.2S, V6.2S, #21
    CNT  V15.16B, V20.16B
    MOV V6.H[0x2], W16
    DUP H20, V5.H[0x7]
    ADDV  H31, V22.4H
    MVNI  V7.2S, #0xca, MSL #8
    SLI  V3.8B, V19.8B, #0x2
    MOV V27.H[0x0], W12
    INS V16.B[0xd], W12
    SLI  V25.8B, V27.8B, #0x4
    BIC  V18.4H, #0x16
    SHRN2 V13.8H, V26.4S, #14
    DUP  V3.4H, V19.H[0x7]
    RSHRN2 V14.8H, V5.4S, #16
    MUL  V21.4S, V13.4S, V14.4S
    UZP2  V22.2D, V18.2D, V6.2D
    BIC  V15.8B, V24.8B, V25.8B
    BSL  V31.16B, V0.16B, V22.16B
    RSHRN2 V2.4S, V15.2D, #29
    TBL  V29.16B, { V3.16B }, V11.16B
    NOT  V24.8B, V20.8B
    MLA  V0.4H, V21.4H, V7.H[0x2]
    DUP  V1.8B, V29.B[0xe]
    MLA  V11.8B, V16.8B, V16.8B
    REV16  V6.16B, V15.16B
    ADDV  H22, V11.8H
    MOV B11, V24.B[0xf]
    SHL V27.2D, V7.2D, #0x28
    MOVI  V25.8B, #0x29
    MUL  V13.4S, V0.4S, V6.S[0x0]
    SLI  V0.8B, V2.8B, #0x3
    ORR  V26.4S, #0xe4, LSL #24
    ADDHN2  V19.16B, V27.8H, V28.8H
    MVN  V3.16B, V22.16B
    MOVI  V24.16B, #0xe1
    MLS  V27.4H, V0.4H, V14.H[0x6]
    ADDV  B12, V14.16B
    TBL  V14.8B, { V15.16B, V16.16B }, V21.8B
    ORR  V5.4S, #0xa6
    MOV V0.D[0x1], X6
    MOVI  V25.4H, #0x91, LSL #8
    ORN  V16.8B, V0.8B, V13.8B
    MOVI  V15.8B, #0x3d
    MLA  V16.2S, V27.2S, V6.S[0x1]
    ZIP2  V30.8B, V25.8B, V16.8B
    DUP  V13.8H, V19.H[0x0]
    RSUBHN2  V17.16B, V26.8H, V31.8H
    ORN  V21.16B, V15.16B, V5.16B
    DUP V0.4H, W29
    SHL  V7.16B, V9.16B, #0x5
    MOV V9.B[0xd], V5.B[0x3]
    MOVI  V19.16B, #0x93
    SRI  V3.8B, V24.8B, #3
    SUBHN2  V6.8H, V11.4S, V2.4S
    INS V29.B[0x5], W6
    SHRN V5.2S, V14.2D, #31
    MLS  V26.4S, V17.4S, V20.S[0x0]
    INS V17.H[0x6], W29
    MOV V9.D[0x0], X7
    UZP2  V11.8B, V6.8B, V19.8B
    INS V28.D[0x0], X26
    MOV  X28, V12.D[0x0]
    INS V15.B[0x8], W6
    DUP  V20.8H, V3.H[0x3]
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_4
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5, LSL #0
    MOVK  X17, #0x91, LSL #16
    SUB  X4, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa500, LSL #0
    SUB  X4, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xac, LSL #0
    SUB  X4, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X4, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X17, FPSR
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X4, #0xd7d6, LSL #0
    MOVK  X4, #0xd7d7, LSL #16
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D2
    MOVZ  X4, #0xf473, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D3
    MOVZ  X4, #0x5cfc, LSL #0
    MOVK  X4, #0xfcfc, LSL #16
    MOVK  X4, #0xfcfc, LSL #32
    MOVK  X4, #0xfcfc, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X4, #0x3232, LSL #0
    MOVK  X4, #0x3232, LSL #16
    MOVK  X4, #0x3232, LSL #32
    MOVK  X4, #0x3232, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D4
    MOVZ  X4, #0x3232, LSL #0
    MOVK  X4, #0x3232, LSL #16
    MOVK  X4, #0x3232, LSL #32
    MOVK  X4, #0x3232, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D5
    MOVZ  X4, #0xc1c1, LSL #0
    MOVK  X4, #0xc1c1, LSL #16
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x2828, LSL #32
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D6
    MOVZ  X4, #0xe078, LSL #0
    MOVK  X4, #0xa8b8, LSL #16
    MOVK  X4, #0xfafa, LSL #32
    MOVK  X4, #0xfafa, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X4, #0x8080, LSL #0
    MOVK  X4, #0x8080, LSL #16
    MOVK  X4, #0x8080, LSL #32
    MOVK  X4, #0x8080, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D7
    MOVZ  X4, #0x8080, LSL #0
    MOVK  X4, #0x8080, LSL #16
    MOVK  X4, #0x8080, LSL #32
    MOVK  X4, #0x8080, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D8
    MOVZ  X4, #0x89, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X4, #0xc4c4, LSL #0
    MOVK  X4, #0xc4c4, LSL #16
    MOVK  X4, #0xeec4, LSL #32
    MOVK  X4, #0xc4c4, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D9
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D10
    MOVZ  X4, #0x1f, LSL #0
    MOVK  X4, #0x1f, LSL #32
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D11
    MOVZ  X4, #0xa8e0, LSL #0
    MOVK  X4, #0xfafa, LSL #16
    MOVK  X4, #0x9393, LSL #32
    MOVK  X4, #0x9393, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D12
    MOVZ  X4, #0xac, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X4, #0xea1a, LSL #0
    MOVK  X4, #0xea1a, LSL #16
    MOVK  X4, #0xea1a, LSL #32
    MOVK  X4, #0xea1a, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D13
    MOVZ  X4, #0xea1a, LSL #0
    MOVK  X4, #0xea1a, LSL #16
    MOVK  X4, #0xea1a, LSL #32
    MOVK  X4, #0xea1a, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D14
    MOVZ  X4, #0xe0e0, LSL #0
    MOVK  X4, #0xe0e0, LSL #16
    MOVK  X4, #0xe0e0, LSL #32
    MOVK  X4, #0xe0e0, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X4, #0xa5, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D15
    MOVZ  X4, #0x3d3d, LSL #0
    MOVK  X4, #0x3d3d, LSL #16
    MOVK  X4, #0x3d3d, LSL #32
    MOVK  X4, #0x3d3d, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D16
    MOVZ  X4, #0xffbf, LSL #0
    MOVK  X4, #0x17d5, LSL #16
    MOVK  X4, #0xffa7, LSL #32
    MOVK  X4, #0x1397, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X4, #0xe400, LSL #0
    MOVK  X4, #0xe400, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xe400, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D17
    MOVZ  X4, #0x9694, LSL #0
    MOVK  X4, #0x9696, LSL #16
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D18
    MOVZ  X4, #0xa5a1, LSL #0
    MOVK  X4, #0xa5a1, LSL #16
    MOVK  X4, #0xa5a1, LSL #32
    MOVK  X4, #0xa5a1, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X4, #0x9393, LSL #0
    MOVK  X4, #0x9393, LSL #16
    MOVK  X4, #0x9393, LSL #32
    MOVK  X4, #0x9393, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D19
    MOVZ  X4, #0x9393, LSL #0
    MOVK  X4, #0x9393, LSL #16
    MOVK  X4, #0x9393, LSL #32
    MOVK  X4, #0x9393, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X4, #0xfcfc, LSL #0
    MOVK  X4, #0xfcfc, LSL #16
    MOVK  X4, #0xfcfc, LSL #32
    MOVK  X4, #0xfcfc, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D20
    MOVZ  X4, #0xfcfc, LSL #0
    MOVK  X4, #0xfcfc, LSL #16
    MOVK  X4, #0xfcfc, LSL #32
    MOVK  X4, #0xfcfc, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X4, #0xff59, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xff59, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D21
    MOVZ  X4, #0x3d3d, LSL #0
    MOVK  X4, #0x3d3f, LSL #16
    MOVK  X4, #0x3d3d, LSL #32
    MOVK  X4, #0x3d3f, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D22
    MOVZ  X4, #0xb102, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D23
    MOVZ  X4, #0xf77f, LSL #0
    MOVK  X4, #0xe17f, LSL #16
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X4, #0xe1e1, LSL #0
    MOVK  X4, #0xe1e1, LSL #16
    MOVK  X4, #0xe1e1, LSL #32
    MOVK  X4, #0xe1e1, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D24
    MOVZ  X4, #0xe1e1, LSL #0
    MOVK  X4, #0xe1e1, LSL #16
    MOVK  X4, #0xe1e1, LSL #32
    MOVK  X4, #0xe1e1, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D25
    MOVZ  X4, #0x9100, LSL #0
    MOVK  X4, #0x9100, LSL #16
    MOVK  X4, #0x9100, LSL #32
    MOVK  X4, #0x9100, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xe400, LSL #16
    MOVK  X4, #0xe400, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D26
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xe400, LSL #16
    MOVK  X4, #0xe400, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D27
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xff35, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D28
    MOVZ  X4, #0xa500, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D29
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa500, LSL #32
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D30
    MOVZ  X4, #0xa700, LSL #0
    MOVK  X4, #0xff91, LSL #16
    MOVK  X4, #0x9700, LSL #32
    MOVK  X4, #0x1391, LSL #48
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X17, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x1768, LSL #0
    MOVK  X2, #0x9884, LSL #16
    MOVK  X2, #0xe2b9, LSL #32
    MOVK  X2, #0xb432, LSL #48
    MOVZ  X3, #0xcfc0, LSL #0
    MOVK  X3, #0xe019, LSL #16
    MOVK  X3, #0xc1fb, LSL #32
    MOVK  X3, #0xf5cf, LSL #48
    MOVZ  X4, #0x2972, LSL #0
    MOVK  X4, #0xde6a, LSL #16
    MOVK  X4, #0x3415, LSL #32
    MOVK  X4, #0x4b29, LSL #48
    MOVZ  X5, #0x274, LSL #0
    MOVK  X5, #0xf23d, LSL #16
    MOVK  X5, #0xdfce, LSL #32
    MOVK  X5, #0x469b, LSL #48
    MOVZ  X6, #0x221b, LSL #0
    MOVK  X6, #0x721c, LSL #16
    MOVK  X6, #0x5d03, LSL #32
    MOVK  X6, #0x2052, LSL #48
    MOVZ  X7, #0x29b, LSL #0
    MOVK  X7, #0xcd9a, LSL #16
    MOVK  X7, #0x8cd6, LSL #32
    MOVK  X7, #0x9298, LSL #48
    MOVZ  X8, #0xdb54, LSL #0
    MOVK  X8, #0x14c7, LSL #16
    MOVK  X8, #0x1864, LSL #32
    MOVK  X8, #0xfbe4, LSL #48
    MOVZ  X9, #0x10c6, LSL #0
    MOVK  X9, #0x8870, LSL #16
    MOVK  X9, #0x597c, LSL #32
    MOVK  X9, #0x2128, LSL #48
    MOVZ  X12, #0x185e, LSL #0
    MOVK  X12, #0xb426, LSL #16
    MOVK  X12, #0xe1fe, LSL #32
    MOVK  X12, #0xc19, LSL #48
    MOVZ  X16, #0x9967, LSL #0
    MOVK  X16, #0xdee9, LSL #16
    MOVK  X16, #0x67fe, LSL #32
    MOVK  X16, #0xf9cd, LSL #48
    MOVZ  X17, #0x272d, LSL #0
    MOVK  X17, #0xb971, LSL #16
    MOVK  X17, #0x1953, LSL #32
    MOVK  X17, #0xb76c, LSL #48
    MOVZ  X18, #0xb4f1, LSL #0
    MOVK  X18, #0x4607, LSL #16
    MOVK  X18, #0x7799, LSL #32
    MOVK  X18, #0x1595, LSL #48
    MOVZ  X19, #0xb2b9, LSL #0
    MOVK  X19, #0xab1a, LSL #16
    MOVK  X19, #0xb232, LSL #32
    MOVK  X19, #0x8b0b, LSL #48
    MOVZ  X20, #0x85b0, LSL #0
    MOVK  X20, #0x65c1, LSL #16
    MOVK  X20, #0x858, LSL #32
    MOVK  X20, #0xa53b, LSL #48
    MOVZ  X21, #0x7c34, LSL #0
    MOVK  X21, #0xf8ec, LSL #16
    MOVK  X21, #0xa42e, LSL #32
    MOVK  X21, #0xd854, LSL #48
    MOVZ  X22, #0x771, LSL #0
    MOVK  X22, #0xb330, LSL #16
    MOVK  X22, #0x28a6, LSL #32
    MOVK  X22, #0x6832, LSL #48
    MOVZ  X23, #0x4ccf, LSL #0
    MOVK  X23, #0xa425, LSL #16
    MOVK  X23, #0x965e, LSL #32
    MOVK  X23, #0xc17, LSL #48
    MOVZ  X24, #0xb60c, LSL #0
    MOVK  X24, #0xc998, LSL #16
    MOVK  X24, #0xd2c3, LSL #32
    MOVK  X24, #0xb84c, LSL #48
    MOVZ  X25, #0xf92c, LSL #0
    MOVK  X25, #0x4eeb, LSL #16
    MOVK  X25, #0x41ef, LSL #32
    MOVK  X25, #0x4f75, LSL #48
    MOVZ  X26, #0xb6d2, LSL #0
    MOVK  X26, #0xbd1, LSL #16
    MOVK  X26, #0xd094, LSL #32
    MOVK  X26, #0xc65a, LSL #48
    MOVZ  X27, #0xf593, LSL #0
    MOVK  X27, #0x3802, LSL #16
    MOVK  X27, #0x1593, LSL #32
    MOVK  X27, #0x4389, LSL #48
    MOVZ  X28, #0xed09, LSL #0
    MOVK  X28, #0x2aa7, LSL #16
    MOVK  X28, #0x3f84, LSL #32
    MOVK  X28, #0x8deb, LSL #48
    MOVZ  X29, #0xc328, LSL #0
    MOVK  X29, #0x45d7, LSL #16
    MOVK  X29, #0x9546, LSL #32
    MOVK  X29, #0x333, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X18
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X9
    FMOV  V3.D[1], X29
    FMOV  D4, X24
    FMOV  V4.D[1], X5
    FMOV  D5, X21
    FMOV  V5.D[1], X29
    FMOV  D6, X8
    FMOV  V6.D[1], X18
    FMOV  D7, X23
    FMOV  V7.D[1], X16
    FMOV  D8, X17
    FMOV  V8.D[1], X4
    FMOV  D9, X16
    FMOV  V9.D[1], X7
    FMOV  D10, X29
    FMOV  V10.D[1], X18
    FMOV  D11, X22
    FMOV  V11.D[1], X23
    FMOV  D12, X17
    FMOV  V12.D[1], X8
    FMOV  D13, X16
    FMOV  V13.D[1], X17
    FMOV  D14, X22
    FMOV  V14.D[1], X7
    FMOV  D15, X21
    FMOV  V15.D[1], X6
    FMOV  D16, X12
    FMOV  V16.D[1], X3
    FMOV  D17, X6
    FMOV  V17.D[1], X6
    FMOV  D18, X19
    FMOV  V18.D[1], X22
    FMOV  D19, X26
    FMOV  V19.D[1], X5
    FMOV  D20, X27
    FMOV  V20.D[1], X29
    FMOV  D21, X20
    FMOV  V21.D[1], X4
    FMOV  D22, X22
    FMOV  V22.D[1], X5
    FMOV  D23, X20
    FMOV  V23.D[1], X6
    FMOV  D24, X27
    FMOV  V24.D[1], X19
    FMOV  D25, X4
    FMOV  V25.D[1], X22
    FMOV  D26, X27
    FMOV  V26.D[1], X28
    FMOV  D27, X2
    FMOV  V27.D[1], X17
    FMOV  D28, X12
    FMOV  V28.D[1], X22
    FMOV  D29, X24
    FMOV  V29.D[1], X25
    FMOV  D30, X9
    FMOV  V30.D[1], X19
    FMOV  D31, X19
    FMOV  V31.D[1], X7
    MOVZ  X18, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_5:
    AESE  V24.16B, V26.16B
    SHL  V19.2S, V28.2S, #0xa
    AESD  V30.16B, V25.16B
    MOVI  V3.2S, #0x5a
    RSHRN V4.4H, V27.4S, #14
    INS V29.H[0x3], V3.H[0x3]
    AESIMC  V8.16B, V19.16B
    SUB  V1.4S, V8.4S, V24.4S
    DUP D16, V20.D[0x1]
    MVNI  V0.4H, #0x73, LSL #8
    REV64  V23.8H, V22.8H
    MOV V8.H[0x4], V31.H[0x4]
    DUP V17.8H, W12
    SLI  V28.16B, V23.16B, #0x1
    BSL  V6.16B, V17.16B, V16.16B
    ORR  V22.4H, #0x29
    RSUBHN2  V31.8H, V1.4S, V28.4S
    MOV  X9, V8.D[0x0]
    MOV S11, V1.S[0x0]
    MOVI  V4.8H, #0x60, LSL #8
    MOV V10.H[0x5], W22
    MOV V11.D[0x1], X5
    MOV H18, V10.H[0x2]
    SUBHN  V5.8B, V6.8H, V31.8H
    REV32  V10.4H, V22.4H
    SHL  V3.2S, V4.2S, #0x1e
    SUB  V6.2S, V12.2S, V3.2S
    AND  V16.16B, V5.16B, V10.16B
    SHRN V23.4H, V30.4S, #10
    RSUBHN2  V17.4S, V11.2D, V11.2D
    MVN  V23.16B, V18.16B
    TRN2  V12.2S, V9.2S, V23.2S
    MOV S4, V6.S[0x1]
    SHLL  V19.2D, V5.2S, #32
    DUP D1, V19.D[0x0]
    ADDP  V28.2S, V1.2S, V1.2S
    INS V30.H[0x3], V8.H[0x5]
    MOV V9.D[0x1], X18
    MOV B23, V28.B[0x8]
    BSL  V3.16B, V2.16B, V15.16B
    SHL V22.2D, V16.2D, #0x35
    MVNI  V5.2S, #0xdb, LSL #24
    MLA  V10.4H, V30.4H, V9.H[0x2]
    ADD  V11.8B, V22.8B, V3.8B
    SHRN V8.8B, V17.8H, #7
    CLS  V6.4H, V5.4H
    DUP B21, V11.B[0xb]
    RSHRN2 V5.16B, V23.8H, #7
    SHLL2  V23.2D, V21.4S, #32
    INS V8.S[0x3], W2
    AESD  V20.16B, V5.16B
    TBL  V9.8B, { V30.16B, V31.16B }, V23.8B
    MOV D31, V9.D[0x0]
    SUBHN2  V7.8H, V12.4S, V25.4S
    MVN  V19.16B, V6.16B
    RSHRN2 V5.4S, V4.2D, #27
    SRI  V28.4H, V22.4H, #5
    BIC  V3.2S, #0x45
    INS V11.D[0x1], X27
    DUP H21, V10.H[0x6]
    SHL  V25.16B, V27.16B, #0x4
    ORR  V23.4H, #0xf0, LSL #8
    UZP2  V23.2D, V9.2D, V8.2D
    DUP H22, V31.H[0x5]
    EOR  V2.8B, V7.8B, V23.8B
    MOVI  V31.2D, #18446742978476114175
    SHL  V31.4S, V20.4S, #0x1f
    MOV V19.D[0x1], X22
    PMULL  V23.8H, V31.8B, V28.8B
    ADDHN  V20.4H, V2.4S, V2.4S
    XTN  V6.2S, V25.2D
    MLS  V31.4S, V4.4S, V10.S[0x1]
    AESMC  V8.16B, V3.16B
    MOVI  V10.4S, #0x6d, MSL #8
    SUB  V21.8H, V2.8H, V31.8H
    MOVI  V3.4S, #0x7d, LSL #24
    DUP  V14.16B, V15.B[0x8]
    SLI V15.2D, V26.2D, #0xa
    RADDHN  V12.4H, V15.4S, V8.4S
    MOV V24.B[0xb], W17
    DUP V6.2D, V19.D[0x1]
    INS V26.S[0x0], V20.S[0x3]
    SHLL2  V7.8H, V23.16B, #8
    ORN  V9.8B, V26.8B, V31.8B
    RSHRN V4.2S, V10.2D, #32
    RSHRN2 V19.4S, V4.2D, #9
    RSHRN V4.2S, V9.2D, #31
    ADDHN2  V25.8H, V21.4S, V30.4S
    SRI V2.2D, V12.2D, #29
    INS V0.H[0x1], V7.H[0x1]
    ZIP1  V7.16B, V0.16B, V15.16B
    DUP H21, V24.H[0x6]
    BIC  V24.2S, #0xbc, LSL #24
    MVN  V23.8B, V3.8B
    MOVI  V19.2S, #0xbe, MSL #16
    SRI  V10.4H, V27.4H, #2
    TBX  V0.8B, { V25.16B, V26.16B }, V19.8B
    RSHRN V9.8B, V4.8H, #5
    RSUBHN2  V20.4S, V2.2D, V9.2D
    MLS  V31.8H, V0.8H, V2.H[0x0]
    MOV V9.D[0x1], X8
    BSL  V12.16B, V4.16B, V20.16B
    DUP V27.8H, W4
    MOV  V4.16B, V12.16B
    MVNI  V20.2S, #0x84, MSL #16
    MOV B18, V9.B[0x7]
    MVNI  V10.4H, #0xae, LSL #8
    MOVI  V21.2S, #0x1c, LSL #16
    MUL  V0.2S, V23.2S, V4.S[0x1]
    REV32  V4.8B, V24.8B
    SHRN V16.8B, V20.8H, #6
    DUP  V3.16B, V18.B[0x9]
    XTN2  V2.8H, V14.4S
    MLS  V14.16B, V12.16B, V2.16B
    SRI  V20.4S, V10.4S, #10
    MOVI  V18.2D, #18446462598749618175
    MLS  V10.2S, V31.2S, V23.2S
    MLS  V12.2S, V16.2S, V21.2S
    MOVI  V3.4S, #0x3e, MSL #16
    SLI  V31.2S, V18.2S, #0x18
    XTN2  V2.16B, V31.8H
    MOV V5.S[0x2], W26
    PMULL2  V21.8H, V10.16B, V12.16B
    PMULL2  V9.1Q, V14.2D, V22.2D
    ADD  V16.8H, V20.8H, V11.8H
    MOV  W12, V0.S[0x2]
    ORN  V12.8B, V4.8B, V4.8B
    SRI  V23.8H, V31.8H, #13
    TBX  V14.16B, { V0.16B, V1.16B }, V2.16B
    AESE  V2.16B, V23.16B
    MOV  W27, V23.S[0x0]
    SLI  V9.8H, V12.8H, #0x9
    SHRN V18.8B, V16.8H, #3
    SRI  V22.8H, V0.8H, #4
    SRI  V7.4S, V12.4S, #29
    TBL  V11.8B, { V19.16B }, V21.8B
    MOV  W25, V5.S[0x3]
    SUBHN  V12.2S, V4.2D, V10.2D
    INS V23.B[0x5], V7.B[0xc]
    MLA  V14.4H, V3.4H, V6.H[0x7]
    DUP V20.8B, W23
    MOVI  V10.2S, #0x2a, MSL #16
    SHRN V5.8B, V14.8H, #6
    DUP V21.2D, X18
    MLA  V15.16B, V18.16B, V22.16B
    UZP1  V6.4H, V20.4H, V11.4H
    MVNI  V19.4S, #0x8f, MSL #16
    MOV V19.B[0x8], W2
    MLA  V25.4S, V21.4S, V27.S[0x2]
    RSHRN2 V20.8H, V5.4S, #2
    CLS  V11.8H, V10.8H
    TBL  V31.8B, { V22.16B, V23.16B }, V25.8B
    INS V9.D[0x0], V19.D[0x1]
    SRI  V8.2S, V25.2S, #32
    MLA  V25.4S, V9.4S, V31.S[0x2]
    EOR  V3.8B, V25.8B, V15.8B
    MLA  V31.2S, V20.2S, V20.S[0x3]
    MOV V29.S[0x1], V21.S[0x0]
    BIC  V6.8B, V3.8B, V29.8B
    UZP2  V14.16B, V2.16B, V21.16B
    ADDV  B5, V14.8B
    SUBHN  V18.8B, V4.8H, V1.8H
    MOV  W19, V5.S[0x3]
    RADDHN2  V30.16B, V8.8H, V31.8H
    SHRN2 V19.4S, V6.2D, #9
    BSL  V15.8B, V30.8B, V11.8B
    ADDP  V30.2S, V21.2S, V22.2S
    MOV  W19, V18.S[0x3]
    MOV B20, V6.B[0xe]
    MUL  V14.2S, V30.2S, V18.S[0x0]
    RSHRN V6.8B, V20.8H, #1
    AESE  V5.16B, V6.16B
    DUP  V4.8B, V19.B[0xe]
    INS V2.B[0x6], W21
    INS V25.B[0x4], W24
    INS V3.D[0x0], X16
    MLA  V18.8H, V23.8H, V20.8H
    PMUL  V29.16B, V23.16B, V25.16B
    DUP V21.16B, W22
    SUBHN2  V19.16B, V29.8H, V19.8H
    MLA  V10.16B, V21.16B, V11.16B
    BIC  V25.4S, #0x5e, LSL #8
    TBX  V29.16B, { V2.16B, V3.16B, V4.16B, V5.16B }, V21.16B
    SHRN V4.2S, V23.2D, #21
    SHRN2 V31.8H, V4.4S, #4
    DUP V6.8B, W8
    ORR  V21.8H, #0x9f, LSL #8
    AESIMC  V19.16B, V16.16B
    REV32  V30.8H, V17.8H
    AESMC  V23.16B, V15.16B
    MVN  V5.8B, V21.8B
    ADDV  H20, V5.8H
    AESD  V6.16B, V17.16B
    MOV B4, V29.B[0x8]
    DUP V22.4H, W22
    TBL  V2.8B, { V0.16B, V1.16B, V2.16B, V3.16B }, V20.8B
    ADDHN2  V14.16B, V19.8H, V30.8H
    BIC  V21.8H, #0x19, LSL #8
    MOV V16.S[0x2], V31.S[0x1]
    DUP V3.16B, W23
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_5
    MOVZ  X7, #0x1768, LSL #0
    MOVK  X7, #0x9884, LSL #16
    MOVK  X7, #0xe2b9, LSL #32
    MOVK  X7, #0xb432, LSL #48
    SUB  X6, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0xcfc0, LSL #0
    MOVK  X7, #0xe019, LSL #16
    MOVK  X7, #0xc1fb, LSL #32
    MOVK  X7, #0xf5cf, LSL #48
    SUB  X6, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x2972, LSL #0
    MOVK  X7, #0xde6a, LSL #16
    MOVK  X7, #0x3415, LSL #32
    MOVK  X7, #0x4b29, LSL #48
    SUB  X6, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x274, LSL #0
    MOVK  X7, #0xf23d, LSL #16
    MOVK  X7, #0xdfce, LSL #32
    MOVK  X7, #0x469b, LSL #48
    SUB  X6, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0xdb54, LSL #0
    MOVK  X7, #0x14c7, LSL #16
    MOVK  X7, #0x1864, LSL #32
    MOVK  X7, #0xfbe4, LSL #48
    SUB  X6, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x9967, LSL #0
    MOVK  X7, #0xdee9, LSL #16
    MOVK  X7, #0x67fe, LSL #32
    MOVK  X7, #0xf9cd, LSL #48
    SUB  X6, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x272d, LSL #0
    MOVK  X7, #0xb971, LSL #16
    MOVK  X7, #0x1953, LSL #32
    MOVK  X7, #0xb76c, LSL #48
    SUB  X6, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x85b0, LSL #0
    MOVK  X7, #0x65c1, LSL #16
    MOVK  X7, #0x858, LSL #32
    MOVK  X7, #0xa53b, LSL #48
    SUB  X6, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x7c34, LSL #0
    MOVK  X7, #0xf8ec, LSL #16
    MOVK  X7, #0xa42e, LSL #32
    MOVK  X7, #0xd854, LSL #48
    SUB  X6, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x771, LSL #0
    MOVK  X7, #0xb330, LSL #16
    MOVK  X7, #0x28a6, LSL #32
    MOVK  X7, #0x6832, LSL #48
    SUB  X6, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x4ccf, LSL #0
    MOVK  X7, #0xa425, LSL #16
    MOVK  X7, #0x965e, LSL #32
    MOVK  X7, #0xc17, LSL #48
    SUB  X6, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0xb60c, LSL #0
    MOVK  X7, #0xc998, LSL #16
    MOVK  X7, #0xd2c3, LSL #32
    MOVK  X7, #0xb84c, LSL #48
    SUB  X6, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0xb6d2, LSL #0
    MOVK  X7, #0xbd1, LSL #16
    MOVK  X7, #0xd094, LSL #32
    MOVK  X7, #0xc65a, LSL #48
    SUB  X6, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0xfff9, LSL #0
    MOVK  X7, #0x82ff, LSL #16
    SUB  X6, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X7, #0xc328, LSL #0
    MOVK  X7, #0x45d7, LSL #16
    MOVK  X7, #0x9546, LSL #32
    MOVK  X7, #0x333, LSL #48
    SUB  X6, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X7, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D1
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X6, #0xcfcf, LSL #0
    MOVK  X6, #0xcfcf, LSL #16
    MOVK  X6, #0xcfcf, LSL #32
    MOVK  X6, #0xcfcf, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D3
    MOVZ  X6, #0xcfcf, LSL #0
    MOVK  X6, #0xcfcf, LSL #16
    MOVK  X6, #0xcfcf, LSL #32
    MOVK  X6, #0xcfcf, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D5
    MOVZ  X6, #0x8e, LSL #0
    MOVK  X6, #0x8e, LSL #16
    MOVK  X6, #0x8e, LSL #32
    MOVK  X6, #0x8e, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X6, #0xfd52, LSL #0
    MOVK  X6, #0x52fd, LSL #16
    MOVK  X6, #0x5252, LSL #32
    MOVK  X6, #0xfdfd, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D6
    MOVZ  X6, #0x52fd, LSL #0
    MOVK  X6, #0xfd52, LSL #16
    MOVK  X6, #0xfdfd, LSL #32
    MOVK  X6, #0x5252, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X6, #0xf8, LSL #0
    MOVK  X6, #0x4c8c, LSL #16
    MOVK  X6, #0x56f8, LSL #32
    MOVK  X6, #0x248c, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D7
    MOVZ  X6, #0xfff, LSL #0
    MOVK  X6, #0x8c, LSL #16
    MOVK  X6, #0x7, LSL #32
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D8
    MOVZ  X6, #0x111d, LSL #0
    MOVK  X6, #0x1718, LSL #16
    MOVK  X6, #0x91dd, LSL #32
    MOVK  X6, #0x5758, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D9
    MOVZ  X6, #0x68, LSL #0
    MOVK  X6, #0xff70, LSL #16
    MOVK  X6, #0xff70, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X6, #0x9f, LSL #0
    MOVK  X6, #0x9f, LSL #16
    MOVK  X6, #0x9f, LSL #32
    MOVK  X6, #0x9f, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D10
    MOVZ  X6, #0xff9e, LSL #0
    MOVK  X6, #0x23, LSL #16
    MOVK  X6, #0xff9e, LSL #32
    MOVK  X6, #0x23, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X6, #0xf, LSL #0
    MOVK  X6, #0xf, LSL #16
    MOVK  X6, #0xf, LSL #32
    MOVK  X6, #0xf, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D11
    MOVZ  X6, #0xf, LSL #0
    MOVK  X6, #0x9, LSL #16
    MOVK  X6, #0xf, LSL #32
    MOVK  X6, #0x9, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D12
    MOVZ  X6, #0x6061, LSL #0
    MOVK  X6, #0xd9b3, LSL #16
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X6, #0x272d, LSL #0
    MOVK  X6, #0xb971, LSL #16
    MOVK  X6, #0x1953, LSL #32
    MOVK  X6, #0xb76c, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D13
    MOVZ  X6, #0x9967, LSL #0
    MOVK  X6, #0xdee9, LSL #16
    MOVK  X6, #0x67fe, LSL #32
    MOVK  X6, #0xf9cd, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X6, #0x24d8, LSL #0
    MOVK  X6, #0x9334, LSL #16
    MOVK  X6, #0x39ba, LSL #32
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D14
    MOVZ  X6, #0x365c, LSL #0
    MOVK  X6, #0x3de9, LSL #16
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D15
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x9, LSL #16
    MOVK  X6, #0x400f, LSL #32
    MOVK  X6, #0x9, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D16
    MOVZ  X6, #0x7fe3, LSL #0
    MOVK  X6, #0xff5d, LSL #16
    MOVK  X6, #0xbfe3, LSL #32
    MOVK  X6, #0xff5d, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D18
    MOVZ  X6, #0x365c, LSL #0
    MOVK  X6, #0x3de9, LSL #16
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X6, #0xba5b, LSL #0
    MOVK  X6, #0x39a7, LSL #16
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D19
    MOVZ  X6, #0xd8db, LSL #0
    MOVK  X6, #0x2419, LSL #16
    MOVK  X6, #0x34da, LSL #32
    MOVK  X6, #0x9383, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D20
    MOVZ  X6, #0x238, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X6, #0xe671, LSL #0
    MOVK  X6, #0xe671, LSL #16
    MOVK  X6, #0xe671, LSL #32
    MOVK  X6, #0xe671, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D21
    MOVZ  X6, #0xe671, LSL #0
    MOVK  X6, #0xe671, LSL #16
    MOVK  X6, #0xe671, LSL #32
    MOVK  X6, #0xe671, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D22
    MOVZ  X6, #0x771, LSL #0
    MOVK  X6, #0x771, LSL #16
    MOVK  X6, #0x771, LSL #32
    MOVK  X6, #0x771, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D23
    MOVZ  X6, #0x1b09, LSL #0
    MOVK  X6, #0x912, LSL #16
    MOVK  X6, #0x94d7, LSL #32
    MOVK  X6, #0x585d, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D24
    MOVZ  X6, #0x936, LSL #0
    MOVK  X6, #0x415c, LSL #16
    MOVK  X6, #0x553d, LSL #32
    MOVK  X6, #0x3e9, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X6, #0xac, LSL #0
    MOVK  X6, #0xa972, LSL #16
    MOVK  X6, #0x8130, LSL #32
    MOVK  X6, #0x4d54, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D25
    MOVZ  X6, #0xa192, LSL #0
    MOVK  X6, #0xb992, LSL #16
    MOVK  X6, #0x800c, LSL #32
    MOVK  X6, #0x9020, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X6, #0xed09, LSL #0
    MOVK  X6, #0x2aa7, LSL #16
    MOVK  X6, #0x3f84, LSL #32
    MOVK  X6, #0x8deb, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D26
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x1593, LSL #32
    MOVK  X6, #0x4389, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X6, #0x2972, LSL #0
    MOVK  X6, #0x2972, LSL #16
    MOVK  X6, #0x2972, LSL #32
    MOVK  X6, #0x2972, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D27
    MOVZ  X6, #0x2972, LSL #0
    MOVK  X6, #0x2972, LSL #16
    MOVK  X6, #0x2972, LSL #32
    MOVK  X6, #0x2972, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D29
    MOVZ  X6, #0x97e2, LSL #0
    MOVK  X6, #0xf28e, LSL #16
    MOVK  X6, #0x802c, LSL #32
    MOVK  X6, #0x2000, LSL #48
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X6, #0x7cc1, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X7, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
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
    FMOV  D0, X6
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X2
    FMOV  D2, X25
    FMOV  V2.D[1], X12
    FMOV  D3, X27
    FMOV  V3.D[1], X25
    FMOV  D4, X22
    FMOV  V4.D[1], X21
    FMOV  D5, X9
    FMOV  V5.D[1], X2
    FMOV  D6, X26
    FMOV  V6.D[1], X5
    FMOV  D7, X24
    FMOV  V7.D[1], X19
    FMOV  D8, X29
    FMOV  V8.D[1], X8
    FMOV  D9, X18
    FMOV  V9.D[1], X24
    FMOV  D10, X26
    FMOV  V10.D[1], X2
    FMOV  D11, X18
    FMOV  V11.D[1], X26
    FMOV  D12, X19
    FMOV  V12.D[1], X25
    FMOV  D13, X29
    FMOV  V13.D[1], X7
    FMOV  D14, X28
    FMOV  V14.D[1], X22
    FMOV  D15, X5
    FMOV  V15.D[1], X16
    FMOV  D16, X19
    FMOV  V16.D[1], X2
    FMOV  D17, X12
    FMOV  V17.D[1], X8
    FMOV  D18, X18
    FMOV  V18.D[1], X20
    FMOV  D19, X9
    FMOV  V19.D[1], X12
    FMOV  D20, X16
    FMOV  V20.D[1], X4
    FMOV  D21, X21
    FMOV  V21.D[1], X20
    FMOV  D22, X12
    FMOV  V22.D[1], X28
    FMOV  D23, X17
    FMOV  V23.D[1], X17
    FMOV  D24, X26
    FMOV  V24.D[1], X3
    FMOV  D25, X2
    FMOV  V25.D[1], X4
    FMOV  D26, X22
    FMOV  V26.D[1], X2
    FMOV  D27, X25
    FMOV  V27.D[1], X22
    FMOV  D28, X3
    FMOV  V28.D[1], X16
    FMOV  D29, X21
    FMOV  V29.D[1], X5
    FMOV  D30, X3
    FMOV  V30.D[1], X20
    FMOV  D31, X7
    FMOV  V31.D[1], X27
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_6:
    DUP  V10.16B, V30.B[0x5]
    BIC  V6.4H, #0xcc
    MOVI  V13.2S, #0x49, MSL #16
    MOV V16.B[0x2], W12
    MOV V1.B[0xf], W5
    SHL  V18.2S, V10.2S, #0x14
    MOV V7.H[0x1], W23
    TBX  V19.16B, { V4.16B, V5.16B }, V29.16B
    SHRN2 V21.16B, V27.8H, #7
    SRI  V7.8B, V15.8B, #6
    UZP1  V18.2S, V31.2S, V31.2S
    ADDP  V9.16B, V17.16B, V18.16B
    INS V13.S[0x0], V19.S[0x1]
    SRI  V12.2S, V4.2S, #26
    ADDP  V16.2S, V7.2S, V7.2S
    CLZ  V10.2S, V9.2S
    ADDV  S3, V13.4S
    MOVI  V18.2S, #0xf6
    MOV  V19.8B, V12.8B
    AESD  V27.16B, V22.16B
    SUBHN2  V1.4S, V10.2D, V14.2D
    NOT  V14.8B, V9.8B
    EXT  V31.16B, V27.16B, V2.16B, #0x6
    DUP D2, V19.D[0x0]
    RSHRN2 V4.8H, V2.4S, #10
    ADD  V3.2D, V21.2D, V3.2D
    BIC  V17.8H, #0x19
    MOV V7.B[0xe], W20
    AESD  V29.16B, V16.16B
    BSL  V21.8B, V7.8B, V3.8B
    MVN  V3.16B, V1.16B
    UZP2  V2.4H, V18.4H, V29.4H
    SLI  V27.2S, V14.2S, #0x1e
    DUP D9, V0.D[0x0]
    MOV H10, V21.H[0x1]
    ADDV  B12, V17.8B
    ADDHN  V18.4H, V9.4S, V0.4S
    MOV  W23, V31.S[0x2]
    ZIP1  V21.4H, V26.4H, V3.4H
    DUP B16, V18.B[0x1]
    MOVI  V24.2S, #0x79, LSL #8
    AESIMC  V6.16B, V24.16B
    DUP  V1.4H, V31.H[0x5]
    RSHRN2 V3.4S, V27.2D, #7
    CNT  V8.8B, V26.8B
    RBIT  V31.16B, V16.16B
    DUP B16, V5.B[0xb]
    INS V31.D[0x1], X3
    SHRN2 V14.8H, V18.4S, #14
    RSHRN2 V9.4S, V14.2D, #14
    RSHRN2 V3.16B, V9.8H, #6
    SHLL  V26.8H, V1.8B, #8
    TBX  V29.8B, { V26.16B }, V12.8B
    DUP H1, V10.H[0x3]
    MVN  V7.8B, V29.8B
    MLA  V5.4H, V6.4H, V6.H[0x4]
    RADDHN  V11.2S, V21.2D, V31.2D
    TBX  V24.16B, { V1.16B, V2.16B, V3.16B }, V7.16B
    DUP V2.4S, W18
    MLS  V3.8B, V16.8B, V8.8B
    MOV V0.D[0x1], X6
    SRI  V29.4S, V10.4S, #10
    RSUBHN2  V17.8H, V5.4S, V5.4S
    MOVI  V9.2S, #0xad, MSL #16
    SHL V1.2D, V3.2D, #0x3f
    MOVI  V6.8B, #0xf7
    DUP V22.4S, W3
    INS V8.D[0x1], X22
    ABS  V14.2D, V29.2D
    PMULL2  V3.1Q, V24.2D, V9.2D
    REV32  V21.16B, V24.16B
    EXT  V9.8B, V21.8B, V21.8B, #0x7
    DUP S5, V0.S[0x2]
    XTN2  V16.8H, V2.4S
    SRI  V12.16B, V20.16B, #4
    DUP V0.8B, W12
    MLA  V26.4H, V17.4H, V14.H[0x2]
    RBIT  V7.16B, V11.16B
    REV16  V20.16B, V7.16B
    MUL  V29.16B, V8.16B, V8.16B
    ABS  V17.4S, V12.4S
    MOV S31, V24.S[0x3]
    SRI  V12.4H, V15.4H, #1
    MOVI  V31.2D, #18446462598749552640
    SHRN2 V24.4S, V6.2D, #1
    EOR  V6.16B, V23.16B, V24.16B
    XTN2  V15.4S, V0.2D
    AESD  V21.16B, V3.16B
    TBL  V7.16B, { V17.16B, V18.16B, V19.16B }, V20.16B
    MLS  V14.4S, V12.4S, V31.S[0x0]
    MLA  V24.2S, V26.2S, V21.2S
    MOVI  V2.2S, #0x0, MSL #8
    MVNI  V12.2S, #0x16, MSL #16
    INS V0.S[0x1], W16
    BIC  V5.2S, #0x9d, LSL #24
    SHRN V29.4H, V22.4S, #8
    ADDV  B21, V6.8B
    SRI  V7.4H, V15.4H, #9
    SHRN V6.2S, V5.2D, #1
    NEG  V3.4H, V7.4H
    MLA  V11.8H, V23.8H, V6.H[0x2]
    PMUL  V20.8B, V11.8B, V27.8B
    RADDHN2  V8.16B, V0.8H, V21.8H
    SLI  V7.8H, V12.8H, #0x7
    ADDP  D19, V29.2D
    DUP B5, V14.B[0x0]
    DUP V26.16B, W7
    MOV  X16, V31.D[0x1]
    INS V17.D[0x1], X16
    AESMC  V21.16B, V25.16B
    BSL  V14.16B, V17.16B, V2.16B
    SHLL  V31.2D, V24.2S, #32
    MUL  V22.2S, V3.2S, V26.S[0x3]
    RBIT  V8.16B, V19.16B
    RSHRN V3.2S, V20.2D, #20
    MVN  V15.16B, V3.16B
    DUP V26.8H, W17
    SHRN V0.8B, V26.8H, #8
    INS V27.B[0x5], W2
    AND  V3.16B, V31.16B, V1.16B
    ZIP2  V25.8B, V22.8B, V8.8B
    RSHRN V12.2S, V14.2D, #28
    DUP B22, V12.B[0x8]
    MLS  V6.4S, V21.4S, V0.4S
    MOVI  V19.8H, #0x3, LSL #8
    MOV V25.H[0x0], W25
    MOV D14, V1.D[0x0]
    AESD  V17.16B, V3.16B
    EXT  V26.8B, V25.8B, V27.8B, #0x1
    RADDHN2  V6.8H, V19.4S, V26.4S
    INS V4.S[0x3], V6.S[0x1]
    MOV H1, V7.H[0x5]
    SRI  V27.4S, V22.4S, #23
    SLI  V8.4S, V27.4S, #0x6
    EXT  V26.16B, V4.16B, V8.16B, #0xc
    SHRN V19.2S, V26.2D, #2
    AESE  V25.16B, V17.16B
    ORN  V17.8B, V14.8B, V25.8B
    MLS  V30.4H, V17.4H, V1.H[0x4]
    RBIT  V4.16B, V11.16B
    SRI V31.2D, V30.2D, #38
    UZP1  V12.4S, V26.4S, V19.4S
    RSHRN2 V22.16B, V12.8H, #6
    MLS  V7.4H, V4.4H, V10.H[0x1]
    ORN  V31.8B, V31.8B, V28.8B
    NOT  V21.16B, V13.16B
    RSHRN2 V12.16B, V21.8H, #1
    TBL  V4.16B, { V20.16B, V21.16B }, V22.16B
    ADDP  V8.8B, V7.8B, V21.8B
    INS V10.H[0x1], V12.H[0x1]
    PMULL  V14.1Q, V10.1D, V4.1D
    SHRN V0.8B, V14.8H, #1
    TBL  V17.16B, { V10.16B, V11.16B, V12.16B }, V31.16B
    AESE  V14.16B, V15.16B
    MOVI  V28.2D, #4294967040
    NOT  V15.8B, V28.8B
    REV64  V19.8H, V5.8H
    SHRN2 V13.4S, V0.2D, #21
    MUL  V21.8H, V13.8H, V14.H[0x2]
    AESE  V4.16B, V8.16B
    ADDP  V0.16B, V31.16B, V18.16B
    MOVI  V18.2S, #0xf7, MSL #16
    ADD  V14.16B, V1.16B, V25.16B
    DUP S11, V24.S[0x2]
    INS V7.B[0xf], V4.B[0x6]
    ADDHN  V25.4H, V19.4S, V3.4S
    SHRN V26.4H, V25.4S, #2
    RSHRN V30.4H, V7.4S, #7
    RSHRN2 V31.8H, V18.4S, #12
    SLI  V18.4S, V21.4S, #0x1a
    MLA  V13.4S, V30.4S, V31.4S
    MOVI  V19.16B, #0xdd
    DUP B7, V13.B[0xb]
    DUP V4.2D, V15.D[0x0]
    DUP V15.16B, W16
    RADDHN  V27.8B, V24.8H, V14.8H
    AESD  V25.16B, V27.16B
    DUP V14.4H, W24
    TBX  V8.16B, { V10.16B, V11.16B, V12.16B }, V4.16B
    ZIP2  V24.8H, V17.8H, V26.8H
    RSHRN2 V21.8H, V8.4S, #13
    ADD  V28.16B, V7.16B, V7.16B
    TBL  V13.16B, { V21.16B }, V25.16B
    MUL  V7.4S, V11.4S, V13.S[0x2]
    SHL  V11.4S, V15.4S, #0x6
    TBL  V15.16B, { V7.16B }, V0.16B
    DUP V24.16B, W27
    MOV V0.B[0x7], W29
    ADDV  H8, V24.4H
    BIF  V6.16B, V19.16B, V23.16B
    MOVI  V27.8H, #0xc9
    SUB  V7.4S, V14.4S, V6.4S
    TBL  V4.8B, { V13.16B, V14.16B, V15.16B }, V11.8B
    INS V20.B[0x5], W29
    SHRN V23.4H, V7.4S, #11
    MVN  V29.8B, V0.8B
    DUP V24.2D, V29.D[0x0]
    RADDHN2  V18.16B, V9.8H, V18.8H
    DUP V13.2D, V31.D[0x1]
    ZIP1  V10.4S, V28.4S, V23.4S
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_6
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xff, LSL #16
    MOVK  X26, #0xffff, LSL #48
    SUB  X4, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x5212, LSL #0
    MOVK  X26, #0xff, LSL #16
    SUB  X4, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X4, #0xfa, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D0
    MOVZ  X4, #0xfefe, LSL #0
    MOVK  X4, #0xfefe, LSL #16
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D2
    MOVZ  X4, #0xff, LSL #0
    MOVK  X4, #0xff, LSL #32
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D5
    MOVZ  X4, #0x14, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X4, #0xdddd, LSL #0
    MOVK  X4, #0xdddd, LSL #16
    MOVK  X4, #0xdddd, LSL #32
    MOVK  X4, #0xdddd, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D6
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x1111, LSL #16
    MOVK  X4, #0x9999, LSL #32
    MOVK  X4, #0x9999, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X4, #0x2223, LSL #0
    MOVK  X4, #0x2222, LSL #16
    MOVK  X4, #0x2223, LSL #32
    MOVK  X4, #0x2222, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D7
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xeeef, LSL #16
    MOVK  X4, #0x6667, LSL #32
    MOVK  X4, #0x6666, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D9
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7900, LSL #16
    MOVK  X4, #0x7900, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4444, LSL #32
    MOVK  X4, #0x4444, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D10
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xdde0, LSL #32
    MOVK  X4, #0xcccc, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X4, #0x1111, LSL #0
    MOVK  X4, #0xdb00, LSL #16
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D12
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4480, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X4, #0xf80, LSL #0
    MOVK  X4, #0xf80, LSL #16
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D13
    MOVZ  X4, #0xf80, LSL #0
    MOVK  X4, #0xf80, LSL #16
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X4, #0x4848, LSL #0
    MOVK  X4, #0x4848, LSL #16
    MOVK  X4, #0x4848, LSL #32
    MOVK  X4, #0x4848, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X4, #0xc600, LSL #0
    MOVK  X4, #0xbe00, LSL #16
    MOVK  X4, #0x6800, LSL #32
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D18
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x4cf7, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0x44f7, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X4, #0xdddd, LSL #0
    MOVK  X4, #0xdddd, LSL #16
    MOVK  X4, #0xdddd, LSL #32
    MOVK  X4, #0xdddd, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D19
    MOVZ  X4, #0xdddd, LSL #0
    MOVK  X4, #0xdddd, LSL #16
    MOVK  X4, #0xdddd, LSL #32
    MOVK  X4, #0xdddd, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D20
    MOVZ  X4, #0x12, LSL #0
    MOVK  X4, #0x4e0e, LSL #16
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X4, #0x4242, LSL #0
    MOVK  X4, #0xa802, LSL #16
    MOVK  X4, #0x4242, LSL #32
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D21
    MOVZ  X4, #0x9493, LSL #0
    MOVK  X4, #0x9493, LSL #16
    MOVK  X4, #0xd2d1, LSL #32
    MOVK  X4, #0xe267, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x1200, LSL #16
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D23
    MOVZ  X4, #0xdde0, LSL #0
    MOVK  X4, #0xcccc, LSL #16
    MOVK  X4, #0x4444, LSL #32
    MOVK  X4, #0x4444, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X4, #0x101, LSL #0
    MOVK  X4, #0x101, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D24
    MOVZ  X4, #0x101, LSL #0
    MOVK  X4, #0x101, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X4, #0x952, LSL #0
    MOVK  X4, #0x5266, LSL #16
    MOVK  X4, #0x5252, LSL #32
    MOVK  X4, #0x5252, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D25
    MOVZ  X4, #0x523d, LSL #0
    MOVK  X4, #0x5252, LSL #16
    MOVK  X4, #0x3052, LSL #32
    MOVK  X4, #0x5252, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X4, #0xc9, LSL #0
    MOVK  X4, #0xc9, LSL #16
    MOVK  X4, #0xc9, LSL #32
    MOVK  X4, #0xc9, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D27
    MOVZ  X4, #0xc9, LSL #0
    MOVK  X4, #0xc9, LSL #16
    MOVK  X4, #0xc9, LSL #32
    MOVK  X4, #0xc9, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D29
    MOVZ  X4, #0x101, LSL #0
    MOVK  X4, #0x101, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X4, #0xf80, LSL #0
    MOVK  X4, #0xf80, LSL #16
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X26, D31
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X6
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X22
    FMOV  D4, X4
    FMOV  V4.D[1], X2
    FMOV  D5, X4
    FMOV  V5.D[1], X29
    FMOV  D6, X19
    FMOV  V6.D[1], X3
    FMOV  D7, X6
    FMOV  V7.D[1], X29
    FMOV  D8, X20
    FMOV  V8.D[1], X29
    FMOV  D9, X12
    FMOV  V9.D[1], X19
    FMOV  D10, X28
    FMOV  V10.D[1], X28
    FMOV  D11, X22
    FMOV  V11.D[1], X23
    FMOV  D12, X19
    FMOV  V12.D[1], X17
    FMOV  D13, X4
    FMOV  V13.D[1], X2
    FMOV  D14, X26
    FMOV  V14.D[1], X27
    FMOV  D15, X25
    FMOV  V15.D[1], X22
    FMOV  D16, X19
    FMOV  V16.D[1], X16
    FMOV  D17, X23
    FMOV  V17.D[1], X26
    FMOV  D18, X2
    FMOV  V18.D[1], X20
    FMOV  D19, X23
    FMOV  V19.D[1], X17
    FMOV  D20, X6
    FMOV  V20.D[1], X9
    FMOV  D21, X6
    FMOV  V21.D[1], X24
    FMOV  D22, X25
    FMOV  V22.D[1], X6
    FMOV  D23, X27
    FMOV  V23.D[1], X25
    FMOV  D24, X26
    FMOV  V24.D[1], X8
    FMOV  D25, X12
    FMOV  V25.D[1], X8
    FMOV  D26, X12
    FMOV  V26.D[1], X29
    FMOV  D27, X5
    FMOV  V27.D[1], X27
    FMOV  D28, X3
    FMOV  V28.D[1], X4
    FMOV  D29, X2
    FMOV  V29.D[1], X9
    FMOV  D30, X4
    FMOV  V30.D[1], X24
    FMOV  D31, X12
    FMOV  V31.D[1], X9
    MOVZ  X6, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_7:
    SUBHN2  V9.8H, V23.4S, V28.4S
    BIF  V28.16B, V30.16B, V31.16B
    MLS  V8.16B, V29.16B, V20.16B
    TRN2  V5.16B, V29.16B, V30.16B
    ADDV  S27, V22.4S
    ORR  V28.2S, #0xb6, LSL #16
    BIC  V9.8H, #0xa
    SLI V8.2D, V27.2D, #0x25
    CLZ  V7.4H, V28.4H
    ZIP1  V14.8B, V9.8B, V5.8B
    RSUBHN2  V9.16B, V14.8H, V4.8H
    MOV D23, V12.D[0x0]
    RSHRN V20.4H, V9.4S, #8
    DUP S0, V21.S[0x0]
    MOV V28.H[0x4], W9
    MVN  V14.8B, V23.8B
    UZP2  V7.8H, V7.8H, V8.8H
    UZP2  V28.2D, V13.2D, V28.2D
    RSHRN V26.8B, V0.8H, #6
    RSHRN2 V5.4S, V18.2D, #21
    ADDV  B30, V7.16B
    PMUL  V21.16B, V14.16B, V6.16B
    ADDP  D0, V28.2D
    EOR  V23.16B, V10.16B, V30.16B
    TBL  V31.8B, { V0.16B, V1.16B, V2.16B }, V20.8B
    TBL  V18.16B, { V31.16B, V0.16B, V1.16B }, V15.16B
    ABS  V28.2S, V5.2S
    ORR  V9.8B, V28.8B, V29.8B
    MUL  V8.4S, V31.4S, V21.S[0x3]
    MOVI  V10.4S, #0xc2, LSL #16
    SUB  V27.2D, V9.2D, V26.2D
    DUP S0, V18.S[0x1]
    RSHRN V1.4H, V0.4S, #15
    SUBHN  V2.4H, V1.4S, V8.4S
    ORR  V1.2S, #0x40, LSL #16
    DUP  V25.4H, V5.H[0x4]
    BIC  V20.2S, #0x98
    MLA  V9.8B, V11.8B, V17.8B
    SHLL2  V4.8H, V14.16B, #8
    MOV V6.D[0x1], X7
    ORR  V15.8B, V23.8B, V2.8B
    PMULL  V0.8H, V13.8B, V14.8B
    DUP  V7.4H, V27.H[0x1]
    CNT  V13.16B, V0.16B
    PMUL  V17.16B, V10.16B, V13.16B
    SRI V2.2D, V22.2D, #38
    MOV V22.B[0xd], V7.B[0x8]
    RSHRN V8.4H, V22.4S, #2
    SUB  V27.2S, V9.2S, V17.2S
    RADDHN2  V31.8H, V10.4S, V8.4S
    INS V9.S[0x2], V25.S[0x0]
    MLA  V10.4H, V6.4H, V9.H[0x6]
    SHRN V30.2S, V2.2D, #16
    ADD  V13.8H, V20.8H, V3.8H
    RADDHN2  V3.16B, V13.8H, V27.8H
    MOV V22.D[0x1], V15.D[0x1]
    SHRN V23.8B, V3.8H, #5
    NOT  V7.16B, V23.16B
    TBX  V21.8B, { V30.16B, V31.16B }, V2.8B
    SRI  V14.16B, V18.16B, #2
    PMULL  V6.1Q, V22.1D, V4.1D
    MOV V30.S[0x1], V3.S[0x0]
    DUP D2, V10.D[0x1]
    INS V5.H[0x5], V2.H[0x7]
    SLI  V23.2S, V21.2S, #0x1f
    CLZ  V31.2S, V14.2S
    MOV V11.B[0x7], V15.B[0xa]
    SHLL  V8.8H, V6.8B, #8
    ORR  V6.4H, #0x5e, LSL #8
    ZIP2  V0.4H, V11.4H, V8.4H
    NEG  V7.4S, V31.4S
    MOVI  V3.4S, #0xbe, LSL #24
    MOV V21.B[0x9], W24
    TRN1  V13.8B, V23.8B, V7.8B
    MVNI  V19.2S, #0xfd, MSL #16
    SRI  V18.2S, V13.2S, #12
    MOV V2.S[0x1], V30.S[0x1]
    TBL  V4.8B, { V3.16B }, V0.8B
    SRI  V3.8H, V6.8H, #12
    MOV V6.S[0x0], W26
    ABS  V30.16B, V4.16B
    BIC  V31.8B, V2.8B, V0.8B
    AESMC  V4.16B, V31.16B
    MOVI  V7.16B, #0x17
    SHL  V12.2S, V18.2S, #0x15
    SLI  V23.8H, V13.8H, #0x1
    BIC  V11.2S, #0x9, LSL #8
    SLI  V2.16B, V30.16B, #0x0
    MUL  V10.4H, V19.4H, V2.H[0x3]
    MLA  V15.4S, V23.4S, V31.S[0x3]
    DUP V19.2D, X7
    ADDP  V10.4S, V13.4S, V15.4S
    UZP2  V0.4S, V3.4S, V5.4S
    PMUL  V31.16B, V12.16B, V12.16B
    SRI  V2.16B, V7.16B, #1
    TBL  V12.8B, { V31.16B, V0.16B }, V29.8B
    ORR  V0.4S, #0x88, LSL #16
    REV16  V1.8B, V15.8B
    SHRN V18.4H, V10.4S, #11
    MOV V5.H[0x5], W26
    XTN  V10.8B, V21.8H
    SHRN2 V15.4S, V11.2D, #6
    MOV H14, V22.H[0x4]
    SHL  V13.4H, V12.4H, #0x8
    PMULL2  V3.1Q, V14.2D, V13.2D
    ADDHN2  V29.8H, V4.4S, V26.4S
    TBX  V29.16B, { V0.16B, V1.16B, V2.16B }, V6.16B
    PMULL  V26.8H, V30.8B, V15.8B
    DUP V30.4S, W9
    RSUBHN  V10.2S, V30.2D, V3.2D
    SHRN V13.8B, V19.8H, #7
    MOV V23.S[0x0], W6
    SHL  V7.16B, V11.16B, #0x6
    RSHRN2 V11.8H, V7.4S, #14
    BIC  V31.4H, #0x6d
    DUP V22.4H, W18
    RSHRN V30.4H, V18.4S, #7
    DUP V18.4H, W6
    XTN  V2.4H, V25.4S
    EXT  V4.8B, V26.8B, V0.8B, #0x3
    BSL  V7.16B, V20.16B, V23.16B
    ORR  V15.8H, #0x41
    XTN  V0.4H, V30.4S
    TBL  V12.8B, { V21.16B, V22.16B }, V7.8B
    MVNI  V7.8H, #0x63
    ADDHN  V6.2S, V31.2D, V7.2D
    INS V10.D[0x0], V0.D[0x1]
    SHRN V13.2S, V27.2D, #4
    MLA  V31.4H, V25.4H, V2.H[0x6]
    MOVI  V14.8B, #0x87
    PMULL  V20.1Q, V10.1D, V14.1D
    RSHRN V22.4H, V15.4S, #10
    RSUBHN  V1.8B, V6.8H, V22.8H
    RSHRN V14.2S, V11.2D, #32
    RSHRN2 V11.8H, V12.4S, #4
    TBX  V29.16B, { V6.16B, V7.16B, V8.16B }, V4.16B
    MOV V25.H[0x4], V14.H[0x6]
    RSHRN2 V8.16B, V25.8H, #5
    RSHRN V15.4H, V20.4S, #1
    SLI V30.2D, V31.2D, #0x26
    DUP B19, V17.B[0x7]
    MOV V21.S[0x1], W17
    MLS  V10.2S, V29.2S, V11.2S
    ZIP2  V12.2D, V26.2D, V0.2D
    INS V2.S[0x2], V1.S[0x3]
    DUP D27, V12.D[0x1]
    MUL  V14.8B, V2.8B, V27.8B
    MOV H23, V15.H[0x2]
    SHRN V25.2S, V20.2D, #7
    MVN  V7.8B, V21.8B
    MUL  V11.8H, V29.8H, V10.H[0x1]
    INS V10.D[0x1], X7
    RSHRN V12.8B, V25.8H, #7
    DUP V26.2S, W29
    ZIP2  V4.2S, V25.2S, V13.2S
    AESMC  V31.16B, V15.16B
    TBX  V1.16B, { V21.16B, V22.16B, V23.16B, V24.16B }, V23.16B
    MOVI  V20.8B, #0x86
    SRI  V6.4S, V12.4S, #4
    SLI  V13.4H, V4.4H, #0x2
    DUP D17, V7.D[0x0]
    PMUL  V12.8B, V1.8B, V11.8B
    ORR  V2.8B, V31.8B, V13.8B
    MOV  X20, V12.D[0x1]
    MOV  V25.8B, V20.8B
    SHRN2 V1.4S, V9.2D, #4
    DUP  V29.16B, V26.B[0x8]
    RADDHN  V26.4H, V29.4S, V23.4S
    BIF  V31.16B, V6.16B, V19.16B
    ORR  V7.4H, #0xc7, LSL #8
    MLS  V22.4H, V17.4H, V5.4H
    SHLL  V4.4S, V31.4H, #16
    MOV V9.D[0x0], V29.D[0x0]
    SRI  V9.2S, V2.2S, #7
    RSHRN V31.8B, V1.8H, #6
    MOV V11.S[0x0], W18
    MOV V21.B[0x0], W5
    TBL  V20.16B, { V28.16B, V29.16B }, V22.16B
    DUP V14.16B, W26
    SHL  V23.4S, V11.4S, #0x4
    DUP B1, V31.B[0x3]
    RSUBHN2  V19.16B, V26.8H, V4.8H
    RSHRN V6.2S, V22.2D, #32
    BIC  V18.4S, #0xb8, LSL #8
    MVNI  V28.4H, #0x28, LSL #8
    RSHRN2 V29.16B, V14.8H, #5
    ZIP2  V26.8B, V25.8B, V23.8B
    NEG  V25.8B, V21.8B
    RSUBHN  V5.2S, V28.2D, V18.2D
    TBL  V29.8B, { V13.16B, V14.16B, V15.16B, V16.16B }, V7.8B
    DUP V5.2D, X17
    ZIP1  V6.2S, V15.2S, V20.2S
    SLI  V2.16B, V1.16B, #0x3
    MLS  V4.8H, V9.8H, V1.H[0x3]
    ADDV  H23, V26.4H
    TBX  V2.16B, { V30.16B, V31.16B }, V29.16B
    MOV V17.B[0x3], V25.B[0x1]
    INS V27.B[0x9], W8
    INS V26.B[0x1], V2.B[0x4]
    SHL  V21.8H, V19.8H, #0xb
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_7
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X27, FPSR
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D0
    MOVZ  X28, #0x1c0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D1
    MOVZ  X28, #0x5, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X28, #0xc0c0, LSL #0
    MOVK  X28, #0xc0c0, LSL #16
    MOVK  X28, #0xc0c0, LSL #32
    MOVK  X28, #0xc0c0, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D2
    MOVZ  X28, #0xc0c0, LSL #0
    MOVK  X28, #0xc0c0, LSL #16
    MOVK  X28, #0xc0c0, LSL #32
    MOVK  X28, #0xc0c0, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xf000, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D5
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D7
    MOVZ  X28, #0xffbe, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xc700, LSL #32
    MOVK  X28, #0xc700, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X28, #0x8080, LSL #0
    MOVK  X28, #0x8080, LSL #16
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D10
    MOVZ  X28, #0x189c, LSL #0
    MOVK  X28, #0x1e1e, LSL #16
    MOVK  X28, #0x6c20, LSL #32
    MOVK  X28, #0xc0c, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X28, #0xa248, LSL #0
    MOVK  X28, #0xa248, LSL #16
    MOVK  X28, #0xa248, LSL #32
    MOVK  X28, #0xa248, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D11
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0x3c48, LSL #32
    MOVK  X28, #0x5a48, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D12
    MOVZ  X28, #0x2248, LSL #0
    MOVK  X28, #0x2248, LSL #16
    MOVK  X28, #0x3c48, LSL #32
    MOVK  X28, #0xda48, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D14
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D16
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D17
    MOVZ  X28, #0xbebe, LSL #0
    MOVK  X28, #0xbfff, LSL #16
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D18
    MOVZ  X28, #0x1, LSL #0
    MOVK  X28, #0x1, LSL #16
    MOVK  X28, #0x1, LSL #32
    MOVK  X28, #0x1, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x1000, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D22
    MOVZ  X28, #0xd9c6, LSL #0
    MOVK  X28, #0x135b, LSL #16
    MOVK  X28, #0x1040, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D23
    MOVZ  X28, #0x6d18, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D24
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D25
    MOVZ  X28, #0xbf01, LSL #0
    MOVK  X28, #0xbf00, LSL #16
    MOVK  X28, #0x101, LSL #32
    MOVK  X28, #0x101, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D26
    MOVZ  X28, #0xc086, LSL #0
    MOVK  X28, #0xc486, LSL #16
    MOVK  X28, #0x8386, LSL #32
    MOVK  X28, #0xa486, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X28, #0xff00, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D28
    MOVZ  X28, #0xd7ff, LSL #0
    MOVK  X28, #0xd7ff, LSL #16
    MOVK  X28, #0xd7ff, LSL #32
    MOVK  X28, #0xd7ff, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D30
    MOVZ  X28, #0x1c0, LSL #0
    MOVK  X28, #0x8b, LSL #16
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D31
    MOVZ  X28, #0x505, LSL #0
    MOVK  X28, #0x505, LSL #16
    MOVK  X28, #0x1051, LSL #32
    MOVK  X28, #0x404, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X20
    FMOV  D2, X29
    FMOV  V2.D[1], X20
    FMOV  D3, X27
    FMOV  V3.D[1], X6
    FMOV  D4, X4
    FMOV  V4.D[1], X22
    FMOV  D5, X5
    FMOV  V5.D[1], X8
    FMOV  D6, X8
    FMOV  V6.D[1], X5
    FMOV  D7, X28
    FMOV  V7.D[1], X2
    FMOV  D8, X19
    FMOV  V8.D[1], X21
    FMOV  D9, X3
    FMOV  V9.D[1], X9
    FMOV  D10, X7
    FMOV  V10.D[1], X16
    FMOV  D11, X6
    FMOV  V11.D[1], X26
    FMOV  D12, X24
    FMOV  V12.D[1], X22
    FMOV  D13, X18
    FMOV  V13.D[1], X4
    FMOV  D14, X3
    FMOV  V14.D[1], X28
    FMOV  D15, X21
    FMOV  V15.D[1], X20
    FMOV  D16, X22
    FMOV  V16.D[1], X23
    FMOV  D17, X5
    FMOV  V17.D[1], X26
    FMOV  D18, X27
    FMOV  V18.D[1], X23
    FMOV  D19, X18
    FMOV  V19.D[1], X27
    FMOV  D20, X9
    FMOV  V20.D[1], X19
    FMOV  D21, X17
    FMOV  V21.D[1], X28
    FMOV  D22, X19
    FMOV  V22.D[1], X24
    FMOV  D23, X23
    FMOV  V23.D[1], X25
    FMOV  D24, X21
    FMOV  V24.D[1], X12
    FMOV  D25, X25
    FMOV  V25.D[1], X5
    FMOV  D26, X28
    FMOV  V26.D[1], X6
    FMOV  D27, X12
    FMOV  V27.D[1], X5
    FMOV  D28, X2
    FMOV  V28.D[1], X9
    FMOV  D29, X25
    FMOV  V29.D[1], X19
    FMOV  D30, X5
    FMOV  V30.D[1], X4
    FMOV  D31, X4
    FMOV  V31.D[1], X25
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_8:
    RADDHN  V20.4H, V27.4S, V24.4S
    MVNI  V1.2S, #0x6b, MSL #16
    RSUBHN2  V4.16B, V31.8H, V23.8H
    MOVI  V31.2D, #72056498821201920
    AESD  V15.16B, V5.16B
    MOV V16.S[0x2], V20.S[0x1]
    ADDP  D14, V11.2D
    MOV V14.H[0x4], W16
    DUP  V11.4H, V29.H[0x0]
    RSHRN V30.8B, V11.8H, #1
    TBX  V14.16B, { V4.16B }, V14.16B
    RADDHN2  V20.8H, V28.4S, V30.4S
    ADD  V10.16B, V14.16B, V14.16B
    INS V12.D[0x1], V31.D[0x1]
    MOV D6, V13.D[0x0]
    ABS  V9.2D, V1.2D
    MOVI  V1.8B, #0x80
    MOVI  V3.4H, #0x7d, LSL #8
    ADDV  S19, V13.4S
    ADDV  B15, V1.16B
    XTN2  V13.4S, V31.2D
    DUP H2, V3.H[0x4]
    MOV V2.H[0x6], V16.H[0x0]
    SRI  V29.8B, V7.8B, #8
    XTN2  V5.16B, V15.8H
    SHRN V28.4H, V12.4S, #10
    RSUBHN2  V24.8H, V10.4S, V13.4S
    ADDP  D18, V9.2D
    EXT  V8.8B, V19.8B, V20.8B, #0x1
    UZP2  V27.8H, V6.8H, V24.8H
    RSHRN V0.2S, V27.2D, #5
    SLI V20.2D, V29.2D, #0x1
    DUP B29, V25.B[0x8]
    MVNI  V4.4H, #0xa9, LSL #8
    MUL  V7.8H, V0.8H, V0.8H
    EXT  V19.8B, V4.8B, V22.8B, #0x7
    PMULL2  V22.1Q, V29.2D, V17.2D
    RADDHN  V14.2S, V29.2D, V28.2D
    MOV H3, V2.H[0x3]
    DUP V15.2D, X26
    RADDHN  V10.4H, V19.4S, V18.4S
    MOV V30.H[0x5], V20.H[0x5]
    DUP H19, V15.H[0x7]
    INS V13.H[0x0], W17
    SRI  V12.4S, V13.4S, #28
    REV32  V6.8B, V19.8B
    INS V24.S[0x1], W5
    ORN  V17.16B, V12.16B, V4.16B
    MOV V6.D[0x0], X4
    PMULL2  V19.8H, V7.16B, V6.16B
    TRN2  V27.2D, V8.2D, V14.2D
    BIF  V29.16B, V24.16B, V22.16B
    XTN2  V2.8H, V7.4S
    UZP2  V31.4H, V29.4H, V24.4H
    BIF  V20.16B, V23.16B, V2.16B
    RADDHN2  V6.4S, V27.2D, V20.2D
    RSHRN V22.8B, V31.8H, #6
    SHL  V27.16B, V21.16B, #0x4
    SLI  V12.8H, V22.8H, #0x0
    SHRN2 V21.4S, V19.2D, #10
    ADDV  H8, V27.4H
    SUB  V27.2D, V17.2D, V30.2D
    MVN  V14.16B, V27.16B
    ADDV  H2, V6.8H
    INS V28.D[0x1], V8.D[0x0]
    RSHRN V29.2S, V12.2D, #23
    MUL  V7.4H, V29.4H, V2.H[0x0]
    DUP V8.2D, V14.D[0x0]
    DUP V21.2D, V9.D[0x0]
    ADDV  H12, V28.8H
    DUP D22, V5.D[0x1]
    SUB  V2.2D, V31.2D, V6.2D
    XTN2  V28.16B, V12.8H
    AESIMC  V6.16B, V10.16B
    ADDP  D14, V23.2D
    SRI  V12.8H, V8.8H, #13
    DUP V8.4S, W23
    MOVI  V5.8B, #0xc5
    REV16  V23.16B, V6.16B
    SHLL2  V9.4S, V18.8H, #16
    PMULL  V10.8H, V5.8B, V5.8B
    TBL  V18.16B, { V7.16B, V8.16B, V9.16B, V10.16B }, V8.16B
    DUP V20.2D, X18
    ORR  V13.8H, #0x91
    ZIP2  V10.8B, V11.8B, V20.8B
    ADDV  B8, V19.16B
    RSHRN2 V19.8H, V12.4S, #7
    ADD  V11.16B, V8.16B, V8.16B
    MOV V7.B[0x4], V19.B[0x9]
    TBL  V20.16B, { V9.16B, V10.16B, V11.16B }, V10.16B
    UZP1  V31.16B, V20.16B, V18.16B
    TBL  V19.8B, { V23.16B, V24.16B, V25.16B, V26.16B }, V15.8B
    SUB  V29.2D, V19.2D, V9.2D
    DUP D10, V31.D[0x0]
    SHLL  V31.8H, V14.8B, #8
    TBX  V9.8B, { V13.16B }, V7.8B
    SRI  V14.4H, V10.4H, #14
    SHRN2 V15.8H, V9.4S, #10
    EXT  V5.8B, V7.8B, V29.8B, #0x7
    SLI  V18.4S, V30.4S, #0xf
    ADDHN2  V24.16B, V10.8H, V16.8H
    DUP V10.2D, X9
    MLS  V8.8H, V24.8H, V13.H[0x5]
    RSUBHN  V23.8B, V8.8H, V31.8H
    INS V12.H[0x3], V5.H[0x2]
    TBX  V20.8B, { V29.16B, V30.16B, V31.16B }, V29.8B
    BIT  V25.16B, V10.16B, V20.16B
    XTN2  V12.16B, V21.8H
    TBX  V16.16B, { V25.16B, V26.16B }, V14.16B
    RSUBHN  V31.2S, V15.2D, V23.2D
    MOV V30.D[0x0], V9.D[0x1]
    UZP1  V15.4H, V8.4H, V18.4H
    TBL  V20.8B, { V12.16B, V13.16B, V14.16B, V15.16B }, V20.8B
    TRN1  V24.2S, V20.2S, V30.2S
    NOT  V21.8B, V17.8B
    ADDHN  V5.4H, V31.4S, V11.4S
    AESD  V9.16B, V18.16B
    MOV  W16, V3.S[0x1]
    MOV V4.D[0x0], X8
    MOVI  V19.4H, #0x97, LSL #8
    SLI  V25.4S, V19.4S, #0x12
    CLZ  V3.4S, V20.4S
    SHRN2 V29.4S, V5.2D, #24
    ZIP2  V10.4S, V24.4S, V5.4S
    SUBHN  V3.8B, V28.8H, V4.8H
    MLS  V23.4H, V21.4H, V4.H[0x0]
    ADDV  B18, V8.16B
    MLA  V21.2S, V25.2S, V16.S[0x2]
    MOV V20.S[0x0], W3
    DUP V27.4H, W8
    MVN  V14.8B, V18.8B
    TRN1  V24.16B, V3.16B, V27.16B
    XTN  V19.4H, V20.4S
    UZP1  V4.16B, V10.16B, V26.16B
    ORR  V23.4S, #0xed, LSL #24
    MUL  V11.4S, V6.4S, V9.S[0x2]
    ADD  V5.4H, V16.4H, V17.4H
    ABS  V9.2S, V21.2S
    RSHRN2 V25.16B, V24.8H, #2
    SLI  V17.16B, V29.16B, #0x0
    SLI  V21.4H, V9.4H, #0x2
    ADD  V30.16B, V12.16B, V24.16B
    MOV V28.S[0x2], W20
    MVNI  V24.4H, #0x35, LSL #8
    MOVI  V20.8B, #0x38
    MOV V31.B[0xb], W8
    ADDV  H18, V6.8H
    AESE  V27.16B, V24.16B
    MUL  V6.8H, V14.8H, V9.H[0x6]
    MOV S2, V27.S[0x3]
    MOVI  V27.4S, #0x54, MSL #16
    DUP  V24.4S, V22.S[0x3]
    DUP D23, V21.D[0x0]
    BIT  V22.8B, V5.8B, V25.8B
    TBX  V1.8B, { V31.16B }, V31.8B
    MLA  V8.4S, V20.4S, V15.S[0x2]
    SHLL2  V31.2D, V24.4S, #32
    XTN2  V31.8H, V19.4S
    INS V3.D[0x1], V1.D[0x0]
    DUP  V24.8B, V2.B[0x1]
    MOV V9.D[0x1], V28.D[0x0]
    RSHRN V13.4H, V23.4S, #13
    SHL V10.2D, V17.2D, #0x2b
    MLS  V20.4S, V22.4S, V10.S[0x0]
    BIT  V28.8B, V31.8B, V24.8B
    RBIT  V2.16B, V28.16B
    ADDHN  V10.8B, V2.8H, V13.8H
    RSHRN2 V7.4S, V12.2D, #5
    INS V1.B[0x2], V3.B[0x1]
    DUP S13, V9.S[0x1]
    MOV V9.S[0x0], W7
    CNT  V22.16B, V7.16B
    NEG  V5.16B, V5.16B
    TBX  V17.16B, { V7.16B, V8.16B }, V3.16B
    SLI V24.2D, V18.2D, #0x36
    PMULL  V2.1Q, V18.1D, V9.1D
    TBX  V9.16B, { V17.16B }, V20.16B
    RADDHN2  V23.8H, V5.4S, V9.4S
    ORR  V26.4S, #0x30
    BIT  V21.8B, V23.8B, V13.8B
    MOV  W18, V14.S[0x3]
    RBIT  V12.16B, V21.16B
    SHRN2 V25.4S, V18.2D, #22
    DUP V23.2D, X16
    MOV V28.D[0x1], X20
    BIC  V5.2S, #0x54
    RSHRN V20.8B, V24.8H, #6
    ADDHN  V13.4H, V2.4S, V2.4S
    DUP  V5.8H, V13.H[0x0]
    XTN  V14.4H, V23.4S
    UZP1  V24.4H, V10.4H, V12.4H
    UZP1  V12.4S, V5.4S, V12.4S
    SRI  V8.8B, V14.8B, #8
    MOV V10.D[0x1], X8
    DUP B23, V28.B[0x0]
    ABS  V5.4H, V10.4H
    RSHRN V2.8B, V26.8H, #3
    RSUBHN  V21.4H, V13.4S, V25.4S
    RSHRN2 V26.16B, V23.8H, #2
    RSHRN V14.4H, V22.4S, #4
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_8
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X21, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X27, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D0
    MOVZ  X21, #0x58d, LSL #0
    MOVK  X21, #0x6800, LSL #32
    MOVK  X21, #0x57, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D1
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5a, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D2
    MOVZ  X21, #0x4b4f, LSL #0
    MOVK  X21, #0x4b4f, LSL #16
    MOVK  X21, #0x7, LSL #32
    MOVK  X21, #0x6, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x80, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D3
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0xe5a5, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X21, #0x5a7a, LSL #0
    MOVK  X21, #0x5a7a, LSL #16
    MOVK  X21, #0x25, LSL #32
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D5
    MOVZ  X21, #0x1c1c, LSL #0
    MOVK  X21, #0x707, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D6
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X21, #0x156, LSL #0
    MOVK  X21, #0xfb60, LSL #32
    MOVK  X21, #0x35f, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D7
    MOVZ  X21, #0x7750, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D8
    MOVZ  X21, #0x1c1c, LSL #0
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D9
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x942d, LSL #32
    MOVK  X21, #0x6797, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D10
    MOVZ  X21, #0x1c1c, LSL #0
    MOVK  X21, #0xf8f9, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D11
    MOVZ  X21, #0x4c00, LSL #0
    MOVK  X21, #0x87f, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X21, #0xa07, LSL #0
    MOVK  X21, #0x793a, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D12
    MOVZ  X21, #0xd2d2, LSL #0
    MOVK  X21, #0xd2d2, LSL #16
    MOVK  X21, #0xd2d2, LSL #32
    MOVK  X21, #0xd2d2, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D13
    MOVZ  X21, #0xd2d2, LSL #0
    MOVK  X21, #0xb1ad, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D14
    MOVZ  X21, #0x60, LSL #0
    MOVK  X21, #0x10, LSL #32
    MOVK  X21, #0x6070, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D15
    MOVZ  X21, #0x1c1c, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D16
    MOVZ  X21, #0x5a7a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X21, #0x5050, LSL #0
    MOVK  X21, #0x5000, LSL #16
    MOVK  X21, #0x5050, LSL #32
    MOVK  X21, #0x5050, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D17
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5050, LSL #32
    MOVK  X21, #0x5050, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D18
    MOVZ  X21, #0x4022, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D19
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0xb0b0, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D20
    MOVZ  X21, #0x8282, LSL #0
    MOVK  X21, #0x2382, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D21
    MOVZ  X21, #0x55ab, LSL #0
    MOVK  X21, #0xa3fe, LSL #16
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X21, #0x104, LSL #0
    MOVK  X21, #0x702, LSL #32
    MOVK  X21, #0x206, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D22
    MOVZ  X21, #0x602, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D23
    MOVZ  X21, #0x94, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D24
    MOVZ  X21, #0x1c1c, LSL #0
    MOVK  X21, #0xa07, LSL #32
    MOVK  X21, #0xaed, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D25
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5c02, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5c02, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X21, #0x25, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D26
    MOVZ  X21, #0x5a7a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a7a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x54, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x54, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D27
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x54, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x54, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D28
    MOVZ  X21, #0x9494, LSL #0
    MOVK  X21, #0x9494, LSL #16
    MOVK  X21, #0x9f80, LSL #32
    MOVK  X21, #0x1f9f, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X21, #0x6c00, LSL #0
    MOVK  X21, #0x6bff, LSL #16
    MOVK  X21, #0x6c00, LSL #32
    MOVK  X21, #0x6bff, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D30
    MOVZ  X21, #0x840a, LSL #0
    MOVK  X21, #0x5aa5, LSL #16
    MOVK  X21, #0x5a00, LSL #32
    MOVK  X21, #0x5a00, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X27, D31
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X4
    FMOV  V3.D[1], X8
    FMOV  D4, X20
    FMOV  V4.D[1], X9
    FMOV  D5, X8
    FMOV  V5.D[1], X21
    FMOV  D6, X22
    FMOV  V6.D[1], X2
    FMOV  D7, X20
    FMOV  V7.D[1], X5
    FMOV  D8, X3
    FMOV  V8.D[1], X25
    FMOV  D9, X16
    FMOV  V9.D[1], X24
    FMOV  D10, X17
    FMOV  V10.D[1], X16
    FMOV  D11, X4
    FMOV  V11.D[1], X18
    FMOV  D12, X28
    FMOV  V12.D[1], X9
    FMOV  D13, X3
    FMOV  V13.D[1], X4
    FMOV  D14, X19
    FMOV  V14.D[1], X22
    FMOV  D15, X5
    FMOV  V15.D[1], X5
    FMOV  D16, X22
    FMOV  V16.D[1], X8
    FMOV  D17, X26
    FMOV  V17.D[1], X8
    FMOV  D18, X27
    FMOV  V18.D[1], X20
    FMOV  D19, X20
    FMOV  V19.D[1], X18
    FMOV  D20, X24
    FMOV  V20.D[1], X25
    FMOV  D21, X28
    FMOV  V21.D[1], X17
    FMOV  D22, X17
    FMOV  V22.D[1], X3
    FMOV  D23, X21
    FMOV  V23.D[1], X9
    FMOV  D24, X20
    FMOV  V24.D[1], X23
    FMOV  D25, X6
    FMOV  V25.D[1], X18
    FMOV  D26, X19
    FMOV  V26.D[1], X18
    FMOV  D27, X20
    FMOV  V27.D[1], X18
    FMOV  D28, X3
    FMOV  V28.D[1], X6
    FMOV  D29, X28
    FMOV  V29.D[1], X28
    FMOV  D30, X8
    FMOV  V30.D[1], X28
    FMOV  D31, X8
    FMOV  V31.D[1], X12
    MOVZ  X22, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_9:
    SRI  V23.4H, V30.4H, #12
    ORR  V15.16B, V24.16B, V7.16B
    MOV S23, V25.S[0x2]
    BIT  V3.16B, V23.16B, V23.16B
    RSHRN2 V9.16B, V28.8H, #3
    DUP V5.2D, X16
    TBL  V11.8B, { V23.16B, V24.16B, V25.16B, V26.16B }, V29.8B
    EXT  V21.16B, V21.16B, V11.16B, #0x2
    BIC  V20.8B, V3.8B, V24.8B
    MOV V17.H[0x0], V15.H[0x1]
    ADD  V10.2S, V21.2S, V21.2S
    MOV B7, V5.B[0x5]
    DUP  V0.8B, V7.B[0x3]
    PMUL  V16.8B, V10.8B, V31.8B
    DUP S11, V20.S[0x3]
    MLS  V24.8H, V0.8H, V17.8H
    REV32  V10.8B, V19.8B
    SHRN V6.2S, V27.2D, #27
    ADDV  S21, V0.4S
    ADDV  H7, V9.4H
    MUL  V0.4H, V10.4H, V11.H[0x1]
    ZIP1  V26.8B, V7.8B, V6.8B
    SHL  V23.8H, V27.8H, #0x7
    CNT  V19.8B, V0.8B
    EOR  V15.16B, V19.16B, V31.16B
    EXT  V3.16B, V16.16B, V15.16B, #0xe
    REV32  V11.4H, V21.4H
    BIC  V9.8B, V24.8B, V21.8B
    DUP D21, V19.D[0x0]
    RBIT  V10.16B, V26.16B
    BIF  V15.16B, V11.16B, V3.16B
    INS V27.H[0x7], V9.H[0x5]
    ZIP2  V24.2S, V21.2S, V7.2S
    REV64  V19.8H, V27.8H
    TBL  V9.16B, { V19.16B }, V2.16B
    SHRN V6.4H, V10.4S, #13
    SLI  V0.4H, V9.4H, #0x2
    RSHRN V16.4H, V6.4S, #16
    SHLL2  V6.4S, V0.8H, #16
    MOV D19, V12.D[0x0]
    AND  V9.16B, V8.16B, V0.16B
    DUP V0.2S, W26
    MOV  V26.16B, V7.16B
    INS V21.H[0x0], V18.H[0x5]
    MOVI  V3.16B, #0xd4
    ADD  V24.2D, V1.2D, V15.2D
    SRI  V7.4S, V9.4S, #32
    BIT  V30.16B, V15.16B, V24.16B
    BIC  V1.4H, #0xa0, LSL #8
    TBX  V31.16B, { V5.16B, V6.16B, V7.16B, V8.16B }, V19.16B
    TBL  V28.16B, { V26.16B }, V0.16B
    SHLL2  V6.8H, V27.16B, #8
    SRI  V26.8B, V23.8B, #2
    SHLL  V0.4S, V21.4H, #16
    ADDP  V23.8B, V16.8B, V28.8B
    BIF  V19.16B, V30.16B, V6.16B
    EXT  V22.8B, V2.8B, V19.8B, #0x1
    RSHRN V18.4H, V26.4S, #16
    RSUBHN  V28.8B, V0.8H, V31.8H
    PMUL  V26.8B, V1.8B, V18.8B
    SRI  V18.8B, V23.8B, #3
    TBX  V9.8B, { V17.16B }, V28.8B
    AESIMC  V10.16B, V1.16B
    RSHRN2 V9.4S, V26.2D, #10
    AND  V19.16B, V3.16B, V0.16B
    SUB  V16.4S, V14.4S, V18.4S
    TBX  V23.16B, { V10.16B, V11.16B, V12.16B, V13.16B }, V22.16B
    ORR  V31.16B, V23.16B, V23.16B
    REV64  V1.2S, V31.2S
    ZIP1  V16.8H, V8.8H, V9.8H
    SHRN2 V7.8H, V16.4S, #16
    ABS  V2.8B, V1.8B
    UZP2  V3.4H, V23.4H, V7.4H
    MOV V30.H[0x6], W26
    RADDHN  V23.4H, V3.4S, V5.4S
    RSHRN2 V24.4S, V1.2D, #15
    ADDV  S7, V2.4S
    SRI  V0.8H, V23.8H, #3
    BIC  V16.8B, V19.8B, V0.8B
    MOV H2, V16.H[0x7]
    MVN  V18.8B, V30.8B
    SUBHN2  V6.4S, V31.2D, V24.2D
    MOV D19, V7.D[0x1]
    RSUBHN2  V0.16B, V22.8H, V18.8H
    NEG  V31.4S, V19.4S
    EOR  V10.16B, V2.16B, V31.16B
    TBL  V26.8B, { V10.16B }, V11.8B
    ZIP2  V10.4H, V17.4H, V6.4H
    RSHRN2 V1.16B, V18.8H, #3
    EXT  V22.16B, V2.16B, V23.16B, #0x1
    REV32  V15.4H, V9.4H
    CNT  V18.16B, V4.16B
    SRI  V14.4S, V22.4S, #20
    CNT  V31.8B, V24.8B
    RSUBHN  V8.2S, V0.2D, V31.2D
    BIT  V22.8B, V14.8B, V15.8B
    INS V9.S[0x1], V3.S[0x1]
    TBL  V11.8B, { V8.16B, V9.16B, V10.16B }, V13.8B
    ADDV  B30, V19.8B
    TBX  V12.8B, { V0.16B, V1.16B, V2.16B }, V8.8B
    DUP V14.2D, V22.D[0x0]
    MVNI  V2.4H, #0x38
    PMULL  V6.1Q, V14.1D, V12.1D
    REV16  V11.16B, V16.16B
    INS V1.B[0x3], W9
    MLA  V10.4H, V26.4H, V1.H[0x1]
    MOV V16.D[0x0], X28
    SHL V17.2D, V10.2D, #0x35
    MOV V16.S[0x3], W5
    DUP  V17.2S, V30.S[0x2]
    RSHRN V31.4H, V18.4S, #4
    MVNI  V3.2S, #0xe2, MSL #8
    TBL  V23.8B, { V19.16B, V20.16B, V21.16B }, V5.8B
    DUP V5.2D, V31.D[0x1]
    MLA  V9.2S, V11.2S, V2.S[0x0]
    MOV D11, V0.D[0x0]
    MOV V26.B[0x8], W21
    MLS  V19.2S, V3.2S, V30.S[0x3]
    TBX  V22.16B, { V1.16B, V2.16B, V3.16B, V4.16B }, V16.16B
    DUP D4, V5.D[0x0]
    SHRN2 V16.8H, V19.4S, #3
    DUP B30, V17.B[0x9]
    EXT  V5.16B, V13.16B, V23.16B, #0x0
    MOV H1, V22.H[0x0]
    MVNI  V0.4S, #0xe3, MSL #8
    MOV V22.H[0x0], W27
    RSHRN V17.8B, V4.8H, #8
    MLS  V3.8H, V11.8H, V11.H[0x2]
    AND  V31.16B, V19.16B, V5.16B
    NOT  V11.8B, V26.8B
    SUB  V20.2D, V22.2D, V23.2D
    MOV H2, V17.H[0x7]
    MVNI  V19.8H, #0x9a, LSL #8
    DUP S25, V31.S[0x1]
    TBL  V23.16B, { V7.16B, V8.16B, V9.16B }, V25.16B
    EOR  V25.16B, V20.16B, V16.16B
    INS V14.S[0x3], V13.S[0x1]
    MLS  V8.8H, V0.8H, V0.H[0x4]
    CNT  V0.16B, V8.16B
    RSUBHN  V4.8B, V19.8H, V3.8H
    RSHRN2 V7.8H, V4.4S, #12
    NOT  V6.8B, V12.8B
    ORR  V9.4H, #0x12
    DUP V16.8B, W29
    MOV V3.D[0x0], X28
    RSUBHN  V26.2S, V0.2D, V25.2D
    BIC  V17.4H, #0xd4, LSL #8
    INS V25.S[0x1], W29
    ADD  V19.8H, V16.8H, V11.8H
    MOV  V27.8B, V6.8B
    ADDHN  V12.2S, V26.2D, V14.2D
    PMUL  V7.8B, V21.8B, V3.8B
    SLI  V21.4S, V23.4S, #0x14
    MOVI  V11.2D, #280375481860095
    SHRN2 V23.4S, V30.2D, #4
    INS V31.D[0x1], V27.D[0x1]
    CNT  V3.16B, V30.16B
    RSUBHN2  V10.16B, V25.8H, V23.8H
    ORN  V20.16B, V10.16B, V31.16B
    MOVI  V8.8H, #0x99
    AESE  V15.16B, V4.16B
    ORR  V25.8B, V7.8B, V21.8B
    RBIT  V23.16B, V8.16B
    MVNI  V8.8H, #0x65, LSL #8
    BIC  V16.8B, V2.8B, V12.8B
    MVNI  V14.4S, #0x49, LSL #24
    MUL  V7.8H, V8.8H, V8.H[0x0]
    MLS  V2.8H, V16.8H, V9.H[0x2]
    MUL  V14.4S, V11.4S, V19.S[0x0]
    MLS  V6.8H, V2.8H, V25.8H
    XTN  V3.8B, V30.8H
    SUBHN2  V20.16B, V22.8H, V8.8H
    MLA  V30.4H, V3.4H, V15.H[0x5]
    MUL  V10.8H, V14.8H, V6.H[0x4]
    ADDV  B11, V7.16B
    SLI  V8.2S, V8.2S, #0x1
    DUP  V14.8H, V30.H[0x2]
    ORR  V27.8B, V10.8B, V14.8B
    SRI V2.2D, V15.2D, #62
    SRI  V15.8B, V17.8B, #5
    XTN  V9.4H, V19.4S
    TRN1  V17.2S, V23.2S, V9.2S
    MOV V6.B[0xc], W12
    ADD  V26.2S, V15.2S, V10.2S
    BIF  V7.8B, V27.8B, V11.8B
    SLI  V25.4H, V21.4H, #0x8
    MOV  X9, V19.D[0x0]
    INS V20.H[0x3], W12
    SHLL2  V17.2D, V25.4S, #32
    MUL  V23.8H, V27.8H, V1.H[0x4]
    ADDHN  V14.4H, V26.4S, V17.4S
    INS V11.S[0x3], V28.S[0x0]
    INS V16.D[0x0], V14.D[0x0]
    EXT  V17.16B, V6.16B, V1.16B, #0xa
    MUL  V28.8B, V20.8B, V17.8B
    INS V20.B[0xf], W7
    CNT  V22.8B, V16.8B
    RSHRN2 V25.4S, V28.2D, #15
    TBX  V16.16B, { V20.16B }, V20.16B
    RSUBHN  V19.2S, V22.2D, V22.2D
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_9
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a4, LSL #0
    MOVK  X8, #0xa5a4, LSL #16
    MOVK  X8, #0xa5a4, LSL #32
    MOVK  X8, #0xa5a4, LSL #48
    SUB  X24, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X24, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X8, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x300, LSL #16
    MOVK  X24, #0x300, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D0
    MOVZ  X24, #0x204, LSL #0
    MOVK  X24, #0x204, LSL #16
    MOVK  X24, #0x300, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X24, #0x1, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D2
    MOVZ  X24, #0x1, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D4
    MOVZ  X24, #0x5e8, LSL #0
    MOVK  X24, #0x5e8, LSL #16
    MOVK  X24, #0x6666, LSL #32
    MOVK  X24, #0x6666, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D5
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5, LSL #32
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D6
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x4b4b, LSL #32
    MOVK  X24, #0x4b4b, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D8
    MOVZ  X24, #0x35ff, LSL #0
    MOVK  X24, #0x35ff, LSL #16
    MOVK  X24, #0x35ff, LSL #32
    MOVK  X24, #0x35ff, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D9
    MOVZ  X24, #0xa5a4, LSL #0
    MOVK  X24, #0xa5a4, LSL #16
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D11
    MOVZ  X24, #0x58, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D12
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x300, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D13
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D14
    MOVZ  X24, #0x6060, LSL #0
    MOVK  X24, #0x6860, LSL #16
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D15
    MOVZ  X24, #0x3098, LSL #0
    MOVK  X24, #0x6060, LSL #16
    MOVK  X24, #0x6030, LSL #32
    MOVK  X24, #0x6860, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X24, #0x65, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D16
    MOVZ  X24, #0x6060, LSL #0
    MOVK  X24, #0x6860, LSL #16
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D17
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5, LSL #16
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D18
    MOVZ  X24, #0x204, LSL #0
    MOVK  X24, #0x204, LSL #16
    MOVK  X24, #0x404, LSL #32
    MOVK  X24, #0x404, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X24, #0x650a, LSL #0
    MOVK  X24, #0x6565, LSL #16
    MOVK  X24, #0x6565, LSL #32
    MOVK  X24, #0xa565, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D20
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D22
    MOVZ  X24, #0x202, LSL #0
    MOVK  X24, #0x302, LSL #16
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X24, #0xb6, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D26
    MOVZ  X24, #0x3098, LSL #0
    MOVK  X24, #0x6060, LSL #16
    MOVK  X24, #0x6030, LSL #32
    MOVK  X24, #0x6860, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D28
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5b, LSL #16
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D29
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X8, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x6f2a, LSL #0
    MOVK  X2, #0x13b3, LSL #16
    MOVK  X2, #0x55f4, LSL #32
    MOVK  X2, #0x2f51, LSL #48
    MOVZ  X3, #0x9454, LSL #0
    MOVK  X3, #0x51b1, LSL #16
    MOVK  X3, #0x1b6d, LSL #32
    MOVK  X3, #0x7e36, LSL #48
    MOVZ  X4, #0x9376, LSL #0
    MOVK  X4, #0x3cd, LSL #16
    MOVK  X4, #0x1c44, LSL #32
    MOVK  X4, #0x20bd, LSL #48
    MOVZ  X5, #0x4c2c, LSL #0
    MOVK  X5, #0xe279, LSL #16
    MOVK  X5, #0xab4, LSL #32
    MOVK  X5, #0x2bb3, LSL #48
    MOVZ  X6, #0x8005, LSL #0
    MOVK  X6, #0xddd4, LSL #16
    MOVK  X6, #0x1856, LSL #32
    MOVK  X6, #0x5e81, LSL #48
    MOVZ  X7, #0xb10, LSL #0
    MOVK  X7, #0x4c24, LSL #16
    MOVK  X7, #0xaf41, LSL #32
    MOVK  X7, #0x7856, LSL #48
    MOVZ  X8, #0x3c08, LSL #0
    MOVK  X8, #0x3d3f, LSL #16
    MOVK  X8, #0x73e4, LSL #32
    MOVK  X8, #0x39fc, LSL #48
    MOVZ  X9, #0xfd45, LSL #0
    MOVK  X9, #0x5bf, LSL #16
    MOVK  X9, #0x592d, LSL #32
    MOVK  X9, #0x4159, LSL #48
    MOVZ  X12, #0xbe59, LSL #0
    MOVK  X12, #0xb1e8, LSL #16
    MOVK  X12, #0x14f6, LSL #32
    MOVK  X12, #0x7d27, LSL #48
    MOVZ  X16, #0x630c, LSL #0
    MOVK  X16, #0x26dc, LSL #16
    MOVK  X16, #0x8023, LSL #32
    MOVK  X16, #0xa163, LSL #48
    MOVZ  X17, #0xf78c, LSL #0
    MOVK  X17, #0x1323, LSL #16
    MOVK  X17, #0x8337, LSL #32
    MOVK  X17, #0x703, LSL #48
    MOVZ  X18, #0x62f4, LSL #0
    MOVK  X18, #0x745a, LSL #16
    MOVK  X18, #0xecec, LSL #32
    MOVK  X18, #0x4c04, LSL #48
    MOVZ  X19, #0xac72, LSL #0
    MOVK  X19, #0x60e8, LSL #16
    MOVK  X19, #0xc45a, LSL #32
    MOVK  X19, #0x79ea, LSL #48
    MOVZ  X20, #0x3a2b, LSL #0
    MOVK  X20, #0xf651, LSL #16
    MOVK  X20, #0x7220, LSL #32
    MOVK  X20, #0x9405, LSL #48
    MOVZ  X21, #0x3156, LSL #0
    MOVK  X21, #0x8de, LSL #16
    MOVK  X21, #0x6e31, LSL #32
    MOVK  X21, #0xfd71, LSL #48
    MOVZ  X22, #0x61e5, LSL #0
    MOVK  X22, #0x52bb, LSL #16
    MOVK  X22, #0xbceb, LSL #32
    MOVK  X22, #0x4f37, LSL #48
    MOVZ  X23, #0xb601, LSL #0
    MOVK  X23, #0x4eba, LSL #16
    MOVK  X23, #0x7254, LSL #32
    MOVK  X23, #0x2205, LSL #48
    MOVZ  X24, #0xcdd9, LSL #0
    MOVK  X24, #0xb267, LSL #16
    MOVK  X24, #0x6abe, LSL #32
    MOVK  X24, #0xb9d2, LSL #48
    MOVZ  X25, #0x9664, LSL #0
    MOVK  X25, #0xa311, LSL #16
    MOVK  X25, #0x4a1b, LSL #32
    MOVK  X25, #0xc0dc, LSL #48
    MOVZ  X26, #0x716b, LSL #0
    MOVK  X26, #0xd228, LSL #16
    MOVK  X26, #0x60ab, LSL #32
    MOVK  X26, #0x5fd8, LSL #48
    MOVZ  X27, #0xec2f, LSL #0
    MOVK  X27, #0x1e3e, LSL #16
    MOVK  X27, #0x5981, LSL #32
    MOVK  X27, #0x55aa, LSL #48
    MOVZ  X28, #0xe4e7, LSL #0
    MOVK  X28, #0xd8ed, LSL #16
    MOVK  X28, #0x34d6, LSL #32
    MOVK  X28, #0x492, LSL #48
    MOVZ  X29, #0xe22e, LSL #0
    MOVK  X29, #0x2bfb, LSL #16
    MOVK  X29, #0xf3a4, LSL #32
    MOVK  X29, #0x72a3, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X7
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X27
    FMOV  D3, X5
    FMOV  V3.D[1], X26
    FMOV  D4, X17
    FMOV  V4.D[1], X7
    FMOV  D5, X29
    FMOV  V5.D[1], X4
    FMOV  D6, X25
    FMOV  V6.D[1], X23
    FMOV  D7, X21
    FMOV  V7.D[1], X12
    FMOV  D8, X18
    FMOV  V8.D[1], X3
    FMOV  D9, X23
    FMOV  V9.D[1], X21
    FMOV  D10, X17
    FMOV  V10.D[1], X2
    FMOV  D11, X26
    FMOV  V11.D[1], X29
    FMOV  D12, X18
    FMOV  V12.D[1], X4
    FMOV  D13, X16
    FMOV  V13.D[1], X16
    FMOV  D14, X19
    FMOV  V14.D[1], X4
    FMOV  D15, X16
    FMOV  V15.D[1], X27
    FMOV  D16, X24
    FMOV  V16.D[1], X8
    FMOV  D17, X12
    FMOV  V17.D[1], X29
    FMOV  D18, X8
    FMOV  V18.D[1], X18
    FMOV  D19, X19
    FMOV  V19.D[1], X17
    FMOV  D20, X16
    FMOV  V20.D[1], X3
    FMOV  D21, X19
    FMOV  V21.D[1], X7
    FMOV  D22, X3
    FMOV  V22.D[1], X2
    FMOV  D23, X29
    FMOV  V23.D[1], X20
    FMOV  D24, X21
    FMOV  V24.D[1], X5
    FMOV  D25, X28
    FMOV  V25.D[1], X4
    FMOV  D26, X7
    FMOV  V26.D[1], X8
    FMOV  D27, X27
    FMOV  V27.D[1], X5
    FMOV  D28, X6
    FMOV  V28.D[1], X2
    FMOV  D29, X16
    FMOV  V29.D[1], X2
    FMOV  D30, X19
    FMOV  V30.D[1], X22
    FMOV  D31, X26
    FMOV  V31.D[1], X7
    MOVZ  X20, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_10:
    SHL  V7.4S, V24.4S, #0x1b
    ABS  V29.4S, V10.4S
    INS V7.D[0x1], V22.D[0x1]
    MUL  V21.8H, V27.8H, V0.H[0x5]
    MUL  V3.4S, V30.4S, V30.S[0x1]
    BIT  V12.8B, V13.8B, V3.8B
    ADDV  H14, V8.8H
    MOV  W22, V22.S[0x1]
    MOV V8.S[0x0], W5
    XTN  V24.4H, V21.4S
    ZIP1  V0.2D, V31.2D, V31.2D
    DUP V29.8B, W12
    ORR  V23.4S, #0xe6
    TBX  V12.16B, { V28.16B, V29.16B, V30.16B, V31.16B }, V20.16B
    RSHRN V25.8B, V0.8H, #7
    RADDHN2  V24.16B, V25.8H, V7.8H
    MLA  V28.8B, V30.8B, V12.8B
    ADD  V17.2S, V3.2S, V8.2S
    TRN2  V10.4S, V24.4S, V28.4S
    SRI  V24.2S, V29.2S, #25
    REV16  V22.16B, V17.16B
    INS V25.D[0x1], V14.D[0x1]
    CNT  V14.16B, V23.16B
    MUL  V11.2S, V20.2S, V9.2S
    DUP V11.4H, W8
    MUL  V13.8B, V5.8B, V10.8B
    RADDHN2  V29.16B, V14.8H, V24.8H
    CNT  V7.16B, V8.16B
    SHLL  V10.8H, V18.8B, #8
    XTN2  V28.4S, V11.2D
    PMULL  V14.8H, V16.8B, V29.8B
    SHRN V24.4H, V17.4S, #3
    RSUBHN2  V9.16B, V10.8H, V28.8H
    EXT  V8.8B, V7.8B, V7.8B, #0x6
    RSHRN V20.2S, V22.2D, #19
    PMULL2  V21.8H, V20.16B, V9.16B
    AESMC  V31.16B, V23.16B
    SLI  V7.4H, V16.4H, #0x6
    SLI  V12.8H, V24.8H, #0x5
    MOV V22.S[0x0], V14.S[0x0]
    DUP V23.2S, W23
    MOV V13.S[0x0], W12
    SRI  V11.8H, V13.8H, #13
    ADDP  V11.2D, V9.2D, V23.2D
    MUL  V15.2S, V25.2S, V25.S[0x3]
    MOV V16.S[0x2], W4
    RSUBHN  V20.4H, V21.4S, V19.4S
    SHRN V10.2S, V14.2D, #19
    DUP  V17.8H, V4.H[0x4]
    RSHRN2 V19.16B, V27.8H, #2
    TBL  V23.16B, { V11.16B, V12.16B }, V1.16B
    MVN  V9.8B, V22.8B
    MLS  V18.8H, V27.8H, V14.H[0x5]
    AESMC  V7.16B, V3.16B
    RSHRN2 V1.4S, V23.2D, #3
    UZP1  V13.4S, V15.4S, V19.4S
    INS V30.H[0x6], W21
    EXT  V27.8B, V1.8B, V27.8B, #0x4
    DUP  V25.2S, V18.S[0x0]
    MUL  V1.16B, V24.16B, V19.16B
    BSL  V3.8B, V10.8B, V6.8B
    MLA  V14.2S, V27.2S, V17.S[0x1]
    MUL  V6.8H, V13.8H, V3.H[0x6]
    MUL  V3.8H, V31.8H, V14.H[0x7]
    SHRN2 V12.4S, V20.2D, #11
    INS V18.D[0x1], X18
    TRN2  V31.8H, V1.8H, V3.8H
    AESE  V10.16B, V31.16B
    MOV V1.S[0x3], V9.S[0x3]
    BIC  V17.8B, V10.8B, V30.8B
    SRI  V20.4S, V24.4S, #18
    ADDV  H19, V1.8H
    ORN  V29.8B, V16.8B, V19.8B
    PMULL  V15.1Q, V20.1D, V20.1D
    SLI  V3.4H, V10.4H, #0xf
    ADD  V30.4S, V22.4S, V18.4S
    CNT  V20.16B, V8.16B
    AESE  V9.16B, V6.16B
    SRI  V6.8H, V28.8H, #3
    XTN  V14.2S, V7.2D
    SHRN V24.2S, V14.2D, #31
    MOV V23.H[0x3], V24.H[0x7]
    MVN  V31.8B, V15.8B
    SHRN2 V18.4S, V6.2D, #4
    ADDP  V24.16B, V25.16B, V9.16B
    CLZ  V19.8B, V27.8B
    CLZ  V15.4S, V30.4S
    SLI V28.2D, V18.2D, #0x17
    EOR  V8.8B, V29.8B, V28.8B
    RSHRN2 V29.16B, V8.8H, #4
    BIC  V16.4H, #0x53, LSL #8
    INS V10.D[0x0], V23.D[0x0]
    SHRN2 V2.8H, V20.4S, #9
    NOT  V30.8B, V16.8B
    RSUBHN2  V14.16B, V30.8H, V30.8H
    MLS  V1.4S, V15.4S, V3.4S
    RSHRN V20.8B, V19.8H, #1
    ADDV  H27, V4.4H
    DUP  V6.4S, V27.S[0x1]
    UZP1  V3.4S, V20.4S, V17.4S
    ADDHN  V19.8B, V24.8H, V6.8H
    MLS  V20.4H, V13.4H, V8.H[0x7]
    RADDHN2  V16.4S, V4.2D, V19.2D
    ADDV  S14, V1.4S
    RSHRN2 V4.4S, V3.2D, #12
    SRI  V28.4H, V31.4H, #1
    DUP D27, V28.D[0x0]
    BSL  V24.8B, V20.8B, V4.8B
    TBL  V11.8B, { V3.16B, V4.16B, V5.16B }, V16.8B
    MOV  V14.8B, V14.8B
    AND  V31.8B, V2.8B, V27.8B
    ORN  V2.8B, V2.8B, V3.8B
    MUL  V13.8H, V14.8H, V2.H[0x0]
    MUL  V14.4H, V11.4H, V19.4H
    EXT  V2.16B, V31.16B, V29.16B, #0x6
    RSHRN V8.2S, V21.2D, #12
    BIC  V15.4H, #0x51
    SHL  V6.4H, V28.4H, #0xa
    BIF  V7.8B, V1.8B, V6.8B
    MLA  V11.8H, V20.8H, V15.H[0x0]
    TBX  V23.8B, { V8.16B, V9.16B, V10.16B }, V20.8B
    MOV D19, V23.D[0x1]
    RADDHN  V16.4H, V24.4S, V24.4S
    RSHRN V21.2S, V14.2D, #28
    SLI  V10.8B, V21.8B, #0x0
    MOV S17, V10.S[0x0]
    RSHRN2 V0.16B, V25.8H, #3
    MOV  X4, V0.D[0x1]
    RSUBHN  V8.4H, V11.4S, V16.4S
    MOV V29.B[0x2], V17.B[0x4]
    XTN  V14.8B, V0.8H
    SHRN2 V15.4S, V2.2D, #10
    BIC  V11.8B, V2.8B, V30.8B
    TBL  V9.16B, { V7.16B }, V17.16B
    DUP B0, V9.B[0x9]
    UZP1  V10.2D, V8.2D, V15.2D
    MVN  V16.16B, V11.16B
    SHRN2 V24.16B, V3.8H, #1
    SLI  V15.16B, V14.16B, #0x5
    MOV B20, V16.B[0x2]
    MLA  V8.16B, V15.16B, V13.16B
    ADDV  B11, V31.8B
    SHLL2  V25.4S, V1.8H, #16
    BIC  V3.16B, V29.16B, V20.16B
    MOVI  V19.4S, #0x92, MSL #16
    TBL  V1.16B, { V22.16B, V23.16B, V24.16B, V25.16B }, V3.16B
    NEG  V24.4S, V8.4S
    ORN  V9.16B, V19.16B, V19.16B
    INS V7.H[0x5], W24
    BIC  V19.8B, V0.8B, V28.8B
    SHRN2 V17.4S, V19.2D, #23
    RSHRN2 V27.8H, V29.4S, #16
    BIT  V16.16B, V19.16B, V9.16B
    MOVI  V19.4S, #0x81, MSL #16
    RSUBHN2  V21.8H, V11.4S, V2.4S
    INS V3.D[0x1], X24
    INS V27.B[0x4], W16
    EXT  V5.16B, V1.16B, V17.16B, #0xd
    ORR  V14.8H, #0xe0, LSL #8
    REV64  V31.4S, V14.4S
    AESIMC  V9.16B, V3.16B
    ADDP  V22.4S, V10.4S, V11.4S
    ABS  V25.16B, V4.16B
    EXT  V14.16B, V27.16B, V19.16B, #0x1
    DUP V11.2D, V5.D[0x1]
    MOV H1, V14.H[0x1]
    BIC  V19.2S, #0x29, LSL #24
    INS V28.H[0x5], W20
    MOVI  V23.8H, #0x78, LSL #8
    REV32  V5.8B, V16.8B
    AESE  V3.16B, V7.16B
    ZIP1  V24.16B, V13.16B, V25.16B
    INS V10.D[0x1], X27
    ADDHN2  V16.16B, V1.8H, V30.8H
    SHRN2 V14.8H, V3.4S, #12
    ZIP1  V21.16B, V7.16B, V9.16B
    SHRN V27.4H, V21.4S, #14
    BSL  V16.16B, V27.16B, V23.16B
    RSHRN2 V29.16B, V10.8H, #3
    DUP H22, V5.H[0x3]
    PMULL2  V3.8H, V16.16B, V24.16B
    ORR  V10.16B, V28.16B, V9.16B
    MOVI  V1.8H, #0x54, LSL #8
    MVNI  V7.8H, #0x6e
    REV32  V25.4H, V6.4H
    DUP H27, V3.H[0x6]
    DUP  V13.8H, V19.H[0x7]
    MLA  V23.4H, V17.4H, V1.H[0x4]
    ADDP  D11, V14.2D
    INS V1.S[0x2], W12
    ADDV  B6, V13.8B
    MOV V17.H[0x2], V28.H[0x2]
    MOV  V30.8B, V4.8B
    MLS  V5.8H, V25.8H, V13.H[0x5]
    TBL  V3.8B, { V5.16B, V6.16B }, V26.8B
    AESE  V28.16B, V16.16B
    NOT  V13.8B, V6.8B
    SHRN2 V14.4S, V7.2D, #32
    INS V24.B[0xe], W3
    MOV V19.D[0x0], V17.D[0x1]
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_10
    MOVZ  X28, #0x6f2a, LSL #0
    MOVK  X28, #0x13b3, LSL #16
    MOVK  X28, #0x55f4, LSL #32
    MOVK  X28, #0x2f51, LSL #48
    SUB  X6, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x9454, LSL #0
    MOVK  X28, #0x51b1, LSL #16
    MOVK  X28, #0x1b6d, LSL #32
    MOVK  X28, #0x7e36, LSL #48
    SUB  X6, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x1ec8, LSL #0
    MOVK  X28, #0x1ec8, LSL #16
    SUB  X6, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x4c2c, LSL #0
    MOVK  X28, #0xe279, LSL #16
    MOVK  X28, #0xab4, LSL #32
    MOVK  X28, #0x2bb3, LSL #48
    SUB  X6, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xb10, LSL #0
    MOVK  X28, #0x4c24, LSL #16
    MOVK  X28, #0xaf41, LSL #32
    MOVK  X28, #0x7856, LSL #48
    SUB  X6, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x3c08, LSL #0
    MOVK  X28, #0x3d3f, LSL #16
    MOVK  X28, #0x73e4, LSL #32
    MOVK  X28, #0x39fc, LSL #48
    SUB  X6, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xfd45, LSL #0
    MOVK  X28, #0x5bf, LSL #16
    MOVK  X28, #0x592d, LSL #32
    MOVK  X28, #0x4159, LSL #48
    SUB  X6, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xbe59, LSL #0
    MOVK  X28, #0xb1e8, LSL #16
    MOVK  X28, #0x14f6, LSL #32
    MOVK  X28, #0x7d27, LSL #48
    SUB  X6, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x630c, LSL #0
    MOVK  X28, #0x26dc, LSL #16
    MOVK  X28, #0x8023, LSL #32
    MOVK  X28, #0xa163, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xf78c, LSL #0
    MOVK  X28, #0x1323, LSL #16
    MOVK  X28, #0x8337, LSL #32
    MOVK  X28, #0x703, LSL #48
    SUB  X6, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x62f4, LSL #0
    MOVK  X28, #0x745a, LSL #16
    MOVK  X28, #0xecec, LSL #32
    MOVK  X28, #0x4c04, LSL #48
    SUB  X6, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x3156, LSL #0
    MOVK  X28, #0x8de, LSL #16
    MOVK  X28, #0x6e31, LSL #32
    MOVK  X28, #0xfd71, LSL #48
    SUB  X6, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xb601, LSL #0
    MOVK  X28, #0x4eba, LSL #16
    MOVK  X28, #0x7254, LSL #32
    MOVK  X28, #0x2205, LSL #48
    SUB  X6, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xcdd9, LSL #0
    MOVK  X28, #0xb267, LSL #16
    MOVK  X28, #0x6abe, LSL #32
    MOVK  X28, #0xb9d2, LSL #48
    SUB  X6, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x9664, LSL #0
    MOVK  X28, #0xa311, LSL #16
    MOVK  X28, #0x4a1b, LSL #32
    MOVK  X28, #0xc0dc, LSL #48
    SUB  X6, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0x716b, LSL #0
    MOVK  X28, #0xd228, LSL #16
    MOVK  X28, #0x60ab, LSL #32
    MOVK  X28, #0x5fd8, LSL #48
    SUB  X6, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xec2f, LSL #0
    MOVK  X28, #0x1e3e, LSL #16
    MOVK  X28, #0x5981, LSL #32
    MOVK  X28, #0x55aa, LSL #48
    SUB  X6, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X28, #0xe22e, LSL #0
    MOVK  X28, #0x2bfb, LSL #16
    MOVK  X28, #0xf3a4, LSL #32
    MOVK  X28, #0x72a3, LSL #48
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X28, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X6, #0xbe59, LSL #0
    MOVK  X6, #0xb1e8, LSL #16
    MOVK  X6, #0x5400, LSL #32
    MOVK  X6, #0x5400, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D1
    MOVZ  X6, #0x5400, LSL #0
    MOVK  X6, #0x5400, LSL #16
    MOVK  X6, #0x5400, LSL #32
    MOVK  X6, #0x5400, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X6, #0x4048, LSL #0
    MOVK  X6, #0x401, LSL #32
    MOVK  X6, #0x6, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D4
    MOVZ  X6, #0xf78c, LSL #0
    MOVK  X6, #0x1323, LSL #16
    MOVK  X6, #0x8337, LSL #32
    MOVK  X6, #0x703, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X6, #0xff91, LSL #0
    MOVK  X6, #0xff91, LSL #16
    MOVK  X6, #0xff91, LSL #32
    MOVK  X6, #0xff91, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D7
    MOVZ  X6, #0xff91, LSL #0
    MOVK  X6, #0xff91, LSL #16
    MOVK  X6, #0xff91, LSL #32
    MOVK  X6, #0xff91, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D8
    MOVZ  X6, #0xf27d, LSL #0
    MOVK  X6, #0x84, LSL #16
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X6, #0xf6ac, LSL #0
    MOVK  X6, #0x108b, LSL #16
    MOVK  X6, #0x5096, LSL #32
    MOVK  X6, #0xe69f, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D9
    MOVZ  X6, #0x1ae5, LSL #0
    MOVK  X6, #0x1ae5, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X6, #0xf6ac, LSL #0
    MOVK  X6, #0x108b, LSL #16
    MOVK  X6, #0x5096, LSL #32
    MOVK  X6, #0xe69f, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D10
    MOVZ  X6, #0xdff5, LSL #0
    MOVK  X6, #0x7ffd, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D11
    MOVZ  X6, #0xc8c0, LSL #0
    MOVK  X6, #0x7da, LSL #16
    MOVK  X6, #0xf5b0, LSL #32
    MOVK  X6, #0x2361, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D12
    MOVZ  X6, #0x7d14, LSL #0
    MOVK  X6, #0x5743, LSL #16
    MOVK  X6, #0x3, LSL #32
    MOVK  X6, #0x3, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D13
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X6, #0xff91, LSL #0
    MOVK  X6, #0xff91, LSL #16
    MOVK  X6, #0xff91, LSL #32
    MOVK  X6, #0xff91, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D14
    MOVZ  X6, #0x5ddd, LSL #0
    MOVK  X6, #0xc7f, LSL #16
    MOVK  X6, #0xff7f, LSL #32
    MOVK  X6, #0x1ff, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x1f00, LSL #32
    MOVK  X6, #0x1f1f, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X6, #0x2800, LSL #0
    MOVK  X6, #0x2800, LSL #16
    MOVK  X6, #0x7800, LSL #32
    MOVK  X6, #0x7800, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D16
    MOVZ  X6, #0x7800, LSL #0
    MOVK  X6, #0x7800, LSL #16
    MOVK  X6, #0x7800, LSL #32
    MOVK  X6, #0x7800, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D17
    MOVZ  X6, #0x6180, LSL #0
    MOVK  X6, #0x9605, LSL #16
    MOVK  X6, #0x7fff, LSL #32
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X6, #0xc155, LSL #0
    MOVK  X6, #0x71eb, LSL #16
    MOVK  X6, #0x1078, LSL #32
    MOVK  X6, #0x78, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D18
    MOVZ  X6, #0x8e42, LSL #0
    MOVK  X6, #0xa8f3, LSL #16
    MOVK  X6, #0xbdca, LSL #32
    MOVK  X6, #0xf0b8, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D20
    MOVZ  X6, #0xff, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X6, #0xff00, LSL #0
    MOVK  X6, #0xffa4, LSL #16
    MOVK  X6, #0xff00, LSL #32
    MOVK  X6, #0xff04, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D21
    MOVZ  X6, #0xe500, LSL #0
    MOVK  X6, #0x1a00, LSL #16
    MOVK  X6, #0xe500, LSL #32
    MOVK  X6, #0x1a10, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D23
    MOVZ  X6, #0x7800, LSL #0
    MOVK  X6, #0x1c00, LSL #16
    MOVK  X6, #0x7800, LSL #32
    MOVK  X6, #0x7800, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X6, #0x3700, LSL #0
    MOVK  X6, #0x7d00, LSL #16
    MOVK  X6, #0x300, LSL #32
    MOVK  X6, #0x754, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D24
    MOVZ  X6, #0x7400, LSL #0
    MOVK  X6, #0x900, LSL #16
    MOVK  X6, #0x2300, LSL #32
    MOVK  X6, #0x1380, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D25
    MOVZ  X6, #0x7400, LSL #0
    MOVK  X6, #0x5400, LSL #16
    MOVK  X6, #0xfc00, LSL #32
    MOVK  X6, #0xfc00, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X6, #0x3c08, LSL #0
    MOVK  X6, #0x3d3f, LSL #16
    MOVK  X6, #0x73e4, LSL #32
    MOVK  X6, #0x39fc, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D26
    MOVZ  X6, #0xb10, LSL #0
    MOVK  X6, #0x4c24, LSL #16
    MOVK  X6, #0xaf41, LSL #32
    MOVK  X6, #0x7856, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X6, #0xbc63, LSL #0
    MOVK  X6, #0x174c, LSL #16
    MOVK  X6, #0x663, LSL #32
    MOVK  X6, #0x3416, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D28
    MOVZ  X6, #0xc503, LSL #0
    MOVK  X6, #0xbc7c, LSL #16
    MOVK  X6, #0x3416, LSL #32
    MOVK  X6, #0xc563, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X6, #0x1150, LSL #0
    MOVK  X6, #0xc886, LSL #32
    MOVK  X6, #0xb530, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D29
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xff00, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D30
    MOVZ  X6, #0xf78c, LSL #0
    MOVK  X6, #0x1323, LSL #16
    MOVK  X6, #0x8337, LSL #32
    MOVK  X6, #0x703, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X6, #0xe000, LSL #0
    MOVK  X6, #0xe000, LSL #16
    MOVK  X6, #0xe000, LSL #32
    MOVK  X6, #0xe000, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X28, D31
    MOVZ  X6, #0xe8c8, LSL #0
    MOVK  X6, #0xe000, LSL #16
    MOVK  X6, #0xe0c8, LSL #32
    MOVK  X6, #0xe8c8, LSL #48
    SUB  X19, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
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
    FMOV  D0, X12
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X25
    FMOV  D2, X23
    FMOV  V2.D[1], X19
    FMOV  D3, X26
    FMOV  V3.D[1], X7
    FMOV  D4, X24
    FMOV  V4.D[1], X24
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X23
    FMOV  V6.D[1], X29
    FMOV  D7, X6
    FMOV  V7.D[1], X28
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X26
    FMOV  V9.D[1], X19
    FMOV  D10, X17
    FMOV  V10.D[1], X21
    FMOV  D11, X4
    FMOV  V11.D[1], X27
    FMOV  D12, X17
    FMOV  V12.D[1], X3
    FMOV  D13, X28
    FMOV  V13.D[1], X21
    FMOV  D14, X8
    FMOV  V14.D[1], X24
    FMOV  D15, X5
    FMOV  V15.D[1], X5
    FMOV  D16, X6
    FMOV  V16.D[1], X26
    FMOV  D17, X2
    FMOV  V17.D[1], X25
    FMOV  D18, X16
    FMOV  V18.D[1], X18
    FMOV  D19, X23
    FMOV  V19.D[1], X8
    FMOV  D20, X9
    FMOV  V20.D[1], X7
    FMOV  D21, X25
    FMOV  V21.D[1], X22
    FMOV  D22, X6
    FMOV  V22.D[1], X20
    FMOV  D23, X8
    FMOV  V23.D[1], X3
    FMOV  D24, X3
    FMOV  V24.D[1], X18
    FMOV  D25, X5
    FMOV  V25.D[1], X18
    FMOV  D26, X25
    FMOV  V26.D[1], X9
    FMOV  D27, X17
    FMOV  V27.D[1], X3
    FMOV  D28, X19
    FMOV  V28.D[1], X26
    FMOV  D29, X9
    FMOV  V29.D[1], X17
    FMOV  D30, X8
    FMOV  V30.D[1], X23
    FMOV  D31, X26
    FMOV  V31.D[1], X23
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_11:
    MOV V20.S[0x3], W23
    SHRN V0.2S, V20.2D, #3
    TRN1  V13.16B, V28.16B, V22.16B
    DUP  V8.16B, V24.B[0xa]
    SHRN2 V16.4S, V25.2D, #24
    ADD  V3.4H, V13.4H, V20.4H
    MOV S0, V0.S[0x2]
    SHLL  V26.8H, V16.8B, #8
    SRI  V12.16B, V29.16B, #7
    MOV V11.B[0x8], V8.B[0xd]
    MOV  V29.16B, V22.16B
    MVNI  V19.4S, #0xe, LSL #24
    SHRN V14.2S, V19.2D, #25
    SHRN V0.8B, V27.8H, #2
    SRI  V27.8B, V3.8B, #5
    CLZ  V15.4S, V11.4S
    TBL  V31.8B, { V0.16B, V1.16B, V2.16B }, V9.8B
    MOV  V11.8B, V30.8B
    CLS  V24.16B, V10.16B
    SRI  V16.8B, V24.8B, #7
    MOV D31, V25.D[0x1]
    RBIT  V22.16B, V16.16B
    REV64  V26.2S, V14.2S
    INS V16.B[0xa], V15.B[0x5]
    ORR  V0.2S, #0xaf
    TBL  V11.8B, { V25.16B, V26.16B, V27.16B, V28.16B }, V9.8B
    MUL  V20.4H, V0.4H, V11.H[0x4]
    UZP1  V17.8B, V22.8B, V16.8B
    INS V1.D[0x0], V16.D[0x1]
    INS V4.H[0x5], V21.H[0x1]
    SHL V23.2D, V22.2D, #0x0
    INS V3.S[0x1], V6.S[0x3]
    PMULL  V22.8H, V20.8B, V3.8B
    SRI  V26.8B, V31.8B, #6
    ADDP  D14, V22.2D
    AESIMC  V22.16B, V14.16B
    RSHRN2 V27.4S, V22.2D, #32
    AESE  V31.16B, V4.16B
    MOV V25.B[0x3], V16.B[0x6]
    RSHRN V6.4H, V25.4S, #8
    ADDP  V24.8B, V26.8B, V26.8B
    SHRN2 V20.16B, V23.8H, #1
    INS V4.S[0x2], W5
    TBL  V29.8B, { V29.16B, V30.16B, V31.16B }, V1.8B
    SHL  V16.4S, V17.4S, #0x18
    SRI  V22.8B, V4.8B, #3
    ADD  V26.8H, V24.8H, V16.8H
    SHRN V24.4H, V6.4S, #9
    MLA  V17.8H, V27.8H, V3.H[0x6]
    TBL  V4.16B, { V22.16B }, V26.16B
    MOV V6.H[0x0], W8
    MOV  X21, V4.D[0x0]
    MOVI  V23.8H, #0x96, LSL #8
    DUP S22, V17.S[0x2]
    MLA  V28.8H, V15.8H, V22.8H
    MOV D26, V6.D[0x0]
    INS V4.D[0x0], V26.D[0x1]
    ADDHN  V17.4H, V10.4S, V24.4S
    TRN1  V21.2D, V17.2D, V17.2D
    MOV V17.H[0x5], V28.H[0x3]
    SLI  V6.4H, V20.4H, #0x1
    MOV  V11.8B, V25.8B
    MLA  V26.4S, V21.4S, V18.S[0x1]
    PMUL  V14.16B, V4.16B, V23.16B
    SRI  V16.4S, V29.4S, #5
    ADDP  V9.4S, V11.4S, V23.4S
    MOV S28, V26.S[0x0]
    BIF  V27.8B, V17.8B, V28.8B
    RADDHN  V15.2S, V14.2D, V16.2D
    INS V22.D[0x0], V0.D[0x0]
    RSUBHN2  V29.16B, V6.8H, V16.8H
    SLI  V16.8H, V15.8H, #0x3
    RADDHN2  V11.8H, V22.4S, V10.4S
    MLA  V26.4H, V16.4H, V0.4H
    SHL  V4.8H, V20.8H, #0x2
    MOV V18.H[0x5], V6.H[0x1]
    MUL  V0.2S, V8.2S, V11.S[0x3]
    MOVI  V17.2D, #281474959933440
    DUP V21.4S, W5
    INS V24.B[0x9], W27
    MVNI  V9.2S, #0x86, MSL #8
    CLZ  V24.2S, V26.2S
    BIC  V20.8H, #0xbb
    MOV B15, V20.B[0x3]
    TBL  V8.16B, { V23.16B, V24.16B, V25.16B }, V0.16B
    DUP D13, V20.D[0x1]
    INS V24.D[0x1], V18.D[0x0]
    ZIP1  V22.8B, V17.8B, V2.8B
    EXT  V0.8B, V24.8B, V15.8B, #0x2
    CNT  V30.16B, V8.16B
    ZIP2  V2.8H, V22.8H, V4.8H
    RSHRN V4.4H, V30.4S, #5
    MOV V26.H[0x1], W9
    MUL  V24.8H, V12.8H, V2.H[0x7]
    MOV  W26, V3.S[0x3]
    CLS  V22.8H, V13.8H
    TRN2  V8.2D, V21.2D, V22.2D
    MOV V10.D[0x1], X16
    AESD  V25.16B, V24.16B
    DUP V13.2D, V25.D[0x1]
    EOR  V20.16B, V26.16B, V31.16B
    RSHRN2 V8.8H, V20.4S, #13
    MOV H24, V9.H[0x2]
    UZP1  V3.4H, V28.4H, V13.4H
    BSL  V18.8B, V10.8B, V3.8B
    MUL  V21.16B, V8.16B, V4.16B
    SHL V26.2D, V18.2D, #0x3d
    ADDP  D18, V26.2D
    SLI V25.2D, V24.2D, #0x19
    RSHRN V8.8B, V0.8H, #5
    UZP2  V3.2D, V7.2D, V8.2D
    PMULL  V7.8H, V18.8B, V17.8B
    UZP2  V0.16B, V0.16B, V9.16B
    INS V24.S[0x0], V17.S[0x0]
    MOV V22.S[0x2], W23
    TRN2  V26.8H, V0.8H, V21.8H
    SRI V8.2D, V20.2D, #13
    REV64  V17.4H, V21.4H
    CNT  V21.16B, V30.16B
    MOV V10.S[0x0], W25
    AESIMC  V20.16B, V24.16B
    UZP2  V13.2S, V2.2S, V20.2S
    UZP2  V0.2S, V26.2S, V22.2S
    TBL  V18.8B, { V17.16B, V18.16B }, V11.8B
    SLI  V24.2S, V0.2S, #0x1b
    MUL  V4.16B, V3.16B, V13.16B
    ADD  V18.2S, V6.2S, V25.2S
    TBX  V9.8B, { V31.16B, V0.16B, V1.16B, V2.16B }, V10.8B
    XTN2  V18.4S, V8.2D
    RSHRN2 V20.4S, V7.2D, #21
    TBL  V10.16B, { V20.16B, V21.16B }, V4.16B
    MVNI  V25.4S, #0xe4, MSL #16
    INS V6.S[0x0], W17
    MOV  X28, V6.D[0x0]
    MOV V22.S[0x0], V24.S[0x2]
    SHRN V21.2S, V28.2D, #27
    MOV V8.D[0x1], V9.D[0x0]
    ADDV  S24, V8.4S
    DUP V11.2D, V4.D[0x1]
    MOV V30.S[0x3], W18
    SHRN V1.2S, V24.2D, #3
    DUP V18.4S, W3
    ADDHN2  V26.8H, V30.4S, V2.4S
    RBIT  V9.8B, V25.8B
    TBL  V6.16B, { V6.16B }, V9.16B
    AESIMC  V4.16B, V11.16B
    INS V20.H[0x6], V4.H[0x4]
    MOV V30.S[0x2], V26.S[0x3]
    AND  V8.8B, V6.8B, V29.8B
    RSHRN2 V14.16B, V22.8H, #5
    BIT  V31.16B, V4.16B, V8.16B
    NOT  V26.16B, V30.16B
    DUP  V9.8B, V26.B[0xe]
    ZIP2  V6.4S, V9.4S, V21.4S
    INS V26.S[0x1], W5
    NOT  V28.8B, V26.8B
    DUP V26.2S, W21
    MLA  V21.16B, V18.16B, V6.16B
    ADDHN  V9.8B, V10.8H, V28.8H
    MVNI  V23.4S, #0x2b, LSL #16
    SHRN V4.2S, V20.2D, #1
    MVN  V30.16B, V1.16B
    BSL  V16.8B, V21.8B, V1.8B
    DUP V10.16B, W17
    ORR  V2.8B, V30.8B, V9.8B
    TBX  V8.8B, { V13.16B, V14.16B, V15.16B }, V6.8B
    MOV V18.H[0x2], W27
    MOV V14.H[0x7], W9
    RBIT  V28.8B, V26.8B
    TBX  V13.16B, { V5.16B, V6.16B, V7.16B }, V18.16B
    MUL  V21.8H, V2.8H, V4.H[0x0]
    ADDV  H15, V14.4H
    INS V11.H[0x3], V16.H[0x6]
    INS V26.B[0x7], V10.B[0x3]
    MOVI  V2.8B, #0xcc
    EXT  V1.8B, V25.8B, V26.8B, #0x2
    REV64  V3.2S, V30.2S
    SUB  V7.2D, V19.2D, V31.2D
    ADDP  V9.8B, V28.8B, V21.8B
    MLA  V7.8H, V1.8H, V13.8H
    DUP V11.2S, W23
    MOVI  V14.4S, #0x12, MSL #8
    ADD  V4.2D, V3.2D, V11.2D
    ZIP1  V10.2D, V8.2D, V8.2D
    ADDV  B19, V9.8B
    SLI  V20.8H, V19.8H, #0xd
    RSHRN2 V28.16B, V7.8H, #3
    INS V8.D[0x0], V2.D[0x1]
    TBL  V9.16B, { V29.16B, V30.16B, V31.16B }, V10.16B
    BIF  V16.16B, V9.16B, V8.16B
    ADDHN  V10.4H, V14.4S, V0.4S
    INS V30.H[0x3], W17
    DUP H15, V10.H[0x1]
    EXT  V25.8B, V28.8B, V7.8B, #0x5
    TBL  V19.16B, { V3.16B, V4.16B }, V20.16B
    RSUBHN2  V14.4S, V19.2D, V31.2D
    ZIP1  V6.2D, V25.2D, V30.2D
    REV32  V20.8B, V6.8B
    AND  V1.16B, V1.16B, V29.16B
    SHRN2 V9.8H, V20.4S, #16
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_11
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X20, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D0
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf, LSL #32
    MOVK  X7, #0xf, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D2
    MOVZ  X7, #0xcccc, LSL #0
    MOVK  X7, #0xcccc, LSL #16
    MOVK  X7, #0xcccc, LSL #32
    MOVK  X7, #0xcccc, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D3
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xca, LSL #32
    MOVK  X7, #0xe692, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D4
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xca, LSL #32
    MOVK  X7, #0xe692, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X7, #0xca, LSL #0
    MOVK  X7, #0xe692, LSL #16
    MOVK  X7, #0xffff, LSL #32
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D6
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xe900, LSL #16
    MOVK  X7, #0xb29c, LSL #32
    MOVK  X7, #0x178e, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X7, #0x9c9c, LSL #0
    MOVK  X7, #0x5de9, LSL #16
    MOVK  X7, #0xe99c, LSL #32
    MOVK  X7, #0xb6a4, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D7
    MOVZ  X7, #0x9ce9, LSL #0
    MOVK  X7, #0x8eb2, LSL #16
    MOVK  X7, #0x9c17, LSL #32
    MOVK  X7, #0xdb9c, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x9cb2, LSL #16
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D10
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf, LSL #16
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X7, #0x9c17, LSL #0
    MOVK  X7, #0xe99c, LSL #16
    MOVK  X7, #0xe99c, LSL #32
    MOVK  X7, #0xc4a4, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D14
    MOVZ  X7, #0x12ff, LSL #0
    MOVK  X7, #0x12ff, LSL #32
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D15
    MOVZ  X7, #0xf, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D19
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D20
    MOVZ  X7, #0xe9, LSL #0
    MOVK  X7, #0x8e17, LSL #32
    MOVK  X7, #0x9cb2, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D21
    MOVZ  X7, #0x6f2a, LSL #0
    MOVK  X7, #0xac42, LSL #16
    MOVK  X7, #0x345d, LSL #32
    MOVK  X7, #0x345d, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf, LSL #32
    MOVK  X7, #0xf, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D22
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf, LSL #32
    MOVK  X7, #0xf, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffd4, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffd4, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D23
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffd4, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffd4, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D24
    MOVZ  X7, #0xf9af, LSL #0
    MOVK  X7, #0xcb6f, LSL #16
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D25
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xe900, LSL #16
    MOVK  X7, #0xb29c, LSL #32
    MOVK  X7, #0x178e, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D27
    MOVZ  X7, #0xf, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X7, #0xd69d, LSL #0
    MOVK  X7, #0x7483, LSL #16
    MOVK  X7, #0xbd94, LSL #32
    MOVK  X7, #0xd534, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D30
    MOVZ  X7, #0xca, LSL #0
    MOVK  X7, #0xe692, LSL #16
    MOVK  X7, #0xffff, LSL #32
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X7, #0x6363, LSL #0
    MOVK  X7, #0x9416, LSL #16
    MOVK  X7, #0x1663, LSL #32
    MOVK  X7, #0x3b5b, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X20, D31
    MOVZ  X7, #0x6316, LSL #0
    MOVK  X7, #0x634d, LSL #16
    MOVK  X7, #0x63e8, LSL #32
    MOVK  X7, #0x1663, LSL #48
    SUB  X4, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X29
    FMOV  V3.D[1], X3
    FMOV  D4, X29
    FMOV  V4.D[1], X29
    FMOV  D5, X6
    FMOV  V5.D[1], X8
    FMOV  D6, X4
    FMOV  V6.D[1], X4
    FMOV  D7, X18
    FMOV  V7.D[1], X17
    FMOV  D8, X17
    FMOV  V8.D[1], X19
    FMOV  D9, X20
    FMOV  V9.D[1], X6
    FMOV  D10, X18
    FMOV  V10.D[1], X19
    FMOV  D11, X21
    FMOV  V11.D[1], X27
    FMOV  D12, X22
    FMOV  V12.D[1], X19
    FMOV  D13, X20
    FMOV  V13.D[1], X25
    FMOV  D14, X17
    FMOV  V14.D[1], X26
    FMOV  D15, X5
    FMOV  V15.D[1], X27
    FMOV  D16, X8
    FMOV  V16.D[1], X4
    FMOV  D17, X3
    FMOV  V17.D[1], X9
    FMOV  D18, X27
    FMOV  V18.D[1], X28
    FMOV  D19, X25
    FMOV  V19.D[1], X2
    FMOV  D20, X9
    FMOV  V20.D[1], X4
    FMOV  D21, X25
    FMOV  V21.D[1], X9
    FMOV  D22, X20
    FMOV  V22.D[1], X20
    FMOV  D23, X28
    FMOV  V23.D[1], X2
    FMOV  D24, X5
    FMOV  V24.D[1], X6
    FMOV  D25, X2
    FMOV  V25.D[1], X27
    FMOV  D26, X9
    FMOV  V26.D[1], X7
    FMOV  D27, X4
    FMOV  V27.D[1], X18
    FMOV  D28, X19
    FMOV  V28.D[1], X5
    FMOV  D29, X28
    FMOV  V29.D[1], X9
    FMOV  D30, X25
    FMOV  V30.D[1], X28
    FMOV  D31, X20
    FMOV  V31.D[1], X29
    MOVZ  X18, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_12:
    MOVI  V11.16B, #0x6b
    MOV V11.S[0x3], V25.S[0x2]
    MOVI  V8.8H, #0x36, LSL #8
    MVNI  V21.2S, #0xec, MSL #8
    MLA  V25.4H, V27.4H, V29.4H
    SLI  V21.8H, V6.8H, #0x3
    PMUL  V17.16B, V28.16B, V30.16B
    SUB  V13.8B, V21.8B, V23.8B
    PMUL  V23.8B, V27.8B, V25.8B
    MOV S25, V13.S[0x3]
    TBL  V30.16B, { V1.16B, V2.16B, V3.16B }, V19.16B
    SLI V3.2D, V10.2D, #0x1b
    AESIMC  V30.16B, V23.16B
    SRI  V7.8B, V30.8B, #4
    INS V23.B[0xd], W23
    XTN  V11.8B, V7.8H
    PMUL  V27.16B, V31.16B, V23.16B
    INS V4.B[0x1], V25.B[0x0]
    DUP  V13.8H, V30.H[0x3]
    MUL  V29.8H, V11.8H, V11.H[0x3]
    INS V8.D[0x1], X18
    SRI  V11.16B, V5.16B, #7
    MOV V28.H[0x2], V27.H[0x4]
    INS V0.S[0x0], W22
    MUL  V31.4H, V28.4H, V4.4H
    RSHRN2 V2.16B, V13.8H, #1
    ORR  V2.4H, #0xae
    DUP D27, V3.D[0x0]
    MLA  V19.8H, V18.8H, V2.H[0x2]
    MLA  V2.2S, V23.2S, V27.S[0x1]
    AESIMC  V10.16B, V18.16B
    UZP2  V5.2D, V0.2D, V19.2D
    ORR  V8.8B, V30.8B, V11.8B
    BIC  V30.16B, V4.16B, V11.16B
    TBX  V13.16B, { V30.16B, V31.16B }, V30.16B
    INS V3.S[0x2], W20
    DUP B23, V13.B[0x6]
    DUP  V31.8H, V5.H[0x2]
    TBX  V5.16B, { V22.16B, V23.16B, V24.16B }, V22.16B
    DUP  V23.8H, V13.H[0x1]
    RSHRN V13.8B, V10.8H, #4
    DUP V0.2D, X7
    SLI  V13.16B, V2.16B, #0x5
    EOR  V2.16B, V31.16B, V0.16B
    SHL  V13.8B, V5.8B, #0x3
    MLS  V31.8H, V2.8H, V1.H[0x5]
    TBL  V27.16B, { V25.16B, V26.16B }, V23.16B
    ZIP2  V22.8H, V26.8H, V15.8H
    MOV V29.H[0x5], V28.H[0x0]
    ADDV  H9, V31.4H
    SHLL2  V24.8H, V22.16B, #8
    CLS  V2.8B, V29.8B
    REV64  V29.4H, V2.4H
    DUP B11, V29.B[0xf]
    DUP V31.8B, W8
    ADDV  B23, V31.8B
    MOV V15.B[0x8], W5
    MLA  V0.4S, V15.4S, V11.4S
    ADDHN  V5.2S, V23.2D, V1.2D
    MOV S1, V4.S[0x1]
    SHL  V22.4S, V0.4S, #0x12
    CLS  V11.2S, V9.2S
    BIC  V29.16B, V29.16B, V13.16B
    AESD  V21.16B, V27.16B
    DUP  V15.4S, V16.S[0x1]
    DUP  V13.16B, V9.B[0x4]
    RADDHN2  V14.4S, V11.2D, V1.2D
    SLI  V10.8B, V14.8B, #0x0
    EXT  V14.8B, V31.8B, V10.8B, #0x1
    MLA  V0.4H, V17.4H, V10.H[0x6]
    MOVI  V23.2D, #18374687574888284415
    MVN  V1.8B, V29.8B
    MLS  V0.8H, V23.8H, V8.H[0x3]
    TBX  V10.8B, { V0.16B, V1.16B }, V22.8B
    AESIMC  V8.16B, V24.16B
    SLI  V17.8B, V28.8B, #0x6
    DUP  V24.8H, V30.H[0x3]
    DUP D23, V14.D[0x1]
    SHL  V28.8H, V24.8H, #0x2
    INS V25.D[0x1], X3
    MOVI  V4.2D, #1099511562495
    ADD  V18.4H, V15.4H, V8.4H
    RSHRN V18.4H, V21.4S, #5
    ADDV  H29, V10.4H
    AESMC  V10.16B, V29.16B
    CLS  V11.16B, V5.16B
    XTN2  V31.4S, V11.2D
    SRI  V12.8H, V25.8H, #8
    SHRN2 V5.4S, V12.2D, #10
    RSHRN2 V0.8H, V16.4S, #13
    TRN1  V16.4S, V23.4S, V31.4S
    ADDHN  V12.4H, V10.4S, V11.4S
    MOV V25.H[0x0], V13.H[0x2]
    MOV D22, V6.D[0x0]
    SHL  V30.8B, V16.8B, #0x5
    ADDV  S29, V22.4S
    ADDP  V23.2S, V28.2S, V4.2S
    MLA  V27.8H, V18.8H, V5.8H
    SHL  V17.4H, V10.4H, #0x0
    SHRN V7.8B, V12.8H, #2
    BIF  V6.8B, V25.8B, V0.8B
    SHL  V8.4S, V29.4S, #0x11
    SRI V21.2D, V8.2D, #9
    DUP V8.8B, W6
    RSHRN2 V13.16B, V7.8H, #1
    DUP B4, V17.B[0x7]
    MUL  V7.4S, V4.4S, V13.4S
    EXT  V17.8B, V27.8B, V30.8B, #0x6
    SUBHN2  V0.4S, V17.2D, V17.2D
    BIC  V11.16B, V22.16B, V8.16B
    INS V10.H[0x3], V28.H[0x0]
    ADDV  H16, V31.8H
    MOV D25, V23.D[0x1]
    TBL  V4.16B, { V10.16B, V11.16B }, V7.16B
    ADDP  D17, V21.2D
    ADDV  S8, V23.4S
    DUP V18.16B, W4
    ADDV  B15, V4.8B
    RADDHN  V30.8B, V8.8H, V29.8H
    MOVI  V31.4S, #0x18
    NOT  V13.8B, V19.8B
    ADD  V29.16B, V11.16B, V7.16B
    TBX  V9.8B, { V30.16B, V31.16B, V0.16B }, V0.8B
    INS V17.S[0x2], V6.S[0x1]
    UZP2  V21.4S, V12.4S, V16.4S
    MUL  V28.4S, V21.4S, V13.S[0x1]
    ADDV  H2, V28.4H
    MOV V7.B[0x9], W12
    AND  V6.8B, V7.8B, V29.8B
    SUBHN2  V8.4S, V18.2D, V2.2D
    SHL V16.2D, V25.2D, #0x1f
    MOV V23.S[0x1], W22
    MOVI  V19.2D, #18374686483949879040
    MOV  V10.16B, V6.16B
    RSHRN2 V12.4S, V16.2D, #29
    ZIP2  V18.2D, V12.2D, V17.2D
    ADDHN  V22.4H, V18.4S, V19.4S
    MOV V16.S[0x3], W8
    TRN2  V12.8B, V22.8B, V8.8B
    RSHRN2 V17.8H, V31.4S, #2
    SRI  V25.4S, V31.4S, #1
    DUP V29.8B, W28
    INS V7.B[0x2], V9.B[0x0]
    BSL  V9.8B, V17.8B, V27.8B
    MLS  V2.4S, V12.4S, V23.S[0x0]
    SHRN V9.2S, V7.2D, #10
    RSHRN2 V0.16B, V26.8H, #8
    MOV D6, V28.D[0x0]
    TBX  V28.8B, { V4.16B, V5.16B, V6.16B }, V6.8B
    ADDHN2  V27.4S, V28.2D, V11.2D
    TRN1  V11.4S, V9.4S, V16.4S
    MOV V12.H[0x6], W12
    MVNI  V13.4S, #0xe3, MSL #16
    ZIP2  V23.4H, V15.4H, V2.4H
    ADDP  V10.16B, V21.16B, V29.16B
    ORR  V28.8B, V0.8B, V20.8B
    PMUL  V15.8B, V12.8B, V11.8B
    TBX  V5.16B, { V29.16B, V30.16B }, V15.16B
    TBX  V30.16B, { V23.16B, V24.16B, V25.16B, V26.16B }, V25.16B
    TBL  V7.16B, { V11.16B, V12.16B, V13.16B }, V5.16B
    TBX  V24.8B, { V11.16B, V12.16B }, V29.8B
    NEG  V8.2D, V9.2D
    MOVI  V31.2D, #18446462603011096575
    TBL  V20.8B, { V25.16B, V26.16B, V27.16B, V28.16B }, V14.8B
    SHRN2 V21.16B, V30.8H, #7
    AESMC  V25.16B, V31.16B
    MOV V11.H[0x0], V20.H[0x0]
    SHRN V18.8B, V24.8H, #3
    SHRN2 V31.4S, V18.2D, #23
    RADDHN  V30.8B, V19.8H, V8.8H
    SHRN V14.4H, V7.4S, #2
    MOV V18.B[0x8], W27
    MOV S22, V14.S[0x3]
    PMUL  V5.16B, V7.16B, V10.16B
    TBL  V14.8B, { V2.16B, V3.16B, V4.16B }, V11.8B
    INS V2.H[0x0], V12.H[0x4]
    RSUBHN  V3.4H, V19.4S, V25.4S
    RADDHN2  V0.16B, V2.8H, V20.8H
    INS V20.S[0x1], V4.S[0x3]
    EXT  V29.8B, V5.8B, V22.8B, #0x1
    PMULL2  V2.8H, V3.16B, V1.16B
    BIC  V13.8H, #0x4c
    MOV  V26.8B, V25.8B
    TBL  V5.16B, { V26.16B, V27.16B }, V19.16B
    INS V10.S[0x0], W6
    PMUL  V27.8B, V30.8B, V5.8B
    ORR  V15.8H, #0x52
    MOV V4.D[0x0], V20.D[0x0]
    RSHRN2 V19.8H, V10.4S, #11
    RSHRN V7.4H, V9.4S, #15
    MOV V25.B[0x5], W17
    RSHRN V10.8B, V24.8H, #8
    SHRN2 V28.16B, V25.8H, #2
    SLI  V12.8B, V14.8B, #0x3
    MUL  V5.4S, V28.4S, V15.4S
    MOV  V9.8B, V4.8B
    TBL  V10.16B, { V3.16B, V4.16B, V5.16B, V6.16B }, V29.16B
    SLI  V28.8B, V0.8B, #0x6
    MUL  V25.2S, V12.2S, V19.S[0x2]
    MOV H30, V30.H[0x1]
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_12
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X16, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X21, #0x9700, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D0
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D1
    MOVZ  X21, #0xf8f8, LSL #0
    MOVK  X21, #0xf8f8, LSL #16
    MOVK  X21, #0xf8f8, LSL #32
    MOVK  X21, #0xf8f8, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D3
    MOVZ  X21, #0xfee6, LSL #0
    MOVK  X21, #0xe400, LSL #16
    MOVK  X21, #0xfee6, LSL #32
    MOVK  X21, #0xe400, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X21, #0x606, LSL #0
    MOVK  X21, #0x606, LSL #16
    MOVK  X21, #0x606, LSL #32
    MOVK  X21, #0x606, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D4
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x606, LSL #32
    MOVK  X21, #0x606, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X21, #0x80, LSL #0
    MOVK  X21, #0x6c02, LSL #16
    MOVK  X21, #0x80, LSL #32
    MOVK  X21, #0x4302, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D5
    MOVZ  X21, #0xffae, LSL #0
    MOVK  X21, #0xffad, LSL #16
    MOVK  X21, #0xffae, LSL #32
    MOVK  X21, #0xffad, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D6
    MOVZ  X21, #0xf8f9, LSL #0
    MOVK  X21, #0xfff8, LSL #16
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D7
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D8
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffc1, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D9
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x606, LSL #32
    MOVK  X21, #0x606, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X21, #0xe6e6, LSL #0
    MOVK  X21, #0xe6e6, LSL #16
    MOVK  X21, #0xe6e6, LSL #32
    MOVK  X21, #0xe6e6, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D10
    MOVZ  X21, #0xe6e6, LSL #0
    MOVK  X21, #0xe6e6, LSL #16
    MOVK  X21, #0xe6e6, LSL #32
    MOVK  X21, #0xe6e6, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D12
    MOVZ  X21, #0xa0f, LSL #0
    MOVK  X21, #0x80f, LSL #16
    MOVK  X21, #0x80f, LSL #32
    MOVK  X21, #0x80f, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff10, LSL #16
    MOVK  X21, #0xff10, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D13
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff10, LSL #16
    MOVK  X21, #0xff10, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D14
    MOVZ  X21, #0x2121, LSL #0
    MOVK  X21, #0x2121, LSL #16
    MOVK  X21, #0x2121, LSL #32
    MOVK  X21, #0x2121, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X21, #0x52, LSL #0
    MOVK  X21, #0x52, LSL #16
    MOVK  X21, #0x52, LSL #32
    MOVK  X21, #0x52, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D15
    MOVZ  X21, #0x52, LSL #0
    MOVK  X21, #0x52, LSL #16
    MOVK  X21, #0x52, LSL #32
    MOVK  X21, #0x52, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D16
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X21, #0x6, LSL #0
    MOVK  X21, #0x6, LSL #16
    MOVK  X21, #0x6, LSL #32
    MOVK  X21, #0x6, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D17
    MOVZ  X21, #0xf900, LSL #0
    MOVK  X21, #0x78, LSL #16
    MOVK  X21, #0xcf00, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X21, #0xff, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D18
    MOVZ  X21, #0xc0c0, LSL #0
    MOVK  X21, #0xc0c0, LSL #16
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xdfe0, LSL #32
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D19
    MOVZ  X21, #0xff00, LSL #0
    MOVK  X21, #0xff00, LSL #16
    MOVK  X21, #0xff00, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D20
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x606, LSL #32
    MOVK  X21, #0x606, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D21
    MOVZ  X21, #0x707, LSL #0
    MOVK  X21, #0x707, LSL #16
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D23
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x30, LSL #16
    MOVK  X21, #0x30, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D24
    MOVZ  X21, #0x606, LSL #0
    MOVK  X21, #0x606, LSL #16
    MOVK  X21, #0x606, LSL #32
    MOVK  X21, #0x606, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D25
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D26
    MOVZ  X21, #0xe500, LSL #0
    MOVK  X21, #0x1a, LSL #16
    MOVK  X21, #0xe500, LSL #32
    MOVK  X21, #0x1aff, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D28
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D30
    MOVZ  X21, #0xff00, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X21, #0x181, LSL #0
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X16, D31
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xff00, LSL #16
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X4
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X18
    FMOV  D2, X25
    FMOV  V2.D[1], X27
    FMOV  D3, X28
    FMOV  V3.D[1], X24
    FMOV  D4, X23
    FMOV  V4.D[1], X25
    FMOV  D5, X22
    FMOV  V5.D[1], X29
    FMOV  D6, X16
    FMOV  V6.D[1], X8
    FMOV  D7, X25
    FMOV  V7.D[1], X27
    FMOV  D8, X3
    FMOV  V8.D[1], X12
    FMOV  D9, X16
    FMOV  V9.D[1], X22
    FMOV  D10, X7
    FMOV  V10.D[1], X28
    FMOV  D11, X27
    FMOV  V11.D[1], X21
    FMOV  D12, X19
    FMOV  V12.D[1], X5
    FMOV  D13, X28
    FMOV  V13.D[1], X16
    FMOV  D14, X7
    FMOV  V14.D[1], X4
    FMOV  D15, X27
    FMOV  V15.D[1], X25
    FMOV  D16, X2
    FMOV  V16.D[1], X7
    FMOV  D17, X20
    FMOV  V17.D[1], X22
    FMOV  D18, X3
    FMOV  V18.D[1], X3
    FMOV  D19, X23
    FMOV  V19.D[1], X27
    FMOV  D20, X22
    FMOV  V20.D[1], X23
    FMOV  D21, X16
    FMOV  V21.D[1], X19
    FMOV  D22, X5
    FMOV  V22.D[1], X12
    FMOV  D23, X21
    FMOV  V23.D[1], X25
    FMOV  D24, X19
    FMOV  V24.D[1], X4
    FMOV  D25, X22
    FMOV  V25.D[1], X4
    FMOV  D26, X16
    FMOV  V26.D[1], X9
    FMOV  D27, X28
    FMOV  V27.D[1], X18
    FMOV  D28, X7
    FMOV  V28.D[1], X12
    FMOV  D29, X16
    FMOV  V29.D[1], X8
    FMOV  D30, X29
    FMOV  V30.D[1], X5
    FMOV  D31, X21
    FMOV  V31.D[1], X2
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_13:
    BIT  V27.8B, V6.8B, V27.8B
    MOV V22.B[0xa], W2
    DUP V2.2D, V28.D[0x0]
    BSL  V28.16B, V27.16B, V20.16B
    MOV V20.B[0xa], V23.B[0xc]
    SHRN V5.8B, V30.8H, #3
    SUBHN2  V22.16B, V12.8H, V28.8H
    SLI V12.2D, V2.2D, #0x24
    XTN2  V31.4S, V26.2D
    MVNI  V12.4H, #0x4a, LSL #8
    TBL  V28.16B, { V24.16B }, V29.16B
    RSHRN V22.2S, V12.2D, #3
    RSUBHN2  V2.4S, V20.2D, V12.2D
    BIC  V4.16B, V5.16B, V18.16B
    RSHRN V12.2S, V4.2D, #13
    RADDHN2  V5.4S, V2.2D, V2.2D
    SHRN2 V9.8H, V18.4S, #13
    SHRN2 V7.4S, V28.2D, #14
    DUP V20.4H, W17
    DUP V5.8H, W28
    TBX  V18.16B, { V6.16B, V7.16B }, V12.16B
    ADD  V24.2D, V27.2D, V22.2D
    SHRN V8.4H, V24.4S, #14
    MOV V24.D[0x0], X17
    NEG  V8.8B, V9.8B
    CNT  V25.8B, V8.8B
    TBX  V31.16B, { V2.16B, V3.16B, V4.16B, V5.16B }, V5.16B
    MUL  V22.4S, V18.4S, V15.S[0x3]
    ADDHN  V29.8B, V6.8H, V22.8H
    PMULL  V19.1Q, V20.1D, V17.1D
    INS V12.B[0x9], V24.B[0x0]
    ADDV  B31, V28.16B
    NEG  V23.2D, V29.2D
    MUL  V9.4H, V1.4H, V12.H[0x0]
    ADDP  V17.2S, V9.2S, V19.2S
    MOV V29.B[0xc], V4.B[0x7]
    PMULL2  V20.1Q, V3.2D, V15.2D
    DUP V6.2D, X12
    RSHRN2 V1.8H, V20.4S, #7
    CLS  V12.4H, V1.4H
    MOV S22, V26.S[0x0]
    SUBHN  V3.2S, V29.2D, V24.2D
    MOVI  V26.4S, #0xb4
    MOV H8, V26.H[0x3]
    XTN2  V24.16B, V12.8H
    DUP V9.4H, W19
    TBX  V1.16B, { V8.16B }, V24.16B
    SHLL  V19.4S, V31.4H, #16
    SHRN2 V5.4S, V17.2D, #9
    CLS  V2.16B, V15.16B
    REV64  V24.4H, V5.4H
    MOV V20.H[0x2], W17
    MLA  V18.2S, V1.2S, V23.S[0x2]
    REV64  V20.8H, V15.8H
    INS V8.S[0x1], V30.S[0x0]
    MOV V28.S[0x3], V8.S[0x0]
    BIC  V27.8B, V23.8B, V8.8B
    DUP V17.16B, W26
    BIC  V8.4H, #0x3e
    PMULL  V4.8H, V11.8B, V9.8B
    EXT  V1.8B, V4.8B, V24.8B, #0x7
    MLA  V11.8B, V8.8B, V24.8B
    ORR  V13.4H, #0x76
    MOV V23.B[0x5], W2
    SHL  V22.8B, V1.8B, #0x2
    MUL  V3.4S, V18.4S, V18.S[0x3]
    RSUBHN2  V15.8H, V28.4S, V22.4S
    EOR  V30.8B, V17.8B, V19.8B
    ADDHN2  V4.16B, V23.8H, V27.8H
    MOV V22.S[0x3], W27
    MLA  V12.4S, V4.4S, V20.S[0x3]
    RSHRN V6.2S, V15.2D, #2
    RADDHN  V28.2S, V11.2D, V11.2D
    AESD  V16.16B, V22.16B
    SHRN2 V27.8H, V12.4S, #2
    CLS  V11.4S, V30.4S
    EXT  V15.8B, V3.8B, V23.8B, #0x1
    MLA  V13.4S, V28.4S, V28.S[0x0]
    SRI V20.2D, V15.2D, #48
    MOV H13, V6.H[0x4]
    XTN  V14.2S, V20.2D
    XTN  V18.2S, V21.2D
    RSHRN2 V15.16B, V26.8H, #6
    MOV V23.S[0x3], V13.S[0x0]
    ABS  V22.2D, V9.2D
    TBL  V4.8B, { V14.16B }, V23.8B
    BIC  V19.2S, #0xac, LSL #24
    ADD  V30.4S, V15.4S, V22.4S
    RSHRN V28.2S, V27.2D, #29
    PMULL2  V15.8H, V28.16B, V4.16B
    MOV V29.H[0x3], V11.H[0x3]
    CLS  V20.8H, V19.8H
    ZIP2  V6.2S, V15.2S, V29.2S
    SHLL  V15.4S, V6.4H, #16
    DUP V11.2D, X18
    MOV  X25, V15.D[0x0]
    RSUBHN  V22.4H, V30.4S, V19.4S
    TRN1  V14.16B, V22.16B, V18.16B
    PMUL  V7.16B, V26.16B, V20.16B
    SHLL  V16.2D, V28.2S, #32
    SHL  V28.16B, V16.16B, #0x2
    MOV B13, V12.B[0x8]
    INS V18.H[0x4], W17
    MOV V4.H[0x4], V20.H[0x1]
    RSHRN2 V15.8H, V28.4S, #15
    ZIP1  V7.8H, V4.8H, V18.8H
    BIC  V26.8H, #0x29
    TBL  V28.16B, { V2.16B, V3.16B, V4.16B, V5.16B }, V23.16B
    ADDHN  V22.4H, V20.4S, V26.4S
    MOV V23.D[0x0], V28.D[0x1]
    ORR  V30.2S, #0xcb, LSL #8
    DUP V12.16B, W25
    DUP V29.2S, W25
    ORR  V20.8H, #0x72
    RSHRN V19.4H, V30.4S, #11
    MVN  V27.16B, V20.16B
    AESD  V0.16B, V12.16B
    MOV V2.H[0x6], V11.H[0x5]
    SHRN V4.2S, V2.2D, #14
    TRN1  V2.2S, V17.2S, V7.2S
    DUP S0, V19.S[0x3]
    AESIMC  V5.16B, V15.16B
    SLI  V18.2S, V5.2S, #0x1a
    ORR  V18.2S, #0xb1, LSL #24
    MOV V3.D[0x0], V2.D[0x0]
    EXT  V30.8B, V0.8B, V23.8B, #0x0
    MOV V15.S[0x1], W6
    MOV D23, V27.D[0x1]
    DUP B12, V22.B[0x6]
    ORN  V28.8B, V3.8B, V23.8B
    REV64  V8.8H, V15.8H
    RSHRN2 V20.4S, V4.2D, #8
    PMULL  V0.1Q, V25.1D, V29.1D
    PMUL  V2.16B, V18.16B, V20.16B
    RBIT  V30.16B, V12.16B
    AND  V13.16B, V0.16B, V2.16B
    RSHRN V3.2S, V25.2D, #28
    REV64  V20.16B, V19.16B
    SRI  V26.8B, V17.8B, #8
    SLI  V17.16B, V3.16B, #0x2
    SHRN2 V29.4S, V31.2D, #6
    UZP2  V22.4H, V7.4H, V26.4H
    BIC  V5.16B, V28.16B, V5.16B
    DUP B25, V19.B[0x9]
    DUP S19, V25.S[0x1]
    MVNI  V25.4S, #0x51
    DUP  V28.16B, V19.B[0x6]
    DUP V26.2S, W29
    MVNI  V7.4S, #0x11, LSL #24
    BIF  V12.8B, V12.8B, V25.8B
    NOT  V3.16B, V24.16B
    SUBHN2  V25.8H, V20.4S, V17.4S
    SHRN V24.4H, V22.4S, #9
    RSHRN2 V25.8H, V5.4S, #7
    MUL  V19.16B, V7.16B, V24.16B
    MOV V17.B[0x3], V3.B[0xe]
    AESIMC  V27.16B, V17.16B
    SLI V31.2D, V12.2D, #0x39
    BIF  V22.16B, V22.16B, V5.16B
    REV64  V5.8H, V8.8H
    MOV V8.H[0x7], W28
    DUP V1.2D, V19.D[0x0]
    INS V19.B[0x1], W20
    RSHRN V7.2S, V22.2D, #7
    MUL  V0.8H, V27.8H, V28.8H
    EXT  V15.8B, V4.8B, V19.8B, #0x4
    MOV V24.H[0x6], V5.H[0x7]
    BIC  V29.8B, V24.8B, V2.8B
    MOVI  V2.2D, #71777218572779520
    MLS  V28.4S, V8.4S, V10.S[0x1]
    SRI  V8.4S, V26.4S, #16
    DUP  V10.8H, V31.H[0x5]
    BSL  V5.8B, V17.8B, V21.8B
    TBL  V31.8B, { V23.16B, V24.16B, V25.16B }, V15.8B
    MOV B26, V2.B[0xe]
    SHRN V4.4H, V29.4S, #12
    MOV H24, V0.H[0x7]
    DUP V24.2D, X19
    XTN  V2.2S, V26.2D
    TBL  V20.8B, { V16.16B, V17.16B, V18.16B }, V10.8B
    ORR  V10.4S, #0xf3, LSL #24
    TBL  V29.16B, { V21.16B, V22.16B, V23.16B, V24.16B }, V7.16B
    DUP H3, V7.H[0x1]
    XTN  V24.2S, V31.2D
    TRN1  V11.16B, V27.16B, V10.16B
    DUP V0.2S, W9
    INS V31.B[0xf], W25
    EXT  V23.16B, V4.16B, V29.16B, #0x4
    REV64  V19.4H, V3.4H
    MLA  V14.4H, V19.4H, V1.H[0x6]
    AND  V16.16B, V28.16B, V11.16B
    DUP H7, V29.H[0x5]
    ADD  V2.4H, V31.4H, V31.4H
    XTN2  V6.4S, V20.2D
    RSHRN V27.4H, V0.4S, #15
    SHRN V26.8B, V6.8H, #1
    RSUBHN  V16.8B, V27.8H, V27.8H
    TRN1  V11.2D, V26.2D, V6.2D
    TBL  V17.16B, { V23.16B, V24.16B, V25.16B }, V7.16B
    RSHRN2 V18.16B, V3.8H, #7
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_13
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X7, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X22, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X7, #0xd3d3, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D1
    MOVZ  X7, #0xd3d3, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D2
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x100, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D3
    MOVZ  X7, #0xb4, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D4
    MOVZ  X7, #0x2, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D5
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x202, LSL #32
    MOVK  X7, #0x202, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D7
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D8
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D9
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf300, LSL #16
    MOVK  X7, #0xf300, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D10
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf300, LSL #16
    MOVK  X7, #0xf300, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D12
    MOVZ  X7, #0xf, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D14
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a03, LSL #32
    MOVK  X7, #0x5a03, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D15
    MOVZ  X7, #0x1c1c, LSL #0
    MOVK  X7, #0x6968, LSL #16
    MOVK  X7, #0x5ad3, LSL #32
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X7, #0x1, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D18
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0xb35a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0xb35a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D19
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xb4, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D21
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D22
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5a00, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X7, #0xfeb5, LSL #0
    MOVK  X7, #0xfe01, LSL #16
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D25
    MOVZ  X7, #0xffae, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffae, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D27
    MOVZ  X7, #0xb4b5, LSL #0
    MOVK  X7, #0xb4b5, LSL #16
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D28
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x9200, LSL #16
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D29
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5a00, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D30
    MOVZ  X7, #0xf0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D31
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8080, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorGeneralOperation_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X7
    FMOV  D1, X3
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X24
    FMOV  V3.D[1], X4
    FMOV  D4, X17
    FMOV  V4.D[1], X4
    FMOV  D5, X12
    FMOV  V5.D[1], X18
    FMOV  D6, X21
    FMOV  V6.D[1], X17
    FMOV  D7, X4
    FMOV  V7.D[1], X28
    FMOV  D8, X24
    FMOV  V8.D[1], X6
    FMOV  D9, X16
    FMOV  V9.D[1], X4
    FMOV  D10, X21
    FMOV  V10.D[1], X6
    FMOV  D11, X29
    FMOV  V11.D[1], X5
    FMOV  D12, X28
    FMOV  V12.D[1], X12
    FMOV  D13, X9
    FMOV  V13.D[1], X21
    FMOV  D14, X17
    FMOV  V14.D[1], X2
    FMOV  D15, X20
    FMOV  V15.D[1], X2
    FMOV  D16, X7
    FMOV  V16.D[1], X23
    FMOV  D17, X18
    FMOV  V17.D[1], X6
    FMOV  D18, X6
    FMOV  V18.D[1], X22
    FMOV  D19, X4
    FMOV  V19.D[1], X19
    FMOV  D20, X24
    FMOV  V20.D[1], X20
    FMOV  D21, X18
    FMOV  V21.D[1], X17
    FMOV  D22, X24
    FMOV  V22.D[1], X20
    FMOV  D23, X21
    FMOV  V23.D[1], X18
    FMOV  D24, X21
    FMOV  V24.D[1], X24
    FMOV  D25, X24
    FMOV  V25.D[1], X16
    FMOV  D26, X16
    FMOV  V26.D[1], X21
    FMOV  D27, X17
    FMOV  V27.D[1], X9
    FMOV  D28, X27
    FMOV  V28.D[1], X26
    FMOV  D29, X22
    FMOV  V29.D[1], X21
    FMOV  D30, X9
    FMOV  V30.D[1], X9
    FMOV  D31, X24
    FMOV  V31.D[1], X5
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorGeneralOperation_label_14:
    MOV V26.D[0x1], X4
    BIC  V15.4S, #0x22, LSL #8
    SRI  V23.4S, V28.4S, #2
    SRI  V21.8B, V24.8B, #1
    DUP D21, V15.D[0x1]
    MVNI  V15.8H, #0x44
    MLA  V27.4S, V27.4S, V21.S[0x3]
    TBX  V8.8B, { V20.16B, V21.16B }, V1.8B
    RSUBHN2  V1.4S, V27.2D, V27.2D
    ZIP2  V23.16B, V15.16B, V12.16B
    SHLL2  V14.4S, V5.8H, #16
    RBIT  V0.16B, V8.16B
    REV32  V13.16B, V1.16B
    MOV V27.D[0x1], X17
    DUP V21.2D, X23
    MOV B25, V30.B[0x0]
    INS V18.H[0x0], V22.H[0x6]
    SHRN V10.2S, V29.2D, #1
    AESD  V2.16B, V13.16B
    BIF  V17.8B, V25.8B, V10.8B
    MOVI  V25.16B, #0x6a
    SLI  V24.16B, V16.16B, #0x7
    BIC  V31.4H, #0x5d
    TBX  V5.16B, { V20.16B, V21.16B, V22.16B, V23.16B }, V0.16B
    MVNI  V22.4S, #0xd9, LSL #8
    AESMC  V10.16B, V2.16B
    TBX  V7.8B, { V3.16B, V4.16B }, V24.8B
    TRN1  V3.8H, V14.8H, V10.8H
    XTN  V10.8B, V31.8H
    RSHRN2 V28.8H, V27.4S, #14
    MOV  X23, V25.D[0x1]
    XTN2  V2.8H, V18.4S
    MOV S23, V10.S[0x3]
    SHL  V0.16B, V21.16B, #0x5
    MUL  V18.4S, V3.4S, V28.S[0x0]
    SHLL  V30.2D, V22.2S, #32
    INS V3.D[0x0], X2
    CLS  V31.8H, V20.8H
    SHRN2 V21.4S, V30.2D, #6
    MOVI  V25.16B, #0xc9
    AESD  V14.16B, V18.16B
    RADDHN  V22.8B, V16.8H, V23.8H
    MOVI  V4.4H, #0x90, LSL #8
    DUP V28.2D, V3.D[0x0]
    BSL  V27.16B, V21.16B, V21.16B
    REV32  V26.4H, V14.4H
    EXT  V3.8B, V3.8B, V0.8B, #0x6
    SUBHN  V16.2S, V26.2D, V24.2D
    ADDP  V14.2S, V22.2S, V17.2S
    MLA  V10.8H, V3.8H, V2.H[0x5]
    DUP S24, V28.S[0x0]
    MOVI  V28.2D, #18446463693966213375
    AND  V23.16B, V31.16B, V16.16B
    CLS  V0.8H, V28.8H
    CNT  V4.16B, V11.16B
    INS V18.S[0x3], W21
    MOV  V16.16B, V3.16B
    ZIP1  V11.2S, V16.2S, V10.2S
    ORN  V20.16B, V23.16B, V14.16B
    SHL  V14.4H, V4.4H, #0xf
    RSHRN2 V10.4S, V20.2D, #22
    RSHRN2 V20.4S, V18.2D, #20
    DUP V8.2D, X9
    PMULL2  V2.8H, V27.16B, V8.16B
    RADDHN  V17.2S, V0.2D, V24.2D
    RSHRN2 V3.16B, V10.8H, #6
    ORR  V27.4H, #0x24
    TBX  V21.8B, { V1.16B, V2.16B, V3.16B }, V9.8B
    MOVI  V23.8B, #0x7f
    AND  V8.16B, V1.16B, V14.16B
    TRN2  V3.4S, V20.4S, V17.4S
    SHRN2 V26.4S, V27.2D, #24
    ORR  V2.8B, V11.8B, V8.8B
    RSHRN V14.8B, V23.8H, #5
    BIC  V10.2S, #0xb6, LSL #8
    TBL  V31.16B, { V20.16B }, V21.16B
    NEG  V18.2S, V8.2S
    ADD  V4.2S, V29.2S, V26.2S
    MOVI  V26.4S, #0x6e, LSL #8
    MOV S1, V22.S[0x1]
    UZP2  V16.2S, V12.2S, V31.2S
    SRI  V9.8B, V25.8B, #2
    EXT  V21.8B, V16.8B, V22.8B, #0x2
    SHL  V25.4H, V14.4H, #0xb
    ADDP  V2.16B, V12.16B, V18.16B
    RSHRN V8.2S, V26.2D, #5
    MOV V17.S[0x3], W8
    MOVI  V29.4S, #0xd5, MSL #8
    DUP  V30.4S, V21.S[0x1]
    REV32  V11.16B, V20.16B
    EOR  V12.8B, V26.8B, V9.8B
    MOVI  V23.2S, #0x76, LSL #24
    SLI  V14.4S, V1.4S, #0xd
    MOV  V16.16B, V3.16B
    MOV V3.H[0x0], V14.H[0x3]
    TBX  V9.16B, { V29.16B, V30.16B }, V3.16B
    XTN  V26.8B, V15.8H
    SUBHN2  V25.4S, V2.2D, V12.2D
    SLI  V1.4S, V23.4S, #0x1b
    INS V21.D[0x1], X20
    MOVI  V15.2D, #18374687579183186175
    UZP1  V23.16B, V16.16B, V9.16B
    MVNI  V4.4S, #0x45, MSL #8
    BIC  V2.16B, V29.16B, V8.16B
    AESE  V29.16B, V26.16B
    AESD  V16.16B, V1.16B
    MUL  V8.8H, V22.8H, V12.H[0x7]
    TBX  V9.16B, { V2.16B, V3.16B, V4.16B, V5.16B }, V21.16B
    PMULL2  V20.8H, V29.16B, V16.16B
    INS V3.H[0x3], W26
    MUL  V11.4S, V30.4S, V15.S[0x0]
    NOT  V15.16B, V8.16B
    INS V18.H[0x0], V25.H[0x5]
    INS V8.B[0xd], W18
    MOV V25.S[0x1], W23
    REV16  V22.8B, V11.8B
    ADDV  B17, V5.8B
    REV64  V14.4H, V20.4H
    MOV V10.H[0x2], W5
    TRN2  V26.8B, V22.8B, V8.8B
    INS V29.B[0xc], W20
    SLI V3.2D, V15.2D, #0x2d
    DUP B2, V17.B[0xc]
    BSL  V2.8B, V2.8B, V29.8B
    SHL  V22.4H, V3.4H, #0xa
    SLI  V29.4S, V2.4S, #0x8
    MOV V4.B[0xf], W17
    ADD  V21.4H, V7.4H, V9.4H
    MOV V20.S[0x3], V14.S[0x3]
    AND  V3.16B, V25.16B, V22.16B
    SHRN2 V16.4S, V1.2D, #13
    MOV H25, V31.H[0x7]
    SRI  V22.8B, V21.8B, #2
    MOV V6.D[0x0], X17
    SRI  V9.16B, V22.16B, #1
    AND  V14.16B, V29.16B, V6.16B
    ADDV  B15, V9.8B
    MOV V29.S[0x0], W5
    RSHRN V2.8B, V10.8H, #4
    AESIMC  V8.16B, V20.16B
    BIC  V7.4S, #0xd1
    UZP1  V5.4S, V3.4S, V15.4S
    MUL  V15.8H, V16.8H, V7.8H
    AND  V3.8B, V10.8B, V5.8B
    MOVI  V16.2D, #1095216726015
    MUL  V9.2S, V2.2S, V26.S[0x1]
    DUP V2.4S, W3
    SHL V20.2D, V2.2D, #0x2b
    EXT  V17.16B, V15.16B, V16.16B, #0x0
    TBL  V21.8B, { V29.16B, V30.16B, V31.16B }, V25.8B
    CNT  V7.16B, V20.16B
    MOV V29.D[0x1], X5
    INS V1.H[0x7], W18
    DUP  V28.16B, V17.B[0xa]
    MOV V20.H[0x0], W27
    MOV V2.D[0x0], V8.D[0x1]
    MOVI  V26.16B, #0x6b
    SUB  V17.8H, V23.8H, V12.8H
    REV16  V16.8B, V28.8B
    MOV V25.S[0x2], V29.S[0x3]
    SUBHN2  V10.8H, V20.4S, V15.4S
    SUBHN2  V26.8H, V1.4S, V26.4S
    ADDHN  V3.8B, V14.8H, V3.8H
    ADD  V15.8B, V21.8B, V3.8B
    BIF  V6.8B, V15.8B, V26.8B
    ADDP  D12, V7.2D
    TBX  V23.16B, { V2.16B }, V10.16B
    DUP V5.2S, W5
    SLI  V26.4H, V23.4H, #0x8
    SRI  V12.8B, V9.8B, #5
    TBX  V21.8B, { V26.16B, V27.16B, V28.16B }, V17.8B
    MUL  V15.2S, V25.2S, V24.S[0x0]
    MLA  V8.8H, V31.8H, V9.H[0x6]
    INS V17.H[0x6], W24
    MOV V20.D[0x0], X24
    MLS  V30.4S, V26.4S, V29.S[0x0]
    MVNI  V10.4S, #0xa5, MSL #8
    AESD  V9.16B, V16.16B
    SRI  V5.16B, V30.16B, #3
    BIF  V1.8B, V0.8B, V17.8B
    SUB  V22.16B, V20.16B, V12.16B
    INS V25.H[0x1], V10.H[0x3]
    CNT  V0.16B, V22.16B
    XTN2  V17.4S, V9.2D
    TBL  V16.8B, { V7.16B }, V6.8B
    REV16  V12.16B, V9.16B
    MOVI  V30.8H, #0xa3
    TBX  V27.8B, { V24.16B, V25.16B, V26.16B, V27.16B }, V23.8B
    CNT  V6.16B, V23.16B
    SHL V14.2D, V17.2D, #0x28
    AESIMC  V30.16B, V1.16B
    MOV  W5, V8.S[0x1]
    XTN2  V1.8H, V12.4S
    UZP1  V26.2D, V21.2D, V1.2D
    INS V6.B[0xc], V14.B[0xf]
    MOVI  V17.8B, #0xb1
    DUP V9.4H, W20
    MOV V13.H[0x0], W9
    MLS  V12.4H, V4.4H, V6.H[0x6]
    TBX  V31.8B, { V8.16B }, V27.8B
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorGeneralOperation_label_14
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xd607, LSL #0
    MOVK  X22, #0x4b7c, LSL #16
    SUB  X16, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0x6a6a, LSL #0
    MOVK  X22, #0x6a6a, LSL #16
    MOVK  X22, #0x6a6a, LSL #32
    MOVK  X22, #0x6a6a, LSL #48
    SUB  X16, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X16, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorGeneralOperation_TestFail
    MRS  X22, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x200, LSL #32
    MOVK  X16, #0x404, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D0
    MOVZ  X16, #0x404, LSL #0
    MOVK  X16, #0x404, LSL #16
    MOVK  X16, #0x404, LSL #32
    MOVK  X16, #0x505, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X16, #0x5252, LSL #0
    MOVK  X16, #0x5252, LSL #16
    MOVK  X16, #0x5252, LSL #32
    MOVK  X16, #0x5252, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D1
    MOVZ  X16, #0x2, LSL #0
    MOVK  X16, #0x2, LSL #16
    MOVK  X16, #0x1, LSL #32
    MOVK  X16, #0x1, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D2
    MOVZ  X16, #0x1f64, LSL #0
    MOVK  X16, #0x95b0, LSL #16
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X16, #0xba00, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xba00, LSL #32
    MOVK  X16, #0x1ff, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D4
    MOVZ  X16, #0xba00, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xba00, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D5
    MOVZ  X16, #0x661c, LSL #0
    MOVK  X16, #0xc9ea, LSL #16
    MOVK  X16, #0x7b1c, LSL #32
    MOVK  X16, #0xd9fa, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X16, #0x303, LSL #0
    MOVK  X16, #0x352, LSL #32
    MOVK  X16, #0x808, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D6
    MOVZ  X16, #0x303, LSL #0
    MOVK  X16, #0x303, LSL #16
    MOVK  X16, #0x400, LSL #32
    MOVK  X16, #0x303, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x200, LSL #32
    MOVK  X16, #0x404, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D7
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x200, LSL #32
    MOVK  X16, #0x404, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X16, #0x1f64, LSL #0
    MOVK  X16, #0x95b0, LSL #16
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D8
    MOVZ  X16, #0x3e7a, LSL #0
    MOVK  X16, #0x463c, LSL #16
    MOVK  X16, #0xd607, LSL #32
    MOVK  X16, #0x4b7c, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D9
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X16, #0x5a00, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x5a00, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D10
    MOVZ  X16, #0x5a00, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x5a00, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D12
    MOVZ  X16, #0xbe52, LSL #0
    MOVK  X16, #0x55a4, LSL #16
    MOVK  X16, #0xbe52, LSL #32
    MOVK  X16, #0x55a4, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D13
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0x100, LSL #32
    MOVK  X16, #0x100, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5200, LSL #32
    MOVK  X16, #0x5252, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D14
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xf500, LSL #32
    MOVK  X16, #0x5501, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D15
    MOVZ  X16, #0x5a5b, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D16
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D17
    MOVZ  X16, #0xb1b1, LSL #0
    MOVK  X16, #0xb1b1, LSL #16
    MOVK  X16, #0xb1b1, LSL #32
    MOVK  X16, #0xb1b1, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D18
    MOVZ  X16, #0x4d4d, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D19
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x2800, LSL #32
    MOVK  X16, #0x2d2d, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D20
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D21
    MOVZ  X16, #0x6400, LSL #0
    MOVK  X16, #0x1111, LSL #16
    MOVK  X16, #0x1111, LSL #32
    MOVK  X16, #0x1111, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x2800, LSL #32
    MOVK  X16, #0x2d2d, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D22
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0x9d9d, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X16, #0x6464, LSL #0
    MOVK  X16, #0x6464, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D23
    MOVZ  X16, #0x6464, LSL #0
    MOVK  X16, #0x6464, LSL #16
    MOVK  X16, #0x5a00, LSL #32
    MOVK  X16, #0x6464, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D24
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D25
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X16, #0x2, LSL #0
    MOVK  X16, #0x2, LSL #16
    MOVK  X16, #0x1, LSL #32
    MOVK  X16, #0x1, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D26
    MOVZ  X16, #0x6400, LSL #0
    MOVK  X16, #0x1111, LSL #16
    MOVK  X16, #0x1111, LSL #32
    MOVK  X16, #0x1111, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D27
    MOVZ  X16, #0x6a6e, LSL #0
    MOVK  X16, #0x6a6e, LSL #16
    MOVK  X16, #0x6aa5, LSL #32
    MOVK  X16, #0x6a6e, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X16, #0x6011, LSL #0
    MOVK  X16, #0xc9ef, LSL #16
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D29
    MOVZ  X16, #0x6011, LSL #0
    MOVK  X16, #0xc9ef, LSL #16
    MOVK  X16, #0x1b1b, LSL #32
    MOVK  X16, #0x6303, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D30
    MOVZ  X16, #0x406, LSL #0
    MOVK  X16, #0x406, LSL #16
    MOVK  X16, #0x203, LSL #32
    MOVK  X16, #0x203, LSL #48
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail
    FMOV  X22, D31
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorGeneralOperation_TestFail

TSRTAdvsimdVectorGeneralOperation_TestEnd:
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
TSRTAdvsimdVectorGeneralOperation_TestFail:
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
