.global TSRTFloatMovMadd

.text
.p2align 4

TSRTFloatMovMadd:

TSRTFloatMovMadd_TestBegin:
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
    MOVZ  X2, #0x4429, LSL #0
    MOVK  X2, #0x5601, LSL #16
    MOVK  X2, #0xb187, LSL #32
    MOVK  X2, #0x9737, LSL #48
    MOVZ  X3, #0x2c2b, LSL #0
    MOVK  X3, #0xf036, LSL #16
    MOVK  X3, #0xfc06, LSL #32
    MOVK  X3, #0x3741, LSL #48
    MOVZ  X4, #0x1f7e, LSL #0
    MOVK  X4, #0xd98b, LSL #16
    MOVK  X4, #0x9cd4, LSL #32
    MOVK  X4, #0x2444, LSL #48
    MOVZ  X5, #0x9365, LSL #0
    MOVK  X5, #0x11b9, LSL #16
    MOVK  X5, #0xabb, LSL #32
    MOVK  X5, #0xab8c, LSL #48
    MOVZ  X6, #0xdc77, LSL #0
    MOVK  X6, #0x9492, LSL #16
    MOVK  X6, #0x5a0f, LSL #32
    MOVK  X6, #0x4967, LSL #48
    MOVZ  X7, #0x84b1, LSL #0
    MOVK  X7, #0xf416, LSL #16
    MOVK  X7, #0x2b2b, LSL #32
    MOVK  X7, #0x5f7a, LSL #48
    MOVZ  X11, #0x9eba, LSL #0
    MOVK  X11, #0x169a, LSL #16
    MOVK  X11, #0xadb2, LSL #32
    MOVK  X11, #0x5fac, LSL #48
    MOVZ  X13, #0x549, LSL #0
    MOVK  X13, #0xa5f6, LSL #16
    MOVK  X13, #0xba08, LSL #32
    MOVK  X13, #0x5b4e, LSL #48
    MOVZ  X14, #0x4e61, LSL #0
    MOVK  X14, #0xabc5, LSL #16
    MOVK  X14, #0xc576, LSL #32
    MOVK  X14, #0x68be, LSL #48
    MOVZ  X16, #0xfee6, LSL #0
    MOVK  X16, #0x3e23, LSL #16
    MOVK  X16, #0x7f8a, LSL #32
    MOVK  X16, #0xc6e9, LSL #48
    MOVZ  X17, #0xa9f0, LSL #0
    MOVK  X17, #0xcd18, LSL #16
    MOVK  X17, #0x3f30, LSL #32
    MOVK  X17, #0xb255, LSL #48
    MOVZ  X18, #0x2ad0, LSL #0
    MOVK  X18, #0x1980, LSL #16
    MOVK  X18, #0xaf32, LSL #32
    MOVK  X18, #0xc1ae, LSL #48
    MOVZ  X19, #0xbdde, LSL #0
    MOVK  X19, #0x6f3f, LSL #16
    MOVK  X19, #0x2c30, LSL #32
    MOVK  X19, #0x36a0, LSL #48
    MOVZ  X20, #0x69e8, LSL #0
    MOVK  X20, #0x34e5, LSL #16
    MOVK  X20, #0xaa6e, LSL #32
    MOVK  X20, #0xa4f1, LSL #48
    MOVZ  X21, #0x484a, LSL #0
    MOVK  X21, #0x3043, LSL #16
    MOVK  X21, #0x471c, LSL #32
    MOVK  X21, #0xc5c1, LSL #48
    MOVZ  X22, #0xbbf6, LSL #0
    MOVK  X22, #0x97bf, LSL #16
    MOVK  X22, #0xd638, LSL #32
    MOVK  X22, #0x542f, LSL #48
    MOVZ  X23, #0x75b1, LSL #0
    MOVK  X23, #0x994e, LSL #16
    MOVK  X23, #0x91f1, LSL #32
    MOVK  X23, #0xccd8, LSL #48
    MOVZ  X24, #0x2fef, LSL #0
    MOVK  X24, #0xea8b, LSL #16
    MOVK  X24, #0x4006, LSL #32
    MOVK  X24, #0x42f8, LSL #48
    MOVZ  X25, #0x9f3f, LSL #0
    MOVK  X25, #0xa0c9, LSL #16
    MOVK  X25, #0x9d5d, LSL #32
    MOVK  X25, #0xd956, LSL #48
    MOVZ  X26, #0x937f, LSL #0
    MOVK  X26, #0x7335, LSL #16
    MOVK  X26, #0xde02, LSL #32
    MOVK  X26, #0xf7c, LSL #48
    MOVZ  X27, #0x9d91, LSL #0
    MOVK  X27, #0xda4c, LSL #16
    MOVK  X27, #0xd62a, LSL #32
    MOVK  X27, #0x7020, LSL #48
    MOVZ  X28, #0x4cbf, LSL #0
    MOVK  X28, #0xa933, LSL #16
    MOVK  X28, #0xe01, LSL #32
    MOVK  X28, #0x7776, LSL #48
    MOVZ  X29, #0x348e, LSL #0
    MOVK  X29, #0xec6d, LSL #16
    MOVK  X29, #0x65b4, LSL #32
    MOVK  X29, #0x7b65, LSL #48
    MOVZ  X21, #0x23f1, LSL #0
    MOVK  X21, #0x9ebf, LSL #16
    MOVK  X21, #0x18bb, LSL #32
    MOVK  X21, #0xa658, LSL #48
    MSR  FPCR, X21
    MRS  X19, FPCR
    MOVZ  X28, #0x60ff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    AND  X19, X19, X28
    MOVZ  X28, #0x0, LSL #0
    ORR  X19, X19, X28
    MSR  FPCR, X19
    ISB  SY
    MOVZ  X21, #0x4948, LSL #0
    MOVK  X21, #0xa500, LSL #16
    MOVK  X21, #0x98a4, LSL #32
    MOVK  X21, #0xe16c, LSL #48
    MSR  FPSR, X21
    MRS  X28, FPSR
    MOVZ  X2, #0xff60, LSL #0
    MOVK  X2, #0x7ff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X28, X28, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X28, X28, X2
    MSR  FPSR, X28
    ISB  SY
    ANDS  X21, X2, #0xffffffc1ffffffc1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x3b87, LSL #0
    MOVK  X2, #0xdd4b, LSL #16
    MOVK  X2, #0xed36, LSL #32
    MOVK  X2, #0xa64c, LSL #48
    MOVZ  X3, #0xe20d, LSL #0
    MOVK  X3, #0xb03e, LSL #16
    MOVK  X3, #0x7bc7, LSL #32
    MOVK  X3, #0x8781, LSL #48
    MOVZ  X4, #0xc17b, LSL #0
    MOVK  X4, #0xf227, LSL #16
    MOVK  X4, #0x4eb9, LSL #32
    MOVK  X4, #0x3cc9, LSL #48
    MOVZ  X5, #0x453a, LSL #0
    MOVK  X5, #0xfa19, LSL #16
    MOVK  X5, #0x973d, LSL #32
    MOVK  X5, #0xbc52, LSL #48
    MOVZ  X6, #0xe919, LSL #0
    MOVK  X6, #0xbc57, LSL #16
    MOVK  X6, #0xaa92, LSL #32
    MOVK  X6, #0xe466, LSL #48
    MOVZ  X7, #0xaff0, LSL #0
    MOVK  X7, #0x894e, LSL #16
    MOVK  X7, #0x836f, LSL #32
    MOVK  X7, #0xe33e, LSL #48
    MOVZ  X11, #0xfa52, LSL #0
    MOVK  X11, #0x86c1, LSL #16
    MOVK  X11, #0x3614, LSL #32
    MOVK  X11, #0x96a6, LSL #48
    MOVZ  X13, #0x953a, LSL #0
    MOVK  X13, #0xa049, LSL #16
    MOVK  X13, #0xb00b, LSL #32
    MOVK  X13, #0xe5dc, LSL #48
    MOVZ  X14, #0x3778, LSL #0
    MOVK  X14, #0x276, LSL #16
    MOVK  X14, #0xf80d, LSL #32
    MOVK  X14, #0x259c, LSL #48
    MOVZ  X16, #0x7892, LSL #0
    MOVK  X16, #0x3103, LSL #16
    MOVK  X16, #0x270a, LSL #32
    MOVK  X16, #0x5b56, LSL #48
    MOVZ  X17, #0xcfd9, LSL #0
    MOVK  X17, #0xbc76, LSL #16
    MOVK  X17, #0x63b0, LSL #32
    MOVK  X17, #0x6736, LSL #48
    MOVZ  X18, #0xc85b, LSL #0
    MOVK  X18, #0x110d, LSL #16
    MOVK  X18, #0xe31f, LSL #32
    MOVK  X18, #0x222a, LSL #48
    MOVZ  X19, #0x5dd4, LSL #0
    MOVK  X19, #0xf3e4, LSL #16
    MOVK  X19, #0xf9aa, LSL #32
    MOVK  X19, #0x396a, LSL #48
    MOVZ  X20, #0xfe35, LSL #0
    MOVK  X20, #0x1ad4, LSL #16
    MOVK  X20, #0x1818, LSL #32
    MOVK  X20, #0x2dc7, LSL #48
    MOVZ  X21, #0x99a8, LSL #0
    MOVK  X21, #0x4a5, LSL #16
    MOVK  X21, #0xaa1b, LSL #32
    MOVK  X21, #0x9f16, LSL #48
    MOVZ  X22, #0x9050, LSL #0
    MOVK  X22, #0x372e, LSL #16
    MOVK  X22, #0x9ac4, LSL #32
    MOVK  X22, #0x2a3d, LSL #48
    MOVZ  X23, #0x66e3, LSL #0
    MOVK  X23, #0x7671, LSL #16
    MOVK  X23, #0x905a, LSL #32
    MOVK  X23, #0xe150, LSL #48
    MOVZ  X24, #0x6508, LSL #0
    MOVK  X24, #0xcd85, LSL #16
    MOVK  X24, #0xb3a8, LSL #32
    MOVK  X24, #0xa805, LSL #48
    MOVZ  X25, #0xce60, LSL #0
    MOVK  X25, #0x9d5b, LSL #16
    MOVK  X25, #0x1a0f, LSL #32
    MOVK  X25, #0x6921, LSL #48
    MOVZ  X26, #0x4c40, LSL #0
    MOVK  X26, #0x4317, LSL #16
    MOVK  X26, #0x1a23, LSL #32
    MOVK  X26, #0x9ec3, LSL #48
    MOVZ  X27, #0x756a, LSL #0
    MOVK  X27, #0x53f9, LSL #16
    MOVK  X27, #0x26ac, LSL #32
    MOVK  X27, #0x551e, LSL #48
    MOVZ  X28, #0xc30d, LSL #0
    MOVK  X28, #0xdda1, LSL #16
    MOVK  X28, #0x3760, LSL #32
    MOVK  X28, #0xaaf8, LSL #48
    MOVZ  X29, #0x9aaf, LSL #0
    MOVK  X29, #0x17f1, LSL #16
    MOVK  X29, #0xc81, LSL #32
    MOVK  X29, #0x3518, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X25
    FMOV  D1, X11
    FMOV  V1.D[1], X14
    FMOV  D2, X27
    FMOV  V2.D[1], X27
    FMOV  D3, X4
    FMOV  V3.D[1], X29
    FMOV  D4, X28
    FMOV  V4.D[1], X4
    FMOV  D5, X22
    FMOV  V5.D[1], X5
    FMOV  D6, X23
    FMOV  V6.D[1], X13
    FMOV  D7, X26
    FMOV  V7.D[1], X27
    FMOV  D8, X3
    FMOV  V8.D[1], X13
    FMOV  D9, X23
    FMOV  V9.D[1], X7
    FMOV  D10, X7
    FMOV  V10.D[1], X28
    FMOV  D11, X23
    FMOV  V11.D[1], X21
    FMOV  D12, X2
    FMOV  V12.D[1], X3
    FMOV  D13, X21
    FMOV  V13.D[1], X6
    FMOV  D14, X18
    FMOV  V14.D[1], X4
    FMOV  D15, X26
    FMOV  V15.D[1], X22
    FMOV  D16, X13
    FMOV  V16.D[1], X26
    FMOV  D17, X14
    FMOV  V17.D[1], X5
    FMOV  D18, X5
    FMOV  V18.D[1], X25
    FMOV  D19, X13
    FMOV  V19.D[1], X23
    FMOV  D20, X26
    FMOV  V20.D[1], X20
    FMOV  D21, X3
    FMOV  V21.D[1], X11
    FMOV  D22, X4
    FMOV  V22.D[1], X5
    FMOV  D23, X27
    FMOV  V23.D[1], X13
    FMOV  D24, X28
    FMOV  V24.D[1], X26
    FMOV  D25, X2
    FMOV  V25.D[1], X21
    FMOV  D26, X14
    FMOV  V26.D[1], X25
    FMOV  D27, X17
    FMOV  V27.D[1], X22
    FMOV  D28, X29
    FMOV  V28.D[1], X2
    FMOV  D29, X24
    FMOV  V29.D[1], X28
    FMOV  D30, X19
    FMOV  V30.D[1], X24
    FMOV  D31, X4
    FMOV  V31.D[1], X3
    FABS  D21, D26
    FABS  D31, D17
    FABS  D0, D20
    FABS  D6, D12
    FABS  D7, D23
    FABS  D14, D27
    FABS  D30, D25
    FABS  D21, D28
    FABS  D29, D30
    FABS  D12, D21
    FABS  S1, S4
    FABS  S8, S14
    FABS  S20, S24
    FABS  S3, S18
    FABS  S25, S20
    FABS  S5, S25
    FABS  S0, S6
    FABS  S6, S0
    FABS  S14, S16
    FABS  S27, S7
    FADD  D7, D8, D14
    FADD  D14, D1, D16
    FADD  D25, D27, D26
    FADD  D16, D25, D6
    FADD  D17, D5, D3
    FADD  D18, D17, D12
    FADD  D0, D29, D28
    FADD  D8, D16, D14
    FADD  D26, D0, D0
    FADD  D3, D18, D7
    FADD  S0, S22, S3
    FADD  S16, S18, S10
    FADD  S28, S26, S26
    FADD  S27, S12, S12
    FADD  S18, S8, S16
    FADD  S10, S18, S27
    FADD  S25, S28, S20
    FADD  S22, S5, S17
    FADD  S7, S0, S0
    FADD  S17, S7, S31
    FDIV  D17, D22, D12
    FDIV  D24, D15, D10
    FDIV  D8, D25, D22
    FDIV  D29, D8, D8
    FDIV  D7, D17, D29
    FDIV  D15, D27, D21
    FDIV  D30, D3, D10
    FDIV  D26, D20, D9
    FDIV  D29, D7, D28
    FDIV  D8, D18, D22
    FDIV  S5, S11, S18
    FDIV  S10, S13, S17
    FDIV  S12, S26, S3
    FDIV  S31, S26, S12
    FDIV  S16, S2, S14
    FDIV  S10, S10, S5
    FDIV  S10, S29, S12
    FDIV  S7, S28, S25
    FDIV  S14, S29, S8
    FDIV  S13, S10, S9
    FMADD  D29, D31, D15, D17
    FMADD  D21, D24, D16, D17
    FMADD  D9, D19, D30, D14
    FMADD  D26, D29, D7, D21
    FMADD  D15, D31, D13, D8
    FMADD  D1, D30, D26, D24
    FMADD  D22, D29, D1, D9
    FMADD  D0, D26, D6, D25
    FMADD  D13, D0, D26, D30
    FMADD  D29, D12, D2, D7
    FMADD  S13, S15, S26, S31
    FMADD  S25, S28, S28, S17
    FMADD  S24, S31, S17, S9
    FMADD  S26, S10, S23, S27
    FMADD  S11, S9, S7, S30
    FMADD  S8, S13, S0, S27
    FMADD  S2, S24, S25, S8
    FMADD  S19, S25, S26, S16
    FMADD  S0, S22, S9, S0
    FMADD  S6, S13, S17, S28
    FMOV  S15, W23
    FMOV  S10, W29
    FMOV  S28, W18
    FMOV  S24, W26
    FMOV  S16, W18
    FMOV  S26, W2
    FMOV  S12, W11
    FMOV  S23, W24
    FMOV  S27, W24
    FMOV  S17, W13
    FMOV  D30, X6
    FMOV  D13, X6
    FMOV  D31, X20
    FMOV  D25, X2
    FMOV  D8, X25
    FMOV  D22, X17
    FMOV  D9, X11
    FMOV  D21, X26
    FMOV  D6, X5
    FMOV  D31, X7
    FMOV  X18, D28
    FMOV  X11, D12
    FMOV  X23, D24
    FMOV  X18, D16
    FMOV  X6, D27
    FMOV  X6, D25
    FMOV  X24, D22
    FMOV  X24, D17
    FMOV  X17, D9
    FMOV  X6, D31
    FMOV  W26, S4
    FMOV  W7, S15
    FMOV  W25, S10
    FMOV  W6, S6
    FMOV  W4, S8
    FMOV  W5, S21
    FMOV  W19, S26
    FMOV  W4, S10
    FMOV  W26, S30
    FMOV  W2, S21
    FMOV  D22, D13
    FMOV  D12, D6
    FMOV  D10, D23
    FMOV  D13, D17
    FMOV  D26, D20
    FMOV  D30, D6
    FMOV  D15, D12
    FMOV  D23, D2
    FMOV  D9, D7
    FMOV  D6, D8
    FMOV  S19, S8
    FMOV  S12, S30
    FMOV  S29, S26
    FMOV  S26, S12
    FMOV  S7, S23
    FMOV  S23, S9
    FMOV  S17, S13
    FMOV  S2, S6
    FMOV  S21, S23
    FMOV  S19, S7
    FMOV  D7, #0.18750000
    FMOV  D13, #-11.50000000
    FMOV  D26, #21.00000000
    FMOV  D9, #0.42187500
    FMOV  D24, #-0.34375000
    FMOV  D12, #-7.50000000
    FMOV  D10, #7.00000000
    FMOV  D30, #-25.00000000
    FMOV  D5, #19.00000000
    FMOV  D28, #-11.50000000
    FMOV  S6, #2.50000000
    FMOV  S23, #5.25000000
    FMOV  S31, #-0.29687500
    FMOV  S13, #-4.25000000
    FMOV  S7, #-11.50000000
    FMOV  S25, #3.12500000
    FMOV  S28, #-11.50000000
    FMOV  S12, #0.87500000
    FMOV  S30, #-0.78125000
    FMOV  S17, #-3.25000000
    FMSUB  D14, D26, D7, D12
    FMSUB  D11, D5, D6, D31
    FMSUB  D2, D10, D17, D8
    FMSUB  D14, D24, D11, D30
    FMSUB  D28, D4, D14, D31
    FMSUB  D3, D19, D0, D25
    FMSUB  D12, D3, D21, D21
    FMSUB  D24, D20, D4, D13
    FMSUB  D9, D7, D9, D26
    FMSUB  D26, D2, D9, D12
    FMSUB  S21, S23, S3, S23
    FMSUB  S13, S17, S3, S5
    FMSUB  S22, S2, S2, S21
    FMSUB  S24, S28, S28, S13
    FMSUB  S28, S26, S2, S24
    FMSUB  S20, S2, S8, S13
    FMSUB  S4, S28, S21, S23
    FMSUB  S13, S12, S14, S3
    FMSUB  S11, S9, S22, S3
    FMSUB  S10, S15, S9, S28
    FMUL  D26, D13, D14
    FMUL  D3, D16, D4
    FMUL  D12, D23, D19
    FMUL  D19, D4, D30
    FMUL  D21, D16, D29
    FMUL  D9, D3, D9
    FMUL  D13, D11, D31
    FMUL  D29, D4, D30
    FMUL  D17, D19, D29
    FMUL  D31, D10, D20
    FMUL  S14, S21, S19
    FMUL  S15, S13, S23
    FMUL  S4, S17, S17
    FMUL  S24, S26, S18
    FMUL  S16, S27, S27
    FMUL  S17, S4, S20
    FMUL  S3, S24, S9
    FMUL  S30, S22, S31
    FMUL  S27, S30, S15
    FMUL  S28, S14, S14
    FNEG  D10, D3
    FNEG  D26, D28
    FNEG  D24, D18
    FNEG  D21, D26
    FNEG  D25, D16
    FNEG  D22, D22
    FNEG  D13, D10
    FNEG  D14, D23
    FNEG  D26, D21
    FNEG  D3, D17
    FNEG  S9, S27
    FNEG  S16, S16
    FNEG  S28, S3
    FNEG  S17, S16
    FNEG  S11, S17
    FNEG  S18, S25
    FNEG  S10, S11
    FNEG  S27, S13
    FNEG  S28, S22
    FNEG  S13, S20
    FNMADD  D25, D10, D26, D24
    FNMADD  D24, D27, D26, D8
    FNMADD  D8, D9, D9, D18
    FNMADD  D17, D8, D9, D25
    FNMADD  D5, D24, D17, D6
    FNMADD  D31, D16, D8, D14
    FNMADD  D27, D13, D28, D28
    FNMADD  D14, D22, D7, D0
    FNMADD  D7, D31, D31, D27
    FNMADD  D21, D1, D7, D23
    FNMADD  S27, S21, S19, S14
    FNMADD  S3, S22, S12, S2
    FNMADD  S2, S4, S23, S8
    FNMADD  S21, S5, S28, S31
    FNMADD  S0, S28, S3, S23
    FNMADD  S22, S19, S15, S19
    FNMADD  S12, S21, S2, S24
    FNMADD  S10, S20, S2, S28
    FNMADD  S5, S12, S8, S11
    FNMADD  S31, S16, S1, S21
    FNMSUB  D3, D12, D28, D20
    FNMSUB  D9, D1, D0, D29
    FNMSUB  D11, D31, D21, D1
    FNMSUB  D24, D28, D6, D19
    FNMSUB  D17, D15, D1, D2
    FNMSUB  D7, D21, D2, D3
    FNMSUB  D20, D17, D25, D10
    FNMSUB  D6, D11, D12, D22
    FNMSUB  D4, D27, D9, D6
    FNMSUB  D2, D4, D14, D24
    FNMSUB  S24, S20, S20, S2
    FNMSUB  S30, S5, S24, S5
    FNMSUB  S23, S17, S11, S6
    FNMSUB  S15, S14, S11, S1
    FNMSUB  S10, S21, S1, S27
    FNMSUB  S21, S10, S9, S11
    FNMSUB  S8, S12, S0, S15
    FNMSUB  S29, S14, S30, S31
    FNMSUB  S12, S11, S22, S12
    FNMSUB  S9, S30, S17, S15
    FNMUL  D10, D2, D20
    FNMUL  D27, D21, D2
    FNMUL  D30, D19, D13
    FNMUL  D5, D31, D12
    FNMUL  D3, D7, D26
    FNMUL  D0, D23, D22
    FNMUL  D15, D27, D16
    FNMUL  D7, D20, D5
    FNMUL  D16, D0, D20
    FNMUL  D22, D28, D29
    FNMUL  S11, S10, S3
    FNMUL  S23, S15, S28
    FNMUL  S5, S15, S8
    FNMUL  S27, S30, S9
    FNMUL  S19, S22, S10
    FNMUL  S1, S16, S21
    FNMUL  S9, S25, S7
    FNMUL  S28, S19, S11
    FNMUL  S3, S28, S23
    FNMUL  S1, S7, S1
    FSUB  D0, D16, D14
    FSUB  D26, D31, D23
    FSUB  D30, D2, D1
    FSUB  D1, D3, D0
    FSUB  D28, D16, D12
    FSUB  D3, D9, D28
    FSUB  D20, D28, D30
    FSUB  D21, D13, D7
    FSUB  D0, D1, D27
    FSUB  D26, D25, D31
    FSUB  S9, S0, S26
    FSUB  S23, S5, S10
    FSUB  S13, S3, S18
    FSUB  S31, S12, S9
    FSUB  S16, S31, S20
    FSUB  S10, S3, S31
    FSUB  S28, S29, S16
    FSUB  S20, S10, S10
    FSUB  S9, S28, S28
    FSUB  S25, S22, S8
    MOVZ  X14, #0x4c40, LSL #0
    MOVK  X14, #0x4317, LSL #16
    SUB  X16, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0xe20d, LSL #0
    MOVK  X14, #0xb03e, LSL #16
    MOVK  X14, #0x7bc7, LSL #32
    MOVK  X14, #0x8781, LSL #48
    SUB  X16, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x9aaf, LSL #0
    MOVK  X14, #0x17f1, LSL #16
    SUB  X16, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x4c40, LSL #0
    MOVK  X14, #0x4317, LSL #16
    SUB  X16, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x453a, LSL #0
    MOVK  X14, #0xfa19, LSL #16
    SUB  X16, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x66e3, LSL #0
    MOVK  X14, #0x7671, LSL #16
    SUB  X16, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0xfa52, LSL #0
    MOVK  X14, #0x86c1, LSL #16
    SUB  X16, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x953a, LSL #0
    MOVK  X14, #0xa049, LSL #16
    MOVK  X14, #0xb00b, LSL #32
    MOVK  X14, #0xe5dc, LSL #48
    SUB  X16, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0xfa52, LSL #0
    MOVK  X14, #0x86c1, LSL #16
    MOVK  X14, #0x3614, LSL #32
    MOVK  X14, #0x96a6, LSL #48
    SUB  X16, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0xc85b, LSL #0
    MOVK  X14, #0x110d, LSL #16
    SUB  X16, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x3b87, LSL #0
    MOVK  X14, #0xdd4b, LSL #16
    SUB  X16, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0xfe35, LSL #0
    MOVK  X14, #0x1ad4, LSL #16
    MOVK  X14, #0x1818, LSL #32
    MOVK  X14, #0x2dc7, LSL #48
    SUB  X16, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x9050, LSL #0
    MOVK  X14, #0x372e, LSL #16
    MOVK  X14, #0x9ac4, LSL #32
    MOVK  X14, #0x2a3d, LSL #48
    SUB  X16, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x4c40, LSL #0
    MOVK  X14, #0x4317, LSL #16
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x953a, LSL #0
    MOVK  X14, #0xa049, LSL #16
    SUB  X16, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x9aaf, LSL #0
    MOVK  X14, #0x17f1, LSL #16
    SUB  X16, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0xe919, LSL #0
    MOVK  X14, #0xbc57, LSL #16
    SUB  X16, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x756a, LSL #0
    MOVK  X14, #0x53f9, LSL #16
    MOVK  X14, #0x26ac, LSL #32
    MOVK  X14, #0x551e, LSL #48
    SUB  X16, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0xc30d, LSL #0
    MOVK  X14, #0xdda1, LSL #16
    MOVK  X14, #0x3760, LSL #32
    MOVK  X14, #0xaaf8, LSL #48
    SUB  X16, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X14, #0x9aaf, LSL #0
    MOVK  X14, #0x17f1, LSL #16
    MOVK  X14, #0xc81, LSL #32
    MOVK  X14, #0x3518, LSL #48
    SUB  X16, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MRS  X14, FPSR
    MOVZ  X16, #0x1c, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D0
    MOVZ  X16, #0xc30c, LSL #0
    MOVK  X16, #0x5da1, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D1
    MOVZ  X16, #0x3cf4, LSL #0
    MOVK  X16, #0x225e, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D3
    MOVZ  X16, #0x1d64, LSL #0
    MOVK  X16, #0xdf82, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D4
    MOVZ  X16, #0xc858, LSL #0
    MOVK  X16, #0x7975, LSL #16
    MOVK  X16, #0xc3a3, LSL #32
    MOVK  X16, #0x9eb6, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D5
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D6
    MOVZ  X16, #0xc857, LSL #0
    MOVK  X16, #0x7975, LSL #16
    MOVK  X16, #0xc3a3, LSL #32
    MOVK  X16, #0x1eb6, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D7
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D8
    MOVZ  X16, #0x3b65, LSL #0
    MOVK  X16, #0x73c2, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D9
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D10
    MOVZ  X16, #0xc310, LSL #0
    MOVK  X16, #0x5da1, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D11
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D12
    MOVZ  X16, #0x1d64, LSL #0
    MOVK  X16, #0xdf82, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D13
    MOVZ  X16, #0x9260, LSL #0
    MOVK  X16, #0xdf81, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D14
    MOVZ  X16, #0xc30c, LSL #0
    MOVK  X16, #0x5da1, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D16
    MOVZ  X16, #0xc310, LSL #0
    MOVK  X16, #0xdda1, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D17
    MOVZ  X16, #0x444, LSL #0
    MOVK  X16, #0x5b8b, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D18
    MOVZ  X16, #0x444, LSL #0
    MOVK  X16, #0xdb8b, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D19
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D20
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D21
    MOVZ  X16, #0x7ffe, LSL #0
    MOVK  X16, #0xc122, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D22
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D23
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D24
    MOVZ  X16, #0x569c, LSL #0
    MOVK  X16, #0x7af3, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D25
    MOVZ  X16, #0x3b65, LSL #0
    MOVK  X16, #0xf3c2, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D26
    MOVZ  X16, #0x5711, LSL #0
    MOVK  X16, #0x515d, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D27
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D28
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0x7f7f, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D29
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0x7f7f, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D30
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X14, D31
    MOVZ  X16, #0x3995, LSL #0
    MOVK  X16, #0xdf8c, LSL #16
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xe591, LSL #0
    MOVK  X2, #0x48af, LSL #16
    MOVK  X2, #0x9c4, LSL #32
    MOVK  X2, #0xcfd8, LSL #48
    MOVZ  X3, #0x72dc, LSL #0
    MOVK  X3, #0x5c11, LSL #16
    MOVK  X3, #0x3985, LSL #32
    MOVK  X3, #0xd271, LSL #48
    MOVZ  X4, #0xe390, LSL #0
    MOVK  X4, #0x5302, LSL #16
    MOVK  X4, #0x1b63, LSL #32
    MOVK  X4, #0xd0b5, LSL #48
    MOVZ  X5, #0x26e5, LSL #0
    MOVK  X5, #0x684a, LSL #16
    MOVK  X5, #0x6388, LSL #32
    MOVK  X5, #0xca0a, LSL #48
    MOVZ  X6, #0x4da6, LSL #0
    MOVK  X6, #0x872b, LSL #16
    MOVK  X6, #0x4227, LSL #32
    MOVK  X6, #0xd91f, LSL #48
    MOVZ  X7, #0xf0c8, LSL #0
    MOVK  X7, #0xe19d, LSL #16
    MOVK  X7, #0x815a, LSL #32
    MOVK  X7, #0xbbc2, LSL #48
    MOVZ  X11, #0xd79b, LSL #0
    MOVK  X11, #0xbf9d, LSL #16
    MOVK  X11, #0xce64, LSL #32
    MOVK  X11, #0x703e, LSL #48
    MOVZ  X13, #0x18eb, LSL #0
    MOVK  X13, #0xfac9, LSL #16
    MOVK  X13, #0x6e17, LSL #32
    MOVK  X13, #0x4a1, LSL #48
    MOVZ  X14, #0xc798, LSL #0
    MOVK  X14, #0xb0d4, LSL #16
    MOVK  X14, #0x4962, LSL #32
    MOVK  X14, #0x7397, LSL #48
    MOVZ  X16, #0xd24, LSL #0
    MOVK  X16, #0x79a6, LSL #16
    MOVK  X16, #0x7adb, LSL #32
    MOVK  X16, #0x3691, LSL #48
    MOVZ  X17, #0xf298, LSL #0
    MOVK  X17, #0x3622, LSL #16
    MOVK  X17, #0xf80a, LSL #32
    MOVK  X17, #0xbe2, LSL #48
    MOVZ  X18, #0x801b, LSL #0
    MOVK  X18, #0x1846, LSL #16
    MOVK  X18, #0xd7fe, LSL #32
    MOVK  X18, #0x876a, LSL #48
    MOVZ  X19, #0x2341, LSL #0
    MOVK  X19, #0x164e, LSL #16
    MOVK  X19, #0xd434, LSL #32
    MOVK  X19, #0xcce8, LSL #48
    MOVZ  X20, #0xc4f7, LSL #0
    MOVK  X20, #0x58d2, LSL #16
    MOVK  X20, #0x76ae, LSL #32
    MOVK  X20, #0xb0e1, LSL #48
    MOVZ  X21, #0x5daa, LSL #0
    MOVK  X21, #0x8d64, LSL #16
    MOVK  X21, #0x7270, LSL #32
    MOVK  X21, #0x7c7c, LSL #48
    MOVZ  X22, #0xc9bb, LSL #0
    MOVK  X22, #0x6062, LSL #16
    MOVK  X22, #0x975a, LSL #32
    MOVK  X22, #0x115c, LSL #48
    MOVZ  X23, #0xc3c6, LSL #0
    MOVK  X23, #0x988f, LSL #16
    MOVK  X23, #0xbbb4, LSL #32
    MOVK  X23, #0xe51b, LSL #48
    MOVZ  X24, #0x8b46, LSL #0
    MOVK  X24, #0xde2, LSL #16
    MOVK  X24, #0xf31b, LSL #32
    MOVK  X24, #0xc5dc, LSL #48
    MOVZ  X25, #0xff3d, LSL #0
    MOVK  X25, #0x8a79, LSL #16
    MOVK  X25, #0x7062, LSL #32
    MOVK  X25, #0x68a8, LSL #48
    MOVZ  X26, #0x1fe5, LSL #0
    MOVK  X26, #0x52ac, LSL #16
    MOVK  X26, #0x6535, LSL #32
    MOVK  X26, #0xcf24, LSL #48
    MOVZ  X27, #0xfd41, LSL #0
    MOVK  X27, #0xf35f, LSL #16
    MOVK  X27, #0xdcd, LSL #32
    MOVK  X27, #0x2b09, LSL #48
    MOVZ  X28, #0xe15e, LSL #0
    MOVK  X28, #0x1af5, LSL #16
    MOVK  X28, #0xa8cd, LSL #32
    MOVK  X28, #0x3b79, LSL #48
    MOVZ  X29, #0xa9d8, LSL #0
    MOVK  X29, #0x3db1, LSL #16
    MOVK  X29, #0x337b, LSL #32
    MOVK  X29, #0x7617, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X13
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X28
    FMOV  V3.D[1], X24
    FMOV  D4, X23
    FMOV  V4.D[1], X26
    FMOV  D5, X24
    FMOV  V5.D[1], X11
    FMOV  D6, X16
    FMOV  V6.D[1], X24
    FMOV  D7, X19
    FMOV  V7.D[1], X2
    FMOV  D8, X4
    FMOV  V8.D[1], X4
    FMOV  D9, X7
    FMOV  V9.D[1], X11
    FMOV  D10, X28
    FMOV  V10.D[1], X18
    FMOV  D11, X13
    FMOV  V11.D[1], X6
    FMOV  D12, X18
    FMOV  V12.D[1], X11
    FMOV  D13, X19
    FMOV  V13.D[1], X17
    FMOV  D14, X27
    FMOV  V14.D[1], X25
    FMOV  D15, X6
    FMOV  V15.D[1], X25
    FMOV  D16, X3
    FMOV  V16.D[1], X22
    FMOV  D17, X14
    FMOV  V17.D[1], X22
    FMOV  D18, X5
    FMOV  V18.D[1], X23
    FMOV  D19, X23
    FMOV  V19.D[1], X18
    FMOV  D20, X23
    FMOV  V20.D[1], X28
    FMOV  D21, X26
    FMOV  V21.D[1], X29
    FMOV  D22, X26
    FMOV  V22.D[1], X29
    FMOV  D23, X17
    FMOV  V23.D[1], X26
    FMOV  D24, X18
    FMOV  V24.D[1], X5
    FMOV  D25, X26
    FMOV  V25.D[1], X23
    FMOV  D26, X27
    FMOV  V26.D[1], X26
    FMOV  D27, X2
    FMOV  V27.D[1], X5
    FMOV  D28, X4
    FMOV  V28.D[1], X25
    FMOV  D29, X19
    FMOV  V29.D[1], X24
    FMOV  D30, X27
    FMOV  V30.D[1], X27
    FMOV  D31, X5
    FMOV  V31.D[1], X18
    FABS  H27, H27
    FABS  H5, H26
    FABS  H3, H30
    FABS  H9, H25
    FABS  H18, H31
    FABS  H3, H6
    FABS  H6, H28
    FABS  H13, H15
    FABS  H10, H27
    FABS  H18, H29
    FADD  H23, H13, H19
    FADD  H9, H5, H29
    FADD  H11, H6, H9
    FADD  H4, H24, H24
    FADD  H28, H25, H10
    FADD  H27, H21, H11
    FADD  H24, H28, H13
    FADD  H25, H27, H23
    FADD  H29, H20, H24
    FADD  H31, H25, H30
    FDIV  H11, H15, H29
    FDIV  H24, H11, H30
    FDIV  H30, H29, H4
    FDIV  H7, H9, H30
    FDIV  H23, H1, H22
    FDIV  H13, H7, H20
    FDIV  H1, H24, H13
    FDIV  H22, H1, H1
    FDIV  H1, H18, H31
    FDIV  H5, H2, H22
    FMADD  H20, H5, H6, H23
    FMADD  H3, H25, H23, H27
    FMADD  H28, H1, H17, H14
    FMADD  H11, H29, H12, H3
    FMADD  H7, H11, H28, H11
    FMADD  H30, H17, H12, H17
    FMADD  H9, H19, H28, H1
    FMADD  H4, H10, H27, H11
    FMADD  H17, H13, H28, H12
    FMADD  H10, H11, H1, H24
    FMOV  H13, W24
    FMOV  H25, W5
    FMOV  H23, W13
    FMOV  H19, W11
    FMOV  H21, W3
    FMOV  H11, W2
    FMOV  H7, W16
    FMOV  H31, W5
    FMOV  H24, W20
    FMOV  H22, W2
    FMOV  H5, X5
    FMOV  H18, X25
    FMOV  H7, X22
    FMOV  H29, X22
    FMOV  H2, X20
    FMOV  H11, X20
    FMOV  H12, X2
    FMOV  H11, X21
    FMOV  H28, X28
    FMOV  H1, X21
    FMOV  W25, H28
    FMOV  W14, H29
    FMOV  W21, H7
    FMOV  W17, H2
    FMOV  W14, H24
    FMOV  W24, H12
    FMOV  W20, H5
    FMOV  W21, H3
    FMOV  W25, H31
    FMOV  W14, H1
    FMOV  X27, H18
    FMOV  X5, H11
    FMOV  X25, H16
    FMOV  X11, H1
    FMOV  X28, H11
    FMOV  X7, H14
    FMOV  X19, H18
    FMOV  X27, H3
    FMOV  X28, H17
    FMOV  X19, H14
    FMOV  H31, H27
    FMOV  H11, H0
    FMOV  H14, H12
    FMOV  H5, H5
    FMOV  H0, H0
    FMOV  H27, H18
    FMOV  H3, H20
    FMOV  H7, H22
    FMOV  H20, H10
    FMOV  H13, H7
    FMOV  H17, #-26.00000000
    FMOV  H5, #1.00000000
    FMOV  H28, #-5.25000000
    FMOV  H10, #-1.62500000
    FMOV  H7, #-0.45312500
    FMOV  H25, #-1.00000000
    FMOV  H22, #5.00000000
    FMOV  H18, #0.75000000
    FMOV  H1, #2.37500000
    FMOV  H5, #-12.00000000
    FMSUB  H28, H31, H11, H0
    FMSUB  H14, H2, H2, H25
    FMSUB  H10, H27, H3, H2
    FMSUB  H1, H13, H18, H10
    FMSUB  H22, H5, H20, H28
    FMSUB  H17, H14, H22, H18
    FMSUB  H25, H12, H1, H31
    FMSUB  H10, H7, H17, H19
    FMSUB  H13, H22, H11, H26
    FMSUB  H3, H13, H20, H2
    FMUL  H2, H21, H10
    FMUL  H3, H23, H26
    FMUL  H14, H1, H24
    FMUL  H22, H25, H22
    FMUL  H25, H3, H21
    FMUL  H31, H3, H24
    FMUL  H20, H7, H2
    FMUL  H26, H6, H19
    FMUL  H30, H7, H17
    FMUL  H10, H23, H30
    FNEG  H5, H31
    FNEG  H27, H6
    FNEG  H0, H25
    FNEG  H17, H6
    FNEG  H31, H27
    FNEG  H3, H10
    FNEG  H21, H14
    FNEG  H7, H20
    FNEG  H6, H7
    FNEG  H8, H31
    FNMADD  H31, H6, H6, H14
    FNMADD  H10, H26, H20, H8
    FNMADD  H23, H10, H16, H31
    FNMADD  H16, H17, H23, H5
    FNMADD  H8, H12, H0, H2
    FNMADD  H26, H10, H13, H26
    FNMADD  H7, H16, H3, H20
    FNMADD  H5, H8, H25, H19
    FNMADD  H1, H5, H21, H22
    FNMADD  H19, H7, H1, H1
    FNMSUB  H31, H10, H23, H18
    FNMSUB  H30, H4, H3, H28
    FNMSUB  H17, H8, H28, H7
    FNMSUB  H20, H12, H17, H3
    FNMSUB  H3, H12, H1, H6
    FNMSUB  H22, H15, H11, H2
    FNMSUB  H16, H22, H24, H9
    FNMSUB  H25, H13, H0, H6
    FNMSUB  H18, H23, H16, H31
    FNMSUB  H4, H27, H31, H16
    FNMUL  H16, H24, H30
    FNMUL  H21, H25, H15
    FNMUL  H17, H27, H14
    FNMUL  H31, H21, H18
    FNMUL  H2, H17, H16
    FNMUL  H13, H0, H26
    FNMUL  H24, H2, H4
    FNMUL  H16, H3, H19
    FNMUL  H10, H31, H20
    FNMUL  H31, H13, H10
    FSUB  H22, H16, H31
    FSUB  H3, H18, H27
    FSUB  H1, H13, H29
    FSUB  H10, H22, H1
    FSUB  H17, H27, H8
    FSUB  H19, H21, H12
    FSUB  H0, H29, H18
    FSUB  H18, H17, H16
    FSUB  H1, H22, H26
    FSUB  H5, H19, H13
    FSQRT  D15, D5
    FSQRT  D4, D19
    FSQRT  D14, D2
    FSQRT  D17, D10
    FSQRT  D10, D3
    FSQRT  D2, D24
    FSQRT  D5, D17
    FSQRT  D6, D0
    FSQRT  D12, D15
    FSQRT  D3, D0
    FSQRT  S16, S6
    FSQRT  S20, S0
    FSQRT  S1, S25
    FSQRT  S29, S4
    FSQRT  S21, S21
    FSQRT  S4, S13
    FSQRT  S6, S4
    FSQRT  S26, S18
    FSQRT  S0, S26
    FSQRT  S29, S12
    FSQRT  H13, H5
    FSQRT  H12, H10
    FSQRT  H17, H2
    FSQRT  H18, H1
    FSQRT  H5, H13
    FSQRT  H11, H21
    FSQRT  H30, H17
    FSQRT  H10, H20
    FSQRT  H13, H30
    FSQRT  H24, H3
    FCSEL  D20, D24, D14, EQ
    FCSEL  D4, D17, D21, CS
    FCSEL  D2, D24, D16, VS
    FCSEL  D14, D13, D13, EQ
    FCSEL  D20, D0, D14, NV
    FCSEL  D30, D12, D12, NE
    FCSEL  D18, D29, D29, CC
    FCSEL  D14, D18, D10, VS
    FCSEL  D29, D30, D30, GT
    FCSEL  D0, D15, D25, VS
    FCSEL  S25, S29, S9, VS
    FCSEL  S26, S14, S5, VC
    FCSEL  S15, S6, S20, NE
    FCSEL  S13, S15, S25, GT
    FCSEL  S10, S4, S11, HI
    FCSEL  S24, S24, S2, GT
    FCSEL  S12, S13, S5, HI
    FCSEL  S1, S23, S0, VC
    FCSEL  S18, S26, S27, NV
    FCSEL  S26, S10, S16, AL
    FCSEL  H16, H8, H5, LE
    FCSEL  H13, H24, H24, LS
    FCSEL  H12, H18, H31, NE
    FCSEL  H29, H26, H23, NE
    FCSEL  H25, H11, H25, MI
    FCSEL  H4, H1, H25, GE
    FCSEL  H20, H17, H8, LS
    FCSEL  H27, H16, H26, PL
    FCSEL  H8, H28, H21, GE
    FCSEL  H25, H10, H12, NE
    MOVZ  X18, #0xe591, LSL #0
    MOVK  X18, #0x48af, LSL #16
    MOVK  X18, #0x9c4, LSL #32
    MOVK  X18, #0xcfd8, LSL #48
    SUB  X23, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x72dc, LSL #0
    MOVK  X18, #0x5c11, LSL #16
    MOVK  X18, #0x3985, LSL #32
    MOVK  X18, #0xd271, LSL #48
    SUB  X23, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xe390, LSL #0
    MOVK  X18, #0x5302, LSL #16
    MOVK  X18, #0x1b63, LSL #32
    MOVK  X18, #0xd0b5, LSL #48
    SUB  X23, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x5daa, LSL #0
    SUB  X23, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x4da6, LSL #0
    MOVK  X18, #0x872b, LSL #16
    MOVK  X18, #0x4227, LSL #32
    MOVK  X18, #0xd91f, LSL #48
    SUB  X23, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xfd41, LSL #0
    SUB  X23, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x5daa, LSL #0
    SUB  X23, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x18eb, LSL #0
    MOVK  X18, #0xfac9, LSL #16
    MOVK  X18, #0x6e17, LSL #32
    MOVK  X18, #0x4a1, LSL #48
    SUB  X23, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x5daa, LSL #0
    SUB  X23, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xd24, LSL #0
    MOVK  X18, #0x79a6, LSL #16
    MOVK  X18, #0x7adb, LSL #32
    MOVK  X18, #0x3691, LSL #48
    SUB  X23, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xc4f7, LSL #0
    SUB  X23, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xfd41, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x26e5, LSL #0
    SUB  X23, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X23, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xc9bb, LSL #0
    MOVK  X18, #0x6062, LSL #16
    MOVK  X18, #0x975a, LSL #32
    MOVK  X18, #0x115c, LSL #48
    SUB  X23, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xe591, LSL #0
    SUB  X23, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x72dc, LSL #0
    SUB  X23, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x1fe5, LSL #0
    MOVK  X18, #0x52ac, LSL #16
    MOVK  X18, #0x6535, LSL #32
    MOVK  X18, #0xcf24, LSL #48
    SUB  X23, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X23, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X23, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MRS  X18, FPSR
    MOVZ  X23, #0x1f, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D0
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D1
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D2
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D3
    MOVZ  X23, #0x2f76, LSL #0
    MOVK  X23, #0x8d0e, LSL #16
    MOVK  X23, #0x732f, LSL #32
    MOVK  X23, #0x1ed6, LSL #48
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D4
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D5
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D6
    MOVZ  X23, #0xd908, LSL #0
    MOVK  X23, #0x2ed6, LSL #16
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D7
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D8
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D9
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D10
    MOVZ  X23, #0x4581, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D11
    MOVZ  X23, #0x4581, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D12
    MOVZ  X23, #0xfe00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D14
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D15
    MOVZ  X23, #0x4edb, LSL #0
    MOVK  X23, #0x2eb4, LSL #16
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D16
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D17
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D18
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D19
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D20
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D21
    MOVZ  X23, #0x4f93, LSL #0
    MOVK  X23, #0x1e34, LSL #16
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D22
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D23
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D24
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D25
    MOVZ  X23, #0xfe00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D26
    MOVZ  X23, #0x4581, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D27
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D28
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D29
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D30
    MOVZ  X23, #0x3576, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    FMOV  X18, D31
    MOVZ  X23, #0xfe00, LSL #0
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xf4f2, LSL #0
    MOVK  X2, #0x5d86, LSL #16
    MOVK  X2, #0x40f, LSL #32
    MOVK  X2, #0xc700, LSL #48
    MOVZ  X3, #0x6ad0, LSL #0
    MOVK  X3, #0x609b, LSL #16
    MOVK  X3, #0xa6e8, LSL #32
    MOVK  X3, #0x33a6, LSL #48
    MOVZ  X4, #0x4a22, LSL #0
    MOVK  X4, #0x7ac8, LSL #16
    MOVK  X4, #0xe532, LSL #32
    MOVK  X4, #0x8b66, LSL #48
    MOVZ  X5, #0x510b, LSL #0
    MOVK  X5, #0x95bc, LSL #16
    MOVK  X5, #0x9d0a, LSL #32
    MOVK  X5, #0x8783, LSL #48
    MOVZ  X6, #0x9e83, LSL #0
    MOVK  X6, #0x3ebf, LSL #16
    MOVK  X6, #0x4397, LSL #32
    MOVK  X6, #0xb773, LSL #48
    MOVZ  X7, #0xf7e, LSL #0
    MOVK  X7, #0x66d0, LSL #16
    MOVK  X7, #0xda4d, LSL #32
    MOVK  X7, #0xbaa3, LSL #48
    MOVZ  X11, #0x9d74, LSL #0
    MOVK  X11, #0x1781, LSL #16
    MOVK  X11, #0x171f, LSL #32
    MOVK  X11, #0xe525, LSL #48
    MOVZ  X13, #0xfda9, LSL #0
    MOVK  X13, #0x65ef, LSL #16
    MOVK  X13, #0xe961, LSL #32
    MOVK  X13, #0x273, LSL #48
    MOVZ  X14, #0x178d, LSL #0
    MOVK  X14, #0xe640, LSL #16
    MOVK  X14, #0xfeef, LSL #32
    MOVK  X14, #0xa835, LSL #48
    MOVZ  X16, #0x6d50, LSL #0
    MOVK  X16, #0x452f, LSL #16
    MOVK  X16, #0x53db, LSL #32
    MOVK  X16, #0xc187, LSL #48
    MOVZ  X17, #0x4552, LSL #0
    MOVK  X17, #0xa0cd, LSL #16
    MOVK  X17, #0x90db, LSL #32
    MOVK  X17, #0xec74, LSL #48
    MOVZ  X18, #0x509c, LSL #0
    MOVK  X18, #0x4098, LSL #16
    MOVK  X18, #0xd812, LSL #32
    MOVK  X18, #0x2cc4, LSL #48
    MOVZ  X19, #0x2f19, LSL #0
    MOVK  X19, #0x6838, LSL #16
    MOVK  X19, #0x3bf2, LSL #32
    MOVK  X19, #0x530b, LSL #48
    MOVZ  X20, #0x8225, LSL #0
    MOVK  X20, #0x5aa8, LSL #16
    MOVK  X20, #0x3e50, LSL #32
    MOVK  X20, #0x266e, LSL #48
    MOVZ  X21, #0x51, LSL #0
    MOVK  X21, #0x5de9, LSL #16
    MOVK  X21, #0xbbaf, LSL #32
    MOVK  X21, #0xf2a3, LSL #48
    MOVZ  X22, #0x18e6, LSL #0
    MOVK  X22, #0x8d72, LSL #16
    MOVK  X22, #0xec84, LSL #32
    MOVK  X22, #0xa443, LSL #48
    MOVZ  X23, #0x7ca9, LSL #0
    MOVK  X23, #0xa1ea, LSL #16
    MOVK  X23, #0x6bb4, LSL #32
    MOVK  X23, #0xe9e0, LSL #48
    MOVZ  X24, #0x1953, LSL #0
    MOVK  X24, #0x4d91, LSL #16
    MOVK  X24, #0xeeef, LSL #32
    MOVK  X24, #0x30b6, LSL #48
    MOVZ  X25, #0x81a1, LSL #0
    MOVK  X25, #0x80b0, LSL #16
    MOVK  X25, #0x1e3e, LSL #32
    MOVK  X25, #0xb552, LSL #48
    MOVZ  X26, #0x45c7, LSL #0
    MOVK  X26, #0x1a45, LSL #16
    MOVK  X26, #0xf07, LSL #32
    MOVK  X26, #0x3d33, LSL #48
    MOVZ  X27, #0xa98, LSL #0
    MOVK  X27, #0xbb37, LSL #16
    MOVK  X27, #0x5858, LSL #32
    MOVK  X27, #0xbca4, LSL #48
    MOVZ  X28, #0x1c7, LSL #0
    MOVK  X28, #0x444a, LSL #16
    MOVK  X28, #0x6f40, LSL #32
    MOVK  X28, #0x4301, LSL #48
    MOVZ  X29, #0x5453, LSL #0
    MOVK  X29, #0x3535, LSL #16
    MOVK  X29, #0xf468, LSL #32
    MOVK  X29, #0x7b3a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X13
    FMOV  D2, X19
    FMOV  V2.D[1], X24
    FMOV  D3, X27
    FMOV  V3.D[1], X28
    FMOV  D4, X17
    FMOV  V4.D[1], X4
    FMOV  D5, X25
    FMOV  V5.D[1], X17
    FMOV  D6, X11
    FMOV  V6.D[1], X6
    FMOV  D7, X26
    FMOV  V7.D[1], X29
    FMOV  D8, X24
    FMOV  V8.D[1], X14
    FMOV  D9, X24
    FMOV  V9.D[1], X20
    FMOV  D10, X25
    FMOV  V10.D[1], X28
    FMOV  D11, X26
    FMOV  V11.D[1], X24
    FMOV  D12, X7
    FMOV  V12.D[1], X29
    FMOV  D13, X4
    FMOV  V13.D[1], X13
    FMOV  D14, X5
    FMOV  V14.D[1], X7
    FMOV  D15, X21
    FMOV  V15.D[1], X18
    FMOV  D16, X24
    FMOV  V16.D[1], X27
    FMOV  D17, X7
    FMOV  V17.D[1], X6
    FMOV  D18, X18
    FMOV  V18.D[1], X3
    FMOV  D19, X26
    FMOV  V19.D[1], X7
    FMOV  D20, X23
    FMOV  V20.D[1], X11
    FMOV  D21, X22
    FMOV  V21.D[1], X17
    FMOV  D22, X17
    FMOV  V22.D[1], X3
    FMOV  D23, X25
    FMOV  V23.D[1], X18
    FMOV  D24, X5
    FMOV  V24.D[1], X7
    FMOV  D25, X29
    FMOV  V25.D[1], X27
    FMOV  D26, X17
    FMOV  V26.D[1], X6
    FMOV  D27, X22
    FMOV  V27.D[1], X24
    FMOV  D28, X18
    FMOV  V28.D[1], X28
    FMOV  D29, X25
    FMOV  V29.D[1], X7
    FMOV  D30, X26
    FMOV  V30.D[1], X23
    FMOV  D31, X13
    FMOV  V31.D[1], X24
    MOVZ  X3, #0xa, LSL #0
