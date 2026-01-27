.global EnhanceFloatP01

.text
.p2align 4

EnhanceFloatP01:

EnhanceFloatP01_TestBegin:
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
    MOVZ  X2, #0x3905, LSL #0
    MOVK  X2, #0xfd5e, LSL #16
    MOVK  X2, #0xdabc, LSL #32
    MOVK  X2, #0xed9e, LSL #48
    MOVZ  X3, #0x78e1, LSL #0
    MOVK  X3, #0x8515, LSL #16
    MOVK  X3, #0x2408, LSL #32
    MOVK  X3, #0x642e, LSL #48
    MOVZ  X4, #0xcca8, LSL #0
    MOVK  X4, #0xdfe4, LSL #16
    MOVK  X4, #0xdf97, LSL #32
    MOVK  X4, #0x531b, LSL #48
    MOVZ  X5, #0x1438, LSL #0
    MOVK  X5, #0x8fa3, LSL #16
    MOVK  X5, #0xc015, LSL #32
    MOVK  X5, #0xfb4, LSL #48
    MOVZ  X6, #0xe443, LSL #0
    MOVK  X6, #0x5f3b, LSL #16
    MOVK  X6, #0x2e93, LSL #32
    MOVK  X6, #0xb361, LSL #48
    MOVZ  X7, #0xacde, LSL #0
    MOVK  X7, #0x4bb1, LSL #16
    MOVK  X7, #0xdb80, LSL #32
    MOVK  X7, #0x3d56, LSL #48
    MOVZ  X8, #0x93bf, LSL #0
    MOVK  X8, #0xbf2a, LSL #16
    MOVK  X8, #0xab8c, LSL #32
    MOVK  X8, #0x4ef8, LSL #48
    MOVZ  X9, #0xdf75, LSL #0
    MOVK  X9, #0xefea, LSL #16
    MOVK  X9, #0xaa27, LSL #32
    MOVK  X9, #0xedb2, LSL #48
    MOVZ  X10, #0x2fa, LSL #0
    MOVK  X10, #0x4f10, LSL #16
    MOVK  X10, #0x5225, LSL #32
    MOVK  X10, #0xefaa, LSL #48
    MOVZ  X11, #0xd8fb, LSL #0
    MOVK  X11, #0xd10f, LSL #16
    MOVK  X11, #0xfd8a, LSL #32
    MOVK  X11, #0x381b, LSL #48
    MOVZ  X12, #0x3991, LSL #0
    MOVK  X12, #0xe665, LSL #16
    MOVK  X12, #0xc798, LSL #32
    MOVK  X12, #0x994b, LSL #48
    MOVZ  X13, #0x51f2, LSL #0
    MOVK  X13, #0xea8c, LSL #16
    MOVK  X13, #0x51b9, LSL #32
    MOVK  X13, #0x9766, LSL #48
    MOVZ  X14, #0x6c5d, LSL #0
    MOVK  X14, #0xbac6, LSL #16
    MOVK  X14, #0x7ba2, LSL #32
    MOVK  X14, #0x1120, LSL #48
    MOVZ  X15, #0xd10, LSL #0
    MOVK  X15, #0xdd61, LSL #16
    MOVK  X15, #0x438d, LSL #32
    MOVK  X15, #0xa7ee, LSL #48
    MOVZ  X16, #0x7994, LSL #0
    MOVK  X16, #0x6fd1, LSL #16
    MOVK  X16, #0xc7b9, LSL #32
    MOVK  X16, #0x88ca, LSL #48
    MOVZ  X17, #0xa6b6, LSL #0
    MOVK  X17, #0xb41f, LSL #16
    MOVK  X17, #0x2cff, LSL #32
    MOVK  X17, #0x7d3a, LSL #48
    MOVZ  X18, #0xf9c0, LSL #0
    MOVK  X18, #0x127c, LSL #16
    MOVK  X18, #0x7a04, LSL #32
    MOVK  X18, #0xf02f, LSL #48
    MOVZ  X19, #0xb37b, LSL #0
    MOVK  X19, #0x713, LSL #16
    MOVK  X19, #0x8420, LSL #32
    MOVK  X19, #0xc99d, LSL #48
    MOVZ  X20, #0x62ea, LSL #0
    MOVK  X20, #0x5d19, LSL #16
    MOVK  X20, #0x8c63, LSL #32
    MOVK  X20, #0xac98, LSL #48
    MOVZ  X21, #0xbaca, LSL #0
    MOVK  X21, #0x606e, LSL #16
    MOVK  X21, #0xdf8b, LSL #32
    MOVK  X21, #0x6764, LSL #48
    MOVZ  X22, #0xe510, LSL #0
    MOVK  X22, #0xe082, LSL #16
    MOVK  X22, #0xe02f, LSL #32
    MOVK  X22, #0x5cc0, LSL #48
    MOVZ  X23, #0x85f3, LSL #0
    MOVK  X23, #0xc10d, LSL #16
    MOVK  X23, #0x4502, LSL #32
    MOVK  X23, #0xcef6, LSL #48
    MOVZ  X27, #0x7684, LSL #0
    MOVK  X27, #0xce5f, LSL #16
    MOVK  X27, #0x9423, LSL #32
    MOVK  X27, #0x6611, LSL #48
    MOVZ  X16, #0x68e, LSL #0
    MOVK  X16, #0xcee2, LSL #16
    MOVK  X16, #0xbd0f, LSL #32
    MOVK  X16, #0xa96a, LSL #48
    MSR  FPCR, X16
    MRS  X10, FPCR
    MOVZ  X3, #0x60ff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X10, X10, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X10, X10, X3
    MSR  FPCR, X10
    ISB  SY
    MOVZ  X16, #0x4d4, LSL #0
    MOVK  X16, #0x97ec, LSL #16
    MOVK  X16, #0x6dcb, LSL #32
    MOVK  X16, #0x62f8, LSL #48
    MSR  FPSR, X16
    MRS  X6, FPSR
    MOVZ  X2, #0xff60, LSL #0
    MOVK  X2, #0x7ff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X6, X6, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X6, X6, X2
    MSR  FPSR, X6
    ISB  SY
    ANDS  X3, X20, #0xe1ffe1ffe1ffe1ff
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x52cf, LSL #0
    MOVK  X2, #0x888f, LSL #16
    MOVK  X2, #0xc448, LSL #32
    MOVK  X2, #0x511d, LSL #48
    MOVZ  X3, #0x5dc6, LSL #0
    MOVK  X3, #0xb4a2, LSL #16
    MOVK  X3, #0xd14f, LSL #32
    MOVK  X3, #0x9b8d, LSL #48
    MOVZ  X4, #0x3469, LSL #0
    MOVK  X4, #0x3532, LSL #16
    MOVK  X4, #0x3411, LSL #32
    MOVK  X4, #0x6594, LSL #48
    MOVZ  X5, #0xce0d, LSL #0
    MOVK  X5, #0x1afe, LSL #16
    MOVK  X5, #0xe10c, LSL #32
    MOVK  X5, #0x623f, LSL #48
    MOVZ  X6, #0xc571, LSL #0
    MOVK  X6, #0x36c1, LSL #16
    MOVK  X6, #0xd4b7, LSL #32
    MOVK  X6, #0xf616, LSL #48
    MOVZ  X7, #0xad9c, LSL #0
    MOVK  X7, #0x60e8, LSL #16
    MOVK  X7, #0x94eb, LSL #32
    MOVK  X7, #0xc41e, LSL #48
    MOVZ  X8, #0x6602, LSL #0
    MOVK  X8, #0x336, LSL #16
    MOVK  X8, #0x8421, LSL #32
    MOVK  X8, #0x3191, LSL #48
    MOVZ  X9, #0xb6f7, LSL #0
    MOVK  X9, #0xb151, LSL #16
    MOVK  X9, #0xa6, LSL #32
    MOVK  X9, #0x1043, LSL #48
    MOVZ  X10, #0xaa56, LSL #0
    MOVK  X10, #0xdbd2, LSL #16
    MOVK  X10, #0x4f88, LSL #32
    MOVK  X10, #0x6263, LSL #48
    MOVZ  X11, #0xa9eb, LSL #0
    MOVK  X11, #0x5a4, LSL #16
    MOVK  X11, #0x31a3, LSL #32
    MOVK  X11, #0x9bb5, LSL #48
    MOVZ  X12, #0xa277, LSL #0
    MOVK  X12, #0x2598, LSL #16
    MOVK  X12, #0x7a64, LSL #32
    MOVK  X12, #0x7fa8, LSL #48
    MOVZ  X13, #0x412c, LSL #0
    MOVK  X13, #0x3ee4, LSL #16
    MOVK  X13, #0xb1e7, LSL #32
    MOVK  X13, #0x8989, LSL #48
    MOVZ  X14, #0x1210, LSL #0
    MOVK  X14, #0x1adc, LSL #16
    MOVK  X14, #0x22cf, LSL #32
    MOVK  X14, #0xc9c, LSL #48
    MOVZ  X15, #0xdd39, LSL #0
    MOVK  X15, #0x62f2, LSL #16
    MOVK  X15, #0x376f, LSL #32
    MOVK  X15, #0x46b6, LSL #48
    MOVZ  X16, #0xef9a, LSL #0
    MOVK  X16, #0xce04, LSL #16
    MOVK  X16, #0xea47, LSL #32
    MOVK  X16, #0xc3e9, LSL #48
    MOVZ  X17, #0xcb48, LSL #0
    MOVK  X17, #0xb0fe, LSL #16
    MOVK  X17, #0xe019, LSL #32
    MOVK  X17, #0x83, LSL #48
    MOVZ  X18, #0xd9b8, LSL #0
    MOVK  X18, #0xe623, LSL #16
    MOVK  X18, #0x8372, LSL #32
    MOVK  X18, #0x6090, LSL #48
    MOVZ  X19, #0xfdb8, LSL #0
    MOVK  X19, #0x8f46, LSL #16
    MOVK  X19, #0xfa04, LSL #32
    MOVK  X19, #0x9954, LSL #48
    MOVZ  X20, #0x39d0, LSL #0
    MOVK  X20, #0x9ea3, LSL #16
    MOVK  X20, #0x7791, LSL #32
    MOVK  X20, #0x93b4, LSL #48
    MOVZ  X21, #0xae5a, LSL #0
    MOVK  X21, #0x438b, LSL #16
    MOVK  X21, #0xb6cf, LSL #32
    MOVK  X21, #0x1452, LSL #48
    MOVZ  X22, #0xfe39, LSL #0
    MOVK  X22, #0x7b25, LSL #16
    MOVK  X22, #0xd2b3, LSL #32
    MOVK  X22, #0xb8cf, LSL #48
    MOVZ  X23, #0xe90f, LSL #0
    MOVK  X23, #0x5a25, LSL #16
    MOVK  X23, #0x2392, LSL #32
    MOVK  X23, #0x9452, LSL #48
    MOVZ  X27, #0x4eae, LSL #0
    MOVK  X27, #0xc64, LSL #16
    MOVK  X27, #0xac1c, LSL #32
    MOVK  X27, #0x8450, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X6
    FMOV  D1, X19
    FMOV  V1.D[1], X23
    FMOV  D2, X13
    FMOV  V2.D[1], X27
    FMOV  D3, X21
    FMOV  V3.D[1], X22
    FMOV  D4, X8
    FMOV  V4.D[1], X12
    FMOV  D5, X5
    FMOV  V5.D[1], X3
    FMOV  D6, X27
    FMOV  V6.D[1], X10
    FMOV  D7, X3
    FMOV  V7.D[1], X19
    FMOV  D8, X23
    FMOV  V8.D[1], X18
    FMOV  D9, X5
    FMOV  V9.D[1], X7
    FMOV  D10, X5
    FMOV  V10.D[1], X19
    FMOV  D11, X19
    FMOV  V11.D[1], X27
    FMOV  D12, X8
    FMOV  V12.D[1], X8
    FMOV  D13, X19
    FMOV  V13.D[1], X21
    FMOV  D14, X19
    FMOV  V14.D[1], X9
    FMOV  D15, X5
    FMOV  V15.D[1], X20
    FMOV  D16, X4
    FMOV  V16.D[1], X2
    FMOV  D17, X2
    FMOV  V17.D[1], X9
    FMOV  D18, X18
    FMOV  V18.D[1], X20
    FMOV  D19, X27
    FMOV  V19.D[1], X22
    FMOV  D20, X9
    FMOV  V20.D[1], X6
    FMOV  D21, X21
    FMOV  V21.D[1], X18
    FMOV  D22, X4
    FMOV  V22.D[1], X7
    FMOV  D23, X11
    FMOV  V23.D[1], X6
    FMOV  D24, X27
    FMOV  V24.D[1], X8
    FMOV  D25, X9
    FMOV  V25.D[1], X21
    FMOV  D26, X10
    FMOV  V26.D[1], X3
    FMOV  D27, X2
    FMOV  V27.D[1], X6
    FMOV  D28, X4
    FMOV  V28.D[1], X27
    FMOV  D29, X5
    FMOV  V29.D[1], X12
    FMOV  D30, X22
    FMOV  V30.D[1], X22
    FMOV  D31, X22
    FMOV  V31.D[1], X13
    MOVZ  X23, #0xa, LSL #0
EnhanceFloatP01_label_0:
    FMSUB  H21, H24, H28, H12
    FNMUL  H3, H22, H20
    FMADD  S0, S29, S3, S21
    FNEG  S0, S31
    FSQRT  D31, D30
    FNEG  S12, S31
    FNMADD  S11, S25, S27, S19
    FDIV  D5, D12, D21
    FDIV  H10, H23, H11
    FSUB  D30, D26, D8
    FMOV  S25, W3
    FCSEL  H7, H10, H5, LT
    FMOV  W11, H11
    FMSUB  D8, D7, D28, D23
    FCSEL  D24, D5, D19, VC
    FMOV  S26, #-0.14843750
    FMOV  H12, W6
    FCSEL  D28, D0, D26, NV
    FMOV  S21, S15
    FMOV  H31, X3
    FNMUL  D23, D4, D28
    FMADD  D11, D8, D31, D31
    FCSEL  S7, S25, S23, LT
    FNMADD  D6, D24, D11, D24
    FSUB  H9, H27, H28
    FADD  D19, D24, D12
    FCSEL  S4, S25, S19, MI
    FNEG  S10, S9
    FMOV  H0, X4
    FNMSUB  S24, S29, S0, S5
    FNMADD  D8, D6, D6, D7
    FNEG  S11, S8
    FSQRT  S31, S11
    FMADD  H19, H21, H21, H21
    FMOV  D8, D31
    FMOV  H0, #-4.75000000
    FMOV  H31, H0
    FSQRT  D9, D14
    FNMUL  D26, D31, D5
    FMSUB  H4, H4, H5, H6
    FMADD  D27, D7, D13, D15
    FMOV  S31, S7
    FMOV  W6, H18
    FNMSUB  D29, D9, D14, D26
    FCSEL  S28, S19, S29, PL
    FMSUB  D18, D29, D30, D7
    FNEG  H27, H30
    FMADD  S9, S8, S4, S22
    FCSEL  S5, S6, S22, EQ
    FMOV  W17, S9
    FSQRT  H25, H18
    FMADD  H6, H28, H11, H28
    FNMSUB  H19, H28, H5, H19
    FMOV  H22, H19
    FNMUL  H14, H28, H3
    FNMSUB  H26, H10, H14, H31
    FMADD  S3, S7, S24, S22
    FMOV  H6, X19
    FNEG  H21, H5
    FMOV  H15, X12
    FMSUB  S30, S1, S5, S3
    FMOV  X13, H28
    FNEG  S29, S15
    FNMUL  D5, D30, D17
    FMOV  H7, #0.35937500
    FMSUB  S19, S21, S27, S6
    FSUB  S25, S29, S29
    FMOV  X27, D25
    FMOV  X3, D26
    FMSUB  D13, D7, D19, D19
    FMOV  X14, H26
    FMADD  H28, H25, H0, H10
    FDIV  H24, H23, H20
    FSQRT  S23, S5
    FCSEL  S25, S21, S31, LT
    FMADD  D27, D8, D30, D17
    FSUB  S19, S31, S10
    FADD  H20, H25, H6
    FNMUL  H15, H18, H14
    FMOV  D18, X4
    FADD  S30, S20, S4
    FMOV  D29, D23
    FMSUB  S26, S27, S15, S13
    FMOV  D22, #24.00000000
    FCSEL  H15, H24, H29, LT
    FABS  D7, D30
    FMOV  X4, D18
    FMOV  S18, #-31.00000000
    FNEG  D27, D15
    FMSUB  S21, S26, S7, S1
    FNEG  H23, H18
    FMADD  D30, D27, D19, D23
    FSQRT  D24, D28
    FMOV  D28, #0.62500000
    FMOV  D1, #-26.00000000
    FMOV  D6, #11.00000000
    FSQRT  S27, S30
    FCSEL  S7, S14, S18, CC
    FMOV  X12, D28
    FDIV  H20, H21, H7
    SUBS  X23, X23, #0x1
    B.NE  EnhanceFloatP01_label_0
    ISB  SY
    FADD  D29, D24, D6
    FADD  S13, S20, S29
    FADD  H18, H24, H21
    FADD  D20, D25, D18
    FADD  S4, S24, S22
    FADD  H21, H27, H16
    FADD  D18, D20, D20
    FADD  S16, S4, S23
    FADD  H25, H6, H21
    FADD  D10, D13, D27
    FADD  S22, S30, S1
    FADD  H7, H10, H28
    FADD  D30, D18, D22
    FADD  S29, S19, S30
    FADD  H30, H7, H7
    FADD  D6, D16, D23
    FADD  S14, S7, S6
    FADD  H11, H30, H26
    FADD  D6, D11, D14
    FADD  S28, S6, S26
    FADD  H15, H29, H29
    FADD  D21, D25, D31
    FADD  S25, S28, S19
    FADD  H29, H8, H25
    FADD  D18, D15, D0
    FADD  S23, S25, S2
    FADD  H0, H29, H18
    FADD  D13, D23, D0
    FADD  S7, S8, S19
    FADD  H10, H24, H19
    MOVZ  X10, #0x52cf, LSL #0
    MOVK  X10, #0x888f, LSL #16
    MOVK  X10, #0xc448, LSL #32
    MOVK  X10, #0x511d, LSL #48
    SUB  X22, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    SUB  X22, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x3469, LSL #0
    MOVK  X10, #0x3532, LSL #16
    MOVK  X10, #0x3411, LSL #32
    MOVK  X10, #0x6594, LSL #48
    SUB  X22, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0xce0d, LSL #0
    MOVK  X10, #0x1afe, LSL #16
    MOVK  X10, #0xe10c, LSL #32
    MOVK  X10, #0x623f, LSL #48
    SUB  X22, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0xad9c, LSL #0
    MOVK  X10, #0x60e8, LSL #16
    MOVK  X10, #0x94eb, LSL #32
    MOVK  X10, #0xc41e, LSL #48
    SUB  X22, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x6602, LSL #0
    MOVK  X10, #0x336, LSL #16
    MOVK  X10, #0x8421, LSL #32
    MOVK  X10, #0x3191, LSL #48
    SUB  X22, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fe4, LSL #48
    SUB  X22, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x7bff, LSL #0
    SUB  X22, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    SUB  X22, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0xdd39, LSL #0
    MOVK  X10, #0x62f2, LSL #16
    MOVK  X10, #0x376f, LSL #32
    MOVK  X10, #0x46b6, LSL #48
    SUB  X22, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0xef9a, LSL #0
    MOVK  X10, #0xce04, LSL #16
    MOVK  X10, #0xea47, LSL #32
    MOVK  X10, #0xc3e9, LSL #48
    SUB  X22, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0xd9b8, LSL #0
    MOVK  X10, #0xe623, LSL #16
    MOVK  X10, #0x8372, LSL #32
    MOVK  X10, #0x6090, LSL #48
    SUB  X22, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0xfdb8, LSL #0
    MOVK  X10, #0x8f46, LSL #16
    MOVK  X10, #0xfa04, LSL #32
    MOVK  X10, #0x9954, LSL #48
    SUB  X22, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x39d0, LSL #0
    MOVK  X10, #0x9ea3, LSL #16
    MOVK  X10, #0x7791, LSL #32
    MOVK  X10, #0x93b4, LSL #48
    SUB  X22, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0xae5a, LSL #0
    MOVK  X10, #0x438b, LSL #16
    MOVK  X10, #0xb6cf, LSL #32
    MOVK  X10, #0x1452, LSL #48
    SUB  X22, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MRS  X10, FPCR
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x6e2, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    MRS  X10, FPSR
    MOVZ  X22, #0x1f, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D0
    MOVZ  X22, #0xf9b5, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D1
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xc03a, LSL #48
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X22, #0x4eae, LSL #0
    MOVK  X22, #0xc64, LSL #16
    MOVK  X22, #0xac1c, LSL #32
    MOVK  X22, #0x8450, LSL #48
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D2
    MOVZ  X22, #0x412c, LSL #0
    MOVK  X22, #0x3ee4, LSL #16
    MOVK  X22, #0xb1e7, LSL #32
    MOVK  X22, #0x8989, LSL #48
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D3
    MOVZ  X22, #0xfbff, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D5
    MOVZ  X22, #0x8cf4, LSL #0
    MOVK  X22, #0xa224, LSL #16
    MOVK  X22, #0x4d19, LSL #32
    MOVK  X22, #0x8efd, LSL #48
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D6
    MOVZ  X22, #0xfc00, LSL #0
    MOVK  X22, #0x1, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D8
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D11
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D13
    MOVZ  X22, #0x3ae1, LSL #0
    MOVK  X22, #0x3ee5, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D14
    MOVZ  X22, #0x7e00, LSL #0
    MOVK  X22, #0x1, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D15
    MOVZ  X22, #0x8000, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D16
    MOVZ  X22, #0x8000, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X22, #0xb6f7, LSL #0
    MOVK  X22, #0xb151, LSL #16
    MOVK  X22, #0xa6, LSL #32
    MOVK  X22, #0x1043, LSL #48
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D17
    MOVZ  X22, #0x52cf, LSL #0
    MOVK  X22, #0x888f, LSL #16
    MOVK  X22, #0xc448, LSL #32
    MOVK  X22, #0x511d, LSL #48
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D18
    MOVZ  X22, #0x44c0, LSL #0
    MOVK  X22, #0x1, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D21
    MOVZ  X22, #0x3469, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D22
    MOVZ  X22, #0x8000, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D23
    MOVZ  X22, #0x412c, LSL #0
    MOVK  X22, #0x3ee4, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D25
    MOVZ  X22, #0xf9b6, LSL #0
    MOVK  X22, #0x2, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D26
    MOVZ  X22, #0xfdb6, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D27
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x1e00, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D28
    MOVZ  X22, #0xf9b6, LSL #0
    MOVK  X22, #0x2, LSL #16
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D29
    MOVZ  X22, #0xf9b6, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D30
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    FMOV  X10, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x9ded, LSL #0
    MOVK  X2, #0x7e62, LSL #16
    MOVK  X2, #0x290c, LSL #32
    MOVK  X2, #0xf493, LSL #48
    MOVZ  X3, #0xba6d, LSL #0
    MOVK  X3, #0x3075, LSL #16
    MOVK  X3, #0xffb8, LSL #32
    MOVK  X3, #0xb872, LSL #48
    MOVZ  X4, #0xb6f9, LSL #0
    MOVK  X4, #0xbca3, LSL #16
    MOVK  X4, #0x6e96, LSL #32
    MOVK  X4, #0x2d82, LSL #48
    MOVZ  X5, #0x14b6, LSL #0
    MOVK  X5, #0x5453, LSL #16
    MOVK  X5, #0x7497, LSL #32
    MOVK  X5, #0xdf66, LSL #48
    MOVZ  X6, #0x9a42, LSL #0
    MOVK  X6, #0x4d71, LSL #16
    MOVK  X6, #0x5def, LSL #32
    MOVK  X6, #0xa3b7, LSL #48
    MOVZ  X7, #0x443b, LSL #0
    MOVK  X7, #0xf50, LSL #16
    MOVK  X7, #0x2e47, LSL #32
    MOVK  X7, #0x66da, LSL #48
    MOVZ  X8, #0x443a, LSL #0
    MOVK  X8, #0xbe28, LSL #16
    MOVK  X8, #0x6267, LSL #32
    MOVK  X8, #0x3641, LSL #48
    MOVZ  X9, #0x9fa0, LSL #0
    MOVK  X9, #0x695b, LSL #16
    MOVK  X9, #0x5c2d, LSL #32
    MOVK  X9, #0x30a9, LSL #48
    MOVZ  X10, #0x3706, LSL #0
    MOVK  X10, #0xd09a, LSL #16
    MOVK  X10, #0xd4d8, LSL #32
    MOVK  X10, #0x2a1e, LSL #48
    MOVZ  X11, #0xb1b, LSL #0
    MOVK  X11, #0x353, LSL #16
    MOVK  X11, #0xd0df, LSL #32
    MOVK  X11, #0xbd07, LSL #48
    MOVZ  X12, #0x6886, LSL #0
    MOVK  X12, #0x2cd3, LSL #16
    MOVK  X12, #0x36b9, LSL #32
    MOVK  X12, #0x4d84, LSL #48
    MOVZ  X13, #0xa57d, LSL #0
    MOVK  X13, #0x45dc, LSL #16
    MOVK  X13, #0xa850, LSL #32
    MOVK  X13, #0x3855, LSL #48
    MOVZ  X14, #0xf205, LSL #0
    MOVK  X14, #0xa0c3, LSL #16
    MOVK  X14, #0x7253, LSL #32
    MOVK  X14, #0xa645, LSL #48
    MOVZ  X15, #0xd20a, LSL #0
    MOVK  X15, #0x9237, LSL #16
    MOVK  X15, #0xbbc, LSL #32
    MOVK  X15, #0xce30, LSL #48
    MOVZ  X16, #0x85c6, LSL #0
    MOVK  X16, #0xd774, LSL #16
    MOVK  X16, #0xb6f8, LSL #32
    MOVK  X16, #0x254a, LSL #48
    MOVZ  X17, #0x5c5, LSL #0
    MOVK  X17, #0xe42d, LSL #16
    MOVK  X17, #0x336a, LSL #32
    MOVK  X17, #0xeead, LSL #48
    MOVZ  X18, #0x76ca, LSL #0
    MOVK  X18, #0x1fc8, LSL #16
    MOVK  X18, #0x5b09, LSL #32
    MOVK  X18, #0x6a13, LSL #48
    MOVZ  X19, #0x4664, LSL #0
    MOVK  X19, #0x9ee, LSL #16
    MOVK  X19, #0x4c74, LSL #32
    MOVK  X19, #0x9aa5, LSL #48
    MOVZ  X20, #0xf2b7, LSL #0
    MOVK  X20, #0xb172, LSL #16
    MOVK  X20, #0xc4a0, LSL #32
    MOVK  X20, #0xd0e3, LSL #48
    MOVZ  X21, #0x5703, LSL #0
    MOVK  X21, #0x93b2, LSL #16
    MOVK  X21, #0x6dc7, LSL #32
    MOVK  X21, #0xec58, LSL #48
    MOVZ  X22, #0xb260, LSL #0
    MOVK  X22, #0x81a8, LSL #16
    MOVK  X22, #0x915f, LSL #32
    MOVK  X22, #0x2a73, LSL #48
    MOVZ  X23, #0x933c, LSL #0
    MOVK  X23, #0x182b, LSL #16
    MOVK  X23, #0xe486, LSL #32
    MOVK  X23, #0xf5d2, LSL #48
    MOVZ  X27, #0x7332, LSL #0
    MOVK  X27, #0x9fbc, LSL #16
    MOVK  X27, #0x5cc8, LSL #32
    MOVK  X27, #0x2b52, LSL #48
    FMOV  D0, X5
    FMOV  V0.D[1], X10
    FMOV  D1, X2
    FMOV  V1.D[1], X20
    FMOV  D2, X18
    FMOV  V2.D[1], X20
    FMOV  D3, X23
    FMOV  V3.D[1], X18
    FMOV  D4, X27
    FMOV  V4.D[1], X22
    FMOV  D5, X13
    FMOV  V5.D[1], X18
    FMOV  D6, X18
    FMOV  V6.D[1], X10
    FMOV  D7, X16
    FMOV  V7.D[1], X12
    FMOV  D8, X22
    FMOV  V8.D[1], X19
    FMOV  D9, X3
    FMOV  V9.D[1], X10
    FMOV  D10, X27
    FMOV  V10.D[1], X23
    FMOV  D11, X2
    FMOV  V11.D[1], X22
    FMOV  D12, X11
    FMOV  V12.D[1], X21
    FMOV  D13, X9
    FMOV  V13.D[1], X10
    FMOV  D14, X17
    FMOV  V14.D[1], X13
    FMOV  D15, X27
    FMOV  V15.D[1], X10
    FMOV  D16, X13
    FMOV  V16.D[1], X23
    FMOV  D17, X20
    FMOV  V17.D[1], X19
    FMOV  D18, X22
    FMOV  V18.D[1], X17
    FMOV  D19, X9
    FMOV  V19.D[1], X11
    FMOV  D20, X15
    FMOV  V20.D[1], X23
    FMOV  D21, X3
    FMOV  V21.D[1], X12
    FMOV  D22, X6
    FMOV  V22.D[1], X3
    FMOV  D23, X14
    FMOV  V23.D[1], X8
    FMOV  D24, X16
    FMOV  V24.D[1], X9
    FMOV  D25, X22
    FMOV  V25.D[1], X17
    FMOV  D26, X19
    FMOV  V26.D[1], X13
    FMOV  D27, X15
    FMOV  V27.D[1], X17
    FMOV  D28, X15
    FMOV  V28.D[1], X4
    FMOV  D29, X27
    FMOV  V29.D[1], X9
    FMOV  D30, X16
    FMOV  V30.D[1], X3
    FMOV  D31, X4
    FMOV  V31.D[1], X27
    MOVZ  X27, #0xa, LSL #0
