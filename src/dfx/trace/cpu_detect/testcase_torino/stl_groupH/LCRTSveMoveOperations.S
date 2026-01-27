.global LCRTSveMoveOperations

.text
.p2align 4

LCRTSveMoveOperations:

LCRTSveMoveOperations_TestBegin:
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
    MOVZ  X2, #0x3a0d, LSL #0
    MOVK  X2, #0x94ba, LSL #16
    MOVK  X2, #0x7f47, LSL #32
    MOVK  X2, #0x22c7, LSL #48
    MOVZ  X3, #0x23c, LSL #0
    MOVK  X3, #0xfd79, LSL #16
    MOVK  X3, #0xc9db, LSL #32
    MOVK  X3, #0xad61, LSL #48
    MOVZ  X4, #0xe3bb, LSL #0
    MOVK  X4, #0x7e2f, LSL #16
    MOVK  X4, #0x62e5, LSL #32
    MOVK  X4, #0xa7b4, LSL #48
    MOVZ  X5, #0xbde1, LSL #0
    MOVK  X5, #0x326c, LSL #16
    MOVK  X5, #0xf13, LSL #32
    MOVK  X5, #0x7cbf, LSL #48
    MOVZ  X6, #0x57df, LSL #0
    MOVK  X6, #0x22a2, LSL #16
    MOVK  X6, #0x4042, LSL #32
    MOVK  X6, #0xd7bc, LSL #48
    MOVZ  X7, #0xf817, LSL #0
    MOVK  X7, #0xb98e, LSL #16
    MOVK  X7, #0xe9ba, LSL #32
    MOVK  X7, #0xf1e2, LSL #48
    MOVZ  X8, #0x3190, LSL #0
    MOVK  X8, #0xd17b, LSL #16
    MOVK  X8, #0x449a, LSL #32
    MOVK  X8, #0xb8ec, LSL #48
    MOVZ  X9, #0x3c56, LSL #0
    MOVK  X9, #0x9614, LSL #16
    MOVK  X9, #0xc0a1, LSL #32
    MOVK  X9, #0x8cd0, LSL #48
    MOVZ  X10, #0xf662, LSL #0
    MOVK  X10, #0x9a5f, LSL #16
    MOVK  X10, #0x9e36, LSL #32
    MOVK  X10, #0xd5c4, LSL #48
    MOVZ  X11, #0x9547, LSL #0
    MOVK  X11, #0xfec7, LSL #16
    MOVK  X11, #0xa44, LSL #32
    MOVK  X11, #0xc1d2, LSL #48
    MOVZ  X12, #0xf11f, LSL #0
    MOVK  X12, #0x687b, LSL #16
    MOVK  X12, #0x6173, LSL #32
    MOVK  X12, #0x16d1, LSL #48
    MOVZ  X13, #0x3273, LSL #0
    MOVK  X13, #0x73d3, LSL #16
    MOVK  X13, #0x2717, LSL #32
    MOVK  X13, #0x1e53, LSL #48
    MOVZ  X14, #0x8682, LSL #0
    MOVK  X14, #0x3e18, LSL #16
    MOVK  X14, #0xe239, LSL #32
    MOVK  X14, #0xd317, LSL #48
    MOVZ  X15, #0x7860, LSL #0
    MOVK  X15, #0xdeb9, LSL #16
    MOVK  X15, #0xe146, LSL #32
    MOVK  X15, #0x2b69, LSL #48
    MOVZ  X16, #0xd836, LSL #0
    MOVK  X16, #0x7c45, LSL #16
    MOVK  X16, #0xd62, LSL #32
    MOVK  X16, #0xdba5, LSL #48
    MOVZ  X17, #0xa27f, LSL #0
    MOVK  X17, #0x29c4, LSL #16
    MOVK  X17, #0x4c58, LSL #32
    MOVK  X17, #0xe15b, LSL #48
    MOVZ  X18, #0x7d7b, LSL #0
    MOVK  X18, #0x6e69, LSL #16
    MOVK  X18, #0x66e6, LSL #32
    MOVK  X18, #0xe0be, LSL #48
    MOVZ  X19, #0xf81b, LSL #0
    MOVK  X19, #0x8b7c, LSL #16
    MOVK  X19, #0x2e31, LSL #32
    MOVK  X19, #0xebca, LSL #48
    MOVZ  X20, #0x6370, LSL #0
    MOVK  X20, #0xc584, LSL #16
    MOVK  X20, #0xe346, LSL #32
    MOVK  X20, #0xf3e2, LSL #48
    MOVZ  X21, #0x5fe7, LSL #0
    MOVK  X21, #0x3ed, LSL #16
    MOVK  X21, #0xb4ad, LSL #32
    MOVK  X21, #0x7c16, LSL #48
    MOVZ  X22, #0xb267, LSL #0
    MOVK  X22, #0x19b, LSL #16
    MOVK  X22, #0x5d37, LSL #32
    MOVK  X22, #0xddfa, LSL #48
    MOVZ  X23, #0x5c49, LSL #0
    MOVK  X23, #0x3001, LSL #16
    MOVK  X23, #0xa434, LSL #32
    MOVK  X23, #0x7ee1, LSL #48
    MOVZ  X24, #0xb8eb, LSL #0
    MOVK  X24, #0x1028, LSL #16
    MOVK  X24, #0x4dc9, LSL #32
    MOVK  X24, #0xe3a0, LSL #48
    MOVZ  X18, #0x2b01, LSL #0
    MOVK  X18, #0x93fb, LSL #16
    MOVK  X18, #0x3034, LSL #32
    MOVK  X18, #0x1d98, LSL #48
    MSR  FPCR, X18
    MRS  X24, FPCR
    MOVZ  X10, #0x60ff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    AND  X24, X24, X10
    MOVZ  X10, #0x0, LSL #0
    ORR  X24, X24, X10
    MSR  FPCR, X24
    ISB  SY
    MOVZ  X18, #0x5206, LSL #0
    MOVK  X18, #0x1a77, LSL #16
    MOVK  X18, #0x1827, LSL #32
    MOVK  X18, #0x6cc1, LSL #48
    MSR  FPSR, X18
    MRS  X18, FPSR
    MOVZ  X2, #0xff60, LSL #0
    MOVK  X2, #0x7ff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X18, X18, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X18, X18, X2
    MSR  FPSR, X18
    ISB  SY
    ADDS  X13, X2, #0xfb2, LSL #12
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xa7fd, LSL #0
    MOVK  X2, #0x75b, LSL #16
    MOVK  X2, #0x85f1, LSL #32
    MOVK  X2, #0xf23d, LSL #48
    MOVZ  X3, #0xd213, LSL #0
    MOVK  X3, #0x2294, LSL #16
    MOVK  X3, #0xb22, LSL #32
    MOVK  X3, #0xfa2, LSL #48
    MOVZ  X4, #0x5421, LSL #0
    MOVK  X4, #0x684a, LSL #16
    MOVK  X4, #0x9cfc, LSL #32
    MOVK  X4, #0x4d64, LSL #48
    MOVZ  X5, #0x238c, LSL #0
    MOVK  X5, #0x9a92, LSL #16
    MOVK  X5, #0x8351, LSL #32
    MOVK  X5, #0x9cfd, LSL #48
    MOVZ  X6, #0x8a74, LSL #0
    MOVK  X6, #0xb447, LSL #16
    MOVK  X6, #0x5513, LSL #32
    MOVK  X6, #0x77e8, LSL #48
    MOVZ  X7, #0x8d4a, LSL #0
    MOVK  X7, #0x12bd, LSL #16
    MOVK  X7, #0x8d3d, LSL #32
    MOVK  X7, #0xce46, LSL #48
    MOVZ  X8, #0x70b2, LSL #0
    MOVK  X8, #0x51ed, LSL #16
    MOVK  X8, #0xe57b, LSL #32
    MOVK  X8, #0xbdc6, LSL #48
    MOVZ  X9, #0x7da9, LSL #0
    MOVK  X9, #0xf93, LSL #16
    MOVK  X9, #0xd6b2, LSL #32
    MOVK  X9, #0x8e5a, LSL #48
    MOVZ  X10, #0x3ba4, LSL #0
    MOVK  X10, #0x7880, LSL #16
    MOVK  X10, #0x4bab, LSL #32
    MOVK  X10, #0x321a, LSL #48
    MOVZ  X11, #0x2e19, LSL #0
    MOVK  X11, #0xc289, LSL #16
    MOVK  X11, #0xf8bb, LSL #32
    MOVK  X11, #0xc2ee, LSL #48
    MOVZ  X12, #0x70b2, LSL #0
    MOVK  X12, #0xae8b, LSL #16
    MOVK  X12, #0x9b12, LSL #32
    MOVK  X12, #0x7789, LSL #48
    MOVZ  X13, #0x5f96, LSL #0
    MOVK  X13, #0x1ab5, LSL #16
    MOVK  X13, #0x3415, LSL #32
    MOVK  X13, #0xd90c, LSL #48
    MOVZ  X14, #0xc714, LSL #0
    MOVK  X14, #0xb3d8, LSL #16
    MOVK  X14, #0xf680, LSL #32
    MOVK  X14, #0x8425, LSL #48
    MOVZ  X15, #0x82d8, LSL #0
    MOVK  X15, #0x32f4, LSL #16
    MOVK  X15, #0x288f, LSL #32
    MOVK  X15, #0x7496, LSL #48
    MOVZ  X16, #0xf2e0, LSL #0
    MOVK  X16, #0xef8, LSL #16
    MOVK  X16, #0x2ee9, LSL #32
    MOVK  X16, #0x5fc0, LSL #48
    MOVZ  X17, #0x3095, LSL #0
    MOVK  X17, #0x6921, LSL #16
    MOVK  X17, #0xb496, LSL #32
    MOVK  X17, #0x7762, LSL #48
    MOVZ  X18, #0xdbc3, LSL #0
    MOVK  X18, #0xbf89, LSL #16
    MOVK  X18, #0x1f96, LSL #32
    MOVK  X18, #0x9d6f, LSL #48
    MOVZ  X19, #0xb967, LSL #0
    MOVK  X19, #0x7718, LSL #16
    MOVK  X19, #0x72b1, LSL #32
    MOVK  X19, #0x5e67, LSL #48
    MOVZ  X20, #0xf7d6, LSL #0
    MOVK  X20, #0xe9a4, LSL #16
    MOVK  X20, #0x4b44, LSL #32
    MOVK  X20, #0x2b54, LSL #48
    MOVZ  X21, #0x1c10, LSL #0
    MOVK  X21, #0x2c0, LSL #16
    MOVK  X21, #0xc5c9, LSL #32
    MOVK  X21, #0xb460, LSL #48
    MOVZ  X22, #0xfc31, LSL #0
    MOVK  X22, #0xbf33, LSL #16
    MOVK  X22, #0xe126, LSL #32
    MOVK  X22, #0x5bf1, LSL #48
    MOVZ  X23, #0x72c4, LSL #0
    MOVK  X23, #0x9d4f, LSL #16
    MOVK  X23, #0x95e5, LSL #32
    MOVK  X23, #0xc5f3, LSL #48
    MOVZ  X24, #0xfa5f, LSL #0
    MOVK  X24, #0xb66, LSL #16
    MOVK  X24, #0xdc8a, LSL #32
    MOVK  X24, #0xccca, LSL #48
    DUP     Z0.D, X24
    DUP     Z1.D, X14
    DUP     Z2.D, X16
    DUP     Z3.D, X20
    DUP     Z4.D, X2
    DUP     Z5.D, X19
    DUP     Z6.D, X21
    DUP     Z7.D, X22
    DUP     Z8.D, X13
    DUP     Z9.D, X24
    DUP     Z10.D, X6
    DUP     Z11.D, X24
    DUP     Z12.D, X9
    DUP     Z13.D, X13
    DUP     Z14.D, X5
    DUP     Z15.D, X7
    DUP     Z16.D, X16
    DUP     Z17.D, X9
    DUP     Z18.D, X21
    DUP     Z19.D, X16
    DUP     Z20.D, X3
    DUP     Z21.D, X20
    DUP     Z22.D, X9
    DUP     Z23.D, X22
    DUP     Z24.D, X6
    DUP     Z25.D, X14
    DUP     Z26.D, X18
    DUP     Z27.D, X19
    DUP     Z28.D, X6
    DUP     Z29.D, X6
    DUP     Z30.D, X10
    DUP     Z31.D, X22
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
    CLASTA  W10, P6, W10, Z31.B
    CLASTA  W3, P4, W3, Z5.B
    CLASTA  W3, P7, W3, Z5.B
    CLASTA  W13, P6, W13, Z21.B
    CLASTA  W15, P1, W15, Z30.B
    CLASTA  W9, P3, W9, Z16.B
    CLASTA  W3, P5, W3, Z28.B
    CLASTA  W5, P1, W5, Z4.B
    CLASTA  W23, P2, W23, Z8.B
    CLASTA  W23, P2, W23, Z18.B
    CLASTA  B20, P7, B20, Z11.B
    CLASTA  B20, P4, B20, Z20.B
    CLASTA  B10, P4, B10, Z22.B
    CLASTA  B31, P0, B31, Z29.B
    CLASTA  B15, P5, B15, Z30.B
    CLASTA  B18, P0, B18, Z31.B
    CLASTA  B22, P7, B22, Z26.B
    CLASTA  B17, P0, B17, Z30.B
    CLASTA  B6, P2, B6, Z20.B
    CLASTA  B20, P1, B20, Z13.B
    CLASTA  Z7.D, P7, Z7.D, Z8.D
    CLASTA  Z31.D, P6, Z31.D, Z0.D
    CLASTA  Z18.D, P3, Z18.D, Z9.D
    CLASTA  Z17.D, P5, Z17.D, Z7.D
    CLASTA  Z18.D, P4, Z18.D, Z8.D
    CLASTA  Z29.D, P4, Z29.D, Z31.D
    CLASTA  Z29.D, P0, Z29.D, Z18.D
    CLASTA  Z29.D, P1, Z29.D, Z20.D
    CLASTA  Z6.D, P2, Z6.D, Z22.D
    CLASTA  Z15.D, P6, Z15.D, Z26.D
    CLASTA  D11, P3, D11, Z12.D
    CLASTA  D11, P4, D11, Z29.D
    CLASTA  D17, P7, D17, Z10.D
    CLASTA  D11, P6, D11, Z6.D
    CLASTA  D11, P4, D11, Z10.D
    CLASTA  D4, P0, D4, Z17.D
    CLASTA  D25, P2, D25, Z14.D
    CLASTA  D30, P5, D30, Z25.D
    CLASTA  D30, P4, D30, Z11.D
    CLASTA  D4, P1, D4, Z15.D
    CLASTA  Z10.H, P0, Z10.H, Z5.H
    CLASTA  Z3.H, P3, Z3.H, Z28.H
    CLASTA  Z0.H, P7, Z0.H, Z26.H
    CLASTA  Z13.H, P6, Z13.H, Z17.H
    CLASTA  Z18.H, P3, Z18.H, Z12.H
    CLASTA  Z11.H, P1, Z11.H, Z10.H
    CLASTA  Z12.H, P0, Z12.H, Z11.H
    CLASTA  Z9.H, P5, Z9.H, Z1.H
    CLASTA  Z15.H, P4, Z15.H, Z19.H
    CLASTA  Z15.H, P6, Z15.H, Z18.H
    CLASTA  S12, P4, S12, Z9.S
    CLASTA  S3, P2, S3, Z9.S
    CLASTA  S21, P3, S21, Z12.S
    CLASTA  S21, P1, S21, Z23.S
    CLASTA  S15, P7, S15, Z3.S
    CLASTA  S30, P3, S30, Z26.S
    CLASTA  S4, P5, S4, Z13.S
    CLASTA  S16, P7, S16, Z0.S
    CLASTA  S23, P5, S23, Z30.S
    CLASTA  S4, P4, S4, Z23.S
    CLASTA  X14, P3, X14, Z21.D
    CLASTA  X2, P0, X2, Z15.D
    CLASTA  X9, P1, X9, Z0.D
    CLASTA  X10, P3, X10, Z1.D
    CLASTA  X9, P5, X9, Z4.D
    CLASTA  X11, P0, X11, Z3.D
    CLASTA  X8, P2, X8, Z3.D
    CLASTA  X12, P0, X12, Z18.D
    CLASTA  X8, P0, X8, Z21.D
    CLASTA  X4, P3, X4, Z17.D
    CLASTA  Z1.S, P5, Z1.S, Z18.S
    CLASTA  Z0.S, P5, Z0.S, Z17.S
    CLASTA  Z24.S, P2, Z24.S, Z26.S
    CLASTA  Z19.S, P5, Z19.S, Z25.S
    CLASTA  Z28.S, P0, Z28.S, Z9.S
    CLASTA  Z3.S, P3, Z3.S, Z20.S
    CLASTA  Z5.S, P3, Z5.S, Z24.S
    CLASTA  Z3.S, P4, Z3.S, Z3.S
    CLASTA  Z4.S, P0, Z4.S, Z6.S
    CLASTA  Z5.S, P4, Z5.S, Z7.S
    CLASTA  W4, P5, W4, Z17.H
    CLASTA  W13, P5, W13, Z9.H
    CLASTA  W13, P7, W13, Z14.H
    CLASTA  W10, P1, W10, Z10.H
    CLASTA  W17, P0, W17, Z10.H
    CLASTA  W19, P0, W19, Z29.H
    CLASTA  W8, P7, W8, Z23.H
    CLASTA  W17, P0, W17, Z1.H
    CLASTA  W4, P3, W4, Z1.H
    CLASTA  W12, P1, W12, Z22.H
    CLASTA  H14, P6, H14, Z11.H
    CLASTA  H7, P1, H7, Z26.H
    CLASTA  H5, P7, H5, Z27.H
    CLASTA  H27, P4, H27, Z14.H
    CLASTA  H14, P5, H14, Z13.H
    CLASTA  H4, P4, H4, Z7.H
    CLASTA  H14, P7, H14, Z27.H
    CLASTA  H14, P3, H14, Z31.H
    CLASTA  H5, P4, H5, Z20.H
    CLASTA  H20, P5, H20, Z21.H
    CLASTA  Z19.B, P0, Z19.B, Z14.B
    CLASTA  Z2.B, P4, Z2.B, Z19.B
    CLASTA  Z4.B, P5, Z4.B, Z5.B
    CLASTA  Z1.B, P6, Z1.B, Z28.B
    CLASTA  Z20.B, P3, Z20.B, Z3.B
    CLASTA  Z14.B, P1, Z14.B, Z2.B
    CLASTA  Z1.B, P7, Z1.B, Z14.B
    CLASTA  Z12.B, P4, Z12.B, Z22.B
    CLASTA  Z1.B, P4, Z1.B, Z12.B
    CLASTA  Z29.B, P6, Z29.B, Z4.B
    CLASTA  W8, P7, W8, Z1.S
    CLASTA  W8, P4, W8, Z15.S
    CLASTA  W15, P7, W15, Z29.S
    CLASTA  W15, P5, W15, Z6.S
    CLASTA  W15, P3, W15, Z21.S
    CLASTA  W4, P2, W4, Z10.S
    CLASTA  W15, P3, W15, Z30.S
    CLASTA  W19, P1, W19, Z31.S
    CLASTA  W19, P1, W19, Z16.S
    CLASTA  W15, P3, W15, Z26.S
    CLASTB  S13, P5, S13, Z3.S
    CLASTB  S15, P1, S15, Z30.S
    CLASTB  S30, P0, S30, Z2.S
    CLASTB  S18, P7, S18, Z15.S
    CLASTB  S1, P2, S1, Z14.S
    CLASTB  S4, P1, S4, Z31.S
    CLASTB  S6, P1, S6, Z12.S
    CLASTB  S5, P7, S5, Z17.S
    CLASTB  S17, P5, S17, Z15.S
    CLASTB  S17, P0, S17, Z24.S
    CLASTB  H12, P3, H12, Z18.H
    CLASTB  H1, P0, H1, Z5.H
    CLASTB  H4, P4, H4, Z1.H
    CLASTB  H5, P7, H5, Z30.H
    CLASTB  H4, P1, H4, Z16.H
    CLASTB  H22, P2, H22, Z13.H
    CLASTB  H10, P1, H10, Z4.H
    CLASTB  H5, P7, H5, Z18.H
    CLASTB  H24, P3, H24, Z5.H
    CLASTB  H22, P4, H22, Z12.H
    CLASTB  Z17.B, P2, Z17.B, Z21.B
    CLASTB  Z31.B, P1, Z31.B, Z6.B
    CLASTB  Z24.B, P6, Z24.B, Z24.B
    CLASTB  Z10.B, P0, Z10.B, Z31.B
    CLASTB  Z1.B, P6, Z1.B, Z24.B
    CLASTB  Z12.B, P1, Z12.B, Z17.B
    CLASTB  Z8.B, P2, Z8.B, Z10.B
    CLASTB  Z25.B, P2, Z25.B, Z4.B
    CLASTB  Z12.B, P7, Z12.B, Z12.B
    CLASTB  Z22.B, P3, Z22.B, Z16.B
    CLASTB  W10, P3, W10, Z22.H
    CLASTB  W7, P1, W7, Z25.H
    CLASTB  W22, P0, W22, Z8.H
    CLASTB  W8, P7, W8, Z3.H
    CLASTB  W18, P0, W18, Z9.H
    CLASTB  W8, P0, W8, Z12.H
    CLASTB  W5, P1, W5, Z9.H
    CLASTB  W8, P3, W8, Z7.H
    CLASTB  W14, P5, W14, Z3.H
    CLASTB  W6, P6, W6, Z20.H
    CLASTB  W2, P2, W2, Z8.B
    CLASTB  W10, P6, W10, Z8.B
    CLASTB  W18, P7, W18, Z9.B
    CLASTB  W6, P5, W6, Z23.B
    CLASTB  W8, P6, W8, Z18.B
    CLASTB  W6, P3, W6, Z17.B
    CLASTB  W7, P4, W7, Z7.B
    CLASTB  W22, P1, W22, Z5.B
    CLASTB  W10, P6, W10, Z3.B
    CLASTB  W2, P0, W2, Z5.B
    CLASTB  Z14.S, P7, Z14.S, Z3.S
    CLASTB  Z11.S, P5, Z11.S, Z29.S
    CLASTB  Z2.S, P5, Z2.S, Z19.S
    CLASTB  Z31.S, P3, Z31.S, Z8.S
    CLASTB  Z27.S, P7, Z27.S, Z12.S
    CLASTB  Z4.S, P0, Z4.S, Z12.S
    CLASTB  Z19.S, P1, Z19.S, Z17.S
    CLASTB  Z22.S, P1, Z22.S, Z5.S
    CLASTB  Z20.S, P0, Z20.S, Z16.S
    CLASTB  Z11.S, P4, Z11.S, Z22.S
    CLASTB  X2, P0, X2, Z13.D
    CLASTB  X2, P0, X2, Z18.D
    CLASTB  X17, P6, X17, Z4.D
    CLASTB  X22, P0, X22, Z24.D
    CLASTB  X10, P3, X10, Z20.D
    CLASTB  X2, P6, X2, Z19.D
    CLASTB  X22, P5, X22, Z22.D
    CLASTB  X17, P3, X17, Z2.D
    CLASTB  X17, P0, X17, Z11.D
    CLASTB  X22, P7, X22, Z31.D
    CLASTB  D30, P5, D30, Z25.D
    CLASTB  D27, P2, D27, Z27.D
    CLASTB  D2, P7, D2, Z14.D
    CLASTB  D2, P0, D2, Z3.D
    CLASTB  D2, P4, D2, Z27.D
    CLASTB  D15, P2, D15, Z5.D
    CLASTB  D24, P3, D24, Z14.D
    CLASTB  D1, P6, D1, Z19.D
    CLASTB  D28, P4, D28, Z8.D
    CLASTB  D9, P6, D9, Z2.D
    CLASTB  Z15.H, P0, Z15.H, Z21.H
    CLASTB  Z25.H, P2, Z25.H, Z2.H
    CLASTB  Z4.H, P6, Z4.H, Z14.H
    CLASTB  Z2.H, P6, Z2.H, Z10.H
    CLASTB  Z8.H, P4, Z8.H, Z28.H
    CLASTB  Z9.H, P0, Z9.H, Z0.H
    CLASTB  Z15.H, P3, Z15.H, Z1.H
    CLASTB  Z9.H, P6, Z9.H, Z18.H
    CLASTB  Z4.H, P7, Z4.H, Z4.H
    CLASTB  Z15.H, P3, Z15.H, Z4.H
    CLASTB  W9, P1, W9, Z15.S
    CLASTB  W9, P6, W9, Z8.S
    CLASTB  W9, P1, W9, Z14.S
    CLASTB  W24, P4, W24, Z17.S
    CLASTB  W22, P6, W22, Z8.S
    CLASTB  W8, P0, W8, Z25.S
    CLASTB  W8, P0, W8, Z5.S
    CLASTB  W8, P5, W8, Z9.S
    CLASTB  W22, P6, W22, Z25.S
    CLASTB  W22, P5, W22, Z17.S
    CLASTB  Z28.D, P1, Z28.D, Z2.D
    CLASTB  Z28.D, P7, Z28.D, Z23.D
    CLASTB  Z28.D, P2, Z28.D, Z30.D
    CLASTB  Z24.D, P2, Z24.D, Z13.D
    CLASTB  Z14.D, P7, Z14.D, Z11.D
    CLASTB  Z1.D, P3, Z1.D, Z1.D
    CLASTB  Z7.D, P1, Z7.D, Z24.D
    CLASTB  Z2.D, P7, Z2.D, Z15.D
    CLASTB  Z5.D, P2, Z5.D, Z28.D
    CLASTB  Z13.D, P0, Z13.D, Z23.D
    CLASTB  B23, P1, B23, Z25.B
    CLASTB  B27, P0, B27, Z14.B
    CLASTB  B1, P3, B1, Z16.B
    CLASTB  B17, P0, B17, Z6.B
    CLASTB  B20, P0, B20, Z25.B
    CLASTB  B23, P4, B23, Z17.B
    CLASTB  B1, P3, B1, Z7.B
    CLASTB  B27, P6, B27, Z19.B
    CLASTB  B14, P2, B14, Z1.B
    CLASTB  B4, P2, B4, Z14.B
    LASTA   X13, P7, Z30.D
    LASTA   X18, P6, Z27.D
    LASTA   X13, P3, Z5.D
    LASTA   X5, P0, Z23.D
    LASTA   X12, P3, Z30.D
    LASTA   X7, P6, Z13.D
    LASTA   X13, P7, Z31.D
    LASTA   X14, P5, Z25.D
    LASTA   X14, P4, Z2.D
    LASTA   X4, P4, Z31.D
    LASTA   H16, P4, Z25.H
    LASTA   H7, P0, Z3.H
    LASTA   H17, P7, Z22.H
    LASTA   H19, P0, Z4.H
    LASTA   H22, P1, Z6.H
    LASTA   H6, P7, Z9.H
    LASTA   H4, P5, Z22.H
    LASTA   H9, P7, Z4.H
    LASTA   H22, P5, Z6.H
    LASTA   H28, P6, Z29.H
    LASTA   W9, P0, Z16.B
    LASTA   W6, P0, Z7.B
    LASTA   W17, P7, Z19.B
    LASTA   W3, P4, Z3.B
    LASTA   W22, P5, Z19.B
    LASTA   W7, P4, Z17.B
    LASTA   W9, P4, Z12.B
    LASTA   W17, P4, Z28.B
    LASTA   W14, P0, Z15.B
    LASTA   W15, P5, Z19.B
    LASTA   B12, P5, Z17.B
    LASTA   B6, P3, Z12.B
    LASTA   B2, P4, Z6.B
    LASTA   B7, P4, Z14.B
    LASTA   B4, P3, Z9.B
    LASTA   B3, P5, Z25.B
    LASTA   B14, P4, Z2.B
    LASTA   B2, P4, Z22.B
    LASTA   B15, P4, Z7.B
    LASTA   B10, P3, Z1.B
    LASTA   S16, P3, Z2.S
    LASTA   S25, P2, Z15.S
    LASTA   S8, P1, Z16.S
    LASTA   S22, P7, Z23.S
    LASTA   S23, P2, Z25.S
    LASTA   S12, P5, Z1.S
    LASTA   S25, P4, Z10.S
    LASTA   S2, P7, Z3.S
    LASTA   S1, P3, Z8.S
    LASTA   S9, P0, Z10.S
    LASTA   W17, P6, Z4.H
    LASTA   W15, P2, Z31.H
    LASTA   W10, P0, Z0.H
    LASTA   W13, P6, Z23.H
    LASTA   W18, P7, Z15.H
    LASTA   W11, P3, Z24.H
    LASTA   W17, P1, Z2.H
    LASTA   W6, P0, Z12.H
    LASTA   W13, P1, Z1.H
    LASTA   W2, P3, Z22.H
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x96, LSL #0
    SUB  X16, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xa9, LSL #0
    SUB  X16, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xdbc3, LSL #0
    MOVK  X20, #0xdbc3, LSL #16
    SUB  X16, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x10, LSL #0
    SUB  X16, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MRS  X20, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X16, #0xa9, LSL #0
    MOVK  X16, #0xa9, LSL #32
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D0
    MOVZ  X16, #0xa9, LSL #0
    MOVK  X16, #0xa9, LSL #32
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D4
    MOVZ  X16, #0xc3, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D16
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D21
    MOVZ  X16, #0xfc31, LSL #0
    MOVK  X16, #0xbf33, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X16, #0xdbc3, LSL #0
    MOVK  X16, #0xbf89, LSL #16
    MOVK  X16, #0x1f96, LSL #32
    MOVK  X16, #0x9d6f, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D26
    MOVZ  X16, #0xdbc3, LSL #0
    MOVK  X16, #0xbf89, LSL #16
    MOVK  X16, #0x1f96, LSL #32
    MOVK  X16, #0x9d6f, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D28
    MOVZ  X16, #0x9696, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X16, #0x9696, LSL #0
    MOVK  X16, #0x9696, LSL #16
    MOVK  X16, #0x9696, LSL #32
    MOVK  X16, #0x9696, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D29
    MOVZ  X16, #0x9696, LSL #0
    MOVK  X16, #0x9696, LSL #16
    MOVK  X16, #0x9696, LSL #32
    MOVK  X16, #0x9696, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D30
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FMOV  X20, D31
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
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
    FMOV  X20, D0
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X20, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D2, P6, Z2.D
    FMOV  X20, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X20, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X20, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X20, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X20, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X20, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X20, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X20, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D10, P4, Z10.D
    FMOV  X20, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X20, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X20, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X20, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X20, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X20, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X20, D16
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X20, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X20, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X20, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D20, P5, Z20.D
    FMOV  X20, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X20, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X20, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X20, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D24, P6, Z24.D
    FMOV  X20, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X20, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X20, D26
    MOVZ  X16, #0xdbc3, LSL #0
    MOVK  X16, #0xbf89, LSL #16
    MOVK  X16, #0x1f96, LSL #32
    MOVK  X16, #0x9d8f, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D27, P5, Z27.D
    FMOV  X20, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X20, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X20, D29
    MOVZ  X16, #0x9696, LSL #0
    MOVK  X16, #0x9696, LSL #16
    MOVK  X16, #0x9696, LSL #32
    MOVK  X16, #0x96b6, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D30, P7, Z30.D
    FMOV  X20, D30
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    FADDV   D31, P2, Z31.D
    FMOV  X20, D31
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0x5d67, LSL #0
    MOVK  X2, #0x1eda, LSL #16
    MOVK  X2, #0xe65b, LSL #32
    MOVK  X2, #0x9ea9, LSL #48
    MOVZ  X3, #0xf951, LSL #0
    MOVK  X3, #0x62de, LSL #16
    MOVK  X3, #0xec17, LSL #32
    MOVK  X3, #0x34ef, LSL #48
    MOVZ  X4, #0x486f, LSL #0
    MOVK  X4, #0xcd3a, LSL #16
    MOVK  X4, #0x5d9f, LSL #32
    MOVK  X4, #0x45e, LSL #48
    MOVZ  X5, #0x1ae7, LSL #0
    MOVK  X5, #0x725e, LSL #16
    MOVK  X5, #0xa1a, LSL #32
    MOVK  X5, #0xc753, LSL #48
    MOVZ  X6, #0xa007, LSL #0
    MOVK  X6, #0x5d06, LSL #16
    MOVK  X6, #0x1fd1, LSL #32
    MOVK  X6, #0x68cc, LSL #48
    MOVZ  X7, #0xbc14, LSL #0
    MOVK  X7, #0xf0ba, LSL #16
    MOVK  X7, #0x8e64, LSL #32
    MOVK  X7, #0x7d39, LSL #48
    MOVZ  X8, #0x6891, LSL #0
    MOVK  X8, #0xe2b8, LSL #16
    MOVK  X8, #0x821f, LSL #32
    MOVK  X8, #0xb21a, LSL #48
    MOVZ  X9, #0x456d, LSL #0
    MOVK  X9, #0xce99, LSL #16
    MOVK  X9, #0xb169, LSL #32
    MOVK  X9, #0x5e0a, LSL #48
    MOVZ  X10, #0xb13d, LSL #0
    MOVK  X10, #0x40c7, LSL #16
    MOVK  X10, #0xda, LSL #32
    MOVK  X10, #0x3d29, LSL #48
    MOVZ  X11, #0x8002, LSL #0
    MOVK  X11, #0x8a8, LSL #16
    MOVK  X11, #0xa1db, LSL #32
    MOVK  X11, #0xac20, LSL #48
    MOVZ  X12, #0x4dc8, LSL #0
    MOVK  X12, #0x46d, LSL #16
    MOVK  X12, #0x1e70, LSL #32
    MOVK  X12, #0x5e3a, LSL #48
    MOVZ  X13, #0xb648, LSL #0
    MOVK  X13, #0x8617, LSL #16
    MOVK  X13, #0x492c, LSL #32
    MOVK  X13, #0x3fb, LSL #48
    MOVZ  X14, #0xac26, LSL #0
    MOVK  X14, #0xe853, LSL #16
    MOVK  X14, #0x9a04, LSL #32
    MOVK  X14, #0xde18, LSL #48
    MOVZ  X15, #0x16b2, LSL #0
    MOVK  X15, #0x60ce, LSL #16
    MOVK  X15, #0x70d9, LSL #32
    MOVK  X15, #0xfdd2, LSL #48
    MOVZ  X16, #0x2bf7, LSL #0
    MOVK  X16, #0x45b, LSL #16
    MOVK  X16, #0xcfea, LSL #32
    MOVK  X16, #0x47cd, LSL #48
    MOVZ  X17, #0xd89f, LSL #0
    MOVK  X17, #0xdc27, LSL #16
    MOVK  X17, #0xef4, LSL #32
    MOVK  X17, #0x2dd5, LSL #48
    MOVZ  X18, #0x11bb, LSL #0
    MOVK  X18, #0x5153, LSL #16
    MOVK  X18, #0x64ec, LSL #32
    MOVK  X18, #0x9475, LSL #48
    MOVZ  X19, #0x2152, LSL #0
    MOVK  X19, #0x79a, LSL #16
    MOVK  X19, #0x9f28, LSL #32
    MOVK  X19, #0x7cc2, LSL #48
    MOVZ  X20, #0x75ae, LSL #0
    MOVK  X20, #0x85d4, LSL #16
    MOVK  X20, #0xe02a, LSL #32
    MOVK  X20, #0xf215, LSL #48
    MOVZ  X21, #0xb3b3, LSL #0
    MOVK  X21, #0x646, LSL #16
    MOVK  X21, #0xa84c, LSL #32
    MOVK  X21, #0x7605, LSL #48
    MOVZ  X22, #0x95f2, LSL #0
    MOVK  X22, #0x550a, LSL #16
    MOVK  X22, #0xbb54, LSL #32
    MOVK  X22, #0xd8bc, LSL #48
    MOVZ  X23, #0xfe58, LSL #0
    MOVK  X23, #0xfda0, LSL #16
    MOVK  X23, #0x141b, LSL #32
    MOVK  X23, #0x79f4, LSL #48
    MOVZ  X24, #0x4717, LSL #0
    MOVK  X24, #0xf8f, LSL #16
    MOVK  X24, #0x9dff, LSL #32
    MOVK  X24, #0x12b2, LSL #48
    DUP     Z0.D, X13
    DUP     Z1.D, X23
    DUP     Z2.D, X6
    DUP     Z3.D, X20
    DUP     Z4.D, X18
    DUP     Z5.D, X24
    DUP     Z6.D, X21
    DUP     Z7.D, X7
    DUP     Z8.D, X19
    DUP     Z9.D, X20
    DUP     Z10.D, X18
    DUP     Z11.D, X3
    DUP     Z12.D, X15
    DUP     Z13.D, X8
    DUP     Z14.D, X13
    DUP     Z15.D, X7
    DUP     Z16.D, X7
    DUP     Z17.D, X6
    DUP     Z18.D, X16
    DUP     Z19.D, X7
    DUP     Z20.D, X5
    DUP     Z21.D, X21
    DUP     Z22.D, X9
    DUP     Z23.D, X21
    DUP     Z24.D, X4
    DUP     Z25.D, X11
    DUP     Z26.D, X21
    DUP     Z27.D, X8
    DUP     Z28.D, X17
    DUP     Z29.D, X4
    DUP     Z30.D, X20
    DUP     Z31.D, X21
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
    LASTA   D30, P7, Z31.D
    LASTA   D9, P0, Z29.D
    LASTA   D21, P3, Z9.D
    LASTA   D13, P6, Z26.D
    LASTA   D10, P2, Z9.D
    LASTA   D6, P3, Z21.D
    LASTA   D0, P0, Z23.D
    LASTA   D6, P5, Z11.D
    LASTA   D2, P4, Z31.D
    LASTA   D3, P6, Z31.D
    LASTA   W19, P4, Z0.S
    LASTA   W21, P5, Z6.S
    LASTA   W21, P7, Z6.S
    LASTA   W23, P5, Z13.S
    LASTA   W21, P2, Z30.S
    LASTA   W22, P3, Z21.S
    LASTA   W20, P7, Z2.S
    LASTA   W13, P6, Z3.S
    LASTA   W9, P1, Z27.S
    LASTA   W20, P6, Z29.S
    LASTB   D20, P0, Z6.D
    LASTB   D29, P3, Z19.D
    LASTB   D31, P0, Z25.D
    LASTB   D27, P2, Z26.D
    LASTB   D3, P5, Z3.D
    LASTB   D26, P4, Z8.D
    LASTB   D6, P7, Z9.D
    LASTB   D25, P2, Z5.D
    LASTB   D2, P5, Z3.D
    LASTB   D19, P2, Z0.D
    LASTB   B13, P7, Z10.B
    LASTB   B9, P7, Z29.B
    LASTB   B5, P0, Z26.B
    LASTB   B30, P1, Z2.B
    LASTB   B29, P2, Z20.B
    LASTB   B16, P6, Z28.B
    LASTB   B2, P6, Z13.B
    LASTB   B28, P7, Z16.B
    LASTB   B0, P0, Z29.B
    LASTB   B3, P6, Z25.B
    LASTB   W21, P5, Z1.B
    LASTB   W8, P0, Z4.B
    LASTB   W17, P7, Z3.B
    LASTB   W19, P0, Z19.B
    LASTB   W22, P7, Z5.B
    LASTB   W24, P4, Z30.B
    LASTB   W24, P5, Z9.B
    LASTB   W24, P7, Z5.B
    LASTB   W24, P5, Z6.B
    LASTB   W6, P7, Z12.B
    LASTB   W19, P7, Z31.H
    LASTB   W19, P7, Z2.H
    LASTB   W20, P5, Z0.H
    LASTB   W17, P4, Z14.H
    LASTB   W2, P1, Z24.H
    LASTB   W23, P2, Z30.H
    LASTB   W13, P1, Z11.H
    LASTB   W3, P5, Z20.H
    LASTB   W19, P5, Z3.H
    LASTB   W21, P4, Z23.H
    LASTB   H19, P3, Z0.H
    LASTB   H30, P6, Z16.H
    LASTB   H24, P3, Z4.H
    LASTB   H4, P1, Z16.H
    LASTB   H6, P7, Z17.H
    LASTB   H3, P1, Z13.H
    LASTB   H16, P5, Z6.H
    LASTB   H1, P5, Z19.H
    LASTB   H23, P0, Z31.H
    LASTB   H23, P4, Z27.H
    LASTB   S9, P7, Z27.S
    LASTB   S12, P2, Z17.S
    LASTB   S27, P6, Z3.S
    LASTB   S2, P4, Z1.S
    LASTB   S3, P0, Z16.S
    LASTB   S17, P4, Z24.S
    LASTB   S5, P6, Z2.S
    LASTB   S2, P4, Z23.S
    LASTB   S0, P3, Z9.S
    LASTB   S24, P7, Z2.S
    LASTB   W8, P7, Z3.S
    LASTB   W22, P3, Z31.S
    LASTB   W3, P1, Z12.S
    LASTB   W13, P1, Z15.S
    LASTB   W16, P6, Z1.S
    LASTB   W10, P0, Z22.S
    LASTB   W17, P7, Z16.S
    LASTB   W19, P0, Z17.S
    LASTB   W2, P0, Z0.S
    LASTB   W4, P3, Z21.S
    LASTB   X8, P1, Z4.D
    LASTB   X20, P0, Z27.D
    LASTB   X13, P0, Z5.D
    LASTB   X18, P7, Z24.D
    LASTB   X20, P0, Z6.D
    LASTB   X16, P2, Z28.D
    LASTB   X14, P3, Z4.D
    LASTB   X14, P1, Z16.D
    LASTB   X18, P1, Z19.D
    LASTB   X17, P5, Z25.D
    COMPACT Z6.D, P4, Z25.D
    COMPACT Z5.S, P4, Z6.S
    COMPACT Z2.D, P7, Z8.D
    COMPACT Z22.D, P1, Z30.D
    COMPACT Z17.D, P3, Z26.D
    COMPACT Z24.S, P4, Z25.S
    COMPACT Z16.D, P0, Z23.D
    COMPACT Z23.D, P6, Z30.D
    COMPACT Z28.S, P1, Z30.S
    COMPACT Z19.D, P1, Z5.D
    SPLICE  Z18.S, P5, Z18.S, Z18.S
    SPLICE  Z27.S, P4, Z27.S, Z10.S
    SPLICE  Z22.S, P5, Z22.S, Z2.S
    SPLICE  Z9.S, P2, Z9.S, Z28.S
    SPLICE  Z9.S, P0, Z9.S, Z27.S
    SPLICE  Z16.S, P7, Z16.S, Z23.S
    SPLICE  Z9.S, P3, Z9.S, Z13.S
    SPLICE  Z25.S, P3, Z25.S, Z16.S
    SPLICE  Z18.S, P2, Z18.S, Z1.S
    SPLICE  Z11.S, P2, Z11.S, Z23.S
    SPLICE  Z31.H, P7, Z31.H, Z4.H
    SPLICE  Z31.H, P5, Z31.H, Z31.H
    SPLICE  Z25.H, P3, Z25.H, Z14.H
    SPLICE  Z25.H, P3, Z25.H, Z23.H
    SPLICE  Z31.H, P7, Z31.H, Z25.H
    SPLICE  Z0.H, P1, Z0.H, Z22.H
    SPLICE  Z0.H, P1, Z0.H, Z28.H
    SPLICE  Z18.H, P7, Z18.H, Z18.H
    SPLICE  Z0.H, P5, Z0.H, Z0.H
    SPLICE  Z18.H, P0, Z18.H, Z18.H
    SPLICE  Z11.B, P6, Z11.B, Z3.B
    SPLICE  Z0.B, P2, Z0.B, Z3.B
    SPLICE  Z0.B, P0, Z0.B, Z23.B
    SPLICE  Z0.B, P6, Z0.B, Z9.B
    SPLICE  Z22.B, P5, Z22.B, Z18.B
    SPLICE  Z20.B, P4, Z20.B, Z28.B
    SPLICE  Z22.B, P0, Z22.B, Z0.B
    SPLICE  Z22.B, P5, Z22.B, Z2.B
    SPLICE  Z20.B, P7, Z20.B, Z30.B
    SPLICE  Z22.B, P7, Z22.B, Z8.B
    SPLICE  Z11.D, P0, Z11.D, Z11.D
    SPLICE  Z11.D, P3, Z11.D, Z11.D
    SPLICE  Z20.D, P5, Z20.D, Z10.D
    SPLICE  Z3.D, P5, Z3.D, Z26.D
    SPLICE  Z19.D, P1, Z19.D, Z21.D
    SPLICE  Z27.D, P7, Z27.D, Z20.D
    SPLICE  Z29.D, P1, Z29.D, Z22.D
    SPLICE  Z4.D, P0, Z4.D, Z26.D
    SPLICE  Z3.D, P0, Z3.D, Z28.D
    SPLICE  Z7.D, P3, Z7.D, Z27.D
    TBL     Z9.B,  Z10.B, Z24.B
    TBL     Z21.B,  Z9.B, Z15.B
    TBL     Z18.B,  Z23.B, Z13.B
    TBL     Z8.B,  Z23.B, Z23.B
    TBL     Z0.B,  Z13.B, Z17.B
    TBL     Z30.B,  Z9.B, Z1.B
    TBL     Z19.B,  Z19.B, Z21.B
    TBL     Z21.B,  Z21.B, Z9.B
    TBL     Z4.B,  Z4.B, Z27.B
    TBL     Z27.B,  Z0.B, Z7.B
    TBL     Z9.S,  Z8.S, Z21.S
    TBL     Z10.S,  Z26.S, Z27.S
    TBL     Z12.S,  Z31.S, Z9.S
    TBL     Z22.S,  Z12.S, Z13.S
    TBL     Z1.S,  Z18.S, Z18.S
    TBL     Z8.S,  Z30.S, Z4.S
    TBL     Z3.S,  Z8.S, Z19.S
    TBL     Z23.S,  Z25.S, Z22.S
    TBL     Z28.S,  Z10.S, Z3.S
    TBL     Z15.S,  Z1.S, Z28.S
    TBL     Z9.H,  Z2.H, Z28.H
    TBL     Z18.H,  Z5.H, Z2.H
    TBL     Z29.H,  Z12.H, Z1.H
    TBL     Z17.H,  Z16.H, Z21.H
    TBL     Z19.H,  Z13.H, Z17.H
    TBL     Z24.H,  Z21.H, Z10.H
    TBL     Z12.H,  Z8.H, Z27.H
    TBL     Z28.H,  Z18.H, Z6.H
    TBL     Z8.H,  Z3.H, Z21.H
    TBL     Z30.H,  Z8.H, Z25.H
    TBL     Z7.D,  Z12.D, Z16.D
    TBL     Z31.D,  Z22.D, Z19.D
    TBL     Z22.D,  Z6.D, Z29.D
    TBL     Z16.D,  Z18.D, Z11.D
    TBL     Z4.D,  Z30.D, Z15.D
    TBL     Z3.D,  Z4.D, Z16.D
    TBL     Z8.D,  Z28.D, Z7.D
    TBL     Z7.D,  Z24.D, Z24.D
    TBL     Z16.D,  Z7.D, Z16.D
    TBL     Z6.D,  Z30.D, Z9.D
    DUP Z27.D,Z6.D[2]
    DUP Z1.D,Z27.D[6]
    DUP Z19.D,Z2.D[7]
    DUP Z27.D,Z1.D[2]
    DUP Z15.D,Z3.D[0]
    DUP Z29.D,Z22.D[2]
    DUP Z2.D,Z21.D[1]
    DUP Z30.D,Z19.D[7]
    DUP Z11.D,Z29.D[3]
    DUP Z21.D,Z15.D[6]
    DUP Z15.B,Z19.B[24]
    DUP Z25.B,Z8.B[25]
    DUP Z22.B,Z30.B[59]
    DUP Z17.B,Z2.B[15]
    DUP Z1.B,Z25.B[58]
    DUP Z0.B,Z11.B[48]
    DUP Z3.B,Z11.B[44]
    DUP Z25.B,Z3.B[51]
    DUP Z8.B,Z1.B[26]
    DUP Z1.B,Z17.B[53]
    DUP Z30.S,Z8.S[8]
    DUP Z29.S,Z21.S[14]
    DUP Z2.S,Z27.S[9]
    DUP Z3.S,Z29.S[15]
    DUP Z24.S,Z2.S[1]
    DUP Z28.S,Z24.S[8]
    DUP Z2.S,Z1.S[7]
    DUP Z19.S,Z28.S[4]
    DUP Z30.S,Z18.S[7]
    DUP Z17.S,Z0.S[4]
    DUP Z24.H,Z2.H[28]
    DUP Z27.H,Z18.H[24]
    DUP Z0.H,Z4.H[20]
    DUP Z21.H,Z24.H[1]
    DUP Z7.H,Z31.H[25]
    DUP Z11.H,Z22.H[26]
    DUP Z9.H,Z7.H[24]
    DUP Z3.H,Z25.H[7]
    DUP Z22.H,Z2.H[31]
    DUP Z27.H,Z17.H[27]
    DUP Z20.Q,Z3.Q[3]
    DUP Z29.Q,Z30.Q[1]
    DUP Z29.Q,Z20.Q[1]
    DUP Z18.Q,Z29.Q[3]
    DUP Z17.Q,Z19.Q[1]
    DUP Z15.Q,Z18.Q[1]
    DUP Z25.Q,Z27.Q[2]
    DUP Z8.Q,Z25.Q[0]
    DUP Z27.Q,Z11.Q[0]
    DUP Z25.Q,Z9.Q[3]
    MOV Z24.B,Z8.B[49]
    MOV Z2.B,Z27.B[8]
    MOV Z31.B,Z25.B[18]
    MOV Z26.B,Z24.B[50]
    MOV Z1.B,Z19.B[42]
    MOV Z9.B,Z17.B[9]
    MOV Z24.B,Z1.B[23]
    MOV Z4.B,Z9.B[28]
    MOV Z3.B,Z31.B[55]
    MOV Z1.B,Z2.B[33]
    MOV Z18.H,Z8.H[21]
    MOV Z30.H,Z26.H[21]
    MOV Z7.H,Z18.H[7]
    MOV Z2.H,Z4.H[6]
    MOV Z17.H,Z25.H[27]
    MOV Z9.H,Z30.H[23]
    MOV Z31.H,Z12.H[3]
    MOV Z4.H,Z27.H[9]
    MOV Z19.H,Z15.H[20]
    MOV Z8.H,Z7.H[25]
    MOV Z15.S,Z24.S[3]
    MOV Z3.S,Z2.S[10]
    MOV Z2.S,Z15.S[13]
    MOV Z27.S,Z18.S[2]
    MOV Z26.S,Z2.S[6]
    MOV Z30.S,Z31.S[7]
    MOV Z25.S,Z26.S[14]
    MOV Z17.S,Z27.S[3]
    MOV Z11.S,Z25.S[1]
    MOV Z18.S,Z19.S[13]
    MOV Z2.D,Z4.D[3]
    MOV Z25.D,Z3.D[1]
    MOV Z15.D,Z8.D[3]
    MOV Z27.D,Z17.D[5]
    MOV Z24.D,Z21.D[7]
    MOV Z9.D,Z16.D[7]
    MOV Z24.D,Z2.D[5]
    MOV Z20.D,Z25.D[3]
    MOV Z3.D,Z29.D[3]
    MOV Z21.D,Z23.D[3]
    MOV Z1.Q,Z18.Q[0]
    MOV Z19.Q,Z1.Q[3]
    MOV Z25.Q,Z21.Q[1]
    MOV Z31.Q,Z24.Q[0]
    MOV Z8.Q,Z10.Q[2]
    MOV Z18.Q,Z11.Q[3]
    MOV Z12.Q,Z17.Q[0]
    MOV Z21.Q,Z4.Q[1]
    MOV Z17.Q,Z21.Q[2]
    MOV Z7.Q,Z12.Q[1]
    EXT     Z0.B, Z0.B, Z25.B, #0x81
    EXT     Z7.B, Z7.B, Z16.B, #0x85
    EXT     Z20.B, Z20.B, Z20.B, #0x2a
    EXT     Z0.B, Z0.B, Z3.B, #0x1f
    EXT     Z13.B, Z13.B, Z16.B, #0x38
    EXT     Z7.B, Z7.B, Z0.B, #0x82
    EXT     Z17.B, Z17.B, Z18.B, #0x4c
    EXT     Z14.B, Z14.B, Z8.B, #0x1f
    EXT     Z20.B, Z20.B, Z31.B, #0x54
    EXT     Z25.B, Z25.B, Z17.B, #0xec
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0xfd, LSL #0
    SUB  X15, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x6891, LSL #0
    MOVK  X7, #0xe2b8, LSL #16
    SUB  X15, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0xb169, LSL #0
    MOVK  X7, #0x5e0a, LSL #16
    SUB  X15, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x8002, LSL #0
    MOVK  X7, #0x8a8, LSL #16
    MOVK  X7, #0xa1db, LSL #32
    MOVK  X7, #0xac20, LSL #48
    SUB  X15, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x4dc8, LSL #0
    MOVK  X7, #0x46d, LSL #16
    MOVK  X7, #0x1e70, LSL #32
    MOVK  X7, #0x5e3a, LSL #48
    SUB  X15, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x7605, LSL #0
    SUB  X15, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MRS  X7, FPSR
    MOVZ  X15, #0x80, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D5
    MOVZ  X15, #0x4717, LSL #0
    MOVK  X15, #0xf8f, LSL #16
    MOVK  X15, #0x9dff, LSL #32
    MOVK  X15, #0x12b2, LSL #48
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X15, #0x2152, LSL #0
    MOVK  X15, #0x79a, LSL #16
    MOVK  X15, #0x2152, LSL #32
    MOVK  X15, #0x79a, LSL #48
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D10
    MOVZ  X15, #0x2152, LSL #0
    MOVK  X15, #0x79a, LSL #16
    MOVK  X15, #0x2152, LSL #32
    MOVK  X15, #0x79a, LSL #48
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D14
    MOVZ  X15, #0x3, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FMOV  X7, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
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
    FADDV   D0, P4, Z0.D
    FMOV  X7, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D1, P0, Z1.D
    FMOV  X7, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X7, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X7, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X7, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X7, D5
    MOVZ  X15, #0x4717, LSL #0
    MOVK  X15, #0xf8f, LSL #16
    MOVK  X15, #0x9dff, LSL #32
    MOVK  X15, #0x12b2, LSL #48
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X7, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X7, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X7, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D9, P0, Z9.D
    FMOV  X7, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X7, D10
    MOVZ  X15, #0x2152, LSL #0
    MOVK  X15, #0x79a, LSL #16
    MOVK  X15, #0x2152, LSL #32
    MOVK  X15, #0x7ba, LSL #48
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X7, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X7, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X7, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D14, P1, Z14.D
    FMOV  X7, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X7, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X7, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X7, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X7, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X7, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X7, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D21, P7, Z21.D
    FMOV  X7, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X7, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X7, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X7, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X7, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D26, P4, Z26.D
    FMOV  X7, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X7, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X7, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X7, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X7, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X7, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0x4958, LSL #0
    MOVK  X2, #0x312c, LSL #16
    MOVK  X2, #0x2fd8, LSL #32
    MOVK  X2, #0x80de, LSL #48
    MOVZ  X3, #0x321e, LSL #0
    MOVK  X3, #0x49f, LSL #16
    MOVK  X3, #0x8cf8, LSL #32
    MOVK  X3, #0x5f77, LSL #48
    MOVZ  X4, #0xbaef, LSL #0
    MOVK  X4, #0x9dc7, LSL #16
    MOVK  X4, #0x4a49, LSL #32
    MOVK  X4, #0xbd79, LSL #48
    MOVZ  X5, #0x7da0, LSL #0
    MOVK  X5, #0x97b, LSL #16
    MOVK  X5, #0xbbf8, LSL #32
    MOVK  X5, #0xcbc0, LSL #48
    MOVZ  X6, #0x513b, LSL #0
    MOVK  X6, #0xc813, LSL #16
    MOVK  X6, #0x7ddc, LSL #32
    MOVK  X6, #0xebf8, LSL #48
    MOVZ  X7, #0xd661, LSL #0
    MOVK  X7, #0x87eb, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x6028, LSL #48
    MOVZ  X8, #0x487, LSL #0
    MOVK  X8, #0x2386, LSL #16
    MOVK  X8, #0x34a, LSL #32
    MOVK  X8, #0x525b, LSL #48
    MOVZ  X9, #0x7efa, LSL #0
    MOVK  X9, #0xf29f, LSL #16
    MOVK  X9, #0x4b6a, LSL #32
    MOVK  X9, #0x44fe, LSL #48
    MOVZ  X10, #0x4414, LSL #0
    MOVK  X10, #0xab97, LSL #16
    MOVK  X10, #0xf742, LSL #32
    MOVK  X10, #0xf594, LSL #48
    MOVZ  X11, #0x6239, LSL #0
    MOVK  X11, #0xb897, LSL #16
    MOVK  X11, #0x1f8, LSL #32
    MOVK  X11, #0xdfd6, LSL #48
    MOVZ  X12, #0xff, LSL #0
    MOVK  X12, #0x41c0, LSL #16
    MOVK  X12, #0x1d81, LSL #32
    MOVK  X12, #0x2295, LSL #48
    MOVZ  X13, #0xf8f7, LSL #0
    MOVK  X13, #0x73e3, LSL #16
    MOVK  X13, #0x7fcf, LSL #32
    MOVK  X13, #0x6dd1, LSL #48
    MOVZ  X14, #0x93aa, LSL #0
    MOVK  X14, #0x19c4, LSL #16
    MOVK  X14, #0x9668, LSL #32
    MOVK  X14, #0x1608, LSL #48
    MOVZ  X15, #0x5b1e, LSL #0
    MOVK  X15, #0x53b3, LSL #16
    MOVK  X15, #0x3689, LSL #32
    MOVK  X15, #0x9c4d, LSL #48
    MOVZ  X16, #0x5b66, LSL #0
    MOVK  X16, #0x7574, LSL #16
    MOVK  X16, #0xc8c, LSL #32
    MOVK  X16, #0xdcfc, LSL #48
    MOVZ  X17, #0xffca, LSL #0
    MOVK  X17, #0x1c75, LSL #16
    MOVK  X17, #0x3ba5, LSL #32
    MOVK  X17, #0xa883, LSL #48
    MOVZ  X18, #0xa03d, LSL #0
    MOVK  X18, #0x29a5, LSL #16
    MOVK  X18, #0x4992, LSL #32
    MOVK  X18, #0x7b21, LSL #48
    MOVZ  X19, #0x3049, LSL #0
    MOVK  X19, #0x56df, LSL #16
    MOVK  X19, #0xd9b7, LSL #32
    MOVK  X19, #0x3815, LSL #48
    MOVZ  X20, #0xc3aa, LSL #0
    MOVK  X20, #0x1d05, LSL #16
    MOVK  X20, #0x7272, LSL #32
    MOVK  X20, #0xc313, LSL #48
    MOVZ  X21, #0x29fc, LSL #0
    MOVK  X21, #0xefcd, LSL #16
    MOVK  X21, #0xa893, LSL #32
    MOVK  X21, #0xfcfc, LSL #48
    MOVZ  X22, #0x2240, LSL #0
    MOVK  X22, #0x471, LSL #16
    MOVK  X22, #0x2633, LSL #32
    MOVK  X22, #0x6df1, LSL #48
    MOVZ  X23, #0xb8c4, LSL #0
    MOVK  X23, #0xada, LSL #16
    MOVK  X23, #0x1d0c, LSL #32
    MOVK  X23, #0xbea6, LSL #48
    MOVZ  X24, #0x3862, LSL #0
    MOVK  X24, #0x14bd, LSL #16
    MOVK  X24, #0xce0b, LSL #32
    MOVK  X24, #0x238c, LSL #48
    DUP     Z0.D, X19
    DUP     Z1.D, X20
    DUP     Z2.D, X23
    DUP     Z3.D, X22
    DUP     Z4.D, X21
    DUP     Z5.D, X24
    DUP     Z6.D, X13
    DUP     Z7.D, X14
    DUP     Z8.D, X9
    DUP     Z9.D, X17
    DUP     Z10.D, X18
    DUP     Z11.D, X2
    DUP     Z12.D, X9
    DUP     Z13.D, X11
    DUP     Z14.D, X2
    DUP     Z15.D, X6
    DUP     Z16.D, X19
    DUP     Z17.D, X13
    DUP     Z18.D, X4
    DUP     Z19.D, X22
    DUP     Z20.D, X21
    DUP     Z21.D, X20
    DUP     Z22.D, X6
    DUP     Z23.D, X14
    DUP     Z24.D, X5
    DUP     Z25.D, X4
    DUP     Z26.D, X4
    DUP     Z27.D, X6
    DUP     Z28.D, X6
    DUP     Z29.D, X20
    DUP     Z30.D, X12
    DUP     Z31.D, X7
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
    INSR    Z31.B, W17
    INSR    Z30.B, W8
    INSR    Z31.B, W7
    INSR    Z10.B, W23
    INSR    Z27.B, W18
    INSR    Z31.B, W17
    INSR    Z27.B, W6
    INSR    Z10.B, W20
    INSR    Z11.B, W24
    INSR    Z26.B, W2
    INSR    Z23.D, X16
    INSR    Z31.D, X11
    INSR    Z5.D, X16
    INSR    Z6.D, X4
    INSR    Z1.D, X2
    INSR    Z26.D, X17
    INSR    Z17.D, X9
    INSR    Z30.D, X22
    INSR    Z9.D, X8
    INSR    Z7.D, X16
    INSR    Z10.H, W3
    INSR    Z17.H, W9
    INSR    Z26.H, W8
    INSR    Z30.H, W10
    INSR    Z27.H, W10
    INSR    Z12.H, W20
    INSR    Z12.H, W18
    INSR    Z5.H, W16
    INSR    Z5.H, W18
    INSR    Z9.H, W6
    INSR    Z11.S, S26
    INSR    Z27.S, S5
    INSR    Z12.S, S4
    INSR    Z6.S, S15
    INSR    Z6.S, S6
    INSR    Z11.S, S7
    INSR    Z23.S, S10
    INSR    Z27.S, S29
    INSR    Z23.S, S6
    INSR    Z23.S, S12
    INSR    Z16.B, B27
    INSR    Z16.B, B23
    INSR    Z5.B, B16
    INSR    Z17.B, B27
    INSR    Z5.B, B9
    INSR    Z17.B, B23
    INSR    Z6.B, B11
    INSR    Z6.B, B5
    INSR    Z8.B, B6
    INSR    Z17.B, B8
    INSR    Z8.H, H6
    INSR    Z26.H, H1
    INSR    Z23.H, H23
    INSR    Z11.H, H10
    INSR    Z18.H, H2
    INSR    Z7.H, H17
    INSR    Z12.H, H26
    INSR    Z23.H, H11
    INSR    Z7.H, H12
    INSR    Z7.H, H25
    INSR    Z26.D, D17
    INSR    Z5.D, D22
    INSR    Z26.D, D23
    INSR    Z16.D, D18
    INSR    Z29.D, D22
    INSR    Z19.D, D21
    INSR    Z5.D, D12
    INSR    Z11.D, D17
    INSR    Z11.D, D16
    INSR    Z31.D, D14
    INSR    Z2.S, W22
    INSR    Z2.S, W3
    INSR    Z22.S, W21
    INSR    Z5.S, W16
    INSR    Z22.S, W2
    INSR    Z31.S, W9
    INSR    Z6.S, W6
    INSR    Z8.S, W16
    INSR    Z26.S, W5
    INSR    Z2.S, W3
    MOV Z14.H,H31
    MOV Z12.H,H19
    MOV Z19.H,H6
    MOV Z19.H,H18
    MOV Z31.H,H7
    MOV Z16.H,H20
    MOV Z22.H,H22
    MOV Z6.H,H31
    MOV Z25.H,H29
    MOV Z29.H,H5
    MOV Z21.Q,Q26
    MOV Z1.Q,Q14
    MOV Z5.Q,Q1
    MOV Z14.Q,Q6
    MOV Z1.Q,Q21
    MOV Z13.Q,Q25
    MOV Z8.Q,Q8
    MOV Z18.Q,Q12
    MOV Z20.Q,Q14
    MOV Z5.Q,Q5
    MOV Z10.S,S20
    MOV Z25.S,S22
    MOV Z30.S,S29
    MOV Z18.S,S18
    MOV Z22.S,S2
    MOV Z12.S,S16
    MOV Z29.S,S10
    MOV Z7.S,S18
    MOV Z18.S,S8
    MOV Z14.S,S9
    MOV     Z26.H, P6/M, H30
    MOV     Z16.H, P4/M, H4
    MOV     Z6.H, P6/M, H25
    MOV     Z10.H, P2/M, H29
    MOV     Z29.H, P0/M, H5
    MOV     Z20.H, P6/M, H18
    MOV     Z9.H, P0/M, H10
    MOV     Z25.H, P4/M, H11
    MOV     Z1.H, P1/M, H8
    MOV     Z2.H, P1/M, H6
    MOV     Z8.S, P4/M, S1
    MOV     Z30.S, P2/M, S25
    MOV     Z5.S, P4/M, S26
    MOV     Z10.S, P3/M, S14
    MOV     Z11.S, P4/M, S5
    MOV     Z6.S, P1/M, S2
    MOV     Z18.S, P0/M, S10
    MOV     Z26.S, P7/M, S12
    MOV     Z30.S, P1/M, S16
    MOV     Z5.S, P5/M, S8
    MOV     Z18.D, P7/M, D9
    MOV     Z28.D, P7/M, D18
    MOV     Z16.D, P1/M, D17
    MOV     Z14.D, P1/M, D14
    MOV     Z0.D, P5/M, D18
    MOV     Z10.D, P0/M, D0
    MOV     Z0.D, P2/M, D10
    MOV     Z17.D, P7/M, D26
    MOV     Z10.D, P6/M, D4
    MOV     Z25.D, P7/M, D5
    MOV     Z4.B, P3/M, B2
    MOV     Z2.B, P1/M, B27
    MOV     Z27.B, P5/M, B0
    MOV     Z31.B, P6/M, B16
    MOV     Z12.B, P2/M, B0
    MOV     Z3.B, P5/M, B25
    MOV     Z18.B, P0/M, B10
    MOV     Z17.B, P5/M, B6
    MOV     Z10.B, P1/M, B2
    MOV     Z5.B, P1/M, B30
    MOV Z25.D,D13
    MOV Z30.D,D3
    MOV Z9.D,D17
    MOV Z13.D,D5
    MOV Z11.D,D27
    MOV Z16.D,D9
    MOV Z9.D,D25
    MOV Z5.D,D8
    MOV Z10.D,D18
    MOV Z27.D,D14
    MOV Z3.B,B28
    MOV Z13.B,B3
    MOV Z2.B,B30
    MOV Z4.B,B22
    MOV Z17.B,B9
    MOV Z3.B,B26
    MOV Z14.B,B27
    MOV Z8.B,B0
    MOV Z0.B,B29
    MOV Z22.B,B17
    REV     Z28.B, Z8.B
    REV     Z29.B, Z4.B
    REV     Z18.B, Z29.B
    REV     Z8.B, Z18.B
    REV     Z1.B, Z15.B
    REV     Z15.B, Z2.B
    REV     Z17.B, Z11.B
    REV     Z0.B, Z5.B
    REV     Z29.B, Z13.B
    REV     Z16.B, Z14.B
    REV     Z24.H, Z15.H
    REV     Z4.H, Z25.H
    REV     Z13.H, Z16.H
    REV     Z27.H, Z1.H
    REV     Z15.H, Z13.H
    REV     Z30.H, Z8.H
    REV     Z13.H, Z10.H
    REV     Z14.H, Z30.H
    REV     Z5.H, Z29.H
    REV     Z11.H, Z4.H
    REV     Z10.S, Z28.S
    REV     Z4.S, Z24.S
    REV     Z8.S, Z14.S
    REV     Z16.S, Z11.S
    REV     Z10.S, Z17.S
    REV     Z31.S, Z21.S
    REV     Z14.S, Z15.S
    REV     Z29.S, Z0.S
    REV     Z11.S, Z7.S
    REV     Z21.S, Z26.S
    REV     Z25.D, Z14.D
    REV     Z28.D, Z29.D
    REV     Z18.D, Z21.D
    REV     Z14.D, Z13.D
    REV     Z21.D, Z10.D
    REV     Z30.D, Z24.D
    REV     Z0.D, Z30.D
    REV     Z30.D, Z31.D
    REV     Z26.D, Z4.D
    REV     Z15.D, Z26.D
    REVB    Z5.S, P0/M, Z12.S
    REVB    Z7.S, P4/M, Z22.S
    REVB    Z22.S, P7/M, Z27.S
    REVB    Z27.S, P7/M, Z15.S
    REVB    Z31.S, P1/M, Z9.S
    REVB    Z0.S, P0/M, Z21.S
    REVB    Z9.S, P6/M, Z14.S
    REVB    Z15.S, P2/M, Z30.S
    REVB    Z24.S, P7/M, Z11.S
    REVB    Z4.S, P7/M, Z22.S
    REVB    Z12.H, P6/M, Z15.H
    REVB    Z21.H, P1/M, Z26.H
    REVB    Z10.H, P7/M, Z0.H
    REVB    Z25.H, P3/M, Z5.H
    REVB    Z17.H, P6/M, Z24.H
    REVB    Z25.H, P4/M, Z12.H
    REVB    Z12.H, P0/M, Z21.H
    REVB    Z6.H, P0/M, Z4.H
    REVB    Z0.H, P2/M, Z12.H
    REVB    Z11.H, P5/M, Z22.H
    REVB    Z15.D, P1/M, Z25.D
    REVB    Z21.D, P0/M, Z0.D
    REVB    Z18.D, P7/M, Z21.D
    REVB    Z12.D, P2/M, Z10.D
    REVB    Z22.D, P3/M, Z6.D
    REVB    Z0.D, P0/M, Z12.D
    REVB    Z14.D, P7/M, Z23.D
    REVB    Z10.D, P5/M, Z14.D
    REVB    Z14.D, P3/M, Z2.D
    REVB    Z21.D, P7/M, Z27.D
    REVH    Z25.D, P1/M, Z18.D
    REVH    Z20.D, P5/M, Z0.D
    REVH    Z24.D, P2/M, Z11.D
    REVH    Z11.D, P4/M, Z14.D
    REVH    Z13.D, P0/M, Z9.D
    REVH    Z14.D, P1/M, Z13.D
    REVH    Z9.D, P3/M, Z25.D
    REVH    Z25.D, P6/M, Z24.D
    REVH    Z13.D, P4/M, Z26.D
    REVH    Z18.D, P4/M, Z13.D
    REVH    Z17.S, P5/M, Z6.S
    REVH    Z0.S, P5/M, Z25.S
    REVH    Z12.S, P0/M, Z9.S
    REVH    Z6.S, P0/M, Z11.S
    REVH    Z3.S, P1/M, Z20.S
    REVH    Z5.S, P4/M, Z4.S
    REVH    Z13.S, P6/M, Z21.S
    REVH    Z23.S, P2/M, Z20.S
    REVH    Z21.S, P0/M, Z6.S
    REVH    Z11.S, P0/M, Z21.S
    REVW    Z26.D, P3/M, Z7.D
    REVW    Z4.D, P6/M, Z3.D
    REVW    Z20.D, P7/M, Z4.D
    REVW    Z5.D, P4/M, Z6.D
    REVW    Z9.D, P5/M, Z10.D
    REVW    Z21.D, P6/M, Z23.D
    REVW    Z3.D, P5/M, Z20.D
    REVW    Z10.D, P1/M, Z13.D
    REVW    Z23.D, P0/M, Z30.D
    REVW    Z4.D, P6/M, Z10.D
    TRN1    Z7.B, Z13.B, Z26.B
    TRN1    Z26.B, Z23.B, Z14.B
    TRN1    Z23.B, Z3.B, Z2.B
    TRN1    Z5.B, Z9.B, Z0.B
    TRN1    Z24.B, Z7.B, Z26.B
    TRN1    Z20.B, Z11.B, Z8.B
    TRN1    Z11.B, Z4.B, Z8.B
    TRN1    Z8.B, Z21.B, Z2.B
    TRN1    Z3.B, Z8.B, Z0.B
    TRN1    Z9.B, Z21.B, Z23.B
    TRN1    Z13.H, Z20.H, Z24.H
    TRN1    Z20.H, Z3.H, Z12.H
    TRN1    Z8.H, Z30.H, Z11.H
    TRN1    Z2.H, Z10.H, Z9.H
    TRN1    Z30.H, Z18.H, Z5.H
    TRN1    Z23.H, Z2.H, Z19.H
    TRN1    Z14.H, Z23.H, Z4.H
    TRN1    Z24.H, Z8.H, Z20.H
    TRN1    Z0.H, Z24.H, Z27.H
    TRN1    Z6.H, Z14.H, Z13.H
    TRN1    Z12.S, Z0.S, Z28.S
    TRN1    Z8.S, Z16.S, Z30.S
    TRN1    Z28.S, Z12.S, Z12.S
    TRN1    Z5.S, Z28.S, Z6.S
    TRN1    Z19.S, Z24.S, Z22.S
    TRN1    Z6.S, Z1.S, Z4.S
    TRN1    Z1.S, Z2.S, Z8.S
    TRN1    Z20.S, Z17.S, Z30.S
    TRN1    Z12.S, Z28.S, Z14.S
    TRN1    Z16.S, Z25.S, Z4.S
    MOVZ  X14, #0x4958, LSL #0
    MOVK  X14, #0x312c, LSL #16
    MOVK  X14, #0x2fd8, LSL #32
    MOVK  X14, #0x80de, LSL #48
    SUB  X15, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x321e, LSL #0
    MOVK  X14, #0x49f, LSL #16
    MOVK  X14, #0x8cf8, LSL #32
    MOVK  X14, #0x5f77, LSL #48
    SUB  X15, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xbaef, LSL #0
    MOVK  X14, #0x9dc7, LSL #16
    MOVK  X14, #0x4a49, LSL #32
    MOVK  X14, #0xbd79, LSL #48
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x7da0, LSL #0
    MOVK  X14, #0x97b, LSL #16
    MOVK  X14, #0xbbf8, LSL #32
    MOVK  X14, #0xcbc0, LSL #48
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x513b, LSL #0
    MOVK  X14, #0xc813, LSL #16
    MOVK  X14, #0x7ddc, LSL #32
    MOVK  X14, #0xebf8, LSL #48
    SUB  X15, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xd661, LSL #0
    MOVK  X14, #0x87eb, LSL #16
    MOVK  X14, #0x7fff, LSL #32
    MOVK  X14, #0x6028, LSL #48
    SUB  X15, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x487, LSL #0
    MOVK  X14, #0x2386, LSL #16
    MOVK  X14, #0x34a, LSL #32
    MOVK  X14, #0x525b, LSL #48
    SUB  X15, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x7efa, LSL #0
    MOVK  X14, #0xf29f, LSL #16
    MOVK  X14, #0x4b6a, LSL #32
    MOVK  X14, #0x44fe, LSL #48
    SUB  X15, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x4414, LSL #0
    MOVK  X14, #0xab97, LSL #16
    MOVK  X14, #0xf742, LSL #32
    MOVK  X14, #0xf594, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x6239, LSL #0
    MOVK  X14, #0xb897, LSL #16
    MOVK  X14, #0x1f8, LSL #32
    MOVK  X14, #0xdfd6, LSL #48
    SUB  X15, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xff, LSL #0
    MOVK  X14, #0x41c0, LSL #16
    MOVK  X14, #0x1d81, LSL #32
    MOVK  X14, #0x2295, LSL #48
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xf8f7, LSL #0
    MOVK  X14, #0x73e3, LSL #16
    MOVK  X14, #0x7fcf, LSL #32
    MOVK  X14, #0x6dd1, LSL #48
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x5b66, LSL #0
    MOVK  X14, #0x7574, LSL #16
    MOVK  X14, #0xc8c, LSL #32
    MOVK  X14, #0xdcfc, LSL #48
    SUB  X15, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xffca, LSL #0
    MOVK  X14, #0x1c75, LSL #16
    MOVK  X14, #0x3ba5, LSL #32
    MOVK  X14, #0xa883, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xa03d, LSL #0
    MOVK  X14, #0x29a5, LSL #16
    MOVK  X14, #0x4992, LSL #32
    MOVK  X14, #0x7b21, LSL #48
    SUB  X15, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xc3aa, LSL #0
    MOVK  X14, #0x1d05, LSL #16
    MOVK  X14, #0x7272, LSL #32
    MOVK  X14, #0xc313, LSL #48
    SUB  X15, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x29fc, LSL #0
    MOVK  X14, #0xefcd, LSL #16
    MOVK  X14, #0xa893, LSL #32
    MOVK  X14, #0xfcfc, LSL #48
    SUB  X15, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x2240, LSL #0
    MOVK  X14, #0x471, LSL #16
    MOVK  X14, #0x2633, LSL #32
    MOVK  X14, #0x6df1, LSL #48
    SUB  X15, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0xb8c4, LSL #0
    MOVK  X14, #0xada, LSL #16
    MOVK  X14, #0x1d0c, LSL #32
    MOVK  X14, #0xbea6, LSL #48
    SUB  X15, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x3862, LSL #0
    MOVK  X14, #0x14bd, LSL #16
    MOVK  X14, #0xce0b, LSL #32
    MOVK  X14, #0x238c, LSL #48
    SUB  X15, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MRS  X14, FPSR
    MOVZ  X15, #0x80, LSL #0
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X15, #0xfc3b, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x29fc, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D0
    MOVZ  X15, #0x321e, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x7da0, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0x513b, LSL #32
    MOVK  X15, #0x513b, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D1
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0x513b, LSL #32
    MOVK  X15, #0x513b, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0xefef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D2
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0xefef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X15, #0x51ef, LSL #0
    MOVK  X15, #0xc8ef, LSL #16
    MOVK  X15, #0x7def, LSL #32
    MOVK  X15, #0xebef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D3
    MOVZ  X15, #0x51ef, LSL #0
    MOVK  X15, #0xc8ef, LSL #16
    MOVK  X15, #0x7def, LSL #32
    MOVK  X15, #0xebef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D4
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X15, #0xfc3b, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x1e66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D5
    MOVZ  X15, #0x321e, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x1e66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X15, #0xf8eb, LSL #0
    MOVK  X15, #0xdc7d, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D6
    MOVZ  X15, #0xf8eb, LSL #0
    MOVK  X15, #0xdc7d, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X15, #0x3b66, LSL #0
    MOVK  X15, #0x3b66, LSL #16
    MOVK  X15, #0x3b66, LSL #32
    MOVK  X15, #0x3b66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D7
    MOVZ  X15, #0x3b66, LSL #0
    MOVK  X15, #0x3b66, LSL #16
    MOVK  X15, #0x3b66, LSL #32
    MOVK  X15, #0x3b66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X15, #0x513b, LSL #0
    MOVK  X15, #0x513b, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x511e, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D8
    MOVZ  X15, #0x513b, LSL #0
    MOVK  X15, #0x513b, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x51fc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X15, #0xefef, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0xefef, LSL #32
    MOVK  X15, #0xefef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D9
    MOVZ  X15, #0xefef, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0xefef, LSL #32
    MOVK  X15, #0xefef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D10
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X15, #0x1e66, LSL #0
    MOVK  X15, #0x1e66, LSL #16
    MOVK  X15, #0x1e66, LSL #32
    MOVK  X15, #0x1e66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D11
    MOVZ  X15, #0x1e66, LSL #0
    MOVK  X15, #0x1e66, LSL #16
    MOVK  X15, #0x1e66, LSL #32
    MOVK  X15, #0x1e66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X15, #0xfc3b, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D12
    MOVZ  X15, #0x321e, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X15, #0x1e66, LSL #0
    MOVK  X15, #0xfc66, LSL #16
    MOVK  X15, #0x1e66, LSL #32
    MOVK  X15, #0x3b66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D13
    MOVZ  X15, #0x1e66, LSL #0
    MOVK  X15, #0xa066, LSL #16
    MOVK  X15, #0x1e66, LSL #32
    MOVK  X15, #0x1e66, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D14
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X15, #0x29fc, LSL #0
    MOVK  X15, #0xefcd, LSL #16
    MOVK  X15, #0xfc3b, LSL #32
    MOVK  X15, #0xfaaa, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D15
    MOVZ  X15, #0x7da0, LSL #0
    MOVK  X15, #0x97b, LSL #16
    MOVK  X15, #0x321e, LSL #32
    MOVK  X15, #0x29fc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X15, #0x13c8, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D16
    MOVZ  X15, #0x13c8, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X15, #0xc813, LSL #0
    MOVK  X15, #0x513b, LSL #16
    MOVK  X15, #0xebf8, LSL #32
    MOVK  X15, #0x7ddc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D17
    MOVZ  X15, #0xc813, LSL #0
    MOVK  X15, #0x513b, LSL #16
    MOVK  X15, #0xebf8, LSL #32
    MOVK  X15, #0x7ddc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D18
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X15, #0xfc3b, LSL #0
    MOVK  X15, #0x51ef, LSL #16
    MOVK  X15, #0xf8eb, LSL #32
    MOVK  X15, #0xdc7d, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D19
    MOVZ  X15, #0x321e, LSL #0
    MOVK  X15, #0x51ef, LSL #16
    MOVK  X15, #0xf8eb, LSL #32
    MOVK  X15, #0xdc7d, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X15, #0xc813, LSL #0
    MOVK  X15, #0x513b, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x511e, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D20
    MOVZ  X15, #0xc813, LSL #0
    MOVK  X15, #0x513b, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x51fc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X15, #0xefef, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0xefef, LSL #32
    MOVK  X15, #0xefef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D21
    MOVZ  X15, #0xefef, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0xefef, LSL #32
    MOVK  X15, #0xefef, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X15, #0xf8eb, LSL #0
    MOVK  X15, #0xdc7d, LSL #16
    MOVK  X15, #0x13c8, LSL #32
    MOVK  X15, #0x3b51, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D22
    MOVZ  X15, #0xf8eb, LSL #0
    MOVK  X15, #0xdc7d, LSL #16
    MOVK  X15, #0x13c8, LSL #32
    MOVK  X15, #0x3b51, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xb8c4, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0xb8c4, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D23
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xb8c4, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0xb8c4, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X15, #0xfc3b, LSL #0
    MOVK  X15, #0x51ef, LSL #16
    MOVK  X15, #0x29fc, LSL #32
    MOVK  X15, #0x7def, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D24
    MOVZ  X15, #0x321e, LSL #0
    MOVK  X15, #0x51ef, LSL #16
    MOVK  X15, #0x7da0, LSL #32
    MOVK  X15, #0x7def, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X15, #0x13c8, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0xf8eb, LSL #32
    MOVK  X15, #0xdc7d, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D25
    MOVZ  X15, #0x13c8, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0xf8eb, LSL #32
    MOVK  X15, #0xdc7d, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X15, #0xfcfc, LSL #0
    MOVK  X15, #0xfccd, LSL #16
    MOVK  X15, #0xfc3b, LSL #32
    MOVK  X15, #0xfcaa, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D26
    MOVZ  X15, #0xfca0, LSL #0
    MOVK  X15, #0xfc7b, LSL #16
    MOVK  X15, #0xfc1e, LSL #32
    MOVK  X15, #0xfcfc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D27
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X15, #0xfc3b, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0xfc3b, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D28
    MOVZ  X15, #0x321e, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x321e, LSL #32
    MOVK  X15, #0x6666, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X15, #0x665b, LSL #0
    MOVK  X15, #0x665b, LSL #16
    MOVK  X15, #0x665b, LSL #32
    MOVK  X15, #0x665b, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D29
    MOVZ  X15, #0x665b, LSL #0
    MOVK  X15, #0x665b, LSL #16
    MOVK  X15, #0x665b, LSL #32
    MOVK  X15, #0x665b, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x511e, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x7d3b, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D30
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x51fc, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x7d1e, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X15, #0x3b51, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0x3b51, LSL #32
    MOVK  X15, #0x3b51, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FMOV  X14, D31
    MOVZ  X15, #0x3b51, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0x3b51, LSL #32
    MOVK  X15, #0x3b51, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
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
    FMOV  X14, D0
    MOVZ  X15, #0x972c, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x53ce, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D1, P3, Z1.D
    FMOV  X14, D1
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0x513b, LSL #32
    MOVK  X15, #0x515b, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X14, D2
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0xf00f, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X14, D3
    MOVZ  X15, #0x51ef, LSL #0
    MOVK  X15, #0xc8ef, LSL #16
    MOVK  X15, #0x7def, LSL #32
    MOVK  X15, #0xec0f, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X14, D4
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X14, D5
    MOVZ  X15, #0x972c, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x1e86, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X14, D6
    MOVZ  X15, #0xf8eb, LSL #0
    MOVK  X15, #0xdc7d, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D7, P5, Z7.D
    FMOV  X14, D7
    MOVZ  X15, #0x3b66, LSL #0
    MOVK  X15, #0x3b66, LSL #16
    MOVK  X15, #0x3b66, LSL #32
    MOVK  X15, #0x3b86, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X14, D8
    MOVZ  X15, #0xaa73, LSL #0
    MOVK  X15, #0xea9f, LSL #16
    MOVK  X15, #0xabdf, LSL #32
    MOVK  X15, #0x51fc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X14, D9
    MOVZ  X15, #0xefef, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0xefef, LSL #32
    MOVK  X15, #0xf00f, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D10, P4, Z10.D
    FMOV  X14, D10
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X14, D11
    MOVZ  X15, #0x1e66, LSL #0
    MOVK  X15, #0x1e66, LSL #16
    MOVK  X15, #0x1e66, LSL #32
    MOVK  X15, #0x1e86, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X14, D12
    MOVZ  X15, #0x972c, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D13, P0, Z13.D
    FMOV  X14, D13
    MOVZ  X15, #0x1e66, LSL #0
    MOVK  X15, #0xfc66, LSL #16
    MOVK  X15, #0x1e66, LSL #32
    MOVK  X15, #0x3b76, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D14, P7, Z14.D
    FMOV  X14, D14
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X14, D15
    MOVZ  X15, #0x29fb, LSL #0
    MOVK  X15, #0xefcd, LSL #16
    MOVK  X15, #0xfc3b, LSL #32
    MOVK  X15, #0xfaba, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X14, D16
    MOVZ  X15, #0x13c8, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D17, P1, Z17.D
    FMOV  X14, D17
    MOVZ  X15, #0xc813, LSL #0
    MOVK  X15, #0x513b, LSL #16
    MOVK  X15, #0xebf8, LSL #32
    MOVK  X15, #0x7dfc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X14, D18
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X14, D19
    MOVZ  X15, #0x972c, LSL #0
    MOVK  X15, #0x51ef, LSL #16
    MOVK  X15, #0xf8eb, LSL #32
    MOVK  X15, #0xdc9d, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X14, D20
    MOVZ  X15, #0x2276, LSL #0
    MOVK  X15, #0xeaa0, LSL #16
    MOVK  X15, #0xabdf, LSL #32
    MOVK  X15, #0x51fc, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D21, P1, Z21.D
    FMOV  X14, D21
    MOVZ  X15, #0xefef, LSL #0
    MOVK  X15, #0xefef, LSL #16
    MOVK  X15, #0xefef, LSL #32
    MOVK  X15, #0xf00f, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X14, D22
    MOVZ  X15, #0xf8eb, LSL #0
    MOVK  X15, #0xdc7d, LSL #16
    MOVK  X15, #0x13c8, LSL #32
    MOVK  X15, #0x3b71, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X14, D23
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0xb8c4, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0xb8e4, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X14, D24
    MOVZ  X15, #0x972c, LSL #0
    MOVK  X15, #0x51ef, LSL #16
    MOVK  X15, #0x53ce, LSL #32
    MOVK  X15, #0x7e0f, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X14, D25
    MOVZ  X15, #0x13c8, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0xf8eb, LSL #32
    MOVK  X15, #0xdc9d, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X14, D26
    MOVZ  X15, #0x6c87, LSL #0
    MOVK  X15, #0xdc62, LSL #16
    MOVK  X15, #0xd400, LSL #32
    MOVK  X15, #0xfd0d, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X14, D27
    MOVZ  X15, #0x6666, LSL #0
    MOVK  X15, #0x6666, LSL #16
    MOVK  X15, #0x6666, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X14, D28
    MOVZ  X15, #0x972c, LSL #0
    MOVK  X15, #0xe666, LSL #16
    MOVK  X15, #0x972c, LSL #32
    MOVK  X15, #0x6686, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D29, P1, Z29.D
    FMOV  X14, D29
    MOVZ  X15, #0x665b, LSL #0
    MOVK  X15, #0x665b, LSL #16
    MOVK  X15, #0x665b, LSL #32
    MOVK  X15, #0x667b, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X14, D30
    MOVZ  X15, #0x67cb, LSL #0
    MOVK  X15, #0xb64c, LSL #16
    MOVK  X15, #0x12cc, LSL #32
    MOVK  X15, #0x7dac, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    FADDV   D31, P7, Z31.D
    FMOV  X14, D31
    MOVZ  X15, #0x3b51, LSL #0
    MOVK  X15, #0x3b51, LSL #16
    MOVK  X15, #0x3b51, LSL #32
    MOVK  X15, #0x3b71, LSL #48
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0x2515, LSL #0
    MOVK  X2, #0x7a06, LSL #16
    MOVK  X2, #0x110b, LSL #32
    MOVK  X2, #0xbb3d, LSL #48
    MOVZ  X3, #0x2247, LSL #0
    MOVK  X3, #0x6046, LSL #16
    MOVK  X3, #0xdc2b, LSL #32
    MOVK  X3, #0x67a6, LSL #48
    MOVZ  X4, #0xeb5b, LSL #0
    MOVK  X4, #0xebb8, LSL #16
    MOVK  X4, #0x4d12, LSL #32
    MOVK  X4, #0xc6b0, LSL #48
    MOVZ  X5, #0x1e5e, LSL #0
    MOVK  X5, #0xa512, LSL #16
    MOVK  X5, #0x5a8a, LSL #32
    MOVK  X5, #0xe42a, LSL #48
    MOVZ  X6, #0x1235, LSL #0
    MOVK  X6, #0xca04, LSL #16
    MOVK  X6, #0x2e16, LSL #32
    MOVK  X6, #0xe754, LSL #48
    MOVZ  X7, #0xb810, LSL #0
    MOVK  X7, #0x85ac, LSL #16
    MOVK  X7, #0x1f66, LSL #32
    MOVK  X7, #0x1266, LSL #48
    MOVZ  X8, #0x8503, LSL #0
    MOVK  X8, #0x12e3, LSL #16
    MOVK  X8, #0x9cb6, LSL #32
    MOVK  X8, #0x6c29, LSL #48
    MOVZ  X9, #0x97a8, LSL #0
    MOVK  X9, #0x2818, LSL #16
    MOVK  X9, #0xf762, LSL #32
    MOVK  X9, #0x35e9, LSL #48
    MOVZ  X10, #0x3b2f, LSL #0
    MOVK  X10, #0x117d, LSL #16
    MOVK  X10, #0xf042, LSL #32
    MOVK  X10, #0x384c, LSL #48
    MOVZ  X11, #0x1bc6, LSL #0
    MOVK  X11, #0x85a0, LSL #16
    MOVK  X11, #0x3325, LSL #32
    MOVK  X11, #0xa258, LSL #48
    MOVZ  X12, #0x67a8, LSL #0
    MOVK  X12, #0x5d65, LSL #16
    MOVK  X12, #0x87f2, LSL #32
    MOVK  X12, #0xc58, LSL #48
    MOVZ  X13, #0x16f4, LSL #0
    MOVK  X13, #0x86a8, LSL #16
    MOVK  X13, #0x2e8a, LSL #32
    MOVK  X13, #0x8687, LSL #48
    MOVZ  X14, #0xbe25, LSL #0
    MOVK  X14, #0xb0b6, LSL #16
    MOVK  X14, #0x6ab3, LSL #32
    MOVK  X14, #0xc42e, LSL #48
    MOVZ  X15, #0xcb5f, LSL #0
    MOVK  X15, #0x30d, LSL #16
    MOVK  X15, #0xb9f2, LSL #32
    MOVK  X15, #0x89b9, LSL #48
    MOVZ  X16, #0x7228, LSL #0
    MOVK  X16, #0xd6c4, LSL #16
    MOVK  X16, #0x6fb5, LSL #32
    MOVK  X16, #0xf21d, LSL #48
    MOVZ  X17, #0x89f0, LSL #0
    MOVK  X17, #0x2d10, LSL #16
    MOVK  X17, #0x507d, LSL #32
    MOVK  X17, #0xbaa3, LSL #48
    MOVZ  X18, #0xf4d, LSL #0
    MOVK  X18, #0x6ca4, LSL #16
    MOVK  X18, #0xd65d, LSL #32
    MOVK  X18, #0x2f59, LSL #48
    MOVZ  X19, #0x8ab0, LSL #0
    MOVK  X19, #0x189, LSL #16
    MOVK  X19, #0x2b4f, LSL #32
    MOVK  X19, #0x9e18, LSL #48
    MOVZ  X20, #0xc1dc, LSL #0
    MOVK  X20, #0x7bb7, LSL #16
    MOVK  X20, #0xbecb, LSL #32
    MOVK  X20, #0x7c84, LSL #48
    MOVZ  X21, #0x7475, LSL #0
    MOVK  X21, #0x685a, LSL #16
    MOVK  X21, #0x35d5, LSL #32
    MOVK  X21, #0xdfd5, LSL #48
    MOVZ  X22, #0x9b82, LSL #0
    MOVK  X22, #0x111c, LSL #16
    MOVK  X22, #0x4197, LSL #32
    MOVK  X22, #0xc3f2, LSL #48
    MOVZ  X23, #0x8f05, LSL #0
    MOVK  X23, #0x4cb1, LSL #16
    MOVK  X23, #0x3179, LSL #32
    MOVK  X23, #0x7682, LSL #48
    MOVZ  X24, #0x6bba, LSL #0
    MOVK  X24, #0xbe0d, LSL #16
    MOVK  X24, #0x8fb6, LSL #32
    MOVK  X24, #0x5ae5, LSL #48
    DUP     Z0.D, X7
    DUP     Z1.D, X23
    DUP     Z2.D, X21
    DUP     Z3.D, X12
    DUP     Z4.D, X22
    DUP     Z5.D, X20
    DUP     Z6.D, X24
    DUP     Z7.D, X19
    DUP     Z8.D, X3
    DUP     Z9.D, X2
    DUP     Z10.D, X22
    DUP     Z11.D, X16
    DUP     Z12.D, X11
    DUP     Z13.D, X19
    DUP     Z14.D, X15
    DUP     Z15.D, X5
    DUP     Z16.D, X23
    DUP     Z17.D, X11
    DUP     Z18.D, X6
    DUP     Z19.D, X6
    DUP     Z20.D, X17
    DUP     Z21.D, X13
    DUP     Z22.D, X5
    DUP     Z23.D, X11
    DUP     Z24.D, X14
    DUP     Z25.D, X20
    DUP     Z26.D, X13
    DUP     Z27.D, X13
    DUP     Z28.D, X2
    DUP     Z29.D, X2
    DUP     Z30.D, X7
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
    TRN1    Z29.D, Z31.D, Z28.D
    TRN1    Z7.D, Z23.D, Z30.D
    TRN1    Z25.D, Z7.D, Z29.D
    TRN1    Z19.D, Z25.D, Z25.D
    TRN1    Z31.D, Z12.D, Z19.D
    TRN1    Z4.D, Z31.D, Z31.D
    TRN1    Z22.D, Z7.D, Z4.D
    TRN1    Z27.D, Z22.D, Z13.D
    TRN1    Z11.D, Z31.D, Z12.D
    TRN1    Z8.D, Z11.D, Z10.D
    TRN2    Z12.B, Z13.B, Z27.B
    TRN2    Z13.B, Z14.B, Z14.B
    TRN2    Z31.B, Z21.B, Z18.B
    TRN2    Z23.B, Z16.B, Z1.B
    TRN2    Z1.B, Z21.B, Z0.B
    TRN2    Z21.B, Z20.B, Z3.B
    TRN2    Z0.B, Z4.B, Z17.B
    TRN2    Z3.B, Z24.B, Z24.B
    TRN2    Z10.B, Z14.B, Z8.B
    TRN2    Z4.B, Z1.B, Z23.B
    TRN2    Z23.H, Z4.H, Z7.H
    TRN2    Z4.H, Z12.H, Z21.H
    TRN2    Z14.H, Z18.H, Z2.H
    TRN2    Z12.H, Z23.H, Z23.H
    TRN2    Z12.H, Z15.H, Z12.H
    TRN2    Z7.H, Z12.H, Z12.H
    TRN2    Z24.H, Z14.H, Z24.H
    TRN2    Z11.H, Z10.H, Z0.H
    TRN2    Z10.H, Z31.H, Z24.H
    TRN2    Z8.H, Z4.H, Z27.H
    TRN2    Z20.D, Z8.D, Z18.D
    TRN2    Z23.D, Z10.D, Z7.D
    TRN2    Z27.D, Z23.D, Z20.D
    TRN2    Z15.D, Z11.D, Z3.D
    TRN2    Z21.D, Z27.D, Z27.D
    TRN2    Z27.D, Z21.D, Z21.D
    TRN2    Z20.D, Z27.D, Z15.D
    TRN2    Z7.D, Z7.D, Z22.D
    TRN2    Z10.D, Z27.D, Z15.D
    TRN2    Z18.D, Z30.D, Z8.D
    TRN2    Z27.S, Z29.S, Z21.S
    TRN2    Z4.S, Z9.S, Z17.S
    TRN2    Z2.S, Z15.S, Z10.S
    TRN2    Z29.S, Z27.S, Z29.S
    TRN2    Z14.S, Z9.S, Z13.S
    TRN2    Z24.S, Z27.S, Z2.S
    TRN2    Z22.S, Z12.S, Z24.S
    TRN2    Z15.S, Z7.S, Z31.S
    TRN2    Z15.S, Z4.S, Z12.S
    TRN2    Z11.S, Z8.S, Z18.S
    UZP1    Z27.S, Z8.S, Z0.S
    UZP1    Z4.S, Z18.S, Z26.S
    UZP1    Z6.S, Z28.S, Z19.S
    UZP1    Z7.S, Z14.S, Z22.S
    UZP1    Z17.S, Z15.S, Z6.S
    UZP1    Z21.S, Z27.S, Z4.S
    UZP1    Z28.S, Z19.S, Z7.S
    UZP1    Z13.S, Z8.S, Z20.S
    UZP1    Z24.S, Z22.S, Z29.S
    UZP1    Z6.S, Z13.S, Z12.S
    UZP1    Z18.B, Z2.B, Z1.B
    UZP1    Z31.B, Z11.B, Z18.B
    UZP1    Z25.B, Z4.B, Z28.B
    UZP1    Z2.B, Z26.B, Z29.B
    UZP1    Z15.B, Z17.B, Z10.B
    UZP1    Z20.B, Z2.B, Z9.B
    UZP1    Z30.B, Z22.B, Z24.B
    UZP1    Z13.B, Z6.B, Z25.B
    UZP1    Z11.B, Z15.B, Z21.B
    UZP1    Z0.B, Z22.B, Z13.B
    UZP1    Z6.H, Z0.H, Z31.H
    UZP1    Z31.H, Z20.H, Z6.H
    UZP1    Z10.H, Z3.H, Z11.H
    UZP1    Z27.H, Z18.H, Z30.H
    UZP1    Z16.H, Z10.H, Z10.H
    UZP1    Z10.H, Z31.H, Z31.H
    UZP1    Z20.H, Z16.H, Z22.H
    UZP1    Z15.H, Z10.H, Z10.H
    UZP1    Z28.H, Z15.H, Z0.H
    UZP1    Z18.H, Z20.H, Z4.H
    UZP1    Z25.D, Z30.D, Z14.D
    UZP1    Z11.D, Z1.D, Z18.D
    UZP1    Z3.D, Z27.D, Z20.D
    UZP1    Z27.D, Z25.D, Z4.D
    UZP1    Z2.D, Z3.D, Z6.D
    UZP1    Z15.D, Z27.D, Z2.D
    UZP1    Z28.D, Z15.D, Z28.D
    UZP1    Z22.D, Z22.D, Z13.D
    UZP1    Z18.D, Z19.D, Z26.D
    UZP1    Z20.D, Z18.D, Z22.D
    UZP2    Z1.D, Z5.D, Z15.D
    UZP2    Z29.D, Z27.D, Z11.D
    UZP2    Z13.D, Z1.D, Z16.D
    UZP2    Z0.D, Z6.D, Z30.D
    UZP2    Z31.D, Z4.D, Z7.D
    UZP2    Z2.D, Z6.D, Z7.D
    UZP2    Z13.D, Z31.D, Z11.D
    UZP2    Z11.D, Z27.D, Z4.D
    UZP2    Z10.D, Z2.D, Z28.D
    UZP2    Z20.D, Z15.D, Z12.D
    UZP2    Z30.H, Z9.H, Z4.H
    UZP2    Z27.H, Z16.H, Z16.H
    UZP2    Z12.H, Z15.H, Z31.H
    UZP2    Z1.H, Z27.H, Z31.H
    UZP2    Z3.H, Z0.H, Z2.H
    UZP2    Z15.H, Z31.H, Z20.H
    UZP2    Z31.H, Z15.H, Z3.H
    UZP2    Z5.H, Z10.H, Z11.H
    UZP2    Z7.H, Z22.H, Z29.H
    UZP2    Z19.H, Z13.H, Z21.H
    UZP2    Z6.B, Z7.B, Z30.B
    UZP2    Z2.B, Z12.B, Z31.B
    UZP2    Z16.B, Z8.B, Z9.B
    UZP2    Z31.B, Z1.B, Z16.B
    UZP2    Z15.B, Z6.B, Z31.B
    UZP2    Z22.B, Z2.B, Z2.B
    UZP2    Z26.B, Z15.B, Z22.B
    UZP2    Z4.B, Z19.B, Z5.B
    UZP2    Z18.B, Z23.B, Z26.B
    UZP2    Z22.B, Z29.B, Z0.B
    UZP2    Z13.S, Z24.S, Z27.S
    UZP2    Z23.S, Z21.S, Z19.S
    UZP2    Z0.S, Z0.S, Z30.S
    UZP2    Z12.S, Z30.S, Z3.S
    UZP2    Z1.S, Z20.S, Z30.S
    UZP2    Z3.S, Z21.S, Z24.S
    UZP2    Z10.S, Z0.S, Z0.S
    UZP2    Z15.S, Z3.S, Z4.S
    UZP2    Z27.S, Z21.S, Z25.S
    UZP2    Z19.S, Z6.S, Z18.S
    ZIP1    Z18.B, Z27.B, Z23.B
    ZIP1    Z5.B, Z12.B, Z12.B
    ZIP1    Z27.B, Z17.B, Z23.B
    ZIP1    Z27.B, Z30.B, Z10.B
    ZIP1    Z31.B, Z13.B, Z1.B
    ZIP1    Z13.B, Z15.B, Z22.B
    ZIP1    Z17.B, Z18.B, Z13.B
    ZIP1    Z7.B, Z5.B, Z19.B
    ZIP1    Z0.B, Z31.B, Z7.B
    ZIP1    Z31.B, Z0.B, Z17.B
    ZIP1    Z2.D, Z1.D, Z29.D
    ZIP1    Z12.D, Z30.D, Z1.D
    ZIP1    Z13.D, Z25.D, Z7.D
    ZIP1    Z0.D, Z30.D, Z12.D
    ZIP1    Z29.D, Z7.D, Z17.D
    ZIP1    Z7.D, Z7.D, Z18.D
    ZIP1    Z6.D, Z5.D, Z17.D
    ZIP1    Z19.D, Z7.D, Z18.D
    ZIP1    Z13.D, Z22.D, Z23.D
    ZIP1    Z16.D, Z27.D, Z0.D
    ZIP1    Z10.H, Z6.H, Z13.H
    ZIP1    Z3.H, Z19.H, Z27.H
    ZIP1    Z0.H, Z12.H, Z2.H
    ZIP1    Z20.H, Z0.H, Z10.H
    ZIP1    Z10.H, Z29.H, Z16.H
    ZIP1    Z13.H, Z24.H, Z31.H
    ZIP1    Z27.H, Z18.H, Z10.H
    ZIP1    Z30.H, Z13.H, Z27.H
    ZIP1    Z27.H, Z20.H, Z30.H
    ZIP1    Z24.H, Z4.H, Z30.H
    ZIP1    Z13.S, Z6.S, Z28.S
    ZIP1    Z26.S, Z27.S, Z13.S
    ZIP1    Z28.S, Z2.S, Z31.S
    ZIP1    Z22.S, Z11.S, Z25.S
    ZIP1    Z23.S, Z30.S, Z3.S
    ZIP1    Z0.S, Z22.S, Z24.S
    ZIP1    Z20.S, Z28.S, Z15.S
    ZIP1    Z13.S, Z13.S, Z13.S
    ZIP1    Z27.S, Z21.S, Z1.S
    ZIP1    Z24.S, Z23.S, Z28.S
    ZIP2    Z1.D, Z24.D, Z23.D
    ZIP2    Z22.D, Z17.D, Z23.D
    ZIP2    Z28.D, Z16.D, Z18.D
    ZIP2    Z5.D, Z12.D, Z12.D
    ZIP2    Z12.D, Z25.D, Z27.D
    ZIP2    Z27.D, Z26.D, Z26.D
    ZIP2    Z3.D, Z0.D, Z20.D
    ZIP2    Z9.D, Z22.D, Z4.D
    ZIP2    Z27.D, Z15.D, Z21.D
    ZIP2    Z21.D, Z3.D, Z24.D
    ZIP2    Z10.H, Z28.H, Z21.H
    ZIP2    Z2.H, Z12.H, Z12.H
    ZIP2    Z13.H, Z9.H, Z27.H
    ZIP2    Z17.H, Z10.H, Z6.H
    ZIP2    Z26.H, Z20.H, Z9.H
    ZIP2    Z4.H, Z5.H, Z26.H
    ZIP2    Z15.H, Z4.H, Z4.H
    ZIP2    Z16.H, Z17.H, Z1.H
    ZIP2    Z0.H, Z1.H, Z8.H
    ZIP2    Z18.H, Z4.H, Z13.H
    ZIP2    Z23.B, Z15.B, Z31.B
    ZIP2    Z25.B, Z26.B, Z2.B
    ZIP2    Z6.B, Z18.B, Z18.B
    ZIP2    Z30.B, Z11.B, Z13.B
    ZIP2    Z21.B, Z24.B, Z16.B
    ZIP2    Z4.B, Z14.B, Z15.B
    ZIP2    Z0.B, Z25.B, Z30.B
    ZIP2    Z31.B, Z26.B, Z18.B
    ZIP2    Z5.B, Z4.B, Z15.B
    ZIP2    Z28.B, Z0.B, Z12.B
    ZIP2    Z8.S, Z28.S, Z6.S
    ZIP2    Z4.S, Z5.S, Z5.S
    ZIP2    Z4.S, Z21.S, Z29.S
    ZIP2    Z16.S, Z30.S, Z6.S
    ZIP2    Z28.S, Z13.S, Z20.S
    ZIP2    Z29.S, Z8.S, Z8.S
    ZIP2    Z26.S, Z4.S, Z0.S
    ZIP2    Z24.S, Z25.S, Z4.S
    ZIP2    Z8.S, Z8.S, Z31.S
    ZIP2    Z15.S, Z28.S, Z24.S
    INDEX   Z4.B, #3, #-11
    INDEX   Z18.B, #-15, #10
    INDEX   Z31.B, #-8, #8
    INDEX   Z12.B, #14, #-3
    INDEX   Z22.B, #-14, #5
    INDEX   Z7.B, #1, #14
    INDEX   Z0.B, #-11, #8
    INDEX   Z6.B, #2, #-10
    INDEX   Z20.B, #2, #0
    INDEX   Z28.B, #-9, #-6
    INDEX   Z7.S, W14, #-6
    INDEX   Z24.S, W23, #4
    INDEX   Z21.S, W22, #-3
    INDEX   Z13.S, W6, #2
    INDEX   Z25.S, W12, #-2
    INDEX   Z17.S, W14, #-13
    INDEX   Z13.S, W5, #-13
    INDEX   Z25.S, W7, #12
    INDEX   Z16.S, W12, #6
    INDEX   Z13.S, W22, #-13
    INDEX   Z1.H, W15, W18
    INDEX   Z3.H, W22, W8
    INDEX   Z19.H, W22, W23
    INDEX   Z29.H, W16, W18
    INDEX   Z31.H, W13, W8
    INDEX   Z4.H, W8, W14
    INDEX   Z1.H, W2, W20
    INDEX   Z31.H, W5, W23
    INDEX   Z0.H, W11, W17
    INDEX   Z0.H, W24, W23
    INDEX   Z22.D, X18, #-8
    INDEX   Z14.D, X6, #-7
    INDEX   Z20.D, X12, #-4
    INDEX   Z19.D, X23, #5
    INDEX   Z7.D, X15, #10
    INDEX   Z5.D, X20, #-8
    INDEX   Z4.D, X13, #-12
    INDEX   Z3.D, X6, #-8
    INDEX   Z12.D, X22, #1
    INDEX   Z31.D, X24, #4
    INDEX   Z0.H, #-7, #-14
    INDEX   Z1.H, #4, #14
    INDEX   Z13.H, #15, #11
    INDEX   Z10.H, #12, #-13
    INDEX   Z18.H, #9, #0
    INDEX   Z26.H, #-1, #-9
    INDEX   Z2.H, #11, #-14
    INDEX   Z27.H, #-8, #-12
    INDEX   Z0.H, #-3, #8
    INDEX   Z15.H, #-16, #13
    INDEX   Z25.H, W14, #-11
    INDEX   Z5.H, W17, #3
    INDEX   Z16.H, W24, #-4
    INDEX   Z30.H, W21, #11
    INDEX   Z3.H, W21, #-9
    INDEX   Z29.H, W10, #-10
    INDEX   Z12.H, W24, #-2
    INDEX   Z5.H, W19, #-4
    INDEX   Z11.H, W17, #-9
    INDEX   Z17.H, W17, #-16
    INDEX   Z15.S, #-4, #-10
    INDEX   Z5.S, #5, #-4
    INDEX   Z6.S, #11, #11
    INDEX   Z14.S, #-3, #-15
    INDEX   Z4.S, #9, #-11
    INDEX   Z9.S, #-12, #1
    INDEX   Z31.S, #-16, #-3
    INDEX   Z6.S, #2, #-6
    INDEX   Z13.S, #3, #10
    INDEX   Z25.S, #-11, #12
    INDEX   Z14.S, #-2, W20
    INDEX   Z21.S, #11, W17
    INDEX   Z14.S, #9, W8
    INDEX   Z3.S, #-16, W22
    INDEX   Z21.S, #-11, W22
    INDEX   Z23.S, #-2, W20
    INDEX   Z22.S, #-11, W10
    INDEX   Z8.S, #-10, W21
    INDEX   Z24.S, #0, W7
    INDEX   Z13.S, #9, W5
    INDEX   Z5.D, #10, #-16
    INDEX   Z10.D, #-11, #3
    INDEX   Z24.D, #-14, #2
    INDEX   Z13.D, #-7, #-5
    INDEX   Z7.D, #10, #-5
    INDEX   Z21.D, #-13, #9
    INDEX   Z24.D, #-13, #-7
    INDEX   Z17.D, #-15, #13
    INDEX   Z31.D, #2, #-1
    INDEX   Z29.D, #13, #14
    MOVZ  X9, #0x2515, LSL #0
    MOVK  X9, #0x7a06, LSL #16
    MOVK  X9, #0x110b, LSL #32
    MOVK  X9, #0xbb3d, LSL #48
    SUB  X4, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x1e5e, LSL #0
    MOVK  X9, #0xa512, LSL #16
    MOVK  X9, #0x5a8a, LSL #32
    MOVK  X9, #0xe42a, LSL #48
    SUB  X4, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x1235, LSL #0
    MOVK  X9, #0xca04, LSL #16
    MOVK  X9, #0x2e16, LSL #32
    MOVK  X9, #0xe754, LSL #48
    SUB  X4, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xb810, LSL #0
    MOVK  X9, #0x85ac, LSL #16
    MOVK  X9, #0x1f66, LSL #32
    MOVK  X9, #0x1266, LSL #48
    SUB  X4, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x8503, LSL #0
    MOVK  X9, #0x12e3, LSL #16
    MOVK  X9, #0x9cb6, LSL #32
    MOVK  X9, #0x6c29, LSL #48
    SUB  X4, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x3b2f, LSL #0
    MOVK  X9, #0x117d, LSL #16
    MOVK  X9, #0xf042, LSL #32
    MOVK  X9, #0x384c, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x1bc6, LSL #0
    MOVK  X9, #0x85a0, LSL #16
    MOVK  X9, #0x3325, LSL #32
    MOVK  X9, #0xa258, LSL #48
    SUB  X4, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x67a8, LSL #0
    MOVK  X9, #0x5d65, LSL #16
    MOVK  X9, #0x87f2, LSL #32
    MOVK  X9, #0xc58, LSL #48
    SUB  X4, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x16f4, LSL #0
    MOVK  X9, #0x86a8, LSL #16
    MOVK  X9, #0x2e8a, LSL #32
    MOVK  X9, #0x8687, LSL #48
    SUB  X4, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xbe25, LSL #0
    MOVK  X9, #0xb0b6, LSL #16
    MOVK  X9, #0x6ab3, LSL #32
    MOVK  X9, #0xc42e, LSL #48
    SUB  X4, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xcb5f, LSL #0
    MOVK  X9, #0x30d, LSL #16
    MOVK  X9, #0xb9f2, LSL #32
    MOVK  X9, #0x89b9, LSL #48
    SUB  X4, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x7228, LSL #0
    MOVK  X9, #0xd6c4, LSL #16
    MOVK  X9, #0x6fb5, LSL #32
    MOVK  X9, #0xf21d, LSL #48
    SUB  X4, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x89f0, LSL #0
    MOVK  X9, #0x2d10, LSL #16
    MOVK  X9, #0x507d, LSL #32
    MOVK  X9, #0xbaa3, LSL #48
    SUB  X4, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xf4d, LSL #0
    MOVK  X9, #0x6ca4, LSL #16
    MOVK  X9, #0xd65d, LSL #32
    MOVK  X9, #0x2f59, LSL #48
    SUB  X4, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x8ab0, LSL #0
    MOVK  X9, #0x189, LSL #16
    MOVK  X9, #0x2b4f, LSL #32
    MOVK  X9, #0x9e18, LSL #48
    SUB  X4, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xc1dc, LSL #0
    MOVK  X9, #0x7bb7, LSL #16
    MOVK  X9, #0xbecb, LSL #32
    MOVK  X9, #0x7c84, LSL #48
    SUB  X4, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x7475, LSL #0
    MOVK  X9, #0x685a, LSL #16
    MOVK  X9, #0x35d5, LSL #32
    MOVK  X9, #0xdfd5, LSL #48
    SUB  X4, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x9b82, LSL #0
    MOVK  X9, #0x111c, LSL #16
    MOVK  X9, #0x4197, LSL #32
    MOVK  X9, #0xc3f2, LSL #48
    SUB  X4, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x8f05, LSL #0
    MOVK  X9, #0x4cb1, LSL #16
    MOVK  X9, #0x3179, LSL #32
    MOVK  X9, #0x7682, LSL #48
    SUB  X4, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x6bba, LSL #0
    MOVK  X9, #0xbe0d, LSL #16
    MOVK  X9, #0x8fb6, LSL #32
    MOVK  X9, #0x5ae5, LSL #48
    SUB  X4, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTSveMoveOperations_TestFail
    MRS  X9, FPSR
    MOVZ  X4, #0x90, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X4, #0x1d, LSL #0
    MOVK  X4, #0x25, LSL #16
    MOVK  X4, #0x2d, LSL #32
    MOVK  X4, #0x35, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D0
    MOVZ  X4, #0xfffd, LSL #0
    MOVK  X4, #0x5, LSL #16
    MOVK  X4, #0xd, LSL #32
    MOVK  X4, #0x15, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X4, #0x3c, LSL #0
    MOVK  X4, #0x4a, LSL #16
    MOVK  X4, #0x58, LSL #32
    MOVK  X4, #0x66, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D1
    MOVZ  X4, #0x4, LSL #0
    MOVK  X4, #0x12, LSL #16
    MOVK  X4, #0x20, LSL #32
    MOVK  X4, #0x2e, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X4, #0xffd3, LSL #0
    MOVK  X4, #0xffc5, LSL #16
    MOVK  X4, #0xffb7, LSL #32
    MOVK  X4, #0xffa9, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D2
    MOVZ  X4, #0xb, LSL #0
    MOVK  X4, #0xfffd, LSL #16
    MOVK  X4, #0xffef, LSL #32
    MOVK  X4, #0xffe1, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X4, #0x36f4, LSL #0
    MOVK  X4, #0x2239, LSL #16
    MOVK  X4, #0xd276, LSL #32
    MOVK  X4, #0x3355, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D3
    MOVZ  X4, #0xfff0, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0x9b72, LSL #32
    MOVK  X4, #0x111c, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X4, #0xfff3, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffe8, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D4
    MOVZ  X4, #0x9, LSL #0
    MOVK  X4, #0xfffe, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X4, #0xfffa, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D5
    MOVZ  X4, #0xa, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X4, #0xfff6, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xfff0, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D6
    MOVZ  X4, #0x2, LSL #0
    MOVK  X4, #0xfffc, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X4, #0x5, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D7
    MOVZ  X4, #0xa, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X4, #0xe8e0, LSL #0
    MOVK  X4, #0xd0b4, LSL #16
    MOVK  X4, #0x5d55, LSL #32
    MOVK  X4, #0x390f, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D8
    MOVZ  X4, #0xfff6, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0x746b, LSL #32
    MOVK  X4, #0x685a, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X4, #0xfff6, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xfff7, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D9
    MOVZ  X4, #0xfff4, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xfff5, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X4, #0xfff8, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D10
    MOVZ  X4, #0xfff5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X4, #0x89cc, LSL #0
    MOVK  X4, #0x89c3, LSL #16
    MOVK  X4, #0x89ba, LSL #32
    MOVK  X4, #0x89b1, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D11
    MOVZ  X4, #0x89f0, LSL #0
    MOVK  X4, #0x89e7, LSL #16
    MOVK  X4, #0x89de, LSL #32
    MOVK  X4, #0x89d5, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X4, #0x6bb2, LSL #0
    MOVK  X4, #0x6bb0, LSL #16
    MOVK  X4, #0x6bae, LSL #32
    MOVK  X4, #0x6bac, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D12
    MOVZ  X4, #0x6bba, LSL #0
    MOVK  X4, #0x6bb8, LSL #16
    MOVK  X4, #0x6bb6, LSL #32
    MOVK  X4, #0x6bb4, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X4, #0xfff4, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D13
    MOVZ  X4, #0xfff9, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X4, #0xa0f, LSL #0
    MOVK  X4, #0x25c7, LSL #16
    MOVK  X4, #0x8f12, LSL #32
    MOVK  X4, #0x38aa, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D14
    MOVZ  X4, #0x9, LSL #0
    MOVK  X4, #0x850c, LSL #32
    MOVK  X4, #0x12e3, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X4, #0xffe8, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffde, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D15
    MOVZ  X4, #0xfffc, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xfff2, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X4, #0x6baa, LSL #0
    MOVK  X4, #0x6ba6, LSL #16
    MOVK  X4, #0x6ba2, LSL #32
    MOVK  X4, #0x6b9e, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D16
    MOVZ  X4, #0x6bba, LSL #0
    MOVK  X4, #0x6bb6, LSL #16
    MOVK  X4, #0x6bb2, LSL #32
    MOVK  X4, #0x6bae, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D17
    MOVZ  X4, #0xfff1, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X4, #0x9, LSL #0
    MOVK  X4, #0x9, LSL #16
    MOVK  X4, #0x9, LSL #32
    MOVK  X4, #0x9, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D18
    MOVZ  X4, #0x9, LSL #0
    MOVK  X4, #0x9, LSL #16
    MOVK  X4, #0x9, LSL #32
    MOVK  X4, #0x9, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X4, #0x8f0a, LSL #0
    MOVK  X4, #0x4cb1, LSL #16
    MOVK  X4, #0x3179, LSL #32
    MOVK  X4, #0x7682, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D19
    MOVZ  X4, #0x8f05, LSL #0
    MOVK  X4, #0x4cb1, LSL #16
    MOVK  X4, #0x3179, LSL #32
    MOVK  X4, #0x7682, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X4, #0x67a4, LSL #0
    MOVK  X4, #0x5d65, LSL #16
    MOVK  X4, #0x87f2, LSL #32
    MOVK  X4, #0xc58, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D20
    MOVZ  X4, #0x67a8, LSL #0
    MOVK  X4, #0x5d65, LSL #16
    MOVK  X4, #0x87f2, LSL #32
    MOVK  X4, #0xc58, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X4, #0xfffc, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D21
    MOVZ  X4, #0xfff3, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X4, #0x7653, LSL #0
    MOVK  X4, #0x22fa, LSL #16
    MOVK  X4, #0xb182, LSL #32
    MOVK  X4, #0x3477, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D22
    MOVZ  X4, #0xfff5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0x3b24, LSL #32
    MOVK  X4, #0x117d, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X4, #0x83b6, LSL #0
    MOVK  X4, #0xf76f, LSL #16
    MOVK  X4, #0x4592, LSL #32
    MOVK  X4, #0x7327, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D23
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xc1da, LSL #32
    MOVK  X4, #0x7bb7, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X4, #0xffec, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D24
    MOVZ  X4, #0xfff3, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X4, #0xd, LSL #0
    MOVK  X4, #0x19, LSL #32
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D25
    MOVZ  X4, #0xfff5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0x1, LSL #32
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X4, #0xffdb, LSL #0
    MOVK  X4, #0xffd2, LSL #16
    MOVK  X4, #0xffc9, LSL #32
    MOVK  X4, #0xffc0, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D26
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xfff6, LSL #16
    MOVK  X4, #0xffed, LSL #32
    MOVK  X4, #0xffe4, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X4, #0xffc8, LSL #0
    MOVK  X4, #0xffbc, LSL #16
    MOVK  X4, #0xffb0, LSL #32
    MOVK  X4, #0xffa4, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D27
    MOVZ  X4, #0xfff8, LSL #0
    MOVK  X4, #0xffec, LSL #16
    MOVK  X4, #0xffe0, LSL #32
    MOVK  X4, #0xffd4, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X4, #0xc1c7, LSL #0
    MOVK  X4, #0xb5bb, LSL #16
    MOVK  X4, #0xa9af, LSL #32
    MOVK  X4, #0x9da3, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D28
    MOVZ  X4, #0xf1f7, LSL #0
    MOVK  X4, #0xe5eb, LSL #16
    MOVK  X4, #0xd9df, LSL #32
    MOVK  X4, #0xcdd3, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X4, #0x1b, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D29
    MOVZ  X4, #0xd, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X4, #0x74a1, LSL #0
    MOVK  X4, #0x74ac, LSL #16
    MOVK  X4, #0x74b7, LSL #32
    MOVK  X4, #0x74c2, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D30
    MOVZ  X4, #0x7475, LSL #0
    MOVK  X4, #0x7480, LSL #16
    MOVK  X4, #0x748b, LSL #32
    MOVK  X4, #0x7496, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X4, #0x1, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X9, D31
    MOVZ  X4, #0x2, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
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
    FMOV  X9, D0
    MOVZ  X4, #0xa86d, LSL #0
    MOVK  X4, #0x4478, LSL #16
    MOVK  X4, #0xe483, LSL #32
    MOVK  X4, #0x7b, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X9, D1
    MOVZ  X4, #0xb6f3, LSL #0
    MOVK  X4, #0xb4c2, LSL #16
    MOVK  X4, #0x1091, LSL #32
    MOVK  X4, #0xd8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X9, D2
    MOVZ  X4, #0x66c7, LSL #0
    MOVK  X4, #0x68f8, LSL #16
    MOVK  X4, #0xc72a, LSL #32
    MOVK  X4, #0xffe3, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D3, P4, Z3.D
    FMOV  X9, D3
    MOVZ  X4, #0xa4fc, LSL #0
    MOVK  X4, #0x66ab, LSL #16
    MOVK  X4, #0x407e, LSL #32
    MOVK  X4, #0x77c8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X9, D4
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X9, D5
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D6, P3, Z6.D
    FMOV  X9, D6
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X9, D7
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X9, D8
    MOVZ  X4, #0xfff5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0x746b, LSL #32
    MOVK  X4, #0x685a, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X9, D9
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X9, D10
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X9, D11
    MOVZ  X4, #0x5fc3, LSL #0
    MOVK  X4, #0xc5b8, LSL #16
    MOVK  X4, #0xbac, LSL #32
    MOVK  X4, #0x89db, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X9, D12
    MOVZ  X4, #0x7927, LSL #0
    MOVK  X4, #0x3926, LSL #16
    MOVK  X4, #0xf924, LSL #32
    MOVK  X4, #0x6bc9, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X9, D13
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X9, D14
    MOVZ  X4, #0x1414, LSL #0
    MOVK  X4, #0x4b8e, LSL #16
    MOVK  X4, #0x9918, LSL #32
    MOVK  X4, #0x5e71, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X9, D15
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X9, D16
    MOVZ  X4, #0x4f2, LSL #0
    MOVK  X4, #0x44f0, LSL #16
    MOVK  X4, #0x84ec, LSL #32
    MOVK  X4, #0x6bbc, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X9, D17
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X9, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X9, D19
    MOVZ  X4, #0x8f0c, LSL #0
    MOVK  X4, #0x4cb1, LSL #16
    MOVK  X4, #0x3179, LSL #32
    MOVK  X4, #0x76a2, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X9, D20
    MOVZ  X4, #0x67a2, LSL #0
    MOVK  X4, #0x5d65, LSL #16
    MOVK  X4, #0x87f2, LSL #32
    MOVK  X4, #0xc78, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D21, P4, Z21.D
    FMOV  X9, D21
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X9, D22
    MOVZ  X4, #0x630f, LSL #0
    MOVK  X4, #0x68ef, LSL #16
    MOVK  X4, #0x9e3e, LSL #32
    MOVK  X4, #0x7a6c, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X9, D23
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xc1da, LSL #32
    MOVK  X4, #0x7bb7, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X9, D24
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X9, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X9, D26
    MOVZ  X4, #0x4df1, LSL #0
    MOVK  X4, #0xb3e8, LSL #16
    MOVK  X4, #0x59dc, LSL #32
    MOVK  X4, #0xffea, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X9, D27
    MOVZ  X4, #0x826f, LSL #0
    MOVK  X4, #0xcc62, LSL #16
    MOVK  X4, #0xfe54, LSL #32
    MOVK  X4, #0xffd7, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X9, D28
    MOVZ  X4, #0x9196, LSL #0
    MOVK  X4, #0x858b, LSL #16
    MOVK  X4, #0x797f, LSL #32
    MOVK  X4, #0x6d73, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X9, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D30, P6, Z30.D
    FMOV  X9, D30
    MOVZ  X4, #0x67ab, LSL #0
    MOVK  X4, #0x2ab9, LSL #16
    MOVK  X4, #0xedc6, LSL #32
    MOVK  X4, #0x751e, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D31, P6, Z31.D
    FMOV  X9, D31
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7ff8, LSL #48
    SUB  X3, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0x93a4, LSL #0
    MOVK  X2, #0xac69, LSL #16
    MOVK  X2, #0xe838, LSL #32
    MOVK  X2, #0x2d6a, LSL #48
    MOVZ  X3, #0xd17, LSL #0
    MOVK  X3, #0x69e0, LSL #16
    MOVK  X3, #0x7f5b, LSL #32
    MOVK  X3, #0x5c88, LSL #48
    MOVZ  X4, #0xf88, LSL #0
    MOVK  X4, #0xc6ae, LSL #16
    MOVK  X4, #0x19aa, LSL #32
    MOVK  X4, #0x23d0, LSL #48
    MOVZ  X5, #0x59d4, LSL #0
    MOVK  X5, #0x8b8b, LSL #16
    MOVK  X5, #0x6739, LSL #32
    MOVK  X5, #0xf69d, LSL #48
    MOVZ  X6, #0x681d, LSL #0
    MOVK  X6, #0xfd5d, LSL #16
    MOVK  X6, #0x5f54, LSL #32
    MOVK  X6, #0x8de3, LSL #48
    MOVZ  X7, #0xdc72, LSL #0
    MOVK  X7, #0x8a48, LSL #16
    MOVK  X7, #0x30c0, LSL #32
    MOVK  X7, #0xdda4, LSL #48
    MOVZ  X8, #0xf3fc, LSL #0
    MOVK  X8, #0x956d, LSL #16
    MOVK  X8, #0x5145, LSL #32
    MOVK  X8, #0xe100, LSL #48
    MOVZ  X9, #0x58b9, LSL #0
    MOVK  X9, #0xc5fd, LSL #16
    MOVK  X9, #0x4a04, LSL #32
    MOVK  X9, #0xd5c0, LSL #48
    MOVZ  X10, #0x3f80, LSL #0
    MOVK  X10, #0x72ef, LSL #16
    MOVK  X10, #0xf202, LSL #32
    MOVK  X10, #0xa808, LSL #48
    MOVZ  X11, #0x3803, LSL #0
    MOVK  X11, #0x1dce, LSL #16
    MOVK  X11, #0x4986, LSL #32
    MOVK  X11, #0x87ab, LSL #48
    MOVZ  X12, #0xbcd, LSL #0
    MOVK  X12, #0x6d8, LSL #16
    MOVK  X12, #0x29b8, LSL #32
    MOVK  X12, #0x5897, LSL #48
    MOVZ  X13, #0xbb7f, LSL #0
    MOVK  X13, #0x2fb, LSL #16
    MOVK  X13, #0x5155, LSL #32
    MOVK  X13, #0xaef8, LSL #48
    MOVZ  X14, #0xc40b, LSL #0
    MOVK  X14, #0xe388, LSL #16
    MOVK  X14, #0x8b90, LSL #32
    MOVK  X14, #0x375, LSL #48
    MOVZ  X15, #0xc447, LSL #0
    MOVK  X15, #0x2d50, LSL #16
    MOVK  X15, #0x9c23, LSL #32
    MOVK  X15, #0x23ef, LSL #48
    MOVZ  X16, #0x746c, LSL #0
    MOVK  X16, #0x68c2, LSL #16
    MOVK  X16, #0x3868, LSL #32
    MOVK  X16, #0x6cb8, LSL #48
    MOVZ  X17, #0xe4cf, LSL #0
    MOVK  X17, #0xad4e, LSL #16
    MOVK  X17, #0x7232, LSL #32
    MOVK  X17, #0x977e, LSL #48
    MOVZ  X18, #0xe38a, LSL #0
    MOVK  X18, #0xbeed, LSL #16
    MOVK  X18, #0x340b, LSL #32
    MOVK  X18, #0x2cca, LSL #48
    MOVZ  X19, #0xf0a2, LSL #0
    MOVK  X19, #0xbb68, LSL #16
    MOVK  X19, #0x9aaf, LSL #32
    MOVK  X19, #0x48f0, LSL #48
    MOVZ  X20, #0x416b, LSL #0
    MOVK  X20, #0x85d0, LSL #16
    MOVK  X20, #0xb0f6, LSL #32
    MOVK  X20, #0x4be8, LSL #48
    MOVZ  X21, #0x609, LSL #0
    MOVK  X21, #0x3b36, LSL #16
    MOVK  X21, #0xd5a4, LSL #32
    MOVK  X21, #0x166, LSL #48
    MOVZ  X22, #0x21fa, LSL #0
    MOVK  X22, #0x8067, LSL #16
    MOVK  X22, #0x2965, LSL #32
    MOVK  X22, #0x198c, LSL #48
    MOVZ  X23, #0xebc2, LSL #0
    MOVK  X23, #0xbe37, LSL #16
    MOVK  X23, #0xd6bf, LSL #32
    MOVK  X23, #0xa2d1, LSL #48
    MOVZ  X24, #0x81f8, LSL #0
    MOVK  X24, #0x4dc6, LSL #16
    MOVK  X24, #0xdd04, LSL #32
    MOVK  X24, #0x34e9, LSL #48
    DUP     Z0.D, X22
    DUP     Z1.D, X15
    DUP     Z2.D, X24
    DUP     Z3.D, X22
    DUP     Z4.D, X14
    DUP     Z5.D, X8
    DUP     Z6.D, X21
    DUP     Z7.D, X23
    DUP     Z8.D, X23
    DUP     Z9.D, X5
    DUP     Z10.D, X12
    DUP     Z11.D, X21
    DUP     Z12.D, X14
    DUP     Z13.D, X15
    DUP     Z14.D, X22
    DUP     Z15.D, X3
    DUP     Z16.D, X20
    DUP     Z17.D, X3
    DUP     Z18.D, X19
    DUP     Z19.D, X19
    DUP     Z20.D, X4
    DUP     Z21.D, X20
    DUP     Z22.D, X7
    DUP     Z23.D, X6
    DUP     Z24.D, X3
    DUP     Z25.D, X12
    DUP     Z26.D, X6
    DUP     Z27.D, X18
    DUP     Z28.D, X12
    DUP     Z29.D, X22
    DUP     Z30.D, X15
    DUP     Z31.D, X22
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
    INDEX   Z4.D, X17, X23
    INDEX   Z8.D, X12, X20
    INDEX   Z29.D, X9, X22
    INDEX   Z20.D, X13, X7
    INDEX   Z22.D, X8, X18
    INDEX   Z29.D, X18, X8
    INDEX   Z25.D, X3, X2
    INDEX   Z13.D, X10, X15
    INDEX   Z22.D, X11, X17
    INDEX   Z12.D, X5, X11
    INDEX   Z29.B, W17, W22
    INDEX   Z17.B, W17, W12
    INDEX   Z1.B, W18, W8
    INDEX   Z4.B, W24, W20
    INDEX   Z3.B, W11, W21
    INDEX   Z14.B, W20, W2
    INDEX   Z18.B, W14, W10
    INDEX   Z22.B, W5, W2
    INDEX   Z11.B, W23, W24
    INDEX   Z17.B, W11, W18
    INDEX   Z19.D, #13, X18
    INDEX   Z25.D, #-12, X13
    INDEX   Z3.D, #-13, X2
    INDEX   Z13.D, #4, X8
    INDEX   Z11.D, #0, X24
    INDEX   Z26.D, #2, X20
    INDEX   Z6.D, #-16, X17
    INDEX   Z20.D, #15, X18
    INDEX   Z20.D, #4, X13
    INDEX   Z16.D, #-16, X14
    INDEX   Z27.B, #-9, W13
    INDEX   Z4.B, #1, W11
    INDEX   Z8.B, #-13, W5
    INDEX   Z14.B, #-13, W22
    INDEX   Z18.B, #2, W20
    INDEX   Z8.B, #-7, W17
    INDEX   Z5.B, #-10, W14
    INDEX   Z23.B, #9, W7
    INDEX   Z8.B, #12, W24
    INDEX   Z26.B, #5, W20
    INDEX   Z5.B, W2, #-15
    INDEX   Z1.B, W20, #-8
    INDEX   Z19.B, W20, #9
    INDEX   Z0.B, W6, #-10
    INDEX   Z4.B, W23, #-1
    INDEX   Z16.B, W14, #1
    INDEX   Z0.B, W17, #-8
    INDEX   Z30.B, W11, #-2
    INDEX   Z5.B, W15, #0
    INDEX   Z20.B, W12, #5
    INDEX   Z9.H, #4, W23
    INDEX   Z31.H, #-3, W3
    INDEX   Z11.H, #-4, W20
    INDEX   Z30.H, #-10, W15
    INDEX   Z19.H, #-15, W11
    INDEX   Z2.H, #0, W5
    INDEX   Z3.H, #5, W8
    INDEX   Z0.H, #-4, W20
    INDEX   Z12.H, #-11, W18
    INDEX   Z6.H, #0, W14
    INDEX   Z23.S, W6, W7
    INDEX   Z9.S, W17, W6
    INDEX   Z16.S, W5, W8
    INDEX   Z29.S, W20, W5
    INDEX   Z4.S, W3, W18
    INDEX   Z14.S, W11, W23
    INDEX   Z5.S, W13, W10
    INDEX   Z9.S, W10, W24
    INDEX   Z18.S, W14, W10
    INDEX   Z2.S, W13, W9
    REV     P1.H, P8.H
    REV     P11.H, P2.H
    REV     P3.H, P9.H
    REV     P0.H, P2.H
    REV     P3.H, P9.H
    REV     P12.H, P8.H
    REV     P11.H, P1.H
    REV     P15.H, P10.H
    REV     P3.H, P4.H
    REV     P5.H, P12.H
    REV     P1.B, P13.B
    REV     P5.B, P0.B
    REV     P15.B, P9.B
    REV     P2.B, P1.B
    REV     P5.B, P14.B
    REV     P6.B, P14.B
    REV     P11.B, P15.B
    REV     P4.B, P6.B
    REV     P3.B, P10.B
    REV     P14.B, P0.B
    REV     P7.D, P3.D
    REV     P2.D, P14.D
    REV     P11.D, P15.D
    REV     P7.D, P6.D
    REV     P5.D, P12.D
    REV     P0.D, P6.D
    REV     P12.D, P9.D
    REV     P4.D, P2.D
    REV     P10.D, P5.D
    REV     P8.D, P8.D
    REV     P9.S, P8.S
    REV     P6.S, P13.S
    REV     P14.S, P9.S
    REV     P12.S, P7.S
    REV     P9.S, P2.S
    REV     P3.S, P6.S
    REV     P15.S, P0.S
    REV     P14.S, P0.S
    REV     P12.S, P10.S
    REV     P13.S, P2.S
    TRN1    P11.B, P14.B, P6.B
    TRN1    P11.B, P9.B, P3.B
    TRN1    P1.B, P12.B, P2.B
    TRN1    P0.B, P2.B, P15.B
    TRN1    P3.B, P13.B, P1.B
    TRN1    P0.B, P0.B, P3.B
    TRN1    P0.B, P0.B, P8.B
    TRN1    P7.B, P3.B, P12.B
    TRN1    P7.B, P7.B, P7.B
    TRN1    P0.B, P7.B, P3.B
    TRN1    P4.H, P0.H, P12.H
    TRN1    P14.H, P4.H, P12.H
    TRN1    P9.H, P5.H, P15.H
    TRN1    P6.H, P3.H, P7.H
    TRN1    P5.H, P14.H, P5.H
    TRN1    P4.H, P7.H, P8.H
    TRN1    P8.H, P0.H, P13.H
    TRN1    P1.H, P9.H, P4.H
    TRN1    P4.H, P13.H, P12.H
    TRN1    P0.H, P5.H, P6.H
    TRN1    P9.D, P2.D, P13.D
    TRN1    P15.D, P9.D, P4.D
    TRN1    P1.D, P5.D, P2.D
    TRN1    P13.D, P10.D, P12.D
    TRN1    P3.D, P7.D, P14.D
    TRN1    P9.D, P1.D, P0.D
    TRN1    P1.D, P10.D, P13.D
    TRN1    P10.D, P2.D, P8.D
    TRN1    P7.D, P12.D, P15.D
    TRN1    P4.D, P0.D, P5.D
    TRN1    P2.S, P11.S, P13.S
    TRN1    P5.S, P7.S, P3.S
    TRN1    P13.S, P4.S, P13.S
    TRN1    P4.S, P11.S, P9.S
    TRN1    P0.S, P3.S, P8.S
    TRN1    P14.S, P0.S, P12.S
    TRN1    P11.S, P12.S, P15.S
    TRN1    P8.S, P14.S, P12.S
    TRN1    P15.S, P1.S, P10.S
    TRN1    P0.S, P2.S, P7.S
    TRN2    P2.B, P4.B, P2.B
    TRN2    P0.B, P3.B, P13.B
    TRN2    P8.B, P1.B, P11.B
    TRN2    P14.B, P13.B, P11.B
    TRN2    P4.B, P1.B, P11.B
    TRN2    P9.B, P1.B, P12.B
    TRN2    P5.B, P14.B, P2.B
    TRN2    P1.B, P0.B, P3.B
    TRN2    P7.B, P0.B, P6.B
    TRN2    P10.B, P11.B, P0.B
    TRN2    P12.D, P13.D, P14.D
    TRN2    P12.D, P5.D, P7.D
    TRN2    P5.D, P9.D, P6.D
    TRN2    P14.D, P9.D, P1.D
    TRN2    P6.D, P3.D, P12.D
    TRN2    P9.D, P8.D, P9.D
    TRN2    P3.D, P5.D, P9.D
    TRN2    P7.D, P10.D, P4.D
    TRN2    P1.D, P15.D, P3.D
    TRN2    P5.D, P10.D, P7.D
    TRN2    P3.H, P9.H, P10.H
    TRN2    P4.H, P5.H, P1.H
    TRN2    P13.H, P4.H, P0.H
    TRN2    P12.H, P3.H, P13.H
    TRN2    P1.H, P6.H, P12.H
    TRN2    P2.H, P4.H, P6.H
    TRN2    P6.H, P5.H, P3.H
    TRN2    P8.H, P12.H, P14.H
    TRN2    P0.H, P6.H, P5.H
    TRN2    P0.H, P11.H, P8.H
    TRN2    P14.S, P1.S, P9.S
    TRN2    P11.S, P7.S, P8.S
    TRN2    P10.S, P12.S, P8.S
    TRN2    P5.S, P14.S, P8.S
    TRN2    P10.S, P1.S, P1.S
    TRN2    P7.S, P3.S, P5.S
    TRN2    P11.S, P14.S, P13.S
    TRN2    P12.S, P8.S, P0.S
    TRN2    P14.S, P15.S, P12.S
    TRN2    P6.S, P14.S, P10.S
    UZP1    P10.B, P8.B, P11.B
    UZP1    P9.B, P8.B, P9.B
    UZP1    P4.B, P15.B, P0.B
    UZP1    P0.B, P2.B, P8.B
    UZP1    P10.B, P5.B, P7.B
    UZP1    P3.B, P13.B, P14.B
    UZP1    P2.B, P4.B, P10.B
    UZP1    P5.B, P11.B, P1.B
    UZP1    P13.B, P14.B, P12.B
    UZP1    P14.B, P14.B, P10.B
    UZP1    P11.S, P11.S, P2.S
    UZP1    P8.S, P11.S, P4.S
    UZP1    P10.S, P10.S, P7.S
    UZP1    P4.S, P5.S, P14.S
    UZP1    P11.S, P1.S, P6.S
    UZP1    P15.S, P10.S, P9.S
    UZP1    P7.S, P13.S, P13.S
    UZP1    P6.S, P7.S, P7.S
    UZP1    P13.S, P15.S, P11.S
    UZP1    P3.S, P3.S, P4.S
    UZP1    P9.D, P13.D, P13.D
    UZP1    P12.D, P8.D, P0.D
    UZP1    P2.D, P9.D, P6.D
    UZP1    P1.D, P12.D, P2.D
    UZP1    P5.D, P4.D, P8.D
    UZP1    P4.D, P9.D, P14.D
    UZP1    P15.D, P1.D, P6.D
    UZP1    P13.D, P4.D, P2.D
    UZP1    P1.D, P8.D, P9.D
    UZP1    P10.D, P7.D, P9.D
    UZP1    P8.H, P4.H, P6.H
    UZP1    P4.H, P13.H, P14.H
    UZP1    P0.H, P7.H, P3.H
    UZP1    P3.H, P0.H, P0.H
    UZP1    P10.H, P1.H, P0.H
    UZP1    P2.H, P9.H, P15.H
    UZP1    P11.H, P1.H, P10.H
    UZP1    P13.H, P14.H, P14.H
    UZP1    P6.H, P14.H, P10.H
    UZP1    P5.H, P2.H, P3.H
    UZP2    P14.B, P12.B, P6.B
    UZP2    P0.B, P8.B, P8.B
    UZP2    P9.B, P13.B, P9.B
    UZP2    P12.B, P4.B, P11.B
    UZP2    P11.B, P8.B, P13.B
    UZP2    P7.B, P12.B, P4.B
    UZP2    P4.B, P13.B, P6.B
    UZP2    P1.B, P10.B, P4.B
    UZP2    P11.B, P0.B, P13.B
    UZP2    P0.B, P8.B, P10.B
    UZP2    P0.D, P10.D, P9.D
    UZP2    P2.D, P9.D, P8.D
    UZP2    P8.D, P2.D, P12.D
    UZP2    P6.D, P9.D, P10.D
    UZP2    P15.D, P10.D, P0.D
    UZP2    P3.D, P5.D, P8.D
    UZP2    P8.D, P15.D, P7.D
    UZP2    P9.D, P10.D, P11.D
    UZP2    P0.D, P10.D, P1.D
    UZP2    P11.D, P14.D, P6.D
    UZP2    P12.S, P10.S, P3.S
    UZP2    P10.S, P13.S, P8.S
    UZP2    P6.S, P2.S, P11.S
    UZP2    P10.S, P5.S, P9.S
    UZP2    P1.S, P0.S, P15.S
    UZP2    P8.S, P6.S, P6.S
    UZP2    P9.S, P11.S, P12.S
    UZP2    P14.S, P6.S, P9.S
    UZP2    P4.S, P12.S, P10.S
    UZP2    P11.S, P9.S, P4.S
    UZP2    P9.H, P13.H, P9.H
    UZP2    P0.H, P6.H, P9.H
    UZP2    P9.H, P0.H, P7.H
    UZP2    P13.H, P3.H, P5.H
    UZP2    P12.H, P1.H, P15.H
    UZP2    P9.H, P9.H, P2.H
    UZP2    P7.H, P15.H, P7.H
    UZP2    P1.H, P14.H, P13.H
    UZP2    P1.H, P10.H, P12.H
    UZP2    P3.H, P5.H, P10.H
    ZIP1    P12.B, P9.B, P7.B
    ZIP1    P14.B, P0.B, P0.B
    ZIP1    P13.B, P6.B, P14.B
    ZIP1    P7.B, P14.B, P13.B
    ZIP1    P14.B, P10.B, P15.B
    ZIP1    P6.B, P3.B, P9.B
    ZIP1    P2.B, P5.B, P10.B
    ZIP1    P10.B, P2.B, P12.B
    ZIP1    P2.B, P6.B, P10.B
    ZIP1    P7.B, P0.B, P8.B
    ZIP1    P12.H, P0.H, P3.H
    ZIP1    P13.H, P2.H, P2.H
    ZIP1    P5.H, P14.H, P15.H
    ZIP1    P3.H, P13.H, P0.H
    ZIP1    P10.H, P3.H, P10.H
    ZIP1    P2.H, P2.H, P0.H
    ZIP1    P0.H, P9.H, P12.H
    ZIP1    P15.H, P7.H, P1.H
    ZIP1    P4.H, P1.H, P11.H
    ZIP1    P2.H, P0.H, P3.H
    ZIP1    P7.S, P7.S, P1.S
    ZIP1    P8.S, P2.S, P5.S
    ZIP1    P11.S, P7.S, P14.S
    ZIP1    P5.S, P14.S, P8.S
    ZIP1    P8.S, P9.S, P5.S
    ZIP1    P6.S, P4.S, P5.S
    ZIP1    P1.S, P3.S, P0.S
    ZIP1    P6.S, P3.S, P15.S
    ZIP1    P15.S, P3.S, P11.S
    ZIP1    P0.S, P13.S, P7.S
    MOVZ  X4, #0x93a4, LSL #0
    MOVK  X4, #0xac69, LSL #16
    MOVK  X4, #0xe838, LSL #32
    MOVK  X4, #0x2d6a, LSL #48
    SUB  X19, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xd17, LSL #0
    MOVK  X4, #0x69e0, LSL #16
    MOVK  X4, #0x7f5b, LSL #32
    MOVK  X4, #0x5c88, LSL #48
    SUB  X19, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x59d4, LSL #0
    MOVK  X4, #0x8b8b, LSL #16
    MOVK  X4, #0x6739, LSL #32
    MOVK  X4, #0xf69d, LSL #48
    SUB  X19, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x681d, LSL #0
    MOVK  X4, #0xfd5d, LSL #16
    MOVK  X4, #0x5f54, LSL #32
    MOVK  X4, #0x8de3, LSL #48
    SUB  X19, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xdc72, LSL #0
    MOVK  X4, #0x8a48, LSL #16
    MOVK  X4, #0x30c0, LSL #32
    MOVK  X4, #0xdda4, LSL #48
    SUB  X19, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xf3fc, LSL #0
    MOVK  X4, #0x956d, LSL #16
    MOVK  X4, #0x5145, LSL #32
    MOVK  X4, #0xe100, LSL #48
    SUB  X19, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x58b9, LSL #0
    MOVK  X4, #0xc5fd, LSL #16
    MOVK  X4, #0x4a04, LSL #32
    MOVK  X4, #0xd5c0, LSL #48
    SUB  X19, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x3f80, LSL #0
    MOVK  X4, #0x72ef, LSL #16
    MOVK  X4, #0xf202, LSL #32
    MOVK  X4, #0xa808, LSL #48
    SUB  X19, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x3803, LSL #0
    MOVK  X4, #0x1dce, LSL #16
    MOVK  X4, #0x4986, LSL #32
    MOVK  X4, #0x87ab, LSL #48
    SUB  X19, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xbcd, LSL #0
    MOVK  X4, #0x6d8, LSL #16
    MOVK  X4, #0x29b8, LSL #32
    MOVK  X4, #0x5897, LSL #48
    SUB  X19, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xbb7f, LSL #0
    MOVK  X4, #0x2fb, LSL #16
    MOVK  X4, #0x5155, LSL #32
    MOVK  X4, #0xaef8, LSL #48
    SUB  X19, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xc40b, LSL #0
    MOVK  X4, #0xe388, LSL #16
    MOVK  X4, #0x8b90, LSL #32
    MOVK  X4, #0x375, LSL #48
    SUB  X19, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xc447, LSL #0
    MOVK  X4, #0x2d50, LSL #16
    MOVK  X4, #0x9c23, LSL #32
    MOVK  X4, #0x23ef, LSL #48
    SUB  X19, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xe4cf, LSL #0
    MOVK  X4, #0xad4e, LSL #16
    MOVK  X4, #0x7232, LSL #32
    MOVK  X4, #0x977e, LSL #48
    SUB  X19, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xe38a, LSL #0
    MOVK  X4, #0xbeed, LSL #16
    MOVK  X4, #0x340b, LSL #32
    MOVK  X4, #0x2cca, LSL #48
    SUB  X19, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x416b, LSL #0
    MOVK  X4, #0x85d0, LSL #16
    MOVK  X4, #0xb0f6, LSL #32
    MOVK  X4, #0x4be8, LSL #48
    SUB  X19, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x609, LSL #0
    MOVK  X4, #0x3b36, LSL #16
    MOVK  X4, #0xd5a4, LSL #32
    MOVK  X4, #0x166, LSL #48
    SUB  X19, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x21fa, LSL #0
    MOVK  X4, #0x8067, LSL #16
    MOVK  X4, #0x2965, LSL #32
    MOVK  X4, #0x198c, LSL #48
    SUB  X19, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xebc2, LSL #0
    MOVK  X4, #0xbe37, LSL #16
    MOVK  X4, #0xd6bf, LSL #32
    MOVK  X4, #0xa2d1, LSL #48
    SUB  X19, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x81f8, LSL #0
    MOVK  X4, #0x4dc6, LSL #16
    MOVK  X4, #0xdd04, LSL #32
    MOVK  X4, #0x34e9, LSL #48
    SUB  X19, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MRS  X4, FPSR
    MOVZ  X19, #0x90, LSL #0
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X19, #0x5a8, LSL #0
    MOVK  X19, #0x4713, LSL #16
    MOVK  X19, #0x887e, LSL #32
    MOVK  X19, #0xc9e9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D0
    MOVZ  X19, #0xfffc, LSL #0
    MOVK  X19, #0x4167, LSL #16
    MOVK  X19, #0x82d2, LSL #32
    MOVK  X19, #0xc43d, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X19, #0x232b, LSL #0
    MOVK  X19, #0x131b, LSL #16
    MOVK  X19, #0x30b, LSL #32
    MOVK  X19, #0xf3fb, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D1
    MOVZ  X19, #0x636b, LSL #0
    MOVK  X19, #0x535b, LSL #16
    MOVK  X19, #0x434b, LSL #32
    MOVK  X19, #0x333b, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X19, #0x6cf1, LSL #0
    MOVK  X19, #0x8ef6, LSL #16
    MOVK  X19, #0xc5aa, LSL #32
    MOVK  X19, #0x54f3, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D2
    MOVZ  X19, #0xbb7f, LSL #0
    MOVK  X19, #0x2fb, LSL #16
    MOVK  X19, #0x1438, LSL #32
    MOVK  X19, #0xc8f9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X19, #0xcff5, LSL #0
    MOVK  X19, #0xc3f1, LSL #16
    MOVK  X19, #0xb7ed, LSL #32
    MOVK  X19, #0xabe9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D3
    MOVZ  X19, #0x5, LSL #0
    MOVK  X19, #0xf401, LSL #16
    MOVK  X19, #0xe7fd, LSL #32
    MOVK  X19, #0xdbf9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X19, #0xd42b, LSL #0
    MOVK  X19, #0xe7bb, LSL #16
    MOVK  X19, #0xb7b5, LSL #32
    MOVK  X19, #0xa6a9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D4
    MOVZ  X19, #0xd17, LSL #0
    MOVK  X19, #0x69e0, LSL #16
    MOVK  X19, #0xf0a1, LSL #32
    MOVK  X19, #0x28cd, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X19, #0x3a7f, LSL #0
    MOVK  X19, #0xe8da, LSL #16
    MOVK  X19, #0x79ff, LSL #32
    MOVK  X19, #0x5bc9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D5
    MOVZ  X19, #0xbb7f, LSL #0
    MOVK  X19, #0x2fb, LSL #16
    MOVK  X19, #0xfaff, LSL #32
    MOVK  X19, #0x75ea, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X19, #0x102c, LSL #0
    MOVK  X19, #0xd437, LSL #16
    MOVK  X19, #0x9842, LSL #32
    MOVK  X19, #0x5c4d, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D6
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xc40b, LSL #16
    MOVK  X19, #0x8816, LSL #32
    MOVK  X19, #0x4c21, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X19, #0xebc2, LSL #0
    MOVK  X19, #0xbe37, LSL #16
    MOVK  X19, #0xd6bf, LSL #32
    MOVK  X19, #0xa2d1, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D7
    MOVZ  X19, #0xebc2, LSL #0
    MOVK  X19, #0xbe37, LSL #16
    MOVK  X19, #0xd6bf, LSL #32
    MOVK  X19, #0xa2d1, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X19, #0xc4cc, LSL #0
    MOVK  X19, #0xb4bc, LSL #16
    MOVK  X19, #0xa4ac, LSL #32
    MOVK  X19, #0x949c, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D8
    MOVZ  X19, #0x40c, LSL #0
    MOVK  X19, #0xf4fc, LSL #16
    MOVK  X19, #0xe4ec, LSL #32
    MOVK  X19, #0xd4dc, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X19, #0x4370, LSL #0
    MOVK  X19, #0xe7c, LSL #16
    MOVK  X19, #0xc568, LSL #32
    MOVK  X19, #0x5c42, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D9
    MOVZ  X19, #0x3f80, LSL #0
    MOVK  X19, #0x72ef, LSL #16
    MOVK  X19, #0xc178, LSL #32
    MOVK  X19, #0xc0b5, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X19, #0xbcd, LSL #0
    MOVK  X19, #0x6d8, LSL #16
    MOVK  X19, #0x29b8, LSL #32
    MOVK  X19, #0x5897, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D10
    MOVZ  X19, #0xbcd, LSL #0
    MOVK  X19, #0x6d8, LSL #16
    MOVK  X19, #0x29b8, LSL #32
    MOVK  X19, #0x5897, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X19, #0x5a8, LSL #0
    MOVK  X19, #0x4713, LSL #16
    MOVK  X19, #0x887e, LSL #32
    MOVK  X19, #0xc9e9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D11
    MOVZ  X19, #0xfffc, LSL #0
    MOVK  X19, #0x4167, LSL #16
    MOVK  X19, #0x82d2, LSL #32
    MOVK  X19, #0xc43d, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X19, #0x8e1d, LSL #0
    MOVK  X19, #0x71a7, LSL #16
    MOVK  X19, #0x5531, LSL #32
    MOVK  X19, #0x38bb, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D12
    MOVZ  X19, #0xfff5, LSL #0
    MOVK  X19, #0xe37f, LSL #16
    MOVK  X19, #0xc709, LSL #32
    MOVK  X19, #0xaa93, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X19, #0xf400, LSL #0
    MOVK  X19, #0x956d, LSL #16
    MOVK  X19, #0x5145, LSL #32
    MOVK  X19, #0xe100, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D13
    MOVZ  X19, #0x4, LSL #0
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X19, #0xf87, LSL #0
    MOVK  X19, #0x9a3e, LSL #16
    MOVK  X19, #0xfb49, LSL #32
    MOVK  X19, #0x5875, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D14
    MOVZ  X19, #0x3803, LSL #0
    MOVK  X19, #0x1dce, LSL #16
    MOVK  X19, #0x23c5, LSL #32
    MOVK  X19, #0xdc06, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X19, #0xd17, LSL #0
    MOVK  X19, #0x69e0, LSL #16
    MOVK  X19, #0x7f5b, LSL #32
    MOVK  X19, #0x5c88, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D15
    MOVZ  X19, #0xd17, LSL #0
    MOVK  X19, #0x69e0, LSL #16
    MOVK  X19, #0x7f5b, LSL #32
    MOVK  X19, #0x5c88, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X19, #0x41cc, LSL #0
    MOVK  X19, #0xb667, LSL #16
    MOVK  X19, #0x35c8, LSL #32
    MOVK  X19, #0x4bd5, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D16
    MOVZ  X19, #0x59d4, LSL #0
    MOVK  X19, #0x8b8b, LSL #16
    MOVK  X19, #0x4dd0, LSL #32
    MOVK  X19, #0x20f9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X19, #0xdd53, LSL #0
    MOVK  X19, #0xf167, LSL #16
    MOVK  X19, #0x57b, LSL #32
    MOVK  X19, #0x198f, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D17
    MOVZ  X19, #0x8d03, LSL #0
    MOVK  X19, #0xa117, LSL #16
    MOVK  X19, #0xb52b, LSL #32
    MOVK  X19, #0xc93f, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X19, #0x430b, LSL #0
    MOVK  X19, #0xc967, LSL #16
    MOVK  X19, #0x828b, LSL #32
    MOVK  X19, #0x3c56, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D18
    MOVZ  X19, #0xc40b, LSL #0
    MOVK  X19, #0xe388, LSL #16
    MOVK  X19, #0x38b, LSL #32
    MOVK  X19, #0x5678, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X19, #0xdffd, LSL #0
    MOVK  X19, #0x1800, LSL #16
    MOVK  X19, #0x5003, LSL #32
    MOVK  X19, #0x8806, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D19
    MOVZ  X19, #0xfff1, LSL #0
    MOVK  X19, #0x37f4, LSL #16
    MOVK  X19, #0x6ff7, LSL #32
    MOVK  X19, #0xa7fa, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X19, #0xfaf5, LSL #0
    MOVK  X19, #0x4ff, LSL #16
    MOVK  X19, #0xe09, LSL #32
    MOVK  X19, #0x1813, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D20
    MOVZ  X19, #0xd2cd, LSL #0
    MOVK  X19, #0xdcd7, LSL #16
    MOVK  X19, #0xe6e1, LSL #32
    MOVK  X19, #0xf0eb, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X19, #0x416b, LSL #0
    MOVK  X19, #0x85d0, LSL #16
    MOVK  X19, #0xb0f6, LSL #32
    MOVK  X19, #0x4be8, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D21
    MOVZ  X19, #0x416b, LSL #0
    MOVK  X19, #0x85d0, LSL #16
    MOVK  X19, #0xb0f6, LSL #32
    MOVK  X19, #0x4be8, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X19, #0x98f4, LSL #0
    MOVK  X19, #0xe03c, LSL #16
    MOVK  X19, #0x2884, LSL #32
    MOVK  X19, #0x70cc, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D22
    MOVZ  X19, #0x78d4, LSL #0
    MOVK  X19, #0xc01c, LSL #16
    MOVK  X19, #0x864, LSL #32
    MOVK  X19, #0x50ac, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X19, #0x2101, LSL #0
    MOVK  X19, #0x11ef, LSL #16
    MOVK  X19, #0xfd73, LSL #32
    MOVK  X19, #0x9c37, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D23
    MOVZ  X19, #0x681d, LSL #0
    MOVK  X19, #0xfd5d, LSL #16
    MOVK  X19, #0x448f, LSL #32
    MOVK  X19, #0x87a6, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X19, #0xd17, LSL #0
    MOVK  X19, #0x69e0, LSL #16
    MOVK  X19, #0x7f5b, LSL #32
    MOVK  X19, #0x5c88, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D24
    MOVZ  X19, #0xd17, LSL #0
    MOVK  X19, #0x69e0, LSL #16
    MOVK  X19, #0x7f5b, LSL #32
    MOVK  X19, #0x5c88, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X19, #0xbb73, LSL #0
    MOVK  X19, #0x2fb, LSL #16
    MOVK  X19, #0x5155, LSL #32
    MOVK  X19, #0xaef8, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D25
    MOVZ  X19, #0xfff4, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X19, #0xc85d, LSL #0
    MOVK  X19, #0x9e33, LSL #16
    MOVK  X19, #0x7409, LSL #32
    MOVK  X19, #0x4adf, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D26
    MOVZ  X19, #0x7005, LSL #0
    MOVK  X19, #0x46db, LSL #16
    MOVK  X19, #0x1cb1, LSL #32
    MOVK  X19, #0xf287, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X19, #0x6eef, LSL #0
    MOVK  X19, #0x6ced, LSL #16
    MOVK  X19, #0x6aeb, LSL #32
    MOVK  X19, #0x68e9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D27
    MOVZ  X19, #0x76f7, LSL #0
    MOVK  X19, #0x74f5, LSL #16
    MOVK  X19, #0x72f3, LSL #32
    MOVK  X19, #0x70f1, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X19, #0xbcd, LSL #0
    MOVK  X19, #0x6d8, LSL #16
    MOVK  X19, #0x29b8, LSL #32
    MOVK  X19, #0x5897, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D28
    MOVZ  X19, #0xbcd, LSL #0
    MOVK  X19, #0x6d8, LSL #16
    MOVK  X19, #0x29b8, LSL #32
    MOVK  X19, #0x5897, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X19, #0xf513, LSL #0
    MOVK  X19, #0x9ce6, LSL #16
    MOVK  X19, #0x4ee7, LSL #32
    MOVK  X19, #0x2872, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D29
    MOVZ  X19, #0x416b, LSL #0
    MOVK  X19, #0x85d0, LSL #16
    MOVK  X19, #0x9b3f, LSL #32
    MOVK  X19, #0x115b, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X19, #0x1112, LSL #0
    MOVK  X19, #0xd559, LSL #16
    MOVK  X19, #0x99a0, LSL #32
    MOVK  X19, #0x5de7, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D30
    MOVZ  X19, #0xfff6, LSL #0
    MOVK  X19, #0xc43d, LSL #16
    MOVK  X19, #0x8884, LSL #32
    MOVK  X19, #0x4ccb, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X19, #0x3459, LSL #0
    MOVK  X19, #0x4170, LSL #16
    MOVK  X19, #0x4e87, LSL #32
    MOVK  X19, #0x5b9e, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X4, D31
    MOVZ  X19, #0xfffd, LSL #0
    MOVK  X19, #0xd14, LSL #16
    MOVK  X19, #0x1a2b, LSL #32
    MOVK  X19, #0x2742, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
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
    FMOV  X4, D0
    MOVZ  X19, #0x1100, LSL #0
    MOVK  X19, #0x526b, LSL #16
    MOVK  X19, #0x93d6, LSL #32
    MOVK  X19, #0xd541, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X4, D1
    MOVZ  X19, #0x8786, LSL #0
    MOVK  X19, #0x8787, LSL #16
    MOVK  X19, #0xe787, LSL #32
    MOVK  X19, #0xf3fa, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X4, D2
    MOVZ  X19, #0xcfd4, LSL #0
    MOVK  X19, #0xa6eb, LSL #16
    MOVK  X19, #0x288e, LSL #32
    MOVK  X19, #0x6ce9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D3, P0, Z3.D
    FMOV  X4, D3
    MOVZ  X19, #0x9fe4, LSL #0
    MOVK  X19, #0x93e1, LSL #16
    MOVK  X19, #0x87dd, LSL #32
    MOVK  X19, #0x7bd9, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D4, P1, Z4.D
    FMOV  X4, D4
    MOVZ  X19, #0x9f29, LSL #0
    MOVK  X19, #0x69d9, LSL #16
    MOVK  X19, #0xf0a1, LSL #32
    MOVK  X19, #0x28cd, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X4, D5
    MOVZ  X19, #0xbb7f, LSL #0
    MOVK  X19, #0x2fb, LSL #16
    MOVK  X19, #0xfaff, LSL #32
    MOVK  X19, #0x75ea, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X4, D6
    MOVZ  X19, #0x3084, LSL #0
    MOVK  X19, #0xf48f, LSL #16
    MOVK  X19, #0xb89a, LSL #32
    MOVK  X19, #0x7ca5, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X4, D7
    MOVZ  X19, #0xebc2, LSL #0
    MOVK  X19, #0xbe37, LSL #16
    MOVK  X19, #0xd6bf, LSL #32
    MOVK  X19, #0xa2f1, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X4, D8
    MOVZ  X19, #0x8787, LSL #0
    MOVK  X19, #0x8887, LSL #16
    MOVK  X19, #0xc888, LSL #32
    MOVK  X19, #0xd4dc, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X4, D9
    MOVZ  X19, #0x475f, LSL #0
    MOVK  X19, #0xaa09, LSL #16
    MOVK  X19, #0xc958, LSL #32
    MOVK  X19, #0xf7cf, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D10, P4, Z10.D
    FMOV  X4, D10
    MOVZ  X19, #0xbcd, LSL #0
    MOVK  X19, #0x6d8, LSL #16
    MOVK  X19, #0x29b8, LSL #32
    MOVK  X19, #0x58b7, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X4, D11
    MOVZ  X19, #0x1100, LSL #0
    MOVK  X19, #0x526b, LSL #16
    MOVK  X19, #0x93d6, LSL #32
    MOVK  X19, #0xd541, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X4, D12
    MOVZ  X19, #0xaa6c, LSL #0
    MOVK  X19, #0x8df7, LSL #16
    MOVK  X19, #0x7181, LSL #32
    MOVK  X19, #0x550b, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X4, D13
    MOVZ  X19, #0xf400, LSL #0
    MOVK  X19, #0x956d, LSL #16
    MOVK  X19, #0x5145, LSL #32
    MOVK  X19, #0xe100, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X4, D14
    MOVZ  X19, #0x3802, LSL #0
    MOVK  X19, #0x1dce, LSL #16
    MOVK  X19, #0x23c5, LSL #32
    MOVK  X19, #0xdc06, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D15, P2, Z15.D
    FMOV  X4, D15
    MOVZ  X19, #0xd17, LSL #0
    MOVK  X19, #0x69e0, LSL #16
    MOVK  X19, #0x7f5b, LSL #32
    MOVK  X19, #0x5ca8, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X4, D16
    MOVZ  X19, #0x29c3, LSL #0
    MOVK  X19, #0xe143, LSL #16
    MOVK  X19, #0x1dc0, LSL #32
    MOVK  X19, #0x76b1, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X4, D17
    MOVZ  X19, #0x2da1, LSL #0
    MOVK  X19, #0x41b7, LSL #16
    MOVK  X19, #0x55cb, LSL #32
    MOVK  X19, #0x69df, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X4, D18
    MOVZ  X19, #0xc40b, LSL #0
    MOVK  X19, #0xe388, LSL #16
    MOVK  X19, #0x38b, LSL #32
    MOVK  X19, #0x5678, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D19, P0, Z19.D
    FMOV  X4, D19
    MOVZ  X19, #0xc008, LSL #0
    MOVK  X19, #0xf80c, LSL #16
    MOVK  X19, #0x300f, LSL #32
    MOVK  X19, #0x6812, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X4, D20
    MOVZ  X19, #0xd2cb, LSL #0
    MOVK  X19, #0xdcd7, LSL #16
    MOVK  X19, #0xe6e1, LSL #32
    MOVK  X19, #0xf0eb, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X4, D21
    MOVZ  X19, #0x416b, LSL #0
    MOVK  X19, #0x85d0, LSL #16
    MOVK  X19, #0xb0f6, LSL #32
    MOVK  X19, #0x4c08, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X4, D22
    MOVZ  X19, #0x98f3, LSL #0
    MOVK  X19, #0xe03c, LSL #16
    MOVK  X19, #0x2884, LSL #32
    MOVK  X19, #0x70cc, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X4, D23
    MOVZ  X19, #0x92c9, LSL #0
    MOVK  X19, #0x3b12, LSL #16
    MOVK  X19, #0x6f3b, LSL #32
    MOVK  X19, #0xc55b, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D24, P0, Z24.D
    FMOV  X4, D24
    MOVZ  X19, #0xd17, LSL #0
    MOVK  X19, #0x69e0, LSL #16
    MOVK  X19, #0x7f5b, LSL #32
    MOVK  X19, #0x5ca8, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X4, D25
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X4, D26
    MOVZ  X19, #0x780d, LSL #0
    MOVK  X19, #0x4ee3, LSL #16
    MOVK  X19, #0x24b9, LSL #32
    MOVK  X19, #0xfa8f, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D27, P5, Z27.D
    FMOV  X4, D27
    MOVZ  X19, #0x76f7, LSL #0
    MOVK  X19, #0x74f5, LSL #16
    MOVK  X19, #0x72f3, LSL #32
    MOVK  X19, #0x70f1, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X4, D28
    MOVZ  X19, #0xbcd, LSL #0
    MOVK  X19, #0x6d8, LSL #16
    MOVK  X19, #0x29b8, LSL #32
    MOVK  X19, #0x58b7, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X4, D29
    MOVZ  X19, #0x5c63, LSL #0
    MOVK  X19, #0xcb14, LSL #16
    MOVK  X19, #0xb637, LSL #32
    MOVK  X19, #0x569f, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X4, D30
    MOVZ  X19, #0x222d, LSL #0
    MOVK  X19, #0xe675, LSL #16
    MOVK  X19, #0xaabc, LSL #32
    MOVK  X19, #0x6f03, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X4, D31
    MOVZ  X19, #0x3458, LSL #0
    MOVK  X19, #0x4170, LSL #16
    MOVK  X19, #0x4e87, LSL #32
    MOVK  X19, #0x5b9e, LSL #48
    SUB  X16, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0x94fd, LSL #0
    MOVK  X2, #0x9acb, LSL #16
    MOVK  X2, #0x108a, LSL #32
    MOVK  X2, #0x4287, LSL #48
    MOVZ  X3, #0x9308, LSL #0
    MOVK  X3, #0xd967, LSL #16
    MOVK  X3, #0xd06a, LSL #32
    MOVK  X3, #0xc076, LSL #48
    MOVZ  X4, #0x49d5, LSL #0
    MOVK  X4, #0x3c9e, LSL #16
    MOVK  X4, #0x6272, LSL #32
    MOVK  X4, #0xb566, LSL #48
    MOVZ  X5, #0x3a7e, LSL #0
    MOVK  X5, #0x50e7, LSL #16
    MOVK  X5, #0x695, LSL #32
    MOVK  X5, #0xe974, LSL #48
    MOVZ  X6, #0x2be9, LSL #0
    MOVK  X6, #0x4d39, LSL #16
    MOVK  X6, #0xc63c, LSL #32
    MOVK  X6, #0xf21, LSL #48
    MOVZ  X7, #0x1863, LSL #0
    MOVK  X7, #0x4d09, LSL #16
    MOVK  X7, #0x20ca, LSL #32
    MOVK  X7, #0xd5c7, LSL #48
    MOVZ  X8, #0x8f98, LSL #0
    MOVK  X8, #0x26d2, LSL #16
    MOVK  X8, #0x9f47, LSL #32
    MOVK  X8, #0x2320, LSL #48
    MOVZ  X9, #0x3cc, LSL #0
    MOVK  X9, #0x3d9, LSL #16
    MOVK  X9, #0x7184, LSL #32
    MOVK  X9, #0xbb1d, LSL #48
    MOVZ  X10, #0x48ec, LSL #0
    MOVK  X10, #0x1332, LSL #16
    MOVK  X10, #0x3b73, LSL #32
    MOVK  X10, #0x7345, LSL #48
    MOVZ  X11, #0xc1c7, LSL #0
    MOVK  X11, #0x937e, LSL #16
    MOVK  X11, #0x448, LSL #32
    MOVK  X11, #0x85bb, LSL #48
    MOVZ  X12, #0x4ca, LSL #0
    MOVK  X12, #0xddcd, LSL #16
    MOVK  X12, #0x16bc, LSL #32
    MOVK  X12, #0xc2fc, LSL #48
    MOVZ  X13, #0x714a, LSL #0
    MOVK  X13, #0x101d, LSL #16
    MOVK  X13, #0xad20, LSL #32
    MOVK  X13, #0x87eb, LSL #48
    MOVZ  X14, #0xd927, LSL #0
    MOVK  X14, #0xfc46, LSL #16
    MOVK  X14, #0x2a4, LSL #32
    MOVK  X14, #0x5dde, LSL #48
    MOVZ  X15, #0x2e1, LSL #0
    MOVK  X15, #0xdfce, LSL #16
    MOVK  X15, #0xf069, LSL #32
    MOVK  X15, #0x11c3, LSL #48
    MOVZ  X16, #0xdbad, LSL #0
    MOVK  X16, #0x8813, LSL #16
    MOVK  X16, #0x6fbe, LSL #32
    MOVK  X16, #0x915f, LSL #48
    MOVZ  X17, #0x3c7d, LSL #0
    MOVK  X17, #0x7b17, LSL #16
    MOVK  X17, #0x97bb, LSL #32
    MOVK  X17, #0xe9ae, LSL #48
    MOVZ  X18, #0x512c, LSL #0
    MOVK  X18, #0x5bf9, LSL #16
    MOVK  X18, #0xf195, LSL #32
    MOVK  X18, #0x1af7, LSL #48
    MOVZ  X19, #0x355a, LSL #0
    MOVK  X19, #0x59cb, LSL #16
    MOVK  X19, #0x1dd1, LSL #32
    MOVK  X19, #0xf664, LSL #48
    MOVZ  X20, #0x9174, LSL #0
    MOVK  X20, #0xd571, LSL #16
    MOVK  X20, #0xcb1, LSL #32
    MOVK  X20, #0x2b2c, LSL #48
    MOVZ  X21, #0xa328, LSL #0
    MOVK  X21, #0x861f, LSL #16
    MOVK  X21, #0x32e, LSL #32
    MOVK  X21, #0x87cb, LSL #48
    MOVZ  X22, #0xcc3d, LSL #0
    MOVK  X22, #0x7039, LSL #16
    MOVK  X22, #0x5ae8, LSL #32
    MOVK  X22, #0x4ac3, LSL #48
    MOVZ  X23, #0x1f84, LSL #0
    MOVK  X23, #0x651e, LSL #16
    MOVK  X23, #0x403e, LSL #32
    MOVK  X23, #0x956f, LSL #48
    MOVZ  X24, #0xda83, LSL #0
    MOVK  X24, #0xa096, LSL #16
    MOVK  X24, #0x7a83, LSL #32
    MOVK  X24, #0xbbdb, LSL #48
    DUP     Z0.D, X20
    DUP     Z1.D, X23
    DUP     Z2.D, X17
    DUP     Z3.D, X3
    DUP     Z4.D, X24
    DUP     Z5.D, X21
    DUP     Z6.D, X22
    DUP     Z7.D, X24
    DUP     Z8.D, X5
    DUP     Z9.D, X4
    DUP     Z10.D, X24
    DUP     Z11.D, X21
    DUP     Z12.D, X5
    DUP     Z13.D, X24
    DUP     Z14.D, X3
    DUP     Z15.D, X10
    DUP     Z16.D, X13
    DUP     Z17.D, X3
    DUP     Z18.D, X20
    DUP     Z19.D, X15
    DUP     Z20.D, X4
    DUP     Z21.D, X13
    DUP     Z22.D, X22
    DUP     Z23.D, X19
    DUP     Z24.D, X18
    DUP     Z25.D, X19
    DUP     Z26.D, X14
    DUP     Z27.D, X7
    DUP     Z28.D, X17
    DUP     Z29.D, X15
    DUP     Z30.D, X16
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
    ZIP1    P9.D, P12.D, P10.D
    ZIP1    P14.D, P1.D, P0.D
    ZIP1    P2.D, P8.D, P14.D
    ZIP1    P11.D, P5.D, P14.D
    ZIP1    P3.D, P7.D, P9.D
    ZIP1    P8.D, P5.D, P2.D
    ZIP1    P7.D, P4.D, P2.D
    ZIP1    P9.D, P13.D, P6.D
    ZIP1    P8.D, P9.D, P14.D
    ZIP1    P9.D, P15.D, P3.D
    ZIP2    P4.H, P7.H, P11.H
    ZIP2    P15.H, P9.H, P8.H
    ZIP2    P14.H, P4.H, P9.H
    ZIP2    P5.H, P3.H, P6.H
    ZIP2    P14.H, P9.H, P13.H
    ZIP2    P5.H, P2.H, P0.H
    ZIP2    P8.H, P8.H, P15.H
    ZIP2    P1.H, P15.H, P9.H
    ZIP2    P11.H, P12.H, P12.H
    ZIP2    P4.H, P13.H, P12.H
    ZIP2    P6.S, P1.S, P13.S
    ZIP2    P7.S, P3.S, P1.S
    ZIP2    P2.S, P1.S, P3.S
    ZIP2    P1.S, P12.S, P4.S
    ZIP2    P0.S, P2.S, P0.S
    ZIP2    P13.S, P5.S, P3.S
    ZIP2    P2.S, P12.S, P15.S
    ZIP2    P12.S, P10.S, P14.S
    ZIP2    P4.S, P4.S, P1.S
    ZIP2    P2.S, P8.S, P4.S
    ZIP2    P12.D, P2.D, P7.D
    ZIP2    P3.D, P6.D, P0.D
    ZIP2    P2.D, P13.D, P11.D
    ZIP2    P1.D, P13.D, P12.D
    ZIP2    P14.D, P1.D, P12.D
    ZIP2    P1.D, P9.D, P2.D
    ZIP2    P15.D, P3.D, P1.D
    ZIP2    P8.D, P1.D, P7.D
    ZIP2    P6.D, P12.D, P8.D
    ZIP2    P5.D, P12.D, P3.D
    ZIP2    P11.B, P12.B, P13.B
    ZIP2    P12.B, P14.B, P14.B
    ZIP2    P14.B, P4.B, P1.B
    ZIP2    P8.B, P6.B, P15.B
    ZIP2    P8.B, P9.B, P10.B
    ZIP2    P2.B, P3.B, P15.B
    ZIP2    P15.B, P4.B, P4.B
    ZIP2    P5.B, P6.B, P0.B
    ZIP2    P0.B, P15.B, P8.B
    ZIP2    P10.B, P13.B, P6.B
    SUNPKHI Z18.D, Z30.S
    SUNPKHI Z26.D, Z10.S
    SUNPKHI Z23.D, Z13.S
    SUNPKHI Z28.D, Z18.S
    SUNPKHI Z11.D, Z0.S
    SUNPKHI Z16.D, Z30.S
    SUNPKHI Z3.D, Z6.S
    SUNPKHI Z13.D, Z4.S
    SUNPKHI Z4.D, Z16.S
    SUNPKHI Z20.D, Z18.S
    SUNPKHI Z25.S, Z10.H
    SUNPKHI Z17.S, Z28.H
    SUNPKHI Z27.S, Z26.H
    SUNPKHI Z23.S, Z21.H
    SUNPKHI Z6.S, Z30.H
    SUNPKHI Z16.S, Z15.H
    SUNPKHI Z26.S, Z11.H
    SUNPKHI Z28.S, Z3.H
    SUNPKHI Z28.S, Z20.H
    SUNPKHI Z3.S, Z25.H
    SUNPKHI Z15.H, Z16.B
    SUNPKHI Z25.H, Z25.B
    SUNPKHI Z12.H, Z27.B
    SUNPKHI Z5.H, Z28.B
    SUNPKHI Z27.H, Z17.B
    SUNPKHI Z13.H, Z23.B
    SUNPKHI Z16.H, Z12.B
    SUNPKHI Z12.H, Z27.B
    SUNPKHI Z30.H, Z15.B
    SUNPKHI Z31.H, Z30.B
    SUNPKLO Z2.H, Z3.B
    SUNPKLO Z22.H, Z9.B
    SUNPKLO Z7.H, Z22.B
    SUNPKLO Z15.H, Z16.B
    SUNPKLO Z3.H, Z4.B
    SUNPKLO Z26.H, Z13.B
    SUNPKLO Z11.H, Z7.B
    SUNPKLO Z4.H, Z8.B
    SUNPKLO Z10.H, Z15.B
    SUNPKLO Z9.H, Z12.B
    SUNPKLO Z30.S, Z11.H
    SUNPKLO Z15.S, Z16.H
    SUNPKLO Z7.S, Z10.H
    SUNPKLO Z12.S, Z27.H
    SUNPKLO Z10.S, Z5.H
    SUNPKLO Z16.S, Z31.H
    SUNPKLO Z27.S, Z25.H
    SUNPKLO Z31.S, Z26.H
    SUNPKLO Z11.S, Z30.H
    SUNPKLO Z31.S, Z25.H
    SUNPKLO Z13.D, Z7.S
    SUNPKLO Z8.D, Z4.S
    SUNPKLO Z5.D, Z11.S
    SUNPKLO Z25.D, Z20.S
    SUNPKLO Z13.D, Z27.S
    SUNPKLO Z30.D, Z3.S
    SUNPKLO Z26.D, Z16.S
    SUNPKLO Z28.D, Z13.S
    SUNPKLO Z16.D, Z28.S
    SUNPKLO Z4.D, Z8.S
    UUNPKHI Z22.H, Z15.B
    UUNPKHI Z11.H, Z18.B
    UUNPKHI Z28.H, Z16.B
    UUNPKHI Z27.H, Z12.B
    UUNPKHI Z12.H, Z26.B
    UUNPKHI Z24.H, Z22.B
    UUNPKHI Z26.H, Z11.B
    UUNPKHI Z15.H, Z31.B
    UUNPKHI Z13.H, Z27.B
    UUNPKHI Z12.H, Z12.B
    UUNPKHI Z17.D, Z28.S
    UUNPKHI Z1.D, Z13.S
    UUNPKHI Z11.D, Z26.S
    UUNPKHI Z22.D, Z27.S
    UUNPKHI Z21.D, Z4.S
    UUNPKHI Z8.D, Z6.S
    UUNPKHI Z18.D, Z24.S
    UUNPKHI Z13.D, Z15.S
    UUNPKHI Z26.D, Z19.S
    UUNPKHI Z24.D, Z26.S
    UUNPKHI Z27.S, Z18.H
    UUNPKHI Z16.S, Z1.H
    UUNPKHI Z1.S, Z21.H
    UUNPKHI Z4.S, Z1.H
    UUNPKHI Z3.S, Z25.H
    UUNPKHI Z1.S, Z4.H
    UUNPKHI Z15.S, Z6.H
    UUNPKHI Z6.S, Z11.H
    UUNPKHI Z26.S, Z15.H
    UUNPKHI Z18.S, Z3.H
    UUNPKLO Z4.H, Z26.B
    UUNPKLO Z15.H, Z13.B
    UUNPKLO Z31.H, Z12.B
    UUNPKLO Z13.H, Z18.B
    UUNPKLO Z21.H, Z15.B
    UUNPKLO Z19.H, Z21.B
    UUNPKLO Z25.H, Z15.B
    UUNPKLO Z21.H, Z6.B
    UUNPKLO Z15.H, Z16.B
    UUNPKLO Z3.H, Z2.B
    UUNPKLO Z23.D, Z1.S
    UUNPKLO Z12.D, Z14.S
    UUNPKLO Z26.D, Z3.S
    UUNPKLO Z3.D, Z4.S
    UUNPKLO Z6.D, Z3.S
    UUNPKLO Z0.D, Z23.S
    UUNPKLO Z4.D, Z21.S
    UUNPKLO Z11.D, Z31.S
    UUNPKLO Z21.D, Z19.S
    UUNPKLO Z31.D, Z5.S
    UUNPKLO Z1.S, Z12.H
    UUNPKLO Z15.S, Z25.H
    UUNPKLO Z14.S, Z0.H
    UUNPKLO Z18.S, Z15.H
    UUNPKLO Z26.S, Z9.H
    UUNPKLO Z19.S, Z1.H
    UUNPKLO Z26.S, Z18.H
    UUNPKLO Z25.S, Z4.H
    UUNPKLO Z4.S, Z25.H
    UUNPKLO Z9.S, Z21.H
    PUNPKHI P4.H, P4.B
    PUNPKHI P11.H, P10.B
    PUNPKHI P12.H, P6.B
    PUNPKHI P15.H, P10.B
    PUNPKHI P6.H, P14.B
    PUNPKHI P9.H, P12.B
    PUNPKHI P1.H, P11.B
    PUNPKHI P9.H, P14.B
    PUNPKHI P10.H, P7.B
    PUNPKHI P0.H, P11.B
    PUNPKLO P1.H, P13.B
    PUNPKLO P0.H, P15.B
    PUNPKLO P14.H, P2.B
    PUNPKLO P6.H, P10.B
    PUNPKLO P14.H, P0.B
    PUNPKLO P8.H, P4.B
    PUNPKLO P13.H, P11.B
    PUNPKLO P14.H, P6.B
    PUNPKLO P11.H, P4.B
    PUNPKLO P9.H, P2.B
    MOVZ  X20, #0x94fd, LSL #0
    MOVK  X20, #0x9acb, LSL #16
    MOVK  X20, #0x108a, LSL #32
    MOVK  X20, #0x4287, LSL #48
    SUB  X23, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x9308, LSL #0
    MOVK  X20, #0xd967, LSL #16
    MOVK  X20, #0xd06a, LSL #32
    MOVK  X20, #0xc076, LSL #48
    SUB  X23, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x49d5, LSL #0
    MOVK  X20, #0x3c9e, LSL #16
    MOVK  X20, #0x6272, LSL #32
    MOVK  X20, #0xb566, LSL #48
    SUB  X23, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x3a7e, LSL #0
    MOVK  X20, #0x50e7, LSL #16
    MOVK  X20, #0x695, LSL #32
    MOVK  X20, #0xe974, LSL #48
    SUB  X23, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x2be9, LSL #0
    MOVK  X20, #0x4d39, LSL #16
    MOVK  X20, #0xc63c, LSL #32
    MOVK  X20, #0xf21, LSL #48
    SUB  X23, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x1863, LSL #0
    MOVK  X20, #0x4d09, LSL #16
    MOVK  X20, #0x20ca, LSL #32
    MOVK  X20, #0xd5c7, LSL #48
    SUB  X23, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x8f98, LSL #0
    MOVK  X20, #0x26d2, LSL #16
    MOVK  X20, #0x9f47, LSL #32
    MOVK  X20, #0x2320, LSL #48
    SUB  X23, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x3cc, LSL #0
    MOVK  X20, #0x3d9, LSL #16
    MOVK  X20, #0x7184, LSL #32
    MOVK  X20, #0xbb1d, LSL #48
    SUB  X23, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x48ec, LSL #0
    MOVK  X20, #0x1332, LSL #16
    MOVK  X20, #0x3b73, LSL #32
    MOVK  X20, #0x7345, LSL #48
    SUB  X23, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xc1c7, LSL #0
    MOVK  X20, #0x937e, LSL #16
    MOVK  X20, #0x448, LSL #32
    MOVK  X20, #0x85bb, LSL #48
    SUB  X23, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x4ca, LSL #0
    MOVK  X20, #0xddcd, LSL #16
    MOVK  X20, #0x16bc, LSL #32
    MOVK  X20, #0xc2fc, LSL #48
    SUB  X23, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x714a, LSL #0
    MOVK  X20, #0x101d, LSL #16
    MOVK  X20, #0xad20, LSL #32
    MOVK  X20, #0x87eb, LSL #48
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xd927, LSL #0
    MOVK  X20, #0xfc46, LSL #16
    MOVK  X20, #0x2a4, LSL #32
    MOVK  X20, #0x5dde, LSL #48
    SUB  X23, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xdbad, LSL #0
    MOVK  X20, #0x8813, LSL #16
    MOVK  X20, #0x6fbe, LSL #32
    MOVK  X20, #0x915f, LSL #48
    SUB  X23, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x3c7d, LSL #0
    MOVK  X20, #0x7b17, LSL #16
    MOVK  X20, #0x97bb, LSL #32
    MOVK  X20, #0xe9ae, LSL #48
    SUB  X23, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x512c, LSL #0
    MOVK  X20, #0x5bf9, LSL #16
    MOVK  X20, #0xf195, LSL #32
    MOVK  X20, #0x1af7, LSL #48
    SUB  X23, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x355a, LSL #0
    MOVK  X20, #0x59cb, LSL #16
    MOVK  X20, #0x1dd1, LSL #32
    MOVK  X20, #0xf664, LSL #48
    SUB  X23, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xa328, LSL #0
    MOVK  X20, #0x861f, LSL #16
    MOVK  X20, #0x32e, LSL #32
    MOVK  X20, #0x87cb, LSL #48
    SUB  X23, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xcc3d, LSL #0
    MOVK  X20, #0x7039, LSL #16
    MOVK  X20, #0x5ae8, LSL #32
    MOVK  X20, #0x4ac3, LSL #48
    SUB  X23, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0xda83, LSL #0
    MOVK  X20, #0xa096, LSL #16
    MOVK  X20, #0x7a83, LSL #32
    MOVK  X20, #0xbbdb, LSL #48
    SUB  X23, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MRS  X20, FPSR
    MOVZ  X23, #0x90, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D0
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D1
    MOVZ  X23, #0x9308, LSL #0
    MOVK  X23, #0xd967, LSL #32
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D2
    MOVZ  X23, #0xff83, LSL #0
    MOVK  X23, #0xffda, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D3
    MOVZ  X23, #0xbe, LSL #0
    MOVK  X23, #0x6f, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D4
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D5
    MOVZ  X23, #0xffd5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D6
    MOVZ  X23, #0xbe, LSL #0
    MOVK  X23, #0x6f, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D7
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X23, #0x8813, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D8
    MOVZ  X23, #0xdbad, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D9
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D10
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D11
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X23, #0xd06a, LSL #0
    MOVK  X23, #0xc076, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D12
    MOVZ  X23, #0x9308, LSL #0
    MOVK  X23, #0xd967, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D13
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D15
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D16
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D17
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D18
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X23, #0xd967, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D19
    MOVZ  X23, #0x9308, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D20
    MOVZ  X23, #0xdbad, LSL #0
    MOVK  X23, #0x8813, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D21
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D22
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D23
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D24
    MOVZ  X23, #0x2e1, LSL #0
    MOVK  X23, #0xdfce, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D25
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D26
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D27
    MOVZ  X23, #0xff, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    MOVK  X23, #0xff, LSL #32
    MOVK  X23, #0xff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D28
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    MOVK  X23, #0xff, LSL #32
    MOVK  X23, #0xff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X23, #0x2e1, LSL #0
    MOVK  X23, #0xdfce, LSL #16
    MOVK  X23, #0xf069, LSL #32
    MOVK  X23, #0x11c3, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D29
    MOVZ  X23, #0x2e1, LSL #0
    MOVK  X23, #0xdfce, LSL #16
    MOVK  X23, #0xf069, LSL #32
    MOVK  X23, #0x11c3, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X23, #0x13, LSL #0
    MOVK  X23, #0xff88, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D30
    MOVZ  X23, #0xffad, LSL #0
    MOVK  X23, #0xffdb, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FMOV  X20, D31
    MOVZ  X23, #0xffd5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x1111, LSL #0
    MOVK  X23, #0x1111, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x5555, LSL #0
    MOVK  X23, #0x5555, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x5555, LSL #0
    MOVK  X23, #0x5555, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x1111, LSL #0
    MOVK  X23, #0x1111, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x1111, LSL #0
    MOVK  X23, #0x1111, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x5555, LSL #0
    MOVK  X23, #0x5555, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x5555, LSL #0
    MOVK  X23, #0x5555, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x1111, LSL #0
    MOVK  X23, #0x1111, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x5555, LSL #0
    MOVK  X23, #0x5555, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x1111, LSL #0
    MOVK  X23, #0x1111, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x101, LSL #0
    MOVK  X23, #0x101, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X20, #0x0, LSL #0
    STR  X20, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X20, [X0, #0]
    MOVZ  X23, #0x5555, LSL #0
    MOVK  X23, #0x5555, LSL #16
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
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
    FMOV  X20, D0
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X20, D1
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X20, D2
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X20, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X20, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X20, D5
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D6, P2, Z6.D
    FMOV  X20, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D7, P7, Z7.D
    FMOV  X20, D7
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D8, P7, Z8.D
    FMOV  X20, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D9, P7, Z9.D
    FMOV  X20, D9
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X20, D10
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X20, D11
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X20, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X20, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X20, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D15, P2, Z15.D
    FMOV  X20, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X20, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D17, P0, Z17.D
    FMOV  X20, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X20, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X20, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X20, D20
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D21, P4, Z21.D
    FMOV  X20, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X20, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X20, D23
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X20, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X20, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X20, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X20, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X20, D28
    MOVZ  X23, #0xff, LSL #0
    MOVK  X23, #0xff, LSL #16
    MOVK  X23, #0xff, LSL #32
    MOVK  X23, #0x11f, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X20, D29
    MOVZ  X23, #0x2e1, LSL #0
    MOVK  X23, #0xdfce, LSL #16
    MOVK  X23, #0xf069, LSL #32
    MOVK  X23, #0x11e3, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X20, D30
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    FADDV   D31, P7, Z31.D
    FMOV  X20, D31
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0x5b6c, LSL #0
    MOVK  X2, #0xc67d, LSL #16
    MOVK  X2, #0xd83, LSL #32
    MOVK  X2, #0x123c, LSL #48
    MOVZ  X3, #0x9034, LSL #0
    MOVK  X3, #0x288a, LSL #16
    MOVK  X3, #0xfab8, LSL #32
    MOVK  X3, #0x160c, LSL #48
    MOVZ  X4, #0xaaca, LSL #0
    MOVK  X4, #0xac5b, LSL #16
    MOVK  X4, #0xce6a, LSL #32
    MOVK  X4, #0xa226, LSL #48
    MOVZ  X5, #0x3792, LSL #0
    MOVK  X5, #0x2a2e, LSL #16
    MOVK  X5, #0xe763, LSL #32
    MOVK  X5, #0x322d, LSL #48
    MOVZ  X6, #0x5ee6, LSL #0
    MOVK  X6, #0x9f62, LSL #16
    MOVK  X6, #0x13ec, LSL #32
    MOVK  X6, #0x8b1e, LSL #48
    MOVZ  X7, #0xc69, LSL #0
    MOVK  X7, #0xe856, LSL #16
    MOVK  X7, #0x12ce, LSL #32
    MOVK  X7, #0x1dfe, LSL #48
    MOVZ  X8, #0x1d2d, LSL #0
    MOVK  X8, #0x600, LSL #16
    MOVK  X8, #0xd154, LSL #32
    MOVK  X8, #0xdeef, LSL #48
    MOVZ  X9, #0x3d90, LSL #0
    MOVK  X9, #0x3fe0, LSL #16
    MOVK  X9, #0x632e, LSL #32
    MOVK  X9, #0xa467, LSL #48
    MOVZ  X10, #0xc6b0, LSL #0
    MOVK  X10, #0xc68e, LSL #16
    MOVK  X10, #0xe1a0, LSL #32
    MOVK  X10, #0x6d66, LSL #48
    MOVZ  X11, #0x1b3, LSL #0
    MOVK  X11, #0x6a14, LSL #16
    MOVK  X11, #0xf719, LSL #32
    MOVK  X11, #0x9e47, LSL #48
    MOVZ  X12, #0xd76b, LSL #0
    MOVK  X12, #0xf223, LSL #16
    MOVK  X12, #0xda4a, LSL #32
    MOVK  X12, #0xe45, LSL #48
    MOVZ  X13, #0x3de8, LSL #0
    MOVK  X13, #0xc8cc, LSL #16
    MOVK  X13, #0xabd6, LSL #32
    MOVK  X13, #0x4825, LSL #48
    MOVZ  X14, #0xa939, LSL #0
    MOVK  X14, #0xd54e, LSL #16
    MOVK  X14, #0xb223, LSL #32
    MOVK  X14, #0xa5e4, LSL #48
    MOVZ  X15, #0x6e2a, LSL #0
    MOVK  X15, #0x3748, LSL #16
    MOVK  X15, #0x8591, LSL #32
    MOVK  X15, #0x51ab, LSL #48
    MOVZ  X16, #0x36b5, LSL #0
    MOVK  X16, #0x69fc, LSL #16
    MOVK  X16, #0x36d4, LSL #32
    MOVK  X16, #0x628, LSL #48
    MOVZ  X17, #0x1c0e, LSL #0
    MOVK  X17, #0xa8fe, LSL #16
    MOVK  X17, #0x59, LSL #32
    MOVK  X17, #0x3d10, LSL #48
    MOVZ  X18, #0x32f0, LSL #0
    MOVK  X18, #0x49d0, LSL #16
    MOVK  X18, #0x3df4, LSL #32
    MOVK  X18, #0x4cdf, LSL #48
    MOVZ  X19, #0x1c4a, LSL #0
    MOVK  X19, #0x2fc4, LSL #16
    MOVK  X19, #0x2aa1, LSL #32
    MOVK  X19, #0x620f, LSL #48
    MOVZ  X20, #0x2c98, LSL #0
    MOVK  X20, #0x5243, LSL #16
    MOVK  X20, #0x3ed6, LSL #32
    MOVK  X20, #0x4d15, LSL #48
    MOVZ  X21, #0x6263, LSL #0
    MOVK  X21, #0x70b1, LSL #16
    MOVK  X21, #0x5bf7, LSL #32
    MOVK  X21, #0x84cb, LSL #48
    MOVZ  X22, #0x4668, LSL #0
    MOVK  X22, #0x70f9, LSL #16
    MOVK  X22, #0x4c02, LSL #32
    MOVK  X22, #0xf6ad, LSL #48
    MOVZ  X23, #0xc287, LSL #0
    MOVK  X23, #0x9481, LSL #16
    MOVK  X23, #0x33b, LSL #32
    MOVK  X23, #0x572a, LSL #48
    MOVZ  X24, #0x4eda, LSL #0
    MOVK  X24, #0xd2fa, LSL #16
    MOVK  X24, #0x92a8, LSL #32
    MOVK  X24, #0x5831, LSL #48
    DUP     Z0.D, X10
    DUP     Z1.D, X9
    DUP     Z2.D, X23
    DUP     Z3.D, X24
    DUP     Z4.D, X7
    DUP     Z5.D, X22
    DUP     Z6.D, X20
    DUP     Z7.D, X21
    DUP     Z8.D, X13
    DUP     Z9.D, X20
    DUP     Z10.D, X21
    DUP     Z11.D, X12
    DUP     Z12.D, X2
    DUP     Z13.D, X16
    DUP     Z14.D, X12
    DUP     Z15.D, X18
    DUP     Z16.D, X20
    DUP     Z17.D, X23
    DUP     Z18.D, X20
    DUP     Z19.D, X7
    DUP     Z20.D, X6
    DUP     Z21.D, X19
    DUP     Z22.D, X19
    DUP     Z23.D, X5
    DUP     Z24.D, X19
    DUP     Z25.D, X2
    DUP     Z26.D, X8
    DUP     Z27.D, X19
    DUP     Z28.D, X24
    DUP     Z29.D, X6
    DUP     Z30.D, X15
    DUP     Z31.D, X22
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
LCRTSveMoveOperations_label_0:
    LASTA   D1, P1, Z29.D
    INDEX   Z21.S, W23, #-7
    SUNPKHI Z21.H, Z21.B
    UUNPKLO Z8.H, Z21.B
    INDEX   Z24.H, #-10, W6
    SUNPKLO Z22.D, Z5.S
    UUNPKHI Z15.D, Z12.S
    SPLICE  Z16.D, P6, Z16.D, Z15.D
    REV     P11.B, P5.B
    INDEX   Z21.H, #0, #-4
    INDEX   Z26.H, W23, W15
    INDEX   Z31.S, W12, #-10
    INDEX   Z1.D, #15, #-10
    INDEX   Z6.S, #-16, #0
    UUNPKHI Z15.H, Z6.B
    UUNPKHI Z0.S, Z1.H
    INDEX   Z3.S, W8, #10
    ZIP1    P10.H, P0.H, P15.H
    UZP2    P6.H, P10.H, P6.H
    REV     P1.B, P2.B
    UZP1    P10.H, P6.H, P11.H
    INDEX   Z8.D, X10, X22
    TRN2    P14.H, P2.H, P11.H
    INDEX   Z18.H, #-16, W8
    ZIP1    Z15.S, Z21.S, Z18.S
    INDEX   Z18.B, W18, W11
    REV     P3.D, P4.D
    UZP2    P3.H, P12.H, P1.H
    INDEX   Z17.D, X23, X17
    UZP2    P11.S, P5.S, P10.S
    INDEX   Z24.H, #-14, #8
    INDEX   Z21.H, #-5, #9
    UUNPKLO Z24.D, Z0.S
    PUNPKHI P9.H, P1.B
    INDEX   Z6.D, #-10, X2
    TRN1    P3.B, P12.B, P14.B
    INDEX   Z21.D, #-4, X12
    UUNPKHI Z22.D, Z3.S
    SUNPKHI Z0.S, Z1.H
    LASTA   X22, P1, Z7.D
    INDEX   Z25.D, X3, X11
    MOV Z27.B,B24
    TRN1    P10.H, P9.H, P11.H
    UZP1    P4.S, P5.S, P12.S
    ZIP2    P9.S, P4.S, P15.S
    UZP2    P7.D, P7.D, P8.D
    INDEX   Z9.S, #-5, W15
    CLASTB  W12, P5, W12, Z20.S
    ZIP1    Z3.S, Z27.S, Z6.S
    INDEX   Z21.D, X12, X15
    MOV Z10.H,H0
    TRN1    P4.S, P15.S, P5.S
    INDEX   Z1.D, X15, X6
    UUNPKLO Z17.H, Z1.B
    TRN1    Z28.H, Z9.H, Z17.H
    UZP2    P11.H, P6.H, P15.H
    MOV Z22.B,Z3.B[19]
    SUNPKLO Z7.D, Z10.S
    SUNPKLO Z22.H, Z24.B
    LASTA   S11, P4, Z21.S
    REVH    Z29.S, P4/M, Z25.S
    UZP1    P14.S, P14.S, P10.S
    UUNPKHI Z1.H, Z28.B
    TRN1    P7.B, P8.B, P14.B
    INDEX   Z14.S, W6, W17
    UZP2    Z20.S, Z29.S, Z1.S
    UZP1    Z31.S, Z7.S, Z7.S
    UZP2    Z30.D, Z10.D, Z12.D
    UZP2    P3.S, P14.S, P13.S
    REV     Z0.S, Z31.S
    UUNPKHI Z10.S, Z14.H
    SUNPKHI Z31.H, Z9.B
    UZP2    P11.B, P7.B, P4.B
    ZIP1    P13.D, P6.D, P2.D
    SUNPKHI Z25.D, Z9.S
    UZP2    Z14.B, Z30.B, Z25.B
    UUNPKHI Z6.H, Z22.B
    LASTB   W17, P5, Z0.S
    UZP2    Z2.B, Z30.B, Z27.B
    INDEX   Z17.H, #-12, #-14
    ZIP2    P14.S, P2.S, P13.S
    SUNPKHI Z12.H, Z10.B
    INDEX   Z26.H, #11, #2
    INDEX   Z1.S, #15, W10
    UUNPKHI Z14.H, Z1.B
    INDEX   Z10.D, #-2, #9
    INDEX   Z29.S, #-8, #-15
    TRN1    P1.D, P14.D, P15.D
    UUNPKHI Z0.H, Z10.B
    MOV Z3.B,B10
    LASTA   W2, P2, Z0.B
    ZIP1    Z0.D, Z17.D, Z26.D
    INDEX   Z27.B, W13, W2
    ZIP2    P9.D, P5.D, P8.D
    INDEX   Z17.H, #-6, W20
    ZIP2    P7.H, P4.H, P12.H
    UZP1    P1.B, P9.B, P7.B
    UUNPKLO Z23.H, Z31.B
    ZIP2    P3.H, P4.H, P1.H
    CLASTB  S0, P3, S0, Z6.S
    INDEX   Z1.D, #15, #3
    ZIP2    Z10.D, Z3.D, Z3.D
    UUNPKLO Z21.D, Z29.S
    UUNPKHI Z21.S, Z23.H
    COMPACT Z26.S, P2, Z1.S
    TRN1    P7.D, P3.D, P8.D
    INDEX   Z30.H, #15, #2
    INDEX   Z1.H, #-5, W13
    ZIP2    Z1.S, Z0.S, Z0.S
    UUNPKHI Z6.S, Z27.H
    UZP1    P5.D, P11.D, P11.D
    INSR    Z10.B, B26
    UUNPKHI Z31.D, Z21.S
    CLASTA  B0, P0, B0, Z24.B
    ZIP2    P11.S, P11.S, P9.S
    TRN2    P5.B, P8.B, P3.B
    INDEX   Z24.D, #10, X12
    UUNPKLO Z23.S, Z9.H
    TRN2    Z20.S, Z0.S, Z24.S
    INDEX   Z9.S, W14, W23
    TBL     Z24.D,  Z9.D, Z23.D
    SUNPKHI Z13.H, Z11.B
    TRN2    P4.B, P10.B, P9.B
    REV     P8.B, P6.B
    UUNPKHI Z21.H, Z17.B
    INDEX   Z11.B, #3, W8
    INDEX   Z23.D, #15, #2
    SUNPKHI Z26.S, Z13.H
    INDEX   Z13.D, #-5, X10
    ZIP1    Z6.S, Z24.S, Z11.S
    INDEX   Z9.D, #7, #-14
    TRN1    P6.D, P6.D, P12.D
    TRN2    P2.H, P15.H, P6.H
    SPLICE  Z29.D, P4, Z29.D, Z23.D
    UZP2    P1.D, P7.D, P8.D
    UUNPKLO Z0.D, Z13.S
    ZIP2    P14.D, P11.D, P14.D
    INDEX   Z19.H, W2, W15
    ZIP1    P14.H, P12.H, P9.H
    PUNPKHI P9.H, P2.B
    SUNPKHI Z10.H, Z30.B
    CLASTA  D21, P2, D21, Z0.D
    INDEX   Z23.S, W22, #-14
    UUNPKLO Z17.S, Z20.H
    UZP1    P7.B, P8.B, P8.B
    INDEX   Z24.S, #2, W10
    ZIP2    P7.D, P15.D, P2.D
    UUNPKLO Z31.D, Z9.S
    CLASTA  W12, P3, W12, Z17.H
    TRN2    P4.D, P1.D, P3.D
    SUNPKHI Z19.S, Z10.H
    ZIP1    P10.S, P14.S, P8.S
    UZP1    P15.B, P12.B, P0.B
    TRN2    Z20.H, Z29.H, Z14.H
    SUNPKLO Z0.S, Z20.H
    SUNPKLO Z7.S, Z21.H
    INDEX   Z29.B, #3, #4
    SUNPKLO Z21.H, Z24.B
    INDEX   Z17.H, W15, W14
    INDEX   Z14.S, W17, #13
    REV     P0.H, P14.H
    INDEX   Z20.H, W12, W13
    LASTA   W19, P6, Z29.H
    CLASTA  H21, P1, H21, Z31.H
    ZIP1    P14.S, P5.S, P3.S
    SUNPKHI Z24.H, Z19.B
    TRN1    P3.H, P5.H, P13.H
    UUNPKLO Z31.S, Z24.H
    LASTA   W15, P6, Z17.H
    LASTA   B19, P1, Z21.B
    REV     P0.H, P11.H
    INDEX   Z24.B, W17, #-7
    UZP1    P1.H, P15.H, P7.H
    ZIP2    P11.B, P2.B, P1.B
    LASTA   B29, P3, Z0.B
    PUNPKLO P1.H, P11.B
    PUNPKLO P4.H, P14.B
    LASTB   D21, P4, Z14.D
    EXT     Z31.B, Z31.B, Z28.B, #0xce
    INDEX   Z14.D, X4, #4
    REV     P5.H, P0.H
    INDEX   Z0.D, #-15, X13
    UUNPKHI Z24.S, Z23.H
    SUNPKLO Z0.S, Z0.H
    MOV Z14.D,Z29.D[3]
    UZP1    P11.S, P8.S, P1.S
    INDEX   Z9.D, #2, #-9
    ZIP2    P1.D, P7.D, P11.D
    MOV Z27.S,S19
    ZIP2    P8.S, P0.S, P4.S
    UZP2    P11.S, P4.S, P10.S
    INDEX   Z29.S, W11, W8
    UZP2    P14.D, P4.D, P7.D
    LASTA   W19, P3, Z23.H
    ZIP1    Z14.B, Z21.B, Z21.B
    ZIP1    P2.H, P2.H, P15.H
    TRN2    P15.S, P1.S, P0.S
    UZP2    P10.D, P13.D, P11.D
    SUNPKHI Z12.D, Z19.S
    INDEX   Z9.D, X17, X8
    SUBS  X10, X10, #0x1
    B.NE  LCRTSveMoveOperations_label_0
    MOVZ  X24, #0x10, LSL #0
    SUB  X16, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x9034, LSL #0
    MOVK  X24, #0x288a, LSL #16
    MOVK  X24, #0xfab8, LSL #32
    MOVK  X24, #0x160c, LSL #48
    SUB  X16, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0xaaca, LSL #0
    MOVK  X24, #0xac5b, LSL #16
    MOVK  X24, #0xce6a, LSL #32
    MOVK  X24, #0xa226, LSL #48
    SUB  X16, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x3792, LSL #0
    MOVK  X24, #0x2a2e, LSL #16
    MOVK  X24, #0xe763, LSL #32
    MOVK  X24, #0x322d, LSL #48
    SUB  X16, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x5ee6, LSL #0
    MOVK  X24, #0x9f62, LSL #16
    MOVK  X24, #0x13ec, LSL #32
    MOVK  X24, #0x8b1e, LSL #48
    SUB  X16, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x1d2d, LSL #0
    MOVK  X24, #0x600, LSL #16
    MOVK  X24, #0xd154, LSL #32
    MOVK  X24, #0xdeef, LSL #48
    SUB  X16, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x3d90, LSL #0
    MOVK  X24, #0x3fe0, LSL #16
    MOVK  X24, #0x632e, LSL #32
    MOVK  X24, #0xa467, LSL #48
    SUB  X16, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x1b3, LSL #0
    MOVK  X24, #0x6a14, LSL #16
    MOVK  X24, #0xf719, LSL #32
    MOVK  X24, #0x9e47, LSL #48
    SUB  X16, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x3de8, LSL #0
    MOVK  X24, #0xc8cc, LSL #16
    MOVK  X24, #0xabd6, LSL #32
    MOVK  X24, #0x4825, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0xa939, LSL #0
    MOVK  X24, #0xd54e, LSL #16
    MOVK  X24, #0xb223, LSL #32
    MOVK  X24, #0xa5e4, LSL #48
    SUB  X16, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x6e2a, LSL #0
    SUB  X16, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0xfffb, LSL #0
    MOVK  X24, #0xfffb, LSL #16
    SUB  X16, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x32f0, LSL #0
    MOVK  X24, #0x49d0, LSL #16
    MOVK  X24, #0x3df4, LSL #32
    MOVK  X24, #0x4cdf, LSL #48
    SUB  X16, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0xffff, LSL #0
    SUB  X16, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x2c98, LSL #0
    MOVK  X24, #0x5243, LSL #16
    MOVK  X24, #0x3ed6, LSL #32
    MOVK  X24, #0x4d15, LSL #48
    SUB  X16, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x6263, LSL #0
    MOVK  X24, #0x70b1, LSL #16
    MOVK  X24, #0x5bf7, LSL #32
    MOVK  X24, #0x84cb, LSL #48
    SUB  X16, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0xc287, LSL #0
    MOVK  X24, #0x9481, LSL #16
    MOVK  X24, #0x33b, LSL #32
    MOVK  X24, #0x572a, LSL #48
    SUB  X16, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MRS  X24, FPSR
    MOVZ  X16, #0x90, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D0
    MOVZ  X16, #0xfff1, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D2
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X16, #0xfefe, LSL #0
    MOVK  X16, #0xfefe, LSL #16
    MOVK  X16, #0xfefe, LSL #32
    MOVK  X16, #0xfefe, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D3
    MOVZ  X16, #0xfefe, LSL #0
    MOVK  X16, #0xfefe, LSL #16
    MOVK  X16, #0xfefe, LSL #32
    MOVK  X16, #0xfefe, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X16, #0xc69, LSL #0
    MOVK  X16, #0xe856, LSL #16
    MOVK  X16, #0x12ce, LSL #32
    MOVK  X16, #0x1dfe, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D4
    MOVZ  X16, #0xc69, LSL #0
    MOVK  X16, #0xe856, LSL #16
    MOVK  X16, #0x12ce, LSL #32
    MOVK  X16, #0x1dfe, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X16, #0x4668, LSL #0
    MOVK  X16, #0x70f9, LSL #16
    MOVK  X16, #0x4c02, LSL #32
    MOVK  X16, #0xf6ad, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D5
    MOVZ  X16, #0x4668, LSL #0
    MOVK  X16, #0x70f9, LSL #16
    MOVK  X16, #0x4c02, LSL #32
    MOVK  X16, #0xf6ad, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xe4b7, LSL #32
    MOVK  X16, #0x3e11, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D6
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3003, LSL #32
    MOVK  X16, #0x8a5d, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D7
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D8
    MOVZ  X16, #0x1, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X16, #0x1d28, LSL #0
    MOVK  X16, #0x5fc, LSL #16
    MOVK  X16, #0xd155, LSL #32
    MOVK  X16, #0xdeef, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D9
    MOVZ  X16, #0xfffb, LSL #0
    MOVK  X16, #0xfffb, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X16, #0x23, LSL #0
    MOVK  X16, #0x25, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D10
    MOVZ  X16, #0x1f, LSL #0
    MOVK  X16, #0x21, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X16, #0x986b, LSL #0
    MOVK  X16, #0xf2c5, LSL #16
    MOVK  X16, #0x4c1f, LSL #32
    MOVK  X16, #0xa679, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D11
    MOVZ  X16, #0x3003, LSL #0
    MOVK  X16, #0x8a5d, LSL #16
    MOVK  X16, #0xe4b7, LSL #32
    MOVK  X16, #0x3e11, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X16, #0xfffc, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D13
    MOVZ  X16, #0xfffb, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X16, #0x5656, LSL #0
    MOVK  X16, #0xfcfc, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D14
    MOVZ  X16, #0x4949, LSL #0
    MOVK  X16, #0xfcfc, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X16, #0xfff8, LSL #0
    MOVK  X16, #0xfff4, LSL #16
    MOVK  X16, #0x3a4a, LSL #32
    MOVK  X16, #0x5777, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D15
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xfffc, LSL #16
    MOVK  X16, #0xfff0, LSL #32
    MOVK  X16, #0x1d1d, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X16, #0x2c98, LSL #0
    MOVK  X16, #0x5243, LSL #16
    MOVK  X16, #0x3ed6, LSL #32
    MOVK  X16, #0x4d15, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D16
    MOVZ  X16, #0x2c98, LSL #0
    MOVK  X16, #0x5243, LSL #16
    MOVK  X16, #0x3ed6, LSL #32
    MOVK  X16, #0x4d15, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X16, #0x130e, LSL #0
    MOVK  X16, #0xbc47, LSL #16
    MOVK  X16, #0x6580, LSL #32
    MOVK  X16, #0xeb9, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D17
    MOVZ  X16, #0x6e2a, LSL #0
    MOVK  X16, #0x1763, LSL #16
    MOVK  X16, #0xc09c, LSL #32
    MOVK  X16, #0x69d5, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X16, #0x3b88, LSL #0
    MOVK  X16, #0xa1ee, LSL #16
    MOVK  X16, #0x754, LSL #32
    MOVK  X16, #0x6dba, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D18
    MOVZ  X16, #0xa3f0, LSL #0
    MOVK  X16, #0x956, LSL #16
    MOVK  X16, #0x6fbc, LSL #32
    MOVK  X16, #0xd522, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D19
    MOVZ  X16, #0x7, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X16, #0xf7a0, LSL #0
    MOVK  X16, #0x3588, LSL #16
    MOVK  X16, #0x7370, LSL #32
    MOVK  X16, #0xb158, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D20
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3de8, LSL #16
    MOVK  X16, #0x7bd0, LSL #32
    MOVK  X16, #0xb9b8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D21
    MOVZ  X16, #0x49, LSL #0
    MOVK  X16, #0xfffc, LSL #16
    MOVK  X16, #0x56, LSL #32
    MOVK  X16, #0xfffc, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D22
    MOVZ  X16, #0xfffb, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X16, #0xffe3, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffd5, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D23
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xfff1, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X16, #0xffb9, LSL #0
    MOVK  X16, #0xffff, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D24
    MOVZ  X16, #0xffc7, LSL #0
    MOVK  X16, #0xffff, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X16, #0x26cd, LSL #0
    MOVK  X16, #0x2, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D25
    MOVZ  X16, #0xb8a3, LSL #0
    MOVK  X16, #0x1, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X16, #0x7, LSL #0
    MOVK  X16, #0x7, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D27
    MOVZ  X16, #0x7, LSL #0
    MOVK  X16, #0x7, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X16, #0xdc4f, LSL #0
    MOVK  X16, #0x4a79, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D28
    MOVZ  X16, #0xfffb, LSL #0
    MOVK  X16, #0x2a, LSL #16
    MOVK  X16, #0x6e25, LSL #32
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X16, #0x3c0d, LSL #0
    MOVK  X16, #0x7614, LSL #16
    MOVK  X16, #0x593a, LSL #32
    MOVK  X16, #0x7c14, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D29
    MOVZ  X16, #0x1b3, LSL #0
    MOVK  X16, #0x6a14, LSL #16
    MOVK  X16, #0x1ee0, LSL #32
    MOVK  X16, #0x7014, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X16, #0x17, LSL #0
    MOVK  X16, #0x19, LSL #16
    MOVK  X16, #0x1b, LSL #32
    MOVK  X16, #0x1d, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D30
    MOVZ  X16, #0xf, LSL #0
    MOVK  X16, #0x11, LSL #16
    MOVK  X16, #0x13, LSL #32
    MOVK  X16, #0x15, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X24, D31
    MOVZ  X16, #0x2b, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xff25, LSL #0
    MOVK  X16, #0xf225, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0x5f1, LSL #0
    MOVK  X16, #0x14fc, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xccff, LSL #0
    MOVK  X16, #0xfffc, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xefae, LSL #0
    MOVK  X16, #0x21c1, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0x5544, LSL #0
    MOVK  X16, #0x5544, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0x588f, LSL #0
    MOVK  X16, #0x58ff, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xff2f, LSL #0
    MOVK  X16, #0xfff3, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xc32f, LSL #0
    MOVK  X16, #0xfcf1, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0x4245, LSL #0
    MOVK  X16, #0x5f52, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0x5005, LSL #0
    MOVK  X16, #0x5550, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xccff, LSL #0
    MOVK  X16, #0xcf54, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0x5454, LSL #0
    MOVK  X16, #0xcf3f, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xff2f, LSL #0
    MOVK  X16, #0xccf0, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0x5555, LSL #0
    MOVK  X16, #0xfcc3, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X16, #0xf02f, LSL #0
    MOVK  X16, #0xf12f, LSL #16
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
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
    FMOV  X24, D0
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X24, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X24, D2
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X24, D3
    MOVZ  X16, #0xfefe, LSL #0
    MOVK  X16, #0xfefe, LSL #16
    MOVK  X16, #0xfefe, LSL #32
    MOVK  X16, #0xff1e, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X24, D4
    MOVZ  X16, #0xc69, LSL #0
    MOVK  X16, #0xe856, LSL #16
    MOVK  X16, #0x12ce, LSL #32
    MOVK  X16, #0x1e1e, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X24, D5
    MOVZ  X16, #0x4668, LSL #0
    MOVK  X16, #0x70f9, LSL #16
    MOVK  X16, #0x4c02, LSL #32
    MOVK  X16, #0xf6cd, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X24, D6
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x986a, LSL #32
    MOVK  X16, #0xf2c5, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D7, P5, Z7.D
    FMOV  X24, D7
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X24, D8
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X24, D9
    MOVZ  X16, #0x1d28, LSL #0
    MOVK  X16, #0x5fc, LSL #16
    MOVK  X16, #0xd155, LSL #32
    MOVK  X16, #0xdeef, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X24, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D11, P3, Z11.D
    FMOV  X24, D11
    MOVZ  X16, #0x683b, LSL #0
    MOVK  X16, #0xc295, LSL #16
    MOVK  X16, #0x1cef, LSL #32
    MOVK  X16, #0x7649, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X24, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X24, D13
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X24, D14
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D15, P2, Z15.D
    FMOV  X24, D15
    MOVZ  X16, #0xfff7, LSL #0
    MOVK  X16, #0xfff4, LSL #16
    MOVK  X16, #0x3a4a, LSL #32
    MOVK  X16, #0x5777, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X24, D16
    MOVZ  X16, #0x2c98, LSL #0
    MOVK  X16, #0x5243, LSL #16
    MOVK  X16, #0x3ed6, LSL #32
    MOVK  X16, #0x4d35, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X24, D17
    MOVZ  X16, #0x6e2a, LSL #0
    MOVK  X16, #0x1763, LSL #16
    MOVK  X16, #0xc09c, LSL #32
    MOVK  X16, #0x69d5, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X24, D18
    MOVZ  X16, #0x3b86, LSL #0
    MOVK  X16, #0xa1ee, LSL #16
    MOVK  X16, #0x754, LSL #32
    MOVK  X16, #0x6dba, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X24, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X24, D20
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3de8, LSL #16
    MOVK  X16, #0x7bd0, LSL #32
    MOVK  X16, #0xb9b8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D21, P2, Z21.D
    FMOV  X24, D21
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D22, P2, Z22.D
    FMOV  X24, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X24, D23
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D24, P7, Z24.D
    FMOV  X24, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X24, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X24, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X24, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X24, D28
    MOVZ  X16, #0x1d4a, LSL #0
    MOVK  X16, #0x818, LSL #16
    MOVK  X16, #0x16e6, LSL #32
    MOVK  X16, #0x63, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D29, P0, Z29.D
    FMOV  X24, D29
    MOVZ  X16, #0x3c0c, LSL #0
    MOVK  X16, #0x7614, LSL #16
    MOVK  X16, #0x593a, LSL #32
    MOVK  X16, #0x7c14, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D30, P6, Z30.D
    FMOV  X24, D30
    MOVZ  X16, #0xc016, LSL #0
    MOVK  X16, #0x4017, LSL #16
    MOVK  X16, #0xc019, LSL #32
    MOVK  X16, #0x42, LSL #48
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X24, D31
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    DUP     Z0.D, X9
    DUP     Z1.D, X13
    DUP     Z2.D, X4
    DUP     Z3.D, X17
    DUP     Z4.D, X12
    DUP     Z5.D, X16
    DUP     Z6.D, X17
    DUP     Z7.D, X23
    DUP     Z8.D, X18
    DUP     Z9.D, X19
    DUP     Z10.D, X22
    DUP     Z11.D, X18
    DUP     Z12.D, X20
    DUP     Z13.D, X24
    DUP     Z14.D, X21
    DUP     Z15.D, X13
    DUP     Z16.D, X8
    DUP     Z17.D, X17
    DUP     Z18.D, X19
    DUP     Z19.D, X11
    DUP     Z20.D, X2
    DUP     Z21.D, X13
    DUP     Z22.D, X8
    DUP     Z23.D, X4
    DUP     Z24.D, X12
    DUP     Z25.D, X14
    DUP     Z26.D, X10
    DUP     Z27.D, X11
    DUP     Z28.D, X11
    DUP     Z29.D, X23
    DUP     Z30.D, X8
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
    MOVZ  X3, #0xa, LSL #0
LCRTSveMoveOperations_label_1:
    INDEX   Z20.D, #3, #9
    UZP1    P10.D, P2.D, P13.D
    INDEX   Z25.D, #-14, #-11
    CLASTA  Z20.B, P3, Z20.B, Z29.B
    CLASTA  W18, P4, W18, Z20.S
    INDEX   Z20.H, #8, W13
    INDEX   Z22.S, #12, #-8
    SUNPKHI Z13.H, Z26.B
    UUNPKLO Z21.H, Z17.B
    CLASTA  W5, P7, W5, Z21.H
    TRN1    P0.H, P8.H, P6.H
    SUNPKLO Z23.D, Z22.S
    SUNPKHI Z8.S, Z20.H
    TRN1    P3.H, P3.H, P1.H
    CLASTB  Z8.D, P1, Z8.D, Z10.D
    INDEX   Z30.B, #-2, W6
    ZIP2    P6.H, P14.H, P3.H
    UUNPKLO Z29.S, Z29.H
    REV     P8.D, P12.D
    ZIP1    Z16.D, Z17.D, Z30.D
    UUNPKLO Z5.S, Z8.H
    INDEX   Z25.D, X5, #-14
    ZIP1    P12.H, P6.H, P5.H
    INDEX   Z27.D, X23, X13
    ZIP2    P12.S, P1.S, P1.S
    ZIP1    P4.H, P7.H, P8.H
    INDEX   Z17.D, X17, X23
    INDEX   Z1.D, X6, X21
    REV     P9.D, P8.D
    DUP Z27.B,Z29.B[50]
    INDEX   Z5.B, W24, #-4
    MOV Z5.D,Z13.D[3]
    ZIP2    P1.B, P2.B, P4.B
    INDEX   Z22.B, #8, W18
    SUNPKHI Z8.S, Z23.H
    UZP2    P11.S, P0.S, P1.S
    CLASTB  W6, P7, W6, Z17.H
    INDEX   Z8.D, #-7, #2
    INDEX   Z11.S, W8, #3
    REV     P5.H, P14.H
    ZIP2    P9.H, P7.H, P10.H
    TRN2    Z8.B, Z25.B, Z18.B
    UUNPKLO Z30.H, Z27.B
    INSR    Z21.H, W17
    SUNPKHI Z19.D, Z5.S
    UUNPKLO Z29.D, Z4.S
    SUNPKLO Z0.S, Z22.H
    INDEX   Z11.H, #-11, #-7
    UZP1    P2.B, P9.B, P11.B
    REVH    Z4.S, P7/M, Z29.S
    SUNPKLO Z2.H, Z29.B
    UUNPKHI Z8.H, Z24.B
    TRN1    Z13.S, Z29.S, Z8.S
    SUNPKLO Z3.S, Z11.H
    UZP1    P12.D, P5.D, P5.D
    REV     Z2.B, Z19.B
    INDEX   Z28.D, X18, X22
    REV     P10.H, P12.H
    TRN1    P0.D, P9.D, P3.D
    INDEX   Z0.H, #3, W23
    UZP2    P3.B, P12.B, P7.B
    UZP2    Z12.D, Z6.D, Z4.D
    ZIP2    P10.B, P0.B, P15.B
    UUNPKLO Z20.H, Z15.B
    CLASTA  W11, P3, W11, Z12.H
    SUNPKLO Z22.S, Z20.H
    UZP1    P12.B, P11.B, P9.B
    TRN1    P4.D, P7.D, P9.D
    UUNPKLO Z18.H, Z28.B
    SUNPKHI Z29.S, Z4.H
    CLASTB  W13, P6, W13, Z21.S
    TRN1    Z5.H, Z30.H, Z18.H
    INDEX   Z28.H, W2, W12
    ZIP1    P6.S, P8.S, P1.S
    ZIP1    Z15.D, Z22.D, Z8.D
    INDEX   Z6.S, W7, W12
    INDEX   Z12.H, #-14, #0
    INDEX   Z8.H, #-15, #-15
    INDEX   Z20.D, #12, #13
    UZP1    Z18.B, Z20.B, Z8.B
    UZP1    P8.B, P12.B, P4.B
    INDEX   Z30.D, X6, #10
    UZP1    P13.D, P3.D, P4.D
    TBL     Z13.B,  Z17.B, Z2.B
    TRN2    P14.B, P5.B, P8.B
    PUNPKHI P12.H, P3.B
    TRN1    P0.D, P15.D, P1.D
    INDEX   Z6.D, X22, #-5
    UZP2    P9.H, P6.H, P11.H
    SUNPKHI Z20.S, Z12.H
    INDEX   Z21.D, #-15, #4
    INSR    Z30.B, W23
    CLASTB  Z14.B, P4, Z14.B, Z28.B
    INDEX   Z22.B, #3, W21
    UUNPKLO Z2.S, Z30.H
    INDEX   Z30.S, W8, W16
    INDEX   Z2.S, #8, #-2
    UZP2    P10.D, P14.D, P3.D
    INDEX   Z24.H, #9, W13
    INDEX   Z12.B, #15, #-15
    UZP1    P13.D, P8.D, P10.D
    INDEX   Z28.S, #14, W8
    INDEX   Z30.B, #-1, #-15
    ZIP2    Z27.H, Z13.H, Z14.H
    LASTA   W21, P0, Z17.B
    ZIP2    P3.D, P7.D, P14.D
    INDEX   Z12.H, #0, W10
    ZIP2    P14.D, P11.D, P8.D
    UZP1    P4.D, P2.D, P12.D
    INDEX   Z31.H, #5, #8
    UUNPKHI Z15.D, Z2.S
    UUNPKLO Z21.H, Z24.B
    INDEX   Z14.D, X21, #-6
    REV     P9.D, P9.D
    UZP2    P7.S, P4.S, P15.S
    UZP2    P11.B, P14.B, P8.B
    TRN1    P8.B, P12.B, P4.B
    UZP1    P8.D, P7.D, P7.D
    TRN1    P8.S, P12.S, P9.S
    CLASTB  Z3.B, P0, Z3.B, Z6.B
    LASTB   S22, P5, Z3.S
    SUNPKLO Z13.S, Z29.H
    UUNPKLO Z8.D, Z27.S
    TRN2    P14.S, P5.S, P7.S
    INDEX   Z2.H, #-16, W17
    INDEX   Z26.B, #-14, W19
    DUP Z16.Q,Z8.Q[2]
    INDEX   Z23.H, #-12, #-10
    TRN2    P13.S, P3.S, P15.S
    ZIP1    P12.H, P6.H, P4.H
    LASTA   X13, P5, Z13.D
    SUNPKHI Z27.D, Z22.S
    TRN1    P4.D, P6.D, P15.D
    INDEX   Z21.H, W24, W13
    LASTA   W21, P2, Z0.B
    LASTA   W20, P3, Z2.H
    REVB    Z4.H, P0/M, Z27.H
    TRN2    P11.B, P4.B, P5.B
    PUNPKHI P12.H, P4.B
    INDEX   Z0.S, W5, #13
    CLASTB  X12, P7, X12, Z23.D
    INDEX   Z1.D, #-3, #-2
    CLASTB  X7, P2, X7, Z4.D
    UUNPKLO Z13.D, Z0.S
    PUNPKHI P14.H, P0.B
    SUNPKHI Z7.D, Z2.S
    UUNPKHI Z23.S, Z1.H
    ZIP2    P3.B, P0.B, P14.B
    ZIP1    P14.H, P15.H, P0.H
    CLASTB  Z21.D, P0, Z21.D, Z14.D
    SUNPKHI Z8.D, Z23.S
    INDEX   Z1.S, W10, #-15
    MOV Z26.B,Z8.B[58]
    REV     P14.D, P12.D
    ZIP2    Z2.D, Z13.D, Z26.D
    INDEX   Z29.S, #-2, #8
    UUNPKHI Z29.H, Z0.B
    ZIP1    P12.B, P10.B, P11.B
    INDEX   Z14.B, W21, #-10
    INDEX   Z19.B, W6, W2
    PUNPKHI P2.H, P1.B
    INDEX   Z4.D, #6, X20
    UZP2    P6.D, P6.D, P13.D
    SUNPKHI Z25.D, Z4.S
    INDEX   Z0.H, #4, #10
    UUNPKHI Z1.D, Z21.S
    ZIP1    P2.B, P13.B, P15.B
    ZIP1    P8.B, P4.B, P11.B
    LASTB   B12, P3, Z27.B
    ZIP2    P1.S, P15.S, P12.S
    CLASTB  S2, P6, S2, Z29.S
    TRN2    Z21.B, Z12.B, Z1.B
    UUNPKHI Z11.H, Z29.B
    LASTB   X5, P3, Z14.D
    SUNPKLO Z24.H, Z7.B
    UUNPKHI Z26.D, Z3.S
    INDEX   Z20.S, #-2, W23
    INDEX   Z19.H, #1, #-13
    INDEX   Z15.H, #-11, #8
    TRN1    P3.H, P15.H, P11.H
    SUNPKLO Z23.H, Z21.B
    SUNPKHI Z1.D, Z20.S
    UUNPKLO Z27.D, Z20.S
    ZIP1    Z0.B, Z23.B, Z3.B
    INDEX   Z29.S, #0, #-10
    UUNPKHI Z26.S, Z11.H
    UUNPKHI Z19.S, Z27.H
    ZIP2    P4.H, P0.H, P12.H
    INDEX   Z9.B, #2, W11
    INDEX   Z2.D, X22, X4
    UUNPKLO Z31.D, Z24.S
    TRN2    P3.H, P5.H, P14.H
    TRN1    P5.H, P9.H, P5.H
    PUNPKHI P6.H, P5.B
    UZP1    P0.H, P11.H, P15.H
    INDEX   Z11.D, X10, X18
    SUNPKHI Z27.D, Z15.S
    UZP1    Z21.B, Z19.B, Z29.B
    INDEX   Z12.S, #10, W18
    TRN1    P11.S, P1.S, P13.S
    SUBS  X3, X3, #0x1
    B.NE  LCRTSveMoveOperations_label_1
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x913, LSL #0
    MOVK  X15, #0xf5ff, LSL #16
    MOVK  X15, #0xe1eb, LSL #32
    MOVK  X15, #0xcdd7, LSL #48
    SUB  X9, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xfffb, LSL #0
    SUB  X9, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xff7c, LSL #0
    MOVK  X15, #0xff72, LSL #16
    MOVK  X15, #0xff68, LSL #32
    MOVK  X15, #0xff5e, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X9, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xfff0, LSL #0
    SUB  X9, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x3, LSL #0
    SUB  X9, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MRS  X15, FPSR
    MOVZ  X9, #0x90, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X9, #0xff00, LSL #0
    MOVK  X9, #0xff00, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D0
    MOVZ  X9, #0xff00, LSL #0
    MOVK  X9, #0xff00, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X9, #0xfffe, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D1
    MOVZ  X9, #0xfffe, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D3
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X9, #0xfff6, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D4
    MOVZ  X9, #0x6, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D5
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xff, LSL #16
    MOVK  X9, #0xff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X9, #0xfffb, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X9, #0xfff0, LSL #0
    MOVK  X9, #0xfff0, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D7
    MOVZ  X9, #0xfff0, LSL #0
    MOVK  X9, #0xfff0, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X9, #0xffff, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D8
    MOVZ  X9, #0xfff7, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X9, #0xd5da, LSL #0
    MOVK  X9, #0xcbd0, LSL #16
    MOVK  X9, #0xc1c6, LSL #32
    MOVK  X9, #0xb7bc, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D9
    MOVZ  X9, #0xfd02, LSL #0
    MOVK  X9, #0xf3f8, LSL #16
    MOVK  X9, #0xe9ee, LSL #32
    MOVK  X9, #0xdfe4, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X9, #0x8, LSL #0
    MOVK  X9, #0x7, LSL #32
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D12
    MOVZ  X9, #0xa, LSL #0
    MOVK  X9, #0x9, LSL #32
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X9, #0xd, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X9, #0xa9b3, LSL #0
    MOVK  X9, #0x959f, LSL #16
    MOVK  X9, #0x818b, LSL #32
    MOVK  X9, #0x6d77, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D14
    MOVZ  X9, #0xf903, LSL #0
    MOVK  X9, #0xe5ef, LSL #16
    MOVK  X9, #0xd1db, LSL #32
    MOVK  X9, #0xbdc7, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X9, #0x15, LSL #0
    MOVK  X9, #0x1d, LSL #16
    MOVK  X9, #0x25, LSL #32
    MOVK  X9, #0x2d, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D15
    MOVZ  X9, #0xfff5, LSL #0
    MOVK  X9, #0xfffd, LSL #16
    MOVK  X9, #0x5, LSL #32
    MOVK  X9, #0xd, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X9, #0x26, LSL #0
    MOVK  X9, #0x33, LSL #32
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D18
    MOVZ  X9, #0xc, LSL #0
    MOVK  X9, #0x19, LSL #32
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D19
    MOVZ  X9, #0xfffe, LSL #0
    MOVK  X9, #0xffff, LSL #32
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X9, #0xfffe, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xfffe, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D20
    MOVZ  X9, #0xfffe, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xfffe, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X9, #0xfe, LSL #0
    MOVK  X9, #0xff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D21
    MOVZ  X9, #0xfe, LSL #0
    MOVK  X9, #0xff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D22
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D23
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D24
    MOVZ  X9, #0xfff0, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xfff0, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D25
    MOVZ  X9, #0xffe6, LSL #0
    MOVK  X9, #0x1, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D26
    MOVZ  X9, #0x5b, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X9, #0x45, LSL #0
    MOVK  X9, #0x4d, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D27
    MOVZ  X9, #0x35, LSL #0
    MOVK  X9, #0x3d, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X9, #0xe, LSL #0
    MOVK  X9, #0xe, LSL #32
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D28
    MOVZ  X9, #0xe, LSL #0
    MOVK  X9, #0xe, LSL #32
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X9, #0xffec, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffe2, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D29
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xfff6, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X9, #0x7887, LSL #0
    MOVK  X9, #0x5a69, LSL #16
    MOVK  X9, #0x3c4b, LSL #32
    MOVK  X9, #0x1e2d, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D30
    MOVZ  X9, #0xf0ff, LSL #0
    MOVK  X9, #0xd2e1, LSL #16
    MOVK  X9, #0xb4c3, LSL #32
    MOVK  X9, #0x96a5, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X9, #0xfff0, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FMOV  X15, D31
    MOVZ  X9, #0xfff0, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x5555, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x6f6f, LSL #0
    MOVK  X9, #0x6f6f, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffee, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x4545, LSL #0
    MOVK  X9, #0x1515, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x7b7b, LSL #0
    MOVK  X9, #0x795b, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x5173, LSL #0
    MOVK  X9, #0x5555, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x1111, LSL #0
    MOVK  X9, #0x1111, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x55ff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x1616, LSL #0
    MOVK  X9, #0x7777, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x5577, LSL #0
    MOVK  X9, #0xd555, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xaaaa, LSL #0
    MOVK  X9, #0xff00, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xafff, LSL #0
    MOVK  X9, #0xafff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x4646, LSL #0
    MOVK  X9, #0x6666, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xfaff, LSL #0
    MOVK  X9, #0xfaff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0x5555, LSL #0
    MOVK  X9, #0x1414, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
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
    FMOV  X15, D0
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X15, D1
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X15, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X15, D3
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X15, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D5, P6, Z5.D
    FMOV  X15, D5
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xff, LSL #16
    MOVK  X9, #0x10f, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X15, D6
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X15, D7
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X15, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X15, D9
    MOVZ  X9, #0x8588, LSL #0
    MOVK  X9, #0x7b80, LSL #16
    MOVK  X9, #0x7176, LSL #32
    MOVK  X9, #0x676c, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X15, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X15, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X15, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X15, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X15, D14
    MOVZ  X9, #0xa9b1, LSL #0
    MOVK  X9, #0x959f, LSL #16
    MOVK  X9, #0x818b, LSL #32
    MOVK  X9, #0x6d77, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X15, D15
    MOVZ  X9, #0x831, LSL #0
    MOVK  X9, #0x4837, LSL #16
    MOVK  X9, #0x83c, LSL #32
    MOVK  X9, #0x73, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X15, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X15, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X15, D18
    MOVZ  X9, #0x6a78, LSL #0
    MOVK  X9, #0x4c5b, LSL #16
    MOVK  X9, #0x2e3d, LSL #32
    MOVK  X9, #0x101f, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X15, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X15, D20
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X15, D21
    MOVZ  X9, #0xdffb, LSL #0
    MOVK  X9, #0x9fef, LSL #16
    MOVK  X9, #0x5fe5, LSL #32
    MOVK  X9, #0xffe6, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X15, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X15, D23
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X15, D24
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D25, P3, Z25.D
    FMOV  X15, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D26, P4, Z26.D
    FMOV  X15, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X15, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X15, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D29, P2, Z29.D
    FMOV  X15, D29
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X15, D30
    MOVZ  X9, #0x8896, LSL #0
    MOVK  X9, #0x6a79, LSL #16
    MOVK  X9, #0x4c5b, LSL #32
    MOVK  X9, #0x2e3d, LSL #48
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X15, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    DUP     Z0.D, X24
    DUP     Z1.D, X23
    DUP     Z2.D, X21
    DUP     Z3.D, X22
    DUP     Z4.D, X6
    DUP     Z5.D, X18
    DUP     Z6.D, X13
    DUP     Z7.D, X15
    DUP     Z8.D, X16
    DUP     Z9.D, X10
    DUP     Z10.D, X19
    DUP     Z11.D, X2
    DUP     Z12.D, X21
    DUP     Z13.D, X18
    DUP     Z14.D, X11
    DUP     Z15.D, X14
    DUP     Z16.D, X4
    DUP     Z17.D, X11
    DUP     Z18.D, X8
    DUP     Z19.D, X23
    DUP     Z20.D, X8
    DUP     Z21.D, X14
    DUP     Z22.D, X18
    DUP     Z23.D, X4
    DUP     Z24.D, X14
    DUP     Z25.D, X12
    DUP     Z26.D, X12
    DUP     Z27.D, X10
    DUP     Z28.D, X10
    DUP     Z29.D, X24
    DUP     Z30.D, X9
    DUP     Z31.D, X12
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
    MOVZ  X23, #0xa, LSL #0
LCRTSveMoveOperations_label_2:
    SUNPKLO Z15.H, Z17.B
    CLASTB  H31, P4, H31, Z30.H
    UUNPKHI Z27.S, Z15.H
    LASTB   W17, P5, Z31.B
    INDEX   Z0.H, W12, #-15
    INDEX   Z24.B, W7, W21
    SUNPKHI Z5.H, Z16.B
    UZP1    P2.H, P15.H, P9.H
    ZIP1    P11.D, P9.D, P7.D
    ZIP1    P7.H, P10.H, P1.H
    UUNPKLO Z30.D, Z24.S
    INDEX   Z21.H, W10, W5
    UUNPKLO Z24.H, Z5.B
    UUNPKLO Z27.D, Z30.S
    UZP1    P6.D, P14.D, P0.D
    INDEX   Z10.D, X19, X8
    REV     P1.H, P11.H
    TRN2    P1.S, P11.S, P7.S
    EXT     Z3.B, Z3.B, Z27.B, #0x8c
    CLASTB  X15, P2, X15, Z3.D
    ZIP2    P15.B, P2.B, P6.B
    UZP1    P12.H, P8.H, P6.H
    PUNPKHI P1.H, P15.B
    PUNPKHI P8.H, P12.B
    INSR    Z31.H, W19
    INDEX   Z12.H, #-14, #8
    ZIP2    P14.D, P1.D, P8.D
    TRN2    P15.D, P2.D, P2.D
    INDEX   Z29.S, W10, W4
    ZIP1    P10.H, P12.H, P1.H
    ZIP2    P4.B, P14.B, P10.B
    INDEX   Z24.D, #8, #3
    UZP2    P7.D, P12.D, P9.D
    ZIP2    Z30.D, Z10.D, Z10.D
    INDEX   Z8.B, #-16, #3
    MOV     Z13.D, P6/M, D24
    INDEX   Z28.D, X19, X21
    INDEX   Z20.S, W7, #8
    SUNPKHI Z18.H, Z20.B
    TBL     Z14.D,  Z0.D, Z31.D
    TRN1    P7.B, P1.B, P6.B
    SUNPKLO Z29.S, Z16.H
    ZIP2    Z5.D, Z6.D, Z29.D
    INDEX   Z14.S, #2, W8
    INDEX   Z19.S, W7, W9
    SUNPKLO Z2.S, Z5.H
    MOV     Z11.B, P5/M, B8
    TRN1    P12.H, P0.H, P14.H
    CLASTB  W17, P4, W17, Z2.B
    INDEX   Z19.H, W17, W22
    UZP1    P6.D, P13.D, P9.D
    UZP1    P4.D, P13.D, P12.D
    INDEX   Z16.H, W9, W4
    INSR    Z11.H, H1
    ZIP1    Z12.D, Z30.D, Z28.D
    LASTA   W8, P5, Z16.B
    INDEX   Z28.S, W7, W4
    INDEX   Z13.S, #-15, #-10
    INDEX   Z11.D, #-3, #1
    REV     Z25.B, Z6.B
    INDEX   Z7.H, W2, #-15
    TRN1    Z18.B, Z7.B, Z12.B
    REV     P11.S, P1.S
    CLASTB  Z25.H, P5, Z25.H, Z28.H
    UUNPKHI Z28.H, Z25.B
    INDEX   Z23.B, #6, #5
    ZIP1    Z8.H, Z25.H, Z23.H
    DUP Z31.H,Z13.H[19]
    LASTA   S17, P5, Z31.S
    INDEX   Z0.D, #10, X4
    INDEX   Z16.S, #13, #11
    SUNPKHI Z29.H, Z16.B
    TRN2    P4.H, P3.H, P5.H
    INDEX   Z30.D, X3, X21
    TRN1    P6.D, P8.D, P3.D
    INDEX   Z13.H, W14, #15
    TRN1    P14.D, P10.D, P14.D
    UUNPKHI Z28.H, Z18.B
    UUNPKHI Z29.D, Z31.S
    SPLICE  Z30.D, P2, Z30.D, Z28.D
    SUNPKHI Z12.S, Z30.H
    REV     P7.B, P1.B
    INDEX   Z23.S, #-3, #-6
    SUNPKLO Z31.S, Z15.H
    LASTB   W3, P4, Z8.H
    DUP Z25.H,Z8.H[6]
    SUNPKHI Z8.D, Z23.S
    SUNPKHI Z14.H, Z13.B
    UZP1    P10.H, P6.H, P1.H
    CLASTA  Z18.H, P3, Z18.H, Z6.H
    ZIP2    P4.D, P7.D, P12.D
    UZP2    Z29.D, Z12.D, Z2.D
    UUNPKHI Z30.S, Z2.H
    INSR    Z4.D, D20
    UUNPKLO Z7.S, Z4.H
    INDEX   Z13.B, W22, #-10
    EXT     Z14.B, Z14.B, Z29.B, #0xaa
    SUNPKLO Z15.D, Z26.S
    CLASTA  X24, P1, X24, Z31.D
    TRN1    P1.S, P12.S, P3.S
    LASTB   D2, P6, Z31.D
    INDEX   Z12.S, W2, W12
    SUNPKHI Z6.D, Z8.S
    SUNPKLO Z20.D, Z2.S
    INDEX   Z4.B, #0, W20
    SUNPKHI Z21.H, Z13.B
    SUNPKLO Z27.H, Z12.B
    UUNPKLO Z26.D, Z15.S
    UUNPKLO Z29.D, Z15.S
    MOV Z21.S,Z26.S[11]
    INDEX   Z5.S, #14, #15
    UZP2    Z23.B, Z6.B, Z30.B
    INDEX   Z8.D, #-7, #3
    LASTA   X12, P7, Z5.D
    REVW    Z9.D, P1/M, Z21.D
    INDEX   Z21.D, #1, #-13
    UZP1    P6.B, P12.B, P10.B
    INDEX   Z13.D, #3, #13
    INDEX   Z30.H, #2, #-3
    INDEX   Z15.D, #-11, #-9
    INDEX   Z12.H, W15, W24
    MOV Z2.H,Z4.H[20]
    TRN2    P14.B, P12.B, P6.B
    UZP1    Z4.S, Z13.S, Z13.S
    SUNPKHI Z26.D, Z4.S
    LASTB   S21, P7, Z23.S
    INDEX   Z18.S, #13, #-13
    REV     P2.B, P10.B
    INDEX   Z6.H, #6, W18
    INDEX   Z23.B, #-3, #-13
    REV     P12.D, P12.D
    INDEX   Z13.H, #14, #-16
    ZIP1    Z20.B, Z10.B, Z12.B
    TRN1    P14.B, P14.B, P9.B
    SUNPKHI Z24.D, Z27.S
    CLASTB  B21, P4, B21, Z18.B
    UZP1    Z5.D, Z0.D, Z20.D
    SUNPKHI Z7.D, Z2.S
    UZP1    P13.D, P10.D, P3.D
    REV     P0.S, P6.S
    SUNPKHI Z6.H, Z5.B
    TRN2    P4.B, P7.B, P1.B
    REVW    Z0.D, P3/M, Z13.D
    INSR    Z23.H, W7
    ZIP2    P4.S, P1.S, P6.S
    ZIP1    P1.S, P0.S, P12.S
    MOV Z26.Q,Z0.Q[0]
    ZIP2    P5.S, P14.S, P12.S
    INDEX   Z14.S, #0, W12
    UUNPKLO Z28.S, Z14.H
    UUNPKHI Z29.D, Z0.S
    INDEX   Z26.H, W16, W23
    CLASTA  Z24.B, P2, Z24.B, Z26.B
    INDEX   Z18.B, W10, #8
    DUP Z3.D,Z3.D[6]
    ZIP2    P10.H, P8.H, P7.H
    UZP2    P11.H, P4.H, P13.H
    LASTB   B5, P2, Z18.B
    UUNPKHI Z8.S, Z23.H
    UZP1    Z16.D, Z28.D, Z3.D
    REV     P12.D, P2.D
    INDEX   Z10.D, #6, #1
    ZIP2    P5.H, P13.H, P2.H
    SUNPKHI Z8.H, Z24.B
    CLASTA  Z8.S, P5, Z8.S, Z10.S
    PUNPKHI P13.H, P11.B
    SUNPKLO Z25.S, Z16.H
    INDEX   Z24.B, #-4, #1
    TRN2    P9.H, P12.H, P7.H
    TRN1    P11.B, P5.B, P9.B
    CLASTB  Z5.B, P4, Z5.B, Z8.B
    INDEX   Z29.S, #-9, W16
    DUP Z20.H,Z2.H[19]
    UUNPKHI Z9.S, Z29.H
    UUNPKLO Z24.S, Z31.H
    UZP1    P0.H, P2.H, P1.H
    TRN1    Z16.H, Z24.H, Z5.H
    INDEX   Z3.B, #6, W3
    INDEX   Z11.S, W24, #8
    SUNPKHI Z28.H, Z25.B
    INDEX   Z5.D, #-1, #12
    UUNPKHI Z25.D, Z9.S
    SUNPKLO Z9.D, Z16.S
    ZIP1    P10.H, P0.H, P6.H
    INDEX   Z8.B, W18, #9
    INDEX   Z9.S, #-16, W19
    REV     Z18.H, Z12.H
    INDEX   Z8.D, X15, X20
    TRN2    Z16.B, Z9.B, Z25.B
    LASTA   D25, P5, Z18.D
    INDEX   Z9.B, W17, #7
    TRN1    P1.H, P11.H, P6.H
    TRN1    P2.S, P8.S, P7.S
    INDEX   Z0.H, #2, #-1
    INDEX   Z4.D, X2, #-7
    PUNPKLO P4.H, P1.B
    EXT     Z8.B, Z8.B, Z28.B, #0xc6
    UZP1    P2.D, P1.D, P2.D
    INDEX   Z28.H, W8, W17
    TRN1    P13.B, P2.B, P2.B
    SUBS  X23, X23, #0x1
    B.NE  LCRTSveMoveOperations_label_2
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xfff8, LSL #0
    SUB  X6, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xf0, LSL #0
    SUB  X6, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xe, LSL #0
    MOVK  X11, #0x1d, LSL #32
    SUB  X6, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x7e86, LSL #0
    MOVK  X11, #0x6e76, LSL #16
    MOVK  X11, #0x5e66, LSL #32
    MOVK  X11, #0x4e56, LSL #48
    SUB  X6, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MRS  X11, FPSR
    MOVZ  X6, #0x90, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X6, #0xfffe, LSL #0
    MOVK  X6, #0xfffd, LSL #16
    MOVK  X6, #0xfffc, LSL #32
    MOVK  X6, #0xfffb, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D0
    MOVZ  X6, #0x2, LSL #0
    MOVK  X6, #0x1, LSL #16
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D1
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X6, #0xbec6, LSL #0
    MOVK  X6, #0xaeb6, LSL #16
    MOVK  X6, #0x9ea6, LSL #32
    MOVK  X6, #0x8e96, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D3
    MOVZ  X6, #0xfe06, LSL #0
    MOVK  X6, #0xeef6, LSL #16
    MOVK  X6, #0xdee6, LSL #32
    MOVK  X6, #0xced6, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X6, #0xfff8, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D4
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X6, #0xb, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D5
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xff85, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0x7e, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D6
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xff86, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0x7e, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X6, #0x7e85, LSL #0
    MOVK  X6, #0x6e76, LSL #16
    MOVK  X6, #0x5e66, LSL #32
    MOVK  X6, #0x4e56, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D8
    MOVZ  X6, #0x7e86, LSL #0
    MOVK  X6, #0x6e76, LSL #16
    MOVK  X6, #0x5e66, LSL #32
    MOVK  X6, #0x4e56, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X6, #0x3f38, LSL #0
    MOVK  X6, #0x4d46, LSL #16
    MOVK  X6, #0x5b54, LSL #32
    MOVK  X6, #0x6962, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D9
    MOVZ  X6, #0x700, LSL #0
    MOVK  X6, #0x150e, LSL #16
    MOVK  X6, #0x231c, LSL #32
    MOVK  X6, #0x312a, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X6, #0x7, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D10
    MOVZ  X6, #0x6, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X6, #0xf, LSL #0
    MOVK  X6, #0x17, LSL #32
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D11
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x7, LSL #32
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X6, #0x7e82, LSL #0
    MOVK  X6, #0x7e81, LSL #16
    MOVK  X6, #0x7e80, LSL #32
    MOVK  X6, #0x7e7f, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D12
    MOVZ  X6, #0x7e86, LSL #0
    MOVK  X6, #0x7e85, LSL #16
    MOVK  X6, #0x7e84, LSL #32
    MOVK  X6, #0x7e83, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X6, #0xffce, LSL #0
    MOVK  X6, #0xffbe, LSL #16
    MOVK  X6, #0xffae, LSL #32
    MOVK  X6, #0xff9e, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D13
    MOVZ  X6, #0xe, LSL #0
    MOVK  X6, #0xfffe, LSL #16
    MOVK  X6, #0xffee, LSL #32
    MOVK  X6, #0xffde, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X6, #0x1c, LSL #0
    MOVK  X6, #0x2a, LSL #32
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D14
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xe, LSL #32
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X6, #0xffec, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D15
    MOVZ  X6, #0xfff5, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xff, LSL #16
    MOVK  X6, #0xff, LSL #32
    MOVK  X6, #0xff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D16
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xff, LSL #16
    MOVK  X6, #0xff, LSL #32
    MOVK  X6, #0xff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X6, #0x7e7b, LSL #0
    MOVK  X6, #0x7e7c, LSL #16
    MOVK  X6, #0x7e7d, LSL #32
    MOVK  X6, #0x7e7e, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D18
    MOVZ  X6, #0x7e77, LSL #0
    MOVK  X6, #0x7e78, LSL #16
    MOVK  X6, #0x7e79, LSL #32
    MOVK  X6, #0x7e7a, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X6, #0xfffc, LSL #0
    MOVK  X6, #0xfffb, LSL #16
    MOVK  X6, #0xfffa, LSL #32
    MOVK  X6, #0xfff9, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D19
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xfffe, LSL #32
    MOVK  X6, #0xfffd, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D22
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X6, #0xa2af, LSL #0
    MOVK  X6, #0x8895, LSL #16
    MOVK  X6, #0x6e7b, LSL #32
    MOVK  X6, #0x5461, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D23
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xf0fd, LSL #16
    MOVK  X6, #0xd6e3, LSL #32
    MOVK  X6, #0xbcc9, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D25
    MOVZ  X6, #0x7e77, LSL #0
    MOVK  X6, #0x7e78, LSL #16
    MOVK  X6, #0x7e79, LSL #32
    MOVK  X6, #0x7e7a, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X6, #0x3, LSL #0
    MOVK  X6, #0x4, LSL #16
    MOVK  X6, #0x5, LSL #32
    MOVK  X6, #0x6, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D26
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x1, LSL #32
    MOVK  X6, #0x2, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X6, #0xd, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D27
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X6, #0xf0, LSL #0
    MOVK  X6, #0xf0, LSL #16
    MOVK  X6, #0xf0, LSL #32
    MOVK  X6, #0xf0, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D28
    MOVZ  X6, #0xf0, LSL #0
    MOVK  X6, #0xf0, LSL #16
    MOVK  X6, #0xf0, LSL #32
    MOVK  X6, #0xf0, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X6, #0xfff5, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xfff4, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D29
    MOVZ  X6, #0xfff7, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xfff6, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X6, #0xfff6, LSL #0
    MOVK  X6, #0xfff3, LSL #16
    MOVK  X6, #0xfff0, LSL #32
    MOVK  X6, #0xffed, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D30
    MOVZ  X6, #0x2, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xfffc, LSL #32
    MOVK  X6, #0xfff9, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FMOV  X11, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x3300, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x1353, LSL #0
    MOVK  X6, #0x1111, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x1153, LSL #0
    MOVK  X6, #0x4, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x1105, LSL #0
    MOVK  X6, #0x105, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x33ff, LSL #0
    MOVK  X6, #0x33ff, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x50, LSL #0
    MOVK  X6, #0xcc, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x4, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x303, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x4400, LSL #0
    MOVK  X6, #0x303, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x1357, LSL #0
    MOVK  X6, #0x1155, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0xf0f, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x33f3, LSL #0
    MOVK  X6, #0xc, LSL #16
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x1302, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
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
    FMOV  X11, D0
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X11, D1
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D2, P2, Z2.D
    FMOV  X11, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D3, P3, Z3.D
    FMOV  X11, D3
    MOVZ  X6, #0x8787, LSL #0
    MOVK  X6, #0x8888, LSL #16
    MOVK  X6, #0xc888, LSL #32
    MOVK  X6, #0xced6, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X11, D4
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X11, D5
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D6, P2, Z6.D
    FMOV  X11, D6
    MOVZ  X6, #0x3ffb, LSL #0
    MOVK  X6, #0x7f84, LSL #16
    MOVK  X6, #0x8000, LSL #32
    MOVK  X6, #0x9e, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X11, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X11, D8
    MOVZ  X6, #0x7e84, LSL #0
    MOVK  X6, #0x6e76, LSL #16
    MOVK  X6, #0x5e66, LSL #32
    MOVK  X6, #0x4e76, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D9, P5, Z9.D
    FMOV  X11, D9
    MOVZ  X6, #0x3f37, LSL #0
    MOVK  X6, #0x4d46, LSL #16
    MOVK  X6, #0x5b54, LSL #32
    MOVK  X6, #0x6962, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X11, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X11, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X11, D12
    MOVZ  X6, #0xde21, LSL #0
    MOVK  X6, #0x9e20, LSL #16
    MOVK  X6, #0x5e1f, LSL #32
    MOVK  X6, #0x7e9e, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X11, D13
    MOVZ  X6, #0xb17c, LSL #0
    MOVK  X6, #0xa8f4, LSL #16
    MOVK  X6, #0x886c, LSL #32
    MOVK  X6, #0xffe0, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D14, P5, Z14.D
    FMOV  X11, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X11, D15
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X11, D16
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xff, LSL #16
    MOVK  X6, #0xff, LSL #32
    MOVK  X6, #0x11f, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X11, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D18, P3, Z18.D
    FMOV  X11, D18
    MOVZ  X6, #0xdede, LSL #0
    MOVK  X6, #0x9edf, LSL #16
    MOVK  X6, #0x5ee0, LSL #32
    MOVK  X6, #0x7ea1, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D19, P5, Z19.D
    FMOV  X11, D19
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X11, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D21, P2, Z21.D
    FMOV  X11, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X11, D22
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X11, D23
    MOVZ  X6, #0x3a46, LSL #0
    MOVK  X6, #0x202d, LSL #16
    MOVK  X6, #0x613, LSL #32
    MOVK  X6, #0xecf9, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X11, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X11, D25
    MOVZ  X6, #0x7e77, LSL #0
    MOVK  X6, #0x7e78, LSL #16
    MOVK  X6, #0x7e79, LSL #32
    MOVK  X6, #0x7e7a, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X11, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X11, D27
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X11, D28
    MOVZ  X6, #0xf0, LSL #0
    MOVK  X6, #0xf0, LSL #16
    MOVK  X6, #0xf0, LSL #32
    MOVK  X6, #0x110, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X11, D29
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D30, P6, Z30.D
    FMOV  X11, D30
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X11, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    DUP     Z0.D, X13
    DUP     Z1.D, X18
    DUP     Z2.D, X21
    DUP     Z3.D, X22
    DUP     Z4.D, X23
    DUP     Z5.D, X24
    DUP     Z6.D, X5
    DUP     Z7.D, X2
    DUP     Z8.D, X23
    DUP     Z9.D, X14
    DUP     Z10.D, X23
    DUP     Z11.D, X20
    DUP     Z12.D, X23
    DUP     Z13.D, X4
    DUP     Z14.D, X14
    DUP     Z15.D, X24
    DUP     Z16.D, X6
    DUP     Z17.D, X4
    DUP     Z18.D, X22
    DUP     Z19.D, X5
    DUP     Z20.D, X17
    DUP     Z21.D, X2
    DUP     Z22.D, X15
    DUP     Z23.D, X18
    DUP     Z24.D, X5
    DUP     Z25.D, X24
    DUP     Z26.D, X7
    DUP     Z27.D, X23
    DUP     Z28.D, X12
    DUP     Z29.D, X16
    DUP     Z30.D, X20
    DUP     Z31.D, X22
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
    MOVZ  X18, #0xa, LSL #0
LCRTSveMoveOperations_label_3:
    ZIP2    Z26.H, Z29.H, Z11.H
    PUNPKLO P13.H, P5.B
    INDEX   Z20.B, W21, #-10
    ZIP1    P8.S, P2.S, P10.S
    TRN1    P1.D, P6.D, P8.D
    ZIP2    Z7.H, Z23.H, Z25.H
    INDEX   Z29.D, #-6, #12
    TRN2    P2.D, P2.D, P5.D
    MOV Z14.Q,Z23.Q[1]
    ZIP2    P2.D, P7.D, P13.D
    ZIP1    P5.S, P10.S, P1.S
    EXT     Z20.B, Z20.B, Z20.B, #0x62
    UZP2    P8.H, P12.H, P15.H
    INDEX   Z5.D, #9, X8
    SUNPKHI Z17.S, Z15.H
    DUP Z21.Q,Z14.Q[2]
    ZIP2    P10.S, P6.S, P14.S
    INDEX   Z22.H, W4, W3
    INDEX   Z11.H, W19, #3
    TRN1    P10.H, P2.H, P8.H
    UZP2    P10.H, P10.H, P3.H
    CLASTB  X11, P2, X11, Z26.D
    UUNPKLO Z12.D, Z1.S
    MOV     Z1.B, P5/M, B24
    CLASTA  D11, P0, D11, Z21.D
    SUNPKHI Z23.S, Z19.H
    INDEX   Z2.S, #13, #7
    INDEX   Z4.S, W14, W4
    UUNPKLO Z13.S, Z28.H
    LASTB   W19, P2, Z13.S
    TRN1    P1.B, P14.B, P2.B
    LASTA   W23, P0, Z29.H
    INDEX   Z3.H, W14, W20
    INDEX   Z24.S, #-14, #-1
    SUNPKLO Z12.S, Z25.H
    INDEX   Z28.D, X21, #-6
    INDEX   Z19.B, #13, #15
    INDEX   Z9.B, #-9, W7
    INDEX   Z30.S, #-8, W5
    REV     P4.B, P9.B
    SUNPKHI Z29.S, Z23.H
    UUNPKLO Z31.D, Z30.S
    UUNPKLO Z3.H, Z12.B
    ZIP1    P0.B, P4.B, P4.B
    TRN1    P8.D, P7.D, P2.D
    ZIP2    Z29.D, Z9.D, Z4.D
    ZIP2    P5.H, P9.H, P5.H
    ZIP2    P0.S, P3.S, P2.S
    UZP1    Z10.B, Z3.B, Z29.B
    INDEX   Z1.S, W21, #3
    UZP2    P7.D, P1.D, P5.D
    TRN1    Z19.H, Z10.H, Z21.H
    SUNPKLO Z8.S, Z17.H
    INDEX   Z27.D, X8, #-7
    UUNPKLO Z30.S, Z8.H
    INDEX   Z6.S, W3, #3
    INDEX   Z13.B, #-3, W13
    PUNPKLO P5.H, P5.B
    LASTA   B3, P1, Z6.B
    INDEX   Z0.S, W12, #12
    UUNPKHI Z30.D, Z27.S
    LASTA   W3, P2, Z9.H
    INSR    Z19.H, H19
    INDEX   Z5.H, W19, #6
    CLASTB  X20, P4, X20, Z30.D
    UUNPKHI Z1.H, Z5.B
    UUNPKHI Z16.S, Z4.H
    CLASTA  Z1.B, P7, Z1.B, Z0.B
    PUNPKHI P14.H, P2.B
    UZP2    P9.D, P4.D, P7.D
    MOV Z0.H,Z3.H[6]
    INDEX   Z3.S, W4, W22
    SUNPKLO Z23.S, Z0.H
    TRN1    P13.S, P5.S, P3.S
    UZP2    P15.H, P15.H, P14.H
    TRN2    P12.B, P14.B, P8.B
    SUNPKHI Z10.H, Z11.B
    CLASTB  B3, P4, B3, Z1.B
    INDEX   Z6.D, #5, #-14
    INDEX   Z4.S, W9, #5
    SUNPKLO Z1.D, Z10.S
    REV     Z10.H, Z29.H
    INDEX   Z17.H, W16, #10
    REVW    Z0.D, P5/M, Z5.D
    INDEX   Z5.B, W2, #-15
    REV     P8.D, P6.D
    UUNPKLO Z11.S, Z10.H
    UUNPKHI Z29.D, Z23.S
    SUNPKHI Z10.D, Z8.S
    SUNPKHI Z10.D, Z17.S
    CLASTA  Z3.D, P0, Z3.D, Z1.D
    CLASTB  Z5.B, P5, Z5.B, Z30.B
    MOV Z3.D,Z28.D[3]
    INDEX   Z8.B, #-14, W14
    REV     P3.H, P12.H
    TRN2    P7.H, P5.H, P14.H
    SUNPKHI Z28.S, Z4.H
    SUNPKLO Z4.D, Z20.S
    PUNPKLO P4.H, P9.B
    TRN2    P10.S, P3.S, P13.S
    TRN1    P10.S, P0.S, P7.S
    TRN1    Z20.D, Z10.D, Z3.D
    TRN1    P2.S, P0.S, P13.S
    ZIP1    Z23.D, Z0.D, Z7.D
    UUNPKHI Z19.D, Z28.S
    ZIP1    P3.D, P6.D, P0.D
    SUNPKHI Z0.S, Z29.H
    SUNPKHI Z31.D, Z19.S
    INSR    Z23.B, B17
    INDEX   Z1.B, W16, #-15
    UUNPKHI Z29.H, Z23.B
    SUNPKHI Z19.D, Z8.S
    INDEX   Z8.S, W11, #-14
    INDEX   Z17.H, #-10, W3
    MOV Z23.H,Z0.H[7]
    LASTB   X23, P1, Z17.D
    INDEX   Z0.H, #-16, W3
    CLASTB  W8, P1, W8, Z12.H
    UZP1    P1.B, P5.B, P3.B
    INDEX   Z23.D, X7, X9
    INDEX   Z6.D, X21, #2
    LASTB   B18, P7, Z1.B
    SUNPKLO Z28.H, Z6.B
    TRN1    P13.D, P9.D, P0.D
    INDEX   Z17.B, #13, W12
    UZP1    P6.D, P0.D, P15.D
    CLASTB  H18, P3, H18, Z0.H
    PUNPKHI P0.H, P4.B
    MOV Z6.Q,Z17.Q[1]
    INDEX   Z17.B, #2, W4
    CLASTA  D29, P1, D29, Z18.D
    UZP2    P9.H, P7.H, P14.H
    MOV     Z1.H, P4/M, H17
    LASTB   X22, P7, Z23.D
    REV     P2.S, P1.S
    INDEX   Z9.H, W23, #10
    REVH    Z0.S, P7/M, Z6.S
    UUNPKHI Z24.H, Z0.B
    UZP1    P2.S, P8.S, P5.S
    INDEX   Z6.D, X2, #15
    UUNPKLO Z0.H, Z1.B
    ZIP2    Z23.B, Z6.B, Z9.B
    ZIP2    P6.H, P1.H, P10.H
    UZP2    P10.D, P9.D, P13.D
    INDEX   Z17.B, #11, #9
    SUNPKLO Z17.H, Z29.B
    SUNPKHI Z18.D, Z24.S
    SUNPKLO Z24.H, Z17.B
    INDEX   Z24.H, W22, #15
    MOV Z24.D,Z23.D[3]
    INDEX   Z31.S, #-11, W16
    INDEX   Z17.D, X13, #-9
    REV     P8.D, P9.D
    MOV Z9.B,B31
    INDEX   Z6.B, #-2, W19
    UUNPKHI Z24.S, Z24.H
    TRN2    P11.S, P7.S, P10.S
    REV     P6.S, P11.S
    UUNPKHI Z12.S, Z27.H
    ZIP2    Z27.H, Z22.H, Z18.H
    TBL     Z29.B,  Z17.B, Z21.B
    CLASTB  W20, P4, W20, Z24.S
    INDEX   Z1.D, #-5, #3
    INDEX   Z22.B, W22, W21
    SUNPKHI Z26.H, Z13.B
    TBL     Z24.H,  Z22.H, Z22.H
    ZIP1    P2.B, P7.B, P4.B
    UUNPKHI Z27.H, Z26.B
    UZP1    P6.S, P12.S, P6.S
    INDEX   Z11.D, #12, #3
    UUNPKLO Z23.D, Z0.S
    UUNPKLO Z0.S, Z1.H
    UZP2    P4.H, P10.H, P1.H
    SPLICE  Z10.B, P6, Z10.B, Z8.B
    TRN2    P2.B, P8.B, P8.B
    INDEX   Z18.H, W13, #-11
    UUNPKLO Z0.D, Z29.S
    CLASTA  B27, P5, B27, Z23.B
    INDEX   Z17.B, W16, #-4
    INDEX   Z13.B, W23, #-7
    TRN2    P10.S, P11.S, P15.S
    ZIP1    P8.B, P15.B, P0.B
    REV     P14.H, P12.H
    INDEX   Z31.S, #13, #7
    UUNPKLO Z26.S, Z10.H
    INDEX   Z9.H, #2, W12
    SUNPKHI Z15.H, Z13.B
    PUNPKLO P7.H, P14.B
    ZIP2    P6.H, P15.H, P12.H
    INDEX   Z10.D, X10, #0
    TRN1    P14.S, P2.S, P13.S
    MOV     Z1.D, P0/M, D9
    MOV Z8.B,Z0.B[7]
    TRN1    P8.D, P9.D, P4.D
    INDEX   Z29.S, W21, #15
    SUNPKHI Z13.H, Z17.B
    INDEX   Z0.B, W22, #-5
    SUNPKHI Z30.S, Z8.H
    INDEX   Z16.S, #4, #9
    TRN1    P10.D, P5.D, P6.D
    SUBS  X18, X18, #0x1
    B.NE  LCRTSveMoveOperations_label_3
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x51f7, LSL #0
    SUB  X15, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X15, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5aa5, LSL #0
    MOVK  X6, #0x5a5a, LSL #32
    SUB  X15, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X15, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xd85a, LSL #0
    SUB  X15, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x6968, LSL #0
    MOVK  X6, #0x6969, LSL #16
    MOVK  X6, #0x6969, LSL #32
    MOVK  X6, #0x6969, LSL #48
    SUB  X15, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xd78a, LSL #0
    MOVK  X6, #0x2981, LSL #16
    MOVK  X6, #0x7b78, LSL #32
    MOVK  X6, #0xcd6f, LSL #48
    SUB  X15, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X15, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MRS  X6, FPSR
    MOVZ  X15, #0x91, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X15, #0x3b40, LSL #0
    MOVK  X15, #0x3136, LSL #16
    MOVK  X15, #0x272c, LSL #32
    MOVK  X15, #0x1d22, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D0
    MOVZ  X15, #0x6368, LSL #0
    MOVK  X15, #0x595e, LSL #16
    MOVK  X15, #0x4f54, LSL #32
    MOVK  X15, #0x454a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X15, #0xfffe, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D1
    MOVZ  X15, #0xfffb, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X15, #0x1b, LSL #0
    MOVK  X15, #0x22, LSL #32
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D2
    MOVZ  X15, #0xd, LSL #0
    MOVK  X15, #0x14, LSL #32
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X15, #0x5a48, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D3
    MOVZ  X15, #0x5a48, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X15, #0x2832, LSL #0
    MOVK  X15, #0x141e, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D4
    MOVZ  X15, #0x505a, LSL #0
    MOVK  X15, #0x3c46, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X15, #0xd3e2, LSL #0
    MOVK  X15, #0xb5c4, LSL #16
    MOVK  X15, #0x97a6, LSL #32
    MOVK  X15, #0x7988, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D5
    MOVZ  X15, #0x4b5a, LSL #0
    MOVK  X15, #0x2d3c, LSL #16
    MOVK  X15, #0xf1e, LSL #32
    MOVK  X15, #0xf100, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X15, #0x28ce, LSL #0
    MOVK  X15, #0xdc82, LSL #16
    MOVK  X15, #0x9036, LSL #32
    MOVK  X15, #0x44ea, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D6
    MOVZ  X15, #0x58fe, LSL #0
    MOVK  X15, #0xcb2, LSL #16
    MOVK  X15, #0xc066, LSL #32
    MOVK  X15, #0x741a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D7
    MOVZ  X15, #0x1e, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0xf, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X15, #0x696a, LSL #0
    MOVK  X15, #0xc3c4, LSL #16
    MOVK  X15, #0x1e1e, LSL #32
    MOVK  X15, #0x7878, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D9
    MOVZ  X15, #0x2, LSL #0
    MOVK  X15, #0x5a5c, LSL #16
    MOVK  X15, #0xb4b6, LSL #32
    MOVK  X15, #0xf10, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D10
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X15, #0xf, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D11
    MOVZ  X15, #0xc, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D12
    MOVZ  X15, #0x5a4c, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X15, #0xa, LSL #0
    MOVK  X15, #0x6, LSL #16
    MOVK  X15, #0x2, LSL #32
    MOVK  X15, #0xfffe, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D13
    MOVZ  X15, #0x1a, LSL #0
    MOVK  X15, #0x16, LSL #16
    MOVK  X15, #0x12, LSL #32
    MOVK  X15, #0xe, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xf1, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D14
    MOVZ  X15, #0x1e, LSL #0
    MOVK  X15, #0xf, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X15, #0xfffe, LSL #0
    MOVK  X15, #0xfff7, LSL #16
    MOVK  X15, #0xfff0, LSL #32
    MOVK  X15, #0xffe9, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D15
    MOVZ  X15, #0x1a, LSL #0
    MOVK  X15, #0x13, LSL #16
    MOVK  X15, #0xc, LSL #32
    MOVK  X15, #0x5, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X15, #0x16, LSL #0
    MOVK  X15, #0x1f, LSL #32
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D16
    MOVZ  X15, #0x4, LSL #0
    MOVK  X15, #0xd, LSL #32
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X15, #0x363a, LSL #0
    MOVK  X15, #0x2e32, LSL #16
    MOVK  X15, #0x262a, LSL #32
    MOVK  X15, #0x1e22, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D17
    MOVZ  X15, #0x565a, LSL #0
    MOVK  X15, #0x4e52, LSL #16
    MOVK  X15, #0x464a, LSL #32
    MOVK  X15, #0x3e42, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X15, #0x5a2e, LSL #0
    MOVK  X15, #0x5a23, LSL #16
    MOVK  X15, #0x5a18, LSL #32
    MOVK  X15, #0x5a0d, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D18
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a4f, LSL #16
    MOVK  X15, #0x5a44, LSL #32
    MOVK  X15, #0x5a39, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X15, #0x54fa, LSL #0
    MOVK  X15, #0x8ae, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D19
    MOVZ  X15, #0xec92, LSL #0
    MOVK  X15, #0xa046, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X15, #0x5a48, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D20
    MOVZ  X15, #0x5aaa, LSL #0
    MOVK  X15, #0x5ab4, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X15, #0x9238, LSL #0
    MOVK  X15, #0x46ec, LSL #16
    MOVK  X15, #0xfaa0, LSL #32
    MOVK  X15, #0xae54, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D22
    MOVZ  X15, #0xc268, LSL #0
    MOVK  X15, #0x761c, LSL #16
    MOVK  X15, #0x2ad0, LSL #32
    MOVK  X15, #0xde84, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X15, #0x3c, LSL #0
    MOVK  X15, #0x2d, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D23
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x4b, LSL #16
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D25
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X15, #0x5a97, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D26
    MOVZ  X15, #0x5aa5, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D27
    MOVZ  X15, #0x6d, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5a, LSL #16
    MOVK  X15, #0x5a, LSL #32
    MOVK  X15, #0x5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D28
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5a, LSL #16
    MOVK  X15, #0x5a, LSL #32
    MOVK  X15, #0x5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X15, #0x5a78, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a87, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D29
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a69, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X15, #0x1b, LSL #0
    MOVK  X15, #0x22, LSL #32
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FMOV  X6, D31
    MOVZ  X15, #0xd, LSL #0
    MOVK  X15, #0x14, LSL #32
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
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
    FADDV   D0, P4, Z0.D
    FMOV  X6, D0
    MOVZ  X15, #0x1317, LSL #0
    MOVK  X15, #0x90e, LSL #16
    MOVK  X15, #0xff04, LSL #32
    MOVK  X15, #0xf5fa, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D1, P3, Z1.D
    FMOV  X6, D1
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X6, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X6, D3
    MOVZ  X15, #0x5a48, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X6, D4
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X6, D5
    MOVZ  X15, #0xd3e0, LSL #0
    MOVK  X15, #0xb5c4, LSL #16
    MOVK  X15, #0x97a6, LSL #32
    MOVK  X15, #0x7988, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X6, D6
    MOVZ  X15, #0x58fd, LSL #0
    MOVK  X15, #0xcb2, LSL #16
    MOVK  X15, #0xc066, LSL #32
    MOVK  X15, #0x741a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D7, P7, Z7.D
    FMOV  X6, D7
    MOVZ  X15, #0x7, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x40, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X6, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X6, D9
    MOVZ  X15, #0x6969, LSL #0
    MOVK  X15, #0xc3c4, LSL #16
    MOVK  X15, #0x1e1e, LSL #32
    MOVK  X15, #0x7878, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X6, D10
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X6, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X6, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X6, D13
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X6, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X6, D15
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffef, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X6, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X6, D17
    MOVZ  X15, #0x1619, LSL #0
    MOVK  X15, #0xe12, LSL #16
    MOVK  X15, #0x60a, LSL #32
    MOVK  X15, #0xfe02, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X6, D18
    MOVZ  X15, #0x4bc8, LSL #0
    MOVK  X15, #0x88bd, LSL #16
    MOVK  X15, #0xa5b0, LSL #32
    MOVK  X15, #0x5a3d, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X6, D19
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X6, D20
    MOVZ  X15, #0x5a48, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a6a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D21, P7, Z21.D
    FMOV  X6, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D22, P2, Z22.D
    FMOV  X6, D22
    MOVZ  X15, #0x6207, LSL #0
    MOVK  X15, #0x16bc, LSL #16
    MOVK  X15, #0xca70, LSL #32
    MOVK  X15, #0x7e24, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X6, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X6, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X6, D25
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X6, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X6, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D28, P3, Z28.D
    FMOV  X6, D28
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5a, LSL #16
    MOVK  X15, #0x5a, LSL #32
    MOVK  X15, #0x7a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X6, D29
    MOVZ  X15, #0x5a87, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a96, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X6, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    FADDV   D31, P6, Z31.D
    FMOV  X6, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    DUP     Z0.D, X19
    DUP     Z1.D, X17
    DUP     Z2.D, X12
    DUP     Z3.D, X22
    DUP     Z4.D, X9
    DUP     Z5.D, X16
    DUP     Z6.D, X7
    DUP     Z7.D, X4
    DUP     Z8.D, X23
    DUP     Z9.D, X5
    DUP     Z10.D, X9
    DUP     Z11.D, X24
    DUP     Z12.D, X16
    DUP     Z13.D, X14
    DUP     Z14.D, X12
    DUP     Z15.D, X11
    DUP     Z16.D, X15
    DUP     Z17.D, X8
    DUP     Z18.D, X12
    DUP     Z19.D, X7
    DUP     Z20.D, X4
    DUP     Z21.D, X9
    DUP     Z22.D, X9
    DUP     Z23.D, X2
    DUP     Z24.D, X2
    DUP     Z25.D, X13
    DUP     Z26.D, X15
    DUP     Z27.D, X14
    DUP     Z28.D, X6
    DUP     Z29.D, X18
    DUP     Z30.D, X23
    DUP     Z31.D, X18
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
    MOVZ  X13, #0xa, LSL #0
LCRTSveMoveOperations_label_4:
    PUNPKLO P2.H, P2.B
    TRN2    P0.H, P14.H, P3.H
    INDEX   Z1.D, #14, X24
    INDEX   Z3.H, #13, W8
    ZIP1    Z4.B, Z26.B, Z27.B
    CLASTB  W22, P2, W22, Z23.B
    INDEX   Z29.B, #3, W14
    UUNPKLO Z26.D, Z4.S
    SUNPKLO Z30.H, Z26.B
    SUNPKLO Z5.H, Z3.B
    INDEX   Z13.H, #4, W12
    SUNPKLO Z26.S, Z29.H
    REVB    Z11.D, P0/M, Z13.D
    ZIP2    P2.H, P11.H, P15.H
    TRN1    Z8.H, Z30.H, Z26.H
    UUNPKLO Z19.D, Z22.S
    SUNPKLO Z9.H, Z1.B
    INDEX   Z7.S, #-3, #2
    CLASTA  Z8.H, P2, Z8.H, Z19.H
    INSR    Z11.S, S9
    PUNPKLO P12.H, P10.B
    INDEX   Z12.D, X22, #-7
    TRN2    P10.S, P12.S, P6.S
    INDEX   Z28.S, #13, W9
    UZP1    P13.B, P9.B, P10.B
    INDEX   Z26.B, #-3, W15
    INDEX   Z4.S, W14, #5
    DUP Z13.Q,Z8.Q[1]
    INDEX   Z27.B, W19, W12
    INDEX   Z21.D, #6, X9
    UZP2    P1.B, P13.B, P3.B
    UZP1    P10.S, P4.S, P8.S
    TBL     Z13.B,  Z7.B, Z21.B
    TBL     Z21.H,  Z1.H, Z4.H
    CLASTA  Z13.B, P3, Z13.B, Z11.B
    UUNPKHI Z4.D, Z21.S
    ZIP2    P11.B, P9.B, P3.B
    SUNPKHI Z24.S, Z15.H
    INDEX   Z4.D, #4, X3
    SUNPKLO Z27.H, Z28.B
    INDEX   Z6.B, W9, W22
    INDEX   Z17.D, X3, #-12
    INDEX   Z17.S, W10, #-8
    UZP2    P12.S, P5.S, P2.S
    UUNPKHI Z21.S, Z24.H
    SUNPKLO Z1.H, Z6.B
    UUNPKLO Z13.D, Z19.S
    DUP Z16.Q,Z4.Q[0]
    INDEX   Z3.D, #-2, X10
    UUNPKHI Z10.S, Z29.H
    INDEX   Z28.H, W21, #-8
    CLASTB  Z1.S, P1, Z1.S, Z11.S
    SUNPKLO Z12.D, Z1.S
    LASTB   B9, P5, Z16.B
    REV     P13.B, P7.B
    TRN2    P15.H, P12.H, P3.H
    SPLICE  Z12.D, P1, Z12.D, Z10.D
    SUNPKLO Z19.H, Z3.B
    ZIP1    P5.H, P2.H, P7.H
    UZP1    P5.B, P1.B, P15.B
    UUNPKLO Z3.H, Z28.B
    TRN1    P7.B, P14.B, P5.B
    REV     P3.S, P9.S
    INDEX   Z13.S, W10, #14
    ZIP1    P10.D, P5.D, P12.D
    CLASTA  D3, P5, D3, Z30.D
    UZP2    P3.S, P9.S, P12.S
    MOV Z10.D,D9
    TRN1    P13.B, P10.B, P8.B
    LASTA   H24, P1, Z27.H
    SUNPKHI Z3.D, Z3.S
    INDEX   Z2.B, W9, #-11
    INDEX   Z21.S, #4, W5
    INDEX   Z1.D, #11, X21
    TRN2    P11.B, P15.B, P5.B
    INDEX   Z18.B, #4, W16
    TRN1    Z9.H, Z27.H, Z2.H
    INDEX   Z15.S, W16, W8
    UUNPKLO Z0.D, Z3.S
    UUNPKLO Z17.H, Z10.B
    INDEX   Z25.B, #-13, W17
    INDEX   Z10.S, #-16, W16
    REV     Z9.S, Z15.S
    INDEX   Z23.H, W5, W5
    INDEX   Z23.H, W19, W17
    SUNPKHI Z12.H, Z21.B
    INDEX   Z18.H, #-5, #-3
    MOV Z28.B,Z12.B[8]
    INDEX   Z10.D, X20, X13
    REVB    Z3.S, P5/M, Z10.S
    INSR    Z18.B, W8
    CLASTB  Z1.D, P7, Z1.D, Z18.D
    INDEX   Z26.H, #-15, W13
    DUP Z18.D,Z28.D[1]
    INDEX   Z23.H, W9, W18
    SUNPKHI Z26.S, Z8.H
    SUNPKLO Z15.S, Z11.H
    INDEX   Z17.D, X3, #-1
    INDEX   Z0.B, #-11, #0
    REV     P3.B, P6.B
    INDEX   Z15.H, W12, #14
    ZIP1    P8.H, P11.H, P10.H
    INDEX   Z2.H, #-2, #-12
    TRN2    Z18.H, Z3.H, Z18.H
    PUNPKLO P2.H, P15.B
    UUNPKLO Z11.D, Z15.S
    INDEX   Z22.H, #2, #-4
    UZP1    P2.D, P0.D, P13.D
    UUNPKHI Z28.S, Z11.H
    ZIP1    P1.S, P1.S, P2.S
    INDEX   Z3.H, W18, #3
    INDEX   Z20.D, #-4, #-7
    REV     Z3.B, Z1.B
    INDEX   Z18.D, #3, X21
    ZIP2    P14.B, P10.B, P4.B
    UUNPKLO Z0.D, Z22.S
    UUNPKHI Z1.S, Z18.H
    INDEX   Z6.S, W21, #-12
    INDEX   Z17.S, W13, W9
    INDEX   Z2.H, W15, #9
    UZP1    P10.H, P14.H, P1.H
    ZIP2    P13.D, P15.D, P7.D
    INDEX   Z21.D, X18, X24
    UUNPKHI Z24.D, Z9.S
    TRN2    P12.S, P6.S, P5.S
    SUNPKLO Z8.D, Z1.S
    INDEX   Z18.D, X21, X12
    SUNPKHI Z25.S, Z31.H
    INDEX   Z13.S, W6, W3
    UUNPKHI Z0.D, Z13.S
    SUNPKHI Z12.H, Z8.B
    SUNPKLO Z21.S, Z30.H
    LASTA   B25, P5, Z0.B
    SUNPKHI Z12.D, Z24.S
    UZP1    P10.B, P4.B, P11.B
    LASTA   X18, P3, Z3.D
    SUNPKHI Z20.D, Z14.S
    LASTB   W21, P3, Z2.S
    REV     Z7.B, Z12.B
    ZIP1    Z13.D, Z20.D, Z20.D
    REV     P1.H, P5.H
    ZIP2    P2.H, P2.H, P2.H
    MOV Z8.B,Z13.B[12]
    SPLICE  Z30.H, P1, Z30.H, Z21.H
    INDEX   Z26.B, W13, #8
    UUNPKLO Z12.S, Z6.H
    REVW    Z13.D, P7/M, Z26.D
    INDEX   Z16.H, #5, #-1
    SUNPKLO Z2.H, Z28.B
    INDEX   Z28.B, W13, #-4
    INDEX   Z21.D, X4, #8
    DUP Z20.D,Z14.D[4]
    LASTB   W21, P1, Z8.S
    REV     P14.B, P3.B
    INDEX   Z19.D, #12, #2
    CLASTA  Z30.B, P1, Z30.B, Z20.B
    REV     P11.B, P11.B
    UUNPKHI Z20.S, Z16.H
    MOV Z22.B,B7
    INDEX   Z0.B, #-12, #-5
    DUP Z6.S,Z8.S[11]
    INDEX   Z7.D, #2, X11
    ZIP1    Z3.D, Z2.D, Z7.D
    INDEX   Z8.D, X13, X21
    INDEX   Z29.H, W22, #-11
    INDEX   Z18.D, #9, X6
    TRN2    P14.D, P12.D, P1.D
    INDEX   Z31.D, X11, X4
    UUNPKLO Z2.S, Z19.H
    LASTA   W21, P6, Z29.B
    INDEX   Z14.H, #0, W13
    INDEX   Z31.B, W16, W17
    UZP1    P12.S, P0.S, P0.S
    UUNPKHI Z7.S, Z18.H
    INDEX   Z19.B, #-5, W9
    TRN2    P7.S, P15.S, P5.S
    TRN2    P6.D, P15.D, P1.D
    UUNPKHI Z30.D, Z16.S
    LASTA   S18, P0, Z19.S
    ZIP1    P3.D, P15.D, P6.D
    CLASTA  S3, P2, S3, Z31.S
    UUNPKLO Z6.H, Z30.B
    ZIP1    P3.S, P12.S, P3.S
    REVH    Z16.S, P0/M, Z8.S
    ZIP2    P4.S, P13.S, P7.S
    ZIP2    Z29.H, Z12.H, Z22.H
    INDEX   Z12.H, W5, W15
    INDEX   Z27.B, W5, W19
    INDEX   Z9.S, W15, #-8
    UZP1    Z0.S, Z27.S, Z18.S
    INSR    Z6.S, S9
    CLASTA  B14, P1, B14, Z16.B
    PUNPKLO P11.H, P3.B
    ZIP2    P15.D, P2.D, P2.D
    INDEX   Z10.D, #13, X20
    TRN1    P6.S, P4.S, P9.S
    INDEX   Z22.D, X12, X5
    TRN2    P1.D, P15.D, P14.D
    PUNPKHI P5.H, P2.B
    SUNPKHI Z18.S, Z22.H
    SUBS  X13, X13, #0x1
    B.NE  LCRTSveMoveOperations_label_4
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xffce, LSL #0
    MOVK  X23, #0xffd1, LSL #16
    MOVK  X23, #0xffd4, LSL #32
    MOVK  X23, #0xffd7, LSL #48
    SUB  X2, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xb7, LSL #0
    SUB  X2, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xb7, LSL #0
    SUB  X2, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X2, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MRS  X23, FPSR
    MOVZ  X2, #0x95, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X2, #0x9af5, LSL #0
    MOVK  X2, #0xe43f, LSL #16
    MOVK  X2, #0xc21d, LSL #32
    MOVK  X2, #0xc67, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D0
    MOVZ  X2, #0x4aa5, LSL #0
    MOVK  X2, #0x94ef, LSL #16
    MOVK  X2, #0x72cd, LSL #32
    MOVK  X2, #0xbc17, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D1
    MOVZ  X2, #0x171, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D2
    MOVZ  X2, #0xc, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D3
    MOVZ  X2, #0x56b1, LSL #0
    MOVK  X2, #0xa0fb, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X2, #0xa5a9, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D4
    MOVZ  X2, #0x4, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X2, #0x57, LSL #0
    MOVK  X2, #0x4b, LSL #16
    MOVK  X2, #0xfffc, LSL #32
    MOVK  X2, #0xfff0, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D5
    MOVZ  X2, #0xd, LSL #0
    MOVK  X2, #0xffb2, LSL #32
    MOVK  X2, #0xffa5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X2, #0xfc, LSL #0
    MOVK  X2, #0xff, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D6
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xfd, LSL #32
    MOVK  X2, #0xff, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X2, #0x4b4b, LSL #0
    MOVK  X2, #0x4b4b, LSL #32
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D7
    MOVZ  X2, #0x4b53, LSL #0
    MOVK  X2, #0x4b4b, LSL #32
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X2, #0x1, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D8
    MOVZ  X2, #0x1, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X2, #0xa595, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa58d, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D9
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa59d, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X2, #0xa5b2, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D10
    MOVZ  X2, #0xd, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X2, #0xa5c1, LSL #0
    MOVK  X2, #0xa5cf, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D11
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5b3, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X2, #0x3c39, LSL #0
    MOVK  X2, #0xe1de, LSL #16
    MOVK  X2, #0x8783, LSL #32
    MOVK  X2, #0x2d28, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D12
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0x4b4a, LSL #16
    MOVK  X2, #0xf0ef, LSL #32
    MOVK  X2, #0x9694, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D13
    MOVZ  X2, #0x2921, LSL #0
    MOVK  X2, #0x3931, LSL #16
    MOVK  X2, #0x901, LSL #32
    MOVK  X2, #0x1911, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X2, #0xa5dd, LSL #0
    MOVK  X2, #0xa5eb, LSL #16
    MOVK  X2, #0xa5f9, LSL #32
    MOVK  X2, #0xa607, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D15
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5b3, LSL #16
    MOVK  X2, #0xa5c1, LSL #32
    MOVK  X2, #0xa5cf, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x1, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xfffe, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D16
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x1, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X2, #0x4b4b, LSL #0
    MOVK  X2, #0x4b4b, LSL #16
    MOVK  X2, #0xf0f0, LSL #32
    MOVK  X2, #0xf0f0, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D17
    MOVZ  X2, #0x1, LSL #0
    MOVK  X2, #0xa5a6, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X2, #0xf0f0, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xf0f0, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D18
    MOVZ  X2, #0xf0ef, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xf0f0, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X2, #0xc823, LSL #0
    MOVK  X2, #0x126d, LSL #16
    MOVK  X2, #0x5cb7, LSL #32
    MOVK  X2, #0xa601, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D19
    MOVZ  X2, #0xa0fb, LSL #0
    MOVK  X2, #0xea45, LSL #16
    MOVK  X2, #0x348f, LSL #32
    MOVK  X2, #0x7ed9, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X2, #0xfffb, LSL #0
    MOVK  X2, #0xfffa, LSL #32
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D20
    MOVZ  X2, #0xfffd, LSL #0
    MOVK  X2, #0xfffc, LSL #32
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X2, #0xa5ad, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D21
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x4b4b, LSL #16
    MOVK  X2, #0x4b4b, LSL #32
    MOVK  X2, #0x4b4b, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D22
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X2, #0xa4dd, LSL #0
    MOVK  X2, #0xa4ab, LSL #16
    MOVK  X2, #0xa479, LSL #32
    MOVK  X2, #0xa447, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D23
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa573, LSL #16
    MOVK  X2, #0xa541, LSL #32
    MOVK  X2, #0xa50f, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X2, #0xf0ef, LSL #0
    MOVK  X2, #0xf0f0, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D24
    MOVZ  X2, #0x9694, LSL #0
    MOVK  X2, #0x9696, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D25
    MOVZ  X2, #0x39, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X2, #0x4941, LSL #0
    MOVK  X2, #0x5951, LSL #16
    MOVK  X2, #0x6961, LSL #32
    MOVK  X2, #0x7971, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D26
    MOVZ  X2, #0x901, LSL #0
    MOVK  X2, #0x1911, LSL #16
    MOVK  X2, #0x2921, LSL #32
    MOVK  X2, #0x3931, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X2, #0x72cd, LSL #0
    MOVK  X2, #0xbc17, LSL #16
    MOVK  X2, #0x661, LSL #32
    MOVK  X2, #0x50ab, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D27
    MOVZ  X2, #0x4aa5, LSL #0
    MOVK  X2, #0x94ef, LSL #16
    MOVK  X2, #0xde39, LSL #32
    MOVK  X2, #0x2883, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X2, #0xdde1, LSL #0
    MOVK  X2, #0xd5d9, LSL #16
    MOVK  X2, #0xcdd1, LSL #32
    MOVK  X2, #0xc5c9, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D28
    MOVZ  X2, #0xfd01, LSL #0
    MOVK  X2, #0xf5f9, LSL #16
    MOVK  X2, #0xedf1, LSL #32
    MOVK  X2, #0xe5e9, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D29
    MOVZ  X2, #0x9f, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X2, #0xfffb, LSL #0
    MOVK  X2, #0xfffa, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D30
    MOVZ  X2, #0xfffd, LSL #0
    MOVK  X2, #0xfffc, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X2, #0x72cd, LSL #0
    MOVK  X2, #0xbc17, LSL #16
    MOVK  X2, #0x661, LSL #32
    MOVK  X2, #0x50ab, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FMOV  X23, D31
    MOVZ  X2, #0x4aa5, LSL #0
    MOVK  X2, #0x94ef, LSL #16
    MOVK  X2, #0xde39, LSL #32
    MOVK  X2, #0x2883, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xefdf, LSL #0
    MOVK  X2, #0xfdff, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xbef5, LSL #0
    MOVK  X2, #0xf70f, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xfff5, LSL #0
    MOVK  X2, #0xff5, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xdfcf, LSL #0
    MOVK  X2, #0xcddf, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xbddf, LSL #0
    MOVK  X2, #0xffdf, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0x5511, LSL #0
    MOVK  X2, #0x55, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xfdff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0x1cdd, LSL #0
    MOVK  X2, #0xfdbd, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xf4fe, LSL #0
    MOVK  X2, #0x5414, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xff7f, LSL #0
    MOVK  X2, #0xbbaa, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0x5055, LSL #0
    MOVK  X2, #0x5155, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xdfff, LSL #0
    MOVK  X2, #0xdfff, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0x7ddf, LSL #0
    MOVK  X2, #0xffdf, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xbe1f, LSL #0
    MOVK  X2, #0xf7ff, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X2, #0xf5f5, LSL #0
    MOVK  X2, #0xf0f, LSL #16
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
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
    FMOV  X23, D0
    MOVZ  X2, #0x4aa4, LSL #0
    MOVK  X2, #0x94ef, LSL #16
    MOVK  X2, #0x72cd, LSL #32
    MOVK  X2, #0xbc17, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D1, P2, Z1.D
    FMOV  X23, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X23, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D3, P4, Z3.D
    FMOV  X23, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X23, D4
    MOVZ  X2, #0xf0f2, LSL #0
    MOVK  X2, #0xf0f0, LSL #16
    MOVK  X2, #0xf0f0, LSL #32
    MOVK  X2, #0xf0f0, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D5, P6, Z5.D
    FMOV  X23, D5
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff8, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X23, D6
    MOVZ  X2, #0xd2d2, LSL #0
    MOVK  X2, #0x52d2, LSL #16
    MOVK  X2, #0xfc, LSL #32
    MOVK  X2, #0x10f, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X23, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X23, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X23, D9
    MOVZ  X2, #0xa58d, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa585, LSL #32
    MOVK  X2, #0xa5c5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X23, D10
    MOVZ  X2, #0xf0fb, LSL #0
    MOVK  X2, #0xf0f0, LSL #16
    MOVK  X2, #0xf0f0, LSL #32
    MOVK  X2, #0xf0f0, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D11, P5, Z11.D
    FMOV  X23, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X23, D12
    MOVZ  X2, #0x6960, LSL #0
    MOVK  X2, #0xf06, LSL #16
    MOVK  X2, #0xb4ab, LSL #32
    MOVK  X2, #0x5a50, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X23, D13
    MOVZ  X2, #0xe9e0, LSL #0
    MOVK  X2, #0xf9f1, LSL #16
    MOVK  X2, #0xc9c1, LSL #32
    MOVK  X2, #0xd9d1, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X23, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X23, D15
    MOVZ  X2, #0x6e6e, LSL #0
    MOVK  X2, #0x6c3e, LSL #16
    MOVK  X2, #0xd40d, LSL #32
    MOVK  X2, #0xa679, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X23, D16
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff8, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D17, P0, Z17.D
    FMOV  X23, D17
    MOVZ  X2, #0x4b4a, LSL #0
    MOVK  X2, #0x4b4b, LSL #16
    MOVK  X2, #0xf0f0, LSL #32
    MOVK  X2, #0xf0f0, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X23, D18
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff8, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X23, D19
    MOVZ  X2, #0xa0f9, LSL #0
    MOVK  X2, #0xea45, LSL #16
    MOVK  X2, #0x348f, LSL #32
    MOVK  X2, #0x7ed9, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X23, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D21, P1, Z21.D
    FMOV  X23, D21
    MOVZ  X2, #0xa5b1, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5c5, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X23, D22
    MOVZ  X2, #0xf0ee, LSL #0
    MOVK  X2, #0xf0f0, LSL #16
    MOVK  X2, #0xf0f0, LSL #32
    MOVK  X2, #0xf0f0, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X23, D23
    MOVZ  X2, #0x8648, LSL #0
    MOVK  X2, #0xfce0, LSL #16
    MOVK  X2, #0xa6bb, LSL #32
    MOVK  X2, #0xa50f, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D24, P7, Z24.D
    FMOV  X23, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D25, P4, Z25.D
    FMOV  X23, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X23, D26
    MOVZ  X2, #0x7877, LSL #0
    MOVK  X2, #0x7878, LSL #16
    MOVK  X2, #0xd878, LSL #32
    MOVK  X2, #0xf9f1, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X23, D27
    MOVZ  X2, #0x9af4, LSL #0
    MOVK  X2, #0xe43f, LSL #16
    MOVK  X2, #0x2e89, LSL #32
    MOVK  X2, #0x78d3, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D28, P6, Z28.D
    FMOV  X23, D28
    MOVZ  X2, #0xfd01, LSL #0
    MOVK  X2, #0xf5f9, LSL #16
    MOVK  X2, #0xedf1, LSL #32
    MOVK  X2, #0xe5e9, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D29, P1, Z29.D
    FMOV  X23, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X23, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X23, D31
    MOVZ  X2, #0x9af4, LSL #0
    MOVK  X2, #0xe43f, LSL #16
    MOVK  X2, #0x2e89, LSL #32
    MOVK  X2, #0x78d3, LSL #48
    SUB  X7, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0xb158, LSL #0
    MOVK  X2, #0xc03d, LSL #16
    MOVK  X2, #0x90e0, LSL #32
    MOVK  X2, #0xaa3a, LSL #48
    MOVZ  X3, #0x7401, LSL #0
    MOVK  X3, #0xadda, LSL #16
    MOVK  X3, #0x5ac9, LSL #32
    MOVK  X3, #0xfac6, LSL #48
    MOVZ  X4, #0x1cfe, LSL #0
    MOVK  X4, #0x603e, LSL #16
    MOVK  X4, #0xb807, LSL #32
    MOVK  X4, #0xeff9, LSL #48
    MOVZ  X5, #0xdab2, LSL #0
    MOVK  X5, #0xbbd6, LSL #16
    MOVK  X5, #0x7ffa, LSL #32
    MOVK  X5, #0x71e2, LSL #48
    MOVZ  X6, #0x794b, LSL #0
    MOVK  X6, #0xa026, LSL #16
    MOVK  X6, #0x9e72, LSL #32
    MOVK  X6, #0xa54, LSL #48
    MOVZ  X7, #0xb76b, LSL #0
    MOVK  X7, #0xa9aa, LSL #16
    MOVK  X7, #0xf0, LSL #32
    MOVK  X7, #0xbcb5, LSL #48
    MOVZ  X8, #0x99a0, LSL #0
    MOVK  X8, #0x3ce7, LSL #16
    MOVK  X8, #0x4348, LSL #32
    MOVK  X8, #0x5707, LSL #48
    MOVZ  X9, #0x84a9, LSL #0
    MOVK  X9, #0x5134, LSL #16
    MOVK  X9, #0xc968, LSL #32
    MOVK  X9, #0x317c, LSL #48
    MOVZ  X10, #0x10b, LSL #0
    MOVK  X10, #0x5489, LSL #16
    MOVK  X10, #0x297, LSL #32
    MOVK  X10, #0x87a2, LSL #48
    MOVZ  X11, #0xdffa, LSL #0
    MOVK  X11, #0x5a05, LSL #16
    MOVK  X11, #0x413d, LSL #32
    MOVK  X11, #0x862e, LSL #48
    MOVZ  X12, #0xa500, LSL #0
    MOVK  X12, #0xf497, LSL #16
    MOVK  X12, #0xd7ee, LSL #32
    MOVK  X12, #0xbfd9, LSL #48
    MOVZ  X13, #0xe7db, LSL #0
    MOVK  X13, #0x2032, LSL #16
    MOVK  X13, #0xad4e, LSL #32
    MOVK  X13, #0x6114, LSL #48
    MOVZ  X14, #0x7e3b, LSL #0
    MOVK  X14, #0x63f8, LSL #16
    MOVK  X14, #0x59fd, LSL #32
    MOVK  X14, #0x68ca, LSL #48
    MOVZ  X15, #0x870d, LSL #0
    MOVK  X15, #0x5011, LSL #16
    MOVK  X15, #0x6a1e, LSL #32
    MOVK  X15, #0x1a2b, LSL #48
    MOVZ  X16, #0x6668, LSL #0
    MOVK  X16, #0xee3a, LSL #16
    MOVK  X16, #0x9a14, LSL #32
    MOVK  X16, #0x7dcd, LSL #48
    MOVZ  X17, #0x3399, LSL #0
    MOVK  X17, #0xa5ff, LSL #16
    MOVK  X17, #0x9d1e, LSL #32
    MOVK  X17, #0x409f, LSL #48
    MOVZ  X18, #0xca0a, LSL #0
    MOVK  X18, #0xa1a, LSL #16
    MOVK  X18, #0xd0ab, LSL #32
    MOVK  X18, #0x43db, LSL #48
    MOVZ  X19, #0x1fb5, LSL #0
    MOVK  X19, #0x1a8e, LSL #16
    MOVK  X19, #0x3465, LSL #32
    MOVK  X19, #0xf7d0, LSL #48
    MOVZ  X20, #0xd169, LSL #0
    MOVK  X20, #0x98e, LSL #16
    MOVK  X20, #0x65d1, LSL #32
    MOVK  X20, #0xf16a, LSL #48
    MOVZ  X21, #0xd41e, LSL #0
    MOVK  X21, #0x5bb9, LSL #16
    MOVK  X21, #0xf46c, LSL #32
    MOVK  X21, #0x7e69, LSL #48
    MOVZ  X22, #0x2f79, LSL #0
    MOVK  X22, #0xf38c, LSL #16
    MOVK  X22, #0xd769, LSL #32
    MOVK  X22, #0x4fc8, LSL #48
    MOVZ  X23, #0x66d2, LSL #0
    MOVK  X23, #0x27, LSL #16
    MOVK  X23, #0x60a1, LSL #32
    MOVK  X23, #0x662b, LSL #48
    MOVZ  X24, #0xf94, LSL #0
    MOVK  X24, #0x6ed4, LSL #16
    MOVK  X24, #0xa10a, LSL #32
    MOVK  X24, #0x3859, LSL #48
    DUP     Z0.D, X17
    DUP     Z1.D, X9
    DUP     Z2.D, X24
    DUP     Z3.D, X20
    DUP     Z4.D, X23
    DUP     Z5.D, X21
    DUP     Z6.D, X22
    DUP     Z7.D, X15
    DUP     Z8.D, X2
    DUP     Z9.D, X24
    DUP     Z10.D, X22
    DUP     Z11.D, X14
    DUP     Z12.D, X6
    DUP     Z13.D, X18
    DUP     Z14.D, X2
    DUP     Z15.D, X17
    DUP     Z16.D, X10
    DUP     Z17.D, X2
    DUP     Z18.D, X6
    DUP     Z19.D, X10
    DUP     Z20.D, X8
    DUP     Z21.D, X11
    DUP     Z22.D, X15
    DUP     Z23.D, X10
    DUP     Z24.D, X14
    DUP     Z25.D, X18
    DUP     Z26.D, X16
    DUP     Z27.D, X9
    DUP     Z28.D, X21
    DUP     Z29.D, X7
    DUP     Z30.D, X9
    DUP     Z31.D, X19
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
LCRTSveMoveOperations_label_5:
    INDEX   Z19.D, X8, #-14
    TRN2    Z24.H, Z0.H, Z14.H
    ZIP1    P13.B, P1.B, P4.B
    INDEX   Z30.D, X11, X2
    SUNPKHI Z31.H, Z27.B
    TRN2    Z28.D, Z4.D, Z0.D
    CLASTA  Z28.S, P7, Z28.S, Z19.S
    CLASTB  W8, P6, W8, Z28.B
    UUNPKLO Z24.S, Z29.H
    INDEX   Z20.B, W12, W2
    PUNPKHI P8.H, P5.B
    UUNPKLO Z11.D, Z31.S
    SUNPKHI Z28.S, Z20.H
    UZP1    P13.S, P2.S, P13.S
    ZIP2    P15.B, P0.B, P10.B
    INDEX   Z15.B, #3, #-15
    UZP1    P6.B, P8.B, P9.B
    INDEX   Z19.H, #1, W10
    UZP1    P15.H, P6.H, P13.H
    UZP2    Z8.D, Z30.D, Z24.D
    TRN2    Z9.B, Z27.B, Z15.B
    TRN2    Z9.B, Z11.B, Z19.B
    INDEX   Z31.S, W12, #-5
    SUNPKLO Z12.S, Z1.H
    ZIP1    P1.D, P15.D, P15.D
    INDEX   Z14.D, X22, #-8
    INDEX   Z22.B, W3, W2
    CLASTB  H21, P1, H21, Z28.H
    REV     P7.S, P8.S
    UUNPKHI Z3.S, Z5.H
    INDEX   Z12.B, W22, W11
    CLASTA  H4, P7, H4, Z3.H
    MOV Z31.B,B3
    INDEX   Z14.S, #1, #-7
    INDEX   Z16.H, W10, #-7
    UZP1    P15.B, P8.B, P15.B
    UUNPKLO Z28.D, Z9.S
    INDEX   Z3.S, #5, W8
    INDEX   Z20.H, W10, #-12
    UUNPKLO Z27.S, Z20.H
    INDEX   Z9.B, W24, W4
    UUNPKHI Z19.D, Z8.S
    UZP1    Z1.H, Z9.H, Z14.H
    INDEX   Z5.B, #-12, #-16
    TRN1    P0.B, P0.B, P13.B
    SUNPKHI Z15.D, Z3.S
    REV     Z20.B, Z1.B
    SUNPKLO Z3.S, Z19.H
    MOV     Z19.B, P2/M, B22
    ZIP1    P15.D, P6.D, P9.D
    ZIP2    P4.H, P4.H, P8.H
    PUNPKHI P12.H, P4.B
    INSR    Z20.H, H20
    SUNPKHI Z14.H, Z0.B
    LASTA   W22, P0, Z20.B
    INDEX   Z7.D, #4, X24
    PUNPKHI P8.H, P10.B
    REV     P1.B, P13.B
    INDEX   Z20.B, #-16, W6
    TRN1    P13.D, P11.D, P2.D
    SUNPKLO Z8.D, Z19.S
    PUNPKHI P4.H, P8.B
    SPLICE  Z8.S, P2, Z8.S, Z7.S
    TRN1    Z7.H, Z5.H, Z3.H
    UUNPKLO Z5.D, Z7.S
    INDEX   Z15.H, W21, W23
    TRN1    Z1.S, Z14.S, Z14.S
    REVH    Z23.S, P4/M, Z15.S
    REV     P12.D, P14.D
    SUNPKHI Z19.D, Z5.S
    INDEX   Z23.S, #15, #15
    ZIP2    P4.H, P10.H, P6.H
    UZP1    Z0.B, Z14.B, Z8.B
    INDEX   Z15.H, W22, #-2
    UUNPKLO Z31.H, Z15.B
    INDEX   Z31.H, W20, #14
    TBL     Z14.D,  Z5.D, Z23.D
    INDEX   Z10.B, #-16, #-1
    TRN2    P4.D, P10.D, P9.D
    MOV Z3.D,D31
    INDEX   Z5.H, #15, W16
    LASTB   W23, P2, Z1.S
    UZP1    P14.S, P8.S, P7.S
    INDEX   Z1.D, X8, X13
    LASTB   W10, P6, Z0.B
    INDEX   Z11.S, W14, W20
    UUNPKHI Z8.H, Z21.B
    INDEX   Z12.B, #1, #-13
    INDEX   Z25.B, #13, #8
    ZIP1    P14.B, P2.B, P10.B
    SUNPKLO Z0.D, Z11.S
    REVH    Z20.S, P0/M, Z3.S
    SUNPKLO Z23.H, Z25.B
    PUNPKHI P9.H, P13.B
    UZP2    P8.B, P0.B, P14.B
    REVW    Z3.D, P4/M, Z0.D
    ZIP1    P13.D, P13.D, P12.D
    MOV     Z31.H, P2/M, H20
    SUNPKLO Z1.S, Z12.H
    TRN2    P5.D, P1.D, P11.D
    LASTA   W20, P2, Z5.B
    UZP2    Z15.S, Z31.S, Z3.S
    ZIP1    P11.D, P3.D, P9.D
    PUNPKLO P4.H, P1.B
    SUNPKLO Z25.H, Z12.B
    REV     Z11.H, Z25.H
    INDEX   Z15.H, #-12, #15
    MOV Z31.D,Z23.D[5]
    SUNPKHI Z5.S, Z11.H
    SUNPKLO Z17.S, Z15.H
    UUNPKLO Z3.H, Z1.B
    INDEX   Z11.H, #13, W13
    REV     P13.H, P7.H
    UUNPKHI Z2.D, Z5.S
    TRN2    P6.H, P6.H, P2.H
    ZIP1    Z23.S, Z25.S, Z3.S
    INSR    Z23.S, W18
    SUNPKLO Z1.H, Z14.B
    DUP Z28.H,Z23.H[24]
    UUNPKLO Z3.D, Z8.S
    INDEX   Z12.B, W17, #-16
    INDEX   Z23.B, W5, W22
    INDEX   Z8.D, #7, #-6
    INDEX   Z25.D, X4, X23
    INDEX   Z15.S, #-8, W6
    TBL     Z23.S,  Z9.S, Z28.S
    REVB    Z23.H, P2/M, Z15.H
    SUNPKHI Z5.D, Z31.S
    PUNPKLO P14.H, P12.B
    INDEX   Z28.B, #4, #-13
    UUNPKHI Z9.S, Z22.H
    TRN2    P8.S, P2.S, P11.S
    UUNPKLO Z20.S, Z5.H
    UUNPKHI Z14.D, Z23.S
    SUNPKHI Z17.S, Z14.H
    REV     Z15.S, Z20.S
    UUNPKLO Z23.H, Z0.B
    INDEX   Z31.H, W14, W11
    SUNPKLO Z0.S, Z15.H
    SPLICE  Z0.D, P6, Z0.D, Z12.D
    INDEX   Z3.B, #13, #4
    INDEX   Z8.B, W22, #6
    DUP Z18.H,Z0.H[2]
    UUNPKHI Z14.D, Z31.S
    INDEX   Z14.H, #7, #-1
    UUNPKHI Z31.H, Z1.B
    ZIP2    P10.H, P15.H, P12.H
    REV     P7.D, P6.D
    INDEX   Z28.B, #-8, #-5
    ZIP1    P4.D, P6.D, P12.D
    SUNPKHI Z22.S, Z18.H
    REV     P11.H, P4.H
    LASTB   D15, P2, Z17.D
    UUNPKLO Z29.S, Z23.H
    CLASTB  S1, P3, S1, Z31.S
    SUNPKHI Z5.D, Z8.S
    UUNPKLO Z20.S, Z15.H
    INDEX   Z17.H, W3, W23
    UUNPKHI Z8.D, Z29.S
    INDEX   Z0.S, W6, W24
    TRN2    P13.H, P2.H, P7.H
    TRN1    P10.D, P0.D, P7.D
    INDEX   Z9.D, X20, X4
    INDEX   Z18.H, #-9, #5
    REVW    Z24.D, P0/M, Z17.D
    SUNPKHI Z17.H, Z6.B
    INSR    Z20.H, H0
    INDEX   Z1.H, #-5, #-2
    SUNPKHI Z5.D, Z24.S
    SUNPKHI Z29.H, Z24.B
    INSR    Z9.H, W5
    SUNPKHI Z24.S, Z28.H
    INDEX   Z31.B, W17, #-12
    TRN1    Z24.B, Z5.B, Z31.B
    ZIP1    P7.D, P12.D, P4.D
    CLASTB  Z1.S, P3, Z1.S, Z29.S
    DUP Z9.B,Z1.B[34]
    UZP2    P7.B, P15.B, P0.B
    DUP Z21.B,Z24.B[25]
    SUNPKLO Z26.D, Z9.S
    SUNPKHI Z9.S, Z20.H
    SUNPKLO Z27.S, Z17.H
    UZP2    P7.S, P14.S, P15.S
    ZIP2    P10.D, P4.D, P1.D
    REV     P2.D, P6.D
    CLASTA  X6, P4, X6, Z26.D
    REVB    Z20.H, P4/M, Z21.H
    INDEX   Z4.D, X16, X21
    SUNPKHI Z6.D, Z11.S
    UUNPKLO Z31.D, Z18.S
    SUNPKHI Z9.D, Z13.S
    ZIP2    P4.B, P13.B, P8.B
    INDEX   Z29.B, #1, W10
    INSR    Z24.S, W12
    INDEX   Z19.D, #5, X15
    SUNPKLO Z28.S, Z3.H
    PUNPKLO P13.H, P7.B
    CLASTA  Z20.B, P6, Z20.B, Z25.B
    MOV Z26.B,B19
    SUNPKHI Z21.H, Z6.B
    SUBS  X5, X5, #0x1
    B.NE  LCRTSveMoveOperations_label_5
    MOVZ  X19, #0xb158, LSL #0
    MOVK  X19, #0xc03d, LSL #16
    MOVK  X19, #0x90e0, LSL #32
    MOVK  X19, #0xaa3a, LSL #48
    SUB  X7, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x7401, LSL #0
    MOVK  X19, #0xadda, LSL #16
    MOVK  X19, #0x5ac9, LSL #32
    MOVK  X19, #0xfac6, LSL #48
    SUB  X7, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x1cfe, LSL #0
    MOVK  X19, #0x603e, LSL #16
    MOVK  X19, #0xb807, LSL #32
    MOVK  X19, #0xeff9, LSL #48
    SUB  X7, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xff, LSL #0
    SUB  X7, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xdffa, LSL #0
    MOVK  X19, #0x5a05, LSL #16
    MOVK  X19, #0x413d, LSL #32
    MOVK  X19, #0x862e, LSL #48
    SUB  X7, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xa500, LSL #0
    MOVK  X19, #0xf497, LSL #16
    MOVK  X19, #0xd7ee, LSL #32
    MOVK  X19, #0xbfd9, LSL #48
    SUB  X7, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xe7db, LSL #0
    MOVK  X19, #0x2032, LSL #16
    MOVK  X19, #0xad4e, LSL #32
    MOVK  X19, #0x6114, LSL #48
    SUB  X7, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x7e3b, LSL #0
    MOVK  X19, #0x63f8, LSL #16
    MOVK  X19, #0x59fd, LSL #32
    MOVK  X19, #0x68ca, LSL #48
    SUB  X7, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x870d, LSL #0
    MOVK  X19, #0x5011, LSL #16
    MOVK  X19, #0x6a1e, LSL #32
    MOVK  X19, #0x1a2b, LSL #48
    SUB  X7, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x6668, LSL #0
    MOVK  X19, #0xee3a, LSL #16
    MOVK  X19, #0x9a14, LSL #32
    MOVK  X19, #0x7dcd, LSL #48
    SUB  X7, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x3399, LSL #0
    MOVK  X19, #0xa5ff, LSL #16
    MOVK  X19, #0x9d1e, LSL #32
    MOVK  X19, #0x409f, LSL #48
    SUB  X7, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xca0a, LSL #0
    MOVK  X19, #0xa1a, LSL #16
    MOVK  X19, #0xd0ab, LSL #32
    MOVK  X19, #0x43db, LSL #48
    SUB  X7, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xf, LSL #0
    SUB  X7, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xd41e, LSL #0
    MOVK  X19, #0x5bb9, LSL #16
    MOVK  X19, #0xf46c, LSL #32
    MOVK  X19, #0x7e69, LSL #48
    SUB  X7, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xff, LSL #0
    SUB  X7, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xc, LSL #0
    MOVK  X19, #0x6d, LSL #16
    SUB  X7, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0xf94, LSL #0
    MOVK  X19, #0x6ed4, LSL #16
    MOVK  X19, #0xa10a, LSL #32
    MOVK  X19, #0x3859, LSL #48
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MRS  X19, FPSR
    MOVZ  X7, #0x95, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X7, #0x1f28, LSL #0
    MOVK  X7, #0xdda8, LSL #16
    MOVK  X7, #0x2ebc, LSL #32
    MOVK  X7, #0x4c7c, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D0
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf94, LSL #32
    MOVK  X7, #0x6ed4, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X7, #0xff9d, LSL #0
    MOVK  X7, #0x74, LSL #16
    MOVK  X7, #0xff9d, LSL #32
    MOVK  X7, #0x74, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D1
    MOVZ  X7, #0xff9d, LSL #0
    MOVK  X7, #0x74, LSL #16
    MOVK  X7, #0xff9d, LSL #32
    MOVK  X7, #0x74, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X7, #0xffe7, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D2
    MOVZ  X7, #0xffda, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X7, #0x312d, LSL #0
    MOVK  X7, #0x3935, LSL #16
    MOVK  X7, #0x413d, LSL #32
    MOVK  X7, #0x4945, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D3
    MOVZ  X7, #0x110d, LSL #0
    MOVK  X7, #0x1915, LSL #16
    MOVK  X7, #0x211d, LSL #32
    MOVK  X7, #0x2925, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X7, #0x3a86, LSL #0
    MOVK  X7, #0x49f4, LSL #16
    MOVK  X7, #0x8e81, LSL #32
    MOVK  X7, #0xfc37, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D4
    MOVZ  X7, #0x6668, LSL #0
    MOVK  X7, #0xee3a, LSL #16
    MOVK  X7, #0x9a14, LSL #32
    MOVK  X7, #0x7dcd, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X7, #0x7461, LSL #0
    MOVK  X7, #0x746d, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D5
    MOVZ  X7, #0x7479, LSL #0
    MOVK  X7, #0x7485, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X7, #0xe9b, LSL #0
    MOVK  X7, #0xf676, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D6
    MOVZ  X7, #0x3ee5, LSL #0
    MOVK  X7, #0x26c0, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X7, #0x6474, LSL #0
    MOVK  X7, #0x2434, LSL #32
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D7
    MOVZ  X7, #0xe4f4, LSL #0
    MOVK  X7, #0x101, LSL #16
    MOVK  X7, #0xa4b4, LSL #32
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X7, #0xd0ab, LSL #0
    MOVK  X7, #0x43db, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D9
    MOVZ  X7, #0xca0a, LSL #0
    MOVK  X7, #0xa1a, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X7, #0xe7e8, LSL #0
    MOVK  X7, #0xe5e6, LSL #16
    MOVK  X7, #0xe3e4, LSL #32
    MOVK  X7, #0xe1e2, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D10
    MOVZ  X7, #0xeff0, LSL #0
    MOVK  X7, #0xedee, LSL #16
    MOVK  X7, #0xebec, LSL #32
    MOVK  X7, #0xe9ea, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X7, #0x9f79, LSL #0
    MOVK  X7, #0x8754, LSL #16
    MOVK  X7, #0x6f2f, LSL #32
    MOVK  X7, #0x570a, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D11
    MOVZ  X7, #0xd, LSL #0
    MOVK  X7, #0xe7e8, LSL #16
    MOVK  X7, #0xcfc3, LSL #32
    MOVK  X7, #0xb79e, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X7, #0x919, LSL #0
    MOVK  X7, #0xe9f9, LSL #16
    MOVK  X7, #0xc9d9, LSL #32
    MOVK  X7, #0xa9b9, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D12
    MOVZ  X7, #0x8999, LSL #0
    MOVK  X7, #0x6979, LSL #16
    MOVK  X7, #0x4959, LSL #32
    MOVK  X7, #0x2939, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X7, #0xca0a, LSL #0
    MOVK  X7, #0xa1a, LSL #16
    MOVK  X7, #0xd0ab, LSL #32
    MOVK  X7, #0x43db, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D13
    MOVZ  X7, #0xca0a, LSL #0
    MOVK  X7, #0xa1a, LSL #16
    MOVK  X7, #0xd0ab, LSL #32
    MOVK  X7, #0x43db, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X7, #0x3, LSL #0
    MOVK  X7, #0x2, LSL #16
    MOVK  X7, #0x1, LSL #32
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D14
    MOVZ  X7, #0x7, LSL #0
    MOVK  X7, #0x6, LSL #16
    MOVK  X7, #0x5, LSL #32
    MOVK  X7, #0x4, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D15
    MOVZ  X7, #0xf8ff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X7, #0xffe4, LSL #0
    MOVK  X7, #0xffdd, LSL #16
    MOVK  X7, #0xffd6, LSL #32
    MOVK  X7, #0xffcf, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D16
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xfff9, LSL #16
    MOVK  X7, #0xfff2, LSL #32
    MOVK  X7, #0xffeb, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D17
    MOVZ  X7, #0x51, LSL #0
    MOVK  X7, #0xffde, LSL #16
    MOVK  X7, #0x2c, LSL #32
    MOVK  X7, #0xffc6, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X7, #0xb, LSL #0
    MOVK  X7, #0x10, LSL #16
    MOVK  X7, #0x15, LSL #32
    MOVK  X7, #0x1a, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D18
    MOVZ  X7, #0xfff7, LSL #0
    MOVK  X7, #0xfffc, LSL #16
    MOVK  X7, #0x1, LSL #32
    MOVK  X7, #0x6, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X7, #0x8712, LSL #0
    MOVK  X7, #0x5011, LSL #16
    MOVK  X7, #0x6a1e, LSL #32
    MOVK  X7, #0x1a2b, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D19
    MOVZ  X7, #0x5, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X7, #0xfefe, LSL #0
    MOVK  X7, #0xfefe, LSL #16
    MOVK  X7, #0xfefe, LSL #32
    MOVK  X7, #0xfefe, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D20
    MOVZ  X7, #0xfefe, LSL #0
    MOVK  X7, #0xfefe, LSL #16
    MOVK  X7, #0xfefe, LSL #32
    MOVK  X7, #0xfefe, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D21
    MOVZ  X7, #0x51, LSL #0
    MOVK  X7, #0xffde, LSL #16
    MOVK  X7, #0x2c, LSL #32
    MOVK  X7, #0xffc6, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D23
    MOVZ  X7, #0x3b, LSL #0
    MOVK  X7, #0x7e, LSL #16
    MOVK  X7, #0xf8, LSL #32
    MOVK  X7, #0x63, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X7, #0x6900, LSL #0
    MOVK  X7, #0x5100, LSL #16
    MOVK  X7, #0x3961, LSL #32
    MOVK  X7, #0x216d, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D24
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xf497, LSL #16
    MOVK  X7, #0x9979, LSL #32
    MOVK  X7, #0x8185, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X7, #0x1d0a, LSL #0
    MOVK  X7, #0x60ab, LSL #16
    MOVK  X7, #0xb807, LSL #32
    MOVK  X7, #0xeff9, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D25
    MOVZ  X7, #0x1cfe, LSL #0
    MOVK  X7, #0x603e, LSL #16
    MOVK  X7, #0xb807, LSL #32
    MOVK  X7, #0xeff9, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X7, #0x505, LSL #0
    MOVK  X7, #0x505, LSL #16
    MOVK  X7, #0x505, LSL #32
    MOVK  X7, #0x505, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D26
    MOVZ  X7, #0x505, LSL #0
    MOVK  X7, #0x505, LSL #16
    MOVK  X7, #0x505, LSL #32
    MOVK  X7, #0x505, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X7, #0x2c, LSL #0
    MOVK  X7, #0xffc6, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D27
    MOVZ  X7, #0x51, LSL #0
    MOVK  X7, #0xffde, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X7, #0x211d, LSL #0
    MOVK  X7, #0x2925, LSL #32
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D28
    MOVZ  X7, #0x110d, LSL #0
    MOVK  X7, #0x1915, LSL #32
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X7, #0x101, LSL #0
    MOVK  X7, #0x101, LSL #16
    MOVK  X7, #0x101, LSL #32
    MOVK  X7, #0x101, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D29
    MOVZ  X7, #0x101, LSL #0
    MOVK  X7, #0x101, LSL #16
    MOVK  X7, #0x101, LSL #32
    MOVK  X7, #0x101, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X7, #0x9152, LSL #0
    MOVK  X7, #0x1a43, LSL #16
    MOVK  X7, #0xd21e, LSL #32
    MOVK  X7, #0x3068, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D30
    MOVZ  X7, #0xdffa, LSL #0
    MOVK  X7, #0x5a05, LSL #16
    MOVK  X7, #0x413d, LSL #32
    MOVK  X7, #0x862e, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X7, #0x1, LSL #0
    MOVK  X7, #0x6, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FMOV  X19, D31
    MOVZ  X7, #0xfff7, LSL #0
    MOVK  X7, #0xfffc, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xdfdf, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xefff, LSL #0
    MOVK  X7, #0xf3f3, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xccff, LSL #0
    MOVK  X7, #0xfccf, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xfffd, LSL #0
    MOVK  X7, #0x55ff, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xfbef, LSL #0
    MOVK  X7, #0x3ff3, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xcffc, LSL #0
    MOVK  X7, #0xffcc, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x30f, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xcff, LSL #0
    MOVK  X7, #0xffe, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5455, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xf3cf, LSL #0
    MOVK  X7, #0xf301, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xf340, LSL #0
    MOVK  X7, #0x3f00, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0x100, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x1, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X7, #0xf3, LSL #0
    MOVK  X7, #0x3f, LSL #16
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
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
    FMOV  X19, D0
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf94, LSL #32
    MOVK  X7, #0x6ed4, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X19, D1
    MOVZ  X7, #0xff9d, LSL #0
    MOVK  X7, #0x74, LSL #16
    MOVK  X7, #0xff9d, LSL #32
    MOVK  X7, #0x94, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X19, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X19, D3
    MOVZ  X7, #0x514c, LSL #0
    MOVK  X7, #0x5955, LSL #16
    MOVK  X7, #0x615d, LSL #32
    MOVK  X7, #0x6965, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X19, D4
    MOVZ  X7, #0x25c7, LSL #0
    MOVK  X7, #0xe273, LSL #16
    MOVK  X7, #0x9a14, LSL #32
    MOVK  X7, #0x7dcd, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X19, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X19, D6
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X19, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X19, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X19, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X19, D10
    MOVZ  X7, #0xeff0, LSL #0
    MOVK  X7, #0xedee, LSL #16
    MOVK  X7, #0xebec, LSL #32
    MOVK  X7, #0xe9ea, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D11, P5, Z11.D
    FMOV  X19, D11
    MOVZ  X7, #0x3ee4, LSL #0
    MOVK  X7, #0x26c0, LSL #16
    MOVK  X7, #0xe9b, LSL #32
    MOVK  X7, #0xf676, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X19, D12
    MOVZ  X7, #0x8f8f, LSL #0
    MOVK  X7, #0x908f, LSL #16
    MOVK  X7, #0xb090, LSL #32
    MOVK  X7, #0xa9c9, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X19, D13
    MOVZ  X7, #0xca0a, LSL #0
    MOVK  X7, #0xa1a, LSL #16
    MOVK  X7, #0xd0ab, LSL #32
    MOVK  X7, #0x43fb, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D14, P5, Z14.D
    FMOV  X19, D14
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X19, D15
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D16, P1, Z16.D
    FMOV  X19, D16
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffef, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D17, P2, Z17.D
    FMOV  X19, D17
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X19, D18
    MOVZ  X7, #0x3b, LSL #0
    MOVK  X7, #0xe043, LSL #16
    MOVK  X7, #0xc049, LSL #32
    MOVK  X7, #0x4c, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X19, D19
    MOVZ  X7, #0x952c, LSL #0
    MOVK  X7, #0xf034, LSL #16
    MOVK  X7, #0x3e5a, LSL #32
    MOVK  X7, #0x4e82, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X19, D20
    MOVZ  X7, #0xfefe, LSL #0
    MOVK  X7, #0xfefe, LSL #16
    MOVK  X7, #0xfefe, LSL #32
    MOVK  X7, #0xff1e, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D21, P4, Z21.D
    FMOV  X19, D21
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X19, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X19, D23
    MOVZ  X7, #0x42, LSL #0
    MOVK  X7, #0x7e, LSL #16
    MOVK  X7, #0xf8, LSL #32
    MOVK  X7, #0x73, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D24, P7, Z24.D
    FMOV  X19, D24
    MOVZ  X7, #0xa8ff, LSL #0
    MOVK  X7, #0x9100, LSL #16
    MOVK  X7, #0x7991, LSL #32
    MOVK  X7, #0x619d, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X19, D25
    MOVZ  X7, #0x9d10, LSL #0
    MOVK  X7, #0x60e1, LSL #16
    MOVK  X7, #0xb807, LSL #32
    MOVK  X7, #0xf019, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X19, D26
    MOVZ  X7, #0x505, LSL #0
    MOVK  X7, #0x505, LSL #16
    MOVK  X7, #0x505, LSL #32
    MOVK  X7, #0x525, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D27, P3, Z27.D
    FMOV  X19, D27
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X19, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X19, D29
    MOVZ  X7, #0x101, LSL #0
    MOVK  X7, #0x101, LSL #16
    MOVK  X7, #0x101, LSL #32
    MOVK  X7, #0x121, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X19, D30
    MOVZ  X7, #0x42a9, LSL #0
    MOVK  X7, #0xda81, LSL #16
    MOVK  X7, #0x62fe, LSL #32
    MOVK  X7, #0xdaa3, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X19, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    DUP     Z0.D, X17
    DUP     Z1.D, X6
    DUP     Z2.D, X14
    DUP     Z3.D, X23
    DUP     Z4.D, X19
    DUP     Z5.D, X20
    DUP     Z6.D, X5
    DUP     Z7.D, X16
    DUP     Z8.D, X13
    DUP     Z9.D, X18
    DUP     Z10.D, X22
    DUP     Z11.D, X12
    DUP     Z12.D, X24
    DUP     Z13.D, X21
    DUP     Z14.D, X8
    DUP     Z15.D, X14
    DUP     Z16.D, X13
    DUP     Z17.D, X8
    DUP     Z18.D, X12
    DUP     Z19.D, X2
    DUP     Z20.D, X14
    DUP     Z21.D, X6
    DUP     Z22.D, X19
    DUP     Z23.D, X22
    DUP     Z24.D, X23
    DUP     Z25.D, X7
    DUP     Z26.D, X9
    DUP     Z27.D, X10
    DUP     Z28.D, X12
    DUP     Z29.D, X11
    DUP     Z30.D, X4
    DUP     Z31.D, X12
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
LCRTSveMoveOperations_label_6:
    REV     P8.S, P11.S
    UUNPKLO Z30.D, Z24.S
    INDEX   Z7.H, W2, #14
    UUNPKHI Z2.S, Z7.H
    LASTB   W12, P1, Z30.S
    MOV     Z20.B, P7/M, B2
    UZP1    P1.H, P14.H, P4.H
    REV     P2.S, P6.S
    UZP1    P7.B, P8.B, P9.B
    INDEX   Z28.H, W11, #2
    MOV     Z9.B, P0/M, B30
    UUNPKHI Z20.D, Z20.S
    INDEX   Z14.D, #-8, #-9
    CLASTB  Z14.D, P1, Z14.D, Z28.D
    INDEX   Z5.H, W6, #-2
    PUNPKLO P5.H, P5.B
    MOV Z13.B,B9
    UZP1    P2.B, P12.B, P0.B
    LASTB   W17, P5, Z13.S
    UUNPKHI Z21.H, Z14.B
    SUNPKHI Z24.H, Z20.B
    MOV     Z18.S, P7/M, S5
    REV     P9.B, P2.B
    INDEX   Z1.H, W22, #-10
    ZIP1    P7.B, P9.B, P9.B
    LASTA   W20, P7, Z24.H
    ZIP2    P9.H, P0.H, P1.H
    ZIP1    P4.H, P9.H, P7.H
    INDEX   Z4.B, #4, #-5
    TRN1    P6.D, P4.D, P4.D
    MOV Z25.Q,Q19
    UUNPKHI Z27.H, Z21.B
    TBL     Z15.D,  Z25.D, Z29.D
    UZP1    P2.H, P11.H, P12.H
    INDEX   Z2.H, #-8, W21
    CLASTA  W12, P6, W12, Z1.S
    LASTA   D23, P2, Z18.D
    UUNPKLO Z18.S, Z2.H
    UUNPKHI Z29.D, Z23.S
    INDEX   Z1.D, X3, X9
    UZP1    P3.B, P6.B, P8.B
    SUNPKLO Z24.S, Z17.H
    UZP2    Z0.B, Z21.B, Z15.B
    PUNPKLO P12.H, P1.B
    INDEX   Z21.S, #8, W9
    ZIP2    P0.S, P15.S, P14.S
    REV     Z2.B, Z11.B
    PUNPKLO P3.H, P10.B
    INDEX   Z13.D, X13, X6
    INDEX   Z11.H, #13, W15
    ZIP1    P12.S, P8.S, P1.S
    INDEX   Z23.B, #8, W2
    REV     Z23.H, Z23.H
    SUNPKLO Z17.D, Z29.S
    UUNPKLO Z2.H, Z27.B
    INDEX   Z15.B, #-5, #0
    LASTA   B22, P4, Z5.B
    UZP2    P4.H, P13.H, P9.H
    INDEX   Z5.B, W18, W7
    CLASTA  W2, P7, W2, Z2.B
    INDEX   Z2.S, W13, W9
    INDEX   Z25.D, X17, X11
    SUNPKLO Z27.D, Z13.S
    UUNPKHI Z31.S, Z27.H
    SUNPKLO Z11.D, Z25.S
    UZP1    P5.S, P13.S, P15.S
    TBL     Z20.B,  Z11.B, Z1.B
    INDEX   Z11.D, X13, X17
    INDEX   Z12.H, #1, W17
    UUNPKHI Z22.H, Z12.B
    CLASTB  X11, P0, X11, Z2.D
    INDEX   Z19.S, #10, W24
    REVH    Z23.D, P7/M, Z19.D
    UZP2    P5.D, P2.D, P10.D
    INDEX   Z6.S, W21, #11
    UZP1    P14.D, P12.D, P8.D
    INDEX   Z26.D, #-6, X8
    SUNPKHI Z10.H, Z31.B
    INDEX   Z18.B, W12, #10
    INDEX   Z6.B, W5, #4
    INDEX   Z24.B, W6, #-8
    INDEX   Z31.B, #14, W21
    UUNPKLO Z19.S, Z18.H
    ZIP1    P15.H, P10.H, P15.H
    ZIP1    Z12.B, Z31.B, Z22.B
    CLASTA  X13, P5, X13, Z6.D
    INDEX   Z24.S, #-15, #-5
    UUNPKHI Z19.H, Z18.B
    UZP1    P3.B, P11.B, P7.B
    INDEX   Z31.H, W15, #13
    TRN1    P1.H, P3.H, P7.H
    TRN2    P12.S, P0.S, P7.S
    UZP1    P5.B, P5.B, P0.B
    SUNPKHI Z26.S, Z24.H
    UUNPKLO Z20.D, Z26.S
    ZIP1    P9.S, P9.S, P4.S
    INDEX   Z4.H, #-1, W22
    INDEX   Z20.H, #6, #14
    INDEX   Z7.B, #-2, #-1
    PUNPKLO P8.H, P5.B
    INDEX   Z3.D, #13, X24
    SPLICE  Z12.D, P7, Z12.D, Z19.D
    REVB    Z11.D, P1/M, Z7.D
    TRN1    P15.S, P10.S, P3.S
    INDEX   Z25.B, #8, #-6
    CLASTA  Z12.D, P7, Z12.D, Z4.D
    UUNPKLO Z21.D, Z11.S
    SUNPKLO Z16.H, Z12.B
    INDEX   Z8.D, #3, X13
    INDEX   Z21.D, #-11, X7
    INDEX   Z21.S, #-2, #-8
    LASTA   D1, P1, Z17.D
    INDEX   Z17.S, W21, #4
    SUNPKLO Z12.D, Z1.S
    TRN1    P5.B, P8.B, P10.B
    INDEX   Z20.H, W24, W21
    INDEX   Z29.D, X22, #-12
    INDEX   Z25.H, #-12, #-15
    SUNPKLO Z19.H, Z26.B
    SPLICE  Z19.B, P1, Z19.B, Z19.B
    INDEX   Z30.H, #5, W15
    INDEX   Z30.D, X3, X24
    INDEX   Z16.H, W21, W13
    SUNPKLO Z20.D, Z17.S
    CLASTA  Z12.D, P1, Z12.D, Z19.D
    TRN2    P10.H, P15.H, P10.H
    SUNPKHI Z27.H, Z16.B
    REV     P1.S, P7.S
    INDEX   Z14.S, W17, W8
    INDEX   Z25.B, #12, W2
    UUNPKHI Z24.H, Z30.B
    UUNPKLO Z26.H, Z12.B
    TRN2    P13.D, P5.D, P15.D
    REVB    Z7.S, P0/M, Z24.S
    ZIP1    P12.S, P3.S, P1.S
    DUP Z0.H,Z6.H[29]
    REVH    Z20.S, P0/M, Z7.S
    REVH    Z30.S, P6/M, Z12.S
    PUNPKHI P8.H, P3.B
    PUNPKLO P7.H, P8.B
    UUNPKLO Z20.S, Z17.H
    UUNPKHI Z14.D, Z29.S
    ZIP1    P5.D, P0.D, P0.D
    INDEX   Z2.S, #10, W24
    ZIP1    P12.S, P2.S, P7.S
    SPLICE  Z27.B, P1, Z27.B, Z2.B
    CLASTA  Z29.H, P0, Z29.H, Z4.H
    INDEX   Z0.D, #7, #-9
    REV     P6.S, P15.S
    INDEX   Z5.H, #-2, W21
    INDEX   Z29.D, #-11, #-1
    UZP1    P7.H, P14.H, P14.H
    UZP1    P15.H, P3.H, P13.H
    UUNPKHI Z0.H, Z30.B
    ZIP2    Z21.B, Z27.B, Z0.B
    SUNPKHI Z5.S, Z21.H
    TRN2    P11.D, P11.D, P0.D
    SUNPKLO Z10.S, Z14.H
    CLASTB  Z25.H, P1, Z25.H, Z0.H
    TBL     Z12.S,  Z26.S, Z5.S
    SUNPKHI Z27.S, Z31.H
    CLASTA  Z12.S, P0, Z12.S, Z28.S
    TRN1    P2.B, P2.B, P3.B
    UZP2    Z0.D, Z12.D, Z29.D
    CLASTB  W14, P4, W14, Z10.H
    TRN1    P10.D, P1.D, P14.D
    UUNPKLO Z14.D, Z27.S
    TRN2    P9.S, P11.S, P5.S
    SUNPKLO Z27.S, Z20.H
    UUNPKHI Z10.S, Z0.H
    PUNPKHI P3.H, P15.B
    UUNPKHI Z30.D, Z11.S
    INDEX   Z4.B, W2, #-7
    UUNPKHI Z26.H, Z4.B
    INDEX   Z8.D, X8, #-10
    SUNPKLO Z28.S, Z26.H
    INDEX   Z0.S, #3, W11
    TRN2    Z21.H, Z14.H, Z28.H
    UUNPKLO Z14.S, Z27.H
    CLASTB  B8, P0, B8, Z5.B
    DUP Z31.S,Z10.S[4]
    TBL     Z4.S,  Z31.S, Z30.S
    INDEX   Z11.H, #-12, #1
    TRN1    P11.B, P2.B, P8.B
    INDEX   Z27.S, W17, #-4
    INDEX   Z31.B, #-15, #5
    INDEX   Z20.S, W8, W19
    UUNPKHI Z14.D, Z21.S
    UUNPKLO Z28.D, Z0.S
    PUNPKHI P7.H, P0.B
    TRN1    P5.D, P10.D, P6.D
    TRN1    P8.D, P8.D, P14.D
    TRN1    P6.S, P8.S, P0.S
    TRN1    Z3.S, Z21.S, Z26.S
    TRN2    P9.D, P10.D, P14.D
    INDEX   Z2.D, X3, #-5
    SUNPKHI Z27.D, Z20.S
    ZIP2    P7.S, P10.S, P12.S
    INDEX   Z20.D, #14, #9
    UUNPKHI Z22.H, Z28.B
    SUBS  X8, X8, #0x1
    B.NE  LCRTSveMoveOperations_label_6
    MOVZ  X23, #0x18, LSL #0
    SUB  X16, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x400, LSL #0
    MOVK  X23, #0xc08, LSL #16
    MOVK  X23, #0x400, LSL #32
    MOVK  X23, #0xc08, LSL #48
    SUB  X16, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xfff6, LSL #16
    SUB  X16, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x400, LSL #0
    MOVK  X23, #0xc08, LSL #16
    MOVK  X23, #0x1410, LSL #32
    MOVK  X23, #0x1c18, LSL #48
    SUB  X16, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0xff88, LSL #0
    SUB  X16, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MRS  X23, FPSR
    MOVZ  X16, #0x95, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X16, #0x803, LSL #0
    MOVK  X16, #0x1810, LSL #16
    MOVK  X16, #0xc03, LSL #32
    MOVK  X16, #0x2418, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D0
    MOVZ  X16, #0x3, LSL #0
    MOVK  X16, #0x403, LSL #32
    MOVK  X16, #0xc08, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X16, #0xfffb, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8c, LSL #32
    MOVK  X16, #0x85, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D3
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa8, LSL #32
    MOVK  X16, #0xa1, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xfff2, LSL #32
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D4
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xfff2, LSL #32
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X16, #0xff38, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D5
    MOVZ  X16, #0xff00, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X16, #0x2420, LSL #0
    MOVK  X16, #0x2c28, LSL #16
    MOVK  X16, #0x3430, LSL #32
    MOVK  X16, #0x3c38, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D6
    MOVZ  X16, #0x400, LSL #0
    MOVK  X16, #0xc08, LSL #16
    MOVK  X16, #0x1410, LSL #32
    MOVK  X16, #0x1c18, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #32
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D10
    MOVZ  X16, #0xfff4, LSL #0
    MOVK  X16, #0xffff, LSL #32
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X16, #0xfff8, LSL #0
    MOVK  X16, #0xfff9, LSL #16
    MOVK  X16, #0xfffa, LSL #32
    MOVK  X16, #0xfffb, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D11
    MOVZ  X16, #0xfff4, LSL #0
    MOVK  X16, #0xfff5, LSL #16
    MOVK  X16, #0xfff6, LSL #32
    MOVK  X16, #0xfff7, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X16, #0x400, LSL #0
    MOVK  X16, #0x402, LSL #16
    MOVK  X16, #0x400, LSL #32
    MOVK  X16, #0x402, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D12
    MOVZ  X16, #0x400, LSL #0
    MOVK  X16, #0x402, LSL #16
    MOVK  X16, #0x400, LSL #32
    MOVK  X16, #0x402, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X16, #0x400, LSL #0
    MOVK  X16, #0xc08, LSL #16
    MOVK  X16, #0x1410, LSL #32
    MOVK  X16, #0x1c18, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D13
    MOVZ  X16, #0x400, LSL #0
    MOVK  X16, #0xc08, LSL #16
    MOVK  X16, #0x1410, LSL #32
    MOVK  X16, #0x1c18, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X16, #0xfbfb, LSL #0
    MOVK  X16, #0xfbfb, LSL #16
    MOVK  X16, #0xfbfb, LSL #32
    MOVK  X16, #0xfbfb, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D15
    MOVZ  X16, #0xfbfb, LSL #0
    MOVK  X16, #0xfbfb, LSL #16
    MOVK  X16, #0xfbfb, LSL #32
    MOVK  X16, #0xfbfb, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X16, #0x1000, LSL #0
    MOVK  X16, #0x1400, LSL #16
    MOVK  X16, #0x1800, LSL #32
    MOVK  X16, #0x1c00, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D16
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x400, LSL #16
    MOVK  X16, #0x800, LSL #32
    MOVK  X16, #0xc00, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X16, #0x8, LSL #0
    MOVK  X16, #0xc, LSL #32
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D17
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4, LSL #32
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X16, #0x5a50, LSL #0
    MOVK  X16, #0x6e64, LSL #16
    MOVK  X16, #0x8278, LSL #32
    MOVK  X16, #0x968c, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D18
    MOVZ  X16, #0xa00, LSL #0
    MOVK  X16, #0x1e14, LSL #16
    MOVK  X16, #0x3228, LSL #32
    MOVK  X16, #0x463c, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D19
    MOVZ  X16, #0xffdd, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X16, #0x17, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D20
    MOVZ  X16, #0xe, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D22
    MOVZ  X16, #0x3, LSL #0
    MOVK  X16, #0x8, LSL #16
    MOVK  X16, #0x10, LSL #32
    MOVK  X16, #0x18, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa, LSL #16
    MOVK  X16, #0xa, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D23
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa, LSL #16
    MOVK  X16, #0xa, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X16, #0xff, LSL #0
    MOVK  X16, #0xff, LSL #16
    MOVK  X16, #0xff, LSL #32
    MOVK  X16, #0xff, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D25
    MOVZ  X16, #0xff, LSL #0
    MOVK  X16, #0xff, LSL #16
    MOVK  X16, #0xff, LSL #32
    MOVK  X16, #0xff, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X16, #0x8c, LSL #0
    MOVK  X16, #0x85, LSL #16
    MOVK  X16, #0x7e, LSL #32
    MOVK  X16, #0x77, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D26
    MOVZ  X16, #0xa8, LSL #0
    MOVK  X16, #0xa1, LSL #16
    MOVK  X16, #0x9a, LSL #32
    MOVK  X16, #0x93, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X16, #0x1, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D27
    MOVZ  X16, #0x1, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X16, #0x403, LSL #0
    MOVK  X16, #0xc08, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D28
    MOVZ  X16, #0x3, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X16, #0xfff4, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D29
    MOVZ  X16, #0xfff5, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X16, #0xeceb, LSL #0
    MOVK  X16, #0xeeed, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D30
    MOVZ  X16, #0xe8e7, LSL #0
    MOVK  X16, #0xeae9, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X16, #0x1e19, LSL #0
    MOVK  X16, #0x2823, LSL #16
    MOVK  X16, #0x322d, LSL #32
    MOVK  X16, #0x3c37, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FMOV  X23, D31
    MOVZ  X16, #0xf6f1, LSL #0
    MOVK  X16, #0xfb, LSL #16
    MOVK  X16, #0xa05, LSL #32
    MOVK  X16, #0x140f, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0x5555, LSL #0
    MOVK  X16, #0x5555, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xfff5, LSL #0
    MOVK  X16, #0xfff5, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0x1fff, LSL #0
    MOVK  X16, #0x1fff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xff55, LSL #0
    MOVK  X16, #0xff55, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0x1f1f, LSL #0
    MOVK  X16, #0x1f1f, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
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
    FMOV  X23, D0
    MOVZ  X16, #0x1803, LSL #0
    MOVK  X16, #0x4830, LSL #16
    MOVK  X16, #0x1c03, LSL #32
    MOVK  X16, #0x5438, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D1, P3, Z1.D
    FMOV  X23, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D2, P2, Z2.D
    FMOV  X23, D2
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D3, P0, Z3.D
    FMOV  X23, D3
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5000, LSL #16
    MOVK  X16, #0x44d3, LSL #32
    MOVK  X16, #0xa8, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X23, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D5, P6, Z5.D
    FMOV  X23, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X23, D6
    MOVZ  X16, #0x6460, LSL #0
    MOVK  X16, #0x6c68, LSL #16
    MOVK  X16, #0x7470, LSL #32
    MOVK  X16, #0x7c78, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X23, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X23, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X23, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X23, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X23, D11
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X23, D12
    MOVZ  X16, #0x400, LSL #0
    MOVK  X16, #0x402, LSL #16
    MOVK  X16, #0x400, LSL #32
    MOVK  X16, #0x422, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X23, D13
    MOVZ  X16, #0x400, LSL #0
    MOVK  X16, #0xc08, LSL #16
    MOVK  X16, #0x1410, LSL #32
    MOVK  X16, #0x1c38, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X23, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X23, D15
    MOVZ  X16, #0xfbfb, LSL #0
    MOVK  X16, #0xfbfb, LSL #16
    MOVK  X16, #0xfbfb, LSL #32
    MOVK  X16, #0xfc1b, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X23, D16
    MOVZ  X16, #0x3000, LSL #0
    MOVK  X16, #0x3400, LSL #16
    MOVK  X16, #0x3800, LSL #32
    MOVK  X16, #0x3c00, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D17, P2, Z17.D
    FMOV  X23, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X23, D18
    MOVZ  X16, #0xaa9e, LSL #0
    MOVK  X16, #0xbeb4, LSL #16
    MOVK  X16, #0xd2c8, LSL #32
    MOVK  X16, #0xe6dc, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X23, D19
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D20, P7, Z20.D
    FMOV  X23, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X23, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X23, D22
    MOVZ  X16, #0x2, LSL #0
    MOVK  X16, #0x8, LSL #16
    MOVK  X16, #0x10, LSL #32
    MOVK  X16, #0x30, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X23, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X23, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D25, P7, Z25.D
    FMOV  X23, D25
    MOVZ  X16, #0xff, LSL #0
    MOVK  X16, #0xff, LSL #16
    MOVK  X16, #0xff, LSL #32
    MOVK  X16, #0x11f, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X23, D26
    MOVZ  X16, #0x4d3, LSL #0
    MOVK  X16, #0xb8ca, LSL #16
    MOVK  X16, #0xecc0, LSL #32
    MOVK  X16, #0x9a, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X23, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X23, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D29, P0, Z29.D
    FMOV  X23, D29
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X23, D30
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X23, D31
    MOVZ  X16, #0x4640, LSL #0
    MOVK  X16, #0x504b, LSL #16
    MOVK  X16, #0x5a55, LSL #32
    MOVK  X16, #0x645f, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    DUP     Z0.D, X3
    DUP     Z1.D, X21
    DUP     Z2.D, X20
    DUP     Z3.D, X24
    DUP     Z4.D, X23
    DUP     Z5.D, X22
    DUP     Z6.D, X11
    DUP     Z7.D, X11
    DUP     Z8.D, X4
    DUP     Z9.D, X22
    DUP     Z10.D, X23
    DUP     Z11.D, X14
    DUP     Z12.D, X9
    DUP     Z13.D, X21
    DUP     Z14.D, X12
    DUP     Z15.D, X2
    DUP     Z16.D, X6
    DUP     Z17.D, X18
    DUP     Z18.D, X13
    DUP     Z19.D, X3
    DUP     Z20.D, X2
    DUP     Z21.D, X14
    DUP     Z22.D, X22
    DUP     Z23.D, X18
    DUP     Z24.D, X14
    DUP     Z25.D, X22
    DUP     Z26.D, X15
    DUP     Z27.D, X3
    DUP     Z28.D, X3
    DUP     Z29.D, X6
    DUP     Z30.D, X14
    DUP     Z31.D, X22
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
    MOVZ  X13, #0xa, LSL #0
LCRTSveMoveOperations_label_7:
    INDEX   Z27.S, #-6, #9
    REV     Z7.B, Z31.B
    INDEX   Z2.S, W23, W23
    INDEX   Z1.B, W3, W19
    UZP2    P1.S, P2.S, P9.S
    CLASTA  Z7.S, P6, Z7.S, Z21.S
    INDEX   Z18.H, #-9, W8
    ZIP2    P7.S, P4.S, P14.S
    TRN1    P4.B, P5.B, P6.B
    SUNPKHI Z26.S, Z25.H
    UZP1    P4.B, P10.B, P8.B
    INSR    Z5.H, H24
    INDEX   Z31.S, W16, #14
    UZP2    Z31.S, Z18.S, Z26.S
    INDEX   Z1.D, #-6, X20
    LASTB   W23, P1, Z21.H
    SUNPKHI Z9.H, Z2.B
    UZP2    P2.H, P4.H, P5.H
    DUP Z25.H,Z7.H[11]
    INDEX   Z4.D, X15, #-7
    UZP2    Z20.D, Z11.D, Z7.D
    ZIP2    Z20.H, Z5.H, Z1.H
    SUNPKLO Z31.H, Z20.B
    INDEX   Z21.S, #7, W23
    ZIP1    P6.D, P4.D, P11.D
    INDEX   Z28.B, #-13, W12
    TRN2    P9.B, P7.B, P1.B
    INDEX   Z24.D, #-11, #11
    REV     P2.H, P15.H
    CLASTA  B27, P6, B27, Z21.B
    INDEX   Z26.D, X10, X14
    UZP2    P13.D, P9.D, P9.D
    UZP1    P12.D, P0.D, P6.D
    SUNPKLO Z16.H, Z5.B
    UZP1    Z21.H, Z22.H, Z4.H
    SUNPKHI Z9.H, Z31.B
    INDEX   Z29.H, W12, #12
    UZP1    Z16.H, Z4.H, Z22.H
    ZIP2    P5.B, P6.B, P6.B
    ZIP1    P9.H, P15.H, P12.H
    DUP Z5.B,Z27.B[14]
    UZP1    P0.B, P13.B, P15.B
    INSR    Z5.S, W24
    ZIP1    Z21.H, Z9.H, Z7.H
    INDEX   Z28.S, W20, #-10
    ZIP1    Z28.D, Z21.D, Z26.D
    SUNPKHI Z0.H, Z16.B
    PUNPKHI P15.H, P14.B
    INDEX   Z10.B, W18, #-14
    PUNPKHI P10.H, P7.B
    TRN2    P13.B, P2.B, P4.B
    INDEX   Z4.B, #-12, W22
    UUNPKHI Z29.S, Z10.H
    INDEX   Z18.B, W4, #11
    INDEX   Z7.D, #7, #14
    ZIP2    P2.B, P5.B, P12.B
    UUNPKLO Z26.S, Z5.H
    PUNPKHI P15.H, P0.B
    INDEX   Z31.S, #-10, W2
    UZP1    P7.D, P4.D, P13.D
    MOV Z25.H,H18
    ZIP1    Z25.D, Z6.D, Z25.D
    UZP1    P5.B, P14.B, P2.B
    INDEX   Z6.S, W7, #-4
    INDEX   Z8.B, #-15, #-16
    INDEX   Z23.B, W12, W24
    INDEX   Z17.S, W13, W13
    INDEX   Z8.D, #-5, X12
    MOV     Z17.H, P6/M, H6
    TRN2    Z15.D, Z16.D, Z14.D
    TRN1    P13.S, P15.S, P6.S
    UUNPKHI Z18.H, Z25.B
    REV     P1.D, P0.D
    TBL     Z14.S,  Z24.S, Z15.S
    REV     P5.S, P12.S
    UUNPKLO Z10.D, Z7.S
    SUNPKHI Z18.H, Z10.B
    INDEX   Z28.D, #-1, X11
    INDEX   Z7.H, W21, W18
    PUNPKLO P3.H, P11.B
    UZP1    P5.D, P9.D, P0.D
    REV     P5.D, P0.D
    ZIP2    P4.H, P3.H, P8.H
    SUNPKHI Z19.H, Z8.B
    SUNPKHI Z9.H, Z19.B
    LASTB   X18, P2, Z7.D
    DUP Z3.Q,Z14.Q[3]
    INDEX   Z18.B, #9, W2
    TRN1    Z24.S, Z18.S, Z31.S
    DUP Z28.H,Z17.H[18]
    MOV Z7.S,Z24.S[7]
    INDEX   Z22.B, W2, #2
    INSR    Z22.S, S20
    TRN2    Z11.B, Z4.B, Z7.B
    REV     P0.D, P3.D
    INDEX   Z6.S, W22, W4
    INDEX   Z19.D, #9, #-2
    SUNPKLO Z15.D, Z8.S
    CLASTA  H3, P6, H3, Z6.H
    TRN2    P6.S, P2.S, P7.S
    TBL     Z18.H,  Z19.H, Z28.H
    INDEX   Z17.D, #-1, #6
    SUNPKHI Z11.D, Z24.S
    INDEX   Z10.B, W3, #3
    TRN1    P4.H, P6.H, P12.H
    REV     P15.H, P2.H
    CLASTA  Z11.D, P6, Z11.D, Z10.D
    TRN1    P0.H, P8.H, P12.H
    MOV Z31.H,H17
    INDEX   Z8.H, #12, #-8
    INDEX   Z17.D, X14, #-12
    DUP Z14.H,Z3.H[26]
    TRN1    P11.D, P10.D, P6.D
    UUNPKLO Z28.S, Z5.H
    MOV Z25.D,D17
    UZP1    P11.H, P7.H, P5.H
    UZP2    P6.B, P15.B, P4.B
    MOV Z6.Q,Q2
    UZP2    Z1.H, Z6.H, Z11.H
    UUNPKHI Z2.S, Z25.H
    TRN1    P15.B, P7.B, P1.B
    REV     P3.D, P7.D
    ZIP2    P7.D, P15.D, P5.D
    INDEX   Z26.S, #-11, W2
    INDEX   Z25.B, #4, W18
    INDEX   Z11.S, #-5, W3
    INDEX   Z23.D, #-1, #-14
    INDEX   Z3.D, X18, #1
    INDEX   Z5.S, #-3, W21
    ZIP1    P4.H, P6.H, P9.H
    INDEX   Z17.D, X12, X4
    SUNPKLO Z17.S, Z26.H
    DUP Z6.Q,Z8.Q[3]
    INDEX   Z26.H, #-5, W16
    INDEX   Z25.H, #5, W20
    ZIP2    P11.D, P3.D, P8.D
    DUP Z20.D,Z23.D[0]
    TRN2    P13.H, P1.H, P7.H
    INDEX   Z26.H, W7, #0
    INDEX   Z19.H, W15, #-5
    UUNPKHI Z1.H, Z28.B
    ZIP1    Z2.B, Z25.B, Z17.B
    MOV Z28.H,Z2.H[9]
    REV     P5.D, P6.D
    INDEX   Z30.S, W21, W8
    ZIP1    P0.S, P11.S, P2.S
    TBL     Z17.S,  Z20.S, Z30.S
    INDEX   Z13.S, #8, #11
    LASTB   W21, P3, Z13.B
    UUNPKLO Z16.H, Z26.B
    SUNPKLO Z13.H, Z6.B
    SUNPKHI Z20.D, Z18.S
    CLASTA  W16, P5, W16, Z13.H
    UZP1    P4.H, P15.H, P11.H
    UUNPKHI Z15.S, Z28.H
    UUNPKHI Z12.S, Z15.H
    CLASTA  X23, P3, X23, Z19.D
    REV     Z0.H, Z10.H
    UUNPKHI Z30.D, Z5.S
    UZP2    P6.H, P4.H, P3.H
    UZP1    P13.B, P0.B, P14.B
    INDEX   Z16.D, X16, X3
    MOV     Z27.B, P5/M, B19
    INDEX   Z26.S, W3, #-5
    CLASTA  W23, P4, W23, Z12.S
    INDEX   Z10.B, W2, #-3
    INDEX   Z12.B, #15, #-4
    UZP2    P12.B, P1.B, P9.B
    MOV     Z28.B, P7/M, B15
    INDEX   Z0.H, #-5, #-3
    CLASTA  B22, P6, B22, Z16.B
    INDEX   Z8.S, #5, W18
    CLASTB  W23, P3, W23, Z28.S
    UUNPKLO Z28.H, Z11.B
    ZIP1    P8.D, P1.D, P6.D
    SUNPKLO Z15.D, Z30.S
    ZIP2    Z26.S, Z10.S, Z28.S
    UZP2    P9.D, P1.D, P14.D
    UZP2    Z5.D, Z27.D, Z3.D
    UZP2    P14.D, P13.D, P4.D
    TRN1    P0.D, P14.D, P13.D
    INDEX   Z28.D, #9, #11
    INDEX   Z5.B, W16, W21
    CLASTA  B4, P3, B4, Z1.B
    INDEX   Z19.S, W18, #-11
    SUNPKHI Z7.D, Z25.S
    INDEX   Z4.D, X24, X3
    INSR    Z7.D, X2
    MOV Z25.Q,Z26.Q[2]
    CLASTA  Z30.S, P0, Z30.S, Z15.S
    PUNPKLO P14.H, P10.B
    UZP1    P14.B, P15.B, P9.B
    PUNPKLO P0.H, P1.B
    INDEX   Z3.B, #6, W22
    CLASTB  B23, P2, B23, Z7.B
    CLASTA  H4, P7, H4, Z3.H
    TRN1    P0.D, P2.D, P13.D
    REVB    Z26.D, P5/M, Z25.D
    INDEX   Z13.H, #2, W3
    UZP1    P3.D, P4.D, P1.D
    SUBS  X13, X13, #0x1
    B.NE  LCRTSveMoveOperations_label_7
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveMoveOperations_TestFail
    MRS  X9, FPSR
    MOVZ  X17, #0x95, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X17, #0xffef, LSL #0
    MOVK  X17, #0xffec, LSL #16
    MOVK  X17, #0xffe9, LSL #32
    MOVK  X17, #0xffe6, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D0
    MOVZ  X17, #0xfffb, LSL #0
    MOVK  X17, #0xfff8, LSL #16
    MOVK  X17, #0xfff5, LSL #32
    MOVK  X17, #0xfff2, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D1
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X17, #0xff03, LSL #0
    MOVK  X17, #0xff00, LSL #16
    MOVK  X17, #0xff02, LSL #32
    MOVK  X17, #0xff00, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D2
    MOVZ  X17, #0xf505, LSL #0
    MOVK  X17, #0xff00, LSL #16
    MOVK  X17, #0xff04, LSL #32
    MOVK  X17, #0xff00, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X17, #0xfdfe, LSL #0
    MOVK  X17, #0xfbfc, LSL #16
    MOVK  X17, #0xf9fa, LSL #32
    MOVK  X17, #0xf7f8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D3
    MOVZ  X17, #0x506, LSL #0
    MOVK  X17, #0x304, LSL #16
    MOVK  X17, #0x102, LSL #32
    MOVK  X17, #0xff00, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D4
    MOVZ  X17, #0x506, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X17, #0xfffd, LSL #0
    MOVK  X17, #0xfffc, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D7
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X17, #0x5, LSL #0
    MOVK  X17, #0x5, LSL #32
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D8
    MOVZ  X17, #0x5, LSL #0
    MOVK  X17, #0x5, LSL #32
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D9
    MOVZ  X17, #0xfff8, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X17, #0xe4e7, LSL #0
    MOVK  X17, #0xdee1, LSL #16
    MOVK  X17, #0xd8db, LSL #32
    MOVK  X17, #0xd2d5, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D10
    MOVZ  X17, #0xfcff, LSL #0
    MOVK  X17, #0xf6f9, LSL #16
    MOVK  X17, #0xf0f3, LSL #32
    MOVK  X17, #0xeaed, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X17, #0xfff9, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xfff8, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D11
    MOVZ  X17, #0xfffb, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xfffa, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X17, #0xebef, LSL #0
    MOVK  X17, #0xe3e7, LSL #16
    MOVK  X17, #0xdbdf, LSL #32
    MOVK  X17, #0xd3d7, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D12
    MOVZ  X17, #0xb0f, LSL #0
    MOVK  X17, #0x307, LSL #16
    MOVK  X17, #0xfbff, LSL #32
    MOVK  X17, #0xf3f7, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X17, #0xfffe, LSL #0
    MOVK  X17, #0xfffd, LSL #16
    MOVK  X17, #0xfffc, LSL #32
    MOVK  X17, #0xfffb, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D13
    MOVZ  X17, #0x2, LSL #0
    MOVK  X17, #0x1, LSL #16
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D15
    MOVZ  X17, #0xfffd, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D17
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X17, #0x9, LSL #0
    MOVK  X17, #0x9, LSL #16
    MOVK  X17, #0x9, LSL #32
    MOVK  X17, #0x9, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D18
    MOVZ  X17, #0x9, LSL #0
    MOVK  X17, #0x9, LSL #16
    MOVK  X17, #0x9, LSL #32
    MOVK  X17, #0x9, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X17, #0xffea, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffdf, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D19
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xfff5, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X17, #0x9, LSL #0
    MOVK  X17, #0x9, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D20
    MOVZ  X17, #0x9, LSL #0
    MOVK  X17, #0x9, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D21
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D23
    MOVZ  X17, #0xff, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X17, #0x1, LSL #0
    MOVK  X17, #0xfeff, LSL #16
    MOVK  X17, #0xfff4, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D24
    MOVZ  X17, #0x809, LSL #0
    MOVK  X17, #0x607, LSL #16
    MOVK  X17, #0xfff6, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D27
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X17, #0x14, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D28
    MOVZ  X17, #0x9, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X17, #0xdae8, LSL #0
    MOVK  X17, #0xbecc, LSL #32
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D29
    MOVZ  X17, #0x1220, LSL #0
    MOVK  X17, #0xf604, LSL #32
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X17, #0xfffd, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xfffd, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D30
    MOVZ  X17, #0xfffd, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xfffd, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FMOV  X9, D31
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0x5555, LSL #0
    MOVK  X17, #0x5555, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
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
    FMOV  X9, D0
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X9, D1
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X9, D2
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X9, D3
    MOVZ  X17, #0x506, LSL #0
    MOVK  X17, #0x304, LSL #16
    MOVK  X17, #0x102, LSL #32
    MOVK  X17, #0xff00, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D4, P1, Z4.D
    FMOV  X9, D4
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X9, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X9, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D7, P7, Z7.D
    FMOV  X9, D7
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X9, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X9, D9
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X9, D10
    MOVZ  X17, #0xfcff, LSL #0
    MOVK  X17, #0xf6f9, LSL #16
    MOVK  X17, #0xf0f3, LSL #32
    MOVK  X17, #0xeaed, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X9, D11
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X9, D12
    MOVZ  X17, #0xb0f, LSL #0
    MOVK  X17, #0x307, LSL #16
    MOVK  X17, #0xfbff, LSL #32
    MOVK  X17, #0xf3f7, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X9, D13
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X9, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X9, D15
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X9, D16
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X9, D17
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X9, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X9, D19
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D20, P7, Z20.D
    FMOV  X9, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D21, P7, Z21.D
    FMOV  X9, D21
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X9, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X9, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X9, D24
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X9, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D26, P3, Z26.D
    FMOV  X9, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X9, D27
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X9, D28
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X9, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D30, P0, Z30.D
    FMOV  X9, D30
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
    FADDV   D31, P6, Z31.D
    FMOV  X9, D31
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    SUB  X6, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    DUP     Z0.D, X21
    DUP     Z1.D, X19
    DUP     Z2.D, X7
    DUP     Z3.D, X20
    DUP     Z4.D, X22
    DUP     Z5.D, X24
    DUP     Z6.D, X14
    DUP     Z7.D, X15
    DUP     Z8.D, X12
    DUP     Z9.D, X21
    DUP     Z10.D, X24
    DUP     Z11.D, X4
    DUP     Z12.D, X4
    DUP     Z13.D, X14
    DUP     Z14.D, X14
    DUP     Z15.D, X19
    DUP     Z16.D, X4
    DUP     Z17.D, X7
    DUP     Z18.D, X24
    DUP     Z19.D, X18
    DUP     Z20.D, X6
    DUP     Z21.D, X15
    DUP     Z22.D, X17
    DUP     Z23.D, X7
    DUP     Z24.D, X14
    DUP     Z25.D, X24
    DUP     Z26.D, X17
    DUP     Z27.D, X22
    DUP     Z28.D, X23
    DUP     Z29.D, X5
    DUP     Z30.D, X13
    DUP     Z31.D, X15
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
LCRTSveMoveOperations_label_8:
    UUNPKLO Z31.S, Z29.H
    ZIP1    P1.B, P10.B, P2.B
    LASTA   H5, P5, Z31.H
    CLASTB  S5, P0, S5, Z5.S
    SUNPKLO Z16.H, Z5.B
    INDEX   Z10.H, #13, W2
    UZP2    Z14.S, Z16.S, Z10.S
    INDEX   Z29.S, W22, #-12
    SUNPKLO Z10.H, Z29.B
    REV     P15.H, P14.H
    SUNPKLO Z6.D, Z30.S
    CLASTB  W16, P1, W16, Z17.S
    CLASTA  D6, P5, D6, Z0.D
    UZP1    Z31.D, Z30.D, Z3.D
    UUNPKLO Z12.S, Z0.H
    PUNPKLO P5.H, P15.B
    COMPACT Z12.S, P5, Z13.S
    UUNPKHI Z18.H, Z25.B
    INDEX   Z26.D, #4, X10
    MOV     Z0.H, P0/M, H26
    INDEX   Z22.B, W6, #-9
    SUNPKHI Z17.S, Z12.H
    LASTB   W21, P4, Z20.B
    UUNPKHI Z15.S, Z0.H
    PUNPKLO P1.H, P11.B
    UZP1    P6.S, P2.S, P13.S
    REV     P15.B, P13.B
    SUNPKLO Z3.D, Z22.S
    INDEX   Z5.H, #-8, #-5
    UZP1    Z18.H, Z3.H, Z18.H
    INDEX   Z9.D, X13, #-2
    PUNPKHI P2.H, P1.B
    PUNPKHI P11.H, P0.B
    SUNPKLO Z28.H, Z17.B
    ZIP2    Z6.H, Z18.H, Z5.H
    CLASTB  Z22.S, P4, Z22.S, Z9.S
    INDEX   Z0.B, #-11, #5
    TRN2    P10.H, P5.H, P1.H
    SUNPKHI Z29.S, Z12.H
    UUNPKHI Z17.S, Z2.H
    UZP1    P12.D, P2.D, P2.D
    UZP2    P2.D, P6.D, P5.D
    UUNPKHI Z9.S, Z18.H
    INDEX   Z3.H, W24, #6
    SUNPKLO Z12.H, Z6.B
    UUNPKLO Z14.H, Z11.B
    UZP1    P4.S, P0.S, P15.S
    INDEX   Z11.B, W20, W18
    INDEX   Z2.S, W15, #6
    INDEX   Z6.S, #-4, W3
    ZIP1    P3.B, P2.B, P7.B
    CLASTA  Z3.S, P4, Z3.S, Z22.S
    INDEX   Z22.H, W10, #4
    INDEX   Z27.B, W5, W15
    PUNPKLO P9.H, P10.B
    SUNPKLO Z0.H, Z14.B
    TRN2    P5.D, P13.D, P9.D
    TRN2    P1.D, P3.D, P3.D
    SUNPKHI Z29.H, Z6.B
    SPLICE  Z12.D, P5, Z12.D, Z20.D
    INDEX   Z17.D, X9, X10
    TBL     Z23.H,  Z11.H, Z22.H
    INDEX   Z18.D, #0, X20
    PUNPKHI P1.H, P1.B
    UZP2    P13.D, P2.D, P1.D
    MOV Z22.H,H27
    UUNPKLO Z3.H, Z18.B
    LASTB   H19, P3, Z17.H
    INDEX   Z15.S, W22, #7
    REV     P5.B, P2.B
    SUNPKLO Z4.S, Z0.H
    ZIP2    P7.D, P5.D, P12.D
    INDEX   Z0.B, W23, W15
    UUNPKLO Z19.H, Z5.B
    SUNPKHI Z23.D, Z24.S
    DUP Z5.S,Z24.S[5]
    INDEX   Z28.B, W5, #6
    ZIP1    Z5.S, Z4.S, Z19.S
    TRN2    P2.H, P3.H, P1.H
    UUNPKHI Z26.S, Z12.H
    UUNPKLO Z23.H, Z23.B
    ZIP1    Z27.H, Z25.H, Z22.H
    LASTB   B22, P6, Z28.B
    UUNPKHI Z23.D, Z26.S
    UZP1    Z10.D, Z23.D, Z5.D
    INDEX   Z5.H, #-1, W21
    SUNPKLO Z12.H, Z5.B
    INDEX   Z28.H, #5, W7
    INDEX   Z26.B, #3, #15
    UZP1    Z15.D, Z28.D, Z28.D
    INDEX   Z4.B, #12, W16
    UZP1    P14.S, P15.S, P13.S
    UUNPKLO Z26.H, Z4.B
    UUNPKLO Z5.S, Z27.H
    INDEX   Z26.S, #-11, W2
    INDEX   Z25.B, W13, W9
    REV     P0.H, P3.H
    INDEX   Z19.B, #0, W21
    INDEX   Z4.B, #12, #7
    UUNPKLO Z30.S, Z4.H
    INDEX   Z27.D, X15, X5
    UUNPKHI Z22.D, Z25.S
    ZIP2    P4.S, P9.S, P5.S
    INDEX   Z24.H, W13, #-13
    INDEX   Z25.D, #7, X9
    SUNPKLO Z27.H, Z22.B
    INDEX   Z28.B, #6, W22
    TRN1    Z22.B, Z30.B, Z15.B
    CLASTA  W3, P5, W3, Z19.H
    REV     P2.H, P14.H
    SUNPKLO Z27.S, Z25.H
    INDEX   Z30.D, X15, #-11
    SUNPKLO Z25.H, Z22.B
    TRN2    P8.H, P9.H, P15.H
    INDEX   Z19.D, #11, X24
    TRN2    P10.H, P2.H, P5.H
    MOV Z6.Q,Z29.Q[2]
    SUNPKLO Z4.D, Z30.S
    TRN1    P9.B, P3.B, P14.B
    SUNPKLO Z29.S, Z19.H
    INSR    Z5.D, D29
    REVH    Z22.S, P2/M, Z28.S
    INDEX   Z28.B, W16, W17
    MOV Z19.Q,Q6
    SUNPKHI Z6.D, Z23.S
    TRN1    P12.S, P6.S, P5.S
    INDEX   Z23.B, #12, W13
    PUNPKLO P12.H, P9.B
    MOV Z15.Q,Z19.Q[1]
    CLASTA  D14, P5, D14, Z22.D
    INDEX   Z26.D, X23, X13
    INDEX   Z11.S, #-16, W9
    ZIP1    P1.B, P15.B, P1.B
    INDEX   Z29.B, W18, #-4
    UUNPKHI Z19.H, Z13.B
    UUNPKHI Z29.D, Z29.S
    TBL     Z27.H,  Z28.H, Z11.H
    SUNPKLO Z13.H, Z15.B
    UUNPKHI Z22.H, Z27.B
    SUNPKLO Z15.D, Z25.S
    SUNPKHI Z25.H, Z4.B
    UUNPKLO Z9.D, Z22.S
    PUNPKHI P3.H, P7.B
    LASTB   S1, P4, Z23.S
    SUNPKHI Z28.H, Z29.B
    TRN1    P13.S, P15.S, P7.S
    INDEX   Z27.S, #-13, W10
    SUNPKHI Z24.S, Z15.H
    TRN1    P2.B, P15.B, P5.B
    LASTA   B15, P2, Z6.B
    INDEX   Z13.D, #5, X19
    INDEX   Z4.D, X7, X24
    TRN2    P9.D, P1.D, P13.D
    CLASTA  S4, P0, S4, Z13.S
    TRN1    Z13.D, Z25.D, Z14.D
    CLASTB  Z28.B, P4, Z28.B, Z24.B
    SUNPKLO Z14.H, Z1.B
    ZIP1    P6.S, P12.S, P7.S
    TRN1    P15.S, P2.S, P5.S
    INDEX   Z23.H, #0, #-14
    TRN1    P14.H, P11.H, P0.H
    MOV Z24.B,Z15.B[19]
    INSR    Z28.S, S17
    INDEX   Z15.H, W12, W8
    UUNPKLO Z8.S, Z28.H
    UZP2    P7.D, P13.D, P2.D
    UUNPKLO Z17.D, Z17.S
    SUNPKLO Z28.D, Z14.S
    CLASTA  H26, P4, H26, Z27.H
    UZP2    P15.B, P12.B, P1.B
    TRN1    P9.S, P0.S, P5.S
    INDEX   Z25.S, #4, W9
    INDEX   Z29.H, W15, W12
    CLASTB  W21, P7, W21, Z23.B
    INDEX   Z27.S, W15, W3
    UZP2    Z23.D, Z27.D, Z28.D
    INDEX   Z15.D, X18, #-4
    REVB    Z14.S, P1/M, Z8.S
    INDEX   Z27.B, #13, W17
    LASTB   D30, P7, Z24.D
    TRN2    Z28.D, Z11.D, Z24.D
    MOV Z13.H,H9
    UUNPKLO Z3.H, Z28.B
    CLASTB  H14, P7, H14, Z13.H
    REV     Z24.B, Z23.B
    INDEX   Z23.D, X23, #-11
    INDEX   Z16.B, W13, #4
    ZIP1    Z13.H, Z24.H, Z15.H
    MOV     Z22.B, P2/M, B26
    ZIP2    P8.S, P1.S, P2.S
    MOV Z8.D,Z22.D[1]
    REV     P4.D, P14.D
    MOV Z25.Q,Z17.Q[2]
    TRN2    P11.S, P6.S, P9.S
    SUNPKHI Z26.D, Z3.S
    INDEX   Z15.S, #15, #-14
    MOV Z27.B,B15
    ZIP1    P11.H, P15.H, P13.H
    INDEX   Z19.S, #-13, #-7
    PUNPKHI P13.H, P15.B
    SUBS  X15, X15, #0x1
    B.NE  LCRTSveMoveOperations_label_8
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x32d8, LSL #0
    SUB  X14, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xb4b4, LSL #0
    MOVK  X4, #0xb4b4, LSL #16
    SUB  X14, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xff, LSL #0
    SUB  X14, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X14, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, LCRTSveMoveOperations_TestFail
    MRS  X4, FPSR
    MOVZ  X14, #0x95, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X14, #0x6362, LSL #0
    MOVK  X14, #0x6564, LSL #16
    MOVK  X14, #0x6766, LSL #32
    MOVK  X14, #0x6968, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D0
    MOVZ  X14, #0x5b5a, LSL #0
    MOVK  X14, #0x5d5c, LSL #16
    MOVK  X14, #0x5f5e, LSL #32
    MOVK  X14, #0x6160, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D1
    MOVZ  X14, #0x6e14, LSL #0
    MOVK  X14, #0x22c8, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X14, #0xd, LSL #0
    MOVK  X14, #0x13, LSL #32
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D2
    MOVZ  X14, #0x1, LSL #0
    MOVK  X14, #0x7, LSL #32
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X14, #0xfe, LSL #0
    MOVK  X14, #0xe, LSL #16
    MOVK  X14, #0xf, LSL #32
    MOVK  X14, #0xf, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D3
    MOVZ  X14, #0xa4, LSL #0
    MOVK  X14, #0xb4, LSL #16
    MOVK  X14, #0xb4, LSL #32
    MOVK  X14, #0xb4, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D4
    MOVZ  X14, #0xf13, LSL #0
    MOVK  X14, #0xf0f, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5b5a, LSL #32
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D5
    MOVZ  X14, #0xb, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D6
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D7
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D10
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X14, #0xb4a4, LSL #0
    MOVK  X14, #0xb4b4, LSL #16
    MOVK  X14, #0xefe, LSL #32
    MOVK  X14, #0xf0f, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D11
    MOVZ  X14, #0xfff0, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0x5a4a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X14, #0xffb3, LSL #0
    MOVK  X14, #0xd, LSL #32
    MOVK  X14, #0x1, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D12
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0x59, LSL #32
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D13
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D14
    MOVZ  X14, #0x14, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X14, #0xfff3, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffe5, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D15
    MOVZ  X14, #0xf, LSL #0
    MOVK  X14, #0x1, LSL #32
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X14, #0x7e7a, LSL #0
    MOVK  X14, #0x8682, LSL #16
    MOVK  X14, #0x8e8a, LSL #32
    MOVK  X14, #0x9692, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D16
    MOVZ  X14, #0x5e5a, LSL #0
    MOVK  X14, #0x6662, LSL #16
    MOVK  X14, #0x6e6a, LSL #32
    MOVK  X14, #0x7672, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D17
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X14, #0xffe5, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffde, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D19
    MOVZ  X14, #0xfff3, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffec, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D20
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D21
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X14, #0x5a4f, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D23
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x2200, LSL #32
    MOVK  X14, #0xc8ff, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X14, #0xf0f, LSL #0
    MOVK  X14, #0xf0f, LSL #16
    MOVK  X14, #0xf0f, LSL #32
    MOVK  X14, #0xf0f, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D27
    MOVZ  X14, #0xf0f, LSL #0
    MOVK  X14, #0xf0f, LSL #16
    MOVK  X14, #0xf0f, LSL #32
    MOVK  X14, #0xf0f, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D28
    MOVZ  X14, #0xb4a4, LSL #0
    MOVK  X14, #0xb4b4, LSL #16
    MOVK  X14, #0xefe, LSL #32
    MOVK  X14, #0xf0f, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X14, #0x6969, LSL #0
    MOVK  X14, #0xc3c3, LSL #16
    MOVK  X14, #0x1e1d, LSL #32
    MOVK  X14, #0x7877, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D29
    MOVZ  X14, #0x1, LSL #0
    MOVK  X14, #0x5a5b, LSL #16
    MOVK  X14, #0xb4b5, LSL #32
    MOVK  X14, #0xf0f, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FMOV  X4, D31
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x11, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xa00, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x11, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x4400, LSL #0
    MOVK  X14, #0x101, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x80, LSL #0
    MOVK  X14, #0x500, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xa00, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xa0, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5001, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x180, LSL #0
    MOVK  X14, #0x400, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x1010, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x101, LSL #0
    MOVK  X14, #0x44, LSL #16
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
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
    MOVZ  X14, #0x7372, LSL #0
    MOVK  X14, #0x7574, LSL #16
    MOVK  X14, #0x7776, LSL #32
    MOVK  X14, #0x7978, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X4, D1
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X4, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X4, D3
    MOVZ  X14, #0xa4, LSL #0
    MOVK  X14, #0xb4, LSL #16
    MOVK  X14, #0xb4, LSL #32
    MOVK  X14, #0xb4, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X4, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X4, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X4, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X4, D7
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a7a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X4, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X4, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X4, D10
    MOVZ  X14, #0xfff7, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xf3, LSL #32
    MOVK  X14, #0x10f, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X4, D11
    MOVZ  X14, #0x1e0b, LSL #0
    MOVK  X14, #0x1e1e, LSL #16
    MOVK  X14, #0x7866, LSL #32
    MOVK  X14, #0x7878, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X4, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X4, D13
    MOVZ  X14, #0x880, LSL #0
    MOVK  X14, #0x1a59, LSL #16
    MOVK  X14, #0x3240, LSL #32
    MOVK  X14, #0x5a7a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D14, P7, Z14.D
    FMOV  X4, D14
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X4, D15
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7ff8, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X4, D16
    MOVZ  X14, #0x5e58, LSL #0
    MOVK  X14, #0x6662, LSL #16
    MOVK  X14, #0x6e6a, LSL #32
    MOVK  X14, #0x7672, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D17, P1, Z17.D
    FMOV  X4, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X4, D18
    MOVZ  X14, #0x5a59, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X4, D19
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7ff8, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X4, D20
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a7a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D21, P2, Z21.D
    FMOV  X4, D21
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a7a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X4, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X4, D23
    MOVZ  X14, #0x5a49, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a7a, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X4, D24
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x2200, LSL #32
    MOVK  X14, #0xc8ff, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X4, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X4, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D27, P7, Z27.D
    FMOV  X4, D27
    MOVZ  X14, #0xf0f, LSL #0
    MOVK  X14, #0xf0f, LSL #16
    MOVK  X14, #0xf0f, LSL #32
    MOVK  X14, #0xf2f, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D28, P6, Z28.D
    FMOV  X4, D28
    MOVZ  X14, #0x1e0c, LSL #0
    MOVK  X14, #0x1e1e, LSL #16
    MOVK  X14, #0x7866, LSL #32
    MOVK  X14, #0x7878, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X4, D29
    MOVZ  X14, #0x6968, LSL #0
    MOVK  X14, #0xc3c3, LSL #16
    MOVK  X14, #0x1e1d, LSL #32
    MOVK  X14, #0x7877, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X4, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    FADDV   D31, P6, Z31.D
    FMOV  X4, D31
    MOVZ  X14, #0xa4, LSL #0
    MOVK  X14, #0xb4, LSL #16
    MOVK  X14, #0xb4, LSL #32
    MOVK  X14, #0xb4, LSL #48
    SUB  X11, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    DUP     Z0.D, X20
    DUP     Z1.D, X3
    DUP     Z2.D, X14
    DUP     Z3.D, X22
    DUP     Z4.D, X24
    DUP     Z5.D, X23
    DUP     Z6.D, X21
    DUP     Z7.D, X22
    DUP     Z8.D, X9
    DUP     Z9.D, X12
    DUP     Z10.D, X12
    DUP     Z11.D, X13
    DUP     Z12.D, X7
    DUP     Z13.D, X8
    DUP     Z14.D, X15
    DUP     Z15.D, X10
    DUP     Z16.D, X15
    DUP     Z17.D, X7
    DUP     Z18.D, X19
    DUP     Z19.D, X3
    DUP     Z20.D, X17
    DUP     Z21.D, X4
    DUP     Z22.D, X6
    DUP     Z23.D, X17
    DUP     Z24.D, X4
    DUP     Z25.D, X2
    DUP     Z26.D, X24
    DUP     Z27.D, X7
    DUP     Z28.D, X12
    DUP     Z29.D, X21
    DUP     Z30.D, X21
    DUP     Z31.D, X2
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
    MOVZ  X18, #0xa, LSL #0
LCRTSveMoveOperations_label_9:
    UZP1    P4.S, P11.S, P15.S
    INDEX   Z20.B, W8, W9
    INDEX   Z0.D, #5, #-2
    UZP2    Z22.B, Z26.B, Z6.B
    REV     P3.H, P0.H
    INDEX   Z9.D, #-11, #2
    UZP1    Z11.D, Z20.D, Z20.D
    TRN1    P10.B, P8.B, P14.B
    INDEX   Z29.H, #1, #1
    INDEX   Z29.H, W21, #14
    UUNPKLO Z0.D, Z29.S
    TRN2    P9.D, P10.D, P3.D
    LASTA   W20, P2, Z11.S
    UUNPKHI Z26.S, Z22.H
    UZP2    P9.S, P9.S, P7.S
    MOV Z17.D,D0
    UUNPKHI Z13.D, Z26.S
    CLASTA  W10, P4, W10, Z8.S
    INDEX   Z5.S, #-4, #-13
    ZIP2    P11.D, P14.D, P13.D
    REV     P9.B, P6.B
    INDEX   Z22.B, #12, W14
    INDEX   Z8.D, X23, X13
    LASTA   H10, P7, Z14.H
    INDEX   Z17.H, #-3, W15
    UUNPKHI Z6.S, Z24.H
    INDEX   Z14.B, W15, W14
    SUNPKHI Z5.D, Z22.S
    INDEX   Z12.H, #-1, #-3
    UUNPKHI Z31.D, Z10.S
    SUNPKHI Z13.D, Z15.S
    INDEX   Z29.B, W4, W7
    SUNPKHI Z0.S, Z12.H
    REV     P7.S, P12.S
    INDEX   Z27.S, W14, #5
    UUNPKLO Z11.H, Z17.B
    SUNPKHI Z26.S, Z5.H
    REVB    Z18.S, P6/M, Z13.S
    INDEX   Z27.H, W13, W18
    UUNPKHI Z10.D, Z31.S
    ZIP2    P8.S, P0.S, P11.S
    INDEX   Z6.H, W20, W15
    REV     Z30.H, Z29.H
    INDEX   Z5.S, #-5, #12
    INSR    Z0.B, B30
    CLASTB  B0, P7, B0, Z28.B
    INDEX   Z25.D, #7, #-12
    UUNPKHI Z25.D, Z11.S
    INDEX   Z16.S, W14, W23
    UUNPKHI Z16.S, Z6.H
    INDEX   Z12.S, #-7, #-10
    INDEX   Z13.B, W22, #11
    CLASTA  X14, P0, X14, Z18.D
    TRN2    Z27.S, Z13.S, Z4.S
    UZP1    P0.B, P6.B, P13.B
    INDEX   Z0.H, W20, W16
    ZIP1    P14.D, P0.D, P12.D
    REV     P15.D, P15.D
    CLASTA  H1, P6, H1, Z4.H
    SUNPKHI Z28.H, Z0.B
    SUNPKLO Z20.S, Z27.H
    PUNPKHI P10.H, P15.B
    INDEX   Z26.S, #6, W23
    PUNPKLO P6.H, P5.B
    INSR    Z7.B, W23
    TRN1    P9.H, P4.H, P5.H
    CLASTA  X20, P1, X20, Z1.D
    TRN2    P7.H, P3.H, P14.H
    SUNPKHI Z24.H, Z9.B
    UUNPKLO Z24.D, Z3.S
    REVW    Z20.D, P4/M, Z29.D
    UUNPKLO Z13.H, Z20.B
    SUNPKLO Z15.D, Z7.S
    UZP1    P12.S, P15.S, P6.S
    SUNPKHI Z1.D, Z28.S
    REV     P15.S, P0.S
    INDEX   Z26.S, W24, #1
    ZIP2    Z7.S, Z0.S, Z26.S
    REV     P2.D, P5.D
    REV     P13.B, P0.B
    TRN2    P6.B, P8.B, P10.B
    INDEX   Z3.B, W8, W4
    REVB    Z29.D, P1/M, Z26.D
    ZIP1    P4.H, P7.H, P13.H
    INDEX   Z27.H, #14, #11
    UUNPKHI Z14.D, Z14.S
    LASTB   B4, P3, Z3.B
    UUNPKLO Z0.D, Z13.S
    UZP1    P7.B, P3.B, P12.B
    REV     P11.H, P15.H
    PUNPKLO P4.H, P7.B
    SUNPKLO Z10.H, Z14.B
    INDEX   Z12.D, #-15, X18
    UZP1    P7.B, P7.B, P3.B
    INDEX   Z0.S, #7, W21
    ZIP2    Z19.H, Z10.H, Z19.H
    ZIP2    P1.B, P12.B, P12.B
    CLASTA  B18, P2, B18, Z13.B
    CLASTA  Z12.B, P1, Z12.B, Z12.B
    CLASTA  H27, P2, H27, Z2.H
    UZP2    P4.S, P3.S, P10.S
    SUNPKHI Z22.H, Z12.B
    UZP1    P6.B, P3.B, P10.B
    CLASTA  W17, P2, W17, Z27.S
    ZIP1    P1.H, P9.H, P15.H
    CLASTA  D11, P7, D11, Z23.D
    PUNPKHI P8.H, P7.B
    TRN2    P8.D, P0.D, P1.D
    UZP1    P9.B, P13.B, P9.B
    UUNPKHI Z14.S, Z18.H
    INDEX   Z11.H, W17, #1
    MOV     Z10.D, P3/M, D19
    UUNPKLO Z10.S, Z14.H
    INDEX   Z27.H, W11, W7
    INDEX   Z15.D, X2, X15
    INDEX   Z23.S, #14, #9
    INDEX   Z18.H, #-14, W19
    ZIP2    P12.D, P4.D, P10.D
    REVH    Z5.S, P3/M, Z5.S
    INDEX   Z5.H, W23, #-5
    SUNPKHI Z19.D, Z27.S
    INDEX   Z14.H, W7, W13
    LASTB   H27, P3, Z8.H
    LASTB   D8, P0, Z23.D
    UZP2    Z12.D, Z11.D, Z15.D
    ZIP2    P9.H, P4.H, P1.H
    PUNPKHI P6.H, P3.B
    SPLICE  Z10.B, P3, Z10.B, Z12.B
    REV     Z11.B, Z27.B
    SUNPKLO Z26.D, Z11.S
    REV     P8.D, P0.D
    REVB    Z31.D, P1/M, Z23.D
    SUNPKLO Z21.S, Z30.H
    INDEX   Z27.B, #12, #-5
    ZIP2    P6.D, P12.D, P12.D
    UZP2    P7.D, P5.D, P12.D
    SUNPKHI Z15.D, Z19.S
    TRN1    P15.B, P5.B, P9.B
    CLASTA  W20, P6, W20, Z15.H
    PUNPKHI P15.H, P7.B
    TBL     Z23.H,  Z27.H, Z5.H
    TBL     Z3.D,  Z31.D, Z30.D
    MOV Z16.Q,Z8.Q[0]
    TRN2    P15.H, P3.H, P13.H
    MOV Z8.D,D18
    UUNPKLO Z13.D, Z21.S
    SUNPKLO Z19.S, Z22.H
    INDEX   Z18.D, X9, #2
    CLASTA  Z3.S, P7, Z3.S, Z13.S
    REV     P0.D, P15.D
    ZIP2    P12.D, P8.D, P10.D
    INSR    Z1.S, S18
    INDEX   Z5.D, X24, X5
    LASTA   S21, P2, Z10.S
    INDEX   Z11.S, W11, W20
    UZP1    P7.H, P10.H, P13.H
    INDEX   Z15.S, #-13, #11
    ZIP1    P13.B, P5.B, P4.B
    INDEX   Z13.D, X23, #-12
    INSR    Z16.B, B23
    ZIP1    P14.B, P7.B, P1.B
    REV     P10.D, P10.D
    INDEX   Z5.S, #3, W18
    SUNPKLO Z23.D, Z19.S
    PUNPKHI P10.H, P4.B
    MOV     Z18.B, P4/M, B5
    INDEX   Z22.S, #11, #-3
    INDEX   Z23.B, W5, #9
    MOV Z30.B,B22
    CLASTA  H16, P3, H16, Z1.H
    CLASTA  W7, P1, W7, Z14.S
    ZIP1    P2.H, P10.H, P7.H
    TRN2    P5.D, P7.D, P8.D
    UUNPKLO Z10.H, Z2.B
    UZP1    Z16.B, Z18.B, Z16.B
    UUNPKHI Z18.S, Z2.H
    INDEX   Z11.S, #-1, #5
    LASTA   W22, P5, Z16.H
    INDEX   Z1.D, X20, X21
    PUNPKLO P15.H, P4.B
    TRN1    P9.H, P10.H, P3.H
    ZIP1    P4.H, P4.H, P6.H
    UUNPKHI Z5.D, Z1.S
    INDEX   Z14.B, W2, #-16
    INDEX   Z16.S, W16, W15
    INDEX   Z21.D, X16, #13
    UUNPKHI Z2.D, Z27.S
    DUP Z27.S,Z5.S[7]
    INDEX   Z3.D, #0, #-14
    TRN2    P4.D, P7.D, P9.D
    SPLICE  Z19.B, P3, Z19.B, Z3.B
    INDEX   Z1.B, W7, #5
    INDEX   Z3.H, W24, W8
    UUNPKLO Z14.H, Z2.B
    UUNPKLO Z28.D, Z19.S
    UZP2    P2.S, P13.S, P2.S
    INDEX   Z22.B, W10, #0
    INDEX   Z10.H, W15, W7
    INDEX   Z2.S, #6, #-1
    UZP1    P3.S, P5.S, P7.S
    SUBS  X18, X18, #0x1
    B.NE  LCRTSveMoveOperations_label_9
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0x4b4a, LSL #16
    SUB  X12, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xfff2, LSL #0
    MOVK  X6, #0xa597, LSL #16
    SUB  X12, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x1f00, LSL #16
    SUB  X12, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x6, LSL #0
    SUB  X12, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x3a5, LSL #0
    SUB  X12, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X12, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveMoveOperations_TestFail
    MRS  X6, FPSR
    MOVZ  X12, #0x95, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X12, #0x4b51, LSL #0
    MOVK  X12, #0x4b4b, LSL #16
    MOVK  X12, #0xf0f6, LSL #32
    MOVK  X12, #0xf0f0, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D0
    MOVZ  X12, #0x7, LSL #0
    MOVK  X12, #0xa5ac, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X12, #0xd2cd, LSL #0
    MOVK  X12, #0xdcd7, LSL #16
    MOVK  X12, #0xe6e1, LSL #32
    MOVK  X12, #0xf0eb, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D1
    MOVZ  X12, #0xaaa5, LSL #0
    MOVK  X12, #0xb4af, LSL #16
    MOVK  X12, #0xbeb9, LSL #32
    MOVK  X12, #0xc8c3, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X12, #0x4, LSL #0
    MOVK  X12, #0x3, LSL #32
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D2
    MOVZ  X12, #0x6, LSL #0
    MOVK  X12, #0x5, LSL #32
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X12, #0x3c39, LSL #0
    MOVK  X12, #0xe1de, LSL #16
    MOVK  X12, #0x8783, LSL #32
    MOVK  X12, #0x2d28, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0x4b4a, LSL #16
    MOVK  X12, #0xf0ef, LSL #32
    MOVK  X12, #0x9694, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D4
    MOVZ  X12, #0xa0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X12, #0x4b4b, LSL #0
    MOVK  X12, #0x4b4b, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D5
    MOVZ  X12, #0x4b4a, LSL #0
    MOVK  X12, #0x4b4b, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X12, #0xe139, LSL #0
    MOVK  X12, #0x86de, LSL #16
    MOVK  X12, #0x2c83, LSL #32
    MOVK  X12, #0xd228, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D6
    MOVZ  X12, #0x4aa5, LSL #0
    MOVK  X12, #0xf04a, LSL #16
    MOVK  X12, #0x95ef, LSL #32
    MOVK  X12, #0x3b94, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X12, #0xc317, LSL #0
    MOVK  X12, #0x68bc, LSL #16
    MOVK  X12, #0xa5aa, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D7
    MOVZ  X12, #0x77cd, LSL #0
    MOVK  X12, #0x1d72, LSL #16
    MOVK  X12, #0xa5a9, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X12, #0xfff2, LSL #0
    MOVK  X12, #0xa597, LSL #16
    MOVK  X12, #0x4b3c, LSL #32
    MOVK  X12, #0xf0e1, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D8
    MOVZ  X12, #0xfff2, LSL #0
    MOVK  X12, #0xa597, LSL #16
    MOVK  X12, #0x4b3c, LSL #32
    MOVK  X12, #0xf0e1, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X12, #0xfff7, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D9
    MOVZ  X12, #0xfff5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X12, #0x3c39, LSL #0
    MOVK  X12, #0xe1de, LSL #16
    MOVK  X12, #0x8783, LSL #32
    MOVK  X12, #0x2d28, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0x4b4a, LSL #16
    MOVK  X12, #0xf0ef, LSL #32
    MOVK  X12, #0x9694, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X12, #0x9, LSL #0
    MOVK  X12, #0xe, LSL #32
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D11
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0x4, LSL #32
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X12, #0x12, LSL #0
    MOVK  X12, #0x13, LSL #16
    MOVK  X12, #0x14, LSL #32
    MOVK  X12, #0x15, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D12
    MOVZ  X12, #0xa, LSL #0
    MOVK  X12, #0xb, LSL #16
    MOVK  X12, #0xc, LSL #32
    MOVK  X12, #0xd, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X12, #0xa599, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D14
    MOVZ  X12, #0xbc, LSL #0
    MOVK  X12, #0xb7, LSL #16
    MOVK  X12, #0xb2, LSL #32
    MOVK  X12, #0xad, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X12, #0x9, LSL #0
    MOVK  X12, #0x14, LSL #32
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D15
    MOVZ  X12, #0xfff3, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xfffe, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X12, #0xf0ef, LSL #0
    MOVK  X12, #0xf0f0, LSL #16
    MOVK  X12, #0x9694, LSL #32
    MOVK  X12, #0x9696, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0x4b4a, LSL #32
    MOVK  X12, #0x4b4b, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X12, #0x9691, LSL #0
    MOVK  X12, #0x3c36, LSL #16
    MOVK  X12, #0xe1db, LSL #32
    MOVK  X12, #0x8780, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D17
    MOVZ  X12, #0xfffd, LSL #0
    MOVK  X12, #0xa5a2, LSL #16
    MOVK  X12, #0x4b47, LSL #32
    MOVK  X12, #0xf0ec, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X12, #0x1, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D18
    MOVZ  X12, #0x2, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D19
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X12, #0x661, LSL #0
    MOVK  X12, #0x50ab, LSL #16
    MOVK  X12, #0x72cd, LSL #32
    MOVK  X12, #0xbc17, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D20
    MOVZ  X12, #0xde39, LSL #0
    MOVK  X12, #0x2883, LSL #16
    MOVK  X12, #0x4aa5, LSL #32
    MOVK  X12, #0x94ef, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X12, #0xa5b2, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X12, #0xf2f2, LSL #0
    MOVK  X12, #0xf2f2, LSL #16
    MOVK  X12, #0xf2f2, LSL #32
    MOVK  X12, #0xf2f2, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D22
    MOVZ  X12, #0xf2f2, LSL #0
    MOVK  X12, #0xf2f2, LSL #16
    MOVK  X12, #0xf2f2, LSL #32
    MOVK  X12, #0xf2f2, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X12, #0xf6ed, LSL #0
    MOVK  X12, #0x8ff, LSL #16
    MOVK  X12, #0x1a11, LSL #32
    MOVK  X12, #0x2c23, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D23
    MOVZ  X12, #0xaea5, LSL #0
    MOVK  X12, #0xc0b7, LSL #16
    MOVK  X12, #0xd2c9, LSL #32
    MOVK  X12, #0xe4db, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X12, #0xf0ef, LSL #0
    MOVK  X12, #0x9694, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0x4b4a, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X12, #0x36, LSL #0
    MOVK  X12, #0x3c, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D25
    MOVZ  X12, #0x91, LSL #0
    MOVK  X12, #0x96, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D26
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D27
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D28
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa8a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa7a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa6a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X12, #0xb0b, LSL #0
    MOVK  X12, #0xb0b, LSL #16
    MOVK  X12, #0xb0b, LSL #32
    MOVK  X12, #0xb0b, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D30
    MOVZ  X12, #0xb0b, LSL #0
    MOVK  X12, #0xb0b, LSL #16
    MOVK  X12, #0xb0b, LSL #32
    MOVK  X12, #0xb0b, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x2900, LSL #16
    MOVK  X12, #0x2000, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FMOV  X6, D31
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x1700, LSL #16
    MOVK  X12, #0xe00, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0xbbbb, LSL #0
    MOVK  X12, #0xbb3b, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x5545, LSL #0
    MOVK  X12, #0x5145, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0xbbbb, LSL #0
    MOVK  X12, #0x4444, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x5a44, LSL #0
    MOVK  X12, #0xaa44, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x8154, LSL #0
    MOVK  X12, #0x89aa, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x5454, LSL #0
    MOVK  X12, #0x55aa, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x1111, LSL #0
    MOVK  X12, #0x1111, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x5454, LSL #0
    MOVK  X12, #0xaaaa, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x5455, LSL #0
    MOVK  X12, #0x5555, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x8189, LSL #0
    MOVK  X12, #0x8989, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x101, LSL #0
    MOVK  X12, #0x101, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x5555, LSL #0
    MOVK  X12, #0x5551, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x1055, LSL #0
    MOVK  X12, #0x1155, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0xb9b8, LSL #0
    MOVK  X12, #0xb9b8, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x3132, LSL #0
    MOVK  X12, #0x3332, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X12, #0x5454, LSL #0
    MOVK  X12, #0x5454, LSL #16
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
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
    FMOV  X6, D0
    MOVZ  X12, #0x4b50, LSL #0
    MOVK  X12, #0x4b4b, LSL #16
    MOVK  X12, #0xf0f6, LSL #32
    MOVK  X12, #0xf0f0, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X6, D1
    MOVZ  X12, #0xd2cc, LSL #0
    MOVK  X12, #0xdcd7, LSL #16
    MOVK  X12, #0xe6e1, LSL #32
    MOVK  X12, #0xf0eb, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X6, D2
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X6, D3
    MOVZ  X12, #0x6960, LSL #0
    MOVK  X12, #0xf06, LSL #16
    MOVK  X12, #0xb4ab, LSL #32
    MOVK  X12, #0x5a50, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D4, P5, Z4.D
    FMOV  X6, D4
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X6, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X6, D6
    MOVZ  X12, #0xe60, LSL #0
    MOVK  X12, #0xb406, LSL #16
    MOVK  X12, #0x59ab, LSL #32
    MOVK  X12, #0xff50, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X6, D7
    MOVZ  X12, #0x68bc, LSL #0
    MOVK  X12, #0xe61, LSL #16
    MOVK  X12, #0xa5ab, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X6, D8
    MOVZ  X12, #0xfff2, LSL #0
    MOVK  X12, #0xa597, LSL #16
    MOVK  X12, #0x4b3c, LSL #32
    MOVK  X12, #0xf101, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D9, P1, Z9.D
    FMOV  X6, D9
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X6, D10
    MOVZ  X12, #0x6960, LSL #0
    MOVK  X12, #0xf06, LSL #16
    MOVK  X12, #0xb4ab, LSL #32
    MOVK  X12, #0x5a50, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X6, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X6, D12
    MOVZ  X12, #0x4b49, LSL #0
    MOVK  X12, #0x4b4b, LSL #16
    MOVK  X12, #0x4b4b, LSL #32
    MOVK  X12, #0x4b4b, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D13, P0, Z13.D
    FMOV  X6, D13
    MOVZ  X12, #0xa593, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X6, D14
    MOVZ  X12, #0x4088, LSL #0
    MOVK  X12, #0x8084, LSL #16
    MOVK  X12, #0xc080, LSL #32
    MOVK  X12, #0xb4, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X6, D15
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D16, P1, Z16.D
    FMOV  X6, D16
    MOVZ  X12, #0x3c37, LSL #0
    MOVK  X12, #0x3c3c, LSL #16
    MOVK  X12, #0xe1de, LSL #32
    MOVK  X12, #0xe1e1, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X6, D17
    MOVZ  X12, #0xfffd, LSL #0
    MOVK  X12, #0xa5a2, LSL #16
    MOVK  X12, #0x4b47, LSL #32
    MOVK  X12, #0xf0ec, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X6, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X6, D19
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D20, P7, Z20.D
    FMOV  X6, D20
    MOVZ  X12, #0x661, LSL #0
    MOVK  X12, #0x50ab, LSL #16
    MOVK  X12, #0x72cd, LSL #32
    MOVK  X12, #0xbc17, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X6, D21
    MOVZ  X12, #0xa5b8, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X6, D22
    MOVZ  X12, #0xf2f2, LSL #0
    MOVK  X12, #0xf2f2, LSL #16
    MOVK  X12, #0xf2f2, LSL #32
    MOVK  X12, #0xf312, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X6, D23
    MOVZ  X12, #0x3e33, LSL #0
    MOVK  X12, #0x5047, LSL #16
    MOVK  X12, #0x6259, LSL #32
    MOVK  X12, #0x746b, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X6, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X6, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X6, D26
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X6, D27
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X6, D28
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D29, P2, Z29.D
    FMOV  X6, D29
    MOVZ  X12, #0x4b4a, LSL #0
    MOVK  X12, #0xacbb, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xaba5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X6, D30
    MOVZ  X12, #0xb0b, LSL #0
    MOVK  X12, #0xb0b, LSL #16
    MOVK  X12, #0xb0b, LSL #32
    MOVK  X12, #0xb2b, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    FADDV   D31, P2, Z31.D
    FMOV  X6, D31
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x4d00, LSL #16
    MOVK  X12, #0x4400, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveMoveOperations_TestFail
    MOVZ  X2, #0x1ee2, LSL #0
    MOVK  X2, #0xe638, LSL #16
    MOVK  X2, #0xa04d, LSL #32
    MOVK  X2, #0x6393, LSL #48
    MOVZ  X3, #0x3236, LSL #0
    MOVK  X3, #0xbf30, LSL #16
    MOVK  X3, #0x71ff, LSL #32
    MOVK  X3, #0x7be5, LSL #48
    MOVZ  X4, #0x54e1, LSL #0
    MOVK  X4, #0x5d2e, LSL #16
    MOVK  X4, #0x24ed, LSL #32
    MOVK  X4, #0x4e35, LSL #48
    MOVZ  X5, #0xc803, LSL #0
    MOVK  X5, #0xbaaf, LSL #16
    MOVK  X5, #0x82f, LSL #32
    MOVK  X5, #0x1f5d, LSL #48
    MOVZ  X6, #0x564f, LSL #0
    MOVK  X6, #0x9692, LSL #16
    MOVK  X6, #0x4e9b, LSL #32
    MOVK  X6, #0xa352, LSL #48
    MOVZ  X7, #0x8b74, LSL #0
    MOVK  X7, #0x3e12, LSL #16
    MOVK  X7, #0xa5b2, LSL #32
    MOVK  X7, #0xa35a, LSL #48
    MOVZ  X8, #0xddfc, LSL #0
    MOVK  X8, #0x72a, LSL #16
    MOVK  X8, #0xb2d1, LSL #32
    MOVK  X8, #0x3e0, LSL #48
    MOVZ  X9, #0x66c8, LSL #0
    MOVK  X9, #0x9e53, LSL #16
    MOVK  X9, #0xf508, LSL #32
    MOVK  X9, #0xf97a, LSL #48
    MOVZ  X10, #0x26fe, LSL #0
    MOVK  X10, #0x42dc, LSL #16
    MOVK  X10, #0xed0, LSL #32
    MOVK  X10, #0xc9f4, LSL #48
    MOVZ  X11, #0x3109, LSL #0
    MOVK  X11, #0x7a7c, LSL #16
    MOVK  X11, #0x81eb, LSL #32
    MOVK  X11, #0xbf7c, LSL #48
    MOVZ  X12, #0x5b0a, LSL #0
    MOVK  X12, #0x7293, LSL #16
    MOVK  X12, #0x74d3, LSL #32
    MOVK  X12, #0x96c, LSL #48
    MOVZ  X13, #0x50dc, LSL #0
    MOVK  X13, #0xfdc1, LSL #16
    MOVK  X13, #0x59b4, LSL #32
    MOVK  X13, #0x9e28, LSL #48
    MOVZ  X14, #0xb301, LSL #0
    MOVK  X14, #0x6dea, LSL #16
    MOVK  X14, #0x7a32, LSL #32
    MOVK  X14, #0x306a, LSL #48
    MOVZ  X15, #0x9d10, LSL #0
    MOVK  X15, #0x85cd, LSL #16
    MOVK  X15, #0xcac8, LSL #32
    MOVK  X15, #0x57b0, LSL #48
    MOVZ  X16, #0x64f0, LSL #0
    MOVK  X16, #0x9854, LSL #16
    MOVK  X16, #0x8748, LSL #32
    MOVK  X16, #0x504b, LSL #48
    MOVZ  X17, #0xb52c, LSL #0
    MOVK  X17, #0xad6a, LSL #16
    MOVK  X17, #0xa9b5, LSL #32
    MOVK  X17, #0xfeff, LSL #48
    MOVZ  X18, #0x114a, LSL #0
    MOVK  X18, #0x24d9, LSL #16
    MOVK  X18, #0xa916, LSL #32
    MOVK  X18, #0xb43a, LSL #48
    MOVZ  X19, #0x6123, LSL #0
    MOVK  X19, #0x962f, LSL #16
    MOVK  X19, #0x435d, LSL #32
    MOVK  X19, #0x219d, LSL #48
    MOVZ  X20, #0x6c6e, LSL #0
    MOVK  X20, #0x7823, LSL #16
    MOVK  X20, #0x5608, LSL #32
    MOVK  X20, #0x572d, LSL #48
    MOVZ  X21, #0xdebc, LSL #0
    MOVK  X21, #0xc375, LSL #16
    MOVK  X21, #0xb1d0, LSL #32
    MOVK  X21, #0x4762, LSL #48
    MOVZ  X22, #0xe0e5, LSL #0
    MOVK  X22, #0x6703, LSL #16
    MOVK  X22, #0xce8e, LSL #32
    MOVK  X22, #0xde41, LSL #48
    MOVZ  X23, #0xd255, LSL #0
    MOVK  X23, #0x90f7, LSL #16
    MOVK  X23, #0xdaad, LSL #32
    MOVK  X23, #0xd2ac, LSL #48
    MOVZ  X24, #0xc92a, LSL #0
    MOVK  X24, #0x5806, LSL #16
    MOVK  X24, #0xc95e, LSL #32
    MOVK  X24, #0x3eb6, LSL #48
    DUP     Z0.D, X8
    DUP     Z1.D, X5
    DUP     Z2.D, X6
    DUP     Z3.D, X21
    DUP     Z4.D, X22
    DUP     Z5.D, X24
    DUP     Z6.D, X23
    DUP     Z7.D, X18
    DUP     Z8.D, X17
    DUP     Z9.D, X18
    DUP     Z10.D, X14
    DUP     Z11.D, X3
    DUP     Z12.D, X18
    DUP     Z13.D, X19
    DUP     Z14.D, X22
    DUP     Z15.D, X14
    DUP     Z16.D, X13
    DUP     Z17.D, X2
    DUP     Z18.D, X7
    DUP     Z19.D, X14
    DUP     Z20.D, X23
    DUP     Z21.D, X19
    DUP     Z22.D, X9
    DUP     Z23.D, X22
    DUP     Z24.D, X22
    DUP     Z25.D, X4
    DUP     Z26.D, X9
    DUP     Z27.D, X3
    DUP     Z28.D, X23
    DUP     Z29.D, X20
    DUP     Z30.D, X6
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
    MOVZ  X14, #0xa, LSL #0
LCRTSveMoveOperations_label_10:
    INDEX   Z1.S, W6, W9
    UZP1    Z13.B, Z26.B, Z30.B
    ZIP1    Z5.H, Z12.H, Z13.H
    SUNPKLO Z28.S, Z26.H
    TRN1    P13.H, P12.H, P2.H
    REV     P8.D, P14.D
    CLASTA  S25, P2, S25, Z1.S
    UZP2    P13.H, P3.H, P7.H
    UZP1    P12.H, P9.H, P5.H
    INDEX   Z13.H, W3, #-12
    INDEX   Z15.D, X11, X3
    SUNPKHI Z7.S, Z15.H
    UUNPKLO Z13.S, Z25.H
    INSR    Z5.H, H13
    CLASTA  D7, P4, D7, Z28.D
    INSR    Z22.D, X3
    PUNPKLO P12.H, P12.B
    REV     P0.B, P12.B
    UUNPKLO Z1.D, Z4.S
    SPLICE  Z15.S, P3, Z15.S, Z23.S
    MOV Z28.B,B9
    UUNPKHI Z22.D, Z24.S
    UUNPKHI Z10.S, Z26.H
    UZP2    P2.H, P6.H, P5.H
    MOV Z18.B,B12
    UZP1    P2.H, P15.H, P13.H
    INDEX   Z23.D, #2, X5
    UZP1    P5.D, P2.D, P2.D
    INDEX   Z4.D, X6, X11
    SUNPKLO Z24.H, Z5.B
    INDEX   Z19.S, W16, W7
    INDEX   Z0.D, #0, X24
    INDEX   Z28.H, #-4, #-4
    TRN1    Z19.D, Z10.D, Z19.D
    LASTB   X5, P0, Z1.D
    TRN2    P5.B, P6.B, P13.B
    UZP1    P0.D, P5.D, P5.D
    REV     P11.S, P6.S
    UUNPKLO Z3.S, Z22.H
    INDEX   Z20.B, #8, #-4
    MOV Z13.D,D15
    UZP1    Z15.S, Z4.S, Z20.S
    INDEX   Z11.S, #5, #9
    INDEX   Z16.S, #7, W18
    INDEX   Z22.D, #-2, #-13
    INDEX   Z21.H, W10, W24
    UZP1    P10.D, P5.D, P7.D
    TRN1    P15.S, P1.S, P13.S
    INDEX   Z22.H, #-8, #8
    INDEX   Z26.D, X22, X23
    INDEX   Z19.S, W13, W8
    TRN1    Z24.H, Z16.H, Z21.H
    LASTA   W13, P4, Z11.B
    UUNPKHI Z16.S, Z3.H
    ZIP1    P9.S, P13.S, P0.S
    SUNPKLO Z0.H, Z13.B
    SUNPKLO Z1.D, Z7.S
    UUNPKHI Z21.S, Z24.H
    SUNPKHI Z2.D, Z15.S
    LASTA   W22, P0, Z0.B
    SUNPKLO Z23.D, Z21.S
    ZIP2    P7.H, P2.H, P12.H
    MOV     Z1.D, P0/M, D2
    UUNPKHI Z15.S, Z16.H
    UUNPKHI Z13.D, Z19.S
    INSR    Z13.H, H23
    ZIP2    P10.B, P11.B, P5.B
    ZIP1    Z31.H, Z26.H, Z22.H
    INDEX   Z23.D, #-16, X22
    TRN1    Z12.S, Z4.S, Z12.S
    DUP Z31.D,Z23.D[5]
    PUNPKHI P4.H, P3.B
    UUNPKHI Z2.D, Z26.S
    INDEX   Z11.D, X15, #0
    INDEX   Z0.D, #-13, X12
    PUNPKLO P7.H, P6.B
    UUNPKHI Z21.D, Z0.S
    UZP1    P4.D, P4.D, P9.D
    REV     P13.D, P2.D
    ZIP1    Z15.D, Z23.D, Z12.D
    REV     P15.S, P4.S
    LASTA   S7, P4, Z13.S
    CLASTB  Z21.H, P2, Z21.H, Z16.H
    UZP1    P9.B, P15.B, P4.B
    SUNPKHI Z16.H, Z21.B
    SUNPKLO Z5.H, Z15.B
    UZP1    P5.B, P5.B, P10.B
    INSR    Z4.H, H31
    TRN2    P14.S, P15.S, P12.S
    REV     P7.H, P7.H
    TRN2    P5.B, P8.B, P3.B
    INDEX   Z0.B, W11, W13
    PUNPKLO P15.H, P5.B
    ZIP2    P10.H, P4.H, P8.H
    REVB    Z17.D, P7/M, Z7.D
    DUP Z11.H,Z21.H[14]
    UUNPKHI Z1.S, Z17.H
    INDEX   Z29.S, #-9, W9
    UUNPKLO Z0.S, Z16.H
    UUNPKLO Z19.D, Z0.S
    UZP1    P13.S, P4.S, P1.S
    REV     Z15.H, Z4.H
    INDEX   Z26.H, #-9, #-14
    INDEX   Z31.S, #5, W5
    INDEX   Z16.D, X23, #4
    ZIP1    P8.H, P6.H, P3.H
    UUNPKHI Z7.D, Z18.S
    UZP2    P3.D, P10.D, P8.D
    INDEX   Z1.S, W14, W2
    SPLICE  Z11.H, P1, Z11.H, Z1.H
    SUNPKLO Z14.S, Z11.H
    UUNPKLO Z21.H, Z26.B
    REVB    Z4.S, P4/M, Z1.S
    UUNPKLO Z21.S, Z1.H
    CLASTB  X6, P3, X6, Z21.D
    MOV Z26.Q,Q4
    TRN2    P7.B, P9.B, P13.B
    TRN2    P13.H, P5.H, P5.H
    INDEX   Z18.D, #-2, #-13
    UZP1    P15.B, P9.B, P6.B
    UZP1    P3.D, P9.D, P11.D
    PUNPKLO P13.H, P9.B
    INDEX   Z4.H, #-4, W18
    INDEX   Z21.H, #10, #8
    MOV Z2.B,Z7.B[41]
    LASTA   X16, P4, Z19.D
    UUNPKHI Z7.D, Z26.S
    LASTA   H11, P3, Z0.H
    INDEX   Z16.D, #-6, #-4
    INDEX   Z15.H, #-6, #-8
    UZP2    P2.H, P14.H, P13.H
    LASTA   W6, P0, Z16.B
    ZIP1    P0.D, P8.D, P12.D
    SUNPKHI Z16.H, Z4.B
    INDEX   Z3.B, W16, W9
    ZIP1    P13.D, P1.D, P3.D
    INSR    Z7.D, D2
    CLASTA  Z14.D, P7, Z14.D, Z15.D
    SUNPKLO Z2.H, Z11.B
    INDEX   Z4.B, #-15, W3
    INDEX   Z15.D, X10, #14
    SUNPKLO Z11.H, Z3.B
    CLASTB  S2, P0, S2, Z15.S
    INDEX   Z28.D, X10, X18
    INDEX   Z28.D, #7, X7
    INDEX   Z5.B, W13, #6
    INDEX   Z19.H, W12, W24
    TRN2    P11.H, P10.H, P13.H
    UUNPKHI Z26.H, Z18.B
    CLASTA  W10, P3, W10, Z16.B
    SUNPKLO Z3.D, Z19.S
    SUNPKHI Z19.H, Z3.B
    ZIP2    P7.H, P10.H, P4.H
    ZIP2    P2.D, P8.D, P12.D
    SUNPKLO Z15.D, Z24.S
    UZP2    P0.S, P8.S, P15.S
    UUNPKHI Z30.D, Z14.S
    TRN1    P1.S, P9.S, P13.S
    UZP1    P13.S, P15.S, P0.S
    REV     P13.H, P12.H
    ZIP1    Z6.H, Z30.H, Z28.H
    UUNPKLO Z24.H, Z11.B
    INDEX   Z22.D, X3, #-12
    SUNPKLO Z28.H, Z5.B
    TRN1    P9.H, P10.H, P9.H
    SUNPKLO Z16.S, Z24.H
    SUNPKHI Z14.S, Z15.H
    TRN2    P3.S, P11.S, P3.S
    UUNPKHI Z27.S, Z2.H
    INDEX   Z15.H, #-1, W5
    TRN1    P2.D, P15.D, P10.D
    INDEX   Z18.B, W9, W14
    INDEX   Z30.H, W9, W24
    INDEX   Z11.B, #-1, W3
    SUNPKLO Z5.S, Z18.H
    LASTB   W9, P2, Z6.B
    REVH    Z24.D, P1/M, Z30.D
    TRN1    P7.B, P4.B, P13.B
    UUNPKLO Z6.H, Z28.B
    UZP1    P8.S, P13.S, P14.S
    INDEX   Z5.S, W13, W8
    MOV     Z2.B, P1/M, B10
    UZP2    P15.H, P1.H, P4.H
    LASTA   D30, P2, Z2.D
    INDEX   Z13.B, W3, #-12
    INSR    Z11.H, W7
    REV     P4.B, P8.B
    SUNPKLO Z0.D, Z24.S
    INDEX   Z28.H, #-10, #-10
    INDEX   Z10.B, #-5, W16
    INSR    Z28.H, H6
    TRN1    Z27.D, Z5.D, Z30.D
    REV     Z24.B, Z23.B
    ZIP2    P2.D, P11.D, P6.D
    UUNPKHI Z6.D, Z17.S
    REVW    Z23.D, P2/M, Z13.D
    CLASTA  H25, P2, H25, Z27.H
    INDEX   Z2.H, W2, #-11
    INDEX   Z13.D, #0, #9
    ZIP2    Z6.D, Z13.D, Z24.D
    SUBS  X14, X14, #0x1
    B.NE  LCRTSveMoveOperations_label_10
    MOVZ  X4, #0x1ee2, LSL #0
    MOVK  X4, #0xe638, LSL #16
    MOVK  X4, #0xa04d, LSL #32
    MOVK  X4, #0x6393, LSL #48
    SUB  X19, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x3236, LSL #0
    MOVK  X4, #0xbf30, LSL #16
    MOVK  X4, #0x71ff, LSL #32
    MOVK  X4, #0x7be5, LSL #48
    SUB  X19, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xaf79, LSL #0
    MOVK  X4, #0x1be5, LSL #16
    SUB  X19, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xfa, LSL #0
    SUB  X19, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x8b74, LSL #0
    MOVK  X4, #0x3e12, LSL #16
    MOVK  X4, #0xa5b2, LSL #32
    MOVK  X4, #0xa35a, LSL #48
    SUB  X19, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xddfc, LSL #0
    MOVK  X4, #0x72a, LSL #16
    MOVK  X4, #0xb2d1, LSL #32
    MOVK  X4, #0x3e0, LSL #48
    SUB  X19, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xa3, LSL #0
    SUB  X19, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x4c, LSL #0
    SUB  X19, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x3109, LSL #0
    MOVK  X4, #0x7a7c, LSL #16
    MOVK  X4, #0x81eb, LSL #32
    MOVK  X4, #0xbf7c, LSL #48
    SUB  X19, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5b0a, LSL #0
    MOVK  X4, #0x7293, LSL #16
    MOVK  X4, #0x74d3, LSL #32
    MOVK  X4, #0x96c, LSL #48
    SUB  X19, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x5, LSL #0
    SUB  X19, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x9d10, LSL #0
    MOVK  X4, #0x85cd, LSL #16
    MOVK  X4, #0xcac8, LSL #32
    MOVK  X4, #0x57b0, LSL #48
    SUB  X19, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xb52c, LSL #0
    MOVK  X4, #0xad6a, LSL #16
    MOVK  X4, #0xa9b5, LSL #32
    MOVK  X4, #0xfeff, LSL #48
    SUB  X19, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x114a, LSL #0
    MOVK  X4, #0x24d9, LSL #16
    MOVK  X4, #0xa916, LSL #32
    MOVK  X4, #0xb43a, LSL #48
    SUB  X19, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xdebc, LSL #0
    MOVK  X4, #0xc375, LSL #16
    MOVK  X4, #0xb1d0, LSL #32
    MOVK  X4, #0x4762, LSL #48
    SUB  X19, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x9, LSL #0
    SUB  X19, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xd255, LSL #0
    MOVK  X4, #0x90f7, LSL #16
    MOVK  X4, #0xdaad, LSL #32
    MOVK  X4, #0xd2ac, LSL #48
    SUB  X19, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0xc92a, LSL #0
    MOVK  X4, #0x5806, LSL #16
    MOVK  X4, #0xc95e, LSL #32
    MOVK  X4, #0x3eb6, LSL #48
    SUB  X19, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveMoveOperations_TestFail
    MRS  X4, FPSR
    MOVZ  X19, #0x95, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X19, #0xc9cd, LSL #0
    MOVK  X19, #0xa3, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D0
    MOVZ  X19, #0x5c21, LSL #0
    MOVK  X19, #0x92f7, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X19, #0x3dc5, LSL #0
    MOVK  X19, #0xcc70, LSL #16
    MOVK  X19, #0x5ca7, LSL #32
    MOVK  X19, #0xb2a8, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D1
    MOVZ  X19, #0x1, LSL #0
    MOVK  X19, #0x1ee3, LSL #32
    MOVK  X19, #0xe638, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X19, #0x1eb6, LSL #0
    MOVK  X19, #0x1eab, LSL #16
    MOVK  X19, #0x1ea0, LSL #32
    MOVK  X19, #0x1e95, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D2
    MOVZ  X19, #0x1ee2, LSL #0
    MOVK  X19, #0x1ed7, LSL #16
    MOVK  X19, #0x1ecc, LSL #32
    MOVK  X19, #0x1ec1, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X19, #0xed5e, LSL #0
    MOVK  X19, #0xb688, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D3
    MOVZ  X19, #0x5b0a, LSL #0
    MOVK  X19, #0x2434, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X19, #0xd7a1, LSL #0
    MOVK  X19, #0x430d, LSL #16
    MOVK  X19, #0xaf79, LSL #32
    MOVK  X19, #0x1be5, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D4
    MOVZ  X19, #0x27f1, LSL #0
    MOVK  X19, #0x935d, LSL #16
    MOVK  X19, #0xffc9, LSL #32
    MOVK  X19, #0x6b35, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X19, #0xbbfd, LSL #0
    MOVK  X19, #0xe55, LSL #16
    MOVK  X19, #0x99f9, LSL #32
    MOVK  X19, #0x1580, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D5
    MOVZ  X19, #0x5, LSL #0
    MOVK  X19, #0xde01, LSL #32
    MOVK  X19, #0x72a, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xf9ff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D6
    MOVZ  X19, #0x12, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x100, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X19, #0xb52c, LSL #0
    MOVK  X19, #0xad6a, LSL #16
    MOVK  X19, #0xa9b5, LSL #32
    MOVK  X19, #0xfeff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D8
    MOVZ  X19, #0xb52c, LSL #0
    MOVK  X19, #0xad6a, LSL #16
    MOVK  X19, #0xa9b5, LSL #32
    MOVK  X19, #0xfeff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X19, #0x114a, LSL #0
    MOVK  X19, #0x24d9, LSL #16
    MOVK  X19, #0xa916, LSL #32
    MOVK  X19, #0xb43a, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D9
    MOVZ  X19, #0x114a, LSL #0
    MOVK  X19, #0x24d9, LSL #16
    MOVK  X19, #0xa916, LSL #32
    MOVK  X19, #0xb43a, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X19, #0xfbfb, LSL #0
    MOVK  X19, #0xfbfb, LSL #16
    MOVK  X19, #0xfbfb, LSL #32
    MOVK  X19, #0xfbfb, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D10
    MOVZ  X19, #0xfbfb, LSL #0
    MOVK  X19, #0xfbfb, LSL #16
    MOVK  X19, #0xfbfb, LSL #32
    MOVK  X19, #0xfbfb, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X19, #0x7943, LSL #0
    MOVK  X19, #0xe5af, LSL #16
    MOVK  X19, #0x511b, LSL #32
    MOVK  X19, #0xbd87, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D11
    MOVZ  X19, #0x8b74, LSL #0
    MOVK  X19, #0x35ff, LSL #16
    MOVK  X19, #0xa16b, LSL #32
    MOVK  X19, #0xdd7, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X19, #0x3203, LSL #0
    MOVK  X19, #0x7a7c, LSL #16
    MOVK  X19, #0x3203, LSL #32
    MOVK  X19, #0x7a7c, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D12
    MOVZ  X19, #0xfa, LSL #0
    MOVK  X19, #0xfa, LSL #32
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X19, #0x9, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D14
    MOVZ  X19, #0x229b, LSL #0
    MOVK  X19, #0x24f4, LSL #32
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X19, #0xbde3, LSL #0
    MOVK  X19, #0x6d5c, LSL #16
    MOVK  X19, #0x1cd5, LSL #32
    MOVK  X19, #0xcc4e, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D15
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xaf78, LSL #16
    MOVK  X19, #0x5ef1, LSL #32
    MOVK  X19, #0xe6a, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X19, #0xa3, LSL #0
    MOVK  X19, #0xff, LSL #32
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D17
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xf577, LSL #32
    MOVK  X19, #0x2f45, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X19, #0xacab, LSL #0
    MOVK  X19, #0xaead, LSL #16
    MOVK  X19, #0xb0af, LSL #32
    MOVK  X19, #0xb2b1, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D18
    MOVZ  X19, #0xa4a3, LSL #0
    MOVK  X19, #0xa6a5, LSL #16
    MOVK  X19, #0xa8a7, LSL #32
    MOVK  X19, #0xaaa9, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D19
    MOVZ  X19, #0xffb2, LSL #0
    MOVK  X19, #0x7f, LSL #16
    MOVK  X19, #0xffdc, LSL #32
    MOVK  X19, #0x48, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X19, #0xe4e8, LSL #0
    MOVK  X19, #0xdce0, LSL #16
    MOVK  X19, #0xd4d8, LSL #32
    MOVK  X19, #0xccd0, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D20
    MOVZ  X19, #0x408, LSL #0
    MOVK  X19, #0xfc00, LSL #16
    MOVK  X19, #0xf4f8, LSL #32
    MOVK  X19, #0xecf0, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X19, #0x2a, LSL #0
    MOVK  X19, #0x32, LSL #16
    MOVK  X19, #0x3a, LSL #32
    MOVK  X19, #0x42, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D21
    MOVZ  X19, #0xa, LSL #0
    MOVK  X19, #0x12, LSL #16
    MOVK  X19, #0x1a, LSL #32
    MOVK  X19, #0x22, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X19, #0x322a, LSL #0
    MOVK  X19, #0xbf30, LSL #16
    MOVK  X19, #0x71ff, LSL #32
    MOVK  X19, #0x7be5, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D22
    MOVZ  X19, #0x3236, LSL #0
    MOVK  X19, #0xbf30, LSL #16
    MOVK  X19, #0x71ff, LSL #32
    MOVK  X19, #0x7be5, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X19, #0x9aa6, LSL #0
    MOVK  X19, #0x828e, LSL #16
    MOVK  X19, #0xcad6, LSL #32
    MOVK  X19, #0xb2be, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D23
    MOVZ  X19, #0xfa06, LSL #0
    MOVK  X19, #0xe2ee, LSL #16
    MOVK  X19, #0x2a36, LSL #32
    MOVK  X19, #0x121e, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x200, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D24
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xb00, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D25
    MOVZ  X19, #0x5, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X19, #0xff, LSL #0
    MOVK  X19, #0xff, LSL #16
    MOVK  X19, #0xff, LSL #32
    MOVK  X19, #0xff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D26
    MOVZ  X19, #0xe4, LSL #0
    MOVK  X19, #0xff, LSL #16
    MOVK  X19, #0xff, LSL #32
    MOVK  X19, #0xff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X19, #0xd7d7, LSL #0
    MOVK  X19, #0xd7d7, LSL #16
    MOVK  X19, #0xd7d7, LSL #32
    MOVK  X19, #0xd7d7, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D27
    MOVZ  X19, #0x5, LSL #0
    MOVK  X19, #0xde01, LSL #32
    MOVK  X19, #0x72a, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X19, #0xffd8, LSL #0
    MOVK  X19, #0xffce, LSL #16
    MOVK  X19, #0xffc4, LSL #32
    MOVK  X19, #0xffba, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D28
    MOVZ  X19, #0x5, LSL #0
    MOVK  X19, #0xfff6, LSL #16
    MOVK  X19, #0xffec, LSL #32
    MOVK  X19, #0xffe2, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X19, #0x13d, LSL #0
    MOVK  X19, #0x1e0, LSL #32
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D29
    MOVZ  X19, #0xfff7, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x9a, LSL #32
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D30
    MOVZ  X19, #0xd7d7, LSL #0
    MOVK  X19, #0xd7d7, LSL #16
    MOVK  X19, #0xd7d7, LSL #32
    MOVK  X19, #0xd7d7, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X19, #0x5ef7, LSL #0
    MOVK  X19, #0x37cb, LSL #16
    MOVK  X19, #0xe70, LSL #32
    MOVK  X19, #0x53b1, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FMOV  X4, D31
    MOVZ  X19, #0x5, LSL #0
    MOVK  X19, #0xaf7e, LSL #32
    MOVK  X19, #0x1be5, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xf7ff, LSL #0
    MOVK  X19, #0xff7f, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xfff7, LSL #0
    MOVK  X19, #0xffdd, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xddff, LSL #0
    MOVK  X19, #0xfdff, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xff8a, LSL #0
    MOVK  X19, #0xaaaa, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0x88aa, LSL #0
    MOVK  X19, #0xadaf, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xfbff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0x5555, LSL #0
    MOVK  X19, #0x51ff, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xff7f, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0x77ff, LSL #0
    MOVK  X19, #0x77ff, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xddff, LSL #0
    MOVK  X19, #0xddf7, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0x5555, LSL #0
    MOVK  X19, #0x5555, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0x5555, LSL #0
    MOVK  X19, #0x5555, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0x5f5f, LSL #0
    MOVK  X19, #0x5551, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xf7df, LSL #0
    MOVK  X19, #0xff45, LSL #16
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
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
    FMOV  X4, D0
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D1, P0, Z1.D
    FMOV  X4, D1
    MOVZ  X19, #0x7b88, LSL #0
    MOVK  X19, #0x98e0, LSL #16
    MOVK  X19, #0x9a6b, LSL #32
    MOVK  X19, #0x7f18, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X4, D2
    MOVZ  X19, #0xa8c1, LSL #0
    MOVK  X19, #0x1735, LSL #16
    MOVK  X19, #0x35a9, LSL #32
    MOVK  X19, #0x1ec4, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X4, D3
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X4, D4
    MOVZ  X19, #0x3700, LSL #0
    MOVK  X19, #0xa36d, LSL #16
    MOVK  X19, #0xfd9, LSL #32
    MOVK  X19, #0x7b45, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X4, D5
    MOVZ  X19, #0x33ed, LSL #0
    MOVK  X19, #0x2b01, LSL #16
    MOVK  X19, #0x11e9, LSL #32
    MOVK  X19, #0x322c, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X4, D6
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xf9ff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X4, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X4, D8
    MOVZ  X19, #0xb52c, LSL #0
    MOVK  X19, #0xad6a, LSL #16
    MOVK  X19, #0xa9b5, LSL #32
    MOVK  X19, #0xff1f, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X4, D9
    MOVZ  X19, #0x114a, LSL #0
    MOVK  X19, #0x24d9, LSL #16
    MOVK  X19, #0xa916, LSL #32
    MOVK  X19, #0xb45a, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X4, D10
    MOVZ  X19, #0xfbfb, LSL #0
    MOVK  X19, #0xfbfb, LSL #16
    MOVK  X19, #0xfbfb, LSL #32
    MOVK  X19, #0xfc1b, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D11, P5, Z11.D
    FMOV  X4, D11
    MOVZ  X19, #0x29f2, LSL #0
    MOVK  X19, #0x955f, LSL #16
    MOVK  X19, #0x1cb, LSL #32
    MOVK  X19, #0x6d37, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X4, D12
    MOVZ  X19, #0x3202, LSL #0
    MOVK  X19, #0x7a7c, LSL #16
    MOVK  X19, #0x3203, LSL #32
    MOVK  X19, #0x7a7c, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X4, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X4, D14
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X4, D15
    MOVZ  X19, #0xbde1, LSL #0
    MOVK  X19, #0x6d5c, LSL #16
    MOVK  X19, #0x1cd5, LSL #32
    MOVK  X19, #0xcc4e, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X4, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X4, D17
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xf577, LSL #32
    MOVK  X19, #0x2f45, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X4, D18
    MOVZ  X19, #0xbcbb, LSL #0
    MOVK  X19, #0xbebd, LSL #16
    MOVK  X19, #0xc0bf, LSL #32
    MOVK  X19, #0xc2c1, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D19, P5, Z19.D
    FMOV  X4, D19
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X4, D20
    MOVZ  X19, #0x408, LSL #0
    MOVK  X19, #0xfc00, LSL #16
    MOVK  X19, #0xf4f8, LSL #32
    MOVK  X19, #0xecf0, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X4, D21
    MOVZ  X19, #0xe87e, LSL #0
    MOVK  X19, #0x8889, LSL #16
    MOVK  X19, #0xe894, LSL #32
    MOVK  X19, #0x87, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D22, P2, Z22.D
    FMOV  X4, D22
    MOVZ  X19, #0x3224, LSL #0
    MOVK  X19, #0xbf30, LSL #16
    MOVK  X19, #0x71ff, LSL #32
    MOVK  X19, #0x7c05, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X4, D23
    MOVZ  X19, #0xdae5, LSL #0
    MOVK  X19, #0xc2ce, LSL #16
    MOVK  X19, #0xa16, LSL #32
    MOVK  X19, #0xf2fe, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X4, D24
    MOVZ  X19, #0xfffe, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xf9ff, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X4, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X4, D26
    MOVZ  X19, #0xee, LSL #0
    MOVK  X19, #0xff, LSL #16
    MOVK  X19, #0xff, LSL #32
    MOVK  X19, #0x11f, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X4, D27
    MOVZ  X19, #0xd7d5, LSL #0
    MOVK  X19, #0xd7d7, LSL #16
    MOVK  X19, #0xd7d7, LSL #32
    MOVK  X19, #0xd7d7, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X4, D28
    MOVZ  X19, #0x96fd, LSL #0
    MOVK  X19, #0xfcec, LSL #16
    MOVK  X19, #0x12e1, LSL #32
    MOVK  X19, #0xffe7, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D29, P2, Z29.D
    FMOV  X4, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X4, D30
    MOVZ  X19, #0xd7d7, LSL #0
    MOVK  X19, #0xd7d7, LSL #16
    MOVK  X19, #0xd7d7, LSL #32
    MOVK  X19, #0xd7d7, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X4, D31
    MOVZ  X19, #0x5ef6, LSL #0
    MOVK  X19, #0x37cb, LSL #16
    MOVK  X19, #0xe70, LSL #32
    MOVK  X19, #0x53b1, LSL #48
    SUB  X20, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    DUP     Z0.D, X3
    DUP     Z1.D, X4
    DUP     Z2.D, X11
    DUP     Z3.D, X5
    DUP     Z4.D, X23
    DUP     Z5.D, X19
    DUP     Z6.D, X21
    DUP     Z7.D, X6
    DUP     Z8.D, X17
    DUP     Z9.D, X3
    DUP     Z10.D, X24
    DUP     Z11.D, X15
    DUP     Z12.D, X18
    DUP     Z13.D, X20
    DUP     Z14.D, X15
    DUP     Z15.D, X14
    DUP     Z16.D, X23
    DUP     Z17.D, X16
    DUP     Z18.D, X9
    DUP     Z19.D, X21
    DUP     Z20.D, X16
    DUP     Z21.D, X7
    DUP     Z22.D, X8
    DUP     Z23.D, X11
    DUP     Z24.D, X23
    DUP     Z25.D, X15
    DUP     Z26.D, X11
    DUP     Z27.D, X21
    DUP     Z28.D, X12
    DUP     Z29.D, X14
    DUP     Z30.D, X24
    DUP     Z31.D, X18
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
    MOVZ  X4, #0xa, LSL #0
LCRTSveMoveOperations_label_11:
    CLASTB  W5, P4, W5, Z17.H
    ZIP2    P2.D, P14.D, P3.D
    INDEX   Z14.D, #-7, #-16
    TRN1    P15.S, P11.S, P12.S
    SUNPKHI Z0.D, Z25.S
    CLASTA  D0, P2, D0, Z10.D
    SUNPKHI Z24.S, Z13.H
    REV     P13.H, P5.H
    INDEX   Z29.H, #15, W16
    SUNPKHI Z20.H, Z0.B
    MOV Z27.H,Z20.H[5]
    MOV Z29.S,Z29.S[5]
    INSR    Z14.D, D29
    UUNPKLO Z7.S, Z27.H
    INDEX   Z21.B, W17, #-4
    INDEX   Z9.D, X15, #0
    UUNPKLO Z22.S, Z7.H
    INDEX   Z8.H, #-9, W23
    UZP1    Z23.B, Z18.B, Z8.B
    SUNPKHI Z9.D, Z23.S
    SPLICE  Z24.S, P1, Z24.S, Z14.S
    UUNPKLO Z23.S, Z22.H
    SUNPKLO Z17.S, Z25.H
    REVH    Z25.D, P1/M, Z23.D
    MOV     Z14.D, P2/M, D25
    LASTA   H8, P4, Z24.H
    UZP1    P8.D, P13.D, P13.D
    INDEX   Z18.B, W3, #-3
    SUNPKLO Z29.H, Z2.B
    UUNPKLO Z0.D, Z17.S
    CLASTB  D7, P4, D7, Z9.D
    DUP Z10.S,Z7.S[3]
    CLASTB  W18, P7, W18, Z8.H
    UZP2    P3.D, P6.D, P14.D
    TRN2    P4.B, P2.B, P8.B
    UUNPKLO Z5.D, Z24.S
    SUNPKLO Z15.S, Z5.H
    MOV     Z2.H, P4/M, H29
    INDEX   Z5.D, #-13, X24
    INDEX   Z7.D, #-4, X3
    INDEX   Z5.D, X19, #-2
    REVB    Z16.D, P2/M, Z1.D
    REV     P1.S, P6.S
    TRN1    P9.H, P0.H, P10.H
    ZIP2    P1.H, P9.H, P14.H
    REV     P2.H, P7.H
    TRN2    P14.S, P13.S, P10.S
    SUNPKHI Z9.S, Z7.H
    INDEX   Z1.B, W24, #14
    UZP2    P10.B, P0.B, P12.B
    ZIP2    P0.B, P14.B, P10.B
    INSR    Z15.D, D22
    ZIP2    P10.B, P2.B, P15.B
    INDEX   Z22.B, #6, #12
    UUNPKHI Z24.H, Z11.B
    TRN2    P8.B, P12.B, P6.B
    SUNPKLO Z11.S, Z10.H
    SUNPKLO Z10.H, Z22.B
    DUP Z0.S,Z31.S[14]
    INSR    Z5.H, W24
    INDEX   Z27.D, X23, #13
    UUNPKHI Z7.S, Z31.H
    ZIP1    P13.S, P9.S, P4.S
    UUNPKLO Z31.S, Z5.H
    CLASTB  Z21.S, P3, Z21.S, Z15.S
    UUNPKHI Z7.H, Z7.B
    CLASTB  W16, P5, W16, Z0.B
    SUNPKLO Z5.S, Z10.H
    INDEX   Z18.S, #-16, W14
    MOV Z28.D,Z21.D[1]
    ZIP1    P12.D, P3.D, P3.D
    INDEX   Z0.B, W18, W17
    REV     Z11.D, Z27.D
    INSR    Z31.D, X2
    INDEX   Z15.S, W9, #14
    REV     Z25.H, Z9.H
    UZP1    Z16.S, Z5.S, Z15.S
    INDEX   Z27.S, W12, #15
    INDEX   Z16.B, W12, W24
    INDEX   Z15.D, #10, X12
    ZIP2    P10.B, P8.B, P3.B
    INDEX   Z9.D, #-1, #-6
    REVH    Z10.S, P1/M, Z0.S
    CLASTA  Z22.S, P7, Z22.S, Z25.S
    TRN2    P12.B, P15.B, P10.B
    INSR    Z8.D, D19
    UZP2    P3.B, P7.B, P0.B
    REVW    Z19.D, P2/M, Z26.D
    TRN2    P5.S, P6.S, P9.S
    CLASTA  H9, P1, H9, Z19.H
    CLASTA  H16, P7, H16, Z10.H
    LASTB   W19, P1, Z27.B
    SUNPKLO Z5.S, Z1.H
    INDEX   Z1.D, X3, #-10
    CLASTB  W3, P0, W3, Z30.B
    LASTB   W16, P7, Z8.H
    LASTB   H25, P5, Z10.H
    ZIP2    P6.D, P5.D, P12.D
    CLASTB  W21, P6, W21, Z1.H
    TRN2    Z19.H, Z9.H, Z28.H
    INDEX   Z10.S, W16, W12
    INDEX   Z27.H, #8, W4
    INDEX   Z30.S, W3, #4
    UUNPKHI Z26.H, Z22.B
    INDEX   Z1.B, W19, #-16
    SUNPKLO Z22.S, Z5.H
    SUNPKHI Z15.H, Z23.B
    SUNPKLO Z14.S, Z1.H
    SUNPKHI Z15.D, Z15.S
    UUNPKLO Z23.D, Z26.S
    ZIP1    Z8.D, Z22.D, Z30.D
    ZIP1    P11.B, P4.B, P14.B
    CLASTB  W3, P1, W3, Z10.H
    INDEX   Z28.B, #1, W12
    PUNPKHI P2.H, P12.B
    UUNPKHI Z10.D, Z8.S
    LASTA   H27, P2, Z23.H
    UZP1    P10.S, P10.S, P9.S
    INDEX   Z30.S, #8, #6
    UUNPKLO Z8.D, Z25.S
    SUNPKHI Z15.H, Z4.B
    INDEX   Z23.D, #7, #-7
    TRN1    P10.S, P2.S, P0.S
    UUNPKHI Z5.S, Z27.H
    PUNPKHI P3.H, P0.B
    REV     P8.S, P9.S
    REV     P9.B, P8.B
    TRN1    Z22.S, Z10.S, Z24.S
    ZIP1    P3.H, P12.H, P2.H
    INDEX   Z25.B, W9, W23
    SUNPKHI Z10.H, Z23.B
    UZP1    P10.S, P0.S, P14.S
    INDEX   Z26.S, W13, W6
    UZP2    P12.B, P2.B, P15.B
    PUNPKLO P7.H, P11.B
    REV     P14.B, P6.B
    SUNPKLO Z31.D, Z24.S
    INDEX   Z24.B, W12, #-14
    TRN1    P5.H, P14.H, P9.H
    TRN2    P8.S, P5.S, P0.S
    SUNPKLO Z27.H, Z26.B
    REV     P11.S, P0.S
    SUNPKLO Z20.D, Z22.S
    TRN2    P5.H, P6.H, P11.H
    INDEX   Z16.D, X9, #10
    UUNPKHI Z25.S, Z10.H
    UZP1    P5.B, P1.B, P9.B
    SUNPKLO Z8.S, Z16.H
    INDEX   Z27.D, #14, #-14
    UZP2    Z10.B, Z25.B, Z25.B
    TBL     Z20.H,  Z24.H, Z31.H
    INDEX   Z25.S, #-13, W9
    MOV Z16.B,Z10.B[53]
    LASTB   W2, P1, Z20.B
    UZP2    P13.S, P14.S, P15.S
    UUNPKHI Z30.H, Z26.B
    UUNPKLO Z24.H, Z16.B
    ZIP2    P7.H, P4.H, P10.H
    SUNPKHI Z23.D, Z24.S
    ZIP1    P3.D, P6.D, P0.D
    UZP1    P8.B, P2.B, P7.B
    UUNPKLO Z11.S, Z0.H
    SUNPKLO Z0.S, Z11.H
    INDEX   Z11.H, #-1, W14
    CLASTA  D25, P5, D25, Z11.D
    TRN1    P6.B, P3.B, P4.B
    INDEX   Z2.S, #5, W5
    TRN1    P14.D, P12.D, P3.D
    SUNPKHI Z23.D, Z30.S
    REVH    Z20.D, P6/M, Z27.D
    TRN1    P14.H, P15.H, P13.H
    TRN2    P12.B, P14.B, P1.B
    TRN1    Z4.D, Z6.D, Z10.D
    UUNPKHI Z14.H, Z0.B
    INDEX   Z3.H, W3, W8
    UUNPKHI Z24.H, Z2.B
    EXT     Z4.B, Z4.B, Z23.B, #0x33
    INDEX   Z21.D, #2, #-16
    SUNPKHI Z11.S, Z24.H
    REV     Z15.B, Z11.B
    INDEX   Z23.S, #4, W18
    INDEX   Z0.S, #6, W7
    SUNPKHI Z30.H, Z20.B
    CLASTA  Z14.D, P2, Z14.D, Z4.D
    PUNPKLO P9.H, P0.B
    TBL     Z11.D,  Z24.D, Z0.D
    SUNPKHI Z2.D, Z14.S
    SUNPKLO Z5.D, Z8.S
    SUNPKHI Z8.S, Z18.H
    MOV     Z27.D, P3/M, D5
    PUNPKHI P3.H, P0.B
    ZIP1    P3.D, P6.D, P7.D
    MOV Z18.Q,Z27.Q[3]
    UZP1    P7.S, P9.S, P0.S
    SUNPKHI Z5.H, Z8.B
    ZIP1    P6.S, P4.S, P3.S
    UZP2    P9.H, P8.H, P6.H
    REV     P11.D, P11.D
    REV     P6.D, P7.D
    INDEX   Z9.D, #-5, X3
    SUBS  X4, X4, #0x1
    B.NE  LCRTSveMoveOperations_label_11
    MOVZ  X10, #0xf2, LSL #0
    SUB  X11, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0xffff, LSL #0
    SUB  X11, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveMoveOperations_TestFail
    MRS  X10, FPSR
    MOVZ  X11, #0x95, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X11, #0x6, LSL #0
    MOVK  X11, #0x6, LSL #32
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D0
    MOVZ  X11, #0x6, LSL #0
    MOVK  X11, #0x6, LSL #32
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X11, #0x7080, LSL #0
    MOVK  X11, #0x5060, LSL #16
    MOVK  X11, #0x3040, LSL #32
    MOVK  X11, #0x1020, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D1
    MOVZ  X11, #0xf000, LSL #0
    MOVK  X11, #0xd0e0, LSL #16
    MOVK  X11, #0xb0c0, LSL #32
    MOVK  X11, #0x90a0, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X11, #0xff, LSL #0
    MOVK  X11, #0xff, LSL #16
    MOVK  X11, #0xff, LSL #32
    MOVK  X11, #0xff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D5
    MOVZ  X11, #0xfff0, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X11, #0xfff0, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D8
    MOVZ  X11, #0xfff0, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X11, #0xfffb, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D9
    MOVZ  X11, #0xfffb, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X11, #0xff, LSL #0
    MOVK  X11, #0xff, LSL #16
    MOVK  X11, #0xff, LSL #32
    MOVK  X11, #0xff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D10
    MOVZ  X11, #0xff, LSL #0
    MOVK  X11, #0xff, LSL #16
    MOVK  X11, #0xff, LSL #32
    MOVK  X11, #0xff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D11
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x500, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D17
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D20
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xe, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X11, #0xfff2, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D21
    MOVZ  X11, #0x2, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D22
    MOVZ  X11, #0x2a1c, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X11, #0x4, LSL #0
    MOVK  X11, #0x4, LSL #32
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D23
    MOVZ  X11, #0x4, LSL #0
    MOVK  X11, #0x4, LSL #32
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X11, #0x5, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D24
    MOVZ  X11, #0x5, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D25
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X11, #0x101, LSL #0
    MOVK  X11, #0x101, LSL #16
    MOVK  X11, #0x101, LSL #32
    MOVK  X11, #0x101, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D28
    MOVZ  X11, #0x101, LSL #0
    MOVK  X11, #0x101, LSL #16
    MOVK  X11, #0x101, LSL #32
    MOVK  X11, #0x101, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xfff2, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D30
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FMOV  X10, D31
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0x5555, LSL #0
    MOVK  X11, #0x5555, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x5555, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0x5555, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xafaf, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xbfbf, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
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
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D1, P2, Z1.D
    FMOV  X10, D1
    MOVZ  X11, #0x8f8f, LSL #0
    MOVK  X11, #0x9090, LSL #16
    MOVK  X11, #0xa090, LSL #32
    MOVK  X11, #0x90b0, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X10, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X10, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X10, D4
    MOVZ  X11, #0xff, LSL #0
    MOVK  X11, #0xff, LSL #16
    MOVK  X11, #0xff, LSL #32
    MOVK  X11, #0x10f, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X10, D5
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X10, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X10, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X10, D8
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X10, D9
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X10, D10
    MOVZ  X11, #0xff, LSL #0
    MOVK  X11, #0xff, LSL #16
    MOVK  X11, #0xff, LSL #32
    MOVK  X11, #0x11f, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X10, D11
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X10, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X10, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X10, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X10, D15
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x510, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X10, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X10, D17
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X10, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X10, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X10, D20
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X10, D21
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X10, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X10, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X10, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X10, D25
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X10, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X10, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D28, P6, Z28.D
    FMOV  X10, D28
    MOVZ  X11, #0x101, LSL #0
    MOVK  X11, #0x101, LSL #16
    MOVK  X11, #0x101, LSL #32
    MOVK  X11, #0x121, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X10, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X10, D30
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
    FADDV   D31, P3, Z31.D
    FMOV  X10, D31
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    DUP     Z0.D, X22
    DUP     Z1.D, X23
    DUP     Z2.D, X24
    DUP     Z3.D, X21
    DUP     Z4.D, X4
    DUP     Z5.D, X11
    DUP     Z6.D, X6
    DUP     Z7.D, X9
    DUP     Z8.D, X23
    DUP     Z9.D, X18
    DUP     Z10.D, X24
    DUP     Z11.D, X22
    DUP     Z12.D, X14
    DUP     Z13.D, X16
    DUP     Z14.D, X21
    DUP     Z15.D, X17
    DUP     Z16.D, X6
    DUP     Z17.D, X19
    DUP     Z18.D, X23
    DUP     Z19.D, X12
    DUP     Z20.D, X23
    DUP     Z21.D, X4
    DUP     Z22.D, X18
    DUP     Z23.D, X12
    DUP     Z24.D, X3
    DUP     Z25.D, X3
    DUP     Z26.D, X13
    DUP     Z27.D, X20
    DUP     Z28.D, X12
    DUP     Z29.D, X23
    DUP     Z30.D, X3
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
    MOVZ  X9, #0xa, LSL #0
LCRTSveMoveOperations_label_12:
    UUNPKLO Z16.S, Z29.H
    UZP1    P10.B, P4.B, P10.B
    MOV Z28.H,H31
    INDEX   Z24.S, #-10, W17
    MOV Z5.D,Z5.D[1]
    INDEX   Z13.H, #-10, W12
    SUNPKLO Z4.S, Z5.H
    INDEX   Z28.S, W12, W8
    INDEX   Z17.S, W14, #-8
    UZP1    Z13.B, Z30.B, Z24.B
    INDEX   Z28.S, #-3, #-2
    INSR    Z27.B, W23
    INDEX   Z20.S, #12, #14
    INDEX   Z21.D, #11, #0
    ZIP2    P9.H, P2.H, P14.H
    REV     P9.S, P6.S
    SUNPKHI Z2.H, Z20.B
    INDEX   Z26.B, #-9, W3
    INSR    Z11.S, S2
    CLASTB  Z26.H, P3, Z26.H, Z26.H
    MOV Z31.S,Z13.S[15]
    UUNPKLO Z12.D, Z17.S
    TRN2    P6.B, P9.B, P11.B
    UUNPKHI Z7.H, Z15.B
    UUNPKLO Z1.D, Z8.S
    UZP2    P4.S, P2.S, P3.S
    INDEX   Z25.B, W16, W6
    TBL     Z7.H,  Z10.H, Z1.H
    UUNPKLO Z0.S, Z31.H
    ZIP2    P11.H, P4.H, P4.H
    INSR    Z0.H, H27
    UZP1    Z30.H, Z3.H, Z11.H
    CLASTA  W20, P4, W20, Z30.B
    REV     Z24.D, Z6.D
    PUNPKHI P8.H, P2.B
    INDEX   Z4.H, #-4, #-15
    ZIP1    P13.S, P3.S, P6.S
    CLASTA  Z3.S, P7, Z3.S, Z12.S
    SUNPKLO Z6.D, Z14.S
    INDEX   Z11.H, W21, W9
    INDEX   Z0.D, X12, #-4
    UUNPKLO Z12.D, Z26.S
    CLASTA  H20, P4, H20, Z25.H
    ZIP1    P14.D, P11.D, P9.D
    INDEX   Z28.D, #-5, #-6
    ZIP1    P13.B, P3.B, P7.B
    INDEX   Z14.B, W10, #14
    ZIP1    P1.B, P14.B, P7.B
    SUNPKLO Z25.H, Z11.B
    REV     P10.D, P4.D
    SUNPKHI Z13.S, Z18.H
    TRN2    P0.B, P13.B, P10.B
    UUNPKLO Z26.D, Z12.S
    SUNPKHI Z18.H, Z6.B
    INDEX   Z10.S, W6, W17
    ZIP2    P14.S, P4.S, P14.S
    REVH    Z21.D, P1/M, Z13.D
    INDEX   Z26.B, W18, W3
    ZIP2    Z31.B, Z17.B, Z0.B
    INDEX   Z13.S, W23, W4
    LASTA   W18, P7, Z26.S
    INDEX   Z0.B, W11, W3
    REVW    Z12.D, P7/M, Z18.D
    CLASTB  Z22.D, P0, Z22.D, Z10.D
    UZP1    P11.B, P8.B, P13.B
    INDEX   Z26.S, #6, W13
    REV     P1.D, P4.D
    INDEX   Z12.B, W10, W17
    INDEX   Z27.S, #-13, W9
    TRN2    P11.D, P1.D, P10.D
    INDEX   Z10.H, W3, W21
    SPLICE  Z27.B, P0, Z27.B, Z12.B
    INSR    Z0.B, W5
    UUNPKHI Z12.H, Z0.B
    REVH    Z13.D, P4/M, Z21.D
    UZP2    P4.S, P8.S, P15.S
    TRN2    P11.B, P14.B, P8.B
    MOV     Z18.S, P7/M, S22
    INDEX   Z0.D, #-16, X24
    UUNPKHI Z12.H, Z13.B
    INDEX   Z25.D, X8, #-10
    TRN1    P5.B, P2.B, P0.B
    UZP2    P2.D, P10.D, P11.D
    TRN2    Z13.D, Z10.D, Z17.D
    SUNPKHI Z17.D, Z13.S
    ZIP2    P1.H, P7.H, P11.H
    LASTA   B13, P7, Z31.B
    REVB    Z22.D, P2/M, Z21.D
    INDEX   Z10.S, #12, W20
    INDEX   Z8.B, #11, W23
    INDEX   Z28.D, X16, X8
    INDEX   Z3.B, #1, W14
    SUNPKHI Z12.D, Z0.S
    TRN2    P1.D, P4.D, P5.D
    REV     P8.H, P4.H
    LASTB   X23, P4, Z10.D
    INDEX   Z3.S, W14, #-2
    ZIP1    P3.D, P8.D, P14.D
    UUNPKHI Z21.S, Z18.H
    ZIP1    P11.S, P4.S, P2.S
    INDEX   Z1.B, W3, W14
    PUNPKLO P5.H, P7.B
    LASTB   D5, P5, Z17.D
    TRN1    P7.B, P8.B, P0.B
    UZP1    Z18.H, Z28.H, Z22.H
    ZIP2    Z15.H, Z3.H, Z17.H
    TRN1    P5.H, P5.H, P14.H
    ZIP1    P14.S, P12.S, P9.S
    COMPACT Z3.S, P7, Z21.S
    INDEX   Z23.S, #-9, W19
    INDEX   Z0.D, X3, #-6
    SUNPKLO Z13.D, Z0.S
    UZP2    P15.S, P4.S, P13.S
    INDEX   Z24.D, X3, X16
    SUNPKLO Z7.S, Z18.H
    SUNPKHI Z21.S, Z7.H
    UUNPKLO Z6.H, Z21.B
    INDEX   Z29.H, W5, W19
    ZIP1    Z3.B, Z29.B, Z24.B
    PUNPKLO P3.H, P2.B
    LASTB   S2, P5, Z15.S
    CLASTB  X12, P6, X12, Z2.D
    LASTA   D17, P0, Z21.D
    UUNPKHI Z30.H, Z3.B
    TRN2    P11.D, P9.D, P11.D
    ZIP2    P15.B, P7.B, P10.B
    ZIP1    P12.B, P12.B, P11.B
    UUNPKHI Z21.S, Z6.H
    UZP1    P5.S, P8.S, P0.S
    INDEX   Z17.D, #-10, X24
    INDEX   Z25.D, X13, X10
    INDEX   Z14.B, W24, W21
    INDEX   Z3.H, #8, W22
    COMPACT Z28.D, P0, Z21.D
    REV     P0.B, P4.B
    UUNPKHI Z23.S, Z17.H
    TRN2    P2.B, P2.B, P1.B
    CLASTA  W3, P6, W3, Z14.B
    SUNPKLO Z28.D, Z28.S
    TRN1    Z31.H, Z30.H, Z26.H
    TRN1    P5.B, P0.B, P10.B
    CLASTB  Z14.D, P4, Z14.D, Z18.D
    REVB    Z1.S, P7/M, Z12.S
    DUP Z10.D,Z26.D[3]
    INDEX   Z19.S, W11, W14
    ZIP2    P10.S, P12.S, P0.S
    INDEX   Z29.H, #-8, #9
    TRN2    Z23.H, Z1.H, Z9.H
    LASTB   W13, P5, Z4.B
    INSR    Z3.S, W12
    REV     P5.H, P11.H
    INDEX   Z27.H, W14, W4
    UUNPKHI Z5.S, Z25.H
    INDEX   Z28.S, W8, W13
    ZIP2    P0.H, P5.H, P14.H
    TRN1    P4.S, P11.S, P14.S
    UZP2    Z9.B, Z14.B, Z27.B
    TRN2    P5.D, P8.D, P4.D
    INDEX   Z13.D, X6, #-1
    UUNPKHI Z20.D, Z29.S
    SUNPKHI Z22.H, Z21.B
    REV     P10.S, P4.S
    LASTB   W12, P0, Z31.H
    INDEX   Z1.B, W22, #-3
    INDEX   Z1.B, #-14, W23
    INDEX   Z23.D, #-9, #-10
    INDEX   Z20.S, #-7, #14
    ZIP2    P8.B, P12.B, P11.B
    ZIP1    P6.B, P12.B, P1.B
    SUNPKHI Z29.H, Z3.B
    TRN2    P7.H, P13.H, P10.H
    INDEX   Z19.S, #-9, #15
    INDEX   Z28.B, #-13, W16
    INDEX   Z30.D, #-13, X11
    UZP2    Z18.D, Z29.D, Z13.D
    INDEX   Z24.S, W4, #12
    INDEX   Z3.S, #-3, #-12
    SUNPKHI Z25.D, Z23.S
    INDEX   Z6.B, W11, #-3
    INDEX   Z6.H, #12, W20
    UZP2    P11.S, P3.S, P11.S
    UZP1    Z24.S, Z15.S, Z3.S
    TRN2    P2.D, P4.D, P6.D
    SUNPKLO Z6.D, Z6.S
    UUNPKLO Z20.H, Z30.B
    INDEX   Z4.H, W8, #-4
    TRN2    P13.D, P6.D, P5.D
    INDEX   Z18.D, X16, X10
    SUNPKLO Z4.H, Z29.B
    SUNPKLO Z26.H, Z8.B
    UZP2    P1.S, P1.S, P14.S
    TRN1    P0.S, P5.S, P2.S
    UUNPKHI Z20.S, Z21.H
    UUNPKLO Z11.D, Z15.S
    TRN2    Z10.D, Z6.D, Z24.D
    PUNPKHI P10.H, P15.B
    TRN1    P0.D, P2.D, P3.D
    UUNPKHI Z1.H, Z11.B
    INDEX   Z3.H, #5, W16
    SUNPKLO Z8.D, Z4.S
    SUBS  X9, X9, #0x1
    B.NE  LCRTSveMoveOperations_label_12
    MOVZ  X15, #0xe2, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x6ff, LSL #0
    SUB  X7, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xff, LSL #0
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xe1ff, LSL #0
    MOVK  X15, #0xa5c3, LSL #16
    SUB  X7, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xff, LSL #0
    SUB  X7, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x606, LSL #0
    MOVK  X15, #0x705, LSL #32
    SUB  X7, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTSveMoveOperations_TestFail
    MRS  X15, FPSR
    MOVZ  X7, #0x95, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X7, #0xdc, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D0
    MOVZ  X7, #0xe2, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D1
    MOVZ  X7, #0xf5, LSL #0
    MOVK  X7, #0xff, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0xff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D2
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X7, #0x1, LSL #0
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xfffe, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D3
    MOVZ  X7, #0x5, LSL #0
    MOVK  X7, #0x4, LSL #16
    MOVK  X7, #0x3, LSL #32
    MOVK  X7, #0x2, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X7, #0x1, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D4
    MOVZ  X7, #0x2, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D5
    MOVZ  X7, #0xfd, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X7, #0x20a, LSL #0
    MOVK  X7, #0x309, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D6
    MOVZ  X7, #0xc, LSL #0
    MOVK  X7, #0x10b, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X7, #0xfffe, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D7
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D8
    MOVZ  X7, #0x2, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X7, #0xff, LSL #0
    MOVK  X7, #0xff, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0xff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D9
    MOVZ  X7, #0xff, LSL #0
    MOVK  X7, #0xff, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0xff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X7, #0xfff3, LSL #0
    MOVK  X7, #0xffc7, LSL #16
    MOVK  X7, #0xfff1, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D10
    MOVZ  X7, #0x20a, LSL #0
    MOVK  X7, #0x309, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D11
    MOVZ  X7, #0xfff7, LSL #0
    MOVK  X7, #0xffcf, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D12
    MOVZ  X7, #0xffee, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X7, #0xfffe, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D13
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #32
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D14
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #32
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X7, #0xfff5, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D15
    MOVZ  X7, #0xfff7, LSL #0
    MOVK  X7, #0xffcf, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X7, #0x1, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D16
    MOVZ  X7, #0x2, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X7, #0xfff5, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D17
    MOVZ  X7, #0xfff6, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X7, #0xfffe, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D18
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X7, #0x15, LSL #0
    MOVK  X7, #0x24, LSL #32
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D19
    MOVZ  X7, #0xfff7, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0x6, LSL #32
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X7, #0xff, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D20
    MOVZ  X7, #0xff, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X7, #0xff, LSL #0
    MOVK  X7, #0xff, LSL #32
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D21
    MOVZ  X7, #0xff, LSL #0
    MOVK  X7, #0xff, LSL #32
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X7, #0xffff, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D22
    MOVZ  X7, #0xffff, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X7, #0xffed, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D23
    MOVZ  X7, #0xfff7, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X7, #0xfff3, LSL #0
    MOVK  X7, #0xffc7, LSL #16
    MOVK  X7, #0xfff1, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D24
    MOVZ  X7, #0xfff7, LSL #0
    MOVK  X7, #0xffcf, LSL #16
    MOVK  X7, #0xfff5, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D25
    MOVZ  X7, #0xffe3, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X7, #0x3b, LSL #0
    MOVK  X7, #0x47, LSL #16
    MOVK  X7, #0x53, LSL #32
    MOVK  X7, #0x5f, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D26
    MOVZ  X7, #0xb, LSL #0
    MOVK  X7, #0x17, LSL #16
    MOVK  X7, #0x23, LSL #32
    MOVK  X7, #0x2f, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X7, #0xfffb, LSL #0
    MOVK  X7, #0xfffa, LSL #16
    MOVK  X7, #0xfff9, LSL #32
    MOVK  X7, #0xfff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D27
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xfffe, LSL #16
    MOVK  X7, #0xfffd, LSL #32
    MOVK  X7, #0xfffc, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X7, #0xeaeb, LSL #0
    MOVK  X7, #0xe8e9, LSL #16
    MOVK  X7, #0xe6e7, LSL #32
    MOVK  X7, #0xe4e5, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D28
    MOVZ  X7, #0xf2f3, LSL #0
    MOVK  X7, #0xf0f1, LSL #16
    MOVK  X7, #0xeeef, LSL #32
    MOVK  X7, #0xeced, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D29
    MOVZ  X7, #0x2, LSL #0
    MOVK  X7, #0x1, LSL #32
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X7, #0xfff2, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D30
    MOVZ  X7, #0xfff3, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X7, #0xfa, LSL #0
    MOVK  X7, #0x204, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0x303, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FMOV  X15, D31
    MOVZ  X7, #0xfb, LSL #0
    MOVK  X7, #0x6, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0x105, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x71, LSL #0
    MOVK  X7, #0x1530, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x2010, LSL #0
    MOVK  X7, #0x7770, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x1571, LSL #0
    MOVK  X7, #0x730, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x115, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x71f7, LSL #0
    MOVK  X7, #0x30f5, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x7185, LSL #0
    MOVK  X7, #0x3004, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x1557, LSL #0
    MOVK  X7, #0x777, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x4c02, LSL #0
    MOVK  X7, #0x4c24, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x3b37, LSL #0
    MOVK  X7, #0x211, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x7770, LSL #0
    MOVK  X7, #0x7551, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x544, LSL #0
    MOVK  X7, #0x14, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x100, LSL #0
    MOVK  X7, #0x1707, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x3f7f, LSL #0
    MOVK  X7, #0x557, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x7115, LSL #0
    MOVK  X7, #0x3007, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x770f, LSL #0
    MOVK  X7, #0x737f, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X7, #0x542a, LSL #0
    MOVK  X7, #0x63a, LSL #16
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
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
    FMOV  X15, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X15, D1
    MOVZ  X7, #0xfa, LSL #0
    MOVK  X7, #0xff, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0x10f, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X15, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D3, P0, Z3.D
    FMOV  X15, D3
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X15, D4
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X15, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X15, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X15, D7
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X15, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D9, P0, Z9.D
    FMOV  X15, D9
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X15, D10
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X15, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X15, D12
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X15, D13
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X15, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X15, D15
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X15, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X15, D17
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X15, D18
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X15, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D20, P3, Z20.D
    FMOV  X15, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X15, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D22, P2, Z22.D
    FMOV  X15, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D23, P1, Z23.D
    FMOV  X15, D23
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X15, D24
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D25, P3, Z25.D
    FMOV  X15, D25
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X15, D26
    MOVZ  X7, #0x6fd3, LSL #0
    MOVK  X7, #0x2fdb, LSL #16
    MOVK  X7, #0xffd2, LSL #32
    MOVK  X7, #0xffc1, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X15, D27
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D28, P3, Z28.D
    FMOV  X15, D28
    MOVZ  X7, #0xf2f3, LSL #0
    MOVK  X7, #0xf0f1, LSL #16
    MOVK  X7, #0xeeef, LSL #32
    MOVK  X7, #0xeced, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X15, D29
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X15, D30
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff8, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X15, D31
    MOVZ  X7, #0x2f6, LSL #0
    MOVK  X7, #0x622, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0x6ff, LSL #48
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    DUP     Z0.D, X20
    DUP     Z1.D, X21
    DUP     Z2.D, X2
    DUP     Z3.D, X22
    DUP     Z4.D, X23
    DUP     Z5.D, X24
    DUP     Z6.D, X19
    DUP     Z7.D, X14
    DUP     Z8.D, X13
    DUP     Z9.D, X20
    DUP     Z10.D, X9
    DUP     Z11.D, X11
    DUP     Z12.D, X6
    DUP     Z13.D, X24
    DUP     Z14.D, X14
    DUP     Z15.D, X22
    DUP     Z16.D, X19
    DUP     Z17.D, X21
    DUP     Z18.D, X6
    DUP     Z19.D, X15
    DUP     Z20.D, X19
    DUP     Z21.D, X18
    DUP     Z22.D, X15
    DUP     Z23.D, X5
    DUP     Z24.D, X18
    DUP     Z25.D, X6
    DUP     Z26.D, X22
    DUP     Z27.D, X3
    DUP     Z28.D, X16
    DUP     Z29.D, X4
    DUP     Z30.D, X17
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
    MOVZ  X4, #0xa, LSL #0
LCRTSveMoveOperations_label_13:
    INDEX   Z23.B, W7, W3
    INDEX   Z13.H, W20, #9
    INDEX   Z0.D, #-6, #6
    UUNPKLO Z17.D, Z7.S
    INDEX   Z16.D, #1, X8
    SUNPKHI Z12.H, Z17.B
    SUNPKHI Z16.D, Z4.S
    ZIP2    Z26.S, Z21.S, Z13.S
    SUNPKLO Z30.S, Z0.H
    SUNPKLO Z1.D, Z23.S
    UZP1    P4.B, P13.B, P13.B
    SUNPKHI Z23.S, Z1.H
    INDEX   Z10.B, #-6, #-15
    CLASTB  Z30.H, P0, Z30.H, Z23.H
    UZP2    P9.S, P3.S, P12.S
    INDEX   Z9.D, X5, #6
    INDEX   Z22.S, W5, #-1
    INDEX   Z29.H, #-1, W23
    SUNPKLO Z17.D, Z29.S
    UUNPKLO Z15.D, Z8.S
    UUNPKLO Z20.D, Z26.S
    SUNPKLO Z10.D, Z15.S
    REV     Z8.D, Z22.D
    ZIP1    P1.D, P4.D, P9.D
    INDEX   Z10.S, #5, W13
    SUNPKLO Z5.D, Z9.S
    UUNPKHI Z26.D, Z10.S
    INSR    Z17.B, B30
    CLASTA  Z20.D, P7, Z20.D, Z17.D
    ZIP2    Z26.H, Z5.H, Z18.H
    SPLICE  Z26.D, P1, Z26.D, Z8.D
    REV     P3.D, P12.D
    CLASTA  D20, P2, D20, Z28.D
    SUNPKHI Z8.H, Z20.B
    REV     Z28.B, Z8.B
    INDEX   Z13.D, #3, X17
    INDEX   Z20.B, #-3, #14
    INDEX   Z5.H, #-7, #5
    INDEX   Z9.B, #-13, W18
    INSR    Z13.D, D4
    LASTB   W18, P1, Z9.H
    TRN2    P4.S, P2.S, P2.S
    INDEX   Z8.S, W2, #6
    SUNPKLO Z4.D, Z28.S
    SUNPKHI Z17.D, Z17.S
    SUNPKLO Z24.S, Z4.H
    PUNPKLO P7.H, P12.B
    TRN2    P10.H, P6.H, P2.H
    TRN1    P9.S, P3.S, P9.S
    SUNPKHI Z18.S, Z26.H
    REV     P15.B, P3.B
    ZIP1    P9.B, P9.B, P11.B
    SUNPKLO Z3.S, Z27.H
    TRN2    P7.B, P8.B, P6.B
    INDEX   Z28.B, #-6, W8
    INDEX   Z9.B, W4, #-9
    INSR    Z19.S, S5
    REVB    Z20.S, P3/M, Z17.S
    UZP1    Z27.S, Z16.S, Z9.S
    TRN1    P13.S, P4.S, P12.S
    ZIP1    P2.B, P15.B, P2.B
    SUNPKHI Z31.D, Z28.S
    CLASTA  Z13.B, P2, Z13.B, Z24.B
    SUNPKHI Z26.D, Z20.S
    UUNPKHI Z24.S, Z13.H
    REV     P6.H, P10.H
    INDEX   Z5.S, W3, W22
    UUNPKHI Z20.H, Z8.B
    UZP2    P14.D, P11.D, P8.D
    ZIP2    P11.D, P11.D, P8.D
    SUNPKHI Z30.D, Z24.S
    UUNPKLO Z2.H, Z31.B
    UZP1    P13.H, P6.H, P14.H
    UUNPKHI Z28.D, Z2.S
    ZIP1    P11.B, P4.B, P10.B
    UUNPKLO Z31.H, Z10.B
    PUNPKHI P11.H, P11.B
    INDEX   Z16.D, #-1, #11
    PUNPKHI P2.H, P5.B
    ZIP1    P11.B, P9.B, P14.B
    UZP1    Z30.H, Z20.H, Z26.H
    INDEX   Z8.S, W7, #3
    INDEX   Z26.D, X18, X13
    INDEX   Z20.B, #-15, #-10
    REVH    Z2.S, P1/M, Z20.S
    REV     P14.H, P9.H
    INDEX   Z24.B, W3, #-8
    ZIP1    Z20.D, Z2.D, Z31.D
    PUNPKHI P12.H, P14.B
    SUNPKHI Z19.H, Z29.B
    SUNPKHI Z31.S, Z28.H
    ZIP2    P11.D, P1.D, P15.D
    PUNPKLO P2.H, P2.B
    TRN1    P14.S, P11.S, P1.S
    INDEX   Z29.D, #3, #11
    INDEX   Z2.S, W7, W2
    LASTB   S10, P0, Z29.S
    UUNPKLO Z15.H, Z30.B
    INDEX   Z7.H, W2, W8
    EXT     Z19.B, Z19.B, Z2.B, #0x8b
    INDEX   Z24.S, W3, W24
    ZIP1    Z6.S, Z19.S, Z26.S
    INDEX   Z9.B, W18, #15
    INDEX   Z7.B, #-15, #-2
    INDEX   Z27.S, W6, W2
    REV     P13.B, P7.B
    INDEX   Z29.D, X24, X19
    UZP1    P0.S, P7.S, P5.S
    SUNPKHI Z12.D, Z1.S
    INSR    Z29.H, W9
    TRN2    P7.H, P14.H, P1.H
    UUNPKLO Z3.S, Z18.H
    SUNPKLO Z5.S, Z24.H
    UZP2    Z17.B, Z5.B, Z7.B
    SUNPKHI Z29.D, Z31.S
    INDEX   Z2.S, W6, #-13
    ZIP1    P9.B, P6.B, P2.B
    ZIP2    P6.H, P11.H, P1.H
    INDEX   Z30.S, W21, W6
    INDEX   Z1.D, #-3, X19
    ZIP2    Z2.S, Z9.S, Z25.S
    INDEX   Z20.S, W20, #8
    INDEX   Z11.H, #-4, W9
    TRN1    P5.B, P5.B, P8.B
    CLASTB  S1, P7, S1, Z30.S
    INDEX   Z17.D, X14, #-8
    SUNPKHI Z30.H, Z29.B
    LASTB   D16, P4, Z30.D
    SUNPKHI Z26.D, Z27.S
    INDEX   Z1.B, #7, W11
    CLASTB  Z26.S, P2, Z26.S, Z24.S
    TRN2    P9.S, P2.S, P14.S
    SUNPKHI Z2.H, Z2.B
    TRN2    P9.H, P6.H, P5.H
    UUNPKLO Z13.D, Z1.S
    PUNPKLO P8.H, P15.B
    SUNPKHI Z24.S, Z17.H
    REVB    Z27.H, P7/M, Z24.H
    TRN2    P12.B, P0.B, P1.B
    INDEX   Z21.D, #5, X7
    SUNPKHI Z7.D, Z21.S
    INDEX   Z27.B, #8, W6
    SUNPKHI Z9.H, Z7.B
    INDEX   Z13.H, #12, W19
    PUNPKLO P12.H, P14.B
    TRN1    P2.H, P1.H, P0.H
    INDEX   Z12.S, W8, #1
    INDEX   Z6.H, #5, W4
    INDEX   Z18.S, #4, W24
    UUNPKHI Z27.H, Z13.B
    SUNPKLO Z16.S, Z27.H
    INDEX   Z18.H, W7, #-11
    MOV Z31.H,H9
    SPLICE  Z26.B, P5, Z26.B, Z25.B
    ZIP1    P5.D, P4.D, P4.D
    UUNPKLO Z15.D, Z12.S
    UUNPKLO Z11.H, Z18.B
    UUNPKLO Z1.H, Z11.B
    PUNPKHI P5.H, P12.B
    TRN1    P2.B, P8.B, P12.B
    CLASTA  Z26.D, P2, Z26.D, Z31.D
    UUNPKLO Z18.D, Z3.S
    INDEX   Z1.D, X4, #-6
    INDEX   Z20.B, W7, #-9
    TRN1    P9.S, P5.S, P6.S
    INDEX   Z6.S, #3, #-16
    CLASTB  Z16.D, P3, Z16.D, Z11.D
    REV     Z9.B, Z21.B
    INDEX   Z20.H, W7, #15
    INDEX   Z6.B, #8, #9
    SUNPKHI Z14.D, Z14.S
    INDEX   Z20.B, #0, #-4
    SUNPKHI Z23.D, Z26.S
    INDEX   Z31.B, #14, W22
    SUNPKLO Z28.D, Z18.S
    UZP2    Z4.B, Z9.B, Z6.B
    ZIP2    P14.B, P9.B, P0.B
    INDEX   Z30.D, #14, X6
    UUNPKHI Z16.D, Z1.S
    TRN2    P1.D, P7.D, P14.D
    INDEX   Z6.H, W6, W20
    INDEX   Z8.H, #15, #-10
    INDEX   Z6.D, X21, X2
    INDEX   Z22.H, W19, W17
    INSR    Z26.B, W6
    REV     Z28.S, Z27.S
    SUNPKLO Z23.D, Z2.S
    INDEX   Z27.H, #10, #-2
    SUNPKLO Z10.H, Z4.B
    TBL     Z21.B,  Z28.B, Z14.B
    INSR    Z27.H, W13
    INDEX   Z22.S, #8, W6
    SUNPKHI Z17.D, Z23.S
    UUNPKLO Z15.H, Z17.B
    ZIP2    P15.B, P0.B, P14.B
    SUNPKHI Z30.H, Z10.B
    REVW    Z6.D, P7/M, Z8.D
    INDEX   Z15.B, #-14, #13
    ZIP1    P6.D, P5.D, P15.D
    ZIP1    P7.H, P2.H, P14.H
    SUBS  X4, X4, #0x1
    B.NE  LCRTSveMoveOperations_label_13
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xe697, LSL #0
    SUB  X15, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X15, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveMoveOperations_TestFail
    MRS  X12, FPSR
    MOVZ  X15, #0x95, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D0
    MOVZ  X15, #0xfffa, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X15, #0xfffb, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D1
    MOVZ  X15, #0x1, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5a, LSL #16
    MOVK  X15, #0x5a, LSL #32
    MOVK  X15, #0x5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D2
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xe, LSL #16
    MOVK  X15, #0x1d, LSL #32
    MOVK  X15, #0x2c, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D3
    MOVZ  X15, #0x5a58, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5f5a, LSL #16
    MOVK  X15, #0x500, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D4
    MOVZ  X15, #0xf0f, LSL #0
    MOVK  X15, #0x130f, LSL #16
    MOVK  X15, #0xb4b4, LSL #32
    MOVK  X15, #0xb9b4, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X15, #0xb4b4, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xb4b4, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D5
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #32
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X15, #0xb4b4, LSL #0
    MOVK  X15, #0xb4b4, LSL #16
    MOVK  X15, #0xb4b4, LSL #32
    MOVK  X15, #0xb4b4, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D6
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X15, #0xb4b4, LSL #0
    MOVK  X15, #0xb4b4, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D7
    MOVZ  X15, #0xb4b9, LSL #0
    MOVK  X15, #0xb4b4, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X15, #0xffe7, LSL #0
    MOVK  X15, #0xffdd, LSL #16
    MOVK  X15, #0xffd3, LSL #32
    MOVK  X15, #0xffc9, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D8
    MOVZ  X15, #0xf, LSL #0
    MOVK  X15, #0x5, LSL #16
    MOVK  X15, #0xfffb, LSL #32
    MOVK  X15, #0xfff1, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X15, #0xb4b4, LSL #0
    MOVK  X15, #0xb4b4, LSL #16
    MOVK  X15, #0xb4b4, LSL #32
    MOVK  X15, #0xb9b4, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D9
    MOVZ  X15, #0xf0f, LSL #0
    MOVK  X15, #0xf0f, LSL #16
    MOVK  X15, #0xf0f, LSL #32
    MOVK  X15, #0x130f, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X15, #0xffb4, LSL #0
    MOVK  X15, #0xffb4, LSL #16
    MOVK  X15, #0xffb4, LSL #32
    MOVK  X15, #0xffb9, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D10
    MOVZ  X15, #0xf, LSL #0
    MOVK  X15, #0xf, LSL #16
    MOVK  X15, #0xf, LSL #32
    MOVK  X15, #0x13, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X15, #0x44, LSL #0
    MOVK  X15, #0x5a, LSL #16
    MOVK  X15, #0x39, LSL #32
    MOVK  X15, #0x5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D11
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5a, LSL #16
    MOVK  X15, #0x4f, LSL #32
    MOVK  X15, #0x5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X15, #0x5a5c, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5d, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D12
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5b, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X15, #0x6974, LSL #0
    MOVK  X15, #0xc3ce, LSL #16
    MOVK  X15, #0x1e28, LSL #32
    MOVK  X15, #0x7882, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D13
    MOVZ  X15, #0xc, LSL #0
    MOVK  X15, #0x5a66, LSL #16
    MOVK  X15, #0xb4c0, LSL #32
    MOVK  X15, #0xf1a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X15, #0x675a, LSL #0
    MOVK  X15, #0x8174, LSL #16
    MOVK  X15, #0x9b8e, LSL #32
    MOVK  X15, #0xb5a8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D15
    MOVZ  X15, #0xfff2, LSL #0
    MOVK  X15, #0x190c, LSL #16
    MOVK  X15, #0x3326, LSL #32
    MOVK  X15, #0x4d40, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D16
    MOVZ  X15, #0xfff5, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D17
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5a, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D18
    MOVZ  X15, #0x5a58, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X15, #0xff83, LSL #0
    MOVK  X15, #0xff87, LSL #16
    MOVK  X15, #0xffdd, LSL #32
    MOVK  X15, #0xffe1, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D19
    MOVZ  X15, #0xffcf, LSL #0
    MOVK  X15, #0xffd2, LSL #16
    MOVK  X15, #0x29, LSL #32
    MOVK  X15, #0x2d, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X15, #0xdce0, LSL #0
    MOVK  X15, #0xd4d8, LSL #16
    MOVK  X15, #0xccd0, LSL #32
    MOVK  X15, #0xc4c8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D20
    MOVZ  X15, #0xfc00, LSL #0
    MOVK  X15, #0xf4f8, LSL #16
    MOVK  X15, #0xecf0, LSL #32
    MOVK  X15, #0xe4e8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X15, #0x5252, LSL #0
    MOVK  X15, #0x5252, LSL #16
    MOVK  X15, #0x5252, LSL #32
    MOVK  X15, #0x5252, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D21
    MOVZ  X15, #0x5252, LSL #0
    MOVK  X15, #0x5252, LSL #16
    MOVK  X15, #0x5252, LSL #32
    MOVK  X15, #0x5252, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X15, #0xb4bc, LSL #0
    MOVK  X15, #0xb4b4, LSL #16
    MOVK  X15, #0xf16, LSL #32
    MOVK  X15, #0xf0f, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D22
    MOVZ  X15, #0x8, LSL #0
    MOVK  X15, #0x5a62, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X15, #0x1d, LSL #0
    MOVK  X15, #0x2c, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D23
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xe, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #32
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D24
    MOVZ  X15, #0x5a4a, LSL #0
    MOVK  X15, #0x5a5a, LSL #32
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D25
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D26
    MOVZ  X15, #0xff5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X15, #0x4, LSL #0
    MOVK  X15, #0x2, LSL #16
    MOVK  X15, #0xfffe, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D27
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0xa, LSL #16
    MOVK  X15, #0x8, LSL #32
    MOVK  X15, #0x6, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X15, #0x9e, LSL #0
    MOVK  X15, #0x96, LSL #16
    MOVK  X15, #0x44, LSL #32
    MOVK  X15, #0x3c, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D28
    MOVZ  X15, #0x52, LSL #0
    MOVK  X15, #0x4b, LSL #16
    MOVK  X15, #0xf8, LSL #32
    MOVK  X15, #0xf0, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5f, LSL #32
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D30
    MOVZ  X15, #0x5a, LSL #0
    MOVK  X15, #0x5a, LSL #32
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X15, #0x38de, LSL #0
    MOVK  X15, #0xec92, LSL #16
    MOVK  X15, #0xa046, LSL #32
    MOVK  X15, #0x54fa, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FMOV  X12, D31
    MOVZ  X15, #0x680e, LSL #0
    MOVK  X15, #0x1cc2, LSL #16
    MOVK  X15, #0xd076, LSL #32
    MOVK  X15, #0x842a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x1000, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x40, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x1000, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x66, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x1000, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x40, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x1000, LSL #0
    MOVK  X15, #0x4000, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x40, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x10, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x1000, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x200, LSL #16
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
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
    FMOV  X12, D0
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X12, D1
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X12, D2
    MOVZ  X15, #0x784a, LSL #0
    MOVK  X15, #0x6852, LSL #16
    MOVK  X15, #0xe05a, LSL #32
    MOVK  X15, #0x79, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X12, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X12, D4
    MOVZ  X15, #0xf0d, LSL #0
    MOVK  X15, #0x130f, LSL #16
    MOVK  X15, #0xb4b4, LSL #32
    MOVK  X15, #0xb9b4, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X12, D5
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X12, D6
    MOVZ  X15, #0x6968, LSL #0
    MOVK  X15, #0x6969, LSL #16
    MOVK  X15, #0x6969, LSL #32
    MOVK  X15, #0x6969, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D7, P4, Z7.D
    FMOV  X12, D7
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D8, P3, Z8.D
    FMOV  X12, D8
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D9, P0, Z9.D
    FMOV  X12, D9
    MOVZ  X15, #0x5a59, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5f5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X12, D10
    MOVZ  X15, #0xffb2, LSL #0
    MOVK  X15, #0xffb4, LSL #16
    MOVK  X15, #0xffb4, LSL #32
    MOVK  X15, #0xffb9, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X12, D11
    MOVZ  X15, #0x39, LSL #0
    MOVK  X15, #0x5a, LSL #16
    MOVK  X15, #0x2e, LSL #32
    MOVK  X15, #0x7a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X12, D12
    MOVZ  X15, #0x5a5d, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5e, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X12, D13
    MOVZ  X15, #0x6973, LSL #0
    MOVK  X15, #0xc3ce, LSL #16
    MOVK  X15, #0x1e28, LSL #32
    MOVK  X15, #0x7882, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X12, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X12, D15
    MOVZ  X15, #0xfff1, LSL #0
    MOVK  X15, #0x190c, LSL #16
    MOVK  X15, #0x3326, LSL #32
    MOVK  X15, #0x4d40, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X12, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X12, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D18, P7, Z18.D
    FMOV  X12, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D19, P5, Z19.D
    FMOV  X12, D19
    MOVZ  X15, #0xdf83, LSL #0
    MOVK  X15, #0x8789, LSL #16
    MOVK  X15, #0xb7da, LSL #32
    MOVK  X15, #0xffe2, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X12, D20
    MOVZ  X15, #0xfc00, LSL #0
    MOVK  X15, #0xf4f8, LSL #16
    MOVK  X15, #0xecf0, LSL #32
    MOVK  X15, #0xe4e8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X12, D21
    MOVZ  X15, #0x5252, LSL #0
    MOVK  X15, #0x5252, LSL #16
    MOVK  X15, #0x5252, LSL #32
    MOVK  X15, #0x5272, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X12, D22
    MOVZ  X15, #0x1e23, LSL #0
    MOVK  X15, #0x1e1e, LSL #16
    MOVK  X15, #0x787e, LSL #32
    MOVK  X15, #0x7878, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X12, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D24, P0, Z24.D
    FMOV  X12, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X12, D25
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X12, D26
    MOVZ  X15, #0x839a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a7a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X12, D27
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X12, D28
    MOVZ  X15, #0xbc1, LSL #0
    MOVK  X15, #0x2498, LSL #16
    MOVK  X15, #0xb0f0, LSL #32
    MOVK  X15, #0xf4, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X12, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D30, P6, Z30.D
    FMOV  X12, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X12, D31
    MOVZ  X15, #0xd87c, LSL #0
    MOVK  X15, #0x8c32, LSL #16
    MOVK  X15, #0x40e6, LSL #32
    MOVK  X15, #0xf49a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveMoveOperations_TestFail
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    DUP     Z0.D, X18
    DUP     Z1.D, X17
    DUP     Z2.D, X24
    DUP     Z3.D, X23
    DUP     Z4.D, X19
    DUP     Z5.D, X5
    DUP     Z6.D, X20
    DUP     Z7.D, X13
    DUP     Z8.D, X22
    DUP     Z9.D, X16
    DUP     Z10.D, X8
    DUP     Z11.D, X12
    DUP     Z12.D, X11
    DUP     Z13.D, X3
    DUP     Z14.D, X10
    DUP     Z15.D, X14
    DUP     Z16.D, X15
    DUP     Z17.D, X8
    DUP     Z18.D, X23
    DUP     Z19.D, X15
    DUP     Z20.D, X9
    DUP     Z21.D, X9
    DUP     Z22.D, X12
    DUP     Z23.D, X12
    DUP     Z24.D, X5
    DUP     Z25.D, X5
    DUP     Z26.D, X22
    DUP     Z27.D, X20
    DUP     Z28.D, X4
    DUP     Z29.D, X21
    DUP     Z30.D, X14
    DUP     Z31.D, X19
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
LCRTSveMoveOperations_label_14:
    UUNPKLO Z17.H, Z29.B
    LASTB   D21, P4, Z31.D
    INDEX   Z17.S, W18, W19
    UZP1    P1.D, P15.D, P0.D
    INDEX   Z12.H, W5, W22
    CLASTA  Z16.D, P7, Z16.D, Z17.D
    INDEX   Z8.B, W3, W7
    UZP2    P12.S, P9.S, P11.S
    REV     P0.H, P1.H
    UUNPKHI Z29.S, Z26.H
    UUNPKHI Z3.D, Z16.S
    PUNPKLO P12.H, P3.B
    UZP1    P6.S, P14.S, P7.S
    SUNPKLO Z24.S, Z12.H
    INDEX   Z23.S, #-14, W4
    ZIP2    P14.D, P14.D, P13.D
    INDEX   Z7.H, #9, #-12
    SUNPKLO Z24.S, Z3.H
    UZP1    P9.B, P9.B, P6.B
    ZIP2    Z4.H, Z23.H, Z17.H
    ZIP1    P6.H, P14.H, P14.H
    INDEX   Z6.S, #-13, #7
    CLASTB  B15, P0, B15, Z22.B
    CLASTA  H24, P6, H24, Z4.H
    INDEX   Z14.H, #4, #6
    LASTA   X24, P5, Z14.D
    TRN1    Z0.B, Z29.B, Z21.B
    INDEX   Z1.H, #-5, #-10
    TRN2    P5.S, P9.S, P12.S
    INDEX   Z29.B, W24, W6
    INDEX   Z24.H, W9, W5
    TBL     Z28.S,  Z28.S, Z24.S
    ZIP2    P1.H, P3.H, P13.H
    LASTA   H15, P1, Z0.H
    TBL     Z5.H,  Z15.H, Z17.H
    INDEX   Z1.B, W24, W14
    UUNPKHI Z14.H, Z29.B
    SUNPKLO Z2.H, Z16.B
    INDEX   Z30.S, W10, #2
    TRN2    P11.B, P10.B, P2.B
    INDEX   Z6.H, W4, W14
    INDEX   Z21.B, #13, #-2
    INDEX   Z27.B, #2, W10
    ZIP2    P4.S, P13.S, P8.S
    TRN1    P9.B, P8.B, P3.B
    TRN2    P13.H, P7.H, P3.H
    ZIP1    P5.D, P6.D, P7.D
    CLASTB  W19, P7, W19, Z2.H
    TRN1    P3.S, P0.S, P10.S
    TRN1    P14.B, P1.B, P2.B
    LASTB   W24, P7, Z12.B
    UZP1    P5.B, P13.B, P6.B
    CLASTA  W4, P1, W4, Z30.S
    INDEX   Z6.B, W19, W7
    INDEX   Z22.H, #-2, W19
    TRN2    P11.H, P12.H, P0.H
    CLASTB  D27, P1, D27, Z7.D
    INDEX   Z7.S, #-4, #-11
    INDEX   Z2.S, #1, W13
    MOV Z0.Q,Q27
    INDEX   Z15.S, #-1, W16
    UUNPKLO Z29.D, Z6.S
    ZIP1    P14.S, P12.S, P13.S
    UUNPKLO Z11.H, Z1.B
    UZP1    P15.B, P3.B, P4.B
    INDEX   Z1.S, W13, W20
    TRN2    P4.B, P10.B, P5.B
    PUNPKLO P5.H, P5.B
    UZP1    P9.S, P1.S, P9.S
    INDEX   Z10.H, #2, #9
    SUNPKHI Z28.S, Z22.H
    TRN1    P11.S, P15.S, P3.S
    INDEX   Z20.H, W4, W21
    INDEX   Z20.D, #-2, #-9
    CLASTA  W2, P2, W2, Z6.H
    REV     P13.B, P12.B
    UZP2    Z19.B, Z29.B, Z2.B
    REVH    Z18.D, P3/M, Z18.D
    SUNPKLO Z17.S, Z28.H
    REV     P9.S, P4.S
    CLASTB  Z28.D, P0, Z28.D, Z9.D
    TRN1    P2.D, P8.D, P0.D
    UUNPKHI Z20.S, Z28.H
    SPLICE  Z19.B, P0, Z19.B, Z31.B
    INDEX   Z29.D, #0, #1
    SUNPKHI Z31.S, Z20.H
    SUNPKHI Z12.D, Z19.S
    UZP1    P4.B, P0.B, P8.B
    INDEX   Z0.D, X24, #2
    SUNPKHI Z10.S, Z17.H
    UZP2    Z11.D, Z15.D, Z31.D
    REVH    Z5.D, P1/M, Z11.D
    SUNPKHI Z9.S, Z5.H
    REV     P14.D, P8.D
    TRN1    P15.D, P8.D, P0.D
    LASTA   W24, P2, Z12.H
    SUNPKHI Z19.D, Z0.S
    INDEX   Z14.H, W11, #11
    INDEX   Z7.B, #4, W10
    LASTA   B24, P7, Z1.B
    UZP1    Z13.D, Z24.D, Z24.D
    UZP2    Z14.B, Z3.B, Z29.B
    CLASTA  W20, P5, W20, Z18.S
    UUNPKLO Z17.S, Z9.H
    UUNPKLO Z18.H, Z14.B
    ZIP2    P10.B, P8.B, P7.B
    INDEX   Z20.S, W19, #-9
    PUNPKLO P4.H, P9.B
    LASTB   H27, P0, Z20.H
    INDEX   Z1.H, #11, #-15
    TRN2    P12.H, P11.H, P5.H
    ZIP2    P7.H, P13.H, P5.H
    CLASTB  X4, P7, X4, Z7.D
    LASTA   D14, P6, Z1.D
    ZIP1    P13.H, P14.H, P2.H
    INDEX   Z3.B, #-3, W9
    SPLICE  Z17.D, P2, Z17.D, Z27.D
    UUNPKLO Z9.D, Z13.S
    SUNPKLO Z29.S, Z20.H
    UUNPKHI Z20.S, Z29.H
    UUNPKLO Z7.H, Z9.B
    INDEX   Z14.B, #13, #-15
    UUNPKLO Z20.D, Z18.S
    TRN2    P4.H, P11.H, P5.H
    SUNPKLO Z13.H, Z17.B
    PUNPKHI P11.H, P5.B
    UUNPKHI Z23.S, Z7.H
    SUNPKLO Z30.S, Z16.H
    UZP1    P4.H, P2.H, P8.H
    UUNPKLO Z27.S, Z3.H
    ZIP1    P5.H, P10.H, P6.H
    INDEX   Z9.D, #10, X2
    UUNPKHI Z7.S, Z3.H
    UUNPKHI Z10.S, Z25.H
    INDEX   Z17.B, #-11, W17
    UUNPKHI Z25.S, Z27.H
    UUNPKHI Z1.S, Z17.H
    ZIP1    Z30.S, Z20.S, Z13.S
    INDEX   Z17.S, W4, #-2
    INDEX   Z27.S, #1, #-1
    PUNPKHI P6.H, P3.B
    CLASTB  B30, P0, B30, Z23.B
    MOV Z30.Q,Z24.Q[3]
    SUNPKHI Z16.S, Z31.H
    TRN2    P12.H, P15.H, P3.H
    ZIP2    P4.B, P9.B, P3.B
    INDEX   Z23.B, W13, W4
    TRN2    P2.S, P15.S, P2.S
    UZP2    P5.B, P10.B, P5.B
    INDEX   Z20.H, #-12, #1
    UZP1    P8.D, P14.D, P12.D
    ZIP1    Z12.S, Z9.S, Z23.S
    REV     P3.S, P14.S
    ZIP2    P3.H, P8.H, P2.H
    UZP2    Z30.S, Z4.S, Z25.S
    INDEX   Z13.H, #-14, #-9
    MOV Z24.D,Z25.D[1]
    INDEX   Z6.B, W9, W17
    SPLICE  Z20.H, P4, Z20.H, Z24.H
    INDEX   Z31.H, #5, W16
    INDEX   Z25.D, X6, #3
    MOV Z24.B,Z1.B[45]
    INDEX   Z4.S, #8, #2
    UUNPKHI Z23.D, Z16.S
    INDEX   Z2.B, #-3, #6
    UZP2    Z9.S, Z12.S, Z10.S
    REVH    Z13.S, P6/M, Z24.S
    INDEX   Z12.H, #3, #-8
    INDEX   Z21.H, #-2, #8
    TRN1    P6.D, P10.D, P12.D
    INDEX   Z1.H, #-3, W19
    UUNPKHI Z10.S, Z20.H
    ZIP2    P8.S, P6.S, P11.S
    CLASTA  Z21.D, P7, Z21.D, Z1.D
    INDEX   Z16.D, X19, X19
    UUNPKLO Z31.H, Z4.B
    TRN2    P11.H, P4.H, P13.H
    ZIP2    P2.H, P6.H, P15.H
    UZP2    P11.H, P8.H, P3.H
    ZIP2    P1.B, P15.B, P2.B
    REV     P6.B, P15.B
    INDEX   Z20.B, W3, W2
    INDEX   Z22.H, #-4, W19
    TRN1    P14.D, P12.D, P15.D
    INDEX   Z28.D, X3, #-1
    REV     P14.B, P3.B
    MOV Z4.B,B6
    SPLICE  Z1.S, P3, Z1.S, Z14.S
    SUNPKLO Z14.S, Z10.H
    TRN2    Z21.D, Z20.D, Z22.D
    TRN2    P6.S, P7.S, P11.S
    ZIP1    P10.H, P13.H, P15.H
    REVW    Z20.D, P2/M, Z14.D
    ZIP1    P13.S, P3.S, P3.S
    UUNPKHI Z14.H, Z28.B
    MOV Z28.H,H12
    PUNPKHI P15.H, P14.B
    INDEX   Z6.B, #8, W6
    INDEX   Z22.S, W2, W18
    INDEX   Z15.B, #9, W10
    SUBS  X7, X7, #0x1
    B.NE  LCRTSveMoveOperations_label_14
    MOVZ  X12, #0x413c, LSL #0
    SUB  X8, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5b3, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0xc, LSL #0
    SUB  X8, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveMoveOperations_TestFail
    MRS  X12, FPSR
    MOVZ  X8, #0x95, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X8, #0x6b, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D0
    MOVZ  X8, #0x69, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X8, #0x8695, LSL #0
    MOVK  X8, #0x6877, LSL #16
    MOVK  X8, #0x4a59, LSL #32
    MOVK  X8, #0x2c3b, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D1
    MOVZ  X8, #0xfe0d, LSL #0
    MOVK  X8, #0xe0ef, LSL #16
    MOVK  X8, #0xc2d1, LSL #32
    MOVK  X8, #0xa4b3, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X8, #0x332d, LSL #0
    MOVK  X8, #0x3f39, LSL #16
    MOVK  X8, #0x4b45, LSL #32
    MOVK  X8, #0x5751, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D2
    MOVZ  X8, #0x3fd, LSL #0
    MOVK  X8, #0xf09, LSL #16
    MOVK  X8, #0x1b15, LSL #32
    MOVK  X8, #0x2721, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X8, #0xca25, LSL #0
    MOVK  X8, #0x146f, LSL #16
    MOVK  X8, #0x5eb9, LSL #32
    MOVK  X8, #0xa803, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D3
    MOVZ  X8, #0xa2fd, LSL #0
    MOVK  X8, #0xec47, LSL #16
    MOVK  X8, #0x3691, LSL #32
    MOVK  X8, #0x80db, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D4
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X8, #0xd530, LSL #0
    MOVK  X8, #0x1f7a, LSL #16
    MOVK  X8, #0x69c4, LSL #32
    MOVK  X8, #0xb30e, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D6
    MOVZ  X8, #0xad08, LSL #0
    MOVK  X8, #0xf752, LSL #16
    MOVK  X8, #0x419c, LSL #32
    MOVK  X8, #0x8be6, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X8, #0x86e1, LSL #0
    MOVK  X8, #0xd02b, LSL #32
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D7
    MOVZ  X8, #0xf24d, LSL #0
    MOVK  X8, #0x3c97, LSL #32
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X8, #0xaead, LSL #0
    MOVK  X8, #0xb0af, LSL #16
    MOVK  X8, #0xb2b1, LSL #32
    MOVK  X8, #0xb4b3, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D8
    MOVZ  X8, #0xa6a5, LSL #0
    MOVK  X8, #0xa8a7, LSL #16
    MOVK  X8, #0xaaa9, LSL #32
    MOVK  X8, #0xacab, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X8, #0xf03d, LSL #0
    MOVK  X8, #0x56a3, LSL #16
    MOVK  X8, #0xbc09, LSL #32
    MOVK  X8, #0x226f, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D9
    MOVZ  X8, #0x58a5, LSL #0
    MOVK  X8, #0xbe0b, LSL #16
    MOVK  X8, #0x2471, LSL #32
    MOVK  X8, #0x8ad7, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X8, #0xfffe, LSL #0
    MOVK  X8, #0x146f, LSL #32
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D10
    MOVZ  X8, #0xfffc, LSL #0
    MOVK  X8, #0xfffd, LSL #32
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X8, #0xe1dd, LSL #0
    MOVK  X8, #0xe1e1, LSL #16
    MOVK  X8, #0x8782, LSL #32
    MOVK  X8, #0x8787, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D11
    MOVZ  X8, #0x4b49, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0xf0ee, LSL #32
    MOVK  X8, #0xf0f0, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X8, #0xffe3, LSL #0
    MOVK  X8, #0xffdb, LSL #16
    MOVK  X8, #0xffd3, LSL #32
    MOVK  X8, #0xffcb, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D12
    MOVZ  X8, #0x3, LSL #0
    MOVK  X8, #0xfffb, LSL #16
    MOVK  X8, #0xfff3, LSL #32
    MOVK  X8, #0xffeb, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X8, #0xffce, LSL #0
    MOVK  X8, #0xffc5, LSL #16
    MOVK  X8, #0xffbc, LSL #32
    MOVK  X8, #0xffb3, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D13
    MOVZ  X8, #0xfff2, LSL #0
    MOVK  X8, #0xffe9, LSL #16
    MOVK  X8, #0xffe0, LSL #32
    MOVK  X8, #0xffd7, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X8, #0xa5, LSL #0
    MOVK  X8, #0xa5, LSL #16
    MOVK  X8, #0xa5, LSL #32
    MOVK  X8, #0xa5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D14
    MOVZ  X8, #0xa3, LSL #0
    MOVK  X8, #0xa5, LSL #16
    MOVK  X8, #0xa5, LSL #32
    MOVK  X8, #0xa5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X8, #0xd631, LSL #0
    MOVK  X8, #0x207b, LSL #16
    MOVK  X8, #0x6ac5, LSL #32
    MOVK  X8, #0xb40f, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D15
    MOVZ  X8, #0xae09, LSL #0
    MOVK  X8, #0xf853, LSL #16
    MOVK  X8, #0x429d, LSL #32
    MOVK  X8, #0x8ce7, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X8, #0xa5af, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5ad, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D17
    MOVZ  X8, #0xa5b3, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5b1, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D19
    MOVZ  X8, #0x6d, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X8, #0xc185, LSL #0
    MOVK  X8, #0x39fd, LSL #16
    MOVK  X8, #0xb175, LSL #32
    MOVK  X8, #0x29ed, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D20
    MOVZ  X8, #0xe1a5, LSL #0
    MOVK  X8, #0x591d, LSL #16
    MOVK  X8, #0xd195, LSL #32
    MOVK  X8, #0x490d, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X8, #0xfffc, LSL #0
    MOVK  X8, #0xfffc, LSL #16
    MOVK  X8, #0xfffc, LSL #32
    MOVK  X8, #0xfffc, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D21
    MOVZ  X8, #0xc185, LSL #0
    MOVK  X8, #0x39fd, LSL #16
    MOVK  X8, #0xb175, LSL #32
    MOVK  X8, #0x29ed, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X8, #0x8c86, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0x322b, LSL #32
    MOVK  X8, #0xf0f1, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D22
    MOVZ  X8, #0x413c, LSL #0
    MOVK  X8, #0xe6e1, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D23
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X8, #0xa5a8, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D25
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D26
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xfffe, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D27
    MOVZ  X8, #0x1, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X8, #0x3, LSL #0
    MOVK  X8, #0x3, LSL #16
    MOVK  X8, #0x3, LSL #32
    MOVK  X8, #0x3, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D28
    MOVZ  X8, #0x3, LSL #0
    MOVK  X8, #0x3, LSL #16
    MOVK  X8, #0x3, LSL #32
    MOVK  X8, #0x3, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X8, #0xfff7, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X8, #0xe1e1, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0x8787, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D30
    MOVZ  X8, #0x9696, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0x3c3c, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X8, #0xa, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FMOV  X12, D31
    MOVZ  X8, #0x8, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x20, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x2, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x1, LSL #0
    MOVK  X8, #0x10, LSL #16
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x200, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x200, LSL #16
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x8, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x401, LSL #16
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x2080, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x2, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x2, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x22, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4000, LSL #16
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x1000, LSL #16
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
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
    FADDV   D0, P4, Z0.D
    FMOV  X12, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X12, D1
    MOVZ  X8, #0x96a4, LSL #0
    MOVK  X8, #0x7887, LSL #16
    MOVK  X8, #0x5a69, LSL #32
    MOVK  X8, #0x3c4b, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X12, D2
    MOVZ  X8, #0x332c, LSL #0
    MOVK  X8, #0x3f39, LSL #16
    MOVK  X8, #0x4b45, LSL #32
    MOVK  X8, #0x5751, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X12, D3
    MOVZ  X8, #0x1a75, LSL #0
    MOVK  X8, #0x64bf, LSL #16
    MOVK  X8, #0xae09, LSL #32
    MOVK  X8, #0xf853, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D4, P1, Z4.D
    FMOV  X12, D4
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5c5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X12, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X12, D6
    MOVZ  X8, #0xfd57, LSL #0
    MOVK  X8, #0x47a2, LSL #16
    MOVK  X8, #0x91ec, LSL #32
    MOVK  X8, #0xdb36, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X12, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X12, D8
    MOVZ  X8, #0xbebd, LSL #0
    MOVK  X8, #0xc0bf, LSL #16
    MOVK  X8, #0xc2c1, LSL #32
    MOVK  X8, #0xc4c3, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X12, D9
    MOVZ  X8, #0xf03c, LSL #0
    MOVK  X8, #0x56a3, LSL #16
    MOVK  X8, #0xbc09, LSL #32
    MOVK  X8, #0x226f, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X12, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X12, D11
    MOVZ  X8, #0x4b49, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0xf0ee, LSL #32
    MOVK  X8, #0xf0f0, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X12, D12
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffef, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X12, D13
    MOVZ  X8, #0x8be1, LSL #0
    MOVK  X8, #0xf1d7, LSL #16
    MOVK  X8, #0x37cb, LSL #32
    MOVK  X8, #0xffde, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X12, D14
    MOVZ  X8, #0xa3, LSL #0
    MOVK  X8, #0xa5, LSL #16
    MOVK  X8, #0xa5, LSL #32
    MOVK  X8, #0xc5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X12, D15
    MOVZ  X8, #0xfe58, LSL #0
    MOVK  X8, #0x48a3, LSL #16
    MOVK  X8, #0x92ed, LSL #32
    MOVK  X8, #0xdc37, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X12, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X12, D17
    MOVZ  X8, #0xa5ad, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5ab, LSL #32
    MOVK  X8, #0xa5c5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D18, P3, Z18.D
    FMOV  X12, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X12, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X12, D20
    MOVZ  X8, #0x8143, LSL #0
    MOVK  X8, #0xf9bd, LSL #16
    MOVK  X8, #0x7135, LSL #32
    MOVK  X8, #0xe9ad, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X12, D21
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7ff8, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X12, D22
    MOVZ  X8, #0x8c85, LSL #0
    MOVK  X8, #0x4b4b, LSL #16
    MOVK  X8, #0x322b, LSL #32
    MOVK  X8, #0xf0f1, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X12, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D24, P0, Z24.D
    FMOV  X12, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X12, D25
    MOVZ  X8, #0xa5a9, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5c5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X12, D26
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5c5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X12, D27
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7ff8, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D28, P6, Z28.D
    FMOV  X12, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D29, P2, Z29.D
    FMOV  X12, D29
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7ff8, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X12, D30
    MOVZ  X8, #0xbc3b, LSL #0
    MOVK  X8, #0x25a5, LSL #16
    MOVK  X8, #0x61e2, LSL #32
    MOVK  X8, #0xa5b5, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail
    FADDV   D31, P2, Z31.D
    FMOV  X12, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveMoveOperations_TestFail

LCRTSveMoveOperations_TestEnd:
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
LCRTSveMoveOperations_TestFail:
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