TSRTFloatMovMadd_label_0:
    FMADD  D29, D0, D31, D23
    FMOV  H26, X13
    FNEG  H16, H22
    FMOV  S24, W4
    FSQRT  D27, D27
    FNMSUB  H14, H20, H30, H3
    FMUL  S27, S26, S7
    FMUL  S6, S11, S14
    FNMADD  H18, H28, H27, H28
    FMUL  H17, H18, H29
    FSQRT  D27, D14
    FMOV  H26, H24
    FNMUL  S30, S6, S21
    FCSEL  H28, H17, H30, LS
    FMOV  D14, D23
    FCSEL  D26, D26, D16, LS
    FMUL  S20, S26, S6
    FNMSUB  S7, S27, S27, S23
    FSUB  D3, D29, D21
    FSQRT  S27, S3
    FDIV  S25, S7, S14
    FMOV  S16, W5
    FMOV  W4, H20
    FSQRT  S7, S27
    FMADD  H27, H9, H8, H28
    FABS  H11, H25
    FCSEL  H29, H11, H27, NV
    FCSEL  D21, D29, D11, HI
    FABS  H3, H19
    FDIV  D19, D21, D7
    FNMUL  S8, S8, S10
    FMOV  X25, D16
    FMOV  H20, X25
    FCSEL  S26, S17, S28, LT
    FSQRT  S28, S18
    FSUB  S14, S12, S26
    FNMUL  D16, D3, D28
    FMOV  H9, #0.48437500
    FDIV  S29, S10, S21
    FADD  S9, S1, S6
    FNEG  S17, S16
    FMOV  W26, H13
    FSUB  S23, S8, S23
    FMOV  W29, H30
    FMOV  X18, D29
    FMOV  S6, S5
    FMOV  D25, #23.00000000
    FNMUL  D30, D17, D19
    FMUL  D21, D9, D23
    FSQRT  S16, S25
    FMOV  X17, H30
    FNMADD  D25, D6, D24, D27
    FMOV  D1, #-3.62500000
    FNMADD  H7, H1, H1, H19
    FCSEL  S15, S16, S13, MI
    FMOV  W25, S14
    FNEG  D18, D20
    FNEG  D17, D23
    FSUB  S13, S18, S14
    FNMUL  S23, S13, S7
    FSUB  H29, H27, H15
    FNEG  H16, H21
    FMSUB  H10, H0, H17, H13
    FMOV  D24, X5
    FMOV  X20, H29
    FMOV  D18, X5
    FADD  H27, H25, H16
    FNMSUB  S1, S16, S10, S23
    FMOV  D15, X6
    FMOV  H13, W13
    FDIV  H25, H27, H18
    FMOV  S23, W4
    FMUL  H30, H1, H20
    FDIV  S17, S23, S12
    FABS  D29, D10
    FADD  H14, H15, H7
    FMOV  H8, X29
    FMOV  D9, D4
    FNMSUB  D19, D14, D13, D25
    FNEG  S0, S29
    FMOV  H21, #21.00000000
    FMADD  H7, H17, H7, H20
    FNMSUB  D14, D8, D30, D25
    FNMSUB  H17, H31, H9, H22
    FSQRT  H23, H7
    FMOV  H16, X11
    FDIV  H22, H0, H26
    FSUB  S27, S24, S22
    FMADD  S8, S21, S19, S23
    FCSEL  H10, H21, H9, LS
    FMOV  S2, W4
    FNEG  D4, D24
    FMOV  W19, H14
    FNMADD  D12, D24, D4, D4
    FMOV  S26, #-1.43750000
    FMOV  X16, H26
    FNMUL  H30, H31, H12
    FMOV  D26, #21.00000000
    FNMADD  H7, H30, H20, H26
    FMOV  W4, S3
    FSUB  S26, S2, S17
    FNMUL  S21, S0, S6
    FMSUB  D6, D12, D7, D26
    FSQRT  S11, S10
    FMOV  W20, S19
    FABS  D24, D6
    FNMUL  H22, H13, H16
    FCSEL  D23, D27, D24, CC
    FSUB  S30, S22, S23
    FNMUL  S10, S28, S11
    FADD  H17, H10, H8
    FMOV  H14, W16
    FNMADD  H11, H16, H17, H17
    FABS  H23, H3
    FCSEL  H16, H4, H24, LT
    FCSEL  D20, D16, D16, CC
    FNMSUB  H2, H23, H18, H20
    FNMADD  S12, S26, S23, S7
    FCSEL  D7, D2, D21, VC
    FCSEL  S13, S3, S11, LE
    FNMSUB  D26, D3, D30, D30
    FNMUL  H8, H20, H26
    FMADD  D24, D0, D17, D4
    FCSEL  H31, H7, H7, LT
    FMOV  H19, W16
    FMOV  H6, W13
    FMOV  W17, S11
    FMUL  S17, S23, S4
    FNEG  S10, S13
    FNMSUB  D16, D24, D8, D12
    FMOV  H2, #8.50000000
    FNMADD  D20, D14, D4, D10
    FSUB  H10, H20, H20
    FABS  D27, D31
    FMOV  S21, W29
    FADD  D3, D6, D16
    FMSUB  H31, H10, H11, H21
    FMOV  S27, W5
    FSUB  H26, H4, H18
    FCSEL  H8, H26, H2, GE
    FMADD  D4, D15, D15, D4
    FNEG  D23, D8
    FNMUL  H1, H4, H5
    FNMADD  D15, D27, D1, D3
    FMADD  D14, D31, D15, D15
    FMOV  D2, #-4.25000000
    FABS  D1, D2
    FSUB  D0, D10, D17
    FNEG  H13, H14
    FMADD  D14, D0, D1, D25
    FMSUB  D20, D23, D23, D11
    FMADD  H23, H27, H20, H2
    FNMADD  S1, S14, S6, S13
    FNMUL  D2, D19, D16
    FMADD  H20, H15, H1, H1
    FMADD  S27, S0, S24, S12
    FSQRT  H24, H0
    FNMUL  D30, D27, D23
    FMOV  S28, #-1.18750000
    FMOV  H4, W3
    FMUL  D14, D15, D24
    FNEG  S13, S15
    FCSEL  D12, D13, D28, VC
    FNMUL  D10, D4, D2
    FNMSUB  D21, D16, D12, D31
    FMOV  S4, S14
    FABS  S13, S0
    FMADD  H6, H21, H20, H9
    FNMSUB  D14, D29, D10, D10
    FABS  H16, H26
    FMOV  H28, X19
    FMADD  H26, H28, H30, H13
    FMOV  D16, D25
    FCSEL  S28, S20, S12, GT
    FDIV  S1, S20, S16
    FNMSUB  H12, H28, H26, H25
    FADD  H21, H9, H21
    FDIV  S9, S20, S22
    FMADD  S30, S13, S6, S12
    FMADD  S16, S8, S21, S12
    FSUB  S27, S14, S28
    FCSEL  S26, S9, S14, GE
    FNMUL  S25, S6, S12
    FNMADD  S5, S1, S21, S16
    FABS  H28, H26
    FNMUL  H26, H17, H25
    FMSUB  D10, D28, D27, D28
    FADD  D8, D30, D30
    FNEG  D31, D29
    FSQRT  H13, H2
    FMUL  H25, H16, H31
    FNMSUB  D29, D12, D26, D8
    FMOV  H26, W26
    FMSUB  S13, S5, S24, S13
    FCSEL  H6, H26, H10, GT
    FNEG  S24, S6
    FABS  H10, H12
    FCSEL  H20, H24, H13, AL
    FNMSUB  D6, D11, D29, D18
    FNEG  D18, D25
    SUBS  X3, X3, #0x1
    B.NE  TSRTFloatMovMadd_label_0
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x510b, LSL #0
    MOVK  X2, #0x95bc, LSL #16
    MOVK  X2, #0x9d0a, LSL #32
    MOVK  X2, #0x8783, LSL #48
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x9e83, LSL #0
    MOVK  X2, #0x3ebf, LSL #16
    MOVK  X2, #0x4397, LSL #32
    MOVK  X2, #0xb773, LSL #48
    SUB  X28, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xf7e, LSL #0
    MOVK  X2, #0x66d0, LSL #16
    MOVK  X2, #0xda4d, LSL #32
    MOVK  X2, #0xbaa3, LSL #48
    SUB  X28, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x9d74, LSL #0
    MOVK  X2, #0x1781, LSL #16
    MOVK  X2, #0x171f, LSL #32
    MOVK  X2, #0xe525, LSL #48
    SUB  X28, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xfda9, LSL #0
    MOVK  X2, #0x65ef, LSL #16
    MOVK  X2, #0xe961, LSL #32
    MOVK  X2, #0x273, LSL #48
    SUB  X28, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x178d, LSL #0
    MOVK  X2, #0xe640, LSL #16
    MOVK  X2, #0xfeef, LSL #32
    MOVK  X2, #0xa835, LSL #48
    SUB  X28, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xc652, LSL #0
    SUB  X28, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x8000, LSL #0
    SUB  X28, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x8000, LSL #0
    SUB  X28, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x18e6, LSL #0
    MOVK  X2, #0x8d72, LSL #16
    MOVK  X2, #0xec84, LSL #32
    MOVK  X2, #0xa443, LSL #48
    SUB  X28, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x7ca9, LSL #0
    MOVK  X2, #0xa1ea, LSL #16
    MOVK  X2, #0x6bb4, LSL #32
    MOVK  X2, #0xe9e0, LSL #48
    SUB  X28, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x1953, LSL #0
    MOVK  X2, #0x4d91, LSL #16
    MOVK  X2, #0xeeef, LSL #32
    MOVK  X2, #0x30b6, LSL #48
    SUB  X28, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    SUB  X28, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xa98, LSL #0
    MOVK  X2, #0xbb37, LSL #16
    MOVK  X2, #0x5858, LSL #32
    MOVK  X2, #0xbca4, LSL #48
    SUB  X28, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    MRS  X2, FPSR
    MOVZ  X28, #0x1f, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D0
    MOVZ  X28, #0x8000, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x8000, LSL #48
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D1
    MOVZ  X28, #0xd800, LSL #0
    MOVK  X28, #0x3ff8, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D3
    MOVZ  X28, #0x5a36, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x8000, LSL #48
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D5
    MOVZ  X28, #0xf8d8, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D6
    MOVZ  X28, #0x510a, LSL #0
    MOVK  X28, #0x95bc, LSL #16
    MOVK  X28, #0x9d0a, LSL #32
    MOVK  X28, #0x783, LSL #48
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D7
    MOVZ  X28, #0x7e00, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D8
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xff80, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D9
    MOVZ  X28, #0xcd9b, LSL #0
    MOVK  X28, #0x3f7a, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D11
    MOVZ  X28, #0xc652, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D14
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D15
    MOVZ  X28, #0x5a35, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D17
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D18
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D21
    MOVZ  X28, #0x8000, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D22
    MOVZ  X28, #0xfe00, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D23
    MOVZ  X28, #0xdbf7, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D24
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D27
    MOVZ  X28, #0xf8d8, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D28
    MOVZ  X28, #0x4d9b, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D29
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xff80, LSL #16
    MOVK  X28, #0x8000, LSL #48
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D30
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7fc0, LSL #16
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X2, D31
    MOVZ  X28, #0x510b, LSL #0
    MOVK  X28, #0x8000, LSL #48
    SUB  X21, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    FMOV  D0, X29
    FMOV  V0.D[1], X21
    FMOV  D1, X13
    FMOV  V1.D[1], X14
    FMOV  D2, X24
    FMOV  V2.D[1], X17
    FMOV  D3, X11
    FMOV  V3.D[1], X22
    FMOV  D4, X16
    FMOV  V4.D[1], X28
    FMOV  D5, X29
    FMOV  V5.D[1], X16
    FMOV  D6, X27
    FMOV  V6.D[1], X20
    FMOV  D7, X18
    FMOV  V7.D[1], X25
    FMOV  D8, X13
    FMOV  V8.D[1], X5
    FMOV  D9, X11
    FMOV  V9.D[1], X2
    FMOV  D10, X16
    FMOV  V10.D[1], X11
    FMOV  D11, X21
    FMOV  V11.D[1], X23
    FMOV  D12, X18
    FMOV  V12.D[1], X14
    FMOV  D13, X7
    FMOV  V13.D[1], X23
    FMOV  D14, X19
    FMOV  V14.D[1], X26
    FMOV  D15, X23
    FMOV  V15.D[1], X21
    FMOV  D16, X13
    FMOV  V16.D[1], X27
    FMOV  D17, X21
    FMOV  V17.D[1], X7
    FMOV  D18, X20
    FMOV  V18.D[1], X25
    FMOV  D19, X21
    FMOV  V19.D[1], X6
    FMOV  D20, X11
    FMOV  V20.D[1], X26
    FMOV  D21, X13
    FMOV  V21.D[1], X18
    FMOV  D22, X19
    FMOV  V22.D[1], X25
    FMOV  D23, X27
    FMOV  V23.D[1], X22
    FMOV  D24, X26
    FMOV  V24.D[1], X4
    FMOV  D25, X19
    FMOV  V25.D[1], X18
    FMOV  D26, X18
    FMOV  V26.D[1], X18
    FMOV  D27, X11
    FMOV  V27.D[1], X11
    FMOV  D28, X16
    FMOV  V28.D[1], X22
    FMOV  D29, X21
    FMOV  V29.D[1], X13
    FMOV  D30, X23
    FMOV  V30.D[1], X16
    FMOV  D31, X19
    FMOV  V31.D[1], X7
    MOVZ  X16, #0xa, LSL #0