EnhanceFloatP01_label_1:
    FMOV  D1, X18
    FCSEL  S7, S25, S1, NV
    FSQRT  S23, S31
    FMADD  H19, H7, H23, H23
    FCSEL  S16, S26, S11, CS
    FMUL  D6, D29, D29
    FSQRT  D11, D6
    FSUB  H13, H14, H16
    FNMUL  D28, D11, D27
    FSUB  D11, D22, D28
    FMOV  S25, W18
    FMSUB  D25, D25, D11, D16
    FDIV  S3, S13, S30
    FADD  D28, D6, D19
    FCSEL  S30, S28, S25, LT
    FNEG  S27, S3
    FMOV  D16, X21
    FMADD  H13, H30, H9, H27
    FMUL  S11, S19, S1
    FMOV  D19, X18
    FMOV  W21, H4
    FDIV  H1, H10, H22
    FMADD  H14, H16, H3, H10
    FNMUL  H24, H17, H23
    FMOV  D4, #1.31250000
    FMSUB  H28, H29, H26, H23
    FNEG  D8, D23
    FMOV  W18, H19
    FMADD  H3, H1, H22, H4
    FDIV  S29, S14, S3
    FMUL  S14, S24, S13
    FNMSUB  S19, S11, S7, S10
    FMOV  D6, #-0.15625000
    FMOV  X13, D3
    FMSUB  H23, H5, H27, H27
    FMOV  D27, X9
    FSUB  S1, S24, S24
    FMOV  H17, X19
    FDIV  S7, S29, S30
    FMOV  D24, X15
    FMOV  S16, S1
    FMOV  X15, H23
    FADD  D10, D16, D17
    FMUL  S15, S14, S14
    FCSEL  H26, H7, H19, VS
    FMOV  D15, #-0.17187500
    FSQRT  H30, H6
    FMUL  S15, S27, S15
    FMSUB  D13, D15, D26, D24
    FDIV  S16, S30, S28
    FSQRT  D11, D16
    FNMUL  S29, S27, S10
    FNMADD  S30, S11, S27, S29
    FADD  D24, D0, D20
    FSQRT  H29, H10
    FMOV  H1, W17
    FNMADD  S0, S17, S29, S21
    FMSUB  S27, S20, S24, S13
    FMOV  X10, D9
    FMOV  S8, #0.93750000
    FDIV  H7, H8, H25
    FMOV  S23, W16
    FMUL  D14, D6, D0
    FMSUB  H28, H27, H14, H14
    FADD  D6, D21, D29
    FABS  D13, D28
    FMADD  H16, H24, H1, H6
    FMOV  S29, S20
    FMOV  W11, S24
    FDIV  H10, H16, H22
    FADD  S11, S7, S21
    FSUB  D31, D6, D2
    FNMUL  S25, S10, S29
    FCSEL  H29, H25, H10, VC
    FMADD  D8, D31, D22, D13
    FMOV  H27, W17
    FMSUB  S20, S23, S31, S11
    FNMUL  S19, S30, S20
    FNEG  H23, H28
    FDIV  D4, D19, D30
    FMOV  H14, H8
    FNMUL  H20, H17, H29
    FDIV  H7, H11, H20
    FSUB  H29, H6, H23
    FNMUL  H2, H31, H4
    FADD  H4, H29, H1
    FMSUB  S12, S2, S6, S2
    FNMADD  D31, D1, D12, D7
    FMOV  D29, #0.28125000
    FCSEL  H16, H31, H14, VC
    FSQRT  H23, H16
    FMOV  S27, W21
    FNMADD  D23, D29, D4, D18
    FSQRT  H24, H23
    FMOV  X13, D10
    FNMUL  S23, S3, S31
    FMOV  H2, W22
    FMOV  S31, #9.00000000
    FDIV  H12, H3, H27
    FCSEL  H19, H15, H2, LT
    SUBS  X27, X27, #0x1
    B.NE  EnhanceFloatP01_label_1
    ISB  SY
    FADD  D9, D22, D21
    FADD  S14, S0, S15
    FADD  H30, H0, H5
    FADD  D10, D3, D7
    FADD  S16, S9, S29
    FADD  H7, H14, H12
    FADD  D14, D19, D10
    FADD  S12, S14, S31
    FADD  H2, H7, H30
    FADD  D3, D24, D12
    FADD  S9, S3, S20
    FADD  H14, H11, H22
    FADD  D22, D16, D2
    FADD  S27, S14, S14
    FADD  H3, H27, H30
    FADD  D20, D3, D19
    FADD  S7, S22, S22
    FADD  H21, H9, H20
    FADD  D15, D7, D22
    FADD  S20, S21, S28
    FADD  H12, H14, H30
    FADD  D21, D7, D20
    FADD  S12, S21, S22
    FADD  H11, H29, H12
    FADD  D22, D28, D22
    FADD  S21, S16, S22
    FADD  H27, H11, H22
    FADD  D14, D15, D15
    FADD  S28, S24, S20
    FADD  H22, H21, H21
    MOVZ  X6, #0x9ded, LSL #0
    MOVK  X6, #0x7e62, LSL #16
    MOVK  X6, #0x290c, LSL #32
    MOVK  X6, #0xf493, LSL #48
    SUB  X8, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0xba6d, LSL #0
    MOVK  X6, #0x3075, LSL #16
    MOVK  X6, #0xffb8, LSL #32
    MOVK  X6, #0xb872, LSL #48
    SUB  X8, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0xb6f9, LSL #0
    MOVK  X6, #0xbca3, LSL #16
    MOVK  X6, #0x6e96, LSL #32
    MOVK  X6, #0x2d82, LSL #48
    SUB  X8, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x14b6, LSL #0
    MOVK  X6, #0x5453, LSL #16
    MOVK  X6, #0x7497, LSL #32
    MOVK  X6, #0xdf66, LSL #48
    SUB  X8, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x443b, LSL #0
    MOVK  X6, #0xf50, LSL #16
    MOVK  X6, #0x2e47, LSL #32
    MOVK  X6, #0x66da, LSL #48
    SUB  X8, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x9fa0, LSL #0
    MOVK  X6, #0x695b, LSL #16
    MOVK  X6, #0x5c2d, LSL #32
    MOVK  X6, #0x30a9, LSL #48
    SUB  X8, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0xba6d, LSL #0
    MOVK  X6, #0x3075, LSL #16
    MOVK  X6, #0xffb8, LSL #32
    MOVK  X6, #0xb872, LSL #48
    SUB  X8, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x3a6d, LSL #0
    MOVK  X6, #0xb076, LSL #16
    SUB  X8, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x6886, LSL #0
    MOVK  X6, #0x2cd3, LSL #16
    MOVK  X6, #0x36b9, LSL #32
    MOVK  X6, #0x4d84, LSL #48
    SUB  X8, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x5c1a, LSL #0
    SUB  X8, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0xf205, LSL #0
    MOVK  X6, #0xa0c3, LSL #16
    MOVK  X6, #0x7253, LSL #32
    MOVK  X6, #0xa645, LSL #48
    SUB  X8, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x3368, LSL #0
    SUB  X8, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x85c6, LSL #0
    MOVK  X6, #0xd774, LSL #16
    MOVK  X6, #0xb6f8, LSL #32
    MOVK  X6, #0x254a, LSL #48
    SUB  X8, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x5c5, LSL #0
    MOVK  X6, #0xe42d, LSL #16
    MOVK  X6, #0x336a, LSL #32
    MOVK  X6, #0xeead, LSL #48
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x76ca, LSL #0
    SUB  X8, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x4664, LSL #0
    MOVK  X6, #0x9ee, LSL #16
    MOVK  X6, #0x4c74, LSL #32
    MOVK  X6, #0x9aa5, LSL #48
    SUB  X8, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x63e0, LSL #0
    SUB  X8, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0xb260, LSL #0
    MOVK  X6, #0x81a8, LSL #16
    MOVK  X6, #0x915f, LSL #32
    MOVK  X6, #0x2a73, LSL #48
    SUB  X8, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x933c, LSL #0
    MOVK  X6, #0x182b, LSL #16
    MOVK  X6, #0xe486, LSL #32
    MOVK  X6, #0xf5d2, LSL #48
    SUB  X8, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, EnhanceFloatP01_TestFail
    MRS  X6, FPCR
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x6e2, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    MRS  X6, FPSR
    MOVZ  X8, #0x1f, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D0
    MOVZ  X8, #0xba6d, LSL #0
    MOVK  X8, #0xb075, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D1
    MOVZ  X8, #0x5c5, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D2
    MOVZ  X8, #0xbdb7, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D3
    MOVZ  X8, #0x74e5, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D4
    MOVZ  X8, #0x63e0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X8, #0x76ca, LSL #0
    MOVK  X8, #0x1fc8, LSL #16
    MOVK  X8, #0x5b09, LSL #32
    MOVK  X8, #0x6a13, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D5
    MOVZ  X8, #0xa57d, LSL #0
    MOVK  X8, #0x45dc, LSL #16
    MOVK  X8, #0xa850, LSL #32
    MOVK  X8, #0x3855, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D6
    MOVZ  X8, #0xba6c, LSL #0
    MOVK  X8, #0x3075, LSL #16
    MOVK  X8, #0xffb8, LSL #32
    MOVK  X8, #0xb872, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D7
    MOVZ  X8, #0x7824, LSL #0
    MOVK  X8, #0x30f6, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D8
    MOVZ  X8, #0xc7bf, LSL #0
    MOVK  X8, #0x4c07, LSL #16
    MOVK  X8, #0xbf23, LSL #32
    MOVK  X8, #0x1c3b, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D9
    MOVZ  X8, #0x7e00, LSL #0
    MOVK  X8, #0x4110, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D10
    MOVZ  X8, #0xd641, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D11
    MOVZ  X8, #0x4b0c, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D12
    MOVZ  X8, #0x4b0c, LSL #0
    MOVK  X8, #0x3139, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D13
    MOVZ  X8, #0x63e2, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D14
    MOVZ  X8, #0xe090, LSL #0
    MOVK  X8, #0xc2d9, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D15
    MOVZ  X8, #0xf048, LSL #0
    MOVK  X8, #0x616c, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D16
    MOVZ  X8, #0xba6d, LSL #0
    MOVK  X8, #0x3075, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D17
    MOVZ  X8, #0x4664, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X8, #0x5c5, LSL #0
    MOVK  X8, #0xe42d, LSL #16
    MOVK  X8, #0x336a, LSL #32
    MOVK  X8, #0xeead, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D18
    MOVZ  X8, #0xb260, LSL #0
    MOVK  X8, #0x81a8, LSL #16
    MOVK  X8, #0x915f, LSL #32
    MOVK  X8, #0x2a73, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D19
    MOVZ  X8, #0xb260, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D20
    MOVZ  X8, #0xe1e2, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D21
    MOVZ  X8, #0x4b39, LSL #0
    MOVK  X8, #0x30f6, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D22
    MOVZ  X8, #0x4f39, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D23
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D24
    MOVZ  X8, #0x7e00, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D25
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D26
    MOVZ  X8, #0x5c1a, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D27
    MOVZ  X8, #0xdb9b, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D28
    MOVZ  X8, #0x5fe2, LSL #0
    MOVK  X8, #0x1, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D29
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x3fd2, LSL #48
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D30
    MOVZ  X8, #0xba98, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    FMOV  X6, D31
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4110, LSL #16
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x67de, LSL #0
    MOVK  X2, #0x12a8, LSL #16
    MOVK  X2, #0x565a, LSL #32
    MOVK  X2, #0x6124, LSL #48
    MOVZ  X3, #0x2b0d, LSL #0
    MOVK  X3, #0xd77a, LSL #16
    MOVK  X3, #0x5ef8, LSL #32
    MOVK  X3, #0x4cc9, LSL #48
    MOVZ  X4, #0x6027, LSL #0
    MOVK  X4, #0x71b, LSL #16
    MOVK  X4, #0x5e6d, LSL #32
    MOVK  X4, #0xe8b2, LSL #48
    MOVZ  X5, #0x9cd7, LSL #0
    MOVK  X5, #0xf6fd, LSL #16
    MOVK  X5, #0xc5e3, LSL #32
    MOVK  X5, #0x48e4, LSL #48
    MOVZ  X6, #0x5a79, LSL #0
    MOVK  X6, #0x115d, LSL #16
    MOVK  X6, #0x2d8a, LSL #32
    MOVK  X6, #0x56c6, LSL #48
    MOVZ  X7, #0x66ad, LSL #0
    MOVK  X7, #0xd4df, LSL #16
    MOVK  X7, #0xe2c0, LSL #32
    MOVK  X7, #0xa934, LSL #48
    MOVZ  X8, #0x7217, LSL #0
    MOVK  X8, #0xe1d1, LSL #16
    MOVK  X8, #0xb405, LSL #32
    MOVK  X8, #0xf1d6, LSL #48
    MOVZ  X9, #0xf7fd, LSL #0
    MOVK  X9, #0x67a5, LSL #16
    MOVK  X9, #0xb39d, LSL #32
    MOVK  X9, #0xc312, LSL #48
    MOVZ  X10, #0x2615, LSL #0
    MOVK  X10, #0x1f94, LSL #16
    MOVK  X10, #0x7cbe, LSL #32
    MOVK  X10, #0x6d52, LSL #48
    MOVZ  X11, #0xdaf, LSL #0
    MOVK  X11, #0xd889, LSL #16
    MOVK  X11, #0xb663, LSL #32
    MOVK  X11, #0x22e6, LSL #48
    MOVZ  X12, #0x8193, LSL #0
    MOVK  X12, #0x7ed2, LSL #16
    MOVK  X12, #0x7e3a, LSL #32
    MOVK  X12, #0xc1c1, LSL #48
    MOVZ  X13, #0x209f, LSL #0
    MOVK  X13, #0x2a18, LSL #16
    MOVK  X13, #0x4791, LSL #32
    MOVK  X13, #0x3686, LSL #48
    MOVZ  X14, #0x23d8, LSL #0
    MOVK  X14, #0xcd62, LSL #16
    MOVK  X14, #0xb40c, LSL #32
    MOVK  X14, #0x4a92, LSL #48
    MOVZ  X15, #0xdccd, LSL #0
    MOVK  X15, #0x66cf, LSL #16
    MOVK  X15, #0xe74a, LSL #32
    MOVK  X15, #0x4c8f, LSL #48
    MOVZ  X16, #0x329b, LSL #0
    MOVK  X16, #0xd46e, LSL #16
    MOVK  X16, #0x65, LSL #32
    MOVK  X16, #0xc02d, LSL #48
    MOVZ  X17, #0x7b84, LSL #0
    MOVK  X17, #0xe634, LSL #16
    MOVK  X17, #0x5206, LSL #32
    MOVK  X17, #0xd39c, LSL #48
    MOVZ  X18, #0x7793, LSL #0
    MOVK  X18, #0xbd0, LSL #16
    MOVK  X18, #0x9073, LSL #32
    MOVK  X18, #0xed0f, LSL #48
    MOVZ  X19, #0xc00c, LSL #0
    MOVK  X19, #0x94cd, LSL #16
    MOVK  X19, #0x60da, LSL #32
    MOVK  X19, #0x51e1, LSL #48
    MOVZ  X20, #0xcd8, LSL #0
    MOVK  X20, #0x9c59, LSL #16
    MOVK  X20, #0xfeaf, LSL #32
    MOVK  X20, #0x362d, LSL #48
    MOVZ  X21, #0x89a4, LSL #0
    MOVK  X21, #0xa015, LSL #16
    MOVK  X21, #0x7758, LSL #32
    MOVK  X21, #0x2cc1, LSL #48
    MOVZ  X22, #0xc272, LSL #0
    MOVK  X22, #0x8581, LSL #16
    MOVK  X22, #0x131c, LSL #32
    MOVK  X22, #0x81fe, LSL #48
    MOVZ  X23, #0xcdcf, LSL #0
    MOVK  X23, #0x1b7f, LSL #16
    MOVK  X23, #0x8931, LSL #32
    MOVK  X23, #0xa461, LSL #48
    MOVZ  X27, #0x82fa, LSL #0
    MOVK  X27, #0xadff, LSL #16
    MOVK  X27, #0xe161, LSL #32
    MOVK  X27, #0x174b, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X21
    FMOV  D1, X27
    FMOV  V1.D[1], X23
    FMOV  D2, X10
    FMOV  V2.D[1], X9
    FMOV  D3, X7
    FMOV  V3.D[1], X11
    FMOV  D4, X8
    FMOV  V4.D[1], X6
    FMOV  D5, X9
    FMOV  V5.D[1], X20
    FMOV  D6, X15
    FMOV  V6.D[1], X14
    FMOV  D7, X6
    FMOV  V7.D[1], X2
    FMOV  D8, X20
    FMOV  V8.D[1], X23
    FMOV  D9, X21
    FMOV  V9.D[1], X17
    FMOV  D10, X19
    FMOV  V10.D[1], X20
    FMOV  D11, X12
    FMOV  V11.D[1], X13
    FMOV  D12, X12
    FMOV  V12.D[1], X18
    FMOV  D13, X14
    FMOV  V13.D[1], X17
    FMOV  D14, X23
    FMOV  V14.D[1], X8
    FMOV  D15, X7
    FMOV  V15.D[1], X17
    FMOV  D16, X10
    FMOV  V16.D[1], X15
    FMOV  D17, X12
    FMOV  V17.D[1], X12
    FMOV  D18, X27
    FMOV  V18.D[1], X19
    FMOV  D19, X4
    FMOV  V19.D[1], X22
    FMOV  D20, X9
    FMOV  V20.D[1], X15
    FMOV  D21, X6
    FMOV  V21.D[1], X23
    FMOV  D22, X5
    FMOV  V22.D[1], X5
    FMOV  D23, X18
    FMOV  V23.D[1], X15
    FMOV  D24, X27
    FMOV  V24.D[1], X10
    FMOV  D25, X19
    FMOV  V25.D[1], X9
    FMOV  D26, X8
    FMOV  V26.D[1], X15
    FMOV  D27, X11
    FMOV  V27.D[1], X10
    FMOV  D28, X18
    FMOV  V28.D[1], X16
    FMOV  D29, X9
    FMOV  V29.D[1], X4
    FMOV  D30, X19
    FMOV  V30.D[1], X5
    FMOV  D31, X20
    FMOV  V31.D[1], X15
    MOVZ  X22, #0xa, LSL #0
