.global LCRTFloatBF16JscvtFrintts

.text
.p2align 4

LCRTFloatBF16JscvtFrintts:

LCRTFloatBF16JscvtFrintts_TestBegin:
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
    MOVZ  X2, #0x8dc, LSL #0
    MOVK  X2, #0xdcab, LSL #16
    MOVK  X2, #0xaaef, LSL #32
    MOVK  X2, #0x3bba, LSL #48
    MOVZ  X3, #0x1574, LSL #0
    MOVK  X3, #0xb0a9, LSL #16
    MOVK  X3, #0x2903, LSL #32
    MOVK  X3, #0xde7a, LSL #48
    MOVZ  X4, #0x2190, LSL #0
    MOVK  X4, #0xc191, LSL #16
    MOVK  X4, #0x5a16, LSL #32
    MOVK  X4, #0x9a5c, LSL #48
    MOVZ  X5, #0x62d3, LSL #0
    MOVK  X5, #0x3367, LSL #16
    MOVK  X5, #0xcf42, LSL #32
    MOVK  X5, #0xf29a, LSL #48
    MOVZ  X6, #0x12c0, LSL #0
    MOVK  X6, #0xa6a, LSL #16
    MOVK  X6, #0x2710, LSL #32
    MOVK  X6, #0xb9ab, LSL #48
    MOVZ  X7, #0x132a, LSL #0
    MOVK  X7, #0xb4f4, LSL #16
    MOVK  X7, #0xcb9e, LSL #32
    MOVK  X7, #0x8e76, LSL #48
    MOVZ  X8, #0xfe1c, LSL #0
    MOVK  X8, #0xb614, LSL #16
    MOVK  X8, #0xd100, LSL #32
    MOVK  X8, #0x93ac, LSL #48
    MOVZ  X9, #0x61a6, LSL #0
    MOVK  X9, #0xf6b5, LSL #16
    MOVK  X9, #0xe845, LSL #32
    MOVK  X9, #0xd767, LSL #48
    MOVZ  X10, #0xe78b, LSL #0
    MOVK  X10, #0xbe2a, LSL #16
    MOVK  X10, #0x5f3a, LSL #32
    MOVK  X10, #0x4256, LSL #48
    MOVZ  X11, #0x14de, LSL #0
    MOVK  X11, #0x95ea, LSL #16
    MOVK  X11, #0x4fdf, LSL #32
    MOVK  X11, #0xd0b2, LSL #48
    MOVZ  X12, #0xb49e, LSL #0
    MOVK  X12, #0x2d8a, LSL #16
    MOVK  X12, #0xb145, LSL #32
    MOVK  X12, #0xac64, LSL #48
    MOVZ  X13, #0xa961, LSL #0
    MOVK  X13, #0xd46d, LSL #16
    MOVK  X13, #0xbec9, LSL #32
    MOVK  X13, #0xc1c8, LSL #48
    MOVZ  X14, #0x2cd7, LSL #0
    MOVK  X14, #0x684a, LSL #16
    MOVK  X14, #0xc8c2, LSL #32
    MOVK  X14, #0x7ecb, LSL #48
    MOVZ  X15, #0xa721, LSL #0
    MOVK  X15, #0xf18, LSL #16
    MOVK  X15, #0x104b, LSL #32
    MOVK  X15, #0x643b, LSL #48
    MOVZ  X16, #0x57e0, LSL #0
    MOVK  X16, #0x1e91, LSL #16
    MOVK  X16, #0xcef, LSL #32
    MOVK  X16, #0xdeb, LSL #48
    MOVZ  X17, #0x3647, LSL #0
    MOVK  X17, #0x390b, LSL #16
    MOVK  X17, #0xc65c, LSL #32
    MOVK  X17, #0xca57, LSL #48
    MOVZ  X23, #0xdb1d, LSL #0
    MOVK  X23, #0xd8cd, LSL #16
    MOVK  X23, #0x4544, LSL #32
    MOVK  X23, #0xc8d3, LSL #48
    MOVZ  X24, #0x60ab, LSL #0
    MOVK  X24, #0x7de4, LSL #16
    MOVK  X24, #0xc0b8, LSL #32
    MOVK  X24, #0x1623, LSL #48
    MOVZ  X25, #0x5f8e, LSL #0
    MOVK  X25, #0xcb9a, LSL #16
    MOVK  X25, #0x1411, LSL #32
    MOVK  X25, #0x7de7, LSL #48
    MOVZ  X26, #0x2db5, LSL #0
    MOVK  X26, #0xc199, LSL #16
    MOVK  X26, #0x3fc, LSL #32
    MOVK  X26, #0x88c1, LSL #48
    MOVZ  X27, #0x5c7e, LSL #0
    MOVK  X27, #0x8e63, LSL #16
    MOVK  X27, #0xcff9, LSL #32
    MOVK  X27, #0x3121, LSL #48
    MOVZ  X28, #0xd3da, LSL #0
    MOVK  X28, #0x3726, LSL #16
    MOVK  X28, #0x5f00, LSL #32
    MOVK  X28, #0xc1f0, LSL #48
    MOVZ  X29, #0x9f29, LSL #0
    MOVK  X29, #0x1e19, LSL #16
    MOVK  X29, #0x8c70, LSL #32
    MOVK  X29, #0x9f0e, LSL #48
    MOVZ  X28, #0xce5f, LSL #0
    MOVK  X28, #0x30d5, LSL #16
    MOVK  X28, #0xb906, LSL #32
    MOVK  X28, #0xe71b, LSL #48
    MSR  FPCR, X28
    MRS  X28, FPCR
    MOVZ  X7, #0x60ff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    AND  X28, X28, X7
    MOVZ  X7, #0x0, LSL #0
    ORR  X28, X28, X7
    MSR  FPCR, X28
    ISB  SY
    MOVZ  X28, #0xf38, LSL #0
    MOVK  X28, #0x9e4d, LSL #16
    MOVK  X28, #0x9788, LSL #32
    MOVK  X28, #0xc623, LSL #48
    MSR  FPSR, X28
    MRS  X26, FPSR
    MOVZ  X16, #0xff60, LSL #0
    MOVK  X16, #0x7ff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    AND  X26, X26, X16
    MOVZ  X16, #0x0, LSL #0
    ORR  X26, X26, X16
    MSR  FPSR, X26
    ISB  SY
    ADDS  X29, X8, X11, ASR #43
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xad50, LSL #0
    MOVK  X2, #0x5716, LSL #16
    MOVK  X2, #0x3e18, LSL #32
    MOVK  X2, #0x3491, LSL #48
    MOVZ  X3, #0xdca6, LSL #0
    MOVK  X3, #0x9b75, LSL #16
    MOVK  X3, #0xb7b3, LSL #32
    MOVK  X3, #0xd697, LSL #48
    MOVZ  X4, #0x356b, LSL #0
    MOVK  X4, #0x5e9, LSL #16
    MOVK  X4, #0xefe4, LSL #32
    MOVK  X4, #0x7140, LSL #48
    MOVZ  X5, #0x475a, LSL #0
    MOVK  X5, #0x23aa, LSL #16
    MOVK  X5, #0x9f33, LSL #32
    MOVK  X5, #0xc2aa, LSL #48
    MOVZ  X6, #0x10c7, LSL #0
    MOVK  X6, #0x5451, LSL #16
    MOVK  X6, #0x3d47, LSL #32
    MOVK  X6, #0x7629, LSL #48
    MOVZ  X7, #0xc786, LSL #0
    MOVK  X7, #0x1d16, LSL #16
    MOVK  X7, #0x960c, LSL #32
    MOVK  X7, #0x6a35, LSL #48
    MOVZ  X8, #0xe5a0, LSL #0
    MOVK  X8, #0x1808, LSL #16
    MOVK  X8, #0xda7e, LSL #32
    MOVK  X8, #0x1899, LSL #48
    MOVZ  X9, #0x20f1, LSL #0
    MOVK  X9, #0xe65f, LSL #16
    MOVK  X9, #0xde51, LSL #32
    MOVK  X9, #0xa123, LSL #48
    MOVZ  X10, #0x5fe4, LSL #0
    MOVK  X10, #0xac13, LSL #16
    MOVK  X10, #0x8a8c, LSL #32
    MOVK  X10, #0x8314, LSL #48
    MOVZ  X11, #0x29e0, LSL #0
    MOVK  X11, #0x701b, LSL #16
    MOVK  X11, #0xa7e5, LSL #32
    MOVK  X11, #0xd6a7, LSL #48
    MOVZ  X12, #0x4dbc, LSL #0
    MOVK  X12, #0x81b5, LSL #16
    MOVK  X12, #0x5fab, LSL #32
    MOVK  X12, #0x8e11, LSL #48
    MOVZ  X13, #0xad1d, LSL #0
    MOVK  X13, #0xf852, LSL #16
    MOVK  X13, #0xde59, LSL #32
    MOVK  X13, #0xce, LSL #48
    MOVZ  X14, #0x47d4, LSL #0
    MOVK  X14, #0xf7c1, LSL #16
    MOVK  X14, #0xe059, LSL #32
    MOVK  X14, #0x99ca, LSL #48
    MOVZ  X15, #0x3aa2, LSL #0
    MOVK  X15, #0xfefe, LSL #16
    MOVK  X15, #0x3269, LSL #32
    MOVK  X15, #0x9daf, LSL #48
    MOVZ  X16, #0xb28d, LSL #0
    MOVK  X16, #0x5ddc, LSL #16
    MOVK  X16, #0x703a, LSL #32
    MOVK  X16, #0x61fd, LSL #48
    MOVZ  X17, #0x7fcf, LSL #0
    MOVK  X17, #0xc0de, LSL #16
    MOVK  X17, #0x6727, LSL #32
    MOVK  X17, #0x1c8c, LSL #48
    MOVZ  X23, #0x6e06, LSL #0
    MOVK  X23, #0xc784, LSL #16
    MOVK  X23, #0x558e, LSL #32
    MOVK  X23, #0x1bdf, LSL #48
    MOVZ  X24, #0x4c8c, LSL #0
    MOVK  X24, #0x63ad, LSL #16
    MOVK  X24, #0x2155, LSL #32
    MOVK  X24, #0xbc98, LSL #48
    MOVZ  X25, #0x73d3, LSL #0
    MOVK  X25, #0x1320, LSL #16
    MOVK  X25, #0x6131, LSL #32
    MOVK  X25, #0xe251, LSL #48
    MOVZ  X26, #0xf5a1, LSL #0
    MOVK  X26, #0x686b, LSL #16
    MOVK  X26, #0xc7af, LSL #32
    MOVK  X26, #0xdbd9, LSL #48
    MOVZ  X27, #0xacab, LSL #0
    MOVK  X27, #0xb565, LSL #16
    MOVK  X27, #0x8dd5, LSL #32
    MOVK  X27, #0xe6d4, LSL #48
    MOVZ  X28, #0x11dc, LSL #0
    MOVK  X28, #0x23bb, LSL #16
    MOVK  X28, #0xacae, LSL #32
    MOVK  X28, #0x3ee8, LSL #48
    MOVZ  X29, #0xa583, LSL #0
    MOVK  X29, #0xc44a, LSL #16
    MOVK  X29, #0x7578, LSL #32
    MOVK  X29, #0x29b6, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X24
    FMOV  V3.D[1], X17
    FMOV  D4, X7
    FMOV  V4.D[1], X17
    FMOV  D5, X29
    FMOV  V5.D[1], X3
    FMOV  D6, X2
    FMOV  V6.D[1], X9
    FMOV  D7, X24
    FMOV  V7.D[1], X4
    FMOV  D8, X3
    FMOV  V8.D[1], X16
    FMOV  D9, X24
    FMOV  V9.D[1], X13
    FMOV  D10, X23
    FMOV  V10.D[1], X14
    FMOV  D11, X6
    FMOV  V11.D[1], X15
    FMOV  D12, X8
    FMOV  V12.D[1], X15
    FMOV  D13, X28
    FMOV  V13.D[1], X10
    FMOV  D14, X15
    FMOV  V14.D[1], X9
    FMOV  D15, X15
    FMOV  V15.D[1], X3
    FMOV  D16, X6
    FMOV  V16.D[1], X8
    FMOV  D17, X24
    FMOV  V17.D[1], X24
    FMOV  D18, X26
    FMOV  V18.D[1], X10
    FMOV  D19, X8
    FMOV  V19.D[1], X28
    FMOV  D20, X24
    FMOV  V20.D[1], X2
    FMOV  D21, X26
    FMOV  V21.D[1], X27
    FMOV  D22, X3
    FMOV  V22.D[1], X28
    FMOV  D23, X13
    FMOV  V23.D[1], X13
    FMOV  D24, X9
    FMOV  V24.D[1], X12
    FMOV  D25, X29
    FMOV  V25.D[1], X15
    FMOV  D26, X23
    FMOV  V26.D[1], X16
    FMOV  D27, X23
    FMOV  V27.D[1], X10
    FMOV  D28, X13
    FMOV  V28.D[1], X26
    FMOV  D29, X9
    FMOV  V29.D[1], X6
    FMOV  D30, X5
    FMOV  V30.D[1], X12
    FMOV  D31, X11
    FMOV  V31.D[1], X4
    BFCVT H24, S29
    BFCVT H4, S24
    BFCVT H20, S31
    BFCVT H26, S28
    BFCVT H12, S17
    BFCVT H17, S27
    BFCVT H2, S12
    BFCVT H13, S11
    BFCVT H19, S13
    BFCVT H29, S17
    FJCVTZS W6, D2
    FJCVTZS W6, D19
    FJCVTZS W9, D20
    FJCVTZS W4, D23
    FJCVTZS W11, D4
    FJCVTZS W12, D25
    FJCVTZS W15, D25
    FJCVTZS W14, D26
    FJCVTZS W23, D29
    FJCVTZS W7, D14
    FRINT32X D19, D2
    FRINT32X D24, D27
    FRINT32X D14, D6
    FRINT32X D17, D25
    FRINT32X D6, D28
    FRINT32X D13, D16
    FRINT32X D25, D16
    FRINT32X D31, D6
    FRINT32X D17, D28
    FRINT32X D2, D15
    FRINT32X S31, S14
    FRINT32X S12, S5
    FRINT32X S6, S6
    FRINT32X S20, S30
    FRINT32X S28, S13
    FRINT32X S26, S19
    FRINT32X S16, S28
    FRINT32X S23, S12
    FRINT32X S14, S17
    FRINT32X S19, S20
    FRINT32Z D30, D18
    FRINT32Z D12, D18
    FRINT32Z D4, D16
    FRINT32Z D0, D12
    FRINT32Z D13, D6
    FRINT32Z D29, D4
    FRINT32Z D5, D2
    FRINT32Z D16, D23
    FRINT32Z D28, D29
    FRINT32Z D4, D14
    FRINT32Z S12, S31
    FRINT32Z S23, S12
    FRINT32Z S12, S19
    FRINT32Z S15, S26
    FRINT32Z S31, S28
    FRINT32Z S26, S20
    FRINT32Z S18, S5
    FRINT32Z S7, S30
    FRINT32Z S5, S4
    FRINT32Z S28, S13
    FRINT64X D28, D16
    FRINT64X D6, D7
    FRINT64X D7, D5
    FRINT64X D29, D12
    FRINT64X D2, D29
    FRINT64X D30, D7
    FRINT64X D17, D30
    FRINT64X D9, D15
    FRINT64X D30, D9
    FRINT64X D9, D23
    FRINT64X S7, S26
    FRINT64X S26, S6
    FRINT64X S30, S7
    FRINT64X S4, S2
    FRINT64X S15, S30
    FRINT64X S7, S15
    FRINT64X S19, S7
    FRINT64X S2, S26
    FRINT64X S26, S5
    FRINT64X S15, S6
    FRINT64Z D13, D18
    FRINT64Z D6, D19
    FRINT64Z D20, D6
    FRINT64Z D30, D26
    FRINT64Z D26, D15
    FRINT64Z D5, D13
    FRINT64Z D29, D20
    FRINT64Z D19, D22
    FRINT64Z D18, D15
    FRINT64Z D13, D5
    FRINT64Z S28, S0
    FRINT64Z S21, S13
    FRINT64Z S20, S21
    FRINT64Z S13, S4
    FRINT64Z S6, S13
    FRINT64Z S5, S30
    FRINT64Z S4, S26
    FRINT64Z S30, S6
    FRINT64Z S6, S30
    FRINT64Z S21, S19
    MOVZ  X10, #0xad50, LSL #0
    MOVK  X10, #0x5716, LSL #16
    MOVK  X10, #0x3e18, LSL #32
    MOVK  X10, #0x3491, LSL #48
    SUB  X24, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0xdca6, LSL #0
    MOVK  X10, #0x9b75, LSL #16
    MOVK  X10, #0xb7b3, LSL #32
    MOVK  X10, #0xd697, LSL #48
    SUB  X24, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0xe5a0, LSL #0
    MOVK  X10, #0x1808, LSL #16
    MOVK  X10, #0xda7e, LSL #32
    MOVK  X10, #0x1899, LSL #48
    SUB  X24, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0xad1d, LSL #0
    MOVK  X10, #0xf852, LSL #16
    MOVK  X10, #0xde59, LSL #32
    MOVK  X10, #0xce, LSL #48
    SUB  X24, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0xb28d, LSL #0
    MOVK  X10, #0x5ddc, LSL #16
    MOVK  X10, #0x703a, LSL #32
    MOVK  X10, #0x61fd, LSL #48
    SUB  X24, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x7fcf, LSL #0
    MOVK  X10, #0xc0de, LSL #16
    MOVK  X10, #0x6727, LSL #32
    MOVK  X10, #0x1c8c, LSL #48
    SUB  X24, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x73d3, LSL #0
    MOVK  X10, #0x1320, LSL #16
    MOVK  X10, #0x6131, LSL #32
    MOVK  X10, #0xe251, LSL #48
    SUB  X24, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0xf5a1, LSL #0
    MOVK  X10, #0x686b, LSL #16
    MOVK  X10, #0xc7af, LSL #32
    MOVK  X10, #0xdbd9, LSL #48
    SUB  X24, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0xacab, LSL #0
    MOVK  X10, #0xb565, LSL #16
    MOVK  X10, #0x8dd5, LSL #32
    MOVK  X10, #0xe6d4, LSL #48
    SUB  X24, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0x11dc, LSL #0
    MOVK  X10, #0x23bb, LSL #16
    MOVK  X10, #0xacae, LSL #32
    MOVK  X10, #0x3ee8, LSL #48
    SUB  X24, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X10, #0xa583, LSL #0
    MOVK  X10, #0xc44a, LSL #16
    MOVK  X10, #0x7578, LSL #32
    MOVK  X10, #0x29b6, LSL #48
    SUB  X24, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X10, FPSR
    MOVZ  X24, #0x19, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D0
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc1e0, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X24, #0x11dc, LSL #0
    MOVK  X24, #0x23bb, LSL #16
    MOVK  X24, #0xacae, LSL #32
    MOVK  X24, #0x3ee8, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D1
    MOVZ  X24, #0xf5a1, LSL #0
    MOVK  X24, #0x686b, LSL #16
    MOVK  X24, #0xc7af, LSL #32
    MOVK  X24, #0xdbd9, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X24, #0x7fcf, LSL #0
    MOVK  X24, #0xc0de, LSL #16
    MOVK  X24, #0x6727, LSL #32
    MOVK  X24, #0x1c8c, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D3
    MOVZ  X24, #0x4c8c, LSL #0
    MOVK  X24, #0x63ad, LSL #16
    MOVK  X24, #0x2155, LSL #32
    MOVK  X24, #0xbc98, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X24, #0xb28d, LSL #0
    MOVK  X24, #0x5ddc, LSL #16
    MOVK  X24, #0x703a, LSL #32
    MOVK  X24, #0x61fd, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D8
    MOVZ  X24, #0xdca6, LSL #0
    MOVK  X24, #0x9b75, LSL #16
    MOVK  X24, #0xb7b3, LSL #32
    MOVK  X24, #0xd697, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X24, #0x47d4, LSL #0
    MOVK  X24, #0xf7c1, LSL #16
    MOVK  X24, #0xe059, LSL #32
    MOVK  X24, #0x99ca, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D10
    MOVZ  X24, #0x6e06, LSL #0
    MOVK  X24, #0xc784, LSL #16
    MOVK  X24, #0x558e, LSL #32
    MOVK  X24, #0x1bdf, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X24, #0x3aa2, LSL #0
    MOVK  X24, #0xfefe, LSL #16
    MOVK  X24, #0x3269, LSL #32
    MOVK  X24, #0x9daf, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D11
    MOVZ  X24, #0x10c7, LSL #0
    MOVK  X24, #0x5451, LSL #16
    MOVK  X24, #0x3d47, LSL #32
    MOVK  X24, #0x7629, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D19
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc3e0, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X24, #0x11dc, LSL #0
    MOVK  X24, #0x23bb, LSL #16
    MOVK  X24, #0xacae, LSL #32
    MOVK  X24, #0x3ee8, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D22
    MOVZ  X24, #0xdca6, LSL #0
    MOVK  X24, #0x9b75, LSL #16
    MOVK  X24, #0xb7b3, LSL #32
    MOVK  X24, #0xd697, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D25
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc1e0, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X24, #0x5fe4, LSL #0
    MOVK  X24, #0xac13, LSL #16
    MOVK  X24, #0x8a8c, LSL #32
    MOVK  X24, #0x8314, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D27
    MOVZ  X24, #0x6e06, LSL #0
    MOVK  X24, #0xc784, LSL #16
    MOVK  X24, #0x558e, LSL #32
    MOVK  X24, #0x1bdf, LSL #48
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X10, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X2, #0x5f0, LSL #0
    MOVK  X2, #0x3df0, LSL #16
    MOVK  X2, #0x40ce, LSL #32
    MOVK  X2, #0xfc70, LSL #48
    MOVZ  X3, #0x6c83, LSL #0
    MOVK  X3, #0x7396, LSL #16
    MOVK  X3, #0x3189, LSL #32
    MOVK  X3, #0xdcf9, LSL #48
    MOVZ  X4, #0x3b54, LSL #0
    MOVK  X4, #0xc06, LSL #16
    MOVK  X4, #0x3ff6, LSL #32
    MOVK  X4, #0x988f, LSL #48
    MOVZ  X5, #0x4d44, LSL #0
    MOVK  X5, #0x3343, LSL #16
    MOVK  X5, #0x803b, LSL #32
    MOVK  X5, #0x4fd, LSL #48
    MOVZ  X6, #0x15f3, LSL #0
    MOVK  X6, #0x7973, LSL #16
    MOVK  X6, #0x68d7, LSL #32
    MOVK  X6, #0x89df, LSL #48
    MOVZ  X7, #0x54bc, LSL #0
    MOVK  X7, #0xb41f, LSL #16
    MOVK  X7, #0xde7a, LSL #32
    MOVK  X7, #0x5db2, LSL #48
    MOVZ  X8, #0x3928, LSL #0
    MOVK  X8, #0xfdfb, LSL #16
    MOVK  X8, #0x22d6, LSL #32
    MOVK  X8, #0xcfa3, LSL #48
    MOVZ  X9, #0xa8eb, LSL #0
    MOVK  X9, #0x32bb, LSL #16
    MOVK  X9, #0x8cec, LSL #32
    MOVK  X9, #0x66e2, LSL #48
    MOVZ  X10, #0xbaee, LSL #0
    MOVK  X10, #0x3602, LSL #16
    MOVK  X10, #0xbd44, LSL #32
    MOVK  X10, #0x841e, LSL #48
    MOVZ  X11, #0x9a2c, LSL #0
    MOVK  X11, #0xdc9c, LSL #16
    MOVK  X11, #0x9dab, LSL #32
    MOVK  X11, #0xaad7, LSL #48
    MOVZ  X12, #0xdf67, LSL #0
    MOVK  X12, #0xc6ad, LSL #16
    MOVK  X12, #0x6876, LSL #32
    MOVK  X12, #0x122e, LSL #48
    MOVZ  X13, #0x2f4e, LSL #0
    MOVK  X13, #0xa70d, LSL #16
    MOVK  X13, #0x3c65, LSL #32
    MOVK  X13, #0x3f3c, LSL #48
    MOVZ  X14, #0xf71d, LSL #0
    MOVK  X14, #0x9d37, LSL #16
    MOVK  X14, #0x7339, LSL #32
    MOVK  X14, #0xfe48, LSL #48
    MOVZ  X15, #0x5e4, LSL #0
    MOVK  X15, #0xe7e6, LSL #16
    MOVK  X15, #0xc81f, LSL #32
    MOVK  X15, #0x1e5a, LSL #48
    MOVZ  X16, #0xbc3f, LSL #0
    MOVK  X16, #0xfe61, LSL #16
    MOVK  X16, #0x8cf8, LSL #32
    MOVK  X16, #0xfd39, LSL #48
    MOVZ  X17, #0x53c0, LSL #0
    MOVK  X17, #0x269b, LSL #16
    MOVK  X17, #0x7285, LSL #32
    MOVK  X17, #0xc831, LSL #48
    MOVZ  X23, #0x45fc, LSL #0
    MOVK  X23, #0x636f, LSL #16
    MOVK  X23, #0x4186, LSL #32
    MOVK  X23, #0x52f3, LSL #48
    MOVZ  X24, #0xf3b7, LSL #0
    MOVK  X24, #0xb506, LSL #16
    MOVK  X24, #0xb445, LSL #32
    MOVK  X24, #0x6495, LSL #48
    MOVZ  X25, #0xf686, LSL #0
    MOVK  X25, #0xc1af, LSL #16
    MOVK  X25, #0x61d4, LSL #32
    MOVK  X25, #0x59a9, LSL #48
    MOVZ  X26, #0xb625, LSL #0
    MOVK  X26, #0x1e4c, LSL #16
    MOVK  X26, #0xb54, LSL #32
    MOVK  X26, #0xcbc6, LSL #48
    MOVZ  X27, #0x5400, LSL #0
    MOVK  X27, #0x65ad, LSL #16
    MOVK  X27, #0xde69, LSL #32
    MOVK  X27, #0x10b4, LSL #48
    MOVZ  X28, #0x54c2, LSL #0
    MOVK  X28, #0xafa2, LSL #16
    MOVK  X28, #0xa726, LSL #32
    MOVK  X28, #0x2b1, LSL #48
    MOVZ  X29, #0x9e6e, LSL #0
    MOVK  X29, #0x69a2, LSL #16
    MOVK  X29, #0x538c, LSL #32
    MOVK  X29, #0x6432, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X11
    FMOV  D1, X9
    FMOV  V1.D[1], X14
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X5
    FMOV  V3.D[1], X29
    FMOV  D4, X9
    FMOV  V4.D[1], X25
    FMOV  D5, X12
    FMOV  V5.D[1], X3
    FMOV  D6, X23
    FMOV  V6.D[1], X11
    FMOV  D7, X12
    FMOV  V7.D[1], X25
    FMOV  D8, X6
    FMOV  V8.D[1], X3
    FMOV  D9, X13
    FMOV  V9.D[1], X4
    FMOV  D10, X2
    FMOV  V10.D[1], X13
    FMOV  D11, X5
    FMOV  V11.D[1], X23
    FMOV  D12, X14
    FMOV  V12.D[1], X2
    FMOV  D13, X17
    FMOV  V13.D[1], X14
    FMOV  D14, X5
    FMOV  V14.D[1], X12
    FMOV  D15, X27
    FMOV  V15.D[1], X14
    FMOV  D16, X11
    FMOV  V16.D[1], X6
    FMOV  D17, X15
    FMOV  V17.D[1], X2
    FMOV  D18, X4
    FMOV  V18.D[1], X17
    FMOV  D19, X7
    FMOV  V19.D[1], X16
    FMOV  D20, X3
    FMOV  V20.D[1], X8
    FMOV  D21, X9
    FMOV  V21.D[1], X4
    FMOV  D22, X28
    FMOV  V22.D[1], X9
    FMOV  D23, X26
    FMOV  V23.D[1], X15
    FMOV  D24, X11
    FMOV  V24.D[1], X29
    FMOV  D25, X17
    FMOV  V25.D[1], X27
    FMOV  D26, X27
    FMOV  V26.D[1], X16
    FMOV  D27, X26
    FMOV  V27.D[1], X4
    FMOV  D28, X5
    FMOV  V28.D[1], X5
    FMOV  D29, X25
    FMOV  V29.D[1], X4
    FMOV  D30, X27
    FMOV  V30.D[1], X24
    FMOV  D31, X4
    FMOV  V31.D[1], X27
    MOVZ  X24, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_0:
    FJCVTZS W25, D31
    BFCVT H10, S31
    FRINT32X D29, D27
    FRINT64X S19, S24
    FRINT32X S26, S10
    FRINT32Z D30, D28
    BFCVT H27, S10
    FJCVTZS W27, D23
    FJCVTZS W4, D30
    FRINT64Z D25, D2
    FRINT32Z S19, S26
    FRINT32X S25, S27
    BFCVT H0, S22
    BFCVT H6, S25
    FJCVTZS W16, D12
    FRINT32X D2, D17
    FJCVTZS W26, D6
    FRINT64X D19, D2
    BFCVT H17, S13
    FJCVTZS W29, D19
    FRINT32Z S26, S0
    FJCVTZS W11, D0
    BFCVT H12, S26
    FJCVTZS W12, D17
    FRINT64Z D2, D29
    FJCVTZS W8, D9
    FJCVTZS W23, D16
    BFCVT H21, S0
    FJCVTZS W9, D15
    BFCVT H9, S11
    BFCVT H17, S15
    BFCVT H15, S28
    FRINT64X D11, D28
    FJCVTZS W14, D6
    BFCVT H0, S1
    FJCVTZS W7, D29
    BFCVT H7, S1
    BFCVT H28, S2
    FRINT32Z S2, S3
    BFCVT H19, S11
    FRINT64Z S27, S14
    FRINT32Z D21, D0
    FJCVTZS W6, D12
    FRINT32X S23, S17
    FJCVTZS W28, D15
    BFCVT H12, S7
    BFCVT H17, S12
    FJCVTZS W10, D23
    FRINT64X D15, D19
    FJCVTZS W12, D21
    BFCVT H14, S17
    BFCVT H11, S27
    FJCVTZS W7, D11
    FJCVTZS W27, D15
    FJCVTZS W6, D28
    FRINT64Z D19, D2
    FRINT64Z S21, S31
    BFCVT H17, S20
    FRINT32X D29, D19
    FRINT32X S12, S5
    FRINT32X S31, S2
    BFCVT H6, S14
    FRINT32Z D15, D7
    FJCVTZS W11, D9
    BFCVT H11, S31
    BFCVT H27, S17
    FRINT32X S17, S27
    FJCVTZS W28, D11
    BFCVT H31, S31
    BFCVT H14, S17
    FRINT32X D7, D15
    BFCVT H16, S29
    FJCVTZS W8, D7
    BFCVT H19, S21
    FJCVTZS W17, D11
    BFCVT H7, S12
    FJCVTZS W29, D28
    FJCVTZS W11, D7
    BFCVT H12, S6
    FJCVTZS W27, D19
    FRINT64Z S28, S10
    BFCVT H17, S28
    FJCVTZS W25, D14
    BFCVT H14, S12
    FJCVTZS W8, D21
    BFCVT H15, S26
    BFCVT H10, S14
    FJCVTZS W14, D31
    BFCVT H14, S11
    FJCVTZS W14, D17
    FRINT32Z S11, S15
    BFCVT H26, S16
    FRINT32Z D16, D14
    FJCVTZS W7, D31
    FRINT64X S0, S26
    FJCVTZS W14, D10
    BFCVT H31, S11
    BFCVT H17, S31
    FRINT32Z D12, D8
    BFCVT H10, S0
    FJCVTZS W11, D17
    FJCVTZS W17, D24
    FJCVTZS W29, D17
    FJCVTZS W28, D12
    FRINT32X D6, D16
    FRINT64X S15, S2
    FJCVTZS W16, D22
    FRINT64X S12, S11
    FJCVTZS W7, D3
    FRINT32X D31, D7
    FRINT32X S8, S27
    FRINT64X D0, D25
    FJCVTZS W28, D26
    FRINT64X S24, S13
    FJCVTZS W4, D7
    BFCVT H11, S16
    BFCVT H7, S6
    BFCVT H26, S24
    FRINT32Z S6, S5
    FJCVTZS W11, D0
    FRINT32X S25, S7
    FRINT32X D24, D8
    FJCVTZS W7, D10
    BFCVT H27, S24
    FRINT64X D5, D16
    FJCVTZS W14, D6
    FRINT32Z D30, D27
    FRINT64X S6, S12
    BFCVT H7, S20
    FJCVTZS W27, D6
    BFCVT H2, S17
    FRINT64X S12, S26
    FJCVTZS W16, D11
    BFCVT H8, S5
    FRINT64X D13, D26
    FJCVTZS W4, D10
    FRINT32X S16, S5
    BFCVT H3, S12
    FJCVTZS W6, D8
    FRINT32X D26, D3
    FRINT64X S24, S30
    FJCVTZS W28, D13
    FJCVTZS W8, D20
    BFCVT H6, S25
    BFCVT H0, S16
    FRINT32Z D12, D5
    FJCVTZS W4, D12
    FJCVTZS W16, D7
    FJCVTZS W17, D2
    BFCVT H5, S6
    FRINT64Z S2, S5
    FJCVTZS W9, D24
    BFCVT H25, S27
    FRINT64X S16, S30
    FRINT64X S5, S25
    FJCVTZS W9, D26
    FRINT32X D25, D0
    FRINT64X D8, D2
    FJCVTZS W25, D28
    BFCVT H24, S21
    FJCVTZS W8, D17
    FJCVTZS W26, D26
    BFCVT H28, S1
    FJCVTZS W6, D16
    FJCVTZS W11, D4
    FRINT32Z S21, S16
    BFCVT H6, S8
    FRINT32X D2, D24
    BFCVT H17, S12
    FJCVTZS W28, D21
    FRINT64X D4, D28
    BFCVT H1, S5
    BFCVT H27, S25
    BFCVT H16, S17
    FRINT32Z S21, S6
    BFCVT H25, S21
    FJCVTZS W9, D4
    FJCVTZS W29, D24
    BFCVT H26, S27
    FJCVTZS W3, D16
    FJCVTZS W28, D27
    FRINT32Z S16, S2
    FRINT32Z D2, D16
    FJCVTZS W27, D1
    FJCVTZS W11, D2
    FJCVTZS W26, D26
    FJCVTZS W6, D1
    BFCVT H8, S13
    FJCVTZS W26, D24
    FJCVTZS W29, D22
    FRINT32X D26, D1
    FRINT32X D22, D6
    FRINT32Z S13, S8
    FJCVTZS W12, D17
    FRINT32Z S2, S2
    BFCVT H6, S16
    BFCVT H16, S1
    FJCVTZS W23, D25
    FJCVTZS W26, D10
    FJCVTZS W3, D5
    SUBS  X24, X24, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_0
    MOVZ  X13, #0x5f0, LSL #0
    MOVK  X13, #0x3df0, LSL #16
    MOVK  X13, #0x40ce, LSL #32
    MOVK  X13, #0xfc70, LSL #48
    SUB  X5, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X13, FPSR
    MOVZ  X5, #0x19, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D0
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D1
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D5
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D7
    MOVZ  X5, #0x7396, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D9
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X5, #0x53c0, LSL #0
    MOVK  X5, #0x269b, LSL #16
    MOVK  X5, #0x7285, LSL #32
    MOVK  X5, #0xc831, LSL #48
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D18
    MOVZ  X5, #0x3b54, LSL #0
    MOVK  X5, #0xc06, LSL #16
    MOVK  X5, #0x3ff6, LSL #32
    MOVK  X5, #0x988f, LSL #48
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X5, #0x3928, LSL #0
    MOVK  X5, #0xfdfb, LSL #16
    MOVK  X5, #0x22d6, LSL #32
    MOVK  X5, #0xcfa3, LSL #48
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D20
    MOVZ  X5, #0x6c83, LSL #0
    MOVK  X5, #0x7396, LSL #16
    MOVK  X5, #0x3189, LSL #32
    MOVK  X5, #0xdcf9, LSL #48
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D29
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D30
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X13, D31
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X11
    FMOV  D1, X14
    FMOV  V1.D[1], X26
    FMOV  D2, X9
    FMOV  V2.D[1], X29
    FMOV  D3, X12
    FMOV  V3.D[1], X28
    FMOV  D4, X17
    FMOV  V4.D[1], X11
    FMOV  D5, X4
    FMOV  V5.D[1], X24
    FMOV  D6, X23
    FMOV  V6.D[1], X11
    FMOV  D7, X25
    FMOV  V7.D[1], X27
    FMOV  D8, X16
    FMOV  V8.D[1], X2
    FMOV  D9, X10
    FMOV  V9.D[1], X11
    FMOV  D10, X12
    FMOV  V10.D[1], X6
    FMOV  D11, X8
    FMOV  V11.D[1], X16
    FMOV  D12, X29
    FMOV  V12.D[1], X3
    FMOV  D13, X8
    FMOV  V13.D[1], X25
    FMOV  D14, X28
    FMOV  V14.D[1], X14
    FMOV  D15, X14
    FMOV  V15.D[1], X17
    FMOV  D16, X25
    FMOV  V16.D[1], X8
    FMOV  D17, X3
    FMOV  V17.D[1], X16
    FMOV  D18, X26
    FMOV  V18.D[1], X4
    FMOV  D19, X14
    FMOV  V19.D[1], X14
    FMOV  D20, X10
    FMOV  V20.D[1], X4
    FMOV  D21, X9
    FMOV  V21.D[1], X7
    FMOV  D22, X7
    FMOV  V22.D[1], X9
    FMOV  D23, X15
    FMOV  V23.D[1], X12
    FMOV  D24, X5
    FMOV  V24.D[1], X14
    FMOV  D25, X2
    FMOV  V25.D[1], X6
    FMOV  D26, X3
    FMOV  V26.D[1], X23
    FMOV  D27, X12
    FMOV  V27.D[1], X13
    FMOV  D28, X27
    FMOV  V28.D[1], X11
    FMOV  D29, X10
    FMOV  V29.D[1], X17
    FMOV  D30, X15
    FMOV  V30.D[1], X25
    FMOV  D31, X6
    FMOV  V31.D[1], X16
    MOVZ  X10, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_1:
    FRINT32Z D12, D24
    BFCVT H26, S16
    BFCVT H1, S31
    BFCVT H13, S10
    FRINT64X D14, D1
    FJCVTZS W2, D12
    FJCVTZS W24, D13
    FJCVTZS W14, D29
    FJCVTZS W5, D14
    FJCVTZS W27, D30
    FJCVTZS W5, D26
    FRINT32X S27, S19
    FRINT64Z S15, S28
    FRINT32X D21, D13
    BFCVT H24, S27
    FJCVTZS W16, D25
    BFCVT H30, S15
    FJCVTZS W6, D30
    BFCVT H1, S24
    FJCVTZS W17, D5
    BFCVT H14, S15
    BFCVT H10, S1
    BFCVT H16, S8
    FRINT64X D5, D0
    BFCVT H1, S12
    FRINT32Z D12, D26
    FRINT64X S30, S9
    FJCVTZS W8, D5
    FJCVTZS W28, D10
    FJCVTZS W17, D31
    FJCVTZS W23, D16
    BFCVT H25, S24
    BFCVT H9, S8
    FJCVTZS W3, D27
    BFCVT H16, S31
    BFCVT H27, S9
    BFCVT H10, S22
    FJCVTZS W17, D27
    FRINT32X D9, D12
    FJCVTZS W11, D21
    BFCVT H0, S30
    BFCVT H8, S16
    BFCVT H27, S10
    FJCVTZS W14, D8
    FRINT32Z D12, D0
    FJCVTZS W27, D9
    FRINT32X S24, S24
    FRINT64Z S30, S27
    BFCVT H22, S24
    BFCVT H20, S12
    FJCVTZS W27, D21
    FJCVTZS W24, D27
    FRINT32X D10, D19
    FRINT64X S21, S9
    FJCVTZS W27, D21
    FJCVTZS W11, D20
    FJCVTZS W27, D2
    FRINT32X S24, S27
    FRINT32Z S8, S24
    FRINT32Z D27, D25
    FJCVTZS W29, D11
    BFCVT H9, S20
    BFCVT H0, S8
    BFCVT H24, S22
    BFCVT H28, S9
    FRINT32X D8, D19
    FJCVTZS W14, D19
    BFCVT H7, S16
    BFCVT H16, S10
    FJCVTZS W16, D17
    FJCVTZS W27, D7
    FRINT32X S7, S28
    FJCVTZS W2, D27
    FJCVTZS W14, D8
    FJCVTZS W15, D24
    BFCVT H8, S5
    FRINT32X S10, S31
    FJCVTZS W2, D7
    FJCVTZS W5, D16
    BFCVT H25, S21
    FJCVTZS W5, D13
    FRINT64Z S7, S10
    FRINT32X S10, S0
    FRINT64X D28, D20
    FRINT32Z S9, S25
    FRINT64Z D17, D7
    FRINT64X D24, D8
    FRINT64X D27, D17
    FRINT32X S20, S10
    BFCVT H10, S20
    BFCVT H21, S24
    BFCVT H25, S30
    BFCVT H12, S26
    FRINT32X S31, S21
    BFCVT H19, S31
    BFCVT H20, S10
    BFCVT H5, S27
    FRINT32X D7, D9
    FJCVTZS W17, D20
    FRINT32Z S24, S8
    BFCVT H27, S19
    FRINT64Z D19, D7
    FRINT64Z D0, D12
    FJCVTZS W16, D31
    FJCVTZS W3, D24
    FJCVTZS W2, D19
    BFCVT H12, S31
    BFCVT H19, S12
    BFCVT H13, S19
    FJCVTZS W25, D5
    BFCVT H30, S8
    FJCVTZS W12, D0
    FRINT64Z S21, S7
    BFCVT H19, S14
    BFCVT H0, S15
    FRINT32Z D8, D13
    FJCVTZS W5, D19
    BFCVT H12, S27
    FRINT64X S13, S9
    FJCVTZS W11, D25
    FRINT64X D5, D28
    FRINT32X S7, S28
    FJCVTZS W9, D5
    FRINT32X D25, D8
    BFCVT H20, S7
    FRINT64Z D15, D25
    FJCVTZS W16, D20
    FJCVTZS W5, D25
    FRINT32X D25, D13
    FRINT64X D30, D1
    BFCVT H22, S12
    BFCVT H12, S0
    FJCVTZS W6, D12
    BFCVT H7, S29
    FRINT64Z S27, S4
    FJCVTZS W9, D21
    BFCVT H5, S16
    BFCVT H0, S27
    BFCVT H4, S22
    FRINT32X S12, S25
    FJCVTZS W4, D13
    BFCVT H25, S2
    FRINT64Z S31, S24
    FJCVTZS W28, D19
    BFCVT H23, S8
    BFCVT H21, S12
    FJCVTZS W25, D15
    FRINT64X D1, D25
    FJCVTZS W2, D18
    FJCVTZS W29, D8
    FRINT32Z S9, S5
    FJCVTZS W14, D7
    FRINT32X S13, S23
    FJCVTZS W9, D30
    FJCVTZS W5, D13
    BFCVT H18, S0
    FRINT64Z S2, S21
    FRINT64X D8, D2
    BFCVT H19, S9
    FRINT32Z D25, D8
    FRINT32X D23, D19
    BFCVT H23, S31
    BFCVT H27, S25
    FJCVTZS W28, D13
    FJCVTZS W12, D27
    BFCVT H5, S1
    FRINT64X D29, D23
    BFCVT H0, S29
    FJCVTZS W5, D4
    BFCVT H8, S20
    FJCVTZS W17, D18
    FRINT32X S9, S31
    FJCVTZS W9, D13
    FRINT64X S18, S0
    FRINT64X S1, S8
    BFCVT H20, S5
    FJCVTZS W28, D20
    BFCVT H13, S1
    FJCVTZS W8, D13
    FRINT32X D21, D19
    FJCVTZS W9, D18
    BFCVT H13, S24
    BFCVT H19, S29
    FRINT32Z S5, S9
    FJCVTZS W12, D21
    FRINT32Z S1, S22
    FRINT64Z D18, D5
    FRINT32Z D29, D19
    BFCVT H5, S1
    BFCVT H23, S5
    FRINT32X S0, S19
    FRINT64Z S19, S0
    FJCVTZS W29, D19
    FRINT32X D5, D9
    FRINT32Z S24, S5
    BFCVT H9, S29
    FJCVTZS W9, D24
    FRINT32X D21, D18
    BFCVT H22, S16
    FRINT32Z S16, S13
    SUBS  X10, X10, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_1
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X26, FPSR
    MOVZ  X13, #0x19, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X8
    FMOV  V2.D[1], X25
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X28
    FMOV  D5, X4
    FMOV  V5.D[1], X11
    FMOV  D6, X15
    FMOV  V6.D[1], X27
    FMOV  D7, X9
    FMOV  V7.D[1], X24
    FMOV  D8, X3
    FMOV  V8.D[1], X4
    FMOV  D9, X2
    FMOV  V9.D[1], X13
    FMOV  D10, X28
    FMOV  V10.D[1], X25
    FMOV  D11, X23
    FMOV  V11.D[1], X5
    FMOV  D12, X8
    FMOV  V12.D[1], X9
    FMOV  D13, X23
    FMOV  V13.D[1], X28
    FMOV  D14, X9
    FMOV  V14.D[1], X7
    FMOV  D15, X13
    FMOV  V15.D[1], X23
    FMOV  D16, X6
    FMOV  V16.D[1], X4
    FMOV  D17, X2
    FMOV  V17.D[1], X26
    FMOV  D18, X10
    FMOV  V18.D[1], X24
    FMOV  D19, X17
    FMOV  V19.D[1], X11
    FMOV  D20, X2
    FMOV  V20.D[1], X14
    FMOV  D21, X27
    FMOV  V21.D[1], X23
    FMOV  D22, X4
    FMOV  V22.D[1], X9
    FMOV  D23, X7
    FMOV  V23.D[1], X29
    FMOV  D24, X11
    FMOV  V24.D[1], X15
    FMOV  D25, X25
    FMOV  V25.D[1], X2
    FMOV  D26, X27
    FMOV  V26.D[1], X27
    FMOV  D27, X11
    FMOV  V27.D[1], X10
    FMOV  D28, X6
    FMOV  V28.D[1], X24
    FMOV  D29, X24
    FMOV  V29.D[1], X24
    FMOV  D30, X28
    FMOV  V30.D[1], X11
    FMOV  D31, X26
    FMOV  V31.D[1], X5
    MOVZ  X6, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_2:
    FJCVTZS W11, D22
    BFCVT H24, S26
    FRINT64Z D13, D25
    BFCVT H6, S31
    BFCVT H3, S29
    FJCVTZS W26, D13
    FRINT64Z S11, S28
    FRINT32Z S25, S6
    FRINT64X D14, D6
    BFCVT H14, S14
    FJCVTZS W3, D13
    FRINT32X D8, D13
    BFCVT H1, S10
    FRINT64X S24, S24
    FJCVTZS W5, D8
    FJCVTZS W28, D27
    FJCVTZS W14, D16
    FRINT64Z S3, S14
    FRINT32X S15, S11
    FRINT32X S10, S26
    FRINT32X D29, D25
    FRINT64X D8, D30
    BFCVT H20, S29
    FRINT64X S24, S15
    FJCVTZS W23, D10
    FRINT32X D30, D24
    FRINT64X D31, D3
    FJCVTZS W27, D30
    FRINT32X D29, D8
    FJCVTZS W14, D31
    BFCVT H27, S19
    FRINT64X D15, D1
    FRINT64Z D8, D8
    FRINT64X S19, S20
    FRINT64Z D6, D19
    FRINT64Z D31, D2
    FRINT32X S26, S3
    BFCVT H19, S7
    FRINT32Z S2, S26
    FRINT32Z D12, D15
    FJCVTZS W28, D21
    FJCVTZS W2, D5
    FJCVTZS W3, D31
    FJCVTZS W13, D17
    BFCVT H17, S6
    BFCVT H3, S2
    FRINT64Z S6, S17
    FJCVTZS W28, D8
    FJCVTZS W28, D11
    FRINT32X S17, S3
    FJCVTZS W5, D19
    BFCVT H17, S12
    FJCVTZS W14, D6
    FRINT32X S24, S17
    FRINT64X S20, S26
    FJCVTZS W27, D20
    FJCVTZS W12, D24
    FJCVTZS W28, D5
    BFCVT H22, S23
    FRINT32Z S5, S22
    BFCVT H12, S27
    FRINT32Z S3, S6
    FRINT64X S6, S28
    FRINT64Z D19, D30
    FRINT64Z S11, S29
    FRINT64Z D28, D9
    FRINT64X D23, D9
    BFCVT H22, S14
    FJCVTZS W29, D16
    BFCVT H29, S22
    FJCVTZS W2, D11
    BFCVT H9, S3
    BFCVT H20, S9
    FJCVTZS W28, D20
    FRINT64Z D24, D19
    FRINT64Z D30, D23
    FJCVTZS W7, D12
    BFCVT H25, S24
    BFCVT H12, S5
    FRINT32X D27, D6
    FRINT64Z D9, D28
    FJCVTZS W28, D1
    FJCVTZS W16, D12
    FJCVTZS W10, D9
    FJCVTZS W5, D14
    FJCVTZS W16, D25
    BFCVT H1, S27
    BFCVT H18, S0
    FRINT32Z S3, S11
    FJCVTZS W4, D4
    FRINT32X S27, S18
    BFCVT H18, S1
    FJCVTZS W15, D11
    FJCVTZS W26, D18
    BFCVT H28, S3
    BFCVT H11, S27
    BFCVT H6, S28
    BFCVT H25, S18
    FRINT64X D27, D21
    FRINT32Z S3, S6
    BFCVT H18, S27
    FRINT32X D14, D20
    FRINT32Z S21, S20
    FJCVTZS W28, D14
    FJCVTZS W5, D11
    FRINT64Z D20, D25
    FRINT64X D6, D21
    FRINT64Z S4, S6
    BFCVT H14, S3
    FRINT32X S27, S4
    BFCVT H11, S31
    FRINT64Z D26, D4
    FRINT32Z D3, D27
    BFCVT H25, S20
    FRINT32Z S27, S3
    BFCVT H7, S11
    BFCVT H4, S26
    FRINT64X D11, D17
    FRINT64X D3, D7
    BFCVT H17, S27
    FJCVTZS W12, D25
    FRINT32X S14, S4
    FRINT64Z D7, D13
    FRINT32X D20, D5
    FJCVTZS W5, D14
    FJCVTZS W4, D3
    FRINT32X D3, D20
    FRINT32X S12, S11
    FRINT32X D25, D6
    BFCVT H14, S12
    FRINT32Z D14, D7
    BFCVT H22, S20
    FJCVTZS W27, D29
    FRINT64Z D27, D31
    BFCVT H26, S13
    FJCVTZS W24, D14
    BFCVT H7, S0
    BFCVT H6, S3
    FRINT64X D0, D22
    BFCVT H25, S25
    FJCVTZS W7, D3
    FRINT64X D5, D16
    FRINT32X S19, S25
    FRINT64X S16, S17
    FRINT64X D29, D0
    BFCVT H16, S29
    BFCVT H29, S26
    FJCVTZS W29, D7
    BFCVT H20, S16
    FJCVTZS W5, D18
    FJCVTZS W28, D5
    BFCVT H6, S14
    FRINT32Z S11, S31
    FRINT64X D26, D25
    FJCVTZS W28, D27
    FJCVTZS W15, D19
    BFCVT H0, S26
    FJCVTZS W2, D9
    BFCVT H13, S22
    FRINT32X D17, D6
    FJCVTZS W2, D29
    BFCVT H26, S0
    FJCVTZS W4, D11
    FRINT64X S6, S13
    FRINT64Z D7, D14
    BFCVT H31, S12
    FJCVTZS W26, D17
    FJCVTZS W4, D28
    FJCVTZS W24, D6
    FRINT32X S17, S25
    BFCVT H5, S20
    FJCVTZS W13, D5
    FJCVTZS W10, D31
    BFCVT H20, S26
    FRINT32X D6, D7
    FRINT64X D0, D20
    BFCVT H9, S11
    BFCVT H15, S6
    FJCVTZS W2, D15
    BFCVT H15, S28
    FRINT32Z S28, S28
    FRINT32Z S27, S9
    BFCVT H19, S19
    FRINT32X S30, S12
    FJCVTZS W29, D21
    FRINT64Z S20, S28
    FRINT64Z D21, D8
    BFCVT H26, S30
    FRINT32X S14, S20
    BFCVT H2, S26
    FRINT32X S6, S21
    BFCVT H21, S27
    FJCVTZS W27, D2
    FJCVTZS W10, D15
    FRINT64Z D26, D19
    FJCVTZS W28, D26
    FJCVTZS W23, D6
    BFCVT H28, S7
    BFCVT H20, S28
    FJCVTZS W10, D14
    SUBS  X6, X6, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_2
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X17, FPSR
    MOVZ  X25, #0x19, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D25
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D30
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X17, D31
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X17
    FMOV  V0.D[1], X5
    FMOV  D1, X10
    FMOV  V1.D[1], X25
    FMOV  D2, X25
    FMOV  V2.D[1], X10
    FMOV  D3, X24
    FMOV  V3.D[1], X29
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X3
    FMOV  V5.D[1], X10
    FMOV  D6, X24
    FMOV  V6.D[1], X24
    FMOV  D7, X7
    FMOV  V7.D[1], X6
    FMOV  D8, X11
    FMOV  V8.D[1], X7
    FMOV  D9, X8
    FMOV  V9.D[1], X3
    FMOV  D10, X27
    FMOV  V10.D[1], X9
    FMOV  D11, X14
    FMOV  V11.D[1], X27
    FMOV  D12, X14
    FMOV  V12.D[1], X6
    FMOV  D13, X9
    FMOV  V13.D[1], X4
    FMOV  D14, X10
    FMOV  V14.D[1], X16
    FMOV  D15, X15
    FMOV  V15.D[1], X23
    FMOV  D16, X29
    FMOV  V16.D[1], X10
    FMOV  D17, X23
    FMOV  V17.D[1], X4
    FMOV  D18, X8
    FMOV  V18.D[1], X24
    FMOV  D19, X3
    FMOV  V19.D[1], X11
    FMOV  D20, X28
    FMOV  V20.D[1], X16
    FMOV  D21, X12
    FMOV  V21.D[1], X8
    FMOV  D22, X14
    FMOV  V22.D[1], X5
    FMOV  D23, X5
    FMOV  V23.D[1], X26
    FMOV  D24, X8
    FMOV  V24.D[1], X26
    FMOV  D25, X17
    FMOV  V25.D[1], X26
    FMOV  D26, X12
    FMOV  V26.D[1], X6
    FMOV  D27, X6
    FMOV  V27.D[1], X24
    FMOV  D28, X12
    FMOV  V28.D[1], X25
    FMOV  D29, X24
    FMOV  V29.D[1], X13
    FMOV  D30, X13
    FMOV  V30.D[1], X8
    FMOV  D31, X7
    FMOV  V31.D[1], X24
    MOVZ  X5, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_3:
    FRINT64X D5, D28
    FRINT64Z D31, D31
    FRINT64Z D3, D12
    FJCVTZS W8, D25
    BFCVT H7, S3
    FJCVTZS W8, D27
    FJCVTZS W13, D30
    FRINT32X S3, S26
    BFCVT H2, S31
    BFCVT H26, S2
    FJCVTZS W24, D8
    FJCVTZS W4, D16
    BFCVT H29, S9
    BFCVT H8, S5
    BFCVT H19, S26
    BFCVT H31, S7
    FJCVTZS W7, D29
    FJCVTZS W15, D19
    BFCVT H23, S10
    FJCVTZS W4, D16
    BFCVT H5, S6
    FJCVTZS W8, D3
    BFCVT H16, S23
    BFCVT H25, S16
    FJCVTZS W26, D8
    FJCVTZS W4, D5
    BFCVT H5, S28
    FJCVTZS W28, D1
    FJCVTZS W6, D25
    FRINT64Z D23, D27
    BFCVT H25, S10
    FJCVTZS W6, D31
    FRINT64Z D16, D5
    FRINT64Z S2, S25
    FRINT32Z S19, S23
    FJCVTZS W4, D19
    BFCVT H25, S2
    BFCVT H3, S15
    FRINT32Z D10, D6
    BFCVT H15, S10
    FJCVTZS W13, D30
    FJCVTZS W11, D3
    BFCVT H10, S29
    FRINT32Z D23, D8
    FJCVTZS W8, D19
    FJCVTZS W14, D3
    BFCVT H3, S1
    BFCVT H11, S27
    FRINT32X D2, D23
    BFCVT H1, S12
    FRINT64Z D14, D9
    FRINT64X D26, D14
    FRINT32Z D8, D3
    BFCVT H27, S25
    BFCVT H14, S11
    FJCVTZS W3, D19
    FRINT32X S25, S8
    FJCVTZS W3, D8
    FJCVTZS W26, D25
    FJCVTZS W9, D26
    BFCVT H19, S5
    BFCVT H25, S2
    BFCVT H9, S9
    FJCVTZS W24, D17
    FRINT64Z S17, S27
    FJCVTZS W3, D14
    FJCVTZS W9, D25
    FRINT32Z D8, D1
    BFCVT H14, S17
    FRINT32Z S26, S8
    BFCVT H25, S26
    FRINT64Z S12, S22
    FJCVTZS W26, D31
    FRINT32X D23, D20
    BFCVT H22, S12
    BFCVT H12, S25
    FJCVTZS W10, D29
    FJCVTZS W9, D10
    FRINT64Z S27, S2
    BFCVT H1, S23
    FJCVTZS W12, D27
    FJCVTZS W6, D1
    FRINT64Z D31, D0
    FJCVTZS W14, D14
    FJCVTZS W4, D19
    FRINT32X S10, S24
    FJCVTZS W15, D2
    FJCVTZS W2, D22
    FRINT64Z S15, S26
    FRINT32X D5, D12
    FRINT64X S1, S10
    BFCVT H26, S22
    FJCVTZS W7, D5
    FJCVTZS W10, D31
    FJCVTZS W12, D3
    FJCVTZS W12, D10
    FJCVTZS W10, D3
    BFCVT H27, S26
    FJCVTZS W7, D5
    FJCVTZS W29, D27
    BFCVT H12, S30
    FRINT64Z D30, D15
    FRINT64Z D25, D30
    FJCVTZS W12, D25
    FRINT64Z D24, D1
    FJCVTZS W14, D24
    BFCVT H15, S26
    FRINT64X D5, D5
    FJCVTZS W24, D25
    FRINT64X D0, D16
    FJCVTZS W2, D14
    FRINT64Z S10, S28
    BFCVT H27, S2
    FJCVTZS W17, D31
    FJCVTZS W28, D2
    FRINT32Z S1, S24
    FRINT64X S28, S26
    FJCVTZS W15, D14
    FJCVTZS W24, D15
    BFCVT H25, S5
    BFCVT H0, S23
    BFCVT H26, S14
    FRINT32Z S5, S21
    FRINT32Z D23, D3
    FRINT32X S30, S28
    FJCVTZS W7, D30
    BFCVT H15, S25
    FRINT64X S26, S0
    FRINT32X S30, S26
    FJCVTZS W4, D27
    BFCVT H14, S16
    BFCVT H24, S10
    FJCVTZS W28, D30
    FJCVTZS W2, D14
    FRINT64Z S21, S0
    FRINT32Z S29, S1
    FJCVTZS W12, D5
    FRINT32Z D2, D15
    FJCVTZS W12, D24
    BFCVT H10, S29
    BFCVT H3, S29
    FJCVTZS W8, D2
    FRINT32Z S27, S21
    BFCVT H25, S23
    FRINT32X S0, S3
    FRINT32Z S30, S27
    FJCVTZS W2, D14
    FJCVTZS W24, D25
    FJCVTZS W8, D0
    FJCVTZS W29, D30
    FRINT32Z S23, S26
    FRINT64Z S3, S10
    FRINT32X S28, S29
    FJCVTZS W17, D26
    FJCVTZS W28, D23
    FJCVTZS W6, D16
    FRINT64Z D26, D12
    FRINT64Z D25, D10
    BFCVT H10, S3
    BFCVT H14, S17
    BFCVT H30, S5
    FRINT32Z D29, D22
    BFCVT H2, S6
    FJCVTZS W2, D5
    FRINT32Z D27, D20
    FJCVTZS W12, D25
    FJCVTZS W4, D26
    BFCVT H17, S29
    FRINT64X S26, S2
    BFCVT H22, S20
    BFCVT H23, S28
    BFCVT H20, S10
    BFCVT H25, S5
    FRINT64Z S3, S12
    BFCVT H12, S26
    FJCVTZS W12, D12
    FRINT32X S28, S26
    BFCVT H12, S22
    FRINT32Z D8, D31
    BFCVT H10, S14
    FRINT32Z D2, D12
    BFCVT H31, S17
    FRINT32X D14, D31
    FRINT64Z D17, D10
    FRINT64Z D5, D15
    FRINT64X D31, D20
    FJCVTZS W9, D7
    FJCVTZS W16, D2
    FRINT32X S7, S19
    BFCVT H18, S17
    BFCVT H0, S28
    BFCVT H22, S27
    FRINT32X D9, D25
    FJCVTZS W9, D22
    FRINT32Z D20, D14
    FRINT32Z S14, S9
    FJCVTZS W4, D7
    BFCVT H10, S6
    FJCVTZS W24, D23
    FJCVTZS W29, D2
    SUBS  X5, X5, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_3
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X27, FPSR
    MOVZ  X25, #0x19, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D0
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D1
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D4
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D6
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D10
    MOVZ  X25, #0x5a5a, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D13
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D25
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D30
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D31
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X11
    FMOV  V1.D[1], X29
    FMOV  D2, X16
    FMOV  V2.D[1], X27
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X5
    FMOV  V4.D[1], X15
    FMOV  D5, X12
    FMOV  V5.D[1], X7
    FMOV  D6, X11
    FMOV  V6.D[1], X14
    FMOV  D7, X13
    FMOV  V7.D[1], X15
    FMOV  D8, X28
    FMOV  V8.D[1], X5
    FMOV  D9, X10
    FMOV  V9.D[1], X27
    FMOV  D10, X5
    FMOV  V10.D[1], X10
    FMOV  D11, X11
    FMOV  V11.D[1], X9
    FMOV  D12, X13
    FMOV  V12.D[1], X16
    FMOV  D13, X9
    FMOV  V13.D[1], X12
    FMOV  D14, X5
    FMOV  V14.D[1], X9
    FMOV  D15, X27
    FMOV  V15.D[1], X25
    FMOV  D16, X14
    FMOV  V16.D[1], X29
    FMOV  D17, X6
    FMOV  V17.D[1], X29
    FMOV  D18, X15
    FMOV  V18.D[1], X12
    FMOV  D19, X28
    FMOV  V19.D[1], X14
    FMOV  D20, X23
    FMOV  V20.D[1], X17
    FMOV  D21, X11
    FMOV  V21.D[1], X9
    FMOV  D22, X23
    FMOV  V22.D[1], X17
    FMOV  D23, X24
    FMOV  V23.D[1], X7
    FMOV  D24, X9
    FMOV  V24.D[1], X12
    FMOV  D25, X23
    FMOV  V25.D[1], X2
    FMOV  D26, X13
    FMOV  V26.D[1], X29
    FMOV  D27, X23
    FMOV  V27.D[1], X24
    FMOV  D28, X2
    FMOV  V28.D[1], X5
    FMOV  D29, X8
    FMOV  V29.D[1], X4
    FMOV  D30, X12
    FMOV  V30.D[1], X27
    FMOV  D31, X25
    FMOV  V31.D[1], X3
    MOVZ  X8, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_4:
    BFCVT H29, S29
    BFCVT H25, S18
    BFCVT H14, S28
    FRINT32X S16, S29
    FJCVTZS W23, D24
    FJCVTZS W11, D28
    FJCVTZS W3, D30
    BFCVT H14, S25
    FRINT32Z S23, S16
    BFCVT H24, S31
    FJCVTZS W2, D4
    BFCVT H22, S24
    FJCVTZS W7, D14
    FJCVTZS W27, D21
    FJCVTZS W12, D23
    BFCVT H1, S22
    BFCVT H2, S1
    FRINT64Z S16, S2
    FRINT32X S28, S26
    FRINT64Z D29, D28
    BFCVT H12, S6
    FJCVTZS W7, D16
    BFCVT H22, S23
    BFCVT H21, S21
    BFCVT H10, S6
    FRINT64Z D8, D22
    FJCVTZS W4, D21
    FRINT64Z S23, S20
    BFCVT H31, S16
    FJCVTZS W10, D19
    FRINT32Z D1, D3
    BFCVT H26, S8
    BFCVT H16, S10
    FJCVTZS W16, D29
    FJCVTZS W2, D23
    FRINT64Z D29, D20
    FJCVTZS W27, D27
    FJCVTZS W29, D12
    BFCVT H10, S31
    FRINT64X S2, S29
    BFCVT H3, S16
    FJCVTZS W27, D10
    FJCVTZS W13, D28
    FJCVTZS W10, D18
    BFCVT H2, S26
    BFCVT H19, S18
    FRINT64X S27, S27
    FRINT32X D31, D3
    FJCVTZS W12, D19
    FRINT32Z D8, D31
    FJCVTZS W7, D10
    BFCVT H26, S8
    FJCVTZS W24, D27
    FRINT64Z S12, S2
    FJCVTZS W14, D26
    FJCVTZS W7, D28
    BFCVT H27, S12
    FJCVTZS W29, D29
    FJCVTZS W10, D20
    BFCVT H19, S2
    FJCVTZS W15, D26
    BFCVT H10, S11
    BFCVT H11, S23
    FJCVTZS W14, D21
    BFCVT H12, S22
    FJCVTZS W3, D8
    FRINT32X D2, D28
    BFCVT H3, S7
    BFCVT H20, S5
    FRINT64X D5, D0
    BFCVT H18, S5
    FRINT32X D28, D2
    BFCVT H23, S10
    FRINT64X S8, S19
    FRINT64X D26, D18
    FJCVTZS W28, D3
    BFCVT H5, S27
    FRINT64Z S0, S28
    BFCVT H3, S8
    BFCVT H27, S23
    BFCVT H7, S0
    FRINT64Z D19, D26
    FJCVTZS W13, D25
    FRINT64Z S25, S3
    FRINT64Z D18, D25
    FJCVTZS W10, D29
    FRINT64X D25, D8
    FRINT32X S8, S11
    BFCVT H19, S1
    FRINT32X D0, D7
    BFCVT H1, S22
    BFCVT H0, S20
    FRINT64X S3, S24
    BFCVT H11, S27
    BFCVT H24, S8
    FRINT64Z D30, D5
    FJCVTZS W16, D10
    FJCVTZS W7, D30
    FRINT32Z S14, S18
    FJCVTZS W13, D24
    BFCVT H27, S14
    FJCVTZS W17, D1
    BFCVT H28, S19
    FRINT64X D18, D19
    BFCVT H17, S28
    BFCVT H17, S27
    FJCVTZS W28, D27
    BFCVT H5, S25
    FRINT64X D1, D16
    BFCVT H8, S11
    BFCVT H28, S3
    BFCVT H14, S1
    FJCVTZS W27, D0
    FRINT64Z D0, D17
    FJCVTZS W23, D9
    FRINT64X D15, D2
    BFCVT H17, S15
    FJCVTZS W23, D18
    FRINT64Z S16, S4
    FJCVTZS W7, D17
    BFCVT H2, S0
    BFCVT H12, S14
    FJCVTZS W24, D28
    FJCVTZS W23, D7
    FJCVTZS W26, D30
    FJCVTZS W13, D12
    FJCVTZS W3, D5
    FRINT32X S17, S7
    FJCVTZS W3, D17
    BFCVT H0, S10
    BFCVT H17, S16
    BFCVT H18, S2
    FJCVTZS W12, D29
    BFCVT H12, S0
    FJCVTZS W7, D8
    FRINT32X S8, S0
    BFCVT H5, S8
    BFCVT H0, S12
    BFCVT H27, S5
    FJCVTZS W23, D31
    BFCVT H12, S3
    BFCVT H28, S24
    FRINT64Z S5, S29
    FRINT32Z D26, D29
    FRINT64X D30, D1
    FJCVTZS W17, D27
    BFCVT H10, S28
    FJCVTZS W16, D18
    BFCVT H23, S26
    FJCVTZS W5, D25
    BFCVT H31, S5
    BFCVT H26, S17
    BFCVT H28, S13
    BFCVT H5, S26
    BFCVT H27, S20
    FJCVTZS W13, D31
    FRINT64Z S3, S17
    FJCVTZS W4, D5
    BFCVT H29, S23
    FJCVTZS W17, D30
    FRINT64X S18, S30
    BFCVT H20, S30
    BFCVT H13, S18
    BFCVT H17, S3
    BFCVT H30, S20
    FRINT32Z D4, D0
    FJCVTZS W3, D30
    FJCVTZS W13, D17
    BFCVT H28, S22
    FJCVTZS W23, D13
    FJCVTZS W15, D8
    FJCVTZS W26, D23
    BFCVT H19, S15
    BFCVT H17, S14
    FJCVTZS W3, D14
    BFCVT H22, S21
    BFCVT H23, S29
    FRINT32X S7, S4
    FJCVTZS W5, D9
    FRINT32X D30, D28
    FRINT64Z D0, D21
    BFCVT H20, S17
    FRINT32Z S3, S7
    FJCVTZS W12, D7
    BFCVT H4, S19
    BFCVT H15, S20
    FJCVTZS W29, D30
    FRINT64X D30, D12
    FJCVTZS W2, D29
    FRINT32Z D29, D1
    BFCVT H20, S6
    FRINT64Z S5, S25
    BFCVT H20, S21
    FJCVTZS W23, D4
    FRINT64X S12, S27
    BFCVT H21, S3
    BFCVT H21, S19
    BFCVT H4, S0
    BFCVT H2, S30
    FJCVTZS W23, D26
    SUBS  X8, X8, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_4
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X25, FPSR
    MOVZ  X9, #0x19, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D6
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D9
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X25, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X2, #0xd737, LSL #0
    MOVK  X2, #0xd020, LSL #16
    MOVK  X2, #0xcd40, LSL #32
    MOVK  X2, #0xcae0, LSL #48
    MOVZ  X3, #0xc09b, LSL #0
    MOVK  X3, #0xf123, LSL #16
    MOVK  X3, #0x6ee0, LSL #32
    MOVK  X3, #0xeb6e, LSL #48
    MOVZ  X4, #0xd1b4, LSL #0
    MOVK  X4, #0x8d13, LSL #16
    MOVK  X4, #0xb9db, LSL #32
    MOVK  X4, #0xa8d7, LSL #48
    MOVZ  X5, #0x1c91, LSL #0
    MOVK  X5, #0xb3a5, LSL #16
    MOVK  X5, #0xac9f, LSL #32
    MOVK  X5, #0x9e9a, LSL #48
    MOVZ  X6, #0x1b1f, LSL #0
    MOVK  X6, #0x11c1, LSL #16
    MOVK  X6, #0x93d8, LSL #32
    MOVK  X6, #0xc0a9, LSL #48
    MOVZ  X7, #0xcb6, LSL #0
    MOVK  X7, #0x322a, LSL #16
    MOVK  X7, #0xb86e, LSL #32
    MOVK  X7, #0x4bf4, LSL #48
    MOVZ  X8, #0x7b97, LSL #0
    MOVK  X8, #0xc46c, LSL #16
    MOVK  X8, #0x71ca, LSL #32
    MOVK  X8, #0xfb2a, LSL #48
    MOVZ  X9, #0xac3a, LSL #0
    MOVK  X9, #0x5e70, LSL #16
    MOVK  X9, #0xf628, LSL #32
    MOVK  X9, #0x7025, LSL #48
    MOVZ  X10, #0x229, LSL #0
    MOVK  X10, #0xa534, LSL #16
    MOVK  X10, #0xc415, LSL #32
    MOVK  X10, #0xa2e2, LSL #48
    MOVZ  X11, #0x9934, LSL #0
    MOVK  X11, #0xe0a, LSL #16
    MOVK  X11, #0xce61, LSL #32
    MOVK  X11, #0xa3cc, LSL #48
    MOVZ  X12, #0x33e3, LSL #0
    MOVK  X12, #0x24da, LSL #16
    MOVK  X12, #0xa452, LSL #32
    MOVK  X12, #0xb798, LSL #48
    MOVZ  X13, #0xeb46, LSL #0
    MOVK  X13, #0x8f26, LSL #16
    MOVK  X13, #0x1c1, LSL #32
    MOVK  X13, #0xdbbb, LSL #48
    MOVZ  X14, #0xdb4a, LSL #0
    MOVK  X14, #0x23ae, LSL #16
    MOVK  X14, #0x878e, LSL #32
    MOVK  X14, #0x7545, LSL #48
    MOVZ  X15, #0xe58b, LSL #0
    MOVK  X15, #0x5fd7, LSL #16
    MOVK  X15, #0xa3ff, LSL #32
    MOVK  X15, #0xcb82, LSL #48
    MOVZ  X16, #0xa0ec, LSL #0
    MOVK  X16, #0xc98d, LSL #16
    MOVK  X16, #0xac7e, LSL #32
    MOVK  X16, #0x7763, LSL #48
    MOVZ  X17, #0x12ec, LSL #0
    MOVK  X17, #0xe4d9, LSL #16
    MOVK  X17, #0xd98, LSL #32
    MOVK  X17, #0x8066, LSL #48
    MOVZ  X23, #0x1258, LSL #0
    MOVK  X23, #0x395d, LSL #16
    MOVK  X23, #0x7fdf, LSL #32
    MOVK  X23, #0xbed3, LSL #48
    MOVZ  X24, #0xf782, LSL #0
    MOVK  X24, #0x2dd1, LSL #16
    MOVK  X24, #0x36cd, LSL #32
    MOVK  X24, #0xec5a, LSL #48
    MOVZ  X25, #0xfda0, LSL #0
    MOVK  X25, #0x3ee0, LSL #16
    MOVK  X25, #0xd611, LSL #32
    MOVK  X25, #0x66e4, LSL #48
    MOVZ  X26, #0x44c8, LSL #0
    MOVK  X26, #0xf303, LSL #16
    MOVK  X26, #0x59f4, LSL #32
    MOVK  X26, #0x5b9b, LSL #48
    MOVZ  X27, #0xa881, LSL #0
    MOVK  X27, #0x8a57, LSL #16
    MOVK  X27, #0xbc12, LSL #32
    MOVK  X27, #0xa07f, LSL #48
    MOVZ  X28, #0x9feb, LSL #0
    MOVK  X28, #0x9aa, LSL #16
    MOVK  X28, #0x467b, LSL #32
    MOVK  X28, #0xfee4, LSL #48
    MOVZ  X29, #0xc4ce, LSL #0
    MOVK  X29, #0x864e, LSL #16
    MOVK  X29, #0xc125, LSL #32
    MOVK  X29, #0xa2e1, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X25
    FMOV  D3, X28
    FMOV  V3.D[1], X8
    FMOV  D4, X27
    FMOV  V4.D[1], X26
    FMOV  D5, X23
    FMOV  V5.D[1], X8
    FMOV  D6, X24
    FMOV  V6.D[1], X10
    FMOV  D7, X26
    FMOV  V7.D[1], X13
    FMOV  D8, X16
    FMOV  V8.D[1], X7
    FMOV  D9, X8
    FMOV  V9.D[1], X25
    FMOV  D10, X4
    FMOV  V10.D[1], X5
    FMOV  D11, X3
    FMOV  V11.D[1], X14
    FMOV  D12, X28
    FMOV  V12.D[1], X15
    FMOV  D13, X12
    FMOV  V13.D[1], X27
    FMOV  D14, X2
    FMOV  V14.D[1], X9
    FMOV  D15, X28
    FMOV  V15.D[1], X29
    FMOV  D16, X5
    FMOV  V16.D[1], X11
    FMOV  D17, X5
    FMOV  V17.D[1], X3
    FMOV  D18, X4
    FMOV  V18.D[1], X24
    FMOV  D19, X7
    FMOV  V19.D[1], X7
    FMOV  D20, X10
    FMOV  V20.D[1], X26
    FMOV  D21, X26
    FMOV  V21.D[1], X5
    FMOV  D22, X7
    FMOV  V22.D[1], X12
    FMOV  D23, X11
    FMOV  V23.D[1], X26
    FMOV  D24, X8
    FMOV  V24.D[1], X27
    FMOV  D25, X12
    FMOV  V25.D[1], X28
    FMOV  D26, X29
    FMOV  V26.D[1], X15
    FMOV  D27, X25
    FMOV  V27.D[1], X16
    FMOV  D28, X7
    FMOV  V28.D[1], X17
    FMOV  D29, X4
    FMOV  V29.D[1], X12
    FMOV  D30, X6
    FMOV  V30.D[1], X24
    FMOV  D31, X11
    FMOV  V31.D[1], X26
    MOVZ  X2, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_5:
    BFCVT H16, S11
    FJCVTZS W17, D1
    FJCVTZS W26, D21
    FJCVTZS W16, D16
    FRINT64X S30, S25
    FRINT64Z S17, S31
    FRINT64X D12, D19
    BFCVT H20, S9
    BFCVT H1, S20
    FRINT32Z D15, D27
    FJCVTZS W8, D29
    FJCVTZS W4, D15
    FJCVTZS W27, D7
    BFCVT H30, S30
    FRINT64Z D26, D17
    BFCVT H26, S14
    FJCVTZS W11, D15
    FJCVTZS W7, D12
    FJCVTZS W13, D22
    FRINT32Z S28, S30
    FRINT32X S7, S8
    BFCVT H25, S8
    FJCVTZS W14, D26
    FRINT64Z D14, D1
    FJCVTZS W3, D13
    FRINT64Z S13, S4
    FJCVTZS W14, D7
    BFCVT H20, S25
    BFCVT H12, S13
    BFCVT H13, S20
    BFCVT H31, S28
    BFCVT H21, S15
    FJCVTZS W27, D13
    BFCVT H8, S21
    FJCVTZS W13, D23
    FRINT64X D27, D12
    FRINT64X S25, S31
    BFCVT H13, S25
    FJCVTZS W7, D15
    FRINT32X D22, D8
    BFCVT H9, S27
    FJCVTZS W25, D9
    FRINT64Z S4, S22
    BFCVT H9, S9
    FRINT64X S7, S19
    FJCVTZS W17, D4
    FJCVTZS W29, D13
    BFCVT H13, S7
    BFCVT H4, S9
    FRINT32Z D12, D13
    FRINT32Z D13, D4
    FRINT64X D27, D16
    FJCVTZS W29, D6
    BFCVT H6, S26
    BFCVT H4, S13
    BFCVT H23, S4
    BFCVT H15, S4
    FRINT64Z D19, D23
    BFCVT H25, S29
    BFCVT H23, S5
    FRINT64Z S4, S23
    FRINT32Z D5, D19
    FRINT64X D26, D27
    FRINT32Z S9, S27
    FJCVTZS W9, D12
    FRINT32Z S23, S9
    FRINT64Z D29, D4
    FJCVTZS W16, D23
    BFCVT H8, S25
    BFCVT H6, S17
    BFCVT H12, S10
    FRINT32Z S0, S28
    FJCVTZS W3, D29
    FJCVTZS W23, D13
    BFCVT H6, S5
    FJCVTZS W12, D15
    FRINT64Z S16, S6
    BFCVT H25, S30
    FRINT64Z S17, S25
    BFCVT H9, S12
    BFCVT H30, S23
    FJCVTZS W5, D0
    FRINT64X S6, S25
    FRINT32X S5, S6
    FJCVTZS W27, D1
    FJCVTZS W25, D30
    FRINT64X S23, S9
    FRINT32Z D30, D23
    FRINT64Z D27, D8
    FJCVTZS W5, D29
    FJCVTZS W16, D30
    FRINT64Z D6, D23
    FJCVTZS W14, D17
    FJCVTZS W7, D5
    FRINT64Z D29, D6
    FJCVTZS W14, D27
    BFCVT H5, S20
    FJCVTZS W13, D2
    FJCVTZS W14, D5
    BFCVT H17, S5
    FRINT32Z S2, S17
    FRINT32X S27, S29
    FRINT32Z S29, S9
    FRINT32X D28, D29
    BFCVT H30, S28
    FRINT32Z S6, S30
    FRINT32X S16, S29
    BFCVT H5, S27
    FRINT64Z D23, D0
    FRINT64Z D9, D2
    FRINT32X D2, D16
    FJCVTZS W12, D9
    FRINT64Z S28, S8
    BFCVT H20, S2
    BFCVT H27, S20
    FJCVTZS W4, D18
    FJCVTZS W14, D23
    FJCVTZS W7, D28
    FJCVTZS W13, D27
    FJCVTZS W3, D5
    BFCVT H16, S3
    FJCVTZS W14, D17
    BFCVT H27, S19
    FJCVTZS W12, D18
    BFCVT H23, S24
    FJCVTZS W23, D20
    FRINT32Z D25, D9
    FJCVTZS W5, D7
    BFCVT H24, S2
    FJCVTZS W6, D1
    FJCVTZS W13, D29
    FJCVTZS W7, D24
    FJCVTZS W6, D27
    FJCVTZS W6, D22
    FRINT64X S17, S26
    FRINT64Z S19, S16
    FRINT32X D28, D10
    BFCVT H29, S19
    FRINT64X D18, D3
    FJCVTZS W17, D7
    FRINT32Z S19, S3
    BFCVT H2, S24
    FRINT64X S1, S7
    FJCVTZS W5, D2
    FRINT64Z D26, D29
    BFCVT H10, S9
    FJCVTZS W28, D19
    FJCVTZS W29, D10
    FRINT64Z D3, D22
    FRINT32Z S22, S25
    FRINT64Z D2, D23
    FJCVTZS W23, D28
    FJCVTZS W8, D6
    FJCVTZS W25, D3
    FRINT32X D20, D22
    BFCVT H27, S26
    FJCVTZS W29, D2
    BFCVT H3, S3
    BFCVT H28, S22
    BFCVT H10, S20
    FRINT64Z D20, D1
    BFCVT H29, S3
    BFCVT H22, S23
    BFCVT H9, S29
    FRINT32X S6, S17
    FRINT32X D29, D6
    FRINT64Z S19, S20
    FRINT32Z S3, S30
    BFCVT H20, S22
    FRINT64X S6, S27
    BFCVT H26, S28
    BFCVT H17, S6
    FRINT64Z D27, D10
    FJCVTZS W17, D22
    FJCVTZS W16, D28
    BFCVT H7, S9
    FJCVTZS W16, D26
    FJCVTZS W4, D20
    FJCVTZS W4, D3
    FJCVTZS W12, D2
    FJCVTZS W14, D17
    FJCVTZS W26, D29
    BFCVT H23, S6
    FJCVTZS W16, D19
    FJCVTZS W6, D27
    FRINT64Z S10, S24
    FJCVTZS W27, D10
    FJCVTZS W5, D7
    BFCVT H10, S13
    FJCVTZS W17, D19
    FRINT32X S1, S11
    FJCVTZS W26, D24
    FJCVTZS W16, D3
    FJCVTZS W5, D21
    FRINT32Z S15, S4
    BFCVT H2, S12
    FJCVTZS W7, D8
    FJCVTZS W16, D4
    FJCVTZS W16, D15
    FJCVTZS W13, D7
    SUBS  X2, X2, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_5
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X24, FPSR
    MOVZ  X15, #0x19, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D1
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xcf00, LSL #16
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X15, #0xdb4a, LSL #0
    MOVK  X15, #0x23ae, LSL #16
    MOVK  X15, #0x878e, LSL #32
    MOVK  X15, #0x7545, LSL #48
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D11
    MOVZ  X15, #0xc09b, LSL #0
    MOVK  X15, #0xf123, LSL #16
    MOVK  X15, #0x6ee0, LSL #32
    MOVK  X15, #0xeb6e, LSL #48
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D26
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X24, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X8
    FMOV  V0.D[1], X28
    FMOV  D1, X11
    FMOV  V1.D[1], X25
    FMOV  D2, X15
    FMOV  V2.D[1], X27
    FMOV  D3, X13
    FMOV  V3.D[1], X12
    FMOV  D4, X26
    FMOV  V4.D[1], X24
    FMOV  D5, X16
    FMOV  V5.D[1], X8
    FMOV  D6, X23
    FMOV  V6.D[1], X16
    FMOV  D7, X29
    FMOV  V7.D[1], X16
    FMOV  D8, X13
    FMOV  V8.D[1], X15
    FMOV  D9, X25
    FMOV  V9.D[1], X6
    FMOV  D10, X29
    FMOV  V10.D[1], X8
    FMOV  D11, X5
    FMOV  V11.D[1], X16
    FMOV  D12, X25
    FMOV  V12.D[1], X15
    FMOV  D13, X23
    FMOV  V13.D[1], X2
    FMOV  D14, X29
    FMOV  V14.D[1], X8
    FMOV  D15, X4
    FMOV  V15.D[1], X3
    FMOV  D16, X29
    FMOV  V16.D[1], X3
    FMOV  D17, X13
    FMOV  V17.D[1], X6
    FMOV  D18, X3
    FMOV  V18.D[1], X23
    FMOV  D19, X12
    FMOV  V19.D[1], X2
    FMOV  D20, X24
    FMOV  V20.D[1], X7
    FMOV  D21, X17
    FMOV  V21.D[1], X6
    FMOV  D22, X24
    FMOV  V22.D[1], X23
    FMOV  D23, X23
    FMOV  V23.D[1], X27
    FMOV  D24, X8
    FMOV  V24.D[1], X8
    FMOV  D25, X15
    FMOV  V25.D[1], X7
    FMOV  D26, X16
    FMOV  V26.D[1], X11
    FMOV  D27, X11
    FMOV  V27.D[1], X6
    FMOV  D28, X14
    FMOV  V28.D[1], X29
    FMOV  D29, X28
    FMOV  V29.D[1], X4
    FMOV  D30, X8
    FMOV  V30.D[1], X10
    FMOV  D31, X28
    FMOV  V31.D[1], X28
    MOVZ  X23, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_6:
    FRINT32X S19, S26
    FRINT32X D24, D13
    BFCVT H22, S30
    BFCVT H29, S29
    BFCVT H21, S22
    FRINT32X S6, S29
    FRINT64X S2, S31
    FJCVTZS W11, D27
    FRINT64Z D9, D4
    FJCVTZS W6, D19
    FJCVTZS W4, D0
    FRINT32Z D21, D21
    FRINT32Z D9, D29
    FRINT32Z D28, D2
    FRINT64Z S28, S24
    FJCVTZS W10, D9
    BFCVT H17, S6
    BFCVT H19, S21
    FJCVTZS W6, D28
    BFCVT H27, S1
    BFCVT H28, S17
    FRINT64X D0, D19
    FJCVTZS W8, D27
    FJCVTZS W25, D28
    FJCVTZS W10, D10
    FRINT64X S30, S13
    FJCVTZS W6, D23
    BFCVT H21, S25
    FRINT64X S2, S25
    FJCVTZS W16, D5
    BFCVT H25, S4
    FRINT32X D28, D13
    BFCVT H27, S0
    FJCVTZS W5, D1
    FRINT64X D1, D24
    FJCVTZS W14, D10
    FJCVTZS W16, D31
    FRINT64X S27, S18
    FJCVTZS W16, D9
    BFCVT H0, S22
    FJCVTZS W7, D28
    BFCVT H13, S26
    FJCVTZS W9, D6
    FJCVTZS W13, D30
    FRINT32X D5, D19
    FRINT64Z D28, D16
    FRINT64X S11, S27
    FJCVTZS W13, D21
    BFCVT H17, S0
    FJCVTZS W2, D13
    FJCVTZS W12, D8
    BFCVT H10, S28
    FJCVTZS W26, D29
    BFCVT H6, S8
    FJCVTZS W15, D24
    FJCVTZS W12, D4
    FRINT32X S30, S10
    FRINT64X D16, D6
    BFCVT H4, S17
    FRINT64X S22, S1
    FRINT64X D13, D22
    FRINT32X S1, S4
    BFCVT H0, S20
    FRINT32Z D20, D4
    BFCVT H4, S6
    FJCVTZS W14, D17
    FRINT64Z S21, S30
    FRINT64X D9, D16
    FRINT32Z S20, S0
    FJCVTZS W9, D8
    FRINT32X D28, D7
    BFCVT H8, S9
    BFCVT H22, S28
    BFCVT H31, S21
    FJCVTZS W11, D8
    FRINT64X D7, D20
    BFCVT H29, S18
    FJCVTZS W6, D31
    FRINT64Z D25, D1
    FRINT64Z S8, S2
    BFCVT H17, S11
    FRINT64Z D16, D4
    FJCVTZS W7, D16
    FJCVTZS W14, D20
    FJCVTZS W16, D15
    FJCVTZS W9, D1
    FRINT32X D14, D22
    FRINT64X S0, S7
    FJCVTZS W15, D0
    FJCVTZS W12, D28
    FRINT64Z S31, S13
    FJCVTZS W4, D5
    FJCVTZS W17, D25
    FJCVTZS W8, D22
    FRINT32X D0, D24
    BFCVT H5, S21
    BFCVT H13, S8
    FRINT32X D24, D13
    FJCVTZS W7, D27
    FRINT64X D1, D31
    BFCVT H7, S14
    FJCVTZS W26, D7
    FJCVTZS W6, D28
    FRINT32X D14, D0
    FJCVTZS W6, D14
    FRINT64Z D21, D5
    FRINT32Z D0, D15
    FJCVTZS W13, D25
    FJCVTZS W29, D0
    BFCVT H15, S30
    FJCVTZS W16, D15
    BFCVT H6, S24
    FJCVTZS W14, D1
    FJCVTZS W3, D21
    FJCVTZS W7, D2
    FJCVTZS W9, D29
    BFCVT H24, S19
    BFCVT H24, S11
    FRINT64X S27, S31
    FRINT32Z D13, D25
    FJCVTZS W6, D21
    FRINT32X D14, D1
    BFCVT H2, S18
    FJCVTZS W13, D20
    FJCVTZS W3, D3
    BFCVT H1, S3
    FRINT32X S25, S30
    FJCVTZS W10, D1
    FRINT32X S15, S7
    FJCVTZS W25, D26
    BFCVT H23, S11
    BFCVT H15, S12
    BFCVT H7, S27
    FRINT64X D0, D7
    FJCVTZS W17, D24
    FJCVTZS W3, D2
    BFCVT H2, S23
    BFCVT H11, S10
    FRINT32X S21, S14
    FJCVTZS W12, D23
    FJCVTZS W13, D18
    FRINT32X S23, S11
    BFCVT H11, S25
    FRINT64Z S12, S21
    BFCVT H24, S0
    FRINT64X S1, S23
    FJCVTZS W2, D24
    FJCVTZS W7, D1
    FJCVTZS W10, D15
    FRINT64X S15, S14
    FRINT32X D0, D2
    BFCVT H27, S0
    BFCVT H25, S27
    BFCVT H14, S12
    FRINT64X D18, D14
    FJCVTZS W25, D29
    FJCVTZS W4, D18
    FRINT32Z D2, D6
    FJCVTZS W9, D11
    BFCVT H18, S31
    FJCVTZS W13, D11
    FJCVTZS W12, D25
    FRINT32Z D29, D17
    BFCVT H6, S17
    FRINT64Z S27, S2
    BFCVT H2, S6
    FJCVTZS W2, D10
    FRINT32Z D25, D29
    BFCVT H20, S5
    FRINT32X S12, S25
    BFCVT H11, S27
    FJCVTZS W9, D7
    FRINT64X D27, D20
    FRINT32X S20, S27
    FJCVTZS W4, D19
    BFCVT H27, S12
    FRINT32X S19, S18
    BFCVT H1, S14
    BFCVT H5, S27
    FRINT64Z S26, S20
    FRINT64Z S6, S9
    FRINT32X D7, D8
    FRINT32X D14, D5
    FRINT32Z S17, S31
    FJCVTZS W10, D7
    BFCVT H5, S29
    FJCVTZS W29, D5
    FRINT64X D7, D1
    BFCVT H10, S17
    FJCVTZS W5, D9
    BFCVT H12, S11
    BFCVT H11, S6
    FRINT32Z S31, S12
    FJCVTZS W12, D7
    FRINT32X D17, D19
    FRINT32Z S19, S14
    FRINT32X D29, D17
    FJCVTZS W26, D26
    FJCVTZS W25, D10
    FRINT64Z S9, S19
    SUBS  X23, X23, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_6
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X27, FPSR
    MOVZ  X24, #0x19, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X27, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X3
    FMOV  V0.D[1], X6
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X6
    FMOV  V4.D[1], X5
    FMOV  D5, X29
    FMOV  V5.D[1], X4
    FMOV  D6, X17
    FMOV  V6.D[1], X27
    FMOV  D7, X7
    FMOV  V7.D[1], X29
    FMOV  D8, X6
    FMOV  V8.D[1], X27
    FMOV  D9, X4
    FMOV  V9.D[1], X9
    FMOV  D10, X6
    FMOV  V10.D[1], X15
    FMOV  D11, X9
    FMOV  V11.D[1], X15
    FMOV  D12, X24
    FMOV  V12.D[1], X23
    FMOV  D13, X24
    FMOV  V13.D[1], X14
    FMOV  D14, X17
    FMOV  V14.D[1], X24
    FMOV  D15, X23
    FMOV  V15.D[1], X5
    FMOV  D16, X5
    FMOV  V16.D[1], X14
    FMOV  D17, X7
    FMOV  V17.D[1], X16
    FMOV  D18, X26
    FMOV  V18.D[1], X12
    FMOV  D19, X2
    FMOV  V19.D[1], X9
    FMOV  D20, X4
    FMOV  V20.D[1], X17
    FMOV  D21, X3
    FMOV  V21.D[1], X24
    FMOV  D22, X9
    FMOV  V22.D[1], X3
    FMOV  D23, X5
    FMOV  V23.D[1], X27
    FMOV  D24, X3
    FMOV  V24.D[1], X16
    FMOV  D25, X10
    FMOV  V25.D[1], X17
    FMOV  D26, X23
    FMOV  V26.D[1], X4
    FMOV  D27, X17
    FMOV  V27.D[1], X4
    FMOV  D28, X6
    FMOV  V28.D[1], X12
    FMOV  D29, X28
    FMOV  V29.D[1], X17
    FMOV  D30, X14
    FMOV  V30.D[1], X6
    FMOV  D31, X24
    FMOV  V31.D[1], X11
    MOVZ  X25, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_7:
    FJCVTZS W14, D21
    FRINT32X D8, D18
    BFCVT H30, S29
    FRINT32Z D28, D27
    FRINT64X D4, D19
    FJCVTZS W17, D4
    FJCVTZS W3, D25
    FJCVTZS W6, D14
    BFCVT H0, S17
    FRINT64X S17, S8
    FRINT32Z S11, S30
    FJCVTZS W13, D28
    FRINT64X D30, D11
    BFCVT H1, S31
    FJCVTZS W11, D26
    FJCVTZS W24, D17
    FRINT64X D30, D30
    FJCVTZS W23, D0
    FJCVTZS W14, D30
    FRINT64Z D25, D12
    FJCVTZS W26, D31
    BFCVT H26, S12
    FRINT64X D11, D5
    FRINT32X S12, S9
    FRINT64X D5, D24
    BFCVT H9, S27
    BFCVT H17, S17
    FJCVTZS W29, D11
    FRINT32Z D11, D1
    FJCVTZS W10, D17
    BFCVT H0, S19
    BFCVT H24, S27
    BFCVT H1, S16
    FRINT32X D21, D12
    BFCVT H8, S24
    FRINT32Z D30, D8
    BFCVT H21, S21
    FJCVTZS W23, D5
    BFCVT H12, S9
    BFCVT H5, S11
    BFCVT H24, S0
    BFCVT H19, S26
    FJCVTZS W6, D20
    FRINT32Z D9, D30
    FJCVTZS W5, D1
    FJCVTZS W26, D24
    BFCVT H16, S21
    FJCVTZS W13, D29
    BFCVT H31, S19
    FRINT64X S24, S17
    FJCVTZS W14, D12
    FRINT64Z S12, S28
    FRINT32Z S20, S19
    FJCVTZS W27, D25
    BFCVT H17, S1
    FJCVTZS W3, D5
    FJCVTZS W17, D11
    FRINT64X D1, D9
    FJCVTZS W9, D31
    BFCVT H28, S26
    FJCVTZS W27, D20
    FRINT64Z D31, D17
    FRINT64X D9, D24
    BFCVT H8, S28
    FJCVTZS W9, D12
    BFCVT H17, S16
    FJCVTZS W9, D27
    FRINT32Z S19, S1
    FJCVTZS W5, D9
    FJCVTZS W29, D17
    BFCVT H5, S31
    BFCVT H31, S19
    FRINT32Z D1, D20
    FRINT64X D16, D23
    FRINT32X S26, S10
    FJCVTZS W9, D26
    FRINT64X S19, S8
    BFCVT H17, S31
    BFCVT H15, S2
    FRINT32X S31, S29
    FJCVTZS W27, D24
    FRINT64X S25, S19
    BFCVT H20, S19
    BFCVT H27, S17
    BFCVT H26, S10
    BFCVT H2, S18
    FRINT32X D24, D15
    FRINT32Z S10, S25
    BFCVT H23, S20
    FJCVTZS W14, D27
    FJCVTZS W29, D31
    BFCVT H29, S19
    FJCVTZS W23, D16
    FRINT32X S20, S10
    BFCVT H27, S24
    FRINT32X D19, D29
    FJCVTZS W27, D27
    FJCVTZS W26, D26
    BFCVT H15, S9
    BFCVT H25, S2
    BFCVT H9, S15
    FRINT64X S26, S9
    FRINT32Z S16, S1
    BFCVT H2, S23
    BFCVT H29, S25
    FJCVTZS W28, D25
    BFCVT H23, S2
    FRINT32Z S9, S8
    FRINT64Z D18, D23
    FJCVTZS W7, D16
    FJCVTZS W14, D28
    FJCVTZS W4, D19
    FRINT64X D19, D9
    BFCVT H3, S18
    BFCVT H28, S3
    FJCVTZS W7, D26
    FRINT64X S15, S29
    BFCVT H16, S3
    BFCVT H26, S16
    FRINT32X D26, D15
    BFCVT H12, S1
    BFCVT H29, S26
    BFCVT H25, S3
    FRINT64X D1, D27
    FJCVTZS W26, D28
    BFCVT H4, S19
    BFCVT H9, S23
    FJCVTZS W6, D23
    FJCVTZS W4, D1
    BFCVT H16, S25
    FRINT32X D14, D27
    FJCVTZS W2, D4
    FRINT32Z S2, S14
    BFCVT H18, S16
    FJCVTZS W14, D16
    FJCVTZS W2, D29
    FJCVTZS W15, D15
    FJCVTZS W13, D9
    FRINT64X S28, S30
    FRINT64Z S26, S2
    FJCVTZS W24, D12
    FRINT64X S14, S5
    FRINT32X D25, D28
    FJCVTZS W23, D18
    FJCVTZS W10, D26
    BFCVT H26, S20
    BFCVT H16, S6
    FJCVTZS W14, D30
    BFCVT H28, S25
    BFCVT H9, S26
    FRINT32X S12, S30
    FRINT32Z S29, S16
    FRINT64Z D15, D12
    FRINT32Z S26, S15
    BFCVT H18, S29
    BFCVT H29, S21
    BFCVT H12, S9
    FRINT32Z D20, D28
    FRINT64Z S1, S26
    FRINT64Z D29, D8
    FJCVTZS W24, D29
    FRINT64X D4, D1
    BFCVT H30, S3
    FRINT64X D29, D18
    FRINT32Z S6, S29
    FJCVTZS W4, D12
    BFCVT H18, S6
    FRINT32X D16, D4
    FRINT32X D15, D0
    FRINT32X D25, D18
    BFCVT H21, S15
    FRINT32Z S3, S20
    FJCVTZS W28, D30
    FJCVTZS W14, D22
    FRINT32X D28, D3
    BFCVT H17, S25
    BFCVT H18, S21
    BFCVT H21, S23
    FRINT32Z S4, S17
    BFCVT H12, S18
    FRINT32Z S25, S4
    BFCVT H1, S25
    FJCVTZS W27, D21
    BFCVT H29, S27
    FRINT32X S30, S12
    FJCVTZS W26, D17
    FJCVTZS W29, D28
    FRINT64Z S4, S26
    FJCVTZS W9, D4
    FRINT64Z D3, D16
    BFCVT H16, S5
    FJCVTZS W24, D3
    BFCVT H21, S30
    BFCVT H17, S26
    FRINT64Z S30, S16
    FJCVTZS W23, D29
    BFCVT H28, S18
    FRINT32X S26, S17
    FJCVTZS W17, D28
    BFCVT H3, S1
    SUBS  X25, X25, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_7
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X8, FPSR
    MOVZ  X16, #0x19, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D0
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D7
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D13
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D16
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D22
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D30
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X8, D31
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X17
    FMOV  D1, X25
    FMOV  V1.D[1], X17
    FMOV  D2, X10
    FMOV  V2.D[1], X23
    FMOV  D3, X2
    FMOV  V3.D[1], X3
    FMOV  D4, X29
    FMOV  V4.D[1], X2
    FMOV  D5, X27
    FMOV  V5.D[1], X10
    FMOV  D6, X29
    FMOV  V6.D[1], X7
    FMOV  D7, X23
    FMOV  V7.D[1], X3
    FMOV  D8, X24
    FMOV  V8.D[1], X2
    FMOV  D9, X17
    FMOV  V9.D[1], X10
    FMOV  D10, X11
    FMOV  V10.D[1], X8
    FMOV  D11, X5
    FMOV  V11.D[1], X25
    FMOV  D12, X6
    FMOV  V12.D[1], X29
    FMOV  D13, X15
    FMOV  V13.D[1], X2
    FMOV  D14, X14
    FMOV  V14.D[1], X17
    FMOV  D15, X24
    FMOV  V15.D[1], X24
    FMOV  D16, X6
    FMOV  V16.D[1], X11
    FMOV  D17, X9
    FMOV  V17.D[1], X5
    FMOV  D18, X6
    FMOV  V18.D[1], X24
    FMOV  D19, X11
    FMOV  V19.D[1], X2
    FMOV  D20, X3
    FMOV  V20.D[1], X25
    FMOV  D21, X4
    FMOV  V21.D[1], X11
    FMOV  D22, X10
    FMOV  V22.D[1], X15
    FMOV  D23, X7
    FMOV  V23.D[1], X12
    FMOV  D24, X13
    FMOV  V24.D[1], X7
    FMOV  D25, X14
    FMOV  V25.D[1], X24
    FMOV  D26, X16
    FMOV  V26.D[1], X11
    FMOV  D27, X5
    FMOV  V27.D[1], X6
    FMOV  D28, X8
    FMOV  V28.D[1], X12
    FMOV  D29, X6
    FMOV  V29.D[1], X10
    FMOV  D30, X16
    FMOV  V30.D[1], X29
    FMOV  D31, X23
    FMOV  V31.D[1], X26
    MOVZ  X4, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_8:
    BFCVT H13, S22
    FJCVTZS W24, D29
    FRINT32X S19, S20
    FRINT64Z D12, D13
    FJCVTZS W5, D6
    BFCVT H23, S26
    BFCVT H9, S23
    FJCVTZS W16, D30
    FJCVTZS W14, D19
    FJCVTZS W26, D31
    BFCVT H19, S9
    FRINT64Z D27, D19
    FJCVTZS W12, D27
    FJCVTZS W10, D12
    FJCVTZS W23, D18
    BFCVT H1, S23
    FJCVTZS W29, D1
    BFCVT H20, S31
    FRINT32X S27, S20
    FJCVTZS W27, D17
    FRINT32Z S31, S25
    FJCVTZS W7, D18
    FRINT64Z D2, D3
    BFCVT H19, S11
    FJCVTZS W2, D29
    FRINT64Z S29, S15
    FRINT64Z D12, D30
    FRINT64X S15, S12
    FRINT64Z D26, D25
    FJCVTZS W5, D9
    BFCVT H25, S26
    FRINT64X D4, D8
    BFCVT H1, S4
    BFCVT H20, S27
    BFCVT H11, S31
    FJCVTZS W8, D8
    BFCVT H27, S7
    FJCVTZS W3, D1
    FRINT32X D6, D11
    FRINT64X D16, D27
    BFCVT H26, S6
    FRINT64Z D9, D26
    BFCVT H7, S4
    FJCVTZS W6, D15
    FJCVTZS W7, D15
    FJCVTZS W14, D24
    FJCVTZS W2, D21
    FJCVTZS W10, D20
    BFCVT H15, S12
    FJCVTZS W17, D8
    FJCVTZS W5, D15
    BFCVT H6, S26
    BFCVT H15, S9
    FJCVTZS W12, D24
    FRINT64X S30, S6
    FRINT32X D26, D30
    FJCVTZS W17, D25
    BFCVT H12, S0
    FJCVTZS W26, D16
    FJCVTZS W10, D7
    FJCVTZS W27, D2
    FJCVTZS W24, D11
    FRINT64Z S2, S12
    BFCVT H14, S27
    BFCVT H21, S26
    FRINT64X D4, D14
    FRINT64Z D7, D15
    FRINT64Z S6, S10
    BFCVT H8, S21
    BFCVT H15, S8
    BFCVT H25, S6
    BFCVT H16, S20
    BFCVT H9, S22
    BFCVT H11, S7
    BFCVT H6, S25
    FRINT64X D24, D4
    BFCVT H13, S20
    BFCVT H12, S17
    FRINT32Z D12, D16
    BFCVT H10, S19
    FRINT32Z S17, S12
    FRINT64Z D22, D29
    FRINT32X S25, S10
    BFCVT H27, S22
    FRINT64Z S20, S17
    BFCVT H22, S24
    FRINT32Z S24, S9
    FRINT64Z S21, S22
    FRINT64Z S16, S22
    FRINT32X D10, D24
    BFCVT H12, S21
    FJCVTZS W6, D20
    FRINT64X S25, S25
    FRINT64Z D4, D6
    FJCVTZS W3, D27
    FJCVTZS W16, D26
    FRINT32X S7, S12
    BFCVT H14, S7
    FRINT64Z S19, S15
    FJCVTZS W9, D6
    BFCVT H21, S10
    BFCVT H29, S21
    FRINT32Z D24, D14
    FJCVTZS W8, D25
    FJCVTZS W11, D4
    BFCVT H21, S2
    FRINT32X D12, D10
    FJCVTZS W12, D29
    FJCVTZS W27, D30
    FRINT64X S7, S24
    FJCVTZS W10, D7
    BFCVT H26, S21
    FJCVTZS W10, D26
    FRINT64X S10, S23
    FJCVTZS W8, D24
    FJCVTZS W26, D29
    FRINT32X S21, S15
    FJCVTZS W2, D10
    FRINT64X D2, D19
    BFCVT H6, S2
    FJCVTZS W8, D12
    FRINT64Z D24, D6
    BFCVT H30, S31
    BFCVT H12, S31
    FRINT32Z D23, D18
    FJCVTZS W24, D17
    BFCVT H6, S4
    BFCVT H26, S15
    FRINT32Z D18, D9
    BFCVT H3, S22
    BFCVT H31, S11
    BFCVT H17, S12
    FRINT32X D12, D27
    FRINT32X S9, S6
    FRINT64Z S22, S9
    FRINT32Z D11, D23
    BFCVT H1, S19
    FRINT64X S19, S1
    FJCVTZS W11, D27
    BFCVT H21, S1
    BFCVT H15, S3
    FRINT64X S4, S17
    FRINT64Z D6, D12
    FRINT32X S27, S15
    BFCVT H15, S4
    FRINT64Z D13, D30
    FRINT32Z D3, D31
    FRINT32Z D31, D15
    BFCVT H25, S20
    FRINT64Z D18, D21
    FJCVTZS W17, D29
    FRINT32X S4, S19
    FJCVTZS W12, D13
    FRINT64Z S12, S4
    FJCVTZS W14, D14
    BFCVT H15, S20
    FRINT32X S1, S15
    BFCVT H17, S25
    FRINT64X S15, S17
    FJCVTZS W9, D31
    FRINT32Z S30, S18
    BFCVT H19, S3
    FRINT64X S13, S12
    BFCVT H12, S1
    BFCVT H3, S13
    BFCVT H0, S15
    FRINT64Z S25, S7
    BFCVT H31, S29
    FRINT64Z S18, S25
    BFCVT H4, S3
    FJCVTZS W7, D4
    FRINT64Z D23, D23
    BFCVT H7, S12
    FRINT32Z D12, D0
    BFCVT H3, S6
    FRINT64Z D17, D3
    BFCVT H29, S18
    BFCVT H13, S17
    BFCVT H17, S13
    BFCVT H21, S29
    FRINT32Z S1, S8
    FJCVTZS W17, D27
    FJCVTZS W14, D31
    BFCVT H0, S29
    FRINT64Z D3, D23
    BFCVT H4, S3
    BFCVT H29, S1
    FRINT64Z D13, D7
    BFCVT H6, S30
    FJCVTZS W17, D21
    FRINT64X D0, D31
    FRINT64X D23, D0
    BFCVT H2, S8
    BFCVT H25, S12
    BFCVT H26, S13
    BFCVT H17, S25
    FJCVTZS W27, D29
    FJCVTZS W16, D1
    BFCVT H18, S17
    FJCVTZS W24, D6
    SUBS  X4, X4, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_8
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X28, FPSR
    MOVZ  X13, #0x19, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D5
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D28
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X28, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X9
    FMOV  V1.D[1], X27
    FMOV  D2, X14
    FMOV  V2.D[1], X3
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X10
    FMOV  V4.D[1], X24
    FMOV  D5, X4
    FMOV  V5.D[1], X14
    FMOV  D6, X12
    FMOV  V6.D[1], X26
    FMOV  D7, X15
    FMOV  V7.D[1], X4
    FMOV  D8, X23
    FMOV  V8.D[1], X13
    FMOV  D9, X3
    FMOV  V9.D[1], X29
    FMOV  D10, X15
    FMOV  V10.D[1], X25
    FMOV  D11, X7
    FMOV  V11.D[1], X29
    FMOV  D12, X25
    FMOV  V12.D[1], X17
    FMOV  D13, X29
    FMOV  V13.D[1], X17
    FMOV  D14, X9
    FMOV  V14.D[1], X29
    FMOV  D15, X29
    FMOV  V15.D[1], X28
    FMOV  D16, X25
    FMOV  V16.D[1], X27
    FMOV  D17, X27
    FMOV  V17.D[1], X13
    FMOV  D18, X5
    FMOV  V18.D[1], X6
    FMOV  D19, X6
    FMOV  V19.D[1], X15
    FMOV  D20, X27
    FMOV  V20.D[1], X12
    FMOV  D21, X17
    FMOV  V21.D[1], X4
    FMOV  D22, X25
    FMOV  V22.D[1], X8
    FMOV  D23, X6
    FMOV  V23.D[1], X29
    FMOV  D24, X3
    FMOV  V24.D[1], X5
    FMOV  D25, X6
    FMOV  V25.D[1], X28
    FMOV  D26, X2
    FMOV  V26.D[1], X7
    FMOV  D27, X2
    FMOV  V27.D[1], X17
    FMOV  D28, X16
    FMOV  V28.D[1], X26
    FMOV  D29, X7
    FMOV  V29.D[1], X7
    FMOV  D30, X15
    FMOV  V30.D[1], X13
    FMOV  D31, X28
    FMOV  V31.D[1], X24
    MOVZ  X16, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_9:
    BFCVT H11, S29
    FJCVTZS W24, D22
    FRINT64Z S28, S7
    FJCVTZS W5, D25
    FRINT64Z S1, S11
    FRINT32Z D0, D2
    BFCVT H31, S21
    BFCVT H26, S1
    BFCVT H24, S23
    BFCVT H24, S26
    BFCVT H22, S0
    BFCVT H19, S27
    BFCVT H19, S30
    BFCVT H18, S24
    BFCVT H9, S22
    FJCVTZS W9, D19
    FJCVTZS W8, D3
    BFCVT H27, S18
    FJCVTZS W17, D15
    FRINT32Z D27, D15
    BFCVT H27, S31
    BFCVT H7, S27
    FJCVTZS W5, D17
    FJCVTZS W11, D12
    FJCVTZS W9, D7
    FJCVTZS W24, D9
    FJCVTZS W10, D25
    FRINT64Z S7, S28
    BFCVT H6, S28
    FRINT64X D22, D19
    BFCVT H25, S14
    FRINT32Z D9, D26
    BFCVT H19, S26
    BFCVT H20, S0
    FRINT32X D26, D2
    FRINT64Z S3, S5
    FRINT32X S11, S6
    FRINT32Z S18, S2
    FJCVTZS W5, D26
    FRINT64Z D24, D12
    BFCVT H31, S25
    BFCVT H17, S18
    BFCVT H6, S24
    FRINT64X S24, S31
    FRINT64X D12, D19
    FRINT64X D2, D7
    FJCVTZS W29, D6
    FJCVTZS W8, D19
    FJCVTZS W13, D24
    BFCVT H18, S2
    FJCVTZS W26, D3
    FRINT64Z S5, S4
    FRINT64Z D4, D18
    FJCVTZS W11, D11
    BFCVT H25, S5
    BFCVT H11, S25
    FJCVTZS W5, D4
    BFCVT H26, S9
    FJCVTZS W26, D12
    BFCVT H6, S17
    FRINT32Z S18, S6
    FRINT64Z S25, S19
    FRINT64X D6, D22
    BFCVT H9, S17
    FRINT64Z S7, S26
    FJCVTZS W6, D30
    FRINT32Z D30, D7
    FRINT32Z S3, S26
    FJCVTZS W26, D10
    FRINT32X S7, S1
    FRINT64Z S19, S9
    BFCVT H10, S18
    FJCVTZS W14, D7
    BFCVT H4, S22
    FRINT64Z D22, D9
    BFCVT H2, S7
    BFCVT H20, S6
    FRINT32Z S5, S4
    FJCVTZS W14, D2
    FJCVTZS W9, D10
    FRINT64Z S7, S29
    FRINT32Z S22, S20
    BFCVT H20, S7
    FRINT32Z S30, S20
    FJCVTZS W11, D5
    FRINT32Z S13, S21
    FRINT64Z D29, D30
    FRINT64X D10, D13
    FJCVTZS W13, D10
    FJCVTZS W17, D29
    FRINT64X S21, S30
    FRINT32Z D30, D3
    FRINT32X D18, D22
    FRINT64Z D29, D18
    FJCVTZS W6, D29
    FJCVTZS W15, D18
    FRINT32Z D5, D30
    FJCVTZS W9, D21
    FJCVTZS W15, D6
    FJCVTZS W6, D17
    BFCVT H5, S5
    FJCVTZS W29, D29
    FJCVTZS W11, D9
    FJCVTZS W29, D20
    BFCVT H18, S11
    FJCVTZS W23, D5
    BFCVT H23, S10
    FJCVTZS W29, D27
    FRINT64Z S11, S18
    FRINT32X D22, D25
    FJCVTZS W24, D16
    FRINT32Z S27, S6
    FRINT32Z S25, S15
    BFCVT H24, S20
    FRINT64Z D2, D26
    FRINT64X D16, D12
    BFCVT H20, S28
    BFCVT H10, S24
    FJCVTZS W27, D2
    BFCVT H6, S11
    BFCVT H11, S23
    FRINT32X D19, D16
    BFCVT H24, S6
    FJCVTZS W25, D25
    FRINT64X S21, S20
    BFCVT H12, S11
    FRINT64X S11, S31
    FJCVTZS W25, D1
    BFCVT H28, S21
    FRINT32X D15, D10
    BFCVT H5, S22
    FRINT32Z S21, S19
    FRINT64X S20, S28
    FRINT32Z D23, D20
    FJCVTZS W14, D12
    FRINT64X D9, D11
    FRINT64X S26, S5
    FJCVTZS W3, D15
    FJCVTZS W25, D20
    FJCVTZS W23, D27
    BFCVT H27, S21
    FJCVTZS W14, D24
    FRINT64X D28, D9
    FRINT64Z D14, D28
    FJCVTZS W7, D27
    BFCVT H9, S26
    FRINT32Z D24, D23
    FJCVTZS W17, D21
    BFCVT H11, S15
    FJCVTZS W26, D17
    FJCVTZS W26, D11
    FJCVTZS W17, D24
    FRINT64Z D23, D9
    BFCVT H28, S4
    BFCVT H12, S2
    FJCVTZS W29, D20
    FRINT32Z D27, D30
    BFCVT H20, S16
    FJCVTZS W24, D10
    FJCVTZS W26, D5
    FRINT32Z D17, D4
    FRINT64Z S24, S14
    FJCVTZS W15, D8
    BFCVT H11, S0
    BFCVT H15, S2
    FJCVTZS W10, D28
    FRINT64Z S8, S15
    FJCVTZS W29, D30
    FJCVTZS W8, D21
    FJCVTZS W23, D8
    FRINT32X S15, S12
    BFCVT H1, S17
    FJCVTZS W10, D15
    FRINT64Z D0, D1
    FRINT32X S8, S18
    BFCVT H26, S28
    BFCVT H8, S30
    FRINT32X S16, S13
    FRINT32Z S5, S24
    FJCVTZS W26, D8
    FJCVTZS W24, D11
    BFCVT H11, S24
    BFCVT H30, S26
    FJCVTZS W15, D9
    FJCVTZS W9, D16
    BFCVT H16, S7
    BFCVT H18, S23
    FJCVTZS W6, D22
    BFCVT H10, S16
    FJCVTZS W29, D11
    FRINT64X D16, D14
    BFCVT H9, S16
    FJCVTZS W29, D27
    FRINT32Z S11, S6
    FJCVTZS W26, D10
    BFCVT H7, S9
    BFCVT H17, S5
    FRINT32X S23, S11
    FRINT32X S6, S17
    BFCVT H14, S6
    SUBS  X16, X16, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X12, FPSR
    MOVZ  X28, #0x19, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D0
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D1
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D28
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D30
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D31
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X2, #0xa4c5, LSL #0
    MOVK  X2, #0xd749, LSL #16
    MOVK  X2, #0x351f, LSL #32
    MOVK  X2, #0x7a2b, LSL #48
    MOVZ  X3, #0xb1c0, LSL #0
    MOVK  X3, #0x4b5a, LSL #16
    MOVK  X3, #0x2a91, LSL #32
    MOVK  X3, #0x5e8a, LSL #48
    MOVZ  X4, #0xfe6e, LSL #0
    MOVK  X4, #0x9174, LSL #16
    MOVK  X4, #0x614, LSL #32
    MOVK  X4, #0x6c88, LSL #48
    MOVZ  X5, #0xd0b, LSL #0
    MOVK  X5, #0xd65f, LSL #16
    MOVK  X5, #0x8e0e, LSL #32
    MOVK  X5, #0x5b13, LSL #48
    MOVZ  X6, #0x2cde, LSL #0
    MOVK  X6, #0x6636, LSL #16
    MOVK  X6, #0xac87, LSL #32
    MOVK  X6, #0xfb03, LSL #48
    MOVZ  X7, #0x9fb, LSL #0
    MOVK  X7, #0xc68c, LSL #16
    MOVK  X7, #0x1742, LSL #32
    MOVK  X7, #0x671c, LSL #48
    MOVZ  X8, #0x17ab, LSL #0
    MOVK  X8, #0x91a5, LSL #16
    MOVK  X8, #0x7f8f, LSL #32
    MOVK  X8, #0x27f5, LSL #48
    MOVZ  X9, #0x721c, LSL #0
    MOVK  X9, #0x5b09, LSL #16
    MOVK  X9, #0x1117, LSL #32
    MOVK  X9, #0xd2d1, LSL #48
    MOVZ  X10, #0x3bbb, LSL #0
    MOVK  X10, #0x961b, LSL #16
    MOVK  X10, #0x8a2e, LSL #32
    MOVK  X10, #0xbd4b, LSL #48
    MOVZ  X11, #0xed71, LSL #0
    MOVK  X11, #0xc412, LSL #16
    MOVK  X11, #0xe73a, LSL #32
    MOVK  X11, #0x2706, LSL #48
    MOVZ  X12, #0xa40b, LSL #0
    MOVK  X12, #0xef1a, LSL #16
    MOVK  X12, #0x6473, LSL #32
    MOVK  X12, #0x8b71, LSL #48
    MOVZ  X13, #0xe270, LSL #0
    MOVK  X13, #0x494a, LSL #16
    MOVK  X13, #0x2fc2, LSL #32
    MOVK  X13, #0xf631, LSL #48
    MOVZ  X14, #0x5cc3, LSL #0
    MOVK  X14, #0xf2e3, LSL #16
    MOVK  X14, #0x5519, LSL #32
    MOVK  X14, #0xa161, LSL #48
    MOVZ  X15, #0x22bd, LSL #0
    MOVK  X15, #0x4424, LSL #16
    MOVK  X15, #0xb5e7, LSL #32
    MOVK  X15, #0xf1af, LSL #48
    MOVZ  X16, #0xab44, LSL #0
    MOVK  X16, #0xc34e, LSL #16
    MOVK  X16, #0x6b4a, LSL #32
    MOVK  X16, #0x8313, LSL #48
    MOVZ  X17, #0x6636, LSL #0
    MOVK  X17, #0x6649, LSL #16
    MOVK  X17, #0x425, LSL #32
    MOVK  X17, #0x36b7, LSL #48
    MOVZ  X23, #0xb922, LSL #0
    MOVK  X23, #0x1527, LSL #16
    MOVK  X23, #0x41e5, LSL #32
    MOVK  X23, #0x2ab5, LSL #48
    MOVZ  X24, #0xae86, LSL #0
    MOVK  X24, #0xf67c, LSL #16
    MOVK  X24, #0x563e, LSL #32
    MOVK  X24, #0x7de3, LSL #48
    MOVZ  X25, #0xafc4, LSL #0
    MOVK  X25, #0xc2c1, LSL #16
    MOVK  X25, #0x2b7a, LSL #32
    MOVK  X25, #0xdc16, LSL #48
    MOVZ  X26, #0x8959, LSL #0
    MOVK  X26, #0xc27c, LSL #16
    MOVK  X26, #0x36cc, LSL #32
    MOVK  X26, #0x834c, LSL #48
    MOVZ  X27, #0xc27f, LSL #0
    MOVK  X27, #0xbd0a, LSL #16
    MOVK  X27, #0x163e, LSL #32
    MOVK  X27, #0xc0a6, LSL #48
    MOVZ  X28, #0x9c22, LSL #0
    MOVK  X28, #0x4b47, LSL #16
    MOVK  X28, #0xb7c0, LSL #32
    MOVK  X28, #0x8790, LSL #48
    MOVZ  X29, #0x4e51, LSL #0
    MOVK  X29, #0x1dd1, LSL #16
    MOVK  X29, #0x8d52, LSL #32
    MOVK  X29, #0x4c39, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X9
    FMOV  D4, X7
    FMOV  V4.D[1], X25
    FMOV  D5, X16
    FMOV  V5.D[1], X29
    FMOV  D6, X13
    FMOV  V6.D[1], X11
    FMOV  D7, X2
    FMOV  V7.D[1], X24
    FMOV  D8, X11
    FMOV  V8.D[1], X25
    FMOV  D9, X16
    FMOV  V9.D[1], X17
    FMOV  D10, X13
    FMOV  V10.D[1], X8
    FMOV  D11, X14
    FMOV  V11.D[1], X29
    FMOV  D12, X17
    FMOV  V12.D[1], X26
    FMOV  D13, X10
    FMOV  V13.D[1], X4
    FMOV  D14, X9
    FMOV  V14.D[1], X12
    FMOV  D15, X2
    FMOV  V15.D[1], X11
    FMOV  D16, X17
    FMOV  V16.D[1], X7
    FMOV  D17, X13
    FMOV  V17.D[1], X16
    FMOV  D18, X2
    FMOV  V18.D[1], X28
    FMOV  D19, X3
    FMOV  V19.D[1], X27
    FMOV  D20, X15
    FMOV  V20.D[1], X6
    FMOV  D21, X12
    FMOV  V21.D[1], X26
    FMOV  D22, X4
    FMOV  V22.D[1], X4
    FMOV  D23, X5
    FMOV  V23.D[1], X24
    FMOV  D24, X6
    FMOV  V24.D[1], X26
    FMOV  D25, X3
    FMOV  V25.D[1], X17
    FMOV  D26, X26
    FMOV  V26.D[1], X3
    FMOV  D27, X23
    FMOV  V27.D[1], X23
    FMOV  D28, X25
    FMOV  V28.D[1], X13
    FMOV  D29, X13
    FMOV  V29.D[1], X8
    FMOV  D30, X13
    FMOV  V30.D[1], X2
    FMOV  D31, X28
    FMOV  V31.D[1], X17
    MOVZ  X24, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_10:
    FJCVTZS W5, D20
    FJCVTZS W3, D31
    BFCVT H8, S23
    FRINT64Z D31, D24
    BFCVT H29, S26
    FRINT32X D26, D29
    FRINT64Z S28, S27
    FJCVTZS W8, D5
    FRINT32Z D28, D21
    BFCVT H4, S14
    FJCVTZS W6, D22
    FRINT64X D2, D8
    FJCVTZS W23, D24
    FJCVTZS W2, D28
    FJCVTZS W8, D30
    FRINT64X S11, S4
    BFCVT H16, S25
    BFCVT H29, S16
    FJCVTZS W28, D2
    FRINT32X S23, S14
    FRINT64Z S14, S31
    FRINT64X S5, S26
    FRINT32Z S16, S23
    FRINT32Z S24, S14
    FJCVTZS W23, D16
    BFCVT H30, S29
    FRINT32X S21, S11
    FJCVTZS W14, D5
    FJCVTZS W15, D24
    FRINT64X D11, D30
    BFCVT H23, S14
    FRINT32Z S25, S18
    BFCVT H26, S19
    FRINT64Z S5, S30
    BFCVT H28, S27
    BFCVT H7, S31
    FJCVTZS W6, D2
    FJCVTZS W2, D26
    BFCVT H4, S25
    FRINT64Z D27, D14
    FJCVTZS W16, D15
    BFCVT H19, S6
    FJCVTZS W7, D19
    BFCVT H26, S21
    FRINT64X D25, D1
    FRINT64X S14, S4
    BFCVT H6, S24
    FRINT64Z S30, S28
    BFCVT H4, S11
    BFCVT H29, S6
    BFCVT H2, S14
    FRINT64Z D31, D26
    FRINT32Z D28, D23
    FJCVTZS W4, D19
    FRINT32X S14, S17
    FJCVTZS W13, D30
    FRINT32X S17, S31
    BFCVT H31, S25
    BFCVT H1, S7
    BFCVT H25, S19
    FRINT64Z D6, D4
    BFCVT H21, S29
    FRINT32X S6, S28
    FRINT32X S5, S17
    FJCVTZS W15, D10
    BFCVT H29, S21
    FRINT64Z D19, D25
    BFCVT H7, S2
    BFCVT H24, S2
    FRINT64Z S21, S16
    FRINT32X D17, D21
    FRINT32X D23, D15
    FJCVTZS W16, D17
    FRINT64Z D28, D6
    FRINT64Z D28, D21
    BFCVT H4, S19
    FRINT64Z D2, D2
    FJCVTZS W5, D7
    FRINT64X S3, S5
    FRINT64X D25, D18
    BFCVT H5, S16
    FJCVTZS W17, D23
    FRINT32X D6, D28
    FJCVTZS W23, D21
    BFCVT H3, S2
    FJCVTZS W23, D29
    FJCVTZS W25, D16
    BFCVT H15, S6
    FJCVTZS W8, D24
    FJCVTZS W13, D7
    BFCVT H16, S22
    FRINT32X D29, D3
    BFCVT H21, S5
    FJCVTZS W6, D15
    FRINT64Z S18, S28
    BFCVT H23, S25
    BFCVT H17, S21
    FRINT64X D19, D23
    FJCVTZS W8, D13
    FJCVTZS W8, D16
    FJCVTZS W23, D2
    FJCVTZS W2, D19
    FRINT32X D23, D4
    FRINT32X S26, S23
    BFCVT H4, S9
    BFCVT H15, S17
    FRINT64X S23, S12
    FJCVTZS W16, D15
    FRINT32X S15, S2
    FRINT64X D19, D27
    FJCVTZS W17, D1
    FJCVTZS W8, D6
    FJCVTZS W28, D23
    FRINT32Z D2, D4
    FRINT32Z S4, S1
    BFCVT H27, S2
    FJCVTZS W6, D15
    BFCVT H13, S19
    FRINT64Z D16, D26
    FJCVTZS W23, D13
    FJCVTZS W7, D16
    FJCVTZS W25, D27
    FRINT32X S17, S4
    BFCVT H23, S17
    FRINT32Z S17, S1
    FJCVTZS W28, D29
    BFCVT H4, S18
    FJCVTZS W12, D31
    FJCVTZS W23, D22
    FJCVTZS W23, D1
    FJCVTZS W27, D17
    BFCVT H27, S27
    BFCVT H19, S29
    BFCVT H16, S31
    FRINT64Z D1, D28
    FJCVTZS W8, D12
    FJCVTZS W5, D2
    FJCVTZS W28, D19
    FRINT32Z S26, S18
    FJCVTZS W10, D9
    FJCVTZS W7, D31
    FRINT64Z D28, D3
    FJCVTZS W14, D1
    BFCVT H9, S0
    FRINT64X S0, S6
    BFCVT H3, S7
    BFCVT H2, S3
    FJCVTZS W27, D31
    FJCVTZS W3, D28
    FRINT64Z S12, S16
    BFCVT H6, S27
    FJCVTZS W13, D12
    FRINT32X D7, D26
    FJCVTZS W14, D9
    FRINT64Z S26, S7
    FJCVTZS W25, D6
    BFCVT H29, S16
    FJCVTZS W16, D18
    FJCVTZS W27, D27
    FRINT64X S6, S28
    FJCVTZS W3, D29
    FJCVTZS W5, D6
    BFCVT H27, S0
    BFCVT H28, S26
    FJCVTZS W14, D27
    BFCVT H18, S27
    FJCVTZS W16, D18
    FJCVTZS W5, D10
    BFCVT H10, S28
    BFCVT H7, S15
    FRINT32Z S29, S16
    FJCVTZS W4, D26
    FRINT64Z D24, D3
    FJCVTZS W4, D30
    BFCVT H28, S20
    BFCVT H12, S25
    FJCVTZS W23, D16
    FRINT32Z D6, D7
    BFCVT H20, S20
    FJCVTZS W25, D19
    BFCVT H27, S30
    FRINT64Z S25, S28
    BFCVT H0, S20
    FJCVTZS W14, D26
    BFCVT H3, S25
    BFCVT H25, S5
    BFCVT H30, S19
    FJCVTZS W28, D12
    FRINT32Z S7, S7
    FJCVTZS W25, D20
    BFCVT H15, S0
    FJCVTZS W17, D29
    FRINT32Z S16, S2
    BFCVT H29, S30
    FJCVTZS W3, D29
    FRINT64Z D0, D7
    FRINT64Z D19, D10
    BFCVT H26, S3
    FJCVTZS W2, D25
    FJCVTZS W16, D24
    SUBS  X24, X24, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_10
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X26, #0x4e51, LSL #0
    MOVK  X26, #0x1dd1, LSL #16
    MOVK  X26, #0x8d52, LSL #32
    MOVK  X26, #0x4c39, LSL #48
    SUB  X11, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X26, FPSR
    MOVZ  X11, #0x19, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D0
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D1
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D11
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X11, #0xfe6e, LSL #0
    MOVK  X11, #0x9174, LSL #16
    MOVK  X11, #0x614, LSL #32
    MOVK  X11, #0x6c88, LSL #48
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D22
    MOVZ  X11, #0xfe6e, LSL #0
    MOVK  X11, #0x9174, LSL #16
    MOVK  X11, #0x614, LSL #32
    MOVK  X11, #0x6c88, LSL #48
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D30
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X26, D31
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X11
    FMOV  V0.D[1], X6
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X9
    FMOV  V2.D[1], X29
    FMOV  D3, X6
    FMOV  V3.D[1], X13
    FMOV  D4, X15
    FMOV  V4.D[1], X10
    FMOV  D5, X27
    FMOV  V5.D[1], X3
    FMOV  D6, X17
    FMOV  V6.D[1], X23
    FMOV  D7, X26
    FMOV  V7.D[1], X8
    FMOV  D8, X23
    FMOV  V8.D[1], X2
    FMOV  D9, X2
    FMOV  V9.D[1], X27
    FMOV  D10, X27
    FMOV  V10.D[1], X8
    FMOV  D11, X25
    FMOV  V11.D[1], X25
    FMOV  D12, X29
    FMOV  V12.D[1], X7
    FMOV  D13, X15
    FMOV  V13.D[1], X3
    FMOV  D14, X15
    FMOV  V14.D[1], X9
    FMOV  D15, X23
    FMOV  V15.D[1], X16
    FMOV  D16, X12
    FMOV  V16.D[1], X13
    FMOV  D17, X12
    FMOV  V17.D[1], X9
    FMOV  D18, X29
    FMOV  V18.D[1], X25
    FMOV  D19, X17
    FMOV  V19.D[1], X6
    FMOV  D20, X6
    FMOV  V20.D[1], X7
    FMOV  D21, X29
    FMOV  V21.D[1], X15
    FMOV  D22, X27
    FMOV  V22.D[1], X4
    FMOV  D23, X2
    FMOV  V23.D[1], X11
    FMOV  D24, X17
    FMOV  V24.D[1], X2
    FMOV  D25, X16
    FMOV  V25.D[1], X15
    FMOV  D26, X28
    FMOV  V26.D[1], X9
    FMOV  D27, X17
    FMOV  V27.D[1], X6
    FMOV  D28, X10
    FMOV  V28.D[1], X13
    FMOV  D29, X12
    FMOV  V29.D[1], X13
    FMOV  D30, X4
    FMOV  V30.D[1], X14
    FMOV  D31, X13
    FMOV  V31.D[1], X7
    MOVZ  X16, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_11:
    FRINT64Z D2, D26
    FRINT64X S8, S28
    FRINT64X S24, S24
    BFCVT H14, S1
    BFCVT H10, S3
    FRINT32X D0, D22
    FRINT32Z S4, S10
    BFCVT H5, S27
    FRINT64Z D20, D14
    BFCVT H28, S20
    FRINT64Z D11, D28
    FJCVTZS W29, D24
    FRINT32X S3, S31
    FRINT32X D5, D4
    FJCVTZS W25, D18
    FRINT32Z D31, D4
    FJCVTZS W12, D3
    BFCVT H1, S0
    FJCVTZS W14, D9
    BFCVT H6, S5
    FJCVTZS W11, D8
    FJCVTZS W10, D6
    FRINT32Z S22, S6
    FJCVTZS W9, D6
    BFCVT H23, S8
    FRINT32X S3, S11
    BFCVT H8, S3
    FRINT64Z D6, D31
    FRINT64Z S14, S17
    FJCVTZS W29, D31
    FJCVTZS W11, D1
    FRINT64Z S11, S23
    FJCVTZS W23, D22
    FJCVTZS W4, D21
    FJCVTZS W23, D6
    FJCVTZS W10, D11
    FRINT64Z S5, S3
    BFCVT H22, S31
    FJCVTZS W29, D8
    FJCVTZS W8, D5
    FJCVTZS W25, D14
    BFCVT H21, S14
    FJCVTZS W25, D3
    FJCVTZS W8, D22
    FJCVTZS W9, D16
    FRINT32X S11, S19
    FJCVTZS W12, D20
    FRINT64Z D0, D20
    BFCVT H6, S6
    FRINT64Z D22, D20
    FJCVTZS W11, D30
    FJCVTZS W12, D18
    FRINT32X S19, S7
    FRINT32X S5, S14
    BFCVT H18, S12
    BFCVT H14, S23
    FRINT64X S8, S11
    FJCVTZS W9, D0
    FRINT32X D3, D22
    BFCVT H23, S5
    FRINT32X D5, D27
    FRINT32Z D19, D19
    BFCVT H2, S18
    FRINT64Z D7, D23
    FRINT64X D12, D5
    FJCVTZS W8, D8
    BFCVT H2, S14
    FRINT64Z D14, D11
    FJCVTZS W8, D31
    FRINT32X D0, D3
    FRINT32Z S3, S2
    BFCVT H3, S0
    BFCVT H24, S12
    FJCVTZS W14, D24
    FJCVTZS W2, D1
    FJCVTZS W10, D14
    BFCVT H2, S7
    FRINT64Z S12, S19
    FJCVTZS W23, D2
    BFCVT H1, S24
    BFCVT H19, S28
    FRINT32X D7, D3
    FJCVTZS W24, D7
    FJCVTZS W14, D20
    FRINT64Z S20, S19
    BFCVT H24, S4
    BFCVT H19, S24
    FRINT64X S2, S31
    BFCVT H4, S30
    FJCVTZS W7, D19
    FRINT64X S8, S1
    BFCVT H26, S8
    BFCVT H2, S31
    FRINT64Z S16, S26
    FRINT64X S31, S28
    BFCVT H0, S12
    FRINT32Z S24, S17
    FRINT64Z D17, D31
    FRINT32Z D21, D20
    FRINT64Z D20, D4
    BFCVT H12, S2
    BFCVT H2, S16
    BFCVT H24, S20
    FRINT32X S20, S15
    FJCVTZS W11, D9
    FRINT32Z D8, D20
    FRINT64X D30, D17
    FRINT64Z S15, S8
    FRINT64X S20, S0
    BFCVT H8, S3
    FJCVTZS W4, D12
    FJCVTZS W23, D20
    BFCVT H24, S24
    BFCVT H4, S8
    FRINT32X D3, D4
    FJCVTZS W27, D3
    BFCVT H8, S22
    FRINT64X S3, S0
    FJCVTZS W11, D2
    BFCVT H2, S15
    BFCVT H31, S3
    FRINT64X D0, D24
    BFCVT H15, S1
    FJCVTZS W8, D13
    BFCVT H17, S31
    FJCVTZS W24, D15
    FRINT64X S13, S8
    BFCVT H8, S29
    BFCVT H8, S30
    FRINT64X D15, D8
    FJCVTZS W11, D15
    FJCVTZS W8, D13
    BFCVT H9, S17
    FRINT64Z S29, S9
    FJCVTZS W10, D0
    FRINT64Z D1, D8
    FJCVTZS W6, D27
    FJCVTZS W24, D2
    BFCVT H0, S26
    FJCVTZS W7, D10
    BFCVT H10, S5
    BFCVT H29, S0
    FJCVTZS W29, D10
    FRINT64Z S13, S8
    BFCVT H10, S29
    BFCVT H8, S13
    BFCVT H17, S10
    BFCVT H27, S17
    FRINT32X D3, D17
    BFCVT H29, S3
    FJCVTZS W9, D31
    BFCVT H13, S20
    FJCVTZS W10, D3
    FRINT64Z D1, D28
    FRINT64X D15, D25
    FRINT32Z D17, D18
    FRINT64X D20, D9
    FJCVTZS W10, D27
    FJCVTZS W23, D19
    BFCVT H0, S15
    BFCVT H18, S8
    FRINT64X S3, S17
    FJCVTZS W29, D18
    FJCVTZS W23, D21
    FJCVTZS W14, D0
    FRINT64Z D21, D29
    FJCVTZS W28, D20
    FRINT32X D31, D3
    FJCVTZS W2, D13
    FRINT32X S20, S1
    FRINT64Z D8, D16
    FJCVTZS W27, D21
    FRINT32Z D10, D31
    FRINT64Z D25, D0
    FJCVTZS W7, D22
    FRINT32Z S17, S8
    FJCVTZS W10, D20
    FRINT64X S8, S17
    BFCVT H28, S8
    FJCVTZS W28, D10
    FRINT64Z D22, D28
    FJCVTZS W26, D21
    FJCVTZS W26, D3
    FRINT32Z D12, D8
    BFCVT H28, S17
    FJCVTZS W25, D26
    BFCVT H16, S6
    FRINT32X D10, D0
    FRINT64Z S31, S16
    FJCVTZS W8, D15
    BFCVT H17, S8
    FRINT32Z S8, S17
    FRINT64X D29, D16
    FJCVTZS W17, D31
    FRINT32X D13, D1
    FJCVTZS W14, D13
    BFCVT H26, S23
    FJCVTZS W15, D13
    BFCVT H16, S24
    FJCVTZS W6, D28
    SUBS  X16, X16, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_11
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X3, FPSR
    MOVZ  X5, #0x19, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D0
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D1
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D5
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D9
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D29
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D30
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X3, D31
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X25
    FMOV  D3, X17
    FMOV  V3.D[1], X26
    FMOV  D4, X23
    FMOV  V4.D[1], X14
    FMOV  D5, X15
    FMOV  V5.D[1], X13
    FMOV  D6, X27
    FMOV  V6.D[1], X28
    FMOV  D7, X4
    FMOV  V7.D[1], X9
    FMOV  D8, X25
    FMOV  V8.D[1], X25
    FMOV  D9, X26
    FMOV  V9.D[1], X26
    FMOV  D10, X27
    FMOV  V10.D[1], X14
    FMOV  D11, X29
    FMOV  V11.D[1], X25
    FMOV  D12, X28
    FMOV  V12.D[1], X28
    FMOV  D13, X8
    FMOV  V13.D[1], X29
    FMOV  D14, X7
    FMOV  V14.D[1], X25
    FMOV  D15, X16
    FMOV  V15.D[1], X27
    FMOV  D16, X2
    FMOV  V16.D[1], X8
    FMOV  D17, X11
    FMOV  V17.D[1], X26
    FMOV  D18, X17
    FMOV  V18.D[1], X4
    FMOV  D19, X6
    FMOV  V19.D[1], X6
    FMOV  D20, X3
    FMOV  V20.D[1], X28
    FMOV  D21, X17
    FMOV  V21.D[1], X7
    FMOV  D22, X25
    FMOV  V22.D[1], X28
    FMOV  D23, X28
    FMOV  V23.D[1], X3
    FMOV  D24, X23
    FMOV  V24.D[1], X25
    FMOV  D25, X26
    FMOV  V25.D[1], X17
    FMOV  D26, X7
    FMOV  V26.D[1], X24
    FMOV  D27, X9
    FMOV  V27.D[1], X4
    FMOV  D28, X5
    FMOV  V28.D[1], X12
    FMOV  D29, X25
    FMOV  V29.D[1], X4
    FMOV  D30, X3
    FMOV  V30.D[1], X8
    FMOV  D31, X13
    FMOV  V31.D[1], X16
    MOVZ  X8, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_12:
    BFCVT H18, S22
    FJCVTZS W5, D12
    FRINT64X D9, D31
    BFCVT H15, S27
    BFCVT H21, S18
    FRINT32X S2, S15
    FRINT64X D5, D30
    FJCVTZS W13, D26
    BFCVT H28, S28
    FJCVTZS W9, D9
    FJCVTZS W25, D4
    FRINT32Z S14, S28
    FRINT32Z D16, D30
    BFCVT H18, S14
    BFCVT H23, S21
    FJCVTZS W16, D2
    BFCVT H21, S5
    FJCVTZS W11, D21
    FRINT64X S6, S16
    FRINT64X D30, D23
    FRINT64Z S14, S6
    BFCVT H5, S13
    FRINT64Z S15, S30
    FJCVTZS W10, D5
    BFCVT H27, S26
    FJCVTZS W15, D15
    BFCVT H16, S14
    FRINT32X S15, S8
    FRINT32X S23, S18
    FRINT32Z D18, D8
    FJCVTZS W10, D18
    FJCVTZS W13, D23
    FRINT32Z D26, D29
    FRINT32X S14, S27
    FRINT32X S21, S16
    FJCVTZS W13, D14
    BFCVT H9, S26
    BFCVT H6, S24
    FJCVTZS W29, D6
    FJCVTZS W4, D12
    FJCVTZS W5, D21
    FRINT32X S30, S9
    FRINT32X D21, D24
    BFCVT H9, S10
    FRINT32Z D27, D8
    BFCVT H4, S26
    FJCVTZS W28, D11
    FJCVTZS W10, D29
    BFCVT H23, S24
    FJCVTZS W15, D16
    FJCVTZS W17, D7
    FRINT64Z D11, D29
    FRINT64X D24, D27
    FJCVTZS W23, D28
    FJCVTZS W11, D31
    FJCVTZS W28, D2
    BFCVT H29, S23
    FJCVTZS W23, D25
    FJCVTZS W25, D31
    FRINT32Z D28, D10
    BFCVT H27, S16
    FRINT32X S6, S31
    BFCVT H13, S29
    BFCVT H10, S27
    FJCVTZS W25, D7
    FJCVTZS W10, D24
    BFCVT H16, S6
    BFCVT H2, S16
    BFCVT H27, S10
    BFCVT H10, S27
    BFCVT H29, S3
    FJCVTZS W11, D29
    FJCVTZS W23, D11
    FJCVTZS W15, D2
    FJCVTZS W29, D21
    FJCVTZS W10, D10
    FRINT64Z S16, S28
    BFCVT H21, S13
    FRINT64Z D7, D23
    FJCVTZS W9, D8
    BFCVT H31, S4
    FJCVTZS W6, D29
    FRINT64X S4, S21
    FJCVTZS W10, D5
    FJCVTZS W6, D6
    FJCVTZS W28, D29
    FJCVTZS W7, D14
    BFCVT H24, S14
    BFCVT H5, S5
    FRINT64Z D21, D17
    FRINT32Z S13, S30
    BFCVT H14, S14
    BFCVT H28, S31
    FRINT64X S30, S10
    FJCVTZS W16, D7
    FJCVTZS W10, D26
    FRINT32Z S6, S5
    FRINT32X S8, S14
    FRINT64Z S2, S31
    BFCVT H29, S24
    BFCVT H14, S8
    BFCVT H14, S14
    BFCVT H4, S16
    FRINT64Z D7, D2
    FRINT64Z D17, D30
    BFCVT H31, S29
    FJCVTZS W4, D21
    FRINT64X D31, D4
    BFCVT H21, S28
    FJCVTZS W6, D28
    FJCVTZS W28, D31
    BFCVT H4, S21
    FRINT32Z S30, S17
    FRINT32Z S27, S4
    BFCVT H8, S14
    FJCVTZS W23, D27
    FRINT64X D24, D7
    BFCVT H2, S30
    FRINT64Z D17, D27
    BFCVT H29, S12
    FJCVTZS W10, D8
    FJCVTZS W10, D24
    BFCVT H16, S12
    FJCVTZS W28, D2
    FJCVTZS W10, D29
    FJCVTZS W15, D17
    FJCVTZS W23, D6
    BFCVT H27, S31
    FJCVTZS W16, D25
    BFCVT H30, S17
    FRINT64X S31, S22
    FJCVTZS W4, D21
    BFCVT H15, S1
    FJCVTZS W14, D27
    FJCVTZS W7, D11
    FRINT64Z D4, D19
    FJCVTZS W25, D2
    FRINT32Z D14, D23
    FRINT64Z S21, S16
    FRINT32Z D27, D11
    FJCVTZS W16, D14
    FJCVTZS W15, D9
    FRINT32X S19, S2
    BFCVT H6, S5
    FRINT32X S2, S3
    FRINT64Z D14, D8
    FRINT32Z D5, D16
    FJCVTZS W29, D30
    FRINT32Z D11, D11
    BFCVT H22, S2
    FRINT32X S3, S27
    BFCVT H20, S4
    BFCVT H12, S22
    FJCVTZS W29, D11
    FRINT32Z S1, S14
    BFCVT H2, S21
    FJCVTZS W5, D1
    FRINT64X D30, D24
    FRINT64X S22, S11
    BFCVT H24, S2
    FRINT64Z D15, D31
    FRINT64X D27, D27
    BFCVT H2, S13
    FJCVTZS W13, D30
    FRINT32Z D1, D25
    BFCVT H16, S2
    FRINT64X S21, S7
    FRINT32X D13, D20
    BFCVT H28, S19
    BFCVT H25, S6
    BFCVT H31, S13
    BFCVT H30, S26
    FJCVTZS W23, D22
    BFCVT H20, S24
    FRINT32X D6, D3
    FJCVTZS W17, D28
    FJCVTZS W28, D1
    FRINT32X D9, D6
    FRINT64X S13, S16
    FJCVTZS W29, D15
    FRINT32X D16, D13
    BFCVT H14, S6
    FRINT32X D15, D31
    FRINT32Z D26, D1
    BFCVT H23, S25
    FJCVTZS W11, D16
    FRINT64X D22, D16
    BFCVT H31, S21
    FRINT32Z D25, D9
    FRINT64X D9, D22
    FRINT32Z S18, S20
    FRINT64X S20, S30
    FJCVTZS W25, D21
    FRINT32X D22, D28
    FRINT32Z S16, S31
    BFCVT H31, S25
    FRINT32Z D1, D14
    FJCVTZS W24, D1
    FRINT64X S1, S31
    FRINT32X D6, D20
    SUBS  X8, X8, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_12
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X12, FPSR
    MOVZ  X3, #0x19, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D0
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D30
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X12, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X16
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X27
    FMOV  V4.D[1], X3
    FMOV  D5, X13
    FMOV  V5.D[1], X3
    FMOV  D6, X7
    FMOV  V6.D[1], X7
    FMOV  D7, X9
    FMOV  V7.D[1], X11
    FMOV  D8, X15
    FMOV  V8.D[1], X7
    FMOV  D9, X24
    FMOV  V9.D[1], X4
    FMOV  D10, X17
    FMOV  V10.D[1], X8
    FMOV  D11, X28
    FMOV  V11.D[1], X8
    FMOV  D12, X4
    FMOV  V12.D[1], X5
    FMOV  D13, X9
    FMOV  V13.D[1], X24
    FMOV  D14, X15
    FMOV  V14.D[1], X3
    FMOV  D15, X23
    FMOV  V15.D[1], X26
    FMOV  D16, X23
    FMOV  V16.D[1], X24
    FMOV  D17, X15
    FMOV  V17.D[1], X3
    FMOV  D18, X29
    FMOV  V18.D[1], X9
    FMOV  D19, X26
    FMOV  V19.D[1], X16
    FMOV  D20, X10
    FMOV  V20.D[1], X2
    FMOV  D21, X2
    FMOV  V21.D[1], X3
    FMOV  D22, X29
    FMOV  V22.D[1], X16
    FMOV  D23, X13
    FMOV  V23.D[1], X6
    FMOV  D24, X6
    FMOV  V24.D[1], X16
    FMOV  D25, X11
    FMOV  V25.D[1], X17
    FMOV  D26, X17
    FMOV  V26.D[1], X3
    FMOV  D27, X12
    FMOV  V27.D[1], X17
    FMOV  D28, X11
    FMOV  V28.D[1], X25
    FMOV  D29, X3
    FMOV  V29.D[1], X26
    FMOV  D30, X2
    FMOV  V30.D[1], X10
    FMOV  D31, X13
    FMOV  V31.D[1], X12
    MOVZ  X26, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_13:
    FRINT64X S3, S27
    BFCVT H2, S23
    FJCVTZS W12, D30
    FRINT64Z D13, D3
    FJCVTZS W3, D31
    BFCVT H30, S2
    BFCVT H17, S9
    FRINT64Z D10, D21
    FRINT64Z S17, S26
    BFCVT H22, S13
    FRINT64Z D19, D29
    BFCVT H20, S19
    BFCVT H30, S30
    FJCVTZS W27, D25
    BFCVT H17, S30
    FRINT32X D12, D10
    FJCVTZS W7, D17
    FRINT64X S19, S12
    FJCVTZS W10, D12
    BFCVT H17, S7
    BFCVT H31, S12
    BFCVT H3, S22
    BFCVT H22, S28
    BFCVT H10, S22
    FJCVTZS W11, D21
    FRINT64Z S5, S26
    BFCVT H7, S19
    FJCVTZS W6, D31
    FJCVTZS W9, D28
    BFCVT H29, S7
    FJCVTZS W6, D11
    BFCVT H11, S21
    FJCVTZS W24, D13
    FRINT64Z S13, S17
    BFCVT H30, S3
    FRINT32X S4, S20
    BFCVT H31, S4
    FJCVTZS W25, D29
    FRINT32X S17, S24
    BFCVT H29, S20
    BFCVT H24, S13
    FRINT32Z S7, S10
    BFCVT H19, S29
    BFCVT H22, S24
    FRINT32Z D10, D7
    BFCVT H19, S29
    FJCVTZS W5, D19
    BFCVT H7, S5
    BFCVT H29, S2
    FRINT32X S3, S11
    FRINT32X S11, S30
    FJCVTZS W27, D22
    BFCVT H30, S10
    FRINT64X S24, S22
    FRINT64X D26, D15
    FRINT64Z D25, D20
    FRINT32X S5, S4
    FJCVTZS W5, D24
    BFCVT H20, S5
    FRINT64X S4, S20
    FJCVTZS W9, D30
    BFCVT H24, S11
    BFCVT H13, S11
    BFCVT H14, S25
    FRINT32Z D15, D29
    FRINT64Z D10, D24
    FJCVTZS W17, D14
    FJCVTZS W9, D26
    BFCVT H29, S7
    FRINT32Z D9, D15
    FJCVTZS W9, D4
    FJCVTZS W15, D16
    BFCVT H24, S10
    BFCVT H16, S29
    FJCVTZS W27, D2
    FJCVTZS W10, D7
    FJCVTZS W24, D2
    FRINT64Z D5, D16
    FJCVTZS W15, D21
    BFCVT H25, S13
    FJCVTZS W25, D5
    BFCVT H5, S9
    FRINT32Z D11, D17
    BFCVT H2, S17
    FJCVTZS W12, D7
    FRINT32X D20, D5
    FJCVTZS W11, D24
    BFCVT H26, S21
    FJCVTZS W4, D25
    FRINT32X S21, S2
    FJCVTZS W14, D20
    FRINT64Z S8, S21
    FJCVTZS W4, D31
    FJCVTZS W28, D11
    FJCVTZS W11, D22
    BFCVT H21, S8
    FRINT64X S22, S4
    BFCVT H8, S6
    FRINT32X S5, S9
    BFCVT H7, S11
    BFCVT H10, S4
    BFCVT H19, S16
    BFCVT H26, S6
    BFCVT H2, S29
    FJCVTZS W11, D26
    FRINT64X D29, D2
    BFCVT H31, S25
    FRINT64X S24, S10
    FJCVTZS W8, D31
    FRINT32Z D9, D21
    FRINT32Z S11, S22
    BFCVT H6, S31
    BFCVT H16, S8
    FJCVTZS W15, D11
    FRINT64Z S10, S5
    FJCVTZS W8, D2
    BFCVT H4, S19
    FJCVTZS W5, D6
    FJCVTZS W28, D16
    FRINT64X S22, S4
    FRINT64Z S19, S29
    FJCVTZS W25, D10
    FRINT64Z D12, D24
    FRINT32X S25, S0
    BFCVT H1, S4
    FRINT64Z D11, D7
    FRINT64X S0, S11
    FJCVTZS W13, D0
    FRINT32X S24, S13
    BFCVT H26, S11
    BFCVT H2, S26
    FRINT32Z D0, D18
    BFCVT H5, S12
    BFCVT H7, S9
    FRINT32Z S6, S19
    FRINT64Z S16, S6
    BFCVT H19, S8
    FRINT32Z D29, D25
    FRINT32X D31, D22
    FRINT32X D10, D24
    FJCVTZS W6, D18
    FRINT32X D4, D5
    FRINT64X D24, D19
    BFCVT H9, S24
    FJCVTZS W11, D21
    FRINT32Z S31, S14
    FRINT64Z S5, S1
    BFCVT H7, S22
    FRINT32Z D14, D18
    BFCVT H22, S25
    FJCVTZS W12, D5
    FRINT64X S6, S9
    FJCVTZS W8, D0
    FRINT32X D9, D18
    FJCVTZS W14, D31
    BFCVT H5, S29
    FJCVTZS W27, D19
    FJCVTZS W2, D9
    BFCVT H24, S13
    FJCVTZS W5, D8
    BFCVT H25, S16
    BFCVT H13, S14
    FRINT32Z D18, D4
    FJCVTZS W7, D5
    FRINT64X D21, D18
    FJCVTZS W24, D10
    FJCVTZS W3, D13
    FRINT32Z D14, D25
    BFCVT H9, S24
    FRINT64Z D19, D6
    FJCVTZS W14, D22
    FJCVTZS W25, D11
    FJCVTZS W13, D21
    FJCVTZS W15, D18
    FRINT32X S11, S7
    FJCVTZS W28, D19
    FJCVTZS W13, D6
    FRINT32X D8, D9
    FJCVTZS W15, D11
    BFCVT H25, S6
    BFCVT H16, S1
    BFCVT H4, S3
    BFCVT H11, S21
    FJCVTZS W24, D24
    FJCVTZS W7, D14
    BFCVT H13, S16
    FRINT32Z D19, D13
    BFCVT H24, S21
    FRINT64Z D13, D28
    FRINT64Z S16, S11
    FJCVTZS W14, D8
    FJCVTZS W9, D19
    FRINT64Z S3, S23
    FRINT64Z D18, D11
    BFCVT H22, S25
    FRINT32X D19, D4
    BFCVT H14, S3
    FJCVTZS W12, D1
    BFCVT H3, S14
    FJCVTZS W7, D13
    SUBS  X26, X26, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_13
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X16, FPSR
    MOVZ  X23, #0x19, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D0
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D1
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D9
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D11
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D13
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc3e0, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D14
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D20
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D23
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D27
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D28
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D30
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X16, D31
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTFloatBF16JscvtFrintts_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X9
    FMOV  D2, X11
    FMOV  V2.D[1], X27
    FMOV  D3, X29
    FMOV  V3.D[1], X13
    FMOV  D4, X23
    FMOV  V4.D[1], X24
    FMOV  D5, X2
    FMOV  V5.D[1], X11
    FMOV  D6, X7
    FMOV  V6.D[1], X3
    FMOV  D7, X16
    FMOV  V7.D[1], X9
    FMOV  D8, X9
    FMOV  V8.D[1], X29
    FMOV  D9, X23
    FMOV  V9.D[1], X17
    FMOV  D10, X4
    FMOV  V10.D[1], X5
    FMOV  D11, X25
    FMOV  V11.D[1], X16
    FMOV  D12, X8
    FMOV  V12.D[1], X16
    FMOV  D13, X12
    FMOV  V13.D[1], X25
    FMOV  D14, X8
    FMOV  V14.D[1], X23
    FMOV  D15, X27
    FMOV  V15.D[1], X6
    FMOV  D16, X6
    FMOV  V16.D[1], X6
    FMOV  D17, X6
    FMOV  V17.D[1], X28
    FMOV  D18, X12
    FMOV  V18.D[1], X27
    FMOV  D19, X28
    FMOV  V19.D[1], X13
    FMOV  D20, X28
    FMOV  V20.D[1], X2
    FMOV  D21, X2
    FMOV  V21.D[1], X9
    FMOV  D22, X7
    FMOV  V22.D[1], X23
    FMOV  D23, X23
    FMOV  V23.D[1], X27
    FMOV  D24, X14
    FMOV  V24.D[1], X28
    FMOV  D25, X15
    FMOV  V25.D[1], X29
    FMOV  D26, X16
    FMOV  V26.D[1], X6
    FMOV  D27, X13
    FMOV  V27.D[1], X8
    FMOV  D28, X10
    FMOV  V28.D[1], X24
    FMOV  D29, X5
    FMOV  V29.D[1], X29
    FMOV  D30, X9
    FMOV  V30.D[1], X8
    FMOV  D31, X26
    FMOV  V31.D[1], X7
    MOVZ  X28, #0xa, LSL #0