TSRTFloatMovMadd_label_1:
    FNMSUB  S31, S31, S31, S26
    FNMUL  S17, S24, S29
    FNMADD  S13, S30, S27, S19
    FMOV  S5, #-7.25000000
    FNMSUB  H9, H31, H17, H29
    FADD  H3, H27, H17
    FSQRT  S24, S9
    FMOV  S9, S3
    FSUB  H23, H23, H18
    FMOV  X13, H25
    FNEG  S1, S23
    FNEG  S16, S9
    FMSUB  S20, S24, S16, S3
    FNMADD  H1, H14, H5, H28
    FSUB  S5, S1, S8
    FSUB  S28, S5, S20
    FMADD  S25, S31, S8, S14
    FMOV  D29, X19
    FADD  D31, D5, D15
    FMOV  H1, H12
    FABS  S26, S10
    FNMSUB  H27, H5, H7, H6
    FMOV  W19, S12
    FMUL  D7, D9, D26
    FSQRT  S17, S25
    FNMUL  H19, H12, H25
    FADD  H9, H14, H17
    FNMSUB  S23, S29, S15, S31
    FCSEL  S19, S9, S3, MI
    FABS  D29, D1
    FMOV  S3, #-2.75000000
    FMSUB  S17, S29, S24, S3
    FMOV  H20, H7
    FSQRT  H10, H12
    FSQRT  D31, D23
    FADD  D16, D31, D31
    FNMUL  S21, S17, S20
    FNMUL  S12, S16, S21
    FMOV  S31, #-1.37500000
    FMOV  X5, D10
    FNMSUB  S8, S2, S30, S13
    FMADD  H30, H18, H11, H25
    FCSEL  S14, S31, S30, LE
    FNMADD  S24, S27, S12, S19
    FNMADD  S12, S12, S14, S24
    FMOV  S2, W22
    FMUL  D7, D26, D12
    FMOV  H24, H8
    FNEG  H30, H24
    FCSEL  D3, D30, D7, NV
    FNMSUB  H21, H13, H1, H14
    FNMADD  D8, D5, D11, D3
    FCSEL  D29, D31, D20, GE
    FSQRT  S1, S11
    FMADD  H3, H21, H0, H24
    FNMUL  S20, S30, S9
    FMUL  H21, H16, H30
    FMSUB  H7, H13, H31, H11
    FNMADD  D5, D17, D28, D2
    FMOV  W7, S6
    FMOV  X2, H21
    FMADD  H30, H4, H18, H23
    FNMADD  D16, D19, D30, D6
    FMADD  H9, H0, H5, H8
    FMSUB  D10, D14, D0, D13
    FMADD  D28, D8, D4, D25
    FNEG  D14, D9
    FNMADD  S25, S3, S14, S7
    FDIV  D18, D25, D23
    FSUB  S12, S18, S28
    FCSEL  D7, D22, D10, NE
    FMADD  S13, S20, S16, S16
    FNMSUB  H4, H13, H1, H16
    FNMADD  S14, S4, S7, S7
    FMOV  S23, S31
    FMOV  H3, W3
    FADD  S7, S14, S14
    FCSEL  D9, D12, D3, VC
    FMOV  H1, #10.50000000
    FNMUL  H8, H9, H3
    FMSUB  D22, D23, D12, D23
    FNEG  S6, S3
    FADD  S25, S6, S8
    FMUL  D5, D8, D28
    FNEG  S17, S24
    FMSUB  S3, S17, S17, S1
    FCSEL  D28, D10, D3, CS
    FNMSUB  H16, H5, H5, H3
    FMADD  H1, H8, H22, H16
    FMADD  D10, D25, D28, D1
    FMSUB  S1, S31, S28, S31
    FNMSUB  S20, S1, S12, S12
    FMADD  S8, S13, S0, S12
    FSQRT  D17, D4
    FMOV  X5, H21
    FNMADD  S31, S6, S5, S2
    FMOV  D17, #-0.50000000
    FABS  S14, S2
    FCSEL  S3, S8, S12, VS
    FMOV  X24, D24
    FNMADD  H16, H6, H20, H6
    FMADD  H22, H31, H28, H29
    FADD  H9, H21, H21
    FMADD  D5, D25, D24, D31
    FNMUL  S1, S14, S3
    FMOV  H14, H9
    FMOV  D0, X5
    FMOV  X29, D25
    FMUL  D15, D4, D26
    FMOV  S4, #2.37500000
    FMOV  H6, H17
    FMADD  S21, S5, S0, S15
    FNMADD  D13, D14, D14, D1
    FNMUL  D15, D10, D2
    FMOV  D5, D15
    FADD  S12, S21, S22
    FMSUB  D15, D6, D8, D7
    FMOV  S10, W14
    FNEG  S2, S15
    FSUB  D5, D2, D25
    FABS  H15, H17
    FMOV  X5, D31
    FADD  S9, S5, S28
    FNMSUB  S24, S4, S12, S15
    FADD  S2, S29, S10
    FADD  S0, S7, S13
    FMOV  D10, X16
    FNMUL  H4, H0, H10
    FADD  D22, D4, D21
    FMOV  H24, X2
    FMUL  H4, H18, H4
    FMOV  H9, X22
    FMOV  D26, X20
    FMOV  H13, #-2.25000000
    FNEG  S21, S22
    FSQRT  H10, H26
    FNMSUB  H8, H20, H5, H21
    FABS  H26, H31
    FNMSUB  H10, H26, H24, H10
    FMOV  D24, D9
    FSQRT  D18, D24
    FCSEL  D12, D13, D8, AL
    FCSEL  H0, H27, H6, LS
    FMOV  D31, #0.14062500
    FMUL  S10, S2, S10
    FMOV  W22, S0
    FMOV  H7, W16
    FCSEL  H13, H29, H10, GT
    FADD  D0, D18, D4
    FCSEL  D21, D7, D15, GE
    FMADD  H4, H0, H13, H12
    FNMSUB  S18, S31, S1, S21
    FABS  H0, H13
    FSQRT  H5, H1
    FNMSUB  D22, D16, D31, D29
    FMOV  H0, X22
    FSUB  D24, D6, D5
    FMOV  D2, #-9.50000000
    FMOV  H15, X4
    FDIV  D13, D29, D19
    FNEG  D16, D6
    FABS  H8, H13
    FNMUL  D7, D22, D4
    FNMSUB  H5, H24, H0, H15
    FMOV  D21, D2
    FMSUB  S13, S7, S28, S28
    FMOV  X7, H5
    FMOV  D1, X29
    FMOV  X5, D30
    FNMUL  H28, H0, H16
    FSUB  H7, H13, H21
    FCSEL  S12, S25, S28, NV
    FSUB  H30, H8, H8
    FNMSUB  S10, S1, S30, S14
    FADD  H6, H10, H25
    FMUL  S15, S12, S18
    FMOV  W3, S20
    FMUL  S31, S28, S14
    FNMADD  S2, S22, S15, S15
    FMOV  H14, W28
    FSUB  H21, H31, H6
    FCSEL  H18, H23, H24, LS
    FCSEL  D16, D21, D20, HI
    FNEG  S4, S5
    FNMADD  D11, D16, D27, D4
    FSUB  S19, S11, S9
    FMUL  H30, H2, H13
    FMADD  H28, H14, H25, H24
    FDIV  D20, D12, D11
    FSQRT  H11, H19
    FNMUL  S0, S22, S25
    FSQRT  D9, D7
    FMOV  D31, #-7.25000000
    FABS  H21, H18
    FDIV  H3, H15, H31
    FNEG  D13, D3
    FSQRT  S2, S16
    FNMSUB  D7, D3, D2, D0
    FNMADD  H23, H9, H25, H9
    FNMSUB  H19, H7, H13, H9
    SUBS  X16, X16, #0x1
    B.NE  TSRTFloatMovMadd_label_1
    MOVZ  X25, #0x7e00, LSL #0
    SUB  X23, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    SUB  X23, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X23, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X23, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X23, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X23, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x7e01, LSL #0
    SUB  X23, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X23, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MRS  X25, FPSR
    MOVZ  X23, #0x1f, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D0
    MOVZ  X23, #0xafee, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D1
    MOVZ  X23, #0x8000, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D2
    MOVZ  X23, #0xfdfb, LSL #0
    MOVK  X23, #0x1dfd, LSL #16
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D3
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D4
    MOVZ  X23, #0x8000, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D5
    MOVZ  X23, #0x8000, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D6
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D7
    MOVZ  X23, #0xafee, LSL #0
    MOVK  X23, #0x8000, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D8
    MOVZ  X23, #0x5d75, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D9
    MOVZ  X23, #0x2f76, LSL #0
    MOVK  X23, #0x8d0e, LSL #16
    MOVK  X23, #0x732f, LSL #32
    MOVK  X23, #0x1ed6, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D10
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D11
    MOVZ  X23, #0x8000, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D12
    MOVZ  X23, #0x8000, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D13
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x8000, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D15
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D16
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D17
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xbfe0, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D19
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D20
    MOVZ  X23, #0x60, LSL #0
    MOVK  X23, #0xffe0, LSL #16
    MOVK  X23, #0xffdf, LSL #32
    MOVK  X23, #0xbeef, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D22
    MOVZ  X23, #0xee00, LSL #0
    MOVK  X23, #0xbfaf, LSL #16
    MOVK  X23, #0x8000, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D23
    MOVZ  X23, #0xaf76, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D24
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D25
    MOVZ  X23, #0x8000, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D27
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D28
    MOVZ  X23, #0x8000, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D29
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xbfb0, LSL #16
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D30
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X25, D31
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc01d, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    FMOV  V0.D[1], X13
    FMOV  D1, X23
    FMOV  V1.D[1], X27
    FMOV  D2, X23
    FMOV  V2.D[1], X3
    FMOV  D3, X28
    FMOV  V3.D[1], X29
    FMOV  D4, X21
    FMOV  V4.D[1], X24
    FMOV  D5, X7
    FMOV  V5.D[1], X25
    FMOV  D6, X18
    FMOV  V6.D[1], X20
    FMOV  D7, X17
    FMOV  V7.D[1], X25
    FMOV  D8, X19
    FMOV  V8.D[1], X17
    FMOV  D9, X25
    FMOV  V9.D[1], X18
    FMOV  D10, X19
    FMOV  V10.D[1], X4
    FMOV  D11, X29
    FMOV  V11.D[1], X13
    FMOV  D12, X11
    FMOV  V12.D[1], X17
    FMOV  D13, X23
    FMOV  V13.D[1], X24
    FMOV  D14, X27
    FMOV  V14.D[1], X23
    FMOV  D15, X17
    FMOV  V15.D[1], X21
    FMOV  D16, X11
    FMOV  V16.D[1], X27
    FMOV  D17, X3
    FMOV  V17.D[1], X19
    FMOV  D18, X7
    FMOV  V18.D[1], X21
    FMOV  D19, X3
    FMOV  V19.D[1], X13
    FMOV  D20, X4
    FMOV  V20.D[1], X2
    FMOV  D21, X18
    FMOV  V21.D[1], X27
    FMOV  D22, X28
    FMOV  V22.D[1], X27
    FMOV  D23, X6
    FMOV  V23.D[1], X16
    FMOV  D24, X6
    FMOV  V24.D[1], X11
    FMOV  D25, X5
    FMOV  V25.D[1], X18
    FMOV  D26, X20
    FMOV  V26.D[1], X21
    FMOV  D27, X18
    FMOV  V27.D[1], X13
    FMOV  D28, X19
    FMOV  V28.D[1], X6
    FMOV  D29, X3
    FMOV  V29.D[1], X22
    FMOV  D30, X14
    FMOV  V30.D[1], X24
    FMOV  D31, X20
    FMOV  V31.D[1], X26
    MOVZ  X26, #0xa, LSL #0
TSRTFloatMovMadd_label_2:
    FMOV  S29, W25
    FNMSUB  D14, D25, D29, D20
    FSQRT  D18, D25
    FABS  H14, H26
    FMADD  S7, S24, S31, S2
    FABS  S8, S6
    FMOV  D26, #-10.50000000
    FNMSUB  D1, D26, D23, D23
    FSUB  H20, H7, H7
    FCSEL  S31, S8, S2, VC
    FDIV  H21, H18, H6
    FNMADD  D27, D29, D31, D28
    FADD  H25, H30, H20
    FDIV  D24, D25, D27
    FADD  S25, S0, S20
    FMOV  S23, W29
    FMADD  S26, S14, S1, S25
    FSUB  H26, H21, H21
    FSUB  S8, S12, S26
    FMOV  S29, S13
    FNEG  S12, S27
    FABS  H28, H24
    FMSUB  D30, D8, D20, D12
    FMSUB  D27, D28, D23, D10
    FMOV  W29, S8
    FNMADD  H28, H27, H30, H30
    FMADD  S13, S17, S26, S23
    FMSUB  S31, S5, S17, S28
    FNEG  S8, S25
    FNMSUB  S30, S2, S23, S1
    FNMUL  D18, D3, D17
    FSQRT  S5, S16
    FMOV  S19, W2
    FMOV  H21, #-3.87500000
    FNMUL  H16, H0, H8
    FSQRT  S5, S8
    FSUB  H8, H29, H19
    FNMADD  H10, H16, H13, H25
    FMOV  S3, #0.31250000
    FCSEL  H27, H28, H21, VS
    FNMUL  H6, H3, H5
    FNEG  H23, H9
    FADD  D24, D4, D10
    FMOV  W4, H30
    FABS  D30, D24
    FMUL  H14, H20, H7
    FABS  D24, D8
    FMOV  D17, X24
    FADD  D3, D18, D13
    FMOV  W2, H30
    FABS  H7, H6
    FMOV  W24, S28
    FMOV  W29, S6
    FDIV  S28, S23, S3
    FMOV  D23, X11
    FMOV  S26, #21.00000000
    FMOV  W21, H24
    FNMUL  H30, H26, H13
    FABS  D8, D18
    FADD  H9, H30, H23
    FSQRT  D24, D17
    FMADD  H12, H0, H7, H21
    FMOV  H13, #-0.24218750
    FMSUB  D7, D14, D28, D10
    FMOV  X21, D7
    FDIV  D3, D12, D9
    FNMUL  H7, H19, H20
    FMUL  S0, S8, S7
    FMOV  H14, H24
    FSQRT  D7, D13
    FADD  S3, S13, S14
    FMOV  W2, H0
    FMUL  D17, D9, D3
    FADD  D14, D17, D31
    FCSEL  D15, D25, D4, VS
    FADD  D6, D19, D6
    FMSUB  S10, S13, S20, S8
    FMOV  W3, H6
    FABS  S30, S9
    FNMADD  S9, S29, S18, S26
    FNEG  H15, H27
    FMOV  X17, H6
    FADD  S0, S5, S13
    FMSUB  D4, D20, D2, D15
    FMUL  S31, S7, S31
    FABS  S28, S6
    FMOV  S6, #17.00000000
    FADD  H11, H28, H10
    FSQRT  H28, H28
    FADD  S17, S6, S8
    FNMUL  S5, S9, S22
    FMSUB  S29, S0, S11, S28
    FMOV  S15, #-16.00000000
    FMOV  D9, X18
    FMOV  H28, W14
    FMADD  D27, D5, D28, D17
    FMSUB  D13, D25, D29, D4
    FMUL  D5, D14, D13
    FMOV  H3, H31
    FMOV  X13, H2
    FMOV  X17, H31
    FABS  S4, S27
    FMOV  D20, X20
    FSQRT  S11, S4
    FMOV  H6, W11
    FNEG  H29, H5
    FNEG  S0, S20
    FMOV  H5, #-13.50000000
    FNMADD  H31, H14, H9, H15
    FCSEL  S8, S19, S0, HI
    FNMADD  D14, D5, D17, D6
    FNMSUB  D13, D21, D26, D2
    FDIV  S17, S24, S31
    FMOV  D24, X11
    FMUL  D20, D24, D29
    FMUL  S2, S22, S14
    FCSEL  D4, D21, D28, PL
    FMADD  S31, S8, S17, S2
    FMADD  H19, H21, H13, H13
    FMSUB  S14, S19, S4, S31
    FNMSUB  H31, H14, H15, H11
    FMOV  H20, H31
    FNMADD  S16, S20, S19, S20
    FNMUL  D26, D30, D15
    FNEG  D6, D31
    FMOV  X24, D8
    FABS  S25, S1
    FNMSUB  S8, S22, S31, S19
    FABS  D5, D9
    FMOV  H21, W19
    FNMADD  H4, H0, H14, H4
    FNMUL  S31, S21, S18
    FDIV  D19, D10, D2
    FMOV  S10, #-0.56250000
    FMOV  H20, X13
    FNEG  H14, H10
    FMOV  H1, X3
    FSQRT  S10, S16
    FABS  D9, D14
    FMSUB  H21, H19, H6, H25
    FSQRT  S9, S17
    FSQRT  D29, D26
    FMOV  X2, H31
    FMOV  X16, D9
    FMUL  D25, D29, D10
    FABS  S31, S29
    FMOV  S17, W6
    FMADD  H26, H27, H8, H17
    FSUB  H29, H31, H14
    FMOV  D9, #-0.17187500
    FSUB  S27, S6, S20
    FMADD  H6, H25, H29, H29
    FSUB  D19, D9, D16
    FMOV  D25, X13
    FMOV  H17, H14
    FMUL  H8, H25, H21
    FMADD  S25, S10, S1, S3
    FMUL  H18, H17, H27
    FABS  D31, D8
    FSUB  H7, H12, H8
    FADD  D20, D27, D7
    FADD  S7, S11, S27
    FABS  H3, H19
    FDIV  D16, D6, D7
    FDIV  S8, S20, S8
    FSQRT  D21, D0
    FNMUL  S19, S11, S25
    FNMUL  D19, D7, D2
    FMOV  S17, #0.23437500
    FMSUB  S15, S22, S19, S31
    FMSUB  H27, H3, H30, H8
    FMOV  X14, D1
    FABS  D8, D18
    FMOV  W29, H26
    FNEG  D31, D8
    FCSEL  H25, H0, H4, MI
    FNMADD  H26, H31, H31, H1
    FSQRT  H11, H17
    FMOV  S8, S7
    FMSUB  D6, D25, D15, D3
    FMOV  D3, #5.00000000
    FSUB  D22, D8, D11
    FMADD  S8, S22, S16, S5
    FNMADD  D14, D27, D31, D26
    FCSEL  H17, H8, H6, NV
    FNMSUB  H29, H21, H30, H25
    FSUB  S1, S6, S17
    FMSUB  S14, S1, S28, S29
    FMUL  H8, H3, H3
    FMOV  D11, D0
    FMOV  H7, H11
    FNMSUB  D5, D6, D14, D19
    FMOV  H22, X20
    FMOV  D26, X4
    FDIV  D2, D5, D22
    FADD  H6, H4, H8
    FMOV  H0, W19
    FNEG  D5, D29
    FSUB  D20, D31, D4
    FMUL  S3, S1, S21
    SUBS  X26, X26, #0x1
    B.NE  TSRTFloatMovMadd_label_2
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    SUB  X22, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    SUB  X22, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x3b54, LSL #0
    SUB  X22, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x7dff, LSL #0
    SUB  X22, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    SUB  X22, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    MRS  X28, FPSR
    MOVZ  X22, #0x1f, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D0
    MOVZ  X22, #0xffff, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D1
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D3
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D4
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D5
    MOVZ  X22, #0x7e00, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D6
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D7
    MOVZ  X22, #0xffff, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D9
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xbfc6, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D10
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7fc0, LSL #16
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D11
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D12
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D14
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D15
    MOVZ  X22, #0x8000, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D18
    MOVZ  X22, #0x8000, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D19
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D20
    MOVZ  X22, #0xfe00, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D21
    MOVZ  X22, #0x9b2e, LSL #0
    MOVK  X22, #0x6668, LSL #16
    MOVK  X22, #0xa09e, LSL #32
    MOVK  X22, #0x1f56, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D22
    MOVZ  X22, #0xffff, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D23
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D24
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D25
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D27
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D28
    MOVZ  X22, #0x8000, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D29
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D30
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    FMOV  X28, D31
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X18
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X5
    FMOV  V2.D[1], X25
    FMOV  D3, X28
    FMOV  V3.D[1], X16
    FMOV  D4, X24
    FMOV  V4.D[1], X28
    FMOV  D5, X11
    FMOV  V5.D[1], X21
    FMOV  D6, X23
    FMOV  V6.D[1], X29
    FMOV  D7, X17
    FMOV  V7.D[1], X16
    FMOV  D8, X5
    FMOV  V8.D[1], X20
    FMOV  D9, X17
    FMOV  V9.D[1], X19
    FMOV  D10, X26
    FMOV  V10.D[1], X14
    FMOV  D11, X22
    FMOV  V11.D[1], X11
    FMOV  D12, X2
    FMOV  V12.D[1], X21
    FMOV  D13, X5
    FMOV  V13.D[1], X4
    FMOV  D14, X23
    FMOV  V14.D[1], X13
    FMOV  D15, X4
    FMOV  V15.D[1], X27
    FMOV  D16, X27
    FMOV  V16.D[1], X16
    FMOV  D17, X22
    FMOV  V17.D[1], X23
    FMOV  D18, X20
    FMOV  V18.D[1], X24
    FMOV  D19, X19
    FMOV  V19.D[1], X17
    FMOV  D20, X29
    FMOV  V20.D[1], X7
    FMOV  D21, X28
    FMOV  V21.D[1], X27
    FMOV  D22, X17
    FMOV  V22.D[1], X25
    FMOV  D23, X2
    FMOV  V23.D[1], X4
    FMOV  D24, X17
    FMOV  V24.D[1], X19
    FMOV  D25, X4
    FMOV  V25.D[1], X3
    FMOV  D26, X23
    FMOV  V26.D[1], X6
    FMOV  D27, X4
    FMOV  V27.D[1], X25
    FMOV  D28, X18
    FMOV  V28.D[1], X27
    FMOV  D29, X3
    FMOV  V29.D[1], X26
    FMOV  D30, X29
    FMOV  V30.D[1], X17
    FMOV  D31, X14
    FMOV  V31.D[1], X26
    MOVZ  X11, #0xa, LSL #0
