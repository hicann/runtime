.global LCRTSveReductionOperations

.text
.p2align 4

LCRTSveReductionOperations:

LCRTSveReductionOperations_TestBegin:
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
    MOVZ  X2, #0xfa45, LSL #0
    MOVK  X2, #0x5a88, LSL #16
    MOVK  X2, #0xfd6b, LSL #32
    MOVK  X2, #0x5e20, LSL #48
    MOVZ  X3, #0x982b, LSL #0
    MOVK  X3, #0x3779, LSL #16
    MOVK  X3, #0xd0d7, LSL #32
    MOVK  X3, #0xa586, LSL #48
    MOVZ  X4, #0xe66a, LSL #0
    MOVK  X4, #0x7d3a, LSL #16
    MOVK  X4, #0x870, LSL #32
    MOVK  X4, #0x331f, LSL #48
    MOVZ  X5, #0xd713, LSL #0
    MOVK  X5, #0x5427, LSL #16
    MOVK  X5, #0x50d8, LSL #32
    MOVK  X5, #0x91c4, LSL #48
    MOVZ  X6, #0xcfbc, LSL #0
    MOVK  X6, #0xd4fd, LSL #16
    MOVK  X6, #0x9f3e, LSL #32
    MOVK  X6, #0x5e05, LSL #48
    MOVZ  X7, #0xab95, LSL #0
    MOVK  X7, #0x6b3c, LSL #16
    MOVK  X7, #0x8d5e, LSL #32
    MOVK  X7, #0x5a50, LSL #48
    MOVZ  X8, #0x20db, LSL #0
    MOVK  X8, #0x4767, LSL #16
    MOVK  X8, #0xfa5f, LSL #32
    MOVK  X8, #0x134c, LSL #48
    MOVZ  X9, #0x8b3, LSL #0
    MOVK  X9, #0xf3e9, LSL #16
    MOVK  X9, #0x6985, LSL #32
    MOVK  X9, #0x816a, LSL #48
    MOVZ  X10, #0x79b1, LSL #0
    MOVK  X10, #0x6cb1, LSL #16
    MOVK  X10, #0xad67, LSL #32
    MOVK  X10, #0xd9a0, LSL #48
    MOVZ  X11, #0xffa1, LSL #0
    MOVK  X11, #0x417e, LSL #16
    MOVK  X11, #0x9b39, LSL #32
    MOVK  X11, #0x6a0e, LSL #48
    MOVZ  X12, #0x7671, LSL #0
    MOVK  X12, #0x6e2c, LSL #16
    MOVK  X12, #0xffd0, LSL #32
    MOVK  X12, #0x4db, LSL #48
    MOVZ  X13, #0xc00e, LSL #0
    MOVK  X13, #0xa893, LSL #16
    MOVK  X13, #0xd1bb, LSL #32
    MOVK  X13, #0x7f2, LSL #48
    MOVZ  X14, #0xd0b4, LSL #0
    MOVK  X14, #0x8a0b, LSL #16
    MOVK  X14, #0x7f38, LSL #32
    MOVK  X14, #0xb4aa, LSL #48
    MOVZ  X15, #0xebe9, LSL #0
    MOVK  X15, #0xfd7c, LSL #16
    MOVK  X15, #0xcae1, LSL #32
    MOVK  X15, #0x61e3, LSL #48
    MOVZ  X16, #0x18fd, LSL #0
    MOVK  X16, #0xf841, LSL #16
    MOVK  X16, #0x8ac1, LSL #32
    MOVK  X16, #0xae58, LSL #48
    MOVZ  X17, #0x8cfa, LSL #0
    MOVK  X17, #0x8952, LSL #16
    MOVK  X17, #0x2d7d, LSL #32
    MOVK  X17, #0x3510, LSL #48
    MOVZ  X23, #0x8298, LSL #0
    MOVK  X23, #0x9cc2, LSL #16
    MOVK  X23, #0xf201, LSL #32
    MOVK  X23, #0x71e5, LSL #48
    MOVZ  X24, #0xc5a8, LSL #0
    MOVK  X24, #0x69f1, LSL #16
    MOVK  X24, #0xefca, LSL #32
    MOVK  X24, #0xb79f, LSL #48
    MOVZ  X25, #0x7164, LSL #0
    MOVK  X25, #0x7922, LSL #16
    MOVK  X25, #0x6e96, LSL #32
    MOVK  X25, #0x4f76, LSL #48
    MOVZ  X26, #0x1ab6, LSL #0
    MOVK  X26, #0x746d, LSL #16
    MOVK  X26, #0x9803, LSL #32
    MOVK  X26, #0x1baa, LSL #48
    MOVZ  X27, #0x1199, LSL #0
    MOVK  X27, #0x2709, LSL #16
    MOVK  X27, #0xa272, LSL #32
    MOVK  X27, #0x60b6, LSL #48
    MOVZ  X28, #0x5ca7, LSL #0
    MOVK  X28, #0xa33, LSL #16
    MOVK  X28, #0xdcdc, LSL #32
    MOVK  X28, #0xd0b5, LSL #48
    MOVZ  X29, #0x7f08, LSL #0
    MOVK  X29, #0x5930, LSL #16
    MOVK  X29, #0xc793, LSL #32
    MOVK  X29, #0x65e1, LSL #48
    MOVZ  X28, #0x8ad9, LSL #0
    MOVK  X28, #0xd5cb, LSL #16
    MOVK  X28, #0xdea4, LSL #32
    MOVK  X28, #0xf929, LSL #48
    MSR  FPCR, X28
    MRS  X6, FPCR
    MOVZ  X17, #0x60ff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X6, X6, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X6, X6, X17
    MSR  FPCR, X6
    ISB  SY
    MOVZ  X28, #0x8690, LSL #0
    MOVK  X28, #0xa4b7, LSL #16
    MOVK  X28, #0x20eb, LSL #32
    MOVK  X28, #0x8e7d, LSL #48
    MSR  FPSR, X28
    MRS  X3, FPSR
    MOVZ  X5, #0xff60, LSL #0
    MOVK  X5, #0x7ff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    AND  X3, X3, X5
    MOVZ  X5, #0x0, LSL #0
    ORR  X3, X3, X5
    MSR  FPSR, X3
    ISB  SY
    ADDS  X9, X5, X10, LSR #2
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xa0e7, LSL #0
    MOVK  X2, #0xa1f4, LSL #16
    MOVK  X2, #0x6b3a, LSL #32
    MOVK  X2, #0x7e87, LSL #48
    MOVZ  X3, #0x80c4, LSL #0
    MOVK  X3, #0xdde1, LSL #16
    MOVK  X3, #0x93fc, LSL #32
    MOVK  X3, #0x6dea, LSL #48
    MOVZ  X4, #0x8ad, LSL #0
    MOVK  X4, #0xd50c, LSL #16
    MOVK  X4, #0xe067, LSL #32
    MOVK  X4, #0x7b95, LSL #48
    MOVZ  X5, #0x6098, LSL #0
    MOVK  X5, #0x31fc, LSL #16
    MOVK  X5, #0xb813, LSL #32
    MOVK  X5, #0xa306, LSL #48
    MOVZ  X6, #0x30bf, LSL #0
    MOVK  X6, #0xc437, LSL #16
    MOVK  X6, #0xe6b, LSL #32
    MOVK  X6, #0xf135, LSL #48
    MOVZ  X7, #0x393, LSL #0
    MOVK  X7, #0x5f13, LSL #16
    MOVK  X7, #0xbec6, LSL #32
    MOVK  X7, #0x9462, LSL #48
    MOVZ  X8, #0xb0f9, LSL #0
    MOVK  X8, #0x63de, LSL #16
    MOVK  X8, #0xc4f2, LSL #32
    MOVK  X8, #0xca25, LSL #48
    MOVZ  X9, #0xf2a4, LSL #0
    MOVK  X9, #0x6380, LSL #16
    MOVK  X9, #0x8df0, LSL #32
    MOVK  X9, #0xf54, LSL #48
    MOVZ  X10, #0xf801, LSL #0
    MOVK  X10, #0x66fb, LSL #16
    MOVK  X10, #0xdb48, LSL #32
    MOVK  X10, #0x7cc3, LSL #48
    MOVZ  X11, #0x2965, LSL #0
    MOVK  X11, #0xe9c3, LSL #16
    MOVK  X11, #0x2d10, LSL #32
    MOVK  X11, #0x439d, LSL #48
    MOVZ  X12, #0x324b, LSL #0
    MOVK  X12, #0x7f45, LSL #16
    MOVK  X12, #0x7a19, LSL #32
    MOVK  X12, #0x49f9, LSL #48
    MOVZ  X13, #0xc996, LSL #0
    MOVK  X13, #0x2a0, LSL #16
    MOVK  X13, #0x79db, LSL #32
    MOVK  X13, #0x5868, LSL #48
    MOVZ  X14, #0x50e3, LSL #0
    MOVK  X14, #0x371e, LSL #16
    MOVK  X14, #0x1f3, LSL #32
    MOVK  X14, #0x2959, LSL #48
    MOVZ  X15, #0x630f, LSL #0
    MOVK  X15, #0x686c, LSL #16
    MOVK  X15, #0x159, LSL #32
    MOVK  X15, #0xfae2, LSL #48
    MOVZ  X16, #0xbb92, LSL #0
    MOVK  X16, #0x6f74, LSL #16
    MOVK  X16, #0x2ebe, LSL #32
    MOVK  X16, #0xac6c, LSL #48
    MOVZ  X17, #0xed2e, LSL #0
    MOVK  X17, #0xb5c9, LSL #16
    MOVK  X17, #0xf20b, LSL #32
    MOVK  X17, #0xa24c, LSL #48
    MOVZ  X23, #0xa6, LSL #0
    MOVK  X23, #0x1a73, LSL #16
    MOVK  X23, #0x4ddd, LSL #32
    MOVK  X23, #0x5a74, LSL #48
    MOVZ  X24, #0x47d8, LSL #0
    MOVK  X24, #0x80e5, LSL #16
    MOVK  X24, #0x355e, LSL #32
    MOVK  X24, #0x71dc, LSL #48
    MOVZ  X25, #0xad36, LSL #0
    MOVK  X25, #0xa079, LSL #16
    MOVK  X25, #0x3c61, LSL #32
    MOVK  X25, #0x7a0b, LSL #48
    MOVZ  X26, #0x4e8b, LSL #0
    MOVK  X26, #0x85cf, LSL #16
    MOVK  X26, #0x54bd, LSL #32
    MOVK  X26, #0x7a9, LSL #48
    MOVZ  X27, #0x3313, LSL #0
    MOVK  X27, #0xec42, LSL #16
    MOVK  X27, #0xc390, LSL #32
    MOVK  X27, #0x1d51, LSL #48
    MOVZ  X28, #0x2151, LSL #0
    MOVK  X28, #0x4c02, LSL #16
    MOVK  X28, #0x3360, LSL #32
    MOVK  X28, #0xd257, LSL #48
    MOVZ  X29, #0x8959, LSL #0
    MOVK  X29, #0xac02, LSL #16
    MOVK  X29, #0x5f84, LSL #32
    MOVK  X29, #0x29f2, LSL #48
    DUP     Z0.D, X29
    DUP     Z1.D, X27
    DUP     Z2.D, X28
    DUP     Z3.D, X7
    DUP     Z4.D, X26
    DUP     Z5.D, X28
    DUP     Z6.D, X5
    DUP     Z7.D, X14
    DUP     Z8.D, X17
    DUP     Z9.D, X28
    DUP     Z10.D, X4
    DUP     Z11.D, X2
    DUP     Z12.D, X8
    DUP     Z13.D, X17
    DUP     Z14.D, X8
    DUP     Z15.D, X5
    DUP     Z16.D, X26
    DUP     Z17.D, X24
    DUP     Z18.D, X16
    DUP     Z19.D, X14
    DUP     Z20.D, X27
    DUP     Z21.D, X3
    DUP     Z22.D, X4
    DUP     Z23.D, X11
    DUP     Z24.D, X27
    DUP     Z25.D, X7
    DUP     Z26.D, X28
    DUP     Z27.D, X10
    DUP     Z28.D, X15
    DUP     Z29.D, X12
    DUP     Z30.D, X27
    DUP     Z31.D, X24
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    ANDV    B0, P7, Z28.B
    ANDV    B24, P3, Z3.B
    ANDV    B19, P5, Z23.B
    ANDV    B18, P2, Z31.B
    ANDV    B26, P5, Z16.B
    ANDV    B7, P7, Z9.B
    ANDV    B1, P0, Z18.B
    ANDV    B16, P4, Z7.B
    ANDV    B19, P6, Z27.B
    ANDV    B5, P6, Z24.B
    ANDV    D12, P3, Z0.D
    ANDV    D21, P2, Z0.D
    ANDV    D15, P4, Z26.D
    ANDV    D22, P3, Z29.D
    ANDV    D25, P6, Z21.D
    ANDV    D2, P4, Z15.D
    ANDV    D4, P7, Z22.D
    ANDV    D7, P6, Z28.D
    ANDV    D3, P5, Z4.D
    ANDV    D5, P4, Z12.D
    ANDV    S28, P3, Z7.S
    ANDV    S5, P5, Z2.S
    ANDV    S15, P7, Z19.S
    ANDV    S23, P5, Z3.S
    ANDV    S31, P1, Z31.S
    ANDV    S18, P1, Z27.S
    ANDV    S22, P3, Z25.S
    ANDV    S7, P1, Z22.S
    ANDV    S25, P2, Z31.S
    ANDV    S3, P6, Z5.S
    ANDV    H6, P0, Z25.H
    ANDV    H2, P3, Z3.H
    ANDV    H21, P5, Z6.H
    ANDV    H0, P4, Z0.H
    ANDV    H4, P2, Z30.H
    ANDV    H5, P2, Z23.H
    ANDV    H25, P4, Z15.H
    ANDV    H12, P6, Z26.H
    ANDV    H23, P5, Z2.H
    ANDV    H31, P4, Z21.H
    EORV    B19, P1, Z31.B
    EORV    B21, P4, Z4.B
    EORV    B26, P4, Z21.B
    EORV    B6, P0, Z25.B
    EORV    B31, P2, Z5.B
    EORV    B21, P2, Z28.B
    EORV    B5, P5, Z23.B
    EORV    B9, P6, Z21.B
    EORV    B12, P0, Z12.B
    EORV    B15, P0, Z6.B
    EORV    H21, P4, Z28.H
    EORV    H2, P0, Z19.H
    EORV    H22, P0, Z17.H
    EORV    H4, P7, Z0.H
    EORV    H0, P1, Z4.H
    EORV    H6, P5, Z26.H
    EORV    H23, P3, Z21.H
    EORV    H21, P7, Z0.H
    EORV    H24, P2, Z10.H
    EORV    H10, P1, Z23.H
    EORV    D4, P1, Z21.D
    EORV    D19, P4, Z12.D
    EORV    D12, P2, Z24.D
    EORV    D23, P4, Z31.D
    EORV    D17, P7, Z15.D
    EORV    D11, P5, Z5.D
    EORV    D31, P3, Z17.D
    EORV    D15, P4, Z22.D
    EORV    D17, P4, Z1.D
    EORV    D21, P2, Z11.D
    EORV    S22, P2, Z31.S
    EORV    S8, P3, Z22.S
    EORV    S26, P2, Z8.S
    EORV    S31, P6, Z4.S
    EORV    S1, P1, Z17.S
    EORV    S22, P6, Z6.S
    EORV    S25, P4, Z10.S
    EORV    S17, P0, Z31.S
    EORV    S11, P3, Z21.S
    EORV    S1, P2, Z12.S
    FADDA   H23, P7, H23, Z23.H
    FADDA   H17, P6, H17, Z1.H
    FADDA   H25, P0, H25, Z19.H
    FADDA   H15, P4, H15, Z27.H
    FADDA   H16, P6, H16, Z22.H
    FADDA   H23, P7, H23, Z8.H
    FADDA   H17, P4, H17, Z21.H
    FADDA   H16, P7, H16, Z10.H
    FADDA   H23, P5, H23, Z17.H
    FADDA   H26, P7, H26, Z25.H
    FADDA   S24, P2, S24, Z23.S
    FADDA   S11, P1, S11, Z15.S
    FADDA   S3, P4, S3, Z24.S
    FADDA   S28, P2, S28, Z11.S
    FADDA   S23, P4, S23, Z6.S
    FADDA   S26, P3, S26, Z26.S
    FADDA   S28, P0, S28, Z23.S
    FADDA   S24, P5, S24, Z16.S
    FADDA   S28, P0, S28, Z22.S
    FADDA   S28, P5, S28, Z24.S
    FADDA   D26, P5, D26, Z26.D
    FADDA   D26, P4, D26, Z3.D
    FADDA   D22, P7, D22, Z8.D
    FADDA   D9, P1, D9, Z31.D
    FADDA   D31, P0, D31, Z3.D
    FADDA   D26, P2, D26, Z28.D
    FADDA   D28, P4, D28, Z26.D
    FADDA   D25, P2, D25, Z11.D
    FADDA   D20, P4, D20, Z30.D
    FADDA   D1, P0, D1, Z21.D
    FADDV   D2, P6, Z26.D
    FADDV   D21, P6, Z13.D
    FADDV   D13, P4, Z28.D
    FADDV   D14, P6, Z9.D
    FADDV   D24, P4, Z13.D
    FADDV   D14, P2, Z21.D
    FADDV   D21, P7, Z24.D
    FADDV   D3, P3, Z31.D
    FADDV   D15, P3, Z21.D
    FADDV   D7, P7, Z7.D
    FADDV   H8, P7, Z3.H
    FADDV   H3, P2, Z2.H
    FADDV   H6, P4, Z29.H
    FADDV   H2, P3, Z12.H
    FADDV   H28, P4, Z29.H
    FADDV   H16, P6, Z1.H
    FADDV   H23, P1, Z6.H
    FADDV   H31, P4, Z10.H
    FADDV   H13, P0, Z13.H
    FADDV   H7, P5, Z14.H
    FADDV   S29, P6, Z11.S
    FADDV   S14, P2, Z3.S
    FADDV   S9, P0, Z26.S
    FADDV   S1, P1, Z15.S
    FADDV   S10, P7, Z14.S
    FADDV   S24, P0, Z2.S
    FADDV   S3, P5, Z31.S
    FADDV   S28, P3, Z29.S
    FADDV   S17, P5, Z1.S
    FADDV   S13, P4, Z5.S
    FMAXNMV S5, P1, Z3.S
    FMAXNMV S11, P2, Z16.S
    FMAXNMV S29, P2, Z8.S
    FMAXNMV S26, P3, Z11.S
    FMAXNMV S8, P5, Z14.S
    FMAXNMV S22, P4, Z22.S
    FMAXNMV S31, P3, Z28.S
    FMAXNMV S2, P5, Z1.S
    FMAXNMV S0, P1, Z22.S
    FMAXNMV S2, P5, Z23.S
    FMAXNMV H3, P2, Z29.H
    FMAXNMV H14, P6, Z26.H
    FMAXNMV H2, P6, Z17.H
    FMAXNMV H11, P7, Z18.H
    FMAXNMV H23, P4, Z11.H
    FMAXNMV H30, P6, Z3.H
    FMAXNMV H26, P7, Z9.H
    FMAXNMV H1, P4, Z14.H
    FMAXNMV H11, P3, Z20.H
    FMAXNMV H20, P3, Z31.H
    FMAXNMV D31, P6, Z26.D
    FMAXNMV D4, P7, Z11.D
    FMAXNMV D28, P3, Z1.D
    FMAXNMV D23, P2, Z23.D
    FMAXNMV D11, P7, Z31.D
    FMAXNMV D31, P4, Z30.D
    FMAXNMV D16, P5, Z0.D
    FMAXNMV D17, P3, Z23.D
    FMAXNMV D30, P5, Z3.D
    FMAXNMV D9, P6, Z8.D
    FMAXV   H18, P1, Z9.H
    FMAXV   H1, P3, Z28.H
    FMAXV   H14, P4, Z1.H
    FMAXV   H3, P7, Z11.H
    FMAXV   H30, P2, Z18.H
    FMAXV   H23, P2, Z20.H
    FMAXV   H13, P4, Z31.H
    FMAXV   H1, P7, Z24.H
    FMAXV   H22, P4, Z16.H
    FMAXV   H31, P5, Z2.H
    FMAXV   S16, P6, Z21.S
    FMAXV   S0, P1, Z1.S
    FMAXV   S28, P3, Z10.S
    FMAXV   S21, P4, Z14.S
    FMAXV   S24, P5, Z4.S
    FMAXV   S19, P3, Z10.S
    FMAXV   S17, P7, Z24.S
    FMAXV   S10, P1, Z16.S
    FMAXV   S14, P3, Z3.S
    FMAXV   S9, P5, Z28.S
    FMAXV   D11, P3, Z31.D
    FMAXV   D18, P2, Z9.D
    FMAXV   D8, P4, Z13.D
    FMAXV   D3, P6, Z7.D
    FMAXV   D4, P6, Z17.D
    FMAXV   D8, P1, Z3.D
    FMAXV   D16, P3, Z11.D
    FMAXV   D31, P0, Z21.D
    FMAXV   D21, P0, Z23.D
    FMAXV   D19, P0, Z10.D
    FMINNMV D7, P2, Z17.D
    FMINNMV D11, P6, Z7.D
    FMINNMV D28, P3, Z23.D
    FMINNMV D13, P3, Z11.D
    FMINNMV D11, P4, Z0.D
    FMINNMV D3, P2, Z22.D
    FMINNMV D29, P7, Z30.D
    FMINNMV D30, P5, Z29.D
    FMINNMV D12, P1, Z28.D
    FMINNMV D7, P1, Z15.D
    FMINNMV H8, P6, Z4.H
    FMINNMV H22, P3, Z30.H
    FMINNMV H15, P7, Z22.H
    FMINNMV H31, P4, Z19.H
    FMINNMV H22, P6, Z8.H
    FMINNMV H30, P1, Z1.H
    FMINNMV H4, P7, Z11.H
    FMINNMV H1, P4, Z7.H
    FMINNMV H29, P7, Z12.H
    FMINNMV H11, P6, Z4.H
    FMINNMV S0, P5, Z15.S
    FMINNMV S7, P3, Z1.S
    FMINNMV S27, P3, Z5.S
    FMINNMV S28, P3, Z3.S
    FMINNMV S5, P4, Z7.S
    FMINNMV S1, P0, Z5.S
    FMINNMV S19, P3, Z29.S
    FMINNMV S10, P5, Z11.S
    FMINNMV S3, P7, Z27.S
    FMINNMV S29, P0, Z31.S
    FMINV   H8, P1, Z3.H
    FMINV   H14, P5, Z29.H
    FMINV   H11, P7, Z19.H
    FMINV   H18, P3, Z1.H
    FMINV   H19, P5, Z20.H
    FMINV   H1, P4, Z29.H
    FMINV   H15, P5, Z17.H
    FMINV   H29, P1, Z29.H
    FMINV   H3, P4, Z19.H
    FMINV   H27, P3, Z26.H
    FMINV   S19, P0, Z15.S
    FMINV   S5, P2, Z0.S
    FMINV   S31, P3, Z19.S
    FMINV   S20, P7, Z1.S
    FMINV   S0, P3, Z5.S
    FMINV   S17, P3, Z11.S
    FMINV   S21, P7, Z17.S
    FMINV   S0, P0, Z18.S
    FMINV   S19, P7, Z27.S
    FMINV   S2, P3, Z20.S
    FMINV   D3, P0, Z28.D
    FMINV   D20, P1, Z29.D
    FMINV   D9, P6, Z28.D
    FMINV   D28, P0, Z9.D
    FMINV   D27, P3, Z28.D
    FMINV   D9, P2, Z21.D
    FMINV   D21, P6, Z3.D
    FMINV   D5, P1, Z27.D
    FMINV   D17, P7, Z8.D
    FMINV   D0, P3, Z21.D
    ORV     H29, P2, Z5.H
    ORV     H11, P0, Z31.H
    ORV     H7, P1, Z29.H
    ORV     H31, P3, Z9.H
    ORV     H9, P4, Z19.H
    ORV     H27, P0, Z0.H
    ORV     H28, P5, Z31.H
    ORV     H26, P4, Z30.H
    ORV     H0, P4, Z2.H
    ORV     H31, P6, Z1.H
    ORV     D1, P2, Z27.D
    ORV     D19, P6, Z9.D
    ORV     D21, P1, Z9.D
    ORV     D29, P0, Z21.D
    ORV     D3, P0, Z0.D
    ORV     D29, P4, Z1.D
    ORV     D9, P6, Z26.D
    ORV     D8, P4, Z29.D
    ORV     D31, P7, Z17.D
    ORV     D30, P0, Z7.D
    ORV     S21, P0, Z31.S
    ORV     S8, P4, Z4.S
    ORV     S4, P4, Z26.S
    ORV     S19, P5, Z30.S
    ORV     S31, P2, Z3.S
    ORV     S7, P2, Z21.S
    ORV     S17, P6, Z19.S
    ORV     S28, P5, Z9.S
    ORV     S9, P6, Z7.S
    ORV     S29, P5, Z17.S
    ORV     B26, P7, Z28.B
    ORV     B29, P6, Z8.B
    ORV     B28, P1, Z11.B
    ORV     B21, P7, Z26.B
    ORV     B30, P6, Z29.B
    ORV     B17, P6, Z28.B
    ORV     B28, P0, Z4.B
    ORV     B3, P5, Z17.B
    ORV     B6, P2, Z28.B
    ORV     B29, P7, Z21.B
    MOVZ  X8, #0xa0e7, LSL #0
    MOVK  X8, #0xa1f4, LSL #16
    MOVK  X8, #0x6b3a, LSL #32
    MOVK  X8, #0x7e87, LSL #48
    SUB  X24, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x80c4, LSL #0
    MOVK  X8, #0xdde1, LSL #16
    MOVK  X8, #0x93fc, LSL #32
    MOVK  X8, #0x6dea, LSL #48
    SUB  X24, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x8ad, LSL #0
    MOVK  X8, #0xd50c, LSL #16
    MOVK  X8, #0xe067, LSL #32
    MOVK  X8, #0x7b95, LSL #48
    SUB  X24, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x6098, LSL #0
    MOVK  X8, #0x31fc, LSL #16
    MOVK  X8, #0xb813, LSL #32
    MOVK  X8, #0xa306, LSL #48
    SUB  X24, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x30bf, LSL #0
    MOVK  X8, #0xc437, LSL #16
    MOVK  X8, #0xe6b, LSL #32
    MOVK  X8, #0xf135, LSL #48
    SUB  X24, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x393, LSL #0
    MOVK  X8, #0x5f13, LSL #16
    MOVK  X8, #0xbec6, LSL #32
    MOVK  X8, #0x9462, LSL #48
    SUB  X24, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0xf2a4, LSL #0
    MOVK  X8, #0x6380, LSL #16
    MOVK  X8, #0x8df0, LSL #32
    MOVK  X8, #0xf54, LSL #48
    SUB  X24, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0xf801, LSL #0
    MOVK  X8, #0x66fb, LSL #16
    MOVK  X8, #0xdb48, LSL #32
    MOVK  X8, #0x7cc3, LSL #48
    SUB  X24, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x2965, LSL #0
    MOVK  X8, #0xe9c3, LSL #16
    MOVK  X8, #0x2d10, LSL #32
    MOVK  X8, #0x439d, LSL #48
    SUB  X24, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x324b, LSL #0
    MOVK  X8, #0x7f45, LSL #16
    MOVK  X8, #0x7a19, LSL #32
    MOVK  X8, #0x49f9, LSL #48
    SUB  X24, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0xc996, LSL #0
    MOVK  X8, #0x2a0, LSL #16
    MOVK  X8, #0x79db, LSL #32
    MOVK  X8, #0x5868, LSL #48
    SUB  X24, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x630f, LSL #0
    MOVK  X8, #0x686c, LSL #16
    MOVK  X8, #0x159, LSL #32
    MOVK  X8, #0xfae2, LSL #48
    SUB  X24, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0xbb92, LSL #0
    MOVK  X8, #0x6f74, LSL #16
    MOVK  X8, #0x2ebe, LSL #32
    MOVK  X8, #0xac6c, LSL #48
    SUB  X24, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0xed2e, LSL #0
    MOVK  X8, #0xb5c9, LSL #16
    MOVK  X8, #0xf20b, LSL #32
    MOVK  X8, #0xa24c, LSL #48
    SUB  X24, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0xa6, LSL #0
    MOVK  X8, #0x1a73, LSL #16
    MOVK  X8, #0x4ddd, LSL #32
    MOVK  X8, #0x5a74, LSL #48
    SUB  X24, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0xad36, LSL #0
    MOVK  X8, #0xa079, LSL #16
    MOVK  X8, #0x3c61, LSL #32
    MOVK  X8, #0x7a0b, LSL #48
    SUB  X24, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x4e8b, LSL #0
    MOVK  X8, #0x85cf, LSL #16
    MOVK  X8, #0x54bd, LSL #32
    MOVK  X8, #0x7a9, LSL #48
    SUB  X24, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x3313, LSL #0
    MOVK  X8, #0xec42, LSL #16
    MOVK  X8, #0xc390, LSL #32
    MOVK  X8, #0x1d51, LSL #48
    SUB  X24, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x2151, LSL #0
    MOVK  X8, #0x4c02, LSL #16
    MOVK  X8, #0x3360, LSL #32
    MOVK  X8, #0xd257, LSL #48
    SUB  X24, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x8959, LSL #0
    MOVK  X8, #0xac02, LSL #16
    MOVK  X8, #0x5f84, LSL #32
    MOVK  X8, #0x29f2, LSL #48
    SUB  X24, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MRS  X8, FPSR
    MOVZ  X24, #0x91, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FMOV  X8, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P1, Z0.D
    FMOV  X8, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D1, P3, Z1.D
    FMOV  X8, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X8, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X8, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X8, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X8, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X8, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X8, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X8, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X8, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X8, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X8, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X8, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X8, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X8, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X8, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X8, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D17, P1, Z17.D
    FMOV  X8, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X8, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X8, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D20, P7, Z20.D
    FMOV  X8, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X8, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X8, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D23, P3, Z23.D
    FMOV  X8, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D24, P6, Z24.D
    FMOV  X8, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D25, P3, Z25.D
    FMOV  X8, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D26, P3, Z26.D
    FMOV  X8, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X8, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X8, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X8, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X8, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    FADDV   D31, P2, Z31.D
    FMOV  X8, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X2, #0x1f2, LSL #0
    MOVK  X2, #0x1f8, LSL #16
    MOVK  X2, #0x658b, LSL #32
    MOVK  X2, #0x14db, LSL #48
    MOVZ  X3, #0xcd13, LSL #0
    MOVK  X3, #0xad, LSL #16
    MOVK  X3, #0xef17, LSL #32
    MOVK  X3, #0x863, LSL #48
    MOVZ  X4, #0x11a7, LSL #0
    MOVK  X4, #0xa219, LSL #16
    MOVK  X4, #0x246f, LSL #32
    MOVK  X4, #0x83a0, LSL #48
    MOVZ  X5, #0x85ac, LSL #0
    MOVK  X5, #0xc995, LSL #16
    MOVK  X5, #0xa4ca, LSL #32
    MOVK  X5, #0x80ec, LSL #48
    MOVZ  X6, #0xb340, LSL #0
    MOVK  X6, #0xdb0f, LSL #16
    MOVK  X6, #0x79f5, LSL #32
    MOVK  X6, #0x9bad, LSL #48
    MOVZ  X7, #0xb980, LSL #0
    MOVK  X7, #0x1a0b, LSL #16
    MOVK  X7, #0xa799, LSL #32
    MOVK  X7, #0x697d, LSL #48
    MOVZ  X8, #0xf849, LSL #0
    MOVK  X8, #0xcb14, LSL #16
    MOVK  X8, #0x1cb3, LSL #32
    MOVK  X8, #0x9ba4, LSL #48
    MOVZ  X9, #0x15f2, LSL #0
    MOVK  X9, #0x7782, LSL #16
    MOVK  X9, #0x38a5, LSL #32
    MOVK  X9, #0x4ab3, LSL #48
    MOVZ  X10, #0x12c1, LSL #0
    MOVK  X10, #0xf486, LSL #16
    MOVK  X10, #0xab9, LSL #32
    MOVK  X10, #0x9ee4, LSL #48
    MOVZ  X11, #0x8fa9, LSL #0
    MOVK  X11, #0x538, LSL #16
    MOVK  X11, #0x25a9, LSL #32
    MOVK  X11, #0xfa22, LSL #48
    MOVZ  X12, #0x4154, LSL #0
    MOVK  X12, #0x5a6e, LSL #16
    MOVK  X12, #0xc5b, LSL #32
    MOVK  X12, #0xa6cc, LSL #48
    MOVZ  X13, #0x76eb, LSL #0
    MOVK  X13, #0x79b5, LSL #16
    MOVK  X13, #0xca2c, LSL #32
    MOVK  X13, #0x9618, LSL #48
    MOVZ  X14, #0xc2d7, LSL #0
    MOVK  X14, #0xb94b, LSL #16
    MOVK  X14, #0xb1e8, LSL #32
    MOVK  X14, #0x5026, LSL #48
    MOVZ  X15, #0x6d01, LSL #0
    MOVK  X15, #0x600a, LSL #16
    MOVK  X15, #0xd8f9, LSL #32
    MOVK  X15, #0xdda7, LSL #48
    MOVZ  X16, #0xfbd5, LSL #0
    MOVK  X16, #0x6531, LSL #16
    MOVK  X16, #0x611e, LSL #32
    MOVK  X16, #0xdab, LSL #48
    MOVZ  X17, #0xfe35, LSL #0
    MOVK  X17, #0x578a, LSL #16
    MOVK  X17, #0xe725, LSL #32
    MOVK  X17, #0xdda1, LSL #48
    MOVZ  X23, #0x7878, LSL #0
    MOVK  X23, #0xc51f, LSL #16
    MOVK  X23, #0xe516, LSL #32
    MOVK  X23, #0xc2f2, LSL #48
    MOVZ  X24, #0xc826, LSL #0
    MOVK  X24, #0x2189, LSL #16
    MOVK  X24, #0x6ea0, LSL #32
    MOVK  X24, #0x2f4d, LSL #48
    MOVZ  X25, #0x47bb, LSL #0
    MOVK  X25, #0x114, LSL #16
    MOVK  X25, #0xa131, LSL #32
    MOVK  X25, #0x3055, LSL #48
    MOVZ  X26, #0xefa1, LSL #0
    MOVK  X26, #0x8871, LSL #16
    MOVK  X26, #0x8157, LSL #32
    MOVK  X26, #0xdaed, LSL #48
    MOVZ  X27, #0x61e5, LSL #0
    MOVK  X27, #0xdca5, LSL #16
    MOVK  X27, #0xa1e7, LSL #32
    MOVK  X27, #0x2faf, LSL #48
    MOVZ  X28, #0x226f, LSL #0
    MOVK  X28, #0xb479, LSL #16
    MOVK  X28, #0x16ba, LSL #32
    MOVK  X28, #0xd617, LSL #48
    MOVZ  X29, #0x94d6, LSL #0
    MOVK  X29, #0x3065, LSL #16
    MOVK  X29, #0x53d1, LSL #32
    MOVK  X29, #0x9baf, LSL #48
    DUP     Z0.D, X3
    DUP     Z1.D, X29
    DUP     Z2.D, X25
    DUP     Z3.D, X26
    DUP     Z4.D, X16
    DUP     Z5.D, X28
    DUP     Z6.D, X27
    DUP     Z7.D, X12
    DUP     Z8.D, X27
    DUP     Z9.D, X10
    DUP     Z10.D, X16
    DUP     Z11.D, X16
    DUP     Z12.D, X13
    DUP     Z13.D, X16
    DUP     Z14.D, X9
    DUP     Z15.D, X2
    DUP     Z16.D, X3
    DUP     Z17.D, X11
    DUP     Z18.D, X26
    DUP     Z19.D, X3
    DUP     Z20.D, X10
    DUP     Z21.D, X29
    DUP     Z22.D, X28
    DUP     Z23.D, X23
    DUP     Z24.D, X23
    DUP     Z25.D, X3
    DUP     Z26.D, X14
    DUP     Z27.D, X5
    DUP     Z28.D, X9
    DUP     Z29.D, X17
    DUP     Z30.D, X15
    DUP     Z31.D, X11
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    SADDV   D30, P2, Z31.S
    SADDV   D28, P3, Z29.S
    SADDV   D3, P4, Z28.S
    SADDV   D5, P5, Z23.S
    SADDV   D3, P6, Z30.S
    SADDV   D7, P1, Z21.S
    SADDV   D6, P0, Z31.S
    SADDV   D17, P4, Z5.S
    SADDV   D21, P7, Z3.S
    SADDV   D10, P4, Z6.S
    SADDV   D5, P6, Z17.H
    SADDV   D29, P6, Z21.H
    SADDV   D13, P4, Z10.H
    SADDV   D15, P1, Z11.H
    SADDV   D9, P2, Z7.H
    SADDV   D24, P4, Z9.H
    SADDV   D31, P0, Z13.H
    SADDV   D1, P3, Z15.H
    SADDV   D19, P5, Z5.H
    SADDV   D13, P0, Z24.H
    SADDV   D8, P3, Z13.B
    SADDV   D5, P1, Z10.B
    SADDV   D6, P7, Z23.B
    SADDV   D24, P2, Z15.B
    SADDV   D23, P0, Z14.B
    SADDV   D9, P3, Z8.B
    SADDV   D3, P6, Z2.B
    SADDV   D5, P3, Z8.B
    SADDV   D10, P1, Z18.B
    SADDV   D8, P2, Z6.B
    SMAXV   S2, P0, Z5.S
    SMAXV   S31, P7, Z17.S
    SMAXV   S24, P0, Z24.S
    SMAXV   S26, P0, Z3.S
    SMAXV   S23, P6, Z8.S
    SMAXV   S10, P1, Z2.S
    SMAXV   S13, P3, Z2.S
    SMAXV   S6, P4, Z31.S
    SMAXV   S3, P3, Z12.S
    SMAXV   S21, P3, Z3.S
    SMAXV   H31, P3, Z7.H
    SMAXV   H12, P5, Z25.H
    SMAXV   H8, P7, Z10.H
    SMAXV   H7, P2, Z6.H
    SMAXV   H5, P4, Z21.H
    SMAXV   H15, P6, Z5.H
    SMAXV   H6, P5, Z23.H
    SMAXV   H1, P3, Z19.H
    SMAXV   H21, P0, Z28.H
    SMAXV   H4, P3, Z26.H
    SMAXV   B28, P5, Z21.B
    SMAXV   B25, P6, Z9.B
    SMAXV   B26, P6, Z22.B
    SMAXV   B9, P3, Z5.B
    SMAXV   B14, P1, Z26.B
    SMAXV   B19, P5, Z24.B
    SMAXV   B3, P7, Z29.B
    SMAXV   B26, P0, Z5.B
    SMAXV   B17, P2, Z1.B
    SMAXV   B10, P1, Z9.B
    SMAXV   D19, P4, Z15.D
    SMAXV   D1, P7, Z17.D
    SMAXV   D2, P4, Z30.D
    SMAXV   D1, P5, Z1.D
    SMAXV   D17, P4, Z25.D
    SMAXV   D7, P7, Z6.D
    SMAXV   D25, P6, Z3.D
    SMAXV   D6, P1, Z17.D
    SMAXV   D22, P0, Z1.D
    SMAXV   D15, P0, Z25.D
    SMINV   D23, P5, Z19.D
    SMINV   D22, P2, Z10.D
    SMINV   D5, P4, Z16.D
    SMINV   D2, P5, Z13.D
    SMINV   D24, P0, Z21.D
    SMINV   D25, P1, Z9.D
    SMINV   D17, P4, Z11.D
    SMINV   D22, P2, Z7.D
    SMINV   D15, P1, Z14.D
    SMINV   D7, P3, Z2.D
    SMINV   H9, P7, Z6.H
    SMINV   H1, P6, Z23.H
    SMINV   H10, P0, Z17.H
    SMINV   H22, P7, Z1.H
    SMINV   H1, P6, Z25.H
    SMINV   H14, P3, Z22.H
    SMINV   H22, P0, Z10.H
    SMINV   H6, P3, Z14.H
    SMINV   H17, P5, Z6.H
    SMINV   H25, P0, Z7.H
    SMINV   B10, P2, Z15.B
    SMINV   B14, P0, Z1.B
    SMINV   B2, P2, Z19.B
    SMINV   B16, P1, Z3.B
    SMINV   B1, P6, Z25.B
    SMINV   B21, P4, Z10.B
    SMINV   B23, P4, Z1.B
    SMINV   B10, P6, Z2.B
    SMINV   B7, P7, Z17.B
    SMINV   B2, P7, Z21.B
    SMINV   S1, P0, Z2.S
    SMINV   S19, P5, Z16.S
    SMINV   S3, P7, Z19.S
    SMINV   S27, P7, Z29.S
    SMINV   S21, P1, Z23.S
    SMINV   S16, P5, Z11.S
    SMINV   S29, P0, Z7.S
    SMINV   S25, P0, Z10.S
    SMINV   S19, P6, Z25.S
    SMINV   S17, P1, Z21.S
    UADDV   D25, P0, Z3.B
    UADDV   D15, P4, Z15.B
    UADDV   D31, P3, Z17.B
    UADDV   D11, P6, Z31.B
    UADDV   D10, P4, Z19.B
    UADDV   D7, P2, Z14.B
    UADDV   D21, P4, Z14.B
    UADDV   D17, P5, Z8.B
    UADDV   D31, P3, Z25.B
    UADDV   D3, P1, Z29.B
    UADDV   D19, P0, Z3.S
    UADDV   D3, P3, Z11.S
    UADDV   D31, P3, Z28.S
    UADDV   D25, P6, Z7.S
    UADDV   D8, P7, Z29.S
    UADDV   D14, P3, Z17.S
    UADDV   D17, P4, Z27.S
    UADDV   D0, P0, Z17.S
    UADDV   D9, P0, Z3.S
    UADDV   D28, P1, Z8.S
    UADDV   D8, P4, Z25.D
    UADDV   D3, P3, Z21.D
    UADDV   D29, P1, Z31.D
    UADDV   D17, P0, Z3.D
    UADDV   D21, P6, Z19.D
    UADDV   D8, P2, Z17.D
    UADDV   D27, P4, Z28.D
    UADDV   D28, P7, Z14.D
    UADDV   D17, P0, Z21.D
    UADDV   D14, P4, Z8.D
    UADDV   D7, P2, Z28.H
    UADDV   D28, P7, Z0.H
    UADDV   D21, P5, Z10.H
    UADDV   D11, P3, Z7.H
    UADDV   D31, P0, Z28.H
    UADDV   D2, P5, Z14.H
    UADDV   D8, P5, Z2.H
    UADDV   D0, P5, Z27.H
    UADDV   D10, P2, Z31.H
    UADDV   D31, P5, Z17.H
    UMAXV   H22, P1, Z1.H
    UMAXV   H28, P1, Z21.H
    UMAXV   H13, P7, Z9.H
    UMAXV   H3, P2, Z0.H
    UMAXV   H7, P6, Z13.H
    UMAXV   H21, P0, Z5.H
    UMAXV   H11, P3, Z8.H
    UMAXV   H9, P1, Z29.H
    UMAXV   H0, P0, Z21.H
    UMAXV   H21, P3, Z17.H
    UMAXV   B5, P6, Z21.B
    UMAXV   B19, P7, Z21.B
    UMAXV   B17, P6, Z3.B
    UMAXV   B13, P4, Z1.B
    UMAXV   B1, P1, Z17.B
    UMAXV   B17, P7, Z27.B
    UMAXV   B14, P7, Z14.B
    UMAXV   B8, P0, Z1.B
    UMAXV   B3, P7, Z5.B
    UMAXV   B14, P7, Z31.B
    UMAXV   S21, P4, Z14.S
    UMAXV   S5, P6, Z13.S
    UMAXV   S12, P0, Z10.S
    UMAXV   S13, P3, Z12.S
    UMAXV   S11, P2, Z21.S
    UMAXV   S14, P7, Z5.S
    UMAXV   S12, P4, Z3.S
    UMAXV   S26, P2, Z14.S
    UMAXV   S21, P0, Z31.S
    UMAXV   S2, P4, Z17.S
    UMAXV   D28, P3, Z6.D
    UMAXV   D17, P1, Z4.D
    UMAXV   D8, P6, Z28.D
    UMAXV   D11, P4, Z26.D
    UMAXV   D6, P7, Z8.D
    UMAXV   D8, P6, Z21.D
    UMAXV   D21, P1, Z8.D
    UMAXV   D1, P0, Z17.D
    UMAXV   D16, P7, Z3.D
    UMAXV   D27, P5, Z11.D
    UMINV   S31, P1, Z27.S
    UMINV   S10, P6, Z31.S
    UMINV   S3, P5, Z21.S
    UMINV   S31, P3, Z16.S
    UMINV   S1, P4, Z6.S
    UMINV   S11, P7, Z18.S
    UMINV   S31, P4, Z2.S
    UMINV   S2, P0, Z10.S
    UMINV   S4, P5, Z29.S
    UMINV   S17, P6, Z31.S
    UMINV   B14, P7, Z11.B
    UMINV   B28, P5, Z7.B
    UMINV   B11, P2, Z4.B
    UMINV   B6, P5, Z3.B
    UMINV   B21, P2, Z17.B
    UMINV   B18, P3, Z6.B
    UMINV   B28, P5, Z2.B
    UMINV   B17, P2, Z11.B
    UMINV   B21, P5, Z31.B
    UMINV   B16, P1, Z21.B
    UMINV   D7, P3, Z20.D
    UMINV   D0, P4, Z1.D
    UMINV   D4, P7, Z0.D
    UMINV   D30, P0, Z20.D
    UMINV   D20, P6, Z17.D
    UMINV   D0, P3, Z28.D
    UMINV   D28, P7, Z4.D
    UMINV   D17, P4, Z20.D
    UMINV   D31, P6, Z7.D
    UMINV   D7, P5, Z14.D
    UMINV   H21, P3, Z15.H
    UMINV   H15, P0, Z19.H
    UMINV   H1, P1, Z2.H
    UMINV   H14, P6, Z1.H
    UMINV   H29, P6, Z14.H
    UMINV   H1, P0, Z15.H
    UMINV   H4, P2, Z29.H
    UMINV   H25, P5, Z30.H
    UMINV   H2, P2, Z0.H
    UMINV   H20, P0, Z1.H
    MOVZ  X12, #0x1f2, LSL #0
    MOVK  X12, #0x1f8, LSL #16
    MOVK  X12, #0x658b, LSL #32
    MOVK  X12, #0x14db, LSL #48
    SUB  X15, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xcd13, LSL #0
    MOVK  X12, #0xad, LSL #16
    MOVK  X12, #0xef17, LSL #32
    MOVK  X12, #0x863, LSL #48
    SUB  X15, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x11a7, LSL #0
    MOVK  X12, #0xa219, LSL #16
    MOVK  X12, #0x246f, LSL #32
    MOVK  X12, #0x83a0, LSL #48
    SUB  X15, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x85ac, LSL #0
    MOVK  X12, #0xc995, LSL #16
    MOVK  X12, #0xa4ca, LSL #32
    MOVK  X12, #0x80ec, LSL #48
    SUB  X15, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xb980, LSL #0
    MOVK  X12, #0x1a0b, LSL #16
    MOVK  X12, #0xa799, LSL #32
    MOVK  X12, #0x697d, LSL #48
    SUB  X15, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xf849, LSL #0
    MOVK  X12, #0xcb14, LSL #16
    MOVK  X12, #0x1cb3, LSL #32
    MOVK  X12, #0x9ba4, LSL #48
    SUB  X15, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x15f2, LSL #0
    MOVK  X12, #0x7782, LSL #16
    MOVK  X12, #0x38a5, LSL #32
    MOVK  X12, #0x4ab3, LSL #48
    SUB  X15, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x12c1, LSL #0
    MOVK  X12, #0xf486, LSL #16
    MOVK  X12, #0xab9, LSL #32
    MOVK  X12, #0x9ee4, LSL #48
    SUB  X15, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x8fa9, LSL #0
    MOVK  X12, #0x538, LSL #16
    MOVK  X12, #0x25a9, LSL #32
    MOVK  X12, #0xfa22, LSL #48
    SUB  X15, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x76eb, LSL #0
    MOVK  X12, #0x79b5, LSL #16
    MOVK  X12, #0xca2c, LSL #32
    MOVK  X12, #0x9618, LSL #48
    SUB  X15, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xc2d7, LSL #0
    MOVK  X12, #0xb94b, LSL #16
    MOVK  X12, #0xb1e8, LSL #32
    MOVK  X12, #0x5026, LSL #48
    SUB  X15, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xfbd5, LSL #0
    MOVK  X12, #0x6531, LSL #16
    MOVK  X12, #0x611e, LSL #32
    MOVK  X12, #0xdab, LSL #48
    SUB  X15, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xfe35, LSL #0
    MOVK  X12, #0x578a, LSL #16
    MOVK  X12, #0xe725, LSL #32
    MOVK  X12, #0xdda1, LSL #48
    SUB  X15, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x7878, LSL #0
    MOVK  X12, #0xc51f, LSL #16
    MOVK  X12, #0xe516, LSL #32
    MOVK  X12, #0xc2f2, LSL #48
    SUB  X15, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xc826, LSL #0
    MOVK  X12, #0x2189, LSL #16
    MOVK  X12, #0x6ea0, LSL #32
    MOVK  X12, #0x2f4d, LSL #48
    SUB  X15, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x47bb, LSL #0
    MOVK  X12, #0x114, LSL #16
    MOVK  X12, #0xa131, LSL #32
    MOVK  X12, #0x3055, LSL #48
    SUB  X15, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0xefa1, LSL #0
    MOVK  X12, #0x8871, LSL #16
    MOVK  X12, #0x8157, LSL #32
    MOVK  X12, #0xdaed, LSL #48
    SUB  X15, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x61e5, LSL #0
    MOVK  X12, #0xdca5, LSL #16
    MOVK  X12, #0xa1e7, LSL #32
    MOVK  X12, #0x2faf, LSL #48
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x226f, LSL #0
    MOVK  X12, #0xb479, LSL #16
    MOVK  X12, #0x16ba, LSL #32
    MOVK  X12, #0xd617, LSL #48
    SUB  X15, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x94d6, LSL #0
    MOVK  X12, #0x3065, LSL #16
    MOVK  X12, #0x53d1, LSL #32
    MOVK  X12, #0x9baf, LSL #48
    SUB  X15, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveReductionOperations_TestFail
    MRS  X12, FPSR
    MOVZ  X15, #0x91, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D13
    MOVZ  X15, #0xd2ae, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D30
    MOVZ  X15, #0x12c1, LSL #0
    MOVK  X15, #0xf486, LSL #16
    MOVK  X15, #0xab9, LSL #32
    MOVK  X15, #0x9ee4, LSL #48
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FMOV  X12, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P1, Z0.D
    FMOV  X12, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X12, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X12, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X12, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X12, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D5, P7, Z5.D
    FMOV  X12, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X12, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X12, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X12, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X12, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X12, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X12, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X12, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X12, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D14, P1, Z14.D
    FMOV  X12, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X12, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X12, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X12, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X12, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X12, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X12, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X12, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X12, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X12, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D24, P0, Z24.D
    FMOV  X12, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X12, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X12, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X12, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X12, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X12, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X12, D30
    MOVZ  X15, #0x12c1, LSL #0
    MOVK  X15, #0xf486, LSL #16
    MOVK  X15, #0xab9, LSL #32
    MOVK  X15, #0x9ee4, LSL #48
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    FADDV   D31, P6, Z31.D
    FMOV  X12, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveReductionOperations_TestFail
    MOVZ  X2, #0x53b4, LSL #0
    MOVK  X2, #0xddca, LSL #16
    MOVK  X2, #0xd5e7, LSL #32
    MOVK  X2, #0x37b5, LSL #48
    MOVZ  X3, #0x510a, LSL #0
    MOVK  X3, #0x90ca, LSL #16
    MOVK  X3, #0x6a26, LSL #32
    MOVK  X3, #0xa6b3, LSL #48
    MOVZ  X4, #0xb0a8, LSL #0
    MOVK  X4, #0x1332, LSL #16
    MOVK  X4, #0x7169, LSL #32
    MOVK  X4, #0x6679, LSL #48
    MOVZ  X5, #0xdd67, LSL #0
    MOVK  X5, #0x33f1, LSL #16
    MOVK  X5, #0x3eae, LSL #32
    MOVK  X5, #0x22ae, LSL #48
    MOVZ  X6, #0xb6cb, LSL #0
    MOVK  X6, #0x4b52, LSL #16
    MOVK  X6, #0xa99e, LSL #32
    MOVK  X6, #0x5ee9, LSL #48
    MOVZ  X7, #0xf6ab, LSL #0
    MOVK  X7, #0x593d, LSL #16
    MOVK  X7, #0x50b0, LSL #32
    MOVK  X7, #0x33ee, LSL #48
    MOVZ  X8, #0x4be1, LSL #0
    MOVK  X8, #0x3dbe, LSL #16
    MOVK  X8, #0x505e, LSL #32
    MOVK  X8, #0xabd7, LSL #48
    MOVZ  X9, #0xbdd5, LSL #0
    MOVK  X9, #0xd4fb, LSL #16
    MOVK  X9, #0x59ac, LSL #32
    MOVK  X9, #0x3a7, LSL #48
    MOVZ  X10, #0x922d, LSL #0
    MOVK  X10, #0xe218, LSL #16
    MOVK  X10, #0x1f8b, LSL #32
    MOVK  X10, #0x31b3, LSL #48
    MOVZ  X11, #0xc455, LSL #0
    MOVK  X11, #0x2bf1, LSL #16
    MOVK  X11, #0x1258, LSL #32
    MOVK  X11, #0x761f, LSL #48
    MOVZ  X12, #0x8b8e, LSL #0
    MOVK  X12, #0x82d2, LSL #16
    MOVK  X12, #0x85d3, LSL #32
    MOVK  X12, #0xed3a, LSL #48
    MOVZ  X13, #0x4f95, LSL #0
    MOVK  X13, #0x8092, LSL #16
    MOVK  X13, #0xa113, LSL #32
    MOVK  X13, #0xaf6e, LSL #48
    MOVZ  X14, #0x4aa0, LSL #0
    MOVK  X14, #0x6d33, LSL #16
    MOVK  X14, #0xa805, LSL #32
    MOVK  X14, #0x7907, LSL #48
    MOVZ  X15, #0x4416, LSL #0
    MOVK  X15, #0xc286, LSL #16
    MOVK  X15, #0xf1bb, LSL #32
    MOVK  X15, #0xdb4c, LSL #48
    MOVZ  X16, #0xa7b5, LSL #0
    MOVK  X16, #0xe73, LSL #16
    MOVK  X16, #0x3272, LSL #32
    MOVK  X16, #0x7b93, LSL #48
    MOVZ  X17, #0x8313, LSL #0
    MOVK  X17, #0xeab7, LSL #16
    MOVK  X17, #0x3c43, LSL #32
    MOVK  X17, #0xdae1, LSL #48
    MOVZ  X23, #0xbe22, LSL #0
    MOVK  X23, #0x92d0, LSL #16
    MOVK  X23, #0x961b, LSL #32
    MOVK  X23, #0x7bf6, LSL #48
    MOVZ  X24, #0x8ab, LSL #0
    MOVK  X24, #0x3f28, LSL #16
    MOVK  X24, #0x5911, LSL #32
    MOVK  X24, #0x511f, LSL #48
    MOVZ  X25, #0xb9f4, LSL #0
    MOVK  X25, #0xb62c, LSL #16
    MOVK  X25, #0x6f7e, LSL #32
    MOVK  X25, #0x3e21, LSL #48
    MOVZ  X26, #0xe8dd, LSL #0
    MOVK  X26, #0x9919, LSL #16
    MOVK  X26, #0xf775, LSL #32
    MOVK  X26, #0xd89e, LSL #48
    MOVZ  X27, #0x60c0, LSL #0
    MOVK  X27, #0x1083, LSL #16
    MOVK  X27, #0x57d0, LSL #32
    MOVK  X27, #0x7100, LSL #48
    MOVZ  X28, #0xb9f9, LSL #0
    MOVK  X28, #0xcbae, LSL #16
    MOVK  X28, #0xd336, LSL #32
    MOVK  X28, #0xcd51, LSL #48
    MOVZ  X29, #0x3a76, LSL #0
    MOVK  X29, #0x38c, LSL #16
    MOVK  X29, #0x1d7c, LSL #32
    MOVK  X29, #0xd56a, LSL #48
    DUP     Z0.D, X28
    DUP     Z1.D, X29
    DUP     Z2.D, X2
    DUP     Z3.D, X10
    DUP     Z4.D, X26
    DUP     Z5.D, X27
    DUP     Z6.D, X4
    DUP     Z7.D, X28
    DUP     Z8.D, X23
    DUP     Z9.D, X4
    DUP     Z10.D, X8
    DUP     Z11.D, X14
    DUP     Z12.D, X6
    DUP     Z13.D, X14
    DUP     Z14.D, X5
    DUP     Z15.D, X23
    DUP     Z16.D, X4
    DUP     Z17.D, X16
    DUP     Z18.D, X14
    DUP     Z19.D, X16
    DUP     Z20.D, X15
    DUP     Z21.D, X27
    DUP     Z22.D, X14
    DUP     Z23.D, X23
    DUP     Z24.D, X28
    DUP     Z25.D, X24
    DUP     Z26.D, X9
    DUP     Z27.D, X5
    DUP     Z28.D, X13
    DUP     Z29.D, X3
    DUP     Z30.D, X10
    DUP     Z31.D, X24
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X24, #0xa, LSL #0
LCRTSveReductionOperations_label_0:
    ANDV    D6, P4, Z29.D
    FMAXNMV H11, P1, Z23.H
    SADDV   D12, P0, Z23.B
    ORV     S7, P0, Z31.S
    UMAXV   B22, P5, Z11.B
    SADDV   D29, P7, Z7.B
    UMINV   H11, P6, Z29.H
    UMAXV   D25, P4, Z22.D
    ANDV    S23, P2, Z6.S
    SMAXV   B7, P2, Z11.B
    FADDA   S30, P7, S30, Z7.S
    SMAXV   S17, P7, Z19.S
    SMAXV   S16, P4, Z17.S
    UMINV   B27, P5, Z25.B
    SMAXV   B10, P7, Z30.B
    UMAXV   S18, P7, Z27.S
    UADDV   D31, P1, Z25.H
    UMAXV   S26, P5, Z28.S
    FMINNMV S14, P1, Z31.S
    FMAXNMV S19, P6, Z0.S
    SMAXV   H4, P2, Z6.H
    FMAXNMV S15, P7, Z26.S
    FADDV   H16, P3, Z4.H
    FMINV   H14, P3, Z10.H
    ORV     H19, P3, Z12.H
    SMAXV   D23, P2, Z14.D
    UMINV   D28, P5, Z23.D
    SMAXV   D10, P7, Z28.D
    UMAXV   B17, P6, Z12.B
    UADDV   D12, P2, Z10.D
    SADDV   D4, P5, Z12.H
    FADDV   D23, P5, Z21.D
    ORV     H30, P5, Z26.H
    FMINNMV H28, P3, Z19.H
    UMAXV   S25, P3, Z28.S
    SADDV   D26, P3, Z16.B
    FADDA   S30, P4, S30, Z23.S
    EORV    S23, P4, Z7.S
    SMAXV   S27, P5, Z23.S
    FMAXV   S7, P3, Z17.S
    SMINV   S28, P4, Z19.S
    SMINV   S21, P0, Z7.S
    FMINV   S12, P7, Z25.S
    FADDV   S10, P2, Z30.S
    UMINV   B25, P0, Z10.B
    SMAXV   B14, P1, Z25.B
    FADDA   S26, P1, S26, Z12.S
    FMINNMV H25, P1, Z4.H
    ANDV    D23, P2, Z26.D
    FMINNMV H6, P4, Z15.H
    SADDV   D19, P6, Z28.B
    FADDA   S3, P6, S3, Z19.S
    UMAXV   S12, P4, Z27.S
    SMINV   S6, P2, Z12.S
    SADDV   D6, P6, Z23.H
    EORV    D10, P0, Z21.D
    EORV    H19, P4, Z19.H
    UMAXV   B9, P1, Z3.B
    SMAXV   B4, P7, Z21.B
    UADDV   D7, P5, Z10.H
    UADDV   D21, P2, Z6.B
    ANDV    B15, P0, Z4.B
    ANDV    B10, P2, Z25.B
    EORV    S7, P2, Z9.S
    FMINNMV D6, P6, Z9.D
    FMINNMV H4, P1, Z21.H
    ORV     H23, P5, Z3.H
    FMAXNMV S4, P2, Z30.S
    SMINV   H3, P1, Z27.H
    ANDV    S21, P7, Z19.S
    ORV     H21, P1, Z19.H
    SADDV   D19, P5, Z15.S
    ORV     D30, P7, Z4.D
    FMAXNMV H19, P3, Z11.H
    UMINV   S27, P5, Z7.S
    FMINV   S4, P0, Z3.S
    UADDV   D25, P7, Z6.B
    FMINV   H3, P2, Z30.H
    ORV     H11, P0, Z22.H
    SADDV   D24, P2, Z18.S
    UMAXV   S22, P5, Z27.S
    FADDA   H24, P0, H24, Z15.H
    FADDV   S31, P4, Z19.S
    SMAXV   B15, P2, Z11.B
    FADDV   D5, P4, Z3.D
    SADDV   D19, P1, Z10.B
    ANDV    D10, P3, Z31.D
    SMINV   D2, P5, Z22.D
    FMAXV   D6, P3, Z15.D
    FMINNMV H31, P0, Z24.H
    SMINV   D15, P3, Z5.D
    SADDV   D7, P7, Z29.B
    FMAXV   H27, P6, Z2.H
    UMAXV   S19, P6, Z21.S
    UMAXV   B11, P3, Z27.B
    EORV    B31, P4, Z25.B
    FMAXNMV D25, P5, Z31.D
    FMINNMV H21, P5, Z4.H
    UMAXV   B27, P3, Z4.B
    SMAXV   H31, P3, Z18.H
    EORV    H4, P7, Z27.H
    FMAXNMV S2, P1, Z23.S
    UMINV   D5, P7, Z15.D
    UADDV   D4, P3, Z13.H
    SMINV   H22, P1, Z29.H
    FADDA   H10, P0, H10, Z6.H
    FMAXNMV D23, P0, Z13.D
    SADDV   D21, P7, Z4.B
    FMAXV   H27, P3, Z25.H
    ORV     S29, P5, Z20.S
    EORV    S26, P6, Z5.S
    UMAXV   B13, P5, Z11.B
    FMAXNMV D6, P7, Z7.D
    FMAXV   D15, P2, Z22.D
    FMAXV   H4, P2, Z27.H
    SADDV   D22, P1, Z10.B
    FMAXV   H12, P4, Z4.H
    SMAXV   S13, P6, Z21.S
    FMAXNMV S28, P6, Z13.S
    SMINV   S20, P7, Z2.S
    ANDV    S10, P3, Z20.S
    UADDV   D20, P3, Z16.H
    SMINV   B29, P2, Z15.B
    UMINV   D7, P5, Z22.D
    FMAXNMV D2, P7, Z6.D
    ANDV    S15, P1, Z20.S
    FMAXNMV S21, P6, Z23.S
    FADDA   H31, P5, H31, Z7.H
    SMINV   S22, P0, Z29.S
    ORV     H29, P1, Z6.H
    FMAXNMV D30, P3, Z11.D
    UMAXV   H6, P7, Z4.H
    SADDV   D16, P7, Z2.B
    SMINV   S13, P2, Z12.S
    FMINNMV H20, P3, Z31.H
    SMAXV   B7, P2, Z10.B
    FMAXNMV D11, P1, Z22.D
    FADDA   S15, P5, S15, Z20.S
    UMAXV   H2, P7, Z31.H
    FMAXNMV S31, P4, Z2.S
    UMAXV   D31, P4, Z28.D
    FMAXNMV H22, P2, Z21.H
    UADDV   D28, P0, Z31.B
    SMAXV   B21, P3, Z29.B
    ORV     S4, P6, Z1.S
    ORV     B6, P1, Z27.B
    UMINV   D17, P1, Z13.D
    FMINNMV D26, P3, Z4.D
    EORV    D25, P5, Z6.D
    UADDV   D1, P0, Z20.S
    EORV    D20, P4, Z15.D
    FADDA   D1, P5, D1, Z20.D
    UMINV   B4, P4, Z21.B
    EORV    B13, P5, Z26.B
    ANDV    S10, P0, Z25.S
    UMINV   B4, P1, Z7.B
    SADDV   D21, P6, Z18.B
    SMAXV   D10, P1, Z1.D
    UADDV   D31, P0, Z5.D
    EORV    D7, P6, Z30.D
    FMAXV   S23, P7, Z14.S
    UMINV   H5, P2, Z21.H
    UMINV   B29, P7, Z23.B
    FADDV   H6, P4, Z11.H
    UMINV   D2, P0, Z29.D
    EORV    D23, P3, Z21.D
    SMAXV   B25, P6, Z2.B
    ORV     D29, P1, Z14.D
    UADDV   D2, P1, Z28.B
    ORV     B15, P1, Z25.B
    FMAXNMV S29, P5, Z17.S
    SMINV   B28, P2, Z5.B
    SMINV   D31, P6, Z31.D
    SMAXV   D17, P1, Z23.D
    UMINV   D23, P6, Z7.D
    EORV    S27, P4, Z15.S
    ANDV    S8, P2, Z27.S
    SADDV   D11, P5, Z4.S
    EORV    S17, P0, Z2.S
    FMINV   H15, P4, Z29.H
    EORV    D12, P7, Z10.D
    FMINV   S21, P7, Z8.S
    ORV     H2, P6, Z21.H
    FADDA   D15, P2, D15, Z3.D
    FMINNMV D3, P2, Z15.D
    FMINV   D4, P6, Z17.D
    UMAXV   S25, P1, Z14.S
    SMAXV   H30, P7, Z31.H
    FADDA   D28, P7, D28, Z30.D
    FMAXNMV S6, P6, Z21.S
    FMINV   S30, P3, Z12.S
    FMAXV   H10, P1, Z6.H
    UMAXV   H7, P0, Z25.H
    FMINV   D14, P2, Z4.D
    ANDV    B4, P0, Z3.B
    SMAXV   H8, P6, Z17.H
    SMAXV   H5, P4, Z11.H
    FADDA   D4, P0, D4, Z28.D
    FMAXV   D31, P7, Z23.D
    ANDV    B14, P2, Z1.B
    SUBS  X24, X24, #0x1
    B.NE  LCRTSveReductionOperations_label_0
    MOVZ  X14, #0x53b4, LSL #0
    MOVK  X14, #0xddca, LSL #16
    MOVK  X14, #0xd5e7, LSL #32
    MOVK  X14, #0x37b5, LSL #48
    SUB  X9, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x510a, LSL #0
    MOVK  X14, #0x90ca, LSL #16
    MOVK  X14, #0x6a26, LSL #32
    MOVK  X14, #0xa6b3, LSL #48
    SUB  X9, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xb0a8, LSL #0
    MOVK  X14, #0x1332, LSL #16
    MOVK  X14, #0x7169, LSL #32
    MOVK  X14, #0x6679, LSL #48
    SUB  X9, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xdd67, LSL #0
    MOVK  X14, #0x33f1, LSL #16
    MOVK  X14, #0x3eae, LSL #32
    MOVK  X14, #0x22ae, LSL #48
    SUB  X9, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xb6cb, LSL #0
    MOVK  X14, #0x4b52, LSL #16
    MOVK  X14, #0xa99e, LSL #32
    MOVK  X14, #0x5ee9, LSL #48
    SUB  X9, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xf6ab, LSL #0
    MOVK  X14, #0x593d, LSL #16
    MOVK  X14, #0x50b0, LSL #32
    MOVK  X14, #0x33ee, LSL #48
    SUB  X9, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x4be1, LSL #0
    MOVK  X14, #0x3dbe, LSL #16
    MOVK  X14, #0x505e, LSL #32
    MOVK  X14, #0xabd7, LSL #48
    SUB  X9, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x922d, LSL #0
    MOVK  X14, #0xe218, LSL #16
    MOVK  X14, #0x1f8b, LSL #32
    MOVK  X14, #0x31b3, LSL #48
    SUB  X9, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xc455, LSL #0
    MOVK  X14, #0x2bf1, LSL #16
    MOVK  X14, #0x1258, LSL #32
    MOVK  X14, #0x761f, LSL #48
    SUB  X9, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x8b8e, LSL #0
    MOVK  X14, #0x82d2, LSL #16
    MOVK  X14, #0x85d3, LSL #32
    MOVK  X14, #0xed3a, LSL #48
    SUB  X9, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x4f95, LSL #0
    MOVK  X14, #0x8092, LSL #16
    MOVK  X14, #0xa113, LSL #32
    MOVK  X14, #0xaf6e, LSL #48
    SUB  X9, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x4416, LSL #0
    MOVK  X14, #0xc286, LSL #16
    MOVK  X14, #0xf1bb, LSL #32
    MOVK  X14, #0xdb4c, LSL #48
    SUB  X9, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xa7b5, LSL #0
    MOVK  X14, #0xe73, LSL #16
    MOVK  X14, #0x3272, LSL #32
    MOVK  X14, #0x7b93, LSL #48
    SUB  X9, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x8313, LSL #0
    MOVK  X14, #0xeab7, LSL #16
    MOVK  X14, #0x3c43, LSL #32
    MOVK  X14, #0xdae1, LSL #48
    SUB  X9, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xbe22, LSL #0
    MOVK  X14, #0x92d0, LSL #16
    MOVK  X14, #0x961b, LSL #32
    MOVK  X14, #0x7bf6, LSL #48
    SUB  X9, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xb9f4, LSL #0
    MOVK  X14, #0xb62c, LSL #16
    MOVK  X14, #0x6f7e, LSL #32
    MOVK  X14, #0x3e21, LSL #48
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xe8dd, LSL #0
    MOVK  X14, #0x9919, LSL #16
    MOVK  X14, #0xf775, LSL #32
    MOVK  X14, #0xd89e, LSL #48
    SUB  X9, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x60c0, LSL #0
    MOVK  X14, #0x1083, LSL #16
    MOVK  X14, #0x57d0, LSL #32
    MOVK  X14, #0x7100, LSL #48
    SUB  X9, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0xb9f9, LSL #0
    MOVK  X14, #0xcbae, LSL #16
    MOVK  X14, #0xd336, LSL #32
    MOVK  X14, #0xcd51, LSL #48
    SUB  X9, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MRS  X14, FPSR
    MOVZ  X9, #0x91, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X9, #0xb9f9, LSL #0
    MOVK  X9, #0xcbae, LSL #16
    MOVK  X9, #0xd336, LSL #32
    MOVK  X9, #0xcd51, LSL #48
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D0
    MOVZ  X9, #0xb9f9, LSL #0
    MOVK  X9, #0xcbae, LSL #16
    MOVK  X9, #0xd336, LSL #32
    MOVK  X9, #0xcd51, LSL #48
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X14, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P3, Z0.D
    FMOV  X14, D0
    MOVZ  X9, #0xb9f9, LSL #0
    MOVK  X9, #0xcbae, LSL #16
    MOVK  X9, #0xd336, LSL #32
    MOVK  X9, #0xcd71, LSL #48
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X14, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D2, P2, Z2.D
    FMOV  X14, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X14, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X14, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X14, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X14, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X14, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X14, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X14, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X14, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X14, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X14, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X14, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X14, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X14, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D16, P1, Z16.D
    FMOV  X14, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X14, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X14, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X14, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X14, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X14, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X14, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X14, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X14, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D25, P4, Z25.D
    FMOV  X14, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X14, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X14, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X14, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X14, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X14, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X14, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X13
    DUP     Z1.D, X23
    DUP     Z2.D, X28
    DUP     Z3.D, X15
    DUP     Z4.D, X12
    DUP     Z5.D, X7
    DUP     Z6.D, X24
    DUP     Z7.D, X7
    DUP     Z8.D, X27
    DUP     Z9.D, X16
    DUP     Z10.D, X24
    DUP     Z11.D, X29
    DUP     Z12.D, X26
    DUP     Z13.D, X9
    DUP     Z14.D, X25
    DUP     Z15.D, X23
    DUP     Z16.D, X6
    DUP     Z17.D, X29
    DUP     Z18.D, X7
    DUP     Z19.D, X29
    DUP     Z20.D, X29
    DUP     Z21.D, X23
    DUP     Z22.D, X17
    DUP     Z23.D, X29
    DUP     Z24.D, X3
    DUP     Z25.D, X14
    DUP     Z26.D, X17
    DUP     Z27.D, X8
    DUP     Z28.D, X12
    DUP     Z29.D, X28
    DUP     Z30.D, X15
    DUP     Z31.D, X23
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X26, #0xa, LSL #0
LCRTSveReductionOperations_label_1:
    UMAXV   S22, P6, Z3.S
    FADDV   S13, P2, Z6.S
    FADDA   H31, P6, H31, Z9.H
    FMINNMV D17, P1, Z24.D
    UMAXV   B22, P3, Z31.B
    FMAXV   S27, P4, Z22.S
    FMINNMV S16, P7, Z17.S
    UMAXV   H24, P5, Z6.H
    FADDA   D5, P4, D5, Z27.D
    SADDV   D4, P7, Z5.B
    UMINV   H0, P5, Z14.H
    UMINV   D29, P4, Z19.D
    UADDV   D30, P0, Z19.B
    EORV    S21, P4, Z13.S
    SMINV   B14, P1, Z29.B
    SMINV   D2, P3, Z5.D
    FMINNMV S16, P4, Z2.S
    SADDV   D8, P2, Z18.B
    UADDV   D30, P1, Z8.B
    ORV     D3, P3, Z24.D
    SMINV   B2, P0, Z4.B
    UMINV   H17, P5, Z0.H
    ANDV    B31, P2, Z8.B
    EORV    S29, P1, Z26.S
    SMAXV   S27, P0, Z12.S
    SMAXV   S6, P2, Z20.S
    FADDV   H12, P5, Z16.H
    FADDV   S8, P0, Z30.S
    ANDV    B21, P0, Z15.B
    FMAXV   H26, P7, Z27.H
    EORV    D0, P6, Z2.D
    FADDA   D31, P5, D31, Z26.D
    EORV    S18, P6, Z12.S
    EORV    D6, P7, Z18.D
    FMAXV   D30, P2, Z28.D
    SMAXV   D16, P6, Z6.D
    FADDV   H18, P1, Z21.H
    SMINV   D2, P5, Z0.D
    UMINV   B12, P7, Z6.B
    UADDV   D21, P7, Z5.D
    FMAXV   S19, P5, Z8.S
    FMAXV   H24, P4, Z30.H
    ORV     D28, P2, Z24.D
    UADDV   D0, P2, Z31.D
    SADDV   D30, P0, Z12.H
    ANDV    D5, P3, Z17.D
    EORV    S4, P4, Z2.S
    UMAXV   H31, P2, Z4.H
    UMAXV   S21, P2, Z30.S
    UMINV   B2, P7, Z21.B
    FMAXNMV S10, P5, Z2.S
    UADDV   D6, P0, Z15.S
    SMINV   H4, P0, Z28.H
    UADDV   D15, P4, Z26.B
    SMINV   B12, P4, Z15.B
    ORV     B28, P3, Z19.B
    UMAXV   D8, P7, Z31.D
    FADDA   S22, P2, S22, Z12.S
    SMINV   B27, P7, Z30.B
    EORV    S31, P6, Z0.S
    ORV     B31, P6, Z17.B
    FMINNMV S23, P1, Z10.S
    SMINV   S2, P7, Z8.S
    UMAXV   B16, P6, Z28.B
    FMAXNMV S17, P2, Z18.S
    UMAXV   D12, P6, Z22.D
    SMAXV   B28, P1, Z26.B
    SMINV   S0, P4, Z4.S
    EORV    H26, P2, Z17.H
    SMINV   S30, P0, Z31.S
    UADDV   D8, P4, Z26.B
    ORV     D14, P3, Z8.D
    UADDV   D4, P2, Z16.H
    UMAXV   D26, P7, Z23.D
    FMINV   S16, P6, Z17.S
    FMINNMV S9, P7, Z14.S
    FADDA   H0, P7, H0, Z0.H
    FMAXNMV S17, P2, Z4.S
    ORV     H0, P6, Z30.H
    SMAXV   H4, P5, Z21.H
    UMINV   D21, P2, Z9.D
    FMAXV   D15, P2, Z12.D
    FADDV   H4, P2, Z21.H
    SADDV   D22, P3, Z22.S
    UADDV   D8, P0, Z22.S
    FMAXV   H19, P7, Z27.H
    EORV    D9, P3, Z30.D
    UMAXV   S29, P3, Z14.S
    FADDA   H9, P4, H9, Z15.H
    SMINV   S14, P7, Z6.S
    SMAXV   H7, P2, Z5.H
    UMAXV   H22, P7, Z0.H
    FMINV   D31, P1, Z2.D
    SADDV   D6, P2, Z16.B
    SADDV   D16, P0, Z22.B
    SMAXV   B13, P0, Z9.B
    UMAXV   B30, P4, Z6.B
    SMAXV   B20, P7, Z14.B
    UADDV   D10, P5, Z16.D
    ANDV    H15, P3, Z4.H
    FADDV   S21, P3, Z29.S
    FMINV   D2, P0, Z7.D
    SADDV   D9, P2, Z31.B
    FADDA   H15, P6, H15, Z8.H
    FADDA   H1, P7, H1, Z19.H
    FMAXV   S7, P3, Z13.S
    EORV    H19, P1, Z9.H
    SMAXV   H11, P3, Z21.H
    SMAXV   D19, P7, Z19.D
    UADDV   D29, P6, Z30.S
    FMINNMV D16, P4, Z15.D
    FMAXV   S6, P5, Z10.S
    EORV    D8, P1, Z19.D
    FMINNMV H13, P6, Z29.H
    FMAXV   H27, P2, Z1.H
    EORV    B16, P6, Z16.B
    UMAXV   D14, P5, Z8.D
    FADDV   S4, P1, Z7.S
    ORV     D29, P1, Z24.D
    FADDV   D21, P1, Z2.D
    FADDV   H7, P6, Z21.H
    ANDV    H9, P7, Z19.H
    SMAXV   H24, P4, Z7.H
    FMINNMV H1, P0, Z27.H
    FMINNMV S8, P2, Z13.S
    UMINV   D21, P1, Z4.D
    EORV    D2, P5, Z29.D
    FADDA   D1, P6, D1, Z22.D
    FMINNMV D9, P4, Z20.D
    FADDV   D22, P0, Z16.D
    SMAXV   S13, P7, Z24.S
    FMINNMV D20, P5, Z8.D
    FADDV   D20, P5, Z3.D
    FADDV   H24, P2, Z21.H
    UMINV   B29, P4, Z9.B
    EORV    H15, P3, Z9.H
    FMAXV   H16, P1, Z6.H
    ORV     S30, P3, Z24.S
    ANDV    B9, P4, Z29.B
    UADDV   D19, P0, Z30.D
    SMAXV   D29, P4, Z9.D
    FMINNMV S27, P2, Z29.S
    UADDV   D0, P7, Z15.D
    UMAXV   H6, P0, Z20.H
    UMAXV   H23, P2, Z13.H
    SMAXV   D24, P1, Z0.D
    FMAXV   H8, P5, Z24.H
    UMAXV   B29, P7, Z22.B
    FMINV   S8, P3, Z1.S
    UMAXV   H9, P1, Z19.H
    FMAXNMV H13, P2, Z8.H
    SADDV   D31, P5, Z23.S
    FMAXV   D1, P2, Z27.D
    EORV    D31, P2, Z25.D
    UMAXV   S24, P0, Z11.S
    FMINV   D20, P7, Z1.D
    ANDV    H15, P1, Z6.H
    FMAXV   D22, P1, Z15.D
    ORV     D19, P6, Z17.D
    SMINV   D25, P6, Z15.D
    FADDV   H15, P1, Z29.H
    FADDA   H15, P7, H15, Z25.H
    SADDV   D7, P7, Z13.S
    FMINNMV H15, P6, Z2.H
    FMINNMV H17, P1, Z9.H
    UMINV   D23, P2, Z20.D
    FADDV   D8, P6, Z24.D
    UADDV   D31, P5, Z19.S
    ANDV    S25, P4, Z18.S
    FMAXV   D12, P2, Z15.D
    SMAXV   H13, P0, Z17.H
    UMAXV   S6, P5, Z31.S
    SMINV   H0, P2, Z8.H
    FMINV   D9, P6, Z17.D
    FADDV   D8, P2, Z12.D
    FADDA   S4, P7, S4, Z7.S
    UMAXV   H18, P0, Z29.H
    FADDV   S17, P6, Z0.S
    SMAXV   D12, P6, Z8.D
    SMINV   H29, P3, Z9.H
    FMAXNMV H19, P7, Z12.H
    UADDV   D15, P1, Z29.H
    SMAXV   D31, P0, Z23.D
    SADDV   D29, P5, Z11.H
    UMINV   H12, P6, Z19.H
    FMINV   D19, P0, Z29.D
    SMAXV   H9, P0, Z25.H
    UMAXV   B7, P0, Z17.B
    UADDV   D23, P2, Z18.S
    FMINV   H25, P4, Z13.H
    FMAXNMV H17, P3, Z19.H
    FMAXNMV H11, P6, Z15.H
    UADDV   D18, P1, Z31.S
    ANDV    B8, P2, Z13.B
    FADDV   H29, P1, Z7.H
    EORV    B19, P7, Z25.B
    ORV     D17, P1, Z23.D
    EORV    D21, P1, Z18.D
    SADDV   D15, P4, Z6.B
    FMAXNMV H13, P5, Z6.H
    SUBS  X26, X26, #0x1
    B.NE  LCRTSveReductionOperations_label_1
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MRS  X16, FPSR
    MOVZ  X10, #0x91, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P3, Z0.D
    FMOV  X16, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X16, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X16, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X16, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X16, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X16, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D6, P3, Z6.D
    FMOV  X16, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X16, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X16, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X16, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X16, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X16, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X16, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X16, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X16, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X16, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D16, P1, Z16.D
    FMOV  X16, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D17, P0, Z17.D
    FMOV  X16, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X16, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X16, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X16, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X16, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X16, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X16, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X16, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D25, P4, Z25.D
    FMOV  X16, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X16, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X16, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X16, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X16, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X16, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D31, P3, Z31.D
    FMOV  X16, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X26
    DUP     Z1.D, X25
    DUP     Z2.D, X29
    DUP     Z3.D, X27
    DUP     Z4.D, X13
    DUP     Z5.D, X16
    DUP     Z6.D, X28
    DUP     Z7.D, X24
    DUP     Z8.D, X25
    DUP     Z9.D, X17
    DUP     Z10.D, X29
    DUP     Z11.D, X12
    DUP     Z12.D, X12
    DUP     Z13.D, X6
    DUP     Z14.D, X15
    DUP     Z15.D, X24
    DUP     Z16.D, X4
    DUP     Z17.D, X25
    DUP     Z18.D, X26
    DUP     Z19.D, X12
    DUP     Z20.D, X28
    DUP     Z21.D, X15
    DUP     Z22.D, X11
    DUP     Z23.D, X27
    DUP     Z24.D, X28
    DUP     Z25.D, X23
    DUP     Z26.D, X2
    DUP     Z27.D, X17
    DUP     Z28.D, X16
    DUP     Z29.D, X23
    DUP     Z30.D, X8
    DUP     Z31.D, X9
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X8, #0xa, LSL #0
LCRTSveReductionOperations_label_2:
    UADDV   D25, P0, Z20.D
    SADDV   D16, P4, Z25.B
    FMAXV   H12, P2, Z16.H
    UADDV   D29, P0, Z24.H
    SMINV   B13, P5, Z29.B
    FMINV   S17, P6, Z13.S
    ORV     B11, P0, Z12.B
    SMAXV   S28, P7, Z15.S
    UMAXV   D14, P0, Z11.D
    FMINV   H7, P2, Z28.H
    UADDV   D28, P1, Z3.S
    SMAXV   B18, P2, Z28.B
    EORV    S10, P7, Z14.S
    FMINV   D10, P5, Z6.D
    SMINV   B15, P6, Z17.B
    EORV    B30, P3, Z24.B
    FMINNMV D22, P5, Z24.D
    FADDV   D29, P6, Z19.D
    UMINV   D5, P3, Z10.D
    FMINNMV S20, P4, Z22.S
    ANDV    B24, P1, Z5.B
    UMAXV   S12, P6, Z0.S
    ORV     S19, P4, Z29.S
    SADDV   D0, P1, Z18.H
    SADDV   D11, P2, Z30.H
    FMINNMV H10, P5, Z15.H
    UMINV   S5, P3, Z19.S
    ORV     S17, P1, Z17.S
    EORV    H30, P3, Z0.H
    SMINV   D16, P1, Z5.D
    FMAXNMV H29, P4, Z16.H
    UADDV   D5, P3, Z17.B
    FADDA   H11, P6, H11, Z29.H
    SADDV   D3, P6, Z2.H
    FADDV   S19, P1, Z10.S
    FMINV   D29, P0, Z11.D
    EORV    H22, P7, Z19.H
    UADDV   D26, P6, Z7.S
    FADDV   H15, P2, Z28.H
    SADDV   D13, P2, Z25.B
    SMINV   H26, P3, Z5.H
    ANDV    B23, P5, Z22.B
    FADDV   D10, P4, Z24.D
    FMAXV   S16, P7, Z29.S
    FMINNMV S11, P1, Z13.S
    FMAXNMV H0, P4, Z16.H
    SMINV   S22, P3, Z22.S
    ORV     B16, P4, Z23.B
    FMAXV   H28, P0, Z10.H
    EORV    H13, P6, Z26.H
    FMINV   D24, P7, Z17.D
    FMAXV   H25, P1, Z21.H
    FMINV   D17, P7, Z29.D
    EORV    D9, P2, Z13.D
    FMAXNMV D13, P0, Z11.D
    FMAXV   D21, P4, Z0.D
    SMAXV   S23, P4, Z9.S
    FMINNMV S7, P7, Z11.S
    ANDV    B25, P5, Z28.B
    EORV    S12, P6, Z1.S
    SADDV   D16, P4, Z21.B
    FADDA   D24, P3, D24, Z0.D
    FMAXV   H10, P2, Z7.H
    FMAXV   H19, P2, Z12.H
    SMAXV   H26, P1, Z23.H
    FMAXV   H11, P6, Z22.H
    FADDV   H28, P3, Z17.H
    SMINV   S18, P5, Z5.S
    FADDA   S1, P0, S1, Z15.S
    FMAXV   S9, P6, Z28.S
    FMAXV   D5, P6, Z12.D
    ORV     B28, P7, Z16.B
    SMAXV   B0, P2, Z8.B
    FADDA   S1, P7, S1, Z28.S
    SADDV   D7, P2, Z13.B
    FMAXV   H13, P3, Z9.H
    SADDV   D23, P5, Z28.S
    FMINNMV D19, P4, Z23.D
    FADDV   H27, P4, Z0.H
    FMINNMV H9, P3, Z18.H
    ANDV    B28, P5, Z13.B
    SADDV   D18, P0, Z25.S
    ORV     B16, P2, Z19.B
    FMAXV   S8, P0, Z7.S
    UMAXV   S13, P5, Z3.S
    UADDV   D19, P1, Z18.H
    ANDV    B22, P2, Z15.B
    UADDV   D18, P7, Z22.H
    EORV    B15, P3, Z5.B
    SMINV   H3, P6, Z8.H
    SADDV   D12, P6, Z15.S
    FMAXV   D22, P2, Z27.D
    FMAXV   D27, P6, Z19.D
    FADDA   H22, P0, H22, Z0.H
    SADDV   D0, P6, Z28.H
    FMINNMV H9, P1, Z18.H
    FADDA   H13, P3, H13, Z0.H
    UMINV   D28, P3, Z16.D
    FMINNMV S0, P7, Z11.S
    SMINV   S15, P2, Z1.S
    UADDV   D8, P4, Z28.H
    EORV    B25, P0, Z4.B
    FMINNMV S20, P6, Z15.S
    ANDV    D11, P1, Z25.D
    UMAXV   D15, P4, Z8.D
    FADDV   S10, P7, Z12.S
    ANDV    B18, P2, Z9.B
    SMAXV   D16, P7, Z15.D
    FMAXV   S25, P5, Z20.S
    ANDV    S28, P6, Z1.S
    UMINV   B20, P3, Z18.B
    ORV     D11, P5, Z27.D
    UADDV   D7, P0, Z28.S
    EORV    D9, P1, Z24.D
    ANDV    D18, P5, Z20.D
    FMAXNMV H28, P4, Z25.H
    UADDV   D27, P6, Z28.B
    ANDV    D25, P3, Z18.D
    ANDV    S20, P1, Z20.S
    ANDV    S8, P2, Z21.S
    SMAXV   H21, P5, Z16.H
    SMAXV   B15, P3, Z25.B
    FMAXNMV H24, P1, Z10.H
    UADDV   D31, P6, Z21.B
    SMINV   S28, P3, Z11.S
    ANDV    S15, P0, Z18.S
    FADDV   S25, P0, Z31.S
    UMINV   H21, P3, Z8.H
    FMINV   D1, P6, Z21.D
    UADDV   D10, P0, Z14.S
    ORV     B8, P1, Z27.B
    ORV     B29, P3, Z10.B
    UMINV   S27, P7, Z12.S
    SMAXV   H11, P2, Z2.H
    ORV     S10, P5, Z1.S
    FMAXV   H0, P1, Z0.H
    UMINV   H12, P2, Z9.H
    FMAXNMV S16, P4, Z27.S
    UADDV   D14, P0, Z29.D
    FMINV   S21, P6, Z11.S
    SMAXV   D31, P7, Z10.D
    SMINV   S18, P5, Z21.S
    UADDV   D12, P1, Z16.H
    FMINNMV S25, P2, Z12.S
    UMAXV   D2, P6, Z25.D
    ANDV    S21, P4, Z15.S
    FADDA   S21, P2, S21, Z18.S
    FADDA   S14, P5, S14, Z29.S
    SMAXV   S25, P3, Z14.S
    SMINV   D14, P5, Z31.D
    SMINV   B11, P5, Z29.B
    ANDV    B1, P5, Z25.B
    UMAXV   S16, P1, Z1.S
    UADDV   D25, P5, Z16.H
    FMINNMV D27, P7, Z17.D
    FADDV   S12, P2, Z2.S
    FMINV   D15, P2, Z0.D
    EORV    H16, P5, Z12.H
    FMINNMV D2, P1, Z21.D
    ORV     B15, P0, Z8.B
    ANDV    S0, P1, Z15.S
    FMINV   D12, P2, Z26.D
    FADDV   D15, P2, Z12.D
    ANDV    S1, P7, Z18.S
    SMAXV   S11, P6, Z16.S
    FMINNMV S8, P1, Z11.S
    FMINNMV D18, P3, Z16.D
    FADDV   S31, P4, Z18.S
    FMINV   H6, P7, Z25.H
    FMINNMV H24, P0, Z2.H
    FMAXNMV H17, P7, Z20.H
    ANDV    D26, P0, Z14.D
    UMINV   S22, P7, Z24.S
    UMINV   D12, P5, Z15.D
    FMAXV   D14, P1, Z1.D
    SADDV   D24, P4, Z8.S
    EORV    B16, P4, Z20.B
    FMINNMV S20, P2, Z12.S
    SMINV   H12, P3, Z22.H
    ORV     D0, P6, Z21.D
    UMAXV   B11, P6, Z31.B
    FMAXV   H21, P1, Z24.H
    FMAXNMV H14, P1, Z12.H
    UMINV   H2, P5, Z10.H
    ANDV    B28, P7, Z2.B
    SMINV   S31, P1, Z21.S
    FMAXV   D21, P1, Z11.D
    UADDV   D19, P2, Z6.B
    FADDV   S9, P1, Z20.S
    UADDV   D10, P7, Z14.H
    SMAXV   H24, P6, Z28.H
    FMAXV   D8, P7, Z31.D
    SMAXV   B11, P6, Z10.B
    UADDV   D28, P4, Z21.D
    ANDV    S6, P6, Z10.S
    FADDA   S11, P0, S11, Z17.S
    FMAXNMV D20, P0, Z8.D
    SADDV   D16, P2, Z21.B
    ANDV    D10, P4, Z11.D
    SMINV   H17, P2, Z20.H
    SUBS  X8, X8, #0x1
    B.NE  LCRTSveReductionOperations_label_2
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MRS  X9, FPSR
    MOVZ  X25, #0x91, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D4
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D25
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D30
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FMOV  X9, D31
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P6, Z0.D
    FMOV  X9, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X9, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X9, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X9, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X9, D4
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X9, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X9, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X9, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X9, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X9, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X9, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X9, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X9, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X9, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X9, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X9, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X9, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D17, P2, Z17.D
    FMOV  X9, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X9, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X9, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X9, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X9, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D22, P2, Z22.D
    FMOV  X9, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X9, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X9, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X9, D25
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X9, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D27, P4, Z27.D
    FMOV  X9, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X9, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D29, P2, Z29.D
    FMOV  X9, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D30, P0, Z30.D
    FMOV  X9, D30
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X9, D31
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X17
    DUP     Z1.D, X25
    DUP     Z2.D, X16
    DUP     Z3.D, X27
    DUP     Z4.D, X27
    DUP     Z5.D, X28
    DUP     Z6.D, X12
    DUP     Z7.D, X29
    DUP     Z8.D, X15
    DUP     Z9.D, X4
    DUP     Z10.D, X13
    DUP     Z11.D, X27
    DUP     Z12.D, X2
    DUP     Z13.D, X16
    DUP     Z14.D, X4
    DUP     Z15.D, X23
    DUP     Z16.D, X6
    DUP     Z17.D, X2
    DUP     Z18.D, X11
    DUP     Z19.D, X9
    DUP     Z20.D, X8
    DUP     Z21.D, X29
    DUP     Z22.D, X17
    DUP     Z23.D, X4
    DUP     Z24.D, X4
    DUP     Z25.D, X4
    DUP     Z26.D, X5
    DUP     Z27.D, X13
    DUP     Z28.D, X9
    DUP     Z29.D, X10
    DUP     Z30.D, X28
    DUP     Z31.D, X8
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X10, #0xa, LSL #0
LCRTSveReductionOperations_label_3:
    UMINV   S11, P3, Z26.S
    FADDA   D3, P6, D3, Z6.D
    SADDV   D19, P5, Z31.B
    FADDV   S22, P5, Z27.S
    EORV    S3, P2, Z22.S
    FMAXNMV S14, P4, Z5.S
    EORV    S5, P6, Z19.S
    UADDV   D22, P7, Z5.S
    SMAXV   H29, P0, Z3.H
    SMAXV   D5, P5, Z21.D
    UADDV   D31, P5, Z12.D
    UADDV   D10, P5, Z21.H
    ANDV    D7, P1, Z30.D
    UADDV   D19, P2, Z11.D
    FMAXNMV D18, P1, Z14.D
    FMINV   S28, P5, Z31.S
    SMINV   S29, P2, Z22.S
    FMINV   D23, P7, Z22.D
    FADDA   S28, P5, S28, Z23.S
    ORV     D15, P7, Z10.D
    SMINV   H20, P5, Z5.H
    FMINNMV D16, P0, Z20.D
    FMAXNMV D29, P5, Z0.D
    EORV    B30, P7, Z18.B
    ANDV    H31, P5, Z28.H
    UMAXV   B20, P4, Z31.B
    FMINV   S22, P1, Z20.S
    ORV     H11, P5, Z9.H
    UMINV   H3, P0, Z11.H
    FADDV   S30, P4, Z19.S
    SADDV   D18, P2, Z15.S
    EORV    D22, P1, Z7.D
    EORV    S14, P5, Z16.S
    SMINV   D5, P4, Z20.D
    SADDV   D19, P6, Z22.B
    SMAXV   B16, P6, Z19.B
    ORV     S31, P3, Z7.S
    SMAXV   B10, P7, Z5.B
    SADDV   D5, P0, Z30.S
    SMAXV   D7, P1, Z29.D
    FADDV   S9, P6, Z14.S
    UADDV   D20, P1, Z19.B
    SMAXV   B2, P7, Z4.B
    ANDV    D14, P4, Z4.D
    EORV    D28, P6, Z20.D
    SMAXV   S17, P3, Z2.S
    FMAXV   S23, P6, Z9.S
    FMAXV   H0, P3, Z13.H
    FADDA   H31, P6, H31, Z0.H
    SADDV   D29, P5, Z3.B
    ORV     S9, P3, Z31.S
    SMAXV   S13, P6, Z4.S
    FMINV   D4, P3, Z15.D
    UMAXV   H22, P0, Z27.H
    FMAXV   H19, P3, Z29.H
    EORV    D30, P0, Z16.D
    UADDV   D2, P7, Z10.H
    ANDV    B18, P1, Z19.B
    SMINV   S31, P4, Z22.S
    FADDA   S2, P6, S2, Z21.S
    FMINNMV H0, P7, Z14.H
    SMINV   S29, P1, Z26.S
    FADDA   S0, P1, S0, Z16.S
    UMAXV   H3, P3, Z4.H
    SMINV   S27, P5, Z28.S
    FADDV   D20, P0, Z17.D
    SMINV   S17, P7, Z3.S
    EORV    B31, P6, Z7.B
    FMAXNMV S9, P0, Z13.S
    UMAXV   B7, P4, Z2.B
    FMAXV   D4, P3, Z0.D
    FMAXNMV H3, P0, Z9.H
    FADDA   S29, P7, S29, Z17.S
    SADDV   D26, P7, Z27.H
    FMAXV   H22, P3, Z23.H
    UMAXV   S16, P6, Z31.S
    ORV     B19, P1, Z4.B
    ANDV    H28, P1, Z3.H
    FMINV   S2, P5, Z7.S
    FADDV   S17, P0, Z22.S
    UADDV   D28, P5, Z20.H
    FMAXV   S0, P4, Z11.S
    UADDV   D3, P4, Z16.H
    FMINNMV S9, P6, Z3.S
    UADDV   D4, P1, Z17.D
    FADDA   H9, P0, H9, Z22.H
    SADDV   D17, P6, Z26.B
    FMAXV   S22, P2, Z19.S
    UMAXV   S19, P0, Z4.S
    UADDV   D19, P5, Z9.D
    SMINV   S26, P1, Z22.S
    ORV     S16, P5, Z2.S
    SMAXV   B7, P2, Z0.B
    ANDV    H3, P2, Z28.H
    ANDV    S31, P1, Z9.S
    FMAXV   D0, P7, Z21.D
    EORV    H28, P3, Z3.H
    FMINNMV H22, P1, Z28.H
    UMINV   S20, P1, Z10.S
    SMAXV   S2, P7, Z16.S
    EORV    B3, P7, Z22.B
    UMAXV   B23, P7, Z2.B
    FADDA   D23, P4, D23, Z23.D
    FADDV   S26, P1, Z17.S
    FMAXNMV S10, P7, Z23.S
    UADDV   D2, P5, Z31.H
    UADDV   D4, P5, Z24.D
    EORV    D9, P4, Z19.D
    UMINV   S23, P7, Z4.S
    FMINV   H0, P3, Z9.H
    FADDV   S21, P2, Z0.S
    UMAXV   H21, P4, Z7.H
    SMINV   S7, P0, Z21.S
    FMINNMV D16, P6, Z1.D
    EORV    D23, P0, Z1.D
    ORV     B4, P7, Z20.B
    SMINV   H12, P5, Z7.H
    ANDV    S31, P2, Z30.S
    FMAXV   H21, P6, Z4.H
    SADDV   D24, P1, Z16.S
    SMINV   S4, P2, Z23.S
    EORV    D7, P1, Z26.D
    FMAXNMV S0, P7, Z4.S
    UMAXV   S19, P1, Z0.S
    FMAXNMV S20, P6, Z2.S
    FMINNMV S9, P4, Z7.S
    SADDV   D0, P1, Z31.S
    EORV    D9, P7, Z3.D
    ORV     D2, P6, Z11.D
    FMAXNMV S4, P2, Z31.S
    SMINV   B31, P5, Z21.B
    SMINV   H25, P3, Z20.H
    ORV     B20, P2, Z4.B
    ANDV    H21, P4, Z19.H
    FADDA   H24, P4, H24, Z31.H
    SMAXV   B0, P7, Z12.B
    FADDA   H24, P3, H24, Z20.H
    UMAXV   S21, P3, Z21.S
    ANDV    B20, P2, Z25.B
    UADDV   D7, P2, Z0.D
    ANDV    B1, P6, Z21.B
    UMINV   D3, P7, Z7.D
    FADDA   D1, P1, D1, Z30.D
    FADDV   H30, P6, Z2.H
    SADDV   D0, P1, Z1.S
    SMINV   D3, P4, Z20.D
    UMAXV   S12, P1, Z27.S
    SADDV   D19, P5, Z26.S
    UMAXV   D16, P2, Z2.D
    FMINNMV S1, P5, Z3.S
    FADDA   D24, P1, D24, Z26.D
    FADDA   D8, P3, D8, Z30.D
    SMAXV   D25, P3, Z29.D
    SMINV   S27, P3, Z25.S
    FADDV   D2, P0, Z12.D
    UMAXV   S8, P0, Z12.S
    SMAXV   S20, P3, Z1.S
    UMINV   B7, P0, Z7.B
    UADDV   D25, P3, Z24.S
    FADDA   D19, P5, D19, Z24.D
    ORV     D1, P4, Z2.D
    FMINV   S29, P6, Z8.S
    FMINV   H2, P1, Z24.H
    SMINV   H20, P6, Z27.H
    SMAXV   S27, P2, Z2.S
    EORV    B27, P1, Z14.B
    FADDA   H16, P5, H16, Z7.H
    FADDV   H8, P3, Z29.H
    SMAXV   S30, P6, Z0.S
    SMAXV   H29, P1, Z27.H
    UMINV   S18, P1, Z16.S
    SMINV   H13, P1, Z4.H
    FADDV   D2, P3, Z8.D
    FADDA   H20, P1, H20, Z2.H
    FMINV   S16, P7, Z18.S
    UADDV   D7, P7, Z4.H
    UADDV   D0, P4, Z29.H
    UMAXV   D11, P7, Z7.D
    ANDV    S29, P0, Z20.S
    ORV     B8, P3, Z29.B
    EORV    D27, P7, Z30.D
    FMAXV   H4, P6, Z8.H
    FMAXV   S17, P2, Z21.S
    UADDV   D8, P2, Z14.S
    SMINV   B7, P1, Z8.B
    SADDV   D21, P3, Z16.H
    EORV    B30, P2, Z17.B
    SADDV   D29, P1, Z9.B
    FADDA   S11, P6, S11, Z24.S
    SMAXV   B24, P5, Z19.B
    FMAXV   H28, P0, Z19.H
    ORV     D14, P7, Z23.D
    EORV    H2, P3, Z0.H
    UMAXV   S0, P5, Z24.S
    ORV     S20, P6, Z11.S
    ANDV    S16, P6, Z30.S
    EORV    H17, P5, Z13.H
    EORV    B9, P7, Z16.B
    FMAXV   D19, P5, Z0.D
    UMAXV   B13, P6, Z23.B
    SUBS  X10, X10, #0x1
    B.NE  LCRTSveReductionOperations_label_3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MRS  X29, FPSR
    MOVZ  X9, #0x91, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D6
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X29, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X29, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X29, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X29, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D3, P4, Z3.D
    FMOV  X29, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X29, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X29, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D6, P2, Z6.D
    FMOV  X29, D6
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a7a, LSL #48
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X29, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D8, P3, Z8.D
    FMOV  X29, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X29, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X29, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X29, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X29, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D13, P3, Z13.D
    FMOV  X29, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X29, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D15, P2, Z15.D
    FMOV  X29, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X29, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X29, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X29, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X29, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D20, P5, Z20.D
    FMOV  X29, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X29, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X29, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X29, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X29, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X29, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X29, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X29, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D28, P3, Z28.D
    FMOV  X29, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X29, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X29, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X29, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X25
    DUP     Z1.D, X7
    DUP     Z2.D, X27
    DUP     Z3.D, X12
    DUP     Z4.D, X28
    DUP     Z5.D, X29
    DUP     Z6.D, X26
    DUP     Z7.D, X17
    DUP     Z8.D, X6
    DUP     Z9.D, X17
    DUP     Z10.D, X11
    DUP     Z11.D, X5
    DUP     Z12.D, X3
    DUP     Z13.D, X16
    DUP     Z14.D, X28
    DUP     Z15.D, X7
    DUP     Z16.D, X7
    DUP     Z17.D, X3
    DUP     Z18.D, X3
    DUP     Z19.D, X17
    DUP     Z20.D, X6
    DUP     Z21.D, X4
    DUP     Z22.D, X5
    DUP     Z23.D, X12
    DUP     Z24.D, X4
    DUP     Z25.D, X3
    DUP     Z26.D, X13
    DUP     Z27.D, X4
    DUP     Z28.D, X2
    DUP     Z29.D, X28
    DUP     Z30.D, X5
    DUP     Z31.D, X25
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X2, #0xa, LSL #0
LCRTSveReductionOperations_label_4:
    UMINV   S6, P3, Z18.S
    SMAXV   D0, P7, Z2.D
    EORV    S15, P5, Z26.S
    UMINV   H11, P2, Z0.H
    UADDV   D25, P6, Z6.H
    EORV    H25, P4, Z30.H
    UMINV   B7, P3, Z25.B
    SMAXV   B18, P1, Z11.B
    ANDV    H23, P0, Z18.H
    FMINV   D23, P1, Z2.D
    SMAXV   H19, P5, Z15.H
    FMINV   D4, P5, Z7.D
    UMINV   B26, P7, Z19.B
    UADDV   D6, P1, Z23.D
    ORV     S13, P6, Z21.S
    UADDV   D22, P1, Z1.B
    ORV     D14, P7, Z2.D
    EORV    D26, P3, Z13.D
    SADDV   D22, P3, Z0.B
    UMINV   B12, P5, Z4.B
    SADDV   D25, P1, Z7.B
    UMINV   S30, P6, Z26.S
    ORV     H4, P7, Z6.H
    UMAXV   S13, P5, Z22.S
    FMAXV   D19, P3, Z14.D
    UADDV   D2, P1, Z4.H
    FMAXNMV D22, P4, Z12.D
    UMAXV   S26, P5, Z13.S
    SMINV   B13, P4, Z10.B
    UMAXV   B15, P4, Z28.B
    ORV     D0, P2, Z25.D
    UMAXV   H4, P6, Z26.H
    FMINV   S18, P3, Z15.S
    ANDV    S19, P3, Z18.S
    SMINV   D5, P7, Z0.D
    FMAXNMV H15, P5, Z19.H
    SADDV   D19, P1, Z22.S
    SMINV   D25, P3, Z5.D
    FMAXV   S10, P7, Z2.S
    ANDV    S18, P3, Z19.S
    EORV    B14, P0, Z3.B
    FMAXV   H3, P7, Z17.H
    ORV     H6, P0, Z25.H
    SMAXV   D13, P7, Z26.D
    EORV    H11, P0, Z14.H
    ANDV    H19, P6, Z30.H
    FMAXNMV H5, P1, Z13.H
    SADDV   D13, P1, Z12.B
    UMINV   H13, P5, Z18.H
    SADDV   D14, P7, Z10.H
    EORV    B31, P4, Z15.B
    ORV     B26, P7, Z14.B
    UMINV   D18, P6, Z19.D
    EORV    B30, P1, Z3.B
    ORV     S19, P0, Z24.S
    UADDV   D24, P3, Z4.S
    FADDA   H11, P2, H11, Z13.H
    FADDA   H31, P0, H31, Z21.H
    FADDV   S10, P5, Z19.S
    ORV     B29, P0, Z24.B
    FMAXNMV D4, P3, Z29.D
    SMINV   B13, P6, Z9.B
    SMAXV   D8, P4, Z4.D
    UMAXV   D4, P2, Z18.D
    FADDA   H10, P7, H10, Z4.H
    UMINV   D21, P7, Z26.D
    ORV     H19, P1, Z30.H
    SMINV   B12, P5, Z29.B
    SMINV   B11, P3, Z13.B
    SMINV   S3, P2, Z12.S
    FMAXNMV H12, P6, Z31.H
    SMINV   B18, P1, Z21.B
    EORV    B30, P2, Z3.B
    UMINV   B24, P6, Z8.B
    EORV    D14, P4, Z22.D
    FMINNMV S21, P1, Z14.S
    UMINV   B26, P0, Z21.B
    FADDA   H11, P1, H11, Z30.H
    SMINV   S15, P5, Z18.S
    UADDV   D0, P1, Z10.B
    FMAXV   H21, P1, Z0.H
    FADDV   S31, P6, Z15.S
    UMINV   B22, P4, Z11.B
    UMAXV   B4, P5, Z12.B
    SMINV   H13, P3, Z19.H
    FMINNMV D29, P1, Z21.D
    FMINNMV S14, P4, Z6.S
    SADDV   D28, P3, Z24.B
    ORV     S9, P3, Z12.S
    ORV     S19, P1, Z26.S
    SADDV   D10, P5, Z9.H
    ANDV    B23, P3, Z14.B
    ORV     H26, P2, Z10.H
    EORV    B9, P3, Z28.B
    FADDA   D19, P3, D19, Z4.D
    FADDA   H15, P1, H15, Z16.H
    EORV    D24, P1, Z22.D
    EORV    B10, P7, Z26.B
    UMAXV   D12, P7, Z16.D
    EORV    H21, P3, Z9.H
    FADDV   H21, P0, Z19.H
    FADDA   D24, P5, D24, Z18.D
    UMINV   H19, P1, Z1.H
    ORV     H18, P7, Z23.H
    UMAXV   H23, P2, Z24.H
    SMAXV   H2, P3, Z19.H
    ORV     S6, P4, Z30.S
    SMINV   S16, P6, Z12.S
    SMINV   D28, P2, Z23.D
    UMAXV   D30, P5, Z18.D
    SMINV   H1, P1, Z19.H
    SMINV   B22, P4, Z1.B
    FMINNMV D26, P4, Z30.D
    ORV     H23, P2, Z27.H
    SADDV   D1, P7, Z21.S
    UMAXV   H30, P2, Z16.H
    SMINV   S21, P5, Z3.S
    FADDV   D9, P7, Z17.D
    EORV    H12, P1, Z9.H
    SMAXV   D9, P3, Z10.D
    SADDV   D16, P1, Z15.S
    UADDV   D10, P0, Z1.H
    ANDV    H10, P7, Z23.H
    SMINV   B17, P3, Z26.B
    FMAXNMV D3, P2, Z2.D
    FMAXV   S26, P2, Z17.S
    UMAXV   D18, P6, Z22.D
    SADDV   D1, P1, Z28.H
    FMINV   S19, P7, Z16.S
    UMAXV   S21, P2, Z1.S
    ANDV    B29, P5, Z18.B
    UADDV   D18, P5, Z30.S
    FMAXV   H26, P5, Z10.H
    EORV    H16, P4, Z6.H
    EORV    H6, P6, Z3.H
    FMAXNMV S28, P0, Z23.S
    FMINNMV S17, P5, Z6.S
    ANDV    D22, P6, Z16.D
    FADDA   H5, P2, H5, Z29.H
    ORV     B3, P6, Z26.B
    FMAXNMV D27, P1, Z5.D
    SMINV   H15, P5, Z22.H
    SMINV   H23, P4, Z18.H
    EORV    D5, P1, Z3.D
    UADDV   D2, P4, Z21.S
    EORV    D26, P1, Z12.D
    EORV    S16, P3, Z28.S
    UMINV   D10, P1, Z19.D
    ORV     H6, P0, Z31.H
    FMINNMV H1, P3, Z4.H
    SMAXV   S0, P5, Z19.S
    FMAXV   S17, P5, Z15.S
    EORV    B6, P5, Z6.B
    SMINV   D15, P3, Z23.D
    FMAXNMV S18, P6, Z2.S
    EORV    H30, P4, Z26.H
    ORV     H21, P6, Z27.H
    EORV    D23, P0, Z29.D
    FADDV   D2, P7, Z27.D
    UMINV   S27, P4, Z10.S
    UADDV   D6, P1, Z13.B
    ANDV    B29, P3, Z23.B
    ORV     B19, P5, Z30.B
    EORV    S10, P4, Z19.S
    FMAXV   S21, P5, Z29.S
    FMAXNMV H23, P7, Z2.H
    SMINV   D28, P5, Z15.D
    SMAXV   B22, P5, Z10.B
    EORV    S4, P7, Z27.S
    FMAXV   S29, P5, Z1.S
    EORV    B26, P1, Z6.B
    UMAXV   S18, P1, Z10.S
    UMAXV   D26, P1, Z23.D
    SMINV   H2, P2, Z26.H
    FMINV   H1, P3, Z22.H
    FMINNMV H11, P1, Z28.H
    UADDV   D22, P7, Z12.S
    FMINV   H22, P2, Z19.H
    EORV    H14, P0, Z8.H
    SMAXV   S10, P6, Z18.S
    FMINNMV H19, P2, Z22.H
    FMINNMV D21, P0, Z29.D
    FADDV   H30, P7, Z19.H
    FMAXV   S27, P0, Z21.S
    FMINNMV H6, P2, Z12.H
    SADDV   D16, P5, Z4.S
    FMAXV   D23, P7, Z16.D
    FMAXNMV S12, P3, Z15.S
    UMAXV   H15, P7, Z16.H
    UMAXV   D0, P3, Z3.D
    ANDV    B28, P4, Z15.B
    FMAXV   S18, P0, Z3.S
    SADDV   D29, P3, Z7.H
    UADDV   D12, P7, Z28.H
    ORV     D20, P0, Z18.D
    UMINV   B4, P5, Z20.B
    UMAXV   H18, P6, Z28.H
    EORV    S19, P2, Z18.S
    EORV    B7, P4, Z18.B
    ORV     D16, P4, Z19.D
    SUBS  X2, X2, #0x1
    B.NE  LCRTSveReductionOperations_label_4
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MRS  X27, FPSR
    MOVZ  X24, #0x91, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FMOV  X27, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P1, Z0.D
    FMOV  X27, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X27, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X27, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D3, P6, Z3.D
    FMOV  X27, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X27, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X27, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D6, P7, Z6.D
    FMOV  X27, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X27, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D8, P3, Z8.D
    FMOV  X27, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X27, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D10, P4, Z10.D
    FMOV  X27, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D11, P3, Z11.D
    FMOV  X27, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X27, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X27, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D14, P7, Z14.D
    FMOV  X27, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X27, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X27, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X27, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X27, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D19, P0, Z19.D
    FMOV  X27, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X27, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D21, P4, Z21.D
    FMOV  X27, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X27, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X27, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X27, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X27, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X27, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X27, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X27, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X27, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X27, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    FADDV   D31, P7, Z31.D
    FMOV  X27, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X2, #0x9aee, LSL #0
    MOVK  X2, #0x372e, LSL #16
    MOVK  X2, #0x751d, LSL #32
    MOVK  X2, #0xcbc6, LSL #48
    MOVZ  X3, #0x1cb6, LSL #0
    MOVK  X3, #0x54ae, LSL #16
    MOVK  X3, #0xa0ca, LSL #32
    MOVK  X3, #0x618a, LSL #48
    MOVZ  X4, #0x2657, LSL #0
    MOVK  X4, #0xb2ec, LSL #16
    MOVK  X4, #0x875b, LSL #32
    MOVK  X4, #0xb3b8, LSL #48
    MOVZ  X5, #0x3d1, LSL #0
    MOVK  X5, #0x9206, LSL #16
    MOVK  X5, #0x161a, LSL #32
    MOVK  X5, #0x62c1, LSL #48
    MOVZ  X6, #0xd69, LSL #0
    MOVK  X6, #0x184c, LSL #16
    MOVK  X6, #0xecd4, LSL #32
    MOVK  X6, #0xf9b6, LSL #48
    MOVZ  X7, #0x7303, LSL #0
    MOVK  X7, #0x5473, LSL #16
    MOVK  X7, #0xd942, LSL #32
    MOVK  X7, #0x90c, LSL #48
    MOVZ  X8, #0xcaca, LSL #0
    MOVK  X8, #0x72dd, LSL #16
    MOVK  X8, #0x7550, LSL #32
    MOVK  X8, #0xc0e3, LSL #48
    MOVZ  X9, #0x81e8, LSL #0
    MOVK  X9, #0x6b15, LSL #16
    MOVK  X9, #0x257, LSL #32
    MOVK  X9, #0x241e, LSL #48
    MOVZ  X10, #0x316d, LSL #0
    MOVK  X10, #0xee17, LSL #16
    MOVK  X10, #0xf6db, LSL #32
    MOVK  X10, #0xfa26, LSL #48
    MOVZ  X11, #0x5c46, LSL #0
    MOVK  X11, #0xf955, LSL #16
    MOVK  X11, #0x9e21, LSL #32
    MOVK  X11, #0x35b4, LSL #48
    MOVZ  X12, #0x3a8, LSL #0
    MOVK  X12, #0xdbdd, LSL #16
    MOVK  X12, #0x59af, LSL #32
    MOVK  X12, #0xfd6e, LSL #48
    MOVZ  X13, #0x10c8, LSL #0
    MOVK  X13, #0x1d1, LSL #16
    MOVK  X13, #0x235a, LSL #32
    MOVK  X13, #0xbe8b, LSL #48
    MOVZ  X14, #0xc1d0, LSL #0
    MOVK  X14, #0x1100, LSL #16
    MOVK  X14, #0x5194, LSL #32
    MOVK  X14, #0x514e, LSL #48
    MOVZ  X15, #0xb49e, LSL #0
    MOVK  X15, #0xfc02, LSL #16
    MOVK  X15, #0xc671, LSL #32
    MOVK  X15, #0xa96a, LSL #48
    MOVZ  X16, #0x7a0d, LSL #0
    MOVK  X16, #0xc177, LSL #16
    MOVK  X16, #0x1d46, LSL #32
    MOVK  X16, #0xeaf, LSL #48
    MOVZ  X17, #0x7e87, LSL #0
    MOVK  X17, #0x1f1e, LSL #16
    MOVK  X17, #0xe17b, LSL #32
    MOVK  X17, #0x885b, LSL #48
    MOVZ  X23, #0xfd5b, LSL #0
    MOVK  X23, #0xfc0, LSL #16
    MOVK  X23, #0x60e0, LSL #32
    MOVK  X23, #0x62d8, LSL #48
    MOVZ  X24, #0xb711, LSL #0
    MOVK  X24, #0xc037, LSL #16
    MOVK  X24, #0x5226, LSL #32
    MOVK  X24, #0xe13e, LSL #48
    MOVZ  X25, #0xfec9, LSL #0
    MOVK  X25, #0xc00, LSL #16
    MOVK  X25, #0x73d, LSL #32
    MOVK  X25, #0xf69e, LSL #48
    MOVZ  X26, #0x639b, LSL #0
    MOVK  X26, #0x496e, LSL #16
    MOVK  X26, #0xd1c5, LSL #32
    MOVK  X26, #0x135f, LSL #48
    MOVZ  X27, #0x6e28, LSL #0
    MOVK  X27, #0xc188, LSL #16
    MOVK  X27, #0xf9da, LSL #32
    MOVK  X27, #0x3861, LSL #48
    MOVZ  X28, #0xe119, LSL #0
    MOVK  X28, #0xb947, LSL #16
    MOVK  X28, #0x993a, LSL #32
    MOVK  X28, #0x1306, LSL #48
    MOVZ  X29, #0x4f97, LSL #0
    MOVK  X29, #0xd9f, LSL #16
    MOVK  X29, #0xac3a, LSL #32
    MOVK  X29, #0x4da6, LSL #48
    DUP     Z0.D, X15
    DUP     Z1.D, X28
    DUP     Z2.D, X29
    DUP     Z3.D, X27
    DUP     Z4.D, X6
    DUP     Z5.D, X26
    DUP     Z6.D, X9
    DUP     Z7.D, X13
    DUP     Z8.D, X14
    DUP     Z9.D, X5
    DUP     Z10.D, X7
    DUP     Z11.D, X3
    DUP     Z12.D, X4
    DUP     Z13.D, X27
    DUP     Z14.D, X3
    DUP     Z15.D, X26
    DUP     Z16.D, X27
    DUP     Z17.D, X7
    DUP     Z18.D, X9
    DUP     Z19.D, X28
    DUP     Z20.D, X5
    DUP     Z21.D, X4
    DUP     Z22.D, X23
    DUP     Z23.D, X14
    DUP     Z24.D, X3
    DUP     Z25.D, X11
    DUP     Z26.D, X2
    DUP     Z27.D, X28
    DUP     Z28.D, X3
    DUP     Z29.D, X3
    DUP     Z30.D, X6
    DUP     Z31.D, X3
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X26, #0xa, LSL #0
LCRTSveReductionOperations_label_5:
    FMINNMV D20, P5, Z25.D
    UMAXV   H8, P4, Z28.H
    ANDV    H19, P6, Z31.H
    UMAXV   B30, P0, Z20.B
    UMINV   S3, P3, Z24.S
    ANDV    B31, P7, Z8.B
    UMINV   D14, P0, Z31.D
    UMAXV   D1, P2, Z3.D
    SMAXV   B8, P1, Z29.B
    FMINNMV D3, P2, Z20.D
    UMINV   D23, P0, Z19.D
    ANDV    S28, P4, Z14.S
    UADDV   D1, P5, Z23.B
    SMINV   D30, P5, Z27.D
    FMINNMV H17, P0, Z13.H
    SMAXV   D0, P4, Z8.D
    FADDA   S5, P2, S5, Z17.S
    FMINV   D8, P5, Z1.D
    ANDV    S26, P2, Z29.S
    UMINV   D19, P0, Z8.D
    ORV     S18, P3, Z7.S
    EORV    H4, P4, Z12.H
    FMAXV   D19, P5, Z18.D
    UMAXV   D18, P2, Z5.D
    EORV    H8, P4, Z8.H
    SADDV   D5, P6, Z26.H
    SMAXV   B12, P0, Z8.B
    ORV     H27, P3, Z18.H
    UADDV   D29, P0, Z27.D
    SMINV   S17, P6, Z13.S
    FMAXNMV S27, P5, Z30.S
    FMAXV   D23, P6, Z0.D
    FADDV   S7, P2, Z16.S
    ANDV    S8, P1, Z19.S
    FMAXV   D1, P1, Z7.D
    EORV    D19, P0, Z8.D
    ORV     B12, P6, Z30.B
    SADDV   D15, P1, Z5.B
    EORV    D16, P2, Z17.D
    ANDV    S26, P3, Z11.S
    SMINV   B17, P0, Z19.B
    EORV    H0, P0, Z27.H
    UMAXV   H19, P4, Z12.H
    EORV    H19, P1, Z15.H
    SMINV   H13, P2, Z3.H
    SMAXV   S30, P5, Z17.S
    UADDV   D8, P6, Z26.D
    FMINNMV S17, P7, Z4.S
    FMINV   D27, P5, Z19.D
    UADDV   D11, P3, Z17.B
    FMINV   H4, P6, Z13.H
    EORV    H3, P4, Z29.H
    UADDV   D13, P3, Z27.S
    UMINV   B7, P1, Z0.B
    FMINNMV S12, P3, Z8.S
    UADDV   D0, P6, Z11.H
    UMAXV   B17, P6, Z4.B
    FMAXV   H25, P1, Z12.H
    UMAXV   B19, P3, Z0.B
    UADDV   D0, P7, Z1.D
    UMAXV   S26, P0, Z0.S
    UMAXV   H24, P2, Z17.H
    SADDV   D0, P2, Z1.S
    SADDV   D1, P6, Z7.S
    UMAXV   S27, P7, Z13.S
    SMINV   B13, P4, Z13.B
    FMAXV   S23, P5, Z1.S
    FMAXV   S4, P6, Z26.S
    UMINV   B15, P0, Z14.B
    EORV    B8, P3, Z19.B
    FADDV   D14, P6, Z6.D
    FADDV   H11, P1, Z21.H
    SMINV   B19, P5, Z4.B
    UMINV   D17, P7, Z8.D
    FMINNMV S7, P5, Z27.S
    UMINV   H29, P1, Z24.H
    UMINV   B6, P5, Z7.B
    FMAXV   S21, P0, Z23.S
    ANDV    D23, P7, Z13.D
    SMINV   H4, P6, Z29.H
    FMINNMV D24, P5, Z15.D
    FMAXNMV S7, P7, Z24.S
    FADDA   H7, P7, H7, Z28.H
    UMINV   H24, P1, Z18.H
    EORV    B14, P7, Z7.B
    ANDV    D28, P1, Z23.D
    SMAXV   H8, P2, Z24.H
    SMAXV   H23, P6, Z17.H
    SADDV   D27, P3, Z8.B
    UMINV   H18, P2, Z11.H
    FMINV   S11, P1, Z10.S
    SMAXV   S29, P2, Z18.S
    FADDV   H29, P1, Z9.H
    FMINNMV S5, P6, Z1.S
    EORV    D9, P0, Z3.D
    SADDV   D18, P7, Z21.S
    ANDV    H8, P4, Z11.H
    FADDA   H28, P3, H28, Z8.H
    ORV     B13, P6, Z23.B
    FMINNMV S29, P3, Z5.S
    FMAXV   H24, P0, Z29.H
    FMAXV   D19, P5, Z27.D
    ANDV    S7, P1, Z14.S
    FADDV   D11, P2, Z19.D
    UMINV   D27, P3, Z29.D
    SADDV   D14, P5, Z28.H
    UADDV   D17, P4, Z19.S
    ORV     D23, P5, Z13.D
    UMINV   D15, P2, Z30.D
    FADDA   H24, P5, H24, Z4.H
    EORV    B21, P0, Z1.B
    UMINV   B25, P2, Z9.B
    FMINNMV D19, P0, Z25.D
    EORV    D25, P1, Z30.D
    SMINV   H10, P6, Z17.H
    UMINV   S1, P5, Z11.S
    SMINV   S13, P5, Z7.S
    FMAXV   D28, P2, Z24.D
    FADDV   H30, P0, Z25.H
    UMINV   B11, P1, Z30.B
    UADDV   D25, P3, Z13.D
    SMAXV   D17, P5, Z18.D
    SADDV   D21, P3, Z25.B
    SMINV   B22, P7, Z31.B
    ANDV    S24, P5, Z2.S
    SMAXV   B2, P3, Z15.B
    FMAXV   S13, P1, Z22.S
    ANDV    S31, P2, Z14.S
    SADDV   D24, P2, Z3.B
    ORV     B15, P5, Z28.B
    SMAXV   H4, P6, Z10.H
    FMINV   D3, P7, Z19.D
    FADDA   H24, P7, H24, Z0.H
    UADDV   D10, P2, Z2.D
    UADDV   D25, P2, Z17.D
    SMAXV   H14, P7, Z21.H
    EORV    D0, P7, Z14.D
    FADDV   H19, P5, Z31.H
    ORV     S31, P6, Z2.S
    EORV    H30, P2, Z0.H
    SMAXV   H18, P2, Z19.H
    FMINNMV H21, P3, Z24.H
    FMINV   S7, P1, Z25.S
    FMINNMV H28, P6, Z30.H
    SMAXV   S25, P1, Z4.S
    EORV    D30, P5, Z6.D
    FADDA   H13, P5, H13, Z28.H
    FMINNMV S1, P2, Z21.S
    UMAXV   D4, P4, Z3.D
    UADDV   D21, P3, Z15.D
    FADDA   D21, P7, D21, Z10.D
    FMINNMV H14, P4, Z21.H
    ANDV    B20, P6, Z2.B
    SMINV   H6, P2, Z21.H
    ORV     B26, P2, Z30.B
    FADDV   H0, P2, Z6.H
    UMAXV   B10, P1, Z18.B
    SMINV   B24, P2, Z20.B
    FMINV   S12, P6, Z25.S
    ORV     S24, P7, Z7.S
    ANDV    B30, P6, Z24.B
    SMAXV   S21, P3, Z13.S
    UADDV   D18, P1, Z17.H
    FADDA   S30, P3, S30, Z0.S
    FADDA   H4, P3, H4, Z26.H
    FMAXV   H15, P1, Z31.H
    SMAXV   D27, P4, Z30.D
    ANDV    B5, P5, Z21.B
    EORV    S0, P1, Z18.S
    ANDV    S21, P3, Z12.S
    UMAXV   D20, P2, Z10.D
    UADDV   D6, P7, Z0.H
    FADDV   H18, P1, Z3.H
    FMINNMV H25, P5, Z20.H
    SMAXV   D3, P1, Z27.D
    ANDV    D17, P1, Z25.D
    FMINV   D24, P6, Z22.D
    SMAXV   B20, P1, Z15.B
    FMINNMV H12, P3, Z6.H
    ANDV    H15, P6, Z17.H
    ANDV    B25, P0, Z17.B
    UMINV   D31, P7, Z18.D
    UADDV   D27, P7, Z14.H
    UMINV   D10, P5, Z15.D
    ANDV    B17, P5, Z6.B
    UADDV   D15, P5, Z12.D
    FADDV   H0, P0, Z5.H
    FADDA   D29, P0, D29, Z3.D
    UMAXV   D12, P6, Z29.D
    ANDV    D5, P2, Z7.D
    SMAXV   B6, P1, Z24.B
    FMAXV   H27, P5, Z29.H
    FMAXNMV H22, P4, Z12.H
    SADDV   D3, P1, Z6.H
    EORV    H3, P2, Z24.H
    FMINV   D22, P5, Z7.D
    FADDV   H7, P7, Z24.H
    ORV     D24, P4, Z3.D
    ORV     D3, P5, Z27.D
    FMAXNMV S24, P1, Z6.S
    SUBS  X26, X26, #0x1
    B.NE  LCRTSveReductionOperations_label_5
    MOVZ  X16, #0x9aee, LSL #0
    MOVK  X16, #0x372e, LSL #16
    MOVK  X16, #0x751d, LSL #32
    MOVK  X16, #0xcbc6, LSL #48
    SUB  X10, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x1cb6, LSL #0
    MOVK  X16, #0x54ae, LSL #16
    MOVK  X16, #0xa0ca, LSL #32
    MOVK  X16, #0x618a, LSL #48
    SUB  X10, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x2657, LSL #0
    MOVK  X16, #0xb2ec, LSL #16
    MOVK  X16, #0x875b, LSL #32
    MOVK  X16, #0xb3b8, LSL #48
    SUB  X10, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xd69, LSL #0
    MOVK  X16, #0x184c, LSL #16
    MOVK  X16, #0xecd4, LSL #32
    MOVK  X16, #0xf9b6, LSL #48
    SUB  X10, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x7303, LSL #0
    MOVK  X16, #0x5473, LSL #16
    MOVK  X16, #0xd942, LSL #32
    MOVK  X16, #0x90c, LSL #48
    SUB  X10, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xcaca, LSL #0
    MOVK  X16, #0x72dd, LSL #16
    MOVK  X16, #0x7550, LSL #32
    MOVK  X16, #0xc0e3, LSL #48
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x81e8, LSL #0
    MOVK  X16, #0x6b15, LSL #16
    MOVK  X16, #0x257, LSL #32
    MOVK  X16, #0x241e, LSL #48
    SUB  X10, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x5c46, LSL #0
    MOVK  X16, #0xf955, LSL #16
    MOVK  X16, #0x9e21, LSL #32
    MOVK  X16, #0x35b4, LSL #48
    SUB  X10, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x3a8, LSL #0
    MOVK  X16, #0xdbdd, LSL #16
    MOVK  X16, #0x59af, LSL #32
    MOVK  X16, #0xfd6e, LSL #48
    SUB  X10, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x10c8, LSL #0
    MOVK  X16, #0x1d1, LSL #16
    MOVK  X16, #0x235a, LSL #32
    MOVK  X16, #0xbe8b, LSL #48
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xc1d0, LSL #0
    MOVK  X16, #0x1100, LSL #16
    MOVK  X16, #0x5194, LSL #32
    MOVK  X16, #0x514e, LSL #48
    SUB  X10, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xb49e, LSL #0
    MOVK  X16, #0xfc02, LSL #16
    MOVK  X16, #0xc671, LSL #32
    MOVK  X16, #0xa96a, LSL #48
    SUB  X10, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x7e87, LSL #0
    MOVK  X16, #0x1f1e, LSL #16
    MOVK  X16, #0xe17b, LSL #32
    MOVK  X16, #0x885b, LSL #48
    SUB  X10, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xfd5b, LSL #0
    MOVK  X16, #0xfc0, LSL #16
    MOVK  X16, #0x60e0, LSL #32
    MOVK  X16, #0x62d8, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xb711, LSL #0
    MOVK  X16, #0xc037, LSL #16
    MOVK  X16, #0x5226, LSL #32
    MOVK  X16, #0xe13e, LSL #48
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xfec9, LSL #0
    MOVK  X16, #0xc00, LSL #16
    MOVK  X16, #0x73d, LSL #32
    MOVK  X16, #0xf69e, LSL #48
    SUB  X10, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x6e28, LSL #0
    MOVK  X16, #0xc188, LSL #16
    MOVK  X16, #0xf9da, LSL #32
    MOVK  X16, #0x3861, LSL #48
    SUB  X10, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xe119, LSL #0
    MOVK  X16, #0xb947, LSL #16
    MOVK  X16, #0x993a, LSL #32
    MOVK  X16, #0x1306, LSL #48
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x4f97, LSL #0
    MOVK  X16, #0xd9f, LSL #16
    MOVK  X16, #0xac3a, LSL #32
    MOVK  X16, #0x4da6, LSL #48
    SUB  X10, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveReductionOperations_TestFail
    MRS  X16, FPSR
    MOVZ  X10, #0x91, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FMOV  X16, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X16, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X16, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X16, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D3, P4, Z3.D
    FMOV  X16, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X16, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X16, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X16, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X16, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X16, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X16, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X16, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X16, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X16, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X16, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X16, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X16, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X16, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X16, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X16, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X16, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X16, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D21, P2, Z21.D
    FMOV  X16, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X16, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X16, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X16, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X16, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X16, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X16, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X16, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X16, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D30, P7, Z30.D
    FMOV  X16, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X16, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X25
    DUP     Z1.D, X24
    DUP     Z2.D, X10
    DUP     Z3.D, X23
    DUP     Z4.D, X14
    DUP     Z5.D, X28
    DUP     Z6.D, X16
    DUP     Z7.D, X29
    DUP     Z8.D, X15
    DUP     Z9.D, X26
    DUP     Z10.D, X8
    DUP     Z11.D, X27
    DUP     Z12.D, X14
    DUP     Z13.D, X14
    DUP     Z14.D, X7
    DUP     Z15.D, X15
    DUP     Z16.D, X17
    DUP     Z17.D, X7
    DUP     Z18.D, X23
    DUP     Z19.D, X4
    DUP     Z20.D, X26
    DUP     Z21.D, X3
    DUP     Z22.D, X6
    DUP     Z23.D, X15
    DUP     Z24.D, X24
    DUP     Z25.D, X3
    DUP     Z26.D, X12
    DUP     Z27.D, X25
    DUP     Z28.D, X14
    DUP     Z29.D, X15
    DUP     Z30.D, X12
    DUP     Z31.D, X6
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X26, #0xa, LSL #0
LCRTSveReductionOperations_label_6:
    EORV    B24, P3, Z5.B
    UADDV   D11, P5, Z28.B
    FMAXNMV S9, P5, Z15.S
    UMINV   H13, P1, Z25.H
    ORV     S25, P0, Z21.S
    ANDV    S10, P6, Z20.S
    SMAXV   D12, P4, Z13.D
    ANDV    B16, P7, Z25.B
    EORV    D23, P5, Z29.D
    ANDV    S21, P2, Z26.S
    UMINV   B22, P7, Z23.B
    FADDA   S9, P3, S9, Z7.S
    FADDA   D9, P7, D9, Z16.D
    SMAXV   D16, P7, Z10.D
    UMINV   D31, P5, Z18.D
    SMAXV   H30, P7, Z11.H
    FMAXNMV H14, P3, Z16.H
    ANDV    H7, P7, Z12.H
    FADDA   S21, P6, S21, Z22.S
    SMAXV   D15, P0, Z21.D
    FADDA   H7, P5, H7, Z15.H
    ANDV    H16, P0, Z14.H
    ORV     D15, P7, Z31.D
    FADDA   H30, P6, H30, Z9.H
    SADDV   D23, P6, Z27.B
    SMINV   B10, P5, Z5.B
    FMINV   H29, P1, Z27.H
    SMAXV   H22, P1, Z16.H
    SADDV   D23, P6, Z7.H
    SMAXV   D16, P5, Z23.D
    FMAXV   H21, P0, Z30.H
    UMINV   D30, P2, Z22.D
    EORV    S5, P5, Z16.S
    UMAXV   H19, P2, Z28.H
    ANDV    D28, P7, Z21.D
    SMAXV   B31, P2, Z30.B
    FMINNMV H27, P1, Z23.H
    UMAXV   B12, P6, Z27.B
    UADDV   D14, P5, Z31.D
    UMAXV   S30, P4, Z29.S
    FMINV   H23, P2, Z30.H
    SMAXV   H31, P0, Z16.H
    ANDV    H21, P5, Z19.H
    SADDV   D19, P3, Z28.B
    UADDV   D13, P6, Z14.H
    ORV     H8, P0, Z5.H
    FMINNMV D29, P4, Z3.D
    FMAXV   H22, P1, Z21.H
    EORV    H7, P5, Z12.H
    EORV    H21, P3, Z19.H
    EORV    H16, P0, Z18.H
    FMINNMV H28, P4, Z23.H
    FMINV   D5, P5, Z22.D
    UMINV   H27, P1, Z31.H
    ANDV    D22, P5, Z16.D
    FMINV   H12, P1, Z10.H
    FMINNMV D19, P1, Z13.D
    SADDV   D30, P7, Z27.H
    SADDV   D24, P7, Z8.S
    ANDV    D16, P2, Z29.D
    UMINV   S14, P2, Z24.S
    UMAXV   S29, P4, Z16.S
    ORV     H8, P6, Z12.H
    FMAXV   S13, P2, Z28.S
    FMINNMV S27, P6, Z21.S
    FADDA   D29, P5, D29, Z7.D
    FMAXV   S3, P2, Z29.S
    SADDV   D22, P2, Z2.S
    FADDV   H24, P6, Z16.H
    ORV     D26, P7, Z27.D
    FMINV   H7, P0, Z26.H
    EORV    S29, P4, Z25.S
    SMAXV   B1, P0, Z8.B
    SMAXV   B27, P2, Z13.B
    ORV     H18, P6, Z22.H
    FMAXNMV D26, P0, Z23.D
    ANDV    D13, P4, Z5.D
    EORV    D2, P1, Z13.D
    FMINNMV H13, P2, Z26.H
    UADDV   D23, P1, Z3.B
    SMINV   B22, P6, Z2.B
    FMINV   D26, P7, Z13.D
    FADDV   S13, P7, Z16.S
    ANDV    D5, P2, Z29.D
    FMINV   S25, P0, Z26.S
    SADDV   D2, P0, Z13.S
    SMAXV   D26, P7, Z27.D
    EORV    D3, P1, Z16.D
    FADDA   D1, P0, D1, Z25.D
    FADDA   D18, P7, D18, Z13.D
    ORV     S28, P1, Z24.S
    SADDV   D12, P6, Z2.S
    FMINNMV D8, P3, Z3.D
    ORV     D16, P1, Z23.D
    SMINV   S25, P2, Z16.S
    FADDA   S4, P6, S4, Z22.S
    FADDV   D13, P7, Z7.D
    FMAXNMV D27, P6, Z1.D
    UADDV   D23, P0, Z26.S
    FMINNMV H1, P7, Z4.H
    ORV     S4, P3, Z6.S
    SMAXV   S6, P3, Z12.S
    FMAXNMV D21, P6, Z3.D
    FADDV   S1, P2, Z27.S
    UMAXV   B24, P0, Z4.B
    UMAXV   B7, P3, Z13.B
    UMAXV   S13, P0, Z8.S
    UADDV   D16, P3, Z24.S
    ANDV    S24, P3, Z0.S
    FMAXNMV S8, P1, Z25.S
    ORV     B11, P5, Z7.B
    FADDV   D7, P3, Z13.D
    ANDV    H4, P7, Z16.H
    ORV     S14, P1, Z11.S
    FMINV   S22, P3, Z27.S
    EORV    D11, P2, Z18.D
    ORV     S12, P6, Z6.S
    SMINV   S13, P7, Z12.S
    UMINV   H18, P5, Z21.H
    SMINV   D19, P7, Z18.D
    FMAXNMV D13, P5, Z14.D
    FMAXV   H16, P7, Z24.H
    SADDV   D3, P5, Z22.B
    ORV     D18, P0, Z3.D
    ANDV    H25, P4, Z19.H
    FMINV   H24, P3, Z30.H
    SMAXV   D12, P5, Z11.D
    ORV     B11, P5, Z20.B
    FMINV   H4, P0, Z8.H
    SMAXV   D27, P5, Z25.D
    FADDV   D22, P6, Z24.D
    ANDV    D19, P3, Z16.D
    FMINV   S8, P0, Z11.S
    FMINNMV D3, P7, Z22.D
    EORV    D12, P1, Z14.D
    EORV    D16, P2, Z3.D
    ORV     H21, P6, Z19.H
    UMINV   B1, P4, Z18.B
    UADDV   D19, P4, Z21.B
    ORV     H3, P4, Z12.H
    ORV     S21, P4, Z27.S
    EORV    B12, P4, Z1.B
    UMINV   B22, P6, Z30.B
    UADDV   D25, P3, Z8.B
    EORV    B11, P6, Z4.B
    FADDV   S20, P3, Z27.S
    SADDV   D24, P6, Z16.S
    UMINV   D1, P1, Z24.D
    FMINNMV S8, P3, Z11.S
    UMAXV   H11, P2, Z21.H
    ANDV    D27, P3, Z20.D
    EORV    B21, P3, Z8.B
    FMINNMV H23, P5, Z27.H
    ORV     S16, P0, Z12.S
    UMINV   D12, P7, Z30.D
    SADDV   D3, P1, Z21.H
    FMINNMV H30, P6, Z11.H
    UMAXV   B26, P3, Z25.B
    FMINV   D21, P6, Z16.D
    FMAXV   H28, P4, Z7.H
    UMAXV   S24, P6, Z21.S
    UMINV   B16, P4, Z26.B
    FMAXNMV H20, P2, Z23.H
    EORV    S4, P5, Z28.S
    ORV     B8, P1, Z3.B
    FMINNMV H28, P0, Z28.H
    UMINV   S18, P1, Z26.S
    FMINV   H7, P5, Z19.H
    ORV     B3, P2, Z4.B
    UMAXV   B25, P4, Z16.B
    ORV     S11, P6, Z7.S
    SADDV   D26, P5, Z11.H
    FMAXV   H19, P4, Z28.H
    FADDV   D23, P6, Z8.D
    SMAXV   S28, P1, Z3.S
    FMINNMV H7, P6, Z23.H
    UMINV   D4, P3, Z18.D
    SADDV   D19, P1, Z28.H
    ORV     B16, P7, Z20.B
    ORV     D24, P2, Z25.D
    EORV    D27, P4, Z26.D
    SMINV   D26, P7, Z14.D
    EORV    B18, P7, Z16.B
    SADDV   D8, P7, Z24.S
    SADDV   D16, P7, Z8.S
    FMAXNMV S18, P3, Z30.S
    EORV    B21, P2, Z7.B
    UMINV   D30, P2, Z1.D
    ORV     S8, P5, Z16.S
    UMINV   S3, P0, Z4.S
    FMINV   S4, P3, Z23.S
    FMAXNMV D28, P6, Z3.D
    ANDV    H14, P6, Z21.H
    FMINNMV D7, P3, Z18.D
    SADDV   D23, P1, Z28.B
    FMINNMV D8, P5, Z22.D
    SMAXV   B21, P7, Z8.B
    SMINV   S8, P4, Z26.S
    SADDV   D27, P2, Z14.H
    SADDV   D24, P5, Z19.S
    SUBS  X26, X26, #0x1
    B.NE  LCRTSveReductionOperations_label_6
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, LCRTSveReductionOperations_TestFail
    MRS  X11, FPSR
    MOVZ  X27, #0x91, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D0
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D1
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D27
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D30
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FMOV  X11, D31
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P3, Z0.D
    FMOV  X11, D0
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D1, P2, Z1.D
    FMOV  X11, D1
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X11, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X11, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D4, P5, Z4.D
    FMOV  X11, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D5, P7, Z5.D
    FMOV  X11, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X11, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X11, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X11, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X11, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D10, P4, Z10.D
    FMOV  X11, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X11, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X11, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X11, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X11, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X11, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X11, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X11, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X11, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D19, P0, Z19.D
    FMOV  X11, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X11, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X11, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X11, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X11, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X11, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X11, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X11, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D27, P3, Z27.D
    FMOV  X11, D27
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X11, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X11, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D30, P0, Z30.D
    FMOV  X11, D30
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X11, D31
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X27
    DUP     Z1.D, X15
    DUP     Z2.D, X28
    DUP     Z3.D, X26
    DUP     Z4.D, X29
    DUP     Z5.D, X27
    DUP     Z6.D, X25
    DUP     Z7.D, X24
    DUP     Z8.D, X5
    DUP     Z9.D, X16
    DUP     Z10.D, X5
    DUP     Z11.D, X9
    DUP     Z12.D, X13
    DUP     Z13.D, X28
    DUP     Z14.D, X29
    DUP     Z15.D, X16
    DUP     Z16.D, X4
    DUP     Z17.D, X7
    DUP     Z18.D, X10
    DUP     Z19.D, X26
    DUP     Z20.D, X10
    DUP     Z21.D, X8
    DUP     Z22.D, X10
    DUP     Z23.D, X29
    DUP     Z24.D, X5
    DUP     Z25.D, X15
    DUP     Z26.D, X11
    DUP     Z27.D, X26
    DUP     Z28.D, X25
    DUP     Z29.D, X26
    DUP     Z30.D, X26
    DUP     Z31.D, X6
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X24, #0xa, LSL #0
LCRTSveReductionOperations_label_7:
    SMAXV   S18, P0, Z30.S
    ORV     B16, P4, Z9.B
    SMAXV   B24, P3, Z13.B
    SADDV   D30, P1, Z18.H
    FMAXV   S24, P0, Z30.S
    FMINNMV H16, P7, Z13.H
    UMAXV   B8, P5, Z7.B
    FMINV   D26, P6, Z7.D
    SMINV   B27, P4, Z8.B
    FMAXV   H7, P1, Z22.H
    SMINV   D16, P1, Z7.D
    UMINV   B1, P4, Z24.B
    UADDV   D29, P2, Z26.S
    FMINV   H15, P3, Z4.H
    FMAXNMV D11, P7, Z1.D
    FMAXNMV S27, P5, Z16.S
    ANDV    S27, P0, Z13.S
    FMAXNMV H2, P3, Z29.H
    FMINV   D26, P2, Z15.D
    FMINNMV H19, P4, Z27.H
    SMINV   S8, P6, Z3.S
    SMINV   D13, P1, Z26.D
    UMAXV   H30, P3, Z13.H
    SMINV   H27, P4, Z19.H
    SADDV   D29, P2, Z11.B
    FADDV   D16, P5, Z27.D
    FMINNMV H13, P7, Z14.H
    FMAXNMV D4, P4, Z2.D
    UMINV   S26, P3, Z18.S
    FMAXNMV S2, P1, Z29.S
    UADDV   D24, P2, Z8.H
    FADDA   H26, P3, H26, Z30.H
    SMAXV   D18, P5, Z16.D
    ANDV    H29, P2, Z13.H
    FMINV   D8, P6, Z15.D
    SMAXV   B13, P2, Z14.B
    SMAXV   D22, P5, Z24.D
    SMINV   B8, P2, Z27.B
    UMINV   B3, P4, Z22.B
    ORV     B30, P5, Z26.B
    ANDV    D27, P3, Z29.D
    ORV     H24, P5, Z3.H
    FMINNMV S11, P3, Z1.S
    EORV    H11, P6, Z4.H
    UADDV   D5, P5, Z8.B
    SMAXV   S19, P2, Z30.S
    FMINNMV H18, P5, Z19.H
    FMAXNMV S11, P5, Z29.S
    FMINNMV D16, P2, Z6.D
    SMINV   B1, P7, Z28.B
    SADDV   D6, P3, Z24.H
    SADDV   D14, P2, Z28.S
    SMINV   S8, P6, Z11.S
    UMINV   B30, P6, Z6.B
    SMAXV   D19, P4, Z16.D
    FMAXNMV H14, P3, Z8.H
    SMAXV   D14, P6, Z8.D
    FADDA   D27, P6, D27, Z13.D
    FADDA   D30, P1, D30, Z14.D
    FMINV   S3, P6, Z18.S
    FMAXV   D12, P5, Z3.D
    FADDV   S11, P5, Z11.S
    SMAXV   H5, P6, Z25.H
    EORV    H24, P2, Z12.H
    SADDV   D4, P2, Z27.S
    SADDV   D6, P4, Z24.B
    UADDV   D6, P1, Z5.D
    ANDV    S16, P1, Z11.S
    SMINV   S24, P6, Z27.S
    SMINV   D13, P1, Z21.D
    FMAXV   H13, P6, Z4.H
    SMINV   H12, P0, Z28.H
    UMAXV   B23, P6, Z20.B
    UMAXV   H14, P6, Z27.H
    FADDV   H7, P0, Z13.H
    UMAXV   B8, P0, Z31.B
    UMINV   S29, P6, Z23.S
    UMINV   S31, P2, Z16.S
    SADDV   D5, P7, Z18.S
    ORV     D25, P7, Z7.D
    SMINV   S21, P2, Z2.S
    EORV    H27, P0, Z4.H
    SADDV   D20, P1, Z8.B
    UMAXV   B28, P6, Z4.B
    SADDV   D18, P1, Z6.H
    FMAXV   S6, P1, Z18.S
    SMAXV   H16, P1, Z6.H
    UMAXV   S11, P4, Z21.S
    EORV    B18, P5, Z27.B
    ANDV    S4, P3, Z5.S
    UADDV   D6, P5, Z28.D
    FMINNMV D25, P1, Z18.D
    FMINV   D8, P0, Z24.D
    FADDV   H28, P6, Z20.H
    EORV    B7, P5, Z31.B
    FMAXNMV S23, P3, Z16.S
    ANDV    S31, P7, Z28.S
    UMINV   H2, P1, Z8.H
    FADDA   H31, P5, H31, Z4.H
    SMAXV   H21, P4, Z25.H
    UMINV   D5, P2, Z6.D
    FMINV   H8, P1, Z29.H
    SMAXV   B29, P0, Z31.B
    FMINV   H25, P0, Z8.H
    FADDA   D23, P3, D23, Z29.D
    UADDV   D27, P3, Z23.H
    FADDA   H27, P5, H27, Z21.H
    FMAXV   S8, P3, Z23.S
    FMINNMV S21, P1, Z8.S
    ORV     S20, P2, Z21.S
    SMAXV   S28, P2, Z2.S
    FMAXNMV H16, P4, Z11.H
    UMINV   D6, P0, Z7.D
    FADDA   H29, P6, H29, Z28.H
    SMINV   D18, P2, Z29.D
    FADDV   D31, P5, Z16.D
    UADDV   D20, P1, Z8.H
    SMINV   H7, P6, Z26.H
    FMINNMV H28, P0, Z27.H
    FMINV   S9, P2, Z5.S
    UADDV   D19, P4, Z31.H
    UMINV   D31, P3, Z20.D
    FADDV   D16, P5, Z6.D
    UADDV   D24, P0, Z30.B
    SMAXV   D4, P0, Z28.D
    FMINNMV S2, P5, Z8.S
    FMINNMV S8, P0, Z24.S
    FMINV   S20, P0, Z9.S
    UMINV   S29, P6, Z31.S
    EORV    B9, P6, Z4.B
    FMAXNMV D30, P1, Z29.D
    ORV     S4, P2, Z20.S
    FADDV   S26, P1, Z4.S
    ANDV    D25, P2, Z19.D
    SMINV   S5, P0, Z10.S
    FMINNMV D31, P2, Z30.D
    SMINV   B24, P2, Z23.B
    SMINV   H22, P6, Z13.H
    FMINV   H27, P4, Z25.H
    EORV    H23, P2, Z5.H
    SADDV   D25, P1, Z24.S
    ANDV    D6, P7, Z25.D
    ANDV    H25, P5, Z9.H
    EORV    S10, P1, Z11.S
    ANDV    B5, P0, Z31.B
    SMAXV   B28, P1, Z6.B
    FMINNMV H19, P1, Z23.H
    UMAXV   B13, P0, Z10.B
    UMINV   D13, P6, Z19.D
    FADDV   D31, P0, Z13.D
    UMINV   H17, P0, Z27.H
    UADDV   D4, P7, Z22.S
    FMAXNMV H10, P0, Z17.H
    ORV     H15, P4, Z26.H
    ANDV    B13, P5, Z0.B
    UMINV   B6, P6, Z5.B
    SADDV   D24, P7, Z4.S
    FMAXNMV D26, P5, Z13.D
    UMINV   B13, P2, Z10.B
    SADDV   D17, P3, Z28.B
    FMINNMV S11, P0, Z17.S
    UMINV   B5, P6, Z31.B
    ORV     D28, P4, Z28.D
    SADDV   D27, P1, Z31.S
    ANDV    B17, P4, Z13.B
    FMINV   S9, P0, Z15.S
    EORV    S4, P5, Z6.S
    SMAXV   B19, P3, Z26.B
    FADDA   H27, P1, H27, Z28.H
    SADDV   D31, P0, Z3.B
    FMAXNMV D16, P7, Z29.D
    FADDA   H5, P7, H5, Z17.H
    FMAXV   S28, P4, Z4.S
    SMAXV   B27, P5, Z9.B
    FADDV   S31, P6, Z31.S
    FMINV   S4, P0, Z24.S
    FADDV   S3, P3, Z16.S
    ANDV    B0, P2, Z26.B
    EORV    S15, P2, Z19.S
    UADDV   D17, P2, Z11.S
    ANDV    S6, P6, Z0.S
    SMAXV   D4, P7, Z6.D
    FADDV   H24, P6, Z15.H
    ANDV    B9, P7, Z8.B
    FADDV   H29, P0, Z4.H
    SADDV   D4, P4, Z11.B
    FMAXNMV D19, P7, Z11.D
    FMAXV   H11, P4, Z31.H
    SADDV   D6, P3, Z24.S
    FMINV   D13, P5, Z9.D
    SMINV   S15, P6, Z17.S
    ANDV    B25, P4, Z4.B
    FMINNMV S19, P3, Z13.S
    SMINV   S24, P5, Z6.S
    FADDA   S3, P2, S3, Z12.S
    UMAXV   D17, P6, Z28.D
    UMAXV   D23, P2, Z3.D
    FMINV   S9, P3, Z25.S
    FADDV   S6, P2, Z23.S
    EORV    H8, P4, Z17.H
    SUBS  X24, X24, #0x1
    B.NE  LCRTSveReductionOperations_label_7
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTSveReductionOperations_TestFail
    MRS  X7, FPSR
    MOVZ  X26, #0x91, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D0
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D1
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D4
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D14
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D26
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D30
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FMOV  X7, D31
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P0, Z0.D
    FMOV  X7, D0
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X7, D1
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X7, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D3, P0, Z3.D
    FMOV  X7, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D4, P5, Z4.D
    FMOV  X7, D4
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D5, P7, Z5.D
    FMOV  X7, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X7, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X7, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X7, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D9, P7, Z9.D
    FMOV  X7, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X7, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X7, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X7, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X7, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D14, P5, Z14.D
    FMOV  X7, D14
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X7, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X7, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X7, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X7, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X7, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X7, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X7, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X7, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X7, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X7, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X7, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X7, D26
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X7, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X7, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X7, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X7, D30
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X7, D31
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X29
    DUP     Z1.D, X16
    DUP     Z2.D, X25
    DUP     Z3.D, X26
    DUP     Z4.D, X5
    DUP     Z5.D, X23
    DUP     Z6.D, X8
    DUP     Z7.D, X28
    DUP     Z8.D, X27
    DUP     Z9.D, X27
    DUP     Z10.D, X15
    DUP     Z11.D, X11
    DUP     Z12.D, X5
    DUP     Z13.D, X17
    DUP     Z14.D, X26
    DUP     Z15.D, X7
    DUP     Z16.D, X23
    DUP     Z17.D, X8
    DUP     Z18.D, X24
    DUP     Z19.D, X4
    DUP     Z20.D, X15
    DUP     Z21.D, X7
    DUP     Z22.D, X15
    DUP     Z23.D, X23
    DUP     Z24.D, X5
    DUP     Z25.D, X23
    DUP     Z26.D, X7
    DUP     Z27.D, X16
    DUP     Z28.D, X11
    DUP     Z29.D, X27
    DUP     Z30.D, X11
    DUP     Z31.D, X5
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X7, #0xa, LSL #0
LCRTSveReductionOperations_label_8:
    FMAXNMV H15, P4, Z20.H
    FADDV   D12, P6, Z31.D
    ANDV    H8, P0, Z12.H
    SADDV   D31, P1, Z8.H
    EORV    B29, P2, Z2.B
    SMINV   S29, P7, Z28.S
    EORV    B3, P3, Z15.B
    SMAXV   H13, P7, Z29.H
    ORV     S14, P5, Z2.S
    SMINV   H2, P5, Z4.H
    ANDV    S15, P2, Z9.S
    UMINV   S16, P7, Z15.S
    ANDV    H3, P6, Z31.H
    UMINV   S24, P6, Z14.S
    FMINNMV H1, P2, Z23.H
    EORV    B22, P3, Z7.B
    FMINV   S27, P0, Z24.S
    FMINV   H29, P7, Z27.H
    SADDV   D1, P7, Z2.B
    ORV     S4, P2, Z19.S
    FADDA   S16, P5, S16, Z3.S
    SMINV   B27, P5, Z22.B
    FMAXV   D2, P4, Z27.D
    SMINV   S20, P3, Z13.S
    UMINV   H2, P7, Z9.H
    UMINV   S12, P7, Z21.S
    SMINV   B3, P3, Z2.B
    UADDV   D14, P7, Z28.S
    EORV    H12, P5, Z4.H
    FADDA   D12, P6, D12, Z17.D
    UMINV   H31, P7, Z16.H
    EORV    B13, P3, Z29.B
    UMINV   D28, P1, Z8.D
    ANDV    S8, P7, Z20.S
    SADDV   D15, P5, Z15.S
    UMAXV   B22, P7, Z14.B
    FADDV   S24, P3, Z1.S
    FMINV   H9, P0, Z12.H
    UMINV   B16, P3, Z31.B
    FMINV   H14, P3, Z4.H
    FMINV   S19, P7, Z16.S
    FADDV   D25, P7, Z3.D
    SMAXV   S1, P6, Z25.S
    FADDA   D1, P1, D1, Z29.D
    FADDA   S15, P2, S15, Z9.S
    FADDA   S24, P1, S24, Z19.S
    SMINV   B9, P4, Z13.B
    FMINNMV H20, P0, Z3.H
    FMAXNMV D3, P7, Z14.D
    FMINNMV D12, P5, Z8.D
    SMAXV   H19, P2, Z3.H
    FMAXNMV D7, P2, Z5.D
    ORV     S4, P4, Z28.S
    UMAXV   H16, P1, Z15.H
    UMAXV   B31, P7, Z26.B
    SMINV   H14, P7, Z26.H
    UADDV   D3, P6, Z22.B
    FMAXNMV D13, P3, Z4.D
    EORV    B8, P6, Z20.B
    FMINV   D5, P5, Z27.D
    FMAXV   H22, P0, Z16.H
    FMAXV   D25, P6, Z22.D
    FADDV   D27, P3, Z24.D
    FMINV   D16, P0, Z27.D
    UADDV   D15, P6, Z1.H
    UMINV   D28, P3, Z13.D
    UADDV   D10, P3, Z9.D
    UMINV   S4, P1, Z12.S
    UMAXV   H24, P3, Z3.H
    FMAXV   S10, P4, Z17.S
    FMAXNMV H17, P1, Z25.H
    EORV    D3, P6, Z19.D
    ORV     S20, P5, Z27.S
    UMAXV   D25, P2, Z31.D
    ORV     B10, P2, Z7.B
    FMAXNMV H31, P2, Z28.H
    UMINV   S21, P0, Z25.S
    SMAXV   H25, P2, Z4.H
    FMINV   H28, P6, Z16.H
    EORV    D12, P3, Z25.D
    FMINNMV H1, P7, Z31.H
    UADDV   D9, P2, Z3.B
    UADDV   D25, P7, Z20.H
    FMAXV   H7, P4, Z28.H
    ANDV    S30, P2, Z4.S
    FADDA   H9, P3, H9, Z21.H
    UMINV   S8, P6, Z30.S
    SADDV   D31, P1, Z18.B
    EORV    B27, P2, Z24.B
    EORV    B4, P1, Z26.B
    SMINV   S22, P6, Z10.S
    SMINV   D24, P7, Z5.D
    UMAXV   S10, P3, Z15.S
    FMINNMV D2, P4, Z24.D
    FMINNMV S18, P3, Z22.S
    SMAXV   B16, P0, Z7.B
    SMINV   S28, P3, Z16.S
    SMINV   B21, P1, Z13.B
    FMINV   H5, P3, Z21.H
    SMINV   H14, P1, Z28.H
    FMAXV   D30, P1, Z5.D
    FMAXNMV D3, P0, Z30.D
    FMINV   S21, P6, Z4.S
    UMAXV   B22, P5, Z1.B
    FMAXV   D13, P5, Z3.D
    FMAXV   H8, P5, Z21.H
    FMAXV   D24, P1, Z24.D
    FMINV   H21, P1, Z19.H
    EORV    S1, P3, Z8.S
    ORV     H16, P7, Z17.H
    ANDV    H3, P0, Z22.H
    UADDV   D22, P7, Z13.H
    ORV     D19, P7, Z22.D
    UMAXV   S22, P5, Z14.S
    SMAXV   D13, P6, Z1.D
    SADDV   D14, P3, Z27.H
    SMAXV   H8, P2, Z8.H
    UMINV   S30, P1, Z19.S
    EORV    H17, P3, Z25.H
    SMAXV   B19, P2, Z13.B
    FMAXNMV D27, P0, Z16.D
    UMINV   H13, P2, Z14.H
    FADDV   D1, P0, Z3.D
    SMINV   S17, P5, Z8.S
    FADDV   D3, P6, Z19.D
    FMINV   D25, P0, Z17.D
    FMINV   S22, P6, Z17.S
    EORV    D19, P1, Z13.D
    ORV     B4, P0, Z26.B
    UMINV   H16, P7, Z19.H
    SADDV   D8, P0, Z27.H
    UMINV   S19, P5, Z4.S
    UMAXV   D4, P3, Z19.D
    SADDV   D20, P0, Z6.H
    FADDA   H1, P0, H1, Z15.H
    SMAXV   B5, P7, Z3.B
    SADDV   D29, P6, Z14.H
    UADDV   D7, P2, Z5.B
    UADDV   D3, P4, Z25.S
    ANDV    S18, P4, Z8.S
    FMAXV   H1, P4, Z16.H
    SADDV   D8, P4, Z26.B
    FMAXV   S17, P4, Z29.S
    ORV     S19, P3, Z1.S
    EORV    D6, P6, Z30.D
    UMAXV   B27, P4, Z20.B
    FMAXV   D7, P3, Z8.D
    EORV    B16, P1, Z18.B
    UADDV   D29, P1, Z27.S
    UADDV   D27, P5, Z22.D
    EORV    D5, P1, Z7.D
    FMINV   S30, P3, Z17.S
    ANDV    S25, P2, Z6.S
    SMAXV   H26, P3, Z16.H
    FADDV   S22, P3, Z23.S
    EORV    S17, P4, Z27.S
    FMAXV   H28, P3, Z26.H
    FMINNMV H0, P5, Z29.H
    FMAXV   H7, P3, Z28.H
    UADDV   D29, P1, Z8.B
    ORV     S6, P3, Z22.S
    ORV     S20, P2, Z23.S
    FMINNMV D27, P1, Z6.D
    UMAXV   H26, P3, Z17.H
    FADDA   H12, P3, H12, Z27.H
    FMINNMV D17, P0, Z26.D
    SADDV   D26, P2, Z6.B
    SMAXV   S1, P2, Z0.S
    ANDV    D11, P1, Z18.D
    SMINV   D16, P1, Z1.D
    FMAXNMV H31, P3, Z29.H
    ORV     B29, P6, Z31.B
    SMINV   H31, P1, Z7.H
    ANDV    D23, P1, Z0.D
    EORV    B16, P7, Z20.B
    FADDV   H0, P4, Z5.H
    UADDV   D9, P6, Z29.D
    EORV    D27, P1, Z0.D
    UADDV   D18, P5, Z9.B
    ANDV    D7, P7, Z11.D
    ANDV    S20, P7, Z23.S
    FMINNMV S20, P0, Z20.S
    FMINNMV D1, P2, Z26.D
    ORV     H9, P6, Z18.H
    UMINV   B8, P6, Z12.B
    FADDV   S5, P2, Z9.S
    ANDV    B0, P4, Z8.B
    UMINV   D11, P3, Z25.D
    UMINV   S25, P2, Z17.S
    UMAXV   B23, P0, Z31.B
    FMINV   S5, P4, Z16.S
    SADDV   D18, P2, Z23.B
    FMAXV   D17, P6, Z20.D
    FMAXV   S16, P7, Z11.S
    UMINV   B26, P1, Z15.B
    FADDA   H26, P7, H26, Z8.H
    SMINV   B29, P6, Z17.B
    EORV    S17, P3, Z27.S
    SADDV   D30, P0, Z0.S
    SADDV   D8, P4, Z7.B
    SUBS  X7, X7, #0x1
    B.NE  LCRTSveReductionOperations_label_8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X14, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveReductionOperations_TestFail
    MRS  X24, FPSR
    MOVZ  X14, #0x91, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D0
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D1
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D14
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D29
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FMOV  X24, D31
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X24, D0
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X24, D1
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X24, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D3, P6, Z3.D
    FMOV  X24, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X24, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X24, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X24, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X24, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X24, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X24, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D10, P3, Z10.D
    FMOV  X24, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X24, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X24, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X24, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X24, D14
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X24, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X24, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X24, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D18, P7, Z18.D
    FMOV  X24, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X24, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D20, P5, Z20.D
    FMOV  X24, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X24, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X24, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X24, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X24, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X24, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X24, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X24, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X24, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D29, P0, Z29.D
    FMOV  X24, D29
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X24, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X24, D31
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X29
    DUP     Z1.D, X28
    DUP     Z2.D, X25
    DUP     Z3.D, X26
    DUP     Z4.D, X6
    DUP     Z5.D, X27
    DUP     Z6.D, X23
    DUP     Z7.D, X11
    DUP     Z8.D, X24
    DUP     Z9.D, X6
    DUP     Z10.D, X28
    DUP     Z11.D, X5
    DUP     Z12.D, X11
    DUP     Z13.D, X5
    DUP     Z14.D, X25
    DUP     Z15.D, X7
    DUP     Z16.D, X5
    DUP     Z17.D, X24
    DUP     Z18.D, X29
    DUP     Z19.D, X5
    DUP     Z20.D, X6
    DUP     Z21.D, X6
    DUP     Z22.D, X14
    DUP     Z23.D, X2
    DUP     Z24.D, X11
    DUP     Z25.D, X13
    DUP     Z26.D, X12
    DUP     Z27.D, X17
    DUP     Z28.D, X9
    DUP     Z29.D, X25
    DUP     Z30.D, X26
    DUP     Z31.D, X25
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X15, #0xa, LSL #0
LCRTSveReductionOperations_label_9:
    SMINV   D29, P0, Z24.D
    ANDV    S4, P6, Z25.S
    EORV    H26, P0, Z13.H
    UMAXV   B8, P3, Z26.B
    FMAXV   H1, P5, Z5.H
    FMINNMV S14, P4, Z16.S
    FMAXNMV S28, P7, Z21.S
    FMAXNMV S2, P6, Z4.S
    ANDV    S21, P2, Z7.S
    ANDV    B18, P1, Z13.B
    SMAXV   D20, P0, Z28.D
    UADDV   D1, P0, Z2.H
    EORV    H21, P7, Z1.H
    UMAXV   B4, P2, Z18.B
    FADDA   H8, P5, H8, Z17.H
    UMAXV   B26, P7, Z7.B
    ORV     S17, P6, Z13.S
    ORV     D27, P5, Z26.D
    FADDV   S31, P4, Z29.S
    FMINNMV S13, P4, Z27.S
    SMINV   S29, P5, Z13.S
    UMINV   H22, P1, Z10.H
    SMAXV   D31, P7, Z31.D
    FADDA   D17, P3, D17, Z17.D
    EORV    S11, P2, Z20.S
    FMAXNMV H26, P3, Z19.H
    FMAXNMV S20, P6, Z14.S
    FADDA   H11, P0, H11, Z26.H
    SADDV   D4, P5, Z29.B
    SMAXV   D4, P3, Z11.D
    FMAXNMV H10, P4, Z12.H
    ORV     D1, P2, Z16.D
    FADDV   S26, P0, Z17.S
    FMAXV   S16, P1, Z27.S
    ANDV    S11, P5, Z4.S
    FMAXV   H2, P4, Z22.H
    SMAXV   H29, P1, Z1.H
    EORV    H17, P2, Z31.H
    ORV     B27, P2, Z20.B
    FMAXV   H9, P1, Z6.H
    FMAXV   S30, P2, Z16.S
    UMAXV   S12, P6, Z29.S
    FMAXV   H31, P4, Z10.H
    EORV    H31, P5, Z17.H
    FMAXNMV H19, P7, Z12.H
    UMAXV   H29, P7, Z9.H
    UADDV   D17, P6, Z19.H
    ORV     S12, P1, Z26.S
    SMAXV   B28, P1, Z0.B
    UMINV   B19, P2, Z12.B
    FMAXNMV D20, P6, Z31.D
    SMINV   B1, P4, Z18.B
    SMINV   B16, P5, Z20.B
    FMAXNMV D12, P2, Z29.D
    SADDV   D31, P2, Z26.S
    FMINNMV H26, P7, Z27.H
    FMINNMV D20, P0, Z19.D
    UMAXV   D30, P7, Z16.D
    FADDV   D19, P6, Z20.D
    FMINV   H17, P2, Z12.H
    UADDV   D29, P5, Z31.S
    SMINV   B18, P6, Z28.B
    FMINNMV S4, P2, Z18.S
    ORV     H16, P1, Z29.H
    UMAXV   D27, P0, Z21.D
    FMINV   D29, P0, Z9.D
    UMAXV   S18, P4, Z27.S
    SMINV   B4, P2, Z25.B
    EORV    S26, P4, Z8.S
    SADDV   D16, P7, Z19.H
    UMINV   H20, P7, Z18.H
    FADDA   H30, P2, H30, Z30.H
    FMINNMV D10, P2, Z16.D
    FMAXV   S18, P0, Z29.S
    UMAXV   S0, P3, Z4.S
    FMAXNMV H18, P4, Z26.H
    ANDV    D26, P4, Z17.D
    UMAXV   H16, P4, Z26.H
    UADDV   D21, P5, Z30.H
    FMAXNMV D26, P2, Z10.D
    SMINV   S28, P1, Z7.S
    UMAXV   S29, P7, Z2.S
    UADDV   D17, P5, Z28.S
    FMINV   H31, P5, Z1.H
    UMINV   B19, P6, Z17.B
    UMAXV   D4, P3, Z16.D
    EORV    H16, P6, Z20.H
    ANDV    D8, P2, Z4.D
    SADDV   D12, P5, Z18.S
    UADDV   D15, P7, Z8.H
    UADDV   D28, P0, Z31.D
    UADDV   D22, P1, Z15.B
    UADDV   D9, P4, Z22.H
    FMINV   D25, P4, Z19.D
    FADDA   H0, P1, H0, Z26.H
    ANDV    D10, P2, Z15.D
    UMINV   D7, P3, Z28.D
    ORV     D24, P3, Z16.D
    FADDA   H2, P3, H2, Z25.H
    SADDV   D19, P7, Z7.S
    UADDV   D13, P3, Z2.D
    UMAXV   D22, P0, Z23.D
    UADDV   D16, P7, Z24.B
    UMAXV   D31, P4, Z31.D
    FMAXNMV H21, P2, Z12.H
    FADDA   H20, P1, H20, Z30.H
    FADDV   S17, P4, Z21.S
    SADDV   D28, P1, Z31.H
    UMAXV   D23, P7, Z9.D
    FADDA   S0, P7, S0, Z0.S
    EORV    B2, P0, Z0.B
    UMAXV   H0, P7, Z29.H
    SADDV   D26, P5, Z22.S
    UMAXV   D30, P3, Z26.D
    EORV    H15, P6, Z19.H
    UMAXV   H0, P7, Z17.H
    ANDV    S9, P6, Z2.S
    FMAXNMV H19, P1, Z13.H
    UMINV   D31, P5, Z15.D
    SADDV   D12, P0, Z30.H
    UADDV   D22, P4, Z23.S
    SMAXV   D4, P6, Z5.D
    FMINNMV D31, P7, Z9.D
    FMAXNMV S29, P2, Z4.S
    FADDA   S22, P7, S22, Z31.S
    FMINV   D13, P0, Z28.D
    FMAXV   H2, P6, Z12.H
    FMAXNMV S30, P1, Z29.S
    FMAXNMV D12, P5, Z13.D
    FMINNMV H29, P2, Z25.H
    FMINV   D26, P2, Z19.D
    SMINV   D4, P5, Z22.D
    EORV    B10, P5, Z30.B
    FADDV   D22, P1, Z21.D
    UMAXV   B23, P1, Z0.B
    SMINV   B30, P7, Z23.B
    UADDV   D19, P3, Z26.S
    EORV    H0, P3, Z12.H
    SMAXV   S25, P0, Z19.S
    FMINV   H26, P0, Z10.H
    FMAXV   S9, P4, Z22.S
    EORV    D23, P0, Z9.D
    UMAXV   D11, P5, Z26.D
    UMINV   D28, P3, Z23.D
    EORV    S22, P4, Z30.S
    FADDV   S10, P7, Z4.S
    UMINV   D13, P5, Z17.D
    FMAXV   S19, P6, Z18.S
    SADDV   D21, P4, Z28.H
    FMINNMV D4, P3, Z19.D
    UMINV   S23, P0, Z11.S
    UMAXV   H9, P4, Z2.H
    FMINNMV H30, P0, Z0.H
    FMINV   H19, P7, Z22.H
    UADDV   D17, P6, Z13.D
    SMAXV   H8, P2, Z1.H
    FADDV   H8, P5, Z19.H
    FMINV   H10, P4, Z8.H
    FMAXV   S1, P4, Z21.S
    FMAXV   S13, P3, Z9.S
    UMAXV   D0, P7, Z30.D
    UADDV   D21, P2, Z1.D
    FMAXV   S11, P6, Z0.S
    SMAXV   D16, P2, Z14.D
    UADDV   D18, P2, Z5.B
    UADDV   D28, P6, Z16.D
    UADDV   D9, P6, Z22.H
    UADDV   D12, P7, Z23.D
    FMAXV   S19, P1, Z12.S
    ORV     D23, P7, Z11.D
    ANDV    B11, P5, Z4.B
    ANDV    S1, P4, Z1.S
    FMAXNMV H16, P0, Z21.H
    FADDA   H3, P0, H3, Z3.H
    FMAXV   D14, P3, Z16.D
    FADDV   S5, P7, Z3.S
    SADDV   D5, P3, Z13.S
    SMAXV   B8, P5, Z11.B
    SMINV   H0, P2, Z23.H
    SMAXV   S23, P3, Z0.S
    FMINNMV D4, P4, Z8.D
    ANDV    S3, P1, Z23.S
    FADDV   S21, P4, Z5.S
    SADDV   D1, P0, Z19.B
    FMAXNMV D27, P0, Z1.D
    UADDV   D14, P4, Z28.D
    SMINV   B5, P4, Z18.B
    FADDA   D7, P4, D7, Z14.D
    FADDV   S18, P2, Z29.S
    FADDA   D29, P5, D29, Z16.D
    FADDV   H14, P2, Z7.H
    EORV    H13, P4, Z5.H
    UADDV   D11, P3, Z4.H
    UADDV   D28, P4, Z9.D
    UMAXV   D0, P7, Z3.D
    SADDV   D29, P4, Z18.B
    SMINV   B27, P0, Z29.B
    ANDV    B29, P2, Z12.B
    FADDA   H14, P6, H14, Z0.H
    FADDA   D26, P0, D26, Z11.D
    SUBS  X15, X15, #0x1
    B.NE  LCRTSveReductionOperations_label_9
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X11, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveReductionOperations_TestFail
    MRS  X4, FPSR
    MOVZ  X11, #0x91, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D0
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D1
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D5
    MOVZ  X11, #0xa0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D6
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D11
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D13
    MOVZ  X11, #0xa0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D30
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X4, D31
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P1, Z0.D
    FMOV  X4, D0
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X4, D1
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D2, P2, Z2.D
    FMOV  X4, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D3, P0, Z3.D
    FMOV  X4, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D4, P1, Z4.D
    FMOV  X4, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X4, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X4, D6
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5c5, LSL #48
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X4, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X4, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D9, P1, Z9.D
    FMOV  X4, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X4, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D11, P3, Z11.D
    FMOV  X4, D11
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X4, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X4, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X4, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X4, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X4, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D17, P0, Z17.D
    FMOV  X4, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D18, P7, Z18.D
    FMOV  X4, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X4, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X4, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D21, P4, Z21.D
    FMOV  X4, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X4, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X4, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D24, P7, Z24.D
    FMOV  X4, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X4, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D26, P4, Z26.D
    FMOV  X4, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X4, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X4, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X4, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X4, D30
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X4, D31
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X2, #0x97d, LSL #0
    MOVK  X2, #0x1771, LSL #16
    MOVK  X2, #0x68ea, LSL #32
    MOVK  X2, #0x28ad, LSL #48
    MOVZ  X3, #0x6abc, LSL #0
    MOVK  X3, #0x666a, LSL #16
    MOVK  X3, #0xd382, LSL #32
    MOVK  X3, #0xa4bc, LSL #48
    MOVZ  X4, #0x912c, LSL #0
    MOVK  X4, #0x7c68, LSL #16
    MOVK  X4, #0xfa27, LSL #32
    MOVK  X4, #0x32b5, LSL #48
    MOVZ  X5, #0x9d7a, LSL #0
    MOVK  X5, #0x5e7f, LSL #16
    MOVK  X5, #0xcc08, LSL #32
    MOVK  X5, #0x2519, LSL #48
    MOVZ  X6, #0x89b4, LSL #0
    MOVK  X6, #0x80d6, LSL #16
    MOVK  X6, #0x5e7f, LSL #32
    MOVK  X6, #0x3a3c, LSL #48
    MOVZ  X7, #0xa2dc, LSL #0
    MOVK  X7, #0x57f2, LSL #16
    MOVK  X7, #0xde84, LSL #32
    MOVK  X7, #0x683e, LSL #48
    MOVZ  X8, #0x5d02, LSL #0
    MOVK  X8, #0x3c1e, LSL #16
    MOVK  X8, #0x9251, LSL #32
    MOVK  X8, #0xbfb4, LSL #48
    MOVZ  X9, #0x3efa, LSL #0
    MOVK  X9, #0x3e27, LSL #16
    MOVK  X9, #0x168c, LSL #32
    MOVK  X9, #0x22a8, LSL #48
    MOVZ  X10, #0xb5ca, LSL #0
    MOVK  X10, #0x3b0d, LSL #16
    MOVK  X10, #0x738f, LSL #32
    MOVK  X10, #0x2c89, LSL #48
    MOVZ  X11, #0xb86c, LSL #0
    MOVK  X11, #0xc419, LSL #16
    MOVK  X11, #0xf9d7, LSL #32
    MOVK  X11, #0xee08, LSL #48
    MOVZ  X12, #0x574a, LSL #0
    MOVK  X12, #0x6e67, LSL #16
    MOVK  X12, #0xce7b, LSL #32
    MOVK  X12, #0xc62, LSL #48
    MOVZ  X13, #0xb99e, LSL #0
    MOVK  X13, #0xc1a7, LSL #16
    MOVK  X13, #0x6159, LSL #32
    MOVK  X13, #0x883e, LSL #48
    MOVZ  X14, #0x7d72, LSL #0
    MOVK  X14, #0x201b, LSL #16
    MOVK  X14, #0x2b64, LSL #32
    MOVK  X14, #0xdd38, LSL #48
    MOVZ  X15, #0xf792, LSL #0
    MOVK  X15, #0xfbd7, LSL #16
    MOVK  X15, #0xba2f, LSL #32
    MOVK  X15, #0x1731, LSL #48
    MOVZ  X16, #0xfd6, LSL #0
    MOVK  X16, #0xbbb2, LSL #16
    MOVK  X16, #0xbaa2, LSL #32
    MOVK  X16, #0x985c, LSL #48
    MOVZ  X17, #0x741f, LSL #0
    MOVK  X17, #0xcf13, LSL #16
    MOVK  X17, #0xabc3, LSL #32
    MOVK  X17, #0xe0ff, LSL #48
    MOVZ  X23, #0xdfff, LSL #0
    MOVK  X23, #0x291b, LSL #16
    MOVK  X23, #0x8ae0, LSL #32
    MOVK  X23, #0xd766, LSL #48
    MOVZ  X24, #0xdbf6, LSL #0
    MOVK  X24, #0x67c6, LSL #16
    MOVK  X24, #0xfa43, LSL #32
    MOVK  X24, #0xdbbd, LSL #48
    MOVZ  X25, #0x8be1, LSL #0
    MOVK  X25, #0xf2b6, LSL #16
    MOVK  X25, #0x90d1, LSL #32
    MOVK  X25, #0x6a8c, LSL #48
    MOVZ  X26, #0xaeac, LSL #0
    MOVK  X26, #0x36e1, LSL #16
    MOVK  X26, #0x9c5, LSL #32
    MOVK  X26, #0x1ecb, LSL #48
    MOVZ  X27, #0x93f6, LSL #0
    MOVK  X27, #0x4ddb, LSL #16
    MOVK  X27, #0x26d4, LSL #32
    MOVK  X27, #0x49d2, LSL #48
    MOVZ  X28, #0x790e, LSL #0
    MOVK  X28, #0x9ae7, LSL #16
    MOVK  X28, #0xd3e2, LSL #32
    MOVK  X28, #0xbaea, LSL #48
    MOVZ  X29, #0xe476, LSL #0
    MOVK  X29, #0xa33, LSL #16
    MOVK  X29, #0xecfb, LSL #32
    MOVK  X29, #0xc549, LSL #48
    DUP     Z0.D, X29
    DUP     Z1.D, X26
    DUP     Z2.D, X17
    DUP     Z3.D, X28
    DUP     Z4.D, X27
    DUP     Z5.D, X4
    DUP     Z6.D, X2
    DUP     Z7.D, X13
    DUP     Z8.D, X5
    DUP     Z9.D, X8
    DUP     Z10.D, X27
    DUP     Z11.D, X13
    DUP     Z12.D, X6
    DUP     Z13.D, X17
    DUP     Z14.D, X28
    DUP     Z15.D, X26
    DUP     Z16.D, X17
    DUP     Z17.D, X17
    DUP     Z18.D, X10
    DUP     Z19.D, X6
    DUP     Z20.D, X3
    DUP     Z21.D, X26
    DUP     Z22.D, X5
    DUP     Z23.D, X14
    DUP     Z24.D, X15
    DUP     Z25.D, X25
    DUP     Z26.D, X14
    DUP     Z27.D, X27
    DUP     Z28.D, X11
    DUP     Z29.D, X2
    DUP     Z30.D, X27
    DUP     Z31.D, X29
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X25, #0xa, LSL #0
LCRTSveReductionOperations_label_10:
    FMINNMV S3, P0, Z31.S
    UMINV   H11, P1, Z30.H
    UMAXV   S2, P4, Z3.S
    ANDV    D4, P3, Z25.D
    ORV     H29, P7, Z5.H
    EORV    S3, P5, Z4.S
    ORV     D16, P6, Z29.D
    SMAXV   B29, P2, Z3.B
    FMINNMV S28, P4, Z2.S
    ANDV    H0, P0, Z20.H
    ANDV    D30, P1, Z29.D
    FADDV   D30, P2, Z23.D
    SADDV   D12, P2, Z30.B
    FMAXNMV S0, P0, Z12.S
    SMINV   H9, P5, Z16.H
    SADDV   D24, P3, Z22.B
    FMAXNMV D9, P0, Z13.D
    SMINV   S12, P7, Z9.S
    UMAXV   S25, P4, Z21.S
    FMINNMV S30, P2, Z12.S
    SMINV   H9, P0, Z25.H
    SADDV   D8, P5, Z31.B
    FMINV   S5, P3, Z11.S
    FMINNMV H20, P2, Z5.H
    FMINNMV H22, P0, Z15.H
    FADDA   S30, P6, S30, Z16.S
    ANDV    H13, P3, Z24.H
    UMINV   D29, P7, Z5.D
    EORV    B2, P1, Z13.B
    UADDV   D3, P5, Z30.H
    EORV    D21, P0, Z22.D
    UADDV   D13, P1, Z3.H
    FMAXNMV S3, P7, Z8.S
    ANDV    S29, P4, Z13.S
    ORV     S4, P2, Z15.S
    EORV    D8, P6, Z3.D
    SMINV   B8, P7, Z7.B
    UMAXV   S7, P2, Z29.S
    FMINV   D4, P2, Z19.D
    SADDV   D29, P0, Z21.H
    EORV    H31, P5, Z9.H
    FMAXNMV S7, P0, Z2.S
    UADDV   D15, P1, Z0.D
    FMAXNMV H19, P4, Z29.H
    FMINV   S22, P6, Z6.S
    UADDV   D29, P0, Z15.H
    FMAXNMV S6, P3, Z22.S
    FADDV   D30, P0, Z19.D
    SMAXV   D2, P5, Z4.D
    SMAXV   H9, P2, Z8.H
    FADDV   H8, P1, Z7.H
    ORV     D19, P2, Z6.D
    UMINV   S13, P2, Z11.S
    FMINV   H19, P5, Z2.H
    FADDA   H25, P4, H25, Z8.H
    SMAXV   H0, P1, Z20.H
    SMINV   D14, P0, Z25.D
    UMINV   D15, P0, Z0.D
    EORV    D7, P4, Z9.D
    SADDV   D14, P0, Z15.B
    SMINV   B6, P4, Z13.B
    UMAXV   B9, P4, Z6.B
    FADDA   H29, P6, H29, Z31.H
    UMAXV   D28, P5, Z29.D
    SMAXV   S0, P6, Z18.S
    UMINV   S13, P4, Z18.S
    FMAXNMV S15, P1, Z10.S
    FADDV   S29, P0, Z28.S
    UADDV   D22, P0, Z29.D
    FMAXNMV S6, P1, Z31.S
    FADDV   S18, P0, Z7.S
    FMAXV   D8, P0, Z6.D
    UMINV   S25, P0, Z7.S
    EORV    B14, P0, Z0.B
    UMINV   D31, P0, Z9.D
    SMAXV   S6, P5, Z15.S
    SMAXV   B11, P2, Z13.B
    UMINV   S28, P6, Z18.S
    FADDV   H15, P2, Z8.H
    UMAXV   B0, P6, Z25.B
    ANDV    B25, P3, Z15.B
    UADDV   D9, P2, Z22.D
    SADDV   D22, P6, Z18.S
    FMINNMV D7, P5, Z22.D
    FMAXV   H2, P1, Z28.H
    FMINNMV H27, P1, Z9.H
    UADDV   D20, P1, Z15.H
    FADDA   S11, P5, S11, Z2.S
    SMAXV   S9, P6, Z25.S
    UMAXV   D2, P2, Z20.D
    FMINV   H20, P5, Z27.H
    UMINV   H28, P5, Z20.H
    FADDA   D6, P0, D6, Z14.D
    ANDV    H18, P2, Z18.H
    FADDA   H6, P2, H6, Z2.H
    SMAXV   B8, P5, Z3.B
    FMAXV   H2, P3, Z1.H
    FMAXNMV H20, P6, Z0.H
    SMAXV   B13, P4, Z14.B
    FMINNMV S27, P2, Z2.S
    FMAXNMV H1, P2, Z8.H
    ORV     D25, P5, Z1.D
    UMAXV   H2, P2, Z7.H
    FADDV   D12, P3, Z11.D
    UADDV   D14, P6, Z18.H
    UMAXV   D11, P1, Z9.D
    ANDV    D27, P1, Z3.D
    UADDV   D3, P6, Z11.H
    ANDV    B22, P4, Z12.B
    SADDV   D11, P6, Z2.S
    SADDV   D0, P3, Z3.S
    ANDV    H31, P7, Z22.H
    SMINV   D7, P0, Z28.D
    FMAXNMV H6, P6, Z8.H
    UADDV   D19, P0, Z14.H
    UMAXV   H27, P2, Z24.H
    SMINV   D12, P3, Z0.D
    SADDV   D2, P4, Z2.S
    EORV    S28, P5, Z21.S
    FMAXV   S10, P5, Z12.S
    FMINNMV H12, P3, Z6.H
    FADDA   H20, P1, H20, Z10.H
    FMAXV   D21, P3, Z12.D
    SMAXV   H12, P3, Z19.H
    FMAXNMV S0, P6, Z21.S
    FMAXV   D22, P7, Z20.D
    FADDV   H19, P7, Z28.H
    FMINNMV S6, P0, Z22.S
    ANDV    D24, P6, Z16.D
    FADDV   D31, P0, Z6.D
    UADDV   D5, P1, Z21.D
    FMINNMV D22, P1, Z0.D
    SMAXV   H16, P6, Z20.H
    FMAXV   H21, P7, Z16.H
    UMINV   D23, P5, Z27.D
    EORV    B28, P4, Z2.B
    SMAXV   B27, P6, Z23.B
    SADDV   D16, P3, Z4.B
    SMINV   D14, P0, Z31.D
    FMAXV   S25, P2, Z28.S
    ANDV    S10, P4, Z27.S
    SMINV   H6, P5, Z10.H
    UMINV   B28, P5, Z12.B
    UMINV   D10, P3, Z27.D
    FMAXNMV D2, P0, Z6.D
    UMINV   H17, P5, Z10.H
    FMAXNMV S6, P4, Z27.S
    SMINV   B10, P1, Z22.B
    SMAXV   B23, P2, Z3.B
    UMAXV   S22, P2, Z16.S
    FMAXNMV S16, P5, Z28.S
    UMINV   B20, P1, Z23.B
    ORV     B23, P4, Z16.B
    FMINNMV D28, P5, Z14.D
    ORV     S7, P7, Z20.S
    SMAXV   S4, P4, Z2.S
    SMINV   B0, P2, Z28.B
    ORV     S3, P4, Z7.S
    UMAXV   D31, P6, Z3.D
    FADDA   S25, P2, S25, Z15.S
    SMINV   D12, P6, Z0.D
    FADDA   S6, P0, S6, Z4.S
    FMAXV   H27, P1, Z22.H
    FMINV   S14, P7, Z31.S
    FMINNMV S16, P0, Z21.S
    SMINV   H4, P3, Z23.H
    EORV    H28, P4, Z16.H
    ORV     D22, P0, Z6.D
    UADDV   D18, P1, Z4.S
    FMINNMV D31, P5, Z18.D
    ORV     S15, P7, Z27.S
    UADDV   D7, P0, Z13.H
    FADDV   H23, P4, Z10.H
    UADDV   D6, P0, Z21.H
    FMAXV   H2, P1, Z15.H
    FADDA   S25, P1, S25, Z3.S
    UMAXV   B3, P3, Z22.B
    ORV     S16, P0, Z14.S
    UADDV   D22, P2, Z16.D
    SMAXV   H15, P1, Z18.H
    ORV     B22, P7, Z22.B
    SMAXV   H1, P0, Z3.H
    UADDV   D12, P0, Z25.B
    ANDV    B21, P2, Z31.B
    UMAXV   D10, P7, Z2.D
    FMINNMV D8, P6, Z1.D
    FMAXV   H11, P3, Z18.H
    SADDV   D16, P7, Z7.B
    FMINNMV H27, P4, Z16.H
    UADDV   D3, P2, Z22.S
    FADDA   H8, P5, H8, Z6.H
    FMINNMV H30, P7, Z3.H
    UMINV   B16, P3, Z28.B
    ORV     H28, P4, Z11.H
    SMAXV   D1, P6, Z28.D
    UMAXV   B22, P2, Z16.B
    FMINNMV H7, P0, Z10.H
    FMINNMV H4, P4, Z12.H
    UMAXV   B25, P5, Z4.B
    UADDV   D3, P5, Z7.S
    SUBS  X25, X25, #0x1
    B.NE  LCRTSveReductionOperations_label_10
    MOVZ  X16, #0x97d, LSL #0
    MOVK  X16, #0x1771, LSL #16
    MOVK  X16, #0x68ea, LSL #32
    MOVK  X16, #0x28ad, LSL #48
    SUB  X13, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x6abc, LSL #0
    MOVK  X16, #0x666a, LSL #16
    MOVK  X16, #0xd382, LSL #32
    MOVK  X16, #0xa4bc, LSL #48
    SUB  X13, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x912c, LSL #0
    MOVK  X16, #0x7c68, LSL #16
    MOVK  X16, #0xfa27, LSL #32
    MOVK  X16, #0x32b5, LSL #48
    SUB  X13, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x9d7a, LSL #0
    MOVK  X16, #0x5e7f, LSL #16
    MOVK  X16, #0xcc08, LSL #32
    MOVK  X16, #0x2519, LSL #48
    SUB  X13, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x89b4, LSL #0
    MOVK  X16, #0x80d6, LSL #16
    MOVK  X16, #0x5e7f, LSL #32
    MOVK  X16, #0x3a3c, LSL #48
    SUB  X13, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xa2dc, LSL #0
    MOVK  X16, #0x57f2, LSL #16
    MOVK  X16, #0xde84, LSL #32
    MOVK  X16, #0x683e, LSL #48
    SUB  X13, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x5d02, LSL #0
    MOVK  X16, #0x3c1e, LSL #16
    MOVK  X16, #0x9251, LSL #32
    MOVK  X16, #0xbfb4, LSL #48
    SUB  X13, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x3efa, LSL #0
    MOVK  X16, #0x3e27, LSL #16
    MOVK  X16, #0x168c, LSL #32
    MOVK  X16, #0x22a8, LSL #48
    SUB  X13, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xb5ca, LSL #0
    MOVK  X16, #0x3b0d, LSL #16
    MOVK  X16, #0x738f, LSL #32
    MOVK  X16, #0x2c89, LSL #48
    SUB  X13, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xb86c, LSL #0
    MOVK  X16, #0xc419, LSL #16
    MOVK  X16, #0xf9d7, LSL #32
    MOVK  X16, #0xee08, LSL #48
    SUB  X13, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x574a, LSL #0
    MOVK  X16, #0x6e67, LSL #16
    MOVK  X16, #0xce7b, LSL #32
    MOVK  X16, #0xc62, LSL #48
    SUB  X13, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x7d72, LSL #0
    MOVK  X16, #0x201b, LSL #16
    MOVK  X16, #0x2b64, LSL #32
    MOVK  X16, #0xdd38, LSL #48
    SUB  X13, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xf792, LSL #0
    MOVK  X16, #0xfbd7, LSL #16
    MOVK  X16, #0xba2f, LSL #32
    MOVK  X16, #0x1731, LSL #48
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x741f, LSL #0
    MOVK  X16, #0xcf13, LSL #16
    MOVK  X16, #0xabc3, LSL #32
    MOVK  X16, #0xe0ff, LSL #48
    SUB  X13, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xdfff, LSL #0
    MOVK  X16, #0x291b, LSL #16
    MOVK  X16, #0x8ae0, LSL #32
    MOVK  X16, #0xd766, LSL #48
    SUB  X13, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xaeac, LSL #0
    MOVK  X16, #0x36e1, LSL #16
    MOVK  X16, #0x9c5, LSL #32
    MOVK  X16, #0x1ecb, LSL #48
    SUB  X13, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x93f6, LSL #0
    MOVK  X16, #0x4ddb, LSL #16
    MOVK  X16, #0x26d4, LSL #32
    MOVK  X16, #0x49d2, LSL #48
    SUB  X13, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x790e, LSL #0
    MOVK  X16, #0x9ae7, LSL #16
    MOVK  X16, #0xd3e2, LSL #32
    MOVK  X16, #0xbaea, LSL #48
    SUB  X13, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0xe476, LSL #0
    MOVK  X16, #0xa33, LSL #16
    MOVK  X16, #0xecfb, LSL #32
    MOVK  X16, #0xc549, LSL #48
    SUB  X13, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MRS  X16, FPSR
    MOVZ  X13, #0x91, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X13, #0x7d72, LSL #0
    MOVK  X13, #0x201b, LSL #16
    MOVK  X13, #0x2b64, LSL #32
    MOVK  X13, #0xdd38, LSL #48
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D26
    MOVZ  X13, #0x7d72, LSL #0
    MOVK  X13, #0x201b, LSL #16
    MOVK  X13, #0x2b64, LSL #32
    MOVK  X13, #0xdd38, LSL #48
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FMOV  X16, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P3, Z0.D
    FMOV  X16, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X16, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X16, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X16, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X16, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D5, P6, Z5.D
    FMOV  X16, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X16, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D7, P7, Z7.D
    FMOV  X16, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X16, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D9, P0, Z9.D
    FMOV  X16, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X16, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D11, P5, Z11.D
    FMOV  X16, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X16, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D13, P3, Z13.D
    FMOV  X16, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X16, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X16, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X16, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X16, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D18, P3, Z18.D
    FMOV  X16, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X16, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D20, P3, Z20.D
    FMOV  X16, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X16, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X16, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X16, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X16, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X16, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X16, D26
    MOVZ  X13, #0x7d72, LSL #0
    MOVK  X13, #0x201b, LSL #16
    MOVK  X13, #0x2b64, LSL #32
    MOVK  X13, #0xdd58, LSL #48
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X16, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X16, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X16, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X16, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    FADDV   D31, P2, Z31.D
    FMOV  X16, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X26
    DUP     Z1.D, X25
    DUP     Z2.D, X12
    DUP     Z3.D, X9
    DUP     Z4.D, X13
    DUP     Z5.D, X11
    DUP     Z6.D, X14
    DUP     Z7.D, X17
    DUP     Z8.D, X27
    DUP     Z9.D, X24
    DUP     Z10.D, X15
    DUP     Z11.D, X23
    DUP     Z12.D, X28
    DUP     Z13.D, X29
    DUP     Z14.D, X10
    DUP     Z15.D, X27
    DUP     Z16.D, X9
    DUP     Z17.D, X25
    DUP     Z18.D, X27
    DUP     Z19.D, X16
    DUP     Z20.D, X5
    DUP     Z21.D, X16
    DUP     Z22.D, X29
    DUP     Z23.D, X26
    DUP     Z24.D, X27
    DUP     Z25.D, X27
    DUP     Z26.D, X3
    DUP     Z27.D, X16
    DUP     Z28.D, X9
    DUP     Z29.D, X26
    DUP     Z30.D, X10
    DUP     Z31.D, X9
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X5, #0xa, LSL #0
LCRTSveReductionOperations_label_11:
    EORV    S20, P7, Z20.S
    UMAXV   S11, P1, Z5.S
    ORV     H6, P0, Z30.H
    ANDV    B6, P5, Z28.B
    FMINV   S18, P2, Z0.S
    SADDV   D2, P6, Z13.H
    FADDA   S23, P3, S23, Z20.S
    FADDV   H19, P4, Z7.H
    UADDV   D8, P6, Z2.S
    FMINV   H29, P6, Z19.H
    SMINV   D27, P3, Z6.D
    FMINV   H21, P6, Z27.H
    SADDV   D11, P6, Z12.H
    EORV    H9, P4, Z23.H
    SADDV   D15, P3, Z16.B
    UADDV   D7, P3, Z19.B
    EORV    H27, P4, Z7.H
    ORV     D7, P1, Z11.D
    FADDA   S7, P7, S7, Z27.S
    UMINV   B27, P4, Z29.B
    EORV    S19, P2, Z14.S
    FADDV   D21, P2, Z26.D
    FMAXV   S14, P7, Z8.S
    EORV    H2, P6, Z2.H
    UMINV   S19, P4, Z7.S
    SMAXV   D29, P1, Z21.D
    SMAXV   D3, P3, Z27.D
    FADDA   H2, P4, H2, Z13.H
    UMINV   S21, P1, Z14.S
    EORV    H8, P1, Z18.H
    FMINV   H7, P1, Z3.H
    SMINV   H13, P7, Z8.H
    FMINV   H11, P6, Z7.H
    SMINV   S3, P2, Z13.S
    UMINV   H16, P0, Z3.H
    FMAXNMV S12, P7, Z1.S
    EORV    D13, P6, Z15.D
    FMAXNMV D1, P6, Z9.D
    FMAXNMV S3, P1, Z2.S
    FADDV   D21, P4, Z19.D
    FADDV   D8, P0, Z3.D
    SMAXV   B10, P3, Z1.B
    FADDA   H14, P1, H14, Z13.H
    SADDV   D23, P5, Z17.S
    SMAXV   D19, P6, Z14.D
    FMAXV   S16, P2, Z10.S
    SMAXV   B9, P2, Z11.B
    FADDV   S2, P6, Z16.S
    FMAXV   D1, P2, Z21.D
    FADDA   H8, P1, H8, Z1.H
    FMAXV   S23, P2, Z6.S
    SADDV   D1, P2, Z9.S
    UMINV   S16, P7, Z19.S
    FADDA   H29, P0, H29, Z12.H
    SMAXV   S27, P5, Z2.S
    FADDV   D12, P6, Z18.D
    FMINV   D9, P6, Z21.D
    ORV     H28, P3, Z23.H
    UMAXV   H23, P5, Z1.H
    UADDV   D18, P6, Z8.D
    ANDV    H19, P6, Z29.H
    ORV     S4, P2, Z27.S
    FADDV   D30, P7, Z22.D
    FMAXNMV D2, P1, Z28.D
    FMINV   S23, P6, Z12.S
    SADDV   D28, P7, Z9.H
    FMAXNMV S12, P7, Z19.S
    FMAXV   D1, P7, Z12.D
    FMINNMV D6, P6, Z17.D
    UMAXV   S27, P1, Z2.S
    FMINNMV D8, P6, Z23.D
    SMINV   D17, P5, Z15.D
    FMAXV   D10, P4, Z17.D
    SMINV   B12, P2, Z16.B
    SADDV   D15, P4, Z1.H
    FMINV   H11, P3, Z12.H
    SMAXV   D19, P0, Z2.D
    FADDA   D23, P6, D23, Z16.D
    ORV     H28, P7, Z27.H
    SMINV   B9, P4, Z8.B
    FMAXV   D2, P2, Z18.D
    UADDV   D17, P1, Z30.S
    ANDV    S8, P1, Z23.S
    SMAXV   D27, P1, Z9.D
    ORV     B1, P5, Z4.B
    FMAXV   S23, P3, Z6.S
    FMINNMV H6, P7, Z2.H
    FADDV   H12, P4, Z10.H
    ORV     B2, P6, Z15.B
    FMAXNMV H4, P0, Z19.H
    ANDV    D10, P1, Z28.D
    FMINV   D30, P0, Z17.D
    UMAXV   B6, P2, Z8.B
    FMAXV   D15, P2, Z29.D
    FMINNMV H6, P4, Z27.H
    UMAXV   D29, P0, Z23.D
    UMAXV   D28, P6, Z20.D
    UADDV   D20, P1, Z30.S
    FADDA   H11, P5, H11, Z1.H
    SMAXV   B17, P0, Z10.B
    SMINV   D14, P7, Z12.D
    UADDV   D9, P1, Z17.D
    FADDV   H14, P6, Z9.H
    SADDV   D12, P2, Z14.H
    SMINV   H30, P3, Z6.H
    FMINNMV D31, P1, Z11.D
    FADDV   S1, P5, Z8.S
    SMAXV   B17, P7, Z2.B
    SMINV   D9, P0, Z17.D
    FADDA   D30, P1, D30, Z4.D
    FADDV   D2, P7, Z4.D
    FADDV   D23, P5, Z20.D
    UADDV   D14, P4, Z28.D
    FMINNMV S4, P1, Z15.S
    EORV    H17, P7, Z9.H
    FMAXNMV H8, P4, Z9.H
    UADDV   D28, P2, Z8.B
    SADDV   D8, P3, Z14.H
    UMINV   D11, P2, Z31.D
    UMINV   H27, P1, Z28.H
    FADDV   D31, P1, Z11.D
    ANDV    S6, P5, Z23.S
    EORV    H20, P0, Z21.H
    FMAXNMV S24, P7, Z4.S
    FMAXNMV D15, P5, Z31.D
    FMAXV   H13, P1, Z29.H
    ORV     H29, P6, Z12.H
    SADDV   D9, P1, Z24.B
    FADDV   H4, P6, Z8.H
    ORV     B24, P0, Z2.B
    ORV     H4, P0, Z15.H
    FMAXNMV S2, P7, Z29.S
    SADDV   D31, P6, Z23.S
    UMINV   S29, P7, Z20.S
    FADDA   S27, P7, S27, Z6.S
    ANDV    H21, P6, Z13.H
    ORV     S11, P2, Z8.S
    FADDV   H8, P3, Z11.H
    ORV     D6, P6, Z21.D
    FMINV   H29, P6, Z24.H
    FMAXNMV H24, P1, Z17.H
    SMAXV   D11, P1, Z27.D
    SMINV   B20, P6, Z29.B
    SMAXV   B29, P6, Z4.B
    SMAXV   D21, P2, Z29.D
    UMINV   S17, P0, Z8.S
    FMAXV   D28, P4, Z11.D
    FMINV   S4, P7, Z24.S
    UADDV   D29, P0, Z21.B
    SMINV   S24, P3, Z31.S
    ORV     H26, P4, Z6.H
    UMAXV   D6, P3, Z24.D
    UADDV   D23, P5, Z20.H
    FADDV   S27, P7, Z27.S
    FADDV   D31, P6, Z4.D
    FADDA   H11, P3, H11, Z22.H
    SMINV   S21, P2, Z11.S
    FMAXNMV D22, P3, Z23.D
    SMAXV   H23, P5, Z21.H
    SMAXV   H21, P1, Z26.H
    UMINV   D24, P2, Z21.D
    FMINV   H7, P2, Z31.H
    FMINNMV S23, P2, Z24.S
    FMINNMV S21, P7, Z17.S
    UMAXV   B31, P4, Z28.B
    SADDV   D13, P1, Z8.H
    EORV    B12, P5, Z21.B
    FADDV   S17, P7, Z8.S
    FMINV   H1, P6, Z6.H
    FMINV   D28, P4, Z23.D
    SMAXV   S24, P6, Z13.S
    FADDV   S23, P5, Z22.S
    SADDV   D28, P2, Z4.H
    SADDV   D31, P5, Z31.H
    FADDA   D29, P7, D29, Z27.D
    FADDA   D17, P0, D17, Z24.D
    UMAXV   S7, P3, Z23.S
    SMAXV   H8, P5, Z28.H
    ORV     H20, P7, Z12.H
    FMINV   H11, P7, Z31.H
    UADDV   D6, P5, Z20.S
    SMINV   H5, P1, Z6.H
    FMINNMV D1, P1, Z27.D
    UMAXV   S6, P1, Z5.S
    FADDV   H31, P6, Z29.H
    FADDA   D6, P2, D6, Z5.D
    FMAXV   H27, P1, Z6.H
    UADDV   D22, P4, Z7.B
    SMAXV   B20, P6, Z11.B
    ORV     S0, P7, Z31.S
    SMAXV   S29, P3, Z27.S
    FADDA   S8, P2, S8, Z0.S
    FADDA   D29, P2, D29, Z12.D
    UADDV   D12, P0, Z31.B
    FMINNMV S0, P4, Z1.S
    SMAXV   B27, P7, Z1.B
    FMAXV   S3, P0, Z29.S
    UMINV   S24, P7, Z27.S
    FMINV   S1, P7, Z17.S
    UMAXV   H6, P6, Z24.H
    SUBS  X5, X5, #0x1
    B.NE  LCRTSveReductionOperations_label_11
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MRS  X15, FPSR
    MOVZ  X9, #0x91, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FMOV  X15, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P2, Z0.D
    FMOV  X15, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X15, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X15, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X15, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X15, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X15, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X15, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X15, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X15, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D9, P7, Z9.D
    FMOV  X15, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X15, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D11, P5, Z11.D
    FMOV  X15, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X15, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X15, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X15, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X15, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X15, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X15, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X15, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X15, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X15, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D21, P7, Z21.D
    FMOV  X15, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D22, P2, Z22.D
    FMOV  X15, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X15, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X15, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X15, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X15, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D27, P3, Z27.D
    FMOV  X15, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X15, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X15, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D30, P0, Z30.D
    FMOV  X15, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
    FADDV   D31, P3, Z31.D
    FMOV  X15, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X26
    DUP     Z1.D, X15
    DUP     Z2.D, X23
    DUP     Z3.D, X8
    DUP     Z4.D, X24
    DUP     Z5.D, X6
    DUP     Z6.D, X27
    DUP     Z7.D, X28
    DUP     Z8.D, X29
    DUP     Z9.D, X6
    DUP     Z10.D, X7
    DUP     Z11.D, X27
    DUP     Z12.D, X2
    DUP     Z13.D, X6
    DUP     Z14.D, X4
    DUP     Z15.D, X2
    DUP     Z16.D, X23
    DUP     Z17.D, X6
    DUP     Z18.D, X23
    DUP     Z19.D, X10
    DUP     Z20.D, X23
    DUP     Z21.D, X5
    DUP     Z22.D, X6
    DUP     Z23.D, X16
    DUP     Z24.D, X15
    DUP     Z25.D, X11
    DUP     Z26.D, X25
    DUP     Z27.D, X12
    DUP     Z28.D, X7
    DUP     Z29.D, X15
    DUP     Z30.D, X11
    DUP     Z31.D, X5
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X27, #0xa, LSL #0
LCRTSveReductionOperations_label_12:
    FMAXV   D25, P2, Z26.D
    FMINV   S1, P5, Z25.S
    UMINV   B29, P4, Z24.B
    FMAXNMV H10, P0, Z29.H
    FMINNMV H24, P1, Z10.H
    FADDV   S23, P3, Z24.S
    SMAXV   D17, P7, Z1.D
    SADDV   D5, P6, Z9.S
    EORV    D21, P7, Z16.D
    SMAXV   H24, P7, Z21.H
    SADDV   D22, P1, Z26.H
    SADDV   D24, P7, Z17.H
    ANDV    S17, P0, Z23.S
    FMAXNMV H6, P2, Z31.H
    EORV    H27, P2, Z6.H
    ANDV    S0, P7, Z27.S
    ANDV    S1, P4, Z24.S
    SMINV   S13, P6, Z16.S
    SMINV   D31, P7, Z8.D
    SADDV   D4, P4, Z13.B
    FMINNMV S13, P0, Z4.S
    FMINV   D22, P4, Z23.D
    SMINV   S4, P4, Z22.S
    FMAXV   S31, P2, Z13.S
    FMINV   D3, P3, Z1.D
    UMINV   D21, P3, Z3.D
    ANDV    B27, P5, Z14.B
    SMAXV   B16, P5, Z27.B
    UMINV   S22, P0, Z0.S
    UMAXV   S1, P0, Z1.S
    UMAXV   B0, P1, Z17.B
    UMINV   D25, P3, Z3.D
    ANDV    H14, P6, Z22.H
    FMINV   D9, P0, Z14.D
    UMINV   B14, P4, Z16.B
    SMAXV   B26, P1, Z1.B
    UADDV   D24, P1, Z7.D
    EORV    S23, P6, Z9.S
    FMINNMV H7, P1, Z31.H
    FMINNMV S13, P6, Z4.S
    UADDV   D17, P7, Z14.H
    SMINV   H15, P0, Z17.H
    UADDV   D4, P6, Z21.B
    UMAXV   D31, P6, Z4.D
    FADDV   S21, P3, Z13.S
    FMINNMV S9, P3, Z31.S
    UMAXV   H10, P2, Z26.H
    FADDA   H21, P2, H21, Z0.H
    UMINV   D31, P1, Z23.D
    UMAXV   S13, P6, Z24.S
    FMAXV   S0, P1, Z15.S
    FMINNMV H26, P4, Z7.H
    SMINV   D16, P3, Z9.D
    FADDA   S0, P7, S0, Z2.S
    UMAXV   B18, P3, Z21.B
    SADDV   D4, P4, Z26.S
    UMINV   S21, P5, Z20.S
    ANDV    H23, P6, Z10.H
    FMINNMV H7, P5, Z22.H
    ANDV    D2, P0, Z22.D
    FMINNMV D24, P6, Z31.D
    FMINV   D22, P4, Z2.D
    UMINV   B20, P3, Z24.B
    SADDV   D9, P1, Z6.B
    UMAXV   H11, P0, Z7.H
    UMINV   H22, P0, Z23.H
    UMINV   B6, P0, Z18.B
    EORV    H22, P0, Z13.H
    FMAXV   D3, P5, Z25.D
    FMINNMV H3, P6, Z0.H
    EORV    D17, P0, Z22.D
    SMAXV   H15, P4, Z9.H
    FMINV   H10, P3, Z8.H
    UMAXV   H25, P6, Z6.H
    FMINNMV D23, P4, Z25.D
    ANDV    D2, P2, Z21.D
    FMINNMV S7, P0, Z2.S
    UMAXV   B6, P6, Z14.B
    UMAXV   H13, P2, Z11.H
    FMINV   D21, P2, Z29.D
    EORV    D25, P0, Z10.D
    UADDV   D26, P2, Z21.B
    FMINV   S10, P0, Z26.S
    FMINV   S19, P6, Z23.S
    EORV    H24, P5, Z4.H
    FMINNMV S0, P4, Z13.S
    FADDA   S6, P5, S6, Z24.S
    FMAXNMV D2, P1, Z13.D
    FMINV   S13, P5, Z6.S
    ORV     D4, P1, Z0.D
    UMAXV   D2, P1, Z15.D
    UMINV   S11, P2, Z25.S
    UMAXV   S23, P3, Z10.S
    UADDV   D29, P3, Z11.S
    FMINNMV D15, P6, Z23.D
    EORV    H14, P4, Z2.H
    SADDV   D26, P2, Z14.B
    SMAXV   H21, P6, Z21.H
    EORV    D10, P1, Z29.D
    UMINV   B2, P3, Z19.B
    SADDV   D24, P3, Z21.H
    FMINNMV D0, P6, Z9.D
    UMAXV   D23, P6, Z5.D
    FMAXNMV D5, P2, Z28.D
    SMINV   H9, P0, Z7.H
    FMAXNMV D7, P1, Z20.D
    FMAXV   S7, P5, Z0.S
    FMINV   H8, P3, Z4.H
    UADDV   D6, P4, Z13.S
    SADDV   D25, P0, Z1.S
    ANDV    S29, P4, Z11.S
    ORV     B14, P5, Z9.B
    FADDV   H21, P0, Z26.H
    SMAXV   S0, P5, Z8.S
    FADDA   D6, P5, D6, Z10.D
    UADDV   D28, P0, Z15.H
    FMAXNMV S4, P5, Z25.S
    UADDV   D15, P1, Z14.S
    FMINNMV D13, P0, Z13.D
    FMINV   H2, P0, Z1.H
    UADDV   D10, P4, Z24.H
    FADDA   D10, P3, D10, Z28.D
    SMAXV   S25, P7, Z21.S
    UADDV   D28, P2, Z29.B
    SMINV   D20, P2, Z25.D
    ORV     H11, P0, Z7.H
    SMAXV   H20, P6, Z13.H
    FMAXV   H21, P4, Z0.H
    SADDV   D4, P6, Z16.H
    FADDA   S28, P7, S28, Z10.S
    ORV     D10, P2, Z6.D
    ORV     D14, P7, Z4.D
    UMAXV   D7, P4, Z11.D
    SMINV   D13, P0, Z28.D
    SMINV   D16, P5, Z20.D
    ANDV    H25, P3, Z16.H
    FADDV   D29, P5, Z0.D
    FMINNMV H6, P7, Z15.H
    UMINV   H15, P2, Z21.H
    FMINV   D15, P1, Z15.D
    FMAXV   D4, P7, Z25.D
    SMAXV   B9, P4, Z7.B
    FMAXV   D2, P5, Z29.D
    SMINV   D0, P7, Z10.D
    UADDV   D10, P6, Z7.D
    UMINV   B16, P0, Z9.B
    FMAXV   D1, P4, Z14.D
    FMINV   D24, P3, Z22.D
    ANDV    B9, P6, Z0.B
    FADDV   S25, P2, Z3.S
    SADDV   D22, P3, Z25.B
    FMAXNMV D28, P7, Z10.D
    SMINV   S11, P1, Z18.S
    UADDV   D7, P3, Z13.S
    FMINNMV D13, P2, Z25.D
    UADDV   D18, P1, Z16.D
    SMAXV   H29, P4, Z15.H
    EORV    H19, P1, Z4.H
    FMINNMV S16, P3, Z14.S
    EORV    H15, P6, Z19.H
    EORV    B10, P6, Z17.B
    ORV     S17, P3, Z16.S
    UADDV   D7, P2, Z9.B
    UMAXV   B3, P4, Z1.B
    UADDV   D0, P2, Z15.S
    SMAXV   B4, P3, Z18.B
    FMINNMV H25, P1, Z3.H
    SMINV   S11, P7, Z4.S
    UMAXV   D14, P7, Z10.D
    SADDV   D8, P3, Z28.B
    UMAXV   B15, P4, Z17.B
    UADDV   D3, P5, Z28.D
    SADDV   D28, P0, Z11.B
    EORV    H28, P7, Z29.H
    SADDV   D11, P2, Z8.B
    FMAXV   H16, P4, Z24.H
    SMINV   D22, P4, Z0.D
    SADDV   D5, P6, Z28.S
    ORV     H4, P0, Z3.H
    UMAXV   S28, P0, Z6.S
    FMAXNMV S17, P0, Z4.S
    FMAXV   D19, P0, Z17.D
    FMINV   H1, P4, Z13.H
    EORV    D10, P1, Z7.D
    ORV     B3, P1, Z27.B
    UMAXV   D29, P1, Z16.D
    SADDV   D8, P4, Z29.H
    FMINV   S6, P0, Z2.S
    UADDV   D15, P1, Z26.D
    SMAXV   D13, P3, Z22.D
    SMAXV   D0, P4, Z6.D
    UMAXV   S24, P0, Z1.S
    SADDV   D7, P0, Z15.H
    UMAXV   B18, P0, Z13.B
    UADDV   D22, P2, Z24.S
    ANDV    D16, P6, Z8.D
    SMINV   H17, P7, Z7.H
    SMINV   B15, P4, Z30.B
    FMAXNMV S2, P7, Z19.S
    UMAXV   D29, P3, Z23.D
    SUBS  X27, X27, #0x1
    B.NE  LCRTSveReductionOperations_label_12
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MRS  X11, FPSR
    MOVZ  X25, #0x91, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D12
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D15
    MOVZ  X25, #0xff, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D25
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D30
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FMOV  X11, D31
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P3, Z0.D
    FMOV  X11, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X11, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X11, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X11, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X11, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X11, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X11, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X11, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X11, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X11, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X11, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D11, P6, Z11.D
    FMOV  X11, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D12, P3, Z12.D
    FMOV  X11, D12
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D13, P0, Z13.D
    FMOV  X11, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X11, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X11, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X11, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X11, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X11, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X11, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X11, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X11, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X11, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D23, P1, Z23.D
    FMOV  X11, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D24, P0, Z24.D
    FMOV  X11, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X11, D25
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D26, P4, Z26.D
    FMOV  X11, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D27, P7, Z27.D
    FMOV  X11, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X11, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X11, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X11, D30
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X11, D31
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X27
    DUP     Z1.D, X24
    DUP     Z2.D, X26
    DUP     Z3.D, X25
    DUP     Z4.D, X9
    DUP     Z5.D, X29
    DUP     Z6.D, X28
    DUP     Z7.D, X25
    DUP     Z8.D, X29
    DUP     Z9.D, X23
    DUP     Z10.D, X25
    DUP     Z11.D, X25
    DUP     Z12.D, X5
    DUP     Z13.D, X3
    DUP     Z14.D, X16
    DUP     Z15.D, X25
    DUP     Z16.D, X3
    DUP     Z17.D, X4
    DUP     Z18.D, X8
    DUP     Z19.D, X7
    DUP     Z20.D, X16
    DUP     Z21.D, X10
    DUP     Z22.D, X8
    DUP     Z23.D, X3
    DUP     Z24.D, X6
    DUP     Z25.D, X9
    DUP     Z26.D, X16
    DUP     Z27.D, X2
    DUP     Z28.D, X2
    DUP     Z29.D, X27
    DUP     Z30.D, X2
    DUP     Z31.D, X6
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X28, #0xa, LSL #0
LCRTSveReductionOperations_label_13:
    EORV    S14, P6, Z14.S
    FMAXV   S23, P7, Z28.S
    UMAXV   S16, P3, Z26.S
    FADDV   S23, P3, Z14.S
    FMINV   D8, P4, Z23.D
    SMAXV   H16, P2, Z8.H
    ORV     D0, P5, Z16.D
    EORV    H27, P1, Z31.H
    SADDV   D14, P7, Z0.H
    ANDV    B20, P6, Z14.B
    FADDV   H14, P7, Z0.H
    FMAXNMV S27, P3, Z27.S
    FADDV   S20, P6, Z28.S
    FADDA   H20, P4, H20, Z20.H
    UADDV   D13, P3, Z27.D
    FMINNMV D16, P0, Z21.D
    SMAXV   B2, P3, Z11.B
    FADDV   D5, P6, Z2.D
    SMINV   B29, P1, Z14.B
    ANDV    B5, P2, Z7.B
    SMINV   S9, P5, Z3.S
    ANDV    H9, P1, Z16.H
    FMAXV   H5, P0, Z29.H
    ORV     D29, P0, Z0.D
    SMINV   S8, P0, Z13.S
    ORV     S13, P4, Z8.S
    UMAXV   H7, P6, Z19.H
    SMINV   S21, P3, Z5.S
    SMINV   S16, P0, Z29.S
    UADDV   D8, P6, Z16.H
    FMINV   H5, P4, Z1.H
    SMINV   B28, P4, Z1.B
    FADDA   S28, P6, S28, Z15.S
    FMAXV   H2, P7, Z13.H
    EORV    H16, P0, Z9.H
    SADDV   D13, P6, Z16.H
    FMINV   D1, P0, Z13.D
    FMAXNMV H19, P0, Z5.H
    SMINV   B29, P1, Z28.B
    SMINV   S15, P6, Z24.S
    FMAXV   H5, P6, Z0.H
    SADDV   D24, P4, Z19.H
    UMAXV   D29, P2, Z2.D
    UADDV   D21, P6, Z7.B
    FMINNMV S9, P2, Z8.S
    ANDV    S15, P1, Z5.S
    SADDV   D16, P2, Z23.S
    SMINV   B0, P3, Z14.B
    SMAXV   S2, P1, Z7.S
    FADDV   H8, P4, Z4.H
    FMAXNMV S5, P6, Z22.S
    FADDA   H7, P7, H7, Z18.H
    UMINV   S4, P4, Z24.S
    ANDV    D22, P2, Z2.D
    SADDV   D14, P2, Z1.S
    SMINV   D12, P5, Z14.D
    SMINV   D23, P7, Z3.D
    FMINV   S2, P0, Z15.S
    FADDA   D9, P6, D9, Z22.D
    FMINNMV H30, P0, Z4.H
    FMINNMV D16, P2, Z31.D
    FMINV   D27, P3, Z9.D
    ORV     S19, P6, Z23.S
    SADDV   D18, P2, Z30.S
    ANDV    D4, P3, Z5.D
    UMAXV   S1, P5, Z24.S
    UADDV   D16, P6, Z12.H
    ORV     B9, P3, Z8.B
    FMINV   H24, P2, Z22.H
    SADDV   D3, P2, Z24.H
    SMAXV   B15, P3, Z9.B
    EORV    D8, P1, Z4.D
    SADDV   D9, P2, Z2.B
    FMINV   D22, P6, Z19.D
    ORV     S5, P4, Z15.S
    FADDV   D20, P1, Z16.D
    UADDV   D31, P2, Z3.H
    FADDA   H21, P2, H21, Z7.H
    FADDV   D7, P7, Z9.D
    UMAXV   H19, P1, Z20.H
    SMINV   H14, P4, Z16.H
    FMINV   S12, P3, Z8.S
    ANDV    D16, P1, Z25.D
    UADDV   D15, P5, Z27.H
    ANDV    H24, P5, Z14.H
    FMAXNMV H4, P0, Z16.H
    FMAXNMV S23, P3, Z21.S
    SADDV   D20, P6, Z5.S
    SMAXV   H8, P4, Z7.H
    SADDV   D30, P4, Z19.H
    FMAXV   S27, P1, Z4.S
    FMAXNMV D4, P1, Z24.D
    FMINNMV D26, P0, Z30.D
    FMINV   S14, P7, Z22.S
    FADDV   S5, P6, Z6.S
    ORV     B9, P6, Z12.B
    FADDA   H15, P6, H15, Z14.H
    UMINV   B25, P4, Z9.B
    SADDV   D3, P5, Z31.H
    UMAXV   S7, P3, Z20.S
    UMAXV   H31, P7, Z27.H
    SADDV   D6, P5, Z31.H
    FMINNMV S9, P4, Z8.S
    SMAXV   S12, P6, Z7.S
    SADDV   D24, P4, Z15.S
    UMAXV   H19, P5, Z25.H
    UMAXV   S20, P6, Z26.S
    FMINNMV D21, P6, Z12.D
    ANDV    D22, P4, Z6.D
    ORV     S15, P1, Z3.S
    SMAXV   S6, P1, Z21.S
    FMINNMV S31, P1, Z4.S
    FMINNMV S4, P1, Z6.S
    UMINV   B16, P0, Z22.B
    SMAXV   B8, P0, Z19.B
    SADDV   D12, P4, Z31.H
    UMINV   H27, P1, Z20.H
    UADDV   D3, P3, Z5.B
    SMINV   S18, P7, Z4.S
    UADDV   D20, P2, Z18.D
    UMAXV   S19, P4, Z3.S
    FMINV   S21, P0, Z4.S
    FMINNMV S2, P3, Z9.S
    SADDV   D6, P6, Z6.B
    UMAXV   B18, P1, Z24.B
    UMAXV   S25, P0, Z20.S
    FMAXV   H24, P5, Z15.H
    ORV     D19, P0, Z2.D
    UMAXV   D7, P3, Z27.D
    FMAXV   H20, P3, Z24.H
    UMAXV   H9, P5, Z6.H
    FMAXV   D24, P5, Z9.D
    FMINNMV S4, P6, Z21.S
    FMAXV   D0, P7, Z4.D
    FADDA   S22, P0, S22, Z24.S
    FMINNMV H21, P2, Z8.H
    SADDV   D29, P7, Z7.S
    EORV    B8, P0, Z0.B
    EORV    B2, P4, Z29.B
    FMAXV   H29, P3, Z19.H
    UMINV   D4, P6, Z25.D
    UADDV   D0, P6, Z21.B
    UADDV   D17, P7, Z29.D
    FMAXNMV H15, P4, Z26.H
    ORV     S24, P3, Z22.S
    UMAXV   S29, P1, Z15.S
    ANDV    H30, P4, Z3.H
    ANDV    S19, P0, Z2.S
    ORV     H22, P2, Z4.H
    SMINV   B17, P1, Z22.B
    UMINV   B7, P1, Z7.B
    SMAXV   D3, P6, Z0.D
    SADDV   D12, P3, Z17.H
    SMINV   H22, P5, Z8.H
    FMINNMV S17, P0, Z15.S
    UMAXV   S26, P5, Z29.S
    UADDV   D0, P4, Z17.H
    EORV    D11, P4, Z25.D
    FMAXV   S27, P3, Z22.S
    FADDA   H11, P7, H11, Z19.H
    EORV    H20, P6, Z0.H
    FMINV   D2, P3, Z11.D
    ANDV    B15, P1, Z20.B
    EORV    H17, P4, Z26.H
    ORV     D4, P1, Z3.D
    FADDA   H17, P1, H17, Z31.H
    UMINV   D29, P5, Z17.D
    UMINV   B0, P4, Z24.B
    UMINV   S31, P4, Z2.S
    SMINV   S3, P7, Z27.S
    UMINV   D20, P1, Z31.D
    FMINV   D27, P4, Z15.D
    SADDV   D26, P4, Z3.B
    SMAXV   S2, P7, Z30.S
    EORV    D15, P4, Z20.D
    SADDV   D11, P7, Z26.S
    SMAXV   D16, P5, Z29.D
    EORV    D25, P0, Z11.D
    FMINNMV D23, P1, Z27.D
    UMINV   D8, P4, Z25.D
    UADDV   D28, P6, Z15.H
    SMAXV   B22, P5, Z2.B
    EORV    D20, P4, Z28.D
    FADDV   D29, P1, Z22.D
    UMINV   H10, P1, Z27.H
    SMAXV   B16, P5, Z4.B
    FMAXV   H3, P7, Z16.H
    UMINV   D15, P0, Z14.D
    UADDV   D2, P5, Z29.H
    FADDA   S25, P2, S25, Z12.S
    SMINV   S28, P2, Z15.S
    ANDV    D31, P7, Z26.D
    ORV     B30, P6, Z30.B
    FADDV   S11, P5, Z6.S
    UADDV   D4, P0, Z4.D
    UMINV   S28, P1, Z30.S
    SMINV   B6, P3, Z2.B
    EORV    S24, P4, Z6.S
    FMAXV   D14, P0, Z25.D
    UADDV   D17, P6, Z4.D
    SUBS  X28, X28, #0x1
    B.NE  LCRTSveReductionOperations_label_13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X24, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTSveReductionOperations_TestFail
    MRS  X5, FPSR
    MOVZ  X24, #0x91, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FMOV  X5, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P7, Z0.D
    FMOV  X5, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X5, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X5, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X5, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X5, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X5, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X5, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D7, P2, Z7.D
    FMOV  X5, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X5, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X5, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X5, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X5, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X5, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X5, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D14, P1, Z14.D
    FMOV  X5, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X5, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X5, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X5, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X5, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X5, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D20, P3, Z20.D
    FMOV  X5, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D21, P1, Z21.D
    FMOV  X5, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X5, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D23, P1, Z23.D
    FMOV  X5, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X5, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D25, P3, Z25.D
    FMOV  X5, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X5, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X5, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X5, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X5, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X5, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X5, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTSveReductionOperations_TestFail
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
    DUP     Z0.D, X25
    DUP     Z1.D, X27
    DUP     Z2.D, X28
    DUP     Z3.D, X5
    DUP     Z4.D, X26
    DUP     Z5.D, X29
    DUP     Z6.D, X11
    DUP     Z7.D, X5
    DUP     Z8.D, X16
    DUP     Z9.D, X23
    DUP     Z10.D, X4
    DUP     Z11.D, X13
    DUP     Z12.D, X29
    DUP     Z13.D, X15
    DUP     Z14.D, X29
    DUP     Z15.D, X10
    DUP     Z16.D, X7
    DUP     Z17.D, X16
    DUP     Z18.D, X27
    DUP     Z19.D, X28
    DUP     Z20.D, X2
    DUP     Z21.D, X17
    DUP     Z22.D, X14
    DUP     Z23.D, X11
    DUP     Z24.D, X28
    DUP     Z25.D, X3
    DUP     Z26.D, X4
    DUP     Z27.D, X16
    DUP     Z28.D, X6
    DUP     Z29.D, X4
    DUP     Z30.D, X29
    DUP     Z31.D, X10
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X7, #0xa, LSL #0
LCRTSveReductionOperations_label_14:
    UMINV   S24, P4, Z29.S
    SADDV   D2, P2, Z25.H
    FADDV   H7, P3, Z3.H
    UADDV   D22, P2, Z0.D
    UMAXV   S21, P1, Z2.S
    FMAXV   S31, P5, Z21.S
    SMINV   D10, P6, Z24.D
    SADDV   D24, P7, Z2.B
    UADDV   D20, P6, Z24.H
    EORV    B20, P7, Z7.B
    FMAXNMV D27, P3, Z10.D
    FMAXNMV H28, P1, Z31.H
    SMAXV   S30, P6, Z28.S
    UADDV   D31, P1, Z30.H
    SMAXV   S6, P0, Z19.S
    ANDV    B17, P3, Z22.B
    EORV    D17, P6, Z17.D
    EORV    S20, P2, Z1.S
    FADDA   H20, P6, H20, Z17.H
    ORV     B8, P3, Z27.B
    UMINV   B0, P6, Z19.B
    SMAXV   B1, P0, Z6.B
    SMINV   D3, P2, Z19.D
    SMINV   D6, P0, Z20.D
    SMAXV   S10, P1, Z0.S
    SADDV   D17, P6, Z15.H
    UMINV   H20, P1, Z8.H
    FMINV   H8, P0, Z10.H
    UMAXV   B0, P0, Z31.B
    SMINV   S10, P2, Z14.S
    FADDA   S3, P4, S3, Z11.S
    ORV     B31, P3, Z8.B
    ANDV    S22, P1, Z27.S
    SMAXV   H11, P7, Z20.H
    FMINNMV D6, P3, Z6.D
    SMAXV   H1, P4, Z23.H
    SADDV   D19, P4, Z3.S
    UMAXV   S15, P5, Z6.S
    UMINV   H27, P1, Z4.H
    FADDA   H12, P3, H12, Z0.H
    EORV    D8, P6, Z26.D
    ANDV    D28, P6, Z1.D
    FADDV   D22, P7, Z14.D
    SMAXV   S26, P5, Z21.S
    FMINV   H24, P7, Z10.H
    SMAXV   H23, P6, Z27.H
    UMINV   H3, P0, Z23.H
    SMINV   B26, P1, Z17.B
    ANDV    S28, P4, Z22.S
    UMAXV   B17, P2, Z28.B
    FADDV   D27, P2, Z6.D
    SMINV   D1, P1, Z16.D
    FMAXV   H0, P7, Z27.H
    SMAXV   B22, P5, Z11.B
    ORV     S27, P1, Z17.S
    SMINV   D14, P1, Z5.D
    FMAXNMV D21, P5, Z12.D
    UMINV   S11, P7, Z3.S
    SADDV   D10, P1, Z0.B
    FADDA   D8, P6, D8, Z21.D
    UADDV   D17, P4, Z30.H
    FADDA   H31, P2, H31, Z18.H
    ANDV    B29, P3, Z14.B
    FADDV   S21, P5, Z16.S
    FADDA   H15, P5, H15, Z18.H
    FMINV   S30, P6, Z27.S
    FADDV   H0, P3, Z17.H
    ORV     D23, P0, Z11.D
    UMINV   H28, P5, Z1.H
    FMAXV   D11, P7, Z21.D
    FADDV   H12, P4, Z6.H
    ORV     D21, P6, Z31.D
    FMAXV   S16, P3, Z24.S
    ANDV    B28, P7, Z25.B
    SMINV   S3, P4, Z4.S
    EORV    D5, P2, Z21.D
    FADDA   H0, P0, H0, Z0.H
    FADDV   D27, P1, Z8.D
    UADDV   D31, P3, Z24.S
    FADDA   D16, P6, D16, Z16.D
    SMAXV   H24, P4, Z29.H
    SMAXV   D29, P1, Z23.D
    FADDV   S25, P5, Z0.S
    UADDV   D6, P6, Z28.B
    FMINV   S18, P4, Z25.S
    FADDV   D17, P4, Z3.D
    SADDV   D4, P5, Z1.S
    EORV    S28, P7, Z28.S
    SMAXV   S18, P5, Z25.S
    ANDV    D23, P1, Z28.D
    UMINV   H25, P1, Z24.H
    SMAXV   D29, P4, Z27.D
    FMAXNMV S1, P1, Z16.S
    SADDV   D24, P7, Z29.H
    ORV     D29, P1, Z24.D
    FMINNMV D16, P2, Z18.D
    UMINV   B28, P2, Z17.B
    EORV    B0, P4, Z1.B
    SMAXV   B27, P2, Z12.B
    FMAXV   H1, P5, Z21.H
    FMAXV   D20, P7, Z1.D
    UADDV   D18, P2, Z23.H
    FMINNMV H8, P3, Z25.H
    EORV    S8, P3, Z20.S
    ANDV    S25, P2, Z29.S
    SADDV   D10, P7, Z28.S
    FADDV   S21, P2, Z11.S
    FMINNMV D23, P1, Z25.D
    UMAXV   B12, P2, Z31.B
    FADDV   H27, P0, Z10.H
    SMAXV   D25, P3, Z21.D
    FADDV   D28, P1, Z13.D
    ORV     B13, P5, Z29.B
    SMAXV   D11, P0, Z27.D
    ORV     B21, P2, Z18.B
    SMAXV   D29, P3, Z16.D
    UMINV   S1, P5, Z8.S
    FMINV   D27, P2, Z1.D
    FADDV   S8, P2, Z4.S
    ORV     S31, P0, Z31.S
    SMAXV   S26, P6, Z8.S
    ANDV    D1, P6, Z13.D
    ANDV    S21, P7, Z28.S
    UMINV   S4, P0, Z17.S
    UMAXV   D17, P6, Z16.D
    FMINV   H16, P2, Z29.H
    FMINNMV H25, P2, Z31.H
    FMINNMV H12, P1, Z17.H
    ANDV    B20, P3, Z4.B
    FADDV   S29, P7, Z15.S
    SMAXV   B8, P3, Z1.B
    UADDV   D13, P2, Z29.S
    FMINNMV S10, P5, Z11.S
    FADDA   H27, P1, H27, Z4.H
    UMINV   B14, P2, Z16.B
    FADDA   S8, P3, S8, Z20.S
    UMAXV   S16, P7, Z29.S
    EORV    S19, P4, Z13.S
    ANDV    H17, P3, Z6.H
    SMINV   D13, P0, Z19.D
    FADDV   D3, P7, Z21.D
    FMINV   S19, P0, Z13.S
    UADDV   D13, P5, Z27.S
    FADDA   H29, P6, H29, Z10.H
    UADDV   D27, P5, Z12.H
    FADDV   S20, P7, Z3.S
    SMAXV   D1, P6, Z20.D
    UMAXV   B3, P7, Z10.B
    EORV    H11, P2, Z16.H
    ORV     S4, P7, Z13.S
    UMAXV   S7, P2, Z3.S
    SMINV   S16, P1, Z30.S
    UMINV   S22, P5, Z17.S
    SMAXV   H21, P4, Z29.H
    FADDA   H1, P7, H1, Z4.H
    UMINV   S4, P6, Z14.S
    FADDV   S20, P7, Z1.S
    ORV     S15, P2, Z7.S
    FMAXNMV H13, P0, Z4.H
    ORV     S30, P7, Z27.S
    FADDV   H14, P2, Z16.H
    EORV    H29, P5, Z17.H
    UADDV   D27, P4, Z22.H
    FADDA   S13, P1, S13, Z30.S
    UMINV   D17, P4, Z15.D
    FADDV   H15, P1, Z29.H
    UMAXV   D1, P1, Z15.D
    EORV    S23, P1, Z1.S
    UMAXV   H22, P7, Z19.H
    SMAXV   H4, P1, Z21.H
    UMINV   H15, P6, Z22.H
    UMAXV   B30, P3, Z13.B
    FMAXNMV H13, P6, Z0.H
    UMAXV   B21, P1, Z15.B
    UMAXV   B0, P0, Z23.B
    ORV     B3, P4, Z4.B
    SMAXV   H19, P3, Z0.H
    FMINNMV D12, P5, Z14.D
    FADDA   S27, P3, S27, Z27.S
    SMAXV   H14, P2, Z19.H
    FADDV   D23, P4, Z27.D
    UMAXV   B1, P7, Z17.B
    ORV     H27, P0, Z24.H
    UADDV   D24, P2, Z27.D
    FMAXNMV S15, P5, Z23.S
    SMAXV   D7, P5, Z14.D
    SMAXV   B4, P2, Z15.B
    FMAXV   S29, P0, Z1.S
    UMINV   D23, P6, Z29.D
    UMINV   B1, P0, Z24.B
    UMAXV   B28, P4, Z30.B
    EORV    D17, P3, Z22.D
    FMINV   D24, P7, Z1.D
    FMINNMV D1, P6, Z12.D
    ANDV    D7, P0, Z7.D
    FMINNMV H15, P3, Z4.H
    UADDV   D27, P3, Z24.S
    EORV    S12, P7, Z12.S
    EORV    S4, P5, Z13.S
    SMINV   S7, P3, Z4.S
    SUBS  X7, X7, #0x1
    B.NE  LCRTSveReductionOperations_label_14
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveReductionOperations_TestFail
    MRS  X10, FPSR
    MOVZ  X9, #0x91, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D9
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FMOV  X10, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P7, Z0.D
    FMOV  X10, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X10, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X10, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D3, P4, Z3.D
    FMOV  X10, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X10, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X10, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X10, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X10, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X10, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D9, P5, Z9.D
    FMOV  X10, D9
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X10, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X10, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X10, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X10, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X10, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X10, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D16, P1, Z16.D
    FMOV  X10, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X10, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X10, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D19, P0, Z19.D
    FMOV  X10, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X10, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D21, P2, Z21.D
    FMOV  X10, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X10, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D23, P3, Z23.D
    FMOV  X10, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X10, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X10, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X10, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X10, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X10, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D29, P0, Z29.D
    FMOV  X10, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X10, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X10, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveReductionOperations_TestFail

LCRTSveReductionOperations_TestEnd:
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
LCRTSveReductionOperations_TestFail:
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