EnhanceFloatP01_label_2:
    FNMADD  H30, H30, H22, H28
    FNMUL  S18, S19, S24
    FNMADD  H13, H25, H29, H17
    FABS  D1, D27
    FMSUB  D23, D13, D18, D30
    FNMUL  D12, D3, D2
    FMUL  S9, S31, S12
    FSUB  S17, S27, S24
    FMOV  S26, W4
    FABS  D28, D26
    FMOV  X9, D19
    FDIV  D31, D9, D17
    FMADD  D12, D8, D31, D28
    FSUB  S17, S25, S9
    FNMUL  H3, H1, H17
    FMSUB  D22, D5, D7, D23
    FSQRT  H6, H12
    FNMADD  S1, S26, S6, S6
    FNMSUB  S25, S3, S24, S22
    FMOV  H26, H26
    FCSEL  S17, S8, S26, GE
    FDIV  S8, S3, S16
    FNEG  H19, H4
    FABS  D3, D17
    FMOV  H9, H5
    FMOV  X4, H14
    FMADD  H27, H28, H11, H3
    FNMADD  H6, H24, H23, H0
    FSUB  S22, S20, S28
    FNMADD  H31, H22, H14, H23
    FMOV  H5, H28
    FADD  D12, D8, D4
    FADD  S30, S25, S9
    FMUL  D13, D12, D6
    FMOV  H2, X15
    FNMSUB  S28, S17, S31, S22
    FABS  D4, D2
    FMOV  X12, D20
    FMUL  S31, S1, S13
    FADD  D0, D15, D28
    FNMUL  D21, D20, D14
    FMOV  W14, H27
    FNMADD  D14, D5, D31, D5
    FMOV  H3, H4
    FNMUL  D6, D26, D26
    FMOV  W4, S8
    FMOV  D22, #0.42187500
    FDIV  S13, S25, S14
    FNEG  S25, S16
    FNEG  S15, S6
    FNMUL  D20, D3, D29
    FMOV  D2, X6
    FNEG  S28, S25
    FMOV  H12, X23
    FSUB  D29, D22, D2
    FMADD  D4, D31, D8, D28
    FMSUB  S22, S14, S12, S15
    FNMSUB  S17, S22, S6, S21
    FNMUL  S8, S14, S13
    FNMSUB  D5, D17, D0, D20
    FABS  S0, S29
    FADD  D26, D8, D5
    FNMSUB  S1, S26, S30, S26
    FSUB  H8, H29, H1
    FDIV  D19, D4, D18
    FNMADD  D25, D23, D8, D0
    FADD  S3, S10, S0
    FCSEL  S31, S31, S10, VC
    FSUB  D17, D1, D16
    FMOV  H10, X6
    FNMUL  H28, H23, H18
    FNMUL  D30, D21, D21
    FSQRT  D0, D16
    FMOV  D29, #15.50000000
    FDIV  S12, S2, S0
    FMOV  H20, W6
    FNMUL  H15, H20, H16
    FMADD  H4, H5, H10, H5
    FMOV  X14, H4
    FABS  H24, H15
    FNMSUB  H18, H17, H30, H24
    FSUB  D6, D12, D4
    FMSUB  D21, D6, D19, D2
    FNEG  S16, S21
    FNMUL  S24, S29, S7
    FMOV  S1, W19
    FSUB  H0, H18, H25
    FNMUL  H21, H1, H2
    FNEG  H1, H16
    FMOV  X11, H31
    FSUB  H7, H3, H3
    FMADD  D2, D1, D24, D23
    FSUB  D3, D2, D7
    FMUL  D1, D29, D21
    FMOV  H31, H28
    FNMUL  H18, H17, H1
    FDIV  H12, H3, H30
    FMOV  D7, D12
    FSQRT  H12, H2
    FMSUB  H20, H7, H8, H18
    SUBS  X22, X22, #0x1
    B.NE  EnhanceFloatP01_label_2
    ISB  SY
    FADD  D28, D5, D9
    FADD  S5, S19, S20
    FADD  H16, H24, H5
    FADD  D29, D5, D29
    FADD  S29, S29, S31
    FADD  H15, H0, H16
    FADD  D28, D15, D12
    FADD  S6, S29, S19
    FADD  H19, H3, H1
    FADD  D17, D23, D12
    FADD  S2, S21, S20
    FADD  H24, H25, H30
    FADD  D21, D21, D4
    FADD  S15, S16, S7
    FADD  H30, H21, H30
    FADD  D31, D0, D15
    FADD  S13, S25, S3
    FADD  H7, H2, H14
    FADD  D14, D6, D28
    FADD  S1, S31, S14
    FADD  H5, H30, H1
    FADD  D10, D5, D2
    FADD  S16, S24, S17
    FADD  H25, H16, H7
    FADD  D18, D11, D25
    FADD  S28, S3, S30
    FADD  H5, H18, H31
    FADD  D29, D13, D28
    FADD  S2, S4, S10
    FADD  H23, H17, H2
    MOVZ  X20, #0x67de, LSL #0
    MOVK  X20, #0x12a8, LSL #16
    MOVK  X20, #0x565a, LSL #32
    MOVK  X20, #0x6124, LSL #48
    SUB  X7, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x2b0d, LSL #0
    MOVK  X20, #0xd77a, LSL #16
    MOVK  X20, #0x5ef8, LSL #32
    MOVK  X20, #0x4cc9, LSL #48
    SUB  X7, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff80, LSL #16
    SUB  X7, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x9cd7, LSL #0
    MOVK  X20, #0xf6fd, LSL #16
    MOVK  X20, #0xc5e3, LSL #32
    MOVK  X20, #0x48e4, LSL #48
    SUB  X7, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x5a79, LSL #0
    MOVK  X20, #0x115d, LSL #16
    MOVK  X20, #0x2d8a, LSL #32
    MOVK  X20, #0x56c6, LSL #48
    SUB  X7, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x7217, LSL #0
    MOVK  X20, #0xe1d1, LSL #16
    MOVK  X20, #0xb405, LSL #32
    MOVK  X20, #0xf1d6, LSL #48
    SUB  X7, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7ff0, LSL #48
    SUB  X7, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x7e00, LSL #0
    SUB  X7, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x209f, LSL #0
    MOVK  X20, #0x2a18, LSL #16
    MOVK  X20, #0x4791, LSL #32
    MOVK  X20, #0x3686, LSL #48
    SUB  X7, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x7bff, LSL #0
    SUB  X7, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xdccd, LSL #0
    MOVK  X20, #0x66cf, LSL #16
    MOVK  X20, #0xe74a, LSL #32
    MOVK  X20, #0x4c8f, LSL #48
    SUB  X7, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x329b, LSL #0
    MOVK  X20, #0xd46e, LSL #16
    MOVK  X20, #0x65, LSL #32
    MOVK  X20, #0xc02d, LSL #48
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x7b84, LSL #0
    MOVK  X20, #0xe634, LSL #16
    MOVK  X20, #0x5206, LSL #32
    MOVK  X20, #0xd39c, LSL #48
    SUB  X7, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x7793, LSL #0
    MOVK  X20, #0xbd0, LSL #16
    MOVK  X20, #0x9073, LSL #32
    MOVK  X20, #0xed0f, LSL #48
    SUB  X7, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xc00c, LSL #0
    MOVK  X20, #0x94cd, LSL #16
    MOVK  X20, #0x60da, LSL #32
    MOVK  X20, #0x51e1, LSL #48
    SUB  X7, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x89a4, LSL #0
    MOVK  X20, #0xa015, LSL #16
    MOVK  X20, #0x7758, LSL #32
    MOVK  X20, #0x2cc1, LSL #48
    SUB  X7, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xcdcf, LSL #0
    MOVK  X20, #0x1b7f, LSL #16
    MOVK  X20, #0x8931, LSL #32
    MOVK  X20, #0xa461, LSL #48
    SUB  X7, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x82fa, LSL #0
    MOVK  X20, #0xadff, LSL #16
    MOVK  X20, #0xe161, LSL #32
    MOVK  X20, #0x174b, LSL #48
    SUB  X7, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MRS  X20, FPCR
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x6e2, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MRS  X20, FPSR
    MOVZ  X7, #0x1f, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D0
    MOVZ  X7, #0xda78, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D1
    MOVZ  X7, #0xd478, LSL #0
    MOVK  X7, #0x2, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D2
    MOVZ  X7, #0x34ee, LSL #0
    MOVK  X7, #0x2, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D3
    MOVZ  X7, #0x8000, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D4
    MOVZ  X7, #0x7bff, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D5
    MOVZ  X7, #0xd678, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D7
    MOVZ  X7, #0xdc8c, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D8
    MOVZ  X7, #0x5a78, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D9
    MOVZ  X7, #0x5e69, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D10
    MOVZ  X7, #0xb8ef, LSL #0
    MOVK  X7, #0x1, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X7, #0x209f, LSL #0
    MOVK  X7, #0x2a18, LSL #16
    MOVK  X7, #0x4791, LSL #32
    MOVK  X7, #0x3686, LSL #48
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D11
    MOVZ  X7, #0x8193, LSL #0
    MOVK  X7, #0x7ed2, LSL #16
    MOVK  X7, #0x7e3a, LSL #32
    MOVK  X7, #0xc1c1, LSL #48
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D12
    MOVZ  X7, #0x8000, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D13
    MOVZ  X7, #0x5a78, LSL #0
    MOVK  X7, #0x115d, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D14
    MOVZ  X7, #0xfe00, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D15
    MOVZ  X7, #0xfc00, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D16
    MOVZ  X7, #0x5a78, LSL #0
    MOVK  X7, #0x1, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D17
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x1, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D18
    MOVZ  X7, #0x8192, LSL #0
    MOVK  X7, #0x7ed2, LSL #16
    MOVK  X7, #0x7e3a, LSL #32
    MOVK  X7, #0xc1c1, LSL #48
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D19
    MOVZ  X7, #0xb97a, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D20
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D21
    MOVZ  X7, #0xda8b, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D22
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D23
    MOVZ  X7, #0x34ee, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D24
    MOVZ  X7, #0x5a78, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D25
    MOVZ  X7, #0xd540, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D26
    MOVZ  X7, #0x5e69, LSL #0
    MOVK  X7, #0xffcd, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D27
    MOVZ  X7, #0x5a78, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D28
    MOVZ  X7, #0x5a8b, LSL #0
    MOVK  X7, #0x1, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D29
    MOVZ  X7, #0xb503, LSL #0
    MOVK  X7, #0x115e, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D30
    MOVZ  X7, #0xda8b, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    FMOV  X20, D31
    MOVZ  X7, #0xd678, LSL #0
    MOVK  X7, #0x1, LSL #16
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xe81d, LSL #0
    MOVK  X2, #0x5600, LSL #16
    MOVK  X2, #0x95ae, LSL #32
    MOVK  X2, #0x75ae, LSL #48
    MOVZ  X3, #0x90f4, LSL #0
    MOVK  X3, #0xda46, LSL #16
    MOVK  X3, #0xf19, LSL #32
    MOVK  X3, #0x378b, LSL #48
    MOVZ  X4, #0xc54d, LSL #0
    MOVK  X4, #0x17bb, LSL #16
    MOVK  X4, #0x29d4, LSL #32
    MOVK  X4, #0x5f80, LSL #48
    MOVZ  X5, #0x3e88, LSL #0
    MOVK  X5, #0x7dd9, LSL #16
    MOVK  X5, #0x8c35, LSL #32
    MOVK  X5, #0xe379, LSL #48
    MOVZ  X6, #0x1b64, LSL #0
    MOVK  X6, #0xb713, LSL #16
    MOVK  X6, #0xf1c5, LSL #32
    MOVK  X6, #0x1011, LSL #48
    MOVZ  X7, #0xbd30, LSL #0
    MOVK  X7, #0x7a16, LSL #16
    MOVK  X7, #0xdaa9, LSL #32
    MOVK  X7, #0x9c01, LSL #48
    MOVZ  X8, #0xe79d, LSL #0
    MOVK  X8, #0x1058, LSL #16
    MOVK  X8, #0x7ada, LSL #32
    MOVK  X8, #0xa3ab, LSL #48
    MOVZ  X9, #0x6361, LSL #0
    MOVK  X9, #0x57c2, LSL #16
    MOVK  X9, #0x4f9f, LSL #32
    MOVK  X9, #0x4eeb, LSL #48
    MOVZ  X10, #0x883c, LSL #0
    MOVK  X10, #0xf2b7, LSL #16
    MOVK  X10, #0x2e99, LSL #32
    MOVK  X10, #0x228f, LSL #48
    MOVZ  X11, #0x91fa, LSL #0
    MOVK  X11, #0xabb9, LSL #16
    MOVK  X11, #0x6837, LSL #32
    MOVK  X11, #0x17f6, LSL #48
    MOVZ  X12, #0x7cd6, LSL #0
    MOVK  X12, #0xaf02, LSL #16
    MOVK  X12, #0xbeef, LSL #32
    MOVK  X12, #0xe50a, LSL #48
    MOVZ  X13, #0x1286, LSL #0
    MOVK  X13, #0xa898, LSL #16
    MOVK  X13, #0xd556, LSL #32
    MOVK  X13, #0xfccc, LSL #48
    MOVZ  X14, #0xb62e, LSL #0
    MOVK  X14, #0x332d, LSL #16
    MOVK  X14, #0xa87b, LSL #32
    MOVK  X14, #0xd782, LSL #48
    MOVZ  X15, #0xd6a6, LSL #0
    MOVK  X15, #0x7575, LSL #16
    MOVK  X15, #0x4dbe, LSL #32
    MOVK  X15, #0x1730, LSL #48
    MOVZ  X16, #0xbf8, LSL #0
    MOVK  X16, #0x8ac9, LSL #16
    MOVK  X16, #0xd84c, LSL #32
    MOVK  X16, #0x4be5, LSL #48
    MOVZ  X17, #0xd1ee, LSL #0
    MOVK  X17, #0x3cd7, LSL #16
    MOVK  X17, #0xaff1, LSL #32
    MOVK  X17, #0x467f, LSL #48
    MOVZ  X18, #0x21f9, LSL #0
    MOVK  X18, #0xabab, LSL #16
    MOVK  X18, #0x6574, LSL #32
    MOVK  X18, #0xca90, LSL #48
    MOVZ  X19, #0x6ec9, LSL #0
    MOVK  X19, #0x75fd, LSL #16
    MOVK  X19, #0xcf, LSL #32
    MOVK  X19, #0xf839, LSL #48
    MOVZ  X20, #0x95d0, LSL #0
    MOVK  X20, #0x2cb9, LSL #16
    MOVK  X20, #0xa081, LSL #32
    MOVK  X20, #0x597b, LSL #48
    MOVZ  X21, #0x6185, LSL #0
    MOVK  X21, #0x685, LSL #16
    MOVK  X21, #0xabe1, LSL #32
    MOVK  X21, #0xed86, LSL #48
    MOVZ  X22, #0x3b9b, LSL #0
    MOVK  X22, #0x1283, LSL #16
    MOVK  X22, #0xbd3f, LSL #32
    MOVK  X22, #0x624e, LSL #48
    MOVZ  X23, #0x6c12, LSL #0
    MOVK  X23, #0xe8fa, LSL #16
    MOVK  X23, #0xfdf4, LSL #32
    MOVK  X23, #0x6e78, LSL #48
    MOVZ  X27, #0xa73, LSL #0
    MOVK  X27, #0x51d2, LSL #16
    MOVK  X27, #0x2c14, LSL #32
    MOVK  X27, #0xb53e, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X8
    FMOV  D1, X22
    FMOV  V1.D[1], X2
    FMOV  D2, X7
    FMOV  V2.D[1], X21
    FMOV  D3, X23
    FMOV  V3.D[1], X2
    FMOV  D4, X19
    FMOV  V4.D[1], X20
    FMOV  D5, X17
    FMOV  V5.D[1], X16
    FMOV  D6, X12
    FMOV  V6.D[1], X12
    FMOV  D7, X6
    FMOV  V7.D[1], X6
    FMOV  D8, X3
    FMOV  V8.D[1], X22
    FMOV  D9, X12
    FMOV  V9.D[1], X9
    FMOV  D10, X19
    FMOV  V10.D[1], X21
    FMOV  D11, X19
    FMOV  V11.D[1], X13
    FMOV  D12, X27
    FMOV  V12.D[1], X11
    FMOV  D13, X14
    FMOV  V13.D[1], X17
    FMOV  D14, X12
    FMOV  V14.D[1], X20
    FMOV  D15, X14
    FMOV  V15.D[1], X19
    FMOV  D16, X8
    FMOV  V16.D[1], X16
    FMOV  D17, X23
    FMOV  V17.D[1], X23
    FMOV  D18, X14
    FMOV  V18.D[1], X6
    FMOV  D19, X15
    FMOV  V19.D[1], X27
    FMOV  D20, X18
    FMOV  V20.D[1], X5
    FMOV  D21, X8
    FMOV  V21.D[1], X4
    FMOV  D22, X3
    FMOV  V22.D[1], X3
    FMOV  D23, X27
    FMOV  V23.D[1], X18
    FMOV  D24, X21
    FMOV  V24.D[1], X17
    FMOV  D25, X18
    FMOV  V25.D[1], X22
    FMOV  D26, X17
    FMOV  V26.D[1], X12
    FMOV  D27, X3
    FMOV  V27.D[1], X19
    FMOV  D28, X2
    FMOV  V28.D[1], X23
    FMOV  D29, X14
    FMOV  V29.D[1], X23
    FMOV  D30, X13
    FMOV  V30.D[1], X9
    FMOV  D31, X2
    FMOV  V31.D[1], X10
    MOVZ  X7, #0xa, LSL #0
EnhanceFloatP01_label_3:
    FMSUB  H25, H17, H22, H26
    FNEG  S2, S27
    FMOV  X10, H24
    FSQRT  S2, S29
    FMUL  H27, H28, H31
    FMOV  H5, W5
    FMUL  S3, S2, S15
    FMOV  H13, H3
    FMOV  H17, W5
    FNMUL  S6, S5, S13
    FNMUL  S18, S27, S3
    FMOV  D3, D25
    FNMUL  S29, S17, S6
    FSUB  S9, S18, S30
    FMUL  D21, D21, D3
    FMOV  D25, #15.00000000
    FMADD  H17, H18, H28, H25
    FNMSUB  S15, S29, S30, S4
    FNMADD  H24, H0, H21, H15
    FCSEL  H2, H9, H17, CS
    FCSEL  D5, D16, D18, LS
    FCSEL  D17, D2, D31, VS
    FMOV  W5, H23
    FDIV  H29, H31, H17
    FABS  S13, S12
    FADD  S6, S5, S13
    FMOV  D22, X7
    FMOV  X12, H29
    FMOV  D29, X27
    FCSEL  S26, S7, S17, GE
    FCSEL  H21, H1, H27, NE
    FNMSUB  S17, S31, S21, S18
    FADD  D7, D26, D15
    FMOV  D31, X8
    FNMUL  S12, S23, S21
    FNMSUB  H15, H17, H18, H0
    FMOV  D13, D15
    FMOV  S30, S20
    FMOV  S28, W7
    FNMUL  H15, H7, H31
    FMADD  H5, H15, H23, H12
    FNMUL  H24, H6, H28
    FMUL  H15, H1, H30
    FMOV  H6, W14
    FMOV  D26, #-1.87500000
    FMOV  S31, #-26.00000000
    FMADD  S19, S24, S15, S6
    FSQRT  D6, D31
    FMOV  W11, H5
    FMOV  H13, H19
    FMOV  S23, W10
    FCSEL  H30, H23, H0, PL
    FNEG  S4, S26
    FCSEL  D17, D29, D0, VC
    FMUL  S26, S15, S13
    FMOV  H31, X3
    FNMADD  D1, D6, D12, D6
    FABS  H25, H22
    FNEG  S13, S26
    FNMUL  S18, S30, S13
    FMUL  H0, H27, H18
    FMOV  D24, X27
    FDIV  S19, S17, S25
    FSQRT  D23, D20
    FMOV  W5, S24
    FNMUL  S17, S4, S18
    FSUB  S24, S18, S17
    FNEG  D20, D1
    FNMSUB  D27, D20, D20, D0
    FMOV  W20, S31
    FADD  S0, S23, S27
    FDIV  S29, S0, S29
    FABS  S12, S11
    FMADD  D6, D29, D30, D29
    FMOV  S31, W11
    FNMSUB  H30, H10, H19, H19
    FMOV  S1, #11.50000000
    FDIV  H4, H5, H1
    FMOV  S17, #27.00000000
    FMOV  D17, #1.93750000
    FMOV  H25, W23
    FMOV  D18, D12
    FMOV  D27, #6.75000000
    FNEG  H20, H10
    FDIV  S23, S17, S31
    FMSUB  D0, D23, D18, D20
    FMOV  X5, H5
    FNEG  S25, S11
    FCSEL  D24, D22, D27, HI
    FMUL  S19, S24, S14
    FSQRT  S12, S21
    FNMUL  S16, S14, S25
    FMSUB  S15, S12, S28, S30
    FMOV  H21, W16
    FADD  D22, D14, D2
    FABS  H23, H16
    FCSEL  H11, H10, H21, GE
    FMADD  D22, D0, D15, D1
    FMOV  D15, D22
    FMOV  H1, X27
    SUBS  X7, X7, #0x1
    B.NE  EnhanceFloatP01_label_3
    FDIV  D1, D17, D19
    FDIV  S16, S1, S27
    FDIV  H0, H16, H23
    FDIV  D11, D15, D12
    FDIV  S16, S0, S10
    FDIV  H10, H30, H16
    FDIV  D8, D10, D11
    FDIV  S15, S1, S12
    FDIV  H1, H19, H29
    FDIV  D12, D18, D22
    FDIV  S27, S1, S6
    FDIV  H28, H30, H20
    FDIV  D18, D16, D22
    FDIV  S16, S13, S15
    FDIV  H13, H5, H14
    FDIV  D28, D27, D14
    FDIV  S29, S30, S0
    FDIV  H25, H23, H3
    FDIV  D10, D27, D2
    FDIV  S5, S13, S8
    FDIV  H26, H16, H13
    FDIV  D23, D5, D26
    FDIV  S15, S23, S29
    FDIV  H8, H0, H24
    FDIV  D14, D25, D10
    FDIV  S27, S28, S30
    FDIV  H11, H27, H14
    FDIV  D28, D11, D15
    FDIV  S6, S14, S8
    FDIV  H30, H3, H29
    FDIV  D14, D6, D28
    FDIV  S31, S24, S30
    FDIV  H22, H31, H31
    FDIV  D6, D26, D14
    FDIV  S19, S22, S6
    FDIV  H8, H3, H19
    FDIV  D2, D30, D14
    FDIV  S31, S2, S2
    FDIV  H27, H31, H14
    FDIV  D3, D8, D14
    FDIV  S1, S18, S3
    FDIV  H8, H18, H27
    FDIV  D26, D6, D16
    FDIV  S5, S5, S30
    FDIV  H28, H20, H7
    FDIV  D22, D9, D19
    FDIV  S29, S23, S10
    FDIV  H31, H12, H13
    FDIV  D24, D16, D14
    FDIV  S9, S29, S6
    FDIV  H11, H5, H21
    FDIV  D16, D8, D28
    FDIV  S3, S22, S9
    FDIV  H7, H3, H25
    FDIV  D30, D2, D13
    FDIV  S20, S24, S2
    FDIV  H18, H30, H29
    FDIV  D3, D31, D20
    FDIV  S8, S18, S26
    FDIV  H21, H1, H16
    FDIV  D5, D21, D16
    FDIV  S31, S24, S3
    FDIV  H16, H5, H5
    FDIV  D28, D23, D8
    FDIV  S26, S7, S31
    FDIV  H23, H7, H27
    FDIV  D18, D2, D28
    FDIV  S25, S16, S8
    FDIV  H22, H25, H18
    FDIV  D28, D20, D24
    FDIV  S7, S17, S26
    FDIV  H17, H7, H22
    FDIV  D24, D1, D23
    FDIV  S13, S14, S17
    FDIV  H2, H11, H11
    FDIV  D16, D19, D24
    FDIV  S21, S5, S28
    FDIV  H5, H2, H13
    FDIV  D1, D5, D23
    FDIV  S5, S21, S20
    FDIV  H30, H7, H1
    FDIV  D22, D16, D22
    FDIV  S23, S16, S5
    FDIV  H1, H2, H6
    FDIV  D17, D1, D30
    FDIV  S24, S17, S23
    FDIV  H8, H16, H17
    FDIV  D3, D16, D29
    FDIV  S27, S25, S1
    FDIV  H23, H23, H26
    MOVZ  X2, #0x90f4, LSL #0
    MOVK  X2, #0xda46, LSL #16
    MOVK  X2, #0xf19, LSL #32
    MOVK  X2, #0x378b, LSL #48
    SUB  X19, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xc54d, LSL #0
    MOVK  X2, #0x17bb, LSL #16
    MOVK  X2, #0x29d4, LSL #32
    MOVK  X2, #0x5f80, LSL #48
    SUB  X19, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x1b64, LSL #0
    MOVK  X2, #0xb713, LSL #16
    MOVK  X2, #0xf1c5, LSL #32
    MOVK  X2, #0x1011, LSL #48
    SUB  X19, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xe79d, LSL #0
    MOVK  X2, #0x1058, LSL #16
    MOVK  X2, #0x7ada, LSL #32
    MOVK  X2, #0xa3ab, LSL #48
    SUB  X19, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x6361, LSL #0
    MOVK  X2, #0x57c2, LSL #16
    MOVK  X2, #0x4f9f, LSL #32
    MOVK  X2, #0x4eeb, LSL #48
    SUB  X19, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x2, LSL #0
    SUB  X19, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x7e00, LSL #0
    SUB  X19, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x1286, LSL #0
    MOVK  X2, #0xa898, LSL #16
    MOVK  X2, #0xd556, LSL #32
    MOVK  X2, #0xfccc, LSL #48
    SUB  X19, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xb62e, LSL #0
    MOVK  X2, #0x332d, LSL #16
    MOVK  X2, #0xa87b, LSL #32
    MOVK  X2, #0xd782, LSL #48
    SUB  X19, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xd6a6, LSL #0
    MOVK  X2, #0x7575, LSL #16
    MOVK  X2, #0x4dbe, LSL #32
    MOVK  X2, #0x1730, LSL #48
    SUB  X19, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xbf8, LSL #0
    MOVK  X2, #0x8ac9, LSL #16
    MOVK  X2, #0xd84c, LSL #32
    MOVK  X2, #0x4be5, LSL #48
    SUB  X19, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xd1ee, LSL #0
    MOVK  X2, #0x3cd7, LSL #16
    MOVK  X2, #0xaff1, LSL #32
    MOVK  X2, #0x467f, LSL #48
    SUB  X19, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x21f9, LSL #0
    MOVK  X2, #0xabab, LSL #16
    MOVK  X2, #0x6574, LSL #32
    MOVK  X2, #0xca90, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x90f4, LSL #0
    SUB  X19, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x3b9b, LSL #0
    MOVK  X2, #0x1283, LSL #16
    MOVK  X2, #0xbd3f, LSL #32
    MOVK  X2, #0x624e, LSL #48
    SUB  X19, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x6c12, LSL #0
    MOVK  X2, #0xe8fa, LSL #16
    MOVK  X2, #0xfdf4, LSL #32
    MOVK  X2, #0x6e78, LSL #48
    SUB  X19, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xa73, LSL #0
    MOVK  X2, #0x51d2, LSL #16
    MOVK  X2, #0x2c14, LSL #32
    MOVK  X2, #0xb53e, LSL #48
    SUB  X19, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MRS  X2, FPCR
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x6e2, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    MRS  X2, FPSR
    MOVZ  X19, #0x1f, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D0
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D1
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D2
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D3
    MOVZ  X19, #0xf7fb, LSL #0
    MOVK  X19, #0xdfef, LSL #16
    MOVK  X19, #0x7fbf, LSL #32
    MOVK  X19, #0x3edf, LSL #48
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D4
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D5
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D6
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff0, LSL #48
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D7
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D8
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D9
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xff80, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D10
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff0, LSL #48
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D11
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D12
    MOVZ  X19, #0x97bc, LSL #0
    MOVK  X19, #0xf35d, LSL #16
    MOVK  X19, #0x2dc0, LSL #32
    MOVK  X19, #0x3efb, LSL #48
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D15
    MOVZ  X19, #0x7df7, LSL #0
    MOVK  X19, #0xf7df, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D16
    MOVZ  X19, #0x7dc0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D17
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x3ff0, LSL #48
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D18
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff0, LSL #48
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D19
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7f80, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D20
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D21
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D22
    MOVZ  X19, #0xbefb, LSL #0
    MOVK  X19, #0xfbef, LSL #16
    MOVK  X19, #0xefbe, LSL #32
    MOVK  X19, #0x3fef, LSL #48
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D23
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D24
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D26
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xff80, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D29
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xff80, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D30
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    FMOV  X2, D31
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xde6b, LSL #0
    MOVK  X2, #0x2730, LSL #16
    MOVK  X2, #0x6609, LSL #32
    MOVK  X2, #0x339e, LSL #48
    MOVZ  X3, #0xca79, LSL #0
    MOVK  X3, #0x747b, LSL #16
    MOVK  X3, #0x1560, LSL #32
    MOVK  X3, #0x1ce, LSL #48
    MOVZ  X4, #0xe827, LSL #0
    MOVK  X4, #0xecd0, LSL #16
    MOVK  X4, #0xe31a, LSL #32
    MOVK  X4, #0xdf14, LSL #48
    MOVZ  X5, #0x7a70, LSL #0
    MOVK  X5, #0x9242, LSL #16
    MOVK  X5, #0xe543, LSL #32
    MOVK  X5, #0xe25c, LSL #48
    MOVZ  X6, #0xfbbd, LSL #0
    MOVK  X6, #0xbaa0, LSL #16
    MOVK  X6, #0x92af, LSL #32
    MOVK  X6, #0x3993, LSL #48
    MOVZ  X7, #0xf485, LSL #0
    MOVK  X7, #0x541b, LSL #16
    MOVK  X7, #0xafa, LSL #32
    MOVK  X7, #0x5cbe, LSL #48
    MOVZ  X8, #0xb106, LSL #0
    MOVK  X8, #0xdd6d, LSL #16
    MOVK  X8, #0x7f94, LSL #32
    MOVK  X8, #0x4bec, LSL #48
    MOVZ  X9, #0x5290, LSL #0
    MOVK  X9, #0xd53a, LSL #16
    MOVK  X9, #0x1dde, LSL #32
    MOVK  X9, #0x29e3, LSL #48
    MOVZ  X10, #0xaf2c, LSL #0
    MOVK  X10, #0x24a4, LSL #16
    MOVK  X10, #0x3b7f, LSL #32
    MOVK  X10, #0x24bc, LSL #48
    MOVZ  X11, #0xda26, LSL #0
    MOVK  X11, #0x68d7, LSL #16
    MOVK  X11, #0x4bfc, LSL #32
    MOVK  X11, #0x7ab6, LSL #48
    MOVZ  X12, #0xc68, LSL #0
    MOVK  X12, #0xf53, LSL #16
    MOVK  X12, #0xf12a, LSL #32
    MOVK  X12, #0x4efe, LSL #48
    MOVZ  X13, #0x97f3, LSL #0
    MOVK  X13, #0xab98, LSL #16
    MOVK  X13, #0x953b, LSL #32
    MOVK  X13, #0xad53, LSL #48
    MOVZ  X14, #0x90f5, LSL #0
    MOVK  X14, #0x47dc, LSL #16
    MOVK  X14, #0x90f, LSL #32
    MOVK  X14, #0x427, LSL #48
    MOVZ  X15, #0x98c1, LSL #0
    MOVK  X15, #0x1650, LSL #16
    MOVK  X15, #0xf2bf, LSL #32
    MOVK  X15, #0xd5a9, LSL #48
    MOVZ  X16, #0x2b96, LSL #0
    MOVK  X16, #0x5a15, LSL #16
    MOVK  X16, #0x1e0c, LSL #32
    MOVK  X16, #0x51e8, LSL #48
    MOVZ  X17, #0xf74d, LSL #0
    MOVK  X17, #0x175, LSL #16
    MOVK  X17, #0xa09d, LSL #32
    MOVK  X17, #0xa297, LSL #48
    MOVZ  X18, #0x1344, LSL #0
    MOVK  X18, #0x7a52, LSL #16
    MOVK  X18, #0x1895, LSL #32
    MOVK  X18, #0x66d, LSL #48
    MOVZ  X19, #0xfc4b, LSL #0
    MOVK  X19, #0xf564, LSL #16
    MOVK  X19, #0xd608, LSL #32
    MOVK  X19, #0xc5ac, LSL #48
    MOVZ  X20, #0x673a, LSL #0
    MOVK  X20, #0x244b, LSL #16
    MOVK  X20, #0x4c8c, LSL #32
    MOVK  X20, #0x6af7, LSL #48
    MOVZ  X21, #0x93ab, LSL #0
    MOVK  X21, #0xe69e, LSL #16
    MOVK  X21, #0x8771, LSL #32
    MOVK  X21, #0xf84d, LSL #48
    MOVZ  X22, #0x90a6, LSL #0
    MOVK  X22, #0xa35b, LSL #16
    MOVK  X22, #0x898d, LSL #32
    MOVK  X22, #0xa0cf, LSL #48
    MOVZ  X23, #0x9395, LSL #0
    MOVK  X23, #0xe129, LSL #16
    MOVK  X23, #0xb9b7, LSL #32
    MOVK  X23, #0x47, LSL #48
    MOVZ  X27, #0xb7f4, LSL #0
    MOVK  X27, #0x1, LSL #16
    MOVK  X27, #0xd444, LSL #32
    MOVK  X27, #0x943b, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X23
    FMOV  D1, X27
    FMOV  V1.D[1], X20
    FMOV  D2, X23
    FMOV  V2.D[1], X3
    FMOV  D3, X18
    FMOV  V3.D[1], X22
    FMOV  D4, X20
    FMOV  V4.D[1], X2
    FMOV  D5, X8
    FMOV  V5.D[1], X2
    FMOV  D6, X21
    FMOV  V6.D[1], X19
    FMOV  D7, X14
    FMOV  V7.D[1], X12
    FMOV  D8, X12
    FMOV  V8.D[1], X19
    FMOV  D9, X22
    FMOV  V9.D[1], X2
    FMOV  D10, X10
    FMOV  V10.D[1], X12
    FMOV  D11, X16
    FMOV  V11.D[1], X8
    FMOV  D12, X16
    FMOV  V12.D[1], X22
    FMOV  D13, X19
    FMOV  V13.D[1], X5
    FMOV  D14, X20
    FMOV  V14.D[1], X14
    FMOV  D15, X6
    FMOV  V15.D[1], X20
    FMOV  D16, X18
    FMOV  V16.D[1], X21
    FMOV  D17, X10
    FMOV  V17.D[1], X12
    FMOV  D18, X27
    FMOV  V18.D[1], X5
    FMOV  D19, X16
    FMOV  V19.D[1], X12
    FMOV  D20, X19
    FMOV  V20.D[1], X23
    FMOV  D21, X14
    FMOV  V21.D[1], X3
    FMOV  D22, X7
    FMOV  V22.D[1], X14
    FMOV  D23, X15
    FMOV  V23.D[1], X3
    FMOV  D24, X6
    FMOV  V24.D[1], X5
    FMOV  D25, X14
    FMOV  V25.D[1], X19
    FMOV  D26, X9
    FMOV  V26.D[1], X13
    FMOV  D27, X3
    FMOV  V27.D[1], X11
    FMOV  D28, X9
    FMOV  V28.D[1], X9
    FMOV  D29, X18
    FMOV  V29.D[1], X21
    FMOV  D30, X15
    FMOV  V30.D[1], X19
    FMOV  D31, X12
    FMOV  V31.D[1], X27
    MOVZ  X27, #0xa, LSL #0