TSRTFloatMovMadd_label_3:
    FMOV  X26, H31
    FDIV  H6, H25, H26
    FMOV  H24, #-0.40625000
    FMOV  X22, H6
    FDIV  D29, D30, D30
    FMUL  H27, H6, H28
    FMOV  H10, #-28.00000000
    FNMADD  D26, D15, D29, D13
    FMOV  H26, #6.75000000
    FCSEL  S16, S24, S1, NV
    FNEG  H25, H6
    FMOV  S4, S25
    FCSEL  H7, H26, H27, HI
    FNMUL  H19, H6, H10
    FMADD  H7, H16, H4, H4
    FABS  H30, H7
    FNEG  H7, H2
    FMOV  X14, H27
    FADD  S2, S28, S5
    FSQRT  S10, S30
    FCSEL  S27, S0, S27, PL
    FSQRT  D25, D20
    FNEG  H16, H24
    FMOV  W14, S3
    FMUL  D3, D20, D20
    FMOV  S24, W19
    FMOV  X4, D24
    FMOV  H5, W20
    FNMADD  H28, H25, H15, H20
    FMADD  D1, D16, D5, D3
    FNMUL  H4, H7, H2
    FMOV  H26, #-0.39062500
    FDIV  H17, H28, H1
    FADD  H0, H4, H10
    FNMUL  H12, H27, H0
    FMADD  D4, D26, D29, D5
    FNMUL  S21, S11, S24
    FMSUB  D2, D23, D12, D21
    FABS  D26, D2
    FDIV  H0, H17, H26
    FSUB  H6, H0, H18
    FMADD  D0, D13, D6, D4
    FNMSUB  S24, S19, S10, S30
    FMADD  S29, S28, S18, S29
    FDIV  D28, D3, D10
    FMSUB  D20, D31, D0, D1
    FDIV  S11, S7, S26
    FCSEL  D26, D23, D17, GE
    FMOV  D7, #21.00000000
    FMSUB  S3, S30, S31, S30
    FMUL  H0, H18, H13
    FDIV  D12, D28, D26
    FSQRT  S28, S0
    FABS  H26, H28
    FNMUL  H0, H11, H20
    FMOV  S22, W20
    FCSEL  H10, H26, H13, VS
    FMUL  S28, S24, S29
    FNMSUB  D19, D10, D7, D7
    FMOV  W5, S28
    FNMUL  D29, D12, D14
    FNMUL  D26, D20, D15
    FMOV  S1, W21
    FNMADD  H2, H19, H11, H0
    FNEG  S23, S30
    FMUL  H17, H4, H23
    FADD  H28, H17, H2
    FNMSUB  D19, D26, D22, D29
    FMOV  S22, W27
    FMOV  H7, W21
    FNMSUB  H31, H30, H12, H1
    FDIV  H24, H7, H9
    FNMSUB  D20, D14, D19, D28
    FMOV  D13, X25
    FNMUL  D0, D22, D31
    FMOV  X21, D5
    FNEG  H29, H13
    FMOV  H19, #12.50000000
    FSUB  H5, H0, H29
    FMADD  S26, S28, S24, S9
    FNMUL  S30, S5, S20
    FNEG  D23, D30
    FMADD  D29, D23, D5, D13
    FMOV  S9, #-2.37500000
    FMSUB  H22, H2, H22, H11
    FMOV  D12, D19
    FMOV  D19, X24
    FMOV  H28, X25
    FMADD  D14, D22, D27, D2
    FNEG  D20, D29
    FNMSUB  D15, D23, D28, D20
    FCSEL  S1, S12, S26, CS
    FNMADD  H22, H28, H16, H18
    FMUL  S11, S15, S1
    FSQRT  H22, H3
    FNMSUB  S9, S9, S19, S22
    FNMADD  S0, S16, S9, S2
    FCSEL  S9, S18, S2, AL
    FNEG  S28, S3
    FMOV  H1, #-8.50000000
    FCSEL  D11, D14, D1, NE
    FCSEL  H1, H11, H0, GE
    FNMUL  H30, H1, H28
    FNMSUB  D27, D11, D9, D24
    FDIV  D2, D18, D21
    FMUL  H0, H23, H9
    FMOV  H13, W16
    FABS  H9, H22
    FNEG  D20, D6
    FMOV  W23, H4
    FABS  D11, D5
    FMADD  H1, H15, H31, H26
    FMSUB  S27, S17, S27, S28
    FMSUB  D19, D11, D20, D27
    FMOV  X20, H0
    FMOV  S12, W19
    FCSEL  H23, H19, H12, CS
    FADD  H22, H1, H25
    FADD  D23, D12, D13
    FMOV  X27, H22
    FCSEL  H4, H9, H0, PL
    FMOV  W17, H23
    FSUB  S22, S24, S4
    FABS  D17, D0
    FDIV  S21, S22, S5
    FMUL  H13, H29, H24
    FMOV  S27, S5
    FMOV  S29, #0.46875000
    FCSEL  H0, H31, H27, LT
    FNMADD  S4, S13, S5, S29
    FSUB  S1, S0, S17
    FNEG  H5, H20
    FMOV  W7, H17
    FDIV  S20, S4, S28
    FSUB  H19, H8, H8
    FMOV  H24, W19
    FMADD  S29, S19, S7, S1
    FMOV  S27, S20
    FNMUL  D28, D5, D14
    FMOV  D1, D24
    FABS  D15, D27
    FNMUL  H27, H15, H21
    FMOV  S22, S4
    FMOV  H5, W29
    FMSUB  H30, H16, H22, H5
    FMOV  D24, D13
    FNMSUB  D7, D30, D28, D27
    FMADD  D17, D1, D23, D24
    FMOV  S19, #15.50000000
    FNEG  D8, D17
    FMOV  H1, #-1.68750000
    FMOV  D20, D7
    FMADD  H24, H10, H2, H1
    FMOV  H7, H19
    FSUB  H8, H31, H14
    FDIV  H23, H20, H20
    FABS  H30, H29
    FMOV  X29, D4
    FMOV  S13, S30
    FNMADD  H15, H8, H15, H13
    FADD  H8, H22, H23
    FDIV  H29, H15, H20
    FNEG  D16, D8
    FMOV  H23, W22
    FNMUL  H0, H16, H24
    FMOV  S14, S28
    FSUB  H15, H13, H0
    FMSUB  H10, H19, H14, H7
    FCSEL  S24, S15, S27, CS
    FNMADD  H29, H27, H15, H11
    FMSUB  D0, D30, D7, D10
    FNEG  S13, S17
    FSUB  H2, H29, H0
    FMOV  W27, H23
    FCSEL  H22, H24, H4, GE
    FMOV  H8, #-7.00000000
    FNEG  S19, S22
    FMOV  D16, #3.50000000
    FDIV  H20, H16, H16
    FMOV  X23, H13
    FMOV  D14, D19
    FMOV  X21, D2
    FNMSUB  H13, H26, H16, H20
    FCSEL  H0, H8, H23, EQ
    FDIV  H26, H5, H13
    FSUB  S23, S14, S24
    FMUL  S28, S26, S29
    FNMADD  H20, H27, H28, H0
    FMSUB  D26, D0, D31, D15
    FMUL  D0, D6, D16
    FSQRT  D17, D13
    FADD  D27, D29, D29
    FMOV  S27, #-6.75000000
    FNMADD  S22, S15, S10, S5
    FNMSUB  H24, H2, H29, H19
    FMOV  H12, X6
    FNEG  S10, S17
    FMOV  X21, D24
    FABS  S8, S0
    FMOV  S28, #-7.75000000
    SUBS  X11, X11, #0x1
    B.NE  TSRTFloatMovMadd_label_3
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X18, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X18, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X18, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X18, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X18, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7dff, LSL #0
    SUB  X18, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xb4b4, LSL #0
    SUB  X18, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X18, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X18, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X18, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X18, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X18, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X18, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X18, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X18, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0xbef0, LSL #16
    SUB  X18, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MRS  X13, FPSR
    MOVZ  X18, #0x1f, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D0
    MOVZ  X18, #0xb900, LSL #0
    MOVK  X18, #0x1, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D1
    MOVZ  X18, #0xbec0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D2
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D3
    MOVZ  X18, #0x7dff, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D4
    MOVZ  X18, #0x1, LSL #0
    MOVK  X18, #0xbef0, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D5
    MOVZ  X18, #0x1, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D6
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D8
    MOVZ  X18, #0xb900, LSL #0
    MOVK  X18, #0x1, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D9
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D10
    MOVZ  X18, #0x2f76, LSL #0
    MOVK  X18, #0xd0e, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D11
    MOVZ  X18, #0x5a5a, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D12
    MOVZ  X18, #0x5a5a, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D13
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D14
    MOVZ  X18, #0x7e00, LSL #0
    MOVK  X18, #0x8000, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D15
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D16
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x400c, LSL #48
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D17
    MOVZ  X18, #0x2f76, LSL #0
    MOVK  X18, #0x8d0e, LSL #16
    MOVK  X18, #0x732f, LSL #32
    MOVK  X18, #0x1ed6, LSL #48
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D18
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D19
    MOVZ  X18, #0x7e00, LSL #0
    MOVK  X18, #0x8000, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D20
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D21
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D22
    MOVZ  X18, #0x2, LSL #0
    MOVK  X18, #0x8000, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D23
    MOVZ  X18, #0xfc00, LSL #0
    MOVK  X18, #0x8000, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D24
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D25
    MOVZ  X18, #0x2f76, LSL #0
    MOVK  X18, #0x8d0e, LSL #16
    MOVK  X18, #0x732f, LSL #32
    MOVK  X18, #0x1ed6, LSL #48
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D26
    MOVZ  X18, #0x7dff, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D27
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xc0d8, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D28
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xc0f8, LSL #16
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D29
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D30
    MOVZ  X18, #0x5a5a, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
    FMOV  X13, D31
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X22
    FMOV  D2, X17
    FMOV  V2.D[1], X13
    FMOV  D3, X26
    FMOV  V3.D[1], X4
    FMOV  D4, X27
    FMOV  V4.D[1], X28
    FMOV  D5, X22
    FMOV  V5.D[1], X27
    FMOV  D6, X11
    FMOV  V6.D[1], X11
    FMOV  D7, X11
    FMOV  V7.D[1], X4
    FMOV  D8, X25
    FMOV  V8.D[1], X17
    FMOV  D9, X24
    FMOV  V9.D[1], X22
    FMOV  D10, X4
    FMOV  V10.D[1], X18
    FMOV  D11, X25
    FMOV  V11.D[1], X21
    FMOV  D12, X28
    FMOV  V12.D[1], X21
    FMOV  D13, X27
    FMOV  V13.D[1], X25
    FMOV  D14, X11
    FMOV  V14.D[1], X2
    FMOV  D15, X22
    FMOV  V15.D[1], X23
    FMOV  D16, X21
    FMOV  V16.D[1], X6
    FMOV  D17, X20
    FMOV  V17.D[1], X7
    FMOV  D18, X14
    FMOV  V18.D[1], X17
    FMOV  D19, X20
    FMOV  V19.D[1], X26
    FMOV  D20, X29
    FMOV  V20.D[1], X5
    FMOV  D21, X4
    FMOV  V21.D[1], X5
    FMOV  D22, X18
    FMOV  V22.D[1], X27
    FMOV  D23, X17
    FMOV  V23.D[1], X17
    FMOV  D24, X23
    FMOV  V24.D[1], X26
    FMOV  D25, X20
    FMOV  V25.D[1], X13
    FMOV  D26, X29
    FMOV  V26.D[1], X5
    FMOV  D27, X7
    FMOV  V27.D[1], X5
    FMOV  D28, X22
    FMOV  V28.D[1], X27
    FMOV  D29, X13
    FMOV  V29.D[1], X27
    FMOV  D30, X23
    FMOV  V30.D[1], X24
    FMOV  D31, X27
    FMOV  V31.D[1], X20
    MOVZ  X19, #0xa, LSL #0
TSRTFloatMovMadd_label_4:
    FMUL  D0, D20, D28
    FCSEL  D13, D27, D23, LS
    FMOV  S3, #-0.81250000
    FMOV  D23, #4.25000000
    FMSUB  D15, D25, D24, D26
    FABS  H14, H30
    FMOV  H3, H7
    FSUB  D25, D3, D13
    FNMSUB  H26, H31, H10, H31
    FMOV  W23, S25
    FNMSUB  H1, H15, H23, H15
    FMOV  W25, H24
    FMOV  H5, #-26.00000000
    FADD  D31, D1, D5
    FMADD  D24, D10, D26, D8
    FNEG  S27, S31
    FMSUB  H5, H9, H24, H4
    FADD  H16, H27, H5
    FNEG  S17, S14
    FDIV  S20, S11, S17
    FMUL  H8, H29, H20
    FADD  D9, D9, D8
    FMSUB  S25, S30, S15, S5
    FDIV  D3, D14, D25
    FMSUB  S25, S7, S22, S24
    FDIV  H5, H12, H16
    FNEG  D13, D28
    FMOV  H22, X19
    FDIV  D6, D17, D25
    FMOV  X13, D5
    FADD  S27, S15, S22
    FSUB  S31, S28, S12
    FNEG  D22, D3
    FNMUL  H28, H13, H27
    FNMUL  S25, S5, S22
    FDIV  H22, H18, H28
    FNMSUB  D30, D27, D25, D30
    FNMADD  D15, D6, D22, D5
    FDIV  S8, S26, S17
    FMSUB  D28, D9, D8, D8
    FSUB  D3, D6, D30
    FDIV  S14, S24, S15
    FSUB  S8, S19, S3
    FMOV  W16, S14
    FMOV  D5, D18
    FMOV  H3, H28
    FMOV  S6, W23
    FMOV  H15, H24
    FMSUB  S9, S15, S5, S18
    FMUL  H28, H13, H2
    FMOV  S13, S31
    FNEG  D24, D9
    FMOV  S31, #1.06250000
    FSUB  H18, H9, H28
    FNEG  D23, D24
    FADD  H4, H8, H23
    FNMSUB  H22, H4, H13, H4
    FMOV  H26, X28
    FSUB  S27, S1, S22
    FMOV  S4, S10
    FMOV  S22, #30.00000000
    FSQRT  D2, D18
    FNMADD  S24, S0, S27, S2
    FNMUL  D19, D22, D7
    FMOV  X28, D11
    FNMADD  H25, H3, H3, H26
    FMSUB  H7, H31, H4, H25
    FMADD  S4, S19, S6, S5
    FNMSUB  D10, D24, D27, D4
    FMOV  S0, S4
    FNMUL  D1, D2, D1
    FADD  D19, D12, D17
    FNMUL  S3, S5, S16
    FMOV  X26, D25
    FABS  S8, S3
    FMADD  H30, H20, H29, H1
    FMADD  H7, H13, H22, H4
    FMOV  W28, H6
    FMUL  H26, H25, H3
    FMOV  H21, #-3.75000000
    FMOV  W5, S0
    FMOV  X5, D31
    FMOV  H20, X11
    FNMUL  H22, H25, H17
    FNMSUB  D2, D26, D10, D10
    FMSUB  D3, D30, D7, D14
    FNMADD  S12, S22, S2, S10
    FNMADD  H1, H6, H3, H21
    FNMADD  H24, H19, H16, H14
    FSUB  D31, D1, D1
    FMOV  W16, S31
    FMUL  S0, S12, S15
    FMSUB  D22, D21, D0, D20
    FDIV  S6, S22, S22
    FDIV  S0, S9, S0
    FMOV  W13, H4
    FMUL  S1, S2, S6
    FDIV  D5, D1, D1
    FMOV  X18, D24
    FABS  S24, S21
    FDIV  S25, S1, S0
    FNEG  H13, H24
    FNMADD  H21, H5, H7, H13
    FMOV  S31, S8
    FMADD  D9, D31, D25, D31
    FMADD  S4, S16, S15, S18
    FABS  S2, S25
    FMSUB  S8, S29, S27, S10
    FSQRT  H18, H29
    FMUL  S29, S7, S29
    FDIV  D9, D5, D8
    FNMSUB  D6, D19, D16, D5
    FMOV  D24, D29
    FMOV  S29, #-3.12500000
    FMSUB  S15, S12, S15, S30
    FMOV  H5, X20
    FDIV  S3, S29, S7
    FMOV  H20, #-3.75000000
    FSQRT  H27, H3
    FMSUB  H7, H2, H27, H9
    FNMADD  H31, H7, H25, H2
    FMOV  D13, X6
    FSQRT  D21, D29
    FSQRT  H17, H5
    FCSEL  D3, D29, D6, GE
    FNEG  S25, S17
    FDIV  H31, H4, H31
    FNMADD  S30, S25, S3, S18
    FABS  H23, H2
    FNEG  D25, D30
    FMOV  X23, D31
    FNEG  S2, S18
    FADD  S10, S11, S24
    FMSUB  S5, S13, S20, S2
    FNEG  H17, H23
    FSQRT  D11, D17
    FMOV  W21, H31
    FADD  H7, H25, H5
    FABS  H5, H21
    FADD  H4, H15, H7
    FMOV  S23, W21
    FNMUL  S24, S4, S23
    FSQRT  D3, D5
    FMOV  X25, D13
    FMOV  S4, W21
    FABS  S29, S3
    FMOV  H31, #0.20312500
    FMOV  H4, #2.50000000
    FNMADD  S17, S16, S10, S14
    FMOV  H13, W27
    FSUB  S20, S31, S17
    FSUB  S24, S20, S11
    FADD  S6, S17, S13
    FABS  D2, D19
    FSQRT  S25, S2
    FMOV  H31, X11
    FABS  D14, D29
    FABS  S29, S8
    FMOV  D20, #0.34375000
    FMUL  S30, S1, S20
    FNMUL  S20, S12, S29
    FSQRT  D16, D20
    FMOV  H30, #-0.81250000
    FMSUB  H7, H14, H22, H6
    FSUB  H2, H22, H7
    FNMSUB  S17, S25, S14, S7
    FMADD  H20, H2, H4, H31
    FMOV  H11, X2
    FMOV  X18, H24
    FNMUL  H22, H16, H10
    FMOV  S10, S2
    FNMADD  S13, S14, S29, S20
    FADD  S6, S30, S5
    FMOV  H5, H18
    FMUL  S14, S5, S22
    FNMUL  S3, S14, S10
    FMADD  D10, D3, D11, D3
    FSUB  D1, D6, D30
    FNMADD  D25, D17, D19, D23
    FNMUL  H23, H24, H1
    FSUB  S6, S25, S13
    FMOV  S12, W22
    FNMSUB  S5, S12, S6, S23
    FMOV  W22, S20
    FNMSUB  D20, D25, D12, D14
    FNMUL  D4, D7, D5
    FNMADD  D30, D10, D17, D30
    FNEG  S19, S16
    FNMUL  S17, S22, S12
    FNMSUB  H16, H26, H10, H5
    FNMUL  S22, S20, S24
    FMADD  H2, H25, H15, H5
    FMUL  S13, S26, S8
    FDIV  S20, S22, S26
    FMSUB  S8, S14, S8, S15
    FNEG  H1, H16
    FCSEL  S16, S13, S9, LS
    FCSEL  D26, D16, D26, HI
    FADD  S7, S18, S20
    FABS  D24, D8
    SUBS  X19, X19, #0x1
    B.NE  TSRTFloatMovMadd_label_4
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3f88, LSL #16
    SUB  X7, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    SUB  X7, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x1bbe, LSL #0
    SUB  X7, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    SUB  X7, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xad88, LSL #0
    SUB  X7, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    SUB  X7, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    SUB  X7, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    SUB  X7, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X7, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMovMadd_TestFail
    MRS  X17, FPSR
    MOVZ  X7, #0x1f, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D0
    MOVZ  X7, #0xfe00, LSL #0
    MOVK  X7, #0xc6fb, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D2
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D3
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D4
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D5
    MOVZ  X7, #0x8000, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D6
    MOVZ  X7, #0x2950, LSL #0
    MOVK  X7, #0x1d7f, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D7
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x3800, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D8
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D9
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fef, LSL #48
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D10
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D11
    MOVZ  X7, #0xa5a5, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D12
    MOVZ  X7, #0xad88, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D15
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D16
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D17
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D18
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D19
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D20
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x3800, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D21
    MOVZ  X7, #0x10a1, LSL #0
    MOVK  X7, #0xa2c6, LSL #16
    MOVK  X7, #0xbbac, LSL #32
    MOVK  X7, #0x1f5b, LSL #48
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D22
    MOVZ  X7, #0x1, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D23
    MOVZ  X7, #0x8000, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D24
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D25
    MOVZ  X7, #0x7e01, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D26
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D28
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D29
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D30
    MOVZ  X7, #0xba81, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X17, D31
    MOVZ  X7, #0xa5a5, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x5847, LSL #0
    MOVK  X2, #0x739e, LSL #16
    MOVK  X2, #0xc42d, LSL #32
    MOVK  X2, #0xd4ad, LSL #48
    MOVZ  X3, #0xb8a1, LSL #0
    MOVK  X3, #0x54d5, LSL #16
    MOVK  X3, #0xcc5f, LSL #32
    MOVK  X3, #0x5c63, LSL #48
    MOVZ  X4, #0x30e8, LSL #0
    MOVK  X4, #0x549f, LSL #16
    MOVK  X4, #0x450f, LSL #32
    MOVK  X4, #0xb561, LSL #48
    MOVZ  X5, #0x8022, LSL #0
    MOVK  X5, #0x3e7, LSL #16
    MOVK  X5, #0x1f27, LSL #32
    MOVK  X5, #0x5e61, LSL #48
    MOVZ  X6, #0x94ea, LSL #0
    MOVK  X6, #0xe470, LSL #16
    MOVK  X6, #0x91e5, LSL #32
    MOVK  X6, #0x8961, LSL #48
    MOVZ  X7, #0x2460, LSL #0
    MOVK  X7, #0xf98b, LSL #16
    MOVK  X7, #0x46e9, LSL #32
    MOVK  X7, #0x7396, LSL #48
    MOVZ  X11, #0x7b9a, LSL #0
    MOVK  X11, #0xbadc, LSL #16
    MOVK  X11, #0x3339, LSL #32
    MOVK  X11, #0x31ba, LSL #48
    MOVZ  X13, #0x5eff, LSL #0
    MOVK  X13, #0x5701, LSL #16
    MOVK  X13, #0xae00, LSL #32
    MOVK  X13, #0x35b2, LSL #48
    MOVZ  X14, #0xc451, LSL #0
    MOVK  X14, #0x22e2, LSL #16
    MOVK  X14, #0xa89f, LSL #32
    MOVK  X14, #0x2f52, LSL #48
    MOVZ  X16, #0xc792, LSL #0
    MOVK  X16, #0x7272, LSL #16
    MOVK  X16, #0x15b4, LSL #32
    MOVK  X16, #0xccb4, LSL #48
    MOVZ  X17, #0x100f, LSL #0
    MOVK  X17, #0x1a6, LSL #16
    MOVK  X17, #0xe665, LSL #32
    MOVK  X17, #0x1142, LSL #48
    MOVZ  X18, #0xb124, LSL #0
    MOVK  X18, #0x867d, LSL #16
    MOVK  X18, #0xb79e, LSL #32
    MOVK  X18, #0x51ab, LSL #48
    MOVZ  X19, #0x4f7c, LSL #0
    MOVK  X19, #0xb3dd, LSL #16
    MOVK  X19, #0x55e2, LSL #32
    MOVK  X19, #0xa2be, LSL #48
    MOVZ  X20, #0xe407, LSL #0
    MOVK  X20, #0x36f5, LSL #16
    MOVK  X20, #0x31b8, LSL #32
    MOVK  X20, #0x5348, LSL #48
    MOVZ  X21, #0xf40d, LSL #0
    MOVK  X21, #0xeba8, LSL #16
    MOVK  X21, #0xa237, LSL #32
    MOVK  X21, #0x6cc9, LSL #48
    MOVZ  X22, #0x5b11, LSL #0
    MOVK  X22, #0x710c, LSL #16
    MOVK  X22, #0x2753, LSL #32
    MOVK  X22, #0x388, LSL #48
    MOVZ  X23, #0xc982, LSL #0
    MOVK  X23, #0xf9ab, LSL #16
    MOVK  X23, #0x52e2, LSL #32
    MOVK  X23, #0x20f0, LSL #48
    MOVZ  X24, #0xdaf6, LSL #0
    MOVK  X24, #0xbb0f, LSL #16
    MOVK  X24, #0x29d9, LSL #32
    MOVK  X24, #0x4727, LSL #48
    MOVZ  X25, #0x6e3, LSL #0
    MOVK  X25, #0xee37, LSL #16
    MOVK  X25, #0x9fe7, LSL #32
    MOVK  X25, #0x3e44, LSL #48
    MOVZ  X26, #0x3a7, LSL #0
    MOVK  X26, #0x88be, LSL #16
    MOVK  X26, #0x7eec, LSL #32
    MOVK  X26, #0x3428, LSL #48
    MOVZ  X27, #0xc2b0, LSL #0
    MOVK  X27, #0x901, LSL #16
    MOVK  X27, #0xc2a3, LSL #32
    MOVK  X27, #0x86c8, LSL #48
    MOVZ  X28, #0xdbc7, LSL #0
    MOVK  X28, #0x29ea, LSL #16
    MOVK  X28, #0xc5c6, LSL #32
    MOVK  X28, #0x7dfa, LSL #48
    MOVZ  X29, #0x4f0d, LSL #0
    MOVK  X29, #0xff96, LSL #16
    MOVK  X29, #0xaf9, LSL #32
    MOVK  X29, #0xfd3f, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X5
    FMOV  D3, X22
    FMOV  V3.D[1], X14
    FMOV  D4, X2
    FMOV  V4.D[1], X26
    FMOV  D5, X22
    FMOV  V5.D[1], X6
    FMOV  D6, X27
    FMOV  V6.D[1], X20
    FMOV  D7, X7
    FMOV  V7.D[1], X29
    FMOV  D8, X25
    FMOV  V8.D[1], X25
    FMOV  D9, X22
    FMOV  V9.D[1], X11
    FMOV  D10, X11
    FMOV  V10.D[1], X13
    FMOV  D11, X3
    FMOV  V11.D[1], X26
    FMOV  D12, X28
    FMOV  V12.D[1], X3
    FMOV  D13, X6
    FMOV  V13.D[1], X19
    FMOV  D14, X3
    FMOV  V14.D[1], X18
    FMOV  D15, X6
    FMOV  V15.D[1], X20
    FMOV  D16, X29
    FMOV  V16.D[1], X27
    FMOV  D17, X2
    FMOV  V17.D[1], X2
    FMOV  D18, X24
    FMOV  V18.D[1], X5
    FMOV  D19, X17
    FMOV  V19.D[1], X2
    FMOV  D20, X20
    FMOV  V20.D[1], X25
    FMOV  D21, X24
    FMOV  V21.D[1], X11
    FMOV  D22, X28
    FMOV  V22.D[1], X18
    FMOV  D23, X18
    FMOV  V23.D[1], X23
    FMOV  D24, X20
    FMOV  V24.D[1], X27
    FMOV  D25, X17
    FMOV  V25.D[1], X27
    FMOV  D26, X13
    FMOV  V26.D[1], X22
    FMOV  D27, X26
    FMOV  V27.D[1], X16
    FMOV  D28, X28
    FMOV  V28.D[1], X6
    FMOV  D29, X13
    FMOV  V29.D[1], X11
    FMOV  D30, X22
    FMOV  V30.D[1], X2
    FMOV  D31, X25
    FMOV  V31.D[1], X24
    MOVZ  X6, #0xa, LSL #0
