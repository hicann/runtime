.global LCRTSveVectorI8MM

.text
.p2align 4

LCRTSveVectorI8MM:

LCRTSveVectorI8MM_TestBegin:
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
    MOVZ  X2, #0xcc55, LSL #0
    MOVK  X2, #0x99e, LSL #16
    MOVK  X2, #0xe86f, LSL #32
    MOVK  X2, #0x92a1, LSL #48
    MOVZ  X3, #0x51b1, LSL #0
    MOVK  X3, #0xa140, LSL #16
    MOVK  X3, #0xb7f3, LSL #32
    MOVK  X3, #0xb0c0, LSL #48
    MOVZ  X4, #0x7b89, LSL #0
    MOVK  X4, #0xd45b, LSL #16
    MOVK  X4, #0x8d16, LSL #32
    MOVK  X4, #0xde2c, LSL #48
    MOVZ  X5, #0x37ab, LSL #0
    MOVK  X5, #0xf094, LSL #16
    MOVK  X5, #0xff87, LSL #32
    MOVK  X5, #0xd69f, LSL #48
    MOVZ  X6, #0xee69, LSL #0
    MOVK  X6, #0xa949, LSL #16
    MOVK  X6, #0xf8d2, LSL #32
    MOVK  X6, #0x9667, LSL #48
    MOVZ  X7, #0x26a3, LSL #0
    MOVK  X7, #0x6acc, LSL #16
    MOVK  X7, #0x1659, LSL #32
    MOVK  X7, #0x9c8d, LSL #48
    MOVZ  X8, #0x6b14, LSL #0
    MOVK  X8, #0xce53, LSL #16
    MOVK  X8, #0x3e99, LSL #32
    MOVK  X8, #0xda32, LSL #48
    MOVZ  X9, #0x4f0c, LSL #0
    MOVK  X9, #0x12b8, LSL #16
    MOVK  X9, #0x2a9d, LSL #32
    MOVK  X9, #0xe1, LSL #48
    MOVZ  X10, #0xf686, LSL #0
    MOVK  X10, #0x6493, LSL #16
    MOVK  X10, #0xb0b3, LSL #32
    MOVK  X10, #0x6fa9, LSL #48
    MOVZ  X11, #0x50c6, LSL #0
    MOVK  X11, #0x7972, LSL #16
    MOVK  X11, #0x9ba4, LSL #32
    MOVK  X11, #0x2aa3, LSL #48
    MOVZ  X12, #0xa20b, LSL #0
    MOVK  X12, #0xe9a9, LSL #16
    MOVK  X12, #0x537a, LSL #32
    MOVK  X12, #0xa2b9, LSL #48
    MOVZ  X13, #0x7335, LSL #0
    MOVK  X13, #0x1323, LSL #16
    MOVK  X13, #0xff0f, LSL #32
    MOVK  X13, #0x3731, LSL #48
    MOVZ  X14, #0x8dfc, LSL #0
    MOVK  X14, #0x2399, LSL #16
    MOVK  X14, #0x1cad, LSL #32
    MOVK  X14, #0x5313, LSL #48
    MOVZ  X15, #0x6c01, LSL #0
    MOVK  X15, #0xcacd, LSL #16
    MOVK  X15, #0x7595, LSL #32
    MOVK  X15, #0x405d, LSL #48
    MOVZ  X16, #0x17bb, LSL #0
    MOVK  X16, #0xc914, LSL #16
    MOVK  X16, #0x8fc, LSL #32
    MOVK  X16, #0xfc49, LSL #48
    MOVZ  X17, #0x5945, LSL #0
    MOVK  X17, #0x8e00, LSL #16
    MOVK  X17, #0x75fb, LSL #32
    MOVK  X17, #0x2356, LSL #48
    MOVZ  X18, #0x638e, LSL #0
    MOVK  X18, #0xbe4b, LSL #16
    MOVK  X18, #0x6dae, LSL #32
    MOVK  X18, #0xef7b, LSL #48
    MOVZ  X19, #0x1545, LSL #0
    MOVK  X19, #0xabc, LSL #16
    MOVK  X19, #0x748a, LSL #32
    MOVK  X19, #0x396f, LSL #48
    MOVZ  X20, #0xc4b2, LSL #0
    MOVK  X20, #0x650d, LSL #16
    MOVK  X20, #0x163d, LSL #32
    MOVK  X20, #0xf4ba, LSL #48
    MOVZ  X21, #0xb7a9, LSL #0
    MOVK  X21, #0x1408, LSL #16
    MOVK  X21, #0x6c65, LSL #32
    MOVK  X21, #0x8047, LSL #48
    MOVZ  X22, #0xc945, LSL #0
    MOVK  X22, #0x7879, LSL #16
    MOVK  X22, #0x66a0, LSL #32
    MOVK  X22, #0x4764, LSL #48
    MOVZ  X23, #0xbe95, LSL #0
    MOVK  X23, #0x52a7, LSL #16
    MOVK  X23, #0xa3bf, LSL #32
    MOVK  X23, #0x3342, LSL #48
    MOVZ  X29, #0x2a25, LSL #0
    MOVK  X29, #0x6a5a, LSL #16
    MOVK  X29, #0xc81e, LSL #32
    MOVK  X29, #0x8e43, LSL #48
    MOVZ  X29, #0xa053, LSL #0
    MOVK  X29, #0x5b6b, LSL #16
    MOVK  X29, #0xbb81, LSL #32
    MOVK  X29, #0x97e7, LSL #48
    MSR  FPCR, X29
    MRS  X2, FPCR
    MOVZ  X19, #0x60ff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    AND  X2, X2, X19
    MOVZ  X19, #0x0, LSL #0
    ORR  X2, X2, X19
    MSR  FPCR, X2
    ISB  SY
    MOVZ  X29, #0xe298, LSL #0
    MOVK  X29, #0x6b95, LSL #16
    MOVK  X29, #0x6aae, LSL #32
    MOVK  X29, #0xde8a, LSL #48
    MSR  FPSR, X29
    MRS  X18, FPSR
    MOVZ  X19, #0xff60, LSL #0
    MOVK  X19, #0x7ff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    AND  X18, X18, X19
    MOVZ  X19, #0x0, LSL #0
    ORR  X18, X18, X19
    MSR  FPSR, X18
    ISB  SY
    ADDS  W10, W12, W9, UXTX #0
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xd458, LSL #0
    MOVK  X2, #0x2361, LSL #16
    MOVK  X2, #0xf9f, LSL #32
    MOVK  X2, #0xa18, LSL #48
    MOVZ  X3, #0xf5c9, LSL #0
    MOVK  X3, #0xa7a6, LSL #16
    MOVK  X3, #0xf4b9, LSL #32
    MOVK  X3, #0x8f0b, LSL #48
    MOVZ  X4, #0xaae, LSL #0
    MOVK  X4, #0xe1ce, LSL #16
    MOVK  X4, #0x221e, LSL #32
    MOVK  X4, #0x84d0, LSL #48
    MOVZ  X5, #0xc311, LSL #0
    MOVK  X5, #0x660d, LSL #16
    MOVK  X5, #0xe94a, LSL #32
    MOVK  X5, #0x1210, LSL #48
    MOVZ  X6, #0x1818, LSL #0
    MOVK  X6, #0xa8db, LSL #16
    MOVK  X6, #0x4be9, LSL #32
    MOVK  X6, #0x4c32, LSL #48
    MOVZ  X7, #0xc559, LSL #0
    MOVK  X7, #0xa9a, LSL #16
    MOVK  X7, #0x667b, LSL #32
    MOVK  X7, #0xd153, LSL #48
    MOVZ  X8, #0x1b19, LSL #0
    MOVK  X8, #0xe49f, LSL #16
    MOVK  X8, #0x71cf, LSL #32
    MOVK  X8, #0xd46f, LSL #48
    MOVZ  X9, #0x3cb3, LSL #0
    MOVK  X9, #0x19e7, LSL #16
    MOVK  X9, #0x6110, LSL #32
    MOVK  X9, #0x5d40, LSL #48
    MOVZ  X10, #0xa9c2, LSL #0
    MOVK  X10, #0x8d7e, LSL #16
    MOVK  X10, #0x7ca7, LSL #32
    MOVK  X10, #0x6a84, LSL #48
    MOVZ  X11, #0xe705, LSL #0
    MOVK  X11, #0xa05d, LSL #16
    MOVK  X11, #0xdead, LSL #32
    MOVK  X11, #0x876a, LSL #48
    MOVZ  X12, #0x2c59, LSL #0
    MOVK  X12, #0x3f6e, LSL #16
    MOVK  X12, #0x794e, LSL #32
    MOVK  X12, #0xf2d7, LSL #48
    MOVZ  X13, #0x7e54, LSL #0
    MOVK  X13, #0x9544, LSL #16
    MOVK  X13, #0x2f74, LSL #32
    MOVK  X13, #0xb95f, LSL #48
    MOVZ  X14, #0xa89c, LSL #0
    MOVK  X14, #0x6bdc, LSL #16
    MOVK  X14, #0xea9c, LSL #32
    MOVK  X14, #0xd4ce, LSL #48
    MOVZ  X15, #0xb8cd, LSL #0
    MOVK  X15, #0xbe2e, LSL #16
    MOVK  X15, #0xcb4f, LSL #32
    MOVK  X15, #0x9268, LSL #48
    MOVZ  X16, #0x9bb8, LSL #0
    MOVK  X16, #0xa68e, LSL #16
    MOVK  X16, #0xa42e, LSL #32
    MOVK  X16, #0x2953, LSL #48
    MOVZ  X17, #0x9b08, LSL #0
    MOVK  X17, #0xcbeb, LSL #16
    MOVK  X17, #0xb323, LSL #32
    MOVK  X17, #0x8c86, LSL #48
    MOVZ  X18, #0xc3ce, LSL #0
    MOVK  X18, #0x9d71, LSL #16
    MOVK  X18, #0x728, LSL #32
    MOVK  X18, #0x2715, LSL #48
    MOVZ  X19, #0xcf16, LSL #0
    MOVK  X19, #0x5c9d, LSL #16
    MOVK  X19, #0xd762, LSL #32
    MOVK  X19, #0xe900, LSL #48
    MOVZ  X20, #0x615c, LSL #0
    MOVK  X20, #0x4ed7, LSL #16
    MOVK  X20, #0xad65, LSL #32
    MOVK  X20, #0x394a, LSL #48
    MOVZ  X21, #0xf81c, LSL #0
    MOVK  X21, #0xa6ab, LSL #16
    MOVK  X21, #0x3016, LSL #32
    MOVK  X21, #0x29f3, LSL #48
    MOVZ  X22, #0x3aee, LSL #0
    MOVK  X22, #0x26a3, LSL #16
    MOVK  X22, #0x6dd2, LSL #32
    MOVK  X22, #0xcfae, LSL #48
    MOVZ  X23, #0xc80e, LSL #0
    MOVK  X23, #0x6083, LSL #16
    MOVK  X23, #0x1cfc, LSL #32
    MOVK  X23, #0x647b, LSL #48
    MOVZ  X29, #0xf434, LSL #0
    MOVK  X29, #0xbc1d, LSL #16
    MOVK  X29, #0xa973, LSL #32
    MOVK  X29, #0x4b46, LSL #48
    DUP     Z0.D, X6
    DUP     Z1.D, X29
    DUP     Z2.D, X23
    DUP     Z3.D, X22
    DUP     Z4.D, X22
    DUP     Z5.D, X16
    DUP     Z6.D, X12
    DUP     Z7.D, X21
    DUP     Z8.D, X17
    DUP     Z9.D, X8
    DUP     Z10.D, X20
    DUP     Z11.D, X11
    DUP     Z12.D, X11
    DUP     Z13.D, X8
    DUP     Z14.D, X19
    DUP     Z15.D, X21
    DUP     Z16.D, X4
    DUP     Z17.D, X9
    DUP     Z18.D, X23
    DUP     Z19.D, X3
    DUP     Z20.D, X14
    DUP     Z21.D, X20
    DUP     Z22.D, X22
    DUP     Z23.D, X11
    DUP     Z24.D, X15
    DUP     Z25.D, X12
    DUP     Z26.D, X23
    DUP     Z27.D, X20
    DUP     Z28.D, X23
    DUP     Z29.D, X12
    DUP     Z30.D, X22
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
    SMMLA Z30.S, Z29.B, Z30.B
    SMMLA Z31.S, Z7.B, Z6.B
    SMMLA Z30.S, Z31.B, Z31.B
    SMMLA Z10.S, Z28.B, Z11.B
    SMMLA Z10.S, Z4.B, Z10.B
    SMMLA Z25.S, Z6.B, Z10.B
    SMMLA Z25.S, Z27.B, Z25.B
    SMMLA Z30.S, Z28.B, Z25.B
    SMMLA Z26.S, Z8.B, Z6.B
    SMMLA Z5.S, Z3.B, Z13.B
    UMMLA Z11.S, Z18.B, Z10.B
    UMMLA Z29.S, Z18.B, Z20.B
    UMMLA Z30.S, Z8.B, Z21.B
    UMMLA Z30.S, Z5.B, Z26.B
    UMMLA Z27.S, Z11.B, Z19.B
    UMMLA Z14.S, Z6.B, Z3.B
    UMMLA Z26.S, Z15.B, Z18.B
    UMMLA Z23.S, Z22.B, Z25.B
    UMMLA Z0.S, Z18.B, Z8.B
    UMMLA Z31.S, Z23.B, Z23.B
    USMMLA Z5.S, Z20.B, Z23.B
    USMMLA Z13.S, Z17.B, Z3.B
    USMMLA Z27.S, Z16.B, Z29.B
    USMMLA Z31.S, Z13.B, Z30.B
    USMMLA Z0.S, Z31.B, Z5.B
    USMMLA Z0.S, Z6.B, Z14.B
    USMMLA Z27.S, Z0.B, Z27.B
    USMMLA Z22.S, Z8.B, Z1.B
    USMMLA Z2.S, Z26.B, Z11.B
    USMMLA Z26.S, Z19.B, Z28.B
    SUDOT Z0.S, Z4.B, Z3.B[0x0]
    SUDOT Z26.S, Z6.B, Z3.B[0x2]
    SUDOT Z6.S, Z28.B, Z3.B[0x0]
    SUDOT Z11.S, Z9.B, Z0.B[0x0]
    SUDOT Z7.S, Z4.B, Z0.B[0x2]
    SUDOT Z16.S, Z28.B, Z4.B[0x0]
    SUDOT Z6.S, Z9.B, Z7.B[0x2]
    SUDOT Z30.S, Z11.B, Z2.B[0x2]
    SUDOT Z20.S, Z15.B, Z0.B[0x2]
    SUDOT Z15.S, Z23.B, Z0.B[0x0]
    USDOT Z14.S, Z20.B, Z1.B[0x1]
    USDOT Z24.S, Z30.B, Z6.B[0x1]
    USDOT Z11.S, Z4.B, Z5.B[0x0]
    USDOT Z29.S, Z21.B, Z1.B[0x2]
    USDOT Z11.S, Z5.B, Z0.B[0x1]
    USDOT Z16.S, Z22.B, Z4.B[0x2]
    USDOT Z16.S, Z27.B, Z7.B[0x3]
    USDOT Z29.S, Z15.B, Z7.B[0x1]
    USDOT Z14.S, Z16.B, Z0.B[0x0]
    USDOT Z26.S, Z26.B, Z1.B[0x1]
    USDOT Z28.S, Z26.B, Z24.B
    USDOT Z5.S, Z11.B, Z11.B
    USDOT Z15.S, Z5.B, Z29.B
    USDOT Z1.S, Z8.B, Z16.B
    USDOT Z15.S, Z14.B, Z14.B
    USDOT Z1.S, Z20.B, Z19.B
    USDOT Z1.S, Z28.B, Z28.B
    USDOT Z20.S, Z14.B, Z22.B
    USDOT Z31.S, Z10.B, Z8.B
    USDOT Z20.S, Z24.B, Z2.B
    MOVZ  X13, #0xd458, LSL #0
    MOVK  X13, #0x2361, LSL #16
    MOVK  X13, #0xf9f, LSL #32
    MOVK  X13, #0xa18, LSL #48
    SUB  X16, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xf5c9, LSL #0
    MOVK  X13, #0xa7a6, LSL #16
    MOVK  X13, #0xf4b9, LSL #32
    MOVK  X13, #0x8f0b, LSL #48
    SUB  X16, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xaae, LSL #0
    MOVK  X13, #0xe1ce, LSL #16
    MOVK  X13, #0x221e, LSL #32
    MOVK  X13, #0x84d0, LSL #48
    SUB  X16, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xc311, LSL #0
    MOVK  X13, #0x660d, LSL #16
    MOVK  X13, #0xe94a, LSL #32
    MOVK  X13, #0x1210, LSL #48
    SUB  X16, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x1818, LSL #0
    MOVK  X13, #0xa8db, LSL #16
    MOVK  X13, #0x4be9, LSL #32
    MOVK  X13, #0x4c32, LSL #48
    SUB  X16, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xc559, LSL #0
    MOVK  X13, #0xa9a, LSL #16
    MOVK  X13, #0x667b, LSL #32
    MOVK  X13, #0xd153, LSL #48
    SUB  X16, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x1b19, LSL #0
    MOVK  X13, #0xe49f, LSL #16
    MOVK  X13, #0x71cf, LSL #32
    MOVK  X13, #0xd46f, LSL #48
    SUB  X16, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x3cb3, LSL #0
    MOVK  X13, #0x19e7, LSL #16
    MOVK  X13, #0x6110, LSL #32
    MOVK  X13, #0x5d40, LSL #48
    SUB  X16, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xa9c2, LSL #0
    MOVK  X13, #0x8d7e, LSL #16
    MOVK  X13, #0x7ca7, LSL #32
    MOVK  X13, #0x6a84, LSL #48
    SUB  X16, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xe705, LSL #0
    MOVK  X13, #0xa05d, LSL #16
    MOVK  X13, #0xdead, LSL #32
    MOVK  X13, #0x876a, LSL #48
    SUB  X16, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x2c59, LSL #0
    MOVK  X13, #0x3f6e, LSL #16
    MOVK  X13, #0x794e, LSL #32
    MOVK  X13, #0xf2d7, LSL #48
    SUB  X16, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xa89c, LSL #0
    MOVK  X13, #0x6bdc, LSL #16
    MOVK  X13, #0xea9c, LSL #32
    MOVK  X13, #0xd4ce, LSL #48
    SUB  X16, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xb8cd, LSL #0
    MOVK  X13, #0xbe2e, LSL #16
    MOVK  X13, #0xcb4f, LSL #32
    MOVK  X13, #0x9268, LSL #48
    SUB  X16, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x9b08, LSL #0
    MOVK  X13, #0xcbeb, LSL #16
    MOVK  X13, #0xb323, LSL #32
    MOVK  X13, #0x8c86, LSL #48
    SUB  X16, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xc3ce, LSL #0
    MOVK  X13, #0x9d71, LSL #16
    MOVK  X13, #0x728, LSL #32
    MOVK  X13, #0x2715, LSL #48
    SUB  X16, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xcf16, LSL #0
    MOVK  X13, #0x5c9d, LSL #16
    MOVK  X13, #0xd762, LSL #32
    MOVK  X13, #0xe900, LSL #48
    SUB  X16, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x615c, LSL #0
    MOVK  X13, #0x4ed7, LSL #16
    MOVK  X13, #0xad65, LSL #32
    MOVK  X13, #0x394a, LSL #48
    SUB  X16, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x3aee, LSL #0
    MOVK  X13, #0x26a3, LSL #16
    MOVK  X13, #0x6dd2, LSL #32
    MOVK  X13, #0xcfae, LSL #48
    SUB  X16, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xc80e, LSL #0
    MOVK  X13, #0x6083, LSL #16
    MOVK  X13, #0x1cfc, LSL #32
    MOVK  X13, #0x647b, LSL #48
    SUB  X16, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0xf434, LSL #0
    MOVK  X13, #0xbc1d, LSL #16
    MOVK  X13, #0xa973, LSL #32
    MOVK  X13, #0x4b46, LSL #48
    SUB  X16, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MRS  X13, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X16, #0x2a8c, LSL #0
    MOVK  X16, #0xa8dc, LSL #16
    MOVK  X16, #0x49fa, LSL #32
    MOVK  X16, #0x4c33, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D0
    MOVZ  X16, #0x2a8c, LSL #0
    MOVK  X16, #0xa8dc, LSL #16
    MOVK  X16, #0x49fa, LSL #32
    MOVK  X16, #0x4c33, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X16, #0xa194, LSL #0
    MOVK  X16, #0xbc1c, LSL #16
    MOVK  X16, #0x1e7e, LSL #32
    MOVK  X16, #0x4b46, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D1
    MOVZ  X16, #0xa194, LSL #0
    MOVK  X16, #0xbc1c, LSL #16
    MOVK  X16, #0x1e7e, LSL #32
    MOVK  X16, #0x4b46, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X16, #0xf27b, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x4769, LSL #32
    MOVK  X16, #0x647b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D2
    MOVZ  X16, #0xf27b, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x4769, LSL #32
    MOVK  X16, #0x647b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X16, #0x3aee, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6dd2, LSL #32
    MOVK  X16, #0xcfae, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D3
    MOVZ  X16, #0x3aee, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6dd2, LSL #32
    MOVK  X16, #0xcfae, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X16, #0x3aee, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6dd2, LSL #32
    MOVK  X16, #0xcfae, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D4
    MOVZ  X16, #0x3aee, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6dd2, LSL #32
    MOVK  X16, #0xcfae, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X16, #0xc2f4, LSL #0
    MOVK  X16, #0xa68e, LSL #16
    MOVK  X16, #0x8b02, LSL #32
    MOVK  X16, #0x2953, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D5
    MOVZ  X16, #0xc2f4, LSL #0
    MOVK  X16, #0xa68e, LSL #16
    MOVK  X16, #0x8b02, LSL #32
    MOVK  X16, #0x2953, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X16, #0xc08f, LSL #0
    MOVK  X16, #0x3f6d, LSL #16
    MOVK  X16, #0x3468, LSL #32
    MOVK  X16, #0xf2d8, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D6
    MOVZ  X16, #0xc08f, LSL #0
    MOVK  X16, #0x3f6d, LSL #16
    MOVK  X16, #0x3468, LSL #32
    MOVK  X16, #0xf2d8, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X16, #0xc0cc, LSL #0
    MOVK  X16, #0xa6ab, LSL #16
    MOVK  X16, #0xc230, LSL #32
    MOVK  X16, #0x29f2, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D7
    MOVZ  X16, #0xc0cc, LSL #0
    MOVK  X16, #0xa6ab, LSL #16
    MOVK  X16, #0xc230, LSL #32
    MOVK  X16, #0x29f2, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X16, #0x9b08, LSL #0
    MOVK  X16, #0xcbeb, LSL #16
    MOVK  X16, #0xb323, LSL #32
    MOVK  X16, #0x8c86, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D8
    MOVZ  X16, #0x9b08, LSL #0
    MOVK  X16, #0xcbeb, LSL #16
    MOVK  X16, #0xb323, LSL #32
    MOVK  X16, #0x8c86, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X16, #0x1b19, LSL #0
    MOVK  X16, #0xe49f, LSL #16
    MOVK  X16, #0x71cf, LSL #32
    MOVK  X16, #0xd46f, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D9
    MOVZ  X16, #0x1b19, LSL #0
    MOVK  X16, #0xe49f, LSL #16
    MOVK  X16, #0x71cf, LSL #32
    MOVK  X16, #0xd46f, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X16, #0x4023, LSL #0
    MOVK  X16, #0x4ed7, LSL #16
    MOVK  X16, #0x8c2c, LSL #32
    MOVK  X16, #0x394a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D10
    MOVZ  X16, #0x4023, LSL #0
    MOVK  X16, #0x4ed7, LSL #16
    MOVK  X16, #0x8c2c, LSL #32
    MOVK  X16, #0x394a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X16, #0x322f, LSL #0
    MOVK  X16, #0xa05f, LSL #16
    MOVK  X16, #0x3295, LSL #32
    MOVK  X16, #0x876c, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D11
    MOVZ  X16, #0x322f, LSL #0
    MOVK  X16, #0xa05f, LSL #16
    MOVK  X16, #0x3295, LSL #32
    MOVK  X16, #0x876c, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X16, #0xe705, LSL #0
    MOVK  X16, #0xa05d, LSL #16
    MOVK  X16, #0xdead, LSL #32
    MOVK  X16, #0x876a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D12
    MOVZ  X16, #0xe705, LSL #0
    MOVK  X16, #0xa05d, LSL #16
    MOVK  X16, #0xdead, LSL #32
    MOVK  X16, #0x876a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X16, #0xcc06, LSL #0
    MOVK  X16, #0xe49e, LSL #16
    MOVK  X16, #0x22bc, LSL #32
    MOVK  X16, #0xd46f, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D13
    MOVZ  X16, #0xcc06, LSL #0
    MOVK  X16, #0xe49e, LSL #16
    MOVK  X16, #0x22bc, LSL #32
    MOVK  X16, #0xd46f, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X16, #0x75b8, LSL #0
    MOVK  X16, #0x5ca0, LSL #16
    MOVK  X16, #0x68c5, LSL #32
    MOVK  X16, #0xe903, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D14
    MOVZ  X16, #0x75b8, LSL #0
    MOVK  X16, #0x5ca0, LSL #16
    MOVK  X16, #0x68c5, LSL #32
    MOVK  X16, #0xe903, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X16, #0x7919, LSL #0
    MOVK  X16, #0xa6ac, LSL #16
    MOVK  X16, #0x1f02, LSL #32
    MOVK  X16, #0x29f3, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D15
    MOVZ  X16, #0x7919, LSL #0
    MOVK  X16, #0xa6ac, LSL #16
    MOVK  X16, #0x1f02, LSL #32
    MOVK  X16, #0x29f3, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X16, #0x9402, LSL #0
    MOVK  X16, #0xe1cd, LSL #16
    MOVK  X16, #0x627c, LSL #32
    MOVK  X16, #0x84d0, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D16
    MOVZ  X16, #0x9402, LSL #0
    MOVK  X16, #0xe1cd, LSL #16
    MOVK  X16, #0x627c, LSL #32
    MOVK  X16, #0x84d0, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X16, #0x3cb3, LSL #0
    MOVK  X16, #0x19e7, LSL #16
    MOVK  X16, #0x6110, LSL #32
    MOVK  X16, #0x5d40, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D17
    MOVZ  X16, #0x3cb3, LSL #0
    MOVK  X16, #0x19e7, LSL #16
    MOVK  X16, #0x6110, LSL #32
    MOVK  X16, #0x5d40, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X16, #0xc80e, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x1cfc, LSL #32
    MOVK  X16, #0x647b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D18
    MOVZ  X16, #0xc80e, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x1cfc, LSL #32
    MOVK  X16, #0x647b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X16, #0xf5c9, LSL #0
    MOVK  X16, #0xa7a6, LSL #16
    MOVK  X16, #0xf4b9, LSL #32
    MOVK  X16, #0x8f0b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D19
    MOVZ  X16, #0xf5c9, LSL #0
    MOVK  X16, #0xa7a6, LSL #16
    MOVK  X16, #0xf4b9, LSL #32
    MOVK  X16, #0x8f0b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X16, #0x3b4, LSL #0
    MOVK  X16, #0x6bdc, LSL #16
    MOVK  X16, #0x42bf, LSL #32
    MOVK  X16, #0xd4d0, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D20
    MOVZ  X16, #0x3b4, LSL #0
    MOVK  X16, #0x6bdc, LSL #16
    MOVK  X16, #0x42bf, LSL #32
    MOVK  X16, #0xd4d0, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X16, #0x615c, LSL #0
    MOVK  X16, #0x4ed7, LSL #16
    MOVK  X16, #0xad65, LSL #32
    MOVK  X16, #0x394a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D21
    MOVZ  X16, #0x615c, LSL #0
    MOVK  X16, #0x4ed7, LSL #16
    MOVK  X16, #0xad65, LSL #32
    MOVK  X16, #0x394a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X16, #0x3a89, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6d6d, LSL #32
    MOVK  X16, #0xcfae, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D22
    MOVZ  X16, #0x3a89, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6d6d, LSL #32
    MOVK  X16, #0xcfae, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X16, #0xb56a, LSL #0
    MOVK  X16, #0xa060, LSL #16
    MOVK  X16, #0xad12, LSL #32
    MOVK  X16, #0x876d, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D23
    MOVZ  X16, #0xb56a, LSL #0
    MOVK  X16, #0xa060, LSL #16
    MOVK  X16, #0xad12, LSL #32
    MOVK  X16, #0x876d, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X16, #0x1f15, LSL #0
    MOVK  X16, #0xbe2f, LSL #16
    MOVK  X16, #0xe885, LSL #32
    MOVK  X16, #0x9268, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D24
    MOVZ  X16, #0x1f15, LSL #0
    MOVK  X16, #0xbe2f, LSL #16
    MOVK  X16, #0xe885, LSL #32
    MOVK  X16, #0x9268, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X16, #0xa95e, LSL #0
    MOVK  X16, #0x3f6d, LSL #16
    MOVK  X16, #0xf653, LSL #32
    MOVK  X16, #0xf2d6, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D25
    MOVZ  X16, #0xa95e, LSL #0
    MOVK  X16, #0x3f6d, LSL #16
    MOVK  X16, #0xf653, LSL #32
    MOVK  X16, #0xf2d6, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X16, #0xa138, LSL #0
    MOVK  X16, #0x6086, LSL #16
    MOVK  X16, #0xd7fa, LSL #32
    MOVK  X16, #0x647d, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D26
    MOVZ  X16, #0xa138, LSL #0
    MOVK  X16, #0x6086, LSL #16
    MOVK  X16, #0xd7fa, LSL #32
    MOVK  X16, #0x647d, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X16, #0x8494, LSL #0
    MOVK  X16, #0x4ed9, LSL #16
    MOVK  X16, #0xd09d, LSL #32
    MOVK  X16, #0x394c, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D27
    MOVZ  X16, #0x8494, LSL #0
    MOVK  X16, #0x4ed9, LSL #16
    MOVK  X16, #0xd09d, LSL #32
    MOVK  X16, #0x394c, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X16, #0xdfff, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x9886, LSL #32
    MOVK  X16, #0x647a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D28
    MOVZ  X16, #0xdfff, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x9886, LSL #32
    MOVK  X16, #0x647a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X16, #0xdc0e, LSL #0
    MOVK  X16, #0x3f70, LSL #16
    MOVK  X16, #0x135d, LSL #32
    MOVK  X16, #0xf2da, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D29
    MOVZ  X16, #0xdc0e, LSL #0
    MOVK  X16, #0x3f70, LSL #16
    MOVK  X16, #0x135d, LSL #32
    MOVK  X16, #0xf2da, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X16, #0xe7ce, LSL #0
    MOVK  X16, #0x26a8, LSL #16
    MOVK  X16, #0x5e7a, LSL #32
    MOVK  X16, #0xcfb4, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D30
    MOVZ  X16, #0xe7ce, LSL #0
    MOVK  X16, #0x26a8, LSL #16
    MOVK  X16, #0x5e7a, LSL #32
    MOVK  X16, #0xcfb4, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X16, #0x193d, LSL #0
    MOVK  X16, #0xa05f, LSL #16
    MOVK  X16, #0xe9a6, LSL #32
    MOVK  X16, #0x876b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D31
    MOVZ  X16, #0x193d, LSL #0
    MOVK  X16, #0xa05f, LSL #16
    MOVK  X16, #0xe9a6, LSL #32
    MOVK  X16, #0x876b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
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
    FMOV  X13, D0
    MOVZ  X16, #0x2a8c, LSL #0
    MOVK  X16, #0xa8dc, LSL #16
    MOVK  X16, #0x49fa, LSL #32
    MOVK  X16, #0x4c53, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X13, D1
    MOVZ  X16, #0xa194, LSL #0
    MOVK  X16, #0xbc1c, LSL #16
    MOVK  X16, #0x1e7e, LSL #32
    MOVK  X16, #0x4b66, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X13, D2
    MOVZ  X16, #0xf27b, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x4769, LSL #32
    MOVK  X16, #0x649b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X13, D3
    MOVZ  X16, #0x3aee, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6dd2, LSL #32
    MOVK  X16, #0xcfce, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X13, D4
    MOVZ  X16, #0x3aee, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6dd2, LSL #32
    MOVK  X16, #0xcfce, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X13, D5
    MOVZ  X16, #0xc2f4, LSL #0
    MOVK  X16, #0xa68e, LSL #16
    MOVK  X16, #0x8b02, LSL #32
    MOVK  X16, #0x2973, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X13, D6
    MOVZ  X16, #0xc08f, LSL #0
    MOVK  X16, #0x3f6d, LSL #16
    MOVK  X16, #0x3468, LSL #32
    MOVK  X16, #0xf2f8, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X13, D7
    MOVZ  X16, #0xc0cc, LSL #0
    MOVK  X16, #0xa6ab, LSL #16
    MOVK  X16, #0xc230, LSL #32
    MOVK  X16, #0x2a12, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X13, D8
    MOVZ  X16, #0x9b08, LSL #0
    MOVK  X16, #0xcbeb, LSL #16
    MOVK  X16, #0xb323, LSL #32
    MOVK  X16, #0x8ca6, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P0, Z9.D
    FMOV  X13, D9
    MOVZ  X16, #0x1b19, LSL #0
    MOVK  X16, #0xe49f, LSL #16
    MOVK  X16, #0x71cf, LSL #32
    MOVK  X16, #0xd48f, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X13, D10
    MOVZ  X16, #0x4023, LSL #0
    MOVK  X16, #0x4ed7, LSL #16
    MOVK  X16, #0x8c2c, LSL #32
    MOVK  X16, #0x396a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X13, D11
    MOVZ  X16, #0x322f, LSL #0
    MOVK  X16, #0xa05f, LSL #16
    MOVK  X16, #0x3295, LSL #32
    MOVK  X16, #0x878c, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X13, D12
    MOVZ  X16, #0xe705, LSL #0
    MOVK  X16, #0xa05d, LSL #16
    MOVK  X16, #0xdead, LSL #32
    MOVK  X16, #0x878a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X13, D13
    MOVZ  X16, #0xcc06, LSL #0
    MOVK  X16, #0xe49e, LSL #16
    MOVK  X16, #0x22bc, LSL #32
    MOVK  X16, #0xd48f, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X13, D14
    MOVZ  X16, #0x75b8, LSL #0
    MOVK  X16, #0x5ca0, LSL #16
    MOVK  X16, #0x68c5, LSL #32
    MOVK  X16, #0xe923, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X13, D15
    MOVZ  X16, #0x7919, LSL #0
    MOVK  X16, #0xa6ac, LSL #16
    MOVK  X16, #0x1f02, LSL #32
    MOVK  X16, #0x2a13, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X13, D16
    MOVZ  X16, #0x9402, LSL #0
    MOVK  X16, #0xe1cd, LSL #16
    MOVK  X16, #0x627c, LSL #32
    MOVK  X16, #0x84f0, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X13, D17
    MOVZ  X16, #0x3cb3, LSL #0
    MOVK  X16, #0x19e7, LSL #16
    MOVK  X16, #0x6110, LSL #32
    MOVK  X16, #0x5d60, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X13, D18
    MOVZ  X16, #0xc80e, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x1cfc, LSL #32
    MOVK  X16, #0x649b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X13, D19
    MOVZ  X16, #0xf5c9, LSL #0
    MOVK  X16, #0xa7a6, LSL #16
    MOVK  X16, #0xf4b9, LSL #32
    MOVK  X16, #0x8f2b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P3, Z20.D
    FMOV  X13, D20
    MOVZ  X16, #0x3b4, LSL #0
    MOVK  X16, #0x6bdc, LSL #16
    MOVK  X16, #0x42bf, LSL #32
    MOVK  X16, #0xd4f0, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X13, D21
    MOVZ  X16, #0x615c, LSL #0
    MOVK  X16, #0x4ed7, LSL #16
    MOVK  X16, #0xad65, LSL #32
    MOVK  X16, #0x396a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X13, D22
    MOVZ  X16, #0x3a89, LSL #0
    MOVK  X16, #0x26a3, LSL #16
    MOVK  X16, #0x6d6d, LSL #32
    MOVK  X16, #0xcfce, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X13, D23
    MOVZ  X16, #0xb56a, LSL #0
    MOVK  X16, #0xa060, LSL #16
    MOVK  X16, #0xad12, LSL #32
    MOVK  X16, #0x878d, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X13, D24
    MOVZ  X16, #0x1f15, LSL #0
    MOVK  X16, #0xbe2f, LSL #16
    MOVK  X16, #0xe885, LSL #32
    MOVK  X16, #0x9288, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X13, D25
    MOVZ  X16, #0xa95e, LSL #0
    MOVK  X16, #0x3f6d, LSL #16
    MOVK  X16, #0xf653, LSL #32
    MOVK  X16, #0xf2f6, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X13, D26
    MOVZ  X16, #0xa138, LSL #0
    MOVK  X16, #0x6086, LSL #16
    MOVK  X16, #0xd7fa, LSL #32
    MOVK  X16, #0x649d, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X13, D27
    MOVZ  X16, #0x8494, LSL #0
    MOVK  X16, #0x4ed9, LSL #16
    MOVK  X16, #0xd09d, LSL #32
    MOVK  X16, #0x396c, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X13, D28
    MOVZ  X16, #0xdfff, LSL #0
    MOVK  X16, #0x6083, LSL #16
    MOVK  X16, #0x9886, LSL #32
    MOVK  X16, #0x649a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X13, D29
    MOVZ  X16, #0xdc0e, LSL #0
    MOVK  X16, #0x3f70, LSL #16
    MOVK  X16, #0x135d, LSL #32
    MOVK  X16, #0xf2fa, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P6, Z30.D
    FMOV  X13, D30
    MOVZ  X16, #0xe7ce, LSL #0
    MOVK  X16, #0x26a8, LSL #16
    MOVK  X16, #0x5e7a, LSL #32
    MOVK  X16, #0xcfd4, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X13, D31
    MOVZ  X16, #0x193d, LSL #0
    MOVK  X16, #0xa05f, LSL #16
    MOVK  X16, #0xe9a6, LSL #32
    MOVK  X16, #0x878b, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x4f51, LSL #0
    MOVK  X2, #0x2905, LSL #16
    MOVK  X2, #0x70f2, LSL #32
    MOVK  X2, #0x4aad, LSL #48
    MOVZ  X3, #0x256, LSL #0
    MOVK  X3, #0xb712, LSL #16
    MOVK  X3, #0xea77, LSL #32
    MOVK  X3, #0x8e6b, LSL #48
    MOVZ  X4, #0xda64, LSL #0
    MOVK  X4, #0x71a, LSL #16
    MOVK  X4, #0xb424, LSL #32
    MOVK  X4, #0x3be9, LSL #48
    MOVZ  X5, #0x2038, LSL #0
    MOVK  X5, #0x861e, LSL #16
    MOVK  X5, #0xf89f, LSL #32
    MOVK  X5, #0x1615, LSL #48
    MOVZ  X6, #0xee4b, LSL #0
    MOVK  X6, #0x7c22, LSL #16
    MOVK  X6, #0x53b9, LSL #32
    MOVK  X6, #0x57be, LSL #48
    MOVZ  X7, #0x91b, LSL #0
    MOVK  X7, #0x9ea4, LSL #16
    MOVK  X7, #0x6bfc, LSL #32
    MOVK  X7, #0xbdd7, LSL #48
    MOVZ  X8, #0x4edc, LSL #0
    MOVK  X8, #0xe364, LSL #16
    MOVK  X8, #0xeb4f, LSL #32
    MOVK  X8, #0x22c6, LSL #48
    MOVZ  X9, #0xb5f6, LSL #0
    MOVK  X9, #0x569c, LSL #16
    MOVK  X9, #0xf2df, LSL #32
    MOVK  X9, #0xa81c, LSL #48
    MOVZ  X10, #0x519a, LSL #0
    MOVK  X10, #0x968d, LSL #16
    MOVK  X10, #0xa1ab, LSL #32
    MOVK  X10, #0xe6b8, LSL #48
    MOVZ  X11, #0x4a9c, LSL #0
    MOVK  X11, #0x4834, LSL #16
    MOVK  X11, #0xcbea, LSL #32
    MOVK  X11, #0x7ec4, LSL #48
    MOVZ  X12, #0x861d, LSL #0
    MOVK  X12, #0x7df2, LSL #16
    MOVK  X12, #0x3d99, LSL #32
    MOVK  X12, #0x4b45, LSL #48
    MOVZ  X13, #0x68a5, LSL #0
    MOVK  X13, #0xa0f0, LSL #16
    MOVK  X13, #0x11d5, LSL #32
    MOVK  X13, #0xe36d, LSL #48
    MOVZ  X14, #0xa427, LSL #0
    MOVK  X14, #0x91c1, LSL #16
    MOVK  X14, #0x549f, LSL #32
    MOVK  X14, #0xfa47, LSL #48
    MOVZ  X15, #0x1156, LSL #0
    MOVK  X15, #0xc643, LSL #16
    MOVK  X15, #0x99d9, LSL #32
    MOVK  X15, #0x7dda, LSL #48
    MOVZ  X16, #0xbb12, LSL #0
    MOVK  X16, #0x4bd0, LSL #16
    MOVK  X16, #0xea24, LSL #32
    MOVK  X16, #0xe1e9, LSL #48
    MOVZ  X17, #0x59ad, LSL #0
    MOVK  X17, #0x6270, LSL #16
    MOVK  X17, #0xf92b, LSL #32
    MOVK  X17, #0xb924, LSL #48
    MOVZ  X18, #0xd5f5, LSL #0
    MOVK  X18, #0x6b86, LSL #16
    MOVK  X18, #0xfdf4, LSL #32
    MOVK  X18, #0x334f, LSL #48
    MOVZ  X19, #0x894c, LSL #0
    MOVK  X19, #0x8fcb, LSL #16
    MOVK  X19, #0x934, LSL #32
    MOVK  X19, #0xbecf, LSL #48
    MOVZ  X20, #0x59b3, LSL #0
    MOVK  X20, #0xbc69, LSL #16
    MOVK  X20, #0x9c7f, LSL #32
    MOVK  X20, #0xc33f, LSL #48
    MOVZ  X21, #0xe464, LSL #0
    MOVK  X21, #0x85e4, LSL #16
    MOVK  X21, #0xce39, LSL #32
    MOVK  X21, #0x6067, LSL #48
    MOVZ  X22, #0x6f93, LSL #0
    MOVK  X22, #0x9d5a, LSL #16
    MOVK  X22, #0x19b5, LSL #32
    MOVK  X22, #0x9a54, LSL #48
    MOVZ  X23, #0x66cf, LSL #0
    MOVK  X23, #0x30ef, LSL #16
    MOVK  X23, #0xe401, LSL #32
    MOVK  X23, #0xf94b, LSL #48
    MOVZ  X29, #0x86bf, LSL #0
    MOVK  X29, #0xa93, LSL #16
    MOVK  X29, #0x8e08, LSL #32
    MOVK  X29, #0x770b, LSL #48
    DUP     Z0.D, X13
    DUP     Z1.D, X11
    DUP     Z2.D, X21
    DUP     Z3.D, X29
    DUP     Z4.D, X23
    DUP     Z5.D, X22
    DUP     Z6.D, X19
    DUP     Z7.D, X20
    DUP     Z8.D, X16
    DUP     Z9.D, X18
    DUP     Z10.D, X5
    DUP     Z11.D, X9
    DUP     Z12.D, X17
    DUP     Z13.D, X8
    DUP     Z14.D, X22
    DUP     Z15.D, X4
    DUP     Z16.D, X18
    DUP     Z17.D, X17
    DUP     Z18.D, X21
    DUP     Z19.D, X14
    DUP     Z20.D, X23
    DUP     Z21.D, X12
    DUP     Z22.D, X7
    DUP     Z23.D, X6
    DUP     Z24.D, X19
    DUP     Z25.D, X9
    DUP     Z26.D, X6
    DUP     Z27.D, X23
    DUP     Z28.D, X13
    DUP     Z29.D, X15
    DUP     Z30.D, X17
    DUP     Z31.D, X4
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
LCRTSveVectorI8MM_label_0:
    UMMLA Z30.S, Z13.B, Z27.B
    USMMLA Z24.S, Z30.B, Z7.B
    SUDOT Z31.S, Z24.B, Z0.B[0x2]
    USDOT Z25.S, Z10.B, Z25.B
    SUDOT Z31.S, Z31.B, Z2.B[0x2]
    USMMLA Z3.S, Z25.B, Z26.B
    USDOT Z31.S, Z3.B, Z3.B
    UMMLA Z13.S, Z7.B, Z18.B
    USDOT Z31.S, Z13.B, Z0.B[0x0]
    UMMLA Z5.S, Z28.B, Z31.B
    SMMLA Z17.S, Z1.B, Z1.B
    USDOT Z0.S, Z17.B, Z2.B[0x3]
    USMMLA Z25.S, Z0.B, Z14.B
    SMMLA Z1.S, Z31.B, Z16.B
    USMMLA Z28.S, Z13.B, Z18.B
    UMMLA Z1.S, Z1.B, Z6.B
    UMMLA Z5.S, Z9.B, Z22.B
    UMMLA Z19.S, Z22.B, Z5.B
    SMMLA Z22.S, Z21.B, Z8.B
    SUDOT Z22.S, Z1.B, Z1.B[0x2]
    USDOT Z24.S, Z26.B, Z7.B[0x1]
    USDOT Z21.S, Z1.B, Z1.B[0x0]
    SMMLA Z25.S, Z17.B, Z1.B
    SUDOT Z15.S, Z0.B, Z3.B[0x0]
    USMMLA Z2.S, Z17.B, Z22.B
    SUDOT Z2.S, Z11.B, Z5.B[0x0]
    USDOT Z24.S, Z11.B, Z7.B[0x1]
    USDOT Z31.S, Z7.B, Z8.B
    USMMLA Z1.S, Z30.B, Z15.B
    SMMLA Z9.S, Z15.B, Z28.B
    SUDOT Z14.S, Z18.B, Z3.B[0x0]
    SUDOT Z18.S, Z12.B, Z2.B[0x3]
    SUDOT Z21.S, Z28.B, Z5.B[0x2]
    SUDOT Z31.S, Z16.B, Z7.B[0x1]
    SUDOT Z21.S, Z24.B, Z1.B[0x1]
    SMMLA Z21.S, Z5.B, Z14.B
    USDOT Z25.S, Z25.B, Z5.B[0x3]
    SMMLA Z28.S, Z10.B, Z3.B
    USMMLA Z13.S, Z21.B, Z9.B
    SMMLA Z18.S, Z13.B, Z9.B
    UMMLA Z25.S, Z28.B, Z18.B
    SMMLA Z10.S, Z31.B, Z30.B
    SUDOT Z19.S, Z25.B, Z1.B[0x3]
    SUDOT Z22.S, Z26.B, Z6.B[0x2]
    USMMLA Z16.S, Z20.B, Z13.B
    USDOT Z27.S, Z27.B, Z30.B
    UMMLA Z6.S, Z27.B, Z7.B
    USDOT Z25.S, Z12.B, Z30.B
    SMMLA Z30.S, Z29.B, Z9.B
    UMMLA Z21.S, Z25.B, Z18.B
    UMMLA Z0.S, Z3.B, Z25.B
    SUDOT Z3.S, Z12.B, Z7.B[0x2]
    UMMLA Z8.S, Z3.B, Z22.B
    UMMLA Z0.S, Z0.B, Z30.B
    SUDOT Z21.S, Z10.B, Z2.B[0x2]
    USDOT Z19.S, Z0.B, Z16.B
    USDOT Z21.S, Z21.B, Z18.B
    UMMLA Z8.S, Z21.B, Z19.B
    USMMLA Z14.S, Z9.B, Z18.B
    SUDOT Z20.S, Z16.B, Z0.B[0x2]
    SMMLA Z26.S, Z21.B, Z5.B
    SUDOT Z11.S, Z4.B, Z6.B[0x1]
    USDOT Z28.S, Z18.B, Z7.B
    USMMLA Z3.S, Z10.B, Z23.B
    UMMLA Z21.S, Z4.B, Z1.B
    USDOT Z28.S, Z9.B, Z1.B[0x3]
    SMMLA Z5.S, Z11.B, Z12.B
    SMMLA Z12.S, Z21.B, Z29.B
    UMMLA Z31.S, Z7.B, Z15.B
    SUDOT Z12.S, Z10.B, Z7.B[0x2]
    USDOT Z3.S, Z13.B, Z14.B
    USDOT Z31.S, Z26.B, Z22.B
    SMMLA Z31.S, Z7.B, Z3.B
    USMMLA Z28.S, Z12.B, Z27.B
    USMMLA Z14.S, Z28.B, Z28.B
    USDOT Z10.S, Z21.B, Z5.B
    SUDOT Z14.S, Z31.B, Z3.B[0x0]
    UMMLA Z14.S, Z10.B, Z7.B
    USDOT Z9.S, Z6.B, Z0.B[0x0]
    USDOT Z14.S, Z14.B, Z6.B[0x1]
    SUDOT Z16.S, Z9.B, Z3.B[0x3]
    SMMLA Z14.S, Z9.B, Z27.B
    SMMLA Z14.S, Z16.B, Z16.B
    SUDOT Z14.S, Z28.B, Z7.B[0x0]
    SMMLA Z14.S, Z14.B, Z14.B
    USDOT Z14.S, Z29.B, Z14.B
    UMMLA Z20.S, Z11.B, Z14.B
    USMMLA Z14.S, Z5.B, Z27.B
    SUDOT Z28.S, Z31.B, Z7.B[0x0]
    SMMLA Z11.S, Z21.B, Z16.B
    USDOT Z28.S, Z29.B, Z1.B[0x3]
    USMMLA Z13.S, Z26.B, Z12.B
    USMMLA Z26.S, Z25.B, Z10.B
    USDOT Z17.S, Z2.B, Z24.B
    USMMLA Z9.S, Z8.B, Z4.B
    USDOT Z22.S, Z7.B, Z5.B[0x1]
    SUDOT Z24.S, Z17.B, Z7.B[0x1]
    USDOT Z12.S, Z14.B, Z3.B[0x3]
    UMMLA Z9.S, Z9.B, Z26.B
    UMMLA Z20.S, Z13.B, Z20.B
    SMMLA Z1.S, Z0.B, Z9.B
    USDOT Z28.S, Z16.B, Z11.B
    USMMLA Z28.S, Z3.B, Z24.B
    USMMLA Z30.S, Z3.B, Z12.B
    USMMLA Z22.S, Z14.B, Z1.B
    SMMLA Z28.S, Z10.B, Z20.B
    UMMLA Z22.S, Z23.B, Z5.B
    SMMLA Z3.S, Z11.B, Z12.B
    USMMLA Z3.S, Z22.B, Z28.B
    SMMLA Z2.S, Z14.B, Z19.B
    USDOT Z2.S, Z2.B, Z2.B[0x2]
    SMMLA Z6.S, Z19.B, Z11.B
    SUDOT Z20.S, Z8.B, Z6.B[0x2]
    SUDOT Z25.S, Z1.B, Z1.B[0x3]
    UMMLA Z4.S, Z27.B, Z1.B
    USDOT Z30.S, Z21.B, Z3.B[0x1]
    USDOT Z16.S, Z23.B, Z2.B[0x3]
    UMMLA Z6.S, Z25.B, Z3.B
    USDOT Z4.S, Z18.B, Z6.B[0x0]
    USDOT Z10.S, Z12.B, Z6.B[0x3]
    USMMLA Z14.S, Z14.B, Z29.B
    USDOT Z10.S, Z5.B, Z6.B[0x2]
    USMMLA Z27.S, Z19.B, Z6.B
    USMMLA Z1.S, Z25.B, Z14.B
    SMMLA Z7.S, Z10.B, Z12.B
    UMMLA Z13.S, Z2.B, Z2.B
    USDOT Z0.S, Z18.B, Z6.B[0x0]
    USDOT Z15.S, Z13.B, Z22.B
    SMMLA Z27.S, Z15.B, Z18.B
    USMMLA Z31.S, Z4.B, Z8.B
    USDOT Z7.S, Z17.B, Z3.B[0x3]
    SMMLA Z27.S, Z0.B, Z1.B
    SUDOT Z7.S, Z7.B, Z0.B[0x0]
    USDOT Z7.S, Z16.B, Z30.B
    SMMLA Z7.S, Z27.B, Z7.B
    USMMLA Z31.S, Z7.B, Z31.B
    SMMLA Z4.S, Z28.B, Z16.B
    UMMLA Z15.S, Z15.B, Z29.B
    SUDOT Z9.S, Z24.B, Z2.B[0x2]
    SUDOT Z21.S, Z6.B, Z2.B[0x0]
    USDOT Z18.S, Z28.B, Z0.B[0x0]
    SUDOT Z11.S, Z11.B, Z6.B[0x2]
    UMMLA Z17.S, Z24.B, Z10.B
    UMMLA Z11.S, Z11.B, Z4.B
    USMMLA Z11.S, Z15.B, Z15.B
    SMMLA Z18.S, Z9.B, Z25.B
    USMMLA Z18.S, Z18.B, Z27.B
    USDOT Z17.S, Z14.B, Z4.B[0x0]
    USDOT Z19.S, Z23.B, Z3.B[0x1]
    USMMLA Z31.S, Z11.B, Z9.B
    SUDOT Z15.S, Z4.B, Z1.B[0x2]
    SUDOT Z17.S, Z18.B, Z1.B[0x0]
    SUDOT Z3.S, Z17.B, Z4.B[0x0]
    USDOT Z15.S, Z24.B, Z4.B[0x2]
    UMMLA Z21.S, Z3.B, Z19.B
    SUDOT Z5.S, Z15.B, Z3.B[0x2]
    USDOT Z29.S, Z31.B, Z1.B
    USDOT Z9.S, Z5.B, Z29.B
    USDOT Z20.S, Z22.B, Z22.B
    UMMLA Z20.S, Z10.B, Z23.B
    SMMLA Z8.S, Z6.B, Z6.B
    USDOT Z8.S, Z0.B, Z0.B[0x3]
    SMMLA Z10.S, Z1.B, Z19.B
    USMMLA Z30.S, Z6.B, Z15.B
    USDOT Z3.S, Z18.B, Z24.B
    USMMLA Z30.S, Z28.B, Z20.B
    SMMLA Z31.S, Z18.B, Z30.B
    SMMLA Z21.S, Z26.B, Z29.B
    USDOT Z23.S, Z23.B, Z12.B
    USMMLA Z15.S, Z15.B, Z2.B
    UMMLA Z9.S, Z31.B, Z5.B
    SUDOT Z29.S, Z20.B, Z0.B[0x2]
    USMMLA Z20.S, Z10.B, Z1.B
    UMMLA Z20.S, Z28.B, Z25.B
    SMMLA Z6.S, Z21.B, Z25.B
    SMMLA Z31.S, Z20.B, Z6.B
    USMMLA Z10.S, Z27.B, Z19.B
    UMMLA Z11.S, Z8.B, Z18.B
    SUDOT Z31.S, Z28.B, Z5.B[0x1]
    UMMLA Z21.S, Z6.B, Z11.B
    SUDOT Z10.S, Z10.B, Z0.B[0x2]
    SMMLA Z5.S, Z11.B, Z10.B
    SUDOT Z19.S, Z0.B, Z3.B[0x3]
    USDOT Z25.S, Z20.B, Z5.B[0x1]
    SUDOT Z2.S, Z23.B, Z2.B[0x1]
    USMMLA Z18.S, Z24.B, Z26.B
    SUDOT Z14.S, Z18.B, Z2.B[0x0]
    USDOT Z25.S, Z31.B, Z21.B
    SUDOT Z15.S, Z24.B, Z5.B[0x1]
    USDOT Z14.S, Z4.B, Z7.B[0x0]
    UMMLA Z14.S, Z25.B, Z27.B
    USMMLA Z29.S, Z19.B, Z28.B
    USDOT Z15.S, Z29.B, Z14.B
    SMMLA Z11.S, Z14.B, Z0.B
    USDOT Z13.S, Z26.B, Z11.B
    SMMLA Z10.S, Z9.B, Z27.B
    USDOT Z8.S, Z25.B, Z7.B[0x3]
    SMMLA Z4.S, Z23.B, Z2.B
    USDOT Z0.S, Z0.B, Z7.B[0x1]
    UMMLA Z29.S, Z31.B, Z19.B
    SUBS  X15, X15, #0x1
    B.NE  LCRTSveVectorI8MM_label_0
    MOVZ  X3, #0x4f51, LSL #0
    MOVK  X3, #0x2905, LSL #16
    MOVK  X3, #0x70f2, LSL #32
    MOVK  X3, #0x4aad, LSL #48
    SUB  X12, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xda64, LSL #0
    MOVK  X3, #0x71a, LSL #16
    MOVK  X3, #0xb424, LSL #32
    MOVK  X3, #0x3be9, LSL #48
    SUB  X12, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x2038, LSL #0
    MOVK  X3, #0x861e, LSL #16
    MOVK  X3, #0xf89f, LSL #32
    MOVK  X3, #0x1615, LSL #48
    SUB  X12, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xee4b, LSL #0
    MOVK  X3, #0x7c22, LSL #16
    MOVK  X3, #0x53b9, LSL #32
    MOVK  X3, #0x57be, LSL #48
    SUB  X12, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x91b, LSL #0
    MOVK  X3, #0x9ea4, LSL #16
    MOVK  X3, #0x6bfc, LSL #32
    MOVK  X3, #0xbdd7, LSL #48
    SUB  X12, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x4edc, LSL #0
    MOVK  X3, #0xe364, LSL #16
    MOVK  X3, #0xeb4f, LSL #32
    MOVK  X3, #0x22c6, LSL #48
    SUB  X12, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xb5f6, LSL #0
    MOVK  X3, #0x569c, LSL #16
    MOVK  X3, #0xf2df, LSL #32
    MOVK  X3, #0xa81c, LSL #48
    SUB  X12, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x519a, LSL #0
    MOVK  X3, #0x968d, LSL #16
    MOVK  X3, #0xa1ab, LSL #32
    MOVK  X3, #0xe6b8, LSL #48
    SUB  X12, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x4a9c, LSL #0
    MOVK  X3, #0x4834, LSL #16
    MOVK  X3, #0xcbea, LSL #32
    MOVK  X3, #0x7ec4, LSL #48
    SUB  X12, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x68a5, LSL #0
    MOVK  X3, #0xa0f0, LSL #16
    MOVK  X3, #0x11d5, LSL #32
    MOVK  X3, #0xe36d, LSL #48
    SUB  X12, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xa427, LSL #0
    MOVK  X3, #0x91c1, LSL #16
    MOVK  X3, #0x549f, LSL #32
    MOVK  X3, #0xfa47, LSL #48
    SUB  X12, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xbb12, LSL #0
    MOVK  X3, #0x4bd0, LSL #16
    MOVK  X3, #0xea24, LSL #32
    MOVK  X3, #0xe1e9, LSL #48
    SUB  X12, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x59ad, LSL #0
    MOVK  X3, #0x6270, LSL #16
    MOVK  X3, #0xf92b, LSL #32
    MOVK  X3, #0xb924, LSL #48
    SUB  X12, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x894c, LSL #0
    MOVK  X3, #0x8fcb, LSL #16
    MOVK  X3, #0x934, LSL #32
    MOVK  X3, #0xbecf, LSL #48
    SUB  X12, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x59b3, LSL #0
    MOVK  X3, #0xbc69, LSL #16
    MOVK  X3, #0x9c7f, LSL #32
    MOVK  X3, #0xc33f, LSL #48
    SUB  X12, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xe464, LSL #0
    MOVK  X3, #0x85e4, LSL #16
    MOVK  X3, #0xce39, LSL #32
    MOVK  X3, #0x6067, LSL #48
    SUB  X12, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x6f93, LSL #0
    MOVK  X3, #0x9d5a, LSL #16
    MOVK  X3, #0x19b5, LSL #32
    MOVK  X3, #0x9a54, LSL #48
    SUB  X12, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x66cf, LSL #0
    MOVK  X3, #0x30ef, LSL #16
    MOVK  X3, #0xe401, LSL #32
    MOVK  X3, #0xf94b, LSL #48
    SUB  X12, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x86bf, LSL #0
    MOVK  X3, #0xa93, LSL #16
    MOVK  X3, #0x8e08, LSL #32
    MOVK  X3, #0x770b, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTSveVectorI8MM_TestFail
    MRS  X3, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X12, #0x20d8, LSL #0
    MOVK  X12, #0xa115, LSL #16
    MOVK  X12, #0x6a21, LSL #32
    MOVK  X12, #0xe392, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D0
    MOVZ  X12, #0x20d8, LSL #0
    MOVK  X12, #0xa115, LSL #16
    MOVK  X12, #0x6a21, LSL #32
    MOVK  X12, #0xe392, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X12, #0xecfb, LSL #0
    MOVK  X12, #0x4847, LSL #16
    MOVK  X12, #0x6e49, LSL #32
    MOVK  X12, #0x7ed8, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D1
    MOVZ  X12, #0xecfb, LSL #0
    MOVK  X12, #0x4847, LSL #16
    MOVK  X12, #0x6e49, LSL #32
    MOVK  X12, #0x7ed8, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X12, #0x122, LSL #0
    MOVK  X12, #0x85de, LSL #16
    MOVK  X12, #0xb28c, LSL #32
    MOVK  X12, #0x6060, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D2
    MOVZ  X12, #0x122, LSL #0
    MOVK  X12, #0x85de, LSL #16
    MOVK  X12, #0xb28c, LSL #32
    MOVK  X12, #0x6060, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X12, #0x61cc, LSL #0
    MOVK  X12, #0xaa0, LSL #16
    MOVK  X12, #0xcbdc, LSL #32
    MOVK  X12, #0x7715, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D3
    MOVZ  X12, #0x61cc, LSL #0
    MOVK  X12, #0xaa0, LSL #16
    MOVK  X12, #0xcbdc, LSL #32
    MOVK  X12, #0x7715, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X12, #0xf54a, LSL #0
    MOVK  X12, #0x30fa, LSL #16
    MOVK  X12, #0x652e, LSL #32
    MOVK  X12, #0xf959, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D4
    MOVZ  X12, #0xf54a, LSL #0
    MOVK  X12, #0x30fa, LSL #16
    MOVK  X12, #0x652e, LSL #32
    MOVK  X12, #0xf959, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X12, #0x2c31, LSL #0
    MOVK  X12, #0x9d83, LSL #16
    MOVK  X12, #0x48f2, LSL #32
    MOVK  X12, #0x9a7b, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D5
    MOVZ  X12, #0x2c31, LSL #0
    MOVK  X12, #0x9d83, LSL #16
    MOVK  X12, #0x48f2, LSL #32
    MOVK  X12, #0x9a7b, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X12, #0x9cb5, LSL #0
    MOVK  X12, #0x8ff4, LSL #16
    MOVK  X12, #0x1c9d, LSL #32
    MOVK  X12, #0xbef8, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D6
    MOVZ  X12, #0x9cb5, LSL #0
    MOVK  X12, #0x8ff4, LSL #16
    MOVK  X12, #0x1c9d, LSL #32
    MOVK  X12, #0xbef8, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X12, #0xb342, LSL #0
    MOVK  X12, #0xbc6b, LSL #16
    MOVK  X12, #0xca85, LSL #32
    MOVK  X12, #0xc341, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D7
    MOVZ  X12, #0xb342, LSL #0
    MOVK  X12, #0xbc6b, LSL #16
    MOVK  X12, #0xca85, LSL #32
    MOVK  X12, #0xc341, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X12, #0xcfd3, LSL #0
    MOVK  X12, #0x4bfd, LSL #16
    MOVK  X12, #0xef9d, LSL #32
    MOVK  X12, #0xe210, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D8
    MOVZ  X12, #0xcfd3, LSL #0
    MOVK  X12, #0x4bfd, LSL #16
    MOVK  X12, #0xef9d, LSL #32
    MOVK  X12, #0xe210, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X12, #0xa329, LSL #0
    MOVK  X12, #0x6b9d, LSL #16
    MOVK  X12, #0xea1, LSL #32
    MOVK  X12, #0x336a, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D9
    MOVZ  X12, #0xa329, LSL #0
    MOVK  X12, #0x6b9d, LSL #16
    MOVK  X12, #0xea1, LSL #32
    MOVK  X12, #0x336a, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X12, #0x26d6, LSL #0
    MOVK  X12, #0x8611, LSL #16
    MOVK  X12, #0x7d76, LSL #32
    MOVK  X12, #0x160d, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D10
    MOVZ  X12, #0x26d6, LSL #0
    MOVK  X12, #0x8611, LSL #16
    MOVK  X12, #0x7d76, LSL #32
    MOVK  X12, #0x160d, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X12, #0x46f3, LSL #0
    MOVK  X12, #0x56cf, LSL #16
    MOVK  X12, #0xe674, LSL #32
    MOVK  X12, #0xa850, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D11
    MOVZ  X12, #0x46f3, LSL #0
    MOVK  X12, #0x56cf, LSL #16
    MOVK  X12, #0xe674, LSL #32
    MOVK  X12, #0xa850, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X12, #0x7180, LSL #0
    MOVK  X12, #0x6270, LSL #16
    MOVK  X12, #0x6fbd, LSL #32
    MOVK  X12, #0xb928, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D12
    MOVZ  X12, #0x7180, LSL #0
    MOVK  X12, #0x6270, LSL #16
    MOVK  X12, #0x6fbd, LSL #32
    MOVK  X12, #0xb928, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X12, #0xc06b, LSL #0
    MOVK  X12, #0xe397, LSL #16
    MOVK  X12, #0x6d33, LSL #32
    MOVK  X12, #0x22fa, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D13
    MOVZ  X12, #0xc06b, LSL #0
    MOVK  X12, #0xe397, LSL #16
    MOVK  X12, #0x6d33, LSL #32
    MOVK  X12, #0x22fa, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X12, #0xf536, LSL #0
    MOVK  X12, #0x9d91, LSL #16
    MOVK  X12, #0x53bf, LSL #32
    MOVK  X12, #0x9a96, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D14
    MOVZ  X12, #0xf536, LSL #0
    MOVK  X12, #0x9d91, LSL #16
    MOVK  X12, #0x53bf, LSL #32
    MOVK  X12, #0x9a96, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X12, #0xf5e9, LSL #0
    MOVK  X12, #0x72a, LSL #16
    MOVK  X12, #0x56c3, LSL #32
    MOVK  X12, #0x3bfd, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D15
    MOVZ  X12, #0xf5e9, LSL #0
    MOVK  X12, #0x72a, LSL #16
    MOVK  X12, #0x56c3, LSL #32
    MOVK  X12, #0x3bfd, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X12, #0xf63d, LSL #0
    MOVK  X12, #0x6b8c, LSL #16
    MOVK  X12, #0xc6e2, LSL #32
    MOVK  X12, #0x3356, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D16
    MOVZ  X12, #0xf63d, LSL #0
    MOVK  X12, #0x6b8c, LSL #16
    MOVK  X12, #0xc6e2, LSL #32
    MOVK  X12, #0x3356, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X12, #0xbcdc, LSL #0
    MOVK  X12, #0x627e, LSL #16
    MOVK  X12, #0x44ce, LSL #32
    MOVK  X12, #0xb93a, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D17
    MOVZ  X12, #0xbcdc, LSL #0
    MOVK  X12, #0x627e, LSL #16
    MOVK  X12, #0x44ce, LSL #32
    MOVK  X12, #0xb93a, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X12, #0x3d55, LSL #0
    MOVK  X12, #0x85f0, LSL #16
    MOVK  X12, #0x19c9, LSL #32
    MOVK  X12, #0x606e, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D18
    MOVZ  X12, #0x3d55, LSL #0
    MOVK  X12, #0x85f0, LSL #16
    MOVK  X12, #0x19c9, LSL #32
    MOVK  X12, #0x606e, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X12, #0xa001, LSL #0
    MOVK  X12, #0x91d9, LSL #16
    MOVK  X12, #0xc19, LSL #32
    MOVK  X12, #0xfa64, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D19
    MOVZ  X12, #0xa001, LSL #0
    MOVK  X12, #0x91d9, LSL #16
    MOVK  X12, #0xc19, LSL #32
    MOVK  X12, #0xfa64, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X12, #0xa5cd, LSL #0
    MOVK  X12, #0x313a, LSL #16
    MOVK  X12, #0xbefa, LSL #32
    MOVK  X12, #0xf997, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D20
    MOVZ  X12, #0xa5cd, LSL #0
    MOVK  X12, #0x313a, LSL #16
    MOVK  X12, #0xbefa, LSL #32
    MOVK  X12, #0xf997, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X12, #0x881b, LSL #0
    MOVK  X12, #0x7e3f, LSL #16
    MOVK  X12, #0x116f, LSL #32
    MOVK  X12, #0x4ba4, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D21
    MOVZ  X12, #0x881b, LSL #0
    MOVK  X12, #0x7e3f, LSL #16
    MOVK  X12, #0x116f, LSL #32
    MOVK  X12, #0x4ba4, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X12, #0x207d, LSL #0
    MOVK  X12, #0x9ebe, LSL #16
    MOVK  X12, #0x602f, LSL #32
    MOVK  X12, #0xbded, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D22
    MOVZ  X12, #0x207d, LSL #0
    MOVK  X12, #0x9ebe, LSL #16
    MOVK  X12, #0x602f, LSL #32
    MOVK  X12, #0xbded, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X12, #0x6df5, LSL #0
    MOVK  X12, #0x7c26, LSL #16
    MOVK  X12, #0x6bca, LSL #32
    MOVK  X12, #0x57bf, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D23
    MOVZ  X12, #0x6df5, LSL #0
    MOVK  X12, #0x7c26, LSL #16
    MOVK  X12, #0x6bca, LSL #32
    MOVK  X12, #0x57bf, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X12, #0x276f, LSL #0
    MOVK  X12, #0x8fce, LSL #16
    MOVK  X12, #0xce8, LSL #32
    MOVK  X12, #0xbecf, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D24
    MOVZ  X12, #0x276f, LSL #0
    MOVK  X12, #0x8fce, LSL #16
    MOVK  X12, #0xce8, LSL #32
    MOVK  X12, #0xbecf, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X12, #0xb8fd, LSL #0
    MOVK  X12, #0x56bc, LSL #16
    MOVK  X12, #0x540, LSL #32
    MOVK  X12, #0xa832, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D25
    MOVZ  X12, #0xb8fd, LSL #0
    MOVK  X12, #0x56bc, LSL #16
    MOVK  X12, #0x540, LSL #32
    MOVK  X12, #0xa832, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X12, #0x93dd, LSL #0
    MOVK  X12, #0x7c1f, LSL #16
    MOVK  X12, #0xf94b, LSL #32
    MOVK  X12, #0x57ba, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D26
    MOVZ  X12, #0x93dd, LSL #0
    MOVK  X12, #0x7c1f, LSL #16
    MOVK  X12, #0xf94b, LSL #32
    MOVK  X12, #0x57ba, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X12, #0x389e, LSL #0
    MOVK  X12, #0x30ea, LSL #16
    MOVK  X12, #0xf572, LSL #32
    MOVK  X12, #0xf944, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D27
    MOVZ  X12, #0x389e, LSL #0
    MOVK  X12, #0x30ea, LSL #16
    MOVK  X12, #0xf572, LSL #32
    MOVK  X12, #0xf944, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X12, #0xb9f4, LSL #0
    MOVK  X12, #0xa0f7, LSL #16
    MOVK  X12, #0xeec, LSL #32
    MOVK  X12, #0xe371, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D28
    MOVZ  X12, #0xb9f4, LSL #0
    MOVK  X12, #0xa0f7, LSL #16
    MOVK  X12, #0xeec, LSL #32
    MOVK  X12, #0xe371, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X12, #0xb8ee, LSL #0
    MOVK  X12, #0xc652, LSL #16
    MOVK  X12, #0xfa22, LSL #32
    MOVK  X12, #0x7de8, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D29
    MOVZ  X12, #0xb8ee, LSL #0
    MOVK  X12, #0xc652, LSL #16
    MOVK  X12, #0xfa22, LSL #32
    MOVK  X12, #0x7de8, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X12, #0x547, LSL #0
    MOVK  X12, #0x628f, LSL #16
    MOVK  X12, #0xa815, LSL #32
    MOVK  X12, #0xb942, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D30
    MOVZ  X12, #0x547, LSL #0
    MOVK  X12, #0x628f, LSL #16
    MOVK  X12, #0xa815, LSL #32
    MOVK  X12, #0xb942, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X12, #0x7735, LSL #0
    MOVK  X12, #0x71e, LSL #16
    MOVK  X12, #0xb6b5, LSL #32
    MOVK  X12, #0x3bf7, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D31
    MOVZ  X12, #0x7735, LSL #0
    MOVK  X12, #0x71e, LSL #16
    MOVK  X12, #0xb6b5, LSL #32
    MOVK  X12, #0x3bf7, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
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
    FMOV  X3, D0
    MOVZ  X12, #0x20d8, LSL #0
    MOVK  X12, #0xa115, LSL #16
    MOVK  X12, #0x6a21, LSL #32
    MOVK  X12, #0xe3b2, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X3, D1
    MOVZ  X12, #0xecfb, LSL #0
    MOVK  X12, #0x4847, LSL #16
    MOVK  X12, #0x6e49, LSL #32
    MOVK  X12, #0x7ef8, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X3, D2
    MOVZ  X12, #0x122, LSL #0
    MOVK  X12, #0x85de, LSL #16
    MOVK  X12, #0xb28c, LSL #32
    MOVK  X12, #0x6080, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P6, Z3.D
    FMOV  X3, D3
    MOVZ  X12, #0x61cc, LSL #0
    MOVK  X12, #0xaa0, LSL #16
    MOVK  X12, #0xcbdc, LSL #32
    MOVK  X12, #0x7735, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X3, D4
    MOVZ  X12, #0xf54a, LSL #0
    MOVK  X12, #0x30fa, LSL #16
    MOVK  X12, #0x652e, LSL #32
    MOVK  X12, #0xf979, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X3, D5
    MOVZ  X12, #0x2c31, LSL #0
    MOVK  X12, #0x9d83, LSL #16
    MOVK  X12, #0x48f2, LSL #32
    MOVK  X12, #0x9a9b, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X3, D6
    MOVZ  X12, #0x9cb5, LSL #0
    MOVK  X12, #0x8ff4, LSL #16
    MOVK  X12, #0x1c9d, LSL #32
    MOVK  X12, #0xbf18, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P2, Z7.D
    FMOV  X3, D7
    MOVZ  X12, #0xb342, LSL #0
    MOVK  X12, #0xbc6b, LSL #16
    MOVK  X12, #0xca85, LSL #32
    MOVK  X12, #0xc361, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P3, Z8.D
    FMOV  X3, D8
    MOVZ  X12, #0xcfd3, LSL #0
    MOVK  X12, #0x4bfd, LSL #16
    MOVK  X12, #0xef9d, LSL #32
    MOVK  X12, #0xe230, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X3, D9
    MOVZ  X12, #0xa329, LSL #0
    MOVK  X12, #0x6b9d, LSL #16
    MOVK  X12, #0xea1, LSL #32
    MOVK  X12, #0x338a, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P3, Z10.D
    FMOV  X3, D10
    MOVZ  X12, #0x26d6, LSL #0
    MOVK  X12, #0x8611, LSL #16
    MOVK  X12, #0x7d76, LSL #32
    MOVK  X12, #0x162d, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P3, Z11.D
    FMOV  X3, D11
    MOVZ  X12, #0x46f3, LSL #0
    MOVK  X12, #0x56cf, LSL #16
    MOVK  X12, #0xe674, LSL #32
    MOVK  X12, #0xa870, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X3, D12
    MOVZ  X12, #0x7180, LSL #0
    MOVK  X12, #0x6270, LSL #16
    MOVK  X12, #0x6fbd, LSL #32
    MOVK  X12, #0xb948, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X3, D13
    MOVZ  X12, #0xc06b, LSL #0
    MOVK  X12, #0xe397, LSL #16
    MOVK  X12, #0x6d33, LSL #32
    MOVK  X12, #0x231a, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P5, Z14.D
    FMOV  X3, D14
    MOVZ  X12, #0xf536, LSL #0
    MOVK  X12, #0x9d91, LSL #16
    MOVK  X12, #0x53bf, LSL #32
    MOVK  X12, #0x9ab6, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X3, D15
    MOVZ  X12, #0xf5e9, LSL #0
    MOVK  X12, #0x72a, LSL #16
    MOVK  X12, #0x56c3, LSL #32
    MOVK  X12, #0x3c1d, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X3, D16
    MOVZ  X12, #0xf63d, LSL #0
    MOVK  X12, #0x6b8c, LSL #16
    MOVK  X12, #0xc6e2, LSL #32
    MOVK  X12, #0x3376, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X3, D17
    MOVZ  X12, #0xbcdc, LSL #0
    MOVK  X12, #0x627e, LSL #16
    MOVK  X12, #0x44ce, LSL #32
    MOVK  X12, #0xb95a, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X3, D18
    MOVZ  X12, #0x3d55, LSL #0
    MOVK  X12, #0x85f0, LSL #16
    MOVK  X12, #0x19c9, LSL #32
    MOVK  X12, #0x608e, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X3, D19
    MOVZ  X12, #0xa001, LSL #0
    MOVK  X12, #0x91d9, LSL #16
    MOVK  X12, #0xc19, LSL #32
    MOVK  X12, #0xfa84, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X3, D20
    MOVZ  X12, #0xa5cd, LSL #0
    MOVK  X12, #0x313a, LSL #16
    MOVK  X12, #0xbefa, LSL #32
    MOVK  X12, #0xf9b7, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X3, D21
    MOVZ  X12, #0x881b, LSL #0
    MOVK  X12, #0x7e3f, LSL #16
    MOVK  X12, #0x116f, LSL #32
    MOVK  X12, #0x4bc4, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X3, D22
    MOVZ  X12, #0x207d, LSL #0
    MOVK  X12, #0x9ebe, LSL #16
    MOVK  X12, #0x602f, LSL #32
    MOVK  X12, #0xbe0d, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X3, D23
    MOVZ  X12, #0x6df5, LSL #0
    MOVK  X12, #0x7c26, LSL #16
    MOVK  X12, #0x6bca, LSL #32
    MOVK  X12, #0x57df, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P6, Z24.D
    FMOV  X3, D24
    MOVZ  X12, #0x276f, LSL #0
    MOVK  X12, #0x8fce, LSL #16
    MOVK  X12, #0xce8, LSL #32
    MOVK  X12, #0xbeef, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X3, D25
    MOVZ  X12, #0xb8fd, LSL #0
    MOVK  X12, #0x56bc, LSL #16
    MOVK  X12, #0x540, LSL #32
    MOVK  X12, #0xa852, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X3, D26
    MOVZ  X12, #0x93dd, LSL #0
    MOVK  X12, #0x7c1f, LSL #16
    MOVK  X12, #0xf94b, LSL #32
    MOVK  X12, #0x57da, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P4, Z27.D
    FMOV  X3, D27
    MOVZ  X12, #0x389e, LSL #0
    MOVK  X12, #0x30ea, LSL #16
    MOVK  X12, #0xf572, LSL #32
    MOVK  X12, #0xf964, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X3, D28
    MOVZ  X12, #0xb9f4, LSL #0
    MOVK  X12, #0xa0f7, LSL #16
    MOVK  X12, #0xeec, LSL #32
    MOVK  X12, #0xe391, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X3, D29
    MOVZ  X12, #0xb8ee, LSL #0
    MOVK  X12, #0xc652, LSL #16
    MOVK  X12, #0xfa22, LSL #32
    MOVK  X12, #0x7e08, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X3, D30
    MOVZ  X12, #0x547, LSL #0
    MOVK  X12, #0x628f, LSL #16
    MOVK  X12, #0xa815, LSL #32
    MOVK  X12, #0xb962, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X3, D31
    MOVZ  X12, #0x7735, LSL #0
    MOVK  X12, #0x71e, LSL #16
    MOVK  X12, #0xb6b5, LSL #32
    MOVK  X12, #0x3c17, LSL #48
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X6
    DUP     Z1.D, X17
    DUP     Z2.D, X18
    DUP     Z3.D, X10
    DUP     Z4.D, X15
    DUP     Z5.D, X3
    DUP     Z6.D, X19
    DUP     Z7.D, X16
    DUP     Z8.D, X21
    DUP     Z9.D, X23
    DUP     Z10.D, X8
    DUP     Z11.D, X29
    DUP     Z12.D, X20
    DUP     Z13.D, X22
    DUP     Z14.D, X13
    DUP     Z15.D, X11
    DUP     Z16.D, X23
    DUP     Z17.D, X22
    DUP     Z18.D, X18
    DUP     Z19.D, X29
    DUP     Z20.D, X5
    DUP     Z21.D, X21
    DUP     Z22.D, X7
    DUP     Z23.D, X4
    DUP     Z24.D, X11
    DUP     Z25.D, X10
    DUP     Z26.D, X29
    DUP     Z27.D, X13
    DUP     Z28.D, X7
    DUP     Z29.D, X11
    DUP     Z30.D, X15
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
    MOVZ  X21, #0xa, LSL #0
LCRTSveVectorI8MM_label_1:
    USDOT Z29.S, Z31.B, Z5.B[0x3]
    SUDOT Z30.S, Z15.B, Z2.B[0x1]
    USMMLA Z27.S, Z30.B, Z10.B
    USDOT Z1.S, Z29.B, Z17.B
    USMMLA Z27.S, Z25.B, Z31.B
    SMMLA Z1.S, Z1.B, Z29.B
    USMMLA Z1.S, Z27.B, Z26.B
    USDOT Z28.S, Z1.B, Z1.B[0x2]
    USDOT Z1.S, Z20.B, Z22.B
    USDOT Z15.S, Z30.B, Z7.B
    SMMLA Z18.S, Z3.B, Z3.B
    SMMLA Z2.S, Z0.B, Z14.B
    SMMLA Z31.S, Z16.B, Z10.B
    UMMLA Z8.S, Z10.B, Z18.B
    SUDOT Z6.S, Z1.B, Z6.B[0x2]
    USDOT Z30.S, Z28.B, Z28.B
    USMMLA Z3.S, Z17.B, Z28.B
    SUDOT Z24.S, Z14.B, Z0.B[0x3]
    USMMLA Z0.S, Z31.B, Z21.B
    USDOT Z26.S, Z7.B, Z3.B
    USMMLA Z31.S, Z5.B, Z20.B
    USMMLA Z16.S, Z4.B, Z2.B
    UMMLA Z8.S, Z15.B, Z31.B
    SMMLA Z26.S, Z0.B, Z0.B
    SMMLA Z16.S, Z10.B, Z19.B
    SMMLA Z26.S, Z6.B, Z6.B
    USMMLA Z18.S, Z26.B, Z20.B
    SMMLA Z8.S, Z30.B, Z16.B
    SMMLA Z18.S, Z12.B, Z14.B
    UMMLA Z11.S, Z7.B, Z5.B
    UMMLA Z30.S, Z8.B, Z8.B
    USDOT Z11.S, Z11.B, Z23.B
    UMMLA Z30.S, Z1.B, Z16.B
    USDOT Z11.S, Z12.B, Z25.B
    SMMLA Z30.S, Z24.B, Z11.B
    UMMLA Z16.S, Z0.B, Z11.B
    UMMLA Z6.S, Z14.B, Z2.B
    SMMLA Z7.S, Z15.B, Z6.B
    UMMLA Z5.S, Z26.B, Z0.B
    USDOT Z6.S, Z31.B, Z22.B
    SMMLA Z2.S, Z13.B, Z9.B
    UMMLA Z6.S, Z3.B, Z27.B
    USDOT Z8.S, Z10.B, Z2.B[0x2]
    USDOT Z22.S, Z30.B, Z24.B
    SUDOT Z31.S, Z11.B, Z1.B[0x0]
    SUDOT Z2.S, Z27.B, Z1.B[0x3]
    USDOT Z22.S, Z0.B, Z5.B[0x3]
    USDOT Z2.S, Z31.B, Z5.B[0x0]
    SUDOT Z7.S, Z16.B, Z7.B[0x1]
    UMMLA Z7.S, Z6.B, Z18.B
    SUDOT Z31.S, Z11.B, Z1.B[0x2]
    UMMLA Z2.S, Z2.B, Z22.B
    USDOT Z8.S, Z29.B, Z7.B[0x0]
    SUDOT Z2.S, Z8.B, Z3.B[0x2]
    USMMLA Z14.S, Z14.B, Z2.B
    USMMLA Z16.S, Z4.B, Z11.B
    UMMLA Z5.S, Z27.B, Z1.B
    USDOT Z18.S, Z31.B, Z7.B[0x0]
    USMMLA Z1.S, Z25.B, Z28.B
    UMMLA Z16.S, Z26.B, Z4.B
    SUDOT Z9.S, Z19.B, Z1.B[0x0]
    USDOT Z22.S, Z25.B, Z3.B[0x3]
    USDOT Z29.S, Z30.B, Z29.B
    SMMLA Z18.S, Z17.B, Z17.B
    USDOT Z4.S, Z11.B, Z9.B
    SUDOT Z6.S, Z26.B, Z4.B[0x3]
    UMMLA Z26.S, Z15.B, Z26.B
    SMMLA Z18.S, Z21.B, Z16.B
    SUDOT Z5.S, Z29.B, Z4.B[0x2]
    USDOT Z29.S, Z19.B, Z26.B
    USDOT Z28.S, Z24.B, Z1.B[0x3]
    USDOT Z20.S, Z26.B, Z21.B
    SUDOT Z0.S, Z5.B, Z3.B[0x3]
    SMMLA Z10.S, Z29.B, Z22.B
    USDOT Z6.S, Z31.B, Z3.B[0x1]
    USDOT Z11.S, Z19.B, Z16.B
    SMMLA Z11.S, Z18.B, Z15.B
    SMMLA Z20.S, Z1.B, Z4.B
    SMMLA Z27.S, Z23.B, Z6.B
    SUDOT Z15.S, Z25.B, Z3.B[0x0]
    USMMLA Z26.S, Z27.B, Z10.B
    SMMLA Z3.S, Z29.B, Z18.B
    UMMLA Z9.S, Z26.B, Z25.B
    USDOT Z17.S, Z5.B, Z4.B
    USDOT Z20.S, Z14.B, Z0.B
    USDOT Z27.S, Z23.B, Z1.B[0x1]
    USDOT Z27.S, Z17.B, Z27.B
    SUDOT Z28.S, Z5.B, Z3.B[0x1]
    UMMLA Z26.S, Z28.B, Z27.B
    USMMLA Z16.S, Z15.B, Z26.B
    USDOT Z22.S, Z16.B, Z20.B
    USDOT Z10.S, Z12.B, Z3.B[0x0]
    USMMLA Z1.S, Z28.B, Z10.B
    USDOT Z14.S, Z11.B, Z6.B
    USDOT Z7.S, Z22.B, Z20.B
    UMMLA Z2.S, Z3.B, Z9.B
    SUDOT Z2.S, Z21.B, Z3.B[0x1]
    USMMLA Z2.S, Z16.B, Z7.B
    USDOT Z1.S, Z2.B, Z1.B[0x2]
    USDOT Z3.S, Z28.B, Z18.B
    UMMLA Z10.S, Z25.B, Z11.B
    SUDOT Z13.S, Z8.B, Z0.B[0x1]
    USMMLA Z29.S, Z22.B, Z9.B
    SUDOT Z6.S, Z28.B, Z7.B[0x0]
    SUDOT Z8.S, Z0.B, Z7.B[0x2]
    USMMLA Z13.S, Z25.B, Z29.B
    SUDOT Z20.S, Z8.B, Z4.B[0x0]
    UMMLA Z13.S, Z7.B, Z11.B
    USMMLA Z28.S, Z17.B, Z3.B
    USMMLA Z11.S, Z28.B, Z23.B
    USMMLA Z26.S, Z11.B, Z25.B
    USMMLA Z1.S, Z0.B, Z13.B
    USMMLA Z9.S, Z10.B, Z1.B
    UMMLA Z27.S, Z30.B, Z7.B
    USMMLA Z22.S, Z10.B, Z2.B
    SUDOT Z9.S, Z16.B, Z6.B[0x3]
    USDOT Z15.S, Z5.B, Z4.B[0x1]
    SUDOT Z29.S, Z25.B, Z0.B[0x2]
    USMMLA Z29.S, Z19.B, Z9.B
    USDOT Z20.S, Z6.B, Z15.B
    SMMLA Z10.S, Z21.B, Z8.B
    USDOT Z5.S, Z26.B, Z9.B
    SMMLA Z4.S, Z4.B, Z3.B
    USDOT Z23.S, Z6.B, Z5.B[0x2]
    USMMLA Z4.S, Z21.B, Z21.B
    SMMLA Z17.S, Z30.B, Z5.B
    USMMLA Z22.S, Z2.B, Z17.B
    SUDOT Z9.S, Z9.B, Z2.B[0x2]
    USDOT Z15.S, Z17.B, Z2.B[0x2]
    USDOT Z15.S, Z23.B, Z0.B[0x1]
    USDOT Z9.S, Z26.B, Z4.B
    USMMLA Z11.S, Z11.B, Z14.B
    SMMLA Z9.S, Z19.B, Z17.B
    SUDOT Z20.S, Z3.B, Z2.B[0x1]
    USDOT Z22.S, Z11.B, Z4.B[0x2]
    USDOT Z15.S, Z23.B, Z26.B
    SUDOT Z29.S, Z15.B, Z0.B[0x1]
    SUDOT Z27.S, Z9.B, Z6.B[0x0]
    USMMLA Z8.S, Z2.B, Z27.B
    SMMLA Z29.S, Z8.B, Z8.B
    USDOT Z12.S, Z27.B, Z0.B[0x3]
    USDOT Z5.S, Z22.B, Z5.B[0x0]
    USDOT Z26.S, Z8.B, Z29.B
    UMMLA Z2.S, Z20.B, Z12.B
    SMMLA Z2.S, Z20.B, Z5.B
    UMMLA Z23.S, Z2.B, Z16.B
    UMMLA Z26.S, Z22.B, Z26.B
    USMMLA Z24.S, Z23.B, Z23.B
    USMMLA Z24.S, Z10.B, Z5.B
    USDOT Z12.S, Z26.B, Z29.B
    USDOT Z15.S, Z8.B, Z1.B[0x2]
    SUDOT Z31.S, Z8.B, Z2.B[0x1]
    USDOT Z14.S, Z21.B, Z5.B[0x2]
    SMMLA Z20.S, Z11.B, Z30.B
    USMMLA Z13.S, Z24.B, Z8.B
    USMMLA Z29.S, Z23.B, Z29.B
    USDOT Z17.S, Z7.B, Z2.B
    USDOT Z3.S, Z19.B, Z3.B[0x2]
    UMMLA Z15.S, Z12.B, Z17.B
    USDOT Z20.S, Z15.B, Z10.B
    USMMLA Z15.S, Z4.B, Z13.B
    SUDOT Z14.S, Z29.B, Z3.B[0x3]
    UMMLA Z14.S, Z31.B, Z20.B
    USMMLA Z1.S, Z11.B, Z1.B
    USDOT Z25.S, Z8.B, Z2.B[0x0]
    SUDOT Z13.S, Z28.B, Z0.B[0x0]
    SMMLA Z14.S, Z5.B, Z26.B
    USDOT Z11.S, Z25.B, Z27.B
    SUDOT Z17.S, Z14.B, Z4.B[0x3]
    USMMLA Z18.S, Z27.B, Z3.B
    USMMLA Z15.S, Z3.B, Z14.B
    SUDOT Z19.S, Z29.B, Z6.B[0x1]
    USDOT Z25.S, Z19.B, Z2.B[0x0]
    SUDOT Z19.S, Z17.B, Z4.B[0x1]
    USDOT Z9.S, Z1.B, Z9.B
    USDOT Z30.S, Z25.B, Z1.B[0x2]
    SMMLA Z2.S, Z28.B, Z10.B
    USDOT Z1.S, Z26.B, Z8.B
    SMMLA Z19.S, Z1.B, Z1.B
    UMMLA Z19.S, Z18.B, Z14.B
    USDOT Z11.S, Z11.B, Z0.B[0x1]
    USMMLA Z11.S, Z27.B, Z13.B
    USDOT Z15.S, Z9.B, Z2.B[0x1]
    SUDOT Z19.S, Z17.B, Z4.B[0x1]
    USMMLA Z14.S, Z25.B, Z15.B
    UMMLA Z11.S, Z14.B, Z31.B
    UMMLA Z5.S, Z11.B, Z30.B
    UMMLA Z21.S, Z4.B, Z19.B
    SMMLA Z2.S, Z22.B, Z7.B
    USMMLA Z28.S, Z21.B, Z6.B
    SMMLA Z15.S, Z25.B, Z13.B
    SMMLA Z28.S, Z31.B, Z23.B
    USMMLA Z21.S, Z29.B, Z26.B
    USDOT Z30.S, Z21.B, Z6.B[0x2]
    USMMLA Z1.S, Z22.B, Z27.B
    SUDOT Z22.S, Z13.B, Z6.B[0x1]
    UMMLA Z12.S, Z18.B, Z2.B
    UMMLA Z18.S, Z15.B, Z29.B
    USDOT Z18.S, Z26.B, Z2.B[0x0]
    USDOT Z21.S, Z22.B, Z16.B
    SUBS  X21, X21, #0x1
    B.NE  LCRTSveVectorI8MM_label_1
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTSveVectorI8MM_TestFail
    MRS  X14, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
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
    FMOV  X14, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X14, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X14, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X14, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X14, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X14, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P2, Z6.D
    FMOV  X14, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P5, Z7.D
    FMOV  X14, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P3, Z8.D
    FMOV  X14, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X14, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X14, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X14, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X14, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X14, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X14, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X14, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X14, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P1, Z17.D
    FMOV  X14, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X14, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X14, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P5, Z20.D
    FMOV  X14, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X14, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X14, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X14, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X14, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X14, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X14, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X14, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X14, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P1, Z29.D
    FMOV  X14, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P3, Z30.D
    FMOV  X14, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X14, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X20
    DUP     Z1.D, X16
    DUP     Z2.D, X29
    DUP     Z3.D, X21
    DUP     Z4.D, X18
    DUP     Z5.D, X10
    DUP     Z6.D, X22
    DUP     Z7.D, X23
    DUP     Z8.D, X7
    DUP     Z9.D, X18
    DUP     Z10.D, X20
    DUP     Z11.D, X6
    DUP     Z12.D, X14
    DUP     Z13.D, X23
    DUP     Z14.D, X16
    DUP     Z15.D, X15
    DUP     Z16.D, X7
    DUP     Z17.D, X5
    DUP     Z18.D, X13
    DUP     Z19.D, X10
    DUP     Z20.D, X14
    DUP     Z21.D, X29
    DUP     Z22.D, X7
    DUP     Z23.D, X6
    DUP     Z24.D, X7
    DUP     Z25.D, X9
    DUP     Z26.D, X10
    DUP     Z27.D, X11
    DUP     Z28.D, X14
    DUP     Z29.D, X29
    DUP     Z30.D, X15
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
    MOVZ  X6, #0xa, LSL #0
LCRTSveVectorI8MM_label_2:
    USDOT Z21.S, Z4.B, Z2.B[0x3]
    SUDOT Z27.S, Z15.B, Z2.B[0x0]
    SUDOT Z27.S, Z31.B, Z1.B[0x3]
    SMMLA Z21.S, Z17.B, Z20.B
    SUDOT Z7.S, Z27.B, Z6.B[0x0]
    SUDOT Z7.S, Z7.B, Z7.B[0x2]
    USDOT Z28.S, Z21.B, Z7.B[0x1]
    SUDOT Z25.S, Z20.B, Z0.B[0x0]
    USDOT Z4.S, Z22.B, Z7.B[0x0]
    USMMLA Z22.S, Z4.B, Z28.B
    SMMLA Z25.S, Z30.B, Z15.B
    SMMLA Z25.S, Z4.B, Z25.B
    SUDOT Z25.S, Z25.B, Z1.B[0x0]
    SUDOT Z22.S, Z12.B, Z5.B[0x1]
    SUDOT Z15.S, Z0.B, Z5.B[0x0]
    SUDOT Z4.S, Z18.B, Z7.B[0x2]
    SMMLA Z24.S, Z29.B, Z5.B
    UMMLA Z16.S, Z8.B, Z14.B
    USDOT Z21.S, Z19.B, Z6.B[0x3]
    SUDOT Z1.S, Z23.B, Z1.B[0x0]
    SUDOT Z1.S, Z28.B, Z1.B[0x2]
    SMMLA Z21.S, Z21.B, Z2.B
    SUDOT Z13.S, Z21.B, Z4.B[0x0]
    UMMLA Z24.S, Z27.B, Z13.B
    SUDOT Z21.S, Z2.B, Z5.B[0x2]
    USDOT Z18.S, Z26.B, Z6.B[0x2]
    USDOT Z12.S, Z15.B, Z31.B
    SUDOT Z28.S, Z13.B, Z4.B[0x3]
    USDOT Z1.S, Z22.B, Z1.B[0x1]
    USDOT Z12.S, Z16.B, Z16.B
    SMMLA Z19.S, Z2.B, Z21.B
    USDOT Z1.S, Z28.B, Z7.B[0x1]
    SMMLA Z18.S, Z24.B, Z7.B
    USMMLA Z1.S, Z1.B, Z19.B
    USMMLA Z1.S, Z8.B, Z28.B
    SMMLA Z1.S, Z12.B, Z23.B
    UMMLA Z1.S, Z18.B, Z20.B
    UMMLA Z17.S, Z10.B, Z20.B
    USDOT Z9.S, Z18.B, Z0.B[0x1]
    USDOT Z0.S, Z21.B, Z1.B
    USDOT Z28.S, Z7.B, Z6.B
    USDOT Z26.S, Z24.B, Z6.B
    SMMLA Z12.S, Z4.B, Z22.B
    SMMLA Z27.S, Z28.B, Z3.B
    SMMLA Z8.S, Z11.B, Z9.B
    USMMLA Z11.S, Z11.B, Z13.B
    SUDOT Z22.S, Z12.B, Z6.B[0x0]
    USMMLA Z20.S, Z16.B, Z31.B
    SMMLA Z23.S, Z12.B, Z2.B
    UMMLA Z17.S, Z0.B, Z1.B
    USDOT Z20.S, Z22.B, Z6.B[0x2]
    SMMLA Z26.S, Z22.B, Z23.B
    UMMLA Z11.S, Z20.B, Z26.B
    UMMLA Z11.S, Z17.B, Z3.B
    UMMLA Z8.S, Z8.B, Z27.B
    USDOT Z2.S, Z20.B, Z28.B
    SUDOT Z8.S, Z11.B, Z3.B[0x3]
    SUDOT Z2.S, Z10.B, Z3.B[0x1]
    USDOT Z29.S, Z2.B, Z4.B[0x1]
    USDOT Z17.S, Z28.B, Z27.B
    SUDOT Z29.S, Z6.B, Z7.B[0x0]
    USDOT Z13.S, Z27.B, Z7.B[0x3]
    USDOT Z17.S, Z18.B, Z8.B
    USMMLA Z17.S, Z12.B, Z23.B
    UMMLA Z22.S, Z1.B, Z10.B
    USMMLA Z28.S, Z9.B, Z28.B
    UMMLA Z18.S, Z28.B, Z1.B
    UMMLA Z11.S, Z0.B, Z20.B
    USDOT Z16.S, Z23.B, Z7.B[0x3]
    USDOT Z30.S, Z7.B, Z2.B
    SMMLA Z23.S, Z27.B, Z17.B
    USDOT Z14.S, Z4.B, Z5.B
    USMMLA Z15.S, Z16.B, Z14.B
    SUDOT Z23.S, Z29.B, Z5.B[0x1]
    UMMLA Z6.S, Z11.B, Z23.B
    SUDOT Z27.S, Z15.B, Z5.B[0x3]
    USMMLA Z21.S, Z13.B, Z13.B
    SMMLA Z14.S, Z4.B, Z27.B
    USDOT Z5.S, Z30.B, Z14.B
    USMMLA Z20.S, Z21.B, Z16.B
    UMMLA Z20.S, Z6.B, Z5.B
    USDOT Z22.S, Z18.B, Z14.B
    USDOT Z13.S, Z25.B, Z21.B
    UMMLA Z14.S, Z7.B, Z24.B
    USDOT Z27.S, Z28.B, Z1.B
    USMMLA Z11.S, Z21.B, Z3.B
    SMMLA Z8.S, Z26.B, Z11.B
    SMMLA Z29.S, Z22.B, Z30.B
    SMMLA Z29.S, Z20.B, Z14.B
    USDOT Z3.S, Z28.B, Z7.B[0x0]
    SMMLA Z31.S, Z13.B, Z3.B
    UMMLA Z30.S, Z11.B, Z21.B
    SUDOT Z12.S, Z12.B, Z4.B[0x1]
    USDOT Z11.S, Z9.B, Z1.B[0x2]
    USMMLA Z19.S, Z17.B, Z28.B
    SMMLA Z18.S, Z14.B, Z16.B
    SUDOT Z29.S, Z11.B, Z5.B[0x0]
    SUDOT Z7.S, Z12.B, Z4.B[0x3]
    USDOT Z18.S, Z31.B, Z7.B[0x1]
    USMMLA Z8.S, Z30.B, Z3.B
    USMMLA Z29.S, Z27.B, Z29.B
    UMMLA Z8.S, Z28.B, Z17.B
    UMMLA Z8.S, Z4.B, Z29.B
    USDOT Z23.S, Z19.B, Z5.B[0x1]
    USMMLA Z4.S, Z11.B, Z18.B
    SMMLA Z4.S, Z14.B, Z4.B
    SUDOT Z4.S, Z28.B, Z3.B[0x2]
    USDOT Z14.S, Z27.B, Z8.B
    USMMLA Z0.S, Z4.B, Z14.B
    USDOT Z30.S, Z13.B, Z26.B
    USMMLA Z27.S, Z17.B, Z5.B
    USDOT Z12.S, Z27.B, Z1.B[0x2]
    USDOT Z16.S, Z17.B, Z3.B[0x0]
    USDOT Z0.S, Z14.B, Z24.B
    UMMLA Z12.S, Z17.B, Z27.B
    USDOT Z1.S, Z23.B, Z14.B
    SUDOT Z21.S, Z23.B, Z5.B[0x0]
    USDOT Z0.S, Z7.B, Z6.B[0x3]
    USDOT Z10.S, Z18.B, Z31.B
    USDOT Z3.S, Z27.B, Z9.B
    USDOT Z18.S, Z16.B, Z27.B
    USDOT Z26.S, Z23.B, Z4.B
    SUDOT Z3.S, Z18.B, Z1.B[0x0]
    USDOT Z21.S, Z23.B, Z0.B
    SMMLA Z30.S, Z30.B, Z27.B
    USDOT Z26.S, Z10.B, Z21.B
    SUDOT Z3.S, Z14.B, Z0.B[0x2]
    USDOT Z26.S, Z30.B, Z3.B[0x3]
    UMMLA Z4.S, Z15.B, Z6.B
    USDOT Z20.S, Z8.B, Z0.B[0x2]
    USDOT Z7.S, Z18.B, Z5.B[0x3]
    USMMLA Z0.S, Z26.B, Z25.B
    UMMLA Z11.S, Z27.B, Z5.B
    USDOT Z31.S, Z19.B, Z1.B
    USDOT Z30.S, Z2.B, Z6.B[0x1]
    USDOT Z19.S, Z22.B, Z8.B
    SMMLA Z20.S, Z10.B, Z12.B
    UMMLA Z11.S, Z4.B, Z12.B
    UMMLA Z11.S, Z9.B, Z30.B
    USDOT Z21.S, Z31.B, Z2.B
    USDOT Z19.S, Z24.B, Z0.B[0x2]
    USDOT Z6.S, Z7.B, Z3.B[0x1]
    USDOT Z20.S, Z21.B, Z1.B[0x2]
    USDOT Z30.S, Z19.B, Z19.B
    USDOT Z21.S, Z7.B, Z20.B
    USDOT Z14.S, Z21.B, Z6.B
    USDOT Z14.S, Z9.B, Z1.B
    USDOT Z11.S, Z30.B, Z26.B
    SMMLA Z17.S, Z11.B, Z17.B
    UMMLA Z3.S, Z8.B, Z11.B
    UMMLA Z10.S, Z6.B, Z13.B
    SUDOT Z20.S, Z2.B, Z5.B[0x2]
    SUDOT Z29.S, Z25.B, Z0.B[0x2]
    USDOT Z13.S, Z25.B, Z1.B[0x2]
    USDOT Z23.S, Z3.B, Z5.B[0x1]
    SUDOT Z29.S, Z29.B, Z2.B[0x3]
    USDOT Z3.S, Z8.B, Z7.B[0x1]
    UMMLA Z14.S, Z24.B, Z29.B
    SMMLA Z12.S, Z14.B, Z30.B
    USMMLA Z31.S, Z31.B, Z18.B
    USMMLA Z24.S, Z11.B, Z15.B
    SMMLA Z23.S, Z9.B, Z22.B
    USMMLA Z17.S, Z13.B, Z20.B
    SMMLA Z17.S, Z3.B, Z31.B
    SMMLA Z0.S, Z11.B, Z21.B
    UMMLA Z17.S, Z12.B, Z27.B
    USDOT Z0.S, Z5.B, Z1.B[0x0]
    UMMLA Z23.S, Z23.B, Z17.B
    USDOT Z26.S, Z0.B, Z0.B[0x1]
    UMMLA Z23.S, Z10.B, Z23.B
    USDOT Z0.S, Z23.B, Z6.B
    UMMLA Z0.S, Z19.B, Z30.B
    USMMLA Z25.S, Z24.B, Z26.B
    UMMLA Z0.S, Z28.B, Z22.B
    USDOT Z3.S, Z24.B, Z2.B[0x0]
    SMMLA Z28.S, Z10.B, Z3.B
    USDOT Z14.S, Z21.B, Z1.B[0x3]
    UMMLA Z23.S, Z26.B, Z4.B
    USDOT Z16.S, Z25.B, Z6.B
    UMMLA Z17.S, Z11.B, Z26.B
    SMMLA Z31.S, Z2.B, Z11.B
    SMMLA Z2.S, Z23.B, Z31.B
    USDOT Z2.S, Z22.B, Z6.B
    SUDOT Z15.S, Z28.B, Z5.B[0x3]
    USDOT Z28.S, Z2.B, Z6.B[0x3]
    USDOT Z15.S, Z25.B, Z1.B[0x3]
    SUDOT Z15.S, Z18.B, Z1.B[0x1]
    USDOT Z23.S, Z6.B, Z3.B[0x3]
    USMMLA Z27.S, Z22.B, Z22.B
    SUDOT Z22.S, Z28.B, Z5.B[0x3]
    SMMLA Z7.S, Z5.B, Z12.B
    USDOT Z0.S, Z8.B, Z0.B[0x2]
    USDOT Z2.S, Z7.B, Z30.B
    USDOT Z22.S, Z17.B, Z3.B[0x3]
    UMMLA Z6.S, Z24.B, Z16.B
    SUDOT Z0.S, Z15.B, Z2.B[0x3]
    USMMLA Z23.S, Z2.B, Z27.B
    SMMLA Z23.S, Z14.B, Z6.B
    SMMLA Z26.S, Z0.B, Z11.B
    USDOT Z6.S, Z22.B, Z4.B[0x2]
    SUBS  X6, X6, #0x1
    B.NE  LCRTSveVectorI8MM_label_2
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MRS  X8, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X18, #0x9f9e, LSL #0
    MOVK  X18, #0xe, LSL #16
    MOVK  X18, #0x9f9e, LSL #32
    MOVK  X18, #0xe, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D0
    MOVZ  X18, #0x9f9e, LSL #0
    MOVK  X18, #0xe, LSL #16
    MOVK  X18, #0x9f9e, LSL #32
    MOVK  X18, #0xe, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X18, #0xa785, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0xa785, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D1
    MOVZ  X18, #0xa785, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0xa785, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X18, #0xcd67, LSL #0
    MOVK  X18, #0xcd67, LSL #32
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D2
    MOVZ  X18, #0xcd67, LSL #0
    MOVK  X18, #0xcd67, LSL #32
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X18, #0x2207, LSL #0
    MOVK  X18, #0xd, LSL #16
    MOVK  X18, #0x2207, LSL #32
    MOVK  X18, #0xd, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D3
    MOVZ  X18, #0x2207, LSL #0
    MOVK  X18, #0xd, LSL #16
    MOVK  X18, #0x2207, LSL #32
    MOVK  X18, #0xd, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X18, #0x8e86, LSL #0
    MOVK  X18, #0xc, LSL #16
    MOVK  X18, #0x8e86, LSL #32
    MOVK  X18, #0xc, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D4
    MOVZ  X18, #0x8e86, LSL #0
    MOVK  X18, #0xc, LSL #16
    MOVK  X18, #0x8e86, LSL #32
    MOVK  X18, #0xc, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X18, #0x4279, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x4279, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D5
    MOVZ  X18, #0x4279, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x4279, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X18, #0xc234, LSL #0
    MOVK  X18, #0x18, LSL #16
    MOVK  X18, #0xc234, LSL #32
    MOVK  X18, #0x18, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D6
    MOVZ  X18, #0xc234, LSL #0
    MOVK  X18, #0x18, LSL #16
    MOVK  X18, #0xc234, LSL #32
    MOVK  X18, #0x18, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X18, #0x70b6, LSL #0
    MOVK  X18, #0xfffd, LSL #16
    MOVK  X18, #0x70b6, LSL #32
    MOVK  X18, #0xfffd, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D7
    MOVZ  X18, #0x70b6, LSL #0
    MOVK  X18, #0xfffd, LSL #16
    MOVK  X18, #0x70b6, LSL #32
    MOVK  X18, #0xfffd, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X18, #0xd0d9, LSL #0
    MOVK  X18, #0x26, LSL #16
    MOVK  X18, #0xd0d9, LSL #32
    MOVK  X18, #0x26, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D8
    MOVZ  X18, #0xd0d9, LSL #0
    MOVK  X18, #0x26, LSL #16
    MOVK  X18, #0xd0d9, LSL #32
    MOVK  X18, #0x26, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X18, #0x9daf, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x9daf, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D9
    MOVZ  X18, #0x9daf, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x9daf, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X18, #0x38de, LSL #0
    MOVK  X18, #0xd, LSL #16
    MOVK  X18, #0x38de, LSL #32
    MOVK  X18, #0xd, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D10
    MOVZ  X18, #0x38de, LSL #0
    MOVK  X18, #0xd, LSL #16
    MOVK  X18, #0x38de, LSL #32
    MOVK  X18, #0xd, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X18, #0x543d, LSL #0
    MOVK  X18, #0x61, LSL #16
    MOVK  X18, #0x543d, LSL #32
    MOVK  X18, #0x61, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D11
    MOVZ  X18, #0x543d, LSL #0
    MOVK  X18, #0x61, LSL #16
    MOVK  X18, #0x543d, LSL #32
    MOVK  X18, #0x61, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X18, #0xcc4, LSL #0
    MOVK  X18, #0x8, LSL #16
    MOVK  X18, #0xcc4, LSL #32
    MOVK  X18, #0x8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D12
    MOVZ  X18, #0xcc4, LSL #0
    MOVK  X18, #0x8, LSL #16
    MOVK  X18, #0xcc4, LSL #32
    MOVK  X18, #0x8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X18, #0xf457, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0xf457, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D13
    MOVZ  X18, #0xf457, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0xf457, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X18, #0xfa23, LSL #0
    MOVK  X18, #0x11, LSL #16
    MOVK  X18, #0xfa23, LSL #32
    MOVK  X18, #0x11, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D14
    MOVZ  X18, #0xfa23, LSL #0
    MOVK  X18, #0x11, LSL #16
    MOVK  X18, #0xfa23, LSL #32
    MOVK  X18, #0x11, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X18, #0x78b2, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x78b2, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D15
    MOVZ  X18, #0x78b2, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x78b2, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X18, #0x69f, LSL #0
    MOVK  X18, #0x11, LSL #16
    MOVK  X18, #0x69f, LSL #32
    MOVK  X18, #0x11, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D16
    MOVZ  X18, #0x69f, LSL #0
    MOVK  X18, #0x11, LSL #16
    MOVK  X18, #0x69f, LSL #32
    MOVK  X18, #0x11, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X18, #0xe8ed, LSL #0
    MOVK  X18, #0x3c, LSL #16
    MOVK  X18, #0xe8ed, LSL #32
    MOVK  X18, #0x3c, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D17
    MOVZ  X18, #0xe8ed, LSL #0
    MOVK  X18, #0x3c, LSL #16
    MOVK  X18, #0xe8ed, LSL #32
    MOVK  X18, #0x3c, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X18, #0x330, LSL #0
    MOVK  X18, #0x24, LSL #16
    MOVK  X18, #0x330, LSL #32
    MOVK  X18, #0x24, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D18
    MOVZ  X18, #0x330, LSL #0
    MOVK  X18, #0x24, LSL #16
    MOVK  X18, #0x330, LSL #32
    MOVK  X18, #0x24, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X18, #0x2bbe, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0x2bbe, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D19
    MOVZ  X18, #0x2bbe, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0x2bbe, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X18, #0x230a, LSL #0
    MOVK  X18, #0xa, LSL #16
    MOVK  X18, #0x230a, LSL #32
    MOVK  X18, #0xa, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D20
    MOVZ  X18, #0x230a, LSL #0
    MOVK  X18, #0xa, LSL #16
    MOVK  X18, #0x230a, LSL #32
    MOVK  X18, #0xa, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X18, #0xeca3, LSL #0
    MOVK  X18, #0xfffc, LSL #16
    MOVK  X18, #0xeca3, LSL #32
    MOVK  X18, #0xfffc, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D21
    MOVZ  X18, #0xeca3, LSL #0
    MOVK  X18, #0xfffc, LSL #16
    MOVK  X18, #0xeca3, LSL #32
    MOVK  X18, #0xfffc, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X18, #0x5f6c, LSL #0
    MOVK  X18, #0xf, LSL #16
    MOVK  X18, #0x5f6c, LSL #32
    MOVK  X18, #0xf, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D22
    MOVZ  X18, #0x5f6c, LSL #0
    MOVK  X18, #0xf, LSL #16
    MOVK  X18, #0x5f6c, LSL #32
    MOVK  X18, #0xf, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X18, #0x6440, LSL #0
    MOVK  X18, #0x1d, LSL #16
    MOVK  X18, #0x6440, LSL #32
    MOVK  X18, #0x1d, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D23
    MOVZ  X18, #0x6440, LSL #0
    MOVK  X18, #0x1d, LSL #16
    MOVK  X18, #0x6440, LSL #32
    MOVK  X18, #0x1d, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X18, #0x2a81, LSL #0
    MOVK  X18, #0x10, LSL #16
    MOVK  X18, #0x2a81, LSL #32
    MOVK  X18, #0x10, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D24
    MOVZ  X18, #0x2a81, LSL #0
    MOVK  X18, #0x10, LSL #16
    MOVK  X18, #0x2a81, LSL #32
    MOVK  X18, #0x10, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X18, #0x212c, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0x212c, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D25
    MOVZ  X18, #0x212c, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0x212c, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X18, #0x3fd6, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x3fd6, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D26
    MOVZ  X18, #0x3fd6, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x3fd6, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X18, #0x1aa4, LSL #0
    MOVK  X18, #0xfffb, LSL #16
    MOVK  X18, #0x1aa4, LSL #32
    MOVK  X18, #0xfffb, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D27
    MOVZ  X18, #0x1aa4, LSL #0
    MOVK  X18, #0xfffb, LSL #16
    MOVK  X18, #0x1aa4, LSL #32
    MOVK  X18, #0xfffb, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X18, #0x32d, LSL #0
    MOVK  X18, #0xfffe, LSL #16
    MOVK  X18, #0x32d, LSL #32
    MOVK  X18, #0xfffe, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D28
    MOVZ  X18, #0x32d, LSL #0
    MOVK  X18, #0xfffe, LSL #16
    MOVK  X18, #0x32d, LSL #32
    MOVK  X18, #0xfffe, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X18, #0x39e3, LSL #0
    MOVK  X18, #0xfffe, LSL #16
    MOVK  X18, #0x39e3, LSL #32
    MOVK  X18, #0xfffe, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D29
    MOVZ  X18, #0x39e3, LSL #0
    MOVK  X18, #0xfffe, LSL #16
    MOVK  X18, #0x39e3, LSL #32
    MOVK  X18, #0xfffe, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X18, #0x58e7, LSL #0
    MOVK  X18, #0xb, LSL #16
    MOVK  X18, #0x58e7, LSL #32
    MOVK  X18, #0xb, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D30
    MOVZ  X18, #0x58e7, LSL #0
    MOVK  X18, #0xb, LSL #16
    MOVK  X18, #0x58e7, LSL #32
    MOVK  X18, #0xb, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X18, #0x6406, LSL #0
    MOVK  X18, #0x6406, LSL #32
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X8, D31
    MOVZ  X18, #0x6406, LSL #0
    MOVK  X18, #0x6406, LSL #32
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X8, #0x0, LSL #0
    STR  X8, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X8, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
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
    FMOV  X8, D0
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P1, Z1.D
    FMOV  X8, D1
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X8, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X8, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X8, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X8, D5
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X8, D6
    MOVZ  X18, #0xc234, LSL #0
    MOVK  X18, #0x18, LSL #16
    MOVK  X18, #0xc234, LSL #32
    MOVK  X18, #0x38, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P7, Z7.D
    FMOV  X8, D7
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P7, Z8.D
    FMOV  X8, D8
    MOVZ  X18, #0xd0d9, LSL #0
    MOVK  X18, #0x26, LSL #16
    MOVK  X18, #0xd0d9, LSL #32
    MOVK  X18, #0x46, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X8, D9
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X8, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P3, Z11.D
    FMOV  X8, D11
    MOVZ  X18, #0x543d, LSL #0
    MOVK  X18, #0x61, LSL #16
    MOVK  X18, #0x543d, LSL #32
    MOVK  X18, #0x81, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X8, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P3, Z13.D
    FMOV  X8, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X8, D14
    MOVZ  X18, #0xfa23, LSL #0
    MOVK  X18, #0x11, LSL #16
    MOVK  X18, #0xfa23, LSL #32
    MOVK  X18, #0x31, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X8, D15
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X8, D16
    MOVZ  X18, #0x69f, LSL #0
    MOVK  X18, #0x11, LSL #16
    MOVK  X18, #0x69f, LSL #32
    MOVK  X18, #0x31, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X8, D17
    MOVZ  X18, #0xe8ed, LSL #0
    MOVK  X18, #0x3c, LSL #16
    MOVK  X18, #0xe8ed, LSL #32
    MOVK  X18, #0x5c, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X8, D18
    MOVZ  X18, #0x330, LSL #0
    MOVK  X18, #0x24, LSL #16
    MOVK  X18, #0x330, LSL #32
    MOVK  X18, #0x44, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X8, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P5, Z20.D
    FMOV  X8, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X8, D21
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X8, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X8, D23
    MOVZ  X18, #0x6440, LSL #0
    MOVK  X18, #0x1d, LSL #16
    MOVK  X18, #0x6440, LSL #32
    MOVK  X18, #0x3d, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X8, D24
    MOVZ  X18, #0x2a81, LSL #0
    MOVK  X18, #0x10, LSL #16
    MOVK  X18, #0x2a81, LSL #32
    MOVK  X18, #0x30, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X8, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X8, D26
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P4, Z27.D
    FMOV  X8, D27
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X8, D28
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X8, D29
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X8, D30
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X8, D31
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X10
    DUP     Z1.D, X2
    DUP     Z2.D, X11
    DUP     Z3.D, X20
    DUP     Z4.D, X23
    DUP     Z5.D, X21
    DUP     Z6.D, X22
    DUP     Z7.D, X15
    DUP     Z8.D, X20
    DUP     Z9.D, X4
    DUP     Z10.D, X15
    DUP     Z11.D, X19
    DUP     Z12.D, X22
    DUP     Z13.D, X22
    DUP     Z14.D, X13
    DUP     Z15.D, X13
    DUP     Z16.D, X4
    DUP     Z17.D, X23
    DUP     Z18.D, X4
    DUP     Z19.D, X3
    DUP     Z20.D, X6
    DUP     Z21.D, X20
    DUP     Z22.D, X5
    DUP     Z23.D, X17
    DUP     Z24.D, X19
    DUP     Z25.D, X21
    DUP     Z26.D, X3
    DUP     Z27.D, X21
    DUP     Z28.D, X18
    DUP     Z29.D, X20
    DUP     Z30.D, X11
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
    MOVZ  X21, #0xa, LSL #0
LCRTSveVectorI8MM_label_3:
    USDOT Z27.S, Z5.B, Z29.B
    UMMLA Z27.S, Z30.B, Z20.B
    USMMLA Z17.S, Z5.B, Z2.B
    UMMLA Z14.S, Z11.B, Z4.B
    USMMLA Z24.S, Z27.B, Z27.B
    USMMLA Z17.S, Z17.B, Z26.B
    USDOT Z24.S, Z17.B, Z14.B
    USDOT Z24.S, Z8.B, Z3.B
    SMMLA Z24.S, Z15.B, Z24.B
    USMMLA Z6.S, Z30.B, Z6.B
    USDOT Z31.S, Z2.B, Z6.B
    USDOT Z31.S, Z31.B, Z4.B[0x3]
    SMMLA Z5.S, Z26.B, Z11.B
    USMMLA Z13.S, Z20.B, Z2.B
    USMMLA Z5.S, Z24.B, Z19.B
    USMMLA Z28.S, Z22.B, Z11.B
    SMMLA Z5.S, Z1.B, Z10.B
    USDOT Z3.S, Z10.B, Z1.B[0x3]
    SMMLA Z14.S, Z24.B, Z26.B
    SMMLA Z24.S, Z12.B, Z24.B
    USDOT Z8.S, Z25.B, Z2.B[0x0]
    USDOT Z3.S, Z7.B, Z1.B[0x2]
    UMMLA Z29.S, Z10.B, Z15.B
    USDOT Z31.S, Z2.B, Z5.B[0x0]
    SUDOT Z28.S, Z0.B, Z1.B[0x0]
    USMMLA Z31.S, Z4.B, Z29.B
    UMMLA Z14.S, Z24.B, Z31.B
    SMMLA Z3.S, Z3.B, Z8.B
    USDOT Z13.S, Z29.B, Z3.B
    USDOT Z13.S, Z11.B, Z21.B
    SUDOT Z31.S, Z22.B, Z3.B[0x3]
    SUDOT Z31.S, Z5.B, Z3.B[0x2]
    SUDOT Z25.S, Z28.B, Z0.B[0x0]
    SMMLA Z14.S, Z23.B, Z14.B
    USMMLA Z14.S, Z31.B, Z11.B
    UMMLA Z13.S, Z14.B, Z16.B
    USMMLA Z27.S, Z22.B, Z28.B
    USDOT Z20.S, Z24.B, Z7.B[0x2]
    SUDOT Z4.S, Z4.B, Z0.B[0x3]
    SUDOT Z14.S, Z29.B, Z7.B[0x2]
    SMMLA Z30.S, Z28.B, Z7.B
    SUDOT Z7.S, Z0.B, Z4.B[0x1]
    UMMLA Z21.S, Z2.B, Z5.B
    SMMLA Z18.S, Z3.B, Z6.B
    SMMLA Z18.S, Z30.B, Z18.B
    USDOT Z27.S, Z18.B, Z5.B
    USMMLA Z17.S, Z13.B, Z27.B
    USMMLA Z25.S, Z10.B, Z24.B
    SMMLA Z20.S, Z7.B, Z22.B
    UMMLA Z14.S, Z14.B, Z17.B
    SMMLA Z25.S, Z14.B, Z20.B
    USMMLA Z13.S, Z4.B, Z30.B
    UMMLA Z15.S, Z30.B, Z30.B
    SMMLA Z13.S, Z12.B, Z30.B
    UMMLA Z29.S, Z0.B, Z1.B
    USDOT Z27.S, Z10.B, Z12.B
    USDOT Z19.S, Z30.B, Z5.B[0x1]
    USMMLA Z28.S, Z2.B, Z16.B
    USDOT Z31.S, Z8.B, Z29.B
    USDOT Z2.S, Z24.B, Z25.B
    USDOT Z2.S, Z4.B, Z6.B[0x1]
    USDOT Z22.S, Z15.B, Z16.B
    SMMLA Z18.S, Z23.B, Z30.B
    SMMLA Z27.S, Z15.B, Z28.B
    SMMLA Z13.S, Z22.B, Z2.B
    USMMLA Z13.S, Z30.B, Z1.B
    USDOT Z19.S, Z13.B, Z5.B[0x1]
    USDOT Z25.S, Z31.B, Z31.B
    SUDOT Z25.S, Z19.B, Z5.B[0x1]
    SUDOT Z18.S, Z29.B, Z3.B[0x3]
    USDOT Z25.S, Z21.B, Z7.B[0x1]
    SMMLA Z8.S, Z25.B, Z4.B
    USMMLA Z6.S, Z18.B, Z21.B
    SUDOT Z27.S, Z27.B, Z7.B[0x0]
    SUDOT Z3.S, Z27.B, Z5.B[0x1]
    SUDOT Z3.S, Z3.B, Z3.B[0x1]
    SMMLA Z6.S, Z5.B, Z3.B
    SMMLA Z4.S, Z4.B, Z7.B
    USDOT Z17.S, Z6.B, Z8.B
    SUDOT Z5.S, Z6.B, Z7.B[0x3]
    SUDOT Z9.S, Z19.B, Z5.B[0x3]
    UMMLA Z29.S, Z29.B, Z28.B
    USDOT Z14.S, Z20.B, Z0.B[0x3]
    SMMLA Z21.S, Z20.B, Z14.B
    UMMLA Z11.S, Z2.B, Z8.B
    SUDOT Z20.S, Z7.B, Z1.B[0x2]
    USDOT Z14.S, Z17.B, Z1.B[0x3]
    UMMLA Z22.S, Z31.B, Z13.B
    USMMLA Z16.S, Z2.B, Z31.B
    SUDOT Z11.S, Z1.B, Z4.B[0x0]
    USMMLA Z29.S, Z13.B, Z21.B
    USDOT Z14.S, Z20.B, Z9.B
    USMMLA Z29.S, Z16.B, Z14.B
    USDOT Z25.S, Z22.B, Z29.B
    SUDOT Z20.S, Z7.B, Z0.B[0x1]
    USDOT Z18.S, Z25.B, Z24.B
    SMMLA Z2.S, Z10.B, Z8.B
    UMMLA Z16.S, Z25.B, Z19.B
    USMMLA Z15.S, Z12.B, Z22.B
    UMMLA Z24.S, Z9.B, Z23.B
    SUDOT Z10.S, Z10.B, Z1.B[0x2]
    UMMLA Z0.S, Z16.B, Z19.B
    SMMLA Z26.S, Z30.B, Z24.B
    UMMLA Z28.S, Z22.B, Z18.B
    USMMLA Z22.S, Z17.B, Z21.B
    USDOT Z26.S, Z28.B, Z0.B[0x3]
    USMMLA Z20.S, Z11.B, Z26.B
    SMMLA Z2.S, Z3.B, Z12.B
    USMMLA Z28.S, Z20.B, Z20.B
    SUDOT Z15.S, Z23.B, Z2.B[0x2]
    SMMLA Z5.S, Z8.B, Z22.B
    USDOT Z23.S, Z10.B, Z31.B
    SUDOT Z23.S, Z23.B, Z2.B[0x1]
    USMMLA Z17.S, Z4.B, Z12.B
    UMMLA Z26.S, Z17.B, Z13.B
    SMMLA Z28.S, Z22.B, Z26.B
    USMMLA Z6.S, Z15.B, Z10.B
    USDOT Z28.S, Z28.B, Z19.B
    SUDOT Z28.S, Z0.B, Z6.B[0x0]
    SUDOT Z5.S, Z5.B, Z0.B[0x2]
    UMMLA Z5.S, Z23.B, Z30.B
    SUDOT Z30.S, Z10.B, Z2.B[0x0]
    UMMLA Z17.S, Z28.B, Z19.B
    UMMLA Z4.S, Z15.B, Z23.B
    SUDOT Z25.S, Z16.B, Z5.B[0x1]
    SUDOT Z2.S, Z7.B, Z4.B[0x3]
    SUDOT Z23.S, Z29.B, Z6.B[0x1]
    USDOT Z28.S, Z3.B, Z29.B
    UMMLA Z16.S, Z30.B, Z20.B
    USDOT Z0.S, Z16.B, Z7.B[0x2]
    SMMLA Z4.S, Z17.B, Z14.B
    USMMLA Z30.S, Z27.B, Z24.B
    USDOT Z20.S, Z28.B, Z2.B[0x0]
    USDOT Z14.S, Z22.B, Z28.B
    UMMLA Z16.S, Z6.B, Z12.B
    SMMLA Z28.S, Z25.B, Z21.B
    USMMLA Z4.S, Z23.B, Z17.B
    USDOT Z4.S, Z13.B, Z29.B
    USDOT Z2.S, Z5.B, Z6.B[0x0]
    UMMLA Z27.S, Z1.B, Z25.B
    SUDOT Z9.S, Z4.B, Z7.B[0x3]
    UMMLA Z19.S, Z28.B, Z30.B
    USDOT Z20.S, Z20.B, Z3.B[0x2]
    UMMLA Z30.S, Z14.B, Z9.B
    SMMLA Z0.S, Z21.B, Z3.B
    SUDOT Z2.S, Z3.B, Z0.B[0x0]
    SUDOT Z7.S, Z16.B, Z2.B[0x0]
    USMMLA Z19.S, Z14.B, Z16.B
    SUDOT Z9.S, Z30.B, Z7.B[0x2]
    USDOT Z26.S, Z20.B, Z2.B[0x0]
    USDOT Z26.S, Z27.B, Z19.B
    SUDOT Z9.S, Z4.B, Z7.B[0x1]
    UMMLA Z15.S, Z7.B, Z19.B
    SMMLA Z2.S, Z26.B, Z2.B
    USDOT Z28.S, Z1.B, Z6.B[0x1]
    USMMLA Z22.S, Z23.B, Z7.B
    UMMLA Z14.S, Z31.B, Z11.B
    USDOT Z15.S, Z1.B, Z16.B
    SUDOT Z25.S, Z30.B, Z3.B[0x3]
    USDOT Z24.S, Z21.B, Z5.B[0x1]
    SUDOT Z25.S, Z21.B, Z6.B[0x2]
    SMMLA Z13.S, Z5.B, Z6.B
    USMMLA Z18.S, Z17.B, Z5.B
    USMMLA Z9.S, Z22.B, Z13.B
    SMMLA Z18.S, Z15.B, Z25.B
    SUDOT Z18.S, Z7.B, Z5.B[0x2]
    SMMLA Z21.S, Z18.B, Z30.B
    USMMLA Z2.S, Z6.B, Z5.B
    USDOT Z9.S, Z28.B, Z9.B
    SMMLA Z2.S, Z10.B, Z2.B
    USDOT Z31.S, Z9.B, Z4.B[0x2]
    USDOT Z11.S, Z24.B, Z2.B[0x1]
    SUDOT Z31.S, Z31.B, Z0.B[0x0]
    UMMLA Z8.S, Z27.B, Z30.B
    UMMLA Z14.S, Z21.B, Z18.B
    UMMLA Z11.S, Z14.B, Z31.B
    SMMLA Z17.S, Z4.B, Z11.B
    USDOT Z0.S, Z24.B, Z25.B
    UMMLA Z25.S, Z25.B, Z12.B
    USDOT Z18.S, Z24.B, Z5.B
    USDOT Z12.S, Z4.B, Z6.B[0x0]
    USDOT Z1.S, Z22.B, Z6.B
    SMMLA Z14.S, Z6.B, Z11.B
    USMMLA Z16.S, Z22.B, Z8.B
    SMMLA Z8.S, Z13.B, Z12.B
    USDOT Z23.S, Z7.B, Z4.B[0x2]
    USMMLA Z29.S, Z8.B, Z23.B
    SMMLA Z17.S, Z0.B, Z14.B
    USDOT Z21.S, Z1.B, Z1.B[0x1]
    USMMLA Z25.S, Z16.B, Z25.B
    USMMLA Z14.S, Z29.B, Z21.B
    USDOT Z3.S, Z11.B, Z0.B[0x1]
    SMMLA Z18.S, Z3.B, Z3.B
    USDOT Z14.S, Z30.B, Z0.B[0x1]
    SMMLA Z26.S, Z2.B, Z17.B
    UMMLA Z31.S, Z2.B, Z14.B
    SUDOT Z4.S, Z17.B, Z0.B[0x3]
    USMMLA Z26.S, Z31.B, Z19.B
    SMMLA Z12.S, Z18.B, Z25.B
    SMMLA Z1.S, Z9.B, Z26.B
    SUBS  X21, X21, #0x1
    B.NE  LCRTSveVectorI8MM_label_3
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MRS  X14, FPSR
    MOVZ  X29, #0x80, LSL #0
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X29, #0x4862, LSL #0
    MOVK  X29, #0x5a75, LSL #16
    MOVK  X29, #0x4862, LSL #32
    MOVK  X29, #0x5a75, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D0
    MOVZ  X29, #0x4862, LSL #0
    MOVK  X29, #0x5a75, LSL #16
    MOVK  X29, #0x4862, LSL #32
    MOVK  X29, #0x5a75, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X29, #0x5a2d, LSL #0
    MOVK  X29, #0x5a62, LSL #16
    MOVK  X29, #0x5a2d, LSL #32
    MOVK  X29, #0x5a62, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D1
    MOVZ  X29, #0x5a2d, LSL #0
    MOVK  X29, #0x5a62, LSL #16
    MOVK  X29, #0x5a2d, LSL #32
    MOVK  X29, #0x5a62, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X29, #0x5ed8, LSL #0
    MOVK  X29, #0x5a83, LSL #16
    MOVK  X29, #0x5ed8, LSL #32
    MOVK  X29, #0x5a83, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D2
    MOVZ  X29, #0x5ed8, LSL #0
    MOVK  X29, #0x5a83, LSL #16
    MOVK  X29, #0x5ed8, LSL #32
    MOVK  X29, #0x5a83, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X29, #0xde6, LSL #0
    MOVK  X29, #0x5a6a, LSL #16
    MOVK  X29, #0xde6, LSL #32
    MOVK  X29, #0x5a6a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D3
    MOVZ  X29, #0xde6, LSL #0
    MOVK  X29, #0x5a6a, LSL #16
    MOVK  X29, #0xde6, LSL #32
    MOVK  X29, #0x5a6a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X29, #0x7e7f, LSL #0
    MOVK  X29, #0x5a7a, LSL #16
    MOVK  X29, #0x7e7f, LSL #32
    MOVK  X29, #0x5a7a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D4
    MOVZ  X29, #0x7e7f, LSL #0
    MOVK  X29, #0x5a7a, LSL #16
    MOVK  X29, #0x7e7f, LSL #32
    MOVK  X29, #0x5a7a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X29, #0x8f18, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0x8f18, LSL #32
    MOVK  X29, #0x5a85, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D5
    MOVZ  X29, #0x8f18, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0x8f18, LSL #32
    MOVK  X29, #0x5a85, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X29, #0x1912, LSL #0
    MOVK  X29, #0x5a74, LSL #16
    MOVK  X29, #0x1912, LSL #32
    MOVK  X29, #0x5a74, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D6
    MOVZ  X29, #0x1912, LSL #0
    MOVK  X29, #0x5a74, LSL #16
    MOVK  X29, #0x1912, LSL #32
    MOVK  X29, #0x5a74, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X29, #0x5b67, LSL #0
    MOVK  X29, #0x5a61, LSL #16
    MOVK  X29, #0x5b67, LSL #32
    MOVK  X29, #0x5a61, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D7
    MOVZ  X29, #0x5b67, LSL #0
    MOVK  X29, #0x5a61, LSL #16
    MOVK  X29, #0x5b67, LSL #32
    MOVK  X29, #0x5a61, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X29, #0x2335, LSL #0
    MOVK  X29, #0x5a74, LSL #16
    MOVK  X29, #0x2335, LSL #32
    MOVK  X29, #0x5a74, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D8
    MOVZ  X29, #0x2335, LSL #0
    MOVK  X29, #0x5a74, LSL #16
    MOVK  X29, #0x2335, LSL #32
    MOVK  X29, #0x5a74, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X29, #0x6e12, LSL #0
    MOVK  X29, #0x5a6c, LSL #16
    MOVK  X29, #0x6e12, LSL #32
    MOVK  X29, #0x5a6c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D9
    MOVZ  X29, #0x6e12, LSL #0
    MOVK  X29, #0x5a6c, LSL #16
    MOVK  X29, #0x6e12, LSL #32
    MOVK  X29, #0x5a6c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X29, #0x4e70, LSL #0
    MOVK  X29, #0x5a5d, LSL #16
    MOVK  X29, #0x4e70, LSL #32
    MOVK  X29, #0x5a5d, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D10
    MOVZ  X29, #0x4e70, LSL #0
    MOVK  X29, #0x5a5d, LSL #16
    MOVK  X29, #0x4e70, LSL #32
    MOVK  X29, #0x5a5d, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X29, #0x5457, LSL #0
    MOVK  X29, #0x5a80, LSL #16
    MOVK  X29, #0x5457, LSL #32
    MOVK  X29, #0x5a80, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D11
    MOVZ  X29, #0x5457, LSL #0
    MOVK  X29, #0x5a80, LSL #16
    MOVK  X29, #0x5457, LSL #32
    MOVK  X29, #0x5a80, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X29, #0xd643, LSL #0
    MOVK  X29, #0x5a63, LSL #16
    MOVK  X29, #0xd643, LSL #32
    MOVK  X29, #0x5a63, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D12
    MOVZ  X29, #0xd643, LSL #0
    MOVK  X29, #0x5a63, LSL #16
    MOVK  X29, #0xd643, LSL #32
    MOVK  X29, #0x5a63, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X29, #0x6781, LSL #0
    MOVK  X29, #0x5a95, LSL #16
    MOVK  X29, #0x6781, LSL #32
    MOVK  X29, #0x5a95, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D13
    MOVZ  X29, #0x6781, LSL #0
    MOVK  X29, #0x5a95, LSL #16
    MOVK  X29, #0x6781, LSL #32
    MOVK  X29, #0x5a95, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X29, #0x8718, LSL #0
    MOVK  X29, #0x5ad8, LSL #16
    MOVK  X29, #0x8718, LSL #32
    MOVK  X29, #0x5ad8, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D14
    MOVZ  X29, #0x8718, LSL #0
    MOVK  X29, #0x5ad8, LSL #16
    MOVK  X29, #0x8718, LSL #32
    MOVK  X29, #0x5ad8, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X29, #0x3dbb, LSL #0
    MOVK  X29, #0x5a88, LSL #16
    MOVK  X29, #0x3dbb, LSL #32
    MOVK  X29, #0x5a88, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D15
    MOVZ  X29, #0x3dbb, LSL #0
    MOVK  X29, #0x5a88, LSL #16
    MOVK  X29, #0x3dbb, LSL #32
    MOVK  X29, #0x5a88, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X29, #0x60f4, LSL #0
    MOVK  X29, #0x5a92, LSL #16
    MOVK  X29, #0x60f4, LSL #32
    MOVK  X29, #0x5a92, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D16
    MOVZ  X29, #0x60f4, LSL #0
    MOVK  X29, #0x5a92, LSL #16
    MOVK  X29, #0x60f4, LSL #32
    MOVK  X29, #0x5a92, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X29, #0x760, LSL #0
    MOVK  X29, #0x5a89, LSL #16
    MOVK  X29, #0x760, LSL #32
    MOVK  X29, #0x5a89, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D17
    MOVZ  X29, #0x760, LSL #0
    MOVK  X29, #0x5a89, LSL #16
    MOVK  X29, #0x760, LSL #32
    MOVK  X29, #0x5a89, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X29, #0x5694, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0x5694, LSL #32
    MOVK  X29, #0x5a85, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D18
    MOVZ  X29, #0x5694, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0x5694, LSL #32
    MOVK  X29, #0x5a85, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X29, #0xc6e5, LSL #0
    MOVK  X29, #0x5a75, LSL #16
    MOVK  X29, #0xc6e5, LSL #32
    MOVK  X29, #0x5a75, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D19
    MOVZ  X29, #0xc6e5, LSL #0
    MOVK  X29, #0x5a75, LSL #16
    MOVK  X29, #0xc6e5, LSL #32
    MOVK  X29, #0x5a75, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X29, #0xa1c3, LSL #0
    MOVK  X29, #0x5a73, LSL #16
    MOVK  X29, #0xa1c3, LSL #32
    MOVK  X29, #0x5a73, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D20
    MOVZ  X29, #0xa1c3, LSL #0
    MOVK  X29, #0x5a73, LSL #16
    MOVK  X29, #0xa1c3, LSL #32
    MOVK  X29, #0x5a73, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X29, #0xcebe, LSL #0
    MOVK  X29, #0x5a73, LSL #16
    MOVK  X29, #0xcebe, LSL #32
    MOVK  X29, #0x5a73, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D21
    MOVZ  X29, #0xcebe, LSL #0
    MOVK  X29, #0x5a73, LSL #16
    MOVK  X29, #0xcebe, LSL #32
    MOVK  X29, #0x5a73, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X29, #0x19c6, LSL #0
    MOVK  X29, #0x5a7a, LSL #16
    MOVK  X29, #0x19c6, LSL #32
    MOVK  X29, #0x5a7a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D22
    MOVZ  X29, #0x19c6, LSL #0
    MOVK  X29, #0x5a7a, LSL #16
    MOVK  X29, #0x19c6, LSL #32
    MOVK  X29, #0x5a7a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X29, #0x8503, LSL #0
    MOVK  X29, #0x5a62, LSL #16
    MOVK  X29, #0x8503, LSL #32
    MOVK  X29, #0x5a62, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D23
    MOVZ  X29, #0x8503, LSL #0
    MOVK  X29, #0x5a62, LSL #16
    MOVK  X29, #0x8503, LSL #32
    MOVK  X29, #0x5a62, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X29, #0x1df8, LSL #0
    MOVK  X29, #0x5a7c, LSL #16
    MOVK  X29, #0x1df8, LSL #32
    MOVK  X29, #0x5a7c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D24
    MOVZ  X29, #0x1df8, LSL #0
    MOVK  X29, #0x5a7c, LSL #16
    MOVK  X29, #0x1df8, LSL #32
    MOVK  X29, #0x5a7c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X29, #0xdab7, LSL #0
    MOVK  X29, #0x5a80, LSL #16
    MOVK  X29, #0xdab7, LSL #32
    MOVK  X29, #0x5a80, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D25
    MOVZ  X29, #0xdab7, LSL #0
    MOVK  X29, #0x5a80, LSL #16
    MOVK  X29, #0xdab7, LSL #32
    MOVK  X29, #0x5a80, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X29, #0xd54f, LSL #0
    MOVK  X29, #0x5a83, LSL #16
    MOVK  X29, #0xd54f, LSL #32
    MOVK  X29, #0x5a83, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D26
    MOVZ  X29, #0xd54f, LSL #0
    MOVK  X29, #0x5a83, LSL #16
    MOVK  X29, #0xd54f, LSL #32
    MOVK  X29, #0x5a83, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X29, #0x126f, LSL #0
    MOVK  X29, #0x5a90, LSL #16
    MOVK  X29, #0x126f, LSL #32
    MOVK  X29, #0x5a90, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D27
    MOVZ  X29, #0x126f, LSL #0
    MOVK  X29, #0x5a90, LSL #16
    MOVK  X29, #0x126f, LSL #32
    MOVK  X29, #0x5a90, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X29, #0xde27, LSL #0
    MOVK  X29, #0x5a8b, LSL #16
    MOVK  X29, #0xde27, LSL #32
    MOVK  X29, #0x5a8b, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D28
    MOVZ  X29, #0xde27, LSL #0
    MOVK  X29, #0x5a8b, LSL #16
    MOVK  X29, #0xde27, LSL #32
    MOVK  X29, #0x5a8b, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X29, #0x499a, LSL #0
    MOVK  X29, #0x5a93, LSL #16
    MOVK  X29, #0x499a, LSL #32
    MOVK  X29, #0x5a93, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D29
    MOVZ  X29, #0x499a, LSL #0
    MOVK  X29, #0x5a93, LSL #16
    MOVK  X29, #0x499a, LSL #32
    MOVK  X29, #0x5a93, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X29, #0x446a, LSL #0
    MOVK  X29, #0x5a7c, LSL #16
    MOVK  X29, #0x446a, LSL #32
    MOVK  X29, #0x5a7c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D30
    MOVZ  X29, #0x446a, LSL #0
    MOVK  X29, #0x5a7c, LSL #16
    MOVK  X29, #0x446a, LSL #32
    MOVK  X29, #0x5a7c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X29, #0xed3, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0xed3, LSL #32
    MOVK  X29, #0x5a85, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FMOV  X14, D31
    MOVZ  X29, #0xed3, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0xed3, LSL #32
    MOVK  X29, #0x5a85, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
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
    FMOV  X14, D0
    MOVZ  X29, #0x4862, LSL #0
    MOVK  X29, #0x5a75, LSL #16
    MOVK  X29, #0x4862, LSL #32
    MOVK  X29, #0x5a95, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X14, D1
    MOVZ  X29, #0x5a2d, LSL #0
    MOVK  X29, #0x5a62, LSL #16
    MOVK  X29, #0x5a2d, LSL #32
    MOVK  X29, #0x5a82, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X14, D2
    MOVZ  X29, #0x5ed8, LSL #0
    MOVK  X29, #0x5a83, LSL #16
    MOVK  X29, #0x5ed8, LSL #32
    MOVK  X29, #0x5aa3, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X14, D3
    MOVZ  X29, #0xde6, LSL #0
    MOVK  X29, #0x5a6a, LSL #16
    MOVK  X29, #0xde6, LSL #32
    MOVK  X29, #0x5a8a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X14, D4
    MOVZ  X29, #0x7e7f, LSL #0
    MOVK  X29, #0x5a7a, LSL #16
    MOVK  X29, #0x7e7f, LSL #32
    MOVK  X29, #0x5a9a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X14, D5
    MOVZ  X29, #0x8f18, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0x8f18, LSL #32
    MOVK  X29, #0x5aa5, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P3, Z6.D
    FMOV  X14, D6
    MOVZ  X29, #0x1912, LSL #0
    MOVK  X29, #0x5a74, LSL #16
    MOVK  X29, #0x1912, LSL #32
    MOVK  X29, #0x5a94, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X14, D7
    MOVZ  X29, #0x5b67, LSL #0
    MOVK  X29, #0x5a61, LSL #16
    MOVK  X29, #0x5b67, LSL #32
    MOVK  X29, #0x5a81, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X14, D8
    MOVZ  X29, #0x2335, LSL #0
    MOVK  X29, #0x5a74, LSL #16
    MOVK  X29, #0x2335, LSL #32
    MOVK  X29, #0x5a94, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P5, Z9.D
    FMOV  X14, D9
    MOVZ  X29, #0x6e12, LSL #0
    MOVK  X29, #0x5a6c, LSL #16
    MOVK  X29, #0x6e12, LSL #32
    MOVK  X29, #0x5a8c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X14, D10
    MOVZ  X29, #0x4e70, LSL #0
    MOVK  X29, #0x5a5d, LSL #16
    MOVK  X29, #0x4e70, LSL #32
    MOVK  X29, #0x5a7d, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X14, D11
    MOVZ  X29, #0x5457, LSL #0
    MOVK  X29, #0x5a80, LSL #16
    MOVK  X29, #0x5457, LSL #32
    MOVK  X29, #0x5aa0, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X14, D12
    MOVZ  X29, #0xd643, LSL #0
    MOVK  X29, #0x5a63, LSL #16
    MOVK  X29, #0xd643, LSL #32
    MOVK  X29, #0x5a83, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P0, Z13.D
    FMOV  X14, D13
    MOVZ  X29, #0x6781, LSL #0
    MOVK  X29, #0x5a95, LSL #16
    MOVK  X29, #0x6781, LSL #32
    MOVK  X29, #0x5ab5, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X14, D14
    MOVZ  X29, #0x8718, LSL #0
    MOVK  X29, #0x5ad8, LSL #16
    MOVK  X29, #0x8718, LSL #32
    MOVK  X29, #0x5af8, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X14, D15
    MOVZ  X29, #0x3dbb, LSL #0
    MOVK  X29, #0x5a88, LSL #16
    MOVK  X29, #0x3dbb, LSL #32
    MOVK  X29, #0x5aa8, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X14, D16
    MOVZ  X29, #0x60f4, LSL #0
    MOVK  X29, #0x5a92, LSL #16
    MOVK  X29, #0x60f4, LSL #32
    MOVK  X29, #0x5ab2, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X14, D17
    MOVZ  X29, #0x760, LSL #0
    MOVK  X29, #0x5a89, LSL #16
    MOVK  X29, #0x760, LSL #32
    MOVK  X29, #0x5aa9, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P3, Z18.D
    FMOV  X14, D18
    MOVZ  X29, #0x5694, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0x5694, LSL #32
    MOVK  X29, #0x5aa5, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X14, D19
    MOVZ  X29, #0xc6e5, LSL #0
    MOVK  X29, #0x5a75, LSL #16
    MOVK  X29, #0xc6e5, LSL #32
    MOVK  X29, #0x5a95, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X14, D20
    MOVZ  X29, #0xa1c3, LSL #0
    MOVK  X29, #0x5a73, LSL #16
    MOVK  X29, #0xa1c3, LSL #32
    MOVK  X29, #0x5a93, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X14, D21
    MOVZ  X29, #0xcebe, LSL #0
    MOVK  X29, #0x5a73, LSL #16
    MOVK  X29, #0xcebe, LSL #32
    MOVK  X29, #0x5a93, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X14, D22
    MOVZ  X29, #0x19c6, LSL #0
    MOVK  X29, #0x5a7a, LSL #16
    MOVK  X29, #0x19c6, LSL #32
    MOVK  X29, #0x5a9a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P1, Z23.D
    FMOV  X14, D23
    MOVZ  X29, #0x8503, LSL #0
    MOVK  X29, #0x5a62, LSL #16
    MOVK  X29, #0x8503, LSL #32
    MOVK  X29, #0x5a82, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X14, D24
    MOVZ  X29, #0x1df8, LSL #0
    MOVK  X29, #0x5a7c, LSL #16
    MOVK  X29, #0x1df8, LSL #32
    MOVK  X29, #0x5a9c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X14, D25
    MOVZ  X29, #0xdab7, LSL #0
    MOVK  X29, #0x5a80, LSL #16
    MOVK  X29, #0xdab7, LSL #32
    MOVK  X29, #0x5aa0, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X14, D26
    MOVZ  X29, #0xd54f, LSL #0
    MOVK  X29, #0x5a83, LSL #16
    MOVK  X29, #0xd54f, LSL #32
    MOVK  X29, #0x5aa3, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X14, D27
    MOVZ  X29, #0x126f, LSL #0
    MOVK  X29, #0x5a90, LSL #16
    MOVK  X29, #0x126f, LSL #32
    MOVK  X29, #0x5ab0, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X14, D28
    MOVZ  X29, #0xde27, LSL #0
    MOVK  X29, #0x5a8b, LSL #16
    MOVK  X29, #0xde27, LSL #32
    MOVK  X29, #0x5aab, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X14, D29
    MOVZ  X29, #0x499a, LSL #0
    MOVK  X29, #0x5a93, LSL #16
    MOVK  X29, #0x499a, LSL #32
    MOVK  X29, #0x5ab3, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X14, D30
    MOVZ  X29, #0x446a, LSL #0
    MOVK  X29, #0x5a7c, LSL #16
    MOVK  X29, #0x446a, LSL #32
    MOVK  X29, #0x5a9c, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P6, Z31.D
    FMOV  X14, D31
    MOVZ  X29, #0xed3, LSL #0
    MOVK  X29, #0x5a85, LSL #16
    MOVK  X29, #0xed3, LSL #32
    MOVK  X29, #0x5aa5, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X2
    DUP     Z1.D, X29
    DUP     Z2.D, X21
    DUP     Z3.D, X22
    DUP     Z4.D, X23
    DUP     Z5.D, X2
    DUP     Z6.D, X23
    DUP     Z7.D, X2
    DUP     Z8.D, X17
    DUP     Z9.D, X9
    DUP     Z10.D, X7
    DUP     Z11.D, X20
    DUP     Z12.D, X19
    DUP     Z13.D, X23
    DUP     Z14.D, X4
    DUP     Z15.D, X5
    DUP     Z16.D, X18
    DUP     Z17.D, X3
    DUP     Z18.D, X29
    DUP     Z19.D, X21
    DUP     Z20.D, X7
    DUP     Z21.D, X16
    DUP     Z22.D, X10
    DUP     Z23.D, X20
    DUP     Z24.D, X20
    DUP     Z25.D, X23
    DUP     Z26.D, X15
    DUP     Z27.D, X5
    DUP     Z28.D, X19
    DUP     Z29.D, X12
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
    MOVZ  X11, #0xa, LSL #0
LCRTSveVectorI8MM_label_4:
    USMMLA Z29.S, Z6.B, Z29.B
    USMMLA Z27.S, Z30.B, Z30.B
    USMMLA Z31.S, Z6.B, Z15.B
    USDOT Z29.S, Z1.B, Z4.B[0x3]
    USDOT Z29.S, Z15.B, Z1.B[0x0]
    USDOT Z29.S, Z29.B, Z27.B
    UMMLA Z0.S, Z29.B, Z19.B
    SUDOT Z9.S, Z22.B, Z5.B[0x2]
    SMMLA Z26.S, Z7.B, Z0.B
    UMMLA Z31.S, Z14.B, Z9.B
    SUDOT Z31.S, Z0.B, Z3.B[0x3]
    USDOT Z30.S, Z21.B, Z20.B
    USDOT Z26.S, Z21.B, Z2.B[0x0]
    USMMLA Z26.S, Z26.B, Z30.B
    USDOT Z1.S, Z16.B, Z2.B[0x0]
    USDOT Z0.S, Z10.B, Z1.B[0x1]
    USMMLA Z24.S, Z13.B, Z25.B
    SMMLA Z27.S, Z2.B, Z7.B
    USDOT Z5.S, Z7.B, Z30.B
    USDOT Z21.S, Z23.B, Z3.B[0x3]
    SUDOT Z2.S, Z20.B, Z3.B[0x0]
    USDOT Z21.S, Z30.B, Z0.B[0x1]
    SUDOT Z5.S, Z8.B, Z1.B[0x0]
    USDOT Z19.S, Z19.B, Z3.B[0x2]
    USDOT Z10.S, Z15.B, Z5.B[0x2]
    UMMLA Z21.S, Z13.B, Z8.B
    SUDOT Z19.S, Z28.B, Z3.B[0x1]
    USDOT Z10.S, Z10.B, Z5.B[0x0]
    UMMLA Z31.S, Z6.B, Z7.B
    USDOT Z23.S, Z12.B, Z0.B
    UMMLA Z4.S, Z17.B, Z10.B
    SMMLA Z19.S, Z7.B, Z26.B
    USMMLA Z24.S, Z10.B, Z31.B
    USMMLA Z19.S, Z24.B, Z24.B
    USMMLA Z19.S, Z5.B, Z19.B
    USMMLA Z0.S, Z19.B, Z23.B
    USDOT Z8.S, Z21.B, Z21.B
    USDOT Z2.S, Z4.B, Z4.B
    SUDOT Z2.S, Z8.B, Z7.B[0x1]
    SMMLA Z11.S, Z18.B, Z14.B
    SUDOT Z0.S, Z8.B, Z0.B[0x0]
    SMMLA Z0.S, Z0.B, Z11.B
    UMMLA Z0.S, Z1.B, Z8.B
    USMMLA Z29.S, Z18.B, Z0.B
    USDOT Z27.S, Z17.B, Z4.B[0x2]
    USDOT Z2.S, Z28.B, Z2.B[0x3]
    USMMLA Z29.S, Z29.B, Z2.B
    USDOT Z15.S, Z29.B, Z29.B
    USMMLA Z17.S, Z2.B, Z4.B
    USMMLA Z8.S, Z19.B, Z11.B
    UMMLA Z18.S, Z13.B, Z8.B
    USDOT Z1.S, Z30.B, Z3.B
    UMMLA Z6.S, Z24.B, Z23.B
    USDOT Z27.S, Z17.B, Z31.B
    SMMLA Z1.S, Z31.B, Z13.B
    UMMLA Z7.S, Z20.B, Z5.B
    USMMLA Z27.S, Z5.B, Z21.B
    USDOT Z9.S, Z25.B, Z6.B[0x2]
    USDOT Z20.S, Z18.B, Z9.B
    USMMLA Z16.S, Z20.B, Z1.B
    USDOT Z24.S, Z4.B, Z19.B
    USMMLA Z24.S, Z28.B, Z15.B
    USDOT Z10.S, Z10.B, Z3.B[0x3]
    USDOT Z31.S, Z9.B, Z0.B[0x0]
    SUDOT Z25.S, Z0.B, Z7.B[0x1]
    USDOT Z20.S, Z3.B, Z24.B
    SUDOT Z3.S, Z7.B, Z7.B[0x1]
    USDOT Z18.S, Z8.B, Z0.B[0x3]
    USDOT Z21.S, Z1.B, Z9.B
    USDOT Z25.S, Z25.B, Z4.B[0x0]
    USDOT Z31.S, Z27.B, Z3.B[0x2]
    USMMLA Z2.S, Z17.B, Z27.B
    SUDOT Z20.S, Z18.B, Z0.B[0x2]
    USDOT Z21.S, Z4.B, Z2.B[0x3]
    SUDOT Z21.S, Z16.B, Z5.B[0x1]
    USMMLA Z10.S, Z21.B, Z31.B
    USDOT Z25.S, Z20.B, Z0.B[0x2]
    USMMLA Z28.S, Z13.B, Z3.B
    USDOT Z4.S, Z28.B, Z4.B[0x2]
    SUDOT Z27.S, Z22.B, Z1.B[0x2]
    SUDOT Z3.S, Z4.B, Z5.B[0x3]
    SMMLA Z17.S, Z28.B, Z23.B
    SMMLA Z17.S, Z5.B, Z3.B
    SMMLA Z11.S, Z8.B, Z19.B
    USDOT Z23.S, Z7.B, Z27.B
    USDOT Z3.S, Z2.B, Z2.B[0x2]
    USDOT Z4.S, Z26.B, Z2.B[0x0]
    SMMLA Z8.S, Z3.B, Z22.B
    SUDOT Z16.S, Z14.B, Z6.B[0x3]
    SMMLA Z25.S, Z13.B, Z24.B
    USMMLA Z2.S, Z16.B, Z19.B
    UMMLA Z1.S, Z9.B, Z18.B
    SUDOT Z7.S, Z8.B, Z2.B[0x0]
    SUDOT Z22.S, Z2.B, Z6.B[0x0]
    USMMLA Z23.S, Z1.B, Z17.B
    USMMLA Z31.S, Z25.B, Z24.B
    USMMLA Z22.S, Z22.B, Z31.B
    USDOT Z23.S, Z10.B, Z3.B[0x3]
    SMMLA Z4.S, Z4.B, Z23.B
    UMMLA Z22.S, Z4.B, Z11.B
    SUDOT Z9.S, Z21.B, Z0.B[0x1]
    SUDOT Z7.S, Z11.B, Z4.B[0x2]
    SUDOT Z30.S, Z29.B, Z3.B[0x2]
    USMMLA Z13.S, Z14.B, Z18.B
    SMMLA Z13.S, Z24.B, Z1.B
    USDOT Z8.S, Z6.B, Z24.B
    SUDOT Z19.S, Z19.B, Z7.B[0x1]
    SUDOT Z27.S, Z9.B, Z4.B[0x1]
    SMMLA Z5.S, Z30.B, Z12.B
    SMMLA Z3.S, Z7.B, Z21.B
    SUDOT Z15.S, Z20.B, Z5.B[0x1]
    UMMLA Z4.S, Z12.B, Z22.B
    SMMLA Z1.S, Z19.B, Z26.B
    USMMLA Z29.S, Z3.B, Z2.B
    SUDOT Z10.S, Z24.B, Z2.B[0x1]
    SMMLA Z17.S, Z9.B, Z19.B
    USMMLA Z8.S, Z15.B, Z27.B
    USMMLA Z8.S, Z23.B, Z1.B
    USMMLA Z8.S, Z13.B, Z17.B
    USDOT Z10.S, Z14.B, Z16.B
    USMMLA Z4.S, Z29.B, Z14.B
    USMMLA Z10.S, Z8.B, Z17.B
    SUDOT Z23.S, Z25.B, Z3.B[0x1]
    SUDOT Z31.S, Z11.B, Z6.B[0x1]
    USDOT Z15.S, Z24.B, Z4.B[0x1]
    USMMLA Z31.S, Z12.B, Z29.B
    SMMLA Z28.S, Z26.B, Z8.B
    USDOT Z10.S, Z13.B, Z25.B
    USMMLA Z30.S, Z22.B, Z13.B
    USDOT Z9.S, Z30.B, Z3.B[0x0]
    SUDOT Z23.S, Z18.B, Z0.B[0x3]
    USDOT Z25.S, Z15.B, Z1.B[0x3]
    USMMLA Z19.S, Z25.B, Z2.B
    UMMLA Z23.S, Z25.B, Z30.B
    UMMLA Z0.S, Z9.B, Z7.B
    SUDOT Z13.S, Z29.B, Z7.B[0x0]
    SMMLA Z14.S, Z15.B, Z10.B
    SUDOT Z3.S, Z10.B, Z7.B[0x1]
    SUDOT Z21.S, Z6.B, Z1.B[0x2]
    USMMLA Z26.S, Z26.B, Z28.B
    SUDOT Z17.S, Z14.B, Z5.B[0x0]
    SUDOT Z3.S, Z31.B, Z0.B[0x3]
    USDOT Z22.S, Z26.B, Z0.B[0x0]
    SMMLA Z28.S, Z13.B, Z22.B
    UMMLA Z17.S, Z23.B, Z21.B
    USMMLA Z17.S, Z10.B, Z22.B
    UMMLA Z17.S, Z17.B, Z11.B
    UMMLA Z11.S, Z27.B, Z21.B
    SMMLA Z11.S, Z17.B, Z14.B
    SMMLA Z28.S, Z19.B, Z3.B
    USMMLA Z6.S, Z4.B, Z3.B
    SUDOT Z23.S, Z7.B, Z3.B[0x1]
    SUDOT Z4.S, Z19.B, Z4.B[0x1]
    SUDOT Z22.S, Z29.B, Z7.B[0x1]
    SUDOT Z20.S, Z17.B, Z2.B[0x3]
    USDOT Z1.S, Z0.B, Z26.B
    UMMLA Z25.S, Z30.B, Z23.B
    UMMLA Z18.S, Z17.B, Z23.B
    USDOT Z20.S, Z20.B, Z29.B
    SMMLA Z7.S, Z28.B, Z11.B
    SUDOT Z1.S, Z20.B, Z7.B[0x3]
    USDOT Z1.S, Z22.B, Z6.B
    USDOT Z4.S, Z11.B, Z4.B[0x1]
    SMMLA Z3.S, Z4.B, Z18.B
    UMMLA Z25.S, Z25.B, Z15.B
    UMMLA Z25.S, Z25.B, Z1.B
    USDOT Z12.S, Z17.B, Z2.B[0x1]
    USDOT Z22.S, Z31.B, Z5.B[0x0]
    SUDOT Z27.S, Z28.B, Z1.B[0x3]
    USDOT Z31.S, Z15.B, Z7.B[0x0]
    SMMLA Z30.S, Z24.B, Z27.B
    UMMLA Z17.S, Z6.B, Z6.B
    UMMLA Z9.S, Z29.B, Z10.B
    USMMLA Z22.S, Z17.B, Z10.B
    UMMLA Z28.S, Z16.B, Z14.B
    USMMLA Z2.S, Z18.B, Z4.B
    SMMLA Z31.S, Z28.B, Z22.B
    SUDOT Z4.S, Z20.B, Z3.B[0x0]
    USDOT Z14.S, Z3.B, Z2.B[0x1]
    USDOT Z25.S, Z2.B, Z4.B[0x3]
    USDOT Z25.S, Z1.B, Z6.B[0x1]
    SMMLA Z31.S, Z5.B, Z25.B
    USDOT Z3.S, Z9.B, Z18.B
    UMMLA Z30.S, Z14.B, Z14.B
    USMMLA Z16.S, Z28.B, Z15.B
    SMMLA Z16.S, Z3.B, Z3.B
    SUDOT Z12.S, Z31.B, Z1.B[0x0]
    USDOT Z28.S, Z12.B, Z4.B
    USDOT Z7.S, Z28.B, Z3.B
    USDOT Z10.S, Z7.B, Z2.B[0x3]
    USDOT Z31.S, Z10.B, Z7.B[0x2]
    SUDOT Z30.S, Z31.B, Z1.B[0x1]
    USDOT Z29.S, Z3.B, Z1.B
    USDOT Z19.S, Z29.B, Z2.B[0x1]
    UMMLA Z7.S, Z31.B, Z1.B
    SUDOT Z2.S, Z4.B, Z1.B[0x1]
    SUDOT Z11.S, Z24.B, Z0.B[0x0]
    USMMLA Z17.S, Z7.B, Z29.B
    USMMLA Z24.S, Z27.B, Z18.B
    USDOT Z30.S, Z31.B, Z4.B[0x0]
    SUBS  X11, X11, #0x1
    B.NE  LCRTSveVectorI8MM_label_4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTSveVectorI8MM_TestFail
    MRS  X29, FPSR
    MOVZ  X18, #0x80, LSL #0
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X18, #0x6bce, LSL #0
    MOVK  X18, #0xa5e8, LSL #16
    MOVK  X18, #0x6bce, LSL #32
    MOVK  X18, #0xa5e8, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D0
    MOVZ  X18, #0x6bce, LSL #0
    MOVK  X18, #0xa5e8, LSL #16
    MOVK  X18, #0x6bce, LSL #32
    MOVK  X18, #0xa5e8, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X18, #0xd15, LSL #0
    MOVK  X18, #0xa5b5, LSL #16
    MOVK  X18, #0xd15, LSL #32
    MOVK  X18, #0xa5b5, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D1
    MOVZ  X18, #0xd15, LSL #0
    MOVK  X18, #0xa5b5, LSL #16
    MOVK  X18, #0xd15, LSL #32
    MOVK  X18, #0xa5b5, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X18, #0xb0da, LSL #0
    MOVK  X18, #0xa56d, LSL #16
    MOVK  X18, #0xb0da, LSL #32
    MOVK  X18, #0xa56d, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D2
    MOVZ  X18, #0xb0da, LSL #0
    MOVK  X18, #0xa56d, LSL #16
    MOVK  X18, #0xb0da, LSL #32
    MOVK  X18, #0xa56d, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X18, #0x5a28, LSL #0
    MOVK  X18, #0xa592, LSL #16
    MOVK  X18, #0x5a28, LSL #32
    MOVK  X18, #0xa592, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D3
    MOVZ  X18, #0x5a28, LSL #0
    MOVK  X18, #0xa592, LSL #16
    MOVK  X18, #0x5a28, LSL #32
    MOVK  X18, #0xa592, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X18, #0xb929, LSL #0
    MOVK  X18, #0xa5c0, LSL #16
    MOVK  X18, #0xb929, LSL #32
    MOVK  X18, #0xa5c0, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D4
    MOVZ  X18, #0xb929, LSL #0
    MOVK  X18, #0xa5c0, LSL #16
    MOVK  X18, #0xb929, LSL #32
    MOVK  X18, #0xa5c0, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X18, #0xcc68, LSL #0
    MOVK  X18, #0xa59f, LSL #16
    MOVK  X18, #0xcc68, LSL #32
    MOVK  X18, #0xa59f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D5
    MOVZ  X18, #0xcc68, LSL #0
    MOVK  X18, #0xa59f, LSL #16
    MOVK  X18, #0xcc68, LSL #32
    MOVK  X18, #0xa59f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X18, #0xccb7, LSL #0
    MOVK  X18, #0xa5b3, LSL #16
    MOVK  X18, #0xccb7, LSL #32
    MOVK  X18, #0xa5b3, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D6
    MOVZ  X18, #0xccb7, LSL #0
    MOVK  X18, #0xa5b3, LSL #16
    MOVK  X18, #0xccb7, LSL #32
    MOVK  X18, #0xa5b3, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X18, #0x2ab0, LSL #0
    MOVK  X18, #0xa5cf, LSL #16
    MOVK  X18, #0x2ab0, LSL #32
    MOVK  X18, #0xa5cf, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D7
    MOVZ  X18, #0x2ab0, LSL #0
    MOVK  X18, #0xa5cf, LSL #16
    MOVK  X18, #0x2ab0, LSL #32
    MOVK  X18, #0xa5cf, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X18, #0x4028, LSL #0
    MOVK  X18, #0xa582, LSL #16
    MOVK  X18, #0x4028, LSL #32
    MOVK  X18, #0xa582, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D8
    MOVZ  X18, #0x4028, LSL #0
    MOVK  X18, #0xa582, LSL #16
    MOVK  X18, #0x4028, LSL #32
    MOVK  X18, #0xa582, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X18, #0xb46c, LSL #0
    MOVK  X18, #0xa5a8, LSL #16
    MOVK  X18, #0xb46c, LSL #32
    MOVK  X18, #0xa5a8, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D9
    MOVZ  X18, #0xb46c, LSL #0
    MOVK  X18, #0xa5a8, LSL #16
    MOVK  X18, #0xb46c, LSL #32
    MOVK  X18, #0xa5a8, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X18, #0x245c, LSL #0
    MOVK  X18, #0xa578, LSL #16
    MOVK  X18, #0x245c, LSL #32
    MOVK  X18, #0xa578, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D10
    MOVZ  X18, #0x245c, LSL #0
    MOVK  X18, #0xa578, LSL #16
    MOVK  X18, #0x245c, LSL #32
    MOVK  X18, #0xa578, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X18, #0xac4b, LSL #0
    MOVK  X18, #0xa5c1, LSL #16
    MOVK  X18, #0xac4b, LSL #32
    MOVK  X18, #0xa5c1, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D11
    MOVZ  X18, #0xac4b, LSL #0
    MOVK  X18, #0xa5c1, LSL #16
    MOVK  X18, #0xac4b, LSL #32
    MOVK  X18, #0xa5c1, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X18, #0xf25, LSL #0
    MOVK  X18, #0xa59e, LSL #16
    MOVK  X18, #0xf25, LSL #32
    MOVK  X18, #0xa59e, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D12
    MOVZ  X18, #0xf25, LSL #0
    MOVK  X18, #0xa59e, LSL #16
    MOVK  X18, #0xf25, LSL #32
    MOVK  X18, #0xa59e, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X18, #0xa0d4, LSL #0
    MOVK  X18, #0xa59f, LSL #16
    MOVK  X18, #0xa0d4, LSL #32
    MOVK  X18, #0xa59f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D13
    MOVZ  X18, #0xa0d4, LSL #0
    MOVK  X18, #0xa59f, LSL #16
    MOVK  X18, #0xa0d4, LSL #32
    MOVK  X18, #0xa59f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X18, #0x84bb, LSL #0
    MOVK  X18, #0xa5a6, LSL #16
    MOVK  X18, #0x84bb, LSL #32
    MOVK  X18, #0xa5a6, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D14
    MOVZ  X18, #0x84bb, LSL #0
    MOVK  X18, #0xa5a6, LSL #16
    MOVK  X18, #0x84bb, LSL #32
    MOVK  X18, #0xa5a6, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X18, #0x27b, LSL #0
    MOVK  X18, #0xa59a, LSL #16
    MOVK  X18, #0x27b, LSL #32
    MOVK  X18, #0xa59a, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D15
    MOVZ  X18, #0x27b, LSL #0
    MOVK  X18, #0xa59a, LSL #16
    MOVK  X18, #0x27b, LSL #32
    MOVK  X18, #0xa59a, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X18, #0xa207, LSL #0
    MOVK  X18, #0xa597, LSL #16
    MOVK  X18, #0xa207, LSL #32
    MOVK  X18, #0xa597, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D16
    MOVZ  X18, #0xa207, LSL #0
    MOVK  X18, #0xa597, LSL #16
    MOVK  X18, #0xa207, LSL #32
    MOVK  X18, #0xa597, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X18, #0x5aaa, LSL #0
    MOVK  X18, #0xa5ea, LSL #16
    MOVK  X18, #0x5aaa, LSL #32
    MOVK  X18, #0xa5ea, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D17
    MOVZ  X18, #0x5aaa, LSL #0
    MOVK  X18, #0xa5ea, LSL #16
    MOVK  X18, #0x5aaa, LSL #32
    MOVK  X18, #0xa5ea, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X18, #0xc604, LSL #0
    MOVK  X18, #0xa5d4, LSL #16
    MOVK  X18, #0xc604, LSL #32
    MOVK  X18, #0xa5d4, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D18
    MOVZ  X18, #0xc604, LSL #0
    MOVK  X18, #0xa5d4, LSL #16
    MOVK  X18, #0xc604, LSL #32
    MOVK  X18, #0xa5d4, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X18, #0xc3f5, LSL #0
    MOVK  X18, #0xa57d, LSL #16
    MOVK  X18, #0xc3f5, LSL #32
    MOVK  X18, #0xa57d, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D19
    MOVZ  X18, #0xc3f5, LSL #0
    MOVK  X18, #0xa57d, LSL #16
    MOVK  X18, #0xc3f5, LSL #32
    MOVK  X18, #0xa57d, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X18, #0xeb2f, LSL #0
    MOVK  X18, #0xa58f, LSL #16
    MOVK  X18, #0xeb2f, LSL #32
    MOVK  X18, #0xa58f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D20
    MOVZ  X18, #0xeb2f, LSL #0
    MOVK  X18, #0xa58f, LSL #16
    MOVK  X18, #0xeb2f, LSL #32
    MOVK  X18, #0xa58f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X18, #0xc2e, LSL #0
    MOVK  X18, #0xa5a2, LSL #16
    MOVK  X18, #0xc2e, LSL #32
    MOVK  X18, #0xa5a2, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D21
    MOVZ  X18, #0xc2e, LSL #0
    MOVK  X18, #0xa5a2, LSL #16
    MOVK  X18, #0xc2e, LSL #32
    MOVK  X18, #0xa5a2, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X18, #0x6623, LSL #0
    MOVK  X18, #0xa5a4, LSL #16
    MOVK  X18, #0x6623, LSL #32
    MOVK  X18, #0xa5a4, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D22
    MOVZ  X18, #0x6623, LSL #0
    MOVK  X18, #0xa5a4, LSL #16
    MOVK  X18, #0x6623, LSL #32
    MOVK  X18, #0xa5a4, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X18, #0x45c7, LSL #0
    MOVK  X18, #0xa59e, LSL #16
    MOVK  X18, #0x45c7, LSL #32
    MOVK  X18, #0xa59e, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D23
    MOVZ  X18, #0x45c7, LSL #0
    MOVK  X18, #0xa59e, LSL #16
    MOVK  X18, #0x45c7, LSL #32
    MOVK  X18, #0xa59e, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X18, #0x7547, LSL #0
    MOVK  X18, #0xa57f, LSL #16
    MOVK  X18, #0x7547, LSL #32
    MOVK  X18, #0xa57f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D24
    MOVZ  X18, #0x7547, LSL #0
    MOVK  X18, #0xa57f, LSL #16
    MOVK  X18, #0x7547, LSL #32
    MOVK  X18, #0xa57f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X18, #0x9984, LSL #0
    MOVK  X18, #0xa5df, LSL #16
    MOVK  X18, #0x9984, LSL #32
    MOVK  X18, #0xa5df, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D25
    MOVZ  X18, #0x9984, LSL #0
    MOVK  X18, #0xa5df, LSL #16
    MOVK  X18, #0x9984, LSL #32
    MOVK  X18, #0xa5df, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X18, #0x9e78, LSL #0
    MOVK  X18, #0xa592, LSL #16
    MOVK  X18, #0x9e78, LSL #32
    MOVK  X18, #0xa592, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D26
    MOVZ  X18, #0x9e78, LSL #0
    MOVK  X18, #0xa592, LSL #16
    MOVK  X18, #0x9e78, LSL #32
    MOVK  X18, #0xa592, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X18, #0x8a0d, LSL #0
    MOVK  X18, #0xa57f, LSL #16
    MOVK  X18, #0x8a0d, LSL #32
    MOVK  X18, #0xa57f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D27
    MOVZ  X18, #0x8a0d, LSL #0
    MOVK  X18, #0xa57f, LSL #16
    MOVK  X18, #0x8a0d, LSL #32
    MOVK  X18, #0xa57f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X18, #0x2247, LSL #0
    MOVK  X18, #0xa5c0, LSL #16
    MOVK  X18, #0x2247, LSL #32
    MOVK  X18, #0xa5c0, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D28
    MOVZ  X18, #0x2247, LSL #0
    MOVK  X18, #0xa5c0, LSL #16
    MOVK  X18, #0x2247, LSL #32
    MOVK  X18, #0xa5c0, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X18, #0xa95c, LSL #0
    MOVK  X18, #0xa577, LSL #16
    MOVK  X18, #0xa95c, LSL #32
    MOVK  X18, #0xa577, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D29
    MOVZ  X18, #0xa95c, LSL #0
    MOVK  X18, #0xa577, LSL #16
    MOVK  X18, #0xa95c, LSL #32
    MOVK  X18, #0xa577, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X18, #0x7639, LSL #0
    MOVK  X18, #0xa5ac, LSL #16
    MOVK  X18, #0x7639, LSL #32
    MOVK  X18, #0xa5ac, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D30
    MOVZ  X18, #0x7639, LSL #0
    MOVK  X18, #0xa5ac, LSL #16
    MOVK  X18, #0x7639, LSL #32
    MOVK  X18, #0xa5ac, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X18, #0xf74d, LSL #0
    MOVK  X18, #0xa5ac, LSL #16
    MOVK  X18, #0xf74d, LSL #32
    MOVK  X18, #0xa5ac, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FMOV  X29, D31
    MOVZ  X18, #0xf74d, LSL #0
    MOVK  X18, #0xa5ac, LSL #16
    MOVK  X18, #0xf74d, LSL #32
    MOVK  X18, #0xa5ac, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X29, #0x0, LSL #0
    STR  X29, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X29, [X0, #0]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
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
    FMOV  X29, D0
    MOVZ  X18, #0x6bce, LSL #0
    MOVK  X18, #0xa5e8, LSL #16
    MOVK  X18, #0x6bce, LSL #32
    MOVK  X18, #0xa608, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X29, D1
    MOVZ  X18, #0xd15, LSL #0
    MOVK  X18, #0xa5b5, LSL #16
    MOVK  X18, #0xd15, LSL #32
    MOVK  X18, #0xa5d5, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X29, D2
    MOVZ  X18, #0xb0da, LSL #0
    MOVK  X18, #0xa56d, LSL #16
    MOVK  X18, #0xb0da, LSL #32
    MOVK  X18, #0xa58d, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P3, Z3.D
    FMOV  X29, D3
    MOVZ  X18, #0x5a28, LSL #0
    MOVK  X18, #0xa592, LSL #16
    MOVK  X18, #0x5a28, LSL #32
    MOVK  X18, #0xa5b2, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P5, Z4.D
    FMOV  X29, D4
    MOVZ  X18, #0xb929, LSL #0
    MOVK  X18, #0xa5c0, LSL #16
    MOVK  X18, #0xb929, LSL #32
    MOVK  X18, #0xa5e0, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X29, D5
    MOVZ  X18, #0xcc68, LSL #0
    MOVK  X18, #0xa59f, LSL #16
    MOVK  X18, #0xcc68, LSL #32
    MOVK  X18, #0xa5bf, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X29, D6
    MOVZ  X18, #0xccb7, LSL #0
    MOVK  X18, #0xa5b3, LSL #16
    MOVK  X18, #0xccb7, LSL #32
    MOVK  X18, #0xa5d3, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X29, D7
    MOVZ  X18, #0x2ab0, LSL #0
    MOVK  X18, #0xa5cf, LSL #16
    MOVK  X18, #0x2ab0, LSL #32
    MOVK  X18, #0xa5ef, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X29, D8
    MOVZ  X18, #0x4028, LSL #0
    MOVK  X18, #0xa582, LSL #16
    MOVK  X18, #0x4028, LSL #32
    MOVK  X18, #0xa5a2, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P5, Z9.D
    FMOV  X29, D9
    MOVZ  X18, #0xb46c, LSL #0
    MOVK  X18, #0xa5a8, LSL #16
    MOVK  X18, #0xb46c, LSL #32
    MOVK  X18, #0xa5c8, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X29, D10
    MOVZ  X18, #0x245c, LSL #0
    MOVK  X18, #0xa578, LSL #16
    MOVK  X18, #0x245c, LSL #32
    MOVK  X18, #0xa598, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X29, D11
    MOVZ  X18, #0xac4b, LSL #0
    MOVK  X18, #0xa5c1, LSL #16
    MOVK  X18, #0xac4b, LSL #32
    MOVK  X18, #0xa5e1, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X29, D12
    MOVZ  X18, #0xf25, LSL #0
    MOVK  X18, #0xa59e, LSL #16
    MOVK  X18, #0xf25, LSL #32
    MOVK  X18, #0xa5be, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X29, D13
    MOVZ  X18, #0xa0d4, LSL #0
    MOVK  X18, #0xa59f, LSL #16
    MOVK  X18, #0xa0d4, LSL #32
    MOVK  X18, #0xa5bf, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P7, Z14.D
    FMOV  X29, D14
    MOVZ  X18, #0x84bb, LSL #0
    MOVK  X18, #0xa5a6, LSL #16
    MOVK  X18, #0x84bb, LSL #32
    MOVK  X18, #0xa5c6, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X29, D15
    MOVZ  X18, #0x27b, LSL #0
    MOVK  X18, #0xa59a, LSL #16
    MOVK  X18, #0x27b, LSL #32
    MOVK  X18, #0xa5ba, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X29, D16
    MOVZ  X18, #0xa207, LSL #0
    MOVK  X18, #0xa597, LSL #16
    MOVK  X18, #0xa207, LSL #32
    MOVK  X18, #0xa5b7, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P1, Z17.D
    FMOV  X29, D17
    MOVZ  X18, #0x5aaa, LSL #0
    MOVK  X18, #0xa5ea, LSL #16
    MOVK  X18, #0x5aaa, LSL #32
    MOVK  X18, #0xa60a, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X29, D18
    MOVZ  X18, #0xc604, LSL #0
    MOVK  X18, #0xa5d4, LSL #16
    MOVK  X18, #0xc604, LSL #32
    MOVK  X18, #0xa5f4, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X29, D19
    MOVZ  X18, #0xc3f5, LSL #0
    MOVK  X18, #0xa57d, LSL #16
    MOVK  X18, #0xc3f5, LSL #32
    MOVK  X18, #0xa59d, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X29, D20
    MOVZ  X18, #0xeb2f, LSL #0
    MOVK  X18, #0xa58f, LSL #16
    MOVK  X18, #0xeb2f, LSL #32
    MOVK  X18, #0xa5af, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X29, D21
    MOVZ  X18, #0xc2e, LSL #0
    MOVK  X18, #0xa5a2, LSL #16
    MOVK  X18, #0xc2e, LSL #32
    MOVK  X18, #0xa5c2, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X29, D22
    MOVZ  X18, #0x6623, LSL #0
    MOVK  X18, #0xa5a4, LSL #16
    MOVK  X18, #0x6623, LSL #32
    MOVK  X18, #0xa5c4, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X29, D23
    MOVZ  X18, #0x45c7, LSL #0
    MOVK  X18, #0xa59e, LSL #16
    MOVK  X18, #0x45c7, LSL #32
    MOVK  X18, #0xa5be, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X29, D24
    MOVZ  X18, #0x7547, LSL #0
    MOVK  X18, #0xa57f, LSL #16
    MOVK  X18, #0x7547, LSL #32
    MOVK  X18, #0xa59f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X29, D25
    MOVZ  X18, #0x9984, LSL #0
    MOVK  X18, #0xa5df, LSL #16
    MOVK  X18, #0x9984, LSL #32
    MOVK  X18, #0xa5ff, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X29, D26
    MOVZ  X18, #0x9e78, LSL #0
    MOVK  X18, #0xa592, LSL #16
    MOVK  X18, #0x9e78, LSL #32
    MOVK  X18, #0xa5b2, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X29, D27
    MOVZ  X18, #0x8a0d, LSL #0
    MOVK  X18, #0xa57f, LSL #16
    MOVK  X18, #0x8a0d, LSL #32
    MOVK  X18, #0xa59f, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X29, D28
    MOVZ  X18, #0x2247, LSL #0
    MOVK  X18, #0xa5c0, LSL #16
    MOVK  X18, #0x2247, LSL #32
    MOVK  X18, #0xa5e0, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X29, D29
    MOVZ  X18, #0xa95c, LSL #0
    MOVK  X18, #0xa577, LSL #16
    MOVK  X18, #0xa95c, LSL #32
    MOVK  X18, #0xa597, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X29, D30
    MOVZ  X18, #0x7639, LSL #0
    MOVK  X18, #0xa5ac, LSL #16
    MOVK  X18, #0x7639, LSL #32
    MOVK  X18, #0xa5cc, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X29, D31
    MOVZ  X18, #0xf74d, LSL #0
    MOVK  X18, #0xa5ac, LSL #16
    MOVK  X18, #0xf74d, LSL #32
    MOVK  X18, #0xa5cc, LSL #48
    SUB  X17, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0xe42a, LSL #0
    MOVK  X2, #0xc7ba, LSL #16
    MOVK  X2, #0x4305, LSL #32
    MOVK  X2, #0x173f, LSL #48
    MOVZ  X3, #0x60c0, LSL #0
    MOVK  X3, #0x1514, LSL #16
    MOVK  X3, #0x1de3, LSL #32
    MOVK  X3, #0xcb2b, LSL #48
    MOVZ  X4, #0xcfb4, LSL #0
    MOVK  X4, #0xe666, LSL #16
    MOVK  X4, #0x653c, LSL #32
    MOVK  X4, #0x734a, LSL #48
    MOVZ  X5, #0x8054, LSL #0
    MOVK  X5, #0x5266, LSL #16
    MOVK  X5, #0x4398, LSL #32
    MOVK  X5, #0x1c93, LSL #48
    MOVZ  X6, #0x7ffc, LSL #0
    MOVK  X6, #0x3c7b, LSL #16
    MOVK  X6, #0xe21a, LSL #32
    MOVK  X6, #0x4289, LSL #48
    MOVZ  X7, #0xf438, LSL #0
    MOVK  X7, #0x234, LSL #16
    MOVK  X7, #0x8445, LSL #32
    MOVK  X7, #0x3a5a, LSL #48
    MOVZ  X8, #0x7b04, LSL #0
    MOVK  X8, #0xab53, LSL #16
    MOVK  X8, #0x4f15, LSL #32
    MOVK  X8, #0x928c, LSL #48
    MOVZ  X9, #0x9b93, LSL #0
    MOVK  X9, #0x4fb, LSL #16
    MOVK  X9, #0x25fc, LSL #32
    MOVK  X9, #0xeddd, LSL #48
    MOVZ  X10, #0x5ae6, LSL #0
    MOVK  X10, #0x4b8a, LSL #16
    MOVK  X10, #0x8457, LSL #32
    MOVK  X10, #0x58a4, LSL #48
    MOVZ  X11, #0xcb87, LSL #0
    MOVK  X11, #0xd82, LSL #16
    MOVK  X11, #0x95bf, LSL #32
    MOVK  X11, #0x8484, LSL #48
    MOVZ  X12, #0x9ad2, LSL #0
    MOVK  X12, #0x1430, LSL #16
    MOVK  X12, #0xfbfe, LSL #32
    MOVK  X12, #0xeeff, LSL #48
    MOVZ  X13, #0x3306, LSL #0
    MOVK  X13, #0x6f48, LSL #16
    MOVK  X13, #0xb990, LSL #32
    MOVK  X13, #0x22f6, LSL #48
    MOVZ  X14, #0x1b3f, LSL #0
    MOVK  X14, #0xbc1a, LSL #16
    MOVK  X14, #0x5e85, LSL #32
    MOVK  X14, #0x6e7a, LSL #48
    MOVZ  X15, #0x4f91, LSL #0
    MOVK  X15, #0x6e51, LSL #16
    MOVK  X15, #0x39d, LSL #32
    MOVK  X15, #0x7bb6, LSL #48
    MOVZ  X16, #0x74a3, LSL #0
    MOVK  X16, #0x8ae0, LSL #16
    MOVK  X16, #0xd628, LSL #32
    MOVK  X16, #0xd0c2, LSL #48
    MOVZ  X17, #0xd7d3, LSL #0
    MOVK  X17, #0x9174, LSL #16
    MOVK  X17, #0x3b76, LSL #32
    MOVK  X17, #0x3f26, LSL #48
    MOVZ  X18, #0xd551, LSL #0
    MOVK  X18, #0xfd9a, LSL #16
    MOVK  X18, #0x8b07, LSL #32
    MOVK  X18, #0x98fa, LSL #48
    MOVZ  X19, #0x4167, LSL #0
    MOVK  X19, #0x4e07, LSL #16
    MOVK  X19, #0xd0a0, LSL #32
    MOVK  X19, #0x1ae5, LSL #48
    MOVZ  X20, #0x2233, LSL #0
    MOVK  X20, #0x5bdc, LSL #16
    MOVK  X20, #0xe10d, LSL #32
    MOVK  X20, #0x5ed3, LSL #48
    MOVZ  X21, #0xf7fb, LSL #0
    MOVK  X21, #0x6352, LSL #16
    MOVK  X21, #0xa3a1, LSL #32
    MOVK  X21, #0x7fb1, LSL #48
    MOVZ  X22, #0x533e, LSL #0
    MOVK  X22, #0x6611, LSL #16
    MOVK  X22, #0xbbd2, LSL #32
    MOVK  X22, #0xd45e, LSL #48
    MOVZ  X23, #0x4bee, LSL #0
    MOVK  X23, #0xe62, LSL #16
    MOVK  X23, #0xead8, LSL #32
    MOVK  X23, #0x1ccc, LSL #48
    MOVZ  X29, #0xa275, LSL #0
    MOVK  X29, #0xd32d, LSL #16
    MOVK  X29, #0xf56c, LSL #32
    MOVK  X29, #0x58e1, LSL #48
    DUP     Z0.D, X23
    DUP     Z1.D, X22
    DUP     Z2.D, X2
    DUP     Z3.D, X19
    DUP     Z4.D, X13
    DUP     Z5.D, X29
    DUP     Z6.D, X21
    DUP     Z7.D, X18
    DUP     Z8.D, X12
    DUP     Z9.D, X12
    DUP     Z10.D, X5
    DUP     Z11.D, X12
    DUP     Z12.D, X16
    DUP     Z13.D, X11
    DUP     Z14.D, X5
    DUP     Z15.D, X19
    DUP     Z16.D, X29
    DUP     Z17.D, X14
    DUP     Z18.D, X10
    DUP     Z19.D, X18
    DUP     Z20.D, X4
    DUP     Z21.D, X13
    DUP     Z22.D, X21
    DUP     Z23.D, X21
    DUP     Z24.D, X3
    DUP     Z25.D, X12
    DUP     Z26.D, X20
    DUP     Z27.D, X7
    DUP     Z28.D, X7
    DUP     Z29.D, X9
    DUP     Z30.D, X22
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
    MOVZ  X3, #0xa, LSL #0
LCRTSveVectorI8MM_label_5:
    SUDOT Z14.S, Z30.B, Z2.B[0x3]
    SMMLA Z31.S, Z16.B, Z31.B
    USDOT Z9.S, Z26.B, Z6.B[0x3]
    SUDOT Z29.S, Z31.B, Z2.B[0x1]
    USMMLA Z14.S, Z31.B, Z9.B
    USDOT Z14.S, Z18.B, Z3.B[0x0]
    SMMLA Z29.S, Z7.B, Z29.B
    SUDOT Z28.S, Z28.B, Z1.B[0x2]
    UMMLA Z28.S, Z6.B, Z27.B
    SUDOT Z15.S, Z14.B, Z6.B[0x1]
    USMMLA Z5.S, Z16.B, Z27.B
    USMMLA Z15.S, Z4.B, Z10.B
    SMMLA Z5.S, Z5.B, Z15.B
    SMMLA Z11.S, Z29.B, Z29.B
    SUDOT Z20.S, Z23.B, Z0.B[0x2]
    SUDOT Z28.S, Z28.B, Z5.B[0x3]
    USMMLA Z28.S, Z11.B, Z11.B
    SUDOT Z23.S, Z0.B, Z3.B[0x3]
    SUDOT Z4.S, Z24.B, Z4.B[0x0]
    UMMLA Z23.S, Z27.B, Z3.B
    USMMLA Z26.S, Z27.B, Z10.B
    UMMLA Z3.S, Z18.B, Z1.B
    USDOT Z2.S, Z12.B, Z5.B
    SUDOT Z12.S, Z19.B, Z6.B[0x1]
    USDOT Z28.S, Z28.B, Z25.B
    USDOT Z24.S, Z25.B, Z4.B[0x2]
    SUDOT Z23.S, Z12.B, Z1.B[0x0]
    USDOT Z27.S, Z10.B, Z21.B
    SMMLA Z23.S, Z0.B, Z9.B
    USDOT Z3.S, Z17.B, Z6.B[0x1]
    UMMLA Z19.S, Z5.B, Z8.B
    USDOT Z3.S, Z19.B, Z26.B
    USDOT Z20.S, Z28.B, Z2.B
    SMMLA Z30.S, Z20.B, Z28.B
    UMMLA Z30.S, Z27.B, Z30.B
    USMMLA Z30.S, Z17.B, Z25.B
    UMMLA Z23.S, Z23.B, Z30.B
    USMMLA Z16.S, Z19.B, Z0.B
    USMMLA Z3.S, Z3.B, Z4.B
    USMMLA Z24.S, Z14.B, Z3.B
    SUDOT Z7.S, Z7.B, Z6.B[0x2]
    UMMLA Z16.S, Z24.B, Z23.B
    USDOT Z17.S, Z25.B, Z4.B[0x0]
    SMMLA Z5.S, Z7.B, Z7.B
    USDOT Z31.S, Z15.B, Z6.B[0x3]
    USDOT Z20.S, Z13.B, Z0.B[0x2]
    UMMLA Z12.S, Z0.B, Z0.B
    SMMLA Z3.S, Z29.B, Z27.B
    USMMLA Z29.S, Z27.B, Z19.B
    UMMLA Z10.S, Z13.B, Z5.B
    SMMLA Z28.S, Z19.B, Z29.B
    USDOT Z31.S, Z4.B, Z6.B[0x1]
    USMMLA Z9.S, Z29.B, Z31.B
    USMMLA Z14.S, Z31.B, Z10.B
    USDOT Z23.S, Z3.B, Z3.B[0x3]
    USDOT Z10.S, Z25.B, Z25.B
    USMMLA Z29.S, Z15.B, Z12.B
    UMMLA Z29.S, Z23.B, Z28.B
    USMMLA Z29.S, Z20.B, Z29.B
    USDOT Z16.S, Z29.B, Z7.B[0x2]
    UMMLA Z16.S, Z14.B, Z10.B
    USDOT Z15.S, Z9.B, Z9.B
    UMMLA Z15.S, Z4.B, Z15.B
    UMMLA Z15.S, Z15.B, Z19.B
    USDOT Z10.S, Z31.B, Z5.B[0x1]
    USDOT Z16.S, Z28.B, Z4.B
    USDOT Z26.S, Z10.B, Z0.B[0x3]
    SUDOT Z17.S, Z16.B, Z4.B[0x2]
    USDOT Z0.S, Z15.B, Z3.B[0x0]
    USDOT Z0.S, Z3.B, Z31.B
    USDOT Z10.S, Z26.B, Z2.B[0x1]
    USDOT Z27.S, Z0.B, Z23.B
    USDOT Z14.S, Z6.B, Z5.B[0x2]
    SMMLA Z14.S, Z29.B, Z10.B
    USDOT Z0.S, Z27.B, Z17.B
    UMMLA Z2.S, Z22.B, Z6.B
    UMMLA Z21.S, Z12.B, Z14.B
    USDOT Z6.S, Z27.B, Z20.B
    SUDOT Z26.S, Z1.B, Z4.B[0x2]
    SMMLA Z31.S, Z26.B, Z24.B
    USMMLA Z26.S, Z0.B, Z20.B
    SMMLA Z8.S, Z29.B, Z13.B
    UMMLA Z5.S, Z21.B, Z30.B
    SUDOT Z0.S, Z10.B, Z3.B[0x3]
    SUDOT Z9.S, Z9.B, Z6.B[0x0]
    USDOT Z22.S, Z25.B, Z5.B
    UMMLA Z1.S, Z4.B, Z25.B
    SMMLA Z15.S, Z17.B, Z9.B
    USMMLA Z30.S, Z17.B, Z15.B
    USMMLA Z23.S, Z26.B, Z0.B
    SUDOT Z9.S, Z22.B, Z1.B[0x1]
    USDOT Z9.S, Z20.B, Z3.B[0x2]
    SMMLA Z29.S, Z21.B, Z2.B
    USDOT Z18.S, Z5.B, Z5.B[0x0]
    SUDOT Z11.S, Z1.B, Z7.B[0x1]
    SUDOT Z26.S, Z13.B, Z3.B[0x2]
    UMMLA Z23.S, Z29.B, Z26.B
    USMMLA Z11.S, Z30.B, Z8.B
    UMMLA Z3.S, Z11.B, Z18.B
    USDOT Z3.S, Z9.B, Z3.B[0x2]
    USDOT Z23.S, Z0.B, Z6.B[0x0]
    USMMLA Z23.S, Z5.B, Z14.B
    UMMLA Z3.S, Z3.B, Z7.B
    USDOT Z3.S, Z23.B, Z31.B
    USDOT Z7.S, Z13.B, Z31.B
    SMMLA Z4.S, Z28.B, Z16.B
    UMMLA Z26.S, Z19.B, Z15.B
    USDOT Z20.S, Z11.B, Z5.B
    UMMLA Z4.S, Z21.B, Z4.B
    SMMLA Z6.S, Z13.B, Z18.B
    USDOT Z27.S, Z30.B, Z23.B
    UMMLA Z12.S, Z20.B, Z28.B
    SUDOT Z2.S, Z4.B, Z2.B[0x0]
    USDOT Z1.S, Z27.B, Z5.B[0x1]
    USDOT Z16.S, Z13.B, Z7.B[0x1]
    UMMLA Z11.S, Z9.B, Z11.B
    SUDOT Z20.S, Z28.B, Z6.B[0x3]
    USDOT Z29.S, Z7.B, Z4.B[0x1]
    USDOT Z7.S, Z2.B, Z2.B[0x3]
    UMMLA Z11.S, Z7.B, Z21.B
    USDOT Z12.S, Z1.B, Z3.B[0x2]
    USDOT Z24.S, Z2.B, Z1.B[0x3]
    USDOT Z11.S, Z24.B, Z6.B[0x0]
    USDOT Z11.S, Z12.B, Z4.B[0x1]
    USMMLA Z26.S, Z5.B, Z15.B
    SMMLA Z26.S, Z28.B, Z29.B
    SUDOT Z16.S, Z20.B, Z5.B[0x0]
    USMMLA Z3.S, Z16.B, Z26.B
    UMMLA Z17.S, Z7.B, Z3.B
    USDOT Z22.S, Z31.B, Z1.B[0x3]
    SMMLA Z10.S, Z9.B, Z30.B
    USDOT Z28.S, Z1.B, Z6.B[0x1]
    SMMLA Z4.S, Z23.B, Z8.B
    SUDOT Z20.S, Z5.B, Z6.B[0x0]
    UMMLA Z21.S, Z21.B, Z29.B
    SMMLA Z28.S, Z4.B, Z15.B
    SUDOT Z9.S, Z28.B, Z1.B[0x2]
    UMMLA Z25.S, Z30.B, Z27.B
    USMMLA Z31.S, Z29.B, Z14.B
    USDOT Z11.S, Z9.B, Z22.B
    UMMLA Z25.S, Z31.B, Z25.B
    SUDOT Z11.S, Z17.B, Z1.B[0x3]
    SMMLA Z20.S, Z11.B, Z7.B
    SUDOT Z10.S, Z3.B, Z4.B[0x0]
    UMMLA Z21.S, Z19.B, Z10.B
    USMMLA Z17.S, Z25.B, Z22.B
    SUDOT Z20.S, Z11.B, Z5.B[0x3]
    USMMLA Z17.S, Z14.B, Z21.B
    USMMLA Z16.S, Z28.B, Z3.B
    USDOT Z7.S, Z9.B, Z4.B[0x2]
    SMMLA Z1.S, Z26.B, Z5.B
    USDOT Z21.S, Z10.B, Z27.B
    UMMLA Z3.S, Z24.B, Z24.B
    SUDOT Z7.S, Z2.B, Z1.B[0x0]
    UMMLA Z26.S, Z31.B, Z0.B
    USMMLA Z5.S, Z0.B, Z28.B
    USDOT Z19.S, Z14.B, Z0.B
    USDOT Z26.S, Z26.B, Z0.B[0x0]
    USDOT Z19.S, Z28.B, Z26.B
    UMMLA Z7.S, Z16.B, Z20.B
    SMMLA Z5.S, Z7.B, Z3.B
    UMMLA Z0.S, Z28.B, Z22.B
    SUDOT Z5.S, Z0.B, Z1.B[0x2]
    USMMLA Z5.S, Z23.B, Z19.B
    SMMLA Z15.S, Z21.B, Z5.B
    SUDOT Z23.S, Z3.B, Z5.B[0x2]
    UMMLA Z23.S, Z12.B, Z8.B
    USDOT Z17.S, Z31.B, Z24.B
    USMMLA Z11.S, Z8.B, Z20.B
    SMMLA Z15.S, Z18.B, Z6.B
    SUDOT Z28.S, Z27.B, Z3.B[0x3]
    USDOT Z19.S, Z3.B, Z7.B
    SMMLA Z16.S, Z10.B, Z0.B
    USDOT Z31.S, Z20.B, Z7.B[0x1]
    USDOT Z6.S, Z29.B, Z17.B
    USDOT Z22.S, Z8.B, Z2.B[0x3]
    SMMLA Z16.S, Z30.B, Z17.B
    USMMLA Z28.S, Z24.B, Z4.B
    UMMLA Z11.S, Z22.B, Z28.B
    SUDOT Z11.S, Z23.B, Z6.B[0x1]
    USMMLA Z16.S, Z10.B, Z9.B
    USDOT Z27.S, Z19.B, Z26.B
    USDOT Z15.S, Z27.B, Z16.B
    USMMLA Z15.S, Z4.B, Z31.B
    USDOT Z25.S, Z15.B, Z16.B
    USMMLA Z21.S, Z18.B, Z30.B
    USMMLA Z15.S, Z10.B, Z2.B
    USDOT Z13.S, Z12.B, Z7.B[0x1]
    SUDOT Z18.S, Z5.B, Z4.B[0x2]
    UMMLA Z13.S, Z9.B, Z4.B
    SMMLA Z13.S, Z14.B, Z9.B
    USDOT Z2.S, Z30.B, Z3.B
    USDOT Z7.S, Z22.B, Z17.B
    SMMLA Z24.S, Z19.B, Z28.B
    SUDOT Z24.S, Z7.B, Z2.B[0x3]
    UMMLA Z8.S, Z13.B, Z12.B
    USDOT Z15.S, Z24.B, Z8.B
    USDOT Z21.S, Z27.B, Z20.B
    UMMLA Z15.S, Z27.B, Z15.B
    USDOT Z18.S, Z21.B, Z1.B[0x3]
    SUBS  X3, X3, #0x1
    B.NE  LCRTSveVectorI8MM_label_5
    MOVZ  X12, #0xe42a, LSL #0
    MOVK  X12, #0xc7ba, LSL #16
    MOVK  X12, #0x4305, LSL #32
    MOVK  X12, #0x173f, LSL #48
    SUB  X21, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0xcfb4, LSL #0
    MOVK  X12, #0xe666, LSL #16
    MOVK  X12, #0x653c, LSL #32
    MOVK  X12, #0x734a, LSL #48
    SUB  X21, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x8054, LSL #0
    MOVK  X12, #0x5266, LSL #16
    MOVK  X12, #0x4398, LSL #32
    MOVK  X12, #0x1c93, LSL #48
    SUB  X21, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x7ffc, LSL #0
    MOVK  X12, #0x3c7b, LSL #16
    MOVK  X12, #0xe21a, LSL #32
    MOVK  X12, #0x4289, LSL #48
    SUB  X21, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0xf438, LSL #0
    MOVK  X12, #0x234, LSL #16
    MOVK  X12, #0x8445, LSL #32
    MOVK  X12, #0x3a5a, LSL #48
    SUB  X21, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x7b04, LSL #0
    MOVK  X12, #0xab53, LSL #16
    MOVK  X12, #0x4f15, LSL #32
    MOVK  X12, #0x928c, LSL #48
    SUB  X21, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x9b93, LSL #0
    MOVK  X12, #0x4fb, LSL #16
    MOVK  X12, #0x25fc, LSL #32
    MOVK  X12, #0xeddd, LSL #48
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x5ae6, LSL #0
    MOVK  X12, #0x4b8a, LSL #16
    MOVK  X12, #0x8457, LSL #32
    MOVK  X12, #0x58a4, LSL #48
    SUB  X21, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0xcb87, LSL #0
    MOVK  X12, #0xd82, LSL #16
    MOVK  X12, #0x95bf, LSL #32
    MOVK  X12, #0x8484, LSL #48
    SUB  X21, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x3306, LSL #0
    MOVK  X12, #0x6f48, LSL #16
    MOVK  X12, #0xb990, LSL #32
    MOVK  X12, #0x22f6, LSL #48
    SUB  X21, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x1b3f, LSL #0
    MOVK  X12, #0xbc1a, LSL #16
    MOVK  X12, #0x5e85, LSL #32
    MOVK  X12, #0x6e7a, LSL #48
    SUB  X21, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x4f91, LSL #0
    MOVK  X12, #0x6e51, LSL #16
    MOVK  X12, #0x39d, LSL #32
    MOVK  X12, #0x7bb6, LSL #48
    SUB  X21, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x74a3, LSL #0
    MOVK  X12, #0x8ae0, LSL #16
    MOVK  X12, #0xd628, LSL #32
    MOVK  X12, #0xd0c2, LSL #48
    SUB  X21, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0xd7d3, LSL #0
    MOVK  X12, #0x9174, LSL #16
    MOVK  X12, #0x3b76, LSL #32
    MOVK  X12, #0x3f26, LSL #48
    SUB  X21, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0xd551, LSL #0
    MOVK  X12, #0xfd9a, LSL #16
    MOVK  X12, #0x8b07, LSL #32
    MOVK  X12, #0x98fa, LSL #48
    SUB  X21, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x2233, LSL #0
    MOVK  X12, #0x5bdc, LSL #16
    MOVK  X12, #0xe10d, LSL #32
    MOVK  X12, #0x5ed3, LSL #48
    SUB  X21, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x533e, LSL #0
    MOVK  X12, #0x6611, LSL #16
    MOVK  X12, #0xbbd2, LSL #32
    MOVK  X12, #0xd45e, LSL #48
    SUB  X21, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x4bee, LSL #0
    MOVK  X12, #0xe62, LSL #16
    MOVK  X12, #0xead8, LSL #32
    MOVK  X12, #0x1ccc, LSL #48
    SUB  X21, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0xa275, LSL #0
    MOVK  X12, #0xd32d, LSL #16
    MOVK  X12, #0xf56c, LSL #32
    MOVK  X12, #0x58e1, LSL #48
    SUB  X21, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MRS  X12, FPSR
    MOVZ  X21, #0x80, LSL #0
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X21, #0xfc7e, LSL #0
    MOVK  X21, #0xe71, LSL #16
    MOVK  X21, #0x1f2a, LSL #32
    MOVK  X21, #0x1cd8, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D0
    MOVZ  X21, #0xfc7e, LSL #0
    MOVK  X21, #0xe71, LSL #16
    MOVK  X21, #0x1f2a, LSL #32
    MOVK  X21, #0x1cd8, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X21, #0x5df, LSL #0
    MOVK  X21, #0x6621, LSL #16
    MOVK  X21, #0x5fb0, LSL #32
    MOVK  X21, #0xd46f, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D1
    MOVZ  X21, #0x5df, LSL #0
    MOVK  X21, #0x6621, LSL #16
    MOVK  X21, #0x5fb0, LSL #32
    MOVK  X21, #0xd46f, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X21, #0x7360, LSL #0
    MOVK  X21, #0xc7da, LSL #16
    MOVK  X21, #0x1f9e, LSL #32
    MOVK  X21, #0x1759, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D2
    MOVZ  X21, #0x7360, LSL #0
    MOVK  X21, #0xc7da, LSL #16
    MOVK  X21, #0x1f9e, LSL #32
    MOVK  X21, #0x1759, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X21, #0xeb38, LSL #0
    MOVK  X21, #0x4e55, LSL #16
    MOVK  X21, #0xf6f5, LSL #32
    MOVK  X21, #0x1b30, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D3
    MOVZ  X21, #0xeb38, LSL #0
    MOVK  X21, #0x4e55, LSL #16
    MOVK  X21, #0xf6f5, LSL #32
    MOVK  X21, #0x1b30, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X21, #0x7792, LSL #0
    MOVK  X21, #0x6f5b, LSL #16
    MOVK  X21, #0x91e8, LSL #32
    MOVK  X21, #0x2308, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D4
    MOVZ  X21, #0x7792, LSL #0
    MOVK  X21, #0x6f5b, LSL #16
    MOVK  X21, #0x91e8, LSL #32
    MOVK  X21, #0x2308, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X21, #0x43f5, LSL #0
    MOVK  X21, #0xd349, LSL #16
    MOVK  X21, #0x8c2f, LSL #32
    MOVK  X21, #0x58fd, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D5
    MOVZ  X21, #0x43f5, LSL #0
    MOVK  X21, #0xd349, LSL #16
    MOVK  X21, #0x8c2f, LSL #32
    MOVK  X21, #0x58fd, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X21, #0x6b82, LSL #0
    MOVK  X21, #0x6358, LSL #16
    MOVK  X21, #0xb91f, LSL #32
    MOVK  X21, #0x7fb8, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D6
    MOVZ  X21, #0x6b82, LSL #0
    MOVK  X21, #0x6358, LSL #16
    MOVK  X21, #0xb91f, LSL #32
    MOVK  X21, #0x7fb8, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X21, #0x6f59, LSL #0
    MOVK  X21, #0xfdb0, LSL #16
    MOVK  X21, #0xbd81, LSL #32
    MOVK  X21, #0x9912, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D7
    MOVZ  X21, #0x6f59, LSL #0
    MOVK  X21, #0xfdb0, LSL #16
    MOVK  X21, #0xbd81, LSL #32
    MOVK  X21, #0x9912, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X21, #0x9430, LSL #0
    MOVK  X21, #0x1449, LSL #16
    MOVK  X21, #0xf55c, LSL #32
    MOVK  X21, #0xef18, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D8
    MOVZ  X21, #0x9430, LSL #0
    MOVK  X21, #0x1449, LSL #16
    MOVK  X21, #0xf55c, LSL #32
    MOVK  X21, #0xef18, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X21, #0x834b, LSL #0
    MOVK  X21, #0x1439, LSL #16
    MOVK  X21, #0x9916, LSL #32
    MOVK  X21, #0xef05, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D9
    MOVZ  X21, #0x834b, LSL #0
    MOVK  X21, #0x1439, LSL #16
    MOVK  X21, #0x9916, LSL #32
    MOVK  X21, #0xef05, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X21, #0xc1cd, LSL #0
    MOVK  X21, #0x527b, LSL #16
    MOVK  X21, #0x7bc8, LSL #32
    MOVK  X21, #0x1ca9, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D10
    MOVZ  X21, #0xc1cd, LSL #0
    MOVK  X21, #0x527b, LSL #16
    MOVK  X21, #0x7bc8, LSL #32
    MOVK  X21, #0x1ca9, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X21, #0xbc85, LSL #0
    MOVK  X21, #0x1475, LSL #16
    MOVK  X21, #0xfbf4, LSL #32
    MOVK  X21, #0xef4b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D11
    MOVZ  X21, #0xbc85, LSL #0
    MOVK  X21, #0x1475, LSL #16
    MOVK  X21, #0xfbf4, LSL #32
    MOVK  X21, #0xef4b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X21, #0x681f, LSL #0
    MOVK  X21, #0x8b06, LSL #16
    MOVK  X21, #0x5f90, LSL #32
    MOVK  X21, #0xd0ea, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D12
    MOVZ  X21, #0x681f, LSL #0
    MOVK  X21, #0x8b06, LSL #16
    MOVK  X21, #0x5f90, LSL #32
    MOVK  X21, #0xd0ea, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X21, #0x9c6e, LSL #0
    MOVK  X21, #0xd93, LSL #16
    MOVK  X21, #0xcb97, LSL #32
    MOVK  X21, #0x8494, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D13
    MOVZ  X21, #0x9c6e, LSL #0
    MOVK  X21, #0xd93, LSL #16
    MOVK  X21, #0xcb97, LSL #32
    MOVK  X21, #0x8494, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X21, #0xb510, LSL #0
    MOVK  X21, #0x5269, LSL #16
    MOVK  X21, #0x4af8, LSL #32
    MOVK  X21, #0x1c97, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D14
    MOVZ  X21, #0xb510, LSL #0
    MOVK  X21, #0x5269, LSL #16
    MOVK  X21, #0x4af8, LSL #32
    MOVK  X21, #0x1c97, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X21, #0xfbca, LSL #0
    MOVK  X21, #0x4e3d, LSL #16
    MOVK  X21, #0xd991, LSL #32
    MOVK  X21, #0x1b16, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D15
    MOVZ  X21, #0xfbca, LSL #0
    MOVK  X21, #0x4e3d, LSL #16
    MOVK  X21, #0xd991, LSL #32
    MOVK  X21, #0x1b16, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X21, #0x418, LSL #0
    MOVK  X21, #0xd353, LSL #16
    MOVK  X21, #0x4afa, LSL #32
    MOVK  X21, #0x5908, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D16
    MOVZ  X21, #0x418, LSL #0
    MOVK  X21, #0xd353, LSL #16
    MOVK  X21, #0x4afa, LSL #32
    MOVK  X21, #0x5908, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X21, #0x7af5, LSL #0
    MOVK  X21, #0xbc34, LSL #16
    MOVK  X21, #0x601b, LSL #32
    MOVK  X21, #0x6e9b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D17
    MOVZ  X21, #0x7af5, LSL #0
    MOVK  X21, #0xbc34, LSL #16
    MOVK  X21, #0x601b, LSL #32
    MOVK  X21, #0x6e9b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X21, #0xb0b0, LSL #0
    MOVK  X21, #0x4b89, LSL #16
    MOVK  X21, #0x2058, LSL #32
    MOVK  X21, #0x58aa, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D18
    MOVZ  X21, #0xb0b0, LSL #0
    MOVK  X21, #0x4b89, LSL #16
    MOVK  X21, #0x2058, LSL #32
    MOVK  X21, #0x58aa, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X21, #0xdec, LSL #0
    MOVK  X21, #0xfdac, LSL #16
    MOVK  X21, #0xde3d, LSL #32
    MOVK  X21, #0x990b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D19
    MOVZ  X21, #0xdec, LSL #0
    MOVK  X21, #0xfdac, LSL #16
    MOVK  X21, #0xde3d, LSL #32
    MOVK  X21, #0x990b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X21, #0xe03b, LSL #0
    MOVK  X21, #0xe66b, LSL #16
    MOVK  X21, #0x2467, LSL #32
    MOVK  X21, #0x7357, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D20
    MOVZ  X21, #0xe03b, LSL #0
    MOVK  X21, #0xe66b, LSL #16
    MOVK  X21, #0x2467, LSL #32
    MOVK  X21, #0x7357, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X21, #0xb283, LSL #0
    MOVK  X21, #0x6f84, LSL #16
    MOVK  X21, #0x42c3, LSL #32
    MOVK  X21, #0x2337, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D21
    MOVZ  X21, #0xb283, LSL #0
    MOVK  X21, #0x6f84, LSL #16
    MOVK  X21, #0x42c3, LSL #32
    MOVK  X21, #0x2337, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X21, #0x899c, LSL #0
    MOVK  X21, #0x6358, LSL #16
    MOVK  X21, #0x2423, LSL #32
    MOVK  X21, #0x7fba, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D22
    MOVZ  X21, #0x899c, LSL #0
    MOVK  X21, #0x6358, LSL #16
    MOVK  X21, #0x2423, LSL #32
    MOVK  X21, #0x7fba, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X21, #0x3f42, LSL #0
    MOVK  X21, #0x63a2, LSL #16
    MOVK  X21, #0x20ea, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D23
    MOVZ  X21, #0x3f42, LSL #0
    MOVK  X21, #0x63a2, LSL #16
    MOVK  X21, #0x20ea, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X21, #0x61ee, LSL #0
    MOVK  X21, #0x1513, LSL #16
    MOVK  X21, #0x9dcd, LSL #32
    MOVK  X21, #0xcb2f, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D24
    MOVZ  X21, #0x61ee, LSL #0
    MOVK  X21, #0x1513, LSL #16
    MOVK  X21, #0x9dcd, LSL #32
    MOVK  X21, #0xcb2f, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X21, #0xe36, LSL #0
    MOVK  X21, #0x1449, LSL #16
    MOVK  X21, #0x75b0, LSL #32
    MOVK  X21, #0xef1a, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D25
    MOVZ  X21, #0xe36, LSL #0
    MOVK  X21, #0x1449, LSL #16
    MOVK  X21, #0x75b0, LSL #32
    MOVK  X21, #0xef1a, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X21, #0x1bc5, LSL #0
    MOVK  X21, #0x5c07, LSL #16
    MOVK  X21, #0x4d8d, LSL #32
    MOVK  X21, #0x5efc, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D26
    MOVZ  X21, #0x1bc5, LSL #0
    MOVK  X21, #0x5c07, LSL #16
    MOVK  X21, #0x4d8d, LSL #32
    MOVK  X21, #0x5efc, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X21, #0xe147, LSL #0
    MOVK  X21, #0x23d, LSL #16
    MOVK  X21, #0xb736, LSL #32
    MOVK  X21, #0x3a5e, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D27
    MOVZ  X21, #0xe147, LSL #0
    MOVK  X21, #0x23d, LSL #16
    MOVK  X21, #0xb736, LSL #32
    MOVK  X21, #0x3a5e, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X21, #0x3eae, LSL #0
    MOVK  X21, #0x24a, LSL #16
    MOVK  X21, #0xf610, LSL #32
    MOVK  X21, #0x3a73, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D28
    MOVZ  X21, #0x3eae, LSL #0
    MOVK  X21, #0x24a, LSL #16
    MOVK  X21, #0xf610, LSL #32
    MOVK  X21, #0x3a73, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X21, #0x3fd3, LSL #0
    MOVK  X21, #0x50a, LSL #16
    MOVK  X21, #0x8b59, LSL #32
    MOVK  X21, #0xedea, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D29
    MOVZ  X21, #0x3fd3, LSL #0
    MOVK  X21, #0x50a, LSL #16
    MOVK  X21, #0x8b59, LSL #32
    MOVK  X21, #0xedea, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X21, #0x1443, LSL #0
    MOVK  X21, #0x6624, LSL #16
    MOVK  X21, #0x7cd7, LSL #32
    MOVK  X21, #0xd471, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D30
    MOVZ  X21, #0x1443, LSL #0
    MOVK  X21, #0x6624, LSL #16
    MOVK  X21, #0x7cd7, LSL #32
    MOVK  X21, #0xd471, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X21, #0xe9d1, LSL #0
    MOVK  X21, #0xe5e, LSL #16
    MOVK  X21, #0x1c80, LSL #32
    MOVK  X21, #0x1cc7, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FMOV  X12, D31
    MOVZ  X21, #0xe9d1, LSL #0
    MOVK  X21, #0xe5e, LSL #16
    MOVK  X21, #0x1c80, LSL #32
    MOVK  X21, #0x1cc7, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X12, #0x0, LSL #0
    STR  X12, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X12, [X0, #0]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
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
    FMOV  X12, D0
    MOVZ  X21, #0xfc7e, LSL #0
    MOVK  X21, #0xe71, LSL #16
    MOVK  X21, #0x1f2a, LSL #32
    MOVK  X21, #0x1cf8, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X12, D1
    MOVZ  X21, #0x5df, LSL #0
    MOVK  X21, #0x6621, LSL #16
    MOVK  X21, #0x5fb0, LSL #32
    MOVK  X21, #0xd48f, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X12, D2
    MOVZ  X21, #0x7360, LSL #0
    MOVK  X21, #0xc7da, LSL #16
    MOVK  X21, #0x1f9e, LSL #32
    MOVK  X21, #0x1779, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P4, Z3.D
    FMOV  X12, D3
    MOVZ  X21, #0xeb38, LSL #0
    MOVK  X21, #0x4e55, LSL #16
    MOVK  X21, #0xf6f5, LSL #32
    MOVK  X21, #0x1b50, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X12, D4
    MOVZ  X21, #0x7792, LSL #0
    MOVK  X21, #0x6f5b, LSL #16
    MOVK  X21, #0x91e8, LSL #32
    MOVK  X21, #0x2328, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P6, Z5.D
    FMOV  X12, D5
    MOVZ  X21, #0x43f5, LSL #0
    MOVK  X21, #0xd349, LSL #16
    MOVK  X21, #0x8c2f, LSL #32
    MOVK  X21, #0x591d, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X12, D6
    MOVZ  X21, #0x6b82, LSL #0
    MOVK  X21, #0x6358, LSL #16
    MOVK  X21, #0xb91f, LSL #32
    MOVK  X21, #0x7fd8, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X12, D7
    MOVZ  X21, #0x6f59, LSL #0
    MOVK  X21, #0xfdb0, LSL #16
    MOVK  X21, #0xbd81, LSL #32
    MOVK  X21, #0x9932, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X12, D8
    MOVZ  X21, #0x9430, LSL #0
    MOVK  X21, #0x1449, LSL #16
    MOVK  X21, #0xf55c, LSL #32
    MOVK  X21, #0xef38, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X12, D9
    MOVZ  X21, #0x834b, LSL #0
    MOVK  X21, #0x1439, LSL #16
    MOVK  X21, #0x9916, LSL #32
    MOVK  X21, #0xef25, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X12, D10
    MOVZ  X21, #0xc1cd, LSL #0
    MOVK  X21, #0x527b, LSL #16
    MOVK  X21, #0x7bc8, LSL #32
    MOVK  X21, #0x1cc9, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X12, D11
    MOVZ  X21, #0xbc85, LSL #0
    MOVK  X21, #0x1475, LSL #16
    MOVK  X21, #0xfbf4, LSL #32
    MOVK  X21, #0xef6b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X12, D12
    MOVZ  X21, #0x681f, LSL #0
    MOVK  X21, #0x8b06, LSL #16
    MOVK  X21, #0x5f90, LSL #32
    MOVK  X21, #0xd10a, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X12, D13
    MOVZ  X21, #0x9c6e, LSL #0
    MOVK  X21, #0xd93, LSL #16
    MOVK  X21, #0xcb97, LSL #32
    MOVK  X21, #0x84b4, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P5, Z14.D
    FMOV  X12, D14
    MOVZ  X21, #0xb510, LSL #0
    MOVK  X21, #0x5269, LSL #16
    MOVK  X21, #0x4af8, LSL #32
    MOVK  X21, #0x1cb7, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X12, D15
    MOVZ  X21, #0xfbca, LSL #0
    MOVK  X21, #0x4e3d, LSL #16
    MOVK  X21, #0xd991, LSL #32
    MOVK  X21, #0x1b36, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X12, D16
    MOVZ  X21, #0x418, LSL #0
    MOVK  X21, #0xd353, LSL #16
    MOVK  X21, #0x4afa, LSL #32
    MOVK  X21, #0x5928, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X12, D17
    MOVZ  X21, #0x7af5, LSL #0
    MOVK  X21, #0xbc34, LSL #16
    MOVK  X21, #0x601b, LSL #32
    MOVK  X21, #0x6ebb, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P7, Z18.D
    FMOV  X12, D18
    MOVZ  X21, #0xb0b0, LSL #0
    MOVK  X21, #0x4b89, LSL #16
    MOVK  X21, #0x2058, LSL #32
    MOVK  X21, #0x58ca, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X12, D19
    MOVZ  X21, #0xdec, LSL #0
    MOVK  X21, #0xfdac, LSL #16
    MOVK  X21, #0xde3d, LSL #32
    MOVK  X21, #0x992b, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X12, D20
    MOVZ  X21, #0xe03b, LSL #0
    MOVK  X21, #0xe66b, LSL #16
    MOVK  X21, #0x2467, LSL #32
    MOVK  X21, #0x7377, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X12, D21
    MOVZ  X21, #0xb283, LSL #0
    MOVK  X21, #0x6f84, LSL #16
    MOVK  X21, #0x42c3, LSL #32
    MOVK  X21, #0x2357, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X12, D22
    MOVZ  X21, #0x899c, LSL #0
    MOVK  X21, #0x6358, LSL #16
    MOVK  X21, #0x2423, LSL #32
    MOVK  X21, #0x7fda, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X12, D23
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7ff8, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X12, D24
    MOVZ  X21, #0x61ee, LSL #0
    MOVK  X21, #0x1513, LSL #16
    MOVK  X21, #0x9dcd, LSL #32
    MOVK  X21, #0xcb4f, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X12, D25
    MOVZ  X21, #0xe36, LSL #0
    MOVK  X21, #0x1449, LSL #16
    MOVK  X21, #0x75b0, LSL #32
    MOVK  X21, #0xef3a, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X12, D26
    MOVZ  X21, #0x1bc5, LSL #0
    MOVK  X21, #0x5c07, LSL #16
    MOVK  X21, #0x4d8d, LSL #32
    MOVK  X21, #0x5f1c, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P7, Z27.D
    FMOV  X12, D27
    MOVZ  X21, #0xe147, LSL #0
    MOVK  X21, #0x23d, LSL #16
    MOVK  X21, #0xb736, LSL #32
    MOVK  X21, #0x3a7e, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X12, D28
    MOVZ  X21, #0x3eae, LSL #0
    MOVK  X21, #0x24a, LSL #16
    MOVK  X21, #0xf610, LSL #32
    MOVK  X21, #0x3a93, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X12, D29
    MOVZ  X21, #0x3fd3, LSL #0
    MOVK  X21, #0x50a, LSL #16
    MOVK  X21, #0x8b59, LSL #32
    MOVK  X21, #0xee0a, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X12, D30
    MOVZ  X21, #0x1443, LSL #0
    MOVK  X21, #0x6624, LSL #16
    MOVK  X21, #0x7cd7, LSL #32
    MOVK  X21, #0xd491, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P7, Z31.D
    FMOV  X12, D31
    MOVZ  X21, #0xe9d1, LSL #0
    MOVK  X21, #0xe5e, LSL #16
    MOVK  X21, #0x1c80, LSL #32
    MOVK  X21, #0x1ce7, LSL #48
    SUB  X19, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X17
    DUP     Z1.D, X10
    DUP     Z2.D, X21
    DUP     Z3.D, X22
    DUP     Z4.D, X16
    DUP     Z5.D, X8
    DUP     Z6.D, X6
    DUP     Z7.D, X18
    DUP     Z8.D, X19
    DUP     Z9.D, X11
    DUP     Z10.D, X6
    DUP     Z11.D, X20
    DUP     Z12.D, X9
    DUP     Z13.D, X29
    DUP     Z14.D, X23
    DUP     Z15.D, X11
    DUP     Z16.D, X16
    DUP     Z17.D, X3
    DUP     Z18.D, X10
    DUP     Z19.D, X6
    DUP     Z20.D, X15
    DUP     Z21.D, X18
    DUP     Z22.D, X19
    DUP     Z23.D, X7
    DUP     Z24.D, X18
    DUP     Z25.D, X21
    DUP     Z26.D, X13
    DUP     Z27.D, X17
    DUP     Z28.D, X7
    DUP     Z29.D, X22
    DUP     Z30.D, X2
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
LCRTSveVectorI8MM_label_6:
    UMMLA Z0.S, Z30.B, Z30.B
    SUDOT Z31.S, Z31.B, Z0.B[0x2]
    UMMLA Z24.S, Z31.B, Z12.B
    USDOT Z24.S, Z24.B, Z4.B
    UMMLA Z10.S, Z24.B, Z27.B
    USDOT Z10.S, Z26.B, Z26.B
    USDOT Z17.S, Z10.B, Z21.B
    SUDOT Z17.S, Z6.B, Z6.B[0x1]
    USDOT Z16.S, Z17.B, Z6.B[0x2]
    USDOT Z16.S, Z6.B, Z4.B[0x1]
    USMMLA Z16.S, Z16.B, Z26.B
    UMMLA Z12.S, Z18.B, Z15.B
    USMMLA Z2.S, Z31.B, Z2.B
    SMMLA Z29.S, Z12.B, Z0.B
    SUDOT Z9.S, Z2.B, Z2.B[0x2]
    USDOT Z30.S, Z11.B, Z1.B[0x1]
    SMMLA Z20.S, Z6.B, Z15.B
    UMMLA Z26.S, Z28.B, Z30.B
    USDOT Z19.S, Z8.B, Z29.B
    USDOT Z20.S, Z3.B, Z5.B[0x0]
    USDOT Z21.S, Z19.B, Z26.B
    USMMLA Z10.S, Z10.B, Z9.B
    USMMLA Z16.S, Z21.B, Z18.B
    UMMLA Z10.S, Z16.B, Z16.B
    UMMLA Z10.S, Z20.B, Z23.B
    SMMLA Z14.S, Z31.B, Z2.B
    USDOT Z31.S, Z27.B, Z7.B[0x0]
    SUDOT Z3.S, Z14.B, Z4.B[0x0]
    USMMLA Z2.S, Z31.B, Z7.B
    USDOT Z30.S, Z2.B, Z7.B[0x0]
    SMMLA Z22.S, Z18.B, Z25.B
    SUDOT Z23.S, Z1.B, Z5.B[0x2]
    USMMLA Z30.S, Z11.B, Z4.B
    USDOT Z3.S, Z26.B, Z1.B[0x2]
    USMMLA Z22.S, Z1.B, Z6.B
    USMMLA Z3.S, Z21.B, Z30.B
    USDOT Z14.S, Z3.B, Z3.B[0x1]
    USDOT Z8.S, Z21.B, Z15.B
    SMMLA Z20.S, Z19.B, Z1.B
    USDOT Z19.S, Z27.B, Z23.B
    SMMLA Z29.S, Z30.B, Z3.B
    USDOT Z2.S, Z20.B, Z0.B[0x3]
    SMMLA Z4.S, Z2.B, Z11.B
    SUDOT Z12.S, Z25.B, Z3.B[0x2]
    UMMLA Z6.S, Z24.B, Z19.B
    USMMLA Z13.S, Z26.B, Z20.B
    SUDOT Z1.S, Z10.B, Z4.B[0x1]
    USDOT Z29.S, Z22.B, Z14.B
    SUDOT Z13.S, Z13.B, Z7.B[0x3]
    USMMLA Z1.S, Z8.B, Z13.B
    SUDOT Z6.S, Z1.B, Z1.B[0x3]
    USMMLA Z25.S, Z29.B, Z6.B
    SMMLA Z9.S, Z24.B, Z14.B
    USMMLA Z10.S, Z18.B, Z31.B
    USDOT Z10.S, Z1.B, Z24.B
    UMMLA Z14.S, Z17.B, Z30.B
    SMMLA Z25.S, Z7.B, Z15.B
    USDOT Z29.S, Z9.B, Z0.B[0x0]
    USMMLA Z19.S, Z20.B, Z25.B
    UMMLA Z9.S, Z8.B, Z26.B
    SMMLA Z29.S, Z21.B, Z17.B
    UMMLA Z7.S, Z12.B, Z4.B
    SMMLA Z0.S, Z24.B, Z28.B
    USDOT Z26.S, Z22.B, Z6.B[0x0]
    SUDOT Z24.S, Z27.B, Z4.B[0x2]
    SMMLA Z26.S, Z14.B, Z9.B
    SUDOT Z16.S, Z19.B, Z0.B[0x2]
    USMMLA Z13.S, Z16.B, Z4.B
    USDOT Z22.S, Z30.B, Z4.B[0x1]
    USDOT Z7.S, Z22.B, Z4.B[0x1]
    USMMLA Z27.S, Z3.B, Z29.B
    SUDOT Z7.S, Z27.B, Z7.B[0x2]
    SUDOT Z10.S, Z24.B, Z4.B[0x1]
    USMMLA Z10.S, Z24.B, Z19.B
    SUDOT Z7.S, Z6.B, Z4.B[0x3]
    USDOT Z13.S, Z10.B, Z4.B
    UMMLA Z7.S, Z13.B, Z26.B
    USMMLA Z21.S, Z17.B, Z18.B
    SMMLA Z25.S, Z14.B, Z13.B
    UMMLA Z30.S, Z21.B, Z13.B
    USDOT Z15.S, Z2.B, Z11.B
    UMMLA Z10.S, Z23.B, Z4.B
    UMMLA Z4.S, Z12.B, Z2.B
    USMMLA Z20.S, Z21.B, Z8.B
    UMMLA Z17.S, Z3.B, Z9.B
    USMMLA Z27.S, Z27.B, Z1.B
    UMMLA Z0.S, Z21.B, Z27.B
    SUDOT Z10.S, Z30.B, Z1.B[0x2]
    USMMLA Z15.S, Z27.B, Z17.B
    USMMLA Z10.S, Z4.B, Z7.B
    SMMLA Z1.S, Z0.B, Z19.B
    USMMLA Z20.S, Z1.B, Z12.B
    USDOT Z15.S, Z20.B, Z4.B[0x0]
    USDOT Z11.S, Z15.B, Z2.B[0x3]
    SUDOT Z19.S, Z25.B, Z5.B[0x1]
    USDOT Z11.S, Z10.B, Z28.B
    SUDOT Z13.S, Z6.B, Z4.B[0x0]
    SMMLA Z26.S, Z29.B, Z23.B
    USMMLA Z18.S, Z14.B, Z10.B
    SUDOT Z27.S, Z24.B, Z0.B[0x3]
    USMMLA Z15.S, Z30.B, Z2.B
    USMMLA Z5.S, Z15.B, Z26.B
    USMMLA Z24.S, Z15.B, Z4.B
    USMMLA Z30.S, Z25.B, Z6.B
    UMMLA Z1.S, Z0.B, Z3.B
    UMMLA Z13.S, Z5.B, Z27.B
    SUDOT Z18.S, Z30.B, Z3.B[0x0]
    SUDOT Z24.S, Z13.B, Z1.B[0x2]
    SMMLA Z10.S, Z18.B, Z14.B
    USDOT Z10.S, Z30.B, Z0.B[0x3]
    SUDOT Z6.S, Z11.B, Z3.B[0x1]
    USDOT Z22.S, Z24.B, Z16.B
    UMMLA Z23.S, Z10.B, Z21.B
    USDOT Z23.S, Z11.B, Z6.B[0x0]
    SMMLA Z26.S, Z23.B, Z1.B
    USDOT Z26.S, Z16.B, Z22.B
    USMMLA Z23.S, Z30.B, Z19.B
    USDOT Z21.S, Z21.B, Z5.B[0x2]
    USDOT Z23.S, Z21.B, Z1.B
    USDOT Z26.S, Z3.B, Z6.B
    SMMLA Z7.S, Z18.B, Z30.B
    USMMLA Z25.S, Z25.B, Z11.B
    USDOT Z11.S, Z28.B, Z0.B[0x1]
    SMMLA Z4.S, Z5.B, Z15.B
    SMMLA Z21.S, Z24.B, Z1.B
    SMMLA Z6.S, Z26.B, Z15.B
    UMMLA Z17.S, Z6.B, Z2.B
    USMMLA Z5.S, Z24.B, Z2.B
    USDOT Z31.S, Z5.B, Z1.B[0x1]
    SMMLA Z25.S, Z8.B, Z29.B
    SMMLA Z27.S, Z8.B, Z8.B
    USDOT Z9.S, Z23.B, Z0.B[0x1]
    USDOT Z21.S, Z4.B, Z4.B[0x0]
    USDOT Z17.S, Z21.B, Z0.B[0x3]
    UMMLA Z31.S, Z27.B, Z29.B
    USDOT Z2.S, Z9.B, Z12.B
    USMMLA Z2.S, Z17.B, Z7.B
    UMMLA Z23.S, Z8.B, Z19.B
    USDOT Z28.S, Z0.B, Z12.B
    USMMLA Z23.S, Z2.B, Z23.B
    UMMLA Z7.S, Z14.B, Z25.B
    USDOT Z7.S, Z11.B, Z7.B[0x3]
    SUDOT Z23.S, Z7.B, Z5.B[0x0]
    SMMLA Z31.S, Z12.B, Z23.B
    USDOT Z6.S, Z25.B, Z26.B
    UMMLA Z5.S, Z1.B, Z20.B
    SUDOT Z7.S, Z11.B, Z2.B[0x0]
    USMMLA Z20.S, Z20.B, Z0.B
    USDOT Z7.S, Z30.B, Z3.B[0x1]
    USDOT Z10.S, Z11.B, Z2.B[0x2]
    SMMLA Z22.S, Z1.B, Z2.B
    USDOT Z8.S, Z29.B, Z16.B
    USMMLA Z24.S, Z22.B, Z10.B
    USDOT Z10.S, Z8.B, Z6.B[0x3]
    SUDOT Z20.S, Z20.B, Z7.B[0x1]
    USMMLA Z2.S, Z24.B, Z20.B
    UMMLA Z5.S, Z8.B, Z28.B
    SMMLA Z6.S, Z31.B, Z0.B
    USDOT Z21.S, Z6.B, Z10.B
    USMMLA Z9.S, Z25.B, Z24.B
    SMMLA Z5.S, Z21.B, Z9.B
    USDOT Z17.S, Z10.B, Z3.B[0x3]
    USDOT Z3.S, Z24.B, Z5.B[0x0]
    USMMLA Z31.S, Z24.B, Z27.B
    USDOT Z9.S, Z30.B, Z16.B
    USMMLA Z26.S, Z6.B, Z26.B
    SUDOT Z16.S, Z1.B, Z4.B[0x2]
    USDOT Z30.S, Z4.B, Z12.B
    USDOT Z26.S, Z3.B, Z6.B[0x1]
    SMMLA Z11.S, Z27.B, Z11.B
    USDOT Z5.S, Z17.B, Z3.B[0x2]
    SUDOT Z13.S, Z21.B, Z7.B[0x0]
    USMMLA Z2.S, Z16.B, Z3.B
    USMMLA Z25.S, Z2.B, Z2.B
    USDOT Z26.S, Z29.B, Z5.B[0x3]
    USDOT Z30.S, Z11.B, Z2.B[0x2]
    USMMLA Z31.S, Z23.B, Z25.B
    UMMLA Z31.S, Z0.B, Z30.B
    SMMLA Z9.S, Z31.B, Z18.B
    SUDOT Z9.S, Z13.B, Z4.B[0x2]
    SUDOT Z24.S, Z28.B, Z7.B[0x0]
    USMMLA Z18.S, Z19.B, Z27.B
    USDOT Z7.S, Z13.B, Z2.B
    USMMLA Z24.S, Z4.B, Z27.B
    USDOT Z3.S, Z5.B, Z12.B
    UMMLA Z26.S, Z21.B, Z3.B
    SMMLA Z5.S, Z27.B, Z18.B
    SMMLA Z16.S, Z21.B, Z19.B
    USDOT Z8.S, Z11.B, Z29.B
    USMMLA Z6.S, Z7.B, Z18.B
    USDOT Z28.S, Z13.B, Z7.B[0x0]
    UMMLA Z21.S, Z11.B, Z19.B
    USMMLA Z8.S, Z3.B, Z24.B
    USDOT Z8.S, Z6.B, Z15.B
    UMMLA Z9.S, Z24.B, Z21.B
    SUDOT Z16.S, Z15.B, Z4.B[0x3]
    SUDOT Z30.S, Z9.B, Z1.B[0x0]
    USMMLA Z31.S, Z28.B, Z20.B
    SMMLA Z16.S, Z8.B, Z28.B
    UMMLA Z6.S, Z30.B, Z14.B
    SUBS  X10, X10, #0x1
    B.NE  LCRTSveVectorI8MM_label_6
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MRS  X13, FPSR
    MOVZ  X22, #0x80, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D1
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D22
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D30
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FMOV  X13, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    MOVZ  X13, #0x0, LSL #0
    STR  X13, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X13, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
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
    FMOV  X13, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X13, D1
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X13, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X13, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X13, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X13, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X13, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X13, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X13, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P5, Z9.D
    FMOV  X13, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X13, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P5, Z11.D
    FMOV  X13, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X13, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X13, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P7, Z14.D
    FMOV  X13, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P2, Z15.D
    FMOV  X13, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X13, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P0, Z17.D
    FMOV  X13, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X13, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X13, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X13, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X13, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X13, D22
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P3, Z23.D
    FMOV  X13, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X13, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X13, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X13, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P4, Z27.D
    FMOV  X13, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X13, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X13, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X13, D30
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X13, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X18
    DUP     Z1.D, X20
    DUP     Z2.D, X9
    DUP     Z3.D, X22
    DUP     Z4.D, X21
    DUP     Z5.D, X23
    DUP     Z6.D, X29
    DUP     Z7.D, X4
    DUP     Z8.D, X6
    DUP     Z9.D, X14
    DUP     Z10.D, X17
    DUP     Z11.D, X13
    DUP     Z12.D, X7
    DUP     Z13.D, X14
    DUP     Z14.D, X2
    DUP     Z15.D, X3
    DUP     Z16.D, X19
    DUP     Z17.D, X16
    DUP     Z18.D, X4
    DUP     Z19.D, X29
    DUP     Z20.D, X22
    DUP     Z21.D, X20
    DUP     Z22.D, X19
    DUP     Z23.D, X20
    DUP     Z24.D, X3
    DUP     Z25.D, X22
    DUP     Z26.D, X2
    DUP     Z27.D, X12
    DUP     Z28.D, X12
    DUP     Z29.D, X6
    DUP     Z30.D, X2
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
    MOVZ  X5, #0xa, LSL #0
LCRTSveVectorI8MM_label_7:
    SUDOT Z23.S, Z19.B, Z4.B[0x0]
    UMMLA Z30.S, Z31.B, Z31.B
    USDOT Z23.S, Z30.B, Z1.B[0x0]
    USDOT Z23.S, Z27.B, Z0.B[0x2]
    SUDOT Z1.S, Z23.B, Z3.B[0x2]
    USMMLA Z21.S, Z15.B, Z1.B
    USDOT Z21.S, Z4.B, Z2.B[0x1]
    USDOT Z0.S, Z21.B, Z0.B
    USMMLA Z0.S, Z2.B, Z0.B
    SMMLA Z0.S, Z2.B, Z0.B
    USMMLA Z0.S, Z0.B, Z7.B
    USMMLA Z13.S, Z5.B, Z31.B
    USDOT Z0.S, Z0.B, Z5.B[0x0]
    SMMLA Z29.S, Z28.B, Z8.B
    SMMLA Z15.S, Z16.B, Z11.B
    USDOT Z26.S, Z5.B, Z4.B[0x1]
    SMMLA Z4.S, Z23.B, Z12.B
    SUDOT Z11.S, Z0.B, Z3.B[0x2]
    SUDOT Z1.S, Z27.B, Z0.B[0x1]
    UMMLA Z8.S, Z14.B, Z25.B
    USDOT Z27.S, Z31.B, Z2.B
    USDOT Z29.S, Z26.B, Z4.B[0x1]
    UMMLA Z11.S, Z1.B, Z23.B
    SUDOT Z13.S, Z31.B, Z5.B[0x1]
    UMMLA Z27.S, Z27.B, Z9.B
    USMMLA Z15.S, Z27.B, Z8.B
    USMMLA Z11.S, Z23.B, Z16.B
    USDOT Z13.S, Z15.B, Z1.B[0x1]
    SUDOT Z9.S, Z24.B, Z4.B[0x0]
    USDOT Z25.S, Z13.B, Z24.B
    UMMLA Z11.S, Z20.B, Z9.B
    SUDOT Z25.S, Z11.B, Z2.B[0x0]
    SMMLA Z16.S, Z31.B, Z18.B
    SMMLA Z2.S, Z14.B, Z17.B
    UMMLA Z15.S, Z12.B, Z30.B
    USDOT Z29.S, Z3.B, Z29.B
    USDOT Z16.S, Z4.B, Z3.B[0x2]
    USDOT Z29.S, Z1.B, Z2.B[0x0]
    UMMLA Z17.S, Z5.B, Z10.B
    SUDOT Z4.S, Z1.B, Z6.B[0x2]
    UMMLA Z17.S, Z15.B, Z22.B
    SUDOT Z0.S, Z0.B, Z7.B[0x0]
    SUDOT Z2.S, Z11.B, Z5.B[0x1]
    UMMLA Z26.S, Z21.B, Z8.B
    SMMLA Z5.S, Z27.B, Z4.B
    USMMLA Z6.S, Z28.B, Z0.B
    USDOT Z15.S, Z23.B, Z4.B[0x3]
    UMMLA Z25.S, Z26.B, Z28.B
    SUDOT Z25.S, Z30.B, Z0.B[0x2]
    SUDOT Z15.S, Z25.B, Z5.B[0x1]
    USDOT Z27.S, Z23.B, Z6.B
    SMMLA Z17.S, Z20.B, Z17.B
    UMMLA Z14.S, Z11.B, Z16.B
    SUDOT Z15.S, Z14.B, Z2.B[0x1]
    USDOT Z13.S, Z29.B, Z29.B
    SMMLA Z15.S, Z27.B, Z18.B
    SUDOT Z23.S, Z15.B, Z7.B[0x0]
    USMMLA Z23.S, Z17.B, Z12.B
    UMMLA Z30.S, Z5.B, Z16.B
    USDOT Z15.S, Z9.B, Z1.B[0x1]
    UMMLA Z22.S, Z19.B, Z5.B
    USDOT Z8.S, Z1.B, Z1.B[0x0]
    USMMLA Z19.S, Z19.B, Z28.B
    USDOT Z6.S, Z16.B, Z1.B[0x3]
    USDOT Z10.S, Z17.B, Z4.B[0x1]
    UMMLA Z8.S, Z10.B, Z13.B
    USMMLA Z23.S, Z15.B, Z28.B
    USDOT Z30.S, Z17.B, Z19.B
    USDOT Z9.S, Z30.B, Z3.B[0x1]
    USDOT Z1.S, Z26.B, Z2.B[0x1]
    SMMLA Z6.S, Z9.B, Z14.B
    USMMLA Z24.S, Z8.B, Z14.B
    SUDOT Z22.S, Z31.B, Z5.B[0x0]
    USDOT Z3.S, Z24.B, Z6.B[0x0]
    SUDOT Z29.S, Z3.B, Z4.B[0x0]
    USMMLA Z23.S, Z22.B, Z23.B
    SUDOT Z29.S, Z29.B, Z1.B[0x2]
    USMMLA Z10.S, Z28.B, Z1.B
    USDOT Z0.S, Z14.B, Z2.B[0x3]
    USDOT Z0.S, Z16.B, Z31.B
    SMMLA Z25.S, Z0.B, Z25.B
    USDOT Z4.S, Z22.B, Z11.B
    USDOT Z28.S, Z3.B, Z12.B
    SUDOT Z30.S, Z10.B, Z4.B[0x1]
    USDOT Z18.S, Z28.B, Z2.B[0x1]
    SMMLA Z0.S, Z11.B, Z1.B
    SUDOT Z24.S, Z18.B, Z0.B[0x2]
    USDOT Z27.S, Z8.B, Z15.B
    SMMLA Z2.S, Z14.B, Z2.B
    USDOT Z25.S, Z22.B, Z27.B
    USDOT Z0.S, Z1.B, Z19.B
    USDOT Z9.S, Z3.B, Z23.B
    SUDOT Z22.S, Z23.B, Z2.B[0x0]
    USDOT Z17.S, Z15.B, Z7.B
    USDOT Z0.S, Z21.B, Z7.B
    SMMLA Z9.S, Z15.B, Z5.B
    USDOT Z23.S, Z19.B, Z6.B
    USDOT Z24.S, Z9.B, Z0.B[0x2]
    SUDOT Z17.S, Z21.B, Z6.B[0x0]
    UMMLA Z24.S, Z30.B, Z29.B
    UMMLA Z26.S, Z22.B, Z22.B
    SMMLA Z25.S, Z24.B, Z17.B
    USMMLA Z30.S, Z23.B, Z24.B
    UMMLA Z2.S, Z26.B, Z29.B
    UMMLA Z2.S, Z25.B, Z30.B
    UMMLA Z19.S, Z25.B, Z18.B
    USDOT Z6.S, Z23.B, Z6.B[0x2]
    SMMLA Z20.S, Z14.B, Z25.B
    UMMLA Z5.S, Z15.B, Z2.B
    SUDOT Z22.S, Z23.B, Z1.B[0x1]
    SMMLA Z4.S, Z6.B, Z24.B
    USDOT Z8.S, Z14.B, Z7.B[0x2]
    UMMLA Z26.S, Z5.B, Z18.B
    SMMLA Z3.S, Z8.B, Z31.B
    USMMLA Z14.S, Z8.B, Z6.B
    UMMLA Z19.S, Z20.B, Z14.B
    USDOT Z14.S, Z18.B, Z26.B
    USDOT Z8.S, Z16.B, Z0.B[0x3]
    USMMLA Z14.S, Z21.B, Z22.B
    SMMLA Z29.S, Z28.B, Z17.B
    USMMLA Z1.S, Z4.B, Z13.B
    USDOT Z11.S, Z14.B, Z5.B[0x2]
    USDOT Z24.S, Z15.B, Z3.B[0x3]
    SMMLA Z24.S, Z25.B, Z11.B
    USDOT Z21.S, Z15.B, Z4.B[0x1]
    USDOT Z3.S, Z27.B, Z25.B
    UMMLA Z27.S, Z12.B, Z16.B
    SUDOT Z24.S, Z22.B, Z7.B[0x1]
    SMMLA Z4.S, Z13.B, Z28.B
    UMMLA Z24.S, Z6.B, Z17.B
    USDOT Z25.S, Z3.B, Z15.B
    USDOT Z4.S, Z1.B, Z3.B[0x1]
    SMMLA Z21.S, Z24.B, Z8.B
    USDOT Z14.S, Z19.B, Z26.B
    SUDOT Z27.S, Z25.B, Z1.B[0x1]
    USDOT Z11.S, Z27.B, Z27.B
    USDOT Z14.S, Z4.B, Z4.B[0x1]
    SMMLA Z28.S, Z14.B, Z11.B
    USDOT Z10.S, Z11.B, Z5.B[0x2]
    USMMLA Z25.S, Z28.B, Z20.B
    USMMLA Z31.S, Z25.B, Z21.B
    USMMLA Z12.S, Z10.B, Z10.B
    USDOT Z6.S, Z12.B, Z6.B[0x3]
    UMMLA Z6.S, Z31.B, Z10.B
    USDOT Z0.S, Z14.B, Z6.B[0x3]
    SUDOT Z7.S, Z16.B, Z2.B[0x0]
    USDOT Z5.S, Z16.B, Z8.B
    USDOT Z10.S, Z21.B, Z6.B[0x3]
    SUDOT Z26.S, Z7.B, Z2.B[0x1]
    USDOT Z15.S, Z7.B, Z1.B[0x2]
    USMMLA Z4.S, Z13.B, Z20.B
    USMMLA Z22.S, Z29.B, Z9.B
    USMMLA Z29.S, Z18.B, Z27.B
    USDOT Z9.S, Z16.B, Z5.B[0x3]
    SMMLA Z7.S, Z22.B, Z24.B
    USMMLA Z22.S, Z11.B, Z2.B
    SMMLA Z15.S, Z7.B, Z26.B
    SUDOT Z9.S, Z15.B, Z7.B[0x2]
    SUDOT Z29.S, Z9.B, Z3.B[0x3]
    UMMLA Z25.S, Z29.B, Z22.B
    USDOT Z0.S, Z10.B, Z11.B
    UMMLA Z27.S, Z25.B, Z9.B
    USMMLA Z4.S, Z27.B, Z0.B
    USMMLA Z0.S, Z22.B, Z3.B
    USDOT Z7.S, Z6.B, Z6.B[0x3]
    SMMLA Z22.S, Z16.B, Z1.B
    SUDOT Z6.S, Z10.B, Z4.B[0x3]
    USMMLA Z17.S, Z3.B, Z1.B
    SUDOT Z31.S, Z18.B, Z0.B[0x1]
    UMMLA Z30.S, Z7.B, Z28.B
    SUDOT Z13.S, Z17.B, Z5.B[0x0]
    SMMLA Z31.S, Z11.B, Z2.B
    UMMLA Z18.S, Z24.B, Z19.B
    UMMLA Z13.S, Z23.B, Z7.B
    SUDOT Z6.S, Z14.B, Z6.B[0x2]
    USMMLA Z10.S, Z21.B, Z25.B
    USMMLA Z30.S, Z22.B, Z4.B
    USDOT Z13.S, Z10.B, Z1.B[0x1]
    USDOT Z5.S, Z7.B, Z0.B[0x3]
    UMMLA Z10.S, Z13.B, Z18.B
    UMMLA Z23.S, Z20.B, Z9.B
    SMMLA Z4.S, Z5.B, Z13.B
    USMMLA Z23.S, Z8.B, Z17.B
    USDOT Z26.S, Z18.B, Z11.B
    USMMLA Z21.S, Z22.B, Z0.B
    SUDOT Z19.S, Z30.B, Z5.B[0x3]
    UMMLA Z30.S, Z20.B, Z20.B
    UMMLA Z31.S, Z10.B, Z10.B
    USDOT Z30.S, Z15.B, Z5.B
    USMMLA Z15.S, Z31.B, Z26.B
    UMMLA Z0.S, Z6.B, Z3.B
    SMMLA Z0.S, Z23.B, Z21.B
    SMMLA Z24.S, Z15.B, Z10.B
    USMMLA Z4.S, Z19.B, Z24.B
    USDOT Z0.S, Z17.B, Z4.B[0x3]
    USMMLA Z14.S, Z30.B, Z7.B
    USMMLA Z21.S, Z23.B, Z29.B
    UMMLA Z27.S, Z13.B, Z29.B
    USMMLA Z8.S, Z8.B, Z23.B
    UMMLA Z20.S, Z11.B, Z15.B
    SUBS  X5, X5, #0x1
    B.NE  LCRTSveVectorI8MM_label_7
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X19, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MRS  X3, FPSR
    MOVZ  X19, #0x80, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X19, #0x7bd5, LSL #0
    MOVK  X19, #0x10, LSL #16
    MOVK  X19, #0x7bd5, LSL #32
    MOVK  X19, #0x10, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D0
    MOVZ  X19, #0x7bd5, LSL #0
    MOVK  X19, #0x10, LSL #16
    MOVK  X19, #0x7bd5, LSL #32
    MOVK  X19, #0x10, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X19, #0xe93, LSL #0
    MOVK  X19, #0xfffe, LSL #16
    MOVK  X19, #0xe93, LSL #32
    MOVK  X19, #0xfffe, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D1
    MOVZ  X19, #0xe93, LSL #0
    MOVK  X19, #0xfffe, LSL #16
    MOVK  X19, #0xe93, LSL #32
    MOVK  X19, #0xfffe, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X19, #0xfe28, LSL #0
    MOVK  X19, #0x15, LSL #16
    MOVK  X19, #0xfe28, LSL #32
    MOVK  X19, #0x15, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D2
    MOVZ  X19, #0xfe28, LSL #0
    MOVK  X19, #0x15, LSL #16
    MOVK  X19, #0xfe28, LSL #32
    MOVK  X19, #0x15, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X19, #0x2f45, LSL #0
    MOVK  X19, #0x1, LSL #16
    MOVK  X19, #0x2f45, LSL #32
    MOVK  X19, #0x1, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D3
    MOVZ  X19, #0x2f45, LSL #0
    MOVK  X19, #0x1, LSL #16
    MOVK  X19, #0x2f45, LSL #32
    MOVK  X19, #0x1, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X19, #0x9dca, LSL #0
    MOVK  X19, #0xfffc, LSL #16
    MOVK  X19, #0x9dca, LSL #32
    MOVK  X19, #0xfffc, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D4
    MOVZ  X19, #0x9dca, LSL #0
    MOVK  X19, #0xfffc, LSL #16
    MOVK  X19, #0x9dca, LSL #32
    MOVK  X19, #0xfffc, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X19, #0x4961, LSL #0
    MOVK  X19, #0x7, LSL #16
    MOVK  X19, #0x4961, LSL #32
    MOVK  X19, #0x7, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D5
    MOVZ  X19, #0x4961, LSL #0
    MOVK  X19, #0x7, LSL #16
    MOVK  X19, #0x4961, LSL #32
    MOVK  X19, #0x7, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X19, #0x15e3, LSL #0
    MOVK  X19, #0x11, LSL #16
    MOVK  X19, #0x15e3, LSL #32
    MOVK  X19, #0x11, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D6
    MOVZ  X19, #0x15e3, LSL #0
    MOVK  X19, #0x11, LSL #16
    MOVK  X19, #0x15e3, LSL #32
    MOVK  X19, #0x11, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X19, #0x3cbf, LSL #0
    MOVK  X19, #0xfffe, LSL #16
    MOVK  X19, #0x3cbf, LSL #32
    MOVK  X19, #0xfffe, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D7
    MOVZ  X19, #0x3cbf, LSL #0
    MOVK  X19, #0xfffe, LSL #16
    MOVK  X19, #0x3cbf, LSL #32
    MOVK  X19, #0xfffe, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X19, #0x71fa, LSL #0
    MOVK  X19, #0x20, LSL #16
    MOVK  X19, #0x71fa, LSL #32
    MOVK  X19, #0x20, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D8
    MOVZ  X19, #0x71fa, LSL #0
    MOVK  X19, #0x20, LSL #16
    MOVK  X19, #0x71fa, LSL #32
    MOVK  X19, #0x20, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X19, #0xe9d7, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xe9d7, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D9
    MOVZ  X19, #0xe9d7, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xe9d7, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X19, #0x1ab2, LSL #0
    MOVK  X19, #0xf, LSL #16
    MOVK  X19, #0x1ab2, LSL #32
    MOVK  X19, #0xf, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D10
    MOVZ  X19, #0x1ab2, LSL #0
    MOVK  X19, #0xf, LSL #16
    MOVK  X19, #0x1ab2, LSL #32
    MOVK  X19, #0xf, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X19, #0x3353, LSL #0
    MOVK  X19, #0x1e, LSL #16
    MOVK  X19, #0x3353, LSL #32
    MOVK  X19, #0x1e, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D11
    MOVZ  X19, #0x3353, LSL #0
    MOVK  X19, #0x1e, LSL #16
    MOVK  X19, #0x3353, LSL #32
    MOVK  X19, #0x1e, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X19, #0x69e3, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x69e3, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D12
    MOVZ  X19, #0x69e3, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x69e3, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X19, #0xab04, LSL #0
    MOVK  X19, #0x7, LSL #16
    MOVK  X19, #0xab04, LSL #32
    MOVK  X19, #0x7, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D13
    MOVZ  X19, #0xab04, LSL #0
    MOVK  X19, #0x7, LSL #16
    MOVK  X19, #0xab04, LSL #32
    MOVK  X19, #0x7, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X19, #0x8475, LSL #0
    MOVK  X19, #0xd, LSL #16
    MOVK  X19, #0x8475, LSL #32
    MOVK  X19, #0xd, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D14
    MOVZ  X19, #0x8475, LSL #0
    MOVK  X19, #0xd, LSL #16
    MOVK  X19, #0x8475, LSL #32
    MOVK  X19, #0xd, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X19, #0x3f6e, LSL #0
    MOVK  X19, #0xc, LSL #16
    MOVK  X19, #0x3f6e, LSL #32
    MOVK  X19, #0xc, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D15
    MOVZ  X19, #0x3f6e, LSL #0
    MOVK  X19, #0xc, LSL #16
    MOVK  X19, #0x3f6e, LSL #32
    MOVK  X19, #0xc, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X19, #0x8fcd, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x8fcd, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D16
    MOVZ  X19, #0x8fcd, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x8fcd, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X19, #0xd0e8, LSL #0
    MOVK  X19, #0x1d, LSL #16
    MOVK  X19, #0xd0e8, LSL #32
    MOVK  X19, #0x1d, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D17
    MOVZ  X19, #0xd0e8, LSL #0
    MOVK  X19, #0x1d, LSL #16
    MOVK  X19, #0xd0e8, LSL #32
    MOVK  X19, #0x1d, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X19, #0xdcf0, LSL #0
    MOVK  X19, #0x8, LSL #16
    MOVK  X19, #0xdcf0, LSL #32
    MOVK  X19, #0x8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D18
    MOVZ  X19, #0xdcf0, LSL #0
    MOVK  X19, #0x8, LSL #16
    MOVK  X19, #0xdcf0, LSL #32
    MOVK  X19, #0x8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X19, #0x3b0f, LSL #0
    MOVK  X19, #0x11, LSL #16
    MOVK  X19, #0x3b0f, LSL #32
    MOVK  X19, #0x11, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D19
    MOVZ  X19, #0x3b0f, LSL #0
    MOVK  X19, #0x11, LSL #16
    MOVK  X19, #0x3b0f, LSL #32
    MOVK  X19, #0x11, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X19, #0x4f73, LSL #0
    MOVK  X19, #0x6, LSL #16
    MOVK  X19, #0x4f73, LSL #32
    MOVK  X19, #0x6, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D20
    MOVZ  X19, #0x4f73, LSL #0
    MOVK  X19, #0x6, LSL #16
    MOVK  X19, #0x4f73, LSL #32
    MOVK  X19, #0x6, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X19, #0x1b76, LSL #0
    MOVK  X19, #0xfffa, LSL #16
    MOVK  X19, #0x1b76, LSL #32
    MOVK  X19, #0xfffa, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D21
    MOVZ  X19, #0x1b76, LSL #0
    MOVK  X19, #0xfffa, LSL #16
    MOVK  X19, #0x1b76, LSL #32
    MOVK  X19, #0xfffa, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X19, #0xa8b6, LSL #0
    MOVK  X19, #0xb, LSL #16
    MOVK  X19, #0xa8b6, LSL #32
    MOVK  X19, #0xb, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D22
    MOVZ  X19, #0xa8b6, LSL #0
    MOVK  X19, #0xb, LSL #16
    MOVK  X19, #0xa8b6, LSL #32
    MOVK  X19, #0xb, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X19, #0x199f, LSL #0
    MOVK  X19, #0x8, LSL #16
    MOVK  X19, #0x199f, LSL #32
    MOVK  X19, #0x8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D23
    MOVZ  X19, #0x199f, LSL #0
    MOVK  X19, #0x8, LSL #16
    MOVK  X19, #0x199f, LSL #32
    MOVK  X19, #0x8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X19, #0x85c5, LSL #0
    MOVK  X19, #0x13, LSL #16
    MOVK  X19, #0x85c5, LSL #32
    MOVK  X19, #0x13, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D24
    MOVZ  X19, #0x85c5, LSL #0
    MOVK  X19, #0x13, LSL #16
    MOVK  X19, #0x85c5, LSL #32
    MOVK  X19, #0x13, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X19, #0xfe5, LSL #0
    MOVK  X19, #0x14, LSL #16
    MOVK  X19, #0xfe5, LSL #32
    MOVK  X19, #0x14, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D25
    MOVZ  X19, #0xfe5, LSL #0
    MOVK  X19, #0x14, LSL #16
    MOVK  X19, #0xfe5, LSL #32
    MOVK  X19, #0x14, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X19, #0x5742, LSL #0
    MOVK  X19, #0x22, LSL #16
    MOVK  X19, #0x5742, LSL #32
    MOVK  X19, #0x22, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D26
    MOVZ  X19, #0x5742, LSL #0
    MOVK  X19, #0x22, LSL #16
    MOVK  X19, #0x5742, LSL #32
    MOVK  X19, #0x22, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X19, #0x107, LSL #0
    MOVK  X19, #0x40, LSL #16
    MOVK  X19, #0x107, LSL #32
    MOVK  X19, #0x40, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D27
    MOVZ  X19, #0x107, LSL #0
    MOVK  X19, #0x40, LSL #16
    MOVK  X19, #0x107, LSL #32
    MOVK  X19, #0x40, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X19, #0x443c, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x443c, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D28
    MOVZ  X19, #0x443c, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0x443c, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X19, #0x5641, LSL #0
    MOVK  X19, #0xfffe, LSL #16
    MOVK  X19, #0x5641, LSL #32
    MOVK  X19, #0xfffe, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D29
    MOVZ  X19, #0x5641, LSL #0
    MOVK  X19, #0xfffe, LSL #16
    MOVK  X19, #0x5641, LSL #32
    MOVK  X19, #0xfffe, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X19, #0xcb0b, LSL #0
    MOVK  X19, #0x47, LSL #16
    MOVK  X19, #0xcb0b, LSL #32
    MOVK  X19, #0x47, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D30
    MOVZ  X19, #0xcb0b, LSL #0
    MOVK  X19, #0x47, LSL #16
    MOVK  X19, #0xcb0b, LSL #32
    MOVK  X19, #0x47, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X19, #0xe14e, LSL #0
    MOVK  X19, #0xd, LSL #16
    MOVK  X19, #0xe14e, LSL #32
    MOVK  X19, #0xd, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X3, D31
    MOVZ  X19, #0xe14e, LSL #0
    MOVK  X19, #0xd, LSL #16
    MOVK  X19, #0xe14e, LSL #32
    MOVK  X19, #0xd, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
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
    FMOV  X3, D0
    MOVZ  X19, #0x7bd5, LSL #0
    MOVK  X19, #0x10, LSL #16
    MOVK  X19, #0x7bd5, LSL #32
    MOVK  X19, #0x30, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X3, D1
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X3, D2
    MOVZ  X19, #0xfe28, LSL #0
    MOVK  X19, #0x15, LSL #16
    MOVK  X19, #0xfe28, LSL #32
    MOVK  X19, #0x35, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P3, Z3.D
    FMOV  X3, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X3, D4
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P7, Z5.D
    FMOV  X3, D5
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X3, D6
    MOVZ  X19, #0x15e3, LSL #0
    MOVK  X19, #0x11, LSL #16
    MOVK  X19, #0x15e3, LSL #32
    MOVK  X19, #0x31, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X3, D7
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X3, D8
    MOVZ  X19, #0x71fa, LSL #0
    MOVK  X19, #0x20, LSL #16
    MOVK  X19, #0x71fa, LSL #32
    MOVK  X19, #0x40, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X3, D9
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X3, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X3, D11
    MOVZ  X19, #0x3353, LSL #0
    MOVK  X19, #0x1e, LSL #16
    MOVK  X19, #0x3353, LSL #32
    MOVK  X19, #0x3e, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X3, D12
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X3, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P7, Z14.D
    FMOV  X3, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X3, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X3, D16
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P0, Z17.D
    FMOV  X3, D17
    MOVZ  X19, #0xd0e8, LSL #0
    MOVK  X19, #0x1d, LSL #16
    MOVK  X19, #0xd0e8, LSL #32
    MOVK  X19, #0x3d, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P3, Z18.D
    FMOV  X3, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P5, Z19.D
    FMOV  X3, D19
    MOVZ  X19, #0x3b0f, LSL #0
    MOVK  X19, #0x11, LSL #16
    MOVK  X19, #0x3b0f, LSL #32
    MOVK  X19, #0x31, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P5, Z20.D
    FMOV  X3, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X3, D21
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X3, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P1, Z23.D
    FMOV  X3, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X3, D24
    MOVZ  X19, #0x85c5, LSL #0
    MOVK  X19, #0x13, LSL #16
    MOVK  X19, #0x85c5, LSL #32
    MOVK  X19, #0x33, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X3, D25
    MOVZ  X19, #0xfe5, LSL #0
    MOVK  X19, #0x14, LSL #16
    MOVK  X19, #0xfe5, LSL #32
    MOVK  X19, #0x34, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P4, Z26.D
    FMOV  X3, D26
    MOVZ  X19, #0x5742, LSL #0
    MOVK  X19, #0x22, LSL #16
    MOVK  X19, #0x5742, LSL #32
    MOVK  X19, #0x42, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X3, D27
    MOVZ  X19, #0x107, LSL #0
    MOVK  X19, #0x40, LSL #16
    MOVK  X19, #0x107, LSL #32
    MOVK  X19, #0x60, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X3, D28
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P0, Z29.D
    FMOV  X3, D29
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff8, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P3, Z30.D
    FMOV  X3, D30
    MOVZ  X19, #0xcb0b, LSL #0
    MOVK  X19, #0x47, LSL #16
    MOVK  X19, #0xcb0b, LSL #32
    MOVK  X19, #0x67, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X3, D31
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X21
    DUP     Z1.D, X3
    DUP     Z2.D, X22
    DUP     Z3.D, X29
    DUP     Z4.D, X8
    DUP     Z5.D, X19
    DUP     Z6.D, X23
    DUP     Z7.D, X10
    DUP     Z8.D, X9
    DUP     Z9.D, X16
    DUP     Z10.D, X20
    DUP     Z11.D, X13
    DUP     Z12.D, X21
    DUP     Z13.D, X7
    DUP     Z14.D, X5
    DUP     Z15.D, X22
    DUP     Z16.D, X18
    DUP     Z17.D, X19
    DUP     Z18.D, X17
    DUP     Z19.D, X23
    DUP     Z20.D, X20
    DUP     Z21.D, X3
    DUP     Z22.D, X16
    DUP     Z23.D, X7
    DUP     Z24.D, X10
    DUP     Z25.D, X2
    DUP     Z26.D, X10
    DUP     Z27.D, X15
    DUP     Z28.D, X12
    DUP     Z29.D, X23
    DUP     Z30.D, X6
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
    MOVZ  X4, #0xa, LSL #0
LCRTSveVectorI8MM_label_8:
    SUDOT Z30.S, Z0.B, Z0.B[0x1]
    SUDOT Z13.S, Z29.B, Z5.B[0x3]
    SMMLA Z31.S, Z25.B, Z21.B
    UMMLA Z31.S, Z6.B, Z13.B
    USMMLA Z9.S, Z31.B, Z31.B
    SUDOT Z30.S, Z1.B, Z1.B[0x2]
    SUDOT Z10.S, Z13.B, Z5.B[0x0]
    USDOT Z7.S, Z26.B, Z5.B[0x1]
    SUDOT Z28.S, Z10.B, Z3.B[0x2]
    SMMLA Z30.S, Z4.B, Z6.B
    USMMLA Z1.S, Z9.B, Z30.B
    UMMLA Z0.S, Z28.B, Z7.B
    USDOT Z16.S, Z17.B, Z3.B[0x0]
    USDOT Z6.S, Z13.B, Z6.B[0x0]
    USDOT Z5.S, Z13.B, Z1.B
    SUDOT Z3.S, Z8.B, Z0.B[0x3]
    SUDOT Z26.S, Z2.B, Z7.B[0x2]
    USDOT Z19.S, Z19.B, Z5.B[0x1]
    USDOT Z8.S, Z7.B, Z0.B[0x1]
    USDOT Z15.S, Z22.B, Z18.B
    SMMLA Z7.S, Z21.B, Z13.B
    SUDOT Z12.S, Z24.B, Z1.B[0x2]
    USMMLA Z13.S, Z3.B, Z6.B
    UMMLA Z19.S, Z16.B, Z0.B
    USMMLA Z22.S, Z31.B, Z26.B
    SMMLA Z22.S, Z22.B, Z22.B
    UMMLA Z29.S, Z25.B, Z19.B
    SUDOT Z22.S, Z17.B, Z4.B[0x3]
    USMMLA Z13.S, Z22.B, Z29.B
    USMMLA Z2.S, Z7.B, Z13.B
    UMMLA Z26.S, Z8.B, Z10.B
    USDOT Z12.S, Z1.B, Z26.B
    USMMLA Z15.S, Z2.B, Z2.B
    USMMLA Z29.S, Z18.B, Z13.B
    UMMLA Z3.S, Z18.B, Z12.B
    USMMLA Z27.S, Z13.B, Z22.B
    SUDOT Z28.S, Z10.B, Z0.B[0x2]
    UMMLA Z24.S, Z21.B, Z20.B
    USDOT Z21.S, Z7.B, Z7.B[0x2]
    UMMLA Z21.S, Z13.B, Z30.B
    USMMLA Z0.S, Z15.B, Z16.B
    USMMLA Z19.S, Z5.B, Z17.B
    SMMLA Z12.S, Z17.B, Z7.B
    SMMLA Z28.S, Z27.B, Z24.B
    USMMLA Z21.S, Z19.B, Z28.B
    SMMLA Z3.S, Z0.B, Z12.B
    USDOT Z25.S, Z29.B, Z2.B
    USDOT Z25.S, Z23.B, Z5.B[0x1]
    SMMLA Z21.S, Z4.B, Z30.B
    UMMLA Z12.S, Z3.B, Z3.B
    USDOT Z12.S, Z25.B, Z12.B
    SMMLA Z10.S, Z7.B, Z16.B
    SUDOT Z22.S, Z6.B, Z1.B[0x0]
    UMMLA Z16.S, Z5.B, Z28.B
    USDOT Z19.S, Z21.B, Z15.B
    USMMLA Z1.S, Z21.B, Z22.B
    USDOT Z13.S, Z4.B, Z11.B
    USDOT Z11.S, Z13.B, Z5.B[0x3]
    USMMLA Z22.S, Z6.B, Z28.B
    USDOT Z5.S, Z27.B, Z28.B
    USDOT Z2.S, Z18.B, Z19.B
    UMMLA Z27.S, Z14.B, Z2.B
    SMMLA Z24.S, Z9.B, Z3.B
    SMMLA Z22.S, Z24.B, Z11.B
    USMMLA Z8.S, Z22.B, Z16.B
    UMMLA Z30.S, Z10.B, Z15.B
    SMMLA Z8.S, Z18.B, Z17.B
    USDOT Z27.S, Z15.B, Z4.B[0x1]
    SMMLA Z27.S, Z6.B, Z14.B
    USDOT Z10.S, Z12.B, Z3.B[0x3]
    UMMLA Z19.S, Z30.B, Z28.B
    USMMLA Z27.S, Z1.B, Z27.B
    UMMLA Z28.S, Z6.B, Z15.B
    SMMLA Z29.S, Z8.B, Z21.B
    UMMLA Z19.S, Z27.B, Z3.B
    UMMLA Z29.S, Z13.B, Z19.B
    UMMLA Z10.S, Z9.B, Z3.B
    USMMLA Z10.S, Z5.B, Z10.B
    UMMLA Z7.S, Z10.B, Z6.B
    SMMLA Z27.S, Z12.B, Z28.B
    USDOT Z7.S, Z12.B, Z7.B[0x2]
    USDOT Z25.S, Z27.B, Z3.B[0x2]
    UMMLA Z20.S, Z8.B, Z7.B
    USDOT Z23.S, Z20.B, Z25.B
    USDOT Z15.S, Z26.B, Z2.B[0x0]
    USMMLA Z2.S, Z8.B, Z13.B
    USMMLA Z24.S, Z0.B, Z14.B
    UMMLA Z11.S, Z10.B, Z27.B
    USDOT Z26.S, Z30.B, Z4.B[0x3]
    UMMLA Z26.S, Z23.B, Z30.B
    USMMLA Z18.S, Z31.B, Z4.B
    SUDOT Z23.S, Z26.B, Z4.B[0x3]
    USMMLA Z29.S, Z24.B, Z7.B
    SMMLA Z11.S, Z28.B, Z27.B
    SUDOT Z30.S, Z9.B, Z6.B[0x3]
    SUDOT Z23.S, Z27.B, Z0.B[0x0]
    USDOT Z17.S, Z21.B, Z28.B
    USDOT Z0.S, Z20.B, Z7.B[0x3]
    SUDOT Z18.S, Z3.B, Z1.B[0x2]
    USDOT Z17.S, Z15.B, Z3.B[0x0]
    SMMLA Z30.S, Z30.B, Z17.B
    UMMLA Z16.S, Z9.B, Z1.B
    USDOT Z14.S, Z16.B, Z21.B
    UMMLA Z27.S, Z21.B, Z14.B
    USDOT Z11.S, Z0.B, Z1.B
    USDOT Z16.S, Z29.B, Z2.B[0x3]
    SUDOT Z23.S, Z18.B, Z4.B[0x2]
    SUDOT Z11.S, Z16.B, Z6.B[0x3]
    USDOT Z27.S, Z2.B, Z5.B[0x2]
    USDOT Z30.S, Z19.B, Z0.B[0x0]
    UMMLA Z27.S, Z18.B, Z30.B
    SUDOT Z23.S, Z11.B, Z5.B[0x0]
    USDOT Z11.S, Z30.B, Z7.B[0x2]
    SUDOT Z21.S, Z3.B, Z2.B[0x2]
    USMMLA Z26.S, Z28.B, Z30.B
    SUDOT Z18.S, Z7.B, Z7.B[0x2]
    UMMLA Z16.S, Z13.B, Z1.B
    USMMLA Z6.S, Z24.B, Z24.B
    SMMLA Z13.S, Z2.B, Z8.B
    SUDOT Z16.S, Z6.B, Z6.B[0x0]
    USDOT Z15.S, Z12.B, Z23.B
    USDOT Z1.S, Z13.B, Z27.B
    USMMLA Z21.S, Z21.B, Z18.B
    USDOT Z3.S, Z11.B, Z26.B
    USDOT Z8.S, Z5.B, Z3.B
    SUDOT Z15.S, Z17.B, Z1.B[0x0]
    SUDOT Z16.S, Z8.B, Z1.B[0x2]
    SMMLA Z26.S, Z9.B, Z25.B
    USDOT Z21.S, Z16.B, Z3.B[0x2]
    USDOT Z26.S, Z15.B, Z1.B[0x0]
    SMMLA Z3.S, Z4.B, Z25.B
    USDOT Z18.S, Z11.B, Z15.B
    USDOT Z15.S, Z21.B, Z5.B[0x2]
    UMMLA Z1.S, Z23.B, Z9.B
    UMMLA Z8.S, Z27.B, Z18.B
    SMMLA Z11.S, Z4.B, Z10.B
    SMMLA Z30.S, Z14.B, Z6.B
    UMMLA Z1.S, Z4.B, Z13.B
    USMMLA Z16.S, Z5.B, Z31.B
    USMMLA Z21.S, Z9.B, Z11.B
    UMMLA Z9.S, Z29.B, Z25.B
    SMMLA Z3.S, Z9.B, Z15.B
    USDOT Z16.S, Z8.B, Z16.B
    USDOT Z26.S, Z16.B, Z26.B
    SMMLA Z26.S, Z3.B, Z30.B
    SMMLA Z1.S, Z1.B, Z21.B
    UMMLA Z26.S, Z0.B, Z8.B
    UMMLA Z10.S, Z17.B, Z22.B
    SUDOT Z31.S, Z5.B, Z5.B[0x1]
    UMMLA Z14.S, Z16.B, Z14.B
    UMMLA Z3.S, Z11.B, Z1.B
    SMMLA Z25.S, Z5.B, Z3.B
    USDOT Z7.S, Z11.B, Z30.B
    USMMLA Z7.S, Z17.B, Z22.B
    SMMLA Z22.S, Z31.B, Z25.B
    UMMLA Z4.S, Z11.B, Z0.B
    USMMLA Z26.S, Z3.B, Z3.B
    USDOT Z0.S, Z16.B, Z5.B
    SUDOT Z9.S, Z22.B, Z5.B[0x0]
    SMMLA Z31.S, Z13.B, Z7.B
    USDOT Z14.S, Z25.B, Z1.B[0x0]
    SUDOT Z2.S, Z25.B, Z6.B[0x3]
    SMMLA Z7.S, Z1.B, Z27.B
    UMMLA Z10.S, Z17.B, Z5.B
    SUDOT Z14.S, Z10.B, Z5.B[0x3]
    USMMLA Z7.S, Z27.B, Z2.B
    SUDOT Z0.S, Z0.B, Z4.B[0x0]
    USMMLA Z14.S, Z5.B, Z0.B
    SMMLA Z7.S, Z15.B, Z18.B
    UMMLA Z31.S, Z15.B, Z31.B
    USDOT Z7.S, Z11.B, Z20.B
    SUDOT Z23.S, Z10.B, Z4.B[0x1]
    USDOT Z31.S, Z7.B, Z7.B[0x1]
    USDOT Z9.S, Z31.B, Z2.B[0x3]
    UMMLA Z26.S, Z14.B, Z2.B
    UMMLA Z23.S, Z9.B, Z9.B
    USDOT Z27.S, Z17.B, Z0.B[0x0]
    SUDOT Z24.S, Z10.B, Z2.B[0x2]
    UMMLA Z12.S, Z9.B, Z12.B
    USMMLA Z14.S, Z18.B, Z26.B
    USDOT Z16.S, Z2.B, Z7.B
    USDOT Z25.S, Z5.B, Z19.B
    USMMLA Z4.S, Z15.B, Z29.B
    USMMLA Z30.S, Z4.B, Z19.B
    SUDOT Z27.S, Z17.B, Z0.B[0x0]
    SMMLA Z13.S, Z1.B, Z23.B
    USDOT Z31.S, Z18.B, Z7.B[0x3]
    USDOT Z25.S, Z30.B, Z3.B[0x1]
    SUDOT Z31.S, Z27.B, Z0.B[0x3]
    SUDOT Z8.S, Z25.B, Z4.B[0x3]
    USDOT Z13.S, Z9.B, Z5.B[0x2]
    USDOT Z13.S, Z14.B, Z3.B[0x2]
    SUDOT Z24.S, Z6.B, Z3.B[0x1]
    USDOT Z9.S, Z13.B, Z22.B
    SUDOT Z31.S, Z31.B, Z2.B[0x0]
    USDOT Z24.S, Z24.B, Z7.B[0x2]
    UMMLA Z16.S, Z19.B, Z9.B
    SMMLA Z16.S, Z25.B, Z20.B
    UMMLA Z15.S, Z28.B, Z23.B
    SUDOT Z12.S, Z31.B, Z6.B[0x1]
    SUBS  X4, X4, #0x1
    B.NE  LCRTSveVectorI8MM_label_8
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTSveVectorI8MM_TestFail
    MRS  X2, FPSR
    MOVZ  X23, #0x80, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X23, #0xffed, LSL #0
    MOVK  X23, #0x5a75, LSL #16
    MOVK  X23, #0xffed, LSL #32
    MOVK  X23, #0x5a75, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D0
    MOVZ  X23, #0xffed, LSL #0
    MOVK  X23, #0x5a75, LSL #16
    MOVK  X23, #0xffed, LSL #32
    MOVK  X23, #0x5a75, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X23, #0x6943, LSL #0
    MOVK  X23, #0x5a82, LSL #16
    MOVK  X23, #0x6943, LSL #32
    MOVK  X23, #0x5a82, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D1
    MOVZ  X23, #0x6943, LSL #0
    MOVK  X23, #0x5a82, LSL #16
    MOVK  X23, #0x6943, LSL #32
    MOVK  X23, #0x5a82, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X23, #0xc566, LSL #0
    MOVK  X23, #0x5a6b, LSL #16
    MOVK  X23, #0xc566, LSL #32
    MOVK  X23, #0x5a6b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D2
    MOVZ  X23, #0xc566, LSL #0
    MOVK  X23, #0x5a6b, LSL #16
    MOVK  X23, #0xc566, LSL #32
    MOVK  X23, #0x5a6b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X23, #0xcc1c, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0xcc1c, LSL #32
    MOVK  X23, #0x5a8e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D3
    MOVZ  X23, #0xcc1c, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0xcc1c, LSL #32
    MOVK  X23, #0x5a8e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X23, #0xd140, LSL #0
    MOVK  X23, #0x5a6d, LSL #16
    MOVK  X23, #0xd140, LSL #32
    MOVK  X23, #0x5a6d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D4
    MOVZ  X23, #0xd140, LSL #0
    MOVK  X23, #0x5a6d, LSL #16
    MOVK  X23, #0xd140, LSL #32
    MOVK  X23, #0x5a6d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X23, #0x9084, LSL #0
    MOVK  X23, #0x5a5d, LSL #16
    MOVK  X23, #0x9084, LSL #32
    MOVK  X23, #0x5a5d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D5
    MOVZ  X23, #0x9084, LSL #0
    MOVK  X23, #0x5a5d, LSL #16
    MOVK  X23, #0x9084, LSL #32
    MOVK  X23, #0x5a5d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X23, #0xd760, LSL #0
    MOVK  X23, #0x5a60, LSL #16
    MOVK  X23, #0xd760, LSL #32
    MOVK  X23, #0x5a60, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D6
    MOVZ  X23, #0xd760, LSL #0
    MOVK  X23, #0x5a60, LSL #16
    MOVK  X23, #0xd760, LSL #32
    MOVK  X23, #0x5a60, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X23, #0xd4b9, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0xd4b9, LSL #32
    MOVK  X23, #0x5a8e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D7
    MOVZ  X23, #0xd4b9, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0xd4b9, LSL #32
    MOVK  X23, #0x5a8e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X23, #0x5d0d, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0x5d0d, LSL #32
    MOVK  X23, #0x5a74, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D8
    MOVZ  X23, #0x5d0d, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0x5d0d, LSL #32
    MOVK  X23, #0x5a74, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X23, #0x207a, LSL #0
    MOVK  X23, #0x5a7a, LSL #16
    MOVK  X23, #0x207a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D9
    MOVZ  X23, #0x207a, LSL #0
    MOVK  X23, #0x5a7a, LSL #16
    MOVK  X23, #0x207a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X23, #0x3fd6, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0x3fd6, LSL #32
    MOVK  X23, #0x5a8e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D10
    MOVZ  X23, #0x3fd6, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0x3fd6, LSL #32
    MOVK  X23, #0x5a8e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X23, #0x2e1e, LSL #0
    MOVK  X23, #0x5a7b, LSL #16
    MOVK  X23, #0x2e1e, LSL #32
    MOVK  X23, #0x5a7b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D11
    MOVZ  X23, #0x2e1e, LSL #0
    MOVK  X23, #0x5a7b, LSL #16
    MOVK  X23, #0x2e1e, LSL #32
    MOVK  X23, #0x5a7b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X23, #0x4ae2, LSL #0
    MOVK  X23, #0x5a8a, LSL #16
    MOVK  X23, #0x4ae2, LSL #32
    MOVK  X23, #0x5a8a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D12
    MOVZ  X23, #0x4ae2, LSL #0
    MOVK  X23, #0x5a8a, LSL #16
    MOVK  X23, #0x4ae2, LSL #32
    MOVK  X23, #0x5a8a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X23, #0xba12, LSL #0
    MOVK  X23, #0x5a7b, LSL #16
    MOVK  X23, #0xba12, LSL #32
    MOVK  X23, #0x5a7b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D13
    MOVZ  X23, #0xba12, LSL #0
    MOVK  X23, #0x5a7b, LSL #16
    MOVK  X23, #0xba12, LSL #32
    MOVK  X23, #0x5a7b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X23, #0xd936, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0xd936, LSL #32
    MOVK  X23, #0x5a74, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D14
    MOVZ  X23, #0xd936, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0xd936, LSL #32
    MOVK  X23, #0x5a74, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X23, #0xcbfa, LSL #0
    MOVK  X23, #0x5a78, LSL #16
    MOVK  X23, #0xcbfa, LSL #32
    MOVK  X23, #0x5a78, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D15
    MOVZ  X23, #0xcbfa, LSL #0
    MOVK  X23, #0x5a78, LSL #16
    MOVK  X23, #0xcbfa, LSL #32
    MOVK  X23, #0x5a78, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X23, #0xfd86, LSL #0
    MOVK  X23, #0x5aad, LSL #16
    MOVK  X23, #0xfd86, LSL #32
    MOVK  X23, #0x5aad, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D16
    MOVZ  X23, #0xfd86, LSL #0
    MOVK  X23, #0x5aad, LSL #16
    MOVK  X23, #0xfd86, LSL #32
    MOVK  X23, #0x5aad, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X23, #0xd03b, LSL #0
    MOVK  X23, #0x5a5d, LSL #16
    MOVK  X23, #0xd03b, LSL #32
    MOVK  X23, #0x5a5d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D17
    MOVZ  X23, #0xd03b, LSL #0
    MOVK  X23, #0x5a5d, LSL #16
    MOVK  X23, #0xd03b, LSL #32
    MOVK  X23, #0x5a5d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0xc8cf, LSL #0
    MOVK  X23, #0x5a65, LSL #16
    MOVK  X23, #0xc8cf, LSL #32
    MOVK  X23, #0x5a65, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0xc8cf, LSL #0
    MOVK  X23, #0x5a65, LSL #16
    MOVK  X23, #0xc8cf, LSL #32
    MOVK  X23, #0x5a65, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X23, #0x1186, LSL #0
    MOVK  X23, #0x5a9e, LSL #16
    MOVK  X23, #0x1186, LSL #32
    MOVK  X23, #0x5a9e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D19
    MOVZ  X23, #0x1186, LSL #0
    MOVK  X23, #0x5a9e, LSL #16
    MOVK  X23, #0x1186, LSL #32
    MOVK  X23, #0x5a9e, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X23, #0x5822, LSL #0
    MOVK  X23, #0x5a6a, LSL #16
    MOVK  X23, #0x5822, LSL #32
    MOVK  X23, #0x5a6a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D20
    MOVZ  X23, #0x5822, LSL #0
    MOVK  X23, #0x5a6a, LSL #16
    MOVK  X23, #0x5822, LSL #32
    MOVK  X23, #0x5a6a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X23, #0x1f6c, LSL #0
    MOVK  X23, #0x5a7c, LSL #16
    MOVK  X23, #0x1f6c, LSL #32
    MOVK  X23, #0x5a7c, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D21
    MOVZ  X23, #0x1f6c, LSL #0
    MOVK  X23, #0x5a7c, LSL #16
    MOVK  X23, #0x1f6c, LSL #32
    MOVK  X23, #0x5a7c, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X23, #0xb42e, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0xb42e, LSL #32
    MOVK  X23, #0x5a74, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D22
    MOVZ  X23, #0xb42e, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0xb42e, LSL #32
    MOVK  X23, #0x5a74, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X23, #0x6495, LSL #0
    MOVK  X23, #0x5a79, LSL #16
    MOVK  X23, #0x6495, LSL #32
    MOVK  X23, #0x5a79, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D23
    MOVZ  X23, #0x6495, LSL #0
    MOVK  X23, #0x5a79, LSL #16
    MOVK  X23, #0x6495, LSL #32
    MOVK  X23, #0x5a79, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X23, #0x58a8, LSL #0
    MOVK  X23, #0x5a76, LSL #16
    MOVK  X23, #0x58a8, LSL #32
    MOVK  X23, #0x5a76, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D24
    MOVZ  X23, #0x58a8, LSL #0
    MOVK  X23, #0x5a76, LSL #16
    MOVK  X23, #0x58a8, LSL #32
    MOVK  X23, #0x5a76, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X23, #0x411a, LSL #0
    MOVK  X23, #0x5a66, LSL #16
    MOVK  X23, #0x411a, LSL #32
    MOVK  X23, #0x5a66, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D25
    MOVZ  X23, #0x411a, LSL #0
    MOVK  X23, #0x5a66, LSL #16
    MOVK  X23, #0x411a, LSL #32
    MOVK  X23, #0x5a66, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X23, #0x2f16, LSL #0
    MOVK  X23, #0x5ab6, LSL #16
    MOVK  X23, #0x2f16, LSL #32
    MOVK  X23, #0x5ab6, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D26
    MOVZ  X23, #0x2f16, LSL #0
    MOVK  X23, #0x5ab6, LSL #16
    MOVK  X23, #0x2f16, LSL #32
    MOVK  X23, #0x5ab6, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X23, #0xb629, LSL #0
    MOVK  X23, #0x5aa9, LSL #16
    MOVK  X23, #0xb629, LSL #32
    MOVK  X23, #0x5aa9, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D27
    MOVZ  X23, #0xb629, LSL #0
    MOVK  X23, #0x5aa9, LSL #16
    MOVK  X23, #0xb629, LSL #32
    MOVK  X23, #0x5aa9, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X23, #0xf68e, LSL #0
    MOVK  X23, #0x5a6b, LSL #16
    MOVK  X23, #0xf68e, LSL #32
    MOVK  X23, #0x5a6b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D28
    MOVZ  X23, #0xf68e, LSL #0
    MOVK  X23, #0x5a6b, LSL #16
    MOVK  X23, #0xf68e, LSL #32
    MOVK  X23, #0x5a6b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X23, #0xf36, LSL #0
    MOVK  X23, #0x5a8c, LSL #16
    MOVK  X23, #0xf36, LSL #32
    MOVK  X23, #0x5a8c, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D29
    MOVZ  X23, #0xf36, LSL #0
    MOVK  X23, #0x5a8c, LSL #16
    MOVK  X23, #0xf36, LSL #32
    MOVK  X23, #0x5a8c, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X23, #0x5a40, LSL #0
    MOVK  X23, #0x5a86, LSL #16
    MOVK  X23, #0x5a40, LSL #32
    MOVK  X23, #0x5a86, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D30
    MOVZ  X23, #0x5a40, LSL #0
    MOVK  X23, #0x5a86, LSL #16
    MOVK  X23, #0x5a40, LSL #32
    MOVK  X23, #0x5a86, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X23, #0xb82d, LSL #0
    MOVK  X23, #0x5a8d, LSL #16
    MOVK  X23, #0xb82d, LSL #32
    MOVK  X23, #0x5a8d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FMOV  X2, D31
    MOVZ  X23, #0xb82d, LSL #0
    MOVK  X23, #0x5a8d, LSL #16
    MOVK  X23, #0xb82d, LSL #32
    MOVK  X23, #0x5a8d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
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
    FMOV  X2, D0
    MOVZ  X23, #0xffed, LSL #0
    MOVK  X23, #0x5a75, LSL #16
    MOVK  X23, #0xffed, LSL #32
    MOVK  X23, #0x5a95, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X2, D1
    MOVZ  X23, #0x6943, LSL #0
    MOVK  X23, #0x5a82, LSL #16
    MOVK  X23, #0x6943, LSL #32
    MOVK  X23, #0x5aa2, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X2, D2
    MOVZ  X23, #0xc566, LSL #0
    MOVK  X23, #0x5a6b, LSL #16
    MOVK  X23, #0xc566, LSL #32
    MOVK  X23, #0x5a8b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P6, Z3.D
    FMOV  X2, D3
    MOVZ  X23, #0xcc1c, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0xcc1c, LSL #32
    MOVK  X23, #0x5aae, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X2, D4
    MOVZ  X23, #0xd140, LSL #0
    MOVK  X23, #0x5a6d, LSL #16
    MOVK  X23, #0xd140, LSL #32
    MOVK  X23, #0x5a8d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X2, D5
    MOVZ  X23, #0x9084, LSL #0
    MOVK  X23, #0x5a5d, LSL #16
    MOVK  X23, #0x9084, LSL #32
    MOVK  X23, #0x5a7d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X2, D6
    MOVZ  X23, #0xd760, LSL #0
    MOVK  X23, #0x5a60, LSL #16
    MOVK  X23, #0xd760, LSL #32
    MOVK  X23, #0x5a80, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X2, D7
    MOVZ  X23, #0xd4b9, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0xd4b9, LSL #32
    MOVK  X23, #0x5aae, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P7, Z8.D
    FMOV  X2, D8
    MOVZ  X23, #0x5d0d, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0x5d0d, LSL #32
    MOVK  X23, #0x5a94, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X2, D9
    MOVZ  X23, #0x207a, LSL #0
    MOVK  X23, #0x5a7a, LSL #16
    MOVK  X23, #0x207a, LSL #32
    MOVK  X23, #0x5a9a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X2, D10
    MOVZ  X23, #0x3fd6, LSL #0
    MOVK  X23, #0x5a8e, LSL #16
    MOVK  X23, #0x3fd6, LSL #32
    MOVK  X23, #0x5aae, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X2, D11
    MOVZ  X23, #0x2e1e, LSL #0
    MOVK  X23, #0x5a7b, LSL #16
    MOVK  X23, #0x2e1e, LSL #32
    MOVK  X23, #0x5a9b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X2, D12
    MOVZ  X23, #0x4ae2, LSL #0
    MOVK  X23, #0x5a8a, LSL #16
    MOVK  X23, #0x4ae2, LSL #32
    MOVK  X23, #0x5aaa, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X2, D13
    MOVZ  X23, #0xba12, LSL #0
    MOVK  X23, #0x5a7b, LSL #16
    MOVK  X23, #0xba12, LSL #32
    MOVK  X23, #0x5a9b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X2, D14
    MOVZ  X23, #0xd936, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0xd936, LSL #32
    MOVK  X23, #0x5a94, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X2, D15
    MOVZ  X23, #0xcbfa, LSL #0
    MOVK  X23, #0x5a78, LSL #16
    MOVK  X23, #0xcbfa, LSL #32
    MOVK  X23, #0x5a98, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X2, D16
    MOVZ  X23, #0xfd86, LSL #0
    MOVK  X23, #0x5aad, LSL #16
    MOVK  X23, #0xfd86, LSL #32
    MOVK  X23, #0x5acd, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X2, D17
    MOVZ  X23, #0xd03b, LSL #0
    MOVK  X23, #0x5a5d, LSL #16
    MOVK  X23, #0xd03b, LSL #32
    MOVK  X23, #0x5a7d, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X2, D18
    MOVZ  X23, #0xc8cf, LSL #0
    MOVK  X23, #0x5a65, LSL #16
    MOVK  X23, #0xc8cf, LSL #32
    MOVK  X23, #0x5a85, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X2, D19
    MOVZ  X23, #0x1186, LSL #0
    MOVK  X23, #0x5a9e, LSL #16
    MOVK  X23, #0x1186, LSL #32
    MOVK  X23, #0x5abe, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P7, Z20.D
    FMOV  X2, D20
    MOVZ  X23, #0x5822, LSL #0
    MOVK  X23, #0x5a6a, LSL #16
    MOVK  X23, #0x5822, LSL #32
    MOVK  X23, #0x5a8a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X2, D21
    MOVZ  X23, #0x1f6c, LSL #0
    MOVK  X23, #0x5a7c, LSL #16
    MOVK  X23, #0x1f6c, LSL #32
    MOVK  X23, #0x5a9c, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X2, D22
    MOVZ  X23, #0xb42e, LSL #0
    MOVK  X23, #0x5a74, LSL #16
    MOVK  X23, #0xb42e, LSL #32
    MOVK  X23, #0x5a94, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X2, D23
    MOVZ  X23, #0x6495, LSL #0
    MOVK  X23, #0x5a79, LSL #16
    MOVK  X23, #0x6495, LSL #32
    MOVK  X23, #0x5a99, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X2, D24
    MOVZ  X23, #0x58a8, LSL #0
    MOVK  X23, #0x5a76, LSL #16
    MOVK  X23, #0x58a8, LSL #32
    MOVK  X23, #0x5a96, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P7, Z25.D
    FMOV  X2, D25
    MOVZ  X23, #0x411a, LSL #0
    MOVK  X23, #0x5a66, LSL #16
    MOVK  X23, #0x411a, LSL #32
    MOVK  X23, #0x5a86, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X2, D26
    MOVZ  X23, #0x2f16, LSL #0
    MOVK  X23, #0x5ab6, LSL #16
    MOVK  X23, #0x2f16, LSL #32
    MOVK  X23, #0x5ad6, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P7, Z27.D
    FMOV  X2, D27
    MOVZ  X23, #0xb629, LSL #0
    MOVK  X23, #0x5aa9, LSL #16
    MOVK  X23, #0xb629, LSL #32
    MOVK  X23, #0x5ac9, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X2, D28
    MOVZ  X23, #0xf68e, LSL #0
    MOVK  X23, #0x5a6b, LSL #16
    MOVK  X23, #0xf68e, LSL #32
    MOVK  X23, #0x5a8b, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X2, D29
    MOVZ  X23, #0xf36, LSL #0
    MOVK  X23, #0x5a8c, LSL #16
    MOVK  X23, #0xf36, LSL #32
    MOVK  X23, #0x5aac, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X2, D30
    MOVZ  X23, #0x5a40, LSL #0
    MOVK  X23, #0x5a86, LSL #16
    MOVK  X23, #0x5a40, LSL #32
    MOVK  X23, #0x5aa6, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X2, D31
    MOVZ  X23, #0xb82d, LSL #0
    MOVK  X23, #0x5a8d, LSL #16
    MOVK  X23, #0xb82d, LSL #32
    MOVK  X23, #0x5aad, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X20
    DUP     Z1.D, X17
    DUP     Z2.D, X20
    DUP     Z3.D, X19
    DUP     Z4.D, X23
    DUP     Z5.D, X22
    DUP     Z6.D, X29
    DUP     Z7.D, X19
    DUP     Z8.D, X9
    DUP     Z9.D, X18
    DUP     Z10.D, X4
    DUP     Z11.D, X23
    DUP     Z12.D, X14
    DUP     Z13.D, X20
    DUP     Z14.D, X23
    DUP     Z15.D, X29
    DUP     Z16.D, X14
    DUP     Z17.D, X8
    DUP     Z18.D, X3
    DUP     Z19.D, X12
    DUP     Z20.D, X14
    DUP     Z21.D, X4
    DUP     Z22.D, X17
    DUP     Z23.D, X20
    DUP     Z24.D, X7
    DUP     Z25.D, X20
    DUP     Z26.D, X10
    DUP     Z27.D, X23
    DUP     Z28.D, X14
    DUP     Z29.D, X11
    DUP     Z30.D, X11
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
    MOVZ  X12, #0xa, LSL #0
LCRTSveVectorI8MM_label_9:
    SMMLA Z31.S, Z28.B, Z28.B
    USDOT Z28.S, Z31.B, Z24.B
    SMMLA Z28.S, Z25.B, Z7.B
    USMMLA Z28.S, Z22.B, Z6.B
    SMMLA Z12.S, Z28.B, Z30.B
    SUDOT Z12.S, Z20.B, Z4.B[0x0]
    USDOT Z23.S, Z12.B, Z12.B
    SMMLA Z23.S, Z23.B, Z23.B
    SUDOT Z23.S, Z28.B, Z6.B[0x1]
    USDOT Z23.S, Z23.B, Z3.B[0x3]
    USDOT Z23.S, Z27.B, Z1.B[0x3]
    SMMLA Z3.S, Z23.B, Z6.B
    USDOT Z15.S, Z8.B, Z31.B
    UMMLA Z25.S, Z28.B, Z18.B
    UMMLA Z30.S, Z5.B, Z28.B
    USDOT Z4.S, Z31.B, Z23.B
    SMMLA Z29.S, Z29.B, Z10.B
    USDOT Z7.S, Z21.B, Z4.B[0x0]
    UMMLA Z10.S, Z7.B, Z19.B
    SMMLA Z10.S, Z3.B, Z19.B
    USMMLA Z7.S, Z22.B, Z30.B
    SMMLA Z31.S, Z15.B, Z24.B
    USMMLA Z0.S, Z21.B, Z26.B
    SMMLA Z25.S, Z20.B, Z15.B
    UMMLA Z6.S, Z9.B, Z22.B
    SUDOT Z20.S, Z25.B, Z0.B[0x1]
    USDOT Z21.S, Z26.B, Z0.B
    UMMLA Z14.S, Z18.B, Z20.B
    USDOT Z25.S, Z14.B, Z25.B
    USMMLA Z22.S, Z30.B, Z13.B
    SUDOT Z14.S, Z24.B, Z0.B[0x0]
    USDOT Z31.S, Z29.B, Z6.B[0x0]
    USDOT Z7.S, Z31.B, Z7.B[0x3]
    SUDOT Z10.S, Z7.B, Z7.B[0x0]
    SUDOT Z21.S, Z25.B, Z0.B[0x3]
    SUDOT Z14.S, Z22.B, Z5.B[0x0]
    USDOT Z23.S, Z10.B, Z21.B
    UMMLA Z5.S, Z30.B, Z1.B
    SUDOT Z26.S, Z5.B, Z0.B[0x1]
    UMMLA Z18.S, Z24.B, Z16.B
    SMMLA Z7.S, Z26.B, Z7.B
    UMMLA Z19.S, Z29.B, Z3.B
    USDOT Z15.S, Z28.B, Z0.B[0x2]
    UMMLA Z24.S, Z10.B, Z18.B
    USMMLA Z22.S, Z2.B, Z6.B
    SMMLA Z24.S, Z27.B, Z27.B
    UMMLA Z5.S, Z3.B, Z5.B
    USDOT Z15.S, Z8.B, Z18.B
    SMMLA Z15.S, Z24.B, Z30.B
    SUDOT Z0.S, Z28.B, Z6.B[0x2]
    SUDOT Z16.S, Z10.B, Z7.B[0x0]
    UMMLA Z25.S, Z12.B, Z24.B
    SMMLA Z15.S, Z2.B, Z23.B
    SMMLA Z5.S, Z25.B, Z5.B
    USDOT Z14.S, Z15.B, Z6.B[0x2]
    USDOT Z13.S, Z22.B, Z5.B[0x2]
    UMMLA Z16.S, Z4.B, Z19.B
    SUDOT Z16.S, Z24.B, Z2.B[0x1]
    SMMLA Z5.S, Z27.B, Z0.B
    USMMLA Z13.S, Z14.B, Z13.B
    USDOT Z11.S, Z13.B, Z7.B
    USDOT Z5.S, Z2.B, Z4.B[0x3]
    USDOT Z11.S, Z11.B, Z1.B
    SMMLA Z7.S, Z5.B, Z5.B
    USDOT Z13.S, Z24.B, Z11.B
    USDOT Z16.S, Z13.B, Z7.B
    SUDOT Z1.S, Z9.B, Z0.B[0x3]
    USDOT Z8.S, Z11.B, Z27.B
    USDOT Z6.S, Z13.B, Z4.B
    SMMLA Z1.S, Z10.B, Z7.B
    USMMLA Z25.S, Z13.B, Z29.B
    SUDOT Z28.S, Z24.B, Z3.B[0x2]
    SMMLA Z2.S, Z20.B, Z24.B
    USDOT Z13.S, Z0.B, Z3.B[0x1]
    USDOT Z28.S, Z2.B, Z6.B[0x0]
    USDOT Z23.S, Z27.B, Z23.B
    SUDOT Z28.S, Z9.B, Z3.B[0x0]
    SMMLA Z27.S, Z13.B, Z27.B
    USMMLA Z26.S, Z5.B, Z27.B
    USDOT Z7.S, Z11.B, Z0.B
    UMMLA Z10.S, Z24.B, Z21.B
    SUDOT Z17.S, Z28.B, Z1.B[0x0]
    USDOT Z16.S, Z17.B, Z4.B
    USDOT Z4.S, Z17.B, Z22.B
    SUDOT Z3.S, Z16.B, Z7.B[0x3]
    SMMLA Z27.S, Z10.B, Z8.B
    UMMLA Z23.S, Z10.B, Z26.B
    USMMLA Z5.S, Z23.B, Z3.B
    USDOT Z16.S, Z27.B, Z27.B
    USDOT Z20.S, Z4.B, Z2.B
    SMMLA Z5.S, Z16.B, Z5.B
    SUDOT Z5.S, Z20.B, Z5.B[0x3]
    SUDOT Z2.S, Z6.B, Z7.B[0x2]
    USDOT Z16.S, Z14.B, Z13.B
    SMMLA Z29.S, Z27.B, Z13.B
    UMMLA Z6.S, Z2.B, Z17.B
    USDOT Z21.S, Z8.B, Z29.B
    UMMLA Z6.S, Z7.B, Z7.B
    USMMLA Z5.S, Z2.B, Z23.B
    USDOT Z24.S, Z16.B, Z3.B
    UMMLA Z17.S, Z19.B, Z13.B
    USDOT Z7.S, Z20.B, Z4.B[0x3]
    UMMLA Z8.S, Z7.B, Z8.B
    USDOT Z29.S, Z19.B, Z29.B
    USMMLA Z27.S, Z28.B, Z15.B
    USDOT Z7.S, Z24.B, Z3.B
    USDOT Z25.S, Z11.B, Z5.B[0x3]
    USMMLA Z18.S, Z1.B, Z0.B
    USDOT Z26.S, Z27.B, Z9.B
    USMMLA Z8.S, Z17.B, Z17.B
    USMMLA Z25.S, Z21.B, Z26.B
    USMMLA Z11.S, Z24.B, Z7.B
    USDOT Z4.S, Z18.B, Z6.B[0x2]
    USMMLA Z7.S, Z25.B, Z4.B
    SMMLA Z7.S, Z15.B, Z29.B
    USDOT Z8.S, Z10.B, Z7.B[0x0]
    SUDOT Z12.S, Z31.B, Z5.B[0x1]
    USMMLA Z7.S, Z18.B, Z15.B
    USMMLA Z12.S, Z16.B, Z8.B
    USDOT Z20.S, Z21.B, Z17.B
    SUDOT Z1.S, Z2.B, Z3.B[0x1]
    USDOT Z15.S, Z22.B, Z10.B
    SUDOT Z30.S, Z22.B, Z1.B[0x3]
    UMMLA Z31.S, Z19.B, Z27.B
    USMMLA Z5.S, Z20.B, Z21.B
    USDOT Z28.S, Z19.B, Z0.B[0x2]
    USDOT Z16.S, Z16.B, Z27.B
    UMMLA Z7.S, Z11.B, Z11.B
    USMMLA Z26.S, Z5.B, Z28.B
    UMMLA Z9.S, Z15.B, Z31.B
    USDOT Z9.S, Z4.B, Z7.B
    SUDOT Z12.S, Z14.B, Z2.B[0x2]
    SUDOT Z9.S, Z30.B, Z1.B[0x2]
    UMMLA Z30.S, Z23.B, Z15.B
    SMMLA Z11.S, Z9.B, Z12.B
    SUDOT Z16.S, Z26.B, Z0.B[0x1]
    USDOT Z2.S, Z30.B, Z5.B[0x2]
    UMMLA Z2.S, Z2.B, Z11.B
    SUDOT Z2.S, Z30.B, Z2.B[0x1]
    SMMLA Z22.S, Z25.B, Z16.B
    SMMLA Z9.S, Z30.B, Z20.B
    SMMLA Z3.S, Z16.B, Z24.B
    USMMLA Z4.S, Z23.B, Z7.B
    USDOT Z28.S, Z25.B, Z5.B[0x3]
    SUDOT Z9.S, Z30.B, Z5.B[0x0]
    UMMLA Z4.S, Z23.B, Z8.B
    USMMLA Z16.S, Z25.B, Z26.B
    SMMLA Z31.S, Z12.B, Z27.B
    SUDOT Z27.S, Z18.B, Z1.B[0x2]
    SMMLA Z22.S, Z16.B, Z9.B
    USMMLA Z28.S, Z4.B, Z6.B
    USDOT Z22.S, Z24.B, Z28.B
    SUDOT Z29.S, Z22.B, Z1.B[0x2]
    SUDOT Z7.S, Z2.B, Z2.B[0x1]
    USDOT Z3.S, Z30.B, Z29.B
    USMMLA Z7.S, Z2.B, Z27.B
    USDOT Z5.S, Z31.B, Z31.B
    SMMLA Z7.S, Z4.B, Z7.B
    USDOT Z31.S, Z30.B, Z21.B
    USMMLA Z31.S, Z7.B, Z3.B
    USMMLA Z3.S, Z20.B, Z10.B
    SUDOT Z15.S, Z24.B, Z6.B[0x0]
    USDOT Z19.S, Z1.B, Z6.B[0x1]
    USDOT Z19.S, Z30.B, Z3.B[0x0]
    USMMLA Z6.S, Z1.B, Z7.B
    USDOT Z18.S, Z24.B, Z6.B[0x3]
    USDOT Z5.S, Z11.B, Z1.B[0x3]
    SUDOT Z4.S, Z1.B, Z3.B[0x0]
    USDOT Z16.S, Z1.B, Z7.B
    USMMLA Z6.S, Z28.B, Z26.B
    SUDOT Z1.S, Z23.B, Z4.B[0x2]
    USDOT Z27.S, Z24.B, Z25.B
    USDOT Z15.S, Z0.B, Z5.B[0x1]
    USDOT Z16.S, Z27.B, Z6.B[0x0]
    USDOT Z31.S, Z27.B, Z1.B[0x2]
    SMMLA Z20.S, Z16.B, Z15.B
    USDOT Z13.S, Z11.B, Z0.B[0x0]
    SMMLA Z20.S, Z31.B, Z13.B
    USDOT Z18.S, Z21.B, Z7.B[0x3]
    UMMLA Z18.S, Z16.B, Z18.B
    USMMLA Z16.S, Z19.B, Z0.B
    UMMLA Z18.S, Z28.B, Z16.B
    SMMLA Z25.S, Z1.B, Z30.B
    SMMLA Z30.S, Z8.B, Z2.B
    USDOT Z4.S, Z27.B, Z22.B
    USDOT Z19.S, Z18.B, Z7.B[0x1]
    SMMLA Z13.S, Z19.B, Z10.B
    USDOT Z1.S, Z20.B, Z1.B[0x1]
    USDOT Z31.S, Z17.B, Z18.B
    SUDOT Z8.S, Z4.B, Z4.B[0x1]
    SMMLA Z24.S, Z26.B, Z1.B
    UMMLA Z30.S, Z2.B, Z24.B
    USMMLA Z10.S, Z21.B, Z30.B
    USDOT Z17.S, Z11.B, Z2.B[0x3]
    SMMLA Z1.S, Z13.B, Z7.B
    USMMLA Z27.S, Z14.B, Z5.B
    UMMLA Z21.S, Z18.B, Z26.B
    USDOT Z25.S, Z0.B, Z2.B[0x0]
    SMMLA Z17.S, Z8.B, Z4.B
    SMMLA Z10.S, Z29.B, Z25.B
    SUBS  X12, X12, #0x1
    B.NE  LCRTSveVectorI8MM_label_9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X29, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MRS  X11, FPSR
    MOVZ  X29, #0x80, LSL #0
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X29, #0x66be, LSL #0
    MOVK  X29, #0xa593, LSL #16
    MOVK  X29, #0x66be, LSL #32
    MOVK  X29, #0xa593, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D0
    MOVZ  X29, #0x66be, LSL #0
    MOVK  X29, #0xa593, LSL #16
    MOVK  X29, #0x66be, LSL #32
    MOVK  X29, #0xa593, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X29, #0xb649, LSL #0
    MOVK  X29, #0xa59b, LSL #16
    MOVK  X29, #0xb649, LSL #32
    MOVK  X29, #0xa59b, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D1
    MOVZ  X29, #0xb649, LSL #0
    MOVK  X29, #0xa59b, LSL #16
    MOVK  X29, #0xb649, LSL #32
    MOVK  X29, #0xa59b, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X29, #0x8436, LSL #0
    MOVK  X29, #0xa5b9, LSL #16
    MOVK  X29, #0x8436, LSL #32
    MOVK  X29, #0xa5b9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D2
    MOVZ  X29, #0x8436, LSL #0
    MOVK  X29, #0xa5b9, LSL #16
    MOVK  X29, #0x8436, LSL #32
    MOVK  X29, #0xa5b9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X29, #0x66b7, LSL #0
    MOVK  X29, #0xa5a0, LSL #16
    MOVK  X29, #0x66b7, LSL #32
    MOVK  X29, #0xa5a0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D3
    MOVZ  X29, #0x66b7, LSL #0
    MOVK  X29, #0xa5a0, LSL #16
    MOVK  X29, #0x66b7, LSL #32
    MOVK  X29, #0xa5a0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X29, #0xee10, LSL #0
    MOVK  X29, #0xa59d, LSL #16
    MOVK  X29, #0xee10, LSL #32
    MOVK  X29, #0xa59d, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D4
    MOVZ  X29, #0xee10, LSL #0
    MOVK  X29, #0xa59d, LSL #16
    MOVK  X29, #0xee10, LSL #32
    MOVK  X29, #0xa59d, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X29, #0x3327, LSL #0
    MOVK  X29, #0xa5c1, LSL #16
    MOVK  X29, #0x3327, LSL #32
    MOVK  X29, #0xa5c1, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D5
    MOVZ  X29, #0x3327, LSL #0
    MOVK  X29, #0xa5c1, LSL #16
    MOVK  X29, #0x3327, LSL #32
    MOVK  X29, #0xa5c1, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X29, #0xf09d, LSL #0
    MOVK  X29, #0xa5e9, LSL #16
    MOVK  X29, #0xf09d, LSL #32
    MOVK  X29, #0xa5e9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D6
    MOVZ  X29, #0xf09d, LSL #0
    MOVK  X29, #0xa5e9, LSL #16
    MOVK  X29, #0xf09d, LSL #32
    MOVK  X29, #0xa5e9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X29, #0x4f59, LSL #0
    MOVK  X29, #0xa59a, LSL #16
    MOVK  X29, #0x4f59, LSL #32
    MOVK  X29, #0xa59a, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D7
    MOVZ  X29, #0x4f59, LSL #0
    MOVK  X29, #0xa59a, LSL #16
    MOVK  X29, #0x4f59, LSL #32
    MOVK  X29, #0xa59a, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X29, #0x2a21, LSL #0
    MOVK  X29, #0xa5a3, LSL #16
    MOVK  X29, #0x2a21, LSL #32
    MOVK  X29, #0xa5a3, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D8
    MOVZ  X29, #0x2a21, LSL #0
    MOVK  X29, #0xa5a3, LSL #16
    MOVK  X29, #0x2a21, LSL #32
    MOVK  X29, #0xa5a3, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X29, #0x44a5, LSL #0
    MOVK  X29, #0xa5ba, LSL #16
    MOVK  X29, #0x44a5, LSL #32
    MOVK  X29, #0xa5ba, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D9
    MOVZ  X29, #0x44a5, LSL #0
    MOVK  X29, #0xa5ba, LSL #16
    MOVK  X29, #0x44a5, LSL #32
    MOVK  X29, #0xa5ba, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X29, #0xd230, LSL #0
    MOVK  X29, #0xa5de, LSL #16
    MOVK  X29, #0xd230, LSL #32
    MOVK  X29, #0xa5de, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D10
    MOVZ  X29, #0xd230, LSL #0
    MOVK  X29, #0xa5de, LSL #16
    MOVK  X29, #0xd230, LSL #32
    MOVK  X29, #0xa5de, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X29, #0x8289, LSL #0
    MOVK  X29, #0xa596, LSL #16
    MOVK  X29, #0x8289, LSL #32
    MOVK  X29, #0xa596, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D11
    MOVZ  X29, #0x8289, LSL #0
    MOVK  X29, #0xa596, LSL #16
    MOVK  X29, #0x8289, LSL #32
    MOVK  X29, #0xa596, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X29, #0xf264, LSL #0
    MOVK  X29, #0xa58f, LSL #16
    MOVK  X29, #0xf264, LSL #32
    MOVK  X29, #0xa58f, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D12
    MOVZ  X29, #0xf264, LSL #0
    MOVK  X29, #0xa58f, LSL #16
    MOVK  X29, #0xf264, LSL #32
    MOVK  X29, #0xa58f, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X29, #0xcde0, LSL #0
    MOVK  X29, #0xa58a, LSL #16
    MOVK  X29, #0xcde0, LSL #32
    MOVK  X29, #0xa58a, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D13
    MOVZ  X29, #0xcde0, LSL #0
    MOVK  X29, #0xa58a, LSL #16
    MOVK  X29, #0xcde0, LSL #32
    MOVK  X29, #0xa58a, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X29, #0x9cc7, LSL #0
    MOVK  X29, #0xa5b0, LSL #16
    MOVK  X29, #0x9cc7, LSL #32
    MOVK  X29, #0xa5b0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D14
    MOVZ  X29, #0x9cc7, LSL #0
    MOVK  X29, #0xa5b0, LSL #16
    MOVK  X29, #0x9cc7, LSL #32
    MOVK  X29, #0xa5b0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X29, #0x34c8, LSL #0
    MOVK  X29, #0xa599, LSL #16
    MOVK  X29, #0x34c8, LSL #32
    MOVK  X29, #0xa599, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D15
    MOVZ  X29, #0x34c8, LSL #0
    MOVK  X29, #0xa599, LSL #16
    MOVK  X29, #0x34c8, LSL #32
    MOVK  X29, #0xa599, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X29, #0x19c5, LSL #0
    MOVK  X29, #0xa57b, LSL #16
    MOVK  X29, #0x19c5, LSL #32
    MOVK  X29, #0xa57b, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D16
    MOVZ  X29, #0x19c5, LSL #0
    MOVK  X29, #0xa57b, LSL #16
    MOVK  X29, #0x19c5, LSL #32
    MOVK  X29, #0xa57b, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X29, #0x1018, LSL #0
    MOVK  X29, #0xa5b7, LSL #16
    MOVK  X29, #0x1018, LSL #32
    MOVK  X29, #0xa5b7, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D17
    MOVZ  X29, #0x1018, LSL #0
    MOVK  X29, #0xa5b7, LSL #16
    MOVK  X29, #0x1018, LSL #32
    MOVK  X29, #0xa5b7, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X29, #0xbf92, LSL #0
    MOVK  X29, #0xa5dd, LSL #16
    MOVK  X29, #0xbf92, LSL #32
    MOVK  X29, #0xa5dd, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D18
    MOVZ  X29, #0xbf92, LSL #0
    MOVK  X29, #0xa5dd, LSL #16
    MOVK  X29, #0xbf92, LSL #32
    MOVK  X29, #0xa5dd, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X29, #0x71a0, LSL #0
    MOVK  X29, #0xa5b4, LSL #16
    MOVK  X29, #0x71a0, LSL #32
    MOVK  X29, #0xa5b4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D19
    MOVZ  X29, #0x71a0, LSL #0
    MOVK  X29, #0xa5b4, LSL #16
    MOVK  X29, #0x71a0, LSL #32
    MOVK  X29, #0xa5b4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X29, #0xeea3, LSL #0
    MOVK  X29, #0xa5a2, LSL #16
    MOVK  X29, #0xeea3, LSL #32
    MOVK  X29, #0xa5a2, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D20
    MOVZ  X29, #0xeea3, LSL #0
    MOVK  X29, #0xa5a2, LSL #16
    MOVK  X29, #0xeea3, LSL #32
    MOVK  X29, #0xa5a2, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X29, #0x445e, LSL #0
    MOVK  X29, #0xa5b4, LSL #16
    MOVK  X29, #0x445e, LSL #32
    MOVK  X29, #0xa5b4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D21
    MOVZ  X29, #0x445e, LSL #0
    MOVK  X29, #0xa5b4, LSL #16
    MOVK  X29, #0x445e, LSL #32
    MOVK  X29, #0xa5b4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X29, #0x7e97, LSL #0
    MOVK  X29, #0xa599, LSL #16
    MOVK  X29, #0x7e97, LSL #32
    MOVK  X29, #0xa599, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D22
    MOVZ  X29, #0x7e97, LSL #0
    MOVK  X29, #0xa599, LSL #16
    MOVK  X29, #0x7e97, LSL #32
    MOVK  X29, #0xa599, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X29, #0x4eb5, LSL #0
    MOVK  X29, #0xa5aa, LSL #16
    MOVK  X29, #0x4eb5, LSL #32
    MOVK  X29, #0xa5aa, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D23
    MOVZ  X29, #0x4eb5, LSL #0
    MOVK  X29, #0xa5aa, LSL #16
    MOVK  X29, #0x4eb5, LSL #32
    MOVK  X29, #0xa5aa, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X29, #0x4741, LSL #0
    MOVK  X29, #0xa5d0, LSL #16
    MOVK  X29, #0x4741, LSL #32
    MOVK  X29, #0xa5d0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D24
    MOVZ  X29, #0x4741, LSL #0
    MOVK  X29, #0xa5d0, LSL #16
    MOVK  X29, #0x4741, LSL #32
    MOVK  X29, #0xa5d0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X29, #0xedfb, LSL #0
    MOVK  X29, #0xa5c9, LSL #16
    MOVK  X29, #0xedfb, LSL #32
    MOVK  X29, #0xa5c9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D25
    MOVZ  X29, #0xedfb, LSL #0
    MOVK  X29, #0xa5c9, LSL #16
    MOVK  X29, #0xedfb, LSL #32
    MOVK  X29, #0xa5c9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X29, #0x233c, LSL #0
    MOVK  X29, #0xa58a, LSL #16
    MOVK  X29, #0x233c, LSL #32
    MOVK  X29, #0xa58a, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D26
    MOVZ  X29, #0x233c, LSL #0
    MOVK  X29, #0xa58a, LSL #16
    MOVK  X29, #0x233c, LSL #32
    MOVK  X29, #0xa58a, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X29, #0x6063, LSL #0
    MOVK  X29, #0xa598, LSL #16
    MOVK  X29, #0x6063, LSL #32
    MOVK  X29, #0xa598, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D27
    MOVZ  X29, #0x6063, LSL #0
    MOVK  X29, #0xa598, LSL #16
    MOVK  X29, #0x6063, LSL #32
    MOVK  X29, #0xa598, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X29, #0x74c, LSL #0
    MOVK  X29, #0xa581, LSL #16
    MOVK  X29, #0x74c, LSL #32
    MOVK  X29, #0xa581, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D28
    MOVZ  X29, #0x74c, LSL #0
    MOVK  X29, #0xa581, LSL #16
    MOVK  X29, #0x74c, LSL #32
    MOVK  X29, #0xa581, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X29, #0xb41f, LSL #0
    MOVK  X29, #0xa5a4, LSL #16
    MOVK  X29, #0xb41f, LSL #32
    MOVK  X29, #0xa5a4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D29
    MOVZ  X29, #0xb41f, LSL #0
    MOVK  X29, #0xa5a4, LSL #16
    MOVK  X29, #0xb41f, LSL #32
    MOVK  X29, #0xa5a4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X29, #0x4ebe, LSL #0
    MOVK  X29, #0xa5fd, LSL #16
    MOVK  X29, #0x4ebe, LSL #32
    MOVK  X29, #0xa5fd, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D30
    MOVZ  X29, #0x4ebe, LSL #0
    MOVK  X29, #0xa5fd, LSL #16
    MOVK  X29, #0x4ebe, LSL #32
    MOVK  X29, #0xa5fd, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X29, #0xe9c6, LSL #0
    MOVK  X29, #0xa5b7, LSL #16
    MOVK  X29, #0xe9c6, LSL #32
    MOVK  X29, #0xa5b7, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D31
    MOVZ  X29, #0xe9c6, LSL #0
    MOVK  X29, #0xa5b7, LSL #16
    MOVK  X29, #0xe9c6, LSL #32
    MOVK  X29, #0xa5b7, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
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
    FMOV  X11, D0
    MOVZ  X29, #0x66be, LSL #0
    MOVK  X29, #0xa593, LSL #16
    MOVK  X29, #0x66be, LSL #32
    MOVK  X29, #0xa5b3, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P3, Z1.D
    FMOV  X11, D1
    MOVZ  X29, #0xb649, LSL #0
    MOVK  X29, #0xa59b, LSL #16
    MOVK  X29, #0xb649, LSL #32
    MOVK  X29, #0xa5bb, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X11, D2
    MOVZ  X29, #0x8436, LSL #0
    MOVK  X29, #0xa5b9, LSL #16
    MOVK  X29, #0x8436, LSL #32
    MOVK  X29, #0xa5d9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P6, Z3.D
    FMOV  X11, D3
    MOVZ  X29, #0x66b7, LSL #0
    MOVK  X29, #0xa5a0, LSL #16
    MOVK  X29, #0x66b7, LSL #32
    MOVK  X29, #0xa5c0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X11, D4
    MOVZ  X29, #0xee10, LSL #0
    MOVK  X29, #0xa59d, LSL #16
    MOVK  X29, #0xee10, LSL #32
    MOVK  X29, #0xa5bd, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X11, D5
    MOVZ  X29, #0x3327, LSL #0
    MOVK  X29, #0xa5c1, LSL #16
    MOVK  X29, #0x3327, LSL #32
    MOVK  X29, #0xa5e1, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X11, D6
    MOVZ  X29, #0xf09d, LSL #0
    MOVK  X29, #0xa5e9, LSL #16
    MOVK  X29, #0xf09d, LSL #32
    MOVK  X29, #0xa609, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X11, D7
    MOVZ  X29, #0x4f59, LSL #0
    MOVK  X29, #0xa59a, LSL #16
    MOVK  X29, #0x4f59, LSL #32
    MOVK  X29, #0xa5ba, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X11, D8
    MOVZ  X29, #0x2a21, LSL #0
    MOVK  X29, #0xa5a3, LSL #16
    MOVK  X29, #0x2a21, LSL #32
    MOVK  X29, #0xa5c3, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X11, D9
    MOVZ  X29, #0x44a5, LSL #0
    MOVK  X29, #0xa5ba, LSL #16
    MOVK  X29, #0x44a5, LSL #32
    MOVK  X29, #0xa5da, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X11, D10
    MOVZ  X29, #0xd230, LSL #0
    MOVK  X29, #0xa5de, LSL #16
    MOVK  X29, #0xd230, LSL #32
    MOVK  X29, #0xa5fe, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X11, D11
    MOVZ  X29, #0x8289, LSL #0
    MOVK  X29, #0xa596, LSL #16
    MOVK  X29, #0x8289, LSL #32
    MOVK  X29, #0xa5b6, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X11, D12
    MOVZ  X29, #0xf264, LSL #0
    MOVK  X29, #0xa58f, LSL #16
    MOVK  X29, #0xf264, LSL #32
    MOVK  X29, #0xa5af, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X11, D13
    MOVZ  X29, #0xcde0, LSL #0
    MOVK  X29, #0xa58a, LSL #16
    MOVK  X29, #0xcde0, LSL #32
    MOVK  X29, #0xa5aa, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X11, D14
    MOVZ  X29, #0x9cc7, LSL #0
    MOVK  X29, #0xa5b0, LSL #16
    MOVK  X29, #0x9cc7, LSL #32
    MOVK  X29, #0xa5d0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X11, D15
    MOVZ  X29, #0x34c8, LSL #0
    MOVK  X29, #0xa599, LSL #16
    MOVK  X29, #0x34c8, LSL #32
    MOVK  X29, #0xa5b9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X11, D16
    MOVZ  X29, #0x19c5, LSL #0
    MOVK  X29, #0xa57b, LSL #16
    MOVK  X29, #0x19c5, LSL #32
    MOVK  X29, #0xa59b, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X11, D17
    MOVZ  X29, #0x1018, LSL #0
    MOVK  X29, #0xa5b7, LSL #16
    MOVK  X29, #0x1018, LSL #32
    MOVK  X29, #0xa5d7, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X11, D18
    MOVZ  X29, #0xbf92, LSL #0
    MOVK  X29, #0xa5dd, LSL #16
    MOVK  X29, #0xbf92, LSL #32
    MOVK  X29, #0xa5fd, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X11, D19
    MOVZ  X29, #0x71a0, LSL #0
    MOVK  X29, #0xa5b4, LSL #16
    MOVK  X29, #0x71a0, LSL #32
    MOVK  X29, #0xa5d4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X11, D20
    MOVZ  X29, #0xeea3, LSL #0
    MOVK  X29, #0xa5a2, LSL #16
    MOVK  X29, #0xeea3, LSL #32
    MOVK  X29, #0xa5c2, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P2, Z21.D
    FMOV  X11, D21
    MOVZ  X29, #0x445e, LSL #0
    MOVK  X29, #0xa5b4, LSL #16
    MOVK  X29, #0x445e, LSL #32
    MOVK  X29, #0xa5d4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X11, D22
    MOVZ  X29, #0x7e97, LSL #0
    MOVK  X29, #0xa599, LSL #16
    MOVK  X29, #0x7e97, LSL #32
    MOVK  X29, #0xa5b9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X11, D23
    MOVZ  X29, #0x4eb5, LSL #0
    MOVK  X29, #0xa5aa, LSL #16
    MOVK  X29, #0x4eb5, LSL #32
    MOVK  X29, #0xa5ca, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P6, Z24.D
    FMOV  X11, D24
    MOVZ  X29, #0x4741, LSL #0
    MOVK  X29, #0xa5d0, LSL #16
    MOVK  X29, #0x4741, LSL #32
    MOVK  X29, #0xa5f0, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X11, D25
    MOVZ  X29, #0xedfb, LSL #0
    MOVK  X29, #0xa5c9, LSL #16
    MOVK  X29, #0xedfb, LSL #32
    MOVK  X29, #0xa5e9, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X11, D26
    MOVZ  X29, #0x233c, LSL #0
    MOVK  X29, #0xa58a, LSL #16
    MOVK  X29, #0x233c, LSL #32
    MOVK  X29, #0xa5aa, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P7, Z27.D
    FMOV  X11, D27
    MOVZ  X29, #0x6063, LSL #0
    MOVK  X29, #0xa598, LSL #16
    MOVK  X29, #0x6063, LSL #32
    MOVK  X29, #0xa5b8, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X11, D28
    MOVZ  X29, #0x74c, LSL #0
    MOVK  X29, #0xa581, LSL #16
    MOVK  X29, #0x74c, LSL #32
    MOVK  X29, #0xa5a1, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X11, D29
    MOVZ  X29, #0xb41f, LSL #0
    MOVK  X29, #0xa5a4, LSL #16
    MOVK  X29, #0xb41f, LSL #32
    MOVK  X29, #0xa5c4, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P0, Z30.D
    FMOV  X11, D30
    MOVZ  X29, #0x4ebe, LSL #0
    MOVK  X29, #0xa5fd, LSL #16
    MOVK  X29, #0x4ebe, LSL #32
    MOVK  X29, #0xa61d, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P6, Z31.D
    FMOV  X11, D31
    MOVZ  X29, #0xe9c6, LSL #0
    MOVK  X29, #0xa5b7, LSL #16
    MOVK  X29, #0xe9c6, LSL #32
    MOVK  X29, #0xa5d7, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTSveVectorI8MM_TestFail
    MOVZ  X2, #0x8d31, LSL #0
    MOVK  X2, #0x2dc8, LSL #16
    MOVK  X2, #0x129, LSL #32
    MOVK  X2, #0x1d73, LSL #48
    MOVZ  X3, #0x1ec3, LSL #0
    MOVK  X3, #0xc6f6, LSL #16
    MOVK  X3, #0xb91c, LSL #32
    MOVK  X3, #0x635a, LSL #48
    MOVZ  X4, #0xc1f1, LSL #0
    MOVK  X4, #0xaa90, LSL #16
    MOVK  X4, #0x5751, LSL #32
    MOVK  X4, #0x2ccd, LSL #48
    MOVZ  X5, #0xcaa6, LSL #0
    MOVK  X5, #0x881a, LSL #16
    MOVK  X5, #0xfac1, LSL #32
    MOVK  X5, #0xd953, LSL #48
    MOVZ  X6, #0x2988, LSL #0
    MOVK  X6, #0xfdf3, LSL #16
    MOVK  X6, #0x3ee4, LSL #32
    MOVK  X6, #0xf9e1, LSL #48
    MOVZ  X7, #0x85c2, LSL #0
    MOVK  X7, #0xb9a2, LSL #16
    MOVK  X7, #0xf35e, LSL #32
    MOVK  X7, #0x38c8, LSL #48
    MOVZ  X8, #0x40a, LSL #0
    MOVK  X8, #0x7a0a, LSL #16
    MOVK  X8, #0x7396, LSL #32
    MOVK  X8, #0x7cc7, LSL #48
    MOVZ  X9, #0xb759, LSL #0
    MOVK  X9, #0x967c, LSL #16
    MOVK  X9, #0x3407, LSL #32
    MOVK  X9, #0xefc, LSL #48
    MOVZ  X10, #0x65d5, LSL #0
    MOVK  X10, #0x5b33, LSL #16
    MOVK  X10, #0x3e8a, LSL #32
    MOVK  X10, #0xe07b, LSL #48
    MOVZ  X11, #0x9ecd, LSL #0
    MOVK  X11, #0x12df, LSL #16
    MOVK  X11, #0x2d68, LSL #32
    MOVK  X11, #0x7e51, LSL #48
    MOVZ  X12, #0xbec8, LSL #0
    MOVK  X12, #0xc2f, LSL #16
    MOVK  X12, #0xe685, LSL #32
    MOVK  X12, #0xc0d3, LSL #48
    MOVZ  X13, #0x929a, LSL #0
    MOVK  X13, #0xcc5b, LSL #16
    MOVK  X13, #0x8638, LSL #32
    MOVK  X13, #0xf23b, LSL #48
    MOVZ  X14, #0x9e87, LSL #0
    MOVK  X14, #0xce0d, LSL #16
    MOVK  X14, #0xf818, LSL #32
    MOVK  X14, #0x88, LSL #48
    MOVZ  X15, #0x6347, LSL #0
    MOVK  X15, #0x656f, LSL #16
    MOVK  X15, #0x2a9, LSL #32
    MOVK  X15, #0xb3e7, LSL #48
    MOVZ  X16, #0x626d, LSL #0
    MOVK  X16, #0xb39c, LSL #16
    MOVK  X16, #0x217c, LSL #32
    MOVK  X16, #0x65f7, LSL #48
    MOVZ  X17, #0x6a33, LSL #0
    MOVK  X17, #0x8b25, LSL #16
    MOVK  X17, #0x7bc7, LSL #32
    MOVK  X17, #0x332e, LSL #48
    MOVZ  X18, #0xd420, LSL #0
    MOVK  X18, #0xcdfe, LSL #16
    MOVK  X18, #0x2abc, LSL #32
    MOVK  X18, #0xf33f, LSL #48
    MOVZ  X19, #0x8856, LSL #0
    MOVK  X19, #0x9a9e, LSL #16
    MOVK  X19, #0x8954, LSL #32
    MOVK  X19, #0x6148, LSL #48
    MOVZ  X20, #0x6f4b, LSL #0
    MOVK  X20, #0x911, LSL #16
    MOVK  X20, #0x4239, LSL #32
    MOVK  X20, #0xca, LSL #48
    MOVZ  X21, #0xfedc, LSL #0
    MOVK  X21, #0xf11d, LSL #16
    MOVK  X21, #0x842b, LSL #32
    MOVK  X21, #0x2a81, LSL #48
    MOVZ  X22, #0x5d24, LSL #0
    MOVK  X22, #0x55d3, LSL #16
    MOVK  X22, #0xd81b, LSL #32
    MOVK  X22, #0xda41, LSL #48
    MOVZ  X23, #0x6990, LSL #0
    MOVK  X23, #0x1fe1, LSL #16
    MOVK  X23, #0xb49c, LSL #32
    MOVK  X23, #0x83a1, LSL #48
    MOVZ  X29, #0x4903, LSL #0
    MOVK  X29, #0x759b, LSL #16
    MOVK  X29, #0x6ad2, LSL #32
    MOVK  X29, #0xcc54, LSL #48
    DUP     Z0.D, X20
    DUP     Z1.D, X11
    DUP     Z2.D, X23
    DUP     Z3.D, X22
    DUP     Z4.D, X29
    DUP     Z5.D, X21
    DUP     Z6.D, X7
    DUP     Z7.D, X29
    DUP     Z8.D, X19
    DUP     Z9.D, X3
    DUP     Z10.D, X17
    DUP     Z11.D, X20
    DUP     Z12.D, X7
    DUP     Z13.D, X10
    DUP     Z14.D, X7
    DUP     Z15.D, X8
    DUP     Z16.D, X20
    DUP     Z17.D, X15
    DUP     Z18.D, X7
    DUP     Z19.D, X13
    DUP     Z20.D, X12
    DUP     Z21.D, X18
    DUP     Z22.D, X12
    DUP     Z23.D, X19
    DUP     Z24.D, X20
    DUP     Z25.D, X8
    DUP     Z26.D, X14
    DUP     Z27.D, X2
    DUP     Z28.D, X6
    DUP     Z29.D, X3
    DUP     Z30.D, X20
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
    MOVZ  X6, #0xa, LSL #0
LCRTSveVectorI8MM_label_10:
    SUDOT Z31.S, Z3.B, Z3.B[0x2]
    USDOT Z22.S, Z30.B, Z29.B
    USDOT Z11.S, Z11.B, Z0.B[0x2]
    USDOT Z11.S, Z8.B, Z31.B
    USDOT Z1.S, Z14.B, Z25.B
    USMMLA Z22.S, Z28.B, Z24.B
    SMMLA Z4.S, Z22.B, Z1.B
    SUDOT Z11.S, Z4.B, Z4.B[0x1]
    USMMLA Z16.S, Z11.B, Z27.B
    UMMLA Z19.S, Z4.B, Z14.B
    USDOT Z16.S, Z16.B, Z5.B[0x1]
    USMMLA Z15.S, Z5.B, Z22.B
    SMMLA Z21.S, Z24.B, Z26.B
    UMMLA Z20.S, Z21.B, Z31.B
    SMMLA Z7.S, Z19.B, Z13.B
    SMMLA Z4.S, Z9.B, Z29.B
    SUDOT Z24.S, Z5.B, Z0.B[0x1]
    USDOT Z22.S, Z26.B, Z3.B[0x0]
    SUDOT Z24.S, Z20.B, Z4.B[0x2]
    USMMLA Z20.S, Z25.B, Z0.B
    USMMLA Z31.S, Z19.B, Z22.B
    USDOT Z31.S, Z16.B, Z1.B
    USDOT Z30.S, Z8.B, Z0.B
    SMMLA Z29.S, Z12.B, Z11.B
    USDOT Z27.S, Z20.B, Z24.B
    USDOT Z13.S, Z13.B, Z2.B[0x0]
    USDOT Z18.S, Z12.B, Z5.B
    SMMLA Z23.S, Z9.B, Z15.B
    SMMLA Z22.S, Z9.B, Z29.B
    SUDOT Z25.S, Z9.B, Z1.B[0x0]
    USDOT Z22.S, Z18.B, Z22.B
    SMMLA Z25.S, Z22.B, Z21.B
    USDOT Z7.S, Z27.B, Z3.B[0x2]
    UMMLA Z5.S, Z31.B, Z13.B
    UMMLA Z25.S, Z7.B, Z23.B
    USMMLA Z30.S, Z30.B, Z14.B
    UMMLA Z30.S, Z30.B, Z25.B
    USDOT Z22.S, Z4.B, Z6.B[0x0]
    USDOT Z12.S, Z26.B, Z3.B[0x3]
    UMMLA Z29.S, Z15.B, Z30.B
    USDOT Z4.S, Z8.B, Z4.B[0x1]
    SUDOT Z13.S, Z26.B, Z5.B[0x0]
    USMMLA Z13.S, Z25.B, Z24.B
    USDOT Z16.S, Z14.B, Z1.B[0x0]
    SMMLA Z6.S, Z22.B, Z3.B
    USDOT Z10.S, Z14.B, Z0.B[0x3]
    UMMLA Z16.S, Z7.B, Z21.B
    USDOT Z23.S, Z25.B, Z21.B
    USMMLA Z21.S, Z17.B, Z19.B
    USDOT Z29.S, Z27.B, Z6.B[0x0]
    UMMLA Z9.S, Z13.B, Z27.B
    USDOT Z8.S, Z21.B, Z29.B
    UMMLA Z21.S, Z4.B, Z16.B
    SUDOT Z25.S, Z5.B, Z4.B[0x3]
    SMMLA Z12.S, Z6.B, Z9.B
    SUDOT Z8.S, Z21.B, Z6.B[0x0]
    UMMLA Z21.S, Z12.B, Z26.B
    SUDOT Z12.S, Z25.B, Z3.B[0x0]
    USDOT Z8.S, Z21.B, Z1.B[0x3]
    USDOT Z12.S, Z27.B, Z23.B
    USMMLA Z10.S, Z29.B, Z12.B
    SMMLA Z29.S, Z27.B, Z8.B
    USMMLA Z7.S, Z8.B, Z12.B
    USMMLA Z26.S, Z1.B, Z28.B
    USDOT Z23.S, Z1.B, Z1.B[0x3]
    USMMLA Z12.S, Z17.B, Z11.B
    USMMLA Z10.S, Z14.B, Z20.B
    UMMLA Z24.S, Z21.B, Z24.B
    UMMLA Z15.S, Z9.B, Z11.B
    USDOT Z13.S, Z20.B, Z6.B
    USDOT Z7.S, Z26.B, Z3.B
    USMMLA Z9.S, Z31.B, Z12.B
    USDOT Z9.S, Z29.B, Z7.B[0x3]
    UMMLA Z13.S, Z24.B, Z4.B
    USDOT Z10.S, Z9.B, Z1.B[0x1]
    USDOT Z24.S, Z13.B, Z11.B
    USMMLA Z15.S, Z23.B, Z5.B
    SUDOT Z8.S, Z3.B, Z7.B[0x0]
    USDOT Z25.S, Z24.B, Z15.B
    SUDOT Z8.S, Z25.B, Z4.B[0x0]
    USDOT Z16.S, Z19.B, Z11.B
    USMMLA Z8.S, Z2.B, Z18.B
    SUDOT Z9.S, Z15.B, Z2.B[0x2]
    SMMLA Z28.S, Z27.B, Z8.B
    USDOT Z13.S, Z2.B, Z1.B[0x0]
    SUDOT Z20.S, Z22.B, Z7.B[0x1]
    USDOT Z1.S, Z3.B, Z1.B[0x0]
    SUDOT Z6.S, Z26.B, Z5.B[0x2]
    USDOT Z11.S, Z12.B, Z14.B
    SMMLA Z16.S, Z16.B, Z9.B
    USDOT Z8.S, Z26.B, Z10.B
    UMMLA Z20.S, Z20.B, Z6.B
    SMMLA Z11.S, Z2.B, Z13.B
    USDOT Z20.S, Z19.B, Z1.B
    UMMLA Z28.S, Z8.B, Z26.B
    UMMLA Z16.S, Z16.B, Z11.B
    USDOT Z16.S, Z20.B, Z20.B
    USDOT Z25.S, Z0.B, Z2.B[0x3]
    SUDOT Z2.S, Z20.B, Z4.B[0x0]
    SMMLA Z24.S, Z22.B, Z29.B
    UMMLA Z10.S, Z13.B, Z13.B
    USDOT Z9.S, Z4.B, Z29.B
    SMMLA Z23.S, Z14.B, Z26.B
    SUDOT Z28.S, Z13.B, Z5.B[0x1]
    USMMLA Z8.S, Z10.B, Z19.B
    USDOT Z27.S, Z19.B, Z3.B[0x3]
    USMMLA Z21.S, Z25.B, Z3.B
    SUDOT Z27.S, Z27.B, Z0.B[0x3]
    UMMLA Z2.S, Z6.B, Z16.B
    USMMLA Z27.S, Z3.B, Z12.B
    USDOT Z28.S, Z27.B, Z0.B
    UMMLA Z11.S, Z9.B, Z26.B
    USDOT Z24.S, Z5.B, Z25.B
    SMMLA Z11.S, Z7.B, Z30.B
    SMMLA Z23.S, Z18.B, Z23.B
    USDOT Z2.S, Z2.B, Z3.B[0x0]
    USMMLA Z30.S, Z13.B, Z24.B
    USDOT Z21.S, Z19.B, Z7.B[0x1]
    USDOT Z22.S, Z23.B, Z0.B[0x3]
    USDOT Z30.S, Z23.B, Z2.B[0x1]
    SUDOT Z28.S, Z28.B, Z7.B[0x2]
    USDOT Z3.S, Z30.B, Z8.B
    UMMLA Z10.S, Z1.B, Z13.B
    USDOT Z21.S, Z28.B, Z16.B
    USMMLA Z22.S, Z22.B, Z10.B
    USMMLA Z23.S, Z5.B, Z11.B
    USMMLA Z3.S, Z26.B, Z21.B
    UMMLA Z20.S, Z22.B, Z2.B
    USMMLA Z11.S, Z1.B, Z9.B
    USDOT Z23.S, Z24.B, Z10.B
    USDOT Z18.S, Z0.B, Z3.B[0x2]
    USDOT Z23.S, Z20.B, Z2.B[0x0]
    SUDOT Z18.S, Z18.B, Z3.B[0x0]
    USMMLA Z23.S, Z16.B, Z18.B
    SUDOT Z18.S, Z4.B, Z5.B[0x1]
    UMMLA Z11.S, Z19.B, Z26.B
    UMMLA Z6.S, Z1.B, Z12.B
    SMMLA Z25.S, Z27.B, Z16.B
    UMMLA Z15.S, Z18.B, Z24.B
    USMMLA Z0.S, Z13.B, Z17.B
    UMMLA Z23.S, Z11.B, Z26.B
    SUDOT Z27.S, Z18.B, Z3.B[0x2]
    SMMLA Z28.S, Z23.B, Z16.B
    SMMLA Z18.S, Z8.B, Z5.B
    USDOT Z3.S, Z22.B, Z10.B
    UMMLA Z11.S, Z19.B, Z27.B
    USDOT Z21.S, Z28.B, Z4.B
    UMMLA Z26.S, Z5.B, Z9.B
    USMMLA Z26.S, Z11.B, Z26.B
    USDOT Z15.S, Z0.B, Z0.B[0x2]
    USDOT Z30.S, Z26.B, Z7.B[0x1]
    USMMLA Z14.S, Z26.B, Z3.B
    SMMLA Z18.S, Z4.B, Z30.B
    SMMLA Z1.S, Z23.B, Z21.B
    USDOT Z14.S, Z9.B, Z5.B[0x3]
    SMMLA Z15.S, Z6.B, Z15.B
    USMMLA Z14.S, Z20.B, Z14.B
    SUDOT Z2.S, Z14.B, Z1.B[0x0]
    SUDOT Z23.S, Z23.B, Z0.B[0x3]
    UMMLA Z23.S, Z29.B, Z23.B
    SUDOT Z4.S, Z15.B, Z2.B[0x0]
    UMMLA Z18.S, Z23.B, Z20.B
    USDOT Z18.S, Z4.B, Z5.B[0x0]
    USDOT Z6.S, Z6.B, Z12.B
    UMMLA Z26.S, Z23.B, Z6.B
    SMMLA Z29.S, Z5.B, Z18.B
    SMMLA Z25.S, Z22.B, Z19.B
    USDOT Z19.S, Z7.B, Z5.B[0x0]
    SMMLA Z14.S, Z10.B, Z28.B
    USMMLA Z0.S, Z22.B, Z2.B
    SMMLA Z0.S, Z15.B, Z12.B
    SUDOT Z8.S, Z11.B, Z1.B[0x3]
    USMMLA Z27.S, Z8.B, Z15.B
    SUDOT Z0.S, Z16.B, Z0.B[0x1]
    USDOT Z6.S, Z18.B, Z4.B[0x3]
    UMMLA Z21.S, Z1.B, Z13.B
    SMMLA Z26.S, Z14.B, Z14.B
    SUDOT Z9.S, Z26.B, Z0.B[0x3]
    UMMLA Z9.S, Z25.B, Z21.B
    UMMLA Z31.S, Z11.B, Z6.B
    SMMLA Z0.S, Z19.B, Z27.B
    USMMLA Z28.S, Z9.B, Z21.B
    SMMLA Z28.S, Z28.B, Z1.B
    SMMLA Z16.S, Z26.B, Z11.B
    UMMLA Z28.S, Z10.B, Z16.B
    UMMLA Z16.S, Z29.B, Z7.B
    USDOT Z21.S, Z0.B, Z1.B[0x1]
    USDOT Z16.S, Z6.B, Z3.B[0x3]
    USDOT Z10.S, Z31.B, Z30.B
    UMMLA Z16.S, Z7.B, Z21.B
    UMMLA Z25.S, Z28.B, Z0.B
    SUDOT Z10.S, Z10.B, Z6.B[0x0]
    USDOT Z16.S, Z23.B, Z6.B[0x2]
    USDOT Z10.S, Z19.B, Z5.B[0x0]
    UMMLA Z25.S, Z10.B, Z18.B
    USDOT Z22.S, Z16.B, Z10.B
    UMMLA Z26.S, Z27.B, Z30.B
    USMMLA Z26.S, Z19.B, Z0.B
    SMMLA Z3.S, Z31.B, Z26.B
    SUDOT Z13.S, Z13.B, Z3.B[0x2]
    SUBS  X6, X6, #0x1
    B.NE  LCRTSveVectorI8MM_label_10
    MOVZ  X4, #0x8d31, LSL #0
    MOVK  X4, #0x2dc8, LSL #16
    MOVK  X4, #0x129, LSL #32
    MOVK  X4, #0x1d73, LSL #48
    SUB  X19, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x1ec3, LSL #0
    MOVK  X4, #0xc6f6, LSL #16
    MOVK  X4, #0xb91c, LSL #32
    MOVK  X4, #0x635a, LSL #48
    SUB  X19, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0xcaa6, LSL #0
    MOVK  X4, #0x881a, LSL #16
    MOVK  X4, #0xfac1, LSL #32
    MOVK  X4, #0xd953, LSL #48
    SUB  X19, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x85c2, LSL #0
    MOVK  X4, #0xb9a2, LSL #16
    MOVK  X4, #0xf35e, LSL #32
    MOVK  X4, #0x38c8, LSL #48
    SUB  X19, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x40a, LSL #0
    MOVK  X4, #0x7a0a, LSL #16
    MOVK  X4, #0x7396, LSL #32
    MOVK  X4, #0x7cc7, LSL #48
    SUB  X19, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0xb759, LSL #0
    MOVK  X4, #0x967c, LSL #16
    MOVK  X4, #0x3407, LSL #32
    MOVK  X4, #0xefc, LSL #48
    SUB  X19, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x65d5, LSL #0
    MOVK  X4, #0x5b33, LSL #16
    MOVK  X4, #0x3e8a, LSL #32
    MOVK  X4, #0xe07b, LSL #48
    SUB  X19, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x9ecd, LSL #0
    MOVK  X4, #0x12df, LSL #16
    MOVK  X4, #0x2d68, LSL #32
    MOVK  X4, #0x7e51, LSL #48
    SUB  X19, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0xbec8, LSL #0
    MOVK  X4, #0xc2f, LSL #16
    MOVK  X4, #0xe685, LSL #32
    MOVK  X4, #0xc0d3, LSL #48
    SUB  X19, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x929a, LSL #0
    MOVK  X4, #0xcc5b, LSL #16
    MOVK  X4, #0x8638, LSL #32
    MOVK  X4, #0xf23b, LSL #48
    SUB  X19, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x9e87, LSL #0
    MOVK  X4, #0xce0d, LSL #16
    MOVK  X4, #0xf818, LSL #32
    MOVK  X4, #0x88, LSL #48
    SUB  X19, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x6347, LSL #0
    MOVK  X4, #0x656f, LSL #16
    MOVK  X4, #0x2a9, LSL #32
    MOVK  X4, #0xb3e7, LSL #48
    SUB  X19, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x626d, LSL #0
    MOVK  X4, #0xb39c, LSL #16
    MOVK  X4, #0x217c, LSL #32
    MOVK  X4, #0x65f7, LSL #48
    SUB  X19, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x6a33, LSL #0
    MOVK  X4, #0x8b25, LSL #16
    MOVK  X4, #0x7bc7, LSL #32
    MOVK  X4, #0x332e, LSL #48
    SUB  X19, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0xd420, LSL #0
    MOVK  X4, #0xcdfe, LSL #16
    MOVK  X4, #0x2abc, LSL #32
    MOVK  X4, #0xf33f, LSL #48
    SUB  X19, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x6f4b, LSL #0
    MOVK  X4, #0x911, LSL #16
    MOVK  X4, #0x4239, LSL #32
    MOVK  X4, #0xca, LSL #48
    SUB  X19, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0xfedc, LSL #0
    MOVK  X4, #0xf11d, LSL #16
    MOVK  X4, #0x842b, LSL #32
    MOVK  X4, #0x2a81, LSL #48
    SUB  X19, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x6990, LSL #0
    MOVK  X4, #0x1fe1, LSL #16
    MOVK  X4, #0xb49c, LSL #32
    MOVK  X4, #0x83a1, LSL #48
    SUB  X19, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x4903, LSL #0
    MOVK  X4, #0x759b, LSL #16
    MOVK  X4, #0x6ad2, LSL #32
    MOVK  X4, #0xcc54, LSL #48
    SUB  X19, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTSveVectorI8MM_TestFail
    MRS  X4, FPSR
    MOVZ  X19, #0x80, LSL #0
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X19, #0xc4f6, LSL #0
    MOVK  X19, #0x90c, LSL #16
    MOVK  X19, #0x7c9f, LSL #32
    MOVK  X19, #0xc3, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D0
    MOVZ  X19, #0xc4f6, LSL #0
    MOVK  X19, #0x90c, LSL #16
    MOVK  X19, #0x7c9f, LSL #32
    MOVK  X19, #0xc3, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X19, #0x7178, LSL #0
    MOVK  X19, #0x12e4, LSL #16
    MOVK  X19, #0xc0ba, LSL #32
    MOVK  X19, #0x7e52, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D1
    MOVZ  X19, #0x7178, LSL #0
    MOVK  X19, #0x12e4, LSL #16
    MOVK  X19, #0xc0ba, LSL #32
    MOVK  X19, #0x7e52, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X19, #0x659e, LSL #0
    MOVK  X19, #0x1ff0, LSL #16
    MOVK  X19, #0xb706, LSL #32
    MOVK  X19, #0x83b1, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D2
    MOVZ  X19, #0x659e, LSL #0
    MOVK  X19, #0x1ff0, LSL #16
    MOVK  X19, #0xb706, LSL #32
    MOVK  X19, #0x83b1, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X19, #0x3024, LSL #0
    MOVK  X19, #0x55d5, LSL #16
    MOVK  X19, #0xfb0b, LSL #32
    MOVK  X19, #0xda46, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D3
    MOVZ  X19, #0x3024, LSL #0
    MOVK  X19, #0x55d5, LSL #16
    MOVK  X19, #0xfb0b, LSL #32
    MOVK  X19, #0xda46, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X19, #0x6d0a, LSL #0
    MOVK  X19, #0x759e, LSL #16
    MOVK  X19, #0x9c35, LSL #32
    MOVK  X19, #0xcc54, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D4
    MOVZ  X19, #0x6d0a, LSL #0
    MOVK  X19, #0x759e, LSL #16
    MOVK  X19, #0x9c35, LSL #32
    MOVK  X19, #0xcc54, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X19, #0x66e7, LSL #0
    MOVK  X19, #0xf133, LSL #16
    MOVK  X19, #0xec36, LSL #32
    MOVK  X19, #0x2a96, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D5
    MOVZ  X19, #0x66e7, LSL #0
    MOVK  X19, #0xf133, LSL #16
    MOVK  X19, #0xec36, LSL #32
    MOVK  X19, #0x2a96, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X19, #0x2fe7, LSL #0
    MOVK  X19, #0xb9b2, LSL #16
    MOVK  X19, #0x6cb6, LSL #32
    MOVK  X19, #0x38dd, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D6
    MOVZ  X19, #0x2fe7, LSL #0
    MOVK  X19, #0xb9b2, LSL #16
    MOVK  X19, #0x6cb6, LSL #32
    MOVK  X19, #0x38dd, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X19, #0xd452, LSL #0
    MOVK  X19, #0x7597, LSL #16
    MOVK  X19, #0x317c, LSL #32
    MOVK  X19, #0xcc50, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D7
    MOVZ  X19, #0xd452, LSL #0
    MOVK  X19, #0x7597, LSL #16
    MOVK  X19, #0x317c, LSL #32
    MOVK  X19, #0xcc50, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X19, #0x2dc6, LSL #0
    MOVK  X19, #0x9a9b, LSL #16
    MOVK  X19, #0x2ead, LSL #32
    MOVK  X19, #0x6156, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D8
    MOVZ  X19, #0x2dc6, LSL #0
    MOVK  X19, #0x9a9b, LSL #16
    MOVK  X19, #0x2ead, LSL #32
    MOVK  X19, #0x6156, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X19, #0xedf, LSL #0
    MOVK  X19, #0xc71f, LSL #16
    MOVK  X19, #0x90b8, LSL #32
    MOVK  X19, #0x6382, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D9
    MOVZ  X19, #0xedf, LSL #0
    MOVK  X19, #0xc71f, LSL #16
    MOVK  X19, #0x90b8, LSL #32
    MOVK  X19, #0x6382, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X19, #0x1ad5, LSL #0
    MOVK  X19, #0x8b4e, LSL #16
    MOVK  X19, #0xaf1d, LSL #32
    MOVK  X19, #0x3355, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D10
    MOVZ  X19, #0x1ad5, LSL #0
    MOVK  X19, #0x8b4e, LSL #16
    MOVK  X19, #0xaf1d, LSL #32
    MOVK  X19, #0x3355, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X19, #0xd992, LSL #0
    MOVK  X19, #0x94f, LSL #16
    MOVK  X19, #0xb2d8, LSL #32
    MOVK  X19, #0x106, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D11
    MOVZ  X19, #0xd992, LSL #0
    MOVK  X19, #0x94f, LSL #16
    MOVK  X19, #0xb2d8, LSL #32
    MOVK  X19, #0x106, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X19, #0xd9b7, LSL #0
    MOVK  X19, #0xb9a0, LSL #16
    MOVK  X19, #0xcc41, LSL #32
    MOVK  X19, #0x38cc, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D12
    MOVZ  X19, #0xd9b7, LSL #0
    MOVK  X19, #0xb9a0, LSL #16
    MOVK  X19, #0xcc41, LSL #32
    MOVK  X19, #0x38cc, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X19, #0x3a3a, LSL #0
    MOVK  X19, #0x5b3d, LSL #16
    MOVK  X19, #0x196e, LSL #32
    MOVK  X19, #0xe084, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D13
    MOVZ  X19, #0x3a3a, LSL #0
    MOVK  X19, #0x5b3d, LSL #16
    MOVK  X19, #0x196e, LSL #32
    MOVK  X19, #0xe084, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X19, #0xf955, LSL #0
    MOVK  X19, #0xb9a4, LSL #16
    MOVK  X19, #0x3dff, LSL #32
    MOVK  X19, #0x38ca, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D14
    MOVZ  X19, #0xf955, LSL #0
    MOVK  X19, #0xb9a4, LSL #16
    MOVK  X19, #0x3dff, LSL #32
    MOVK  X19, #0x38ca, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X19, #0x299a, LSL #0
    MOVK  X19, #0x7a24, LSL #16
    MOVK  X19, #0x4b48, LSL #32
    MOVK  X19, #0x7ce2, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D15
    MOVZ  X19, #0x299a, LSL #0
    MOVK  X19, #0x7a24, LSL #16
    MOVK  X19, #0x4b48, LSL #32
    MOVK  X19, #0x7ce2, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X19, #0x6ccf, LSL #0
    MOVK  X19, #0x962, LSL #16
    MOVK  X19, #0x9758, LSL #32
    MOVK  X19, #0x11b, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D16
    MOVZ  X19, #0x6ccf, LSL #0
    MOVK  X19, #0x962, LSL #16
    MOVK  X19, #0x9758, LSL #32
    MOVK  X19, #0x11b, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X19, #0x6347, LSL #0
    MOVK  X19, #0x656f, LSL #16
    MOVK  X19, #0x2a9, LSL #32
    MOVK  X19, #0xb3e7, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D17
    MOVZ  X19, #0x6347, LSL #0
    MOVK  X19, #0x656f, LSL #16
    MOVK  X19, #0x2a9, LSL #32
    MOVK  X19, #0xb3e7, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X19, #0xb073, LSL #0
    MOVK  X19, #0xb9ae, LSL #16
    MOVK  X19, #0xbd46, LSL #32
    MOVK  X19, #0x38d4, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D18
    MOVZ  X19, #0xb073, LSL #0
    MOVK  X19, #0xb9ae, LSL #16
    MOVK  X19, #0xbd46, LSL #32
    MOVK  X19, #0x38d4, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X19, #0xfbca, LSL #0
    MOVK  X19, #0xcc72, LSL #16
    MOVK  X19, #0x344b, LSL #32
    MOVK  X19, #0xf252, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D19
    MOVZ  X19, #0xfbca, LSL #0
    MOVK  X19, #0xcc72, LSL #16
    MOVK  X19, #0x344b, LSL #32
    MOVK  X19, #0xf252, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X19, #0x2d04, LSL #0
    MOVK  X19, #0xc6f, LSL #16
    MOVK  X19, #0x9a36, LSL #32
    MOVK  X19, #0xc116, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D20
    MOVZ  X19, #0x2d04, LSL #0
    MOVK  X19, #0xc6f, LSL #16
    MOVK  X19, #0x9a36, LSL #32
    MOVK  X19, #0xc116, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X19, #0x8c21, LSL #0
    MOVK  X19, #0xce3d, LSL #16
    MOVK  X19, #0x1b91, LSL #32
    MOVK  X19, #0xf37e, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D21
    MOVZ  X19, #0x8c21, LSL #0
    MOVK  X19, #0xce3d, LSL #16
    MOVK  X19, #0x1b91, LSL #32
    MOVK  X19, #0xf37e, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X19, #0x915a, LSL #0
    MOVK  X19, #0xc32, LSL #16
    MOVK  X19, #0x2a1c, LSL #32
    MOVK  X19, #0xc0d7, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D22
    MOVZ  X19, #0x915a, LSL #0
    MOVK  X19, #0xc32, LSL #16
    MOVK  X19, #0x2a1c, LSL #32
    MOVK  X19, #0xc0d7, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X19, #0xdb7c, LSL #0
    MOVK  X19, #0x9ac8, LSL #16
    MOVK  X19, #0xf13, LSL #32
    MOVK  X19, #0x617c, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D23
    MOVZ  X19, #0xdb7c, LSL #0
    MOVK  X19, #0x9ac8, LSL #16
    MOVK  X19, #0xf13, LSL #32
    MOVK  X19, #0x617c, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X19, #0x1368, LSL #0
    MOVK  X19, #0x925, LSL #16
    MOVK  X19, #0xd727, LSL #32
    MOVK  X19, #0xcf, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D24
    MOVZ  X19, #0x1368, LSL #0
    MOVK  X19, #0x925, LSL #16
    MOVK  X19, #0xd727, LSL #32
    MOVK  X19, #0xcf, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X19, #0x8275, LSL #0
    MOVK  X19, #0x7a41, LSL #16
    MOVK  X19, #0x4c2a, LSL #32
    MOVK  X19, #0x7d01, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D25
    MOVZ  X19, #0x8275, LSL #0
    MOVK  X19, #0x7a41, LSL #16
    MOVK  X19, #0x4c2a, LSL #32
    MOVK  X19, #0x7d01, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X19, #0xd3c3, LSL #0
    MOVK  X19, #0xce44, LSL #16
    MOVK  X19, #0x2d54, LSL #32
    MOVK  X19, #0xc0, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D26
    MOVZ  X19, #0xd3c3, LSL #0
    MOVK  X19, #0xce44, LSL #16
    MOVK  X19, #0x2d54, LSL #32
    MOVK  X19, #0xc0, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X19, #0x47bf, LSL #0
    MOVK  X19, #0x2dc4, LSL #16
    MOVK  X19, #0xc912, LSL #32
    MOVK  X19, #0x1d73, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D27
    MOVZ  X19, #0x47bf, LSL #0
    MOVK  X19, #0x2dc4, LSL #16
    MOVK  X19, #0xc912, LSL #32
    MOVK  X19, #0x1d73, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X19, #0xfb9d, LSL #0
    MOVK  X19, #0xfe16, LSL #16
    MOVK  X19, #0x86fb, LSL #32
    MOVK  X19, #0xf9ff, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D28
    MOVZ  X19, #0xfb9d, LSL #0
    MOVK  X19, #0xfe16, LSL #16
    MOVK  X19, #0x86fb, LSL #32
    MOVK  X19, #0xf9ff, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X19, #0x6c76, LSL #0
    MOVK  X19, #0xc706, LSL #16
    MOVK  X19, #0x4a55, LSL #32
    MOVK  X19, #0x636c, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D29
    MOVZ  X19, #0x6c76, LSL #0
    MOVK  X19, #0xc706, LSL #16
    MOVK  X19, #0x4a55, LSL #32
    MOVK  X19, #0x636c, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X19, #0x69df, LSL #0
    MOVK  X19, #0x91b, LSL #16
    MOVK  X19, #0xee0a, LSL #32
    MOVK  X19, #0xd6, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D30
    MOVZ  X19, #0x69df, LSL #0
    MOVK  X19, #0x91b, LSL #16
    MOVK  X19, #0xee0a, LSL #32
    MOVK  X19, #0xd6, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X19, #0xcf44, LSL #0
    MOVK  X19, #0xc3c, LSL #16
    MOVK  X19, #0x186e, LSL #32
    MOVK  X19, #0xc0e5, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FMOV  X4, D31
    MOVZ  X19, #0xcf44, LSL #0
    MOVK  X19, #0xc3c, LSL #16
    MOVK  X19, #0x186e, LSL #32
    MOVK  X19, #0xc0e5, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X4, #0x0, LSL #0
    STR  X4, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X4, [X0, #0]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
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
    FMOV  X4, D0
    MOVZ  X19, #0xc4f6, LSL #0
    MOVK  X19, #0x90c, LSL #16
    MOVK  X19, #0x7c9f, LSL #32
    MOVK  X19, #0xe3, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X4, D1
    MOVZ  X19, #0x7178, LSL #0
    MOVK  X19, #0x12e4, LSL #16
    MOVK  X19, #0xc0ba, LSL #32
    MOVK  X19, #0x7e72, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X4, D2
    MOVZ  X19, #0x659e, LSL #0
    MOVK  X19, #0x1ff0, LSL #16
    MOVK  X19, #0xb706, LSL #32
    MOVK  X19, #0x83d1, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P3, Z3.D
    FMOV  X4, D3
    MOVZ  X19, #0x3024, LSL #0
    MOVK  X19, #0x55d5, LSL #16
    MOVK  X19, #0xfb0b, LSL #32
    MOVK  X19, #0xda66, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P0, Z4.D
    FMOV  X4, D4
    MOVZ  X19, #0x6d0a, LSL #0
    MOVK  X19, #0x759e, LSL #16
    MOVK  X19, #0x9c35, LSL #32
    MOVK  X19, #0xcc74, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X4, D5
    MOVZ  X19, #0x66e7, LSL #0
    MOVK  X19, #0xf133, LSL #16
    MOVK  X19, #0xec36, LSL #32
    MOVK  X19, #0x2ab6, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X4, D6
    MOVZ  X19, #0x2fe7, LSL #0
    MOVK  X19, #0xb9b2, LSL #16
    MOVK  X19, #0x6cb6, LSL #32
    MOVK  X19, #0x38fd, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X4, D7
    MOVZ  X19, #0xd452, LSL #0
    MOVK  X19, #0x7597, LSL #16
    MOVK  X19, #0x317c, LSL #32
    MOVK  X19, #0xcc70, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X4, D8
    MOVZ  X19, #0x2dc6, LSL #0
    MOVK  X19, #0x9a9b, LSL #16
    MOVK  X19, #0x2ead, LSL #32
    MOVK  X19, #0x6176, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P1, Z9.D
    FMOV  X4, D9
    MOVZ  X19, #0xedf, LSL #0
    MOVK  X19, #0xc71f, LSL #16
    MOVK  X19, #0x90b8, LSL #32
    MOVK  X19, #0x63a2, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X4, D10
    MOVZ  X19, #0x1ad5, LSL #0
    MOVK  X19, #0x8b4e, LSL #16
    MOVK  X19, #0xaf1d, LSL #32
    MOVK  X19, #0x3375, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X4, D11
    MOVZ  X19, #0xd992, LSL #0
    MOVK  X19, #0x94f, LSL #16
    MOVK  X19, #0xb2d8, LSL #32
    MOVK  X19, #0x126, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X4, D12
    MOVZ  X19, #0xd9b7, LSL #0
    MOVK  X19, #0xb9a0, LSL #16
    MOVK  X19, #0xcc41, LSL #32
    MOVK  X19, #0x38ec, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P3, Z13.D
    FMOV  X4, D13
    MOVZ  X19, #0x3a3a, LSL #0
    MOVK  X19, #0x5b3d, LSL #16
    MOVK  X19, #0x196e, LSL #32
    MOVK  X19, #0xe0a4, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X4, D14
    MOVZ  X19, #0xf955, LSL #0
    MOVK  X19, #0xb9a4, LSL #16
    MOVK  X19, #0x3dff, LSL #32
    MOVK  X19, #0x38ea, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X4, D15
    MOVZ  X19, #0x299a, LSL #0
    MOVK  X19, #0x7a24, LSL #16
    MOVK  X19, #0x4b48, LSL #32
    MOVK  X19, #0x7d02, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P0, Z16.D
    FMOV  X4, D16
    MOVZ  X19, #0x6ccf, LSL #0
    MOVK  X19, #0x962, LSL #16
    MOVK  X19, #0x9758, LSL #32
    MOVK  X19, #0x13b, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P1, Z17.D
    FMOV  X4, D17
    MOVZ  X19, #0x6347, LSL #0
    MOVK  X19, #0x656f, LSL #16
    MOVK  X19, #0x2a9, LSL #32
    MOVK  X19, #0xb407, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X4, D18
    MOVZ  X19, #0xb073, LSL #0
    MOVK  X19, #0xb9ae, LSL #16
    MOVK  X19, #0xbd46, LSL #32
    MOVK  X19, #0x38f4, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P5, Z19.D
    FMOV  X4, D19
    MOVZ  X19, #0xfbca, LSL #0
    MOVK  X19, #0xcc72, LSL #16
    MOVK  X19, #0x344b, LSL #32
    MOVK  X19, #0xf272, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X4, D20
    MOVZ  X19, #0x2d04, LSL #0
    MOVK  X19, #0xc6f, LSL #16
    MOVK  X19, #0x9a36, LSL #32
    MOVK  X19, #0xc136, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P7, Z21.D
    FMOV  X4, D21
    MOVZ  X19, #0x8c21, LSL #0
    MOVK  X19, #0xce3d, LSL #16
    MOVK  X19, #0x1b91, LSL #32
    MOVK  X19, #0xf39e, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X4, D22
    MOVZ  X19, #0x915a, LSL #0
    MOVK  X19, #0xc32, LSL #16
    MOVK  X19, #0x2a1c, LSL #32
    MOVK  X19, #0xc0f7, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X4, D23
    MOVZ  X19, #0xdb7c, LSL #0
    MOVK  X19, #0x9ac8, LSL #16
    MOVK  X19, #0xf13, LSL #32
    MOVK  X19, #0x619c, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P7, Z24.D
    FMOV  X4, D24
    MOVZ  X19, #0x1368, LSL #0
    MOVK  X19, #0x925, LSL #16
    MOVK  X19, #0xd727, LSL #32
    MOVK  X19, #0xef, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X4, D25
    MOVZ  X19, #0x8275, LSL #0
    MOVK  X19, #0x7a41, LSL #16
    MOVK  X19, #0x4c2a, LSL #32
    MOVK  X19, #0x7d21, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X4, D26
    MOVZ  X19, #0xd3c3, LSL #0
    MOVK  X19, #0xce44, LSL #16
    MOVK  X19, #0x2d54, LSL #32
    MOVK  X19, #0xe0, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X4, D27
    MOVZ  X19, #0x47bf, LSL #0
    MOVK  X19, #0x2dc4, LSL #16
    MOVK  X19, #0xc912, LSL #32
    MOVK  X19, #0x1d93, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X4, D28
    MOVZ  X19, #0xfb9d, LSL #0
    MOVK  X19, #0xfe16, LSL #16
    MOVK  X19, #0x86fb, LSL #32
    MOVK  X19, #0xfa1f, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X4, D29
    MOVZ  X19, #0x6c76, LSL #0
    MOVK  X19, #0xc706, LSL #16
    MOVK  X19, #0x4a55, LSL #32
    MOVK  X19, #0x638c, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X4, D30
    MOVZ  X19, #0x69df, LSL #0
    MOVK  X19, #0x91b, LSL #16
    MOVK  X19, #0xee0a, LSL #32
    MOVK  X19, #0xf6, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X4, D31
    MOVZ  X19, #0xcf44, LSL #0
    MOVK  X19, #0xc3c, LSL #16
    MOVK  X19, #0x186e, LSL #32
    MOVK  X19, #0xc105, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X7
    DUP     Z1.D, X21
    DUP     Z2.D, X22
    DUP     Z3.D, X20
    DUP     Z4.D, X13
    DUP     Z5.D, X6
    DUP     Z6.D, X23
    DUP     Z7.D, X15
    DUP     Z8.D, X16
    DUP     Z9.D, X18
    DUP     Z10.D, X19
    DUP     Z11.D, X29
    DUP     Z12.D, X9
    DUP     Z13.D, X17
    DUP     Z14.D, X9
    DUP     Z15.D, X21
    DUP     Z16.D, X4
    DUP     Z17.D, X17
    DUP     Z18.D, X5
    DUP     Z19.D, X10
    DUP     Z20.D, X21
    DUP     Z21.D, X11
    DUP     Z22.D, X21
    DUP     Z23.D, X17
    DUP     Z24.D, X23
    DUP     Z25.D, X22
    DUP     Z26.D, X5
    DUP     Z27.D, X8
    DUP     Z28.D, X29
    DUP     Z29.D, X8
    DUP     Z30.D, X6
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
LCRTSveVectorI8MM_label_11:
    SMMLA Z30.S, Z30.B, Z29.B
    USDOT Z30.S, Z30.B, Z26.B
    USMMLA Z28.S, Z31.B, Z30.B
    USDOT Z28.S, Z20.B, Z2.B[0x0]
    UMMLA Z4.S, Z25.B, Z28.B
    SMMLA Z23.S, Z15.B, Z19.B
    SMMLA Z4.S, Z23.B, Z27.B
    SUDOT Z3.S, Z8.B, Z3.B[0x0]
    USDOT Z28.S, Z17.B, Z4.B
    SMMLA Z27.S, Z26.B, Z21.B
    USDOT Z2.S, Z13.B, Z2.B[0x1]
    USDOT Z0.S, Z17.B, Z30.B
    USMMLA Z8.S, Z15.B, Z17.B
    SUDOT Z20.S, Z26.B, Z3.B[0x2]
    USDOT Z21.S, Z10.B, Z6.B[0x3]
    USDOT Z12.S, Z12.B, Z31.B
    USMMLA Z3.S, Z19.B, Z4.B
    USMMLA Z2.S, Z20.B, Z11.B
    USDOT Z21.S, Z2.B, Z30.B
    SUDOT Z9.S, Z0.B, Z3.B[0x3]
    SUDOT Z1.S, Z16.B, Z2.B[0x1]
    USMMLA Z28.S, Z12.B, Z27.B
    SUDOT Z4.S, Z8.B, Z1.B[0x3]
    USDOT Z27.S, Z21.B, Z5.B[0x0]
    SMMLA Z9.S, Z18.B, Z28.B
    UMMLA Z22.S, Z4.B, Z27.B
    USDOT Z21.S, Z18.B, Z18.B
    SMMLA Z11.S, Z30.B, Z9.B
    SMMLA Z22.S, Z18.B, Z30.B
    USDOT Z8.S, Z26.B, Z5.B[0x3]
    SUDOT Z28.S, Z22.B, Z6.B[0x3]
    USDOT Z22.S, Z17.B, Z14.B
    USDOT Z8.S, Z2.B, Z12.B
    SMMLA Z12.S, Z14.B, Z3.B
    USDOT Z30.S, Z26.B, Z24.B
    UMMLA Z24.S, Z28.B, Z13.B
    SUDOT Z0.S, Z9.B, Z5.B[0x1]
    USDOT Z31.S, Z31.B, Z1.B[0x3]
    SMMLA Z30.S, Z12.B, Z21.B
    UMMLA Z0.S, Z22.B, Z8.B
    USDOT Z30.S, Z11.B, Z11.B
    SUDOT Z31.S, Z30.B, Z3.B[0x3]
    USDOT Z21.S, Z24.B, Z15.B
    UMMLA Z20.S, Z6.B, Z7.B
    USDOT Z31.S, Z0.B, Z31.B
    SUDOT Z27.S, Z21.B, Z4.B[0x0]
    SUDOT Z12.S, Z22.B, Z3.B[0x2]
    USDOT Z20.S, Z31.B, Z25.B
    SUDOT Z16.S, Z5.B, Z1.B[0x2]
    USDOT Z27.S, Z20.B, Z27.B
    SMMLA Z29.S, Z27.B, Z27.B
    UMMLA Z12.S, Z29.B, Z20.B
    SUDOT Z9.S, Z23.B, Z4.B[0x1]
    USDOT Z11.S, Z14.B, Z22.B
    USMMLA Z17.S, Z5.B, Z11.B
    SMMLA Z16.S, Z1.B, Z24.B
    UMMLA Z21.S, Z27.B, Z4.B
    SMMLA Z14.S, Z30.B, Z26.B
    USMMLA Z6.S, Z10.B, Z23.B
    SUDOT Z27.S, Z29.B, Z1.B[0x3]
    UMMLA Z5.S, Z6.B, Z30.B
    SUDOT Z20.S, Z30.B, Z7.B[0x3]
    USDOT Z17.S, Z30.B, Z5.B[0x0]
    USDOT Z17.S, Z14.B, Z3.B[0x2]
    SMMLA Z12.S, Z12.B, Z16.B
    USDOT Z16.S, Z5.B, Z12.B
    USDOT Z27.S, Z16.B, Z2.B[0x0]
    USMMLA Z21.S, Z23.B, Z20.B
    SMMLA Z21.S, Z7.B, Z21.B
    SMMLA Z21.S, Z0.B, Z21.B
    USDOT Z9.S, Z17.B, Z5.B[0x3]
    USDOT Z27.S, Z27.B, Z2.B[0x3]
    USMMLA Z27.S, Z4.B, Z27.B
    UMMLA Z17.S, Z27.B, Z1.B
    USDOT Z17.S, Z17.B, Z21.B
    SUDOT Z8.S, Z2.B, Z5.B[0x2]
    USMMLA Z6.S, Z6.B, Z6.B
    USMMLA Z28.S, Z15.B, Z28.B
    UMMLA Z5.S, Z9.B, Z27.B
    SUDOT Z20.S, Z21.B, Z7.B[0x1]
    UMMLA Z5.S, Z12.B, Z15.B
    USDOT Z29.S, Z21.B, Z8.B
    USDOT Z19.S, Z26.B, Z27.B
    SUDOT Z30.S, Z21.B, Z7.B[0x0]
    USMMLA Z17.S, Z31.B, Z18.B
    SMMLA Z28.S, Z16.B, Z12.B
    USDOT Z22.S, Z29.B, Z5.B[0x3]
    UMMLA Z9.S, Z11.B, Z11.B
    USDOT Z2.S, Z23.B, Z3.B
    UMMLA Z9.S, Z23.B, Z2.B
    SUDOT Z28.S, Z19.B, Z6.B[0x1]
    SUDOT Z20.S, Z22.B, Z7.B[0x1]
    USMMLA Z20.S, Z5.B, Z17.B
    UMMLA Z20.S, Z7.B, Z30.B
    SMMLA Z25.S, Z21.B, Z9.B
    USMMLA Z25.S, Z20.B, Z17.B
    USDOT Z9.S, Z6.B, Z4.B[0x0]
    USDOT Z10.S, Z16.B, Z1.B[0x3]
    SMMLA Z27.S, Z31.B, Z8.B
    SUDOT Z18.S, Z1.B, Z6.B[0x1]
    USDOT Z22.S, Z14.B, Z13.B
    USDOT Z28.S, Z17.B, Z0.B[0x2]
    USDOT Z24.S, Z26.B, Z0.B
    SMMLA Z15.S, Z9.B, Z8.B
    USDOT Z17.S, Z15.B, Z11.B
    UMMLA Z27.S, Z17.B, Z29.B
    SUDOT Z16.S, Z16.B, Z2.B[0x0]
    UMMLA Z8.S, Z1.B, Z2.B
    USMMLA Z28.S, Z10.B, Z24.B
    SMMLA Z28.S, Z8.B, Z22.B
    UMMLA Z19.S, Z16.B, Z27.B
    SUDOT Z18.S, Z5.B, Z7.B[0x2]
    USDOT Z16.S, Z11.B, Z0.B
    UMMLA Z19.S, Z16.B, Z16.B
    SUDOT Z23.S, Z25.B, Z1.B[0x0]
    UMMLA Z18.S, Z31.B, Z30.B
    SUDOT Z28.S, Z0.B, Z4.B[0x1]
    USDOT Z28.S, Z19.B, Z5.B[0x3]
    USDOT Z7.S, Z30.B, Z6.B[0x1]
    SUDOT Z28.S, Z23.B, Z7.B[0x1]
    SMMLA Z30.S, Z6.B, Z17.B
    USMMLA Z27.S, Z26.B, Z3.B
    SUDOT Z18.S, Z1.B, Z2.B[0x0]
    UMMLA Z4.S, Z20.B, Z25.B
    USDOT Z10.S, Z20.B, Z4.B[0x1]
    USDOT Z3.S, Z24.B, Z17.B
    SUDOT Z24.S, Z8.B, Z1.B[0x1]
    SUDOT Z29.S, Z0.B, Z4.B[0x1]
    SUDOT Z20.S, Z16.B, Z1.B[0x0]
    SMMLA Z10.S, Z18.B, Z18.B
    SUDOT Z11.S, Z1.B, Z3.B[0x2]
    USDOT Z20.S, Z24.B, Z29.B
    SUDOT Z4.S, Z11.B, Z5.B[0x3]
    USDOT Z10.S, Z10.B, Z30.B
    USDOT Z28.S, Z4.B, Z2.B[0x0]
    USDOT Z6.S, Z18.B, Z0.B[0x2]
    SUDOT Z20.S, Z28.B, Z6.B[0x3]
    UMMLA Z27.S, Z25.B, Z21.B
    SUDOT Z16.S, Z11.B, Z4.B[0x3]
    USMMLA Z11.S, Z10.B, Z16.B
    UMMLA Z15.S, Z23.B, Z11.B
    USDOT Z27.S, Z8.B, Z5.B[0x2]
    SMMLA Z20.S, Z27.B, Z21.B
    SMMLA Z24.S, Z13.B, Z3.B
    USDOT Z18.S, Z6.B, Z24.B
    SUDOT Z4.S, Z4.B, Z1.B[0x0]
    USDOT Z10.S, Z28.B, Z6.B[0x1]
    SUDOT Z1.S, Z14.B, Z2.B[0x1]
    SMMLA Z20.S, Z30.B, Z17.B
    USDOT Z26.S, Z13.B, Z3.B[0x3]
    SMMLA Z8.S, Z24.B, Z24.B
    SMMLA Z3.S, Z20.B, Z5.B
    UMMLA Z7.S, Z18.B, Z4.B
    USDOT Z4.S, Z6.B, Z16.B
    USMMLA Z6.S, Z5.B, Z0.B
    SUDOT Z1.S, Z6.B, Z7.B[0x2]
    SUDOT Z26.S, Z1.B, Z3.B[0x2]
    UMMLA Z17.S, Z1.B, Z15.B
    SMMLA Z15.S, Z4.B, Z26.B
    USDOT Z8.S, Z31.B, Z5.B[0x0]
    USDOT Z10.S, Z15.B, Z5.B[0x0]
    SMMLA Z18.S, Z8.B, Z22.B
    USDOT Z13.S, Z10.B, Z17.B
    SMMLA Z25.S, Z4.B, Z2.B
    USMMLA Z12.S, Z13.B, Z0.B
    USMMLA Z14.S, Z27.B, Z4.B
    USMMLA Z10.S, Z8.B, Z3.B
    SUDOT Z17.S, Z26.B, Z5.B[0x1]
    USDOT Z12.S, Z30.B, Z2.B[0x1]
    SMMLA Z11.S, Z13.B, Z22.B
    UMMLA Z13.S, Z30.B, Z3.B
    SMMLA Z26.S, Z11.B, Z17.B
    SMMLA Z22.S, Z18.B, Z11.B
    SMMLA Z25.S, Z8.B, Z15.B
    UMMLA Z10.S, Z22.B, Z11.B
    SMMLA Z11.S, Z24.B, Z23.B
    USDOT Z5.S, Z29.B, Z29.B
    USMMLA Z22.S, Z29.B, Z28.B
    UMMLA Z12.S, Z14.B, Z14.B
    SUDOT Z28.S, Z1.B, Z5.B[0x3]
    UMMLA Z28.S, Z4.B, Z10.B
    SMMLA Z6.S, Z16.B, Z22.B
    UMMLA Z28.S, Z25.B, Z25.B
    UMMLA Z28.S, Z6.B, Z6.B
    USMMLA Z26.S, Z17.B, Z15.B
    UMMLA Z15.S, Z26.B, Z28.B
    SUDOT Z0.S, Z2.B, Z2.B[0x0]
    USDOT Z27.S, Z22.B, Z13.B
    USDOT Z4.S, Z27.B, Z0.B[0x3]
    UMMLA Z12.S, Z4.B, Z18.B
    SUDOT Z12.S, Z5.B, Z7.B[0x3]
    USDOT Z15.S, Z22.B, Z1.B[0x0]
    USMMLA Z15.S, Z29.B, Z8.B
    SMMLA Z7.S, Z18.B, Z11.B
    USDOT Z12.S, Z31.B, Z0.B[0x2]
    USMMLA Z15.S, Z23.B, Z7.B
    USDOT Z9.S, Z18.B, Z5.B[0x2]
    SMMLA Z21.S, Z3.B, Z0.B
    USDOT Z21.S, Z26.B, Z2.B[0x1]
    SUDOT Z29.S, Z6.B, Z0.B[0x0]
    SUBS  X9, X9, #0x1
    B.NE  LCRTSveVectorI8MM_label_11
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTSveVectorI8MM_TestFail
    MRS  X6, FPSR
    MOVZ  X8, #0x80, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FMOV  X6, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    MOVZ  X6, #0x0, LSL #0
    STR  X6, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X6, [X0, #0]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
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
    FMOV  X6, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P0, Z1.D
    FMOV  X6, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P2, Z2.D
    FMOV  X6, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P4, Z3.D
    FMOV  X6, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X6, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X6, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X6, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X6, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X6, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X6, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X6, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X6, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X6, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P0, Z13.D
    FMOV  X6, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X6, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X6, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X6, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X6, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P7, Z18.D
    FMOV  X6, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X6, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X6, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X6, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X6, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X6, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X6, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P7, Z25.D
    FMOV  X6, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X6, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P7, Z27.D
    FMOV  X6, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X6, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X6, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X6, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X6, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X29
    DUP     Z1.D, X20
    DUP     Z2.D, X21
    DUP     Z3.D, X16
    DUP     Z4.D, X23
    DUP     Z5.D, X13
    DUP     Z6.D, X21
    DUP     Z7.D, X19
    DUP     Z8.D, X10
    DUP     Z9.D, X18
    DUP     Z10.D, X7
    DUP     Z11.D, X22
    DUP     Z12.D, X9
    DUP     Z13.D, X16
    DUP     Z14.D, X7
    DUP     Z15.D, X7
    DUP     Z16.D, X9
    DUP     Z17.D, X12
    DUP     Z18.D, X4
    DUP     Z19.D, X8
    DUP     Z20.D, X20
    DUP     Z21.D, X21
    DUP     Z22.D, X7
    DUP     Z23.D, X20
    DUP     Z24.D, X17
    DUP     Z25.D, X2
    DUP     Z26.D, X19
    DUP     Z27.D, X13
    DUP     Z28.D, X13
    DUP     Z29.D, X3
    DUP     Z30.D, X5
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
    MOVZ  X2, #0xa, LSL #0
LCRTSveVectorI8MM_label_12:
    SMMLA Z22.S, Z31.B, Z18.B
    SMMLA Z22.S, Z22.B, Z30.B
    SUDOT Z23.S, Z22.B, Z6.B[0x2]
    USDOT Z23.S, Z21.B, Z2.B[0x3]
    USDOT Z23.S, Z18.B, Z6.B[0x3]
    UMMLA Z23.S, Z23.B, Z25.B
    USDOT Z13.S, Z2.B, Z23.B
    UMMLA Z31.S, Z7.B, Z0.B
    USDOT Z27.S, Z0.B, Z7.B[0x3]
    SMMLA Z31.S, Z27.B, Z28.B
    USDOT Z14.S, Z10.B, Z7.B[0x1]
    USMMLA Z20.S, Z31.B, Z13.B
    USDOT Z16.S, Z14.B, Z2.B[0x1]
    USMMLA Z27.S, Z5.B, Z9.B
    SUDOT Z18.S, Z20.B, Z6.B[0x1]
    SUDOT Z28.S, Z24.B, Z7.B[0x0]
    USDOT Z7.S, Z27.B, Z6.B[0x0]
    SUDOT Z18.S, Z20.B, Z1.B[0x3]
    SUDOT Z9.S, Z13.B, Z2.B[0x0]
    SMMLA Z8.S, Z25.B, Z16.B
    SUDOT Z24.S, Z3.B, Z6.B[0x2]
    SUDOT Z27.S, Z23.B, Z7.B[0x2]
    SMMLA Z21.S, Z19.B, Z20.B
    USDOT Z9.S, Z26.B, Z6.B
    USDOT Z1.S, Z11.B, Z4.B[0x3]
    USDOT Z5.S, Z7.B, Z3.B[0x3]
    USDOT Z17.S, Z24.B, Z1.B[0x3]
    USDOT Z19.S, Z20.B, Z28.B
    SUDOT Z11.S, Z19.B, Z5.B[0x1]
    SMMLA Z0.S, Z27.B, Z27.B
    USDOT Z12.S, Z17.B, Z9.B
    SMMLA Z24.S, Z0.B, Z8.B
    UMMLA Z18.S, Z18.B, Z24.B
    USDOT Z31.S, Z18.B, Z9.B
    USMMLA Z26.S, Z11.B, Z22.B
    USMMLA Z12.S, Z15.B, Z7.B
    SUDOT Z9.S, Z7.B, Z0.B[0x0]
    USMMLA Z21.S, Z31.B, Z27.B
    SUDOT Z21.S, Z9.B, Z7.B[0x2]
    USDOT Z5.S, Z26.B, Z5.B[0x2]
    UMMLA Z12.S, Z12.B, Z1.B
    USMMLA Z5.S, Z21.B, Z21.B
    USMMLA Z3.S, Z15.B, Z0.B
    USDOT Z20.S, Z6.B, Z5.B[0x3]
    SUDOT Z15.S, Z31.B, Z0.B[0x1]
    SMMLA Z14.S, Z12.B, Z8.B
    SUDOT Z2.S, Z16.B, Z2.B[0x2]
    SMMLA Z11.S, Z31.B, Z30.B
    UMMLA Z16.S, Z30.B, Z9.B
    USDOT Z10.S, Z2.B, Z30.B
    USMMLA Z2.S, Z18.B, Z21.B
    UMMLA Z27.S, Z12.B, Z28.B
    UMMLA Z2.S, Z11.B, Z14.B
    USDOT Z27.S, Z18.B, Z20.B
    SUDOT Z10.S, Z10.B, Z3.B[0x3]
    SMMLA Z15.S, Z27.B, Z8.B
    USMMLA Z25.S, Z16.B, Z31.B
    USMMLA Z21.S, Z5.B, Z25.B
    USDOT Z12.S, Z19.B, Z15.B
    UMMLA Z12.S, Z14.B, Z24.B
    SMMLA Z14.S, Z18.B, Z12.B
    SMMLA Z2.S, Z10.B, Z14.B
    SUDOT Z2.S, Z8.B, Z3.B[0x1]
    UMMLA Z27.S, Z28.B, Z27.B
    UMMLA Z31.S, Z26.B, Z10.B
    SUDOT Z23.S, Z22.B, Z0.B[0x1]
    SMMLA Z1.S, Z2.B, Z6.B
    SMMLA Z5.S, Z30.B, Z8.B
    USDOT Z7.S, Z0.B, Z7.B[0x1]
    USDOT Z4.S, Z20.B, Z5.B
    USDOT Z15.S, Z9.B, Z7.B[0x2]
    USDOT Z0.S, Z16.B, Z12.B
    SUDOT Z15.S, Z0.B, Z5.B[0x2]
    USMMLA Z26.S, Z19.B, Z10.B
    UMMLA Z0.S, Z26.B, Z15.B
    USDOT Z12.S, Z11.B, Z12.B
    USDOT Z13.S, Z19.B, Z11.B
    SUDOT Z31.S, Z21.B, Z0.B[0x1]
    USDOT Z12.S, Z31.B, Z4.B[0x1]
    SUDOT Z4.S, Z6.B, Z1.B[0x1]
    USDOT Z23.S, Z8.B, Z4.B[0x3]
    SUDOT Z14.S, Z29.B, Z1.B[0x2]
    SUDOT Z11.S, Z13.B, Z7.B[0x1]
    UMMLA Z25.S, Z14.B, Z11.B
    USDOT Z2.S, Z12.B, Z7.B[0x0]
    SUDOT Z25.S, Z2.B, Z5.B[0x1]
    UMMLA Z25.S, Z25.B, Z10.B
    USDOT Z3.S, Z2.B, Z23.B
    SMMLA Z3.S, Z3.B, Z7.B
    USDOT Z11.S, Z10.B, Z1.B[0x3]
    SMMLA Z25.S, Z3.B, Z12.B
    SUDOT Z12.S, Z11.B, Z7.B[0x0]
    USDOT Z21.S, Z12.B, Z0.B[0x3]
    USDOT Z0.S, Z25.B, Z1.B[0x3]
    USMMLA Z7.S, Z9.B, Z27.B
    SUDOT Z21.S, Z3.B, Z5.B[0x1]
    SMMLA Z0.S, Z7.B, Z14.B
    USDOT Z5.S, Z9.B, Z6.B[0x1]
    SMMLA Z8.S, Z28.B, Z15.B
    USDOT Z28.S, Z29.B, Z2.B[0x1]
    USMMLA Z11.S, Z15.B, Z7.B
    USDOT Z25.S, Z15.B, Z14.B
    SMMLA Z24.S, Z14.B, Z3.B
    USDOT Z12.S, Z16.B, Z0.B[0x3]
    USDOT Z24.S, Z15.B, Z3.B[0x2]
    USMMLA Z7.S, Z14.B, Z15.B
    SUDOT Z7.S, Z24.B, Z4.B[0x1]
    USDOT Z12.S, Z21.B, Z25.B
    USMMLA Z7.S, Z28.B, Z11.B
    UMMLA Z8.S, Z8.B, Z7.B
    SMMLA Z8.S, Z12.B, Z16.B
    SUDOT Z31.S, Z2.B, Z2.B[0x2]
    SUDOT Z20.S, Z5.B, Z5.B[0x0]
    USMMLA Z13.S, Z2.B, Z21.B
    USMMLA Z18.S, Z17.B, Z31.B
    USDOT Z3.S, Z3.B, Z29.B
    SMMLA Z1.S, Z16.B, Z23.B
    UMMLA Z6.S, Z19.B, Z13.B
    SMMLA Z0.S, Z29.B, Z27.B
    USMMLA Z10.S, Z19.B, Z5.B
    SMMLA Z27.S, Z21.B, Z30.B
    SUDOT Z0.S, Z3.B, Z3.B[0x1]
    SUDOT Z4.S, Z7.B, Z0.B[0x1]
    SUDOT Z27.S, Z1.B, Z6.B[0x2]
    UMMLA Z19.S, Z6.B, Z8.B
    USMMLA Z20.S, Z10.B, Z10.B
    USMMLA Z12.S, Z20.B, Z27.B
    USDOT Z1.S, Z18.B, Z4.B[0x2]
    USMMLA Z19.S, Z12.B, Z9.B
    USMMLA Z5.S, Z20.B, Z18.B
    USDOT Z24.S, Z23.B, Z1.B[0x3]
    USDOT Z1.S, Z26.B, Z15.B
    UMMLA Z16.S, Z22.B, Z26.B
    UMMLA Z21.S, Z31.B, Z13.B
    UMMLA Z3.S, Z7.B, Z27.B
    UMMLA Z28.S, Z16.B, Z21.B
    SMMLA Z8.S, Z14.B, Z16.B
    USDOT Z16.S, Z21.B, Z28.B
    USMMLA Z21.S, Z2.B, Z28.B
    SUDOT Z0.S, Z14.B, Z1.B[0x3]
    SUDOT Z24.S, Z22.B, Z3.B[0x2]
    USDOT Z13.S, Z24.B, Z6.B[0x3]
    UMMLA Z19.S, Z9.B, Z5.B
    USMMLA Z7.S, Z2.B, Z3.B
    SMMLA Z1.S, Z30.B, Z0.B
    USDOT Z19.S, Z16.B, Z3.B[0x0]
    USDOT Z2.S, Z31.B, Z3.B
    USDOT Z8.S, Z1.B, Z30.B
    USDOT Z16.S, Z31.B, Z25.B
    USDOT Z4.S, Z1.B, Z6.B
    SMMLA Z3.S, Z9.B, Z2.B
    SMMLA Z4.S, Z28.B, Z3.B
    USMMLA Z21.S, Z8.B, Z15.B
    USDOT Z20.S, Z29.B, Z7.B[0x0]
    USDOT Z5.S, Z11.B, Z6.B[0x0]
    SUDOT Z13.S, Z1.B, Z7.B[0x3]
    UMMLA Z16.S, Z10.B, Z9.B
    UMMLA Z26.S, Z9.B, Z15.B
    UMMLA Z13.S, Z14.B, Z16.B
    SMMLA Z3.S, Z17.B, Z4.B
    USDOT Z19.S, Z11.B, Z5.B[0x2]
    UMMLA Z29.S, Z13.B, Z2.B
    SUDOT Z20.S, Z9.B, Z1.B[0x1]
    USDOT Z23.S, Z0.B, Z9.B
    USDOT Z22.S, Z25.B, Z2.B[0x1]
    USMMLA Z14.S, Z3.B, Z26.B
    USDOT Z22.S, Z9.B, Z10.B
    SMMLA Z27.S, Z24.B, Z2.B
    SMMLA Z5.S, Z28.B, Z10.B
    SUDOT Z21.S, Z27.B, Z2.B[0x0]
    USDOT Z21.S, Z16.B, Z19.B
    USMMLA Z28.S, Z14.B, Z5.B
    USMMLA Z7.S, Z28.B, Z21.B
    UMMLA Z23.S, Z6.B, Z22.B
    USDOT Z29.S, Z7.B, Z20.B
    USDOT Z25.S, Z26.B, Z21.B
    UMMLA Z27.S, Z16.B, Z22.B
    USMMLA Z21.S, Z5.B, Z26.B
    USDOT Z27.S, Z31.B, Z25.B
    SUDOT Z7.S, Z21.B, Z4.B[0x1]
    USMMLA Z13.S, Z7.B, Z20.B
    USMMLA Z25.S, Z24.B, Z16.B
    UMMLA Z15.S, Z11.B, Z5.B
    USMMLA Z7.S, Z4.B, Z7.B
    USMMLA Z13.S, Z23.B, Z16.B
    USMMLA Z10.S, Z13.B, Z20.B
    SMMLA Z20.S, Z18.B, Z8.B
    USDOT Z7.S, Z0.B, Z16.B
    SUDOT Z4.S, Z15.B, Z4.B[0x2]
    USDOT Z31.S, Z18.B, Z12.B
    SUDOT Z27.S, Z5.B, Z5.B[0x3]
    UMMLA Z0.S, Z0.B, Z19.B
    USDOT Z9.S, Z2.B, Z20.B
    SMMLA Z31.S, Z12.B, Z7.B
    SUDOT Z25.S, Z0.B, Z7.B[0x3]
    USDOT Z27.S, Z4.B, Z4.B[0x1]
    SMMLA Z27.S, Z24.B, Z13.B
    USDOT Z27.S, Z31.B, Z29.B
    USDOT Z25.S, Z3.B, Z2.B[0x2]
    USDOT Z10.S, Z31.B, Z3.B[0x0]
    SUBS  X2, X2, #0x1
    B.NE  LCRTSveVectorI8MM_label_12
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTSveVectorI8MM_TestFail
    MRS  X11, FPSR
    MOVZ  X22, #0x80, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X22, #0x4ce8, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0x4ce8, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D0
    MOVZ  X22, #0x4ce8, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0x4ce8, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X22, #0xfe7, LSL #0
    MOVK  X22, #0x2, LSL #16
    MOVK  X22, #0xfe7, LSL #32
    MOVK  X22, #0x2, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D1
    MOVZ  X22, #0xfe7, LSL #0
    MOVK  X22, #0x2, LSL #16
    MOVK  X22, #0xfe7, LSL #32
    MOVK  X22, #0x2, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X22, #0x81c5, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0x81c5, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D2
    MOVZ  X22, #0x81c5, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0x81c5, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X22, #0xc87d, LSL #0
    MOVK  X22, #0xb, LSL #16
    MOVK  X22, #0xc87d, LSL #32
    MOVK  X22, #0xb, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D3
    MOVZ  X22, #0xc87d, LSL #0
    MOVK  X22, #0xb, LSL #16
    MOVK  X22, #0xc87d, LSL #32
    MOVK  X22, #0xb, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X22, #0xc818, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xc818, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D4
    MOVZ  X22, #0xc818, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xc818, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X22, #0x76e, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0x76e, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D5
    MOVZ  X22, #0x76e, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0x76e, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X22, #0x609b, LSL #0
    MOVK  X22, #0x10, LSL #16
    MOVK  X22, #0x609b, LSL #32
    MOVK  X22, #0x10, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D6
    MOVZ  X22, #0x609b, LSL #0
    MOVK  X22, #0x10, LSL #16
    MOVK  X22, #0x609b, LSL #32
    MOVK  X22, #0x10, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X22, #0xb328, LSL #0
    MOVK  X22, #0xfff7, LSL #16
    MOVK  X22, #0xb328, LSL #32
    MOVK  X22, #0xfff7, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D7
    MOVZ  X22, #0xb328, LSL #0
    MOVK  X22, #0xfff7, LSL #16
    MOVK  X22, #0xb328, LSL #32
    MOVK  X22, #0xfff7, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X22, #0x7e54, LSL #0
    MOVK  X22, #0xe, LSL #16
    MOVK  X22, #0x7e54, LSL #32
    MOVK  X22, #0xe, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D8
    MOVZ  X22, #0x7e54, LSL #0
    MOVK  X22, #0xe, LSL #16
    MOVK  X22, #0x7e54, LSL #32
    MOVK  X22, #0xe, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X22, #0x7de9, LSL #0
    MOVK  X22, #0x7de9, LSL #32
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D9
    MOVZ  X22, #0x7de9, LSL #0
    MOVK  X22, #0x7de9, LSL #32
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X22, #0xc7f, LSL #0
    MOVK  X22, #0x2, LSL #16
    MOVK  X22, #0xc7f, LSL #32
    MOVK  X22, #0x2, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D10
    MOVZ  X22, #0xc7f, LSL #0
    MOVK  X22, #0x2, LSL #16
    MOVK  X22, #0xc7f, LSL #32
    MOVK  X22, #0x2, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X22, #0x933f, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0x933f, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D11
    MOVZ  X22, #0x933f, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0x933f, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X22, #0xe689, LSL #0
    MOVK  X22, #0x1d, LSL #16
    MOVK  X22, #0xe689, LSL #32
    MOVK  X22, #0x1d, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D12
    MOVZ  X22, #0xe689, LSL #0
    MOVK  X22, #0x1d, LSL #16
    MOVK  X22, #0xe689, LSL #32
    MOVK  X22, #0x1d, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X22, #0xf8b3, LSL #0
    MOVK  X22, #0xc, LSL #16
    MOVK  X22, #0xf8b3, LSL #32
    MOVK  X22, #0xc, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D13
    MOVZ  X22, #0xf8b3, LSL #0
    MOVK  X22, #0xc, LSL #16
    MOVK  X22, #0xf8b3, LSL #32
    MOVK  X22, #0xc, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X22, #0xca0c, LSL #0
    MOVK  X22, #0xfffd, LSL #16
    MOVK  X22, #0xca0c, LSL #32
    MOVK  X22, #0xfffd, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D14
    MOVZ  X22, #0xca0c, LSL #0
    MOVK  X22, #0xfffd, LSL #16
    MOVK  X22, #0xca0c, LSL #32
    MOVK  X22, #0xfffd, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X22, #0xc563, LSL #0
    MOVK  X22, #0x14, LSL #16
    MOVK  X22, #0xc563, LSL #32
    MOVK  X22, #0x14, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D15
    MOVZ  X22, #0xc563, LSL #0
    MOVK  X22, #0x14, LSL #16
    MOVK  X22, #0xc563, LSL #32
    MOVK  X22, #0x14, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X22, #0xd09d, LSL #0
    MOVK  X22, #0x25, LSL #16
    MOVK  X22, #0xd09d, LSL #32
    MOVK  X22, #0x25, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D16
    MOVZ  X22, #0xd09d, LSL #0
    MOVK  X22, #0x25, LSL #16
    MOVK  X22, #0xd09d, LSL #32
    MOVK  X22, #0x25, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X22, #0xd0bf, LSL #0
    MOVK  X22, #0xd0bf, LSL #32
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D17
    MOVZ  X22, #0xd0bf, LSL #0
    MOVK  X22, #0xd0bf, LSL #32
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X22, #0x685e, LSL #0
    MOVK  X22, #0xc, LSL #16
    MOVK  X22, #0x685e, LSL #32
    MOVK  X22, #0xc, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D18
    MOVZ  X22, #0x685e, LSL #0
    MOVK  X22, #0xc, LSL #16
    MOVK  X22, #0x685e, LSL #32
    MOVK  X22, #0xc, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X22, #0x5274, LSL #0
    MOVK  X22, #0x19, LSL #16
    MOVK  X22, #0x5274, LSL #32
    MOVK  X22, #0x19, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D19
    MOVZ  X22, #0x5274, LSL #0
    MOVK  X22, #0x19, LSL #16
    MOVK  X22, #0x5274, LSL #32
    MOVK  X22, #0x19, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X22, #0xd925, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xd925, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D20
    MOVZ  X22, #0xd925, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xd925, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X22, #0x49a9, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0x49a9, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D21
    MOVZ  X22, #0x49a9, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0x49a9, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X22, #0x7651, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0x7651, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D22
    MOVZ  X22, #0x7651, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0x7651, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X22, #0x3ab9, LSL #0
    MOVK  X22, #0x1a, LSL #16
    MOVK  X22, #0x3ab9, LSL #32
    MOVK  X22, #0x1a, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D23
    MOVZ  X22, #0x3ab9, LSL #0
    MOVK  X22, #0x1a, LSL #16
    MOVK  X22, #0x3ab9, LSL #32
    MOVK  X22, #0x1a, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X22, #0xddc5, LSL #0
    MOVK  X22, #0xddc5, LSL #32
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D24
    MOVZ  X22, #0xddc5, LSL #0
    MOVK  X22, #0xddc5, LSL #32
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X22, #0x6fa2, LSL #0
    MOVK  X22, #0x1f, LSL #16
    MOVK  X22, #0x6fa2, LSL #32
    MOVK  X22, #0x1f, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D25
    MOVZ  X22, #0x6fa2, LSL #0
    MOVK  X22, #0x1f, LSL #16
    MOVK  X22, #0x6fa2, LSL #32
    MOVK  X22, #0x1f, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X22, #0xf44f, LSL #0
    MOVK  X22, #0x6, LSL #16
    MOVK  X22, #0xf44f, LSL #32
    MOVK  X22, #0x6, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D26
    MOVZ  X22, #0xf44f, LSL #0
    MOVK  X22, #0x6, LSL #16
    MOVK  X22, #0xf44f, LSL #32
    MOVK  X22, #0x6, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X22, #0x667, LSL #0
    MOVK  X22, #0x26, LSL #16
    MOVK  X22, #0x667, LSL #32
    MOVK  X22, #0x26, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D27
    MOVZ  X22, #0x667, LSL #0
    MOVK  X22, #0x26, LSL #16
    MOVK  X22, #0x667, LSL #32
    MOVK  X22, #0x26, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X22, #0xfaa5, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0xfaa5, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D28
    MOVZ  X22, #0xfaa5, LSL #0
    MOVK  X22, #0xf, LSL #16
    MOVK  X22, #0xfaa5, LSL #32
    MOVK  X22, #0xf, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X22, #0x14dd, LSL #0
    MOVK  X22, #0xb, LSL #16
    MOVK  X22, #0x14dd, LSL #32
    MOVK  X22, #0xb, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D29
    MOVZ  X22, #0x14dd, LSL #0
    MOVK  X22, #0xb, LSL #16
    MOVK  X22, #0x14dd, LSL #32
    MOVK  X22, #0xb, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D30
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X22, #0xddf9, LSL #0
    MOVK  X22, #0x1e, LSL #16
    MOVK  X22, #0xddf9, LSL #32
    MOVK  X22, #0x1e, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FMOV  X11, D31
    MOVZ  X22, #0xddf9, LSL #0
    MOVK  X22, #0x1e, LSL #16
    MOVK  X22, #0xddf9, LSL #32
    MOVK  X22, #0x1e, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    MOVZ  X11, #0x0, LSL #0
    STR  X11, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X11, [X0, #0]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
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
    FMOV  X11, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P2, Z1.D
    FMOV  X11, D1
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X11, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X11, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X11, D4
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X11, D5
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X11, D6
    MOVZ  X22, #0x609b, LSL #0
    MOVK  X22, #0x10, LSL #16
    MOVK  X22, #0x609b, LSL #32
    MOVK  X22, #0x30, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X11, D7
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P3, Z8.D
    FMOV  X11, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P1, Z9.D
    FMOV  X11, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P3, Z10.D
    FMOV  X11, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P7, Z11.D
    FMOV  X11, D11
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P1, Z12.D
    FMOV  X11, D12
    MOVZ  X22, #0xe689, LSL #0
    MOVK  X22, #0x1d, LSL #16
    MOVK  X22, #0xe689, LSL #32
    MOVK  X22, #0x3d, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X11, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X11, D14
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X11, D15
    MOVZ  X22, #0xc563, LSL #0
    MOVK  X22, #0x14, LSL #16
    MOVK  X22, #0xc563, LSL #32
    MOVK  X22, #0x34, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X11, D16
    MOVZ  X22, #0xd09d, LSL #0
    MOVK  X22, #0x25, LSL #16
    MOVK  X22, #0xd09d, LSL #32
    MOVK  X22, #0x45, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X11, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X11, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X11, D19
    MOVZ  X22, #0x5274, LSL #0
    MOVK  X22, #0x19, LSL #16
    MOVK  X22, #0x5274, LSL #32
    MOVK  X22, #0x39, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X11, D20
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X11, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X11, D22
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X11, D23
    MOVZ  X22, #0x3ab9, LSL #0
    MOVK  X22, #0x1a, LSL #16
    MOVK  X22, #0x3ab9, LSL #32
    MOVK  X22, #0x3a, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P6, Z24.D
    FMOV  X11, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X11, D25
    MOVZ  X22, #0x6fa2, LSL #0
    MOVK  X22, #0x1f, LSL #16
    MOVK  X22, #0x6fa2, LSL #32
    MOVK  X22, #0x3f, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X11, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X11, D27
    MOVZ  X22, #0x667, LSL #0
    MOVK  X22, #0x26, LSL #16
    MOVK  X22, #0x667, LSL #32
    MOVK  X22, #0x46, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X11, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P1, Z29.D
    FMOV  X11, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X11, D30
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P3, Z31.D
    FMOV  X11, D31
    MOVZ  X22, #0xddf9, LSL #0
    MOVK  X22, #0x1e, LSL #16
    MOVK  X22, #0xddf9, LSL #32
    MOVK  X22, #0x3e, LSL #48
    SUB  X16, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X29
    DUP     Z1.D, X29
    DUP     Z2.D, X14
    DUP     Z3.D, X2
    DUP     Z4.D, X9
    DUP     Z5.D, X19
    DUP     Z6.D, X22
    DUP     Z7.D, X20
    DUP     Z8.D, X23
    DUP     Z9.D, X11
    DUP     Z10.D, X5
    DUP     Z11.D, X29
    DUP     Z12.D, X14
    DUP     Z13.D, X14
    DUP     Z14.D, X5
    DUP     Z15.D, X19
    DUP     Z16.D, X9
    DUP     Z17.D, X29
    DUP     Z18.D, X23
    DUP     Z19.D, X3
    DUP     Z20.D, X11
    DUP     Z21.D, X2
    DUP     Z22.D, X4
    DUP     Z23.D, X17
    DUP     Z24.D, X22
    DUP     Z25.D, X4
    DUP     Z26.D, X23
    DUP     Z27.D, X29
    DUP     Z28.D, X14
    DUP     Z29.D, X16
    DUP     Z30.D, X16
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
    MOVZ  X29, #0xa, LSL #0
LCRTSveVectorI8MM_label_13:
    USMMLA Z17.S, Z30.B, Z8.B
    USMMLA Z23.S, Z31.B, Z31.B
    USDOT Z23.S, Z23.B, Z3.B[0x2]
    USDOT Z25.S, Z15.B, Z23.B
    SMMLA Z25.S, Z25.B, Z25.B
    USMMLA Z17.S, Z31.B, Z26.B
    SMMLA Z22.S, Z17.B, Z2.B
    USDOT Z29.S, Z22.B, Z27.B
    UMMLA Z25.S, Z29.B, Z30.B
    UMMLA Z16.S, Z19.B, Z13.B
    SUDOT Z11.S, Z5.B, Z7.B[0x1]
    SUDOT Z27.S, Z30.B, Z3.B[0x3]
    SUDOT Z10.S, Z25.B, Z2.B[0x3]
    UMMLA Z2.S, Z9.B, Z10.B
    USDOT Z27.S, Z24.B, Z1.B
    USDOT Z12.S, Z29.B, Z5.B[0x1]
    USDOT Z25.S, Z14.B, Z11.B
    USMMLA Z31.S, Z21.B, Z23.B
    USDOT Z13.S, Z29.B, Z25.B
    SMMLA Z14.S, Z3.B, Z15.B
    USDOT Z4.S, Z15.B, Z17.B
    USDOT Z24.S, Z1.B, Z22.B
    USMMLA Z28.S, Z24.B, Z16.B
    SMMLA Z13.S, Z31.B, Z15.B
    USDOT Z27.S, Z20.B, Z4.B[0x1]
    SUDOT Z23.S, Z31.B, Z7.B[0x2]
    UMMLA Z28.S, Z14.B, Z2.B
    USDOT Z29.S, Z10.B, Z27.B
    USDOT Z23.S, Z9.B, Z12.B
    USDOT Z31.S, Z13.B, Z4.B[0x0]
    USDOT Z23.S, Z28.B, Z1.B[0x1]
    USDOT Z25.S, Z1.B, Z0.B[0x3]
    UMMLA Z29.S, Z27.B, Z31.B
    UMMLA Z25.S, Z6.B, Z16.B
    USMMLA Z25.S, Z25.B, Z23.B
    USMMLA Z27.S, Z28.B, Z23.B
    USDOT Z22.S, Z29.B, Z1.B[0x1]
    UMMLA Z12.S, Z28.B, Z21.B
    SMMLA Z6.S, Z8.B, Z12.B
    USDOT Z14.S, Z19.B, Z8.B
    UMMLA Z22.S, Z28.B, Z11.B
    USDOT Z14.S, Z3.B, Z2.B[0x1]
    USMMLA Z0.S, Z8.B, Z16.B
    UMMLA Z5.S, Z23.B, Z8.B
    SUDOT Z12.S, Z28.B, Z2.B[0x1]
    USDOT Z19.S, Z29.B, Z0.B
    USDOT Z22.S, Z22.B, Z15.B
    USDOT Z25.S, Z29.B, Z1.B[0x0]
    USDOT Z5.S, Z27.B, Z5.B[0x2]
    USDOT Z10.S, Z24.B, Z7.B[0x0]
    USMMLA Z6.S, Z24.B, Z11.B
    USDOT Z22.S, Z11.B, Z1.B[0x0]
    SMMLA Z17.S, Z15.B, Z1.B
    USMMLA Z25.S, Z19.B, Z19.B
    USDOT Z22.S, Z21.B, Z6.B[0x2]
    SUDOT Z10.S, Z14.B, Z5.B[0x0]
    UMMLA Z15.S, Z28.B, Z28.B
    USDOT Z19.S, Z18.B, Z3.B
    SUDOT Z22.S, Z19.B, Z0.B[0x3]
    SMMLA Z15.S, Z19.B, Z25.B
    SMMLA Z25.S, Z15.B, Z22.B
    USDOT Z25.S, Z26.B, Z10.B
    SUDOT Z24.S, Z25.B, Z1.B[0x3]
    USDOT Z25.S, Z21.B, Z24.B
    USDOT Z12.S, Z25.B, Z10.B
    SUDOT Z11.S, Z3.B, Z4.B[0x3]
    UMMLA Z9.S, Z22.B, Z21.B
    UMMLA Z30.S, Z20.B, Z28.B
    USMMLA Z27.S, Z27.B, Z27.B
    USMMLA Z7.S, Z6.B, Z19.B
    SMMLA Z30.S, Z3.B, Z27.B
    UMMLA Z19.S, Z13.B, Z19.B
    SUDOT Z17.S, Z30.B, Z2.B[0x0]
    USDOT Z10.S, Z3.B, Z4.B[0x1]
    USDOT Z27.S, Z19.B, Z1.B[0x1]
    USDOT Z23.S, Z11.B, Z2.B[0x2]
    USMMLA Z20.S, Z17.B, Z19.B
    SMMLA Z18.S, Z13.B, Z4.B
    USDOT Z14.S, Z31.B, Z24.B
    UMMLA Z20.S, Z14.B, Z20.B
    USDOT Z7.S, Z11.B, Z20.B
    USMMLA Z9.S, Z7.B, Z18.B
    USMMLA Z23.S, Z0.B, Z23.B
    USMMLA Z24.S, Z23.B, Z10.B
    SUDOT Z9.S, Z30.B, Z3.B[0x2]
    USMMLA Z28.S, Z24.B, Z4.B
    SMMLA Z9.S, Z24.B, Z6.B
    SMMLA Z27.S, Z6.B, Z28.B
    USMMLA Z13.S, Z9.B, Z0.B
    USDOT Z27.S, Z13.B, Z0.B[0x0]
    SUDOT Z12.S, Z19.B, Z2.B[0x2]
    UMMLA Z29.S, Z15.B, Z14.B
    UMMLA Z27.S, Z19.B, Z5.B
    SUDOT Z15.S, Z18.B, Z7.B[0x3]
    SMMLA Z16.S, Z30.B, Z26.B
    USDOT Z30.S, Z16.B, Z17.B
    USMMLA Z10.S, Z0.B, Z8.B
    USDOT Z19.S, Z19.B, Z12.B
    UMMLA Z24.S, Z19.B, Z10.B
    UMMLA Z25.S, Z22.B, Z3.B
    USDOT Z23.S, Z12.B, Z5.B[0x3]
    USDOT Z21.S, Z18.B, Z10.B
    UMMLA Z15.S, Z13.B, Z20.B
    USDOT Z11.S, Z13.B, Z7.B[0x2]
    SUDOT Z24.S, Z30.B, Z7.B[0x3]
    SMMLA Z25.S, Z11.B, Z29.B
    USMMLA Z27.S, Z15.B, Z3.B
    USMMLA Z27.S, Z24.B, Z27.B
    USMMLA Z23.S, Z23.B, Z21.B
    UMMLA Z27.S, Z3.B, Z25.B
    SMMLA Z1.S, Z20.B, Z13.B
    USDOT Z10.S, Z7.B, Z7.B[0x0]
    SMMLA Z4.S, Z10.B, Z17.B
    SMMLA Z18.S, Z25.B, Z22.B
    USMMLA Z21.S, Z12.B, Z15.B
    USDOT Z4.S, Z13.B, Z1.B[0x3]
    USDOT Z28.S, Z26.B, Z24.B
    SMMLA Z19.S, Z9.B, Z1.B
    USMMLA Z3.S, Z24.B, Z9.B
    SUDOT Z25.S, Z0.B, Z5.B[0x1]
    SUDOT Z31.S, Z28.B, Z3.B[0x1]
    USDOT Z21.S, Z21.B, Z4.B[0x0]
    SMMLA Z21.S, Z27.B, Z27.B
    SUDOT Z6.S, Z21.B, Z3.B[0x1]
    USDOT Z14.S, Z6.B, Z19.B
    SMMLA Z16.S, Z14.B, Z18.B
    USDOT Z28.S, Z25.B, Z23.B
    SUDOT Z25.S, Z13.B, Z0.B[0x3]
    SMMLA Z28.S, Z29.B, Z7.B
    USDOT Z31.S, Z31.B, Z1.B[0x2]
    SMMLA Z17.S, Z13.B, Z16.B
    USMMLA Z26.S, Z26.B, Z31.B
    SMMLA Z28.S, Z28.B, Z25.B
    USDOT Z5.S, Z26.B, Z7.B[0x1]
    USDOT Z8.S, Z28.B, Z1.B[0x2]
    USDOT Z31.S, Z0.B, Z4.B[0x0]
    USDOT Z17.S, Z11.B, Z7.B[0x2]
    USDOT Z8.S, Z19.B, Z16.B
    UMMLA Z9.S, Z31.B, Z17.B
    USMMLA Z26.S, Z25.B, Z5.B
    USMMLA Z26.S, Z26.B, Z14.B
    SMMLA Z6.S, Z26.B, Z13.B
    USDOT Z9.S, Z6.B, Z13.B
    SUDOT Z0.S, Z7.B, Z3.B[0x3]
    USDOT Z10.S, Z24.B, Z17.B
    USMMLA Z25.S, Z31.B, Z7.B
    USDOT Z2.S, Z24.B, Z15.B
    SUDOT Z0.S, Z11.B, Z5.B[0x0]
    USDOT Z6.S, Z19.B, Z2.B[0x2]
    USMMLA Z23.S, Z12.B, Z27.B
    USDOT Z3.S, Z16.B, Z5.B[0x2]
    UMMLA Z5.S, Z7.B, Z15.B
    SUDOT Z25.S, Z23.B, Z0.B[0x2]
    USMMLA Z5.S, Z10.B, Z6.B
    UMMLA Z3.S, Z25.B, Z9.B
    USMMLA Z5.S, Z16.B, Z1.B
    SUDOT Z8.S, Z5.B, Z3.B[0x0]
    USDOT Z29.S, Z13.B, Z8.B
    USDOT Z29.S, Z28.B, Z2.B
    SUDOT Z15.S, Z20.B, Z2.B[0x3]
    SMMLA Z7.S, Z14.B, Z12.B
    USMMLA Z31.S, Z11.B, Z7.B
    SUDOT Z15.S, Z20.B, Z7.B[0x1]
    SMMLA Z11.S, Z30.B, Z11.B
    UMMLA Z22.S, Z5.B, Z12.B
    USMMLA Z14.S, Z16.B, Z29.B
    USMMLA Z1.S, Z27.B, Z29.B
    UMMLA Z6.S, Z1.B, Z31.B
    SUDOT Z17.S, Z30.B, Z1.B[0x0]
    SUDOT Z27.S, Z23.B, Z0.B[0x3]
    USDOT Z28.S, Z30.B, Z6.B[0x3]
    UMMLA Z16.S, Z21.B, Z25.B
    USDOT Z25.S, Z16.B, Z6.B[0x1]
    SUDOT Z29.S, Z4.B, Z0.B[0x2]
    USDOT Z15.S, Z28.B, Z3.B[0x3]
    USDOT Z29.S, Z22.B, Z2.B[0x1]
    USMMLA Z30.S, Z11.B, Z25.B
    USDOT Z30.S, Z9.B, Z27.B
    USMMLA Z0.S, Z26.B, Z29.B
    SUDOT Z0.S, Z29.B, Z0.B[0x3]
    USDOT Z14.S, Z10.B, Z0.B[0x3]
    USDOT Z17.S, Z31.B, Z1.B[0x1]
    SMMLA Z24.S, Z30.B, Z14.B
    USDOT Z24.S, Z24.B, Z1.B[0x3]
    SUDOT Z17.S, Z20.B, Z3.B[0x1]
    UMMLA Z11.S, Z24.B, Z15.B
    USMMLA Z21.S, Z10.B, Z2.B
    USDOT Z25.S, Z8.B, Z13.B
    SUDOT Z11.S, Z14.B, Z2.B[0x3]
    USDOT Z22.S, Z1.B, Z3.B[0x0]
    UMMLA Z13.S, Z16.B, Z31.B
    SUDOT Z16.S, Z16.B, Z7.B[0x3]
    USDOT Z14.S, Z4.B, Z6.B[0x1]
    USDOT Z14.S, Z18.B, Z0.B
    SUDOT Z20.S, Z10.B, Z1.B[0x3]
    USMMLA Z5.S, Z25.B, Z5.B
    UMMLA Z15.S, Z5.B, Z22.B
    USDOT Z15.S, Z15.B, Z5.B[0x0]
    SMMLA Z21.S, Z18.B, Z18.B
    SMMLA Z4.S, Z12.B, Z15.B
    SUBS  X29, X29, #0x1
    B.NE  LCRTSveVectorI8MM_label_13
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X2, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MRS  X19, FPSR
    MOVZ  X2, #0x81, LSL #0
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X2, #0x165b, LSL #0
    MOVK  X2, #0x5a6d, LSL #16
    MOVK  X2, #0x165b, LSL #32
    MOVK  X2, #0x5a6d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D0
    MOVZ  X2, #0x165b, LSL #0
    MOVK  X2, #0x5a6d, LSL #16
    MOVK  X2, #0x165b, LSL #32
    MOVK  X2, #0x5a6d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X2, #0xe36c, LSL #0
    MOVK  X2, #0x5a63, LSL #16
    MOVK  X2, #0xe36c, LSL #32
    MOVK  X2, #0x5a63, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D1
    MOVZ  X2, #0xe36c, LSL #0
    MOVK  X2, #0x5a63, LSL #16
    MOVK  X2, #0xe36c, LSL #32
    MOVK  X2, #0x5a63, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X2, #0xcbb0, LSL #0
    MOVK  X2, #0x5a6d, LSL #16
    MOVK  X2, #0xcbb0, LSL #32
    MOVK  X2, #0x5a6d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D2
    MOVZ  X2, #0xcbb0, LSL #0
    MOVK  X2, #0x5a6d, LSL #16
    MOVK  X2, #0xcbb0, LSL #32
    MOVK  X2, #0x5a6d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X2, #0x6695, LSL #0
    MOVK  X2, #0x5a77, LSL #16
    MOVK  X2, #0x6695, LSL #32
    MOVK  X2, #0x5a77, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D3
    MOVZ  X2, #0x6695, LSL #0
    MOVK  X2, #0x5a77, LSL #16
    MOVK  X2, #0x6695, LSL #32
    MOVK  X2, #0x5a77, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X2, #0xb6a2, LSL #0
    MOVK  X2, #0x5a68, LSL #16
    MOVK  X2, #0xb6a2, LSL #32
    MOVK  X2, #0x5a68, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D4
    MOVZ  X2, #0xb6a2, LSL #0
    MOVK  X2, #0x5a68, LSL #16
    MOVK  X2, #0xb6a2, LSL #32
    MOVK  X2, #0x5a68, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X2, #0x4193, LSL #0
    MOVK  X2, #0x5a8d, LSL #16
    MOVK  X2, #0x4193, LSL #32
    MOVK  X2, #0x5a8d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D5
    MOVZ  X2, #0x4193, LSL #0
    MOVK  X2, #0x5a8d, LSL #16
    MOVK  X2, #0x4193, LSL #32
    MOVK  X2, #0x5a8d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X2, #0xe2e5, LSL #0
    MOVK  X2, #0x5a83, LSL #16
    MOVK  X2, #0xe2e5, LSL #32
    MOVK  X2, #0x5a83, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D6
    MOVZ  X2, #0xe2e5, LSL #0
    MOVK  X2, #0x5a83, LSL #16
    MOVK  X2, #0xe2e5, LSL #32
    MOVK  X2, #0x5a83, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X2, #0x667d, LSL #0
    MOVK  X2, #0x5a6a, LSL #16
    MOVK  X2, #0x667d, LSL #32
    MOVK  X2, #0x5a6a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D7
    MOVZ  X2, #0x667d, LSL #0
    MOVK  X2, #0x5a6a, LSL #16
    MOVK  X2, #0x667d, LSL #32
    MOVK  X2, #0x5a6a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X2, #0x189f, LSL #0
    MOVK  X2, #0x5a63, LSL #16
    MOVK  X2, #0x189f, LSL #32
    MOVK  X2, #0x5a63, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D8
    MOVZ  X2, #0x189f, LSL #0
    MOVK  X2, #0x5a63, LSL #16
    MOVK  X2, #0x189f, LSL #32
    MOVK  X2, #0x5a63, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X2, #0xbac0, LSL #0
    MOVK  X2, #0x5a8b, LSL #16
    MOVK  X2, #0xbac0, LSL #32
    MOVK  X2, #0x5a8b, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D9
    MOVZ  X2, #0xbac0, LSL #0
    MOVK  X2, #0x5a8b, LSL #16
    MOVK  X2, #0xbac0, LSL #32
    MOVK  X2, #0x5a8b, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X2, #0x2cb9, LSL #0
    MOVK  X2, #0x5a72, LSL #16
    MOVK  X2, #0x2cb9, LSL #32
    MOVK  X2, #0x5a72, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D10
    MOVZ  X2, #0x2cb9, LSL #0
    MOVK  X2, #0x5a72, LSL #16
    MOVK  X2, #0x2cb9, LSL #32
    MOVK  X2, #0x5a72, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X2, #0x51bb, LSL #0
    MOVK  X2, #0x5a7f, LSL #16
    MOVK  X2, #0x51bb, LSL #32
    MOVK  X2, #0x5a7f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D11
    MOVZ  X2, #0x51bb, LSL #0
    MOVK  X2, #0x5a7f, LSL #16
    MOVK  X2, #0x51bb, LSL #32
    MOVK  X2, #0x5a7f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X2, #0xaa67, LSL #0
    MOVK  X2, #0x5a78, LSL #16
    MOVK  X2, #0xaa67, LSL #32
    MOVK  X2, #0x5a78, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D12
    MOVZ  X2, #0xaa67, LSL #0
    MOVK  X2, #0x5a78, LSL #16
    MOVK  X2, #0xaa67, LSL #32
    MOVK  X2, #0x5a78, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X2, #0x4556, LSL #0
    MOVK  X2, #0x5a74, LSL #16
    MOVK  X2, #0x4556, LSL #32
    MOVK  X2, #0x5a74, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D13
    MOVZ  X2, #0x4556, LSL #0
    MOVK  X2, #0x5a74, LSL #16
    MOVK  X2, #0x4556, LSL #32
    MOVK  X2, #0x5a74, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X2, #0x1d72, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0x1d72, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D14
    MOVZ  X2, #0x1d72, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0x1d72, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X2, #0x7af6, LSL #0
    MOVK  X2, #0x5aa0, LSL #16
    MOVK  X2, #0x7af6, LSL #32
    MOVK  X2, #0x5aa0, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D15
    MOVZ  X2, #0x7af6, LSL #0
    MOVK  X2, #0x5aa0, LSL #16
    MOVK  X2, #0x7af6, LSL #32
    MOVK  X2, #0x5aa0, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X2, #0xdd2, LSL #0
    MOVK  X2, #0x5a87, LSL #16
    MOVK  X2, #0xdd2, LSL #32
    MOVK  X2, #0x5a87, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D16
    MOVZ  X2, #0xdd2, LSL #0
    MOVK  X2, #0x5a87, LSL #16
    MOVK  X2, #0xdd2, LSL #32
    MOVK  X2, #0x5a87, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X2, #0x28c0, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0x28c0, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D17
    MOVZ  X2, #0x28c0, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0x28c0, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X2, #0xef40, LSL #0
    MOVK  X2, #0x5a61, LSL #16
    MOVK  X2, #0xef40, LSL #32
    MOVK  X2, #0x5a61, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D18
    MOVZ  X2, #0xef40, LSL #0
    MOVK  X2, #0x5a61, LSL #16
    MOVK  X2, #0xef40, LSL #32
    MOVK  X2, #0x5a61, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X2, #0xd63c, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0xd63c, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D19
    MOVZ  X2, #0xd63c, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0xd63c, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X2, #0x8f24, LSL #0
    MOVK  X2, #0x5a73, LSL #16
    MOVK  X2, #0x8f24, LSL #32
    MOVK  X2, #0x5a73, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D20
    MOVZ  X2, #0x8f24, LSL #0
    MOVK  X2, #0x5a73, LSL #16
    MOVK  X2, #0x8f24, LSL #32
    MOVK  X2, #0x5a73, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X2, #0xbecb, LSL #0
    MOVK  X2, #0x5a7a, LSL #16
    MOVK  X2, #0xbecb, LSL #32
    MOVK  X2, #0x5a7a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D21
    MOVZ  X2, #0xbecb, LSL #0
    MOVK  X2, #0x5a7a, LSL #16
    MOVK  X2, #0xbecb, LSL #32
    MOVK  X2, #0x5a7a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X2, #0x9501, LSL #0
    MOVK  X2, #0x5a8f, LSL #16
    MOVK  X2, #0x9501, LSL #32
    MOVK  X2, #0x5a8f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D22
    MOVZ  X2, #0x9501, LSL #0
    MOVK  X2, #0x5a8f, LSL #16
    MOVK  X2, #0x9501, LSL #32
    MOVK  X2, #0x5a8f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X2, #0xa9a, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0xa9a, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D23
    MOVZ  X2, #0xa9a, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0xa9a, LSL #32
    MOVK  X2, #0x5a76, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X2, #0xf8f8, LSL #0
    MOVK  X2, #0x5a7b, LSL #16
    MOVK  X2, #0xf8f8, LSL #32
    MOVK  X2, #0x5a7b, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D24
    MOVZ  X2, #0xf8f8, LSL #0
    MOVK  X2, #0x5a7b, LSL #16
    MOVK  X2, #0xf8f8, LSL #32
    MOVK  X2, #0x5a7b, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X2, #0x8c09, LSL #0
    MOVK  X2, #0x5acb, LSL #16
    MOVK  X2, #0x8c09, LSL #32
    MOVK  X2, #0x5acb, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D25
    MOVZ  X2, #0x8c09, LSL #0
    MOVK  X2, #0x5acb, LSL #16
    MOVK  X2, #0x8c09, LSL #32
    MOVK  X2, #0x5acb, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X2, #0x9f9c, LSL #0
    MOVK  X2, #0x5a6a, LSL #16
    MOVK  X2, #0x9f9c, LSL #32
    MOVK  X2, #0x5a6a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D26
    MOVZ  X2, #0x9f9c, LSL #0
    MOVK  X2, #0x5a6a, LSL #16
    MOVK  X2, #0x9f9c, LSL #32
    MOVK  X2, #0x5a6a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X2, #0x39bb, LSL #0
    MOVK  X2, #0x5a9d, LSL #16
    MOVK  X2, #0x39bb, LSL #32
    MOVK  X2, #0x5a9d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D27
    MOVZ  X2, #0x39bb, LSL #0
    MOVK  X2, #0x5a9d, LSL #16
    MOVK  X2, #0x39bb, LSL #32
    MOVK  X2, #0x5a9d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X2, #0x583f, LSL #0
    MOVK  X2, #0x5a7f, LSL #16
    MOVK  X2, #0x583f, LSL #32
    MOVK  X2, #0x5a7f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D28
    MOVZ  X2, #0x583f, LSL #0
    MOVK  X2, #0x5a7f, LSL #16
    MOVK  X2, #0x583f, LSL #32
    MOVK  X2, #0x5a7f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X2, #0x363c, LSL #0
    MOVK  X2, #0x5a8b, LSL #16
    MOVK  X2, #0x363c, LSL #32
    MOVK  X2, #0x5a8b, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D29
    MOVZ  X2, #0x363c, LSL #0
    MOVK  X2, #0x5a8b, LSL #16
    MOVK  X2, #0x363c, LSL #32
    MOVK  X2, #0x5a8b, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X2, #0x8d49, LSL #0
    MOVK  X2, #0x5a6e, LSL #16
    MOVK  X2, #0x8d49, LSL #32
    MOVK  X2, #0x5a6e, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D30
    MOVZ  X2, #0x8d49, LSL #0
    MOVK  X2, #0x5a6e, LSL #16
    MOVK  X2, #0x8d49, LSL #32
    MOVK  X2, #0x5a6e, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X2, #0xabe6, LSL #0
    MOVK  X2, #0x5a72, LSL #16
    MOVK  X2, #0xabe6, LSL #32
    MOVK  X2, #0x5a72, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FMOV  X19, D31
    MOVZ  X2, #0xabe6, LSL #0
    MOVK  X2, #0x5a72, LSL #16
    MOVK  X2, #0xabe6, LSL #32
    MOVK  X2, #0x5a72, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    MOVZ  X19, #0x0, LSL #0
    STR  X19, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X19, [X0, #0]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
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
    FMOV  X19, D0
    MOVZ  X2, #0x165b, LSL #0
    MOVK  X2, #0x5a6d, LSL #16
    MOVK  X2, #0x165b, LSL #32
    MOVK  X2, #0x5a8d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X19, D1
    MOVZ  X2, #0xe36c, LSL #0
    MOVK  X2, #0x5a63, LSL #16
    MOVK  X2, #0xe36c, LSL #32
    MOVK  X2, #0x5a83, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X19, D2
    MOVZ  X2, #0xcbb0, LSL #0
    MOVK  X2, #0x5a6d, LSL #16
    MOVK  X2, #0xcbb0, LSL #32
    MOVK  X2, #0x5a8d, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X19, D3
    MOVZ  X2, #0x6695, LSL #0
    MOVK  X2, #0x5a77, LSL #16
    MOVK  X2, #0x6695, LSL #32
    MOVK  X2, #0x5a97, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X19, D4
    MOVZ  X2, #0xb6a2, LSL #0
    MOVK  X2, #0x5a68, LSL #16
    MOVK  X2, #0xb6a2, LSL #32
    MOVK  X2, #0x5a88, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X19, D5
    MOVZ  X2, #0x4193, LSL #0
    MOVK  X2, #0x5a8d, LSL #16
    MOVK  X2, #0x4193, LSL #32
    MOVK  X2, #0x5aad, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P2, Z6.D
    FMOV  X19, D6
    MOVZ  X2, #0xe2e5, LSL #0
    MOVK  X2, #0x5a83, LSL #16
    MOVK  X2, #0xe2e5, LSL #32
    MOVK  X2, #0x5aa3, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X19, D7
    MOVZ  X2, #0x667d, LSL #0
    MOVK  X2, #0x5a6a, LSL #16
    MOVK  X2, #0x667d, LSL #32
    MOVK  X2, #0x5a8a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X19, D8
    MOVZ  X2, #0x189f, LSL #0
    MOVK  X2, #0x5a63, LSL #16
    MOVK  X2, #0x189f, LSL #32
    MOVK  X2, #0x5a83, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X19, D9
    MOVZ  X2, #0xbac0, LSL #0
    MOVK  X2, #0x5a8b, LSL #16
    MOVK  X2, #0xbac0, LSL #32
    MOVK  X2, #0x5aab, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X19, D10
    MOVZ  X2, #0x2cb9, LSL #0
    MOVK  X2, #0x5a72, LSL #16
    MOVK  X2, #0x2cb9, LSL #32
    MOVK  X2, #0x5a92, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X19, D11
    MOVZ  X2, #0x51bb, LSL #0
    MOVK  X2, #0x5a7f, LSL #16
    MOVK  X2, #0x51bb, LSL #32
    MOVK  X2, #0x5a9f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X19, D12
    MOVZ  X2, #0xaa67, LSL #0
    MOVK  X2, #0x5a78, LSL #16
    MOVK  X2, #0xaa67, LSL #32
    MOVK  X2, #0x5a98, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X19, D13
    MOVZ  X2, #0x4556, LSL #0
    MOVK  X2, #0x5a74, LSL #16
    MOVK  X2, #0x4556, LSL #32
    MOVK  X2, #0x5a94, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X19, D14
    MOVZ  X2, #0x1d72, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0x1d72, LSL #32
    MOVK  X2, #0x5a96, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X19, D15
    MOVZ  X2, #0x7af6, LSL #0
    MOVK  X2, #0x5aa0, LSL #16
    MOVK  X2, #0x7af6, LSL #32
    MOVK  X2, #0x5ac0, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X19, D16
    MOVZ  X2, #0xdd2, LSL #0
    MOVK  X2, #0x5a87, LSL #16
    MOVK  X2, #0xdd2, LSL #32
    MOVK  X2, #0x5aa7, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X19, D17
    MOVZ  X2, #0x28c0, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0x28c0, LSL #32
    MOVK  X2, #0x5a96, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X19, D18
    MOVZ  X2, #0xef40, LSL #0
    MOVK  X2, #0x5a61, LSL #16
    MOVK  X2, #0xef40, LSL #32
    MOVK  X2, #0x5a81, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X19, D19
    MOVZ  X2, #0xd63c, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0xd63c, LSL #32
    MOVK  X2, #0x5a96, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X19, D20
    MOVZ  X2, #0x8f24, LSL #0
    MOVK  X2, #0x5a73, LSL #16
    MOVK  X2, #0x8f24, LSL #32
    MOVK  X2, #0x5a93, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X19, D21
    MOVZ  X2, #0xbecb, LSL #0
    MOVK  X2, #0x5a7a, LSL #16
    MOVK  X2, #0xbecb, LSL #32
    MOVK  X2, #0x5a9a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X19, D22
    MOVZ  X2, #0x9501, LSL #0
    MOVK  X2, #0x5a8f, LSL #16
    MOVK  X2, #0x9501, LSL #32
    MOVK  X2, #0x5aaf, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X19, D23
    MOVZ  X2, #0xa9a, LSL #0
    MOVK  X2, #0x5a76, LSL #16
    MOVK  X2, #0xa9a, LSL #32
    MOVK  X2, #0x5a96, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X19, D24
    MOVZ  X2, #0xf8f8, LSL #0
    MOVK  X2, #0x5a7b, LSL #16
    MOVK  X2, #0xf8f8, LSL #32
    MOVK  X2, #0x5a9b, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X19, D25
    MOVZ  X2, #0x8c09, LSL #0
    MOVK  X2, #0x5acb, LSL #16
    MOVK  X2, #0x8c09, LSL #32
    MOVK  X2, #0x5aeb, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P7, Z26.D
    FMOV  X19, D26
    MOVZ  X2, #0x9f9c, LSL #0
    MOVK  X2, #0x5a6a, LSL #16
    MOVK  X2, #0x9f9c, LSL #32
    MOVK  X2, #0x5a8a, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X19, D27
    MOVZ  X2, #0x39bb, LSL #0
    MOVK  X2, #0x5a9d, LSL #16
    MOVK  X2, #0x39bb, LSL #32
    MOVK  X2, #0x5abd, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P3, Z28.D
    FMOV  X19, D28
    MOVZ  X2, #0x583f, LSL #0
    MOVK  X2, #0x5a7f, LSL #16
    MOVK  X2, #0x583f, LSL #32
    MOVK  X2, #0x5a9f, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X19, D29
    MOVZ  X2, #0x363c, LSL #0
    MOVK  X2, #0x5a8b, LSL #16
    MOVK  X2, #0x363c, LSL #32
    MOVK  X2, #0x5aab, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X19, D30
    MOVZ  X2, #0x8d49, LSL #0
    MOVK  X2, #0x5a6e, LSL #16
    MOVK  X2, #0x8d49, LSL #32
    MOVK  X2, #0x5a8e, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X19, D31
    MOVZ  X2, #0xabe6, LSL #0
    MOVK  X2, #0x5a72, LSL #16
    MOVK  X2, #0xabe6, LSL #32
    MOVK  X2, #0x5a92, LSL #48
    SUB  X3, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTSveVectorI8MM_TestFail
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
    DUP     Z0.D, X3
    DUP     Z1.D, X21
    DUP     Z2.D, X18
    DUP     Z3.D, X16
    DUP     Z4.D, X14
    DUP     Z5.D, X6
    DUP     Z6.D, X14
    DUP     Z7.D, X23
    DUP     Z8.D, X6
    DUP     Z9.D, X15
    DUP     Z10.D, X22
    DUP     Z11.D, X29
    DUP     Z12.D, X2
    DUP     Z13.D, X23
    DUP     Z14.D, X21
    DUP     Z15.D, X8
    DUP     Z16.D, X16
    DUP     Z17.D, X3
    DUP     Z18.D, X14
    DUP     Z19.D, X20
    DUP     Z20.D, X19
    DUP     Z21.D, X20
    DUP     Z22.D, X12
    DUP     Z23.D, X20
    DUP     Z24.D, X12
    DUP     Z25.D, X16
    DUP     Z26.D, X19
    DUP     Z27.D, X12
    DUP     Z28.D, X6
    DUP     Z29.D, X22
    DUP     Z30.D, X23
    DUP     Z31.D, X20
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
    MOVZ  X16, #0xa, LSL #0
LCRTSveVectorI8MM_label_14:
    USMMLA Z25.S, Z30.B, Z20.B
    USDOT Z25.S, Z31.B, Z31.B
    SMMLA Z31.S, Z16.B, Z25.B
    SMMLA Z22.S, Z22.B, Z19.B
    UMMLA Z27.S, Z14.B, Z29.B
    UMMLA Z10.S, Z16.B, Z31.B
    USDOT Z10.S, Z10.B, Z2.B[0x1]
    SMMLA Z18.S, Z8.B, Z10.B
    USMMLA Z27.S, Z22.B, Z28.B
    SUDOT Z18.S, Z18.B, Z4.B[0x2]
    SMMLA Z27.S, Z11.B, Z8.B
    SMMLA Z24.S, Z22.B, Z15.B
    SMMLA Z6.S, Z7.B, Z25.B
    USDOT Z25.S, Z13.B, Z4.B[0x1]
    SMMLA Z22.S, Z3.B, Z10.B
    USDOT Z1.S, Z7.B, Z17.B
    USDOT Z7.S, Z11.B, Z4.B[0x0]
    USDOT Z23.S, Z0.B, Z20.B
    USDOT Z6.S, Z17.B, Z7.B
    SMMLA Z18.S, Z16.B, Z25.B
    SUDOT Z23.S, Z22.B, Z1.B[0x2]
    SUDOT Z23.S, Z24.B, Z6.B[0x3]
    UMMLA Z27.S, Z24.B, Z1.B
    USDOT Z23.S, Z23.B, Z16.B
    SMMLA Z3.S, Z18.B, Z12.B
    USDOT Z7.S, Z27.B, Z3.B
    SUDOT Z30.S, Z27.B, Z0.B[0x3]
    SUDOT Z9.S, Z14.B, Z1.B[0x0]
    SMMLA Z11.S, Z7.B, Z23.B
    USDOT Z6.S, Z27.B, Z4.B[0x1]
    SUDOT Z25.S, Z15.B, Z6.B[0x3]
    USMMLA Z26.S, Z22.B, Z30.B
    USDOT Z23.S, Z22.B, Z9.B
    UMMLA Z17.S, Z18.B, Z30.B
    USDOT Z23.S, Z0.B, Z2.B[0x1]
    UMMLA Z10.S, Z9.B, Z14.B
    USDOT Z16.S, Z4.B, Z1.B[0x0]
    USDOT Z4.S, Z17.B, Z24.B
    USDOT Z25.S, Z10.B, Z5.B[0x0]
    UMMLA Z21.S, Z23.B, Z29.B
    UMMLA Z25.S, Z7.B, Z4.B
    UMMLA Z3.S, Z13.B, Z9.B
    SMMLA Z29.S, Z29.B, Z11.B
    USMMLA Z23.S, Z18.B, Z0.B
    USMMLA Z15.S, Z1.B, Z17.B
    SMMLA Z16.S, Z18.B, Z27.B
    USDOT Z31.S, Z4.B, Z21.B
    SMMLA Z1.S, Z15.B, Z29.B
    USDOT Z28.S, Z7.B, Z12.B
    USDOT Z15.S, Z23.B, Z18.B
    USDOT Z11.S, Z18.B, Z11.B
    USDOT Z15.S, Z16.B, Z3.B[0x3]
    SMMLA Z17.S, Z15.B, Z26.B
    UMMLA Z1.S, Z28.B, Z17.B
    SUDOT Z8.S, Z26.B, Z0.B[0x2]
    USDOT Z30.S, Z11.B, Z26.B
    SUDOT Z25.S, Z30.B, Z1.B[0x2]
    USDOT Z8.S, Z28.B, Z3.B[0x0]
    SUDOT Z25.S, Z8.B, Z1.B[0x2]
    SMMLA Z31.S, Z18.B, Z8.B
    SUDOT Z22.S, Z6.B, Z7.B[0x3]
    SMMLA Z5.S, Z23.B, Z30.B
    UMMLA Z24.S, Z14.B, Z24.B
    UMMLA Z3.S, Z3.B, Z5.B
    SUDOT Z0.S, Z7.B, Z0.B[0x2]
    USDOT Z1.S, Z20.B, Z10.B
    SUDOT Z24.S, Z2.B, Z4.B[0x3]
    SMMLA Z24.S, Z28.B, Z10.B
    SUDOT Z10.S, Z17.B, Z0.B[0x2]
    USDOT Z6.S, Z23.B, Z1.B[0x1]
    USMMLA Z19.S, Z0.B, Z10.B
    USDOT Z27.S, Z12.B, Z5.B[0x2]
    SUDOT Z8.S, Z3.B, Z4.B[0x0]
    SMMLA Z8.S, Z18.B, Z11.B
    UMMLA Z9.S, Z12.B, Z7.B
    UMMLA Z5.S, Z2.B, Z27.B
    UMMLA Z25.S, Z9.B, Z31.B
    SUDOT Z14.S, Z6.B, Z3.B[0x2]
    SMMLA Z8.S, Z25.B, Z25.B
    SUDOT Z14.S, Z19.B, Z5.B[0x2]
    USDOT Z22.S, Z14.B, Z7.B[0x3]
    UMMLA Z22.S, Z22.B, Z29.B
    USMMLA Z8.S, Z8.B, Z13.B
    USDOT Z2.S, Z17.B, Z5.B[0x1]
    SMMLA Z26.S, Z2.B, Z24.B
    SMMLA Z26.S, Z22.B, Z8.B
    UMMLA Z0.S, Z14.B, Z23.B
    USMMLA Z2.S, Z1.B, Z18.B
    SUDOT Z17.S, Z0.B, Z3.B[0x1]
    SMMLA Z3.S, Z2.B, Z11.B
    SMMLA Z21.S, Z16.B, Z29.B
    UMMLA Z11.S, Z24.B, Z1.B
    USMMLA Z14.S, Z11.B, Z5.B
    UMMLA Z29.S, Z8.B, Z9.B
    USMMLA Z15.S, Z10.B, Z18.B
    USDOT Z7.S, Z13.B, Z1.B
    USDOT Z25.S, Z23.B, Z23.B
    SUDOT Z3.S, Z31.B, Z6.B[0x0]
    SUDOT Z26.S, Z29.B, Z3.B[0x3]
    USDOT Z30.S, Z30.B, Z25.B
    SUDOT Z1.S, Z7.B, Z3.B[0x0]
    USDOT Z1.S, Z26.B, Z1.B[0x2]
    USDOT Z24.S, Z27.B, Z1.B[0x1]
    USDOT Z19.S, Z30.B, Z14.B
    SUDOT Z19.S, Z15.B, Z3.B[0x0]
    USDOT Z17.S, Z29.B, Z6.B[0x3]
    UMMLA Z24.S, Z13.B, Z15.B
    USDOT Z24.S, Z24.B, Z23.B
    SMMLA Z11.S, Z5.B, Z23.B
    SMMLA Z21.S, Z24.B, Z21.B
    UMMLA Z17.S, Z11.B, Z17.B
    USDOT Z21.S, Z19.B, Z20.B
    UMMLA Z23.S, Z21.B, Z13.B
    SUDOT Z17.S, Z7.B, Z4.B[0x1]
    SUDOT Z26.S, Z13.B, Z2.B[0x3]
    USDOT Z5.S, Z10.B, Z4.B[0x1]
    SMMLA Z5.S, Z6.B, Z4.B
    UMMLA Z14.S, Z16.B, Z17.B
    USMMLA Z11.S, Z15.B, Z21.B
    USDOT Z21.S, Z3.B, Z17.B
    SMMLA Z14.S, Z5.B, Z31.B
    UMMLA Z3.S, Z31.B, Z5.B
    USDOT Z5.S, Z24.B, Z27.B
    SUDOT Z3.S, Z26.B, Z5.B[0x0]
    SMMLA Z20.S, Z4.B, Z10.B
    UMMLA Z12.S, Z21.B, Z10.B
    USDOT Z9.S, Z10.B, Z18.B
    USDOT Z17.S, Z22.B, Z0.B[0x3]
    USMMLA Z31.S, Z5.B, Z0.B
    UMMLA Z9.S, Z3.B, Z6.B
    USMMLA Z17.S, Z31.B, Z9.B
    SUDOT Z17.S, Z23.B, Z6.B[0x2]
    SUDOT Z12.S, Z20.B, Z7.B[0x3]
    UMMLA Z12.S, Z17.B, Z17.B
    UMMLA Z6.S, Z31.B, Z14.B
    UMMLA Z12.S, Z27.B, Z21.B
    SUDOT Z11.S, Z11.B, Z6.B[0x0]
    USMMLA Z20.S, Z2.B, Z20.B
    USDOT Z19.S, Z31.B, Z3.B[0x0]
    USDOT Z21.S, Z30.B, Z9.B
    USDOT Z15.S, Z20.B, Z7.B[0x0]
    SMMLA Z30.S, Z26.B, Z9.B
    SUDOT Z12.S, Z15.B, Z2.B[0x0]
    USMMLA Z8.S, Z27.B, Z11.B
    USDOT Z11.S, Z5.B, Z2.B[0x1]
    SUDOT Z4.S, Z22.B, Z1.B[0x0]
    SUDOT Z8.S, Z3.B, Z1.B[0x1]
    USDOT Z23.S, Z12.B, Z2.B[0x3]
    UMMLA Z2.S, Z0.B, Z1.B
    USDOT Z19.S, Z30.B, Z2.B[0x1]
    UMMLA Z23.S, Z9.B, Z11.B
    SMMLA Z17.S, Z9.B, Z4.B
    SMMLA Z5.S, Z29.B, Z11.B
    SUDOT Z8.S, Z3.B, Z4.B[0x3]
    SUDOT Z9.S, Z27.B, Z5.B[0x1]
    USDOT Z20.S, Z19.B, Z5.B[0x1]
    SUDOT Z27.S, Z11.B, Z7.B[0x2]
    USDOT Z20.S, Z2.B, Z23.B
    USMMLA Z0.S, Z17.B, Z28.B
    UMMLA Z11.S, Z6.B, Z14.B
    UMMLA Z20.S, Z4.B, Z0.B
    USMMLA Z5.S, Z30.B, Z20.B
    UMMLA Z5.S, Z5.B, Z30.B
    SMMLA Z9.S, Z14.B, Z31.B
    SUDOT Z20.S, Z24.B, Z7.B[0x2]
    USDOT Z25.S, Z31.B, Z15.B
    USDOT Z0.S, Z5.B, Z7.B[0x3]
    USMMLA Z23.S, Z2.B, Z18.B
    SUDOT Z23.S, Z26.B, Z4.B[0x2]
    USMMLA Z25.S, Z20.B, Z23.B
    USMMLA Z16.S, Z8.B, Z9.B
    USDOT Z11.S, Z2.B, Z8.B
    SMMLA Z0.S, Z0.B, Z16.B
    USMMLA Z11.S, Z13.B, Z30.B
    USDOT Z27.S, Z11.B, Z0.B[0x0]
    SMMLA Z10.S, Z16.B, Z7.B
    USDOT Z30.S, Z15.B, Z7.B[0x1]
    UMMLA Z10.S, Z5.B, Z3.B
    SUDOT Z24.S, Z6.B, Z6.B[0x0]
    USDOT Z24.S, Z1.B, Z3.B[0x2]
    UMMLA Z13.S, Z8.B, Z16.B
    UMMLA Z17.S, Z26.B, Z7.B
    SUDOT Z12.S, Z31.B, Z7.B[0x0]
    SUDOT Z15.S, Z22.B, Z4.B[0x2]
    USDOT Z25.S, Z12.B, Z7.B[0x1]
    UMMLA Z8.S, Z31.B, Z24.B
    USDOT Z15.S, Z12.B, Z8.B
    SMMLA Z1.S, Z2.B, Z24.B
    UMMLA Z1.S, Z30.B, Z30.B
    USMMLA Z25.S, Z29.B, Z22.B
    UMMLA Z15.S, Z27.B, Z13.B
    UMMLA Z15.S, Z17.B, Z21.B
    USMMLA Z5.S, Z9.B, Z25.B
    USMMLA Z15.S, Z10.B, Z1.B
    USDOT Z24.S, Z11.B, Z22.B
    USDOT Z4.S, Z18.B, Z9.B
    UMMLA Z21.S, Z18.B, Z23.B
    USMMLA Z1.S, Z24.B, Z7.B
    USMMLA Z12.S, Z27.B, Z17.B
    USMMLA Z24.S, Z8.B, Z11.B
    SUBS  X16, X16, #0x1
    B.NE  LCRTSveVectorI8MM_label_14
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X20, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTSveVectorI8MM_TestFail
    MRS  X9, FPSR
    MOVZ  X20, #0x81, LSL #0
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X20, #0x85b1, LSL #0
    MOVK  X20, #0xa5af, LSL #16
    MOVK  X20, #0x85b1, LSL #32
    MOVK  X20, #0xa5af, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D0
    MOVZ  X20, #0x85b1, LSL #0
    MOVK  X20, #0xa5af, LSL #16
    MOVK  X20, #0x85b1, LSL #32
    MOVK  X20, #0xa5af, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X20, #0x74c7, LSL #0
    MOVK  X20, #0xa5c5, LSL #16
    MOVK  X20, #0x74c7, LSL #32
    MOVK  X20, #0xa5c5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D1
    MOVZ  X20, #0x74c7, LSL #0
    MOVK  X20, #0xa5c5, LSL #16
    MOVK  X20, #0x74c7, LSL #32
    MOVK  X20, #0xa5c5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X20, #0xade3, LSL #0
    MOVK  X20, #0xa5af, LSL #16
    MOVK  X20, #0xade3, LSL #32
    MOVK  X20, #0xa5af, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D2
    MOVZ  X20, #0xade3, LSL #0
    MOVK  X20, #0xa5af, LSL #16
    MOVK  X20, #0xade3, LSL #32
    MOVK  X20, #0xa5af, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X20, #0x2c48, LSL #0
    MOVK  X20, #0xa5fc, LSL #16
    MOVK  X20, #0x2c48, LSL #32
    MOVK  X20, #0xa5fc, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D3
    MOVZ  X20, #0x2c48, LSL #0
    MOVK  X20, #0xa5fc, LSL #16
    MOVK  X20, #0x2c48, LSL #32
    MOVK  X20, #0xa5fc, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X20, #0x7b3d, LSL #0
    MOVK  X20, #0xa597, LSL #16
    MOVK  X20, #0x7b3d, LSL #32
    MOVK  X20, #0xa597, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D4
    MOVZ  X20, #0x7b3d, LSL #0
    MOVK  X20, #0xa597, LSL #16
    MOVK  X20, #0x7b3d, LSL #32
    MOVK  X20, #0xa597, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X20, #0x6090, LSL #0
    MOVK  X20, #0xa5d0, LSL #16
    MOVK  X20, #0x6090, LSL #32
    MOVK  X20, #0xa5d0, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D5
    MOVZ  X20, #0x6090, LSL #0
    MOVK  X20, #0xa5d0, LSL #16
    MOVK  X20, #0x6090, LSL #32
    MOVK  X20, #0xa5d0, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X20, #0x623e, LSL #0
    MOVK  X20, #0xa5ba, LSL #16
    MOVK  X20, #0x623e, LSL #32
    MOVK  X20, #0xa5ba, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D6
    MOVZ  X20, #0x623e, LSL #0
    MOVK  X20, #0xa5ba, LSL #16
    MOVK  X20, #0x623e, LSL #32
    MOVK  X20, #0xa5ba, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X20, #0x10cf, LSL #0
    MOVK  X20, #0xa599, LSL #16
    MOVK  X20, #0x10cf, LSL #32
    MOVK  X20, #0xa599, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D7
    MOVZ  X20, #0x10cf, LSL #0
    MOVK  X20, #0xa599, LSL #16
    MOVK  X20, #0x10cf, LSL #32
    MOVK  X20, #0xa599, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X20, #0xea0b, LSL #0
    MOVK  X20, #0xa5b2, LSL #16
    MOVK  X20, #0xea0b, LSL #32
    MOVK  X20, #0xa5b2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D8
    MOVZ  X20, #0xea0b, LSL #0
    MOVK  X20, #0xa5b2, LSL #16
    MOVK  X20, #0xea0b, LSL #32
    MOVK  X20, #0xa5b2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X20, #0xc48c, LSL #0
    MOVK  X20, #0xa5d4, LSL #16
    MOVK  X20, #0xc48c, LSL #32
    MOVK  X20, #0xa5d4, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D9
    MOVZ  X20, #0xc48c, LSL #0
    MOVK  X20, #0xa5d4, LSL #16
    MOVK  X20, #0xc48c, LSL #32
    MOVK  X20, #0xa5d4, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X20, #0x8f69, LSL #0
    MOVK  X20, #0xa5fb, LSL #16
    MOVK  X20, #0x8f69, LSL #32
    MOVK  X20, #0xa5fb, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D10
    MOVZ  X20, #0x8f69, LSL #0
    MOVK  X20, #0xa5fb, LSL #16
    MOVK  X20, #0x8f69, LSL #32
    MOVK  X20, #0xa5fb, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X20, #0xfe63, LSL #0
    MOVK  X20, #0xa5c2, LSL #16
    MOVK  X20, #0xfe63, LSL #32
    MOVK  X20, #0xa5c2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D11
    MOVZ  X20, #0xfe63, LSL #0
    MOVK  X20, #0xa5c2, LSL #16
    MOVK  X20, #0xfe63, LSL #32
    MOVK  X20, #0xa5c2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X20, #0xa89c, LSL #0
    MOVK  X20, #0xa5f1, LSL #16
    MOVK  X20, #0xa89c, LSL #32
    MOVK  X20, #0xa5f1, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D12
    MOVZ  X20, #0xa89c, LSL #0
    MOVK  X20, #0xa5f1, LSL #16
    MOVK  X20, #0xa89c, LSL #32
    MOVK  X20, #0xa5f1, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X20, #0x9fdf, LSL #0
    MOVK  X20, #0xa5c2, LSL #16
    MOVK  X20, #0x9fdf, LSL #32
    MOVK  X20, #0xa5c2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D13
    MOVZ  X20, #0x9fdf, LSL #0
    MOVK  X20, #0xa5c2, LSL #16
    MOVK  X20, #0x9fdf, LSL #32
    MOVK  X20, #0xa5c2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X20, #0x2248, LSL #0
    MOVK  X20, #0xa5b3, LSL #16
    MOVK  X20, #0x2248, LSL #32
    MOVK  X20, #0xa5b3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D14
    MOVZ  X20, #0x2248, LSL #0
    MOVK  X20, #0xa5b3, LSL #16
    MOVK  X20, #0x2248, LSL #32
    MOVK  X20, #0xa5b3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X20, #0xc5fc, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xc5fc, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D15
    MOVZ  X20, #0xc5fc, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xc5fc, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X20, #0xa235, LSL #0
    MOVK  X20, #0xa59e, LSL #16
    MOVK  X20, #0xa235, LSL #32
    MOVK  X20, #0xa59e, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D16
    MOVZ  X20, #0xa235, LSL #0
    MOVK  X20, #0xa59e, LSL #16
    MOVK  X20, #0xa235, LSL #32
    MOVK  X20, #0xa59e, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X20, #0x5113, LSL #0
    MOVK  X20, #0xa5e6, LSL #16
    MOVK  X20, #0x5113, LSL #32
    MOVK  X20, #0xa5e6, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D17
    MOVZ  X20, #0x5113, LSL #0
    MOVK  X20, #0xa5e6, LSL #16
    MOVK  X20, #0x5113, LSL #32
    MOVK  X20, #0xa5e6, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X20, #0x9c15, LSL #0
    MOVK  X20, #0xa5a9, LSL #16
    MOVK  X20, #0x9c15, LSL #32
    MOVK  X20, #0xa5a9, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D18
    MOVZ  X20, #0x9c15, LSL #0
    MOVK  X20, #0xa5a9, LSL #16
    MOVK  X20, #0x9c15, LSL #32
    MOVK  X20, #0xa5a9, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X20, #0xc6e0, LSL #0
    MOVK  X20, #0xa590, LSL #16
    MOVK  X20, #0xc6e0, LSL #32
    MOVK  X20, #0xa590, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D19
    MOVZ  X20, #0xc6e0, LSL #0
    MOVK  X20, #0xa590, LSL #16
    MOVK  X20, #0xc6e0, LSL #32
    MOVK  X20, #0xa590, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X20, #0xe505, LSL #0
    MOVK  X20, #0xa5b0, LSL #16
    MOVK  X20, #0xe505, LSL #32
    MOVK  X20, #0xa5b0, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D20
    MOVZ  X20, #0xe505, LSL #0
    MOVK  X20, #0xa5b0, LSL #16
    MOVK  X20, #0xe505, LSL #32
    MOVK  X20, #0xa5b0, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X20, #0xb89a, LSL #0
    MOVK  X20, #0xa5d7, LSL #16
    MOVK  X20, #0xb89a, LSL #32
    MOVK  X20, #0xa5d7, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D21
    MOVZ  X20, #0xb89a, LSL #0
    MOVK  X20, #0xa5d7, LSL #16
    MOVK  X20, #0xb89a, LSL #32
    MOVK  X20, #0xa5d7, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X20, #0xc2ea, LSL #0
    MOVK  X20, #0xa5bf, LSL #16
    MOVK  X20, #0xc2ea, LSL #32
    MOVK  X20, #0xa5bf, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D22
    MOVZ  X20, #0xc2ea, LSL #0
    MOVK  X20, #0xa5bf, LSL #16
    MOVK  X20, #0xc2ea, LSL #32
    MOVK  X20, #0xa5bf, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X20, #0x8217, LSL #0
    MOVK  X20, #0xa5a3, LSL #16
    MOVK  X20, #0x8217, LSL #32
    MOVK  X20, #0xa5a3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D23
    MOVZ  X20, #0x8217, LSL #0
    MOVK  X20, #0xa5a3, LSL #16
    MOVK  X20, #0x8217, LSL #32
    MOVK  X20, #0xa5a3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X20, #0xc954, LSL #0
    MOVK  X20, #0xa5c5, LSL #16
    MOVK  X20, #0xc954, LSL #32
    MOVK  X20, #0xa5c5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D24
    MOVZ  X20, #0xc954, LSL #0
    MOVK  X20, #0xa5c5, LSL #16
    MOVK  X20, #0xc954, LSL #32
    MOVK  X20, #0xa5c5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X20, #0x81ca, LSL #0
    MOVK  X20, #0xa58e, LSL #16
    MOVK  X20, #0x81ca, LSL #32
    MOVK  X20, #0xa58e, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D25
    MOVZ  X20, #0x81ca, LSL #0
    MOVK  X20, #0xa58e, LSL #16
    MOVK  X20, #0x81ca, LSL #32
    MOVK  X20, #0xa58e, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X20, #0x2f65, LSL #0
    MOVK  X20, #0xa59e, LSL #16
    MOVK  X20, #0x2f65, LSL #32
    MOVK  X20, #0xa59e, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D26
    MOVZ  X20, #0x2f65, LSL #0
    MOVK  X20, #0xa59e, LSL #16
    MOVK  X20, #0x2f65, LSL #32
    MOVK  X20, #0xa59e, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X20, #0x8c24, LSL #0
    MOVK  X20, #0xa5ca, LSL #16
    MOVK  X20, #0x8c24, LSL #32
    MOVK  X20, #0xa5ca, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D27
    MOVZ  X20, #0x8c24, LSL #0
    MOVK  X20, #0xa5ca, LSL #16
    MOVK  X20, #0x8c24, LSL #32
    MOVK  X20, #0xa5ca, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X20, #0x92b1, LSL #0
    MOVK  X20, #0xa5a1, LSL #16
    MOVK  X20, #0x92b1, LSL #32
    MOVK  X20, #0xa5a1, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D28
    MOVZ  X20, #0x92b1, LSL #0
    MOVK  X20, #0xa5a1, LSL #16
    MOVK  X20, #0x92b1, LSL #32
    MOVK  X20, #0xa5a1, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X20, #0x4873, LSL #0
    MOVK  X20, #0xa5c7, LSL #16
    MOVK  X20, #0x4873, LSL #32
    MOVK  X20, #0xa5c7, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D29
    MOVZ  X20, #0x4873, LSL #0
    MOVK  X20, #0xa5c7, LSL #16
    MOVK  X20, #0x4873, LSL #32
    MOVK  X20, #0xa5c7, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X20, #0x7238, LSL #0
    MOVK  X20, #0xa598, LSL #16
    MOVK  X20, #0x7238, LSL #32
    MOVK  X20, #0xa598, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D30
    MOVZ  X20, #0x7238, LSL #0
    MOVK  X20, #0xa598, LSL #16
    MOVK  X20, #0x7238, LSL #32
    MOVK  X20, #0xa598, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X20, #0xf267, LSL #0
    MOVK  X20, #0xa5a3, LSL #16
    MOVK  X20, #0xf267, LSL #32
    MOVK  X20, #0xa5a3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FMOV  X9, D31
    MOVZ  X20, #0xf267, LSL #0
    MOVK  X20, #0xa5a3, LSL #16
    MOVK  X20, #0xf267, LSL #32
    MOVK  X20, #0xa5a3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
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
    MOVZ  X20, #0x85b1, LSL #0
    MOVK  X20, #0xa5af, LSL #16
    MOVK  X20, #0x85b1, LSL #32
    MOVK  X20, #0xa5cf, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D1, P0, Z1.D
    FMOV  X9, D1
    MOVZ  X20, #0x74c7, LSL #0
    MOVK  X20, #0xa5c5, LSL #16
    MOVK  X20, #0x74c7, LSL #32
    MOVK  X20, #0xa5e5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X9, D2
    MOVZ  X20, #0xade3, LSL #0
    MOVK  X20, #0xa5af, LSL #16
    MOVK  X20, #0xade3, LSL #32
    MOVK  X20, #0xa5cf, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X9, D3
    MOVZ  X20, #0x2c48, LSL #0
    MOVK  X20, #0xa5fc, LSL #16
    MOVK  X20, #0x2c48, LSL #32
    MOVK  X20, #0xa61c, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X9, D4
    MOVZ  X20, #0x7b3d, LSL #0
    MOVK  X20, #0xa597, LSL #16
    MOVK  X20, #0x7b3d, LSL #32
    MOVK  X20, #0xa5b7, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D5, P6, Z5.D
    FMOV  X9, D5
    MOVZ  X20, #0x6090, LSL #0
    MOVK  X20, #0xa5d0, LSL #16
    MOVK  X20, #0x6090, LSL #32
    MOVK  X20, #0xa5f0, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X9, D6
    MOVZ  X20, #0x623e, LSL #0
    MOVK  X20, #0xa5ba, LSL #16
    MOVK  X20, #0x623e, LSL #32
    MOVK  X20, #0xa5da, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X9, D7
    MOVZ  X20, #0x10cf, LSL #0
    MOVK  X20, #0xa599, LSL #16
    MOVK  X20, #0x10cf, LSL #32
    MOVK  X20, #0xa5b9, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D8, P7, Z8.D
    FMOV  X9, D8
    MOVZ  X20, #0xea0b, LSL #0
    MOVK  X20, #0xa5b2, LSL #16
    MOVK  X20, #0xea0b, LSL #32
    MOVK  X20, #0xa5d2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X9, D9
    MOVZ  X20, #0xc48c, LSL #0
    MOVK  X20, #0xa5d4, LSL #16
    MOVK  X20, #0xc48c, LSL #32
    MOVK  X20, #0xa5f4, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X9, D10
    MOVZ  X20, #0x8f69, LSL #0
    MOVK  X20, #0xa5fb, LSL #16
    MOVK  X20, #0x8f69, LSL #32
    MOVK  X20, #0xa61b, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X9, D11
    MOVZ  X20, #0xfe63, LSL #0
    MOVK  X20, #0xa5c2, LSL #16
    MOVK  X20, #0xfe63, LSL #32
    MOVK  X20, #0xa5e2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X9, D12
    MOVZ  X20, #0xa89c, LSL #0
    MOVK  X20, #0xa5f1, LSL #16
    MOVK  X20, #0xa89c, LSL #32
    MOVK  X20, #0xa611, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X9, D13
    MOVZ  X20, #0x9fdf, LSL #0
    MOVK  X20, #0xa5c2, LSL #16
    MOVK  X20, #0x9fdf, LSL #32
    MOVK  X20, #0xa5e2, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X9, D14
    MOVZ  X20, #0x2248, LSL #0
    MOVK  X20, #0xa5b3, LSL #16
    MOVK  X20, #0x2248, LSL #32
    MOVK  X20, #0xa5d3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X9, D15
    MOVZ  X20, #0xc5fc, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xc5fc, LSL #32
    MOVK  X20, #0xa5c5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X9, D16
    MOVZ  X20, #0xa235, LSL #0
    MOVK  X20, #0xa59e, LSL #16
    MOVK  X20, #0xa235, LSL #32
    MOVK  X20, #0xa5be, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D17, P0, Z17.D
    FMOV  X9, D17
    MOVZ  X20, #0x5113, LSL #0
    MOVK  X20, #0xa5e6, LSL #16
    MOVK  X20, #0x5113, LSL #32
    MOVK  X20, #0xa606, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X9, D18
    MOVZ  X20, #0x9c15, LSL #0
    MOVK  X20, #0xa5a9, LSL #16
    MOVK  X20, #0x9c15, LSL #32
    MOVK  X20, #0xa5c9, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X9, D19
    MOVZ  X20, #0xc6e0, LSL #0
    MOVK  X20, #0xa590, LSL #16
    MOVK  X20, #0xc6e0, LSL #32
    MOVK  X20, #0xa5b0, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X9, D20
    MOVZ  X20, #0xe505, LSL #0
    MOVK  X20, #0xa5b0, LSL #16
    MOVK  X20, #0xe505, LSL #32
    MOVK  X20, #0xa5d0, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D21, P1, Z21.D
    FMOV  X9, D21
    MOVZ  X20, #0xb89a, LSL #0
    MOVK  X20, #0xa5d7, LSL #16
    MOVK  X20, #0xb89a, LSL #32
    MOVK  X20, #0xa5f7, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X9, D22
    MOVZ  X20, #0xc2ea, LSL #0
    MOVK  X20, #0xa5bf, LSL #16
    MOVK  X20, #0xc2ea, LSL #32
    MOVK  X20, #0xa5df, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D23, P5, Z23.D
    FMOV  X9, D23
    MOVZ  X20, #0x8217, LSL #0
    MOVK  X20, #0xa5a3, LSL #16
    MOVK  X20, #0x8217, LSL #32
    MOVK  X20, #0xa5c3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X9, D24
    MOVZ  X20, #0xc954, LSL #0
    MOVK  X20, #0xa5c5, LSL #16
    MOVK  X20, #0xc954, LSL #32
    MOVK  X20, #0xa5e5, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D25, P4, Z25.D
    FMOV  X9, D25
    MOVZ  X20, #0x81ca, LSL #0
    MOVK  X20, #0xa58e, LSL #16
    MOVK  X20, #0x81ca, LSL #32
    MOVK  X20, #0xa5ae, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X9, D26
    MOVZ  X20, #0x2f65, LSL #0
    MOVK  X20, #0xa59e, LSL #16
    MOVK  X20, #0x2f65, LSL #32
    MOVK  X20, #0xa5be, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X9, D27
    MOVZ  X20, #0x8c24, LSL #0
    MOVK  X20, #0xa5ca, LSL #16
    MOVK  X20, #0x8c24, LSL #32
    MOVK  X20, #0xa5ea, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X9, D28
    MOVZ  X20, #0x92b1, LSL #0
    MOVK  X20, #0xa5a1, LSL #16
    MOVK  X20, #0x92b1, LSL #32
    MOVK  X20, #0xa5c1, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X9, D29
    MOVZ  X20, #0x4873, LSL #0
    MOVK  X20, #0xa5c7, LSL #16
    MOVK  X20, #0x4873, LSL #32
    MOVK  X20, #0xa5e7, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X9, D30
    MOVZ  X20, #0x7238, LSL #0
    MOVK  X20, #0xa598, LSL #16
    MOVK  X20, #0x7238, LSL #32
    MOVK  X20, #0xa5b8, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X9, D31
    MOVZ  X20, #0xf267, LSL #0
    MOVK  X20, #0xa5a3, LSL #16
    MOVK  X20, #0xf267, LSL #32
    MOVK  X20, #0xa5c3, LSL #48
    SUB  X2, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTSveVectorI8MM_TestFail

LCRTSveVectorI8MM_TestEnd:
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
LCRTSveVectorI8MM_TestFail:
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