EnhanceFloatP01_label_4:
    FMADD  H0, H30, H24, H31
    FMOV  W13, H0
    FMOV  S8, #3.62500000
    FMUL  H26, H8, H23
    FMUL  D26, D29, D29
    FMUL  S21, S27, S26
    FNMADD  D23, D20, D28, D25
    FSQRT  D5, D21
    FABS  H18, H5
    FADD  H24, H18, H18
    FMOV  H5, #-0.31250000
    FMUL  D20, D5, D18
    FMSUB  S9, S29, S7, S23
    FCSEL  S23, S24, S18, LS
    FSUB  S17, S20, S20
    FMOV  W18, S12
    FMADD  H11, H14, H11, H25
    FMADD  H25, H23, H17, H21
    FMADD  S20, S2, S11, S19
    FNMADD  D31, D9, D28, D30
    FNEG  H8, H25
    FMUL  S23, S17, S22
    FMUL  D14, D31, D23
    FMOV  D25, D19
    FMOV  D30, D14
    FMOV  S19, S30
    FMOV  X17, H19
    FDIV  H19, H8, H15
    FDIV  D21, D20, D1
    FMOV  X20, H25
    FMOV  S6, #6.50000000
    FNMADD  D25, D6, D17, D6
    FMUL  H20, H19, H19
    FSQRT  D18, D10
    FMADD  H24, H29, H18, H20
    FMOV  S19, W14
    FNMSUB  S2, S24, S25, S23
    FMUL  D1, D8, D10
    FMOV  H31, #5.75000000
    FNMADD  S9, S19, S19, S19
    FDIV  S22, S21, S1
    FMUL  S1, S2, S30
    FNMUL  D17, D19, D27
    FSQRT  S13, S1
    FCSEL  H10, H13, H17, LS
    FDIV  S25, S10, S22
    FNMUL  S17, S9, S31
    FNMADD  S22, S0, S3, S15
    FABS  H7, H24
    FMOV  X21, H2
    FNMADD  H13, H18, H10, H13
    FSQRT  H21, H18
    FMSUB  H10, H24, H25, H26
    FMOV  W7, S20
    FMOV  D15, D23
    FMOV  S24, W18
    FABS  D29, D30
    FSUB  S23, S7, S15
    FCSEL  D8, D5, D23, EQ
    FADD  S14, S24, S10
    FNMSUB  D23, D18, D14, D29
    FABS  D3, D7
    FMOV  W19, H13
    FNEG  H27, H3
    FNEG  H18, H22
    FADD  S20, S23, S15
    FSUB  H19, H21, H5
    FMOV  W14, H27
    FNMUL  S7, S19, S20
    FNMSUB  D21, D8, D7, D17
    FABS  H26, H24
    FNEG  S15, S9
    FDIV  H9, H28, H8
    FNEG  H3, H24
    FMOV  W3, S25
    FADD  D25, D8, D11
    FNMSUB  H27, H24, H20, H23
    FSQRT  S5, S0
    FMOV  S2, S3
    FNMSUB  S0, S30, S2, S18
    FDIV  S30, S26, S0
    FMOV  H7, W17
    FSQRT  S8, S5
    FMOV  H17, X21
    FNEG  S23, S21
    FCSEL  S0, S30, S28, VC
    FNEG  H5, H7
    FNEG  H30, H27
    FMOV  H24, W17
    FNMSUB  D7, D23, D8, D23
    FNMADD  S4, S30, S15, S16
    FMADD  S8, S19, S5, S16
    FNMADD  D18, D24, D24, D8
    FADD  H28, H25, H4
    FCSEL  S27, S17, S17, NV
    FADD  S23, S27, S27
    FMUL  D5, D28, D18
    FMOV  S4, W15
    FNEG  H3, H5
    FNMUL  S14, S0, S0
    SUBS  X27, X27, #0x1
    B.NE  EnhanceFloatP01_label_4
    FDIV  D16, D3, D14
    FDIV  S14, S7, S9
    FDIV  H24, H16, H21
    FDIV  D8, D20, D1
    FDIV  S26, S2, S14
    FDIV  H2, H24, H8
    FDIV  D25, D26, D4
    FDIV  S16, S23, S23
    FDIV  H0, H16, H12
    FDIV  D9, D29, D14
    FDIV  S7, S0, S29
    FDIV  H21, H9, H25
    FDIV  D3, D4, D21
    FDIV  S5, S30, S7
    FDIV  H29, H5, H31
    FDIV  D30, D2, D2
    FDIV  S9, S10, S3
    FDIV  H17, H29, H30
    FDIV  D28, D29, D0
    FDIV  S29, S8, S29
    FDIV  H2, H6, H5
    FDIV  D24, D28, D18
    FDIV  S30, S6, S19
    FDIV  H12, H24, H30
    FDIV  D3, D20, D25
    FDIV  S30, S7, S9
    FDIV  H21, H8, H11
    FDIV  D1, D0, D6
    FDIV  S19, S27, S26
    FDIV  H10, H11, H3
    FDIV  D9, D12, D21
    FDIV  S30, S13, S1
    FDIV  H7, H19, H18
    FDIV  D13, D5, D11
    FDIV  S6, S28, S24
    FDIV  H24, H29, H4
    FDIV  D5, D7, D7
    FDIV  S19, S13, S2
    FDIV  H27, H6, H5
    FDIV  D26, D17, D9
    FDIV  S12, S25, S3
    FDIV  H8, H24, H17
    FDIV  D21, D24, D19
    FDIV  S1, S10, S30
    FDIV  H7, H1, H12
    FDIV  D1, D7, D26
    FDIV  S26, S8, S1
    FDIV  H20, H3, H26
    FDIV  D11, D5, D20
    FDIV  S25, S7, S27
    FDIV  H1, H27, H16
    FDIV  D30, D27, D20
    FDIV  S17, S9, S11
    FDIV  H6, H21, H21
    FDIV  D8, D28, D9
    FDIV  S14, S30, S17
    FDIV  H6, H8, H25
    FDIV  D28, D14, D6
    FDIV  S10, S25, S4
    FDIV  H8, H5, H4
    FDIV  D16, D18, D20
    FDIV  S7, S14, S14
    FDIV  H14, H31, H9
    FDIV  D5, D17, D27
    FDIV  S24, S6, S19
    FDIV  H2, H12, H8
    FDIV  D21, D10, D2
    FDIV  S13, S27, S1
    FDIV  H1, H13, H13
    FDIV  D26, D2, D1
    FDIV  S17, S16, S11
    FDIV  H18, H14, H4
    FDIV  D30, D21, D21
    FDIV  S19, S17, S11
    FDIV  H22, H29, H10
    FDIV  D17, D7, D22
    FDIV  S25, S14, S18
    FDIV  H16, H26, H26
    FDIV  D6, D4, D19
    FDIV  S26, S16, S6
    FDIV  H0, H26, H17
    FDIV  D9, D22, D29
    FDIV  S14, S28, S25
    FDIV  H12, H5, H5
    FDIV  D20, D14, D19
    FDIV  S27, S3, S20
    FDIV  H18, H8, H24
    FDIV  D17, D12, D18
    FDIV  S2, S17, S6
    FDIV  H12, H9, H3
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7fc0, LSL #16
    SUB  X23, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0xe827, LSL #0
    MOVK  X8, #0xecd0, LSL #16
    MOVK  X8, #0xe31a, LSL #32
    MOVK  X8, #0xdf14, LSL #48
    SUB  X23, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x7a70, LSL #0
    MOVK  X8, #0x9242, LSL #16
    MOVK  X8, #0xe543, LSL #32
    MOVK  X8, #0xe25c, LSL #48
    SUB  X23, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0xfbbd, LSL #0
    MOVK  X8, #0xbaa0, LSL #16
    MOVK  X8, #0x92af, LSL #32
    MOVK  X8, #0x3993, LSL #48
    SUB  X23, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x7e00, LSL #0
    SUB  X23, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x5290, LSL #0
    MOVK  X8, #0xd53a, LSL #16
    MOVK  X8, #0x1dde, LSL #32
    MOVK  X8, #0x29e3, LSL #48
    SUB  X23, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0xaf2c, LSL #0
    MOVK  X8, #0x24a4, LSL #16
    MOVK  X8, #0x3b7f, LSL #32
    MOVK  X8, #0x24bc, LSL #48
    SUB  X23, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0xda26, LSL #0
    MOVK  X8, #0x68d7, LSL #16
    MOVK  X8, #0x4bfc, LSL #32
    MOVK  X8, #0x7ab6, LSL #48
    SUB  X23, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0xc68, LSL #0
    MOVK  X8, #0xf53, LSL #16
    MOVK  X8, #0xf12a, LSL #32
    MOVK  X8, #0x4efe, LSL #48
    SUB  X23, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x45c0, LSL #0
    SUB  X23, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0xfe00, LSL #0
    SUB  X23, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x98c1, LSL #0
    MOVK  X8, #0x1650, LSL #16
    MOVK  X8, #0xf2bf, LSL #32
    MOVK  X8, #0xd5a9, LSL #48
    SUB  X23, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x2b96, LSL #0
    MOVK  X8, #0x5a15, LSL #16
    MOVK  X8, #0x1e0c, LSL #32
    MOVK  X8, #0x51e8, LSL #48
    SUB  X23, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x2b96, LSL #0
    MOVK  X8, #0x5a15, LSL #16
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x8000, LSL #0
    SUB  X23, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x393b, LSL #0
    SUB  X23, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x3300, LSL #0
    SUB  X23, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x90a6, LSL #0
    MOVK  X8, #0xa35b, LSL #16
    MOVK  X8, #0x898d, LSL #32
    MOVK  X8, #0xa0cf, LSL #48
    SUB  X23, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, EnhanceFloatP01_TestFail
    MRS  X8, FPCR
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x6e2, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    MRS  X8, FPSR
    MOVZ  X23, #0x1f, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D0
    MOVZ  X23, #0x7c00, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D1
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D2
    MOVZ  X23, #0x34e3, LSL #0
    MOVK  X23, #0x3998, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D4
    MOVZ  X23, #0x98c1, LSL #0
    MOVK  X23, #0x1650, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D5
    MOVZ  X23, #0xe38e, LSL #0
    MOVK  X23, #0x8e38, LSL #16
    MOVK  X23, #0x38e3, LSL #32
    MOVK  X23, #0x40f0, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D6
    MOVZ  X23, #0x2914, LSL #0
    MOVK  X23, #0xa452, LSL #16
    MOVK  X23, #0x5bc6, LSL #32
    MOVK  X23, #0x3fb6, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D7
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D8
    MOVZ  X23, #0x8000, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D9
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D10
    MOVZ  X23, #0x167b, LSL #0
    MOVK  X23, #0x689d, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D11
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D12
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D13
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3f80, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D14
    MOVZ  X23, #0xdef8, LSL #0
    MOVK  X23, #0x8ebb, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D15
    MOVZ  X23, #0xfe00, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D16
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D17
    MOVZ  X23, #0xe79e, LSL #0
    MOVK  X23, #0x9e79, LSL #16
    MOVK  X23, #0x79e7, LSL #32
    MOVK  X23, #0x3fde, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D18
    MOVZ  X23, #0x7e00, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D19
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xff80, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D20
    MOVZ  X23, #0x8542, LSL #0
    MOVK  X23, #0x150a, LSL #16
    MOVK  X23, #0xe06c, LSL #32
    MOVK  X23, #0x3fe1, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D21
    MOVZ  X23, #0xdf7d, LSL #0
    MOVK  X23, #0xcdf7, LSL #16
    MOVK  X23, #0x918b, LSL #32
    MOVK  X23, #0x40ea, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D23
    MOVZ  X23, #0x6600, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D24
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D25
    MOVZ  X23, #0xefbe, LSL #0
    MOVK  X23, #0x3efb, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D26
    MOVZ  X23, #0x7b93, LSL #0
    MOVK  X23, #0x9799, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D28
    MOVZ  X23, #0xe38e, LSL #0
    MOVK  X23, #0x8e38, LSL #16
    MOVK  X23, #0x38e3, LSL #32
    MOVK  X23, #0x40f0, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D29
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D30
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3ff0, LSL #48
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    FMOV  X8, D31
    MOVZ  X23, #0x45c0, LSL #0
    SUB  X2, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xfd90, LSL #0
    MOVK  X2, #0x9ba2, LSL #16
    MOVK  X2, #0x1bb8, LSL #32
    MOVK  X2, #0x58ff, LSL #48
    MOVZ  X3, #0x53a6, LSL #0
    MOVK  X3, #0x7bc2, LSL #16
    MOVK  X3, #0x3d0a, LSL #32
    MOVK  X3, #0xd196, LSL #48
    MOVZ  X4, #0xb92c, LSL #0
    MOVK  X4, #0xa110, LSL #16
    MOVK  X4, #0xd0e8, LSL #32
    MOVK  X4, #0x979, LSL #48
    MOVZ  X5, #0xfbfa, LSL #0
    MOVK  X5, #0xde4b, LSL #16
    MOVK  X5, #0x247f, LSL #32
    MOVK  X5, #0x10e8, LSL #48
    MOVZ  X6, #0x8614, LSL #0
    MOVK  X6, #0xc6d0, LSL #16
    MOVK  X6, #0x7719, LSL #32
    MOVK  X6, #0xacd2, LSL #48
    MOVZ  X7, #0xa94, LSL #0
    MOVK  X7, #0x10fe, LSL #16
    MOVK  X7, #0x3fe2, LSL #32
    MOVK  X7, #0x6cd9, LSL #48
    MOVZ  X8, #0xd0f6, LSL #0
    MOVK  X8, #0x5c7f, LSL #16
    MOVK  X8, #0x2f55, LSL #32
    MOVK  X8, #0x8888, LSL #48
    MOVZ  X9, #0xbff3, LSL #0
    MOVK  X9, #0x8105, LSL #16
    MOVK  X9, #0xe3f8, LSL #32
    MOVK  X9, #0x883e, LSL #48
    MOVZ  X10, #0x78af, LSL #0
    MOVK  X10, #0x2eee, LSL #16
    MOVK  X10, #0x7917, LSL #32
    MOVK  X10, #0x6d1a, LSL #48
    MOVZ  X11, #0xa438, LSL #0
    MOVK  X11, #0xbffe, LSL #16
    MOVK  X11, #0x5bed, LSL #32
    MOVK  X11, #0xe216, LSL #48
    MOVZ  X12, #0x75a5, LSL #0
    MOVK  X12, #0x5f8f, LSL #16
    MOVK  X12, #0x58b6, LSL #32
    MOVK  X12, #0xba49, LSL #48
    MOVZ  X13, #0x6a3f, LSL #0
    MOVK  X13, #0x1f11, LSL #16
    MOVK  X13, #0x407d, LSL #32
    MOVK  X13, #0x2490, LSL #48
    MOVZ  X14, #0xcf4, LSL #0
    MOVK  X14, #0xb5ae, LSL #16
    MOVK  X14, #0x90d0, LSL #32
    MOVK  X14, #0xfc11, LSL #48
    MOVZ  X15, #0xb8e9, LSL #0
    MOVK  X15, #0xcf1a, LSL #16
    MOVK  X15, #0x3637, LSL #32
    MOVK  X15, #0x5c36, LSL #48
    MOVZ  X16, #0x6ce1, LSL #0
    MOVK  X16, #0x5965, LSL #16
    MOVK  X16, #0xa203, LSL #32
    MOVK  X16, #0xa569, LSL #48
    MOVZ  X17, #0x4add, LSL #0
    MOVK  X17, #0xe278, LSL #16
    MOVK  X17, #0xe4ed, LSL #32
    MOVK  X17, #0x760a, LSL #48
    MOVZ  X18, #0x77ee, LSL #0
    MOVK  X18, #0x908d, LSL #16
    MOVK  X18, #0x9c0, LSL #32
    MOVK  X18, #0xc98e, LSL #48
    MOVZ  X19, #0xdf44, LSL #0
    MOVK  X19, #0x8d98, LSL #16
    MOVK  X19, #0xb1cc, LSL #32
    MOVK  X19, #0x80d7, LSL #48
    MOVZ  X20, #0xf6ca, LSL #0
    MOVK  X20, #0xc8c1, LSL #16
    MOVK  X20, #0x8846, LSL #32
    MOVK  X20, #0x10d2, LSL #48
    MOVZ  X21, #0xb08f, LSL #0
    MOVK  X21, #0x4e4, LSL #16
    MOVK  X21, #0xbaeb, LSL #32
    MOVK  X21, #0x600c, LSL #48
    MOVZ  X22, #0x9fdb, LSL #0
    MOVK  X22, #0x83b0, LSL #16
    MOVK  X22, #0xc332, LSL #32
    MOVK  X22, #0xc290, LSL #48
    MOVZ  X23, #0x1bb5, LSL #0
    MOVK  X23, #0x1f90, LSL #16
    MOVK  X23, #0xebf, LSL #32
    MOVK  X23, #0xef23, LSL #48
    MOVZ  X27, #0xb40f, LSL #0
    MOVK  X27, #0x833, LSL #16
    MOVK  X27, #0xfac9, LSL #32
    MOVK  X27, #0x4661, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X10
    FMOV  D1, X19
    FMOV  V1.D[1], X15
    FMOV  D2, X8
    FMOV  V2.D[1], X20
    FMOV  D3, X22
    FMOV  V3.D[1], X23
    FMOV  D4, X23
    FMOV  V4.D[1], X5
    FMOV  D5, X11
    FMOV  V5.D[1], X22
    FMOV  D6, X3
    FMOV  V6.D[1], X6
    FMOV  D7, X17
    FMOV  V7.D[1], X27
    FMOV  D8, X7
    FMOV  V8.D[1], X27
    FMOV  D9, X12
    FMOV  V9.D[1], X22
    FMOV  D10, X4
    FMOV  V10.D[1], X4
    FMOV  D11, X4
    FMOV  V11.D[1], X27
    FMOV  D12, X9
    FMOV  V12.D[1], X23
    FMOV  D13, X3
    FMOV  V13.D[1], X22
    FMOV  D14, X6
    FMOV  V14.D[1], X22
    FMOV  D15, X22
    FMOV  V15.D[1], X13
    FMOV  D16, X13
    FMOV  V16.D[1], X5
    FMOV  D17, X20
    FMOV  V17.D[1], X7
    FMOV  D18, X14
    FMOV  V18.D[1], X21
    FMOV  D19, X18
    FMOV  V19.D[1], X7
    FMOV  D20, X11
    FMOV  V20.D[1], X27
    FMOV  D21, X18
    FMOV  V21.D[1], X8
    FMOV  D22, X16
    FMOV  V22.D[1], X5
    FMOV  D23, X6
    FMOV  V23.D[1], X19
    FMOV  D24, X23
    FMOV  V24.D[1], X14
    FMOV  D25, X19
    FMOV  V25.D[1], X5
    FMOV  D26, X6
    FMOV  V26.D[1], X3
    FMOV  D27, X27
    FMOV  V27.D[1], X9
    FMOV  D28, X21
    FMOV  V28.D[1], X18
    FMOV  D29, X20
    FMOV  V29.D[1], X3
    FMOV  D30, X3
    FMOV  V30.D[1], X4
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X4, #0xa, LSL #0
EnhanceFloatP01_label_5:
    FMUL  S13, S31, S1
    FMSUB  D15, D29, D28, D30
    FCSEL  D29, D23, D25, CS
    FMADD  H15, H27, H19, H13
    FMOV  X23, H15
    FMOV  X14, H26
    FMOV  X17, D20
    FADD  S3, S29, S16
    FNEG  S8, S20
    FABS  H15, H8
    FNMADD  S16, S15, S3, S3
    FMSUB  S20, S21, S15, S16
    FNMSUB  D28, D24, D17, D3
    FNMUL  H25, H24, H8
    FMUL  D23, D30, D0
    FMUL  H7, H1, H12
    FABS  S31, S16
    FMADD  H26, H8, H24, H31
    FMUL  S1, S9, S9
    FSUB  H19, H14, H5
    FMADD  D17, D13, D23, D8
    FMUL  D3, D9, D26
    FNMADD  D4, D28, D18, D11
    FMOV  S0, S10
    FMOV  S2, W3
    FMOV  H21, W4
    FMSUB  D4, D25, D7, D0
    FDIV  S26, S2, S3
    FSUB  D12, D10, D22
    FNMADD  S30, S12, S17, S14
    FSUB  D14, D2, D4
    FMOV  S8, S1
    FNMADD  S17, S13, S20, S8
    FSQRT  S9, S2
    FDIV  S13, S9, S17
    FMSUB  H7, H14, H19, H21
    FCSEL  H20, H19, H20, AL
    FNMSUB  D8, D20, D7, D14
    FNMUL  S4, S30, S8
    FABS  D8, D13
    FMUL  S0, S20, S18
    FMOV  H12, H4
    FABS  H22, H26
    FSQRT  S4, S24
    FNMUL  D27, D12, D12
    FCSEL  D2, D21, D30, HI
    FMOV  S20, #0.24218750
    FSUB  S13, S0, S27
    FMOV  X21, H23
    FNMUL  S27, S8, S23
    FNEG  D13, D7
    FMADD  H17, H26, H8, H13
    FADD  D4, D6, D29
    FSUB  D0, D27, D20
    FNMSUB  S9, S27, S8, S6
    FMUL  D11, D22, D29
    FADD  D18, D4, D16
    FSQRT  S24, S28
    FABS  D26, D18
    FMOV  H30, X12
    FMOV  H1, X12
    FCSEL  H28, H24, H17, NV
    FNMADD  D28, D14, D0, D26
    FMOV  X5, D11
    FNEG  H0, H12
    FABS  H27, H0
    FNEG  D19, D27
    FADD  H4, H0, H25
    FMOV  X13, H26
    FADD  D20, D9, D30
    FMOV  D13, #-1.81250000
    FSUB  H14, H19, H13
    FMSUB  H11, H4, H20, H2
    FNMUL  D12, D28, D1
    FNMADD  D9, D4, D14, D7
    FDIV  S14, S18, S9
    FNMADD  S25, S8, S18, S24
    FSQRT  D18, D25
    FMOV  D30, #-0.56250000
    FMADD  D26, D4, D13, D14
    FMADD  D16, D18, D26, D22
    FSQRT  D9, D16
    FCSEL  D4, D9, D3, NV
    FMOV  H22, H26
    FMADD  H24, H22, H4, H22
    FSQRT  D28, D12
    FABS  D1, D10
    FADD  H13, H3, H11
    FNMUL  D1, D28, D13
    FABS  S20, S13
    FABS  H22, H30
    FSUB  H5, H22, H4
    FMSUB  H3, H22, H24, H1
    FMOV  X9, D20
    FSQRT  D0, D13
    FMUL  S30, S3, S16
    FMOV  D20, #0.14843750
    FDIV  D22, D28, D5
    FMSUB  D24, D0, D20, D19
    FSUB  H12, H24, H30
    SUBS  X4, X4, #0x1
    B.NE  EnhanceFloatP01_label_5
    FDIV  D26, D28, D19
    FDIV  S16, S8, S2
    FDIV  H8, H12, H21
    FDIV  D25, D2, D12
    FDIV  S5, S0, S22
    FDIV  H4, H11, H6
    FDIV  D11, D26, D25
    FDIV  S19, S21, S6
    FDIV  H13, H31, H19
    FDIV  D1, D6, D20
    FDIV  S22, S31, S16
    FDIV  H19, H20, H28
    FDIV  D31, D29, D29
    FDIV  S30, S13, S22
    FDIV  H15, H6, H1
    FDIV  D24, D5, D8
    FDIV  S12, S11, S12
    FDIV  H1, H24, H12
    FDIV  D19, D19, D31
    FDIV  S28, S15, S30
    FDIV  H20, H19, H24
    FDIV  D2, D20, D4
    FDIV  S24, S4, S2
    FDIV  H0, H1, H28
    FDIV  D20, D7, D30
    FDIV  S11, S16, S30
    FDIV  H21, H16, H10
    FDIV  D23, D12, D29
    FDIV  S26, S14, S1
    FDIV  H19, H21, H10
    FDIV  D22, D18, D1
    FDIV  S12, S14, S21
    FDIV  H25, H20, H19
    FDIV  D1, D24, D26
    FDIV  S14, S12, S25
    FDIV  H24, H26, H22
    FDIV  D29, D0, D14
    FDIV  S21, S11, S6
    FDIV  H2, H29, H20
    FDIV  D9, D27, D22
    FDIV  S4, S3, S9
    FDIV  H30, H8, H19
    FDIV  D20, D30, D1
    FDIV  S3, S11, S4
    FDIV  H22, H21, H4
    FDIV  D25, D24, D24
    FDIV  S18, S23, S19
    FDIV  H12, H29, H3
    FDIV  D29, D20, D20
    FDIV  S10, S22, S18
    FDIV  H16, H12, H6
    FDIV  D11, D18, D0
    FDIV  S8, S23, S16
    FDIV  H6, H29, H21
    FDIV  D22, D2, D8
    FDIV  S30, S6, S31
    FDIV  H27, H30, H3
    FDIV  D8, D25, D10
    FDIV  S21, S1, S27
    FDIV  H12, H11, H8
    FDIV  D26, D12, D23
    FDIV  S19, S2, S26
    FDIV  H4, H27, H19
    FDIV  D13, D14, D21
    FDIV  S3, S4, S17
    FDIV  H17, H27, H13
    FDIV  D0, D3, D7
    FDIV  S7, S25, S22
    FDIV  H26, H0, H28
    FDIV  D21, D1, D27
    FDIV  S28, S1, S17
    FDIV  H30, H0, H12
    FDIV  D14, D6, D21
    FDIV  S12, S15, S23
    FDIV  H2, H26, H26
    FDIV  D6, D30, D28
    FDIV  S27, S6, S26
    FDIV  H16, H0, H27
    FDIV  D28, D18, D12
    FDIV  S6, S5, S28
    FDIV  H22, H2, H14
    FDIV  D2, D12, D7
    FDIV  S3, S6, S16
    FDIV  H19, H22, H5
    FDIV  D28, D6, D3
    FDIV  S14, S28, S4
    FDIV  H1, H2, H19
    FDIV  D3, D14, D12
    FDIV  S12, S1, S8
    FDIV  H27, H18, H0
    MOVZ  X18, #0xfd90, LSL #0
    MOVK  X18, #0x9ba2, LSL #16
    MOVK  X18, #0x1bb8, LSL #32
    MOVK  X18, #0x58ff, LSL #48
    SUB  X6, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x53a6, LSL #0
    MOVK  X18, #0x7bc2, LSL #16
    MOVK  X18, #0x3d0a, LSL #32
    MOVK  X18, #0xd196, LSL #48
    SUB  X6, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0xd0f6, LSL #0
    MOVK  X18, #0x5c7f, LSL #16
    MOVK  X18, #0x2f55, LSL #32
    MOVK  X18, #0x8888, LSL #48
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x7bff, LSL #0
    SUB  X6, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x78af, LSL #0
    MOVK  X18, #0x2eee, LSL #16
    MOVK  X18, #0x7917, LSL #32
    MOVK  X18, #0x6d1a, LSL #48
    SUB  X6, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0xa438, LSL #0
    MOVK  X18, #0xbffe, LSL #16
    MOVK  X18, #0x5bed, LSL #32
    MOVK  X18, #0xe216, LSL #48
    SUB  X6, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x75a5, LSL #0
    MOVK  X18, #0x5f8f, LSL #16
    MOVK  X18, #0x58b6, LSL #32
    MOVK  X18, #0xba49, LSL #48
    SUB  X6, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x53a5, LSL #0
    SUB  X6, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x5ffd, LSL #0
    SUB  X6, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0xb8e9, LSL #0
    MOVK  X18, #0xcf1a, LSL #16
    MOVK  X18, #0x3637, LSL #32
    MOVK  X18, #0x5c36, LSL #48
    SUB  X6, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x6ce1, LSL #0
    MOVK  X18, #0x5965, LSL #16
    MOVK  X18, #0xa203, LSL #32
    MOVK  X18, #0xa569, LSL #48
    SUB  X6, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x3fc3, LSL #48
    SUB  X6, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0xdf44, LSL #0
    MOVK  X18, #0x8d98, LSL #16
    MOVK  X18, #0xb1cc, LSL #32
    MOVK  X18, #0x80d7, LSL #48
    SUB  X6, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0xf6ca, LSL #0
    MOVK  X18, #0xc8c1, LSL #16
    MOVK  X18, #0x8846, LSL #32
    MOVK  X18, #0x10d2, LSL #48
    SUB  X6, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x9fdb, LSL #0
    MOVK  X18, #0x83b0, LSL #16
    MOVK  X18, #0xc332, LSL #32
    MOVK  X18, #0xc290, LSL #48
    SUB  X6, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0x7bff, LSL #0
    SUB  X6, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X18, #0xb40f, LSL #0
    MOVK  X18, #0x833, LSL #16
    MOVK  X18, #0xfac9, LSL #32
    MOVK  X18, #0x4661, LSL #48
    SUB  X6, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MRS  X18, FPCR
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x6e2, LSL #16
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MRS  X18, FPSR
    MOVZ  X6, #0x1f, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D0
    MOVZ  X6, #0x8208, LSL #0
    MOVK  X6, #0x820, LSL #16
    MOVK  X6, #0x2082, LSL #32
    MOVK  X6, #0x40e0, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D1
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D2
    MOVZ  X6, #0xfeff, LSL #0
    MOVK  X6, #0xfbfd, LSL #16
    MOVK  X6, #0xeff7, LSL #32
    MOVK  X6, #0x3fef, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D4
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D5
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7f80, LSL #16
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D6
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7f80, LSL #16
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D7
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7fc0, LSL #16
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D8
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0x7fef, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D10
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7fc0, LSL #16
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D11
    MOVZ  X6, #0xef7b, LSL #0
    MOVK  X6, #0xf7bd, LSL #16
    MOVK  X6, #0x7bde, LSL #32
    MOVK  X6, #0x40f0, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D12
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7fc0, LSL #16
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D13
    MOVZ  X6, #0x624, LSL #0
    MOVK  X6, #0x8f31, LSL #16
    MOVK  X6, #0xac0f, LSL #32
    MOVK  X6, #0x3ffe, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D15
    MOVZ  X6, #0xdce9, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D16
    MOVZ  X6, #0x8000, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D17
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D18
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7fc0, LSL #16
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D19
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D20
    MOVZ  X6, #0x7bff, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D21
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0x7fef, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D22
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D23
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff0, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D24
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D25
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3ff0, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D26
    MOVZ  X6, #0xfc00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D27
    MOVZ  X6, #0x8000, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D28
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3ff0, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D29
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3ff0, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D30
    MOVZ  X6, #0x7e00, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    FMOV  X18, D31
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X7, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, EnhanceFloatP01_TestFail
    MOVZ  X2, #0xef61, LSL #0
    MOVK  X2, #0x5a9f, LSL #16
    MOVK  X2, #0x3ecc, LSL #32
    MOVK  X2, #0x44e3, LSL #48
    MOVZ  X3, #0x48a1, LSL #0
    MOVK  X3, #0x57cc, LSL #16
    MOVK  X3, #0xb3b, LSL #32
    MOVK  X3, #0x4cf4, LSL #48
    MOVZ  X4, #0xc28a, LSL #0
    MOVK  X4, #0x905e, LSL #16
    MOVK  X4, #0x5dc2, LSL #32
    MOVK  X4, #0x8962, LSL #48
    MOVZ  X5, #0xe425, LSL #0
    MOVK  X5, #0x1d6a, LSL #16
    MOVK  X5, #0x595f, LSL #32
    MOVK  X5, #0x4d6a, LSL #48
    MOVZ  X6, #0x76ac, LSL #0
    MOVK  X6, #0xc7c4, LSL #16
    MOVK  X6, #0x4b13, LSL #32
    MOVK  X6, #0xe4ac, LSL #48
    MOVZ  X7, #0xbcfe, LSL #0
    MOVK  X7, #0x9247, LSL #16
    MOVK  X7, #0x2285, LSL #32
    MOVK  X7, #0x76c6, LSL #48
    MOVZ  X8, #0x52a4, LSL #0
    MOVK  X8, #0x7440, LSL #16
    MOVK  X8, #0xa3c8, LSL #32
    MOVK  X8, #0xdce0, LSL #48
    MOVZ  X9, #0xa9cd, LSL #0
    MOVK  X9, #0xdd69, LSL #16
    MOVK  X9, #0xd201, LSL #32
    MOVK  X9, #0xfe5b, LSL #48
    MOVZ  X10, #0x7dab, LSL #0
    MOVK  X10, #0x4e1, LSL #16
    MOVK  X10, #0xc148, LSL #32
    MOVK  X10, #0xe067, LSL #48
    MOVZ  X11, #0xe8bc, LSL #0
    MOVK  X11, #0x38d0, LSL #16
    MOVK  X11, #0x1c43, LSL #32
    MOVK  X11, #0x80f6, LSL #48
    MOVZ  X12, #0x55c6, LSL #0
    MOVK  X12, #0x9a25, LSL #16
    MOVK  X12, #0xa215, LSL #32
    MOVK  X12, #0xb07d, LSL #48
    MOVZ  X13, #0x6f8d, LSL #0
    MOVK  X13, #0x7db4, LSL #16
    MOVK  X13, #0x311a, LSL #32
    MOVK  X13, #0xa5b7, LSL #48
    MOVZ  X14, #0x3f3b, LSL #0
    MOVK  X14, #0x7b91, LSL #16
    MOVK  X14, #0xb4e6, LSL #32
    MOVK  X14, #0x4cfe, LSL #48
    MOVZ  X15, #0xf377, LSL #0
    MOVK  X15, #0x82c9, LSL #16
    MOVK  X15, #0xdc6b, LSL #32
    MOVK  X15, #0x50df, LSL #48
    MOVZ  X16, #0x12e, LSL #0
    MOVK  X16, #0xa3c2, LSL #16
    MOVK  X16, #0xa5e9, LSL #32
    MOVK  X16, #0xf3e8, LSL #48
    MOVZ  X17, #0xa4d3, LSL #0
    MOVK  X17, #0xfcd4, LSL #16
    MOVK  X17, #0x9dcd, LSL #32
    MOVK  X17, #0x711b, LSL #48
    MOVZ  X18, #0xd2d7, LSL #0
    MOVK  X18, #0x24e2, LSL #16
    MOVK  X18, #0x10a1, LSL #32
    MOVK  X18, #0x21dd, LSL #48
    MOVZ  X19, #0xa738, LSL #0
    MOVK  X19, #0xfefd, LSL #16
    MOVK  X19, #0xe4e4, LSL #32
    MOVK  X19, #0x5c27, LSL #48
    MOVZ  X20, #0x2f53, LSL #0
    MOVK  X20, #0xc2cc, LSL #16
    MOVK  X20, #0xe09a, LSL #32
    MOVK  X20, #0x2897, LSL #48
    MOVZ  X21, #0xed64, LSL #0
    MOVK  X21, #0xc372, LSL #16
    MOVK  X21, #0xefe3, LSL #32
    MOVK  X21, #0x3ce3, LSL #48
    MOVZ  X22, #0xda20, LSL #0
    MOVK  X22, #0x5052, LSL #16
    MOVK  X22, #0x6d50, LSL #32
    MOVK  X22, #0x4178, LSL #48
    MOVZ  X23, #0x6d8d, LSL #0
    MOVK  X23, #0x16ea, LSL #16
    MOVK  X23, #0x3be8, LSL #32
    MOVK  X23, #0x2512, LSL #48
    MOVZ  X27, #0x9ea0, LSL #0
    MOVK  X27, #0xab97, LSL #16
    MOVK  X27, #0x8564, LSL #32
    MOVK  X27, #0xb8e5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X3
    FMOV  D2, X10
    FMOV  V2.D[1], X11
    FMOV  D3, X20
    FMOV  V3.D[1], X27
    FMOV  D4, X27
    FMOV  V4.D[1], X8
    FMOV  D5, X8
    FMOV  V5.D[1], X16
    FMOV  D6, X13
    FMOV  V6.D[1], X8
    FMOV  D7, X7
    FMOV  V7.D[1], X14
    FMOV  D8, X14
    FMOV  V8.D[1], X21
    FMOV  D9, X5
    FMOV  V9.D[1], X23
    FMOV  D10, X23
    FMOV  V10.D[1], X10
    FMOV  D11, X11
    FMOV  V11.D[1], X6
    FMOV  D12, X7
    FMOV  V12.D[1], X13
    FMOV  D13, X15
    FMOV  V13.D[1], X4
    FMOV  D14, X9
    FMOV  V14.D[1], X27
    FMOV  D15, X11
    FMOV  V15.D[1], X4
    FMOV  D16, X13
    FMOV  V16.D[1], X7
    FMOV  D17, X8
    FMOV  V17.D[1], X9
    FMOV  D18, X9
    FMOV  V18.D[1], X9
    FMOV  D19, X19
    FMOV  V19.D[1], X10
    FMOV  D20, X17
    FMOV  V20.D[1], X4
    FMOV  D21, X9
    FMOV  V21.D[1], X6
    FMOV  D22, X27
    FMOV  V22.D[1], X27
    FMOV  D23, X2
    FMOV  V23.D[1], X23
    FMOV  D24, X19
    FMOV  V24.D[1], X6
    FMOV  D25, X19
    FMOV  V25.D[1], X10
    FMOV  D26, X3
    FMOV  V26.D[1], X14
    FMOV  D27, X6
    FMOV  V27.D[1], X8
    FMOV  D28, X23
    FMOV  V28.D[1], X6
    FMOV  D29, X13
    FMOV  V29.D[1], X8
    FMOV  D30, X14
    FMOV  V30.D[1], X8
    FMOV  D31, X21
    FMOV  V31.D[1], X22
    MOVZ  X14, #0xa, LSL #0