TSRTFloatMovMadd_label_5:
    FADD  S17, S30, S27
    FNEG  H8, H23
    FMOV  S13, W6
    FCSEL  H17, H25, H29, LS
    FSQRT  D9, D24
    FMUL  H14, H31, H30
    FNMUL  H7, H21, H17
    FMOV  H9, X20
    FNMUL  D23, D5, D28
    FSQRT  H4, H8
    FADD  H21, H14, H23
    FMOV  S13, W25
    FADD  H23, H13, H7
    FMUL  S2, S24, S12
    FMSUB  D28, D9, D23, D9
    FDIV  D5, D6, D13
    FMSUB  H7, H21, H30, H4
    FABS  H11, H7
    FNMSUB  S29, S28, S28, S23
    FMUL  H8, H2, H4
    FADD  D11, D29, D5
    FABS  S13, S8
    FSUB  D23, D20, D16
    FMSUB  S5, S27, S15, S24
    FCSEL  D4, D16, D29, AL
    FNMSUB  S6, S27, S22, S9
    FSUB  S12, S12, S14
    FMSUB  D10, D17, D15, D19
    FMOV  S30, #-10.00000000
    FNMUL  D22, D4, D17
    FDIV  D14, D28, D16
    FMOV  W22, H13
    FMOV  S21, S5
    FNMUL  D15, D27, D30
    FMSUB  S7, S6, S5, S11
    FMADD  S8, S1, S30, S22
    FMUL  H3, H10, H23
    FMOV  S11, S12
    FMOV  W7, H15
    FNMUL  D13, D21, D27
    FSUB  D10, D10, D11
    FSUB  S24, S11, S7
    FSQRT  D30, D14
    FMOV  X22, D23
    FMOV  H23, H3
    FSQRT  D5, D23
    FMOV  W21, S14
    FMOV  S4, S10
    FSQRT  H28, H12
    FCSEL  S22, S13, S18, HI
    FNMADD  D15, D22, D10, D5
    FNEG  H3, H24
    FMOV  H5, #-8.50000000
    FSUB  S21, S4, S28
    FNEG  D18, D21
    FNEG  H13, H15
    FNEG  S14, S5
    FMOV  D12, #-28.00000000
    FMOV  S5, #-7.25000000
    FNEG  H27, H0
    FNMUL  H23, H8, H13
    FADD  S15, S26, S20
    FNMUL  S21, S31, S15
    FNMADD  H10, H26, H21, H17
    FMOV  X19, H30
    FMUL  S7, S14, S14
    FDIV  S13, S7, S18
    FMOV  H18, X22
    FNMSUB  H7, H0, H12, H10
    FNEG  D4, D3
    FABS  S30, S7
    FMSUB  H26, H18, H23, H10
    FMADD  S17, S18, S24, S14
    FMUL  D24, D30, D27
    FNMADD  H25, H5, H4, H29
    FNMUL  H18, H27, H21
    FSUB  S24, S24, S23
    FNMSUB  S12, S14, S5, S0
    FMUL  H21, H12, H17
    FABS  H29, H18
    FMSUB  S30, S21, S24, S26
    FSQRT  D27, D13
    FMOV  W20, H13
    FMUL  D3, D29, D30
    FNMSUB  H18, H3, H3, H25
    FNMUL  H25, H20, H3
    FNMUL  S14, S10, S1
    FNMUL  S19, S15, S21
    FSUB  S4, S20, S8
    FCSEL  H23, H18, H7, CS
    FMOV  W21, H16
    FNMUL  H29, H4, H26
    FMOV  H7, W6
    FMADD  H5, H23, H26, H29
    FSUB  D8, D2, D13
    FSUB  S1, S10, S23
    FMOV  X29, D21
    FABS  H4, H7
    FMOV  X26, H20
    FSUB  D1, D26, D9
    FMADD  D18, D27, D11, D14
    FSQRT  S12, S4
    FADD  S17, S19, S12
    FMOV  H21, X13
    FMOV  D30, X28
    FABS  D11, D18
    FABS  D7, D27
    FNMUL  H6, H7, H0
    FSUB  D27, D29, D17
    FABS  H10, H31
    FDIV  S13, S21, S10
    FMSUB  S1, S8, S27, S0
    FSQRT  D7, D6
    FMOV  W22, S1
    FMOV  D20, D11
    FMOV  S27, W5
    FMOV  H14, #-0.16406250
    FMOV  W5, H13
    FNEG  H12, H5
    FMOV  H18, #26.00000000
    FMOV  S1, W4
    FMOV  H31, #0.12500000
    FABS  S0, S18
    FMOV  W17, S5
    FMOV  X28, D18
    FNMADD  D27, D25, D1, D1
    FMUL  S6, S30, S31
    FNEG  S9, S7
    FMSUB  H8, H18, H27, H9
    FSUB  D30, D6, D12
    FNMUL  H30, H16, H8
    FMOV  H5, W4
    FDIV  D13, D14, D0
    FMOV  D14, D5
    FMOV  S1, S26
    FMOV  H25, H5
    FNEG  D18, D30
    FMOV  X17, D18
    FSUB  H30, H13, H13
    FNEG  H20, H16
    FSQRT  S8, S17
    FMOV  D27, X3
    FCSEL  H12, H24, H8, VS
    FABS  D9, D14
    FADD  H17, H1, H8
    FMUL  H20, H25, H12
    FMUL  D24, D27, D17
    FCSEL  H0, H28, H15, LS
    FABS  S27, S0
    FSUB  S4, S9, S25
    FDIV  D27, D4, D30
    FNMSUB  H14, H20, H9, H30
    FMOV  X25, H6
    FABS  H0, H10
    FNMSUB  S1, S9, S0, S19
    FMADD  S15, S1, S28, S27
    FSQRT  S4, S15
    FMOV  X5, H1
    FMSUB  S13, S14, S0, S30
    FCSEL  S14, S24, S13, VC
    FNMADD  H1, H17, H15, H8
    FABS  S19, S27
    FSUB  H9, H25, H2
    FMUL  S17, S9, S24
    FADD  H30, H12, H31
    FSQRT  D23, D21
    FMOV  D25, #1.93750000
    FMOV  D27, X26
    FMOV  H13, H25
    FNMADD  H28, H17, H12, H27
    FNMUL  D11, D30, D31
    FMOV  D27, #-3.25000000
    FMUL  D20, D14, D23
    FMADD  D20, D28, D1, D1
    FDIV  H1, H11, H11
    FABS  H9, H27
    FDIV  S27, S4, S9
    FMUL  D12, D2, D19
    FMOV  X17, D31
    FMOV  W18, S27
    FSQRT  S25, S12
    FSUB  H8, H20, H20
    FSQRT  D28, D25
    FMOV  D27, X14
    FNEG  D12, D10
    FMOV  S30, #-26.00000000
    FADD  H2, H12, H13
    FCSEL  H0, H13, H1, PL
    FNMADD  H12, H30, H2, H0
    FMUL  H14, H27, H19
    FNMUL  H31, H8, H14
    FSUB  H2, H28, H9
    FSUB  S27, S2, S12
    FSUB  S2, S7, S1
    FMADD  S13, S6, S2, S25
    FMOV  H30, X5
    FCSEL  H8, H3, H18, LT
    FDIV  D1, D12, D13
    FABS  D14, D28
    FMOV  X20, D8
    SUBS  X6, X6, #0x1
    B.NE  TSRTFloatMovMadd_label_5
    MOVZ  X16, #0x5847, LSL #0
    MOVK  X16, #0x739e, LSL #16
    MOVK  X16, #0xc42d, LSL #32
    MOVK  X16, #0xd4ad, LSL #48
    SUB  X11, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xb8a1, LSL #0
    MOVK  X16, #0x54d5, LSL #16
    MOVK  X16, #0xcc5f, LSL #32
    MOVK  X16, #0x5c63, LSL #48
    SUB  X11, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x30e8, LSL #0
    MOVK  X16, #0x549f, LSL #16
    MOVK  X16, #0x450f, LSL #32
    MOVK  X16, #0xb561, LSL #48
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x5eff, LSL #0
    MOVK  X16, #0x5701, LSL #16
    MOVK  X16, #0xae00, LSL #32
    MOVK  X16, #0x35b2, LSL #48
    SUB  X11, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xc451, LSL #0
    MOVK  X16, #0x22e2, LSL #16
    MOVK  X16, #0xa89f, LSL #32
    MOVK  X16, #0x2f52, LSL #48
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x3000, LSL #0
    SUB  X11, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    SUB  X11, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x5551, LSL #0
    SUB  X11, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x4f0d, LSL #0
    SUB  X11, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x1, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X11, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xc982, LSL #0
    MOVK  X16, #0xf9ab, LSL #16
    MOVK  X16, #0x52e2, LSL #32
    MOVK  X16, #0x20f0, LSL #48
    SUB  X11, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X11, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xc2b0, LSL #0
    MOVK  X16, #0x901, LSL #16
    MOVK  X16, #0xc2a3, LSL #32
    MOVK  X16, #0x86c8, LSL #48
    SUB  X11, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x4e80, LSL #0
    SUB  X11, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x3826, LSL #0
    SUB  X11, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MRS  X16, FPSR
    MOVZ  X11, #0x1f, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D0
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D1
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff0, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D2
    MOVZ  X11, #0x3bcb, LSL #0
    MOVK  X11, #0x667f, LSL #16
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D5
    MOVZ  X11, #0x30e8, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D7
    MOVZ  X11, #0x3bcc, LSL #0
    MOVK  X11, #0x667f, LSL #16
    MOVK  X11, #0xa09e, LSL #32
    MOVK  X11, #0x1ed6, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D8
    MOVZ  X11, #0x5551, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D10
    MOVZ  X11, #0x7e00, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D11
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D12
    MOVZ  X11, #0x7e00, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X11, #0xc2b0, LSL #0
    MOVK  X11, #0x901, LSL #16
    MOVK  X11, #0xc2a3, LSL #32
    MOVK  X11, #0x86c8, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D16
    MOVZ  X11, #0x4f0d, LSL #0
    MOVK  X11, #0xff96, LSL #16
    MOVK  X11, #0xaf9, LSL #32
    MOVK  X11, #0xfd3f, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D17
    MOVZ  X11, #0x3cf7, LSL #0
    MOVK  X11, #0x94dc, LSL #16
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D18
    MOVZ  X11, #0x5551, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D20
    MOVZ  X11, #0x7e00, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D21
    MOVZ  X11, #0x5eff, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D23
    MOVZ  X11, #0xd8ec, LSL #0
    MOVK  X11, #0x9023, LSL #16
    MOVK  X11, #0x7e41, LSL #32
    MOVK  X11, #0x1ed3, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D24
    MOVZ  X11, #0x61be, LSL #0
    MOVK  X11, #0xd782, LSL #16
    MOVK  X11, #0x7d2d, LSL #32
    MOVK  X11, #0x1a33, LSL #48
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D26
    MOVZ  X11, #0x7e00, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D27
    MOVZ  X11, #0x200, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D29
    MOVZ  X11, #0xfe00, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D30
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D31
    MOVZ  X11, #0xfe00, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X13
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X7
    FMOV  V3.D[1], X24
    FMOV  D4, X20
    FMOV  V4.D[1], X25
    FMOV  D5, X14
    FMOV  V5.D[1], X21
    FMOV  D6, X22
    FMOV  V6.D[1], X25
    FMOV  D7, X28
    FMOV  V7.D[1], X20
    FMOV  D8, X20
    FMOV  V8.D[1], X13
    FMOV  D9, X2
    FMOV  V9.D[1], X25
    FMOV  D10, X4
    FMOV  V10.D[1], X25
    FMOV  D11, X7
    FMOV  V11.D[1], X26
    FMOV  D12, X26
    FMOV  V12.D[1], X27
    FMOV  D13, X26
    FMOV  V13.D[1], X22
    FMOV  D14, X25
    FMOV  V14.D[1], X19
    FMOV  D15, X24
    FMOV  V15.D[1], X11
    FMOV  D16, X23
    FMOV  V16.D[1], X20
    FMOV  D17, X24
    FMOV  V17.D[1], X24
    FMOV  D18, X17
    FMOV  V18.D[1], X7
    FMOV  D19, X27
    FMOV  V19.D[1], X22
    FMOV  D20, X6
    FMOV  V20.D[1], X17
    FMOV  D21, X2
    FMOV  V21.D[1], X24
    FMOV  D22, X7
    FMOV  V22.D[1], X17
    FMOV  D23, X26
    FMOV  V23.D[1], X7
    FMOV  D24, X3
    FMOV  V24.D[1], X11
    FMOV  D25, X4
    FMOV  V25.D[1], X4
    FMOV  D26, X18
    FMOV  V26.D[1], X14
    FMOV  D27, X6
    FMOV  V27.D[1], X27
    FMOV  D28, X19
    FMOV  V28.D[1], X25
    FMOV  D29, X7
    FMOV  V29.D[1], X7
    FMOV  D30, X3
    FMOV  V30.D[1], X3
    FMOV  D31, X23
    FMOV  V31.D[1], X2
    MOVZ  X4, #0xa, LSL #0
TSRTFloatMovMadd_label_6:
    FMADD  H4, H23, H24, H23
    FABS  D23, D26
    FMOV  D27, #31.00000000
    FDIV  D16, D30, D30
    FADD  H2, H7, H29
    FCSEL  S9, S30, S14, CS
    FNEG  H24, H2
    FADD  S13, S27, S16
    FNMADD  S1, S23, S24, S31
    FDIV  D26, D13, D28
    FDIV  H19, H9, H4
    FDIV  H31, H25, H19
    FDIV  H22, H26, H12
    FMADD  S13, S1, S18, S6
    FMOV  D31, X5
    FABS  H26, H4
    FNMSUB  D28, D6, D0, D10
    FDIV  H24, H22, H26
    FADD  H30, H28, H13
    FABS  H4, H31
    FMUL  S1, S4, S13
    FMOV  H9, H1
    FMUL  D31, D30, D30
    FABS  D23, D24
    FSQRT  D30, D4
    FMOV  H14, H31
    FSQRT  D18, D23
    FNMADD  H4, H28, H30, H27
    FDIV  S1, S18, S9
    FMOV  D22, #-0.37500000
    FMOV  S18, W6
    FABS  D31, D1
    FMOV  X14, H14
    FCSEL  S16, S8, S22, EQ
    FMOV  D23, X24
    FDIV  D8, D20, D20
    FMOV  D28, #-26.00000000
    FMADD  D25, D22, D1, D31
    FCSEL  H31, H8, H10, LT
    FNMADD  D30, D22, D23, D25
    FMSUB  S29, S15, S4, S16
    FADD  S8, S16, S28
    FABS  H10, H7
    FMOV  X19, H30
    FCSEL  S16, S8, S26, PL
    FMOV  X14, H10
    FMOV  H13, X20
    FMUL  S14, S31, S31
    FMADD  H25, H13, H13, H13
    FADD  S22, S29, S25
    FCSEL  S9, S14, S21, LS
    FMUL  D7, D8, D16
    FSUB  D18, D22, D18
    FCSEL  D15, D21, D15, GE
    FABS  D27, D24
    FDIV  H23, H9, H9
    FNMUL  S22, S7, S18
    FADD  D1, D22, D22
    FCSEL  D28, D13, D14, NV
    FMOV  S9, S15
    FMOV  S21, S12
    FDIV  H16, H9, H1
    FMOV  S22, S28
    FSQRT  S31, S16
    FNEG  H29, H21
    FCSEL  H8, H29, H3, GE
    FMADD  S18, S7, S22, S8
    FMUL  H21, H27, H27
    FMADD  D9, D23, D23, D21
    FNMADD  H26, H20, H26, H31
    FNMSUB  D23, D18, D26, D9
    FCSEL  D25, D28, D8, LT
    FABS  D21, D19
    FNMUL  S20, S4, S6
    FMOV  H14, X25
    FMOV  W21, H23
    FMOV  H12, X21
    FMOV  X11, H25
    FMOV  S23, #-8.00000000
    FNMADD  D22, D12, D6, D10
    FMOV  X25, H31
    FSUB  D18, D22, D3
    FDIV  H29, H1, H26
    FMOV  X21, H6
    FMSUB  H13, H5, H20, H26
    FDIV  S26, S9, S24
    FSUB  S22, S16, S26
    FNMUL  S28, S3, S2
    FNMUL  D20, D5, D10
    FDIV  S19, S22, S13
    FMOV  H8, X7
    FMOV  W19, S19
    FMSUB  H13, H23, H15, H28
    FMOV  D31, D20
    FNMSUB  S28, S18, S31, S13
    FMOV  S3, W14
    FMSUB  S26, S7, S8, S21
    FMADD  D18, D20, D3, D14
    FADD  D4, D26, D29
    FCSEL  D23, D30, D23, CS
    FCSEL  H15, H4, H31, GE
    FMUL  D3, D24, D28
    FMSUB  S19, S18, S23, S29
    FABS  D23, D2
    FMSUB  H18, H3, H3, H22
    FSUB  S30, S8, S19
    FABS  D29, D18
    FNMUL  S24, S12, S15
    FDIV  D7, D20, D30
    FNMUL  D26, D19, D21
    FMUL  H12, H23, H29
    FSQRT  H14, H7
    FMSUB  S29, S12, S9, S24
    FADD  D2, D29, D5
    FMOV  D16, #24.00000000
    FSUB  D28, D2, D27
    FABS  S4, S28
    FMOV  H5, X17
    FMSUB  S19, S26, S26, S11
    FDIV  S3, S3, S19
    FADD  H7, H5, H21
    FCSEL  D12, D29, D16, GT
    FMSUB  D8, D2, D1, D12
    FCSEL  S20, S7, S4, MI
    FMOV  H21, X18
    FCSEL  S5, S20, S8, VS
    FMOV  H7, H26
    FCSEL  D1, D3, D3, LT
    FDIV  D23, D1, D21
    FNMSUB  S22, S20, S13, S28
    FMOV  S11, #0.59375000
    FSUB  S2, S23, S6
    FNMSUB  S13, S2, S11, S7
    FADD  D21, D11, D7
    FABS  D12, D24
    FMOV  D24, D5
    FMOV  D2, X20
    FCSEL  S5, S14, S21, NE
    FMOV  W28, H22
    FMUL  H1, H6, H5
    FSQRT  D4, D12
    FDIV  S3, S14, S2
    FCSEL  D7, D24, D3, LS
    FADD  H26, H4, H22
    FMOV  S11, W20
    FMSUB  S8, S31, S11, S11
    FMSUB  H21, H30, H8, H7
    FSQRT  S4, S18
    FSUB  D30, D13, D14
    FMADD  S9, S26, S26, S14
    FMOV  X22, D1
    FNMADD  H24, H9, H15, H30
    FNMSUB  D30, D21, D21, D24
    FSUB  S3, S13, S11
    FSUB  D12, D8, D2
    FMOV  D15, X5
    FDIV  H22, H11, H14
    FSQRT  D24, D16
    FMOV  W16, H23
    FMUL  S14, S26, S6
    FABS  S27, S7
    FABS  D10, D15
    FMADD  D14, D4, D3, D30
    FMOV  X29, H22
    FNMADD  H2, H27, H9, H24
    FDIV  S12, S12, S12
    FCSEL  D7, D6, D14, GT
    FNMADD  D1, D2, D12, D2
    FABS  S16, S20
    FCSEL  S21, S7, S16, GE
    FSQRT  H10, H21
    FMOV  S11, S9
    FMOV  D26, D28
    FMOV  X20, D25
    FCSEL  D28, D21, D27, CS
    FMOV  W25, H5
    FMOV  X28, H22
    FNMUL  H20, H3, H11
    FMUL  H30, H3, H31
    FMADD  D8, D21, D25, D0
    FABS  H31, H15
    FMSUB  S15, S6, S7, S25
    FNMUL  S25, S31, S10
    FNMADD  D2, D31, D28, D25
    FMOV  H19, W14
    FMOV  S16, S8
    FADD  D31, D19, D16
    FABS  D0, D31
    FNEG  S25, S24
    FNEG  S11, S13
    FMOV  X17, H30
    FCSEL  D10, D15, D11, NV
    FDIV  S11, S25, S10
    FMOV  D6, #0.50000000
    FADD  S8, S11, S6
    FDIV  H30, H1, H28
    FMSUB  D6, D2, D30, D8
    FMOV  H31, X24
    FMUL  H6, H6, H15
    FCSEL  S11, S31, S26, PL
    SUBS  X4, X4, #0x1
    B.NE  TSRTFloatMovMadd_label_6
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x8000, LSL #0
    SUB  X2, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x7e00, LSL #0
    SUB  X2, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x8000, LSL #0
    SUB  X2, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xff80, LSL #16
    SUB  X2, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x8000, LSL #0
    SUB  X2, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x7e00, LSL #0
    SUB  X2, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x7e00, LSL #0
    SUB  X2, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x7e00, LSL #0
    SUB  X2, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X27, #0x7e00, LSL #0
    SUB  X2, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MRS  X27, FPSR
    MOVZ  X2, #0x1f, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D0
    MOVZ  X2, #0xf000, LSL #0
    MOVK  X2, #0x3, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D1
    MOVZ  X2, #0xa12f, LSL #0
    MOVK  X2, #0x8000, LSL #48
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D2
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    MOVK  X2, #0x8000, LSL #48
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D3
    MOVZ  X2, #0xcad0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D4
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x1e00, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D6
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D7
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D8
    MOVZ  X2, #0x2241, LSL #0
    MOVK  X2, #0xd709, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D10
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D12
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D13
    MOVZ  X2, #0x4ad0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D14
    MOVZ  X2, #0x7e00, LSL #0
    MOVK  X2, #0x8000, LSL #48
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D15
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D16
    MOVZ  X2, #0x7200, LSL #0
    MOVK  X2, #0x3, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D18
    MOVZ  X2, #0x8000, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D19
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D21
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D22
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D23
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff0, LSL #48
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D24
    MOVZ  X2, #0x212e, LSL #0
    MOVK  X2, #0x1409, LSL #16
    MOVK  X2, #0x988e, LSL #32
    MOVK  X2, #0x4013, LSL #48
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D25
    MOVZ  X2, #0x212e, LSL #0
    MOVK  X2, #0x9409, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D26
    MOVZ  X2, #0x8201, LSL #0
    MOVK  X2, #0x7fff, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D28
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D29
    MOVZ  X2, #0x1, LSL #0
    MOVK  X2, #0x8000, LSL #16
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D30
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    FMOV  X27, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    FMOV  D0, X3
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X17
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X16
    FMOV  D4, X22
    FMOV  V4.D[1], X25
    FMOV  D5, X27
    FMOV  V5.D[1], X2
    FMOV  D6, X20
    FMOV  V6.D[1], X6
    FMOV  D7, X13
    FMOV  V7.D[1], X3
    FMOV  D8, X20
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X14
    FMOV  D10, X27
    FMOV  V10.D[1], X18
    FMOV  D11, X11
    FMOV  V11.D[1], X26
    FMOV  D12, X24
    FMOV  V12.D[1], X24
    FMOV  D13, X23
    FMOV  V13.D[1], X21
    FMOV  D14, X6
    FMOV  V14.D[1], X24
    FMOV  D15, X17
    FMOV  V15.D[1], X17
    FMOV  D16, X24
    FMOV  V16.D[1], X24
    FMOV  D17, X20
    FMOV  V17.D[1], X6
    FMOV  D18, X23
    FMOV  V18.D[1], X5
    FMOV  D19, X11
    FMOV  V19.D[1], X13
    FMOV  D20, X22
    FMOV  V20.D[1], X7
    FMOV  D21, X25
    FMOV  V21.D[1], X3
    FMOV  D22, X25
    FMOV  V22.D[1], X22
    FMOV  D23, X25
    FMOV  V23.D[1], X3
    FMOV  D24, X29
    FMOV  V24.D[1], X4
    FMOV  D25, X13
    FMOV  V25.D[1], X27
    FMOV  D26, X7
    FMOV  V26.D[1], X17
    FMOV  D27, X3
    FMOV  V27.D[1], X21
    FMOV  D28, X2
    FMOV  V28.D[1], X26
    FMOV  D29, X28
    FMOV  V29.D[1], X28
    FMOV  D30, X24
    FMOV  V30.D[1], X18
    FMOV  D31, X22
    FMOV  V31.D[1], X24
    MOVZ  X16, #0xa, LSL #0
TSRTFloatMovMadd_label_7:
    FMADD  D20, D19, D1, D31
    FSQRT  D29, D24
    FMOV  X13, D25
    FNEG  D17, D30
    FNMSUB  H14, H6, H29, H27
    FSQRT  H12, H24
    FMSUB  D1, D14, D1, D14
    FMADD  D21, D1, D19, D10
    FNMSUB  D31, D26, D12, D17
    FMADD  S30, S28, S23, S28
    FMOV  S26, W16
    FADD  H12, H18, H20
    FMOV  D14, #-1.00000000
    FDIV  D1, D12, D21
    FMSUB  D10, D31, D26, D31
    FNMUL  D1, D10, D30
    FMADD  H30, H1, H14, H10
    FMOV  S20, #0.71875000
    FMADD  H12, H29, H19, H2
    FMADD  S22, S23, S3, S28
    FNMADD  H10, H6, H2, H13
    FSUB  H6, H26, H23
    FMADD  D26, D18, D26, D6
    FABS  D29, D4
    FMOV  H14, X21
    FNMSUB  S6, S25, S12, S24
    FMOV  S4, W24
    FCSEL  D31, D14, D22, NV
    FNMUL  S2, S20, S21
    FMSUB  D19, D10, D4, D6
    FMOV  S27, W22
    FMUL  H14, H2, H19
    FMOV  S25, W6
    FMSUB  D18, D29, D3, D29
    FMOV  H1, H18
    FMOV  H0, #-0.75000000
    FMADD  H23, H14, H25, H27
    FNEG  H30, H0
    FMUL  S10, S31, S1
    FNMUL  H5, H10, H26
    FCSEL  S19, S30, S30, VC
    FMOV  W6, S5
    FMOV  H13, X5
    FMOV  H2, H17
    FMSUB  S0, S23, S17, S19
    FADD  D6, D6, D4
    FNMADD  D22, D24, D27, D1
    FMADD  D23, D30, D17, D2
    FABS  D25, D0
    FMOV  X5, D20
    FMUL  D21, D23, D23
    FNMADD  D12, D6, D19, D16
    FMOV  X24, H25
    FMOV  W21, H5
    FMADD  S29, S4, S12, S13
    FABS  D30, D22
    FABS  S0, S13
    FSQRT  S6, S30
    FMOV  D25, #0.48437500
    FADD  H5, H25, H1
    FNMADD  H22, H29, H6, H2
    FMUL  D22, D0, D5
    FSUB  H27, H25, H21
    FCSEL  D16, D1, D21, MI
    FSQRT  D24, D11
    FMOV  H1, W5
    FNMADD  D13, D9, D9, D24
    FMSUB  H9, H15, H17, H20
    FMADD  S25, S30, S20, S11
    FSQRT  D10, D10
    FMUL  D18, D29, D15
    FMSUB  D30, D17, D13, D18
    FSUB  D6, D15, D9
    FMOV  S21, W3
    FCSEL  S2, S16, S22, NE
    FMOV  D14, D30
    FMUL  D26, D21, D2
    FNMADD  H13, H0, H14, H6
    FNMUL  S5, S17, S3
    FNEG  H6, H9
    FABS  H2, H0
    FMOV  S19, S26
    FSUB  H0, H27, H19
    FADD  H14, H27, H18
    FMOV  W25, H13
    FMOV  H29, #-11.50000000
    FMOV  H19, H6
    FNMSUB  D11, D5, D29, D12
    FCSEL  H12, H2, H14, LE
    FNMUL  H26, H17, H19
    FCSEL  H5, H11, H12, GE
    FMSUB  D27, D0, D23, D12
    FNMADD  H23, H26, H18, H11
    FNMADD  D15, D25, D23, D22
    FMOV  W24, S27
    FMSUB  H27, H15, H5, H15
    FMADD  S3, S27, S12, S27
    FNMSUB  H5, H3, H3, H3
    FABS  D18, D7
    FNMSUB  H6, H19, H21, H9
    FADD  H7, H6, H6
    FNMSUB  H3, H20, H18, H12
    FMADD  S15, S30, S0, S24
    FMSUB  S25, S28, S12, S29
    FMOV  X13, D2
    FMSUB  H17, H28, H12, H28
    FMOV  H26, W22
    FMOV  X24, H9
    FCSEL  D14, D24, D29, CC
    FNEG  H27, H27
    FADD  D25, D23, D10
    FMOV  S21, S27
    FSQRT  D22, D5
    FNEG  H9, H25
    FNEG  D27, D24
    FABS  D23, D27
    FCSEL  H30, H16, H26, LE
    FMOV  H19, X2
    FCSEL  D6, D30, D14, CS
    FNMUL  H16, H22, H23
    FMOV  X13, H7
    FSUB  H25, H17, H9
    FABS  H22, H8
    FMOV  X14, H19
    FSUB  S21, S23, S23
    FMUL  S5, S22, S26
    FMADD  D4, D2, D24, D5
    FMOV  S10, S26
    FMADD  H21, H25, H16, H4
    FCSEL  S26, S26, S6, HI
    FSQRT  S17, S28
    FMOV  S7, W28
    FNMADD  D12, D17, D26, D0
    FMUL  H14, H13, H7
    FNMSUB  S0, S12, S14, S14
    FNMUL  H17, H8, H0
    FNEG  H9, H10
    FMOV  X17, H21
    FCSEL  H0, H17, H1, EQ
    FABS  H28, H29
    FNEG  D16, D15
    FCSEL  S15, S29, S12, AL
    FDIV  D26, D16, D12
    FABS  D13, D13
    FCSEL  H12, H1, H17, VC
    FSQRT  H23, H5
    FNEG  H10, H24
    FMOV  H7, H19
    FABS  S5, S28
    FMOV  H6, H26
    FMOV  H23, #-3.50000000
    FNEG  S26, S5
    FMOV  H21, W13
    FMOV  S12, #-1.68750000
    FDIV  S5, S9, S6
    FMOV  H16, #14.00000000
    FMOV  S29, W22
    FNEG  S31, S16
    FCSEL  H16, H1, H29, MI
    FNMUL  H1, H31, H26
    FABS  H8, H23
    FMOV  S5, W28
    FMOV  S6, #0.18750000
    FMOV  D31, D5
    FSUB  S28, S16, S15
    FNEG  D26, D20
    FNMUL  H29, H26, H21
    FNMADD  S14, S28, S29, S13
    FCSEL  H13, H8, H14, CC
    FNMADD  S24, S31, S20, S13
    FMUL  H19, H24, H7
    FNMUL  D17, D19, D6
    FNMSUB  D23, D1, D16, D12
    FSQRT  D29, D23
    FSUB  S13, S17, S24
    FMSUB  H9, H11, H29, H1
    FMOV  D22, #0.29687500
    FMUL  D15, D9, D4
    FMOV  D24, X22
    FMOV  S4, W21
    FMUL  D4, D15, D15
    FMUL  S8, S22, S22
    FMADD  H7, H20, H17, H4
    FMOV  S6, #0.59375000
    FABS  H15, H8
    FNMADD  S22, S7, S25, S13
    FMOV  S17, S22
    FNMADD  S16, S24, S24, S7
    FNMUL  H21, H17, H24
    FNMADD  D1, D15, D16, D30
    FDIV  H14, H14, H20
    FMUL  H11, H21, H8
    FMOV  H8, X16
    FMSUB  D17, D13, D14, D1
    FMUL  D22, D16, D11
    FDIV  H7, H6, H6
    FMOV  X22, H8
    FADD  H16, H20, H17
    FMUL  H25, H16, H27
    FNEG  D14, D7
    SUBS  X16, X16, #0x1
    B.NE  TSRTFloatMovMadd_label_7
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x3f38, LSL #16
    SUB  X29, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x7e00, LSL #0
    SUB  X29, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    SUB  X29, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x1, LSL #0
    SUB  X29, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X29, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X29, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MRS  X20, FPSR
    MOVZ  X29, #0x1f, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D1
    MOVZ  X29, #0x2, LSL #0
    MOVK  X29, #0x8000, LSL #48
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D3
    MOVZ  X29, #0x7e00, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D5
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D6
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x3f18, LSL #16
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D7
    MOVZ  X29, #0x7e00, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D8
    MOVZ  X29, #0x1, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D9
    MOVZ  X29, #0xd908, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D10
    MOVZ  X29, #0xbbcc, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D11
    MOVZ  X29, #0x8000, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D12
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xbfd8, LSL #16
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D13
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7fc0, LSL #16
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D14
    MOVZ  X29, #0x7e00, LSL #0
    MOVK  X29, #0x8000, LSL #48
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D17
    MOVZ  X29, #0x3, LSL #0
    MOVK  X29, #0x8000, LSL #48
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D18
    MOVZ  X29, #0x7e00, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D19
    MOVZ  X29, #0x7e00, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D20
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x3f38, LSL #16
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D21
    MOVZ  X29, #0x8000, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D23
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xbfd8, LSL #16
    MOVK  X29, #0x8000, LSL #48
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D24
    MOVZ  X29, #0x2, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D26
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x3f38, LSL #16
    MOVK  X29, #0x8000, LSL #48
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D27
    MOVZ  X29, #0x3bcc, LSL #0
    MOVK  X29, #0x667f, LSL #16
    MOVK  X29, #0xa09e, LSL #32
    MOVK  X29, #0x9ed6, LSL #48
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D28
    MOVZ  X29, #0xc9be, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D29
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7ff8, LSL #48
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D30
    MOVZ  X29, #0x2, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    FMOV  X20, D31
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X27, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X4
    FMOV  V1.D[1], X5
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X19
    FMOV  V3.D[1], X14
    FMOV  D4, X26
    FMOV  V4.D[1], X24
    FMOV  D5, X14
    FMOV  V5.D[1], X28
    FMOV  D6, X27
    FMOV  V6.D[1], X29
    FMOV  D7, X14
    FMOV  V7.D[1], X5
    FMOV  D8, X2
    FMOV  V8.D[1], X27
    FMOV  D9, X21
    FMOV  V9.D[1], X2
    FMOV  D10, X27
    FMOV  V10.D[1], X11
    FMOV  D11, X26
    FMOV  V11.D[1], X28
    FMOV  D12, X3
    FMOV  V12.D[1], X20
    FMOV  D13, X22
    FMOV  V13.D[1], X28
    FMOV  D14, X17
    FMOV  V14.D[1], X2
    FMOV  D15, X7
    FMOV  V15.D[1], X14
    FMOV  D16, X7
    FMOV  V16.D[1], X20
    FMOV  D17, X25
    FMOV  V17.D[1], X24
    FMOV  D18, X26
    FMOV  V18.D[1], X16
    FMOV  D19, X18
    FMOV  V19.D[1], X2
    FMOV  D20, X23
    FMOV  V20.D[1], X20
    FMOV  D21, X27
    FMOV  V21.D[1], X28
    FMOV  D22, X19
    FMOV  V22.D[1], X23
    FMOV  D23, X6
    FMOV  V23.D[1], X26
    FMOV  D24, X3
    FMOV  V24.D[1], X6
    FMOV  D25, X28
    FMOV  V25.D[1], X26
    FMOV  D26, X3
    FMOV  V26.D[1], X21
    FMOV  D27, X4
    FMOV  V27.D[1], X26
    FMOV  D28, X16
    FMOV  V28.D[1], X6
    FMOV  D29, X16
    FMOV  V29.D[1], X23
    FMOV  D30, X22
    FMOV  V30.D[1], X7
    FMOV  D31, X17
    FMOV  V31.D[1], X19
    MOVZ  X4, #0xa, LSL #0