LCRTFloatBF16JscvtFrintts_label_14:
    FJCVTZS W7, D27
    FJCVTZS W4, D24
    FRINT32X D18, D23
    FJCVTZS W24, D8
    BFCVT H1, S20
    FJCVTZS W2, D31
    FRINT64X S27, S27
    BFCVT H23, S20
    BFCVT H12, S27
    FJCVTZS W23, D30
    FRINT32X D23, D29
    FRINT64X D5, D25
    BFCVT H1, S5
    FJCVTZS W9, D1
    FRINT32Z S26, S11
    BFCVT H18, S12
    BFCVT H0, S9
    FRINT32X S29, S28
    BFCVT H5, S26
    FJCVTZS W17, D0
    BFCVT H19, S23
    FJCVTZS W12, D4
    FJCVTZS W16, D18
    BFCVT H8, S5
    FJCVTZS W24, D29
    FJCVTZS W8, D23
    FRINT64X S31, S19
    FRINT64X S19, S9
    BFCVT H27, S6
    FRINT32Z S9, S30
    FJCVTZS W12, D24
    FRINT32X D20, D26
    BFCVT H29, S27
    FJCVTZS W17, D7
    FRINT64Z D24, D21
    FJCVTZS W14, D18
    BFCVT H4, S13
    FJCVTZS W23, D30
    FJCVTZS W24, D19
    BFCVT H19, S25
    FRINT32X S7, S31
    FRINT32X S5, S13
    BFCVT H18, S5
    FJCVTZS W7, D19
    BFCVT H31, S9
    FRINT64X S13, S6
    FJCVTZS W9, D8
    FRINT32Z D8, D31
    FJCVTZS W26, D25
    FJCVTZS W2, D16
    FJCVTZS W24, D18
    FJCVTZS W16, D25
    BFCVT H11, S24
    BFCVT H18, S8
    FRINT64X D19, D13
    FJCVTZS W16, D11
    FJCVTZS W26, D7
    BFCVT H24, S18
    BFCVT H11, S29
    FRINT32Z S18, S9
    FJCVTZS W16, D3
    FJCVTZS W29, D18
    FJCVTZS W29, D6
    FJCVTZS W12, D11
    FRINT32Z D6, D4
    BFCVT H21, S31
    BFCVT H7, S6
    FRINT64Z S25, S3
    BFCVT H29, S22
    FRINT32X S5, S19
    BFCVT H13, S4
    FRINT32X S16, S25
    FRINT64X D18, D24
    BFCVT H4, S18
    FJCVTZS W26, D21
    FJCVTZS W8, D8
    BFCVT H6, S5
    BFCVT H21, S7
    FRINT64X D31, D12
    FJCVTZS W10, D31
    BFCVT H8, S13
    FJCVTZS W8, D8
    BFCVT H5, S6
    FRINT32X D31, D5
    FRINT32X S13, S6
    BFCVT H11, S24
    FRINT32X S8, S16
    FJCVTZS W13, D11
    FJCVTZS W12, D21
    BFCVT H11, S31
    BFCVT H1, S29
    BFCVT H7, S1
    FJCVTZS W27, D4
    FJCVTZS W9, D13
    BFCVT H3, S7
    BFCVT H16, S8
    BFCVT H7, S16
    BFCVT H31, S11
    FJCVTZS W17, D31
    FRINT32Z D8, D3
    FJCVTZS W25, D27
    FJCVTZS W27, D5
    FJCVTZS W10, D7
    BFCVT H8, S11
    FRINT32X D21, D10
    FRINT64Z S1, S11
    BFCVT H5, S24
    BFCVT H6, S11
    FRINT32X S13, S22
    BFCVT H24, S29
    FRINT32Z D7, D31
    FJCVTZS W4, D7
    FJCVTZS W15, D0
    BFCVT H7, S9
    BFCVT H29, S12
    BFCVT H0, S0
    BFCVT H10, S29
    BFCVT H4, S24
    BFCVT H16, S28
    FJCVTZS W4, D11
    BFCVT H3, S16
    FRINT64Z S10, S13
    BFCVT H11, S8
    FJCVTZS W12, D7
    BFCVT H22, S6
    FRINT64X S9, S5
    BFCVT H26, S11
    FJCVTZS W7, D10
    BFCVT H7, S4
    FRINT64Z S16, S15
    BFCVT H4, S9
    FRINT64X S8, S1
    BFCVT H13, S8
    FJCVTZS W12, D31
    FRINT32X S8, S16
    BFCVT H5, S0
    BFCVT H16, S11
    BFCVT H26, S8
    BFCVT H26, S1
    BFCVT H21, S24
    BFCVT H0, S3
    FJCVTZS W23, D4
    FRINT32Z D31, D7
    FRINT64Z S11, S16
    FJCVTZS W13, D20
    FRINT64X S10, S11
    FJCVTZS W10, D9
    FRINT64X D15, D5
    FRINT64Z D20, D26
    BFCVT H9, S31
    FRINT64Z D8, D20
    FRINT32X S11, S8
    FRINT64Z D4, D22
    FRINT64Z D31, D3
    FRINT64X D5, D10
    BFCVT H7, S19
    FJCVTZS W14, D0
    BFCVT H26, S4
    FRINT64X D1, D5
    FJCVTZS W12, D13
    FRINT64X S21, S23
    FJCVTZS W23, D9
    FJCVTZS W2, D7
    BFCVT H19, S20
    FRINT32Z S23, S19
    FJCVTZS W10, D1
    FRINT64Z S4, S3
    FRINT64X D0, D26
    BFCVT H1, S23
    BFCVT H31, S27
    BFCVT H23, S11
    FRINT64X D11, D1
    FJCVTZS W26, D21
    FJCVTZS W16, D31
    FRINT64Z D15, D8
    BFCVT H5, S4
    BFCVT H7, S30
    FRINT32Z D1, D12
    FJCVTZS W23, D23
    FJCVTZS W25, D14
    BFCVT H22, S15
    BFCVT H4, S4
    FRINT64X S31, S0
    FRINT64Z D19, D12
    FJCVTZS W8, D31
    BFCVT H0, S1
    BFCVT H26, S4
    BFCVT H14, S17
    FJCVTZS W13, D0
    BFCVT H0, S26
    BFCVT H3, S19
    FJCVTZS W7, D20
    FJCVTZS W26, D5
    FRINT32X D1, D3
    FRINT32X S17, S1
    FJCVTZS W7, D24
    BFCVT H27, S7
    FRINT32Z S19, S7
    BFCVT H12, S14
    BFCVT H15, S19
    SUBS  X28, X28, #0x1
    B.NE  LCRTFloatBF16JscvtFrintts_label_14
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X3, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTFloatBF16JscvtFrintts_TestFail
    MRS  X11, FPSR
    MOVZ  X3, #0x19, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D2
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D7
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D28
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D30
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail
    FMOV  X11, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTFloatBF16JscvtFrintts_TestFail

LCRTFloatBF16JscvtFrintts_TestEnd:
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
LCRTFloatBF16JscvtFrintts_TestFail:
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