EnhanceFloatP01_label_6:
    FMOV  H5, X9
    FSUB  D9, D26, D23
    FNMSUB  D12, D28, D21, D9
    FMOV  D9, #0.22656250
    FADD  H16, H29, H27
    FMOV  D19, X21
    FNEG  S0, S19
    FSQRT  H17, H4
    FMADD  D1, D16, D22, D25
    FMOV  X20, H27
    FMADD  H25, H31, H31, H0
    FDIV  S19, S2, S17
    FNMADD  S19, S11, S5, S20
    FADD  D11, D9, D8
    FMOV  H2, X14
    FMOV  W2, S11
    FMADD  D29, D19, D25, D19
    FMSUB  S3, S1, S12, S1
    FNMADD  S16, S9, S6, S3
    FNEG  S23, S15
    FSUB  S7, S30, S4
    FMUL  H6, H30, H10
    FADD  S28, S7, S19
    FADD  S8, S30, S23
    FNMSUB  D21, D29, D3, D16
    FMUL  D25, D28, D27
    FMOV  H10, W4
    FNMADD  H26, H21, H25, H6
    FMOV  D30, D26
    FNMSUB  S31, S2, S30, S2
    FMADD  D7, D9, D31, D15
    FMOV  S5, S10
    FNMUL  H23, H8, H18
    FADD  S4, S5, S23
    FMSUB  H17, H26, H28, H4
    FSUB  S11, S11, S10
    FNMUL  D9, D21, D26
    FMOV  H3, #-0.21875000
    FADD  H19, H5, H1
    FNMADD  D27, D6, D20, D19
    FNEG  H10, H28
    FABS  H27, H27
    FDIV  S6, S1, S2
    FMOV  S16, S9
    FNMUL  S26, S28, S30
    FDIV  H3, H19, H26
    FMSUB  S12, S7, S6, S3
    FMOV  D15, X21
    FMOV  X15, H15
    FNMADD  H28, H12, H12, H17
    FNMUL  S9, S11, S14
    FNMADD  D30, D19, D9, D27
    FMOV  H3, #-1.43750000
    FNMUL  D29, D30, D22
    FMSUB  H5, H16, H28, H3
    FDIV  S26, S29, S10
    FDIV  H19, H25, H2
    FNMADD  D14, D24, D15, D22
    FABS  S12, S10
    FCSEL  D17, D28, D6, VC
    FMOV  X10, H21
    FABS  H23, H9
    FMOV  S15, W27
    FMOV  D11, D24
    FMOV  S25, S26
    FCSEL  D3, D5, D15, PL
    FMOV  S29, W10
    FABS  H27, H14
    FMUL  D6, D23, D27
    FMUL  D30, D11, D25
    FMOV  H25, #-7.00000000
    FMOV  H28, W8
    FSUB  D11, D30, D29
    FMUL  D23, D28, D11
    FSUB  H12, H10, H19
    FMOV  S26, #-0.68750000
    FMADD  S19, S6, S17, S6
    FNEG  D10, D5
    FMOV  D14, #1.31250000
    FMOV  X7, D23
    FMUL  D9, D14, D5
    FMOV  H29, #2.25000000
    FABS  H5, H23
    FDIV  S24, S29, S3
    FNEG  D3, D7
    FSUB  D27, D26, D26
    FABS  S7, S25
    FMOV  X16, H30
    FMUL  H17, H19, H19
    FMOV  S15, W7
    FMOV  S23, #-14.50000000
    FMADD  D29, D27, D15, D26
    FNMUL  D25, D22, D9
    FCSEL  S24, S3, S24, LT
    FADD  H14, H29, H26
    FADD  H25, H24, H17
    FMOV  X9, D7
    FABS  S17, S12
    FNMSUB  H15, H17, H31, H5
    FSUB  S19, S25, S19
    SUBS  X14, X14, #0x1
    B.NE  EnhanceFloatP01_label_6
    FSQRT  D31, D14
    FSQRT  S7, S19
    FSQRT  H3, H29
    FSQRT  D17, D14
    FSQRT  S6, S5
    FSQRT  H14, H15
    FSQRT  D15, D31
    FSQRT  S5, S14
    FSQRT  H9, H10
    FSQRT  D25, D5
    FSQRT  S16, S1
    FSQRT  H1, H6
    FSQRT  D19, D12
    FSQRT  S15, S7
    FSQRT  H7, H23
    FSQRT  D31, D19
    FSQRT  S24, S7
    FSQRT  H23, H29
    FSQRT  D6, D1
    FSQRT  S22, S25
    FSQRT  H10, H22
    FSQRT  D1, D7
    FSQRT  S7, S10
    FSQRT  H19, H1
    FSQRT  D2, D20
    FSQRT  S3, S16
    FSQRT  H28, H23
    FSQRT  D14, D15
    FSQRT  S23, S7
    FSQRT  H10, H28
    FSQRT  D18, D10
    FSQRT  S5, S21
    FSQRT  H21, H14
    FSQRT  D7, D24
    FSQRT  S25, S19
    FSQRT  H28, H22
    FSQRT  D22, D19
    FSQRT  S19, S15
    FSQRT  H10, H23
    FSQRT  D5, D5
    FSQRT  S20, S15
    FSQRT  H22, H7
    FSQRT  D1, D21
    FSQRT  S2, S28
    FSQRT  H21, H2
    FSQRT  D24, D10
    FSQRT  S10, S18
    FSQRT  H15, H1
    FSQRT  D15, D7
    FSQRT  S13, S22
    FSQRT  H14, H13
    FSQRT  D28, D15
    FSQRT  S22, S20
    FSQRT  H1, H10
    FSQRT  D11, D25
    FSQRT  S20, S3
    FSQRT  H15, H2
    FSQRT  D2, D22
    FSQRT  S23, S7
    FSQRT  H28, H28
    FSQRT  D13, D8
    FSQRT  S3, S13
    FSQRT  H18, H5
    FSQRT  D30, D23
    FSQRT  S1, S30
    FSQRT  H8, H21
    FSQRT  D7, D28
    FSQRT  S15, S11
    FSQRT  H23, H24
    FSQRT  D24, D14
    FSQRT  S5, S15
    FSQRT  H28, H2
    FSQRT  D22, D5
    FSQRT  S15, S3
    FSQRT  H3, H7
    FSQRT  D2, D31
    FSQRT  S21, S3
    FSQRT  H29, H28
    FSQRT  D10, D23
    FSQRT  S0, S29
    FSQRT  H25, H5
    FSQRT  D25, D2
    FSQRT  S29, S1
    FSQRT  H7, H24
    FSQRT  D19, D0
    FSQRT  S11, S10
    FSQRT  H2, H21
    FSQRT  D23, D23
    FSQRT  S5, S25
    FSQRT  H14, H0
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x48a1, LSL #0
    MOVK  X23, #0x57cc, LSL #16
    MOVK  X23, #0xb3b, LSL #32
    MOVK  X23, #0x4cf4, LSL #48
    SUB  X19, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xc28a, LSL #0
    MOVK  X23, #0x905e, LSL #16
    MOVK  X23, #0x5dc2, LSL #32
    MOVK  X23, #0x8962, LSL #48
    SUB  X19, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xe425, LSL #0
    MOVK  X23, #0x1d6a, LSL #16
    MOVK  X23, #0x595f, LSL #32
    MOVK  X23, #0x4d6a, LSL #48
    SUB  X19, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    SUB  X19, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x52a4, LSL #0
    MOVK  X23, #0x7440, LSL #16
    MOVK  X23, #0xa3c8, LSL #32
    MOVK  X23, #0xdce0, LSL #48
    SUB  X19, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xc700, LSL #0
    SUB  X19, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xa1c, LSL #0
    SUB  X19, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xe8bc, LSL #0
    MOVK  X23, #0x38d0, LSL #16
    MOVK  X23, #0x1c43, LSL #32
    MOVK  X23, #0x80f6, LSL #48
    SUB  X19, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x55c6, LSL #0
    MOVK  X23, #0x9a25, LSL #16
    MOVK  X23, #0xa215, LSL #32
    MOVK  X23, #0xb07d, LSL #48
    SUB  X19, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x6f8d, LSL #0
    MOVK  X23, #0x7db4, LSL #16
    MOVK  X23, #0x311a, LSL #32
    MOVK  X23, #0xa5b7, LSL #48
    SUB  X19, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xed64, LSL #0
    SUB  X19, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xa4d3, LSL #0
    MOVK  X23, #0xfcd4, LSL #16
    MOVK  X23, #0x9dcd, LSL #32
    MOVK  X23, #0x711b, LSL #48
    SUB  X19, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xd2d7, LSL #0
    MOVK  X23, #0x24e2, LSL #16
    MOVK  X23, #0x10a1, LSL #32
    MOVK  X23, #0x21dd, LSL #48
    SUB  X19, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xed64, LSL #0
    MOVK  X23, #0xc372, LSL #16
    MOVK  X23, #0xefe3, LSL #32
    MOVK  X23, #0x3ce3, LSL #48
    SUB  X19, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0xda20, LSL #0
    MOVK  X23, #0x5052, LSL #16
    MOVK  X23, #0x6d50, LSL #32
    MOVK  X23, #0x4178, LSL #48
    SUB  X19, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X23, #0x9ea0, LSL #0
    MOVK  X23, #0xab97, LSL #16
    MOVK  X23, #0x8564, LSL #32
    MOVK  X23, #0xb8e5, LSL #48
    SUB  X19, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MRS  X23, FPCR
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x6e2, LSL #16
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MRS  X23, FPSR
    MOVZ  X19, #0x1f, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D0
    MOVZ  X19, #0x75fa, LSL #0
    MOVK  X19, #0x1d9c, LSL #16
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D1
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D4
    MOVZ  X19, #0xc28a, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D5
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #16
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D9
    MOVZ  X19, #0x7e00, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D12
    MOVZ  X19, #0x24d1, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D14
    MOVZ  X19, #0x58e3, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D15
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D16
    MOVZ  X19, #0xf1c6, LSL #0
    MOVK  X19, #0x1d0f, LSL #16
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D18
    MOVZ  X19, #0x4a90, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D19
    MOVZ  X19, #0x4ebb, LSL #0
    MOVK  X19, #0xc16e, LSL #16
    MOVK  X19, #0xc436, LSL #32
    MOVK  X19, #0x1f45, LSL #48
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D20
    MOVZ  X19, #0xae5c, LSL #0
    MOVK  X19, #0x36dd, LSL #16
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D21
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D25
    MOVZ  X19, #0x53e4, LSL #0
    MOVK  X19, #0xc508, LSL #16
    MOVK  X19, #0xfea0, LSL #32
    MOVK  X19, #0x3bc9, LSL #48
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D26
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xbf30, LSL #16
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D28
    MOVZ  X19, #0x23a2, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D30
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    FMOV  X23, D31
    MOVZ  X19, #0x8c2a, LSL #0
    MOVK  X19, #0x54bf, LSL #16
    MOVK  X19, #0xde5d, LSL #32
    MOVK  X19, #0x2f5b, LSL #48
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x40e1, LSL #0
    MOVK  X2, #0x8a1d, LSL #16
    MOVK  X2, #0x1512, LSL #32
    MOVK  X2, #0x2dca, LSL #48
    MOVZ  X3, #0x22a3, LSL #0
    MOVK  X3, #0xc72d, LSL #16
    MOVK  X3, #0x1d59, LSL #32
    MOVK  X3, #0xd90c, LSL #48
    MOVZ  X4, #0xe8ff, LSL #0
    MOVK  X4, #0x7bd3, LSL #16
    MOVK  X4, #0xe315, LSL #32
    MOVK  X4, #0x5416, LSL #48
    MOVZ  X5, #0xc439, LSL #0
    MOVK  X5, #0x1878, LSL #16
    MOVK  X5, #0x3aa9, LSL #32
    MOVK  X5, #0x6afc, LSL #48
    MOVZ  X6, #0x3009, LSL #0
    MOVK  X6, #0x94bb, LSL #16
    MOVK  X6, #0x8c9d, LSL #32
    MOVK  X6, #0x834c, LSL #48
    MOVZ  X7, #0xdacf, LSL #0
    MOVK  X7, #0x3c46, LSL #16
    MOVK  X7, #0xde86, LSL #32
    MOVK  X7, #0xd9eb, LSL #48
    MOVZ  X8, #0xcd21, LSL #0
    MOVK  X8, #0x751f, LSL #16
    MOVK  X8, #0x110b, LSL #32
    MOVK  X8, #0x949e, LSL #48
    MOVZ  X9, #0x710f, LSL #0
    MOVK  X9, #0xad48, LSL #16
    MOVK  X9, #0xb75f, LSL #32
    MOVK  X9, #0x7052, LSL #48
    MOVZ  X10, #0xfbd, LSL #0
    MOVK  X10, #0xf0c, LSL #16
    MOVK  X10, #0x9120, LSL #32
    MOVK  X10, #0x3645, LSL #48
    MOVZ  X11, #0x5d01, LSL #0
    MOVK  X11, #0xa47f, LSL #16
    MOVK  X11, #0xc173, LSL #32
    MOVK  X11, #0x52f2, LSL #48
    MOVZ  X12, #0xf3d, LSL #0
    MOVK  X12, #0x33f6, LSL #16
    MOVK  X12, #0x659a, LSL #32
    MOVK  X12, #0x572d, LSL #48
    MOVZ  X13, #0x46fd, LSL #0
    MOVK  X13, #0x1040, LSL #16
    MOVK  X13, #0xd02b, LSL #32
    MOVK  X13, #0xca56, LSL #48
    MOVZ  X14, #0xb90e, LSL #0
    MOVK  X14, #0x5e7f, LSL #16
    MOVK  X14, #0xbfde, LSL #32
    MOVK  X14, #0x5a67, LSL #48
    MOVZ  X15, #0x6d5c, LSL #0
    MOVK  X15, #0xd3cf, LSL #16
    MOVK  X15, #0xef30, LSL #32
    MOVK  X15, #0xd6f9, LSL #48
    MOVZ  X16, #0x64e4, LSL #0
    MOVK  X16, #0x6500, LSL #16
    MOVK  X16, #0xfac3, LSL #32
    MOVK  X16, #0xa695, LSL #48
    MOVZ  X17, #0x21bf, LSL #0
    MOVK  X17, #0x95d2, LSL #16
    MOVK  X17, #0x9b4e, LSL #32
    MOVK  X17, #0xc772, LSL #48
    MOVZ  X18, #0x4af7, LSL #0
    MOVK  X18, #0x4e65, LSL #16
    MOVK  X18, #0x9ce5, LSL #32
    MOVK  X18, #0xf361, LSL #48
    MOVZ  X19, #0x6f27, LSL #0
    MOVK  X19, #0x1d1e, LSL #16
    MOVK  X19, #0x8b24, LSL #32
    MOVK  X19, #0x322b, LSL #48
    MOVZ  X20, #0xf38b, LSL #0
    MOVK  X20, #0xc292, LSL #16
    MOVK  X20, #0x4cfb, LSL #32
    MOVK  X20, #0xf4e2, LSL #48
    MOVZ  X21, #0xbdba, LSL #0
    MOVK  X21, #0x8ab8, LSL #16
    MOVK  X21, #0x247, LSL #32
    MOVK  X21, #0x6ba1, LSL #48
    MOVZ  X22, #0x5f45, LSL #0
    MOVK  X22, #0x3497, LSL #16
    MOVK  X22, #0x833, LSL #32
    MOVK  X22, #0x991b, LSL #48
    MOVZ  X23, #0x632, LSL #0
    MOVK  X23, #0xdc2e, LSL #16
    MOVK  X23, #0xa545, LSL #32
    MOVK  X23, #0xcede, LSL #48
    MOVZ  X27, #0xc4f2, LSL #0
    MOVK  X27, #0x7790, LSL #16
    MOVK  X27, #0x2900, LSL #32
    MOVK  X27, #0x5eb3, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X20
    FMOV  D1, X27
    FMOV  V1.D[1], X23
    FMOV  D2, X22
    FMOV  V2.D[1], X15
    FMOV  D3, X27
    FMOV  V3.D[1], X3
    FMOV  D4, X17
    FMOV  V4.D[1], X3
    FMOV  D5, X18
    FMOV  V5.D[1], X8
    FMOV  D6, X11
    FMOV  V6.D[1], X18
    FMOV  D7, X3
    FMOV  V7.D[1], X17
    FMOV  D8, X19
    FMOV  V8.D[1], X21
    FMOV  D9, X5
    FMOV  V9.D[1], X4
    FMOV  D10, X13
    FMOV  V10.D[1], X15
    FMOV  D11, X13
    FMOV  V11.D[1], X21
    FMOV  D12, X20
    FMOV  V12.D[1], X4
    FMOV  D13, X7
    FMOV  V13.D[1], X12
    FMOV  D14, X12
    FMOV  V14.D[1], X7
    FMOV  D15, X27
    FMOV  V15.D[1], X13
    FMOV  D16, X11
    FMOV  V16.D[1], X5
    FMOV  D17, X18
    FMOV  V17.D[1], X4
    FMOV  D18, X7
    FMOV  V18.D[1], X4
    FMOV  D19, X9
    FMOV  V19.D[1], X7
    FMOV  D20, X5
    FMOV  V20.D[1], X4
    FMOV  D21, X3
    FMOV  V21.D[1], X22
    FMOV  D22, X19
    FMOV  V22.D[1], X5
    FMOV  D23, X9
    FMOV  V23.D[1], X13
    FMOV  D24, X6
    FMOV  V24.D[1], X2
    FMOV  D25, X14
    FMOV  V25.D[1], X8
    FMOV  D26, X3
    FMOV  V26.D[1], X21
    FMOV  D27, X7
    FMOV  V27.D[1], X5
    FMOV  D28, X3
    FMOV  V28.D[1], X21
    FMOV  D29, X14
    FMOV  V29.D[1], X10
    FMOV  D30, X2
    FMOV  V30.D[1], X19
    FMOV  D31, X15
    FMOV  V31.D[1], X17
    MOVZ  X11, #0xa, LSL #0