TSRTFloatMovMadd_label_8:
    FNMSUB  S13, S6, S30, S24
    FMOV  D5, X13
    FCSEL  H5, H13, H28, CS
    FNEG  H16, H25
    FDIV  D4, D31, D12
    FNEG  S16, S26
    FSQRT  S22, S29
    FMUL  H16, H4, H20
    FMOV  X23, H17
    FMADD  D2, D27, D22, D16
    FMOV  D20, D2
    FNMSUB  H29, H20, H3, H18
    FABS  D13, D29
    FMOV  D20, X24
    FADD  D2, D7, D21
    FNMSUB  H3, H13, H5, H29
    FMOV  H27, #-1.62500000
    FMUL  H7, H20, H16
    FMSUB  S18, S7, S3, S2
    FMOV  W2, S28
    FMUL  S3, S5, S14
    FSQRT  S22, S7
    FMOV  H26, W20
    FMOV  W13, H11
    FMOV  S12, S22
    FMADD  S13, S5, S14, S11
    FMOV  X24, D19
    FCSEL  S11, S5, S27, AL
    FNEG  H2, H1
    FMADD  H27, H12, H28, H31
    FMOV  S14, W7
    FMOV  W5, H21
    FMOV  D29, #-0.65625000
    FMADD  H5, H14, H14, H29
    FCSEL  H4, H26, H20, NE
    FNMSUB  H29, H5, H4, H4
    FNMADD  D28, D13, D3, D11
    FDIV  S16, S2, S4
    FNMADD  D5, D1, D10, D28
    FABS  H3, H15
    FNMUL  D1, D21, D3
    FMSUB  S12, S29, S19, S4
    FNMADD  D22, D30, D27, D11
    FABS  D15, D5
    FMSUB  D29, D16, D22, D16
    FNMSUB  S4, S15, S15, S31
    FCSEL  S9, S18, S29, EQ
    FMOV  X2, D30
    FNMADD  D24, D9, D17, D14
    FMOV  H22, X23
    FDIV  H9, H2, H12
    FMUL  S31, S1, S22
    FNMUL  H22, H9, H31
    FNMSUB  H16, H4, H22, H13
    FABS  H15, H14
    FMOV  W13, S6
    FNMSUB  D6, D19, D15, D13
    FADD  D4, D10, D11
    FNMADD  H14, H3, H12, H3
    FNMSUB  D10, D20, D5, D17
    FNMSUB  S15, S24, S1, S22
    FNMUL  H31, H6, H17
    FCSEL  S9, S15, S7, CC
    FMADD  S13, S30, S9, S31
    FCSEL  D11, D30, D23, VS
    FNMADD  D31, D30, D28, D9
    FMOV  H28, #0.14062500
    FNMUL  S24, S12, S2
    FSUB  H29, H25, H10
    FADD  H12, H5, H13
    FNMSUB  S13, S14, S28, S24
    FADD  D18, D13, D16
    FMOV  S2, #14.00000000
    FMUL  H17, H20, H29
    FADD  S23, S9, S18
    FNMADD  D5, D29, D4, D3
    FMOV  D13, X7
    FSUB  D22, D31, D22
    FMOV  S31, #-6.00000000
    FMOV  S7, #-1.25000000
    FMSUB  S19, S9, S17, S17
    FMOV  S16, S31
    FADD  S17, S19, S11
    FNEG  D20, D23
    FMOV  S23, #0.96875000
    FMOV  W18, S20
    FDIV  H14, H14, H18
    FMOV  D10, D22
    FNEG  D24, D12
    FMOV  W26, S25
    FMOV  D25, X29
    FMADD  S12, S28, S31, S14
    FMUL  H17, H4, H23
    FMOV  H26, W11
    FMUL  S21, S2, S16
    FNMUL  S3, S12, S13
    FADD  H31, H25, H10
    FSUB  S12, S8, S24
    FSQRT  S4, S7
    FNEG  H22, H31
    FMUL  D16, D4, D22
    FMOV  H25, W22
    FMOV  S16, W14
    FMSUB  H7, H21, H1, H26
    FSQRT  S26, S0
    FNMSUB  D8, D25, D3, D22
    FMOV  S31, W27
    FMUL  H4, H12, H16
    FNEG  D23, D4
    FDIV  S20, S31, S26
    FNMSUB  S24, S23, S20, S25
    FMOV  S10, #-3.37500000
    FDIV  S20, S7, S8
    FMUL  S7, S24, S3
    FSUB  S1, S11, S25
    FNMUL  D28, D1, D1
    FCSEL  D23, D29, D7, AL
    FMSUB  D31, D8, D17, D28
    FMOV  D3, X18
    FCSEL  H12, H20, H29, CC
    FSQRT  S17, S3
    FMOV  W17, H23
    FNMSUB  S23, S16, S10, S17
    FABS  S7, S7
    FSQRT  D4, D12
    FNMADD  D8, D31, D4, D31
    FMOV  W19, H8
    FMSUB  D4, D9, D17, D23
    FMSUB  D11, D0, D5, D20
    FNMUL  H24, H8, H12
    FMOV  D29, #-0.48437500
    FMOV  H23, H15
    FMOV  H0, X24
    FSUB  H24, H30, H6
    FMADD  S25, S6, S26, S7
    FMOV  H3, X11
    FMOV  D5, D1
    FADD  D30, D4, D3
    FSUB  D7, D23, D20
    FNMADD  H4, H4, H24, H29
    FSUB  H31, H4, H29
    FMOV  S17, S5
    FSUB  D24, D31, D28
    FCSEL  D8, D24, D0, GE
    FSQRT  H6, H8
    FNMUL  S20, S25, S7
    FSQRT  D7, D29
    FMSUB  D9, D12, D20, D11
    FNMUL  D28, D17, D9
    FDIV  S25, S11, S12
    FDIV  H10, H28, H30
    FNMADD  S26, S6, S10, S6
    FMOV  D12, X2
    FMADD  S29, S26, S25, S21
    FNEG  D7, D9
    FNEG  H10, H7
    FMOV  H15, #6.25000000
    FABS  H0, H29
    FMOV  H26, W4
    FNEG  D24, D12
    FNMUL  S1, S25, S26
    FNMADD  D26, D0, D21, D6
    FSUB  H31, H26, H1
    FMADD  H9, H1, H31, H1
    FSQRT  H26, H15
    FMOV  S11, W27
    FNMADD  S28, S26, S10, S24
    FDIV  D30, D19, D11
    FSQRT  H6, H10
    FCSEL  D7, D8, D23, CS
    FSUB  H29, H6, H25
    FMOV  S8, W27
    FNMADD  D14, D1, D7, D31
    FADD  S23, S14, S14
    FMSUB  D12, D14, D29, D23
    FNMADD  S15, S6, S5, S13
    FMOV  S21, #2.75000000
    FABS  S29, S23
    FSUB  H24, H20, H29
    FNEG  H19, H8
    FMOV  H20, H30
    FNMADD  H7, H12, H21, H15
    FCSEL  D26, D7, D28, VC
    FSQRT  H0, H7
    FMOV  X17, H22
    FCSEL  S25, S0, S24, MI
    FMSUB  D3, D25, D19, D20
    FMUL  S5, S8, S30
    FMSUB  D20, D24, D5, D7
    FNMADD  H13, H20, H4, H26
    FMADD  H7, H5, H13, H13
    FSQRT  H21, H7
    FSUB  D29, D21, D21
    FMADD  H23, H3, H2, H3
    FMOV  S7, #0.34375000
    FNMADD  S31, S23, S8, S29
    FCSEL  H1, H21, H30, AL
    FMADD  D15, D30, D0, D17
    FSUB  S23, S14, S28
    FNEG  D17, D8
    SUBS  X4, X4, #0x1
    B.NE  TSRTFloatMovMadd_label_8
    MOVZ  X28, #0xfa7d, LSL #0
    MOVK  X28, #0xaac0, LSL #16
    MOVK  X28, #0x4fd2, LSL #32
    MOVK  X28, #0x3ef6, LSL #48
    SUB  X6, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    SUB  X6, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x2716, LSL #0
    SUB  X6, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xfc00, LSL #0
    SUB  X6, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xfc00, LSL #0
    SUB  X6, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    SUB  X6, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xda5a, LSL #0
    SUB  X6, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    SUB  X6, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MRS  X28, FPSR
    MOVZ  X6, #0x1f, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D0
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D1
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D2
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x4160, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D3
    MOVZ  X6, #0xfa7c, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D4
    MOVZ  X6, #0x7ae4, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D5
    MOVZ  X6, #0x996b, LSL #0
    MOVK  X6, #0xc5a4, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D6
    MOVZ  X6, #0x2716, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D7
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3eb0, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D8
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D9
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D10
    MOVZ  X6, #0x1248, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D11
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D12
    MOVZ  X6, #0xfc02, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D13
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D14
    MOVZ  X6, #0x7e01, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D15
    MOVZ  X6, #0xfa7d, LSL #0
    MOVK  X6, #0xaac0, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D16
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D17
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D18
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D19
    MOVZ  X6, #0xda5a, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D20
    MOVZ  X6, #0x7dff, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D21
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D22
    MOVZ  X6, #0xfc00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D23
    MOVZ  X6, #0xfa7c, LSL #0
    MOVK  X6, #0xaac0, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D24
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D25
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D26
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D27
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D28
    MOVZ  X6, #0xfa7c, LSL #0
    MOVK  X6, #0x2ac0, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D29
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D30
    MOVZ  X6, #0xfa7d, LSL #0
    MOVK  X6, #0xaac0, LSL #16
    MOVK  X6, #0x4fd2, LSL #32
    MOVK  X6, #0x3ef6, LSL #48
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X28, D31
    MOVZ  X6, #0xa600, LSL #0
    MOVK  X6, #0x97d5, LSL #16
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X6
    FMOV  V3.D[1], X24
    FMOV  D4, X18
    FMOV  V4.D[1], X18
    FMOV  D5, X14
    FMOV  V5.D[1], X29
    FMOV  D6, X21
    FMOV  V6.D[1], X13
    FMOV  D7, X6
    FMOV  V7.D[1], X17
    FMOV  D8, X25
    FMOV  V8.D[1], X4
    FMOV  D9, X17
    FMOV  V9.D[1], X27
    FMOV  D10, X11
    FMOV  V10.D[1], X19
    FMOV  D11, X21
    FMOV  V11.D[1], X2
    FMOV  D12, X20
    FMOV  V12.D[1], X6
    FMOV  D13, X16
    FMOV  V13.D[1], X5
    FMOV  D14, X6
    FMOV  V14.D[1], X26
    FMOV  D15, X3
    FMOV  V15.D[1], X26
    FMOV  D16, X29
    FMOV  V16.D[1], X19
    FMOV  D17, X29
    FMOV  V17.D[1], X3
    FMOV  D18, X25
    FMOV  V18.D[1], X16
    FMOV  D19, X2
    FMOV  V19.D[1], X29
    FMOV  D20, X25
    FMOV  V20.D[1], X3
    FMOV  D21, X29
    FMOV  V21.D[1], X14
    FMOV  D22, X25
    FMOV  V22.D[1], X13
    FMOV  D23, X20
    FMOV  V23.D[1], X28
    FMOV  D24, X3
    FMOV  V24.D[1], X26
    FMOV  D25, X20
    FMOV  V25.D[1], X7
    FMOV  D26, X29
    FMOV  V26.D[1], X28
    FMOV  D27, X2
    FMOV  V27.D[1], X16
    FMOV  D28, X2
    FMOV  V28.D[1], X18
    FMOV  D29, X20
    FMOV  V29.D[1], X2
    FMOV  D30, X29
    FMOV  V30.D[1], X7
    FMOV  D31, X2
    FMOV  V31.D[1], X16
    MOVZ  X11, #0xa, LSL #0
TSRTFloatMovMadd_label_9:
    FMOV  S1, #-4.50000000
    FCSEL  H4, H1, H1, GT
    FMOV  H7, #-0.59375000
    FNEG  D5, D4
    FADD  D3, D26, D28
    FSUB  D22, D16, D29
    FNMUL  S19, S3, S25
    FSUB  D6, D7, D31
    FADD  D5, D5, D27
    FNMADD  S15, S2, S13, S13
    FDIV  S21, S22, S22
    FSQRT  H2, H6
    FSQRT  H28, H15
    FMADD  D22, D30, D21, D26
    FSUB  D26, D5, D5
    FMUL  D22, D2, D19
    FMOV  X7, H20
    FNMUL  H24, H28, H29
    FMOV  H20, W24
    FMOV  S29, S17
    FNMADD  S2, S9, S22, S18
    FSQRT  D4, D24
    FSUB  D28, D2, D19
    FCSEL  D17, D31, D28, MI
    FNMADD  H28, H17, H4, H30
    FDIV  D3, D6, D21
    FNEG  S6, S26
    FCSEL  S5, S9, S24, GT
    FSUB  H18, H5, H0
    FNMADD  H20, H14, H18, H6
    FADD  H15, H3, H29
    FMOV  X19, H4
    FABS  H3, H28
    FNMADD  D25, D3, D0, D27
    FMSUB  D26, D29, D20, D13
    FDIV  S9, S10, S25
    FMOV  W2, S9
    FMADD  D31, D26, D15, D15
    FMOV  D29, D27
    FSQRT  H21, H16
    FMUL  D10, D20, D21
    FSQRT  S27, S3
    FSQRT  S15, S29
    FMADD  D15, D25, D20, D0
    FSUB  D24, D26, D25
    FMOV  S25, W25
    FMOV  H14, #-4.00000000
    FSQRT  D6, D4
    FMOV  D31, D9
    FMOV  H26, H6
    FDIV  D31, D0, D12
    FNEG  S26, S24
    FMUL  H22, H10, H16
    FSQRT  D15, D20
    FABS  H0, H14
    FSQRT  S1, S31
    FNEG  D30, D22
    FNMSUB  D6, D0, D15, D5
    FNMUL  S4, S3, S27
    FNEG  S29, S25
    FNMADD  S9, S29, S30, S21
    FNEG  D31, D4
    FMSUB  D13, D1, D26, D9
    FNMUL  H30, H9, H21
    FNMUL  D13, D13, D22
    FMUL  S5, S13, S4
    FDIV  H14, H0, H30
    FNMADD  H1, H14, H19, H14
    FCSEL  D21, D3, D15, MI
    FNEG  H9, H0
    FNMUL  S10, S21, S21
    FMOV  S26, #-0.42187500
    FNMSUB  D25, D9, D25, D1
    FNEG  D21, D25
    FMUL  S1, S12, S29
    FMADD  H13, H26, H6, H6
    FMOV  H29, W16
    FMOV  D22, D10
    FNEG  H3, H8
    FMOV  H6, #4.00000000
    FDIV  S12, S27, S22
    FMOV  D27, #-7.75000000
    FMOV  H0, W25
    FSQRT  H8, H0
    FMOV  X21, D8
    FNEG  H8, H1
    FMADD  H20, H25, H13, H29
    FNMSUB  D24, D29, D21, D16
    FMOV  H15, #4.25000000
    FMOV  H29, X17
    FADD  D21, D27, D20
    FMOV  X16, H8
    FMOV  H13, #0.23437500
    FSUB  D27, D21, D21
    FNMUL  H0, H3, H27
    FSUB  S17, S13, S5
    FNMADD  H5, H24, H20, H22
    FNMADD  H17, H6, H12, H17
    FABS  S25, S20
    FNMUL  S6, S17, S0
    FADD  H0, H18, H24
    FNMSUB  H27, H10, H27, H25
    FSUB  H3, H2, H15
    FNMUL  S16, S27, S5
    FMOV  H22, W2
    FSQRT  S1, S16
    FSQRT  S12, S24
    FNMADD  S16, S29, S16, S0
    FSQRT  S5, S16
    FMOV  H0, #0.28125000
    FMUL  S29, S6, S22
    FNMSUB  H18, H1, H29, H1
    FNMSUB  S21, S0, S26, S5
    FMSUB  D8, D21, D21, D12
    FMOV  X24, D5
    FABS  S21, S1
    FMOV  D13, D23
    FMOV  S22, S8
    FSUB  D12, D27, D3
    FMOV  S1, S13
    FSQRT  S17, S21
    FNMSUB  S21, S12, S2, S12
    FABS  S13, S18
    FNMADD  S6, S18, S22, S21
    FMSUB  S9, S5, S18, S17
    FMOV  X22, H13
    FCSEL  D15, D0, D30, CC
    FCSEL  S16, S27, S1, GT
    FDIV  D27, D27, D15
    FSQRT  S21, S8
    FMUL  D19, D16, D15
    FADD  S25, S27, S24
    FMUL  D1, D25, D8
    FMOV  W2, S1
    FABS  H10, H26
    FADD  H4, H24, H29
    FMOV  W3, S9
    FMADD  S25, S4, S19, S10
    FABS  H16, H1
    FNMADD  H8, H14, H16, H6
    FNMSUB  S26, S17, S29, S21
    FNMUL  H9, H21, H8
    FMOV  X6, D30
    FSUB  D1, D9, D7
    FMOV  X29, H13
    FSQRT  S8, S25
    FSQRT  S25, S3
    FMOV  H17, H26
    FNMSUB  S10, S8, S31, S25
    FNMUL  S0, S10, S17
    FMSUB  H16, H13, H4, H23
    FMSUB  S7, S22, S27, S6
    FABS  S6, S21
    FMOV  D1, X26
    FMOV  S17, #0.81250000
    FCSEL  H19, H8, H17, VC
    FNMADD  H31, H31, H7, H28
    FMADD  D3, D12, D29, D28
    FNMSUB  D14, D18, D8, D8
    FMOV  X2, H15
    FMUL  D8, D24, D13
    FMOV  X23, D1
    FMOV  S28, W24
    FCSEL  D25, D28, D16, HI
    FCSEL  H27, H6, H6, AL
    FMADD  H6, H19, H8, H29
    FMOV  S17, W26
    FNMUL  D16, D14, D27
    FMSUB  D28, D17, D19, D21
    FMOV  S8, S31
    FMOV  D22, D8
    FNEG  S10, S3
    FADD  H30, H28, H16
    FNMADD  D29, D6, D22, D3
    FMOV  H1, X22
    FSUB  S12, S10, S30
    FMOV  X28, D11
    FMOV  W16, H19
    FMOV  X23, D4
    FADD  D11, D12, D29
    FMSUB  S2, S25, S25, S25
    FNMUL  H12, H11, H29
    FNMSUB  D19, D13, D12, D12
    FNMSUB  H29, H15, H19, H12
    FMUL  S13, S2, S15
    FCSEL  D19, D23, D22, CC
    FCSEL  H28, H28, H29, LE
    FDIV  S0, S19, S19
    FMUL  D31, D1, D8
    FMSUB  H14, H13, H0, H3
    FSQRT  S7, S31
    FSQRT  H0, H20
    FMUL  D4, D20, D14
    FMOV  H14, #-12.50000000
    FNEG  H17, H15
    FADD  S29, S0, S17
    FSUB  D29, D7, D4
    FMADD  H8, H15, H5, H22
    FMSUB  D0, D8, D29, D12
    FMUL  H21, H19, H14
    SUBS  X11, X11, #0x1
    B.NE  TSRTFloatMovMadd_label_9
    MOVZ  X20, #0x8000, LSL #0
    SUB  X4, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X4, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X4, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x7e00, LSL #0
    SUB  X4, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X4, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X4, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X4, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X4, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x3bcc, LSL #0
    SUB  X4, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x7e00, LSL #0
    SUB  X4, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X4, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7fc0, LSL #16
    SUB  X4, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X4, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X4, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X4, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x4f3, LSL #0
    MOVK  X20, #0x8000, LSL #16
    SUB  X4, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X4, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MRS  X20, FPSR
    MOVZ  X4, #0x1f, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D1
    MOVZ  X4, #0x8000, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D2
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D3
    MOVZ  X4, #0x84f2, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D5
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D8
    MOVZ  X4, #0x4f3, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D9
    MOVZ  X4, #0xfe00, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D10
    MOVZ  X4, #0x84f2, LSL #0
    MOVK  X4, #0x8000, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D11
    MOVZ  X4, #0x4f3, LSL #0
    MOVK  X4, #0x8000, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D13
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D14
    MOVZ  X4, #0xca40, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D15
    MOVZ  X4, #0x8000, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D18
    MOVZ  X4, #0x8000, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D19
    MOVZ  X4, #0x4f3, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D20
    MOVZ  X4, #0x7e00, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D21
    MOVZ  X4, #0x93bc, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D22
    MOVZ  X4, #0x4f3, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D23
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D24
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D25
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D26
    MOVZ  X4, #0x4f3, LSL #0
    MOVK  X4, #0x9a35, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D27
    MOVZ  X4, #0x4f3, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D28
    MOVZ  X4, #0x8000, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D29
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D30
    MOVZ  X4, #0x4f3, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    FMOV  X20, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x499b, LSL #0
    MOVK  X2, #0x51d5, LSL #16
    MOVK  X2, #0xab3a, LSL #32
    MOVK  X2, #0x620c, LSL #48
    MOVZ  X3, #0x3c62, LSL #0
    MOVK  X3, #0xbd3a, LSL #16
    MOVK  X3, #0xf29e, LSL #32
    MOVK  X3, #0xd14a, LSL #48
    MOVZ  X4, #0x50ba, LSL #0
    MOVK  X4, #0xb6ca, LSL #16
    MOVK  X4, #0x3daa, LSL #32
    MOVK  X4, #0xb1b, LSL #48
    MOVZ  X5, #0xe201, LSL #0
    MOVK  X5, #0x97af, LSL #16
    MOVK  X5, #0x6709, LSL #32
    MOVK  X5, #0xc47a, LSL #48
    MOVZ  X6, #0x9245, LSL #0
    MOVK  X6, #0x7833, LSL #16
    MOVK  X6, #0xcc92, LSL #32
    MOVK  X6, #0x6708, LSL #48
    MOVZ  X7, #0xaf14, LSL #0
    MOVK  X7, #0x2d53, LSL #16
    MOVK  X7, #0x429c, LSL #32
    MOVK  X7, #0x3e0c, LSL #48
    MOVZ  X11, #0xc03, LSL #0
    MOVK  X11, #0x228f, LSL #16
    MOVK  X11, #0x8e7c, LSL #32
    MOVK  X11, #0x8654, LSL #48
    MOVZ  X13, #0xe07c, LSL #0
    MOVK  X13, #0xd888, LSL #16
    MOVK  X13, #0xbe70, LSL #32
    MOVK  X13, #0xcea, LSL #48
    MOVZ  X14, #0xa6e7, LSL #0
    MOVK  X14, #0x7aa0, LSL #16
    MOVK  X14, #0xfd96, LSL #32
    MOVK  X14, #0xf7f0, LSL #48
    MOVZ  X16, #0xcfd4, LSL #0
    MOVK  X16, #0x362, LSL #16
    MOVK  X16, #0xc5af, LSL #32
    MOVK  X16, #0xa9a7, LSL #48
    MOVZ  X17, #0x4810, LSL #0
    MOVK  X17, #0xf044, LSL #16
    MOVK  X17, #0xb87c, LSL #32
    MOVK  X17, #0xdda4, LSL #48
    MOVZ  X18, #0xefd4, LSL #0
    MOVK  X18, #0xf753, LSL #16
    MOVK  X18, #0xaea9, LSL #32
    MOVK  X18, #0x6f19, LSL #48
    MOVZ  X19, #0x7bfa, LSL #0
    MOVK  X19, #0xe928, LSL #16
    MOVK  X19, #0xbdca, LSL #32
    MOVK  X19, #0xfc4e, LSL #48
    MOVZ  X20, #0x16e9, LSL #0
    MOVK  X20, #0xfac1, LSL #16
    MOVK  X20, #0x32fe, LSL #32
    MOVK  X20, #0x23e4, LSL #48
    MOVZ  X21, #0xa19c, LSL #0
    MOVK  X21, #0x787f, LSL #16
    MOVK  X21, #0xa94e, LSL #32
    MOVK  X21, #0xe8d2, LSL #48
    MOVZ  X22, #0x947a, LSL #0
    MOVK  X22, #0x7a3d, LSL #16
    MOVK  X22, #0xd926, LSL #32
    MOVK  X22, #0x6285, LSL #48
    MOVZ  X23, #0xfc55, LSL #0
    MOVK  X23, #0xb61b, LSL #16
    MOVK  X23, #0x9478, LSL #32
    MOVK  X23, #0x2cf, LSL #48
    MOVZ  X24, #0x809b, LSL #0
    MOVK  X24, #0xf9fd, LSL #16
    MOVK  X24, #0xf090, LSL #32
    MOVK  X24, #0xa657, LSL #48
    MOVZ  X25, #0xafbe, LSL #0
    MOVK  X25, #0xaed3, LSL #16
    MOVK  X25, #0xbdfc, LSL #32
    MOVK  X25, #0x934d, LSL #48
    MOVZ  X26, #0xf226, LSL #0
    MOVK  X26, #0x52b5, LSL #16
    MOVK  X26, #0xa1c6, LSL #32
    MOVK  X26, #0x4350, LSL #48
    MOVZ  X27, #0x42bc, LSL #0
    MOVK  X27, #0xf55d, LSL #16
    MOVK  X27, #0x13fb, LSL #32
    MOVK  X27, #0x7631, LSL #48
    MOVZ  X28, #0x6b03, LSL #0
    MOVK  X28, #0x1856, LSL #16
    MOVK  X28, #0x1db2, LSL #32
    MOVK  X28, #0x2e3b, LSL #48
    MOVZ  X29, #0xe55f, LSL #0
    MOVK  X29, #0xeca5, LSL #16
    MOVK  X29, #0x70b2, LSL #32
    MOVK  X29, #0x438c, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X2
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X24
    FMOV  V2.D[1], X27
    FMOV  D3, X2
    FMOV  V3.D[1], X20
    FMOV  D4, X25
    FMOV  V4.D[1], X5
    FMOV  D5, X13
    FMOV  V5.D[1], X27
    FMOV  D6, X26
    FMOV  V6.D[1], X11
    FMOV  D7, X23
    FMOV  V7.D[1], X21
    FMOV  D8, X23
    FMOV  V8.D[1], X3
    FMOV  D9, X23
    FMOV  V9.D[1], X2
    FMOV  D10, X13
    FMOV  V10.D[1], X21
    FMOV  D11, X14
    FMOV  V11.D[1], X14
    FMOV  D12, X5
    FMOV  V12.D[1], X5
    FMOV  D13, X17
    FMOV  V13.D[1], X27
    FMOV  D14, X28
    FMOV  V14.D[1], X3
    FMOV  D15, X26
    FMOV  V15.D[1], X27
    FMOV  D16, X7
    FMOV  V16.D[1], X17
    FMOV  D17, X14
    FMOV  V17.D[1], X14
    FMOV  D18, X2
    FMOV  V18.D[1], X3
    FMOV  D19, X27
    FMOV  V19.D[1], X18
    FMOV  D20, X27
    FMOV  V20.D[1], X16
    FMOV  D21, X27
    FMOV  V21.D[1], X13
    FMOV  D22, X3
    FMOV  V22.D[1], X19
    FMOV  D23, X24
    FMOV  V23.D[1], X22
    FMOV  D24, X18
    FMOV  V24.D[1], X20
    FMOV  D25, X19
    FMOV  V25.D[1], X14
    FMOV  D26, X14
    FMOV  V26.D[1], X21
    FMOV  D27, X22
    FMOV  V27.D[1], X6
    FMOV  D28, X4
    FMOV  V28.D[1], X11
    FMOV  D29, X24
    FMOV  V29.D[1], X29
    FMOV  D30, X4
    FMOV  V30.D[1], X2
    FMOV  D31, X23
    FMOV  V31.D[1], X16
    MOVZ  X14, #0xa, LSL #0
TSRTFloatMovMadd_label_10:
    FMOV  H23, #-25.00000000
    FNEG  D28, D19
    FMOV  S0, S28
    FNEG  D15, D31
    FMOV  D15, D0
    FNEG  H25, H26
    FMUL  H16, H21, H30
    FMOV  X27, H16
    FADD  D2, D0, D21
    FNMADD  H8, H2, H11, H25
    FMOV  D21, D22
    FNEG  S11, S15
    FADD  D21, D19, D8
    FMSUB  D10, D2, D2, D24
    FNMADD  S21, S11, S10, S23
    FNMADD  D2, D22, D21, D14
    FADD  S28, S2, S2
    FMOV  H23, X29
    FDIV  D8, D0, D27
    FMADD  S16, S28, S14, S23
    FMUL  H21, H8, H8
    FCSEL  S23, S21, S21, LE
    FNMSUB  H30, H16, H5, H23
    FMADD  H13, H21, H23, H3
    FMADD  H9, H5, H7, H11
    FMADD  H31, H24, H25, H15
    FCSEL  H8, H18, H20, LT
    FNMUL  D21, D19, D10
    FCSEL  H21, H6, H3, GT
    FMADD  D19, D26, D20, D14
    FNMADD  S26, S23, S15, S1
    FADD  S18, S19, S6
    FMSUB  S8, S9, S11, S17
    FMOV  S15, #-19.00000000
    FSUB  S27, S22, S2
    FNMADD  S25, S21, S1, S21
    FNMUL  S7, S27, S16
    FMSUB  H28, H30, H15, H10
    FSQRT  D22, D31
    FNMUL  D1, D7, D25
    FABS  D7, D18
    FNEG  S15, S17
    FNEG  D5, D18
    FMOV  D3, D28
    FNMADD  D11, D10, D5, D22
    FMOV  X2, D14
    FADD  D22, D10, D12
    FMOV  D30, X5
    FDIV  D13, D22, D3
    FMOV  W7, S11
    FNMSUB  S12, S8, S1, S30
    FNMUL  D2, D31, D15
    FMOV  S17, W24
    FSQRT  H0, H11
    FMSUB  H16, H2, H3, H4
    FMOV  H12, W23
    FMOV  W7, S18
    FDIV  S8, S7, S27
    FCSEL  D19, D17, D12, NE
    FMOV  W13, H16
    FMOV  S30, #1.37500000
    FMOV  H18, H19
    FNEG  D7, D0
    FDIV  D0, D19, D8
    FABS  H31, H29
    FCSEL  D11, D16, D7, VS
    FADD  H27, H17, H18
    FNMUL  H18, H27, H5
    FADD  S18, S23, S30
    FNMSUB  H5, H31, H31, H29
    FCSEL  D8, D5, D0, AL
    FMSUB  D4, D11, D18, D6
    FMOV  W18, S8
    FMOV  S17, W3
    FSUB  H25, H22, H4
    FDIV  H4, H13, H17
    FDIV  H26, H16, H8
    FMOV  W24, H21
    FNMSUB  H31, H21, H19, H15
    FMOV  D14, X18
    FMOV  X25, H18
    FSQRT  D18, D16
    FMOV  H30, #0.50000000
    FMOV  D29, #29.00000000
    FCSEL  H7, H19, H17, GT
    FMSUB  S11, S15, S7, S16
    FMOV  W11, H31
    FMOV  W7, S4
    FNMADD  S23, S18, S19, S26
    FADD  D5, D23, D30
    FMOV  H16, #-0.14843750
    FNEG  D8, D16
    FABS  H8, H5
    FNMUL  H22, H25, H8
    FDIV  D13, D14, D30
    FDIV  H23, H0, H18
    FSUB  S6, S11, S23
    FADD  H26, H6, H29
    FMOV  D11, X14
    FSUB  H29, H5, H26
    FMSUB  S25, S22, S11, S27
    FMOV  H6, W17
    FMOV  H4, W26
    FMOV  W28, H6
    FMUL  H7, H30, H16
    FMOV  H5, #-0.19531250
    FADD  D23, D25, D25
    FMOV  H30, H7
    FMUL  S6, S29, S27
    FMOV  W4, S5
    FSUB  H3, H23, H0
    FNMUL  D8, D30, D8
    FMOV  S30, #25.00000000
    FMSUB  S0, S4, S8, S20
    FMSUB  H27, H7, H3, H0
    FNMUL  S18, S6, S27
    FABS  D14, D30
    FMOV  S20, #0.62500000
    FDIV  S11, S11, S13
    FCSEL  S7, S18, S11, LE
    FMOV  S18, W4
    FMUL  S30, S19, S1
    FABS  D24, D30
    FMOV  W11, S25
    FMADD  S5, S24, S7, S24
    FADD  S27, S5, S5
    FCSEL  D8, D18, D3, LE
    FDIV  S25, S20, S15
    FDIV  H1, H25, H8
    FSQRT  D30, D1
    FCSEL  H31, H27, H30, GT
    FMUL  S7, S31, S31
    FMADD  S18, S3, S8, S8
    FMOV  D2, #-0.90625000
    FNMADD  S24, S13, S16, S11
    FSQRT  H20, H0
    FMOV  D16, D16
    FNMADD  S13, S25, S8, S25
    FMOV  W5, H20
    FSUB  D5, D14, D30
    FSQRT  H11, H26
    FSQRT  S3, S0
    FMADD  S27, S13, S16, S16
    FMOV  D8, #3.87500000
    FCSEL  H14, H11, H0, AL
    FSUB  S1, S11, S3
    FNMUL  D0, D24, D18
    FMUL  D31, D7, D6
    FMOV  H31, X25
    FABS  S25, S1
    FMUL  H26, H11, H8
    FNEG  H8, H0
    FMOV  X6, H5
    FNMUL  D20, D26, D24
    FMSUB  H28, H14, H8, H27
    FMSUB  S26, S28, S16, S15
    FMOV  H19, #-28.00000000
    FMOV  X18, H25
    FSUB  D24, D16, D29
    FMUL  S11, S2, S22
    FMOV  D17, D11
    FADD  S1, S26, S5
    FADD  D18, D23, D3
    FMOV  W24, H1
    FMOV  D23, D1
    FNMSUB  D11, D31, D28, D23
    FMOV  H25, H18
    FMADD  D26, D20, D25, D11
    FNEG  S27, S17
    FNEG  H18, H27
    FDIV  D16, D24, D26
    FDIV  H27, H19, H4
    FSQRT  H8, H18
    FMSUB  S21, S5, S16, S15
    FSUB  D19, D27, D8
    FCSEL  S29, S17, S19, LS
    FNMADD  D23, D12, D4, D27
    FNEG  S16, S12
    FNMADD  H5, H0, H17, H20
    FNMSUB  S9, S17, S29, S24
    FABS  D29, D14
    FMOV  D3, X27
    FADD  S24, S22, S12
    FSQRT  D25, D13
    FNEG  H2, H11
    FMOV  H28, W4
    FNMSUB  S7, S23, S28, S25
    FMOV  S20, #1.93750000
    FCSEL  H18, H13, H20, CS
    FMOV  H12, X4
    FMUL  S20, S16, S12
    FNEG  H5, H9
    FNMADD  D7, D24, D18, D20
    FMOV  S8, #-1.37500000
    FNMSUB  D23, D6, D2, D8
    FNMSUB  S18, S23, S7, S5
    FNMUL  D8, D18, D3
    FNMADD  H12, H13, H8, H19
    FMOV  H31, H15
    FMADD  S17, S12, S21, S20
    SUBS  X14, X14, #0x1
    B.NE  TSRTFloatMovMadd_label_10
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X16, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x3c62, LSL #0
    MOVK  X22, #0xbd3a, LSL #16
    MOVK  X22, #0xf29e, LSL #32
    MOVK  X22, #0xd14a, LSL #48
    SUB  X16, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0xb240, LSL #0
    SUB  X16, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x2f76, LSL #0
    SUB  X16, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x852e, LSL #0
    SUB  X16, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x3375, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0xf226, LSL #0
    SUB  X16, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x4810, LSL #0
    MOVK  X22, #0xf044, LSL #16
    MOVK  X22, #0xb87c, LSL #32
    MOVK  X22, #0xdda4, LSL #48
    SUB  X16, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x7bfa, LSL #0
    MOVK  X22, #0xe928, LSL #16
    MOVK  X22, #0xbdca, LSL #32
    MOVK  X22, #0xfc4e, LSL #48
    SUB  X16, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x16e9, LSL #0
    MOVK  X22, #0xfac1, LSL #16
    MOVK  X22, #0x32fe, LSL #32
    MOVK  X22, #0x23e4, LSL #48
    SUB  X16, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0xfc55, LSL #0
    MOVK  X22, #0xb61b, LSL #16
    MOVK  X22, #0x9478, LSL #32
    MOVK  X22, #0x2cf, LSL #48
    SUB  X16, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x2f76, LSL #0
    SUB  X16, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0xf226, LSL #0
    MOVK  X22, #0x52b5, LSL #16
    MOVK  X22, #0xa1c6, LSL #32
    MOVK  X22, #0x4350, LSL #48
    SUB  X16, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x8000, LSL #0
    SUB  X16, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0x4810, LSL #0
    SUB  X16, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X22, #0xe55f, LSL #0
    MOVK  X22, #0xeca5, LSL #16
    MOVK  X22, #0x70b2, LSL #32
    MOVK  X22, #0x438c, LSL #48
    SUB  X16, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MRS  X22, FPSR
    MOVZ  X16, #0x1f, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D0
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D1
    MOVZ  X16, #0x2f76, LSL #0
    MOVK  X16, #0x8d0e, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D2
    MOVZ  X16, #0xaf76, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D3
    MOVZ  X16, #0x8000, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D4
    MOVZ  X16, #0xf226, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D5
    MOVZ  X16, #0x84f6, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D7
    MOVZ  X16, #0x1, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D8
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D9
    MOVZ  X16, #0x4f6, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D10
    MOVZ  X16, #0x2ef9, LSL #0
    MOVK  X16, #0x1, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D11
    MOVZ  X16, #0x2f76, LSL #0
    MOVK  X16, #0x8d0e, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D12
    MOVZ  X16, #0xe773, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D13
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xff80, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D14
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D15
    MOVZ  X16, #0x1, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D16
    MOVZ  X16, #0xfc55, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D17
    MOVZ  X16, #0x2, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D18
    MOVZ  X16, #0x84f5, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D19
    MOVZ  X16, #0x6773, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D20
    MOVZ  X16, #0x1, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D21
    MOVZ  X16, #0xe1d4, LSL #0
    MOVK  X16, #0x9e29, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D22
    MOVZ  X16, #0x90d1, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D23
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xbfb0, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D24
    MOVZ  X16, #0x8d26, LSL #0
    MOVK  X16, #0x1, LSL #16
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D25
    MOVZ  X16, #0xebf8, LSL #0
    MOVK  X16, #0xffbf, LSL #16
    MOVK  X16, #0xf7fe, LSL #32
    MOVK  X16, #0x1f5f, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D26
    MOVZ  X16, #0x2f76, LSL #0
    MOVK  X16, #0x8d0e, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D27
    MOVZ  X16, #0x188d, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D28
    MOVZ  X16, #0xb240, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D29
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D30
    MOVZ  X16, #0x2f76, LSL #0
    MOVK  X16, #0x8d0e, LSL #16
    MOVK  X16, #0x732f, LSL #32
    MOVK  X16, #0x1ed6, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X22, D31
    MOVZ  X16, #0x1, LSL #0
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    FMOV  V0.D[1], X27
    FMOV  D1, X18
    FMOV  V1.D[1], X19
    FMOV  D2, X7
    FMOV  V2.D[1], X28
    FMOV  D3, X5
    FMOV  V3.D[1], X24
    FMOV  D4, X23
    FMOV  V4.D[1], X17
    FMOV  D5, X26
    FMOV  V5.D[1], X2
    FMOV  D6, X22
    FMOV  V6.D[1], X25
    FMOV  D7, X24
    FMOV  V7.D[1], X29
    FMOV  D8, X17
    FMOV  V8.D[1], X14
    FMOV  D9, X11
    FMOV  V9.D[1], X20
    FMOV  D10, X4
    FMOV  V10.D[1], X4
    FMOV  D11, X14
    FMOV  V11.D[1], X21
    FMOV  D12, X26
    FMOV  V12.D[1], X17
    FMOV  D13, X11
    FMOV  V13.D[1], X2
    FMOV  D14, X6
    FMOV  V14.D[1], X26
    FMOV  D15, X18
    FMOV  V15.D[1], X5
    FMOV  D16, X4
    FMOV  V16.D[1], X6
    FMOV  D17, X23
    FMOV  V17.D[1], X2
    FMOV  D18, X5
    FMOV  V18.D[1], X26
    FMOV  D19, X29
    FMOV  V19.D[1], X14
    FMOV  D20, X6
    FMOV  V20.D[1], X6
    FMOV  D21, X24
    FMOV  V21.D[1], X4
    FMOV  D22, X23
    FMOV  V22.D[1], X24
    FMOV  D23, X20
    FMOV  V23.D[1], X16
    FMOV  D24, X21
    FMOV  V24.D[1], X23
    FMOV  D25, X6
    FMOV  V25.D[1], X4
    FMOV  D26, X24
    FMOV  V26.D[1], X29
    FMOV  D27, X5
    FMOV  V27.D[1], X23
    FMOV  D28, X28
    FMOV  V28.D[1], X23
    FMOV  D29, X27
    FMOV  V29.D[1], X3
    FMOV  D30, X29
    FMOV  V30.D[1], X6
    FMOV  D31, X17
    FMOV  V31.D[1], X19
    MOVZ  X20, #0xa, LSL #0
TSRTFloatMovMadd_label_11:
    FDIV  S23, S23, S30
    FMOV  S26, W3
    FSQRT  D25, D16
    FDIV  S22, S23, S28
    FMUL  D12, D31, D27
    FMOV  D26, #0.96875000
    FADD  D17, D6, D22
    FMOV  H30, X6
    FNMSUB  D30, D29, D12, D25
    FSUB  S3, S9, S30
    FMOV  H18, X6
    FMOV  S16, S18
    FSQRT  S25, S26
    FNMSUB  S31, S17, S25, S27
    FABS  D23, D3
    FMOV  X17, D23
    FNEG  D2, D16
    FSUB  D4, D9, D3
    FDIV  S27, S2, S7
    FMUL  S25, S3, S6
    FMUL  D21, D28, D3
    FMOV  S7, S19
    FNMADD  D16, D15, D2, D25
    FSQRT  H26, H26
    FMOV  S25, #-12.50000000
    FMOV  H19, #-5.50000000
    FMOV  S19, S4
    FMOV  D12, #-28.00000000
    FDIV  S18, S21, S3
    FMUL  H13, H26, H22
    FADD  D17, D30, D23
    FMADD  H30, H13, H27, H19
    FMOV  H9, W22
    FMOV  D6, D7
    FMOV  H27, #-8.50000000
    FMSUB  S15, S17, S1, S9
    FNMADD  D8, D25, D20, D27
    FMOV  D22, D18
    FADD  H1, H16, H6
    FADD  D27, D2, D19
    FNMSUB  S16, S2, S15, S12
    FNMUL  D12, D8, D2
    FCSEL  H13, H8, H12, GE
    FADD  H25, H13, H21
    FMOV  H21, X16
    FMOV  S21, S30
    FNMADD  D28, D15, D0, D22
    FABS  H13, H25
    FMSUB  D8, D27, D8, D25
    FNEG  D12, D8
    FNMUL  D7, D21, D27
    FNMSUB  H21, H19, H12, H1
    FABS  H19, H7
    FMADD  S7, S5, S16, S26
    FMUL  H17, H10, H26
    FNEG  S10, S7
    FSQRT  D16, D6
    FMOV  X6, H10
    FDIV  S22, S17, S0
    FABS  S7, S19
    FMOV  D27, D13
    FNEG  D26, D27
    FMUL  H27, H28, H26
    FSUB  D28, D22, D22
    FMOV  W27, S4
    FMOV  S26, W16
    FADD  H10, H6, H20
    FNMADD  S0, S10, S16, S9
    FMOV  D17, #1.81250000
    FMUL  S5, S30, S17
    FSUB  S14, S21, S27
    FMADD  S12, S28, S27, S7
    FDIV  D28, D26, D14
    FMOV  S10, W2
    FADD  D22, D21, D5
    FNMUL  D17, D22, D31
    FNEG  S7, S17
    FSQRT  S5, S30
    FMOV  H21, H20
    FMOV  W7, S0
    FSQRT  H19, H21
    FNMUL  S13, S12, S7
    FNMADD  D0, D4, D3, D2
    FNEG  D7, D0
    FMOV  H9, #3.00000000
    FDIV  S16, S13, S9
    FMSUB  D28, D19, D5, D17
    FMOV  D27, #0.93750000
    FMSUB  D12, D16, D16, D2
    FMOV  H4, H12
    FNMADD  S19, S7, S28, S28
    FABS  H13, H10
    FMOV  H7, X14
    FMOV  H28, W28
    FMOV  S2, #0.15625000
    FMOV  D4, X17
    FMUL  H20, H12, H14
    FSQRT  S9, S5
    FMOV  X27, D20
    FMOV  H0, X27
    FDIV  S5, S28, S0
    FMUL  D17, D2, D27
    FMOV  X26, H9
    FSQRT  H16, H5
    FCSEL  H3, H13, H4, CS
    FNMADD  S13, S26, S26, S3
    FSUB  D28, D7, D19
    FMUL  S9, S17, S16
    FMOV  S17, #-0.20312500
    FMOV  S3, S24
    FMOV  X24, D13
    FSQRT  H0, H6
    FSUB  D6, D14, D17
    FMSUB  S13, S12, S6, S9
    FABS  S12, S0
    FMOV  H2, X14
    FNMADD  H24, H28, H2, H28
    FDIV  D20, D24, D18
    FNMADD  D18, D12, D20, D23
    FADD  S17, S26, S18
    FSUB  H6, H17, H17
    FNEG  D7, D9
    FADD  D17, D24, D2
    FMOV  H0, H7
    FCSEL  D12, D13, D13, NV
    FSQRT  S14, S17
    FMADD  H7, H6, H31, H6
    FMSUB  S20, S4, S16, S3
    FNEG  D6, D28
    FMOV  W18, H12
    FMOV  X22, H6
    FMOV  W11, S28
    FMOV  H29, W24
    FDIV  D28, D22, D7
    FSQRT  S7, S28
    FABS  H8, H24
    FMUL  S19, S29, S11
    FDIV  S11, S8, S8
    FMSUB  H31, H19, H14, H24
    FMOV  H2, W3
    FNMSUB  D4, D31, D20, D7
    FCSEL  S29, S2, S0, GE
    FSQRT  H24, H11
    FMUL  S8, S1, S4
    FDIV  D1, D4, D29
    FSQRT  S19, S21
    FMADD  S14, S5, S10, S17
    FADD  S5, S1, S1
    FMOV  W24, H2
    FNMSUB  S2, S24, S9, S1
    FNEG  D6, D14
    FMSUB  D21, D0, D29, D7
    FMOV  S17, #0.45312500
    FADD  H23, H12, H6
    FNMUL  H4, H23, H4
    FNMSUB  H0, H4, H16, H2
    FMSUB  H30, H0, H3, H17
    FCSEL  S23, S31, S20, GT
    FABS  H0, H17
    FNMUL  S7, S30, S0
    FSQRT  D3, D25
    FADD  D22, D8, D23
    FDIV  S11, S19, S18
    FNMUL  S10, S8, S21
    FMUL  S18, S0, S5
    FNMADD  D9, D10, D26, D3
    FSQRT  S16, S22
    FSUB  D24, D3, D18
    FMADD  S22, S11, S11, S16
    FMOV  D10, X2
    FADD  S8, S9, S22
    FSQRT  D22, D10
    FNMUL  H4, H24, H7
    FMOV  S26, #30.00000000
    FMOV  W11, H4
    FNMSUB  H4, H22, H8, H22
    FADD  H21, H16, H31
    FSUB  S19, S31, S6
    FMOV  H29, X19
    FADD  H9, H24, H14
    FMADD  D17, D19, D3, D4
    FDIV  S19, S15, S27
    FMOV  H30, X28
    FNMADD  H22, H10, H21, H10
    FNMSUB  H16, H25, H3, H26
    FSUB  H23, H7, H7
    FMUL  D4, D9, D31
    FNEG  H10, H24
    FSUB  H8, H29, H10
    FMADD  H7, H8, H19, H4
    FMOV  H24, H23
    FSUB  D18, D7, D7
    FNMUL  S29, S22, S22
    FSUB  S10, S16, S11
    FADD  D9, D30, D5
    FDIV  D7, D20, D1
    FMSUB  H22, H2, H18, H24
    FCSEL  D15, D18, D29, NV
    FNEG  D8, D7
    FDIV  S19, S8, S24
    SUBS  X20, X20, #0x1
    B.NE  TSRTFloatMovMadd_label_11
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x1, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X13, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x8000, LSL #0
    SUB  X13, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x97e3, LSL #0
    MOVK  X23, #0xda9d, LSL #16
    SUB  X13, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x1, LSL #0
    SUB  X13, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0xee3e, LSL #0
    SUB  X13, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X13, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMovMadd_TestFail
    MRS  X23, FPSR
    MOVZ  X13, #0x1f, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D1
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D2
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D3
    MOVZ  X13, #0x3c15, LSL #0
    MOVK  X13, #0x6767, LSL #16
    MOVK  X13, #0x7cd7, LSL #32
    MOVK  X13, #0x1edc, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D6
    MOVZ  X13, #0x8000, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D7
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D8
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xfff8, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D10
    MOVZ  X13, #0xfa28, LSL #0
    MOVK  X13, #0x2cf, LSL #16
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D11
    MOVZ  X13, #0xed78, LSL #0
    MOVK  X13, #0x82cf, LSL #16
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D12
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D13
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D14
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D15
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D16
    MOVZ  X13, #0xcb08, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D17
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D18
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D20
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D21
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D22
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D23
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D24
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D25
    MOVZ  X13, #0xcae3, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D26
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x41f0, LSL #16
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D27
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3fee, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D28
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa400, LSL #32
    MOVK  X13, #0x3fd3, LSL #48
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D29
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    FMOV  X23, D31
    MOVZ  X13, #0x8000, LSL #0
    SUB  X21, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X13
    FMOV  V2.D[1], X28
    FMOV  D3, X22
    FMOV  V3.D[1], X6
    FMOV  D4, X24
    FMOV  V4.D[1], X14
    FMOV  D5, X11
    FMOV  V5.D[1], X29
    FMOV  D6, X27
    FMOV  V6.D[1], X11
    FMOV  D7, X20
    FMOV  V7.D[1], X28
    FMOV  D8, X14
    FMOV  V8.D[1], X26
    FMOV  D9, X25
    FMOV  V9.D[1], X23
    FMOV  D10, X26
    FMOV  V10.D[1], X16
    FMOV  D11, X14
    FMOV  V11.D[1], X14
    FMOV  D12, X3
    FMOV  V12.D[1], X18
    FMOV  D13, X4
    FMOV  V13.D[1], X28
    FMOV  D14, X16
    FMOV  V14.D[1], X4
    FMOV  D15, X23
    FMOV  V15.D[1], X14
    FMOV  D16, X25
    FMOV  V16.D[1], X20
    FMOV  D17, X7
    FMOV  V17.D[1], X6
    FMOV  D18, X29
    FMOV  V18.D[1], X28
    FMOV  D19, X7
    FMOV  V19.D[1], X11
    FMOV  D20, X6
    FMOV  V20.D[1], X2
    FMOV  D21, X20
    FMOV  V21.D[1], X18
    FMOV  D22, X7
    FMOV  V22.D[1], X19
    FMOV  D23, X26
    FMOV  V23.D[1], X4
    FMOV  D24, X18
    FMOV  V24.D[1], X29
    FMOV  D25, X2
    FMOV  V25.D[1], X21
    FMOV  D26, X26
    FMOV  V26.D[1], X14
    FMOV  D27, X5
    FMOV  V27.D[1], X11
    FMOV  D28, X20
    FMOV  V28.D[1], X5
    FMOV  D29, X23
    FMOV  V29.D[1], X26
    FMOV  D30, X13
    FMOV  V30.D[1], X23
    FMOV  D31, X26
    FMOV  V31.D[1], X16
    MOVZ  X27, #0xa, LSL #0