EnhanceFloatP01_label_7:
    FNMUL  D10, D28, D22
    FCSEL  D25, D24, D4, PL
    FMOV  W12, H0
    FMOV  H9, H20
    FNMSUB  H19, H9, H10, H12
    FNMUL  H31, H6, H23
    FMADD  D8, D29, D26, D25
    FMADD  S4, S19, S21, S30
    FNMUL  H10, H31, H31
    FNEG  S12, S4
    FNMADD  D20, D8, D12, D10
    FDIV  H19, H21, H0
    FABS  S22, S14
    FCSEL  S21, S10, S20, EQ
    FSQRT  S12, S20
    FMUL  S26, S11, S25
    FMOV  D31, X21
    FMOV  W15, H21
    FMADD  H20, H2, H23, H10
    FMOV  W21, S19
    FNEG  H4, H11
    FMOV  H28, H16
    FMOV  H8, #-1.81250000
    FMOV  S24, W16
    FMADD  H23, H15, H31, H26
    FCSEL  D25, D20, D22, MI
    FNEG  H20, H25
    FMSUB  H21, H23, H20, H8
    FCSEL  S9, S21, S12, VS
    FNMSUB  D0, D9, D24, D28
    FMADD  H28, H25, H15, H29
    FMADD  D6, D21, D22, D9
    FMUL  S8, S7, S2
    FSUB  H12, H19, H2
    FNMADD  H13, H0, H15, H9
    FMADD  D11, D25, D10, D14
    FMOV  D27, D29
    FNMADD  H1, H21, H23, H14
    FNMUL  H9, H28, H26
    FMSUB  S29, S1, S27, S26
    FDIV  D31, D13, D12
    FSUB  D15, D6, D11
    FMSUB  S24, S15, S8, S9
    FDIV  H12, H29, H31
    FABS  S0, S3
    FSQRT  S6, S4
    FMOV  S27, #3.37500000
    FMOV  S11, W10
    FNMADD  S21, S11, S5, S6
    FNMADD  S16, S27, S24, S19
    FNMSUB  D29, D21, D0, D25
    FMOV  S11, W22
    FNMSUB  H2, H16, H31, H6
    FADD  H8, H29, H29
    FMADD  H6, H7, H20, H27
    FNEG  D19, D30
    FABS  S31, S12
    FMSUB  H13, H22, H8, H24
    FADD  S27, S21, S2
    FADD  S29, S4, S19
    FSQRT  S30, S6
    FMADD  D8, D30, D29, D30
    FADD  S0, S3, S11
    FMOV  H2, #10.00000000
    FNEG  H4, H2
    FMOV  D24, #6.75000000
    FABS  H15, H0
    FMOV  D6, #-2.87500000
    FMOV  S29, S13
    FMOV  H13, #-25.00000000
    FMOV  W27, S8
    FNEG  H6, H24
    FMADD  H11, H13, H27, H31
    FNMSUB  H28, H31, H11, H0
    FADD  S13, S4, S4
    FMUL  H22, H13, H28
    FCSEL  D28, D22, D29, LT
    FMOV  S1, #0.26562500
    FABS  S0, S10
    FMOV  W5, H28
    FMSUB  H19, H1, H0, H15
    FDIV  S18, S16, S17
    FMUL  H2, H15, H17
    FMOV  S15, W8
    FMOV  H27, W3
    FNEG  D30, D0
    FSQRT  D6, D21
    FNMADD  H4, H29, H3, H0
    FNMUL  H0, H31, H7
    FMOV  H16, X5
    FMOV  H21, H23
    FMOV  X9, H15
    FNEG  H26, H16
    FNEG  D24, D18
    FMADD  S3, S2, S4, S26
    FNMUL  D16, D27, D8
    FMOV  S13, W12
    FABS  H30, H23
    FSUB  D18, D16, D3
    FNEG  D2, D0
    SUBS  X11, X11, #0x1
    B.NE  EnhanceFloatP01_label_7
    FSQRT  D15, D30
    FSQRT  S31, S31
    FSQRT  H29, H31
    FSQRT  D14, D6
    FSQRT  S0, S8
    FSQRT  H31, H19
    FSQRT  D7, D14
    FSQRT  S3, S17
    FSQRT  H27, H8
    FSQRT  D30, D13
    FSQRT  S15, S29
    FSQRT  H13, H24
    FSQRT  D6, D7
    FSQRT  S16, S6
    FSQRT  H19, H3
    FSQRT  D14, D7
    FSQRT  S8, S19
    FSQRT  H29, H30
    FSQRT  D6, D27
    FSQRT  S5, S17
    FSQRT  H16, H19
    FSQRT  D17, D5
    FSQRT  S30, S13
    FSQRT  H24, H4
    FSQRT  D13, D8
    FSQRT  S4, S2
    FSQRT  H2, H30
    FSQRT  D7, D14
    FSQRT  S5, S4
    FSQRT  H14, H5
    FSQRT  D2, D11
    FSQRT  S6, S14
    FSQRT  H8, H7
    FSQRT  D30, D19
    FSQRT  S11, S8
    FSQRT  H14, H28
    FSQRT  D11, D24
    FSQRT  S3, S6
    FSQRT  H24, H16
    FSQRT  D28, D3
    FSQRT  S16, S17
    FSQRT  H14, H4
    FSQRT  D3, D2
    FSQRT  S19, S24
    FSQRT  H4, H27
    FSQRT  D22, D3
    FSQRT  S6, S30
    FSQRT  H20, H6
    FSQRT  D5, D22
    FSQRT  S7, S11
    FSQRT  H27, H0
    FSQRT  D22, D2
    FSQRT  S26, S28
    FSQRT  H17, H4
    FSQRT  D2, D13
    FSQRT  S3, S12
    FSQRT  H11, H26
    FSQRT  D25, D10
    FSQRT  S6, S17
    FSQRT  H8, H11
    FSQRT  D4, D8
    FSQRT  S0, S7
    FSQRT  H5, H1
    FSQRT  D12, D22
    FSQRT  S13, S5
    FSQRT  H26, H27
    FSQRT  D7, D25
    FSQRT  S22, S4
    FSQRT  H30, H0
    FSQRT  D2, D7
    FSQRT  S24, S22
    FSQRT  H8, H26
    FSQRT  D5, D30
    FSQRT  S22, S6
    FSQRT  H15, H5
    FSQRT  D26, D3
    FSQRT  S25, S25
    FSQRT  H1, H15
    FSQRT  D3, D8
    FSQRT  S10, S24
    FSQRT  H8, H0
    FSQRT  D28, D12
    FSQRT  S12, S17
    FSQRT  H4, H1
    FSQRT  D1, D4
    FSQRT  S15, S2
    FSQRT  H6, H0
    FSQRT  D7, D13
    FSQRT  S6, S26
    FSQRT  H5, H1
    MOVZ  X20, #0x40e1, LSL #0
    MOVK  X20, #0x8a1d, LSL #16
    MOVK  X20, #0x1512, LSL #32
    MOVK  X20, #0x2dca, LSL #48
    SUB  X13, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x22a3, LSL #0
    MOVK  X20, #0xc72d, LSL #16
    MOVK  X20, #0x1d59, LSL #32
    MOVK  X20, #0xd90c, LSL #48
    SUB  X13, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x9f, LSL #0
    SUB  X13, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x3009, LSL #0
    MOVK  X20, #0x94bb, LSL #16
    MOVK  X20, #0x8c9d, LSL #32
    MOVK  X20, #0x834c, LSL #48
    SUB  X13, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xdacf, LSL #0
    MOVK  X20, #0x3c46, LSL #16
    MOVK  X20, #0xde86, LSL #32
    MOVK  X20, #0xd9eb, LSL #48
    SUB  X13, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xcd21, LSL #0
    MOVK  X20, #0x751f, LSL #16
    MOVK  X20, #0x110b, LSL #32
    MOVK  X20, #0x949e, LSL #48
    SUB  X13, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xcd21, LSL #0
    SUB  X13, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xfbd, LSL #0
    MOVK  X20, #0xf0c, LSL #16
    MOVK  X20, #0x9120, LSL #32
    MOVK  X20, #0x3645, LSL #48
    SUB  X13, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x8000, LSL #0
    SUB  X13, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xb90e, LSL #0
    MOVK  X20, #0x5e7f, LSL #16
    MOVK  X20, #0xbfde, LSL #32
    MOVK  X20, #0x5a67, LSL #48
    SUB  X13, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0xfbff, LSL #0
    SUB  X13, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x64e4, LSL #0
    MOVK  X20, #0x6500, LSL #16
    MOVK  X20, #0xfac3, LSL #32
    MOVK  X20, #0xa695, LSL #48
    SUB  X13, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x21bf, LSL #0
    MOVK  X20, #0x95d2, LSL #16
    MOVK  X20, #0x9b4e, LSL #32
    MOVK  X20, #0xc772, LSL #48
    SUB  X13, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x4af7, LSL #0
    MOVK  X20, #0x4e65, LSL #16
    MOVK  X20, #0x9ce5, LSL #32
    MOVK  X20, #0xf361, LSL #48
    SUB  X13, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x6f27, LSL #0
    MOVK  X20, #0x1d1e, LSL #16
    MOVK  X20, #0x8b24, LSL #32
    MOVK  X20, #0x322b, LSL #48
    SUB  X13, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x7c00, LSL #0
    SUB  X13, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x5f45, LSL #0
    MOVK  X20, #0x3497, LSL #16
    MOVK  X20, #0x833, LSL #32
    MOVK  X20, #0x991b, LSL #48
    SUB  X13, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x632, LSL #0
    MOVK  X20, #0xdc2e, LSL #16
    MOVK  X20, #0xa545, LSL #32
    MOVK  X20, #0xcede, LSL #48
    SUB  X13, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X20, #0x2ff7, LSL #0
    MOVK  X20, #0x1e00, LSL #16
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MRS  X20, FPCR
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x6e2, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    MRS  X20, FPSR
    MOVZ  X13, #0x1f, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D0
    MOVZ  X13, #0xfaee, LSL #0
    MOVK  X13, #0x30f9, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D1
    MOVZ  X13, #0x9c2a, LSL #0
    MOVK  X13, #0xe974, LSL #16
    MOVK  X13, #0x7e29, LSL #32
    MOVK  X13, #0x1ece, LSL #48
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D2
    MOVZ  X13, #0x549b, LSL #0
    MOVK  X13, #0x827a, LSL #16
    MOVK  X13, #0xdb13, LSL #32
    MOVK  X13, #0x37aa, LSL #48
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D3
    MOVZ  X13, #0xb2c2, LSL #0
    MOVK  X13, #0x3084, LSL #16
    MOVK  X13, #0x38db, LSL #32
    MOVK  X13, #0x1ece, LSL #48
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D4
    MOVZ  X13, #0x3a1d, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D5
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D8
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D10
    MOVZ  X13, #0x651f, LSL #0
    MOVK  X13, #0x476b, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D11
    MOVZ  X13, #0x48a1, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D12
    MOVZ  X13, #0x919e, LSL #0
    MOVK  X13, #0x1dac, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D15
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D16
    MOVZ  X13, #0x91ee, LSL #0
    MOVK  X13, #0x4c62, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D17
    MOVZ  X13, #0x3a2a, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D18
    MOVZ  X13, #0x809f, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D19
    MOVZ  X13, #0xe993, LSL #0
    MOVK  X13, #0x1db0, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D20
    MOVZ  X13, #0x2989, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D21
    MOVZ  X13, #0x7c00, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D22
    MOVZ  X13, #0x9f7f, LSL #0
    MOVK  X13, #0x2e94, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D23
    MOVZ  X13, #0x7c00, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D24
    MOVZ  X13, #0x72d0, LSL #0
    MOVK  X13, #0x4f58, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D25
    MOVZ  X13, #0x5095, LSL #0
    MOVK  X13, #0x5f1b, LSL #16
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D27
    MOVZ  X13, #0x313c, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D28
    MOVZ  X13, #0x3a47, LSL #0
    MOVK  X13, #0x1508, LSL #16
    MOVK  X13, #0x50b3, LSL #32
    MOVK  X13, #0x3bcd, LSL #48
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D29
    MOVZ  X13, #0x3be5, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D30
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    FMOV  X20, D31
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x888c, LSL #0
    MOVK  X2, #0x60e5, LSL #16
    MOVK  X2, #0xf322, LSL #32
    MOVK  X2, #0xa307, LSL #48
    MOVZ  X3, #0xee7, LSL #0
    MOVK  X3, #0x42a3, LSL #16
    MOVK  X3, #0xa6fe, LSL #32
    MOVK  X3, #0x2b4a, LSL #48
    MOVZ  X4, #0x7fce, LSL #0
    MOVK  X4, #0x4c78, LSL #16
    MOVK  X4, #0x9cad, LSL #32
    MOVK  X4, #0x36c5, LSL #48
    MOVZ  X5, #0x3d0e, LSL #0
    MOVK  X5, #0xc00c, LSL #16
    MOVK  X5, #0xa017, LSL #32
    MOVK  X5, #0x8f7d, LSL #48
    MOVZ  X6, #0x496d, LSL #0
    MOVK  X6, #0xa627, LSL #16
    MOVK  X6, #0x84e3, LSL #32
    MOVK  X6, #0x6b9c, LSL #48
    MOVZ  X7, #0x3f77, LSL #0
    MOVK  X7, #0x16bf, LSL #16
    MOVK  X7, #0xc108, LSL #32
    MOVK  X7, #0x78f8, LSL #48
    MOVZ  X8, #0x9c19, LSL #0
    MOVK  X8, #0x6da5, LSL #16
    MOVK  X8, #0xe352, LSL #32
    MOVK  X8, #0x481f, LSL #48
    MOVZ  X9, #0x95b0, LSL #0
    MOVK  X9, #0x123, LSL #16
    MOVK  X9, #0x8f6f, LSL #32
    MOVK  X9, #0xc632, LSL #48
    MOVZ  X10, #0x8764, LSL #0
    MOVK  X10, #0x1404, LSL #16
    MOVK  X10, #0x76ce, LSL #32
    MOVK  X10, #0xb107, LSL #48
    MOVZ  X11, #0x2714, LSL #0
    MOVK  X11, #0xa11f, LSL #16
    MOVK  X11, #0x2733, LSL #32
    MOVK  X11, #0xdfef, LSL #48
    MOVZ  X12, #0xa57c, LSL #0
    MOVK  X12, #0x570a, LSL #16
    MOVK  X12, #0x5951, LSL #32
    MOVK  X12, #0xc95f, LSL #48
    MOVZ  X13, #0xe154, LSL #0
    MOVK  X13, #0x40c7, LSL #16
    MOVK  X13, #0x4fe6, LSL #32
    MOVK  X13, #0x27aa, LSL #48
    MOVZ  X14, #0x36a0, LSL #0
    MOVK  X14, #0xb30, LSL #16
    MOVK  X14, #0x189c, LSL #32
    MOVK  X14, #0xe604, LSL #48
    MOVZ  X15, #0x5ac5, LSL #0
    MOVK  X15, #0x4fb9, LSL #16
    MOVK  X15, #0xd4ec, LSL #32
    MOVK  X15, #0xdca2, LSL #48
    MOVZ  X16, #0x26f1, LSL #0
    MOVK  X16, #0xa137, LSL #16
    MOVK  X16, #0x4c04, LSL #32
    MOVK  X16, #0xfe05, LSL #48
    MOVZ  X17, #0x66aa, LSL #0
    MOVK  X17, #0x309f, LSL #16
    MOVK  X17, #0xf2c1, LSL #32
    MOVK  X17, #0x6fed, LSL #48
    MOVZ  X18, #0xd280, LSL #0
    MOVK  X18, #0x11d1, LSL #16
    MOVK  X18, #0x35f8, LSL #32
    MOVK  X18, #0x7ac9, LSL #48
    MOVZ  X19, #0x9303, LSL #0
    MOVK  X19, #0x620a, LSL #16
    MOVK  X19, #0xd71e, LSL #32
    MOVK  X19, #0xf606, LSL #48
    MOVZ  X20, #0x7ced, LSL #0
    MOVK  X20, #0xbd5, LSL #16
    MOVK  X20, #0x4213, LSL #32
    MOVK  X20, #0x6027, LSL #48
    MOVZ  X21, #0x1fb3, LSL #0
    MOVK  X21, #0x230, LSL #16
    MOVK  X21, #0x141c, LSL #32
    MOVK  X21, #0x3247, LSL #48
    MOVZ  X22, #0xef09, LSL #0
    MOVK  X22, #0x632, LSL #16
    MOVK  X22, #0x120, LSL #32
    MOVK  X22, #0xd85c, LSL #48
    MOVZ  X23, #0x9b46, LSL #0
    MOVK  X23, #0x80ce, LSL #16
    MOVK  X23, #0xeaa3, LSL #32
    MOVK  X23, #0xb68e, LSL #48
    MOVZ  X27, #0xe0b9, LSL #0
    MOVK  X27, #0x6d17, LSL #16
    MOVK  X27, #0xd6bb, LSL #32
    MOVK  X27, #0x7a75, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X19
    FMOV  D1, X8
    FMOV  V1.D[1], X18
    FMOV  D2, X6
    FMOV  V2.D[1], X16
    FMOV  D3, X2
    FMOV  V3.D[1], X27
    FMOV  D4, X22
    FMOV  V4.D[1], X2
    FMOV  D5, X23
    FMOV  V5.D[1], X19
    FMOV  D6, X10
    FMOV  V6.D[1], X16
    FMOV  D7, X8
    FMOV  V7.D[1], X19
    FMOV  D8, X21
    FMOV  V8.D[1], X5
    FMOV  D9, X20
    FMOV  V9.D[1], X10
    FMOV  D10, X10
    FMOV  V10.D[1], X14
    FMOV  D11, X27
    FMOV  V11.D[1], X4
    FMOV  D12, X27
    FMOV  V12.D[1], X14
    FMOV  D13, X2
    FMOV  V13.D[1], X5
    FMOV  D14, X4
    FMOV  V14.D[1], X22
    FMOV  D15, X8
    FMOV  V15.D[1], X12
    FMOV  D16, X8
    FMOV  V16.D[1], X13
    FMOV  D17, X12
    FMOV  V17.D[1], X20
    FMOV  D18, X11
    FMOV  V18.D[1], X18
    FMOV  D19, X5
    FMOV  V19.D[1], X23
    FMOV  D20, X19
    FMOV  V20.D[1], X3
    FMOV  D21, X12
    FMOV  V21.D[1], X4
    FMOV  D22, X8
    FMOV  V22.D[1], X11
    FMOV  D23, X9
    FMOV  V23.D[1], X7
    FMOV  D24, X11
    FMOV  V24.D[1], X10
    FMOV  D25, X17
    FMOV  V25.D[1], X12
    FMOV  D26, X4
    FMOV  V26.D[1], X17
    FMOV  D27, X7
    FMOV  V27.D[1], X15
    FMOV  D28, X12
    FMOV  V28.D[1], X15
    FMOV  D29, X6
    FMOV  V29.D[1], X19
    FMOV  D30, X17
    FMOV  V30.D[1], X4
    FMOV  D31, X20
    FMOV  V31.D[1], X12
    MOVZ  X22, #0xa, LSL #0