TSRTFloatMovMadd_label_12:
    FMSUB  D12, D29, D25, D6
    FMOV  D27, D28
    FNEG  D24, D12
    FMOV  S18, #-0.21875000
    FMSUB  S1, S31, S27, S31
    FNMSUB  S19, S31, S26, S15
    FMUL  S24, S24, S30
    FNMUL  H16, H18, H16
    FSUB  H9, H16, H16
    FNMADD  S22, S1, S8, S19
    FMOV  W13, S8
    FNMSUB  D16, D24, D9, D23
    FMOV  D25, #0.31250000
    FMOV  S28, S9
    FNEG  S23, S17
    FADD  D13, D31, D28
    FSQRT  D8, D8
    FMSUB  S8, S4, S27, S23
    FMUL  S20, S5, S6
    FDIV  S27, S26, S27
    FMOV  W29, S14
    FMOV  D29, X27
    FMOV  H1, #3.00000000
    FMOV  H19, W5
    FNEG  D15, D16
    FABS  S9, S22
    FMADD  H13, H29, H19, H23
    FMOV  D31, #-0.15625000
    FNEG  H28, H27
    FMADD  S26, S31, S30, S20
    FMOV  D14, #0.81250000
    FMUL  H5, H26, H15
    FMOV  X29, D14
    FNEG  H4, H13
    FMUL  D29, D3, D6
    FMOV  W19, S9
    FSUB  H13, H29, H29
    FADD  D26, D28, D28
    FMOV  H15, X28
    FNMUL  D19, D25, D5
    FMOV  X3, D12
    FMUL  S16, S20, S9
    FSUB  D5, D23, D2
    FMSUB  H25, H24, H17, H19
    FNMSUB  S29, S23, S13, S25
    FMADD  H17, H15, H5, H15
    FSQRT  H6, H16
    FCSEL  S19, S8, S17, LS
    FNEG  S14, S26
    FNEG  S15, S17
    FDIV  D24, D15, D29
    FNEG  S26, S29
    FMOV  D16, #7.50000000
    FDIV  H3, H24, H6
    FMOV  D5, D31
    FDIV  H12, H19, H15
    FNMADD  D6, D9, D14, D19
    FNEG  S29, S12
    FDIV  S28, S9, S29
    FSQRT  S31, S6
    FCSEL  H24, H20, H28, VC
    FSQRT  S27, S26
    FMADD  H15, H29, H5, H31
    FMOV  H20, W7
    FMOV  S2, #-3.87500000
    FMOV  H21, X19
    FDIV  D3, D31, D17
    FNMSUB  S29, S20, S2, S27
    FDIV  S12, S7, S3
    FMOV  D3, #0.26562500
    FMOV  W14, H25
    FMADD  H14, H29, H29, H7
    FMOV  D23, X14
    FNMSUB  S22, S14, S3, S21
    FABS  H28, H16
    FMSUB  H14, H20, H20, H13
    FMOV  D2, D31
    FMUL  D31, D12, D19
    FADD  H3, H28, H28
    FNMSUB  H10, H15, H24, H14
    FMSUB  D24, D31, D22, D26
    FMADD  S5, S2, S3, S8
    FMOV  D26, D1
    FADD  H19, H31, H19
    FMOV  H25, W29
    FMADD  H12, H5, H2, H24
    FNMSUB  S29, S31, S25, S25
    FNMADD  S12, S10, S26, S29
    FMOV  W20, H26
    FMOV  H3, X2
    FCSEL  H13, H27, H11, EQ
    FMUL  H31, H12, H23
    FABS  D15, D3
    FSUB  S2, S19, S13
    FMADD  D26, D2, D15, D15
    FMOV  D15, X14
    FCSEL  D29, D25, D15, CS
    FABS  S3, S7
    FSQRT  S11, S30
    FMOV  H27, X2
    FSQRT  H12, H16
    FADD  S29, S19, S14
    FMOV  S27, W23
    FADD  S12, S6, S29
    FNEG  D23, D9
    FMOV  H23, H7
    FNMSUB  D9, D5, D21, D22
    FMOV  D14, X2
    FNEG  S2, S26
    FSQRT  S29, S11
    FMSUB  D17, D14, D14, D5
    FMOV  X3, D6
    FMOV  D6, #-10.50000000
    FNMUL  S22, S9, S29
    FNMSUB  D9, D12, D27, D23
    FNMADD  D20, D2, D3, D27
    FABS  H25, H5
    FNMSUB  H21, H1, H17, H6
    FNMADD  S27, S9, S22, S22
    FSUB  H1, H21, H25
    FNMSUB  S2, S1, S31, S27
    FMOV  X13, H23
    FADD  S27, S12, S24
    FNMUL  H3, H14, H1
    FMSUB  S26, S5, S9, S6
    FMUL  D14, D9, D30
    FNEG  H5, H21
    FABS  H13, H15
    FMOV  D19, X13
    FMADD  H9, H13, H16, H21
    FMOV  D22, D14
    FMADD  H24, H16, H9, H2
    FADD  H2, H22, H3
    FSUB  H12, H16, H27
    FMADD  D1, D26, D12, D19
    FNMADD  H12, H25, H2, H2
    FMOV  H25, W13
    FNMUL  S11, S5, S20
    FMOV  X19, H11
    FNMSUB  S14, S3, S25, S7
    FADD  S26, S14, S4
    FNMUL  H5, H24, H24
    FSUB  H20, H14, H5
    FNMUL  H19, H12, H26
    FNEG  S2, S20
    FDIV  D16, D12, D13
    FDIV  D4, D16, D6
    FMUL  H27, H2, H19
    FMOV  W5, H30
    FDIV  D24, D1, D9
    FMUL  S4, S20, S13
    FMUL  D12, D21, D27
    FMOV  S6, #2.87500000
    FMOV  D26, D4
    FMADD  H2, H24, H17, H27
    FMUL  D3, D19, D2
    FNMADD  D14, D6, D6, D31
    FDIV  D1, D28, D22
    FMOV  D31, X29
    FMOV  W18, S31
    FDIV  S6, S26, S28
    FABS  H27, H12
    FMUL  H9, H6, H27
    FMSUB  D24, D3, D3, D9
    FNMUL  S13, S24, S24
    FMOV  X4, D20
    FMSUB  S16, S1, S21, S1
    FMSUB  H28, H23, H30, H16
    FSQRT  S31, S14
    FNMADD  D30, D28, D21, D28
    FADD  H27, H26, H28
    FNMSUB  H24, H27, H30, H28
    FNMADD  S30, S13, S10, S5
    FABS  D9, D9
    FMOV  D12, D4
    FMOV  D13, X11
    FMOV  H29, X17
    FABS  D4, D12
    FNMUL  H12, H9, H9
    FNMSUB  H16, H6, H29, H14
    FSUB  D8, D16, D13
    FNEG  H9, H19
    FSQRT  S1, S28
    FMOV  X2, D12
    FSQRT  H14, H7
    FMADD  H19, H24, H1, H14
    FADD  H4, H31, H8
    FMADD  S31, S30, S11, S29
    FMSUB  S1, S4, S24, S11
    FMOV  S14, #25.00000000
    FMOV  H16, W11
    FNMSUB  S28, S14, S16, S14
    FMOV  W17, S31
    FSUB  S8, S1, S24
    FSQRT  H12, H3
    FDIV  S11, S8, S12
    FNMSUB  H16, H9, H7, H28
    FMUL  D27, D2, D11
    FDIV  S4, S24, S14
    FCSEL  S30, S8, S17, MI
    SUBS  X27, X27, #0x1
    B.NE  TSRTFloatMovMadd_label_12
    MOVZ  X16, #0x8000, LSL #0
    SUB  X6, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e01, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X6, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X6, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    SUB  X6, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x2760, LSL #0
    SUB  X6, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    SUB  X6, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x4200, LSL #0
    SUB  X6, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3fea, LSL #48
    SUB  X6, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MRS  X16, FPSR
    MOVZ  X6, #0x1f, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D0
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D1
    MOVZ  X6, #0x1, LSL #0
    MOVK  X6, #0x8000, LSL #16
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D2
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D4
    MOVZ  X6, #0x50a, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D5
    MOVZ  X6, #0xfe00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D6
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7fc0, LSL #16
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D7
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D8
    MOVZ  X6, #0x7e01, LSL #0
    MOVK  X6, #0x8000, LSL #16
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D9
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D10
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D11
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xff80, LSL #16
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D13
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D14
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x41c8, LSL #16
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D15
    MOVZ  X6, #0x2760, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D16
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D17
    MOVZ  X6, #0x7df9, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D18
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xbe60, LSL #16
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D19
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D20
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D21
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D22
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D23
    MOVZ  X6, #0xffff, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D24
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D25
    MOVZ  X6, #0xffff, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D28
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xc1c8, LSL #16
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D29
    MOVZ  X6, #0xffff, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D30
    MOVZ  X6, #0x7df9, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    FMOV  X16, D31
    MOVZ  X6, #0xffff, LSL #0
    SUB  X24, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X3
    FMOV  D1, X29
    FMOV  V1.D[1], X18
    FMOV  D2, X14
    FMOV  V2.D[1], X26
    FMOV  D3, X17
    FMOV  V3.D[1], X5
    FMOV  D4, X26
    FMOV  V4.D[1], X27
    FMOV  D5, X25
    FMOV  V5.D[1], X16
    FMOV  D6, X4
    FMOV  V6.D[1], X11
    FMOV  D7, X22
    FMOV  V7.D[1], X25
    FMOV  D8, X17
    FMOV  V8.D[1], X29
    FMOV  D9, X13
    FMOV  V9.D[1], X25
    FMOV  D10, X13
    FMOV  V10.D[1], X27
    FMOV  D11, X29
    FMOV  V11.D[1], X7
    FMOV  D12, X25
    FMOV  V12.D[1], X25
    FMOV  D13, X19
    FMOV  V13.D[1], X6
    FMOV  D14, X26
    FMOV  V14.D[1], X2
    FMOV  D15, X17
    FMOV  V15.D[1], X19
    FMOV  D16, X11
    FMOV  V16.D[1], X3
    FMOV  D17, X11
    FMOV  V17.D[1], X26
    FMOV  D18, X20
    FMOV  V18.D[1], X7
    FMOV  D19, X7
    FMOV  V19.D[1], X21
    FMOV  D20, X23
    FMOV  V20.D[1], X6
    FMOV  D21, X24
    FMOV  V21.D[1], X18
    FMOV  D22, X27
    FMOV  V22.D[1], X13
    FMOV  D23, X7
    FMOV  V23.D[1], X20
    FMOV  D24, X7
    FMOV  V24.D[1], X11
    FMOV  D25, X19
    FMOV  V25.D[1], X25
    FMOV  D26, X20
    FMOV  V26.D[1], X19
    FMOV  D27, X20
    FMOV  V27.D[1], X13
    FMOV  D28, X14
    FMOV  V28.D[1], X20
    FMOV  D29, X2
    FMOV  V29.D[1], X26
    FMOV  D30, X4
    FMOV  V30.D[1], X26
    FMOV  D31, X27
    FMOV  V31.D[1], X16
    MOVZ  X6, #0xa, LSL #0
TSRTFloatMovMadd_label_13:
    FNMUL  H18, H24, H27
    FNMADD  H8, H28, H24, H16
    FNEG  S19, S24
    FNMADD  S24, S0, S31, S29
    FABS  D22, D30
    FMOV  D15, X29
    FMOV  S18, W22
    FCSEL  S24, S6, S21, LS
    FMOV  X29, D22
    FSQRT  S17, S8
    FSQRT  H21, H23
    FMUL  H1, H11, H17
    FNMADD  D17, D21, D15, D31
    FNMUL  S25, S0, S1
    FNMADD  S14, S15, S17, S11
    FMSUB  H22, H25, H18, H25
    FMOV  S21, W5
    FMADD  S11, S3, S3, S4
    FMOV  H3, W26
    FDIV  S22, S11, S21
    FNMSUB  D30, D22, D14, D10
    FMOV  S12, #3.12500000
    FNEG  S25, S31
    FMOV  H23, #9.00000000
    FCSEL  H20, H18, H3, CC
    FMOV  W5, H12
    FSQRT  H31, H29
    FNEG  H14, H5
    FMOV  D5, X4
    FMADD  D26, D25, D31, D0
    FMUL  S15, S12, S16
    FDIV  D31, D24, D23
    FABS  S30, S20
    FNMSUB  S8, S15, S30, S14
    FDIV  H0, H5, H31
    FSQRT  S12, S0
    FMOV  H31, X19
    FADD  H20, H19, H31
    FNEG  D0, D31
    FMOV  S17, #-3.75000000
    FSQRT  S4, S0
    FSUB  H18, H20, H12
    FMOV  D8, #-4.00000000
    FSUB  S20, S17, S26
    FMOV  H5, X14
    FMUL  D30, D14, D14
    FCSEL  S16, S10, S4, GE
    FMADD  S21, S30, S20, S20
    FMUL  H23, H8, H8
    FNEG  S10, S18
    FNMSUB  D0, D5, D5, D23
    FCSEL  S10, S23, S3, HI
    FMOV  X21, D21
    FDIV  S8, S10, S0
    FNMSUB  D18, D23, D29, D9
    FCSEL  S19, S17, S23, CC
    FNMUL  S30, S26, S30
    FMOV  H12, H31
    FMUL  D23, D27, D5
    FNMADD  S29, S5, S10, S1
    FADD  S1, S20, S19
    FMUL  D14, D1, D6
    FCSEL  S20, S7, S24, NE
    FNMADD  H7, H10, H10, H30
    FSUB  D29, D23, D18
    FCSEL  S5, S7, S15, LS
    FNEG  H14, H14
    FMOV  X29, H29
    FCSEL  H29, H8, H14, VS
    FSUB  D10, D5, D20
    FMADD  H8, H16, H10, H24
    FMOV  H1, W7
    FMOV  X28, D7
    FABS  D0, D0
    FSQRT  H31, H5
    FSQRT  H15, H24
    FMSUB  H27, H24, H16, H31
    FMADD  D14, D29, D22, D18
    FMOV  H7, H24
    FMADD  H29, H8, H14, H12
    FMOV  H3, X29
    FNEG  H8, H27
    FMOV  D9, D7
    FNEG  D23, D15
    FMADD  S24, S3, S1, S9
    FNMSUB  D15, D7, D29, D9
    FMUL  S21, S24, S8
    FMOV  H7, #-1.31250000
    FADD  H23, H21, H14
    FMOV  W2, S0
    FMUL  D10, D15, D11
    FADD  H15, H8, H4
    FMOV  S11, W28
    FMOV  D29, #-25.00000000
    FNEG  H20, H15
    FMOV  D14, #-3.25000000
    FSQRT  H5, H14
    FMOV  H14, W28
    FADD  D4, D7, D5
    FABS  D19, D12
    FDIV  S27, S14, S14
    FNMADD  H5, H13, H10, H4
    FSQRT  D1, D19
    FSUB  H9, H20, H15
    FDIV  S14, S27, S11
    FADD  S0, S9, S3
    FNMADD  D20, D3, D12, D23
    FABS  S21, S0
    FABS  S4, S14
    FCSEL  D10, D20, D21, LE
    FMADD  S0, S4, S4, S25
    FNEG  D23, D17
    FADD  D12, D23, D10
    FNMSUB  H7, H3, H17, H8
    FNMUL  D23, D12, D0
    FNMSUB  H9, H29, H1, H23
    FSUB  S24, S9, S7
    FMUL  H15, H6, H25
    FSUB  H21, H30, H1
    FNMADD  D18, D17, D17, D29
    FMSUB  H13, H12, H6, H17
    FCSEL  D12, D6, D25, NV
    FMOV  W28, S15
    FMOV  X4, D19
    FDIV  S15, S19, S4
    FNMSUB  H3, H11, H6, H21
    FNMADD  S4, S19, S6, S22
    FMOV  S14, W11
    FCSEL  D25, D9, D18, EQ
    FADD  H27, H12, H20
    FNEG  S12, S14
    FMOV  D30, #6.75000000
    FMSUB  D9, D24, D21, D4
    FNEG  D20, D13
    FNMSUB  S29, S28, S27, S3
    FMUL  D11, D1, D27
    FSUB  H27, H29, H24
    FSUB  H1, H27, H20
    FMADD  S20, S30, S12, S11
    FNMSUB  H27, H9, H9, H24
    FMOV  X7, D29
    FMADD  S9, S12, S13, S17
    FNMSUB  H29, H11, H25, H24
    FSUB  H0, H9, H6
    FMUL  D6, D20, D24
    FMSUB  S9, S27, S15, S28
    FABS  H19, H20
    FSQRT  H16, H4
    FMSUB  D14, D1, D6, D27
    FMOV  D4, X2
    FSQRT  D1, D9
    FMOV  H25, W19
    FMADD  S27, S0, S25, S13
    FMOV  S6, W28
    FMUL  D24, D16, D30
    FMSUB  H20, H7, H4, H3
    FMUL  D13, D24, D1
    FMUL  D12, D11, D14
    FMSUB  H7, H12, H12, H4
    FABS  D11, D13
    FNMSUB  S25, S5, S27, S26
    FMADD  D3, D7, D20, D20
    FSUB  D27, D0, D25
    FSQRT  S29, S3
    FMOV  D13, #1.68750000
    FSQRT  D24, D11
    FSQRT  H23, H27
    FDIV  D24, D29, D29
    FSUB  D26, D23, D13
    FMOV  D5, D23
    FNMUL  D29, D6, D6
    FNMSUB  S13, S26, S24, S8
    FMSUB  H25, H19, H13, H0
    FMOV  H7, W26
    FNEG  D27, D29
    FMOV  H23, X26
    FSUB  S11, S5, S10
    FSQRT  D8, D0
    FCSEL  D24, D27, D8, AL
    FMOV  W27, H23
    FDIV  D0, D25, D14
    FNEG  S30, S7
    FMOV  H5, X2
    FDIV  D8, D5, D17
    FMOV  W2, S30
    FMOV  H14, X25
    FMOV  H6, W2
    FABS  D23, D15
    FMUL  S7, S11, S0
    FADD  H14, H8, H23
    FNEG  D29, D24
    FNMADD  S8, S29, S16, S29
    FABS  S13, S8
    FMUL  H16, H14, H28
    FNMUL  S30, S3, S7
    FMOV  W19, S25
    FCSEL  S23, S18, S31, LT
    FMUL  D28, D13, D13
    FDIV  D15, D23, D16
    FNEG  S14, S28
    SUBS  X6, X6, #0x1
    B.NE  TSRTFloatMovMadd_label_13
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X24, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0xda5a, LSL #0
    SUB  X24, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0xbeb8, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X24, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0xda5a, LSL #0
    SUB  X24, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xc070, LSL #16
    SUB  X24, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X24, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    SUB  X24, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MRS  X3, FPSR
    MOVZ  X24, #0x1f, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D0
    MOVZ  X24, #0x28a2, LSL #0
    MOVK  X24, #0xa28a, LSL #16
    MOVK  X24, #0xba28, LSL #32
    MOVK  X24, #0x3ffb, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D1
    MOVZ  X24, #0x3bcc, LSL #0
    MOVK  X24, #0x667f, LSL #16
    MOVK  X24, #0xa09e, LSL #32
    MOVK  X24, #0x1f56, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D3
    MOVZ  X24, #0xbeb8, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D6
    MOVZ  X24, #0x5a5a, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D8
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D9
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D10
    MOVZ  X24, #0x7bff, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D11
    MOVZ  X24, #0x36fc, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D14
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D15
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7ff8, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D17
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc070, LSL #16
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D18
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x4038, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D20
    MOVZ  X24, #0xbeb8, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D21
    MOVZ  X24, #0x3eb8, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D22
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7fc0, LSL #16
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D25
    MOVZ  X24, #0xda5a, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D26
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xbffb, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D29
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #48
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D30
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
    FMOV  X3, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMovMadd_TestFail
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
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    FMOV  D0, X5
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X7
    FMOV  D2, X29
    FMOV  V2.D[1], X29
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X26
    FMOV  D5, X27
    FMOV  V5.D[1], X27
    FMOV  D6, X13
    FMOV  V6.D[1], X19
    FMOV  D7, X7
    FMOV  V7.D[1], X16
    FMOV  D8, X19
    FMOV  V8.D[1], X17
    FMOV  D9, X25
    FMOV  V9.D[1], X6
    FMOV  D10, X11
    FMOV  V10.D[1], X27
    FMOV  D11, X17
    FMOV  V11.D[1], X14
    FMOV  D12, X11
    FMOV  V12.D[1], X25
    FMOV  D13, X24
    FMOV  V13.D[1], X17
    FMOV  D14, X6
    FMOV  V14.D[1], X24
    FMOV  D15, X25
    FMOV  V15.D[1], X11
    FMOV  D16, X2
    FMOV  V16.D[1], X20
    FMOV  D17, X20
    FMOV  V17.D[1], X25
    FMOV  D18, X20
    FMOV  V18.D[1], X27
    FMOV  D19, X17
    FMOV  V19.D[1], X26
    FMOV  D20, X19
    FMOV  V20.D[1], X3
    FMOV  D21, X5
    FMOV  V21.D[1], X5
    FMOV  D22, X24
    FMOV  V22.D[1], X24
    FMOV  D23, X28
    FMOV  V23.D[1], X27
    FMOV  D24, X14
    FMOV  V24.D[1], X17
    FMOV  D25, X19
    FMOV  V25.D[1], X20
    FMOV  D26, X7
    FMOV  V26.D[1], X25
    FMOV  D27, X25
    FMOV  V27.D[1], X28
    FMOV  D28, X22
    FMOV  V28.D[1], X7
    FMOV  D29, X11
    FMOV  V29.D[1], X21
    FMOV  D30, X6
    FMOV  V30.D[1], X17
    FMOV  D31, X5
    FMOV  V31.D[1], X21
    MOVZ  X5, #0xa, LSL #0
TSRTFloatMovMadd_label_14:
    FNEG  S29, S23
    FMUL  H15, H3, H3
    FMOV  D22, #-1.37500000
    FNMUL  D25, D8, D28
    FNMSUB  H6, H28, H10, H30
    FNMSUB  D10, D26, D24, D25
    FSUB  D20, D20, D15
    FDIV  S4, S21, S24
    FMOV  D24, #0.14843750
    FSQRT  H17, H20
    FNMUL  H7, H31, H1
    FMOV  S5, #14.50000000
    FNMADD  D2, D6, D4, D10
    FMOV  H4, H21
    FMUL  H15, H14, H9
    FMADD  S6, S17, S2, S29
    FMOV  X26, H15
    FDIV  S10, S4, S12
    FNEG  H3, H10
    FMOV  D31, D11
    FMADD  H23, H27, H3, H3
    FABS  S16, S6
    FMOV  W3, H13
    FMSUB  H12, H23, H25, H0
    FCSEL  S13, S7, S2, AL
    FNMADD  D0, D22, D16, D5
    FMOV  H9, #-1.25000000
    FDIV  D3, D10, D24
    FNMSUB  S10, S12, S9, S10
    FNMADD  D14, D0, D24, D10
    FSUB  D30, D2, D3
    FNEG  D6, D27
    FNMUL  H11, H31, H11
    FMOV  X3, H21
    FADD  H26, H14, H12
    FNMADD  H8, H11, H30, H3
    FMOV  H30, W29
    FMADD  H12, H22, H6, H8
    FSUB  H14, H7, H30
    FMOV  D14, D3
    FMADD  D31, D26, D12, D26
    FNMSUB  H27, H14, H31, H13
    FMUL  H14, H0, H26
    FNMUL  D5, D12, D31
    FMOV  D7, #5.75000000
    FMADD  D10, D13, D12, D3
    FNEG  H21, H10
    FMSUB  S9, S10, S12, S0
    FMOV  W6, S22
    FNMUL  D12, D29, D12
    FMOV  S3, #-0.65625000
    FMOV  D6, #-13.00000000
    FMADD  S31, S5, S3, S12
    FNMSUB  S29, S9, S7, S6
    FNMUL  S30, S14, S6
    FMADD  D26, D24, D29, D31
    FMSUB  D13, D6, D21, D9
    FMOV  D22, D18
    FCSEL  D31, D30, D26, HI
    FABS  H14, H31
    FSUB  S0, S27, S22
    FMOV  H31, X6
    FADD  S18, S1, S3
    FNMADD  D9, D18, D31, D3
    FMADD  D1, D14, D14, D14
    FMOV  H30, H28
    FMOV  S9, W13
    FDIV  D7, D30, D9
    FMADD  D9, D7, D1, D31
    FMOV  X6, D22
    FNMUL  D31, D5, D26
    FMADD  D12, D9, D0, D13
    FNMADD  D12, D6, D25, D21
    FABS  H14, H21
    FDIV  H22, H4, H31
    FSUB  D25, D15, D25
    FCSEL  S15, S2, S14, GE
    FNMADD  D10, D22, D15, D13
    FSQRT  D13, D31
    FCSEL  S3, S27, S28, PL
    FMADD  S21, S17, S16, S6
    FMSUB  D5, D11, D18, D15
    FNMADD  H2, H0, H25, H18
    FMOV  H6, X16
    FMSUB  H30, H6, H2, H20
    FNMADD  S21, S29, S27, S11
    FMADD  D22, D9, D17, D0
    FSQRT  D27, D23
    FNMUL  D14, D30, D13
    FNMADD  H28, H8, H10, H5
    FMUL  D16, D27, D14
    FMOV  D16, #-0.25000000
    FMOV  D2, X26
    FDIV  D25, D28, D21
    FMADD  S8, S29, S31, S27
    FNMSUB  S19, S3, S16, S0
    FMOV  S0, #0.20312500
    FADD  H23, H19, H2
    FCSEL  D19, D20, D0, LS
    FDIV  D30, D23, D8
    FMOV  H23, W29
    FABS  S11, S29
    FMUL  D14, D12, D23
    FCSEL  S27, S19, S22, EQ
    FMOV  H29, W7
    FCSEL  H0, H27, H14, LT
    FNMSUB  S3, S28, S28, S0
    FMOV  W25, H9
    FMOV  H20, X5
    FSQRT  H10, H1
    FMUL  S6, S7, S11
    FNMUL  S11, S20, S29
    FMUL  D14, D11, D3
    FNMSUB  S1, S21, S18, S3
    FNMSUB  S12, S25, S14, S19
    FMOV  W7, H7
    FSQRT  S9, S12
    FMUL  S23, S26, S30
    FMOV  H25, X13
    FNEG  D11, D9
    FNMUL  S28, S23, S25
    FMOV  S0, S9
    FABS  S14, S28
    FNMUL  D25, D15, D14
    FMOV  W14, S1
    FNMUL  D9, D26, D25
    FMOV  X28, H11
    FNEG  H12, H0
    FNMSUB  H0, H9, H8, H6
    FMUL  H28, H10, H12
    FNEG  D1, D27
    FNMADD  H28, H15, H13, H12
    FADD  S3, S15, S24
    FSQRT  S9, S19
    FMOV  W28, H16
    FMOV  S23, S6
    FMOV  X27, H21
    FNMSUB  H11, H4, H12, H3
    FMOV  W2, S8
    FMOV  D8, D29
    FNMADD  H16, H27, H2, H13
    FNEG  S24, S25
    FDIV  S15, S5, S28
    FMUL  S4, S17, S9
    FMOV  D16, D11
    FNMADD  H26, H8, H1, H15
    FMOV  H22, X3
    FDIV  H2, H28, H22
    FNEG  H8, H26
    FMSUB  H13, H23, H8, H24
    FNMSUB  D1, D17, D2, D16
    FADD  D29, D25, D10
    FMSUB  D8, D1, D10, D16
    FADD  S14, S23, S20
    FSUB  H5, H17, H12
    FMOV  X16, H14
    FNEG  H16, H19
    FDIV  D22, D25, D29
    FMOV  D25, D22
    FMOV  X23, D17
    FSUB  D23, D8, D13
    FNMADD  D14, D2, D15, D15
    FMOV  S9, S23
    FMOV  S11, S9
    FCSEL  D22, D5, D15, CC
    FNMSUB  D24, D3, D27, D10
    FNMUL  S1, S24, S29
    FABS  S20, S14
    FNMUL  H8, H21, H20
    FMADD  S28, S22, S20, S16
    FMOV  S29, S8
    FMOV  D10, X16
    FCSEL  D8, D1, D29, VS
    FDIV  H1, H3, H20
    FMOV  S29, W17
    FMOV  H13, H8
    FMUL  S10, S1, S11
    FABS  S17, S24
    FSUB  S2, S17, S19
    FNMSUB  D12, D1, D10, D10
    FNMADD  D22, D28, D13, D12
    FNMADD  S12, S29, S22, S23
    FSQRT  S29, S14
    FMOV  H9, X21
    FSQRT  H16, H24
    FDIV  S13, S16, S12
    FMOV  D17, X14
    FMOV  W3, S29
    FABS  D3, D16
    FMADD  D22, D17, D18, D9
    FMOV  H20, #-7.75000000
    FNEG  D12, D3
    FMSUB  D11, D31, D20, D13
    FDIV  H20, H11, H22
    FMUL  D21, D12, D2
    FNEG  D27, D28
    FNMADD  S9, S15, S14, S6
    FCSEL  H16, H11, H6, VS
    FMADD  H17, H3, H20, H1
    FMSUB  D24, D21, D30, D14
    SUBS  X5, X5, #0x1
    B.NE  TSRTFloatMovMadd_label_14
    MOVZ  X20, #0x3bcc, LSL #0
    MOVK  X20, #0x667f, LSL #16
    SUB  X11, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xbf28, LSL #16
    SUB  X11, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa2e8, LSL #0
    SUB  X11, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x5401, LSL #0
    SUB  X11, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x1, LSL #0
    SUB  X11, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X11, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X11, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MRS  X20, FPSR
    MOVZ  X11, #0x1f, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D0
    MOVZ  X11, #0x8000, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D1
    MOVZ  X11, #0x7e00, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D2
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xbe50, LSL #16
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D4
    MOVZ  X11, #0x39b0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D5
    MOVZ  X11, #0x8000, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D6
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D7
    MOVZ  X11, #0xa2e8, LSL #0
    MOVK  X11, #0x8bbb, LSL #16
    MOVK  X11, #0xba2e, LSL #32
    MOVK  X11, #0x3ee8, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D9
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D11
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7fc0, LSL #16
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D12
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D13
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7fc0, LSL #16
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D14
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D17
    MOVZ  X11, #0x7e00, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D18
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xbf28, LSL #16
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D19
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3e50, LSL #16
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D20
    MOVZ  X11, #0x8000, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D21
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D22
    MOVZ  X11, #0xa5a5, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D23
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D24
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D25
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D26
    MOVZ  X11, #0x8000, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D27
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D28
    MOVZ  X11, #0x8000, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D30
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail
    FMOV  X20, D31
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMovMadd_TestFail

TSRTFloatMovMadd_TestEnd:
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
TSRTFloatMovMadd_TestFail:
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