EnhanceFloatP01_label_8:
    FMSUB  D4, D8, D27, D15
    FSUB  H12, H17, H23
    FNMADD  S26, S21, S30, S3
    FMUL  H9, H25, H20
    FNEG  H17, H26
    FABS  H15, H12
    FNMUL  D15, D28, D17
    FMUL  D17, D4, D29
    FNMSUB  H13, H9, H17, H17
    FNMSUB  S29, S8, S31, S13
    FNMADD  S24, S8, S7, S18
    FMSUB  H30, H29, H11, H15
    FMSUB  S4, S14, S24, S30
    FNMUL  H15, H23, H25
    FADD  D27, D1, D18
    FADD  D20, D26, D24
    FMADD  S2, S20, S4, S2
    FADD  S11, S4, S25
    FMOV  H17, X13
    FMADD  S20, S3, S6, S7
    FNMADD  D24, D14, D2, D4
    FSUB  D31, D14, D7
    FMOV  W15, H10
    FDIV  D18, D0, D24
    FNMUL  H26, H18, H26
    FDIV  D10, D31, D29
    FMOV  X11, H11
    FDIV  S0, S31, S2
    FCSEL  H8, H16, H31, HI
    FMSUB  S4, S24, S5, S22
    FNMADD  H25, H20, H21, H4
    FMOV  W18, S7
    FMOV  X12, D27
    FNMADD  D3, D0, D25, D17
    FNEG  S4, S21
    FNMSUB  S22, S5, S25, S10
    FABS  S3, S23
    FMSUB  S6, S5, S11, S17
    FMUL  H13, H26, H22
    FMADD  S18, S23, S3, S3
    FNEG  D2, D14
    FADD  S0, S10, S2
    FMOV  D26, X11
    FMOV  H17, W22
    FMUL  H29, H0, H2
    FMOV  D16, #-1.75000000
    FCSEL  S11, S9, S4, LT
    FCSEL  H1, H13, H11, CC
    FADD  S24, S0, S0
    FCSEL  H3, H17, H11, VC
    FMOV  D27, #-18.00000000
    FMOV  D4, D27
    FNMADD  H9, H8, H4, H0
    FMOV  S0, S17
    FNMADD  S13, S26, S18, S9
    FSUB  H5, H16, H3
    FMOV  H5, H8
    FMADD  D31, D18, D24, D22
    FSUB  D2, D13, D31
    FNMUL  S21, S1, S21
    FNMSUB  S27, S6, S0, S15
    FNMSUB  H16, H21, H29, H5
    FNMSUB  S4, S21, S4, S27
    FSQRT  H13, H22
    FNMUL  S21, S17, S21
    FMOV  W15, S15
    FMOV  X20, H27
    FCSEL  H0, H2, H16, LE
    FNMUL  D23, D13, D4
    FNMSUB  S29, S23, S12, S22
    FNMSUB  S22, S29, S27, S16
    FMOV  X2, D22
    FMADD  H9, H22, H29, H24
    FDIV  S18, S21, S0
    FSQRT  S22, S28
    FMOV  H8, X22
    FSQRT  H11, H23
    FSQRT  H0, H10
    FMOV  D5, D16
    FMOV  S21, #0.25000000
    FMOV  W27, H29
    FMSUB  S4, S12, S0, S24
    FABS  S2, S20
    FNMSUB  D24, D8, D22, D22
    FCSEL  D27, D4, D21, LT
    FMOV  X23, D5
    FMOV  H31, W5
    FNMADD  S8, S31, S23, S9
    FMOV  W9, H2
    FMOV  W17, S1
    FMOV  D10, #-3.25000000
    FMOV  W21, H8
    FSUB  H8, H11, H18
    FMOV  W3, H16
    FMOV  S29, #-12.50000000
    FNEG  S14, S9
    FMUL  S21, S24, S14
    FNEG  D11, D16
    FNEG  S24, S26
    FNMUL  S4, S11, S10
    SUBS  X22, X22, #0x1
    B.NE  EnhanceFloatP01_label_8
    FSQRT  D23, D24
    FSQRT  S27, S27
    FSQRT  H24, H29
    FSQRT  D18, D8
    FSQRT  S3, S23
    FSQRT  H29, H10
    FSQRT  D26, D29
    FSQRT  S8, S4
    FSQRT  H5, H24
    FSQRT  D23, D8
    FSQRT  S31, S24
    FSQRT  H24, H3
    FSQRT  D29, D24
    FSQRT  S14, S8
    FSQRT  H6, H14
    FSQRT  D8, D23
    FSQRT  S11, S12
    FSQRT  H10, H31
    FSQRT  D4, D21
    FSQRT  S24, S4
    FSQRT  H0, H8
    FSQRT  D22, D5
    FSQRT  S14, S11
    FSQRT  H15, H7
    FSQRT  D21, D14
    FSQRT  S3, S27
    FSQRT  H31, H0
    FSQRT  D7, D18
    FSQRT  S9, S10
    FSQRT  H4, H24
    FSQRT  D24, D3
    FSQRT  S12, S6
    FSQRT  H10, H31
    FSQRT  D3, D11
    FSQRT  S23, S7
    FSQRT  H7, H6
    FSQRT  D0, D21
    FSQRT  S8, S23
    FSQRT  H29, H4
    FSQRT  D14, D9
    FSQRT  S18, S22
    FSQRT  H9, H7
    FSQRT  D11, D9
    FSQRT  S27, S8
    FSQRT  H21, H24
    FSQRT  D4, D17
    FSQRT  S24, S3
    FSQRT  H22, H18
    FSQRT  D17, D22
    FSQRT  S31, S14
    FSQRT  H18, H15
    FSQRT  D14, D27
    FSQRT  S28, S29
    FSQRT  H20, H28
    FSQRT  D21, D0
    FSQRT  S9, S6
    FSQRT  H6, H26
    FSQRT  D15, D4
    FSQRT  S4, S11
    FSQRT  H22, H21
    FSQRT  D7, D24
    FSQRT  S8, S10
    FSQRT  H21, H18
    FSQRT  D10, D20
    FSQRT  S11, S0
    FSQRT  H20, H11
    FSQRT  D18, D31
    FSQRT  S3, S15
    FSQRT  H26, H4
    FSQRT  D29, D6
    FSQRT  S23, S28
    FSQRT  H6, H17
    FSQRT  D31, D8
    FSQRT  S11, S21
    FSQRT  H7, H3
    FSQRT  D4, D7
    FSQRT  S21, S4
    FSQRT  H24, H21
    FSQRT  D17, D10
    FSQRT  S28, S26
    FSQRT  H28, H22
    FSQRT  D18, D11
    FSQRT  S11, S29
    FSQRT  H8, H28
    FSQRT  D16, D18
    FSQRT  S22, S11
    FSQRT  H27, H24
    FSQRT  D7, D17
    FSQRT  S24, S23
    FSQRT  H18, H20
    MOVZ  X7, #0x7e00, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X10, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X10, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x7fce, LSL #0
    MOVK  X7, #0x4c78, LSL #16
    MOVK  X7, #0x9cad, LSL #32
    MOVK  X7, #0x36c5, LSL #48
    SUB  X10, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x3d0e, LSL #0
    MOVK  X7, #0xc00c, LSL #16
    MOVK  X7, #0xa017, LSL #32
    MOVK  X7, #0x8f7d, LSL #48
    SUB  X10, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x496d, LSL #0
    MOVK  X7, #0xa627, LSL #16
    MOVK  X7, #0x84e3, LSL #32
    MOVK  X7, #0x6b9c, LSL #48
    SUB  X10, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x9c19, LSL #0
    MOVK  X7, #0x6da5, LSL #16
    MOVK  X7, #0xe352, LSL #32
    MOVK  X7, #0x481f, LSL #48
    SUB  X10, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x9c19, LSL #0
    SUB  X10, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x6367, LSL #0
    SUB  X10, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x7413, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X10, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0xe154, LSL #0
    MOVK  X7, #0x40c7, LSL #16
    MOVK  X7, #0x4fe6, LSL #32
    MOVK  X7, #0x27aa, LSL #48
    SUB  X10, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x36a0, LSL #0
    MOVK  X7, #0xb30, LSL #16
    MOVK  X7, #0x189c, LSL #32
    MOVK  X7, #0xe604, LSL #48
    SUB  X10, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x7413, LSL #0
    SUB  X10, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x9c19, LSL #0
    MOVK  X7, #0x6da5, LSL #16
    SUB  X10, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x9303, LSL #0
    MOVK  X7, #0x620a, LSL #16
    MOVK  X7, #0xd71e, LSL #32
    MOVK  X7, #0xf606, LSL #48
    SUB  X10, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X10, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x7e00, LSL #0
    SUB  X10, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, EnhanceFloatP01_TestFail
    MRS  X7, FPCR
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x6e2, LSL #16
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    MRS  X7, FPSR
    MOVZ  X10, #0x1f, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D0
    MOVZ  X10, #0x777f, LSL #0
    MOVK  X10, #0xd85a, LSL #16
    MOVK  X10, #0x4d7f, LSL #32
    MOVK  X10, #0x2f9d, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D1
    MOVZ  X10, #0x7413, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D2
    MOVZ  X10, #0x9c19, LSL #0
    MOVK  X10, #0x6da5, LSL #16
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D3
    MOVZ  X10, #0x9dd3, LSL #0
    MOVK  X10, #0x52ff, LSL #16
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D4
    MOVZ  X10, #0x2f76, LSL #0
    MOVK  X10, #0x8d0e, LSL #16
    MOVK  X10, #0x732f, LSL #32
    MOVK  X10, #0x1ed6, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D8
    MOVZ  X10, #0x389a, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D15
    MOVZ  X10, #0x3bcc, LSL #0
    MOVK  X10, #0x667f, LSL #16
    MOVK  X10, #0xa09e, LSL #32
    MOVK  X10, #0x2f26, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D16
    MOVZ  X10, #0x81b5, LSL #0
    MOVK  X10, #0x42b6, LSL #16
    MOVK  X10, #0x79ed, LSL #32
    MOVK  X10, #0x2f9a, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X10, #0x9b46, LSL #0
    MOVK  X10, #0x80ce, LSL #16
    MOVK  X10, #0xeaa3, LSL #32
    MOVK  X10, #0xb68e, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D19
    MOVZ  X10, #0x3d0e, LSL #0
    MOVK  X10, #0xc00c, LSL #16
    MOVK  X10, #0xa017, LSL #32
    MOVK  X10, #0x8f7d, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D21
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D25
    MOVZ  X10, #0xe567, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D28
    MOVZ  X10, #0x354d, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D30
    MOVZ  X10, #0x7e00, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    FMOV  X7, D31
    MOVZ  X10, #0x3bb7, LSL #0
    MOVK  X10, #0x1d90, LSL #16
    MOVK  X10, #0xe7f2, LSL #32
    MOVK  X10, #0x1f45, LSL #48
    SUB  X16, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x6e02, LSL #0
    MOVK  X2, #0xe15b, LSL #16
    MOVK  X2, #0xf31c, LSL #32
    MOVK  X2, #0x87ad, LSL #48
    MOVZ  X3, #0x62e4, LSL #0
    MOVK  X3, #0x4710, LSL #16
    MOVK  X3, #0x7d74, LSL #32
    MOVK  X3, #0x599d, LSL #48
    MOVZ  X4, #0x1b7c, LSL #0
    MOVK  X4, #0xc359, LSL #16
    MOVK  X4, #0xa186, LSL #32
    MOVK  X4, #0x3b37, LSL #48
    MOVZ  X5, #0x68ff, LSL #0
    MOVK  X5, #0x3203, LSL #16
    MOVK  X5, #0xfc7d, LSL #32
    MOVK  X5, #0x8b0f, LSL #48
    MOVZ  X6, #0x32cc, LSL #0
    MOVK  X6, #0x3f54, LSL #16
    MOVK  X6, #0xc5bd, LSL #32
    MOVK  X6, #0xbc09, LSL #48
    MOVZ  X7, #0xffa9, LSL #0
    MOVK  X7, #0x7f0f, LSL #16
    MOVK  X7, #0x78e7, LSL #32
    MOVK  X7, #0x320c, LSL #48
    MOVZ  X8, #0x7e66, LSL #0
    MOVK  X8, #0xa1f2, LSL #16
    MOVK  X8, #0xc122, LSL #32
    MOVK  X8, #0x42a0, LSL #48
    MOVZ  X9, #0x2f78, LSL #0
    MOVK  X9, #0x69b2, LSL #16
    MOVK  X9, #0x2646, LSL #32
    MOVK  X9, #0x976f, LSL #48
    MOVZ  X10, #0x78, LSL #0
    MOVK  X10, #0x61ff, LSL #16
    MOVK  X10, #0x5374, LSL #32
    MOVK  X10, #0x873e, LSL #48
    MOVZ  X11, #0xb9f6, LSL #0
    MOVK  X11, #0x15b4, LSL #16
    MOVK  X11, #0xbbd8, LSL #32
    MOVK  X11, #0x2356, LSL #48
    MOVZ  X12, #0x315d, LSL #0
    MOVK  X12, #0x2e56, LSL #16
    MOVK  X12, #0xdfac, LSL #32
    MOVK  X12, #0x2e25, LSL #48
    MOVZ  X13, #0x250c, LSL #0
    MOVK  X13, #0x7d1d, LSL #16
    MOVK  X13, #0x52e0, LSL #32
    MOVK  X13, #0x3b61, LSL #48
    MOVZ  X14, #0xc110, LSL #0
    MOVK  X14, #0xd43f, LSL #16
    MOVK  X14, #0xd858, LSL #32
    MOVK  X14, #0x4079, LSL #48
    MOVZ  X15, #0xd642, LSL #0
    MOVK  X15, #0xfa4, LSL #16
    MOVK  X15, #0x85cd, LSL #32
    MOVK  X15, #0x66cd, LSL #48
    MOVZ  X16, #0x74b3, LSL #0
    MOVK  X16, #0xe185, LSL #16
    MOVK  X16, #0xd09, LSL #32
    MOVK  X16, #0xb582, LSL #48
    MOVZ  X17, #0x5fda, LSL #0
    MOVK  X17, #0x91e, LSL #16
    MOVK  X17, #0x2dcd, LSL #32
    MOVK  X17, #0x67f3, LSL #48
    MOVZ  X18, #0x5ba7, LSL #0
    MOVK  X18, #0x374a, LSL #16
    MOVK  X18, #0x1778, LSL #32
    MOVK  X18, #0x81da, LSL #48
    MOVZ  X19, #0xfc5e, LSL #0
    MOVK  X19, #0x4d05, LSL #16
    MOVK  X19, #0x655e, LSL #32
    MOVK  X19, #0xb94b, LSL #48
    MOVZ  X20, #0xaf04, LSL #0
    MOVK  X20, #0x62e5, LSL #16
    MOVK  X20, #0xf36e, LSL #32
    MOVK  X20, #0x4f0e, LSL #48
    MOVZ  X21, #0xa740, LSL #0
    MOVK  X21, #0x92c, LSL #16
    MOVK  X21, #0x3636, LSL #32
    MOVK  X21, #0x9d73, LSL #48
    MOVZ  X22, #0xa035, LSL #0
    MOVK  X22, #0x2a0a, LSL #16
    MOVK  X22, #0xf24b, LSL #32
    MOVK  X22, #0xffd7, LSL #48
    MOVZ  X23, #0x6c21, LSL #0
    MOVK  X23, #0xc36a, LSL #16
    MOVK  X23, #0x653a, LSL #32
    MOVK  X23, #0x81ec, LSL #48
    MOVZ  X27, #0x9813, LSL #0
    MOVK  X27, #0xd33a, LSL #16
    MOVK  X27, #0xf77a, LSL #32
    MOVK  X27, #0x443a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X4
    FMOV  D1, X11
    FMOV  V1.D[1], X20
    FMOV  D2, X27
    FMOV  V2.D[1], X5
    FMOV  D3, X16
    FMOV  V3.D[1], X22
    FMOV  D4, X27
    FMOV  V4.D[1], X2
    FMOV  D5, X14
    FMOV  V5.D[1], X23
    FMOV  D6, X11
    FMOV  V6.D[1], X5
    FMOV  D7, X6
    FMOV  V7.D[1], X4
    FMOV  D8, X12
    FMOV  V8.D[1], X3
    FMOV  D9, X10
    FMOV  V9.D[1], X20
    FMOV  D10, X10
    FMOV  V10.D[1], X27
    FMOV  D11, X27
    FMOV  V11.D[1], X6
    FMOV  D12, X20
    FMOV  V12.D[1], X18
    FMOV  D13, X10
    FMOV  V13.D[1], X21
    FMOV  D14, X27
    FMOV  V14.D[1], X27
    FMOV  D15, X9
    FMOV  V15.D[1], X7
    FMOV  D16, X16
    FMOV  V16.D[1], X13
    FMOV  D17, X20
    FMOV  V17.D[1], X6
    FMOV  D18, X10
    FMOV  V18.D[1], X13
    FMOV  D19, X20
    FMOV  V19.D[1], X4
    FMOV  D20, X18
    FMOV  V20.D[1], X14
    FMOV  D21, X8
    FMOV  V21.D[1], X4
    FMOV  D22, X8
    FMOV  V22.D[1], X15
    FMOV  D23, X13
    FMOV  V23.D[1], X10
    FMOV  D24, X15
    FMOV  V24.D[1], X6
    FMOV  D25, X4
    FMOV  V25.D[1], X8
    FMOV  D26, X21
    FMOV  V26.D[1], X8
    FMOV  D27, X22
    FMOV  V27.D[1], X17
    FMOV  D28, X8
    FMOV  V28.D[1], X23
    FMOV  D29, X23
    FMOV  V29.D[1], X19
    FMOV  D30, X18
    FMOV  V30.D[1], X7
    FMOV  D31, X13
    FMOV  V31.D[1], X19
    MOVZ  X4, #0xa, LSL #0
EnhanceFloatP01_label_9:
    FMOV  S4, S29
    FMADD  D20, D31, D9, D4
    FADD  D10, D27, D26
    FMUL  D30, D4, D15
    FCSEL  S30, S22, S21, VC
    FNMADD  H6, H20, H4, H30
    FMUL  H2, H6, H6
    FNMUL  S21, S20, S26
    FMOV  H26, X19
    FNEG  D19, D28
    FNMADD  D2, D5, D19, D3
    FCSEL  D4, D8, D21, VC
    FMOV  S30, S2
    FNMSUB  S31, S22, S26, S4
    FADD  H2, H31, H8
    FADD  H3, H10, H30
    FMOV  H28, X17
    FMUL  S19, S13, S2
    FNEG  H1, H28
    FNMADD  H29, H3, H27, H17
    FMSUB  S20, S9, S1, S29
    FMOV  X22, D19
    FMOV  H9, X6
    FDIV  H18, H13, H4
    FNMUL  H26, H22, H25
    FCSEL  D28, D0, D30, LE
    FMADD  D5, D5, D27, D31
    FNMADD  H0, H0, H3, H28
    FSQRT  H27, H14
    FMOV  D31, #29.00000000
    FABS  S29, S16
    FMOV  H4, X15
    FABS  H22, H1
    FMUL  H19, H4, H4
    FMOV  D22, #-0.22656250
    FABS  H4, H31
    FMOV  H21, #0.37500000
    FMOV  D17, #-1.81250000
    FADD  S5, S18, S19
    FNMUL  D19, D2, D22
    FSUB  D18, D19, D19
    FCSEL  D25, D29, D17, EQ
    FMOV  D13, D21
    FNMSUB  S3, S5, S25, S27
    FMADD  S20, S26, S30, S0
    FCSEL  S5, S4, S13, GT
    FNMADD  S19, S10, S18, S20
    FMOV  S14, #-1.00000000
    FNEG  D31, D19
    FMOV  W27, H14
    FMOV  H0, #0.65625000
    FMOV  H6, H9
    FMOV  S16, S16
    FSQRT  H26, H5
    FSUB  H13, H6, H6
    FABS  D25, D13
    FMOV  H6, W4
    FSQRT  S22, S23
    FMOV  X18, H11
    FMUL  D23, D22, D22
    FNMUL  S10, S3, S10
    FMSUB  H17, H25, H20, H6
    FMOV  W2, H6
    FSQRT  H5, H16
    FMUL  H29, H5, H0
    FABS  D3, D28
    FMADD  S11, S29, S23, S7
    FADD  H13, H27, H23
    FDIV  D19, D26, D10
    FSQRT  H16, H7
    FNMSUB  S6, S17, S13, S17
    FADD  D21, D11, D24
    FMUL  D26, D21, D9
    FMOV  W27, S25
    FMOV  X15, H22
    FMSUB  D28, D19, D16, D26
    FMADD  S25, S28, S3, S0
    FSQRT  H21, H25
    FNEG  H9, H21
    FMOV  D27, X23
    FMUL  S27, S8, S11
    FMSUB  H7, H6, H27, H31
    FMOV  S23, S14
    FSUB  H22, H25, H5
    FCSEL  S10, S19, S9, MI
    FNMADD  H25, H4, H1, H27
    FNEG  H24, H2
    FMOV  X10, H0
    FABS  S1, S30
    FMSUB  S6, S27, S12, S2
    FDIV  D20, D16, D31
    FMOV  D30, #-1.25000000
    FADD  D5, D11, D22
    FSQRT  H19, H1
    FMSUB  D16, D12, D30, D23
    FMOV  D21, D10
    FCSEL  S1, S6, S25, HI
    FNEG  H6, H9
    FNMADD  D27, D30, D24, D6
    FNMSUB  S31, S19, S19, S18
    SUBS  X4, X4, #0x1
    B.NE  EnhanceFloatP01_label_9
    MOVZ  X12, #0x1, LSL #0
    SUB  X13, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x62e4, LSL #0
    MOVK  X12, #0x4710, LSL #16
    MOVK  X12, #0x7d74, LSL #32
    MOVK  X12, #0x599d, LSL #48
    SUB  X13, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x68ff, LSL #0
    MOVK  X12, #0x3203, LSL #16
    MOVK  X12, #0xfc7d, LSL #32
    MOVK  X12, #0x8b0f, LSL #48
    SUB  X13, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x32cc, LSL #0
    MOVK  X12, #0x3f54, LSL #16
    MOVK  X12, #0xc5bd, LSL #32
    MOVK  X12, #0xbc09, LSL #48
    SUB  X13, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0xffa9, LSL #0
    MOVK  X12, #0x7f0f, LSL #16
    MOVK  X12, #0x78e7, LSL #32
    MOVK  X12, #0x320c, LSL #48
    SUB  X13, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x7e66, LSL #0
    MOVK  X12, #0xa1f2, LSL #16
    MOVK  X12, #0xc122, LSL #32
    MOVK  X12, #0x42a0, LSL #48
    SUB  X13, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x2f78, LSL #0
    MOVK  X12, #0x69b2, LSL #16
    MOVK  X12, #0x2646, LSL #32
    MOVK  X12, #0x976f, LSL #48
    SUB  X13, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x3940, LSL #0
    SUB  X13, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0xc110, LSL #0
    MOVK  X12, #0xd43f, LSL #16
    MOVK  X12, #0xd858, LSL #32
    MOVK  X12, #0x4079, LSL #48
    SUB  X13, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x74b3, LSL #0
    MOVK  X12, #0xe185, LSL #16
    MOVK  X12, #0xd09, LSL #32
    MOVK  X12, #0xb582, LSL #48
    SUB  X13, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x5fda, LSL #0
    MOVK  X12, #0x91e, LSL #16
    MOVK  X12, #0x2dcd, LSL #32
    MOVK  X12, #0x67f3, LSL #48
    SUB  X13, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x2589, LSL #0
    SUB  X13, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0xfc5e, LSL #0
    MOVK  X12, #0x4d05, LSL #16
    MOVK  X12, #0x655e, LSL #32
    MOVK  X12, #0xb94b, LSL #48
    SUB  X13, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0xaf04, LSL #0
    MOVK  X12, #0x62e5, LSL #16
    MOVK  X12, #0xf36e, LSL #32
    MOVK  X12, #0x4f0e, LSL #48
    SUB  X13, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0xa740, LSL #0
    MOVK  X12, #0x92c, LSL #16
    MOVK  X12, #0x3636, LSL #32
    MOVK  X12, #0x9d73, LSL #48
    SUB  X13, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x6c21, LSL #0
    MOVK  X12, #0xc36a, LSL #16
    MOVK  X12, #0x653a, LSL #32
    MOVK  X12, #0x81ec, LSL #48
    SUB  X13, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, EnhanceFloatP01_TestFail
    MRS  X12, FPCR
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x6e2, LSL #16
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    MRS  X12, FPSR
    MOVZ  X13, #0x1f, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D0
    MOVZ  X13, #0x3940, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D1
    MOVZ  X13, #0x355c, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D2
    MOVZ  X13, #0x355c, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D5
    MOVZ  X13, #0xa389, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D6
    MOVZ  X13, #0x3a7b, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D7
    MOVZ  X13, #0x2589, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X13, #0x62e4, LSL #0
    MOVK  X13, #0x4710, LSL #16
    MOVK  X13, #0x7d74, LSL #32
    MOVK  X13, #0x599d, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D8
    MOVZ  X13, #0x315d, LSL #0
    MOVK  X13, #0x2e56, LSL #16
    MOVK  X13, #0xdfac, LSL #32
    MOVK  X13, #0x2e25, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D9
    MOVZ  X13, #0xba7b, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D10
    MOVZ  X13, #0xba7b, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D11
    MOVZ  X13, #0x2589, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X13, #0x5ba7, LSL #0
    MOVK  X13, #0x374a, LSL #16
    MOVK  X13, #0x1778, LSL #32
    MOVK  X13, #0x81da, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D12
    MOVZ  X13, #0xaf04, LSL #0
    MOVK  X13, #0x62e5, LSL #16
    MOVK  X13, #0xf36e, LSL #32
    MOVK  X13, #0x4f0e, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D14
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbf80, LSL #16
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X13, #0xffa9, LSL #0
    MOVK  X13, #0x7f0f, LSL #16
    MOVK  X13, #0x78e7, LSL #32
    MOVK  X13, #0x320c, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D15
    MOVZ  X13, #0x2f78, LSL #0
    MOVK  X13, #0x69b2, LSL #16
    MOVK  X13, #0x2646, LSL #32
    MOVK  X13, #0x976f, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D16
    MOVZ  X13, #0x8d62, LSL #0
    MOVK  X13, #0xfdcf, LSL #16
    MOVK  X13, #0x5824, LSL #32
    MOVK  X13, #0x4f13, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D17
    MOVZ  X13, #0x1, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D20
    MOVZ  X13, #0xc411, LSL #0
    MOVK  X13, #0xdbed, LSL #16
    MOVK  X13, #0x59f8, LSL #32
    MOVK  X13, #0xbed8, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D21
    MOVZ  X13, #0xba7b, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D22
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D23
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbf80, LSL #16
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D24
    MOVZ  X13, #0xb55c, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D27
    MOVZ  X13, #0xa838, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D29
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D30
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbff4, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    FMOV  X12, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x8268, LSL #0
    MOVK  X2, #0xcb03, LSL #16
    MOVK  X2, #0xfdac, LSL #32
    MOVK  X2, #0x6e5c, LSL #48
    MOVZ  X3, #0x4a85, LSL #0
    MOVK  X3, #0x7326, LSL #16
    MOVK  X3, #0xfe6e, LSL #32
    MOVK  X3, #0x56b1, LSL #48
    MOVZ  X4, #0xb1b1, LSL #0
    MOVK  X4, #0x443a, LSL #16
    MOVK  X4, #0xcdaa, LSL #32
    MOVK  X4, #0x5068, LSL #48
    MOVZ  X5, #0x96, LSL #0
    MOVK  X5, #0xa8e6, LSL #16
    MOVK  X5, #0x7d17, LSL #32
    MOVK  X5, #0x19a6, LSL #48
    MOVZ  X6, #0x2d8d, LSL #0
    MOVK  X6, #0x4195, LSL #16
    MOVK  X6, #0xdca9, LSL #32
    MOVK  X6, #0xfe9e, LSL #48
    MOVZ  X7, #0xa8d4, LSL #0
    MOVK  X7, #0x8f25, LSL #16
    MOVK  X7, #0x96b, LSL #32
    MOVK  X7, #0xda1e, LSL #48
    MOVZ  X8, #0x11b6, LSL #0
    MOVK  X8, #0x9bfd, LSL #16
    MOVK  X8, #0x287b, LSL #32
    MOVK  X8, #0x5e69, LSL #48
    MOVZ  X9, #0x56dc, LSL #0
    MOVK  X9, #0x1c8c, LSL #16
    MOVK  X9, #0x96ad, LSL #32
    MOVK  X9, #0x7bdc, LSL #48
    MOVZ  X10, #0xad3d, LSL #0
    MOVK  X10, #0x7352, LSL #16
    MOVK  X10, #0x688f, LSL #32
    MOVK  X10, #0xb6a9, LSL #48
    MOVZ  X11, #0x3a2a, LSL #0
    MOVK  X11, #0xeaba, LSL #16
    MOVK  X11, #0xe6e4, LSL #32
    MOVK  X11, #0x81d1, LSL #48
    MOVZ  X12, #0x935d, LSL #0
    MOVK  X12, #0x7306, LSL #16
    MOVK  X12, #0xd6f4, LSL #32
    MOVK  X12, #0x9687, LSL #48
    MOVZ  X13, #0x5734, LSL #0
    MOVK  X13, #0x11fc, LSL #16
    MOVK  X13, #0x8772, LSL #32
    MOVK  X13, #0x22e4, LSL #48
    MOVZ  X14, #0x1e21, LSL #0
    MOVK  X14, #0xf44a, LSL #16
    MOVK  X14, #0xe63c, LSL #32
    MOVK  X14, #0x9004, LSL #48
    MOVZ  X15, #0xfc58, LSL #0
    MOVK  X15, #0xcf37, LSL #16
    MOVK  X15, #0x37e2, LSL #32
    MOVK  X15, #0x5d55, LSL #48
    MOVZ  X16, #0xd992, LSL #0
    MOVK  X16, #0x1f34, LSL #16
    MOVK  X16, #0x69f8, LSL #32
    MOVK  X16, #0xe4cc, LSL #48
    MOVZ  X17, #0xde2d, LSL #0
    MOVK  X17, #0xab17, LSL #16
    MOVK  X17, #0x5f9b, LSL #32
    MOVK  X17, #0x1080, LSL #48
    MOVZ  X18, #0xc4c0, LSL #0
    MOVK  X18, #0xb715, LSL #16
    MOVK  X18, #0x9fac, LSL #32
    MOVK  X18, #0xb8dc, LSL #48
    MOVZ  X19, #0x41b9, LSL #0
    MOVK  X19, #0xea5a, LSL #16
    MOVK  X19, #0x242f, LSL #32
    MOVK  X19, #0x1ec7, LSL #48
    MOVZ  X20, #0xf5d3, LSL #0
    MOVK  X20, #0x17d9, LSL #16
    MOVK  X20, #0x5382, LSL #32
    MOVK  X20, #0xad37, LSL #48
    MOVZ  X21, #0xd874, LSL #0
    MOVK  X21, #0xcaff, LSL #16
    MOVK  X21, #0x3294, LSL #32
    MOVK  X21, #0x77dd, LSL #48
    MOVZ  X22, #0x3bac, LSL #0
    MOVK  X22, #0x8e63, LSL #16
    MOVK  X22, #0xaca, LSL #32
    MOVK  X22, #0x5e11, LSL #48
    MOVZ  X23, #0x20c0, LSL #0
    MOVK  X23, #0xb957, LSL #16
    MOVK  X23, #0x3833, LSL #32
    MOVK  X23, #0xe909, LSL #48
    MOVZ  X27, #0xe77a, LSL #0
    MOVK  X27, #0xd0ba, LSL #16
    MOVK  X27, #0xa38f, LSL #32
    MOVK  X27, #0x4a97, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X20
    FMOV  V1.D[1], X21
    FMOV  D2, X22
    FMOV  V2.D[1], X4
    FMOV  D3, X11
    FMOV  V3.D[1], X2
    FMOV  D4, X15
    FMOV  V4.D[1], X20
    FMOV  D5, X18
    FMOV  V5.D[1], X3
    FMOV  D6, X21
    FMOV  V6.D[1], X19
    FMOV  D7, X6
    FMOV  V7.D[1], X9
    FMOV  D8, X2
    FMOV  V8.D[1], X10
    FMOV  D9, X21
    FMOV  V9.D[1], X6
    FMOV  D10, X21
    FMOV  V10.D[1], X10
    FMOV  D11, X4
    FMOV  V11.D[1], X16
    FMOV  D12, X11
    FMOV  V12.D[1], X21
    FMOV  D13, X7
    FMOV  V13.D[1], X14
    FMOV  D14, X5
    FMOV  V14.D[1], X3
    FMOV  D15, X16
    FMOV  V15.D[1], X27
    FMOV  D16, X14
    FMOV  V16.D[1], X22
    FMOV  D17, X10
    FMOV  V17.D[1], X18
    FMOV  D18, X10
    FMOV  V18.D[1], X5
    FMOV  D19, X10
    FMOV  V19.D[1], X18
    FMOV  D20, X9
    FMOV  V20.D[1], X16
    FMOV  D21, X13
    FMOV  V21.D[1], X7
    FMOV  D22, X9
    FMOV  V22.D[1], X23
    FMOV  D23, X11
    FMOV  V23.D[1], X15
    FMOV  D24, X3
    FMOV  V24.D[1], X13
    FMOV  D25, X11
    FMOV  V25.D[1], X10
    FMOV  D26, X3
    FMOV  V26.D[1], X3
    FMOV  D27, X8
    FMOV  V27.D[1], X20
    FMOV  D28, X7
    FMOV  V28.D[1], X15
    FMOV  D29, X23
    FMOV  V29.D[1], X27
    FMOV  D30, X9
    FMOV  V30.D[1], X11
    FMOV  D31, X23
    FMOV  V31.D[1], X13
    MOVZ  X9, #0xa, LSL #0
EnhanceFloatP01_label_10:
    FNMSUB  S27, S18, S20, S22
    FCSEL  H0, H30, H23, MI
    FSQRT  H3, H28
    FNMADD  H17, H3, H9, H31
    FMADD  S5, S29, S18, S29
    FNMADD  S14, S6, S24, S25
    FDIV  D23, D26, D0
    FNMUL  S2, S27, S27
    FMOV  H25, #10.00000000
    FADD  D29, D4, D5
    FMOV  W10, H2
    FMOV  H21, H25
    FNEG  D26, D29
    FMOV  S31, W13
    FMSUB  D28, D23, D17, D1
    FMADD  D13, D3, D15, D28
    FADD  H2, H31, H11
    FMADD  D25, D26, D14, D26
    FMOV  S17, W16
    FCSEL  H31, H13, H13, HI
    FSQRT  S18, S17
    FSUB  H15, H31, H27
    FMADD  S8, S18, S15, S15
    FMADD  D31, D25, D8, D26
    FADD  S0, S20, S31
    FNEG  D18, D2
    FMOV  H20, W10
    FSQRT  H5, H0
    FMOV  S21, W6
    FABS  D22, D18
    FMOV  H0, X11
    FABS  D13, D21
    FNEG  H21, H25
    FMOV  X15, H0
    FNEG  H15, H23
    FNMADD  H31, H13, H5, H15
    FNEG  D26, D20
    FSQRT  S3, S17
    FMOV  S16, W7
    FMOV  S5, W18
    FSUB  S21, S10, S5
    FMOV  H15, W23
    FSQRT  D14, D16
    FNMUL  H13, H26, H31
    FMOV  H21, #-3.62500000
    FNMADD  D0, D15, D22, D15
    FMOV  S22, W20
    FMOV  X20, H13
    FADD  H25, H14, H31
    FMOV  W10, H22
    FNEG  S31, S17
    FADD  S10, S4, S25
    FADD  D17, D26, D0
    FNMSUB  H20, H13, H21, H17
    FABS  S13, S10
    FNMADD  D10, D11, D3, D31
    FSQRT  S5, S13
    FADD  D31, D10, D10
    FSUB  S23, S5, S5
    FMOV  X23, H16
    FMUL  H4, H18, H23
    FMOV  D15, #6.25000000
    FNMSUB  H24, H20, H20, H31
    FNMSUB  H22, H15, H17, H4
    FMOV  H3, X16
    FNMADD  H6, H29, H7, H7
    FMOV  S5, #-0.23437500
    FNMUL  D26, D27, D27
    FADD  D1, D20, D4
    FMOV  X5, H2
    FMSUB  D16, D8, D11, D0
    FMOV  H31, #-23.00000000
    FSQRT  H18, H13
    FADD  H15, H16, H5
    FMUL  D11, D15, D26
    FADD  S2, S3, S21
    FMOV  S13, W5
    FMOV  W17, H20
    FSQRT  S27, S7
    FSUB  S21, S12, S1
    FABS  S0, S27
    FABS  S5, S29
    FNEG  H29, H13
    FMADD  H31, H0, H2, H29
    FADD  D7, D31, D31
    FMSUB  D1, D31, D18, D27
    FMOV  X23, H5
    FMADD  D20, D21, D7, D11
    FMUL  D31, D22, D20
    FNEG  H7, H1
    FMOV  X18, D7
    FMSUB  D7, D31, D31, D22
    FMOV  S25, #-1.12500000
    FMOV  D18, X4
    FADD  H13, H7, H25
    FSUB  D27, D18, D18
    FSQRT  S20, S27
    FADD  H27, H20, H21
    FMOV  X5, D6
    FNMSUB  S11, S7, S18, S29
    SUBS  X9, X9, #0x1
    B.NE  EnhanceFloatP01_label_10
    MOVZ  X3, #0x8268, LSL #0
    MOVK  X3, #0xcb03, LSL #16
    MOVK  X3, #0xfdac, LSL #32
    MOVK  X3, #0x6e5c, LSL #48
    SUB  X22, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0xb1b1, LSL #0
    MOVK  X3, #0x443a, LSL #16
    MOVK  X3, #0xcdaa, LSL #32
    MOVK  X3, #0x5068, LSL #48
    SUB  X22, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x2d8d, LSL #0
    MOVK  X3, #0x4195, LSL #16
    MOVK  X3, #0xdca9, LSL #32
    MOVK  X3, #0xfe9e, LSL #48
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0xa8d4, LSL #0
    MOVK  X3, #0x8f25, LSL #16
    MOVK  X3, #0x96b, LSL #32
    MOVK  X3, #0xda1e, LSL #48
    SUB  X22, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x11b6, LSL #0
    MOVK  X3, #0x9bfd, LSL #16
    MOVK  X3, #0x287b, LSL #32
    MOVK  X3, #0x5e69, LSL #48
    SUB  X22, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x3a2a, LSL #0
    MOVK  X3, #0xeaba, LSL #16
    MOVK  X3, #0xe6e4, LSL #32
    MOVK  X3, #0x81d1, LSL #48
    SUB  X22, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x935d, LSL #0
    MOVK  X3, #0x7306, LSL #16
    MOVK  X3, #0xd6f4, LSL #32
    MOVK  X3, #0x9687, LSL #48
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x5734, LSL #0
    MOVK  X3, #0x11fc, LSL #16
    MOVK  X3, #0x8772, LSL #32
    MOVK  X3, #0x22e4, LSL #48
    SUB  X22, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x1e21, LSL #0
    MOVK  X3, #0xf44a, LSL #16
    MOVK  X3, #0xe63c, LSL #32
    MOVK  X3, #0x9004, LSL #48
    SUB  X22, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x3a2a, LSL #0
    SUB  X22, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0xd992, LSL #0
    MOVK  X3, #0x1f34, LSL #16
    MOVK  X3, #0x69f8, LSL #32
    MOVK  X3, #0xe4cc, LSL #48
    SUB  X22, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    SUB  X22, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x8000, LSL #0
    SUB  X22, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0xfe00, LSL #0
    SUB  X22, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0xd874, LSL #0
    MOVK  X3, #0xcaff, LSL #16
    MOVK  X3, #0x3294, LSL #32
    MOVK  X3, #0x77dd, LSL #48
    SUB  X22, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0x9ae0, LSL #0
    SUB  X22, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MOVZ  X3, #0xe77a, LSL #0
    MOVK  X3, #0xd0ba, LSL #16
    MOVK  X3, #0xa38f, LSL #32
    MOVK  X3, #0x4a97, LSL #48
    SUB  X22, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, EnhanceFloatP01_TestFail
    MRS  X3, FPCR
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x6e2, LSL #16
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MRS  X3, FPSR
    MOVZ  X22, #0x1f, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D0
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D1
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D2
    MOVZ  X22, #0x9cd2, LSL #0
    MOVK  X22, #0x1, LSL #16
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D3
    MOVZ  X22, #0xd992, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D5
    MOVZ  X22, #0x9ae0, LSL #0
    MOVK  X22, #0xcc, LSL #16
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X22, #0x2d8d, LSL #0
    MOVK  X22, #0x4195, LSL #16
    MOVK  X22, #0xdca9, LSL #32
    MOVK  X22, #0xfe9e, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D9
    MOVZ  X22, #0xd874, LSL #0
    MOVK  X22, #0xcaff, LSL #16
    MOVK  X22, #0x3294, LSL #32
    MOVK  X22, #0x77dd, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D10
    MOVZ  X22, #0xd992, LSL #0
    MOVK  X22, #0x9f34, LSL #16
    MOVK  X22, #0x8000, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D11
    MOVZ  X22, #0xd792, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X22, #0xd874, LSL #0
    MOVK  X22, #0xcaff, LSL #16
    MOVK  X22, #0x3294, LSL #32
    MOVK  X22, #0x77dd, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D12
    MOVZ  X22, #0x3a2a, LSL #0
    MOVK  X22, #0xeaba, LSL #16
    MOVK  X22, #0xe6e4, LSL #32
    MOVK  X22, #0x81d1, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D14
    MOVZ  X22, #0x69ed, LSL #0
    MOVK  X22, #0x26c4, LSL #16
    MOVK  X22, #0xedc7, LSL #32
    MOVK  X22, #0x1f57, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D15
    MOVZ  X22, #0x6b99, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D16
    MOVZ  X22, #0x6b99, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D17
    MOVZ  X22, #0x6b99, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D18
    MOVZ  X22, #0xb1b1, LSL #0
    MOVK  X22, #0x443a, LSL #16
    MOVK  X22, #0xcdaa, LSL #32
    MOVK  X22, #0x5068, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X22, #0xc4c0, LSL #0
    MOVK  X22, #0xb715, LSL #16
    MOVK  X22, #0x9fac, LSL #32
    MOVK  X22, #0xb8dc, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D19
    MOVZ  X22, #0xad3d, LSL #0
    MOVK  X22, #0x7352, LSL #16
    MOVK  X22, #0x688f, LSL #32
    MOVK  X22, #0xb6a9, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D21
    MOVZ  X22, #0x3a2a, LSL #0
    MOVK  X22, #0xeaba, LSL #16
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D22
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D24
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D25
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xbf90, LSL #16
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D26
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D27
    MOVZ  X22, #0x3a2a, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D28
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D29
    MOVZ  X22, #0xd792, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X22, #0x3a2a, LSL #0
    MOVK  X22, #0xeaba, LSL #16
    MOVK  X22, #0xe6e4, LSL #32
    MOVK  X22, #0x81d1, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D30
    MOVZ  X22, #0x56dc, LSL #0
    MOVK  X22, #0x1c8c, LSL #16
    MOVK  X22, #0x96ad, LSL #32
    MOVK  X22, #0x7bdc, LSL #48
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    FMOV  X3, D31
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, EnhanceFloatP01_TestFail
    MOVZ  X2, #0x8b45, LSL #0
    MOVK  X2, #0xa4c4, LSL #16
    MOVK  X2, #0xb167, LSL #32
    MOVK  X2, #0xd5aa, LSL #48
    MOVZ  X3, #0x1534, LSL #0
    MOVK  X3, #0x5482, LSL #16
    MOVK  X3, #0xe325, LSL #32
    MOVK  X3, #0xe5ed, LSL #48
    MOVZ  X4, #0xd3e0, LSL #0
    MOVK  X4, #0xcbfa, LSL #16
    MOVK  X4, #0x4fe4, LSL #32
    MOVK  X4, #0x6cef, LSL #48
    MOVZ  X5, #0x8d01, LSL #0
    MOVK  X5, #0x5d3, LSL #16
    MOVK  X5, #0x3325, LSL #32
    MOVK  X5, #0xc21a, LSL #48
    MOVZ  X6, #0x859e, LSL #0
    MOVK  X6, #0x47fd, LSL #16
    MOVK  X6, #0x6c37, LSL #32
    MOVK  X6, #0xd146, LSL #48
    MOVZ  X7, #0xfb9c, LSL #0
    MOVK  X7, #0x1c4e, LSL #16
    MOVK  X7, #0x2be5, LSL #32
    MOVK  X7, #0x6e9d, LSL #48
    MOVZ  X8, #0xd5e4, LSL #0
    MOVK  X8, #0xf8e0, LSL #16
    MOVK  X8, #0x57f, LSL #32
    MOVK  X8, #0x5ec2, LSL #48
    MOVZ  X9, #0x2c22, LSL #0
    MOVK  X9, #0xb61f, LSL #16
    MOVK  X9, #0x66ff, LSL #32
    MOVK  X9, #0xd974, LSL #48
    MOVZ  X10, #0xc33, LSL #0
    MOVK  X10, #0xaa6, LSL #16
    MOVK  X10, #0x44e0, LSL #32
    MOVK  X10, #0xf465, LSL #48
    MOVZ  X11, #0x3dc4, LSL #0
    MOVK  X11, #0x4c04, LSL #16
    MOVK  X11, #0x79f8, LSL #32
    MOVK  X11, #0x973b, LSL #48
    MOVZ  X12, #0x7dd2, LSL #0
    MOVK  X12, #0x47f1, LSL #16
    MOVK  X12, #0xbfe1, LSL #32
    MOVK  X12, #0xfe36, LSL #48
    MOVZ  X13, #0xb71e, LSL #0
    MOVK  X13, #0xa209, LSL #16
    MOVK  X13, #0xddd5, LSL #32
    MOVK  X13, #0x2c16, LSL #48
    MOVZ  X14, #0xfc3c, LSL #0
    MOVK  X14, #0x9dad, LSL #16
    MOVK  X14, #0xe1cc, LSL #32
    MOVK  X14, #0xa0d6, LSL #48
    MOVZ  X15, #0x6427, LSL #0
    MOVK  X15, #0xe72c, LSL #16
    MOVK  X15, #0x27, LSL #32
    MOVK  X15, #0xdc33, LSL #48
    MOVZ  X16, #0x1799, LSL #0
    MOVK  X16, #0x944, LSL #16
    MOVK  X16, #0x6b9f, LSL #32
    MOVK  X16, #0x2172, LSL #48
    MOVZ  X17, #0x6e36, LSL #0
    MOVK  X17, #0xa329, LSL #16
    MOVK  X17, #0xe6a, LSL #32
    MOVK  X17, #0xfb8c, LSL #48
    MOVZ  X18, #0xf37d, LSL #0
    MOVK  X18, #0x46e3, LSL #16
    MOVK  X18, #0xed68, LSL #32
    MOVK  X18, #0x641d, LSL #48
    MOVZ  X19, #0xc48f, LSL #0
    MOVK  X19, #0x8306, LSL #16
    MOVK  X19, #0xfbba, LSL #32
    MOVK  X19, #0x75a0, LSL #48
    MOVZ  X20, #0x1955, LSL #0
    MOVK  X20, #0xbfd7, LSL #16
    MOVK  X20, #0xaaf8, LSL #32
    MOVK  X20, #0xcc82, LSL #48
    MOVZ  X21, #0x3405, LSL #0
    MOVK  X21, #0x74a0, LSL #16
    MOVK  X21, #0x7577, LSL #32
    MOVK  X21, #0x8a74, LSL #48
    MOVZ  X22, #0x1075, LSL #0
    MOVK  X22, #0xc6e5, LSL #16
    MOVK  X22, #0x18b8, LSL #32
    MOVK  X22, #0xf204, LSL #48
    MOVZ  X23, #0xc103, LSL #0
    MOVK  X23, #0x80c0, LSL #16
    MOVK  X23, #0x3845, LSL #32
    MOVK  X23, #0x70c8, LSL #48
    MOVZ  X27, #0x5ffa, LSL #0
    MOVK  X27, #0xd4ee, LSL #16
    MOVK  X27, #0x1b06, LSL #32
    MOVK  X27, #0x92f4, LSL #48
    FMOV  D0, X4
    FMOV  V0.D[1], X20
    FMOV  D1, X27
    FMOV  V1.D[1], X15
    FMOV  D2, X23
    FMOV  V2.D[1], X19
    FMOV  D3, X2
    FMOV  V3.D[1], X23
    FMOV  D4, X17
    FMOV  V4.D[1], X15
    FMOV  D5, X21
    FMOV  V5.D[1], X23
    FMOV  D6, X20
    FMOV  V6.D[1], X8
    FMOV  D7, X20
    FMOV  V7.D[1], X4
    FMOV  D8, X13
    FMOV  V8.D[1], X11
    FMOV  D9, X10
    FMOV  V9.D[1], X5
    FMOV  D10, X22
    FMOV  V10.D[1], X5
    FMOV  D11, X19
    FMOV  V11.D[1], X6
    FMOV  D12, X19
    FMOV  V12.D[1], X14
    FMOV  D13, X16
    FMOV  V13.D[1], X23
    FMOV  D14, X21
    FMOV  V14.D[1], X19
    FMOV  D15, X4
    FMOV  V15.D[1], X10
    FMOV  D16, X21
    FMOV  V16.D[1], X2
    FMOV  D17, X27
    FMOV  V17.D[1], X8
    FMOV  D18, X4
    FMOV  V18.D[1], X13
    FMOV  D19, X15
    FMOV  V19.D[1], X14
    FMOV  D20, X14
    FMOV  V20.D[1], X21
    FMOV  D21, X21
    FMOV  V21.D[1], X17
    FMOV  D22, X16
    FMOV  V22.D[1], X11
    FMOV  D23, X13
    FMOV  V23.D[1], X21
    FMOV  D24, X27
    FMOV  V24.D[1], X10
    FMOV  D25, X10
    FMOV  V25.D[1], X18
    FMOV  D26, X11
    FMOV  V26.D[1], X14
    FMOV  D27, X27
    FMOV  V27.D[1], X9
    FMOV  D28, X5
    FMOV  V28.D[1], X23
    FMOV  D29, X2
    FMOV  V29.D[1], X4
    FMOV  D30, X12
    FMOV  V30.D[1], X20
    FMOV  D31, X16
    FMOV  V31.D[1], X4
    MOVZ  X4, #0xa, LSL #0
EnhanceFloatP01_label_11:
    FMOV  H30, H24
    FCSEL  H7, H10, H24, GE
    FCSEL  D5, D27, D10, HI
    FMOV  H27, X7
    FMOV  W11, H20
    FMOV  D12, D19
    FMOV  H8, H27
    FDIV  D7, D13, D16
    FCSEL  H11, H28, H29, LS
    FNMSUB  S8, S12, S5, S31
    FSQRT  H23, H11
    FCSEL  D0, D8, D23, GE
    FNMSUB  D18, D29, D14, D7
    FMOV  S26, #-4.25000000
    FNMSUB  D12, D25, D4, D18
    FDIV  D29, D27, D30
    FCSEL  H25, H26, H10, VC
    FCSEL  H7, H12, H0, NV
    FDIV  S24, S7, S25
    FMADD  S8, S16, S13, S10
    FCSEL  S31, S14, S4, NE
    FMOV  D19, D18
    FCSEL  D26, D19, D16, NV
    FCSEL  S16, S29, S9, MI
    FSUB  H14, H24, H14
    FMOV  X17, H17
    FADD  H10, H5, H7
    FDIV  S18, S21, S7
    FMOV  D12, X2
    FNMADD  H27, H19, H8, H31
    FMOV  X13, D2
    FNMUL  H30, H22, H26
    FMOV  X6, H20
    FSQRT  H21, H16
    FNMADD  D19, D12, D12, D17
    FMOV  X20, D21
    FNMSUB  S7, S17, S21, S21
    FNMUL  H21, H31, H9
    FMOV  S2, W23
    FMOV  H13, W18
    FMOV  H4, W13
    FNEG  D20, D14
    FDIV  S16, S7, S19
    FMSUB  H8, H18, H21, H13
    FMOV  W23, S4
    FNMUL  S9, S16, S10
    FMOV  X18, D30
    FMUL  S12, S17, S2
    FMSUB  D15, D8, D21, D9
    FMOV  H21, H15
    FMOV  H0, H12
    FMOV  H22, W10
    FMOV  S15, S14
    FSUB  H9, H24, H20
    FMSUB  H24, H21, H22, H21
    FMSUB  D19, D24, D6, D15
    FNMSUB  H13, H26, H2, H9
    FMSUB  S24, S14, S0, S3
    FSQRT  D26, D13
    FMOV  D21, D20
    FMUL  H6, H24, H30
    FABS  D28, D6
    FMOV  H2, #-0.78125000
    FSUB  S4, S10, S21
    FMOV  H21, H26
    FMOV  X17, H12
    FMSUB  D26, D4, D21, D21
    FADD  S9, S11, S19
    FNEG  H22, H17
    FMOV  H20, H2
    FABS  S18, S10
    FNEG  H14, H22
    FMOV  W19, H9
    FMOV  W16, S26
    FMADD  H0, H24, H25, H14
    FSQRT  D16, D28
    FNEG  S30, S18
    FNMUL  D13, D25, D0
    FCSEL  H19, H13, H13, MI
    FMOV  X21, H14
    FMUL  S22, S30, S20
    FABS  H19, H13
    FMOV  D24, X16
    FSUB  H10, H19, H0
    FCSEL  D3, D22, D10, NE
    FSUB  D11, D31, D25
    FMADD  H30, H13, H3, H24
    FMOV  H25, W5
    FMSUB  S31, S16, S4, S25
    FMUL  H25, H11, H16
    FMOV  S0, S30
    FMOV  S16, S28
    FMOV  D10, D0
    FSQRT  D24, D2
    FNMUL  S30, S31, S10
    FNMADD  D4, D30, D25, D13
    FADD  H28, H16, H9
    FCSEL  S2, S4, S19, LT
    FNMADD  H31, H19, H17, H20
    FNMUL  H0, H30, H6
    SUBS  X4, X4, #0x1
    B.NE  EnhanceFloatP01_label_11
    MOVZ  X27, #0x8b45, LSL #0
    MOVK  X27, #0xa4c4, LSL #16
    MOVK  X27, #0xb167, LSL #32
    MOVK  X27, #0xd5aa, LSL #48
    SUB  X14, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x1534, LSL #0
    MOVK  X27, #0x5482, LSL #16
    MOVK  X27, #0xe325, LSL #32
    MOVK  X27, #0xe5ed, LSL #48
    SUB  X14, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x8d01, LSL #0
    MOVK  X27, #0x5d3, LSL #16
    MOVK  X27, #0x3325, LSL #32
    MOVK  X27, #0xc21a, LSL #48
    SUB  X14, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0xba40, LSL #0
    SUB  X14, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0xfb9c, LSL #0
    MOVK  X27, #0x1c4e, LSL #16
    MOVK  X27, #0x2be5, LSL #32
    MOVK  X27, #0x6e9d, LSL #48
    SUB  X14, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0xd5e4, LSL #0
    MOVK  X27, #0xf8e0, LSL #16
    MOVK  X27, #0x57f, LSL #32
    MOVK  X27, #0x5ec2, LSL #48
    SUB  X14, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x2c22, LSL #0
    MOVK  X27, #0xb61f, LSL #16
    MOVK  X27, #0x66ff, LSL #32
    MOVK  X27, #0xd974, LSL #48
    SUB  X14, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0xc33, LSL #0
    MOVK  X27, #0xaa6, LSL #16
    MOVK  X27, #0x44e0, LSL #32
    MOVK  X27, #0xf465, LSL #48
    SUB  X14, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0xba40, LSL #0
    SUB  X14, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x6427, LSL #0
    MOVK  X27, #0xe72c, LSL #16
    MOVK  X27, #0x27, LSL #32
    MOVK  X27, #0xdc33, LSL #48
    SUB  X14, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0xed80, LSL #0
    SUB  X14, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x8000, LSL #0
    SUB  X14, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0xbad0, LSL #0
    SUB  X14, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x7e00, LSL #0
    SUB  X14, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x5ffa, LSL #0
    SUB  X14, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x1075, LSL #0
    MOVK  X27, #0xc6e5, LSL #16
    MOVK  X27, #0x18b8, LSL #32
    MOVK  X27, #0xf204, LSL #48
    SUB  X14, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceFloatP01_TestFail
    MRS  X27, FPCR
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x6e2, LSL #16
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    MRS  X27, FPSR
    MOVZ  X14, #0x1f, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D0
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X14, #0x6427, LSL #0
    MOVK  X14, #0xe72c, LSL #16
    MOVK  X14, #0x27, LSL #32
    MOVK  X14, #0xdc33, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D1
    MOVZ  X14, #0x5ffa, LSL #0
    MOVK  X14, #0xd4ee, LSL #16
    MOVK  X14, #0x1b06, LSL #32
    MOVK  X14, #0x92f4, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D3
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D4
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D5
    MOVZ  X14, #0x7bff, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D6
    MOVZ  X14, #0x8000, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D7
    MOVZ  X14, #0xa67a, LSL #0
    MOVK  X14, #0x91ea, LSL #16
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D8
    MOVZ  X14, #0x2749, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D9
    MOVZ  X14, #0xbad0, LSL #0
    MOVK  X14, #0x1, LSL #16
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D10
    MOVZ  X14, #0xed80, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D11
    MOVZ  X14, #0x5ffa, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D12
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D13
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D14
    MOVZ  X14, #0x5ffa, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D15
    MOVZ  X14, #0xdffa, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D16
    MOVZ  X14, #0x8000, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X14, #0xd5e4, LSL #0
    MOVK  X14, #0xf8e0, LSL #16
    MOVK  X14, #0x57f, LSL #32
    MOVK  X14, #0x5ec2, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D17
    MOVZ  X14, #0x5ffa, LSL #0
    MOVK  X14, #0xd4ee, LSL #16
    MOVK  X14, #0x1b06, LSL #32
    MOVK  X14, #0x92f4, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D18
    MOVZ  X14, #0x7bff, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D20
    MOVZ  X14, #0xba40, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D21
    MOVZ  X14, #0xed81, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D22
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D23
    MOVZ  X14, #0x7e00, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D24
    MOVZ  X14, #0xe72e, LSL #0
    MOVK  X14, #0xae5f, LSL #16
    MOVK  X14, #0x4b70, LSL #32
    MOVK  X14, #0x1edb, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D25
    MOVZ  X14, #0x5fc6, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D26
    MOVZ  X14, #0xed80, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D27
    MOVZ  X14, #0x7bff, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D28
    MOVZ  X14, #0xbad0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D29
    MOVZ  X14, #0xdad7, LSL #0
    MOVK  X14, #0x3250, LSL #16
    MOVK  X14, #0x69f8, LSL #32
    MOVK  X14, #0x3ff1, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D30
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail
    FMOV  X27, D31
    MOVZ  X14, #0x3a40, LSL #0
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, EnhanceFloatP01_TestFail

EnhanceFloatP01_TestEnd:
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
EnhanceFloatP01_TestFail:
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
